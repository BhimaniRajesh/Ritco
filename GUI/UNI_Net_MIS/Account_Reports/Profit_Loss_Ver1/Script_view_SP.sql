if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Locations]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Locations]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/****** Object:  View dbo.vw_Locations    Script Date: 11/28/2007 3:54:05 PM ******/

/****** Object:  View dbo.vw_Locations    Script Date: 10/25/2007 6:18:22 PM ******/
CREATE View vw_Locations
As
/*
Select WMG.CodeDesc,WMLD.*
From
WebX_Master_Location_Details WMLD
Inner Join
WebX_Master_General WMG
On WMLD.LocCode = WMG.CodeID
Where WMG.StatusCode='Y'
*/
Select LocCode,CodeDesc = LocName,DataEntry From WebX_Location Where ActiveFlag='Y'



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Webx_profitloss_closingbalance_Net]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Webx_profitloss_closingbalance_Net]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Webx_profitloss_closingbalance_Net_Ver1]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Webx_profitloss_closingbalance_Net_Ver1]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[webx_ProfitLoss_ver3]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[webx_ProfitLoss_ver3]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create  Procedure [dbo].[Webx_profitloss_closingbalance_Net]          
@mTableName_Trans varchar(100),              
@mTableName_Acct varchar(100),              
@brcd varchar(7),              
@closedt varchar(12),              
@individual varchar(1),          
@fromdt varchar(12)             
as              
set nocount on              
begin              
Declare @sql varchar(3000);       
--Declare @WhereCri varchar(3000);       
--if @brcd =''      
 --Select @WhereCri = ' + char(39) +  'brcd' + char(39) +'      
--else      
 --select @WhereCri = ' + char(39) +  @brcd + char(39) +' as brcd      
      
            
    truncate table webx_closing_balance_pf          
    if @individual='N'              
              select @sql='insert into webx_closing_balance_pf select  t.brcd,a.acccode,sum(debit) as debit , sum(credit) as credit     
From ' + @mTableName_Trans + ' t WITH (NOLOCK)
inner join ' + @mTableName_Acct + ' a   WITH (NOLOCK) on  a.acccode=t.acccode
inner join webx_groups G WITH (NOLOCK) on  a.groupcode  =G.groupcode 
where   convert(varchar,transdate,106)  between convert(datetime,' + char(39) +  @fromdt + char(39) +',106) and convert(datetime,' + char(39) +  @closedt + char(39) + ',106)     
and voucher_cancel=' + char(39) + 'N' + char(39) + '        
   and (substring(G.PARENTCODE,1,3) =''INC'' or substring(G.PARENTCODE,1,3) =''EXP'' ) group by G.PARENTCODE,a.acccode,t.brcd order by G.PARENTCODE,t.brcd,a.acccode'              
    else               
              select @sql='insert into webx_closing_balance_pf select ' + char(39) + @brcd + char(39) + '  as brcd,a.acccode,sum(debit) as debit , sum(credit) as credit     
From ' + @mTableName_Trans + ' t WITH (NOLOCK)
inner join ' + @mTableName_Acct + ' a   WITH (NOLOCK) on  a.acccode=t.acccode
inner join webx_groups G WITH (NOLOCK) on  a.groupcode  =G.groupcode 
  t.brcd='+ char(39) +  @brcd + char(39) + ' and voucher_cancel=' + char(39) + 'N' + char(39) + ' and convert(varchar,transdate,106) between convert(datetime,' + char(39) +  @fromdt + char(39) +',106)        
  and  convert(datetime,' + char(39) +  @closedt + char(39) + ',106)   and (substring(G.PARENTCODE,1,3) =''INC'' or substring(G.PARENTCODE,1,3) =''EXP'' ) group by G.PARENTCODE,a.acccode  order by G.PARENTCODE,a.acccode'              
    execute(@sql)              
    --select @WhereCri              
end    
  
  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



