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


public partial class GUI_WebAdmin_PicKup_location_PickUp_step2 : System.Web.UI.Page
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
        string sql = "select pickup_loccode,pickup_locname,City_Code=(select location from webx_citymaster where City_Code=l.City_Code),ActiveFlag,EntryDate from webx_PICKUP_Location l with(NOLOCK) ";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        DataSet ds = new DataSet();
        DataView dv = new DataView();
        da.Fill(ds, "webx_PICKUP_Location");
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
            string Query = "Delete from  webx_PICKUP_Location where pickup_loccode='" + ClassId + "'";
            //SqlConnection conn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=WEBX_FLEET;UID=sa;pwd=!@ECfy#$");
            conn.Open();
            SqlCommand Command = new System.Data.SqlClient.SqlCommand(Query, conn);
            Command.ExecuteNonQuery();
            conn.Close();
            BindGrid();
        }
    }
}
