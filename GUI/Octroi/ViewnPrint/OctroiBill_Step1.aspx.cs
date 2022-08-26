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

public partial class GUI_Octroi_DirectPayVoucher_ViewPrint2 : System.Web.UI.Page
{
    public static string Locationstr = "";
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //Session["SqlProvider"] = "Data Source=123.108.47.72;Initial Catalog=ptn_live_net;UID=sa;pwd=@ptn$ecfy;";

            Locationstr = fn.getLocationStr();
            lbloctsubmit2.Attributes.Add("onclick", "javascript:return requireValidate()");
            txtoctloc.Attributes.Add("onblur", "javascript:return locCheck(this)");

            SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();

            string str = "SELECT distinct h.custcd,h.custnm from webx_custhdr h  order by custnm";
            SqlCommand cmd = new SqlCommand(str, con);

            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            cmbselcust.Items.Clear();
            cmbselcust.Items.Add(" -- All -- ");
            string custval = "";

            while (dr.Read())
            {
                custval = dr[1].ToString() + " ~ " + dr[0].ToString();
                cmbselcust.Items.Add(new ListItem(custval, dr[0].ToString()));
            }

            dr.Close();
            con.Close();

            string scr3 = @"<script>
                    function update1111(elemValue)
                  {
                     document.getElementById('ctl00_MyCPH1_txtoctloc').value=elemValue;
                     document.getElementById('ctl00_MyCPH1_txtoctloc').focus()
                  }
                  </script>";

            Page.RegisterClientScriptBlock("update1111", scr3);
            btnPopUp.Attributes.Add("onclick", "window.open('popup-branch_level4.aspx',null,'left=300, top=150, height=300, width= 300, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');");
        }

    }

    
    protected void btnoctgo_Click(object sender, EventArgs e)
    {
        string FINAL = "";
        FINAL = FINAL + "type=0";
        FINAL = FINAL + "&billno="+txtoctbillno.Text;
        FINAL = FINAL + "&location=" + txtoctloc.Text;
        FINAL = FINAL + "&customer=" + cmbselcust.Text;
        FINAL = FINAL + "&date1=" + txtDateFrom.Text;
        FINAL = FINAL + "&date2=" + txtDateTo.Text;
        Response.Redirect("OctroiBillList.aspx?" + FINAL);
    }

    protected void lbloctsubmit2_Click(object sender, EventArgs e)
    {
        string FINAL = "";
        
        if (radDate.SelectedIndex==0)
        {
            FINAL = "TYPE=1";
        }
        else if (radDate.SelectedIndex == 1)
        {
            FINAL = "TYPE=2";
        }
        else if (radDate.SelectedIndex == 2)
        {
            FINAL = "TYPE=3";
        }

        FINAL = FINAL + "&billno=" + txtoctbillno.Text;
        FINAL = FINAL + "&location=" + txtoctloc.Text;
        FINAL = FINAL + "&customer=" + cmbselcust.Text;
        FINAL = FINAL + "&date1=" + txtDateFrom.Text;
        FINAL = FINAL + "&date2=" + txtDateTo.Text;
        Response.Redirect("OctroiBillList.aspx?" + FINAL);
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
