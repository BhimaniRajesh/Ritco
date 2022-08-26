using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Finance_VendorCPKMBilling_BillGeneration_Done : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
			if( Convert.ToString(Request.QueryString.Get("Flag"))=="A")
			{
				lblTitle.Text = "Credit KMS For CPKM Approved Successfully….";
				
			}
			else if(Convert.ToString(Request.QueryString.Get("Flag"))=="R")
			{
				lblTitle.Text = "Credit KMS For CPKM Rejected Successfully….";
				
			}
				
            
            
        }
    }
}