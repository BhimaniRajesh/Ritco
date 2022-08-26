using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class GUI_Fleet_Webadmin_Fuel_wfrm_Fuel_Brand_Master_Add : System.Web.UI.Page
{
    private void BindData()
    {
        BLL_Fuel fuel_Brand = new BLL_Fuel(Session["SqlProvider"].ToString().Trim());
        fuel_Brand.BindDDLFuelTypes(ddl_Fuel_Type);
    }

    private void ShowData()
    {
        BLL_Fuel fuel_Brand = new BLL_Fuel(Session["SqlProvider"].ToString().Trim());

        if (Request.QueryString["Fuel_Brand_ID"].ToString() != "0")
        {
            fuel_Brand.GetFuelBrandRecord(Convert.ToInt32(Request.QueryString["Fuel_Brand_ID"].ToString()));

            lbl_Fuel_Brand_ID.Text = fuel_Brand.Fuel_Brand_ID.ToString();
            tb_Fuel_Brand_Name.Text = fuel_Brand.Fuel_Brand_Name;
            tb_VendorCode.Text = fuel_Brand.VendorCode;
            lbl_VendorName.Text = fuel_Brand.VendorName;
            ddl_Fuel_Type.SelectedValue = fuel_Brand.Fuel_Type_ID;
            chk_Active_Flag.Checked = (fuel_Brand.Active_Flag == "Y") ? true : false;
            lbl_Active_Flag.Text = fuel_Brand.Active_Flag;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {
            tb_Fuel_Brand_Name.Attributes.Add("OnBlur", "javascript:checkDuplicateFuelBrandName(" + Request.QueryString["Fuel_Brand_ID"].ToString() + ", this, " + lbl_Brand_Error.ClientID + ");");
            tb_VendorCode.Attributes.Add("OnBlur", "javascript:getVendorDetails(this, " + lbl_VendorName.ClientID + ");");
            chk_Active_Flag.Attributes.Add("OnClick", "javascript:clickYesNo(" + lbl_Active_Flag.ClientID + ");");
            btn_Save.Attributes.Add("OnClick", "javascript:return validateFormFuelBrandMaster();");

            BindData();
            ShowData();
        }
    }

    protected void btn_Save_Click(object sender, EventArgs e)
    {
        BLL_Fuel fuel_Brand = new BLL_Fuel(Session["SqlProvider"].ToString().Trim());

        fuel_Brand.Fuel_Brand_ID = (Request.QueryString["Fuel_Brand_ID"].ToString() == "0") ? 0 : Convert.ToInt32(lbl_Fuel_Brand_ID.Text);
        fuel_Brand.Fuel_Brand_Name = tb_Fuel_Brand_Name.Text;
        fuel_Brand.VendorCode = tb_VendorCode.Text;
        fuel_Brand.Fuel_Type_ID = ddl_Fuel_Type.SelectedItem.Value;
        fuel_Brand.Active_Flag = (chk_Active_Flag.Checked) ? "Y" : "N";

        try {
            fuel_Brand.SaveFuelBrandRecord();
            Response.Redirect("wfrm_Fuel_Brand_Master_Edit.aspx");
        }
        catch (Exception exc) {
            lbl_Page_Error.Text = exc.Message.ToString();
        }
    }
}
