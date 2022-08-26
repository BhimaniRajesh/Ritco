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

public partial class GUI_admin_FuelSlipMaster_FuelBillCancelation : System.Web.UI.Page
{
    string BillNumber, CancelRemarks;
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

    protected void GetFuelBillCancellation(object sender, EventArgs e)
    {
        string BillNo = txtBillNo.Text;
        //lblSuccess.Text = "";

        if (txtBillNo.Text == "")
        {

            tblDCR.Visible = true;
            SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();
            SqlCommand cmd = new SqlCommand("usp_FuelBills_Get", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataReader dr = cmd.ExecuteReader();
             
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
            SqlCommand cmd = new SqlCommand("usp_FuelBills_GetBillVise", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Bill_No", BillNo);

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

    protected void btnSubmit_Cancel_Click(object sender, EventArgs e)
    {
        for (int i = 0; i < dgGeneral.Rows.Count; i++)
        {
            TextBox txtbxRemarks = (TextBox)dgGeneral.Rows[i].FindControl("txtbxRemarks");
            CheckBox ChkSel = (CheckBox)dgGeneral.Rows[i].FindControl("chkbxSelect");
            //BillNumber = dgGeneral.Rows[i].Cells[1].Text;
            BillNumber = ((HyperLink)dgGeneral.Rows[i].Cells[1].Controls[0]).Text;

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
                    //string sql = "UPDATE Webx_Fuel_Issue_Slip SET IsCancel='Y', ValidatedBy='" + UpdateBy + "' , ValidatedDate='" + EntryDate + "' , CancelledRemark='" + txtUserInfo.Text + "' WHERE UserSlipNo='" + UserSlipNumber + "'";
                    //SqlCommand cmdTC = new SqlCommand(sql, con, trn);
                    //cmdTC.ExecuteNonQuery();
                    //trn.Commit();
                    //success = true;
                    //con.Close();


                    SqlCommand cmd = new SqlCommand("usp_CancelFuelBills", con, trn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@BillNo", SqlDbType.VarChar).Value = BillNumber;
                    cmd.Parameters.Add("@CanceledRemark", SqlDbType.VarChar).Value = txtbxRemarks.Text;
                    cmd.Parameters.Add("@CanceledBy", SqlDbType.VarChar).Value = EntryBy;
                    cmd.Parameters.Add("@CanceledDate", SqlDbType.VarChar).Value = EntryDate;
                    cmd.ExecuteNonQuery();
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
                    Response.Redirect("FuelBillCancelation_Result.aspx");
                }

            }
        }
    }

}