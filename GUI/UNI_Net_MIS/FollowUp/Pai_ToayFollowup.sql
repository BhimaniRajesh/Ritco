if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WebxNet_FOllowUP_Paid_ToPay]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WebxNet_FOllowUP_Paid_ToPay]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WebxNet_FOllowUP_Paid_ToPay_Det]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WebxNet_FOllowUP_Paid_ToPay_Det]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

--exec WebxNet_FOllowUP_Paid_ToPay  '01 July 08','31 July 08','All','All','All','2'
CREATE Proc WebxNet_FOllowUP_Paid_ToPay
@fromdt varchar(200),
@todt varchar(200),
@RO varchar(200),
@ORGNCD varchar(200),
@CUSTCD varchar(2000),
@RPT varchar(10)
as

Declare @SQL Varchar(8000),@WhereCri_DT varchar(400),@DT_TYPE varchar(100);
Declare @WhereCri varchar(2000),@WhereCri_cust varchar(2000),@WhereCri_TYP varchar(2000),@WhereCri_DST varchar(2000);
Declare @WhereCri_MST varchar(2000),@WhereCri_L_TYP varchar(2000),@WhereCri_C_TYP varchar(2000),@WhereCri_MR_DKT varchar(2000);

select @WhereCri_DT='',@WhereCri='',@WhereCri_cust=''

	if @RO='All' and @ORGNCD='All'  
	select @WhereCri = ''  
	else if @RO<>'All' and @ORGNCD='All'  
	select @WhereCri = ' and report_loc=' + char(39) + @RO + char(39)  
	else if @RO='All' and @ORGNCD<>'All'  
	select @WhereCri = ' and loccode= '+ char(39) + @ORGNCD + char(39)  
	else if @RO<>'All' and @ORGNCD<>'All'  
	select @WhereCri = 'and report_loc=' + char(39) + @RO + char(39) +' and loccode= '+ char(39) + @ORGNCD + char(39)  


	select @WhereCri_DT=' and Convert(varchar,d.dockdt,106) between Convert(datetime,'+char(39)+@fromdt+char(39)+',106) and Convert(datetime,'+char(39)+@TODT+char(39)+',106)  and d.dockdt is not null'

	if @CUSTCD <>'All' 
		select @WhereCri_cust=' and [dbo].[SplitWithSearch]('+char(39)+@CUSTCD+char(39)+','+char(39)+','+char(39)+',csgncd)='+char(39)+'1'+char(39)+''
	else 
		select @WhereCri_cust=''

--select @WhereCri_DT,@WhereCri,@WhereCri_cust

if @RPT='1'
	begin
	select @SQL='select report_loc,report_loc_name=(select top 1 loccode+'+char(39)+' : '+char(39)+'+locname  from webx_location where loccode=VLD.report_loc ),loccode,locname=loccode+'+char(39)+' : '+char(39)+'+locname ,count(d.dockno) as TOT_docket,
	sum(case when (VMD.mrsno is not null ) then 1 else 0 end) as MR_gen,      
	sum(case when (VMD.mrsno is not null ) then isnull(dkttot,0) else 0 end) as MR_gen_amt,
	sum(case when (isnull(VMD.MRS_CLOSED,'+char(39)+'N'+char(39)+')<>'+char(39)+'N'+char(39)+' )  then 1 else 0 end) as MR_CloseD,      
	sum(case when (isnull(VMD.MRS_CLOSED,'+char(39)+'N'+char(39)+')<>'+char(39)+'N'+char(39)+' ) then isnull(dkttot,0) else 0 end) as MR_Closed_amt,      
	sum(case when (isnull(VMD.MRS_CLOSED,'+char(39)+'N'+char(39)+')='+char(39)+'N'+char(39)+'  ) then 1 else 0 end) as MR_not_Closed,      
	sum(case when (isnull(VMD.MRS_CLOSED,'+char(39)+'N'+char(39)+')='+char(39)+'N'+char(39)+'  ) then isnull(dkttot,0) else 0 end) as MR_not_Closed_amt,sum(isnull(miscchrg,0))
	from webx_master_docket D with(NOLOCK)
	inner join webx_master_docket_charges C with(NOLOCK) on d.dockno=c.dockno
	inner join webx_trans_docket_status s with(NOLOCK) on d.dockno=s.dockno and  d.docksf=s.docksf and isnull(cancelled,'+char(39)+'N'+char(39)+')='+char(39)+'N'+char(39)+'
	Inner Join Webx_location VLD with(NOLOCK)   on D.orgncd=VLD.loccode    
	Left Outer Join  webx_MR_hdr VMD with(NOLOCK) On D.dockno = VMD.dockno and isnull(VMD.MR_CANCEL,'+char(39)+'N'+char(39)+')='+char(39)+'N'+char(39)+' and VMD.MRstype not in ('+char(39)+'4'+char(39)+')    
	where d.paybas='+char(39)+'P01'+char(39)+' '+@WhereCri+@WhereCri_DT+@WhereCri_cust+' 	
	group by report_loc,loccode,locname'
	end
