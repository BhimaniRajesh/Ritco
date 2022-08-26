if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VW_Location]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VW_Location]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE View VW_Location  as  select distinct loccode,lcd='['+loccode+']',locname,Report_loc=(case when report_level='1' then loccode else Report_loc end),loc_level from webx_location with(NOLOCK) where isnull(activeflag,'N')='Y' and (loccode in ('IDRR','HSP','HQTR','TARF','PNQN','KRLF','BWN','JGA','HGN','TKBF','HYD','CCUN','WGLF','BLRN','GDYF','PMC','ADIF','BLRX','PORF','CDRF','IXU','HGLF','GDN','SKRF','TPR','GOI','RTKF','PTP','VTZ','JLR','MSDF','NJP','IDR','IXM','LUH','MHP','NAGY','HLDF','AGR','BOMR','FBD','TYR','HYDN','BMSF','COK','HSRF','YMNF','LKO','BWDF','KRP','SGI','PURF','RAJ','BKRF','BDI','SGNF','AMDR','SNRF','AKV','DMBF','RDP','SVKF','KTAF','STV','AMDX','AMDC','HISF','RPR','ALG','NAGC','IXW','SPTF','CCUY','PNYF','MBD','MAAX','DDN','MDP','CCUS','MAU','BNWF','MBCF','DELR','KMBF','AKLF','VKR','GNDF','HDW','GWL','KNUR','TNWF','MAAN','UDR','LNRF','IXC','DELY','KNP','CTK','KRRF','IDRN','VPI','AND','IXB','MPLF','BTBF','PNY','VSI','JAIC','AMD','IXR','CCUR','BBI','VNS','BOMX','NDA','CLAF','IXJ','PIRF','TRZF','DELX','BRGN','BHO','PCMC','GZB','PHRF','ISKF','CJBF','CJBN','SOL','NAGN','KNLF','BOMN','NRLF','BDQ','PNN','KPM','ERDF','YLKF','SSE','RWRF','PAT','SAL','MAAY','MVL','GZBN','HYDR','AMDN','DELW','PWN','AMB','ANR','MPIF','PRG','NGP','JSGF','MSD','DHRF','OKL','MYS','IXWY','VGA','AMTF','IXD','SLMN','AMCN','GGN','IXCR','AJMF','RKEF','CKNF','BWIF','BLY','GAU','ATPF','SMB','KNWF','JLD','CJB','DELN','PTU','KLH','RGR','BDO','RJAF','MAAR','KNUN','ATQ','KLMF','HBX','PPTF') or loc_level in ('1','2') )  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VW_P_AND_L_GRP]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VW_P_AND_L_GRP]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VW_P_AND_L_SUBGRP]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VW_P_AND_L_SUBGRP]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VW_P_AND_L]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[VW_P_AND_L]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


create view VW_P_AND_L
as 
select t.debit    ,t.credit,  c.Groupcode  ,a.acccode    ,c.parentcode,t.brcd
 from webx_acctinfo a with(NOLOCK),
 webx_closing_balance_pf t with(NOLOCK) ,
webx_groups c with(NOLOCK) where a.acccode=t.acccode    
 and a.Groupcode=c.Groupcode


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE view VW_P_AND_L_GRP
as
select t.brcd as br,isnull(company_groupcode,a.groupcode) as gcd,groupdesc as gnm,a.groupcode as gcd1,parcd=left(isnull(a.parentcode,a.groupcode),3),
c=sum(isnull(credit,0)),
d=sum(isnull(debit,0)),
l=sum(isnull(credit,0))-sum(isnull(debit,0)),
P=(isnull((case when left(isnull(a.parentcode,a.groupcode),3)='INC' then  sum(isnull(t.credit,0) - isnull(t.debit,0)) 
when left(isnull(a.parentcode,a.groupcode),3)='EXP' then sum(isnull(t.debit,0) - isnull(t.credit,0))    end ),0))
from webx_groups a with(NOLOCK) 
left outer join VW_P_AND_L t with(NOLOCK)  on a.groupcode=t.groupcode 
where left(isnull(a.parentcode,a.groupcode),3)='INC'  or left(isnull(a.parentcode,a.groupcode),3)='EXP' 
group by t.brcd,a.groupcode,a.parentcode,company_groupcode,groupdesc 



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE View VW_P_AND_L_SUBGRP  
as  
select t.brcd as br,a.groupcode,isnull(company_acccode,a.acccode) as acccode1 ,a.accdesc,a.acccode,  
  credit=isnull(credit,0),debit=isnull(debit,0),  
  P=(isnull((case when left(acccategory,3)='INC' then (isnull(t.credit,0) - isnull(t.debit,0))    
  when left(acccategory,3)='EXP' then  (isnull(t.debit,0) - isnull(t.credit,0))  end ),0))  
  from webx_acctinfo a with(NOLOCK)  
  left outer join VW_P_AND_L t with(NOLOCK)  on a.acccode=t.acccode   


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

