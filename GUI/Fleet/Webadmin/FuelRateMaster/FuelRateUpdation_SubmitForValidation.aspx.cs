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

public partial class GUI_Fleet_Webadmin_FuelRateMaster_FuelRateUpdation_SubmitForValidation : System.Web.UI.Page
{ 
    string QVendorCode;

    protected void Page_Load(object sender, EventArgs e)
    {
        QVendorCode = Request.QueryString["VendorCode"].ToString();
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
            ShowDCRs();
        }
    }

    protected void ShowDCRs()
    {
        try
        { 
            SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();
            SqlCommand cmd = new SqlCommand("usp_View_Vendor_History", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@VendorCode", QVendorCode);

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