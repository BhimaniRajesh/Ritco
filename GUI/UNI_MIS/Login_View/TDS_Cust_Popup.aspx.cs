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

public partial class GUI_UNI_MIS_TDS_STMT_TDS_Cust_Popup : System.Web.UI.Page
{
    String strSQL = "";
    public int intTotalRecords = 0;
    public static byte byteQSParam;

    protected void Page_Load(object sender, EventArgs e)
    {
        string scr = @"<script>
        function SelectCustomer(obj)
            {
            var lococde=obj.value;
            window.opener.update(lococde);
            window.close();
            }
            </script>;";
        Page.RegisterClientScriptBlock("SelectCustomer", scr);

        if (!IsPostBack)
        {
        }
        txtVendorCode.Focus();
        
    }
    protected void btnSubmit_OnClick(object sender, EventArgs e)
    {
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        strSQL = "SELECT DISTINCT loccode, locname FROM webx_Location where activeflag='Y'";

        if (txtVendorCode.Value != "")
        {
            strSQL = strSQL + " AND loccode LIKE '" + txtVendorCode.Value.Replace("'", "''") + "%'";
        }
        else if (txtVendorName.Value != "")
        {
            strSQL = strSQL + " AND locname LIKE '" + txtVendorName.Value.Replace("'", "''") + "%'";
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

            dr["CustCode"] = drRows["loccode"].ToString();
            dr["CustName"] = drRows["locname"].ToString();

            dt.Rows.Add(dr);
        }

        rptCustomer.DataSource = dt;
        rptCustomer.DataBind();     
    }
}
