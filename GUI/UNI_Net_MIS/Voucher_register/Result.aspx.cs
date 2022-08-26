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

public partial class GUI_UNI_Net_MIS_Voucher_register_Result : System.Web.UI.Page
{
    SqlConnection Conn;
    //public static string dkt_Call, THC_Call;
    protected void Page_Load(object sender, EventArgs e)
    {
        //dkt_Call = Session["DocketCalledAs"].ToString();
        string RMD;
        RMD = Request.QueryString["RMD"].ToString();

        if (RMD == "N")
        {
            BindGrid();
        }
        else
        {
            BindGrid();
            DWN_XLS();

        }
    }
    public void BindGrid()
    {
        Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Conn.Open();

        string RO = Request.QueryString.Get("RO");
        string LO = Request.QueryString.Get("LO");
        string fromdt = Request.QueryString.Get("fromdt");
        string todt = Request.QueryString.Get("todt");
        string VRLIST = Request.QueryString.Get("VRLIST");
        string doclist = Request.QueryString.Get("doclist");
        string VRTY = Request.QueryString.Get("VRTY");
        string VRTY_str = Request.QueryString.Get("VRTY_str");
        string TRTY = Request.QueryString.Get("TRTY");
        string TRTY_str = Request.QueryString.Get("TRTY_str");
        string VRREFNO = Request.QueryString.Get("VRREFNO");
        string VRSTATUS = Request.QueryString.Get("VRSTATUS");

        lblvrty.Text = VRTY_str;
        lbltrty.Text = TRTY_str;
        LBLDATE.Text = fromdt + " - " + todt;
        LBLBRANCH.Text = RO;
        LBLRPT.Text = LO;
        lblrefno.Text = VRREFNO;
        if (VRSTATUS == "N")
            lblvrstatus.Text = "Generated";
        else
            lblvrstatus.Text = "Cancelled";
                    
        string YearString = Session["FinYear"].ToString().Substring(2, 2);
        string CloseYear = Convert.ToString((Convert.ToInt16(YearString) + 1));
        if (CloseYear.Length == 1)
        {
            CloseYear = "0" + CloseYear;
        }
        DateTime yrstartdt;
        string  yearSuffix = Convert.ToString(YearString) + "_" + Convert.ToString(CloseYear);

         SqlTransaction trans;
        string transtyp1 = "";
        trans = Conn.BeginTransaction();
        if (RO == LO)
            RO = "All";
        try
        {
            string SQL_grid = "exec WebxNet_voucher_register '" + fromdt + "','" + todt + "','" + RO + "','" + LO + "','" + TRTY + "','" + VRTY + "','" + VRLIST + "','" + doclist + "','" + VRREFNO + "','" + VRSTATUS + "','transdate','" + yearSuffix + "',''";
            //Response.Write("<br> SQL_grid : " + SQL_grid);
            SqlCommand sqlcmd12 = new SqlCommand(SQL_grid, Conn);
            sqlcmd12.Transaction = trans;
            SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);
            DataSet ds = new DataSet();

            da.Fill(ds);
            dgDocket.DataSource = ds;
            dgDocket.DataBind();
            dgDocket.Visible = true;
            trans.Commit();
        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + e1.Message + "</font>");
            if (e1.Message == "")
            {
                // abc = "Insert Susccessfully !!!!!!!";
            }
            trans.Rollback();
            Response.End();
        }
        finally
        {
            Conn.Close();
        }
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        dgDocket.PageIndex = e.NewPageIndex;
        BindGrid();
    }
    protected void btn_csv_Click(object sender, EventArgs e)
    {
        DWN_XLS();
    }
    public void DWN_XLS()
    {
        TBL_CRI.Border = 1;
        dgDocket.AllowPaging = false;
        dgDocket.BorderWidth = 1;
        dgDocket.CssClass = "blackfnt";
        dgDocket.Font.Size = 10;
        BindGrid();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=Voucher_Register_Report.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        frm.Controls.Add(TBL_CRI);
        frm.Controls.Add(dgDocket);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }
}
