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

public partial class GUI_Fleet_Webadmin_FuelRateMaster_FuelRateValidation : System.Web.UI.Page
{
    string VendorNm, Prod;
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


        if (!IsPostBack)
        {
            ShowDCRs();
        }
    }

    protected void ShowDCRs()
    {
        lblSuccess.Text = "";
        tblDCR.Visible = true; 
        string strCMD = "Exec usp_Get_Fuel_Vendor_Contract";
        SqlDataSource1.SelectCommand = strCMD;
        dgGeneral.DataBind();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        for (int i = 0; i < dgGeneral.Rows.Count; i++)
        {
            RadioButton rdbtnYesbtn = (RadioButton)dgGeneral.Rows[i].FindControl("rdbtnYes");
            RadioButton rdbtnNobtn = (RadioButton)dgGeneral.Rows[i].FindControl("rdbtnNo");
            HiddenField hdnSrNo = (HiddenField)dgGeneral.Rows[i].FindControl("hdnSrNo");
            VendorNm = dgGeneral.Rows[i].Cells[1].Text.Replace("&amp;","&");
            Prod = dgGeneral.Rows[i].Cells[6].Text;

            if (rdbtnYesbtn.Checked == true)
            {
                SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                con.Open();
                SqlTransaction trn;
                trn = con.BeginTransaction();
                string EntryBy = Session["empcd"].ToString();
                string UpdateBy = Session["empcd"].ToString();
                string EntryDate = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");

                try
                {
                    string sql = "UPDATE Webx_Fuel_Vendor_Contract SET IsActiveFlag='Y', IsValidated='Y',IsApproved='Y', ValidatedBy='" + UpdateBy + "' , ValidatedDate='" + EntryDate + "',ApprovedBy='" + UpdateBy + "' , ApprovedDate='" + EntryDate + "' WHERE VendorName='" + VendorNm + "' AND Product ='" + Prod + "' AND Srno= "+ hdnSrNo.Value + "";
                    SqlCommand cmdTC = new SqlCommand(sql, con, trn);
                    cmdTC.ExecuteNonQuery();
                    trn.Commit();
                    success = true;
                    con.Close();
                }
                catch (Exception e1)
                {
                    trn.Rollback();
                }

                if (success == true)
                {
                    Response.Redirect("FuelRateValidation_Result.aspx");
                }

            }

            if (rdbtnNobtn.Checked == true)
            {
                SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                con.Open();
                SqlTransaction trn;
                trn = con.BeginTransaction();
                string EntryBy = Session["empcd"].ToString();
                string UpdateBy = Session["empcd"].ToString();
                string EntryDate = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");

                try
                {
                    string sql = "UPDATE Webx_Fuel_Vendor_Contract SET IsActiveFlag='Y', IsValidated='Y',IsApproved='N', ValidatedBy='" + UpdateBy + "' , ValidatedDate='" + EntryDate + "', ApprovedBy='" + UpdateBy + "' , ApprovedDate='" + EntryDate + "' WHERE VendorName='" + VendorNm + "' AND Product ='" + Prod + "' AND Srno= " + hdnSrNo.Value + " ";
                    SqlCommand cmdTC = new SqlCommand(sql, con, trn);
                    cmdTC.ExecuteNonQuery();
                    trn.Commit();
                    success = true;
                    con.Close();
                }
                catch (Exception e1)
                {
                    trn.Rollback();
                }

                if (success == true)
                {
                    Response.Redirect("FuelRateValidation_Result.aspx");
                }

            }
        }


    }
}
