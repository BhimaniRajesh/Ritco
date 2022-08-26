if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[webx_Monthly_sales_ver4]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[webx_Monthly_sales_ver4]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[webx_update_View_VW_Monthly_sales]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[webx_update_View_VW_Monthly_sales]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE Procedure webx_Monthly_sales_ver4     
@report_mode varchar(100),      
@ro varchar(100),      
@lo varchar(100),      
@pb varchar(100),      
@trnmod varchar(100),      
@columnnam varchar(100),      
@Report_subType varchar(100),      
@report_type varchar(100),      
@year varchar(5)  ,    
@fromdt varchar(100),      
@todt varchar(100),      
@8888cust varchar(100),  
@businesstype  varchar(100),    
@year_typ   varchar(100)  
as      
begin       
 Declare @sql varchar(8000);      
 declare @grpby varchar(200);      
 declare @m1 varchar(200);      
 declare @m2 varchar(200);      
 declare @m3 varchar(200);      
 declare @WHereYear varchar(200);      
 declare @WhereView varchar(200);      
 declare @WherePatIndex varchar(200);      
 declare @SeachCri varchar(200);      
 declare @WhichSeachCri varchar(200);      
 Declare @WhereCri varchar(8000);      
 Declare @WhereCri1 varchar(8000);    
declare @where_BUSI varchar(8000);      
 Declare @TRN1 varchar(10),@TRN2 varchar(10),@TRN3 varchar(10),@TRN4 varchar(10),@TRN_All varchar(10);      
 Declare @Pay_P01 varchar(10),@Pay_P02 varchar(10),@Pay_P03 varchar(10),@Pay_P04 varchar(10),@Pay_P06 varchar(10),@Pay_P07 varchar(10),@Pay_P08 varchar(10),@Pay_P09 varchar(10),@Pay_All varchar(10)  ,@Pay_CAN varchar(10),@TRN_CAN varchar(10)    
    
if @businesstype='All' or @businesstype=''  
 select  @where_BUSI=''  
else   
 select  @where_BUSI=' and businesstype=' + char(39)  + @businesstype + char(39)       
  
if @year_typ='2'  
begin  
declare @SQL_UPDATEView varchar(8000);     
if @report_type <>'7'    
 begin  
 select @SQL_UPDATEView='alter view VW_M_Y_FIN        
 as       
 select dkt_month as m,trn_mod,csgnnm,paybas as pb,dkt_Year as Y,orgncd lcd,f_report_loc as ro,f_locname as lnm,ENtryby,Party,count(*) as tdk,sum(chrgwt) as cWt,sum(dkttot) as dt,        
 sum(dkttot) as st,businesstype  
 from VW_Monthly_sales with(NOLOCK)        
 where dkt_month between ' + char(39)  +'4' + char(39)  +' and ' + char(39)  +'12' + char(39)  +'   and dkt_year=' + char(39)  +'20' + char(39)  +'+left(' + char(39)  +@year + char(39)  +',2)      
 group by trn_mod,paybas,dkt_Year,csgnnm,orgncd,f_report_loc,f_locname,ENtryby,Party,dkt_month,businesstype  
 union   
 select dkt_month as m,trn_mod,csgnnm,paybas as pb,dkt_Year as Y,orgncd lcd,f_report_loc as ro,f_locname as lnm,ENtryby,Party,count(*) as tdk,sum(chrgwt) as cWt,sum(dkttot) as dt,        
 sum(dkttot) as st,businesstype  
 from VW_Monthly_sales with(NOLOCK)        
 where dkt_month between ' + char(39)  +'1' + char(39)  +' and ' + char(39)  +'3' + char(39)  +'   and dkt_year=' + char(39)  +'20' + char(39)  +'+right(' + char(39)  +@year + char(39)  +',2)      
 group by trn_mod,paybas,dkt_Year,csgnnm,orgncd,f_report_loc,f_locname,ENtryby,Party,dkt_month  ,businesstype '    
  end  
else   
begin  
 select @SQL_UPDATEView='alter view VW_M_Y_FIN_BA_Employee            
 as        
 select BA_Employee_name,Alloted_By,BA_Employee,dkt_month as m,trn_mod,paybas as pb,dkt_Year as Y,orgncd lcd,f_report_loc as ro,f_locname as lnm,ENtryby,Party,count(*) as tdk,sum(chrgwt) as cWt,sum(dkttot) as dt,      
 sum(dkttot) as st ,businesstype  
 from VW_Monthly_sales_BA_Employee with(NOLOCK)      
 where dkt_month between ' + char(39)  +'4' + char(39)  +' and ' + char(39)  +'12' + char(39)  +'   and dkt_year=' + char(39)  +'20' + char(39)  +'+left(' + char(39)  +@year + char(39)  +',2)      
 group by BA_Employee_name,Alloted_By,BA_Employee,trn_mod,paybas,dkt_Year,orgncd,f_report_loc,f_locname,ENtryby,Party,dkt_month ,businesstype  
 union   
 select BA_Employee_name,Alloted_By,BA_Employee,dkt_month as m,trn_mod,paybas as pb,dkt_Year as Y,orgncd lcd,f_report_loc as ro,f_locname as lnm,ENtryby,Party,count(*) as tdk,sum(chrgwt) as cWt,sum(dkttot) as dt,      
 sum(dkttot) as st ,businesstype  
 from VW_Monthly_sales_BA_Employee with(NOLOCK)      
 where dkt_month between ' + char(39)  +'1' + char(39)  +' and ' + char(39)  +'3' + char(39)  +'   and dkt_year=' + char(39)  +'20' + char(39)  +'+right(' + char(39)  +@year + char(39)  +',2)      
 group by BA_Employee_name,Alloted_By,BA_Employee,trn_mod,paybas,dkt_Year,orgncd,f_report_loc,f_locname,ENtryby,Party,dkt_month ,businesstype    '  
end  
--select @SQL_UPDATEView  
exec(@SQL_UPDATEView)  
end  
 select @Pay_All=PATINDEX('%All%',@pb)      
 select @Pay_P01=PATINDEX('%P01%',@pb)      
 select @Pay_P02=PATINDEX('%P02%',@pb)      
 select @Pay_P03=PATINDEX('%P03%',@pb)      
 select @Pay_P04=PATINDEX('%P04%',@pb)      
 select @Pay_P06=PATINDEX('%P06%',@pb)      
 select @Pay_P07=PATINDEX('%P07%',@pb)      
 select @Pay_P08=PATINDEX('%P08%',@pb)      
 select @Pay_P09=PATINDEX('%P09%',@pb)      
 select @Pay_CAN=PATINDEX('%CAN%',@pb)      
       
