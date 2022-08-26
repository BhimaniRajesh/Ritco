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

public partial class GUI_finance_advice_AdviceCancel_step1 : System.Web.UI.Page
{
    MyFunctions myFunc;
    string connStr;
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        connStr = Session["SqlProvider"].ToString().Trim();
        //AccountTrans trans = new AccountTrans();
        //string vchrno = trans.genVoucherNo("HQTR");

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        if (!IsPostBack)
        {
            cmdctrpopup.Attributes.Add("onClick", "window.open('../../../GUI/Admin/commonPopUp.aspx?popuptype=4&ctrCodeName=" + txtRaisedOn.ClientID + "',null,'height=250, width=300,status= no, resizable= yes, scrollbars=no, toolbar=no,location=no,menubar=no ');");
        }

    }
    protected void cmdSubmit1_Click(object sender, EventArgs e)
    {
        Server.Transfer("AdviceCancel_step2.aspx?AdviceNo=" + txtAdviceNo.Text + "&DateFrom=&DateTo=", true);

    }
    protected void cmdSubmit2_Click(object sender, EventArgs e)
    {
        UserControls_SelectDate date1 = (UserControls_SelectDate)UCSelectDate;
        TextBox datefrom = (TextBox)date1.FindControl("txtDateFrom");
        TextBox dateTo = (TextBox)date1.FindControl("txtDateTo");

        Server.Transfer("AdviceCancel_step2.aspx?AdviceNo=&location=" + txtloccode.Text + "&DateFrom=" + datefrom.Text + "&DateTo=" + dateTo.Text, true);
    }
}
