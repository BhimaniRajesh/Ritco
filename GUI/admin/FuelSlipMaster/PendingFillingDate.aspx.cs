using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Microsoft.ApplicationBlocks.Data;
using WebX.Controllers;

public partial class GUI_admin_FuelSlipMaster_PendingFillingDate : System.Web.UI.Page
{
    public byte byteRadButtonSelection;
    MyDataSet ds = new MyDataSet();
    DataSet ds1 = new DataSet();
    public static string LoginBrLevel = "";
    string srno = "";
    string WithoutLastUserSlipNo;
    string Old_UserSlipNo, UPCurr_UserSlipNo, Curr_UserSlipNo, All_UserSlipNo;
    int UserSlip_Counter = 0;

    string FillingDate, VendorName, VehicleNo, TripsheetNo, TripsheetOpen_Dt, VendorCity, Product, UserSlipNo, UserSlip_Dt;
    string Quantity, Rate, Amount;
    string Prod;
    bool success = false;

    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);
        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
        if (ddVendorName.SelectedValue == "" || ddVendorName.SelectedValue == "0")
        {
            btnRateHistory.Visible = false;
        }
        else
        {
            btnRateHistory.Visible = true;
        }
        if (!IsPostBack)
        {
            txtDateFrom.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtDateTo.Text = System.DateTime.Today.ToString("dd/MM/yyyy");

            btnSubmitBills.Visible = false;


            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            string sql = "";
            sql = "SELECT '0' AS Vendorcode, 'All' AS Vendorname UNION SELECT H.Vendorcode,(H.vendorname+':'+ D.VENDORCITY+':'+H.Vendorcode) AS vendorname FROM webx_VENDOR_HDR H INNER JOIN dbo.webx_VENDOR_DET D ON D.VENDORCODE = H.VENDORCODE WHERE H.Vendor_Type='12' ORDER BY Vendorcode ASC";
            SqlCommand sqlcmd = new SqlCommand(sql, conn);
            SqlDataReader dr;
            dr = sqlcmd.ExecuteReader();
            ddVendorName.Items.Clear();

            while (dr.Read())
            {
                ddVendorName.Items.Add(new ListItem(dr["VendorName"].ToString(), dr["Vendorcode"].ToString()));
            }
            dr.Close();
            conn.Close();
        }
    }

    protected void radDate_SelectedIndexChanged(object sender, EventArgs e)
    {
        RadioButtonList rbl = new RadioButtonList();
        rbl = (RadioButtonList)sender;

        byteRadButtonSelection = Convert.ToByte(rbl.SelectedItem.Value);

        if (rbl.Items[0].Selected)
        {
            txtDateFrom.ReadOnly = false;
            txtDateTo.ReadOnly = false;
        }
        else
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
        }

        if (rbl.Items[1].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Today.AddDays(-7).ToString("dd/MM/yyyy");
            txtDateTo.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
        }
        else if (rbl.Items[2].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;
        }
        else if (rbl.Items[3].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Today.AddYears(-50).ToString("dd/MM/yyyy");
            txtDateTo.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
        }

    }
    public void daterange(object source, ServerValidateEventArgs value)
    {
        if (txtDateFrom.Text == "")
        {
            value.IsValid = false;
            return;
        }
        if (txtDateTo.Text == "")
        {
            value.IsValid = false;
            return;
        }
        string[] strDtFrom = txtDateFrom.Text.Split('/');
        DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        string[] strDtTo = txtDateTo.Text.Split('/');
        DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));
        System.TimeSpan diffResult = dt2.Subtract(dt1);

        if (dt1 > dt2)
        {
            CustomValidator1.ErrorMessage = "From Date can not be Less then To date";
            value.IsValid = false;
            return;

        }
    }

    protected void ShowPendingBills(object sender, EventArgs e)
    {
        tblDCR.Visible = true;
        string VendorName = ddVendorName.SelectedValue.ToString();

        string[] strDtFrom = txtDateFrom.Text.Split('/');
        DateTime d1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        string[] strDtTo = txtDateTo.Text.Split('/');
        DateTime d2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));
        var StartTime = TimeSpan.Parse("00:00:00");
        var EndTime = TimeSpan.Parse("23:59:59");
        var StartDate = d1 + StartTime;
        var EndDate = d2 + EndTime;

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        SqlCommand cmd = new SqlCommand("usp_Get_PendingFuelIssueSlip_FillingDate", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@VendorName", VendorName);
        cmd.Parameters.AddWithValue("@FromDate", StartDate);
        cmd.Parameters.AddWithValue("@ToDate", EndDate);
        SqlDataReader dr = cmd.ExecuteReader();
        dgGeneral.DataSource = dr;
        dgGeneral.DataBind();
        if (dgGeneral.Rows.Count == 0)
        {
            btnSubmitBills.Visible = false;
        }
        else
        {
            if (ddVendorName.SelectedValue != "All")
            {
                btnSubmitBills.Visible = true;
            }
        }
        con.Close();
    }
    protected void btnSubmitBills_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow gridrow in dgGeneral.Rows)
        {
            //for (int i = 0; i < dgGeneral.Rows.Count; i++)
            //{
            //TextBox txtFillingDate = (TextBox)dgGeneral.Rows[i].FindControl("txtFillingDate");
            //UserSlipNo = dgGeneral.Rows[i].Cells[8].Text;
            string UserSlipNo = Convert.ToString(((Label)gridrow.FindControl("lblUserSlipNo")).Text);
            var hdnSrNo = (HiddenField)gridrow.FindControl("hdnSrNo");
            TextBox txtFillingDate = (TextBox)gridrow.FindControl("txtFillingDate");
            TextBox txtIGST = (TextBox)gridrow.FindControl("txtIGST");
            TextBox txtSGST = (TextBox)gridrow.FindControl("txtSGST");
            TextBox txtCGST = (TextBox)gridrow.FindControl("txtCGST");

            var hdnRateAsPerFillingDate = (HiddenField)gridrow.FindControl("hdnRateAsPerFillingDate");
            var hdnFinalAmount = (HiddenField)gridrow.FindControl("hdnFinalAmount");
            var hdnTotalAmount = (HiddenField)gridrow.FindControl("hdnTotalAmount");


            if (txtFillingDate.Text != "")
            {

                string[] strDtFrom = txtFillingDate.Text.Split('/');
                DateTime d1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));

                SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                con.Open();
                SqlTransaction tran;
                tran = con.BeginTransaction();
                string EntryBy = Session["empcd"].ToString();
                string UpdateBy = Session["empcd"].ToString();
                string EntryDate = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");

                try
                {
                    SqlCommand cmd = new SqlCommand("usp_PendingFillingDate_Insert", con, tran);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@FillingDate", SqlDbType.VarChar).Value = d1;
                    cmd.Parameters.Add("@UserSlipNo", SqlDbType.VarChar).Value = UserSlipNo;
                    cmd.Parameters.Add("@FillingDateEntryBy", SqlDbType.VarChar).Value = EntryBy;
                    cmd.Parameters.Add("@FillingEntry_Dt", SqlDbType.VarChar).Value = EntryDate;
                    cmd.Parameters.Add("@Rate", SqlDbType.VarChar).Value = hdnRateAsPerFillingDate.Value;
                    cmd.Parameters.Add("@Amount", SqlDbType.VarChar).Value = hdnFinalAmount.Value;
                    cmd.Parameters.Add("@IGST", SqlDbType.VarChar).Value = txtIGST.Text;
                    cmd.Parameters.Add("@SGST", SqlDbType.VarChar).Value = txtSGST.Text;
                    cmd.Parameters.Add("@CGST", SqlDbType.VarChar).Value = txtCGST.Text;
                    cmd.Parameters.Add("@TotalAmount", SqlDbType.VarChar).Value = hdnTotalAmount.Value;

                    /*
                    UserSlip_Counter = UserSlip_Counter + 1;

                    if (UserSlip_Counter == 1)
                    {
                        Old_UserSlipNo = "'" + UserSlipNo + "'" + ",";
                    }
                    else
                    {
                        Old_UserSlipNo = "'" + UserSlipNo + "'" + "," + Old_UserSlipNo;
                        // All_UserSlipNo = "'" + UserSlipNo + "'" + "," + Old_UserSlipNo;
                    }
                    */
                    cmd.ExecuteNonQuery();
                    tran.Commit();
                    success = true;
                    con.Close();
                }
                catch (Exception e1)
                {
                    tran.Rollback();
                } 
            }
            //else
            //{
            //    i++;
            //}

            //if (dgGeneral.Rows.Count == i)
            //{ 
            //    WithoutLastUserSlipNo = Old_UserSlipNo.Substring(0, Old_UserSlipNo.Length - 1);
            //}
        }

        if (success == true)
        {
            Response.Redirect("PendingFillingDate_Result.aspx");

            //Response.Redirect("PendingFillingDate_View.aspx?QUserSlipNo=" + WithoutLastUserSlipNo);
        }
    }
    protected void ddVendorName_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddVendorName.SelectedValue != "0") {
            btnRateHistory.Visible = true;
        }
    }


    [System.Web.Services.WebMethod]
    public static string GetRateFillingDateWise(string FillingDate, string VendorCode, string FuelType)
    {
        var objFin = new TripSubmissionOperationFinancialClosureController();
        return objFin.GetRateFillingDateWise(FillingDate, VendorCode, FuelType);
    }


    protected void dgGeneral_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        foreach (GridViewRow gridrow in dgGeneral.Rows)
        {
            Label ddFuelType = (Label)gridrow.FindControl("lblFuelType");            
            TextBox txtIGST = (TextBox)gridrow.FindControl("txtIGST");
            TextBox txtSGST = (TextBox)gridrow.FindControl("txtSGST");
            TextBox txtCGST = (TextBox)gridrow.FindControl("txtCGST");                       

            if (ddFuelType.Text == "AddBlue")
            {
                txtIGST.Enabled = true;
                txtSGST.Enabled = true;
                txtCGST.Enabled = true;
            }
            else
            {
                txtIGST.Enabled = false;
                txtSGST.Enabled = false;
                txtCGST.Enabled = false;
                txtIGST.Text = "0.00";
                txtSGST.Text = "0.00";
                txtCGST.Text = "0.00";                
            }
        }
    }
}