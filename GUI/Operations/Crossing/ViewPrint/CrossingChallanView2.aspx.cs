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
using System.Data.SqlClient;

public partial class GUI_Operations_Crossing_ViewPrint_CrossingChallanView2 : System.Web.UI.Page
{
    public string DocumentNo, ManualNo, dtFrom, dtTo, VehicleNo, sql, SessionBranch, fromdt, todt, s2 = "", RouteMode = "";
    public static string doctype = "";
    public string[] VehicleArray, DocumentArray, ManualNoArray;
    public int intTotalRecords;
    int i;
    SqlCommand cmd;
    SqlDataAdapter sqlDA;
    DataSet ds;
    DateTime f = new DateTime();
    DateTime t = new DateTime();
    MyFunctions fn = new MyFunctions();

    protected void Page_Load(object sender, EventArgs e)
    {
        fromdt = Request.QueryString["dtFrom"];
        fromdt = fn.Mydate(fromdt);
        todt = Request.QueryString["dtTo"];
        todt = fn.Mydate(todt);
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        DocumentNo = Convert.ToString(Request.QueryString["DocumentNo"]);
        SessionBranch = Session["BRCD"].ToString();

        lblDocDate.Text = fromdt + " TO " + todt;
        lblDocNo.Text = DocumentNo;
        string docno_str = "", datecls = "";

        if (Session["BRCD"].ToString() == "HQTR")
        {
            if (DocumentNo != "")
            {
                sql = "select CrossingChallanNo,Convert(varchar,ChallanDate,06) as ChallanDate,(VendorCode + ':' + VendorName) as vendname,ChallanLocCode from Webx_Crossing_Docket_Master where CrossingChallanNo = '" + DocumentNo + "'";
            }
            else
            {
                sql = "select CrossingChallanNo,Convert(varchar,ChallanDate,06) as ChallanDate,(VendorCode + ':' + VendorName) as vendname,ChallanLocCode from Webx_Crossing_Docket_Master where Convert(varchar,ChallanDate,06) between Convert(datetime,'" + fromdt + "',103) and Convert(datetime,'" + todt + "',103)";
            }
        }
        else
        {
            if (DocumentNo != "")
            {
                sql = "select CrossingChallanNo,Convert(varchar,ChallanDate,06) as ChallanDate,(VendorCode + ':' + VendorName) as vendname,ChallanLocCode from Webx_Crossing_Docket_Master where CrossingChallanNo = '" + DocumentNo + "' and ChallanLocCode='" + Session["BRCD"].ToString() + "'";
            }
            else
            {
                sql = "select CrossingChallanNo,Convert(varchar,ChallanDate,06) as ChallanDate,(VendorCode + ':' + VendorName) as vendname,ChallanLocCode from Webx_Crossing_Docket_Master where Convert(varchar,ChallanDate,06) between Convert(datetime,'" + fromdt + "',103) and Convert(datetime,'" + todt + "',103) and ChallanLocCode='" + Session["BRCD"].ToString() + "'";
            }
        }
        //Response.Write(sql);
        //Response.End();
        DipsplayReport();
    }
    public void DipsplayReport()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        cmd = new SqlCommand(sql, conn);
        sqlDA = new SqlDataAdapter(cmd);
        ds = new DataSet();
        sqlDA.Fill(ds);

        GridCrossingList.DataSource = ds;
        intTotalRecords = ds.Tables[0].Rows.Count;
        GridCrossingList.DataBind();
        conn.Close();
    }
    public void pgChange(object sender, GridViewPageEventArgs e)
    {
        GridCrossingList.PageIndex = e.NewPageIndex;
        DipsplayReport();
    }
}
