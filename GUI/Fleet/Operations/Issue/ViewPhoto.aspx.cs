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

public partial class GUI_Fleet_Operations_Issue_ViewPhoto : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection();
    protected void Page_Load(object sender, EventArgs e)
    {

        string DriverId = "";
        DriverId =Request.QueryString["Manual_Driver_Code"].ToString();
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string sql = "usp_GetDriverPhotoFileName";
        SqlCommand sqlcmd2 = new SqlCommand(sql, conn);
        sqlcmd2.CommandType = CommandType.StoredProcedure;
       

        string mFlag = "", mLocation="";
        sqlcmd2.Parameters.Add("@ManualDriverID", SqlDbType.VarChar).Value = DriverId;

        SqlDataReader r2 = sqlcmd2.ExecuteReader();

        while (r2.Read())
        {
            if (r2["Driver_Photo"].ToString() != "")
            {
                imgDriverPhoto.ImageUrl = "~/UploadedImages/" + r2["Driver_Photo"].ToString().Trim();
            }
        }


        
    }
}
