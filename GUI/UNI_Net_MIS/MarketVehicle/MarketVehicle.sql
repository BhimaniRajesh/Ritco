CREATE proc webx_Market_Vehicle_Report          
@fromdt varchar(200),          
@todt varchar(200),    
@RO varchar(200),          
@LOC varchar(200)  
as           
begin        
          
Declare @sql varchar(6000);            
Declare @whereCri varchar(1000),@whereCri_RO varchar(1000);            
Declare @dktstr varchar(1000);            
Declare @paystr varchar(1000);     
    
 if @RO='All' and @LOC='All'      
 select @whereCri_RO = ''      
 else if @RO<>'All' and @LOC='All'      
 select @whereCri_RO = ' and (report_loc=' + char(39) + @RO + char(39)  +' or loccode=' + char(39) + @RO + char(39)  +')'    
 else if @RO='All' and @LOC<>'All'      
 select @whereCri_RO = ' and loccode= '+ char(39) + @LOC + char(39)      
 else if @RO<>'All' and @LOC<>'All'      
 select @whereCri_RO =' and loccode= '+ char(39) + @LOC + char(39)             
       
    
select @sql='select sourcehb=(select top 1 loccode+'+ char(39)+' : '+ char(39)+'+locname from webx_location where loccode=T.sourcehb),tobh_code=(select top 1 loccode+'+ char(39)+' : '+ char(39)+'+locname from webx_location where loccode=T.tobh_code),
T.thcno,VHCDT=convert(varchar,thcdt,6),thcdt,PCAMT,ADVAMT,totwt,  
totfrt,totdkt,T.vehno,  
FTL=isnull((case when isnull(Payload,0)>0 then Payload end),0)  
from webx_thc_summary T with(NOLOCK)  
inner join webx_location l with(NOLOCK) on l.loccode=T.thcbr  
left outer join webx_vehicle_hdr V with(NOLOCK) on T.Vehno=V.vehno   
inner join (select totdkt=count(*),sum(isnull(actuwt,0)) as totwt,sum(isnull(subtotal,0)) as totfrt,thcno   
from webx_master_docket D with(NOLOCK)  
inner join webx_master_docket_charges CD  with(NOLOCK) on d.dockno=cd.dockno  
inner join webx_trans_docket_Status s  with(NOLOCK) on d.dockno=s.dockno  
inner join VW_THC_TC_DOCKETS  TS with(NOLOCK) on d.dockno=TS.dockno and s.docksf=TS.docksf group by THCNo)FRT on T.thcno=FRT.thcno  
where MKT_veh='+ char(39)+'Y'+ char(39)+'  
' + @whereCri_RO + ' and          
convert(varchar,T.thcdt,106) between  convert(datetime,'+ char(39)+ @fromdt+ char(39)+',106) and convert(datetime,'+ char(39)+ @todt+ char(39)+',106)  
order by thcdt desc'  
  
end          
          
exec(@SQL)          
--select @whereCri      


