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

public partial class GUI_admin_setting_cust_opn_bal_PopupCustomer : System.Web.UI.Page
{
    String strSQL = "";
    public int intTotalRecords = 0;
    public static byte byteQSParam;
    public static string branch = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        branch = Convert.ToString(Request.QueryString["branch"]);
        if (!IsPostBack)
        {  
        }
        txtVendorCode.Focus();
    }
    protected void btnSubmit_OnClick(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string custcode = txtVendorCode.Value;
        string custname = txtVendorName.Value;
        string sql = "SELECT  distinct CUSTCD,CUSTNM  FROM webx_CUSTHDR where cust_active='Y' and CUSTCD like'" + custcode + "%' and CUSTNM Like '" + custname + "%' and PATINDEx ('%" + branch + "%',custloc)>0 order by CUSTNM";
        conn.Open();
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dtr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        DataList1.DataSource = dtr;
        DataList1.DataBind();
        conn.Close();

        /*

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string loccls = "", destcls = "";
        if (txtVendorCode.Value != "")
        {
            loccls = " AND CUSTCD LIKE '" + txtVendorCode.Value.Replace("'", "''") + "%'";
        }
        else if (txtVendorName.Value != "")
        {
            destcls = " AND CUSTNM LIKE '" + txtVendorName.Value.Replace("'", "''") + "%'";
        }
        strSQL = "SELECT  distinct CUSTCD,CUSTNM  FROM webx_CUSTHDR  where CUSTCD is not null " + loccls + destcls + "  and PATINDEx ('%" + branch + "%',custloc)>0  order by CUSTNM";

        conn.Open();


        


        SqlCommand sqlCommand = new SqlCommand(strSQL, conn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();

        sqlDA.Fill(ds);

        DataTable dt = new DataTable();

        dt.Columns.Add("CUSTCD", typeof(string));
        dt.Columns.Add("CUSTNM", typeof(string));

        DataRow dr;

        intTotalRecords = ds.Tables[0].Rows.Count;

        foreach (DataRow drRows in ds.Tables[0].Rows)
        {
            dr = dt.NewRow();

            dr["CUSTCD"] = drRows["CUSTCD"].ToString();
            dr["CUSTNM"] = drRows["CUSTNM"].ToString();

            dt.Rows.Add(dr);
        }

        rptCustomer.DataSource = dt;
        rptCustomer.DataBind();
        
        */ 
    }
}
