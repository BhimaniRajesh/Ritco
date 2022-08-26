using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_admin_FuelSlipMaster_TripSheetValidationDone : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            if(Request.QueryString["Flag"].ToString()=="Add")
            {
                lblMsg.Text = "Validation Form Added Successfully.";
            }
            else if (Request.QueryString["Flag"].ToString() == "Edit")
                {
                    lblMsg.Text = "Validation Form Edited Successfully.";
                }
        }
    }
}