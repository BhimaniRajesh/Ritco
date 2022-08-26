using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Finance_VendorCPKMBilling_BillApproval_BillDone : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            var objVendorCPKMBillController = new VendorCPKMBillController();
            gvCPKMBillDT.DataSource = objVendorCPKMBillController.GetCPKMBillList("", "",
               "Done", Request.QueryString["BillNo"]);
            gvCPKMBillDT.DataBind();
        }
    }
}