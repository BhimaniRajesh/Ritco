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

public partial class admin_TireSearch : System.Web.UI.Page
{
   
   
    protected void Page_Load(object sender, EventArgs e)
    {
        btnShow.Attributes.Add("onclick", "javascript:return OnSubmit()");
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Common objCommon = new Common();
        objCommon.doCacheRoutine();
        this.Title = pagetitle;
        if (!IsPostBack)
        {
            RadioButtonList radDate = (RadioButtonList)this.DT.FindControl("radDate");
            radDate.Items[3].Selected = true;
            TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
            txtDateFrom.Text = "01/01/1950";
          
            //SqlDataSource1.ConnectionString = Session["SqlProvider"].ToString().Trim();
            //SqlDataSource2.ConnectionString = Session["SqlProvider"].ToString().Trim();
            //img_CalendarF.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtDateFrom.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtDateFrom.ClientID + @"\')')");
            //img_CalendarT.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtDateTo.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtDateTo.ClientID + @"\')')");
            //txtRTO.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnRTO.ClientID.ToString() + "').focus();");
            //txtVehNo.Attributes.Add("OnFocus", "javascript:document.getElementById('" + lnkbtnSelect.ClientID.ToString() + "').focus();");
            BindDropDown("USP_Driver_STATUS", "Driver_Status", "Driver_Status", ddlStatus); 
        }
    }
   
    protected void btnShow_Click(object sender, EventArgs e)
    {
        TextBox txtDateFrom = (TextBox)this.DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)this.DT.FindControl("txtDateTo");
        TextBox txtVehicle = (TextBox)this.popUpVehicle.FindControl("tb_TextBox");
        TextBox txtRTO = (TextBox)this.popUpRTO.FindControl("tb_TextBox");

        cls_Report_DriverRegister.strLIC_EXP_DT_From = txtDateFrom.Text.ToString().Trim();
        cls_Report_DriverRegister.strLIC_EXP_DT_To = txtDateTo.Text.ToString().Trim();
        cls_Report_DriverRegister.strRTO = txtRTO.Text.ToString().Trim();
        cls_Report_DriverRegister.strVEH_NO = txtVehicle.Text.ToString().Trim();
        cls_Report_DriverRegister.strDRIVER_NAME = txtDriver1.Text.ToString().Trim();
        cls_Report_DriverRegister.strddlStatus = ddlStatus.SelectedValue.ToString();

       // Response.Redirect("DriverRegisterResult.aspx");

    }
    public void BindDropDown(string strProc, string text, string value, DropDownList d)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = strProc;
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;

        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                d.Items.Add(new ListItem(Convert.ToString(dr[text]), Convert.ToString(dr[value])));
            }
        }
        dr.Close();
        conn.Close();
    }
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

}
