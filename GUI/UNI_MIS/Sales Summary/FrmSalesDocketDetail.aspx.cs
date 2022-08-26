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
    //SqlConnection cn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_Ver2_LIVE"); 
    SqlConnection cn;// = new SqlConnection("data source=202.87.45.69;UID=sa;PWD=!@ECfy#$;Database=ASL_LIVE");
    string strqry,mode,sql;
    string q_select, FromDt, ToDt, whereCri, whereCri_cus, whereCri_cust, loccode, loccode1, val, custcode, locname, FDate, TDate;
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
    cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    q_select = Convert.ToString(Request.QueryString["q_select"]);
    loccode1 = Convert.ToString(Request.QueryString["loccode1"]);
    val = Convert.ToString(Request.QueryString["val"]);
    locname = Convert.ToString(Request.QueryString["locname"]);
    custcode = Convert.ToString(Request.QueryString["custcode"]);
    FDate = Convert.ToString(Request.QueryString["FromDt"]);
    TDate = Convert.ToString(Request.QueryString["ToDt"]);
    Array str, str1;
    str = FDate.Split('/');
    str1 = TDate.Split('/');
    //((string[])(str))[0]
    string FmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str))[1]));//return month name
    string TmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str1))[1]));//return month name
    //CultureInfo a = CultureInfo.CurrentCulture;  
    //lblDateRange.Text = (FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2] + " -- " + TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2]);
    lblDateRange.Text = fn.Mydatedisplay(FDate) + " -- " + fn.Mydatedisplay(TDate);
    FromDt = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];
    ToDt = TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2];
    loccode = "";
    whereCri_cust = ""; whereCri = "";
    //strqry = strqry.Replace("@", "+");
        
    if ((q_select == "locwise") || (q_select == "destwise"))  
      {
        if (loccode != "") 
        {
            whereCri = "and  destcd = '" + loccode + "' and orgncd = '" + loccode1 + "'";
        }
        else
        {
        whereCri = "and   orgncd = '" + loccode1 + "'";
        }
        if (custcode == "") 
            {
            whereCri_cus="";
            }
        else if (loccode1=="8888") 
            {
                whereCri_cust=" and party='"+ custcode +"' and csgnnm like '%"+ locname +"'";
            }
        else
            {
                whereCri_cust=" and party='"+ custcode +"'";
            }
   
    }
