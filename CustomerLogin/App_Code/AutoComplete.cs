using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;

/// <summary>
/// Summary description for AutoComplete
/// </summary>
//[WebService(Namespace = "http://www.15seconds.com/articles/robchartier/guid",
//Description = "Generate a GUID, to be used with UDDI for failover example")]
//public class GuidGenerator
//{
//    [WebMethod(Description = "Generate the GUID")]
//    public string GetGuid()
//    {
//        return System.Guid.NewGuid().ToString();
//    }
//}

//[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class AutoComplete : System.Web.Services.WebService {

    public AutoComplete () 
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
    [WebMethod]
    public string[] GetBlogTitlesForAutoComplete(string prefixText, int count)
    {
        ArrayList _blog_titles = new ArrayList();

       // SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        SqlCommand cmd = new SqlCommand("wms_generate_select_data", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        
        String TableName, Wherecls, OrderBy;
        TableName = "WMS_RECPT_TYPE";
        
        Wherecls = "RECPT_NAME like '"+prefixText+"%'";
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

    [WebMethod]
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
    [WebMethod]
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
    [WebMethod]
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
    [WebMethod]
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
    [WebMethod]
    public string[] GetCustomerList(string prefixText, int count)
    {
        ArrayList _blog_titles = new ArrayList();
        string dax = "Data Source=202.87.45.69;Initial Catalog=Webxpress_new;UID=sa;pwd=!@ecfy#$";
        SqlConnection conn = new SqlConnection(dax.ToString());
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
    [WebMethod]
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

    [WebMethod]
    public string[] GetReportPickOrderList(string prefixText, int count)
    {
        ArrayList _blog_titles = new ArrayList();

        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["WMS"]);
        string sql = "select OrderNo from WMS_Trans_Order_Header with (NOLOCK) where Order_Status_Code='200'";
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
}

