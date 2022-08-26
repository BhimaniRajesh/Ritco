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

public partial class MRreg_show : System.Web.UI.Page
{

    public static string strDateRange;
    public static string strro;
    public static string strloc;
    public static string strmrparty;
    public static string strmrtype;
    public static string strstatus;
    public static string strcash;
    public static string strAmtGrThan;

     
    protected void Page_Load(object sender, EventArgs e)
    {

        hypWelcome.NavigateUrl = "../../welcome.asp"; //Use an appropriate path

        hypReport.Text = "Reports";
        hypReport.NavigateUrl = "../reportmenu.asp"; //Use an appropriate path

        hypFinance.Text = "Finance";
        hypFinance.NavigateUrl = "../rpt_finance.asp"; //Use an appropriate path

        if (!IsPostBack)
        {
            //Date Range display preparation
            strDateRange = Request.QueryString["MRDate"].ToString();
            strro = Request.QueryString["RO"].ToString();
            if (strro == "")
            {
                strro = "ALL";
            }
            strloc = Request.QueryString["Location"].ToString();
            if (strloc == "-All-")
            {
                strloc = "ALL";
            }
            strmrparty = Request.QueryString["MRParty"].ToString();
            if (strmrparty == "")
            {
                strmrparty = "ALL";
            }
            strmrtype = Request.QueryString["MRType"].ToString();
            if (strmrtype == "")
            {
                strmrtype = "ALL";
            }
           
            strstatus = Request.QueryString["Status"].ToString();
            if (strstatus == "-All-")
            {
                strstatus = "ALL";
            }



            strcash = Request.QueryString["cash"].ToString();
            if (strcash == "0")
            {
                strcash = "ALL";
            }

            strAmtGrThan = Request.QueryString["AmtGrThan"].ToString();
            if (strAmtGrThan == "0")
            {
                strAmtGrThan = "ALL";
            }
            

        }


        
        lblro.Text = strro;
        lblloc.Text = strloc;
        lblmrparty.Text = strmrparty;
        lblmrtype.Text = strmrtype;
        lblstatus.Text = strstatus;
        lblcash.Text = strcash;
        lblamtgrt.Text = strAmtGrThan + ".00";

        
    }

    private void DisplayMrDetails()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();

        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "webx_MR_DETAIL_new";

        //Input parameter for Billing Party
       // sqlCommand.Parameters.AddWithValue("@CUSTCD", strBillingParty);

        //Managing Date Range for input parameters to SP
        string[] strArrDtFromTo = strDateRange.Split('-');

        sqlCommand.Parameters.AddWithValue("@DATEFROM", strArrDtFromTo[0]);
        sqlCommand.Parameters.AddWithValue("@DATETO", strArrDtFromTo[1]);

        //Input parameter for MR Type
        sqlCommand.Parameters.AddWithValue("@MRTYP", strmrtype);

        //Input parameter for MR Party
        sqlCommand.Parameters.AddWithValue("@CUSTCD", strmrparty);

        //Input parameter Status
        sqlCommand.Parameters.AddWithValue("@MRSTATUS", strstatus);

        //Input parameter for Bill Amount
        sqlCommand.Parameters.AddWithValue("@MRAMT", strAmtGrThan);

        //Input parameter for Collection RO
        sqlCommand.Parameters.AddWithValue("@RO", strro);

        //Input parameter for Collection Location
        sqlCommand.Parameters.AddWithValue("@MRBRCD", strloc);

        
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();
        try
        {

            sqlDA.Fill(ds);



        }
        catch (Exception e)
        {
            lblcash.Text = e.Message;
        }


        GridView1.DataSource = ds;
        GridView1.DataBind();

        
    //    DataTable dt = new DataTable();


    //    dt.Columns.Add("RowCounter", typeof(string));
    //    dt.Columns.Add("aHrefLink", typeof(string));
    //    dt.Columns.Add("BillNo", typeof(string));
    //    dt.Columns.Add("BillType", typeof(string));
    //    dt.Columns.Add("BillingParty", typeof(string));
    //    dt.Columns.Add("CollectionAt", typeof(string));
    //    dt.Columns.Add("SubmittedAt", typeof(string));
    //    dt.Columns.Add("BillDate", typeof(string));
    //    dt.Columns.Add("SubmissionDate", typeof(string));
    //    dt.Columns.Add("DueDate", typeof(string));
    //    dt.Columns.Add("OverDueDays", typeof(string));
    //    dt.Columns.Add("CollectionDate", typeof(string));
    //    dt.Columns.Add("BillCancellationDate", typeof(string));
    //    dt.Columns.Add("BillCancelledBy", typeof(string));
    //    dt.Columns.Add("ServiceTaxPlusCess", typeof(string));
    //    dt.Columns.Add("MRDetails", typeof(string));
    //    dt.Columns.Add("Amount", typeof(string));
    //    dt.Columns.Add("CollectionAmount", typeof(string));
    //    dt.Columns.Add("PendingAmount", typeof(string));
    //    dt.Columns.Add("Deduction", typeof(string));
    //    dt.Columns.Add("Claim", typeof(string));
    //    dt.Columns.Add("TDS", typeof(string));
    //    dt.Columns.Add("UnadjustedAmount", typeof(string));