else if (q_select == "custwise") 
    {
  if (loccode1=="8888")
    {
      whereCri=" and party='"+ loccode1 +"' and csgnnm like '%"+ locname +"'";
    }
  else 			
    {
      whereCri="and  (csgncd = '"+ loccode1 +"' or csgecd = '"+ loccode1 +"'  or party_code = '"+ loccode1 +"' ) ";
    }
    }		
    if (val=="paid")
    {
        sql = "select Convert(varchar(9),dockdt,6) as dockdt,*,dockno+docksf as docket,csgncd+char(32)+char(58)+char(32)+csgnnm as consignee,csgecd+char(32)+char(58)+char(32)+csgenm as consignor from vw_docket_net where paybas = 'P01' and dkt_cancel <> 'Y'  " + whereCri + whereCri_cust + " and convert(varchar,dockdt,106) between convert(datetime,'" + FromDt + "',106) and convert(datetime,'" + ToDt + "',106)";
    }
	else if (val == "tbb")
    {
        sql = "select Convert(varchar(9),dockdt,6) as dockdt,*,dockno+docksf as docket,csgncd+char(32)+char(58)+char(32)+csgnnm as consignee,csgecd+char(32)+char(58)+char(32)+csgenm as consignor from vw_docket_net where paybas = 'P02' and dkt_cancel <> 'Y'  " + whereCri + whereCri_cust + " and  convert(varchar,dockdt,106) between convert(datetime,'" + FromDt + "',106) and convert(datetime,'" + ToDt + "',106)";
    }
	else if (val == "topay") 
    {
        sql = "select Convert(varchar(9),dockdt,6) as dockdt,*,dockno+docksf as docket,csgncd+char(32)+char(58)+char(32)+csgnnm as consignee,csgecd+char(32)+char(58)+char(32)+csgenm as consignor from vw_docket_net where paybas = 'P03' and dkt_cancel <> 'Y' " + whereCri + whereCri_cust + " and convert(varchar,dockdt,106) between convert(datetime,'" + FromDt + "',106) and convert(datetime,'" + ToDt + "',106)";
    }
	else if (val == "to pay") 
    {
        sql = "select Convert(varchar(9),dockdt,6) as dockdt,*,dockno+docksf as docket,csgncd+char(32)+char(58)+char(32)+csgnnm as consignee,csgecd+char(32)+char(58)+char(32)+csgenm as consignor from vw_docket_net where paybas = 'P03' and dkt_cancel <> 'Y' " + whereCri + whereCri_cust + " and convert(varchar,dockdt,106) between convert(datetime,'" + FromDt + "',106) and convert(datetime,'" + ToDt + "',106)";
    }
	else if(val == "bod") 
    {
        sql = "select Convert(varchar(9),dockdt,6) as dockdt,*,dockno+docksf as docket,csgncd+char(32)+char(58)+char(32)+csgnnm as consignee,csgecd+char(32)+char(58)+char(32)+csgenm as consignor from vw_docket_net where paybas = 'P08' and dkt_cancel <> 'Y' " + whereCri + whereCri_cust + " and convert(varchar,dockdt,106) between convert(datetime,'" + FromDt + "',106) and convert(datetime,'" + ToDt + "',106)";
    }
	else if (val=="foc") 
    {
        sql = "select Convert(varchar(9),dockdt,6) as dockdt,*,dockno+docksf as docket,csgncd+char(32)+char(58)+char(32)+csgnnm as consignee,csgecd+char(32)+char(58)+char(32)+csgenm as consignor from vw_docket_net where paybas = 'P04' and dkt_cancel <> 'Y' " + whereCri + whereCri_cust + " and convert(varchar,dockdt,106) between convert(datetime,'" + FromDt + "',106) and convert(datetime,'" + ToDt + "',106)";
    }
	else if (val=="national")
    {
        sql = "select Convert(varchar(9),dockdt,6) as dockdt,*,dockno+docksf as docket,csgncd+char(32)+char(58)+char(32)+csgnnm as consignee,csgecd+char(32)+char(58)+char(32)+csgenm as consignor from vw_docket_net where paybas = 'P09' and dkt_cancel <> 'Y' " + whereCri + whereCri_cust + whereCri_cust + " and convert(varchar,dockdt,106) between convert(datetime,'" + FromDt + "',106) and convert(datetime,'" + ToDt + "',106)";
    }
	else if (val=="cancel") 
    {
        sql = "select Convert(varchar(9),dockdt,6) as dockdt,*,dockno+docksf as docket,csgncd+char(32)+char(58)+char(32)+csgnnm as consignee,csgecd+char(32)+char(58)+char(32)+csgenm as consignor from vw_docket_net where dkt_cancel = 'Y'  " + whereCri + whereCri_cust + " and convert(varchar,dockdt,106) between convert(datetime,'" + FromDt + "',106) and convert(datetime,'" + ToDt + "',106)";
    }
	else if (val=="tot") 
    {
        sql = "select Convert(varchar(9),dockdt,6) as dockdt,*,dockno+docksf as docket,csgncd+char(32)+char(58)+char(32)+csgnnm as consignee,csgecd+char(32)+char(58)+char(32)+csgenm as consignor from vw_docket_net where paybas in ('P01','P02','P03','P04','P06','P08','P09') " + whereCri_cust + " and (dkt_cancel='N' or dkt_cancel is not null) " + whereCri + " and convert(varchar,dockdt,106) between convert(datetime,'" + FromDt + "',106) and convert(datetime,'" + ToDt + "',106)";
    }
	else if (val=="tot_M") 
    {
        sql = "select Convert(varchar(9),dockdt,6) as dockdt,*,dockno+docksf as docket,csgncd+char(32)+char(58)+char(32)+csgnnm as consignee,csgecd+char(32)+char(58)+char(32)+csgenm as consignor from vw_docket_net where TRN_MOD in ('1','2','3','4') " + whereCri_cust + " and (dkt_cancel='N' or dkt_cancel is not null) " + whereCri + " and convert(varchar,dockdt,106) between convert(datetime,'" + FromDt + "',106) and convert(datetime,'" + ToDt + "',106)";
    }
	else if(val=="1") 
    {
        sql = "select Convert(varchar(9),dockdt,6) as dockdt,*,dockno+docksf as docket,csgncd+char(32)+char(58)+char(32)+csgnnm as consignee,csgecd+char(32)+char(58)+char(32)+csgenm as consignor from vw_docket_net where TRN_MOD in ('1') " + whereCri_cust + " and (dkt_cancel='N' or dkt_cancel is not null) " + whereCri + " and convert(varchar,dockdt,106) between convert(datetime,'" + FromDt + "',106) and convert(datetime,'" + ToDt + "',106)";
    }
	else if(val=="2")
    {
        sql = "select Convert(varchar(9),dockdt,6) as dockdt,*,dockno+docksf as docket,csgncd+char(32)+char(58)+char(32)+csgnnm as consignee,csgecd+char(32)+char(58)+char(32)+csgenm as consignor from vw_docket_net where TRN_MOD in ('2') " + whereCri_cust + " and (dkt_cancel='N' or dkt_cancel is not null) " + whereCri + " and convert(varchar,dockdt,106) between convert(datetime,'" + FromDt + "',106) and convert(datetime,'" + ToDt + "',106)";
    }
	else if(val=="3")
    {
        sql = "select Convert(varchar(9),dockdt,6) as dockdt,*,dockno+docksf as docket,csgncd+char(32)+char(58)+char(32)+csgnnm as consignee,csgecd+char(32)+char(58)+char(32)+csgenm as consignor from vw_docket_net where TRN_MOD in ('3') " + whereCri_cust + " and (dkt_cancel='N' or dkt_cancel is not null) " + whereCri + " and convert(varchar,dockdt,106) between convert(datetime,'" + FromDt + "',106) and convert(datetime,'" + ToDt + "',106)";
    }
	else if(val=="4") 
    {
        sql = "select Convert(varchar(9),dockdt,6) as dockdt,*,dockno+docksf as docket,csgncd+char(32)+char(58)+char(32)+csgnnm as consignee,csgecd+char(32)+char(58)+char(32)+csgenm as consignor from vw_docket_net where TRN_MOD in ('4') " + whereCri_cust + " and (dkt_cancel='N' or dkt_cancel is not null) " + whereCri + " and convert(varchar,dockdt,106) between convert(datetime,'" + FromDt + "',106) and convert(datetime,'" + ToDt + "',106)";
    }
    //Response.Write(sql);  
	    //LblRptName.Text = "";
        //LblRptName.Text = "LOCATION:-" + Convert.ToString(Request.QueryString["Location"]) + "";
        //lblDateRange.Text = Convert.ToString(Request.QueryString["daterange"]);
        //lblLocation.Text = Convert.ToString(Request.QueryString["loccode1"]); 
        if (!IsPostBack)
        {
            BindTheData();
            GrdToPayFollow.HeaderRow.Cells[1].Text = Convert.ToString(Session["DocketCalledAs"]);
            GrdToPayFollow.HeaderRow.Cells[5].Text = Convert.ToString(Session["DocketCalledAs"]) + " Date";
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
        DataColumn dc = new DataColumn("SR.No", typeof(Int32));
        DataRow dr;
        Int32 i = ds.Tables["DocketDtl"].Rows.Count;
        ds.Tables["DocketDtl"].Columns.Add(dc);
        for (int j = 1; j <= i; j++)
        {
            dr = ds.Tables["DocketDtl"].Rows[j-1];
            dr["SR.No"] = j;
        }
        ds.Tables["DocketDtl"].AcceptChanges();  
        GrdToPayFollow.DataSource = ds.Tables["DocketDtl"];// cmd.ExecuteReader(CommandBehavior.CloseConnection);//
        GrdToPayFollow.DataBind();
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
        //System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("Excel1.csv"), false);

        ////Response.AddHeader("content-disposition", "attachment;filename=FileName.xls");

        //// First we will write the headers.
        //SqlDataAdapter sqlDA = new SqlDataAdapter(strqry, cn);
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
        //// Now write all the rows.
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
        if (e.Row.RowType == DataControlRowType.Header)
        {
            
                GridView oGridView = (GridView)sender;
                GridViewRow oGridViewRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);
                TableCell oTableCell = new TableCell();
                if (q_select == "custwise")
                {
                    oTableCell.Text = "Customer Code : " + loccode1 + "";
                }
                else if (q_select == "locwise")
                {
                    oTableCell.Text = "Location Code : " + loccode1 + "";
                }
                oTableCell.HorizontalAlign = HorizontalAlign.Left;
                oTableCell.Font.Bold = true;
                oTableCell.CssClass = "blackfnt"; 
                oTableCell.ColumnSpan = 8;
                oGridViewRow.Cells.Add(oTableCell);
                oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);
            
        }
    }
}
