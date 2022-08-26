using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_admin_VehicleMappingFuelCard_Vehicle_Mapping_FuelCard_View : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        trxsl.Visible = false;
    }

    #region Events
    protected void btnStep1_Click(object sender, EventArgs e)
    {
        trxsl.Visible = true;
        view.Visible = true;
        XlSDownload.Visible = true;

        VehicleFuelMappingController obj = new VehicleFuelMappingController();

        ds = obj.GetFuelCardMappingView(txtVehicleNo.Text);
        BindFuelCardMappingDetails.DataSource = ds;
        BindFuelCardMappingDetails.DataBind();
    }

    protected void XlSDownload_Click(object sender, EventArgs e)
    {
        try
        {
            var objVehicleFuelController = new VehicleFuelMappingController();
            ds = objVehicleFuelController.GetFuelCardMappingView(txtVehicleNo.Text);
            ExcelUtilities Exlobj = new ExcelUtilities();
            Exlobj.ExportExcel(ds, "VehicleMappingWithFuelCard.xls");
        }
        catch (Exception ex)
        {
         
        }
    }
    #endregion

}