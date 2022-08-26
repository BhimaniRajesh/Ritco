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

public partial class GUI_Fleet_Operations_Issue_frmViewPrintVehicleIssueSlipQueryLegWise : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    DataView dv;
    DataSet ds;
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
            popRO();
            Session["mBranch"] = ddlro.SelectedItem.Value.Trim();
        }
    }

    //protected void btnShowSingleRequest_Click(object sender, EventArgs e)
    //{
    //    RetrieveGridDataTS();
    //    DataGrid1.DataSource = dv;
    //    DataGrid1.DataBind();
    //}
    //protected void btnShowMultipleRequest_Click(object sender, EventArgs e)
    //{
    //    BindGrid();
    //}
    public void popRO()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string brcd = SessionUtilities.CurrentBranchCode.ToString().Trim();
        string q1 = "Select loccode,locname from webx_location where loc_level='1'";
        SqlCommand sqlcmd1 = new SqlCommand(q1, conn);
        SqlDataReader dr;
        dr = sqlcmd1.ExecuteReader();
        dr.Read();
        string loccd = dr["loccode"].ToString();
        dr.Close();
        String SQL_LOC, sqlall1;
        if (brcd == loccd)
        {
            //ddlro.Items.Add(new ListItem("-- Select -- ", ""));
            ddlro.Items.Add(new ListItem("ALL", "ALL"));
            SQL_LOC = "select loccode,locname+' : '+loccode from webx_location where activeFlag='Y' order by locName";
        }
        else
        {
            ddlro.Items.Add(new ListItem("ALL", "ALL"));
            SQL_LOC = "select loccode,locname+' : '+loccode from webx_location where activeFlag='Y'  order by locName";//and loccode='" + brcd + "'
        }
        SqlCommand sqlcmd2 = new SqlCommand(SQL_LOC, conn);
        SqlDataReader dr1;
        dr1 = sqlcmd2.ExecuteReader();
        while (dr1.Read())
        {
            ddlro.Items.Add(new ListItem(dr1.GetValue(1).ToString(), dr1.GetValue(0).ToString()));
        }
        dr1.Close();
        ddlro.SelectedValue = loccd;
    }

    //public void RetrieveGridData()
    //{
    //    string VSlipId = "";
    //    string IssueStatus = "";

    //    if (txtVIssueID.Text != "")
    //    {
    //        VSlipId = txtVIssueID.Text;
    //    }
    //    TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
    //    TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");

    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    conn.Open();
    //    string sql = "usp_VehicleIssueViewPrintList";
    //    SqlCommand sqlcmd = new SqlCommand(sql, conn);
    //    sqlcmd.CommandType = CommandType.StoredProcedure;

    //    SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

    //    DateTime dtFrom = new DateTime();
    //    DateTime dtTo = new DateTime();

    //    System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
    //    dtfi.ShortDatePattern = "dd/MM/yyyy";
    //    dtfi.DateSeparator = "/";
    //    {
    //        if (txtDateFrom.Text != "")
    //        {
    //            dtFrom = Convert.ToDateTime(txtDateFrom.Text + " 00:00:00.000", dtfi);
    //            dtTo = Convert.ToDateTime(txtDateTo.Text + " 23:59:59.999", dtfi);
    //        }
    //        else
    //        {
    //            System.DateTime righnow = System.DateTime.Today;
    //            string strrightnow = righnow.ToString("dd/MM/yyyy");
    //            dtFrom = Convert.ToDateTime("01/01/1900 00:00:00.000", dtfi);
    //            dtTo = Convert.ToDateTime(strrightnow + " 23:59:59.999", dtfi);
    //        }
    //    }
    //    IssueStatus = cboIssueSlipStatus.SelectedValue;

    //    da.SelectCommand.Parameters.Add("@VSlipId", SqlDbType.VarChar).Value = VSlipId.ToString();
    //    da.SelectCommand.Parameters.Add("@VSlipFromDt", SqlDbType.DateTime).Value = dtFrom;
    //    da.SelectCommand.Parameters.Add("@VSlipToDt", SqlDbType.DateTime).Value = dtTo;
    //    da.SelectCommand.Parameters.Add("@IssueStatus", SqlDbType.VarChar).Value = IssueStatus.ToString();

    //    da.SelectCommand.Parameters.Add("@TripsheetFlag", SqlDbType.VarChar).Value = ddlTripsheet.SelectedItem.Value.ToString().Trim();
    //    da.SelectCommand.Parameters.Add("@Branch", SqlDbType.VarChar).Value = ddlro.SelectedValue.ToString().Trim();
    //    da.SelectCommand.Parameters.Add("@Driver", SqlDbType.VarChar).Value = txtDriver1.Text.ToString().Trim();
    //    da.SelectCommand.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = txtVehNo.Text.ToString().Trim();
    //    da.SelectCommand.Parameters.Add("@COMPANY_CODE", SqlDbType.VarChar).Value = SessionUtilities.DefaultCompanyCode.ToString().Trim().ToUpper();  

    //    ds = new DataSet();
    //    da.Fill(ds);

    //    dv = ds.Tables[0].DefaultView;
    //    conn.Close();
    //}
    //public void RetrieveGridDataTS()
    //{
    //    string VSlipId = "";
    //    string IssueStatus = "";

    //    if (txtVIssueID.Text != "")
    //    {
    //        VSlipId = txtVIssueID.Text;
    //    }

    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    conn.Open();
    //    string sql = "usp_VehicleIssueViewPrintList";
    //    SqlCommand sqlcmd = new SqlCommand(sql, conn);
    //    sqlcmd.CommandType = CommandType.StoredProcedure;

    //    SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

    //    DateTime dtFrom = new DateTime();
    //    DateTime dtTo = new DateTime();

    //    System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
    //    dtfi.ShortDatePattern = "dd/MM/yyyy";
    //    dtfi.DateSeparator = "/";
    //    {
    //        System.DateTime righnow = System.DateTime.Today;
    //        string strrightnow = righnow.ToString("dd/MM/yyyy");
    //        dtFrom = Convert.ToDateTime("01/01/1900", dtfi);
    //        dtTo = Convert.ToDateTime(strrightnow, dtfi);
    //    }
    //    IssueStatus = cboIssueSlipStatus.SelectedValue;

    //    da.SelectCommand.Parameters.Add("@VSlipId", SqlDbType.VarChar).Value = VSlipId.ToString();
    //    da.SelectCommand.Parameters.Add("@VSlipFromDt", SqlDbType.DateTime).Value = dtFrom;
    //    da.SelectCommand.Parameters.Add("@VSlipToDt", SqlDbType.DateTime).Value = dtTo;
    //    da.SelectCommand.Parameters.Add("@IssueStatus", SqlDbType.VarChar).Value = "B";

    //    da.SelectCommand.Parameters.Add("@TripsheetFlag", SqlDbType.VarChar).Value = ddlTripsheet.SelectedItem.Value.ToString().Trim();
    //    da.SelectCommand.Parameters.Add("@Branch", SqlDbType.VarChar).Value = "All";
    //    da.SelectCommand.Parameters.Add("@Driver", SqlDbType.VarChar).Value = "";
    //    da.SelectCommand.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = "";
    //    da.SelectCommand.Parameters.Add("@COMPANY_CODE", SqlDbType.VarChar).Value = SessionUtilities.DefaultCompanyCode.ToString().Trim().ToUpper();  

    //    ds = new DataSet();
    //    da.Fill(ds);

    //    dv = ds.Tables[0].DefaultView;
    //    conn.Close();
    //}
    //public void BindGrid()
    //{
    //    RetrieveGridData();
    //    DataGrid1.DataSource = dv;
    //    DataGrid1.DataBind();
    //}

    protected void ddlro_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["mBranch"] = null;
        Session["mBranch"] = ddlro.SelectedItem.Value.Trim();
    }

}