create Procedure [dbo].[Webx_profitloss_closingbalance_Net_Ver1]            
@mTableName_Trans varchar(100),                
@mTableName_Acct varchar(100),                
@brcd varchar(7),                
@closedt varchar(12),                
@individual varchar(1),            
@fromdt varchar(12)               
as                
set nocount on                
begin                
Declare @sql varchar(3000);         
--Declare @WhereCri varchar(3000);         
--if @brcd =''        
 --Select @WhereCri = ' + char(39) +  'brcd' + char(39) +'        
--else        
 --select @WhereCri = ' + char(39) +  @brcd + char(39) +' as brcd        
        
              
    truncate table webx_closing_balance_pf            
    if @individual='N'                
              select @sql='insert into webx_closing_balance_pf select  t.brcd,a.acccode,sum(debit) as debit , sum(credit) as credit       
From ' + @mTableName_Trans + ' t WITH (NOLOCK)
inner join ' + @mTableName_Acct + ' a   WITH (NOLOCK) on  a.acccode=t.acccode
inner join webx_groups G WITH (NOLOCK) on  a.groupcode  =G.groupcode 
where convert(varchar,transdate,106)  between convert(datetime,' + char(39) +  @fromdt + char(39) +',106) and convert(datetime,' + char(39) +  @closedt + char(39) + ',106)       
and voucher_cancel=' + char(39) + 'N' + char(39) + '          
   and (substring(G.PARENTCODE,1,3) =''INC'' or substring(G.PARENTCODE,1,3) =''EXP'' )   
and t.brcd in (select distinct loccode from webx_location where report_loc='+ char(39) +  @brcd + char(39) + '   
or report_loc in (select loccode from webx_location where report_loc='+ char(39) +  @brcd + char(39) + '  ) or Loccode='+ char(39) +  @brcd + char(39) + ' Or  
report_loc in (select loccode from webx_location where report_loc in (select loccode from webx_location where report_loc='+ char(39) +  @brcd + char(39) + '  ) ))  
group by G.PARENTCODE,a.acccode,t.brcd order by G.PARENTCODE,t.brcd,a.acccode  
'                
    else                 
              select @sql='insert into webx_closing_balance_pf select ' + char(39) + @brcd + char(39) + '  as brcd,a.acccode,sum(debit) as debit , sum(credit) as credit       
From ' + @mTableName_Trans + ' t WITH (NOLOCK)
inner join ' + @mTableName_Acct + ' a   WITH (NOLOCK) on  a.acccode=t.acccode
inner join webx_groups G WITH (NOLOCK) on  a.groupcode  =G.groupcode 
where t.brcd='+ char(39) +  @brcd + char(39) + ' and voucher_cancel=' + char(39) + 'N' + char(39) + ' and convert(varchar,transdate,106) between convert(datetime,' + char(39) +  @fromdt + char(39) +',106)          
  and  convert(datetime,' + char(39) +  @closedt + char(39) + ',106)   and (substring(G.PARENTCODE,1,3) =''INC'' or substring(G.PARENTCODE,1,3) =''EXP'' ) group by G.PARENTCODE,a.acccode  order by G.PARENTCODE,a.acccode'                
    execute(@sql)                
    --select @WhereCri                
end      
    
  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO





--exec Webx_profitloss_closingbalance_Net 'webx_acctrans_07_08','webx_acctinfo','HQTR','31 March 08','Y','02 Apr 07'
--exec webx_ProfitLoss_ver3 '%%','N','Y'
--exec webx_ProfitLoss_ver3 '%BOMR%','N','Y'
--exec webx_ProfitLoss_ver3 '%AMDR%','N','Y'
--select loccode,locname from VW_Location with(NOLOCK) where  Report_loc like '%AMDR%' order by Report_loc,loc_level
create Procedure webx_ProfitLoss_ver3
@RO varchar(200),
@GRP_WISE varchar(200),
@CUM_WISE varchar(200)
as