    //    DataRow dr;
    //    try
    //    {
    //        int TotalRecords = ds.Tables[0].Rows.Count;
    //    }
    //    catch (Exception e)
    //    {
    //        lblSelBilledAt.Text = e.Message;
    //    }

    //    int loopCounter = 1;
    //    string strHrefLink = "";
    //    string BLCDT = "";
    //    TimeSpan ts;
    //    int intOSDAYS1 = 0;
    //    string strOSDAYSDesc = "";

    //    //Total variables declaration
    //    double dblTotalPendingAmount = 0;
    //    double dblTotalFrtDed = 0;
    //    double dblTotalTDSAmt = 0;
    //    double dblTotalUnadjustedAmt = 0;
    //    double dblTotalClaimedAmt = 0;
    //    double dblTotalBillAmtRcvd = 0;
    //    double dblTotalBillAmtCollected = 0;

    //    foreach (DataRow drRows in ds.Tables[0].Rows)
    //    {
    //        dr = dt.NewRow();

    //        dr["RowCounter"] = loopCounter++;
    //        dr["aHrefLink"] = strHrefLink;
    //        dr["BillNo"] = drRows["BILLNO"].ToString();
    //        dr["BillType"] = GetBillType(Convert.ToInt32(drRows["PAYBAS"]));
    //        dr["BillingParty"] = drRows["PTMSCD"].ToString() + " : " + drRows["PTMSNM"].ToString();
    //        dr["CollectionAt"] = drRows["BILLCOLBRCD"].ToString();
    //        dr["SubmittedAt"] = drRows["BILLSUBBRCD"].ToString();
    //        dr["BillDate"] = Convert.ToDateTime(drRows["BGNDT"]).ToString("dd/MM/yyyy");
    //        dr["SubmissionDate"] = Convert.ToDateTime(drRows["BSBDT"]).ToString("dd/MM/yyyy");
    //        dr["DueDate"] = Convert.ToDateTime(drRows["BDUEDT"]).ToString("dd/MM/yyyy");

    //        BLCDT = drRows["BCLDT"].ToString();
    //        if (BLCDT == "-")
    //        {
    //            ts = Convert.ToDateTime(drRows["BDUEDT"]) - DateTime.Today.Date;
    //            intOSDAYS1 = ts.Days;

    //            if (intOSDAYS1 < 0)
    //            {
    //                intOSDAYS1 = 0;
    //                strOSDAYSDesc = "-";
    //            }
    //            else
    //            {
    //                strOSDAYSDesc = intOSDAYS1.ToString();
    //            }
    //        }
    //        else
    //        {
    //            intOSDAYS1 = 0;
    //            strOSDAYSDesc = "-";
    //        }

    //        dr["OverDueDays"] = strOSDAYSDesc;
    //        dr["CollectionDate"] = Convert.ToDateTime(drRows["BCLDT"]).ToString("dd/MM/yyyy");
    //        if (drRows["BCANDT"].ToString() != "")
    //        {
    //            dr["BillCancellationDate"] = Convert.ToDateTime(drRows["BCANDT"]).ToString("dd/MM/yyyy");
    //        }
    //        else
    //        {
    //            dr["BillCancellationDate"] = drRows["BCANDT"].ToString();
    //        }

    //        dr["BillCancelledBy"] = drRows["BCANEMPCD"].ToString();

    //        if (drRows["svrcamt"] is DBNull)
    //        // if (drRows.IsNull["svrcamt"] = true)
    //        {
    //            dr["ServiceTaxPlusCess"] = "0.00";
    //        }
    //        else
    //        {
    //            dr["ServiceTaxPlusCess"] = Convert.ToDouble(drRows["svrcamt"]).ToString("0.00");
    //        }

