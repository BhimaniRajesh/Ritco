if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WebxNet_BILL_Register]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WebxNet_BILL_Register]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WebxNet_MR_Register]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WebxNet_MR_Register]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

--EXEC WebxNet_BILL_Register '01 May 08','31 Jul 08','All','All','C00310001','All','8','All','All','1','0','0','Billno,PENDAMT','','','','31 July 08'

CREATE Proc WebxNet_BILL_Register
@fromdt varchar(200),
@todt varchar(200),
@RO varchar(200),
@ORGNCD varchar(200),
@CUSTCD varchar(2000),
@Bill_TYP varchar(200),
@Bill_STATuS varchar(20),
@Bill_TYP_CL varchar(20),
@bill_TYP_LIST varchar(20),
@DTTYP varchar(20),
@OVDAYS varchar(20),
@AMT varchar(20),
@Select_LIST varchar(2000),
@BillNO_LIST varchar(2000),
@MANBillNO_LIST varchar(2000),
@DOCKNO_LIST varchar(2000),
@ASONDT varchar(30),
@ASONDT_to varchar(30)
as

Declare @SQL Varchar(8000),@WhereCri_DT varchar(400),@DT_TYPE varchar(100);
Declare @WhereCri varchar(2000),@WhereCri_cust varchar(2000),@WhereCri_TYP varchar(2000),@WhereCri_DST varchar(2000);
Declare @WhereCri_MST varchar(2000),@WhereCri_L_TYP varchar(2000),@WhereCri_C_TYP varchar(2000),@WhereCri_MR_DKT varchar(2000);

select @WhereCri='',@WhereCri_cust='',@WhereCri_TYP='',@WhereCri_DST='',@WhereCri_DT=''
select @WhereCri_MST='',@WhereCri_L_TYP='',@WhereCri_C_TYP='',@WhereCri_MR_DKT=''

if @AMT=''
	select @AMT='0'

	if @DTTYP='1'
		select @DT_TYPE='bgndt'
	else if @DTTYP='2'
		select @DT_TYPE='bcldt'
	else if @DTTYP='3'
		select @DT_TYPE='Bcandt'
	else if @DTTYP='4'
		select @DT_TYPE='BSBdt'

if @BillNO_LIST<>''
	select @WhereCri_MR_DKT=' and [dbo].[SplitWithSearch]('+char(39)+@BillNO_LIST+char(39)+','+char(39)+','+char(39)+',billno)='+char(39)+'1'+char(39)+''
else if @MANBillNO_LIST<>''
	select @WhereCri_MR_DKT=' and [dbo].[SplitWithSearch]('+char(39)+@MANBillNO_LIST+char(39)+','+char(39)+','+char(39)+',manualbillno)='+char(39)+'1'+char(39)+''
else if @DOCKNO_LIST<>''
	select @WhereCri_MR_DKT=' and Billno in ( select billno from webx_billdet where  [dbo].[SplitWithSearch]('+char(39)+@DOCKNO_LIST+char(39)+','+char(39)+','+char(39)+',dockno)='+char(39)+'1'+char(39)+')'
