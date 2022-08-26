using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

public partial class wfrm_AJAX_Validator : System.Web.UI.Page
{
    string str_Connection_String = "";
    string strNullVal = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        str_Connection_String = Session["SqlProvider"].ToString();
        if (Request.QueryString["Function"] == "CheckValidTyreID"){Response.Write(CheckValidTyreID());}
        if (Request.QueryString["Function"] == "CheckValidTyreIDRemould") { Response.Write(CheckValidTyreIDRemould()); }
        if (Request.QueryString["Function"] == "CheckValidTyrePosCode"){Response.Write(CheckValidTyrePosCode());}
        if (Request.QueryString["Function"] == "CheckValidTyrePatCode"){Response.Write(CheckValidTyrePatCode());}
        if (Request.QueryString["Function"] == "CheckValidTyreNo"){Response.Write(CheckValidTyreNo());}
        if (Request.QueryString["Function"] == "CheckTyreModelNo"){Response.Write(CheckTyreModelNo());}
        if (Request.QueryString["Function"] == "CheckValidSizeName"){Response.Write(CheckValidSizeName());}
        if (Request.QueryString["Function"] == "GetTyreDetails") { Response.Write(GetTyreDetails()); }
        if (Request.QueryString["Function"] == "CheckTyrePosFront") { Response.Write(CheckTyrePosFront()); }
        if (Request.QueryString["Function"] == "CheckValidVehNo") { Response.Write(CheckValidVehNo()); }
        if (Request.QueryString["Function"] == "GetVehIDKM") { Response.Write(GetVehIDKM()); }
        if (Request.QueryString["Function"] == "CheckValidVehNoTyreMst") { Response.Write(CheckValidVehNoTyreMst()); }
        if (Request.QueryString["Function"] == "GetTyrePosition") { Response.Write(GetTyrePosition()); }
        if (Request.QueryString["Function"] == "CheckValidVehNoTyreMount") { Response.Write(CheckValidVehNoTyreMount()); }
        if (Request.QueryString["Function"] == "CheckValidVehNoRotate") { Response.Write(CheckValidVehNoRotate()); }
        if (Request.QueryString["Function"] == "CheckTWI") { Response.Write(CheckTWI()); }
        if (Request.QueryString["Function"] == "GetTyreDetailsTDM") { Response.Write(GetTyreDetailsTDM()); }
        if (Request.QueryString["Function"] == "FillTreadDepth") { Response.Write(FillTreadDepth()); }
        if (Request.QueryString["Function"] == "GetTyreDetailsWarranty") { Response.Write(GetTyreDetailsWarranty()); }
        if (Request.QueryString["Function"] == "CheckManualVehicleOdometerReading") { Response.Write(CheckManualVehicleOdometerReading()); }
        if (Request.QueryString["Function"] == "FillTyreDetailsForTyreScrap") { Response.Write(FillTyreDetailsForTyreScrap()); }
        if (Request.QueryString["Function"] == "GetVendorName") { Response.Write(GetVendorName()); }
        
    }

    private string FillTyreDetailsForTyreScrap()
    {
        General gen = new General(str_Connection_String);
        gen.TyreNo = Request.QueryString["TyreNo"].ToString();
        gen.FillTyreDetailsForTyreScrap();
        if (gen.Is_Record_Found == true)
        {
            return "Y~" + gen.TyreId + "~" + gen.MFG_NAME + "~" + gen.MODEL_NO + "~" + gen.TYRE_COST + "~" + gen.TYRE_PUR_KMS + "~" + gen.CURRENT_KM_READ + "~" + gen.TYRE_TREAD_DEPTH + "~" + gen.VEHICLE_STATUS + "~" + gen.VehNo + "~" + gen.TyreStatus + "~";
        }
        else
        {
            return "N~";
        }
    }
    private string CheckManualVehicleOdometerReading()
    {
        General gen = new General(str_Connection_String);
        gen.TyreId = Request.QueryString["TyreId"].ToString();
        gen.CheckManualVehicleOdometerReading();
        if (gen.Is_Record_Found == true)
        {
            return "Y~" + gen.MANUAL_MOUNT_KM_RUN + "~" + gen.MANUAL_DISMOUNT_KM_RUN + "~";
        }
        else
        {
            return "N~";
        }
    }
    private string CheckValidTyreIDRemould()
    {
        cls_Tyre_Remould tyreRemould = new cls_Tyre_Remould(str_Connection_String);
        tyreRemould.TyreId = Request.QueryString["TyreID"].ToString();
        tyreRemould.CheckValidTyreId();
        if (tyreRemould.IsRecordFound == true)
        {
            return "Y~" + tyreRemould.TyreId + "~" + tyreRemould.TYRE_NO + "~" + tyreRemould.TYRE_TREAD_DEPTH_32NDS + "~" + tyreRemould.TYRE_VEHNO + "~" + tyreRemould.KM_Read + "~" + tyreRemould.TYRE_COST + "~" + tyreRemould.tyre_pattern + "~" + tyreRemould.TYRE_STATUS + "~";
        }
        else
        {
            return "N~";
        }
    }
    public string FillTreadDepth()
    {
        cls_TreadDepthMeasurement cTDM = new cls_TreadDepthMeasurement(str_Connection_String);
        
        cTDM.FillTDM(Request.QueryString["TyreNo"].ToString()); 
        if (cTDM.IsRecordFound == true)
        {
            return "Y~" + cTDM.AVG_TWI + "~";
        }
        else
        {
            return "N~";
        }
    }
    private string GetTyreDetailsWarranty()
    {
        cls_Tyre_Warranty cTyreWarranty = new cls_Tyre_Warranty(str_Connection_String);
        cTyreWarranty.FillTyreDetails(Request.QueryString["TyreNo"].ToString());
        if (cTyreWarranty.IsRecordFound == true)
        {
            return "Y~" + cTyreWarranty.TYRE_NO + "~" + cTyreWarranty.TYRE_ID + "~" + cTyreWarranty.MFG + "~" + cTyreWarranty.TYRE_COST + "~" + cTyreWarranty.TYRE_TOTKM_RUN + "~" + cTyreWarranty.MODEL + "~" + cTyreWarranty.LAST_TERADDEPTH + "~" + cTyreWarranty.VEH_INTERNAL_NO + "~" + cTyreWarranty.TOTAL_COST + "~";
        }
        else
        {
            return "N~";
        }
    }
    private string GetTyreDetailsTDM()
    {
        cls_TreadDepthMeasurement cTDM = new cls_TreadDepthMeasurement(str_Connection_String);
        cTDM.FillTyreDetails_TyreWise(Request.QueryString["TyreNo"].ToString());
        if (cTDM.IsRecordFound == true)
        {
            return "Y~" + cTDM.TYRE_ID + "~" + cTDM.KM_RUN + "~" + cTDM.VEH_NO + "~" + cTDM.POSITION + "~" + cTDM.TYRE_TREAD_DEPTH_32NDS + "~" + cTDM.MFG + "~" + cTDM.MODEL + "~" + cTDM.AVG_TWI + "~" + cTDM.TyreId + "~" + cTDM.VehId + "~" + cTDM.TYRE_STATUS + "~";
        }
        else
        {
            return "N~";
        }
    }
    private string CheckTWI()
    {
        cls_TreadDepthMeasurement cTDS = new cls_TreadDepthMeasurement(str_Connection_String);
        cTDS.TYRE_ID = Request.QueryString["TyreID"].ToString();
        cTDS.CheckTWI();
        if (cTDS.IsRecordFound == true)
        {
            return "Y~" + cTDS.TWI1 + "~" + cTDS.TWI2 + "~" + cTDS.TWI3 + "~" + cTDS.AVG_TWI + "~";
        }
        else
        {
            return "N~";
        }
    }
    private string GetTyrePosition()
    {
        General gen = new General(str_Connection_String);
        gen.TruckTrailer = Request.QueryString["TT"].ToString();
        gen.VEH_INTERNAL_NO = Request.QueryString["VehNo"].ToString();
        gen.GetTyrePosition(Request.QueryString["PosAllow"].ToString());
        if (gen.Is_Record_Found == true)
        {
            return "Y~" + gen.PosCode + "~" + gen.PosId + "~";
        }
        else
        {
            return "N~";
        }
    }
    private string CheckValidTyreID()
    {
        cls_Tyre_Remould tyreRemould = new cls_Tyre_Remould(str_Connection_String);
        tyreRemould.TyreId = Request.QueryString["TyreID"].ToString();
        tyreRemould.CheckValidTyreId();
        if (tyreRemould.IsRecordFound == true)
        {
            return "Y~" + tyreRemould.TyreId + "~" + tyreRemould.CaptureKM + "~" + tyreRemould.Cost + "~";
        }
        else
        {
            return "N~";
        }
    }
    private string CheckValidTyrePosCode()
    {
        cls_TyrePosition tyrepos = new cls_TyrePosition(str_Connection_String);
        tyrepos.TRUCK_TRAILER = Request.QueryString["VehicleCate"].ToString();    
        tyrepos.TYREPOS_CODE = Request.QueryString["TyrePosCode"].ToString();
        if (Request.QueryString["TyrePosId"].ToString() != "undefined")
        {
            tyrepos.CheckValidTyrePos(Request.QueryString["TyrePosId"].ToString());
        }
        else
        {
            tyrepos.CheckValidTyrePos(strNullVal);
        }
        if (tyrepos.IsRecordFound == true)
        {
            return "Y~" + tyrepos.TYREPOS_CODE + "~";
        }
        else
        {
            return "N~";
        }
    }
    private string CheckValidTyrePatCode()
    {
        cls_TyrePattern tyrepat = new cls_TyrePattern(str_Connection_String);
        tyrepat.TYREPAT_CODE = Request.QueryString["TyrePatCode"].ToString();
        if (Request.QueryString["TyrePatId"].ToString() != "undefined")
        {
            tyrepat.CheckValidTyrePat(Request.QueryString["TyrePatId"].ToString());
        }
        else
        {
            tyrepat.CheckValidTyrePat(strNullVal);
        }
        if (tyrepat.IsRecordFound == true)
        {
            return "Y~" + tyrepat.TYREPAT_CODE + "~";
        }
        else
        {
            return "N~";
        }
    }
    private string CheckValidTyreNo()
    {
        cls_TyreMaster tyremst = new cls_TyreMaster(str_Connection_String);
        tyremst.TYRE_NO = Request.QueryString["TyreNo"].ToString();
        if (Request.QueryString["TyreId"].ToString() != "undefined")
        {
            tyremst.CheckValidTyreNo(Request.QueryString["TyreId"].ToString());
        }
        else
        {
            tyremst.CheckValidTyreNo(strNullVal);
        }
        if (tyremst.IsRecordFound == true)
        {
            return "Y~" + tyremst.TYRE_NO + "~";
        }
        else
        {
            return "N~";
        }
    }
    private string CheckTyreModelNo()
    {
        cls_TyreModel tyremod = new cls_TyreModel(str_Connection_String);
        tyremod.MODEL_NO = Request.QueryString["TyreModelNo"].ToString();
        if (Request.QueryString["TyreModelId"].ToString() != "undefined")
        {
            tyremod.CheckValidTyreModelNo(Request.QueryString["TyreModelId"].ToString());
        }
        else
        {
            tyremod.CheckValidTyreModelNo(strNullVal);
        }
        if (tyremod.IsRecordFound == true)
        {
            return "Y~" + tyremod.MODEL_NO + "~";
        }
        else
        {
            return "N~";
        }
    }
    private string CheckValidSizeName()
    {
        cls_TyreMaster tyremst = new cls_TyreMaster(str_Connection_String);
        if (Request.QueryString["sizeId"].ToString() != "undefined")
        {
            tyremst.CheckValidSizeName(Request.QueryString["SizeName"].ToString(), Request.QueryString["sizeId"].ToString());
        }
        else
        {
            tyremst.CheckValidSizeName(Request.QueryString["SizeName"].ToString(), strNullVal);
        }
        if (tyremst.IsRecordFound == true)
        {
            return "Y~";
        }
        else
        {
            return "N~";
        }
    }
    private string GetTyreDetails()
    {
        General gen = new General(str_Connection_String);
        gen.TyreNo = Request.QueryString["TyreNo"].ToString();
        gen.GetTyreDetails();
        if (gen.Is_Record_Found == true)
        {
            return "Y~" + gen.TyreSize + "~" + gen.TyrePattern + "~" + gen.TyrePosition + "~" + gen.Manufacturer + "~" + gen.VehNo + "~" + gen.VEH_INTERNAL_NO + "~" + gen.LOCNAME + "~" + gen.TyreId + "~" + gen.POS_CATEGORY + "~" + gen.TruckTrailer + "~" + gen.CURRENT_KM_READ + "~" + gen.TyreStatus + "~";
        }
        else
        {
            return "N~";
        }
    }
    private string CheckTyrePosFront()
    {
        General gen = new General(str_Connection_String);
        gen.CheckValidTyreFront(Request.QueryString["TyrePosId"].ToString(), Request.QueryString["TyrePosAllowed"].ToString(), Request.QueryString["TyreCategory"].ToString(), Request.QueryString["TyreId"].ToString());
        if (gen.Is_Record_Found == true)
        {
            return "Y~";
        }
        else
        {
            return "N~";
        }
    }
    private string CheckValidVehNo()
    {
        General gen = new General(str_Connection_String);
        gen.CheckValidVehNo(Request.QueryString["VehNo"].ToString());
        if (gen.Is_Record_Found == true)
        {
            return "Y~" + gen.VehNo + "~" + gen.VEH_INTERNAL_NO + "~";
        }
        else
        {
            return "N~";
        }
    }
    private string CheckValidVehNoTyreMst()
    {
        General gen = new General(str_Connection_String);
        gen.CheckValidVehNoTyreMst(Request.QueryString["VehNo"].ToString());
        if (gen.Is_Record_Found == true)
        {
            return "Y~" + gen.VehNo + "~" + gen.VEH_INTERNAL_NO + "~" + gen.VEHCATE + "~" + gen.POS_ALLOWED + "~" + gen.TruckTrailer + "~";
        }
        else
        {
            return "N~";
        }
    }
    private string CheckValidVehNoTyreMount()
    {
        General gen = new General(str_Connection_String);
        gen.CheckValidVehNoTyreMount(Request.QueryString["VehNo"].ToString());
        if (gen.Is_Record_Found == true)
        {
            return "Y~" + gen.VehNo + "~" + gen.VEH_INTERNAL_NO + "~" + gen.VEHCATE + "~" + gen.POS_ALLOWED + "~" + gen.TruckTrailer + "~" + gen.CURRENT_KM_READ + "~";
        }
        else
        {
            return "N~";
        }
    }
    private string GetVehIDKM()
    {
        cls_TyreOdometer Tyre_Odometer = new cls_TyreOdometer(str_Connection_String);
        Tyre_Odometer.VehicleNo = Request.QueryString["VehNo"].ToString();
        Tyre_Odometer.GetVehIDKM();
        if (Tyre_Odometer.IsRecordFound == true)
        {
            return "Y~" + Tyre_Odometer.VehicleNo + "~" + Tyre_Odometer.CURRENT_KM_READ + "~" + Tyre_Odometer.VEH_INTERNAL_NO + "~" + Tyre_Odometer.TripSheetNo + "~" + Tyre_Odometer.VehicleStatus + "~";
        }
        else
        {
            return "N~";
        }
    } 
    private string CheckValidVehNoRotate()
    {
        General gen = new General(str_Connection_String);
        gen.CheckValidVehNoRotate(Request.QueryString["VehNo"].ToString());
        if (gen.Is_Record_Found == true)
        {
            return "Y~" + gen.VehNo + "~" + gen.VEH_INTERNAL_NO + "~" + gen.CURRENT_KM_READ + "~";
        }
        else
        {
            return "N~";
        }
    }
    private string GetVendorName()
    {
        cls_Tyre_Scrap objTyreScrap = new cls_Tyre_Scrap(str_Connection_String);

        objTyreScrap.VENDORNAME = Request.QueryString["VENDORNAME"].ToString();
        objTyreScrap.CheckVendorName();

        if (objTyreScrap.IsRecordFound == true) { return "Y~" + objTyreScrap.VENDORNAME + "~" + objTyreScrap.VENDORCODE + "~"; } else { return "N~"; }
    }
}
