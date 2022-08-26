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
/// Summary description for General
/// </summary>
public class General : DataAccessLayer
{
    private string _Connection_String;
    private string _TyreNo;
    private string _TyreSize;
    private string _TyrePattern;
    private string _TyrePosition;
    private string _Manufacturer;
    private string _TyreStatus;
    private string _VehNo;
    private string _VEH_INTERNAL_NO;
    private string _TyreOE;
    private string _LOCNAME;
    private string _VEHCATE;
    private string _POS_CATEGORY;
    private string _POS_ALLOWED;
    private string _TyreId;
    private string _TruckTrailer;
    //for dropdown bind
    private string _PosCode;
    private string _PosId;
    private string _CURRENT_KM_READ;
    private string _MANUAL_MOUNT_KM_RUN;
    private string _MANUAL_DISMOUNT_KM_RUN;

    private string _End_Dt_Tm;
    private string _Drive_Settle_Dt;
    private string _VslipNo;
    private string _Manual_TripSheetNo;

    private string _MFG_NAME;
    private string _MODEL_NO;
    private string _TYRE_COST;
    private string _TYRE_PUR_KMS;
    private string _TYRE_TREAD_DEPTH;
    private string _VEHICLE_STATUS;
    private string _VSLIPDT;
    private string _Oper_Close_Dt;
    private string _Cancel_Status;

    protected bool _Is_Record_Found;
    //for tyre scrap 
    public string MFG_NAME { get { return _MFG_NAME; } set { _MFG_NAME = value; } }
    public string MODEL_NO { get { return _MODEL_NO; } set { _MODEL_NO = value; } }
    public string TYRE_COST { get { return _TYRE_COST; } set { _TYRE_COST = value; } }
    public string TYRE_PUR_KMS { get { return _TYRE_PUR_KMS; } set { _TYRE_PUR_KMS = value; } }
    public string TYRE_TREAD_DEPTH { get { return _TYRE_TREAD_DEPTH; } set { _TYRE_TREAD_DEPTH = value; } }
    public string VEHICLE_STATUS { get { return _VEHICLE_STATUS; } set { _VEHICLE_STATUS = value; } }
    //for Fuel Bill Entry Vehicle wise or Trisheet wise
    public string End_Dt_Tm { get { return _End_Dt_Tm; } set { _End_Dt_Tm = value; } }
    public string Drive_Settle_Dt { get { return _Drive_Settle_Dt; } set { _Drive_Settle_Dt = value; } }
    public string CURRENT_KM_READ { get { return _CURRENT_KM_READ; } set { _CURRENT_KM_READ = value; } }

    public string VslipNo { get { return _VslipNo; } set { _VslipNo = value; } }
    public string Manual_TripSheetNo { get { return _Manual_TripSheetNo; } set { _Manual_TripSheetNo = value; } }

    public string TyreSize { get { return _TyreSize; } set { _TyreSize = value; } }
    public string TyrePattern { get { return _TyrePattern; } set { _TyrePattern = value; } }
    public string TyrePosition { get { return _TyrePosition; } set { _TyrePosition = value; } }
    public string Manufacturer { get { return _Manufacturer; } set { _Manufacturer = value; } }
    public string TyreNo { get { return _TyreNo; } set { _TyreNo = value; } }
    public string TyreStatus { get { return _TyreStatus; } set { _TyreStatus = value; } }
    public string VehNo { get { return _VehNo; } set { _VehNo = value; } }
    public string VEH_INTERNAL_NO { get { return _VEH_INTERNAL_NO; } set { _VEH_INTERNAL_NO = value; } }
    public string TyreOE { get { return _TyreOE; } set { _TyreOE = value; } }
    public string LOCNAME { get { return _LOCNAME; } set { _LOCNAME = value; } }
    public string TyreId { get { return _TyreId; } set { _TyreId = value; } }
    public string VEHCATE { get { return _VEHCATE; } set { _VEHCATE = value; } }
    public string POS_CATEGORY { get { return _POS_CATEGORY; } set { _POS_CATEGORY = value; } }
    public string POS_ALLOWED { get { return _POS_ALLOWED; } set { _POS_ALLOWED = value; } }
    public bool Is_Record_Found { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }
    public string TruckTrailer { get { return _TruckTrailer; } set { _TruckTrailer = value; } }
    //for dropdown bind
    public string PosCode { get { return _PosCode; } set { _PosCode = value; } }
    public string PosId { get { return _PosId; } set { _PosId = value; } }

