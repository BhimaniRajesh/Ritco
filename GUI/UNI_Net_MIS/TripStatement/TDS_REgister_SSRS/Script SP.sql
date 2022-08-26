if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WebxNet_TDS_Register]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WebxNet_TDS_Register]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

--exec WebxNet_TDS_Register '01 July 08','31 July 08','All','All','','','All','','00','00','1','08_09'


CREATE Proc WebxNet_TDS_Register
@fromdt varchar(200),
@todt varchar(200),
@RO varchar(200),
@ORGNCD varchar(200),
@Cust_vendcd varchar(200),
@Cust_vendnm varchar(200),
@AccList  varchar(2000),
@VRNOLsit  varchar(2000),
@amtfrm varchar(20),
@amtto varchar(20),
@RPTTYP varchar(20),
@finYear varchar(5)
as

declare @WhereCri varchar(200),@SQL varchar(8000),@whereDt varchar(2000),@whereAcc varchar(2000);
declare @whereAccCat varchar(2000),@WhereCust varchar(2000),@Where_List varchar(2000),@WhereAmt varchar(2000);

select @whereDt='',@Where_List='',@WhereCri='',@WhereCust='',@whereAcc='',@whereAccCat='',@WhereAmt=''

	if  @amtto>0
		select @WhereAmt=' and ((isnull(credit,0)>='+@amtfrm+' and  isnull(credit,0)<='+@amtto+') or (isnull(debit,0)>='+@amtfrm+' and  isnull(debit,0)<='+@amtto+'))' 

	if @Cust_vendcd<>''
		select @WhereCust='  and [dbo].[SplitWithSearch]('+char(39)+@Cust_vendcd+char(39)+','+char(39)+','+char(39)+',pbov_code)='+char(39)+'1'+char(39)+''
	else if @Cust_vendnm<>''
		select @WhereCust =' and pbov_code='+char(39)+'8888'+char(39)+' and pbov_name like  '+char(39)+@Cust_vendnm+char(39)+''
	
	if @RO='All' and @ORGNCD='All'  
	select @WhereCri = ''  
	else if @RO<>'All' and @ORGNCD='All'  
	select @WhereCri = ' and report_loc=' + char(39) + @RO + char(39)  
	else if @RO='All' and @ORGNCD<>'All'  
	select @WhereCri = ' and loccode= '+ char(39) + @ORGNCD + char(39)  
	else if @RO<>'All' and @ORGNCD<>'All'  
	select @WhereCri = 'and report_loc=' + char(39) + @RO + char(39) +' and loccode= '+ char(39) + @ORGNCD + char(39)  

	select @whereDt=' and Convert(varchar,transdate,106) between Convert(datetime,'+char(39)+@fromdt+char(39)+',106) and Convert(datetime,'+char(39)+@TODT+char(39)+',106)  and transdate is not null'

	if @AccList<>'All'
		select @whereAcc=' and t.acccode= '+ char(39) + @AccList + char(39)  +''

if  @VRNOLsit<>'' 	
		begin	
		--select @Where_List=' and [dbo].[SplitWithSearch]('+char(39)+@VRNOLsit+char(39)+','+char(39)+','+char(39)+',Voucherno)='+char(39)+'1'+char(39)+''
		select @Where_List=' and  Voucherno in ('+char(39)+ replace(replace(@VRNOLsit,',',char(39)+','+char(39)),' ','')+char(39)+')'
		select @WhereCri=''
		select @whereDt=''
		select @WhereCust=''
		select @whereAcc=''
		select @WhereAmt=''
		end


	if @RO='All' and @ORGNCD='All'  
	select @WhereCri = ''  
	else if @RO<>'All' and @ORGNCD='All'  
	select @WhereCri = ' and report_loc=' + char(39) + @RO + char(39)  
	else if @RO='All' and @ORGNCD<>'All'  
	select @WhereCri = ' and loccode= '+ char(39) + @ORGNCD + char(39)  
	else if @RO<>'All' and @ORGNCD<>'All'  
	select @WhereCri = ' and report_loc=' + char(39) + @RO + char(39) +' and loccode= '+ char(39) + @ORGNCD + char(39)  

	if @RPTTYP='P'
		select @whereAccCat=' and main_category=' + char(39) + 'LIABILITY' + char(39) + ''
	else 
		select @whereAccCat=' and main_category=' + char(39) + 'ASSET' + char(39) + ''


IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id = object_id(N'[tempdb]..[#TDS_REPORT]'))                  
Drop table #TDS_REPORT      
Create Table #TDS_REPORT ([SRNO] [numeric](18, 0) IDENTITY (1, 1) NOT NULL,
Voucherno Varchar(150),chqno Varchar(150),transdate datetime,chqdate datetime,debit numeric(12,2),
credit numeric(12,2),Narration Varchar(1550),brcd Varchar(150),docno Varchar(150),entryby Varchar(150),
entrydt datetime,voucher_cancel Varchar(150),opertitle Varchar(1150),opertitle_cd Varchar(150),pbov_code Varchar(150),
pbov_name Varchar(150),pbov_typ Varchar(150),transtype Varchar(150),transtype_cd Varchar(150),account Varchar(150),
acccategory Varchar(150),payto Varchar(150),finyear Varchar(150))

delete from #TDS_REPORT
		
	select @SQL='insert into #TDS_REPORT (voucherno,chqno,transdate,chqdate,debit,credit,
Narration,brcd,docno,entryby,entrydt,voucher_cancel,opertitle,opertitle_cd,pbov_code,pbov_name,pbov_typ,transtype,transtype_cd,account,
acccategory,payto,finyear)
select  Voucherno,chqno,transdate,chqdate=convert(varchar,chqdate,6),Credit=isnull(credit,0),Debit=isnull(debit,0)
,narration,t.brcd,docno,T.entryby,convert(varchar,T.entrydt,6),voucher_cancel,opertitle,
opertitle_cd=(case when opertitle='+char(39)+'ADVICE TRANSACTION'+char(39)+' then '+char(39)+'1'+char(39)+'
when opertitle='+char(39)+'BILL TRANSACTION'+char(39)+' then '+char(39)+'2'+char(39)+' 
when opertitle='+char(39)+'CHEQUE TRANSACTION'+char(39)+' then '+char(39)+'3'+char(39)+'
when opertitle='+char(39)+'CN BOOKING - PAID'+char(39)+' then '+char(39)+'4'+char(39)+'
when opertitle='+char(39)+'CN BOOKING - TBB'+char(39)+' then '+char(39)+'5'+char(39)+'
when opertitle='+char(39)+'CN BOOKING - TO PAY'+char(39)+' or opertitle='+char(39)+'DKT BOOKING - TO PAY'+char(39)+' then '+char(39)+'6'+char(39)+'
when opertitle='+char(39)+'FROM VENDOR BIll PAYMENT'+char(39)+' then '+char(39)+'7'+char(39)+'
when opertitle='+char(39)+'Manual Contra Voucher'+char(39)+' then '+char(39)+'8'+char(39)+'
when opertitle='+char(39)+'Manual Credit Voucher'+char(39)+' then '+char(39)+'9'+char(39)+'
when opertitle='+char(39)+'Manual Debit Voucher'+char(39)+' then '+char(39)+'10'+char(39)+'
when opertitle='+char(39)+'Manual Voucher'+char(39)+' then '+char(39)+'11'+char(39)+'
when opertitle='+char(39)+'MR TRANSACTION'+char(39)+' then '+char(39)+'12'+char(39)+'
when opertitle='+char(39)+'Octroi Payment'+char(39)+' then '+char(39)+'13'+char(39)+'
when opertitle='+char(39)+'RUN SHEET OPERATION'+char(39)+' then '+char(39)+'14'+char(39)+'
when opertitle= '+char(39)+'THC CYCLE'+char(39)+' then '+char(39)+'15'+char(39)+'
when opertitle='+char(39)+'VENDOR PAYMENT'+char(39)+' or opertitle='+char(39)+'OTHER BILL ENTRY'+char(39)+' then '+char(39)+'16'+char(39)+'
when opertitle= '+char(39)+'MISC BILL'+char(39)+' then '+char(39)+'17'+char(39)+'
when opertitle='+char(39)+'MANUAL JOURNAL VOUCHER'+char(39)+' then '+char(39)+'18'+char(39)+'
when left(narration,22)= '+char(39)+'When Bill Entry for BA'+char(39)+' then '+char(39)+'19'+char(39)+'end),
pbov_code,pbov_name=(case when pbov_code<>'+char(39)+'8888'+char(39)+' and pbov_typ='+char(39)+'C'+char(39)+' then (select top 1 custcd+'+char(39)+' : '+char(39)+'+custnm from webx_custhdr with(NOLOCK) where custcd=t.pbov_code)   
 when pbov_code<>'+char(39)+'8888'+char(39)+' and pbov_typ='+char(39)+'V'+char(39)+' then (select top 1 vendorcode+'+char(39)+': '+char(39)+'+Vendorname from webx_vendor_hdr with(NOLOCK) where vendorcode=t.pbov_code) else pbov_code+'+char(39)+' : '+char(39)+'+pbov_name end ),pbov_typ ,
