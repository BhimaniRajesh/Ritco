using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.Mobile;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.MobileControls;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data.Sql;
using System.Configuration;
using Microsoft.ApplicationBlocks.Data;

public partial class MobileTrack_Result : System.Web.UI.MobileControls.MobilePage
{
    string connString = "";
    string DocNo = "";
    string RefType = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        connString = ConfigurationManager.AppSettings["riplConnString"].ToString();

        if (Request.QueryString["DN"] != null)
            DocNo = Request.QueryString["DN"].ToString();
        if (Request.QueryString["RT"] != null)
            RefType = Request.QueryString["RT"].ToString();
        BindResult();
    }

    private void BindResult()
    {
        switch (RefType)
        { 
            case "DOC":
                trackDocket();
                break;
            case "INV":
                trackInvStatus();
                break;
            case "CTN":
                trackCustRefNo();
                break;
        }
    }

    private void trackDocket()
    {
        string cmd = "exec usp_Docket_Track_ForMobile '"+DocNo+".'";
        DataSet ds = SqlHelper.ExecuteDataset(connString, CommandType.Text, cmd);
        bindData(ds);
    }
    private void trackInvStatus()
    { 
        string cmd = "exec usp_Docket_Track_ForMobile_ByInvoiceNo '"+DocNo+"'";
        DataSet ds = SqlHelper.ExecuteDataset(connString, CommandType.Text, cmd);
        bindData(ds);
    }
    private void trackCustRefNo()
    {
        string cmd = "exec usp_Docket_Track_ForMobile_ByCustRefNo '" + DocNo + "'";
        DataSet ds = SqlHelper.ExecuteDataset(connString, CommandType.Text, cmd);
        bindData(ds);        
    }
    private void bindData(DataSet ds)
    {
        DataTable dt = ds.Tables[0];
        if (dt.Rows.Count > 0)
        {
            DataRow dr = dt.Rows[0];

            lblDocket.Text = "Docket Number: " + dr["DOCKNO"].ToString() + " booked on " + dr["DOCKDT"].ToString();
            lblOrgDest.Text = "Origin-Destination: " + dr["Docket_Orgin"].ToString() + " - " + dr["Docket_Destination"].ToString();
            lblFromTo.Text = "From-To: NA";
            if (dr["from_loc"] != null && dr["to_loc"] != null)
            {
                string frmdt = dr["from_loc"].ToString().Trim();
                string todt = dr["to_loc"].ToString().Trim();
                if (frmdt != "" && todt != "")
                    lblFromTo.Text = "From-To: " + frmdt + " - " + todt;
            }
            lblEDD.Text = "EDD: " + dr["EDD"].ToString();
            lblStatus.Text = "Status: " + dr["Docket_Status"].ToString();
            lblDelivered.Text = "Delivered to: NA";
            if (dr["delivered"] != null)
            {
                string delv = dr["delivered"].ToString().Trim().ToUpper();
                if (delv == "Y")
                    lblDelivered.Text = "Delivered to: " + dr["DESTCD"].ToString() + " on " + dr["Delivery_DT"].ToString();
            }
        }
    }
}