    public string MANUAL_MOUNT_KM_RUN { get { return _MANUAL_MOUNT_KM_RUN; } set { _MANUAL_MOUNT_KM_RUN = value; } }
    public string MANUAL_DISMOUNT_KM_RUN { get { return _MANUAL_DISMOUNT_KM_RUN; } set { _MANUAL_DISMOUNT_KM_RUN = value; } }
    public string VSLIPDT { get { return _VSLIPDT; } set { _VSLIPDT = value; } }

    public string Oper_Close_Dt { get { return _Oper_Close_Dt; } set { _Oper_Close_Dt = value; } }
    public string Cancel_Status { get { return _Cancel_Status; } set { _Cancel_Status = value; } }





    public General(string Connection_String)
        : base(Connection_String)
    {
        //
        // TODO: Add constructor logic here 
        //
        _Connection_String = Connection_String;
    }

    public void GetTripDate(string strTripNo)
    {
        SqlConnection conn = new SqlConnection(_Connection_String);
        SqlDataAdapter adp = new SqlDataAdapter("select Convert(VarChar,Vslipdt,103) as Vslipdt,Convert(VarChar,Oper_Close_Dt,103) as Oper_Close_Dt from Webx_Fleet_Vehicle_Issue where VslipNo='" + strTripNo + "'", conn);
        DataSet ds = new DataSet();
        adp.Fill(ds);
        if (ds.Tables[0].Rows.Count != 0)
        {
            VSLIPDT = ds.Tables[0].Rows[0]["Vslipdt"].ToString();
            Oper_Close_Dt = ds.Tables[0].Rows[0]["Oper_Close_Dt"].ToString();
            Is_Record_Found = true;

        }
        else
        {
            Is_Record_Found = false;
        }
    }

    public void CheckVehNumber()
    {
        SqlConnection conn = new SqlConnection(_Connection_String);
        SqlDataAdapter adp = new SqlDataAdapter("select current_KM_Read From webx_vehicle_hdr Where Vehno = '" + VehNo + "' and ActiveFlag='Y'", conn);
        //SqlDataAdapter adp = new SqlDataAdapter("Select top 1 VehicleNo,current_KM_Read,end_dt_tm,DriverSettleDt,Manual_TripSheetNo,VslipNo From WEBX_FLEET_VEHICLE_ISSUE I,webx_vehicle_hdr v where V.vehno=I.VehicleNo and v.vehno = '" + VehNo.Trim() + "' and I.End_Dt_tm is null order by vslipdt desc", conn);

        DataSet ds = new DataSet();
        adp.Fill(ds);
        if (ds.Tables[0].Rows.Count != 0)
        {
            CURRENT_KM_READ = ds.Tables[0].Rows[0]["current_KM_Read"].ToString();
            //VslipNo = ds.Tables[0].Rows[0]["VslipNo"].ToString();
            //Manual_TripSheetNo = ds.Tables[0].Rows[0]["Manual_TripSheetNo"].ToString();

            Is_Record_Found = true;
        }
        else
        {
            Is_Record_Found = false;
        }
    }

    public void CheckTSNumber(string strManulaTSNo)
    {
        SqlConnection conn = new SqlConnection(_Connection_String);
        SqlDataAdapter adp = new SqlDataAdapter("Select VehicleNo,current_KM_Read,convert(varchar,end_dt_tm,103) as end_dt_tm,convert(varchar,DriverSettleDt,103) as DriverSettleDt From WEBX_FLEET_VEHICLE_ISSUE I,webx_vehicle_hdr v where V.vehno=I.VehicleNo and (Manual_TripSheetNo='" + strManulaTSNo + "' or Vslipno='" + strManulaTSNo + "')", conn);
   
        DataSet ds = new DataSet();
        adp.Fill(ds);
        if (ds.Tables[0].Rows.Count != 0)
        {
            VehNo = ds.Tables[0].Rows[0]["VehicleNo"].ToString();
            CURRENT_KM_READ = ds.Tables[0].Rows[0]["current_KM_Read"].ToString();
            End_Dt_Tm = ds.Tables[0].Rows[0]["end_dt_tm"].ToString();
            Drive_Settle_Dt = ds.Tables[0].Rows[0]["DriverSettleDt"].ToString();

            Is_Record_Found = true;
        }
        else
        {
            Is_Record_Found = false;
        }
    }

