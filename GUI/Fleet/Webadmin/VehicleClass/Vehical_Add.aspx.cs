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

public partial class GUI_WebAdmin_Class_Vihical_Master : System.Web.UI.Page
{
    static string sql, ClassVehId;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(Page.IsPostBack))
        {
            ClassVehId = Request.QueryString["id"];

            if (ClassVehId != "" && ClassVehId != null)
            {
                RetriveData();
                lblVihicalCode.Text = ClassVehId;
            }            
        }
    }

    private void RetriveData()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sql = "select Class_name,ActiveFlag from webx_vehicle_class where ClassId='" + ClassVehId.ToString().Trim() + "' ";
        
        conn.Open();
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            txtVihicalMaster.Text = Convert.ToString(dr["Class_name"]);
            txtNo.Text = Convert.ToString(dr["ActiveFlag"]);
            if (txtNo.Text == "Y")
            {
                chkYes.Checked = true;
            }
            else
            {
                chkYes.Checked = false;
            }
        }
        conn.Close();
    }
    public void VihicalName(object source, ServerValidateEventArgs value)
    {
        string VihicalName = "";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (ClassVehId != "" && ClassVehId != null)
        {
            sql = "select * from webx_vehicle_class where Class_name='" + txtVihicalMaster.Text.ToString().Trim() + "' and ClassId <> " + ClassVehId + "";
        }
        else
        {
            sql = "select * from webx_vehicle_class where Class_name='" + txtVihicalMaster.Text.ToString().Trim() + "'";
        }
        conn.Open();
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            VihicalName = Convert.ToString(dr["Class_name"]);
        }
        conn.Close();

        if (VihicalName != null && VihicalName != "")
        {
            value.IsValid = false;
        }
        else
        {
            value.IsValid = true;
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid == true)
        {
            if (ClassVehId != "" && ClassVehId != null)
            {
                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                conn.Open();
                sql = "update  webx_vehicle_class set Class_name='" + txtVihicalMaster.Text + "',ActiveFlag='" + txtNo.Text + "' where ClassId='" + ClassVehId + "'";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.ExecuteNonQuery();
                conn.Close();
            }
            else
            {
                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                conn.Open();
                sql = "insert into webx_vehicle_class (Class_name,ActiveFlag) values ('" + txtVihicalMaster.Text + "','" + txtNo.Text + "')";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.ExecuteNonQuery();
                conn.Close();
            }
            Response.Redirect("~/WebAdmin/Class/Vehical_Master.aspx");

        }
    }
    protected void btnListing_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/WebAdmin/Class/Vehical_Edit.aspx");
    }
    protected void chkYes_CheckedChanged(object sender, EventArgs e)
    {
        if (chkYes.Checked == true)
        {
            txtNo.Text = "Y";
        }
        else
        {
            txtNo.Text = "N";
        }
    }
}
