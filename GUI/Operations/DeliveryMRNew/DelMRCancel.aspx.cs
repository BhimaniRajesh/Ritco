using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;


public partial class GUI_Operations_DeliveryMR_DelMRCancel : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            hdndockname.Value = Session["DocketCalledAs"].ToString();
        }
        catch (Exception ex)
        {
            Response.Redirect("../ErrorPage.aspx?heading=Session Expired.&detail1=" + ex.Message.Replace('\n', '_') + "&suggestion1=Log on again", false);
            return;
        }
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        string strsql = "";
        trmessage.Visible = false;
        if (optdoctype.SelectedValue.CompareTo("DKT") == 0)
        {
            strsql = "SELECT COUNT(dockno) FROM webx_master_docket WHERE dockno='" + txtmrno.Text.Trim() + "'";
            int cnt = 0;
            cnt = WebXConvert.ToInt16(Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, strsql)));
            if (cnt == 0)
            {
                SetMessage(hdndockname.Value + " No " + txtmrno.Text + " doesn't Exists.");
                return;
            }
        }
        else if (optdoctype.SelectedValue.CompareTo("GP") == 0)
        {
            strsql = "SELECT COUNT(dockno) FROM webx_gatepass WHERE gatepassno='" + txtmrno.Text.Trim() + "'";
            int cnt = 0;
            cnt = WebXConvert.ToInt16(Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, strsql)));
            if (cnt == 0)
            {
                SetMessage("Gatepass No " + txtmrno.Text + " doesn't Exists.");
                return;
            }
        }
        /*else if (optdoctype.SelectedValue.CompareTo("MR") == 0)
        {
            strsql = "SELECT COUNT(D.Dockno) FROM Webx_DDMR_HDR M WITH(NOLOCK) INNER JOIN Webx_DDMR_DET D WITH(NOLOCK) ON D.DDMRNo=M.DDMRNo WHERE ISNULL(M.Cancelled,'N')='N' AND D.MRNO='" + txtmrno.Text.Trim() + "'";
            int cnt = 0;
            cnt = WebXConvert.ToInt16(Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, strsql)));
            if (cnt > 0)
            {
                SetMessage("Delivery MR No " + txtmrno.Text + " Already DDMR Exists, So Please First Cancel DDMR.");
                return;
            }
        }*/

        strsql = " SELECT CONVERT(VARCHAR,mrsdt,103) AS mrdate,* FROM webx_mr_hdr m ";
        strsql = strsql + " inner join webx_trans_docket_status s on s.dockno=m.dockno and s.docksf=m.docksf ";
        strsql = strsql + " left outer JOIN webx_gatepass g ON g.gatepassno=s.gatepassno and g.mrsno=m.mrsno ";
        strsql = strsql + " WHERE  m.mrstype='12' AND mr_cancel='N'";
        if (optdoctype.SelectedValue.CompareTo("MR") == 0)
            strsql = strsql + "AND m.mrsno='" + txtmrno.Text.Trim() + "'";
        else if (optdoctype.SelectedValue.CompareTo("DKT") == 0)
            strsql = strsql + "AND m.dockno='" + txtmrno.Text.Trim() + "'";
        else if (optdoctype.SelectedValue.CompareTo("GP") == 0)
            strsql = strsql + "AND g.gatepassno='" + txtmrno.Text.Trim() + "'";

        DataTable dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];                
        DataRow dr = null, drbill = null;

        if (dt.Rows.Count > 0)
        {
            dr = dt.Rows[0];

            DateTime mrdate = WebXConvert.ToDateTime(dr["mrdate"].ToString(),"en-GB");
            int year = 0;
            if (mrdate.Month < 4)
                year = mrdate.Year - 1;
            else
                year = mrdate.Year;

            if (year.ToString() != SessionUtilities.FinYear)
            {
                SetMessage("DELIVERY MR " + dr["mrsno"] + " doesn't exists in Current Financial Year");
                return;
            }
            if (dr["mr_cancel"].ToString().CompareTo("Y") == 0 || dr["activeflag"].ToString().CompareTo("N") == 0)
            {
                SetMessage("Delivery MR " + dr["mrsno"].ToString() + " is already cancelled."); 
                return;
            }
            hdndocksf.Value = dr["docksf"].ToString();
            if (WebXConvert.ToDouble(dr["mrsamt"].ToString()) != WebXConvert.ToDouble(dr["netamt"].ToString()))
            {
                strsql = "SELECT * FROM webx_billdet d INNER JOIN webx_billmst m ON d.billno=m.billno WHERE dockno='" + dr["dockno"].ToString() + "'";
                strsql = strsql + " AND paybas='11' AND bill_cancel='N'";
                DataTable dtbill = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strsql).Tables[0];

                if (dtbill.Rows.Count > 0)
                {
                    drbill = dtbill.Rows[0];
                    if (drbill["billstatus"].ToString().ToUpper().CompareTo("BILL COLLECTED") == 0)
                    {
                        SetMessage("DELIVERY BILL " + drbill["billno"] + " is now Collected");
                        return;
                    }
                }
                else
                {
                    SetMessage("Problem in Partial Payment.");
                    return;
                }
            }
            CancelMR(dr, drbill);
        }
        else
        {
            if (optdoctype.SelectedValue.CompareTo("DKT") == 0)
                SetMessage("Either Delivery MR doesn't Exists or cancelled for " + hdndockname.Value + " No " + txtmrno.Text);
            else if (optdoctype.SelectedValue.CompareTo("MR") == 0)
                SetMessage("Either Delivery MR No " + txtmrno.Text + " doesn't Exists or cancelled ");
            else if (optdoctype.SelectedValue.CompareTo("GP") == 0)
                SetMessage("Either Delivery MR doesn't exists or cancelled for Gatepass No " + txtmrno.Text);
            return;
        }

    }

    private void CancelMR(DataRow drmain, DataRow drbill)
    {
        string strsql = "", billno = "NA";
        SqlConnection con = new SqlConnection(SessionUtilities.ConnectionString);
        con.Open();
        SqlTransaction trn = con.BeginTransaction();
        try
        {
            string finstring = "";
            int year1 = WebXConvert.ToInt16(SessionUtilities.FinYear.Substring(2, 2));
            int year2 = WebXConvert.ToInt16(SessionUtilities.FinYear.Substring(2, 2)) + 1;
            finstring = year1.ToString("F0").PadLeft(2, '0') + "_" + year2.ToString("F0").PadLeft(2, '0');

            if (drmain["paymode"].ToString().ToUpper().CompareTo("CHEQUE") == 0)
            {
                strsql = "SELECT voucherno FROM webx_acctrans_" + finstring + "";
                strsql = strsql + " WHERE docno='" + drmain["mrsno"].ToString() + "' AND voucher_cancel='N'";
                string voucherno = Convert.ToString(SqlHelper.ExecuteScalar(trn, CommandType.Text, strsql));

                strsql = "INSERT INTO webx_chq_det_cancelled(chqindex,chqno,chqdt,chqamt,banknm,ptmsptcd,ptmsptnm,comments,bacd,banm,brcd,brnm,";
                strsql = strsql + " empcd,empnm,adjustamt,bankbrn,owncust,depoflag,voucherno,acccode,transdate,depoloccode,chq_clear,chq_status ) ";
                strsql = strsql + " SELECT chqindex,chqno,chqdt,chqamt,banknm,ptmsptcd,ptmsptnm,'DELIVERY MR CANCELLED',bacd,banm,brcd,brnm,";
                strsql = strsql + " empcd,empnm,adjustamt,bankbrn,owncust,depoflag,voucherno,acccode,transdate,depoloccode,chq_clear,'CANCELLED'";
                strsql = strsql + " FROM webx_chq_det WHERE ";
                strsql = strsql + " voucherno='" + voucherno + "' AND chqno='" + drmain["mrschqno"].ToString() + "'";
                SqlHelper.ExecuteNonQuery(trn, CommandType.Text, strsql);

                strsql = "DELETE FROM webx_chq_det WHERE voucherno='" + voucherno + "' AND chqno='";
                strsql = strsql + drmain["mrschqno"].ToString() + "'";
                SqlHelper.ExecuteNonQuery(trn, CommandType.Text, strsql);

                strsql = "DELETE FROM webx_billchqdetail WHERE docno='" + drmain["mrsno"].ToString() + "' AND chqno='";
                strsql = strsql + drmain["mrschqno"].ToString() + "'";
                SqlHelper.ExecuteNonQuery(trn, CommandType.Text, strsql);
                
            }
            strsql = "UPDATE webx_mr_hdr SET mr_cancel='Y',CancelledBy='"+ Session["EMPCD"].ToString() +"'";
            strsql = strsql + " WHERE mrsno='" + drmain["mrsno"].ToString() + "'";
            SqlHelper.ExecuteNonQuery(trn, CommandType.Text, strsql);

            strsql = "UPDATE webx_acctrans_" + finstring + " SET voucher_cancel='Y'";
            strsql = strsql + " WHERE docno='" + drmain["mrsno"].ToString() + "'";
            SqlHelper.ExecuteNonQuery(trn, CommandType.Text, strsql);

            strsql = "UPDATE webx_gatepass SET activeflag='N'";
            strsql = strsql + " WHERE mrsno='" + drmain["mrsno"].ToString() + "'";
            SqlHelper.ExecuteNonQuery(trn, CommandType.Text, strsql);

            strsql = "UPDATE webx_trans_docket_status SET delivered='N',dely_date=NULL,gatepassno=NULL,receivercode=NULL,receivername=NULL,Op_Status=' Pending For Delivery MR' ";
            strsql = strsql + " WHERE dockno='" + drmain["dockno"].ToString() + "' AND docksf='" + hdndocksf.Value + "'";
            SqlHelper.ExecuteNonQuery(trn, CommandType.Text, strsql);

            if (WebXConvert.ToDouble(drmain["mrsamt"].ToString()) != WebXConvert.ToDouble(drmain["netamt"].ToString()))
            {
                strsql = "UPDATE webx_billmst SET billstatus='BILL CANCELLED',bill_cancel='Y'";
                strsql = strsql + " WHERE billno='" + drbill["billno"].ToString() + "'";
                SqlHelper.ExecuteNonQuery(trn, CommandType.Text, strsql);
                billno = drbill["billno"].ToString();
            }
        }
        catch (Exception ex)
        {
            trn.Rollback();
            Response.Redirect("../ErrorPage.aspx?heading=Database updation failed&detail1=" + ex.Message.Replace('\n', '_') + "&suggestion1=Re-try Cancel MR", false);
            return;
        }

        trn.Commit();
        Response.Redirect("DelMRCancelDone.aspx?mrno=" + drmain["mrsno"].ToString() + "&billno=" + billno);
    }

    private void SetMessage(string message)
    {
        trmessage.Visible = true;
        lblmessage.Text = message;
    }

}