--declare @GRP_WISE varchar(100)
--set @GRP_WISE='N'
--declare @CUM_WISE varchar(100)
--set @CUM_WISE='Y'
--declare @RO varchar(100)
--set @RO='%BOMR%'

declare @grpcd varchar(100)
declare @Parentcd varchar(100)
declare @Parentcd_Curr varchar(100)
declare @Parentcd_prev varchar(100)
declare @INC_EXP varchar(100)
declare @groupdesc varchar(1000)
declare @groupcode varchar(100)
declare @credit float
declare @debit float
declare @credit_i float
declare @debit_i float
declare @G_P_N_L varchar(100)
declare @ACCcd varchar(100)
declare @ACCdesc varchar(1000)
declare @ACCcode varchar(100)


--select @WHERE_RO = ' where  Report_loc like '+ @RO         

IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id = object_id(N'[tempdb]..[#PRO_N_LOSS]'))    
Drop table #PRO_N_LOSS  
--temp table to hold list of missing    
create table #PRO_N_LOSS (    
CAT Varchar(150),Grpcd Varchar(150) ,grpdesc Varchar(150),grpcd1 Varchar(150),
ACCcd Varchar(150) ,ACCdesc Varchar(150),ACCcd1 Varchar(150) ,credit  Varchar(150),debit  Varchar(150),P_N_L Varchar(150)
  
) 
if @CUM_WISE='Y'
begin 

Declare @Loccode varchar(100);
Declare  @SQL_SUBGRP varchar(8000);
Declare  @SQL_LOC varchar(8000);
DECLARE my_cursor_1 CURSOR FOR 

select lcd from VW_Location with(NOLOCK) where  Report_loc like @RO order by Report_loc,loc_level

OPEN my_cursor_1    
FETCH NEXT FROM my_cursor_1                 
INTO 
@Loccode
BEGIN  
	--
	 WHILE @@FETCH_STATUS = 0       
	  BEGIN 	
		declare @SQL_CL varchar (5000);
		select @SQL_CL='alter table #PRO_N_LOSS add  '+@Loccode+' numeric(9,2)'
		exec(@SQL_CL)
 	 FETCH NEXT FROM my_cursor_1                 
	 INTO                 
		@Loccode
	  END      
END   
CLOSE my_cursor_1                
DEALLOCATE my_cursor_1   
end
--select * from #PRO_N_LOSS
   
