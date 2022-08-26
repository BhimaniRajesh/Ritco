using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class GUI_Common_UserControls_LinkedReport : System.Web.UI.UserControl
{
    public string xml_EmailParameter
    {
        get { return (ViewState["xml_EmailParameter"] != null) ? ViewState["xml_EmailParameter"].ToString() : ""; }
        set { ViewState["xml_EmailParameter"] = value; }
    }
    public string Report_URL
    {
        get { return (ViewState["Report_URL"] != null) ? ViewState["Report_URL"].ToString() : ""; ; }
        set { ViewState["Report_URL"] = value; }
    }
    public string Report_NM
    {
        get { return (ViewState["Report_NM"] != null) ? ViewState["Report_NM"].ToString() : ""; ; }
        set { ViewState["Report_NM"] = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        // btnshow.Attributes.Add("OnClick", "javascript:ShowtrlkngrptFilter();");
        txtReportName.Attributes.Add("onChange", "javascript:return CheckDuplicate(this.getAttribute('id'));");
        BtUpdSubs.Attributes.Add("OnClick", "javascript:return DateCheck();");
    }

    SqlConnection conn;
    SqlTransaction trans;

    protected void BtUpdSubs_Click(object sender, EventArgs e)
    {
        if (txtReportName.Text.ToString() != "")
        {
            try
            {
                conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                conn.Open();
                trans = conn.BeginTransaction();
                string DBnm = "";
                SqlCommand cmd12 = new SqlCommand("select db_name() ", conn, trans);
                DBnm = cmd12.ExecuteScalar().ToString();

                string sqlstr = "exec Reportserver.dbo.WebxNet_MakeLinkedReprot_New '" + Report_URL + "','" + txtReportName.Text + "','" + txtReportDesc.Text + "','" + xml_EmailParameter + "','" + DBnm + "'";
                SqlCommand cmd = new SqlCommand(sqlstr, conn, trans);
                cmd.ExecuteNonQuery();
                //conn.Close();

                if (rblstYesNo.SelectedValue == "Y")
                {
                    string strSqlGetData = "Select * From Webx_Reports_Ver1 Where Srno = (Select Max(Srno) From Webx_Reports_Ver1)";
                    SqlCommand cmdGD = new SqlCommand(strSqlGetData, conn, trans);
                    SqlDataAdapter adp = new SqlDataAdapter(cmdGD);
                    DataSet ds = new DataSet();
                    adp.Fill(ds);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        string sRepoName = ds.Tables[0].Rows[0]["Report_name"].ToString();
                        string sRepoPath = ds.Tables[0].Rows[0]["Link"].ToString();
                        string sRepoType = "SVD";
                        string sRrpoParam = "<ParameterValues></ParameterValues>";
                        string sRdate = "N";
                        string sClname = "";
                        string sActive = "Y";
                        string sFinYear = "Y";

                        string sAutomail = "Webx_AutoEmail_Setup";

                        SqlCommand cmdAutoMail = new SqlCommand(sAutomail, conn, trans);
                        cmdAutoMail.CommandType = CommandType.StoredProcedure;

                        cmdAutoMail.Parameters.Add("@ReportName", SqlDbType.VarChar, 200).Value = sRepoName.ToString().Trim();
                        cmdAutoMail.Parameters.Add("@ReportPath", SqlDbType.VarChar, 200).Value = sRepoPath.ToString().Trim();
                        cmdAutoMail.Parameters.Add("@ReportRDL", SqlDbType.VarChar, 100).Value = sRepoName.ToString().Trim();
                        cmdAutoMail.Parameters.Add("@Type", SqlDbType.VarChar, 100).Value = sRepoType.ToString().Trim();
                        cmdAutoMail.Parameters.Add("@PRMS_LIST", SqlDbType.VarChar, 500).Value = sRrpoParam.ToString().Trim();
                        cmdAutoMail.Parameters.Add("@FreeSub", SqlDbType.VarChar, 10).Value = sRdate.ToString().Trim();
                        cmdAutoMail.Parameters.Add("@CLNM", SqlDbType.VarChar, 200).Value = sClname.ToString().Trim();
                        cmdAutoMail.Parameters.Add("@ACTIVEFLAG", SqlDbType.VarChar, 10).Value = sActive.ToString().Trim();
                        cmdAutoMail.Parameters.Add("@finyear", SqlDbType.VarChar, 10).Value = sFinYear.ToString().Trim();

                        cmdAutoMail.ExecuteNonQuery();
                    }
                }
                trans.Commit();
                MsgBox.Show("Report is created successfully.");
                //trans.Rollback();
            }
            catch (Exception ex)
            {
                MsgBox.Show(ex.Message.ToString());
                trans.Rollback();
            }
            finally
            {
                conn.Close();
                txtReportName.Text = "";
                txtReportDesc.Text = "";
            }
        }
    }
}
