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
using WebX.Controllers;
using WebX.Entity;
using System.Xml.Serialization;
using System.Xml;
using System.Collections.Generic;
using System.Xml.XPath;
using System.Xml.Linq;

public partial class Clients_1_login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!Request.Browser.Browser.ToLower().Contains("ie"))
        //{
        //    Response.Redirect("~/GUI/warning.aspx");
        //}
        //else
        //{
            Session["Client"] = "Ritco";
            Session["RedirectURL"] = "~/Live/login.aspx";
            //SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString);
            Session["SqlProvider"] = ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString;
            //throw new Exception(Session["SqlProvider"].ToString());
            //Session["SqlProvider"] = "Data Source=192.168.0.14;Initial Catalog=Ritco_Live;UID=sa;pwd=welcome@123;Connection Lifetime=40;Max Pool Size=80000";
            getFinYear();

            Session["HeadOfficeCode"] = "HQTR";
            //Session["YearVal"] = "07_08";
            //Session["FinYear"] = "07";
            Session["Dktlength"] = "7";
            Session["FinYearStart"] = "1 Apr " + Session["FinYear"];
            //string CloseYear = Convert.ToString((Convert.ToInt16(Session["FinYear"]) + 1));

            //if (CloseYear.Length == 1)
            //    CloseYear = "0" + CloseYear;

            //Session["FinYearEnd"] = "31 Mar " + CloseYear;
            Session["logofile"] = "WebXpress_logo.gif";
            Session["DocketCalledAs"] = "Docket";
            Session["THCCalledAs"] = "THC";

            try
            {
                string strXmlPath = "~/GUI/Operation/DocketEntry/DefaultInvokedContractSettings.xml";
                List<ContractKeys> ContractKeysList = new List<ContractKeys>();
                ContractKeysList.Add(new ContractKeys());
                XmlSerializer x = new XmlSerializer(ContractKeysList.GetType());
                System.IO.MemoryStream stream = new System.IO.MemoryStream();
                x.Serialize(stream, ContractKeysList);
                stream.Position = 0;
                XmlDocument xd = new XmlDocument();
                xd.Load(stream);
                xd.Save(Server.MapPath(strXmlPath));
            }
            catch (Exception ex) { }

            Response.Redirect("~/GUI/default.aspx");

            //Response.Redirect("~/GUI/default.aspx");
        //}
    }
    private void getFinYear()
    {
        SqlConnection sqlCon = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlCon.Open();

        string sql = "usp_Get_Finacial_Years";
        SqlCommand sqlCmd = new SqlCommand(sql, sqlCon);
        sqlCmd.CommandType = CommandType.StoredProcedure;

        SqlDataReader dr = sqlCmd.ExecuteReader();

        while (dr.Read())
        {
            if (Session["FinYear"] == null)
            {
                Session["FinYear"] = dr["FinYear"].ToString().Trim();
                Session["YearVal"] = dr["YearVal"].ToString().Trim();
                string yearval = Session["YearVal"].ToString();
                string finYear = Session["FinYear"].ToString();
                string info = finYear;
                string strStartVal = "";
                string strEndVal = "";
                string[] arInfo = new string[1];
                char[] splitter = { '-' };
                arInfo = info.Split(splitter);
                for (int x = 0; x < arInfo.Length; x++)
                {
                    strStartVal = arInfo[0];
                    Session["FinYearStart"] = "1 Apr " + strStartVal;
                    Session["FinYear"] = strStartVal;
                    strEndVal = arInfo[1];
                    Session["FinYearEnd"] = "31 Mar " + strEndVal;
                }

                string strStartVal1 = "";
                string strEndVal1 = "";
                string info1 = yearval;
                string[] arInfo1 = new string[1];
                char[] splitter1 = { '_' };
                arInfo1 = info1.Split(splitter1);
                for (int x1 = 0; x1 < arInfo1.Length; x1++)
                {
                    strStartVal1 = arInfo1[0];
                    Session["FinYearStart1"] = strStartVal1;
                    Session["FinYear1"] = strStartVal;
                    strEndVal1 = arInfo1[1];
                    Session["FinYearEnd1"] = strEndVal1;
                }
            }
        }
    }


}
