using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_admin_GSTMaster_GSTSacMaster : BasePage
{

    public DataTable dtSACCategory
    {
        get { return ViewState["dtSACCategory"] != null ? (DataTable)ViewState["dtSACCategory"] : new DataTable(); }
        set { ViewState["dtSACCategory"] = value; }
    }

    public DataTable dtSACDetails
    {
        get { return ViewState["dtSACDetails"] != null ? (DataTable)ViewState["dtSACDetails"] : new DataTable(); }
        set { ViewState["dtSACDetails"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadData();
        }
        msgBox.Hide();
    }

    private void LoadData()
    {
        try
        {
            GSTMasterController objGSTMaster = new GSTMasterController();
            DataTable dt = objGSTMaster.GetSACGSTDetails();

            rp_GST_SAC.DataSource = dt;
            rp_GST_SAC.DataBind();
        }
        catch (Exception ex)
        {
            throw;
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            List<GSTSacMasterEntity> objGSTSacMaster = new List<GSTSacMasterEntity>();
            bool IsValid = true;
            Regex regx = new Regex("^[a-zA-Z0-9]*$");
            decimal GSTRate = 0;
            string msg = "";
            foreach (RepeaterItem item in rp_GST_SAC.Items)
            {
                HiddenField hdnSACCategory = (HiddenField)item.FindControl("hdnSACCategory");
                TextBox txtSACCode = (TextBox)item.FindControl("txtSACCode");
                HiddenField hdnSACCode = (HiddenField)item.FindControl("hdnSACCode");
                TextBox txtGSTRate = (TextBox)item.FindControl("txtGSTRate");
                RadioButtonList rbtnRCMApplicable = (RadioButtonList)item.FindControl("rbtnRCMApplicable");

                GSTRate = 0;

                if (!regx.IsMatch(txtSACCode.Text.Trim()))
                {
                    msg = "SAC Code must be alphanumeric value.";
                    IsValid = false;
                    break;
                }

                if (!decimal.TryParse(txtGSTRate.Text, out GSTRate))
                {
                    msg = "GST Rate must be numeric or 2 digit decimal value in range of 1 to 100.";
                    IsValid = false;
                    break;
                }

                objGSTSacMaster.Add(new GSTSacMasterEntity() { SACCategory = hdnSACCategory.Value, SACCode = txtSACCode.Text.Trim(), GSTRate = GSTRate, IsRCMApplicable = (rbtnRCMApplicable.SelectedValue == "1" ? true : false), EntryBy = SessionUtilities.CurrentEmployeeID });
            }

            if (IsValid)
            {
                GSTMasterController objGSTMasterController = new GSTMasterController();

                string GSTSacResult = objGSTMasterController.SaveGSTSacRate(objGSTSacMaster);
                if (GSTSacResult == "1")
                {
                    pnl_GST_SAC.Visible = false;
                    lblMsg.Text = "GST SAC Rate saved successfully.";
                    tblDetailSaved.Visible = true;
                    return;
                }
                else
                {
                    pnl_GST_SAC.Visible = false;
                    lblMsg.Text = "Fail to save GST SAC Rates. Try after sometime.";
                    tblDetailSaved.Visible = true;
                    return;
                }
            }
            else
            {
                MsgBox.Show(msg);
                return;
            }
        }
        catch (Exception ex)
        {
            MsgBox.Show(ex.Message);
        }
    }

    protected void rp_GST_SAC_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DropDownList ddlsac = (DropDownList)e.Item.FindControl("ddlSAC");
            HiddenField hdnRCMApplicable = (HiddenField)e.Item.FindControl("hdnRCMApplicable");
            RadioButtonList rbtnRCMApplicable = (RadioButtonList)e.Item.FindControl("rbtnRCMApplicable");

            HiddenField hdnSACCode = (HiddenField)e.Item.FindControl("hdnSACCode");
            TextBox txtSACCode = (TextBox)e.Item.FindControl("txtSACCode");

            //if (!string.IsNullOrEmpty(hdnSACCode.Value))
            //{
            //    txtSACCode.Enabled = false;
            //}
            //else
            //{
            //    txtSACCode.Enabled = true;
            //}

            if (!string.IsNullOrEmpty(hdnRCMApplicable.Value))
            {
                rbtnRCMApplicable.SelectedValue = Convert.ToInt16(Convert.ToBoolean(hdnRCMApplicable.Value)).ToString();
            }
        }
    }
}