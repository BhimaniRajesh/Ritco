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

public partial class GUI_Fleet_Operations_Issue_New_TripSheet_Validation_CFDriverFuelBalance : System.Web.UI.Page
{
    public byte byteRadButtonSelection;
    MyDataSet ds = new MyDataSet();
    DataSet ds1 = new DataSet();
    public static string LoginBrLevel = "";
    string srno = "";
    string WithoutLastUserSlipNo;
    string Old_UserSlipNo, UPCurr_UserSlipNo, Curr_UserSlipNo, All_UserSlipNo;
    int UserSlip_Counter = 0;
    string FillingDate, VendorName, VehicleNo, TripsheetNo, TripsheetOpen_Dt, VendorCity, Product, UserSlipNo, UserSlip_Dt;
    string Quantity, Rate, Amount;
    string Prod;
    bool success = false;
    string SelectedFlag = "";

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
            txtDateFrom.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtDateTo.Text = System.DateTime.Today.ToString("dd/MM/yyyy");

            btnSubmitBills.Visible = false;
            btnSubmitBills1.Visible = false;
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            string brcd = Session["brcd"].ToString();
            string sql_level = "select isnull(loc_level,1) from webx_location with(NOLOCK) where activeFlag='Y' and loccode='" + brcd + "' ";
            SqlCommand cmd_level = new SqlCommand(sql_level, conn);
            SqlDataReader dr_level = cmd_level.ExecuteReader();

