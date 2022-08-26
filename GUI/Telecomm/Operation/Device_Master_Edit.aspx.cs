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

public partial class Operation_Device_Master_Edit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(IsPostBack))
        {
            BindGrid();
        }
    }
    private void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "select *,CDM_Person + ' : '+CDM_Person_Name as Name,RTRIM(LEFT(convert(varchar,cdm_start_dt,106), 6)) + ' ' + RIGHT(convert(varchar,cdm_start_dt,10),2) as StartDt,RTRIM(LEFT(convert(varchar,cdm_end_dt,106), 6)) + ' ' + RIGHT(convert(varchar,cdm_end_dt,10),2) as EndDt from Tel_Comm_Device_Master order by CDM_Code";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        DataView dv = new DataView();
        dv = ds.Tables[0].DefaultView;
        gvDevice_Master.DataSource = dv;
        gvDevice_Master.DataBind();
        conn.Close();
    }
}
