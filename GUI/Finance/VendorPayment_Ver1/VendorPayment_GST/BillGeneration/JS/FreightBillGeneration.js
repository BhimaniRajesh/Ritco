var Count, subTotal, gstTotal, total;
var controlIdPrefix = "ctl00_MyCPH1_";
var txtBillGenerationState, txtBillSubmissionState, txtBillCollectionState, txtBillGenerationCity, txtBillSubmissionCity, txtBillCollectionCity,
    txtBillGenerationLocation, txtBillSubmissionLocation, txtBillCollectionLocation, lblInterState, hdnInterState,
    hdnBillGenerationState, hdnBillGenerationStateType, hdnBillSubmissionState, hdnBillSubmissionStateType, hdnBillCollectionState,
    hdnBillCollectionStateType, hdnBillGenerationCity, hdnBillSubmissionCity, hdnBillCollectionCity,
    hdnBillGenerationLocation, hdnBillSubmissionLocation, hdnBillCollectionLocation;
var lblCount, lblSubtotal, hdnSubtotal, lblSGST, hdnSGST, lblUGST, hdnUGST, lblCGST, hdnCGST, lblIGST, hdnIGST, lblGSTTotal, hdnGSTTotal, lblTotal, hdnTotal;
var grvcontrols, txtAccCode, txtDescription;
var UTInterState = "";

function rounditn(Num, decplaces) {
    Places = decplaces
    if (Places > 0) {
        if ((Num.toString().length - Num.toString().lastIndexOf('.')) > (Places + 1)) {
            if (Num.toString().lastIndexOf('.') < 0) {
                return Num.toString() + '.00';
            }
            var Rounder = Math.pow(10, Places);
            return Math.round(Num * Rounder) / Rounder;
        }
        else {
            if (Num.toString().lastIndexOf('.') < 0) {
                return Num.toString() + '.00';
            }
            else {
                if (Num.toString().lastIndexOf('.') + 1 == Num.toString().length - 1)
                    return Num.toString() + '0';
                else
                    return Num.toString();
            }
        }
    }
    else return Math.round(Num);
}

$(function () {
    $(".DocketSummaryHeader").hide(); 1
    $(".DocketSummary").hide();
    $(".LedgerSummaryHeader").hide();
    $(".LedgerSummary").hide();
});

function SelectAll() {
    $("input[id*='chkSelect']").prop("checked", $("input[id*='chkAllSelect']").prop("checked"));
    OnCheck();
}

