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

public partial class REPORT_CallRegister_CompanywiseReport2 : System.Web.UI.Page
{
    public static SqlConnection conn;
    public static string strCompany, fromdt, todt;
    function2 fn = new function2();
    protected void Page_Load(object sender, EventArgs e)
    {
        
        fromdt = Request.QueryString["strFromDt"].ToString();
        todt = Request.QueryString["strToDt"].ToString();
        strCompany = Request.QueryString["strCompany"].ToString();

        lblCallDate.Text = fromdt + " TO " + todt;
        if (strCompany == "")
        {
            lblCompanyName.Text = "ALL";
        }
        else
        {
            lblCompanyName.Text = strCompany + ":" + fn.GetCompanyName(strCompany);
        }
        if (!IsPostBack)
        {
            conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            BindGrid();
        }
        
    }

    private void BindGrid()
    {
        
        conn.Open();
        string sql = "webx_callreg_Company";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        System.DateTime righnow = System.DateTime.Today;
        string strrightnow = righnow.ToString("dd/MM/yyyy");

        DateTime dtFrom = new DateTime();
        DateTime dtTo = new DateTime();

        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";

        {
            dtFrom = Convert.ToDateTime(fromdt, dtfi);
            dtTo = Convert.ToDateTime(todt, dtfi);
        }


        da.SelectCommand.Parameters.Add("@frmdt", SqlDbType.DateTime).Value = dtFrom;
        da.SelectCommand.Parameters.Add("@todt", SqlDbType.DateTime).Value = dtTo;
        da.SelectCommand.Parameters.Add("@company", SqlDbType.VarChar).Value = strCompany;

        DataSet ds = new DataSet();
        da.Fill(ds);

        DataView dv = ds.Tables[0].DefaultView;

        dgCallCompany.DataSource = dv;
        dgCallCompany.DataBind();

        conn.Close();
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        dgCallCompany.PageIndex = e.NewPageIndex;
        BindGrid();
    }
}
