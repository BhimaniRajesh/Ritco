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
        if (IsPostBack == false)
        {         
            if (!Page.IsPostBack)
            {
                VendorMasterController objVendorMaster = new VendorMasterController();
                DataTable dtLocation = new DataTable();

                dtLocation = objVendorMaster.getAllLocation();

                if (dtLocation != null && dtLocation.Rows.Count > 0)
                {
                    gvLocationList.DataSource = dtLocation;
                    gvLocationList.DataBind();
                }
            }
        }
    }
}

