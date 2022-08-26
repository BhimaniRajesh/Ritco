if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[webx_Stock_Report]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[webx_Stock_Report]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[webx_Stock_Report_det]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[webx_Stock_Report_det]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE proc webx_Stock_Report  
@fromdt varchar(200),  
@todt varchar(200),  
@RO varchar(200),  
@LO varchar(200)  
as   
  
begin    
Declare @sql varchar(6000);    
Declare @whereCri varchar(1000);    
Declare @dktstr varchar(1000);    
Declare @paystr varchar(1000);    
    
       if @RO='All' and @LO='All'       
   select @whereCri  = ''       
      else if @RO<>'All' and  @LO='All'      
   select @whereCri  = ' and l.report_loc=' + char(39)  + @RO + char(39)       
      else if @RO<>'All' and  @LO<>'All'      
        select @whereCri  = 'and l.report_loc=' + char(39)  + @RO + char(39) +' and l.loccode= '+ char(39)  + @LO  + char(39)      
  else if @RO='All' and  @LO<>'All'      
        select @whereCri  = 'and  l.loccode= '+ char(39)  + @LO  + char(39)      
  
  
select @SQL='select Report_loc=(select top 1 loccode+'+ char(39)+' : '+ char(39)+'+locname from webx_location where loccode=l.report_loc), loccode+'+ char(39)+' : '+ char(39)+'+locname as Location,loccode,  
sum(case when loccode=orgncd  and orgncd=curr_loc then 1 else 0 end) as Booking_Stock,  
sum(case when loccode=reassign_destcd and reassign_destcd=curr_loc   then 1 else 0 end) as Delivery_Stock,  
sum(case when loccode=curr_loc and reassign_destcd<>curr_loc and orgncd<>curr_loc then 1 else 0 end) as Transhipment_Stock  
from webx_location l with(NOLOCK)  
inner join (select a.dockno,orgncd,reassign_destcd,curr_loc from webx_master_docket a with(NOLOCK)  
 inner join webx_trans_docket_status b  with(NOLOCK) on a.dockno=b.dockno and b.docksf='+ char(39)+'.'+ char(39)+' and isnull(cancelled,'+ char(39)+'N'+ char(39)+')='+ char(39)+'N'+ char(39)+'  
 and THC is null and isnull(delivered,'+ char(39)+'N'+ char(39)+')='+ char(39)+'N'+ char(39)+'    
 and (case when reassign_destcd=curr_loc and DRS is not null then (select top 1  isnull(pdcupdated,'+ char(39)+'N'+ char(39)+') from webx_pdchdr p with(NOLOCK) where p.pdcno=drs) else '+ char(39)+'Y'+ char(39)+' end )='+ char(39)+'Y'+ char(39)+'      
 and Dely_Date is NULL  and   
 convert(varchar,dockdt,106) between  convert(datetime,'+ char(39)+ @fromdt+ char(39)+',106) and convert(datetime,'+ char(39)+ @todt+ char(39)+',106) )d   
 on (orgncd=loccode or reassign_destcd=loccode or curr_loc=loccode)  
where 1=1 '+@whereCri+'  
group by Report_loc, loccode,locname  
order  by  Report_loc ,loccode,locname'  
  
end  
  
exec(@SQL)  


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE proc webx_Stock_Report_det    
@fromdt varchar(200),    
@todt varchar(200),    
@LOC varchar(200),    
@RPTNO varchar(200)    
as     
    
begin      
Declare @sql varchar(6000);      
Declare @whereCri varchar(1000);      
Declare @dktstr varchar(1000);      
Declare @paystr varchar(1000);      
    
if @RPTNO='1'    
 select @whereCri=' and loccode=orgncd  and orgncd=curr_loc'    
else if @RPTNO='2'    
 select @whereCri=' and loccode=reassign_destcd and reassign_destcd=curr_loc'    
else if @RPTNO='3'    
 select @whereCri=' and (loccode=curr_loc and reassign_destcd<>curr_loc and orgncd<>curr_loc)'    
else if @RPTNO='4'    
 select @whereCri=' and ( ( loccode=orgncd  and orgncd=curr_loc) or (loccode=reassign_destcd and reassign_destcd=curr_loc) or (loccode=curr_loc and reassign_destcd<>curr_loc and orgncd<>curr_loc) )'    
    
select @sql='select DISTINCT a.dockno,orgncd=(select (LocCode+ '+ char(39)+':'+ char(39)+'+ LocName) from webx_location where loccode=a.orgncd),reassign_destcd=(select (LocCode+ '+ char(39)+':'+ char(39)+'+ LocName) from webx_location where loccode=a.reassign_destcd),curr_loc=(select (LocCode+ '+ char(39)+':'+ char(39)+'+ LocName) from webx_location where loccode=curr_loc),convert(varchar,dockdt,6) as dockdt,    
paybasstr=(select top 1  codedesc from webx_master_general where codetype='+ char(39)+'PAYTYP'+ char(39)+' and codeid=a.paybas),    
trnmodstr=(select top 1 codedesc from webx_master_general where codetype='+ char(39)+'TRN'+ char(39)+' and codeid=a.trn_mod),     
CSGNCD+'+ char(39)+':'+ char(39)+' +(case  when CSGNCD='+ char(39)+'8888'+ char(39)+' then CSGNNM else (select top 1 custnm from webx_custhdr  with(NOLOCK) where custcd=a.csgncd) end ) as Cnor,        
CSGeCD+'+ char(39)+':'+ char(39)+' +(case  when CSGeCD='+ char(39)+'8888'+ char(39)+' then CSGeNM else (select top 1 custnm from webx_custhdr   with(NOLOCK)  where custcd=a.csgecd) end ) as Cnee,         
status=(select top 1 docket_status from VW_docket_track_status_ver1 with(NOLOCK) where dockno=a.dockno)    
 from webx_master_docket a with(NOLOCK)    
inner join webx_trans_docket_status b  with(NOLOCK) on a.dockno=b.dockno and b.docksf='+ char(39)+'.'+ char(39)+'     
inner join webx_location l with(NOLOCK) on (orgncd=loccode or reassign_destcd=loccode or curr_loc=loccode)    
and isnull(cancelled,'+ char(39)+'N'+ char(39)+')='+ char(39)+'N'+ char(39)+'    
and  THC is null and isnull(delivered,'+ char(39)+'N'+ char(39)+')='+ char(39)+'N'+ char(39)+'    
and (case when reassign_destcd=curr_loc and DRS is not null then (select top 1  isnull(pdcupdated,'+ char(39)+'N'+ char(39)+') from webx_pdchdr p with(NOLOCK) where p.pdcno=drs) else '+ char(39)+'Y'+ char(39)+' end )='+ char(39)+'Y'+ char(39)+'        
and Dely_Date is NULL  and     
  loccode='+ char(39)+@LOC+ char(39)+' '+@whereCri+' and     
convert(varchar,dockdt,106) between  convert(datetime,'+ char(39)+ @fromdt+ char(39)+',106) and convert(datetime,'+ char(39)+ @todt+ char(39)+',106)     
order by dockdt desc,a.dockno'    
    
    
end    
    
exec(@SQL)    
--select @whereCri    
  


GO
SET QUOTED_IDENTIFIER OFF 	
GO
SET ANSI_NULLS ON 
GO

