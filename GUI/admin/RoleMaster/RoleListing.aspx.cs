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
using System.Text; 
public partial class GUI_admin_RoleMaster_RoleListing : System.Web.UI.Page
{
    SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        BindGrid();
    }
    private void BindGrid()
    {
        // SqlConnection conn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=WEBX_FLEET;UID=sa;pwd=!@ECfy#$");
        conn.Open();
        string sql = "select srno,Roleid,HYC=(select top 1 codedesc from webx_master_general where codetype='HRCHY' and codeid=Roleid),ROledesc,Multiple,ACTIVEFLAG=isnull(ACTIVEFLAG,'N') from Webx_Master_Role ";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        DataSet ds = new DataSet();
        DataView dv = new DataView();
        da.Fill(ds, "Webx_Master_Role");
        dv = ds.Tables[0].DefaultView;
        gvVehicalPart.DataSource = dv;
        gvVehicalPart.DataBind();
        conn.Close();
    }
    protected void dg_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (((Control)e.CommandSource).ID == "DeleteButton")
        {
            int thisRow = (((GridViewRow)((System.Web.UI.Control)e.CommandSource).Parent.Parent).RowIndex);
            string ClassId = gvVehicalPart.DataKeys[thisRow].Values[0].ToString();
            ClassId = ClassId.Trim().ToString();
            string Query = "Update   Webx_Master_Role set [ACTIVEFLAG]='N' where roledesc='" + ClassId + "'";
            //SqlConnection conn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=WEBX_FLEET;UID=sa;pwd=!@ECfy#$");
            conn.Open();
            SqlCommand Command = new System.Data.SqlClient.SqlCommand(Query, conn);
            Command.ExecuteNonQuery();
            conn.Close();
            BindGrid();
        }
    }
}