--select @pb    
 select @TRN_All=PATINDEX('%All%',@trnmod)      
 select @TRN1=PATINDEX('%1%',@trnmod)      
 select @TRN2=PATINDEX('%2%',@trnmod)      
 select @TRN3=PATINDEX('%3%',@trnmod)      
 select @TRN4=PATINDEX('%4%',@trnmod)      
 select @TRN_CAN=PATINDEX('%CAN%',@trnmod)    
      
       
  if @ro='All' and @lo='All'       
   select @WhereCri  = ''       
  else if @ro<>'All' and  @lo='All'      
   select @WhereCri  = ' and ro=' + char(39)  + @ro + char(39)       
  else if @ro<>'All' and  @lo<>'All'      
      select @WhereCri  = 'and ro=' + char(39)  + @ro + char(39) +' and lcd= '+ char(39)  + @lo  + char(39)      
  else if @ro='All' and  @lo<>'All'      
      select @WhereCri  = 'and  lcd= '+ char(39)  + @lo  + char(39)      
      
           
  if @Report_subType='1'      
   begin      
   select @grpby='pb'      
   select @SeachCri='trn_mod'      
   select @WhichSeachCri=@trnmod      
   end      
  else       
   begin      
    select @grpby='trn_mod'      
   select @SeachCri='pb'      
   select @WhichSeachCri=@pb      
   end      
       
  select @WHereYear=''      
     
  if @report_mode='1'      
   select @WhereView='VW_M_CM'      
  else if @report_mode='2'       
   select @WhereView='VW_M_PM'      
  else if @report_mode='3'       
   Begin      
   select @WhereView='VW_M_1Q'      
   select @m1='1'      
   select @m2='2'      
   select @m3='3'       
   select @WHereYear=' and Y ='+ char(39)  + @year  + char(39)       
   end       
  else if @report_mode='4'       
   Begin      
   select @WhereView='VW_M_2Q'      
   select @m1='4'      
   select @m2='5'      
   select @m3='6'       
   select @WHereYear=' and Y ='+ char(39)  + @year  + char(39)       
   end        
  else if @report_mode='5'       
    Begin      
   select @WhereView='VW_M_3Q'      
   select @m1='7'      
   select @m2='8'      
   select @m3='9'       
   select @WHereYear=' and Y ='+ char(39)  + @year  + char(39)       
   end        
  else if @report_mode='6'       
   Begin      
   select @WhereView='VW_M_4Q'      
   select @m1='10'      
   select @m2='11'      
   select @m3='12'       
   select @WHereYear=' and Y ='+ char(39)  + @year  + char(39)       
   end      
  else if @report_mode='7'    or  @report_mode='11'  or  @report_mode='12'   
   Begin      
   select @WhereView='VW_M_Y'     
   select @WHereYear=' and Y ='+ char(39)  + @year  + char(39)       
 if @year_typ='2'  
 begin  
  select @WhereView='VW_M_Y_FIN'     
  select @WHereYear=' '    
 end  
   end      
  else if @report_mode='8' or @report_mode='9' or @report_mode='10'       
   Begin      
   select @WhereView='VW_M_Date'      
   select @WHereYear=' and Convert(varchar,dockdt,106)  between  Convert(datetime,' + char(39) + @fromdt + char(39)  + ',106)  and  Convert(datetime,' + char(39) + @todt + char(39)  + ',106)    '    
   end     
       
  
  
  
      
 if @report_type ='1'       
  select @sql='select ro,lcd as cd,lnm as nm'      
 else if @report_type ='2'      
 begin     
    if @8888cust='Y'    
    select @sql='select Party as cd,(case when Party= '+ char(39) +'8888'+ char(39) + ' then  csgnnm else custnm end ) as nm,custloc'      
    else    
  select @sql='select custcd as cd,custnm as nm,custloc'     
 end     
 else if @report_type ='3'       
  select @sql='select grpcd as cd,grpnm as nm'      
 else if @report_type ='4'        
  select @sql='select userid as cd,name as nm'     
 else if @report_type ='5'       
  select @sql='select custcd as cd,custnm as nm'       
 else if @report_type ='6'     
  select @sql='select top 20 custcd as cd,custnm as nm'     
 else if @report_type ='7'     
  select @sql='select  BA_Employee as ro,Alloted_By as cd,BA_Employee_name as nm'     
