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

public partial class GUI_Finance_Bill_MR_Cancellation_Mr_Cancellation_step_2 : System.Web.UI.Page
{
    public static SqlConnection conn;
    public DataSet ds = new DataSet();
    MyFunctions fn = new MyFunctions();
    public static int intTotalRecords = 0;
    string FromDtae = "", ToDtae = "", MRStype = "", MRSNO = "", Financial_Year = "", fin_year = "";
    string id, msge;
    string totalmrsno = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        FromDtae = Request.QueryString["FromDtae"].ToString();
        ToDtae = Request.QueryString["ToDtae"].ToString();
        MRStype = Request.QueryString["MRStype"].ToString();
        MRSNO = Request.QueryString["MRSNO"].ToString();

        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        fin_year = Session["FinYear"].ToString();
        double fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');

        conn.Open();
        if (!IsPostBack)
        {
            DipsplayReport();
        }

        conn.Close();

    }
    public void DipsplayReport()
    {
        string sql = "exec USP_Bill_MR_Cancellation_Listing '" + FromDtae + "','" + ToDtae + "','MR','" + MRSNO + "','" + MRStype + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.Fill(ds);

        grvcontrols.DataSource = ds;
        grvcontrols.DataBind();

        conn.Close();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        conn.Open();
        SqlTransaction trans;
        trans = conn.BeginTransaction();

        string mrcanceldt = fn.Mydate1(txtMRdt.Text.ToString());
        string mrcancelreason = txtreson.Text.ToString();

        try
        {
            foreach (GridViewRow gr in grvcontrols.Rows)
            {
                HtmlInputCheckBox chkbox = ((HtmlInputCheckBox)gr.FindControl("chkMRno"));
                Label lblMRSno = ((Label)gr.FindControl("lblMRSno"));
                HiddenField hdnmrstype = ((HiddenField)gr.FindControl("hdnmrstype"));
                if (chkbox.Checked)
                {
                    string sql_Acctrans = "exec USP_Bill_MR_Cancellation 'MR','" + lblMRSno.Text + "','" + hdnmrstype.Value + "','" + mrcanceldt + "','" + mrcancelreason + "','" + Financial_Year + "','" + Session["empcd"].ToString() + "'";
                    SqlCommand cmd = new SqlCommand(sql_Acctrans, conn, trans);
                    cmd.ExecuteNonQuery();

                    totalmrsno += lblMRSno.Text + ",";
                }
            }
            trans.Commit();
            //trans.Rollback();
            conn.Close();
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
        Response.Redirect("Bill_Mr_Cancellation_Done.aspx?Type=MR&BillMrNos=" + totalmrsno);
    }
}
