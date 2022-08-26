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
    String fdate, tdate,frmdate,todate,status,dockno,series,location;
    DataTable dt;
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        status = Request.QueryString["RO"];
        location = Request.QueryString["LocCode"];
        series = Request.QueryString["series"];
        dockno = Request.QueryString["dockno"];
        lbllocation.Text = location;
        lblStatus.Text = status;
        Lblsearchdockno.Text = dockno;  
            Array str, str1;
            //String fdate, tdate;
            frmdate = Request.QueryString["FrmDate"];
            todate = Request.QueryString["ToDate"];
            str = frmdate.Split('/');
            str1 = todate.Split('/');
            //((string[])(str))[0]
            string FmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str))[1]));//return month name
            string TmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str1))[1]));//return month name
            //CultureInfo a = CultureInfo.CurrentCulture;  
            lblDate.Text = (FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2] + " -- " + TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2]);
            fdate = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];
            tdate = TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2];
            lblDate.Text = fdate + " - " + tdate;
            txtfdate.Text = fdate;
            txttdate.Text = tdate;
            if (!IsPostBack)
            {
                BindTheData(); 
            }
        
    }
    private void helper_GroupHeader(string groupName, object[] values, GridViewRow row)
    {
        if (groupName == "report_loc")
        {
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
        row.Cells[0].Font.Bold = true;
        row.Cells[0].HorizontalAlign = HorizontalAlign.Left;
        row.Cells[0].Text = "Total";
    }
    public void BindTheData()
    {
        string sql;
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = cn;
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = "usp_DCR_And_Booked_Dockets_net";
        cmd.Parameters.AddWithValue("@allocated", series);
        cmd.Parameters.AddWithValue("@zone", lblStatus.Text == "All" ? "" : lblStatus.Text);
        cmd.Parameters.AddWithValue("@docbrcd", lbllocation.Text == "All" ? "" : lbllocation.Text);
        cmd.Parameters.AddWithValue("@dockno", dockno);
        cmd.Parameters.AddWithValue("@FROMDT", fdate);
        cmd.Parameters.AddWithValue("@TODT", tdate);
        cmd.Connection.Open();
        SqlDataReader dr;
        dr = cmd.ExecuteReader();
        dt = new DataTable();
        dt.Load(dr);
        ////DataColumn dc = new DataColumn("subtract",typeof (Int32));
        ////DataColumn dc1 = new DataColumn("frmdate", typeof(string));
        ////DataColumn dc2 = new DataColumn("todate", typeof(string));
        ////dt.Columns.Add(dc);
        ////dt.Columns.Add(dc1);
        ////dt.Columns.Add(dc2);  
        ////DataRow r1;
        ////for (int i = 0; i <= dt.Rows.Count-1; i++)
        ////{
        ////    r1 = dt.Rows[i];
        ////    dt.Rows[i]["subtract"] = ((Convert.ToInt32(dt.Rows[i]["tot1"] == System.DBNull.Value ? 0 : dt.Rows[i]["tot1"])) - (Convert.ToInt32(dt.Rows[i]["tot2"] == System.DBNull.Value ? 0 : dt.Rows[i]["tot2"])));
        ////    dt.Rows[i]["frmdate"] = fdate;
        ////    dt.Rows[i]["todate"] = tdate;  
        ////}
        

        ////GridViewHelper helper = new GridViewHelper(this.GrdPaidFollow);
        ////string[] cols = new string[1];
        ////cols[0] = "report_loc";
        ////helper.RegisterGroup(cols, true, true);
        ////helper.GroupHeader += new GroupEvent(helper_GroupHeader);
        ////helper.RegisterSummary("tot1", SummaryOperation.Sum);
        ////helper.RegisterSummary("tot2", SummaryOperation.Sum);
        ////helper.RegisterSummary("subtract", SummaryOperation.Sum);
        ////helper.RegisterSummary("tot1", SummaryOperation.Sum, "report_loc");
        ////helper.RegisterSummary("tot2", SummaryOperation.Sum, "report_loc");
        ////helper.RegisterSummary("subtract", SummaryOperation.Sum, "report_loc");
        ////helper.GroupSummary += new GroupEvent(helper_GroupSummary);
        GrdPaidFollow.DataSource = dt;
        GrdPaidFollow.DataBind();  
        dr.Close();
        cmd.Connection.Close();
        if (dt.Rows.Count <= 0)
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
        //Response.AddHeader("content-disposition", "attachment; filename=MyExcelFile.xls");
        //System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("MissingDockets.csv"), false);
        //SqlCommand cmd = new SqlCommand();
        //cmd.Connection = cn;
        //cmd.CommandType = CommandType.StoredProcedure;
        //cmd.CommandText = "usp_DCR_And_Booked_Dockets_net";
        //cmd.Parameters.AddWithValue("@allocated", series);
        //cmd.Parameters.AddWithValue("@zone", lblStatus.Text == "All" ? "" : lblStatus.Text);
        //cmd.Parameters.AddWithValue("@docbrcd", lbllocation.Text == "All" ? "" : lbllocation.Text);
        //cmd.Parameters.AddWithValue("@dockno", dockno);
        //cmd.Parameters.AddWithValue("@FROMDT", fdate);
        //cmd.Parameters.AddWithValue("@TODT", tdate);
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
        //fs = System.IO.File.Open(Server.MapPath("MissingDockets.csv"), System.IO.FileMode.Open);
        //byte[] btFile = new byte[fs.Length];
        //fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        //fs.Close();
        //Response.ContentType = "application/vnd.ms-excel";
        //Response.AddHeader("Content-disposition", "attachment; filename=" + "MissingDockets.csv");
        ////Response.ContentType = "application/octet-stream";
        //Response.BinaryWrite(btFile);
        //Response.End();
        //////////////////////////////////////////////////////////////////////////////////////////////
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
    protected void GrdPaidFollow_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //Build custom header.
                string docknofrom, docknoto;
                docknofrom = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "doc_sr_from"));
                docknoto = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "doc_sr_to"));
                Table table = (Table)this.GrdPaidFollow.Controls[0];
                GridView oGridView = (GridView)sender;
                int realindex = table.Rows.GetRowIndex(e.Row);
                GridViewRow oGridViewRow = new GridViewRow(realindex, realindex, DataControlRowType.DataRow, DataControlRowState.Insert);
                TableCell oTableCell = new TableCell();

                //Add Department
                oTableCell.Text = "Unused " + Session["DocketCalledAs"].ToString() + " For The Series : " + Convert.ToString(DataBinder.Eval(e.Row.DataItem, "doc_sr_from")) + " To " + Convert.ToString(DataBinder.Eval(e.Row.DataItem, "doc_sr_to")) + "";
                //DataBinder.Eval(e.Row.DataItem, "doc_sr_from")
                oTableCell.ColumnSpan = 6;
                oTableCell.CssClass = "blackfnt";
                oTableCell.Font.Bold = true;
                oTableCell.BackColor = System.Drawing.Color.White;
                oTableCell.HorizontalAlign = HorizontalAlign.Right;   
                oGridViewRow.Cells.Add(oTableCell);

                //exec sp_Missing_Dockets_In_Range '648751','648800'

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = cn;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "sp_Missing_Dockets_In_Range";
                cmd.Parameters.AddWithValue("@FromRange", docknofrom);
                cmd.Parameters.AddWithValue("@ToRange", docknoto);
                if (cn.State == ConnectionState.Closed) 
                {
                    cmd.Connection.Open();
                }
                SqlDataReader dr;
                dr = cmd.ExecuteReader();
                string MissDkt;
                MissDkt = "";
                while (dr.Read())
                {
                    MissDkt = MissDkt + ", " + Convert.ToString(dr[0]) ;
                }
                dr.Close();
                if (cn.State == ConnectionState.Open)
                {
                    cmd.Connection.Close();
                }
                string MDockets;
                MDockets = "";
                if (MissDkt.Length > 0)
                {
                    MDockets = "[" + MissDkt.Substring(1, MissDkt.Length - 1) + "]";
                }
                else 
                {
                    MDockets = "None";
                }
                //MissDkt += "[" + MissDkt + "]";
                oTableCell = new TableCell();
                //oTableCell.Text = "Employee";
                oTableCell.ColumnSpan = 2;
                oTableCell.Text = MDockets;
                //oTableCell.Width = 50;
                oTableCell.Wrap = true;  
                //TextBox txt = new TextBox();
                //txt.CssClass = "blackfnt";
                //txt.Text = "chirag";
                //oTableCell.Controls.Add(txt);
                oTableCell.CssClass = "blackfnt";
                oTableCell.BackColor = System.Drawing.Color.White;
                oTableCell.HorizontalAlign = HorizontalAlign.Left;   
                oGridViewRow.Cells.Add(oTableCell);
                table.Controls.AddAt(realindex + 1, oGridViewRow);
                oGridViewRow.Width = 100; 
            }
        }
        //catch (Exception ex)
        //{ }
    }
}