else if @report_type ='8'      
 begin     
    if @8888cust='Y'    
    select @sql='select lcd as RO,Party as cd,(case when Party= '+ char(39) +'8888'+ char(39) + ' then  csgnnm else custnm end ) as nm'      
    else    
  select @sql='select lcd as RO,custcd as cd,custnm as nm'     
 end   
    
 ------------Current/Pre Month Start      
 if @report_mode='1' or @report_mode='2' or @report_mode='7'  or @report_mode='8' or @report_mode='9' or @report_mode='10'   or @report_mode='12'    
  Begin       
   ------------Current/Pre Month Location Wise Start      
         
   ------------Current/Pre Month  pb Wise Start      
   if @Report_subType='1'      
    begin      
     if @Pay_All>0      
     Select @sql = @sql + ',isnull(sum(case when pb<>'+char(39)+'CAN'+char(39)+' then tdk else 0 end),0) as PAY_All_dkt,isnull(sum(case when pb<>'+char(39)+'CAN'+char(39)+' then dt else 0 end),0) as Pay_All_Amt,isnull(sum(case when pb<>'+char(39)+'CAN'+char(39)+' then cWt else 0 end),0) as Pay_All_wt,isnull(sum(case when pb<>'+char(39)+'CAN'+char(39)+' then st else 0 end),0) as Pay_All_yld'      
     if @Pay_P01>0      
     Select @sql = @sql + ',sum(case when pb='+char(39)+'P01'+char(39)+' then tdk else 0 end) as P1_dkt,sum(case when pb='+char(39)+'P01'+char(39)+' then dt else 0 end) as P1_Amt,sum(case when pb='+char(39)+'P01'+char(39)+' then cWt else 0 end) as P1_wt,sum(case when pb='+char(39)+'P01'+char(39)+' then st else 0 end) as P1_yld'      
     if @Pay_P02>0      
     Select @sql = @sql + ',sum(case when pb='+char(39)+'P02'+char(39)+' then tdk else 0 end) as P2_dkt,sum(case when pb='+char(39)+'P02'+char(39)+' then dt else 0 end) as P2_Amt,sum(case when pb='+char(39)+'P02'+char(39)+' then cWt else 0 end) as P2_wt,sum(case when pb='+char(39)+'P02'+char(39)+' then st else 0 end) as P2_yld'      
     if @Pay_P03>0      
     Select @sql = @sql + ',sum(case when pb='+char(39)+'P03'+char(39)+' then tdk else 0 end) as P3_dkt,sum(case when pb='+char(39)+'P03'+char(39)+' then dt else 0 end) as P3_Amt,sum(case when pb='+char(39)+'P03'+char(39)+' then cWt else 0 end) as P3_wt,sum(case when pb='+char(39)+'P03'+char(39)+' then st else 0 end) as P3_yld'      
     if @Pay_P04>0      
     Select @sql = @sql + ',sum(case when pb='+char(39)+'P04'+char(39)+' then tdk else 0 end) as P4_dkt,sum(case when pb='+char(39)+'P04'+char(39)+' then dt else 0 end) as P4_Amt,sum(case when pb='+char(39)+'P04'+char(39)+' then cWt else 0 end) as P4_wt,sum(case when pb='+char(39)+'P04'+char(39)+' then st else 0 end) as P4_yld'      
     if @Pay_P06>0      
     Select @sql = @sql + ',sum(case when pb='+char(39)+'P06'+char(39)+' then tdk else 0 end) as P6_dkt,sum(case when pb='+char(39)+'P06'+char(39)+' then dt else 0 end) as P6_Amt,sum(case when pb='+char(39)+'P06'+char(39)+' then cWt else 0 end) as P6_wt,sum(case when pb='+char(39)+'P06'+char(39)+' then st else 0 end) as P6_yld'      
     if @Pay_P07>0      
     Select @sql = @sql + ',sum(case when pb='+char(39)+'P07'+char(39)+' then tdk else 0 end) as P7_dkt,sum(case when pb='+char(39)+'P07'+char(39)+' then dt else 0 end) as P7_Amt,sum(case when pb='+char(39)+'P07'+char(39)+' then cWt else 0 end) as P7_wt,sum(case when pb='+char(39)+'P07'+char(39)+' then st else 0 end) as P7_yld'      
     if @Pay_P08>0      
     Select @sql = @sql + ',sum(case when pb='+char(39)+'P08'+char(39)+' then tdk else 0 end) as P8_dkt,sum(case when pb='+char(39)+'P08'+char(39)+' then dt else 0 end) as P8_Amt,sum(case when pb='+char(39)+'P08'+char(39)+' then cWt else 0 end) as P8_wt,sum(case when pb='+char(39)+'P08'+char(39)+' then st else 0 end) as P8_yld'      
     if @Pay_P09>0      
     Select @sql = @sql + ',sum(case when pb='+char(39)+'P09'+char(39)+' then tdk else 0 end) as P9_dkt,sum(case when pb='+char(39)+'P09'+char(39)+' then dt else 0 end) as P9_Amt,sum(case when pb='+char(39)+'P09'+char(39)+' then cWt else 0 end) as P9_wt,sum(case when pb='+char(39)+'P09'+char(39)+' then st else 0 end) as P9_yld'      
     if @Pay_CAN>0      
     Select @sql = @sql + ',sum(case when pb='+char(39)+'CAN'+char(39)+' then tdk else 0 end) as PC_dkt,sum(case when pb='+char(39)+'CAN'+char(39)+' then dt else 0 end) as PC_Amt,sum(case when pb='+char(39)+'CAN'+char(39)+' then cWt else 0 end) as PC_wt,sum(case when pb='+char(39)+'CAN'+char(39)+' then st else 0 end) as PC_yld'      
      
       
    end      
   ------------Current/Pre Month  pb Wise End       
   else    if @Report_subType='2'    
   ------------Current/Pre Month  Mode Wise Start       
    begin      
     if @TRN_All>0      
     Select @sql = @sql + ',isnull(sum(case when pb<>'+char(39)+'CAN'+char(39)+' then tdk else 0 end),0) as TRN_All_dkt,isnull(sum(case when pb<>'+char(39)+'CAN'+char(39)+' then dt else 0 end),0) as TRN_All_Amt,isnull(sum(case when pb<>'+char(39)+'CAN'+char(39)+' then cWt else 0 end),0) as  TRN_All_wt,isnull(sum(case when pb<>'+char(39)+'CAN'+char(39)+' then st else 0 end),0) as TRN_All_yld'      
     if @TRN1>0      
     Select @sql = @sql + ',sum(case when trn_mod ='+char(39)+'1'+char(39)+' then tdk else 0 end) as TRN_1_dkt,sum(case when trn_mod ='+char(39)+'1'+char(39)+' then dt else 0 end) as TRN_1_Amt,sum(case when trn_mod ='+char(39)+'1'+char(39)+' then cWt else 0 end) as TRN_1_wt,sum(case when trn_mod ='+char(39)+'1'+char(39)+' then st else 0 end) as TRN_1_yld'      
     if @TRN2>0      
     Select @sql = @sql + ',sum(case when trn_mod ='+char(39)+'2'+char(39)+' then tdk else 0 end) as TRN_2_dkt,sum(case when trn_mod ='+char(39)+'2'+char(39)+' then dt else 0 end) as TRN_2_Amt,sum(case when trn_mod ='+char(39)+'2'+char(39)+' then cWt else 0 end) as TRN_2_wt,sum(case when trn_mod ='+char(39)+'2'+char(39)+' then st else 0 end) as TRN_2_yld'      
     if @TRN3>0      
     Select @sql = @sql + ',sum(case when trn_mod ='+char(39)+'3'+char(39)+' then tdk else 0 end) as TRN_3_dkt,sum(case when trn_mod ='+char(39)+'3'+char(39)+' then dt else 0 end) as TRN_3_Amt,sum(case when trn_mod ='+char(39)+'3'+char(39)+' then cWt else 0 end) as TRN_3_wt,sum(case when trn_mod ='+char(39)+'3'+char(39)+' then st else 0 end) as TRN_3_yld'      
     if @TRN4>0      
     Select @sql = @sql + ',sum(case when trn_mod ='+char(39)+'4'+char(39)+' then tdk else 0 end) as TRN_4_dkt,sum(case when trn_mod ='+char(39)+'4'+char(39)+' then dt else 0 end) as TRN_4_Amt,sum(case when trn_mod ='+char(39)+'4'+char(39)+' then cWt else  0 end) as TRN_4_wt,sum(case when trn_mod ='+char(39)+'4'+char(39)+' then st else 0 end) as TRN_4_yld'      
     if @TRN_CAN>0      
     Select @sql = @sql + ',sum(case when trn_mod ='+char(39)+'CAN'+char(39)+' then tdk else 0 end) as TRN_C_dkt,sum(case when trn_mod ='+char(39)+'CAN'+char(39)+' then dt else 0 end) as TRN_C_Amt,sum(case when trn_mod ='+char(39)+'CAN'+char(39)+' then cWt else 0 end) as TRN_C_wt,sum(case when trn_mod ='+char(39)+'CAN'+char(39)+' then st else 0 end) as TRN_C_yld'      
            
    end      
   ------------Current/Pre Month Location Wise Mode Wise End       
  end      
  ------------Current/Pre Month Start      
      
 if @report_mode='3' or @report_mode='4' or @report_mode='5' or @report_mode='6'      
  begin      
         
         
   ------------Quater  pb Wise Start      
   if @Report_subType='1'      
    begin      
     if @Pay_All>0      
     Select @sql = @sql + ',isnull(sum(case when pb<>'+char(39)+'CAN'+char(39)+' then tdk else 0 end),0) as Pay_All_dkt,isnull(sum(case when pb<>'+char(39)+'CAN'+char(39)+' then dt else 0 end),0) as Pay_All_Amt,isnull(sum(case when pb<>'+char(39)+'CAN'+char(39)+' then cWt else 0 end),0) as  Pay_All_wt,isnull(sum(case when pb<>'+char(39)+'CAN'+char(39)+' then st else 0 end),0) as Pay_All_yld'      
   --------------------First Month Of Qater      
     if @Pay_P01>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P01'+char(39)+' then tdk else 0 end) as M1_P1_dkt,sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P01'+char(39)+' then dt else 0 end) as M1_P1_Amt,sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P01'+char(39)+' then cWt else 0 end) as M1_P1_wt,sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P01'+char(39)+' then st else 0 end) as M1_P1_yld'      
     if @Pay_P02>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P02'+char(39)+' then tdk else 0 end) as M1_P2_dkt,sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P02'+char(39)+' then dt else 0 end) as M1_P2_Amt,sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P02'+char(39)+' then cWt else 0 end) as M1_P2_wt,sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P02'+char(39)+' then st else 0 end) as M1_P2_yld'      
     if @Pay_P03>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P03'+char(39)+' then tdk else 0 end) as M1_P3_dkt,sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P03'+char(39)+' then dt else 0 end) as M1_P3_Amt,sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P03'+char(39)+' then cWt else 0 end) as M1_P3_wt,sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P03'+char(39)+' then st else 0 end) as M1_P3_yld'      
     if @Pay_P04>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P04'+char(39)+' then tdk else 0 end) as M1_P4_dkt,sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P04'+char(39)+' then dt else 0 end) as M1_P4_Amt,sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P04'+char(39)+' then cWt else 0 end) as M1_P4_wt,sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P04'+char(39)+' then st else 0 end) as M1_P4_yld'      
     if @Pay_P06>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P06'+char(39)+' then tdk else 0 end) as M1_P6_dkt,sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P06'+char(39)+' then dt else 0 end) as M1_P6_Amt,sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P06'+char(39)+' then cWt else 0 end) as M1_P6_wt,sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P06'+char(39)+' then st else 0 end) as M1_P6_yld'      
     if @Pay_P07>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P07'+char(39)+' then tdk else 0 end) as M1_P7_dkt,sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P07'+char(39)+' then dt else 0 end) as M1_P7_Amt,sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P07'+char(39)+' then cWt else 0 end) as M1_P7_wt,sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P07'+char(39)+' then st else 0 end) as M1_P7_yld'      
     if @Pay_P08>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P08'+char(39)+' then tdk else 0 end) as M1_P8_dkt,sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P08'+char(39)+' then dt else 0 end) as M1_P8_Amt,sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P08'+char(39)+' then cWt else 0 end) as M1_P8_wt,sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P08'+char(39)+' then st else 0 end) as M1_P8_yld'      
     if @Pay_P09>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P09'+char(39)+' then tdk else 0 end) as M1_P9_dkt,sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P09'+char(39)+' then dt else 0 end) as M1_P9_Amt,sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P09'+char(39)+' then cWt else 0 end) as M1_P9_wt,sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'P09'+char(39)+' then st else 0 end) as M1_P9_yld'      
      if @Pay_CAN>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'CAN'+char(39)+' then tdk else 0 end) as M1_PC_dkt,sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'CAN'+char(39)+' then dt else 0 end) as M1_PC_Amt,sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'CAN'+char(39)+' then cWt else 0 end) as M1_PC_wt,sum(case when m='+char(39)+@m1+char(39)+' and pb='+char(39)+'CAN'+char(39)+' then st else 0 end) as M1_PC_yld'      
     
   --------------------Second Month Of Qater      
     if @Pay_P01>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P01'+char(39)+' then tdk else 0 end) as M2_P1_dkt,sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P01'+char(39)+' then dt else 0 end) as M2_P1_Amt,sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P01'+char(39)+' then cWt else 0 end) as M2_P1_wt,sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P01'+char(39)+' then st else 0 end) as M2_P1_yld'      
     if @Pay_P02>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P02'+char(39)+' then tdk else 0 end) as M2_P2_dkt,sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P02'+char(39)+' then dt else 0 end) as M2_P2_Amt,sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P02'+char(39)+' then cWt else 0 end) as M2_P2_wt,sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P02'+char(39)+' then st else 0 end) as M2_P2_yld'      
     if @Pay_P03>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P03'+char(39)+' then tdk else 0 end) as M2_P3_dkt,sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P03'+char(39)+' then dt else 0 end) as M2_P3_Amt,sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P03'+char(39)+' then cWt else 0 end) as M2_P3_wt,sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P03'+char(39)+' then st else 0 end) as M2_P3_yld'      
     if @Pay_P04>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P04'+char(39)+' then tdk else 0 end) as M2_P4_dkt,sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P04'+char(39)+' then dt else 0 end) as M2_P4_Amt,sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P04'+char(39)+' then cWt else 0 end) as M2_P4_wt,sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P04'+char(39)+' then st else 0 end) as M2_P4_yld'      
     if @Pay_P06>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P06'+char(39)+' then tdk else 0 end) as M2_P6_dkt,sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P06'+char(39)+' then dt else 0 end) as M2_P6_Amt,sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P06'+char(39)+' then cWt else 0 end) as M2_P6_wt,sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P06'+char(39)+' then st else 0 end) as M2_P6_yld'      
     if @Pay_P07>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P07'+char(39)+' then tdk else 0 end) as M2_P7_dkt,sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P07'+char(39)+' then dt else 0 end) as M2_P7_Amt,sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P07'+char(39)+' then cWt else 0 end) as M2_P7_wt,sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P07'+char(39)+' then st else 0 end) as M2_P7_yld'      
     if @Pay_P08>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P08'+char(39)+' then tdk else 0 end) as M2_P8_dkt,sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P08'+char(39)+' then dt else 0 end) as M2_P8_Amt,sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P08'+char(39)+' then cWt else 0 end) as M2_P8_wt,sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P08'+char(39)+' then st else 0 end) as M2_P8_yld'      
     if @Pay_P09>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P09'+char(39)+' then tdk else 0 end) as M2_P9_dkt,sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P09'+char(39)+' then dt else 0 end) as M2_P9_Amt,sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P09'+char(39)+' then cWt else 0 end) as M2_P9_wt,sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'P09'+char(39)+' then st else 0 end) as M2_P9_yld'      
      if @Pay_CAN>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'CAN'+char(39)+' then tdk else 0 end) as M2_PC_dkt,sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'CAN'+char(39)+' then dt else 0 end) as M2_PC_Amt,sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'CAN'+char(39)+' then cWt else 0 end) as M2_PC_wt,sum(case when m='+char(39)+@m2+char(39)+' and pb='+char(39)+'CAN'+char(39)+' then st else 0 end) as M2_PC_yld'      
   --------------------Third Month Of Qater       
     if @Pay_P01>0       
     Select @sql = @sql + ',sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P01'+char(39)+' then tdk else 0 end) as M3_P1_dkt,sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P01'+char(39)+' then dt else 0 end) as M3_P1_Amt,sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P01'+char(39)+' then cWt else 0 end) as M3_P1_wt,sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P01'+char(39)+' then st else 0 end) as M3_P1_yld'      
     if @Pay_P02>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P02'+char(39)+' then tdk else 0 end) as M3_P2_dkt,sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P02'+char(39)+' then dt else 0 end) as M3_P2_Amt,sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P02'+char(39)+' then cWt else 0 end) as M3_P2_wt,sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P02'+char(39)+' then st else 0 end) as M3_P2_yld'      
     if @Pay_P03>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P03'+char(39)+' then tdk else 0 end) as M3_P3_dkt,sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P03'+char(39)+' then dt else 0 end) as M3_P3_Amt,sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P03'+char(39)+' then cWt else 0 end) as M3_P3_wt,sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P03'+char(39)+' then st else 0 end) as M3_P3_yld'      
     if @Pay_P04>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P04'+char(39)+' then tdk else 0 end) as M3_P4_dkt,sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P04'+char(39)+' then dt else 0 end) as M3_P4_Amt,sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P04'+char(39)+' then cWt else 0 end) as M3_P4_wt,sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P04'+char(39)+' then st else 0 end) as M3_P4_yld'      
     if @Pay_P06>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P06'+char(39)+' then tdk else 0 end) as M3_P6_dkt,sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P06'+char(39)+' then dt else 0 end) as M3_P6_Amt,sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P06'+char(39)+' then cWt else 0 end) as M3_P6_wt,sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P06'+char(39)+' then st else 0 end) as M3_P6_yld'      
     if @Pay_P07>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P07'+char(39)+' then tdk else 0 end) as M3_P7_dkt,sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P07'+char(39)+' then dt else 0 end) as M3_P7_Amt,sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P07'+char(39)+' then cWt else 0 end) as M3_P7_wt,sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P07'+char(39)+' then st else 0 end) as M3_P7_yld'      
     if @Pay_P08>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P08'+char(39)+' then tdk else 0 end) as M3_P8_dkt,sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P08'+char(39)+' then dt else 0 end) as M3_P8_Amt,sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P08'+char(39)+' then cWt else 0 end) as M3_P8_wt,sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P08'+char(39)+' then st else 0 end) as M3_P8_yld'      
     if @Pay_P09>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P09'+char(39)+' then tdk else 0 end) as M3_P9_dkt,sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P09'+char(39)+' then dt else 0 end) as M3_P9_Amt,sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P09'+char(39)+' then cWt else 0 end) as M3_P9_wt,sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'P09'+char(39)+' then st else 0 end) as M3_P9_yld'      
       if @Pay_CAN>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'CAN'+char(39)+' then tdk else 0 end) as M3_PC_dkt,sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'CAN'+char(39)+' then dt else 0 end) as M3_PC_Amt,sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'CAN'+char(39)+' then cWt else 0 end) as M3_PC_wt,sum(case when m='+char(39)+@m3+char(39)+' and pb='+char(39)+'CAN'+char(39)+' then st else 0 end) as M3_PC_yld'       
      
    end      
   ------------Current Month  pb Wise End       
   else   if @Report_subType='2'      
   ------------Current Month  Mode Wise Start       
    begin      
     if @TRN_All>0      
     Select @sql = @sql + ',isnull(sum(case when pb<>'+char(39)+'CAN'+char(39)+' then tdk else 0 end),0) as TRN_All_dkt,isnull(sum(case when pb<>'+char(39)+'CAN'+char(39)+' then dt else 0 end),0) as TRN_All_Amt,isnull(sum(case when pb<>'+char(39)+'CAN'+char(39)+' then cWt else 0 end),0) as  TRN_All_wt,isnull(sum(case when pb<>'+char(39)+'CAN'+char(39)+' then st else 0 end),0) as TRN_All_yld'      
   --------------------First Month Of Qater      
     if @TRN1>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m1+char(39)+' and trn_mod ='+char(39)+'1'+char(39)+' then tdk else 0 end) as M1_TRN_1_dkt,sum(case when m='+char(39)+@m1+char(39)+' and trn_mod ='+char(39)+'1'+char(39)+' then dt else 0 end) as M1_TRN_1_Amt,sum(case when m='+char(39)+@m1+char(39)+' and trn_mod ='+char(39)+'1'+char(39)+' then cWt else 0 end) as M1_TRN_1_wt,sum(case when m='+char(39)+@m1+char(39)+' and trn_mod ='+char(39)+'1'+char(39)+' then st else 0 end) as M1_TRN_1_yld'      
     if @TRN2>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m1+char(39)+' and trn_mod ='+char(39)+'2'+char(39)+' then tdk else 0 end) as M1_TRN_2_dkt,sum(case when m='+char(39)+@m1+char(39)+' and trn_mod ='+char(39)+'2'+char(39)+' then dt else 0 end) as M1_TRN_2_Amt,sum(case when m='+char(39)+@m1+char(39)+' and trn_mod ='+char(39)+'2'+char(39)+' then cWt else 0 end) as M1_TRN_2_wt,sum(case when m='+char(39)+@m1+char(39)+' and trn_mod ='+char(39)+'2'+char(39)+' then st else 0 end) as M1_TRN_2_yld'      
     if @TRN3>0     
     Select @sql = @sql + ',sum(case when m='+char(39)+@m1+char(39)+' and trn_mod ='+char(39)+'3'+char(39)+' then tdk else 0 end) as M1_TRN_3_dkt,sum(case when m='+char(39)+@m1+char(39)+' and trn_mod ='+char(39)+'3'+char(39)+' then dt else 0 end) as M1_TRN_3_Amt,sum(case when m='+char(39)+@m1+char(39)+' and trn_mod ='+char(39)+'3'+char(39)+' then cWt else 0 end) as M1_TRN_3_wt,sum(case when m='+char(39)+@m1+char(39)+' and trn_mod ='+char(39)+'3'+char(39)+' then st else 0 end) as M1_TRN_3_yld'      
     if @TRN4>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m1+char(39)+' and trn_mod ='+char(39)+'4'+char(39)+' then tdk else 0 end) as M1_TRN_4_dkt,sum(case when m='+char(39)+@m1+char(39)+' and trn_mod ='+char(39)+'4'+char(39)+' then dt else 0 end) as M1_TRN_4_Amt,sum(case when m='+char(39)+@m1+char(39)+' and trn_mod ='+char(39)+'4'+char(39)+' then cWt else 0 end) as M1_TRN_4_wt,sum(case when m='+char(39)+@m1+char(39)+' and trn_mod ='+char(39)+'4'+char(39)+' then st else 0 end) as M1_TRN_4_yld'      
     if @TRN_CAN>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m1+char(39)+' and trn_mod ='+char(39)+'CAN'+char(39)+' then tdk else 0 end) as M1_TRN_C_dkt,sum(case when m='+char(39)+@m1+char(39)+' and trn_mod ='+char(39)+'CAN'+char(39)+' then dt else 0 end) as M1_TRN_C_Amt,sum(case when m='+char(39)+@m1+char(39)+' and trn_mod ='+char(39)+'CAN'+char(39)+' then cWt else 0 end) as M1_TRN_C_wt,sum(case when m='+char(39)+@m1+char(39)+' and trn_mod ='+char(39)+'CAN'+char(39)+' then st else 0 end) as M1_TRN_C_yld'     


 
    
   --------------------First Month Of Qater      
      if @TRN1>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m2+char(39)+' and trn_mod ='+char(39)+'1'+char(39)+' then tdk else 0 end) as M2_TRN_1_dkt,sum(case when m='+char(39)+@m2+char(39)+' and trn_mod ='+char(39)+'1'+char(39)+' then dt else 0 end) as M2_TRN_1_Amt,sum(case when m='+char(39)+@m2+char(39)+' and trn_mod ='+char(39)+'1'+char(39)+' then cWt else 0 end) as M2_TRN_1_wt,sum(case when m='+char(39)+@m2+char(39)+' and trn_mod ='+char(39)+'1'+char(39)+' then st else 0 end) as M2_TRN_1_yld'      
     if @TRN2>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m2+char(39)+' and trn_mod ='+char(39)+'2'+char(39)+' then tdk else 0 end) as M2_TRN_2_dkt,sum(case when m='+char(39)+@m2+char(39)+' and trn_mod ='+char(39)+'2'+char(39)+' then dt else 0 end) as M2_TRN_2_Amt,sum(case when m='+char(39)+@m2+char(39)+' and trn_mod ='+char(39)+'2'+char(39)+' then cWt else 0 end) as M2_TRN_2_wt,sum(case when m='+char(39)+@m2+char(39)+' and trn_mod ='+char(39)+'2'+char(39)+' then st else 0 end) as M2_TRN_2_yld'      
     if @TRN3>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m2+char(39)+' and trn_mod ='+char(39)+'3'+char(39)+' then tdk else 0 end) as M2_TRN_3_dkt,sum(case when m='+char(39)+@m2+char(39)+' and trn_mod ='+char(39)+'3'+char(39)+' then dt else 0 end) as M2_TRN_3_Amt,sum(case when m='+char(39)+@m2+char(39)+' and trn_mod ='+char(39)+'3'+char(39)+' then cWt else 0 end) as M2_TRN_3_wt,sum(case when m='+char(39)+@m2+char(39)+' and trn_mod ='+char(39)+'3'+char(39)+' then st else 0 end) as M2_TRN_3_yld'      
     if @TRN4>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m2+char(39)+' and trn_mod ='+char(39)+'4'+char(39)+' then tdk else 0 end) as M2_TRN_4_dkt,sum(case when m='+char(39)+@m2+char(39)+' and trn_mod ='+char(39)+'4'+char(39)+' then dt else 0 end) as M2_TRN_4_Amt,sum(case when m='+char(39)+@m2+char(39)+' and trn_mod ='+char(39)+'4'+char(39)+' then cWt else 0 end) as M2_TRN_4_wt,sum(case when m='+char(39)+@m2+char(39)+' and trn_mod ='+char(39)+'4'+char(39)+' then st else 0 end) as M2_TRN_4_yld'      
      if @TRN_CAN>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m2+char(39)+' and trn_mod ='+char(39)+'CAN'+char(39)+' then tdk else 0 end) as M2_TRN_C_dkt,sum(case when m='+char(39)+@m1+char(39)+' and trn_mod ='+char(39)+'CAN'+char(39)+' then dt else 0 end) as M2_TRN_C_Amt,sum(case when m='+char(39)+@m2+char(39)+' and trn_mod ='+char(39)+'CAN'+char(39)+' then cWt else 0 end) as M2_TRN_C_wt,sum(case when m='+char(39)+@m2+char(39)+' and trn_mod ='+char(39)+'CAN'+char(39)+' then st else 0 end) as M2_TRN_C_yld'     


  
      
   --------------------First Month Of Qater       
      if @TRN1>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m3+char(39)+' and trn_mod ='+char(39)+'1'+char(39)+' then tdk else 0 end) as M3_TRN_1_dkt,sum(case when m='+char(39)+@m3+char(39)+' and trn_mod ='+char(39)+'1'+char(39)+' then dt else 0 end) as M3_TRN_1_Amt,sum(case when m='+char(39)+@m3+char(39)+' and trn_mod ='+char(39)+'1'+char(39)+' then cWt else 0 end) as M3_TRN_1_wt,sum(case when m='+char(39)+@m3+char(39)+' and trn_mod ='+char(39)+'1'+char(39)+' then st else 0 end) as M3_TRN_1_yld'      
     if @TRN2>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m3+char(39)+' and trn_mod ='+char(39)+'2'+char(39)+' then tdk else 0 end) as M3_TRN_2_dkt,sum(case when m='+char(39)+@m3+char(39)+' and trn_mod ='+char(39)+'2'+char(39)+' then dt else 0 end) as M3_TRN_2_Amt,sum(case when m='+char(39)+@m3+char(39)+' and trn_mod ='+char(39)+'2'+char(39)+' then cWt else 0 end) as M3_TRN_2_wt,sum(case when m='+char(39)+@m3+char(39)+' and trn_mod ='+char(39)+'2'+char(39)+' then st else 0 end) as M3_TRN_2_yld'      
     if @TRN3>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m3+char(39)+' and trn_mod ='+char(39)+'3'+char(39)+' then tdk else 0 end) as M3_TRN_3_dkt,sum(case when m='+char(39)+@m3+char(39)+' and trn_mod ='+char(39)+'3'+char(39)+' then dt else 0 end) as M3_TRN_3_Amt,sum(case when m='+char(39)+@m3+char(39)+' and trn_mod ='+char(39)+'3'+char(39)+' then cWt else 0 end) as M3_TRN_3_wt,sum(case when m='+char(39)+@m3+char(39)+' and trn_mod ='+char(39)+'3'+char(39)+' then st else 0 end) as M3_TRN_3_yld'      
     if @TRN4>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m3+char(39)+' and trn_mod ='+char(39)+'4'+char(39)+' then tdk else 0 end) as M3_TRN_4_dkt,sum(case when m='+char(39)+@m3+char(39)+' and trn_mod ='+char(39)+'4'+char(39)+' then dt else 0 end) as M3_TRN_4_Amt,sum(case when m='+char(39)+@m3+char(39)+' and trn_mod ='+char(39)+'4'+char(39)+' then cWt else 0 end) as M3_TRN_4_wt,sum(case when m='+char(39)+@m3+char(39)+' and trn_mod ='+char(39)+'4'+char(39)+' then st else 0 end) as M3_TRN_4_yld'      
       if @TRN_CAN>0      
     Select @sql = @sql + ',sum(case when m='+char(39)+@m3+char(39)+' and trn_mod ='+char(39)+'CAN'+char(39)+' then tdk else 0 end) as M3_TRN_C_dkt,sum(case when m='+char(39)+@m3+char(39)+' and trn_mod ='+char(39)+'CAN'+char(39)+' then dt else 0 end) as M1_TRN_C_Amt,sum(case when m='+char(39)+@m3+char(39)+' and trn_mod ='+char(39)+'CAN'+char(39)+' then cWt else 0 end) as M3_TRN_C_wt,sum(case when m='+char(39)+@m3+char(39)+' and trn_mod ='+char(39)+'CAN'+char(39)+' then st else 0 end) as M3_TRN_C_yld'     


  
    end      
   ------------Current Month Location Wise Mode Wise End       
        
       
  end      
  
   if @report_mode='11'  
    begin  
 if @year_typ='1'  
   begin      
         Select @sql = @sql + ',isnull(sum(case when pb<>'+char(39)+'CAN'+char(39)+' then tdk else 0 end),0) as M_All_dkt,isnull(sum(case when pb<>'+char(39)+'CAN'+char(39)+' then dt else 0 end),0) as M_All_Amt,isnull(sum(case when pb<>'+char(39)+'CAN'+char(39)+' then cWt else 0 end),0) as  M_All_wt,isnull(sum(case when pb<>'+char(39)+'CAN'+char(39)+' then st else 0 end),0) as M_All_yld'      
         Select @sql = @sql + ',sum(case when m='+char(39)+'1'+char(39)+'  then tdk else 0 end) as M1_dkt,sum(case when m='+char(39)+'1'+char(39)+'  then dt else 0 end) as M1_Amt,sum(case when m='+char(39)+'1'+char(39)+'  then cWt else 0 end) as M1_wt,sum(case when m='+char(39)+'1'+char(39)+'  then st else 0 end) as M1_yld'      
                Select @sql = @sql + ',sum(case when m='+char(39)+'2'+char(39)+'  then tdk else 0 end) as M2_dkt,sum(case when m='+char(39)+'2'+char(39)+'  then dt else 0 end) as M2_Amt,sum(case when m='+char(39)+'2'+char(39)+'  then cWt else 0 end) as M2_wt,sum(case when m='+char(39)+'2'+char(39)+'  then st else 0 end) as M2_yld'     
         Select @sql = @sql + ',sum(case when m='+char(39)+'3'+char(39)+'  then tdk else 0 end) as M3_dkt,sum(case when m='+char(39)+'3'+char(39)+'  then dt else 0 end) as M3_Amt,sum(case when m='+char(39)+'3'+char(39)+'  then cWt else 0 end) as M3_wt,sum(case when m='+char(39)+'3'+char(39)+'  then st else 0 end) as M3_yld'     
  Select @sql = @sql + ',sum(case when m='+char(39)+'4'+char(39)+'  then tdk else 0 end) as M4_dkt,sum(case when m='+char(39)+'4'+char(39)+'  then dt else 0 end) as M4_Amt,sum(case when m='+char(39)+'4'+char(39)+'  then cWt else 0 end) as M4_wt,sum(case when m='+char(39)+'4'+char(39)+'  then st else 0 end) as M4_yld'     
  Select @sql = @sql + ',sum(case when m='+char(39)+'5'+char(39)+'  then tdk else 0 end) as M5_dkt,sum(case when m='+char(39)+'5'+char(39)+'  then dt else 0 end) as M5_Amt,sum(case when m='+char(39)+'5'+char(39)+'  then cWt else 0 end) as M5_wt,sum(case when m='+char(39)+'5'+char(39)+'  then st else 0 end) as M5_yld'     
  Select @sql = @sql + ',sum(case when m='+char(39)+'6'+char(39)+'  then tdk else 0 end) as M6_dkt,sum(case when m='+char(39)+'6'+char(39)+'  then dt else 0 end) as M6_Amt,sum(case when m='+char(39)+'6'+char(39)+'  then cWt else 0 end) as M6_wt,sum(case when m='+char(39)+'6'+char(39)+'  then st else 0 end) as M6_yld'     
  Select @sql = @sql + ',sum(case when m='+char(39)+'7'+char(39)+'  then tdk else 0 end) as M7_dkt,sum(case when m='+char(39)+'7'+char(39)+'  then dt else 0 end) as M7_Amt,sum(case when m='+char(39)+'7'+char(39)+'  then cWt else 0 end) as M7_wt,sum(case when m='+char(39)+'7'+char(39)+'  then st else 0 end) as M7_yld'     
  Select @sql = @sql + ',sum(case when m='+char(39)+'8'+char(39)+'  then tdk else 0 end) as M8_dkt,sum(case when m='+char(39)+'8'+char(39)+'  then dt else 0 end) as M8_Amt,sum(case when m='+char(39)+'8'+char(39)+'  then cWt else 0 end) as M8_wt,sum(case when m='+char(39)+'8'+char(39)+'  then st else 0 end) as M8_yld'     
  Select @sql = @sql + ',sum(case when m='+char(39)+'9'+char(39)+'  then tdk else 0 end) as M9_dkt,sum(case when m='+char(39)+'9'+char(39)+'  then dt else 0 end) as M9_Amt,sum(case when m='+char(39)+'9'+char(39)+'  then cWt else 0 end) as M9_wt,sum(case when m='+char(39)+'9'+char(39)+'  then st else 0 end) as M9_yld'     
  Select @sql = @sql + ',sum(case when m='+char(39)+'10'+char(39)+'  then tdk else 0 end) as M10_dkt,sum(case when m='+char(39)+'10'+char(39)+'  then dt else 0 end) as M10_Amt,sum(case when m='+char(39)+'10'+char(39)+'  then cWt else 0 end) as M10_wt,sum(case when m='+char(39)+'10'+char(39)+'  then st else 0 end) as M10_yld'      
  Select @sql = @sql + ',sum(case when m='+char(39)+'11'+char(39)+'  then tdk else 0 end) as M11_dkt,sum(case when m='+char(39)+'11'+char(39)+'  then dt else 0 end) as M11_Amt,sum(case when m='+char(39)+'11'+char(39)+'  then cWt else 0 end) as M11_wt,sum(case when m='+char(39)+'11'+char(39)+'  then st else 0 end) as M11_yld'   
                Select @sql = @sql + ',sum(case when m='+char(39)+'12'+char(39)+'  then tdk else 0 end) as M12_dkt,sum(case when m='+char(39)+'12'+char(39)+'  then dt else 0 end) as M12_Amt,sum(case when m='+char(39)+'12'+char(39)+'  then cWt else 0 end) as M12_wt,sum(case when m='+char(39)+'12'+char(39)+'  then st else 0 end) as M12_yld'  
     END  
 else if @year_typ='2'  
    begin      
         Select @sql = @sql + ',isnull(sum(case when pb<>'+char(39)+'CAN'+char(39)+' then tdk else 0 end),0) as M_All_dkt,isnull(sum(case when pb<>'+char(39)+'CAN'+char(39)+' then dt else 0 end),0) as M_All_Amt,isnull(sum(case when pb<>'+char(39)+'CAN'+char(39)+' then cWt else 0 end),0) as  M_All_wt,isnull(sum(case when pb<>'+char(39)+'CAN'+char(39)+' then st else 0 end),0) as M_All_yld'      
         Select @sql = @sql + ',sum(case when m='+char(39)+'4'+char(39)+'  then tdk else 0 end) as M1_dkt,sum(case when m='+char(39)+'4'+char(39)+'  then dt else 0 end) as M1_Amt,sum(case when m='+char(39)+'4'+char(39)+'  then cWt else 0 end) as M1_wt,sum(case when m='+char(39)+'4'+char(39)+'  then st else 0 end) as M1_yld'     
  Select @sql = @sql + ',sum(case when m='+char(39)+'5'+char(39)+'  then tdk else 0 end) as M2_dkt,sum(case when m='+char(39)+'5'+char(39)+'  then dt else 0 end) as M2_Amt,sum(case when m='+char(39)+'5'+char(39)+'  then cWt else 0 end) as M2_wt,sum(case when m='+char(39)+'5'+char(39)+'  then st else 0 end) as M2_yld'     
  Select @sql = @sql + ',sum(case when m='+char(39)+'6'+char(39)+'  then tdk else 0 end) as M3_dkt,sum(case when m='+char(39)+'6'+char(39)+'  then dt else 0 end) as M3_Amt,sum(case when m='+char(39)+'6'+char(39)+'  then cWt else 0 end) as M3_wt,sum(case when m='+char(39)+'6'+char(39)+'  then st else 0 end) as M3_yld'     
  Select @sql = @sql + ',sum(case when m='+char(39)+'7'+char(39)+'  then tdk else 0 end) as M4_dkt,sum(case when m='+char(39)+'7'+char(39)+'  then dt else 0 end) as M4_Amt,sum(case when m='+char(39)+'7'+char(39)+'  then cWt else 0 end) as M4_wt,sum(case when m='+char(39)+'7'+char(39)+'  then st else 0 end) as M4_yld'     
  Select @sql = @sql + ',sum(case when m='+char(39)+'8'+char(39)+'  then tdk else 0 end) as M5_dkt,sum(case when m='+char(39)+'8'+char(39)+'  then dt else 0 end) as M5_Amt,sum(case when m='+char(39)+'8'+char(39)+'  then cWt else 0 end) as M5_wt,sum(case when m='+char(39)+'8'+char(39)+'  then st else 0 end) as M5_yld'     
  Select @sql = @sql + ',sum(case when m='+char(39)+'9'+char(39)+'  then tdk else 0 end) as M6_dkt,sum(case when m='+char(39)+'9'+char(39)+'  then dt else 0 end) as M6_Amt,sum(case when m='+char(39)+'9'+char(39)+'  then cWt else 0 end) as M6_wt,sum(case when m='+char(39)+'9'+char(39)+'  then st else 0 end) as M6_yld'     
  Select @sql = @sql + ',sum(case when m='+char(39)+'10'+char(39)+'  then tdk else 0 end) as M7_dkt,sum(case when m='+char(39)+'10'+char(39)+'  then dt else 0 end) as M7_Amt,sum(case when m='+char(39)+'10'+char(39)+'  then cWt else 0 end) as M7_wt,sum(case when m='+char(39)+'10'+char(39)+'  then st else 0 end) as M7_yld'      
  Select @sql = @sql + ',sum(case when m='+char(39)+'11'+char(39)+'  then tdk else 0 end) as M8_dkt,sum(case when m='+char(39)+'11'+char(39)+'  then dt else 0 end) as M8_Amt,sum(case when m='+char(39)+'11'+char(39)+'  then cWt else 0 end) as M8_wt,sum(case when m='+char(39)+'11'+char(39)+'  then st else 0 end) as M8_yld'   
                Select @sql = @sql + ',sum(case when m='+char(39)+'12'+char(39)+'  then tdk else 0 end) as M9_dkt,sum(case when m='+char(39)+'12'+char(39)+'  then dt else 0 end) as M9_Amt,sum(case when m='+char(39)+'12'+char(39)+'  then cWt else 0 end) as M9_wt,sum(case when m='+char(39)+'12'+char(39)+'  then st else 0 end) as M9_yld'  
  Select @sql = @sql + ',sum(case when m='+char(39)+'1'+char(39)+'  then tdk else 0 end) as M10_dkt,sum(case when m='+char(39)+'1'+char(39)+'  then dt else 0 end) as M10_Amt,sum(case when m='+char(39)+'1'+char(39)+'  then cWt else 0 end) as M10_wt,sum(case when m='+char(39)+'1'+char(39)+'  then st else 0 end) as M10_yld'      
                Select @sql = @sql + ',sum(case when m='+char(39)+'2'+char(39)+'  then tdk else 0 end) as M11_dkt,sum(case when m='+char(39)+'2'+char(39)+'  then dt else 0 end) as M11_Amt,sum(case when m='+char(39)+'2'+char(39)+'  then cWt else 0 end) as M11_wt,sum(case when m='+char(39)+'2'+char(39)+'  then st else 0 end) as M11_yld'     
         Select @sql = @sql + ',sum(case when m='+char(39)+'3'+char(39)+'  then tdk else 0 end) as M12_dkt,sum(case when m='+char(39)+'3'+char(39)+'  then dt else 0 end) as M12_Amt,sum(case when m='+char(39)+'3'+char(39)+'  then cWt else 0 end) as M12_wt,sum(case when m='+char(39)+'3'+char(39)+'  then st else 0 end) as M12_yld'     
     END  

