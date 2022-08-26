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
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;

public partial class GUI_admin_Accounts_masters_Acctgroup_Grouplist : System.Web.UI.Page
{
    public static string pcode = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        pcode=Request.QueryString.ToString();
        DipsplayReport();

    }
    public void DipsplayReport()
    {


        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        // SqlConnection conn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_VER2_TEST3;");

        string sql = "";


        conn.Open();

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = conn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "webx_Group_details";

        sqlCommand.Parameters.AddWithValue("@pcode", pcode);


        SqlDataAdapter da = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();
        da.Fill(ds);
        //intTotalRecords = ds.Tables[0].Rows.Count;
        //foreach (DataRow dr in ds.Tables[0].Rows)
        //{

        //    DateTime s;
        //    s = Convert.ToDateTime(dr["mrsdt"]);


        //    dr["mrsdt"] = s;
        //}

        GV_Booking.DataSource = ds;

        GV_Booking.DataBind();

        if (GV_Booking.Rows.Count == 0)
        {

        }
        if (GV_Booking.Rows.Count <= 25)
        {
            ////LinkButton1.Visible = false;
            ////LinkButton2.Visible = false;

        }


    }
    public void pgChange(object sender, GridViewPageEventArgs e)
    {
        GV_Booking.PageIndex = e.NewPageIndex;

        DipsplayReport();


    }

}