select @Parentcd_Curr=''
select @Parentcd_prev=''
DECLARE my_cursor_2 CURSOR FOR 
----------------Start------Main Group Query
--select isnull(company_groupcode,groupcode) as grpcd,groupdesc,groupcode,left(isnull(parentcode,groupcode),3) from webx_groups  where left(isnull(parentcode,groupcode),3)='INC'  or left(isnull(parentcode,groupcode),3)='EXP' order by left(isnull(parentcode,groupcode),3) desc
select isnull(company_groupcode,a.groupcode) as grpcd,groupdesc,a.groupcode,left(isnull(a.parentcode,a.groupcode),3),
credit=convert(varchar,convert(money,sum(isnull(credit,0)),2)),
debit=convert(varchar,convert(money,sum(isnull(debit,0)),2)),
P_N_L=convert(varchar,convert(money,(isnull((case when left(isnull(a.parentcode,a.groupcode),3)='INC' then (case when sum(isnull(t.credit,0) - isnull(t.debit,0)) >0  then sum(isnull(t.credit,0) - isnull(t.debit,0)) when sum(isnull(t.credit,0) - isnull(t.debit,0)) >0  then '('+sum(isnull(t.debit,0) - isnull(t.credit,0))+')'  end )  
when left(isnull(a.parentcode,a.groupcode),3)='EXP' then (case when sum(isnull(t.debit,0) - isnull(t.credit,0)) >0  then sum(isnull(t.debit,0) - isnull(t.credit,0)) when sum(isnull(t.debit,0) - isnull(t.credit,0)) >0  then '('+sum(isnull(t.credit,0) - isnull(t.debit,0))+')'  end )   end ),0)),2))
from webx_groups a with(NOLOCK) 
left outer join VW_P_AND_L t with(NOLOCK)  on a.groupcode=t.groupcode 
where left(isnull(a.parentcode,a.groupcode),3)='INC'  or left(isnull(a.parentcode,a.groupcode),3)='EXP' group by a.groupcode,a.parentcode,company_groupcode,groupdesc order by left(isnull(a.parentcode,a.groupcode),3) desc
----------------END------Main Group Query 
Insert into #PRO_N_LOSS(grpcd) Select 'INCOME'
-----------------Cursor Start
OPEN my_cursor_2    
FETCH NEXT FROM my_cursor_2                 
INTO 
@grpcd,@groupdesc,@groupcode,@Parentcd,@credit,@debit,@G_P_N_L
BEGIN  
	--
	 WHILE @@FETCH_STATUS = 0       
	  BEGIN 
		
		if @Parentcd_Curr<>@Parentcd_prev and @Parentcd_prev<>''
		begin
			--select 'ABC'
			if @Parentcd_Curr='INC'
			--Insert into #PRO_N_LOSS(CAT,credit,debit,P_N_L) select 'Total InCome',convert(varchar,convert(money,isnull(@tot_income_CR,0),2)),convert(varchar,convert(money,isnull(@tot_income_DR,0),2)),convert(varchar,convert(money,isnull(@tot_income_CR,0)-isnull(@tot_income_DR,0),2))--convert(varchar,convert(money,isnull(@tot_income_DR,0),2))--,isnull(@tot_income_CR,0)-isnull(@tot_income_DR,0)					
			select @SQL_SUBGRP='Insert into #PRO_N_LOSS select null,'+char(39)+'Total INCOME'+char(39)+',null,null,null,null,null,convert(varchar,convert(money,sum(c),2)),convert(varchar,convert(money,sum(d),2)),convert(varchar,convert(money,sum(P),2))'
			if @CUM_WISE='Y'
			begin 
			
			Declare @Loccode5 varchar(100);
			DECLARE my_cursor_1 CURSOR FOR 
			
			select loccode from VW_Location with(NOLOCK) where  Report_loc like @RO order by Report_loc,loc_level

			OPEN my_cursor_1    
			FETCH NEXT FROM my_cursor_1                 
			INTO 
			@Loccode5
			BEGIN  
				--
				 WHILE @@FETCH_STATUS = 0       
				  BEGIN 	
					select @SQL_SUBGRP=@SQL_SUBGRP + ',sum(case when br='+char(39)+@Loccode5+char(39)+' then convert(money,P,2) end)'
			 	 FETCH NEXT FROM my_cursor_1                 
				 INTO                 
					@Loccode5
				  END      
			END   
			CLOSE my_cursor_1                
			DEALLOCATE my_cursor_1   
			end
			select @SQL_SUBGRP=@SQL_SUBGRP + ' from VW_P_AND_L_GRP a with(NOLOCK)
			 where parcd='+char(39)+'INC'+char(39)+' group by parcd '	
			--select @SQL_SUBGRP
			exec(@SQL_SUBGRP)
			Insert into #PRO_N_LOSS(grpcd) Select ''
			Insert into #PRO_N_LOSS(grpcd) Select 'EXPENSE'
		end 
		select @Parentcd_Curr = @Parentcd
			--Insert into #PRO_N_LOSS(CAT,Grpcd,grpdesc,grpcd1,credit,debit,P_N_L) select @Parentcd,@grpcd,@groupdesc,@groupcode,convert(varchar,convert(money,isnull(@credit,0),2)),convert(varchar,convert(money,isnull(@debit,0),2)),convert(varchar,convert(money,isnull(@G_P_N_L,0),2))

			select @SQL_SUBGRP='Insert into #PRO_N_LOSS select null,gcd,gnm,gcd1,null,null,null,convert(varchar,convert(money,sum(c),2)),convert(varchar,convert(money,sum(d),2)),convert(varchar,convert(money,sum(P),2))'
			if @CUM_WISE='Y'
			begin 
			
			Declare @Loccode4 varchar(100);
			DECLARE my_cursor_1 CURSOR FOR 
			
			select loccode from VW_Location with(NOLOCK) where  Report_loc like @RO order by Report_loc,loc_level

			OPEN my_cursor_1    
			FETCH NEXT FROM my_cursor_1                 
			INTO 
			@Loccode4
			BEGIN  
				--
				 WHILE @@FETCH_STATUS = 0       
				  BEGIN 	
					select @SQL_SUBGRP=@SQL_SUBGRP + ',sum(case when br='+char(39)+@Loccode4+char(39)+' then convert(money,P,2) end)'
			 	 FETCH NEXT FROM my_cursor_1                 
				 INTO                 
					@Loccode4
				  END      
			END   
			CLOSE my_cursor_1                
			DEALLOCATE my_cursor_1   
			end
			select @SQL_SUBGRP=@SQL_SUBGRP + ' from VW_P_AND_L_GRP a with(NOLOCK)
			 where a.gcd1='+char(39)+@groupcode+char(39)+' group by parcd,gcd,gnm,gcd1 '	
			--select @SQL_SUBGRP
			exec(@SQL_SUBGRP)
			
	if @GRP_WISE='N'
	begin
	select @SQL_SUBGRP='Insert into #PRO_N_LOSS select null,null,null,null,acccode1,accdesc,acccode,convert(varchar,convert(money,sum(credit),2)),convert(varchar,convert(money,sum(debit),2)),convert(varchar,convert(money,sum(P),2))'
		if @CUM_WISE='Y'
		begin 
		
		Declare @Loccode1 varchar(100);
		DECLARE my_cursor_1 CURSOR FOR 
		
		select loccode from VW_Location with(NOLOCK) where  Report_loc like @RO order by Report_loc,loc_level

		OPEN my_cursor_1    
		FETCH NEXT FROM my_cursor_1                 
		INTO 
		@Loccode1
		BEGIN  
			--
			 WHILE @@FETCH_STATUS = 0       
			  BEGIN 	
				select @SQL_SUBGRP=@SQL_SUBGRP + ',sum(case when br='+char(39)+@Loccode1+char(39)+' then convert(money,P,2) end)'
		 	 FETCH NEXT FROM my_cursor_1                 
			 INTO                 
				@Loccode1
			  END      
		END   
		CLOSE my_cursor_1                
		DEALLOCATE my_cursor_1   
		end
		select @SQL_SUBGRP=@SQL_SUBGRP + ' from VW_P_AND_L_SUBGRP a with(NOLOCK)
		 where a.groupcode='+char(39)+@groupcode+char(39)+' and (credit>0 or debit>0) group by acccode1,accdesc,acccode	'	
		--select @SQL_SUBGRP
		exec(@SQL_SUBGRP)
		
	end
	 FETCH NEXT FROM my_cursor_2                 
	 INTO                 
	 @grpcd,@groupdesc,@groupcode,@Parentcd,@credit,@debit,@G_P_N_L
	   
	 select @Parentcd_prev = @Parentcd
	--select 	@Parentcd_Curr , @Parentcd_prev,@Parentcd
	 END   

	
   
