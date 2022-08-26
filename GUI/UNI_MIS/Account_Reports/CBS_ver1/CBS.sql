if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[webxNet_CBS_Register]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[webxNet_CBS_Register]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[webxNet_CBS_Summary]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[webxNet_CBS_Summary]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



--exec webxNet_CBS_Register '01 May 07','31 May 07','BLR','All','Y','AFB0093','07_08' 

CREATE Proc webxNet_CBS_Register
@from_date varchar(200),
@to_date varchar(200), 
@loccode varchar(50), 
@RO varchar(50), 
@CUM varchar(20),
@ACCODE varchar(20),
@Fin_Year  varchar(20)
as
--declare @Fin_Year  varchar(20),@from_date varchar(200),@to_date varchar(200), @loccode varchar(20), @CUM varchar(20)

declare @finyrstart varchar(100) 
declare @toate_tr varchar(100)  
declare @WhereCri varchar(1000)  
declare @WhereCri_ACC varchar(1000)  
declare @SQL varchar(7000)  

select @WhereCri_ACC=''

	if @ACCODE <>'All'
	select @WhereCri_ACC=' and d.acccode=' + char(39) + @ACCODE + char(39)  

	if @RO='All' and @loccode='All'  
	select @WhereCri = ''  
	else if @RO<>'All' and @loccode='All'  
	select @WhereCri = ' and report_loc=' + char(39) + @RO + char(39) +' or loccode=' + char(39) + @RO + char(39) 
	else if @RO='All' and @loccode<>'All'  
	select @WhereCri = ' and loccode= '+ char(39) + @loccode + char(39)  
	else if @RO<>'All' and @loccode<>'All'  
	select @WhereCri = '  and loccode= '+ char(39) + @loccode + char(39)  


--select @from_date ='02 Apr 08'
--select @to_date='03 July 08'
--select @Fin_Year='08_09'   
--select @loccode='HQTR'
--select @CUM='Y'   
 
select @finyrstart='01 Apr '+left(@Fin_Year,2)     
select  @toate_tr=convert(varchar,convert(datetime,@from_date,106)-1,106)  

IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id = object_id(N'[tempdb]..[#CBS_REG]'))              
Drop table #CBS_REG          
--temp table to hold list of missing              
create table #CBS_REG ([SRNO] [numeric](18, 0) IDENTITY (1, 1) NOT NULL,Heading Varchar(50), Voucherno Varchar(50), DOCNO Varchar(50) , V_Date datetime,Party Varchar(150),BANK_NAME Varchar(150),
Location Varchar(150),Particulars  Varchar(150),Narration Varchar(300),CHQNO Varchar(200),CHQDT datetime,
acccode Varchar(150),brcd Varchar(150) ,BANK_Debit numeric(12,2),          
BANK_Credit numeric(12,2) ,CASH_Debit numeric(12,2),CASH_Credit numeric(12,2) ,TYP Varchar(150)           
--,NotMissing int               
)           
 

declare @B_D_OPNTR numeric(12,2),@B_C_OPNTR numeric(12,2), @C_D_OPNTR numeric(12,2), @C_C_OPNTR numeric(12,2)     
declare @B_D_OPN numeric(12,2),@B_C_OPN numeric(12,2), @C_D_OPN numeric(12,2), @C_C_OPN numeric(12,2)   


select @SQL='insert into #CBS_REG (BANK_Debit,BANK_Credit,CASH_Debit,CASH_Credit,TYP) select 
isnull(sum(case when acccategory='+char(39)+'BANK'+char(39)+' then debit else 0 end),0),
isnull(sum(case when acccategory='+char(39)+'BANK'+char(39)+' then credit else 0 end),0),
isnull(sum(case when acccategory='+char(39)+'CASH'+char(39)+' then debit else 0 end),0),
isnull(sum(case when acccategory='+char(39)+'CASH'+char(39)+' then credit else 0 end),0),'+char(39)+'OPN_TR'+char(39)+'
from webx_acctrans_'+@Fin_Year+' M with(NOLOCK)
inner join webx_acctinfo D  with(NOLOCK) on m.acccode=d.acccode
inner join webx_location l on m.brcd=l.loccode
where 1=1 '+@WhereCri+@WhereCri_ACC+' and 
( acccategory='+char(39)+'CASH'+char(39)+' OR  acccategory='+char(39)+'BANK'+char(39)+')
 and Voucher_cancel='+char(39)+'N'+char(39)+'  
