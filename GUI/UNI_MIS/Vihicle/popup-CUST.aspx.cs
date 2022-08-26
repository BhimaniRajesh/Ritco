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

public partial class GUI_admin_CustomerMaster_popup_CUST : System.Web.UI.Page
{
    
    SqlConnection cn;  // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    
    public static string strQSParam;
    public static string sql;
    public static SqlCommand cmd;
    public static SqlDataAdapter adp;
    public static DataSet ds;

    protected void Page_Load(object sender, EventArgs e)
    {

        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        strQSParam = HttpUtility.UrlDecode(Request.QueryString.ToString());
        
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //string sql;
        if (txtCustCd.Text != "" && txtCustNm.Text == "" )
        {
            sql = "Select vendorcode,vendorname from webx_vendor_hdr  where vendorcode like '" + txtCustCd.Text + "%' order by vendorname";
            cmd = new SqlCommand(sql, cn);
            adp = new SqlDataAdapter(cmd);
            ds = new DataSet();
            adp.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
            GridView1.Visible = true;
            Label1.Text = "";
        }
        else
            if (txtCustNm.Text != "" && txtCustCd.Text == "")
            {
                sql = "Select vendorcode,vendorname from webx_vendor_hdr  where vendorname like '" + txtCustNm.Text + "%' order by vendorname";
                cmd = new SqlCommand(sql, cn);
                adp = new SqlDataAdapter(cmd);
                ds = new DataSet();
                adp.Fill(ds);
                GridView1.DataSource = ds;
                GridView1.DataBind();
                GridView1.Visible = true;
                Label1.Text = "";
            }
            else
            { Label1.Text = "Please select anyone"; GridView1.Visible = false; }
                //if (txtCustNm.Text == "" && txtCustCd.Text == "")
                //{
                //    sql = "Select custcd,custnm from webx_CUSTHDR order by CUSTNM";
                //    cmd = new SqlCommand(sql, cn);
                //    adp = new SqlDataAdapter(cmd);
                //    ds = new DataSet();
                //    adp.Fill(ds);
                //    GridView1.DataSource = ds;
                //    GridView1.DataBind();
                //    GridView1.Visible = true;
                //    Label1.Text = "";
                //}
                //else
                //{ Label1.Text = "Please select anyone"; GridView1.Visible = false; }
                    //if (txtCustNm.Text == "" && txtCustCd.Text == "")
                //{ Label1.Text = "Please select anyone"; GridView1.Visible = false; } 
    }

        
 }
    //protected void txtCustCd_TextChanged(object sender, EventArgs e)
    //{
    //    if (txtCustCd.Text != "")
    //    {
    //        sql = "Select custcd,custnm from webx_CUSTHDR  where CUSTCd like '" + txtCustCd.Text + "%' order by CUSTNM";
    //        cmd = new SqlCommand(sql, cn);
    //        adp = new SqlDataAdapter(cmd);
    //        ds = new DataSet();
    //        adp.Fill(ds);
    //        GridView1.DataSource = ds;
    //        GridView1.DataBind();

    //    }

    //}
//}
 
        


        //    SqlDataAdapter adp = new SqlDataAdapter(cmd);
        //    DataTable dt = new DataTable();
        //    adp.Fill(dt);
        //    //dt.Columns.Add("Select", typeof(RadioButton));
        //    //dt.Columns["Select"].AutoIncrement = true;
        //    GridView1.DataSource = dt;
        //    GridView1.DataBind();
        ////}
        //else
        // if(txtCustNm.Text != "")
        //{
        //    sql = "Select custcd,custnm from webx_CUSTHDR  where CUSTNM like '" + txtCustNm.ToString() + "%' order by CUSTNM";
        //    SqlCommand cmd1 = new SqlCommand(sql, cn);
        //    SqlDataAdapter adp1 = new SqlDataAdapter(cmd1);
        //    DataTable dt1 = new DataTable();
        //    adp1.Fill(dt1);
        //    //dt.Columns.Add("Select", typeof(RadioButton));
        //    //dt.Columns["Select"].AutoIncrement = true;
        //    GridView1.DataSource = dt1;
        //    GridView1.DataBind();
        //}

        
   

