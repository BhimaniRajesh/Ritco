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

public partial class GUI_admin_CustomerMaster_CustomerMaster : System.Web.UI.Page
{
    SqlConnection cn;  // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    public static string chk1="";

    protected void Page_Load(object sender, EventArgs e)
    {
      if (IsPostBack == false)
      {

          if (chk.Checked = true)
          {
              popcstgrp();

          }
          else
          {
              ddCst.Items.Clear();
              ddCstGrp.Items.Clear();
              ddCstGrp.Items.Add("--Select--");
              ddCst.Items.Add("--Select--");

          }


      }

      if (chk.Checked == true)
      {
          popcstgrp();

      }
      else
      {
          ddCst.Items.Clear();
          ddCstGrp.Items.Clear();
          ddCstGrp.Items.Add("--Select--");
          ddCst.Items.Add("--Select--");

      }
       

         
       
    }


    public void popcstgrp()
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        ddCstGrp.Items.Add("--Select--");
        ddCst.Items.Add("--Select--");
        cn.Open();
        SqlCommand cmd = new SqlCommand("select GRPNM + ' : ' + GRPCD from webx_GRPMST where activeflag='Y' order by GRPNM", cn);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            ddCstGrp.Items.Add(new ListItem(dr.GetValue(0).ToString()));
        }
        dr.Close();
        cn.Close();


    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        string[] strGrpCdSS = ddCstGrp.SelectedValue.Split(':');
        Session["strGrpCdS"] = strGrpCdSS[1].Trim();
        string[] strCstCdPp = ddCst.SelectedValue.Split(':');
        Session["popCustCd"] = strCstCdPp[1].Trim();
        Server.Transfer("CustomerMasterAdd.aspx");
    }
    protected void ddCstGrp_SelectedIndexChanged(object sender, EventArgs e)
    {
        
        if(ddCstGrp.SelectedIndex == 0) 
        {
            //ddCst.Text = "--Select--";
            ddCst.Items.Clear();
        }
        else
        {
            cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            string[] strGrpCd = ddCstGrp.SelectedValue.Split(':');
            cn.Open();
            SqlCommand cmd1 = new SqlCommand("select CUSTNM + ' : ' + CUSTCD from webx_CUSTHDR where GRPCD='" + strGrpCd[1].ToString().Trim() + "' order by CUSTNM", cn);
            SqlDataReader dr1 = cmd1.ExecuteReader();
            ddCst.Items.Clear();
            while (dr1.Read())
            {
                ddCst.Items.Add(new ListItem(dr1.GetValue(0).ToString()));
            }
            dr1.Close();
            cn.Close();
        }
    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
            string[] strGrpCdSS = ddCstGrp.SelectedValue.Split(':');
            Session["strGrpCdS"] = strGrpCdSS[1].Trim();
            string[] strCstCdPp = ddCst.SelectedValue.Split(':');
            Session["popCustCd"] = strCstCdPp[1].Trim();
            Session["tCstCd"] = "";
            Server.Transfer("CustomerMasterEdit.aspx?para="+"1");
    }
    protected void btnQckEdit_Click(object sender, EventArgs e)
    {
        Session["tCstCd"] = txtCstCd.Text.Trim();
        Session["strGrpCdS"] = "";
        Session["popCustCd"] = "";
        Server.Transfer("CustomerMasterEdit.aspx?para=" + "1");
    }
    protected void btnQckLstAll_Click(object sender, EventArgs e)
    {
        if (chk.Checked == true)
        {
            Session["chktrue"] = "true";
        }
        else
        {
            Session["chktrue"] = "false";   
        }
        Server.Transfer("ListAll.aspx");
    }
    protected void btnListing_Click(object sender, EventArgs e)
    {
        if (chk.Checked == true)
        {
            Session["chktrue"] = "true";
        }
        else
        {
            Session["chktrue"] = "false";
        }
        Server.Transfer("ListAll.aspx");

    }
    protected void chk_CheckedChanged(object sender, EventArgs e)
    {
        if (chk.Checked = true)
        {
            chk1 = "Y";
            popcstgrp();

        }
        else
        {
            chk1 = "N";
            ddCst.Items.Clear();
            ddCstGrp.Items.Clear();
            ddCstGrp.Items.Add("--Select All--");
            ddCst.Items.Add("--Select All--");
        
        }
    }
    protected void chk_CheckedChanged1(object sender, EventArgs e)
    {
        //if (chk.Checked = true)
        //{
        //    chk1 = "Y";
        //    popcstgrp();

        //}
        //else
        //{
        //    chk1 = "N";
        //    ddCst.Items.Clear();
        //    ddCstGrp.Items.Clear();
        //    ddCstGrp.Items.Add("--Select All--");
        //    ddCst.Items.Add("--Select All--");

        //}
    }
}
