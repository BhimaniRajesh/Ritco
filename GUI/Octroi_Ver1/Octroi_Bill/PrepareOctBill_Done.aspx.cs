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

public partial class GUI_Octroi_Ver1_Octroi_Bill_PrepareOctBill_Done : System.Web.UI.Page
{
    public string BillNo = "";
    protected void Page_Load(object sender, EventArgs e)
    {        
        BillNo = Request.QueryString["billno"].ToString();
       // BillNo = "HQTR/OCT/0900048";
        lblBillNo.Text = BillNo; 
    }
}
