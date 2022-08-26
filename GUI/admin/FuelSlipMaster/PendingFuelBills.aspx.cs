using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
public partial class GUI_admin_FuelSlipMaster_PendingFuelBills : BasePage
{
    public byte byteRadButtonSelection;
    MyDataSet ds = new MyDataSet();
    DataSet ds1 = new DataSet();
    public static string LoginBrLevel = "", BILL_NO = "", Finyear = "", Brcd = "", CompanyCode = "", BranchCode = "", FinYearcode = "";
    string srno = "";

    decimal TotalAmt = 0, TotalLtr = 0;
    int TotalSlip = 0;

    string FillingDate, VendorName, VehicleNo, TripsheetNo, TripsheetOpen_Dt, VendorCity, Product, UserSlipNo, UserSlip_Dt;
    // decimal Quantity, Rate, Amount;
    string Quantity, Rate, Amount;
    string Prod;
    bool success = false;

    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Form.Attributes.Add("enctype", "multipart/form-data");
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
            tdAmount.Visible = false;
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            string sql = "";
            sql = "SELECT '0' AS Vendorcode, 'All' AS Vendorname UNION SELECT DISTINCT  H.Vendorcode,(H.vendorname+':'+ D.VENDORCITY+':'+H.Vendorcode) AS vendorname FROM webx_VENDOR_HDR H INNER JOIN dbo.webx_VENDOR_DET D ON D.VENDORCODE = H.VENDORCODE WHERE H.Vendor_Type='12' AND H.Active = 'Y' ORDER BY Vendorcode ASC";
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
        //string abc1 = ddVendorName.SelectedValue.ToString();
        //string abc = ddVendorName.SelectedItem.ToString(); 

        tblDCR.Visible = true;
        string VendorCode = ddVendorName.SelectedValue.ToString();
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
        SqlCommand cmd = new SqlCommand("usp_Get_PendingFuelIssueSlip", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@VendorCode", VendorCode);
        cmd.Parameters.AddWithValue("@FromDate", StartDate);
        cmd.Parameters.AddWithValue("@ToDate", EndDate);
        SqlDataReader dr = cmd.ExecuteReader();
        dgGeneral.DataSource = dr;
        dgGeneral.DataBind();

        if (dgGeneral.Rows.Count == 0)
        {
            btnSubmitBills.Visible = false;
            tdAmount.Visible = false;
        }
        else
        {
            if (ddVendorName.SelectedValue != "0")
            {
                btnSubmitBills.Visible = true;
                tdAmount.Visible = true;

            }
        }
        con.Close();
    }

    protected void dgGeneral_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string cb;
            Button btnEdit = (Button)e.Row.FindControl("btnEdit");
            CheckBox chkbxCheck = (CheckBox)e.Row.FindControl("chkbxCheck");
            cb = e.Row.Cells[2].Text;


            if (ddVendorName.SelectedValue == "0")
            {
                chkbxCheck.Enabled = false;
            }
            else
            {
                if (cb == "&nbsp;")
                {
                    btnEdit.Enabled = true;
                    chkbxCheck.Enabled = false;
                }
            }
            //if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
            //{
            //    CheckBox chkbxCheck = (CheckBox)e.Row.FindControl("chkbxCheck");
            //    chkbxCheck.Attributes.Add("OnClick", "javascript:CalculateBalance_FuelSlipAmt(" + e.Row.RowIndex + ");");
            //}


            //****************************************************
            //string cb;
            //Button btnEdit = (Button)e.Row.FindControl("btnEdit");
            //CheckBox chkbxCheck = (CheckBox)e.Row.FindControl("chkbxCheck");
            //cb = e.Row.Cells[2].Text;

            //if (cb == "&nbsp;")
            //{
            //    btnEdit.Enabled = true;
            //    chkbxCheck.Enabled = false;
            //} 



            //int no = e.Row.RowIndex + 2;
            //String c, d;
            //if (no < 10)
            //{ 

            //    Label l1 = (Label)e.Row.FindControl("netamt");
            //    c = "'ctl00_MyCPH1_dgGeneral_ctl0" + Convert.ToString(no) + "_lblAmount'"; 

            //    CheckBox chkBill1 = (CheckBox)e.Row.FindControl("chkbxCheck");
            //    d = "'ctl00_MyCPH1_dgGeneral_ctl0" + Convert.ToString(no) + "_chkbxCheck'";

