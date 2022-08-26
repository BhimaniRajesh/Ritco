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

public partial class GetToCity : System.Web.UI.Page
{
    String strSQL = "";

    public int intTotalRecords = 0;

    public static string strQSParam;
    public static string strMode = "";
    public static string strReport_Branch = "";
    public static string strRegion = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        string scr = @"<script>
         function SelectCustomer(obj)
			{  		
            var lococde=obj.value;
            window.opener.update_city1(lococde);        
			window.close();  
			}  
	       </script>";
        Page.RegisterClientScriptBlock("SelectCustomer", scr);

        if (!IsPostBack)
        {
            strQSParam = HttpUtility.UrlDecode(Request.QueryString.ToString());

            if (strQSParam.Trim() != "")
            {
                string[] strArrQS = strQSParam.Split(',');

                strMode = strArrQS[0];
                strReport_Branch = strArrQS[1];
                strRegion = strArrQS[2];
            }
        }
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        //string destination = Session["destination"].ToString();
        strSQL = "SELECT DISTINCT LOCATION FROM webx_citymaster"; // where del_loc = '" + destination + "' ORDER BY LOCATION";

        SqlCommand sqlCommand = new SqlCommand(strSQL, conn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();

        sqlDA.Fill(ds);

        DataTable dt = new DataTable();

        dt.Columns.Add("LOCATION", typeof(string));

        DataRow dr;

        intTotalRecords = ds.Tables[0].Rows.Count;

        foreach (DataRow drRows in ds.Tables[0].Rows)
        {
            dr = dt.NewRow();

            dr["LOCATION"] = drRows["LOCATION"].ToString();


            dt.Rows.Add(dr);
        }

        rptBranch.DataSource = dt;
        rptBranch.DataBind();
    }
}
