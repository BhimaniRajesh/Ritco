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
using CrystalDecisions.CrystalReports.Engine;

public partial class BillRegister_ShowBillDetails : System.Web.UI.Page
{
    public static string strDateRange;
    public static string strBillingParty;
    public static string strBillType;
    public static string strBilledAt;
    public static string strSubmittedAt;
    public static string strCollectedAt;
    public static string strStatus;
    public static string strOverDueDays;
    public static string strAmtGrThan;
    public static string strBillNo;

    public static int intPageSize = 10;
    DataSet dsPages = new DataSet();

    //static string strConnection = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=ASL_LIVE;";
    //static string strConnection = ConfigurationManager.AppSettings.Get("dbConnection");
    //SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

    public static int intCurrentPageNo;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (HIDCurrentPageNo.Value == "")
        {
            HIDCurrentPageNo.Value = "1";
        }

        intCurrentPageNo = Convert.ToInt32(HIDCurrentPageNo.Value);
        btnPrint.Attributes.Add("onclick", "Javascript:OpenInWindow('PrintBillRegister.aspx','400','700','0','0')");
        if (!IsPostBack)
        {
            //Date Range display preparation
            strDateRange = Request.QueryString["BillDate"].ToString();
            strBillingParty = Request.QueryString["BillingParty"].ToString();
            if (strBillingParty == "")
            {
                strBillingParty = "ALL";
            }
            strBillType = Request.QueryString["BillType"].ToString();
            if (strBillType == "-All-" || strBillType == "All")
            {
                strBillType = "ALL";
            }
            strBilledAt = Request.QueryString["BilledAt"].ToString();
            if (strBilledAt == "")
            {
                strBilledAt = "ALL";
            }
            strSubmittedAt = Request.QueryString["SubmittedAt"].ToString();
            if (strSubmittedAt == "")
            {
                strSubmittedAt = "ALL";
            }
            strCollectedAt = Request.QueryString["CollectedAt"].ToString();
            if (strCollectedAt == "")
            {
                strCollectedAt = "ALL";
            }
            strStatus = Request.QueryString["Status"].ToString();
            if (strStatus == "-All-" || strStatus == "All")
            {
                strStatus = "ALL";
            }

            strOverDueDays = Request.QueryString["OverDueDays"].ToString();
            strAmtGrThan = Request.QueryString["AmtGrThan"].ToString();
            strBillNo = Request.QueryString["BillNo"].ToString();
        }

        lblSelDateRange.Text = strDateRange;
        lblSelBillingParty.Text = strBillingParty;
        lblSelBillingType.Text = strBillType;
        lblSelBilledAt.Text = strBilledAt;
        lblSelSubmittedAt.Text = strSubmittedAt;
        lblSelCollectedAt.Text = strCollectedAt;
        lblSelStatus.Text = strStatus;
        lblSelOverDueDays.Text = strOverDueDays;
        lblSelAmtGrThan.Text = strAmtGrThan + ".00";

