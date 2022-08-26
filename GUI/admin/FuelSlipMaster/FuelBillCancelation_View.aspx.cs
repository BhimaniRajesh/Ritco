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
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_admin_FuelSlipMaster_FuelBillCancelation_View : System.Web.UI.Page
{
    string Bill_No;
    protected void Page_Load(object sender, EventArgs e)
    {
        Bill_No = Request.QueryString["Bill_No"].ToString();
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        this.Title = pagetitle;
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);
        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        if (!IsPostBack)
        {
            ShowBillDetails();
        }

    }
    protected void ShowBillDetails()
    {
        try
        {
            SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();
            SqlCommand cmd = new SqlCommand("usp_FuelBill_View", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Bill_No", Bill_No);

            SqlDataReader dr = cmd.ExecuteReader();
            dgGeneral.DataSource = dr;
            dgGeneral.DataBind();
            con.Close();

        }
        catch (Exception e1)
        {

        }
        finally
        {

        }

    }
}