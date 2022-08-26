--alter table webx_chq_det add chq_b_r varchar(250)



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VWnet_CHQ_Register]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VWnet_CHQ_Register]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

 CREATE View VWnet_CHQ_Register  
as  
select  chqno,chqdt=convert(varchar,chqdt,6),entrydt=convert(varchar,entrydt,6),chqamt,  
BANK=isnull(acccode,'')+' : '+(select top 1 accdesc from webx_acctinfo where acccode=c.acccode),chq_b_r=isnull(chq_b_r,'R'),  
Party=isnull(ptmsptcd,'')+' : '+isnull(ptmsptnm,''),brcd,voucherno,acccode,ptmsptcd,adjustamt=cast(isnull(adjustamt,0) as decimal(9,2)),  
NotUsedAmt=cast((case when (isnull(chqamt,0)-isnull(adjustamt,0)) >0 then (isnull(chqamt,0)-isnull(adjustamt,0)) else 0 end) as decimal(9,2)),DepoFlag,OwnCust  
,transdate=convert(varchar,transdate,6),Reconciled=isnull(chq_clear,'N') ,report_loc,loccode  
from webx_chq_det c with(NOLOCK)  
inner join webx_location  l on l.loccode=c.brcd  


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WebxNet_CHQ_Register]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WebxNet_CHQ_Register]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

--exec WebxNet_CHQ_Register '27 Jul 08','31 Jul 08','All','All','1','','All','All','All','1111','22222','1',''

--exec WebxNet_CHQ_Register '01 July 08','31 July 08','All','All','1','','All','All','All','0','0','1',''
CREATE Proc WebxNet_CHQ_Register
@fromdt varchar(200),
@todt varchar(200),
@RO varchar(200),
@ORGNCD varchar(200),
@DTTYP varchar(20),
@BankList varchar(2000),
@CHQ_CLST varchar(200),
@CHQDEPO varchar(200),
@CHQ_ACC varchar(200),
@CHQ_AMTFRM varchar(200),
@CHQ_AMTTO varchar(200),
@RPTTYP varchar(20),
@CHANO_LIST varchar(2000)
as 


Declare @SQL Varchar(8000),@WhereCri_DT varchar(400),@DT_TYPE varchar(100),@Where_Bank varchar(2000),@Where_CHQ varchar(2000);
Declare @WhereCri varchar(2000),@WhereCri_CHQ_CLST varchar(2000),@WhereCri_DEPO varchar(2000),@WhereCri_ACC varchar(2000);
Declare @WhereCri_AMt varchar(2000);

select @WhereCri_DT='',@Where_Bank='',@Where_CHQ='',@WhereCri='',@WhereCri_CHQ_CLST='',@WhereCri_DEPO='',@WhereCri_ACC='',@WhereCri_AMt=''

	if @DTTYP='1'
		select @DT_TYPE='chqdt'
	else if @DTTYP='2'
		select @DT_TYPE='entrydt'

	select @WhereCri_DT=' and Convert(varchar,'+@DT_TYPE+',106) between Convert(datetime,'+char(39)+@fromdt+char(39)+',106) and Convert(datetime,'+char(39)+@TODT+char(39)+',106)  and '+@DT_TYPE+' is not null'

	if @RO='All' and @ORGNCD='All'  
	select @WhereCri = ''  
	else if @RO<>'All' and @ORGNCD='All'  
	select @WhereCri = ' and report_loc=' + char(39) + @RO + char(39)  
	else if @RO='All' and @ORGNCD<>'All'  
	select @WhereCri = ' and loccode= '+ char(39) + @ORGNCD + char(39)  
	else if @RO<>'All' and @ORGNCD<>'All'  
	select @WhereCri = '  and loccode= '+ char(39) + @ORGNCD + char(39)  

	
	if @BankList<>''
		select @Where_Bank=' and [dbo].[SplitWithSearch]('+char(39)+@BankList+char(39)+','+char(39)+','+char(39)+',acccode)='+char(39)+'1'+char(39)+''
	

	if @CHQ_CLST <>'All'
		select @WhereCri_CHQ_CLST='  and Reconciled= '+ char(39) + @CHQ_CLST + char(39)

	if @CHQDEPO <>'All' and @CHQDEPO <>'B'
		select @WhereCri_DEPO='  and DepoFlag= '+ char(39) + @CHQDEPO + char(39) +' and chq_b_r<> '+ char(39) + 'B' + char(39) 
	else if @CHQDEPO ='B'  
		select @WhereCri_DEPO='  and chq_b_r='+ char(39) + @CHQDEPO + char(39)
	else 
		select @WhereCri_DEPO='  and chq_b_r<>'+ char(39) + 'B' + char(39)

	if @CHQ_ACC='1'
		select @WhereCri_ACC=' and ( isnull(NotUsedAmt,0)<=0)'
	else if @CHQ_ACC='2'
		select @WhereCri_ACC=' and ( isnull(NotUsedAmt,0)>0)'

--select @SQL,@WhereCri_DT,@Where_CHQ,@Where_Bank,@WhereCri,@WhereCri_CHQ_CLST,@WhereCri_DEPO,@WhereCri_ACC,@WhereCri_AMt

	if @CHQ_AMTTO>0
		select  @WhereCri_AMt =' and isnull(chqamt,0)>='+@CHQ_AMTFRM+' and   isnull(chqamt,0)<='+@CHQ_AMTTO+''

--select @WhereCri_AMt
if @CHANO_LIST<>''
	begin
	select @WhereCri_DT='',@Where_Bank='',@WhereCri='',@WhereCri_CHQ_CLST='',@WhereCri_DEPO='',@WhereCri_ACC='',@WhereCri_AMt=''
	select @Where_CHQ=' and [dbo].[SplitWithSearch]('+char(39)+@CHANO_LIST+char(39)+','+char(39)+','+char(39)+',chqno)='+char(39)+'1'+char(39)+''
	end

if @RPTTYP='1'
	begin
	select @SQL='select chqno,chqdt,entrydt,chqamt,BANK,Party,brcd,voucherno,acccode,ptmsptcd,adjustamt,NotUsedAmt,DepoFlag,OwnCust,transdate,Reconciled
		from VWnet_CHQ_Register where OwnCust='+ char(39) + 'O' + char(39)+''+@WhereCri_DT+@WhereCri+@Where_CHQ+@Where_Bank+@WhereCri_CHQ_CLST+@WhereCri_AMt+'
		order by chqdt desc,chqno,BANK'

	end 
else 
	begin
	select @SQL='select chqno,chqdt,entrydt,chqamt,BANK,Party,brcd,voucherno,acccode,ptmsptcd,adjustamt,NotUsedAmt,DepoFlag,OwnCust,transdate,Reconciled
		from VWnet_CHQ_Register where OwnCust='+ char(39) + 'C' + char(39)+''+@WhereCri_DT+@WhereCri+@Where_CHQ+@WhereCri_CHQ_CLST+@WhereCri_AMt+@WhereCri_DEPO+@WhereCri_ACC+'
		order by chqdt desc,chqno,BANK'
	end 

exec(@SQL)

	
		

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

