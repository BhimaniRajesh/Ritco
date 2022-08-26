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

public partial class GUI_Operations_DRS_GenerateDRSResult : System.Web.UI.Page
{
    public static string strDRSCode,DRSNumber;
    //static string strDocketList;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            strDRSCode = HttpUtility.UrlDecode(Request.QueryString["DRSCode"].ToString());
            DRSNumber = HttpUtility.UrlDecode(Request.QueryString["DRSCode"].ToString());
            strDRSCode = strDRSCode + "<br>[" + HttpUtility.UrlDecode(Request.QueryString["Tranzaction"].ToString()) + "]";
            strDRSCode = strDRSCode + "<br> FinYear:" + Session["FinYear"].ToString().Trim();
            //strDocketList = HttpUtility.UrlDecode(Request.QueryString["DocketList"].ToString());

            getDocumentDetails();

            paintDocketListing();
        }

        //lblHeader.InnerHtml = "<b>" + HidDRS.Value + " Generation Result</b>";
        lblHeader.InnerHtml = "<b>Transaction Completed</b>";
        lblDRSCaption.InnerHtml = HidDRS.Value;
        lblDocketCaption.InnerHtml = HidDocket.Value + " No.";
        lblMRCaption.InnerHtml = "Bill NOs.";
        lblVP.InnerHtml = "<a href=\"Javascript:OpenInWindow('DRS_View_Print.aspx?DRSNo=" + DRSNumber + ",0',400,600,10,10)\"><u>View</u></a>&nbsp;|&nbsp;<a href=\"Javascript:OpenInWindow('DRS_View_Print.aspx?DRSNo=" + DRSNumber + ",1',400,600,10,10)\"><u>Print</u></a>|&nbsp;<a href=\"Javascript:OpenInWindow('../../Print/PDCPrint.aspx?DRSNo=" + DRSNumber + "',400,600,10,10)\"><u>Dos Print</u></a>";
        lblMoreDRS.InnerHtml = "<a href=\"../../../GUI/Operations/DRS/DRSCreateMain.aspx\"><u>Click here to Generate More " + HidDRS.Value + "</u></a>";
        //lblUpdateDRS.InnerHtml = "<a href=\"../../../GUI/Operations/DRS/UpdateDRSMain.aspx\"><u>Update " + HidDRS.Value + "</u></a>";
        //lblUpdateDRS.InnerHtml = "<a href=\"../../../GUI/Operations/DRS/DRSUpdateMain.aspx\"><u>Update " + HidDRS.Value + "</u></a>";

        Page.Title = "Display " + HidDRS.Value + " Result";
    }

    private void paintDocketListing()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        //string strSQL = "select dockno, mrsno, mrstype from Vw_MR_details with(NOLOCK) where dockno+docksf in ('" + strDocketList.Replace(" ", "").Replace(",", "','") + "') AND mrstype = 3";
        string strSQL = "Select Dockno,A.Billno, Billtype=paybas From webx_billdet A  inner join webx_billmst B on A.billno=B.billno Where Dockno in (Select  Dockno From WebX_Trans_Docket_DRS Where DRSNo = '" + DRSNumber.Trim() + "' and DockSF='.')";
        //Response.Write("strSQL--" + strSQL);
        //Response.End();
        
        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
        
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsDocketList = new DataSet();

        DataTable dt = new DataTable();

        dt.Columns.Add("DocketNo", typeof(string));
        dt.Columns.Add("Billno", typeof(string));
        dt.Columns.Add("Billtype", typeof(string));
        dt.Columns.Add("DocketVP", typeof(string));
        
        DataRow dr;

        sqlDA.Fill(dsDocketList);

        if (dsDocketList.Tables[0].Rows.Count > 0)
        {
            rptDocketList.Visible = true;

            foreach (DataRow drRows in dsDocketList.Tables[0].Rows)
            {
                dr = dt.NewRow();

                dr["DocketNo"] = drRows["dockno"].ToString();
                dr["BIllno"] = drRows["BIllno"].ToString();
                dr["Billtype"] = drRows["Billtype"].ToString();
                dr["DocketVP"] = "<a href=\"Javascript:OpenInWindow('../../Operation/Singlescreen_docketentry/DocketPrint/PaidMR/MR_Summ_Popup.aspx?mrsno=" + drRows["BIllno"].ToString() + "',400,600,10,10)\"><u>View</u></a>&nbsp;|&nbsp;<a href=\"Javascript:OpenInWindow('../../Operation/Singlescreen_docketentry/DocketPrint/PaidMR/MR_Summ_Popup.aspx?mrsno=" + drRows["BIllno"].ToString() + "',400,600,10,10)\"><u>Print</u></a>";

                dt.Rows.Add(dr);
            }

            rptDocketList.DataSource = dt;
            rptDocketList.DataBind();
        }
        else
        {
            rptDocketList.Visible = false;
        }

        sqlConn.Close();
    }

    private void getDocumentDetails()
    {
        HidLS.Value = "";
        HidMF.Value = "";
        HidTHC.Value = "";
        HidDRS.Value = "";
        HidDocket.Value = "";
        HidMR.Value = "";

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
                    case "DRS":
                        HidDRS.Value = dsDocument.Tables[0].Rows[intLoopCounter]["CodeDesc"].ToString();
                        break;
                    case "DKT":
                        HidDocket.Value = dsDocument.Tables[0].Rows[intLoopCounter]["CodeDesc"].ToString();
                        break;
                    case "BILL":
                        HidMR.Value = dsDocument.Tables[0].Rows[intLoopCounter]["CodeDesc"].ToString();
                        break;
                }
            }
        }
    }
}