transtype,
transtype_cd=(case when transtype='+char(39)+'Bank Payment'+char(39)+' or transtype='+char(39)+'BANK RECEIPT'+char(39)+' or transtype='+char(39)+'BANK RECIEPT'+char(39)+' then '+char(39)+'5'+char(39)+'
when transtype='+char(39)+'Cash'+char(39)+' or transtype='+char(39)+'Cash Payment'+char(39)+' or transtype='+char(39)+'Cash Receipt'+char(39)+' or transtype='+char(39)+'CASH RECIEPT'+char(39)+' then '+char(39)+'1'+char(39)+'
when transtype='+char(39)+'Cheque'+char(39)+' then '+char(39)+'2'+char(39)+'
when transtype='+char(39)+'Contra'+char(39)+' then '+char(39)+'4'+char(39)+'
when transtype='+char(39)+'Expenses'+char(39)+' then '+char(39)+'3'+char(39)+'
when transtype='+char(39)+'Journal'+char(39)+' then '+char(39)+'6'+char(39)+'  end ),
account=isnull(company_acccode,a.acccode)+'+char(39)+' : '+char(39)+' +accdesc,main_category,payto,finyear
 from webx_acctrans_08_09 T with(NOLOCK)   
 inner join webx_acctinfo a with(NOLOCK) on a.acccode=t.acccode   
 inner join webx_groups g with(NOLOCK) on a.groupcode=g.groupcode    
 inner join webx_location l on t.brcd=l.loccode where acccategory='+char(39)+'TDS'+char(39)+'
'+@WhereCri+@whereDt+@WhereCust+@whereAcc+@Where_List+ @whereAccCat+@WhereAmt+' order by transdate'
exec(@SQL)
if @RPTTYP='P'
	begin
	select  distinct  VRNO=TD.Voucherno,transdate=convert(varchar,transdate,6),account,acccategory,finyear,chqno,chqdate,payto,TD.brcd,pbov_name,
	TD.narration,TD.docno,transtype=(select top 1 codedesc from webx_master_general where codetype= 'VRTYPE' and codeid=TD.transtype),
	opertitle=(select top 1 codedesc from webx_master_general where codetype= 'TRNTYPE' and codeid=opertitle_cd),
	opertitle_cd,TD.transtype_cd,credit,debit,opertitle,
	DocAmt=(case when opertitle_cd='15' then T.PCAMT when (opertitle_cd='19' or opertitle_cd='16')  then BA.PCAMT when opertitle_cd='14' then RS.PDC_AMT     end),
	DocDt=(case when opertitle_cd='15' then convert(varchar,T.thcdt,6) when (opertitle_cd='19' or opertitle_cd='16')  then convert(varchar,BA.billdt,6) when opertitle_cd='14' then convert(varchar,RS.pdcdt,6)   end) ,
	TDSRate=(case when opertitle_cd='15' then convert(varchar,T.tds_rate,6) when (opertitle_cd='19' or opertitle_cd='16')   then convert(varchar,BA.TDSRATE,6) when opertitle_cd='14'  then convert(varchar,RS.TDSRATE,6) end)
	from #TDS_REPORT TD with(NOLOCK)
	left outer join webx_thc_summary T with(NOLOCK)  on t.thcno=TD.docno and opertitle_cd='15'
	left outer join webx_vendorbill_hdr BA with(NOLOCK)  on BA.billno=TD.docno and (opertitle_cd='19' or opertitle_cd='16') 
	left outer join webx_pdchdr  RS with(NOLOCK)  on RS.PDCNO=TD.docno and opertitle_cd='14'
	end
else 
	begin
	select  distinct     VRNO=TD.Voucherno,transdate=convert(varchar,transdate,6),account,acccategory,finyear,chqno,chqdate,payto,TD.brcd,pbov_name,
	TD.narration,TD.docno,transtype=(select top 1 codedesc from webx_master_general where codetype= 'VRTYPE' and codeid=TD.transtype),
	opertitle=(select top 1 codedesc from webx_master_general where codetype= 'TRNTYPE' and codeid=opertitle_cd),opertitle_cd,TD.transtype_cd,credit,debit,opertitle,
	DocAmt=(case when (opertitle_cd='12' or opertitle_cd='2') then MR.MRSAMT  end),
	DocDt=(case when (opertitle_cd='12' or opertitle_cd='2') then convert(varchar,MR.MRSDT,6) end) ,
	TDSRate=(case when (opertitle_cd='12' or opertitle_cd='2') then MR.tds_rate 		end)
	from #TDS_REPORT TD with(NOLOCK)
	left outer join webx_MR_hdr MR with(NOLOCK)  on MR.MRSno=TD.docno and ( opertitle_cd='12'  or opertitle_cd='2')
	end


--select @whereDt,@Where_List,@WhereCri,@WhereCust,@whereAcc,@whereAccCat,@WhereAmt
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

