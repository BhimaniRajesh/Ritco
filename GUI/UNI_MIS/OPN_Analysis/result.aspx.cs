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


public partial class GUI_UNI_MIS_OPN_Analysis_result : System.Web.UI.Page
{
    public static string DateType,dkt_call , fromdt, todt, RO, LO, St_paylist, st_trnlist, st_delist, st_mode, st_status;



    protected void Page_Load(object sender, EventArgs e)
    {
        BindGrid();
        dkt_call = Session["DocketCalledAs"].ToString();
    }

    public void BindGrid()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        

        RO = Request.QueryString["RO"].ToString();
        LO = Request.QueryString["LO"].ToString();
        DateType = Request.QueryString["DateType"].ToString();
        fromdt = Request.QueryString["fromdt"].ToString();
        todt = Request.QueryString["todt"].ToString();
        St_paylist = Request.QueryString["St_paylist"].ToString();
        st_trnlist = Request.QueryString["st_trnlist"].ToString();
        st_delist = Request.QueryString["st_delist"].ToString();

        
        string strrightnow, strrightnow1;
        System.DateTime righnow = System.DateTime.Today;
        strrightnow = righnow.ToString("dd/MM/yyyy");
        strrightnow1 = righnow.ToString("dd/MM/yyyy");
        if (DateType == "Date")
        {
            strrightnow = Request.QueryString.Get("fromdt");
            strrightnow1 = Request.QueryString.Get("todt");
        }
        else if (DateType == "Week")
        {
            strrightnow = righnow.AddDays(-7).ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        else if (DateType == "Today")
        {
            strrightnow = righnow.ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");

        }
        else if (DateType == "Tilldate")
        {
            strrightnow = "01/04/1990";
            strrightnow1 = righnow.ToString("dd/MM/yyyy");

        }
        string[] strArrDtFrom = strrightnow.Split('/');
        string[] strArrDtTo = strrightnow1.Split('/');
        string dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
        string dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");



        string sql_st = "exec Webx_OPN_FLOW '" + dtFrom + "','" + dtTo + "','" + RO + "','" + LO + "','" + St_paylist + "','" + st_trnlist + "','" + st_delist + "'";
        //Response.Write("<br>sql_st : " + sql_st);
        //Response.Write("<br>RPT_SUBTY : " + RPT_SUBTY);
        SqlCommand sqlcmd12 = new SqlCommand(sql_st, conn);
        //SqlDataReader dr = sqlcmd12.ExecuteReader();
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
        dgDocket.CssClass = "blackfnt";
        dgDocket.Font.Size = 10;

        

        BindGrid();
        StringWriter stringWrite;
        HtmlTextWriter htmlWrite;
        HtmlForm frm = new HtmlForm();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=Analysis_report.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-xls";
        stringWrite = new System.IO.StringWriter();
        htmlWrite = new HtmlTextWriter(stringWrite);
        Controls.Add(frm);
        
            frm.Controls.Add(dgDocket);
       

        //frm.Controls.Add(dgDocket);
        frm.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();





    }
}
