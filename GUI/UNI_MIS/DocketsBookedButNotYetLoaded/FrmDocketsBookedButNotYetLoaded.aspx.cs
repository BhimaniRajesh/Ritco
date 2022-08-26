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
public partial class FrmPaidFollowUp : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    String str = "";
    //SqlConnection cn = new SqlConnection("Data Source=202.87.45.72;Initial Catalog=PTN_Live;User ID=sa;Password=ecfy@pra$$ana");
    SqlConnection cn;// = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_VER2_LIVE"); 
    //SqlConnection cn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_Ver2_LIVE"); 
    //SqlConnection cn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=$rcpl@@p@$$;Database=RCPL_VER2_LIVE");
    private GridViewHelper helper;
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!IsPostBack)
        {
            
            Array str, str1;
            String fdate, tdate;
            fdate = Request.QueryString["FrmDate"];
            tdate = Request.QueryString["ToDate"];
            str = fdate.Split('/');
            str1 = tdate.Split('/');
            //((string[])(str))[0]
            string FmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str))[1]));//return month name
            string TmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str1))[1]));//return month name
            //CultureInfo a = CultureInfo.CurrentCulture;  
            //TxtDateRange.Text = (FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2] + " -- " + TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2]);
            TxtDateRange.Text = fn.Mydatedisplay(fdate) + " -- " + fn.Mydatedisplay(tdate);
            TxtFDt.Text = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];
            TxtTDt.Text = TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2];
            //TxtDateRange.Text = Request.QueryString["FrmDate"] + "-" + Request.QueryString["ToDate"];
            TxtRO.Text = Request.QueryString["RO"];
            txtLocation.Text = Request.QueryString["LocCode"];
            //TxtCCode.Text = Request.QueryString["CCode"];
            lbldaterange.Text = TxtDateRange.Text;
            lblLocation.Text = txtLocation.Text;
            lblRO.Text = TxtRO.Text;
            //lblCCode.Text = TxtCCode.Text;    
            //BindTheData();
        }
        BindTheData();
        //GrdLoadUnload.Rows[GrdLoadUnload.Rows.Count + 1].CssClass = "blackfnt";
        //GridViewRow gr = GrdLoadUnload.Rows[GrdLoadUnload.Rows.Count - 1];
        //gr.CssClass = "blackfnt";
        GrdLoadUnload.HeaderRow.Cells[4].Text = "Total " + Convert.ToString((Session["DocketCalledAs"])) + " Booked";
        GrdLoadUnload.HeaderRow.Cells[5].Text = "Total " + Convert.ToString((Session["DocketCalledAs"])) + " W/O LS For MF";
        GrdLoadUnload.HeaderRow.Cells[6].Text = "Total " + Convert.ToString((Session["DocketCalledAs"])) + " With LF For MF";
        GrdLoadUnload.HeaderRow.Cells[7].Text = Convert.ToString((Session["DocketCalledAs"])) + " Loaded in THC";
        GrdLoadUnload.HeaderRow.Cells[8].Text = Convert.ToString((Session["DocketCalledAs"])) + " (Same Delivery Locations)";
    }
    public void BindTheData()
    {
        GrdLoadUnload.DataSource = null;
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = cn;
        cmd.CommandType = CommandType.StoredProcedure;
        //exec webx_unloading_locading '01 june 07','22 june 07','All','All'
        cmd.CommandText = "usp_disc_load_analy2";
        cmd.Parameters.AddWithValue("@FROMDT", TxtFDt.Text);
        cmd.Parameters.AddWithValue("@TODT", TxtTDt.Text);
        cmd.Parameters.AddWithValue("@RO", TxtRO.Text);
        cmd.Parameters.AddWithValue("@ORGNCD", txtLocation.Text);
        //cmd.Parameters.AddWithValue("@LOCTYP", TxtCCode.Text);
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        if (cn.State==ConnectionState.Closed)
        {  
            cn.Open();
        }
        //if (ds.Tables.Contains("Dockets")) { ds.Tables["Dockets"].Columns.Clear(); } 
        sqlDA.Fill(ds, "Dockets");
        GridViewHelper helper = new GridViewHelper(this.GrdLoadUnload);
        string[] cols = new string[1];
        cols[0] = "report_loc";
        helper.RegisterGroup(cols, true, true);
        helper.GroupHeader += new GroupEvent(helper_GroupHeader);
        helper.RegisterSummary("tot1", SummaryOperation.Sum);
        helper.RegisterSummary("tot2", SummaryOperation.Sum);
        helper.RegisterSummary("tot3", SummaryOperation.Sum);
        helper.RegisterSummary("tot4", SummaryOperation.Sum);
        helper.RegisterSummary("tot5", SummaryOperation.Sum);
        helper.RegisterSummary("tot1", SummaryOperation.Sum, "report_loc");
        helper.RegisterSummary("tot2", SummaryOperation.Sum, "report_loc");
        helper.RegisterSummary("tot3", SummaryOperation.Sum, "report_loc");
        helper.RegisterSummary("tot4", SummaryOperation.Sum, "report_loc");
        helper.RegisterSummary("tot5", SummaryOperation.Sum, "report_loc");
        helper.GroupSummary += new GroupEvent(helper_GroupSummary);
        GrdLoadUnload.DataSource = ds.Tables["Dockets"];
        GrdLoadUnload.DataBind();
        GrdLoadUnload.HeaderRow.CssClass = "bgbluegrey";
        if (ds.Tables["Dockets"].Rows.Count <= 0)
        {
            cmdexcel.Visible = false;  
        }
        
    }
    private void helper_GroupHeader(string groupName, object[] values, GridViewRow row)
    {
        if (groupName == "report_loc")
        {
            row.Cells[0].VerticalAlign = VerticalAlign.Top;  
            row.Cells[0].HorizontalAlign = HorizontalAlign.Left;    
            row.CssClass = "blackfnt";
            row.Cells[0].Font.Bold = true;   
            row.BackColor = System.Drawing.Color.FromName("#D4E0E7");
            row.Cells[0].Text = "&nbsp;&nbsp;" + row.Cells[0].Text;
        }
    }
    private void helper_GroupSummary(string groupName, object[] values, GridViewRow row)
    {
        //row.CssClass = "blackfnt";
        row.BackColor = System.Drawing.Color.White;
        row.Cells[0].Font.Bold = true;
        row.Cells[0].HorizontalAlign = HorizontalAlign.Left;
        row.Cells[0].VerticalAlign = VerticalAlign.Top;  
        row.Cells[0].Text = " Total";
    }

    protected void abc(object sender, EventArgs e)
    {

        GrdLoadUnload.SelectedIndex = ((GridViewRow)((LinkButton)sender).Parent.Parent).DataItemIndex;
       // string categoryName = ((DropDownList)GridView1.SelectedRow.FindControl("cmb1")).SelectedItem.Value;
       //Response.Write(categoryName);
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string sql,Type;
        sql = "";
        Type = "";
        if (e.CommandName == "LnkDocketsBooked")
        {
            string cbolocation = ((Label)GrdLoadUnload.SelectedRow.FindControl("lblloccode")).Text;
            string location = ((Label)GrdLoadUnload.SelectedRow.FindControl("lbllocation")).Text;
            sql = "select *,orgncd@char(32)@char(45)@char(32)@destcd as origin,dockno@docksf as docket,csgncd@' : '@csgnnm as consignee,csgecd@' : '@csgenm as consignor  from vw_Docket_net p,webx_location a where p.orgncd = a.locCode and ( a.op_bkg='Y') and a.activeflag = 'Y' and p.dkt_cancel = 'N'  and a.locCode = '" + cbolocation + "' and Convert(varchar,dockdt,106)  between  Convert(datetime,'" + TxtFDt.Text + "',106)  and  Convert(datetime,'" + TxtTDt.Text + "',106)";
            Type = "Total " + Convert.ToString((Session["DocketCalledAs"])) + " Booked";
            Response.Redirect("FrmDocketDetail.aspx?RptType=" + Type + "&str=" + sql + "&daterange=" + TxtDateRange.Text + "&Location=" + location + "");  
        }
        else if (e.CommandName == "LnkDWOSheet")
        {
            //GrdLoadUnload.SelectedIndex = ((GridViewRow)((LinkButton)sender).Parent.Parent).DataItemIndex;
            string cbolocation = ((Label)GrdLoadUnload.SelectedRow.FindControl("lblloccode")).Text;
            string location = ((Label)GrdLoadUnload.SelectedRow.FindControl("lbllocation")).Text;
            sql = "select *,orgncd@char(32)@char(45)@char(32)@destcd as origin,dockno@docksf as docket,csgncd@' : '@csgnnm as consignee,csgecd@' : '@csgenm as consignor from vw_Docket_net p,webx_location a where p.orgncd = a.locCode and ( a.op_bkg='Y') and reassign_destcd<>a.loccode and a.activeflag = 'Y' and p.dkt_cancel = 'N' and a.locCode = '" + cbolocation + "' and Convert(varchar,dockdt,106)  between  Convert(datetime,'" + TxtFDt.Text + "',106)  and  Convert(datetime,'" + TxtTDt.Text + "',106) and isnull(p.ls,'N') = 'N' and mf is null and p.doc_curloc=a.loccode";
            Type =  Convert.ToString((Session["DocketCalledAs"])) + " W/O Loading Sheet";
            //sql = "select * from vw_MF_details t  where ToBH_CODE in (select sourcehb from webx_thchdr where thcno=t.thcno and sourcehb='BLR' ) and CONVERT(VARCHAR,thcdt,106) between CONVERT(DATETIME,'25 Jun 07',106) and CONVERT(DATETIME,'25 Jun 07',106) "
            Response.Redirect("FrmDocketDetail.aspx?RptType=" + Type + "&str=" + sql + "&daterange=" + TxtDateRange.Text + "&Location=" + location + "");
        }
        else if (e.CommandName == "LnkDWSheet")
        {

            //GrdLoadUnload.SelectedIndex = ((GridViewRow)((LinkButton)sender).Parent.Parent).DataItemIndex;
            string cbolocation = ((Label)GrdLoadUnload.SelectedRow.FindControl("lblloccode")).Text;
            sql = "select *,orgncd@char(32)@char(45)@char(32)@destcd as origin,dockno@docksf as docket,csgncd@' : '@csgnnm as consignee,csgecd@' : '@csgenm as consignor from vw_Docket_net p,webx_location a where p.orgncd = a.locCode and ( a.op_bkg='Y') and a.activeflag = 'Y' and p.dkt_cancel = 'N' and a.locCode = '" + cbolocation + "' and Convert(varchar,dockdt,106)  between  Convert(datetime,'" + TxtFDt.Text + "',106)  and  Convert(datetime,'" + TxtTDt.Text + "',106) and p.thcno is null and (p.mf is not null or (p.ls='Y' and p.mf is null)) and p.doc_curloc=a.loccode";
            Type =  Convert.ToString((Session["DocketCalledAs"])) + " With Loading Sheet";
            //SQL = "select * from vw_MF_details where tcbr='WLJ' and CONVERT(VARCHAR,tcdt,106) between CONVERT(DATETIME,'25 Jun 07',106) and CONVERT(DATETIME,'25 Jun 07',106)"
            string location = ((Label)GrdLoadUnload.SelectedRow.FindControl("lbllocation")).Text;
            Response.Redirect("FrmDocketDetail.aspx?RptType=" + Type + "&str=" + sql + "&daterange=" + TxtDateRange.Text + "&Location=" + location + "");
        }
        else if (e.CommandName == "LnkDTHC")
        {

            //GrdLoadUnload.SelectedIndex = ((GridViewRow)((LinkButton)sender).Parent.Parent).DataItemIndex;
            string cbolocation = ((Label)GrdLoadUnload.SelectedRow.FindControl("lblloccode")).Text;
            sql = "select *,orgncd@char(32)@char(45)@char(32)@destcd as origin,dockno@docksf as docket,csgncd@' : '@csgnnm as consignee,csgecd@' : '@csgenm as consignor  from vw_Docket_net p,webx_location a where p.orgncd = a.locCode and ( a.op_bkg='Y') and a.activeflag = 'Y' and p.dkt_cancel = 'N' and a.locCode = '" + cbolocation + "' and Convert(varchar,dockdt,106)  between  Convert(datetime,'" + TxtFDt.Text + "',106)  and  Convert(datetime,'" + TxtTDt.Text + "',106) and (doc_curloc<>a.loccode or (doc_curloc=a.loccode and thcno is not null))";
            string location = ((Label)GrdLoadUnload.SelectedRow.FindControl("lbllocation")).Text;
            Type =  Convert.ToString((Session["DocketCalledAs"]))+" Loaded In THC";
            Response.Redirect("FrmDocketDetail.aspx?RptType=" + Type + "&str=" + sql + "&daterange=" + TxtDateRange.Text + "&Location=" + location + "");
        }
        else if (e.CommandName == "LnkDSameLoc")
        {

            //GrdLoadUnload.SelectedIndex = ((GridViewRow)((LinkButton)sender).Parent.Parent).DataItemIndex;
            string cbolocation = ((Label)GrdLoadUnload.SelectedRow.FindControl("lblloccode")).Text;
            sql = "select *,orgncd@char(32)@char(45)@char(32)@destcd as origin,dockno@docksf as docket,csgncd@' : '@csgnnm as consignee,csgecd@' : '@csgenm as consignor from vw_Docket_net where  orgncd  = '" + cbolocation + "' and reassign_destcd=orgncd and doc_curloc=orgncd and Convert(varchar,dockdt,106)  between  Convert(datetime,'" + TxtFDt.Text + "',106)  and  Convert(datetime,'" + TxtTDt.Text + "',106)";
            string location = ((Label)GrdLoadUnload.SelectedRow.FindControl("lbllocation")).Text;
            Type =  Convert.ToString((Session["DocketCalledAs"]))+" (Same Delivery Location)";
            Response.Redirect("FrmDocketDetail.aspx?RptType=" + Type + "&str=" + sql + "&daterange=" + TxtDateRange.Text + "&Location=" + location + "");
        }
    }
    protected void PageIndexChanged_Click(object sender, GridViewPageEventArgs e)
    {
        GrdLoadUnload.PageIndex = e.NewPageIndex;
        BindTheData();
        //GrdLoadUnload.DataBind(); 
    }
    public void SortCommand_Click(object sender, DataGridSortCommandEventArgs e)
    {
        //str = " ORDER BY " + e.SortExpression;
        DataView dv = new DataView();
        dv = ds.Tables["Dockets"].DefaultView;
        dv.Sort = e.SortExpression;
        GrdLoadUnload.DataSource = ds.Tables["Dockets"];
        GrdLoadUnload.DataBind();  
        //BindTheData();
    }
    
    public void eventhandler(object Sender, DataGridItemEventArgs E)
    {
     
        if (E.Item.ItemType != ListItemType.Header && E.Item.ItemType != ListItemType.Footer)
        {
            E.Item.Cells[0].Text = Convert.ToString(E.Item.DataSetIndex + 1);
            E.Item.Cells[0].CssClass = "blackfnt";   
        }

    }
    //public void gotolink(object Sender, DataGridCommandEventArgs e)
    //{
    //    // str = " ORDER BY " + e.SortExpression;
    //    // BindTheData();
    //    string strqry;
    //    strqry = "";
    //    Label l1, l2;
    //    string a, b;
    //    a = "";
    //    b = "";
    //    l1 = (Label)e.Item.FindControl("lblloccode");
    //    l2 = (Label)e.Item.FindControl("lbllocation");
    //    if (l1 != null)
    //    {
    //        a = l1.Text;
    //        b = l1.Text + ":" + l2.Text;
    //    }
    //    switch (e.CommandName)
    //    {
    //            //SELECT *, CONVERT(varchar, ARRV_DT, 106) AS arrv_dt_small, CONVERT(varchar, MRSDT, 106) AS mrsdt_small FROM VW_UNI_PAID_Folleup WHERE (ORGNCD = '" + a + "') AND (DOCKDT BETWEEN '" + TxtFDt.Text + "' AND '" + TxtTDt.Text + "') AND (Closedt IS NULL)
    //        case "booked" :
    //            strqry = "select *,dockno:docksf as docket, CONVERT(varchar, ARRV_DT, 106) AS arrv_dt_small, CONVERT(varchar, MRSDT, 106) AS mrsdt_small, CONVERT(varchar, dely_dt, 106) AS dely_dt_small, CONVERT(varchar, FINCLOSEDT, 106) AS finclosedt_small from vw_topay_arriv where destcd = '" + a + "' and dockdt between '" + TxtFDt.Text + "' and '" + TxtTDt.Text + "'";
    //            Response.Redirect("FrmDocketDetail.aspx?str=" + strqry + "&name=" + b + "&RptName=Booked MR Report");  
    //            break; 
    //        case "arrived":
    //            strqry = "select *,dockno:docksf as docket, CONVERT(varchar, ARRV_DT, 106) AS arrv_dt_small, CONVERT(varchar, MRSDT, 106) AS mrsdt_small, CONVERT(varchar, dely_dt, 106) AS dely_dt_small, CONVERT(varchar, FINCLOSEDT, 106) AS finclosedt_small from vw_topay_arriv where tohub_br='' and destcd = '" + a + "' and dockdt between '" + TxtFDt.Text + "' and '" + TxtTDt.Text + "'";
    //            Response.Redirect("FrmDocketDetail.aspx?str=" + strqry + "&name=" + b + "&RptName=Arrived MR Report");  
    //            break;
    //        case "generated":
    //            strqry = "select *,dockno:docksf as docket, CONVERT(varchar, ARRV_DT, 106) AS arrv_dt_small, CONVERT(varchar, MRSDT, 106) AS mrsdt_small, CONVERT(varchar, dely_dt, 106) AS dely_dt_small, CONVERT(varchar, FINCLOSEDT, 106) AS finclosedt_small from vw_topay_arriv where tohub_br='' and mrsno is not null and destcd = '" + a + "' and dockdt between '" + TxtFDt.Text + "' and '" + TxtTDt.Text + "'";
    //            Response.Redirect("FrmDocketDetail.aspx?str=" + strqry + "&name=" + b + "&RptName=Generated MR Report");  
    //            break;
    //        case "closed":
    //            strqry = "select *,dockno:docksf as docket, CONVERT(varchar, ARRV_DT, 106) AS arrv_dt_small, CONVERT(varchar, MRSDT, 106) AS mrsdt_small, CONVERT(varchar, dely_dt, 106) AS dely_dt_small, CONVERT(varchar, FINCLOSEDT, 106) AS finclosedt_small from vw_topay_arriv where tohub_br='' and mrsno is not null and finclosedt is not null and destcd = '" + a + "' and dockdt between '" + TxtFDt.Text + "' and '" + TxtTDt.Text + "'";
    //            Response.Redirect("FrmDocketDetail.aspx?str=" + strqry + "&name=" + b + "&RptName=Closed MR Report");
    //            break;
    //        case "out_docket":
    //            strqry = "select *,dockno:docksf as docket, CONVERT(varchar, ARRV_DT, 106) AS arrv_dt_small, CONVERT(varchar, MRSDT, 106) AS mrsdt_small, CONVERT(varchar, dely_dt, 106) AS dely_dt_small, CONVERT(varchar, FINCLOSEDT, 106) AS finclosedt_small from vw_topay_arriv where tohub_br='' and mrsno is not null and finclosedt is  null and destcd = '" + a + "' and dockdt between '" + TxtFDt.Text + "' and '" + TxtTDt.Text + "'";
    //            Response.Redirect("FrmDocketDetail.aspx?str=" + strqry + "&name=" + b + "&RptName=Outstanding MR Report");  
    //            break;
    //        default:
    //            break;
    //    }
    //}

    protected void Button1_Click(object sender, EventArgs e)
    {
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = cn;
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = "usp_disc_load_analy2";
        cmd.Parameters.AddWithValue("@FROMDT", TxtFDt.Text);
        cmd.Parameters.AddWithValue("@TODT", TxtTDt.Text);
        cmd.Parameters.AddWithValue("@RO", TxtRO.Text);
        cmd.Parameters.AddWithValue("@ORGNCD", txtLocation.Text);
    
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        if (cn.State == ConnectionState.Closed)
        {
            cn.Open();
        }
        sqlDA.Fill(ds, "Dockets");
        Session["Dockets"] = ds;
        Response.Redirect("FrmToPayFollowUpRPT.aspx");  
    }

    protected void cmdexcel_Click(object sender, EventArgs e)
    {
        //System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("Dockets.csv"), false);

        ////Response.AddHeader("content-disposition", "attachment;filename=FileName.xls");

        //SqlCommand cmd = new SqlCommand();
        //cmd.Connection = cn;
        //cmd.CommandType = CommandType.StoredProcedure;
        //cmd.CommandText = "usp_disc_load_analy2";
        //cmd.Parameters.AddWithValue("@FROMDT", TxtFDt.Text);
        //cmd.Parameters.AddWithValue("@TODT", TxtTDt.Text);
        //cmd.Parameters.AddWithValue("@RO", TxtRO.Text);
        //cmd.Parameters.AddWithValue("@ORGNCD", txtLocation.Text);
       
        //SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        //if (cn.State == ConnectionState.Closed)
        //{
        //    cn.Open();
        //}
        //sqlDA.Fill(ds, "Dockets");
        //DataTable dt2 = ds.Tables["Dockets"];

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
        //fs = System.IO.File.Open(Server.MapPath("Dockets.csv"), System.IO.FileMode.Open);
        //byte[] btFile = new byte[fs.Length];
        //fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        //fs.Close();
        //Response.ContentType = "application/vnd.ms-excel";
        //Response.AddHeader("Content-disposition", "attachment; filename=" + "Dockets.csv");
        //Response.ContentType = "application/octet-stream";
        //Response.BinaryWrite(btFile);
        //Response.End();

        //GrdLoadUnload.AllowPaging = false;
        //BindTheData();
        GrdLoadUnload.AllowPaging = false;
        GrdLoadUnload.BorderWidth = 1;
        GrdLoadUnload.CssClass = "blackfnt";
        GrdLoadUnload.Font.Size = 8;
        //GrdLoadUnload.Font.Names = verdana;
        GrdLoadUnload.BackColor = System.Drawing.Color.White;
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
        GrdLoadUnload.RenderControl(htmlWrite);

        //frm.Controls.Add(GrdLoadUnload);
        //frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();


        //int ind = 0;
        //int a = 0;
        //try
        //{
        //    GrdLoadUnload.AllowPaging = false;
        //    GrdLoadUnload.BorderWidth = 1;
        //    GrdLoadUnload.CssClass = "blackfnt";
        //    GrdLoadUnload.Font.Size = 8;
        //    //GrdLoadUnload.Font.Names = verdana;
        //    GrdLoadUnload.BackColor = System.Drawing.Color.White;
        //    Response.Clear();
        //    Response.AddHeader("Content-Disposition", "attachment;Filename=Docket_booked_yet_not_loaded.xls");
        //    Response.Charset = "";
        //    Response.ContentType = "application/vnd.xls";
        //    System.IO.StringWriter tw = new System.IO.StringWriter();
        //    System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

        //    BindTheData();
        //    GrdLoadUnload.RenderControl(hw);


        //    Response.Write(tw.ToString());
        //    Response.End();

        //}
        //catch (Exception ex1)
        //{
        //    throw ex1;
        //    // lblloc.Text = ex1.Message;
        //}

    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void GrdLoadUnload_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            LinkButton LnkDocketsBooked, LnkDWOSheet, LnkDWSheet, LnkDTHC, LnkDSameLoc;
            LnkDocketsBooked = (LinkButton)e.Row.FindControl("LnkDocketsBooked");
            LnkDWOSheet = (LinkButton)e.Row.FindControl("LnkDWOSheet");
            LnkDWSheet = (LinkButton)e.Row.FindControl("LnkDWSheet");
            LnkDTHC = (LinkButton)e.Row.FindControl("LnkDTHC");
            LnkDSameLoc = (LinkButton)e.Row.FindControl("LnkDSameLoc");

            if (LnkDocketsBooked.Text == "0")
            {
                LnkDocketsBooked.Text = "";
                e.Row.Cells[4].Text = "0";
                e.Row.Cells[4].CssClass = "blackfnt";
                //function.Font.Underline = true;
            }

            if (LnkDWOSheet.Text == "0")
            {
                LnkDWOSheet.Text = "";
                e.Row.Cells[5].Text = "0";
                e.Row.Cells[5].CssClass = "blackfnt";
                //function.Font.Underline = true;
            }

            if (LnkDWSheet.Text == "0")
            {
                LnkDWSheet.Text = "";
                e.Row.Cells[6].Text = "0";
                e.Row.Cells[6].CssClass = "blackfnt";
                //function.Font.Underline = true;
            }

            if (LnkDTHC.Text == "0")
            {
                LnkDTHC.Text = "";
                e.Row.Cells[7].Text = "0";
                e.Row.Cells[7].CssClass = "blackfnt";
                //function.Font.Underline = true;
            }

            if (LnkDSameLoc.Text == "0")
            {
                LnkDSameLoc.Text = "";
                e.Row.Cells[8].Text = "0";
                e.Row.Cells[8].CssClass = "blackfnt";
                //function.Font.Underline = true;
            }
        }

    }
}
