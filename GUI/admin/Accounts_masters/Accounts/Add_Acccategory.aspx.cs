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
using Microsoft.ApplicationBlocks.Data;
using System.Data.SqlClient;

public partial class GUI_admin_Accounts_masters_Accounts_Add_Acccategory : System.Web.UI.Page
{
    string Acccategory = "",srno = "";
    DataAccess DAccess = new DataAccess();
    DataSet ds = new DataSet();
    DataTable dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Acccategory = Request.QueryString["Data"].ToString();
            if (Acccategory != "new")
            {
                loadData();
            }
        }
        string str = "";
        if (Acccategory != "new")
        {
            Acccategory = Request.QueryString["Data"].ToString();
            txtAcccategory.Attributes.Add("onblur", "CheckCategory('" + txtAcccategory.ClientID.ToString() + "','" + Acccategory + "','edit')");

        }
        if (Acccategory == "new")
        {
            Acccategory = "new";
            txtAcccategory.Attributes.Add("onblur", "CheckCategory('" + txtAcccategory.ClientID.ToString() + "','" + Acccategory + "','new')");
        }
    }
    public void loadData()
    {
        Acccategory = Request.QueryString["Data"].ToString();
        string str = "select * from webx_Acccategory_master where Acccategory='" + Acccategory + "'";
        ds = DAccess.getdataset(str);
        foreach (DataRow dr in ds.Tables["temp"].Rows)
        {
            Acccategory = dr["Acccategory"].ToString();
            srno = dr["srno"].ToString();

            if (dr["ActiveFlag"].ToString() == "Y")
                chkActiveflag.Checked = true;
            else
                chkActiveflag.Checked = false;

            txtAcccategory.Text = Acccategory;
        }
    }
    protected void btnsubmit(object sender, EventArgs e)
    {
        Acccategory = Request.QueryString["Data"].ToString();
        string check = "";

        if (chkActiveflag.Checked == true)
        {
            check = "Y";
        }
        else
        {
            check = "N";
        }
        if (Acccategory == "new")
        {
            string srno = "";
            Hashtable MyHT = new Hashtable();
            MyHT.Add("srno", srno);
            MyHT.Add("Acccategory", txtAcccategory.Text);
            MyHT.Add("ActiveFlag", check);
            string r_val = DAccess.insertQuary_New("usp_Add_Edit_Account_Category", MyHT);
            if (r_val != "0")
            {
                Server.Transfer("../Error/ErrorPage.aspx?PageHead='Account Category Code Insert'&ErrorMsg=" + r_val, true);
            }
            else
            {
                Response.Redirect("Add_Edit_Acccategory_Done.aspx?flag=new&Acccategory=" + txtAcccategory.Text, true);
            }
        }
        else
        {
            string srno = Convert.ToString(SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "select srno from webx_Acccategory_master where Acccategory='" + Acccategory + "'"));
            Hashtable MyHT = new Hashtable();
            MyHT.Add("srno", srno);
            MyHT.Add("Acccategory", txtAcccategory.Text);
            MyHT.Add("ActiveFlag", check);
            string r_val = DAccess.insertQuary_New("usp_Add_Edit_Account_Category", MyHT);
            if (r_val != "0")
            {
                Server.Transfer("../Error/ErrorPage.aspx?PageHead='Account Category Code Insert'&ErrorMsg=" + r_val, true);
            }
            else
            {
                Response.Redirect("Add_Edit_Acccategory_Done.aspx?flag=old&Acccategory=" + txtAcccategory.Text, true);
            }
        }
    }
}
