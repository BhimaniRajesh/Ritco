if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Webx_BalanceSheet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Webx_BalanceSheet]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

--exec Webx_BalanceSheet '01 Apr 08','27 Aug 08','Y','08_09','HQTR','1','C0011293'  
  
  
  
CREATE Procedure Webx_BalanceSheet     
@from_date varchar(200),        
@to_date varchar(200),        
@Cumilative varchar(10),        
@Fin_Year varchar(10),        
@brcd varchar(100),    
@rpttyp varchar(10),    
@sel_typcd varchar(100)        
as        
declare @loc_level int        
declare @whereCri_loc varchar(2000),@whereCri_loc1 varchar(2000);        
     
select top 1 @loc_level=loc_level from webx_location with(NOLOCK) where loccode=@brcd        
 select @whereCri_loc=''    
       
begin        
 if @loc_level=1 and @Cumilative='Y'        
 select @whereCri_loc='where 1=1'        
 else if @loc_level<2 or @loc_level>2 or (@loc_level='2' ) and @Cumilative='N'        
 select @whereCri_loc='where m.brcd IN (' + char(39) + @brcd + char(39) +' )'        
 else if @loc_level<2 and @Cumilative='Y'        
 select @whereCri_loc='where 1=1'        
 else if @loc_level=2 and @Cumilative='Y'        
 select @whereCri_loc='where (m.brcd in (select loccode from webx_location where report_loc in (' + char(39) + @brcd + char(39) +' )) or m.brcd IN (' + char(39) + @brcd + char(39) +' ) )'        
end       
    
select @whereCri_loc1='where 1=1 '      
     
if @sel_typcd <>''  --or        
begin        
 select @whereCri_loc=@whereCri_loc + ' and [dbo].[SplitWithSearch]('+char(39)+@sel_typcd+char(39)+','+char(39)+','+char(39)+',PBOV_CODE)='+char(39)+'1'+char(39)+''              
 select @whereCri_loc1=@whereCri_loc1 + ' and [dbo].[SplitWithSearch]('+char(39)+@sel_typcd+char(39)+','+char(39)+','+char(39)+',empcd)='+char(39)+'1'+char(39)+''               
end     
    
---select @whereCri_loc,@whereCri_loc1    
declare @SQL_createView varchar(7000)   ,@SQL varchar(8000)    
    
    
declare @WhereCri_Sele_cum varchar(1000)     
    
if @Cumilative='Y'    
 select @WhereCri_Sele_cum='_i'    
else     
 select @WhereCri_Sele_cum='_i'    
           
delete  from  Webx_BlanaceSheet_RPT    
        
select @SQL_createView='insert into Webx_BlanaceSheet_RPT(M_CAT,M_CAT_no,M_GCD,GCD,acccode,M_ACD,debit,credit,BSAMT,TYP)    
 select g.bstype,bstypeno,    
isnull(g.company_groupcode,g.groupcode)+'+char(39)+' : '+char(39)+'+groupdesc,g.groupcode,a.acccode,    
isnull(a.company_acccode,a.acccode)+'+char(39)+' : '+char(39)+'+accdesc,    
sum(isnull(m.debit,0)),sum(isnull(m.credit,0)),  
(case when sum(isnull(debit,0))>sum(isnull(credit,0)) then sum(isnull(debit,0))-sum(isnull(credit,0)) else sum(isnull(credit,0))-sum(isnull(debit,0)) end) ,  
'+char(39)+'OPN_TR'+char(39)+'    
from webx_acctrans_'+@Fin_Year+' M with(NOLOCK)    
inner join webx_acctinfo a  with(NOLOCK) on m.acccode=a.acccode    
inner join webx_groups_bs g  with(NOLOCK) on g.groupcode=a.groupcode    
 '+@whereCri_loc +'  and  isnull(Voucher_cancel,'+char(39)+'N'+char(39)+')='+char(39)+'N'+char(39)+'       
and  g.bstype in ('+char(39)+'SF'+char(39)+','+char(39)+'CL'+char(39)+','+char(39)+'CA'+char(39)+','+char(39)+'AF'+char(39)+')    
and convert(varchar,transdate,106) < Convert(datetime,'+char(39)+@from_date+char(39)+',106)    
and  (isnull(Debit,0)>0 or isnull(credit,0)>0)    
group by  g.bstype,bstypeno,company_groupcode,g.groupcode,groupdesc,company_acccode,a.acccode,accdesc    
order by  bstypeno ,g.groupcode,a.acccode '    
       
exec(@SQL_createView)        
    
    
if @sel_typcd =''    
 begin    
 select @SQL='insert into Webx_BlanaceSheet_RPT(M_CAT,M_CAT_no,M_GCD,GCD,acccode,M_ACD,debit,credit,TYP)     
 select g.bstype,bstypeno,    
 isnull(g.company_groupcode,g.groupcode)+'+char(39)+' : '+char(39)+'+groupdesc,    
 g.groupcode,a.acccode,isnull(a.company_acccode,a.acccode)+'+char(39)+' : '+char(39)+'+accdesc,    
 sum(isnull(m.opendebit'+@WhereCri_Sele_cum+',0)),sum(isnull(m.opencredit'+@WhereCri_Sele_cum+',0)) ,  
