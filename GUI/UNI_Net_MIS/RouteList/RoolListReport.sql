ALTER proc WebxNet_RutMaster_det    
@RT_STBR varchar(50),    
@RT_ENDBR varchar(50),    
@RT_ENTBR varchar(50),    
@RT_No varchar(5000)    
as    
Declare @RUTCD Varchar(50),@RUTSTBR Varchar(150) ,@RUTENDBR Varchar(150),@RUTNM Varchar(150),@Dist Varchar(50),@Time Varchar(15)    
Declare @MAXCnt Numeric(12,2),@RUTCnt varchar(50),@RUTTRNCD varchar(50),@TR_RUTNO varchar(5),@ControlLoc Varchar(50)    
Declare @SQL_COLUMN varchar(8000);    
Declare @BR varchar(50),@DS varchar(50),@TM varchar(50),@DTM varchar(50)    
Declare @STD_CONTAMT varchar(50)    
    
    
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id = object_id(N'[tempdb]..[#RUTMAS]'))    
Drop table #RUTMAS    
--temp table to hold list of missing    
create table #RUTMAS ( [srno] [numeric](18, 0) IDENTITY (1, 1) NOT NULL,    
RUTCD Varchar(50),ControlLoc Varchar(50),RUTSTBR Varchar(150) ,RUTENDBR Varchar(150),RUTNM Varchar(150),STD_CONTAMT Varchar(50)    
)    
    
select top 1 @RUTCnt=rutcd from webx_ruttran with(NOLOCK)    
where rutcd in (select rutcd from webx_rutmas    
where RutSTBR like @RT_STBR    
and RUTENDBR like @RT_ENDBR    
and RUTNM like @RT_ENTBR    
and RUTCD like @RT_No) group by rutcd order by count(*) desc    
-----------------------//////////////////////////ADD Branch column    
DECLARE my_cursor CURSOR FOR    
    
select distinct RUTNO from webx_ruttran with(NOLOCK) where RUTCD=@RUTCnt order by rutno    
OPEN my_cursor    
FETCH NEXT FROM my_cursor    
INTO    
@RUTTRNCD    
BEGIN    
--    
WHILE @@FETCH_STATUS = 0    
BEGIN    
declare @SQL_CL varchar (5000);    
select @SQL_CL='alter table #RUTMAS add Branch_'+@RUTTRNCD+' Varchar(50)'    
exec(@SQL_CL)    
FETCH NEXT FROM my_cursor    
INTO    
@RUTTRNCD    
END    
END    
CLOSE my_cursor    
DEALLOCATE my_cursor    
    
    
    
-----------------------//////////////////////////ADD Distance column    
DECLARE my_cursor_D CURSOR FOR    
    
select distinct RUTNO from webx_ruttran with(NOLOCK) where RUTCD=@RUTCnt order by rutno    
OPEN my_cursor_D    
FETCH NEXT FROM my_cursor_D    
INTO    
@RUTTRNCD    
BEGIN    
--    
WHILE @@FETCH_STATUS = 0    
BEGIN    
select @SQL_CL =''    
select @SQL_CL='alter table #RUTMAS add Dist_'+@RUTTRNCD+' Varchar(50)'    
exec(@SQL_CL)    
FETCH NEXT FROM my_cursor_D    
INTO    
@RUTTRNCD    
END    
END    
CLOSE my_cursor_D    
DEALLOCATE my_cursor_D    
select @SQL_CL =''    
select @SQL_CL='alter table #RUTMAS add TOT_Dist Varchar(50)'    
exec(@SQL_CL)    
    
-----------------------//////////////////////////ADD Time column    
    
    
DECLARE my_cursor_T CURSOR FOR    
    
select distinct RUTNO from webx_ruttran with(NOLOCK) where RUTCD=@RUTCnt order by rutno    
OPEN my_cursor_T    
FETCH NEXT FROM my_cursor_T    
INTO    
@RUTTRNCD    
BEGIN    
--    
WHILE @@FETCH_STATUS = 0    
BEGIN    
select @SQL_CL =''    
select @SQL_CL='alter table #RUTMAS add Time_'+@RUTTRNCD+' Varchar(50)'    
exec(@SQL_CL)    
FETCH NEXT FROM my_cursor_T    
INTO    
@RUTTRNCD    
END    
END    
CLOSE my_cursor_T    
DEALLOCATE my_cursor_T    
select @SQL_CL =''    
select @SQL_CL='alter table #RUTMAS add TOT_Time Varchar(50)'    
exec(@SQL_CL)    
    
-----------------------//////////////////////////END ADD Column    
    