else 
	begin
	

	
	
	select @WhereCri_DT=' and Convert(varchar,'+@DT_TYPE+',106) between Convert(datetime,'+char(39)+@fromdt+char(39)+',106) and Convert(datetime,'+char(39)+@TODT+char(39)+',106)  and '+@DT_TYPE+' is not null'

	if @RO='All' and @ORGNCD='All'  
	select @WhereCri = ''  
	else if @RO<>'All' and @ORGNCD='All'  
	select @WhereCri = ' and report_loc=' + char(39) + @RO + char(39)  
	else if @RO='All' and @ORGNCD<>'All'  
	select @WhereCri = ' and loccode= '+ char(39) + @ORGNCD + char(39)  
	else if @RO<>'All' and @ORGNCD<>'All'  
	select @WhereCri = 'and report_loc=' + char(39) + @RO + char(39) +' and loccode= '+ char(39) + @ORGNCD + char(39)  

	if @CUSTCD <>'All' 
		select @WhereCri_cust=' and [dbo].[SplitWithSearch]('+char(39)+@CUSTCD+char(39)+','+char(39)+','+char(39)+',PTmsCD)='+char(39)+'1'+char(39)+''
	else 
		select @WhereCri_cust=''

	if @bill_TYP_LIST='1'
		select @WhereCri_L_TYP=' and STAX_CESS_HCESS>0'
	else if @bill_TYP_LIST='2'
		select @WhereCri_L_TYP=' and STAX_CESS_HCESS=0'
	else 
		select @WhereCri_L_TYP=''

	if @Bill_TYP <>'All' 
		select @WhereCri_TYP=' and TYP='+ char(39) + @Bill_TYP + char(39)
	else 
		select @WhereCri_TYP=''

	--if @DKT_STATuS <>'All' 
		--select @WhereCri_DST=' and delivered='+ char(39) + @DKT_STATuS + char(39)
	--else 
		--select @WhereCri_DST=''

	if @Bill_STATuS='1'
		select @WhereCri_MST=' and BSBDT IS NOT NULL AND DATEDIFF(DAY,BDUEDT,GETDATE())>0 and  BILL_STATUS!='  + CHAR(39) + 'Bill Cancelled' +  CHAR(39) 
	else if @Bill_STATuS='2'
		select @WhereCri_MST=' and BSBDT IS NOT NULL AND DATEDIFF(DAY,BDUEDT,GETDATE())<0 and  BILL_STATUS!='  + CHAR(39) + 'Bill Cancelled' +  CHAR(39) 
	else if @Bill_STATuS='3'
		select @WhereCri_MST=' and BSBDT IS NULL AND DATEDIFF(DAY,BDUEDT,GETDATE())>0 and  BILL_STATUS!='  + CHAR(39) + 'Bill Cancelled' +  CHAR(39) 
	else if @Bill_STATuS='4'
		select @WhereCri_MST=' and BSBDT IS NULL AND DATEDIFF(DAY,BDUEDT,GETDATE())<0 and  BILL_STATUS!='  + CHAR(39) + 'Bill Cancelled' +  CHAR(39) 
	else if @Bill_STATuS='5'
		select @WhereCri_MST=' and BCLDT IS NOT NULL and  BILL_STATUS!='  + CHAR(39) + 'Bill Cancelled' +  CHAR(39) 
	else if @Bill_STATuS='6'
		select @WhereCri_MST=' and  BILL_STATUS='  + CHAR(39) + 'Bill Cancelled' +  CHAR(39)  
	else if @Bill_STATuS='7'
		select @WhereCri_MST=' and datediff(day,convert(varchar,'+@DT_TYPE+',106),convert(datetime,' + char(39) + @ASONDT + char(39)  + ',106)) < convert(varchar,0) '
	else if @Bill_STATuS='8'
		select @WhereCri_MST=' and datediff(day,convert(varchar,'+@DT_TYPE+',106),convert(datetime,' + char(39) + @ASONDT + char(39)  + ',106)) between convert(varchar,0) and  convert(varchar,30)  '
	else if @Bill_STATuS='9'
		select @WhereCri_MST=' and datediff(day,convert(varchar,'+@DT_TYPE+',106),convert(datetime,' + char(39) + @ASONDT + char(39)  + ',106)) between convert(varchar,31) and  convert(varchar,60)  '
	else if @Bill_STATuS='10'
		select @WhereCri_MST=' and datediff(day,convert(varchar,'+@DT_TYPE+',106),convert(datetime,' + char(39) + @ASONDT + char(39)  + ',106)) between convert(varchar,61) and  convert(varchar,90)  '
	else if @Bill_STATuS='11'
		select @WhereCri_MST=' and datediff(day,convert(varchar,'+@DT_TYPE+',106),convert(datetime,' + char(39) + @ASONDT + char(39)  + ',106)) between convert(varchar,91) and  convert(varchar,180)  '
	else if @Bill_STATuS='12'
		select @WhereCri_MST=' and datediff(day,convert(varchar,'+@DT_TYPE+',106),convert(datetime,' + char(39) + @ASONDT + char(39)  + ',106)) between convert(varchar,181) and  convert(varchar,365)  '
	else if @Bill_STATuS='13'
		select @WhereCri_MST=' and datediff(day,convert(varchar,'+@DT_TYPE+',106),convert(datetime,' + char(39) + @ASONDT + char(39)  + ',106)) > convert(varchar,365) '
	else if @Bill_STATuS='15'
		select @WhereCri_MST='  and  ((convert(varchar,bcldt,106)  > convert(datetime,' + char(39) + @ASONDT + char(39)  + ',106)-0.1 or  bcldt is null) and convert(varchar,bgndt,106) < convert(datetime,' + char(39) + @ASONDT + char(39  )  + ',106)-0.1)  and  BILL_STATUS!='  + CHAR(39) + 'Bill Cancelled' +  CHAR(39)
	else if @Bill_STATuS='16'
		select @WhereCri_MST='  and  (convert(varchar,bgndt,106) between convert(datetime,' + char(39) + @ASONDT + char(39)  + ',106) and convert(datetime,' + char(39) + @ASONDT_to + char(39)  + ',106))  and  BILL_STATUS!='  + CHAR(39) + 'Bill Cancelled' +  CHAR(39)
	else if @Bill_STATuS='17'
		select @WhereCri_MST='  and  (convert(varchar,bcldt,106) between convert(datetime,' + char(39) + @ASONDT + char(39)  + ',106) and convert(datetime,' + char(39) + @ASONDT_to + char(39)  + ',106))  and  BILL_STATUS!='  + CHAR(39) + 'Bill Cancelled' +  CHAR(39)	
	else if @Bill_STATuS='18'
		select @WhereCri_MST='  and  ( (convert(varchar,bcldt,106) > convert(datetime,' + char(39) + @ASONDT_to + char(39)  + ',106)+0.9  or bcldt is null) and convert(varchar,bgndt,106) < convert(datetime,' + char(39) + @ASONDT_to + char(39  )  + ',106)-0.1)  and  BILL_STATUS!='  + CHAR(39) + 'Bill Cancelled' +  CHAR(39)
	
	else 
		select @WhereCri_MST=' and  BILL_STATUS!='  + CHAR(39) + 'Bill Cancelled' +  CHAR(39)  

	--if @MR_TYP_LIST='1'
		--select @WhereCri_L_TYP=' and STAX>0'
	--else if @MR_TYP_LIST='2'
		--select @WhereCri_L_TYP=' and STAX=0'
	--else 
	--	select @WhereCri_L_TYP=''

	if @Bill_TYP_CL<>'All'
		select @WhereCri_C_TYP=' and paymode='+ char(39) + @Bill_TYP_CL + char(39)
	else 
		select @WhereCri_C_TYP=''

	
	
	end 


