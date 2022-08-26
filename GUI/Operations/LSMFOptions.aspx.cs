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

public partial class GUI_Operations_LSMFOptions : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getDocumentDetails();
        }

        lblHeader.InnerHtml = "<b>" + HidLS.Value + " &amp; " + HidMF.Value + " Operations</b>";
        lblTitle.InnerHtml = "<b>" + HidLS.Value + " &amp; " + HidMF.Value + " Options</b>";
        lnkNewLS.Text = "Prepare New " + HidLS.Value;
        lnkUpLSPrepMF.Text = "Update " + HidLS.Value + " &amp; Generate " + HidMF.Value;
        lnkNewMF.Text = "Generate " + HidMF.Value + " without Preparing " + HidLS.Value;
        lnkUpdatePackagesWeightInMF.Text = "Update Packages & Weight in " + HidMF.Value;
        lnkViewPrintMF.Text = "View & Print " + HidMF.Value;

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