        displayBillDetails();
    }

    protected void NavigationLink_Click(Object sender, CommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "First":
                intCurrentPageNo = 1;
                break;
            case "Last":
                intCurrentPageNo = Int32.Parse(TotalPages.Text);
                break;
            case "Next":
                intCurrentPageNo = Int32.Parse(CurrentPage.Text) + 1;
                break;
            case "Prev":
                intCurrentPageNo = Int32.Parse(CurrentPage.Text) - 1;
                break;
        }

        HIDCurrentPageNo.Value = intCurrentPageNo.ToString();

        displayBillDetails();
    }

    private void displayBillDetails()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();

        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "webx_OUTSTANDING_DETAIL_New";

        //Input parameter for Billing Party
        sqlCommand.Parameters.AddWithValue("@CUSTCD", strBillingParty);

        //Managing Date Range for input parameters to SP
        string [] strArrDtFromTo = strDateRange.Split('-');

        sqlCommand.Parameters.AddWithValue("@DATEFROM", strArrDtFromTo[0]);
        sqlCommand.Parameters.AddWithValue("@DATETO", strArrDtFromTo[1]);

        //Input parameter for Bill Type
        sqlCommand.Parameters.AddWithValue("@BILLTYP", strBillType);

        //Input parameter for Status
        sqlCommand.Parameters.AddWithValue("@BILLSTATUS", strStatus);

        //Input parameter for Over Due Days
        sqlCommand.Parameters.AddWithValue("@OSDAYS", strOverDueDays);

        //Input parameter for Bill Amount
        sqlCommand.Parameters.AddWithValue("@BILLAMT", strOverDueDays);

        //Input parameter for Collection Branch Code
        sqlCommand.Parameters.AddWithValue("@COLBRCD", strCollectedAt);

        //Input parameter for Billing Branch Code
        sqlCommand.Parameters.AddWithValue("@BILLBRCD", strBilledAt);

        //Input parameter for Submission Branch Code
        sqlCommand.Parameters.AddWithValue("@SUBBRCD", strSubmittedAt);

        //Input parameter for Bill No., separated by comma, if multiple
        sqlCommand.Parameters.AddWithValue("@billist", strBillNo);
        
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();
        //DataSet dsPages = new DataSet();

        if (CurrentPage.Text == "")
        {
            CurrentPage.Text = "1";
            intCurrentPageNo = 1;
            HIDCurrentPageNo.Value = "1";
            FirstPage.Enabled = false;
            PreviousPage.Enabled = false;
        }
        else
        {
            CurrentPage.Text = intCurrentPageNo.ToString();
        }

        sqlDA.Fill(ds, ((intCurrentPageNo - 1) * intPageSize), intPageSize, "dtBillDetails");
        dsPages.Clear();
        sqlDA.Fill(dsPages);

        if (ds.Tables[0].Rows.Count == 0)
        {
            tblNoRecords.Visible = true;

            trForTotalValues.Visible = false;
            tblPageNavigation.Visible = false;
            tblButtons.Visible = false;
            lblComment.Visible = false;
        }
        else
        {
            double dblTotalRecords = dsPages.Tables[0].Rows.Count;
            double dblTotalPages = Convert.ToDouble(System.Math.Ceiling(Convert.ToDecimal(dblTotalRecords / intPageSize)));

            //Logic for Managing Page Navigation Links
            if (intCurrentPageNo == 1)
            {
                FirstPage.Enabled = false;
                PreviousPage.Enabled = false;
                NextPage.Enabled = true;
                LastPage.Enabled = true;
            }
            else if (intCurrentPageNo == dblTotalPages)
            {
                FirstPage.Enabled = true;
                PreviousPage.Enabled = true;
                NextPage.Enabled = false;
                LastPage.Enabled = false;
            }
            else
            {
                FirstPage.Enabled = true;
                PreviousPage.Enabled = true;
                NextPage.Enabled = true;
                LastPage.Enabled = true;
            }

            //Logic for populating Page No.'s in Drop Down List for Page
            ddlPages.Items.Clear();

            ListItem lItem;

            for(int i = 1; i<= dblTotalPages; i++)
            {
                lItem = new ListItem();

                lItem.Text = i.ToString();
                lItem.Value = lItem.Text;

                ddlPages.Items.Add(lItem);

                if (i == Convert.ToInt32(HIDCurrentPageNo.Value))
                {
                    ddlPages.SelectedIndex = ddlPages.Items.Count - 1;
                }

                lItem = null;
            }

            TotalPages.Text = dblTotalPages.ToString();

            DataTable dt = new DataTable();

            dt.Columns.Add("RowCounter", typeof(string));
            dt.Columns.Add("aHrefLink", typeof(string));
            dt.Columns.Add("BillNo", typeof(string));
            dt.Columns.Add("BillType", typeof(string));
            dt.Columns.Add("BillingParty", typeof(string));
            dt.Columns.Add("CollectionAt", typeof(string));
            dt.Columns.Add("SubmittedAt", typeof(string));
            dt.Columns.Add("BillDate", typeof(string));
            dt.Columns.Add("SubmissionDate", typeof(string));
            dt.Columns.Add("DueDate", typeof(string));
            dt.Columns.Add("OverDueDays", typeof(string));
            dt.Columns.Add("CollectionDate", typeof(string));
            dt.Columns.Add("BillCancellationDate", typeof(string));
            dt.Columns.Add("BillCancelledBy", typeof(string));
            dt.Columns.Add("ServiceTaxPlusCess", typeof(string));
            dt.Columns.Add("CessAmt", typeof(string));
            dt.Columns.Add("BillSubTot", typeof(string));
            dt.Columns.Add("MRDetails", typeof(string));
            dt.Columns.Add("Amount", typeof(string));
            dt.Columns.Add("CollectionAmount", typeof(string));
            dt.Columns.Add("PendingAmount", typeof(string));
            dt.Columns.Add("Deduction", typeof(string));
            dt.Columns.Add("Claim", typeof(string));
            dt.Columns.Add("TDS", typeof(string));
            dt.Columns.Add("UnadjustedAmount", typeof(string));
            dt.Columns.Add("BillGenBy", typeof(string));
            dt.Columns.Add("BillSubBy", typeof(string));

            DataRow dr;

            string strHrefLink = "";
            string BLCDT = "";
            string strOSDAYSDesc = "";
            
            TimeSpan ts;
            
            int intOSDAYS1 = 0;
            int intBillType = 0;

            int loopCounter = ((intCurrentPageNo - 1) * intPageSize) + 1;

            //Total variables declaration
            double dblTotalPendingAmount = 0;
            double dblTotalFrtDed = 0;
            double dblTotalTDSAmt = 0;
            double dblTotalUnadjustedAmt = 0;
            double dblTotalClaimedAmt = 0;
            double dblTotalBillAmtRcvd = 0;
            double dblTotalBillAmtCollected = 0;
            double dblSvcTax = 0;
            double dblCess = 0;
            double dblBillSubTot = 0;

            foreach (DataRow drRows in ds.Tables[0].Rows)
            {
                dr = dt.NewRow();

                dr["RowCounter"] = loopCounter++;
                //Logic for Link on Bill No. column
                intBillType = Convert.ToInt32(drRows["PAYBAS"]);

                if (intBillType == 6)
                {
                    strHrefLink = "javascript:OpenPopup('" + drRows["BILLNO"].ToString() + "',0)";                 
                }
                else
                {
                    strHrefLink = "javascript:OpenPopup('" + drRows["BILLNO"].ToString() + "',0)";
                }

                dr["aHrefLink"] = strHrefLink;
                dr["BillNo"] = drRows["BILLNO"].ToString();
                dr["BillType"] = GetBillType(Convert.ToInt32(drRows["PAYBAS"]));
                dr["BillingParty"] = drRows["PTMSCD"].ToString() + " : " + drRows["PTMSNM"].ToString();
                dr["CollectionAt"] = drRows["BILLCOLBRCD"].ToString();
                dr["SubmittedAt"] = drRows["BILLSUBBRCD"].ToString();
                
                if (drRows["BGNDT"] is DBNull)
                {
                    dr["BillDate"] = "-";
                }
                else
                {
                    dr["BillDate"] = Convert.ToDateTime(drRows["BGNDT"]).ToString("dd MMM yyyy");
                }

                if (drRows["BSBDT"] is DBNull)
                {
                    dr["SubmissionDate"] = "-";
                }
                else
                {
                    dr["SubmissionDate"] = Convert.ToDateTime(drRows["BSBDT"]).ToString("dd MMM yyyy");
                }

                if (drRows["BDUEDT"] is DBNull)
                {
                    dr["DueDate"] = "-";
                }
                else
                {
                    dr["DueDate"] = Convert.ToDateTime(drRows["BDUEDT"]).ToString("dd MMM yyyy");
                }

                BLCDT = drRows["BCLDT"].ToString();
                if (BLCDT == "-")
                {
                    ts = Convert.ToDateTime(drRows["BDUEDT"]) - DateTime.Today.Date;
                    intOSDAYS1 = ts.Days;

                    if (intOSDAYS1 < 0)
                    {
                        intOSDAYS1 = 0;
                        strOSDAYSDesc = "-";
                    }
                    else
                    {
                        strOSDAYSDesc = intOSDAYS1.ToString();
                    }
                }
                else
                {
                    intOSDAYS1 = 0;
                    strOSDAYSDesc = "-";
                }

                dr["OverDueDays"] = strOSDAYSDesc;

                if (drRows["BCLDT"] is DBNull)
                {
                    dr["CollectionDate"] = "-";
                }
                else
                {
                    dr["CollectionDate"] = Convert.ToDateTime(drRows["BCLDT"]).ToString("dd MMM yyyy");
                }

                if (drRows["BCANDT"] is DBNull)
                {
                    dr["BillCancellationDate"] = "-";
                }
                else
                {
                    dr["BillCancellationDate"] = Convert.ToDateTime(drRows["BCANDT"]).ToString("dd MMM yyyy");
                }

                if (drRows["BCANEMPCD"] is DBNull)
                {
                    dr["BillCancelledBy"] = "-";
                }
                else
                {
                    dr["BillCancelledBy"] = drRows["BCANEMPCD"].ToString();
                }

                if (drRows["svrcamt"] is DBNull)
                {
                    dr["ServiceTaxPlusCess"] = "0.00";
                }
                else
                {
                    dr["ServiceTaxPlusCess"] = Convert.ToDouble(drRows["svrcamt"]).ToString("0.00");
                    dblSvcTax += Convert.ToDouble(drRows["svrcamt"]);
                }
                if (drRows["cessamt"] is DBNull)
                {
                    dr["CessAmt"] = "0.00";
                }
                else
                {
                    dr["CessAmt"] = Convert.ToDouble(drRows["cessamt"]).ToString("0.00");
                    dblCess += Convert.ToDouble(drRows["cessamt"]);
                }
                if (drRows["billsubtotal"] is DBNull)
                {
                    dr["BillSubTot"] = "0.00";
                }
                else
                {
                    dr["BillSubTot"] = Convert.ToDouble(drRows["billsubtotal"]).ToString("0.00");
                    dblBillSubTot += Convert.ToDouble(drRows["billsubtotal"]);
                }

                if (drRows["MRDetails"] is DBNull)
                {
                    dr["MRDetails"] = "-";
                }
                else
                {
                    dr["MRDetails"] = drRows["MRDetails"].ToString();
                }

                if (drRows["BILLAMT"] is DBNull)
                {
                    dr["Amount"] = "0.00";
                }
                else
                {
                    dr["Amount"] = Convert.ToDouble(drRows["BILLAMT"]).ToString("0.00");
                    dblTotalBillAmtRcvd += Convert.ToDouble(drRows["BILLAMT"]);
                }

                if (drRows["CLAMT"] is DBNull)
                {
                    dr["CollectionAmount"] = "0.00";
                }
                else
                {
                    dr["CollectionAmount"] = Convert.ToDouble(drRows["CLAMT"]).ToString("0.00");
                    dblTotalBillAmtCollected += Convert.ToDouble(drRows["CLAMT"]);
                }

                if (drRows["PENDAMT"] is DBNull)
                {
                    dr["PendingAmount"] = "0.00";
                }
                else
                {
                    dr["PendingAmount"] = Convert.ToDouble(drRows["PENDAMT"]).ToString("0.00");
                    dblTotalPendingAmount += Convert.ToDouble(drRows["PENDAMT"]);
                }

                if (drRows["frtDED"] is DBNull)
                {
                    dr["Deduction"] = "0.00";
                }
                else
                {
                    dr["Deduction"] = Convert.ToDouble(drRows["frtDED"]).ToString("0.00");
                    dblTotalFrtDed += Convert.ToDouble(drRows["frtDED"]);
                }

                if (drRows["CLMDED_AMT"] is DBNull)
                {
                    dr["Claim"] = "0.00";
                }
                else
                {
                    dr["Claim"] = Convert.ToDouble(drRows["CLMDED_AMT"]).ToString("0.00");
                    dblTotalClaimedAmt += Convert.ToDouble(drRows["CLMDED_AMT"]);
                }

                if (drRows["TDS_AMT"] is DBNull)
                {
                    dr["TDS"] = "0.00";
                }
                else
                {
                    dr["TDS"] = Convert.ToDouble(drRows["TDS_AMT"]).ToString("0.00");
                    dblTotalTDSAmt += Convert.ToDouble(drRows["TDS_AMT"]);
                }

                if (drRows["UNEXPDED_AMT"] is DBNull)
                {
                    dr["UnadjustedAmount"] = "0.00";
                }
                else
                {
                    dr["UnadjustedAmount"] = Convert.ToDouble(drRows["UNEXPDED_AMT"]).ToString("0.00");
                    dblTotalUnadjustedAmt += Convert.ToDouble(drRows["UNEXPDED_AMT"]);
                }
                string strQuery = "select bsubempcd + ' : ' + em.Name as BillGenNo from webx_billmst bm,webx_master_users em where bm.bsubempcd=em.userid and billno = '" + dr["BillNo"].ToString() + "'";
                SqlCommand cmd = new SqlCommand(strQuery, sqlConn);
                SqlDataReader drBill = cmd.ExecuteReader();
                while (drBill.Read())
                {
                    dr["BillGenBy"] = Convert.ToString(drBill["BillGenNo"]);
                    dr["BillSubBy"] = Convert.ToString(drBill["BillGenNo"]);
                }
                drBill.Close();

                dt.Rows.Add(dr);
            }

            rptBillDetails.DataSource = dt;
            rptBillDetails.DataBind();

            lblSvcTax.Text = dblSvcTax.ToString("0.00");
            lblCess.Text = dblCess.ToString("0.00");
            lblBillSubTot.Text = dblBillSubTot.ToString("0.00");
            lblTotalBillAmtRcvd.Text = dblTotalBillAmtRcvd.ToString("0.00");
            lblTotalBillAmtCollected.Text = dblTotalBillAmtCollected.ToString("0.00");
            lblTotalPendingAmt.Text = dblTotalPendingAmount.ToString("0.00");
            lblTotalFreightAmt.Text = dblTotalFrtDed.ToString("0.00");
            lblTotalAmtClaimed.Text = dblTotalClaimedAmt.ToString("0.00");
            lblTotalTDSAmt.Text = dblTotalTDSAmt.ToString("0.00");
            lblTotalUnadjAmt.Text = dblTotalUnadjustedAmt.ToString("0.00");
        }
    }

    private string GetBillType(int intBillTypeValue)
    {
        string strBillType = "";
        switch (intBillTypeValue)
        {
            case 1:
                strBillType = "Paid";
                break;
            case 2:
                strBillType = "TBB";
                break;
            case 3:
                strBillType = "To Pay";
                break;
            case 4:
                strBillType = "Misc.";
                break;
            case 5:
                strBillType = "Cancelled";
                break;
            case 6:
                strBillType = "Octroi";
                break;
            case 7:
                strBillType = "Supplimentry";
                break;
            case 8:
                strBillType = "Trial TBB";
                break;
        }

        return strBillType;
    }

    protected void btnPrint_OnClick(object sender, EventArgs e)
    {
        //ReportDocument rdocBillDetails = new ReportDocument();

        //rdocBillDetails.Load(Server.MapPath("BillRegister.rpt"));
        //rdocBillDetails.SetDataSource(dsPages.Tables[0]);

        //crvBillDetails.ReportSource = rdocBillDetails;
        //crvBillDetails.DataBind();
    }
}
