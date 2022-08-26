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

public partial class popupbranch : System.Web.UI.Page
{
    public static string strQSParam;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack == false)
        {
            strQSParam = Request.QueryString.ToString();
            SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            //SqlConnection cn = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
            //SqlConnection cn = new SqlConnection(myCommon.Common.cnstr);
            string sql = "Select loccode,locname from webx_Location where activeflag='Y' order by locname";
            SqlCommand cmd = new SqlCommand(sql, cn);
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adp.Fill(dt);
            //dt.Columns.Add("Select", typeof(RadioButton));
            //dt.Columns["Select"].AutoIncrement = true;
            GridView1.DataSource = dt;
            GridView1.DataBind(); 
  
        }

    }

    public void   SelectLocation( string objLocation)
        {



        string scr1 = @"<script>
        function SelectCustomer(obj)
            {
            var lococde=obj.value;
            window.opener.update1(lococde);
            window.close();
            }
            </script>;";
        Page.RegisterClientScriptBlock("SelectCustomer", scr1);

 


           //   old working    window.opener.document.forms[0].strQSParam.value = objLocation.value;
                
             //    window.opener.document.forms[0].ctl00$MyCPH1$txtLocCod1.value = objLocation.value
            
        }    
}
