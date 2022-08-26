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
//using CrystalDecisions.CrystalReports.Engine;
using System.IO;

public partial class FrmPaidFollowUp : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    String str = "",vwname="";
    //SqlConnection cn = new SqlConnection("Data Source=202.87.45.72;Initial Catalog=ASL_Live;User ID=sa;Password=ecfy@pra$$ana");
    SqlConnection cn;// = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_VER2_LIVE"); 
    //SqlConnection cn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_Ver2_LIVE"); 
    string vtype, voucherno, YEAR_SUFFIX;
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        vtype = Request.QueryString["vtype"];
        voucherno = Request.QueryString["voucherno"];
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
            txtLocation.Text = Request.QueryString["Location"];
            //TxtCCode.Text = Request.QueryString["CCode"];
            lblDateRange.Text = TxtDateRange.Text;
            lblLocation.Text = txtLocation.Text;
            lblRO.Text = TxtRO.Text;
            //vtype = Request.QueryString["vtype"];
            LblVoucherType.Text = Request.QueryString["vname"];
            lblvoucherno.Text = Request.QueryString["voucherno"];



            if (lblvoucherno.Text == "")
            {
                //tbl1.Visible = true;
                p1.Style["Display"] = "Block"; 
            }
            else 
            {
                p2.Style["Display"] = "Block";
                //tbl2.Visible = true;
            }
            BindTheData();

        }
      
    }


    // UNI_MIS/voucher%20register/FrmVoucherList.aspx?FrmDate=04/03/2008&ToDate=04/04/2007&RO=All&vtype=All&vname=All&voucherno=&location=All

    //   UNI_MIS/Voucher%20Register/FrmVoucherList.aspx?FrmDate=27/04/2008&ToDate=03/04/2008&RO=All&vtype=All&vname=All&voucherno=HQTR/VR/08000710&location=All



    // UNI_MIS/voucher%20register/frmcriteria.aspx



    public void BindTheData()
    {
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = cn;
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = "webx_VOUCHER_Register2";

        string Finyear = Session["FinYear"].ToString();
        Finyear = Finyear.Substring(2, 2);
        string CloseYear = Convert.ToString((Convert.ToInt16(Session["FinYear"].ToString()) + 1));
        if (CloseYear.Length == 1)
            CloseYear = "0" + CloseYear;
        CloseYear = CloseYear.Substring(2, 2);
        YEAR_SUFFIX = Finyear + "_" + CloseYear;
      

        vwname = "vw_VoucherReport_"+YEAR_SUFFIX;
        cmd.Parameters.AddWithValue("@FROMDT", TxtFDt.Text);
        cmd.Parameters.AddWithValue("@TODT", TxtTDt.Text);
        cmd.Parameters.AddWithValue("@RO", TxtRO.Text);
        cmd.Parameters.AddWithValue("@ORGNCD", txtLocation.Text);
        //cmd.Parameters.AddWithValue("@LOCTYP", "");
        cmd.Parameters.AddWithValue("@LOCTYP", vtype);
        cmd.Parameters.AddWithValue("@VaoucherNolist", voucherno);
        cmd.Parameters.AddWithValue("@TABLENAME", vwname);
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        if (cn.State==ConnectionState.Closed)
        {  
            cn.Open();
        }
        sqlDA.Fill(ds, "VchReg");
        GrdPaidFollow.DataSource = ds.Tables["VchReg"];
        GrdPaidFollow.DataBind();
        if (ds.Tables["VchReg"].Rows.Count <= 0)
        {
            cmdexcel.Visible = false;  
        }
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
        dv = ds.Tables["VchReg"].DefaultView;
        dv.Sort = e.SortExpression;
        GrdPaidFollow.DataSource = ds.Tables["VchReg"];
        GrdPaidFollow.DataBind();  
        //BindTheData();
    }
    //Boolean IsPageIndex;
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
   
    protected void Button1_Click(object sender, EventArgs e)
    {
    }
    protected void cmdexcel_Click(object sender, EventArgs e)
    {
        //System.IO.StreamWriter sw = new System.IO.StreamWriter(Server.MapPath("VoucherReg.csv"), false);

        ////Response.AddHeader("content-disposition", "attachment;filename=FileName.xls");

        //SqlCommand cmd = new SqlCommand();
        //cmd.Connection = cn;
        //cmd.CommandType = CommandType.StoredProcedure;
        ////cmd.CommandText = "webx_VOUCHER_Register_net";
        //cmd.CommandText = "webx_VOUCHER_Register2";

        //cmd.Parameters.AddWithValue("@FROMDT", TxtFDt.Text);
        //cmd.Parameters.AddWithValue("@TODT", TxtTDt.Text);
        //cmd.Parameters.AddWithValue("@RO", TxtRO.Text);
        //cmd.Parameters.AddWithValue("@ORGNCD", txtLocation.Text);
        //cmd.Parameters.AddWithValue("@LOCTYP", vtype);
        ////cmd.Parameters.AddWithValue("@LOCTYP", "");
        ////cmd.Parameters.AddWithValue("@voucherlist", vtype);
        //cmd.Parameters.AddWithValue("@TABLENAME", "vw_VoucherReport");
        //SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
        //if (cn.State == ConnectionState.Closed)
        //{
        //    cn.Open();
        //}
        //sqlDA.Fill(ds, "VchReg");
        //DataTable dt2 = ds.Tables["VchReg"];// (DataTable)Session["dt1"];

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
        //fs = System.IO.File.Open(Server.MapPath("VoucherReg.csv"), System.IO.FileMode.Open);
        //byte[] btFile = new byte[fs.Length];
        //fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        //fs.Close();
        //Response.ContentType = "application/vnd.ms-excel";
        //Response.AddHeader("Content-disposition", "attachment; filename=" + "VoucherReg.csv");
        ////Response.ContentType = "application/octet-stream";
        //Response.BinaryWrite(btFile);
        //Response.End();
        ////FileInfo abc = new FileInfo(Server.MapPath("Excel1.csv"));
        ////abc.Open(FileMode.Open, FileAccess.Read);     
        
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
