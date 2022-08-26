using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

public partial class _Default : System.Web.UI.Page 
{
    SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["ecfy"]);
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            conn.Open();
            String sqlstr = "select VendorName,VendorCode from webx_vendor_hdr WHERE Vendor_Type = 12";
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            SqlDataReader dread = cmd.ExecuteReader();
            {
                while (dread.Read())
                {
                    cboVendor.Items.Add(new ListItem(dread.GetValue(0).ToString(), dread.GetValue(1).ToString()));
                }
            }
            dread.Close();

            sqlstr = "SELECT EMPNM,EMPCD,CURRBRCD FROM webx_empmst";
            cmd = new SqlCommand(sqlstr, conn);
            dread = cmd.ExecuteReader();
            {
                while (dread.Read())
                {
                    cboEmployee.Items.Add(new ListItem(dread.GetValue(0).ToString(), dread.GetValue(1).ToString()));
                    
                }
            }
            dread.Close();
            conn.Close();
        }
    }
    protected void cboEmployee_SelectedIndexChanged(object sender, EventArgs e)
    {
        conn.Open();
        string sqlstr = "SELECT CURRBRCD FROM webx_empmst where EMPNM='" + cboEmployee.SelectedItem.Text + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dread = cmd.ExecuteReader();
        {
            while (dread.Read())
            {
                txtLocation.Text = dread.GetValue(0).ToString();
            }
        }
        dread.Close();
        conn.Close();
    }


    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
        conn.Open();
        string sql = "Insert into CommunicationMaster(PhoneNo,PhoneType,VendorCode,EmpCode,LocationCode) values ('" + txtPhoneNo.Text + "','" + cboPhoneType.SelectedItem.Text + "','" + cboVendor.SelectedItem.Value + "','" + cboEmployee.SelectedItem.Value + "','" + txtLocation.Text + "')";
        SqlCommand sqlcmd3 = new SqlCommand(sql, conn);
        sqlcmd3.ExecuteNonQuery();
        Response.Redirect("Home.aspx");
        conn.Close();
    }
}
