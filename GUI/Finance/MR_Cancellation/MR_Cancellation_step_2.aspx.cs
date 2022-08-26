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

public partial class GUI_Finance_Bill_MR_Cancellation_Mr_Cancellation_step_2 : System.Web.UI.Page
{   
    MyFunctions fn = new MyFunctions();
    string FromDtae = "", ToDtae = "", MRStype = "", MRSNO = "", Financial_Year = "", fin_year = "";
    string id, msge;
    string totalmrsno = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        FromDtae = Request.QueryString["FromDtae"].ToString();
        ToDtae = Request.QueryString["ToDtae"].ToString();
        MRStype = Request.QueryString["MRStype"].ToString();
        MRSNO = Request.QueryString["MRSNO"].ToString();

        Financial_Year = Session["FinYear"].ToString();
        fin_year = Session["FinYear"].ToString();
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');

        if (!IsPostBack)
        {
            DipsplayReport();
        }
    }
    public void DipsplayReport()
    {
        string sql = "exec USP_MR_Cancellation_Listing 'MR','" + FromDtae + "','" + ToDtae + "','" + MRSNO + "','" + MRStype + "','" + SessionUtilities.FinYear.ToString() + "'";
        DataTable dtl = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sql).Tables[0];

        if (dtl.Rows.Count > 0)
        {
            grvcontrols.DataSource = dtl;
            grvcontrols.DataBind();
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        SqlTransaction trans;
        trans = conn.BeginTransaction();

        string mrcanceldt = fn.Mydate1(txtMRdt.Text.ToString());
        string mrcancelreason = txtreson.Text.ToString();
        Financial_Year = Session["FinYear"].ToString();

        try
        {
            foreach (GridViewRow gr in grvcontrols.Rows)
            {
                HtmlInputCheckBox chkbox = ((HtmlInputCheckBox)gr.FindControl("chkMRno"));
                Label lblMRSno = ((Label)gr.FindControl("lblMRSno"));
                HiddenField hdnmrstype = ((HiddenField)gr.FindControl("hdnmrstype"));
                if (chkbox.Checked)
                {
                    string sql_Acctrans = "exec USP_MR_Cancellation '" + lblMRSno.Text + "','" + mrcanceldt + "','" + mrcancelreason + "','" + Financial_Year + "','" + Session["empcd"].ToString() + "'";
                    SqlHelper.ExecuteNonQuery(trans, CommandType.Text, sql_Acctrans);
                    totalmrsno += lblMRSno.Text + ",";
                }
            }
            trans.Commit();
            totalmrsno = totalmrsno.Substring(0, totalmrsno.Length - 1).ToString();
        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : " + e1.Message + "</b></font></center>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            trans.Rollback();
            Response.Redirect("Message.aspx?" + e1.Message);
            Response.End();
        }

        conn.Close();
        Response.Redirect("MR_Cancellation_Done.aspx?Type=MR&BillMrNos=" + totalmrsno);
    }
}
