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
        {
            strurl = strurl + "mode=1";
        }
        else if(optdockno.Checked==true)
        {
            strurl = strurl + "mode=0";
        }

        if (radDate.SelectedIndex == 0)
            strurl = strurl + "&type=1";
        else if (radDate.SelectedIndex == 1)
            strurl = strurl + "&type=2";
        else if (radDate.SelectedIndex == 2)
            strurl = strurl + "&type=3";

        strurl = strurl + "&dockno=" + txtdockno.Text;
        strurl = strurl + "&date1=" + txtDateFrom.Text;
        strurl = strurl + "&date2=" + txtDateTo.Text;
        Response.Redirect("DocketList.aspx?" + strurl);
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
