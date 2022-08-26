if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Vw_Bill_details_net]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[Vw_Bill_details_net]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



/****** Object:  View dbo.Vw_Bill_details_net    Script Date: 11/28/2007 3:54:04 PM ******/  
CREATE view Vw_Bill_details_net  
as  
--select a.dockno,a.docksf,b.BGNDT,b.billno,b.BILL_CANCEL,b.billsubbrcd,b.billcolbrcd,b.ptmscd,b.billamt from Vw_Billdet_details a,Vw_Billmst_details b where a.billno=b.billno  
  
select a.dockno,a.docksf,b.BGNDT,b.billno,b.BILL_CANCEL,b.billsubbrcd,b.billcolbrcd,b.ptmscd,b.billamt,  
b.BSBDT,b.bcldt,b.bbrcd,b.paybas ,clamt  ,manualbillno
from webx_billdet a with(NOLOCK)  inner join webx_billmst b with(NOLOCK)  on a.billno=b.billno  
  
  
  GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO






if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_THC_Register]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_THC_Register]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE View vw_THC_Register  As                  
Select distinct thcno,thcdt,thcbr,vehno,vendor_name=(vendor_code +' : ' +vendor_name),routename=(routecd +' : ' +routename),adv_colamt,TOTALAMTPAID,  tobh_code,thc_dt=convert(varchar,thcdt,6),                
m.pcamt,advpaidat,advvoucherNo,advpaiddt=convert(varchar,advpaiddt,6),dclaim,oth_ded,incentive,penalty,  thcsf,                
bal_colamt,balpaidby,balamtbrcd,balvoucherNo,balvoucherdt=convert(varchar,balvoucherdt,6),vendorBENo,m.vendorbillNo,advpaidby,                  
PaymentDt,OPENKM,CLOSEKM,vendor_code,routecd,  tds_chrg=isnull(tds_chrg,0),              
vendtype=(select vendor_type=(select top 1 codedesc  from webx_master_general with(NOLOCK)  where  codetype='vendty' and   codeid=v.vendor_type) from webx_vendor_hdr v where vendorcode=m.vendor_code),                  
(CASE WHEN OPENKM is Null or CLOSEKM is Null THEN 0 ELSE (cast(CLOSEKM as int)-cast(OPENKM as int)) END) AS Dist,                  
 convert(varchar, (select top 1 n.actdept_dt from webx_thchdr n with(NOLOCK) where n.actarrv_dt is null and n.actarrv_tm is null and m.thcno=n.thcno),6) as dept_dt,                  
(select top 1 n.actdept_tm from webx_thchdr n with(NOLOCK) where n.actarrv_dt is null and n.actarrv_tm is null and  m.thcno=n.thcno ) as dept_tm,                  
convert(varchar,(select top 1 n.actarrv_dt from webx_thchdr n with(NOLOCK) where n.tobh_code = 'null' and m.thcno=n.thcno ) ,6)as arrv_dt,                  
(select top 1 n.actarrv_tm from webx_thchdr n  with(NOLOCK) where n.tobh_code = 'null' and m.thcno=n.thcno ) as arrv_tm ,                  
(select count(dockno) from VW_THC_TC_Dockets n with(NOLOCK) where m.thcno=n.thcno) as Total_docket,                  
(select sum(d.freight) from VW_THC_TC_Dockets n with(NOLOCK) inner join webx_master_docket_charges d with(NOLOCK)  on m.thcno=n.thcno and d.dockno=n.dockno) as Total_freight_dkt,                  
(Select Sum(loadactuwt) From VW_THC_TC_Dockets with(NOLOCK)    where thcno=m.thcno  )  as MyActualWt,                  
capacity=(select isnull(payload,0) from webx_vehicle_hdr with(NOLOCK) where vehno=m.vehno),                  
billno,billdt=(convert(varchar,billdt,106)),othamt,billamt=netamt,voucherno                  
,tripsheetno,manualthcno,l_f.loccode as f_loccode, l_f.locname as f_locname,l_f.report_loc as f_report_loc                  
,l_t.loccode as t_loccode, l_t.locname as t_locname,l_t.report_loc as t_report_loc                  
,l_f.loccode as from_loccode,l_f.report_loc as from_report_loc,m.advamt  ,netbalamt            
,l_t.loccode as to_loccode,l_t.report_loc as to_report_loc  ,THCClose_Mode    ,load_chrg   ,THCNew_mode,     
m.advamt_lastpaid,m.cancelled        
from webx_thc_summary m with(NOLOCK)                   
left outer join webx_vendorBill_hdr vb with(NOLOCK)  on m.vendorBENo=vb.billno                  
Inner Join Webx_location l_f With(NOLOCK) On m.thcbr=l_f.loccode                  
Inner Join Webx_location l_t With(NOLOCK) On m.tobh_code=l_t.loccode    

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VW_THC_TC_Dockets_Veh]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VW_THC_TC_Dockets_Veh]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE view  [dbo].[VW_THC_TC_Dockets_Veh]          
as          
select distinct thcno,b.tcbr,thcsf,b.tcno,b.tcsf,dockno,docksf,thcbr,thcdt,b.tcdt,route_code,loadactuwt,    
arrived_yn=isnull(arrived_yn,'N') ,CANCELLED  ,VEHNO=(select top 1 vehno from webx_thc_summary with(NOLOCK) where thcno=b.thcno )  
from webx_tctrn a      with(NOLOCK)      
inner join webx_tchdr b  with(NOLOCK)  on a.tcno=b.tcno   

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[webx_SALES_REGISTER_RPT]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[webx_SALES_REGISTER_RPT]
GO

