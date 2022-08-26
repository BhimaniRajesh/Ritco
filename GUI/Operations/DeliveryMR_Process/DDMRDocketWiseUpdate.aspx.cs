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

public partial class GUI_Finance_GeneralizedPO_POViewPrint_POViewPrintResult : BasePage
{
    string DDMRCode = "", DocketCode = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            CreateToken();
            DDMRCode = Request.QueryString["DDMRCode"].ToString();
            DocketCode = Request.QueryString["DocketCode"].ToString();

            BindGrid();
        }
    }
    public void BindGrid()
    {
        DataTable dtDDMRList = new DataTable();

        string SQLStr = "EXEC USP_DDMR_DocketWise_UpdateProcessList '" + DDMRCode + "','" + DocketCode + "','" + SessionUtilities.CurrentBranchCode.ToString().Trim() + "'";

        dtDDMRList = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQLStr).Tables[0];
        GV_DDMRList.DataSource = dtDDMRList;
        GV_DDMRList.DataBind();
        if (dtDDMRList.Rows.Count == 0)
        {
            btnShow.Enabled = false;
        }

        DataTable dtHeader = new DataTable();
        string SQL = "";
        if (DDMRCode.ToString() != "" && DDMRCode.ToString() != "NA")
        {
            SQL = "SELECT H.DDMRNo,DDMRDt=CONVERT(VARCHAR,H.DDMRDt,106),H.Vehicle FROM webx_DDMR_HDR H WITH(NOLOCK) INNER JOIN Webx_DDMR_DET D WITH(NOLOCK) ON D.DDMRNo=H.DDMRNo WHERE ISNULL(Cancelled,'N')='N' AND D.DDMRNo='" + DDMRCode + "'";
        }
        else
        {
            SQL = "SELECT H.DDMRNo,DDMRDt=CONVERT(VARCHAR,H.DDMRDt,106),H.Vehicle FROM webx_DDMR_HDR H WITH(NOLOCK) INNER JOIN Webx_DDMR_DET D WITH(NOLOCK) ON D.DDMRNo=H.DDMRNo WHERE ISNULL(Cancelled,'N')='N' AND D.Dockno='" + DocketCode + "'";
        }
        dtHeader = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, SQL).Tables[0];
        if (dtHeader.Rows.Count > 0)
        {
            LblDDMRNo.Text = dtHeader.Rows[0]["DDMRNo"].ToString();
            LblDDMTDate.Text = dtHeader.Rows[0]["DDMRDt"].ToString();
            LblTruckNo.Text = dtHeader.Rows[0]["Vehicle"].ToString();
        }
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        if (IsTokenValid())
        {
            string SQL = "";
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();

            try
            {
                foreach (GridViewRow gridrow in GV_DDMRList.Rows)
                {
                    Label LblDOCKNO = (Label)gridrow.FindControl("LblDOCKNO");
                    TextBox TxtPktGiven = (TextBox)gridrow.FindControl("TxtPktGiven");
                    TextBox TxtDeliveredPkt = (TextBox)gridrow.FindControl("TxtDeliveredPkt");
                    TextBox TxtPendPkt = (TextBox)gridrow.FindControl("TxtPendPkt");
                    HiddenField _HdnPendPkt = (HiddenField)gridrow.FindControl("HdnPendPkt");
                    CheckBox Chk_Docno = (CheckBox)gridrow.FindControl("Chk_Docno");

                    if (Chk_Docno.Checked == true)
                    {
                        SqlTransaction trans = conn.BeginTransaction();
                        try
                        {
                            SQL = "UPDATE Webx_DDMR_DET SET DeliveredPkt=" + TxtDeliveredPkt.Text + ",Update_PendPkt=" + _HdnPendPkt.Value + " WHERE DDMRNo='" + LblDDMRNo.Text + "' AND Dockno='" + LblDOCKNO.Text.ToString() + "'";
                            SqlHelper.ExecuteNonQuery(trans, CommandType.Text, SQL);
                            trans.Commit();
                            ConsumeToken();
                        }
                        catch (Exception e1)
                        {
                            trans.Rollback();
                            throw new Exception("You Cant Update the DDMR Process, So Please Try Against");
                        }
                        //trans.Commit();
                    }
                }
                Response.Redirect("DDMR_UpdateDone.aspx");
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message);
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                    conn.Close();
                conn.Dispose();
            }
        }
    }
}