--select @WhereCri,@WhereCri_cust,@WhereCri_TYP,@WhereCri_DST,@WhereCri_DT,@DT_TYPE
--select @WhereCri_MST,@WhereCri_L_TYP,@WhereCri_C_TYP,@WhereCri_MR_DKT,@Select_LIST

select @SQL='select '+@Select_LIST+' from  VwNet_Bill_Register B with(NOLOCK) 
where convert(money,isnull(billamt,0),2)>'+@AMT+' '+@WhereCri+@WhereCri_cust+@WhereCri_TYP+ @WhereCri_DST+@WhereCri_MST+@WhereCri_L_TYP+@WhereCri_C_TYP+@WhereCri_MR_DKT+@WhereCri_DT+'
order by billno,'+@DT_TYPE+''


exec(@SQL)
--select @SQL
select @WhereCri,@WhereCri_cust,@WhereCri_TYP,@WhereCri_DST,@WhereCri_DT,@DT_TYPE
select @WhereCri_MST,@WhereCri_L_TYP,@WhereCri_C_TYP,@WhereCri_MR_DKT,@Select_LIST
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


--exec WebxNet_MR_Register '01 July 08','30 July 08','All','All','All','All','All','All','2','CASH','1','0','*','',''

CREATE Proc WebxNet_MR_Register
@fromdt varchar(200),
@todt varchar(200),
@RO varchar(200),
@ORGNCD varchar(200),
@CUSTCD varchar(2000),
@MR_TYP varchar(200),
@DKT_STATuS varchar(20),
@MR_STATuS varchar(20),
@MR_TYP_LIST varchar(20),
@MR_TYP_CL varchar(20),
@DTTYP varchar(20),
@AMT varchar(20),
@Select_LIST varchar(2000),
@MRNO_LIST varchar(2000),
@DOCKNO_LIST varchar(2000)
as

