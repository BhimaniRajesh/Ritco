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

public partial class GUI_Operations_LoadingSheet_ListLoadingSheet : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getDocumentDetails();
            paintLSList();
        }

        lblHeader.InnerHtml = "<b>Update " + HidLS.Value + " & Prepare " + HidMF.Value + "</b>";
        lblLSNo.InnerHtml = "<b>" + HidLS.Value + " No.</b>";
        lblManualLSNo.InnerHtml = "<b>Manual " + HidLS.Value + " No.</b>";
        lblLSDate.InnerHtml = "<b>" + HidLS.Value + " Date</b>";
        lblTotDockets.InnerHtml = "<b>Total " + HidDocket.Value + "s&nbsp;</b>";
    }

    protected void paintLSList()
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        string strSQL = "Select tcno AS LSNo, convert(varchar,tcdt,106) AS LSDate, tcbr AS LocCode, route_code AS RouteCode, tot_dkt AS TotalDockets, '0/'+rtrim(ltrim(cast(tot_pkgs as varchar))) AS Packages,'0/'+rtrim(ltrim(cast(tot_actuwt as varchar))) AS Weight, ManualLSno From webx_tchdr_tmp where rtrim(ltrim(tcbr))='" + Session["brcd"].ToString() + "' and (Final_TC='N' or Final_TC is Null) order by tcdt desc";

        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsLSList = new DataSet();

        DataTable dt = new DataTable();

        dt.Columns.Add("SrNo", typeof(string));
        dt.Columns.Add("LSNo", typeof(string));
        dt.Columns.Add("LSNoLinkToolTip", typeof(string));
        dt.Columns.Add("LSNoPostBackURL", typeof(string));
        dt.Columns.Add("ManualLSNo", typeof(string));
        dt.Columns.Add("ManualLSNoLinkToolTip", typeof(string));
        dt.Columns.Add("LSDate", typeof(string));
        dt.Columns.Add("LocationCode", typeof(string));
        dt.Columns.Add("RouteCode", typeof(string));
        dt.Columns.Add("TotalDockets", typeof(string));
        dt.Columns.Add("Packages", typeof(string));
        dt.Columns.Add("Weight", typeof(string));

        DataRow dr;

        sqlDA.Fill(dsLSList);
        int i = 1;

        if (dsLSList.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow drRows in dsLSList.Tables[0].Rows)
            {
                dr = dt.NewRow();

                dr["SrNo"] = i.ToString();
                i++;
                dr["LSNo"] = drRows["LSNo"].ToString();
                dr["LSNoLinkToolTip"] = "Click here to prepare menifest for dockets from the selected " + HidLS.Value + " no.: " + drRows["LSNo"].ToString();
                dr["ManualLSNo"] = (drRows["ManualLSno"].ToString().ToUpper() == "NULL" || drRows["ManualLSno"].ToString().Trim() == "" ? "" : drRows["ManualLSno"].ToString());
                dr["ManualLSNoLinkToolTip"] = (dr["ManualLSNo"].ToString() == "-" ? "" : "Click here to prepare menifest for dockets from the selected " + HidLS.Value + " No.: " + drRows["LSNo"].ToString());
                dr["LSNoPostBackURL"] = "~/GUI/Operations/LoadingSheet/PrepareMFFromLS.aspx?LSNo=" + drRows["LSNo"].ToString();
                dr["LSDate"] = (drRows["LSDate"] == System.DBNull.Value ? "-" : Convert.ToDateTime(drRows["LSDate"].ToString()).ToString("dd MMM yy"));
                dr["LocationCode"] = drRows["LocCode"].ToString();
                dr["RouteCode"] = (drRows["RouteCode"].ToString().ToUpper() == "NULL" || drRows["RouteCode"].ToString().Trim() == "" ? "-" : drRows["RouteCode"].ToString());
                dr["TotalDockets"] = drRows["TotalDockets"].ToString();
                dr["Packages"] = drRows["Packages"].ToString();
                dr["Weight"] = drRows["Weight"].ToString();

                dt.Rows.Add(dr);
            }

            rptLoadingSheetList.DataSource = dt;
            rptLoadingSheetList.DataBind();
            trErrorMsgForLS.Visible = false;
        }
        else
        {
            rptLoadingSheetList.Visible = false;
            trErrorMsgForLS.Visible = true;
            lblErrorMsgForLS.InnerHtml = HidLS.Value + " details not found";
        }

        sqlConn.Close();
    }

    private void getDocumentDetails()
    {
        HidDocket.Value = "";
        HidLS.Value = "";

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
                }
            }
        }
    }
}
