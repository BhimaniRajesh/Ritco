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

public partial class GUI_Fleet_Operations_Issue_New_TripSheet_Validation_StandardExpense_FixedRouteNew : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
    static DataTable dt = new DataTable("table1");
    DataRow drow;
    static string VendorCity;
    static string GlobalGetVendorCode;
    string UserSlipNo;
    string WithoutLastUserSlipNo;
    int counter = 1; string CityCommaTrim, CityCommaTrimTemp;

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

            fn.Fill_Location_Dataset();
            txtRow_TextChanged(txtRow, null);
            //txtVehNo.Attributes.Add("onblur", "javascript:return CheckVhNo();");
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

    protected void txtRow_TextChanged(object sender, EventArgs e)
    {
        dt_WorkGroup.Clear();
        if ((txtRow.Text == "") || (txtRow.Text == "0")) txtRow.Text = "1";
        for (int i = 0; i < Convert.ToInt32(txtRow.Text); i++)
        {
            dt_WorkGroup.AddWebx_Fleet_SM_Task_DetRow("", "", "", "", "", "", "", "", "", "");
        }
        BindGrid();
    }
    public void BindGrid()
    {
        dgWorkgroup.DataSource = dt_WorkGroup;// _dataSet.WorkGroup;
        dgWorkgroup.DataBind();
        //_lastEditedPage = dgWorkgroup.CurrentPageIndex;

        if (dgWorkgroup.Rows.Count != 0)
        {
            btnFinalSubmit.Visible = true;

        }
        else
        {
            btnFinalSubmit.Visible = false;
        }
    }
    //protected void btnSubmit_Click(object sender, EventArgs e)
    //{
    //    tblGrid.Visible = true;
    //}



    protected void dgWorkgroup_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            //TextBox txtVehNo = (TextBox)e.Row.FindControl("txtVehNo");
            //TextBox txtVehList = (TextBox)e.Row.FindControl("txtVehList");
            //txtVehNo.Attributes.Add("Onblur", "javascript:CommaSepratedVehicle(this)");
        }
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
                umsg.Show("Invalid Vehicle !! Can not Enter Vehicle No Multiple times !!!");
                //umsg.Show("Invalid Vehicle " + string.Join(",", duplicateVehicle) + " !! Can not Enter Vehicle No Multiple times !!!");
                return;
            }

            trans = conn.BeginTransaction();
            try
            {
                foreach (GridViewRow gridrow in dgWorkgroup.Rows)
                {

                    int TotalCount = dgWorkgroup.Rows.Count;
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
                    // TextBox txtCashRate = (TextBox)gridrow.FindControl("txtCashRate");
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
                    TextBox txtToll = (TextBox)gridrow.FindControl("txtToll");
                    TextBox txtFuel = (TextBox)gridrow.FindControl("txtFuel");
                    Label lblSubTotal = (Label)gridrow.FindControl("lblSubTotal");
                    Label lblGrandTotal = (Label)gridrow.FindControl("lblGrandTotal");
                    HiddenField hdnSubTotal = (HiddenField)gridrow.FindControl("hdnSubTotal");
                    HiddenField hdnGrandTotal = (HiddenField)gridrow.FindControl("hdnGrandTotal");


                    string str = "Usp_StandardExpenseFixedRoute_Insert";

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


                    cmd.Parameters.Add("@RouteNo", SqlDbType.VarChar).Value = "";
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
                    cmd.Parameters.Add("@VehicleList", SqlDbType.VarChar).Value = txtCstLoc.Text;
                    cmd.Parameters.Add("@EntryBy", SqlDbType.VarChar).Value = EntryBy;
                    cmd.Parameters.Add("@EntryDate", SqlDbType.VarChar).Value = EntryDate;

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
                Response.Redirect("StandardExpense_FixedRouteAll.aspx");
            }
        }
    }
    protected void BtnCustCode_Click(object sender, EventArgs e)
    {
        //foreach (GridViewRow dgWorkgroup1 in dgWorkgroup.Rows)
        //{
        //    TextBox txtCstLoc = dgWorkgroup1.FindControl("txtCstLoc") as TextBox;
        //    Button BtnCustCode = dgWorkgroup1.FindControl("BtnCustCode") as Button;
        //    //BtnCustCode.Attributes.Add("OnClick", "window.open('popupLoc.aspx?ctlid=" + txtCstLoc.ClientID + "',null,'left=300, top=250, height=300, width=700, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
        //   // BtnCustCode.Attributes.Add("OnClick", "window.open('popupLoc.aspx?txtCstLoc=" + txtCstLoc.ClientID + "&BtnCustCode=" + BtnCustCode.ClientID + "',null,'left=300, top=250, height=300, width=700, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");

        //}

    }
}


//txtToll         
//txtBorder       
//txtCheckPost    
//txtRto          
//txtLoading      
//txtUnLoading    
//txtIncentive    
//txtDriverDA     
//txtTelephone    
//txtEnrouteRepair
//txtPenalty      
//txtHeight       
//txtBrokarage    
//txtGuide        
//txtBehtiExp     
//txtGreenTax     
//txtPExp         
//txtMislExp      
//txtOtherExp     
//txtMExp         
//txtCashRate     
//txtCashLtr      
//txtCashTotal    
//txtGCashRate    
//txtGCashLtr     
//txtCstLoc       

//Toll          numeric(18,2),
//Border        numeric(18,2),
//CheckPost     numeric(18,2),
//Rto           numeric(18,2),
//Loading       numeric(18,2),
//UnLoading     numeric(18,2),
//Incentive     numeric(18,2),
//DriverDA      numeric(18,2),
//Telephone     numeric(18,2),
//EnrouteRepair numeric(18,2),
//Penalty       numeric(18,2),
//Height        numeric(18,2),
//Brokarage     numeric(18,2),
//Guide         numeric(18,2),
//BehtiExp      numeric(18,2),
//GreenTax      numeric(18,2),
//PExp          numeric(18,2),
//MislExp       numeric(18,2),
//OtherExp      numeric(18,2),
//MExp          numeric(18,2),
//CashRate      numeric(18,2),
//CashLtr       numeric(18,2),
//CashTotal     numeric(18,2),
//GCashRate     numeric(18,2),
//GCashLtr      numeric(18,2),
//CstLoc        numeric(18,2)

//@RouteNo         , varchar(50),
//@RouteName       , varchar(50),
//@NumberofOptions , numeric(18,2),
//@EntryBy         ,varchar(50),         
//@EntryDate       ,datetime ,
//@UpdatedBy       ,   varchar(50),         
//@UpdatedDate      datetime 


//@RouteNo		 ,
//@RouteName	 ,
//@OptionNo	    ,
//@Toll         ,
//@Border       ,
//@CheckPost    ,
//@Rto          ,
//@Loading      ,
//@UnLoading    ,
//@Incentive    ,
//@DriverDA     ,
//@Telephone    ,
//@EnrouteRepair,
//@Penalty      ,
//@Height       ,
//@Brokarage    ,
//@Guide        ,
//@BehtiExp     ,
//@GreenTax     ,
//@PExp         ,
//@MislExp      ,
//@OtherExp     ,
//@MExp         ,
//@CashRate     ,
//@CashLtr      ,
//@CashTotal    ,
//@GCashRate    ,
//@GCashLtr     ,
//@VehicleList  ,       
//@EntryBy	    ,
//@EntryDate 