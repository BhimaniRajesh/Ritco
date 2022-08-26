if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WebxNet_OutStd]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WebxNet_OutStd]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

--EXEC WebxNet_OutStd '01 Apr 90','30 Aug 08','All','BLRB','','30 Aug 08','30 Aug 08','bgndt','3','2','08_09','All','2'

create Proc WebxNet_OutStd  
@fromdt varchar(200),  
@todt varchar(200),  
@RO varchar(200),  
@ORGNCD varchar(200),  
@Custcd varchar(2000),  
@ASONDT varchar(200),  
@ASONDT_to varchar(200),  
@DT_TYPE varchar(200),  
@RPT_TYP varchar(200),  
@RPT_SUBTYP varchar(200),  
@FinYear varchar(5),  
@BillTYP Varchar(50),  
@CustRPT_TYP varchar(20)  
as  
  
declare @SQL varchar(8000),@WhereCri varchar(8000),@WhereCust varchar(8000),@WhereDate varchar(8000);  
declare @SELCUST_LOC varchar(200),@SELCUST_LOC_GRP varchar(200),@SELCUST_LOC_STR varchar(200)  
Declare @dktstr_Asondate varchar(1000),@WhereBillTYp varchar(1000),@WhereCustlTYp varchar(100);            
  
if  @ASONDT<>''         
      select @dktstr_Asondate=' and (convert(varchar,bcldt,106) > convert(datetime,' + char(39) + @ASONDT + char(39)  + ',106)  or bcldt is null)'                 
else   
 select @dktstr_Asondate=''  
  
  
if @CustRPT_TYP='1'  
 select @WhereCustlTYp= '  b.bbrcd=loccode '  
else if @CustRPT_TYP='2'  
 select @WhereCustlTYp= '  b.billsubbrcd=loccode '  
else if @CustRPT_TYP='3'  
 select @WhereCustlTYp= '  b.billcolbrcd=loccode '  
   
--select @WhereCustlTYp  
  
--@WhereBillTYp  
 if @BillTYP <>'All'   
  select @WhereBillTYp=' and (select top 1 codedesc from  webx_master_general with(NOLOCK) where codetype= '+char(39)+'BILLTYP'+char(39)+' and codeid=b.paybas)='+ char(39) + @BillTYP + char(39)  
 else   
  select @WhereBillTYp=''  
  
--select @WhereBillTYp  
  
if @Custcd<>''  
 select @WhereCust=' and [dbo].[SplitWithSearch]('+char(39)+@Custcd+char(39)+','+char(39)+','+char(39)+',b.ptmscd)='+char(39)+'1'+char(39)+' and  BILLSTATUS!='  + CHAR(39) + 'Bill Cancelled' +  CHAR(39)   
else   
 select @WhereCust=' and  BILLSTATUS!='  + CHAR(39) + 'Bill Cancelled' +  CHAR(39)   
   
  
select @WhereDate=' and Convert(varchar,'+@DT_TYPE+',106) between Convert(datetime,'+char(39)+@fromdt+char(39)+',106) and Convert(datetime,'+char(39)+@TODT+char(39)+',106)  and '+@DT_TYPE+' is not null'  
  
if @RO='All' and @ORGNCD='All'    
select @WhereCri = ''    
else if @RO<>'All' and @ORGNCD='All'    
select @WhereCri = ' and report_loc=' + char(39) + @RO + char(39)    
else if @RO='All' and @ORGNCD<>'All'    
select @WhereCri = ' and loccode= '+ char(39) + @ORGNCD + char(39)    
else if @RO<>'All' and @ORGNCD<>'All'    
select @WhereCri = ' and loccode= '+ char(39) + @ORGNCD + char(39)    
  
select @SELCUST_LOC='',@SELCUST_LOC_GRP='',@SELCUST_LOC_STR=''  
  
if @RPT_SUBTYP='1'  
 begin  
 select  @SELCUST_LOC= 'LOC_CUST_cd=loccode,  LOC_CUST=loccode+'+char(39)+' : '+char(39)+'+locname,'  
 select @SELCUST_LOC_GRP='locname,loccode,'  
 select @SELCUST_LOC_STR='loccode=brcd and'  
 end   
else  if @RPT_SUBTYP='2'  and (@RPT_TYP='3' or @RPT_TYP='4')
 begin  
 select  @SELCUST_LOC= 'LOC_CUST_cd=loccode,  LOC_CUST=loccode+'+char(39)+' : '+char(39)+'+locname,'  
 select @SELCUST_LOC_GRP='locname,loccode,'  
 select @SELCUST_LOC_STR='loccode=brcd and'  
