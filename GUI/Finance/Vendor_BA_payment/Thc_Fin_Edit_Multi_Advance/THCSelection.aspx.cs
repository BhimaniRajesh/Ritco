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

public partial class GUI_Finance_Vendor_BA_payment_THC_FIN_Edit_THCSelection : System.Web.UI.Page
{
    public int intTotalRecords;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            BindThcDetails();
        }

    }

    public void BindThcDetails()
    {
        var fn = new MyFunctions();
        var sFromDate = fn.Mydate(Convert.ToString(Request.QueryString["dtFrom"]));
        var sToDate = fn.Mydate(Convert.ToString(Request.QueryString["dtTo"]));
        var sThcNo = Convert.ToString(Request.QueryString["DocumentNo"]);
        var sManualThcNo = Convert.ToString(Request.QueryString["ManualNo"]);
        var sVehicleNo = Convert.ToString(Request.QueryString["VehicleNo"]);
        var sBranchCode = Session["BRCD"].ToString();
        var sFinyear = Convert.ToString(Session["Finyear"]);

        lblDocDate.Text = sFromDate + " TO " + sToDate;
        lblDocType.Text = "THC";

        var oThc = new ThcFinancialEdit();
        var dsResult = oThc.GetThcForFinancialEdit(sFromDate, sToDate, sThcNo, sManualThcNo, sVehicleNo, sFinyear, sBranchCode);

        GridTHCList.DataSource = dsResult;
        GridTHCList.DataBind();
        intTotalRecords = dsResult.Tables[0].Rows.Count;
    }
}
