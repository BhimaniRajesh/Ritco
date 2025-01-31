﻿using System;
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
using WebX.Common;

/// <summary>
/// Summary description for cls_TyreIssueMaster
/// </summary>
public class cls_TyreIssueMaster : DataAccessLayer
{
    #region Private Declaration

    private string _Connection_String;
    protected bool _IsRecordFound;

    private string _TyreId;
    private string _TD_ID;
    private string _VEH_NO, _NEW_VEH_NO;
    private string _TYRE_ID;
    private string _TYRE_STATUS, _TYRE_LOC, _MAKE, _TYRE_TYPE, _ENTRY_BY, _UPDATEDBY, _UPDATEDT;
    private int _VehId;
    private int _KM_RUN, _REMOVAL_KM;
    private DateTime _IssueDate, _REMOVAL_DATE;
    private string _POSITION;
    private string _TYRE_TREAD_DEPTH_32NDS;
    private string _MFG, _SIZE, _PATTERN;
    private string _MODEL;
    private string _Company_Code;
    private Int32 _Tyre_Attached, _AttachedTyre_Count, _Prev_TyreCount;
    private Double _Dist_Covered;
    private Double _CostPerKM, _RemovalKM, _KM;
    private string _Suffix, _Tyre_Vendor;
    private string _Actions;

    private string _CLAIM_REMOLD_SALE_ID, _ACTION_DT, _BRANCH, _VendorCode, _mobileNo, _STATUS, _C_Remark, _Claim_YN;
    private string _S_REMARK, _R_REMARK, _RMOLD_YN;
    private string _PayMode, _Acccode, _Chqno, _PAYDT, _Cashcode, _Bankaccode;
    private Double _ChqAmt, _NetPay, _SALE_AMT, _REMOLD_AMT, _CLAIM_AMT, _CashAmt;
    private Int32 _SR_NO;
    private string _XMLData;
    private string _Chqdate;

    private string _BILL_NO, _BILL_DT, _VOUCHER_NO, _VOUCHER_DT, _company_code;
    private Double _BILL_AMT, _VOUCHER_AMT, _PAID_AMT, _PENDING_AMT, _CURRENT_AMT;

    //added by vidya on 19 apr 2014
    public static string Tyre_IDs = "";
    public string TotalRate { get; set; }
    public string FinalRate { get; set; }
    public string CreditKM { get; set; }
    public string FileUploadPath { get; set; }

    #endregion


    #region Properties
    public bool IsRecordFound { get { return _IsRecordFound; } set { _IsRecordFound = value; } }

    public string TyreId { get { return _TyreId; } set { _TyreId = value; } }
    public int VehId { get { return _VehId; } set { _VehId = value; } }
    public string TD_ID { get { return _TD_ID; } set { _TD_ID = value; } }
    public string VEH_NO { get { return _VEH_NO; } set { _VEH_NO = value; } }
    public string NEW_VEH_NO { get { return _NEW_VEH_NO; } set { _NEW_VEH_NO = value; } }
    public string TYRE_ID { get { return _TYRE_ID; } set { _TYRE_ID = value; } }
    public string TYRE_LOC { get { return _TYRE_LOC; } set { _TYRE_LOC = value; } }

    public string SIZE { get { return _SIZE; } set { _SIZE = value; } }
    public string PATTERN { get { return _PATTERN; } set { _PATTERN = value; } }
    public string TYRE_TYPE { get { return _TYRE_TYPE; } set { _TYRE_TYPE = value; } }

    public int KM_RUN { get { return _KM_RUN; } set { _KM_RUN = value; } }
    public int REMOVAL_KM { get { return _REMOVAL_KM; } set { _REMOVAL_KM = value; } }
    public string POSITION { get { return _POSITION; } set { _POSITION = value; } }
    public string TYRE_TREAD_DEPTH_32NDS { get { return _TYRE_TREAD_DEPTH_32NDS; } set { _TYRE_TREAD_DEPTH_32NDS = value; } }
    public string MFG { get { return _MFG; } set { _MFG = value; } }
    public string MODEL { get { return _MODEL; } set { _MODEL = value; } }
    public string Company_Code { get { return _Company_Code; } set { _Company_Code = value; } }
    public DateTime IssueDate { get { return _IssueDate; } set { _IssueDate = value; } }
    public DateTime REMOVAL_DATE { get { return _REMOVAL_DATE; } set { _REMOVAL_DATE = value; } }

    public string MAKE { get { return _MAKE; } set { _MAKE = value; } }
    public string ENTRY_BY { get { return _ENTRY_BY; } set { _ENTRY_BY = value; } }
    public string UPDATEDBY { get { return _UPDATEDBY; } set { _UPDATEDBY = value; } }
    public string UPDATEDT { get { return _UPDATEDT; } set { _UPDATEDT = value; } }

    public Int32 Tyre_Attached { get { return _Tyre_Attached; } set { _Tyre_Attached = value; } }
    public Int32 AttachedTyre_Count { get { return _AttachedTyre_Count; } set { _AttachedTyre_Count = value; } }
    public Int32 Prev_TyreCount { get { return _Prev_TyreCount; } set { _Prev_TyreCount = value; } }

    //added on 20 may 2013

    public Double Dist_Covered { get { return _Dist_Covered; } set { _Dist_Covered = value; } }
    public Double CostPerKM { get { return _CostPerKM; } set { _CostPerKM = value; } }
    public Double RemovalKM { get { return _RemovalKM; } set { _RemovalKM = value; } }
    public string Actions { get { return _Actions; } set { _Actions = value; } }
    public string Suffix { get { return _Suffix; } set { _Suffix = value; } }
    public string Tyre_Vendor { get { return _Tyre_Vendor; } set { _Tyre_Vendor = value; } }
    public string XMLData { get { return _XMLData; } set { _XMLData = value; } }

    //ADDED ON 15 NOV 2013

