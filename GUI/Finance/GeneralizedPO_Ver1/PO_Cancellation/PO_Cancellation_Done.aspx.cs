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

            string[] POMrNos = Request.QueryString["PONos"].Split(',');
            string POmrsno = "";

            for (int i = 0; i < POMrNos.Length; i++)
            {
                //AdviceNos[i] = "'" + AdviceNos[i] + "'";
                POmrsno = POmrsno + "'" + POMrNos[i] + "',";
            }
            POmrsno = POmrsno.Substring(0, POmrsno.Length - 1).ToString();

            string strsql = "";
            if (Type == "PO")
            {
                strsql = "select pocode as POMrNO from webx_GENERAL_POASSET_HDR where pocode in(" + POmrsno + ")";
            }

            cmd = new SqlCommand(strsql, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            dgGeneral.DataSource = ds;
            dgGeneral.DataBind();
        }
    }
}
