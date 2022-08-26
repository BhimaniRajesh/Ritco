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

public partial class Finance_Billing_Billsubmission_start : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void ButSubmit_Click(object sender, EventArgs e)
    {
        if (RD_Process_STN.Checked==true)
        {
            Response.Redirect("GRNSTNCriteria.aspx");
        }
        else if (RD_Process_PO.Checked == true)
        {
            Response.Redirect("GRNCriteria.aspx");
        }
        else if (RD_Process_SKU.Checked == true)
        {
            Response.Redirect("~/GUI/Finance/GeneralizedPO_Ver2/GRNGeneration/start.aspx");
        }
    }
}
