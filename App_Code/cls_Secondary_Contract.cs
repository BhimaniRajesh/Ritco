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
public class Secondary_Contract : DataAccessLayer 
{
    #region Private Declaration

    private string _Connection_String;
    private string _Contract_Code;

    private string _Customer_Code, _Loc_Code;
    private string _Customer_Name;

    private DateTime _Contract_From_Dt;
    private DateTime _Contract_To_Dt;
    private string _Contract_From_Dt_S, _Contract_To_Dt_S;

    private string _Contract_Based_On, _Vehicle_Type, _Category, _Fixed_Cost_Based;
    private string _AC, _Non_AC, _Empty;
    private string _Rate_Based_On;
    private int _Hourly_Based_Slot_Id;
    private string _Rate_Type;
    private string _Fixed_Cost_Rate;
    private string _Fixed_Cost_Rate_Based_On;
    private double _Fixed_Cost;
    private double _Fixes_Cost_KM;
    private string _Fixed_Cost_KM_Type;
    private string _Variable_Cost_Rate;
    private string _Variable_Cost_Rate_Based_On;
    private string _Standard_Charge_Applicable;
    private string _Entry_By;
    private double _From_KM, _To_KM, _Variable_Cost, _Fixed_Cost_KM;
    private string _Contract_Det_Code;
    private string _Vehicle_No;
    private string _FTL_Type;
    private double _Fixed_AC;
    private double _Fixed_Non_AC;
    private double _Fixed_Empty;
    private double _Fixed_AC_Time1;
    private double _Fixed_AC_Time2;
    private double _Fixed_AC_Time3;
    private double _Fixed_AC_Time4;
    private double _Fixed_AC_Time5;
    private double _Fixed_AC_Time6;
    private double _Fixed_AC_Time7;
    private double _Fixed_AC_Time8;
    private double _Fixed_AC_Time9;
    private double _Fixed_AC_Time10;
    private double _Fixed_NONAC_Time1;
    private double _Fixed_NONAC_Time2;
    private double _Fixed_NONAC_Time3;
    private double _Fixed_NONAC_Time4;
    private double _Fixed_NONAC_Time5;
    private double _Fixed_NONAC_Time6;
    private double _Fixed_NONAC_Time7;
    private double _Fixed_NONAC_Time8;
    private double _Fixed_NONAC_Time9;
    private double _Fixed_NONAC_Time10;
    private double _Fixed_EMPTY_Time1;
    private double _Fixed_EMPTY_Time2;
    private double _Fixed_EMPTY_Time3;
    private double _Fixed_EMPTY_Time4;
    private double _Fixed_EMPTY_Time5;
    private double _Fixed_EMPTY_Time6;
    private double _Fixed_EMPTY_Time7;
    private double _Fixed_EMPTY_Time8;
    private double _Fixed_EMPTY_Time9;
    private double _Fixed_EMPTY_Time10;
    private double _Variable_AC;
    private double _Variable_Non_AC;
    private double _Variable_Empty;
    private double _Variable_AC_Time1;
    private double _Variable_AC_Time2;
    private double _Variable_AC_Time3;
    private double _Variable_AC_Time4;
    private double _Variable_AC_Time5;
    private double _Variable_AC_Time6;
    private double _Variable_AC_Time7;
    private double _Variable_AC_Time8;
    private double _Variable_AC_Time9;
    private double _Variable_AC_Time10;
    private double _Variable_NONAC_Time1;
    private double _Variable_NONAC_Time2;
    private double _Variable_NONAC_Time3;
    private double _Variable_NONAC_Time4;
    private double _Variable_NONAC_Time5;
    private double _Variable_NONAC_Time6;
    private double _Variable_NONAC_Time7;
    private double _Variable_NONAC_Time8;
    private double _Variable_NONAC_Time9;
    private double _Variable_NONAC_Time10;
    private double _Variable_EMPTY_Time1;
    private double _Variable_EMPTY_Time2;
    private double _Variable_EMPTY_Time3;
    private double _Variable_EMPTY_Time4;
    private double _Variable_EMPTY_Time5;
    private double _Variable_EMPTY_Time6;
    private double _Variable_EMPTY_Time7;
    private double _Variable_EMPTY_Time8;
    private double _Variable_EMPTY_Time9;
    private double _Variable_EMPTY_Time10;



    public double _HourlyBasedSlot, _Extra_Charge_Per_Hour;

    protected bool _Is_Record_Found;

    #endregion

    #region Properties

    public string Contract_Code { get { return _Contract_Code; } set { _Contract_Code = value; } }
    public string Vehicle_Type { get { return _Vehicle_Type; } set { _Vehicle_Type = value; } }

