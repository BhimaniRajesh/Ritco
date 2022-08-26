if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Webx_Missing_unUsed]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Webx_Missing_unUsed]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE Procedure Webx_Missing_unUsed
@fromdt varchar(100),
@todt varchar(100),
@RO varchar(100),
@ORGNCD varchar(100),
@dockno varchar(100)
AS
begin
Declare @sql varchar(6000);
Declare @whereCri varchar(1000);
Declare @dktstr varchar(1000);
Declare @paystr varchar(1000);


if @RO='All' and @ORGNCD='All'
select @whereCri = ''
else if @RO<>'All' and @ORGNCD='All'
select @whereCri = ' and d.report_loc=' + char(39) + @RO + char(39)
else if @RO<>'All' and @ORGNCD<>'All'
select @whereCri = 'and d.report_loc=' + char(39) + @RO + char(39) +' and d.loccode= '+ char(39) + @ORGNCD + char(39)
else if @RO='All' and @ORGNCD<>'All'
select @whereCri = 'and d.loccode= '+ char(39) + @ORGNCD + char(39)

if @dockno=''
begin
select @sql='select Book_Code,Series_From , Series_To,allocated_date,loccode,locname as locname,BA_Employee_name,BA_Employee,
total_leafs,used from VW_Missing_unUsed d with(NOLOCK) where 1=1 '+@whereCri+'
and Convert(varchar,updton,106) between Convert(datetime,' + char(39) + @FROMDT + char(39) + ',106) and Convert(datetime,' + char(39) + @TODT + char(39) + ',106)
order by loccode '
end
else
begin
select @sql='select Book_Code,Series_From , Series_To,allocated_date,loccode,locname as locname,BA_Employee_name,BA_Employee,
total_leafs,used from VW_Missing_unUsed d with(NOLOCK) where ' + @dockno + ' between Series_From and Series_To'
end

end
exec(@sql)




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VW_Missing_unUsed]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VW_Missing_unUsed]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


create view VW_Missing_unUsed
as
Select Book_Code,Series_From , Series_To,Book_Curr_Loc,allocated_date,d.updton,Allocated,AssignTo,
(Select Count(*) From WebX_master_Docket with(NOLOCK) where dockno between Series_From and Series_To) as used,
total_leafs,Alloted_By,Alloted_To,
BA_Employee=(Case When (Select Count(*) From WebX_Vendor_Hdr Where VendorCode=Alloted_To)>0 Then 'BA' when (Select Count(*) From WebX_master_users Where userid=Alloted_To)>0  then 'Employee' when Alloted_To is not null then 'Other' Else 'Not Allocated' End)  ,
BA_Employee_name=(Case When (Select Count(*) From WebX_Vendor_Hdr Where VendorCode=Alloted_To)>0 Then (Select VendorCode+' : '+Vendorname From WebX_Vendor_Hdr Where VendorCode=Alloted_To) when (Select Count(*) From WebX_master_users Where userid=Alloted_To)>0  then (Select userid+' : '+name From WebX_master_users Where userid=Alloted_To)  Else Alloted_To End)  ,
report_loc,loccode,locname
From vw_DCR_Series_new  D with(NOLOCK)
inner join webx_location l with(NOLOCK) on d.AssignTo =l.loccode
Where  Allocated='Y' and  Alloted_To not in (Select Loccode From webx_location)  

--sp_helptext vw_DCR_Series_new





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_Missing_Dockets_In_Range]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[usp_Missing_Dockets_In_Range]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE [dbo].[usp_Missing_Dockets_In_Range]   
@FromRange Varchar(15),  
@ToRange Varchar(15)  
AS  
  
SET NOCOUNT ON  
  
declare @lowwer as Varchar(15)  
declare @upper as Varchar(15)  
declare @count_abc   as Varchar(15)  
declare @cur as Varchar(15)  
  
set @lowwer =@FromRange   
set @upper = @ToRange   
  
set @cur =  @lowwer  
  
  
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id = object_id(N'[tempdb]..[#missing]'))  
Drop table #missing  
--temp table to hold list of missing  
create table #missing (  
Missing Varchar(15)  
--,NotMissing int   
)  
  
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id = object_id(N'[tempdb]..[#Dockets]'))  
Drop table #Dockets  
-- temp table to hold your range  
create table #Dockets(  
DockNo Varchar(15)  
)  
  
insert into #Dockets (DockNo)  
select DockNo from [webx_master_docket]  with(NOLOCK)   
where   
--DockNo like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9]' and   
DockNo between @lowwer and @upper  
-- and any other filter you think would be handy  
  
While( @cur between @lowwer and @upper)  
Begin --while  
  
if not exists (select DockNo from #Dockets  
where DockNo = @cur)   
Begin --if  
  Begin --if  
  select @count_abc=count(*) from  webx_master_docket with(NOLOCK)  where dockno  between @cur and @upper    
  --select @count_abc  
    
  if @count_abc>1   
  insert into #missing (Missing) values (@cur)  
  End --if  
End --if  
-- else  
-- Begin --else  
-- insert into #missing (NotMissing) values (@cur)  
-- End --else  
  
set @cur = [dbo].MyDockAddSub(@cur,1)  
  
--select @cur  
  
End --while  
-- return the results  
select * from #missing with(NOLOCK)   
--clean up  
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id = object_id(N'[tempdb]..[#missing]'))  
Drop table #missing  
  
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id = object_id(N'[tempdb]..[#Dockets]'))  
Drop table #Dockets

  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_UNUsed_Dockets_In_Range]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[usp_UNUsed_Dockets_In_Range]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


create PROCEDURE [dbo].[usp_UNUsed_Dockets_In_Range]   
@FromRange Varchar(15),  
@ToRange Varchar(15)  
AS  
  
SET NOCOUNT ON  
  
declare @lowwer as Varchar(15)  
declare @upper as Varchar(15)  
declare @count_abc   as Varchar(15)  
declare @cur as Varchar(15)  
  
set @lowwer =@FromRange   
set @upper = @ToRange   
  
set @cur =  @lowwer  
  
  
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id = object_id(N'[tempdb]..[#missing]'))  
Drop table #missing  
--temp table to hold list of missing  
create table #missing (  
Missing Varchar(15)  
--,NotMissing int   
)  
  
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id = object_id(N'[tempdb]..[#Dockets]'))  
Drop table #Dockets  
-- temp table to hold your range  
create table #Dockets(  
DockNo Varchar(15)  
)  
  
insert into #Dockets (DockNo)  
select DockNo from [webx_master_docket]  with(NOLOCK)   
where   
--DockNo like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9]' and   
DockNo between @lowwer and @upper  
-- and any other filter you think would be handy  
  
While( @cur between @lowwer and @upper)  
Begin --while  
  
if not exists (select DockNo from #Dockets  
where DockNo = @cur)   
Begin --if  
  --Begin --if  
  --select @count_abc=count(*) from  webx_master_docket with(NOLOCK)  where dockno  between @cur and @upper    
  --select @count_abc  
    
  --if @count_abc>1   
  insert into #missing (Missing) values (@cur)  
 -- End --if  
End --if  
-- else  
-- Begin --else  
-- insert into #missing (NotMissing) values (@cur)  
-- End --else  
  
set @cur = [dbo].MyDockAddSub(@cur,1)  
  
--select @cur  
  
End --while  
-- return the results  
select * from #missing with(NOLOCK)   
--clean up  
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id = object_id(N'[tempdb]..[#missing]'))  
Drop table #missing  
  
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id = object_id(N'[tempdb]..[#Dockets]'))  
Drop table #Dockets

  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

