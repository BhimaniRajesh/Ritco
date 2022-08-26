using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebX.Controllers;
using WebX.Entity;

public partial class GUI_admin_Happay_Fuel_Wallet_Happay_Fuel_Wallet_Edit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnStep1_Click(object sender, EventArgs e)
    {
        step2.Visible = true;
        txtBank.Enabled = false;
        HappayFuelWalletController obj = new HappayFuelWalletController();
        DataSet ds = obj.GetBankDetailsByBankName(hdnBank.Value);
        BindBankDetails.DataSource = ds;
        BindBankDetails.DataBind();
        trstp1btn.Visible = false;
    }

    [WebMethod(EnableSession = true)]
    public static string BankList(string prefixText)
    {
        var objcontroller = new HappayFuelWalletController();
        DataTable dt = new DataTable();
        dt = objcontroller.GetBankList(prefixText);
        if (!(WebxUtils.IsDataTableNullOrEmpty(dt)))
            return JsonConvert.SerializeObject(dt);
        else
            return string.Empty;
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        var objcontroller = new HappayFuelWalletController();
        var objlist = new List<BankFuelTypeRequest>();
        foreach (RepeaterItem item in BindBankDetails.Items)
        {
            var obj = new BankFuelTypeRequest();
            CheckBox IsActive = item.FindControl("IsActive") as CheckBox;
            Label lblBankName = item.FindControl("lblBankName") as Label;
            Label lblAccountNo = item.FindControl("lblAccountNo") as Label;
            HiddenField hdnAccCode = item.FindControl("hdnAccCode") as HiddenField;
            DropDownList ddWallet = item.FindControl("ddWallet") as DropDownList;
            
                obj.WalletType = ddWallet.SelectedValue.ToString();
                obj.BankName = lblBankName.Text;
                obj.AccountNo = lblAccountNo.Text;
                obj.BankLeadgerCode = hdnAccCode.Value;
                //obj.LocationCode = XsdCode.Text;
                obj.IsActive = IsActive.Checked == true ? true : false;
                objlist.Add(obj);
        }
        objcontroller.UpdateBankFuelMapping(objlist);
        Response.Redirect("Done.aspx");
    }
}