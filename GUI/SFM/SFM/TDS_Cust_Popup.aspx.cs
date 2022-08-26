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


public partial class TDS_Cust_Popup : System.Web.UI.Page
{
    public static SqlConnection conn;
    string strSQL = "", Branch;
    public int intTotalRecords = 0;
    public static byte byteQSParam;

    protected void Page_Load(object sender, EventArgs e)
    {
        Branch = Session["brcd"].ToString();
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string scr1 = @"<script>
        function SelectCustomer(obj)
            {
            var lococde=obj.value;
            var code = lococde.split('~')

            Prospect=code[0]
            Employee=code[1]
            companyName = code[2]
            industry1 = code[3]
            AccountCategory = code[4]
            Status = code[5]

            var ProsectCompany = Prospect +':'+ companyName
            var industry = industry1
            var accCategory = AccountCategory
            var status1 = Status
            window.opener.update(ProsectCompany,Employee,industry,accCategory,status1);
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
        string employee = Session["EMPCD"].ToString();
        strSQL = "select ProspectCode,CompanyName,entryby,(select a.CodeDesc from Webx_Master_General a where a.Codetype='IND' and a.CodeId=industryCode) as Industry,AcctCategory,statesub from webx_ProspectCustomer with(NOLOCK) where ProspectCode is not null";

        conn.Open();
        string brcd = Session["brcd"].ToString();
        string q1 = "Select Loc_level,locname from webx_location where loccode='" + brcd + "'";
        SqlCommand sqlcmd1 = new SqlCommand(q1, conn);
        SqlDataReader dr;
        dr = sqlcmd1.ExecuteReader();

        dr.Read();
        int loclvl = Convert.ToInt16(dr["Loc_level"]);
        string locnm = dr["locname"].ToString();
        dr.Close();
        if (loclvl == 1)
        {
            if (txtVendorCode.Value != "")
            {
                strSQL = strSQL + " AND ProspectCode LIKE '" + txtVendorCode.Value.Replace("'", "''") + "%'";
            }
            else if (txtVendorName.Value != "")
            {
                strSQL = strSQL + " AND CompanyName LIKE '" + txtVendorName.Value.Replace("'", "''") + "%'";
            }
            strSQL = strSQL;
        }

        else if (Session["mainbrcd"].ToString().Trim() != Session["brcd"].ToString().Trim())
        {
            if (txtVendorCode.Value != "")
            {
                strSQL = strSQL + " AND ProspectCode LIKE '" + txtVendorCode.Value.Replace("'", "''") + "%'";
            }
            else if (txtVendorName.Value != "")
            {
                strSQL = strSQL + " AND CompanyName LIKE '" + txtVendorName.Value.Replace("'", "''") + "%'";
            }
            strSQL = strSQL + " AND Loccode='" + Branch + "'";
        }

        else if (Session["mainbrcd"].ToString().Trim() == Session["brcd"].ToString().Trim())
        {
            if (txtVendorCode.Value != "")
            {
                strSQL = strSQL + " AND ProspectCode LIKE '" + txtVendorCode.Value.Replace("'", "''") + "%'";
            }
            else if (txtVendorName.Value != "")
            {
                strSQL = strSQL + " AND CompanyName LIKE '" + txtVendorName.Value.Replace("'", "''") + "%'";
            }
            strSQL = strSQL  + " AND entryby='" + Session["empcd"].ToString() + "'";;
        }
        SqlCommand sqlCommand = new SqlCommand(strSQL, conn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();

        sqlDA.Fill(ds);

        DataTable dt = new DataTable();
        
        dt.Columns.Add("ProspectCode", typeof(string));
        dt.Columns.Add("CompanyName", typeof(string));
        dt.Columns.Add("entryby", typeof(string));
        dt.Columns.Add("Industry", typeof(string));
        dt.Columns.Add("AcctCategory", typeof(string));
        dt.Columns.Add("statesub", typeof(string));

        DataRow dr1;

        intTotalRecords = ds.Tables[0].Rows.Count;

        foreach (DataRow drRows in ds.Tables[0].Rows)
        {
            dr1 = dt.NewRow();

            dr1["ProspectCode"] = drRows["ProspectCode"].ToString();
            dr1["CompanyName"] = drRows["CompanyName"].ToString();
            dr1["entryby"] = drRows["entryby"].ToString();
            dr1["Industry"] = drRows["Industry"].ToString();
            dr1["AcctCategory"] = drRows["AcctCategory"].ToString();
            dr1["statesub"] = drRows["statesub"].ToString();

            dt.Rows.Add(dr1);
        }

        rptCustomer.DataSource = ds;
        rptCustomer.DataBind();     
    }
}
