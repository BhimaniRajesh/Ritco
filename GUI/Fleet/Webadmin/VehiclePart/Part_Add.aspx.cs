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

public partial class GUI_WebAdmin_Part_Vehical_Part : System.Web.UI.Page
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
        sql = "select PartName,ActiveFlag from WEBX_FLEET_PARTMST where PartId='" + ClassVehId.ToString().Trim() + "'";

        conn.Open();
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            txtVihicalPart.Text = Convert.ToString(dr["PartName"]);
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
            sql = "select * from WEBX_FLEET_PARTMST where PartName='" + txtVihicalPart.Text.ToString().Trim() + "' and PartId <>" + ClassVehId + "";
        }
        else
        {
            sql = "select * from WEBX_FLEET_PARTMST where PartName='" + txtVihicalPart.Text.ToString().Trim() + "'";
        }
        conn.Open();
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            VihicalName = Convert.ToString(dr["PartName"]);
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
                sql = "update WEBX_FLEET_PARTMST set PartName='" + txtVihicalPart.Text + "',ActiveFlag='" + txtNo.Text + "' where PartId='" + ClassVehId + "'";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.ExecuteNonQuery();
                conn.Close();
            }
            else
            {
                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                conn.Open();
                sql = "insert into WEBX_FLEET_PARTMST (PartName,ActiveFlag) values ('" + txtVihicalPart.Text + "','" + txtNo.Text + "')";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.ExecuteNonQuery();
                conn.Close();
            }
            Response.Redirect("~/GUI/Fleet/WebAdmin/VehiclePart/Part_Edit.aspx");
        }
    }
    protected void btnListing_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/GUI/Fleet/WebAdmin/VehiclePart/Part_Edit.aspx");
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
