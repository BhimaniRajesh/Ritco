using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI.WebControls.WebParts;
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Fleet_Tyre_TyreUpdate_Msg : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        BindGrid();
    }
    public void BindGrid()
    {
        string sql = "";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        sql = "USP_TyreList";

        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        DataTable dtRoute = new DataTable();

        da.SelectCommand.Parameters.Add("@tyre_ID", SqlDbType.VarChar).Value =cls_TyreIssueMaster.Tyre_IDs.Trim();//Request.QueryString["Tyre_ID"].ToString();
        
        DataSet ds = new DataSet();
        da.Fill(ds);

        GV_FuelRequest.DataSource = ds;
        GV_FuelRequest.DataBind();
    }
}