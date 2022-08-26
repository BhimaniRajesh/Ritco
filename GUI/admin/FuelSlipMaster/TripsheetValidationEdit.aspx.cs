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

public partial class GUI_admin_FuelSlipMaster_TripsheetValidationEdit : System.Web.UI.Page
{
    string Redirected;
    bool success = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Redirected = Request.QueryString["IsRedirect"].ToString();
            getData();
            
        }
    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        string EntryBy = Session["empcd"].ToString();
        string EntryDate = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");


        SqlConnection conn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        SqlTransaction trans1;
        conn1.Open();
        trans1 = conn1.BeginTransaction();
        try
        {

            SqlCommand cmd = new SqlCommand("usp_Fleet_EditTripsheetValidationDays", conn1, trans1);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@FitnessDays", SqlDbType.VarChar).Value = txtFitness.Text;
            cmd.Parameters.Add("@NationalPermitDays", SqlDbType.VarChar).Value = txtNationalPermit.Text;
            cmd.Parameters.Add("@FiveYearPermitDays", SqlDbType.VarChar).Value = txtFiveYearPermit.Text;
            cmd.Parameters.Add("@InsuranceDays", SqlDbType.VarChar).Value = txtInsurance.Text; ;
            cmd.Parameters.Add("@RoadTaxDays", SqlDbType.VarChar).Value = txtRoadTax.Text;
            cmd.Parameters.Add("@DriverLicenseDays", SqlDbType.VarChar).Value = txtDriverLicense.Text;
            cmd.Parameters.Add("@DriverLicVerificationDays", SqlDbType.VarChar).Value = txtDriverLicenseVerification.Text;
            cmd.Parameters.Add("@DieselLtrs", SqlDbType.VarChar).Value = txtDieselLtrs.Text;
            cmd.Parameters.Add("@Cash", SqlDbType.VarChar).Value = txtCash.Text;

            cmd.Parameters.Add("@EditedBy", SqlDbType.VarChar).Value = EntryBy;
            cmd.Parameters.Add("@EditedDate", SqlDbType.VarChar).Value = EntryDate;

            cmd.ExecuteNonQuery();
            trans1.Commit();
            success = true;
            conn1.Close();  
        }

        catch (Exception e1)
        {
            trans1.Rollback();
        }
        finally
        {

        }
        if (success == true)
        {
               string Flag = "Edit";
            // Response.Redirect("TripsheetValidation.aspx");
            Response.Redirect("TripSheetValidationDone.aspx?Flag=" + Flag, false);
        }
    }

    public void getData()
    {
        if(Redirected == "true")
        {
            lblRedirectMsg.Text = "Records already exist, Transfered to Edit Page.";
        }
        else
        {

        }
         
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string sql;
        cn.Open();
        SqlCommand cmd = new SqlCommand("usp_Fleet_ShowTripsheetValidationDay", cn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            txtFitness.Text = dr["FitnessDays"].ToString();
            txtNationalPermit.Text = dr["NationalPermitDays"].ToString();
            txtFiveYearPermit.Text = dr["FiveYearPermitDays"].ToString();
            txtInsurance.Text = dr["InsuranceDays"].ToString();
            txtRoadTax.Text = dr["RoadTaxDays"].ToString();
            txtDriverLicense.Text = dr["DriverLicenseDays"].ToString();
            txtDriverLicenseVerification.Text = dr["DriverLicVerificationDays"].ToString();
            txtDieselLtrs.Text = dr["DieselLtrs"].ToString();
            txtCash.Text = dr["Cash"].ToString(); 
        }
        dr.Close();
        cn.Close();
    }
}