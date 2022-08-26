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

public partial class GUI_Finance_MoneyRecipt_MR_DocketDetail : System.Web.UI.Page
{

    string Mrsno = "", Billno = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        Mrsno = Convert.ToString(Request.QueryString["Mrsno"]);
        Billno = Convert.ToString(Request.QueryString["Billno"]);
        Lbl_Title.Text = "DOcket Details For Collection Of Bill No - <b>" + Billno + "</b> And Bill's MRsNo - <b>" + Mrsno + "</b>";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string Sql = "exec Webx_MR_View_Detail '" + Mrsno + "','" + Billno + "'";
        SqlDataAdapter da = new SqlDataAdapter(Sql, conn);
        DataSet ds = new DataSet();
        da.Fill(ds, "MR");

        GrdPaidFollow.DataSource = ds.Tables["MR"];
        GrdPaidFollow.DataBind();
    }
    protected void GrdPaidFollow_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
}
