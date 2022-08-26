using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebX.Controllers;
using WebX.Entity;
using Microsoft.ApplicationBlocks.Data;
public partial class GUI_admin_CustomerContractMaster_StepNavigation : System.Web.UI.UserControl
{
    public event SaveEventHandler SaveContractInformation;
    public delegate void SaveEventHandler();

    public string ContractID { get { return hdnContractID.Value; } set { hdnContractID.Value = value; } }
    public string CustCode { get { return hdnCustCode.Value; } set { hdnCustCode.Value = value; } }
	public bool Visible { get { return panNavigation.Visible; } set { panNavigation.Visible = value; } }

    protected void Page_Load(object sender, EventArgs e)
    {
        DataTable NavigationDetails = new DataTable();
        NavigationDetails.Columns.Add("ServiceCode", typeof(string));
        NavigationDetails.Columns.Add("Name", typeof(string));

        DataRow NavigationRow;

        CCMServices ccms = CCMServicesController.GetContractServices(ContractID);

        NavigationRow = NavigationDetails.NewRow();
        NavigationRow["ServiceCode"] = "1";
        NavigationRow["Name"] = "Basic Information";
        NavigationDetails.Rows.Add(NavigationRow);

        NavigationRow = NavigationDetails.NewRow();
        NavigationRow["ServiceCode"] = "2";
        NavigationRow["Name"] = "Service Selection";
        NavigationDetails.Rows.Add(NavigationRow);

        NavigationRow = NavigationDetails.NewRow();
        NavigationRow["ServiceCode"] = "3";
        NavigationRow["Name"] = "Modewise Services";
        NavigationDetails.Rows.Add(NavigationRow);

        NavigationRow = NavigationDetails.NewRow();
        NavigationRow["ServiceCode"] = "4";
        NavigationRow["Name"] = "Define Charge Matrix";
        NavigationDetails.Rows.Add(NavigationRow);

        NavigationRow = NavigationDetails.NewRow();
        NavigationRow["ServiceCode"] = "5";
        NavigationRow["Name"] = "Standard Charges";
        NavigationDetails.Rows.Add(NavigationRow);


        if (ccms.ServiceType.IndexOf("1") >= 0)
        {
            NavigationRow = NavigationDetails.NewRow();
            NavigationRow["ServiceCode"] = "6";
            NavigationRow["Name"] = "Freight Charges - LTL";
            NavigationDetails.Rows.Add(NavigationRow);
        }
        if (ccms.ServiceType.IndexOf("2") >= 0)
        {
            NavigationRow = NavigationDetails.NewRow();
            NavigationRow["ServiceCode"] = "7";
            NavigationRow["Name"] = "Freight Charges - FTL";
            NavigationDetails.Rows.Add(NavigationRow);
        }      
        if (ccms.FlagODA)
        {
            NavigationRow = NavigationDetails.NewRow();
            NavigationRow["ServiceCode"] = "8";
            NavigationRow["Name"] = "ODA Charges";
            NavigationDetails.Rows.Add(NavigationRow);
        }

        if (ccms.FlagFlatMultiPickup || ccms.FlagFlatMultiDelivery)
        {
            NavigationRow = NavigationDetails.NewRow();
            NavigationRow["ServiceCode"] = "9";
            NavigationRow["Name"] = "Flat Multipoint Charges";
            NavigationDetails.Rows.Add(NavigationRow);
        }

        if (ccms.FlagFlatLoading)
        {
            NavigationRow = NavigationDetails.NewRow();
            NavigationRow["ServiceCode"] = "10";
            NavigationRow["Name"] = "Flat Loading Charges";
            NavigationDetails.Rows.Add(NavigationRow);
        }

        if (ccms.FlagFlatUnLoading)
        {
            NavigationRow = NavigationDetails.NewRow();
            NavigationRow["ServiceCode"] = "11";
            NavigationRow["Name"] = "Flat Unloading Charges";
            NavigationDetails.Rows.Add(NavigationRow);
        }

        if (ccms.FlagLocMultiPickup || ccms.FlagLocMultiDelivery)
        {
            NavigationRow = NavigationDetails.NewRow();
            NavigationRow["ServiceCode"] = "12";
            NavigationRow["Name"] = "Location wise Multipoint Charges";
            NavigationDetails.Rows.Add(NavigationRow);
        }
        if (ccms.FlagLocMultiPickup || ccms.FlagLocMultiDelivery)
        {
            NavigationRow = NavigationDetails.NewRow();
            NavigationRow["ServiceCode"] = "12";
            NavigationRow["Name"] = "Location wise Multipoint Charges";
            NavigationDetails.Rows.Add(NavigationRow);
        }
        if (ccms.FlagLocMultiPickup || ccms.FlagLocMultiDelivery)
        {
            NavigationRow = NavigationDetails.NewRow();
            NavigationRow["ServiceCode"] = "12";
            NavigationRow["Name"] = "Location wise Multipoint Charges";
            NavigationDetails.Rows.Add(NavigationRow);
        }
        if (ccms.FlagLocLoading || ccms.FlagLocUnLoading)
        {
            NavigationRow = NavigationDetails.NewRow();
            NavigationRow["ServiceCode"] = "13";
            NavigationRow["Name"] = "Location wise Loading-Unloading Charges";
            NavigationDetails.Rows.Add(NavigationRow);
        }
        if (ccms.ServiceType.IndexOf("3") >= 0)
        {
            NavigationRow = NavigationDetails.NewRow();
            NavigationRow["ServiceCode"] = "15";
            NavigationRow["Name"] = "Freight Charges - FCL";
            NavigationDetails.Rows.Add(NavigationRow);
        }
        string strAutoBillingAllowed = (string)SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, "SELECT Online_ebilling FROM Webx_CustMiscDet WHERE CUSTCD='" + hdnCustCode.Value + "'");
        if (strAutoBillingAllowed == "Y")
        {
            NavigationRow = NavigationDetails.NewRow();
            NavigationRow["ServiceCode"] = "16";
            NavigationRow["Name"] = "Auto Billing Details";
            NavigationDetails.Rows.Add(NavigationRow);
        }
        reptNavigation.DataSource = NavigationDetails;
        reptNavigation.DataBind();
    }

    protected void lnkNavigation_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            LinkButton lnkNavigation = (LinkButton)e.Item.FindControl("lnkNavigation");
            lnkNavigation.Text = DataBinder.Eval(e.Item.DataItem, "Name").ToString();
            lnkNavigation.Attributes.Add("onclick", "javascript:return NavigationClick('" + lnkNavigation.ClientID + "')");
            HiddenField hdnServiceCode = (HiddenField)e.Item.FindControl("hdnServiceCode");
            hdnServiceCode.Value = DataBinder.Eval(e.Item.DataItem, "ServiceCode").ToString();
        }
    }

    protected void lnkNavigation_Click(object sender, EventArgs e)
    {
        if (hdnFlagSave.Value == "Y")
            SaveContractInformation();

        HiddenField hdnServiceCode = (HiddenField)((LinkButton)sender).FindControl("hdnServiceCode");

        if (hdnServiceCode.Value == "1")
        {
            Response.Redirect("CCMStep1.aspx?custcode=" + CustCode + "&contractid=" + ContractID);
        }
        else if (hdnServiceCode.Value == "2")
        {
            Response.Redirect("CCMStep2.aspx?custcode=" + CustCode + "&contractid=" + ContractID);
        }
        else if (hdnServiceCode.Value == "3")
        {
            Response.Redirect("CCMModeWise.aspx?custcode=" + CustCode + "&contractid=" + ContractID);
        }
        else if (hdnServiceCode.Value == "4")
        {
            Response.Redirect("DefineChargeMatrix.aspx?custcode=" + CustCode + "&contractid=" + ContractID);
        }
        else if (hdnServiceCode.Value == "5")
        {
            Response.Redirect("ChargeMatrixSelection.aspx?custcode=" + CustCode + "&contractid=" + ContractID + "&chargecode=");
        }
        else if (hdnServiceCode.Value == "6")
        {
            if (CCMController.GetSundrySlabType(ContractID).CompareTo("N") == 0)
            {
                Response.Redirect("ChargeMatrixSelection.aspx?custcode=" + CustCode + "&contractid=" + ContractID + "&chargecode=1");
            }
            else
                Response.Redirect("SundrySlabSelection.aspx?custcode=" + CustCode + "&contractid=" + ContractID);
        }
        else if (hdnServiceCode.Value == "7")
        {
            Response.Redirect("MatrixSelection.aspx?servicecode=2.1&custcode=" + CustCode + "&contractid=" + ContractID);
        }
        else if (hdnServiceCode.Value == "8")
        {
            Response.Redirect("EditCCMODA.aspx?custcode=" + CustCode + "&contractid=" + ContractID);
        }
        else if (hdnServiceCode.Value == "9")
        {
            Response.Redirect("FlatMultiPointCharges.aspx?custcode=" + CustCode + "&contractid=" + ContractID + "&requestid=flatmultipoint");
        }
        else if (hdnServiceCode.Value == "10")
        {
            Response.Redirect("FlatLoadingCharges.aspx?custcode=" + CustCode + "&contractid=" + ContractID + "&requestid=flatloading");
        }
        else if (hdnServiceCode.Value == "11")
        {
            Response.Redirect("FlatUnLoadingCharges.aspx?custcode=" + CustCode + "&contractid=" + ContractID + "&requestid=flatunloading");
        }
        else if (hdnServiceCode.Value == "12")
        {
            Response.Redirect("MultiPointCharges.aspx?custcode=" + CustCode + "&contractid=" + ContractID + "&requestid=locmultipoint");
        }
        else if (hdnServiceCode.Value == "13")
        {
            Response.Redirect("LoadingUnLoadingSundryFTLSelection.aspx?custcode=" + CustCode + "&contractid=" + ContractID + "&requestid=locloading");
        }
        else if (hdnServiceCode.Value == "14")
        {
            Response.Redirect("LoadingUnLoadingSundryFTLSelection.aspx?custcode=" + CustCode + "&contractid=" + ContractID + "&requestid=locunloading");
        }
        else if (hdnServiceCode.Value == "15")
        {
            Response.Redirect("FCLMatrixSelection.aspx?servicecode=2.1&custcode=" + CustCode + "&contractid=" + ContractID);
        }
        else if (hdnServiceCode.Value == "16")
        {
            Response.Redirect("AutoBilling.aspx?custcode=" + CustCode + "&contractid=" + ContractID);
        }
    }
}
