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

public partial class GUI_admin_CustomerMaster_ListAll : System.Web.UI.Page
{
    SqlConnection cn;  // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    public static string chkval;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack == false)
        {
            cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            
            
            bindGrid();
        }
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        bindGrid();
    }
    public void bindGrid()
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
            string sql;


            sql = "select assetcd,assetname,units,category from webx_assetmaster";

           
            SqlCommand cmd = new SqlCommand(sql, cn);
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            adp.Fill(ds);
      
            ds.Tables[0].Columns.Add("s1");
            ds.Tables[0].Columns.Add("s2");
            ds.Tables[0].Columns.Add("sn");
  int sn = 1;
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
              
                dr["sn"] = sn.ToString();
                sn++;
                string s1 = dr["units"].ToString();

                if (s1 == "1")
                {
                    s1 = "Nos.";
                
                }
               else if (s1 == "2")
                {
                    s1 = "Kgs.";

                }
                else if (s1 == "3")
                {
                    s1 = "Meter";

                }
                else if (s1 == "4")
                {
                    s1 = "Liter";

                }

                dr["s1"] = s1;

                string s2 = dr["category"].ToString();

                if (s2 == "1")
                {
                    s2 = "Movable";

                }
                else if (s2 == "2")
                {
                    s2 = "Non-Movable";

                }
                dr["s2"] = s2;


            
            
            }

            GridView1.DataSource = ds;
            GridView1.DataBind();
          cn.Close();
         }
        
    }



