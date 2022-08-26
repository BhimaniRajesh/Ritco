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

public partial class GUI_admin_AirportMaster_AirportMasterAdd : System.Web.UI.Page
{
    SqlConnection cn;
    protected void Page_Load(object sender, EventArgs e)
    {
        //cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string sql = "select airportcity from webx_airport_master";
        SqlCommand cmd = new SqlCommand(sql, cn);
        SqlDataReader dr;
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            //str = str +","+ Convert.ToString(dr["name"]);
            Page.RegisterArrayDeclaration("str", "'" + Convert.ToString(dr["airportcity"] + "'"));
        }
        dr.Close();
        if (IsPostBack == false)
        {
            int Cd;
            Cd = newCode();
            lblCode.Text = Cd.ToString(); 
        }
    }
    public int newCode()
    {
        int nwCd = 0;
        string sqlCode = "Select max(airportcode) From webx_airport_master";
        SqlCommand cmd = new SqlCommand(sqlCode, cn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            nwCd = Convert.ToInt32(dr[0].ToString());
        }
        dr.Close();
        cn.Close();

        return nwCd + 1;

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
         
        cn.Open();
        int AirCode = newCode();
        string sqlAdd = "Insert into webx_airport_master(airportcode, airportcity) values('" + AirCode + "', '" + txtAirportCity.Text.Replace("'","''") + "')";
        SqlCommand cmd = new SqlCommand(sqlAdd, cn);
        cmd.ExecuteNonQuery();
        cn.Close();

        Server.Transfer("AirportListing.aspx");
    }
    protected void txtAirportCity_TextChanged(object sender, EventArgs e)
    {
        txtAirportCity.Text = txtAirportCity.Text.ToUpper();

        if (txtAirportCity.Text == "")
        {
            lblErrorLocation.Visible = false;
            return;
        }

        String strSQL = "";

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        strSQL = "SELECT airportcity FROM webx_airport_master WHERE airportcity = '" + txtAirportCity.Text.Replace("'","''")  + "'";

        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsLocation = new DataSet();

        sqlDA.Fill(dsLocation);

        lblErrorLocation.Visible = (dsLocation.Tables[0].Rows.Count > 0 ? true : false);

        if (dsLocation.Tables[0].Rows.Count > 0)
        {
            txtAirportCity.Focus();
        }

        sqlConn.Close();
    }

    protected void btnListing_Click(object sender, EventArgs e)
    {
        Response.Redirect("AirportListing.aspx");
    }
}
