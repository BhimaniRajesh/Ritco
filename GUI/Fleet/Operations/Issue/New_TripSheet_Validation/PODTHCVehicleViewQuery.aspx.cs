using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using WebX.Common;

public partial class GUI_Fleet_Operations_Issue_PODTHCVehicleViewQuery : System.Web.UI.Page
{
    public string brcd, empcd, selyear, dkt_Call;
    protected void Page_Load(object sender, EventArgs e)
    {
        brcd = Session["brcd"].ToString();
        empcd = Session["empcd"].ToString();
        if (!IsPostBack)
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            string q1 = "Select loccode,locname from webx_location where loc_level='1' and activeflag='y'";
            SqlCommand sqlcmd1 = new SqlCommand(q1, conn);
            SqlDataReader drBr;
            drBr = sqlcmd1.ExecuteReader();
            drBr.Read();
            string loccd = drBr["loccode"].ToString();
            drBr.Close();
            String SQL_LOC, sqlall1;
            if (brcd == loccd)
            {
                SQL_LOC = "SELECT 'All' AS loccode, 'All' AS locname UNION select loccode,loccode+' : '+locname from webx_location where activeFlag='Y'  order by locName";
                sqlall1 = "SELECT 'All' AS loccode, 'All' AS locname UNION select acccode ,acccode + ' : ' + accdesc from webx_acctinfo where activeFlag='Y' and ( acccategory='CASH' OR acccategory='BANK')  order  by accdesc";
            }
            else
            {
                SQL_LOC = "SELECT 'All' AS loccode, 'All' AS locname UNION select loccode,loccode+' : '+locname from webx_location where activeFlag='Y' and loccode='" + brcd + "' order by locName";
                sqlall1 = "SELECT 'All' AS loccode, 'All' AS locname UNION select acccode ,acccode + ' : ' + accdesc from webx_acctinfo where activeFlag='Y' and ( acccategory='CASH' OR ((bkloccode like '%" + brcd + "%' or bkloccode='ALL' ) AND acccategory='BANK'))  order  by accdesc";
            }
            SqlCommand sqlcmd2 = new SqlCommand(SQL_LOC, conn);
            SqlDataReader dr1;
            dr1 = sqlcmd2.ExecuteReader();
            while (dr1.Read())
            {

                ddlro.Items.Add(new ListItem(dr1.GetValue(1).ToString(), dr1.GetValue(0).ToString()));
            }
            dr1.Close();
            ddlro.SelectedValue = loccd;
            conn.Close();

            bindGrid();
        }
    }

    public void bindGrid()
    {
        DataTable dt = new DataTable();
        using (WebXHelper helper = new WebXHelper())
        {
            dt = helper.ExecuteDataTable("USP_Active_VehicleList");
        }
        ddlVehicleNo.DataValueField = "VEHNO";
        ddlVehicleNo.DataValueField = "VEHNO";
        ddlVehicleNo.DataSource = dt;
        ddlVehicleNo.DataBind();
        ddlVehicleNo.Items.Insert(0, new ListItem("All", ""));
    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        string fromdt = DT.FromDate, todt = DT.ToDate;
        string final;
        final = "?fromdt=" + fromdt;
        final += "&todt=" + todt;
        final += "&thctype=" + ddlSelection.SelectedValue;
        final += "&vehicleno=" + ddlVehicleNo.SelectedValue;
        final += "&branch=" + ddlro.SelectedValue;
        final += "&status=" + ddlStatus.SelectedValue;
        Response.Redirect("PODTHCVehicleViewResult.aspx" + final);
    }
}