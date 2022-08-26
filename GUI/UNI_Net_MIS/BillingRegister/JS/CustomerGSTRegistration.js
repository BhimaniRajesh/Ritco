/// <reference path="../../../Js/Webx.Common.js" />

var btnSubmit, hdnCust, hdnValid, tdpr2, tdpr1, ddlBillingPreference, lblBIll;
var btnNext, tdCustomerHeaderDetail, tdCustomerDetail, Table1Submit, txtCustomerName, tdCustomerCriteria;
var txtGSTCity, ddlGSTState, hdnGSTCity, hdnGSTState;
var tdCustomerDetailExcel, rbEntrytype;
var rbPreferenceType


$(document).ready(function () {

    txtCustomerName = $("#" + txtCustomerNameID);
    hdnCust = $("#" + hdnCustID);
    
    InitAutoCompleteSelection();
    InitAutoComplete();

    //InitAutoComplete();
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
    function EndRequestHandler(sender, args) {
        // InitAutoComplete();
       
        txtCustomerName = $("#" + txtCustomerNameID);
        hdnCust = $("#" + hdnCustID);

        InitAutoCompleteSelection();
        InitAutoComplete();
    }
});

function InitAutoCompleteSelection() {
    AutoCompleteForGSTMaster(txtCustomerName, serviceUrl + '/CustomerAutoComplate', 'POST', 'application/json; charset=utf-8', 'json',
                'searchText', 'l', 'l', 'l', 'v', 'v', hdnCustID, 'No entries found!', 2, null, true);

}
