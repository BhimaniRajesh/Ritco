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

public partial class GUI_Fleet_Operations_Issue_ExternalThcAudit_DownloadExternalThcScannDocQuery : System.Web.UI.Page
{
    public string brcd, empcd, selyear, dkt_Call;

    protected void Page_Load(object sender, EventArgs e)
    {
        brcd = Session["brcd"].ToString();
        empcd = Session["empcd"].ToString();
        if (!IsPostBack)
        {
        }
    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        
        string fromdt = DT.FromDate, todt = DT.ToDate;
        string final;
        final = "?fromdt=" + fromdt;
        final += "&todt=" + todt;
        final += "&ExternalThcNo=" + txtExternalThcNo.Text;
        Response.Redirect("DownloadExternalThcScannDocResult.aspx" + final);

    }
}