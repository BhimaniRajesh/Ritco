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
using System.Globalization;
using System.Data.SqlClient;
using System.IO;
//using CrystalDecisions.CrystalReports.Engine; 
public partial class FrmPaidFollowUp : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    String str = "";
    //SqlConnection cn = new SqlConnection("Data Source=202.87.45.72;Initial Catalog=PTN_Live;User ID=sa;Password=ecfy@pra$$ana");
    SqlConnection cn;// = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_VER2_LIVE"); 
    //SqlConnection cn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_Ver2_LIVE"); 
    //SqlConnection cn = new SqlConnection("data source=202.87.45.69;UID=sa;PWD=!@ECfy#$;Database=ASL_LIVE");
    private GridViewHelper helper;
    String fdate, date, status, location;
    DataTable dt;
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        status = Request.QueryString["type"];
        location = Request.QueryString["location"];
        if (!IsPostBack)
        {
            Array str;        
            fdate = DateTime.Today.ToString("dd/MM/yyyy");
            str = fdate.Split('/');
            string FmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str))[1]));//return month name
            date = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];
            status = Request.QueryString["type"];
            lblDate.Text = fn.Mydatedisplay(fdate);
            lbllocation.Text = location;
            lblStatus.Text = status;  
            BindTheData();
            GrdPaidFollow.HeaderRow.Cells[4].Text = "No. Of " + Convert.ToString(Session["DocketCalledAs"]);
        }
        
    }
    public void BindTheData()
    {
        string sql;
        sql = "";
        if (status == "All") 
        {
           //sql = "Select thcbr,thcno,(select loccode +' : '+locname from webx_location where loccode=thcbr)as THCName,(Select SUM(TOTDKT) from webx_THCTC_PNTR where thcno=vw_Expexted_Report.thcno) as TOTDKT,(Select SUM(TC_CHWT) from webx_THCTC_PNTR where thcno=vw_Expexted_Report.thcno) as actuwt,(Select (pcamt) as pcamt from webx_THC_SUMMARY where thcno=vw_Expexted_Report.thcno UNION Select (pcamt) as pcamt from webx_THC_SUMMARY_ARCH where thcno=vw_Expexted_Report.thcno) as ContractRS,vehno,convert(varchar,thcdt,106) as thcdt,routename,outacm,coming_from,actdept_dt,actdept_tm,depdate_prevbr,deptime_prevbr,CONVERT(varchar,actdept_dt,106) + '-' + actdept_tm as DTDep,'Yet to Arrive' as stat,outacm as FreeSpace,coming_from as lastlocation,DaysFromStart=datediff(d, thcdt,getdate()) from vw_Expexted_Report where tobh_code='" + location + "' and thcno not in (select thcno from webx_thchdr with(NOLOCK) where sourcehb='" + location + "')  UNION select thcbr,thcno,(select loccode +' : '+locname from webx_location where loccode=thcbr)as THCName, (Select SUM(TOTDKT) from webx_THCTC_PNTR  where thcno=vw_Expexted_Report.thcno) as TOTDKT, (Select SUM(TC_CHWT) from webx_THCTC_PNTR  where thcno=vw_Expexted_Report.thcno) as actuwt, (Select (pcamt) as pcamt from webx_THC_SUMMARY where thcno=vw_Expexted_Report.thcno UNION Select (pcamt) as pcamt from webx_THC_SUMMARY_ARCH where thcno=vw_Expexted_Report.thcno) as ContractRS,vehno,convert(varchar,thcdt,106) as thcdt,routename,outacm,coming_from,actdept_dt,actdept_tm,depdate_prevbr,deptime_prevbr,CONVERT(varchar,actdept_dt,106) + '-' + actdept_tm as DTDep, 'Departed' as stat , outacm as FreeSpace,coming_from as lastlocation, DaysFromStart=datediff(d, thcdt,getdate()) from vw_Expexted_Report where sourcehb='" + location + "' and rvn_self='Y' and TOBH_Code<>'Null' and thcno not in (select thcno from webx_thc_summary with(NOLOCK) where routename like '%" + location + "%' and coming_from='" + location + "' and going_to is null) Union select thcbr,thcno,(select loccode +' : '+locname from webx_location where loccode=thcbr)as THCName, (Select SUM(TOTDKT) from webx_THCTC_PNTR  where thcno=webx_thc_summary.thcno) as TOTDKT, (Select SUM(TC_CHWT) from webx_THCTC_PNTR  where thcno=webx_thc_summary.thcno) as actuwt, (Select (pcamt) as pcamt from webx_THC_SUMMARY where thcno=webx_thc_summary.thcno UNION Select (pcamt) as pcamt from webx_THC_SUMMARY_ARCH where thcno=webx_thc_summary.thcno) as ContractRS,vehno,convert(varchar,thcdt,106) as thcdt,routename,inacm as outacm,coming_from,actdept_dt,actdept_tm,depdate_prevbr,deptime_prevbr,CONVERT(varchar,actdept_dt,106) + '-' + actdept_tm as DTDep, 'Completed' as stat , '-' as FreeSpace,':' as lastlocation,DaysFromStart=datediff(d, thcdt,getdate()) from webx_thc_summary with(NOLOCK) where routename like '%" + location + "%' and tobh_code='Null' order by thcdt";
            sql = "Select thcbr,thcno,(select loccode +' : '+locname from webx_location where loccode=thcbr)as THCName,(Select SUM(TOTDKT) from webx_THCTC_PNTR where thcno=vw_Expexted_Report.thcno) as TOTDKT,(Select SUM(TC_CHWT) from webx_THCTC_PNTR where thcno=vw_Expexted_Report.thcno) as actuwt,(Select (pcamt) as pcamt from webx_THC_SUMMARY where thcno=vw_Expexted_Report.thcno) as ContractRS,vehno,convert(varchar(9),thcdt,6) as thcdt,routename,outacm,coming_from,actdept_dt,actdept_tm,depdate_prevbr,deptime_prevbr,CONVERT(varchar(9),actdept_dt,6) + '-' + actdept_tm as DTDep,'Yet to Arrive' as stat,outacm as FreeSpace,coming_from as lastlocation,DaysFromStart=datediff(d, thcdt,getdate()) from vw_Expexted_Report where tobh_code='" + location + "' and thcno not in (select thcno from webx_thchdr with(NOLOCK) where sourcehb='" + location + "')  UNION select thcbr,thcno,(select loccode +' : '+locname from webx_location where loccode=thcbr)as THCName, (Select SUM(TOTDKT) from webx_THCTC_PNTR  where thcno=vw_Expexted_Report.thcno) as TOTDKT, (Select SUM(TC_CHWT) from webx_THCTC_PNTR  where thcno=vw_Expexted_Report.thcno) as actuwt, (Select (pcamt) as pcamt from webx_THC_SUMMARY where thcno=vw_Expexted_Report.thcno) as ContractRS,vehno,convert(varchar(9),thcdt,6) as thcdt,routename,outacm,coming_from,actdept_dt,actdept_tm,depdate_prevbr,deptime_prevbr,CONVERT(varchar(9),actdept_dt,6) + '-' + actdept_tm as DTDep, 'Departed' as stat , outacm as FreeSpace,coming_from as lastlocation, DaysFromStart=datediff(d, thcdt,getdate()) from vw_Expexted_Report where sourcehb='" + location + "' and rvn_self='Y' and TOBH_Code<>'Null' and thcno not in (select thcno from webx_thc_summary with(NOLOCK) where routename like '%" + location + "%' and coming_from='" + location + "' and going_to is null) Union select thcbr,thcno,(select loccode +' : '+locname from webx_location where loccode=thcbr)as THCName, (Select SUM(TOTDKT) from webx_THCTC_PNTR  where thcno=webx_thc_summary.thcno) as TOTDKT, (Select SUM(TC_CHWT) from webx_THCTC_PNTR  where thcno=webx_thc_summary.thcno) as actuwt, (Select (pcamt) as pcamt from webx_THC_SUMMARY where thcno=webx_thc_summary.thcno) as ContractRS,vehno,convert(varchar(9),thcdt,6) as thcdt,routename,inacm as outacm,coming_from,actdept_dt,actdept_tm,depdate_prevbr,deptime_prevbr,CONVERT(varchar(9),actdept_dt,6) + '-' + actdept_tm as DTDep, 'Completed' as stat , '-' as FreeSpace,':' as lastlocation,DaysFromStart=datediff(d, thcdt,getdate()) from webx_thc_summary with(NOLOCK) where routename like '%" + location + "%' and tobh_code='Null' order by thcdt";
        }
        else if (status == "Yet to Arrive")
        {
            sql = "Select thcbr,thcno,(select loccode +' : '+locname from webx_location where loccode=thcbr)as THCName,(Select SUM(TOTDKT) from webx_THCTC_PNTR where thcno=vw_Expexted_Report.thcno) as TOTDKT,(Select SUM(TC_CHWT) from webx_THCTC_PNTR where thcno=vw_Expexted_Report.thcno) as actuwt,(Select (pcamt) as pcamt from webx_THC_SUMMARY where thcno=vw_Expexted_Report.thcno) as ContractRS,vehno,convert(varchar(9),thcdt,6) as thcdt,routename,outacm,coming_from,actdept_dt,actdept_tm,depdate_prevbr,deptime_prevbr,CONVERT(varchar(9),actdept_dt,6) + '-' + actdept_tm as DTDep,'Yet to Arrive' as stat,outacm as FreeSpace,coming_from as lastlocation,DaysFromStart=datediff(d, thcdt,getdate()) from vw_Expexted_Report where tobh_code='" + location + "' and thcno not in (select thcno from webx_thchdr with(NOLOCK) where sourcehb='" + location + "')";

        }
        else if (status == "Departed")
        {
            sql = "select thcbr,thcno,(select loccode +' : '+locname from webx_location where loccode=thcbr)as THCName,(Select SUM(TOTDKT) from webx_THCTC_PNTR  where thcno=vw_Expexted_Report.thcno) as TOTDKT, (Select SUM(TC_CHWT) from webx_THCTC_PNTR  where thcno=vw_Expexted_Report.thcno) as actuwt, (Select (pcamt) as pcamt from webx_THC_SUMMARY where thcno=vw_Expexted_Report.thcno) as ContractRS,vehno,convert(varchar(9),thcdt,6) as thcdt,routename,outacm,coming_from,actdept_dt,actdept_tm,depdate_prevbr,deptime_prevbr,CONVERT(varchar(9),actdept_dt,6) + '-' + actdept_tm as DTDep, 'Departed' as stat , outacm as FreeSpace,coming_from as lastlocation, DaysFromStart=datediff(d, thcdt,getdate()) from vw_Expexted_Report where sourcehb='" + location + "' and rvn_self='Y' and TOBH_Code<>'Null' and thcno not in (select thcno from webx_thc_summary with(NOLOCK) where routename like '%" + location + "%' and coming_from='" + location + "' and going_to is null)";
        }
        else if (status == "Completed")
        {
            sql = "select thcbr,thcno,(select loccode +' : '+locname from webx_location where loccode=thcbr)as THCName,(Select SUM(TOTDKT) from webx_THCTC_PNTR  where thcno=webx_thc_summary.thcno) as TOTDKT, (Select SUM(TC_CHWT) from webx_THCTC_PNTR  where thcno=webx_thc_summary.thcno) as actuwt, (Select (pcamt) as pcamt from webx_THC_SUMMARY where thcno=webx_thc_summary.thcno) as ContractRS,vehno,convert(varchar(9),thcdt,6) as thcdt,routename,inacm as outacm,coming_from,actdept_dt,actdept_tm,depdate_prevbr,deptime_prevbr,CONVERT(varchar(9),actdept_dt,6) + '-' + actdept_tm as DTDep, 'Completed' as stat , '-' as FreeSpace, ':' as lastlocation,DaysFromStart=datediff(d, thcdt,getdate()) from webx_thc_summary with(NOLOCK) where routename like '%" + location + "%' and tobh_code='Null' order by thcdt";
        }
        //SqlCommand cmd = new SqlCommand(sql, cn);
        //cmd.Connection.Open();
       // SqlDataReader dr;
       // dr = cmd.ExecuteReader();
       // dt = new DataTable();
       // dt.Load(dr);
        cn.Open(); 
        SqlDataAdapter da = new SqlDataAdapter(sql,cn);
        DataSet ds = new DataSet();
        da.Fill(ds,"ExpArrival"); 
        GrdPaidFollow.DataSource = ds.Tables["ExpArrival"];
        GrdPaidFollow.DataBind();  
        //dr.Close();
        //cmd.Connection.Close();
        cn.Close();
        if (ds.Tables["ExpArrival"].Rows.Count <= 0)
        {
            Button1.Visible = false;  
        }
    }
    
    protected void PageIndexChanged_Click(object sender, GridViewPageEventArgs e)
    {
        GrdPaidFollow.PageIndex = e.NewPageIndex;
        BindTheData();
        //GrdPaidFollow.DataBind(); 
    }
    public void SortCommand_Click(object sender, DataGridSortCommandEventArgs e)
    {
        //str = " ORDER BY " + e.SortExpression;
        DataView dv = new DataView();
        dv = ds.Tables["Dockets"].DefaultView;
        dv.Sort = e.SortExpression;
        GrdPaidFollow.DataSource = ds.Tables["Dockets"];
        GrdPaidFollow.DataBind();  
        //BindTheData();
    }
    
    public void eventhandler(object Sender, DataGridItemEventArgs E)
    {
     
        if (E.Item.ItemType != ListItemType.Header && E.Item.ItemType != ListItemType.Footer)
        {
            E.Item.Cells[0].Text = Convert.ToString(E.Item.DataSetIndex + 1);
        }

    }
   
    protected void Button1_Click(object sender, EventArgs e)
    {
       
    }

    protected void cmdexcel_Click(object sender, EventArgs e)
    {
        //System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("ExpectedArrival.csv"), false);
        //string sql;
        //sql = "";
        //if (status == "All")
        //{
        //    //sql = "Select thcbr,thcno,(select loccode +' : '+locname from webx_location where loccode=thcbr)as THCName,(Select SUM(TOTDKT) from webx_THCTC_PNTR where thcno=vw_Expexted_Report.thcno) as TOTDKT,(Select SUM(TC_CHWT) from webx_THCTC_PNTR where thcno=vw_Expexted_Report.thcno) as actuwt,(Select (pcamt) as pcamt from webx_THC_SUMMARY where thcno=vw_Expexted_Report.thcno UNION Select (pcamt) as pcamt from webx_THC_SUMMARY_ARCH where thcno=vw_Expexted_Report.thcno) as ContractRS,vehno,convert(varchar,thcdt,106) as thcdt,routename,outacm,coming_from,actdept_dt,actdept_tm,depdate_prevbr,deptime_prevbr,CONVERT(varchar,actdept_dt,106) + '-' + actdept_tm as DTDep,'Yet to Arrive' as stat,outacm as FreeSpace,coming_from as lastlocation,DaysFromStart=datediff(d, thcdt,getdate()) from vw_Expexted_Report where tobh_code='" + location + "' and thcno not in (select thcno from webx_thchdr with(NOLOCK) where sourcehb='" + location + "')  UNION select thcbr,thcno,(select loccode +' : '+locname from webx_location where loccode=thcbr)as THCName, (Select SUM(TOTDKT) from webx_THCTC_PNTR  where thcno=vw_Expexted_Report.thcno) as TOTDKT, (Select SUM(TC_CHWT) from webx_THCTC_PNTR  where thcno=vw_Expexted_Report.thcno) as actuwt, (Select (pcamt) as pcamt from webx_THC_SUMMARY where thcno=vw_Expexted_Report.thcno UNION Select (pcamt) as pcamt from webx_THC_SUMMARY_ARCH where thcno=vw_Expexted_Report.thcno) as ContractRS,vehno,convert(varchar,thcdt,106) as thcdt,routename,outacm,coming_from,actdept_dt,actdept_tm,depdate_prevbr,deptime_prevbr,CONVERT(varchar,actdept_dt,106) + '-' + actdept_tm as DTDep, 'Departed' as stat , outacm as FreeSpace,coming_from as lastlocation, DaysFromStart=datediff(d, thcdt,getdate()) from vw_Expexted_Report where sourcehb='" + location + "' and rvn_self='Y' and TOBH_Code<>'Null' and thcno not in (select thcno from webx_thc_summary with(NOLOCK) where routename like '%" + location + "%' and coming_from='" + location + "' and going_to is null) Union select thcbr,thcno,(select loccode +' : '+locname from webx_location where loccode=thcbr)as THCName, (Select SUM(TOTDKT) from webx_THCTC_PNTR  where thcno=webx_thc_summary.thcno) as TOTDKT, (Select SUM(TC_CHWT) from webx_THCTC_PNTR  where thcno=webx_thc_summary.thcno) as actuwt, (Select (pcamt) as pcamt from webx_THC_SUMMARY where thcno=webx_thc_summary.thcno UNION Select (pcamt) as pcamt from webx_THC_SUMMARY_ARCH where thcno=webx_thc_summary.thcno) as ContractRS,vehno,convert(varchar,thcdt,106) as thcdt,routename,inacm as outacm,coming_from,actdept_dt,actdept_tm,depdate_prevbr,deptime_prevbr,CONVERT(varchar,actdept_dt,106) + '-' + actdept_tm as DTDep, 'Completed' as stat , '-' as FreeSpace,':' as lastlocation,DaysFromStart=datediff(d, thcdt,getdate()) from webx_thc_summary with(NOLOCK) where routename like '%" + location + "%' and tobh_code='Null' order by thcdt";
        //    sql = "Select thcbr,thcno,(select loccode +' : '+locname from webx_location where loccode=thcbr)as THCName,(Select SUM(TOTDKT) from webx_THCTC_PNTR where thcno=vw_Expexted_Report.thcno) as TOTDKT,(Select SUM(TC_CHWT) from webx_THCTC_PNTR where thcno=vw_Expexted_Report.thcno) as actuwt,(Select (pcamt) as pcamt from webx_THC_SUMMARY where thcno=vw_Expexted_Report.thcno) as ContractRS,vehno,convert(varchar,thcdt,106) as thcdt,routename,outacm,coming_from,actdept_dt,actdept_tm,depdate_prevbr,deptime_prevbr,CONVERT(varchar,actdept_dt,106) + '-' + actdept_tm as DTDep,'Yet to Arrive' as stat,outacm as FreeSpace,coming_from as lastlocation,DaysFromStart=datediff(d, thcdt,getdate()) from vw_Expexted_Report where tobh_code='" + location + "' and thcno not in (select thcno from webx_thchdr with(NOLOCK) where sourcehb='" + location + "')  UNION select thcbr,thcno,(select loccode +' : '+locname from webx_location where loccode=thcbr)as THCName, (Select SUM(TOTDKT) from webx_THCTC_PNTR  where thcno=vw_Expexted_Report.thcno) as TOTDKT, (Select SUM(TC_CHWT) from webx_THCTC_PNTR  where thcno=vw_Expexted_Report.thcno) as actuwt, (Select (pcamt) as pcamt from webx_THC_SUMMARY where thcno=vw_Expexted_Report.thcno) as ContractRS,vehno,convert(varchar,thcdt,106) as thcdt,routename,outacm,coming_from,actdept_dt,actdept_tm,depdate_prevbr,deptime_prevbr,CONVERT(varchar,actdept_dt,106) + '-' + actdept_tm as DTDep, 'Departed' as stat , outacm as FreeSpace,coming_from as lastlocation, DaysFromStart=datediff(d, thcdt,getdate()) from vw_Expexted_Report where sourcehb='" + location + "' and rvn_self='Y' and TOBH_Code<>'Null' and thcno not in (select thcno from webx_thc_summary with(NOLOCK) where routename like '%" + location + "%' and coming_from='" + location + "' and going_to is null) Union select thcbr,thcno,(select loccode +' : '+locname from webx_location where loccode=thcbr)as THCName, (Select SUM(TOTDKT) from webx_THCTC_PNTR  where thcno=webx_thc_summary.thcno) as TOTDKT, (Select SUM(TC_CHWT) from webx_THCTC_PNTR  where thcno=webx_thc_summary.thcno) as actuwt, (Select (pcamt) as pcamt from webx_THC_SUMMARY where thcno=webx_thc_summary.thcno) as ContractRS,vehno,convert(varchar,thcdt,106) as thcdt,routename,inacm as outacm,coming_from,actdept_dt,actdept_tm,depdate_prevbr,deptime_prevbr,CONVERT(varchar,actdept_dt,106) + '-' + actdept_tm as DTDep, 'Completed' as stat , '-' as FreeSpace,':' as lastlocation,DaysFromStart=datediff(d, thcdt,getdate()) from webx_thc_summary with(NOLOCK) where routename like '%" + location + "%' and tobh_code='Null' order by thcdt";
        //}
        //else if (status == "Yet to Arrive")
        //{
        //    sql = "Select thcbr,thcno,(select loccode +' : '+locname from webx_location where loccode=thcbr)as THCName,(Select SUM(TOTDKT) from webx_THCTC_PNTR where thcno=vw_Expexted_Report.thcno) as TOTDKT,(Select SUM(TC_CHWT) from webx_THCTC_PNTR where thcno=vw_Expexted_Report.thcno) as actuwt,(Select (pcamt) as pcamt from webx_THC_SUMMARY where thcno=vw_Expexted_Report.thcno) as ContractRS,vehno,convert(varchar,thcdt,106) as thcdt,routename,outacm,coming_from,actdept_dt,actdept_tm,depdate_prevbr,deptime_prevbr,CONVERT(varchar,actdept_dt,106) + '-' + actdept_tm as DTDep,'Yet to Arrive' as stat,outacm as FreeSpace,coming_from as lastlocation,DaysFromStart=datediff(d, thcdt,getdate()) from vw_Expexted_Report where tobh_code='" + location + "' and thcno not in (select thcno from webx_thchdr with(NOLOCK) where sourcehb='" + location + "')";

        //}
        //else if (status == "Departed")
        //{
        //    sql = "select thcbr,thcno,(select loccode +' : '+locname from webx_location where loccode=thcbr)as THCName,(Select SUM(TOTDKT) from webx_THCTC_PNTR  where thcno=vw_Expexted_Report.thcno) as TOTDKT, (Select SUM(TC_CHWT) from webx_THCTC_PNTR  where thcno=vw_Expexted_Report.thcno) as actuwt, (Select (pcamt) as pcamt from webx_THC_SUMMARY where thcno=vw_Expexted_Report.thcno) as ContractRS,vehno,convert(varchar,thcdt,106) as thcdt,routename,outacm,coming_from,actdept_dt,actdept_tm,depdate_prevbr,deptime_prevbr,CONVERT(varchar,actdept_dt,106) + '-' + actdept_tm as DTDep, 'Departed' as stat , outacm as FreeSpace,coming_from as lastlocation, DaysFromStart=datediff(d, thcdt,getdate()) from vw_Expexted_Report where sourcehb='" + location + "' and rvn_self='Y' and TOBH_Code<>'Null' and thcno not in (select thcno from webx_thc_summary with(NOLOCK) where routename like '%" + location + "%' and coming_from='" + location + "' and going_to is null)";
        //}
        //else if (status == "Completed")
        //{
        //    sql = "select thcbr,thcno,(select loccode +' : '+locname from webx_location where loccode=thcbr)as THCName,(Select SUM(TOTDKT) from webx_THCTC_PNTR  where thcno=webx_thc_summary.thcno) as TOTDKT, (Select SUM(TC_CHWT) from webx_THCTC_PNTR  where thcno=webx_thc_summary.thcno) as actuwt, (Select (pcamt) as pcamt from webx_THC_SUMMARY where thcno=webx_thc_summary.thcno) as ContractRS,vehno,convert(varchar,thcdt,106) as thcdt,routename,inacm as outacm,coming_from,actdept_dt,actdept_tm,depdate_prevbr,deptime_prevbr,CONVERT(varchar,actdept_dt,106) + '-' + actdept_tm as DTDep, 'Completed' as stat , '-' as FreeSpace, ':' as lastlocation,DaysFromStart=datediff(d, thcdt,getdate()) from webx_thc_summary with(NOLOCK) where routename like '%" + location + "%' and tobh_code='Null' order by thcdt";
        //}
        //SqlCommand cmd = new SqlCommand(sql, cn);
        //cmd.Connection.Open();
        //SqlDataReader dr;
        //dr = cmd.ExecuteReader();
        //dt = new DataTable();
        //dt.Load(dr);        
        //DataTable dt2 = dt;
        //int iColCount = dt2.Columns.Count;
        //for (int i = 0; i < iColCount; i++)
        //{
        //    sw.Write(dt2.Columns[i]);
        //    if (i < iColCount - 1)
        //    {
        //        sw.Write(",");
        //    }
        //}
        //sw.Write(sw.NewLine);
        //// Now write all the rows.
        //foreach (DataRow dr1 in dt2.Rows)
        //{
        //    for (int i = 0; i < iColCount; i++)
        //    {
        //        if (!Convert.IsDBNull(dr1[i]))
        //        {
        //            sw.Write(dr1[i].ToString());
        //        }
        //        if (i < iColCount - 1)
        //        {
        //            sw.Write(",");
        //        }
        //    }
        //    sw.Write(sw.NewLine);
        //}
        //sw.Close();
        //System.IO.FileStream fs = null;
        //fs = System.IO.File.Open(Server.MapPath("ExpectedArrival.csv"), System.IO.FileMode.Open);
        //byte[] btFile = new byte[fs.Length];
        //fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        //fs.Close();
        //Response.ContentType = "application/vnd.ms-excel";
        //Response.AddHeader("Content-disposition", "attachment; filename=" + "ExpectedArrival.csv");
        ////Response.ContentType = "application/octet-stream";
        //Response.BinaryWrite(btFile);
        //Response.End();
        GrdPaidFollow.AllowPaging = false;
        BindTheData();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=FileName.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        frm.Controls.Add(GrdPaidFollow);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();


    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
}
