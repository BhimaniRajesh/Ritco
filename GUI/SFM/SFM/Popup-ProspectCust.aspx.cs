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
using System.Web.SessionState;
using System.Data.SqlClient;
using System.Data.SqlTypes;


public partial class _Default : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["ecfy"]);
    SqlCommand cmd = new SqlCommand();
    protected void Page_Load(object sender, EventArgs e)
    {
       // DataGrid1.Attributes.Add("OnCheckedChanged", "return fsubmit()");
      
       
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        
      


                //cmd.CommandText = "Select EMPNM,PWD from WEBX_EMPMST  ";
                //cmd.Connection = conn;

                //conn.Open();
                //SqlDataAdapter da = new SqlDataAdapter();
                //DataSet ds = new DataSet();
                //da.SelectCommand = cmd;
                //da.Fill(ds);
                //DataGrid1.DataSource = ds;
                //DataGrid1.DataBind();
                //conn.Close(); 




    }
    protected void RadioButton1_CheckedChanged(object sender, EventArgs e)
    {


    }
    protected void DataGrid1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void Button1_Click1(object sender, EventArgs e)
    {

        BindGrid();
    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        dgSelect.PageIndex = e.NewPageIndex;
        BindGrid();
    }

    public void BindGrid()
    {
        string custcode = CustCode.Text;
        string custname = CustName.Text;
        string loccls = " and ProspectCode like '" + custcode + "%'";
        string destcls = " and CompanyName like '" + custname + "%'";

        cmd.CommandText = "SELECT  distinct ProspectCode, CompanyName  FROM webx_ProspectCustomer  where ProspectCode is not null and entryby='" + Session["EmpCd"] + "' " + loccls + destcls + " order by CompanyName";
        cmd.Connection = conn;

        conn.Open();
        SqlDataAdapter da = new SqlDataAdapter();
        DataSet ds = new DataSet();
        da.SelectCommand = cmd;
        da.Fill(ds);
        //DataView dv = ds.Tables[0].DefaultView;




        //DataGrid1.DataSource = dv;
        //DataGrid1.DataBind();



        dgSelect.DataSource = ds;
        dgSelect.DataBind();
        conn.Close(); 
    }
}
