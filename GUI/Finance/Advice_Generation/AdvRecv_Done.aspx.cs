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

public partial class GUI_finance_advice_AdvRecv_Done : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand cmd;
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        if (!Page.IsPostBack)
        {
            string[] AdviceNos = Request.QueryString["AdviceNo"].Split(',');
            string advnos = "";
            for (int i = 0; i < AdviceNos.Length; i++)
            {
                //AdviceNos[i] = "'" + AdviceNos[i] + "'";
                advnos = advnos + "'" + AdviceNos[i] + "',";
            }
            advnos = advnos.Substring(0, advnos.Length - 1).ToString();

            string strsql = "select AdviceNo from webx_advice_hdr where adviceno in(" + advnos + ")";
            cmd = new SqlCommand(strsql, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            dgGeneral.DataSource = ds;
            dgGeneral.DataBind();
            
            //string AdviceType = "Advice";
            //lblDocNameVal.Text = AdviceType;
            //lblDocNoVal.Text = AdviceNo;
        }
    }
}
