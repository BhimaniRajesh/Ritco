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

public partial class GUI_admin_FuelSlipMaster_TripsheetValidationAdd : System.Web.UI.Page
{
    string DataFound; string Redirect;
    bool success = false;
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
        //txtFitness.focus();
        getData();

    }

    public void getData()
    {
       
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string STR = "SELECT *  FROM Webx_Fleet_TripsheetValidationDays";
        SqlCommand cmd = new SqlCommand(STR, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                DataFound = "Y";
                Redirect = "true";
            }
        }
        dr.Close();
        conn.Close();
        if (DataFound == "Y")
        {

           //txtFitness.Attributes.Add("onFocus", "javascript:return changeFocus(this);"); 
           //Response.Write("Records aleady Exist, Transfered to EDIT PAGE!");
          // ScriptManager.RegisterClientScriptBlock(this "alertMessage", "alert('Record Inserted Successfully')");

           Response.Redirect("~/GUI/admin/FuelSlipMaster/TripsheetValidationEdit.aspx?IsRedirect="+Redirect); 
        }
    }




    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string EntryBy = Session["empcd"].ToString();
        string EntryDate = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");


        SqlConnection conn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        SqlTransaction trans1;
        conn1.Open();
        trans1 = conn1.BeginTransaction();
        try
        {

            SqlCommand cmd = new SqlCommand("usp_Fleet_TripsheetValidationDays", conn1, trans1); 
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

            cmd.Parameters.Add("@ValidatedBy", SqlDbType.VarChar).Value = EntryBy;
            cmd.Parameters.Add("@ValidatedDate", SqlDbType.VarChar).Value = EntryDate;


            cmd.ExecuteNonQuery();
            trans1.Commit();
            success = true;
            conn1.Close();
            //lblConfirm.Text = "Successfully Inserted";

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
             string Flag = "Add";
            //Response.Redirect("TripsheetValidation.aspx");
            Response.Redirect("TripSheetValidationDone.aspx?Flag="+ Flag, false);
        }
    }
}
  