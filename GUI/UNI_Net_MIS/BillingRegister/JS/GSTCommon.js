var url;
var CurrentControlId, CurrentHiddenControlId;

function onValidateCompanyExist(e) {
    try {
        setTimeout(function () {
            CurrentControlId = $(e); CurrentHiddenControlId = $(e).parent().find("input[type=hidden]");
            hdnValid.val("1");
            if (CurrentControlId.val().trim() != "") {

                var jData = {};
                jData["CompanyName"] = CurrentControlId.val().trim();
                ExecuteAjax(serviceUrl + "/ValidateCompanyExist", jData, function (result) {
                    var data = JSON.parse(result.d)[0];
                    if (data.IsExist == false) {
                        CurrentControlId.val("").focus();
                        $("#" + CurrentControlId.attr("id").replace("txt", "hdn")).val("");
                        alert("Invalid Company Name!");
                    }
                    else {
                        CurrentControlId.val(data.Name);
                        $(CurrentHiddenControlId).val(data.Code);
                    }
                }, null, true, "POST");
            }
        }, 200);
    }
    catch (e) {
        alert(e.message);
        return false;
    }
}

function onValidateCustomerExist(e) {
    try {
        setTimeout(function () {
            CurrentControlId = $(e); CurrentHiddenControlId = $(e).parent().find("input[type=hidden]");
            hdnValid.val("1");
            if (CurrentControlId.val().trim() != "") {

                var jData = {};
                jData["CustomerName"] = CurrentHiddenControlId.val().trim();
                ExecuteAjax(serviceUrl + "/ValidateCustomerExist", jData, function (result) {
                    var data = JSON.parse(result.d)[0];
                    if (data.IsExist == false) {
                        CurrentControlId.val("").focus();
                        $("#" + CurrentControlId.attr("id").replace("txt", "hdn")).val("");
                        alert("Invalid Customer Name!");
                    }
                    else {
                        CurrentControlId.val(data.Name);
                        $(CurrentHiddenControlId).val(data.Code);
                    }
                }, null, true, "POST");
            }
        }, 200);
    }
    catch (e) {
        alert(e.message);
        return false;
    }
}

function onValidateVendorExist(e) {
    try {
        setTimeout(function () {
            CurrentControlId = $(e); CurrentHiddenControlId = $(e).parent().find("input[type=hidden]");
            hdnValid.val("1");
            if (CurrentControlId.val().trim() != "") {

                var jData = {};
                jData["VendorName"] = CurrentControlId.val().trim();
                ExecuteAjax(serviceUrl + "/ValidateVendorExist", jData, function (result) {
                    var data = JSON.parse(result.d)[0];
                    if (data.IsExist == false) {
                        CurrentControlId.val("").focus();
                        $("#" + CurrentControlId.attr("id").replace("txt", "hdn")).val("");
                        alert("Invalid Vendor Name!");
                    }
                    else {
                        CurrentControlId.val(data.Name);
                        $(CurrentHiddenControlId).val(data.Code);
                    }
                }, null, true, "POST");
            }
        }, 200);
    }
    catch (e) {
        alert(e.message);
        return false;
    }
}

function onValidateStateExist(e, checkStateType) {
    try {
        setTimeout(function () {
            CurrentControlId = $(e); CurrentHiddenControlId = $(e).parent().find("input[type=hidden]");
            if (CurrentControlId.val().trim() != "") {
                var jData = {};
                jData["stateName"] = CurrentControlId.val().trim();

                if (checkStateType) {
                    jData["stateType"] = $(CurrentControlId).closest("tr").find("select[id*=ddlStatetype]").val();
                } else { jData["stateType"] = ""; }

                ExecuteAjax(serviceUrl + "/ValidateStateExist", jData, function (result) {
                    var data = JSON.parse(result.d)[0];
                    if (data.IsExist == false) {
                        CurrentControlId.val("").focus();
                        $("#" + CurrentControlId.attr("id").replace("txt", "hdn")).val("");
                        alert("Invalid State Name!");
                    }
                    else {
                        CurrentControlId.val(data.Name);
                        $(CurrentHiddenControlId).val(data.Code);
                        if (CurrentControlId.closest("tr").length > 0 && CurrentControlId.closest("tr").find("input[id$=txtCity],input[id$=hdnCityCode],input[id$=txtLocation],input[id$=hdnLocationCode],input[id$=txtProvisionalNumber],input[id$=txtGSTTiNumber]").length > 0) {
                            CurrentControlId.closest("tr").find("textarea[id$=txtAddress],input[id$=hdnAddress],input[id$=txtCity],input[id$=hdnCityCode],input[id$=txtLocation],input[id$=hdnLocationCode],input[id$=txtProvisionalNumber],input[id$=txtGSTTiNumber]").val("");
                        }
                    }
                }, null, true, "POST");
            }
        }, 200);
    }
    catch (e) {
        alert(e.message);
        return false;
    }
}

