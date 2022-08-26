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

public partial class GUI_Operation_Singlescreen_docketentry_popup_city1 : System.Web.UI.Page
{
    String strSQL = "";

    public int intTotalRecords = 0;

    public static string strQSParam;
    public static string strMode = "";
    public static string strReport_Branch = "";
    public static string strRegion = "";
    protected string sdkt_call = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string scr = @"<script>
         function SelectCustomer(obj)
			{  		
            var dockno=obj.value;
            window.opener.update_dockno(dockno);        
			window.close();  
			}  
	       </script>;";
        Page.RegisterClientScriptBlock("SelectCustomer", scr);
        string dockno = Request.QueryString["dockno"].ToString();
        
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string destination = Session["destination"].ToString();
        strSQL = "SELECT * FROM webx_master_docket WHERE dockno like '" + dockno + "%' ORDER BY dockno";

        SqlCommand sqlCommand = new SqlCommand(strSQL, conn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();

        sqlDA.Fill(ds);

        DataTable dt = new DataTable();

        dt.Columns.Add("dockno", typeof(string));

        DataRow dr;

        intTotalRecords = ds.Tables[0].Rows.Count;

        foreach (DataRow drRows in ds.Tables[0].Rows)
        {
            dr = dt.NewRow();

            dr["dockno"] = drRows["dockno"].ToString();


            dt.Rows.Add(dr);
        }

        rptBranch.DataSource = dt;
        rptBranch.DataBind();
    }
}
