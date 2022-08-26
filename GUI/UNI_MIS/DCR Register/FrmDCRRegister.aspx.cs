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
    SqlConnection cn;// = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_VER2_LIVE");
    SqlConnection gcn;// = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_VER2_LIVE"); 
    //SqlConnection cn =s new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_Ver2_LIVE");
    //SqlConnection gcn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_Ver2_LIVE"); 
    //SqlConnection cn = new SqlConnection("data source=202.87.45.69;UID=sa;PWD=!@ECfy#$;Database=ASL_LIVE");
    //SqlConnection gcn = new SqlConnection("data source=202.87.45.69;UID=sa;PWD=!@ECfy#$;Database=ASL_LIVE");
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        gcn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
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
            //TxtDateRange.Text = (FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2] + " -- " + TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2]);
            TxtDateRange.Text = fn.Mydatedisplay(fdate) + " -- " + fn.Mydatedisplay(tdate);
            TxtFDt.Text = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];
            TxtTDt.Text = TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2];
            TxtRO.Text = Request.QueryString["RO"];
            txtLocation.Text = Request.QueryString["LocCode"];
            lbldaterange.Text = TxtDateRange.Text;
            lblLocation.Text = txtLocation.Text;
            lblRO.Text = TxtRO.Text;
            BindTheData();
        }
    }
    public void BindTheData()
    {
        
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = cn;
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = "webx_DCR_summary_report";
        cmd.Parameters.AddWithValue("@startdate", TxtFDt.Text);
        cmd.Parameters.AddWithValue("@enddate", TxtTDt.Text);
        cmd.Parameters.AddWithValue("@ORGNCD", txtLocation.Text);
        cmd.Parameters.AddWithValue("@RO", TxtRO.Text);
        //cmd.Parameters.AddWithValue("@LOCTYP", TxtCCode.Text);
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        if (cn.State==ConnectionState.Closed)
        {  
            cn.Open();
        }
        sqlDA.Fill(ds, "LoadUnload");
        DataRow dr;
        DataColumn dc0 = new DataColumn("DocketSeries", typeof(string));        
        DataColumn dc1 = new DataColumn("HO" ,typeof (string));        
        DataColumn dc2 = new DataColumn("HODate", typeof(string));
        DataColumn dc3 = new DataColumn("RO", typeof(string));
        DataColumn dc4 = new DataColumn("RODate", typeof(string));
        DataColumn dc5 = new DataColumn("AO", typeof(string));
        DataColumn dc6 = new DataColumn("AODate", typeof(string));
        DataColumn dc7 = new DataColumn("LO", typeof(string));
        DataColumn dc8 = new DataColumn("LODate", typeof(string));
        DataColumn dc9 = new DataColumn("BA", typeof(string));
        DataColumn dc10 = new DataColumn("BADate", typeof(string));
        DataColumn dc11 = new DataColumn("unusedleaf", typeof(Int32));
        DataColumn dc12 = new DataColumn("voidleaf", typeof(string));
        
        ds.Tables["LoadUnload"].Columns.Add(dc0);
        ds.Tables["LoadUnload"].Columns.Add(dc1);
        ds.Tables["LoadUnload"].Columns.Add(dc2);
        ds.Tables["LoadUnload"].Columns.Add(dc3);
        ds.Tables["LoadUnload"].Columns.Add(dc4);
        ds.Tables["LoadUnload"].Columns.Add(dc5);
        ds.Tables["LoadUnload"].Columns.Add(dc6);
        ds.Tables["LoadUnload"].Columns.Add(dc7);
        ds.Tables["LoadUnload"].Columns.Add(dc8);
        ds.Tables["LoadUnload"].Columns.Add(dc9);
        ds.Tables["LoadUnload"].Columns.Add(dc10);
        ds.Tables["LoadUnload"].Columns.Add(dc11);
        ds.Tables["LoadUnload"].Columns.Add(dc12);


        for (int i = 0; i < ds.Tables["LoadUnload"].Rows.Count; i++)
        {
            string a;
            dr = ds.Tables["LoadUnload"].Rows[i];
            dr["DocketSeries"] = dr["Doc_Sr_From"].ToString() + " - " + dr["Doc_Sr_To"].ToString();
            dr["unusedleaf"] = Convert.ToInt32(dr["tot_leaf"]) - Convert.ToInt32(dr["used_dkt"]); 

            SqlCommand cmdtemp;
            cmdtemp = new SqlCommand();
            SqlDataReader dreader;
            cmdtemp.Connection = gcn;
            cmdtemp.CommandType = CommandType.StoredProcedure;
            cmdtemp.CommandText = "webx_DCR_summary_report_Details";
            cmdtemp.Parameters.AddWithValue("@dcrno", ds.Tables["LoadUnload"].Rows[i]["Doc_Sr_From"]);
            cmdtemp.Parameters.AddWithValue("@levelno", "1");
            cmdtemp.Connection.Open();
            dreader = cmdtemp.ExecuteReader();
            while (dreader.Read())
            {
                dr["HO"] = Convert.ToString(dreader["DOCBRCD"] == System.DBNull.Value ? "" : dreader["DOCBRCD"]);
                a = Convert.ToString(dreader["UPDTON"] == System.DBNull.Value ? "" : dreader["UPDTON"]);
                if (a != "")
                {
                    //dr["HODate"] = Convert.ToString(Convert.ToDateTime(a));  
                    dr["HODate"] = Convert.ToDateTime(a).ToString("dd-MMM-yy");
                }
                else
                {
                    dr["HODate"] = "";
                }
            }
            dreader.Close();
            cmdtemp.Connection.Close();


            cmdtemp = new SqlCommand();
            cmdtemp.Connection = gcn;
            cmdtemp.CommandType = CommandType.StoredProcedure;
            cmdtemp.CommandText = "webx_DCR_summary_report_Details";
            cmdtemp.Parameters.AddWithValue("@dcrno", ds.Tables["LoadUnload"].Rows[i]["Doc_Sr_From"]);
            cmdtemp.Parameters.AddWithValue("@levelno", "2");
            cmdtemp.Connection.Open();
            dreader = cmdtemp.ExecuteReader();
            while (dreader.Read())
            {
                dr["RO"] = Convert.ToString(dreader["DOCBRCD"] == System.DBNull.Value ? "" : dreader["DOCBRCD"]);
                a = Convert.ToString(dreader["UPDTON"] == System.DBNull.Value ? "" : dreader["UPDTON"]);
                if (a != "")
                {
                    //dr["RODate"] = Convert.ToString(Convert.ToDateTime(a),"dd/MM/yyyy");
                    dr["RODate"] = Convert.ToDateTime(a).ToString("dd-MMM-yy");
                }
                else
                {
                    dr["RODate"] = "";
                }
            }
            dreader.Close();
            cmdtemp.Connection.Close();


            cmdtemp = new SqlCommand();
            cmdtemp.Connection = gcn;
            cmdtemp.CommandType = CommandType.StoredProcedure;
            cmdtemp.CommandText = "webx_DCR_summary_report_Details";
            cmdtemp.Parameters.AddWithValue("@dcrno", ds.Tables["LoadUnload"].Rows[i]["Doc_Sr_From"]);
            cmdtemp.Parameters.AddWithValue("@levelno", "4");
            cmdtemp.Connection.Open();
            dreader = cmdtemp.ExecuteReader();
            while (dreader.Read())
            {
                dr["AO"] = Convert.ToString(dreader["DOCBRCD"] == System.DBNull.Value ? "" : dreader["DOCBRCD"]);
                a = Convert.ToString(dreader["UPDTON"] == System.DBNull.Value ? "" : dreader["UPDTON"]);
                if (a != "")
                {
                    //dr["AODate"] = Convert.ToString(Convert.ToDateTime(a), "dd-MMM-yy");
                    dr["AODate"] = Convert.ToDateTime(a).ToString("dd-MMM-yy");
                }
                else
                {
                    dr["AODate"] = "";
                }
            }
            dreader.Close();
            cmdtemp.Connection.Close();


            cmdtemp = new SqlCommand();
            cmdtemp.Connection = gcn;
            cmdtemp.CommandType = CommandType.StoredProcedure;
            cmdtemp.CommandText = "webx_DCR_summary_report_Details";
            cmdtemp.Parameters.AddWithValue("@dcrno", ds.Tables["LoadUnload"].Rows[i]["Doc_Sr_From"]);
            cmdtemp.Parameters.AddWithValue("@levelno", "3");
            cmdtemp.Connection.Open();
            dreader = cmdtemp.ExecuteReader();
            while (dreader.Read())
            {
                dr["LO"] = Convert.ToString(dreader["DOCBRCD"] == System.DBNull.Value ? "" : dreader["DOCBRCD"]);
                a = Convert.ToString(dreader["UPDTON"] == System.DBNull.Value ? "" : dreader["UPDTON"]);
                if (a != "")
                {
                    //dr["LODate"] = Convert.ToString(Convert.ToDateTime(a), "dd-MMM-yy");
                    dr["LODate"] = Convert.ToDateTime(a).ToString("dd-MMM-yy");
                }
                else
                {
                    dr["LODate"] = "";
                }
            }
            dreader.Close();
            cmdtemp.Connection.Close();


            cmdtemp = new SqlCommand();
            cmdtemp.Connection = gcn;
            cmdtemp.CommandType = CommandType.StoredProcedure;
            cmdtemp.CommandText = "webx_DCR_summary_report_Details";
            cmdtemp.Parameters.AddWithValue("@dcrno", ds.Tables["LoadUnload"].Rows[i]["Doc_Sr_From"]);
            cmdtemp.Parameters.AddWithValue("@levelno", "999");
            cmdtemp.Connection.Open();
            dreader = cmdtemp.ExecuteReader();
            while (dreader.Read())
            {
                dr["BA"] = Convert.ToString(dreader["DOCBRCD"] == System.DBNull.Value ? "" : dreader["DOCBRCD"]);
                a = Convert.ToString(dreader["UPDTON"] == System.DBNull.Value ? "" : dreader["UPDTON"]);
                if (a != "")
                {
                    //dr["BADate"] = Convert.ToString(Convert.ToDateTime(a), "dd-MMM-yy");
                    dr["BADate"] = Convert.ToDateTime(a).ToString("dd-MMM-yy");
                }
                else
                {
                    dr["BADate"] = "";
                }
            }
            dreader.Close();
            cmdtemp.Connection.Close();  
        }
        GrdPaidFollow.DataSource = ds.Tables["LoadUnload"];
        GrdPaidFollow.DataBind();
        if (ds.Tables["LoadUnload"].Rows.Count <= 0)
        {
            cmdexcel.Visible = false;
        }
    }
    public void PageIndexChanged_Click(object sender, GridViewPageEventArgs e)
    {
        GrdPaidFollow.PageIndex = e.NewPageIndex;
        //GrdPaidFollow.DataBind();  
        BindTheData();
    }
    public void SortCommand_Click(object sender, DataGridSortCommandEventArgs e)
    {
        //str = " ORDER BY " + e.SortExpression;
        DataView dv = new DataView();
        dv = ds.Tables["LoadUnload"].DefaultView;
        dv.Sort = e.SortExpression;
        GrdPaidFollow.DataSource = ds.Tables["LoadUnload"];
        GrdPaidFollow.DataBind();  
       
    }
    
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
    }
   
    protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
    {

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
            LinkButton lblusedleaf, lblunusedleaf;
            lblusedleaf = (LinkButton)e.Row.FindControl("lblusedleaf");
            lblunusedleaf = (LinkButton)e.Row.FindControl("lblunusedleaf");

            if (lblusedleaf.Text == "0")
            {
                lblusedleaf.Visible = false;
                e.Row.Cells[14].Text = "0";
                e.Row.Cells[14].CssClass = "blackfnt";
                //function.Font.Underline = true;
            }

            if (lblunusedleaf.Text == "0")
            {
                lblunusedleaf.Visible = false;
                e.Row.Cells[15].Text = "0";
                e.Row.Cells[15].CssClass = "blackfnt";
                //function.Font.Underline = true;
            }

        }

    }
}
