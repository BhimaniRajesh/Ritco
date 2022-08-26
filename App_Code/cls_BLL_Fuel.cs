using DabaseAccessLayer;
using DateTimeManager;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using WebControls;

public class BLL_Fuel
{
    #region Private Declaration
    private string _Connection_String;
    private int _Fuel_Brand_ID, _Fuel_Card_ID;
    private string _Fuel_Brand_Name, _VendorCode, _VendorName, _Fuel_Type_ID, _Active_Flag;
    private string _Manual_Fuel_Card_No, _Vehicle_No,_Fuelacccode;
    //private DateTime _Issue_Date, _Expiry_Date, _Ticket_Date;

    private DateTime _Ticket_Date;
    private string _Issue_Date, _Expiry_Date;
    private string _Ticket_No, _Manual_Ticket_No, _Manufacturer, _Model, _Fuel_Tank_Capacity, _Trip_Sheet_ID;
    private string _Driver_Name, _Fuel_Location, _Bill_No, _Pay_Mode;
    private double _Last_Meter_Read, _Curr_Meter_Read, _Total_KMs, _Qty_In_Litres, _Fuel_Cost;
    private double _Fuel_Tax, _Fuel_Total_Cost, _Fuel_Rate, _Mileage;
    #endregion

    #region Properties
    public int Fuel_Brand_ID { get { return _Fuel_Brand_ID; } set { _Fuel_Brand_ID = value; } }
    public string Fuel_Brand_Name { get { return _Fuel_Brand_Name; } set { _Fuel_Brand_Name = value; } }
    public string VendorCode { get { return _VendorCode; } set { _VendorCode = value; } }
    public string VendorName { get { return _VendorName; } set { _VendorName = value; } }
    public string Fuel_Type_ID { get { return _Fuel_Type_ID; } set { _Fuel_Type_ID = value; } }
    public string Active_Flag { get { return _Active_Flag; } set { _Active_Flag = value; } }
    public int Fuel_Card_ID { get { return _Fuel_Card_ID; } set { _Fuel_Card_ID = value; } }
    public string Manual_Fuel_Card_No { get { return _Manual_Fuel_Card_No; } set { _Manual_Fuel_Card_No = value; } }
    public string Vehicle_No { get { return _Vehicle_No; } set { _Vehicle_No = value; } }
    //public DateTime Issue_Date { get { return _Issue_Date; } set { _Issue_Date = value; } }
    //public DateTime Expiry_Date { get { return _Expiry_Date; } set { _Expiry_Date = value; } }
    public string Issue_Date { get { return _Issue_Date; } set { _Issue_Date = value; } }
    public string Expiry_Date { get { return _Expiry_Date; } set { _Expiry_Date = value; } }
     public string Fuelacccode { get { return _Fuelacccode; } set { _Fuelacccode = value; } }
   
    public string Ticket_No { get { return _Ticket_No; } set { _Ticket_No = value; } }
    public string Manual_Ticket_No { get { return _Manual_Ticket_No; } set { _Manual_Ticket_No = value; } }
    public DateTime Ticket_Date { get { return _Ticket_Date; } set { _Ticket_Date = value; } }
    public string Manufacturer { get { return _Manufacturer; } set { _Manufacturer = value; } }
    public string Model { get { return _Model; } set { _Model = value; } }
    public string Fuel_Tank_Capacity { get { return _Fuel_Tank_Capacity; } set { _Fuel_Tank_Capacity = value; } }
    public string Trip_Sheet_ID { get { return _Trip_Sheet_ID; } set { _Trip_Sheet_ID = value; } }
    public string Driver_Name { get { return _Driver_Name; } set { _Driver_Name = value; } }
    public string Fuel_Location { get { return _Fuel_Location; } set { _Fuel_Location = value; } }
    public double Last_Meter_Read { get { return _Last_Meter_Read; } set { _Last_Meter_Read = value; } }
    public double Curr_Meter_Read { get { return _Curr_Meter_Read; } set { _Curr_Meter_Read = value; } }
    public double Total_KMs { get { return _Total_KMs; } set { _Total_KMs = value; } }
    public double Qty_In_Litres { get { return _Qty_In_Litres; } set { _Qty_In_Litres = value; } }
    public double Fuel_Cost { get { return _Fuel_Cost; } set { _Fuel_Cost = value; } }
    public double Fuel_Tax { get { return _Fuel_Tax; } set { _Fuel_Tax = value; } }
    public double Fuel_Total_Cost { get { return _Fuel_Total_Cost; } set { _Fuel_Total_Cost = value; } }
    public double Fuel_Rate { get { return _Fuel_Rate; } set { _Fuel_Rate = value; } }
    public string Bill_No { get { return _Bill_No; } set { _Bill_No = value; } }
    public string Pay_Mode { get { return _Pay_Mode; } set { _Pay_Mode = value; } }
    public double Mileage { get { return _Mileage; } set { _Mileage = value; } }
    #endregion

