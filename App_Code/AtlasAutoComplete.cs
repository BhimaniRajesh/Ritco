using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data;
using System.Data.SqlClient;

[WebService(Namespace = "http://tempuri.org/")]

[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[System.Web.Script.Services.ScriptService]

public class AtlasAutoComplete : System.Web.Services.WebService
{

    public static DataTable dsCity = new DataTable();
    public static DataTable dsCityFromCityMaster = new DataTable();
    public static DataTable DsVendor = new DataTable();
    public static DataTable DsOctVendor = new DataTable();
    public static DataTable DsVehicle = new DataTable();
    public static DataTable DsAsset = new DataTable();
    public static DataTable DsCustomer = new DataTable();
    public static DataTable DsLocation = new DataTable();
    public static DataTable DsAcccode = new DataTable();
    public static DataTable DsGeneralAsset = new DataTable();
    public static DataTable DsDrivName = new DataTable();
    public static DataTable DsVendorName = new DataTable();
    public static DataTable DsSpareParts = new DataTable();
    public static DataTable DsTyreModel = new DataTable();
    public static DataTable DsTyreMFG = new DataTable();
    public static DataTable DsTyreSize = new DataTable();
    public static DataTable DsTyrePatten = new DataTable();
    public static DataTable DsServiceWiseCustomer = new DataTable();
    public static DataTable DsFixAsset = new DataTable();
    public static DataTable DsStationaryParts = new DataTable();
    public static DataTable DsMaterialDetails = new DataTable();
    public static DataTable DsVehicleMaster = new DataTable();
    public static DataTable DsVehicleOpenTripsheet = new DataTable();
    public static DataTable DsVendorFuel = new DataTable();
    public static DataTable DsGetCityCd = new DataTable();

    public static DataTable DsRouteNo = new DataTable();
    public static DataTable DsGetAllVehicle = new DataTable();
    public static DataTable DsUser = new DataTable();

    String[] arrCities;
    String[] arrCitiesCode;
    String[] arrCode;
    String[] arrCode1;

    public AtlasAutoComplete()
    {
        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod(EnableSession = true)]
    public string[] GetCompletionList(string prefixText, int count)
    {
        arrCities = new string[dsCity.Select("Location like '" + prefixText + "%' ").Length];
        int i = 0;
        foreach (DataRow Dr in dsCity.Select("Location like '" + prefixText + "%' "))
        {
            arrCities[i] = (Dr["location"].ToString());
            i = i + 1;

        }
        return arrCities;

    }
    [WebMethod(EnableSession = true)]
    public string[] GetCities(string prefixText, int count)
    {

        //if ((string)Session["LocMastState"] == null)
        //    {
        arrCities = new string[dsCityFromCityMaster.Select("location like '" + prefixText + "%' ").Length];

        int i = 0;
        foreach (DataRow Dr in dsCityFromCityMaster.Select("location like '" + prefixText + "%' "))
        {
            arrCities[i] = (Dr["location"].ToString());
            i = i + 1;
        }
        return arrCities;
        //}

        //else
        //{
        //        arrCities = new string[dsCity.Select("LocState = '" + Session["LocMastState"] + "' and  locName like '" + prefixText + "%'").Length];

        //        int i = 0;
        //        foreach (DataRow Dr in dsCity.Select("LocState = '" + Session["LocMastState"] + "' and  locName like '" + prefixText + "%'"))
        //        {
        //            arrCities[i] = (Dr["locName"].ToString());
        //            i = i + 1;
        //        }

        //      return arrCities;
        //}
    }


    [WebMethod(EnableSession = true)]
    public string[] GetCitiesCode(string prefixText, int count)
    {
        arrCitiesCode = new string[dsCity.Select("locName like '" + prefixText + "%' or  loccode like '" + prefixText + "%'  ").Length];

        int i = 0;
        foreach (DataRow Dr in dsCity.Select("locName like '" + prefixText + "%' or  loccode like '" + prefixText + "%' "))
        {
            arrCitiesCode[i] = (Dr["locName"].ToString() + ":" + Dr["loccode"].ToString());
            i = i + 1;
        }
        return arrCitiesCode;
    }

    [WebMethod(EnableSession = true)]
    public string[] GetCode(string prefixText, int count)
    {
        arrCode = new string[dsCity.Select("loccode like '" + prefixText + "%'  or  loccode like '" + prefixText + "%' ").Length];

        int i = 0;
        foreach (DataRow Dr in dsCity.Select("loccode like '" + prefixText + "%'  or  loccode like '" + prefixText + "%' "))
        {
            arrCode[i] = (Dr["locName"].ToString() + ":" + Dr["loccode"].ToString());
            i = i + 1;
        }
        return arrCode;
    }
    [WebMethod(EnableSession = true)]
    public string[] GetVendor(string prefixText, int count)
    {
        arrCode = new string[DsVendor.Select("Name like '" + prefixText + "%'  or  Code like '" + prefixText + "%' ").Length];

        int i = 0;
        foreach (DataRow Dr in DsVendor.Select("Name like '" + prefixText + "%'  or  Code like '" + prefixText + "%' "))
        {
            arrCode[i] = (Dr["Name"].ToString() + "~" + Dr["Code"].ToString());
            i = i + 1;
        }
        return arrCode;
    }
    [WebMethod(EnableSession = true)]
    public string[] GetVehicle(string prefixText, int count)
    {
        arrCode = new string[DsVehicle.Select("Name like '" + prefixText + "%'  or  Code like '" + prefixText + "%' ").Length];

        int i = 0;
        foreach (DataRow Dr in DsVehicle.Select("Name like '" + prefixText + "%'  or  Code like '" + prefixText + "%' "))
        {
            arrCode[i] = (Dr["Name"].ToString() + "~" + Dr["Code"].ToString());
            i = i + 1;
        }
        return arrCode;
    }
    [WebMethod(EnableSession = true)]
    public string[] Get_Asset(string prefixText, int count)
    {
        arrCode = new string[DsAsset.Select("Name like '" + prefixText + "%'  or  Code like '" + prefixText + "%' ").Length];

        int i = 0;
        foreach (DataRow Dr in DsAsset.Select("Name like '" + prefixText + "%'  or  Code like '" + prefixText + "%' "))
        {
            arrCode[i] = (Dr["Name"].ToString() + "~" + Dr["Code"].ToString());
            i = i + 1;
        }
        return arrCode;
    }
    [WebMethod(EnableSession = true)]
    public string[] Get_GeneralAsset(string prefixText, int count)
    {
        arrCode = new string[DsGeneralAsset.Select("Name like '" + prefixText + "%' ").Length];
        int i = 0;
        foreach (DataRow Dr in DsGeneralAsset.Select("Name like '" + prefixText + "%' "))
        {
            arrCode[i] = (Dr["Name"].ToString() + "~" + Dr["Code"].ToString());
            i = i + 1;
        }
        return arrCode;
    }

    [WebMethod(EnableSession = true)]
    public string[] Get_FixAsset(string prefixText, int count)
    {
        arrCode = new string[DsFixAsset.Select("Name like '" + prefixText + "%'  or  Code like '" + prefixText + "%' ").Length];

        int i = 0;
        foreach (DataRow Dr in DsFixAsset.Select("Name like '" + prefixText + "%'  or  Code like '" + prefixText + "%' "))
        {
            arrCode[i] = (Dr["Name"].ToString() + "~" + Dr["Code"].ToString());
            i = i + 1;
        }
        return arrCode;
    }

    [WebMethod(EnableSession = true)]
    public string[] GetCustomer(string prefixText, int count)
    {
        arrCode = new string[DsCustomer.Select("Name like '" + prefixText + "%'  or  Code like '" + prefixText + "%' ").Length];

        int i = 0;
        foreach (DataRow Dr in DsCustomer.Select("Name like '" + prefixText + "%'  or  Code like '" + prefixText + "%' "))
        {
            arrCode[i] = (Dr["Name"].ToString() + "~" + Dr["Code"].ToString());
            i = i + 1;
        }
        return arrCode;
    }
    [WebMethod(EnableSession = true)]
    public string[] GetLocation(string prefixText, int count)
    {

        arrCode = new string[DsLocation.Select("Name like '" + prefixText + "%'  or  Code like '" + prefixText + "%' ").Length];

        int i = 0;
        foreach (DataRow Dr in DsLocation.Select("Name like '" + prefixText + "%'  or  Code like '" + prefixText + "%' "))
        {
            arrCode[i] = (Dr["Name"].ToString() + "~" + Dr["Code"].ToString());
            i = i + 1;
        }
        return arrCode;
    }
     [WebMethod(EnableSession = true)]
    public string[] GetLocationNew(string prefixText, int count)
    {
        arrCode = new string[DsLocation.Select("Name like '" + prefixText + "%'  or  Code like '" + prefixText + "%' ").Length];

        int i = 0;
        foreach (DataRow Dr in DsLocation.Select("Name like '" + prefixText + "%'  or  Code like '" + prefixText + "%' "))
        {
            arrCode[i] = (Dr["Name"].ToString());
            i = i + 1;
        }
        return arrCode;
    }
    [WebMethod(EnableSession = true)]
    public string[] GetLocationCodeNew(string prefixText, int count)
    {
        arrCode = new string[DsLocation.Select("Name like '" + prefixText + "%'  or  Code like '" + prefixText + "%' ").Length];

        int i = 0;
        foreach (DataRow Dr in DsLocation.Select("Name like '" + prefixText + "%'  or  Code like '" + prefixText + "%' "))
        {
            arrCode[i] = (Dr["Code"].ToString());
            i = i + 1;
        }
        return arrCode;
    }
    [WebMethod(EnableSession = true)]
    public string[] GetAcccode(string prefixText, int count)
    {
        arrCode = new string[DsAcccode.Select("Name like '" + prefixText + "%' or  Code like '" + prefixText + "%' ").Length];

        int i = 0;
        foreach (DataRow Dr in DsAcccode.Select("Name like '" + prefixText + "%' or  Code like '" + prefixText + "%'  "))
        {
            arrCode[i] = (Dr["Name"].ToString() + "~" + Dr["Code"].ToString());
            i = i + 1;
        }
        return arrCode;
    }

    [WebMethod(EnableSession = true)]
    public string[] GetOctroiVendor(string prefixText, int count)
    {
        arrCode = new string[DsOctVendor.Select("Name like '" + prefixText + "%' ").Length];

        int i = 0;
        foreach (DataRow Dr in DsOctVendor.Select("Name like '" + prefixText + "%' "))
        {
            arrCode[i] = (Dr["Name"].ToString() + "~" + Dr["Code"].ToString());
            i = i + 1;
        }
        return arrCode;
    }
    [WebMethod(EnableSession = true)]
    public string[] GetDriverName(string prefixText, int count)
    {
        arrCode = new string[DsDrivName.Select("Name like '" + prefixText + "%'  or  Code like '" + prefixText + "%' ").Length];

        int i = 0;
        foreach (DataRow Dr in DsDrivName.Select("Name like '" + prefixText + "%'  or  Code like '" + prefixText + "%' "))
        {
            arrCode[i] = (Dr["Name"].ToString() + "~" + Dr["Code"].ToString());
            i = i + 1;
        }
        return arrCode;
    }
    [WebMethod(EnableSession = true)]
    public string[] GetVendorName(string prefixText, int count)
    {
        arrCode = new string[DsVendorName.Select("Name like '" + prefixText + "%' ").Length];

        int i = 0;
        foreach (DataRow Dr in DsVendorName.Select("Name like '" + prefixText + "%' "))
        {
            arrCode[i] = (Dr["Name"].ToString());
            i = i + 1;
        }
        return arrCode;
    }
    [WebMethod(EnableSession = true)]
    public string[] GetVendorName_Gatepass(string prefixText, int count)
    {
        arrCode = new string[DsVendorName.Select("Name like '" + prefixText + "%' ").Length];

        int i = 0;
        foreach (DataRow Dr in DsVendorName.Select("Name like '" + prefixText + "%' "))
        {
            arrCode[i] = (Dr["Name"].ToString() + "~" + Dr["Code"].ToString());
            i = i + 1;
        }
        return arrCode;
    }
    [WebMethod(EnableSession = true)]
    public string[] GetSpareParts(string prefixText, int count)
    {
        arrCode = new string[DsSpareParts.Select("Name like '" + prefixText + "%' ").Length];
        int i = 0;
        foreach (DataRow Dr in DsSpareParts.Select("Name like '" + prefixText + "%' "))
        {
            arrCode[i] = (Dr["Name"].ToString() + "~" + Dr["Code"].ToString());
            i = i + 1;
        }
        return arrCode;
    }
    [WebMethod(EnableSession = true)]
    public string[] GetTyreModel(string prefixText, int count)
    {
        arrCode = new string[DsTyreModel.Select("Name like '" + prefixText + "%' ").Length];

        int i = 0;
        foreach (DataRow Dr in DsTyreModel.Select("Name like '" + prefixText + "%' "))
        {
            arrCode[i] = (Dr["Name"].ToString() + "~" + Dr["Code"].ToString());
            i = i + 1;
        }
        return arrCode;
    }
    [WebMethod(EnableSession = true)]
    public string[] GetTyreMFG(string prefixText, int count)
    {
        arrCode = new string[DsTyreMFG.Select("Name like '" + prefixText + "%' ").Length];

        int i = 0;
        foreach (DataRow Dr in DsTyreMFG.Select("Name like '" + prefixText + "%' "))
        {
            arrCode[i] = (Dr["Name"].ToString() + "~" + Dr["Code"].ToString());
            i = i + 1;
        }
        return arrCode;
    }
    [WebMethod(EnableSession = true)]
    public string[] GetTyreSize(string prefixText, int count)
    {
        arrCode = new string[DsTyreSize.Select("Name like '" + prefixText + "%' ").Length];

        int i = 0;
        foreach (DataRow Dr in DsTyreSize.Select("Name like '" + prefixText + "%' "))
        {
            arrCode[i] = (Dr["Name"].ToString() + "~" + Dr["Code"].ToString());
            i = i + 1;
        }
        return arrCode;
    }

    [WebMethod(EnableSession = true)]
    public string[] GetTyrePatten(string prefixText, int count)
    {
        arrCode = new string[DsTyrePatten.Select("Name like '" + prefixText + "%' ").Length];

        int i = 0;
        foreach (DataRow Dr in DsTyrePatten.Select("Name like '" + prefixText + "%' "))
        {
            arrCode[i] = (Dr["Name"].ToString() + "~" + Dr["Code"].ToString());
            i = i + 1;
        }
        return arrCode;
    }

    [WebMethod(EnableSession = true)]
    public string[] GetServiceWiseCustomer(string prefixText, int count)
    {
        arrCode = new string[DsServiceWiseCustomer.Select("Name like '" + prefixText + "%' ").Length];
        int i = 0;
        foreach (DataRow Dr in DsServiceWiseCustomer.Select("Name like '" + prefixText + "%' "))
        {
            arrCode[i] = (Dr["Name"].ToString() + "~" + Dr["Code"].ToString());
            i = i + 1;
        }
        return arrCode;
    }
    //************** created by vidya
    /// <summary>
    /// use for smart search in Tyre issue module
    /// </summary>
    /// <param name="prefixText"></param>
    /// <param name="count"></param>
    /// <returns></returns>
    [WebMethod(EnableSession = true)]
    public string[] AutoVhNo(string prefixText, int count)
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        SqlDataAdapter ad = null;
        DataSet ds = new DataSet();

        ad = new SqlDataAdapter("USP_Auto_VhNo", con);
        ad.SelectCommand.CommandType = CommandType.StoredProcedure;
        ad.SelectCommand.Parameters.AddWithValue("@VhNo", prefixText);
        DataTable dt = new DataTable();
        ad.Fill(dt);

        string[] items = new string[dt.Rows.Count];
        int i = 0;
        foreach (DataRow dr in dt.Rows)
        {
            items.SetValue(dr[0].ToString(), i);
            i++;

        }
        return items;
        con.Close();
    }

    

    [WebMethod(EnableSession = true)]
    public string[] Get_City(string prefixText, int count)
    {
        arrCode = null;
        int cnt = DsGetCityCd.Select("Name like '" + prefixText + "%'").Length;
        arrCode = new string[DsGetCityCd.Select("Name like '" + prefixText + "%'  or  Code like '" + prefixText + "%'").Length];

        int i = 0;
        foreach (DataRow Dr in DsGetCityCd.Select("Name like '" + prefixText + "%'  or  Code like '" + prefixText + "%'    "))
        {
            arrCode[i] = (Dr["Name"].ToString() + ":" + Dr["Code"].ToString());
            i = i + 1;
        }
        return arrCode; 
    }
    [WebMethod(EnableSession = true)]
    public string[] Get_CityNew(string prefixText, int count)
    {
        arrCode1 = null;
        int cnt = DsGetCityCd.Select("Name like '" + prefixText + "%'").Length;
        arrCode1 = new string[DsGetCityCd.Select("Name like '" + prefixText + "%'").Length];

        int i = 0;
        foreach (DataRow Dr in DsGetCityCd.Select("Name like '" + prefixText + "%'"))
        {
            arrCode1[i] = (Dr["Name"].ToString());
            i = i + 1;
        }
        return arrCode1;
    }
    [WebMethod(EnableSession = true)]
    public string[] Get_MaterialDetails(string prefixText, int count)
    {
        arrCode = new string[DsMaterialDetails.Select("Name like '" + prefixText + "%' ").Length];

        int i = 0;
        foreach (DataRow Dr in DsMaterialDetails.Select("Name like '" + prefixText + "%' "))
        {
            arrCode[i] = (Dr["Name"].ToString() + "~" + Dr["Code"].ToString());
            i = i + 1;
        }
        return arrCode;
    }

    [WebMethod(EnableSession = true)]
    public string[] GetVehicleMaster(string prefixText, int count)
    {
        arrCode = new string[DsVehicleMaster.Select("Name like '" + prefixText + "%'  or  Code like '" + prefixText + "%' ").Length];

        int i = 0;
        foreach (DataRow Dr in DsVehicleMaster.Select("Name like '" + prefixText + "%'  or  Code like '" + prefixText + "%' "))
        {
            arrCode[i] = (Dr["Name"].ToString());
            i = i + 1;
        }
        return arrCode;
    }

    //************* Added by Mayank *******************
    [WebMethod(EnableSession = true)]
    public string[] GetVehicleOpenTripsheet(string prefixText, int count)
    {
        arrCode = new string[DsVehicleOpenTripsheet.Select("Name like '" + prefixText + "%'  or  Code like '" + prefixText + "%' ").Length];

        int i = 0;
        foreach (DataRow Dr in DsVehicleOpenTripsheet.Select("Name like '" + prefixText + "%'  or  Code like '" + prefixText + "%' "))
        {
            arrCode[i] = (Dr["Name"].ToString());
            i = i + 1;
        }
        return arrCode;
    }
    //********************************

    [WebMethod(EnableSession = true)]
    public string[] GetVendorFuel(string prefixText, int count)
    {
        arrCode = new string[DsVendorFuel.Select("Name like '" + prefixText + "%'  or  Code like '" + prefixText + "%' ").Length];

        int i = 0;
        foreach (DataRow Dr in DsVendorFuel.Select("Name like '" + prefixText + "%'  or  Code like '" + prefixText + "%' "))
        {
            arrCode[i] = (Dr["Name"].ToString() + "~" + Dr["Code"].ToString());
            i = i + 1;
        }
        return arrCode;
    }

    //***************** STANDARD EXP FOR FIXED ROUTE******************
    [WebMethod(EnableSession = true)]
    public string[] GetRouteNo(string prefixText, int count)
    {
        arrCode = new string[DsRouteNo.Select("Code like '" + prefixText + "%' ").Length];

        int i = 0;
        foreach (DataRow Dr in DsRouteNo.Select("Code like '" + prefixText + "%' "))
        {
            arrCode[i] = (Dr["Code"].ToString());
            i = i + 1;
        }
        return arrCode;
    }


    [WebMethod(EnableSession = true)]
    public string[] GetAllVehicle(string prefixText, int count)
    {
        arrCode = new string[DsGetAllVehicle.Select("Code like '" + prefixText + "%' ").Length];

        int i = 0;
        foreach (DataRow Dr in DsGetAllVehicle.Select("Code like '" + prefixText + "%' "))
        {
            arrCode[i] = (Dr["Code"].ToString());
            i = i + 1;
        }
        return arrCode;
    } 
    //****************************************************************

    /// <summary>
    /// use for smart search in Tyre issue module
    /// </summary>
    /// <param name="prefixText"></param>
    /// <param name="count"></param>
    /// <returns></returns>
    [WebMethod(EnableSession = true)]
    public string[] AutoVendor(string prefixText, int count)
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        SqlDataAdapter ad = null;
        DataSet ds = new DataSet();

        ad = new SqlDataAdapter("USP_AutoVendor", con);
        ad.SelectCommand.CommandType = CommandType.StoredProcedure;
        ad.SelectCommand.Parameters.AddWithValue("@Vendor", prefixText);
        DataTable dt = new DataTable();
        ad.Fill(dt);

        string[] items = new string[dt.Rows.Count];
        int i = 0;
        foreach (DataRow dr in dt.Rows)
        {
            items.SetValue(dr[0].ToString(), i);
            i++;
        }
        return items;
        con.Close();
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="prefixText"></param>
    /// <param name="count"></param>
    /// <returns></returns>
    [WebMethod(EnableSession = true)]
    public string[] AutoBILLNO(string prefixText, int count)
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        SqlDataAdapter ad = null;
        DataSet ds = new DataSet();

        ad = new SqlDataAdapter("USP_BILLNO", con);
        ad.SelectCommand.CommandType = CommandType.StoredProcedure;
        ad.SelectCommand.Parameters.AddWithValue("@BILLNO", prefixText);
        DataTable dt = new DataTable();
        ad.Fill(dt);

        string[] items = new string[dt.Rows.Count];
        int i = 0;
        foreach (DataRow dr in dt.Rows)
        {
            items.SetValue(dr[0].ToString(), i);
            i++;
        }
        return items;
        con.Close();
    }

    /// <summary>
    /// use for smart search in update remold tyre module
    /// </summary>
    /// <param name="prefixText"></param>
    /// <param name="count"></param>
    /// <returns></returns>
    [WebMethod(EnableSession = true)]
    public string[] AutoRemoldNo(string prefixText, int count)
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        SqlDataAdapter ad = null;
        DataSet ds = new DataSet();

        ad = new SqlDataAdapter("USP_AutoRemoldNo", con);
        ad.SelectCommand.CommandType = CommandType.StoredProcedure;
        ad.SelectCommand.Parameters.AddWithValue("@CLAIM_REMOLD_SALE_ID", prefixText);
        DataTable dt = new DataTable();
        ad.Fill(dt);

        string[] items = new string[dt.Rows.Count];
        int i = 0;
        foreach (DataRow dr in dt.Rows)
        {
            items.SetValue(dr[0].ToString(), i);
            i++;
        }
        return items;
        con.Close();
    }

    /// <summary>
    /// use for smart search in update claim tyre 
    /// </summary>
    /// <param name="prefixText"></param>
    /// <param name="count"></param>
    /// <returns></returns>
    [WebMethod(EnableSession = true)]
    public string[] AutoClaimNo(string prefixText, int count)
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        SqlDataAdapter ad = null;
        DataSet ds = new DataSet();

        ad = new SqlDataAdapter("USP_AutoClaimNo", con);
        ad.SelectCommand.CommandType = CommandType.StoredProcedure;
        ad.SelectCommand.Parameters.AddWithValue("@CLAIM_REMOLD_SALE_ID", prefixText);
        DataTable dt = new DataTable();
        ad.Fill(dt);

        string[] items = new string[dt.Rows.Count];
        int i = 0;
        foreach (DataRow dr in dt.Rows)
        {
            items.SetValue(dr[0].ToString(), i);
            i++;
        }
        return items;
        con.Close();
    }
    //**********End
	
    /// <summary>
    /// use for smart search in Location Master 
    /// </summary>
    [WebMethod(EnableSession = true)]
    public string[] GetUser(string prefixText, int count)
    {
        arrCode = new string[DsUser.Select("Name like '" + prefixText + "%' or  UserId like '" + prefixText + "%'  ").Length];

        int i = 0;
        foreach (DataRow Dr in DsUser.Select("Name like '" + prefixText + "%' or  UserId like '" + prefixText + "%' "))
        {            
            arrCode[i] = (Dr["Name"].ToString() + "~" + Dr["UserId"].ToString());
            i = i + 1;
        }
        return arrCode;
    }

}