            while (dr_level.Read())
            {
                //   lv = dr_level[0].ToString();
            }
            dr_level.Close();
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
                SQL_LOC = "SELECT 'All' AS loccode, 'All' AS locname UNION select loccode,locname+' : '+loccode from webx_location where activeFlag='Y'  order by locName";
                sqlall1 = "SELECT 'All' AS loccode, 'All' AS locname UNION select acccode ,acccode + ' : ' + accdesc from webx_acctinfo where activeFlag='Y' and ( acccategory='CASH' OR acccategory='BANK')  order  by accdesc";

            }
            else
            {
                SQL_LOC = "SELECT 'All' AS loccode, 'All' AS locname UNION select loccode,locname+' : '+loccode from webx_location where activeFlag='Y' and loccode='" + brcd + "' order by locName";
                sqlall1 = "SELECT 'All' AS loccode, 'All' AS locname UNION select acccode ,acccode + ' : ' + accdesc from webx_acctinfo where activeFlag='Y' and ( acccategory='CASH' OR ((bkloccode like '%" + brcd + "%' or bkloccode='ALL' ) AND acccategory='BANK'))  order  by accdesc";
            }
            SqlCommand sqlcmd2 = new SqlCommand(SQL_LOC, conn);
            SqlDataReader dr1;
            dr1 = sqlcmd2.ExecuteReader();
            while (dr1.Read())
            {

                ddlro.Items.Add(new ListItem(dr1.GetValue(1).ToString(), dr1.GetValue(0).ToString()));
                //ddlro.SelectedValue = Session["HeadOfficeCode"].ToString();
            }
            dr1.Close();
            ddlro.SelectedValue = loccd;
            conn.Close();
        }
    }
    protected void radDate_SelectedIndexChanged(object sender, EventArgs e)
    {
        RadioButtonList rbl = new RadioButtonList();
        rbl = (RadioButtonList)sender;

        byteRadButtonSelection = Convert.ToByte(rbl.SelectedItem.Value);

        if (rbl.Items[0].Selected)
        {
            txtDateFrom.ReadOnly = false;
            txtDateTo.ReadOnly = false;
        }
        else
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
        }

        if (rbl.Items[1].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Today.AddDays(-7).ToString("dd/MM/yyyy");
            txtDateTo.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
        }
        else if (rbl.Items[2].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;
        }
        else if (rbl.Items[3].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Today.AddYears(-50).ToString("dd/MM/yyyy");
            txtDateTo.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
        }

    }
    public void daterange(object source, ServerValidateEventArgs value)
    {
        if (txtDateFrom.Text == "")
        {
            value.IsValid = false;
            return;
        }
        if (txtDateTo.Text == "")
        {
            value.IsValid = false;
            return;
        }
        string[] strDtFrom = txtDateFrom.Text.Split('/');
        DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        string[] strDtTo = txtDateTo.Text.Split('/');
        DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));
        System.TimeSpan diffResult = dt2.Subtract(dt1);

        if (dt1 > dt2)
        {
            CustomValidator1.ErrorMessage = "From Date can not be Less then To date";
            value.IsValid = false;
            return;

        }
    }

    //protected void ShowParamVice(object sender, EventArgs e)
    //{
    //    tblDCR.Visible = true;
    //    SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    con.Open();
    //    SqlCommand cmd = new SqlCommand("usp_PendingDriverBalwithoutVehicle_GetParamVice", con);
    //    cmd.CommandType = CommandType.StoredProcedure;
    //    cmd.Parameters.AddWithValue("@Flag", ddlSelection.SelectedValue);
    //    //cmd.Parameters.AddWithValue("@TripsheetOrVehicle", txtSelection.Text);
    //    SqlDataReader dr = cmd.ExecuteReader();
    //    dgGeneral.DataSource = dr;
    //    dgGeneral.DataBind();

    //    if (dgGeneral.Rows.Count == 0)
    //    {
    //        btnSubmitBills.Visible = false;
    //    }
    //    else
    //    {  
    //        btnSubmitBills.Visible = true; 
    //    }
    //    con.Close();
    //}

    protected void ShowDateVice(object sender, EventArgs e)
    {
        tblDCR.Visible = true;
        string[] strDtFrom = txtDateFrom.Text.Split('/');
        DateTime d1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        string[] strDtTo = txtDateTo.Text.Split('/');
        DateTime d2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));
        var StartTime = TimeSpan.Parse("00:00:00");
        var EndTime = TimeSpan.Parse("23:59:59");
        var StartDate = d1 + StartTime;
        var EndDate = d2 + EndTime;

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        //SqlCommand cmd = new SqlCommand("usp_PendingDriverBalwithoutVehicle_GetDateVice", con);
        SqlCommand cmd = new SqlCommand("usp_PendingDriverBalwithoutVehicle_GetDateVice_FA", con);
        
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Type", ddlSelection.SelectedValue);
        cmd.Parameters.AddWithValue("@FromDate", StartDate);
        cmd.Parameters.AddWithValue("@ToDate", EndDate);
        cmd.Parameters.AddWithValue("@BranchCode", ddlro.SelectedValue);
        SqlDataReader dr = cmd.ExecuteReader();
        if (ddlSelection.SelectedValue == "F")
        {
            dgGeneral.DataSource = dr;
            dgGeneral.DataBind();
            if (dgGeneral.Rows.Count == 0)
            {
                btnSubmitBills.Visible = false;
            }
            else
            {
                btnSubmitBills1.Visible = false;
                trdgGeneral1.Visible = false;
                trCancel1.Visible = false;
                btnSubmitBills.Visible = true;
                trdgGeneral.Visible = true;
                trCancel.Visible = true;
                lblTitle.Text = "C/F Fuel";
                trTitle.Visible = true;
            }
        }
        else
        {
            dgGeneral1.DataSource = dr;
            dgGeneral1.DataBind();
            if (dgGeneral1.Rows.Count == 0)
            {
                btnSubmitBills1.Visible = false;
            }
            else
            {
                btnSubmitBills1.Visible = true;
                trdgGeneral1.Visible = true;
                trCancel1.Visible = true;
                btnSubmitBills.Visible = false;
                trdgGeneral.Visible = false;
                trCancel.Visible = false;
                lblTitle.Text = "C/F Driver Balance";
                trTitle.Visible = true;
            }
        }
        con.Close();
    }
}