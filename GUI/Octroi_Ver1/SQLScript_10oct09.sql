CREATE Proc [dbo].[usp_Prepare_OctroiBill_Generate]                  
@Bill_Location Varchar(10),                
@Xml_BillMst Text,                  
@Xml_BillDet Text ,                  
@FinYear Varchar(10),                
@Businesstype Varchar(50)                
                 
As                  
Set NoCount On                  
-----------------------                  
DECLARE @ret int                  
Declare @Fianancial_Year varchar(4)                  
DECLARE @Bill_Error int                  
select @Fianancial_Year='20'+@FinYear                
BEGIN                    
 select @ret=1                
                  
 If @ret=1                  
 BEGIN                  
 select @ret=1                
   ---Step 1                              
  ------------------------------------------------                              
  --Get Next Billno Code/No for the said branch                              
  ------------------------------------------------                              
  DECLARE @Billno varchar(25),@BillGen_Loc_basedOn varchar(20),@BIll_Business_Type_Wise_YN varchar(10)                              
                              
  --select @BillGen_Loc_basedOn=BillGen_Loc_basedOn,@BIll_Business_Type_Wise_YN=BIll_Business_Type_Wise_YN from webx_setup_process                      
  select @BIll_Business_Type_Wise_YN=RULE_Y_N  from Webx_Modules_Rules WITH(NOLOCK) where RUleID='RULE01'              
    --select @Billno,@Fianancial_Year,@Bill_Location                    
    EXEC WebX_SP_GetNextDocumentCode_Bill_MR @Bill_Location,@Fianancial_Year,'OCT','N',@Billno output                 
                       
   -- select @Billno                
   --Set @Billno = (Select NextDocumentCode FROM #Temp_Bill)                            
                              
   --DROP TABLE #Temp_Bill                             
  ------------------------------------------------                              
  --End of Get Next Billno Code/No for the said branch                              
  ------------------------------------------------                              
                   
  --Step 2                  
  -------------------------------------------------------------------------------------------------------------                  
  --Populate WebX_Billmst,WebX_Billdet,WebX_Trans_Docket_Status Using XMLs passed as arguments                  
  -------------------------------------------------------------------------------------------------------------                  
                   
   --Start Transaction------                      
                        
     BEGIN TRANSACTION                
   DECLARE @ReturnCode INT                
   SELECT @ReturnCode = 0                
                
                  
   Exec @ReturnCode=usp_XML_Prepare_OctroiBill_Generate @Xml_BillMst,@Xml_Billdet,@Billno                  
   IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback                
   Set @Bill_Error = @@ERROR                  
    --select @Bill_Error as ER1                
                
   declare @FinYear_ACC varchar(4);                  
                    
   select @FinYear_ACC=right(@FinYear,2)                  
 -- Exec @ReturnCode=usp_Bill_Transaction 1,@Billno,@Fianancial_Year,'02','E'                
  -- IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback                
                    
                   
  ------------------------------------------------------------------------------                
  -- BILLNO GENERATION QUERY UPDATED                
  ------------------------------------------------------------------------------                
  Exec @ReturnCode=usp_Update_Billno 'OCT',@Fianancial_Year,@Bill_Location,@BIll_Business_Type_Wise_YN,@Businesstype,'2'                
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback                
 ------------------------------------------------------------------------------                
 -- Commit or ROLLBACK TRAN                
 ------------------------------------------------------------------------------                
  SELECT @Billno as  Billno,'Done' as TranXaction                
  COMMIT TRANSACTION                
  GOTO EndSave                
  QuitWithRollback:                
  IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION                
  SELECT @Billno as  Billno,'Not Done' as TranXaction,@ReturnCode                
  EndSave:                
 END                  
END                 
        

Go





********************************************************************************************************************



CREATE PROC [dbo].[usp_XML_Prepare_OctroiBill_Generate]                
@Xml_BillMst Text,                
@Xml_BillDet Text,                
@Billno varchar(50)               
AS                
BEGIN                     
            
 DECLARE @hDoc1 int                
 DECLARE @hDoc2 int           
 DECLARE @Bill_Error int                
  
 --Prepare XML document in memory and reference is given to @hDoc variable                
 EXEC sp_xml_preparedocument @hDoc1 OUTPUT, @Xml_BillMst                
 EXEC sp_xml_preparedocument @hDoc2 OUTPUT, @Xml_BillDet   
        
 -- Insert Record in Webx_BillMst Table            
            
 INSERT INTO WebX_Billmst               
 (  
 BILLNO,BGNDT,BDUEDT,BBRCD,BBRNM,PAYBAS,PTMSCD,PTMSNM,REMARK,BILLAMT,PENDAMT,BILLSTATUS,  
 closebill,BGENEMPCD,BILL_CANCEL,BILLSUBBRCD,BILLCOLBRCD,SVRCAMT,CESSAMT,manualbillno,entrydt              
 )                 
 SELECT                 
 BILLNO=@Billno,BGNDT,BDUEDT,BBRCD,BBRNM,PAYBAS,PTMSCD,PTMSNM,REMARK,BILLAMT,PENDAMT,BILLSTATUS,  
 closebill,BGENEMPCD,BILL_CANCEL,BILLSUBBRCD,BILLCOLBRCD,SVRCAMT,CESSAMT,manualbillno,entrydt=getdate()  
 FROM OPENXML(@hDoc1,'root/BillMst',2)                 
 WITH                 
   (       
 BGNDT smalldatetime 'BGNDT',                
 BDUEDT smalldatetime 'BDUEDT',                 
 BBRCD varchar(10) 'BBRCD',                
 BBRNM Varchar(100) 'BBRNM',  
 PAYBAS varchar(1) 'PAYBAS',           
 PTMSCD varchar(10) 'PTMSCD',               
 PTMSNM varchar(100) 'PTMSNM',              
 REMARK varchar(250) 'REMARK',             
 BILLAMT Float 'BILLAMT',               
 PENDAMT Float 'PENDAMT',  
 BILLSTATUS varchar(50) 'BILLSTATUS',  
 closebill varchar(1) 'closebill',     
 BGENEMPCD varchar(50) 'BGENEMPCD',    
 BILL_CANCEL varchar(1) 'BILL_CANCEL',  
 BILLSUBBRCD varchar(8) 'BILLSUBBRCD',           
 BILLCOLBRCD varchar(8) 'BILLCOLBRCD',  
 SVRCAMT Float 'SVRCAMT',             
 CESSAMT Float 'CESSAMT',          
 manualbillno varchar(25) 'manualbillno'                  
   )  
   Set @Bill_Error = @@ERROR     
  
 -- Insert Record in Webx_BillDet Table     
  
 INSERT INTO WebX_BillDet               
 (  
 BILLNO,DOCKNO,DOCKSF,SVRCAMT,DKTTOT,OCT_RECEIPTNO,OCT_AMT,CESSAMT,totamt,declval,OTCHG,process_chrg,  
 oct_percentage,clearance_chrg,processing_per,recptdt,Hedu_Cess              
 )                 
 SELECT                 
 BILLNO=@Billno,DOCKNO,DOCKSF,SVRCAMT,DKTTOT,OCT_RECEIPTNO,OCT_AMT,CESSAMT,totamt,declval,OTCHG,process_chrg,  
 oct_percentage,clearance_chrg,processing_per,recptdt,Hedu_Cess  
 FROM OPENXML(@hDoc2,'root/BillDet',2)                 
 WITH   
 (  
 DOCKNO varchar(50) 'DOCKNO',                
 DOCKSF Varchar(1) 'DOCKSF',  
 SVRCAMT Float 'SVRCAMT',           
 DKTTOT Float 'DKTTOT',               
 OCT_RECEIPTNO varchar(15) 'OCT_RECEIPTNO',              
 OCT_AMT Float 'OCT_AMT',             
 CESSAMT Numeric(12,2) 'CESSAMT',              
 totamt Float 'totamt',  
 declval Float 'declval',  
 OTCHG Float 'OTCHG',     
 process_chrg real 'process_chrg',    
 oct_percentage real 'oct_percentage',  
 clearance_chrg real 'clearance_chrg',  
 processing_per real 'processing_per',  
 recptdt datetime 'recptdt',     
 Hedu_Cess Numeric(12,2) 'Hedu_Cess'  
 )   
  
 Set @Bill_Error = @@ERROR   
  
-- Insert Record in Webx_Oct_Det Table     
  
 INSERT INTO Webx_Oct_Det               
 (  
 DOCKNO,DOCKSF,DECLVAL,OCTAMT,RECPTNO,RECPTDT,octroipaid_by,oct_Custcd,oct_Custnm,billno,process_chrg,  
 oct_percentage,clearance_chrg,OTCHG,processing_per,bill_mr_dt,customer_paidby,customer_paidat,customer_paiddt             
 )                 
 SELECT                 
 DOCKNO,DOCKSF,declval,OCT_AMT,OCT_RECEIPTNO,recptdt,octroipaid_by,oct_Custcd,oct_Custnm,billno=@Billno,process_chrg,  
 oct_percentage,clearance_chrg,OTCHG,processing_per,bill_mr_dt,customer_paidby,customer_paidat,customer_paiddt=getdate()  
 FROM OPENXML(@hDoc2,'root/BillDet',2)                 
 WITH   
 (  
 DOCKNO varchar(50) 'DOCKNO',                
 DOCKSF Varchar(1) 'DOCKSF',  
 declval Numeric(12,2) 'declval',  
 OCT_AMT Numeric(12,2) 'OCT_AMT',  
 OCT_RECEIPTNO varchar(15) 'OCT_RECEIPTNO',  
 recptdt datetime 'recptdt',   
 octroipaid_by varchar(50) 'octroipaid_by',  
 oct_Custcd varchar(50) 'oct_Custcd',  
 oct_Custnm varchar(50) 'oct_Custnm',   
 process_chrg real 'process_chrg',   
 oct_percentage real 'oct_percentage',   
 clearance_chrg real 'clearance_chrg',  
 OTCHG real 'OTCHG',   
 processing_per real 'processing_per',  
 bill_mr_dt datetime 'bill_mr_dt',  
 customer_paidby varchar(50) 'customer_paidby',  
 customer_paidat varchar(50) 'customer_paidat'  
 )   
  
 Set @Bill_Error = @@ERROR   
 END


Go


**************************************************************************************************************

CREATE Proc usp_get_octroi_Vendor  
as  
select Vendorcode as code,Vendorname as name from webx_vendor_hdr hdr   
inner join   
 webx_master_general g   
on hdr.Vendor_type=g.Codeid   
and codetype='VENDTY'   
and codeDesc='Octroi Agent'   


Go


**************************************************************************************************************


CREATE Proc [dbo].[usp_Prepare_Agent_Bill_Entry]                    
@Bill_Location Varchar(10),                  
@Xml_BillMst Text,                    
@Xml_BillDet Text ,                    
@FinYear Varchar(10),                  
@Businesstype Varchar(50)                  
                   
As                    
Set NoCount On                    
-----------------------                    
DECLARE @ret int                    
Declare @Fianancial_Year varchar(4)                    
DECLARE @Bill_Error int                    
select @Fianancial_Year='20'+@FinYear                  
BEGIN                      
 select @ret=1                  
                    
 If @ret=1                    
 BEGIN                    
 select @ret=1                  
   ---Step 1                                
  ------------------------------------------------                                
  --Get Next Billno Code/No for the said branch                                
  ------------------------------------------------                                
  DECLARE @Billno varchar(25),@BillGen_Loc_basedOn varchar(20),@BIll_Business_Type_Wise_YN varchar(10)                                
                                
  --select @BillGen_Loc_basedOn=BillGen_Loc_basedOn,@BIll_Business_Type_Wise_YN=BIll_Business_Type_Wise_YN from webx_setup_process                        
  select @BIll_Business_Type_Wise_YN=RULE_Y_N  from Webx_Modules_Rules WITH(NOLOCK) where RUleID='RULE01'                
    --select @Billno,@Fianancial_Year,@Bill_Location                      
    EXEC WebX_SP_GetNextDocumentCode_Bill_MR @Bill_Location,@Fianancial_Year,'BE','N',@Billno output                   
                         
   -- select @Billno                  
   --Set @Billno = (Select NextDocumentCode FROM #Temp_Bill)                              
                                
   --DROP TABLE #Temp_Bill                               
  ------------------------------------------------                                
  --End of Get Next Billno Code/No for the said branch                                
  ------------------------------------------------                                
                     
  --Step 2                    
  -------------------------------------------------------------------------------------------------------------                    
  --Populate WebX_Billmst,WebX_Billdet,WebX_Trans_Docket_Status Using XMLs passed as arguments                    
  -------------------------------------------------------------------------------------------------------------                    
                     
   --Start Transaction------                        
                          
     BEGIN TRANSACTION                  
   DECLARE @ReturnCode INT                  
   SELECT @ReturnCode = 0                  
                  
                    
   Exec @ReturnCode=usp_XML_Prepare_Agent_Bill_Entry @Xml_BillMst,@Xml_Billdet,@Billno                    
   IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback                  
   Set @Bill_Error = @@ERROR                    
    --select @Bill_Error as ER1                  
                  
   declare @FinYear_ACC varchar(4);                    
                      
   select @FinYear_ACC=right(@FinYear,2)                    
 -- Exec @ReturnCode=usp_Bill_Transaction 1,@Billno,@Fianancial_Year,'02','E'                  
  -- IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback                  
                      
                     
  ------------------------------------------------------------------------------                  
  -- BILLNO GENERATION QUERY UPDATED                  
  ------------------------------------------------------------------------------                  
  Exec @ReturnCode=usp_Update_Billno 'BE',@Fianancial_Year,@Bill_Location,@BIll_Business_Type_Wise_YN,@Businesstype,'2'                  
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback                  
 ------------------------------------------------------------------------------                  
 -- Commit or ROLLBACK TRAN                  
 ------------------------------------------------------------------------------                  
  SELECT @Billno as  Billno,'Done' as TranXaction                  
  COMMIT TRANSACTION                  
  GOTO EndSave                  
  QuitWithRollback:                  
  IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION                  
  SELECT @Billno as  Billno,'Not Done' as TranXaction,@ReturnCode                  
  EndSave:                  
 END                    
END                   



Go



*******************************************************************************************************************




CREATE PROC [dbo].[usp_XML_Prepare_Agent_Bill_Entry]                  
@Xml_BillMst Text,                  
@Xml_BillDet Text,                  
@Billno varchar(50)                 
AS                  
BEGIN                       
              
 DECLARE @hDoc1 int                  
 DECLARE @hDoc2 int             
 DECLARE @Bill_Error int                  
    
 --Prepare XML document in memory and reference is given to @hDoc variable                  
 EXEC sp_xml_preparedocument @hDoc1 OUTPUT, @Xml_BillMst                  
 EXEC sp_xml_preparedocument @hDoc2 OUTPUT, @Xml_BillDet   
  
  
 -- Insert Record in Webx_Oct_Hdr Table   
  
INSERT INTO Webx_Oct_Hdr                 
 (    
 OCBILLNO,OCBILLSF,OCBRCD,OCBILLDT,OCAGCD,OCAGNM,OCAGBILLDT,OCAGBILLNO,OCAGOCTAMT,OCAGOTHCHRG,OCAGSERCHRG,NetAmt,PendAmt,  
 OCDUEDT,ENTRYBY,ENTRYDT,REMARK,ACTSERCHRG,servchargeper,sundrychrg,formchrg,clearchrg,CANCEL_YN              
 )                   
 SELECT                   
 OCBILLNO=@Billno,OCBILLSF,OCBRCD,OCBILLDT=getdate(),OCAGCD,OCAGNM,OCAGBILLDT,OCAGBILLNO,OCAGOCTAMT,OCAGOTHCHRG,OCAGSERCHRG,NetAmt,PendAmt,  
 OCDUEDT,ENTRYBY,ENTRYDT=getdate(),REMARK,ACTSERCHRG,servchargeper,sundrychrg,formchrg,clearchrg,CANCEL_YN  
 FROM OPENXML(@hDoc1,'root/BillOctHdr',2)                   
 WITH     
 (    
 OCBILLSF varchar(1) 'OCBILLSF',                  
 OCBRCD Varchar(50) 'OCBRCD',    
 OCAGCD Varchar(100) 'OCAGCD',    
 OCAGNM Varchar(500) 'OCAGNM',    
 OCAGBILLDT Datetime 'OCAGBILLDT',    
 OCAGBILLNO varchar(500) 'OCAGBILLNO',     
 OCAGOCTAMT numeric(12,2) 'OCAGOCTAMT',    
 OCAGOTHCHRG numeric(12,2) 'OCAGOTHCHRG',    
 OCAGSERCHRG numeric(12,2) 'OCAGSERCHRG',     
 NetAmt Float 'NetAmt',     
 PendAmt Float 'PendAmt',     
 OCDUEDT dateTime 'OCDUEDT',    
 ENTRYBY varchar(50) 'ENTRYBY',     
 REMARK varchar(1000) 'REMARK',    
 ACTSERCHRG numeric(12,2) 'ACTSERCHRG',    
 servchargeper numeric(12,2) 'servchargeper',    
 sundrychrg numeric(12,2) 'sundrychrg',  
 formchrg numeric(12,2) 'formchrg',    
 clearchrg numeric(12,2) 'clearchrg',    
 CANCEL_YN varchar(1) 'CANCEL_YN'    
 )     
    
 Set @Bill_Error = @@ERROR     
          
 -- Insert Record in Webx_Oct_Det Table              
              
 INSERT INTO Webx_Oct_Det                 
 (    
 OCBILLNO,OCBILLSF,DOCKNO,OCTAMT,RECPTNO,RECPTDT,vendor_paidby,vendor_paidat,vendor_paiddt                
 )                   
 SELECT                   
 OCBILLNO=@Billno,OCBILLSF,DOCKNO,OCTAMT,RECPTNO,RECPTDT,vendor_paidby,vendor_paidat,vendor_paiddt=getdate()    
 FROM OPENXML(@hDoc2,'root/BillOctDet',2)                   
 WITH                   
   (         
  OCBILLSF varchar(1) 'OCBILLSF',                  
  DOCKNO varchar(20) 'DOCKNO',     
  OCTAMT numeric(12,2) 'OCTAMT',                  
  RECPTNO varchar(150) 'RECPTNO',  
  RECPTDT datetime 'RECPTDT',                  
  vendor_paidby varchar(50) 'vendor_paidby',  
  vendor_paidat varchar(50) 'vendor_paidat'  
   )    
  
   Set @Bill_Error = @@ERROR       
   
 END


Go


*****************************************************************************************************************


alter table webx_oct_hdr
add NetAmt Float

Go

alter table webx_oct_hdr
add PendAmt Float


Go


****************************************************************************************************************