end  
      
      
 if @Pay_All>0 and @Pay_All>0      
  begin      
  select @WherePatIndex=' '      
        
  end      
 else      
  begin      
  select @WherePatIndex=' and  patindex('      
  Select @WherePatIndex = @WherePatIndex + '''' + '%' + '''' + '+'+@SeachCri +'+' + '''' + '%' + '''' + ','       
  Select @WherePatIndex = @WherePatIndex + '''' + @WhichSeachCri + '''' + ')<>0 '      
  end      
      
  if @report_type ='1'      
    begin       
   Select @sql = @sql + ' from '+ @WhereView+'  With(NOLOCK) where 1=1 '+@WhereCri+@WherePatIndex+@WHereYear+@where_BUSI+ ' Group by ro,lcd,lnm order by  ro,lcd'--,'+@grpby+ ''      
    end      
  else if @report_type ='2'      
    begin       
 if  @8888cust='N'    
     Select @sql = @sql + ' from '+ @WhereView+' D With(NOLOCK) Inner join webx_custhdr c With(NOLOCK) on d.party=custcd where 1=1 '+@WhereCri+@WherePatIndex+@WHereYear+@where_BUSI+ ' Group by custcd,custnm,custloc order by custcd'--,'+@grpby+ ''      
 else     
   Select @sql = @sql + ' from '+ @WhereView+' D With(NOLOCK) left outer join webx_custhdr c With(NOLOCK) on d.party=custcd where 1=1 '+@WhereCri+@WherePatIndex+@WHereYear+@where_BUSI+ ' Group by party,(case when d.party= '+ char(39) +'8888'+ char(39) + ' then  csgnnm else custnm end ) ,custloc  order by party,custloc'--,'+@grpby+ ''      
    end      
  else if @report_type ='3'      
    begin       
   Select @sql = @sql + ' from '+ @WhereView+' D With(NOLOCK) Inner join vw_custGrop c With(NOLOCK) on d.party=custcd where 1=1 '+@WhereCri+@WherePatIndex+@WHereYear+@where_BUSI+ ' Group by  grpcd,grpnm order by  grpcd'--,'+@grpby+ ''      
    end      
  else if @report_type ='4'      
    begin       
   Select @sql = @sql + ' from '+ @WhereView+' D With(NOLOCK) Inner join webx_master_users c With(NOLOCK) on d.entryby=userid where 1=1 '+@WhereCri+@WherePatIndex+@WHereYear+@where_BUSI+ ' Group by  userid,name order by userid'--,'+@grpby+ ''      
    end     
  else if @report_type ='5'      
    begin       
   Select @sql = @sql + ' from webx_custhdr c With(NOLOCK)  left outer join '+ @WhereView+' D With(NOLOCK) on d.party=custcd and   1=1 '+@WhereCri+@WherePatIndex+@WHereYear+@where_BUSI+ ' Group by custcd,custnm having count(d.tdk)=0 order by custcd'--,'+@grpby+ ''     
   
    end      
  else if @report_type ='6'      
    begin       
   Select @sql = @sql + ' from '+ @WhereView+' D With(NOLOCK) Inner join webx_custhdr c With(NOLOCK) on d.party=custcd where 1=1 '+@WhereCri+@WherePatIndex+@WHereYear+ @where_BUSI+' Group by custcd,custnm order by sum(dt) desc'--,'+@grpby+ ''      
    end     
  else if @report_type ='7'      
    begin       
   Select @sql = @sql + ' from '+ @WhereView+'_BA_Employee D With(NOLOCK)   where 1=1 '+@WhereCri+@WherePatIndex+@WHereYear+ @where_BUSI+' Group by BA_Employee,BA_Employee_name,Alloted_By  order by BA_Employee,sum(dt) desc'--,'+@grpby+ ''      
    end     
 else if @report_type ='8'      
    begin       
 if  @8888cust='N'    
     Select @sql = @sql + ' from '+ @WhereView+' D With(NOLOCK) Inner join webx_custhdr c With(NOLOCK) on d.party=custcd where 1=1 '+@WhereCri+@WherePatIndex+@WHereYear+ @where_BUSI+' Group by lcd,custcd,custnm order by lcd,custcd'--,'+@grpby+ ''      
 else     
   Select @sql = @sql + ' from '+ @WhereView+' D With(NOLOCK) left outer join webx_custhdr c With(NOLOCK) on d.party=custcd where 1=1 '+@WhereCri+@WherePatIndex+@WHereYear+@where_BUSI+ ' Group by lcd,party,(case when d.party= '+ char(39) +'8888'+ char(39) + ' then  csgnnm else custnm end )   order by lcd,party'--,'+@grpby+ ''      
    end   
  
  
  if @report_mode='12'  
  begin  
  Select @sql = replace(@sql,'Group by ','Group by m,Y,')  
  Select @sql = replace(@sql,'order by ','order by Y,m,')  
  Select @sql = replace(@sql,'select ','select m,Y,')  
  end  
