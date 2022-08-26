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

public partial class GUI_UNI_MIS_OUTSTD_BILL_MR_results_det : System.Web.UI.Page
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


        string sql_st = "exec webx_outstd_bill_mr_det '" + fromdt + "','" + dtTo + "','" + branch + "','" + custcd + "','" + RPT_SUBTY + "','" + RPT_TY + "','" + RPT_no + "','" + asondt + "'";

        //Response.Write("<br>sql_st : " + sql_st);
        //Response.Write("<br>RPT_SUBTY : " + RPT_SUBTY);
        SqlCommand sqlcmd12 = new SqlCommand(sql_st, conn);
        //SqlDataReader dr = sqlcmd12.ExecuteReader();
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd12);

        DataSet ds = new DataSet();

        da.Fill(ds);


        if (RPT_SUBTY == "B")
        {
            dgDocket.DataSource = ds;
            dgDocket.DataBind();
           // lblflow.Text = dkt_call;
            dgDocket.Visible = true;

          
        }
        if (RPT_SUBTY == "M")
        {
            dgMR.DataSource = ds;
            dgMR.DataBind();
            // lblflow.Text = dkt_call;
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
}