And convert(varchar,transdate,106)  between convert(datetime,'+char(39)+@finyrstart+char(39)+',106)  and   convert(datetime,'+char(39)+@toate_tr+char(39)+',106)  '
exec(@SQL)

select @SQL='insert into #CBS_REG (BANK_Debit,BANK_Credit,CASH_Debit,CASH_Credit,TYP) 
 select isnull(sum(case when acccategory='+char(39)+'BANK'+char(39)+' then isnull(o.opendebit_i,0) else 0 end),0),
isnull(sum(case when acccategory='+char(39)+'BANK'+char(39)+' then isnull(o.opencredit_i,0) else 0 end),0),
isnull(sum(case when acccategory='+char(39)+'CASH'+char(39)+' then isnull(o.opendebit_i,0) else 0 end),0),
isnull(sum(case when acccategory='+char(39)+'CASH'+char(39)+' then isnull(o.opencredit_i,0) else 0 end) ,0),'+char(39)+'OPN'+char(39)+'
from webx_acctinfo D with(NOLOCK) 
inner join  webx_acctopening_'+@Fin_Year+' o with(NOLOCK) on D.acccode=o.acccode 
inner join webx_location l on o.brcd=l.loccode
where 1=1 '+@WhereCri+@WhereCri_ACC+' and
( acccategory='+char(39)+'CASH'+char(39)+' OR  acccategory='+char(39)+'BANK'+char(39)+') '
exec(@SQL)

select @B_D_OPNTR=sum(isnull(BANK_Debit,0)),@B_C_OPNTR=sum(isnull(BANK_Credit,0)), 
@C_D_OPNTR=sum(isnull(CASH_Debit,0)) , @C_C_OPNTR=sum(isnull(CASH_Credit,0))  from #CBS_REG where typ='OPN_TR'

select @B_D_OPN=sum(isnull(BANK_Debit,0)),@B_C_OPN=sum(isnull(BANK_Credit,0)), 
@C_D_OPN=sum(isnull(CASH_Debit,0)) , @C_C_OPN=sum(isnull(CASH_Credit,0))  from #CBS_REG where typ='OPN'

delete from #CBS_REG

declare @BD_OPN numeric(12,2),@BC_OPN numeric(12,2), @CD_OPN numeric(12,2), @CC_OPN numeric(12,2) 

--select isnull(@C_D_OPNTR,0),isnull(@C_D_OPN,0),isnull(@C_C_OPNTR,0),isnull(@C_C_OPN,0)

if isnull(@B_D_OPNTR,0)+isnull(@B_D_OPN,0)>isnull(@B_C_OPNTR,0)+isnull(@B_C_OPN,0)
	begin
	select @BD_OPN=isnull(@B_D_OPNTR,0)+isnull(@B_D_OPN,0)-isnull(@B_C_OPNTR,0)+isnull(@B_C_OPN,0)
	select @BC_OPN=0
	end
else 
	begin
	select @BD_OPN=0
	select @BC_OPN=isnull(@B_C_OPNTR,0)+isnull(@B_C_OPN,0)-isnull(@B_D_OPNTR,0)+isnull(@B_D_OPN,0)
	end

if isnull(@C_D_OPNTR,0)+isnull(@C_D_OPN,0)>isnull(@C_C_OPNTR,0)+isnull(@C_C_OPN,0)
	begin
	select @CD_OPN=isnull(@C_D_OPNTR,0)+isnull(@C_D_OPN,0)-isnull(@C_C_OPNTR,0)+isnull(@C_C_OPN,0)
	select @CC_OPN=0
	end
