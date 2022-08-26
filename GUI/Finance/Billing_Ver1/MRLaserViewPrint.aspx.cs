using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System;
using System.Data;
using WebX.Controllers;

public partial class GUI_Finance_Billing_Ver1_MRLaserViewPrint : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack && !IsCallback)
            {
                reptMain.DataSource = GenerateData();
                reptMain.DataBind();
            }
        }
        catch (Exception Exc)
        {
            Response.Redirect("ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }
    private DataTable GenerateData()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("ID");
        dt.Columns.Add("DESC");

        dt.Rows.Add("1", "Consignor Copy");
        //dt.Rows.Add("2", "Consignee Copy ");
        //dt.Rows.Add("3", "HO Copy");
        //dt.Rows.Add("4", "POD Copy");

        return dt;
    }
    protected void reptMain_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        var objMRDotmatrixController = new MRDotmatrixController();
        var dtMrDetails = new DataTable();

        string MRSNo = Request.QueryString["mrsno"];
        dtMrDetails = objMRDotmatrixController.GetDocketdetails(MRSNo);

        if (dtMrDetails != null && dtMrDetails.Rows.Count > 0)
        {
            Label lblMrNo = (Label)e.Item.FindControl("lblMrNo");
            Label lblMrDate = (Label)e.Item.FindControl("lblMrDate");
            Label lblReceiver = (Label)e.Item.FindControl("lblReceiver");
            Label lblStation = (Label)e.Item.FindControl("lblStation");
            Label lblThrough = (Label)e.Item.FindControl("lblMrNo");
            Label lblFreigth = (Label)e.Item.FindControl("lblFreigth");
            Label lblGrNo = (Label)e.Item.FindControl("lblGrNo");
            Label lblFreightDiff = (Label)e.Item.FindControl("lblFreightDiff");
            Label lblBookedOn = (Label)e.Item.FindControl("lblBookedOn");
            Label lblDocketcharges = (Label)e.Item.FindControl("lblDocketcharges");
            Label lblFrom = (Label)e.Item.FindControl("lblFrom");
            Label lblMiscCharges = (Label)e.Item.FindControl("lblMiscCharges");
            Label lblPackeges = (Label)e.Item.FindControl("lblPackeges");
            Label lblDlyCharges = (Label)e.Item.FindControl("lblDlyCharges");
            Label lblContents = (Label)e.Item.FindControl("lblContents");
            Label lblHandlingCharges = (Label)e.Item.FindControl("lblHandlingCharges");
            Label lblWeigth = (Label)e.Item.FindControl("lblWeigth");
            Label lblSurcharge = (Label)e.Item.FindControl("lblSurcharge");
            Label lblPvtMark = (Label)e.Item.FindControl("lblPvtMark");
            Label lblLabour = (Label)e.Item.FindControl("lblLabour");
            Label lblPakgtype = (Label)e.Item.FindControl("lblPakgtype");
            Label lblServicetax = (Label)e.Item.FindControl("lblServicetax");
            Label lblGodown = (Label)e.Item.FindControl("lblGodown");
            Label lblTotal = (Label)e.Item.FindControl("lblTotal");
            Label lblUIDate = (Label)e.Item.FindControl("lblUIDate");
            Label lblCollectedAmt = (Label)e.Item.FindControl("lblCollectedAmt");
            Label lblCashCredit = (Label)e.Item.FindControl("lblCashCredit");
            Label lblRemark = (Label)e.Item.FindControl("lblRemark");
            Label lblGSTNo = (Label)e.Item.FindControl("lblGSTNo");


            lblMrNo.Text = Convert.ToString(dtMrDetails.Rows[0]["MRSNO"]);
            lblMrDate.Text = Convert.ToString(dtMrDetails.Rows[0]["MRDate"]);
            lblReceiver.Text = Convert.ToString(dtMrDetails.Rows[0]["Receiver"]);
            lblStation.Text = Convert.ToString(dtMrDetails.Rows[0]["Station"]);
            lblThrough.Text = Convert.ToString(dtMrDetails.Rows[0]["Through"]);
            lblFreigth.Text = Convert.ToString(dtMrDetails.Rows[0]["Freight"]);
            lblGrNo.Text = Convert.ToString(dtMrDetails.Rows[0]["GrNO"]);
            lblFreightDiff.Text = Convert.ToString(dtMrDetails.Rows[0]["FreightDiff"]);
            lblBookedOn.Text = Convert.ToString(dtMrDetails.Rows[0]["BookedOn"]);
            lblDocketcharges.Text = Convert.ToString(dtMrDetails.Rows[0]["DocketChg"]);
            lblFrom.Text = Convert.ToString(dtMrDetails.Rows[0]["FromCity"]);
            lblMiscCharges.Text = Convert.ToString(dtMrDetails.Rows[0]["Misccharges"]);
            lblPackeges.Text = Convert.ToString(dtMrDetails.Rows[0]["Packeges"]);
            lblDlyCharges.Text = Convert.ToString(dtMrDetails.Rows[0]["DlyCharges"]);
            lblContents.Text = Convert.ToString(dtMrDetails.Rows[0]["Contents"]);
            lblHandlingCharges.Text = Convert.ToString(dtMrDetails.Rows[0]["Hadlingcharge"]);
            lblWeigth.Text = Convert.ToString(dtMrDetails.Rows[0]["ChrgeWeight"]);
            lblSurcharge.Text = Convert.ToString(dtMrDetails.Rows[0]["Surcharge"]);
            lblPvtMark.Text = Convert.ToString(dtMrDetails.Rows[0]["PvtMark"]);
            lblLabour.Text = Convert.ToString(dtMrDetails.Rows[0]["Labourchg"]);
            lblPakgtype.Text = Convert.ToString(dtMrDetails.Rows[0]["PakgsType"]);
            lblServicetax.Text = Convert.ToString(dtMrDetails.Rows[0]["GSTCharged"]);
            lblGodown.Text = Convert.ToString(dtMrDetails.Rows[0]["Godown"]);
            lblTotal.Text = Convert.ToString(dtMrDetails.Rows[0]["GTotal"]);
            lblUIDate.Text = Convert.ToString(dtMrDetails.Rows[0]["UIDate"]);
            lblCollectedAmt.Text = Convert.ToString(dtMrDetails.Rows[0]["CollectedAmount"]);
            lblCashCredit.Text = Convert.ToString(dtMrDetails.Rows[0]["CashCredit"]);
            lblRemark.Text = Convert.ToString(dtMrDetails.Rows[0]["remark"]);
            lblGSTNo.Text = Convert.ToString(dtMrDetails.Rows[0]["GSTIN"]);
        }

    }
 
}