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
var months = new Array("", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
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
    } else return Math.round(Num);
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
	
    Count = 0, subTotal = 0, gstTotal = 0, total = 0, miscTotalCharge = 0;
    Count = $("input[id*='chkSelect']:checked").length;
    if (parseFloat(Count) > 0) {
        // $(".DocketSummaryHeader").show();
        // $(".DocketSummary").show();
		$("#" + controlIdPrefix + "trDocketSummaryHeader").show();
        $("#" + controlIdPrefix + "tdDocketSummary").show();
        //$(".LedgerSummaryHeader").show();
        //$(".LedgerSummary").show();
    } else {
		$("#" + controlIdPrefix + "trDocketSummaryHeader").hide();
        $("#" + controlIdPrefix + "tdDocketSummary").hide();
        // $(".DocketSummaryHeader").hide();
        // $(".DocketSummary").hide();
        //$(".LedgerSummaryHeader").hide();
        //$(".LedgerSummary").hide();
    }
    if ($("input[id*='chkSelect']").length == Count) {
        $("input[id*='chkAllSelect']").attr("checked", "checked");
    } else {
        $("input[id*='chkAllSelect']").removeAttr("checked");
    }
	
    $("input[id*='chkSelect']:checked").each(function (i, e) {
        if (e.checked) {
            var lblSubTotal = $(e).parentsUntil("tr").parent().find("span[id*='lblSubTotal']");
            var lblSub_Total = $(e).parentsUntil("tr").parent().find("span[id*='lblSub_Total']");
            var lblGSTAmount = $(e).parentsUntil("tr").parent().find("span[id*='lblGSTAmount']");
            var lblTotal = $(e).parentsUntil("tr").parent().find("span[id*='lblTotal']");

            var txtMiscCharge = $(e).parentsUntil("tr").parent().find("input[id*='txtMiscCharge']");
            var miscchrg = parseFloat(txtMiscCharge.val() == "" ? "0" : txtMiscCharge.val());
            var _SubTot = parseFloat(lblSubTotal.text() == "" ? "0" : lblSubTotal.text());
            var _GstAmt = parseFloat(lblGSTAmount.text() == "" ? "0" : lblGSTAmount.text());
            lblSub_Total.text(_SubTot + miscchrg);
            lblTotal.text(_SubTot + miscchrg + _GstAmt);
            miscTotalCharge = miscTotalCharge + miscchrg;

            subTotal = subTotal + parseFloat(lblSub_Total.text());
            gstTotal = gstTotal + parseFloat(lblGSTAmount.text());
            total = total + parseFloat(lblTotal.text());
        }
    });
	
	 
    // $(".count").text(Count);
    // $(".subTotal").text(subTotal.toFixed(2));
    // $(".gstTotal").text(gstTotal.toFixed(2));
    // $(".total").text(total.toFixed(2));
	
	
	$("#" + controlIdPrefix + "lblCount").text(Count);
    $("#" + controlIdPrefix + "lblSummarySubTotal").text(subTotal.toFixed(2));
    $("#" + controlIdPrefix + "lblSummaryGSTTotal").text(gstTotal.toFixed(2));
    $("#" + controlIdPrefix + "lblSummaryTotal").text(total.toFixed(2));
	
	$("#" + controlIdPrefix + "hdCount").val(Count);
    $("#" + controlIdPrefix + "hdsubTotal").val(subTotal.toFixed(2));
    $("#" + controlIdPrefix + "hdgstTotal").val(gstTotal.toFixed(2));
    $("#" + controlIdPrefix + "hdtotal").val(total.toFixed(2));
	
    // $("input[id*='hdCount']").val(Count);
    // $("input[id*='hdsubTotal']").val(subTotal.toFixed(2));
    // $("input[id*='hdgstTotal']").val(gstTotal.toFixed(2));
    // $("input[id*='hdtotal']").val(total.toFixed(2));
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
            //$("#" + controlIdPrefix + "lblBillGenerationCity").text(cityName);
            //$("#" + controlIdPrefix + "hdnBillGenerationCity").val(cityCode);
            //$("#" + controlIdPrefix + "hdnBillGenerationCityName").val(cityName);
            $("#" + controlIdPrefix + "lblBillGenerationGSTIN").text(GSTINNumber);
            $("#" + controlIdPrefix + "hdnBillGenerationGSTINNumber").val(GSTINNumber);
            $("#" + controlIdPrefix + "hidBillGenerationStateType").val(StateType);
            GetCustomerBillGenerationLocation();
            $("#" + controlIdPrefix + "lblBillGenerationCity").text('');
            $("#" + controlIdPrefix + "hdnBillGenerationCity").val('');
            $("#" + controlIdPrefix + "hdnBillGenerationCityName").val('');
        } else {
            $("#" + controlIdPrefix + "hidBillGenerationState").val('');
            $("#" + controlIdPrefix + "lblBillGenerationCity").text('');
            $("#" + controlIdPrefix + "hdnBillGenerationCity").val('');
            $("#" + controlIdPrefix + "hdnBillGenerationCityName").val('');
            $("#" + controlIdPrefix + "lblBillGenerationGSTIN").text('');
            $("#" + controlIdPrefix + "hdnBillGenerationGSTINNumber").val('');
            $("#" + controlIdPrefix + "hidBillGenerationStateType").val('');
            $("#" + controlIdPrefix + "ddlBillGenerationLocation").val('');
        }
    }
    if (type == "2") {
        var cityData = "", cityCode = "", cityName = "";
        var ddlBillSubmissionStateCode = $("#" + controlIdPrefix + "ddlBillSubmissionState").val();
        if (ddlBillSubmissionStateCode != "" && ddlBillSubmissionStateCode != "0") {
            var BillSubmissionStateCode = ddlBillSubmissionStateCode.split("~");
            var stateCode = BillSubmissionStateCode[0];
            var city = BillSubmissionStateCode[1];
            if (city != "") {
                cityData = city.split("^");
                cityCode = cityData[0];
                cityName = cityData[1];
            }
            var GSTINNumber = BillSubmissionStateCode[2];
            var StateType = BillSubmissionStateCode[3];
            var BillingAddressStateWise = BillSubmissionStateCode[4];
            $("#" + controlIdPrefix + "hidBillSubmissionState").val(stateCode);
            $("#" + controlIdPrefix + "hidBillSubmissionStateName").val($("#" + controlIdPrefix + "ddlBillSubmissionState option:selected").text());
            //$("#" + controlIdPrefix + "lblBillSubmissionCity").text(cityName);
            //$("#" + controlIdPrefix + "hdnBillSubmissionCity").val(cityCode);
            //$("#" + controlIdPrefix + "hdnBillSubmissionCityName").val(cityName);
            $("#" + controlIdPrefix + "lblBillSubmissionGSTIN").text(GSTINNumber);
            $("#" + controlIdPrefix + "hdnBillSubmissionGSTINNumber").val(GSTINNumber);
            $("#" + controlIdPrefix + "hidBillSubmissionStateType").val(StateType);
            $("#" + controlIdPrefix + "hidBillingAddressStateWise").val(BillingAddressStateWise);
            $("#" + controlIdPrefix + "lblBillingAddress").text(BillingAddressStateWise);
            $("#" + controlIdPrefix + "hidBillCollectionState").val(stateCode);
            $("#" + controlIdPrefix + "lblBillCollectionGSTIN").text(GSTINNumber);
            $("#" + controlIdPrefix + "hdnBillCollectionGSTINNumber").val(GSTINNumber);
            $("#" + controlIdPrefix + "hidBillCollectionStateType").val(StateType);
            //$("#" + controlIdPrefix + "lblBillCollectionCity").text(cityName);
            //$("#" + controlIdPrefix + "hdnBillCollectionCity").val(cityCode);
            //$("#" + controlIdPrefix + "hdnBillCollectionCityName").val(cityName);
            GetCustomerBillSubmissionLocation();
            $("#" + controlIdPrefix + "lblBillCollectionState").text($("#" + controlIdPrefix + "hidBillSubmissionStateName").val());
            $("#" + controlIdPrefix + "hidBillCollectionStateName").val($("#" + controlIdPrefix + "hidBillSubmissionStateName").val());
            $("#" + controlIdPrefix + "lblBillSubmissionCity").text('');
            $("#" + controlIdPrefix + "hdnBillSubmissionCity").val('');
            $("#" + controlIdPrefix + "hdnBillSubmissionCityName").val('');
            $("#" + controlIdPrefix + "lblBillCollectionCity").text('');
            $("#" + controlIdPrefix + "hdnBillCollectionCity").val('');
            $("#" + controlIdPrefix + "hdnBillCollectionCityName").val('');
            $("#" + controlIdPrefix + "lblBillCollectionLocation").text('');
            $("#" + controlIdPrefix + "hidBillCollectionLocation").val('');
        } else {
            $("#" + controlIdPrefix + "hidBillSubmissionLocation").val('');
            $("#" + controlIdPrefix + "lblBillCollectionLocation").text('');
            $("#" + controlIdPrefix + "hidBillCollectionLocation").val('');
            $("#" + controlIdPrefix + "hidBillSubmissionState").val('');
            $("#" + controlIdPrefix + "lblBillSubmissionCity").text('');
            $("#" + controlIdPrefix + "hdnBillSubmissionCity").val('');
            $("#" + controlIdPrefix + "hdnBillSubmissionCityName").val('');
            $("#" + controlIdPrefix + "lblBillSubmissionGSTIN").text('');
            $("#" + controlIdPrefix + "hdnBillSubmissionGSTINNumber").val('');
            $("#" + controlIdPrefix + "hidBillSubmissionStateType").val('');
            $("#" + controlIdPrefix + "hidBillingAddressStateWise").val('');
            $("#" + controlIdPrefix + "lblBillingAddress").text($("#" + controlIdPrefix + "hidBillingAddress").val());
            $("#" + controlIdPrefix + "ddlBillSubmissionLocation").val('');
            $("#" + controlIdPrefix + "lblBillCollectionCity").text('');
            $("#" + controlIdPrefix + "hdnBillCollectionCity").val('');
            $("#" + controlIdPrefix + "hdnBillCollectionCityName").val('');
            $("#" + controlIdPrefix + "hidBillCollectionState").val('');
            $("#" + controlIdPrefix + "lblBillCollectionGSTIN").text('');
            $("#" + controlIdPrefix + "hdnBillCollectionGSTINNumber").val('');
            $("#" + controlIdPrefix + "hidBillCollectionStateType").val('');
            $("#" + controlIdPrefix + "hidBillSubmissionStateName").val('');
            $("#" + controlIdPrefix + "lblBillCollectionState").text('');
            $("#" + controlIdPrefix + "hidBillCollectionStateName").val('');
        }
    }
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
            var BillingAddressStateWise = BillSubmissionStateCode[4];
            $("#" + controlIdPrefix + "hidBillCollectionState").val(stateCode);
            //$("#" + controlIdPrefix + "lblBillCollectionCity").text(cityName);
            //$("#" + controlIdPrefix + "hdnBillCollectionCity").val(cityCode);
            //$("#" + controlIdPrefix + "hdnBillCollectionCityName").val(cityName);
            $("#" + controlIdPrefix + "lblBillCollectionGSTIN").text(GSTINNumber);
            $("#" + controlIdPrefix + "hdnBillCollectionGSTINNumber").val(GSTINNumber);
            $("#" + controlIdPrefix + "hidBillCollectionStateType").val(StateType);
            $("#" + controlIdPrefix + "lblBillCollectionCity").text('');
            $("#" + controlIdPrefix + "hdnBillCollectionCity").val('');
            $("#" + controlIdPrefix + "hdnBillCollectionCityName").val('');
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
function OnChangeLocation(type) {
    if (type == "1") {
        var ddlBillGenerationLocationCode = $("#" + controlIdPrefix + "ddlBillGenerationLocation").val();
        if (ddlBillGenerationLocationCode != "" && ddlBillGenerationLocationCode != "0") {
            var BillGenerationLocationCode = ddlBillGenerationLocationCode.split("~");
            var locationCode = BillGenerationLocationCode[0];
            var locationCityCode = BillGenerationLocationCode[1];
            var locationCityName = BillGenerationLocationCode[2];
            $("#" + controlIdPrefix + "hidBillGenerationLocation").val(locationCode);
            $("#" + controlIdPrefix + "lblBillGenerationCity").text(locationCityName);
            $("#" + controlIdPrefix + "hdnBillGenerationCity").val(locationCityCode);
            $("#" + controlIdPrefix + "hdnBillGenerationCityName").val(locationCityName);
        }
        else {
            $("#" + controlIdPrefix + "hidBillGenerationLocation").val('');
            $("#" + controlIdPrefix + "lblBillGenerationCity").text('');
            $("#" + controlIdPrefix + "hdnBillGenerationCity").val('');
            $("#" + controlIdPrefix + "hdnBillGenerationCityName").val('');
        }
    }
    if (type == "2") {
        var ddlBillSubmissionLocationCode = $("#" + controlIdPrefix + "ddlBillSubmissionLocation").val();
        if (ddlBillSubmissionLocationCode != "" && ddlBillSubmissionLocationCode != "0") {
            var BillSubmissionLocationCode = ddlBillSubmissionLocationCode.split("~");
            var locationCode = BillSubmissionLocationCode[0];
            var locationCityCode = BillSubmissionLocationCode[1];
            var locationCityName = BillSubmissionLocationCode[2];
            $("#" + controlIdPrefix + "hidBillSubmissionLocation").val(locationCode);
            $("#" + controlIdPrefix + "lblBillSubmissionCity").text(locationCityName);
            $("#" + controlIdPrefix + "hdnBillSubmissionCity").val(locationCityCode);
            $("#" + controlIdPrefix + "hdnBillSubmissionCityName").val(locationCityName);
            $("#" + controlIdPrefix + "lblBillCollectionCity").text(locationCityName);
            $("#" + controlIdPrefix + "hdnBillCollectionCity").val(locationCityCode);
            $("#" + controlIdPrefix + "hdnBillCollectionCityName").val(locationCityName);
            $("#" + controlIdPrefix + "lblBillCollectionLocation").text($("#" + controlIdPrefix + "ddlBillSubmissionLocation option:selected").text());
            $("#" + controlIdPrefix + "hidBillCollectionLocation").val($("#" + controlIdPrefix + "ddlBillSubmissionLocation option:selected").text());
        }
        else {
            $("#" + controlIdPrefix + "hidBillSubmissionLocation").val('');
            $("#" + controlIdPrefix + "lblBillSubmissionCity").text('');
            $("#" + controlIdPrefix + "hdnBillSubmissionCity").val('');
            $("#" + controlIdPrefix + "hdnBillSubmissionCityName").val('');
            $("#" + controlIdPrefix + "lblBillCollectionCity").text('');
            $("#" + controlIdPrefix + "hdnBillCollectionCity").val('');
            $("#" + controlIdPrefix + "hdnBillCollectionCityName").val('');
            $("#" + controlIdPrefix + "lblBillCollectionLocation").text('');
            $("#" + controlIdPrefix + "hidBillCollectionLocation").val('');
        }
    }
}

