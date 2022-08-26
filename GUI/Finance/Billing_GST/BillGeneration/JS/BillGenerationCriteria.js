var ddlTransactionType, ddlTransactionCategory, txtCustomerCode, txtDateFrom, txtDateTo, txtCustomerName, btnGetList, ddlCustomerState, ddlLocationState, ddlBusinessType;
var DatecontrolIdPrefix = "ctl00_MyCPH1_dtBookingDate_";
var controlIdPrefix = "ctl00_MyCPH1_";
var reqData = {};
//reqData.TrnMode = "4";
//reqData.Paybas = "2";

$(document).ready(function () {

    InitializeControls();

    AutoCompleteByAjaxVer1("[id*='txtCustomerCode']", serviceUrl + 'GetCustomer', 'POST', 'application/json; charset=utf-8', 'json', 'searchText', 2, 'vl', 'vl', 'l', 'v', txtCustomerName.id, 'No Customer found!', reqData, false);

    $(document).on("blur", "[id*='txtCustomerCode']", function () {
        if (!(WebxConvert.IsStringNullOrEmpty($(this).val()))) {
            var requestData = "{ 'customerId' : '" + $(this).val() + "'}";
            WebxCommon.invokeWebxAJAXRequest(serviceUrl + 'CheckValidCustomer', 'POST', 'application/json; charset=utf-8', 'json', requestData, OnValidate, false);
        }
    });
});

function InitializeControls() {
    ddlTransactionType = $("#" + controlIdPrefix + "ddlTransactionType");
    ddlTransactionCategory = $("#" + controlIdPrefix + "ddlTransactionCategory");
    txtCustomerCode = $("#" + controlIdPrefix + "txtCustomerCode");
    txtCustomerName = $("#" + controlIdPrefix + "txtCustomerName");
    btnGetList = $("#" + controlIdPrefix + "btnGetList");
    txtDateFrom = $("#" + DatecontrolIdPrefix + "txtDateFrom");
    txtDateTo = $("#" + DatecontrolIdPrefix + "txtDateTo");
    ddlCustomerState = $("#" + controlIdPrefix + "ddlCustomerState");
    ddlLocationState = $("#" + controlIdPrefix + "ddlLocationState");
    ddlBusinessType = $("#" + controlIdPrefix + "ddlBusinessType");
}

function OnValidate(data) {
    if ((!(WebxConvert.IsObjectNullOrEmpty(data))) && (data.d.length > 0)) {
        var result = JSON.parse(data.d)[0];
        txtCustomerCode.val(result.Value);
        txtCustomerName.val(result.Name);
        if ($("#" + controlIdPrefix + "ddlTransactionType").val() == "1")
            GetCustomerState();
    }
    else {
        alert('Invalid Customer');
        txtCustomerCode.val('');
        txtCustomerName.val('');
    }
}

