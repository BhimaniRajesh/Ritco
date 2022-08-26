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

public partial class GUI_UNI_MIS_Stock_Report_results_det : System.Web.UI.Page
{
    public static string dkt_call = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        BindGrid();
        dkt_call = Session["DocketCalledAs"].ToString();
    }
    public void BindGrid()
    {



        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();



        string branch, rpttyp, fromdt, todt, RPT_no;

        branch = Request.QueryString["branch"].ToString();
        fromdt = Request.QueryString["fromdt"].ToString();
        todt = Request.QueryString["todt"].ToString();
        RPT_no = Request.QueryString["RPT_no"].ToString();
        //rpttyp = Request.QueryString["rpttyp"].ToString();

        lblseldet.Text = fromdt + " - " + todt;
        lblloc.Text = branch;
        LBLRPT.Text = rpttyp;

        string sql_st = "exec webx_Stock_Report_det '" + fromdt + "','" + todt + "','" + branch + "','" + RPT_no + "'";
        //Response.Write("<br>sql_st : " + sql_st);
        SqlCommand sqlcmd12 = new SqlCommand(sql_st, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);
        DataSet ds = new DataSet();
        da.Fill(ds);
        dgDocket.DataSource = ds;
        dgDocket.DataBind();
        // lblflow.Text = dkt_call;
        dgDocket.Visible = true;
        conn.Close();
    }
    protected void dgDocket_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //try
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                Label dkt_colname = (Label)e.Row.FindControl("lblColname");
                //Label lblColDockdt = (Label)e.Row.FindControl("lblColDockdt");

                dkt_colname.Text = dkt_call + " No.";
                //lblColDockdt.Text = dkt_call + " Date";
            }
            
        }
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
        dgDocket.Font.Name = "verdana";
        dgDocket.Font.Size = 8;

        TBL_CRI.Border = 1;

        BindGrid();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=Stock_details.xls");
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
