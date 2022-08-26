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


public partial class GUI_Operations_UpdateDocketArrivalStatus_StockUpdateSubmit : System.Web.UI.Page
{
   // public static string xmlSU = "";
    //public static string DRSCode = "";
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

            //xmlSU = HttpUtility.UrlDecode(Request.QueryString["XMLData"].ToString());
            //xmlSU = Request.QueryString["XMLData"].ToString();
            //DRSCode = Request.QueryString["DRSCode"].ToString();

            xmlSU = Request.Form["ctl00$MyCPH1$hXMLData"].ToString().Trim();
            xmlSU = xmlSU.Replace(" ", "_");
            xmlSU = xmlSU.Replace("&", " and ");

            xmlSU_NonArr = Request.Form["ctl00$MyCPH1$hXMLData_NonArr"].ToString().Trim();
            xmlSU_NonArr = xmlSU_NonArr.Replace(" ", "_");
            xmlSU_NonArr = xmlSU_NonArr.Replace("&", " and ");


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


            doStockUpdate(xmlSU, xmlSU_NonArr, xmlSU_MSRDKT);
            //Response.Redirect("./StockUpdateResult.aspx");
        }

        protected void doStockUpdate(string xmlData, string xmlData_NonArr, string xmlData_MSRDKT)
        {
            //Make & Open Connection
            SqlConnection sqlCon = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            sqlCon.Open();
            //--------------------------------

            string sql = "usp_XML_Stock_Update";
            SqlCommand sqlCmd = new SqlCommand(sql, sqlCon);
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.Parameters.Add("@empcd", SqlDbType.VarChar).Value = Session["empcd"].ToString().Trim();
            sqlCmd.Parameters.Add("@brcd", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();
            sqlCmd.Parameters.Add("@FinYear", SqlDbType.Text).Value = Session["FinYear"].ToString().Trim();
            sqlCmd.Parameters.Add("@xmlData", SqlDbType.Text).Value = xmlData.Trim();
            sqlCmd.Parameters.Add("@xmlData_NonArr", SqlDbType.Text).Value = xmlData_NonArr.Trim();
            sqlCmd.Parameters.Add("@xmlSU_MSRDKT", SqlDbType.Text).Value = xmlData_MSRDKT.Trim();
            sqlCmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(sqlCmd);

            DataSet ds = new DataSet();
            da.Fill(ds);
            da.Dispose();

            string VURNO = "";
            VURNO = ds.Tables[0].Rows[0]["VURNO"].ToString();
            Response.Redirect("StockUpdateResult.aspx?VURNO=" + VURNO); 
        }
}
