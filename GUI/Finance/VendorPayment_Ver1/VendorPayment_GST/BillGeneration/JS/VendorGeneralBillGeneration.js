var controlIdPrefix = "ctl00_MyCPH1_";
//var txtInvoicedAtState, txtBookedAtState,DDLInvoicedAtState, DDLBookedAtState
var ddlSupplyCity, ddlBookingCity, txtInvoicedAtLocation, txtBookedAtLocation,
    lblInterState, hdnInterState, hdnSupplyState, hdnSupplyStateType, hdnBookingState, hdnBookingStateType,
    hdnInvoicedAtCity, hdnBookedAtCity, hdnInvoicedAtLocation, hdnBookedAtLocation;

var HdnVendorCode, lblVendorName;
var ddlSupplyCity, ddlBookingCity, LblInvoicedAtGSTIN, LblBookedAtGSTIN;

var lblCount, hdnCount, lblSubtotal, hdnSubtotal, lblSGST, hdnSGST, lblUGST, hdnUGST, lblCGST, hdnCGST, lblIGST,
    hdnIGST, lblGSTTotal, hdnGSTTotal, lblTotal, hdnTotal;

var grvcontrols, txtAccCode, txtDescription, hdnDescription, hdnGSTRate, hdnGSTAmount, hdnItemTotal;

var btnSubmit, hdnSysDate, hdnPastDate, txtGenerationDate, txtVendorInvoiceDate, hidCreditDays, txtDueDate,
    txtManualInvoiceNumber, hdnRegisteredYN;
var txtTdsRate, ddlTdsSection, lblTdsAmount, hdnTdsAmount;
$(document).ready(function () {
    DocumentReadyReload();
});

function DocumentReadyReload() {
    InitializeControls();
    InitAutoComplete();
    //setInterIntraState();
    //calculate_GST();
}

function InitializeControls() {

    txtGenerationDate = $("#" + controlIdPrefix + "txtGenerationDate");
    txtVendorInvoiceDate = $("#" + controlIdPrefix + "txtVendorInvoiceDate");
    hdnSysDate = $("#" + controlIdPrefix + "hdnSysDate");
    hdnPastDate = $("#" + controlIdPrefix + "hdnPastDate");
    txtDueDate = $("#" + controlIdPrefix + "txtDueDate");
    hidCreditDays = $("#" + controlIdPrefix + "hidCreditDays");
    HdnVendorCode = $("#" + controlIdPrefix + "HdnVendorCode");
    lblVendorName = $("#" + controlIdPrefix + "lblVendorName");
    txtManualInvoiceNumber = $("#" + controlIdPrefix + "txtManualInvoiceNumber");
    hdnRegisteredYN = $("#" + controlIdPrefix + "hdnRegisteredYN");

    hdnSupplyState = $("#" + controlIdPrefix + "hdnSupplyState");
    hdnSupplyStateType = $("#" + controlIdPrefix + "hdnSupplyStateType");

    hdnBookingState = $("#" + controlIdPrefix + "hdnBookingState");
    hdnBookingStateType = $("#" + controlIdPrefix + "hdnBookingStateType");

    ddlSupplyCity = $("#" + controlIdPrefix + "ddlSupplyCity");
    hdnInvoicedAtCity = $("#" + controlIdPrefix + "hdnInvoicedAtCity");
    ddlBookingCity = $("#" + controlIdPrefix + "ddlBookingCity");
    hdnBookedAtCity = $("#" + controlIdPrefix + "hdnBookedAtCity");

    txtInvoicedAtLocation = $("#" + controlIdPrefix + "txtInvoicedAtLocation");
    hdnInvoicedAtLocation = $("#" + controlIdPrefix + "hdnInvoicedAtLocation");
    txtBookedAtLocation = $("#" + controlIdPrefix + "txtBookedAtLocation");
    hdnBookedAtLocation = $("#" + controlIdPrefix + "hdnBookedAtLocation");

    txtTdsRate = $("#" + controlIdPrefix + "txtTdsRate");
    ddlTdsSection = $("#" + controlIdPrefix + "ddlTdsSection");

    ddlSupplyCity = $("#" + controlIdPrefix + "ddlSupplyCity");
    ddlBookingCity = $("#" + controlIdPrefix + "ddlBookingCity");

    LblInvoicedAtGSTIN = $("#" + controlIdPrefix + "LblInvoicedAtGSTIN");
    LblBookedAtGSTIN = $("#" + controlIdPrefix + "LblBookedAtGSTIN");

    grvcontrols = $("#" + controlIdPrefix + "grvcontrols");

    lblInterState = $("#" + controlIdPrefix + "lblInterState");
    hdnInterState = $("#" + controlIdPrefix + "hdnInterState");

    lblCount = $("#" + controlIdPrefix + "lblCount");
    hdnCount = $("#" + controlIdPrefix + "hdnCount");
    lblSubtotal = $("#" + controlIdPrefix + "lblSubtotal");
    hdnSubtotal = $("#" + controlIdPrefix + "hdnSubtotal");
    lblSGST = $("#" + controlIdPrefix + "lblSGST");
    hdnSGST = $("#" + controlIdPrefix + "hdnSGST");
    lblUGST = $("#" + controlIdPrefix + "lblUGST");
    hdnUGST = $("#" + controlIdPrefix + "hdnUGST");
    lblCGST = $("#" + controlIdPrefix + "lblCGST");
    hdnCGST = $("#" + controlIdPrefix + "hdnCGST");
    lblIGST = $("#" + controlIdPrefix + "lblIGST");
    hdnIGST = $("#" + controlIdPrefix + "hdnIGST");

    //Added TDS Section
    lblTdsAmount = $("#" + controlIdPrefix + "lblTdsAmount");
    hdnTdsAmount = $("#" + controlIdPrefix + "hdnTdsAmount");

    lblGSTTotal = $("#" + controlIdPrefix + "lblGSTTotal");
    hdnGSTTotal = $("#" + controlIdPrefix + "hdnGSTTotal");
    lblTotal = $("#" + controlIdPrefix + "lblTotal");
    hdnTotal = $("#" + controlIdPrefix + "hdnTotal");

    btnSubmit = $("#" + controlIdPrefix + "btnSubmit");
}

