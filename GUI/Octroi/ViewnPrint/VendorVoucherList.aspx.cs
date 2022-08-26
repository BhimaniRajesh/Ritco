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


public partial class GUI_Octroi_ViewnPrint_VendorVoucherList : System.Web.UI.Page
{
    string tp, dates,date1,date2;
    public static string pagename = "", status = "", selcri = "";
    SqlConnection con;

    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        
        lbldates.Text= Request.QueryString["date1"].ToString() + " ~ " + Request.QueryString["date2"].ToString();
        lblvendortype.Text = Request.QueryString["vendortype"].ToString();
        lblvendorname.Text=Request.QueryString["vendorname"].ToString();
        lblvoucherno.Text=Request.QueryString["voucherno"].ToString();
        lbldocno.Text=Request.QueryString["docno"].ToString();
        date1=Request.QueryString["date1"].ToString();
        date2=Request.QueryString["date2"].ToString();
        tp=Request.QueryString["type"].ToString();
        dates=Request.QueryString["dates"].ToString();


      

        if(tp.CompareTo("2")==0)
        {
            if (dates.CompareTo("0") == 0)
            {
                selcri = "convert(varchar,transdate,106) between convert(varchar,'" + date1 + "',106) and convert(varchar,'" + date2 + "',106)";
                lbldates.Text = date1 + " ~ " + date2;
            }
            else if (dates.CompareTo("1") == 0)
            {
                DateTime date_tmp = System.DateTime.Now.Subtract(System.TimeSpan.FromDays(7));
                date1 = Convert.ToString(date_tmp.ToString("dd/MM/yyyy"));
                date2 = System.DateTime.Now.ToString("dd/MM/yyyy");
                selcri = "convert(varchar,transdate,106) between convert(datetime,'" + date1 + "',106) and convert(datetime,'" + date2 + "',106)";
                lbldates.Text = "Last Week";
            }
            else if (dates.CompareTo("2") == 0)
            {
                DateTime date_tmp = System.DateTime.Now;
                selcri = "convert(varchar,transdate,106) between convert(datetmp,'" + date_tmp + "',106) and convert(datetime,'" + date_tmp + "',106)";
                lbldates.Text = "Today";
            }
        }
        else if (tp.CompareTo("0") == 0)
        {
            selcri = " voucherno='" + Request.QueryString["voucherno"].ToString() + "'";
        }
        else if (tp.CompareTo("1") == 0)
        {
            selcri = " docno='" + Request.QueryString["docno"].ToString() + "'";
        }





        string sql = "SELECT docno,voucherno,entrydt,pbov_code,pbov_name,netamt,documentno=(case when bookcode='VENDOR BILL' then voucherno else docno end ),bookcode FROM webx_vouchertrans_arch WHERE " + selcri;
        SqlCommand cmd = new SqlCommand(sql, con);
      

        string docno = "", bookcode="";
        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            docno = Convert.ToString(dr["docno"]);
            bookcode = Convert.ToString(dr["bookcode"]);
        }
        dr.Close();
        if (bookcode == "VENDOR BILL")
        {
             pagename = "ExpensePaymentVoucher_xls.aspx";
        }
        else if (bookcode == "ADVANCE VENDOR PAYMENT")
        {
            if (inStr(docno.ToUpper(), "THC"))
            {
                pagename = "THCAdvancedVoucher.aspx";
            }
            else if (inStr(docno.ToUpper(), "DS")|| inStr(docno.ToUpper(), "PS"))
            {
                pagename = "PDCVoucher_xls.aspx";
                status = "1";
            }
        }
        else if (bookcode == "BALANCE VENDOR PAYMENT")
        {
            if (inStr(docno.ToUpper(),"THC"))
            {
                pagename = "THCBalanceVoucher.aspx";
            }
            else if (inStr(docno.ToUpper(), "DS") || inStr(docno.ToUpper(), "PS"))
            {
                pagename = "pdcvoucher_xls.aspx";
                status = "2";
            }
        }

        dataBind();
    }


    protected void dataBind()
    {
        string sql = "SELECT docno,voucherno,entrydt,pbov_code,pbov_name,netamt,documentno=(case when bookcode='VENDOR BILL' then voucherno else docno end ),bookcode FROM webx_vouchertrans_arch WHERE " + selcri;
        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);

        gvvendorvoucher.DataSource = ds;
        gvvendorvoucher.DataBind();
    }


    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        gvvendorvoucher.PageIndex = e.NewPageIndex;
        dataBind();
    }




    protected void gvvendorvoucher_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected bool inStr(string str,string substr)
    {
        int len = 0;
        int sublen=0;
        int flag=0;
        len = str.Length;
        sublen = substr.Length;
        for (int i = 0; i < len - sublen; i++)
        {
            if (str.Substring(i, sublen).CompareTo(substr) == 0)
            {
                flag = 1;
                break;
            }
        }
        if (flag == 1)
            return true;
        else
            return false;
    }


}
