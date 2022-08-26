using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebX.Controllers;

public partial class GUI_Fleet_Operations_Issue_New_TripSheet_Validation_DriverSettlementTripsheetAmountView : System.Web.UI.Page
{
    string stVSlipId = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            stVSlipId = Request.QueryString["id"];
            DriverSettlementController obj = new DriverSettlementController();
            gvDriverSettlementAmount.DataSource = obj.GetDriverSettlementTripsheetAmountView(stVSlipId);
            gvDriverSettlementAmount.DataBind();

        }
    }
}