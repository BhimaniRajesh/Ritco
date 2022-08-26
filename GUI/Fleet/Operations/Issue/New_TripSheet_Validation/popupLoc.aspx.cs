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

using WebX.Controllers;

public partial class GUI_admin_CustomerMaster_popupLoc : System.Web.UI.Page
{
    public static string strQSParam;
    protected void Page_Load(object sender, EventArgs e)
    {
        hdnstrQSParam.Value = HttpUtility.UrlDecode(Request.QueryString.ToString());
        if (IsPostBack == false)
        {
            if (!Page.IsPostBack)
            {
                VehicleMasterController objVehicleMaster = new VehicleMasterController();
                DataTable dtVehicle = new DataTable();
                dtVehicle = objVehicleMaster.getAllVehicle();

                if (dtVehicle != null && dtVehicle.Rows.Count > 0)
                {
                    gvLocationList.DataSource = dtVehicle;
                    gvLocationList.DataBind();
                }

            }
        }
    }
    protected void gvLocationList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        foreach (GridViewRow gvLocationList1 in gvLocationList.Rows)
        {
            RadioButton rad = gvLocationList1.FindControl("RbtVeh") as RadioButton; 

            //rad.Attributes.Add("onclick", "javascript:return SelectVehicle(this.getAttribute('id'),'" + QSParam2 + "')");

            //rad.Attributes.Add("onclick", "javascript:return SelectVehicle(this)");
        }

    }
}

