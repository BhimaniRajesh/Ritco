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

public partial class TripsheetQuery : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
        if (!IsPostBack)
        {

        }
    }


    protected void CheckValid(object sender, EventArgs e)
    {
        TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");
        txtDateFrom.Text = "";
        txtDateTo.Text = "";
    }

    protected void btnShowMultipleRequest_Click(object sender, EventArgs e)
    {
        string VSlipId = "";
        string IssueStatus = "";

        
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //conn.Open();
        //string sql = "usp_JobOrderViewPrintList";
        //SqlCommand sqlcmd = new SqlCommand(sql, conn);
        //sqlcmd.CommandType = CommandType.StoredProcedure;

        //SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        //DateTime dtFrom = new DateTime();
        //DateTime dtTo = new DateTime();


        //TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
        //TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");

        //System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        //dtfi.ShortDatePattern = "dd/MM/yyyy";
        //dtfi.DateSeparator = "/";
        //{
        //    if (txtDateFrom.Text != "")
        //    {
        //        dtFrom = Convert.ToDateTime(txtDateFrom.Text + " 00:00:00.000", dtfi);
        //        dtTo = Convert.ToDateTime(txtDateTo.Text + " 23:59:59.999", dtfi);
        //    }
        //    else
        //    {
        //        System.DateTime righnow = System.DateTime.Today;
        //        string strrightnow = righnow.ToString("dd/MM/yyyy");
        //        dtFrom = Convert.ToDateTime("01/01/1900 00:00:00.000", dtfi);
        //        dtTo = Convert.ToDateTime(strrightnow + " 23:59:59.999", dtfi);
        //    }
        //}
        //IssueStatus = cboIssueSlipStatus.SelectedValue;

        //da.SelectCommand.Parameters.Add("@VSlipId", SqlDbType.VarChar).Value = VSlipId.ToString();
        //da.SelectCommand.Parameters.Add("@VSlipFromDt", SqlDbType.DateTime).Value = dtFrom;
        //da.SelectCommand.Parameters.Add("@VSlipToDt", SqlDbType.DateTime).Value = dtTo;
        //da.SelectCommand.Parameters.Add("@IssueStatus", SqlDbType.VarChar).Value = IssueStatus.ToString();
        //da.SelectCommand.Parameters.Add("@COMPANY_CODE", SqlDbType.VarChar).Value = SessionUtilities.DefaultCompanyCode.ToString().Trim().ToUpper();

        //ds = new DataSet();
        //da.Fill(ds);

        //dv = ds.Tables[0].DefaultView;
        //conn.Close();
        
    }
}
