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

public partial class GUI_Octroi_Octroi_Bill_BillListReport : System.Web.UI.Page
{
    bool flag;
    public string billno,location,customer,date1,date2,tp,sqlstr;
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        flag = false;
        billno = Request.QueryString["billno"].ToString();
        location = Request.QueryString["location"].ToString();
        customer = Request.QueryString["customer"].ToString();
        date1 = Request.QueryString["date1"].ToString();
        date2 = Request.QueryString["date2"].ToString();
        tp = Request.QueryString["type"].ToString();

        lbldates.Text = date1 + "~" + date2;
        lblbillno.Text = billno;
        lblcustomer.Text = customer;
        if (customer == "")
            lblcustomer.Text = "All";

        lbllocation.Text = location;

       
                        
        string datestr = "",BILLNOstr="",brcdstr="";
        
        if (tp.CompareTo("0") == 0)
        {
            datestr = "And 1=1";
            BILLNOstr = "a.BILLNO='" + billno + "'";
        }
        else if (tp.CompareTo("1") == 0)
        {
            if (location != "")
            {

                brcdstr = "and bbrcd='" + location + "'";
            }
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

            datestr = "and convert(varchar,BGNDT,106) between convert(datetime,'" + date1 + "',106) and convert(datetime,'" + date2 + "',106)";
            BILLNOstr = "1=1";
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
            datestr = "and convert(varchar,BGNDT,106) between convert(datetime,'" + date1 + "',106) and convert(datetime,'" + date2 + "',106)";
            BILLNOstr = "1=1";
        }
        else if (tp.CompareTo("3") == 0)
        {
            date1 = System.DateTime.Now.ToString("dd/MM/yyyy");
            if (date1 != "")
            {
                date1 = fn.Mydate1(date1);
            }
            date2 = date1;
            datestr = "and convert(varchar,BGNDT,106) between convert(datetime,'" + date1 + "',106) and convert(datetime,'" + date2 + "',106)";
            BILLNOstr = "1=1";
        }

        string Custr;
        if (customer.Trim() == "-- All --")
        {
            Custr = "And 1=1";

        }
        else
        {
            Custr = "AND PTMSNM='" + customer + "'";
        }
        string sqlstr1 = BILLNOstr + "  " + datestr + "  " + Custr + " " + brcdstr ;
        sqlstr = "SELECT distinct a.BILLNO,BBRCD=BBRCD +'~'+(select locname from webx_location a where  a.loccode=BBRCD),BILLAMT,BILLSTATUS,convert(varchar,BGNDT,106) as BGNDT,convert(varchar,BSBDT,106) as BSBDT,convert(varchar,BDUEDT,106) as BDUEDT,convert(varchar,BCLDT,106) as BCLDT FROM webx_billmst a,webx_oct_det b WHERE a.billno=b.billno and " + sqlstr1 + " and paybas='6'";

        dataBind();
    }
    

    protected void billNoClick(object sender,EventArgs e)
    {
        Response.Redirect("OctroiBill_viewPrint.aspx?voucherno=" + billno);
    }


    protected void dataBind()
    {

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();


        SqlCommand cmdoct = new SqlCommand(sqlstr);
        cmdoct.Connection = con;

        DataSet ds = new DataSet();
        SqlDataAdapter sda = new SqlDataAdapter(cmdoct);

        sda.Fill(ds, "tbl1");
        if (ds.Tables[0].Rows.Count == 0)
        {
            DataColumn dc0 = new DataColumn("ocbillno", typeof(string));
            ds.Tables[0].Columns.Add(dc0);
            DataRow dr;
            dr = ds.Tables[0].NewRow();
            ds.Tables[0].Rows.Add(dr);
            flag = true;
        }
        gvoctroibill.DataSource = ds.Tables["tbl1"];
        gvoctroibill.DataBind();

        if (ds.Tables[0].Rows.Count == 0)
        {
            gvoctroibill.EmptyDataText = "No Bills Found.........";
        }
        con.Close(); 
    }


    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        gvoctroibill.PageIndex = e.NewPageIndex;
        dataBind();   
    }

    protected void gvoctroibill_SelectedIndexChanged(object sender, EventArgs e)
    {

    }


    protected void gvoctroibill_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (flag == true)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lbl = (Label)e.Row.FindControl("lblsrnocomplainlist");
                lbl.Text = "";
                LinkButton lnk = (LinkButton)e.Row.FindControl("lnkview");
                lnk.Visible = false;
                
            }
        }
    }
}
