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
using System.Data.SqlClient;
using System.Text;
using System.IO;
using Microsoft.Reporting.WebForms;

public partial class GUI_Fleet_Reports_TruckProfit_Query : System.Web.UI.Page
{
    protected void Page_Load(object sender, System.EventArgs e)
    {
        hdnRptId.Value = Request.QueryString["RPTID"].ToString(); // added by Manisha 20/5/2014


    }

    //protected void btnSubmit_Click(object sender, EventArgs e)
    //{
    //    string final;

    //    final = "Result.aspx?VEHNO=" + txtVehicleNo.Text.ToString().Trim();
    //    final += "&FROMDT=" + DT.DateFrom.ToString("dd MMM yyyy");
    //    final += "&TODT=" + DT.DateTo.ToString("dd MMM yyyy");

    //    Page.RegisterStartupScript("DocumentSeriesControl", @"<script language='JavaScript' type='text/javascript'>window.open('" + final + "', '_blank', 'menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800 ,height=600,status=no,left=60,top=50');</script>");

    //}
  
}
