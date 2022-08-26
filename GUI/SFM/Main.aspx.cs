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

public partial class GUI_SFM_Main : System.Web.UI.Page
{
    public static SqlConnection conn;
    SqlCommand cmd = new SqlCommand();
    public string callvisit;
    protected void Page_Load(object sender, EventArgs e)
    {
        
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!(Page.IsPostBack))
        {
            string client = Session["Client"].ToString();
            if (client == "Varuna" || client == "VARUNA")
            {
                callvisit = "Visit";
            }
            else
            {
                callvisit = "Call";
            }
            popRO();
        }
    }
    public void popRO()
    {
        conn.Open();
        string brcd = Session["brcd"].ToString();
        string q1 = "Select Loc_level,locname from webx_location where loccode='" + brcd + "'";
        SqlCommand sqlcmd1 = new SqlCommand(q1, conn);
        SqlDataReader dr;
        dr = sqlcmd1.ExecuteReader();

        dr.Read();
        int loclvl = Convert.ToInt16(dr["Loc_level"]);
        string locnm = dr["locname"].ToString();
        dr.Close();
        if (loclvl <= 2)
        {
            reassign1.Visible = true;
            reassign2.Visible = true;

            approval1.Visible = true;
            approval2.Visible = true;
        }
        else
        {
            reassign1.Visible = false;
            reassign2.Visible = false;

            approval1.Visible = false;
            approval2.Visible = false;
        }
    }
}
