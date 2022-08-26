using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;
using System.Web.Services;
using System.Web.Services.Protocols;
using Microsoft.ApplicationBlocks.Data;
using System.Web.Script.Services;
using System.ServiceModel.Web;
using Newtonsoft.Json;
using System.Web.Script.Serialization;
using Microsoft.Web.UI.Controls;
using WebX.Entity;
using WebX.Controllers;  
/// <summary>
/// Summary description for AutoComplete
/// </summary>
[WebService(Namespace = "http://www.15seconds.com/articles/robchartier/guid",
Description = "Generate a GUID, to be used with UDDI for failover example")]
public class GuidGenerator
{
    [WebMethod(Description = "Generate the GUID")]
    public string GetGuid()
    {
        return System.Guid.NewGuid().ToString();
    }
}

[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[System.Web.Script.Services.ScriptService]
public class AutoComplete : System.Web.Services.WebService
{

    public AutoComplete()
    {
        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebService(Namespace = "http://www.15seconds.com/articles/robchartier/guid",
    Description = "Generate a GUID, to be used with UDDI for failover example")]
    public class GuidGenerator
    {
        [WebMethod(Description = "Generate the GUID")]
        public string GetGuid()
        {
            return System.Guid.NewGuid().ToString();
        }
    }
    /// <summary>
    /// ////////FOR RECEIPT TYPE ////////////
    /// </summary>
    [WebMethod(EnableSession = true)]
    public string[] GetBlogTitlesForAutoComplete(string prefixText, int count)
    {
        ArrayList _blog_titles = new ArrayList();

        // SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        SqlCommand cmd = new SqlCommand("wms_generate_select_data", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        String TableName, Wherecls, OrderBy;
        TableName = "WMS_RECPT_TYPE";

        Wherecls = "RECPT_NAME like '" + prefixText + "%'";
        OrderBy = "RECPT_NAME";
        cmd.Parameters.AddWithValue("@TableName", TableName);

        cmd.Parameters.AddWithValue("@Wherecls", Wherecls);
        cmd.Parameters.AddWithValue("@OrderBy  ", OrderBy);

        SqlDataReader dtr;
        cmd.Connection.Open();
        dtr = cmd.ExecuteReader();
        while (dtr.Read())
        {
            string mystr = "";
            mystr = dtr["RECPT_NAME"].ToString().TrimEnd();
            _blog_titles.Add(mystr);
        }
        dtr.Close();
        cmd.Connection.Close();

        String[] arrBlogTitles = (String[])_blog_titles.ToArray(Type.GetType("System.String"));

        return arrBlogTitles;
    }

    [WebMethod(EnableSession = true)]
    public string[] getpartyList(string prefixText)
    {
        string branchcode = HttpContext.Current.Session["brcd"].ToString();
        DataSet dtst = new DataSet();
        SqlConnection sqlCon = new SqlConnection(HttpContext.Current.Session["SqlProvider"].ToString());
        string strSql = "SELECT custcd FROM webx_custhdr WHERE PATINDEx ('%" + prefixText + "%',custloc)>0";
        SqlCommand sqlComd = new SqlCommand(strSql, sqlCon);
        sqlCon.Open();
        SqlDataAdapter sqlAdpt = new SqlDataAdapter();
        sqlAdpt.SelectCommand = sqlComd;
        sqlAdpt.Fill(dtst);
        string[] cntName = new string[dtst.Tables[0].Rows.Count];
        int i = 0;

        try
        {
            foreach (DataRow rdr in dtst.Tables[0].Rows)
            {
                cntName.SetValue(rdr["custcd"].ToString(), i);
                i++;
            }
        }
        catch { }
        finally
        {
            sqlCon.Close();

        }
        return cntName;
    }

    [WebMethod(EnableSession = true)]
    public string[] GetVenderAutoComplete(string prefixText, int count)
    {
        ArrayList _blog_titles = new ArrayList();

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        SqlCommand cmd = new SqlCommand("wms_generate_select_data", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        String TableName, Wherecls, OrderBy;
        TableName = "WMS_VENDOR_HDR";

        Wherecls = "VEND_CODE like '" + prefixText + "%'";
        OrderBy = "VEND_NAME";
        cmd.Parameters.AddWithValue("@TableName", TableName);

        cmd.Parameters.AddWithValue("@Wherecls", Wherecls);
        cmd.Parameters.AddWithValue("@OrderBy  ", OrderBy);

        SqlDataReader dtr;
        cmd.Connection.Open();
        dtr = cmd.ExecuteReader();
        while (dtr.Read())
        {
            string mystr = "";
            string venderNm = "";
            mystr = dtr["VEND_CODE"].ToString().TrimEnd();
            venderNm = dtr["VEND_NAME"].ToString().TrimEnd();
            _blog_titles.Add(mystr + " " + venderNm);
        }
        cmd.Connection.Close();

        String[] arrBlogTitles = (String[])_blog_titles.ToArray(Type.GetType("System.String"));

        return arrBlogTitles;
    }

    /// <summary>
    /// ////////CARRIER TYPE ////////////
    /// </summary>
    [WebMethod(EnableSession = true)]
    public string[] GetCarrirAutoComplete(string prefixText, int count)
    {
        ArrayList _blog_titles = new ArrayList();

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        SqlCommand cmd = new SqlCommand("wms_generate_select_data", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        String TableName, Wherecls, OrderBy;
        TableName = "WMS_CARRIER_HDR";

        Wherecls = "CARRIER_CODE like '" + prefixText + "%'";
        OrderBy = "CARRIER_CODE";
        cmd.Parameters.AddWithValue("@TableName", TableName);

        cmd.Parameters.AddWithValue("@Wherecls", Wherecls);
        cmd.Parameters.AddWithValue("@OrderBy  ", OrderBy);

        SqlDataReader dtr;
        cmd.Connection.Open();
        dtr = cmd.ExecuteReader();
        while (dtr.Read())
        {
            string mystr = "";
            string venderNm = "";
            mystr = dtr["CARRIER_CODE"].ToString().TrimEnd();
            venderNm = dtr["CARRIER_NAME"].ToString().TrimEnd();
            _blog_titles.Add(mystr + " " + venderNm);
        }
        cmd.Connection.Close();

        String[] arrBlogTitles = (String[])_blog_titles.ToArray(Type.GetType("System.String"));

        return arrBlogTitles;
    }
    /// <summary>
    /// ////////FOR SKU ////////////
    /// </summary>
    [WebMethod(EnableSession = true)]
    public string[] GetSKUAutoComplete(string prefixText, int count)
    {
        ArrayList _blog_titles = new ArrayList();

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        SqlCommand cmd = new SqlCommand("wms_generate_select_data", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        String TableName, Wherecls, OrderBy;
        TableName = "WMS_SKU_HDR";

        Wherecls = "SKU_CODE like '" + prefixText + "%'";
        OrderBy = "SKU_CODE";
        cmd.Parameters.AddWithValue("@TableName", TableName);
        cmd.Parameters.AddWithValue("@Wherecls", Wherecls);
        cmd.Parameters.AddWithValue("@OrderBy  ", OrderBy);

        SqlDataReader dtr;
        cmd.Connection.Open();
        dtr = cmd.ExecuteReader();
        while (dtr.Read())
        {
            string mystr = "";
            string venderNm = "";
            mystr = dtr["SKU_CODE"].ToString().TrimEnd();
            venderNm = dtr["SKU_NAME"].ToString().TrimEnd();
            //_blog_titles.Add(mystr + " " + venderNm);
            _blog_titles.Add(mystr);
        }
        cmd.Connection.Close();

        String[] arrBlogTitles = (String[])_blog_titles.ToArray(Type.GetType("System.String"));

        return arrBlogTitles;
    }
    /// <summary>
    /// ////////FOR RECEIPT NO////////////
    /// </summary>
    [WebMethod(EnableSession = true)]
    public string[] GetRECEIPT_CODE(string prefixText, int count)
    {
        ArrayList _blog_titles = new ArrayList();

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        SqlCommand cmd = new SqlCommand("wms_select_receiptNo", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        String TableName, Wherecls, OrderBy;
        TableName = "WMS_RECPTDUE_HDR";

        Wherecls = "RECPT_CODE like '" + prefixText + "%'";
        OrderBy = "RECPT_CODE";
        cmd.Parameters.AddWithValue("@TableName", TableName);
        cmd.Parameters.AddWithValue("@Wherecls", Wherecls);
        cmd.Parameters.AddWithValue("@OrderBy  ", OrderBy);

        SqlDataReader dtr;
        cmd.Connection.Open();
        dtr = cmd.ExecuteReader();
        while (dtr.Read())
        {
            string mystr = "";
            string venderNm = "";
            mystr = dtr["RECPT_CODE"].ToString().TrimEnd();
            //venderNm = dtr["SKU_NAME"].ToString().TrimEnd();
            _blog_titles.Add(mystr);
        }
        cmd.Connection.Close();

        String[] arrBlogTitles = (String[])_blog_titles.ToArray(Type.GetType("System.String"));

        return arrBlogTitles;
    }

    // Customer List
    [WebMethod(EnableSession = true)]
    public string[] GetCustomerList2(string prefixText, int count)
    {
        ArrayList _blog_titles = new ArrayList();

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlCommand cmd = new SqlCommand("Webx_CUstomerList", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        String TableName, Wherecls, OrderBy;
        TableName = "webx_custhdr";

        Wherecls = "custnm like '" + prefixText + "%'";
        OrderBy = "custnm";
        cmd.Parameters.AddWithValue("@TableName", TableName);
        cmd.Parameters.AddWithValue("@Wherecls", Wherecls);
        cmd.Parameters.AddWithValue("@OrderBy  ", OrderBy);

        SqlDataReader dtr;
        // cmd.Connection.Open();
        dtr = cmd.ExecuteReader();
        while (dtr.Read())
        {
            string custcode = "";
            string custNm = "";
            custcode = dtr["custcd"].ToString().TrimEnd();
            custNm = dtr["custnm"].ToString().TrimEnd();

            _blog_titles.Add(custcode + "-" + custNm);

        }
        cmd.Connection.Close();

        String[] arrBlogTitles = (String[])_blog_titles.ToArray(Type.GetType("System.String"));

        return arrBlogTitles;
    }

    [WebMethod(EnableSession = true)]
    public string[] GetOrderList(string prefixText, int count)
    {
        ArrayList _blog_titles = new ArrayList();

        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["WMS"]);
        string sql = "select OrderNo from WMS_Trans_Order_Header with (NOLOCK) where Order_Status_Code='100'";
        SqlCommand cmd = new SqlCommand(sql, conn);

        string Wherecls = "OrderNo like '" + prefixText + "%'";
        string OrderBy = "OrderNo";

        SqlDataReader dtr;
        cmd.Connection.Open();
        dtr = cmd.ExecuteReader();
        while (dtr.Read())
        {
            string mystr = "";
            mystr = dtr["OrderNo"].ToString().TrimEnd();
            _blog_titles.Add(mystr);
        }
        cmd.Connection.Close();

        String[] arrBlogTitles = (String[])_blog_titles.ToArray(Type.GetType("System.String"));

        return arrBlogTitles;
    }
    [WebMethod(EnableSession = true)]
    public string[] GetDeliveryLocation(string prefixText, int count)
    {
        ArrayList arr = new ArrayList();
 
        SqlDataReader dtr;
        dtr = SqlHelper.ExecuteReader(Session["SqlProvider"].ToString().Trim(), CommandType.Text, "SELECT loccode FROM webx_location WITH(NOLOCK)  WHERE loccode LIKE '" + prefixText + "%' ORDER BY loccode");

        while (dtr.Read())
        {
            arr.Add(dtr["loccode"].ToString().TrimEnd());
        }
        

        String[] arrBlogTitles = (String[])arr.ToArray(Type.GetType("System.String"));

        
        return arrBlogTitles;
    }

    // Vehicle Master
    [WebMethod(EnableSession = true)]
    public string[] GetVehicleNumberList(string prefixText)
    {
        ArrayList arVehicleNumberList = new ArrayList();

        try
        {
            SqlDataReader drVehicleNumber;

            drVehicleNumber = SqlHelper.ExecuteReader(Session["SqlProvider"].ToString().Trim(), CommandType.Text, "Select vehno from webx_vehicle_hdr where vehno like '" + prefixText + "%' order by vehno");

            while (drVehicleNumber.Read())
            {
                arVehicleNumberList.Add(drVehicleNumber["vehno"].ToString().Trim().ToLower());
            }
            String[] arrBlogTitles = (String[])arVehicleNumberList.ToArray(Type.GetType("System.String"));

            return arrBlogTitles;
        }
        catch (Exception Exc)
        {
            String[] arrBlogTitles = new string[5];
            return arrBlogTitles;
        }
    }

    // Location Master
    [WebMethod(EnableSession = true)]
    public string[] GetLocationList(string prefixText)
    {
        ArrayList arVehicleNumberList = new ArrayList();

        try
        {
            SqlDataReader drVehicleNumber;

            // drVehicleNumber = SqlHelper.ExecuteReader(Session["SqlProvider"].ToString().Trim(), CommandType.Text, "SELECT loccode + ' : ' + locname as Location FROM webx_Location where activeflag='Y' AND  loccode like '" + prefixText + "%' order by locname");
            drVehicleNumber = SqlHelper.ExecuteReader(Session["SqlProvider"].ToString().Trim(), CommandType.Text, "SELECT loccode, locname FROM webx_Location where activeflag='Y' AND  loccode like '" + prefixText + "%' order by locname");

            while (drVehicleNumber.Read())
            {
                arVehicleNumberList.Add(drVehicleNumber["loccode"].ToString().TrimEnd());
                // arVehicleNumberList.Add(drVehicleNumber["Location"].ToString().TrimEnd());
            }
            String[] arrBlogTitles = (String[])arVehicleNumberList.ToArray(Type.GetType("System.String"));

            return arrBlogTitles;
        }
        catch (Exception Exc)
        {
            String[] arrBlogTitles = new string[5];
            return arrBlogTitles;
        }
    }

    // Employee Master
    [WebMethod(EnableSession = true)]
    public string[] GetEmployeeList(string prefixText)
    {
        ArrayList arEmployeeList = new ArrayList();

        try
        {
            SqlDataReader drEmployeeList;

            drEmployeeList = SqlHelper.ExecuteReader(Session["SqlProvider"].ToString().Trim(), CommandType.Text, "SELECT  empid FROM WEBX_MASTER_USERS WHERE empid LIKE '" + prefixText + "%' ORDER BY empid");

            while (drEmployeeList.Read())
            {
                arEmployeeList.Add(drEmployeeList["empid"].ToString().TrimEnd());
            }
            String[] arrBlogTitles = (String[])arEmployeeList.ToArray(Type.GetType("System.String"));

            return arrBlogTitles;
        }
        catch (Exception Exc)
        {
            String[] arrBlogTitles = new string[5];
            return arrBlogTitles;
        }
    }

    // User List
    [WebMethod(EnableSession = true)]
    public string[] GetUserList(string prefixText)
    {
        ArrayList arUserList = new ArrayList();

        try
        {
            SqlDataReader drUserList;

            drUserList = SqlHelper.ExecuteReader(Session["SqlProvider"].ToString().Trim(), CommandType.Text, "SELECT userid FROM WEBX_MASTER_USERS WHERE userid LIKE '" + prefixText + "%' ORDER BY userid");

            while (drUserList.Read())
            {
                arUserList.Add(drUserList["userid"].ToString().TrimEnd());
            }
            String[] arrBlogTitles = (String[])arUserList.ToArray(Type.GetType("System.String"));

            return arrBlogTitles;
        }
        catch (Exception Exc)
        {
            String[] arrBlogTitles = new string[5];
            return arrBlogTitles;
        }
    }

    // Customer Master
    [WebMethod(EnableSession = true)]
    public string[] GetCustomerList(string prefixText)
    {
        ArrayList arCustomerList = new ArrayList();

        try
        {
            SqlDataReader drCustomerList;

            drCustomerList = SqlHelper.ExecuteReader(Session["SqlProvider"].ToString().Trim(), CommandType.Text, "SELECT custcd FROM webx_CUSTHDR WHERE CUSTCd like '" + prefixText + "%' ORDER BY CUSTCd");

            while (drCustomerList.Read())
            {
                arCustomerList.Add(drCustomerList["custcd"].ToString().TrimEnd());
            }
            String[] arrBlogTitles = (String[])arCustomerList.ToArray(Type.GetType("System.String"));

            return arrBlogTitles;
        }
        catch (Exception Exc)
        {
            String[] arrBlogTitles = new string[5];
            return arrBlogTitles;
        }
    }

    // City Master
    [WebMethod(EnableSession = true)]
    public string[] GetCityLocationList(string prefixText)
    {
        ArrayList arCityLocationList = new ArrayList();

        try
        {
            SqlDataReader drCityLocationList;

            drCityLocationList = SqlHelper.ExecuteReader(Session["SqlProvider"].ToString().Trim(), CommandType.Text, "SELECT Location FROM  webx_citymaster where Location like '" + prefixText + "%' order by Location");

            while (drCityLocationList.Read())
            {
                arCityLocationList.Add(drCityLocationList["Location"].ToString().TrimEnd());
            }
            String[] arrBlogTitles = (String[])arCityLocationList.ToArray(Type.GetType("System.String"));

            return arrBlogTitles;
        }
        catch (Exception Exc)
        {
            String[] arrBlogTitles = new string[5];
            return arrBlogTitles;
        }
    }

    // Vendor Master
    [WebMethod(EnableSession = true)]
    public string[] GetVendorList(string prefixText)
    {
        ArrayList arVendorList = new ArrayList();

        try
        {
            SqlDataReader drVendorList;

            drVendorList = SqlHelper.ExecuteReader(Session["SqlProvider"].ToString().Trim(), CommandType.Text, "SELECT VENDORCODE FROM webx_VENDOR_HDR WHERE VENDORCODE like '" + prefixText + "%' ORDER BY VENDORCODE");

            while (drVendorList.Read())
            {
                arVendorList.Add(drVendorList["VENDORCODE"].ToString().TrimEnd());
            }
            String[] arrBlogTitles = (String[])arVendorList.ToArray(Type.GetType("System.String"));

            return arrBlogTitles;
        }
        catch (Exception Exc)
        {
            String[] arrBlogTitles = new string[5];
            return arrBlogTitles;
        }
    }

    // Route Master
    [WebMethod(EnableSession = true)]
    public string[] GetRouteList(string prefixText)
    {
        ArrayList arRouteList = new ArrayList();

        try
        {
            SqlDataReader drRouteList;

            drRouteList = SqlHelper.ExecuteReader(Session["SqlProvider"].ToString().Trim(), CommandType.Text, "SELECT * FROM webx_rutmas WHERE RUTCD like '" + prefixText + "%' ORDER BY RUTCD");

            while (drRouteList.Read())
            {
                arRouteList.Add(drRouteList["RUTCD"].ToString().TrimEnd());
            }
            String[] arrBlogTitles = (String[])arRouteList.ToArray(Type.GetType("System.String"));

            return arrBlogTitles;
        }
        catch (Exception Exc)
        {
            String[] arrBlogTitles = new string[5];
            return arrBlogTitles;
        }
    }

    // City Route Master
    [WebMethod(EnableSession = true)]
    public string[] GetCityRouteList(string prefixText)
    {
        ArrayList arRouteList = new ArrayList();

        try
        {
            SqlDataReader drRouteList;

            drRouteList = SqlHelper.ExecuteReader(Session["SqlProvider"].ToString().Trim(), CommandType.Text, "SELECT * FROM webx_rutmas_city WHERE RUTCD like '" + prefixText + "%' ORDER BY RUTCD");

            while (drRouteList.Read())
            {
                arRouteList.Add(drRouteList["RUTCD"].ToString().TrimEnd());
            }
            String[] arrBlogTitles = (String[])arRouteList.ToArray(Type.GetType("System.String"));

            return arrBlogTitles;
        }
        catch (Exception Exc)
        {
            String[] arrBlogTitles = new string[5];
            return arrBlogTitles;
        }
    }

    [WebMethod(EnableSession = true)]
    public string[] GetFUelCity(string prefixText)
    {
        int count = 10;

        string sql = "select Code,Name From  VWFuelRateMSTCheckAuto Where Name like @prefixText or Code like @prefixText order by Name";
        SqlDataAdapter da = new SqlDataAdapter(sql, Session["SqlProvider"].ToString().Trim());
        da.SelectCommand.Parameters.Add("@prefixText", SqlDbType.VarChar, 50).Value = prefixText + "%";
        DataTable dt = new DataTable();
        da.Fill(dt);
        string[] items = new string[dt.Rows.Count];
        int i = 0;
        foreach (DataRow dr in dt.Rows)
        {
            items.SetValue(dr["Name"].ToString(), i);
            i++;
        }
        return items;
    }

    // Customer Group Code List
    [WebMethod(EnableSession = true)]
    public string[] GetCustomerGroupCodeList(string prefixText)
    {
        ArrayList arCustomerGroupCodeList = new ArrayList();

        try
        {
            SqlDataReader drCustomerGroupCodeList;

            drCustomerGroupCodeList = SqlHelper.ExecuteReader(Session["SqlProvider"].ToString().Trim(), CommandType.Text, "SELECT GRPCD  FROM  webx_GRPMST WHERE GRPCD like '" + prefixText + "%' ORDER BY GRPCD");

            while (drCustomerGroupCodeList.Read())
            {
                arCustomerGroupCodeList.Add(drCustomerGroupCodeList["GRPCD"].ToString().TrimEnd());
            }
            String[] arrBlogTitles = (String[])arCustomerGroupCodeList.ToArray(Type.GetType("System.String"));

            return arrBlogTitles;
        }
        catch (Exception Exc)
        {
            String[] arrBlogTitles = new string[5];
            return arrBlogTitles;
        }
    }

    //************** added by vidya on 21 May 20 Sep 2014
    /// <summary>
    /// use for smart search in Tyre issue module
    /// </summary>
    /// <param name="prefixText"></param>
    /// <param name="count"></param>
    /// <returns></returns>
    /// 
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
    /// use for smart search in Tyre issue module
    /// </summary>
    /// <param name="prefixText"></param>
    /// <param name="count"></param>
    /// <returns></returns>
    [WebMethod(EnableSession = true)]
    public string[] AutoOtherVendorThc(string prefixText, int count)
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        SqlDataAdapter ad = null;
        DataSet ds = new DataSet();

        ad = new SqlDataAdapter("USP_AutoOtherVendorThc", con);
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


    //// Customer Group Code List
    //[WebMethod(EnableSession = true)]
    //public string[] GetLocationList1(string prefixText)
    //{
    //    ArrayList arVehicleNumberList = new ArrayList();

    //    try
    //    {
    //        SqlDataReader drVehicleNumber;

    //        // drVehicleNumber = SqlHelper.ExecuteReader(Session["SqlProvider"].ToString().Trim(), CommandType.Text, "SELECT loccode + ' : ' + locname as Location FROM webx_Location where activeflag='Y' AND  loccode like '" + prefixText + "%' order by locname");
    //        drVehicleNumber = SqlHelper.ExecuteReader(Session["SqlProvider"].ToString().Trim(), CommandType.Text, "SELECT loccode, locname FROM webx_Location where activeflag='Y' AND  loccode like '" + prefixText + "%' order by locname");

    //        while (drVehicleNumber.Read())
    //        {
    //            arVehicleNumberList.Add(drVehicleNumber["loccode"].ToString().TrimEnd());
    //            // arVehicleNumberList.Add(drVehicleNumber["Location"].ToString().TrimEnd());
    //        }
    //        String[] arrBlogTitles = (String[])arVehicleNumberList.ToArray(Type.GetType("System.String"));

    //        return arrBlogTitles;
    //    }
    //    catch (Exception Exc)
    //    {
    //        String[] arrBlogTitles = new string[5];
    //        return arrBlogTitles;
    //    }
    //} 
    //[WebMethod(EnableSession = true)]
    //public string GetCustomerList1(string locationCode, string customerCode)
    //{
    //    var strReturn = "";
    //    var list = new List<NameValue>();
    //    try
    //    {
    //        string strsql = "SELECT custcd,custnm,custloc FROM webx_custhdr";
    //        strsql = strsql + " WHERE (custcd LIKE '" + customerCode + "%' OR custnm LIKE '" + customerCode + "%'";
    //        strsql = strsql + " OR custnm LIKE '% " + customerCode + "%')";
    //        strsql = strsql + " AND custcd NOT IN ('8888','P018888','P028888','P038888','P048888')";
    //        if (locationCode.CompareTo("") != 0)
    //        { strsql = strsql + " AND PATINDEx ('%" + locationCode + "%',custloc)>0 "; }
    //        var dtResult = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];
    //        for (int i = 0; i < dtResult.Rows.Count; i++)
    //        {
    //            var oNameValue = new NameValue();
    //            var dr = dtResult.Rows[i];
    //            oNameValue.Value = dr["custcd"].ToString();
    //            oNameValue.Name = dr["custnm"].ToString();
    //            list.Add(oNameValue);
    //        }
    //        strReturn = JsonConvert.SerializeObject(list);
    //    }
    //    catch
    //    {
    //        strReturn = "";
    //    }
    //    return strReturn;
    //}
    [WebMethod(EnableSession = true)]
    public string GetCustomerList1(string locationCode, string customerCode)
    {
        var list = new List<NameValue>();
        var strReturn = "";
        try
        {
            var sqlPrm = new SqlParameter[2];
            sqlPrm[0] = new SqlParameter("@CustomerCode", customerCode);
            sqlPrm[1] = new SqlParameter("@LocCode", locationCode);
            var dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "Usp_Get_Customer_List", sqlPrm).Tables[0];

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var oNameValue = new NameValue();
                var dr = dt.Rows[i];
                oNameValue.Value = dr["custcd"].ToString();
                oNameValue.Name = dr["custnm"].ToString();
                list.Add(oNameValue);
            }
            strReturn = JsonConvert.SerializeObject(list);
        }
        catch
        {
            strReturn = "";
        }
        return strReturn;
    }

    [Serializable]
    public class NameValue
    {
        private string _name = "", _value = "", _display = "";
        public string Name { get { return _name; } set { _name = value; } }
        public string Value { get { return _value; } set { _value = value; } }
        public string Display { get { return _display; } set { _display = value; } }
    }
    [Serializable]
    public class CustomerAddressDetails
    {
        public CustomerAddressDetails()
        {
            Code = ""; Name = ""; Address = ""; City = ""; Pincode = ""; Email = ""; Website = ""; PhoneNo = ""; MobileNo = "";
        }
        public string Code { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string Pincode { get; set; }
        public string Email { get; set; }
        public string Website { get; set; }
        public string PhoneNo { get; set; }
        public string MobileNo { get; set; }
    }
// Customer Master
    [WebMethod(EnableSession = true)]
    public string[] GetCustomerNameCodeList(string prefixText)
    {
        ArrayList arCustomerList = new ArrayList();
        try
        {
            SqlDataReader drCustomerList;
            drCustomerList = SqlHelper.ExecuteReader(Session["SqlProvider"].ToString().Trim(), CommandType.Text, "SELECT custnm,custcd FROM webx_CUSTHDR WHERE CUSTCd like '" + prefixText + "%' OR custnm like '" + prefixText + "%'   ORDER BY CUSTCd");
            while (drCustomerList.Read())
            {
                arCustomerList.Add(drCustomerList["custnm"].ToString().TrimEnd() + "~" + drCustomerList["custcd"].ToString());
            }
            String[] arrBlogTitles = (String[])arCustomerList.ToArray(Type.GetType("System.String"));
            return arrBlogTitles;
        }
        catch (Exception Exc)
        {
            String[] arrBlogTitles = new string[5];
            return arrBlogTitles;
        }
    }
	
	/* Add GST wise Change */
    /// <summary>
    /// The Webmethod will proide GST rates details
    /// </summary>
    /// <param name="dst">Docket GST object</param>
    /// <returns>Docket GST object as json string</returns>
    [WebMethod(EnableSession = true)]
    public string GetGSTCustomerDetails(DocketGSTDetails dst)
    {
        return Newtonsoft.Json.JsonConvert.SerializeObject(DocketController.GetGSTDetails(dst));
    }


    [WebMethod(EnableSession = true)]
    public string GSTCustomerDetailsPush(CustomerGSTDetail dst)
    {
        return Newtonsoft.Json.JsonConvert.SerializeObject(DocketController.GSTCustomerDetailsInsert(dst));
    }

    [WebMethod(EnableSession = true)]
    public string GSTCustomerDetailsValidate(CustomerGSTDetail dst)
    {
        using (WebX.Common.WebXHelper dbObject = new WebX.Common.WebXHelper())
        {
            var dtGstData = dbObject.ExecuteDataSet(CommandType.StoredProcedure, "USP_GST_CUSTOMERANDGST_DETAIL_VALIDATE",
               new[] {
                        new SqlParameter("@CUSTCD",dst.CUSTCD),
                        new SqlParameter("@GRPCD",dst.GRPCD),
                        new SqlParameter("@CUSTNM",dst.CUSTNM),
                        new SqlParameter("@CUSTPASS",dst.CUSTPASS),
                        new SqlParameter("@CUSTCAT",dst.CUSTCAT),
                        new SqlParameter("@BookingBranch",dst.BookingBranch),

                        new SqlParameter("@ServiceOptFor",dst.ServiceOptFor),
                        new SqlParameter("@entryby",SessionUtilities.CurrentEmployeeID),
                        new SqlParameter("@GSTBillingState",dst.GSTBillingState),
                        new SqlParameter("@GSTBillingCity",dst.GSTBillingCity),
                        new SqlParameter("@CGSTnumber",dst.CGSTnumber),
                        new SqlParameter("@IGSTnumber",dst.IGSTnumber),

                        new SqlParameter("@GSTBillingAddress",dst.GSTBillingAddress),
                        new SqlParameter("@BillingStateCode",dst.BillingStateCode),
                        new SqlParameter("@BillingAddress",dst.BillingAddress),
                        new SqlParameter("@BillingCityCode",dst.BillingCityCode),
                        new SqlParameter("@ProvisionalNumber",dst.ProvisionalNumber),
                        new SqlParameter("@GSTINNumber",dst.GSTINNumber),
                        new SqlParameter("@DeclarationFile",dst.DeclarationFile),
               });
            return Newtonsoft.Json.JsonConvert.SerializeObject(dtGstData);
        }
    }

    [WebMethod(EnableSession = true)]
    public string GSTGetGSTMasterData()
    {
        using (WebX.Common.WebXHelper dbObject = new WebX.Common.WebXHelper())
        {
            var dsData = dbObject.ExecuteDataSet("USP_GET_GSTDETAILMASTER");
            return Newtonsoft.Json.JsonConvert.SerializeObject(dsData);
        }
    }

    /* Add GST wise Change */
}

