using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class GUI_admin_Rules_Rules_DFM : System.Web.UI.Page
{
    string currUser = "";
    private DataTable dtDocTypes
    {
        get 
        {
            if (ViewState["DocTypes"] != null)
                return ViewState["DocTypes"] as DataTable;
            else
                return new DataTable();
        }
        set { ViewState["DocTypes"] = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        currUser = SessionUtilities.CurrentEmployeeID;
        lblMsg.Visible = false;
        if (!IsPostBack)
        {
            dtDocTypes = FMUtility.GetDocTypes("CodeId","ALL");
            reptHdr.DataSource = dtDocTypes;
            reptHdr.DataBind();

            reptRules.DataSource = DFMRules.GetList();
            reptRules.DataBind();
        }
    }
    protected void reptHdr_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {            
            
        }
    }
    protected void reptRules_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DFMRules objDR = e.Item.DataItem as DFMRules;
            List<DFMRules_Details> listDFR = objDR.Details;
            listDFR.Sort(new GenericComparer<DFMRules_Details>("DocType", GenericComparer<DFMRules_Details>.SortOrder.Ascending));
            if (listDFR.Count < dtDocTypes.Rows.Count)
            {
                int diff = dtDocTypes.Rows.Count - listDFR.Count;
                for (int i = 0; i < diff; i++)
                {
                    listDFR.Add(new DFMRules_Details());
                }
            }
            Repeater reptDocTyp = e.Item.FindControl("reptDocTyp") as Repeater;
            DropDownList ddlDefValue = e.Item.FindControl("ddlDefValue") as DropDownList;
            Label lblRuleID = e.Item.FindControl("lblRuleID") as Label;

            lblRuleID.Text = objDR.CodeID;

            ddlDefValue.DataSource = DFM_Rules_NameValues.GetRuleValues(objDR.CodeID,"0");
            ddlDefValue.DataTextField = "Name";
            ddlDefValue.DataValueField = "Value";
            ddlDefValue.DataBind();
            ddlDefValue.SelectedValue = objDR.DefaultValue;            
            reptDocTyp.DataSource = listDFR;
            reptDocTyp.DataBind();
        }
    }
    protected void reptDocTyp_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DFMRules_Details objDrd = e.Item.DataItem as DFMRules_Details;

            DropDownList ddlValue = e.Item.FindControl("ddlValue") as DropDownList;
            ddlValue.DataSource = DFM_Rules_NameValues.GetRuleValues(objDrd.RuleID,objDrd.DocType);
            ddlValue.DataTextField = "Name";
            ddlValue.DataValueField = "Value";
            ddlValue.DataBind();
            ddlValue.SelectedValue = objDrd.SetValue;
            if (objDrd.ActiveFlag != "Y" || objDrd.Enable != "Y")
                ddlValue.Enabled = false;
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            foreach (RepeaterItem ri in reptRules.Items)
            {
                CheckBox chkEdit = ri.FindControl("chkEdit") as CheckBox;
                if (chkEdit.Checked)
                {
                    Label lblRuleID = ri.FindControl("lblRuleID") as Label;
                    DropDownList ddlDefValue = ri.FindControl("ddlDefValue") as DropDownList;
                    Repeater reptDocTyp = ri.FindControl("reptDocTyp") as Repeater;
                    
                    DFMRules objDFR = DFMRules.GetByCodeID(lblRuleID.Text);
                    objDFR.DefaultValue = ddlDefValue.SelectedValue;
                    objDFR.UpdateBy = currUser;
                    objDFR.UpdateDate = DateTime.Now;

                    List<DFMRules_Details> listDeatils = new List<DFMRules_Details>();
                    foreach (RepeaterItem itm in reptDocTyp.Items)
                    {
                        DropDownList ddlValue = itm.FindControl("ddlValue") as DropDownList;
                        HiddenField hidID = itm.FindControl("hidID") as HiddenField;

                        DFMRules_Details objDRD = DFMRules_Details.GetByID(Convert.ToInt32(hidID.Value));
                        objDRD.SetValue = ddlValue.SelectedValue;
                        objDRD.DefaultValue = ddlDefValue.SelectedValue;
                        objDRD.UpdateBy = currUser;
                        objDRD.UpdateDate = DateTime.Now;
                        listDeatils.Add(objDRD);
                    }
                    objDFR.Details = listDeatils;
                    if (!DFMRules.Update(objDFR))
                        throw new Exception("Fail to update rules");

                    showMessage("Rules updated successfully.", false);
                }
            }
        }
        catch (Exception ex)
        {
            showMessage(ex.Message, true);
        }
    }
    private void showMessage(string strMsg, bool isError)
    {
        if (isError)
        {
            lblMsg.Text = strMsg;
            lblMsg.ForeColor = System.Drawing.Color.Red;
            lblMsg.Visible = true;
        }
        else
        {
            lblMsg.Text = strMsg;
            lblMsg.ForeColor = System.Drawing.Color.Black;
            lblMsg.Visible = true;
        }
    }
}
