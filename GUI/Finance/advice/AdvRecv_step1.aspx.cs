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

public partial class GUI_finance_advice_AdvRecv_step1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void cmdSubmit1_Click(object sender, EventArgs e)
    {
        Response.Redirect("AdvRecv_step2.aspx?AdviceNo=" + txtAdviceNo.Text + "&DateFrom=" +""+ "&DateTo=" + "" + "", true);
        
    }
    protected void cmdSubmit2_Click(object sender, EventArgs e)
    {
        UserControls_SelectDate date1 = (UserControls_SelectDate)UCSelectDate;
        TextBox datefrom =(TextBox) date1.FindControl("txtDateFrom");
        TextBox dateTo = (TextBox)date1.FindControl("txtDateTo");
        
        Server.Transfer("AdvRecv_step2.aspx?AdviceNo=&DateFrom=" + datefrom.Text+"&DateTo=" + dateTo.Text , true);
    }
}
