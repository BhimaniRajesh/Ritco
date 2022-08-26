CREATE Proc WebxNet_Delivered_undelivered        
@fromdt varchar(100),                              
@todt varchar(100),                              
@fromRo  varchar(100),                              
@fromloc  varchar(100),                              
@toRo  varchar(100),                              
@toloc  varchar(100),                              
@custcode  varchar(100),            
@Paybas  varchar(100),           
@TRNMOD varchar(100),           
@SvcTYPE  varchar(100),      
@Status varchar(100) ,                           
@docklist varchar(100) ,      
@Path varchar(1000) ,      
@XLS varchar(2)       
--,@OUT varchar(8000) OutPut        
        
as                              
begin                              
Declare @sql varchar(8000),@selelist varchar(3000);                              
Declare @whereCri varchar(1000),@whereCri_pay varchar(1000),@whereCri_trn varchar(1000),@whereCri_typ varchar(1000);                              
Declare @whereCriTo varchar(1000);                              
Declare @dktstr varchar(1000);                              
Declare @dktstr_doc varchar(1000);        
Declare @dktstr_Status varchar(1000);        
        
        
select @whereCri_pay='',@whereCri_trn='',@whereCri_typ='' ,@dktstr_doc='' ,@dktstr_Status=''            
        
if  @Paybas<>'All'          
 select @whereCri_pay=' and paybas='+ char(39)  + @Paybas  + char(39)           
if  @TRNMOD<>'All'          
 select @whereCri_trn=' and trn_mod='+ char(39)  + @TRNMOD  + char(39)           
if  @SvcTYPE<>'All'          
 select @whereCri_typ=' and service_class='+ char(39)  + @SvcTYPE  + char(39)           
               
  if  @custcode<>'All'                      
 select @dktstr_doc =' and (csgncd='+ char(39)  + @custcode  + char(39) +' or csgecd='+ char(39)  + @custcode  + char(39) +' or party_code='+ char(39)  + @custcode  + char(39) +')'                
         
if    @Status<>'All'                        
select @dktstr_Status=' and Status='+ char(39)  + @Status  + char(39)           
    
if @fromRo='All' and @fromloc='All'                               
   select @whereCri  = ''                               
      else if @fromRo<>'All' and  @fromloc='All'                              
   select @whereCri  = ' and (from_report_loc=' + char(39)  + @fromRo + char(39)+' or from_loccode=' + char(39)  + @fromRo + char(39)+' )'                               
      else if @fromRo<>'All' and  @fromloc<>'All'                              
   select @whereCri  = ' and from_loccode= '+ char(39)  + @fromloc  + char(39)                              
      else if @fromRo='All' and  @fromloc<>'All'                              
   select @whereCri  = 'and  from_loccode= '+ char(39)  + @fromloc  + char(39)             
          
if @toRo='All' and @toloc='All'                               
   select @whereCriTo  = ''                               
      else if @toRo<>'All' and  @toloc='All'                              
   select @whereCriTo  = ' and (to_report_loc=' + char(39)  + @toRo + char(39)+'  or to_loccode=' + char(39)  + @toRo + char(39)+' )'                                             
      else if @toRo<>'All' and  @toloc<>'All'                              
   select @whereCriTo  = ' and to_loccode= '+ char(39)  + @toloc  + char(39)                              
      else if @toRo='All' and  @toloc<>'All'                              
   select @whereCriTo  = 'and  to_loccode= '+ char(39)  + @toloc  + char(39)                         
                
  --docksf,,Delivered  ,paybas,trn_mod,service_class,DRS,pdcupdated,      
      -- declare @selelist varchar(3000)        
select @selelist='dockno,dockdt=convert(varchar,dockdt,6),EDD,orgncd=(select top 1 loccode+'+ char(39)+' : '+ char(39)+'+locname from webx_location where loccode=orgncd),reassign_destcd=(select top 1 loccode+'+ char(39)+' : '+ char(39)+'+locname from webx_location where loccode=reassign_destcd),curr_loc=(select top 1 loccode+'+ char(39)+' : '+ char(39)+'+locname from webx_location where loccode=curr_loc),Cnor,Cnee,pkgsno,actuwt,chrgwt,Freight,        
invamt,STYP,PAYBASis,tranportmode,Status_date,Status,Actual_Status,ArrDt,Special_sevice  '        
      
