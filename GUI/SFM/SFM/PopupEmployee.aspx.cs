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

public partial class SFM_PopupEmployee : System.Web.UI.Page
{
    public static SqlConnection conn;

    String strSQL = "";
    string empLocation;
    public int intTotalRecords = 0;

    public static string strQSParam;
    public static string strMode = "";
    public static string strReport_Branch = "";
    public static string strRegion = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string scr = @"<script>
         function Done(obj)
			{  		
            var EMPCD=obj.value;
            window.opener.update(EMPCD);        
			window.close();  
			}  
	       </script>;";
        Page.RegisterClientScriptBlock("done", scr);
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
        conn.Open();
        strSQL = "Select USERID,NAME, * from WebX_Master_Users";//union select EMPNM,EMPCD from WEBX_EMPMST where currbrcd='" + empLocation + "'";

        SqlCommand sqlCommand = new SqlCommand(strSQL, conn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();

        sqlDA.Fill(ds);

        DataTable dt = new DataTable();

        dt.Columns.Add("USERID", typeof(string));
        dt.Columns.Add("NAME", typeof(string));

        DataRow dr;

        intTotalRecords = ds.Tables[0].Rows.Count;

        foreach (DataRow drRows in ds.Tables[0].Rows)
        {
            dr = dt.NewRow();

            dr["USERID"] = drRows["USERID"].ToString();
            dr["NAME"] = drRows["NAME"].ToString();

            dt.Rows.Add(dr);
        }

        rptBranch.DataSource = dt;
        rptBranch.DataBind();
    }
}
