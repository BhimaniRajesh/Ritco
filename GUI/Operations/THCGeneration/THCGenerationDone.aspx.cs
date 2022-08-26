using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Operations_THCGeneration_THCGenerationDone : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblHeader.Text = "" + Request.QueryString["TranXaction"];
        lblDocno.Text = Request.QueryString["DOCTYP"];
        lblManualNo.Text = Request.QueryString["MANDOCNO"];
        lblSysNo.Text = Request.QueryString["DOCNO"];

        lblviewPrintLink.Text = "<a href=\"Javascript:OpenInWindow('./../../Operations/THC/ViewPrint/THCViewPrint.aspx?tcno=" + Request.QueryString["DOCNO"].ToString() + ".,0',700,1000,0,0)\"><u>View</u></a>|<a href=\"Javascript:OpenInWindow('./../../Operations/THC/ViewPrint/THCViewPrint.aspx?tcno=" + Request.QueryString["DOCNO"].ToString() + ".,0',700,1000,0,0)\"><u>Print</u></a>";
       
    }
}
