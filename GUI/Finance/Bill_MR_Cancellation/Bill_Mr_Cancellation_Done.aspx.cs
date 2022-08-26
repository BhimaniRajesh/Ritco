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
            string Type = Request.QueryString["Type"];
            lblPageHead.Text = Type + " Cancellation Result";
            lblHeader.Text = "Following " + Type + " has been successfully Updated :";
            string[] BillMrNos = Request.QueryString["BillMrNos"].Split(',');
            string billmrsno = "";
            for (int i = 0; i < BillMrNos.Length; i++)
            {
                //AdviceNos[i] = "'" + AdviceNos[i] + "'";
                billmrsno = billmrsno + "'" + BillMrNos[i] + "',";
            }
            billmrsno = billmrsno.Substring(0, billmrsno.Length - 1).ToString();

            string strsql = "";
            if(Type == "MR")
                strsql = "select Mrsno as BillMrNO from webx_mr_hdr where Mrsno in(" + billmrsno + ")";
            if (Type == "Bill")
                strsql = "select Billno as BillMrNO from webx_billmst where Billno in(" + billmrsno + ")";
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