CREATE TABLE [dbo].[webx_SALES_REGISTER_RPT] (
	[dockno] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[dockdt] [datetime] NULL ,
	[orgncd] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[destcd] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Curr_loc] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[nextloc] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[from_loc] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[to_loc] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Paybas_st] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[trn_mod_st] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Service_class_st] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[loadtype] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[businesstype] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Cnor] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Cnee] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BACode] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[PkgsNo] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Actuwt] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ChrgWt] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Yield] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FRT_Rate] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[subtotal] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[svctax] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Cess] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[hedu_cess] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[dkttot] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Delivered] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Dely_Date] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MR] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Docket_mode] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Pickup_Dely] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OCTROIMR] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[billed] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Cancelled] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[spl_svc_req] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[csgnnm] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[csgecd] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[csgncd] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[VEHNO] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG01] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG02] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG03] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG04] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG05] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG06] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG07] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG08] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG09] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG10] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG11] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG12] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG13] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG14] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG15] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG16] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG17] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG18] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG19] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG20] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG21] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG22] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG23] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG24] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG25] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG26] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG27] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG28] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG29] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG30] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG31] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG32] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SCHG33] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UCHG01] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UCHG02] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UCHG03] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UCHG04] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UCHG05] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UCHG06] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UCHG07] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UCHG08] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UCHG09] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UCHG010] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[invno] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[invdt] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[invamt] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[PFMno] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MRSNo] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[mrsdt] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BillNo] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[bgndt] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[party_code] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[fincmplbr] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[billsubbrcd] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[billcolbrcd] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BillAmt] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[paybas] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[trn_mod] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Service_class] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[f_locname] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[t_locname] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[from_loccode] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[from_report_loc] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[to_loccode] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[to_report_loc] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[webx_OPN_DOC_Register_ver1]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[webx_OPN_DOC_Register_ver1]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE procedure [dbo].[webx_OPN_DOC_Register_ver1]
@Fromdt varchar(100),
@todt varchar(100),
@fromRo varchar(100),
@fromloc varchar(100),
@toRo varchar(100),
@toloc varchar(100),
@Selectitem varchar(8000),
@paybas varchar(100),
@trnmod varchar(100),
@type varchar(100),
@status varchar(8000),
@BUSTYP varchar(80),
@custcode varchar(8000),
@docklist varchar(8000),
@Select_view varchar(100),
@Doc_typ varchar(100)
As
declare @sql varchar(8000);
declare @wherepaybas varchar(8000);
declare @wheremode varchar(8000);
declare @wheretype varchar(8000);
declare @whereBUStype varchar(8000);
declare @wherestatus varchar(8000);
declare @wherecust varchar(8000);
declare @whereCri varchar(8000);
declare @whereCriTo varchar(8000);

if @fromRo='All' and @fromloc='All'
select @whereCri = ''
else if @fromRo<>'All' and @fromloc='All'
select @whereCri = ' and d.from_report_loc=' + char(39) + @fromRo + char(39)
else if @fromRo<>'All' and @fromloc<>'All'
select @whereCri = ' and d.from_loccode= '+ char(39) + @fromloc + char(39)
else if @fromRo='All' and @fromloc<>'All'
select @whereCri = 'and d.from_loccode= '+ char(39) + @fromloc + char(39)

if @toRo='All' and @toloc='All'
select @whereCriTo = ''
else if @toRo<>'All' and @toloc='All'
select @whereCriTo = ' and d.to_report_loc=' + char(39) + @toRo + char(39)
else if @toRo<>'All' and @toloc<>'All'
select @whereCriTo = ' and d.to_loccode= '+ char(39) + @toloc + char(39)
else if @toRo='All' and @toloc<>'All'
select @whereCriTo = 'and d.to_loccode= '+ char(39) + @toloc + char(39)

if @paybas<>'All'
select @wherepaybas=' and paybas=' + char(39) + @paybas + char(39)
else
select @wherepaybas=''

if @BUSTYP<>'All'
select @whereBUStype=' and businesstype=' + char(39) + @BUSTYP + char(39)
else
select @whereBUStype=''


if @trnmod<>'All'
select @wheremode=' and trn_mod=' + char(39) + @trnmod + char(39)
else
select @wheremode=' AND 1=1'

if @type<>'All'
select @wheretype=' and service_class=' + char(39) + @type + char(39)
else
select @wheretype=' AND 1=1'

if @custcode<>''
select @wherecust=' and (csgncd=' + char(39) + @custcode + char(39) +' or party_code=' + char(39) + @custcode + char(39) +' or csgecd=' + char(39) + @custcode + char(39) +' )'
else if @custcode='All'
select @wherecust=' AND 1=1'
else
select @wherecust=' AND 1=1'



