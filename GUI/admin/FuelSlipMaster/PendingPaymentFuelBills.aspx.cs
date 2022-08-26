using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebX.Common;

public partial class GUI_admin_FuelSlipMaster_PendingPaymentFuelBills : BasePage
{
    public byte byteRadButtonSelection;
    MyDataSet ds = new MyDataSet();
    DataSet ds1 = new DataSet();
    public static string LoginBrLevel = "";
    string srno = "";

    string VehicleNo, TripsheetNo, TripsheetOpen_Dt, VendorCity, Product, UserSlipNo, UserSlip_Dt;
    // decimal Quantity, Rate, Amount;
    string Quantity, Rate, Amount;
    string Prod;
    bool success;
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        UserMessage.Hide();
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);
        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
        if (!IsPostBack)
        {
            CreateToken();
            txtDateFrom.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtDateTo.Text = System.DateTime.Today.ToString("dd/MM/yyyy");

            btnSubmitBills.Visible = false;
            txtGrandTotal.Visible = false;
            Total.Visible = false;
            txtFromDate.Text = txtDateFrom.Text;

            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            //string sql = "USP_BIND_DRP_VENDROR_BANK";
            string sql = "", sql1 = "";
            sql = "SELECT '0' AS Vendorcode, 'All' AS Vendorname UNION SELECT  H.VENDORCODE,VENDORNAME = VENDORNAME + ':' + D.VENDORCITY +':'+ H.VENDORCODE  FROM webx_VENDOR_HDR H INNER JOIN dbo.webx_VENDOR_DET D ON D.VENDORCODE = H.VENDORCODE WHERE Vendor_Type='12' AND H.Active='Y' ORDER BY Vendorcode ASC";
            sql1 = "SELECT '0' AS BankCode, 'All' AS BankName UNION SELECT  WA.acccode,WA.accdesc FROM webx_acctinfo WA WITH(NOLOCK) INNER JOIN webx_location WL WITH(NOLOCK) ON WL.LocCode IN(SELECT Items FROM Split(WA.bkloccode, ',')) WHERE WA.Acccategory = 'BANK' AND WA.ACTIVEFLAG = 'Y' AND WL.LocCode='"+ SessionUtilities.CurrentBranchCode.ToString()+"'";

            //sql = "SELECT '0' AS Vendorcode, 'All' AS Vendorname UNION SELECT  Vendorcode,vendorCode+':'+ vendorname FROM webx_VENDOR_HDR WHERE Vendor_Type='12' ORDER BY Vendorcode ASC";
            SqlCommand sqlcmd = new SqlCommand(sql, conn);
            SqlCommand sqlcmd1 = new SqlCommand(sql1, conn);
            SqlDataReader dr;
            SqlDataReader dr1;

            //DataSet ds = new DataSet();
            dr = sqlcmd.ExecuteReader();

            ddVendorName.Items.Clear();
            ddlBank.Items.Clear();
            // ddlBank.DataSource = ds.Tables[2];
            //ddlBank.DataBind();

            while (dr.Read())
            {
                //ddVendorName.Items.Add(new ListItem(dr["VendorName"].ToString()));
                ddVendorName.Items.Add(new ListItem(dr["VendorName"].ToString(), dr["Vendorcode"].ToString()));

                //ddlBank.Items.Add(new ListItem(dr["BankName"].ToString(), dr["BankCode"].ToString()));
            }
            dr.Close();

            dr1 = sqlcmd1.ExecuteReader();
            while (dr1.Read())
            {
                ddlBank.Items.Add(new ListItem(dr1["BankName"].ToString(), dr1["BankCode"].ToString()));
            }
            dr1.Close();
            conn.Close();
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
    protected void dgGeneral_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string cb;
            Button btnEdit = (Button)e.Row.FindControl("btnEdit");
            CheckBox chkbxCheck = (CheckBox)e.Row.FindControl("chkbxCheck");
            TextBox txtPaidAmount = (TextBox)e.Row.FindControl("txtPaidAmount");
            cb = e.Row.Cells[2].Text;

            if (cb == "&nbsp;")
            {
                btnEdit.Enabled = true;
                chkbxCheck.Enabled = false;
            }
            int no = e.Row.RowIndex + 2;
            String c, d, a;

            int id, i;
            if (no <= 9)
            {
                Label l1 = (Label)e.Row.FindControl("netamt");
                c = "'ctl00_MyCPH1_dgGeneral_ctl0" + Convert.ToString(no) + "_txtPaidAmount'";
                CheckBox chkBill1 = (CheckBox)e.Row.FindControl("chkbxCheck");
                d = "'ctl00_MyCPH1_dgGeneral_ctl0" + Convert.ToString(no) + "_chkbxCheck'";
            }
            else
            {
                c = "'ctl00_MyCPH1_dgGeneral_ctl" + Convert.ToString(no) + "_txtPaidAmount'";
                d = "'ctl00_MyCPH1_dgGeneral_ctl" + Convert.ToString(no) + "_chkbxCheck'";
            }
            ((CheckBox)(e.Row.FindControl("chkbxCheck"))).Attributes.Add("onclick", "return calculation(" + c + "," + d + ")");
            ((TextBox)(e.Row.FindControl("txtPaidAmount"))).Attributes.Add("OnBlur", "CalculatePendingAmount(this)");
        }
    }

    protected void btnSubmitBills_Click(object sender, EventArgs e)
    {

        if (IsTokenValid())
        {
            string VendorName = ddVendorName.SelectedValue.ToString();
            string InstrumentType = drpinstrument.SelectedItem.ToString();
            string BankCode = ddlBank.SelectedValue.ToString();
            string BillNONEW = "0";

            var strxml = "<ROOT>";
            for (int i = 0; i < dgGeneral.Rows.Count; i++)
            {
                CheckBox chkbxCheck = (CheckBox)dgGeneral.Rows[i].FindControl("chkbxCheck");
                if (chkbxCheck.Checked == true)
                {
                    string Billno = "", BillDate = "", TotalLtr = "", TotalSlips = "";
                    TextBox txtPaidAmount = (TextBox)dgGeneral.Rows[i].FindControl("txtPaidAmount");
                    Label lblPendingAmount = (Label)dgGeneral.Rows[i].FindControl("lblPendingAmount");
                    HiddenField hdnPendingAmount = (HiddenField)dgGeneral.Rows[i].FindControl("hdnPendingAmount");
                    Label lblAmount = (Label)dgGeneral.Rows[i].FindControl("lblAmount");
                    Label lblBillNo = (Label)dgGeneral.Rows[i].FindControl("lblBillNo");
                    Label lblBillDate = (Label)dgGeneral.Rows[i].FindControl("lblBillDate");
                    Label lblTotalLtr = (Label)dgGeneral.Rows[i].FindControl("lblTotalLtr");
                    Label lblTotalSlips = (Label)dgGeneral.Rows[i].FindControl("lblTotalSlips");

                    Billno = lblBillNo.Text;
                    BillDate = lblBillDate.Text;
                    TotalLtr = lblTotalLtr.Text;
                    TotalSlips = lblTotalSlips.Text;

                    //Billno = dgGeneral.Rows[i].Cells[3].Text;
                    //BillDate = dgGeneral.Rows[i].Cells[4].Text;
                    //TotalLtr = dgGeneral.Rows[i].Cells[5].Text;
                    //TotalSlips = dgGeneral.Rows[i].Cells[6].Text;

                    string PaidAmaount = txtPaidAmount.Text;
                    string PendingAmaount = hdnPendingAmount.Value;
                    string Amount = lblAmount.Text;
                    if (PendingAmaount == "")
                    {
                        PendingAmaount = "0";
                    }

                    //string InstrumentNo = txtinstrumentno.Text;
                    string GrandTotal = txtGrandTotal.Text;

                    SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                    con.Open();
                    SqlTransaction tran;
                    tran = con.BeginTransaction();

                    strxml = strxml + "<BillDetails>";
                    strxml = strxml + "<BillNo>" + Billno + "</BillNo>";
                    strxml = strxml + "<VendorCode>" + VendorName + "</VendorCode>";
                    strxml = strxml + "<BillDate>" + BillDate + "</BillDate>";
                    strxml = strxml + "<TotalLiter>" + TotalLtr + "</TotalLiter>";
                    strxml = strxml + "<TotalSlip>" + TotalSlips + "</TotalSlip>";
                    strxml = strxml + "<TotalAmount>" + Amount + "</TotalAmount>";
                    strxml = strxml + "<PaidAmount>" + PaidAmaount + "</PaidAmount>";
                    strxml = strxml + "<PendingAmount>" + PendingAmaount + "</PendingAmount>";
                    strxml = strxml + "<GrandTotal>" + GrandTotal + "</GrandTotal>";


                    string[] strDtFrom = txtFromDate.Text.Split('/');
                    DateTime d1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));

                    strxml = strxml + "<InstrumentType>" + InstrumentType + "</InstrumentType>";
                    strxml = strxml + "<InstrumentNo>" + txtinstrumentno.Text + "</InstrumentNo>";
                    strxml = strxml + "<InstrumentDate>" + d1 + "</InstrumentDate>";
                    strxml = strxml + "<InstrumentAmount>" + txtInstrumentAmount.Text + "</InstrumentAmount>";
                    strxml = strxml + "<ReedemAmount>" + txtReedem.Text + "</ReedemAmount>";
                    strxml = strxml + "<TotalPaymentAmt>" + txtTotalPaymentAmt.Text + "</TotalPaymentAmt>";
                    strxml = strxml + "<BankCode>" + BankCode + "</BankCode>";
                    strxml = strxml + "<OilCompany>" + txtOilCompany.Text + "</OilCompany>";
                    strxml = strxml + "<PaymentRemarks>" + txtRemarks.Text + "</PaymentRemarks>";
                    strxml = strxml + "</BillDetails>";

                    //// SqlCommand cmd = new SqlCommand("usp_Insert_Fuel_Vendor_Contract", con, tran);
                    //SqlCommand cmd = new SqlCommand("Usp_FuelBillPayement_Insert", con, tran);
                    //cmd.CommandType = CommandType.StoredProcedure;

                    //cmd.Parameters.Add("@BillNo", SqlDbType.VarChar).Value = Billno;
                    //cmd.Parameters.Add("@VendorCode", SqlDbType.VarChar).Value = VendorName;
                    //cmd.Parameters.Add("@BillDate", SqlDbType.DateTime).Value = BillDate;
                    //cmd.Parameters.Add("@TotalLiter", SqlDbType.VarChar).Value = TotalLtr;
                    //cmd.Parameters.Add("@TotalSlip", SqlDbType.VarChar).Value = TotalSlips;
                    //cmd.Parameters.Add("@TotalAmount", SqlDbType.VarChar).Value = Amount;
                    //cmd.Parameters.Add("@PaidAmount", SqlDbType.VarChar).Value = PaidAmaount;
                    //cmd.Parameters.Add("@PendingAmount", SqlDbType.VarChar).Value = PendingAmaount;
                    //cmd.Parameters.Add("@GrandTotal", SqlDbType.VarChar).Value = GrandTotal;
                    //cmd.Parameters.Add("@InstrumentType", SqlDbType.VarChar).Value = InstrumentType;
                    //cmd.Parameters.Add("@InstrumentNo", SqlDbType.VarChar).Value = InstrumentNo;
                    //cmd.Parameters.Add("@InstrumentDate", SqlDbType.DateTime).Value = d1;
                    //cmd.Parameters.Add("@InstrumentAmount", SqlDbType.DateTime).Value = txtInstrumentAmount.Text;
                    //cmd.Parameters.Add("@TotalPaymentAmt", SqlDbType.VarChar).Value = txtTotalPaymentAmt.Text;
                    //cmd.Parameters.Add("@ReedemAmount", SqlDbType.VarChar).Value = txtReedem.Text;
                    //cmd.Parameters.Add("@BankCode", SqlDbType.VarChar).Value = BankCode;
                    //cmd.Parameters.Add("@OilCompany", SqlDbType.VarChar).Value = txtOilCompany.Text;
                    ////cmd.Parameters.Add("@CreatedDate", SqlDbType.DateTime).Value = d1;
                    //cmd.Parameters.Add("@CreatedBy", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID;
                    ////cmd.Parameters.Add("@UpdatedDate", SqlDbType.DateTime).Value = d1;
                    //cmd.Parameters.Add("@UpdatedBy", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID;
                    //cmd.Parameters.Add("@Brcd", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode;
                    //cmd.Parameters.Add("@Finyear", SqlDbType.VarChar).Value = SessionUtilities.FinYear;

                    //BillNONEW =  Billno;
                    ////BillNONEW = "'" + Billno + "'";
                    //cmd.ExecuteNonQuery();
                    //tran.Commit();
                    //success = true;
                    //con.Close();
                }
            }
            strxml = strxml + "<CreatedBy>" + SessionUtilities.CurrentEmployeeID + "</CreatedBy>";
            strxml = strxml + "<Brcd>" + SessionUtilities.CurrentBranchCode + "</Brcd>";
            strxml = strxml + "<Finyear>" + SessionUtilities.FinYear + "</Finyear>";
            strxml = strxml + "</ROOT>";

            var obj = new WebXHelper(SessionUtilities.ConnectionString);
            DataTable dtResult = new DataTable();
            obj.BeginTransaction();
            try
            {
                strxml = XmlUtility.CleanXmlString(strxml);

                SqlParameter[] prm = new SqlParameter[1];
                prm[0] = new SqlParameter("@xml", strxml);

                DataSet dsResult = obj.ExecuteDataSet(CommandType.StoredProcedure, "Usp_FuelBillPayement_Insert", prm);

                dtResult = dsResult.Tables[1];

                if (dtResult.Rows.Count > 0)
                {
                    success = true;
                }
                obj.CommitTransaction();
                ConsumeToken();
            }
            catch (Exception ex)
            {
                obj.RollBackTransaction();
                UserMessage.Show(ex.Message);
            }
            finally
            {
                obj.Dispose();
            }

            if (success == true)
            {
                Response.Redirect("PendingPaymentFuelBills_Result.aspx?VoucherNo=" + dtResult.Rows[0]["VoucherNo"].ToString() + "&VoucherDate=" + dtResult.Rows[0]["VoucherDate"].ToString() + "&Amount=" + dtResult.Rows[0]["Amount"].ToString());
            }
            else
            {
                UserMessage.Show("Payment Failed");
            }
        }
    }
    protected void ShowPendingPayemntBills(object sender, EventArgs e)
    {
        btnSubmit.Visible = false;
        tblDCR.Visible = true;
        txtGrandTotal.Text = "0";
        string VendorCode = ddVendorName.SelectedValue.ToString();
        //string VendorName = ddVendorName.SelectedItem.ToString();

        //string BillNo = txtfuelBillNo.Text.ToString();

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
        SqlCommand cmd = new SqlCommand("USP_Get_Pending_Payment_Fuel_Bill", con);
        cmd.CommandType = CommandType.StoredProcedure;
        // cmd.Parameters.AddWithValue("@BillNo", BillNo);
        cmd.Parameters.AddWithValue("@FromDate", StartDate);
        cmd.Parameters.AddWithValue("@ToDate", EndDate);
        cmd.Parameters.AddWithValue("@VendorCode", VendorCode);
        SqlDataReader dr = cmd.ExecuteReader();
        dgGeneral.DataSource = dr;
        dgGeneral.DataBind();
        if (dgGeneral.Rows.Count == 0)
        {
            btnSubmitBills.Visible = false;
            txtGrandTotal.Visible = false;
            Total.Visible = false;
        }
        else
        {
            if (ddVendorName.SelectedValue != "All")
            {
                btnSubmitBills.Visible = true;
                txtGrandTotal.Visible = true;
                Total.Visible = true;
                trinstrument.Visible = true;
            }
        }
        string VendorNamea = ddVendorName.SelectedValue.ToString();
        if (VendorNamea == "0")
        {
            btnSubmitBills.Visible = false;
            trinstrument.Visible = false;
        }
        con.Close();
    }
    protected void ddVendorName_SelectedIndexChanged(object sender, EventArgs e)
    {
        string VendorName = ddVendorName.SelectedValue.ToString();
        if (VendorName == "0")
        {
            btnSubmitBills.Visible = false;
        }
    }
}