--select @selelist=replace(replace(@selelist,',',char(39)+''+char(39)+','+char(39)+''+char(39)),' ','')           
--select @selelist      
      
 IF @docklist=''             
  begin                     
 select @sql='select '+@selelist+' from VwNet_Delivered_undelivered Item where 1=1 '+ @dktstr_Status+@whereCri+@whereCriTo+@dktstr_doc+@whereCri_pay+@whereCri_trn+@whereCri_typ +'                
    and  Convert(varchar,dockdt,106)  between  Convert(datetime,' + char(39) + @FROMDT + char(39)  + ',106)  and  Convert(datetime,' + char(39) + @TODT + char(39)  + ',106)                                
    order by dockdt desc ,dockno  '         
--select @dktstr_Status,@whereCriTo,@dktstr_doc,@whereCri_pay,@whereCri_trn,@whereCri_typ               
  end           
               
 else                 
 begin                
                  
    if @docklist<>''                     
   select @dktstr= '  and docno in  ('+char(39)+ replace(replace(@docklist,',',char(39)+','+char(39)),' ','')+char(39)+')'                        
   select @sql='select '+@selelist+' from VwNet_Delivered_undelivered Item where 1=1 '+ @dktstr+@dktstr_doc+'                    
      '                
 end        
      
      
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Delivered_undelivered]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)      
drop table [dbo].[Delivered_undelivered]      
--temp table to hold list of missing          
create table Delivered_undelivered ([srno] [numeric](18, 0) IDENTITY (1, 1) NOT NULL,           
DOCKNO Varchar(150),dockdt Varchar(150),EDD Varchar(150),      
orgncd Varchar(150) ,reassign_destcd Varchar(150),curr_loc Varchar(15) ,Cnor  Varchar(150),      
Cnee  Varchar(150),pkgsno Varchar(150), actuwt Varchar(150),chrgwt Varchar(15),invamt Varchar(15),      
Freight Varchar(150),STYP Varchar(150),PAYBASis Varchar(150),tranportmode Varchar(150)      
,Status Varchar(150),Status_date Varchar(150),Actual_Status Varchar(150))      
         
      
      
if @XLS='1' or @XLS='2'       
begin      
 insert into Delivered_undelivered values ('Docket No','Docket Date','EDD','Origin','Destination','Curr Loc.','Cnor','Cnee','Pkgs','Actu Wt.','Chrg Wt.','Freight','Value of Shipment','BKG Type','Pay Type','Mode','Status','Status Date','Actual Status')    
 
     
      
select @SQL ='insert into Delivered_undelivered '+@sql      
exec(@SQL)      
      
      
--if @XLS='Y'      
       
 declare @RPT_XLS varchar(2000)      
 if @XLS='1'      
  select @RPT_XLS='bcp "select *  from rcpl_live_net.dbo.Delivered_undelivered with(NOLOCK)" queryout "'+@Path+'\Delivered_Undelivered.XLS" -c -T -S localhost -U sa -P $QLaDm!n$123'      
 if @XLS='2'      
 begin      
  select @selelist=replace(replace(@selelist,',',char(39)+''+char(39)+','+char(39)+''+char(39)),' ','')           
  select @RPT_XLS='bcp "select '+@selelist+' from rcpl_live_net.dbo.Delivered_undelivered with(NOLOCK)" queryout "'+@Path+'\Delivered_Undelivered.CSV" -c -T -S localhost -U sa -P $QLaDm!n$123'      
 end      
        
 EXEC master..xp_cmdshell @RPT_XLS      
       
 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Delivered_undelivered]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)      
 drop table [dbo].[Delivered_undelivered]      
end      
else       
 --select * from #Delivered_undelivered with(NOLOCK)      
  exec(@SQL)      
end      
         
----select @SQL='<?xml version="1.0" ?>         
--    --<DocketList > ' + char(39) + '+('+@SQL+'          
----FOR XML AUTO, ROOT(' + char(39) +'Items' + char(39) +') )+' + char(39) +'</DocketList>'      
--select @SQL='create View VwNet_Delivered_undelivered_XLS as       
--select '+char(39)+ replace(replace(@selelist,',',char(39)+','+char(39)),' ','')+char(39)+'       
--union  '+ @sql        
--end                
--select @SQL-- ,@selelist+@whereCri+@whereCriTo+@dktstr_doc+@whereCri_pay+@whereCri_trn+@whereCri_typ               
--exec(@SQL)          
      