function Validate() {
    if ($.trim($("span[id*='lblCustomerName']").text()) == '') {
        throw new Error("Customer Name not found ! ")
    }
    if ($.trim($("span[id*='lblBillingAddress']").text()) == '') {
        throw new Error("Billing Address not found ! ")
    }
    isValidDateBillDate($("#" + controlIdPrefix + "txtGenerationDate").val(), 'Invoice');
    isValidDateBillDate($("#" + controlIdPrefix + "txtDueDate").val(), 'Due');

    var booFuture = true;
    if (MyDateCompare($("#" + controlIdPrefix + "hdnSysDate").val(), $("#" + controlIdPrefix + "txtGenerationDate").val()) > 0) booFuture = false;
    if (!booFuture) {
        throw new Error("Invoice Date cannot be greater than System Date: " + $("#" + controlIdPrefix + "hdnSysDate").val());
    }
    var dt = $("#" + controlIdPrefix + "txtGenerationDate").val();
    var dtDueDate = $("#" + controlIdPrefix + "txtDueDate").val();
    var hdndockdt;
    //var Maxdt = "01/07/2017";
    var Maxdt = $("#" + controlIdPrefix + "hidMaxDate").val();
    var hidInvoiceDateEditable = $("#" + controlIdPrefix + "hidInvoiceDateEditable").val();
    var hidInvoiceDateBackDaysYN = $("#" + controlIdPrefix + "hidInvoiceDateBackDaysYN").val();
    var hidInvoiceDateBackDays = $("#" + controlIdPrefix + "hidInvoiceDateBackDays").val();
    var rows = document.getElementById("tblDocketDetail").rows.length;
    for (var b = 0; b <= rows - 2; b++) {
        if (b < 10) {
            hdndockdt = "ctl00_MyCPH1_rptDocketDetails_ctl" + "0" + b + "_hidTransactionDate";
            hdndockdt = document.getElementById(hdndockdt).value;
            checkyn = document.getElementById("ctl00_MyCPH1_rptDocketDetails_ctl" + "0" + b + "_chkSelect").checked;
        }
        else {
            hdndockdt = "ctl00_MyCPH1_rptDocketDetails_ctl" + b + "_hidTransactionDate";
            hdndockdt = document.getElementById(hdndockdt).value;
            checkyn = document.getElementById("ctl00_MyCPH1_rptDocketDetails_ctl" + b + "_chkSelect").checked;
        }
        if (checkyn == true) {
            var Maxdt1 = Maxdt
            Check_One = "Y"
            var Maxdt_dd = Maxdt1.substring(0, 2)
            var Maxdt_mm = Maxdt1.substring(3, 5)
            var Maxdt_yy = Maxdt1.substring(6, 10)
            var hdndockdt1 = hdndockdt
            var hdndockdt_dd = hdndockdt1.substring(0, 2)
            var hdndockdt_mm = hdndockdt1.substring(3, 5)
            var hdndockdt_yy = hdndockdt1.substring(6, 10)
            Maxdt1 = new Date(months[parseInt(Maxdt_mm)] + " " + parseInt(Maxdt_dd) + ", " + parseInt(Maxdt_yy))
            hdndockdt1 = new Date(months[parseInt(hdndockdt_mm)] + " " + parseInt(hdndockdt_dd) + ", " + parseInt(hdndockdt_yy))
            if (hdndockdt1 > Maxdt1) {
                Maxdt1 = hdndockdt1
                Maxdt = hdndockdt
            }
            if (rows == 2)
                Maxdt = hdndockdt
        }
    }
    Fromdate1 = Maxdt1
    Fromdate = Maxdt
    //if (dt < Fromdate && dt != "") {
    //    throw new Error("Invoice Date should not be Less then Docket Date");
    //}

    if (MyDateCompare(dt, Fromdate) > 0) booFuture = false;
    if (!booFuture) {
        throw new Error("Invoice Date should not be Less then Docket Date");
    }
    if (hidInvoiceDateEditable == "Y" && hidInvoiceDateBackDaysYN == "Y") {
        if (MyDateCompare(dt, hidInvoiceDateBackDays) > 0) booFuture = false;
        if (!booFuture) {
            throw new Error("Invoice Date should not be Less then Back Date:" + hidInvoiceDateBackDays);
        }
    }
    else {
        var booPast = true;
        if (MyDateCompare($("#" + controlIdPrefix + "hdnPastDate").val(), $("#" + controlIdPrefix + "txtGenerationDate").val()) < 0) booPast = false;
        if (!booPast) {
            throw new Error("Invoice Date cannot be less than : " + $("#" + controlIdPrefix + "hdnPastDate").val());
        }
    }

    if (MyDateCompare(dtDueDate, dt) > 0) booFuture = false;
    if (!booFuture) {
        throw new Error("Due Date should not be Less then Invoice Date");
    }
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
    if ($("#" + controlIdPrefix + "ddlBillGenerationLocation").val() == '') {
        throw new Error("Please Select Bill Generation Location ! ")
    }
    if ($.trim($("span[id*='lblBillGenerationCity']").text()) == '') {
        throw new Error("Bill Generation City not found ! ")
    }
    if ($.trim($("span[id*='lblBillGenerationGSTIN']").text()) == '') {
        throw new Error("Bill Generation GSTIN not found ! ")
    }
    //if ($.trim($("span[id*='lblBillGenerationLocation']").text()) == '') {
    //    throw new Error("Bill Generation Location not found ! ")
    //}
    //if ($("#" + controlIdPrefix + "ddlBillSubmissionState").val() == '') {
    //    throw new Error("Please Select Bill Submission State ! ")
    //}
    //if ($("#" + controlIdPrefix + "lblBillSubmissionState").text() == '') {
    //    throw new Error("Please Select Bill Submission State ! ")
    //}
    if ($("#" + controlIdPrefix + "ddlBillSubmissionState").val() == '') {
        throw new Error("Please Select Bill Submission State ! ")
    }
    if ($("#" + controlIdPrefix + "ddlBillSubmissionLocation").val() == '') {
        throw new Error("Please Select Bill Submission Location ! ")
    }
    if ($.trim($("span[id*='lblBillSubmissionCity']").text()) == '') {
        throw new Error("Bill Submission City not found ! ")
    }
    if ($.trim($("span[id*='lblBillSubmissionGSTIN']").text()) == '') {
        throw new Error("Bill Submission GSTIN not found ! ")
    }
    //if ($.trim($("span[id*='lblBillSubmissionLocation']").text()) == '') {
    //    throw new Error("Bill Submission Location not found ! ")
    //}
    if ($.trim($("span[id*='lblBillCollectionState']").text()) == '') {
        throw new Error("Bill Collection State not found ! ")
    }
    //if ($("#" + controlIdPrefix + "ddlBillCollectionState").val() == '') {
    //    throw new Error("Please Select Bill Collection State ! ")
    //}
    if ($.trim($("span[id*='lblBillCollectionLocation']").text()) == '') {
        throw new Error("Bill Collection Location not found ! ")
    }
    if ($.trim($("span[id*='lblBillCollectionCity']").text()) == '') {
        throw new Error("Bill Collection City not found ! ")
    }
    if ($.trim($("span[id*='lblBillCollectionGSTIN']").text()) == '') {
        throw new Error("Bill Collection GSTIN not found ! ")
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
    //if ($.trim($("span[id*='lblCustomerGSTIN']").text()) == '') {
    //    throw new Error("Customer GSTIN not found ! ")
    //}
    //if ($.trim($("span[id*='lblTransporterGSTIN']").text()) == '') {
    //    throw new Error("Transporter GSTIN not found ! ")
    //}
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
	
	if ($("#" + controlIdPrefix + "txtGenerationDate").val() != "") {
            var jBillDateArray = $("#" + controlIdPrefix + "txtGenerationDate").val().split("/");
            var jBillDate = new Date(jBillDateArray[1] + '/' + jBillDateArray[0] + '/' + jBillDateArray[2]);
            var jFinStartDate = new Date("01 APR " + FinYear);
            var jFinEndDate = new Date("31 MAR " + (parseInt(FinYear) + 1).toString());

            if (jBillDate < jFinStartDate || jBillDate > jFinEndDate) {
                alert("Invoice Date Must be in Selected Finacial Year !!");
                $("#" + controlIdPrefix + "txtGenerationDate").val("");
                $("#" + controlIdPrefix + "txtGenerationDate").focus();
                return false;
            }
        }

        $("input[type=text][id*=txtReportingDate]").each(function () {
			
            var txtReportingDate = $(this);
            var hdnReportingDate = $("#" + txtReportingDate.attr('id').replace("txtReportingDate", "hdnReportingDate"));
            var txtUnloadingDate = $("#" + txtReportingDate.attr('id').replace("txtReportingDate", "txtUnloadingDate"));
            var hdnUnloadingDate = $("#" + txtReportingDate.attr('id').replace("txtReportingDate", "hdnUnloadingDate"));
            var txtRARemark = $("#" + txtReportingDate.attr('id').replace("txtReportingDate", "txtRARemark"));
			var chkSelect = $("#" + txtReportingDate.attr('id').replace("txtReportingDate", "chkSelect"));

			// alert(chkSelect.prop("checked"));	
            if(chkSelect.prop("checked")==true){
				if (txtUnloadingDate != null && txtReportingDate != null) {
					if (txtReportingDate.val() == "" || txtUnloadingDate.val() == "") {
						alert("Please select Reporting Date and Unloading Date !!");
						throw "";
					}

					if (hdnReportingDate.val() != "" && hdnUnloadingDate.val() != "") {
						if (txtReportingDate.val() != hdnReportingDate.val() || txtUnloadingDate.val() != hdnUnloadingDate.val()) {
							if (txtRARemark.val() == "") {
								alert("Please select Deviation Remark As Reporting Date or Unloading Date is changed  !!");
								throw "";
							}
						}
					}
				}
			}
			
        });


    } catch (e) {
        return false
    }

    try {

        Validate();
	
        if (!confirm("Are You Sure to Submit"))
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
    // var isvalid = false;
    // $.ajax({
        // type: "POST",
        // url: "FreightBillGeneration.aspx/GetLedgerDetails",
        // data: "{ grandtotal:'" + $("#" + controlIdPrefix + "hdtotal").val() + "',gsttotal:'" + $("#" + controlIdPrefix + "hdgstTotal").val() + "',customercode:'" + $("#" + controlIdPrefix + "hidCustomerID").val() + "',interstateyesno:'" + $("#" + controlIdPrefix + "hidInterState").val() + "',billingtype:'TRANSACTIONAL BILLING',utState:'" + UTInterState + "',utStateSame:'" + $("#" + controlIdPrefix + "hidInterState").val() + "',businessType:'" + $("#" + controlIdPrefix + "hidBusinessType").val() + "'}",
        // contentType: "application/json; charset=utf-8",
        // dataType: "json",
        // async: false,
        // success: function (data) {
            // if (data.d != "") {
                // var j = jQuery.parseJSON(data.d);
                // var detail = "";
                // if (j.ListItems.length > 0) {
                    // for (var i = 0; i < j.ListItems.length; i++) {
                        // if ((parseFloat(j.ListItems[i].Debit) + parseFloat(j.ListItems[i].Credit)) > 0) {
                            // detail += "<tr class='nrow'>";
                            // detail += "<td><label id='lblLedger'>" + j.ListItems[i].Ledger + "</label></td>";
                            // detail += "<td><label id='lblSubLedger'>" + j.ListItems[i].SubLedger + "</label></td>";
                            // detail += "<td style='text-align: right;'><label id='Dr'>" + j.ListItems[i].Debit + "</label></td>";
                            // detail += "<td style='text-align: right;'><label id='Cr'>" + j.ListItems[i].Credit + "</label></td>";
                            // detail += "</tr>";
                        // }
                    // }
                    // $("#tblLedgerSummary>tbody").html(detail);
                // }
            // } else {
                // alert("Issue occurred in Ledger Details.");
                // isvalid = false;
            // }
        // },
        // error: function (msg) {
            // alert(msg);
            // isvalid = false;
        // }
    // });
    // return isvalid;
	return true;
}

function GetCustomerBillGenerationLocation() {
    var hidBillGenerationState = $("#" + controlIdPrefix + "hidBillGenerationState");
    var ddlBillGenerationLocation = $("#" + controlIdPrefix + "ddlBillGenerationLocation");
    $.ajax({
        type: "POST",
        async: false,
        url: "FreightBillGeneration.aspx/GetCustomerBillGenerationLocation",
        data: "{ statecd:'" + hidBillGenerationState.val() + "',customercode:'" + $("#" + controlIdPrefix + "hidCustomerID").val() + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            ddlBillGenerationLocation.empty();
			var cnt = 0;
            if (data.d != "") {
                $.each(jQuery.parseJSON(data.d), function () {
                    ddlBillGenerationLocation.append($("<option></option>").val(this['Code']).html(this['Name']));
					 if (this['Name'] == 'BULK') {
                        cnt = 1;
                    }
                });
				if (cnt == 0) {
                    ddlBillSubmissionLocation.append($('<option></option>').val('BULK~1486~GURGAON').html('BULK'));
                }
            }
        },
        error: function (msg) {
        }
    });
}

