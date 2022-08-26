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
    //SqlConnection cn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_VER2_LIVE"); 
    SqlConnection cn;// = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_Ver2_LIVE"); 
    //SqlConnection cn = new SqlConnection("data source=202.87.45.69;UID=sa;PWD=!@ECfy#$;Database=ASL_LIVE");
    //SqlConnection cn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=$rcpl@@p@$$;Database=RCPL_VER2_LIVE");
    private GridViewHelper helper;
    String fdate, tdate,frmdate,todate,status, location;
    DataTable dt;
    MyFunctions fn = new MyFunctions();
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
            //lblDate.Text = (FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2] + " -- " + TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2]);
            lblDate.Text = fn.Mydatedisplay(frmdate) + " -- " + fn.Mydatedisplay(todate);
            fdate = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];
            tdate = TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2];
            //lblDate.Text = fdate + " - " + tdate;
            txtfdate.Text = fn.Mydatedisplay(frmdate);
            txttdate.Text = fn.Mydatedisplay(todate);
            if (!IsPostBack)
            {
                BindTheData(); 
            }
        
    }
    public void BindTheData()
    {
        string sql;
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = cn;
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = "usp_disc_newDRS_analy";
        cmd.Parameters.AddWithValue("@FROMDT", fdate);
        cmd.Parameters.AddWithValue("@TODT", tdate);
        cmd.Parameters.AddWithValue("@RO", lblStatus.Text);
        cmd.Parameters.AddWithValue("@ORGNCD", lbllocation.Text);
        cmd.Connection.Open();
        SqlDataReader dr;
        dr = cmd.ExecuteReader();
        dt = new DataTable();
        dt.Load(dr);
        DataRow drow;
        DataColumn dc = new DataColumn("subtract",typeof (Int32)); 
        dt.Columns.Add(dc);   
        for (Int32 i =0 ;i<= dt.Rows.Count -1;i++)
        {
            drow = dt.Rows[i];
            drow["subtract"] = Convert.ToInt32(dt.Rows[i]["tot3"] == System.DBNull.Value ? 0 : dt.Rows[i]["tot3"]) - Convert.ToInt32(dt.Rows[i]["tot4"] == System.DBNull.Value ? 0 : dt.Rows[i]["tot4"]);
        }
        GridViewHelper helper = new GridViewHelper(this.GrdPaidFollow);
        string[] cols = new string[1];
        cols[0] = "report_loc";
        helper.RegisterGroup(cols, true, true);
        helper.GroupHeader += new GroupEvent(helper_GroupHeader);
        helper.RegisterSummary("tot1", SummaryOperation.Sum);
        helper.RegisterSummary("tot2", SummaryOperation.Sum);
        helper.RegisterSummary("tot3", SummaryOperation.Sum);
        helper.RegisterSummary("tot4", SummaryOperation.Sum);
        helper.RegisterSummary("subtract", SummaryOperation.Sum);
        helper.RegisterSummary("tot1", SummaryOperation.Sum, "report_loc");
        helper.RegisterSummary("tot2", SummaryOperation.Sum, "report_loc");
        helper.RegisterSummary("tot3", SummaryOperation.Sum, "report_loc");
        helper.RegisterSummary("tot4", SummaryOperation.Sum, "report_loc");
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
        row.Cells[0].Font.Bold = true;
        row.Cells[0].HorizontalAlign = HorizontalAlign.Left;
        row.Cells[0].VerticalAlign = VerticalAlign.Top;
        row.Cells[0].Text = " Total";
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
            Label loccode,locname,location;
            loccode = (Label)e.Row.FindControl("lblloccode");
            locname = (Label)e.Row.FindControl("lbllocname");
            location = (Label)e.Row.FindControl("lbllocation");
            location.Text = loccode.Text + " : " + locname.Text;
            //txtlocationname.Text = location.Text;
  
            Label function;
            function = (Label)e.Row.FindControl("lblfunction");
            if (function.Text == "Y")
            {
                function.Text = "Delivered";
                //function.Font.Underline = true;
            }
            else
            {
                function.Text = "";
            }

            LinkButton subtract,tot3,tot4,tot1,tot2;
            tot3 = (LinkButton)e.Row.FindControl("lblgcngonedelivery");
            tot4 = (LinkButton)e.Row.FindControl("lblgcndelivered");
            tot2 = (LinkButton)e.Row.FindControl("lblgcnawaitingdrs");
            tot1 = (LinkButton)e.Row.FindControl("lbltotalgcn");
            subtract = (LinkButton)e.Row.FindControl("lblgcndrsupdate");
            //subtract.Text = Convert.ToString(Convert.ToInt32(tot3.Text) - Convert.ToInt32(tot4.Text));

            if (tot1.Text == "0")
            {
                tot1.Visible = false;
                //tot1.Text = "";
                //tot1.PostBackUrl = "#";
                e.Row.Cells[5].Text = "0";
                e.Row.Cells[5].CssClass = "blackfnt";
                //tot1.Enabled = false;
                //tot1.PostBackUrl = "";
                //tot1.Font.Underline = false;
            }
            if (tot2.Text == "0")
            {
                tot2.Visible= false;
                //tot2.Text = "";
                e.Row.Cells[6].Text = "0";
                e.Row.Cells[6].CssClass = "blackfnt";
                tot2.PostBackUrl = "";
                //tot2.Font.Underline = false;
                //tot2.Font.Bold = true; 
            }
            if (tot3.Text == "0")
            {
                //tot3.Enabled = false;
                tot3.Visible = false;
                e.Row.Cells[7].Text = "0";
                e.Row.Cells[7].CssClass = "blackfnt";
                //tot3.PostBackUrl = "";
                //tot3.Font.Underline = false;
            }
            if (tot4.Text == "0")
            {
                tot4.Visible= false;  
                //tot4.PostBackUrl = "";
                //tot4.Text = "";
                e.Row.Cells[8].Text = "0";
                e.Row.Cells[8].CssClass = "blackfnt";
                //tot4.Font.Underline = false;
            }
            if (subtract.Text == "0")
            {
                subtract.Visible= false; 
                //subtract.PostBackUrl = "";
                //subtract.Text = "";
                e.Row.Cells[9].Text = "0";
                e.Row.Cells[9].CssClass = "blackfnt";
                //subtract.Font.Underline = false;
            }

        }
    }
}