    public string CLAIM_REMOLD_SALE_ID { get { return _CLAIM_REMOLD_SALE_ID; } set { _CLAIM_REMOLD_SALE_ID = value; } }
    public string ACTION_DT { get { return _ACTION_DT; } set { _ACTION_DT = value; } }
    public string BRANCH { get { return _BRANCH; } set { _BRANCH = value; } }
    public string VendorCode { get { return _VendorCode; } set { _VendorCode = value; } }
    public string mobileNo { get { return _mobileNo; } set { _mobileNo = value; } }
    public string STATUS { get { return _STATUS; } set { _STATUS = value; } }
    public string TYRE_STATUS { get { return _TYRE_STATUS; } set { _TYRE_STATUS = value; } }

    public string C_Remark { get { return _C_Remark; } set { _C_Remark = value; } }
    public string Claim_YN { get { return _Claim_YN; } set { _Claim_YN = value; } }
    public string S_REMARK { get { return _S_REMARK; } set { _S_REMARK = value; } }
    public string R_REMARK { get { return _R_REMARK; } set { _R_REMARK = value; } }
    public string RMOLD_YN { get { return _RMOLD_YN; } set { _RMOLD_YN = value; } }

    public string PayMode { get { return _PayMode; } set { _PayMode = value; } }
    public string Acccode { get { return _Acccode; } set { _Acccode = value; } }
    public string Chqno { get { return _Chqno; } set { _Chqno = value; } }
    public string Chqdate { get { return _Chqdate; } set { _Chqdate = value; } }
    public string PAYDT { get { return _PAYDT; } set { _PAYDT = value; } }

    public string Cashcode { get { return _Cashcode; } set { _Cashcode = value; } }
    public string Bankaccode { get { return _Bankaccode; } set { _Bankaccode = value; } }

    public Double KM { get { return _KM; } set { _KM = value; } }
    public Double CLAIM_AMT { get { return _CLAIM_AMT; } set { _CLAIM_AMT = value; } }
    public Double SALE_AMT { get { return _SALE_AMT; } set { _SALE_AMT = value; } }
    public Double REMOLD_AMT { get { return _REMOLD_AMT; } set { _REMOLD_AMT = value; } }
    public Double ChqAmt { get { return _ChqAmt; } set { _ChqAmt = value; } }
    public Double NetPay { get { return _NetPay; } set { _NetPay = value; } }
    public Double CashAmt { get { return _CashAmt; } set { _CashAmt = value; } }
    public Int32 SR_NO { get { return _SR_NO; } set { _SR_NO = value; } }

    public string BILL_NO { get { return _BILL_NO; } set { _BILL_NO = value; } }
    public string BILL_DT { get { return _BILL_DT; } set { _BILL_DT = value; } }
    public string VOUCHER_NO { get { return _VOUCHER_NO; } set { _VOUCHER_NO = value; } }
    public string VOUCHER_DT { get { return _VOUCHER_DT; } set { _VOUCHER_DT = value; } }
    public string company_code { get { return _company_code; } set { _company_code = value; } }

    public Double BILL_AMT { get { return _BILL_AMT; } set { _BILL_AMT = value; } }
    public Double VOUCHER_AMT { get { return _VOUCHER_AMT; } set { _VOUCHER_AMT = value; } }
    public Double PAID_AMT { get { return _PAID_AMT; } set { _PAID_AMT = value; } }
    public Double PENDING_AMT { get { return _PENDING_AMT; } set { _PENDING_AMT = value; } }
    public Double CURRENT_AMT { get { return _CURRENT_AMT; } set { _CURRENT_AMT = value; } }

    #endregion
    //public cls_TyreIssueMaster()
    //{
    //    //
    //    // TODO: Add constructor logic here
    //    //
    //}

    public cls_TyreIssueMaster(string ConnectionString)
        : base(ConnectionString)
    {
        _Connection_String = ConnectionString;
    }

    #region Fetch Data
    /// <summary>
    /// fetch tyre details according to selection of branch 
    /// </summary>
    /// <param name="gv"></param>
    public DataTable BindOldTyreDetails(string VehicleNo,string type)
    {
        SqlParameter[] prm = new SqlParameter[3];
        prm[0] = new SqlParameter("@VehicleNo", VehicleNo);
		prm[1] = new SqlParameter("@Branch", TYRE_LOC.ToString());
		prm[2] = new SqlParameter("@Type", type);
		
        var dt = new DataTable();
        using (var oWebXHelper = new WebXHelper())
        {
            dt = oWebXHelper.ExecuteDataTable(CommandType.StoredProcedure, "USP_OldTyre_List_new", prm);
        }
        return dt;
    }