'+char(39)+'OPN'+char(39)+'    
 from webx_acctopening_'+@Fin_Year+' M with(NOLOCK)    
 inner join webx_acctinfo a  with(NOLOCK) on m.acccode=a.acccode    
 inner join webx_groups_bs g  with(NOLOCK) on g.groupcode=a.groupcode     
'+@whereCri_loc+'      
 and  g.bstype in ('+char(39)+'SF'+char(39)+','+char(39)+'CL'+char(39)+','+char(39)+'CA'+char(39)+','+char(39)+'AF'+char(39)+')    
 group by  g.bstype,bstypeno,company_groupcode,g.groupcode,groupdesc,company_acccode,a.acccode,accdesc'    
 end    
else     
 begin     
 select @SQL='insert into Webx_BlanaceSheet_RPT(M_CAT,M_CAT_no,M_GCD,GCD,acccode,M_ACD,debit,credit,TYP)     
 select g.bstype,bstypeno,    
 isnull(g.company_groupcode,g.groupcode)+'+char(39)+' : '+char(39)+'+groupdesc,g.groupcode,a.acccode,isnull(a.company_acccode,a.acccode)+'+char(39)+' : '+char(39)+'+accdesc,    
 sum(isnull(m.opendebit,0)),sum(isnull(m.opencredit,0)),'+char(39)+'OPN'+char(39)+'    
 from webx_acctopening_employee_'+@Fin_Year+' M with(NOLOCK)    
 inner join webx_acctinfo a  with(NOLOCK) on m.acccode=a.acccode    
 inner join webx_groups_bs g  with(NOLOCK) on g.groupcode=a.groupcode     
 '+@whereCri_loc1+'     
 and  g.bstype in ('+char(39)+'SF'+char(39)+','+char(39)+'CL'+char(39)+','+char(39)+'CA'+char(39)+','+char(39)+'AF'+char(39)+')    
 group by  g.bstype,bstypeno,company_groupcode,g.groupcode,groupdesc,company_acccode,a.acccode,accdesc'    
 end    
 --select  @SQL    
exec(@SQL)    
    
select @SQL_createView='insert into Webx_BlanaceSheet_RPT(M_CAT,M_CAT_no,M_GCD,GCD,acccode,M_ACD,debit,credit,BSAMT,TYP)    
 select g.bstype,bstypeno,    
isnull(g.company_groupcode,g.groupcode)+'+char(39)+' : '+char(39)+'+groupdesc,g.groupcode,a.acccode,    
isnull(a.company_acccode,a.acccode)+'+char(39)+' : '+char(39)+'+accdesc,sum(isnull(m.debit,0)),sum(isnull(m.credit,0)),  
(case when sum(isnull(debit,0))>sum(isnull(credit,0)) then sum(isnull(debit,0))-sum(isnull(credit,0)) else sum(isnull(credit,0))-sum(isnull(debit,0)) end) ,  
'+char(39)+'TR'+char(39)+'    
from webx_acctrans_'+@Fin_Year+' M with(NOLOCK)    
inner join webx_acctinfo a  with(NOLOCK) on m.acccode=a.acccode    
inner join webx_groups_bs g  with(NOLOCK) on g.groupcode=a.groupcode    
 '+@whereCri_loc +'  and  isnull(Voucher_cancel,'+char(39)+'N'+char(39)+')='+char(39)+'N'+char(39)+'      
and  g.bstype in ('+char(39)+'SF'+char(39)+','+char(39)+'CL'+char(39)+','+char(39)+'CA'+char(39)+','+char(39)+'AF'+char(39)+')    
and convert(varchar,transdate,106) between Convert(datetime,'+char(39)+@from_date+char(39)+',106) and convert(datetime,'+char(39)+@to_date+char(39)+',106)     
and  (isnull(Debit,0)>0 or isnull(credit,0)>0)    
group by  g.bstype,bstypeno,company_groupcode,g.groupcode,groupdesc,company_acccode,a.acccode,accdesc    
order by  bstypeno ,g.groupcode,a.acccode '    
 exec(@SQL_createView)       
    
  
  
  


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Webx_BlanaceSheet_RPT]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Webx_BlanaceSheet_RPT]
GO

CREATE TABLE [dbo].[Webx_BlanaceSheet_RPT] (
	[SRNO] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[GCD] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[M_GCD] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[M_ACD] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[M_CAT] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[M_CAT_no] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[acccode] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[brcd] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Debit] [numeric](12, 2) NULL ,
	[Credit] [numeric](12, 2) NULL ,
	[TYP] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

