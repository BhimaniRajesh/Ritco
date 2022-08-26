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
    SqlConnection cn;// = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=$rcpl@@p@$$;Database=RCPL_VER2_LIVE"); 
    //SqlConnection cn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_Ver2_LIVE"); 
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
            lblDateRange.Text = TxtDateRange.Text;
            lblLocation.Text = txtLocation.Text;
            lblRO.Text = TxtRO.Text;
            //lblCCode.Text = TxtCCode.Text;    
            //BindTheData();
        }
        BindTheData();
    }
    public void BindTheData()
    {
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = cn;
        cmd.CommandType = CommandType.StoredProcedure;
        //exec webx_unloading_locading '01 june 07','22 june 07','All','All'
        cmd.CommandText = "webx_unloading_locading";
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
        if (ds.Tables.Contains("LoadUnload")) { ds.Tables["LoadUnload"].Columns.Clear(); } 
        sqlDA.Fill(ds, "LoadUnload");
        DataRow dr;
        DataColumn dc1 = new DataColumn("Loading_total_wt", typeof(Decimal));
        DataColumn dc2 = new DataColumn("UnLoading_total_wt", typeof(Decimal));
        DataColumn dc3 = new DataColumn("Grand_total", typeof(Decimal));
        DataColumn dc4 = new DataColumn("Rate", typeof(Decimal));
        DataColumn dc5 = new DataColumn("NetDue", typeof(Decimal));
        ds.Tables["LoadUnload"].Columns.Add(dc1);
        ds.Tables["LoadUnload"].Columns.Add(dc2);
        ds.Tables["LoadUnload"].Columns.Add(dc3);
        ds.Tables["LoadUnload"].Columns.Add(dc4);
        ds.Tables["LoadUnload"].Columns.Add(dc5);
        for (int i = 0; i < ds.Tables["LoadUnload"].Rows.Count; i++)
        {
            decimal a, b;
            dr = ds.Tables["LoadUnload"].Rows[i];
            //dr["Loading_total_wt"] = (Convert.ToDecimal(ds.Tables["LoadUnload"].Rows[i].ItemArray.GetValue(5) == System.DBNull.Value ? 0.00 : ds.Tables["LoadUnload"].Rows[i].ItemArray.GetValue(5)) + Convert.ToDecimal(ds.Tables["LoadUnload"].Rows[i].ItemArray.GetValue(7) == System.DBNull.Value ? 0.00 : ds.Tables["LoadUnload"].Rows[i].ItemArray.GetValue(7))) / 1000;
            //a = (Convert.ToDecimal(ds.Tables["LoadUnload"].Rows[i].ItemArray.GetValue(5) == System.DBNull.Value ? 0.00 : ds.Tables["LoadUnload"].Rows[i].ItemArray.GetValue(5)) + Convert.ToDecimal(ds.Tables["LoadUnload"].Rows[i].ItemArray.GetValue(7) == System.DBNull.Value ? 0.00 : ds.Tables["LoadUnload"].Rows[i].ItemArray.GetValue(7))) / 1000;
            //dr["UnLoading_total_wt"] = (Convert.ToDecimal(ds.Tables["LoadUnload"].Rows[i].ItemArray.GetValue(9) == System.DBNull.Value ? 0.00 : ds.Tables["LoadUnload"].Rows[i].ItemArray.GetValue(9)) + Convert.ToDecimal(ds.Tables["LoadUnload"].Rows[i].ItemArray.GetValue(11) == System.DBNull.Value ? 0.00 : ds.Tables["LoadUnload"].Rows[i].ItemArray.GetValue(11))) / 1000;
            //b = (Convert.ToDecimal(ds.Tables["LoadUnload"].Rows[i].ItemArray.GetValue(9) == System.DBNull.Value ? 0.00 : ds.Tables["LoadUnload"].Rows[i].ItemArray.GetValue(9)) + Convert.ToDecimal(ds.Tables["LoadUnload"].Rows[i].ItemArray.GetValue(11) == System.DBNull.Value ? 0.00 : ds.Tables["LoadUnload"].Rows[i].ItemArray.GetValue(11))) / 1000;
            //dr["Grand_total"] = a + b;
            dr["Loading_total_wt"] = (Convert.ToDecimal(ds.Tables["LoadUnload"].Rows[i]["cn_wt"] == System.DBNull.Value ? 0.00 : ds.Tables["LoadUnload"].Rows[i]["cn_wt"]) + Convert.ToDecimal(ds.Tables["LoadUnload"].Rows[i]["mf_in_wt"] == System.DBNull.Value ? 0.00 : ds.Tables["LoadUnload"].Rows[i]["mf_in_wt"])) / 1000;
            a = (Convert.ToDecimal(ds.Tables["LoadUnload"].Rows[i]["cn_wt"] == System.DBNull.Value ? 0.00 : ds.Tables["LoadUnload"].Rows[i]["cn_wt"]) + Convert.ToDecimal(ds.Tables["LoadUnload"].Rows[i]["mf_in_wt"] == System.DBNull.Value ? 0.00 : ds.Tables["LoadUnload"].Rows[i]["mf_in_wt"])) / 1000;
            dr["UnLoading_total_wt"] = (Convert.ToDecimal(ds.Tables["LoadUnload"].Rows[i]["mf_out_wt"] == System.DBNull.Value ? 0.00 : ds.Tables["LoadUnload"].Rows[i]["mf_out_wt"]) + Convert.ToDecimal(ds.Tables["LoadUnload"].Rows[i]["drs_wt"] == System.DBNull.Value ? 0.00 : ds.Tables["LoadUnload"].Rows[i]["drs_wt"])) / 1000;
            b = (Convert.ToDecimal(ds.Tables["LoadUnload"].Rows[i]["mf_out_wt"] == System.DBNull.Value ? 0.00 : ds.Tables["LoadUnload"].Rows[i]["mf_out_wt"]) + Convert.ToDecimal(ds.Tables["LoadUnload"].Rows[i]["drs_wt"] == System.DBNull.Value ? 0.00 : ds.Tables["LoadUnload"].Rows[i]["drs_wt"])) / 1000;
            dr["Grand_total"] = a + b;
        }
        GridViewHelper helper = new GridViewHelper(this.GrdLoadUnload);
        string[] cols = new string[1];
        cols[0] = "report_loc";
        //cols[1] = "ShipName";
        helper.RegisterGroup(cols, true, true);
        helper.GroupHeader += new GroupEvent(helper_GroupHeader);
        helper.RegisterSummary("Grand_total", SummaryOperation.Sum, "report_loc");
        helper.RegisterSummary("UnLoading_total_wt", SummaryOperation.Sum, "report_loc");
        helper.RegisterSummary("Loading_total_wt", SummaryOperation.Sum, "report_loc");
        helper.GroupSummary += new GroupEvent(helper_GroupSummary);
        //helper.ApplyGroupSort();
        GrdLoadUnload.DataSource = ds.Tables["LoadUnload"];
        GrdLoadUnload.DataBind();

    }
    private void helper_GroupHeader(string groupName, object[] values, GridViewRow row)
    {
        if (groupName == "report_loc")
        {
            row.CssClass = "blackfnt";
            row.Cells[0].Font.Bold = true;
            row.Cells[0].HorizontalAlign = HorizontalAlign.Left;  
            row.BackColor = System.Drawing.Color.FromName("#D4E0E7");
            row.Cells[0].Text = "&nbsp;&nbsp;" + row.Cells[0].Text;
        }
    }
    private void helper_GroupSummary(string groupName, object[] values, GridViewRow row)
    {
        row.Cells[0].Font.Bold = true;
        row.Cells[0].HorizontalAlign = HorizontalAlign.Left;
        row.Cells[0].Text = "Total";
        row.Cells[0].CssClass = "blackfnt";  
    }
    protected void abc(object sender, EventArgs e)
    {

        GrdLoadUnload.SelectedIndex = ((GridViewRow)((LinkButton)sender).Parent.Parent).DataItemIndex;
       // string categoryName = ((DropDownList)GridView1.SelectedRow.FindControl("cmb1")).SelectedItem.Value;
       //Response.Write(categoryName);
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string sql;
        sql = "";
        if (e.CommandName == "CNNo")
        {
            // int Id = int.Parse(e.CommandArgument.ToString());
            // string str = e.CommandArgument.ToString();  // to fetch commmand argument
            //GridView1.SelectedIndex = ((GridViewRow)((DropDownList)sender).Parent.Parent).DataItemIndex;
            //GrdLoadUnload.SelectedIndex = ((GridViewRow)((LinkButton)sender).Parent.Parent).DataItemIndex;
            string cbolocation = e.CommandArgument.ToString();  //((Label)GrdLoadUnload.SelectedRow.FindControl("lblloccode")).Text;
            string location = e.CommandArgument.ToString();     //((Label)GrdLoadUnload.SelectedRow.FindControl("lbllocation")).Text;
            sql = "select *,csgecd@' : '@csgenm as consignor,csgncd@' : '@csgnnm as consignee,(select locname from webx_location where loccode=reassign_destcd) as DelyLoction, dockno @ docksf as docket  from vw_docket_net where orgncd='" + cbolocation + "' and dockdt between '" + TxtFDt.Text + "' and '" + TxtTDt.Text + "'";
            Response.Redirect("FrmDocketDetail.aspx?mode=" + e.CommandName.ToString() + "&str=" + sql + "&daterange=" + TxtDateRange.Text + "&Location=" + location + "");  
        }
        else if (e.CommandName == "MFIn")
        {
            //GrdLoadUnload.SelectedIndex = ((GridViewRow)((LinkButton)sender).Parent.Parent).DataItemIndex;
            string cbolocation = ((Label)GrdLoadUnload.SelectedRow.FindControl("lblloccode")).Text;
            string location = ((Label)GrdLoadUnload.SelectedRow.FindControl("lbllocation")).Text;
            sql = "select * from vw_MF_details t where ToBH_CODE in (select sourcehb from webx_thchdr where thcno=t.thcno and sourcehb='" + cbolocation + "')  and  convert(varchar,thcdt,106) between convert(datetime,'" + TxtFDt.Text + "',106) and convert(datetime,'" + TxtTDt.Text + "',106)";
            //sql = "select * from vw_MF_details t  where ToBH_CODE in (select sourcehb from webx_thchdr where thcno=t.thcno and sourcehb='BLR' ) and CONVERT(VARCHAR,thcdt,106) between CONVERT(DATETIME,'25 Jun 07',106) and CONVERT(DATETIME,'25 Jun 07',106) "
            Response.Redirect("FrmDocketDetail.aspx?mode=" + e.CommandName.ToString() + "&str=" + sql + "&daterange=" + TxtDateRange.Text + "&Location=" + location + "");
        }
        else if (e.CommandName == "MFOut")
        {

            //GrdLoadUnload.SelectedIndex = ((GridViewRow)((LinkButton)sender).Parent.Parent).DataItemIndex;
            string cbolocation = ((Label)GrdLoadUnload.SelectedRow.FindControl("lblloccode")).Text;
            sql = "select * from vw_MF_details where tcbr='" + cbolocation + "' and CONVERT(VARCHAR,tcdt,106) between CONVERT(DATETIME,'" + TxtFDt.Text + "',106) and CONVERT(DATETIME,'" + TxtTDt.Text + "',106)";
            //SQL = "select * from vw_MF_details where tcbr='WLJ' and CONVERT(VARCHAR,tcdt,106) between CONVERT(DATETIME,'25 Jun 07',106) and CONVERT(DATETIME,'25 Jun 07',106)"
            string location = ((Label)GrdLoadUnload.SelectedRow.FindControl("lbllocation")).Text;
            Response.Redirect("FrmDocketDetail.aspx?mode=" + e.CommandName.ToString() + "&str=" + sql + "&daterange=" + TxtDateRange.Text + "&Location=" + location + "");
        }
        else if (e.CommandName == "DRS")
        {

            //GrdLoadUnload.SelectedIndex = ((GridViewRow)((LinkButton)sender).Parent.Parent).DataItemIndex;
            string cbolocation = ((Label)GrdLoadUnload.SelectedRow.FindControl("lblloccode")).Text;
            sql = "select * from vw_DRS_Details where pdcbr='" + cbolocation + "'  and pdcty='D'  and  convert(varchar,pdcdt,106) between convert(datetime,'" + TxtFDt.Text + "',106) and convert(datetime,'" + TxtTDt.Text + "',106)";
            string location = ((Label)GrdLoadUnload.SelectedRow.FindControl("lbllocation")).Text;
            Response.Redirect("FrmDocketDetail.aspx?mode=" + e.CommandName.ToString() + "&str=" + sql + "&daterange=" + TxtDateRange.Text + "&Location=" + location + "");
        }
    }
    protected void PageIndexChanged_Click(object sender, GridViewPageEventArgs e)
    {
        GrdLoadUnload.PageIndex = e.NewPageIndex;
        BindTheData();
        GrdLoadUnload.DataBind(); 
    }
    public void SortCommand_Click(object sender, DataGridSortCommandEventArgs e)
    {
        //str = " ORDER BY " + e.SortExpression;
        DataView dv = new DataView();
        dv = ds.Tables["LoadUnload"].DefaultView;
        dv.Sort = e.SortExpression;
        GrdLoadUnload.DataSource = ds.Tables["LoadUnload"];
        GrdLoadUnload.DataBind();  
        //BindTheData();
    }
    
    public void eventhandler(object Sender, DataGridItemEventArgs E)
    {
     
        if (E.Item.ItemType != ListItemType.Header && E.Item.ItemType != ListItemType.Footer)
        {
            E.Item.Cells[0].Text = Convert.ToString(E.Item.DataSetIndex + 1);
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
        cmd.CommandText = "webx_unloading_locading";
        cmd.Parameters.AddWithValue("@FROMDT", TxtFDt.Text);
        cmd.Parameters.AddWithValue("@TODT", TxtTDt.Text);
        cmd.Parameters.AddWithValue("@RO", TxtRO.Text);
        cmd.Parameters.AddWithValue("@ORGNCD", txtLocation.Text);
    
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        if (cn.State == ConnectionState.Closed)
        {
            cn.Open();
        }
        sqlDA.Fill(ds, "LoadUnload");
        Session["LoadUnload"] = ds;
        Response.Redirect("FrmToPayFollowUpRPT.aspx");  
    }
    protected void GrdLoadUnload_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            GridView oGridView = (GridView)sender;
            GridViewRow oGridViewRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);
            oGridViewRow.CssClass = "bgbluegrey";
            TableCell oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "Unloading";  
            oTableCell.ColumnSpan = 7;
            oTableCell.CssClass = "blackfnt"; 
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "Loading";
            oTableCell.ColumnSpan = 5;
            oTableCell.CssClass = "blackfnt"; 
            oGridViewRow.Cells.Add(oTableCell);
            
            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "Grand Total";
            oTableCell.ColumnSpan = 1;
            oTableCell.CssClass = "blackfnt"; 
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "Rate";
            oTableCell.ColumnSpan = 1;
            oTableCell.CssClass = "blackfnt"; 
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "Net Due";
            oTableCell.ColumnSpan = 1;
            oTableCell.CssClass = "blackfnt"; 
            oGridViewRow.Cells.Add(oTableCell);
            oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);


            oGridViewRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);
            oGridViewRow.CssClass = "bgbluegrey";
            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "";
            oTableCell.ColumnSpan = 1;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "";
            oTableCell.ColumnSpan = 1;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "CN(Booked)";
            oTableCell.ColumnSpan = 2;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "MF(In)";
            oTableCell.ColumnSpan = 2;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "Total Wt.";
            oTableCell.ColumnSpan = 1;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "MF(Out)";
            oTableCell.ColumnSpan = 2;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "DRS";
            oTableCell.ColumnSpan = 2;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "Total Wt.";
            oTableCell.ColumnSpan = 1;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "Total Wt.";
            oTableCell.ColumnSpan = 1;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "RS/Ton";
            oTableCell.ColumnSpan = 1;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);

            oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "";
            oTableCell.ColumnSpan = 1;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);
            oGridView.Controls[0].Controls.AddAt(1, oGridViewRow);


        }
    }
    protected void GrdLoadUnload_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            LinkButton LnkCNNo, LnkInMF, LnkOutMF, LnkDRSNo;
            LnkCNNo = (LinkButton)e.Row.FindControl("LnkCNNo");
            LnkInMF = (LinkButton)e.Row.FindControl("LnkInMF");
            LnkOutMF = (LinkButton)e.Row.FindControl("LnkOutMF");
            LnkDRSNo = (LinkButton)e.Row.FindControl("LnkDRSNo");

            if (LnkCNNo.Text == "0")
            {
                LnkCNNo.Text = "";
                e.Row.Cells[4].Text = "0";
                e.Row.Cells[4].CssClass = "blackfnt";  
                //function.Font.Underline = true;
            }

            if (LnkInMF.Text == "0")
            {
                LnkInMF.Text = "";
                e.Row.Cells[6].Text = "0";
                e.Row.Cells[6].CssClass = "blackfnt";
                //function.Font.Underline = true;
            }

            if (LnkOutMF.Text == "0")
            {
                LnkOutMF.Text = "";
                e.Row.Cells[9].Text = "0";
                e.Row.Cells[9].CssClass = "blackfnt";
                //function.Font.Underline = true;
            }

            if (LnkDRSNo.Text == "0")
            {
                LnkDRSNo.Text = "";
                e.Row.Cells[11].Text = "0";
                e.Row.Cells[11].CssClass = "blackfnt";
                //function.Font.Underline = true;
            }
            

        }

    }
    protected void cmdexcel_Click(object sender, EventArgs e)
    {
        System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("LoadUnload.csv"), false);

        //Response.AddHeader("content-disposition", "attachment;filename=FileName.xls");

        SqlCommand cmd = new SqlCommand();
        cmd.Connection = cn;
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = "webx_unloading_locading";
        cmd.Parameters.AddWithValue("@FROMDT", TxtFDt.Text);
        cmd.Parameters.AddWithValue("@TODT", TxtTDt.Text);
        cmd.Parameters.AddWithValue("@RO", TxtRO.Text);
        cmd.Parameters.AddWithValue("@ORGNCD", txtLocation.Text);

        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        if (cn.State == ConnectionState.Closed)
        {
            cn.Open();
        }
        sqlDA.Fill(ds, "LoadUnload");
        DataTable dt2 = ds.Tables["LoadUnload"];

        int iColCount = dt2.Columns.Count;
        for (int i = 0; i < iColCount; i++)
        {
            sw.Write(dt2.Columns[i]);
            if (i < iColCount - 1)
            {
                sw.Write(",");
            }
        }
        sw.Write(sw.NewLine);
        // Now write all the rows.
        foreach (DataRow dr in dt2.Rows)
        {
            for (int i = 0; i < iColCount; i++)
            {
                if (!Convert.IsDBNull(dr[i]))
                {
                    sw.Write(dr[i].ToString());
                }
                if (i < iColCount - 1)
                {
                    sw.Write(",");
                }
            }
            sw.Write(sw.NewLine);
        }
        sw.Close();
        System.IO.FileStream fs = null;
        fs = System.IO.File.Open(Server.MapPath("LoadUnload.csv"), System.IO.FileMode.Open);
        byte[] btFile = new byte[fs.Length];
        fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        fs.Close();
        Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("Content-disposition", "attachment; filename=" + "LoadUnload.csv");
        //Response.ContentType = "application/octet-stream";
        Response.BinaryWrite(btFile);
        Response.End();

    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
       
     ////////////////////////Response.Clear();
     ////////////////////////Response.AddHeader("content-disposition", "attachment;filename=FileName.xls");
     ////////////////////////Response.Charset = "";
     ////////////////////////Response.ContentType = "application/vnd.xls";
     ////////////////////////StringWriter StringWriter = new System.IO.StringWriter();
     ////////////////////////HtmlTextWriter HtmlTextWriter = new HtmlTextWriter(StringWriter);
     ////////////////////////GrdLoadUnload.RenderControl(HtmlTextWriter);
     ////////////////////////Response.Write(StringWriter.ToString());
     ////////////////////////Response.End();
      
     //StringWriter stringWrite;
     //HtmlTextWriter htmlWrite;
     //HtmlForm frm = new HtmlForm();
     //Response.Clear();
     //Response.AddHeader("content-disposition", "attachment;filename=FileName.xls");
     //Response.Charset = "";
     //Response.ContentType = "application/vnd.ms-xls";
     //stringWrite = new System.IO.StringWriter();
     //htmlWrite = new HtmlTextWriter(stringWrite);
     //Controls.Add(frm);
     //frm.Controls.Add(GrdLoadUnload);
     //frm.RenderControl(htmlWrite);
     //Response.Write(stringWrite.ToString());
     //Response.End();


     //GrdLoadUnload.AllowPaging = false;
     //BindTheData();
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
     frm.Controls.Add(GrdLoadUnload);
     frm.RenderControl(htmlWrite);
     Response.Write(stringWrite.ToString());
     Response.End();
       
    }
}
