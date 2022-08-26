using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using ApplicationManager;
using System.Data.SqlClient;
/// <summary>
/// <summary>
/// Summary description for cls_AvgDieselRage
/// </summary>
public class JobSheet : DataAccessLayer 
{
    #region Private Declaration

    private string _Connection_String, _tasktyp, _LABOUR_HRS, _taskcd,_PartId,_PartCost;
    protected bool _Is_Record_Found;
    private string _AvgDieRate, _Entry_By;

    private string _ID, _Job_ID, _Approved_Id, _Approver_UserId, _CC_UserId, _UserId, _UserID, _EmailId;
    private string _LOC_HRCHY_CODE, _LOC_APPROVE_AMT, _JS_TYPE;

    private string _JobOrderNo, _JobOrderFromDt, _JobOrderToDt, _JobCardType, _JS_BRCD;
    private string _VehNo, _Current_KM_Read, _Vehicle_Status, _Made_by, _Model_No, _Type_Name, _Type_Code;

    private string _JS_Approve, _JS_Reject, _JS_Approve_By, _JS_Reject_By;
    private string _Tmp_Current_KM_Read, _JS_Approval_Remarks, _PartCode, _Selling_Price, _JS_Maintainance_Status;

    private string _SMTP_Server, _From_Address, _From_To, _Update_By;

    private string _Company_Code;

	private string _VehicleNo;

	private string _Vehicle_Attached_TS;
    private string _Vehicle_Attached_JS;
    private string _Labour_Cost_TaskWise;

    
    #endregion

    #region Properties

    public string JS_Maintainance_Status { get { return _JS_Maintainance_Status; } set { _JS_Maintainance_Status = value; } }
    
	public string VehicleNo { get { return _VehicleNo; } set { _VehicleNo = value; } }
    public bool IsRecordFound { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }
    public string Selling_Price { get { return _Selling_Price; } set { _Selling_Price = value; } }
    public string PartCode { get { return _PartCode; } set { _PartCode = value; } }
    public string JS_Approval_Remarks { get { return _JS_Approval_Remarks; } set { _JS_Approval_Remarks = value; } }
    public string Tmp_Current_KM_Read { get { return _Tmp_Current_KM_Read; } set { _Tmp_Current_KM_Read = value; } }
    public string VehNo { get { return _VehNo; } set { _VehNo = value; } }
    public string Current_KM_Read { get { return _Current_KM_Read; } set { _Current_KM_Read = value; } }
    public string Vehicle_Status { get { return _Vehicle_Status; } set { _Vehicle_Status = value; } }
    public string Made_by { get { return _Made_by; } set { _Made_by = value; } }
    public string Model_No { get { return _Model_No; } set { _Model_No = value; } }
    public string Type_Name { get { return _Type_Name; } set { _Type_Name = value; } }
    public string Type_Code { get { return _Type_Code; } set { _Type_Code = value; } }

    public string PartId { get { return _PartId; } set { _PartId = value; } }
    public string PartCost { get { return _PartCost; } set { _PartCost = value; } }
    public string taskcd { get { return _taskcd; } set { _taskcd = value; } }
    public string tasktyp { get { return _tasktyp; } set { _tasktyp = value; } }
    public string LABOUR_HRS { get { return _LABOUR_HRS; } set { _LABOUR_HRS = value; } }

    public string ID { get { return _ID; } set { _ID = value; } }

    public string Job_ID { get { return _Job_ID; } set { _Job_ID = value; } }
    public string Approved_Id { get { return _Approved_Id; } set { _Approved_Id = value; } }
    public string Approver_UserId { get { return _Approver_UserId; } set { _Approver_UserId = value; } }
    public string CC_UserId { get { return _CC_UserId; } set { _CC_UserId = value; } }
    public string UserId { get { return _UserId; } set { _UserId = value; } }
    public string UserID { get { return _UserID; } set { _UserID = value; } }
    public string EmailId { get { return _EmailId; } set { _EmailId = value; } }

