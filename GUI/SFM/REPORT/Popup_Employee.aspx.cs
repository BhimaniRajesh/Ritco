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

public partial class REPORT_Popup_Employee : System.Web.UI.Page
{
    public static SqlConnection conn;
    String strSQL = "";
    public int intTotalRecords = 0;
    public static byte byteQSParam;

    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string scr1 = @"<script>
        function SelectCustomer(obj)
            {
            var lococde=obj.value;
            window.opener.update1(lococde);
            window.close();
            }
            </script>;";
        Page.RegisterClientScriptBlock("SelectCustomer", scr1);

        if (!IsPostBack)
        {
        }
        txtVendorCode.Focus();
    }
    protected void btnSubmit_OnClick(object sender, EventArgs e)
    {
        strSQL = "select UserId,Name from WebX_Master_Users where UserId is not null";

        conn.Open();

        if (txtVendorCode.Value != "")
        {
            strSQL = strSQL + " AND  UserId LIKE '" + txtVendorCode.Value.Replace("'", "''") + "%'";
        }
        else if (txtVendorName.Value != "")
        {
            strSQL = strSQL + " AND  Name LIKE '" + txtVendorName.Value.Replace("'", "''") + "%'";
        }

        strSQL = strSQL;

        SqlCommand sqlCommand = new SqlCommand(strSQL, conn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();

        sqlDA.Fill(ds);

        DataTable dt = new DataTable();

        dt.Columns.Add("UserId", typeof(string));
        dt.Columns.Add("Name", typeof(string));

        DataRow dr;

        intTotalRecords = ds.Tables[0].Rows.Count;

        foreach (DataRow drRows in ds.Tables[0].Rows)
        {
            dr = dt.NewRow();

            dr["UserId"] = drRows["UserId"].ToString();
            dr["Name"] = drRows["Name"].ToString();

            dt.Rows.Add(dr);
        }

        rptCustomer.DataSource = dt;
        rptCustomer.DataBind();
    }
}
