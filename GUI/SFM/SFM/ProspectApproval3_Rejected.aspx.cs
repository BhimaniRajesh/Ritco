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

public partial class SFM_ProspectApproval3_Rejected : System.Web.UI.Page
{
    public static SqlConnection conn;
    public string prospect;

    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!IsPostBack)
        {
            prospect = Request.QueryString["prospect"].ToString();
            BindGrid();
        }
    }
    private void BindGrid()
    {
        conn.Open();
        string sql = "select ProspectCode,companyName,convert(varchar,RegisterDt,106) as RegisterDt,LastVisitDt,entryby,(select a.CodeDesc from Webx_Master_General a where a.Codetype='IND' and a.CodeId=industryCode) as industryCode,compCity,contPerson,acctCategory,companyStatus,comment,statesub,CustCode,ReasonforReject from webx_ProspectCustomer where ProspectCode in ('" + prospect + "') and CustCode is not null  order by CompanyName";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        DataSet ds = new DataSet();
        da.Fill(ds);

        DataView dv = ds.Tables[0].DefaultView;

        ProspectRejected.DataSource = dv;
        ProspectRejected.DataBind();

        conn.Close();
    }
}
