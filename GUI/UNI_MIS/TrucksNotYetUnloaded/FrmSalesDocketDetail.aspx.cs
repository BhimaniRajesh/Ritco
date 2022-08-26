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
    SqlConnection cn;// = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_VER2_LIVE");
    //SqlConnection cn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_Ver2_LIVE"); 
    //SqlConnection cn = new SqlConnection("data source=202.87.45.69;UID=sa;PWD=!@ECfy#$;Database=ASL_LIVE");
    string strqry,val,mode,sql;
    string FDate, TDate, loccode, location;
    protected void Page_Load(object sender, EventArgs e)
    {
    cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    val = Convert.ToString(Request.QueryString["val"]);  
    loccode = Convert.ToString(Request.QueryString["loccode"]);
    mode = Convert.ToString(Request.QueryString["mode"]);
    location = Convert.ToString(Request.QueryString["location"]);
    FDate = Convert.ToString(Request.QueryString["fromdate"]);
    TDate = Convert.ToString(Request.QueryString["todate"]);
    lblLocation.Text = loccode + " : " + location;
    lblrpttype.Text = mode;
    lblDateRange.Text = FDate + " - " + TDate;
    if (val=="expected")
    {
        sql = "select *,(select locname from webx_location where loccode= t1.thcbr) as location,convert(varchar,convert(datetime,thcdt),106) as thcdtD from vw_thchdr t1,webx_location t3 where t3.locCode = '" + loccode + "' and t1.sourcehb = t3.locCode and t1.tobh_code='Null'  and ( t3.op_Tranship='Y'  or t3.op_Dly='Y') and Convert(varchar,t1.thcdt,106)  between  Convert(datetime,'" + FDate + "',106)  and  Convert(datetime,'" + TDate + "',106)";
    }
    else if (val == "unloadedTHC")
    {
        sql = "select *,(select locname from webx_location where loccode= p1.thcbr) as location,convert(varchar,convert(datetime,thcdt),106) as thcdtD from vw_thchdr p1 ,webx_tur_hdr p2,webx_location t3 where t3.locCode = '" + loccode + "' and p1.thcno=p2.thcno and p2.TUR_ACTIVE='Y' and p1.tobh_code='Null'  and p1.sourcehb = t3.locCode  and ( t3.op_Tranship='Y'  or t3.op_Dly='Y') and Convert(varchar,p1.thcdt,106)  between  Convert(datetime,'" + FDate + "',106)  and  Convert(datetime,'" + TDate + "',106)";
    }
    else if (val == "unloadedTHCbal") 
    {
        sql = "select *,(select locname from webx_location where loccode= vw_thchdr.thcbr) as location,convert(varchar,convert(datetime,thcdt),106) as thcdtD from vw_thchdr  where sourcehb = '" + loccode + "' and tobh_code='Null' and Convert(varchar,thcdt,106)  between  Convert(datetime,'" + FDate + "',106)  and  Convert(datetime,'" + TDate + "',106) and thcno not in(select p1.thcno from vw_thchdr p1 ,webx_tur_hdr p2,webx_location t3 where t3.locCode = '" + loccode + "' and p1.thcno=p2.thcno and p2.TUR_ACTIVE='Y' and p1.tobh_code='Null'  and p1.sourcehb = t3.locCode  and ( t3.op_Tranship='Y' or t3.op_Dly='Y') and Convert(varchar,p1.thcdt,106)  between  Convert(datetime,'" + FDate + "',106)  and  Convert(datetime,'" + TDate + "',106))";
    }

	if (!IsPostBack)
    {
        BindTheData();
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
    protected void GrdToPayFollow_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label l1,l2;
            l1 = (Label)e.Row.FindControl("lblthcno");
            l2 = (Label)e.Row.FindControl("lblthcsf");
            l1.Text = l1.Text + l2.Text; 
        }
    }
}