function OnCheck() {
    Count = 0, subTotal = 0, gstTotal = 0, total = 0;
    Count = $("input[id*='chkSelect']:checked").length;
    if (parseFloat(Count) > 0) {
        $(".DocketSummaryHeader").show();
        $(".DocketSummary").show();
        $(".LedgerSummaryHeader").show();
        $(".LedgerSummary").show();
    }
    else {
        $(".DocketSummaryHeader").hide();
        $(".DocketSummary").hide();
        $(".LedgerSummaryHeader").hide();
        $(".LedgerSummary").hide();
    }
    if ($("input[id*='chkSelect']").length == Count) {
        $("input[id*='chkAllSelect']").attr("checked", "checked");
    }
    else {
        $("input[id*='chkAllSelect']").removeAttr("checked");
    }
    $("input[id*='chkSelect']").each(function (i, e) {
        if (e.checked) {
            subTotal = subTotal + parseFloat($(e).parentsUntil("tr").parent().find("span[id*='lblSubTotal']").text());
            gstTotal = gstTotal + parseFloat($(e).parentsUntil("tr").parent().find("span[id*='lblGSTAmount']").text());
            total = total + parseFloat($(e).parentsUntil("tr").parent().find("span[id*='lblTotal']").text());
        }
    });
    $(".count").text(Count);
    $(".subTotal").text(subTotal.toFixed(2));
    $(".gstTotal").text(gstTotal.toFixed(2));
    $(".total").text(total.toFixed(2));
    $("input[id*='hdCount']").val(Count);
    $("input[id*='hdsubTotal']").val(subTotal.toFixed(2));
    $("input[id*='hdgstTotal']").val(gstTotal.toFixed(2));
    $("input[id*='hdtotal']").val(total.toFixed(2));
    var hidSGST = $("#" + controlIdPrefix + "hidSGST").val();
    var hidUTGST = $("#" + controlIdPrefix + "hidUTGST").val();
    var hidCGST = $("#" + controlIdPrefix + "hidCGST").val();
    var hidIGST = $("#" + controlIdPrefix + "hidIGST").val();
    var hidUTGSTNo = $("#" + controlIdPrefix + "hidUTGSTNo").val();
    if ($("#" + controlIdPrefix + "hidBillGenerationStateType").val() == "UT" || $("#" + controlIdPrefix + "hidBillSubmissionStateType").val() == "UT") {
        UTInterState = "YES";
        if ($("#" + controlIdPrefix + "hidBillGenerationState").val() == $("#" + controlIdPrefix + "hidBillSubmissionState").val()) {
            $("#" + controlIdPrefix + "lblInterState").text('Yes');
            $("#" + controlIdPrefix + "hidInterState").val('Yes');
            $("#" + controlIdPrefix + "lblSummaryUTGST").text((gstTotal * parseFloat(hidUTGSTNo)).toFixed(2));
            $("#" + controlIdPrefix + "hidSummaryUTGST").val((gstTotal * parseFloat(hidUTGSTNo)).toFixed(2));
            $("#" + controlIdPrefix + "lblSummaryIGST").text('0.00');
            $("#" + controlIdPrefix + "hidSummaryIGST").val('0.00');
            $("#" + controlIdPrefix + "lblSummarySGST").text('0.00');
            $("#" + controlIdPrefix + "hidSummarySGST").val('0.00');
            $("#" + controlIdPrefix + "lblSummaryCGST").text((gstTotal * parseFloat(hidCGST)).toFixed(2));
            $("#" + controlIdPrefix + "hidSummaryCGST").val((gstTotal * parseFloat(hidCGST)).toFixed(2));
        } else {
            $("#" + controlIdPrefix + "lblInterState").text('No');
            $("#" + controlIdPrefix + "hidInterState").val('No');
            $("#" + controlIdPrefix + "lblSummaryUTGST").text('0.00');
            $("#" + controlIdPrefix + "hidSummaryUTGST").val('0.00');
            $("#" + controlIdPrefix + "lblSummaryIGST").text((gstTotal * parseFloat(hidUTGST)).toFixed(2));
            $("#" + controlIdPrefix + "hidSummaryIGST").val((gstTotal * parseFloat(hidUTGST)).toFixed(2));
            $("#" + controlIdPrefix + "lblSummarySGST").text('0.00');
            $("#" + controlIdPrefix + "hidSummarySGST").val('0.00');
            $("#" + controlIdPrefix + "lblSummaryCGST").text('0.00');
            $("#" + controlIdPrefix + "hidSummaryCGST").val('0.00');
        }
    } else {
        UTInterState = "NO";
        if ($("#" + controlIdPrefix + "lblInterState").text() == "Yes") {
            $("#" + controlIdPrefix + "lblSummarySGST").text((gstTotal * parseFloat(hidSGST)).toFixed(2));
            $("#" + controlIdPrefix + "lblSummaryCGST").text((gstTotal * parseFloat(hidCGST)).toFixed(2));
            $("#" + controlIdPrefix + "lblSummaryIGST").text('0.00');
            $("#" + controlIdPrefix + "hidSummarySGST").val((gstTotal * parseFloat(hidSGST)).toFixed(2));
            $("#" + controlIdPrefix + "hidSummaryCGST").val((gstTotal * parseFloat(hidCGST)).toFixed(2));
            $("#" + controlIdPrefix + "hidSummaryIGST").val('0.00');
            $("#" + controlIdPrefix + "lblSummaryUTGST").text('0.00');
            $("#" + controlIdPrefix + "hidSummaryUTGST").val('0.00');
        } else {
            $("#" + controlIdPrefix + "lblSummaryIGST").text((gstTotal * parseFloat(hidIGST)).toFixed(2));
            $("#" + controlIdPrefix + "hidSummaryIGST").val((gstTotal * parseFloat(hidIGST)).toFixed(2));
            $("#" + controlIdPrefix + "lblSummarySGST").text('0.00');
            $("#" + controlIdPrefix + "lblSummaryCGST").text('0.00');
            $("#" + controlIdPrefix + "hidSummarySGST").val('0.00');
            $("#" + controlIdPrefix + "hidSummaryCGST").val('0.00');
            $("#" + controlIdPrefix + "lblSummaryUTGST").text('0.00');
            $("#" + controlIdPrefix + "hidSummaryUTGST").val('0.00');
        }
    }
    if (parseFloat(Count) > 0) {
        GetSummaryLedgerDetails();
    }
}