function InitAutoComplete() {

    //AutoCompleteByAjaxVer2(txtInvoicedAtLocation, '../../../services/WebxCommonService.asmx/LocationAutoComplate', 'POST', 'application/json; charset=utf-8', 'json',
    //              'searchText', 'l', 'l', 'l', 'v', 'v', hdnInvoicedAtLocation, 'No entries found!', 2, 'StateCode=' + hdnSupplyState.attr("id"), true);

    AutoCompleteByAjaxVer2(txtBookedAtLocation, '../../../services/WebxCommonService.asmx/LocationAutoComplate', 'POST', 'application/json; charset=utf-8', 'json',
                  'searchText', 'l', 'l', 'l', 'v', 'v', hdnBookedAtLocation, 'No entries found!', 2, 'StateCode=' + hdnBookingState.attr("id"), true);


}

function AutoCompleteByAjaxVer2(eleId, url, type, contentType, dataType, prefixText, focus, select, s1, s2, EvalOrtext, eleVal, alertMsg, minPrefixLength, additionalData, disableNotFoundAlert) {
    $(eleId).autocomplete({
        minLength: minPrefixLength,
        source: function (request, response) {

            var requestData, svcUrl;// "{ '" + prefixText + "': '" + request.term + "'}";
            //requestData = JSON.stringify(requestData);

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
                    //alert(JSON.stringify(data));
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
                        $(eleVal).val('');
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
            if (select == 'v') { $(this).val(ui.item.value); $(eleVal).val(ui.item.value); }
            else if (select == 'l') { $(this).val(ui.item.label); $(eleVal).val(ui.item.value); }
            else { $(this).val(ui.item.label + " : " + ui.item.value); $(eleVal).val(ui.item.value); }

            if (EvalOrtext == 'v') { $(eleVal).val(ui.item.value); }
            else { $(eleVal).val(ui.item.label); }

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

function OnAccCode_Selected(source, eventArgs) {
    var id = source._id;
    var txtAccCode = window.$get(id.replace("aceAccountCode", "txtAccCode"));
    var txtDescription = window.$get(id.replace("aceAccountCode", "txtDescription"));
    var hdnDescription = window.$get(id.replace("aceAccountCode", "hdnDescription"));

    var results = eval('(' + eventArgs.get_value() + ')');
    txtAccCode.value = results.Value.toUpperCase();
    txtDescription.value = results.Name.toUpperCase();
    hdnDescription.value = results.Name.toUpperCase();
}

function GetGstRate(ddlSACCode) {
    var txtGSTRate = $("#" + ddlSACCode.id.replace("ddlSACCode", "txtGSTRate"));
    var hdnGSTRate = $("#" + ddlSACCode.id.replace("ddlSACCode", "hdnGSTRate"));

    var serviceType = ddlSACCode.value.split("~");

    $.ajax({
        type: "POST",
        url: "VendorGeneralBillGeneration.aspx/GetGstRate_FromServiceType",
        data: "{ strServiceType:'" + serviceType[0] + "',strIsRegistered:'" + hdnRegisteredYN.val() + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function (data) {
            if (data.d != "") {
                var j = jQuery.parseJSON(data.d);
                txtGSTRate.val(j.GstRate);
                hdnGSTRate.val(j.GstRate);
                return true;
            } else {
                //alert("Please Enter Valid TAM No.");
                //txtCapacity.val("");
                //hdnCapacity.val("");
                return false;
            }
        },
        error: function (msg) {
            //error
        }
    });
}

function Nagative_Chk_wDecimal(obj) {
    var temp;
    temp = obj.value;
    if (temp == "") {
        alert("Value can not be blank");
        obj.focus();
        obj.value = "0.00";
        return false;
    }
    if (isNaN(temp)) {
        alert("Value should be Numeric");
        obj.value = "0.00";
        obj.focus();
        return false;
    }
    if (parseFloat(temp) < 0) {
        alert("Value should be greater than zero");
        obj.value = "0.00";
        obj.focus();
        return false;
    }
    obj.value = roundit(temp);
    return true;
}

function roundit(num) {
    var places = 2;
    if (places > 0) {
        if ((num.toString().length - num.toString().lastIndexOf('.')) > (places + 1)) {
            if (num.toString().lastIndexOf('.') < 0) {
                return num.toString() + '.00';
            }
            var rounder = Math.pow(10, places);
            return Math.round(num * rounder) / rounder;
        }
        else {
            if (num.toString().lastIndexOf('.') < 0) {
                return num.toString() + '.00';
            }
            else {
                if (num.toString().lastIndexOf('.') + 1 == num.toString().length - 1)
                    return num.toString() + '0';
                else
                    return num.toString();

            }
        }
    }
    else return Math.round(num);
}

function calculate_GST() {
    //debugger;
    var grvcontrols = document.getElementById(controlIdPrefix + 'grvcontrols');
    var gvDetailLength = parseInt(grvcontrols.rows.length);
    var txtTotAmt, txtTotGSTAmount, txtTotTotal;
    var totalfooterAmount = 0, totalfooterGstAmt = 0, totalfooterGrandTotal = 0, itemcounter = 0;
    var pref = "";
    for (var i = 2; i <= gvDetailLength - 1; i++) {
        if (i < 10)
            pref = controlIdPrefix + "grvcontrols_ctl0" + i + "_";
        else
            pref = controlIdPrefix + "grvcontrols_ctl" + i + "_";

        var txtAccCode = document.getElementById(pref + "txtAccCode");
        var txtAmt = document.getElementById(pref + "txtAmt");
        var hdnAmt = document.getElementById(pref + "hdnAmt");
        var txtGSTRate = document.getElementById(pref + "txtGSTRate");
        var txtGSTAmount = document.getElementById(pref + "txtGSTAmount");
        var txtTotal = document.getElementById(pref + "txtTotal");

        var hdnDescription = document.getElementById(pref + "hdnDescription");
        var hdnGSTRate = document.getElementById(pref + "hdnGSTRate");
        var hdnGSTAmount = document.getElementById(pref + "hdnGSTAmount");
        var hdnItemTotal = document.getElementById(pref + "hdnItemTotal");

        if (txtAccCode.value != "") {

            if (hdnRegisteredYN.val() == "Y") {
                var GstAmt = 0, totalAmt = 0;
                itemcounter++;
                GstAmt = (parseFloat(txtAmt.value == "" ? "0" : txtAmt.value) * parseFloat(hdnGSTRate.value == "" ? "0" : hdnGSTRate.value)) / 100;
                totalAmt = parseFloat(txtAmt.value == "" ? "0" : txtAmt.value) + parseFloat(GstAmt);
                totalfooterAmount = totalfooterAmount + parseFloat(txtAmt.value == "" ? "0" : txtAmt.value);
                totalfooterGstAmt = totalfooterGstAmt + parseFloat(GstAmt);
                totalfooterGrandTotal = totalfooterGrandTotal + parseFloat(totalAmt);

                txtGSTAmount.value = parseFloat(GstAmt).toFixed(2);
                hdnGSTAmount.value = parseFloat(GstAmt).toFixed(2);
                txtTotal.value = parseFloat(totalAmt).toFixed(2);
                hdnItemTotal.value = parseFloat(totalAmt).toFixed(2);
                hdnAmt.value = txtAmt.value;
            } else {

                var ReverseGstAmt = 0, Amt = 0, ReverseGstRate = 0;
                itemcounter++;

                ReverseGstRate = ((100 + parseFloat(hdnGSTRate.value == "" ? "0" : hdnGSTRate.value)) / 100);
                Amt = parseFloat(txtTotal.value == "" ? "0" : txtTotal.value) / parseFloat(ReverseGstRate);
                ReverseGstAmt = parseFloat(txtTotal.value == "" ? "0" : txtTotal.value) - parseFloat(Amt == "" ? "0" : Amt);
                totalfooterAmount = totalfooterAmount + parseFloat(Amt == "" ? "0" : Amt);
                totalfooterGstAmt = totalfooterGstAmt + parseFloat(ReverseGstAmt);
                totalfooterGrandTotal = totalfooterGrandTotal + parseFloat(txtTotal.value == "" ? "0" : txtTotal.value);

                txtGSTAmount.value = parseFloat(ReverseGstAmt).toFixed(2);
                hdnGSTAmount.value = parseFloat(ReverseGstAmt).toFixed(2);
                txtAmt.value = parseFloat(Amt).toFixed(2);
                hdnAmt.value = txtAmt.value;
                hdnItemTotal.value = txtTotal.value;
            }
        }
    }

    if (gvDetailLength < 10) {
        txtTotAmt = document.getElementById(controlIdPrefix + "grvcontrols_ctl0" + gvDetailLength + "_txtTotAmt");
        txtTotGSTAmount = document.getElementById(controlIdPrefix + "grvcontrols_ctl0" + gvDetailLength + "_txtTotGSTAmount");
        txtTotTotal = document.getElementById(controlIdPrefix + "grvcontrols_ctl0" + gvDetailLength + "_txtTotTotal");
    } else {
        txtTotAmt = document.getElementById(controlIdPrefix + "grvcontrols_ctl" + gvDetailLength + "_txtTotAmt");
        txtTotGSTAmount = document.getElementById(controlIdPrefix + "grvcontrols_ctl" + gvDetailLength + "_txtTotGSTAmount");
        txtTotTotal = document.getElementById(controlIdPrefix + "grvcontrols_ctl" + gvDetailLength + "_txtTotTotal");
    }

    lblCount.text(itemcounter);
    hdnCount.val(itemcounter);
    txtTotAmt.value = parseFloat(totalfooterAmount).toFixed(2);
    txtTotGSTAmount.value = parseFloat(totalfooterGstAmt).toFixed(2);
    txtTotTotal.value = parseFloat(totalfooterGrandTotal).toFixed(2);

    GetSummaryTransaction();

}

function responseValidateAccCode(txtAccCode) {

    txtDescription = $("#" + txtAccCode.id.replace("txtAccCode", "txtDescription"));
    hdnDescription = $("#" + txtAccCode.id.replace("txtAccCode", "hdnDescription"));

    if (txtAccCode.value == "") {
        return true;
    }

    var isvalid = false;

    $.ajax({
        type: "POST",
        url: "VendorGeneralBillGeneration.aspx/ValidateAccCode",
        data: "{ strAccCode:'" + txtAccCode.value + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function (data) {
            if (data.d != "") {
                var j = jQuery.parseJSON(data.d);

                if (j.CountFlag == "true") {
                    isvalid = true;
                    txtAccCode.value = j.AccCode;
                    txtDescription.val(j.AccDesc);
                    hdnDescription.val(j.AccDesc);
                }
                else {
                    alert("Please select valid Account Code.");
                    txtAccCode.value = "";
                    txtDescription.val("");
                    hdnDescription.val("");
                    txtAccCode.focus();
                    isvalid = false;
                }

            } else {
                alert("Please select valid Account Code.");
                txtAccCode.value = "";
                txtDescription.val("");
                hdnDescription.val("");
                txtAccCode.focus();
                isvalid = false;
            }
        },
        error: function (msg) {
            alert(msg);
            txtAccCode.focus();
            isvalid = false;
        }
    });

    return isvalid;
}

function setInterIntraState() {

    if (hdnSupplyState.val() == hdnBookingState.val()) {
        lblInterState.text("Yes");
        hdnInterState.val("Yes");
    } else {
        lblInterState.text("No");
        hdnInterState.val("No");
    }
}

function GetSummaryTransaction() {
    var grvcontrols = document.getElementById('ctl00_MyCPH1_grvcontrols');
    var gvDetailLength = parseInt(grvcontrols.rows.length);
    var txtTotAmt, txtTotGSTAmount, txtTotTotal;


    if (gvDetailLength < 10) {
        txtTotAmt = document.getElementById(controlIdPrefix + "grvcontrols_ctl0" + gvDetailLength + "_txtTotAmt");
        txtTotGSTAmount = document.getElementById(controlIdPrefix + "grvcontrols_ctl0" + gvDetailLength + "_txtTotGSTAmount");
        txtTotTotal = document.getElementById(controlIdPrefix + "grvcontrols_ctl0" + gvDetailLength + "_txtTotTotal");
    } else {
        txtTotAmt = document.getElementById(controlIdPrefix + "grvcontrols_ctl" + gvDetailLength + "_txtTotAmt");
        txtTotGSTAmount = document.getElementById(controlIdPrefix + "grvcontrols_ctl" + gvDetailLength + "_txtTotGSTAmount");
        txtTotTotal = document.getElementById(controlIdPrefix + "grvcontrols_ctl" + gvDetailLength + "_txtTotTotal");
    }

    lblSubtotal.text(txtTotAmt.value);
    hdnSubtotal.val(txtTotAmt.value);
    lblGSTTotal.text(txtTotGSTAmount.value);
    hdnGSTTotal.val(txtTotGSTAmount.value);

    //Added TDS Section
    CalculateTds();
    var totalAmount = parseFloat(txtTotTotal.value).toFixed(2) - parseFloat(hdnTdsAmount.val()).toFixed(2);
    lblTotal.text(totalAmount.toFixed(2));
    hdnTotal.val(totalAmount.toFixed(2));

    var gst, ugst = 0, sgst = 0, igst = 0, cgst = 0;
    gst = txtTotGSTAmount.value;

    if (hdnSupplyState.val() == hdnBookingState.val()) {
        lblInterState.text("Yes");
        hdnInterState.val("Yes");
    } else {
        lblInterState.text("No");
        hdnInterState.val("No");
    }

    if (hdnSupplyStateType.val() == "UT" || hdnBookingStateType.val() == "UT") {
        //ugst = gst / 2;
        ugst = gst;
        lblUGST.text("0.00");
        hdnUGST.val("0.00");
        //lblCGST.text(parseFloat(ugst).toFixed(2));
        lblSGST.text("0.00");
        hdnSGST.val("0.00");
        lblIGST.text(parseFloat(ugst).toFixed(2));
        hdnIGST.val(parseFloat(ugst).toFixed(2));
        lblCGST.text("0.00");
        hdnCGST.val("0.00");
    }
    if (hdnSupplyStateType.val() == "UT" && hdnBookingStateType.val() == "UT") {
        ugst = gst / 2;
        //ugst = gst;
        lblUGST.text(parseFloat(ugst).toFixed(2));
        hdnUGST.val(parseFloat(ugst).toFixed(2));
        lblCGST.text(parseFloat(ugst).toFixed(2));
        hdnCGST.val(parseFloat(ugst).toFixed(2));
        lblSGST.text("0.00");
        hdnSGST.val("0.00");
        lblIGST.text("0.00");
        hdnIGST.val("0.00");

    } else {
        if (hdnSupplyState.val() == hdnBookingState.val()) {
            sgst = gst / 2;
            lblSGST.text(parseFloat(sgst).toFixed(2));
            hdnSGST.val(parseFloat(sgst).toFixed(2));
            lblUGST.text("0.00");
            hdnUGST.val("0.00");
            lblCGST.text(parseFloat(sgst).toFixed(2));
            hdnCGST.val(parseFloat(sgst).toFixed(2));
            lblIGST.text("0.00");
            hdnIGST.val("0.00");
        } else {
            //igst = gst / 2;
            igst = gst;
            lblIGST.text(parseFloat(igst).toFixed(2));
            hdnIGST.val(parseFloat(igst).toFixed(2));
            //lblCGST.text(parseFloat(igst).toFixed(2));
            lblSGST.text("0.00");
            hdnSGST.val("0.00");
            lblUGST.text("0.00");
            hdnUGST.val("0.00");
            lblCGST.text("0.00");
            hdnCGST.val("0.00");
        }
    }

    GetSummaryLedgerDetails();
}

//Added TDS Section
function CalculateTds() {
    try {
        var tdsRate = parseFloat(txtTdsRate.val()).toFixed(2);
        if (tdsRate > 0) {
            var txtTotTotal, txtTotAmt, totTdsAmount;

            var grvcontrols = document.getElementById('ctl00_MyCPH1_grvcontrols');
            var gvDetailLength = parseInt(grvcontrols.rows.length);

            if (gvDetailLength < 10) {
                txtTotAmt = document.getElementById(controlIdPrefix + "grvcontrols_ctl0" + gvDetailLength + "_txtTotAmt");
                txtTotTotal = document.getElementById(controlIdPrefix + "grvcontrols_ctl0" + gvDetailLength + "_txtTotTotal");
            } else {
                txtTotAmt = document.getElementById(controlIdPrefix + "grvcontrols_ctl" + gvDetailLength + "_txtTotAmt");
                txtTotTotal = document.getElementById(controlIdPrefix + "grvcontrols_ctl" + gvDetailLength + "_txtTotTotal");
            }
            totTdsAmount = (tdsRate * parseFloat(txtTotAmt.value).toFixed(2)) / 100;

            hdnTdsAmount.val(parseFloat(totTdsAmount).toFixed(2));
            lblTdsAmount.text(hdnTdsAmount.val());
        } else {
            hdnTdsAmount.val("0.00");
            lblTdsAmount.text("0.00");
        }
    }
    catch(e)
    {
        hdnTdsAmount.val("0.00");
        lblTdsAmount.text("0.00");
    }
}

function GetSummaryLedgerDetails() {

    var isvalid = false;
    var utState = "NO";
    var utStateSame = "NO";
    if (hdnSupplyStateType.val() == "UT" || hdnBookingStateType.val() == "UT") {
        utState = "YES";
    }
    if (hdnSupplyState.val() == hdnBookingState.val()) {
        utStateSame = "YES";
    }

    $.ajax({
        type: "POST",
        url: "VendorGeneralBillGeneration.aspx/GetLedgerDetails",
        data: "{ grandtotal:'" + hdnTotal.val() + "',gsttotal:'" + hdnGSTTotal.val() + "',vendorcode:'" + HdnVendorCode.val() + "',interstateyesno:'" + hdnInterState.val() + "',billingtype:'GENERAL BILLING',utState:'" + utState + "',utStateSame:'" + utStateSame + "',tdsAmount:'" + hdnTdsAmount.val() + "',tdsSection:'" + ddlTdsSection.val() + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function (data) {
            if (data.d != "") {
                var j = jQuery.parseJSON(data.d);

                var detail = "";

                var grvcontrols = document.getElementById(controlIdPrefix + 'grvcontrols');
                var gvDetailLength = parseInt(grvcontrols.rows.length);
                var pref = "";
                var icount = 0;
                //var detailAcc = "";
                for (var it = 2; it <= gvDetailLength - 1; it++) {
                    if (it < 10)
                        pref = controlIdPrefix + "grvcontrols_ctl0" + it + "_";
                    else
                        pref = controlIdPrefix + "grvcontrols_ctl" + it + "_";

                    var txtAccCode = document.getElementById(pref + "txtAccCode");
                    var txtDescription = document.getElementById(pref + "txtDescription");
                    var txtAmt = document.getElementById(pref + "txtAmt");
                    //var txtGSTRate = document.getElementById(pref + "txtGSTRate");
                    //var txtGSTAmount = document.getElementById(pref + "txtGSTAmount");
                    //var txtTotal = document.getElementById(pref + "txtTotal");

                    if (txtAccCode.value != "" && parseFloat(txtAmt.value) > 0) {
                        icount++;
                        detail += "<tr class='nrow'>";
                        detail += "<td class='text-left'><label id='lblAccCode'>" + txtAccCode.value + ":" + txtDescription.value + "</label></td>";
                        detail += "<td class='text-center'><label id='lblVendorName'>" + lblVendorName.text() + "</label></td>";
                        detail += "<td class='text-right'><label id='lblDebit'>" + txtAmt.value + "</label></td>";
                        detail += "<td class='text-right'><label id='lblCredit'>0.00</label></td>";
                        detail += "</tr>";
                    }
                }
                if (icount > 0) {
                    if (j.ListItems.length > 0) {

                        for (var i = 0; i < j.ListItems.length; i++) {
                            detail += "<tr class='nrow'>";
                            detail += "<td class='text-left'><label id='lblAccCode'>" + j.ListItems[i].Ledger + "</label></td>";
                            detail += "<td class='text-center'><label id='lblVendorName'>" + j.ListItems[i].SubLedger + "</label></td>";
                            detail += "<td class='text-right'><label id='lblDebit'>" + j.ListItems[i].Debit + "</label></td>";
                            detail += "<td class='text-right'><label id='lblCredit'>" + j.ListItems[i].Credit + "</label></td>";
                            detail += "</tr>";
                        }
                        //$("#tblLedgerPosting>tbody").html(detail);
                    }
                }

                $("#tblLedgerPosting>tbody").html(detail);

            } else {
                //alert("Issue occurred in Ledger Details.");
                isvalid = false;
            }
        },
        error: function (msg) {
            alert(msg);
            txtAccCode.focus();
            isvalid = false;
        }
    });

    return isvalid;
}

function ValidateOnSubmit() {
    btnSubmit.hide();
    try {

        //if (txtManualInvoiceNumber.val() == "") {
        //    alert("Please Enter Manual Invoice Number.");
        //    txtManualInvoiceNumber.focus();
        //    btnSubmit.show();
        //    return false;
        //}

        if (txtGenerationDate.val() == "") {
            alert("Please Select Invoice Booking Date.");
            txtGenerationDate.focus();
            btnSubmit.show();
            return false;
        }

        if (txtVendorInvoiceDate.val() == "") {
            alert("Please Select Vendor Invoice Date.");
            txtVendorInvoiceDate.focus();
            btnSubmit.show();
            return false;
        }

        var voo = true;
        voo = isValidDate(txtGenerationDate.val(), 'Invoice Booking Date ');
        if (!voo) {
            txtGenerationDate.focus();
            btnSubmit.show();
            return false;
        }

        var booPast = true;
        if (MyDateCompare(hdnPastDate.val(), txtGenerationDate.val()) < 0) booPast = false;
        if (!booPast) {
            alert("Invoice Booking Date cannot be less than : " + hdnPastDate.val());
            txtGenerationDate.focus();
            btnSubmit.show();
            return false;
        }

        var booFuture = true;
        if (MyDateCompare(hdnSysDate.val(), txtGenerationDate.val()) > 0) booFuture = false;
        if (!booFuture) {
            alert("Invoice Booking Date cannot be greater than System Date: " + hdnSysDate.val());
            txtGenerationDate.focus();
            btnSubmit.show();
            return false;
        }

        var vooVI = true;
        vooVI = isValidDate(txtVendorInvoiceDate.val(), 'Vendor Invoice Date ');
        if (!vooVI) {
            txtVendorInvoiceDate.focus();
            btnSubmit.show();
            return false;
        }

        var booVIPast = true;
        if (MyDateCompare(hdnPastDate.val(), txtVendorInvoiceDate.val()) < 0) booVIPast = false;
        if (!booVIPast) {
            alert("Vendor Invoice Date cannot be less than : " + hdnPastDate.val());
            txtVendorInvoiceDate.focus();
            btnSubmit.show();
            return false;
        }

        var booVIFuture = true;
        if (MyDateCompare(hdnSysDate.val(), txtVendorInvoiceDate.val()) > 0) booVIFuture = false;
        if (!booVIFuture) {
            alert("Vendor Invoice Date cannot be greater than System Date: " + hdnSysDate.val());
            txtVendorInvoiceDate.focus();
            btnSubmit.show();
            return false;
        }

        if (hdnSupplyState.val() == "") {
            alert("Vendor State is invalid.");
            btnSubmit.show();
            return false;
        }

        if (hdnBookingState.val() == "") {
            alert("Booking State is invalid.");
            btnSubmit.show();
            return false;
        }

        if (ddlSupplyCity.val() == "") {
            alert("Please select Vendor City.");
            btnSubmit.show();
            return false;
        }

        if (ddlBookingCity.text() == "") {
            alert("Please select Booking City.");
            btnSubmit.show();
            return false;
        }

        if (hdnRegisteredYN.val() == "Y") {

            if (LblInvoicedAtGSTIN.text() == "") {
                alert("Vendor GSTIN is not valid.");
                btnSubmit.show();
                return false;
            }

            //if (LblBookedAtGSTIN.text() == "") {
            //    alert("Booking GSTIN is not valid.");
            //    btnSubmit.show();
            //    return false;
            //}
        }

        var grvcontrols = document.getElementById(controlIdPrefix + 'grvcontrols');
        var gvDetailLength = parseInt(grvcontrols.rows.length);
        var txtTotAmt, txtTotGSTAmount, txtTotTotal;
        var totalfooterAmount = 0, totalfooterGstAmt = 0, totalfooterGrandTotal = 0, itemcounter = 0;
        var pref = "";
        for (var i = 2; i <= gvDetailLength - 1; i++) {
            if (i < 10)
                pref = controlIdPrefix + "grvcontrols_ctl0" + i + "_";
            else
                pref = controlIdPrefix + "grvcontrols_ctl" + i + "_";

            var txtAccCode = document.getElementById(pref + "txtAccCode");
            var txtAmt = document.getElementById(pref + "txtAmt");
            var txtGSTRate = document.getElementById(pref + "txtGSTRate");
            var txtGSTAmount = document.getElementById(pref + "txtGSTAmount");
            var txtTotal = document.getElementById(pref + "txtTotal");
            var hdnItemTotal = document.getElementById(pref + "hdnItemTotal");

            if (txtAccCode.value != "") {
                var GstAmt = 0, totalAmt = 0;
                itemcounter++;

                var foo = true;
                foo = responseValidateAccCode(txtAccCode);
                if (!foo) {
                    txtAccCode.focus();
                    btnSubmit.show();
                    return false;
                }

                if (txtAmt.value == "" || parseFloat(txtAmt.value) == 0) {
                    alert("Please enter valid Amount");
                    txtAmt.focus();
                    btnSubmit.show();
                    return false;
                }

                if (hdnItemTotal.value == "" || parseFloat(hdnItemTotal.value) == 0) {
                    alert("Invalid Total Amount");
                    txtAmt.focus();
                    btnSubmit.show();
                    return false;
                }
            }
        }

        if (itemcounter == 0) {
            alert("Please enter at least one account code.");
            btnSubmit.show();
            return false;
        }
        //Added TDS Section
        if (parseFloat(txtTdsRate.val()).toFixed(2) > 0) {
            if (ddlTdsSection.val() == "0") {
                alert("Select TDS Section.")
                ddlTdsSection.focus();
                btnSubmit.show();
                return false;
            }
        }
        return true;
    } catch (err) {
        alert(err.message);
        btnSubmit.show();
        return false;
    }
}

function MyDateCompare(startDt, endDt) {
    var startDtArr;
    var endDtArr;

    startDtArr = startDt.split('/');
    endDtArr = endDt.split('/');

    var myStartDt = new Date(startDtArr[2], startDtArr[1] - 1, startDtArr[0]);
    var myEndDt = new Date(endDtArr[2], endDtArr[1] - 1, endDtArr[0]);
    var dtDiff = myEndDt.getTime() - myStartDt.getTime();

    dtDiff = dtDiff / 86400000;


    if (Trim(startDt) == Trim(endDt)) {
        dtDiff = 0;
    }
    //alert(dtDiff);
    return dtDiff;
}

function ValidateDateOnBlur() {
    if (txtGenerationDate.val() != "") {
        var voo = true;
        voo = isValidDate(txtGenerationDate.val(), 'Invoice Booking Date ');
        if (!voo) {
            txtGenerationDate.val("");
            txtGenerationDate.focus();
            return false;
        }

        var booPast = true;
        if (MyDateCompare(hdnPastDate.val(), txtGenerationDate.val()) < 0) booPast = false;
        if (!booPast) {
            alert("Invoice Booking Date cannot be less than : " + hdnPastDate.val());
            txtGenerationDate.val("");
            txtGenerationDate.focus();
            return false;
        }

        var booFuture = true;
        if (MyDateCompare(hdnSysDate.val(), txtGenerationDate.val()) > 0) booFuture = false;
        if (!booFuture) {
            alert("Invoice Booking Date cannot be greater than System Date: " + hdnSysDate.val());
            txtGenerationDate.val("");
            btnSubmit.show();
            return false;
        }
    }

    if (txtVendorInvoiceDate.val() != "") {

        var vooVI = true;
        vooVI = isValidDate(txtVendorInvoiceDate.val(), 'Vendor Invoice Date ');
        if (!vooVI) {
            txtVendorInvoiceDate.val("");
            txtVendorInvoiceDate.focus();
            return false;
        }

        var booVIPast = true;
        if (MyDateCompare(hdnPastDate.val(), txtVendorInvoiceDate.val()) < 0) booVIPast = false;
        if (!booVIPast) {
            alert("Vendor Invoice Date cannot be less than : " + hdnPastDate.val());
            txtVendorInvoiceDate.val("");
            txtVendorInvoiceDate.focus();
            return false;
        }

        var booVIFuture = true;
        if (MyDateCompare(hdnSysDate.val(), txtVendorInvoiceDate.val()) > 0) booVIFuture = false;
        if (!booVIFuture) {
            alert("Vendor Invoice Date cannot be greater than System Date: " + hdnSysDate.val());
            txtVendorInvoiceDate.val("");
            btnSubmit.show();
            return false;
        }

        var invDtArr;

        invDtArr = txtVendorInvoiceDate.val().split('/');

        var myInvDt = new Date(invDtArr[2], invDtArr[1] - 1, invDtArr[0]);
        //var dtDiff = myEndDt.getTime() - myInvDt.getTime();
        var duedate = new Date(myInvDt);
        duedate.setDate(duedate.getDate() + parseInt(hidCreditDays.val(), 10));

        var dd = duedate.getDate();
        var mm = duedate.getMonth() + 1;
        var y = duedate.getFullYear();

        var someFormattedDate = dd + '/' + mm + '/' + y;

        txtDueDate.val(someFormattedDate);
    }
    return true;
}

function isValidDate(dateStr, str) {
    var datePat = /^(\d{1,2})(\/|-)(\d{1,2})\2(\d{4})$/; // requires 4 digit year
    var matchArray = dateStr.match(datePat); // is the format ok?
    if (matchArray == null) {
        alert("Please Enter " + str + " Date in dd/mm/yyyy Format");
        return false;
    }

    month = matchArray[3]; // parse date into variables
    day = matchArray[1];
    year = matchArray[4];


    if (month < 1 || month > 12) { // check month range
        alert("In " + str + "Date Month must be between 1 and 12.");
        return false;
    }

    if (day < 1 || day > 31) {
        alert("In " + str + "Day must be between 1 and 31.");
        return false;
    }

    if ((month == 4 || month == 6 || month == 9 || month == 11) && day == 31) {
        alert("In " + str + "Month " + month + " doesn't have 31 days!")
        return false
    }

    if (month == 2) { // check for february 29th
        var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));

        if (day > 29 || (day == 29 && !isleap)) {
            alert("In " + str + "February " + year + " doesn't have " + day + " days!");
            return false;
        }
    }
    return true; // date is valid
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

function RTrim(VALUE) {
    var w_space = String.fromCharCode(32);
    var v_length = VALUE.length;
    var strTemp = "";
    if (v_length < 0) {
        return "";
    }
    var iTemp = v_length - 1;

    while (iTemp > -1) {
        if (VALUE.charAt(iTemp) == w_space) {
        }
        else {
            strTemp = VALUE.substring(0, iTemp + 1);
            break;
        }
        iTemp = iTemp - 1;

    } //End While
    return strTemp;
} //End Function

function LTrim(VALUE) {
    var w_space = String.fromCharCode(32);
    if (v_length < 1) {
        return "";
    }
    var v_length = VALUE.length;
    var strTemp = "";

    var iTemp = 0;

    while (iTemp < v_length) {
        if (VALUE.charAt(iTemp) == w_space) {
        }
        else {
            strTemp = VALUE.substring(iTemp, v_length);
            break;
        }
        iTemp = iTemp + 1;
    } //End While
    return strTemp;
} //End Function
