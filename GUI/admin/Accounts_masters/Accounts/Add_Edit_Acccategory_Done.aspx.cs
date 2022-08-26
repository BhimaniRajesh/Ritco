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

public partial class GUI_admin_Accounts_masters_Acctgroup_Add_Edit_Done : System.Web.UI.Page
{
    public string Acccategory = "", flag = "", msg= "";
    DataAccess DAccess = new DataAccess();
    DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        Acccategory = Request.QueryString["Acccategory"].ToString();

        string sql = "select Acccategory,ActiveFlag from webx_Acccategory_master where Acccategory = '" + Acccategory + "'";
        ds = DAccess.getdataset(sql);

        foreach (DataRow dr in ds.Tables["temp"].Rows)
        {
            if (dr["ActiveFlag"].ToString() == "Y")
            {
                msg = "Account Category Activated";
            }
            else
            {
                msg = "Account Category Deactivated";
            }
            
            lblaccountCode.Text = Acccategory + " : " + msg;
        }

        flag = Request.QueryString["Flag"].ToString();
        
        if (flag == "new")
            Lblmsg.Text = "Following Account Category has been Successfully Added";
        else
            Lblmsg.Text = "Following Account Category has been Successfully Updated";

        //lblaccountGroup.Text = accgroup;


    }
}