else 
	begin
	select @WhereCri_CUST=replace(@WhereCri_CUST,'csgncd','csgecd')
	select @SQL='select report_loc,report_loc_name=(select top 1 loccode+'+char(39)+' : '+char(39)+'+locname  from webx_location where loccode=VLD.report_loc ),loccode,locname=loccode+'+char(39)+' : '+char(39)+'+locname ,count(d.dockno) as TOT_docket,
	sum(case when curr_loc=reassign_destcd then 1 else 0 end) as Arrived,
	sum(case when (curr_loc=reassign_destcd and VMD.mrsno is not null ) then 1 else 0 end) as MR_gen,      
	sum(case when (curr_loc=reassign_destcd and VMD.mrsno is not null ) then isnull(dkttot,0) else 0 end) as MR_gen_amt,
	sum(case when (curr_loc=reassign_destcd and isnull(VMD.MRS_CLOSED,'+char(39)+'N'+char(39)+')<>'+char(39)+'N'+char(39)+' )  then 1 else 0 end) as MR_CloseD,      
	sum(case when (curr_loc=reassign_destcd and isnull(VMD.MRS_CLOSED,'+char(39)+'N'+char(39)+')<>'+char(39)+'N'+char(39)+' ) then isnull(dkttot,0) else 0 end) as MR_Closed_amt,      
	sum(case when (curr_loc=reassign_destcd and isnull(VMD.MRS_CLOSED,'+char(39)+'N'+char(39)+')='+char(39)+'N'+char(39)+'  ) then 1 else 0 end) as MR_not_Closed,      
	sum(case when (curr_loc=reassign_destcd and isnull(VMD.MRS_CLOSED,'+char(39)+'N'+char(39)+')='+char(39)+'N'+char(39)+'  ) then isnull(dkttot,0) else 0 end) as MR_not_Closed_amt,sum(isnull(miscchrg,0))
	from webx_master_docket D with(NOLOCK)
	inner join webx_master_docket_charges C with(NOLOCK) on d.dockno=c.dockno
	inner join webx_trans_docket_status s with(NOLOCK) on d.dockno=s.dockno and  d.docksf=s.docksf and isnull(cancelled,'+char(39)+'N'+char(39)+')='+char(39)+'N'+char(39)+'
	Inner Join Webx_location VLD with(NOLOCK)   on D.reassign_destcd=VLD.loccode    
	Left Outer Join  webx_MR_hdr VMD with(NOLOCK) On D.dockno = VMD.dockno and isnull(VMD.MR_CANCEL,'+char(39)+'N'+char(39)+')='+char(39)+'N'+char(39)+' and VMD.MRstype not in ('+char(39)+'4'+char(39)+')    
	where d.paybas='+char(39)+'P03'+char(39)+' '+@WhereCri+@WhereCri_DT+@WhereCri_cust+' 	
	group by report_loc,loccode,locname'
	end

exec(@SQL)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

--exec WebxNet_FOllowUP_Paid_ToPay_Det '01 July 08','31 July 08','AKV','All','1','1'
CREATE Proc WebxNet_FOllowUP_Paid_ToPay_Det
@fromdt varchar(200),
@todt varchar(200),
@ORGNCD varchar(200),
@CUSTCD varchar(2000),
@RPT varchar(10),
@RPT_MD varchar(10)
as

Declare @SQL Varchar(8000),@WhereCri_DT varchar(400),@WhereCri_cust varchar(2000)

