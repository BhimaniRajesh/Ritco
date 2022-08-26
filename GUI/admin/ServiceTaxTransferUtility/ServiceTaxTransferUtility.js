
var txtLegerCode, hdnLegerCode, chkCheckAll, trMRDetails, trSubmit, btnNext;
var txtCustomer, hdnCustomerCode;

$(document).ready(function () {

    txtCustomer = $("#" + controlIdPrefix + "txtCustomer");
    hdnCustomerCode = $("#" + controlIdPrefix + "hdnCustomerCode");

    AutoCompleteByAjax(txtCustomer, serviceUrl + "/GetCustomerList", "POST", "application/json; charset=utf-8", "json", "prefix", 'l', 'l', 'l', 'v', hdnCustomerCode.attr('id'), 'Invalid Customer');

    chkCheckAll = $("#" + controlIdPrefix + "chkCheckAll");
    trMRDetails = $("#" + controlIdPrefix + "trMRDetails");
    trSubmit = $("#" + controlIdPrefix + "trSubmit");
    btnNext = $("#" + controlIdPrefix + "btnNext");

    //$('.chkHeader input').click(function () {
    //    $(".chkItem input").each(function () {
    //        $(this).prop('checked', $('.chkHeader input').prop('checked'));
    //    });
    //});

    $("input[id*='txtLegerCode']").each(function () {
        var txtLegerCode = $(this);
        var hdnLegerCode = $('#' + txtLegerCode.attr('id').replace('txtLegerCode', 'hdnLegerCode'));
        AutoCompleteByAjax(txtLegerCode, serviceUrl + "/GetLegerList", "POST", "application/json; charset=utf-8", "json", "prefix", 'l', 'l', 'l', 'v', hdnLegerCode.attr('id'), 'Invalid Leger');
    });
});

//Check Customer exist or not
var txtCustomerName;
function IsExistCustomer(obj) {
    if (obj.value != "") {
        txtCustomerName = obj;
        AjaxRequestWithPostAndJson(serviceUrl + "/IsExistCustomer", JSON.stringify(obj.value), checkCustomerSuccess, errorFunction, false);
    }
    else {
        return true;
    }
}
//get customer code
function checkCustomerSuccess(data) {
    if (data != '') {
        hdnCustomerCode.val(data);
    }
    else {
        txtCustomerName.value = "";
        txtCustomerName.focus();
        alert("Invalid Customer");
        return false;
    }
}
//select all functionality
function SelectAll(id) {
    if ($(id).is(":checked")) {
        $("#tblList").find("[type='checkbox']").prop('checked', true);
    }
	else
	{
    $("#tblList").find("[type='checkbox']").prop('checked', false);
	}
}
function Checked(id, caller) {
    var chkSelect = $('#' + id.replace(caller, 'chkSelect'));
    if (!chkSelect.prop('checked')) {
        chkCheckAll.attr('checked', false);
    }
}
//check Leger exist or not
var txtLegerName;
function IsExistLeger(obj) {
    if (obj.value != "") {
        txtLegerName = obj;
        AjaxRequestWithPostAndJson(serviceUrl + "/IsExistLeger", JSON.stringify(obj.value), checkLegerSuccess, errorFunction, false);
    }
    else {
        return true;
    }
}
//get Leger code
function checkLegerSuccess(data) {
    if (data != '') {
        var hdnLegerCode = $('#' + txtLegerName.id.replace('txtLegerCode', 'hdnLegerCode'));
        var txtLegerCode = $('#' + txtLegerName.id.replace('txtLegerCode', 'txtLegerCode'));
        hdnLegerCode.val(data);

    }
    else {
        txtLegerName.value = "";
        txtLegerName.focus();
        alert("Invalid Leger");
        return false;
    }
}
//function ValidOnNext() {

//    trMRDetails.css("display", "table-row");
//    trSubmit.css("display", "table-row");
//    btnNext.prop('disabled', true);

//    return true;
//}

// Check validation
function ValidateOnSubmit() {
    try {
        var count = 0;
        try {
            $("input[id*='txtLegerCode']").each(function () {
                var txtLegerCode = $(this);
                var chkSelect = $("#" + txtLegerCode.attr('id').replace('txtLegerCode', 'chkSelect'));
                if ($(chkSelect).prop('checked')) {
                   // if (!CheckValidInput(txtLegerCode, 'Leger Code', '')) throw ('');
                    count++;
                }
            });
        }
        catch (e) {
            return false;
        }
        if (count == 0) {
            alert("Please select at least one load transaction Id");
            return false;
        }
        if (!confirm("Are you sure that entered details are correct and want to submit data?")) {
            return false;
        }
        trSubmit.css("display", "none");
        return true;
    }
    catch (e) { alert(e.message); return false; }
}
