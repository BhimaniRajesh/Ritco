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

public partial class GUI_UNI_MIS_Bill_Register_Query : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void radDate_OnSelectedIndexChange(object sender, EventArgs e)
    {
        txtDateFrom.ReadOnly = false;
        txtDateTo.ReadOnly = false;

        System.DateTime righnow = System.DateTime.Today;
        string strrightnow = righnow.ToString("dd/MM/yyyy");

        RadioButtonList rbl = new RadioButtonList();
        rbl = (RadioButtonList)sender;
        if (!(rbl.Items[0].Selected))
        {
            txtDateFrom.Text = strrightnow;
            txtDateTo.Text = strrightnow;
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
        }
        if (rbl.Items[1].Selected)
        {
            righnow = righnow.AddDays(-7);
            strrightnow = righnow.ToString("dd/MM/yyyy");
            txtDateFrom.Text = strrightnow;
        }
        if (rbl.Items[3].Selected)
        {
            righnow = righnow.AddDays(-30);
            strrightnow = righnow.ToString("dd/MM/yyyy");
            txtDateFrom.Text = strrightnow;
        }
    }
    public void ToDate(object source, ServerValidateEventArgs value)
    {
        //value.IsValid = true; 
        string[] strDtFrom = txtDateFrom.Text.Split('/');
        DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        string[] strDtTo = txtDateTo.Text.Split('/');
        DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));
        if (DateTime.Compare(dt1, dt2) > 0)
        {
            value.IsValid = false;
        }
        else
        {
            value.IsValid = true;
        }
    }
    public void daterange(object source, ServerValidateEventArgs value)
    {
        string[] strDtFrom = txtDateFrom.Text.Split('/');
        DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        string[] strDtTo = txtDateTo.Text.Split('/');
        DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));
        System.TimeSpan diffResult = dt2.Subtract(dt1);
        //if (diffResult.Days > 31)
        //{
        //    value.IsValid = false;
        //}
        //else
        //{
        //    value.IsValid = true;
        //}
    }
    protected void btnShowMR_OnClick(object sender, EventArgs e)
    {
        if (Page.IsValid == true)
        {
            string[] strArrDtFrom = txtDateFrom.Text.Split('/');
            string[] strArrDtTo = txtDateTo.Text.Split('/');
            string strQSBillDate = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy") + " - " + Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");

            string BillingParty = txtPartyCode.Text;
            string BillType = ddlBillType.SelectedItem.Value;
            string BillAt = txtBilledAt.Text;
            string SubAt = txtSubmittedAt.Text;
            string CollAt = txtCollectionAt.Text;
            string Status = ddlStatus.SelectedItem.Value;
            string OverDueDay = txtOverDueDays.Text;
            string AmtGrThan = txtAmtGreaterThan.Text;
            string BillNo = txtBillNo.Text;

            string strFinalQS = "?BillDate=" + strQSBillDate;
            strFinalQS = strFinalQS + "&BillingParty=" + BillingParty;
            strFinalQS = strFinalQS + "&BillType=" + BillType;
            strFinalQS = strFinalQS + "&BilledAt=" + BillAt;
            strFinalQS = strFinalQS + "&SubmittedAt=" + SubAt;
            strFinalQS = strFinalQS + "&CollectedAt=" + CollAt;
            strFinalQS = strFinalQS + "&Status=" + Status;
            strFinalQS = strFinalQS + "&OverDueDays=" + OverDueDay;
            strFinalQS = strFinalQS + "&AmtGrThan=" + AmtGrThan;
            strFinalQS = strFinalQS + "&BillNo=" + BillNo;


            Response.Redirect("BillRegister_ShowBillDetails.aspx" + strFinalQS);
        }
    }
}
