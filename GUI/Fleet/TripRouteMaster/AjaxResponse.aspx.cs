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

public partial class GUI_Operation_Singlescreen_TripRouteMst_AjaxResponse : System.Web.UI.Page
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
            
            if (code1.CompareTo("City") == 0)
            {
                #region Customer Group Name
                string City = Request.QueryString["code2"].ToString();

                if (TripRouteValidations.IsValidCity(City))
                {
                    Response.Write("true| City Already Exist.|");
                }
                else
                {
                    Response.Write("false| City Does Not Exist.|");
                }
                #endregion
            }
            else if (code1.CompareTo("LocName") == 0)
            {
                #region Customer Group Name
                string LocNm = Request.QueryString["code2"].ToString();

                if (TripRouteValidations.IsValidLocaton(LocNm))
                {
                    Response.Write("true| Location Already Exist.|");
                }
                else
                {
                    Response.Write("false| Location Does Not Exist.|");
                }
                #endregion
            }
            else if (code1.CompareTo("LocCode") == 0)
            {
                #region Customer Group Name
                string LocNm = Request.QueryString["code2"].ToString();

                if (TripRouteValidations.IsValidLocCode(LocNm))
                {
                    Response.Write("true| Location Already Exist.|");
                }
                else
                {
                    Response.Write("false| Location Does Not Exist.|");
                }
                #endregion
            }
            else if (code1.CompareTo("routeCodeCityC") == 0)
            {
                #region City Route
                string strRouteCode = Request.QueryString["code2"].ToString();

                if (TripRouteValidations.IsValidTripRouteCode(strRouteCode))
                {
                    Response.Write("true| City Based Route Code Already Exists.|");
                }
                else
                {
                    Response.Write("false| City Based Route code Does Not Exist.|");
                }
                #endregion
            }
            else if (code1.CompareTo("routecodecity") == 0)
            {
                #region City Route with mode
                string strRouteName = Request.QueryString["code2"].ToString();
                string strRouteMode = Request.QueryString["routemode"].ToString();

                if (TripRouteValidations.IsValidCityRouteName(strRouteName, strRouteMode))
                {
                    Response.Write("true| City Based Route Already Exists.|");
                }
                else
                {
                    Response.Write("false| City Based Route Does Not Exist.|");
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
