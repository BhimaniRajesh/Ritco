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
using Microsoft.ApplicationBlocks.Data;
using ApplicationManager;
using System.Linq;
using System.Text;

public partial class GUI_Fleet_Operations_Issue_New_TripSheet_Validation_StandardExpense_FixedRouteEdit : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
    static DataTable dt = new DataTable("table1");
    DataRow drow;
    static string VendorCity;
    static string GlobalGetVendorCode;
    string UserSlipNo;
    string WithoutLastUserSlipNo;
    int counter = 1; string CityCommaTrim, CityCommaTrimTemp;

    string QSRouteNo, QSRouteName, QSVehicleNo;

    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    Int32 nullvalue = 0;
    int _lastEditedPage;
    bool success = false;
    MyFleetDataSet.Webx_Fleet_SM_Task_DetRow datarow_Wgrp;
    MyFleetDataSet.Webx_Fleet_SM_Task_DetDataTable dt_WorkGroup = new MyFleetDataSet.Webx_Fleet_SM_Task_DetDataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        umsg.Hide();
        if (!IsPostBack)
        {
            QSRouteNo = Request.QueryString["RouteNo"].ToString();
            QSRouteName = Request.QueryString["RouteName"].ToString();
            QSVehicleNo = Request.QueryString["VehicleNo"].ToString();

            GetAllData();
            fn.Fill_Location_Dataset();
            txtRouteType1.Attributes.Add("Onblur", "javascript:TrimCity(this);");
            txtRouteType2.Attributes.Add("Onblur", "javascript:TrimCity(this);");
            txtRouteType3.Attributes.Add("Onblur", "javascript:TrimCity(this);");
            txtRouteType4.Attributes.Add("Onblur", "javascript:TrimCity(this);");
            txtRouteType5.Attributes.Add("Onblur", "javascript:TrimCity(this);");
            txtRouteType6.Attributes.Add("Onblur", "javascript:TrimCity(this);");
            txtRouteType7.Attributes.Add("Onblur", "javascript:TrimCity(this);");
            txtRouteType8.Attributes.Add("Onblur", "javascript:TrimCity(this);");
            txtRouteType9.Attributes.Add("Onblur", "javascript:TrimCity(this);");
            txtRouteType10.Attributes.Add("Onblur", "javascript:TrimCity(this);");

            foreach (GridViewRow gridrow in dgWorkgroup.Rows)
            {
                TextBox txtCstLoc = (TextBox)gridrow.FindControl("txtCstLoc");

            }
        }
    }


    public void GetBindgridData()
    {
        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //conn.Open(); 
        //string sql = "select NumberofOptions from StandardExpense_FixedRoute_HDR WHERE RouteNo='" + QSRouteNo + "'";
        //SqlCommand cmd1 = new SqlCommand(sql, conn);
        //SqlDataReader dr1 = cmd1.ExecuteReader();
        //if (dr1.Read())
        //{
        //    txtRow.Text = dr1["NumberofOptions"].ToString();
        //}
        //dr1.Close();
        //conn.Close();


    }

    public void GetAllData()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlCommand cmd1 = new SqlCommand("usp_StandardExpenseFixedRoute_GetDetails", conn);
        cmd1.CommandType = CommandType.StoredProcedure;
        cmd1.Parameters.AddWithValue("@RouteNo", Request.QueryString["RouteNo"].ToString());
        cmd1.Parameters.AddWithValue("@RouteName", Request.QueryString["RouteName"].ToString());
        SqlDataReader dr1 = cmd1.ExecuteReader();
        if (dr1.Read())
        {
            txtRouteNo.Text = dr1["RouteNo"].ToString();
            txtCityTrim.Text = dr1["RouteName"].ToString();
            txtRow.Text = dr1["NumberofOptions"].ToString();
        }
        dr1.Close();
        conn.Close();

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        SqlCommand cmd2 = new SqlCommand("usp_StandardExpenseFixedRoute_View", con);
        cmd2.CommandType = CommandType.StoredProcedure;
        cmd2.Parameters.AddWithValue("@RouteNo", Request.QueryString["RouteNo"].ToString());
        cmd2.Parameters.AddWithValue("@RouteName", Request.QueryString["RouteName"].ToString());
        cmd2.Parameters.AddWithValue("@VehicleNo", Request.QueryString["VehicleNo"].ToString());
        SqlDataReader dr2 = cmd2.ExecuteReader();
        dgWorkgroup.DataSource = dr2;
        dgWorkgroup.DataBind();
        dr2.Close();
        con.Close();


        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        SqlCommand cmd7 = new SqlCommand("usp_StandardExpenseFixedRoute_ViewRoutes", cn);
        cmd7.CommandType = CommandType.StoredProcedure;
        cmd7.Parameters.AddWithValue("@RouteNo", Request.QueryString["RouteNo"].ToString());
        cmd7.Parameters.AddWithValue("@RouteName", Request.QueryString["RouteName"].ToString());
        SqlDataReader dr7 = cmd7.ExecuteReader();
        if (dr7.Read())
        {
            txtRouteType1.Text = dr7["RouteType1"].ToString();
            txtRouteType2.Text = dr7["RouteType2"].ToString();
            txtRouteType3.Text = dr7["RouteType3"].ToString();
            txtRouteType4.Text = dr7["RouteType4"].ToString();
            txtRouteType5.Text = dr7["RouteType5"].ToString();
            txtRouteType6.Text = dr7["RouteType6"].ToString();
            txtRouteType7.Text = dr7["RouteType7"].ToString();
            txtRouteType8.Text = dr7["RouteType8"].ToString();
            txtRouteType9.Text = dr7["RouteType9"].ToString();
            txtRouteType10.Text = dr7["RouteType10"].ToString();
        }
        dr7.Close();
        cn.Close();
    }

    protected void txtRow_TextChanged(object sender, EventArgs e)
    {
        if ((txtRow.Text == "") || (txtRow.Text == "0")) txtRow.Text = "1";
        for (int i = 0; i < Convert.ToInt32(txtRow.Text); i++)
        {
            dt_WorkGroup.AddWebx_Fleet_SM_Task_DetRow("", "", "", "", "", "", "", "", "", "");
        }

        GetAllData();
        BindGrid();
    }
    public void BindGrid()
    {
        dgWorkgroup.DataSource = dt_WorkGroup;
        dgWorkgroup.DataBind();
    }


    private string SpliceNoteText(string text, int maxWidth)
    {
        StringBuilder sb = new StringBuilder(text);

        for (int i = 0; i < (sb.Length / maxWidth); i++)
        {
            int insertPosition = i * maxWidth;
            sb.Insert(insertPosition, Environment.NewLine);
        }

        return sb.ToString();
    }


    protected void btnFinalSubmit_Click(object sender, EventArgs e)
    {
        if (success == false)
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            SqlTransaction trans;
            string[] VehicleListArray = null;
            string VehicleList = "";
            foreach (GridViewRow gridrow in dgWorkgroup.Rows)
            {
                TextBox txtVehicle = (TextBox)gridrow.FindControl("txtCstLoc");
                if (VehicleList != "")
                { VehicleList = VehicleList + "," + txtVehicle.Text; }
                else
                { VehicleList = txtVehicle.Text; }

            }

            VehicleListArray = VehicleList.Split(',');
            VehicleListArray = VehicleListArray.Where(x => !string.IsNullOrEmpty(x)).ToArray();

            if (VehicleListArray.Count() != VehicleListArray.Distinct().Count())
            {
                string[] duplicateVehicle = VehicleListArray.Distinct().ToArray();
                //string validationMsg = SpliceNoteText(string.Join(",", duplicateVehicle), 25);
                umsg.Show("Can not Enter Vehicle No Multiple times !!!");
                //umsg.Show("Invalid Vehicle " + string.Join(",", duplicateVehicle) + " !! Can not Enter Vehicle No Multiple times !!!");
                return;
            }

            trans = conn.BeginTransaction();
            try
            {
                foreach (GridViewRow gridrow in dgWorkgroup.Rows)
                {

                    int TotalCount = dgWorkgroup.Rows.Count;
                    TextBox txtToll = (TextBox)gridrow.FindControl("txtToll");
                    TextBox txtBorder = (TextBox)gridrow.FindControl("txtBorder");
                    TextBox txtCheckPost = (TextBox)gridrow.FindControl("txtCheckPost");
                    TextBox txtRto = (TextBox)gridrow.FindControl("txtRto");
                    TextBox txtLoading = (TextBox)gridrow.FindControl("txtLoading");
                    TextBox txtUnLoading = (TextBox)gridrow.FindControl("txtUnLoading");
                    TextBox txtIncentive = (TextBox)gridrow.FindControl("txtIncentive");
                    TextBox txtDriverDA = (TextBox)gridrow.FindControl("txtDriverDA");
                    TextBox txtTelephone = (TextBox)gridrow.FindControl("txtTelephone");
                    TextBox txtEnrouteRepair = (TextBox)gridrow.FindControl("txtEnrouteRepair");
                    TextBox txtPenalty = (TextBox)gridrow.FindControl("txtPenalty");
                    TextBox txtHeight = (TextBox)gridrow.FindControl("txtHeight");
                    TextBox txtBrokarage = (TextBox)gridrow.FindControl("txtBrokarage");
                    TextBox txtGuide = (TextBox)gridrow.FindControl("txtGuide");
                    TextBox txtBehtiExp = (TextBox)gridrow.FindControl("txtBehtiExp");
                    TextBox txtGreenTax = (TextBox)gridrow.FindControl("txtGreenTax");
                    TextBox txtPExp = (TextBox)gridrow.FindControl("txtPExp");
                    TextBox txtMislExp = (TextBox)gridrow.FindControl("txtMislExp");
                    TextBox txtOtherExp = (TextBox)gridrow.FindControl("txtOtherExp");
                    TextBox txtMExp = (TextBox)gridrow.FindControl("txtMExp");
                    //TextBox txtCashRate = (TextBox)gridrow.FindControl("txtCashRate");
                    //TextBox txtCashLtr = (TextBox)gridrow.FindControl("txtCashLtr");
                    //TextBox txtCashTotal = (TextBox)gridrow.FindControl("txtCashTotal");
                    //TextBox txtGCashRate = (TextBox)gridrow.FindControl("txtGCashRate");
                    //TextBox txtGCashLtr = (TextBox)gridrow.FindControl("txtGCashLtr");
                    TextBox txtCstLoc = (TextBox)gridrow.FindControl("txtCstLoc");

                    TextBox txtTyrePuncture = (TextBox)gridrow.FindControl("txtTyrePuncture");
                    TextBox txtServicing = (TextBox)gridrow.FindControl("txtServicing");
                    TextBox txtParking = (TextBox)gridrow.FindControl("txtParking");
                    TextBox txtMechanical = (TextBox)gridrow.FindControl("txtMechanical");
                    TextBox txtGreecing = (TextBox)gridrow.FindControl("txtGreecing");
                    TextBox txtAirCheck = (TextBox)gridrow.FindControl("txtAirCheck");
                    TextBox txtDandaTax = (TextBox)gridrow.FindControl("txtDandaTax");
                    TextBox txtKaanta = (TextBox)gridrow.FindControl("txtKaanta");
                    TextBox txtFuel = (TextBox)gridrow.FindControl("txtFuel");
                    Label lblSubTotal = (Label)gridrow.FindControl("lblSubTotal");
                    Label lblGrandTotal = (Label)gridrow.FindControl("lblGrandTotal");
                    HiddenField hdnSubTotal = (HiddenField)gridrow.FindControl("hdnSubTotal");
                    HiddenField hdnGrandTotal = (HiddenField)gridrow.FindControl("hdnGrandTotal");
                    HiddenField hdnSrNo = (HiddenField)gridrow.FindControl("hdnSrNo");


                    string str = "Usp_StandardExpenseFixedRoute_Update";

                    SqlCommand cmd = new SqlCommand(str, conn, trans);
                    string EntryBy = Session["empcd"].ToString();
                    string UpdateBy = Session["empcd"].ToString();

                    string EntryDate = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");
                    cmd.CommandType = CommandType.StoredProcedure;
                    string VehTemp = txtCstLoc.Text;
                    string VehTemp2;

                    //VehTemp = VehTemp.Remove(VehTemp.IndexOf(","), 1);
                    if (VehTemp.LastIndexOf(",") >= 1)
                    {
                        VehTemp2 = VehTemp.Remove(VehTemp.LastIndexOf(","), 1);
                    }
                    //string VehTemp2;
                    //VehTemp = VehTemp.Remove(VehTemp.IndexOf(","), 1);
                    //VehTemp2 = VehTemp.Remove(VehTemp.LastIndexOf(","), 1);

                    cmd.Parameters.Add("@SrNo", SqlDbType.Int).Value = hdnSrNo.Value;
                    cmd.Parameters.Add("@RouteNo", SqlDbType.VarChar).Value = txtRouteNo.Text;
                    cmd.Parameters.Add("@RouteName", SqlDbType.VarChar).Value = txtCityTrim.Text;
                    cmd.Parameters.Add("@OptionNo", SqlDbType.VarChar).Value = counter.ToString();
                    cmd.Parameters.Add("@NumberofOptions", SqlDbType.VarChar).Value = TotalCount.ToString();
                    cmd.Parameters.Add("@BranchCode", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode;
                    cmd.Parameters.Add("@FinYear", SqlDbType.VarChar).Value = SessionUtilities.FinYear;
                    cmd.Parameters.Add("@RouteType1", SqlDbType.VarChar).Value = txtRouteType1.Text;
                    cmd.Parameters.Add("@RouteType2", SqlDbType.VarChar).Value = txtRouteType2.Text;
                    cmd.Parameters.Add("@RouteType3", SqlDbType.VarChar).Value = txtRouteType3.Text;
                    cmd.Parameters.Add("@RouteType4", SqlDbType.VarChar).Value = txtRouteType4.Text;
                    cmd.Parameters.Add("@RouteType5", SqlDbType.VarChar).Value = txtRouteType5.Text;
                    cmd.Parameters.Add("@RouteType6", SqlDbType.VarChar).Value = txtRouteType6.Text;
                    cmd.Parameters.Add("@RouteType7", SqlDbType.VarChar).Value = txtRouteType7.Text;
                    cmd.Parameters.Add("@RouteType8", SqlDbType.VarChar).Value = txtRouteType8.Text;
                    cmd.Parameters.Add("@RouteType9", SqlDbType.VarChar).Value = txtRouteType9.Text;
                    cmd.Parameters.Add("@RouteType10", SqlDbType.VarChar).Value = txtRouteType10.Text;

                    cmd.Parameters.Add("@Toll", SqlDbType.VarChar).Value = txtToll.Text;
                    cmd.Parameters.Add("@Border", SqlDbType.VarChar).Value = txtBorder.Text;
                    cmd.Parameters.Add("@CheckPost", SqlDbType.VarChar).Value = txtCheckPost.Text;
                    cmd.Parameters.Add("@Rto", SqlDbType.VarChar).Value = txtRto.Text;
                    cmd.Parameters.Add("@Loading", SqlDbType.VarChar).Value = txtLoading.Text;
                    cmd.Parameters.Add("@UnLoading", SqlDbType.VarChar).Value = txtUnLoading.Text;
                    cmd.Parameters.Add("@Incentive", SqlDbType.VarChar).Value = txtIncentive.Text;
                    cmd.Parameters.Add("@DriverDA ", SqlDbType.VarChar).Value = txtDriverDA.Text;
                    cmd.Parameters.Add("@Telephone", SqlDbType.VarChar).Value = txtTelephone.Text;
                    cmd.Parameters.Add("@EnrouteRepair ", SqlDbType.VarChar).Value = txtEnrouteRepair.Text;
                    cmd.Parameters.Add("@Penalty", SqlDbType.VarChar).Value = txtPenalty.Text;
                    cmd.Parameters.Add("@Height", SqlDbType.VarChar).Value = txtHeight.Text;
                    cmd.Parameters.Add("@Brokarage", SqlDbType.VarChar).Value = txtBrokarage.Text;
                    cmd.Parameters.Add("@Guide", SqlDbType.VarChar).Value = txtGuide.Text;
                    cmd.Parameters.Add("@BehtiExp", SqlDbType.VarChar).Value = txtBehtiExp.Text;
                    cmd.Parameters.Add("@GreenTax", SqlDbType.VarChar).Value = txtGreenTax.Text;
                    cmd.Parameters.Add("@PExp", SqlDbType.VarChar).Value = txtPExp.Text;
                    cmd.Parameters.Add("@MislExp", SqlDbType.VarChar).Value = txtMislExp.Text;
                    cmd.Parameters.Add("@OtherExp", SqlDbType.VarChar).Value = txtOtherExp.Text;
                    cmd.Parameters.Add("@MExp", SqlDbType.VarChar).Value = txtMExp.Text;
                    //cmd.Parameters.Add("@CashRate", SqlDbType.VarChar).Value = txtCashRate.Text;
                    //cmd.Parameters.Add("@CashLtr", SqlDbType.VarChar).Value = txtCashLtr.Text;
                    //cmd.Parameters.Add("@CashTotal", SqlDbType.VarChar).Value = txtCashTotal.Text;
                    //cmd.Parameters.Add("@GCashRate", SqlDbType.VarChar).Value = txtGCashRate.Text;
                    //cmd.Parameters.Add("@GCashLtr", SqlDbType.VarChar).Value = txtGCashLtr.Text;
                    //cmd.Parameters.Add("@VehicleList", SqlDbType.VarChar).Value = VehTemp2;
                    cmd.Parameters.Add("@VehicleList", SqlDbType.VarChar).Value = VehTemp;

                    cmd.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = EntryBy;
                    cmd.Parameters.Add("@EntryDate     ", SqlDbType.VarChar).Value = EntryDate;

                    cmd.Parameters.Add("@TyrePuncture", SqlDbType.VarChar).Value = txtTyrePuncture.Text;
                    cmd.Parameters.Add("@Servicing", SqlDbType.VarChar).Value = txtServicing.Text;
                    cmd.Parameters.Add("@Parking", SqlDbType.VarChar).Value = txtParking.Text;
                    cmd.Parameters.Add("@Mechanical", SqlDbType.VarChar).Value = txtMechanical.Text;
                    cmd.Parameters.Add("@Greecing", SqlDbType.VarChar).Value = txtGreecing.Text;
                    cmd.Parameters.Add("@AirCheck", SqlDbType.VarChar).Value = txtAirCheck.Text;
                    cmd.Parameters.Add("@DandaTax", SqlDbType.VarChar).Value = txtDandaTax.Text;
                    cmd.Parameters.Add("@Kaanta", SqlDbType.VarChar).Value = txtKaanta.Text;
                    cmd.Parameters.Add("@Fuel", SqlDbType.VarChar).Value = txtFuel.Text;
                    cmd.Parameters.Add("@SubTotal", SqlDbType.VarChar).Value = hdnSubTotal.Value;
                    cmd.Parameters.Add("@GrandTotal", SqlDbType.VarChar).Value = hdnGrandTotal.Value;

                    counter++;
                    cmd.ExecuteNonQuery();
                }
                trans.Commit();
                success = true;

            }

            catch (Exception e1)
            {
                Response.Write("Error" + e1.Message);
                trans.Rollback();
                Response.End();
            }
            finally
            {
                conn.Close();
            }
            if (success)
            {
                Response.Redirect("~/GUI/Fleet/Operations/Issue/New_TripSheet_Validation/StandardExpense_FixedRouteAll.aspx");
            }
        }
    }
}