else 
	begin
	select @CD_OPN=0
	select @CC_OPN=isnull(@C_C_OPNTR,0)+isnull(@C_C_OPN,0)-isnull(@C_D_OPNTR,0)+isnull(@C_D_OPN,0)
	end
--select @BD_OPN,@BC_OPN,@CD_OPN,@CC_OPN

--select 'OPN','', @B_D_OPNTR+@B_D_OPN,@B_C_OPNTR+@B_C_OPN,@C_D_OPNTR+@C_D_OPN,@C_c_OPNTR+@C_c_OPN,'OPN'
insert into #CBS_REG(Heading,BANK_Debit,BANK_Credit,CASH_Debit,CASH_Credit,TYP)
select 'Opening Balance B/F',isnull(@BD_OPN,0),isnull(@BC_OPN,0),isnull(@CD_OPN,0),isnull(@CC_OPN,0),'OPN'



select @SQL='insert into #CBS_REG(acccode,Location,Voucherno,docno,V_Date,Party ,Particulars,Narration,BANK_NAME,CHQNO,CHQDT,BANK_Debit,BANK_Credit,CASH_Debit,CASH_Credit,TYP)  
select  d.acccode,t.brcd,Voucherno=(case when t.transtype='+char(39)+'Journal'+char(39)+' then '+char(39)+'JV :'+char(39)+' + '+char(39)+' '+char(39)+' +  t.voucherno   
when t.transtype='+char(39)+'CASH RECIEPT'+char(39)+' then '+char(39)+'CSH - R :'+char(39)+' + '+char(39)+' '+char(39)+' +  t.voucherno   
when t.transtype='+char(39)+'Cash Payment'+char(39)+' then '+char(39)+'CSH - P :'+char(39)+' + '+char(39)+' '+char(39)+' +  t.voucherno   
when t.transtype='+char(39)+'Bank Payment'+char(39)+' then '+char(39)+'BK - P :'+char(39)+' + '+char(39)+' '+char(39)+' +  t.voucherno   
when t.transtype='+char(39)+'Bank Receipt'+char(39)+' then '+char(39)+'BK - R :'+char(39)+' + '+char(39)+' '+char(39)+' +  t.voucherno   
when t.transtype='+char(39)+'Credit Note'+char(39)+' then '+char(39)+'CN :'+char(39)+' + '+char(39)+' '+char(39)+' +  t.voucherno   
when t.transtype='+char(39)+'Debit note'+char(39)+' then '+char(39)+'DN :'+char(39)+' + '+char(39)+' '+char(39)+' +  t.voucherno   
when t.transtype='+char(39)+'Contra'+char(39)+' then '+char(39)+'CON :'+char(39)+' + '+char(39)+' '+char(39)+' +  t.voucherno   
when t.transtype='+char(39)+'Income'+char(39)+' then '+char(39)+'INC :'+char(39)+' + '+char(39)+' '+char(39)+' +  t.voucherno   
when t.transtype='+char(39)+'Expenses'+char(39)+' then '+char(39)+'EXP :'+char(39)+' + '+char(39)+' '+char(39)+' +  t.voucherno   
when t.transtype='+char(39)+'Sale'+char(39)+' then '+char(39)+'SA :'+char(39)+' + '+char(39)+' '+char(39)+' +  t.voucherno   
when t.transtype='+char(39)+'Purchase'+char(39)+' then '+char(39)+'PUR :'+char(39)+' + '+char(39)+' '+char(39)+' +  t.voucherno   
else t.voucherno End),docno,transdate,isnull(pbov_code,'+char(39)+''+char(39)+')+'+char(39)+' : '+char(39)+'+isnull(pbov_name,'+char(39)+''+char(39)+')
 ,oppacccode=(select top 1 isnull(company_acccode,acccode)+'+char(39)+' : '+char(39)+'+accdesc from webx_acctinfo where acccode=t.oppacccode),Narration,
