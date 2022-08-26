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

public partial class REPORT_CallRegister_SalesPersonWiseReport2 : System.Web.UI.Page
{
    public static SqlConnection conn;
    public static string strEmployee, fromdt, todt;
    public string ProspectCode, ProspectCode1,callvisit;
    function2 fn = new function2();
    protected void Page_Load(object sender, EventArgs e)
    {
        string client = Session["Client"].ToString();
        if (client == "Varuna")
        {
            callvisit = "Visit";
        }
        else
        {
            callvisit = "Call";
        }
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        fromdt = Request.QueryString["strFromDt"].ToString();
        todt = Request.QueryString["strToDt"].ToString();
        strEmployee = Request.QueryString["strEmployee"].ToString();
        //ProspectCode = Request.QueryString["ProspectCode"].ToString();
        //ProspectCode1 = Session["ProspectCode1"].ToString();

        lblCallDate.Text = fromdt + " TO " + todt;
        if (strEmployee == "")
        {
            lblSalesPerson.Text = "ALL";
        }
        else
        {
            lblSalesPerson.Text = strEmployee;// +":" + fn.GetEmployeeName(strEmployee);
        }

        BindGrid();
    }

    public void BindGrid()
    {
        conn.Open();
        string sql = "webx_callregsalespersonlist";
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
        da.SelectCommand.Parameters.Add("@employee", SqlDbType.VarChar).Value = strEmployee;

        DataSet ds = new DataSet();
        da.Fill(ds);

        DataView dv = ds.Tables[0].DefaultView;

        dgCallReg.DataSource = dv;
        dgCallReg.DataBind();

        conn.Close();
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        dgCallReg.PageIndex = e.NewPageIndex;
        BindGrid();
    }
}
