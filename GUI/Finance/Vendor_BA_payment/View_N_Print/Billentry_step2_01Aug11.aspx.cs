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

public partial class GUI_Finance_Vendor_BA_payment_View_N_Print_Billentry_step2 : System.Web.UI.Page
{
    public string DocumentNo, ManualNo, dtFrom, dtTo, VehicleNo, sql, SessionBranch, fromdt, todt, s2 = "", RouteMode = "";
    //public string billnonos, checkeddockno;
    public static string doctype="";
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
        RouteMode = Request.QueryString["RouteMode"];
        fromdt = fn.Mydate(fromdt);
        todt = Request.QueryString["dtTo"];
        todt = fn.Mydate(todt);
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        
        DocumentNo = Convert.ToString(Request.QueryString["DocumentNo"]);
        //ManualNo = Convert.ToString(Request.QueryString["ManualNo"]);
        //dtFrom = Convert.ToString(Request.QueryString["dtFrom"]);
        //dtTo = Convert.ToString(Request.QueryString["dtTo"]);
        //VehicleNo = Convert.ToString(Request.QueryString["VehicleNo"]);
        doctype = Convert.ToString(Request.QueryString["doctype"]);
        SessionBranch = Session["BRCD"].ToString();

        // f = Convert.ToDateTime(Request.QueryString["dtFrom"]);

        // t = Convert.ToDateTime(Request.QueryString["dtTo"]);


        lblDocDate.Text = fromdt + " TO " + todt;
        lblDocType.Text = doctype;
        string docno_str = "", datecls = "";
        if (DocumentNo != "")
        {
            docno_str = " and billno='" + DocumentNo + "'";
            docno_str = " and billno in ('" + DocumentNo.ToString().Trim().Replace(" " ,"").ToString().Replace(",","','") + "')";

        }
        else
        {
            //datecls = "and Convert(varchar,vendorbilldt,106) between Convert(datetime,'" + fromdt + "',106)  and Convert(datetime,'" + todt + "',106) ";
            //datecls = "and Convert(varchar,BILLDT,106) between Convert(datetime,'" + fromdt + "',106)  and Convert(datetime,'" + todt + "',106) ";
            datecls = "and Convert(datetime,BILLDT,120) between Convert(datetime,'" + fromdt + "',120)  and Convert(datetime,'" + todt + "',120) ";
        }

        if(doctype=="BA")
        {
        doctype="BA Payment";
        }
        else if (doctype == "Expense")
        {
            doctype = "Expense";
        }
        //sql = "select betype,billno,brcd+':'+(select locname from webx_location where loccode=a.brcd) as location,vendorcode+':'+vendorname as vendname,convert(varchar,vendorbilldt,106) as vendorbilldt,Netamt from webx_vendorbill_hdr a  With(NOLOCK) where betype='" + doctype + "' " + docno_str + datecls + " ";
        //sql = "select betype,billno,brcd+':'+(select locname from webx_location where loccode=a.brcd) as location,vendorcode+':'+vendorname as vendname,convert(varchar,vendorbilldt,106) as vendorbilldt,Netamt,(case when bill_cancel='Y' then 'Yes' else 'No' end) bill_cancel from webx_vendorbill_hdr a  With(NOLOCK) where betype like '%" + doctype + "%' " + docno_str + datecls + " ";

        sql = "select betype,billno,brcd+':'+(select locname from webx_location where loccode=a.brcd) as location,vendorcode+':'+vendorname as vendname,convert(varchar,vendorbilldt,106) as vendorbilldt,convert(varchar,BILLDT,106) BILLDT,Netamt,VENDORBILLNO,(case when bill_cancel='Y' then 'Yes' else 'No' end) bill_cancel from webx_vendorbill_hdr a  With(NOLOCK) where betype like '%" + doctype + "%' " + docno_str + datecls + " and (brcd='ALL' or brcd='" + Session["Brcd"] + "' or  patindex('%" + Session["Brcd"] + "%',brcd)>0 ) and Company_Code='" + SessionUtilities.DefaultCompanyCode.ToUpper().Trim() + "' ";

        DipsplayReport();


    }
    public void DipsplayReport()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cmd = new SqlCommand(sql, conn);
        sqlDA = new SqlDataAdapter(cmd);
        ds = new DataSet();
        sqlDA.Fill(ds);

        GridBillList.DataSource = ds;
        intTotalRecords = ds.Tables[0].Rows.Count;
        GridBillList.DataBind();
    }
    public void pgChange(object sender, GridViewPageEventArgs e)
    {
        GridBillList.PageIndex = e.NewPageIndex;

        DipsplayReport();


    }
    public void lst(object sender, EventArgs e)
    {
        int i = GridBillList.PageCount;
        GridBillList.PageIndex = i;

        DipsplayReport();

    }
    public void fst(object sender, EventArgs e)
    {
        GridBillList.PageIndex = 0;

        DipsplayReport();


    }
}