function onValidateCityExist(e, stateCode) {
    try {
        setTimeout(function () {
            CurrentControlId = $(e); CurrentHiddenControlId = $(e).parent().find("input[type=hidden]");
            if (CurrentControlId.val().trim() != "") {
                var jData = {};
                jData["CityName"] = CurrentControlId.val().trim();
                if (stateCode != undefined) {
                    jData["StateCode"] = $('#' + stateCode).val();
                } else { jData["StateCode"] = ""; }


                ExecuteAjax(serviceUrl + "/ValidateCityExist", jData, function (result) {
                    var data = JSON.parse(result.d)[0];
                    if (data.IsExist == false) {
                        CurrentControlId.val("").focus();
                        $("#" + CurrentControlId.attr("id").replace("txt", "hdn")).val("");
                        alert("Invalid City Name!");
                    }
                    else {
                        CurrentControlId.val(data.Name);
                        $(CurrentHiddenControlId).val(data.Code);

                        if (CurrentControlId.closest("tr").length > 0 && CurrentControlId.closest("tr").find("input[id$=txtLocation]").length > 0) {
                            CurrentControlId.closest("tr").find("input[id$=txtLocation],input[id$=hdnLocationCode]").val("");
                        }
                    }
                }, null, true, "POST");
            }
        }, 200);
    }
    catch (e) {
        alert(e.message);
        return false;
    }
}

function onValidateLocationExist(e) {
    try {
        setTimeout(function () {
            CurrentControlId = $(e); CurrentHiddenControlId = $(e).parent().find("input[type=hidden]");
            if (CurrentControlId.val().trim() != "") {
                var jData = {};
                jData["LocationName"] = CurrentControlId.val().trim();
                ExecuteAjax(serviceUrl + "/ValidateLocationExist", jData, function (result) {
                    var data = JSON.parse(result.d)[0];
                    if (data.IsExist == false) {
                        CurrentControlId.val("").focus();
                        $("#" + CurrentControlId.attr("id").replace("txt", "hdn")).val("");
                        alert("Invalid Location Name!");
                    }
                    else {
                        CurrentControlId.val(data.Code);
                        $(CurrentHiddenControlId).val(data.Code);
                    }
                }, null, true, "POST");
            }
        }, 200);
    }
    catch (e) {
        alert(e.message);
        return false;
    }
}

//commented on 04-jul-2017, to provide one textbox for both Provisional / GSTIN Number.
/*
function onValidateCGSTNumberExist(e, category, code) {
    try {
        setTimeout(function () {
            CurrentControlId = $(e); CurrentHiddenControlId = $(e).parent().find("input[type=hidden]");
            if (CurrentControlId.val().trim() != "") {
                var jData = {};
                jData["CGSTNumber"] = CurrentControlId.val().trim();
                jData["Category"] = category;
                jData["Code"] = code;
                ExecuteAjax(serviceUrl + "/ValidateCGSTNumberExist", jData, function (result) {
                    var data = JSON.parse(result.d)[0];
                    if (data.IsExist == true) {
                        CurrentControlId.val("").focus();
                        //$("#" + CurrentControlId.attr("id").replace("txt", "hdn")).val("");
                        alert("Provisional ID Number Already Exist!");
                    }
                    //else {
                    //    CurrentControlId.val(data.Name);
                    //    $(CurrentHiddenControlId).val(data.Code);
                    //}
                }, null, true, "POST");
            }
        }, 200);
    }
    catch (e) {
        alert(e.message);
        return false;
    }
}
*/

function onValidateIGSTNumberExist(e, category, code) {
    try {
        setTimeout(function () {
            CurrentControlId = $(e); CurrentHiddenControlId = $(e).parent().find("input[type=hidden]");
            if (CurrentControlId.val().trim() != "") {
                if (IsValidGSTINNumber(CurrentControlId)) {
                    var jData = {};
                    jData["IGSTNumber"] = CurrentControlId.val().trim();
                    jData["Category"] = category;
                    jData["Code"] = code;
                    ExecuteAjax(serviceUrl + "/ValidateIGSTNumberExist", jData, function (result) {
                        var data = JSON.parse(result.d)[0];
                        if (data.IsExist == true) {
                            CurrentControlId.val("").focus();
                            //$("#" + CurrentControlId.attr("id").replace("txt", "hdn")).val("");
                            alert("Provisional / GSTIN Number Already Exist!");
                        }
                        //else {
                        //    CurrentControlId.val(data.Name);
                        //    $(CurrentHiddenControlId).val(data.Code);
                        //}
                    }, null, true, "POST");
                }
                else {//added on 04-jul-2017, for validate 16 alphanumeric Provisional / GSTIN Number.
                    alert("Please enter valid alphanumeric Provisional / GSTIN Number (maximum 16 characters).");
                    CurrentControlId.val("");
                    return false;
                }
            }
        }, 200);
    }
    catch (e) {
        alert(e.message);
        return false;
    }
}

