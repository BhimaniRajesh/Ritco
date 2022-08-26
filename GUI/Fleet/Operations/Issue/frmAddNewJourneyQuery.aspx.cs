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

public partial class Issue_frmAddNewJourneyQuery : System.Web.UI.Page
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
        }

    }

    protected void CheckValid(object sender, EventArgs e)
    {
        txtDateFrom.Text = "";
        txtDateTo.Text = "";
        radDate.Items[0].Selected = true;
        radDate.Items[1].Selected = false;
        radDate.Items[2].Selected = false;
        radDate.Items[3].Selected = false;
    }

    protected void radDate_OnSelectedIndexChange(object sender, EventArgs e)
    {


        txtVIssueID.Text = "";
        txtDateFrom.ReadOnly = false;
        txtDateTo.ReadOnly = false;

        System.DateTime righnow = System.DateTime.Today;
        string strrightnow = righnow.ToString("dd/MM/yyyy");

        RadioButtonList rbl = new RadioButtonList();
        rbl = (RadioButtonList)sender;
        if (!(rbl.Items[0].Selected))
        {
            txtDateFrom.Text = strrightnow;
            txtDateTo.Text = strrightnow;
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
        }
        if (rbl.Items[1].Selected)
        {
            righnow = righnow.AddDays(-7);
            strrightnow = righnow.ToString("dd/MM/yyyy");
            txtDateFrom.Text = strrightnow;
        }

        if (rbl.Items[3].Selected)
        {
            //righnow = righnow.AddMonths(-12);
            strrightnow = "01/01/1950";
            txtDateFrom.Text = strrightnow;
        }
    }

    protected void btnShowMultipleRequest_Click(object sender, EventArgs e)
    {

        BindGrid();
    }


    public void RetrieveGridData()
    {


        string VSlipId = "";

        if (txtVIssueID.Text != "")
        {
            VSlipId = txtVIssueID.Text;
        }

        conn.Open();
        string sql = "usp_VehicleIssueList";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

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

        da.SelectCommand.Parameters.Add("@VSlipId", SqlDbType.VarChar).Value = VSlipId.ToString();
        da.SelectCommand.Parameters.Add("@VSlipFromDt", SqlDbType.DateTime).Value = dtFrom;
        da.SelectCommand.Parameters.Add("@VSlipToDt", SqlDbType.DateTime).Value = dtTo;

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
}
