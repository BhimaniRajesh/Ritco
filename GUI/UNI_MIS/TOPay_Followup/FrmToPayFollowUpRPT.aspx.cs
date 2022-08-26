using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
//using CrystalDecisions.CrystalReports.Engine;

public partial class FrmPaidFollowUpRPT : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DataSet ds = new DataSet();
        ds = (DataSet)Session["ToPay"];
        ReportDocument rd;
        rd = new ReportDocument();
        rd.Load(Server.MapPath("RptToPayFollow.rpt"));
        rd.SetDataSource(ds.Tables["ToPay"]);
        CRVEmployees.ReportSource = rd;
        CRVEmployees.DataBind();

       //DataSet ds = new DataSet();
       // //DataTable dt = new DataTable(); 
       // // Mydataset = (DataSet)Request.QueryString["abc"];  
       // ds = (DataSet)Session["abc"];
       // //ds.Tables.Add(dt);  
       // //Response.Write(Convert.ToString(dt.Rows.Count));
       // ReportDocument rd;
       // rd = new ReportDocument();
       // rd.Load(Server.MapPath("RptDocketDetail.rpt"));
       // rd.SetDataSource(ds.Tables[0]);
       // CrystalReportViewer1.ReportSource = rd;
       // CrystalReportViewer1.DataBind(); 

    }
}
