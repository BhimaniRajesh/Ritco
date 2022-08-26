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
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;

public partial class octroi_OctCustBillStep2 : System.Web.UI.Page
{
  
    
 

    protected void Page_Load(object sender, EventArgs e)
    {

        string Chqno = Request.QueryString["Chqno"].ToString();
        string Chqdate = Request.QueryString["ChqDate"].ToString();
        LblChqno.Text = Chqno;
        LblChqdate.Text = Chqdate;  


    }
    }

     

