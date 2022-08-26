alter table webx_trans_docket_status 
alter column SP_Vrno varchar(2000)
alter table Webx_thc_summary 
alter column SP_Vrno varchar(2000)
alter table webx_pdchdr 
alter column SP_Vrno varchar(2000)
alter table WEBX_FLEET_VEHICLE_ISSUE 
alter column SP_Vrno varchar(2000)

alter table webx_acctrans_08_09 
alter column DocNo varchar(2000)
alter table webx_acctrans_09_10 
alter column DocNo varchar(2000)

go

ALTER Proc usp_update_Special_Cost_Voucher      
@DocType varchar(10),  
@DocNo varchar(100),      
@Sp_VrNo varchar(35),      
@Sp_VrAmt numeric(12,2)  
AS                      
set nocount on        
BEGIN       
	if @DocType='DKT'      
	Begin   
		UPDATE webx_trans_docket_status SET
		 SP_Vrno=(case when isnull(SP_Vrno,'')='' then  @Sp_VrNo else isnull(SP_Vrno,'')+','+@Sp_VrNo end) ,SP_VrAmt=isnull(SP_VrAmt,0)+@Sp_VrAmt WHERE DOCKNO=@DocNo   
	End  
	if @DocType='THC'      
	Begin   
		UPDATE webx_THC_SUMMARY SET
       SP_Vrno=(case when isnull(SP_Vrno,'')='' then  @Sp_VrNo else isnull(SP_Vrno,'')+','+@Sp_VrNo end),SP_VrAmt=isnull(SP_VrAmt,0)+@Sp_VrAmt WHERE THCNO=@DocNo   
	End  
	if @DocType='TRP'      
	Begin   
		UPDATE WEBX_FLEET_VEHICLE_ISSUE SET
		 SP_Vrno=(case when isnull(SP_Vrno,'')='' then  @Sp_VrNo else isnull(SP_Vrno,'')+','+@Sp_VrNo end),SP_VrAmt=isnull(SP_VrAmt,0)+@Sp_VrAmt WHERE vslipno=@DocNo   
	End  
	if @DocType='PRS' or @DocType='DRS'      
	Begin   
		UPDATE webx_PDCHDR SET 
		SP_Vrno=(case when isnull(SP_Vrno,'')='' then  @Sp_VrNo else isnull(SP_Vrno,'')+','+@Sp_VrNo end),SP_VrAmt=isnull(SP_VrAmt,0)+@Sp_VrAmt WHERE PDCNO=@DocNo   
	End  
END

go

CREATE Proc usp_update_Special_Cost_Voucher_24apr09      
@DocType varchar(10),  
@DocNo varchar(100),      
@Sp_VrNo varchar(35),      
@Sp_VrAmt numeric(12,2)  
AS                      
set nocount on        
BEGIN       
 if @DocType='DKT'      
 Begin   
  UPDATE webx_trans_docket_status SET SP_Vrno=@Sp_VrNo,SP_VrAmt=@Sp_VrAmt WHERE DOCKNO=@DocNo   
 End  
 if @DocType='THC'      
 Begin   
  UPDATE webx_THC_SUMMARY SET SP_Vrno=@Sp_VrNo,SP_VrAmt=@Sp_VrAmt WHERE THCNO=@DocNo   
 End  
 if @DocType='TRP'      
 Begin   
  UPDATE WEBX_FLEET_VEHICLE_ISSUE SET SP_Vrno=@Sp_VrNo,SP_VrAmt=@Sp_VrAmt WHERE vslipno=@DocNo   
 End  
 if @DocType='PRS' or @DocType='DRS'      
 Begin   
  UPDATE webx_PDCHDR SET SP_Vrno=@Sp_VrNo,SP_VrAmt=@Sp_VrAmt WHERE PDCNO=@DocNo   
 End  
END


select top 10 dockno,sp_vrno from webx_trans_docket_status where sp_vrno is not null

select top 10 dockno,sp_vrno from webx_trans_docket_status where sp_vrno is null


select * from webx_master_users where userid='rajesh'