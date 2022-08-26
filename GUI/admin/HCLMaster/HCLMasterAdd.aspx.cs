using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_admin_HCLMaster_HCLMasterAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        UserMessage.Hide();
        if(!IsPostBack)
        {
            BindOutstandingTHCType();
            BindIncomingTHCType();
            BindDDMRType();
            BindMRType();
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
        ddlOutgoingTHCType.Items.Insert(0, new ListItem("Select Type","0"));
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

        ddlDDMR.DataSource = ds;
        ddlDDMR.DataTextField = "CodeDesc";
        ddlDDMR.DataValueField = "CodeId";
        ddlDDMR.DataBind();
        ddlDDMR.Items.Insert(0, new ListItem("Select Type", "0"));
    }
    public void BindMRType()
    {
        var oHCLMasterController = new HCLMasterController();
        var ds = new DataSet();
        ds = oHCLMasterController.GetRateType();

        ddlMR.DataSource = ds;
        ddlMR.DataTextField = "CodeDesc";
        ddlMR.DataValueField = "CodeId";
        ddlMR.DataBind();
        ddlMR.Items.Insert(0, new ListItem("Select Type", "0"));
    }
}