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

public partial class GUI_Fleet_Job_JobOrderCloseQuery : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    DataView dv;
    DataSet ds;
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
        if (!IsPostBack)
        {
            AddJobCardType();
        }
    }


    protected void CheckValid(object sender, EventArgs e)
    {
        //txtDateFrom.Text = "";
        //txtDateTo.Text = "";
        //radDate.Items[0].Selected = true;
        //radDate.Items[1].Selected = false;
        //radDate.Items[2].Selected = false;
        //radDate.Items[3].Selected = false;
    }
    protected void btnShowMultipleRequest_Click(object sender, EventArgs e)
    {

        BindGrid();
    }


    public void RetrieveGridData()
    {
        string VSlipId = "";
        string IssueStatus = "";

        if (txtVIssueID.Text != "")
        {
            VSlipId = txtVIssueID.Text;
        }
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "usp_JobOrderCloseList";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;
         
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");
        DateTime dtFrom = new DateTime();
        DateTime dtTo = new DateTime();

        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        {
            if (txtDateFrom.Text != "")
            {
                dtFrom = Convert.ToDateTime(txtDateFrom.Text, dtfi);
                dtTo = Convert.ToDateTime(txtDateTo.Text, dtfi);
            }
            else
            {
                System.DateTime righnow = System.DateTime.Today;
                string strrightnow = righnow.ToString("dd/MM/yyyy");
                dtFrom = Convert.ToDateTime("01/01/1900", dtfi);
                dtTo = Convert.ToDateTime(strrightnow, dtfi);

            }
        }
        IssueStatus = cboJobCardType.SelectedValue;

        da.SelectCommand.Parameters.Add("@JobOrderNo", SqlDbType.VarChar).Value = VSlipId.ToString();
        da.SelectCommand.Parameters.Add("@JobOrderFromDt", SqlDbType.DateTime).Value = dtFrom;
        da.SelectCommand.Parameters.Add("@JobOrderToDt", SqlDbType.DateTime).Value = dtTo;
        da.SelectCommand.Parameters.Add("@JobCardType", SqlDbType.VarChar).Value = IssueStatus.ToString();
        da.SelectCommand.Parameters.Add("@JS_BRCD", SqlDbType.VarChar).Value = Convert.ToString(Session["brcd"]);
        da.SelectCommand.Parameters.Add("@Company_Code", SqlDbType.VarChar).Value = SessionUtilities.DefaultCompanyCode.ToUpper().Trim(); 

        ds = new DataSet();
        da.Fill(ds);

        dv = ds.Tables[0].DefaultView;
        conn.Close();
    }
    public void BindGrid()
    {
        RetrieveGridData();
        DataGrid1.DataSource = dv;
        DataGrid1.DataBind();
    }
    public void AddJobCardType()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = "select CodeId,CodeDesc from webx_master_general where codetype= 'JOBCARDTYP' and StatusCode='Y' order by CodeDesc";
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
             cboJobCardType.Items.Add(new ListItem("All", ""));
            while (dr.Read())
            {
                cboJobCardType.Items.Add(new ListItem(Convert.ToString(dr["CodeDesc"]), Convert.ToString(dr["CodeId"])));
            }
        }
        dr.Close();
        conn.Close();
    }
}
