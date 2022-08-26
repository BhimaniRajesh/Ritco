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
public partial class FrmRptDocketDTL : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DataSet ds = new DataSet();
        //DataTable dt = new DataTable(); 
       // Mydataset = (DataSet)Request.QueryString["abc"];  
        ds = (DataSet)Session["abc"];
        //ds.Tables.Add(dt);  
        //Response.Write(Convert.ToString(dt.Rows.Count));
        ReportDocument rd;
        rd = new ReportDocument();
        rd.Load(Server.MapPath("RptToPayDocketDetail.rpt"));
        string RptName;
        RptName = Convert.ToString(Request.QueryString["RPT"]);
        rd.DataDefinition.FormulaFields["RptName"].Text = "'" + RptName + "'";
        rd.SetDataSource(ds.Tables[0]);
        CrystalReportViewer1.ReportSource = rd;
        CrystalReportViewer1.DataBind(); 
    }
}
