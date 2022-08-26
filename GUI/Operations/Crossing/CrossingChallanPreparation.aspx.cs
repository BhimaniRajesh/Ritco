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

public partial class GUI_Operations_Crossing_CrossingChallanPreparation : System.Web.UI.Page
{
    SqlConnection conn;
    string sqlDocket = "", sql_Account = "", Financial_Year = "", VoucherNo = "", DateFrom, DateTO, DateType, Origin, Destination, Dockno, DeliveryMethod, Vendor;
    DateTime f = new DateTime();
    DateTime t = new DateTime();
    MyFunctions fn = new MyFunctions();
    public int intTotalRecords;
    protected void Page_Load(object sender, EventArgs e)
    {
        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        DateFrom = Convert.ToString(Request.QueryString["DateFrom"]);
        DateTO = Convert.ToString(Request.QueryString["DateTO"]);
        DateType = Convert.ToString(Request.QueryString["DateType"]);
        Origin = Convert.ToString(Request.QueryString["Origin"]);
        Destination = Convert.ToString(Request.QueryString["Destination"]);
        Dockno = Convert.ToString(Request.QueryString["Dockno"]);
        DeliveryMethod = Convert.ToString(Request.QueryString["DeliveryMethod"]);
        Vendor = Convert.ToString(Request.QueryString["Vendor"]);
        hdnVendorCode.Value = Vendor.ToString();

        if (!IsPostBack)
        {   
            lblChallanLocation.Text = Session["BRCD"].ToString();
            lblVendor.Text = fn.GetVendor(Vendor);
            txtVoucherDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");

            if (DateFrom != "")
            {
                f = Convert.ToDateTime(fn.Mydate1(DateFrom));
                t = Convert.ToDateTime(fn.Mydate1(DateTO));
            }
            else
            {
                f = System.DateTime.Now;
                t = System.DateTime.Now;
            }
            DocketList();
        }
    }

