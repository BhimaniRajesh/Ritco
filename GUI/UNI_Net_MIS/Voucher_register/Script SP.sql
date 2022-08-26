if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WebxNet_voucher_register]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[WebxNet_voucher_register]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



--exec WebxNet_voucher_register '01 July 08','01 July 08','All','AGR','All','All','','','transdate','08_09',''
CREATE Procedure WebxNet_voucher_register
@fromdt varchar(200),
@todt varchar(200),
@RO varchar(200),
@ORGNCD varchar(200),
@vaouchertype varchar(200),
@TRtype varchar(200),
@vochernolist varchar(2000),
@docnolist varchar(2000),
@DT_TYPE varchar(200),
@Finyear varchar(5),
@DKT_Nom varchar(50)
as 

declare @WhereCri varchar(200),@SQL varchar(8000),@whereDt varchar(2000),@WhereVrTyp varchar(2000),@WhereTRTyp varchar(2000),@Where_List varchar(2000);

select @whereDt='',@Where_List='',@WhereCri='',@WhereVrTyp='',@WhereTRTyp=''

declare @SQLInsertData varchar(8000);

IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id = object_id(N'[tempdb]..[#VRList]'))                  
Drop table #VRList      
Create Table #VRList ([SRNO] [numeric](18, 0) IDENTITY (1, 1) NOT NULL,
Voucherno Varchar(150),chqno Varchar(150),transdate datetime,chqdate datetime,debit numeric(12,2),
credit numeric(12,2),Narration Varchar(1550),brcd Varchar(150),docno Varchar(150),entryby Varchar(150),
entrydt datetime,voucher_cancel Varchar(150),opertitle Varchar(1150),opertitle_cd Varchar(150),pbov_code Varchar(150),
pbov_name Varchar(150),pbov_typ Varchar(150),transtype Varchar(150),transtype_cd Varchar(150))


	if @RO='All' and @ORGNCD='All'  
	select @WhereCri = ''  
	else if @RO<>'All' and @ORGNCD='All'  
	select @WhereCri = ' and report_loc=' + char(39) + @RO + char(39)  
	else if @RO='All' and @ORGNCD<>'All'  
	select @WhereCri = ' and loccode= '+ char(39) + @ORGNCD + char(39)  
	else if @RO<>'All' and @ORGNCD<>'All'  
	select @WhereCri = 'and report_loc=' + char(39) + @RO + char(39) +' and loccode= '+ char(39) + @ORGNCD + char(39)  

	if @vochernolist='' and @docnolist=''
		begin
		select @whereDt=' and Convert(varchar,'+@DT_TYPE+',106) between Convert(datetime,'+char(39)+@fromdt+char(39)+',106) and Convert(datetime,'+char(39)+@TODT+char(39)+',106)  and '+@DT_TYPE+' is not null'
		if @vaouchertype<>'All'
			select @WhereVrTyp=' and opertitle_cd='+ char(39) + @vaouchertype + char(39)

		if @TRtype<>'All'
			select @WhereTRTyp=' and transtype_cd='+ char(39) + @TRtype + char(39)
		end
	else if  @vochernolist<>'' 	
		begin	
		select  @Where_List='and [dbo].[SplitWithSearch]('+char(39)+@vochernolist+char(39)+','+char(39)+','+char(39)+',Voucherno)='+char(39)+'1'+char(39)+''
		select @WhereCri=''
		select @whereDt=''
		end
	else if  @docnolist<>'' 
		begin
		select  @Where_List='and [dbo].[SplitWithSearch]('+char(39)+@docnolist+char(39)+','+char(39)+','+char(39)+',docno)='+char(39)+'1'+char(39)+''
		select @WhereCri=''
		select @whereDt=''
		end


delete from #VRList

select @SQLInsertData='insert into #VRList (voucherno,chqno,transdate,chqdate,debit,credit,Narration,brcd,docno,entryby,entrydt,voucher_cancel,opertitle,opertitle_cd,pbov_code,pbov_name,pbov_typ,transtype,transtype_cd)
select  Voucherno,chqno,transdate,chqdate=convert(varchar,chqdate,6),
debit=sum(isnull(debit,0)),credit=sum(isnull(credit,0)),
Narration,brcd,docno,entryby,convert(varchar,entrydt,6),voucher_cancel,opertitle,
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
when opertitle='+char(39)+'VENDOR PAYMENT'+char(39)+' then '+char(39)+'16'+char(39)+'
when opertitle= '+char(39)+'MISC BILL'+char(39)+' then '+char(39)+'17'+char(39)+'
when opertitle='+char(39)+'MANUAL JOURNAL VOUCHER'+char(39)+' then '+char(39)+'18'+char(39)+'
end),pbov_code,pbov_name,pbov_typ,transtype,
transtype_cd=(case when transtype='+char(39)+'Bank Payment'+char(39)+' or transtype='+char(39)+'BANK RECEIPT'+char(39)+' or transtype='+char(39)+'BANK RECIEPT'+char(39)+' then '+char(39)+'5'+char(39)+'
when transtype='+char(39)+'Cash'+char(39)+' or transtype='+char(39)+'Cash Payment'+char(39)+' or transtype='+char(39)+'Cash Receipt'+char(39)+' or transtype='+char(39)+'CASH RECIEPT'+char(39)+' then '+char(39)+'1'+char(39)+'
when transtype='+char(39)+'Cheque'+char(39)+' then '+char(39)+'2'+char(39)+'
when transtype='+char(39)+'Contra'+char(39)+' then '+char(39)+'4'+char(39)+'
when transtype='+char(39)+'Expenses'+char(39)+' then '+char(39)+'3'+char(39)+'
when transtype='+char(39)+'Journal'+char(39)+' then '+char(39)+'6'+char(39)+'  end )
 from webx_acctrans_'+@Finyear+' T with(NOLOCK)
