using DateTimeManager;
using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class GUI_Fleet_Webadmin_Fuel_wfrm_Fuel_Card_Master_Add : System.Web.UI.Page
{
    private void BindData()
    {
        BLL_Fuel fuel_Card = new BLL_Fuel(Session["SqlProvider"].ToString().Trim());
        fuel_Card.BindDDLFuelTypesFromFuelBrand(ddl_Fuel_Type);
        fuel_Card.BindDDLFuelBrandForGivenFuelType(ddl_Fuel_Brand, ddl_Fuel_Type.SelectedValue);
    }

    private void ShowData()
    {
        BLL_Fuel fuel_Card = new BLL_Fuel(Session["SqlProvider"].ToString().Trim());

        if (Request.QueryString["Fuel_Card_ID"].ToString() != "0")
        {
            fuel_Card.GetFuelCardRecord(Convert.ToInt32(Request.QueryString["Fuel_Card_ID"].ToString()));

            lbl_Fuel_Card_ID.Text = fuel_Card.Fuel_Card_ID.ToString();
            tb_Manual_Fuel_Card_No.Text = fuel_Card.Manual_Fuel_Card_No;
            tb_VendorCode.Text = fuel_Card.VendorCode;
            lbl_VendorName.Text = fuel_Card.VendorName;
            dp_Issue_Date.Text = fuel_Card.Issue_Date.ToString("dd/MM/yyyy");
            dp_Expiry_Date.Text = fuel_Card.Expiry_Date.ToString("dd/MM/yyyy");
            tb_Vehicle_No.Text = fuel_Card.Vehicle_No;
            ddl_Fuel_Type.SelectedValue = fuel_Card.Fuel_Type_ID;
            //  First bind the Fuel Brand DropDownList then select
            fuel_Card.BindDDLFuelBrandForGivenFuelType(ddl_Fuel_Brand, ddl_Fuel_Type.SelectedValue);
            ddl_Fuel_Brand.SelectedValue = fuel_Card.Fuel_Brand_ID.ToString();
            chk_Active_Flag.Checked = (fuel_Card.Active_Flag == "Y") ? true : false;
            lbl_Active_Flag.Text = fuel_Card.Active_Flag;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            tb_Manual_Fuel_Card_No.Attributes.Add("OnBlur", "javascript:checkDuplicateFuelCardNo(" + Request.QueryString["Fuel_Card_ID"].ToString() + ", this, " + lbl_Manual_Fuel_Card_Error.ClientID + ");");
            tb_VendorCode.Attributes.Add("OnBlur", "javascript:getVendorDetails(this, " + lbl_VendorName.ClientID + ");");
            chk_Active_Flag.Attributes.Add("OnClick", "javascript:clickYesNo(" + lbl_Active_Flag.ClientID + ");");
            btn_Save.Attributes.Add("OnClick", "javascript:return validateFormFuelCardMaster();");

            BindData();
            ShowData();
        }
    }

    protected void ddl_Fuel_Type_SelectedIndexChanged(object sender, EventArgs e)
    {
        BLL_Fuel fuel_Card = new BLL_Fuel(Session["SqlProvider"].ToString().Trim());
        fuel_Card.BindDDLFuelBrandForGivenFuelType(ddl_Fuel_Brand, ddl_Fuel_Type.SelectedValue);
    }

    protected void btn_Save_Click(object sender, EventArgs e)
    {
        BLL_Fuel fuel_Card = new BLL_Fuel(Session["SqlProvider"].ToString().Trim());

        fuel_Card.Fuel_Card_ID = (Request.QueryString["Fuel_Card_ID"].ToString() == "0") ? 0 : Convert.ToInt32(lbl_Fuel_Card_ID.Text);
        fuel_Card.Manual_Fuel_Card_No = tb_Manual_Fuel_Card_No.Text;
        fuel_Card.VendorCode = tb_VendorCode.Text;
        fuel_Card.Issue_Date = DTM.ConvertToShortDate(dp_Issue_Date.Text);
        fuel_Card.Expiry_Date = DTM.ConvertToShortDate(dp_Expiry_Date.Text);
        fuel_Card.Vehicle_No = tb_Vehicle_No.Text;
        fuel_Card.Fuel_Type_ID = ddl_Fuel_Type.SelectedValue;
        fuel_Card.Fuel_Brand_ID = Convert.ToInt32(ddl_Fuel_Brand.SelectedValue);
        fuel_Card.Active_Flag = (chk_Active_Flag.Checked) ? "Y" : "N";

        try
        {
            fuel_Card.SaveFuelCardRecord();
            Response.Redirect("wfrm_Fuel_Card_Master_Edit.aspx");
        }
        catch (Exception exc)
        {
            lbl_Page_Error.Text = exc.Message.ToString();
        }
    }
}
