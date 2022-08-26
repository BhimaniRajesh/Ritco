if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[webx_DKT_OPN_LIFE_CYCLE]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[webx_DKT_OPN_LIFE_CYCLE]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[webx_DKT_OPN_LIFE_CYCLE_Det]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[webx_DKT_OPN_LIFE_CYCLE_Det]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE Procedure webx_DKT_OPN_LIFE_CYCLE        
@Fromdt varchar(100),        
@todt varchar(100),        
@fromRo varchar(100),        
@fromloc varchar(100),        
@docklist varchar(8000)        
as         
declare @sql varchar(8000);        
declare @whereCri varchar(8000);        
        
  if @fromRo='All' and @fromloc='All'         
   select @whereCri  = ''         
      else if @fromRo<>'All' and  @fromloc='All'        
   select @whereCri  = ' and report_loc=' + char(39)  + @fromRo + char(39)         
      else if @fromRo<>'All' and  @fromloc<>'All'        
        select @whereCri  = 'and report_loc=' + char(39)  + @fromRo + char(39) +' and loccode= '+ char(39)  + @fromloc  + char(39)        
      else if @fromRo='All' and  @fromloc<>'All'        
        select @whereCri  = 'and  loccode= '+ char(39)  + @fromloc  + char(39)        
if @docklist=''        
 begin        
 select @sql='select  docket=dockno+docksf,dockno,docksf,dockdt=convert(varchar,dockdt,6),orgncd,destcd,from_loc,to_loc,report_loc,loccode,locname,LS,THC,MF,PDC,DRS, Curr_loc,nextloc,      
Status from VW_DKT_OPN_LIFE_CYCLE with(NOLOCK) where       
Convert(varchar,dockdt,106)  between  Convert(datetime,' + char(39) + @Fromdt + char(39)  + ',106)  and  Convert(datetime,' + char(39) + @todt + char(39)  + ',106)     '+@whereCri+' order by dockno+docksf '        
 end        
else         
 begin        
 select @sql='select  docket=dockno+docksf,dockno,docksf,dockdt=convert(varchar,dockdt,6),orgncd,destcd,from_loc,to_loc,report_loc,loccode,locname,LS,THC,MF,PDC,DRS, Curr_loc,nextloc,Status from 
VW_DKT_OPN_LIFE_CYCLE with(NOLOCK) where  patindex('        
 Select @sql = @sql + '''' + '%' + '''' + '+dockno+' + '''' + '%' + '''' + ','         
 Select @sql = @sql + '''' + @docklist + '''' + ')<>0 order by dockno+docksf  '        
 end        
        
        
exec(@sql)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE Procedure webx_DKT_OPN_LIFE_CYCLE_Det      
@dockno varchar(100),      
@docksf varchar(10),      
@doc_typ varchar(10)      
as      
declare @sql varchar(8000);      
declare @whereCri varchar(8000);      
  
      
  
if @doc_typ='LS'      
 begin      
 select  @sql ='select a.TCNo,manualLSNO,TCDT=convert(varchar,TCDT,6),TCBR,a.tobh_code from webx_TCHdr_tmp a with(NOLOCK)      
 inner join webx_TCTRN_tmp b on a.tcno=b.tcno where dockno='+ char(39)  + @dockno  + char(39) + ' and docksf='+ char(39)  + @docksf  + char(39) + '      
 order by b.tcdt '      
 end      
else if @doc_typ='MF'      
 begin      
 select  @sql ='select a.TCNo,manual_tcno,TCDT=convert(varchar,TCDT,6),TCBR,a.tobh_code,Cancelled=isnull(Cancelled,'+ char(39)  + 'N'  + char(39) + ') from webx_TCHdr a with(NOLOCK)      
 inner join webx_TCTRN b on a.tcno=b.tcno where dockno='+ char(39)  + @dockno  + char(39) + ' and docksf='+ char(39)  + @docksf  + char(39) + '      
 order by b.tcdt '      
 end      
else if @doc_typ='THC'      
 begin      
 select  @sql ='select a.ThCNo,ThCDT=convert(varchar,b.THCdt,6),b.thcbr,tobh_code,routecd,routename,cancelled=isnull(b.cancelled,'+ char(39)  + 'N'  + char(39) + ') from VW_thc_tc_dockets a with(NOLOCK)      
 inner join webx_THC_summary b on a.thcno=b.thcno where dockno='+ char(39)  + @dockno  + char(39) + ' and docksf='+ char(39)  + @docksf  + char(39) + '      
 order by b.thcdt '      
 end      
else if @doc_typ='PRS'      
 begin      
 select  @sql ='select *,PDC_DT=convert(varchar,pdcdt,6) from VW_PDC_HDR_TRN with(NOLOCK) where pdcty='+ char(39)  + 'P'  + char(39) + ' and dockno='+ char(39)  + @dockno  + char(39) + ' and docksf='+ char(39)  + @docksf  + char(39) + '      
 order by pdcdt '      
 end      
else if @doc_typ='DRS'      
 begin      
 select  @sql ='select *,PDC_DT=convert(varchar,pdcdt,6) from VW_PDC_HDR_TRN with(NOLOCK) where pdcty='+ char(39)  + 'D'  + char(39) + ' and dockno='+ char(39)  + @dockno  + char(39) + ' and docksf='+ char(39)  + @docksf  + char(39) + '      
 order by pdcdt '      
 end      
      
exec(@sql)    




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VW_DKT_OPN_LIFE_CYCLE]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VW_DKT_OPN_LIFE_CYCLE]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VW_PDC_HDR_TRN]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VW_PDC_HDR_TRN]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE View VW_PDC_HDR_TRN      
as      
select p.pdcty,p.pdcno,pdcbr,pdcdt,dockno,docksf      
from webx_pdchdr p With(NOLOCK)      
inner join webx_pdctrn PT With(NOLOCK) on p.pdcno=pt.pdcno      
      

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE View VW_DKT_OPN_LIFE_CYCLE          
as           
select  d.dockno,s.docksf,dockdt,orgncd,destcd,from_loc,to_loc,report_loc,loccode,locname,  Curr_loc,nextloc,        
(select count(dockno) from webx_TCTRN_tmp with(NOLOCK) where dockno=d.dockno and docksf=s.docksf) as LS,          
(select count(dockno) from webx_TCTRN with(NOLOCK)  where dockno=d.dockno and docksf=s.docksf ) AS MF,          
(select  count(dockno) from VW_thc_tc_dockets with(NOLOCK)  where thcno is not null and  dockno=d.dockno and docksf=s.docksf ) AS THC ,          
(select  count(dockno) from VW_PDC_HDR_TRN with(NOLOCK)  where PDCTY='P' and  dockno=d.dockno and docksf=s.docksf) AS PDC ,           
(select  count(dockno) from VW_PDC_HDR_TRN with(NOLOCK)  where PDCTY='D' and  dockno=d.dockno and docksf=s.docksf) AS DRS  
 , Status=(select top 1 docket_status from Vw_Docket_TRack_status_ver1 with(NOLOCK) where docket=d.dockno+s.docksf)      
from webx_master_docket d with(NOLOCK)           
inner join webx_Trans_docket_status S with(NOLOCK) on d.dockno=s.dockno          
inner join webx_location l with(NOLOCK)  on d.orgncd=l.loccode and activeflag='Y'   
--where d.dockno='0085525'       
--where isnull(cancelled,'N')='N'        

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

