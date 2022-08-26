using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data.OleDb;
using System.Data.Odbc;
using System.Configuration;
public partial class GUI_Fleet_Reports_Trip_Query : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        hdnRptId.Value = Request.QueryString["RPTID"].ToString();
        //dtBookingDate.EnableTillDate = true;
    }

   
}