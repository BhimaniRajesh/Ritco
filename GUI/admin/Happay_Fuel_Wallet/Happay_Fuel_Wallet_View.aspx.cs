using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebX.Controllers;


public partial class GUI_admin_Happay_Fuel_Wallet_Happay_Fuel_Wallet_View : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    DataSet ds = new DataSet();
    protected void btnView_Click(object sender, EventArgs e)
    {
        view.Visible = true;
        XlSDownload.Visible = true;

        HappayFuelWalletController obj = new HappayFuelWalletController();
        
        ds = obj.GetBankFuelMapping(ddWallet.SelectedValue.ToString());
        BindFuelBankTypeDetails.DataSource = ds;
        BindFuelBankTypeDetails.DataBind();
    }
    protected void XlSDownload_Click(object sender, EventArgs e)
    {
        try
        {
            HappayFuelWalletController obj = new HappayFuelWalletController();
            ds = obj.GetBankFuelMapping(ddWallet.SelectedValue.ToString());
            ExcelUtilities Exlobj = new ExcelUtilities();
            Exlobj.ExportExcel_XLSX(ds, "BankFuelTypeMapping.xlsx");
        }
        catch (Exception ex)
        {
            //Exception Message Here
        }
    }
}