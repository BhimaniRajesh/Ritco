using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_admin_FuelSlipMaster_PendingFuelBillsApproval_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string Billno = Convert.ToString(Request.QueryString["Billno"]);
        string Type = Request.QueryString["Type"];

        lblHeader.Text = "Pending Fuel Bills "+ Type +" Successfully…..   ";
		 if (!IsPostBack)
        {
            //ShowBills(Billno);
        }
    }
	
	 protected void ShowBills( string Billno)
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        SqlCommand cmd = new SqlCommand("usp_FuelBillHdrApproval_Get", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Bill_No", Billno);

        SqlDataReader dr = cmd.ExecuteReader();
        dgGeneral.DataSource = dr;
        dgGeneral.DataBind();
        con.Close();
    }
}