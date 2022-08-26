CREATE proc webx_TripStatement_Report                
@fromdt varchar(200),                
@todt varchar(200),          
@RO varchar(200),                
@LOC varchar(200),               
@RPTNO varchar(200)             
as                 
begin              
                
Declare @sql varchar(6000);                  
Declare @whereCri varchar(1000),@whereCri_RO varchar(1000);                  
Declare @dktstr varchar(1000);                  
Declare @paystr varchar(1000);           
          
 if @RO='All' and @LOC='All'            
 select @whereCri_RO = ''            
 else if @RO<>'All' and @LOC='All'            
 select @whereCri_RO = 'and (report_loc=' + char(39) + @RO + char(39)  +' or loccode=' + char(39) + @RO + char(39)  +')'          
 else if @RO='All' and @LOC<>'All'            
 select @whereCri_RO = 'and loccode= '+ char(39) + @LOC + char(39)            
 else if @RO<>'All' and @LOC<>'All'            
 select @whereCri_RO ='and loccode= '+ char(39) + @LOC + char(39)                   
           
if @RPTNO='1'           
 select @whereCri=''                
else if @RPTNO='2'                
 select @whereCri=' and rut_cat='+ char(39)+'A'+ char(39)               
else if @RPTNO='3'                
 select @whereCri=' and rut_cat='+ char(39)+'S'+ char(39)                
else if @RPTNO='4'                
 select @whereCri=' and rut_cat='+ char(39)+'T'+ char(39)                
else if @RPTNO='5'        
 select @whereCri=' and rut_cat='+ char(39)+'E'+ char(39)        
        
select @sql='select routecd,m.thcno,convert(varchar,thcdt,06) as thcdt,routename,          
 (select top 1 tobh_code from vw_thchdr where thcno=m.thcno  order by thcdt desc ) as tobh_code,        
isnull((select payload from webx_VEHICLE_HDR v where v.vehno=m.vehno ),0) as payload,          
rvn_self,sourcehb,coming_from,actdept_dt,actdept_tm,depdate_prevbr,deptime_prevbr,vehno,ld_actuwt,ul_actuwt,          
ld_actuwt As actload,CLOSEKM,OPENKM,totdkt,totwt,totfrt,     
status=(select dbo.FN_THC_STATUS(thcno) from webx_thc_summary where thcno=m.thcno)          
from webx_thc_summary m with(NOLOCK)        
inner join webx_location l with(NOLOCK) on l.loccode=m.thcbr      
inner join (select totdkt=count(*),sum(isnull(actuwt,0)) as totwt,sum(isnull(subtotal,0)) as totfrt,thcno      
from webx_master_docket D with(NOLOCK)      
inner join webx_master_docket_charges CD  with(NOLOCK) on d.dockno=cd.dockno      
inner join webx_trans_docket_Status s  with(NOLOCK) on d.dockno=s.dockno      
inner join VW_THC_TC_DOCKETS  TS with(NOLOCK) on d.dockno=TS.dockno and s.docksf=TS.docksf group by THCNo)FRT on m.thcno=FRT.thcno      
      
where 1=1' + @whereCri_RO + @whereCri + '        
and convert(varchar,thcdt,106) between          
convert(datetime,'+ char(39)+ @fromdt+ char(39)+',106) and        
convert(datetime,'+ char(39)+ @todt+ char(39)+',106)'        
end                
                
exec(@SQL)                
--select @whereCri_RO, @whereCri    

