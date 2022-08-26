using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class BillingParty_Popup : System.Web.UI.Page
{
    static string strConnection = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=ASL_LIVE;";
    String strSQL = "";
    public int intTotalRecords = 0;

    public static byte byteQSParam;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            object objQSParam = Request.QueryString;

            byteQSParam = Convert.ToByte(objQSParam.ToString());
        }

        //Set the default focus to customer code text box
        txtCustCode.Focus();
    }
    
    protected void btnSubmit_OnClick(object sender, EventArgs e)
    {
        //SqlConnection sqlConn = new SqlConnection(strConnection);

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        strSQL = "SELECT DISTINCT CUSTCD, CUSTNM FROM webx_CUSTHDR WHERE CUSTCD IS NOT NULL ";

        if (txtCustCode.Value != "")
        {
            strSQL = strSQL + " AND CUSTCD LIKE '" + txtCustCode.Value.Replace("'","''") + "%'";
        }
        else if (txtCustName.Value != "")
        {
            strSQL = strSQL + " AND CUSTNM LIKE '" + txtCustName.Value.Replace("'", "''") + "%'";
        }

        strSQL = strSQL + " ORDER BY CUSTNM";

        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();

        sqlDA.Fill(ds);

        DataTable dt = new DataTable();

        dt.Columns.Add("CustCode", typeof(string));
        dt.Columns.Add("CustName", typeof(string));

        DataRow dr;

        intTotalRecords = ds.Tables[0].Rows.Count;

        foreach (DataRow drRows in ds.Tables[0].Rows)
        {
            dr = dt.NewRow();

            dr["CustCode"] = drRows["CUSTCD"].ToString();
            dr["CustName"] = drRows["CUSTNM"].ToString();

            dt.Rows.Add(dr);
        }

        rptCustomer.DataSource = dt;
        rptCustomer.DataBind();
    }
}
