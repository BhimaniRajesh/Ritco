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

public partial class GUI_admin_dcr_allot : System.Web.UI.Page
{
    public static string LoginBrLevel = "";
    public static string DCRSeries="";
    public static int Doc_Key = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        Doc_Key = Convert.ToInt32(Request.QueryString["DOCKey"].ToString().Trim());
        DCRSeries = Request.QueryString["DCRSeriesFrom"].ToString().Trim() + "-" + Request.QueryString["DCRSeriesTo"].ToString().Trim();
        
        //Get Login Br. Level
        getLoginBrLevel();
        if (!Page.IsPostBack)
        {
            PopulateAllotTo();
        }
        //Response.Write(LoginBrLevel + "--");
        if (LoginBrLevel == "1") { Step2.Visible = true; } 
    }

    private void getLoginBrLevel()
    {
        SqlConnection sqlCon = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlCon.Open();

        string sql = "Select Loc_Level From WebX_Location Where LocCode='" + Session["brcd"].ToString().Trim() + "'";
        SqlCommand sqlCmd = new SqlCommand(sql, sqlCon);
        sqlCmd.CommandType = CommandType.Text;

        SqlDataReader dr = sqlCmd.ExecuteReader();

        while (dr.Read())
        {
            LoginBrLevel = dr[0].ToString().Trim();
        }
    }

    protected void btnAllotSeries_Click(object sender, EventArgs e)
    {
        SqlConnection sqlCon = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlCon.Open();

        string sql = "usp_DCR_Allocate";
        SqlCommand sqlCmd = new SqlCommand(sql,sqlCon);
        sqlCmd.CommandType = CommandType.StoredProcedure;

        sqlCmd.Parameters.Add("@doc_key", SqlDbType.Int).Value = Doc_Key;
        sqlCmd.Parameters.Add("@alloted_by", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();
        sqlCmd.Parameters.Add("@alloted_to", SqlDbType.VarChar).Value = cboAllotTo.Text.Trim();
        sqlCmd.Parameters.Add("@empcd", SqlDbType.VarChar).Value = Session["empcd"].ToString().Trim();

        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);

        DataSet ds = new DataSet();
        da.Fill(ds);
        da.Dispose();

        //Close Connection
        sqlCon.Close();
        sqlCon = null;
        //--------------------------------

        ds.DataSetName = "ds_AllotSeries";
        ds.Tables[0].TableName = "tbl_AllotSeries";

        DataTable dt = new DataTable();
        DataRow dr;

        dt.Columns.Add("Type", typeof(string));
        dt.Columns.Add("Series", typeof(string));
        dt.Columns.Add("AllotedTo", typeof(string));
        dt.Columns.Add("IsSucessful", typeof(string));

        foreach (DataRow drRows in ds.Tables[0].Rows)
        {
            dr = dt.NewRow();
            dr["Type"] = drRows["Type"].ToString().Trim();
            dr["Series"] = drRows["Series"].ToString().Trim();
            dr["AllotedTo"] = drRows["AllotedTo"].ToString().Trim();
            dr["IsSucessful"] = drRows["IsSucessful"].ToString().Trim(); 

            dt.Rows.Add(dr);
        }
        
        rptSeriesAllotResult.DataSource = dt;
        rptSeriesAllotResult.DataBind();


        tblAllotTo.Visible = false;
        AllotResult.Visible = true;
        rptSeriesAllotResult.Visible = true;
    }


    private void PopulateAllotTo()
    {
        //Make & Open SQL Connection
        SqlConnection sqlCon = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        sqlCon.Open();

        string sql = "usp_AllotToList";
        SqlCommand sqlCmd = new SqlCommand(sql, sqlCon);
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Parameters.Add("@brcd", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();

        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);

        DataSet ds = new DataSet();
        da.Fill(ds);
        da.Dispose();

        //Close Connection
        sqlCon.Close();
        sqlCon = null;
        //--------------------------------

        ds.DataSetName = "ds_AllotTo";
        ds.Tables[0].TableName = "tbl_AllotTo";

        cboAllotTo.DataSource = ds;
        cboAllotTo.DataTextField = "AllotToName";
        cboAllotTo.DataValueField = "AllotToCode";
        cboAllotTo.DataBind();
    }
}
