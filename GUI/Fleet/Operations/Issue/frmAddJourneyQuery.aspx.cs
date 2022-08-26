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

public partial class Issue_frmAddJourneyQuery : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);

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

            conn.Open();
            DropDownList cboPickup = new DropDownList();
            cboPickup = (DropDownList)cboOrgnLoc;
            DataSet myds = new DataSet();
            SqlDataAdapter myda = new SqlDataAdapter("select p.pickup_loccode,upper(p.pickup_locname) pickup_locname from vwPickupList p where 1=1 order By pickup_locname", conn);
            myda.Fill(myds, "vwPickupList");


            cboPickup.DataTextField = "pickup_locname";
            cboPickup.DataValueField = "pickup_loccode";
            cboPickup.DataSource = myds.Tables["vwPickupList"];
            cboPickup.DataBind();
            cboPickup.Items.Insert(0, "");
            conn.Close();

        }
    }


    protected void FillCity()
    {
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


    protected void FillPickupLoc(object sender, EventArgs e)
    {
        DropDownList cboCity = (DropDownList)sender;
        DropDownList cboPickup = new DropDownList();

        if (cboCity.ID == "cboOrgnCity")
        {
            cboPickup = (DropDownList)cboOrgnLoc;
        }

        conn.Open();

        string mcity = "";
        mcity = cboCity.SelectedItem.Value;// cboOrgnCity.SelectedItem.Value;
        if (mcity == "")
        {
            mcity = "0";
        }

        string sql = "";
        if (mcity == "0")
        {
            sql = "select p.pickup_loccode,upper(p.pickup_locname) pickup_locname from vwPickupList p where 1=1 order By pickup_locname";
        }
        else
        {
            sql = "select p.pickup_loccode,upper(p.pickup_locname) pickup_locname from vwPickupList p where city_code=" + mcity + " order By pickup_locname";
        }

        DataSet myds = new DataSet();

        SqlDataAdapter myda = new SqlDataAdapter(sql, conn);
        myda.Fill(myds, "vwPickupList");


        cboPickup.DataTextField = "pickup_locname";
        cboPickup.DataValueField = "pickup_loccode";
        cboPickup.DataSource = myds.Tables["vwPickupList"];
        cboPickup.DataBind();
        cboPickup.Items.Insert(0, "");

    }


    protected void btnShowMultipleRequest_Click(object sender, EventArgs e)
    {
        string strval = "";

        string DtTime = cboStDt_HH.SelectedItem.Value + ":" + cboStDt_MM.SelectedItem.Value + ":00" + " " + cboStDt_AMPM.SelectedItem.Value;

        strval = "StartDt=" + DtCal.CalenderText() + " " + DtTime + "&OrgnCity=" + cboOrgnCity.SelectedItem.Value + "&OrgnLoc=" + cboOrgnLoc.SelectedItem.Value + "&VehType=" + cboVehType.SelectedItem.Value + "&Pass_No=" + txtPassNo.Text.Trim();
        Response.Redirect("frmAddJourneyVehicleIssueSlip.aspx?" + strval);

    }
}