if @status='1'
select @wherestatus=' and Docket_mode=' + char(39) + 'F' + char(39) +' and isnull(Cancelled,' + char(39) + 'N' + char(39) +' )=' + char(39) + 'N' + char(39)
else if @status='2'
select @wherestatus=' and billed=' + char(39) + 'Y' + char(39) +' and isnull(Cancelled,' + char(39) + 'N' + char(39) +' )=' + char(39) + 'N' + char(39)
else if @status='3'
select @wherestatus=' and (billed<>' + char(39) + 'Y' + char(39) +' or billed is null ) and (Paybas=' + char(39) + 'p02' + char(39) +' or Paybas=' + char(39) + 'p08' + char(39) +' or Paybas=' + char(39) + 'p09' + char(39) +' ) and isnull(Cancelled,' + char(39) + 'N' + char(39) +' )=' + char(39) + 'N' + char(39)
else if @status='4'
select @wherestatus=' and (MR<>' + char(39) + 'Y' + char(39) +' or MR<>' + char(39) + 'Y' + char(39) +' or MR<>' + char(39) + 'Y' + char(39) +' or OCTROIMR<>' + char(39) + 'Y' + char(39) +' or MR<>' + char(39) + 'Y' + char(39) +' ) and isnull(Cancelled,' + char(39) + 'N' + char(39) +' )=' + char(39) + 'N' + char(39)
else if @status='5'
select @wherestatus=' and (MR=' + char(39) + 'Y' + char(39) +' or MR=' + char(39) + 'Y' + char(39) +' or MR=' + char(39) + 'Y' + char(39) +' or OCTROIMR=' + char(39) + 'Y' + char(39) +' or MR=' + char(39) + 'Y' + char(39) +') and isnull(Cancelled,' + char(39) + 'N' + char(39) +' )=' + char(39) + 'N' + char(39)
else if @status='6'
select @wherestatus=' '--and OCTROI=' + char(39) + 'Y' + char(39) +' and Cancelled=' + char(39) + 'N' + char(39)
else if @status='7'
select @wherestatus=' '--and (OCTROI<>' + char(39) + 'Y' + char(39) +' or OCTROI is null ) and Cancelled=' + char(39) + 'N' + char(39)
else if @status='8'
select @wherestatus=' and delivered=' + char(39) + 'Y' + char(39) +' and isnull(Cancelled,' + char(39) + 'N' + char(39) +' )=' + char(39) + 'N' + char(39)
else if @status='9'
select @wherestatus=' and (delivered<>' + char(39) + 'Y' + char(39) +' or delivered is null ) and isnull(Cancelled,' + char(39) + 'N' + char(39) +' )=' + char(39) + 'N' + char(39)
else if @status='10'
select @wherestatus=' and (Docket_mode=' + char(39) + 'Q' + char(39) +' ) and isnull(Cancelled,' + char(39) + 'N' + char(39) +' )=' + char(39) + 'N' + char(39)
else if @status='11'
select @wherestatus=' and Docket_mode<>' + char(39) + 'F' + char(39) +' and isnull(Cancelled,' + char(39) + 'N' + char(39) +' )=' + char(39) + 'N' + char(39)
else if @status='12'
select @wherestatus=' and Pickup_Dely=' + char(39) + '4' + char(39) +' and isnull(Cancelled,' + char(39) + 'N' + char(39) +' )=' + char(39) + 'N' + char(39)
else if @status='13'
select @wherestatus=' and Pickup_Dely=' + char(39) + '3' + char(39) +' and isnull(Cancelled,' + char(39) + 'N' + char(39) +' )=' + char(39) + 'N' + char(39)
else if @status='14'
select @wherestatus=' and Pickup_Dely=' + char(39) + '1' + char(39) +' and isnull(Cancelled,' + char(39) + 'N' + char(39) +' )=' + char(39) + 'N' + char(39)
else if @status='15'
select @wherestatus=' and Pickup_Dely=' + char(39) + '2' + char(39) +' and isnull(Cancelled,' + char(39) + 'N' + char(39) +' )=' + char(39) + 'N' + char(39)
else if @status='16'
select @wherestatus=' and Cancelled=' + char(39) + 'Y' + char(39)
else if @status='All'
select @wherestatus=' and isnull(Cancelled,' + char(39) + 'N' + char(39) +' )=' + char(39) + 'N' + char(39)


--,convert(varchar,dockdt,106) as dockdt, orgncd ,paybas,Docket_mode,trn_mod -- order by DocketDate,origin,docketno

if @Doc_typ='DKT'
begin
if @docklist=''
begin
select @sql ='select ' +@Selectitem+' from ' + @Select_view +' d with(NOLOCK)
where 1=1 '+@wherepaybas + @wheremode + @wheretype+ @wherestatus + @wherecust +@whereCriTo + @whereCri +' and
Convert(varchar,d.dockdt,106) between Convert(datetime,' + char(39) + @Fromdt + char(39) + ',106) and Convert(datetime,' + char(39) + @todt + char(39) + ',106) --and docksf=' + char(39) + '.' + char(39) + '
order by dockdt ,orgncd,dockno'
end
else
begin
Select @sql = 'select ' + @Selectitem + ' from ' + @Select_view +' d with(NOLOCK) where patindex('
Select @sql = @sql + '''' + '%' + '''' + '+dockno+' + '''' + '%' + '''' + ','
Select @sql = @sql + '''' + @docklist + '''' + ')<>0'
end
end

else if @Doc_typ='THC'
begin

if @trnmod<>'All'
select @wheremode=' and routecd=' + char(39) + @trnmod + char(39)
else
select @wheremode=' AND 1=1'

if @status='1'
select @wherestatus=' and THCNew_mode=' + char(39) + 'F' + char(39) +''
else if @status='2'
select @wherestatus=' and Adv_colamt > 0'
else if @status='3'
select @wherestatus=' and vendorBEno is not null'
else if @status='4'
select @wherestatus=' and THCClose_Mode=' + char(39) +'F' + char(39) +' or paymentDt is not null and balvoucherNo is not null '
else if @status='All'
select @wherestatus=' and 1=1 '

if @custcode<>'All'
select @wherecust=' and (vendor_code=' + char(39) + @custcode + char(39) +' )'
else
select @wherecust=' AND 1=1'


