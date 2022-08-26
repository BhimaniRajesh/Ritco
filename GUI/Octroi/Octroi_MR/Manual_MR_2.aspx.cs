using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;

public partial class octroi_OctCustBillStep2 : System.Web.UI.Page
{
  //GUI/OCTROI/Octroi_MR/mr_summ_popup3.aspx?mrsno=HQTR/MR/0000010
   //SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
   

    public DataSet1 _dataSet = new DataSet1();
    int _lastEditedPage;
    string custcd, octroipaid_by;
    string custcls = "";
    MyFunctions fn = new MyFunctions();
    public DataSet1.WorkExperianceDataRow datarow;
    public string dockno;

    public string s1, s2, s3;

    protected void Page_Load(object sender, EventArgs e)
    {

        string mrn=Request.QueryString["mrno"].ToString();
        mrn=mrn.Substring(0,mrn.Length-1);
       // Label1.Text = mrn;
        string[] arrmr= mrn.Split(',');
        DataTable dt = new DataTable();
        dt.Columns.Add("mrn");
        DataRow dr;
        for (int i = 0; i < arrmr.Length;i++)
        {
            dr = dt.NewRow();
            dr["mrn"] = arrmr[i];
            dt.Rows.Add(dr);
            
        }



        gv_1.DataSource = dt;
        gv_1.DataBind();


    }
    protected void view(object sender, EventArgs e)
    {
       // Response.Redirect("OctroiBill_viewPrint.aspx?billno=" + Label1.Text + "&printyn=0");
    }
    protected void print(object sender, EventArgs e)
    {
       // Response.Redirect("OctroiBill_viewPrint.aspx?billno=" + Label1.Text + "&printyn=1");
    }
    }

     

