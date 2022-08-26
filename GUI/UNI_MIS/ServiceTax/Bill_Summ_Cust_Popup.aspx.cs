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

public partial class GUI_UNI_MIS_Bill_Summary_Bill_Summ_Cust_Popup : System.Web.UI.Page
{
    String strSQL = "";
    public int intTotalRecords = 0;
    public static byte byteQSParam;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSubmit_OnClick(object sender, EventArgs e)
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlConn.Open();

        strSQL = "SELECT DISTINCT CUSTCD, CUSTNM FROM webx_CUSTHDR WITH(NOLOCK)  where CUSTCD is not null";

        if (txtVendorCode.Value != "")
        {
            strSQL = strSQL + " and CUSTCD LIKE '" + txtVendorCode.Value.Replace("'", "''") + "%'";
        }
        else if (txtVendorName.Value != "")
        {
            strSQL = strSQL + " and CUSTNM LIKE '" + txtVendorName.Value.Replace("'", "''") + "%'";
        }

        strSQL = strSQL;

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
