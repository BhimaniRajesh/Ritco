using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class GUI_admin_Multi_Company_Master_Company_Master_Edit : System.Web.UI.Page
{
    Company_Master Company_Details = new Company_Master();
    DataTable dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            dt = Company_Details.CompanyListing();
            if (dt.Rows.Count > 0)
            {
                Cmd_comlist.DataSource = dt;
                Cmd_comlist.DataBind();
            }
            Cmd_comlist.SelectedValue = "";
        }
        TxtCmpCode.Attributes.Add("onblur", "CompanyCode('" + TxtCmpCode.ClientID.ToString() + "')");
    }
    protected void Edit_Click(object sender, EventArgs e)
    {
        string CompanyCode = "";

        if (TxtCmpCode.Text != "")
            CompanyCode = TxtCmpCode.Text;
        else
            CompanyCode = Cmd_comlist.SelectedValue.ToString();

        string final = "Company_Master.aspx?Company_Code=" + CompanyCode;

        Response.Redirect(final, false);
    }
}
