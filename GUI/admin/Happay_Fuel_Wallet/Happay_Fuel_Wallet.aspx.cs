using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebX.Controllers;
using WebX.Entity;

public partial class GUI_admin_Happay_Fuel_Wallet_Happay_Fuel_Wallet : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {
            HappayFuelWalletController obj = new HappayFuelWalletController();
            DataSet ds = obj.GetBankDetails();
            BindBankDetails.DataSource = ds;
            BindBankDetails.DataBind();
        }
    }

    protected void btnStep1_Click(object sender, EventArgs e)
    {
        ddWallet.Enabled = false;
        trstp1btn.Visible = false;
        step2.Visible = true;
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        var objcontroller = new HappayFuelWalletController();
        var objlist = new List<BankFuelTypeRequest>();
        foreach (RepeaterItem item in BindBankDetails.Items)
        {
            var obj = new BankFuelTypeRequest();
            CheckBox chkWallet = item.FindControl("chkWallet") as CheckBox;
            Label lblBankName = item.FindControl("lblBankName") as Label;
            Label lblAccountNo = item.FindControl("lblAccountNo") as Label;
            HiddenField hdnAccCode = item.FindControl("hdnAccCode") as HiddenField;
            if (chkWallet.Checked == true) {
                obj.WalletType = ddWallet.SelectedValue.ToString();
                obj.BankName = lblBankName.Text;
                obj.AccountNo = lblAccountNo.Text;
                obj.BankLeadgerCode = hdnAccCode.Value;
                //obj.LocationCode = XsdCode.Text;
                obj.IsActive = true;
                objlist.Add(obj);
            }
            
            
        }
        objcontroller.InsertBankFuelMapping(objlist);
        Response.Redirect("Done.aspx");
    }
}