accdesc,chqno,chqdate,
Bank_Debit=(case when acccategory='+char(39)+'BANK'+char(39)+' then debit else 0 end) ,
Bank_Credit=(case when acccategory='+char(39)+'BANK'+char(39)+' then credit else 0 end),
CASH_Debit=(case when acccategory='+char(39)+'CASH'+char(39)+' then debit else 0 end) ,
CASH_Credit=(case when acccategory='+char(39)+'CASH'+char(39)+' then credit else 0 end) ,'+char(39)+'TR'+char(39)+'
--,Bank_name=(select top 1 accdesc from webx_acctinfo where acccode=m.acccode) 
from webx_acctrans_'+@Fin_Year+' t  with(NOLOCK) 
inner join webx_acctinfo D  with(NOLOCK) on t.acccode=d.acccode 
inner join webx_location l on t.brcd=l.loccode
where  1=1 '+@WhereCri+@WhereCri_ACC+' and 
( acccategory='+char(39)+'CASH'+char(39)+' OR  acccategory='+char(39)+'BANK'+char(39)+')
 and Voucher_cancel='+char(39)+'N'+char(39)+'  
 And convert(varchar,transdate,106) between convert(datetime,'+char(39)+@from_date+char(39)+',106) and Convert(datetime,'+char(39)+@to_date+char(39)+',106) 
order by transdate,voucherno'
exec(@SQL)
--select top 1 * from webx_acctrans_08_09
 
declare @BD_TR numeric(12,2),@BC_TR numeric(12,2), @CD_TR numeric(12,2), @CC_TR numeric(12,2)  

select @SQL='insert into #CBS_REG (BANK_Debit,BANK_Credit,CASH_Debit,CASH_Credit,TYP)  select 
isnull(sum(case when acccategory='+char(39)+'BANK'+char(39)+' then debit else 0 end),0),
isnull(sum(case when acccategory='+char(39)+'BANK'+char(39)+' then credit else 0 end),0),
isnull(sum(case when acccategory='+char(39)+'CASH'+char(39)+' then debit else 0 end),0),
isnull(sum(case when acccategory='+char(39)+'CASH'+char(39)+' then credit else 0 end),0),'+char(39)+'TOT_TR'+char(39)+'
--,Bank_name=(select top 1 accdesc from webx_acctinfo where acccode=m.acccode) 
from webx_acctrans_'+@Fin_Year+' M  with(NOLOCK) 
inner join webx_acctinfo D  with(NOLOCK) on m.acccode=d.acccode 
inner join webx_location l on m.brcd=l.loccode
where 1=1 '+@WhereCri+@WhereCri_ACC+' and 
( acccategory='+char(39)+'CASH'+char(39)+' OR  acccategory='+char(39)+'BANK'+char(39)+')
 and Voucher_cancel='+char(39)+'N'+char(39)+'  
 And convert(varchar,transdate,106) between convert(datetime,'+char(39)+@from_date+char(39)+',106) and Convert(datetime,'+char(39)+@to_date+char(39)+',106) '
exec(@SQL)
--group by d.acccode--,m.brcd

--insert into #CBS_REG(acccode,Location,BANK_Debit,BANK_Credit,CASH_Debit,CASH_Credit,TYP)
--select 'TOT','',@BD_TR,@BC_TR,@CD_TR,@CC_TR,'TOT_TR'

select @BD_TR=sum(isnull(BANK_Debit,0)),@BC_TR=sum(isnull(BANK_Credit,0)), 
@CD_TR=sum(isnull(CASH_Debit,0)) , @CC_TR=sum(isnull(CASH_Credit,0))  from #CBS_REG where typ='TOT_TR'
--select 'TOT','',@BD_TR,@BC_TR,@CD_TR,@CC_TR,'TOT_TR'
delete from #CBS_REG where typ='TOT_TR'

