using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_admin_FuelSlipMaster_PendingFuelBills_Result : System.Web.UI.Page
{
    string QBillNo;
    protected void Page_Load(object sender, EventArgs e)
    {
        QBillNo = Request.QueryString["QBillNo"].ToString();
        if (!IsPostBack)
        {
            ShowBills();
        }
    }


    protected void ShowBills()
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        SqlCommand cmd = new SqlCommand("usp_FuelBillHdr_Get", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Bill_No", QBillNo);

        SqlDataReader dr = cmd.ExecuteReader();
        dgGeneral.DataSource = dr;
        dgGeneral.DataBind();
        con.Close();
    }
}