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
using System.IO;
public partial class GUI_UNI_MIS_OPN_LIFE_CYCLE_PopUp_Result : System.Web.UI.Page
{
    SqlConnection Conn;
    public static string dockno, docksf, doctyp;
    protected void Page_Load(object sender, EventArgs e)
    {
        //string[] str_dockno = Request.QueryString.ToString();
        //dockno = str_dockno[0].ToString();
        //docksf = str_dockno[1].ToString();
        //doctyp = str_dockno[2].ToString();
        dockno = Request.QueryString["strDocketNo"].ToString();
        docksf = Request.QueryString["strDcksf"].ToString();
        doctyp = Request.QueryString["strDckty"].ToString().Replace("%3d", "");


        Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Conn.Open();

        string SQL_TB = "exec webx_DKT_OPN_LIFE_CYCLE_Det   '" + dockno + "','" + docksf + "','" + doctyp + "'";
        //Response.Write("<BR> SQL_TB : " + SQL_TB);
        // Rtyp = "1";
        SqlCommand sqlcmd12 = new SqlCommand(SQL_TB, Conn);
        //SqlDataReader dr;
        //dr = sqlcmd12.ExecuteReader();
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);
        DataSet ds = new DataSet();
        da.Fill(ds);

        if (doctyp == "LS")
        {
            dgLS.DataSource = ds;
            dgLS.DataBind();
            dgLS.Visible = true;
        }
        else if (doctyp == "MF")
        {

            dgMF.DataSource = ds;
            dgMF.DataBind();
            dgMF.Visible = true;
        }
        else if (doctyp == "THC")
        {
            dgTHC.DataSource = ds;
            dgTHC.DataBind();
            dgTHC.Visible = true;
        }
        else if (doctyp == "PRS")
        {
            dgPRS.DataSource = ds;
            dgPRS.DataBind();
            dgPRS.Visible = true;
        }
        else  if (doctyp == "DRS")
        {
            dgDRS.DataSource = ds;
            dgDRS.DataBind();
            dgDRS.Visible = true;
        }

        Conn.Close();

    }
}