if @BD_TR>@BC_TR
	begin
	select @BD_TR=@BD_TR-@BC_TR
	select @BC_TR=0
	end 
else 
	begin
	select @BD_TR=0
	select @BC_TR=@BC_TR-@BD_TR
	end 

if @CD_TR>@CC_TR
	begin
	select @CD_TR=@CD_TR-@CC_TR
	select @CC_TR=0
	end 
else 
	begin
	select @CD_TR=0
	select @CC_TR=@CC_TR-@CD_TR
	end 

--select @BD_TR,@BC_TR,@CD_TR,@CC_TR,@BD_OPN,@BC_OPN,@CD_OPN,@CC_OPN
insert into #CBS_REG(Heading,BANK_Debit,BANK_Credit,CASH_Debit,CASH_Credit,TYP)
select 'Total Transaction',@BD_TR,@BC_TR,@CD_TR,@CC_TR,'TOT_TR'

declare @B_D_Close numeric(12,2),@B_C_Close numeric(12,2), @C_D_Close numeric(12,2), @C_C_Close numeric(12,2)   

--select @BD_TR+@BD_OPN,@BC_TR+@BC_OPN
if @BD_TR+@BD_OPN>@BC_TR+@BC_OPN
	begin
	select @B_D_Close=(@BD_TR+@BD_OPN)-(@BC_TR+@BC_OPN)
	select @B_C_Close=0
	end 
else 
	begin
	select @B_C_Close=(@BC_TR+@BC_OPN)-(@BD_TR+@BD_OPN)
	select @B_D_Close=0
	end 
--select @CD_TR+@CD_OPN,@CC_TR+@CC_OPN
if @CD_TR+@CD_OPN>@CC_TR+@CC_OPN
	begin
	select @C_D_Close=(@CD_TR+@CD_OPN)-(@CC_TR+@CC_OPN)
	select @C_C_Close=0
	end 
else 
	begin
	select @C_C_Close=(@CC_TR+@CC_OPN)-(@CD_TR+@CD_OPN)
	select @C_D_Close=0
	end 
--select @C_C_Close,@C_D_Close,@B_D_Close,@B_C_Close
	
insert into #CBS_REG(Heading,BANK_Debit,BANK_Credit,CASH_Debit,CASH_Credit,TYP)
select 'Closing Balance C/F',@B_D_Close,@B_C_Close,@C_D_Close,@C_C_Close,'Close'

select SRNO,Heading=isnull(Heading,''),acccode=isnull(acccode,''),Location=isnull(Location,''),Voucherno=isnull(Voucherno,''),docno=isnull(docno,''),
V_Date=convert(varchar,V_Date,6),Party=isnull(Party,'') ,Particulars=isnull(Particulars,''),Narration=isnull(Narration,''),BANK_NAME=isnull(BANK_NAME,''),
CHQNO=isnull(CHQNO,''),CHQDT=convert(varchar,CHQDT,6),TYP=isnull(TYP,''),
BANK_Debit=(case when TYP='TR' then (case when   BANK_Debit>BANK_Credit then BANK_Debit-BANK_Credit else 0 end ) else BANK_Debit end),
BANK_Credit=(case when TYP='TR' then (case when  BANK_Credit>BANK_Debit then BANK_Credit-BANK_Debit else 0 end) else BANK_Credit end),
CASH_Debit=(case when TYP='TR' then (case when CASH_Debit>CASH_Credit then CASH_Debit-CASH_Credit else 0 end) else CASH_Debit end),
CASH_Credit=(case when TYP='TR' then (case when  CASH_Credit>CASH_Debit then CASH_Credit-CASH_Debit else 0 end) else CASH_Credit end) from #CBS_REG
order by SRNO

IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id = object_id(N'[tempdb]..[#CBS_REG]'))              
Drop table #CBS_REG  







GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



--exec webxNet_CBS_Summary '01 Apr 08','22 Aug 08','AKV','All','Y','All','08_09' 
	

