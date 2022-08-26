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

public partial class GUI_Octroi_ViewnPrint_DirectVoucherList : System.Web.UI.Page
{
    string docno, recno, billno, date1, date2,tp,dates;
    MyFunctions fn=new MyFunctions();

    protected void Page_Load(object sender, EventArgs e)
    {
        tp = Request.QueryString["type"].ToString();
        dates = Request.QueryString["dates"].ToString();
        docno = Request.QueryString["docno"].ToString();
        recno = Request.QueryString["recno"].ToString();
        billno = Request.QueryString["billno"].ToString();
        date1 = Request.QueryString["date1"].ToString();
        date2 = Request.QueryString["date2"].ToString();

        lbldocno.Text = docno;
        lblrecno.Text = recno;
        lblbillno.Text = billno;
        lbldates.Text = date1 + " ~ " + date2;
            

        
        /*
         *      type 0 for docno selected
         *      type 1 for billno selected 
         *      type 2 for recno selected
         *      type 5 for none selected
         * 
         *      dates 0 for From and To
         *      dates 1 for weekly
         *      date 2 for today's
         * 
         */


        string datqry = "", numqry = "",subqry="";
        date1 = fn.Mydate1(date1);
        date2 = fn.Mydate1(date2);


        if (tp.CompareTo("5") == 0)
        {
            if (dates.CompareTo("0") == 0)
            {
                datqry = "convert(varchar,paydt,106) between convert(datetime,'" + date1 + "',106) and convert(datetime,'" + date2 + "',106)";
                lbldates.Text = date1 + " ~ " + date2;
            }
            else if (dates.CompareTo("1") == 0)
            {
                DateTime date_tmp = System.DateTime.Now.Subtract(System.TimeSpan.FromDays(7));
                date1 = Convert.ToString(date_tmp.ToString("dd/MM/yyyy"));
                date2 = System.DateTime.Now.ToString("dd/MM/yyyy");
                datqry = "convert(varchar,paydt,106) between convert(datetime,'" + date1 + "',106) and convert(datetime,'" + date2 + "',106)";
                lbldates.Text = "Last Week";
            }
            else if (dates.CompareTo("1") == -1)
            {
                string date_tmp = fn.Mydate1(System.DateTime.Now.ToString("dd/MM/yyyy"));
                datqry = "convert(varchar,paydt,106) between convert(datetme,'" + date_tmp + "',106) and convert(datetime,'" + date_tmp + "',106)";
                lbldates.Text = "Today";
                date1 = fn.Mydate1(System.DateTime.Now.ToString("dd/MM/yyyy"));
                date2 = fn.Mydate1(System.DateTime.Now.ToString("dd/MM/yyyy"));
            }
            numqry = " voucherno in (select voucherno from webx_oct_det where convert(varchar,paydt,106) between convert(datetime,'" + date1 + "',106) and convert(datetime,'" + date2 + "',106)) ";
        }
        else if (tp.CompareTo("0") == 0)
        {
            numqry = " voucherno in (select voucherno from webx_oct_det where dockno='" + docno + "') ";
        }
        else if (tp.CompareTo("1") == 0)
        {
            numqry = " voucherno in (select voucherno from webx_oct_det where OCAGBILLNO='" + billno + "') ";
        }
        else if (tp.CompareTo("2") == 0)
        {
            numqry = " voucherno in (select voucherno from webx_oct_det where recptno='" + recno + "') ";
        }


        // string query = "SELECT voucherno,transdate,pbov_name,sum(credit) as octamt ,totchrg FROM webx_voucherTrans_arch WHERE " + datqry + numqry + " group by voucherno,transdate,pbov_name,totchrg";

       string query = "SELECT voucherno,transdate,pbov_name,sum(credit) as octamt ,totchrg FROM webx_voucherTrans_arch WHERE   " + numqry + " and PBOV_TYP='O' group by voucherNo,transdate,PBOV_CODE,PBOV_NAME,totchrg order by transdate";
        
        
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                con.Open();

                SqlCommand cmdoct = new SqlCommand(query);
                cmdoct.Connection = con;

                DataSet ds = new DataSet();
                SqlDataAdapter sda = new SqlDataAdapter(cmdoct);

                
                sda.Fill(ds, "tbl1");
                gvdirectvoucher.DataSource = ds;
                gvdirectvoucher.DataBind();
                if (ds.Tables[0].Rows.Count <= 0)
                {
                    gvdirectvoucher.CssClass = "redfnt";
                }
                con.Close();

    }



    protected void pgChange(object sender, GridViewPageEventArgs e)
    {

    }

    protected void gvdirectvoucher_SelectedIndexChanged(object sender, EventArgs e)
    {

    }



}
