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

public partial class GUI_Operations_Crossing_ViewPrint_CrossingChallanPaymentView1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            System.DateTime righnow1 = System.DateTime.Today;
            string strrightnow1 = righnow1.ToString("dd/MM/yyyy");
            txtDateFrom.Text = strrightnow1;
            txtDateTo.Text = strrightnow1;
        }
    }
    protected void radDate_OnSelectedIndexChange(object sender, EventArgs e)
    {
        txtDateFrom.ReadOnly = false;
        txtDateTo.ReadOnly = false;

        System.DateTime righnow = System.DateTime.Today;
        string strrightnow = righnow.ToString("dd/MM/yyyy");

        RadioButtonList rbl = new RadioButtonList();
        rbl = (RadioButtonList)sender;
        if (!(rbl.Items[0].Selected))
        {
            txtDateFrom.Text = strrightnow;
            txtDateTo.Text = strrightnow;
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
        }

        if (rbl.Items[1].Selected)
        {
            righnow = righnow.AddDays(-7);
            strrightnow = righnow.ToString("dd/MM/yyyy");
            txtDateFrom.Text = strrightnow;
        }

        if (rbl.Items[3].Selected)
        {
            strrightnow = "01/01/2001";
            txtDateFrom.Text = strrightnow;
        }
    }
    protected void btnsubmit1_Click(object sender, EventArgs e)
    {
        string final = "?DocumentNo=" + txtDocNo.Text;
        final += "&dtFrom=" + txtDateFrom.Text;
        final += "&dtTo=" + txtDateTo.Text;
        Response.Redirect("CrossingChallanPaymentView2.aspx" + final);
    }
}
