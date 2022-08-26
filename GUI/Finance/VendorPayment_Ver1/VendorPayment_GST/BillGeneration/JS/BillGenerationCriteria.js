var ddlTransactionType, ddlTransactionCategory, txtVendorCode, txtDateFrom, txtDateTo, txtVendorName, btnGetList,
hdnCompanyCode, ddlGstCharged, ddlSupplyState, ddlBookingState;
var DatecontrolIdPrefix = "ctl00_MyCPH1_dtBookingDate_";
var controlIdPrefix = "ctl00_MyCPH1_";
var reqData = {};
//reqData.TrnMode = "4";
//reqData.Paybas = "2";

$(document).ready(function () {

    InitializeControls();

    $("#" + controlIdPrefix + "trDate").hide();
    
    AutoCompleteByAjaxVer1("[id*='txtVendorCode']", serviceUrl + 'GetVendor', 'POST', 'application/json; charset=utf-8', 'json', 'searchText', 2, 'vl', 'vl', 'l', 'v', txtVendorName.id, 'No Customer found!', reqData, false);

    $(document).on("blur", "[id*='txtVendorCode']", function () {
        if (!(WebxConvert.IsStringNullOrEmpty($(this).val()))) {
            var requestData = "{ 'vendorId' : '" + $(this).val() + "'}";
            WebxCommon.invokeWebxAJAXRequest(serviceUrl + 'CheckValidVendor', 'POST', 'application/json; charset=utf-8', 'json', requestData, OnValidate, false);
        }
    });
});

function InitializeControls() {
    ddlTransactionType = $("#" + controlIdPrefix + "ddlTransactionType");
    ddlTransactionCategory = $("#" + controlIdPrefix + "ddlTransactionCategory");
    txtVendorCode = $("#" + controlIdPrefix + "txtVendorCode");
    txtVendorName = $("#" + controlIdPrefix + "txtVendorName");
    btnGetList = $("#" + controlIdPrefix + "btnGetList");
    txtDateFrom = $("#" + DatecontrolIdPrefix + "txtDateFrom");
    txtDateTo = $("#" + DatecontrolIdPrefix + "txtDateTo");
    //ddlCustomerState = $("#" + controlIdPrefix + "ddlCustomerState");
    hdnCompanyCode = $("#" + controlIdPrefix + "hdnCompanyCode");
    ddlGstCharged = $("#" + controlIdPrefix + "ddlGstCharged");
    ddlSupplyState = $("#" + controlIdPrefix + "ddlSupplyState");
    ddlBookingState = $("#" + controlIdPrefix + "ddlBookingState");
}

function OnValidate(data) {
    if ((!(WebxConvert.IsObjectNullOrEmpty(data))) && (data.d.length > 0)) {
        var result = JSON.parse(data.d)[0];
        txtVendorCode.val(result.Value);
        txtVendorName.val(result.Name);
        //if ($("#" + controlIdPrefix + "ddlTransactionType").val() == "1")
        //    GetCustomerState();
    }
    else {
        alert('Invalid Customer');
        txtVendorCode.val('');
        txtVendorName.val('');
    }
}

