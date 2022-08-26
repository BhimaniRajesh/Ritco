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

public partial class rptCommExeRegister : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(IsPostBack))
        {
            rbLoc.Checked = true;
            Vendor();
            Region();
            ddlLoc.Items.Insert(0, "All");
            ddlCommType.Items.Insert(0, "All");
            ddlNumber.Items.Insert(0, "All");
        }
    }
    private void Region()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //SqlConnection conn = new SqlConnection("Data Source=ECFY110;Initial Catalog=Webxnet;UID=sa;pwd=sa");
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
    public string Type = "";
    protected void ddlVendor_SelectedIndexChanged(object sender, EventArgs e)
    {
        Type = ddlVendor.SelectedItem.Text;
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
    protected void ddlCommType_SelectedIndexChanged(object sender, EventArgs e)
    {
        Type = ddlVendor.SelectedItem.Text;
        string Number = ddlCommType.SelectedItem.Text;
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        DataSet ds = new DataSet();
        string sql = "select Distinct CDM_Number from Tel_comm_Device_Master where CDM_Type = '" + Number + "' and CDM_Vendor = '" + Type + "'";
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);
        da.Fill(ds, "TEl_Comm_Device_Master");
        ddlNumber.DataSource = ds;
        ddlNumber.DataTextField = "CDM_Number";
        ddlNumber.DataValueField = "CDM_Number";
        ddlNumber.DataBind();
        ddlNumber.Items.Insert(0, "All");
    }
    protected void cboRegion_SelectedIndexChanged(object sender, EventArgs e)
    {
        string Location = cboRegion.SelectedItem.Text;
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        DataSet ds = new DataSet();
        string sql = "select LocName as Location,LocCode as Code from webx_location where LocCity = '" + Location + "'Order By LocName";
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);
        da.Fill(ds, "webx_location");
        ddlLoc.DataSource = ds;
        ddlLoc.DataTextField = "Location";
        ddlLoc.DataValueField = "Code";
        ddlLoc.DataBind();
        ddlLoc.Items.Insert(0, "All");
    }
    protected void btnMove_Click(object sender, EventArgs e)
    {
        if (lbMonth.SelectedItem != null)
        {
            string ListLedger = lbMonth.SelectedItem.Text;
            lbMonths.Items.Add(ListLedger);
            lbMonths.SelectedIndex = 0;
            lbMonth.Items.Remove(ListLedger);
        }
    }
    protected void btnMoveAll_Click(object sender, EventArgs e)
    {
        foreach (ListItem item in lbMonth.Items)
        lbMonths.Items.Add(item);
        lbMonth.Items.Clear();
        lbMonths.SelectedIndex = 0;
        lbMonths.Focus();
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        if (lbMonths.SelectedItem != null)
        {
            string ListLedger = lbMonths.SelectedItem.Text;
            lbMonth.Items.Add(ListLedger);
            lbMonth.SelectedIndex = 0;
            lbMonths.Items.Remove(ListLedger);
        }
    }
    protected void btnBackAll_Click(object sender, EventArgs e)
    {
        foreach (ListItem item in lbMonths.Items)
        lbMonth.Items.Add(item);
        lbMonths.Items.Clear();
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
            string strName = "";
            if (lbMonths.Items.Count != 0)
            {
                foreach (ListItem lItem in lbMonths.Items)
                {
                    if (strName == "")
                    {
                        strName = lItem.Text;                        
                    }
                    else
                    {
                        strName = strName + "," + lItem.Text;                       
                    }
                }
            }
            string Person = txtPerson.Text == "" ? "All" : txtPerson.Text;
            if (rbLoc.Checked == true)
            {
                Response.Redirect("Cost_Summary_Rpt.aspx?Loc=" + "Loc" + "&Location=" + ddlLoc.SelectedItem.Text + "&User=" + Person + "&Vendor=" + ddlVendor.SelectedItem.Text + "&Device=" + ddlCommType.SelectedItem.Text + "&Number=" + ddlNumber.SelectedItem.Text + "&Months=" + strName + "&Year=" + ddlYear.SelectedItem.Value + "&Region=" + cboRegion.SelectedItem.Text);
            }
            if (rbVendorWise.Checked == true)
            {
                Response.Redirect("Cost_Summary_Rpt.aspx?Loc=" + "Vendor" + "&Location=" + ddlLoc.SelectedItem.Text + "&User=" + Person + "&Vendor=" + ddlVendor.SelectedItem.Text + "&Device=" + ddlCommType.SelectedItem.Text + "&Number=" + ddlNumber.SelectedItem.Text + "&Months=" + strName + "&Year=" + ddlYear.SelectedItem.Value + "&Region=" + cboRegion.SelectedItem.Text);
            }
            else
            {
                Response.Redirect("Cost_Summary_Rpt.aspx?Loc=" + "Device" + "&Location=" + ddlLoc.SelectedItem.Text + "&User=" + Person + "&Vendor=" + ddlVendor.SelectedItem.Text + "&Device=" + ddlCommType.SelectedItem.Text + "&Number=" + ddlNumber.SelectedItem.Text + "&Months=" + strName + "&Year=" + ddlYear.SelectedItem.Value + "&Region=" + cboRegion.SelectedItem.Text);
            }
        }
    }
}