    /// <summary>
    /// fetch tyre details according to selection of branch 
    /// </summary>
    /// <param name="gv"></param>
    public void BindGridTyreDetails(GridView gv)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[1];
        prm[0] = new SqlParameter("@TYRE_LOC", TYRE_LOC.ToString());
        //dcm.DataBind(gv, CommandType.StoredProcedure, "USP_Get_TyreDetail_BranchWIse", prm);
        dcm.DataBind(gv, CommandType.StoredProcedure, "USP_Get_TyreDetail_BranchWIse_NEW", prm);
    }

    /// <summary>
    /// fetch tyre details according to selection of branch 
    /// </summary>
    /// <param name="gv"></param>
    public void BindGridCliam(GridView gv, string FromDT, string ToDT)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[4];
        prm[0] = new SqlParameter("@FromDT", FromDT.ToString());
        prm[1] = new SqlParameter("@ToDT", ToDT.ToString());
        prm[2] = new SqlParameter("@VendorID", VendorCode.ToString());
        prm[3] = new SqlParameter("@ClaimID", CLAIM_REMOLD_SALE_ID.ToString());
        dcm.DataBind(gv, CommandType.StoredProcedure, "USP_ClaimList", prm);
    }
    /// <summary>
    /// Display list of Remold no & no of tyres against it
    /// </summary>
    /// <param name="gv"></param>
    /// <param name="FromDT"></param>
    /// <param name="ToDT"></param>
    public void GetRemoldID_List(GridView gv, string FromDT, string ToDT)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[4];
        prm[0] = new SqlParameter("@FromDT", FromDT.ToString());
        prm[1] = new SqlParameter("@ToDT", ToDT.ToString());
        prm[2] = new SqlParameter("@VendorID", VendorCode.ToString());
        prm[3] = new SqlParameter("@RemoldID", CLAIM_REMOLD_SALE_ID.ToString());
        dcm.DataBind(gv, CommandType.StoredProcedure, "USP_RemoldList", prm);
    }

    public void GetRemoldBill_List(GridView gv, string FromDT, string ToDT)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[4];
        prm[0] = new SqlParameter("@FromDT", FromDT.ToString());
        prm[1] = new SqlParameter("@ToDT", ToDT.ToString());
        prm[2] = new SqlParameter("@VendorID", VendorCode.ToString());
        prm[3] = new SqlParameter("@BILLNO", BILL_NO.Trim());
        dcm.DataBind(gv, CommandType.StoredProcedure, "USP_RemoldBillList", prm);
    }

    /// <summary>
    ///  Display list of Remold no & tyre detais
    /// </summary>
    /// <param name="gv"></param>
    public void GetRemoldID_ListDtls(GridView gv)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[1];
        prm[0] = new SqlParameter("@RemoldID", CLAIM_REMOLD_SALE_ID.ToString());
        dcm.DataBind(gv, CommandType.StoredProcedure, "USP_RemoldList_Dtls", prm);
    }

    /// <summary>
    /// fetch tyre details according to selection of vehicle 
    /// </summary>
    /// <param name="gv"></param>
    public void BindGetTyreDetails(GridView gv)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        SqlParameter[] prm = new SqlParameter[1];
        prm[0] = new SqlParameter("@VHNO", VEH_NO.ToString());
        dcm.DataBind(gv, CommandType.StoredProcedure, "USP_Get_TyreDetail_VehicleWIse_New", prm);
        //USP_Get_TyreDetail_VehicleWIse
    }

    /// <summary>
    /// Bind grid for sale
    /// </summary>
    /// <param name="gv"></param>
    /// <param name="strSql"></param>
    public void GetTyres_Sale(GridView gv, string strSql)
    {
        string Sql = "EXEC USP_TyresList_Sale '" + strSql + "'";

        DataControlManager dcm = new DataControlManager(SessionUtilities.ConnectionString.Trim());
        dcm.DataBind(gv, CommandType.Text, Sql);
    }

    /// <summary>
    /// Bind grid for Claim
    /// </summary>
    /// <param name="gv"></param>
    /// <param name="strSql"></param>
    public void GetTyres_Claim(GridView gv, string strSql)
    {
        string Sql = "EXEC USP_TyresList_Claim '" + strSql + "'";

        DataControlManager dcm = new DataControlManager(SessionUtilities.ConnectionString.Trim());
        dcm.DataBind(gv, CommandType.Text, Sql);
    }


    /// <summary>
    /// Bind grid for Claim
    /// </summary>
    /// <param name="gv"></param>
    /// <param name="strSql"></param>
    public void GetTyres_CPKM(GridView gv, string strSql)
    {
        string Sql = "EXEC USP_TyresList_CPKM '" + strSql + "'";

        DataControlManager dcm = new DataControlManager(SessionUtilities.ConnectionString.Trim());
        dcm.DataBind(gv, CommandType.Text, Sql);
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="gv"></param>
    /// <param name="strSql"></param>
    public void GetTyres_Claim_New(GridView gv, string strSql)
    {
        string Sql = "EXEC USP_GetTyres_Claim '" + strSql + "'";

        DataControlManager dcm = new DataControlManager(SessionUtilities.ConnectionString.Trim());
        dcm.DataBind(gv, CommandType.Text, Sql);
    }

    /// <summary>
    /// Bind grid for Remold
    /// </summary>
    /// <param name="gv"></param>
    /// <param name="strSql"></param>
    public void GetTyres_Remold(GridView gv, string strSql)
    {
        string Sql = "EXEC USP_TyresList_Remold '" + strSql + "'";

        DataControlManager dcm = new DataControlManager(SessionUtilities.ConnectionString.Trim());
        dcm.DataBind(gv, CommandType.Text, Sql);
    }
    /// <summary>
    /// Bind Grid For Exception
    /// </summary>
    /// <param name="gv"></param>
    public void GetTyreException(GridView gv)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        dcm.DataBind(gv, CommandType.StoredProcedure, "USP_Get_TyreException");
    }

    #endregion

    #region Update Data
    /// <summary>
    /// update tyre details
    /// INSERT INTO WEBX_FLEET_TYREMST_History & WEBX_FLEET_VEHICLE_FITMENT_KM TABLE
    /// PASS A/C ING [ EXP0177 (Tyre Expenses - Owned Fleet) DR. and "EXP0161 (Tyre Stock) CR. ]
    /// </summary>
    /// 
    public void UpdateTyreDtl()
    {
        SqlConnection conn = new SqlConnection(_Connection_String);
        conn.Open();
        SqlCommand cmd = new SqlCommand("USP_UpdateTyreDtl", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.SelectCommand.Parameters.Add("@VEH_NO", SqlDbType.VarChar).Value = VEH_NO.ToString().Trim();
        da.SelectCommand.Parameters.Add("@IssueDate", SqlDbType.DateTime).Value = IssueDate.ToString().Trim();
        da.SelectCommand.Parameters.Add("@KM_RUN", SqlDbType.Int).Value = KM_RUN;
        da.SelectCommand.Parameters.Add("@TYRE_ID", SqlDbType.VarChar).Value = TYRE_ID.ToString();
        da.SelectCommand.Parameters.Add("@ENTRY_BY", SqlDbType.VarChar).Value = ENTRY_BY.ToString().Trim();
        da.SelectCommand.Parameters.Add("@LOC", SqlDbType.VarChar).Value = TYRE_LOC.ToString().Trim();
        cmd.ExecuteNonQuery();
        da.Dispose();
        conn.Dispose();
        conn.Close();
    }
    /// <summary>
    /// update tyre details
    /// </summary>
    public void UpdateRemovalTyreDtl()
    {
        SqlConnection conn = new SqlConnection(_Connection_String);
        conn.Open();
        //USP_UpdateDismountTyreDtl
        SqlCommand cmd = new SqlCommand("USP_UpdateDismountTyreDtl_New", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        try
        {
            string T = TYRE_ID.ToString();

            da.SelectCommand.Parameters.Add("@VEH_NO", SqlDbType.VarChar).Value = VEH_NO.ToString().Trim();
            da.SelectCommand.Parameters.Add("@KM_RUN", SqlDbType.Decimal).Value = RemovalKM;
            da.SelectCommand.Parameters.Add("@TYRE_ID", SqlDbType.VarChar).Value = TYRE_ID.ToString();
            da.SelectCommand.Parameters.Add("@ENTRY_BY", SqlDbType.VarChar).Value = ENTRY_BY.ToString().Trim();
            da.SelectCommand.Parameters.Add("@Dist_Covered", SqlDbType.VarChar).Value = Dist_Covered.ToString().Trim();
            da.SelectCommand.Parameters.Add("@CostPerKM", SqlDbType.VarChar).Value = CostPerKM.ToString().Trim();

            //da.SelectCommand.Parameters.Add("@REMOVALKM", SqlDbType.Int).Value = REMOVAL_KM;
            //da.SelectCommand.Parameters.Add("@COMPANY_CODE", SqlDbType.VarChar).Value = Company_Code.ToString().Trim();
            da.SelectCommand.Parameters.Add("@LOCATION", SqlDbType.VarChar).Value = TYRE_LOC.ToString().Trim();
            da.SelectCommand.Parameters.Add("@TYRE_REMOVE_DT", SqlDbType.DateTime).Value = REMOVAL_DATE.ToString().Trim();

            cmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "cls_TyreIssueMaster -> UpdateRemovalTyreDtl");
            throw;
        }
        da.Dispose();
        conn.Dispose();
        conn.Close();
    }
    /// <summary>
    /// update tyres in old  stock
    /// for Internal=I; Sale=S;Claim=C;Remold=R
    /// </summary>
    public void UpdateOldTyreDtl()
    {
        SqlConnection conn = new SqlConnection(_Connection_String);
        conn.Open();
        SqlCommand cmd = new SqlCommand("USP_UpdateOldTyreDtl", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.SelectCommand.Parameters.Add("@TYRE_ID", SqlDbType.VarChar).Value = TYRE_ID.ToString();
        da.SelectCommand.Parameters.Add("@Suffix", SqlDbType.VarChar).Value = Suffix.ToString().Trim();
        da.SelectCommand.Parameters.Add("@Actions", SqlDbType.VarChar).Value = Actions.Trim();
        da.SelectCommand.Parameters.Add("@Branch", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode.Trim();
        da.SelectCommand.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID.Trim();

        cmd.ExecuteNonQuery();
        da.Dispose();
        conn.Dispose();
        conn.Close();
    }

    /// <summary>
    /// update tire for sale
    /// for Internal=I; Sale=S;Claim=C;Remold=R
    /// </summary>
    public void UpdateTyreDtl_Sale()
    {
        SqlConnection conn = new SqlConnection(_Connection_String);
        conn.Open();
        //usp_XML_Update_TyreDtl_Sale
        SqlCommand cmd = new SqlCommand("usp_XML_Update_TyreDtl_Sale_New", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.SelectCommand.Parameters.Add("@Xml_TyreID", SqlDbType.VarChar).Value = XMLData.Trim();

        cmd.ExecuteNonQuery();
        da.Dispose();
        conn.Dispose();
        conn.Close();
    }

    public void UpdateTyre_SalePayment()
    {
        SqlConnection conn = new SqlConnection(_Connection_String);
        conn.Open();
        //usp_XML_Update_TyreDtl_Claim
        SqlCommand cmd = new SqlCommand("USP_TyreSale_Payment", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.SelectCommand.Parameters.Add("@TYRE_ID", SqlDbType.VarChar).Value = TYRE_ID.Trim();
        da.SelectCommand.Parameters.Add("@CLAIM_REMOLD_SALE_ID", SqlDbType.VarChar).Value = CLAIM_REMOLD_SALE_ID.Trim();
        da.SelectCommand.Parameters.Add("@VendorCode", SqlDbType.VarChar).Value = VendorCode.Trim();
        da.SelectCommand.Parameters.Add("@STATUS", SqlDbType.VarChar).Value = STATUS;
        da.SelectCommand.Parameters.Add("@SALE_AMT", SqlDbType.Decimal).Value = SALE_AMT;
        //da.SelectCommand.Parameters.Add("@ACTION_DT", SqlDbType.VarChar).Value = ACTION_DT;
        da.SelectCommand.Parameters.Add("@mobileNo", SqlDbType.VarChar).Value = mobileNo.Trim();
        da.SelectCommand.Parameters.Add("@Loc", SqlDbType.VarChar).Value = BRANCH.Trim();
        da.SelectCommand.Parameters.Add("@PayMode", SqlDbType.VarChar).Value = PayMode.Trim();
        da.SelectCommand.Parameters.Add("@Acccode", SqlDbType.VarChar).Value = Acccode.Trim();
        da.SelectCommand.Parameters.Add("@Chqno", SqlDbType.VarChar).Value = Chqno.Trim();
        da.SelectCommand.Parameters.Add("@Chqdate", SqlDbType.VarChar).Value = Chqdate;
        da.SelectCommand.Parameters.Add("@ChqAmt", SqlDbType.Decimal).Value = ChqAmt;
        da.SelectCommand.Parameters.Add("@CashAmt", SqlDbType.Decimal).Value = CashAmt;
        da.SelectCommand.Parameters.Add("@Cashcode", SqlDbType.VarChar).Value = Cashcode.Trim();
        da.SelectCommand.Parameters.Add("@Bankaccode", SqlDbType.VarChar).Value = Bankaccode.Trim();
        da.SelectCommand.Parameters.Add("@NetPay", SqlDbType.Decimal).Value = NetPay;
        da.SelectCommand.Parameters.Add("@UPDATEDBY", SqlDbType.VarChar).Value = UPDATEDBY.Trim();


        cmd.ExecuteNonQuery();
        da.Dispose();
        conn.Dispose();
        conn.Close();
    }

    /// <summary>
    /// update tyres for claim
    /// for Internal=I; Sale=S;Claim=C;Remold=R
    /// </summary>
    public void UpdateTyreDtl_Claim()
    {
        SqlConnection conn = new SqlConnection(_Connection_String);
        conn.Open();
        //usp_XML_Update_TyreDtl_Claim
        SqlCommand cmd = new SqlCommand("usp_XML_Update_TyreDtl_Claim_New", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.SelectCommand.Parameters.Add("@Xml_TyreID", SqlDbType.VarChar).Value = XMLData.Trim();

        cmd.ExecuteNonQuery();
        da.Dispose();
        conn.Dispose();
        conn.Close();
    }
    /// <summary>
    /// Payment of Tyres in case of Claim 
    /// </summary>
    public void UpdateTyre_ClaimPayment()
    {
        SqlConnection conn = new SqlConnection(_Connection_String);
        conn.Open();
        //usp_XML_Update_TyreDtl_Claim
        SqlCommand cmd = new SqlCommand("USP_TyreClaim_Payment", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.SelectCommand.Parameters.Add("@SR_NO", SqlDbType.VarChar).Value = SR_NO.ToString();
        da.SelectCommand.Parameters.Add("@TYRE_ID", SqlDbType.VarChar).Value = TYRE_ID.Trim();
        da.SelectCommand.Parameters.Add("@CLAIM_REMOLD_SALE_ID", SqlDbType.VarChar).Value = CLAIM_REMOLD_SALE_ID.Trim();
        da.SelectCommand.Parameters.Add("@VendorCode", SqlDbType.VarChar).Value = VendorCode.Trim();
        da.SelectCommand.Parameters.Add("@STATUS", SqlDbType.VarChar).Value = STATUS;
        da.SelectCommand.Parameters.Add("@CLAIM_AMT", SqlDbType.Decimal).Value = CLAIM_AMT;
        da.SelectCommand.Parameters.Add("@C_Remark", SqlDbType.VarChar).Value = C_Remark.Trim();
        da.SelectCommand.Parameters.Add("@Claim_YN", SqlDbType.VarChar).Value = Claim_YN.Trim();
        da.SelectCommand.Parameters.Add("@Loc", SqlDbType.VarChar).Value = BRANCH.Trim();
        da.SelectCommand.Parameters.Add("@PayMode", SqlDbType.VarChar).Value = PayMode.Trim();
        da.SelectCommand.Parameters.Add("@Acccode", SqlDbType.VarChar).Value = Acccode.Trim();
        da.SelectCommand.Parameters.Add("@Chqno", SqlDbType.VarChar).Value = Chqno.Trim();
        da.SelectCommand.Parameters.Add("@Chqdate", SqlDbType.VarChar).Value = Chqdate;
        da.SelectCommand.Parameters.Add("@ChqAmt", SqlDbType.Decimal).Value = ChqAmt;
        da.SelectCommand.Parameters.Add("@CashAmt", SqlDbType.Decimal).Value = CashAmt;
        da.SelectCommand.Parameters.Add("@Cashcode", SqlDbType.VarChar).Value = Cashcode.Trim();
        da.SelectCommand.Parameters.Add("@Bankaccode", SqlDbType.VarChar).Value = Bankaccode.Trim();
        da.SelectCommand.Parameters.Add("@NetPay", SqlDbType.Decimal).Value = NetPay;
        da.SelectCommand.Parameters.Add("@UPDATEDBY", SqlDbType.VarChar).Value = UPDATEDBY.Trim();
        cmd.ExecuteNonQuery();
        da.Dispose();
        conn.Dispose();
        conn.Close();
    }
    /// <summary>
    /// GENERATE BILL NO IN CASE OF REMOLD
    /// </summary>
    /// <param name="Brcd"></param>
    /// <param name="Finyear"></param>
    public void GENERATE_BILLNO(string Brcd, string Finyear)
    {

        DataTable dt = new DataTable();
        string SQL = "EXEC USP_GEN_REMOLD_BILLNO '" + Brcd + "','" + Finyear + "'";

        dt = ExecuteDataTable(CommandType.Text, SQL);
        if (dt.Rows.Count > 0)
        {
            BILL_NO = dt.Rows[0]["REMOLD_BILLNO"].ToString();
        }
        else
        {
            BILL_NO = "";
        }
    }

    public void INSERT_VENDOR_BILL()
    {
        SqlConnection conn = new SqlConnection(_Connection_String);
        conn.Open();
        //usp_XML_Update_TyreDtl_Claim
        SqlCommand cmd = new SqlCommand("USP_INSERT_VENDOR_BILL", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.SelectCommand.Parameters.Add("@SR_NO", SqlDbType.VarChar).Value = SR_NO.ToString();
        da.SelectCommand.Parameters.Add("@TYRE_ID", SqlDbType.VarChar).Value = TYRE_ID.Trim();
        da.SelectCommand.Parameters.Add("@CLAIM_REMOLD_SALE_ID", SqlDbType.VarChar).Value = CLAIM_REMOLD_SALE_ID.Trim();

        cmd.ExecuteNonQuery();
        da.Dispose();
        conn.Dispose();
        conn.Close();

    }
    /// <summary>
    /// Payment of Tyres in case of Remold
    /// </summary>
    public void UpdateTyre_RemoldPayment()
    {
        SqlConnection conn = new SqlConnection(_Connection_String);
        conn.Open();
        //usp_XML_Update_TyreDtl_Claim
        SqlCommand cmd = new SqlCommand("USP_TyreRemold_Payment", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.SelectCommand.Parameters.Add("@SR_NO", SqlDbType.VarChar).Value = SR_NO.ToString();
        da.SelectCommand.Parameters.Add("@TYRE_ID", SqlDbType.VarChar).Value = TYRE_ID.Trim();
        da.SelectCommand.Parameters.Add("@CLAIM_REMOLD_SALE_ID", SqlDbType.VarChar).Value = CLAIM_REMOLD_SALE_ID.Trim();
        da.SelectCommand.Parameters.Add("@STATUS", SqlDbType.VarChar).Value = STATUS;
        da.SelectCommand.Parameters.Add("@VendorCode", SqlDbType.VarChar).Value = VendorCode.Trim();
        da.SelectCommand.Parameters.Add("@REMOLD_AMT", SqlDbType.Decimal).Value = REMOLD_AMT;
        da.SelectCommand.Parameters.Add("@R_Remark", SqlDbType.VarChar).Value = R_REMARK;
        da.SelectCommand.Parameters.Add("@REMOLD_YN", SqlDbType.VarChar).Value = RMOLD_YN;
        da.SelectCommand.Parameters.Add("@Loc", SqlDbType.VarChar).Value = BRANCH.Trim();

        da.SelectCommand.Parameters.Add("@BILL_NO", SqlDbType.VarChar).Value = BILL_NO.Trim();
        da.SelectCommand.Parameters.Add("@NetPay", SqlDbType.Decimal).Value = NetPay;
        da.SelectCommand.Parameters.Add("@UPDATEDBY", SqlDbType.VarChar).Value = UPDATEDBY.Trim();
        da.SelectCommand.Parameters.Add("@PCAMT", SqlDbType.Decimal).Value = NetPay;
        da.SelectCommand.Parameters.Add("@company_code", SqlDbType.VarChar).Value = company_code.Trim();

        cmd.ExecuteNonQuery();
        da.Dispose();
        conn.Dispose();
        conn.Close();
    }
    /// <summary>
    ///INSERT INTO [WEBX_VENDORBILL_PAYDET] 
    ///update WEBX_vendorbill_hdr
    ///update WEBX_vendorbill_det
    ///Insert into webx_vouchertrans
    ///Insert into webx_vouchertrans_arch
    ///delete from webx_vouchertrans
    ///usp_Vendor_Payment_transaction_other
    /// </summary>
    public void UpdateRemold_BillPayment()
    {
        SqlConnection conn = new SqlConnection(_Connection_String);
        conn.Open();
        //usp_XML_Update_TyreDtl_Claim
        SqlCommand cmd = new SqlCommand("USP_Remold_BillPayment", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.SelectCommand.Parameters.Add("@SR_NO", SqlDbType.VarChar).Value = SR_NO.ToString();
        da.SelectCommand.Parameters.Add("@TYRE_ID", SqlDbType.VarChar).Value = TYRE_ID.Trim();
        da.SelectCommand.Parameters.Add("@CLAIM_REMOLD_SALE_ID", SqlDbType.VarChar).Value = CLAIM_REMOLD_SALE_ID.Trim();
        //da.SelectCommand.Parameters.Add("@STATUS", SqlDbType.VarChar).Value = STATUS;
        da.SelectCommand.Parameters.Add("@VendorCode", SqlDbType.VarChar).Value = VendorCode.Trim();
        da.SelectCommand.Parameters.Add("@REMOLD_AMT", SqlDbType.Decimal).Value = REMOLD_AMT;
        da.SelectCommand.Parameters.Add("@R_Remark", SqlDbType.VarChar).Value = R_REMARK;
        da.SelectCommand.Parameters.Add("@REMOLD_YN", SqlDbType.VarChar).Value = RMOLD_YN;
        da.SelectCommand.Parameters.Add("@Loc", SqlDbType.VarChar).Value = BRANCH.Trim();

        da.SelectCommand.Parameters.Add("@BILL_NO", SqlDbType.VarChar).Value = BILL_NO.Trim();
        da.SelectCommand.Parameters.Add("@NetPay", SqlDbType.Decimal).Value = NetPay;
        da.SelectCommand.Parameters.Add("@UPDATEDBY", SqlDbType.VarChar).Value = UPDATEDBY.Trim();
        da.SelectCommand.Parameters.Add("@PCAMT", SqlDbType.Decimal).Value = NetPay;
        da.SelectCommand.Parameters.Add("@company_code", SqlDbType.VarChar).Value = company_code.Trim();

        cmd.ExecuteNonQuery();
        da.Dispose();
        conn.Dispose();
        conn.Close();
    }
    /// <summary>
    /// 
    /// </summary>
    public void UpdateTyreDtl_ClaimNew()
    {
        SqlConnection conn = new SqlConnection(_Connection_String);
        conn.Open();
        SqlCommand cmd = new SqlCommand("USP_TYRE_CLAIM_UPDATE", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.SelectCommand.Parameters.Add("@TYRE_ID", SqlDbType.VarChar).Value = TYRE_ID.Trim();
        da.SelectCommand.Parameters.Add("@CLAIM_REMOLD_SALE_ID", SqlDbType.VarChar).Value = CLAIM_REMOLD_SALE_ID.Trim();
        da.SelectCommand.Parameters.Add("@ACTION_DT", SqlDbType.VarChar).Value = ACTION_DT.Trim();
        da.SelectCommand.Parameters.Add("@BRANCH", SqlDbType.VarChar).Value = BRANCH.Trim();
        da.SelectCommand.Parameters.Add("@VendorCode", SqlDbType.VarChar).Value = VendorCode.Trim();
        da.SelectCommand.Parameters.Add("@STATUS", SqlDbType.VarChar).Value = STATUS.Trim();
        da.SelectCommand.Parameters.Add("@ACTIONS", SqlDbType.VarChar).Value = Actions.Trim();
        da.SelectCommand.Parameters.Add("@CLAIM_AMT", SqlDbType.Decimal).Value = CLAIM_AMT;
        da.SelectCommand.Parameters.Add("@C_Remark", SqlDbType.VarChar).Value = C_Remark.Trim();
        da.SelectCommand.Parameters.Add("@Claim_YN", SqlDbType.VarChar).Value = Claim_YN.Trim();
        da.SelectCommand.Parameters.Add("@Suffix", SqlDbType.VarChar).Value = Suffix.Trim();
        da.SelectCommand.Parameters.Add("@Dist_Covered", SqlDbType.Decimal).Value = Dist_Covered;
        da.SelectCommand.Parameters.Add("@ENTRYBY", SqlDbType.VarChar).Value = ENTRY_BY.Trim();

        cmd.ExecuteNonQuery();
        da.Dispose();
        conn.Dispose();
        conn.Close();
    }

    /// <summary>
    /// 
    /// </summary>
    public void UpdateTyreDtl_CPKM()
    {
        SqlConnection conn = new SqlConnection(_Connection_String);
        conn.Open();
        SqlCommand cmd = new SqlCommand("USP_TYRE_CPKM_UPDATE", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.SelectCommand.Parameters.Add("@TYRE_ID", SqlDbType.VarChar).Value = TYRE_ID.Trim();
        da.SelectCommand.Parameters.Add("@BRANCH", SqlDbType.VarChar).Value = BRANCH.Trim();
        da.SelectCommand.Parameters.Add("@VendorCode", SqlDbType.VarChar).Value = VendorCode.Trim();
        da.SelectCommand.Parameters.Add("@Actions", SqlDbType.VarChar).Value = Actions.Trim();
        da.SelectCommand.Parameters.Add("@CLAIM_AMT", SqlDbType.Decimal).Value = CLAIM_AMT;
        da.SelectCommand.Parameters.Add("@TotalRate", SqlDbType.Decimal).Value = TotalRate.Trim();
        da.SelectCommand.Parameters.Add("@FinalRate", SqlDbType.Decimal).Value = FinalRate.Trim();
        da.SelectCommand.Parameters.Add("@CreditKM", SqlDbType.Decimal).Value = CreditKM.Trim();
        da.SelectCommand.Parameters.Add("@FileUploadPath", SqlDbType.VarChar).Value = FileUploadPath.Trim();
        da.SelectCommand.Parameters.Add("@ENTRYBY", SqlDbType.VarChar).Value = ENTRY_BY.Trim();
        da.SelectCommand.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = VEH_NO.Trim();
                        
        cmd.ExecuteNonQuery();
        da.Dispose();
        conn.Dispose();
        conn.Close();
    }
    /// <summary>
    /// update tiers for claim
    /// for Internal=I; Sale=S;Claim=C;Remold=R
    /// </summary>
    public void UpdateTyreDtl_Remold()
    {
        SqlConnection conn = new SqlConnection(_Connection_String);
        conn.Open();
        SqlCommand cmd = new SqlCommand("usp_XML_Update_TyreDtl_Remold", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.SelectCommand.Parameters.Add("@Xml_TyreID", SqlDbType.VarChar).Value = XMLData.Trim();

        cmd.ExecuteNonQuery();
        da.Dispose();
        conn.Dispose();
        conn.Close();
    }

    public void UpdateTyreDtl_RemoldNew()
    {
        SqlConnection conn = new SqlConnection(_Connection_String);
        conn.Open();
        SqlCommand cmd = new SqlCommand("USP_TYRE_REMOLD_UPDATE", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.SelectCommand.Parameters.Add("@TYRE_ID", SqlDbType.VarChar).Value = TYRE_ID.Trim();
        da.SelectCommand.Parameters.Add("@CLAIM_REMOLD_SALE_ID", SqlDbType.VarChar).Value = CLAIM_REMOLD_SALE_ID.Trim();
        da.SelectCommand.Parameters.Add("@ACTION_DT", SqlDbType.VarChar).Value = ACTION_DT.Trim();
        da.SelectCommand.Parameters.Add("@BRANCH", SqlDbType.VarChar).Value = BRANCH.Trim();
        da.SelectCommand.Parameters.Add("@VendorCode", SqlDbType.VarChar).Value = VendorCode.Trim();
        da.SelectCommand.Parameters.Add("@STATUS", SqlDbType.VarChar).Value = STATUS.Trim();
        da.SelectCommand.Parameters.Add("@ACTIONS", SqlDbType.VarChar).Value = Actions.Trim();
        da.SelectCommand.Parameters.Add("@Suffix", SqlDbType.VarChar).Value = Suffix.Trim();
        da.SelectCommand.Parameters.Add("@Dist_Covered", SqlDbType.Decimal).Value = Dist_Covered;
        da.SelectCommand.Parameters.Add("@ENTRYBY", SqlDbType.VarChar).Value = ENTRY_BY.Trim();

        cmd.ExecuteNonQuery();
        da.Dispose();
        conn.Dispose();
        conn.Close();
    }
    /// <summary>
    /// interchange tyre 
    /// </summary>
    public void Update_InterchangeTyre()
    {
        SqlConnection conn = new SqlConnection(_Connection_String);
        conn.Open();
        SqlCommand cmd = new SqlCommand("USP_INTERCHANGE_TYRE", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.SelectCommand.Parameters.Add("@TYRE_ID", SqlDbType.VarChar).Value = TYRE_ID.Trim();
        da.SelectCommand.Parameters.Add("@VHNO", SqlDbType.VarChar).Value = VEH_NO.Trim();
        da.SelectCommand.Parameters.Add("@NEW_VHNO", SqlDbType.VarChar).Value = NEW_VEH_NO.Trim();
        da.SelectCommand.Parameters.Add("@KM", SqlDbType.Decimal).Value = KM;
        da.SelectCommand.Parameters.Add("@BRANCH", SqlDbType.VarChar).Value = BRANCH.Trim();
        da.SelectCommand.Parameters.Add("@UPDATED_BY", SqlDbType.VarChar).Value = ENTRY_BY.Trim();

        cmd.ExecuteNonQuery();
        da.Dispose();
        conn.Dispose();
        conn.Close();
    }

    /// <summary>
    /// Update exception tyres
    /// </summary>
    public void UpdateTyreException()
    {
        //SqlParameter[] prm = new SqlParameter[5];
        //prm[0] = new SqlParameter("@VEHNO",VEH_NO );
        //prm[1] = new SqlParameter("@Tyre_ID",TYRE_ID );
        //prm[2] = new SqlParameter("@PendingExcess", );

        //ExecuteNonQuery(CommandType.StoredProcedure, "USP_Update_TyreException", prm);
    }



    #endregion
    #region Validations
    /// <summary>
    ///  To validate PO no.
    /// </summary>
    public void checkPONO(string PO_NO)
    {
        DataTable dt = new DataTable();
        string SQL = "select pocode from [webx_GENERAL_POASSET_HDR] where pocode='" + PO_NO.Trim() + "'";
        dt = ExecuteDataTable(CommandType.Text, SQL);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            //VEH_NO = dt.Rows[0]["VEHNO"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }
    /// <summary>
    /// Check for valid vehicle No
    /// </summary>
    public void CheckValidVehicle()
    {
        DataTable dt = new DataTable();

        //string SQL = "SELECT CUSTCD,CUSTNM FROM webx_CUSTHDR where CUSTNM='" + CUST_NM + "'";
        ////string SQL = "select VEHNO from webx_VEHICLE_HDR where ACTIVEFLAG='Y'and VEHNO='" + VEH_NO + "'";
        string SQL = "exec USP_Check_TyreCount '" + VEH_NO + "'";

        dt = ExecuteDataTable(CommandType.Text, SQL);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            VEH_NO = dt.Rows[0]["VEHNO"].ToString();
            Prev_TyreCount = Convert.ToInt32(dt.Rows[0]["TYRE_ID"].ToString());
            AttachedTyre_Count = Convert.ToInt32(dt.Rows[0]["Tyre_Attached"].ToString());
        }
        else
        {
            IsRecordFound = false;
        }
    }

    public void Check_KM()
    {
        DataTable dt = new DataTable();

        //string SQL = "SELECT CUSTCD,CUSTNM FROM webx_CUSTHDR where CUSTNM='" + CUST_NM + "'";
        string SQL = "exec USP_Check_TyreKM '" + VEH_NO + "'";

        dt = ExecuteDataTable(CommandType.Text, SQL);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            KM = Convert.ToDouble(dt.Rows[0]["KM"].ToString());
        }
        else
        {
            IsRecordFound = false;
        }
    }
    /// <summary>
    /// CHECK FOR VALID VENDOR ID
    /// </summary>
    public void CheckValidVendor()
    {
        DataTable dt = new DataTable();

        //string SQL = "SELECT CUSTCD,CUSTNM FROM webx_CUSTHDR where CUSTNM='" + CUST_NM + "'";
        string SQL = "exec USP_CheckVendor '" + Tyre_Vendor + "'";

        dt = ExecuteDataTable(CommandType.Text, SQL);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            Tyre_Vendor = dt.Rows[0]["Vendor"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }

    /// <summary>
    /// CHECH FOR VALID REMOLD NO
    /// </summary>
    public void CheckValidRemoldNO()
    {
        DataTable dt = new DataTable();

        //string SQL = "SELECT CUSTCD,CUSTNM FROM webx_CUSTHDR where CUSTNM='" + CUST_NM + "'";
        string SQL = "exec USP_GetRemoldNo '" + CLAIM_REMOLD_SALE_ID + "'";

        dt = ExecuteDataTable(CommandType.Text, SQL);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            CLAIM_REMOLD_SALE_ID = dt.Rows[0]["CLAIM_REMOLD_SALE_ID"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }
    /// <summary>
    /// CHECH FOR VALID REMOLD NO
    /// </summary>
    public void CheckValid_BILLNO()
    {
        DataTable dt = new DataTable();

        //string SQL = "SELECT CUSTCD,CUSTNM FROM webx_CUSTHDR where CUSTNM='" + CUST_NM + "'";
        string SQL = "exec USP_GetBILLNo '" + BILL_NO + "'";

        dt = ExecuteDataTable(CommandType.Text, SQL);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            BILL_NO = dt.Rows[0]["BILLNO"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }
    public void GetVehicleDtls()
    {
        DataTable dt = new DataTable();
        string SQL = "select VEHNO ,Tyre_Attached=(case  when Tyre_Attached is null then '0'  else Tyre_Attached end)  from webx_VEHICLE_HDR where VEHNO='" + VEH_NO + "'";
        //string SQL = "SELECT count(TYRE_ID)Tyre_Attached,TYRE_VEHNO  FROM WEBX_FLEET_TYREMST where 1=1 and GRNNO is null and TYRE_VEHNO='" + VEH_NO + "'" + " group by TYRE_VEHNO";

        dt = ExecuteDataTable(CommandType.Text, SQL);
        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            //VEH_NO = dt.Rows[0]["TYRE_VEHNO"].ToString();
            VEH_NO = dt.Rows[0]["VEHNO"].ToString();

            Tyre_Attached = Convert.ToInt32(dt.Rows[0]["Tyre_Attached"].ToString());

        }
        else
        {
            Tyre_Attached = 0;
            IsRecordFound = false;

        }
    }

    /// <summary>
    /// Find no of tyres attached with vehicle
    /// </summary>
    public void GetVehicleWise_AxelTyre()
    {
        DataTable dt = new DataTable();

        string SQL = "exec USP_Check_TyreCount '" + VEH_NO + "'";

        dt = ExecuteDataTable(CommandType.Text, SQL);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;
            VEH_NO = dt.Rows[0]["VEHNO"].ToString();
            Prev_TyreCount = Convert.ToInt32(dt.Rows[0]["TYRE_ID"].ToString());
            AttachedTyre_Count = Convert.ToInt32(dt.Rows[0]["Tyre_Attached"].ToString());
        }
        else
        {
            IsRecordFound = false;
        }
    }
    #endregion
}