Declare @SQL Varchar(8000),@WhereCri_DT varchar(400),@DT_TYPE varchar(100);
Declare @WhereCri varchar(2000),@WhereCri_cust varchar(2000),@WhereCri_TYP varchar(2000),@WhereCri_DST varchar(2000);
Declare @WhereCri_MST varchar(2000),@WhereCri_L_TYP varchar(2000),@WhereCri_C_TYP varchar(2000),@WhereCri_MR_DKT varchar(2000);

select @WhereCri='',@WhereCri_cust='',@WhereCri_TYP='',@WhereCri_DST='',@WhereCri_DT=''
select @WhereCri_MST='',@WhereCri_L_TYP='',@WhereCri_C_TYP='',@WhereCri_MR_DKT=''

if @DTTYP='1'
		select @DT_TYPE='mrsdt'
	else if @DTTYP='2'
		select @DT_TYPE='finclosedt'
	else if @DTTYP='3'
		select @DT_TYPE='Bcandt'

if @AMT=''
	select @AMT='0'

if @MRNO_LIST<>''
	select @WhereCri_MR_DKT=' and [dbo].[SplitWithSearch]('+char(39)+@MRNO_LIST+char(39)+','+char(39)+','+char(39)+',mrsno)='+char(39)+'1'+char(39)+''
else if @DOCKNO_LIST<>''
	select @WhereCri_MR_DKT=' and [dbo].[SplitWithSearch]('+char(39)+@DOCKNO_LIST+char(39)+','+char(39)+','+char(39)+',dockno)='+char(39)+'1'+char(39)+''
else 
	begin
	
	
	
	
	select @WhereCri_DT=' and Convert(varchar,'+@DT_TYPE+',106) between Convert(datetime,'+char(39)+@fromdt+char(39)+',106) and Convert(datetime,'+char(39)+@TODT+char(39)+',106)  and '+@DT_TYPE+' is not null'

	if @RO='All' and @ORGNCD='All'  
	select @WhereCri = ''  
	else if @RO<>'All' and @ORGNCD='All'  
	select @WhereCri = ' and report_loc=' + char(39) + @RO + char(39)  
	else if @RO='All' and @ORGNCD<>'All'  
	select @WhereCri = ' and loccode= '+ char(39) + @ORGNCD + char(39)  
	else if @RO<>'All' and @ORGNCD<>'All'  
	select @WhereCri = 'and report_loc=' + char(39) + @RO + char(39) +' and loccode= '+ char(39) + @ORGNCD + char(39)  

	if @CUSTCD <>'All' 
		select @WhereCri_cust=' and [dbo].[SplitWithSearch]('+char(39)+@CUSTCD+char(39)+','+char(39)+','+char(39)+',PTCD)='+char(39)+'1'+char(39)+''
	else 
		select @WhereCri_cust=''

	if @MR_TYP <>'All' 
		select @WhereCri_TYP=' and TYP='+ char(39) + @MR_TYP + char(39)
	else 
		select @WhereCri_TYP=''

	if @DKT_STATuS <>'All' 
		select @WhereCri_DST=' and delivered='+ char(39) + @DKT_STATuS + char(39)
	else 
		select @WhereCri_DST=''

	if @MR_STATuS='1'
		select @WhereCri_MST=' and finclosedt is not null '
	else if @MR_STATuS='2'
		select @WhereCri_MST=' and finclosedt is  null '
	else if @MR_STATuS='3'
		select @WhereCri_MST=' and isnull(MR_CANCEL,'+char(39)+'N'+char(39)+')='+char(39)+'Y'+char(39)+' '	
	else 
		select @WhereCri_MST=''

	if @MR_TYP_LIST='1'
		select @WhereCri_L_TYP=' and STAX>0'
	else if @MR_TYP_LIST='2'
		select @WhereCri_L_TYP=' and STAX=0'
	else 
		select @WhereCri_L_TYP=''

	if @MR_TYP_CL<>'All'
		select @WhereCri_C_TYP=' and paymode='+ char(39) + @MR_TYP_CL + char(39)
	else 
		select @WhereCri_C_TYP=''

	
	
	end 

