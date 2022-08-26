using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_UNI_NET_MIS_MISFuelPointsReport_Query : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        string final;
        final = "Result.aspx?fromdt=" + DT.DateFrom.ToString("dd MMM yyyy");
        final += "&todt=" + DT.DateTo.ToString("dd MMM yyyy");



        // Response.Redirect("Result.aspx" + final);

        Page.RegisterStartupScript("Ericsson Register Report", @"<script language='JavaScript' type='text/javascript'>window.open('" + final + "', '_blank', 'menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800 ,height=600,status=no,left=60,top=50');</script>");
    }
}