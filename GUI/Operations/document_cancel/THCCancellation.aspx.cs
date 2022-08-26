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

public partial class GUI_Operations_document_cancel_THCCancellation : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand cmd;
    SqlDataReader dr;
    DataTable dt = new DataTable("table1");
    public string sql = "", sql1 = "", Vno = "";
    public static string acccode = "", accdesc = "", fincmplbr = "", Financial_Year = "", fin_year = "";
    MyFunctions fn = new MyFunctions();
    string TripsheetNo = "", CountTripsheetNo = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        if (!IsPostBack)
        {
            for (int i = 0; i < 5; i++)
            {
                dt.Rows.Add();
            }

            grvcontrols.DataSource = dt;
            grvcontrols.DataBind();

            Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
            fin_year = Session["FinYear"].ToString();
            double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
            fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');
        }
    }
    protected void btnrows_Click(object sender, EventArgs e)
    {


        Int16 maxrows = 0;
        if (txtnorows.Text.ToString().CompareTo("") != 0)
        {
            try
            {
                maxrows = Convert.ToInt16(txtnorows.Text);
            }
            catch (Exception ex)
            {
                txtnorows.Text = "";
                txtnorows.Focus();
            }
        }

        for (int i = 0; i < maxrows; i++)
        {
            dt.Rows.Add();
        }

        grvcontrols.DataSource = dt;
        grvcontrols.DataBind();

    }
    protected void grvcontrols_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            ((TextBox)e.Row.FindControl("txtTHCNo")).Attributes.Add("onblur", "THCBlur('" + ((TextBox)e.Row.FindControl("txtTHCNo")).ClientID.ToString() + "')");
        }
    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        for (int i = 0; i < grvcontrols.Rows.Count; i++)
        {
            TextBox txtTHCNumber = (TextBox)grvcontrols.Rows[i].FindControl("txtTHCNo");
            CheckBox ChkSel = (CheckBox)grvcontrols.Rows[i].FindControl("ChkSel");

            SqlConnection con1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());

            string THCBR = "", FromModule = "";

            if (ChkSel.Checked == true)
            {
                con1.Open();

                string SQLFromModule = "Select ISNULL(FromModule,'') from  WEBX_THC_SUMMARY WITH(Nolock) where thcno= '" + txtTHCNumber.Text + "'";
                FromModule = SqlHelper.ExecuteScalar(con1, CommandType.Text, SQLFromModule).ToString();

                if (FromModule.ToUpper() != "NEWMVC")
                {
                    string SQLTHCBR = "Select THCBR from  WEBX_THC_SUMMARY WITH(Nolock) where thcno= '" + txtTHCNumber.Text + "'";
                    THCBR = SqlHelper.ExecuteScalar(con1, CommandType.Text, SQLTHCBR).ToString();
                    string Vno = fn.NextVoucherno(THCBR, Financial_Year);
                    con1.Close();
                    SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                    con.Open();
                    SqlTransaction trn;
                    trn = con.BeginTransaction();
                    try
                    {
                        string EntryBy = Session["empcd"].ToString();
                        string UpdateBy = Session["empcd"].ToString();


                        string Cancel_Flag = "N";
                        string sql_Check = "Select Cancelled=isnull(cancelled,'N') from  WEBX_THC_SUMMARY WITH(Nolock) where thcno= '" + txtTHCNumber.Text + "'";
                        Cancel_Flag = SqlHelper.ExecuteScalar(trn, CommandType.Text, sql_Check).ToString();

                        if (Cancel_Flag == "N")
                        {
                            string sql_update1 = "Update WEBX_TCHDR set TFlag_YN = 'N',THCBR= NULL, THCNO = NULL,THCsf = NULL, THCDT=NULL,VEHNO=NULL where THCNO ='" + txtTHCNumber.Text + "' and thcsf='.'";
                            SqlCommand cmdTCHDR = new SqlCommand(sql_update1, con, trn);
                            cmdTCHDR.ExecuteNonQuery();

                            string sql_update2 = "Update WebX_Trans_Docket_Status  SET THC = NULL,Op_Status ='Manifested generated and Available for THC'    where THC ='" + txtTHCNumber.Text + "'";
                            SqlCommand cmdDKT = new SqlCommand(sql_update2, con, trn);
                            cmdDKT.ExecuteNonQuery();

                            string sql_update3 = "Update WEBX_THC_SUMMARY set Cancelled='Y',cancelled_dt=getdate(),cancelled_by='" + EntryBy + "' where THCNO='" + txtTHCNumber.Text + "' and THCSF='.'";
                            SqlCommand cmdTHC = new SqlCommand(sql_update3, con, trn);
                            cmdTHC.ExecuteNonQuery();

                            string sql_findTripSheetNo = "Select TripSheetNo from  WEBX_THC_SUMMARY where thcno= '" + txtTHCNumber.Text + "'";
                            SqlCommand cmdTripsheet = new SqlCommand(sql_findTripSheetNo, con, trn);
                            SqlDataReader dr;
                            dr = cmdTripsheet.ExecuteReader();

                            while (dr.Read())
                            {
                                TripsheetNo = Convert.ToString(dr["TripSheetNo"]);
                            }
                            dr.Close();

                            string sql_CountTripSheetNo = "Select count(*) as Total from  WEBX_THC_SUMMARY where TripSheetNo= '" + TripsheetNo.Trim() + "'";
                            SqlCommand cmdCountTripsheet = new SqlCommand(sql_CountTripSheetNo, con, trn);
                            SqlDataReader drCount;
                            drCount = cmdCountTripsheet.ExecuteReader();

                            while (drCount.Read())
                            {
                                CountTripsheetNo = Convert.ToString(drCount["Total"]);
                            }
                            drCount.Close();

                            string sql_update4 = "";
                            SqlCommand cmdTripSheet;
                            if (Convert.ToInt32(CountTripsheetNo) > 1)
                            {
                                sql_update4 = "Update WEBX_FLEET_VEHICLE_ISSUE set THC_Attached_YN='N' where VSlipNo = (Select TripSheetNo from  WEBX_THC_SUMMARY where thcno= '" + txtTHCNumber.Text + "')";
                                cmdTripSheet = new SqlCommand(sql_update4, con, trn);
                                cmdTripSheet.ExecuteNonQuery();
                            }
                            else
                            {
                                sql_update4 = "Update WEBX_FLEET_VEHICLE_ISSUE set THC_Attached_YN=NULL where VSlipNo = (Select TripSheetNo from  WEBX_THC_SUMMARY where thcno= '" + txtTHCNumber.Text + "')";
                                cmdTripSheet = new SqlCommand(sql_update4, con, trn);
                                cmdTripSheet.ExecuteNonQuery();
                            }

                            string OwnVeh = "0";
                            string sql_Check1 = "select cnt=COUNT(*) from webx_THC_SUMMARY where VENDOR_CODE in (select VENDORCODE from webx_VENDOR_HDR where Vendor_Type='05') and thcno= '" + txtTHCNumber.Text + "'";
                            OwnVeh = SqlHelper.ExecuteScalar(trn, CommandType.Text, sql_Check1).ToString();

                            if (OwnVeh == "0")
                            {
                                string sql_Adv_acct = "exec usp_THCTransaction_THC_Cancelled 1,'" + txtTHCNumber.Text + "','.','" + Financial_Year + "','" + Session["empcd"].ToString() + "','" + Vno + "'";
                                cmd = new SqlCommand(sql_Adv_acct, con, trn);
                                cmd.ExecuteNonQuery();

                                sql_Adv_acct = "exec usp_THCTransaction_THC_Cancelled 2,'" + txtTHCNumber.Text + "','.','" + Financial_Year + "','" + Session["empcd"].ToString() + "','" + Vno + "'";
                                cmd = new SqlCommand(sql_Adv_acct, con, trn);
                                cmd.ExecuteNonQuery();

                                sql_Adv_acct = "exec usp_THCTransaction_THC_Cancelled 3,'" + txtTHCNumber.Text + "','.','" + Financial_Year + "','" + Session["empcd"].ToString() + "','" + Vno + "'";
                                cmd = new SqlCommand(sql_Adv_acct, con, trn);
                                cmd.ExecuteNonQuery();
                            }

                            //************************************************************************************
                            trn.Commit();

                            con.Close();
                        }
                    }
                    catch (Exception e1)
                    {
                        con1.Close();
                        Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : " + e1.Message + "</b></font></center>");
                        string msg = e1.Message.ToString();
                        msg = msg.Replace('\n', ' ');
                        throw e1;
                        //trn.Rollback();
                        Response.End();
                    }
                }
            }
        }
        Response.Redirect("./THC_CancellationDone.aspx?", false);

    }
}
