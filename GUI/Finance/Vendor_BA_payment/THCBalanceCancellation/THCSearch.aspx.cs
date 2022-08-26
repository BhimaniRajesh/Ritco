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
using System.Data.SqlClient;

public partial class GUI_Finance_Vendor_BA_payment_THCBalanceCancellation_THCSearch : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            System.DateTime righnow1 = System.DateTime.Today;
            string strrightnow1 = righnow1.ToString("dd/MM/yyyy");
        }

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    }
    
    protected void btnsubmit1_Click(object sender, EventArgs e)
    {
        string final = "?DocumentNo=" + txtDocNo.Text;
        final += "&THCNO=" + txtTHCNO.Text;
        Response.Redirect("THCSelection.aspx" + final);
    }
}