            //}
            //else
            //{
            //    c = "'ctl00_MyCPH1_dgGeneral_ctl0" + Convert.ToString(no) + "_lblAmount'";
            //    d = "'ctl00_MyCPH1_dgGeneral_ctl0" + Convert.ToString(no) + "_chkbxCheck'";
            //    ((CheckBox)(e.Row.FindControl("chkbxCheck"))).Attributes.Add("onclick", "return calculation(" + c + "," + d + ")");


            //}
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
            //string sql = "UPDATE webx_fuel_issue_slip SET IsFillingDate='N', Sentfor_Fillingdt='" + EntryDate + "' WHERE UserSlipNo='" + UserSlipNo + "' AND FuelType ='" + Prod + "'  AND FillingDate IS NULL";
            SqlCommand cmdTC = new SqlCommand("Usp_FuelBill_UpdateFuelIssueSlipDetail", con, trn);
            cmdTC.CommandType = CommandType.StoredProcedure;
            cmdTC.Parameters.Add("@FuelSlipNo", SqlDbType.VarChar).Value = UserSlipNo;
            cmdTC.Parameters.Add("@FuelType", SqlDbType.VarChar).Value = Prod;
            cmdTC.ExecuteNonQuery();
            trn.Commit();
            con.Close();
            ShowPendingBills(sender, e);

        }
        catch (Exception e1)
        {
            trn.Rollback();
        }
    }

    protected void btnSubmitBills_Click(object sender, EventArgs e)
    {
        string VCode = ddVendorName.SelectedValue.ToString();

        TotalAmt = 0; TotalSlip = 0;

        string EntryBy = Session["empcd"].ToString();
        string UpdateBy = Session["empcd"].ToString();
        string EntryDate = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");
        Brcd = SessionUtilities.CurrentBranchCode.Trim();
        Finyear = SessionUtilities.FinYear.ToString().Trim();
        CompanyCode = SessionUtilities.DefaultCompanyCode.ToString().Trim();
        BranchCode = SessionUtilities.CurrentBranchCode.ToString().Trim();
        FinYearcode = SessionUtilities.YearVal.ToString().Trim();

        FuelAccounting FC = new FuelAccounting(Session["SqlProvider"].ToString().Trim());
        FC.GENERATE_BILLNO(Brcd, Finyear);
        BILL_NO = FC.BillNo;

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        SqlTransaction tran;
        tran = con.BeginTransaction();
        try
        {

            for (int i = 0; i < dgGeneral.Rows.Count; i++)
            {
                CheckBox chkbxCheck = (CheckBox)dgGeneral.Rows[i].FindControl("chkbxCheck");
                FileUpload UploadImg = (FileUpload)dgGeneral.Rows[i].FindControl("fileupload");
                Label lblUloadLink = ((Label)dgGeneral.Rows[i].FindControl("lblUloadLink"));
                string DocumentUploadedPath = "";
                if (chkbxCheck.Checked == true)
                {
                    
                    if (dgGeneral.Rows[i].Cells[2].Text != "")
                    {
                        var strFillingDate = dgGeneral.Rows[i].Cells[2].Text.Split('/');
                        FillingDate = strFillingDate[1] + "/" + strFillingDate[0] + "/" + strFillingDate[2];
                    }
                    else { FillingDate = ""; }

                    if (dgGeneral.Rows[i].Cells[6].Text != "")
                    {
                        var strTripsheetOpen_Dt = dgGeneral.Rows[i].Cells[6].Text.Split('/');
                        TripsheetOpen_Dt = strTripsheetOpen_Dt[1] + "/" + strTripsheetOpen_Dt[0] + "/" + strTripsheetOpen_Dt[2];
                    }
                    else { TripsheetOpen_Dt = ""; }

                    if (dgGeneral.Rows[i].Cells[10].Text != "")
                    {
                        var strUserSlip_Dt = dgGeneral.Rows[i].Cells[10].Text.Split('/');
                        UserSlip_Dt = strUserSlip_Dt[1] + "/" + strUserSlip_Dt[0] + "/" + strUserSlip_Dt[2];
                    }
                    else { UserSlip_Dt = ""; }

                    VendorName = dgGeneral.Rows[i].Cells[3].Text;
                    VehicleNo = dgGeneral.Rows[i].Cells[4].Text;
                    TripsheetNo = dgGeneral.Rows[i].Cells[5].Text;
                    //TripsheetOpen_Dt = dgGeneral.Rows[i].Cells[6].Text;
                    VendorCity = dgGeneral.Rows[i].Cells[7].Text;
                    Product = dgGeneral.Rows[i].Cells[8].Text;
                    UserSlipNo = dgGeneral.Rows[i].Cells[9].Text;
                    //UserSlip_Dt = dgGeneral.Rows[i].Cells[10].Text;


                    


                    Label lblQuantity =  (Label)dgGeneral.Rows[i].FindControl("lblQuantity");
                    Label lblRate = (Label)dgGeneral.Rows[i].FindControl("lblRate");
                    Label Amount = (Label)dgGeneral.Rows[i].FindControl("lblAmount");
                    Quantity = lblQuantity.Text;

                    TotalAmt = TotalAmt + decimal.Parse(Amount.Text);
                    TotalLtr = TotalLtr + decimal.Parse(Quantity);
                    TotalSlip = TotalSlip + 1;

                    if (UploadImg.HasFile)
                    {
                        string UploadFileName = "";
                        var Filename = GetFileName(UploadImg.FileName, "/" + UploadImg.FileName, "PendingFuelBills_" + TripsheetNo + "_" + DateTime.Now.ToString("h:mm:ss tt"));
                        UploadFileName = AzureStorageHelper.UploadBlob("PendingFuelBills", UploadImg, Filename);
                        DocumentUploadedPath = UploadFileName;
                    }


                    if (BILL_NO != "")
                    {
                        SqlCommand cmd = new SqlCommand("usp_FuelBills_Insert", con, tran);
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.Add("@FillingDate", SqlDbType.VarChar).Value = FillingDate;
                        cmd.Parameters.Add("@VendorCode", SqlDbType.VarChar).Value = VCode;
                        cmd.Parameters.Add("@VendorName", SqlDbType.VarChar).Value = VendorName;
                        cmd.Parameters.Add("@VehicleNo", SqlDbType.VarChar).Value = VehicleNo;
                        cmd.Parameters.Add("@TripsheetNo", SqlDbType.VarChar).Value = TripsheetNo;
                        cmd.Parameters.Add("@TripsheetOpen_Dt", SqlDbType.DateTime).Value = TripsheetOpen_Dt;
                        cmd.Parameters.Add("@VendorCity", SqlDbType.VarChar).Value = VendorCity;
                        cmd.Parameters.Add("@Product", SqlDbType.VarChar).Value = Product;
                        cmd.Parameters.Add("@UserSlipNo", SqlDbType.VarChar).Value = UserSlipNo;
                        cmd.Parameters.Add("@UserSlip_Dt", SqlDbType.DateTime).Value = UserSlip_Dt;
                        cmd.Parameters.Add("@Quantity", SqlDbType.Decimal).Value = Quantity;
                        cmd.Parameters.Add("@Rate", SqlDbType.Decimal).Value = Convert.ToDecimal(lblRate.Text);
                        cmd.Parameters.Add("@Amount", SqlDbType.Decimal).Value = Convert.ToDecimal(Amount.Text);
                        cmd.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = EntryBy;
                        cmd.Parameters.Add("@Entry_Dt", SqlDbType.DateTime).Value = EntryDate;
                        cmd.Parameters.Add("@BillNo", SqlDbType.VarChar).Value = BILL_NO;
                        cmd.Parameters.Add("@BILLDT", SqlDbType.DateTime).Value = EntryDate;
                        cmd.Parameters.Add("@Company_Code", SqlDbType.VarChar).Value = CompanyCode;
                        cmd.Parameters.Add("@BranchCode", SqlDbType.VarChar).Value = BranchCode;
                        cmd.Parameters.Add("@FinYearcode", SqlDbType.VarChar).Value = Finyear;
                        cmd.Parameters.Add("@Finyear", SqlDbType.VarChar).Value = Finyear;
                        cmd.Parameters.Add("@DocumentName", SqlDbType.VarChar).Value = DocumentUploadedPath;
                        cmd.ExecuteNonQuery();


                        //string sql = "UPDATE webx_fuel_issue_slip SET IsBilled='Y',  BillNo= '" + BILL_NO + " ' ,  BillingDt= '" + EntryDate + " '   WHERE UserSlipNo='" + UserSlipNo + "' ";
                        SqlCommand cmdTC = new SqlCommand("Usp_FuelBill_UpdateFuelIssueSlipDetail", con, tran);
                        cmdTC.CommandType = CommandType.StoredProcedure;
                        cmdTC.Parameters.Add("@BillNO", SqlDbType.VarChar).Value = BILL_NO;
                        cmdTC.Parameters.Add("@FuelSlipNo", SqlDbType.VarChar).Value = UserSlipNo;
                        cmdTC.ExecuteNonQuery();


                    }

                }

            }
            if (TotalAmt > 0) {
                SqlCommand cmd1 = new SqlCommand("usp_FuelBills_Hdr_Insert", con, tran);
                cmd1.CommandType = CommandType.StoredProcedure;
                cmd1.Parameters.Add("@Bill_No", SqlDbType.VarChar).Value = BILL_NO;
                cmd1.Parameters.Add("@VendorCode", SqlDbType.VarChar).Value = VCode;
                cmd1.Parameters.Add("@TotalAmount", SqlDbType.VarChar).Value = TotalAmt;
                cmd1.Parameters.Add("@TotalLtr", SqlDbType.VarChar).Value = TotalLtr;
                cmd1.Parameters.Add("@TotalSlips", SqlDbType.VarChar).Value = TotalSlip;
                cmd1.Parameters.Add("@BillDate", SqlDbType.VarChar).Value = EntryDate;
                cmd1.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = EntryBy;
                cmd1.Parameters.Add("@Entry_Dt", SqlDbType.VarChar).Value = EntryDate;
                cmd1.Parameters.Add("@Remarks", SqlDbType.VarChar).Value = txtRemarks.Text;
                cmd1.Parameters.Add("@FuelDiscount", SqlDbType.Decimal).Value = Convert.ToDecimal(txtFuleDiscount.Text);
                cmd1.Parameters.Add("@SpecialDiscount", SqlDbType.Decimal).Value = Convert.ToDecimal(txtSpecialDiscount.Text);
                cmd1.Parameters.Add("@NetBillAmount", SqlDbType.Decimal).Value = Convert.ToDecimal(txtNetBillAmount.Text);
                cmd1.ExecuteNonQuery();

                tran.Commit();
                success = true;
            }

        }
        catch (Exception e1)
        {
            MsgBox.Show("Error:" + e1.Message);
            tran.Rollback();
        }
        finally
        {
            con.Close();
        }

        if (success == true)
        {
            Response.Redirect("PendingFuelBills_Result.aspx?QBillNo=" + BILL_NO, false);
        }

    }



    protected void ddVendorName_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddVendorName.SelectedValue != "0")
        {
            btnRateHistory.Visible = true;
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            string sql = "";
			sql = "SELECT ISNULL(F.DiscountRate,0) AS DiscountRate FROM dbo.webx_VENDOR_HDR V WITH(NOLOCK) INNER JOIN Webx_THCMaster_FuelDiscount F WITH(NOLOCK) ON F.VendorCode = V.VENDORCODE WHERE V.VENDORCODE ='" + ddVendorName.SelectedValue + "'AND GETDATE() BETWEEN F.FromPeriod AND F.ToPeriod AND ISNULL(F.IsApproved,'N')='Y'";
            SqlCommand sqlcmd = new SqlCommand(sql, conn);

            txtDiscountRate.Text = Convert.ToString(sqlcmd.ExecuteScalar());

            conn.Close();
        }
        else
        {
            txtDiscountRate.Text = "0";
        }
        for (int i = 0; i < dgGeneral.Rows.Count; i++)
        {
            CheckBox chkbxCheck = (CheckBox)dgGeneral.Rows[i].FindControl("chkbxCheck");
            chkbxCheck.Checked = false;
            if (ddVendorName.SelectedValue != "0")
            {
                chkbxCheck.Enabled = true;
            }
            else
            {
                chkbxCheck.Enabled = false;
            }
        }
    }

    private string GetFileName(string fileName, string docno, string pref)
    {
        string strRet = fileName;

        string pat = @"(?:.+)(.+)\.(.+)";
        Regex r = new Regex(pat);
        //run
        Match m = r.Match(fileName);
        string file_ext = m.Groups[2].Captures[0].ToString();
        string filename = m.Groups[1].Captures[0].ToString();
        docno = docno.Replace("/", "$");

        strRet = pref + "_" + docno + "." + file_ext;

        return strRet;
    }
 
}