inner join webx_location l on t.brcd=loccode where (isnull(debit,0)>0 or isnull(credit,0)>0) 
'+@WhereCri+@Where_List+@whereDt+' and isnull(Voucher_cancel,'+char(39)+'N'+char(39)+')='+char(39)+'N'+char(39)+'
group by Voucherno,transdate,chqno,chqdate,Narration,brcd,docno,entryby,convert(varchar,entrydt,6),voucher_cancel,opertitle,pbov_code,pbov_name,pbov_typ,transtype
'
exec(@SQLInsertData)


	select @SQL='select Voucherno=(case when t.transtype='+char(39)+'Journal'+char(39)+' then '+char(39)+'JV :'+char(39)+' + '+char(39)+' '+char(39)+' +  t.voucherno       
when t.transtype='+char(39)+'CASH RECIEPT'+char(39)+' then '+char(39)+'CSH - R :'+char(39)+' + '+char(39)+' '+char(39)+' +  t.voucherno       
when t.transtype='+char(39)+'Cash Payment'+char(39)+' then '+char(39)+'CSH - P :'+char(39)+' + '+char(39)+' '+char(39)+' +  t.voucherno       
when t.transtype='+char(39)+'Bank Payment'+char(39)+' then '+char(39)+'BK - P :'+char(39)+' + '+char(39)+' '+char(39)+' +  t.voucherno       
when t.transtype='+char(39)+'Bank Receipt'+char(39)+' then '+char(39)+'BK - R :'+char(39)+' + '+char(39)+' '+char(39)+' +  t.voucherno       
when t.transtype='+char(39)+'Credit Note'+char(39)+' then '+char(39)+'CN :'+char(39)+' + '+char(39)+' '+char(39)+' +  t.voucherno       
when t.transtype='+char(39)+'Debit note'+char(39)+' then '+char(39)+'DN :'+char(39)+' + '+char(39)+' '+char(39)+' +  t.voucherno       
when t.transtype='+char(39)+'Contra'+char(39)+' then '+char(39)+'CON :'+char(39)+' + '+char(39)+' '+char(39)+' +  t.voucherno       
when t.transtype='+char(39)+'Income'+char(39)+' then '+char(39)+'INC :'+char(39)+' + '+char(39)+' '+char(39)+' +  t.voucherno       
when t.transtype='+char(39)+'Expenses'+char(39)+' then '+char(39)+'EXP :'+char(39)+' + '+char(39)+' '+char(39)+' +  t.voucherno       
when t.transtype='+char(39)+'Sale'+char(39)+' then '+char(39)+'SA :'+char(39)+' + '+char(39)+' '+char(39)+' +  t.voucherno       
when t.transtype='+char(39)+'Purchase'+char(39)+' then '+char(39)+'PUR :'+char(39)+' + '+char(39)+' '+char(39)+' +  t.voucherno       
else t.voucherno End) ,chqno,transdate=convert(varchar,transdate,6),chqdate=convert(varchar,chqdate,6),debit=(isnull(debit,0)),credit=(isnull(credit,0)),Amt=(case when isnull(debit,0)>0 then isnull(debit,0) else isnull(credit,0) end),Narration,brcd,docno,entryby,entrydt=convert(varchar,entrydt,6),voucher_cancel,
opertitle,opertitle_str=(select top 1 codedesc from  webx_master_general with(NOLOCK) where codetype= '+char(39)+'TRNTYPE'+char(39)+' and T.opertitle_cd=codeid),opertitle_cd,pbov_code,pbov_name,pbov_typ,
transtype,transtype_str=(select top 1 codedesc from  webx_master_general with(NOLOCK) where codetype= '+char(39)+'VRTYPE'+char(39)+' and T.transtype_cd=codeid),transtype_cd
 from #VRList T with(NOLOCK) where (isnull(debit,0)>0 or isnull(credit,0)>0) '+@Where_List+@whereDt+@WhereVrTyp+@WhereTRTyp+'
order by transdate desc ,brcd,Voucherno 
'

--group by Voucherno,transdate,chqno,chqdate,Narration,brcd,docno,entryby,entrydt,voucher_cancel,opertitle,pbov_code,pbov_name,pbov_typ,transtype
exec(@SQL)
select @WhereCri,@Where_List,@whereDt,@WhereVrTyp,@WhereTRTyp

IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id = object_id(N'[tempdb]..[#VRList]'))                  
Drop table #VRList    
    


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

