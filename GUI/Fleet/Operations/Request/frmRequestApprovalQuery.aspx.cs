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

public partial class Request_frmRequestApprovalQuery : System.Web.UI.Page
{
    //SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);

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

            FillCity();
            FillVehType();

            

        }

    }

    protected void FillCity()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        DataSet myds = new DataSet();
        SqlDataAdapter myda = new SqlDataAdapter("select city_code ,Location from vwCityList order By Location", conn);
        myda.Fill(myds, "vwCityList");

        cboOrgnCity.DataTextField = "Location";
        cboOrgnCity.DataValueField = "city_code";
        cboOrgnCity.DataSource = myds.Tables["vwCityList"];
        cboOrgnCity.DataBind();
        cboOrgnCity.Items.Insert(0, "");
        

        conn.Close();

    }
    protected void FillVehType()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        DataSet myds = new DataSet();
        SqlDataAdapter myda = new SqlDataAdapter("select Distinct Type_Code,Type_Name from webx_Vehicle_Type where ActiveFlag='Y' and Fleet_Type='0' order by Type_Name", conn);
        myda.Fill(myds, "webx_Vehicle_Type");

        cboVehType.DataTextField = "Type_Name";
        cboVehType.DataValueField = "Type_Code";
        cboVehType.DataSource = myds.Tables["webx_Vehicle_Type"];
        cboVehType.DataBind();
        cboVehType.Items.Insert(0, "");

        conn.Close();

    }


   

    protected void radDate_OnSelectedIndexChange(object sender, EventArgs e)
    {
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

        string strval = "";
        strval = "FromDt=" + txtDateFrom.Text.Trim() + "&ToDt=" + txtDateTo.Text.Trim()  + "&RequestId=" + txtRequestID.Text.Trim() + "&RequestBy=" + txtRequestBy.Text.Trim() + "&StartDt=" + "&OrgnCity=" + cboOrgnCity.SelectedItem.Value + "&OrgnLoc=" + "&VehType=" + cboVehType.SelectedItem.Value;
        Response.Redirect ("frmRequestApprovalList.aspx?"+ strval);
        //Server.Transfer("frmRequestApprovalList.aspx");
    }
}