--select @WhereCri,@WhereCri_cust,@WhereCri_TYP,@WhereCri_DST
--select @WhereCri_MST,@WhereCri_L_TYP,@WhereCri_C_TYP,@WhereCri_MR_DKT

select @SQL='select '+@Select_LIST+' from  VwNet_MR_Register with(NOLOCK)
where mrsamt>'+@AMT+' '+@WhereCri+@WhereCri_cust+@WhereCri_TYP+ @WhereCri_DST+@WhereCri_MST+@WhereCri_L_TYP+@WhereCri_C_TYP+@WhereCri_MR_DKT+@WhereCri_DT+'
order by mrsno,'+@DT_TYPE+''

--select @SQL
exec(@SQL)

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VwNet_Bill_Register]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VwNet_Bill_Register]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VwNet_MR_Register]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VwNet_MR_Register]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VwNet_BILL_MR]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VwNet_BILL_MR]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE View VwNet_BILL_MR
as 
select TDS_DED=sum(isnull(TDSDEd,0)),
FRT_DED=sum(isnull(frtDED,0)),
CLM_DED=sum(isnull(CLMDED,0)),
UNE_DED=sum(isnull(UNEXPDED,0)),docno,mrsno from webx_mrdet_bill
group by docno,mrsno


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE View VwNet_Bill_Register  
as  
select report_loc,loccode,Billno,manualbillno,BillGenDT=convert(varchar,bgndt,6),BillSUBDT=convert(varchar,bsbdt,6),BillCollDT=convert(varchar,bcldt,6),bbrcd,billsubbrcd,billcolbrcd,  
TYp=(select top 1 codedesc from  webx_master_general with(NOLOCK) where codetype= 'BILLTYP' and b.paybas=codeid),  
PARTY=PTMSCD+' : '+ptmsnm,BILL_STATuS=BillSTAtus,BillDueDT=convert(varchar,BDUEDT,6),DUE_DYAS=datediff(d,BDUEDT,getdate()),  
STAX_CESS_HCESS=convert(varchar,convert(money,(isnull(svrcamt,0)+isnull(cessamt,0)+isnull(hedu_cess,0)),2)),CLAMT=convert(varchar,convert(money,isnull(CLAMT,0),2)),  
PENDAMT=convert(varchar,convert(money,isnull(PENDAMT,0),2)),billamt=convert(varchar,convert(money,isnull(billamt,0),2)),  
FRT_DED=convert(varchar,convert(money,isnull(FRT_DED,0),2)),TDS_DED=convert(varchar,convert(money,isnull(TDS_DED,0),2)),PTmsCD,BSBDT,BDUEDT,  
CLM_DED=convert(varchar,convert(money,isnull(CLM_DED,0),2)),UNE_DED=convert(varchar,convert(money,isnull(UNE_DED,0),2)),bgndt,bcldt,Bcandt,  
BCANEMPCD=isnull((select top 1 name from webx_master_users where userid=isnull(BCANEMPCD,'')),''),Bcan_dt=Convert(varchar,Bcandt,6),  
paymode=(select top 1 paymode from webx_mr_hdr with(NOLOCK) where mrsno=BM.mrsno)  ,'<b>'+billno+'</b>' as B_view
from webx_billmst b with(NOLOCK)   
inner join webx_location l on b.bbrcd=l.loccode   
left outer join  (select TDS_DED=sum(isnull(TDS_DED,0)),FRT_DED=sum(isnull(FRT_DED,0)),CLM_DED=sum(isnull(CLM_DED,0)),
UNE_DED=sum(isnull(UNE_DED,0)),docno,mrsno=(select mrsno from VwNet_BILL_MR where docno=BM.docno) from
VwNet_BILL_MR BM with(NOLOCK)  group by docno )BM   on BM.docno=B.billno  


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE View VwNet_MR_Register  
as  
select  report_loc,loccode,  M.MRSNO,M.DOCKNo,mrstype,TYP=(select top 1 codedesc from  webx_master_general with(NOLOCK) where codetype= 'mrstype' and codeid=m.mrstype),  
MR_GEN_DT=Convert(varchar,mrsdt,6),PARTY=PTCD+' : '+ptname,mrsbr,  
MRSTATUS=(case when isnull(MR_CANCEL,'N')='Y' then 'Cancelled' when finclosedt is null then 'Generated' when finclosedt is not null then 'Collected' end),  
DKT_dly=(case when isnull(ST.delivered,'N')='Y' then 'Delivered' else 'Yet Not Delivered' end),  
delivered=isnull(ST.delivered,'N'),PTCD,  
MRSAMT=isnull(MRSAMT,0),BCANEMPCD=isnull((select top 1 name from webx_master_users where userid=isnull(BCANEMPCD,'')),''),Bcan_dt=Convert(varchar,Bcandt,6),remark=isnull(remark,''),  
(case when paymode='cash'then isnull(mrscash,0) else isnull(mrschq,0) end) as Closeamt,paymode=isnull(paymode,''),  
closedt=Convert(varchar,finclosedt,6),Closedby=isnull((select top 1 name from webx_master_users where userid=isnull(finclose_empcd,'')),''),  
mrsdt,finclosedt,Bcandt,  
OT_DED=(case when mrstype='2' then 0 else isnull(deduction,0)-isnull(ded_tds,0) end ),  
FRT_DED=cast(isnull(FRT_DED,0) as decimal(9,2)),TDS_DED=cast(isnull(TDS_DED,0) as decimal(9,2)),  
CLM_DED=cast(isnull(CLM_DED,0) as decimal(9,2)),UNE_DED=cast(isnull(UNE_DED,0) as decimal(9,2)),  
STAX=(isnull(COL_STAX,0)+isnull(COL_CESS,0)+isnull(Col_h_cess,0)),MR_CANCEL  
from webx_MR_HDR M with(NOLOCK)  
inner join webx_location l on m.mrsbr=l.loccode   
left outer join webx_trans_docket_status ST with(NOLOCK) on M.dockno=ST.dockno and M.docksf=ST.docksf  
left outer join  (select TDS_DED=sum(isnull(TDS_DED,0)),FRT_DED=sum(isnull(FRT_DED,0)),CLM_DED=sum(isnull(CLM_DED,0)),
UNE_DED=sum(isnull(UNE_DED,0)),mrsno from
VwNet_BILL_MR BM with(NOLOCK)  group by mrsno )BM  on BM.MRSNO=M.MRSNO  

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FN_GET_CHQNO]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[FN_GET_CHQNO]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FN_MR_FORBILL]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[FN_MR_FORBILL]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE FUNCTION [dbo].[FN_GET_CHQNO](@DOCno varchar(80),@TYP int)
RETURNS VARCHAR(1000) AS  
BEGIN
	Declare   @CHQNO_DT varchar(250)  
	
	Declare   @CHQNO varchar(250)  
	Declare   @STR_CHQNO varchar(2500) 
	select  @STR_CHQNO =''
	if @TYP=1
	begin
	DECLARE my_cursor_1 CURSOR FOR 
		select distinct isnull(CHQNO,'') + '/' + convert(varchar,isnull(chqdt,''),6) as CHQNO from WEBX_BILLCHQDETAIL with(NOLOCK) where DOCNO= ltrim(rtrim(@DOCno))

		OPEN my_cursor_1    
		FETCH NEXT FROM my_cursor_1                 
		INTO 
		@CHQNO
		BEGIN  
			--
			 WHILE @@FETCH_STATUS = 0       
			  BEGIN 	
				if @STR_CHQNO =''
					select @STR_CHQNO=@CHQNO
				else 
					select @STR_CHQNO=@STR_CHQNO+','+@CHQNO
				
		 	 FETCH NEXT FROM my_cursor_1                 
			 INTO                 
				@CHQNO
			  END      
		END   
		CLOSE my_cursor_1                
		DEALLOCATE my_cursor_1   
	

	select @CHQNO_DT=@STR_CHQNO
	end
	else if @TYP=2
	begin 
		select  @CHQNO_DT=convert(varchar,convert(money,sum(isnull(chqamt,0)),2))  from WEBX_BILLCHQDETAIL with(NOLOCK) where DOCNO= ltrim(rtrim(@DOCno))

	end

	return @CHQNO_DT