function OnChangeState(type) {
    if (type == "1") {
        var cityData = "", cityCode = "", cityName = "";
        var ddlBillGenerationStateCode = $("#" + controlIdPrefix + "ddlBillGenerationState").val();
        if (ddlBillGenerationStateCode != "" && ddlBillGenerationStateCode != "0") {
            var BillGenerationStateCode = ddlBillGenerationStateCode.split("~");
            var stateCode = BillGenerationStateCode[0];
            var city = BillGenerationStateCode[1];
            if (city != "") {
                cityData = city.split("^");
                cityCode = cityData[0];
                cityName = cityData[1];
            }
            var GSTINNumber = BillGenerationStateCode[2];
            var StateType = BillGenerationStateCode[3];
            $("#" + controlIdPrefix + "hidBillGenerationState").val(stateCode);
            $("#" + controlIdPrefix + "lblBillGenerationCity").text(cityName);
            $("#" + controlIdPrefix + "hdnBillGenerationCity").val(cityCode);
            $("#" + controlIdPrefix + "hdnBillGenerationCityName").val(cityName);
            $("#" + controlIdPrefix + "lblBillGenerationGSTIN").text(GSTINNumber);
            $("#" + controlIdPrefix + "hdnBillGenerationGSTINNumber").val(GSTINNumber);
            $("#" + controlIdPrefix + "hidBillGenerationStateType").val(StateType);
        } else {
            $("#" + controlIdPrefix + "hidBillGenerationState").val('');
            $("#" + controlIdPrefix + "lblBillGenerationCity").text('');
            $("#" + controlIdPrefix + "hdnBillGenerationCity").val('');
            $("#" + controlIdPrefix + "hdnBillGenerationCityName").val('');
            $("#" + controlIdPrefix + "lblBillGenerationGSTIN").text('');
            $("#" + controlIdPrefix + "hdnBillGenerationGSTINNumber").val('');
            $("#" + controlIdPrefix + "hidBillGenerationStateType").val('');
        }
    }
    //if (type == "2") {
    //    var cityData = "", cityCode = "", cityName = "";
    //    var ddlBillSubmissionStateCode = $("#" + controlIdPrefix + "ddlBillSubmissionState").val();
    //    if (ddlBillSubmissionStateCode != "" && ddlBillSubmissionStateCode != "0") {
    //        var BillSubmissionStateCode = ddlBillSubmissionStateCode.split("~");
    //        var stateCode = BillSubmissionStateCode[0];
    //        var city = BillSubmissionStateCode[1];
    //        if (city != "") {
    //            cityData = city.split("^");
    //            cityCode = cityData[0];
    //            cityName = cityData[1];
    //        }
    //        var GSTINNumber = BillSubmissionStateCode[2];
    //        var StateType = BillSubmissionStateCode[3];
    //        var BillingAddressStateWise = BillSubmissionStateCode[4];
    //        $("#" + controlIdPrefix + "hidBillSubmissionState").val(stateCode);
    //        $("#" + controlIdPrefix + "lblBillSubmissionCity").text(cityName);
    //        $("#" + controlIdPrefix + "hdnBillSubmissionCity").val(cityCode);
    //        $("#" + controlIdPrefix + "hdnBillSubmissionCityName").val(cityName);
    //        $("#" + controlIdPrefix + "lblBillSubmissionGSTIN").text(GSTINNumber);
    //        $("#" + controlIdPrefix + "hdnBillSubmissionGSTINNumber").val(GSTINNumber);
    //        $("#" + controlIdPrefix + "hidBillSubmissionStateType").val(StateType);
    //        $("#" + controlIdPrefix + "hidBillingAddressStateWise").val(BillingAddressStateWise);
    //        $("#" + controlIdPrefix + "lblBillingAddress").text(BillingAddressStateWise);
    //    } else {
    //        $("#" + controlIdPrefix + "hidBillSubmissionState").val('');
    //        $("#" + controlIdPrefix + "lblBillSubmissionCity").text('');
    //        $("#" + controlIdPrefix + "hdnBillSubmissionCity").val('');
    //        $("#" + controlIdPrefix + "hdnBillSubmissionCityName").val('');
    //        $("#" + controlIdPrefix + "lblBillSubmissionGSTIN").text('');
    //        $("#" + controlIdPrefix + "hdnBillSubmissionGSTINNumber").val('');
    //        $("#" + controlIdPrefix + "hidBillSubmissionStateType").val('');
    //        $("#" + controlIdPrefix + "hidBillingAddressStateWise").val('');
    //        $("#" + controlIdPrefix + "lblBillingAddress").text($("#" + controlIdPrefix + "hidBillingAddress").val());
    //    }
    //}
    if (type == "3") {
        var cityData = "", cityCode = "", cityName = "";
        var ddlBillCollectionStateCode = $("#" + controlIdPrefix + "ddlBillCollectionState").val();
        if (ddlBillCollectionStateCode != "" && ddlBillCollectionStateCode != "0") {
            var BillCollectionStateCode = ddlBillCollectionStateCode.split("~");
            var stateCode = BillCollectionStateCode[0];
            var city = BillCollectionStateCode[1];
            if (city != "") {
                cityData = city.split("^");
                cityCode = cityData[0];
                cityName = cityData[1];
            }
            var GSTINNumber = BillCollectionStateCode[2];
            var StateType = BillCollectionStateCode[3];
            $("#" + controlIdPrefix + "hidBillCollectionState").val(stateCode);
            $("#" + controlIdPrefix + "lblBillCollectionCity").text(cityName);
            $("#" + controlIdPrefix + "hdnBillCollectionCity").val(cityCode);
            $("#" + controlIdPrefix + "hdnBillCollectionCityName").val(cityName);
            $("#" + controlIdPrefix + "lblBillCollectionGSTIN").text(GSTINNumber);
            $("#" + controlIdPrefix + "hdnBillCollectionGSTINNumber").val(GSTINNumber);
            $("#" + controlIdPrefix + "hidBillCollectionStateType").val(StateType);
        } else {
            $("#" + controlIdPrefix + "hidBillCollectionState").val('');
            $("#" + controlIdPrefix + "lblBillCollectionCity").text('');
            $("#" + controlIdPrefix + "hdnBillCollectionCity").val('');
            $("#" + controlIdPrefix + "hdnBillCollectionCityName").val('');
            $("#" + controlIdPrefix + "lblBillCollectionGSTIN").text('');
            $("#" + controlIdPrefix + "hdnBillCollectionGSTINNumber").val('');
            $("#" + controlIdPrefix + "hidBillCollectionStateType").val('');
        }
    }
    var hidSGST = $("#" + controlIdPrefix + "hidSGST").val();
    var hidUTGST = $("#" + controlIdPrefix + "hidUTGST").val();
    var hidCGST = $("#" + controlIdPrefix + "hidCGST").val();
    var hidIGST = $("#" + controlIdPrefix + "hidIGST").val();
    var hidUTGSTNo = $("#" + controlIdPrefix + "hidUTGSTNo").val();
    if ($("#" + controlIdPrefix + "hidBillGenerationStateType").val() == "UT" || $("#" + controlIdPrefix + "hidBillSubmissionStateType").val() == "UT") {
        UTInterState = "YES";
        var gstTotal = 0;
        gstTotal = parseFloat($("#" + controlIdPrefix + "hdgstTotal").val());
        if ($("#" + controlIdPrefix + "hidBillGenerationState").val() == $("#" + controlIdPrefix + "hidBillSubmissionState").val()) {
            $("#" + controlIdPrefix + "lblInterState").text('Yes');
            $("#" + controlIdPrefix + "hidInterState").val('Yes');
            $("#" + controlIdPrefix + "lblSummaryUTGST").text((gstTotal * parseFloat(hidUTGSTNo)).toFixed(2));
            $("#" + controlIdPrefix + "hidSummaryUTGST").val((gstTotal * parseFloat(hidUTGSTNo)).toFixed(2));
            $("#" + controlIdPrefix + "lblSummaryIGST").text('0.00');
            $("#" + controlIdPrefix + "hidSummaryIGST").val('0.00');
            $("#" + controlIdPrefix + "lblSummarySGST").text('0.00');
            $("#" + controlIdPrefix + "hidSummarySGST").val('0.00');
            $("#" + controlIdPrefix + "lblSummaryCGST").text((gstTotal * parseFloat(hidCGST)).toFixed(2));
            $("#" + controlIdPrefix + "hidSummaryCGST").val((gstTotal * parseFloat(hidCGST)).toFixed(2));
        } else {
            $("#" + controlIdPrefix + "lblInterState").text('No');
            $("#" + controlIdPrefix + "hidInterState").val('No');
            $("#" + controlIdPrefix + "lblSummaryUTGST").text('0.00');
            $("#" + controlIdPrefix + "hidSummaryUTGST").val('0.00');
            $("#" + controlIdPrefix + "lblSummaryIGST").text((gstTotal * parseFloat(hidUTGST)).toFixed(2));
            $("#" + controlIdPrefix + "hidSummaryIGST").val((gstTotal * parseFloat(hidUTGST)).toFixed(2));
            $("#" + controlIdPrefix + "lblSummarySGST").text('0.00');
            $("#" + controlIdPrefix + "hidSummarySGST").val('0.00');
            $("#" + controlIdPrefix + "lblSummaryCGST").text('0.00');
            $("#" + controlIdPrefix + "hidSummaryCGST").val('0.00');
        }
    } else {
        UTInterState = "NO";
        if ($("#" + controlIdPrefix + "hidBillGenerationState").val() == $("#" + controlIdPrefix + "hidBillSubmissionState").val()) {
            var gstTotal = 0;
            gstTotal = parseFloat($("#" + controlIdPrefix + "hdgstTotal").val());
            $("#" + controlIdPrefix + "lblInterState").text('Yes');
            $("#" + controlIdPrefix + "hidInterState").val('Yes');
            $("#" + controlIdPrefix + "lblSummarySGST").text((gstTotal * parseFloat(hidSGST)).toFixed(2));
            $("#" + controlIdPrefix + "lblSummaryCGST").text((gstTotal * parseFloat(hidCGST)).toFixed(2));
            $("#" + controlIdPrefix + "lblSummaryIGST").text('0.00');
            $("#" + controlIdPrefix + "hidSummarySGST").val((gstTotal * parseFloat(hidSGST)).toFixed(2));
            $("#" + controlIdPrefix + "hidSummaryCGST").val((gstTotal * parseFloat(hidCGST)).toFixed(2));
            $("#" + controlIdPrefix + "hidSummaryIGST").val('0.00');
            $("#" + controlIdPrefix + "lblSummaryUTGST").text('0.00');
            $("#" + controlIdPrefix + "hidSummaryUTGST").val('0.00');
        } else {
            var gstTotal = 0;
            gstTotal = parseFloat($("#" + controlIdPrefix + "hdgstTotal").val());
            $("#" + controlIdPrefix + "lblInterState").text('No');
            $("#" + controlIdPrefix + "hidInterState").val('No');
            $("#" + controlIdPrefix + "lblSummaryIGST").text((gstTotal * parseFloat(hidIGST)).toFixed(2));
            $("#" + controlIdPrefix + "hidSummaryIGST").val((gstTotal * parseFloat(hidIGST)).toFixed(2));
            $("#" + controlIdPrefix + "lblSummarySGST").text('0.00');
            $("#" + controlIdPrefix + "lblSummaryCGST").text('0.00');
            $("#" + controlIdPrefix + "hidSummarySGST").val('0.00');
            $("#" + controlIdPrefix + "hidSummaryCGST").val('0.00');
            $("#" + controlIdPrefix + "lblSummaryUTGST").text('0.00');
            $("#" + controlIdPrefix + "hidSummaryUTGST").val('0.00');
        }
    }
    var countChecked = 0;
    countChecked = $("input[id*='chkSelect']:checked").length;
    if (parseFloat(countChecked) > 0 && parseFloat($("#" + controlIdPrefix + "hdgstTotal").val()) > 0) {
        GetSummaryLedgerDetails();
    }
}

