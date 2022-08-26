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

public partial class GUI_admin_RoleMaster_ROle_EmoloyeeMaster : System.Web.UI.Page
{
    SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        if (!IsPostBack)
        {
            SqlCommand cmd = new SqlCommand("select srno as RoleId,ROledesc from Webx_Master_Role where ACTIVEFLAG='Y'", conn);
            SqlDataReader dr = cmd.ExecuteReader();
            Int32 i = 0;
            DllRole.Items.Clear();
            DllRole.Items.Add(new ListItem("--Select--", ""));
            while (dr.Read())
            {
                DllRole.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
            }
        }
        conn.Close();
    }
    protected void CheckAll_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow gvr in RIghts.Rows)
        {
            CheckBox cb = (CheckBox)gvr.FindControl("chkRights");
            cb.Checked = true;
        }

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        BtnStep1.Enabled = true;
        DllRole.Enabled = true;

        foreach (GridViewRow gridrow in RIghts.Rows)
        {
            CheckBox ch = (CheckBox)gridrow.FindControl("chkRights");
            HiddenField userid = (HiddenField)gridrow.FindControl("userid");
            TextBox EID= (TextBox)gridrow.FindControl("userEmailid");

            if (ch.Checked == true && EID.Text.ToString() != "")
            {
                string strupdate = "update webx_master_users set emailid='" + EID.Text.ToString() + "',ROLEID='" + DllRole.SelectedValue.ToString() + "' where userid='" + userid.Value.ToString() + "'";
                SqlCommand sqlcmd12 = new SqlCommand(strupdate, conn);
                sqlcmd12.ExecuteNonQuery();
            }
            else if (ch.Checked == false && EID.Text.ToString() != "")
            {
                string strupdate = "update webx_master_users set ROLEID='' where userid='" + userid.Value.ToString() + "'";
                SqlCommand sqlcmd12 = new SqlCommand(strupdate, conn);
                sqlcmd12.ExecuteNonQuery();
            }

        }

       // string strupdate = "update webx_master_users set emailid='"++"',ROLEID'"++"' where userid='"++"'"; 

        Response.Redirect("./../miscellaneous.aspx");
        conn.Close();
    }
    protected void BtnStep1_Click(object sender, EventArgs e)
    {
      
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        tr1.Style["display"] = "block";
        tr2.Style["display"] = "block";
        string stridlist = "select emailid,CHK=(case when isnull(ROLEID,'')='' then 'N' else 'Y' end),userid,name=name+' : '+userid from webx_master_users where branchcode in (select loccode from webx_location where loc_level=(select top 1 roleid from webx_master_role where srno= '" + DllRole.SelectedValue.ToString() + "')) order by userid";

        SqlCommand sqlcmd12 = new SqlCommand(stridlist, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);
        DataSet ds = new DataSet();
        da.Fill(ds);
        RIghts.DataSource = ds;
        RIghts.DataBind();
        //intTotalRecords = ds.Tables[0].Rows.Count;
       
        conn.Close();
        BtnStep1.Enabled = true;
        DllRole.Enabled = true;
        lbl1.Enabled = false;
            
    }
    protected void dg_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField HDCHK = (HiddenField)e.Row.FindControl("chkval");
            //chkRights
            CheckBox ch = (CheckBox)e.Row.FindControl("chkRights");
            if (HDCHK.Value.ToString().Trim() == "Y")
                ch.Checked = true;
            else
                ch.Checked = false;


        }
    }

}
