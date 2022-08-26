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

public partial class GUI_admin_AirportMaster_AirportMasterEdit : System.Web.UI.Page
{
    SqlConnection cn;
    public static string strSsCd;
    public static string strActualLocationCode;
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (IsPostBack == false)
        {
            strSsCd = Session["Edit"].ToString().Trim();
            lblCode.Text = strSsCd;
            cn.Open();
            string sqlUpdt = "select airportcity from webx_airport_master where airportcode = '" + lblCode.Text + "'";
            SqlCommand cmd = new SqlCommand(sqlUpdt, cn);
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                txtAirportCity.Text = dr[0].ToString();
                strActualLocationCode = txtAirportCity.Text;
            }
            dr.Close();
            cn.Close();
  
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        cn.Open();
        string sqlUpdt = "update webx_airport_master set airportcity = '" + txtAirportCity.Text + "' where airportcode = '" + lblCode.Text + "'";
        SqlCommand cmd = new SqlCommand(sqlUpdt, cn);
        cmd.ExecuteNonQuery();
        cn.Close();

        Server.Transfer("AirportList.aspx");
    }
    protected void txtAirportCity_TextChanged(object sender, EventArgs e)
    {
        txtAirportCity.Text = txtAirportCity.Text.ToUpper();

        if (txtAirportCity.Text == "" || txtAirportCity.Text.ToUpper() == strActualLocationCode.ToUpper())
        {
            lblErrorLocation.Visible = false;
            return;
        }

        String strSQL = "";

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        strSQL = "SELECT airportcity FROM webx_airport_master WHERE airportcity = '" + txtAirportCity.Text + "'";

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
        Server.Transfer("AirportList.aspx");
    }
    
}
