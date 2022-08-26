if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VW_M_1Q_BA_Employee]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VW_M_1Q_BA_Employee]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VW_M_2Q_BA_Employee]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VW_M_2Q_BA_Employee]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VW_M_3Q_BA_Employee]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VW_M_3Q_BA_Employee]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VW_M_4Q_BA_Employee]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VW_M_4Q_BA_Employee]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VW_M_CM_BA_Employee]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VW_M_CM_BA_Employee]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VW_M_Date_BA_Employee]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VW_M_Date_BA_Employee]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VW_M_PM_BA_Employee]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VW_M_PM_BA_Employee]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VW_M_Y_BA_Employee]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VW_M_Y_BA_Employee]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VW_M_Y_FIN_BA_Employee]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VW_M_Y_FIN_BA_Employee]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VW_M_1Q]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VW_M_1Q]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VW_M_2Q]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VW_M_2Q]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VW_M_3Q]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VW_M_3Q]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VW_M_4Q]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VW_M_4Q]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VW_M_CM]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VW_M_CM]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VW_M_Date]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VW_M_Date]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VW_M_PM]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VW_M_PM]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VW_M_Y]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VW_M_Y]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VW_M_Y_FIN]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VW_M_Y_FIN]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VW_Monthly_sales_BA_Employee]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VW_Monthly_sales_BA_Employee]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VW_Monthly_sales]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VW_Monthly_sales]
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE view VW_Monthly_sales        
 as        
 select    month(dockdt) as dkt_month,dockdt,businesstype,csgnnm,year(dockdt) as dkt_Year,    
