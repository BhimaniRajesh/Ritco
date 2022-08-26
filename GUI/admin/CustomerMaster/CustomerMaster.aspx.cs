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
      if (!IsPostBack)
      {

          if (chk.Checked = true)
          {
              popcstgrp();

          }
          else
          {
              //ddCst.Items.Clear();
              //ddCst.Items.Add("--Select--");
              ddCstGrp.Items.Clear();
              ddCstGrp.Items.Add("--Select--");
              

          }


      }

      
       

         
       
    }


    public void popcstgrp()
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        //ddCstGrp.Items.Add("--Select--");
        //ddCst.Items.Add("--Select--");
        cn.Open();
        SqlCommand cmd = new SqlCommand("select '--Select--' as a,'--Select--' as grpcd ,'' AS GRPNM union select GRPNM + ' : ' + GRPCD as a,grpcd ,GRPNM AS GRPNM from webx_GRPMST where activeflag='Y' order by GRPNM", cn);
        SqlDataAdapter dda = new SqlDataAdapter(cmd);
        DataSet dds = new DataSet();
        dda.Fill(dds);

        ddCstGrp.DataSource = dds;
        ddCstGrp.DataTextField = "a";
        ddCstGrp.DataValueField = "grpcd";
        ddCstGrp.DataBind();

    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        
        Response.Redirect("CustomerMasterAdd.aspx?custgrp="+ ddCstGrp.SelectedValue.ToString());
    }
    protected void ddCstGrp_SelectedIndexChanged(object sender, EventArgs e)
    {
        
        if(ddCstGrp.SelectedIndex == 0) 
        {
            //ddCst.Text = "--Select--";
            //ddCst.Items.Clear();
        }
        else
        {
            cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            string[] strGrpCd = ddCstGrp.SelectedValue.Split(':');
            cn.Open();
            //SqlCommand cmd1 = new SqlCommand("select CUSTNM + ' : ' + CUSTCD from webx_CUSTHDR where GRPCD='" + strGrpCd[1].ToString().Trim() + "' order by CUSTNM", cn);

            SqlCommand cmd = new SqlCommand("select top 1 '--Select--' as a,'--Select--' as CUSTCD from webx_GRPMST  union select CUSTNM + ' : ' + CUSTCD as a, CUSTCD from webx_CUSTHDR where GRPCD='" + ddCstGrp.SelectedValue.ToString() + "'  order by a asc", cn);
            SqlDataAdapter dda = new SqlDataAdapter(cmd);
            DataSet dds = new DataSet();
            dda.Fill(dds);

            //ddCst.DataSource = dds;
            //ddCst.DataTextField = "a";
            //ddCst.DataValueField = "CUSTCD";
            //ddCst.DataBind();

            cn.Close();

        }
    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        Session["g"] = ddCstGrp.SelectedValue.ToString();
            //string[] strGrpCdSS = ddCstGrp.SelectedValue.Split(':');
            Session["strGrpCdS"] = ddCstGrp.SelectedValue.ToString();
        //  string[] strCstCdPp = ddCst.SelectedValue.Split(':');
        //Session["popCustCd"] = ddCst.SelectedValue.ToString();
        Session["popCustCd"] = txtCustomerCode.Text;
        Session["tCstCd"] = "";
            Response.Redirect("CustomerMasterEdit.aspx?para=" + "1");
    }
    protected void btnQckEdit_Click(object sender, EventArgs e)
    {
        Session["g"] = ddCstGrp.SelectedValue.ToString();
        Session["tCstCd"] = txtCstCd.Text.Trim();
        Session["strGrpCdS"] = "";
        Session["popCustCd"] = "";
        Response.Redirect("CustomerMasterEdit.aspx?para=" + "1");
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
        Response.Redirect("ListAll.aspx");
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
            //ddCst.Items.Clear();
            //ddCst.Items.Add("--Select All--");
            ddCstGrp.Items.Clear();
            ddCstGrp.Items.Add("--Select All--");
            
        
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
