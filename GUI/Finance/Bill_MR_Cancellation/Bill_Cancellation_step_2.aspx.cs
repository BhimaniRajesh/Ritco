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

public partial class GUI_Finance_Bill_MR_Cancellation_Bill_Cancellation_step_2 : System.Web.UI.Page
{
    public static SqlConnection conn;
    public DataSet ds = new DataSet();
    MyFunctions fn = new MyFunctions();
    public static int intTotalRecords = 0;
    string FromDtae = "", ToDtae = "", Billtype = "", BillNO = "", Financial_Year = "", fin_year = "";
    string id, msge;
    string totalbillno = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        FromDtae = Request.QueryString["FromDtae"].ToString();
        ToDtae = Request.QueryString["ToDtae"].ToString();
        Billtype = Request.QueryString["Billtype"].ToString();
        BillNO = Request.QueryString["BillNO"].ToString();

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
        string sql = "exec USP_Bill_MR_Cancellation_Listing '" + FromDtae + "','" + ToDtae + "','Bill','" + BillNO + "','" + Billtype + "'";
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

        string mrcanceldt = fn.Mydate1(txtbilldt.Text.ToString());
        string mrcancelreason = txtreson.Text.ToString();

        try
        {
            foreach (GridViewRow gr in grvcontrols.Rows)
            {
                HtmlInputCheckBox chkbox = ((HtmlInputCheckBox)gr.FindControl("chkbillno"));
                Label lblbillno = ((Label)gr.FindControl("lblbillno"));
                HiddenField hdnbilltype = ((HiddenField)gr.FindControl("hdnbilltype"));
                if (chkbox.Checked)
                {
                    string sql_Acctrans = "exec USP_Bill_MR_Cancellation 'Bill','" + lblbillno.Text + "','" + hdnbilltype.Value + "','" + mrcanceldt + "','" + mrcancelreason + "','" + Financial_Year + "','" + Session["empcd"].ToString() + "'";
                    SqlCommand cmd = new SqlCommand(sql_Acctrans, conn, trans);
                    cmd.ExecuteNonQuery();

                    totalbillno += lblbillno.Text + ",";
                }
            }
            trans.Commit();
            //trans.Rollback();
            conn.Close();
            totalbillno = totalbillno.Substring(0, totalbillno.Length - 1).ToString();
        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : " + e1.Message + "</b></font></center>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            trans.Rollback();
            Response.Redirect("Message.aspx?" + msg);
            Response.End();
        }

        Response.Redirect("Bill_Mr_Cancellation_Done.aspx?Type=Bill&BillMrNos=" + totalbillno);
    }
}
