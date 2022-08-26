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
using System.IO;
public partial class FrmDocketDetail : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    String str = "";
    //SqlConnection cn = new SqlConnection("Data Source=202.87.45.72;Initial Catalog=ASL_Live;User ID=sa;Password=ecfy@pra$$ana");
    SqlConnection cn; //= new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_VER2_LIVE");
    //SqlConnection cn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_Ver2_LIVE"); 
    //SqlConnection cn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=$rcpl@@p@$$;Database=RCPL_VER2_LIVE");
    string strqry;
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //cn = new SqlConnection("data source=202.87.45.69;UID=sa;PWD=!@ecfy#$;Database=Webxpress_new;");
        strqry = Convert.ToString(Request.QueryString["str"]);
        strqry = strqry.Replace("@", "+");
        lblrpttype.Text = "";
        lblrpttype.Text = Convert.ToString(Request.QueryString["RptType"]);
        lblDateRange.Text = Convert.ToString(Request.QueryString["DateRange"]);
        lblLocation.Text = Convert.ToString(Request.QueryString["Location"]);
        //(" + Convert.ToString(Request.QueryString["RptName"].ToUpper()) + ")"; 
        if (!IsPostBack)
        {  
           // strqry = Convert.ToString(Request.QueryString["str"]);
            BindTheData();
            ((Table)(GrdToPayFollow.Controls[0])).Rows[1].Cells[1].Text = Convert.ToString((Session["DocketCalledAs"]));
        }
    }
    public void BindTheData()
    {
        SqlCommand cmd = new SqlCommand();
        //SqlCommand cmd1 = new SqlCommand();
        cmd.Connection = cn;
        //cmd1.Connection = cn;
        //cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = strqry;
        //cmd1.CommandText = "select count(*) as records from VW_UNI_PAID_Folleup";
        //cmd.Parameters.AddWithValue("@FROMDT", TxtFDt.Text);
        //cmd.Parameters.AddWithValue("@TODT", TxtTDt.Text);
        //cmd.Parameters.AddWithValue("@RO", TxtRO.Text);
        //cmd.Parameters.AddWithValue("@ORGNCD", txtLocation.Text);
        //cmd.Parameters.AddWithValue("@LOCTYP", TxtCCode.Text);
        ds.Clear(); 
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        if (cn.State == ConnectionState.Closed)
        {
            cn.Open();
        }
        sqlDA.Fill(ds, "DocketDtl");
        GrdToPayFollow.DataSource = null;

       // GrdPaidFollow.VirtualItemCount = 200;//Convert.ToInt32(cmd1.ExecuteScalar()); 
        GrdToPayFollow.DataSource = ds.Tables["DocketDtl"];// cmd.ExecuteReader(CommandBehavior.CloseConnection);// 
        GrdToPayFollow.DataBind();
        if (ds.Tables["DocketDtl"].Rows.Count <= 0)
        {
            cmdexcel.Visible = false;
        }
         
    }
    public void PageIndexChanged_Click(object sender, DataGridPageChangedEventArgs e)
    {
        GrdToPayFollow.CurrentPageIndex = e.NewPageIndex;
        BindTheData();
    }
    public void SortCommand_Click(object sender, DataGridSortCommandEventArgs e)
    {
        str = " ORDER BY " + e.SortExpression;
        BindTheData();
    }
    public void gotolink(object Sender, DataGridCommandEventArgs e)
    {
        if (e.CommandName == "ViewMR")
        {
            //LinkButton l1;
            //string a;
            //l1 = (LinkButton)e.Item.FindControl("lblPaidDocket");
            //a = l1.Text;
            //Response.Redirect("FrmDocketDetail.aspx");
        }
    }

    protected void cmdprint_Click(object sender, EventArgs e)
    {
        
        SqlDataAdapter sqlDA = new SqlDataAdapter(strqry,cn);
        if (cn.State == ConnectionState.Closed)
        {
            cn.Open();
        }
        sqlDA.Fill(ds, "DocketDtl");
        Session["abc"] = ds;
        //Response.Redirect("FrmToPayRptDocketDTL.aspx?RPT=" + LblRptName.Text + "");
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void cmdexcel_Click(object sender, EventArgs e)
    {
        //System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("DocketDtl.csv"), false);
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
        //System.IO.FileStream fs = null;
        //fs = System.IO.File.Open(Server.MapPath("DocketDtl.csv"), System.IO.FileMode.Open);
        //byte[] btFile = new byte[fs.Length];
        //fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        //fs.Close();
        //Response.ContentType = "application/vnd.ms-excel";
        //Response.AddHeader("Content-disposition", "attachment; filename=" + "DocketDtl.csv");
        ////Response.ContentType = "application/octet-stream";
        //Response.BinaryWrite(btFile);
        //Response.End();
        //-----------------------------------------------------------------------------------------------


        //StringWriter stringWrite;
        //HtmlTextWriter htmlWrite;
        //HtmlForm frm = new HtmlForm();
        //Response.Clear();
        //Response.AddHeader("content-disposition", "attachment;filename=DocketDtl.csv");
        //Response.Charset = "";
        //Response.ContentType = "application/vnd.ms-xls";
        //stringWrite = new System.IO.StringWriter();
        //htmlWrite = new HtmlTextWriter(stringWrite);
        //Controls.Add(frm);
        //frm.Controls.Add(GrdLoadUnload);
        //frm.RenderControl(htmlWrite);
        //Response.Write(stringWrite.ToString());
        //Response.End();
        //HtmlForm frm = new HtmlForm();

        int ind = 0;
        int a = 0;
        try
        {
            //ind = GrdToPayFollow.CurrentPageIndex;
            //Response.Clear();
            //Response.AddHeader("Content-Disposition", "attachment;Filename=DocketDtl.xls");
            //Response.Charset = "";
            //Response.ContentType = "application/vnd.xls";
            //System.IO.StringWriter tw = new System.IO.StringWriter();
            //System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);
            //GrdToPayFollow.CurrentPageIndex = a;
            //while (a < GrdToPayFollow.PageCount)
            //{
            //    GrdToPayFollow.CurrentPageIndex = a;
            //    BindTheData();
            //    GrdToPayFollow.RenderControl(hw);
            //    a++;
            //}
            //Response.Write(tw.ToString());
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
            GrdToPayFollow.RenderControl(htmlWrite);
            //frm.Controls.Add(GrdToPayFollow);
            //frm.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

   
}
