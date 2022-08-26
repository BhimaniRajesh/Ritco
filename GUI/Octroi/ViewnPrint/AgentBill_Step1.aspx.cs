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

public partial class GUI_Octroi_AgentBill_Step1 : System.Web.UI.Page
{
    public static string Locationstr = "";
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        Locationstr = fn.getLocationStr();
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        
        

        string scr1 = @"<script>
        function update1111(elemValue)
        {        
        document.getElementById('ctl00_MyCPH1_txtoctloc').value=elemValue;        
        }
        </script>";

        Page.RegisterClientScriptBlock("update1", scr1);
        btnPopUp.Attributes.Add("onclick", "window.open('popup-agent.aspx',null,'left=600, top=100, height=300, width= 450, status=no, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');");
        btnsubmit2.Attributes.Add("onclick","javascript:return requireCheck()");

        string sql = "SELECT * FROM webx_Vendor_HDR WHERE VENDOR_TYPE='1'";
        con.Open();
        SqlCommand cmd = new SqlCommand(sql,con);
        SqlDataReader dr=cmd.ExecuteReader();
        while (dr.Read())
        {
            cmbselcust.Items.Add(dr["vendorname"].ToString());
        }
        dr.Close();
        con.Close();
    }

    protected void btnsubmit1_Click(object sender,EventArgs e)
    {
        string param="";

        param = param + "type=0";
        param = param + "&billno=" + txtbillno.Text;
        param = param + "&location=" + txtoctloc.Text;
        param = param + "&customer=" + cmbselcust.Text;
        param = param + "&date1=" + txtDateFrom.Text;
        param = param + "&date2=" + txtDateTo.Text;
        Response.Redirect("AgentBillList.aspx?" + param);
    }

    protected void btnsubmit2_Click(object sender, EventArgs e)
    {
        string param = "";

        if (radDate.SelectedIndex == 0)
        {
            param = param + "type=1";    
        }
        else if (radDate.SelectedIndex == 1)
        {
            param = param + "type=2";    
        }
        else if (radDate.SelectedIndex == 1)
        {
            param = param + "type=3";
        }

        param = param + "&billno=" + txtbillno.Text;
        param = param + "&location=" + txtoctloc.Text;
        param = param + "&customer=" + cmbselcust.Text;
        param = param + "&date1=" + txtDateFrom.Text;
        param = param + "&date2=" + txtDateTo.Text;
        Response.Redirect("AgentBillList.aspx?" + param);

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