    public BLL_Fuel(string ConnectionString) { _Connection_String = ConnectionString; }

    public void BindDDLFuelTypes(DropDownList ddl)
    {
        WebControlsBinder wcb = new WebControlsBinder(_Connection_String);

        ddl.DataValueField = "CodeID";
        ddl.DataTextField = "CodeDesc";
        wcb.DataBind(ddl, CommandType.StoredProcedure, "sp_Fleet_Fuel_Get_Fuel_Types");
    }
    public void BindDDLFuelTypesFromFuelBrand(DropDownList ddl)
    {
        WebControlsBinder wcb = new WebControlsBinder(_Connection_String);

        ddl.DataValueField = "Fuel_Type_ID";
        ddl.DataTextField = "Fuel_Type_Name";
        wcb.DataBind(ddl, CommandType.StoredProcedure, "sp_Fleet_Fuel_Get_Fuel_Types_From_FuelBrand");
    }
    public void BindDDLFuelLedgerType(DropDownList ddl)
    {
        WebControlsBinder wcb = new WebControlsBinder(_Connection_String);

        ddl.DataValueField = "Acccode";
        ddl.DataTextField = "Accdesc";
        wcb.DataBind(ddl, CommandType.StoredProcedure, "sp_Fleet_Fuel_Get_Fuel_Ledger");
    }

    public void BindDDLFuelBrandForGivenFuelType(DropDownList ddl, string FuelTypeID)
    {
        WebControlsBinder wcb = new WebControlsBinder(_Connection_String);
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@Fuel_Type_ID", FuelTypeID);

        ddl.DataValueField = "Fuel_Brand_ID";
        ddl.DataTextField = "Fuel_Brand_Name";
        wcb.DataBind(ddl, CommandType.StoredProcedure, "sp_Fleet_Fuel_Get_FuelBrand_For_Given_Fuel_Type", prm);
    }

    public void BindGridFuelBrand(GridView gv)
    {
        WebControlsBinder wcb = new WebControlsBinder(_Connection_String);
        wcb.DataBind(gv, CommandType.StoredProcedure, "sp_Fleet_Fuel_Get_FuelBrand");
    }
    public void BindGridFuelCard(GridView gv)
    {
        WebControlsBinder wcb = new WebControlsBinder(_Connection_String);
        wcb.DataBind(gv, CommandType.StoredProcedure, "sp_Fleet_Fuel_Get_FuelCard");
    }
    public void BindGridFuelTicket(GridView gv)
    {
        WebControlsBinder wcb = new WebControlsBinder(_Connection_String);
        wcb.DataBind(gv, CommandType.StoredProcedure, "sp_Fleet_Fuel_Get_FuelTicket");
    }

