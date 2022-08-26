if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WebxNet_octroi]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WebxNet_octroi]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


--exec WebxNet_octroi '01 Jun 08','10 Jun 08','All','','',''
--exec WebxNet_octroi '02 Jun 08','06 Jun 08','All','0070405,0083723,0097339,0099400','',''
CREATE Proc WebxNet_octroi
@fromdt varchar(200),
@todt varchar(200),
@status varchar(200),
@docklist varchar(3000),
@OCTBILL_list varchar(3000),
@OCTMR_list varchar(3000)
as
SET NOCOUNT ON


declare @WhereCri varchar(2000),@WhereCri_DOC varchar(4000),@SqL varchar(8000);

if @status ='1'
select @WhereCri=' and (a.ocbillno is not null and a.ocbillno <>'+char(39)+''+char(39)+') and a.voucherno is not null'
else if @status ='2'
select @WhereCri=' and (a.ocbillno is not null and a.ocbillno <>'+char(39)+''+char(39)+') and a.voucherno is null'
else if @status ='3'
select @WhereCri=' and (a.voucherno is not null and a.voucherno <>'+char(39)+''+char(39)+') and (a.ocbillno is null or a.ocbillno ='+char(39)+''+char(39)+')'
else if @status ='4'
select @WhereCri=' and ((a.ocbillno is not null and a.ocbillno <>'+char(39)+''+char(39)+') and a.voucherno is not null) and (a.billno is null and a.mrsno is null)'
else if @status ='5'
select @WhereCri=' and ((a.ocbillno is not null or a.ocbillno <>'+char(39)+''+char(39)+') and a.voucherno is not null) and (a.billno is not null or a.mrsno is not null)'
else
select @WhereCri=''
select @WhereCri_DOC=' and convert(varchar,b.dockdt,106) between convert(datetime,'+ char(39)+ @fromdt+ char(39)+',106) and convert(datetime,'+ char(39)+ @todt+ char(39)+',106) '
if @docklist<>''
select @WhereCri_DOC=' and [dbo].[SplitWithSearch]('+char(39)+@docklist+char(39)+','+char(39)+','+char(39)+',b.dockno)='+char(39)+'1'+char(39)+''
if @OCTBILL_list<>''
select @WhereCri_DOC=' and [dbo].[SplitWithSearch]('+char(39)+@OCTBILL_list+char(39)+','+char(39)+','+char(39)+',a.BILLNO)='+char(39)+'1'+char(39)+''
if @OCTMR_list<>''
select @WhereCri_DOC=' and [dbo].[SplitWithSearch]('+char(39)+@OCTMR_list+char(39)+','+char(39)+','+char(39)+',a.mrsno)='+char(39)+'1'+char(39)+''

--select @WhereCri_DOC
select @SqL='select a.DOCKNO,a.DECLVAL,a.recptno,a.octamt,a.process_chrg,a.OTCHG,a.billno,a.voucherNo,b.PAYBAS,
paybasstr=(select top 1 codedesc from webx_master_general where codetype='+char(39)+'PAYTYP'+char(39)+' and codeid=b.paybas),c.FREIGHT,DOCKDT=convert(varchar,b.DOCKDT,6),b.ORGNCD,b.reassign_DESTCD,a.OCBILLNO,a.octroipaid_by,a.oct_Custcd,a.oct_Custnm,Vendor=a.oct_vendorcd+'+char(39)+':'+char(39)+' +a.oct_vendornm ,a.oct_vendorcd,a.oct_vendornm,m.mrsno,a.mr_paidby ,
OCT_CUST=(case when a.mr_paidby='+char(39)+'CSGECD'+char(39)+' then CSGeCD+'+char(39)+':'+char(39)+' +(case when CSGeCD='+char(39)+'8888'+char(39)+' then CSGeNM else (select top 1 custnm from webx_custhdr with(NOLOCK) where custcd=b.csgecd) end )
when a.mr_paidby='+char(39)+'CSGnCD'+char(39)+' then CSGnCD+'+char(39)+':'+char(39)+' +(case when CSGnCD='+char(39)+'8888'+char(39)+' then CSGnNM else (select top 1 custnm from webx_custhdr with(NOLOCK) where custcd=b.csgncd) end ) end ),
OCT_CUSTPAIDBY=(case when a.mr_paidby='+char(39)+'CSGECD'+char(39)+' then '+char(39)+'Cnee'+char(39)+'
when a.mr_paidby='+char(39)+'CSGNCD'+char(39)+' then '+char(39)+'Cnor'+char(39)+' end )
from webx_oct_det a with(NOLOCK)
inner join webx_master_docket b with(NOLOCK) on a.dockno=b.dockno
inner join webx_master_docket_charges c with(NOLOCK) on a.dockno=c.dockno
left outer join webx_mr_hdr m with(NOLOCK) on a.dockno=m.dockno and mrstype='+char(39)+'4'+char(39)+' where 1=1 '+@WhereCri+@WhereCri_DOC+'

order by b.Dockdt desc'

exec(@SqL)



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