Declare @WhereCri Varchar(8000),@WhereCri_ST varchar(400)

select @WhereCri_DT=' and Convert(varchar,d.dockdt,106) between Convert(datetime,'+char(39)+@fromdt+char(39)+',106) and Convert(datetime,'+char(39)+@TODT+char(39)+',106)  and d.dockdt is not null'

	if @CUSTCD <>'All' 
		begin
		if @RPT='1'
			select @WhereCri_cust=' and [dbo].[SplitWithSearch]('+char(39)+@CUSTCD+char(39)+','+char(39)+','+char(39)+',csgncd)='+char(39)+'1'+char(39)+''
		else 
			select @WhereCri_cust=' and [dbo].[SplitWithSearch]('+char(39)+@CUSTCD+char(39)+','+char(39)+','+char(39)+',csgecd)='+char(39)+'1'+char(39)+''
		end
	else 
		select @WhereCri_cust=''

	if @RPT='1'
		select @WhereCri=' and d.paybas='+char(39)+'P01'+char(39)+' and d.orgncd='+ char(39) + @ORGNCD + char(39)  
	else 
		select @WhereCri=' and d.paybas='+char(39)+'P03'+char(39)+' and d.reassign_destcd='+ char(39) + @ORGNCD + char(39)

	if @RPT_MD='1'
		select @WhereCri_ST=''
	else if @RPT_MD='2'
		select @WhereCri_ST=' and VMD.mrsno is not null'
	else if @RPT_MD='3'
		select @WhereCri_ST=' and isnull(VMD.MRS_CLOSED,'+char(39)+'N'+char(39)+')<>'+char(39)+'N'+char(39)+''
	else if @RPT_MD='4'
		select @WhereCri_ST=' and isnull(VMD.MRS_CLOSED,'+char(39)+'N'+char(39)+')='+char(39)+'N'+char(39)+''


	if  @RPT<>'1' and (@RPT_MD='2' or @RPT_MD='3' or @RPT_MD='4')
		select @WhereCri_ST =@WhereCri_ST+ ' and curr_loc=reassign_destcd'

	select @SQL='select  d.dockno,dockdt=convert(varchar,d.dockdt,6),d.orgncd,reassign_destcd,curr_loc,VMD.mrsno,mrsdt=convert(varchar,VMD.mrsdt,6),VMD.mrstype,
	MRS_CLOSED=isnull(VMD.MRS_CLOSED,'+char(39)+'N'+char(39)+') ,MRCloseDT=convert(varchar,VMD.finclosedt,6),
	TYP=(select top 1 codedesc from  webx_master_general with(NOLOCK) where codetype= '+char(39)+'mrstype'+char(39)+' and codeid=VMD.mrstype),
	mrsamt,CSGNCD+'+char(39)+':'+char(39)+' +(case  when CSGNCD='+char(39)+'8888'+char(39)+' then CSGNNM else (select top 1 custnm from webx_custhdr  with(NOLOCK) where custcd=d.csgncd) end ) as Cnor,    
CSGeCD+'+char(39)+':'+char(39)+' +(case  when CSGeCD='+char(39)+'8888'+char(39)+' then CSGeNM else (select top 1 custnm from webx_custhdr   with(NOLOCK)  where custcd=d.csgecd) end ) as Cnee   
	from webx_master_docket D with(NOLOCK)
	inner join webx_master_docket_charges C with(NOLOCK) on d.dockno=c.dockno
	inner join webx_trans_docket_status s with(NOLOCK) on d.dockno=s.dockno and  d.docksf=s.docksf and isnull(cancelled,'+char(39)+'N'+char(39)+')='+char(39)+'N'+char(39)+'
	Left Outer Join  webx_MR_hdr VMD with(NOLOCK) On D.dockno = VMD.dockno and isnull(VMD.MR_CANCEL,'+char(39)+'N'+char(39)+')='+char(39)+'N'+char(39)+' and VMD.MRstype not in ('+char(39)+'4'+char(39)+')    
	where 1=1  '+@WhereCri+@WhereCri_DT+@WhereCri_cust+@WhereCri_ST+' 	'
	

exec(@SQL)
--select @SQL
--select @WhereCri,@WhereCri_DT,@WhereCri_cust,@WhereCri_ST
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