CREATE Proc webxNet_CBS_Summary
@from_date varchar(200),
@to_date varchar(200), 
@loccode varchar(50), 
@RO varchar(50), 
@CUM varchar(20),
@ACCODE varchar(20),
@Fin_Year  varchar(20)
as
--declare @Fin_Year  varchar(20),@from_date varchar(200),@to_date varchar(200), @loccode varchar(20), @CUM varchar(20)

declare @finyrstart varchar(100) 
declare @toate_tr varchar(100)  
declare @WhereCri varchar(1000)  
declare @WhereCri_ACC varchar(1000)  
declare @SQL varchar(7000)  
	select @WhereCri_ACC=''

	if @ACCODE <>'All'
	select @WhereCri_ACC=' and M.acccode=' + char(39) + @ACCODE + char(39)  

	if @RO='All' and @loccode='All'  
	select @WhereCri = ''  
	else if @RO<>'All' and @loccode='All'  
	select @WhereCri = ' and (report_loc=' + char(39) + @RO + char(39) +' or loccode=' + char(39) + @RO + char(39) +')'
	else if @RO='All' and @loccode<>'All'  
	select @WhereCri = ' and loccode= '+ char(39) + @loccode + char(39)  
	else if @RO<>'All' and @loccode<>'All'  
	select @WhereCri = '  and loccode= '+ char(39) + @loccode + char(39)  

--select @WhereCri

--select @from_date ='02 Apr 08'
--select @to_date='03 July 08'
--select @Fin_Year='08_09'   
--select @loccode='HQTR'
--select @CUM='Y'   

declare @SELCT varchar(2000),@SELCT_1 varchar(2000);

select @SELCT='BANK_OPNDEBIT=sum(case when acccategory='+char(39)+'BANK'+char(39)+' then isnull(debit,0) else 0 end),
BANK_OPNCredit=sum(case when acccategory='+char(39)+'BANK'+char(39)+' then isnull(credit,0) else 0 end),
CASH_OPNDEBIT=sum(case when acccategory='+char(39)+'CASH'+char(39)+' then isnull(debit,0) else 0 end),
CASH_OPNCredit=sum(case when acccategory='+char(39)+'CASH'+char(39)+' then isnull(credit,0) else 0 end) '

select @SELCT_1='BANK_OPNDEBIT=sum(case when acccategory='+char(39)+'BANK'+char(39)+' then isnull(M.opendebit_i,0) else 0 end),
BANK_OPNCredit=sum(case when acccategory='+char(39)+'BANK'+char(39)+' then isnull(M.opencredit_i,0) else 0 end),
CASH_OPNDEBIT=sum(case when acccategory='+char(39)+'CASH'+char(39)+' then isnull(M.opendebit_i,0) else 0 end),
CASH_OPNCredit=sum(case when acccategory='+char(39)+'CASH'+char(39)+' then isnull(M.opencredit_i,0) else 0 end) '
 
select @finyrstart='01 Apr '+left(@Fin_Year,2)     
select  @toate_tr=convert(varchar,convert(datetime,@from_date,106)-1,106)  

IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id = object_id(N'[tempdb]..[#CBS]'))              
Drop table #CBS          
--temp table to hold list of missing              
create table #CBS (              
acccode Varchar(150),brcd Varchar(150) ,BANK_Debit numeric(12,2),          
BANK_Credit numeric(12,2) ,CASH_Debit numeric(12,2),CASH_Credit numeric(12,2) ,TYP Varchar(150)           
--,NotMissing int               
)           
        

declare @B_D_OPNTR numeric(12,2),@B_C_OPNTR numeric(12,2), @C_D_OPNTR numeric(12,2), @C_c_OPNTR numeric(12,2)     
declare @B_D_OPN numeric(12,2),@B_C_OPN numeric(12,2), @C_D_OPN numeric(12,2), @C_c_OPN numeric(12,2)   
--declare @BD_OPN numeric(12,2),@BC_OPN numeric(12,2), @CD_OPN numeric(12,2), @CD_OPN numeric(12,2)  

