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
public partial class GUI_Common_UserControls_CompayFilter : System.Web.UI.UserControl
{
    Company_Master CM = new Company_Master();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataTable Dt_ComList = CM.CompanyListingMappedToEmployee(SessionUtilities.CurrentEmployeeID);
           


            if (Dt_ComList.Rows.Count > 0)
            {
                ddlCompanyList.DataSource = Dt_ComList;
                ddlCompanyList.DataBind();
            }
            if (Dt_ComList.Rows.Count > 1)
            {
                ddlCompanyList.Items.Add(new ListItem("All", "All"));
                ddlCompanyList.SelectedValue = "All";
            }
            else 
            ddlCompanyList.SelectedValue = CM.DefaultCompanyMappedToEmployee(SessionUtilities.CurrentEmployeeID);
        }
    }
}