    public void BindDLVendor(DataList dl, string VendorCode, string VendorName)
    {
        WebControlsBinder wcb = new WebControlsBinder(_Connection_String);
        SqlParameter[] prm = new SqlParameter[2];

        prm[0] = new SqlParameter("@VendorCode", VendorCode);
        prm[1] = new SqlParameter("@VendorName", VendorName);

        wcb.DataBind(dl, CommandType.StoredProcedure, "sp_Fleet_Fuel_Get_Vendor_For_Popup", prm);
    }
    public void BindDLVehicle(DataList dl, string VehicleNumber)
    {
        WebControlsBinder wcb = new WebControlsBinder(_Connection_String);
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@VEHNO", VehicleNumber);

        wcb.DataBind(dl, CommandType.StoredProcedure, "sp_Fleet_Fuel_Get_Vehicle_For_Popup", prm);
    }
    public void BindDLJourney(DataList dl, string JourneyID)
    {
        WebControlsBinder wcb = new WebControlsBinder(_Connection_String);
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@VSlipNo", JourneyID);

        wcb.DataBind(dl, CommandType.StoredProcedure, "sp_Fleet_Fuel_Get_Journey_For_Popup", prm);
    }

    public bool CheckDuplicateFuelBrandName(int FuelBrandID, string FuelBrandName)
    {
        DatabaseAccessor dba = new DatabaseAccessor(_Connection_String);
        SqlParameter[] prm = new SqlParameter[2];

        prm[0] = new SqlParameter("@Fuel_Brand_ID", FuelBrandID.ToString());
        prm[1] = new SqlParameter("@Fuel_Brand_Name", FuelBrandName);

        if (dba.HasRecord(CommandType.StoredProcedure, "sp_Fleet_Fuel_Check_Duplicate_FuelBrand_Name", prm)) return true; else return false;
    }
    public bool CheckDuplicateFuelCardNo(int FuelCardID, string ManualFuelCardNo)
    {
        DatabaseAccessor dba = new DatabaseAccessor(_Connection_String);
        SqlParameter[] prm = new SqlParameter[2];

        prm[0] = new SqlParameter("@Fuel_Card_ID", FuelCardID.ToString());
        prm[1] = new SqlParameter("@Manual_Fuel_Card_No", ManualFuelCardNo);

        if (dba.HasRecord(CommandType.StoredProcedure, "sp_Fleet_Fuel_Check_Duplicate_FuelCard_No", prm)) return true; else return false;
    }

    public bool CheckDuplicateFuelCardNoVehicle(int FuelCardID, string Vehicle_No)
    {
        DatabaseAccessor dba = new DatabaseAccessor(_Connection_String);
        SqlParameter[] prm = new SqlParameter[2];

        //prm[0] = new SqlParameter("@Fuel_Card_ID", FuelCardID.ToString());
        prm[0] = new SqlParameter("@Vehicle_No", Vehicle_No);

        if (dba.HasRecord(CommandType.StoredProcedure, "sp_Fleet_Fuel_Check_Duplicate_FuelCard_VehicleNo", prm)) return true; else return false;
    }


    public bool CheckDuplicateFuelManualTicketNo(string TicketNo, string ManualTicketNo)
    {
        DatabaseAccessor dba = new DatabaseAccessor(_Connection_String);
        SqlParameter[] prm = new SqlParameter[2];

        prm[0] = new SqlParameter("@Ticket_No", TicketNo);
        prm[1] = new SqlParameter("@Manual_Ticket_No", ManualTicketNo);

        if (dba.HasRecord(CommandType.StoredProcedure, "sp_Fleet_Fuel_Check_Duplicate_Fuel_Manual_Ticket_No", prm)) return true; else return false;
    }

    public string GetVendorDetails(string VendorCode)
    {
        DatabaseAccessor dba = new DatabaseAccessor(_Connection_String);
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];
        string str_Return_Value = "N";

        prm[0] = new SqlParameter("@VendorCode", VendorCode);

