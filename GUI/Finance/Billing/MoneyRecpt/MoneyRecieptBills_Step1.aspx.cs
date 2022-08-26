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

public partial class GUI_Finance_MoneyRecpt_MoneyRecieptBills_Step1 : System.Web.UI.Page
{
    public static string Locationstr = "";
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        string scr1 = @"<script>
        function update1111(elemValue)
        {        
        document.getElementById('ctl00_MyCPH1_txtoctloc').value=elemValue;        
        }
        </script>";

        Page.RegisterClientScriptBlock("update1", scr1);
        btnsubmit.Attributes.Add("onclick", "javascript:return validateData()");

    }

   
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        string param = "";

        if (optdate.Checked == true)
        {
            param = param + "&mrno="; 
            param = param + "&mrtype=" + cmbmrtype.Text;
            param = param + "&docno=";
            param = param + "&docsf=";
            param = param + "&date1=" + txtDateFrom.Text;
            param = param + "&date2=" + txtDateTo.Text;
            Response.Redirect("MoneyRecieptBillsList.aspx?" + param);
        }
        else if (optmrno.Checked == true)
        {
            param = param + "&mrno=" + txtmrno.Text;
            param = param + "&mrtype=";
            param = param + "&docno=";
            param = param + "&docsf=";
            param = param + "&date1=";
            param = param + "&date2=";
            Response.Redirect("MoneyRecieptBillsList.aspx?" + param);
        }
        else if (optdocno.Checked == true)
        {
            param = param + "&mrno=";
            param = param + "&mrtype=";
            param = param + "&docno=" + txtdocno.Text;
            param = param + "&docsf=" + txtdocsf.Text;
            param = param + "&date1=";
            param = param + "&date2=";
            Response.Redirect("MoneyRecieptBillsList.aspx?" + param);
        }


        // executin sp webx_MR_vplist 
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
