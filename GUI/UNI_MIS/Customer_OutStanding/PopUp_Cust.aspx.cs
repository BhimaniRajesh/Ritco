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

public partial class GUI_UNI_Net_MIS_PopUp_Cust : System.Web.UI.Page
{
    DateFunction Daccess = new DateFunction();
    SqlDataReader dtr;
    public string ID = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            ID = Request.QueryString["ID"].ToString();
            QID.Value = ID;
            if (ID == "C")
            {
                SelectID.Text =  "Customer";
                SelectID1.Text = "Customer";
                SelectID2.Text = "Customer";
                SelectID3.Text = "Customer";
                SelectID4.Text = "Customer";
                SelectID5.Text = "Customer";
            }
            else if (ID == "V")
            {
                SelectID.Text =  "Vendor";
                SelectID1.Text = "Vendor";
                SelectID2.Text = "Vendor";
                SelectID4.Text = "Vendor";
                SelectID3.Text = "Vendor";
                SelectID5.Text = "Vendor";
            }
            else if (ID == "E")
            {
                SelectID.Text =  "Employee";
                SelectID1.Text = "Employee";
                SelectID2.Text = "Employee";
                SelectID4.Text = "Employee";
                SelectID3.Text = "Employee";
                SelectID5.Text = "Employee";
            }
            else if (ID == "D")
            {
                SelectID.Text =  "Driver";
                SelectID1.Text = "Driver";
                SelectID2.Text = "Driver";
                SelectID4.Text = "Driver";
                SelectID3.Text = "Driver";
                SelectID5.Text = "Driver";
            }
            else if (ID == "A")
            {
                SelectID.Text =  "Account";
                SelectID1.Text = "Account";
                SelectID2.Text = "Account";
                SelectID4.Text = "Account";
                SelectID3.Text = "Account";
                SelectID5.Text = "Account";
            }
            else if (ID == "B")
            {
                SelectID.Text =  "Bank";
                SelectID1.Text = "Bank";
                SelectID2.Text = "Bank";
                SelectID4.Text = "Bank";
                SelectID3.Text = "Bank";
                SelectID5.Text = "Bank";
            }
            else if (ID == "L" || ID == "L1" || ID == "L2")
            {
                SelectID.Text =  "Location";
                SelectID1.Text = "Location";
                SelectID2.Text = "Location";
                SelectID4.Text = "Location";
                SelectID3.Text = "Location";
                SelectID5.Text = "Location";
            }
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        }

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        ID = Request.QueryString["ID"].ToString();
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string custcode = txtCustCode.Text;
        string custname = txtCustName.Text;
        string sql = "";
        if (ID == "C")
        {
            sql = "SELECT  distinct CUSTCD,CUSTNM  FROM webx_CUSTHDR with(NOLOCK)  where CUSTCD is not null and custcd like '%" + custcode.Trim() + "%' and custnm like '" + custname.Trim() + "%' order by CUSTNM";
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
        dtr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        DataList1.DataSource = dtr;
        DataList1.DataBind();
        conn.Close();
    }
}