end
else  if @RPT_SUBTYP='2'   and (@RPT_TYP='1' or @RPT_TYP='2')
 begin  
 select  @SELCUST_LOC='LOC_CUST_cd=custcd, LOC_CUST=custcd+'+char(39)+' : '+char(39)+'+custnm,'  
 select @SELCUST_LOC_GRP='custnm,custcd,'  
select @SELCUST_LOC_STR='loccode=brcd and'  
 end   
   
  
if @RPT_TYP='1'  
 begin  
 select @SQL='select report_loc,report_loc_name=(select top 1 loccode+'+char(39)+' : '+char(39)+'+locname from webx_location where loccode=l.report_loc),loccode,locname=loccode+'+char(39)+' : '+char(39)+'+locname,'+@SELCUST_LOC+'  
 Generated=convert(varchar,convert(money,(sum(case when b.bbrcd=loccode then isnull(pendamt,0) else 0 end )) ,2)),  
 To_BE_Submitted=convert(varchar,convert(money,(sum(case when billsubbrcd=loccode then isnull(pendamt,0) else 0 end )) ,2)),  
 To_BE_Collected=convert(varchar,convert(money,(sum(case when b.billcolbrcd=loccode then isnull(pendamt,0) else 0 end )) ,2))   
 from webx_billmst B with(NOLOCK)   
 inner join webx_location l on (b.bbrcd=loccode or  billsubbrcd=loccode or billcolbrcd=loccode)  
 inner join webx_custhdr on B.ptmscd=custcd  
 where 1=1  '+@WhereCri+@WhereDate+@dktstr_Asondate+@WhereCust+@WhereBillTYp+'  
 group by report_loc,loccode,'+@SELCUST_LOC_GRP+'locname  
 order by report_loc,locname,'+@SELCUST_LOC_GRP+'loccode'  
 exec(@SQL)  
 end  
else if @RPT_TYP='2'  
 begin  
 select @SQL='select report_loc,report_loc_name=(select top 1 loccode+'+char(39)+' : '+char(39)+'+locname from webx_location where loccode=l.report_loc),loccode,locname=loccode+'+char(39)+' : '+char(39)+'+locname,'+@SELCUST_LOC+'  
 Generated=convert(varchar,convert(money,(sum(isnull(pendamt,0)) ) ,2))     ,  
 Undue=convert(varchar,convert(money,(sum(case  when datediff(day,convert(varchar,'+@DT_TYPE+',106),convert(datetime,' + char(39) + @ASONDT + char(39)  + ',106)) < convert(varchar,0)  then isnull(pendamt,0) else 0 end) ) ,2)) ,   
 Undue_0_30=convert(varchar,convert(money,(sum(case  when datediff(day,convert(varchar,'+@DT_TYPE+',106),convert(datetime,' + char(39) + @ASONDT + char(39)  + ',106)) between convert(varchar,0) and  convert(varchar,30)  then isnull(pendamt,0) else 0 end) ) ,2)),  
 Undue_31_60=convert(varchar,convert(money,(sum(case  when datediff(day,convert(varchar,'+@DT_TYPE+',106),convert(datetime,' + char(39) + @ASONDT + char(39)  + ',106)) between convert(varchar,31) and  convert(varchar,60)  then isnull(pendamt,0) else 0 end) ) ,2)),  
 Undue_61_90=convert(varchar,convert(money,(sum(case  when datediff(day,convert(varchar,'+@DT_TYPE+',106),convert(datetime,' + char(39) + @ASONDT + char(39)  + ',106)) between convert(varchar,61) and  convert(varchar,90)  then isnull(pendamt,0) else 0 end) ) ,2)),  
 Undue_91_180=convert(varchar,convert(money,(sum(case  when datediff(day,convert(varchar,'+@DT_TYPE+',106),convert(datetime,' + char(39) + @ASONDT + char(39)  + ',106)) between convert(varchar,91) and  convert(varchar,180)  then isnull(pendamt,0) else 0 end) ) ,2)),  
 Undue_181_365=convert(varchar,convert(money,(sum(case  when datediff(day,convert(varchar,'+@DT_TYPE+',106),convert(datetime,' + char(39) + @ASONDT + char(39)  + ',106)) between convert(varchar,180) and  convert(varchar,365)  then isnull(pendamt,0) else 0 end) ) ,2)) ,  
 Undue_365=convert(varchar,convert(money,(sum(case  when datediff(day,convert(varchar,'+@DT_TYPE+',106),convert(datetime,' + char(39) + @ASONDT + char(39)  + ',106)) > convert(varchar,365)  then isnull(pendamt,0) else 0 end) ) ,2))  
 from webx_billmst B with(NOLOCK)   
 inner join webx_location l on b.bbrcd=loccode -- or  billsubbrcd=loccode or billcolbrcd=loccode)  
 inner join webx_custhdr on B.ptmscd=custcd  
 where 1=1  '+@WhereCri+@WhereDate+@dktstr_Asondate+@WhereCust+@WhereBillTYp+'  
 group by report_loc,loccode,'+@SELCUST_LOC_GRP+'locname  
 order by report_loc,locname,'+@SELCUST_LOC_GRP+'loccode'  
 exec(@SQL)  
 end  
