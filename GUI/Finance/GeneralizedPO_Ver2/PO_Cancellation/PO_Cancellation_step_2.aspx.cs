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

public partial class GUI_Finance_Bill_MR_Cancellation_Bill_Cancellation_step_2 : System.Web.UI.Page
{   
    MyFunctions fn = new MyFunctions();
    public static int intTotalRecords = 0;
    string FromDtae = "", ToDtae = "", ManualPONO = "", PONO = "", Financial_Year = "", fin_year = "";
    string id, msge;
    string totalPOno = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        MsgBox.Hide();
        FromDtae = Request.QueryString["FromDtae"].ToString();
        ToDtae = Request.QueryString["ToDtae"].ToString();
        ManualPONO = Request.QueryString["ManualPONO"].ToString();
        PONO = Request.QueryString["PONO"].ToString();

        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        fin_year = Session["FinYear"].ToString();
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');

        if (PONO != "")
        {
            FromDtae = "01 Apr " + Financial_Year;
            ToDtae = "31 Mar " + fin_year_next.ToString().PadLeft(2, '0');
        }
        if (!IsPostBack)
        {
            DipsplayReport();
        }
    }
    public void DipsplayReport()
    {
        string sql = "exec USP_POEntry_Listing_Ver1 '" + FromDtae + "','" + ToDtae + "','" + PONO + "','" + ManualPONO + "','" + Session["FinYear"].ToString() + "'";
        //Response.Write("sql : " + sql);
        //Response.End();
        DataTable Dtl = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sql).Tables[0];
        if (Dtl.Rows.Count > 0)
        {
            grvcontrols.DataSource = Dtl;
            grvcontrols.DataBind();
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        bool IsCommited = false;

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        SqlTransaction trans;
        trans = conn.BeginTransaction();

        string POcanceldt = fn.Mydate1(txtcandt.Text.ToString());
        string POcancelreason = txtreson.Text.ToString();

        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        try
        {
            foreach (GridViewRow gr in grvcontrols.Rows)
            {
                HtmlInputCheckBox chkbox = ((HtmlInputCheckBox)gr.FindControl("chkPOno"));
                Label lblPono = ((Label)gr.FindControl("lblPono"));
                if (chkbox.Checked)
                {
                    string Checkqry = "select count(*) from webx_GENERAL_POASSET_HDR where isnull(cancelled,'N')='N' and pocode='" + lblPono.Text + "'";
                    double count = Convert.ToDouble(SqlHelper.ExecuteScalar(trans, CommandType.Text, Checkqry));

                    if (count>0)
                    {
                        string sql_Acctrans = "exec USP_POEntry_Cancellation '" + lblPono.Text + "','" + POcanceldt + "','" + POcancelreason + "','" + SessionUtilities.CurrentEmployeeID.ToString() + "','" + Session["FinYear"].ToString() + "'";
                        SqlCommand cmd = new SqlCommand(sql_Acctrans, conn, trans);
                        cmd.ExecuteNonQuery();
                    }
                    else
                    {
                        throw new Exception("You Cant Cancel Purchase Order Becuase Same Purchase Order Already Cancelled");
                    }
                    totalPOno += lblPono.Text + ",";
                }
            }
            trans.Commit();
            //trans.Rollback();
            totalPOno = totalPOno.Substring(0, totalPOno.Length - 1).ToString();
            IsCommited = true;
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
        Response.Redirect("PO_Cancellation_Done.aspx?Type=PO&PONos=" + totalPOno);
    }
}
