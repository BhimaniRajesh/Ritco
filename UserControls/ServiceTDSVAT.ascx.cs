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

public partial class UserControls_ServiceTDSVAT : System.Web.UI.UserControl
{
    SqlConnection con;
    SqlCommand cmd;
    SqlDataReader dr;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
           
            con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();

            string sql = "select acccode,accdesc from webx_acctinfo where accdesc like '%tds%'";
            SqlCommand cmd1 = new SqlCommand(sql, con);
            SqlDataReader dr;
            dr = cmd1.ExecuteReader();
            Tdssection.Items.Add(new ListItem("Select", ""));
            while (dr.Read())
            {
                Tdssection.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
            }
            dr.Close();
            Tdssection.CssClass = "blackfnt";

            string sql2 = "select TOP 1 svctax_rate,EDU_CESS_RATE,hedu_cess_rate,SbcRate,KKCessRate from webx_chargemst order by startdate desc";// Changed By Anupam
            SqlCommand cmd2 = new SqlCommand(sql2, con);
            SqlDataReader dr2;
            dr2 = cmd2.ExecuteReader();
            while (dr2.Read())
            {
                LblSTaxRate.Text = dr2["svctax_rate"].ToString();
                LblEduCess.Text = dr2["EDU_CESS_RATE"].ToString();
                LblHEduCess.Text = dr2["hedu_cess_rate"].ToString();
                LblSBCess.Text = dr2["SbcRate"].ToString(); // Added By Anupam
                LblKKCess.Text = dr2["KKCessRate"].ToString(); // Added By Anupam
            }
            dr2.Close();
        

        }

        

    }
}
