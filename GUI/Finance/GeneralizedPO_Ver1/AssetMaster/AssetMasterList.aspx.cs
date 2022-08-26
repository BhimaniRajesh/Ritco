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

public partial class GUI_Finance_GeneralizedPO_AssetMaster_AssetMasterList : System.Web.UI.Page
{
    SqlConnection cn;  
    public static string chkval;
    string Assetcd = "";
    protected void Page_Load(object sender, EventArgs e)
    {        
        Assetcd = Request.QueryString["Assetcd"].ToString();
        if (Assetcd != "")
        {           
            Select_crt.Text = "Selected Asset Code :" + Assetcd;
        }
        if (IsPostBack == false)
        {
            cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            bindGrid();
        }
    }
    public void bindGrid()
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string sql;
        sql = "Exec USP_General_Asset_Listing '" + Assetcd + "'";

        SqlCommand cmd = new SqlCommand(sql, cn);
        SqlDataAdapter adp = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        adp.Fill(ds);         
        ds.Tables[0].Columns.Add("sn");
        int sn = 1;
        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            dr["sn"] = sn.ToString();
            sn++;            
        }
        GridView1.DataSource = ds;
        GridView1.DataBind();
        cn.Close();
    }
}