end      
-- select @WHereYear   
exec(@sql)        
--select @sql      
--select  @Pay_CAN    
--select @WhereView      
 --select @WherePatIndex     
--select @WHereYear      
      
--exec webx_Monthly_sales '1','All','All','All,P01,P02','All','lyield,dkttot,totchrgwt,totdkts,','1','1','2007'    
    
    
--select std_contamt from webx_rutmas where rutcd='s0579'    
    
--exec webx_Monthly_sales '5','All','All','All,P01,P02,P03','All','lyield,dkttot,totchrgwt,totdkts,','1','2','2007'    
--exec webx_Monthly_sales '7','All','bomn','All,P01,P02,P03,P04,P08,p09','1,2,3,4,All','lyield,dkttot,totchrgwt,totdkts,','1','1','2007'    
    






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE     webx_update_View_VW_Monthly_sales    
@flag varchar(100) ,
@staxFlg    varchar(100) 
as    
    
declare @SQL varchar(8000),@whereORd_Dest varchar(2000),@whereStax varchar(400);    
declare @SQL1 varchar(8000);    
if @flag='Y'  
	select @whereORd_Dest=' inner join webx_location f With(NOLOCK) on d.reassign_destcd=f.loccode'
else 
	select @whereORd_Dest=' inner join webx_location f With(NOLOCK) on d.orgncd=f.loccode'

