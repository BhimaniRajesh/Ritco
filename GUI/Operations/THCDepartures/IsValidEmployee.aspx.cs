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

public partial class GUI_IsValidEmployee : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string EmpCode = Request.QueryString["EmpCode"].ToString();
        string EmpBranch = Session["brcd"].ToString().Trim();
        string EmpBranchMain = Session["mainbrcd"].ToString().Trim();

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        string Qry = "Exec usp_IsValidEmployee '" + EmpCode.Trim() + "','" + EmpBranch + "','" + EmpBranchMain + "'";
        //Response.Write(Qry);
        SqlCommand sqlCommand = new SqlCommand(Qry, con);
        //sqlCommand.CommandType = CommandType.StoredProcedure;
        //DataSet ds = new DataSet();
        SqlDataReader dr;
        dr = sqlCommand.ExecuteReader();

        int Kount = 0;
        if (dr.Read())
        {
            Kount = Convert.ToInt16(dr["UserKount"].ToString());
        }
        dr.Close();

       if (Kount == 0)
            Response.Write("true|Invalid User");
        else
            Response.Write("false|");
        //return;
        con.Close();
    }
}