        dt = dba.ExecuteDataTable(CommandType.StoredProcedure, "sp_Fleet_Fuel_Get_Vendor_Details", prm);
        if (dt.Rows.Count > 0) str_Return_Value = "Y~" + dt.Rows[0]["VendorName"].ToString();
        return str_Return_Value;
    }
    public string GetVehicleDetails(string VehicleNo)
    {
        DatabaseAccessor dba = new DatabaseAccessor(_Connection_String);
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];
        string str_Return_Value = "N";

        prm[0] = new SqlParameter("@VEHNO", VehicleNo);

        dt = dba.ExecuteDataTable(CommandType.StoredProcedure, "sp_Fleet_Fuel_Get_Vehicle_Details", prm);
        //if (dt.Rows.Count > 0) str_Return_Value = "Y~" + dt.Rows[0]["VEHMADEBY"].ToString() + "~" + dt.Rows[0]["VEHMODEL"].ToString() + "~" + dt.Rows[0]["Fuel_Tank_Cap"].ToString() + "~" + dt.Rows[0]["Last_Meter_Read"].ToString();
        if (dt.Rows.Count > 0) str_Return_Value = "Y~" + "";

        return str_Return_Value;
    }
    public string GetJourneyDetails(string TripSheetID)
    {
        DatabaseAccessor dba = new DatabaseAccessor(_Connection_String);
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];
        string str_Return_Value = "N";

        prm[0] = new SqlParameter("@VSlipNo", TripSheetID);

        dt = dba.ExecuteDataTable(CommandType.StoredProcedure, "sp_Fleet_Fuel_Get_Journey_Details", prm);
        if (dt.Rows.Count > 0) str_Return_Value = "Y~" + dt.Rows[0]["Driver_Name"].ToString();
        return str_Return_Value;
    }

    public void SaveFuelBrandRecord()
    {
        DatabaseAccessor dba = new DatabaseAccessor(_Connection_String);
        SqlParameter[] prm = new SqlParameter[5];

        prm[0] = new SqlParameter("@Fuel_Brand_ID", Fuel_Brand_ID);
        prm[1] = new SqlParameter("@Fuel_Brand_Name", Fuel_Brand_Name);
        prm[2] = new SqlParameter("@VendorCode", VendorCode);
        prm[3] = new SqlParameter("@Fuel_Type_ID", Fuel_Type_ID);
        prm[4] = new SqlParameter("@Active_Flag", Active_Flag);

        if (Fuel_Brand_ID == 0) dba.ExecuteNonQuery(CommandType.StoredProcedure, "sp_Fleet_Fuel_Insert_WEBX_FLEET_FUELBRAND", prm); else dba.ExecuteNonQuery(CommandType.StoredProcedure, "sp_Fleet_Fuel_Update_WEBX_FLEET_FUELBRAND", prm);
    }
    public void SaveFuelCardRecord()
    {
        DatabaseAccessor dba = new DatabaseAccessor(_Connection_String);
        SqlParameter[] prm = new SqlParameter[10];

        prm[0] = new SqlParameter("@Fuel_Card_ID", Fuel_Card_ID);
        prm[1] = new SqlParameter("@Manual_Fuel_Card_No", Manual_Fuel_Card_No);
        prm[2] = new SqlParameter("@VendorCode", VendorCode);
        //prm[3] = new SqlParameter("@Issue_Date", Issue_Date.ToString("dd MMM yyyy"));
        //prm[4] = new SqlParameter("@Expiry_Date", Expiry_Date.ToString("dd MMM yyyy"));
        prm[3] = new SqlParameter("@Issue_Date", Issue_Date);
        prm[4] = new SqlParameter("@Expiry_Date", Expiry_Date);

        prm[5] = new SqlParameter("@Vehicle_No", Vehicle_No);
        prm[6] = new SqlParameter("@Fuel_Type_ID", Fuel_Type_ID);
        prm[7] = new SqlParameter("@Fuel_Brand_ID", Fuel_Brand_ID);
        prm[8] = new SqlParameter("@Active_Flag", Active_Flag);
        prm[9] = new SqlParameter("@acccode", Fuelacccode);


        if (Fuel_Card_ID == 0) dba.ExecuteNonQuery(CommandType.StoredProcedure, "sp_Fleet_Fuel_Insert_WEBX_FLEET_FUELCARD", prm); else dba.ExecuteNonQuery(CommandType.StoredProcedure, "sp_Fleet_Fuel_Update_WEBX_FLEET_FUELCARD", prm);
        
    }
    public void SaveFuelTicketRecord()
    {
        DatabaseAccessor dba = new DatabaseAccessor(_Connection_String);
        SqlParameter[] prm = new SqlParameter[19];

        prm[0] = new SqlParameter("@Ticket_No", Ticket_No);
        prm[1] = new SqlParameter("@Manual_Ticket_No", Manual_Ticket_No);
        prm[2] = new SqlParameter("@Ticket_Date", Ticket_Date.ToString("dd MMM yyyy"));
        prm[3] = new SqlParameter("@Vehicle_No", Vehicle_No);
        prm[4] = new SqlParameter("@Trip_Sheet_ID", Trip_Sheet_ID);
        prm[5] = new SqlParameter("@VendorCode", VendorCode);
        prm[6] = new SqlParameter("@Fuel_Location", Fuel_Location);
        prm[7] = new SqlParameter("@Fuel_Type_ID", Fuel_Type_ID);
        prm[8] = new SqlParameter("@Fuel_Brand_ID", Convert.ToInt32(Fuel_Brand_ID));
        prm[9] = new SqlParameter("@Last_Meter_Read", Last_Meter_Read);
        prm[10] = new SqlParameter("@Curr_Meter_Read", Curr_Meter_Read);
        prm[11] = new SqlParameter("@Total_KMs", Total_KMs);
        prm[12] = new SqlParameter("@Qty_In_Litres", Qty_In_Litres);
        prm[13] = new SqlParameter("@Fuel_Cost", Fuel_Cost);
        prm[14] = new SqlParameter("@Fuel_Tax", Fuel_Tax);
        prm[16] = new SqlParameter("@Fuel_Total_Cost", Fuel_Total_Cost);
        prm[15] = new SqlParameter("@Fuel_Rate", Fuel_Rate);
        prm[17] = new SqlParameter("@Bill_No", Bill_No);
        prm[18] = new SqlParameter("@Pay_Mode", Pay_Mode);

        if (Ticket_No == "0") dba.ExecuteNonQuery(CommandType.StoredProcedure, "sp_Fleet_Fuel_Insert_WEBX_FLEET_FUELTICKET", prm); else dba.ExecuteNonQuery(CommandType.StoredProcedure, "sp_Fleet_Fuel_Update_WEBX_FLEET_FUELTICKET", prm);
        
    }

    public void GetFuelBrandRecord(int FuelBrandID)
    {
        DatabaseAccessor dba = new DatabaseAccessor(_Connection_String);
        DataTable dt;
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@Fuel_Brand_ID", FuelBrandID.ToString());

        dt = dba.ExecuteDataTable(CommandType.StoredProcedure, "sp_Fleet_Fuel_Get_FuelBrand_Record", prm);

        if (dt.Rows.Count > 0)
        {
            Fuel_Brand_ID = FuelBrandID;
            Fuel_Brand_Name = dt.Rows[0]["Fuel_Brand_Name"].ToString();
            VendorCode = dt.Rows[0]["VendorCode"].ToString();
            VendorName = dt.Rows[0]["VendorName"].ToString();
            Fuel_Type_ID = dt.Rows[0]["Fuel_Type_ID"].ToString();
            Active_Flag = dt.Rows[0]["Active_Flag"].ToString();
            
        }
    }
    public void GetFuelCardRecord(int FuelCardID)
    {
        DatabaseAccessor dba = new DatabaseAccessor(_Connection_String);
        DataTable dt;
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@Fuel_Card_ID", FuelCardID.ToString());

        dt = dba.ExecuteDataTable(CommandType.StoredProcedure, "sp_Fleet_Fuel_Get_FuelCard_Record", prm);

        if (dt.Rows.Count > 0)
        {
            Fuel_Card_ID = FuelCardID;
            Manual_Fuel_Card_No = dt.Rows[0]["Manual_Fuel_Card_No"].ToString();
            VendorCode = dt.Rows[0]["VendorCode"].ToString();
            VendorName = dt.Rows[0]["VendorName"].ToString();
            //Issue_Date = Convert.ToDateTime(dt.Rows[0]["Issue_Date"].ToString());
            //Expiry_Date = Convert.ToDateTime(dt.Rows[0]["Expiry_Date"].ToString());

            Issue_Date = (dt.Rows[0]["Issue_Date"].ToString());
            Expiry_Date = (dt.Rows[0]["Expiry_Date"].ToString());


            Vehicle_No = dt.Rows[0]["Vehicle_No"].ToString();
            Fuel_Type_ID = dt.Rows[0]["Fuel_Type_ID"].ToString();
            Fuel_Brand_ID = Convert.ToInt32(dt.Rows[0]["Fuel_Brand_ID"].ToString());
            Active_Flag = dt.Rows[0]["Active_Flag"].ToString();
            Fuelacccode = dt.Rows[0]["Acccode"].ToString();
        }
    }
    public void GetFuelTicketRecord(string TicketNo)
    {
        DatabaseAccessor dba = new DatabaseAccessor(_Connection_String);
        DataTable dt;
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@Ticket_No", TicketNo);

        dt = dba.ExecuteDataTable(CommandType.StoredProcedure, "sp_Fleet_Fuel_Get_FuelTicket_Record", prm);

        if (dt.Rows.Count > 0)
        {
            Ticket_No = TicketNo;
            Manual_Ticket_No = dt.Rows[0]["Manual_Ticket_No"].ToString();
            Ticket_Date = Convert.ToDateTime(dt.Rows[0]["Ticket_Date"].ToString());

            Vehicle_No = dt.Rows[0]["Vehicle_No"].ToString();
            Manufacturer = dt.Rows[0]["Manufacturer"].ToString();
            Model = dt.Rows[0]["Model"].ToString();
            Fuel_Tank_Capacity = dt.Rows[0]["Fuel_Tank_Cap"].ToString();

            Trip_Sheet_ID = dt.Rows[0]["Trip_Sheet_ID"].ToString();
            Driver_Name = dt.Rows[0]["Driver_Name"].ToString();

            VendorCode = dt.Rows[0]["VendorCode"].ToString();
            VendorName = dt.Rows[0]["VendorName"].ToString();

            Fuel_Location = dt.Rows[0]["Fuel_Location"].ToString();
            Fuel_Type_ID = dt.Rows[0]["Fuel_Type_ID"].ToString();
            Fuel_Brand_ID = Convert.ToInt32(dt.Rows[0]["Fuel_Brand_ID"].ToString());
            Last_Meter_Read = Convert.ToDouble(dt.Rows[0]["Last_Meter_Read"].ToString());
            Curr_Meter_Read = Convert.ToDouble(dt.Rows[0]["Curr_Meter_Read"].ToString());
            Total_KMs = Convert.ToDouble(dt.Rows[0]["Total_KMs"].ToString());
            Qty_In_Litres = Convert.ToDouble(dt.Rows[0]["Qty_In_Litres"].ToString());
            Fuel_Cost = Convert.ToDouble(dt.Rows[0]["Fuel_Cost"].ToString());
            Fuel_Tax = Convert.ToDouble(dt.Rows[0]["Fuel_Tax"].ToString());
            Fuel_Total_Cost = Convert.ToDouble(dt.Rows[0]["Fuel_Total_Cost"].ToString());
            Fuel_Rate = Convert.ToDouble(dt.Rows[0]["Fuel_Rate"].ToString());
            Bill_No = dt.Rows[0]["Bill_No"].ToString();
            Pay_Mode = dt.Rows[0]["Pay_Mode"].ToString();
        }
    }
}
