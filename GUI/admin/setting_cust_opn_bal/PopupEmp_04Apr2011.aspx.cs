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

public partial class GUI_admin_setting_cust_opn_bal_PopupVendor : System.Web.UI.Page
{
    String strSQL = "";
    public int intTotalRecords = 0;
    public static byte byteQSParam;
    public static string branch = "",vendortype="";
    protected void Page_Load(object sender, EventArgs e)
    {

        branch = Convert.ToString(Request.QueryString["branch"]);
        //vendortype = Convert.ToString(Request.QueryString["Vendortype"]);
       // string[] vendortype_arr = Request.QueryString["Vendortype"].Split('~');
      //  vendortype = vendortype_arr[0].ToString();
        string scr1 = @"<script>
        function SelectEmp(obj)
            {
            var lococde=obj.value;
            var code = lococde
            EmpCode=code
            window.opener.update4(EmpCode);
            window.close();
            }
            </script>;";
        Page.RegisterClientScriptBlock("SelectEmp", scr1);

        if (!IsPostBack)
        {
        }

        txtEmpCode.Focus();
    }//select vendorcode,vendorname from webx_VENDOR_HDR order by vendorname
    protected void btnSubmit_OnClick(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string loccls = "", destcls = "";
        if (txtEmpCode.Value != "")
        {
            loccls = " AND a.userid LIKE '" + txtEmpCode.Value.Replace("'", "''") + "%'";
        }
        else if (txtEmpName.Value != "")
        {
            destcls = " AND a.name LIKE '" + txtEmpName.Value.Replace("'", "''") + "%'";
        }
        strSQL = "SELECT  distinct a.userid,name  FROM webx_Master_Users a WITH(NOLOCK)    where a.userid is not null " + loccls + destcls + "     order by name";

        conn.Open();

        SqlCommand sqlCommand = new SqlCommand(strSQL, conn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();

        sqlDA.Fill(ds);

        DataTable dt = new DataTable();

        dt.Columns.Add("userid", typeof(string));
        dt.Columns.Add("name", typeof(string));

        DataRow dr;

        intTotalRecords = ds.Tables[0].Rows.Count;

        foreach (DataRow drRows in ds.Tables[0].Rows)
        {
            dr = dt.NewRow();

            dr["userid"] = drRows["userid"].ToString();
            dr["name"] = drRows["name"].ToString();

            dt.Rows.Add(dr);
        }

        rptEmployee.DataSource = dt;
        rptEmployee.DataBind();
    }
}
