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
    public string accgroup = "",flag="";
    DataAccess DAccess = new DataAccess();
    DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        accgroup = Request.QueryString["GroupCode"].ToString();

        string sql = "select Groupdesc from webx_groups where Groupcode = '" + accgroup + "'";
        ds = DAccess.getdataset(sql);
        foreach (DataRow dr in ds.Tables["temp"].Rows)
        {
            lblaccountGroup.Text = accgroup + " : " + dr["Groupdesc"].ToString();
        }

        flag = Request.QueryString["Flag"].ToString();
        
        if (flag == "new")
            Lblmsg.Text = "Following Account Group has been Successfully Added";
        else
            Lblmsg.Text = "Following Account Group has been Successfully Updated";

        //lblaccountGroup.Text = accgroup;


    }
}
