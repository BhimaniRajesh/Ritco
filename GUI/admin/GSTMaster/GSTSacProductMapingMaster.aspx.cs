using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_admin_GSTMaster_GSTSacProductMapingMaster : BasePage
{
    public DataTable dtSACCategory
    {
        get { return ViewState["dtSACCategory"] != null ? (DataTable)ViewState["dtSACCategory"] : new DataTable(); }
        set { ViewState["dtSACCategory"] = value; }
    }

    //public DataTable dtServiceType
    //{
    //    get { return ViewState["dtServiceType"] != null ? (DataTable)ViewState["dtServiceType"] : new DataTable(); }
    //    set { ViewState["dtServiceType"] = value; }
    //}

    public DataTable dtSACDetails
    {
        get { return ViewState["dtSACDetails"] != null ? (DataTable)ViewState["dtSACDetails"] : new DataTable(); }
        set { ViewState["dtSACDetails"] = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadGeneralMasterData();
            LoadSACGSTProductMappingData();
        }
        msgBox.Hide();
    }

    private void LoadSACGSTProductMappingData()
    {
        try
        {
            GSTMasterController objGSTMaster = new GSTMasterController();

            dtSACDetails = objGSTMaster.GetSACGSTDetails();
            if (dtSACDetails != null && dtSACDetails.Rows.Count > 0)
            {

                var SAC = (from sac in dtSACDetails.AsEnumerable()
                           select new
                           {
                               SACCategory = Convert.ToString(sac["SACCategory"]),
                               SACCode = Convert.ToString(sac["SACCode"]),
                               GSTRate = Convert.ToDecimal(sac["GSTRate"]),
                               IsRCMApplicable = (Convert.ToInt16(sac["IsRCMApplicable"]) == 0 ? "No" : "Yes")
                           });

                hdnSACGSTDetails.Value = JsonConvert.SerializeObject(SAC);
            }
            DataTable dt = objGSTMaster.GetSACGSTProductMappingDetails();

            rp_Product_SAC_Master.DataSource = dt;
            rp_Product_SAC_Master.DataBind();
        }
        catch (Exception ex)
        {
            throw;
        }
    }

    private void LoadGeneralMasterData()
    {
        try
        {
            dtSACCategory = GeneralMasterUtilities.GetGeneralMaster("SACGSTCAT");
            //dtServiceType = objGeneralMaster.GetGeneralMasterDataByCodeType("TRN");
        }
        catch (Exception)
        {
            throw;
        }
    }

    protected void rp_Product_SAC_Master_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DropDownList ddlSACCategory = (DropDownList)e.Item.FindControl("ddlSACCategory");
            HiddenField hdnSACCategory = (HiddenField)e.Item.FindControl("hdnSACCategory");

            ddlSACCategory.DataSource = dtSACCategory;
            ddlSACCategory.DataBind();
            ddlSACCategory.Items.Insert(0, new ListItem() { Text = "Select SAC Category", Value = "", Selected = true });
            if (hdnSACCategory.Value != "")
            {
                ddlSACCategory.SelectedValue = hdnSACCategory.Value;
            }

            Label lblIsRCMApplicable = (Label)e.Item.FindControl("lblIsRCMApplicable");
            HiddenField hdnIsRCMApplicable = (HiddenField)e.Item.FindControl("hdnIsRCMApplicable");
            if (hdnIsRCMApplicable.Value != "")
            {
                lblIsRCMApplicable.Text = (Convert.ToBoolean(hdnIsRCMApplicable.Value) ? "Yes" : "No");
            }
            else
            {
                lblIsRCMApplicable.Text = "";
            }

            Label lblGSTRate = (Label)e.Item.FindControl("lblGSTRate");
            HiddenField hdnGSTRate = (HiddenField)e.Item.FindControl("hdnGSTRate");
            if (hdnGSTRate.Value != "" && (Convert.ToDecimal(hdnGSTRate.Value)) > 0)
            {
                lblGSTRate.Text = hdnGSTRate.Value + " %";
            }
            else {
                lblGSTRate.Text = "";
            }
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            List<GSTSacProductMappingMasterEntity> objGSTSacProductMapping = new List<GSTSacProductMappingMasterEntity>();
            bool IsValid = true;
            string msg = "";
            foreach (RepeaterItem item in rp_Product_SAC_Master.Items)
            {
                HiddenField hdnServiceType = (HiddenField)item.FindControl("hdnServiceType");
                DropDownList ddlSACCategory = (DropDownList)item.FindControl("ddlSACCategory");

                if (ddlSACCategory.SelectedValue != "")
                {
                    objGSTSacProductMapping.Add(new GSTSacProductMappingMasterEntity() { ServiceType = hdnServiceType.Value, SACCategory = ddlSACCategory.SelectedValue, EntryBy = SessionUtilities.CurrentEmployeeID });
                }
                else
                {
                    msg = "Please select SAC Category.";
                    IsValid = false;
                    break;
                }
            }

            if (IsValid)
            {
                GSTMasterController objGSTMasterController = new GSTMasterController();

                string GSTSacResult = objGSTMasterController.SaveGSTSacProductMapping(objGSTSacProductMapping);
                if (GSTSacResult == "1")
                {
                    pnl_GST_SAC_Mapping.Visible = false;
                    lblMsg.Text = "GST SAC Product Mapping details saved successfully.";
                    tblDetailSaved.Visible = true;
                    return;
                }
                else
                {
                    pnl_GST_SAC_Mapping.Visible = false;
                    lblMsg.Text = "Fail to save GST SAC Product Mapping details. Try after sometime.";
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
}