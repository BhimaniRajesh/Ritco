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
using Microsoft.ApplicationBlocks.Data; 
public partial class UserControls_TDSPayment : System.Web.UI.UserControl
{
    string connStr;
    private string _tdsType;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            connStr = Session["SqlProvider"].ToString().Trim();
            string sql = "";

            if (TdsType == "P")
                sql = "select acccode,accdesc,acccategory from webx_acctinfo where acccode ='CLA0015'";
            else
                sql = "select acccode,accdesc,acccategory from webx_acctinfo where acccode ='CLA0014'";

            DataSet ds = SqlHelper.ExecuteDataset(connStr, CommandType.Text, sql);
            //DropDownList dlst = (DropDownList)e.FindControl("dlstAcccode");
            dlstTdsAcccode.DataSource = ds.Tables[0].DefaultView;
            dlstTdsAcccode.DataTextField = "accdesc";
            dlstTdsAcccode.DataValueField = "acccode";
            dlstTdsAcccode.DataBind();
            dlstTdsAcccode.Items.Insert(0, new ListItem("Select", ""));

            txtTdsAmt.Attributes.Add("onfocus", "javscript:this.blur();");
        }
        
    }
    public string TdsType
    {
        get
        {
            return (_tdsType);
        }
        set
        {
            _tdsType = value;
        }
    }
}
