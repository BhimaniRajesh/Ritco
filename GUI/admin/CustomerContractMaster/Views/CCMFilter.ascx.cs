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

public partial class GUI_admin_CustomerContractMaster_CCMFilter : System.Web.UI.UserControl
{
    string flagmatrix, flagtransmode, flagbasedon1, flagbasedon2, flagfrom, flagto;

    public string FlagMatrix
    {
        get { return flagmatrix; }
        set { flagmatrix = value; }
    }

    public string FlagTransMode
    {
        get { return flagtransmode; }
        set { flagtransmode = value; }
    }

    public string FlagBasedOn1
    {
        get { return flagbasedon1; }
        set { flagbasedon1 = value; }
    }

    public string FlagBasedOn2
    {
        get { return flagbasedon2; }
        set { flagbasedon2 = value; }
    }

    public string FlagFrom
    {
        get { return flagfrom; }
        set { flagfrom = value; }
    }

    public string FlagTo
    {
        get { return flagto; }
        set { flagto = value; }
    }

    public string From { get { return txtfrom.Text; } set { txtfrom.Text = value; } }
    public string To { get { return txtto.Text; } set { txtto.Text = value; } }
    public string MatrixType { get { return ddlmatrixtype.SelectedValue; } set { ddlmatrixtype.SelectedValue = value; } }
    public string TransMode { get { return ddltransmode.SelectedValue; } set { ddltransmode.SelectedValue = value; } }
    public string BaseCode1 { get { return ddlbasecode1.SelectedValue; } set { ddlbasecode1.SelectedValue = value; } }
    public string BaseCode2 { get { return ddlbasecode2.SelectedValue; } set { ddlbasecode2.SelectedValue = value; } }
    public string BasedOn1 { get { return hdnbasedon1.Value; } set { hdnbasedon1.Value = value; } }
    public string BasedOn2 { get { return hdnbasedon2.Value; } set { hdnbasedon2.Value = value; } }
    
    public GUI_admin_CustomerContractMaster_CCMFilter()
    {
        flagmatrix = "Y"; flagtransmode = "Y"; flagbasedon1 = "Y"; flagbasedon2 = "Y"; flagfrom = "Y"; flagto = "Y";
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack & !Page.IsCallback)
        {
            if (FlagMatrix.CompareTo("N") == 0)
            {
                ddlmatrixtype.SelectedValue = "CLR";
                ddlmatrixtype.Style["display"] = "none";
                lblmatrixtype.Style["display"] = "none";
            }

            if (FlagTransMode.CompareTo("Y") == 0)
            {
                ddltransmode.DataSource = DataProvider.GetActiveGeneralMaster("TRN");
                ddltransmode.DataBind();
                ddltransmode.Items.Insert(0,new ListItem("All", "1234"));
                ddltransmode.SelectedValue = "1234";                
            }
            else
            {
                ddltransmode.Items.Insert(0, new ListItem("All", "1234")); 
                ddltransmode.SelectedValue = "1234";
                ddltransmode.Style["display"] = "none";
                lbltransmode.Style["display"] = "none";
            }
          
            if (FlagBasedOn1.CompareTo("Y") == 0)
            {
                hdnbasedon1.Value = DocketRules.GetDefaultValue("CHRG_RULE");
                ddlbasecode1.DataSource = DataProvider.GetActiveGeneralMaster(hdnbasedon1.Value);
                ddlbasecode1.DataBind();
                lblbasedon1.Text = DataProvider.GetCodeTypeName(hdnbasedon1.Value);

                if (FlagBasedOn2.CompareTo("Y") == 0)
                {
                    ddlbasecode1_SelectedIndexChanged(sender, e);
                }
                else
                {
                    ddlbasecode2.Items.Add(new ListItem("NONE", "NONE"));
                    hdnbasedon2.Value = "NONE";
                    ddlbasecode2.Style["display"] = "none";
                }
            }
            else
            {
                ddlbasecode1.Items.Add(new ListItem("NONE", "NONE"));
                ddlbasecode2.Items.Add(new ListItem("NONE", "NONE"));
                hdnbasedon1.Value = "NONE";
                hdnbasedon2.Value = "NONE";
            }

            if (FlagFrom.CompareTo("N") == 0)
                lblfrom.Style["display"] = "none";
            if (FlagTo.CompareTo("N") == 0)
                lblto.Style["display"] = "none";

            if (FlagMatrix.CompareTo("N") == 0 && FlagTransMode.CompareTo("N") == 0)
                trone.Style["display"] = "none";
            
            if (FlagBasedOn1.CompareTo("N") == 0 && FlagBasedOn1.CompareTo("N") == 0)
                trtwo.Style["display"] = "none";

            if (FlagFrom.CompareTo("N") == 0 && FlagTo.CompareTo("N") == 0)
                trthree.Style["display"] = "none";
        }
        if (FlagMatrix.CompareTo("Y") == 0)
        {
            if (MatrixType != "")
                ddlmatrixtype.SelectedValue = MatrixType;
            else
                ddlmatrixtype.SelectedValue = "CLR";
        }
        if (FlagTransMode.CompareTo("Y") == 0)
        {
            if (TransMode != "")
                ddltransmode.SelectedValue = TransMode;
            else
                ddltransmode.SelectedValue = "1234";
        }
    }

    protected void ddlbasecode1_SelectedIndexChanged(object sender, EventArgs e)
    {
        hdnbasedon2.Value = ChargeMasterController.GetChargeSubRule("DKT", hdnbasedon1.Value, ddlbasecode1.SelectedValue);
        if (FlagBasedOn2.CompareTo("Y") == 0)
        {
            if (hdnbasedon2.Value.CompareTo("NONE") != 0)
            {
                ddlbasecode2.DataSource = DataProvider.GetActiveGeneralMaster(hdnbasedon2.Value);
                ddlbasecode2.DataBind();
                ddlbasecode2.Style["display"] = "block";
                lblbasedon2.Text = DataProvider.GetCodeTypeName(hdnbasedon2.Value);
            }
            else
            {
                ddlbasecode2.Items.Add(new ListItem("NONE", "NONE"));
                ddlbasecode2.Style["display"] = "none";
            }
        }
    }
}