if @docklist=''
begin
select @sql ='select ' +@Selectitem+' from vw_THC_Register d with(NOLOCK)
where 1=1 '+ @wheremode + @wherestatus + @wherecust + @whereCriTo + @whereCri +' and
Convert(varchar,d.thcdt,106) between Convert(datetime,' + char(39) + @Fromdt + char(39) + ',106) and Convert(datetime,' + char(39) + @todt + char(39) + ',106)
order by thcdt,thcbr,thcno'
end
else
begin
Select @sql = 'select ' + @Selectitem + ' from vw_THC_Register d with(NOLOCK) where patindex('
Select @sql = @sql + '''' + '%' + '''' + '+thcno+' + '''' + '%' + '''' + ','
Select @sql = @sql + '''' + @docklist + '''' + ')<>0'
end
end

else if @Doc_typ='PRS'
begin

if @custcode=''
select @wherecust='AND 1=1 and pdcty=' + char(39) + 'P' + char(39) +''
else if @custcode<>'All'
select @wherecust=' and (vendorcode=' + char(39) + @custcode + char(39) +' and pdcty=' + char(39) + 'P' + char(39) +')'
else
select @wherecust=' AND 1=1 and pdcty=' + char(39) + 'P' + char(39) +''
if @docklist=''
begin
select @sql ='select ' +@Selectitem+' from vw_PRS_DRS_Register d with(NOLOCK)
where 1=1 '+ @wherecust +@whereCriTo + @whereCri +' and
Convert(varchar,pdcdt,106) between Convert(datetime,' + char(39) + @Fromdt + char(39) + ',106) and Convert(datetime,' + char(39) + @todt + char(39) + ',106)
order by pdcdt,pdcbr,pdcno'
end
else
begin
Select @sql = 'select ' + @Selectitem + ' from vw_PRS_DRS_Register d with(NOLOCK) where patindex('
Select @sql = @sql + '''' + '%' + '''' + '+pdcno+' + '''' + '%' + '''' + ','
Select @sql = @sql + '''' + @docklist + '''' + ')<>0'
end
end

else if @Doc_typ='DRS'

begin

if @custcode=''
select @wherecust='AND 1=1 and pdcty=' + char(39) + 'D' + char(39) +''
else if @custcode<>'All'
select @wherecust=' and (vendorcode=' + char(39) + @custcode + char(39) +' and pdcty=' + char(39) + 'D' + char(39) +')'
else
select @wherecust=' AND 1=1 and pdcty=' + char(39) + 'D' + char(39) +''
if @docklist=''
begin
select @sql ='select ' +@Selectitem+' from vw_PRS_DRS_Register d with(NOLOCK)
where 1=1 '+ @wherecust +@whereCriTo + @whereCri +' and
Convert(varchar,pdcdt,106) between Convert(datetime,' + char(39) + @Fromdt + char(39) + ',106) and Convert(datetime,' + char(39) + @todt + char(39) + ',106)
order by pdcdt,pdcbr,pdcno'
print 'SQLLLL-->' + @sql
end
else
begin
Select @sql = 'select ' + @Selectitem + ' from vw_PRS_DRS_Register d with(NOLOCK) where patindex('
Select @sql = @sql + '''' + '%' + '''' + '+pdcno+' + '''' + '%' + '''' + ','
Select @sql = @sql + '''' + @docklist + '''' + ')<>0'
end
end

--select @Selectitem
--select @wherepaybas
--select @Select_view
--select @wheremode
--select @wheretype
--select @wherestatus
--select @sql
exec(@sql)

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VW_SALES_PFM]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VW_SALES_PFM]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE View VW_SALES_PFM  
as  
select   (FM_NO +' : '+convert(varchar,FM_date,6)) as FMNO ,FM_date,dockno as dkt  
from WebX_FM_FWD_DOC_Master A With(NOLOCK)  
inner join WebX_FM_FWD_DOC_Detail B With(NOLOCK) on a.ID=b.HDR_ID  


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Docket_Sales_register]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Docket_Sales_register]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Docket_Sales_register_All]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Docket_Sales_register_All]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Docket_Sales_register_BIll]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Docket_Sales_register_BIll]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Docket_Sales_register_MR]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Docket_Sales_register_MR]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE  view  vw_Docket_Sales_register    
As    
Select D.DOCKNO AS DocketNo,convert(varchar,D.DOCKDT,106) As DocketDate,D.ORGNCD As Origin,D.DESTCD as Destination,    
paybasstr=(select top 1  codedesc from webx_master_general where codetype='PAYTYP' and codeid=D.paybas),
trnmodstr=(select top 1 codedesc from webx_master_general where codetype='TRN' and codeid=d.trn_mod),    
(select codedesc from webx_master_general where  codetype='SVCTYP' and codeid=d.Service_class) as BookingType,
loadtype=(select codedesc from webx_master_general where  codetype='LOT' and codeid=d.loadtype), 
businesstype=(select codedesc from webx_master_general where  codetype='BOT' and codeid=d.businesstype),
PROD_str=(select codedesc from webx_master_general where  codetype='PROD' and codeid=d.PRODcd),
D.DOCKNO,s.DOCKSF,DOCKDT,ORGNCD,DESTCD,REASSIGN_DESTCD,from_loc,to_loc,dly_loc,CDELDT,PAYBAS,PKGSNO,ACTUWT,CHRGWT,PRODCD    
,spl_svc_req,stax_paidby,stax_regno,Service_Class,ftl_types,fincmplbr,CSGNCD,CSGNNM,CSGNADDR,CSGNCity,CSGNPinCode,    
CSGNTeleNo,CSGNEmail,CSGECD,CSGENM,CSGEADDR,CSGECity,CSGEPinCode,CSGETeleNo,CSGEEmail,PARTY_CODE,privatemark    
,tpnumber,TRN_MOD,CFT_YN,DIPLOMAT ,DACC_YN,LocalCN_YN,Part,Pickup_Dely,UGC,permit_yn, permit_recvd_at,permitdt     
,permit_recvd_dt,Permit_No,permit_validity_dt,DOCKDT_Entry,ENTRYBY,LastEditDate,LastEditBy ,Curr_Loc as doc_curloc,    
dktMODE=(case when docket_mode='F' then 'Financial' when docket_mode='Q' then 'Quick' end), 