END   

CLOSE my_cursor_2                
DEALLOCATE my_cursor_2   
--Insert into #PRO_N_LOSS(CAT,credit,debit,P_N_L) select 'Total Expense',convert(varchar,convert(money,isnull(@tot_EXP_CR,0),2)),convert(varchar,convert(money,isnull(@tot_EXP_DR,0),2)),convert(varchar,convert(money,isnull(@tot_EXP_DR,0)-isnull(@tot_EXP_CR,0),2))--convert(varchar,convert(money,isnull(@tot_income_DR,0),2))--,isnull(@tot_income_CR,0)-isnull(@tot_income_DR,0)					
select @SQL_SUBGRP='Insert into #PRO_N_LOSS select null,'+char(39)+'Total EXPENSE'+char(39)+',null,null,null,null,null,convert(varchar,convert(money,sum(c),2)),convert(varchar,convert(money,sum(d),2)),convert(varchar,convert(money,sum(P),2))'
			if @CUM_WISE='Y'
			begin 
			
			Declare @Loccode6 varchar(100);
			DECLARE my_cursor_1 CURSOR FOR 
			
			select loccode from VW_Location with(NOLOCK) where  Report_loc like @RO order by Report_loc,loc_level

			OPEN my_cursor_1    
			FETCH NEXT FROM my_cursor_1                 
			INTO 
			@Loccode6
			BEGIN  
				--
				 WHILE @@FETCH_STATUS = 0       
				  BEGIN 	
					select @SQL_SUBGRP=@SQL_SUBGRP + ',sum(case when br='+char(39)+@Loccode6+char(39)+' then convert(money,P,2) end)'
			 	 FETCH NEXT FROM my_cursor_1                 
				 INTO                 
					@Loccode6
				  END      
			END   
			CLOSE my_cursor_1                
			DEALLOCATE my_cursor_1   
			end
			select @SQL_SUBGRP=@SQL_SUBGRP + ' from VW_P_AND_L_GRP a with(NOLOCK)
			 where parcd='+char(39)+'EXP'+char(39)+' group by parcd '	
			--select @SQL_SUBGRP
			exec(@SQL_SUBGRP)
