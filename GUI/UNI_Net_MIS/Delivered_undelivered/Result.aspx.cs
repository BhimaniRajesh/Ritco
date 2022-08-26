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
public partial class GUI_UNI_Net_MIS_Delivered_undelivered_Result : System.Web.UI.Page
{
    public static string strcust, dkt_call;
    public static string RO = "", LO = "", DLLStatus="",RO_TO = "", LO_TO = "", DateType = "", fromdt = "", todt = "", st_Docnolist = "";
    public static string strPaybas = "", strCust="",str_Paybas = "", strMode = "", str_Mode = "", strType = "", str_Type = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        dkt_call = Session["DocketCalledAs"].ToString();
        string RMD = Request.QueryString.Get("RMD");

         RO = Request.QueryString.Get("RO");
         LO = Request.QueryString.Get("LO");
         RO_TO = Request.QueryString.Get("RO_TO");
         LO_TO = Request.QueryString.Get("LO_TO");
         DateType = Request.QueryString.Get("DateType");
         fromdt = Request.QueryString.Get("fromdt");
         todt = Request.QueryString.Get("todt");
         st_Docnolist = Request.QueryString.Get("st_Docnolist");
         strCust = Request.QueryString.Get("strCust");
         strPaybas = Request.QueryString.Get("strPaybas");
         str_Paybas = Request.QueryString.Get("str_Paybas");
         strMode = Request.QueryString.Get("strMode");
         str_Mode = Request.QueryString.Get("str_Mode");
         strType = Request.QueryString.Get("strType");
         str_Type = Request.QueryString.Get("str_Type");
         DLLStatus = Request.QueryString.Get("DLLStatus");
         

        if (RMD == "0")
            BindGrid();
        else if (RMD == "1")
            DWN_XLS();
        else if (RMD == "2")
            CSV_BindGrid();

       
    }
    public void DWN_XLS()
    {

        tblGl.Border = 1;

        dgDocket.AllowPaging = false;
        dgDocket.BorderWidth = 1;
        dgDocket.CssClass = "blackfnt";
        dgDocket.Font.Size = 10;
     


        BindGrid();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=Delivered_undelivered_Report.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        frm.Controls.Add(tblGl);
        frm.Controls.Add(dgDocket);


        
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();

    }
    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        //Response.Write(".." + Server.MapPath("."));

        if (strCust == "")
            strCust = "All";

        if (RO == "" || RO == "All")
        {
            RO = "All";
        }
        if (LO == "" || LO == "All")
        {
            LO = "All";
        }
        if (RO_TO == "" || RO_TO == "All")
        {
            RO_TO = "All";
        }
        if (LO_TO == "" || LO_TO == "All")
        {
            LO_TO = "All";
        }

        if (RO == LO)
        {
            RO = "All";
        }

        if (RO_TO == LO_TO)
        {
            RO_TO = "All";
        }

        lblseldet.Text = fromdt + " - " + todt;
        lblro.Text = RO + " - " + RO_TO;
        lblloc.Text = LO + " - " + LO_TO;

        lblCust.Text = strCust;// Session["empcd"].ToString().Trim() + " : " + Session["empnm"].ToString().Trim();
        lblpaybas.Text = str_Paybas;
        lblMode.Text = str_Mode;
        lblTypem.Text = str_Type;
        lblstatus.Text = DLLStatus;

        string SQL = "exec WebxNet_Delivered_undelivered '" + fromdt + "','" + todt + "','" + RO + "','" + LO + "','" + RO_TO + "','" + LO_TO + "','" + strCust + "','" + strPaybas + "','" + strMode + "','" + strType + "','" + DLLStatus + "','" + st_Docnolist + "','d:','0'  ";
        //=Response.Write("SQL.." + SQL);
       //Response.End();
        SqlCommand sqlcmd12 = new SqlCommand(SQL, conn);
       
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);
        DataSet ds = new DataSet();

        da.Fill(ds);

        dgDocket.DataSource = ds;
        dgDocket.DataBind();
        // lblflow.Text = dkt_call;
        dgDocket.Visible = true;
        
        conn.Close();
    }
    public void XLS_BindGrid()
    {
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //conn.Open();

        //string SQL = "exec WebxNet_Delivered_undelivered '" + fromdt + "','" + todt + "','" + RO + "','" + LO + "','" + RO_TO + "','" + LO_TO + "','All','" + strPaybas + "','" + strMode + "','" + strType + "','" + st_Docnolist + "','d:ReportS_XLS','1'  ";
        //SqlCommand sqlcmd12 = new SqlCommand(SQL, conn);
        //sqlcmd12.ExecuteNonQuery();

        //Response.Redirect("http://123.108.47.79/reports_xls/Delivered_Undelivered.XLS");
        //conn.Close();
    }
    public void CSV_BindGrid()
    {
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //conn.Open();
        //string SQL = "exec WebxNet_Delivered_undelivered '" + fromdt + "','" + todt + "','" + RO + "','" + LO + "','" + RO_TO + "','" + LO_TO + "','All','" + strPaybas + "','" + strMode + "','" + strType + "','" + st_Docnolist + "','D:ReportS_XLS','2'  ";
        //SqlCommand sqlcmd12 = new SqlCommand(SQL, conn);
        //sqlcmd12.ExecuteNonQuery();

        //Response.Redirect("D:ReportS_XLS/Delivered_Undelivered.CSV");
        //conn.Close();
    }
    protected void btn_csv_Click(object sender, EventArgs e)
    {
        DWN_XLS();
    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        dgDocket.PageIndex = e.NewPageIndex;
        BindGrid();
    }

    protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            Label dkt_colname = (Label)e.Row.FindControl("lblColname");
            Label lblColDockdt = (Label)e.Row.FindControl("lblColDockdt");

            dkt_colname.Text = dkt_call + " No.";
            lblColDockdt.Text = dkt_call + " Date";
        }
       
    }


}