    public string Fixed_Cost_Based { get { return _Fixed_Cost_Based; } set { _Fixed_Cost_Based = value; } }

    
    public double HourlyBasedSlot { get { return _HourlyBasedSlot; } set { _HourlyBasedSlot = value; } }
    public double Extra_Charge_Per_Hour { get { return _Extra_Charge_Per_Hour; } set { _Extra_Charge_Per_Hour = value; } }

    public string Customer_Code { get { return _Customer_Code; } set { _Customer_Code = value; } }
    public string Customer_Name { get { return _Customer_Name; } set { _Customer_Name = value; } }
    
    public DateTime Contract_From_Dt { get { return _Contract_From_Dt; } set { _Contract_From_Dt = value; } }
    public DateTime Contract_To_Dt { get { return _Contract_To_Dt; } set { _Contract_To_Dt = value; } }

    public string Contract_To_Dt_S { get { return _Contract_To_Dt_S; } set { _Contract_To_Dt_S = value; } }
    public string Contract_From_Dt_S { get { return _Contract_From_Dt_S; } set { _Contract_From_Dt_S = value; } }


    public string Contract_Based_On { get { return _Contract_Based_On; } set { _Contract_Based_On = value; } }
    public string AC { get { return _AC; } set { _AC = value; } }
    public string Non_AC { get { return _Non_AC; } set { _Non_AC = value; } }
    public string Empty { get { return _Empty; } set { _Empty = value; } }
    public string Rate_Based_On { get { return _Rate_Based_On; } set { _Rate_Based_On = value; } }
    public int Hourly_Based_Slot_Id { get { return _Hourly_Based_Slot_Id; } set { _Hourly_Based_Slot_Id = value; } }
    public string Rate_Type { get { return _Rate_Type; } set { _Rate_Type = value; } }
    public string Fixed_Cost_Rate { get { return _Fixed_Cost_Rate; } set { _Fixed_Cost_Rate = value; } }
    public string Fixed_Cost_Rate_Based_On { get { return _Fixed_Cost_Rate_Based_On; } set { _Fixed_Cost_Rate_Based_On = value; } }
    public double Fixed_Cost { get { return _Fixed_Cost; } set { _Fixed_Cost = value; } }
    public double Fixes_Cost_KM { get { return _Fixes_Cost_KM; } set { _Fixes_Cost_KM = value; } }
    public string Fixed_Cost_KM_Type { get { return _Fixed_Cost_KM_Type; } set { _Fixed_Cost_KM_Type = value; } }
    public string Variable_Cost_Rate { get { return _Variable_Cost_Rate; } set { _Variable_Cost_Rate = value; } }
    public string Variable_Cost_Rate_Based_On { get { return _Variable_Cost_Rate_Based_On; } set { _Variable_Cost_Rate_Based_On = value; } }
    public string Standard_Charge_Applicable { get { return _Standard_Charge_Applicable; } set { _Standard_Charge_Applicable = value; } }
    public string Entry_By { get { return _Entry_By; } set { _Entry_By = value; } }
    public string Loc_Code { get { return _Loc_Code; } set { _Loc_Code = value; } }

    public string Contract_Det_Code {get {return _Contract_Det_Code; } set { _Contract_Det_Code = value;}}
    public string FTL_Type { get { return _FTL_Type; } set { _FTL_Type = value; } }
    public string Vehicle_No { get { return _Vehicle_No; } set { _Vehicle_No = value; } }


    public string Category { get { return _Category; } set { _Category = value; } }
    public double From_KM { get { return _From_KM; } set { _From_KM = value; } }
    public double To_KM { get { return _To_KM; } set { _To_KM = value; } }
    public double Variable_Cost { get { return _Variable_Cost; } set { _Variable_Cost = value; } }
    public double Fixed_Cost_KM { get { return _Fixed_Cost_KM; } set { _Fixed_Cost_KM = value; } }
    

