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
/// Summary description for cls_Tyre_Remould
/// </summary>
public class People_Contract : DataAccessLayer
{
    #region Private Declaration

    private string _Connection_String;
    private string _Contract_Code, _Vehicle_Type;

    private string _Customer_Code;
    private string _Customer_Name;

    private string _Contract_Type_Id, _Category_Id, _From_Area, _To_Area, _PickDrop_Id, _Duration_Id, _Veh_Category_Id, _Entry_By, _Update_By, _Company_Code, _Branch_Code, _Active_Flag;
    private string _Tot_Hour;
    private string _Tot_Min;
    private double _Outstanding_Charge, _Non_Working_Charge, _Fixed_KM, _Variable_KM, _Fixed_Hour, _Variable_Hour, _Rate, _No_of_Vehicle, _No_of_Days, _Minimum_Head;
    private string _RUTKM;
    private string _RUTCD;
    private string _Deployment_St_Time;
    private string _Deployment_End_Time;
    private string _Contract_From_Dt_S, _Contract_To_Dt_S;
    private string _VehicleNo;
    private string _HrsMin;
    protected bool _Is_Record_Found;

    #endregion

    #region Properties

    public string Contract_Code { get { return _Contract_Code; } set { _Contract_Code = value; } }
    public string Vehicle_Type { get { return _Vehicle_Type; } set { _Vehicle_Type = value; } }
    public string VehicleNo { get { return _VehicleNo; } set { _VehicleNo = value; } }
    public string HrsMin { get { return _HrsMin; } set { _HrsMin = value; } }
    public string Tot_Hour { get { return _Tot_Hour; } set { _Tot_Hour = value; } }
    public string Tot_Min { get { return _Tot_Min; } set { _Tot_Min = value; } }
    
    public string Contract_Type_Id { get { return _Contract_Type_Id; } set { _Contract_Type_Id = value; } }
    public string Category_Id { get { return _Category_Id; } set { _Category_Id = value; } }
    public string From_Area { get { return _From_Area; } set { _From_Area = value; } }
    public string To_Area { get { return _To_Area; } set { _To_Area = value; } }
    public string PickDrop_Id { get { return _PickDrop_Id; } set { _PickDrop_Id = value; } }
    public string Duration_Id { get { return _Duration_Id; } set { _Duration_Id = value; } }
    public string Veh_Category_Id { get { return _Veh_Category_Id; } set { _Veh_Category_Id = value; } }
    public string Entry_By { get { return _Entry_By; } set { _Entry_By = value; } }
    public string Update_By { get { return _Update_By; } set { _Update_By = value; } }
    public string Company_Code { get { return _Company_Code; } set { _Company_Code = value; } }
    public string Branch_Code { get { return _Branch_Code; } set { _Branch_Code = value; } }
    public string Active_Flag { get { return _Active_Flag; } set { _Active_Flag = value; } }

    public double Outstanding_Charge { get { return _Outstanding_Charge; } set { _Outstanding_Charge = value; } }
    public double Non_Working_Charge { get { return _Non_Working_Charge; } set { _Non_Working_Charge = value; } }
    public double Fixed_KM { get { return _Fixed_KM; } set { _Fixed_KM = value; } }
    public double Variable_KM { get { return _Variable_KM; } set { _Variable_KM = value; } }
    public double Fixed_Hour { get { return _Fixed_Hour; } set { _Fixed_Hour = value; } }
    public double Variable_Hour { get { return _Variable_Hour; } set { _Variable_Hour = value; } }
    public double Rate { get { return _Rate; } set { _Rate = value; } }
    public double No_of_Vehicle { get { return _No_of_Vehicle; } set { _No_of_Vehicle = value; } }
    public double No_of_Days { get { return _No_of_Days; } set { _No_of_Days = value; } }
    public double Minimum_Head { get { return _Minimum_Head; } set { _Minimum_Head = value; } }

    public string Customer_Code { get { return _Customer_Code; } set { _Customer_Code = value; } }
    public string Customer_Name { get { return _Customer_Name; } set { _Customer_Name = value; } }

