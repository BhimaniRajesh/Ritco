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

public partial class GUI_Octroi_ViewnPrint_DirectVoucher_Step1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        btnsubmit.Attributes.Add("onclick","javascript:return requireValidate();");
    }
    int dates = 0;

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
            dates = 0;
        }

        if (rbl.Items[1].Selected)
        {
            righnow = righnow.AddDays(-7);
            strrightnow = righnow.ToString("dd/MM/yyyy");
            txtDateFrom.Text = strrightnow;
            dates = 1;
        }

        if (rbl.Items[2].Selected)
        {
            txtDateFrom.Text = righnow.ToString("dd/MM/yyyy");
            txtDateTo.Text = righnow.ToString("dd/MM/yyyy");
            dates = 2;
        }
    }

    protected void btnsubmit_Click(object sender,EventArgs e)
    {
        string qstr = "";
        if (optdocno.Checked == true)
        {
            qstr = qstr + "type=0";
        }
        else if (optbillno.Checked == true)
        {
            qstr = qstr + "type=1";
        }
        else if (optrecno.Checked == true)
        {
            qstr = qstr + "type=2";
        }
        else
        {
            qstr = qstr + "type=5";
        }

        qstr = qstr + "&dates=" + dates;
        qstr=qstr + "&docno=" + txtdocno.Text;
        qstr=qstr + "&recno=" + txtrecno.Text;
        qstr=qstr + "&billno=" + txtbillno.Text;
        qstr=qstr + "&date1=" + txtDateFrom.Text;
        qstr=qstr + "&date2=" + txtDateTo.Text;
        Response.Redirect("DirectVoucherList.aspx?" + qstr);
    }

}