    public double Fixed_AC  { get { return _Fixed_AC ; } set { _Fixed_AC  = value; } }
    public double Fixed_Non_AC  { get { return _Fixed_Non_AC ; } set { _Fixed_Non_AC  = value; } }
    public double Fixed_Empty  { get { return _Fixed_Empty ; } set { _Fixed_Empty  = value; } }
    public double Fixed_AC_Time1  { get { return _Fixed_AC_Time1 ; } set { _Fixed_AC_Time1  = value; } }
    public double Fixed_AC_Time2  { get { return _Fixed_AC_Time2 ; } set { _Fixed_AC_Time2  = value; } }
    public double Fixed_AC_Time3  { get { return _Fixed_AC_Time3 ; } set { _Fixed_AC_Time3  = value; } }
    public double Fixed_AC_Time4  { get { return _Fixed_AC_Time4 ; } set { _Fixed_AC_Time4  = value; } }
    public double Fixed_AC_Time5  { get { return _Fixed_AC_Time5 ; } set { _Fixed_AC_Time5  = value; } }
    public double Fixed_AC_Time6  { get { return _Fixed_AC_Time6 ; } set { _Fixed_AC_Time6  = value; } }
    public double Fixed_AC_Time7  { get { return _Fixed_AC_Time7 ; } set { _Fixed_AC_Time7  = value; } }
    public double Fixed_AC_Time8  { get { return _Fixed_AC_Time8 ; } set { _Fixed_AC_Time8  = value; } }
    public double Fixed_AC_Time9  { get { return _Fixed_AC_Time9 ; } set { _Fixed_AC_Time9  = value; } }
    public double Fixed_AC_Time10  { get { return _Fixed_AC_Time10 ; } set { _Fixed_AC_Time10  = value; } }
    public double Fixed_NONAC_Time1  { get { return _Fixed_NONAC_Time1 ; } set { _Fixed_NONAC_Time1  = value; } }
    public double Fixed_NONAC_Time2  { get { return _Fixed_NONAC_Time2 ; } set { _Fixed_NONAC_Time2  = value; } }
    public double Fixed_NONAC_Time3  { get { return _Fixed_NONAC_Time3 ; } set { _Fixed_NONAC_Time3  = value; } }
    public double Fixed_NONAC_Time4  { get { return _Fixed_NONAC_Time4 ; } set { _Fixed_NONAC_Time4  = value; } }
    public double Fixed_NONAC_Time5  { get { return _Fixed_NONAC_Time5 ; } set { _Fixed_NONAC_Time5  = value; } }
    public double Fixed_NONAC_Time6  { get { return _Fixed_NONAC_Time6 ; } set { _Fixed_NONAC_Time6  = value; } }
    public double Fixed_NONAC_Time7  { get { return _Fixed_NONAC_Time7 ; } set { _Fixed_NONAC_Time7  = value; } }
    public double Fixed_NONAC_Time8  { get { return _Fixed_NONAC_Time8 ; } set { _Fixed_NONAC_Time8  = value; } }
    public double Fixed_NONAC_Time9  { get { return _Fixed_NONAC_Time9 ; } set { _Fixed_NONAC_Time9  = value; } }
    public double Fixed_NONAC_Time10  { get { return _Fixed_NONAC_Time10 ; } set { _Fixed_NONAC_Time10  = value; } }
    public double Fixed_EMPTY_Time1  { get { return _Fixed_EMPTY_Time1 ; } set { _Fixed_EMPTY_Time1  = value; } }
    public double Fixed_EMPTY_Time2  { get { return _Fixed_EMPTY_Time2 ; } set { _Fixed_EMPTY_Time2  = value; } }
    public double Fixed_EMPTY_Time3  { get { return _Fixed_EMPTY_Time3 ; } set { _Fixed_EMPTY_Time3  = value; } }
    public double Fixed_EMPTY_Time4  { get { return _Fixed_EMPTY_Time4 ; } set { _Fixed_EMPTY_Time4  = value; } }
    public double Fixed_EMPTY_Time5  { get { return _Fixed_EMPTY_Time5 ; } set { _Fixed_EMPTY_Time5  = value; } }
    public double Fixed_EMPTY_Time6  { get { return _Fixed_EMPTY_Time6 ; } set { _Fixed_EMPTY_Time6  = value; } }
    public double Fixed_EMPTY_Time7  { get { return _Fixed_EMPTY_Time7 ; } set { _Fixed_EMPTY_Time7  = value; } }
    public double Fixed_EMPTY_Time8  { get { return _Fixed_EMPTY_Time8 ; } set { _Fixed_EMPTY_Time8  = value; } }
    public double Fixed_EMPTY_Time9  { get { return _Fixed_EMPTY_Time9 ; } set { _Fixed_EMPTY_Time9  = value; } }
    public double Fixed_EMPTY_Time10  { get { return _Fixed_EMPTY_Time10 ; } set { _Fixed_EMPTY_Time10  = value; } }
    public double Variable_AC  { get { return _Variable_AC ; } set { _Variable_AC  = value; } }
    public double Variable_Non_AC  { get { return _Variable_Non_AC ; } set { _Variable_Non_AC  = value; } }
    public double Variable_Empty  { get { return _Variable_Empty ; } set { _Variable_Empty  = value; } }
    public double Variable_AC_Time1  { get { return _Variable_AC_Time1 ; } set { _Variable_AC_Time1  = value; } }
    public double Variable_AC_Time2  { get { return _Variable_AC_Time2 ; } set { _Variable_AC_Time2  = value; } }
    public double Variable_AC_Time3  { get { return _Variable_AC_Time3 ; } set { _Variable_AC_Time3  = value; } }
    public double Variable_AC_Time4  { get { return _Variable_AC_Time4 ; } set { _Variable_AC_Time4  = value; } }
    public double Variable_AC_Time5  { get { return _Variable_AC_Time5 ; } set { _Variable_AC_Time5  = value; } }
    public double Variable_AC_Time6  { get { return _Variable_AC_Time6 ; } set { _Variable_AC_Time6  = value; } }
    public double Variable_AC_Time7  { get { return _Variable_AC_Time7 ; } set { _Variable_AC_Time7  = value; } }
    public double Variable_AC_Time8  { get { return _Variable_AC_Time8 ; } set { _Variable_AC_Time8  = value; } }
    public double Variable_AC_Time9  { get { return _Variable_AC_Time9 ; } set { _Variable_AC_Time9  = value; } }
    public double Variable_AC_Time10  { get { return _Variable_AC_Time10 ; } set { _Variable_AC_Time10  = value; } }
    public double Variable_NONAC_Time1  { get { return _Variable_NONAC_Time1 ; } set { _Variable_NONAC_Time1  = value; } }
    public double Variable_NONAC_Time2  { get { return _Variable_NONAC_Time2 ; } set { _Variable_NONAC_Time2  = value; } }
    public double Variable_NONAC_Time3  { get { return _Variable_NONAC_Time3 ; } set { _Variable_NONAC_Time3  = value; } }
    public double Variable_NONAC_Time4  { get { return _Variable_NONAC_Time4 ; } set { _Variable_NONAC_Time4  = value; } }
    public double Variable_NONAC_Time5  { get { return _Variable_NONAC_Time5 ; } set { _Variable_NONAC_Time5  = value; } }
    public double Variable_NONAC_Time6  { get { return _Variable_NONAC_Time6 ; } set { _Variable_NONAC_Time6  = value; } }
    public double Variable_NONAC_Time7  { get { return _Variable_NONAC_Time7 ; } set { _Variable_NONAC_Time7  = value; } }
    public double Variable_NONAC_Time8  { get { return _Variable_NONAC_Time8 ; } set { _Variable_NONAC_Time8  = value; } }
    public double Variable_NONAC_Time9  { get { return _Variable_NONAC_Time9 ; } set { _Variable_NONAC_Time9  = value; } }
    public double Variable_NONAC_Time10  { get { return _Variable_NONAC_Time10 ; } set { _Variable_NONAC_Time10  = value; } }
    public double Variable_EMPTY_Time1  { get { return _Variable_EMPTY_Time1 ; } set { _Variable_EMPTY_Time1  = value; } }
    public double Variable_EMPTY_Time2  { get { return _Variable_EMPTY_Time2 ; } set { _Variable_EMPTY_Time2  = value; } }
    public double Variable_EMPTY_Time3  { get { return _Variable_EMPTY_Time3 ; } set { _Variable_EMPTY_Time3  = value; } }
    public double Variable_EMPTY_Time4  { get { return _Variable_EMPTY_Time4 ; } set { _Variable_EMPTY_Time4  = value; } }
    public double Variable_EMPTY_Time5  { get { return _Variable_EMPTY_Time5 ; } set { _Variable_EMPTY_Time5  = value; } }
    public double Variable_EMPTY_Time6  { get { return _Variable_EMPTY_Time6 ; } set { _Variable_EMPTY_Time6  = value; } }
    public double Variable_EMPTY_Time7  { get { return _Variable_EMPTY_Time7 ; } set { _Variable_EMPTY_Time7  = value; } }
    public double Variable_EMPTY_Time8  { get { return _Variable_EMPTY_Time8 ; } set { _Variable_EMPTY_Time8  = value; } }
    public double Variable_EMPTY_Time9  { get { return _Variable_EMPTY_Time9 ; } set { _Variable_EMPTY_Time9  = value; } }
    public double Variable_EMPTY_Time10  { get { return _Variable_EMPTY_Time10 ; } set { _Variable_EMPTY_Time10  = value; } }


