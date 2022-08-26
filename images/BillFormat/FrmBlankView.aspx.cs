using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Finance_BILLING_BillViewPrint_FrmBlankView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblalert.Text = "Sorry!!! Scan Copy Is Not Available";
        lblalert.Font.Bold = true;
    }
}
