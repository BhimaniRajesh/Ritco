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
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Operations_FM_FM_report_result : System.Web.UI.Page
{
    public string DateType, dkt_call, fromdt, todt, RO, LO, RO_Text, LO_Text, St_paylist, st_trnlist, st_delist, st_mode, st_status;
    public string FMNO, dtFrom, dtTo;
    private DateFunction df = new DateFunction();
    protected void Page_Load(object sender, EventArgs e)
    {
        dkt_call = SessionUtilities.DocketCalledAs;
        RO = Request.QueryString["RO"].ToString();
        RO_Text = Request.QueryString["RO_Text"].ToString();
        LO = Request.QueryString["LO"].ToString();
        LO_Text = Request.QueryString["LO_Text"].ToString();
        fromdt = Request.QueryString["fromdt"].ToString();
        todt = Request.QueryString["todt"].ToString();
        FMNO = Convert.ToString(Request.QueryString["FMNo"]);

        lblFmNO.Text = FMNO;
        lblRegion.Text = RO_Text;
        lblLoc.Text = LO_Text;
        lblDt.Text = Convert.ToDateTime(df.returnmmddyyyy_format(fromdt)).ToString("dd MMM yy") + " - " + Convert.ToDateTime(df.returnmmddyyyy_format(todt)).ToString("dd MMM yy");
        BindGrid();
    }
    public void BindGrid()
    {
        if (FMNO == "")
        {
            dtFrom = Convert.ToDateTime(df.returnmmddyyyy_format(fromdt)).ToString("dd MMM yy");
            dtTo = Convert.ToDateTime(df.returnmmddyyyy_format(todt)).ToString("dd MMM yy");
        }

        string sql_st = "exec webx_PFM_ViewPrint '" + dtFrom + "','" + dtTo + "','" + RO + "','" + LO + "','" + FMNO + "'";
        //Response.Write("<br>sql_st : " + sql_st);
        //Response.Write("<br>RPT_SUBTY : " + RPT_SUBTY);    
        DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sql_st);
        dgDocket.DataSource = ds;
        dgDocket.DataBind();
        // lblflow.Text = dkt_call;
        dgDocket.Visible = true;
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        dgDocket.PageIndex = e.NewPageIndex;
        BindGrid();
    }
    protected void btn_csv_Click(object sender, EventArgs e)
    {

        dgDocket.AllowPaging = false;
        dgDocket.BorderWidth = 1;
        dgDocket.CssClass = "blackfnt";
        dgDocket.Font.Size = 10;

        BindGrid();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=TRF_report.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);

        frm.Controls.Add(dgDocket);


        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }
    protected void dgDocket_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