function AutoCompleteByAjaxVer1(eleId, url, type, contentType, dataType, prefixText, minLength, focus, select, s1, s2, eleVal, alertMsg, additionalFiltersArr, showAlert) {

    $(eleId).autocomplete({
        minLength: 3,
        source: function (request, response) {

            var requestData = {};
            requestData.searchText = request.term;

            if (!(WebxConvert.IsObjectUndefinedOrNull(additionalFiltersArr))) {
                for (var i = 0; i < additionalFiltersArr.length; i++) {
                    // requestData[additionalFiltersArr[i][0]] = additionalFiltersArr[i][1];
                }
            }
            requestData = JSON.stringify(requestData);
            $.ajax({
                minLength: minLength,
                type: type,
                contentType: contentType,
                url: url,
                dataType: dataType,
                data: requestData,
                //data: "{ '" + prefixText + "': '" + request.term + "'}",
                success: function (data) {
                    //alert(JSON.stringify(data));
                    if (data.d.length != 0) {
                        //   alert('in func');
                        var retOut = jQuery.parseJSON(data.d);
                        // alert('json obj ' + retOut);
                        response($.map(retOut, function (item) {
                            //   alert('n ' + item.Name); //yeh alert bhi aaya
                            //   alert('v ' + item.Value);
                            return {
                                label: item.Name,
                                value: item.Value
                            }
                        }));
                    } else {
                        if (showAlert)
                            alert(alertMsg);
                        $(eleId).val('');
                    }
                }
            })
        },
        open: function (event, ui) { disableACblur = true; return false; },
        close: function (event, ui) { disableACblur = false; return false; },
        focus: function (event, ui) {
            if (focus == 'v') { $(this).val(ui.item.value); }
            else if (focus == 'l') { $(this).val(ui.item.label); }
            else if (focus == 'vl') { $(this).val(ui.item.value); $("#" + eleVal).val(ui.item.label); }
            else { $(this).val(ui.item.label + " : " + ui.item.value); }
            return false;
        },
        select: function (event, ui) {
            if (select == 'v') { $(this).val(ui.item.value); $("#" + eleVal).val(ui.item.value); }
            else if (select == 'l') { $(this).val(ui.item.label); $("#" + eleVal).val(ui.item.value); }
            else if (select == 'vl') { $(this).val(ui.item.value); $("#" + eleVal).val(ui.item.label); }
            else { $(this).val(ui.item.label + " : " + ui.item.value); $("#" + eleVal).val(ui.item.value); }
            return false;
        }
    })
    .data("ui-autocomplete")._renderItem = function (ul, item) {
        var rs1, rs2;
        if (s1 == 'v') { rs1 = item.value; }
        else if (s1 == 'l') { rs1 = item.label; }
        if (s2 == 'v') { rs2 = item.value; }
        else if (s2 == 'l') { rs2 = item.label; }
        return $("<li>")
        .append("<a>" + rs1 + " : " + rs2 + "</a>")
        .appendTo(ul);
    };
}

function ValidateOnSubmit() {
    try {

        if ((ddlTransactionCategory.val() == "" || ddlTransactionCategory.val() == "0") && ddlTransactionType.val() == "1") {
            throw "Please select Transaction Category.";
        }

        if (txtVendorCode.val() == "" || txtVendorName.val() == "") {
            throw "Please select valid Vendor.";
        }

        if (CheckFromToDate(txtDateFrom, txtDateTo) == false) {
            return false;
        }
        if ((ddlGstCharged.val() == "" || ddlGstCharged.val() == "0") && ddlTransactionType.val() == "2") {
            throw "Please select GST Charged.";
        }

        if ((ddlSupplyState.val() == "" || ddlSupplyState.val() == "0") && ddlTransactionType.val() == "2") {
            throw "Please select Supply State.";
        }

        if ((ddlBookingState.val() == "" || ddlBookingState.val() == "0") && ddlTransactionType.val() == "2") {
            throw "Please select Booking State.";
        }

    }
    catch (e) {
        alert(e);
        return false;
    }
    if (ddlTransactionType.val() == "1") {
        //var final = "TransactionType=" + ddlTransactionType.val();
        //final += "&TransactionCategory=" + ddlTransactionCategory.val();
        //final += "&FromDate=" + txtDateFrom.val();
        //final += "&ToDate=" + txtDateTo.val();
        //final += "&VendorCode=" + txtVendorCode.val();
        ////final += "&CustomerState=" + ddlCustomerState.val();
        //window.location.href = './BillGenerationCriteria.aspx?' + final;
        return false;
    } else {
        var final = "TransactionType=" + ddlTransactionType.val();
        final += "&TransactionCategory=";// + ddlTransactionCategory.val();
        final += "&FromDate=" + txtDateFrom.val();
        final += "&ToDate=" + txtDateTo.val();
        final += "&VendorCode=" + txtVendorCode.val();
        final += "&GSTCharged=" + ddlGstCharged.val();
        final += "&SupplyState=" + ddlSupplyState.val();
        final += "&BookingState=" + ddlBookingState.val();
        //final += "&CustomerState=" + ddlCustomerState.val();
        window.location.href = './VendorGeneralBillGeneration.aspx?' + final;
    }
    return true;
}

