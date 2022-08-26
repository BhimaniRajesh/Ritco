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

public partial class GUI_Operations_LoadingSheet_DisplayLSResult : System.Web.UI.Page
{
    public string strNextLoadingSheetNo;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            HidLSNo.Value = Request.QueryString["LSNo"];
            HidManLSNo.Value = Request.QueryString["ManLSNo"];
            
            getDocumentDetails();
        }

        lblLSNo.InnerHtml = HidLSNo.Value;
        strNextLoadingSheetNo = HidLSNo.Value;

        //lblHeader.InnerHtml = "<b>" + HidLS.Value + " Generation Result</b>";
        lblHeader.InnerHtml = "<b>Transaction Completed</b>";
        lblLS.InnerHtml = HidLS.Value + "&nbsp;";
        lblManualLSNo.InnerHtml = HidManLSNo.Value;
        lblMoreLS.InnerHtml = "<a href=\"./LSMain.aspx\"><u>Prepare More " + HidLS.Value + "s</u></a>";
        lblPrepMF.InnerHtml = "Prepare " + HidMF.Value + " for: <a href=\"PrepareMFFromLS.aspx?LSNo=" + strNextLoadingSheetNo + "\"><u>This " + HidLS.Value + "</u></a>&nbsp;|&nbsp;<a href=\"ListLoadingSheet.aspx\"><u>Other " + HidLS.Value + "s</u></a>";
        lblVPLS.InnerHtml = "<a href=\"Javascript:OpenInWindow('../TCS/PrintTCS/ViewAndPrintLoadingSheet.aspx?MFNo=" + strNextLoadingSheetNo + ",0',400,600,10,10)\"><u>View</u></a>|<a href=\"Javascript:OpenInWindow('../TCS/PrintTCS/ViewAndPrintLoadingSheet.aspx?MFNo=" + strNextLoadingSheetNo + ",1',400,600,10,10)\"><u>Print</u></a>";
        //lblVPLS1.InnerHtml = "<a href=\"\"><u>View &amp; Print " + HidLS.Value + "</u></a>";
        //lblLSMFOptions.InnerHtml = "<a href=\"./../LSMFOptions.aspx\"><u>" + HidLS.Value + " &amp; " + HidMF.Value + " Options</u></a>";
        lblPrepTHC.InnerHtml = "<a href=\"../THC/THCMain.aspx\"><u>Prepare " + HidTHC.Value + "</u></a>";

        Page.Title = "Display " + HidLS.Value + " Result";
    }

    private void getDocumentDetails()
    {
        HidLS.Value = "";
        HidMF.Value = "";
        HidTHC.Value = "";

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        string strSQLForDocument = "select CodeID, CodeDesc from webx_master_general where codetype = 'DOCS'";

        SqlCommand sqlCommand = new SqlCommand(strSQLForDocument, sqlConn);

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsDocument = new DataSet();

        sqlDA.Fill(dsDocument);

        if (dsDocument.Tables[0].Rows.Count > 0)
        {
            for (int intLoopCounter = 0; intLoopCounter < dsDocument.Tables[0].Rows.Count; intLoopCounter++)
            {
                switch (dsDocument.Tables[0].Rows[intLoopCounter]["CodeID"].ToString())
                {
                    case "LS":
                        HidLS.Value = dsDocument.Tables[0].Rows[intLoopCounter]["CodeDesc"].ToString();
                        break;
                    case "MF":
                        HidMF.Value = dsDocument.Tables[0].Rows[intLoopCounter]["CodeDesc"].ToString();
                        break;
                    case "THC":
                        HidTHC.Value = dsDocument.Tables[0].Rows[intLoopCounter]["CodeDesc"].ToString();
                        break;
                }
            }
        }
    }
}
