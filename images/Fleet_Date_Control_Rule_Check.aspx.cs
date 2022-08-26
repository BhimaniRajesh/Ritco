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

public partial class GUI_Images_Fleet_Date_Control_Rule_Check : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {

        string DocCode = Request.QueryString["DocCode"].ToString();
        string Value = Request.QueryString["Value"].ToString();
        string Falg = "",ErrMsg = "", Backdate_Y_N = "";
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string qry = "Exec Usp_Fleet_Get_Date_Rule_Result '" + DocCode + "','" + fn.Mydate1(Value) + "','" + Session["Finyear"].ToString().Substring(2, 2) + "','" + Session["empcd"].ToString() + "'";
        SqlCommand cmd = new SqlCommand(qry, con);
        SqlDataReader dr;
        con.Open();
        dr = cmd.ExecuteReader();
        int i = 0;
        if (dr.Read())
        {
            Falg = dr["Falg"].ToString();
            ErrMsg = dr["ErrMsg"].ToString();
            Backdate_Y_N = dr["Backdate_Y_N"].ToString();
        }
        dr.Close(); 
        Response.Write(Falg + "|" + ErrMsg + "|" + Backdate_Y_N + "|");
    }
 
}
