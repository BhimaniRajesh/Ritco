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

public partial class GUI_Operations_DRS_ListDRSForUpdate : System.Web.UI.Page
{
    static string strFromDate;
    static string strToDate;
    static string strDRSNoList;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            strFromDate = HttpUtility.UrlDecode(Request.QueryString["FromDate"].ToString());
            strToDate = HttpUtility.UrlDecode(Request.QueryString["ToDate"].ToString());
            strDRSNoList = HttpUtility.UrlDecode(Request.QueryString["DRSNoList"].ToString());

            getDocumentDetails();

            paintDRSListing();
        }

        lblHeader.InnerHtml = "<b>Update " + HidDRS.Value + "</b>";
        lblDRSCode.InnerHtml = "<b>" + HidDRS.Value + " Code</b>";
        lblDRSDate.InnerHtml = "<b>" + HidDRS.Value + " Date</b>";
        lblDockets.InnerHtml = "<b>No. of " + HidDocket.Value + "(s) in " + HidDRS.Value + "&nbsp;</b>";
        lblNoRecsForDRS.InnerHtml = HidDRS.Value + " details not found for the given criteria.";

        btnSelectDRS.Text = "Update Selected " + HidDRS.Value;
        btnSelectDRS.ToolTip = "Click here to Update Selected " + HidDRS.Value + " Details";

        lbtnSelectDRSDetails.Text = "Search " + HidDRS.Value + " Details";
        lbtnSelectDRSDetails.ToolTip = "Click here to Go Back & Search " + HidDRS.Value + " details";

        Page.Title = "Display " + HidDRS.Value + " To Update";
    }

    private void paintDRSListing()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = sqlConn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "usp_drs_for_updation";

        sqlCommand.Parameters.AddWithValue("@pdclist", strDRSNoList);
        sqlCommand.Parameters.AddWithValue("@pdcdtfrom", strFromDate + " 00:00:00");
        sqlCommand.Parameters.AddWithValue("@pdcdtto", strToDate + " 23:59:59");
        sqlCommand.Parameters.AddWithValue("@brcd", Session["brcd"].ToString());
        
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsDRSList = new DataSet();

        DataTable dt = new DataTable();

        dt.Columns.Add("SrNo", typeof(string));
        dt.Columns.Add("DRSNo", typeof(string));
        dt.Columns.Add("DRSDate", typeof(string));
        dt.Columns.Add("TotalDocketsInDRS", typeof(string));
        
        DataRow dr;

        sqlDA.Fill(dsDRSList);

        int i = 1;

        HidTotalRecords.Value = dsDRSList.Tables[0].Rows.Count.ToString();

        if (dsDRSList.Tables[0].Rows.Count > 0)
        {
            rptDocketList.Visible = true;
            trNoRecsForDocketList.Visible = false;
            trUpdateSelectedDRS.Visible = true;
            trLinkSelectDRSDetails.Visible = false;

            foreach (DataRow drRows in dsDRSList.Tables[0].Rows)
            {
                dr = dt.NewRow();

                dr["SrNo"] = i.ToString();
                i++;
                dr["DRSNo"] = drRows["pdcno"].ToString();
                dr["DRSDate"] = (drRows["pdc_dt"].ToString().Trim() == ""  || drRows["pdc_dt"].ToString().Trim().ToUpper() == "NULL"? "-" : Convert.ToDateTime(drRows["pdc_dt"].ToString()).ToString("dd MMM yy"));
                dr["TotalDocketsInDRS"] = drRows["tot_dkt"].ToString();

                dt.Rows.Add(dr);
            }

            rptDocketList.DataSource = dt;
            rptDocketList.DataBind();
        }
        else
        {
            trNoRecsForDocketList.Visible = true;
            rptDocketList.Visible = false;
            trUpdateSelectedDRS.Visible = false;
            trLinkSelectDRSDetails.Visible = true;
        }
        
        sqlConn.Close();
    }

    protected void btnSelectDRS_Click(object sender, EventArgs e)
    {
        Response.Redirect("UpdateDRSDetailsStep1.aspx?DRSCode=" + HidSelectedDRSNo.Value);
    }

    private void getDocumentDetails()
    {
        HidLS.Value = "";
        HidMF.Value = "";
        HidTHC.Value = "";
        HidDRS.Value = "";
        HidDocket.Value = "";

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
                }
            }
        }
    }
}
