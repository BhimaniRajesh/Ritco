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

public partial class GUI_Octroi_ViewnPrint_VendorPaymentBill : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
    string tp,dates,billno, date1, date2, doctype, vendorname, vendortype;
   
    protected void Page_Load(object sender, EventArgs e)
    {

            tp=Request.QueryString["type"].ToString();
            dates=Request.QueryString["dates"].ToString();
            billno=Request.QueryString["billno"].ToString();
            date1 = Request.QueryString["date1"].ToString();
            date2 = Request.QueryString["date2"].ToString();
            doctype=Request.QueryString["doctype"].ToString();
            vendorname=Request.QueryString["vendorname"].ToString();
            vendortype=Request.QueryString["vendortype"].ToString();

            lblbillno.Text=billno;
            lbldates.Text = fn.Mydate1(date1) + " ~ " + fn.Mydate1(date2);
            lbldoctype.Text= doctype;
            lblvendorname.Text= vendorname;
            lblvendortype.Text= vendortype;

    
    
            string datqry="",numqry="",sqlqry="",selcri="";
       
            // DATE CRITERIA
            if (dates.CompareTo("0") == 0)
            {
                datqry = "convert(varchar,ENTRYDT,106) between convert(varchar,'" + date1 + "',106) and convert(varchar,'" + date2 + "',106)";
                lbldates.Text = date1 + " ~ " + date2;
            }
            else if (dates.CompareTo("1") == 0)
            {
                DateTime date_tmp = System.DateTime.Now.Subtract(System.TimeSpan.FromDays(7));
                date1 = Convert.ToString(date_tmp.ToString("dd/MM/yyyy"));
                date2 = System.DateTime.Now.ToString("dd/MM/yyyy");
                datqry = "convert(varchar,ENTRYDT,106) between convert(datetime,'" + date1 + "',106) and convert(datetime,'" + date2 + "',106)";
                lbldates.Text = "Last Week";
            }
            else if (dates.CompareTo("2") == 0)
            {
                DateTime date_tmp = System.DateTime.Now;
                datqry = "convert(varchar,ENTRYDT,106) between convert(datetmp,'" + date_tmp + "',106) and convert(datetime,'" + date_tmp + "',106)";
                lbldates.Text = "Today";
            }


            // CRITERIA OF VENDORNAME,VENDORTYPE, AND DOCUMNET TYPE
            if (tp.CompareTo("0") != 0)
            {
                if(vendorname.CompareTo( "All")==0)
                    selcri = " and betype='" + doctype + "'";
                else
                    selcri = " and betype='" + doctype + "' and vendorname='" + vendorname +  "'";
            }

            // BILL NUMBER WISE SELECTION

            if(tp.CompareTo("0")==0)
            {
                numqry=" billno='" + billno + "'";
            }

            dataBind();
    }


    protected void dataBind()
    {

        sqlqry = "SELECT billno,entrydt,brcd,vendorname,duedt,netamt FROM webx_vendorbill_hdr WHERE " + datqry + numqry + selcri;

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        SqlCommand cmd = new SqlCommand(sqlqry, con);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();

        da.Fill(ds, "tbl1");
        gvvendorpayment.DataSource = ds;
        gvvendorpayment.DataBind();

        if (ds.Tables[0].Rows.Count <= 0)
        {
            gvvendorpayment.CssClass = "redfnt";
            gvvendorpayment.HorizontalAlign = HorizontalAlign.Center;
        }

        con.Close();
    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        gvvendorpayment.PageIndex = e.NewPageIndex;

    }

    protected void gvvendorpayment_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

}
