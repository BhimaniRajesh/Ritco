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

public partial class Finance_Billing_Billsubmission_start : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {


            string scr = @"<script>
                    function update1(elemValue1)
                  {
                     document.getElementById('ctl00_MyCPH1_Party_code').value=elemValue1;
                  }
                  </script>";

            Page.RegisterClientScriptBlock("update1", scr);
            btnPopUp.Attributes.Add("onclick", "window.open('../popup_cust.aspx',null,'left=600, top=100, height=300, width= 400, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');");

        }
        //Session["brcd"] = "PRHO";
        //Session["empcd"] = "p1438";
        Button1.Attributes.Add("onclick", "javascript:return CheckDocketSelection(" + Billno.ClientID + "," + Party_code.ClientID + "," + txtDateFrom.ClientID + "," + txtDateTo.ClientID + ","+txtmanualbillno.ClientID+")");
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string billno;
        billno = Billno.Text.ToString();
        string party_detail = Party_code.Text.ToString();
        string[] party_arr;
        party_arr = party_detail.Split('-');
        string custcd = party_arr[0].ToString();
        Response.Redirect("billmr_step1.aspx?billno=" + billno + "&party_code=" + custcd.ToString() + "&paybas=" + Cbopaybas.SelectedValue.ToString() + "&fromtdate=" + txtDateFrom.Text.ToString() + "&todate=" + txtDateTo.Text.ToString() + "&manualbillno=" + txtmanualbillno.Text.ToString());

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
            //righnow = righnow.AddMonths(-12);
            strrightnow = "01/01/2006";
            txtDateFrom.Text = strrightnow;
        }
    }
   


    protected void Button2_Click(object sender, EventArgs e)
    {
              }
}
