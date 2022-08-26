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
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;


public partial class GUI_Admin_Vendor_contract_vendorContract_Done : System.Web.UI.Page
{
    public static string vendorCode, ContID, Flag,b;
    SqlConnection cn;
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Flag = Request.QueryString.Get("Flag");
        vendorCode = Request.QueryString.Get("vendorCode");
        ContID = Request.QueryString.Get("ContID");
        cn.Open();
        lblcontid.Text = ContID;

        string SQL_MAXSRNO1 = "select top 1 vendorname from webx_vendor_hdr where vendorcode='" + vendorCode + "'";
        SqlCommand MAXSRNO1 = new SqlCommand(SQL_MAXSRNO1, cn);

        b = Convert.ToString(MAXSRNO1.ExecuteScalar());

        if (Flag == "Y")
        {
            lblstatus.Text = "Updated. ";
        }
        else
        {
            lblstatus.Text = "Generated. ";
        }

        lblvendor.Text = vendorCode + " : " + b;

        cn.Close();


    }
}
