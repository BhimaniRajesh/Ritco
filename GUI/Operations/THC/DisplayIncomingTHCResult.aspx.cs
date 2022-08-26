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

public partial class GUI_Operations_LoadingSheet_DisplayIncomingTHCResult : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //HidTHCNo.Value = Request.QueryString["THCNo"];
            //HidManTHCNo.Value = Request.QueryString["ManTHCNo"];
            
            getDocumentDetails();
        }

        //lblTHCNo.InnerHtml = HidTHCNo.Value;

        //lblHeader.InnerHtml = "<b>" + HidMF.Value + " Generation Result</b>";
        lblHeader.InnerHtml = "<b>Transaction Completed</b>";
        //lblTHC.InnerHtml = HidTHC.Value + "&nbsp;";
        //lblManTHCNo.InnerHtml = HidManTHCNo.Value.Trim();
        //lblVPTHC.InnerHtml = "<a href=\"Javascript:OpenInWindow('thcprintview_new.aspx?tcno=" + HidTHCNo.Value + "',400,600,10,10)\"><u>View</u></a>&nbsp;|&nbsp;<a href=\"Javascript:OpenInWindow('thcprintview_new.aspx?tcno=" + HidTHCNo.Value + "',400,600,10,10)\"><u>Print</u></a>";
        //lblMoreMF.InnerHtml = "<a href=\"./ListLoadingSheet.aspx\"><u>Prepare More " + HidMF.Value + "</u></a>";
        //lblMoreTHC.InnerHtml = "<a href=\"../THC/THCMain.aspx\"><u>Prepare More " + HidTHC.Value + "s</u></a>";
        //lblLSMFOptions.InnerHtml = "<a href=\"./../LSMFOptions.aspx\"><u>" + HidLS.Value + " &amp; " + HidMF.Value + " Options</u></a>";

        lblUpdateTHC.InnerHtml = "<a href=\"THCArrivalsMain.aspx\"><u>Update more " + HidTHC.Value + "</u></a>";
        lblUpdateDocketStatus.InnerHtml = "<a href=\"./../StockUpdate/StockUpdateMain.aspx\"><u>Update " + HidDocket.Value + " Arrival Status</u></a>";
        
        Page.Title = "Display " + HidTHC.Value + " Incoming Result";
    }

    private void getDocumentDetails()
    {
        HidDocket.Value = "";
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
                    case "DKT":
                        HidDocket.Value = dsDocument.Tables[0].Rows[intLoopCounter]["CodeDesc"].ToString();
                        break;
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
