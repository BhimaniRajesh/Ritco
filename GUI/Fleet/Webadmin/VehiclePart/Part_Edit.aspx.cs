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

public partial class GUI_WebAdmin_Part_Vehical_Part_Edit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        BindGrid();
    }
    private void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "select * from WEBX_FLEET_PARTMST";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        DataSet ds = new DataSet();
        DataView dv = new DataView();
        da.Fill(ds, "WEBX_FLEET_PARTMST");
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
            string Query = "Delete from  WEBX_FLEET_PARTMST where PartId='" + ClassId + "'";
            SqlConnection conn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=WEBX_FLEET;UID=sa;pwd=!@ECfy#$");
            conn.Open();
            SqlCommand Command = new System.Data.SqlClient.SqlCommand(Query, conn);
            Command.ExecuteNonQuery();
            conn.Close();
            BindGrid();
        }
    }
}
