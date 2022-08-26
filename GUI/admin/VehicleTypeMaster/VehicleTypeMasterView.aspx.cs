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
    protected static string boxbg, bgbluegrey;
    public static string vehicleTypeCode = string.Empty; 
    #endregion

    #region Event[s]
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!Page.IsPostBack)
            {
                vehicleTypeCode = Convert.ToString(Request.QueryString["vehicleTypeCode"]);  
                hdnflagprint.Value = Convert.ToString(Request.QueryString["print"]);

                if (hdnflagprint.Value.CompareTo("Y") == 0)
                {
                    setBorderWidth();
                    lnkBtnDownloadXLS.Visible = false;
                    lnkBtnPrint.Visible = false; 
                    boxbg = "bgwhite";
                    bgbluegrey = "bgwhite";
                    tblMain.BorderWidth = 1;
                    tblMain.BackColor = System.Drawing.Color.Black;
                    trVehicleTypeMaster.BackColor = System.Drawing.Color.White;
                    trCapacityInfo.BackColor = System.Drawing.Color.White;                   
                }
                else
                {
                    if (Convert.ToString(Request.QueryString["print"]).CompareTo("N") == 0)
                    {
                        lnkBtnDownloadXLS.Visible = true;
                        lnkBtnPrint.Visible = true;
                        boxbg = "boxbg";
                        tblMain.CssClass = "boxbg";                       
                        trVehicleTypeMaster.CssClass = "bgbluegrey";
                        trCapacityInfo.CssClass = "bgbluegrey";                     
                        bgbluegrey = "bgbluegrey";
                    }
                }

                if (Request.QueryString["vehicleTypeCode"] != null)
                {
                    getData(Request.QueryString["vehicleTypeCode"].ToString());
                }
            }
        }
        catch (Exception Exc)
        {          
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Session Expired&detail1=" + Exc.Message.Replace('\n', '_'));            
        }
    }
    protected void lnkBtnDownloadXLS_Click(object sender, EventArgs e)
    {
        try
        {
            setBorderWidth();
            DownloadXLS();
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in download excel file.&detail1=" + Exc.Message.Replace('\n', '_'), true);
        }
        finally
        {
            Response.End();
        }
    }
    #endregion

    #region Private Function[s]
    private void DownloadXLS()
    {
        try
        {
            //export to excel
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=" + lblVehicleName.Text.Trim() + ".xls");
            Response.ContentType = "application/vnd.ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
            tblMain.RenderControl(oHtmlTextWriter);
            Response.Write(oStringWriter.ToString());
            // Response.End();
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
    private void setBorderWidth()
    {
        tdVehicleTypeMaster.BorderWidth = 1;
        tdVehicleTypeCode.BorderWidth = 1;
        lbltdVehicleTypeCode.BorderWidth = 1;
        tdVehicleManufactureName.BorderWidth = 1;
        lbltdVehicleManufactureName.BorderWidth = 1;
        tdVehicleName.BorderWidth = 1;
        lbltdVehicleName.BorderWidth = 1;
        tdVehicleModelNo.BorderWidth = 1;
        lbltdVehicleModelNo.BorderWidth = 1;
        tdVehicleTypeDecs.BorderWidth = 1;
        lbltdVehicleTypeDecs.BorderWidth = 1;
        tdActiveFlag.BorderWidth = 1;
        lbltdActiveFlag.BorderWidth = 1;
        tdCapecityInfo.BorderWidth = 1;
        tdGrossVehicleWeight.BorderWidth = 1;
        lbltdGrossVehicleWeight.BorderWidth = 1;
        tdUnledenWeight.BorderWidth = 1;
        lbltdUnledenWeight.BorderWidth = 1;
        tdPayload.BorderWidth = 1;
        lbltdPayload.BorderWidth = 1;
        tdRate.BorderWidth = 1;
        lbltdRate.BorderWidth = 1;
        tdFuelType.BorderWidth = 1;
        lbltdFuelType.BorderWidth = 1;
        tdHeight.BorderWidth = 1;
        lbltdHeight.BorderWidth = 1;
        tdUpdateby.BorderWidth = 1;
        lbltdUpdateby.BorderWidth = 1;
        tdUpdateon.BorderWidth = 1;
        lbltdUpdateon.BorderWidth = 1;
        tdLength.BorderWidth = 1;
        lbltdLength.BorderWidth = 1;
        tdWidth.BorderWidth = 1;
        lbltdWidth.BorderWidth = 1;
        tdTruck.BorderWidth = 1;
        lbltdTruck.BorderWidth = 1;
        tdTyreStation.BorderWidth = 1;
        lbltdTyreStation.BorderWidth = 1; 
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
                lblVehicleTypeCode.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["Type_Code"]);
                lblVehicleName.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["Type_Name"]);
                lblVehicleManufactureName.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["Made_By"]);
                lblVehicleModelNo.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["Model_No"]);
                lblVehicleTypeDesc.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["Type_Desc"]);
                lblVehicleGrossWeight.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["GVW"]);
                lblRate.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["Rate_Per_KM"]);
                lblFuelType.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["Fuel_Type"]);
                lblActiveFlag.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["activeflag"]);
                lblUpdateBy.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["UpdateBy"]);

                if (!string.IsNullOrEmpty(Convert.ToString(dtVehicleTypeMaster.Rows[0]["UPDTON"])))
                {
                    if (DateTime.Compare(Convert.ToDateTime(dtVehicleTypeMaster.Rows[0]["UPDTON"]), DateTime.MinValue.AddYears(1754)) != 0)
                        lblUpdateOn.Text = dtVehicleTypeMaster.Rows[0]["UPDTON"] != null ? Convert.ToDateTime(dtVehicleTypeMaster.Rows[0]["UPDTON"].ToString()).ToString("dd/MM/yyyy") : "";
                }

                lblVehicleTypeCat.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["Vehicle_Type_Category_Name"]);
                lblTyreStation.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["TyreRotate_KM"]);
                lblUnladen.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["unld_wt"]);
                lblPayload.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["capacity"]);
                lblLength.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["length"]);
                lblWidth.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["width"]);
                lblHeight.Text = Convert.ToString(dtVehicleTypeMaster.Rows[0]["Height"]);
            }
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }   
    #endregion
}
