/// <reference path="../../../Js/Webx.Common.js" />

var btnSubmit, hdnCust, hdnValid, tdpr2, tdpr1, ddlBillingPreference, lblBIll;
var btnNext, tdCustomerHeaderDetail, tdCustomerDetail, Table1Submit, txtCustomerName, tdCustomerCriteria;
var txtGSTCity, ddlGSTState, hdnGSTCity, hdnGSTState;
var tdCustomerDetailExcel, rbEntrytype;
var rbPreferenceType
var hdnOrigin, hdnDestination;
var txtOrigin, txtDestination;

$(document).ready(function () {

    txtCustomerName = $("#" + txtCustomerNameID);
    hdnCust = $("#" + hdnCustID);

    hdnOrigin = $("#" + hdnOriginID);
    hdnDestination = $("#" + hdnDestinationID);

    txtOrigin = $("#" + txtOriginID);
    txtDestination = $("#" + txtDestinationID);
    
    InitAutoCompleteSelection();
  

    //InitAutoComplete();
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
    function EndRequestHandler(sender, args) {
        // InitAutoComplete();
       
        txtCustomerName = $("#" + txtCustomerNameID);
        hdnCust = $("#" + hdnCustID);

        hdnOrigin = $("#" + hdnOriginID);
        hdnDestination = $("#" + hdnDestinationID);

        txtOrigin = $("#" + txtOriginID);
        txtDestination = $("#" + txtDestinationID);

        InitAutoCompleteSelection();
       
    }
});

function InitAutoCompleteSelection() {
    
	AutoCompleteForGSTMaster(txtCustomerName, serviceUrl + '/CustomerAutoComplate', 'POST', 'application/json; charset=utf-8', 'json',
        'searchText', 'l', 'l', 'l', 'v', 'v', hdnCustID, 'No entries found!', 2, null, true);

    //AutoCompleteForGSTMaster(txtCompanyName, serviceUrl + '/CompanyAutoComplate', 'POST', 'application/json; charset=utf-8', 'json',
    //            'searchText', 'l', 'l', 'l', 'v', 'v', hdnCompanyCodeID, 'No entries found!', 2, null, true);

    AutoCompleteForGSTMaster(txtOrigin, serviceUrl + '/LocationAutoComplateReport', 'POST', 'application/json; charset=utf-8', 'json',
        'searchText', 'v', 'v', 'l', 'v', 'v', hdnOriginID, 'No entries found!', 2, null, true);

    AutoCompleteForGSTMaster(txtDestination, serviceUrl + '/LocationAutoComplateReport', 'POST', 'application/json; charset=utf-8', 'json',
        'searchText', 'v', 'v', 'l', 'v', 'v', hdnDestinationID, 'No entries found!', 2, null, true);

}