BACode=BACode,--(select top 1 BA_Employee + ' - '+ BA_Employee_name  from   VW_docket_BA_Employee where  D.dockno between  doc_sr_from and doc_sr_to),
(case when (chrgwt=0 or chrgwt is  null ) then 0 else (cast((dkttot-(cess+svctax+hedu_cess))/chrgwt as decimal(9,2) ))  end) as Yield,
--Cnor Cnee    
CSGNCD+':' +(case  when CSGNCD='8888' then CSGNNM else (select top 1 custnm from webx_custhdr  with(NOLOCK) where custcd=d.csgncd) end ) as Cnor,    
CSGeCD+':' +(case  when CSGeCD='8888' then CSGeNM else (select top 1 custnm from webx_custhdr   with(NOLOCK)  where custcd=d.csgecd) end ) as Cnee,    
--Docket Charges    
docket=d.dockno+s.docksf,  hedu_cess,  
RATE_TYPE,FRT_RATE,FREIGHT_CALC,FREIGHT,FOV,SCHG01,SCHG02,SCHG03,SCHG04,SCHG05,SCHG06,SCHG07,SCHG08,SCHG09,SCHG10     
,SCHG11,SCHG12,SCHG13,SCHG14,SCHG15,SCHG16,SCHG17,SCHG18,SCHG19,SCHG20,SCHG21,SCHG22,SCHG23,UCHG01,UCHG02,UCHG03    
,UCHG04,UCHG05,UCHG06,UCHG07,UCHG08,UCHG09,UCHG10,SubTotal,SVCTAX,CESS,DKTTOT as dkttot,cess_svctax=(cess+svctax),  
invno,invdt,invamt,
--Docket Charges    
Docket_Mode,Curr_Loc,NextLoc,Billed,MR,OctroiMR,LS,MF,THC,PRS,DRS,Delivered,Dely_Date,Cancelled,CancelledBy,CancelledOn    
,Op_Status,ArrPkgQty,ArrWeightQty,DelPkgQty,DelWeightQty,PendPkgQty,PendWeightQty,    
(select case when d.paybas='P09' then party_code When d.paybas='P08' then party_code   When d.paybas='P02' then party_code  When d.paybas='P01 ' then csgncd When d.paybas='P03 ' then csgecd  else csgncd  end) as Party     
,l_f.loccode as f_loccode, l_f.locname as f_locname,l_f.report_loc as f_report_loc    
,l_t.loccode as t_loccode, l_t.locname as t_locname,l_t.report_loc as t_report_loc    
,l_f.loccode as from_loccode,l_f.report_loc as from_report_loc    
,l_t.loccode as to_loccode,l_t.report_loc as to_report_loc    
from WebX_Master_Docket D With(NOLOCK)     
Inner join WebX_Master_Docket_Charges C  With(NOLOCK)  on D.dockno=C.dockno    
Inner join WebX_Trans_Docket_Status S  With(NOLOCK)  on D.dockno=S.dockno --and D.docksf=S.docksf    
Inner Join Webx_location l_f With(NOLOCK) On D.orgncd=l_f.loccode    
Inner Join Webx_location l_t With(NOLOCK) On D.reassign_destcd=l_t.loccode    


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE view  vw_Docket_Sales_register_All  
As  
Select D.DOCKNO AS DocketNo,convert(varchar,D.DOCKDT,106) As DocketDate,D.ORGNCD As Origin,D.DESTCD as Destination,  
D.DOCKNO,D.DOCKSF,DOCKDT,ORGNCD,DESTCD,REASSIGN_DESTCD,from_loc,to_loc,dly_loc,CDELDT,d.PAYBAS,PKGSNO,ACTUWT,CHRGWT,PRODCD  
,spl_svc_req,stax_paidby,stax_regno,Service_Class,ftl_types,fincmplbr,CSGNCD,CSGNNM,CSGNADDR,CSGNCity,CSGNPinCode,  
CSGNTeleNo,CSGNEmail,CSGECD,CSGENM,CSGEADDR,CSGECity,CSGEPinCode,CSGETeleNo,CSGEEmail,PARTY_CODE,privatemark  
,tpnumber,TRN_MOD,CFT_YN,DIPLOMAT ,DACC_YN,LocalCN_YN,Part,Pickup_Dely,UGC,permit_yn, permit_recvd_at,permitdt   
,permit_recvd_dt,Permit_No,permit_validity_dt,DOCKDT_Entry,ENTRYBY,LastEditDate,LastEditBy ,  
invno,invdt,invamt,
--Cnor Cnee  
CSGNCD+':' +(case  when CSGNCD='8888' then CSGNNM else (select top 1 custnm from webx_custhdr  with(NOLOCK) where custcd=d.csgncd) end ) as Cnor,  
CSGeCD+':' +(case  when CSGeCD='8888' then CSGeNM else (select top 1 custnm from webx_custhdr   with(NOLOCK)  where custcd=d.csgecd) end ) as Cnee,  
--Docket Charges  
RATE_TYPE,FRT_RATE,FREIGHT_CALC,FREIGHT,FOV,SCHG01,SCHG02,SCHG03,SCHG04,SCHG05,SCHG06,SCHG07,SCHG08,SCHG09,SCHG10   
,SCHG11,SCHG12,SCHG13,SCHG14,SCHG15,SCHG16,SCHG17,SCHG18,SCHG19,SCHG20,SCHG21,SCHG22,SCHG23,UCHG01,UCHG02,UCHG03  
,UCHG04,UCHG05,UCHG06,UCHG07,UCHG08,UCHG09,UCHG10,SubTotal,SVCTAX,CESS,DKTTOT as dkttot,cess_svctax=(cess+svctax),  
paybasstr=(select top 1  codedesc from webx_master_general with(NOLOCK) where codetype='PAYTYP' and codeid=D.paybas),
trnmodstr=(select top 1 codedesc from webx_master_general with(NOLOCK) where codetype='TRN' and codeid=d.trn_mod),    
(select codedesc from webx_master_general with(NOLOCK) where  codetype='SVCTYP' and codeid=d.Service_class) as BookingType,
loadtype=(select codedesc from webx_master_general with(NOLOCK) where  codetype='LOT' and codeid=d.loadtype), 
businesstype=(select codedesc from webx_master_general with(NOLOCK) where  codetype='BOT' and codeid=d.businesstype),
PROD_str=(select codedesc from webx_master_general where  codetype='PROD' and codeid=d.PRODcd),
BACode=BACode,--(select top 1 BA_Employee + ' - '+ BA_Employee_name  from   VW_docket_BA_Employee where  D.dockno between  doc_sr_from and doc_sr_to),
(case when (chrgwt=0 or chrgwt is  null ) then 0 else (cast((dkttot-(cess+svctax+hedu_cess))/chrgwt as decimal(9,2) ))  end) as Yield,
octroibill as octribill,manualbillno,
--Docket Charges  
Docket_Mode,Curr_Loc,NextLoc,Billed,MR,OctroiMR,LS,MF,THC,PRS,DRS,Delivered,Dely_Date,Dely_Date as dely_dt ,Cancelled,CancelledBy,CancelledOn  
,Op_Status,ArrPkgQty,ArrWeightQty,DelPkgQty,DelWeightQty,PendPkgQty,PendWeightQty,  mrs_closed,mrstype,
(select case when d.paybas='P09' then party_code When d.paybas='P08' then party_code   When d.paybas='P02' then party_code  When d.paybas='P01 ' then csgncd When d.paybas='P03 ' then csgecd  else csgncd  end) as Party   
,VBD.billno as billno,  bcldt,hedu_cess,
Curr_Loc as doc_curloc,  
VBD.bgndt as bgndt,VBD.Billsubbrcd as Billsubbrcd ,VBD.BillColbrcd as BillColbrcd  
,VMD.MRSNO as MRSNO ,VMD.MRSDT As MRSDT  ,mrsbr,BillAmt,--octroibill as octribill,
dept_dt=(select top 1 atad from  WebX_Trans_Docket_Track with(NOLOCK)  where In_Out='O' and dockno=D.dockno order by atad desc),            
Arrv_dt=(select top 1    atad  from  WebX_Trans_Docket_Track with(NOLOCK) where  In_Out='I'  and dockno=D.dockno order by atad desc),    
l_f.loccode as f_loccode, l_f.locname as f_locname,l_f.report_loc as f_report_loc  
,l_t.loccode as t_loccode, l_t.locname as t_locname,l_t.report_loc as t_report_loc  
,l_f.loccode as from_loccode,l_f.report_loc as from_report_loc  
,l_t.loccode as to_loccode,l_t.report_loc as to_report_loc  
from WebX_Master_Docket D With(NOLOCK)   
Inner join WebX_Master_Docket_Charges C  With(NOLOCK)  on D.dockno=C.dockno  
Inner join WebX_Trans_Docket_Status S  With(NOLOCK)  on D.dockno=S.dockno and D.docksf=S.docksf  
Left Outer Join Vw_MR_details_net VMD with(NOLOCK) On D.dockno = VMD.dockno-- and VMD.MR_CANCEL='N'  and mrstype in ('1','3')  
Left Outer Join Vw_Bill_details_net VBD with(NOLOCK) On D.dockno = VBD.dockno and VBD.BILL_CANCEL='N' and vbd.paybas<>'6'  
--Left Outer Join   webx_custhdr g with(NOLOCK) On p.csgncd=g.custcd  
Inner Join Webx_location l_f With(NOLOCK) On D.orgncd=l_f.loccode  
Inner Join Webx_location l_t With(NOLOCK) On D.reassign_destcd=l_t.loccode  


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO






