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

using WebX.Entity;
using WebX.Controllers;

public partial class GUI_admin_VehicleTypeMaster_VehicleTypeMasterAdd : System.Web.UI.Page
{
    #region Variable[s]
    private string ErrorMsg = string.Empty;   
    #endregion

    #region Event[s]
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                bindVehicleTypeCategoryDDL();

                if (Request.QueryString["vehicleTypeCode"] != null)
                {
                    if (Request.QueryString["Flag"] == "Edit")
                    {                       
                        getData(Request.QueryString["vehicleTypeCode"].ToString());
                    }
                }               
            }
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        VehicleMasterController objVehicleMaster = new VehicleMasterController();
        VehicleMaster objectVehicleMaster = new VehicleMaster();

        try
        {
             Validation();

             if (string.IsNullOrEmpty(ErrorMsg))
             {
                 objectVehicleMaster.VehicleType = txtVehicleNm.Text.Trim();
                 objectVehicleMaster.VehicleMadeBy = txtVehicleManufacturerNm.Text != "" ? txtVehicleManufacturerNm.Text.Trim().Replace("'", "''") : "";
                 objectVehicleMaster.VehicleModel = txtModelNo.Text != "" ? txtModelNo.Text.Trim().Replace("'", "''") : "";
                 objectVehicleMaster.VehicleTypeDescription = txtTypeDescription.Text != "" ? txtTypeDescription.Text.Trim().Replace("'", "''") : "";
                 objectVehicleMaster.Capacity = txtGrosVehicleWeight.Text != "" ? Convert.ToDecimal(txtGrosVehicleWeight.Text.Replace("'", "''")) : Convert.ToDecimal("0");
                 objectVehicleMaster.Rate = txtRateKm.Text != "" ? Convert.ToDecimal(txtRateKm.Text.Replace("'", "''")) : Convert.ToDecimal("0");
                 objectVehicleMaster.FuelType = txtFuelType.Text != "" ? txtFuelType.Text.Replace("'", "''") : "";
                 objectVehicleMaster.ActiveFlag = (chkactiveflag.Checked == true ? "Y" : "N");
                 objectVehicleMaster.Vehicle_Type_Category = ddlTruckTrailer.SelectedValue.Trim();
                 objectVehicleMaster.TyreRotate_KM = txtStationKM.Text != "" ? Convert.ToDecimal(txtStationKM.Text.Replace("'", "''")) : Convert.ToDecimal("0");
                 
                 objectVehicleMaster.VehicleTypeGVW = txtGrosVehicleWeight.Text != "" ? Convert.ToDecimal(txtGrosVehicleWeight.Text.Replace("'", "''")) : Convert.ToDecimal("0");
   
                 try
                 {
                     objectVehicleMaster.UpdateBy = Session["empcd"] != null ? Session["empcd"].ToString().Trim() : ""; // txtUpdtby.Text != "" ? txtUpdtby.Text.Replace("'", "''") : "";
                 }
                 catch(Exception Ex)
                 {
                     Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Session Expired.&detail1=" + Ex.Message.Replace('\n', '_'), false);  
                 }
     
                 if (Request.QueryString["Flag"] != null)
                 {
                     if (Request.QueryString["Flag"] == "Edit")
                     {
                         objectVehicleMaster.UpdateOnDate = Convert.ToDateTime(System.DateTime.Now.ToString("MM/dd/yyyy")); // txtUpdton.Text != "" ? Convert.ToDateTime(Common.getDateInddMMMyyyFormat(txtUpdton.Text.Replace("'", "''"))) : Convert.ToDateTime(Common.getDateInddMMMyyyFormat(System.DateTime.Now.ToString("MM/dd/yyyy")));
                     }
                     else
                     {
                         objectVehicleMaster.UpdateOnDate = DateTime.MinValue.AddYears(1754);
                     }
                 }

                 objectVehicleMaster.UsedCapecity = txtUnladenWeight.Text != "" ? Convert.ToDecimal(txtUnladenWeight.Text.Replace("'", "''")) : Convert.ToDecimal("0");
                 objectVehicleMaster.UnladenWeight = txtUnladenWeight.Text != "" ? Convert.ToDecimal(txtUnladenWeight.Text.Replace("'", "''")) : Convert.ToDecimal("0");
                 objectVehicleMaster.Capacity = (Convert.ToDecimal(txtGrosVehicleWeight.Text.Replace("'", "''")) - Convert.ToDecimal(txtUnladenWeight.Text.Replace("'", "''")));
                 
                 // objectVehicleMaster.Payload = txtPayload.Text != "" ? Convert.ToDecimal(txtPayload.Text.Replace("'", "''")) : Convert.ToDecimal("0");
                 objectVehicleMaster.Length = txtLength.Text != "" ? Convert.ToDecimal(txtLength.Text.Replace("'", "''")) : Convert.ToDecimal("0");
                 objectVehicleMaster.Width = txtWidth.Text != "" ? Convert.ToDecimal(txtWidth.Text.Replace("'", "''")) : Convert.ToDecimal("0");
                 objectVehicleMaster.Height = txtHeight.Text != "" ? Convert.ToDecimal(txtHeight.Text.Replace("'", "''")) : Convert.ToDecimal("0");
                
               
                 if (Request.QueryString["Flag"] == "Edit")
                 {
                     if (!string.IsNullOrEmpty(lblVehicleCode.Text))
                     {
                         objectVehicleMaster.VehicleTypeCode = Convert.ToInt32(lblVehicleCode.Text);
                         objVehicleMaster.updateVehicleTypeMaster(objectVehicleMaster);
                         Response.Redirect("VehicleTypeMasterDone.aspx?Flag=Edit&vehicleTypeCode=" + lblVehicleCode.Text, false);
                     }
                     else
                     {
                         Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in update record.", false);
                         
                     }
                 }
                 else
                 {
                     int vehicleTypeCode = objVehicleMaster.insertVehicleTypeMaster(objectVehicleMaster);

                     if (vehicleTypeCode > 0)
                     {
                         Response.Redirect("VehicleTypeMasterDone.aspx?Flag=Add&vehicleTypeCode=" + vehicleTypeCode.ToString(), false);
                     }
                     else
                     {
                         Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error to inserting Record.", false);
                     }
                 }                          
             }
             else
             {
                 Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=" + ErrorMsg, false);
             }
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in record Insert/Update.&detail1=" + Exc.Message.Replace('\n', '_'));  
        }
    }
    #endregion

    #region Private Function[s]
    private void Validation()
    {
        try
        {
            ErrorMsg = string.Empty;

            if (string.IsNullOrEmpty(txtVehicleManufacturerNm.Text))
            {
                ErrorMsg = "Please enter Manufacturer Name.";
                return;
            }

            if (string.IsNullOrEmpty(txtVehicleNm.Text))
            {
                ErrorMsg = "Please enter Vehicle Name.";
                return;
            }
            else
            {
                if (Request.QueryString["Flag"] != null)
                {
                    if (Request.QueryString["Flag"] != "Edit")
                    {
                        DataTable dtVehicleTypeMaster = new DataTable();
                        VehicleMasterController objVehicleTypeMaster = new VehicleMasterController();

                        if (!string.IsNullOrEmpty(txtVehicleNm.Text.Trim()))
                        {
                            dtVehicleTypeMaster = objVehicleTypeMaster.getVehicleTypeByVehicleTypeName(txtVehicleNm.Text.Trim());

                            if (dtVehicleTypeMaster != null && dtVehicleTypeMaster.Rows.Count > 0)
                            {
                                ErrorMsg = "Vehicle Type Name is already Exist. Please Enter another Type Name.";
                                return;
                            }
                        }
                    }
                }
            }

            if (ddlTruckTrailer.SelectedValue != null && ddlTruckTrailer.SelectedValue == "0")
            {
                ErrorMsg = "Select Truck / Trailer.";
                return;
            }

            if (string.IsNullOrEmpty(txtModelNo.Text))
            {
                ErrorMsg = "Please enter Model Number.";
                return;
            }

            //if (string.IsNullOrEmpty(txtStationKM.Text))
            //{
            //    ErrorMsg = "Please enter Tyre rotation at Km.";
            //    return;
            //}

            //if (string.IsNullOrEmpty(txtTypeDescription.Text))
            //{
            //    ErrorMsg = "Please enter Type Description.";
            //    return;
            //}          
            
            if (string.IsNullOrEmpty(txtGrosVehicleWeight.Text))
            {
                ErrorMsg = "Please enter Gross Vehicle Weight.";
                return;
            }

            if (string.IsNullOrEmpty(txtUnladenWeight.Text))
            {
                ErrorMsg = "Please enter Unladen Weight.";
                return;
            }
     
            //if (string.IsNullOrEmpty(txtRateKm.Text))
            //{
            //    ErrorMsg = "Please enter Rate per KM.";
            //    return;
            //}

            if (string.IsNullOrEmpty(txtFuelType.Text))
            {
                ErrorMsg = "Please enter Fuel Type.";
                return;
            }

            if (string.IsNullOrEmpty(txtHeight.Text))
            {
                ErrorMsg = "Please enter Height.";
                return;
            }

            if (string.IsNullOrEmpty(txtLength.Text))
            {
                ErrorMsg = "Please enter Length.";
                return;
            }

            if (string.IsNullOrEmpty(txtWidth.Text))
            {
                ErrorMsg = "Please enter Width.";
                return;
            }  
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
    private void bindVehicleTypeCategoryDDL()
    {
        try
        {
            VehicleMasterController objVehicleMaster = new VehicleMasterController();
            DataTable dtVehicleList = new DataTable();

            ddlTruckTrailer.Items.Clear();

            dtVehicleList = objVehicleMaster.getVehicleTypeCategory();

            if (dtVehicleList != null && dtVehicleList.Rows.Count > 0)
            {
                ddlTruckTrailer.DataTextField = "CodeDesc";
                ddlTruckTrailer.DataValueField = "CodeId";
                ddlTruckTrailer.DataSource = dtVehicleList;
                ddlTruckTrailer.DataBind();
                ddlTruckTrailer.Items.Insert(0, new ListItem("Select", "0"));
            }
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }       
    public void getData(string vehicleTypeCode)
    {
        try
        {
            VehicleMasterController objVehicleMaster = new VehicleMasterController();
            DataTable dtVehicleTypeMaster = new DataTable();

            if (!string.IsNullOrEmpty(vehicleTypeCode))
            {
                dtVehicleTypeMaster = objVehicleMaster.getVehicleTypeByVehicleCode(vehicleTypeCode);
            }

            if (dtVehicleTypeMaster != null && dtVehicleTypeMaster.Rows.Count > 0)
            {                  
                lblVehicleCode.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["Type_Code"]);
                txtVehicleNm.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["Type_Name"]);
                hdnVehicleTypeName.Value = txtVehicleNm.Text.Trim(); 
                txtVehicleManufacturerNm.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["Made_By"]);
                txtModelNo.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["Model_No"]);
                txtTypeDescription.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["Type_Desc"]);
                txtGrosVehicleWeight.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["GVW"]);
                txtRateKm.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["Rate_Per_KM"]);
                txtFuelType.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["Fuel_Type"]);
                if (Convert.ToString(dtVehicleTypeMaster.Rows[0]["activeflag"]) == "Y")
                {
                    chkactiveflag.Checked = true;
                }
                else
                {
                    chkactiveflag.Checked = false;
                }
                ddlTruckTrailer.SelectedValue = Convert.ToString(dtVehicleTypeMaster.Rows[0]["Vehicle_Type_Category"]);
                txtStationKM.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["TyreRotate_KM"]);
                txtUnladenWeight.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["unld_wt"]);
                txtPayload.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["capacity"]);
                txtLength.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["length"]);
                txtWidth.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["width"]);
                txtHeight.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["Height"]);

                // txtVehicleNm.Enabled = false; 
            }
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
    #endregion
}


