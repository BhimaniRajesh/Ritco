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

public partial class Issue_New_TripSheet_Validation_TripSheetApprovalFinClosure_TripsheetApprovalQuery : BasePage
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
            if (Request.QueryString["Module"].ToString() == "A")
            {
                lblPageHead.Text = "Trip Sheet Approval >> Query";
            }
            if (Request.QueryString["Module"].ToString() == "F")
            {
                lblPageHead.Text = "Trip Sheet Financial Closure >> Query";
            }

            var obj = new TripApprovalController();
            ddlFleetCenter.DataSource = obj.GetFleetCenter();
            ddlFleetCenter.DataTextField = "LOCATIONNAME";
            ddlFleetCenter.DataValueField = "LOCCODE";
            ddlFleetCenter.DataBind();
            ddlFleetCenter.Items.Insert(0, new ListItem("All", "0"));
            ddlFleetCenter.SelectedValue = "0";

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

        var obj = new TripApprovalController();
        grdList.DataSource = obj.GetTripsheetForApprovalAndFinacialClosure(txtVIssueID.Text, ddlTripsheet.SelectedValue, dtFrom, dtTo, ddlFleetCenter.SelectedValue, Request.QueryString["Module"].ToString());
        grdList.DataBind();

        if (grdList.Columns.Count > 0 && Request.QueryString["Module"].ToString() == "A")
        {
            grdList.Columns[7].Visible = false;
            //grdList.Columns[8].Visible = false;
            //grdList.Columns[9].Visible = false;
        }

    }

    protected void lnkApproval_Click(object sender, EventArgs e)
    {
        LinkButton lnkApproval = (sender as LinkButton);
        HiddenField hdnVSlipNo = (HiddenField)lnkApproval.Parent.FindControl("hdnVSlipNo");

        if (Request.QueryString["Module"].ToString() == "A")
        {
            Response.Redirect("TripsheetApprovalMain.aspx?VSlipNo=" + hdnVSlipNo.Value, false);
        }
        if (Request.QueryString["Module"].ToString() == "F")
        {
            Response.Redirect("TripsheetFinClosureMain.aspx?VSlipNo=" + hdnVSlipNo.Value, false);
        }


    }
    protected void grdList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView dr = ((DataRowView)e.Row.DataItem);

            var lnkApproval = (LinkButton)e.Row.FindControl("lnkApproval");

            if (Request.QueryString["Module"].ToString() == "A")
            {
                lnkApproval.Text = "Approval";
            }
            if (Request.QueryString["Module"].ToString() == "F")
            {
                lnkApproval.Text = "Financial Closure";
            }

        }
    }
}