function Validate() {
    if ($.trim($("span[id*='lblCustomerName']").text()) == '') {
        throw new Error("Customer Name not found ! ")
    }
    if ($.trim($("span[id*='lblBillingAddress']").text()) == '') {
        throw new Error("Billing Address not found ! ")
    }
    var voo = true;
    voo = isValidDate($("#" + controlIdPrefix + "txtGenerationDate").val(), 'Invoice Date ');
    if (!voo) {
        throw new Error(voo);
    }
    var booPast = true;
    if (MyDateCompare($("#" + controlIdPrefix + "hdnPastDate").val(), $("#" + controlIdPrefix + "txtGenerationDate").val()) < 0) booPast = false;
    if (!booPast) {
        throw new Error("Invoice Date cannot be less than : " + $("#" + controlIdPrefix + "hdnPastDate").val());
    }
    var booFuture = true;
    if (MyDateCompare($("#" + controlIdPrefix + "hdnSysDate").val(), $("#" + controlIdPrefix + "txtGenerationDate").val()) > 0) booFuture = false;
    if (!booFuture) {
        throw new Error("Invoice Date cannot be greater than System Date: " + $("#" + controlIdPrefix + "hdnSysDate").val());
    }
    var dt = $("#" + controlIdPrefix + "txtGenerationDate").val();
    var dt_dd = dt.substring(0, 2)
    var dt_mm = dt.substring(3, 5)
    var dt_yy = dt.substring(6, 10)
    dt = new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
    var FinYear_fromdate_dd = FinYear_fromdate.substring(0, 2);
    var FinYear_fromdate_mm = FinYear_fromdate.substring(3, 5);
    var FinYear_fromdate_yy = FinYear_fromdate.substring(6, 10);
    FinYear_fromdate1 = new Date(months[parseFloat(FinYear_fromdate_mm)] + " " + parseFloat(FinYear_fromdate_dd) + ", " + parseFloat(FinYear_fromdate_yy))

    var FinYear_todate_dd = FinYear_todate.substring(0, 2);
    var FinYear_todate_mm = FinYear_todate.substring(3, 5);
    var FinYear_todate_yy = FinYear_todate.substring(6, 10);
    FinYear_todate1 = new Date(months[parseFloat(FinYear_todate_mm)] + " " + parseFloat(FinYear_todate_dd) + ", " + parseFloat(FinYear_todate_yy))

    if (dt > FinYear_todate1 || dt < FinYear_fromdate1) {
        throw new Error("You have Selected Finacial Year as " + Sle_finyear + " , SO Billdate Should Be Between  " + FinYear_fromdate + " to " + FinYear_todate + " !!!")
    }
    if ($("#" + controlIdPrefix + "ddlBillGenerationState").val() == '') {
        throw new Error("Please Select Bill Generation State ! ")
    }
    if ($.trim($("span[id*='lblBillGenerationCity']").text()) == '') {
        throw new Error("Bill Generation City not found ! ")
    }
    if ($.trim($("span[id*='lblBillGenerationGSTIN']").text()) == '') {
        throw new Error("Bill Generation GSTIN not found ! ")
    }
    if ($.trim($("span[id*='lblBillGenerationLocation']").text()) == '') {
        throw new Error("Bill Generation Location not found ! ")
    }
    //if ($("#" + controlIdPrefix + "ddlBillSubmissionState").val() == '') {
    //    throw new Error("Please Select Bill Submission State ! ")
    //}
    if ($("#" + controlIdPrefix + "lblBillSubmissionState").text() == '') {
        throw new Error("Please Select Bill Submission State ! ")
    }
    if ($.trim($("span[id*='lblBillSubmissionCity']").text()) == '') {
        throw new Error("Bill Submission City not found ! ")
    }
    if ($.trim($("span[id*='lblBillSubmissionGSTIN']").text()) == '') {
        throw new Error("Bill Submission GSTIN not found ! ")
    }
    if ($.trim($("span[id*='lblBillSubmissionLocation']").text()) == '') {
        throw new Error("Bill Submission Location not found ! ")
    }
    if ($("#" + controlIdPrefix + "ddlBillCollectionState").val() == '') {
        throw new Error("Please Select Bill Collection State ! ")
    }
    if ($.trim($("span[id*='lblBillCollectionCity']").text()) == '') {
        throw new Error("Bill Collection City not found ! ")
    }
    if ($.trim($("span[id*='lblBillCollectionGSTIN']").text()) == '') {
        throw new Error("Bill Collection GSTIN not found ! ")
    }
    if ($.trim($("span[id*='lblBillCollectionLocation']").text()) == '') {
        throw new Error("Bill Collection Location not found ! ")
    }
    if ($.trim($("span[id*='lblServiceType']").text()) == '') {
        throw new Error("Service Type not found ! ")
    }
    if ($.trim($("span[id*='lblInterState']").text()) == '') {
        throw new Error("Inter State not found ! ")
    }
    if ($.trim($("span[id*='lblSACCategory']").text()) == '') {
        throw new Error("SAC Category not found ! ")
    }
    if ($.trim($("span[id*='lblGSTRate']").text()) == '') {
        throw new Error("GST Rate not found ! ")
    }
    if ($.trim($("span[id*='lblITC']").text()) == '') {
        throw new Error("ITC not found ! ")
    }
    if ($.trim($("span[id*='lblCustomerGSTIN']").text()) == '') {
        throw new Error("Customer GSTIN not found ! ")
    }
    if ($.trim($("span[id*='lblTransporterGSTIN']").text()) == '') {
        throw new Error("Transporter GSTIN not found ! ")
    }
    var countChecked = 0;
    countChecked = $("input[id*='chkSelect']:checked").length;
    if (parseFloat(countChecked) <= 0) {
        throw new Error("Please select at least one record ! ")
    }
    if ($.trim($("span[id*='lblCount']").text()) == '' || parseInt($.trim($("span[id*='lblCount']").text())) == 0) {
        throw new Error("Transaction Count must be greater then 0 ! ")
    }
    if ($.trim($("span[id*='lblSummarySubTotal']").text()) == '' || rounditn($.trim($("span[id*='lblSummarySubTotal']").text()), 2) == 0.00) {
        throw new Error("Transaction Sub Total must be greater then 0 ! ")
    }
    if ($.trim($("span[id*='lblSummaryTotal']").text()) == '' || rounditn($.trim($("span[id*='lblSummaryTotal']").text()), 2) == 0.00) {
        throw new Error("Transaction Total must be greater then 0 ! ")
    }
    if ($("#" + controlIdPrefix + "txtGenerationDate").val() == "") {
        throw new Error("Please Select Invoice Date.");
    }
    
}

