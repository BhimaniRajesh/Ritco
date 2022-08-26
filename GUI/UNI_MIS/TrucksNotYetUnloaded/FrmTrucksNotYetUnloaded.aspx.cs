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
    String fdate, tdate,frmdate,todate,status, location;
    DataTable dt;
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        status = Request.QueryString["RO"];
        location = Request.QueryString["LocCode"];
        lbllocation.Text = location;
        lblStatus.Text = status;  
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
        cmd.CommandText = "usp_disc_Newunload_analy";
        cmd.Parameters.AddWithValue("@FROMDT", fdate);
        cmd.Parameters.AddWithValue("@TODT", tdate);
        cmd.Parameters.AddWithValue("@RO", lblStatus.Text);
        cmd.Parameters.AddWithValue("@ORGNCD", lbllocation.Text);
        cmd.Connection.Open();
        SqlDataReader dr;
        dr = cmd.ExecuteReader();
        dt = new DataTable();
        dt.Load(dr);
        DataColumn dc = new DataColumn("subtract",typeof (Int32));
        DataColumn dc1 = new DataColumn("frmdate", typeof(string));
        DataColumn dc2 = new DataColumn("todate", typeof(string));
        dt.Columns.Add(dc);
        dt.Columns.Add(dc1);
        dt.Columns.Add(dc2);  
        DataRow r1;
        for (int i = 0; i <= dt.Rows.Count-1; i++)
        {
            r1 = dt.Rows[i];
            dt.Rows[i]["subtract"] = ((Convert.ToInt32(dt.Rows[i]["tot1"] == System.DBNull.Value ? 0 : dt.Rows[i]["tot1"])) - (Convert.ToInt32(dt.Rows[i]["tot2"] == System.DBNull.Value ? 0 : dt.Rows[i]["tot2"])));
            dt.Rows[i]["frmdate"] = fdate;
            dt.Rows[i]["todate"] = tdate;  
        }
        

        GridViewHelper helper = new GridViewHelper(this.GrdPaidFollow);
        string[] cols = new string[1];
        cols[0] = "report_loc";
        helper.RegisterGroup(cols, true, true);
        helper.GroupHeader += new GroupEvent(helper_GroupHeader);
        helper.RegisterSummary("tot1", SummaryOperation.Sum);
        helper.RegisterSummary("tot2", SummaryOperation.Sum);
        helper.RegisterSummary("subtract", SummaryOperation.Sum);
        helper.RegisterSummary("tot1", SummaryOperation.Sum, "report_loc");
        helper.RegisterSummary("tot2", SummaryOperation.Sum, "report_loc");
        helper.RegisterSummary("subtract", SummaryOperation.Sum, "report_loc");
        helper.GroupSummary += new GroupEvent(helper_GroupSummary);
        GrdPaidFollow.DataSource = dt;
        GrdPaidFollow.DataBind();  
        dr.Close();
        cmd.Connection.Close();
        if (dt.Rows.Count <= 0)
        {
            Button1.Visible = false;
        }
        //for (int i = 0; i <= GrdPaidFollow.Rows.Count - 1; i++)
        //{
        //    if (GrdPaidFollow.Rows[i].Cells[5].Text != "0")
        //    {
        //        GrdPaidFollow.Rows[i].Cells[5].Font.Underline = true;  
        //    }
        //    if (GrdPaidFollow.Rows[i].Cells[6].Text != "0")
        //    {
        //        GrdPaidFollow.Rows[i].Cells[6].Font.Underline = true;
        //    }
        //    if (GrdPaidFollow.Rows[i].Cells[7].Text != "0")
        //    {
        //        GrdPaidFollow.Rows[i].Cells[7].Font.Underline = true;
        //    }
        //}

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
        //System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("TrucksNotUnloaded.csv"), false);
        //string sql;
        //SqlCommand cmd = new SqlCommand();
        //cmd.Connection = cn;
        //cmd.CommandType = CommandType.StoredProcedure;
        //cmd.CommandText = "usp_disc_Newunload_analy";
        //cmd.Parameters.AddWithValue("@FROMDT", fdate);
        //cmd.Parameters.AddWithValue("@TODT", tdate);
        //cmd.Parameters.AddWithValue("@RO", lblStatus.Text);
        //cmd.Parameters.AddWithValue("@ORGNCD", lbllocation.Text);
        //cmd.Connection.Open();
        //SqlDataReader dr;
        //dr = cmd.ExecuteReader();
        //dt = new DataTable();
        //dt.Load(dr);
        //DataColumn dc = new DataColumn("subtract", typeof(Int32));
        //DataColumn dc1 = new DataColumn("frmdate", typeof(string));
        //DataColumn dc2 = new DataColumn("todate", typeof(string));
        //dt.Columns.Add(dc);
        //dt.Columns.Add(dc1);
        //dt.Columns.Add(dc2);
        //DataRow r1;
        //for (int i = 0; i < dt.Rows.Count - 1; i++)
        //{
        //    r1 = dt.Rows[i];
        //    dt.Rows[i]["subtract"] = ((Convert.ToInt32(dt.Rows[i]["tot1"] == System.DBNull.Value ? 0 : dt.Rows[i]["tot1"])) - (Convert.ToInt32(dt.Rows[i]["tot2"] == System.DBNull.Value ? 0 : dt.Rows[i]["tot2"])));
        //    dt.Rows[i]["frmdate"] = fdate;
        //    dt.Rows[i]["todate"] = tdate;
        //}
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
        //fs = System.IO.File.Open(Server.MapPath("TrucksNotUnloaded.csv"), System.IO.FileMode.Open);
        //byte[] btFile = new byte[fs.Length];
        //fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        //fs.Close();
        //Response.ContentType = "application/vnd.ms-excel";
        //Response.AddHeader("Content-disposition", "attachment; filename=" + "TrucksNotUnloaded.csv");
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
    protected void GrdPaidFollow_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            Int32 s;
            s = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "tot1"));
            if (s == 0)
            {
                DataControlFieldCell dfield;
                dfield = (DataControlFieldCell)e.Row.Cells[5];
                HyperLinkField hlf;
                hlf = (HyperLinkField)dfield.ContainingField;
                //hlf.DataTextField = "";
                e.Row.Cells[5].Text = "0";
                hlf.ItemStyle.Font.Underline = false;
            }
            else 
            {
                DataControlFieldCell dfield;
                dfield = (DataControlFieldCell)e.Row.Cells[5];
                HyperLinkField hlf;
                hlf = (HyperLinkField)dfield.ContainingField;
                //hlf.ItemStyle.Font.Underline = true;
                e.Row.Cells[5].Font.Underline = true;
                //GrdPaidFollow.Rows[e.Row.RowIndex-1].Cells[5].Text = Convert.ToString(s);   
            }

            s = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "tot2"));
            if (s == 0)
            {
                DataControlFieldCell dfield;
                dfield = (DataControlFieldCell)e.Row.Cells[6];
                HyperLinkField hlf;
                hlf = (HyperLinkField)dfield.ContainingField;
                //hlf.DataTextField = "";
                e.Row.Cells[6].Text = "0";
                hlf.ItemStyle.Font.Underline = false;
            }
            else
            {
                DataControlFieldCell dfield;
                dfield = (DataControlFieldCell)e.Row.Cells[6];
                HyperLinkField hlf;
                hlf = (HyperLinkField)dfield.ContainingField;
                //hlf.ItemStyle.Font.Underline = true;
                e.Row.Cells[6].Font.Underline = true;
                //GrdPaidFollow.Rows[e.Row.RowIndex-1].Cells[6].Text = Convert.ToString(s);   
            }

            s = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "subtract"));
            if (s == 0)
            {
                DataControlFieldCell dfield;
                dfield = (DataControlFieldCell)e.Row.Cells[7];
                HyperLinkField hlf;
                hlf = (HyperLinkField)dfield.ContainingField;
                //hlf.DataTextField = "";
                e.Row.Cells[7].Text = "0";
                hlf.ItemStyle.Font.Underline = false;
            }
            else 
            {
                DataControlFieldCell dfield;
                dfield = (DataControlFieldCell)e.Row.Cells[7];
                HyperLinkField hlf;
                hlf = (HyperLinkField)dfield.ContainingField;
                //hlf.ItemStyle.Font.Underline = true;
                e.Row.Cells[7].Font.Underline = true;
                //GrdPaidFollow.Rows[e.Row.RowIndex-1].Cells[7].Text = Convert.ToString(s);   
            }


            Label loccode,locname,location;
            loccode = (Label)e.Row.FindControl("lblloccode");
            locname = (Label)e.Row.FindControl("lbllocname");
            location = (Label)e.Row.FindControl("lbllocation");
            location.Text = loccode.Text + " : " + locname.Text;
            //txtlocationname.Text = location.Text;
  
            Label function1,function2;
            function1 = (Label)e.Row.FindControl("lblfunction1");
            function2 = (Label)e.Row.FindControl("lblfunction2");
            if (function1.Text == "Y")
            {
                function1.Text = "Booking Hub";
                //function.Font.Underline = true;
            }
            else
            {
                function1.Text = "";
            }
            if (function2.Text == "Y")
            {
                function2.Text = "Transhipment";
                //function.Font.Underline = true;
            }
            else
            {
                function2.Text = "";
            }
           
        }
    }
}
