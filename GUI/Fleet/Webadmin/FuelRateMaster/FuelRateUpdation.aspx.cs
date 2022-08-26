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

public partial class GUI_Fleet_Webadmin_FuelRateMaster_FuelRateUpdation : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        SqlDataSource1.ConnectionString = Session["SqlProvider"].ToString().Trim(); 
        this.Title = pagetitle; 
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle; 
        if (!IsPostBack)
        {
            tdVendorlbl.Visible = false;
            tdVendortxt.Visible = false; 
            fn.Fill_Vendor_Dataset_Fuel(); 
        }
    }
     
    protected void Redirect_AddContract(object sender, EventArgs e)
    {
        Response.Redirect("~/GUI/Fleet/Webadmin/FuelRateMaster/FuelRateUpdation_AddContract.aspx"); 
    }
 
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
       
        if(ddlSelectType.SelectedValue == "All")
        {
            tblDCR.Visible = true;
            SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();
            SqlCommand cmd = new SqlCommand("usp_Get_Fuel_Vendor_Contract_All", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataReader dr = cmd.ExecuteReader();
            dgGeneral.DataSource = dr;
            dgGeneral.DataBind();
            con.Close();
        }


        if (ddlSelectType.SelectedValue == "Active")
        {
            tblDCR.Visible = true;
            SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();
            SqlCommand cmd = new SqlCommand("usp_Get_Fuel_Vendor_Contract_Activated", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataReader dr = cmd.ExecuteReader();
            dgGeneral.DataSource = dr;
            dgGeneral.DataBind();
            con.Close();
        }


        if (ddlSelectType.SelectedValue == "Deactive")
        {
            tblDCR.Visible = true;
            SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();
            SqlCommand cmd = new SqlCommand("usp_Get_Fuel_Vendor_Contract_Deactivated", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataReader dr = cmd.ExecuteReader();
            dgGeneral.DataSource = dr;
            dgGeneral.DataBind();
            con.Close();
        }

        if (ddlSelectType.SelectedValue == "Vendor")
        {

            if (txtVendor.Text != "")
            {
                lblErrorMsg.Text = "";
                tblDCR.Visible = true;  
                string[] nameParts = txtVendor.Text.Split('~');
                string SplitVendorName = nameParts[0];
                string SplitVendorCode = nameParts[1];

                SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                con.Open();
                SqlCommand cmd = new SqlCommand("usp_Get_Fuel_Contract_VendorVise", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@VendorCode", SplitVendorCode);

                SqlDataReader dr = cmd.ExecuteReader();
                dgGeneral.DataSource = dr;
                dgGeneral.DataBind();
                con.Close();
            }

            else
            {
                lblErrorMsg.Text = "Please enter vendor name";
            }
        }
         
    }
    protected void ddlSelectType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlSelectType.SelectedValue == "All")
        {
            tblDCR.Visible = false;
            tdVendorlbl.Visible = true;
            tdVendortxt.Visible = true;
            lblErrorMsg.Text = "";
        }

        if (ddlSelectType.SelectedValue == "Active")
        {
            tblDCR.Visible = false;
            tdVendorlbl.Visible = true;
            tdVendortxt.Visible = true;
            lblErrorMsg.Text = "";
        }

        if (ddlSelectType.SelectedValue == "Deactive")
        {
            tblDCR.Visible = false;
            tdVendorlbl.Visible = true;
            tdVendortxt.Visible = true;
            lblErrorMsg.Text = "";
        }



        if (ddlSelectType.SelectedValue == "Vendor")
        {
            tblDCR.Visible = false;
            tdVendorlbl.Visible = true;
            tdVendortxt.Visible = true;
            lblErrorMsg.Text = "";
        }
        else
        {
            tdVendorlbl.Visible = false;
            tdVendortxt.Visible = false;
            lblErrorMsg.Text = "";
        }
    }
}