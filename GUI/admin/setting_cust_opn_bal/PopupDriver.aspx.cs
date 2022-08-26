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
        string sql = "SELECT Driver_id,Manual_Driver_Code,Driver_Name FROM WEBX_FLEET_DRIVERMST WITH(NOLOCK) where Manual_Driver_Code is not null and Manual_Driver_Code like'" + custcode + "%' and Driver_Name Like '" + custname + "%' and PATINDEx ('%" + branch + "%',Driver_Location)>0 order by Driver_Name";
        conn.Open();
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dtr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        DataList1.DataSource = dtr;
        DataList1.DataBind();
        conn.Close();

        /*

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string loccls = "", destcls = "";
        if (txtDriverCode.Value != "")
        {
            loccls = " AND Manual_Driver_Code LIKE '" + txtDriverCode.Value.Replace("'", "''") + "%'";
        }
        else if (txtDriverName.Value != "")
        {
            destcls = " AND Driver_Name LIKE '" + txtDriverName.Value.Replace("'", "''") + "%'";
        }
        strSQL = "SELECT Driver_id,Manual_Driver_Code,Driver_Name  FROM WEBX_FLEET_DRIVERMST  where Manual_Driver_Code is not null " + loccls + destcls + "  and PATINDEx ('%" + branch + "%',Driver_Location)>0  order by Driver_Name";

        conn.Open();

        SqlCommand sqlCommand = new SqlCommand(strSQL, conn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();

        sqlDA.Fill(ds);

        DataTable dt = new DataTable();

        dt.Columns.Add("Driver_id", typeof(string));
        dt.Columns.Add("Manual_Driver_Code", typeof(string));
        dt.Columns.Add("Driver_Name", typeof(string));
        DataRow dr;

        intTotalRecords = ds.Tables[0].Rows.Count;

        foreach (DataRow drRows in ds.Tables[0].Rows)
        {
            dr = dt.NewRow();

            dr["Driver_id"] = drRows["Driver_id"].ToString();
            dr["Manual_Driver_Code"] = drRows["Manual_Driver_Code"].ToString();
            dr["Driver_Name"] = drRows["Driver_Name"].ToString();

            dt.Rows.Add(dr);
        }

        rptDriver.DataSource = dt;
        rptDriver.DataBind();
        
        */ 
    }
}