DECLARE my_cursor_DT CURSOR FOR    
    
select distinct RUTNO from webx_ruttran with(NOLOCK) where RUTCD=@RUTCnt order by rutno    
OPEN my_cursor_DT    
FETCH NEXT FROM my_cursor_DT    
INTO    
@RUTTRNCD    
BEGIN    
--    
WHILE @@FETCH_STATUS = 0    
BEGIN    
select @SQL_CL =''    
select @SQL_CL='alter table #RUTMAS add DeptTime_'+@RUTTRNCD+' Varchar(50)'    
exec(@SQL_CL)    
FETCH NEXT FROM my_cursor_DT    
INTO    
@RUTTRNCD    
END    
END    
CLOSE my_cursor_DT    
DEALLOCATE my_cursor_DT    
--select @SQL_CL =''    
--select @SQL_CL='alter table #RUTMAS add TOT_Time Varchar(50)'    
--exec(@SQL_CL)    
-----------------------//////////////////////////    
    
DECLARE my_cursor_1 CURSOR FOR    
    
    
select R.RUTCD,ControlLoc,RUTSTBR,RUTENDBR,RUTNM,TOTDIST,TOTTIme=(convert(varchar,TOTTIme/60)+':'+convert(varchar,TOTTIme%60)),STD_CONTAMT from webx_rutmas R with(NOLOCK)    
inner join( select TOTDIST=SUM(isnull(Dist_km,0)),TOTTIme=sum(isnull(trtime_min,0)+isnull(trtime_hr,0)*60),rutcd from webx_ruttran with(NOLOCK) group by rutcd)TR on R.rutcd=tr.rutcd    
where R.RutSTBR like @RT_STBR    
and R.RUTENDBR like @RT_ENDBR    
and R.RUTNM like @RT_ENTBR    
and R.RUTCD like @RT_No    
    
order by r.RUTCD    
    
OPEN my_cursor_1    
FETCH NEXT FROM my_cursor_1    
INTO    
@RUTCD,@ControlLoc,@RUTSTBR,@RUTENDBR,@RUTNM,@Dist,@Time,@STD_CONTAMT    
BEGIN    
--    
WHILE @@FETCH_STATUS = 0    
BEGIN    
    
insert into #RUTMAS(RUTCD,ControlLoc,RUTSTBR,RUTENDBR,RUTNM,TOT_Dist,TOT_Time,STD_CONTAMT) select @RUTCD,@ControlLoc,@RUTSTBR,@RUTENDBR,@RUTNM,@Dist,@Time,@STD_CONTAMT    
    
DECLARE my_cursor_TR CURSOR FOR    
    
select distinct RUTNO,LOCCD,dist_km,TOTTIme=(convert(varchar,(isnull(trtime_min,0)+isnull(trtime_hr,0)*60)/60)+':'+convert(varchar,(isnull(trtime_min,0)+isnull(trtime_hr,0)*60)%60)),STTIME_HR+':'+STTIME_MIN from webx_ruttran with(NOLOCK) where RUTCD=@RUTCD order by rutno    
OPEN my_cursor_TR    
FETCH NEXT FROM my_cursor_TR    
INTO    
@TR_RUTNO,@BR,@DS,@TM,@DTM    
BEGIN    
--    
WHILE @@FETCH_STATUS = 0    
BEGIN    
    
select @SQL_CL =''    
    
select @SQL_CL='update #RUTMAS set Branch_'+@TR_RUTNO+'='+char(39)+@BR+char(39)+',Dist_'+@TR_RUTNO+'='+char(39)+@DS+char(39)+',Time_'+@TR_RUTNO+'='+char(39)+@TM+char(39)+',DeptTime_'+@TR_RUTNO+'='+char(39)+@DTM+char(39)+' where RUTCD='+char(39)+@RUTCD+char(39)+''    
--select @RUTCD,@SQL_CL    
exec(@SQL_CL)    
    
    
FETCH NEXT FROM my_cursor_TR    
INTO    
@TR_RUTNO,@BR,@DS,@TM,@DTM    
END    
END    
CLOSE my_cursor_TR    
DEALLOCATE my_cursor_TR    
    
FETCH NEXT FROM my_cursor_1    
INTO    
@RUTCD,@ControlLoc,@RUTSTBR,@RUTENDBR,@RUTNM,@Dist,@Time,@STD_CONTAMT    
END    
END    
CLOSE my_cursor_1    
DEALLOCATE my_cursor_1    
    
    
select * from #RUTMAS with(NOLOCK)    
    
    
    
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id = object_id(N'[tempdb]..[#RUTMAS]'))    
Drop table #RUTMAS    
    
