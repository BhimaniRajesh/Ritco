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

public partial class GUI_admin_DocketPrint_DocketList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        btnsubmit.Attributes.Add("onclick", "javascript:return dateValidate()");
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        string strurl = "";
        if (optdate.Checked == true)
            strurl = "tp=1";
        else
            strurl = "tp=0";

        strurl = strurl + "&date1=" + txtDateFrom.Text;
        strurl = strurl + "&date2=" + txtDateTo.Text;
        strurl = strurl + "&partycode=" + txtpartycode.Text.Trim();
        strurl = strurl + "&dockno=" + txtdockno.Text;
        
        Response.Redirect("DocketEditList.aspx?" + strurl);
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

        if (rbl.Items[2].Selected)
        {
            txtDateFrom.Text = righnow.ToString("dd/MM/yyyy");
            txtDateTo.Text = righnow.ToString("dd/MM/yyyy");
        }
    }
}