    //        dr["MRDetails"] = drRows["MRDetails"].ToString();

    //        if (drRows["BILLAMT"] is DBNull)
    //        {
    //            dr["Amount"] = "0.00";
    //        }
    //        else
    //        {
    //            dr["Amount"] = Convert.ToDouble(drRows["BILLAMT"]).ToString("0.00");
    //            dblTotalBillAmtRcvd += Convert.ToDouble(drRows["BILLAMT"]);
    //        }

    //        if (drRows["CLAMT"] is DBNull)
    //        {
    //            dr["CollectionAmount"] = "0.00";
    //        }
    //        else
    //        {
    //            dr["CollectionAmount"] = Convert.ToDouble(drRows["CLAMT"]).ToString("0.00");
    //            dblTotalBillAmtCollected += Convert.ToDouble(drRows["CLAMT"]);
    //        }

    //        if (drRows["PENDAMT"] is DBNull)
    //        {
    //            dr["PendingAmount"] = "0.00";
    //        }
    //        else
    //        {
    //            dr["PendingAmount"] = Convert.ToDouble(drRows["PENDAMT"]).ToString("0.00");
    //            dblTotalPendingAmount += Convert.ToDouble(drRows["PENDAMT"]);
    //        }

    //        if (drRows["frtDED"] is DBNull)
    //        {
    //            dr["Deduction"] = "0.00";
    //        }
    //        else
    //        {
    //            dr["Deduction"] = Convert.ToDouble(drRows["frtDED"]).ToString("0.00");
    //            dblTotalFrtDed += Convert.ToDouble(drRows["frtDED"]);
    //        }

    //        if (drRows["CLMDED_AMT"] is DBNull)
    //        {
    //            dr["Claim"] = "0.00";
    //        }
    //        else
    //        {
    //            dr["Claim"] = Convert.ToDouble(drRows["CLMDED_AMT"]).ToString("0.00");
    //            dblTotalClaimedAmt += Convert.ToDouble(drRows["CLMDED_AMT"]);
    //        }

    //        if (drRows["TDS_AMT"] is DBNull)
    //        {
    //            dr["TDS"] = "0.00";
    //        }
    //        else
    //        {
    //            dr["TDS"] = Convert.ToDouble(drRows["TDS_AMT"]).ToString("0.00");
    //            dblTotalTDSAmt += Convert.ToDouble(drRows["TDS_AMT"]);
    //        }

    //        if (drRows["UNEXPDED_AMT"] is DBNull)
    //        {
    //            dr["UnadjustedAmount"] = "0.00";
    //        }
    //        else
    //        {
    //            dr["UnadjustedAmount"] = Convert.ToDouble(drRows["UNEXPDED_AMT"]).ToString("0.00");
    //            dblTotalUnadjustedAmt += Convert.ToDouble(drRows["UNEXPDED_AMT"]);
    //        }

    //        dt.Rows.Add(dr);
    //    }

    //    rptBillDetails.DataSource = dt;
    //    rptBillDetails.DataBind();

    //    lblTotalBillAmtRcvd.Text = dblTotalBillAmtRcvd.ToString("0.00");
    //    lblTotalBillAmtCollected.Text = dblTotalBillAmtCollected.ToString("0.00");
    //    lblTotalPendingAmt.Text = dblTotalPendingAmount.ToString("0.00");
    //    lblTotalFreightAmt.Text = dblTotalFrtDed.ToString("0.00");
    //    lblTotalAmtClaimed.Text = dblTotalClaimedAmt.ToString("0.00");
    //    lblTotalTDSAmt.Text = dblTotalTDSAmt.ToString("0.00");
    //    lblTotalUnadjAmt.Text = dblTotalUnadjustedAmt.ToString("0.00");
    //}

    //private string GetBillType(int intBillTypeValue)
    //{
    //    string strBillType = "";
    //    switch (intBillTypeValue)
    //    {
    //        case 1:
    //            strBillType = "Paid";
    //            break;
    //        case 2:
    //            strBillType = "TBB";
    //            break;
    //        case 3:
    //            strBillType = "To Pay";
    //            break;
    //        case 4:
    //            strBillType = "Misc.";
    //            break;
    //        case 5:
    //            strBillType = "Cancelled";
    //            break;
    //        case 6:
    //            strBillType = "Octroi";
    //            break;
    //        case 7:
    //            strBillType = "Supplimentry";
    //            break;
    //        case 8:
    //            strBillType = "Trial TBB";
    //            break;
    //    }

    //    return strBillType;

    }
}
