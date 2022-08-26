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


public partial class GUI_Operations_DRS_UpdateDRSSunmit : System.Web.UI.Page
{
    public static string xmlDRS = "";
    public static string DRSCode = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        //xmlDRS = HttpUtility.UrlDecode(Request.QueryString["XMLData"].ToString());
        //xmlDRS = Request.QueryString["XMLData"].ToString();
        //DRSCode = Request.QueryString["DRSCode"].ToString();

        xmlDRS = Request.Form["ctl00$MyCPH1$hXMLData"].ToString().Trim();
        xmlDRS = xmlDRS.Replace(" ", "_");
        xmlDRS = xmlDRS.Replace("&", " and ");

        DRSCode = Request.Form["ctl00$MyCPH1$hDRS"].ToString().Trim();

        /*for (int i = 0; i < Request.Form.Count; i++)
        {
            Response.Write(i + "--" + Request.Form.AllKeys[i] + "<br>");
        }*/
        //Response.Write(DRSCode + "<br>");
        //Response.Write(xmlDRS + "<br>");
        

        doUpdateDRS(xmlDRS);
        Response.Redirect("./DRSUpdateResult.aspx?DRSCode=" + DRSCode);
    }


    protected void doUpdateDRS(string xmlData)
    {
        //Make & Open Connection
        SqlConnection sqlCon = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlCon.Open();
        //--------------------------------

        string sql = "usp_XML_DRS_Update";
        SqlCommand sqlCmd = new SqlCommand(sql, sqlCon);
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Parameters.Add("@empcd", SqlDbType.VarChar).Value = Session["empcd"].ToString().Trim();
        sqlCmd.Parameters.Add("@xmlData", SqlDbType.Text).Value = xmlData.Trim();


        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);

        DataSet ds = new DataSet();
        da.Fill(ds);
        da.Dispose();

        //string THCCodeGenerated = "";
        //string Tranzaction = "";

        //THCCodeGenerated = ds.Tables[0].Rows[0]["THCNo"].ToString();
        //Tranzaction = ds.Tables[0].Rows[0]["TranXaction"].ToString().Trim();

        //Response.Redirect("DisplayTHCResult.aspx?THCNo=" + THCCodeGenerated + "&ManTHCNo=" + txtManualTHCNo.Text.Trim() + "&Tranzaction=" + Tranzaction);

    }
}