trn_mod=(case when cancelled='Y' then 'CAN' else trn_mod end),    
 paybas=(case when cancelled='Y' then 'CAN' when paybas='p08' then 'p02' when paybas='p09' then 'p02' else paybas end),     
 ST=((isnull(dkttot,0))-(isnull(svctax,0)+isnull(cess,0)+isnull(hedu_cess,0))),  dkttot= (isnull(dkttot,0)),
 svctax=isnull(svctax,0),cess=isnull(cess,0),hedu_cess=isnull(hedu_cess,0),ENtryby,        
 chrgwt=isnull(chrgwt,0), destcd as  orgncd,f.report_loc as f_report_loc,f.locname as f_locname,--reassign_destcd, t.report_loc as t_report_loc,t.locname as t_locname,  destcd,      
 (select case when d.paybas='P09' then party_code When d.paybas='P08' then party_code   When d.paybas='P02' then party_code  When d.paybas='P01 ' then csgncd When d.paybas='P03 ' then csgecd  else csgncd  end) as Party             
 from webx_master_docket d With(NOLOCK)        
 inner join webx_master_docket_charges c With(NOLOCK) on d.dockno=c.dockno        
 inner join webx_trans_docket_status s With(NOLOCK) on d.dockno=s.dockno  and s.docksf='.'  -- AND isnull(cancelled,'N')='N' 
 inner join webx_location f With(NOLOCK) on d.reassign_destcd=f.loccode 
   
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE view VW_M_1Q        
as        
select dkt_month as m,trn_mod,csgnnm,paybas as pb,dkt_Year as Y,businesstype,orgncd as lcd,f_report_loc as ro,f_locname as lnm,ENtryby,Party,count(*) as tdk,sum(chrgwt) as cWt,sum(dkttot) as dt,        
--sum((isnull(dkttot,0))-(isnull(svctax,0)+isnull(cess,0)+isnull(hedu_cess,0))) as st       
sum(ST) as st      
from VW_Monthly_sales with(NOLOCK)        
where dkt_month between month('01 jan 07') and month('31 March 07')        
group by trn_mod,paybas,csgnnm,dkt_Year,businesstype,orgncd,f_report_loc,f_locname,ENtryby,Party,dkt_month        
  


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE view VW_M_2Q        
as        
select dkt_month as m,trn_mod,csgnnm,businesstype,paybas as pb,dkt_Year as Y,orgncd lcd,f_report_loc as ro,f_locname as lnm,ENtryby,Party,count(*) as tdk,sum(chrgwt) as cWt,sum(dkttot) as dt,        
--sum((isnull(dkttot,0))-(isnull(svctax,0)+isnull(cess,0)+isnull(hedu_cess,0))) as st       
sum(ST) as st      
from VW_Monthly_sales with(NOLOCK)        
where dkt_month between month('01 Apr 07') and month('30 June 07')        
group by trn_mod,businesstype,paybas,csgnnm,dkt_Year,orgncd,f_report_loc,f_locname,ENtryby,Party,dkt_month        
  
  


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE view VW_M_3Q        
as        
select dkt_month as m,trn_mod,csgnnm,businesstype,paybas as pb,dkt_Year as Y,orgncd lcd,f_report_loc as ro,f_locname as lnm,ENtryby,Party,count(*) as tdk,sum(chrgwt) as cWt,sum(dkttot) as dt,        
--sum((isnull(dkttot,0))-(isnull(svctax,0)+isnull(cess,0)+isnull(hedu_cess,0))) as st       
sum(ST) as st       
from VW_Monthly_sales with(NOLOCK)        
where dkt_month between month('01 July 07') and month('30 Sep 07')        
group by trn_mod,businesstype,paybas,csgnnm,dkt_Year,orgncd,f_report_loc,f_locname,ENtryby,Party,dkt_month        
  
 


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE view VW_M_4Q      
as      
select dkt_month as m,trn_mod,businesstype,csgnnm,paybas as pb,dkt_Year as Y,orgncd lcd,f_report_loc as ro,f_locname as lnm,ENtryby,Party,count(*) as tdk,sum(chrgwt) as cWt,sum(dkttot) as dt,      
--sum((isnull(dkttot,0))-(isnull(svctax,0)+isnull(cess,0)+isnull(hedu_cess,0))) as st       
sum(ST) as st    
from VW_Monthly_sales with(NOLOCK)      
where dkt_month between month('01 Oct 07') and month('30 Dec 07')      
group by trn_mod,paybas,businesstype,csgnnm,dkt_Year,orgncd,f_report_loc,f_locname,ENtryby,Party,dkt_month      
  



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE view VW_M_CM        
as        
select trn_mod,paybas as pb,dkt_Year,businesstype,csgnnm,orgncd lcd,f_report_loc as ro,f_locname as lnm,ENtryby,Party,count(*) as tdk,sum(chrgwt) as cWt,sum(dkttot) as dt,        
--sum((isnull(dkttot,0))-(isnull(svctax,0)+isnull(cess,0)+isnull(hedu_cess,0))) as st       
sum(ST) as st     
from VW_Monthly_sales with(NOLOCK)        
where dkt_month=month(getdate())        
group by trn_mod,paybas,dkt_Year,businesstype,csgnnm,orgncd,f_report_loc,f_locname,ENtryby,Party        
 



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE view VW_M_Date  
as      
select dkt_month as m,dockdt,trn_mod,businesstype,csgnnm,paybas as pb,dkt_Year as Y,orgncd lcd,f_report_loc as ro,f_locname as lnm,ENtryby,Party,count(*) as tdk,sum(chrgwt) as cWt,sum(dkttot) as dt,      
--sum((isnull(dkttot,0))-(isnull(svctax,0)+isnull(cess,0)+isnull(hedu_cess,0))) as st       
sum(ST) as st    
from VW_Monthly_sales with(NOLOCK)      
--where dkt_month between month('01 Oct 07') and month('30 Dec 07')      
group by trn_mod,paybas,businesstype,csgnnm,dockdt,dkt_Year,orgncd,f_report_loc,f_locname,ENtryby,Party,dkt_month  




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE view VW_M_PM        
as        
select trn_mod,paybas as pb,dkt_Year,businesstype,csgnnm,orgncd lcd,f_report_loc as ro,f_locname as lnm,ENtryby,Party,count(*) as tdk,sum(chrgwt) as cWt,sum(dkttot) as dt,        
--sum((isnull(dkttot,0))-(isnull(svctax,0)+isnull(cess,0)+isnull(hedu_cess,0))) as st       
sum(ST) as st      
from VW_Monthly_sales with(NOLOCK)        
where dkt_month=(month(getdate())-1)    and   dkt_year=(year(getdate()-30))        
group by trn_mod,paybas,dkt_Year,businesstype,csgnnm,orgncd,f_report_loc,f_locname,ENtryby,Party        
 



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE view VW_M_Y        
as        
select dkt_month as m,trn_mod,businesstype,csgnnm,paybas as pb,dkt_Year as Y,orgncd lcd,f_report_loc as ro,f_locname as lnm,ENtryby,Party,count(*) as tdk,sum(chrgwt) as cWt,sum(dkttot) as dt,        
--sum((isnull(dkttot,0))-(isnull(svctax,0)+isnull(cess,0)+isnull(hedu_cess,0))) as st       
sum(ST) as st  
from VW_Monthly_sales with(NOLOCK)        
where dkt_month between month('01 Jan 07') and month('30 Dec 07')        
group by trn_mod,paybas,dkt_Year,businesstype,csgnnm,orgncd,f_report_loc,f_locname,ENtryby,Party,dkt_month      
  



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE view VW_M_Y_FIN          
 as         
 select dkt_month as m,trn_mod,csgnnm,paybas as pb,dkt_Year as Y,orgncd lcd,f_report_loc as ro,f_locname as lnm,ENtryby,Party,count(*) as tdk,sum(chrgwt) as cWt,sum(dkttot) as dt,          
 sum(ST) as st,businesstype    
 from VW_Monthly_sales with(NOLOCK)          
 where dkt_month between '4' and '12'   and dkt_year='20'+left('08-09',2)        
 group by trn_mod,paybas,dkt_Year,csgnnm,orgncd,f_report_loc,f_locname,ENtryby,Party,dkt_month,businesstype    
 union     
 select dkt_month as m,trn_mod,csgnnm,paybas as pb,dkt_Year as Y,orgncd lcd,f_report_loc as ro,f_locname as lnm,ENtryby,Party,count(*) as tdk,sum(chrgwt) as cWt,sum(dkttot) as dt,          
 sum(ST) as st,businesstype    
 from VW_Monthly_sales with(NOLOCK)          
 where dkt_month between '1' and '3'   and dkt_year='20'+right('08-09',2)        
 group by trn_mod,paybas,dkt_Year,csgnnm,orgncd,f_report_loc,f_locname,ENtryby,Party,dkt_month  ,businesstype 




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE view VW_Monthly_sales_BA_Employee      
 as      
 select BA_Employee_name,Alloted_By,BA_Employee,businesstype,csgnnm,dockdt,month(dockdt) as dkt_month,year(dockdt) as dkt_Year,    