    private void DocketList()
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        //sqlDocket = "exec usp_dockets_for_Crossing_generation '" + Dockno + "','" + f + "','" + t + "','" + Session["BRCD"].ToString() + "','" + Destination + "','1'";
        sqlDocket = "exec usp_dockets_for_Crossing_generation '" + Dockno + "','" + f + "','" + t + "','" + Session["BRCD"].ToString() + "','" + Destination + "','1','" + hdnVendorCode.Value + "'";
        SqlCommand cmd = new SqlCommand(sqlDocket, conn);
         cmd.CommandTimeout = 1800;
	SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);

        DataSet ds = new DataSet();
        sqlDA.Fill(ds);
        intTotalRecords = ds.Tables[0].Rows.Count;
        DocketDetail.DataSource = ds;
        DocketDetail.DataBind();
        conn.Close();
    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        btnsubmit.Visible = false;
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlTransaction trn = conn.BeginTransaction();
        string NewCrossingCode = "";
        Crossing cr = new Crossing();
        try
        {
            string FinanacialYear = Session["YearVal"].ToString();
            FinanacialYear = FinanacialYear.Replace("_", "");

            cr.CrossingChallanNo = NewCrossingCode;
            //cr.ChallanDate = DateTime.Now;
            cr.ChallanDate = Convert.ToDateTime(fn.Mydate1(txtVoucherDate.Text));
            cr.ChallanLocCode = Convert.ToString(Session["BRCD"]);
            cr.VehicleNo = txtVehicleEntry.Text;
            cr.VendorCode = Vendor;
            cr.VendorName = lblVendor.Text;
            cr.TotalToPay =Math.Round(Convert.ToDouble(txtTotalToPay.Text),MidpointRounding.AwayFromZero);
            cr.TotalCrossing = Math.Round(Convert.ToDouble(txtTotalCrossing.Text),MidpointRounding.AwayFromZero);
            cr.TotalDoorDelyChrg = Math.Round(Convert.ToDouble(txtTotDDCharge.Text),MidpointRounding.AwayFromZero);
            cr.TotalBulkyCharge = Math.Round(Convert.ToDouble(txtTotBulkyCharge.Text),MidpointRounding.AwayFromZero);
            cr.TotalTruckFreight = Math.Round(Convert.ToDouble(txtTruckFreight.Text),MidpointRounding.AwayFromZero);
            cr.TotalAdvanceFreight = Math.Round(Convert.ToDouble(txtAdvanceTruckFreight.Text),MidpointRounding.AwayFromZero);
            cr.TotalBalance = Math.Round(Convert.ToDouble(txtBalanceFreight.Text),MidpointRounding.AwayFromZero);
            cr.NetPayable = Math.Round(Convert.ToDouble(txtNetPayable.Text),MidpointRounding.AwayFromZero);
            cr.Cancel = "N";
            cr.PaymentFlag = "N";

            NewCrossingCode = CrossingController.CrossingMasterEntry(cr, trn, FinanacialYear);

            bool IsRecordCount = false;
            foreach (GridViewRow gridrow in DocketDetail.Rows)
            {
                CheckBox chkBill = (CheckBox)gridrow.FindControl("chkBill");
                Label lbldockno = (Label)gridrow.FindControl("lbldockno");
                Label lbldockdt = (Label)gridrow.FindControl("lbldockdt");
                HiddenField hdnPaybas = (HiddenField)gridrow.FindControl("hdnPaybas");
                Label lblPaybas = (Label)gridrow.FindControl("lblPaybas");
                Label lblOrigin = (Label)gridrow.FindControl("lblOrigin");
                Label lblDestn = (Label)gridrow.FindControl("lblDestn");
                Label lblPkgs = (Label)gridrow.FindControl("lblPkgs");
                TextBox lblVendorRate = (TextBox)gridrow.FindControl("lblVendorRate");
                Label lblActualWt = (Label)gridrow.FindControl("lblActualWt");
                TextBox txtDocketAmt = (TextBox)gridrow.FindControl("txtDocketAmt");
                DropDownList cboRateBase = (DropDownList)gridrow.FindControl("cboRateBase");
                TextBox txtCrossCharge = (TextBox)gridrow.FindControl("txtCrossCharge");
                TextBox txtDDCharge = (TextBox)gridrow.FindControl("txtDDCharge");
                TextBox txtBulkyCharge = (TextBox)gridrow.FindControl("txtBulkyCharge");

                if (chkBill.Checked)
                {
                    IsRecordCount = true;
                    cr.DockNo = lbldockno.Text;
                    cr.DockDate = Convert.ToDateTime(lbldockdt.Text);
                    cr.Paybas = hdnPaybas.Value;
                    cr.Origin = lblOrigin.Text;
                    cr.Destination = lblDestn.Text;
                    cr.Pkgs = Convert.ToDouble(lblPkgs.Text);
                    cr.ActuWeight = Convert.ToDouble(lblActualWt.Text);
                    cr.DKTTOT = Convert.ToDouble(txtDocketAmt.Text);
                    cr.Ratetype = cboRateBase.SelectedItem.ToString();
                    cr.VendorRate = Convert.ToDouble(lblVendorRate.Text);
                    cr.CrossingChrg = Convert.ToDouble(txtCrossCharge.Text);
                    cr.DoorDelyChrg = Convert.ToDouble(txtDDCharge.Text);
                    cr.BulkyCharge = Convert.ToDouble(txtBulkyCharge.Text);
                    cr.EntryBY = Convert.ToString(Session["empcd"]);
                    cr.EntryDate = DateTime.Now;
                    cr.Cancel = "N";
                    cr.CrossingChallanNo = NewCrossingCode;
                    
                    CrossingController.CrossingDetailEntry(cr, trn);
                }
            }

            Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
            string Vbrcd = Session["brcd"].ToString();
            VoucherNo = fn.NextVoucherno(Vbrcd, Financial_Year);

            sql_Account = "exec USP_CROSSINGTRANSACTION_CHALLANWISE  1,'" + NewCrossingCode + "','" + Financial_Year + "','" + VoucherNo + "'";
            SqlCommand cmdAccount = new SqlCommand(sql_Account, conn, trn);
            cmdAccount.ExecuteNonQuery();

            if (IsRecordCount)
                trn.Commit();
                //trn.Rollback();
            else
                trn.Rollback();

        }
        catch (Exception e1)
        {
            trn.Rollback();
            throw e1;
        }
        conn.Close();
        string final = "";
        final = "CrossingChallanNo=" + NewCrossingCode;
        Response.Redirect("CrossingChallanDone.aspx?" + final);
    }
}
