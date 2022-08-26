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

public partial class GUI_Operations_LoadingSheet_DisplayTHCResult : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            HidTHCNo.Value = Request.QueryString["THCNo"];
            HidManTHCNo.Value = Request.QueryString["ManTHCNo"];
            HidTranzaction.Value = Request.QueryString["Tranzaction"];
            getDocumentDetails();
        }

        lblHeader.InnerHtml = Request.QueryString["Tranzaction"];

        paintTHCMFList();

        //lblPrepTHC.InnerHtml = "<a href=\"../new_THC_Ver2/THCCreateMain.aspx\"><u>Prepare More " + HidTHC.Value + "</u></a>";
        lblPrepLSMF.InnerHtml = "<a href=\"./../LSMFOptions.aspx\"><u>Prepare " + HidLS.Value + " &amp; " + HidMF.Value + "</u></a>";
        lblPrepDocket.InnerHtml = "<a href=\"./../../operation/docket_operation.aspx\"><u>Prepare " + HidDocket.Value + "s</u></a>";

        Page.Title = "Display " + HidTHC.Value + " Generation Result";
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
                        HidTHC.Value = Session["THCCalledAs"].ToString();
                            //dsDocument.Tables[0].Rows[intLoopCounter]["CodeDesc"].ToString();
                        break;
                }
            }
        }
    }

    private void paintTHCMFList()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandText = "WebX_SP_GetTHCMFDetailsForViewPrint";
        sqlCommand.CommandType = CommandType.StoredProcedure;

        sqlCommand.Parameters.AddWithValue("@THCNo", HidTHCNo.Value);

        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsTHCMFList = new DataSet();

        DataTable dt = new DataTable();

        dt.Columns.Add("DocumentName", typeof(string));
        dt.Columns.Add("SystemNumber", typeof(string));
        dt.Columns.Add("ManualNumber", typeof(string));
        dt.Columns.Add("ViewPrint", typeof(string));

        DataRow dr;

        int i = 1;

        sqlDA.Fill(dsTHCMFList);

        if (dsTHCMFList.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow drRows in dsTHCMFList.Tables[0].Rows)
            {
                dr = dt.NewRow();
                
                dr["DocumentName"] = drRows["DocumentName"].ToString();
                dr["SystemNumber"] = drRows["SystemNumber"].ToString();
                dr["ManualNumber"] = drRows["ManualNumber"].ToString().Replace("NULL", "");

                if (drRows["SrNo"].ToString() == "1")
                {
                    dr["ViewPrint"] = "<a href=\"Javascript:OpenInWindow('../THC/ViewPrint/THCViewPrint.aspx?tcno=" + drRows["SystemNumber"].ToString() + ".,0',400,600,10,10)\"><u>View</u></a>|<a href=\"Javascript:OpenInWindow('../THC/ViewPrint/THCViewPrint.aspx?tcno=" + drRows["SystemNumber"].ToString() + ".,1',400,600,10,10)\"><u>Print</u></a>|<a href=\"Javascript:OpenInWindow('../../Print/THCPrint.aspx?tcno=" + drRows["SystemNumber"].ToString() + "',400,600,10,10)\"><u>Dos Print</u></a>";
                }
                else
                {
                    dr["ViewPrint"] = "<a href=\"Javascript:OpenInWindow('../TCS/PrintTCS/FrmMenifestView.aspx?MFNo=" + drRows["SystemNumber"].ToString() + ",0',400,600,10,10)\"><u>View</u></a>|<a href=\"Javascript:OpenInWindow('../TCS/PrintTCS/FrmMenifestView.aspx?MFNo=" + drRows["SystemNumber"].ToString() + ",1',400,600,10,10)\"><u>Print</u></a>|<a href=\"Javascript:OpenInWindow('../../Print/MenifestPrint.aspx?tcno=" + drRows["SystemNumber"].ToString() + "',400,600,10,10)\"><u>Dos Print</u></a>";
                }
                
                dt.Rows.Add(dr);
            }

            rptDocumentList.DataSource = dt;
            rptDocumentList.DataBind();
        }
    }
}
