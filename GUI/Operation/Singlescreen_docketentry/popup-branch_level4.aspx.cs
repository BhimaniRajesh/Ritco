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

public partial class GUI_Operation_Singlescreen_docketentry_popup_branch_level4 : System.Web.UI.Page
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
            window.opener.update1111(lococde);        
			window.close();  
			}  
	       </script>;";
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
        strSQL = "Select loccode,locname from WEBX_Location where activeflag='Y' order by locname";

        SqlCommand sqlCommand = new SqlCommand(strSQL, conn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();

        sqlDA.Fill(ds);

        DataTable dt = new DataTable();

        dt.Columns.Add("LocCode", typeof(string));
        dt.Columns.Add("LocName", typeof(string));

        DataRow dr;

        intTotalRecords = ds.Tables[0].Rows.Count;

        foreach (DataRow drRows in ds.Tables[0].Rows)
        {
            dr = dt.NewRow();

            dr["LocCode"] = drRows["loccode"].ToString();
            dr["LocName"] = drRows["locname"].ToString();

            dt.Rows.Add(dr);
        }

        rptBranch.DataSource = dt;
        rptBranch.DataBind();
    }
    
}