function GetCustomerBillSubmissionLocation() {
    var hidBillSubmissionState = $("#" + controlIdPrefix + "hidBillSubmissionState");
    var ddlBillSubmissionLocation = $("#" + controlIdPrefix + "ddlBillSubmissionLocation");
    $.ajax({
        type: "POST",
        async: false,
        url: "FreightBillGeneration.aspx/GetCustomerBillGenerationLocation",
        data: "{ statecd:'" + hidBillSubmissionState.val() + "',customercode:'" + $("#" + controlIdPrefix + "hidCustomerID").val() + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            ddlBillSubmissionLocation.empty();
			var cnt = 0;
            if (data.d != "") {
                $.each(jQuery.parseJSON(data.d), function () {
                    ddlBillSubmissionLocation.append($("<option></option>").val(this['Code']).html(this['Name']));
					 if (this['Name'] == 'BULK') {
                        cnt = 1;
                    }
                });
				if (cnt == 0) {
                    ddlBillSubmissionLocation.append($('<option></option>').val('BULK~1486~GURGAON').html('BULK'));
                }
            }
        },
        error: function (msg) {
        }
    });
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
function isValidDateBillDate(dateStr, str) {
    var datePat = /^(\d{1,2})(\/|-)(\d{1,2})\2(\d{4})$/; // requires 4 digit year
    var matchArray = dateStr.match(datePat); // is the format ok?
    if (matchArray == null) {
        throw new Error("Please Enter " + str + " Date in dd/mm/yyyy Format");
        return false;
    }

    month = matchArray[3]; // parse date into variables
    day = matchArray[1];
    year = matchArray[4];

    if (month < 1 || month > 12) { // check month range
        throw new Error("In " + str + "Date Month must be between 1 and 12.");
    }

    if (day < 1 || day > 31) {
        throw new Error("In " + str + "Day must be between 1 and 31.");
    }

    if ((month == 4 || month == 6 || month == 9 || month == 11) && day == 31) {
        throw new Error("In " + str + "Month " + month + " doesn't have 31 days!")
    }

    if (month == 2) { // check for february 29th
        var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));

        if (day > 29 || (day == 29 && !isleap)) {
            throw new Error("In " + str + "February " + year + " doesn't have " + day + " days!");
        }
    }
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
} //End Function

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
function ValidateDateOnBlur() {
    var billGenerationDate = $("#" + controlIdPrefix + "txtGenerationDate");
    if (billGenerationDate.val() != "") {
        var voo = true;
        voo = isValidDate(billGenerationDate.val(), 'Invoice Date ');
        if (!voo) {
            billGenerationDate.val("");
            billGenerationDate.focus();
            return false;
        }
        //var booPast = true;
        //if (MyDateCompare($("#" + controlIdPrefix + "hdnPastDate").val(), billGenerationDate.val()) < 0) booPast = false;
        //if (!booPast) {
        //    alert("Invoice Date cannot be less than : " + $("#" + controlIdPrefix + "hdnPastDate").val());
        //    billGenerationDate.val("");
        //    billGenerationDate.focus();
        //    return false;
        //}
        var booFuture = true;
        if (MyDateCompare($("#" + controlIdPrefix + "hdnSysDate").val(), billGenerationDate.val()) > 0) booFuture = false;
        if (!booFuture) {
            alert("Invoice Date cannot be greater than System Date: " + $("#" + controlIdPrefix + "hdnSysDate").val());
            billGenerationDate.val("");
            return false;
        }
		
		var jBillDateArray = billGenerationDate.val().split("/");
        var jBillDate = new Date(jBillDateArray[1] + '/' + jBillDateArray[0] + '/' + jBillDateArray[2]);
        var jFinStartDate = new Date("01 APR " + FinYear);
        var jFinEndDate = new Date("31 MAR " + (parseInt(FinYear) + 1).toString());

        if (jBillDate < jFinStartDate || jBillDate > jFinEndDate) {
            alert("Invoice Date Must be in Selected Finacial Year !!");
            billGenerationDate.val("");
            billGenerationDate.focus();
            return false;
        }
		
        var invDtArr;
        invDtArr = billGenerationDate.val().split('/');
        var myInvDt = new Date(invDtArr[2], invDtArr[1] - 1, invDtArr[0]);
        var duedate = new Date(myInvDt);
        duedate.setDate(duedate.getDate() + parseInt($("#" + controlIdPrefix + "hidCreditDays").val(), 10));
        var dd = "";
        if (duedate.getDate() > 9)
            dd = duedate.getDate();
        else
            dd = "0" + (duedate.getDate());
        var mm = "";
        if (duedate.getMonth() + 1 > 9)
            mm = duedate.getMonth() + 1;
        else
            mm = "0" + (duedate.getMonth() + 1);
        var y = duedate.getFullYear();
        var someFormattedDate = dd + '/' + mm + '/' + y;
        $("#" + controlIdPrefix + "txtDueDate").val(someFormattedDate);
    }
    return true;
}