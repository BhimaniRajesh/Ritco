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
using System.Collections.Generic;
using Microsoft.Reporting.WebForms;

public partial class Vehicle_Tracking_Report_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack && !IsCallback)
        {
             
        }
    }
  
    protected void tb_Vehicle_No_TextChanged(object sender, EventArgs e)
    {
        if (tb_Vehicle_No.Text != "")
        {
            string strVehNo = tb_Vehicle_No.Text; //"KA01A1100";
            string strConnStr = Convert.ToString(Session["SqlProvider"]);
            //string strConnStr = "Data Source=115.113.239.51;Initial Catalog=AgilityERP;UID=sa;pwd=Tr@nsp0rt";

            DataSet ds = new DataSet();
            ds = GetVehicleInfo(strConnStr, strVehNo);

            lblVehNo.Text = ds.Tables[0].Rows[0]["VEHNO"].ToString();
            lblVehicleNo.Text = ds.Tables[0].Rows[0]["VEHNO"].ToString();

            if (ds.Tables[0].Rows[0]["Vehicle_Status"].ToString() == "In Transit")
            {
                lblVehicleStatus.Text = ds.Tables[0].Rows[0]["Vehicle_Status"].ToString() + " Tripsheet Number : " + ds.Tables[0].Rows[0]["VSlipNo"].ToString();
            }
            else
            {
                lblVehicleStatus.Text = ds.Tables[0].Rows[0]["Vehicle_Status"].ToString();
            }

            lblTotalKM.Text = ds.Tables[0].Rows[0]["Current_KM_Read"].ToString();
            lblTotalFuel.Text = ds.Tables[0].Rows[0]["DieselFillLtrs"].ToString();
            lblKMPL.Text = ds.Tables[0].Rows[0]["KMPL"].ToString();
            //lblVehTotalExp.Text = ds.Tables[0].Rows[0]["Vehicle_Status"].ToString();
            //lblVehCost.Text = ds.Tables[0].Rows[0]["Vehicle_Status"].ToString();
            lblTotalTrip.Text = ds.Tables[0].Rows[0]["Total_Trip"].ToString();
            //lblAvgVehKMTrip.Text =  ds.Tables[0].Rows[0]["Vehicle_Status"].ToString();
            //lblAvgTripCompletionDay.Text = ds.Tables[0].Rows[0]["Vehicle_Status"].ToString();
            lblControllingBranch.Text = ds.Tables[0].Rows[0]["Conrtl_branch"].ToString();
            lblVehicleType.Text = ds.Tables[0].Rows[0]["TYPE_NAME"].ToString();
            lblMadyBy.Text = ds.Tables[0].Rows[0]["UpdtBy"].ToString();
            lblGPSEnabaled.Text = ds.Tables[0].Rows[0]["GPS_Device_Enabled"].ToString();
            lblEngineNo.Text = ds.Tables[0].Rows[0]["VEHENGINENO"].ToString();
            lblChasisNo.Text = ds.Tables[0].Rows[0]["VEHCHASISNO"].ToString();
            lblDtComm.Text = ds.Tables[0].Rows[0]["VEHREGDT"].ToString();
            lblLength.Text = ds.Tables[0].Rows[0]["length"].ToString();
            lblHeight.Text = ds.Tables[0].Rows[0]["Height"].ToString();
            lblWidth.Text = ds.Tables[0].Rows[0]["width"].ToString();

            lblGVW.Text = ds.Tables[0].Rows[0]["GVW"].ToString();
            lblUnladen.Text = ds.Tables[0].Rows[0]["Unld_Wt"].ToString();
            lblCapacity.Text = ds.Tables[0].Rows[0]["Capacity"].ToString();


            /////////////////////////////////////////////////////////////////////////////////////////////////
            //BindGrid(strConnStr, "SELECT *FROM vw_Document_Register WHERE vehno='" + strVehNo + "'", gvDocument);
            BindGrid(strConnStr, "SELECT *FROM vw_Document_Register WHERE vehno='" + strVehNo + "'", gvDocument);
            BindGrid(strConnStr, "SELECT Convert(VarChar,Vslipdt,106) as Vslipdt,*FROM vw_VT_tripsheet_new WHERE VehicleNo='" + strVehNo + "'", gvTripsheet);
            BindGrid(strConnStr, "SELECT VSlipNo,CONVERT(VARCHAR,BILLDT,106) AS BILLFROMDT,* FROM VW_VEH_FUEL_FILL_HISTORY WHERE VEHNO ='" + strVehNo + "' ORDER BY BILLDT,VEHNO", gvFuelFillHistory);
            BindGrid(strConnStr, "SELECT *FROM vw_tyre_register WHERE VEHNO = '" + strVehNo + "'", gvTyreDetails);
            BindGrid(strConnStr, "SELECT *FROM VW_ODOMETER_HISTORY WHERE VEHNO = '" + strVehNo + "'", gvOdometerHistory);

            //BindGrid("Data Source=115.113.239.51;Initial Catalog=AgilityERP;UID=sa;pwd=Tr@nsp0rt", "SELECT *FROM vw_Document_Register WHERE vehno='MH04DS5186'", gvDocument);
            //BindGrid("Data Source=115.113.239.51;Initial Catalog=AgilityERP;UID=sa;pwd=Tr@nsp0rt", "SELECT Convert(VarChar,Vslipdt,106) as Vslipdt,*FROM vw_tripsheet_new WHERE VehicleNo='MH04DS5186'", gvTripsheet);
            //BindGrid("Data Source=115.113.239.51;Initial Catalog=AgilityERP;UID=sa;pwd=Tr@nsp0rt", "SELECT VSlipNo,CONVERT(VARCHAR,BILLDT,106) AS BILLFROMDT,* FROM VW_VEH_FUEL_FILL_HISTORY WHERE VEHNO ='MH04CP9914' ORDER BY BILLDT,VEHNO", gvFuelFillHistory);
            //BindGrid("Data Source=115.113.239.51;Initial Catalog=AgilityERP;UID=sa;pwd=Tr@nsp0rt", "SELECT *FROM vw_tyre_register WHERE VEHNO = 'MH04CP9914'", gvTyreDetails);
            //BindGrid("Data Source=115.113.239.51;Initial Catalog=AgilityERP;UID=sa;pwd=Tr@nsp0rt", "SELECT *FROM VW_ODOMETER_HISTORY WHERE VEHNO = 'MH04CP9914'", gvOdometerHistory);
            /////////////////////////////////////////////////////////////////////////////////////////////////
        }
    }
    public DataSet GetVehicleInfo(string strConnStr, string strVehNo)
    {
        SqlDataAdapter adp = new SqlDataAdapter("Select * From VW_Vehicle_Tracking Where Vehno='" + strVehNo + "'", strConnStr);
        DataSet ds = new DataSet();
        adp.Fill(ds);
        return ds;
    }
    public void BindGrid(string strConnStr, string strSQL, GridView gv)
    {
        SqlDataAdapter adp = new SqlDataAdapter(strSQL, strConnStr);
        DataSet ds = new DataSet();
        adp.Fill(ds);
        gv.DataSource = ds;
        gv.DataBind();
    }
}
