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

public partial class GUI_admin_DocketPrint_DocketList : System.Web.UI.Page
{
    public string dockno,mode, agent, date1, date2, tp, sqlstr;
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {

        dockno = Request.QueryString["dockno"].ToString();
        mode = Request.QueryString["mode"].ToString();
        date1 = Request.QueryString["date1"].ToString();
        date2 = Request.QueryString["date2"].ToString();
        tp = Request.QueryString["type"].ToString();


       


        lbldates.Text = fn.Mydate1(date1) + " ~ " + fn.Mydate1(date2);

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();


        string datestr = "", BILLNOstr = "";
        if (mode.CompareTo("0") == 0)
        {
            sqlstr = "SELECT * FROM vw_docket_net WHERE dockno='" + dockno + "'";
        }
        else if (mode.CompareTo("0") == 0)
        {
            if (tp.CompareTo("1") == 0)
            {
                date1 = Request.QueryString["date1"].ToString();
                if (date1 != "")
                {
                    date1 = fn.Mydate1(date1);
                }
                date2 = Request.QueryString["date2"].ToString();
                if (date2 != "")
                {
                    date2 = fn.Mydate1(date2);
                }
                datestr = "and convert(varchar,DOCKDT,106) between convert(datetime,'" + date1 + "',106) and convert(datetime,'" + date2 + "',106)";
            }
            else if (tp.CompareTo("2") == 0)
            {
                DateTime date_tmp = System.DateTime.Now.Subtract(System.TimeSpan.FromDays(7));

                date1 = Convert.ToString(date_tmp.ToString("dd/MM/yyyy"));
                if (date1 != "")
                {
                    date1 = fn.Mydate1(date1);
                }
                date2 = System.DateTime.Now.ToString("dd/MM/yyyy");
                if (date2 != "")
                {
                    date2 = fn.Mydate1(date2);
                }
                datestr = "and convert(varchar,DOCKDT,106) between convert(datetime,'" + date1 + "',106) and convert(datetime,'" + date2 + "',106)";
            }
            else if (tp.CompareTo("3") == 0)
            {
                date1 = System.DateTime.Now.ToString("dd/MM/yyyy");
                if (date1 != "")
                {
                    date1 = fn.Mydate1(date1);
                }
                date2 = date1;
                datestr = "and convert(varchar,DOCKDT,106) between convert(datetime,'" + date1 + "',106) and convert(datetime,'" + date2 + "',106)";
            }

            sqlstr = "SELECT * FROM vw_docket_net WHERE " + datestr;
        }

    
        SqlCommand cmdoct = new SqlCommand(sqlstr,con);
        

        DataSet ds = new DataSet();
        SqlDataAdapter sda = new SqlDataAdapter(cmdoct);

        sda.Fill(ds, "tbl1");
        if (ds.Tables[0].Rows.Count <= 0)
        {
            gvdocklist.CssClass = "redfnt";
            gvdocklist.HorizontalAlign = HorizontalAlign.Center;
        }
        gvdocklist.DataSource = ds;
        gvdocklist.DataBind();

        con.Close();
    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {

    }

    protected void gvdocklist_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
