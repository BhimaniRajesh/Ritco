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
using System.Text;
using System.IO;

public partial class GUI_Fleet_Reports_TripsheetQueryNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;

        //Session["Stat"] = null;
        //Session["EndLoc"] = null;
        //Session["StLoc"] = null;
        //Session["SDate"] = null;
        //Session["EndDate"] = null;

        //Session["TotKms"] = null;

        //Session["TripNo"] = null;

        //Session["VehCat"] = null;

        //Session["Vehno"] = null;

        //Session["DName"] = null;
        //Session["Cat"] = null;
        //Session["TAll"] = null;

        //Session["Claim"] = null;
        //Session["Inc"] = null;
        //Session["Spare"] = null;
        //Session["Fuel"] = null;
        //Session["Enroute"] = null;
        //Session["Repair"] = null;
        //Session["Adv"] = null;
        //Session["EAll"] = null;


        //Session["dtFrom"] = null;

        //Session["dtTo"] = null;
         Session["Status"] = null;

        
        if (!IsPostBack)
        {
               popRO();
               FillDDLDate();
            //Do Work
        }
        Session["mBranch"] = null;
        Session["mBranch"] = ddlro.SelectedItem.Value.Trim();
    
    }

    public void popRO()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        string brcd = Session["brcd"].ToString();

        string q1 = "Select loccode,locname from webx_location where loc_level='1'";

        SqlCommand sqlcmd1 = new SqlCommand(q1, conn);
        SqlDataReader dr;
        dr = sqlcmd1.ExecuteReader();


        dr.Read();
       
        string loccd = dr["loccode"].ToString();
        dr.Close();

        String SQL_LOC,sqlall1;
      

        if (brcd == loccd)
        {
            ddlro.Items.Add(new ListItem("-- Select -- ", ""));
            ddlro.Items.Add(new ListItem("ALL", "ALL"));
            SQL_LOC = "select loccode,locname+' : '+loccode from webx_location where activeFlag='Y' order by locName";
     
        }
        else
        {
            //ddlro.Items.Add(new ListItem("ALL", "ALL"));
            SQL_LOC = "select loccode,locname+' : '+loccode from webx_location where activeFlag='Y' and loccode='" + brcd + "' order by locName";
      
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

      
       
        
    }

      
    
    //protected void radDate_OnSelectedIndexChange(object sender, EventArgs e)
    //{
    //    txtDateFrom.ReadOnly = false;
    //    txtDateTo.ReadOnly = false;

    //    System.DateTime righnow = System.DateTime.Today;
    //    string strrightnow = righnow.ToString("dd/MM/yyyy");

    //    RadioButtonList rbl = new RadioButtonList();
    //    rbl = (RadioButtonList)sender;
    //    if (!(rbl.Items[0].Selected))
    //    {
    //        txtDateFrom.Text = strrightnow;
    //        txtDateTo.Text = strrightnow;
    //        txtDateFrom.ReadOnly = true;
    //        txtDateTo.ReadOnly = true;
    //    }
    //    if (rbl.Items[1].Selected)
    //    {
    //        righnow = righnow.AddDays(-7);
    //        strrightnow = righnow.ToString("dd/MM/yyyy");
    //        txtDateFrom.Text = strrightnow;
    //    }

    //    if (rbl.Items[3].Selected)
    //    {
    //        //righnow = righnow.AddMonths(-12);
    //        strrightnow = "01/01/1950";
    //        txtDateFrom.Text = strrightnow;
    //    }
    //}

    




    //protected void btnShow_Click(object sender, EventArgs e)
    //{
    //    TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
    //    TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");

    //    Response.Redirect("Result.aspx?CreatedFrom=" + txtDateFrom.Text + "&CreatedTo=" + txtDateTo.Text + "&Status=" + ddlStatus.SelectedItem.Text.ToString() + "&Branch=" + ddlro.SelectedItem.Text.ToString() + "&DateGNorCL=" + ddlDate.SelectedItem.Text.ToString());
       
        //BindGrid();
    //}


    
    //public void BindGrid()
    //{
    //    Session["dtFrom"] = txtDateFrom.Text.Trim();
    //    Session["dtTo"] = txtDateTo.Text.Trim();

    //    Session["Status"] = ddlStatus.Text.Trim();
    //    Session["branch"] = ddlro.SelectedValue.Trim();
   

    //    //Session["VehicleNo"] = txtVehNo.Text.Trim();
    //    //Session["Driver"] = txtDriver1.Text.Trim();
    //    //Session["Manual"] = txtManual.Text.Trim();
    //    //Session["Tripsheetno"] = txtTripsheetNo.Text.Trim();

    //    Session["DateGNorCL"] = ddlDate.SelectedItem.Text.ToString();
    //    Response.Redirect("Result.aspx");
    //}


    public void RetrieveDriverDataInfo1(object sender, EventArgs e)
    {
  
        if (txtDriver1.Text.Trim() != "")
        {
            string DataFound = "N";

            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            string mDriverId1 = "";
            lblD1Error.Text = "";
            conn.Open();
            string sqlD1 = "Select Driver_Id from WEBX_FLEET_DRIVERMST where Manual_Driver_Code='" + txtDriver1.Text.Trim() + "'";
            SqlCommand cmdD1 = new SqlCommand(sqlD1, conn);
            cmdD1.CommandType = CommandType.Text;

            SqlDataReader drD1 = cmdD1.ExecuteReader();
            while (drD1.Read())
            {
                DataFound = "Y";
                mDriverId1 = Convert.ToString(drD1["Driver_ID"]);
            }
            drD1.Close();
            
            if (DataFound == "N")
            {
                lblD1Error.Visible = true;
                lblD1Error.Text = "Driver1 Code Is InValid!";
            }
            else
            {
                lblD1Error.Visible = false;
                lblD1Error.Text = "";
            }
        }

    }

    public void FillDDLDate()
    {
       ddlDate.Items.Clear();
       ddlDate.Items.Add("Generation");
        ddlDate.Items.Add("Closure");
    }

    protected void ddlro_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["mBranch"] = null;
        Session["mBranch"] = ddlro.SelectedItem.Value.Trim();
    }
}