Insert into #PRO_N_LOSS(CAT) Select ''
---Insert into #PRO_N_LOSS(CAT,credit,debit,P_N_L) select 'Total InCome',convert(varchar,convert(money,isnull(@tot_income_CR,0),2)),convert(varchar,convert(money,isnull(@tot_income_DR,0),2)),convert(varchar,convert(money,isnull(@tot_income_CR,0)-isnull(@tot_income_DR,0),2))--convert(varchar,convert(money,isnull(@tot_income_DR,0),2))--,isnull(@tot_income_CR,0)-isnull(@tot_income_DR,0)					
--Insert into #PRO_N_LOSS(CAT,credit,debit,P_N_L) select 'Profit',convert(varchar,convert(money,isnull(@tot_income_CR,0)-isnull(@tot_EXP_CR,0),2)),convert(varchar,convert(money,isnull(@tot_income_DR,0)-isnull(@tot_EXP_DR,0),2)),(case when ((isnull(@tot_income_CR,0)-isnull(@tot_income_DR,0))-(isnull(@tot_EXP_DR,0)-isnull(@tot_EXP_CR,0))) >0 then convert(varchar,convert(money,(isnull(@tot_income_CR,0)-isnull(@tot_income_DR,0))-(isnull(@tot_EXP_DR,0)-isnull(@tot_EXP_CR,0)),2)) else '('+ convert(varchar,convert(money,(isnull(@tot_EXP_DR,0)-isnull(@tot_EXP_CR,0))-(isnull(@tot_income_CR,0)-isnull(@tot_income_DR,0)),2))+')' end)--convert(varchar,convert(money,isnull(@tot_income_DR,0),2))--,isnull(@tot_income_CR,0)-isnull(@tot_income_DR,0)					
select @SQL_SUBGRP='Insert into #PRO_N_LOSS select null,'+char(39)+'Profit/(Loss)'+char(39)+',null,null,null,null,null,convert(varchar,convert(money,sum(c),2)),convert(varchar,convert(money,sum(d),2)),convert(varchar,convert(money,sum(l),2))'
			if @CUM_WISE='Y'
			begin 
			
			Declare @Loccode7 varchar(100);
			DECLARE my_cursor_1 CURSOR FOR 
			
			select loccode from VW_Location with(NOLOCK) where  Report_loc like @RO order by Report_loc,loc_level

			OPEN my_cursor_1    
			FETCH NEXT FROM my_cursor_1                 
			INTO 
			@Loccode7
			BEGIN  
				--
				 WHILE @@FETCH_STATUS = 0       
				  BEGIN 	
					select @SQL_SUBGRP=@SQL_SUBGRP + ',sum(case when br='+char(39)+@Loccode7+char(39)+' then convert(money,l,2) end)'
			 	 FETCH NEXT FROM my_cursor_1                 
				 INTO                 
					@Loccode7
				  END      
			END   
			CLOSE my_cursor_1                
			DEALLOCATE my_cursor_1   
			end
			select @SQL_SUBGRP=@SQL_SUBGRP + ' from VW_P_AND_L_GRP a with(NOLOCK)
			 where parcd='+char(39)+'INC'+char(39)+' or parcd='+char(39)+'EXP'+char(39)+'   '	
			--select @SQL_SUBGRP
			exec(@SQL_SUBGRP)