    public void CheckBillNumber(string VENDORCODE, string billno)
    {
        SqlConnection conn = new SqlConnection(_Connection_String);
        SqlDataAdapter adp = new SqlDataAdapter("select VENDORBILLNO from WEBX_VENDORBILL_HDR where VENDORCODE='" + VENDORCODE + "'", conn);
        DataSet ds = new DataSet();
        adp.Fill(ds);
        if (ds.Tables[0].Rows.Count != 0)
        {
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                if (billno == ds.Tables[0].Rows[i]["VENDORBILLNO"].ToString())
                {
                    Is_Record_Found = true;
                    break;
                }
                else
                {
                    Is_Record_Found = false;
                }
            }
        }
    }
    public void FillTyreDetailsForTyreScrap()
    {
        DataTable dt = new DataTable();

        dt = ExecuteDataTable(CommandType.Text, "select * from vw_TyreDet_forScrap where TYRE_NO='" + TyreNo.ToString().Trim() + "'");

        if (dt.Rows.Count > 0)
        {
            Is_Record_Found = true;

            TyreId = Convert.ToString(dt.Rows[0]["TYRE_ID"]);
            MFG_NAME = Convert.ToString(dt.Rows[0]["MFG_NAME"]);
            MODEL_NO = Convert.ToString(dt.Rows[0]["MODEL_NO"]);
            TYRE_COST = Convert.ToString(dt.Rows[0]["TYRE_COST"]);
            TYRE_PUR_KMS = Convert.ToString(dt.Rows[0]["MFG_NAME"]);
            MFG_NAME = Convert.ToString(dt.Rows[0]["MFG_NAME"]);
            CURRENT_KM_READ = Convert.ToString(dt.Rows[0]["CURRENT_KM_READ"]);
            TYRE_TREAD_DEPTH = Convert.ToString(dt.Rows[0]["TYRE_TREAD_DEPTH"]);
            VEHICLE_STATUS = Convert.ToString(dt.Rows[0]["VEHICLE_STATUS"]);
            VehNo = Convert.ToString(dt.Rows[0]["TYRE_VEHNO"]);
            TyreStatus = Convert.ToString(dt.Rows[0]["TYRE_STATUS"]);
        }
        else { Is_Record_Found = false; }
    }

    public void CheckManualVehicleOdometerReading()
    {
        DataTable dt = new DataTable();

        dt = ExecuteDataTable(CommandType.Text, "SELECT MANUAL_MOUNT_KM_RUN,MANUAL_DISMOUNT_KM_RUN FROM WEBX_FLEET_TYREMST WHERE TYRE_ID = '" + TyreId.ToString().Trim() + "'");

        if (dt.Rows.Count > 0)
        {
            Is_Record_Found = true;

            MANUAL_MOUNT_KM_RUN = Convert.ToString(dt.Rows[0]["MANUAL_MOUNT_KM_RUN"]);
            MANUAL_DISMOUNT_KM_RUN = Convert.ToString(dt.Rows[0]["MANUAL_DISMOUNT_KM_RUN"]);
        }
        else { Is_Record_Found = false; }
    }
    public void GetTyreDetails()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@Tyre_No", TyreNo);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Get_Tyre_Details", prm);

        if (dt.Rows.Count > 0)
        {
            Is_Record_Found = true;

            TyreSize = dt.Rows[0]["TYRE_SIZENAME"].ToString();
            TyrePattern = dt.Rows[0]["TYRE_PATTERN_DESC"].ToString();
            TyrePosition = dt.Rows[0]["TYREPOS_CODE"].ToString();
            Manufacturer = dt.Rows[0]["MFG_NAME"].ToString();
            TyreStatus = dt.Rows[0]["TYRE_STATUS"].ToString();
            TyreOE = dt.Rows[0]["TYRE_OE"].ToString();
            VehNo = dt.Rows[0]["VEHNO"].ToString();
            VEH_INTERNAL_NO = dt.Rows[0]["VEH_INTERNAL_NO"].ToString();
            LOCNAME = dt.Rows[0]["LOCNAME"].ToString();
            TyreId = dt.Rows[0]["TYRE_ID"].ToString();
            POS_CATEGORY = dt.Rows[0]["POS_CATEGORY"].ToString();
            TruckTrailer = dt.Rows[0]["TRUCK_TRAILER"].ToString();
            CURRENT_KM_READ = dt.Rows[0]["CURRENT_KM_READ"].ToString();
        }
        else
        {
            Is_Record_Found = false;
        }
    }
    public void CheckValidTyreFront(string TyrePosId, string PosAllowed, string TyreCategory, string TyreId)
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[2];
        prm[0] = new SqlParameter("@TyrePosId", TyrePosId);
        prm[1] = new SqlParameter("@TyreId", "");
        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Check_TyrePosFront", prm);

        if (TyreCategory != "Remould")
        {
            if (PosAllowed == "Rear")
            {
                if (dt.Rows.Count > 0)
                {
                    if (PosAllowed == dt.Rows[0]["POS_ALLOWED"].ToString())
                    {
                        Is_Record_Found = false;
                    }
                    else
                    {
                        Is_Record_Found = true;
                    }
                }
            }
        }
        else
        {
            if (dt.Rows.Count > 0)
            {
                Is_Record_Found = false;
                if (dt.Rows[0]["POS_ALLOWED"].ToString() != "Front")
                {
                    Is_Record_Found = false;
                }
                else
                {
                    Is_Record_Found = true;
                }
            }
        }
    }
    public void CheckValidVehNo(string strVehNo)
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@VEHNO", strVehNo);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Check_Veh_No", prm);

        if (dt.Rows.Count > 0)
        {
            Is_Record_Found = true;

            VehNo = dt.Rows[0]["VEHNO"].ToString();
            VEH_INTERNAL_NO = dt.Rows[0]["VEH_INTERNAL_NO"].ToString();
        }
        else
        {
            Is_Record_Found = false;
        }
    }
    //Roate Tyre
    public void CheckValidVehNoRotate(string strVehNo)
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@VEHNO", strVehNo);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Check_Veh_No_rotate", prm);

        if (dt.Rows.Count > 0)
        {
            Is_Record_Found = true;

            VehNo = dt.Rows[0]["VEHNO"].ToString();
            VEH_INTERNAL_NO = dt.Rows[0]["VEH_INTERNAL_NO"].ToString();
            CURRENT_KM_READ = dt.Rows[0]["Current_KM_Read"].ToString();
        }
        else
        {
            Is_Record_Found = false;
        }
    }
    public void CheckValidVehNoTyreMount(string strVehNo)
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@VEHNO", strVehNo);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Check_Veh_No_TyreMount", prm);

        if (dt.Rows.Count > 0)
        {
            Is_Record_Found = true;

            VehNo = dt.Rows[0]["VEHNO"].ToString();
            VEH_INTERNAL_NO = dt.Rows[0]["VEH_INTERNAL_NO"].ToString();
            VEHCATE = dt.Rows[0]["VehCategory"].ToString();
            POS_ALLOWED = dt.Rows[0]["POS_ALLOWED"].ToString();
            TruckTrailer = dt.Rows[0]["TRUCK_TRAILER"].ToString();
            CURRENT_KM_READ = dt.Rows[0]["CURRENT_KM_READ"].ToString();
        }
        else
        {
            Is_Record_Found = false;
        }
    }
    public void CheckValidVehNoTyreMst(string strVehNo)
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@VEHNO", strVehNo);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Check_Veh_No_TyreMst", prm);

        if (dt.Rows.Count > 0)
        {
            Is_Record_Found = true;

            VehNo = dt.Rows[0]["VEHNO"].ToString();
            VEH_INTERNAL_NO = dt.Rows[0]["VEH_INTERNAL_NO"].ToString();
            VEHCATE = dt.Rows[0]["VehCategory"].ToString();
            POS_ALLOWED = dt.Rows[0]["POS_ALLOWED"].ToString();
            TruckTrailer = dt.Rows[0]["TRUCK_TRAILER"].ToString();
        }
        else
        {
            Is_Record_Found = false;
        }
    }
    //for UserControls ExpenseVoucherFV.ascx 
    //create by jiten on 28_Feb_2009
    public void CheckVehNo(string strVehNo, string strLocBranch)
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[2];

        prm[0] = new SqlParameter("@VEHNO", strVehNo);
        prm[1] = new SqlParameter("@LOCBR", strLocBranch);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Check_VehNo_ExpVou", prm);

        if (dt.Rows.Count > 0)
        {
            Is_Record_Found = true;
            VehNo = dt.Rows[0]["VEHNO"].ToString();
        }
        else
        {
            Is_Record_Found = false;
        }
    }

    //for dropdown
    public void GetTyrePosition(string PosAllowed)
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[3];

        prm[0] = new SqlParameter("@POS_ALLOWED", PosAllowed);
        prm[1] = new SqlParameter("@TT", TruckTrailer);
        prm[2] = new SqlParameter("@VEHNO", VEH_INTERNAL_NO);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "USP_TYREPOSITION_BIND", prm);

        if (dt.Rows.Count > 0)
        {
            Is_Record_Found = true;
            PosCode = dt.Rows[0]["POSCODE"].ToString();
            PosId = dt.Rows[0]["POSID"].ToString();
        }
        else
        {
            Is_Record_Found = false;
        }
    }


}
