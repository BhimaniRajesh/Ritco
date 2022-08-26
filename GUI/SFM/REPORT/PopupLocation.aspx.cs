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

public partial class REPORT_PopupLocation : System.Web.UI.Page
{
    public static SqlConnection conn;
    string strSQL = "",Branch;

    public int intTotalRecords = 0;

    public static string strQSParam;
    public static string strMode = "";
    public static string strReport_Branch = "";
    public static string strRegion = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        Branch = Session["brcd"].ToString();
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string scr = @"<script>
         function Done(obj)
			{  		
            var lococde=obj.value;
            window.opener.update(lococde);        
			window.close();  
			}  
	       </script>;";
        Page.RegisterClientScriptBlock("update", scr);

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

        string brcd = Session["brcd"].ToString();
        string q1 = "Select Loc_level,locname from webx_location where loccode='" + brcd + "'";
        SqlCommand sqlcmd1 = new SqlCommand(q1, conn);
        SqlDataReader dr;
        dr = sqlcmd1.ExecuteReader();

        dr.Read();
        int loclvl = Convert.ToInt16(dr["Loc_level"]);
        string locnm = dr["locname"].ToString();
        dr.Close();
        if (loclvl == 1)
        {
            strSQL = "Select loccode,locname from WEBX_Location where activeflag='Y' order by locname";
        }
        else if (Session["mainbrcd"].ToString().Trim() != Session["brcd"].ToString().Trim())
        {
            strSQL = "Select loccode,locname from WEBX_Location where activeflag='Y' and loccode='" + Branch + "' order by locname";
        }
        else if (Session["mainbrcd"].ToString().Trim() == Session["brcd"].ToString().Trim())
        {
            strSQL = "Select loccode,locname from WEBX_Location where activeflag='Y' and loccode='" + Branch + "' order by locname ";
        }


        SqlCommand sqlCommand = new SqlCommand(strSQL, conn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();

        sqlDA.Fill(ds);

        DataTable dt = new DataTable();

        dt.Columns.Add("LocCode", typeof(string));
        dt.Columns.Add("LocName", typeof(string));

        DataRow dr1;

        intTotalRecords = ds.Tables[0].Rows.Count;

        foreach (DataRow drRows in ds.Tables[0].Rows)
        {
            dr1 = dt.NewRow();

            dr1["LocCode"] = drRows["loccode"].ToString();
            dr1["LocName"] = drRows["locname"].ToString();

            dt.Rows.Add(dr1);
        }

        rptBranch.DataSource = dt;
        rptBranch.DataBind();

    }
    
}
