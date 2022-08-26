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

public partial class Operation_Device_Type : System.Web.UI.Page
{
    static string CDT_Desc, AddEditMode;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(IsPostBack))
        {
            CDT_Desc = Request.QueryString["id"];            
            if (CDT_Desc != null && CDT_Desc != "")
            {
                RetriveData();
                AddEditMode = "U";
                lblAddEdit.Text = "Edit Existing";
            }
            else
            {
                AddEditMode = "I";
                lblAddEdit.Text = "Add New";
            }
            txtDeviceType.Focus();
        }
    }

    private void RetriveData()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "select * from Tel_Comm_Device_Type_Master where CDT_Code='" + CDT_Desc + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            lblTypeCode.Text = Convert.ToString(dr["CDT_Code"]);
            txtDeviceType.Text = Convert.ToString(dr["CDT_Desc"]);
        }
        conn.Close();
    }
    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
        if (Page.IsValid == true)
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            SqlCommand cmd = new SqlCommand("usp_Comm_Device_Type_InsertUpdate", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            if (AddEditMode.ToString().Trim() == "I")
            {
                cmd.Parameters.Add("@AddEditMode", SqlDbType.VarChar).Value = "I";
                cmd.Parameters.Add("@CDT_Code", SqlDbType.VarChar).Value = "";
                cmd.Parameters.Add("@CDT_Desc", SqlDbType.VarChar).Value = txtDeviceType.Text.Trim();
            }
            else
            {
                cmd.Parameters.Add("@AddEditMode", SqlDbType.VarChar).Value = "U";
                cmd.Parameters.Add("@CDT_Code", SqlDbType.VarChar).Value = lblTypeCode.Text;
                cmd.Parameters.Add("@CDT_Desc", SqlDbType.VarChar).Value = txtDeviceType.Text.Trim();
            }
            cmd.ExecuteNonQuery();
            conn.Close();
            Response.Redirect("Master_Page.aspx");
        }
    }    
    protected void txtDeviceType_TextChanged(object sender, EventArgs e)
    {
        string Desc = "";
        string sql = "";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (CDT_Desc != "" && CDT_Desc != null)
        {
            sql = "select * from Tel_Comm_Device_Type_Master where CDT_Desc = '" + txtDeviceType.Text.Trim() + "' and CDT_Code <> '" + CDT_Desc + "'";
        }
        else
        {
            sql = "select * from Tel_Comm_Device_Type_Master where CDT_Desc='" + txtDeviceType.Text.Trim() + "'";
        }
        conn.Open();
        SqlCommand cmd = new SqlCommand(sql, conn);

        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            Desc = Convert.ToString(dr["CDT_Desc"]);
        }
        conn.Close();
        if (Desc != "" && Desc != null)
        {
            lblDesc.Text = "This Device Type Already Exists";            
        }        
    }
    public void DeviceType(object source, ServerValidateEventArgs value)
    {
        string Desc = "";
        string sql = "";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (CDT_Desc != "" && CDT_Desc != null)
        {
            sql = "select * from Tel_Comm_Device_Type_Master where CDT_Desc = '" + txtDeviceType.Text.Trim() + "' and CDT_Code <> '" + CDT_Desc + "'";
        }
        else
        {
            sql = "select * from Tel_Comm_Device_Type_Master where CDT_Desc='" + txtDeviceType.Text.Trim() + "'";
        }
        conn.Open();
        SqlCommand cmd = new SqlCommand(sql, conn);

        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            Desc = Convert.ToString(dr["CDT_Desc"]);
        }
        conn.Close();
        if (Desc != "" && Desc != null)
        {
            value.IsValid = false;       
        }
        else
        {
            value.IsValid = true;
        }
    }
    
}
