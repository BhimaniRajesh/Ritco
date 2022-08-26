/// <reference path="GSTCommon.js" />
/// <reference path="../../../Js/Webx.Common.js" />

var hdnOrigin, hdnDestination;
var txtOrigin, txtDestination;


$(document).ready(function () {

    hdnOrigin = $("#" + hdnOrigin);
    hdnDestination = $("#" + hdnDestination);

    txtOrigin = $("#" + txtOrigin);
    txtDestination = $("#" + txtDestination);
   
    InitAutoCompleteSelection();

    //InitAutoComplete();
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
    function EndRequestHandler(sender, args) {
        // InitAutoComplete();
        hdnOrigin = $("#" + hdnOriginID);
        hdnDestination = $("#" + hdnDestinationID);

        txtOrigin = $("#" + txtOriginID);
        txtDestination = $("#" + txtDestinationID);

        InitAutoCompleteSelection();
    }
});

function InitAutoCompleteSelection() {
    //AutoCompleteForGSTMaster(txtCompanyName, serviceUrl + '/CompanyAutoComplate', 'POST', 'application/json; charset=utf-8', 'json',
    //            'searchText', 'l', 'l', 'l', 'v', 'v', hdnCompanyCodeID, 'No entries found!', 2, null, true);

    AutoCompleteForGSTMaster(txtOrigin, serviceUrl + '/LocationAutoComplateReport', 'POST', 'application/json; charset=utf-8', 'json',
        'searchText', 'v', 'v', 'l', 'v', 'v', hdnOriginID, 'No entries found!', 2, null, true);

    AutoCompleteForGSTMaster(txtDestination, serviceUrl + '/LocationAutoComplateReport', 'POST', 'application/json; charset=utf-8', 'json',
        'searchText', 'v', 'v', 'l', 'v', 'v', hdnDestinationID, 'No entries found!', 2, null, true);
}
