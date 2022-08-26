using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;

public partial class Finance_Billing_Billgeneration_start : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Session["brcd"] = "PRHO";
        //Session["empcd"] = "p1438";
        //SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
        Button1.Attributes.Add("onclick", "javascript:return CheckDocketSelection(" + Party_code.ClientID + "," + txtDateFrom.ClientID + "," + txtDateTo.ClientID + ")");
        
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        
        conn.Open();
       
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
            
            

            SqlDataReader drpaybas;

            //string sql = "select codetype_new,abbr_type from webx_typemst where billflag='Y'";
            //SqlCommand cmd = new SqlCommand(sql, conn);
            //drpaybas = cmd.ExecuteReader();

            //Cbopaybas.Items.Clear();
            //while (drpaybas.Read())
            //{
            //    Cbopaybas.Items.Add(new ListItem(drpaybas.GetValue(1).ToString(), drpaybas.GetValue(0).ToString()));

            //}
            SqlDataReader drtrnmod;
            //drpaybas.Close();
            string sql1 = "select codeID,codedesc from Webx_Master_General where codetype='trn'";
            SqlCommand cmd1 = new SqlCommand(sql1, conn);
            drtrnmod = cmd1.ExecuteReader();

            Cbotrnmod.Items.Clear();
            Cbotrnmod.Items.Add(new ListItem("All-(Without Road)", "134"));

            while (drtrnmod.Read())
            {
                Cbotrnmod.Items.Add(new ListItem(drtrnmod.GetValue(1).ToString(), drtrnmod.GetValue(0).ToString()));

            }

            drtrnmod.Close();
            conn.Close();

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
            //righnow = righnow.AddMonths(-12);
            strrightnow = "01/01/2006";
            txtDateFrom.Text = strrightnow;
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string party_detail = Party_code.Text.ToString();
        string[] party_arr;
        party_arr = party_detail.Split('~');
        string custcd = party_arr[0].ToString();
        //Response.Write("Cbotrnmod - " + Cbotrnmod.SelectedValue.ToString());
        //Response.End();
        Response.Redirect("genbillsdone.aspx?party_code=" + custcd.ToString() + "&paybas=" + Cbopaybas.SelectedValue.ToString() + "&trnmod=" + Cbotrnmod.SelectedItem.Value.Trim() + "&fromtdate=" + txtDateFrom.Text.ToString() + "&todate=" + txtDateTo.Text.ToString());
    }
    protected void Cbopaybas_SelectedIndexChanged(object sender, EventArgs e)
    {
        
    }
    protected void Cbotrnmod_SelectedIndexChanged(object sender, EventArgs e)
    {
        
    }
}
