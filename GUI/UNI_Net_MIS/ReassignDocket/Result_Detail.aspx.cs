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

public partial class GUI_UNI_Net_MIS_ReassignDocket_Result_Detail : System.Web.UI.Page
{
    SqlConnection Conn;
    public static string dkt_Call, THC_Call;
    protected void Page_Load(object sender, EventArgs e)
    {
        dkt_Call = Session["DocketCalledAs"].ToString();
        string RMD;

        BindGrid();

    }
    public void BindGrid()
    {
        Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        Conn.Open();


        string loc = Request.QueryString["loc"].ToString();
        string Fromdt = Request.QueryString["Fromdt"].ToString();
        string todt = Request.QueryString["todt"].ToString();

        string rptmd = Request.QueryString["rptmd"].ToString();
        LBLRPT.Text = loc;
        string sqlLoc = "Select Loccode,Locname from webx_location where loccode='" + loc + "'";
        SqlCommand cmdLoc = new SqlCommand(sqlLoc, Conn);
        SqlDataReader dr;
        dr = cmdLoc.ExecuteReader();

        while (dr.Read())
        {
            LBLRPT.Text = Convert.ToString(dr["Loccode"]) + ":" + Convert.ToString(dr["Locname"]);
        }
        dr.Close();


        LBLDATE.Text = Fromdt + " - " + Fromdt;



        string SQL_STR = "exec  webx_Reassign_report_det '" + Fromdt + "','" + todt + "','" + rptmd + "','" + loc + "'";
        //Response.Write("<BR> SQL_STR : " + SQL_STR);
        SqlCommand CMD = new SqlCommand(SQL_STR, Conn);
        SqlDataAdapter da = new SqlDataAdapter(CMD);
        DataSet ds = new DataSet();
        da.Fill(ds);
        dgDocket.DataSource = ds;
        dgDocket.DataBind();
    }

    public void DWN_XLS()
    {

        TBL_CRI.Border = 1;

        dgDocket.BorderWidth = 1;
        dgDocket.BorderColor = System.Drawing.Color.Gray;
        dgDocket.Font.Name = "verdana";
        dgDocket.Font.Size = 8;

        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=ReassignDocketDetail.xls");
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

    protected void btn_csv_Click(object sender, EventArgs e)
    {
        DWN_XLS();
    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        dgDocket.PageIndex = e.NewPageIndex;
        BindGrid();

    }


}