END




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE FUNCTION [dbo].[FN_MR_FORBILL](@Billno varchar(80),@TYP int)
RETURNS VARCHAR(1000) AS  
BEGIN
	Declare   @MRNO_DT varchar(250)  
Declare   @MRNO varchar(250)  
Declare   @MRDT varchar(250)  

Declare   @STR_MRNO varchar(2500)  
	select @STR_MRNO=''
	if @TYP=1
	begin
		DECLARE my_cursor_1 CURSOR FOR 
		select  distinct m.MRSNO,convert(varchar,d.MRSDT,106)  from webx_mrdet_bill m with(NOLOCK)
		inner join webx_mr_hdr d with(NOLOCK)  on  m.mrsno=d.mrsno where DOCNO= ltrim(rtrim(@Billno))  order by m.mrsno
		
		OPEN my_cursor_1    
		FETCH NEXT FROM my_cursor_1                 
		INTO 
		@MRNO,@MRDT
		BEGIN  
			--
			 WHILE @@FETCH_STATUS = 0       
			  BEGIN 	
				if @STR_MRNO =''
					select @STR_MRNO=@MRNO
				else 
					select @STR_MRNO=@STR_MRNO+','+@MRNO
				
		 	 FETCH NEXT FROM my_cursor_1                 
			 INTO                 
				@MRNO,@MRDT
			  END      
		END   
		CLOSE my_cursor_1                
		DEALLOCATE my_cursor_1   
		
	

	end 
	else if @TYP=2
	begin
		DECLARE my_cursor_1 CURSOR FOR 
		select  distinct m.MRSNO,convert(varchar,d.MRSDT,6)  from webx_mrdet_bill m with(NOLOCK)
		inner join webx_mr_hdr d with(NOLOCK)  on  m.mrsno=d.mrsno where DOCNO= ltrim(rtrim(@Billno))  order by m.mrsno
		
		OPEN my_cursor_1    
		FETCH NEXT FROM my_cursor_1                 
		INTO 
		@MRNO,@MRDT
		BEGIN  
			--
			 WHILE @@FETCH_STATUS = 0       
			  BEGIN 	
				if @STR_MRNO =''
					select @STR_MRNO=@MRDT
				else 
					select @STR_MRNO=@STR_MRNO+','+@MRDT
				
		 	 FETCH NEXT FROM my_cursor_1                 
			 INTO                 
				@MRNO,@MRDT
			  END      
		END   
		CLOSE my_cursor_1                
		DEALLOCATE my_cursor_1   
		
	

	end 
	select @MRNO_DT=@STR_MRNO

	return @MRNO_DT
END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WebxNet_bill_dockDetails]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WebxNet_bill_dockDetails]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create Proc WebxNet_bill_dockDetails
@billno varchar(50)
as

select a.dockno,docksf,orgncd,reassign_destcd,dockdt=convert(varchar,dockdt,6),subtotal,svctax,cess,b.hedu_cess,otchg,dktchg,b.dkttot 
from webx_billdet a
inner join webx_master_docket_charges b on a.dockno=b.dockno where  billno=@billno
union 
select '','','','','Total',subtotal=sum(isnull(subtotal,0)),svctax=sum(isnull(svctax,0)),
cess=sum(isnull(cess,0)),hedu_cess=sum(isnull(b.hedu_cess,0)),otchg=sum(isnull(otchg,0)),dktchg=sum(isnull(dktchg,0)),dkttot=sum(isnull(b.dkttot,0))
from webx_billdet a
inner join webx_master_docket_charges b on a.dockno=b.dockno where  billno=@billno
order by subtotal


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