if @staxFlg='Y' 
	select @whereStax='dkttot= (isnull(dkttot,0)),'
else 
	select @whereStax='dkttot=((isnull(dkttot,0))-(isnull(svctax,0)+isnull(cess,0)+isnull(hedu_cess,0))),   '

  
 select @SQL='alter view VW_Monthly_sales        
 as        
 select    month(dockdt) as dkt_month,dockdt,businesstype,csgnnm,year(dockdt) as dkt_Year,    
trn_mod=(case when cancelled=' + char(39)  +'Y' + char(39)  +' then ' + char(39)  +'CAN' + char(39)  +' else trn_mod end),    
 paybas=(case when cancelled=' + char(39)  +'Y' + char(39)  +' then ' + char(39)  +'CAN' + char(39)  +' when paybas=' + char(39)  +'p08' + char(39)  +' then ' + char(39)  +'p02' + char(39)  +' when paybas=' + char(39)  +'p09' + char(39)  +' then ' + char(39)  +'p02' + char(39)  +' else paybas end),     
 ST=((isnull(dkttot,0))-(isnull(svctax,0)+isnull(cess,0)+isnull(hedu_cess,0))),  '+@whereStax+'
 svctax=isnull(svctax,0),cess=isnull(cess,0),hedu_cess=isnull(hedu_cess,0),ENtryby,        
 chrgwt=isnull(chrgwt,0), loccode as  orgncd,f.report_loc as f_report_loc,f.locname as f_locname,--reassign_destcd, t.report_loc as t_report_loc,t.locname as t_locname,  destcd,      
 (select case when d.paybas=' + char(39)  +'P09' + char(39)  +' then party_code When d.paybas=' + char(39)  +'P08' + char(39)  +' then party_code   When d.paybas=' + char(39)  +'P02' + char(39)  +' then party_code  When d.paybas=' + char(39)  +'P01 ' + char(39)  +' then csgncd When d.paybas=' + char(39)  +'P03 ' + char(39)  +' then csgecd  else csgncd  end) as Party             
 from webx_master_docket d With(NOLOCK)        
 inner join webx_master_docket_charges c With(NOLOCK) on d.dockno=c.dockno        
 inner join webx_trans_docket_status s With(NOLOCK) on d.dockno=s.dockno  and s.docksf=' + char(39)  +'.' + char(39)  +'  -- AND isnull(cancelled,' + char(39)  +'N' + char(39)  +')=' + char(39)  +'N' + char(39)  +' 
