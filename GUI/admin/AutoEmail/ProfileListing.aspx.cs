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
public partial class GUI_admin_AutoEmail_ProfileListing : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        BindGrid();
    }
    private void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //cn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim()); 
        conn.Open();
        string sqlstr = "select profile_id,PFNM=replace(replace(name,'_',' '),'MYProf','') from msdb.dbo.sysmail_profile";
        SqlCommand sqlcmd12 = new SqlCommand(sqlstr, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);
        DataSet ds = new DataSet();
        da.Fill(ds);
        dgDocket.DataSource = ds;
        dgDocket.DataBind();
        dgDocket.Visible = true;
        conn.Close();
    }
    protected void dg_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (((Control)e.CommandSource).ID == "DeleteButton")
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            int thisRow = (((GridViewRow)((System.Web.UI.Control)e.CommandSource).Parent.Parent).RowIndex);
            string ClassId = dgDocket.DataKeys[thisRow].Values[0].ToString();
            ClassId = ClassId.Trim().ToString();
            string Query = "exec webx_DeleteMailProfile '" + ClassId + "'";
            //SqlConnection conn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=WEBX_FLEET;UID=sa;pwd=!@ECfy#$");
            conn.Open();
            SqlCommand Command = new System.Data.SqlClient.SqlCommand(Query, conn);
            Command.ExecuteNonQuery();
            conn.Close();
            BindGrid();
        }
    }
}