function onSubmitClick() {
    try {
        Validate();
        if (!confirm("Are You Sure to Sumbit"))
            return false;
        hidClickCount = $("#" + controlIdPrefix + "hidClickCount").val();
        if (hidClickCount > 0) {
            throw new Error("Sorry... You cannot click twice !!!")
        }
        else {
            hidClickCount = hidClickCount + 1
            hidClickCount = $("#" + controlIdPrefix + "hidClickCount").val(hidClickCount);
        }
        return true;
    }
    catch (e) { alert(e.message); return false; }
}
function GetSummaryLedgerDetails() {
    var isvalid = false;
    $.ajax({
        type: "POST",
        url: "FreightBillGeneration.aspx/GetLedgerDetails",
        data: "{ grandtotal:'" + $("#" + controlIdPrefix + "hdtotal").val() + "',gsttotal:'" + $("#" + controlIdPrefix + "hdgstTotal").val() + "',customercode:'" + $("#" + controlIdPrefix + "hidCustomerID").val() + "',interstateyesno:'" + $("#" + controlIdPrefix + "hidInterState").val() + "',billingtype:'TRANSACTIONAL BILLING',utState:'" + UTInterState + "',utStateSame:'" + $("#" + controlIdPrefix + "hidInterState").val() + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function (data) {
            if (data.d != "") {
                var j = jQuery.parseJSON(data.d);
                var detail = "";
                if (j.ListItems.length > 0) {
                    for (var i = 0; i < j.ListItems.length; i++) {
                        if ((parseFloat(j.ListItems[i].Debit) + parseFloat(j.ListItems[i].Credit)) > 0) {
                            detail += "<tr class='nrow'>";
                            detail += "<td><label id='lblLedger'>" + j.ListItems[i].Ledger + "</label></td>";
                            detail += "<td><label id='lblSubLedger'>" + j.ListItems[i].SubLedger + "</label></td>";
                            detail += "<td style='text-align: right;'><label id='Dr'>" + j.ListItems[i].Debit + "</label></td>";
                            detail += "<td style='text-align: right;'><label id='Cr'>" + j.ListItems[i].Credit + "</label></td>";
                            detail += "</tr>";
                        }
                    }
                    $("#tblLedgerSummary>tbody").html(detail);
                }
            } else {
                alert("Issue occurred in Ledger Details.");
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