function ExecuteAjax(url, data, fnSuccess, fnError, async, type) {
    /// <summary>To make ajax call to get/set data.</summary>
    /// <param name="url" type="String">Url to make ajax call.</param>
    /// <param name="data" type="Json">data to send with ajax call.</param>
    /// <param name="fnSuccess" type="Function">Success function of ajax call.</param>
    /// <param name="fnError" type="Function">Error function of ajax call.</param>
    try {
        //setTimeout(function () {
        $.ajax({
            type: (type != undefined && type != "" ? type : "POST"),
            url: url,
            async: (async != undefined && async ? true : false),
            data: (data != undefined && data != "" && data != "{}" ? JSON.stringify(data) : "{}"),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: (typeof (fnSuccess) == "function" ?
                function (response) {
                    fnSuccess(response);
                }
                :
                function (response) {
                }),
            error: (typeof (fnError) == "function" ?
                function (xhr, ajaxOptions, thrownError) {
                    fnError(xhr, ajaxOptions, thrownError);
                }
                :
                function (xhr, ajaxOptions, thrownError) {
                    alert(thrownError);
                })
        });
        //}, 200);
    } catch (e) {
        throw e;
    }
}

var alpha = "[ A-Za-z]";
var numeric = "[0-9]";
var alphanumeric = "[ A-Za-z0-9]";
var float = "^(?:[1-9]\d*|0)?(?:\.\d{2})?$";
var specialcharacters = /[ !@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/;
function ValidAlphaNumeric(e, charVal) {
    var keynum;
    var keyChars = /[\x00\x08]/;
    var validChars = new RegExp(charVal);
    if (window.event) {
        keynum = e.keyCode;
    }
    else if (e.which) {
        keynum = e.which;
    }
    var keychar = String.fromCharCode(keynum);
    if (!validChars.test(keychar) && !keyChars.test(keychar)) {
        return false
    } else {
        return keychar;
    }
}

//common Autocomplete method for GST Master
function AutoCompleteForGSTMaster(eleId, url, type, contentType, dataType, prefixText, focus, select, s1, s2, EvalOrtext, eleVal, alertMsg, minPrefixLength, additionalData, disableNotFoundAlert) {
    $(eleId).autocomplete({
        minLength: minPrefixLength,
        source: function (request, response) {

            var requestData, svcUrl;

            type = type.toUpperCase();
            if (type == "POST") {
                requestData = "{'" + prefixText + "': '" + request.term + "'";

                if (additionalData != undefined && additionalData != null) {
                    var addData = additionalData.split(',');
                    for (var i = 0; i < addData.length; i++) {
                        var keyval = addData[i].split('=');
                        requestData += (", '" + keyval[0] + "': '" + $('#' + keyval[1]).val() + "'");
                    }
                }
                requestData += "}";
                svcUrl = url;
            }
            else {
                svcUrl = url + "?" + prefixText + "=" + request.term;
            }

            $.ajax({
                type: type,
                contentType: contentType,
                url: svcUrl,
                dataType: dataType,
                data: requestData,
                success: function (data) {
                    if (data.d.length != 0) {
                        var retOut;
                        try {
                            retOut = jQuery.parseJSON(data.d);
                        } catch (e) { retOut = data.d; }

                        response($.map(retOut, function (item) {
                            return {
                                label: item.Name,
                                value: item.Value
                            }
                        }));
                    } else {
                        if (disableNotFoundAlert == undefined || disableNotFoundAlert == null || disableNotFoundAlert == false) {
                            alert(alertMsg);
                        }
                        $(eleId).val("");
                        $("#" + eleVal).val('');
                    }
                },
                error: function (errormessage) {
                    alert(errormessage.message);
                }
            })
        },
        open: function (event, ui) { disableACblur = true; return false; },
        close: function (event, ui) { disableACblur = false; return false; },
        focus: function (event, ui) {
            if (focus == 'v') { $(this).val(ui.item.value); }
            else if (focus == 'l') { $(this).val(ui.item.label); }
            else { $(this).val(ui.item.label + " : " + ui.item.value); }
            return false;
        },
        select: function (event, ui) {
            if (select == 'v') { $(this).val(ui.item.value); $("#" + eleVal).val(ui.item.value); }
            else if (select == 'l') { $(this).val(ui.item.label); $("#" + eleVal).val(ui.item.value); }
            else { $(this).val(ui.item.label + " : " + ui.item.value); $("#" + eleVal).val(ui.item.value); }

            if (EvalOrtext == 'v') { $("#" + eleVal).val(ui.item.value); }
            else { $("#" + eleVal).val(ui.item.label); }

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

function IsValidGSTINNumber(txtGST) {
    try {
        //var validChars = new RegExp(alphanumeric);
        var specialchars = new RegExp(specialcharacters);
        if ($(txtGST).val().trim().length > 16 ||
            specialchars.test($(txtGST).val().trim())
            //|| !validChars.test($(txtGST).val().trim())
            ) {
            return false;
        }
        return true;
    } catch (e) {
        alert(e.message);
        return false;
    }
}