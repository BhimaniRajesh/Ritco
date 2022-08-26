select Total_DKTS=count(*),
TOT_DKT_WO_LS=sum(case when isnull(delivered,'N')='N' and   orgncd<>reassign_destcd  and thc is null and MF is null and LS is null then 1 else 0 end)  ,
TOT_DKT_With_LS_MF=sum(case when isnull(delivered,'N')='N' and  orgncd<>reassign_destcd  and thc is null and MF is not null and LS is not null then 1 else 0 end)  ,
TOT_DKT_WO_LS_MF=sum(case when isnull(delivered,'N')='N' and  orgncd<>reassign_destcd  and thc is null and MF is not null and LS is  null then 1 else 0 end),  
TOT_DKT_Loaded_THC=sum(case when isnull(delivered,'N')='N' and  orgncd<>reassign_destcd  and thc is not null  then 1 else 0 end),
TOT_DKT_SAME_DLYLOC=sum(case when isnull(delivered,'N')='N' and  orgncd=reassign_destcd  then 1 else 0 end),
TOT_DKT_DLY=sum(case when isnull(delivered,'N')='Y'  then 1 else 0 end)
from webx_master_docket d  with(NOLOCK)
inner join webx_trans_docket_status s on d.dockno=s.dockno and s.docksf='.' and isnull(cancelled,'N')='N'



select * from webx_acctinfo where acccode='BA508'



