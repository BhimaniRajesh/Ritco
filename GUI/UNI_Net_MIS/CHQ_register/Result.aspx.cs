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

public partial class GUI_UNI_Net_MIS_CHQ_register_Result : System.Web.UI.Page
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
        string RPT = Request.QueryString.Get("RPT");
        string RPT_STR = Request.QueryString.Get("RPT_STR");
        string banklist = Request.QueryString.Get("banklist");
        string CHQ_DEPOST = Request.QueryString.Get("CHQ_DEPOST");
        string CHQ_DEPOST_str = Request.QueryString.Get("CHQ_DEPOST_str");
        string CHQ_AccSt_str = Request.QueryString.Get("CHQ_AccSt_str");
        string CHQ_AccSt = Request.QueryString.Get("CHQ_AccSt");
        string CHQ_REcoSt = Request.QueryString.Get("CHQ_REcoSt");
        string CHQ_REcoSt_str = Request.QueryString.Get("CHQ_REcoSt_str");

        string amtfrm = Request.QueryString.Get("amtfrm");
        string amtto = Request.QueryString.Get("amtto");
        string chqnolist = Request.QueryString.Get("chqnolist");
        string DTSTR = Request.QueryString.Get("DTSTR");
        string DTSTR_str = Request.QueryString.Get("DTSTR_str");

        lblchqdepostatus.Text = CHQ_DEPOST_str;
        lblonAccst.Text = CHQ_AccSt_str;
        lblRECst.Text = CHQ_REcoSt_str;
        lblvrty.Text = RPT_STR;
        lbltrty.Text = banklist;
        if (banklist == "")
        {
            lbltrty.Text = "All";
        }
        LBLDATE.Text = fromdt + " - " + todt;
        lblAmt.Text = amtfrm + " - " + amtto;
        LBLBRANCH.Text = RO;
        LBLRPT.Text = LO;
        lbldttyp.Text = DTSTR_str;


        if (RPT == "1")
        {
            TR1.Visible = true;
            TR2.Visible = false;
            TR3.Visible = false;
        }
        else
        {
            TR1.Visible = false;
            TR2.Visible = true;
            TR3.Visible = true;
        }
        string SQL_grid = "";
        SqlTransaction trans;
        string transtyp1 = "";
        trans = Conn.BeginTransaction();
        try
        {
            SQL_grid = "exec WebxNet_CHQ_Register '" + fromdt + "','" + todt + "','" + RO + "','" + LO + "','" + DTSTR + "','" + banklist + "','" + CHQ_REcoSt + "','" + CHQ_DEPOST + "','" + CHQ_AccSt + "','" + amtfrm + "','" + amtto + "','" + RPT + "','" + chqnolist + "'";
            //Response.Write("<br> SQL_grid : " + SQL_grid);

            SqlCommand sqlcmd12 = new SqlCommand(SQL_grid, Conn);
            sqlcmd12.Transaction = trans;
            // SqlDataReader dr = sqlcmd12.ExecuteReader();
            SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);

            DataSet ds = new DataSet();

            da.Fill(ds);
            if (RPT == "1")
            {
                dgDocket.DataSource = ds;
                dgDocket.DataBind();
                // lblflow.Text = dkt_call;
                dgDocket.Visible = true;
            }
            else
            {
                dgDocket1.DataSource = ds;
                dgDocket1.DataBind();
                // lblflow.Text = dkt_call;
                dgDocket1.Visible = true;
            }
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
            // Conn.Close();
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
    protected void pgChange1(object sender, GridViewPageEventArgs e)
    {

        dgDocket1.PageIndex = e.NewPageIndex;


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
        dgDocket1.AllowPaging = false;
        dgDocket1.BorderWidth = 1;
        dgDocket1.CssClass = "blackfnt";
        dgDocket1.Font.Size = 10;


        BindGrid();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=CHQ_Register_Report.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        frm.Controls.Add(TBL_CRI);
        frm.Controls.Add(dgDocket);


        frm.Controls.Add(dgDocket1);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();

    }
}
