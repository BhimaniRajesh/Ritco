using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using WebX.Entity;
using WebX.Controllers;

public partial class GUI_admin_CustomerContractMaster_ViewSSC : System.Web.UI.UserControl
{
    string basedon1, basecode1, basedon2, basecode2,sundrytype;

    public string SundryType { get { return sundrytype; } set { sundrytype = value; } }
    public string Matrix { get { return ddlmatrixtype.SelectedValue; } set { ddlmatrixtype.SelectedValue = value; } }
    public string TransMode { get { return ddltransmode.SelectedValue; } set { ddltransmode.SelectedValue = value; } }
    public string BaseCode1 { get { return ddlbasecode1.SelectedValue; } set { ddlbasecode1.SelectedValue = value; } }
    public string BaseCode2 { get { return ddlbasecode2.SelectedValue; } set { ddlbasecode2.SelectedValue = value; } }
    public string BasedOn1 { get { return hdnbasedon1.Value; }}
    public string BasedOn2 { get { return hdnbasedon2.Value; }}
    public string From { get { return txtfrom.Text; } set { txtfrom.Text = value; } }
    public string To { get { return txtto.Text; } set { txtto.Text = value; } }

    public GUI_admin_CustomerContractMaster_ViewSSC()
    {
        sundrytype = "N";
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ddltransmode.DataSource = DataProvider.GetActiveGeneralMaster("TRN");
            ddltransmode.DataBind();
            ddltransmode.Items.Add(new ListItem("All", "1234"));

            hdnbasedon1.Value = DocketRules.GetDefaultValue("CHRG_RULE");
            ddlbasecode1.DataSource = DataProvider.GetActiveGeneralMaster(hdnbasedon1.Value);
            ddlbasecode1.DataBind();
            lblbasedon1.Text = DataProvider.GetCodeTypeName(hdnbasedon1.Value);

            if (SundryType.CompareTo("S") == 0)
            {
                ddltransmode.Enabled = false;
                ddltransmode.SelectedValue = "1234";
            }
            ddlbasecode1_SelectedIndexChanged(sender, e);
        }
    }

    protected void ddlbasecode1_SelectedIndexChanged(object sender, EventArgs e)
    {
        hdnbasedon2.Value = ChargeMasterController.GetChargeSubRule("DKT", hdnbasedon1.Value, ddlbasecode1.SelectedValue);
        if (hdnbasedon2.Value.CompareTo("NONE") != 0)
        {
            ddlbasecode2.DataSource = DataProvider.GetActiveGeneralMaster(hdnbasedon2.Value);
            ddlbasecode2.DataBind();
            ddlbasecode2.Style["display"] = "block";
            lblbasedon2.Text = DataProvider.GetCodeTypeName(hdnbasedon2.Value);
        }
        else
        {
            lblbasedon2.Text = "";
            ddlbasecode2.Items.Add(new ListItem("NONE", "NONE"));
            ddlbasecode2.Style["display"] = "none";
        }

    }
}
