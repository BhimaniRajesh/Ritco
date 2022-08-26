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

public partial class GUI_UNI_Net_MIS_TDS_REgister_Result : System.Web.UI.Page
{
    SqlConnection Conn;
    
    int i = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        string RMD;
        RMD = Request.QueryString["RMD"].ToString();

        if (RMD == "N")
        {
            BindGrid();
        }
        else
        {
            // BindGrid();
            DWN_XLS();

        }
    }
    public void BindGrid()
    {
        Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Conn.Open();

        string RO = "", LO = "", RTP_DT_str = "", fromdt = "", todt = "", RPT = "", RTP_DT = "";
        string cust_vendcd = "", cust_vendnm = "", acccd = "", accnm = "", VRnolist = "", amt_frm = "", amt_to = "";

        RO = Request.QueryString["RO"].ToString();
        LO = Request.QueryString["LO"].ToString();
        fromdt = Request.QueryString["fromdt"].ToString();
        todt = Request.QueryString["todt"].ToString();
        RPT = Request.QueryString["RPT"].ToString();
        RTP_DT_str = Request.QueryString["RTP_DT_str"].ToString();
        cust_vendcd = Request.QueryString["cust_vendcd"].ToString();
        cust_vendnm = Request.QueryString["cust_vendnm"].ToString();
        acccd = Request.QueryString["acccd"].ToString();
        accnm = Request.QueryString["accnm"].ToString();
        VRnolist = Request.QueryString["VRnolist"].ToString();
        amt_frm = Request.QueryString["amt_frm"].ToString();
        amt_to = Request.QueryString["amt_to"].ToString();

        LBLDATE.Text = fromdt + " - " + todt;
        LBLBRANCH.Text = RO;
        LBLRPT.Text = LO;
        lblamt.Text = amt_frm + " - " + amt_to;
        lblcust.Text = cust_vendcd;
        lblBM_TYp.Text = RTP_DT_str;

        if (cust_vendnm == "")
        {
            cust_vendnm = "";
        }
        else
        {
            lblcust.Text = "8888 : " + cust_vendnm;
            cust_vendnm = "%" + cust_vendnm + "%";
            
        }

        if (amt_frm == "0.00")
            amt_frm = "0";

        if (amt_to == "0.00")
            amt_to = "0";

        string Year = Session["FinYear"].ToString();

        string abc = Year.Substring(2, 2);
        //Response.Write("<br>Year " + Year);
        //Response.Write("<br>Year " + abc);
        // Response.End();
        string CloseYear = Convert.ToString((Convert.ToInt16(abc) + 1));
        if (CloseYear.Length == 1)
        {
            CloseYear = "0" + CloseYear;
        }
       string YearString = Convert.ToString(abc) + "_" + Convert.ToString(CloseYear);
       string yearSuffix = YearString;



        string SQL_STR = "";
        SQL_STR = "EXEC WebxNet_TDS_Register '" + fromdt + "','" + todt + "','" + RO + "','" + LO + "','" + cust_vendcd + "','" + cust_vendnm + "','" + acccd + "','" + VRnolist + "','" + amt_frm + "','" + amt_to + "','" + RPT + "','" + yearSuffix + "'";
        SqlCommand CMD = new SqlCommand(SQL_STR, Conn);
       // Response.Write("SQL_STR : " + SQL_STR);
        SqlDataAdapter da = new SqlDataAdapter(CMD);
        DataSet ds = new DataSet();
        da.Fill(ds);
        da.Fill(ds, "RDATA");
        Session["DATA"] = ds;
        dgDocket.DataSource = ds.Tables["RDATA"];
        if (RPT == "P")
        {
            dgDocket.DataBind();
            dgDocket.Columns[3].Visible = false;
            dgDocket.Columns[4].Visible = false;
            dgDocket.Columns[5].Visible = false;
            dgDocket.Columns[6].Visible = false;
            dgDocket.Columns[7].Visible = true;            
            dgDocket.Visible = true;            
        }
        else
        {
            
            dgDocket.Columns[3].Visible = false;
            dgDocket.Columns[4].Visible = false;
            dgDocket.Columns[5].Visible = false;
            dgDocket.Columns[6].Visible = false;
            dgDocket.Columns[7].Visible = false;
            dgDocket.DataBind();
            dgDocket.Visible = true;
        }
        Conn.Close();
    }

    public void DWN_XLS()
    {
        dgDocket.AllowPaging = false;
        dgDocket.BorderWidth = 1;
        dgDocket.CssClass = "blackfnt";
        dgDocket.Font.Size = 10;

        //TBL_CRI.Border = 1;

        BindGrid();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=TDS_Register_Report.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        //frm.Controls.Add(TBL_CRI);
        frm.Controls.Add(dgDocket);

        //frm.Controls.Add(dgDocket);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        dgDocket.PageIndex = e.NewPageIndex;
        BindGrid();
    }
    protected void btn_csv_Click(object sender, EventArgs e)
    {
        string final;
        final = "?RO=" + Request.QueryString["RO"].ToString();
        final += "&LO=" + Request.QueryString["LO"].ToString();
        final += "&fromdt=" + Request.QueryString["fromdt"].ToString();
        final += "&todt=" + Request.QueryString["todt"].ToString();
        final += "&RPT=" + Request.QueryString["RPT"].ToString();
        final += "&RTP_DT_str=" + Request.QueryString["RTP_DT_str"].ToString();
        final += "&cust_vendcd=" + Request.QueryString["cust_vendcd"].ToString();
        final += "&cust_vendnm=" + Request.QueryString["cust_vendnm"].ToString();
        final += "&acccd=" + Request.QueryString["acccd"].ToString();
        final += "&accnm=" + Request.QueryString["accnm"].ToString();
        final += "&VRnolist=" + Request.QueryString["VRnolist"].ToString();
        final += "&amt_frm=" + Request.QueryString["amt_frm"].ToString();
        final += "&amt_to=" + Request.QueryString["amt_to"].ToString();
        final += "&RMD=Y";

        Response.Redirect("Result.aspx" + final);
    }
}
