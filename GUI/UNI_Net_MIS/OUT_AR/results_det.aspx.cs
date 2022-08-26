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

public partial class GUI_UNI_Net_MIS_OUT_AR_results_det : System.Web.UI.Page
{
    public static string branch, fromdt, dtTo, custcd, RPT_SUBTY, RPT_no, asondt, RPT_TY;
    protected void Page_Load(object sender, EventArgs e)
    {
        BindGrid();
    }

    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        branch = Request.QueryString["branch"].ToString();
        fromdt = Request.QueryString["fromdt"].ToString();
        dtTo = Request.QueryString["todt"].ToString();
        custcd = Request.QueryString["custcd"].ToString();
        RPT_SUBTY = Request.QueryString["RPT_SUBTY"].ToString();
        RPT_no = Request.QueryString["RPT_no"].ToString();
        asondt = Request.QueryString["asondt"].ToString();
        RPT_TY = Request.QueryString["RPT_TY"].ToString();

        lblseldet.Text = fromdt + '-' + dtTo;
        lblloc.Text = branch;
        lblcust.Text = custcd;

        if (RPT_TY == "L")
        {
            lblflow.Text = "Location";
        }
        else if (RPT_TY == "C")
        {
            lblflow.Text = "Customer";
        }

        string sqlLoc = "Select Loccode,Locname from webx_location with(NOLOCK) where loccode='" + lblloc.Text + "'";
        SqlCommand cmdLoc = new SqlCommand(sqlLoc, conn);
        SqlDataReader drLoc;
        drLoc = cmdLoc.ExecuteReader();

        while (drLoc.Read())
        {
            lblloc.Text = Convert.ToString(drLoc["Loccode"]) + ":" + Convert.ToString(drLoc["Locname"]);
        }
        drLoc.Close();

        if (lblcust.Text == "")
        {
            lblcust.Text = "ALL";
        }
        else
        {
            lblcust.Text = lblcust.Text;
        }
        string sql_st = "exec webx_outstd_bill_mr_det '" + fromdt + "','" + dtTo + "','" + branch + "','" + custcd + "','" + RPT_SUBTY + "','" + RPT_TY + "','" + RPT_no + "','" + asondt + "'";
        //Response.Write("<br> sql_st : " + sql_st);
        SqlCommand sqlcmd12 = new SqlCommand(sql_st, conn);
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);

        DataSet ds = new DataSet();

        da.Fill(ds);


        if (RPT_SUBTY == "B")
        {
            dgDocket.DataSource = ds;
            dgDocket.DataBind();
            dgDocket.Visible = true;


        }
        if (RPT_SUBTY == "M")
        {
            dgMR.DataSource = ds;
            dgMR.DataBind();
            dgMR.Visible = true;
        }

        conn.Close();
    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        if (RPT_SUBTY == "B")
        {
            dgDocket.PageIndex = e.NewPageIndex;
        }
        if (RPT_SUBTY == "M")
        {
            dgMR.PageIndex = e.NewPageIndex;
        }

        BindGrid();
    }
   
    
    public void DWN_XLS()
    {
        if (RPT_SUBTY == "B")
        {
            dgDocket.BorderWidth = 1;
            dgDocket.Font.Size = 8;
            dgDocket.Font.Name = "verdana";
            dgDocket.AllowPaging = false;
            BindGrid();

            StringWriter stringWrite;
            HtmlTextWriter htmlWrite;
            HtmlForm frm = new HtmlForm();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=OutStandingBillDetail.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-xls";
            stringWrite = new System.IO.StringWriter();
            htmlWrite = new HtmlTextWriter(stringWrite);
            Controls.Add(frm);
            Response.Write("OutStanding Bill Detail");
            frm.Controls.Add(dgDocket);
            frm.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        if (RPT_SUBTY == "M")
        {
            dgMR.BorderWidth = 1;
            dgMR.Font.Size = 8;
            dgMR.Font.Name = "verdana";
            dgMR.AllowPaging = false;
            BindGrid();

            StringWriter stringWrite;
            HtmlTextWriter htmlWrite;
            HtmlForm frm = new HtmlForm();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=OutStandingMRDetail.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-xls";
            stringWrite = new System.IO.StringWriter();
            htmlWrite = new HtmlTextWriter(stringWrite);
            Controls.Add(frm);
            Response.Write("OutStanding MR Detail");
            frm.Controls.Add(dgMR);
            frm.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        
    }
    protected void btn_csv1_Click(object sender, EventArgs e)
    {
        DWN_XLS();
    }
    protected void btn_csv_Click(object sender, EventArgs e)
    {
        DWN_XLS();
    }
}