select @SQL='insert into #CBS select m.acccode,m.brcd,
'+@SELCT+','+char(39)+'OPN_TR'+char(39)+'
from webx_acctrans_'+@Fin_Year+' M with(NOLOCK)
inner join webx_acctinfo D  with(NOLOCK) on m.acccode=d.acccode
inner join webx_location l on m.brcd=l.loccode
where 1=1  '+@WhereCri+@WhereCri_ACC+' 
and   ( acccategory='+char(39)+'CASH'+char(39)+' OR  acccategory='+char(39)+'BANK'+char(39)+')
 and Voucher_cancel='+char(39)+'N'+char(39)+' And 
convert(varchar,transdate,106) between convert(datetime,'+char(39)+@finyrstart+char(39)+',106)  and   convert(datetime,'+char(39)+@toate_tr+char(39)+',106) 
group by m.acccode,m.brcd '
exec(@SQL)

select @SQL='insert into #CBS select d.acccode,m.brcd,
'+@SELCT_1+' ,'+char(39)+'OPN'+char(39)+'
from webx_acctinfo D with(NOLOCK) 
inner join  webx_acctopening_'+@Fin_Year+' M with(NOLOCK) on D.acccode=m.acccode
inner join webx_location l on M.brcd=l.loccode
where 1=1  '+@WhereCri+@WhereCri_ACC+'  
 and  ( acccategory='+char(39)+'CASH'+char(39)+' OR  acccategory='+char(39)+'BANK'+char(39)+') 
 group by d.acccode,m.brcd '
exec(@SQL)
--select * from #CBS

select @SQL='insert into #CBS  select d.acccode,m.brcd,
'+@SELCT+' ,'+char(39)+'TR'+char(39)+'
--,Bank_name=(select top 1 accdesc from webx_acctinfo where acccode=m.acccode) 
from webx_acctrans_'+@Fin_Year+' M  with(NOLOCK) 
inner join webx_acctinfo D  with(NOLOCK) on m.acccode=d.acccode 
inner join webx_location l on m.brcd=l.loccode
where 1=1  '+@WhereCri+@WhereCri_ACC+' 
and  Voucher_cancel='+char(39)+'N'+char(39)+' and (M.debit<>m.credit)  
and ( acccategory='+char(39)+'CASH'+char(39)+' OR  acccategory='+char(39)+'BANK'+char(39)+')
 And convert(varchar,transdate,106) between convert(datetime,'+char(39)+@from_date+char(39)+',106) and Convert(datetime,'+char(39)+@to_date+char(39)+',106) 
group by d.acccode,m.brcd'
exec(@SQL)

