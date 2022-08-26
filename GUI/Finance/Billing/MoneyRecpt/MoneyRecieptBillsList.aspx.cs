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
using System.Globalization;


public partial class GUI_Finance_MoneyRecpt_MoneyRecieptBillsList : System.Web.UI.Page
{
    public string mrno, mrtype, docno, docsf, date1, date2, tp, sqlstr;
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        mrno=Request.QueryString["mrno"].ToString();
        mrtype=Request.QueryString["mrtype"].ToString();
        docno=Request.QueryString["docno"].ToString();
        docsf=Request.QueryString["docsf"].ToString();
        date1=Request.QueryString["date1"].ToString();
        date2=Request.QueryString["date2"].ToString();
        
        if(date1.CompareTo("")!=0)
            date1 = sqlDate(date1);

        if(date2.CompareTo("")!=0)
            date2 = sqlDate(date2);

        lblmrno.Text = mrno;
        lbldockno.Text = docno;
        lblmrtype.Text = mrtype;
        lbldates.Text = date1 + " ~ " + date2;

        sqlstr = "exec webx_MR_vplist '" + date1 + "','" + date2 + "','" + mrno + "','"  + docno + "','" + docsf + "','" + mrtype + "'";
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        SqlCommand cmdoct = new SqlCommand(sqlstr);
        cmdoct.Connection = con;

        DataSet ds = new DataSet();
        SqlDataAdapter sda = new SqlDataAdapter(cmdoct);

        sda.Fill(ds, "tbl1");
        if (ds.Tables[0].Rows.Count <= 0)
        {
            gvmoneyrecpbills.CssClass = "redfnt";
            gvmoneyrecpbills.HorizontalAlign = HorizontalAlign.Center;
        }
        gvmoneyrecpbills.DataSource = ds;
        gvmoneyrecpbills.DataBind();

        con.Close();
    }

    protected string sqlDate(string date1)
    {
            string sqldate="";
            Array str;
            String fdate, tdate;
            fdate = date1;
            str = fdate.Split('/');
            string FmonthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(Convert.ToInt16(((string[])(str))[1]));//return month name
            // TxtDateRange.Text = (FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2] + " -- " + TmonthName + " " + ((string[])(str1))[0] + " " + ((string[])(str1))[2]);
            sqldate = FmonthName + " " + ((string[])(str))[0] + " " + ((string[])(str))[2];
       return sqldate;
    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {

    }

    protected void gvmoneyrecpbills_SelectedIndexChanged(object sender, EventArgs e)
    {

    }


    protected void gvmoneyrecpbills_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {

      
    }
    
}
