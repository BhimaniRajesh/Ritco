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

public partial class GUI_Octroi_ViewnPrint_ManualOctroiMrList : System.Web.UI.Page
{
    string tp,mrno, date1, date2;
    MyFunctions fn = new MyFunctions();
    
    protected void Page_Load(object sender, EventArgs e)
    {

        tp = Request.QueryString["type"].ToString();
        mrno = Request.QueryString["mrno"].ToString();
        date1 = Request.QueryString["date1"].ToString();
        date2 = Request.QueryString["date2"].ToString();
        
        lblmrno.Text = mrno;
        lblmrdate.Text = fn.Mydate1(date1) + " ~ " + fn.Mydate1(date2);

        date1 = fn.Mydate1(date1);
        date2 = fn.Mydate1(date2);



        dataBind();

        /* select a.mrsno,a.mrsdt,a.ptname,a.mrsamt,b.recptno from webx_mr_hdr a, webx_mr_det b 
        where a.mrsno='mrcrhq00001' and b.mrsno='mrcrhq00001'*/
      

    }


    protected void dataBind()
    {
        DateTime date_tmp = System.DateTime.Now.Subtract(System.TimeSpan.FromDays(7));
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        string qstr = "";
        qstr = "webx_MR_vplist '" + date1 + "','" + date2 + "','" + mrno + "','','','4'";


        SqlCommand cmdoct = new SqlCommand(qstr);
        cmdoct.Connection = con;

        DataSet ds = new DataSet();
        SqlDataAdapter sda = new SqlDataAdapter(cmdoct);

        sda.Fill(ds, "tbl1");
        if (ds.Tables[0].Rows.Count <= 0)
        {
            gvmanualoctmr.CssClass = "redfnt";
            gvmanualoctmr.HorizontalAlign = HorizontalAlign.Center;
        }
        gvmanualoctmr.DataSource = ds;
        gvmanualoctmr.DataBind();
        con.Close();
    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        gvmanualoctmr.PageIndex = e.NewPageIndex;
        DataBind();
    }

    protected void gvmanualoctmr_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
