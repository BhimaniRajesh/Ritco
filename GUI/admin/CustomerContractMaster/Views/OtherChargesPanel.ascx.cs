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
using System.Collections.Generic;

public partial class Views_OtherChargesPanel : System.Web.UI.UserControl
{
    public string ContractID { get { return (ViewState["OCP_ContractID"] != null) ? ViewState["OCP_ContractID"].ToString() : ""; } set { ViewState["OCP_ContractID"] = value; } }
    string strBaseOn = "";
    string ConnStr = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        ConnStr = SessionUtilities.ConnectionString;

        if (!IsPostBack)
        {
            BindData();
            menuTabs.Items[0].Selected = true;
            AddView(menuTabs.Items[0]);
        }
    }
    protected void menuTabs_MenuItemClick(object sender, MenuEventArgs e)
    {
        AddView(e.Item);
    }

    private void BindData()
    {
        strBaseOn = DocketRules.GetDefaultValue("CHRG_RULE");

        if (strBaseOn.CompareTo("NONE") == 0)
        {
            strBaseOn = "NONE";
            DataTable dt = new DataTable();
            dt.Columns.Add("CodeID");
            dt.Columns.Add("CodeDesc");
            dt.Rows.Add("NONE", "NONE");
            GenerateTabs(dt);
        }
        else if (strBaseOn.CompareTo("SVCTYP") == 0)
        {
            GetServiceTypes();
        }
        else if (strBaseOn.CompareTo("BUT") == 0)
        {
            GetBusTypes();
        }
        menuTabs.Items[0].Selected = true;
        AddView(menuTabs.SelectedItem);
    }

    private void GetBusTypes()
    {
        DataTable dt = DataProvider.GetActiveGeneralMaster("BUT");
        GenerateTabs(dt);
    }
    private void GetServiceTypes()
    {
        DataTable dt = DataProvider.GetActiveGeneralMaster("SVCTYP");
        GenerateTabs(dt);
    }
    private void GenerateTabs(DataTable dt)
    {
        menuTabs.Items.Clear();
        foreach (DataRow dr in dt.Rows)
        {
            MenuItem mi = new MenuItem(dr["CodeDesc"].ToString(), dr["CodeID"].ToString());
            menuTabs.Items.Add(mi);
        }
    }
    private void bindNone()
    { 
        
    }
    private void AddView(MenuItem mi)
    {
        View v = multiTabs.Views[0];
        strBaseOn = DocketRules.GetDefaultValue("CHRG_RULE");
        StanderdCharge sg = v.FindControl("ucCharges") as StanderdCharge;
        sg.ContractID = ContractID;
        sg.BasedOn = strBaseOn;
        sg.BaseCode = mi.Value;
        sg.ReBind();
    }
}
