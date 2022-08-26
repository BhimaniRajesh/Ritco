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

public partial class Issue_frmCloseVehicleIssueSlipQuery_Ver1 : System.Web.UI.Page
{
    DataView dv;
    DataSet ds;
    public string modeval = "";
    string Flag = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        modeval = Request.QueryString["mode"];
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);
        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
        Session["Flag"] = null;
        if (!IsPostBack)
        {
            if (modeval == "Advance")
            {
                ddlUpdClose.Items.Add(new ListItem("Advance", "Update"));
                lblPageHead.Text = "Trip Advance Entry >> Query";
                Session["Flag"] = "U";
            }
            else if (modeval == "AdvanceV2")
            {
                ddlUpdClose.Items.Add(new ListItem("Advance", "Update"));
                lblPageHead.Text = "Trip Advance Entry >> Query";
                Session["Flag"] = "U";
            }
            else if (modeval == "AdvanceV3")
            {
                ddlUpdClose.Items.Add(new ListItem("Advance", "Update"));
                lblPageHead.Text = "Trip Advance Entry >> Query";
                Session["Flag"] = "U";
            }
            else if (modeval == "Close")
            {
                ddlUpdClose.Items.Add(new ListItem("Close - Operational", "Close"));
                //ddlUpdClose.Items.Add(new ListItem("Close - Financial", "Close"));
                lblPageHead.Text = "Close - Operational Trip Sheet >> Query";
                Session["Flag"] = "C";
            }
            else if (modeval == "Settlement")
            {
                ddlUpdClose.Items.Add(new ListItem("Driver Settlement", "DS"));
                lblPageHead.Text = "Driver Settlement >> Query";
                Session["Flag"] = "DS";
            }
            else if (modeval == "SettlementNew")
            {
                ddlUpdClose.Items.Add(new ListItem("Driver Settlement", "DS"));
                lblPageHead.Text = "Driver Settlement >> Query";
                Session["Flag"] = "DSNEW";
            }
            else if (modeval == "FE")
            {
                ddlUpdClose.Items.Add(new ListItem("Financial Edit", "FE"));
                lblPageHead.Text = "Tripsheet Financial Edit >> Query";
                Session["Flag"] = "DS";
            }
        }
    }

    protected void btnShowMultipleRequest_Click(object sender, EventArgs e)
    {
        if (ddlUpdClose.SelectedItem.Text.Trim() == "Advance")
        {
            Flag = "U";
        }
        else if (ddlUpdClose.SelectedItem.Text.Trim() == "Driver Settlement")
        {
            Flag = "DS";
        }
        else if (ddlUpdClose.SelectedItem.Text.Trim() == "Financial Edit")
        {
            Flag = "FE";
        }
        else
        {
            Flag = "C";
        }
        Session["Flag"] = Flag;
        BindGrid();
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
        string sql = "usp_VehicleIssueList_FA";
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
        da.SelectCommand.Parameters.Add("@UpdClose", SqlDbType.VarChar).Value = ddlUpdClose.SelectedItem.Value.Trim();
        da.SelectCommand.Parameters.Add("@BRCD", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode.ToString().Trim().ToUpper();
        da.SelectCommand.Parameters.Add("@TripsheetFlag", SqlDbType.VarChar).Value = ddlTripsheet.SelectedItem.Value.ToString().Trim();
        da.SelectCommand.Parameters.Add("@COMPANY_CODE", SqlDbType.VarChar).Value = SessionUtilities.DefaultCompanyCode.ToString().Trim().ToUpper();
        da.SelectCommand.Parameters.Add("@Vehicle", SqlDbType.VarChar).Value = txtVehno.Text;
        da.SelectCommand.Parameters.Add("@Driver", SqlDbType.VarChar).Value = txtDriver1.Text;
        ds = new DataSet();
        da.Fill(ds);
        dv = ds.Tables[0].DefaultView;
        conn.Close();
    }
    public void BindGrid()
    {
        RetrieveGridData();

        if (Flag == "U")
        {
            DataGrid2.DataSource = dv;
            DataGrid2.DataBind();
        }
        else
        {
            DataGrid1.DataSource = dv;
            DataGrid1.DataBind();
        }
    }

    protected void DataGrid1_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        if (Session["Flag"].ToString().Trim() == "U" && Request.QueryString["mode"].ToString().ToUpper() == "ADVANCE")
        {
            e.Item.Cells[13].Visible = true;
            e.Item.Cells[14].Visible = false;
            e.Item.Cells[15].Visible = false;
            e.Item.Cells[16].Visible = false;
            e.Item.Cells[17].Visible = false;
            e.Item.Cells[18].Visible = false;
        }
        if (Session["Flag"].ToString().Trim() == "U" && (Request.QueryString["mode"].ToString().ToUpper() == "ADVANCEV2" || Request.QueryString["mode"].ToString().ToUpper() == "ADVANCEV3"))
        {
            e.Item.Cells[13].Visible = false;
            e.Item.Cells[14].Visible = false;
            e.Item.Cells[15].Visible = false;
            e.Item.Cells[16].Visible = false;
            e.Item.Cells[17].Visible = false;
            e.Item.Cells[18].Visible = true;
        }
        if (Session["Flag"].ToString().Trim() == "C")
        {
            e.Item.Cells[13].Visible = false;
            e.Item.Cells[14].Visible = true;
            e.Item.Cells[15].Visible = false;
            e.Item.Cells[16].Visible = false;
            e.Item.Cells[17].Visible = false;
            e.Item.Cells[18].Visible = false;
        }

        if (Session["Flag"].ToString().Trim() == "DS" && Request.QueryString["mode"].ToString().ToUpper() != "SETTLEMENTNEW")
        {
            e.Item.Cells[13].Visible = false;
            e.Item.Cells[14].Visible = false;
            e.Item.Cells[15].Visible = true;
            e.Item.Cells[16].Visible = false;
            e.Item.Cells[17].Visible = false;
            e.Item.Cells[18].Visible = false;
        }

        if (Session["Flag"].ToString().Trim() == "FE")
        {
            e.Item.Cells[13].Visible = false;
            e.Item.Cells[14].Visible = false;
            e.Item.Cells[15].Visible = false;
            e.Item.Cells[16].Visible = true;
            e.Item.Cells[17].Visible = false;
            e.Item.Cells[18].Visible = false;
        }
        if (Request.QueryString["mode"].ToString().ToUpper() == "SETTLEMENTNEW")
        {
            e.Item.Cells[13].Visible = false;
            e.Item.Cells[14].Visible = false;
            e.Item.Cells[15].Visible = false;
            e.Item.Cells[16].Visible = false;
            e.Item.Cells[17].Visible = true;
            e.Item.Cells[18].Visible = false;
        }

    }

    protected void DataGrid2_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        if (Session["Flag"].ToString().Trim() == "U" && Request.QueryString["mode"].ToString().ToUpper() == "ADVANCE")
        {
            e.Item.Cells[7].Visible = true;
            e.Item.Cells[8].Visible = false;
            e.Item.Cells[9].Visible = false;

        }
        if (Session["Flag"].ToString().Trim() == "U" && (Request.QueryString["mode"].ToString().ToUpper() == "ADVANCEV2" || Request.QueryString["mode"].ToString().ToUpper() == "ADVANCEV3"))
        {
            e.Item.Cells[7].Visible = false;
            if (Request.QueryString["mode"].ToString().ToUpper() == "ADVANCEV3")
            {
                e.Item.Cells[8].Visible = true;
                e.Item.Cells[9].Visible = false;
            }
            else
            {
                e.Item.Cells[8].Visible = false;
                e.Item.Cells[9].Visible = true;
            }


        }


    }
}