    public string Contract_To_Dt_S { get { return _Contract_To_Dt_S; } set { _Contract_To_Dt_S = value; } }
    public string Contract_From_Dt_S { get { return _Contract_From_Dt_S; } set { _Contract_From_Dt_S = value; } }

    public string RUTCD { get { return _RUTCD; } set { _RUTCD = value; } }
    public string RUTKM { get { return _RUTKM; } set { _RUTKM = value; } }
    public string Deployment_St_Time { get { return _Deployment_St_Time; } set { _Deployment_St_Time = value; } }
    public string Deployment_End_Time { get { return _Deployment_End_Time; } set { _Deployment_End_Time = value; } }


    private string _sHrs;
    private string _sMin;
    public string sHrs { get { return _sHrs; } set { _sHrs = value; } }
    public string sMin { get { return _sMin; } set { _sMin = value; } }

    // For Transit Time Calculation in New Trip


    public bool IsRecordFound { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }

    #endregion

    public People_Contract(string ConnectionString)
        : base(ConnectionString)
    {
        _Connection_String = ConnectionString;
    }
    public void BindDropDown(DropDownList ddl, string strSQL)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        dcm.DataBind(ddl, CommandType.Text, strSQL);
    }
    public void OnChangeRoute(string strRutCd)
    {
        DataTable dt = new DataTable();

        dt = ExecuteDataTable(CommandType.Text, "select  SUM(DIST_KM) as RUTKM,SUM(CONVERT(NUMERIC(18,0),TRTIME_HR)) +  SUM(CONVERT(NUMERIC(18,0),STTIME_HR))  AS Tot_Hour,SUM(CONVERT(NUMERIC(18,0),TRTIME_MIN))+SUM(CONVERT(NUMERIC(18,0),STTIME_MIN))  AS Tot_Min  FROM webx_trip_ruttran GROUP BY RUTCD HAVING RUTCD='" + strRutCd.ToString().Trim() + "'");

        if (dt.Rows.Count > 0)
        {
            Tot_Hour = dt.Rows[0]["Tot_Hour"].ToString();
            Tot_Min = dt.Rows[0]["Tot_Min"].ToString();
            RUTKM = dt.Rows[0]["RUTKM"].ToString();
            IsRecordFound = true;
        }
        else
        {
            IsRecordFound = false;
        }
    }
    public void CheckVehicleNumber()
    {
        DataTable dt = new DataTable();
        //SqlParameter[] prm = new SqlParameter[2];
        //prm[0] = new SqlParameter("@VEHNO", Vehicle_No);

        //dt = ExecuteDataTable(CommandType.Text, "Select Vehno From Webx_Vehicle_Hdr where ActiveFlag='Y' And VehNo = '" + Vehicle_No + "' ");

        if (dt.Rows.Count > 0) { IsRecordFound = true; } else { IsRecordFound = false; }
    }
    public void CheckVehicleType()
    {
        DataTable dt = new DataTable();

        dt = ExecuteDataTable(CommandType.Text, "Select TYPE_NAME from webx_Vehicle_Type where TYPE_NAME = '" + Vehicle_Type + "' ");

        if (dt.Rows.Count > 0) { IsRecordFound = true; } else { IsRecordFound = false; }
    }

    public DataSet GetDataSet(string StrSql)
    {
        DataSet ds = new DataSet();
        DataControlManager dcm = new DataControlManager(_Connection_String);
        ds = ExecuteDataSet(CommandType.Text, StrSql);
        return ds;
    }

    public DataTable GetDataTable(string StrSql)
    {
        DataTable dt = new DataTable();
        DataControlManager dcm = new DataControlManager(_Connection_String);
        dt = ExecuteDataTable(CommandType.Text, StrSql);
        return dt;
    }
    public void CheckCustomerCode()
    {
        DataTable dt = new DataTable();
        dt = ExecuteDataTable(CommandType.Text, "Select * from webx_CUSTHDR where CUST_ACTIVE='Y' and custcd='" + Customer_Code + "'");
        if (dt.Rows.Count > 0) { Customer_Name = dt.Rows[0]["CUSTNM"].ToString(); IsRecordFound = true; } else { IsRecordFound = false; }
    }
    public void CheckCustomerName()
    {
        DataTable dt = new DataTable();
        dt = ExecuteDataTable(CommandType.Text, "Select * from webx_CUSTHDR where CUST_ACTIVE='Y' and CUSTNM='" + Customer_Name + "'");
        if (dt.Rows.Count > 0) { Customer_Code = dt.Rows[0]["CUSTCD"].ToString(); IsRecordFound = true; } else { IsRecordFound = false; }
    }
    public void CalculateHours(string strSDT, string strEDT)
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[2];

        prm[0] = new SqlParameter("@StartDateTime", strSDT);
        prm[1] = new SqlParameter("@EndDateTime", strEDT);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "Usp_Fleet_LogSheet_Count_Hours", prm);
        if (dt.Rows.Count > 0) { sHrs = dt.Rows[0]["Hours"].ToString(); sMin = dt.Rows[0]["Minitues"].ToString(); IsRecordFound = true; } else { IsRecordFound = false; }
    }
    public void CheckContractExist()
    {
        DataTable dt = new DataTable();

        SqlParameter[] prm = new SqlParameter[4];

        prm[0] = new SqlParameter("@Customer_Code", Customer_Code);
        prm[1] = new SqlParameter("@From_Dt_Enter", Contract_From_Dt_S);
        prm[2] = new SqlParameter("@To_Dt_Enter", Contract_To_Dt_S);
        prm[3] = new SqlParameter("@Contract_Type", Contract_Type_Id);

        //dt = ExecuteDataTable(CommandType.Text, "Select top 1 CONVERT(varchar,Contract_To_Dt,103) As [Contract_To_Dt] From [Webx_Fleet_Secondary_Contract_Hdr] Where Customer_Code='" + Customer_Code + "' order by Entry_Dt desc");
        dt = ExecuteDataTable(CommandType.StoredProcedure, "USP_CheckPMContractCode", prm);

        if (dt.Rows.Count > 0) { IsRecordFound = true; } else { IsRecordFound = false; }
    }

    public void OnChangeContract()
    {
        DataTable dt = new DataTable();

        SqlParameter[] prm = new SqlParameter[3];

        prm[0] = new SqlParameter("@Customer_Code", Customer_Code);
        prm[1] = new SqlParameter("@Contract_Type", Contract_Type_Id);
        prm[2] = new SqlParameter("@VehicleNo", VehicleNo);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "Usp_FillContractDetails", prm);

        if (dt.Rows.Count > 0)
        {
            Duration_Id = dt.Rows[0]["Duration_Id"].ToString();
            Category_Id = dt.Rows[0]["Category_Id"].ToString();
            RUTCD = dt.Rows[0]["RUTCD"].ToString();
            RUTKM = dt.Rows[0]["RUTKM"].ToString();
            Tot_Hour = dt.Rows[0]["Tot_Hour"].ToString();
            Tot_Min = dt.Rows[0]["Tot_Min"].ToString();
            IsRecordFound = true; 
        }
        else
        { 
            IsRecordFound = false; 
        }
    }
    
    //public void CheckContractExist()
    //{
    //    DataTable dt = new DataTable();

    //    SqlParameter[] prm = new SqlParameter[3];

    //    prm[0] = new SqlParameter("@Customer_Code", Customer_Code);
    //    prm[1] = new SqlParameter("@From_Dt_Enter", Contract_From_Dt_S);
    //    prm[2] = new SqlParameter("@To_Dt_Enter", Contract_To_Dt_S);

    //    //dt = ExecuteDataTable(CommandType.Text, "Select top 1 CONVERT(varchar,Contract_To_Dt,103) As [Contract_To_Dt] From [Webx_Fleet_Secondary_Contract_Hdr] Where Customer_Code='" + Customer_Code + "' order by Entry_Dt desc");
    //    dt = ExecuteDataTable(CommandType.StoredProcedure, "USP_CheckContractCode", prm);

    //    if (dt.Rows.Count > 0) { IsRecordFound = true; } else { IsRecordFound = false; }
    //}

    public void ExecureQry(string strSql)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        ExecuteNonQuery(CommandType.Text, strSql);
    }

    public void InsertPMContractWithID()
    {
        SqlParameter[] prm = new SqlParameter[28];

        prm[0] = new SqlParameter("@Contract_Code", Contract_Code);
        prm[1] = new SqlParameter("@Customer_Code", Customer_Code);
        prm[2] = new SqlParameter("@Contract_Type_Id", Contract_Type_Id);
        prm[3] = new SqlParameter("@Vehicle_Type", Vehicle_Type);
        prm[4] = new SqlParameter("@Category_Id", Category_Id);
        prm[5] = new SqlParameter("@From_Area", From_Area == null ? "" : From_Area);
        prm[6] = new SqlParameter("@To_Area", To_Area == null ? "" : To_Area);
        prm[7] = new SqlParameter("@PickDrop_Id", PickDrop_Id);
        prm[8] = new SqlParameter("@Duration_Id", Duration_Id);
        prm[9] = new SqlParameter("@Outstanding_Charge", Outstanding_Charge);
        prm[10] = new SqlParameter("@Non_Working_Charge", Non_Working_Charge);
        prm[11] = new SqlParameter("@Veh_Category_Id", Veh_Category_Id);
        prm[12] = new SqlParameter("@Fixed_KM", Fixed_KM);
        prm[13] = new SqlParameter("@Variable_KM", Variable_KM);
        prm[14] = new SqlParameter("@Fixed_Hour", Fixed_Hour);
        prm[15] = new SqlParameter("@Variable_Hour", Variable_Hour);
        prm[16] = new SqlParameter("@Rate", Rate);
        prm[17] = new SqlParameter("@No_of_Vehicle", No_of_Vehicle);
        prm[18] = new SqlParameter("@No_of_Days", No_of_Days);
        prm[19] = new SqlParameter("@Entry_By", SessionUtilities.CurrentEmployeeID.Trim());
        prm[20] = new SqlParameter("@Company_Code", SessionUtilities.DefaultCompanyCode.Trim());
        prm[21] = new SqlParameter("@Branch_Code", SessionUtilities.CurrentBranchCode.Trim());
        prm[22] = new SqlParameter("@Active_Flag", "Y");
        prm[23] = new SqlParameter("@Minimum_Head", Minimum_Head);
        prm[24] = new SqlParameter("@RUTCD", RUTCD);
        prm[25] = new SqlParameter("@RUTKM", RUTKM);
        prm[26] = new SqlParameter("@Deployment_St_Time", Deployment_St_Time);
        prm[27] = new SqlParameter("@Deployment_End_Time", Deployment_End_Time);

        ExecuteNonQuery(CommandType.StoredProcedure, "SP_Insert_Webx_Fleet_Contract_People_WithID", prm);
    }
    public void InsertPMContract()
    {
        SqlParameter[] prm = new SqlParameter[28];

        prm[0] = new SqlParameter("@Contract_Code", SqlDbType.VarChar, 20);
        prm[0].Direction = ParameterDirection.Output;
        prm[1] = new SqlParameter("@Customer_Code", Customer_Code);
        prm[2] = new SqlParameter("@Contract_Type_Id", Contract_Type_Id);
        prm[3] = new SqlParameter("@Vehicle_Type", Vehicle_Type);
        prm[4] = new SqlParameter("@Category_Id", Category_Id);
        prm[5] = new SqlParameter("@From_Area", From_Area == null ? "" : From_Area);
        prm[6] = new SqlParameter("@To_Area", To_Area == null ? "" : To_Area);
        prm[7] = new SqlParameter("@PickDrop_Id", PickDrop_Id);
        prm[8] = new SqlParameter("@Duration_Id", Duration_Id);
        prm[9] = new SqlParameter("@Outstanding_Charge", Outstanding_Charge);
        prm[10] = new SqlParameter("@Non_Working_Charge", Non_Working_Charge);
        prm[11] = new SqlParameter("@Veh_Category_Id", Veh_Category_Id);
        prm[12] = new SqlParameter("@Fixed_KM", Fixed_KM);
        prm[13] = new SqlParameter("@Variable_KM", Variable_KM);
        prm[14] = new SqlParameter("@Fixed_Hour", Fixed_Hour);
        prm[15] = new SqlParameter("@Variable_Hour", Variable_Hour);
        prm[16] = new SqlParameter("@Rate", Rate);
        prm[17] = new SqlParameter("@No_of_Vehicle", No_of_Vehicle);
        prm[18] = new SqlParameter("@No_of_Days", No_of_Days);
        prm[19] = new SqlParameter("@Entry_By", SessionUtilities.CurrentEmployeeID.Trim());
        prm[20] = new SqlParameter("@Company_Code", SessionUtilities.DefaultCompanyCode.Trim());
        prm[21] = new SqlParameter("@Branch_Code", SessionUtilities.CurrentBranchCode.Trim());
        prm[22] = new SqlParameter("@Active_Flag", "Y");
        prm[23] = new SqlParameter("@Minimum_Head", Minimum_Head);
        prm[24] = new SqlParameter("@RUTCD", RUTCD);
        prm[25] = new SqlParameter("@RUTKM", RUTKM);
        prm[26] = new SqlParameter("@Deployment_St_Time", Deployment_St_Time);
        prm[27] = new SqlParameter("@Deployment_End_Time", Deployment_End_Time);

        ExecuteNonQuery(CommandType.StoredProcedure, "SP_INSERT_Webx_Fleet_Contract_People", prm);

        Contract_Code = prm[0].Value.ToString();
    }
    public void UpdatePMContract()
    {
        SqlParameter[] prm = new SqlParameter[24];

        prm[0] = new SqlParameter("@Contract_Code", Contract_Code);
        prm[1] = new SqlParameter("@Customer_Code", Customer_Code);
        prm[2] = new SqlParameter("@Vehicle_Type", Vehicle_Type);
        prm[3] = new SqlParameter("@Category_Id", Category_Id);
        prm[4] = new SqlParameter("@From_Area", From_Area == null ? "" : From_Area);
        prm[5] = new SqlParameter("@To_Area", To_Area == null ? "" : To_Area);
        prm[6] = new SqlParameter("@PickDrop_Id", PickDrop_Id);
        prm[7] = new SqlParameter("@Duration_Id", Duration_Id);
        prm[8] = new SqlParameter("@Outstanding_Charge", Outstanding_Charge);
        prm[9] = new SqlParameter("@Non_Working_Charge", Non_Working_Charge);
        prm[10] = new SqlParameter("@Veh_Category_Id", Veh_Category_Id);
        prm[11] = new SqlParameter("@Fixed_KM", Fixed_KM);
        prm[12] = new SqlParameter("@Variable_KM", Variable_KM);
        prm[13] = new SqlParameter("@Fixed_Hour", Fixed_Hour);
        prm[14] = new SqlParameter("@Variable_Hour", Variable_Hour);
        prm[15] = new SqlParameter("@Rate", Rate);
        prm[16] = new SqlParameter("@No_of_Vehicle", No_of_Vehicle);
        prm[17] = new SqlParameter("@No_of_Days", No_of_Days);
        prm[18] = new SqlParameter("@Update_By", SessionUtilities.CurrentEmployeeID.Trim());
        prm[19] = new SqlParameter("@Minimum_Head", Minimum_Head);
        prm[20] = new SqlParameter("@RUTCD", RUTCD);
        prm[21] = new SqlParameter("@RUTKM", RUTKM);
        prm[22] = new SqlParameter("@Deployment_St_Time", Deployment_St_Time);
        prm[23] = new SqlParameter("@Deployment_End_Time", Deployment_End_Time);

        ExecuteNonQuery(CommandType.StoredProcedure, "SP_Update_Webx_Fleet_Contract_People", prm);
    }
    //public void InsertHourlyBased()
    //{
    //    SqlParameter[] prm = new SqlParameter[5];

    //    prm[0] = new SqlParameter("@HourlyBasedSlot", HourlyBasedSlot);
    //    prm[1] = new SqlParameter("@Extra_Charge_Per_Hour", Extra_Charge_Per_Hour);
    //    prm[2] = new SqlParameter("@Customer_Code", Customer_Code);
    //    prm[3] = new SqlParameter("@Contract_Code", Contract_Code == null ? "" : Contract_Code);
    //    //prm[3].Direction = ParameterDirection.Output;  
    //    prm[4] = new SqlParameter("@Entry_By", Entry_By);

    //    ExecuteNonQuery(CommandType.StoredProcedure, "Usp_Insert_Webx_Fleet_Hourly_Based_Slot", prm);

    //    //Contract_Code = prm[3].Value.ToString(); 
    //}

    //public void UpdateHourlyBased()
    //{
    //    SqlParameter[] prm = new SqlParameter[5];

    //    prm[0] = new SqlParameter("@HourlyBasedSlot", HourlyBasedSlot);
    //    prm[1] = new SqlParameter("@Extra_Charge_Per_Hour", Extra_Charge_Per_Hour);
    //    prm[2] = new SqlParameter("@Contract_Code", Contract_Code);
    //    prm[3] = new SqlParameter("@Update_By", Entry_By);
    //    prm[4] = new SqlParameter("@Id", Hourly_Based_Slot_Id);

    //    ExecuteNonQuery(CommandType.StoredProcedure, "Usp_Update_Webx_Fleet_Hourly_Based_Slot", prm);
    //}

    //public void InsertSecondaryContractDet()
    //{
    //    SqlParameter[] prm = new SqlParameter[12];

    //    prm[0] = new SqlParameter("@Contract_Det_Code", Contract_Det_Code);
    //    prm[1] = new SqlParameter("@Contract_Code", Contract_Code);
    //    prm[2] = new SqlParameter("@Vehicle_No", Vehicle_No);
    //    prm[3] = new SqlParameter("@Vehicle_Type_Code", Vehicle_Type);
    //    prm[4] = new SqlParameter("@Category", Category);
    //    prm[5] = new SqlParameter("@HourlyBasedSlot_Id", Hourly_Based_Slot_Id);
    //    prm[6] = new SqlParameter("@From_KM", From_KM);
    //    prm[7] = new SqlParameter("@To_KM", To_KM);
    //    prm[8] = new SqlParameter("@Fixed_Cost", Fixed_Cost);
    //    prm[9] = new SqlParameter("@Variable_Cost", Variable_Cost);
    //    prm[10] = new SqlParameter("@Fixed_Cost_KM", Fixed_Cost_Based);
    //    prm[11] = new SqlParameter("@Entry_By", Entry_By);

    //    ExecuteNonQuery(CommandType.StoredProcedure, "USP_Insert_Webx_Fleet_Secondary_Contract_Det", prm);
    //}

    //public void UpdateSecondaryContractDet()
    //{
    //    SqlParameter[] prm = new SqlParameter[12];

    //    prm[0] = new SqlParameter("@Contract_Det_Code", Contract_Det_Code);
    //    prm[1] = new SqlParameter("@Contract_Code", Contract_Code);
    //    prm[2] = new SqlParameter("@Vehicle_No", Vehicle_No);
    //    prm[3] = new SqlParameter("@Vehicle_Type_Code", Vehicle_Type);
    //    prm[4] = new SqlParameter("@Category", Category);
    //    prm[5] = new SqlParameter("@HourlyBasedSlot_Id", Hourly_Based_Slot_Id);
    //    prm[6] = new SqlParameter("@From_KM", From_KM);
    //    prm[7] = new SqlParameter("@To_KM", To_KM);
    //    prm[8] = new SqlParameter("@Fixed_Cost", Fixed_Cost);
    //    prm[9] = new SqlParameter("@Variable_Cost", Variable_Cost);
    //    prm[10] = new SqlParameter("@Fixed_Cost_KM", Fixed_Cost_Based);
    //    prm[11] = new SqlParameter("@Entry_By", Entry_By);

    //    ExecuteNonQuery(CommandType.StoredProcedure, "USP_Update_Webx_Fleet_Secondary_Contract_Det", prm);
    //}
    public void BindGridContract(GridView gv)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);

        dcm.DataBind(gv, CommandType.Text, "Select *from vw_GetPMContractData where Customer_Code = '" + Customer_Code + "' And Contract_Type='" + Contract_Code + "'");
    }
}
