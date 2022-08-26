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
using System.Globalization;
using System.IO;
public partial class FrmDocketDetail : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    String str = "";
    //SqlConnection cn = new SqlConnection("Data Source=202.87.45.72;Initial Catalog=PTN_Live;User ID=sa;Password=ecfy@pra$$ana");
    //SqlConnection cn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_VER2_LIVE");
    SqlConnection cn;// = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_Ver2_LIVE"); 
    //SqlConnection cn = new SqlConnection("data source=202.87.45.69;UID=sa;PWD=!@ECfy#$;Database=ASL_LIVE");
    //SqlConnection cn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=$rcpl@@p@$$;Database=RCPL_VER2_LIVE");
    string strqry,val,mode,sql;
    string FDate, TDate, loccode, location;
    protected void Page_Load(object sender, EventArgs e)
    {
    cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    loccode = Convert.ToString(Request.QueryString["loccode"]);
    val = Convert.ToString(Request.QueryString["val"]);
    mode = Convert.ToString(Request.QueryString["mode"]);
    location = Convert.ToString(Request.QueryString["location"]);
    FDate = Convert.ToString(Request.QueryString["fromdate"]);
    TDate = Convert.ToString(Request.QueryString["todate"]);
    lblLocation.Text = loccode + " : " + location;
    lblrpttype.Text = mode;
    lblDateRange.Text = FDate + " - " + TDate;
    if (val=="delivery")
    {
        //sql = "select *,convert(varchar,convert(datetime,dockdt,102),106) as dockdtv,convert(varchar,convert(datetime,cdeldt,102),106) as cdeldtv,convert(varchar,convert(datetime,dep_dt,102),106) as dep_dtv,convert(varchar,convert(datetime,arrv_dt,102),106) as arrv_dtv,convert(varchar,convert(datetime,dely_dt,102),106) as dely_dtv from vw_UNI_sales_GCN_report t3 with(NOLOCK)  where (t3.op_dly='Y') and t3.reassign_destcd = t3.locCode and t3.report_loc is not null  and t3.locCode = '" + loccode + "' and Convert(varchar,t3.arrv_dt,106)  between  Convert(datetime,'" + FDate + "',106)  and  Convert(datetime,'" + TDate + "',106) and t3.doc_curloc=t3.reassign_destcd and t3.tohub_br = ''";
        sql = "select *,convert(varchar(9),convert(datetime,dockdt,102),6) as dockdtv,convert(varchar(9),convert(datetime,cdeldt,102),6) as cdeldtv,convert(varchar(9),convert(datetime,dep_dt,102),6) as dep_dtv,convert(varchar(9),convert(datetime,arrv_dt,102),6) as arrv_dtv,convert(varchar(9),convert(datetime,dely_dt,102),6) as dely_dtv from vw_docket_booked t3 with(NOLOCK)  where (t3.op_dly='Y') and t3.f_locCode='" + loccode + "' and t3.f_report_loc is not null  and t3.f_locCode = '" + loccode + "' and Convert(varchar,t3.arrv_dt,106)  between  Convert(datetime,'" + FDate + "',106)  and  Convert(datetime,'" + TDate + "',106) and t3.doc_curloc=t3.reassign_destcd";
    }
	else if (val == "drs")
    {
        //sql = "select *,convert(varchar,convert(datetime,dockdt,102),106) as dockdtv,convert(varchar,convert(datetime,cdeldt,102),106) as cdeldtv,convert(varchar,convert(datetime,dep_dt,102),106) as dep_dtv,convert(varchar,convert(datetime,arrv_dt,102),106) as arrv_dtv,convert(varchar,convert(datetime,dely_dt,102),106) as dely_dtv from vw_UNI_sales_GCN_report t3 with(NOLOCK)  where (t3.op_dly='Y') and t3.reassign_destcd = t3.locCode and t3.report_loc is not null  and t3.locCode = '" + loccode + "' and Convert(varchar,t3.arrv_dt,106)  between  Convert(datetime,'" + FDate + "',106)  and  Convert(datetime,'" + TDate + "',106) and t3.doc_curloc=t3.reassign_destcd and t3.tohub_br = '' and t3.dlypdcno is null and t3.dely_dt is null";
        sql = "select *,convert(varchar(9),convert(datetime,dockdt,102),6) as dockdtv,convert(varchar(9),convert(datetime,cdeldt,102),6) as cdeldtv,convert(varchar(9),convert(datetime,dep_dt,102),6) as dep_dtv,convert(varchar(9),convert(datetime,arrv_dt,102),6) as arrv_dtv,convert(varchar(9),convert(datetime,dely_dt,102),6) as dely_dtv from vw_docket_booked t3 with(NOLOCK)  where (t3.op_dly='Y') and t3.f_locCode='" + loccode + "' and t3.f_report_loc is not null  and t3.f_locCode = '" + loccode + "'  and Convert(varchar,t3.arrv_dt,106)  between  Convert(datetime,'" + FDate + "',106)  and  Convert(datetime,'" + TDate + "',106) and t3.doc_curloc=t3.reassign_destcd and t3.dlypdcno is null and t3.dely_dt is null";
    }
	else if (val == "gonedelivery") 
    {
        //sql = "select *,convert(varchar,convert(datetime,dockdt,102),106) as dockdtv,convert(varchar,convert(datetime,cdeldt,102),106) as cdeldtv,convert(varchar,convert(datetime,dep_dt,102),106) as dep_dtv,convert(varchar,convert(datetime,arrv_dt,102),106) as arrv_dtv,convert(varchar,convert(datetime,dely_dt,102),106) as dely_dtv from vw_UNI_sales_GCN_report t3 with(NOLOCK)  where (t3.op_dly='Y') and t3.reassign_destcd = t3.locCode and t3.report_loc is not null  and t3.locCode = '" + loccode + "' and Convert(varchar,t3.arrv_dt,106)  between  Convert(datetime,'" + FDate + "',106)  and  Convert(datetime,'" + TDate + "',106) and t3.doc_curloc=t3.reassign_destcd and t3.tohub_br = '' and t3.dlypdcno is not null";
        sql = "select *,convert(varchar(9),convert(datetime,dockdt,102),6) as dockdtv,convert(varchar(9),convert(datetime,cdeldt,102),6) as cdeldtv,convert(varchar(9),convert(datetime,dep_dt,102),6) as dep_dtv,convert(varchar(9),convert(datetime,arrv_dt,102),6) as arrv_dtv,convert(varchar(9),convert(datetime,dely_dt,102),6) as dely_dtv from vw_docket_booked t3 with(NOLOCK)  where (t3.op_dly='Y') and t3.f_locCode='" + loccode + "'  and t3.f_report_loc is not null  and t3.f_locCode = '" + loccode + "'  and Convert(varchar,t3.arrv_dt,106)  between  Convert(datetime, '" + FDate + "' ,106)  and  Convert(datetime,'" + TDate + "',106) and t3.doc_curloc=t3.reassign_destcd  and t3.dlypdcno is not null";
    }
	else if (val == "gcndelivered") 
    {
        //sql = "select *,convert(varchar,convert(datetime,dockdt,102),106) as dockdtv,convert(varchar,convert(datetime,cdeldt,102),106) as cdeldtv,convert(varchar,convert(datetime,dep_dt,102),106) as dep_dtv,convert(varchar,convert(datetime,arrv_dt,102),106) as arrv_dtv,convert(varchar,convert(datetime,dely_dt,102),106) as dely_dtv from vw_UNI_sales_GCN_report t3 with(NOLOCK)  where (t3.op_dly='Y') and t3.reassign_destcd = t3.locCode and t3.report_loc is not null  and t3.locCode = '" + loccode + "' and Convert(varchar,t3.arrv_dt,106)  between  Convert(datetime,'" + FDate + "',106)  and  Convert(datetime,'" + TDate + "',106) and t3.doc_curloc=t3.reassign_destcd and t3.tohub_br = '' and t3.dlypdcno is not null and t3.dely_dt is not null";
        sql = "select *,convert(varchar(9),convert(datetime,dockdt,102),6) as dockdtv,convert(varchar(9),convert(datetime,cdeldt,102),6) as cdeldtv,convert(varchar(9),convert(datetime,dep_dt,102),6) as dep_dtv,convert(varchar(9),convert(datetime,arrv_dt,102),6) as arrv_dtv,convert(varchar(9),convert(datetime,dely_dt,102),6) as dely_dtv from vw_docket_booked t3 with(NOLOCK) where (t3.op_dly='Y') and t3.f_locCode='" + loccode + "'  and t3.f_report_loc is not null  and t3.f_locCode = '" + loccode + "'  and Convert(varchar,t3.arrv_dt,106) between  Convert(datetime,'" + FDate + "' ,106)  and  Convert(datetime,'" + TDate + "',106) and t3.doc_curloc=t3.reassign_destcd and t3.dlypdcno is not null and t3.dely_dt is not null";
    }
	else if(val == "drsupdate") 
    {
        //sql = "select *,convert(varchar,convert(datetime,dockdt,102),106) as dockdtv,convert(varchar,convert(datetime,cdeldt,102),106) as cdeldtv,convert(varchar,convert(datetime,dep_dt,102),106) as dep_dtv,convert(varchar,convert(datetime,arrv_dt,102),106) as arrv_dtv,convert(varchar,convert(datetime,dely_dt,102),106) as dely_dtv from vw_UNI_sales_GCN_report t3 with(NOLOCK)  where (t3.op_dly='Y') and t3.reassign_destcd = t3.locCode and t3.report_loc is not null  and t3.locCode = '" + loccode + "' and Convert(varchar,t3.arrv_dt,106)  between  Convert(datetime,'" + FDate + "',106)  and  Convert(datetime,'" + TDate + "',106) and t3.doc_curloc=t3.reassign_destcd and t3.tohub_br = '' and t3.dlypdcno is not null and t3.dely_dt is  null";
        sql = "select *,convert(varchar(9),convert(datetime,dockdt,102),6) as dockdtv,convert(varchar(9),convert(datetime,cdeldt,102),6) as cdeldtv,convert(varchar(9),convert(datetime,dep_dt,102),6) as dep_dtv,convert(varchar(9),convert(datetime,arrv_dt,102),6) as arrv_dtv,convert(varchar(9),convert(datetime,dely_dt,102),6) as dely_dtv from vw_docket_booked t3 with(NOLOCK)  where (t3.op_dly='Y') and t3.f_locCode='" + loccode + "'  and t3.f_report_loc is not null  and t3.f_locCode = '" + loccode + "'  and Convert(varchar,t3.arrv_dt,106) between  Convert(datetime, '" + FDate + "' ,106)  and  Convert(datetime,'" + TDate + "',106) and t3.doc_curloc=t3.reassign_destcd and t3.dlypdcno is not null and t3.dely_dt is  null";
    }
	if (!IsPostBack)
    {
        BindTheData();
        GrdToPayFollow.HeaderRow.Cells[1].Text = Convert.ToString(Session["DocketCalledAs"]);
    }
    }
    public void BindTheData()
    {
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = cn;
        cmd.CommandText = sql;
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        if (cn.State == ConnectionState.Closed)
        {
            cn.Open();
        }
        sqlDA.Fill(ds, "DocketDtl");
        GrdToPayFollow.DataSource = ds.Tables["DocketDtl"];// cmd.ExecuteReader(CommandBehavior.CloseConnection);//
        GrdToPayFollow.DataBind();
        if (ds.Tables["DocketDtl"].Rows.Count <= 0)
        {
            cmdexcel.Visible = false;  
        }
    }
    public void PageIndexChanged_Click(object sender, GridViewPageEventArgs e)
    {
        GrdToPayFollow.PageIndex = e.NewPageIndex;
        BindTheData();
        GrdToPayFollow.DataBind();  
    }
    public void SortCommand_Click(object sender, DataGridSortCommandEventArgs e)
    {
        str = " ORDER BY " + e.SortExpression;
        BindTheData();
    }
    public void eventhandler(object Sender, DataGridItemEventArgs E)
    {
        if (E.Item.ItemType != ListItemType.Header && E.Item.ItemType != ListItemType.Footer)
        {
            E.Item.Cells[0].Text = Convert.ToString(E.Item.DataSetIndex + 1);
        }

    }
    
   protected void cmdexcel_Click(object sender, EventArgs e)
    {
        //System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("DocketDetail.csv"), false);

        //SqlCommand cmd = new SqlCommand();
        //cmd.Connection = cn;
        //cmd.CommandText = sql;
        //SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        //if (cn.State == ConnectionState.Closed)
        //{
        //    cn.Open();
        //}
        //sqlDA.Fill(ds, "DocketDtl");
        //DataTable dt2 = ds.Tables["DocketDtl"];// (DataTable)Session["dt1"];
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
        //foreach (DataRow dr in dt2.Rows)
        //{
        //    for (int i = 0; i < iColCount; i++)
        //    {
        //        if (!Convert.IsDBNull(dr[i]))
        //        {
        //            sw.Write(dr[i].ToString());
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
        //fs = System.IO.File.Open(Server.MapPath("DocketDetail.csv"), System.IO.FileMode.Open);
        //byte[] btFile = new byte[fs.Length];
        //fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        //fs.Close();
        //Response.ContentType = "application/vnd.ms-excel";
        //Response.AddHeader("Content-disposition", "attachment; filename=" + "DocketDetail.csv");
        ////Response.ContentType = "application/octet-stream";
        //Response.BinaryWrite(btFile);
        //Response.End();
        GrdToPayFollow.AllowPaging = false;
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
        frm.Controls.Add(GrdToPayFollow);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void GrdToPayFollow_RowCreated(object sender, GridViewRowEventArgs e)
    {
        //if (e.Row.RowType == DataControlRowType.Header)
        //{
            
        //        GridView oGridView = (GridView)sender;
        //        GridViewRow oGridViewRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);
        //        TableCell oTableCell = new TableCell();
        //        //if (q_select == "custwise")
        //        //{
        //        //    oTableCell.Text = "Customer Code : " + loccode1 + "";
        //        //}
        //        //else if (q_select == "locwise")
        //        //{
        //        //    oTableCell.Text = "Location Code : " + loccode1 + "";
        //        //}
        //        oTableCell.HorizontalAlign = HorizontalAlign.Left;
        //        oTableCell.Font.Bold = true;
        //        oTableCell.CssClass = "blackfnt"; 
        //        oTableCell.ColumnSpan = 7;
        //        oGridViewRow.Cells.Add(oTableCell);
        //        oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);
            
        //}
    }
}
