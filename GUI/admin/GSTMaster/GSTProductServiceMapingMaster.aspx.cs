using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_admin_GSTMaster_GSTProductServiceMapingMaster : BasePage
{
    public DataTable dtServiceTypeList
    {
        get { return ViewState["dtServiceTypeList"] != null ? (DataTable)ViewState["dtServiceTypeList"] : new DataTable(); }
        set { ViewState["dtServiceTypeList"] = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadGeneralMasterData();
            LoadProductServiceMappingData();
        }
        msgBox.Hide();
    }

    private void LoadProductServiceMappingData()
    {

        try
        {
            GSTMasterController objGSTMaster = new GSTMasterController();
            DataTable dt = objGSTMaster.GetProductServiceMappingDetails().Tables[0];
            rp_ProductServiceMapping.DataSource = dt;
            rp_ProductServiceMapping.DataBind();
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
            dtServiceTypeList = GeneralMasterUtilities.GetGeneralMaster("SVRTYPE");
            
        }
        catch (Exception)
        {
            throw;
        }
    }

    
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            List<ProductServiceMappingMasterEntity> objProductSerivceMapping = new List<ProductServiceMappingMasterEntity>();
            bool IsValid = true;
            string msg = "";
            foreach (RepeaterItem item in rp_ProductServiceMapping.Items)
            {
                HiddenField hdnProductType = (HiddenField)item.FindControl("hdnProductType");
                DropDownList ddlServiceType = (DropDownList)item.FindControl("ddlServiceType");

                if (ddlServiceType.SelectedValue != "")
                {
                    objProductSerivceMapping.Add(new ProductServiceMappingMasterEntity() { ProductType = hdnProductType.Value, ServiceType = ddlServiceType.SelectedValue, EntryBy = SessionUtilities.CurrentEmployeeID });
                }
                //else
                //{
                //    msg = "Please select Service Type.";
                //    IsValid = false;
                //    break;
                //}
            }

            if (IsValid)
            {
                GSTMasterController objGSTMasterController = new GSTMasterController();

                string GSTSacResult = objGSTMasterController.SaveProductSerivceMapping(objProductSerivceMapping);
                if (GSTSacResult == "1")
                {
                    pnl_Mapping.Visible = false;
                    lblMsg.Text = "Product Service Type Mapping details saved successfully.";
                    tblDetailSaved.Visible = true;
                    return;
                }
                else
                {
                    pnl_Mapping.Visible = false;
                    lblMsg.Text = "Fail to save Product Service Type Mapping details. Try after sometime.";
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
    protected void rp_ProductServiceMapping_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DropDownList ddlServiceType = (DropDownList)e.Item.FindControl("ddlServiceType");
            HiddenField hdnSeriviceType = (HiddenField)e.Item.FindControl("hdnSeriviceType");
            HiddenField hdnProductType = (HiddenField)e.Item.FindControl("hdnProductType");
            
            ddlServiceType.DataSource = dtServiceTypeList;
            ddlServiceType.DataBind();
            ddlServiceType.Items.Insert(0, new ListItem() { Text = "Select Service Type", Value = "", Selected = true });

            if (hdnSeriviceType.Value != "")
            {
                ddlServiceType.SelectedValue = hdnSeriviceType.Value;
            }
 
        }
    }
}