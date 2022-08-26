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
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Fleet_Operations_Issue_New_TripSheet_Validation_StandardExpense_FixedRouteSelectEdit : System.Web.UI.Page
{
    bool success = false;
    MyFunctions fn = new MyFunctions();
    string LoginBranch;

    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);
        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        LoginBranch = Session["brcd"].ToString().Trim();

        if (!IsPostBack)
        {
            fn.Fill_StandardExp_FixedRoute();
            fn.Fill_StandardExp_Fixed_VehicleNo();

            //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            //conn.Open(); 
            //string brcd = Session["brcd"].ToString(); 
            //string q1 = "Select loccode,locname from webx_location where loc_level='1' and activeflag='y'";
            //SqlCommand sqlcmd1 = new SqlCommand(q1, conn);
            //SqlDataReader drBr;
            //drBr = sqlcmd1.ExecuteReader();
            //drBr.Read();
            //string loccd = drBr["loccode"].ToString();
            //drBr.Close();
            //String SQL_LOC, sqlall1;

            //if (brcd == loccd)
            //{
            //    SQL_LOC = "SELECT 'All' AS loccode, 'All' AS locname UNION select loccode,locname+' : '+loccode from webx_location where activeFlag='Y'  order by locName";
            //    sqlall1 = "SELECT 'All' AS loccode, 'All' AS locname UNION select acccode ,acccode + ' : ' + accdesc from webx_acctinfo where activeFlag='Y' and ( acccategory='CASH' OR acccategory='BANK')  order  by accdesc";

            //}
            //else
            //{
            //    SQL_LOC = "SELECT 'All' AS loccode, 'All' AS locname UNION select loccode,locname+' : '+loccode from webx_location where activeFlag='Y' and loccode='" + brcd + "' order by locName";
            //    sqlall1 = "SELECT 'All' AS loccode, 'All' AS locname UNION select acccode ,acccode + ' : ' + accdesc from webx_acctinfo where activeFlag='Y' and ( acccategory='CASH' OR ((bkloccode like '%" + brcd + "%' or bkloccode='ALL' ) AND acccategory='BANK'))  order  by accdesc";
            //}
            //SqlCommand sqlcmd2 = new SqlCommand(SQL_LOC, conn);
            //SqlDataReader dr1;
            //dr1 = sqlcmd2.ExecuteReader();
            //while (dr1.Read())
            //{

            //    ddlro.Items.Add(new ListItem(dr1.GetValue(1).ToString(), dr1.GetValue(0).ToString())); 
            //}
            //dr1.Close();
            //ddlro.SelectedValue = loccd;
            //conn.Close();

            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            string brcd = Session["brcd"].ToString();
            string q1 = "Select loccode,locname from webx_location where loc_level='1' and activeflag='y'";
            SqlCommand sqlcmd1 = new SqlCommand(q1, conn);
            SqlDataReader drBr;
            drBr = sqlcmd1.ExecuteReader();
            drBr.Read();
            string loccd = drBr["loccode"].ToString();
            drBr.Close();
            String SQL_LOC;

            if (brcd == loccd)
            {
                SQL_LOC = "Select 'All' AS RouteName UNION select RouteName from StandardExpense_FixedRoute_HDR";
                //sqlall1 = "SELECT 'All' AS loccode, 'All' AS locname UNION select acccode ,acccode + ' : ' + accdesc from webx_acctinfo where activeFlag='Y' and ( acccategory='CASH' OR acccategory='BANK')  order  by accdesc";

            }
            else
            {
                SQL_LOC = "Select 'All' AS RouteNo UNION select RouteName from StandardExpense_FixedRoute_HDR";
                //sqlall1 = "SELECT 'All' AS loccode, 'All' AS locname UNION select acccode ,acccode + ' : ' + accdesc from webx_acctinfo where activeFlag='Y' and ( acccategory='CASH' OR ((bkloccode like '%" + brcd + "%' or bkloccode='ALL' ) AND acccategory='BANK'))  order  by accdesc";
            }
            SqlCommand sqlcmd2 = new SqlCommand(SQL_LOC, conn);
            SqlDataReader dr1;
            dr1 = sqlcmd2.ExecuteReader();
            while (dr1.Read())
            {

                ddlRouteName.Items.Add(new ListItem(dr1.GetValue(0).ToString()));
            }
            dr1.Close();
            ddlRouteName.SelectedValue = loccd;
            conn.Close();
        }
    }

    protected void ShowParamVice(object sender, EventArgs e)
    {
        //{
        //    tblDCR.Visible = true;
        //    SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //    con.Open();
        //    SqlCommand cmd = new SqlCommand("usp_ClosedTripsheetView_GetParamVice", con);
        //    cmd.CommandType = CommandType.StoredProcedure;
        //    cmd.Parameters.AddWithValue("@TripsheetNo", txtSelection.Text);
        //    SqlDataReader dr = cmd.ExecuteReader();
        //    dgGeneral.DataSource = dr;
        //    dgGeneral.DataBind();

        //if (dgGeneral.Rows.Count == 0)
        //{
        //    btnSubmitBills.Visible = false;
        //}
        //else
        //{ 
        //    btnSubmitBills.Visible = true; 
        //}
        //con.Close();
    }

    protected void ShowDateVice(object sender, EventArgs e)
    {
        // tblDCR.Visible = true;
        //// string[] strDtFrom = txtDateFrom.Text.Split('/');
        // //DateTime d1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        //// string[] strDtTo = txtDateTo.Text.Split('/');
        // DateTime d2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));
        // var StartTime = TimeSpan.Parse("00:00:00");
        // var EndTime = TimeSpan.Parse("23:59:59");
        // var StartDate = d1 + StartTime;
        // var EndDate = d2 + EndTime;


        // SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        // con.Open();
        // SqlCommand cmd = new SqlCommand("usp_CloseTripsheetView_GetDateVice", con);
        // cmd.CommandType = CommandType.StoredProcedure;
        // cmd.Parameters.AddWithValue("@FromDate", StartDate);
        // cmd.Parameters.AddWithValue("@ToDate", EndDate);
        // cmd.Parameters.AddWithValue("@BranchCode", LoginBranch);
        // SqlDataReader dr = cmd.ExecuteReader();
        // dgGeneral.DataSource = dr;
        // dgGeneral.DataBind();

        //if (dgGeneral.Rows.Count == 0)
        //{
        //    btnSubmitBills.Visible = false;
        //}
        //else
        //{ 
        //    btnSubmitBills.Visible = true; 
        //}
        // con.Close();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        Response.Redirect("StandardExpense_FixedRouteEdit.aspx?RouteNo=" + txtRouteNo.Text + "&RouteName=" + ddlRouteName.SelectedValue + "&VehicleNo=" + txtVehicleNo.Text);
    }
}