else if @RPT_TYP='3'  
 begin  
 select @SQL='select custcd,custnm=custcd+'+char(39)+' : '+char(39)+'+custnm,'+@SELCUST_LOC+'  
 Generated=convert(varchar,convert(money,(sum(isnull(pendamt,0))) ,2))  
 ,On_AC_balance=convert(varchar,convert(money,(isnull((select  isnull(sum(isnull(chqamt,0)-isnull(ADJUSTAMT,0)),0)  from webx_CHQ_DET with(NOLOCK) where '+@SELCUST_LOC_STR+'  (ADJUSTAMT<>' + char(39) +'0' + char(39) +' or ADJUSTAMT is not null) and owncust=' + char(39) +'C' + char(39) +' and ptmsptcd=custcd group by ptmsptcd),0)) ,2))     ,  
 Ledger_balance=(select (case when sum(isnull(debit,0))>sum(isnull(credit,0)) then convert(varchar,cast(sum(isnull(debit,0))-sum(isnull(credit,0)) as decimal(9,2)))+ ' + char(39) +' Dr' + char(39) +' else convert(varchar,cast(sum(isnull(credit,0))-sum(isnull(debit,0)) as decimal(9,2)))+ ' + char(39) +'Cr' + char(39) +' end) as ledger_balance from webx_acctrans_'+@FinYear+' with(NOLOCK) where  '+@SELCUST_LOC_STR+' acccode=' + char(39) +'CDA0001' + char(39) +' and pbov_code=custcd and voucher_cancel='+ char(39) +'N'+ char(39) +' group by pbov_code),  
 Undue=convert(varchar,convert(money,(sum(case  when datediff(day,convert(varchar,'+@DT_TYPE+',106),convert(datetime,' + char(39) + @ASONDT + char(39)  + ',106)) < convert(varchar,0)  then isnull(pendamt,0) else 0 end)) ,2)) ,   
 Undue_0_30=convert(varchar,convert(money,(sum(case  when datediff(day,convert(varchar,'+@DT_TYPE+',106),convert(datetime,' + char(39) + @ASONDT + char(39)  + ',106)) between convert(varchar,0) and  convert(varchar,30)  then isnull(pendamt,0) else 0 end)) ,2)),  
 Undue_31_60=convert(varchar,convert(money,(sum(case  when datediff(day,convert(varchar,'+@DT_TYPE+',106),convert(datetime,' + char(39) + @ASONDT + char(39)  + ',106)) between convert(varchar,31) and  convert(varchar,60)  then isnull(pendamt,0) else 0 end)) ,2)),  
 Undue_61_90=convert(varchar,convert(money,(sum(case  when datediff(day,convert(varchar,'+@DT_TYPE+',106),convert(datetime,' + char(39) + @ASONDT + char(39)  + ',106)) between convert(varchar,61) and  convert(varchar,90)  then isnull(pendamt,0) else 0 end) ),2)),  
 Undue_91_180=convert(varchar,convert(money,(sum(case  when datediff(day,convert(varchar,'+@DT_TYPE+',106),convert(datetime,' + char(39) + @ASONDT + char(39)  + ',106)) between convert(varchar,91) and  convert(varchar,180)  then isnull(pendamt,0) else 0 end)) ,2)),  
 Undue_181_365=convert(varchar,convert(money,(sum(case  when datediff(day,convert(varchar,'+@DT_TYPE+',106),convert(datetime,' + char(39) + @ASONDT + char(39)  + ',106)) between convert(varchar,180) and  convert(varchar,365)  then isnull(pendamt,0) else 0 end)) ,2)) ,  
 Undue_365=convert(varchar,convert(money,(sum(case  when datediff(day,convert(varchar,'+@DT_TYPE+',106),convert(datetime,' + char(39) + @ASONDT + char(39)  + ',106)) > convert(varchar,365)  then isnull(pendamt,0) else 0 end)) ,2))  
 from webx_billmst B with(NOLOCK)   
 inner join webx_location l on  ' + @WhereCustlTYp + '  
 inner join webx_custhdr on B.ptmscd=custcd  
 where 1=1  '+@WhereCri+@WhereDate+@dktstr_Asondate+@WhereCust+@WhereBillTYp+'  
 group by custcd,'+@SELCUST_LOC_GRP+'custnm  
 order by custnm,'+@SELCUST_LOC_GRP+'custcd'  
