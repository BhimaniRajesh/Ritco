using System;
using System.Data;
using WebX.Controllers;
public partial class GUI_Finance_Billing_Ver1_MRDotmatrixViewPrint : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetMrDetail();
        }
    }
    public void GetMrDetail()
    {
        var objMRDotmatrixController = new MRDotmatrixController();
        var dtMrDetails = new DataTable();

        string MRSNo = Request.QueryString["mrsno"];
        dtMrDetails = objMRDotmatrixController.GetDocketdetails(MRSNo);

        if (dtMrDetails != null && dtMrDetails.Rows.Count > 0)
        {
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
            lblServicetax.Text = Convert.ToString(dtMrDetails.Rows[0]["ServiceTax"]);
            lblGodown.Text = Convert.ToString(dtMrDetails.Rows[0]["Godown"]);
            lblTotal.Text = Convert.ToString(dtMrDetails.Rows[0]["GTotal"]);
            lblUIDate.Text = Convert.ToString(dtMrDetails.Rows[0]["UIDate"]);
            lblCollectedAmt.Text = Convert.ToString(dtMrDetails.Rows[0]["CollectedAmount"]);
            lblCashCredit.Text = Convert.ToString(dtMrDetails.Rows[0]["CashCredit"]);
         }
    }
}