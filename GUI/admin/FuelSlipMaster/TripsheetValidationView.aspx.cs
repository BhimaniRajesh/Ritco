////using System;
////using System.Collections.Generic;
////using System.Linq;
////using System.Web;
////using System.Web.UI;
////using System.Web.UI.WebControls;
//using System;
//using System.Data;
//using System.Configuration;
//using System.Collections;
//using System.Web;
//using System.Web.Security;
//using System.Web.UI;
//using System.Web.UI.WebControls;
//using System.Web.UI.WebControls.WebParts;
//using System.Web.UI.HtmlControls;
//using System.Data.SqlClient;
//using Microsoft.ApplicationBlocks.Data;

//public partial class GUI_admin_FuelSlipMaster_TripsheetValidationView : System.Web.UI.Page
//{
//    protected void Page_Load(object sender, EventArgs e)
//    {
//        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
//        this.Title = pagetitle;
//        Response.Cache.SetCacheability(HttpCacheability.NoCache);
//        Response.Cache.SetNoStore();
//        Response.Cache.SetExpires(DateTime.MinValue);
//        Common objCommon = new Common();
//        objCommon.doCacheRoutine();
//        this.Title = pagetitle;


//        if (!IsPostBack)
//        {
//            ShowDCRs();
//        }
//    }
//    protected void ShowDCRs()
//    {
//        try
//        {

//            SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
//            con.Open();
//            SqlCommand cmd = new SqlCommand("usp_Fleet_ShowTripsheetValidationDay", con);
//            cmd.CommandType = CommandType.StoredProcedure;
//            SqlDataReader dr = cmd.ExecuteReader();
//            dgGeneral.DataSource = dr;
//            dgGeneral.DataBind();
//            con.Close();

//        } 
//        catch (Exception e1)
//        {

//        }
//        finally
//        {

//        }
//    }
//}

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

public partial class GUI_admin_FuelSlipMaster_TripsheetValidationView : System.Web.UI.Page
{
    //string Redirected;
    bool success = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //Redirected = Request.QueryString["IsRedirect"].ToString();
            getData();

        }
    }
    //protected void btnEdit_Click(object sender, EventArgs e)
    //{
    //    string EntryBy = Session["empcd"].ToString();
    //    string EntryDate = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");


    //    SqlConnection conn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    SqlTransaction trans1;
    //    conn1.Open();
    //    trans1 = conn1.BeginTransaction();
    //    try
    //    {

    //        SqlCommand cmd = new SqlCommand("usp_Fleet_EditTripsheetValidationDays", conn1, trans1);
    //        cmd.CommandType = CommandType.StoredProcedure;

    //        cmd.Parameters.Add("@FitnessDays", SqlDbType.VarChar).Value = lblFitness.Text;
    //        cmd.Parameters.Add("@NationalPermitDays", SqlDbType.VarChar).Value = lblNationalPermit.Text;
    //        cmd.Parameters.Add("@FiveYearPermitDays", SqlDbType.VarChar).Value = lblFiveYearPermit.Text;
    //        cmd.Parameters.Add("@InsuranceDays", SqlDbType.VarChar).Value = lblInsurance.Text; ;
    //        cmd.Parameters.Add("@RoadTaxDays", SqlDbType.VarChar).Value = lblRoadTax.Text;
    //        cmd.Parameters.Add("@DriverLicenseDays", SqlDbType.VarChar).Value = lblDriverLicense.Text;
    //        cmd.Parameters.Add("@DriverLicVerificationDays", SqlDbType.VarChar).Value = lblDriverLicenseVerification.Text;
    //        cmd.Parameters.Add("@DieselLtrs", SqlDbType.VarChar).Value = lblDieselLtrs.Text;
    //        cmd.Parameters.Add("@Cash", SqlDbType.VarChar).Value = lblCash.Text;

    //        cmd.Parameters.Add("@EditedBy", SqlDbType.VarChar).Value = EntryBy;
    //        cmd.Parameters.Add("@EditedDate", SqlDbType.VarChar).Value = EntryDate;

    //        cmd.ExecuteNonQuery();
    //        trans1.Commit();
    //        success = true;
    //        conn1.Close();
    //    }

    //    catch (Exception e1)
    //    {
    //        trans1.Rollback();
    //    }
    //    finally
    //    {

    //    }
    //    if (success == true)
    //    {
    //        Response.Redirect("TripsheetValidation.aspx");
    //    }
    //}

    public void getData()
    {
        //if (Redirected == "true")
        //{
        //    lblRedirectMsg.Text = "Records already exist, Transfered to Edit Page.";
        //}
        //else
        //{

        //}

        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string sql;
        cn.Open();
        SqlCommand cmd = new SqlCommand("usp_Fleet_ShowTripsheetValidationDay", cn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            lblFitness.Text = dr["FitnessDays"].ToString();
            lblNationalPermit.Text = dr["NationalPermitDays"].ToString();
            lblFiveYearPermit.Text = dr["FiveYearPermitDays"].ToString();
            lblInsurance.Text = dr["InsuranceDays"].ToString();
            lblRoadTax.Text = dr["RoadTaxDays"].ToString();
            lblDriverLicense.Text = dr["DriverLicenseDays"].ToString();
            lblDriverLicenseVerification.Text = dr["DriverLicVerificationDays"].ToString();
            lblDieselLtrs.Text = dr["DieselLtrs"].ToString();
            lblCash.Text = dr["Cash"].ToString();
        }
        dr.Close();
        cn.Close();
    }
}