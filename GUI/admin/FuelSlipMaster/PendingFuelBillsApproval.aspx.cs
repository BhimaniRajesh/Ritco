using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_admin_FuelSlipMaster_PendingFuelBillsApproval : System.Web.UI.Page
{
    public byte byteRadButtonSelection;
    //MyDataSet ds = new MyDataSet();
    DataSet ds1 = new DataSet();
    public static string LoginBrLevel = "";
    string srno = "";

    string isApproved, ApprovedDate, ApprovedBy;
    // decimal Quantity, Rate, Amount;
    //string Quantity, Rate, Amount;
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
            txtDateFrom.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtDateTo.Text = System.DateTime.Today.ToString("dd/MM/yyyy");

            btnSubmitBills.Visible = false;
            btnReject.Visible = false;


            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            string sql = "";
            sql = "SELECT '0' AS Vendorcode, 'All' AS Vendorname UNION SELECT  H.VENDORCODE,VENDORNAME =  VENDORNAME + ':' + D.VENDORCITY + ':'+ H.VENDORCODE FROM webx_VENDOR_HDR H INNER JOIN dbo.webx_VENDOR_DET D ON D.VENDORCODE = H.VENDORCODE WHERE Vendor_Type='12' ORDER BY Vendorcode ASC";
            //sql = "SELECT '0' AS Vendorcode, 'All' AS Vendorname UNION SELECT  Vendorcode,vendorCode+':'+ vendorname FROM webx_VENDOR_HDR WHERE Vendor_Type='12' ORDER BY Vendorcode ASC";
            SqlCommand sqlcmd = new SqlCommand(sql, conn);
            SqlDataReader dr;
            dr = sqlcmd.ExecuteReader();
            ddVendorName.Items.Clear();

            while (dr.Read())
            {
                //ddVendorName.Items.Add(new ListItem(dr["VendorName"].ToString()));
                ddVendorName.Items.Add(new ListItem(dr["VendorName"].ToString(), dr["Vendorcode"].ToString()));
            }
            dr.Close();
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
        // GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
        // int index = gvRow.RowIndex;
        // Button btnEdit = (Button)dgGeneral.Rows[index].FindControl("btnEdit");
        // Prod = dgGeneral.Rows[index].Cells[8].Text;
        //// UserSlipNo = dgGeneral.Rows[index].Cells[9].Text;
        // SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        // con.Open();
        // SqlTransaction trn;
        // trn = con.BeginTransaction();
        // string EntryDate = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");

        // try
        // {
        //    // string sql = "UPDATE webx_fuel_issue_slip SET IsFillingDate='N', Sentfor_Fillingdt='" + EntryDate + "' WHERE UserSlipNo='" + UserSlipNo + "' AND FuelType ='" + Prod + "'  AND FillingDate IS NULL";
        //     SqlCommand cmdTC = new SqlCommand(sql, con, trn);
        //     cmdTC.ExecuteNonQuery();
        //     trn.Commit();
        //     con.Close();
        //     ShowPendingBillsApproval(sender, e);

        // }
        // catch (Exception e1)
        // {
        //     trn.Rollback();
        // }
    }

    protected void btnSubmitBills_Click(object sender, EventArgs e)
    {
        string VCode = ddVendorName.SelectedValue.ToString();
		string strBillno = "";
        for (int i = 0; i < dgGeneral.Rows.Count; i++)
        {
            CheckBox chkbxCheck = (CheckBox)dgGeneral.Rows[i].FindControl("chkbxCheck");

            if (chkbxCheck.Checked == true)
            {
				decimal NetAmount = 0;
                var Billno = ((HyperLink)dgGeneral.Rows[i].Cells[3].Controls[0]).Text;
                var TotalAmount = ((HyperLink)dgGeneral.Rows[i].Cells[3].Controls[0]).Text;
                var lblNetAmount = (Label)dgGeneral.Rows[i].FindControl("lblNetAmount");
                var txtSpecialDiscount = (TextBox)dgGeneral.Rows[i].FindControl("lblSpecialDiscount");
				NetAmount = Convert.ToDecimal(lblNetAmount.Text) - Convert.ToDecimal(txtSpecialDiscount.Text);

                strBillno = strBillno + "," + Billno;
                SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                con.Open();
                SqlTransaction tran;
                tran = con.BeginTransaction();

                try
                {
                    SqlCommand cmd = new SqlCommand("usp_PendingFuelBillApproval", con, tran);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@BillNo", SqlDbType.VarChar).Value = Billno;
                    cmd.Parameters.Add("@ApprovedBy", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID;
                    cmd.Parameters.Add("@isApproved", SqlDbType.VarChar).Value = "Y";
                    cmd.Parameters.Add("@NetBillAmount", SqlDbType.VarChar).Value = NetAmount;
                    cmd.Parameters.Add("@SpecialDiscount", SqlDbType.VarChar).Value = txtSpecialDiscount.Text;
                    cmd.Parameters.Add("@Brcd", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode;
                    cmd.Parameters.Add("@Finyear", SqlDbType.VarChar).Value = SessionUtilities.FinYear;
                    cmd.Parameters.Add("@DiaspprovedRemarks", SqlDbType.VarChar).Value = "";

                    cmd.ExecuteNonQuery();

                    tran.Commit();
                    success = true;
                }
                catch (Exception e1)
                {
                    tran.Rollback();
                }
                finally
                {
                    con.Close();
                }
            }
            //else
            //{
            //    i++;
            //}
        }
        if (success == true)
        {
            //Response.Redirect("PendingFuelBillsApproval_Result.aspx?Billno=" + Billno);
             Response.Redirect("PendingFuelBillsApproval_Result.aspx?Type=approved&Billno="+strBillno);
        }
    }
    protected void ShowPendingBillsApproval(object sender, EventArgs e)
    {
        tblDCR.Visible = true;
        string VendorName = ddVendorName.SelectedValue.ToString();
        //string VendorName = ddVendorName.SelectedItem.ToString();

        string BillNo = txtfuelBillNo.Text.ToString();

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
        SqlCommand cmd = new SqlCommand("USP_Get_Pending_Fuel_Bill_Approval", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@BillNo", BillNo);
        cmd.Parameters.AddWithValue("@FromDate", StartDate);
        cmd.Parameters.AddWithValue("@ToDate", EndDate);
        cmd.Parameters.AddWithValue("@VendorCode", VendorName);
		cmd.Parameters.AddWithValue("@Brcd", SessionUtilities.CurrentBranchCode);
        SqlDataReader dr = cmd.ExecuteReader();
        dgGeneral.DataSource = dr;
        dgGeneral.DataBind();
        if (dgGeneral.Rows.Count == 0)
        {
            btnSubmitBills.Visible = false;
            btnReject.Visible=false;
            TRPayment.Visible=false;
            TRPayment1.Visible=false;
        }
        else
        {
            if (ddVendorName.SelectedValue != "All")
            {
                btnSubmitBills.Visible = true;
                btnReject.Visible=true;
            }
            TRPayment.Visible=true;
            TRPayment1.Visible=true;
        }
        con.Close();
    }

    protected void btnReject_Click(object sender, EventArgs e)
    {
        if (txtDisapprovedRemarks.Text=="")
        {
            UserMessage.Show("Please Enter disapproved remarks");
            return;
        }
        else
        {
            string VCode = ddVendorName.SelectedValue.ToString();

            for (int i = 0; i < dgGeneral.Rows.Count; i++)
            {
                CheckBox chkbxCheck = (CheckBox)dgGeneral.Rows[i].FindControl("chkbxCheck");

                if (chkbxCheck.Checked == true)
                {
                    var Billno = ((HyperLink)dgGeneral.Rows[i].Cells[3].Controls[0]).Text;
                    var lblNetAmount = (Label)dgGeneral.Rows[i].FindControl("lblNetAmount");
                    SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                    con.Open();
                    SqlTransaction tran;
                    tran = con.BeginTransaction();
                    try
                    {
                        SqlCommand cmd = new SqlCommand("usp_PendingFuelBillApproval", con, tran);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@BillNo", SqlDbType.VarChar).Value = Billno;
                        cmd.Parameters.Add("@isApproved", SqlDbType.VarChar).Value = "N";
                        cmd.Parameters.Add("@ApprovedBy", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID;
                        cmd.Parameters.Add("@DiaspprovedRemarks", SqlDbType.VarChar).Value = txtDisapprovedRemarks.Text;
                        cmd.Parameters.Add("@Brcd", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode;
                        cmd.Parameters.Add("@Finyear", SqlDbType.VarChar).Value = SessionUtilities.FinYear;
                        //cmd.Parameters.Add("@NetBillAmount", SqlDbType.VarChar).Value = lblNetAmount.Text;
                        cmd.ExecuteNonQuery();

                        tran.Commit();
                        success = true;
                    }
                    catch (Exception e1)
                    {
                        tran.Rollback();
                    }
                    finally
                    {
                        con.Close();
                    }
                }
                //else
				//{
				//    i++;
				//}
            }

            if (success == true)
            {
                //Response.Redirect("PendingFuelBillsApproval_Result.aspx?Billno=" + Billno);
                Response.Redirect("PendingFuelBillsApproval_Result.aspx?Type=Disapproved");
            }
        }
    }
}