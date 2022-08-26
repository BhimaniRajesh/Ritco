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

public partial class GUI_admin_CustomerGroupMaster_CustomerGroupMasterEdit : System.Web.UI.Page
{
    SqlConnection cn; // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());

    //public static string tCstGrpCd;

    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (IsPostBack == false)
        {

 

            ddCstGrp.Items.Add("--Select--");
            cn.Open();
            SqlCommand cmd = new SqlCommand("select (GRPNM + ' : ' + GRPCD) as GROUPNM, GRPCD from webx_GRPMST order by GRPNM", cn);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ddCstGrp.Items.Add(new ListItem(dr.GetValue(0).ToString(), dr.GetValue(1).ToString()));  
            }
            dr.Close();
            cn.Close();
        }

    }


   
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("CustomerGroupMasterAdd.aspx");
    }
    //protected void btnCstAdd_Click(object sender, EventArgs e)
    //{
    //    Server.Transfer("CustomerGroupMasterAdd.aspx");
    //}
    protected void btnEdit_Click(object sender, EventArgs e)
    {
            if (txtCstGrpCd.Text == "" && ddCstGrp.SelectedIndex != 0)
            {
            //lblmsg.Text = "*";
            //lblmsg.Focus();
            Session["dCstGrp"] = "";
            Session["tCstGrpCd"] = ddCstGrp.SelectedValue;
         
            Response.Redirect("CustomerGroupMasterEdGet.aspx?para=1");
            }
            else if (txtCstGrpCd.Text != "" && ddCstGrp.SelectedIndex == 0)
            {
            Session["tCstGrpCd"] = txtCstGrpCd.Text;
            Session["dCstGrp"] = "";
            Response.Redirect("CustomerGroupMasterEdGet.aspx?para=1");
            }
            else
            {
            lblmsg.Text = "pls select any one";
            }
    }




    protected void btnlist_Click(object sender, EventArgs e)
    {
        Response.Redirect("ListAll.aspx");
    }
    
    //protected void txtCstGrpCd_TextChanged(object sender, EventArgs e)
    //{
    //    //btnAdd.Enabled = true;
    //    btnEdit.Enabled = true;
    //    btnDelete.Enabled = true; 

    //    //btnCstAdd.Enabled = false;
    //    btnCstEdit.Enabled = false;
    //    btnCstDelete.Enabled = false; 
    //}
    //protected void ddCstGrp_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    //btnAdd.Enabled = false;
    //    btnEdit.Enabled = false;
    //    btnDelete.Enabled = false;

    //    //btnCstAdd.Enabled = true;
    //    btnCstEdit.Enabled = true;
    //    btnCstDelete.Enabled = true; 
        
    //}
    //protected void btnCstEdit_Click(object sender, EventArgs e)
    //{
    //    if (ddCstGrp.SelectedValue == "0")
    //    {
    //        lblmsg.Text = "*";
    //        lblmsg.Focus();
    //    }
    //    else
    //    {
    //        Session["dCstGrp"] = ddCstGrp.SelectedValue;
    //        Session["tCstGrpCd"] = "";
    //        Server.Transfer("CustomerGroupMasterEdGet.aspx");
    //    }
        
    //}
}
