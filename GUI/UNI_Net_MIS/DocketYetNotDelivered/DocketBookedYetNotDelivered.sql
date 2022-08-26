--sp_helptext WbxNet_Yet_Not_delivered_det
--exec WbxNet_Yet_Not_delivered '01 Aug 08','31 Aug 08','All','All'    
    
CREATE Proc WbxNet_Yet_Not_delivered    
@fromdt varchar(200),    
@todt varchar(200),    
@RO varchar(200),    
@ORGNCD varchar(200)    
as     
    
Declare @SQL Varchar(8000),@WhereCri_DT varchar(400),@DT_TYPE varchar(100),@Where_join varchar(1000);    
Declare @WhereCri varchar(2000),@WhereCri_Pay varchar(2000),@WhereCri_TYP varchar(2000),@WhereCri_SRTYP varchar(2000);    
    
select @WhereCri_DT='',@Where_join='',@WhereCri='',@WhereCri_Pay='',@WhereCri_TYP='',@WhereCri_SRTYP=''    
select @WhereCri_DT=' and Convert(varchar,dockdt,106) between Convert(datetime,'+char(39)+@fromdt+char(39)+',106) and Convert(datetime,'+char(39)+@TODT+char(39)+',106)  '    
    
 if @RO='All' and @ORGNCD='All'      
 select @WhereCri = ''      
 else if @RO<>'All' and @ORGNCD='All'      
 select @WhereCri = ' and report_loc=' + char(39) + @RO + char(39)      
 else if @RO='All' and @ORGNCD<>'All'      
 select @WhereCri = ' and loccode= '+ char(39) + @ORGNCD + char(39)      
 else if @RO<>'All' and @ORGNCD<>'All'      
 select @WhereCri = '  and loccode= '+ char(39) + @ORGNCD + char(39)      
    
    
select @SQL='select  report_loc,report_loc_name=(select top 1 loccode+'+char(39)+' : '+char(39)+'+locname  from webx_location where loccode=l.report_loc ),loccode,locname=loccode+'+char(39)+' : '+char(39)+'+locname,count(*) as Total_Dockets,    
NotArrived_At_dest=sum(case when d.reassign_destcd<>curr_loc  Then 1 else 0 end),    
Delivered=sum(case when d.reassign_destcd=curr_loc and  Delivered='+char(39)+'Y'+char(39)+' Then 1 else 0 end),    
Waiting_FOR_DRS=sum(case when d.reassign_destcd=curr_loc and Delivered='+char(39)+'N'+char(39)+' and DRS is  null  Then 1 else 0 end),    
Gone_for_Delivery=sum(case when d.reassign_destcd=curr_loc and Delivered='+char(39)+'N'+char(39)+' and DRS is not null and isnull(pdcupdated,'+char(39)+'N'+char(39)+')='+char(39)+'N'+char(39)+' Then 1 else 0 end),    
UnDelivered=sum(case when d.reassign_destcd=curr_loc and Delivered='+char(39)+'N'+char(39)+' and DRS is not null and  isnull(pdcupdated,'+char(39)+'N'+char(39)+')='+char(39)+'Y'+char(39)+' Then 1 else 0 end)    
from webx_master_docket D With(NOLOCK)     
inner join webx_trans_docket_status S With(NOLOCK)  on d.dockno=s.dockno and d.docksf=s.docksf    
inner join webx_location L on d.reassign_destcd=l.loccode    
left outer join webx_pdchdr P With(NOLOCK) on S.drs=P.pdcno    
where 1=1 '+@WhereCri_DT+@WhereCri+'    
group by Report_loc,loccode,locname    
order by Report_loc,loccode,locname'    
exec(@SQL)    


go


--exec WbxNet_Yet_Not_delivered_det '01 Aug 08','31 Aug 08','6','BOMN'    
    
CREATE Proc WbxNet_Yet_Not_delivered_det    
@fromdt varchar(200),    
@todt varchar(200),    
@RPTno varchar(200),    
@ORGNCD varchar(200)    
as     
    
Declare @SQL Varchar(8000),@WhereCri_DT varchar(400),@DT_TYPE varchar(100),@Where_join varchar(1000);    
Declare @WhereCri varchar(2000),@WhereCri_Pay varchar(2000),@WhereCri_TYP varchar(2000),@WhereCri_SRTYP varchar(2000);    
    
select @WhereCri_DT='',@Where_join='',@WhereCri='',@WhereCri_Pay='',@WhereCri_TYP='',@WhereCri_SRTYP=''    
select @WhereCri_DT=' and Convert(varchar,dockdt,106) between Convert(datetime,'+char(39)+@fromdt+char(39)+',106) and Convert(datetime,'+char(39)+@TODT+char(39)+',106)  '    
    
if @RPTno='1'--total dockets     
 select @WhereCri=''    
else if @RPTno='2'--NotArrived_At_dest    
 select @WhereCri=' and d.reassign_destcd<>curr_loc '    
else if @RPTno='3'--Delivered    
 select @WhereCri=' and d.reassign_destcd=curr_loc and  Delivered='+char(39)+'Y'+char(39)+''    
else if @RPTno='4'--Waiting_FOR_DRS    
 select @WhereCri=' and d.reassign_destcd=curr_loc and Delivered='+char(39)+'N'+char(39)+' and DRS is  null'    
else if @RPTno='5'--Gone_for_Delivery    
 select @WhereCri=' and d.reassign_destcd=curr_loc and Delivered='+char(39)+'N'+char(39)+' and DRS is not null  and  isnull(pdcupdated,'+char(39)+'N'+char(39)+')='+char(39)+'N'+char(39)+''    
else if @RPTno='6'--UnDelivered    
 select @WhereCri=' and d.reassign_destcd=curr_loc and Delivered='+char(39)+'N'+char(39)+' and DRS is not null and  isnull(pdcupdated,'+char(39)+'N'+char(39)+')='+char(39)+'Y'+char(39)+''    
    
select @SQL='select  d.dockno,dockdt=convert(varchar,dockdt,6),EDD,    
orgncd,reassign_destcd,curr_loc,Cnor,        Cnee ,  pkgsno,actuwt,chrgwt,Freight,    
Docket_Status   from                              
VwNet_Yet_Not_delivered_det d     
where d.reassign_destcd='+char(39)+@ORGNCD+char(39)+' '+@WhereCri_DT+@WhereCri+'    
order by dockdt desc,d.dockno'    
exec(@SQL)    
    
  



    
    
    
    
    
    
    
    
    
  
