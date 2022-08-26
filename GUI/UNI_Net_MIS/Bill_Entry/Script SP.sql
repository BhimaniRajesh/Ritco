if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[webx_BILLENtry_register]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[webx_BILLENtry_register]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


create Proc webx_BILLENtry_register
@FROMDT varchar(250),    
@TODT varchar(250),    
@RO varchar(70),    
@ORGNCD varchar(70),    
@BillTYP varchar(15),
@SelDAT varchar(150),
@vendcd varchar(150)
as 
   
Declare @sql varchar(6000);    
Declare @whereCri varchar(1000);    
Declare @dktstr varchar(1000);    
Declare @paystr varchar(1000);    

            if @RO='All' and @ORGNCD='All'     
   select @whereCri  = ''     
      else if @RO<>'All' and  @ORGNCD='All'    
   select @whereCri  = ' and report_loc=' + char(39)  + @RO + char(39)     
      else if @RO<>'All' and  @ORGNCD<>'All'    
        select @whereCri  = 'and report_loc=' + char(39)  + @RO + char(39) +' and loccode= '+ char(39)  + @ORGNCD  + char(39)    
  else if @RO='All' and  @ORGNCD<>'All'    
        select @whereCri  = 'and  loccode= '+ char(39)  + @ORGNCD  + char(39)    

	if @BillTYP='All' or @BillTYP=''
		select @dktstr=''	
	else 
		select @dktstr = 'and  BETYPE= '+ char(39)  + @BillTYP  + char(39)    

	

	if @vendcd='All' or @vendcd=''
		select @paystr=''	
	else 
		select @paystr = 'and  vendorcode= '+ char(39)  + @vendcd  + char(39)   

	select @sql='select  Billno,brcd,billdt=convert(varchar,billdt,6),vendorcode,vendorname=vendorcode+' + char(39)  + ' : ' + char(39) +'+(select top 1 vendorname from webx_vendor_hdr where vendorcode=h.vendorcode),
	vendorbilldt=convert(varchar,vendorbilldt,6),vendorbillno,PCAMT=cast(isnull(PCAMT,0.00) as decimal(9,2)),ADVAMT=cast(isnull(ADVAMT,0.00) as decimal(9,2)),OTHAMT=cast(isnull(OTHAMT,0.00) as decimal(9,2)),DUEDT=convert(varchar,DUEDT,6),Entryby,ENtrydt=convert(varchar,ENtrydt,6),Remark,
	Paydt=convert(varchar,Paydt,6),voucherno=(case when voucherno='+ char(39)  + 'null'  + char(39)  +' then '+ char(39)  + ''  + char(39)  +'  else voucherno end),otherded=cast(isnull(otherded,0.00) as decimal(9,2)),tdsrate,tds=cast(isnull(tds,0.00) as decimal(9,2)),svctaxded,otherchrg,netamt=cast(isnull(netamt,0.00) as decimal(9,2)),tdsfor,tdsgrpcode,tdsgrpdesc,BETYPE,pendamt=cast(isnull(pendamt,0.00) as decimal(9,2)),Finclosedt=convert(varchar,Finclosedt,6)
	from webx_vendorbill_hdr H with(NOLOCK) 
	inner join webx_location on  loccode=H.brcd
	where 1=1 '+@whereCri+@dktstr+@paystr+' and 
	convert(varchar,'+@SelDAT+',106) between Convert(datetime,' + char(39) + @FROMDT + char(39)  + ',106)  and  Convert(datetime,' + char(39) + @TODT + char(39)  + ',106)    '


exec(@sql)    



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