-- select @SQL  ,@WhereCustlTYp,@WhereCri,@WhereDate,@dktstr_Asondate,@WhereCust,@WhereBillTYp,@SELCUST_LOC_GRP
 exec(@SQL)  
 END  
else if @RPT_TYP='4'  
 begin  
 select @SQL='select custcd,custnm=custcd+'+char(39)+' : '+char(39)+'+custnm,'+@SELCUST_LOC+'  
   fromason=convert(varchar,convert(money,sum(case when ((convert(varchar,bcldt,106) > convert(datetime,' + char(39) + @ASONDT + char(39)  + ',106)-0.1 or  bcldt is null) and convert(varchar,bgndt,106) < convert(datetime,' + char(39) + @ASONDT + char(39  )  + ',106)-0.1) then isnull(billamt,0) else 0 end),2))  ,        
   billgenamt=convert(varchar,convert(money,sum( case  when (convert(varchar,bgndt,106) between convert(datetime,' + char(39) + @ASONDT + char(39)  + ',106) and convert(datetime,' + char(39) + @ASONDT_to + char(39)  + ',106)) then isnull(billamt,0) else 0 end) ,2)) ,        
   Recvamt=convert(varchar,convert(money,sum( case  when (convert(varchar,bcldt,106) between convert(datetime,' + char(39) + @ASONDT + char(39)  + ',106) and convert(datetime,' + char(39) + @ASONDT_to + char(39)  + ',106)) then isnull(billamt,0) else 0 end) ,2)) ,        
   ToASon=convert(varchar,convert(money,sum(case when ((convert(varchar,bcldt,106) > convert(datetime,' + char(39) + @ASONDT_to + char(39)  + ',106)+0.9  or bcldt is null) and convert(varchar,bgndt,106) < convert(datetime,' + char(39) + @ASONDT_to + char(39  )  + ',106)-0.1) then isnull(billamt,0) else 0 end)      ,2))    
   ,On_AC_balance=convert(varchar,convert(money,isnull((select  isnull(sum(isnull(chqamt,0)-isnull(ADJUSTAMT,0)),0)  from webx_CHQ_DET with(NOLOCK) where '+@SELCUST_LOC_STR+'  (ADJUSTAMT<>' + char(39) +'0' + char(39) +' or ADJUSTAMT is not null) and owncust=' + char(39) +'C' + char(39) +' and ptmsptcd=custcd group by ptmsptcd),0)  ,2)),  
  Ledger_balance=(select (case when sum(isnull(debit,0))>sum(isnull(credit,0)) then convert(varchar,convert(money,sum(isnull(debit,0))-sum(isnull(credit,0))  ,2)) + ' + char(39) +' Dr' + char(39) +' else convert(varchar,convert(money,sum(isnull(credit,0))-sum(isnull(debit,0)) ,2))+ ' + char(39) +'Cr' + char(39) +' end) as ledger_balance from webx_acctrans_'+@FinYear+' with(NOLOCK) where '+@SELCUST_LOC_STR+' acccode=' + char(39) +'CDA0001' + char(39) +' and pbov_code=custcd and voucher_cancel='+ char(39) +'N'+ char(39) +' group by pbov_code)       
   from webx_billmst B with(NOLOCK)   
   inner join webx_location l on b.bbrcd=loccode  
   inner join webx_custhdr on B.ptmscd=custcd   
   where  1=1   '+@WhereCri+@WhereCust+@WhereBillTYp+'  
   group by custcd,'+@SELCUST_LOC_GRP+'custnm  
   order by custnm,'+@SELCUST_LOC_GRP+'custcd'  
 exec(@SQL)  
 END  


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