function AutoCompleteByAjaxVer1(eleId, url, type, contentType, dataType, prefixText, minLength, focus, select, s1, s2, eleVal, alertMsg, additionalFiltersArr, showAlert) {

    $(eleId).autocomplete({
        minLength: 3,
        source: function (request, response) {

            var requestData = {};
            requestData.prefixText = request.term;

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

        if (txtCustomerCode.val() == "" || txtCustomerName.val() == "") {
            throw "Please select valid Customer.";
        }

        if (ddlTransactionType.val() == "1") {
            if (CheckFromToDate(txtDateFrom, txtDateTo) == false) {
                return false;
            }
        }
        if ($("#" + controlIdPrefix + "hidBusinessTypeRuleYesNo").val() == "Y") {
            if ((ddlBusinessType.val() == "" || ddlBusinessType.val() == "0") && ddlTransactionType.val() == "1") {
                throw "Please select Business Type.";
            }
        }
        if ((ddlCustomerState.val() == "" || ddlCustomerState.val() == "0") && $("#" + controlIdPrefix + "ddlTransactionType").val() == "1") {
            throw "Please select State.";
        }
        if (ddlTransactionType.val() == "1") {
            if (!GetDocketDetails())
                return false;
        }
    }
    catch (e) {
        alert(e);
        return false;
    }
    if (ddlTransactionType.val() == "1") {
        var BusinessType = "";
        if (ddlBusinessType.val() == "" || ddlBusinessType.val() == undefined)
            BusinessType = "";
        else
            BusinessType = ddlBusinessType.val();
        var final = "TransactionType=" + ddlTransactionType.val();
        final += "&TransactionCategory=" + ddlTransactionCategory.val();
        final += "&FromDate=" + txtDateFrom.val();
        final += "&ToDate=" + txtDateTo.val();
        final += "&CustomerCode=" + txtCustomerCode.val();
        final += "&CustomerState=" + ddlCustomerState.val();
        final += "&LocationState=" + ddlLocationState.val();
        final += "&BusinessType=" + BusinessType;
        window.location.href = './FreightBillGeneration.aspx?' + final;
    } else {
        var BusinessType = "";
        if (ddlBusinessType.val() == "" || ddlBusinessType.val() == undefined)
            BusinessType = "";
        else
            BusinessType = ddlBusinessType.val();
        var final = "TransactionType=" + ddlTransactionType.val();
        final += "&TransactionCategory=" + ddlTransactionCategory.val();
        final += "&FromDate=" + txtDateFrom.val();
        final += "&ToDate=" + txtDateTo.val();
        final += "&CustomerCode=" + txtCustomerCode.val();
        final += "&CustomerState=" + ddlCustomerState.val();
        final += "&LocationState=" + ddlLocationState.val();
        final += "&BusinessType=" + ddlBusinessType.val();
        window.location.href = './SupplementaryBillGeneration.aspx?' + final;
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
function GetDocketDetails() {
    var FD = new Date(DateString(txtDateFrom.val()));
    var TD = new Date(DateString(txtDateTo.val()));
    var isvalid = false;
    $.ajax({
        type: "POST",
        url: "BillGenerationCriteria.aspx/GetDocketDetails",
        data: "{ TransactionType:'" + $("#" + controlIdPrefix + "ddlTransactionType").val() + "',TransactionCategory:'" + $("#" + controlIdPrefix + "ddlTransactionCategory").val() + "',FromDate:'" + DateString(txtDateFrom.val()) + "',ToDate:'" + DateString(txtDateTo.val()) + "',CustomerCode:'" + $("#" + controlIdPrefix + "txtCustomerCode").val() + "',StateCode:'" + ddlCustomerState.val() + "',LocationState:'" + ddlLocationState.val() + "',BusinessType:'" + ddlBusinessType.val() + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function (data) {
            if (data.d != "") {
                var j = jQuery.parseJSON(data.d);
                if (j.CountFlag == "true") {
                    isvalid = true;
                }
                else {
                    alert("There is no docket available for billing against selected criteria.....");
                    isvalid = false;
                }
            } else {
                alert("There is no docket available for billing against selected criteria.....");
                isvalid = false;
            }
        },
        error: function (msg) {
            alert(msg);
            isvalid = false;
        }
    });
    return isvalid;
}
function OnChangeBillType() {
    if (ddlTransactionType.val() == "2") {
        $("#" + controlIdPrefix + "trCategory").hide();
        $("#" + controlIdPrefix + "trDate").hide();
        $("#" + controlIdPrefix + "trState").hide();
        $("#" + controlIdPrefix + "trBusinessType").hide();

    } else {
        $("#" + controlIdPrefix + "trCategory").show();
        $("#" + controlIdPrefix + "trDate").show();
        $("#" + controlIdPrefix + "trState").show();
        $("#" + controlIdPrefix + "trBusinessType").show();
    }
}
function GetCustomerState() {
    var ddlCustomerState = $("#" + controlIdPrefix + "ddlCustomerState");

    $.ajax({
        type: "POST",
        async: false,
        url: "BillGenerationCriteria.aspx/GetCustomerState",
        data: "{ customercode:'" + txtCustomerCode.val() + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            ddlCustomerState.empty();
            if (data.d != "") {
                $.each(jQuery.parseJSON(data.d), function () {
                    ddlCustomerState.append($("<option></option>").val(this['Code']).html(this['Name']));
                });
            }
        },
        error: function (msg) {
        }
    });
}
function DateString(str) {
    var arrDate = new Array();
    arrDate = str.split('/');
    return arrDate[1] + '/' + arrDate[0] + '/' + arrDate[2];
}

function Trim(TRIM_VALUE) {
    if (TRIM_VALUE.length < 1) {
        return "";
    }
    TRIM_VALUE = RTrim(TRIM_VALUE);
    TRIM_VALUE = LTrim(TRIM_VALUE);
    if (TRIM_VALUE == "") {
        return "";
    }
    else {
        return TRIM_VALUE;
    }
}