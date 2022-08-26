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

public partial class GUI_Operations_FM_ViewFMMemoDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string strFMDocType;
            string strFMID;
            string strFMNo;

            strFMID = HttpUtility.UrlDecode(Request.QueryString["FMID"].ToString());
            strFMNo = HttpUtility.UrlDecode(Request.QueryString["FMNo"].ToString());
            strFMDocType = HttpUtility.UrlDecode(Request.QueryString["FMDocType"].ToString());

            HidFMID.Value = strFMID;
            HidFMNo.Value = strFMNo;
            
            Get_FM_FWD_Doc_Master_Data();

            if (strFMDocType != "2")
            {
                paintDocketListing();
            }
            else
            {
                paintBillListing();
            }
        }
    }

    private void paintDocketListing()
    {
        string strSQL = "select ROW_NUMBER()over(order by ID) SrNo, DocketNo=DockNo," +
                    "DocketDate=(Case When (DockDt is null) Then '-' Else Convert(varchar,DockDt,106) END)," +
                    "DocumentNo, DocumentDate= (Case When (DocumentNo='N/A') Then '-' Else ( Case When DocumentDate is NULL Then '-' Else Convert(varchar,DocumentDate,106) END) END)," +
                    "Amount, OrgnDest=Orgn_Dest,FromToLoc=From_To,DelyDate=(Case When Dely_Date is null Then '-' Else Convert(varchar,Dely_Date,106) END)," +
                    "ID FROM webx_fm_fwd_doc_detail WHERE HDR_ID = " + HidFMID.Value;

        DataSet dsDocketList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strSQL); 
        
        trDocketList.Visible = true;
        trTableHeadersForDocket.Visible = true;

        trBillList.Visible = false;
        rptBillList.Visible = false;

        string strAckFMDocIDs = "";

        if (dsDocketList.Tables[0].Rows.Count > 0)
        {
            rptDocketList.Visible = true;
            trForwardDocument.Visible = true;
            
            foreach (DataRow drRows in dsDocketList.Tables[0].Rows)
            {
                strAckFMDocIDs = (strAckFMDocIDs == "" ? drRows["ID"].ToString() : strAckFMDocIDs + "," + drRows["ID"].ToString());
            }

            rptDocketList.DataSource = dsDocketList.Tables[0];
            rptDocketList.DataBind();

            HidAckFMDocIDs.Value = strAckFMDocIDs;
        }
    }

    private void paintBillListing()
    {
        string strSQL = "Select ROW_NUMBER()over(order by ID) SrNo, ID," +
                        "BillNo=Bill_no," +
                        "ManualBillNo=(Case When isNull(Manual_Bill_No,'-')='' Then '-' Else Manual_Bill_No End)," +
                        "BillDate=(Case When isNull(Bill_Date,'-')='' Then '-' Else Convert(varchar,Bill_Date) End)," +
                        "BillingParty=Billing_Party," +
                        "BillAmount=Bill_Amount," +
                        "SubmissionLocation=Submission_Location" +
                        "FROM webx_fm_fwd_doc_detail WHERE HDR_ID = " + HidFMID.Value;


        DataSet dsBillList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strSQL);
       
        trDocketList.Visible = true;
        rptDocketList.Visible = false;
        trForwardDocument.Visible = false;

        trBillList.Visible = true;
        rptBillList.Visible = false;

        string strAckFMDocIDs = "";

        if (dsBillList.Tables[0].Rows.Count > 0)
        {
            trForwardDocument.Visible = true;
            rptBillList.Visible = true;
            
            foreach (DataRow drRows in dsBillList.Tables[0].Rows)
            {
                strAckFMDocIDs = (strAckFMDocIDs == "" ? drRows["ID"].ToString() : strAckFMDocIDs + "," + drRows["ID"].ToString());
            }

            rptBillList.DataSource = dsBillList.Tables[0];
            rptBillList.DataBind();

            HidAckFMDocIDs.Value = strAckFMDocIDs;
        }
    }        
        
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string strSQL = "UPDATE webx_fm_fwd_doc_detail SET FM_Ack_Status = 1 WHERE ID IN (" + HidAckFMDocs.Value + ")";
            SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.Text, strSQL);

            SqlParameter[] prm = new SqlParameter[1];
            prm[0] = new SqlParameter("@FM_Master_ID", HidFMID.Value);
            SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.StoredProcedure, "Webx_SP_FM_Update_Ack_Status", prm);
            
            Response.Redirect("DisplayFMAckDocumentsResult.aspx?FMNo=" + HidFMNo.Value + "&FMID=" + HidFMID.Value);
        }
        catch (Exception Ex)
        {
            trErrorMsg.Visible = true;
            lblFMFWDDocErrorMsg.InnerHtml = "An unknown error has occurred: " + Ex.Message;
        }
    }

    private string GetFMDocketTypeSuffix(string DocTypeValue)
    {
        return FMUtility.GetFMDocketTypeSuffix(DocTypeValue);
    }

    private void Get_FM_FWD_Doc_Master_Data()
    {
        string strSQL = "SELECT ID, FM_No, Manual_FM_No, FM_Date, FM_Entry_Date, " +
                        "(Case Doc_FWD_To WHEN 1 THEN 'Customer' WHEN 2 THEN 'Location' END) AS Doc_FWD_To, " +
                        "Loc_Cust_Code, (case FM_Doc_Type WHEN 1 THEN 'POD' " +
                        "WHEN 2 THEN 'Bill' WHEN 3 THEN 'Octroi Receipt' WHEN 4 THEN 'COD/DOD' " +
                        "END) AS FM_Doc_Type, Courier_Code, " +
                        "Courier_Way_Bill_No, Courier_Way_Bill_Date, FM_Ack_Status, " +
                        "FM_FWD_LocCode, FM_FWD_CurrYear FROM webx_fm_fwd_doc_master " +
                        "WHERE ID = " + HidFMID.Value;

        DataSet dsFMMasterData = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strSQL);

        if (dsFMMasterData.Tables[0].Rows.Count > 0)
        {
            lblFMNo.InnerHtml = dsFMMasterData.Tables[0].Rows[0]["FM_No"].ToString();
            lblFMDate.InnerHtml = Convert.ToDateTime(dsFMMasterData.Tables[0].Rows[0]["FM_Date"].ToString()).ToString("dd MMM yy");
            lblManualFMNo.InnerHtml = (dsFMMasterData.Tables[0].Rows[0]["Manual_FM_No"].ToString().Trim() == "" || dsFMMasterData.Tables[0].Rows[0]["Manual_FM_No"].ToString().Trim().ToUpper() == "NULL" ? "-" : dsFMMasterData.Tables[0].Rows[0]["Manual_FM_No"].ToString());
            lblFMEntryDate.InnerHtml = Convert.ToDateTime(dsFMMasterData.Tables[0].Rows[0]["FM_Entry_Date"].ToString()).ToString("dd MMM yy");
            lblFwdDocTo.InnerHtml = dsFMMasterData.Tables[0].Rows[0]["Doc_FWD_To"].ToString();
            lblCustLoc.InnerHtml = dsFMMasterData.Tables[0].Rows[0]["Loc_Cust_Code"].ToString();
            lblDocType.InnerHtml = dsFMMasterData.Tables[0].Rows[0]["FM_Doc_Type"].ToString();
            lblCourier.InnerHtml = dsFMMasterData.Tables[0].Rows[0]["Courier_Code"].ToString();
            lblWayBillNo.InnerHtml = (dsFMMasterData.Tables[0].Rows[0]["Courier_Way_Bill_No"].ToString().Trim() == "" || dsFMMasterData.Tables[0].Rows[0]["Courier_Way_Bill_No"].ToString().Trim().ToUpper() == "NULL" ? "-" : dsFMMasterData.Tables[0].Rows[0]["Courier_Way_Bill_No"].ToString());
            lblWayBillDate.InnerHtml = (dsFMMasterData.Tables[0].Rows[0]["Courier_Way_Bill_Date"].ToString().Trim() == "" || dsFMMasterData.Tables[0].Rows[0]["Courier_Way_Bill_Date"].ToString().Trim().ToUpper() == "NULL" ? "-" : Convert.ToDateTime(dsFMMasterData.Tables[0].Rows[0]["Courier_Way_Bill_Date"].ToString()).ToString("dd MMM yy"));
        }
    }


    private string getDateInddMMMyyyFormat(string strDate)
    {
        try
        {
            string[] strDateParts = strDate.Split('/');
            return strDateParts[0] + "-" + getShortMonthName(Convert.ToInt32(strDateParts[1])) + "-" + strDateParts[2];
        }
        catch (Exception Ex)
        {
            return "";
        }
    }

    private string getDateInddMMMyyFormat(string strDate)
    {
        try
        {
            string[] strDateParts = strDate.Split('/');
            return strDateParts[0] + " " + getShortMonthName(Convert.ToInt32(strDateParts[1])) + " " + strDateParts[2].Substring(2, 2);
        }
        catch (Exception Ex)
        {
            return "";
        }
    }

    private string getDateInddMMMyyFormatWithHyphen(string strDate)
    {
        try
        {
            string[] strDateParts = strDate.Split('/');
            return strDateParts[0] + "-" + getShortMonthName(Convert.ToInt32(strDateParts[1])) + "-" + strDateParts[2].Substring(2, 2);
        }
        catch (Exception Ex)
        {
            return "";
        }
    }

    private string getShortMonthName(int intMonth)
    {
        string strShortMonthName = "";
        strShortMonthName = DateFunction.MonthName1(intMonth);
        return strShortMonthName;
    }
}
