using System;
using System.Data;
using System.Data.SqlClient;
using WebX.Controllers;  

public partial class GUI_Operation_Singlescreen_docketentry_AjaxResponse : System.Web.UI.Page
{
    string strMethod = "";
    SqlConnection sqlCon;
    protected void Page_Load(object sender, EventArgs e)
    {
        strMethod = Convert.ToString(Request.QueryString["Method"]);
        try
        {
            sqlCon = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            sqlCon.Open();
            var dktCalledAs = Session["DocketCalledAs"].ToString();
        }
        catch (Exception ex)
        {
            Response.Clear();
            Response.Write("false|Session Expired. LogOn again....|");
            return;
        }
        if (sqlCon.State == ConnectionState.Open)
            sqlCon.Close();

        if (String.Compare(strMethod, "GetServiceTax", StringComparison.Ordinal) == 0)
        {
            string parameter1 = Convert.ToString(Request.QueryString["Parameter1"]);

            if (!string.IsNullOrEmpty(parameter1))
            {
                var enGB = new System.Globalization.CultureInfo("en-GB");
                var strDocumentDate = Convert.ToDateTime(parameter1, enGB);
                var serviceTaxRate = Convert.ToString(TaxRateController.GetServiceTaxRate(strDocumentDate));
                var eduCessRate = Convert.ToString(TaxRateController.GetEduCessRate(strDocumentDate));
                var hEduCessRate = Convert.ToString(TaxRateController.GetHEduCessRate(strDocumentDate));
                Response.Clear();
                Response.Write("true|" + serviceTaxRate + "|" + eduCessRate + "|" + hEduCessRate + "|");
            }
            else
            {
                Response.Clear();
                Response.Write("false|Date Required!!!|");

            }
            Response.End();
        } // 'GetData' Ends here
    }// Page Load ends
}


