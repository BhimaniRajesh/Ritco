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

public partial class GUI_admin_Accounts_masters_Accounts_Account_Add_PopUp : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    DataAccess DAccess  = new DataAccess();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public void Change_Group(object sender, EventArgs e)
    {
        string str = "select Parentcode,Groupdesc + ' : ' + Company_Groupcode as Groupdesc,Groupdesc as GroupdescMain from webx_groups where Grouplevel='2' and Parentcode='" + dlstCategory.SelectedItem.Value + "' Order by GroupdescMain";
        ds = DAccess.getdataset(str);
        dlstGroup.DataSource = ds;
        dlstGroup.DataValueField = "Parentcode";
        dlstGroup.DataTextField = "Groupdesc";
        dlstGroup.DataBind();
        dlstGroup.Items.Insert(0, "Select");
        dlstGroup.Items[0].Text = "Select";
        dlstGroup.Items[0].Selected = true;
    }
}