'+@whereORd_Dest+' 
   '   
 
 select @SQL1='alter view VW_Monthly_sales_BA_Employee      
 as      
 select BA_Employee_name,Alloted_By,BA_Employee,businesstype,csgnnm,dockdt,month(dockdt) as dkt_month,year(dockdt) as dkt_Year,    
trn_mod=(case when cancelled=' + char(39)  +'Y' + char(39)  +' then ' + char(39)  +'CAN' + char(39)  +' else trn_mod end),    
paybas=(case when cancelled=' + char(39)  +'Y' + char(39)  +' then ' + char(39)  +'CAN' + char(39)  +' when paybas=' + char(39)  +'p08' + char(39)  +' then ' + char(39)  +'p02' + char(39)  +' when paybas=' + char(39)  +'p09' + char(39)  +' then ' + char(39)  +'p02' + char(39)  +' else paybas end),     
 ST=((isnull(dkttot,0))-(isnull(svctax,0)+isnull(cess,0)+isnull(hedu_cess,0))), '+@whereStax+'     
 svctax=isnull(svctax,0),cess=isnull(cess,0),hedu_cess=isnull(hedu_cess,0),ENtryby,      
 chrgwt=isnull(chrgwt,0),loccode as orgncd,f.report_loc as f_report_loc,f.locname as f_locname,--reassign_destcd,t.report_loc as t_report_loc,t.locname as t_locname,      
 (select case when d.paybas=' + char(39)  +'P09' + char(39)  +' then party_code When d.paybas=' + char(39)  +'P08' + char(39)  +' then party_code   When d.paybas=' + char(39)  +'P02' + char(39)  +' then party_code  When d.paybas=' + char(39)  +'P01 ' + char(39)  +' then csgncd When d.paybas=' + char(39)  +'P03 ' + char(39)  +' then csgecd  else csgncd  end) as Party             
 from webx_master_docket d With(NOLOCK)      
 inner join webx_master_docket_charges c With(NOLOCK) on d.dockno=c.dockno     
 inner join VW_docket_BA_Employee V  With(NOLOCK) on d.dockno between doc_sr_from and doc_sr_to and Alloted_By  not in (select loccode from webx_location)    
 inner join webx_trans_docket_status s With(NOLOCK) on d.dockno=s.dockno    and s.docksf=' + char(39)  +'.' + char(39)  +'  -- AND isnull(cancelled,' + char(39)  +'N' + char(39)  +')=' + char(39)  +'N' + char(39)  +' 
'+@whereORd_Dest+' 
   '      

   -- select   @SQL
exec(@SQL)    
exec(@SQL1)    
  











GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