trn_mod=(case when cancelled='Y' then 'CAN' else trn_mod end),    
paybas=(case when cancelled='Y' then 'CAN' when paybas='p08' then 'p02' when paybas='p09' then 'p02' else paybas end),     
 ST=((isnull(dkttot,0))-(isnull(svctax,0)+isnull(cess,0)+isnull(hedu_cess,0))), dkttot= (isnull(dkttot,0)),     
 svctax=isnull(svctax,0),cess=isnull(cess,0),hedu_cess=isnull(hedu_cess,0),ENtryby,      
 chrgwt=isnull(chrgwt,0),destcd as orgncd,f.report_loc as f_report_loc,f.locname as f_locname,--reassign_destcd,t.report_loc as t_report_loc,t.locname as t_locname,      
 (select case when d.paybas='P09' then party_code When d.paybas='P08' then party_code   When d.paybas='P02' then party_code  When d.paybas='P01 ' then csgncd When d.paybas='P03 ' then csgecd  else csgncd  end) as Party             
 from webx_master_docket d With(NOLOCK)      
 inner join webx_master_docket_charges c With(NOLOCK) on d.dockno=c.dockno     
 inner join VW_docket_BA_Employee V  With(NOLOCK) on d.dockno between doc_sr_from and doc_sr_to and Alloted_By  not in (select loccode from webx_location)    
 inner join webx_trans_docket_status s With(NOLOCK) on d.dockno=s.dockno    and s.docksf='.'  -- AND isnull(cancelled,'N')='N' 
 inner join webx_location f With(NOLOCK) on d.reassign_destcd=f.loccode 
   
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE view VW_M_1Q_BA_Employee      
as      
select BA_Employee_name,Alloted_By,businesstype,BA_Employee,dkt_month as m,trn_mod,paybas as pb,dkt_Year as Y,orgncd lcd,f_report_loc as ro,f_locname as lnm,ENtryby,Party,count(*) as tdk,sum(chrgwt) as cWt,sum(dkttot) as dt,      
--sum((isnull(dkttot,0))-(isnull(svctax,0)+isnull(cess,0)+isnull(hedu_cess,0))) as st       
sum(ST) as st    
from VW_Monthly_sales_BA_Employee with(NOLOCK)      
where dkt_month between month('01 jan 07') and month('31 March 07')      
group by BA_Employee_name,Alloted_By,businesstype,BA_Employee,trn_mod,paybas,dkt_Year,orgncd,f_report_loc,f_locname,ENtryby,Party,dkt_month      
 



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE view VW_M_2Q_BA_Employee      
as      
select BA_Employee_name,Alloted_By,businesstype,BA_Employee,dkt_month as m,trn_mod,paybas as pb,dkt_Year as Y,orgncd lcd,f_report_loc as ro,f_locname as lnm,ENtryby,Party,count(*) as tdk,sum(chrgwt) as cWt,sum(dkttot) as dt,      
--sum((isnull(dkttot,0))-(isnull(svctax,0)+isnull(cess,0)+isnull(hedu_cess,0))) as st       
sum(ST) as st   
from VW_Monthly_sales_BA_Employee with(NOLOCK)      
where dkt_month between month('01 Apr 07') and month('30 June 07')      
group by BA_Employee_name,Alloted_By,businesstype,BA_Employee,trn_mod,paybas,dkt_Year,orgncd,f_report_loc,f_locname,ENtryby,Party,dkt_month      




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE view VW_M_3Q_BA_Employee      
as      
select BA_Employee_name,Alloted_By,businesstype,BA_Employee,dkt_month as m,trn_mod,paybas as pb,dkt_Year as Y,orgncd lcd,f_report_loc as ro,f_locname as lnm,ENtryby,Party,count(*) as tdk,sum(chrgwt) as cWt,sum(dkttot) as dt,      
--sum((isnull(dkttot,0))-(isnull(svctax,0)+isnull(cess,0)+isnull(hedu_cess,0))) as st       
sum(ST) as st     
from VW_Monthly_sales_BA_Employee with(NOLOCK)      
where dkt_month between month('01 July 07') and month('30 Sep 07')      
group by BA_Employee_name,Alloted_By,businesstype,BA_Employee,trn_mod,paybas,dkt_Year,orgncd,f_report_loc,f_locname,ENtryby,Party,dkt_month      
  



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE view VW_M_4Q_BA_Employee      
as      
select BA_Employee_name,Alloted_By,businesstype,BA_Employee,dkt_month as m,trn_mod,paybas as pb,dkt_Year as Y,orgncd lcd,f_report_loc as ro,f_locname as lnm,ENtryby,Party,count(*) as tdk,sum(chrgwt) as cWt,sum(dkttot) as dt,      
--sum((isnull(dkttot,0))-(isnull(svctax,0)+isnull(cess,0)+isnull(hedu_cess,0))) as st       
sum(ST) as st      
from VW_Monthly_sales_BA_Employee with(NOLOCK)      
where dkt_month between month('01 Oct 07') and month('30 Dec 07')      
group by BA_Employee_name,Alloted_By,businesstype,BA_Employee,trn_mod,paybas,dkt_Year,orgncd,f_report_loc,f_locname,ENtryby,Party,dkt_month      
  



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE view VW_M_CM_BA_Employee      
as      
select BA_Employee_name,Alloted_By,businesstype,BA_Employee,trn_mod,paybas as pb,dkt_Year,orgncd lcd,f_report_loc as ro,f_locname as lnm,ENtryby,Party,count(*) as tdk,sum(chrgwt) as cWt,sum(dkttot) as dt,      
--sum((isnull(dkttot,0))-(isnull(svctax,0)+isnull(cess,0)+isnull(hedu_cess,0))) as st       
sum(ST) as st    
from VW_Monthly_sales_BA_Employee with(NOLOCK)      
where dkt_month=month(getdate())      
group by BA_Employee_name,Alloted_By,businesstype,BA_Employee,trn_mod,paybas,dkt_Year,orgncd,f_report_loc,f_locname,ENtryby,Party      
 



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE view VW_M_Date_BA_Employee      
as      
select BA_Employee_name,Alloted_By,businesstype,BA_Employee,dockdt,dkt_month as m,trn_mod,paybas as pb,dkt_Year as Y,orgncd lcd,f_report_loc as ro,f_locname as lnm,ENtryby,Party,count(*) as tdk,sum(chrgwt) as cWt,sum(dkttot) as dt,      
--sum((isnull(dkttot,0))-(isnull(svctax,0)+isnull(cess,0)+isnull(hedu_cess,0))) as st       
sum(ST) as st    
from VW_Monthly_sales_BA_Employee with(NOLOCK)      
--where dkt_month between month('01 Jan 07') and month('30 Dec 07')      
group by BA_Employee_name,Alloted_By,businesstype,BA_Employee,dockdt,trn_mod,paybas,dkt_Year,orgncd,f_report_loc,f_locname,ENtryby,Party,dkt_month     
 



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE view VW_M_PM_BA_Employee      
as      
select BA_Employee_name,Alloted_By,businesstype,BA_Employee,trn_mod,paybas as pb,dkt_Year,orgncd lcd,f_report_loc as ro,f_locname as lnm,ENtryby,Party,count(*) as tdk,sum(chrgwt) as cWt,sum(dkttot) as dt,      
--sum((isnull(dkttot,0))-(isnull(svctax,0)+isnull(cess,0)+isnull(hedu_cess,0))) as st       
sum(ST) as st      
from VW_Monthly_sales_BA_Employee with(NOLOCK)      
where dkt_month=(month(getdate())-1)     and   dkt_year=(year(getdate()-30))      
group by BA_Employee_name,Alloted_By,businesstype,BA_Employee,trn_mod,paybas,dkt_Year,orgncd,f_report_loc,f_locname,ENtryby,Party      




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE view VW_M_Y_BA_Employee      
as      
select BA_Employee_name,Alloted_By,businesstype,BA_Employee,dkt_month as m,trn_mod,paybas as pb,dkt_Year as Y,orgncd lcd,f_report_loc as ro,f_locname as lnm,ENtryby,Party,count(*) as tdk,sum(chrgwt) as cWt,sum(dkttot) as dt,      
--sum((isnull(dkttot,0))-(isnull(svctax,0)+isnull(cess,0)+isnull(hedu_cess,0))) as st       
sum(ST) as st   
from VW_Monthly_sales_BA_Employee with(NOLOCK)      
where dkt_month between month('01 Jan 07') and month('30 Dec 07')      
group by BA_Employee_name,Alloted_By,businesstype,BA_Employee,trn_mod,paybas,dkt_Year,orgncd,f_report_loc,f_locname,ENtryby,Party,dkt_month      
  



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE view VW_M_Y_FIN_BA_Employee            
 as        
 select BA_Employee_name,Alloted_By,BA_Employee,businesstype,dkt_month as m,trn_mod,paybas as pb,dkt_Year as Y,orgncd lcd,f_report_loc as ro,f_locname as lnm,ENtryby,Party,count(*) as tdk,sum(chrgwt) as cWt,sum(dkttot) as dt,      
 sum(ST) as st   
 from VW_Monthly_sales_BA_Employee with(NOLOCK)      
 where dkt_month between month('01 Jan ') and month('30 Dec')      
 group by BA_Employee_name,Alloted_By,BA_Employee,businesstype,trn_mod,paybas,dkt_Year,orgncd,f_report_loc,f_locname,ENtryby,Party,dkt_month      
  
  


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