    public string LOC_HRCHY_CODE { get { return _LOC_HRCHY_CODE; } set { _LOC_HRCHY_CODE = value; } }
    public string LOC_APPROVE_AMT { get { return _LOC_APPROVE_AMT; } set { _LOC_APPROVE_AMT = value; } }
    public string JS_TYPE { get { return _JS_TYPE; } set { _JS_TYPE = value; } }

    public string Entry_By { get { return _Entry_By; } set { _Entry_By = value; } }

    public string JobOrderNo { get { return _JobOrderNo; } set { _JobOrderNo = value; } }
    public string JobOrderFromDt { get { return _JobOrderFromDt; } set { _JobOrderFromDt = value; } }
    public string JobOrderToDt { get { return _JobOrderToDt; } set { _JobOrderToDt = value; } }
    public string JobCardType { get { return _JobCardType; } set { _JobCardType = value; } }
    public string JS_BRCD { get { return _JS_BRCD; } set { _JS_BRCD = value; } }

    public string JS_Approve { get { return _JS_Approve; } set { _JS_Approve = value; } }
    public string JS_Reject { get { return _JS_Reject; } set { _JS_Reject = value; } }
    public string JS_Approve_By { get { return _JS_Approve_By; } set { _JS_Approve_By = value; } }
    public string JS_Reject_By { get { return _JS_Reject_By; } set { _JS_Reject_By = value; } }
    
    public string SMTP_Server { get { return _SMTP_Server; } set { _SMTP_Server = value; } }
    public string From_Address { get { return _From_Address; } set { _From_Address = value; } }
    public string From_To { get { return _From_To; } set { _From_To = value; } }
    public string Update_By { get { return _Update_By; } set { _Update_By = value; } }

    public string Company_Code { get { return _Company_Code; } set { _Company_Code = value; } }
	
	public string Vehicle_Attached_TS { get { return _Vehicle_Attached_TS; } set { _Vehicle_Attached_TS = value; } }
    public string Vehicle_Attached_JS { get { return _Vehicle_Attached_JS; } set { _Vehicle_Attached_JS = value; } }
    public string Labour_Cost_TaskWise { get { return _Labour_Cost_TaskWise; } set { _Labour_Cost_TaskWise = value; } }

    
    #endregion

    public JobSheet(string ConnectionString)
        : base(ConnectionString)
	{
        _Connection_String = ConnectionString;
	}

