using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_admin_HCLMaster_HCLMasterEdit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        UserMessage.Hide();
        if (!IsPostBack)
        {   
            tblMain.Visible = false;
            BindOutstandingTHCType();
            BindIncomingTHCType();
            BindDDMRType();
            BindMRType();
        }
        else
        {
           // tblMain.Visible = true;
        }
    }
    public void BindOutstandingTHCType()
    {
        var oHCLMasterController = new HCLMasterController();
        var ds = new DataSet();
        ds = oHCLMasterController.GetRateType();

        ddlOutgoingTHCType.DataSource = ds;
        ddlOutgoingTHCType.DataTextField = "CodeDesc";
        ddlOutgoingTHCType.DataValueField = "CodeId";
        ddlOutgoingTHCType.DataBind();
        ddlOutgoingTHCType.Items.Insert(0, new ListItem("Select Type", "0"));
    }
    public void BindIncomingTHCType()
    {
        var oHCLMasterController = new HCLMasterController();
        var ds = new DataSet();
        ds = oHCLMasterController.GetRateType();

        ddlIncomingTHCType.DataSource = ds;
        ddlIncomingTHCType.DataTextField = "CodeDesc";
        ddlIncomingTHCType.DataValueField = "CodeId";
        ddlIncomingTHCType.DataBind();
        ddlIncomingTHCType.Items.Insert(0, new ListItem("Select Type", "0"));
    }

    public void BindDDMRType()
    {
        var oHCLMasterController = new HCLMasterController();
        var ds = new DataSet();
        ds = oHCLMasterController.GetRateType();

        ddlDDMRType.DataSource = ds;
        ddlDDMRType.DataTextField = "CodeDesc";
        ddlDDMRType.DataValueField = "CodeId";
        ddlDDMRType.DataBind();
        ddlDDMRType.Items.Insert(0, new ListItem("Select Type", "0"));
    }
    public void BindMRType()
    {
        var oHCLMasterController = new HCLMasterController();
        var ds = new DataSet();
        ds = oHCLMasterController.GetRateType();

        ddlMRType.DataSource = ds;
        ddlMRType.DataTextField = "CodeDesc";
        ddlMRType.DataValueField = "CodeId";
        ddlMRType.DataBind();
        ddlMRType.Items.Insert(0, new ListItem("Select Type", "0"));
    }
    public void GetHCLData()
    {
        //if (txtBranchcode.Text == "")
        //{
        //    UserMessage.Show("Please Enter Branch code.123");
        //    tblMain.Visible = false;
        //}
        //else if(txtBranchcode.Text != "")
        //{
            var branchcode = txtBranchcode.Text;
            var objHCLMasterController = new HCLMasterController();
            var ds = new DataSet();
            ds = objHCLMasterController.GetDataForHCLEdit(branchcode);

            if (ds.Tables[0].Rows.Count > 0)
            {
                tblMain.Visible = true;
                ddlOutgoingTHCType.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["OutgoingThcType"]);
                txtOutgoingTHCRate.Text = ds.Tables[0].Rows[0]["OutgoingThcRate"].ToString();
                txtOutgoingTHCFromDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["OutgoingThcFromDate"]).ToString("dd/MM/yyyy");
                txtOutgoingTHCToDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["OutgoingThcToDate"]).ToString("dd/MM/yyyy");

                ddlIncomingTHCType.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["IncomingThcType"]);
                txtIncomingTHCRate.Text = ds.Tables[0].Rows[0]["IncomingThcRate"].ToString();
                txtIncomingTHCFromDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["IncomingThcFromDate"]).ToString("dd/MM/yyyy");
                txtIncomingTHCToDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["IncomingThcToDate"]).ToString("dd/MM/yyyy");

                ddlDDMRType.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["DDMRType"]);
                txtDDMRRate.Text = ds.Tables[0].Rows[0]["DDMRRate"].ToString();
                txtDDMRFromDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["DDMRFromDate"]).ToString("dd/MM/yyyy");
                txtDDMRToDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["DDMRToDate"]).ToString("dd/MM/yyyy");

                ddlMRType.SelectedIndex = Convert.ToInt32(ds.Tables[0].Rows[0]["MRType"]);
                txtMRRate.Text = ds.Tables[0].Rows[0]["MRRate"].ToString();
                txtMRFromDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["MRFromDate"]).ToString("dd/MM/yyyy");
                txtMRToDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["MRToDate"]).ToString("dd/MM/yyyy");
            }
            else
            {
                tblMain.Visible = false;
                UserMessage.Show("No Records Found..");
            }
       // }
    }
    protected void btnGetData_Click(object sender, EventArgs e)
    {

        if (txtBranchcode.Text == "")
        {
            UserMessage.Show("Please Enter Branch code.");
            tblMain.Visible = false;
        }
        else if (txtBranchcode.Text != "")
        {
            GetHCLData();
        }
        //GetHCLData();
    }

    public void checkDate()
    {
        

    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        DateTime dtOutgoingTHCFromDate = DateTime.ParseExact(txtOutgoingTHCFromDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
        DateTime dtOutgoingTHCToDate = DateTime.ParseExact(txtOutgoingTHCToDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);

        DateTime dtIncomingThcFromDate = DateTime.ParseExact(txtIncomingTHCFromDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
        DateTime dtIncomingThcToDate = DateTime.ParseExact(txtIncomingTHCToDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);

        DateTime dtDDMRFromDate = DateTime.ParseExact(txtDDMRFromDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
        DateTime dtDDMRToDate = DateTime.ParseExact(txtDDMRToDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);

        DateTime dtMRFromDate = DateTime.ParseExact(txtMRFromDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
        DateTime dtMRToDate = DateTime.ParseExact(txtMRToDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);

        if (dtOutgoingTHCFromDate > dtOutgoingTHCToDate)
        {
            UserMessage.Show("Outgoing THC From Date Can't be greater than To Date.");
        }
        else if (dtIncomingThcFromDate > dtIncomingThcToDate)
        {
            UserMessage.Show("Incoming THC From Date Can't be greater than To Date.");
        }
        else if (dtDDMRFromDate > dtDDMRToDate)
        {
            UserMessage.Show("DDMR THC From Date Can't be greater than To Date.");
        }
        else if (dtMRFromDate > dtMRToDate)
        {
            UserMessage.Show("MR THC From Date Can't be greater than To Date.");
        }
        else
        {
            var objHCLMasterController = new HCLMasterController();
            var objHCLDetail = new HCLUpdateDetail();

            objHCLDetail.BranchCode = txtBranchcode.Text;

            objHCLDetail.OutgoingThcType = Convert.ToInt32(ddlOutgoingTHCType.SelectedValue.ToString());
            objHCLDetail.OutgoingThcRate = Convert.ToDouble(txtOutgoingTHCRate.Text);
            objHCLDetail.OutgoingThcFromDate = DateTime.ParseExact(txtOutgoingTHCFromDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            objHCLDetail.OutgoingThcToDate = DateTime.ParseExact(txtOutgoingTHCToDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);

            objHCLDetail.IncomingThcType = Convert.ToInt32(ddlIncomingTHCType.SelectedValue.ToString());
            objHCLDetail.IncomingThcRate = Convert.ToDouble(txtIncomingTHCRate.Text);
            objHCLDetail.IncomingThcFromDate = DateTime.ParseExact(txtIncomingTHCFromDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            objHCLDetail.IncomingThcToDate = DateTime.ParseExact(txtIncomingTHCToDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);

            objHCLDetail.DDMRType = Convert.ToInt32(ddlDDMRType.SelectedValue.ToString());
            objHCLDetail.DDMRRate = Convert.ToDouble(txtDDMRRate.Text);
            objHCLDetail.DDMRFromDate = DateTime.ParseExact(txtDDMRFromDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            objHCLDetail.DDMRToDate = DateTime.ParseExact(txtDDMRToDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);

            objHCLDetail.MRType = Convert.ToInt32(ddlMRType.SelectedValue.ToString());
            objHCLDetail.MRRate = Convert.ToDouble(txtMRRate.Text);
            objHCLDetail.MRFromDate = DateTime.ParseExact(txtMRFromDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            objHCLDetail.MRToDate = DateTime.ParseExact(txtMRToDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);

            objHCLDetail.UpdateBy = SessionUtilities.CurrentEmployeeID;

            objHCLMasterController.UpdateHCLDetails(objHCLDetail);
            DataTable dt = objHCLMasterController.UpdateHCLDetails(objHCLDetail);

            if (dt.Rows.Count > 0)
            {
                Response.Redirect("HCLMasterDone.aspx?Flag=Edit", false);
            }
        }
    }
}