--Insert into #PRO_N_LOSS(CAT) select 'Total EXP'CAT=isnull(CAT,'+char(39)+''+char(39)+'),
--select CAT=isnull(CAT,''),grpcd=isnull(grpcd,''),grpdesc=isnull(grpdesc,''),grpcd1=isnull(grpcd1,''),acccd=isnull(acccd,''),accdesc=isnull(accdesc,''),acccd1=isnull(acccd1,''),credit= convert(varchar,convert(money,isnull(credit,0),2)),debit=convert(varchar,convert(money,isnull(debit,0),2)),P_N_L from #PRO_N_LOSS    
--select * from #PRO_N_LOSS
select @SQL_SUBGRP='select grpcd=isnull(grpcd,'+char(39)+''+char(39)+'),grpdesc=isnull(grpdesc,'+char(39)+''+char(39)+'),grpcd1=isnull(grpcd1,'+char(39)+''+char(39)+'),acccd=isnull(acccd,'+char(39)+''+char(39)+'),accdesc=isnull(accdesc,'+char(39)+''+char(39)+'),acccd1=isnull(acccd1,'+char(39)+''+char(39)+'),credit= convert(varchar,convert(money,isnull(credit,0),2)),debit=convert(varchar,convert(money,isnull(debit,0),2)),P_N_L=isnull(P_N_L,0.00) '
		if @CUM_WISE='Y'
		begin 
		
		Declare @Loccode2 varchar(100);
		DECLARE my_cursor_1 CURSOR FOR 
		
		select lcd from VW_Location with(NOLOCK) where  Report_loc like @RO order by Report_loc,loc_level

		OPEN my_cursor_1    
		FETCH NEXT FROM my_cursor_1                 
		INTO 
		@Loccode2
		BEGIN  
			--
			 WHILE @@FETCH_STATUS = 0       
			  BEGIN 	
				select @SQL_SUBGRP=@SQL_SUBGRP + ','+@Loccode2+'=isnull('+@Loccode2+',0)'
		 	 FETCH NEXT FROM my_cursor_1                 
			 INTO                 
				@Loccode2
			  END      
		END   
		CLOSE my_cursor_1                
		DEALLOCATE my_cursor_1   
		end
		select @SQL_SUBGRP=@SQL_SUBGRP + ' from  #PRO_N_LOSS   '	
		--select @SQL_SUBGRP
		exec(@SQL_SUBGRP)
--clean up    
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id = object_id(N'[tempdb]..[#PRO_N_LOSS]'))    
Drop table #PRO_N_LOSS   













GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

