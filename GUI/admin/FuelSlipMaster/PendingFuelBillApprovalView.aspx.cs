using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_admin_FuelSlipMaster_PendingFuelBillApprovalView : System.Web.UI.Page
{
    public byte byteRadButtonSelection;
    MyDataSet ds = new MyDataSet();
    DataSet ds1 = new DataSet();
    public static string LoginBrLevel = "";
    string srno = "";

    string FillingDate, VendorName, VehicleNo, TripsheetNo, TripsheetOpen_Dt, VendorCity, Product, UserSlipNo, UserSlip_Dt;
    // decimal Quantity, Rate, Amount;
    string Quantity, Rate, Amount;
    string Prod;
    bool success;
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        tblDCR.Visible = true;
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);
        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
        if (!IsPostBack)
        {
           // txtDateFrom.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
           // txtDateTo.Text = System.DateTime.Today.ToString("dd/MM/yyyy");

            btnSubmitBills.Visible = false;

            string BillNo = Request.QueryString["Billno"];
            //string BillNo = "B12";
            SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();
            SqlCommand cmd = new SqlCommand("USP_GetPendingFuelBillApproval_ViewByFuelBillNo", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Billno", BillNo);
            
            SqlDataReader dr = cmd.ExecuteReader();
            dgGeneral.DataSource = dr;
            dgGeneral.DataBind();
            dr.Close();
            SqlCommand cmd2 = new SqlCommand("USP_GetPendingFuelBillApproval_ViewByFuelBillNoTotaldetails", con);
            cmd2.CommandType = CommandType.StoredProcedure;
            cmd2.Parameters.AddWithValue("@Billno", BillNo);
            DataTable dt = new DataTable("Customers");
            using (SqlDataReader sdr = cmd2.ExecuteReader())
            {
                dt.Load(sdr);
            }
            //SqlDataReader dr2 = cmd2.ExecuteReader();
            lblTotalAmount.Text = dt.Rows[0]["TotalAmount"].ToString();
            lblDiscount.Text = dt.Rows[0]["Discount"].ToString();
            lblSpcialDiscount.Text = dt.Rows[0]["SpecialDiscount"].ToString();
            lblNetbillAmount.Text = dt.Rows[0]["NetBillAmount"].ToString();

            if (dgGeneral.Rows.Count == 0)
            {
                btnSubmitBills.Visible = false;
            }
           
            con.Close();
        }
    }
    public void daterange(object source, ServerValidateEventArgs value)
    {
        //if (txtDateFrom.Text == "")
        //{
        //    value.IsValid = false;
        //    return;
        //}
        //if (txtDateTo.Text == "")
        //{
        //    value.IsValid = false;
        //    return;
        //}
       // string[] strDtFrom = txtDateFrom.Text.Split('/');
        //DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        //string[] strDtTo = txtDateTo.Text.Split('/');
       // DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));
        //System.TimeSpan diffResult = dt2.Subtract(dt1);

        //if (dt1 > dt2)
        //{
        //    //CustomValidator1.ErrorMessage = "From Date can not be Less then To date";
        //    value.IsValid = false;
        //    return;

        //}
    }

    protected void radDate_SelectedIndexChanged(object sender, EventArgs e)
    {
        RadioButtonList rbl = new RadioButtonList();
        rbl = (RadioButtonList)sender;

        byteRadButtonSelection = Convert.ToByte(rbl.SelectedItem.Value);

        if (rbl.Items[0].Selected)
        {
          //  txtDateFrom.ReadOnly = false;
            //txtDateTo.ReadOnly = false;
        }
        else
        {
           // txtDateFrom.ReadOnly = true;
           // txtDateTo.ReadOnly = true;
        }

        if (rbl.Items[1].Selected)
        {
            //txtDateFrom.ReadOnly = true;
            //txtDateTo.ReadOnly = true;
            //txtDateFrom.Text = System.DateTime.Today.AddDays(-7).ToString("dd/MM/yyyy");
            //txtDateTo.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
        }
        else if (rbl.Items[2].Selected)
        {
            //txtDateFrom.ReadOnly = true;
            //txtDateTo.ReadOnly = true;
            //txtDateFrom.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            //txtDateTo.Text = txtDateFrom.Text;
        }
        else if (rbl.Items[3].Selected)
        {
            //txtDateFrom.ReadOnly = true;
            //txtDateTo.ReadOnly = true;
            //txtDateFrom.Text = System.DateTime.Today.AddYears(-50).ToString("dd/MM/yyyy");
            //txtDateTo.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
        }

    }
    protected void dgGeneral_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string cb;
            Button btnEdit = (Button)e.Row.FindControl("btnEdit");
            CheckBox chkbxCheck = (CheckBox)e.Row.FindControl("chkbxCheck");
            cb = e.Row.Cells[2].Text;

            if (cb == "&nbsp;")
            {
                btnEdit.Enabled = true;
                chkbxCheck.Enabled = false;
            }
        }
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
        int index = gvRow.RowIndex;
        Button btnEdit = (Button)dgGeneral.Rows[index].FindControl("btnEdit");
        Prod = dgGeneral.Rows[index].Cells[8].Text;
        UserSlipNo = dgGeneral.Rows[index].Cells[9].Text;
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        SqlTransaction trn;
        trn = con.BeginTransaction();
        string EntryDate = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");

        try
        {
            string sql = "UPDATE webx_fuel_issue_slip SET IsFillingDate='N', Sentfor_Fillingdt='" + EntryDate + "' WHERE UserSlipNo='" + UserSlipNo + "' AND FuelType ='" + Prod + "'  AND FillingDate IS NULL";
            SqlCommand cmdTC = new SqlCommand(sql, con, trn);
            cmdTC.ExecuteNonQuery();
            trn.Commit();
            con.Close();
           // ShowPendingBillsApproval(sender, e);

        }
        catch (Exception e1)
        {
            trn.Rollback();
        }
    }

    protected void btnSubmitBills_Click(object sender, EventArgs e)
    {
        for (int i = 0; i < dgGeneral.Rows.Count; i++)
        {
            CheckBox chkbxCheck = (CheckBox)dgGeneral.Rows[i].FindControl("chkbxCheck");
            FillingDate = dgGeneral.Rows[i].Cells[2].Text;
            VendorName = dgGeneral.Rows[i].Cells[3].Text;
            VehicleNo = dgGeneral.Rows[i].Cells[4].Text;
            TripsheetNo = dgGeneral.Rows[i].Cells[5].Text;
            TripsheetOpen_Dt = dgGeneral.Rows[i].Cells[6].Text;
            VendorCity = dgGeneral.Rows[i].Cells[7].Text;
            Product = dgGeneral.Rows[i].Cells[8].Text;
            UserSlipNo = dgGeneral.Rows[i].Cells[9].Text;
            UserSlip_Dt = dgGeneral.Rows[i].Cells[10].Text;
            Quantity = dgGeneral.Rows[i].Cells[11].Text;
            Rate = dgGeneral.Rows[i].Cells[12].Text;
            Amount = dgGeneral.Rows[i].Cells[13].Text;

            SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();
            SqlTransaction tran;
            tran = con.BeginTransaction();
            string EntryBy = Session["empcd"].ToString();
            string UpdateBy = Session["empcd"].ToString();
            string EntryDate = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");

            try
            {
                // SqlCommand cmd = new SqlCommand("usp_Insert_Fuel_Vendor_Contract", con, tran);
                SqlCommand cmd = new SqlCommand("", con, tran);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@FillingDate", SqlDbType.VarChar).Value = FillingDate;
                cmd.Parameters.Add("@VendorName", SqlDbType.VarChar).Value = VendorName;
                cmd.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = VehicleNo;
                cmd.Parameters.Add("@TripsheetNo", SqlDbType.DateTime).Value = TripsheetNo;
                cmd.Parameters.Add("@TripsheetOpen_Dt", SqlDbType.DateTime).Value = TripsheetOpen_Dt;
                cmd.Parameters.Add("@VendorCity", SqlDbType.VarChar).Value = VendorCity;
                cmd.Parameters.Add("@Product", SqlDbType.VarChar).Value = Product;
                cmd.Parameters.Add("@UserSlipNo", SqlDbType.VarChar).Value = UserSlipNo;
                cmd.Parameters.Add("@UserSlip_Dt", SqlDbType.VarChar).Value = UserSlip_Dt;
                cmd.Parameters.Add("@Quantity", SqlDbType.DateTime).Value = Quantity;
                cmd.Parameters.Add("@Rate", SqlDbType.DateTime).Value = Rate;
                cmd.Parameters.Add("@Amount", SqlDbType.VarChar).Value = Amount;

                cmd.Parameters.Add("@EntryBy", SqlDbType.DateTime).Value = EntryBy;
                cmd.Parameters.Add("@Entry_Dt", SqlDbType.VarChar).Value = EntryDate;
                cmd.ExecuteNonQuery();
                tran.Commit();
                success = true;
                con.Close();
            }
            catch (Exception e1)
            {
                tran.Rollback();
            }

            if (success == true)
            {
                //Response.Redirect("FuelRateValidation_Result.aspx");
            }


        }
    }
    //protected void ShowPendingBillsApproval(object sender, EventArgs e)
    //{
    //    tblDCR.Visible = true;
    //    string VendorName = ddVendorName.SelectedValue.ToString();
    //    //string VendorName = ddVendorName.SelectedItem.ToString();

    //    string BillNo = txtfuelBillNo.Text.ToString();

    //    string[] strDtFrom = txtDateFrom.Text.Split('/');
    //    DateTime d1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
    //    string[] strDtTo = txtDateTo.Text.Split('/');
    //    DateTime d2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));
    //    var StartTime = TimeSpan.Parse("00:00:00");
    //    var EndTime = TimeSpan.Parse("23:59:59");
    //    var StartDate = d1 + StartTime;
    //    var EndDate = d2 + EndTime;

    //    SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    con.Open();
    //    SqlCommand cmd = new SqlCommand("USP_Get_Pending_Fuel_Bill_Approval", con);
    //    cmd.CommandType = CommandType.StoredProcedure;
    //    cmd.Parameters.AddWithValue("@BillNo", BillNo);
    //    cmd.Parameters.AddWithValue("@FromDate", StartDate);
    //    cmd.Parameters.AddWithValue("@ToDate", EndDate);
    //    cmd.Parameters.AddWithValue("@VendorCode", VendorName);
    //    SqlDataReader dr = cmd.ExecuteReader();
    //    dgGeneral.DataSource = dr;
    //    dgGeneral.DataBind();
    //    if (dgGeneral.Rows.Count == 0)
    //    {
    //        btnSubmitBills.Visible = false;
    //    }
    //    else
    //    {
    //        if (ddVendorName.SelectedValue != "All")
    //        {
    //            btnSubmitBills.Visible = true;
    //        }
    //    }
    //    con.Close();
    //}
}