using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Xml;
using System.Text;
using System.Net;
using System.Net.Sockets;

public partial class BillRegister : System.Web.UI.Page 
{
    static string strConnection = ConfigurationManager.AppSettings.Get("dbConnection");
    String strSQL = "";

    protected Int32 _currentPageNumber = 1;
    public byte byteRadButtonSelection;

    protected void Page_Load(object sender, EventArgs e)
    {             
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
     
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        if (!IsPostBack)
        {
            txtDateFrom.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;
        }
        else
        {
            lblErrPartyCode.Visible =false;
            lblErrBilledAt.Visible = false;
            lblErrSubmittedAt.Visible = false;
            lblErrCollectedAt.Visible = false;
        }
    }
    public void ToDate(object source, ServerValidateEventArgs value)
    {
        string[] strDtFrom = txtDateFrom.Text.Split('/');
        DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        string[] strDtTo = txtDateTo.Text.Split('/');
        DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));
        if (DateTime.Compare(dt1, dt2) > 0)
        {
            value.IsValid = false;
        }
        else
        {
            value.IsValid = true;
        }
    }

    public void daterange(object source, ServerValidateEventArgs value)
    {
        string[] strDtFrom = txtDateFrom.Text.Split('/');
        DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        string[] strDtTo = txtDateTo.Text.Split('/');
        DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));
        System.TimeSpan diffResult = dt2.Subtract(dt1);
        //if (diffResult.Days > 31)
        //{
        //    value.IsValid = false;
        //}
        //else
        //{
        //    value.IsValid = true;
        //}
    }
    protected void radDate_OnSelectedIndexChange(object sender, EventArgs e)
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
    }

    protected void btnXLS_Click(object sender, EventArgs e)
    {

    }

    protected void btnPrint_Click(object sender, EventArgs e)
    {

    }
    
    protected void btnShow_Click(object sender, EventArgs e)
    {
        //Generate Query String parameter for the page
        if (Page.IsValid == true)
        {
            string[] strArrDtFrom = txtDateFrom.Text.Split('/');
            string[] strArrDtTo = txtDateTo.Text.Split('/');

            string strQSBillDate = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy") + " - " + Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");
            string strQSBillingParty = txtPartyCode.Text;
            string strQSBillType = ddlBillType.Text;
            string strQSBilledAt = txtBilledAt.Text;
            string strQSSubmittedAt = txtSubmittedAt.Text;
            string strQSCollectedAt = txtCollectionAt.Text;
            string strQSStatus = ddlStatus.Text;
            string strQSOverDueDays = txtOverDueDays.Value;
            string strQSAmtGrThan = txtAmtGreaterThan.Value;
            string strQSBillNo = txtBillNo.Text;



            string strFinalQS = "?BillDate=" + strQSBillDate;
            strFinalQS = strFinalQS + "&BillingParty=" + strQSBillingParty;
            strFinalQS = strFinalQS + "&BillType=" + strQSBillType;
            strFinalQS = strFinalQS + "&BilledAt=" + strQSBilledAt;
            strFinalQS = strFinalQS + "&SubmittedAt=" + strQSSubmittedAt;
            strFinalQS = strFinalQS + "&CollectedAt=" + strQSCollectedAt;
            strFinalQS = strFinalQS + "&Status=" + strQSStatus;
            strFinalQS = strFinalQS + "&OverDueDays=" + strQSOverDueDays;
            strFinalQS = strFinalQS + "&AmtGrThan=" + strQSAmtGrThan;
            strFinalQS = strFinalQS + "&BillNo=" + strQSBillNo;

            Response.Redirect("BillRegister_ShowBillDetails.aspx" + strFinalQS);
            //try
            //{
            //    bool blnErrFlag = false;

            //    string[] strArrDtFrom = txtDateFrom.Text.Split('/');
            //    string[] strArrDtTo = txtDateTo.Text.Split('/');

            //    string strQSBillDate = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy") + " - " + Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");
            //    string strQSBillingParty = txtPartyCode.Text;
            //    string strQSBillType = ddlBillType.Text;
            //    string strQSBilledAt = txtBilledAt.Text;
            //    string strQSSubmittedAt = txtSubmittedAt.Text;
            //    string strQSCollectedAt = txtCollectionAt.Text;
            //    string strQSStatus = ddlStatus.Text;
            //    string strQSOverDueDays = txtOverDueDays.Value;
            //    string strQSAmtGrThan = txtAmtGreaterThan.Value;
            //    string strQSBillNo = txtBillNo.Text;

            //    if (strQSBillingParty != "" && HIDBillPartySelFromPopupWindow.Value.ToUpper() != strQSBillingParty.ToUpper())
            //    {
            //        //Check Billing Party
            //        SqlConnection sqlConn = new SqlConnection(strConnection);

            //        sqlConn.Open();

            //        strSQL = "SELECT DISTINCT CUSTCD, CUSTNM FROM webx_CUSTHDR WHERE CUSTCD IS NOT NULL ";

            //        strSQL = strSQL + " AND CUSTCD LIKE '" + strQSBillingParty.Replace("'", "''") + "%'";

            //        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
            //        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            //        DataSet ds = new DataSet();

            //        sqlDA.Fill(ds);

            //        if (ds.Tables[0].Rows.Count == 0)
            //        {
            //            lblErrPartyCode.Visible = true;
            //            blnErrFlag = true;
            //        }
            //    }

            //    if (!blnErrFlag)
            //    {
            //        if (strQSBilledAt != "")
            //        {
            //            //Check Billed At Location Code
            //            SqlConnection sqlConn = new SqlConnection(strConnection);

            //            sqlConn.Open();

            //            strSQL = "SELECT loccode, locname FROM webx_Location WHERE activeflag='Y' AND loccode like '%" + strQSBilledAt + "%'";

            //            SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
            //            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            //            DataSet ds = new DataSet();

            //            sqlDA.Fill(ds);

            //            if (ds.Tables[0].Rows.Count == 0)
            //            {
            //                lblErrBilledAt.Visible = true;
            //                blnErrFlag = true;
            //            }
            //        }
            //    }

            //    if (!blnErrFlag)
            //    {
            //        if (strQSSubmittedAt != "")
            //        {
            //            //Check Collected At Location Code
            //            SqlConnection sqlConn = new SqlConnection(strConnection);

            //            sqlConn.Open();

            //            strSQL = "SELECT loccode, locname FROM webx_Location WHERE activeflag='Y' AND loccode like '%" + strQSSubmittedAt + "%'";

            //            SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
            //            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            //            DataSet ds = new DataSet();

            //            sqlDA.Fill(ds);

            //            if (ds.Tables[0].Rows.Count == 0)
            //            {
            //                lblErrSubmittedAt.Visible = true;
            //                blnErrFlag = true;
            //            }
            //        }
            //    }

            //    if (!blnErrFlag)
            //    {
            //        if (strQSCollectedAt != "")
            //        {
            //            //Check Collected At Location Code
            //            SqlConnection sqlConn = new SqlConnection(strConnection);

            //            sqlConn.Open();

            //            strSQL = "SELECT loccode, locname FROM webx_Location WHERE activeflag='Y' AND loccode like '%" + strQSCollectedAt + "%'";

            //            SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
            //            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            //            DataSet ds = new DataSet();

            //            sqlDA.Fill(ds);

            //            if (ds.Tables[0].Rows.Count == 0)
            //            {
            //                lblErrCollectedAt.Visible = true;
            //                blnErrFlag = true;
            //            }
            //        }
            //    }

            //    if (!blnErrFlag)
            //    {
            //        string strFinalQS = "?BillDate=" + strQSBillDate;
            //        strFinalQS = strFinalQS + "&BillingParty=" + strQSBillingParty;
            //        strFinalQS = strFinalQS + "&BillType=" + strQSBillType;
            //        strFinalQS = strFinalQS + "&BilledAt=" + strQSBilledAt;
            //        strFinalQS = strFinalQS + "&SubmittedAt=" + strQSSubmittedAt;
            //        strFinalQS = strFinalQS + "&CollectedAt=" + strQSCollectedAt;
            //        strFinalQS = strFinalQS + "&Status=" + strQSStatus;
            //        strFinalQS = strFinalQS + "&OverDueDays=" + strQSOverDueDays;
            //        strFinalQS = strFinalQS + "&AmtGrThan=" + strQSAmtGrThan;
            //        strFinalQS = strFinalQS + "&BillNo=" + strQSBillNo;

            //        Response.Redirect("BillRegister_ShowBillDetails.aspx" + strFinalQS);
            //    }
            //}

            //catch (Exception Ex)
            //{

            //}
            //finally
            //{

            //}
        }
    }
}
