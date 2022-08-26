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
using System.Data.SqlClient;
public partial class GUI_UNI_Net_MIS_PopUp_Cust : System.Web.UI.Page
{
    public string ID = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string EntityName = "";
        if (!IsPostBack)
        {
            ID = Request.QueryString["ID"].ToString();
            QID.Value = ID;
            if (ID == "C")
            {
                EntityName = "Customer";
            }
            else if (ID == "V")
            {
                EntityName = "Vendor";
            }
            else if (ID == "E")
            {
                EntityName = "Employee";
            }
            else if (ID == "D")
            {
                EntityName = "Driver";
            }
            else if (ID == "A")
            {
                EntityName = "Account";
            }
            else if (ID == "B")
            {
                EntityName = "Bank";
            }
            else if (ID == "L" || ID == "L1" || ID == "L2")
            {
                EntityName = "Location";
            }

            SelectID1.Text = EntityName;
            SelectID2.Text = EntityName;
            SelectID4.Text = EntityName;
            SelectID5.Text = EntityName;
        }

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        ID = Request.QueryString["ID"].ToString();
        SqlConnection conn = new SqlConnection(SessionUtilities.ConnectionString);
        string custcode = txtCustCode.Text;
        string custname = txtCustName.Text;
        string sql = "";
        if (ID == "C")
        {
            sql = "SELECT  distinct CUSTCD,CUSTNM  FROM webx_CUSTHDR with(NOLOCK)  where CUST_ACTIVE='Y' and CUSTCD is not null and custcd like '%" + custcode.Trim() + "%' and custnm like '" + custname.Trim() + "%' order by CUSTNM";
        }
        else if (ID == "V")
        {
            sql = "SELECT  distinct vendorcode as CUSTCD,vendorname as CUSTNM  FROM webx_vendor_hdr with(NOLOCK)  where vendorcode is not null and vendorcode like '%" + custcode.Trim() + "%' and vendorname like '" + custname.Trim() + "%' order by vendorname";
        }
        else if (ID == "E")
        {
            sql = "SELECT  distinct userid as CUSTCD,name as CUSTNM  FROM webx_master_users with(NOLOCK)  where userid is not null and userid like '%" + custcode.Trim() + "%' and name like '" + custname.Trim() + "%' order by name";
        }
        else if (ID == "D")
        {
            sql = "SELECT  distinct convert(varchar,driver_id) as CUSTCD,driver_name as CUSTNM  FROM WEBX_FLEET_DRIVERMST with(NOLOCK)  where convert(varchar,driver_id) is not null and convert(varchar,driver_id) like '%" + custcode.Trim() + "%' and driver_name like '" + custname.Trim() + "%' order by driver_name";
        }
        else if (ID == "A")
        {
            sql = "SELECT  distinct acccode as CUSTCD,accdesc as CUSTNM  FROM webx_acctinfo with(NOLOCK)  where acccode is not null and acccode like '%" + custcode.Trim() + "%' and accdesc like '" + custname.Trim() + "%' order by accdesc";
        }
        else if (ID == "G")
        {
            sql = "SELECT  distinct acccode as CUSTCD,accdesc as CUSTNM  FROM webx_acctinfo with(NOLOCK)  where acccode is not null and acccode like '%" + custcode.Trim() + "%' and accdesc like '" + custname.Trim() + "%' order by accdesc";
        }
        else if (ID == "B")
        {
            sql = "SELECT  distinct acccode as CUSTCD,accdesc as CUSTNM  FROM webx_acctinfo with(NOLOCK)  where acccode is not null and acccode like '%" + custcode.Trim() + "%' and accdesc like '" + custname.Trim() + "%' and Acccategory='Bank' order by accdesc";
        }
        else if (ID == "L" || ID == "L1" || ID == "L2")
        {
            sql = "SELECT  distinct loccode as CUSTCD,LocName as CUSTNM  FROM webx_location with(NOLOCK)  where loccode is not null and loccode like '%" + custcode.Trim() + "%' and LocName like '" + custname.Trim() + "%' and ActiveFlag='Y' order by loccode";
        }

        conn.Open();
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dtr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        rptMain.DataSource = dtr;
        rptMain.DataBind();
        conn.Close();
    }
}
