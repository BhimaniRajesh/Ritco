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

public partial class Issue_DriverSettlementQuery : System.Web.UI.Page
{
    DataView dv;
    DataSet ds;
    public string modeval = "";
    string Flag = "";
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

    protected void btnShowMultipleRequest_Click(object sender, EventArgs e)
    {
        RetrieveGridData();
    }


    public void RetrieveGridData()
    {
        TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");
        string VSlipId = "";
        if (txtVIssueID.Text != "")
        {
            VSlipId = txtVIssueID.Text;
        }
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "USP_DriverSettlement_VehicleIssueList";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        DateTime dtFrom = new DateTime();
        DateTime dtTo = new DateTime();
        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        {
            if (txtDateFrom.Text != "")
            {
                dtFrom = Convert.ToDateTime(txtDateFrom.Text + " 00:00:00.000", dtfi);
                dtTo = Convert.ToDateTime(txtDateTo.Text + " 23:59:59.999", dtfi);
            }
            else
            {
                System.DateTime righnow = System.DateTime.Today;
                string strrightnow = righnow.ToString("dd/MM/yyyy");
                dtFrom = Convert.ToDateTime("01/01/1900 00:00:00.000", dtfi);
                dtTo = Convert.ToDateTime(strrightnow + " 23:59:59.999", dtfi);
            }
        }
        da.SelectCommand.Parameters.Add("@VSlipId", SqlDbType.VarChar).Value = VSlipId.ToString();
        da.SelectCommand.Parameters.Add("@VSlipFromDt", SqlDbType.DateTime).Value = dtFrom;
        da.SelectCommand.Parameters.Add("@VSlipToDt", SqlDbType.DateTime).Value = dtTo;
        da.SelectCommand.Parameters.Add("@BRCD", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode.ToString().Trim().ToUpper();
        da.SelectCommand.Parameters.Add("@TripsheetFlag", SqlDbType.VarChar).Value = ddlTripsheet.SelectedItem.Value.ToString().Trim();
        da.SelectCommand.Parameters.Add("@COMPANY_CODE", SqlDbType.VarChar).Value = SessionUtilities.DefaultCompanyCode.ToString().Trim().ToUpper();
        da.SelectCommand.Parameters.Add("@Vehicle", SqlDbType.VarChar).Value = txtVehno.Text;
        da.SelectCommand.Parameters.Add("@Driver", SqlDbType.VarChar).Value = txtDriver1.Text;
        da.SelectCommand.Parameters.Add("@Status", SqlDbType.VarChar).Value = ddlStatus.SelectedValue;
        
        ds = new DataSet();
        da.Fill(ds);
        dv = ds.Tables[0].DefaultView;
        grdList.DataSource = dv;
        grdList.DataBind();
        conn.Close();
    }

    protected void lnkNextStep_Click(object sender, EventArgs e)
    {
        LinkButton lnkNextStep = (sender as LinkButton);
        var hdnTripsheetNo = (HiddenField)lnkNextStep.Parent.FindControl("hdnTripsheetNo");
        Response.Redirect("frmDriverSettlementIssueSlipVer1.aspx?VSlipNo=" + hdnTripsheetNo.Value, false);
    }

    protected void grdList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            LinkButton lnkNextStep = (LinkButton)e.Row.FindControl("lnkNextStep");
            HiddenField hdnStatus = (HiddenField)e.Row.FindControl("hdnStatus");

            if (hdnStatus.Value == "Settled")
            {
                lnkNextStep.Visible = false;
            }

        }
    }
}
