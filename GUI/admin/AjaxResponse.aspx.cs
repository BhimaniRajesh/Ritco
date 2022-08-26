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
using System.IO;
using Microsoft.ApplicationBlocks.Data;

using WebX.Entity;
using WebX.Controllers;

public partial class GUI_Operation_Singlescreen_docketentry_AjaxResponse : System.Web.UI.Page
{
    #region Variable[s]
    string mode = string.Empty;
    #endregion

    #region Event[s]
    protected void Page_Load(object sender, EventArgs e)
    {        
        VehicleMasterController objVehicleTypeMaster = new VehicleMasterController();        
        DataTable dtVehicleTypeMaster = new DataTable();

        mode = Request.QueryString["mode"].ToString();      

            if (mode.CompareTo("check") == 0)
        {
            // CHECK MODE RETURNS true OR false USED ONLY TO CHECKING PURPOSE
            string code1 = Request.QueryString["code1"].ToString();
           
            if (code1.CompareTo("vehicletest") == 0)
            {
                #region VEHICLE IS ALREADY EXIST OR NOT
                string strVehicleNumber = Request.QueryString["code2"].ToString();              

                if (!string.IsNullOrEmpty(strVehicleNumber))
                {
                    if (DataValidations.IsValidVehicleNumber(strVehicleNumber))
                    {
                        Response.Write("true|Vehicle already exists.|");
                    }
                    else
                    {
                        Response.Write("false|This vehicle is not registred.|");
                    }
                }
                #endregion
            }
            else if(code1.CompareTo("locationcode") == 0)
            {
                string strLocationCode = Request.QueryString["code2"].ToString();

                #region LOCATION IS Active OR NOT
                if (!string.IsNullOrEmpty(strLocationCode))
                {
                    if (!DataValidations.IsActiveLocation(strLocationCode))
                    {
                        Response.Write("false|Please enter valid location.|");
                    }
                    else
                    {
                        Response.Write("true|");
                    }
                }
                #endregion
            }
            else if (code1.CompareTo("validLocation") == 0)
            {
                string strLocationCode = Request.QueryString["code2"].ToString();

                #region LOCATION IS VALID OR NOT
                if (!string.IsNullOrEmpty(strLocationCode))
                {
                    if (!DataValidations.IsValidLocation(strLocationCode))
                    {
                        Response.Write("false|Please enter valid location.|");
                    }
                    else
                    {
                        Response.Write("true|Location Code Already exist.|");
                    }
                }
                #endregion
            }
            else if (code1.CompareTo("arrLocationcode") == 0)
            {
                string strLocations = string.Empty;   
                string strLocationCodes = Request.QueryString["code2"].ToString();

                if (strLocationCodes.Contains(","))
                {
                    if (strLocationCodes.LastIndexOf(',') > 0)
                    {
                        if (strLocationCodes.Trim().IndexOf(',') == 0)
                        {
                            strLocations = strLocationCodes.Substring(1, strLocationCodes.Length - 1);
                            strLocations = strLocations.Substring(0, (strLocations.Length - 1));
                        }
                        else
                        {
                            strLocations = strLocationCodes.Trim();
                        }
                    }
                    else
                    {
                        strLocations = strLocationCodes.Substring(1, (strLocationCodes.Length - 1));
                    }
                }

                Array arrLocation;
                arrLocation = strLocations.Split(',');

                for (int i = 0; i < arrLocation.Length; i++)
                {
                    String strelement = ((string[])(arrLocation))[i];

                    #region LOCATION IS VALID OR NOT
                    if (!string.IsNullOrEmpty(strelement))
                    {
                        if (!DataValidations.IsActiveLocation(strelement))
                        {
                            Response.Write("false|Please enter valid location.|");
                            break;
                        }                       
                    }
                    #endregion
                }
            }
            else if (code1.CompareTo("vehtype") == 0)
            {
                string vehicleTypeName = Request.QueryString["code2"].ToString();

                #region VEHICLE TYPE NAME IS ALREADY EXIST OR NOT
                if (!string.IsNullOrEmpty(vehicleTypeName))
                {
                    dtVehicleTypeMaster = objVehicleTypeMaster.getVehicleTypeByVehicleTypeName(vehicleTypeName);

                    if (dtVehicleTypeMaster != null && dtVehicleTypeMaster.Rows.Count > 0)
                    {
                        Response.Write("true| Vehicle Type Name is already Exist. Please Enter another Type Name.|");
                    }
                    else
                    {
                        Response.Write("false|");
                    }
                }
                #endregion
            }
            else if (code1.CompareTo("state") == 0)
            {
                #region STATE
                string stateName = Request.QueryString["code2"].ToString();

                if (DataValidations.IsValidState(stateName))
                {
                    Response.Write("true| State Name Already Exists. Please Enter another state Name.|");
                }
                else
                {
                    Response.Write("false|");
                }
                #endregion
            }
            else if (code1.CompareTo("employee") == 0)
            {
                #region Employee
                string strEmpID = Request.QueryString["code2"].ToString();

                if (DataValidations.IsValidEmployeeID(strEmpID))
                {
                    Response.Write("true| Internal ID Already Exists. Please Enter another Internal ID.|");
                }
                else
                {
                    Response.Write("false| Internal ID Does Not Exist.|");
                }
                #endregion
            }
            else if (code1.CompareTo("user") == 0)
            {
                #region USER
                string strUserID = Request.QueryString["code2"].ToString();

                if (DataValidations.IsValidUserID(strUserID))
                {
                    Response.Write("true| User ID Already Exists. Please Enter another User ID.|");
                }
                else
                {
                    Response.Write("false| User ID Does Not Exist.|");
                }
                #endregion
            }
            else if (code1.CompareTo("customerCode") == 0)
            {
                #region Customer
                string strCustomerCode = Request.QueryString["code2"].ToString();

                if (DataValidations.IsValidCustomerCode(strCustomerCode))
                {
                    Response.Write("true|");
                }
                else
                {
                    Response.Write("false| Customer code Does Not Exist.|");
                }
                #endregion
            }
            else if (code1.CompareTo("vendorCode") == 0)
            {
                #region Vendor
                string strVendorCode = Request.QueryString["code2"].ToString();

                if (DataValidations.IsValidVendorCode(strVendorCode))
                {
                    Response.Write("true|");
                }
                else
                {
                    Response.Write("false| Vendor code Does Not Exist.|");
                }
                #endregion
            }
            else if (code1.CompareTo("routecode") == 0)
            {
                #region Route with mode
                string strRouteName = Request.QueryString["code2"].ToString();
                string strRouteMode = Request.QueryString["routemode"].ToString();

                if (DataValidations.IsValidRouteName(strRouteName, strRouteMode))
                {
                    Response.Write("true| Route Already Exists.|");
                }
                else
                {
                    Response.Write("false| Route Does Not Exist.|");
                }
                #endregion
            }
            else if (code1.CompareTo("routeCodeC") == 0)
            {
                #region Route
                string strRouteCode = Request.QueryString["code2"].ToString();

                if (DataValidations.IsValidRouteCode(strRouteCode))
                {
                    Response.Write("true| Route Code Already Exists.|");
                }
                else
                {
                    Response.Write("false| Route code Does Not Exist.|");
                }
                #endregion
            }
            else if (code1.CompareTo("routecodecity") == 0)
            {
                #region City Route with mode
                string strRouteName = Request.QueryString["code2"].ToString();
                string strRouteMode = Request.QueryString["routemode"].ToString();

                if (DataValidations.IsValidCityRouteName(strRouteName, strRouteMode))
                {
                    Response.Write("true| City Based Route Already Exists.|");
                }
                else
                {
                    Response.Write("false| City Based Route Does Not Exist.|");
                }
                #endregion
            }
            else if (code1.CompareTo("routeCodeCityC") == 0)
            {
                #region City Route
                string strRouteCode = Request.QueryString["code2"].ToString();

                if (DataValidations.IsValidCityRouteCode(strRouteCode))
                {
                    Response.Write("true| City Based Route Code Already Exists.|");
                }
                else
                {
                    Response.Write("false| City Based Route code Does Not Exist.|");
                }
                #endregion
            }
            else if (code1.CompareTo("customerGroupName") == 0)
            {
                #region Customer Group Name
                string strGroupName = Request.QueryString["code2"].ToString();

                if (DataValidations.IsValidCustomerGroupName(strGroupName))
                {
                    Response.Write("true| Group Name Already Exist.|");
                }
                else
                {
                    Response.Write("false| Group Name Does Not Exist.|");
                }
                #endregion
            }
            else if (code1.CompareTo("customerGroupCode") == 0)
            {
                #region Customer Group Name
                string strGroupCode = Request.QueryString["code2"].ToString();

                if (DataValidations.IsValidCustomerGroupCode(strGroupCode))
                {
                    Response.Write("true| Group Code Already Exist.|");
                }
                else
                {
                    Response.Write("false| Group Code Does Not Exist.|");
                }
                #endregion
            }
            else if (code1.CompareTo("Pincode") == 0)
            {
                #region Customer Group Name
                int Pincode = Request.QueryString["code2"].ToString() != "" ? Convert.ToInt32(Request.QueryString["code2"]) : 0;

                if (DataValidations.IsValidPincode(Pincode))
                {
                    Response.Write("true| Pincode Already Exist.|");
                }
                else
                {
                    Response.Write("false| Pincode Does Not Exist.|");
                }

                //string state = Request.QueryString["state"].ToString();
                //string city = Request.QueryString["City"].ToString();

                //if (DataValidations.IsValidPincode(state, city, Pincode))
                //{
                //    Response.Write("true| Pincode Already Exist For " + city + ".");
                //}
                //else
                //{
                //    Response.Write("false| Pincode Does Not Exist.|");
                //}
                #endregion
            }
            else if (code1.CompareTo("City") == 0)
            {
                #region Customer Group Name
                string City = Request.QueryString["code2"].ToString();

                if (DataValidations.IsValidCity(City))
                {
                    Response.Write("true| City Already Exist.|");
                }
                else
                {
                    Response.Write("false| City Does Not Exist.|");
                }
                #endregion
            }
            else if (code1.CompareTo("HO") == 0)
            {
                #region Check Head Office               

                if (DataValidations.IsHeadOfficeLocation())
                {
                    Response.Write("true| Head Office location already exist. Please select other location level.|");
                }
                else
                {
                    Response.Write("false| Head Office location not exist.|");
                }
                #endregion
            } 

        } // check ENDS HERE
        else if (mode.CompareTo("data") == 0)
        {
        }// data ENDS HERE       
    }
    #endregion
}
