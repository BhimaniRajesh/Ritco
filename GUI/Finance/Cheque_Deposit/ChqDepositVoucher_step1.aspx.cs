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

public partial class GUI_Finance_Cheque_Deposit_ChqDepositVoucher_step1 : System.Web.UI.Page
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            txtChqNo.Attributes.Add("onblur", "ChqBlur('" + txtChqNo.ClientID.ToString() + "')");
    }
    //protected void adv_submitclick_1(object sender, EventArgs e)
    //{
    //    Response.Redirect("ChqDepositVoucher_step2.aspx?chqno=" + txtChqNo.Text + "&chqdt=" + HdnChqDt.Value + "&option=1");
    //}
    protected void adv_submitclick_2(object sender, EventArgs e)
    {
        if(txtChqNo.Text == "")
            Response.Redirect("ChqDepositVoucher_step2.aspx?DateFrom=" + txtDateFrom.Text + "&DateTo=" + txtDateTo.Text + "&datetype=" + ddrdatemode.SelectedValue.ToString() + "&option=2");
        else
            Response.Redirect("ChqDepositVoucher_step2.aspx?chqno=" + txtChqNo.Text + "&datetype=" + ddrdatemode.SelectedValue.ToString() + "&option=1");
        
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
