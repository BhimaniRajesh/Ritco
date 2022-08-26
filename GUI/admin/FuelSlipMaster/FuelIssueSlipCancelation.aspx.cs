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

public partial class GUI_admin_FuelSlipMaster_FuelIssueSlipCancelation : System.Web.UI.Page
{
    string UserSlipNumber, CancelRemarks;
    bool success = false;

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
            fn.Fill_Vendor_Dataset_Fuel();


            btnSubmit_Cancel.Visible = false;
        }
    }

    protected void GetFuelIssueSlipCancellation(object sender, EventArgs e)
    {
        string FuelSlipNo = txtFuelSlipNo.Text;
        //lblSuccess.Text = "";

        if (txtFuelSlipNo.Text == "")
        {

            tblDCR.Visible = true;
            SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();
            SqlCommand cmd = new SqlCommand("usp_Fleet_FuelIssueSlipCancellation", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataReader dr = cmd.ExecuteReader();

            //if (dr.HasRows == false)
            //{
            //    btnSubmit_Cancel.Visible = true;
            //}
            dgGeneral.DataSource = dr; 
            dgGeneral.DataBind();

            if (dgGeneral.Rows.Count != 0)
            {
                btnSubmit_Cancel.Visible = true;
            }
            con.Close();
        }
        else
        {
            SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();
            SqlCommand cmd = new SqlCommand("usp_Fleet_FuelIssueSlipCancellationSlipVice", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@USlipno", FuelSlipNo);

            SqlDataReader dr = cmd.ExecuteReader();
            dgGeneral.DataSource = dr;
            dgGeneral.DataBind();

            if (dgGeneral.Rows.Count != 0)
            {
                btnSubmit_Cancel.Visible = true;
            }
            else
            {
                btnSubmit_Cancel.Visible = false;
            }
            con.Close();

        }
    }

    //protected void Redirect_AddContract(object sender, EventArgs e)
    //{
    //    Response.Redirect("~/GUI/Fleet/Webadmin/FuelRateMaster/FuelRateUpdation_AddContract.aspx");
    //}


    //protected void dgGeneral_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    if (e.CommandName == "EditButton")
    //    {
    //        int index = Convert.ToInt32(e.CommandArgument);
    //        GridViewRow row = dgGeneral.Rows[index];
    //        Response.Redirect("~/GUI/admin/FuelSlipMaster/FuelIssueSlipCancelationView.aspx?UserSlipNo=" + row.Cells[1].Text);
    //    }
    //}

    protected void btnSubmit_Cancel_Click(object sender, EventArgs e)
    {
        for (int i = 0; i < dgGeneral.Rows.Count; i++)
        {
            TextBox txtUserInfo = (TextBox)dgGeneral.Rows[i].FindControl("txtbxRemarks");
            CheckBox ChkSel = (CheckBox)dgGeneral.Rows[i].FindControl("chkbxSelect");
            UserSlipNumber = dgGeneral.Rows[i].Cells[1].Text;

            //CancelRemarks = dgGeneral.Rows[i].FindControl("txtbxRemarks");
            if (ChkSel.Checked == true)
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
                    //string sql = "Exec usp_Manifest_Do_Cancel '" + txtMFNumber.Text + "','" + Session["empcd"].ToString().Trim() + "'";

                    string sql = "UPDATE Webx_Fuel_Issue_Slip SET IsCancel='Y', ValidatedBy='" + UpdateBy + "' , ValidatedDate='" + EntryDate + "' , CancelledRemark='" + txtUserInfo.Text + "' WHERE UserSlipNo='" + UserSlipNumber + "'";
                    SqlCommand cmdTC = new SqlCommand(sql, con, trn);
                    cmdTC.ExecuteNonQuery();
                    trn.Commit();
                    success = true;
                    con.Close();

                    //lblSuccess.Text = "Fuel Slip Cancelled Successfully!";

                }
                catch (Exception e1)
                {
                    trn.Rollback();
                }

                if (success == true)
                {
                    Response.Redirect("FuelIssueSlipCancelation_Result.aspx");
                }

            }
        }

        
        // Response.Redirect("~/GUI/Default.aspx");
    }


}