    public void UpdateMailData()
    {
        SqlParameter[] prm = new SqlParameter[4];

        prm[0] = new SqlParameter("@SMTP_Server", SMTP_Server);
        prm[1] = new SqlParameter("@From_Address", From_Address);
        prm[2] = new SqlParameter("@From_To", From_To);
        prm[3] = new SqlParameter("@Update_By", Update_By);

        ExecuteNonQuery(CommandType.StoredProcedure, "Usp_Update_Webx_Fleet_JobApprovalMailSettings", prm);
    }
    public DataTable GetMailData()
    {
        DataTable dt = new DataTable();
        DataControlManager dcm = new DataControlManager(_Connection_String);

        dt = ExecuteDataTable(CommandType.Text, "Select EmailId,* From webx_master_users Where userid='" + Entry_By + "'");
        return dt;
    }
    public void OnTaskDescChange()
    {
        DataTable dt = new DataTable();
        dt = ExecuteDataTable(CommandType.Text, "SELECT taskcd,tasktyp,LABOUR_HRS FROM WEBX_FLEET_GENERALTASKMST Where convert(varchar,taskcd)='" + taskcd + "'");
        //(select TaskType from webx_Fleet_TaskTypeMst where TaskTypeId=tasktyp) as 

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            tasktyp = dt.Rows[0]["tasktyp"].ToString();
            LABOUR_HRS = dt.Rows[0]["LABOUR_HRS"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }
    public void OnPartDescChangeClose()
    {
        DataTable dt = new DataTable();
        dt = ExecuteDataTable(CommandType.Text, "select Selling_Price From WEBX_FLEET_SPAREPARTHDR where Part_Id='" + PartCode.Trim() + "'");

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            Selling_Price = dt.Rows[0]["Selling_Price"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }
    
    public void OnTaskDescChangeClose()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[2];

        prm[0] = new SqlParameter("@JOB_ORDER_NO", JobOrderNo);
        prm[1] = new SqlParameter("@Taskcd", taskcd);
        
        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_OnTaskDescChange", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            tasktyp = dt.Rows[0]["tasktyp"].ToString();
            LABOUR_HRS = dt.Rows[0]["LABOUR_HRS"].ToString();
        }
        else
        {
            DataTable dt1 = new DataTable();
            SqlParameter[] prm1 = new SqlParameter[2];

            prm1[0] = new SqlParameter("@JOB_ORDER_NO", JobOrderNo);
            prm1[1] = new SqlParameter("@Taskcd", taskcd);

            dt1 = ExecuteDataTable(CommandType.StoredProcedure, "usp_OnTaskDescChange_Rec", prm1);

            if (dt1.Rows.Count > 0)
            {
                IsRecordFound = true;
                tasktyp = dt1.Rows[0]["tasktyp"].ToString();
                LABOUR_HRS = dt1.Rows[0]["LABOUR_HRS"].ToString();
            }
            else
            {
                IsRecordFound = false;
            }
        }
    }
    public void CheckVehicleNo()
    {
        DataTable dt = new DataTable();
        string SQL = "Select ISNULL(H.Current_KM_Read,0) as Current_KM_Read,Vehicle_Status,Made_by,Model_No,Type_Name,Type_Code,H.Tmp_Current_KM_Read,H.JS_Maintainance_Status,(select Top 1 JOB_ORDER_NO from WEBX_FLEET_PM_JOBORDER_HDR where vehno=H.VehNO and Order_Status = 'Open' Order By EntryDt Desc) AS JOB_ORDER_NO  from WEBX_VEHICLE_TYPE T  Right outer join  WEBX_VEHICLE_HDR H On T.Type_code=H.Vehicle_Type Where H.VehNO='" + VehNo.ToString().Trim() + "'";
        dt = ExecuteDataTable(CommandType.Text, SQL);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            Current_KM_Read = dt.Rows[0]["Current_KM_Read"].ToString();
            Vehicle_Status = dt.Rows[0]["Vehicle_Status"].ToString();
            Made_by = dt.Rows[0]["Made_by"].ToString();
            Model_No = dt.Rows[0]["Model_No"].ToString();
            Type_Name = dt.Rows[0]["Type_Name"].ToString();
            Type_Code = dt.Rows[0]["Type_Code"].ToString();
            Tmp_Current_KM_Read = dt.Rows[0]["Tmp_Current_KM_Read"].ToString();
            JS_Maintainance_Status = dt.Rows[0]["JS_Maintainance_Status"].ToString();
            JobOrderNo = dt.Rows[0]["JOB_ORDER_NO"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }
	public void BindGVPopupVehicle(DataList dl)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[3];

        prm[0] = new SqlParameter("@VehNo", (VehicleNo == null) ? "" : VehicleNo);
        prm[1] = new SqlParameter("@TSJS", (JS_TYPE == null) ? "" : JS_TYPE);
        prm[2] = new SqlParameter("@Vehicle_Status", (Vehicle_Status == null) ? "" : Vehicle_Status);

        dcm.DataBind(dl, CommandType.StoredProcedure, "USP_Joborder_Vehicle_Popup", prm);
    }
    public void OnPartDescChange()
    {
        DataTable dt = new DataTable();
        dt = ExecuteDataTable(CommandType.Text, "select Selling_Price,TaskTypeId  from WEBX_FLEET_SPAREPARTHDR where Part_Id='" + PartId + "'");

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            PartCost = dt.Rows[0]["Selling_Price"].ToString();
            taskcd = dt.Rows[0]["TaskTypeId"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }
    public void CheckValidData(string str_LOC_HRCHY_CODE,string str_JS_TYPE)
    {
        DataTable dt = new DataTable();
        dt = ExecuteDataTable(CommandType.Text, "SELECT * FROM Webx_Fleet_JS_Approval_Hrchy_Amt Where LOC_HRCHY_CODE = '" + str_LOC_HRCHY_CODE + "' And JS_TYPE= '" + str_JS_TYPE + "'");
        if (dt.Rows.Count > 0)
        {
            ID = dt.Rows[0]["Id"].ToString().Trim();
        }
        if (dt.Rows.Count > 0) { IsRecordFound = true; } else { IsRecordFound = false; }
    }
    public void BindDropDown(DropDownList ddl, string strSQL)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        dcm.DataBind(ddl, CommandType.Text, strSQL);
    }
    public void BindLocationHierarchy(DropDownList ddl)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        dcm.DataBind(ddl, CommandType.Text, "SELECT CODEID,CODEDESC FROM WEBX_MASTER_GENERAL WHERE CODETYPE='HRCHY'");
    }
    public void BindTaskList(DropDownList ddl, string W_GRPCD)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[2];

        prm[0] = new SqlParameter("@W_GRPCD", W_GRPCD);
        prm[1] = new SqlParameter("@G_TASKCD", "0");

        dcm.DataBind(ddl, CommandType.StoredProcedure, "usp_Job_TaskList", prm);
    }
    public void BindTaskType(DropDownList ddl)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        dcm.DataBind(ddl, CommandType.Text, "Select TaskTypeID,TaskType From Webx_Fleet_TaskTypeMst Where Activeflag='Y' and TasktypeID <> 1");
    }
    
    public void BindPartList(DropDownList ddl, string W_GRPCD)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        dcm.DataBind(ddl, CommandType.Text, "SELECT PART_ID,DESCRIPTION FROM WEBX_FLEET_SPAREPARTHDR WHERE W_GRPDC = " + Convert.ToInt32(W_GRPCD) + " order by Description ");
    }
    public void BindWorkGroup(DropDownList ddl)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[0];
        dcm.DataBind(ddl, CommandType.StoredProcedure, "usp_Job_AllWorkGroupList", prm);
    }

    public void BindPart(DropDownList ddl)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        dcm.DataBind(ddl, CommandType.Text, "select  distinct Part_Id,Description from Webx_Fleet_spareParthdr where  ACTIVEFLAG='Y' UNION select '','Select' from Webx_Fleet_spareParthdr  Order by Description ");
    }

    public void Insert_JS_Approval_Amt()
    {
        SqlParameter[] prm = new SqlParameter[4];

        prm[0] = new SqlParameter("@LOC_HRCHY_CODE", LOC_HRCHY_CODE);
        prm[1] = new SqlParameter("@LOC_APPROVE_AMT", LOC_APPROVE_AMT);
        prm[2] = new SqlParameter("@JS_TYPE", JS_TYPE);
        prm[3] = new SqlParameter("@ENTRY_BY", Entry_By);

        ExecuteNonQuery(CommandType.StoredProcedure, "Usp_Insert_Webx_Fleet_JS_Approval_Hrchy_Amt", prm);
    }
    public void Update_JS_Approval_Amt()
    {
        SqlParameter[] prm = new SqlParameter[5];

        prm[0] = new SqlParameter("@Id", ID);
        prm[1] = new SqlParameter("@LOC_HRCHY_CODE", LOC_HRCHY_CODE);
        prm[2] = new SqlParameter("@LOC_APPROVE_AMT", LOC_APPROVE_AMT);
        prm[3] = new SqlParameter("@JS_TYPE", JS_TYPE);
        prm[4] = new SqlParameter("@UPDATE_BY", Entry_By);

        ExecuteNonQuery(CommandType.StoredProcedure, "Usp_Update_Webx_Fleet_JS_Approval_Hrchy_Amt", prm);
    }

    public void InsertJobApprovalMatrix()
    {
        SqlParameter[] prm = new SqlParameter[6];

        prm[0] = new SqlParameter("@Approved_Id", Approved_Id);
        prm[1] = new SqlParameter("@Approver_UserId", Approver_UserId);
        prm[2] = new SqlParameter("@CC_UserId", CC_UserId);
        prm[3] = new SqlParameter("@Jobsheet_Type", JS_TYPE);
        prm[4] = new SqlParameter("@Approve_Amount", LOC_APPROVE_AMT);
        prm[5] = new SqlParameter("@Entry_By", Entry_By);

        ExecuteNonQuery(CommandType.StoredProcedure, "Usp_Insert_Fleet_JS_Approval_Matrix", prm);
    }
    public void UpdateJobApprovalMatrix()
    {
        SqlParameter[] prm = new SqlParameter[4];

        prm[0] = new SqlParameter("@Approved_Id", Approved_Id);
        prm[1] = new SqlParameter("@Approver_UserId", Approver_UserId);
        prm[2] = new SqlParameter("@CC_UserId", CC_UserId);
        prm[3] = new SqlParameter("@Updated_By", Entry_By);

        ExecuteNonQuery(CommandType.StoredProcedure, "Usp_Update_Fleet_JS_Approval_Matrix", prm);
    }

    //public DataTable CheckApproveUserID(string strApproveUserID)
    //{
    //    DataTable dt = new DataTable();
    //    DataControlManager dcm = new DataControlManager(_Connection_String);
    //    dt = ExecuteDataTable(CommandType.Text, "select Items from dbo.Split('" + strApproveUserID + "',',') where Items not in ( select UserId from WebX_Master_Users)");
    //    return dt;
    //}

    //public DataTable CheckCCUserID(string strCCUserID)
    //{
    //    DataTable dt = new DataTable();
    //    DataControlManager dcm = new DataControlManager(_Connection_String);
    //    dt = ExecuteDataTable(CommandType.Text, "select Items from dbo.Split('" + strCCUserID + "',',') where Items not in ( select UserId from WebX_Master_Users)");
    //    return dt;
    //}

    public void CheckUserID(string UserId)
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@UserID", UserId);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "USP_Fleet_JS_Matrix", prm);

        if (dt.Rows.Count > 0)
        {
            if (dt.Rows[0]["UserID"].ToString() != "")
            {
                IsRecordFound = true;
                UserID = dt.Rows[0]["UserID"].ToString();
                if (EmailId != null)
                {
                    EmailId = dt.Rows[0]["EmailId"].ToString();
                }
            }
        }
        else
        {
            IsRecordFound = false;
        }
    }

    //public void CheckUserEmailID(string UserId)
    //{
    //    DataTable dt = new DataTable();
    //    SqlParameter[] prm = new SqlParameter[1];

    //    prm[0] = new SqlParameter("@UserID", UserId);

    //    dt = ExecuteDataTable(CommandType.StoredProcedure, "USP_Fleet_CheckValid_UsersEmailID", prm);

    //    if (dt.Rows.Count > 0)
    //    {
    //        if (dt.Rows[0]["UserID"].ToString() != "")
    //        {
    //            IsRecordFound = true;
    //            UserID = dt.Rows[0]["UserID"].ToString();
    //            if (EmailId != null)
    //            {
    //                EmailId = dt.Rows[0]["EmailId"].ToString();
    //            }
    //        }
    //    }
    //    else
    //    {
    //        IsRecordFound = false;
    //    }
    //}

    public void UpdateJobsheetApproval()
    {
        SqlParameter[] prm = new SqlParameter[7];

        prm[0] = new SqlParameter("@JOB_ORDER_NO", JobOrderNo);
        prm[1] = new SqlParameter("@JS_Approve", JS_Approve);
        prm[2] = new SqlParameter("@JS_Approve_By", JS_Approve_By);
        prm[3] = new SqlParameter("@JS_Reject", JS_Reject);
        prm[4] = new SqlParameter("@JS_Reject_By", JS_Reject_By);
        prm[5] = new SqlParameter("@JS_Approved_LocCode", JS_BRCD);
        prm[6] = new SqlParameter("@JS_Approval_Remarks", JS_Approval_Remarks); 

        ExecuteNonQuery(CommandType.StoredProcedure, "Usp_Update_Jobsheet_Approval", prm);
    }
    
    public void BindGVJSApproveGenerate(GridView gv)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[6];

        prm[0] = new SqlParameter("@JobOrderNo", (JobOrderNo == null) ? "" : JobOrderNo);
        prm[1] = new SqlParameter("@JobOrderFromDt", (JobOrderFromDt == null) ? "" : JobOrderFromDt);
        prm[2] = new SqlParameter("@JobOrderToDt", (JobOrderToDt == null) ? "" : JobOrderToDt);
        prm[3] = new SqlParameter("@JobCardType", (JobCardType == null) ? "" : JobCardType);
        prm[4] = new SqlParameter("@JS_BRCD", (JS_BRCD == null) ? "" : JS_BRCD);
        prm[5] = new SqlParameter("@Company_Code", (Company_Code == null) ? "" : Company_Code);

        dcm.DataBind(gv, CommandType.StoredProcedure, "usp_JobOrderGenerateApproveList", prm);
    }
    public void BindGVJSCloseJobSheet(GridView gv)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[6];

        prm[0] = new SqlParameter("@JobOrderNo", (JobOrderNo == null) ? "" : JobOrderNo);
        prm[1] = new SqlParameter("@JobOrderFromDt", (JobOrderFromDt == null) ? "" : JobOrderFromDt);
        prm[2] = new SqlParameter("@JobOrderToDt", (JobOrderToDt == null) ? "" : JobOrderToDt);
        prm[3] = new SqlParameter("@JobCardType", (JobCardType == null) ? "" : JobCardType);
        prm[4] = new SqlParameter("@JS_BRCD", (JS_BRCD == null) ? "" : JS_BRCD);
        prm[5] = new SqlParameter("@Company_Code", (Company_Code == null) ? "" : Company_Code);

        dcm.DataBind(gv, CommandType.StoredProcedure, "usp_JobOrderCloseApproveList", prm);
    }
    public void BindGridSM(GridView gv)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@VEHNO", (VehNo == null) ? "" : VehNo);

        dcm.DataBind(gv, CommandType.StoredProcedure, "usp_SMTask_GenerateJS_New", prm);
    }
    
    public void UpdateJobsheetApprovalClosure()
    {
        SqlParameter[] prm = new SqlParameter[7];

        prm[0] = new SqlParameter("@JOB_ORDER_NO", JobOrderNo);
        prm[1] = new SqlParameter("@JS_Approve", JS_Approve);
        prm[2] = new SqlParameter("@JS_Approve_By", JS_Approve_By);
        prm[3] = new SqlParameter("@JS_Reject", JS_Reject);
        prm[4] = new SqlParameter("@JS_Reject_By", JS_Reject_By);
        prm[5] = new SqlParameter("@JS_Approved_LocCode_Close", JS_BRCD);
        prm[6] = new SqlParameter("@JS_Approval_Remarks", JS_Approval_Remarks);

        ExecuteNonQuery(CommandType.StoredProcedure, "Usp_Update_Jobsheet_Approval_Clouare", prm);
    }

    public void BindGVApprovedAmt(GridView gv)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        dcm.DataBind(gv, CommandType.Text , "Select (SELECT CODEDESC FROM WEBX_MASTER_GENERAL WHERE CODETYPE='HRCHY' AND CODEID=LOC_HRCHY_CODE) AS CODEDESC,JS_TYPE,LOC_APPROVE_AMT,UPDATE_BY,CONVERT(VARCHAR,UPDATE_DT,106) AS UPDATE_DT FROM Webx_Fleet_JS_Approval_Hrchy_Amt");
    }
    
    public DataTable GetDataJobOrderHdr()
    {
        DataTable dt= new DataTable();
        DataControlManager dcm = new DataControlManager(_Connection_String);
        dt = ExecuteDataTable(CommandType.Text, "SELECT *,VehDet.* FROM WEBX_FLEET_PM_JOBORDER_HDR As JH cross apply (select ISNULL(H.Current_KM_Read,0) as Current_KM_Read,Vehicle_Status,Made_by,Model_No,Type_Name,Type_Code,H.VehNO from WEBX_VEHICLE_TYPE T,WEBX_VEHICLE_HDR H where T.Type_code=H.Vehicle_Type and H.VehNO=JH.VEHNO) VehDet  WHERE JOB_ORDER_NO = '" + JobOrderNo.ToString().Trim() + "'");
        return dt;
    }
    //public DataTable GetDataJobOrderTask()
    //{
    //    DataTable dt = new DataTable();
    //    DataControlManager dcm = new DataControlManager(_Connection_String);
    //    dt = ExecuteDataTable(CommandType.Text, "SELECT *,VehDet.* FROM WEBX_FLEET_PM_JOBORDER_DET As JH cross apply (select ISNULL(H.Current_KM_Read,0) as Current_KM_Read,Vehicle_Status,Made_by,Model_No,Type_Name,Type_Code,H.VehNO from WEBX_VEHICLE_TYPE T,WEBX_VEHICLE_HDR H where T.Type_code=H.Vehicle_Type and H.VehNO=JH.VEHNO) VehDet  WHERE JOB_ORDER_NO = '" + JobOrderNo.ToString().Trim() + "'");
    //    return dt;
    //}
    public DataSet GetDataJobOrderTask()
    {
        DataSet ds = new DataSet();
        DataControlManager dcm = new DataControlManager(_Connection_String);
        ds = ExecuteDataSet(CommandType.Text, "SELECT *,(select codedesc from webx_master_general where codetype='JOBTSKTYP' and codeid=(Select TASKTYP From WEBX_FLEET_GENERALTASKMST Where TASKCD=WEBX_FLEET_PM_JOBORDER_DET.TASKCD)) as TaskType FROM  WEBX_FLEET_PM_JOBORDER_DET WHERE JOB_ORDER_NO = '" + JobOrderNo.ToString().Trim() + "'");
        return ds;
    }
    public DataSet GetDataJobOrderSparePart()
    {
        DataSet ds = new DataSet();
        DataControlManager dcm = new DataControlManager(_Connection_String);
        ds = ExecuteDataSet(CommandType.Text, "SELECT *FROM  WEBX_FLEET_PM_JOBORDER_SPARE_EST_DET WHERE JOB_ORDER_NO = '" + JobOrderNo.ToString().Trim() + "'");
        return ds;
    }
    public void ExecuteNonQry(string strSql)
    {
        SqlConnection con = new SqlConnection(_Connection_String);
        con.Open();
        SqlCommand cmd = new SqlCommand(strSql, con);
        cmd.ExecuteNonQuery();
        con.Close();
    }
    public DataTable GetDataTable(String StrSql)
    {
        DataTable dt = new DataTable();
        DataControlManager dcm = new DataControlManager(_Connection_String);
        dt = ExecuteDataTable(CommandType.Text, StrSql);
        return dt;
    }
    public void BindGridSummary(GridView gv)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        dcm.DataBind(gv, CommandType.Text, "SELECT TaskType,ACCDESC,SUM(TOT_LABOUR_COST) AS TOT_LABOUR_COST,SUM(TOT_SPARE_COST)AS TOT_SPARE_COST FROM VW_JOBSHEET_SUMMARY WHERE JOB_ORDER_NO ='" + JobOrderNo.ToString().Trim() + "' GROUP BY TASKTYPE,ACCDESC");
    }
    public DataTable JobOrderDetListView()
    {
        DataTable dt = new DataTable();
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[2];

        prm[0] = new SqlParameter("@OrderNo", JobOrderNo);
        prm[1] = new SqlParameter("@Company_Code", Company_Code);


        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Job_JobOrderDetListView", prm);
        return dt;
    }

    public DataTable JobOrderDetPartView()
    {
        DataTable dt = new DataTable();
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[2];
        dt = new DataTable("New");
        prm[0] = new SqlParameter("@OrderNo", JobOrderNo);
        prm[1] = new SqlParameter("@Company_Code", Company_Code);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Job_JobOrderDetPartView", prm);
        return dt;
    }
    public DataTable GetDataJobHdrCloure()
    {
        DataTable dt = new DataTable();
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[3];

        prm[0] = new SqlParameter("@OrderNo", JobOrderNo);
        prm[1] = new SqlParameter("@VEHNO", "");
        prm[2] = new SqlParameter("@Flag", "Y");

        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Job_JobOrderList", prm);
        return dt;
    }
    public void CloseJobSheetUpdateStatus()
    {
        SqlParameter[] prm = new SqlParameter[3];

        prm[0] = new SqlParameter("@JOB_ORDER_NO", JobOrderNo);
        prm[1] = new SqlParameter("@JOB_Order_Closedt", JobOrderToDt);
        prm[2] = new SqlParameter("@JS_BRCD", JS_BRCD);

        ExecuteNonQuery(CommandType.StoredProcedure, "Usp_CloseJobSheetUpdateStatus", prm);
    }
    public DataTable GetDataJobTaskCloure()
    {
        DataTable dt = new DataTable();
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[2];

        prm[0] = new SqlParameter("@OrderNo", JobOrderNo);
        prm[1] = new SqlParameter("@Company_Code", Company_Code);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Job_JobOrderDetListView", prm);
        return dt;
    }

    public DataTable CheckCloseJS()
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        DataTable dt = new DataTable();
        dt = ExecuteDataTable(CommandType.Text, "SELECT totCount=Count(*) FROM WEBX_FLEET_PM_JOBORDER_HDR as JH Inner Join Webx_Fleet_JobOrder_Approval_Mst as JA On JH.Job_Order_No = JA.Job_Order_No Where 1=1 And Approved is null And Flag='Closure' AND  JH.JOB_ORDER_NO='" + JobOrderNo.Trim() + "'");
        return dt;
    }
    public DataTable GetDataJobPartList()
    {
        DataTable dt = new DataTable();
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[2];

        prm[0] = new SqlParameter("@OrderNo", JobOrderNo);
        prm[1] = new SqlParameter("@Company_Code", Company_Code);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Job_JobOrderDetPartView", prm);
        return dt;
    }
    public DataTable GetDataAddJobOrder()
    {
        DataTable dt = new DataTable();
        DataControlManager dcm = new DataControlManager(_Connection_String);
        dt = ExecuteDataTable(CommandType.Text, "select  distinct H.JOB_ORDER_NO from WEBX_FLEET_PM_JOBORDER_HDR H  where  H.JOB_ORDER_CLOSEDT is  null and JOB_ORDER_NO='" + JobOrderNo + "'");
        return dt;
    }
    public void GetJobOrderRules()
    {
        DataTable dt = new DataTable();
        dt = ExecuteDataTable(CommandType.Text, "select *from Webx_Fleet_JobOrder_Rules Where ID = 1");

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            Vehicle_Attached_TS = dt.Rows[0]["Vehicle_Attached_TS"].ToString();
            Vehicle_Attached_JS = dt.Rows[0]["Vehicle_Attached_JS"].ToString();
            Labour_Cost_TaskWise = dt.Rows[0]["Labour_Cost_TaskWise"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }
}
