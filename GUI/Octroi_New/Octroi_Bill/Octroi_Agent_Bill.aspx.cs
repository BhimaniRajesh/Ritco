using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class GUI_Octroi_New_Octroi_Bill_Octroi_Agent_Bill : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        txtBillDate.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
        txtDueDate.Text = System.DateTime.Now.AddDays(15).ToString("dd/MM/yyyy");
    }

}