/****** Object:  View dbo.vw_Docket_Sales_register_BIll    Script Date: 11/28/2007 3:54:07 PM ******/
CREATE  view  vw_Docket_Sales_register_BIll
As
Select D.DOCKNO AS DocketNo,convert(varchar,D.DOCKDT,106) As DocketDate,D.ORGNCD As Origin,D.DESTCD as Destination,
D.DOCKNO,D.DOCKSF,DOCKDT,ORGNCD,DESTCD,REASSIGN_DESTCD,from_loc,to_loc,dly_loc,CDELDT,d.PAYBAS,PKGSNO,ACTUWT,CHRGWT,PRODCD
,spl_svc_req,stax_paidby,stax_regno,Service_Class,ftl_types,fincmplbr,CSGNCD,CSGNNM,CSGNADDR,CSGNCity,CSGNPinCode,
CSGNTeleNo,CSGNEmail,CSGECD,CSGENM,CSGEADDR,CSGECity,CSGEPinCode,CSGETeleNo,CSGEEmail,PARTY_CODE,privatemark
,tpnumber,TRN_MOD,CFT_YN,DIPLOMAT ,DACC_YN,LocalCN_YN,Part,Pickup_Dely,UGC,permit_yn, permit_recvd_at,permitdt 
,permit_recvd_dt,Permit_No,permit_validity_dt,DOCKDT_Entry,ENTRYBY,LastEditDate,LastEditBy ,manualbillno,
--Cnor Cnee
--invno,invdt,invamt,
CSGNCD+':' +(case  when CSGNCD='8888' then CSGNNM else (select top 1 custnm from webx_custhdr  with(NOLOCK) where custnm=d.csgncd) end ) as Cnor,
CSGeCD+':' +(case  when CSGeCD='8888' then CSGeNM else (select top 1 custnm from webx_custhdr   with(NOLOCK)  where custnm=d.csgecd) end ) as Cnee,
--Docket Charges
RATE_TYPE,FRT_RATE,FREIGHT_CALC,FREIGHT,FOV,SCHG01,SCHG02,SCHG03,SCHG04,SCHG05,SCHG06,SCHG07,SCHG08,SCHG09,SCHG10 
,SCHG11,SCHG12,SCHG13,SCHG14,SCHG15,SCHG16,SCHG17,SCHG18,SCHG19,SCHG20,SCHG21,SCHG22,SCHG23,UCHG01,UCHG02,UCHG03
,UCHG04,UCHG05,UCHG06,UCHG07,UCHG08,UCHG09,UCHG10,SubTotal,SVCTAX,CESS,DKTTOT as dkttot,cess_svctax=(cess+svctax),
paybasstr=(select top 1  codedesc from webx_master_general where codetype='PAYTYP' and codeid=D.paybas),
trnmodstr=(select top 1 codedesc from webx_master_general where codetype='TRN' and codeid=d.trn_mod),    
(select codedesc from webx_master_general where  codetype='SVCTYP' and codeid=d.Service_class) as BookingType,
loadtype=(select codedesc from webx_master_general where  codetype='LOT' and codeid=d.loadtype), 
businesstype=(select codedesc from webx_master_general where  codetype='BOT' and codeid=d.businesstype),
PROD_str=(select codedesc from webx_master_general where  codetype='PROD' and codeid=d.PRODcd),
BACode=BACode,--(select top 1 BA_Employee + ' - '+ BA_Employee_name  from   VW_docket_BA_Employee where  D.dockno between  doc_sr_from and doc_sr_to),
(case when (chrgwt=0 or chrgwt is  null ) then 0 else (cast((dkttot-(cess+svctax+hedu_cess))/chrgwt as decimal(9,2) ))  end) as Yield,
invno,invdt,invamt,
--Docket Charges
Docket_Mode,Curr_Loc,NextLoc,Billed,MR,OctroiMR,LS,MF,THC,PRS,DRS,Delivered,Dely_Date,Cancelled,CancelledBy,CancelledOn
,Op_Status,ArrPkgQty,ArrWeightQty,DelPkgQty,DelWeightQty,PendPkgQty,PendWeightQty,
(select case when d.paybas='P09' then party_code When d.paybas='P08' then party_code   When d.paybas='P02' then party_code  When d.paybas='P01 ' then csgncd When d.paybas='P03 ' then csgecd  else csgncd  end) as Party 
,VBD.billno as billno,hedu_cess,
VBD.bgndt as bgndt,VBD.Billsubbrcd as Billsubbrcd ,VBD.BillColbrcd as BillColbrcd
,l_f.loccode as f_loccode, l_f.locname as f_locname,l_f.report_loc as f_report_loc
,l_t.loccode as t_loccode, l_t.locname as t_locname,l_t.report_loc as t_report_loc
from WebX_Master_Docket D With(NOLOCK) 
Inner join WebX_Master_Docket_Charges C  With(NOLOCK)  on D.dockno=C.dockno
Inner join WebX_Trans_Docket_Status S  With(NOLOCK)  on D.dockno=S.dockno and D.docksf=S.docksf
--Left Outer Join Vw_Bill_details_net VMD with(NOLOCK) On D.dockno = VMD.dockno-- and VMD.MR_CANCEL='N'  and mrstype in ('1','3')
Left Outer Join Vw_Bill_details_net VBD with(NOLOCK) On D.dockno = VBD.dockno and VBD.BILL_CANCEL='N' and vbd.paybas<>'6'
--Left Outer Join   webx_custhdr g with(NOLOCK) On p.csgncd=g.custcd
Inner Join Webx_location l_f With(NOLOCK) On D.orgncd=l_f.loccode
Inner Join Webx_location l_t With(NOLOCK) On D.destcd=l_t.loccode




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/****** Object:  View dbo.vw_Docket_Sales_register_MR    Script Date: 11/28/2007 3:54:05 PM ******/
CREATE view  vw_Docket_Sales_register_MR
As
Select D.DOCKNO AS DocketNo,convert(varchar,D.DOCKDT,106) As DocketDate,D.ORGNCD As Origin,D.DESTCD as Destination,
paybasstr=(select top 1  codedesc from webx_master_general where codetype='PAYTYP' and codeid=D.paybas),
trnmodstr=(select top 1 codedesc from webx_master_general where codetype='TRN' and codeid=d.trn_mod),    
(select codedesc from webx_master_general where  codetype='SVCTYP' and codeid=d.Service_class) as BookingType,
loadtype=(select codedesc from webx_master_general where  codetype='LOT' and codeid=d.loadtype), 
businesstype=(select codedesc from webx_master_general where  codetype='BOT' and codeid=d.businesstype),
PROD_str=(select codedesc from webx_master_general where  codetype='PROD' and codeid=d.PRODcd),
D.DOCKNO,D.DOCKSF,DOCKDT,ORGNCD,DESTCD,REASSIGN_DESTCD,from_loc,to_loc,dly_loc,CDELDT,d.PAYBAS,PKGSNO,ACTUWT,CHRGWT,PRODCD
,spl_svc_req,stax_paidby,stax_regno,Service_Class,ftl_types,fincmplbr,CSGNCD,CSGNNM,CSGNADDR,CSGNCity,CSGNPinCode,
CSGNTeleNo,CSGNEmail,CSGECD,CSGENM,CSGEADDR,CSGECity,CSGEPinCode,CSGETeleNo,CSGEEmail,PARTY_CODE,privatemark
,tpnumber,TRN_MOD,CFT_YN,DIPLOMAT ,DACC_YN,LocalCN_YN,Part,Pickup_Dely,UGC,permit_yn, permit_recvd_at,permitdt 
,permit_recvd_dt,Permit_No,permit_validity_dt,DOCKDT_Entry,ENTRYBY,LastEditDate,LastEditBy ,
--Cnor Cnee
CSGNCD+':' +(case  when CSGNCD='8888' then CSGNNM else (select top 1 custnm from webx_custhdr  with(NOLOCK) where custcd=d.csgncd) end ) as Cnor,
CSGeCD+':' +(case  when CSGeCD='8888' then CSGeNM else (select top 1 custnm from webx_custhdr   with(NOLOCK)  where custcd=d.csgecd) end ) as Cnee,
--Docket Charges
invno,invdt,invamt,
RATE_TYPE,FRT_RATE,FREIGHT_CALC,FREIGHT,FOV,SCHG01,SCHG02,SCHG03,SCHG04,SCHG05,SCHG06,SCHG07,SCHG08,SCHG09,SCHG10 
,SCHG11,SCHG12,SCHG13,SCHG14,SCHG15,SCHG16,SCHG17,SCHG18,SCHG19,SCHG20,SCHG21,SCHG22,SCHG23,UCHG01,UCHG02,UCHG03
,UCHG04,UCHG05,UCHG06,UCHG07,UCHG08,UCHG09,UCHG10,SubTotal,SVCTAX,CESS,DKTTOT as dkttot,cess_svctax=(cess+svctax),
BACode=BACode,--(select top 1 BA_Employee + ' - '+ BA_Employee_name  from   VW_docket_BA_Employee where  D.dockno between  doc_sr_from and doc_sr_to),
(case when (chrgwt=0 or chrgwt is  null ) then 0 else (cast((dkttot-(cess+svctax+hedu_cess))/chrgwt as decimal(9,2) ))  end) as Yield,
--Docket Charges
Docket_Mode,Curr_Loc,NextLoc,Billed,MR,OctroiMR,LS,MF,THC,PRS,DRS,Delivered,Dely_Date,Cancelled,CancelledBy,CancelledOn
,Op_Status,ArrPkgQty,ArrWeightQty,DelPkgQty,DelWeightQty,PendPkgQty,PendWeightQty,hedu_cess,
(select case when d.paybas='P09' then party_code When d.paybas='P08' then party_code   When d.paybas='P02' then party_code  When d.paybas='P01 ' then csgncd When d.paybas='P03 ' then csgecd  else csgncd  end) as Party 
--,VBD.billno as billno,
--VBD.bgndt as bgndt,VBD.Billsubbrcd as Billsubbrcd ,VBD.BillColbrcd as BillColbrcd
,VMD.MRSNO as MRSNO ,VMD.MRSDT As MRSDT
,l_f.loccode as f_loccode, l_f.locname as f_locname,l_f.report_loc as f_report_loc
,l_t.loccode as t_loccode, l_t.locname as t_locname,l_t.report_loc as t_report_loc
,l_f.loccode as from_loccode,l_f.report_loc as from_report_loc  
,l_t.loccode as to_loccode,l_t.report_loc as to_report_loc  
from WebX_Master_Docket D With(NOLOCK) 
Inner join WebX_Master_Docket_Charges C  With(NOLOCK)  on D.dockno=C.dockno
Inner join WebX_Trans_Docket_Status S  With(NOLOCK)  on D.dockno=S.dockno and D.docksf=S.docksf
Left Outer Join Vw_MR_details_net VMD with(NOLOCK) On D.dockno = VMD.dockno-- and VMD.MR_CANCEL='N'  and mrstype in ('1','3')
--Left Outer Join Vw_Bill_details_net VBD with(NOLOCK) On D.dockno = VBD.dockno and VBD.BILL_CANCEL='N' and vbd.paybas<>'6'
--Left Outer Join   webx_custhdr g with(NOLOCK) On p.csgncd=g.custcd
Inner Join Webx_location l_f With(NOLOCK) On D.orgncd=l_f.loccode
Inner Join Webx_location l_t With(NOLOCK) On D.destcd=l_t.loccode



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


