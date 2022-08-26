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

public partial class GUI_Finance_Advice_Generation_AdviceAcknowledged : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtAdviceNo.Attributes.Add("onblur", "AdviceBlur('" + txtAdviceNo.ClientID.ToString() + "')");
            txtDateFrom.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtDateTo.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
        }
    }
    protected void adv_submitclick_1(object sender, EventArgs e)
    {
        Response.Redirect("AdviceAcknowledged_step2.aspx?adviceno=" + txtAdviceNo.Text + "&option=1");
    }
    protected void adv_submitclick_2(object sender, EventArgs e)
    {
        Response.Redirect("AdviceAcknowledged_step2.aspx?DateFrom=" + txtDateFrom.Text + "&DateTo=" + txtDateTo.Text + "&option=2");
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
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
        }
        if (rbl.Items[0].Selected)
        {
            txtDateFrom.Text = "";
            txtDateTo.Text = "";
        }
        if (rbl.Items[1].Selected)
        {
            txtDateFrom.Text = strrightnow;
            txtDateTo.Text = strrightnow;
        }
        if (rbl.Items[2].Selected)
        {
            txtDateTo.Text = strrightnow;
            righnow = righnow.AddDays(-7);
            strrightnow = righnow.ToString("dd/MM/yyyy");
            txtDateFrom.Text = strrightnow;
        }
    }

}
