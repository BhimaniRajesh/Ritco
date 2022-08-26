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

public partial class rptExpenseSummary : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(IsPostBack))
        {
            rbSummType.Checked = true;
            Vendor();
            Region();
            ddlLoc.Items.Insert(0, "All");
            ddlCommType.Items.Insert(0, "All");
        }
    }
    private void Region()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter("select Distinct LocCity from webx_location where LocCity is not null", conn);
        da.Fill(ds);
        cboRegion.DataSource = ds;
        cboRegion.DataTextField = "LocCity";
        cboRegion.DataValueField = "LocCity";
        cboRegion.DataBind();
        cboRegion.Items.Insert(0, "All");
    }
    private void Vendor()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter("select Distinct CDM_Vendor from Tel_comm_Device_Master", conn);
        da.Fill(ds);
        ddlVendor.DataSource = ds;
        ddlVendor.DataTextField = "CDM_Vendor";
        ddlVendor.DataValueField = "CDM_Vendor";
        ddlVendor.DataBind();
        ddlVendor.Items.Insert(0, "All");
    }
    protected void ddlVendor_SelectedIndexChanged(object sender, EventArgs e)
    {
        string Type = ddlVendor.SelectedItem.Text;
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        DataSet ds = new DataSet();
        string sql = "select Distinct CDM_Type from Tel_comm_Device_Master where CDM_Vendor = '" + Type + "'";
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);
        da.Fill(ds, "TEl_Comm_Device_Master");
        ddlCommType.DataSource = ds;
        ddlCommType.DataTextField = "CDM_Type";
        ddlCommType.DataValueField = "CDM_Type";
        ddlCommType.DataBind();
        ddlCommType.Items.Insert(0, "All");
    }
    protected void cboRegion_SelectedIndexChanged(object sender, EventArgs e)
    {
        string Location = cboRegion.SelectedItem.Text;
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        DataSet ds = new DataSet();
        string sql = "select Distinct LocName as Location,LocCode as Code from webx_location where LocCity = '" + Location + "'Order By LocName";
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);
        da.Fill(ds, "webx_location");
        ddlLoc.DataSource = ds;
        ddlLoc.DataTextField = "Location";
        ddlLoc.DataValueField = "Code";
        ddlLoc.DataBind();
        ddlLoc.Items.Insert(0, "All");
    }
    protected void txtPerson_TextChanged(object sender, EventArgs e)
    {
        string Loc = "";
        string EmpCode = "";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "select wl.LocName AS Location, we.empnm as empnm from webx_location wl,webx_EMPMST we where wl.loccode=we.currbrcd and we.empcd='" + txtPerson.Text.Trim() + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            Loc = Convert.ToString(dr["Location"]);
            EmpCode = Convert.ToString(dr["empnm"]);
        }
        conn.Close();

        if (Loc != "" && Loc != null)
        {
            lblPersonName.Text = EmpCode;
        }
        else
        {
            lblPersonName.Text = "Assigned to User ID is not Existing";
        }
    }
    public void Person(object source, ServerValidateEventArgs value)
    {
        if (lblPersonName.Text == "Assigned to User ID is not Existing")
        {
            value.IsValid = false;
        }
        else
        {
            value.IsValid = true;
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (Page.IsValid == true)
        {
            if (rbSummType.Checked == true)
            {
                Response.Redirect("CommAssets_Reg_Rpt.aspx?ReportType=" + "Summary" + "&Location=" + ddlLoc.SelectedItem.Text + "&Person=" + txtPerson.Text + "&Vendor=" + ddlVendor.SelectedItem.Text + "&Device=" + ddlCommType.SelectedItem.Text + "&Region=" + cboRegion.SelectedItem.Text);              
            }
            if (rbSummVendor.Checked == true)
            {
                Response.Redirect("CommAssets_Reg_Rpt.aspx?ReportType=" + "Vendor" + "&Location=" + ddlLoc.SelectedItem.Text + "&Person=" + txtPerson.Text + "&Vendor=" + ddlVendor.SelectedItem.Text + "&Device=" + ddlCommType.SelectedItem.Text + "&Region=" + cboRegion.SelectedItem.Text);
            }
            else
            {
                Response.Redirect("CommAssets_Reg_Rpt.aspx?ReportType=" + "Register" + "&Location=" + ddlLoc.SelectedItem.Text + "&Person=" + txtPerson.Text + "&Vendor=" + ddlVendor.SelectedItem.Text + "&Device=" + ddlCommType.SelectedItem.Text);
            }            
        }
    }
}