select report_loc,report_loc_nm=(select top 1 loccode+' : '+locname from webx_location where loccode=l.report_loc),loccode,locname
,BANK_OPNDEBIT=sum(case when (TYP='OPN_TR' or TYP='OPN') then isnull(BANK_Debit,0) else 0 end ) 
,BANK_OPNCredit=sum(case when (TYP='OPN_TR' or TYP='OPN') then isnull(BANK_Credit,0) else 0 end ) 
,CASH_OPNDEBIT=sum(case when (TYP='OPN_TR' or TYP='OPN') then isnull(CASH_Debit,0) else 0 end ) 
,CASH_OPNCredit=sum(case when (TYP='OPN_TR' or TYP='OPN') then isnull(CASH_Credit,0) else 0 end ) 
,BANK_TRDEBIT=sum(case when (TYP='TR' ) then isnull(BANK_Debit,0) else 0 end ) 
,BANK_TRCredit=sum(case when (TYP='TR' ) then isnull(BANK_Credit,0) else 0 end ) 
,CASH_TRDEBIT=sum(case when (TYP='TR' ) then isnull(CASH_Debit,0) else 0 end ) 
,CASH_TRCredit=sum(case when (TYP='TR' ) then isnull(CASH_Credit,0) else 0 end ) 
--,BANK_CloseDebit=(case when sum(case when (TYP='OPN_TR' or TYP='OPN') then isnull(BANK_Debit,0) else 0 end )>sum(case when (TYP='OPN_TR' or TYP='OPN') then isnull(BANK_Credit,0) else 0 end )  then sum(case when (TYP='OPN_TR' or TYP='OPN') then isnull(BANK_Debit,0) else 0 end )-sum(case when (TYP='OPN_TR' or TYP='OPN') then isnull(BANK_Credit,0) else 0 end ) else 0 end )
--+(case when sum(case when (TYP='TR') then isnull(BANK_Debit,0) else 0 end )>sum(case when (TYP='TR') then isnull(BANK_Credit,0) else 0 end ) then sum(case when (TYP='TR') then isnull(BANK_Debit,0) else 0 end )-sum(case when (TYP='TR') then isnull(BANK_Credit,0) else 0 end ) else 0 end )
--,BANK_CloseCredit=(case when sum(case when (TYP='OPN_TR' or TYP='OPN') then isnull(BANK_Credit,0) else 0 end )>sum(case when (TYP='OPN_TR' or TYP='OPN') then isnull(BANK_Debit,0) else 0 end )  then sum(case when (TYP='OPN_TR' or TYP='OPN') then isnull(BANK_Credit,0) else 0 end )-sum(case when (TYP='OPN_TR' or TYP='OPN') then isnull(BANK_Debit,0) else 0 end ) else 0 end )
--+(case when sum(case when (TYP='TR') then isnull(BANK_Credit,0) else 0 end )>sum(case when (TYP='TR') then isnull(BANK_Debit,0) else 0 end ) then sum(case when (TYP='TR') then isnull(BANK_Credit,0) else 0 end )-sum(case when (TYP='TR') then isnull(BANK_Debit,0) else 0 end ) else 0 end )
--,CASH_CloseDebit=(case when sum(case when (TYP='OPN_TR' or TYP='OPN') then isnull(CASH_Debit,0) else 0 end )>sum(case when (TYP='OPN_TR' or TYP='OPN') then isnull(CASH_Credit,0) else 0 end )  then sum(case when (TYP='OPN_TR' or TYP='OPN') then isnull(CASH_Debit,0) else 0 end )-sum(case when (TYP='OPN_TR' or TYP='OPN') then isnull(CASH_Credit,0) else 0 end ) else 0 end )
--+(case when sum(case when (TYP='TR') then isnull(CASH_Debit,0) else 0 end )>sum(case when (TYP='TR') then isnull(CASH_Credit,0) else 0 end ) then sum(case when (TYP='TR') then isnull(CASH_Debit,0) else 0 end )-sum(case when (TYP='TR') then isnull(CASH_Credit,0) else 0 end ) else 0 end )
--,CASH_CloseCredit=(case when sum(case when (TYP='OPN_TR' or TYP='OPN') then isnull(CASH_Credit,0) else 0 end )>sum(case when (TYP='OPN_TR' or TYP='OPN') then isnull(CASH_Debit,0) else 0 end )  then sum(case when (TYP='OPN_TR' or TYP='OPN') then isnull(CASH_Credit,0) else 0 end )-sum(case when (TYP='OPN_TR' or TYP='OPN') then isnull(CASH_Debit,0) else 0 end ) else 0 end )
--+(case when sum(case when (TYP='TR') then isnull(CASH_Credit,0) else 0 end )>sum(case when (TYP='TR') then isnull(CASH_Debit,0) else 0 end ) then sum(case when (TYP='TR') then isnull(CASH_Credit,0) else 0 end )-sum(case when (TYP='TR') then isnull(CASH_Debit,0) else 0 end ) else 0 end )

from #CBS a
inner join webx_location l on a.brcd=l.loccode
--where report_loc like @RO and loccode like @loccode
group by report_loc,loccode,locname
order by report_loc,loccode,locname
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id = object_id(N'[tempdb]..[#CBS]'))              
Drop table #CBS



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

