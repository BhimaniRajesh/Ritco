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
    public string acccode = "",flag="";
    DataAccess DAccess = new DataAccess();
    DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        acccode = Request.QueryString["AccCode"].ToString();

        string sql = "select Accdesc from webx_acctinfo where Acccode = '" + acccode + "'";
        ds = DAccess.getdataset(sql);
        foreach (DataRow dr in ds.Tables["temp"].Rows)
        {
            lblaccountCode.Text = acccode + " : " + dr["Accdesc"].ToString();
        }

        flag = Request.QueryString["Flag"].ToString();
        
        if (flag == "new")
            Lblmsg.Text = "Following Account Code has been Successfully Added";
        else
            Lblmsg.Text = "Following Account Code has been Successfully Updated";

        //lblaccountGroup.Text = accgroup;


    }
}
