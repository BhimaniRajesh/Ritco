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
    //SqlConnection cn = new SqlConnection("Data Source=202.87.45.72;Initial Catalog=ASL_Live;User ID=sa;Password=ecfy@pra$$ana");
    //SqlConnection cn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_VER2_LIVE"); 
    //SqlConnection cn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_Ver2_LIVE"); 
    SqlConnection cn;
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //Session["SqlProvider"] = "data source=202.87.45.69;UID=sa;PWD=!@ecfy#$;Database=Webxpress_new;";
        if (!IsPostBack)
        {
            Array str, str1;
            String fdate, tdate;
            fdate = Request.QueryString["FrmDate"];
            tdate = Request.QueryString["ToDate"];
            str = fdate.Split('/');
            str1 = tdate.Split('/');
            string FmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str))[1]));//return month name
            string TmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str1))[1]));//return month name
            //CultureInfo a = CultureInfo.CurrentCulture;  
            ////TxtDateRange.Text = (FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2] + " -- " + TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2]);
            TxtDateRange.Text = fn.Mydatedisplay(fdate) + " -- " + fn.Mydatedisplay(tdate);
            TxtFDt.Text = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];
            TxtTDt.Text = TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2];
            TxtRO.Text = Request.QueryString["RO"];
            txtLocation.Text = Request.QueryString["LocCode"];
            TxtCCode.Text = Request.QueryString["CCode"];
            lblDateRange.Text = TxtDateRange.Text;
            lblLocation.Text = txtLocation.Text;
            lblCCode.Text = TxtCCode.Text == "" ? "All" : lblCCode.Text;
            lblRO.Text = TxtRO.Text;
            //DateTime d1,d2; 
            //d1 = Convert.ToDateTime(fdate);
            //d2 = Convert.ToDateTime(tdate);
            //lblDateRange.Text = d1.ToString("dd MMM yy") + " -- " + d2.ToString("dd MMM yy");
            BindTheData();
            ((Table)(GrdPaidFollow.Controls[0])).Rows[1].Cells[3].Text = "Paid " + Convert.ToString((Session["DocketCalledAs"])) + " Booked";
        }
    }
    public void BindTheData()
    {
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = cn;
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = "webx_paid_follow";
        cmd.Parameters.AddWithValue("@FROMDT", TxtFDt.Text);
        cmd.Parameters.AddWithValue("@TODT", TxtTDt.Text);
        cmd.Parameters.AddWithValue("@RO", TxtRO.Text);
        cmd.Parameters.AddWithValue("@ORGNCD", txtLocation.Text);
        cmd.Parameters.AddWithValue("@LOCTYP", TxtCCode.Text);
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        if (cn.State==ConnectionState.Closed)
        {  
            cn.Open();
        }
        sqlDA.Fill(ds, "PaidFollow");
        GrdPaidFollow.DataSource = ds.Tables["PaidFollow"];   
        GrdPaidFollow.DataBind();  
    }
    public void PageIndexChanged_Click(object sender, DataGridPageChangedEventArgs e)
    {
        GrdPaidFollow.CurrentPageIndex = e.NewPageIndex;
        BindTheData();
    }
    public void SortCommand_Click(object sender, DataGridSortCommandEventArgs e)
    {
        //str = " ORDER BY " + e.SortExpression;
        DataView dv = new DataView();
        dv = ds.Tables["PaidFollow"].DefaultView;
        dv.Sort = e.SortExpression;
        GrdPaidFollow.DataSource = ds.Tables["PaidFollow"];
        GrdPaidFollow.DataBind();  
        //BindTheData();
    }
    //Boolean IsPageIndex;
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
    //    IsPageIndex = true;
    //    if (GridViewSortExpression != string.Empty)
    //    {
    //        if (IsPageIndex)
    //        {

    //            ds.Tables[0].DefaultView.Sort = string.Format("{0} {1}", GridViewSortExpression, GridViewSortDirection);
    //        }
    //        else
    //        {
    //            ds.Tables[0].DefaultView.Sort = string.Format("{0} {1}", GridViewSortExpression, GetSortDirection());

    //        }
    //    }
    //    BindGrid();
        //////////GrdPaidFollow.DataSource = ds.Tables[0];
        //////////GrdPaidFollow.PageIndex = e.NewPageIndex;
        //////////BindGrid(); 
        //////////GrdPaidFollow.DataBind();

    }
   
    protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
    {

        //GridViewSortExpression = e.SortExpression;
        //int pageIndex = GrdPaidFollow.PageIndex;
        //IsPageIndex = false;
        //if (GridViewSortExpression != string.Empty)
        //{
        //    if (IsPageIndex)
        //    {

        //        ds.Tables["PaidFollow"].DefaultView.Sort = string.Format("{0} {1}", GridViewSortExpression, GridViewSortDirection);
        //    }
        //    else
        //    {
        //        ds.Tables["PaidFollow"].DefaultView.Sort = string.Format("{0} {1}", GridViewSortExpression, GetSortDirection());
        //    }
        //}
        //BindGrid();
        //GrdPaidFollow.DataSource = ds.Tables["PaidFollow"];
        //GrdPaidFollow.DataBind();  

    }
    //private string GridViewSortExpression
    //{

    //    get { return ViewState["SortExpression"] as string ?? string.Empty; }

    //    set { ViewState["SortExpression"] = value; }

    //}

    //private string GetSortDirection()
    //{
    //    switch (GridViewSortDirection)
    //    {
    //        case "ASC":
    //            GridViewSortDirection = "DESC";
    //            break;
    //        case "DESC":
    //            GridViewSortDirection = "ASC";
    //            break;
    //    }
    //    return GridViewSortDirection;

    //}
    //private string GridViewSortDirection
    //{

    //    get { return ViewState["SortDirection"] as string ?? "ASC"; }

    //    set { ViewState["SortDirection"] = value; }

    //}
    Int32 tlb1, tlb2, tlb3, tlb4;
    Decimal tl1, tl2, tl3;
    public void eventhandler(object Sender, DataGridItemEventArgs E)
    {
     
        if (E.Item.ItemType != ListItemType.Header && E.Item.ItemType != ListItemType.Footer)
        {
            E.Item.Cells[0].Text = Convert.ToString(E.Item.DataSetIndex + 1);
            E.Item.Cells[0].CssClass = "blackfnt";
            LinkButton lb1, lb2, lb3, lb4;
            Label l1, l2, l3;
            lb1 = (LinkButton)E.Item.FindControl("lb1");
            lb2 = (LinkButton)E.Item.FindControl("lb2");
            lb3 = (LinkButton)E.Item.FindControl("lb3");
            lb4 = (LinkButton)E.Item.FindControl("lb4");
            if (lb1.Text == "0")
            {
                lb1.Visible = false;
                E.Item.Cells[3].Text = "0";
                E.Item.CssClass = "blackfnt"; 
            }
            if (lb2.Text == "0")
            {
                lb2.Visible = false;
                E.Item.Cells[4].Text = "0";
                E.Item.CssClass = "blackfnt"; 
            }
            if (lb3.Text == "0")
            {
                lb3.Visible = false;
                E.Item.Cells[6].Text = "0";
                E.Item.CssClass = "blackfnt"; 
            }
            if (lb4.Text == "0")
            {
                lb4.Visible = false;
                E.Item.Cells[8].Text = "0";
                E.Item.CssClass = "blackfnt"; 
            }
            l1 = (Label)E.Item.FindControl("l1");
            l2 = (Label)E.Item.FindControl("l2");
            l3 = (Label)E.Item.FindControl("l3");
            tlb1 += Convert.ToInt32((lb1.Text == "" || lb1.Text == System.DBNull.Value.ToString()) ? "0" : lb1.Text);
            tlb2 += Convert.ToInt32((lb2.Text == "" || lb2.Text == System.DBNull.Value.ToString()) ? "0" : lb2.Text);
            tlb3 += Convert.ToInt32((lb3.Text == "" || lb3.Text == System.DBNull.Value.ToString()) ? "0" : lb3.Text);
            tlb4 += Convert.ToInt32((lb4.Text == "" || lb4.Text == System.DBNull.Value.ToString()) ? "0" : lb4.Text);
            tl1 += Convert.ToDecimal((l1.Text == "" || l1.Text == System.DBNull.Value.ToString()) ? "0.00" : l1.Text);
            tl2 += Convert.ToDecimal((l2.Text == "" || l2.Text == System.DBNull.Value.ToString()) ? "0.00" : l2.Text);
            tl3 += Convert.ToDecimal((l3.Text == "" || l3.Text == System.DBNull.Value.ToString()) ? "0.00" : l3.Text);      
        }
        if (E.Item.ItemType == ListItemType.Footer)
        {
            E.Item.CssClass = "blackfnt";
            E.Item.Font.Bold = true;   
            E.Item.Cells[3].Text = tlb1.ToString();
            E.Item.Cells[4].Text = tlb2.ToString();
            E.Item.Cells[5].Text = tl1.ToString();
            E.Item.Cells[6].Text = tlb3.ToString();
            E.Item.Cells[7].Text = tl2.ToString();
            E.Item.Cells[8].Text = tlb4.ToString();
            E.Item.Cells[9].Text = tl3.ToString();
            

        }

    }
    public void gotolink(object Sender, DataGridCommandEventArgs e)
    {
        // str = " ORDER BY " + e.SortExpression;
        // BindTheData();
        string strqry;
        strqry = "";
        Label l1,l2;
        string a,b;
        a = "";
        b = "";
        l1 = (Label)e.Item.FindControl("lblloccode");
        l2 = (Label)e.Item.FindControl("lbllocation");
        if (l1 != null)
        {
            a = l1.Text;
            b = l1.Text + ":" + l2.Text;
        }
        switch (e.CommandName)
        {
            case "Paid_docket" :
                strqry = "SELECT cast(ded_oth as decimal(38,00)) as ded_oth,*, CONVERT(varchar, ARRV_DT, 106) AS arrv_dt_small, CONVERT(varchar, MRSDT, 106) AS mrsdt_small, CONVERT(varchar, CLOSEDT, 106) AS closedt_small FROM Paid_Mr WHERE (ORGNCD = '" + a + "') AND (DOCKDT BETWEEN '" + TxtFDt.Text + "' AND '" + TxtTDt.Text + "')";
                Response.Redirect("FrmDocketDetail.aspx?str=" + strqry + "&name=" + b + "&RptName=Booked MR Report");  
                break; 
            case "MR_gen":
                strqry = "SELECT cast(ded_oth as decimal(38,00)) as ded_oth,*, CONVERT(varchar, ARRV_DT, 106) AS arrv_dt_small, CONVERT(varchar, MRSDT, 106) AS mrsdt_small, CONVERT(varchar, CLOSEDT, 106) AS closedt_small FROM Paid_Mr WHERE (ORGNCD = '" + a + "') AND (DOCKDT BETWEEN '" + TxtFDt.Text + "' AND '" + TxtTDt.Text + "') AND (PaidMR <> 'N' OR PaidMR IS NOT NULL) AND (mrsno IS NOT NULL)";
                Response.Redirect("FrmDocketDetail.aspx?str=" + strqry + "&name=" + b + "&RptName=Generated MR Report");  
                break;
            case "MR_Close_money":
                strqry = "SELECT cast(ded_oth as decimal(38,00)) as ded_oth,*, CONVERT(varchar, ARRV_DT, 106) AS arrv_dt_small, CONVERT(varchar, MRSDT, 106) AS mrsdt_small, CONVERT(varchar, CLOSEDT, 106) AS closedt_small FROM Paid_Mr WHERE (ORGNCD = '" + a + "') AND (DOCKDT BETWEEN '" + TxtFDt.Text + "' AND '" + TxtTDt.Text + "') AND (Closedt IS NOT NULL)";
                Response.Redirect("FrmDocketDetail.aspx?str=" + strqry + "&name=" + b + "&RptName=Closed MR Report");  
                break;
            case "MR_not_close":
                strqry = "SELECT cast(ded_oth as decimal(38,00)) as ded_oth,*, CONVERT(varchar, ARRV_DT, 106) AS arrv_dt_small, CONVERT(varchar, MRSDT, 106) AS mrsdt_small, CONVERT(varchar, CLOSEDT, 106) AS closedt_small FROM Paid_Mr WHERE (ORGNCD = '" + a + "') AND paidmr<>'N' and (DOCKDT BETWEEN '" + TxtFDt.Text + "' AND '" + TxtTDt.Text + "') AND (Closedt IS NULL)";
                //SELECT *, CONVERT(varchar, ARRV_DT, 106) AS arrv_dt_small, CONVERT(varchar, MRSDT, 106) AS mrsdt_small, CONVERT(varchar, CLOSEDT, 106) AS closedt_small FROM Paid_Mr WHERE (ORGNCD = '" + a + "') AND paidmr<>'N' and (DOCKDT BETWEEN '" + TxtFDt.Text + "' AND '" + TxtTDt.Text + "')AND (Closedt IS NULL)
                Response.Redirect("FrmDocketDetail.aspx?str=" + strqry + "&name=" + b + "&RptName=Outstanding MR Report");  
                break;
            default:
                break;
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = cn;
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = "webx_paid_follow";
        cmd.Parameters.AddWithValue("@FROMDT", TxtFDt.Text);
        cmd.Parameters.AddWithValue("@TODT", TxtTDt.Text);
        cmd.Parameters.AddWithValue("@RO", TxtRO.Text);
        cmd.Parameters.AddWithValue("@ORGNCD", txtLocation.Text);
        cmd.Parameters.AddWithValue("@LOCTYP", TxtCCode.Text);
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        if (cn.State == ConnectionState.Closed)
        {
            cn.Open();
        }
        sqlDA.Fill(ds, "PaidFollow");
        Session["xyz"] = ds;
        Response.Redirect("FrmPaidFollowUpRPT.aspx");  
        //ReportDocument rd;
        //rd = new ReportDocument();
        //rd.Load(Server.MapPath("RptPaidFollow.rpt"));
        //rd.SetDataSource(ds.Tables[0]);
        //CrystalReportViewer1.ReportSource = rd;
        //CrystalReportViewer1.DataBind();  
    }
    protected void cmdexcel_Click(object sender, EventArgs e)
    {
        //System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("PaidFollowUp.csv"), false);
        //SqlCommand cmd = new SqlCommand();
        //cmd.Connection = cn;
        //cmd.CommandType = CommandType.StoredProcedure;
        //cmd.CommandText = "webx_paid_follow";
        //cmd.Parameters.AddWithValue("@FROMDT", TxtFDt.Text);
        //cmd.Parameters.AddWithValue("@TODT", TxtTDt.Text);
        //cmd.Parameters.AddWithValue("@RO", TxtRO.Text);
        //cmd.Parameters.AddWithValue("@ORGNCD", txtLocation.Text);
        //cmd.Parameters.AddWithValue("@LOCTYP", TxtCCode.Text);
        //SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        //if (cn.State == ConnectionState.Closed)
        //{
        //    cn.Open();
        //}
        //sqlDA.Fill(ds, "PaidFollow");
        //// (DataTable)Session["dt1"];
        //DataTable dt2 = ds.Tables["PaidFollow"];
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
        //System.IO.FileStream fs = null;
        //fs = System.IO.File.Open(Server.MapPath("PaidFollowUp.csv"), System.IO.FileMode.Open);
        //byte[] btFile = new byte[fs.Length];
        //fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        //fs.Close();
        //Response.ContentType = "application/vnd.ms-excel";
        //Response.AddHeader("Content-disposition", "attachment; filename=" + "PaidFollowUp.csv");
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
