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

public partial class GUI_Operations_MISROUTE_MSStep2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string xmlSU = "", xmlSU_NonArr = "", xmlSU_MSRDKT = "";
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

      

        xmlSU_MSRDKT = Request.Form["ctl00$MyCPH1$hXMLData_MSRDKT"].ToString().Trim();
        xmlSU_MSRDKT = xmlSU_MSRDKT.Replace(" ", "_");
        xmlSU_MSRDKT = xmlSU_MSRDKT.Replace("&", " and ");


        //DRSCode = Request.Form["ctl00$MyCPH1$hDRS"].ToString().Trim();

        /*for (int i = 0; i < Request.Form.Count; i++)
        {
            Response.Write(i + "--" + Request.Form.AllKeys[i] + "<br>");
        }*/
        //Response.Write(DRSCode + "<br>");
        Response.Write(xmlSU + "<br>");


        doStockUpdate(xmlSU_MSRDKT);
        Response.Redirect("./MSStep3.aspx");
    }

    protected void doStockUpdate(string xmlData_MSRDKT)
    {
        //Make & Open Connection
        SqlConnection sqlCon = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlCon.Open();
        //--------------------------------

        string sql = "usp_XML_Misroute_Update";
        SqlCommand sqlCmd = new SqlCommand(sql, sqlCon);
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Parameters.Add("@empcd", SqlDbType.VarChar).Value = Session["empcd"].ToString().Trim();
        sqlCmd.Parameters.Add("@brcd", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();
        //sqlCmd.Parameters.Add("@xmlData", SqlDbType.Text).Value = xmlData.Trim();
        //sqlCmd.Parameters.Add("@xmlData_NonArr", SqlDbType.Text).Value = xmlData_NonArr.Trim();
        sqlCmd.Parameters.Add("@xmlSU_MSRDKT", SqlDbType.Text).Value = xmlData_MSRDKT.Trim();
        sqlCmd.ExecuteNonQuery();
        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);

        DataSet ds = new DataSet();
        da.Fill(ds);
        da.Dispose();
    }
}