function CheckFromToDate(txtDateFrom, txtDateTo) {

    var ToDay = new Date();
    var MinDate = new Date("01/01/1950");

    var FD = new Date(DateString(txtDateFrom.val()));
    var TD = new Date(DateString(txtDateTo.val()));

    var regex = new RegExp("^\s*((0?[1-9]|[12][0-9]|3[01])[/](0?[1-9]|1[012])[/](20|19)[0-9]{2})\s*$");

    if (txtDateFrom.val() == "") {
        alert("Please enter From Date");
        txtDateFrom.focus();
        return false;
    }
    else if (regex.test(txtDateFrom.val()) == false) {
        alert("The date format should be : dd/mm/yyyy");
        txtDateFrom.focus();
        return false;
    }
    else if (txtDateTo.val() == "") {

        alert("Please enter To Date");
        txtDateTo.focus();
        return false;
    }
    else if (regex.test(txtDateTo.val()) == false) {
        alert("The date format should be : dd/mm/yyyy");
        txtDateTo.focus();
        return false;

    }

    else if (TD > ToDay) {
        alert("To Date should be Less than Today");
        txtDateTo.focus();
        return false;

    }
    else if (TD < MinDate) {
        alert("To Date should be Greater than 01/01/1950");
        txtDateTo.focus();
        return false;

    }
    else if (FD > TD) {
        alert("To Date should be Greater than From Date");
        txtDateTo.focus();
        return false;
    }
}

function OnChangeBillType() {
    if (ddlTransactionType.val() == "2") {
        $("#" + controlIdPrefix + "trDate").hide();

    } else {
        $("#" + controlIdPrefix + "trDate").show();
    }
}

function GetSupplyState(strGstChargeCode) {
    var ddlSupplyState = $("#" + controlIdPrefix + "ddlSupplyState");

    $.ajax({
        type: "POST",
        async: false,
        url: "BillGenerationCriteria.aspx/GetSupplyState",
        data: "{ strVendorCode:'" + txtVendorCode.val() + "',strGstChargeCode:'" + strGstChargeCode + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            ddlSupplyState.empty();
            if (data.d != "") {
                $.each(jQuery.parseJSON(data.d), function () {
                    ddlSupplyState.append($("<option></option>").val(this['Code']).html(this['Name']));
                });
            }
        },
        error: function (msg) {
        }
    });
}

function GetBookingState(strGstChargeCode) {
    var ddlBookingState = $("#" + controlIdPrefix + "ddlBookingState");
    var strVendorCompanyCode = "";
    if (strGstChargeCode == "3")
        strVendorCompanyCode = hdnCompanyCode.val();
    else
        strVendorCompanyCode = txtVendorCode.val();

    $.ajax({
        type: "POST",
        async: false,
        url: "BillGenerationCriteria.aspx/GetBookingState",
        data: "{ strVendorCompanyCode:'" + strVendorCompanyCode + "',strGstChargeCode:'" + strGstChargeCode + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            ddlBookingState.empty();
            if (data.d != "") {
                $.each(jQuery.parseJSON(data.d), function () {
                    ddlBookingState.append($("<option></option>").val(this['Code']).html(this['Name']));
                });
            }
        },
        error: function (msg) {
        }
    });
}

function OnChangeGstCharged() {
    var ddlGstCharged = $("#" + controlIdPrefix + "ddlGstCharged");

    GetSupplyState(ddlGstCharged.val());
    GetBookingState(ddlGstCharged.val());
}

function OnChangeSupplyState() {
    
    var ddlGstCharged = $("#" + controlIdPrefix + "ddlGstCharged");
    var ddlSupplyState = $("#" + controlIdPrefix + "ddlSupplyState");
    var ddlBookingState = $("#" + controlIdPrefix + "ddlBookingState");

    if (ddlGstCharged.val() == "1" || ddlGstCharged.val() == "2") {
        ddlBookingState.val(ddlSupplyState.val());
        ddlBookingState.prop('disabled', true);
    }
	else
	{
		ddlBookingState.prop('disabled', false);
	}
}

function OnChangeBookingState() {

}