using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_admin_HCLMaster_HCLMasterDone : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["Flag"] == "Edit")
        {
            lblDisplay.Text = "HCL Master Successfully Updated.";
        }
        else if (Request.QueryString["Flag"] == "Add")
        {
            lblDisplay.Text = "HCL Master Successfully Added.";
        }
    }
}