    public bool IsRecordFound { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }

    #endregion

    public Secondary_Contract(string ConnectionString)
        : base(ConnectionString)
    { 
        _Connection_String = ConnectionString; 
    }
    public void BindDropDown(DropDownList ddl, string strSQL)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        dcm.DataBind(ddl, CommandType.Text, strSQL);
    }
    public void CheckVehicleNumber()
    {
        DataTable dt = new DataTable();
        //SqlParameter[] prm = new SqlParameter[2];
        //prm[0] = new SqlParameter("@VEHNO", Vehicle_No);

        dt = ExecuteDataTable(CommandType.Text, "Select Vehno From Webx_Vehicle_Hdr where ActiveFlag='Y' And VehNo = '" + Vehicle_No + "' ");

        if (dt.Rows.Count > 0) { IsRecordFound = true; } else { IsRecordFound = false; }
    }
    public void CheckLocation()
    {
        DataTable dt = new DataTable();

        dt = ExecuteDataTable(CommandType.Text, "Select LocName From webx_location where LocName='" + Loc_Code + "' ");

        if (dt.Rows.Count > 0) { IsRecordFound = true; } else { IsRecordFound = false; }
    }

    
    public void CheckVehicleType()
    {
        DataTable dt = new DataTable();

        dt = ExecuteDataTable(CommandType.Text, "SELECT CodeDesc FROM Webx_Master_General WHERE CodeType='FTLTYP' and StatusCode='Y'  and CodeDesc = '" + Vehicle_Type + "' ");

        if (dt.Rows.Count > 0) { IsRecordFound = true; } else { IsRecordFound = false; }
    }
    public void CheckFTLType()
    {
        DataTable dt = new DataTable();

        dt = ExecuteDataTable(CommandType.Text, "SELECT CodeDesc FROM Webx_Master_General WHERE CodeType='FTLTYP' and StatusCode='Y'  and CodeDesc = '" + Vehicle_Type + "' ");

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
    public void CheckContractExist()
    {
        DataTable dt = new DataTable();

        SqlParameter[] prm = new SqlParameter[3];

        prm[0] = new SqlParameter("@Customer_Code", Customer_Code);
        prm[1] = new SqlParameter("@From_Dt_Enter", Contract_From_Dt_S);
        prm[2] = new SqlParameter("@To_Dt_Enter", Contract_To_Dt_S);
        
        //dt = ExecuteDataTable(CommandType.Text, "Select top 1 CONVERT(varchar,Contract_To_Dt,103) As [Contract_To_Dt] From [Webx_Fleet_Secondary_Contract_Hdr] Where Customer_Code='" + Customer_Code + "' order by Entry_Dt desc");
        dt = ExecuteDataTable(CommandType.StoredProcedure, "USP_CheckContractCode", prm);

        if (dt.Rows.Count > 0) { IsRecordFound = true; } else { IsRecordFound = false; }
    }

    public void ExecureQry(string strSql)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        ExecuteNonQuery(CommandType.Text, strSql);
    }
    
    public void InsertSecondaryContractHdr()
    {
        SqlParameter[] prm = new SqlParameter[16];

        prm[0] = new SqlParameter("@Contract_Code", SqlDbType.VarChar, 20);
        prm[0].Direction = ParameterDirection.Output;  
        prm[1] = new SqlParameter("@Customer_Code", Customer_Code);
        prm[2] = new SqlParameter("@Contract_From_Dt", Contract_From_Dt);
        prm[3] = new SqlParameter("@Contract_To_Dt", Contract_To_Dt);
        prm[4] = new SqlParameter("@Contract_Based_On", Contract_Based_On);
        prm[5] = new SqlParameter("@AC", AC);
        prm[6] = new SqlParameter("@Non_AC", Non_AC);
        prm[7] = new SqlParameter("@Empty", Empty);
        prm[8] = new SqlParameter("@Rate_Based_On", Rate_Based_On);
        prm[9] = new SqlParameter("@Rate_Type", Rate_Type);
        prm[10] = new SqlParameter("@Fixed_Cost_Rate", Fixed_Cost_Rate);
        prm[11] = new SqlParameter("@Fixed_Cost_Rate_Based_On", Fixed_Cost_Rate_Based_On);
        prm[12] = new SqlParameter("@Variable_Cost_Rate", Variable_Cost_Rate);
        prm[13] = new SqlParameter("@Variable_Cost_Rate_Based_On", Variable_Cost_Rate_Based_On);
        prm[14] = new SqlParameter("@Standard_Charge_Applicable", Standard_Charge_Applicable);
        prm[15] = new SqlParameter("@Entry_By", Entry_By);

        ExecuteNonQuery(CommandType.StoredProcedure, "Usp_Insert_Webx_Fleet_Secondary_Contract_Hdr", prm);

        Contract_Code = prm[0].Value.ToString();
    }
    public void UpdateSecondaryContractHdr()
    {
        SqlParameter[] prm = new SqlParameter[16];

        prm[0] = new SqlParameter("@Contract_Code", Contract_Code);
        prm[1] = new SqlParameter("@Customer_Code", Customer_Code);
        prm[2] = new SqlParameter("@Contract_From_Dt", Contract_From_Dt);
        prm[3] = new SqlParameter("@Contract_To_Dt", Contract_To_Dt);
        prm[4] = new SqlParameter("@Contract_Based_On", Contract_Based_On);
        prm[5] = new SqlParameter("@AC", AC);
        prm[6] = new SqlParameter("@Non_AC", Non_AC);
        prm[7] = new SqlParameter("@Empty", Empty);
        prm[8] = new SqlParameter("@Rate_Based_On", Rate_Based_On);
        prm[9] = new SqlParameter("@Rate_Type", Rate_Type);
        prm[10] = new SqlParameter("@Fixed_Cost_Rate", Fixed_Cost_Rate);
        prm[11] = new SqlParameter("@Fixed_Cost_Rate_Based_On", Fixed_Cost_Rate_Based_On);
        prm[12] = new SqlParameter("@Variable_Cost_Rate", Variable_Cost_Rate);
        prm[13] = new SqlParameter("@Variable_Cost_Rate_Based_On", Variable_Cost_Rate_Based_On);
        prm[14] = new SqlParameter("@Standard_Charge_Applicable", Standard_Charge_Applicable);
        prm[15] = new SqlParameter("@Update_By", Entry_By);

        ExecuteNonQuery(CommandType.StoredProcedure, "Usp_Update_Webx_Fleet_Secondary_Contract_Hdr", prm);
    }
    public void InsertHourlyBased()
    {
        SqlParameter[] prm = new SqlParameter[5];
        
        prm[0] = new SqlParameter("@HourlyBasedSlot", HourlyBasedSlot);
        prm[1] = new SqlParameter("@Extra_Charge_Per_Hour", Extra_Charge_Per_Hour);
        prm[2] = new SqlParameter("@Customer_Code", Customer_Code);
        prm[3] = new SqlParameter("@Contract_Code", Contract_Code == null ? "" : Contract_Code);
        //prm[3].Direction = ParameterDirection.Output;  
        prm[4] = new SqlParameter("@Entry_By", Entry_By);

        ExecuteNonQuery(CommandType.StoredProcedure, "Usp_Insert_Webx_Fleet_Hourly_Based_Slot", prm);

        //Contract_Code = prm[3].Value.ToString(); 
    }

    public void UpdateHourlyBased()
    {
        SqlParameter[] prm = new SqlParameter[5];

        prm[0] = new SqlParameter("@HourlyBasedSlot", HourlyBasedSlot);
        prm[1] = new SqlParameter("@Extra_Charge_Per_Hour", Extra_Charge_Per_Hour);
        prm[2] = new SqlParameter("@Contract_Code", Contract_Code);
        prm[3] = new SqlParameter("@Update_By", Entry_By);
        prm[4] = new SqlParameter("@Id", Hourly_Based_Slot_Id);

        ExecuteNonQuery(CommandType.StoredProcedure, "Usp_Update_Webx_Fleet_Hourly_Based_Slot", prm);
    }

    public void InsertSecondaryContractDet()
    {
        SqlParameter[] prm = new SqlParameter[13];

        prm[0] = new SqlParameter("@Contract_Det_Code", Contract_Det_Code);
        prm[1] = new SqlParameter("@Contract_Code", Contract_Code);
        prm[2] = new SqlParameter("@Vehicle_No", Vehicle_No);
        prm[3] = new SqlParameter("@Vehicle_Type_Code", Vehicle_Type);
        prm[4] = new SqlParameter("@Category", Category);
        prm[5] = new SqlParameter("@HourlyBasedSlot_Id", Hourly_Based_Slot_Id);
        prm[6] = new SqlParameter("@From_KM", From_KM);
        prm[7] = new SqlParameter("@To_KM", To_KM);
        prm[8] = new SqlParameter("@Fixed_Cost", Fixed_Cost);
        prm[9] = new SqlParameter("@Variable_Cost", Variable_Cost);
        prm[10] = new SqlParameter("@Fixed_Cost_KM", Fixed_Cost_Based);
        prm[11] = new SqlParameter("@Entry_By", Entry_By);
        prm[12] = new SqlParameter("@Loc_Code", Loc_Code);

        ExecuteNonQuery(CommandType.StoredProcedure, "USP_Insert_Webx_Fleet_Secondary_Contract_Det", prm);
    }

    public void UpdateSecondaryContractDet()
    {
        SqlParameter[] prm = new SqlParameter[13];

        prm[0] = new SqlParameter("@Contract_Det_Code", Contract_Det_Code);
        prm[1] = new SqlParameter("@Contract_Code", Contract_Code);
        prm[2] = new SqlParameter("@Vehicle_No", Vehicle_No);
        prm[3] = new SqlParameter("@Vehicle_Type_Code", Vehicle_Type);
        prm[4] = new SqlParameter("@Category", Category);
        prm[5] = new SqlParameter("@HourlyBasedSlot_Id", Hourly_Based_Slot_Id);
        prm[6] = new SqlParameter("@From_KM", From_KM);
        prm[7] = new SqlParameter("@To_KM", To_KM);
        prm[8] = new SqlParameter("@Fixed_Cost", Fixed_Cost);
        prm[9] = new SqlParameter("@Variable_Cost", Variable_Cost);
        prm[10] = new SqlParameter("@Fixed_Cost_KM", Fixed_Cost_Based);
        prm[11] = new SqlParameter("@Entry_By", Entry_By);
        prm[12] = new SqlParameter("@Loc_Code", Loc_Code);

        ExecuteNonQuery(CommandType.StoredProcedure, "USP_Update_Webx_Fleet_Secondary_Contract_Det", prm);
    }

    public void InsertSecondaryContract()
    {
        SqlParameter[] prm = new SqlParameter[71];

        prm[0] = new SqlParameter("@Contract_Det_Code", Contract_Det_Code);
        prm[1] = new SqlParameter("@Contract_Code", Contract_Code);
        prm[2] = new SqlParameter("@Vehicle_No", Vehicle_No);
        prm[3] = new SqlParameter("@FTL_Type",FTL_Type);
        
        prm[4] = new SqlParameter("@Fixed_AC", Fixed_AC);
        prm[5] = new SqlParameter("@Fixed_Non_AC", Fixed_Non_AC);
        prm[6] = new SqlParameter("@Fixed_Empty", Fixed_Empty);
        
        prm[7] = new SqlParameter("@Fixed_AC_Time1", Fixed_AC_Time1);
        prm[8] = new SqlParameter("@Fixed_AC_Time2", Fixed_AC_Time2);
        prm[9] = new SqlParameter("@Fixed_AC_Time3", Fixed_AC_Time3);
        prm[10] = new SqlParameter("@Fixed_AC_Time4", Fixed_AC_Time4);
        prm[11] = new SqlParameter("@Fixed_AC_Time5", Fixed_AC_Time5);
        prm[12] = new SqlParameter("@Fixed_AC_Time6", Fixed_AC_Time6);
        prm[13] = new SqlParameter("@Fixed_AC_Time7", Fixed_AC_Time7);
        prm[14] = new SqlParameter("@Fixed_AC_Time8", Fixed_AC_Time8);
        prm[15] = new SqlParameter("@Fixed_AC_Time9", Fixed_AC_Time9);
        prm[16] = new SqlParameter("@Fixed_AC_Time10", Fixed_AC_Time10);
        
        prm[17] = new SqlParameter("@Fixed_NONAC_Time1", Fixed_NONAC_Time1);
        prm[18] = new SqlParameter("@Fixed_NONAC_Time2", Fixed_NONAC_Time2);
        prm[19] = new SqlParameter("@Fixed_NONAC_Time3", Fixed_NONAC_Time3);
        prm[20] = new SqlParameter("@Fixed_NONAC_Time4", Fixed_NONAC_Time4);
        prm[21] = new SqlParameter("@Fixed_NONAC_Time5", Fixed_NONAC_Time5);
        prm[22] = new SqlParameter("@Fixed_NONAC_Time6", Fixed_NONAC_Time6);
        prm[23] = new SqlParameter("@Fixed_NONAC_Time7", Fixed_NONAC_Time7);
        prm[24] = new SqlParameter("@Fixed_NONAC_Time8", Fixed_NONAC_Time8);
        prm[25] = new SqlParameter("@Fixed_NONAC_Time9", Fixed_NONAC_Time9);
        prm[26] = new SqlParameter("@Fixed_NONAC_Time10", Fixed_NONAC_Time10);
        
        prm[27] = new SqlParameter("@Fixed_EMPTY_Time1", Fixed_EMPTY_Time1);
        prm[28] = new SqlParameter("@Fixed_EMPTY_Time2", Fixed_EMPTY_Time2);
        prm[29] = new SqlParameter("@Fixed_EMPTY_Time3", Fixed_EMPTY_Time3);
        prm[30] = new SqlParameter("@Fixed_EMPTY_Time4", Fixed_EMPTY_Time4);
        prm[31] = new SqlParameter("@Fixed_EMPTY_Time5", Fixed_EMPTY_Time5);
        prm[32] = new SqlParameter("@Fixed_EMPTY_Time6", Fixed_EMPTY_Time6);
        prm[33] = new SqlParameter("@Fixed_EMPTY_Time7", Fixed_EMPTY_Time7);
        prm[34] = new SqlParameter("@Fixed_EMPTY_Time8", Fixed_EMPTY_Time8);
        prm[35] = new SqlParameter("@Fixed_EMPTY_Time9", Fixed_EMPTY_Time9);
        prm[36] = new SqlParameter("@Fixed_EMPTY_Time10", Fixed_EMPTY_Time10);
        
        prm[37] = new SqlParameter("@Variable_AC", Variable_AC);
        prm[38] = new SqlParameter("@Variable_Non_AC", Variable_Non_AC);
        prm[39] = new SqlParameter("@Variable_Empty", Variable_Empty);
        
        prm[40] = new SqlParameter("@Variable_AC_Time1", Variable_AC_Time1);
        prm[41] = new SqlParameter("@Variable_AC_Time2", Variable_AC_Time2);
        prm[42] = new SqlParameter("@Variable_AC_Time3", Variable_AC_Time3);
        prm[43] = new SqlParameter("@Variable_AC_Time4", Variable_AC_Time4);
        prm[44] = new SqlParameter("@Variable_AC_Time5", Variable_AC_Time5);
        prm[45] = new SqlParameter("@Variable_AC_Time6", Variable_AC_Time6);
        prm[46] = new SqlParameter("@Variable_AC_Time7", Variable_AC_Time7);
        prm[47] = new SqlParameter("@Variable_AC_Time8", Variable_AC_Time8);
        prm[48] = new SqlParameter("@Variable_AC_Time9", Variable_AC_Time9);
        prm[49] = new SqlParameter("@Variable_AC_Time10", Variable_AC_Time10);
        
        prm[50] = new SqlParameter("@Variable_NONAC_Time1", Variable_NONAC_Time1);
        prm[51] = new SqlParameter("@Variable_NONAC_Time2", Variable_NONAC_Time2);
        prm[52] = new SqlParameter("@Variable_NONAC_Time3", Variable_NONAC_Time3);
        prm[53] = new SqlParameter("@Variable_NONAC_Time4", Variable_NONAC_Time4);
        prm[54] = new SqlParameter("@Variable_NONAC_Time5", Variable_NONAC_Time5);
        prm[55] = new SqlParameter("@Variable_NONAC_Time6", Variable_NONAC_Time6);
        prm[56] = new SqlParameter("@Variable_NONAC_Time7", Variable_NONAC_Time7);
        prm[57] = new SqlParameter("@Variable_NONAC_Time8", Variable_NONAC_Time8);
        prm[58] = new SqlParameter("@Variable_NONAC_Time9", Variable_NONAC_Time9);
        prm[59] = new SqlParameter("@Variable_NONAC_Time10", Variable_NONAC_Time10);
        
        prm[60] = new SqlParameter("@Variable_EMPTY_Time1", Variable_EMPTY_Time1);
        prm[61] = new SqlParameter("@Variable_EMPTY_Time2", Variable_EMPTY_Time2);
        prm[62] = new SqlParameter("@Variable_EMPTY_Time3", Variable_EMPTY_Time3);
        prm[63] = new SqlParameter("@Variable_EMPTY_Time4", Variable_EMPTY_Time4);
        prm[64] = new SqlParameter("@Variable_EMPTY_Time5", Variable_EMPTY_Time5);
        prm[65] = new SqlParameter("@Variable_EMPTY_Time6", Variable_EMPTY_Time6);
        prm[66] = new SqlParameter("@Variable_EMPTY_Time7", Variable_EMPTY_Time7);
        prm[67] = new SqlParameter("@Variable_EMPTY_Time8", Variable_EMPTY_Time8);
        prm[68] = new SqlParameter("@Variable_EMPTY_Time9", Variable_EMPTY_Time9);
        prm[69] = new SqlParameter("@Variable_EMPTY_Time10", Variable_EMPTY_Time10);
        
        prm[70] = new SqlParameter("@Entry_By", Entry_By);

        ExecuteNonQuery(CommandType.StoredProcedure, "Usp_Insert_Webx_Fleet_Secondary_Contract", prm);

    }
    public void BindGridContract(GridView gv)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        //SqlParameter[] prm = new SqlParameter[8];

        //prm[0] = new SqlParameter("@RemouldId", (RemouldId == null) ? "" : RemouldId);
        //prm[1] = new SqlParameter("@TyreId", TyreId);
        //prm[2] = new SqlParameter("@CaptureKM", (CaptureKM == null) ? "" : CaptureKM);
        //prm[3] = new SqlParameter("@Cost", (Cost == null) ? "" : Cost);
        //prm[4] = new SqlParameter("@TotalCost", (TotalCost == null) ? "" : TotalCost);
        //prm[5] = new SqlParameter("@RemouldTyreLife", (RemouldTyreLife == null) ? "" : RemouldTyreLife);
        //prm[6] = new SqlParameter("@RemouldVendor", (RemouldVendor == null) ? "" : RemouldVendor);
        //prm[7] = new SqlParameter("@RemouldDate", RemouldDate);

        dcm.DataBind(gv, CommandType.Text, "Select CONVERT(varchar,Contract_From_Dt,106) as Contract_From_Dt,CONVERT(varchar,Contract_To_Dt,106) as Contract_To_Dt,(case when Contract_Based_On='FTL' then 'FTL Type wise' else 'Vehicle wise' end) as Contract_Based_On,ISNULL(Active_Flag,'N') AS Active_Flag,(CASE WHEN Active_Flag = 'Y' THEN 'Active' ELSE 'InActive' END) as [Status],*from [Webx_Fleet_Secondary_Contract_Hdr] where Customer_Code = '" + Customer_Code + "'");
    }
}
