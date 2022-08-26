/*
Version 1.0.0.6 Rule Based customer registration allow.
Version 1.0.0.5 Added New logic if company is registerd with GST Then do overwrite Make RCM Yes to No else keep Yes as Yes.
Version 1.0.0.4 Added New logic for RCM Applicalble if NOT Register Then Make RCM To NO and calculate GST For same. 
                ALSO Removed Provisinal text and made single GST Number. 
Version 1.0.0.3 Added new validation in Submit and added logic of overwrite RCM in case of no registration. 
Version 1.0.0.2 Resolved all bugs
Version 1.0.0.1 Implemention of control logic.
*/
var ddlGroupCode, txtCustomerName, ddlGSTRegistered, txtGstCreateCGSTNumber, txtGstCreateIGSTNumber,
    txtGstCreateBillingAddress, txtGstCreateGSTINNumber, hdnGstCreateGSTINNumber,
    txtDocketSubTotal, txtGstRate, txtGSTAmount, txtDocketTotal, txtGSTCharged, hdnNonRegisterRate,
    hdnRCMApplicable, hdnSACCAtegory, hdnSACCode, hdnGSTBillingParyCode, lblBillingParyCode, hdnCityId, hdnProduct, hdnPayBaseId,
    lblPaybasis, hdnPaybasisCode, lblStateName, hdnStateCode, lblServiceType, hdnServicetypeCode, lblSACCategory,
    lblProduct, lblRCMApplicable, hdnGSTRate, lblBillingParty, lblGSTInNumber, lblGstCreateBillingStateUT, hdnGstCreateStateUT,
    lblGstCreateStateUT, lnkGstDetails, lblGstCreateBillingState,
      registerCustomer, hdnCustomerId, uploadDeclaratoin, hdnGSTRegistered,
    hdnCustomerDeclaratoinFiles, lblCustomerDeclaratoinFilesText, btnUploadDocuments, hdnIsGStDocumentScan, hdnGSTRemark,
    hdnRulesTBBAllowWithoutRegistration,
    hdnRCMApplicableActualValue, hdnDocketMode, hdnDocketNumber, hdnEnableGSTRCMLogic, hdnCompanyCode,
    hdnGSTPartyRegister, hdnGSTRegister, hdnGSTRegDeclaration, hdnDeductAmount,
    hdnDestinationBranch, hdnBilledAtBranch, hdnDestinatonCityId, hdnPartyAs, ddlGstCreateBillingStateUT,
    hdnTempCsgnCode, hdnTempCsgeCode, ddlLocation, ddlGSTExempted, ddlExemptionCategory,
    ddlCityRegistration, ddlPlaceOFSupplyCity, txtGstPinCode, txtCustomerSearch, hdnPlaceOfSupply,
    objMasterGstData, hdnActualGstCreateStateUT, hdnActualPlaceOfSupply, hdnActualSACCode;
var IsGSTRegister;
function LoadControl(mTextddlGroupCode) {
    ddlGroupCode = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'ddlGroupCode'));
    txtCustomerName = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'txtCustomerName'));
    ddlGSTRegistered = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'ddlGSTRegistered'));
    hdnGSTRegistered = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnGSTRegistered'));
    txtGstCreateCGSTNumber = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'txtGstCreateCGSTNumber'));
    txtGstCreateIGSTNumber = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'txtGstCreateIGSTNumber'));
    txtGstCreateBillingAddress = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'txtGstCreateBillingAddress'));
    txtGstCreateGSTINNumber = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'txtGstCreateGSTINNumber'));
    hdnGstCreateGSTINNumber = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnGstCreateGSTINNumber'));
    hdnIsGStDocumentScan = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnIsGStDocumentScan'));
    hdnGSTRemark = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnGSTRemark'));
    txtDocketSubTotal = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'txtDocketSubTotal'));
    txtGstRate = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'txtGstRate'));
    txtGSTAmount = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'txtGSTAmount'));
    txtDocketTotal = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'txtDocketTotal'));
    txtGSTCharged = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'txtGSTCharged'));
    hdnNonRegisterRate = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnNonRegisterRate'));
    hdnRCMApplicable = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnRCMApplicable'));
    hdnSACCAtegory = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnSACCAtegory'));
    hdnSACCode = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnSACCode'));
    hdnGSTBillingParyCode = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnGSTBillingParyCode'));
    lblBillingParyCode = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'lblBillingParyCode'));
    hdnCityId = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnCityId'));
    hdnProduct = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnProduct'));
    hdnPayBaseId = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnPayBaseId'));


    lblPaybasis = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'lblPaybasis'));
    hdnPaybasisCode = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnPaybasisCode'));
    lblStateName = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'lblStateName'));
    hdnStateCode = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnStateCode'));
    lblServiceType = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'lblServiceType'));
    hdnServicetypeCode = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnServicetypeCode'));
    lblSACCategory = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'lblSACCategory'));
    lblProduct = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'lblProduct'));
    lblRCMApplicable = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'lblRCMApplicable'));
    hdnGSTRate = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnGSTRate'));
    lblBillingParty = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'lblBillingParty'));
    lblGSTInNumber = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'lblGSTInNumber'));
    lblGstCreateBillingStateUT = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'lblGstCreateBillingStateUT'));


    hdnGstCreateStateUT = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnGstCreateStateUT'));
    lblGstCreateStateUT = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'lblGstCreateStateUT'));
    lnkGstDetails = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'lnkGstDetails'));
    lblGstCreateBillingState = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'lblGstCreateBillingState'));
    registerCustomer = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'registerCustomer'));
    hdnCustomerId = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnCustomerId'));
    hdnBookingBranch = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnBookingBranch'));
    uploadDeclaratoin = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'uploadDeclaratoin'));
    hdnCustomerDeclaratoinFiles = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnCustomerDeclaratoinFiles'));
    lblCustomerDeclaratoinFilesText = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'lblCustomerDeclaratoinFilesText'));
    btnUploadDocuments = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'btnUploadDocuments'));
    hdnRulesTBBAllowWithoutRegistration = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnRulesTBBAllowWithoutRegistration'));

    hdnRCMApplicableActualValue = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnRCMApplicableActualValue'));
    hdnDocketMode = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnDocketMode'));
    hdnDocketNumber = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnDocketNumber'));
    hdnEnableGSTRCMLogic = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnEnableGSTRCMLogic'));
    hdnCompanyCode = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnCompanyCode'));

    /*Changes for the customer registration*/
    hdnGSTPartyRegister = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnGSTPartyRegister'));
    hdnGSTRegister = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnGSTRegister'));
    hdnGSTRegDeclaration = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnGSTRegDeclaration'));
    hdnDeductAmount = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnDeductAmount'));

    hdnDestinationBranch = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnDestinationBranch'));
    hdnBilledAtBranch = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnBilledAtBranch'));
    hdnBilledAtBranchActual = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnBilledAtBranchActual'));
    hdnDestinatonCityId = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnDestinatonCityId'));
    hdnPartyAs = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnPartyAs'));
    ddlGstCreateBillingStateUT = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'ddlGstCreateBillingStateUT'));
    hdnTempCsgnCode = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnTempCsgnCode'));
    hdnTempCsgeCode = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnTempCsgeCode'));
    ddlGSTExempted = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'ddlGSTExempted'));
    ddlExemptionCategory = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'ddlExemptionCategory'));
    //ddlLocation = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'ddlLocation'));
    //ddlCityRegistration = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'ddlCityRegistration'));
    //ddlPlaceOFSupplyCity = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'ddlPlaceOFSupplyCity'));
    ddlCityRegistration = $("#ddlCityRegistration");
    ddlPlaceOFSupplyCity = $("#ddlPlaceOFSupplyCity");
    ddlLocation = $("#ddlLocation");
    hdnPlaceOfSupply = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnPlaceOfSupply'));
    txtGstPinCode = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'txtGstPinCode'));
    txtCustomerSearch = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'txtCustomerSearch'));
    hdnCustID = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnCustID'));

    hdnActualGstCreateStateUT = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnActualGstCreateStateUT'));
    hdnActualPlaceOfSupply = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnActualPlaceOfSupply'));
    hdnActualSACCode = $("#" + mTextddlGroupCode.replace('ddlGroupCode', 'hdnActualSACCode'));

    /*Smart serach and load master details. */
    AutoCompleteForGSTTaxtControl(txtCustomerSearch, serviceUrlGSTCommonService + "/CustomerAutoComplate", 'POST', 'application/json; charset=utf-8', 'json',
                'searchText', 'l', 'l', 'l', 'v', 'v', hdnCustID.attr("id"), 'No entries found!', 2, null, true);
    AjaxRequestWithPostAndJson(serviceUrl + '/GSTGetGSTMasterData', "", LoadDetailsOfMaster, errorFunction, false);
}

function validateQuickCustomerGst() {
    try {
        /*
        1) IF GSTIN NUmber exist then GST Registered must be Yes. 
        1) IF GST Registered then all details must be Mandotory. 
        */

        if (ddlGroupCode.val() == "") {
            throw new Error("Please Select Customer GROUP Code");
        }
        if (txtCustomerName.val() == "") {
            throw new Error("Please enter Customer Name");
        }


        if (ddlGSTRegistered.val() == "Y") {
            if (false) {
                if (txtGstCreateCGSTNumber.val() == "")
                    throw new Error("Please enter CGST Number");
                if (txtGstCreateIGSTNumber.val() == "")
                    throw new Error("Please enter IGST Number");
            }
            if (txtGstCreateBillingAddress.val() == "")
                throw new Error("Please enter Address");
            if (TrimData(txtGstCreateGSTINNumber.val()) == "")
                throw new Error("Please enter valid alphanumeric characters in Provisional / GSTIN Number.");
            if (TrimData(txtGstPinCode.val()) == "")
                throw new Error("Please enter pin code.");
        }
        return true;
    } catch (message) {
        alert(message.message);
        return false;
    }
}

function LoadDetailsOfMaster(data) {
    objMasterGstData = JSON.parse(data.d);
}

function CalculateGSTTax() {
    try {
        if (ddlGSTExempted.val() == "N") {
            /*Diable logic for RCM overwrite for except P02 (TBB)*/
            if (hdnRCMApplicable.val() == "Y") {
                lblRCMApplicable.text("YES");
                txtGSTAmount.val(parseFloat((parseFloat(txtGstRate.val()) * parseFloat(txtDocketSubTotal.val())) / 100).toFixed(2));
                txtGSTCharged.val(0);
                if (hdnGstCreateGSTINNumber.val() == "" && hdnEnableGSTRCMLogic.val() == "Y") {
                    hdnRCMApplicable.val("N");
                    lblRCMApplicable.text("NO");
                    txtGSTCharged.val(parseFloat((parseFloat(txtGstRate.val()) * parseFloat(txtDocketSubTotal.val())) / 100).toFixed(2));
                }
            } else {
                lblRCMApplicable.text("NO");
                txtGSTAmount.val(parseFloat((parseFloat(txtGstRate.val()) * parseFloat(txtDocketSubTotal.val())) / 100).toFixed(2));
                txtGSTCharged.val(parseFloat((parseFloat(txtGstRate.val()) * parseFloat(txtDocketSubTotal.val())) / 100).toFixed(2));
            }

            if (hdnGstCreateGSTINNumber.val() == "" && hdnEnableGSTRCMLogic.val() == "Y") {
                hdnIsGStDocumentScan.val("false");
                hdnGSTRemark.val("No GST Number Available So GST Get Charged");
            } else {
                if (hdnCustomerDeclaratoinFiles.val() != "") {
                    hdnIsGStDocumentScan.val("true");
                } else {
                    hdnIsGStDocumentScan.val("false");
                }
                hdnGSTRemark.val("");
            }

            txtDocketTotal.val(parseFloat(parseFloat(txtDocketSubTotal.val()) + parseFloat(txtGSTCharged.val())).toFixed(2));
            if (hdnDeductAmount.val().length > 0) {
                txtDocketTotal.val(parseFloat(txtDocketTotal.val()) - parseFloat(hdnDeductAmount.val()));
            }
            txtDocketSubTotal.prop("readonly", true);
            txtGstRate.prop("readonly", true);
            txtGSTAmount.prop("readonly", true);
            txtDocketTotal.prop("readonly", true);
            txtGSTCharged.prop("readonly", true);
        } else {
            hdnRCMApplicable.val("A");
            lblRCMApplicable.text("NA");
            txtGstRate.val("0.00");
            txtGSTAmount.val("0.00");
            txtGSTCharged.val("0.00");
            txtDocketTotal.val(txtDocketSubTotal.val());
        }

        if (hdnDocketMode.val() == "DeliveryMR") {
            calculateTotalforDeliveryMr();
        }
    } catch (message) {
        alert(message.message);
        return false;
    }
}

function GSTPaymentPartyCodeGet() {
    return hdnGSTBillingParyCode.val();
}
function GSTPaymentPartyCodeSet(value) {
    lblBillingParyCode.val(value);
    hdnGSTBillingParyCode.val(value);
}
function GSTPaymentPartyNameGet() {
    return lblBillingParty.text();
}
function GSTPaymentPartyNameSet(value) {
    lblBillingParty.text(value);
}
function CityIdGet() {
    return hdnCityId.val();
}
function CityIdSet(value) {
    hdnCityId.val(value);
}
function GSTPayBaseIdGet() {
    return hdnPayBaseId.val()
}
function GSTPayBaseIdSet(value) {
    hdnPayBaseId.val(value);
}
function GSTProductIDGet() {
    return hdnProduct.val();
}
function GSTProductIDSet(value) {
    hdnProduct.val(value);
}
function BookingBranchGet() {
    return hdnBookingBranch.val();
}
function BookingBranchSet(value) {
    hdnBookingBranch.val(value)
}
function SubTotalsGet() {
    return parseFloat(txtDocketSubTotal.val());
}
function SubTotalsSet(value) {
    txtDocketSubTotal.val(value)
}
function GSTBillingStateCodeGet() {
    return hdnGstCreateStateUT.val();
}
function GSTBillingStateCodeSet(value) {
    return hdnActualGstCreateStateUT.val(value);
}
function GSTINGet() {
    return hdnGstCreateGSTINNumber.val();
}
function SACCategoryGet() {
    return hdnSACCAtegory.val();
}
function SACCodeGet() {
    return hdnSACCode.val();
}
function SACCodeSet(value) {
    return hdnActualSACCode.val(value);
}
function GSTServiceTypeGet() {
    return hdnServicetypeCode.val();
}
function ISRCMApplicableGet() {
    return hdnRCMApplicable.val();
}
function IsGSTPartyRegisteredGet() {
    return hdnGSTRegistered.val();
}
function GSTRateGet() {
    return parseFloat(txtGstRate.val());
}
function GSTAmountGet() {
    return parseFloat(txtGSTAmount.val());
}
function GSTChargedGet() {
    return parseFloat(txtGSTCharged.val());
}
function DocketTotalGet() {
    return parseFloat(txtDocketTotal.val());
}
function DocketTotalSet(value) {
    txtDocketTotal.val(value)
}
function IsGStDocumentScanGet() {
    return parseFloat(hdnIsGStDocumentScan.val());
}
function GSTRemarkGet() {
    return parseFloat(hdnGSTRemark.val());
}

function DocketModeGet() {
    return hdnDocketMode.val();
}
function DocketModeSet(value) {
    hdnDocketMode.val(value);
}
function DocketNumberGet() {
    return hdnDocketNumber.val();
}
function DocketNumberSet(value) {
    hdnDocketNumber.val(value);
}
function DeductAmountGet() {
    return parseFloat(hdnDeductAmount.val());
}
function DeductAmountSet(value) {
    hdnDeductAmount.val(value)
}

function DestinatonionBranchGet() {
    return hdnDestinationBranch.val();
}
function DestinatonionBranchSet(value) {
    hdnDestinationBranch.val(value);
}

function DestinatonCityGet() {
    return hdnDestinatonCityId.val();
}
function DestinatonCitySet(value) {
    hdnDestinatonCityId.val(value);
}

function BilledAtBranchGet() {
    return hdnBilledAtBranch.val();
}
function BilledAtBranchSet(value) {
    hdnBilledAtBranch.val(value);
    hdnBilledAtBranchActual.val(value);
}

function PartyAsGet() {
    return hdnPartyAs.val();
}
function PartyAsSet(value) {
    hdnPartyAs.val(value);
}

function GSTExemptedGet() {
    return ddlGSTExempted.val();
}
function GSTExemptedSet(value) {
    ddlGSTExempted.val(value);
}
function PlaceOfSupplyGet() {
    return hdnPlaceOfSupply.val();
}
function PlaceOfSupplySet(value) {
    hdnActualPlaceOfSupply.val(value);
}
function GSTExemptionCategoryGet() {
    return ddlExemptionCategory.val();
}
function GSTExemptionCategorySet(value) {
    ddlExemptionCategory.val(value);
}

//Setting async to false means that the statement you are calling has to complete before the next statement in your function can be called.
//If you set async: true then that statement will begin it's execution and the next statement will be called regardless of whether the async statement has completed yet.
function AjaxRequest(url, type, contentType, dataType, data, successFunction, errorFunction, async) {
    $.ajax({
        type: type,
        contentType: contentType,
        url: url,
        data: data,
        dataType: dataType,
        success: successFunction,
        error: errorFunction,
        async: async
    });
}
function AjaxRequestWithPostAndJson(url, data, successFunction, errorFunction, async) {
    AjaxRequest(url, "POST", "application/json; charset=utf-8", "json", data, successFunction, errorFunction, async)
}
function errorFunction(request, status, error) {
    alert("There is something wrong, contract to support team");
}
function LoadDetailsOfCustomer(ToLoadCustomerCode) {
    var mParty = "";
    if (ToLoadCustomerCode == "" || ToLoadCustomerCode == undefined) {
        if (hdnGSTBillingParyCode.val() == "" || hdnGSTBillingParyCode.val() == "undefined") {
            mParty = "8888";
        } else {
            mParty = hdnGSTBillingParyCode.val();
        }
    } else {
        mParty = ToLoadCustomerCode;
        hdnGSTBillingParyCode.val(ToLoadCustomerCode);
    }
    if (mParty == "8888") {
        $(".customerSelection").show();
        if (hdnPartyAs.val() == "1") {
            if (hdnTempCsgnCode.val() != "8888" && hdnTempCsgnCode.val() != "") {
                mParty = hdnTempCsgnCode.val();
                hdnGSTBillingParyCode.val(hdnTempCsgnCode.val())
            }
        }
        if (hdnPartyAs.val() == "2") {
            if (hdnTempCsgeCode.val() != "8888" && hdnTempCsgeCode.val() != "") {
                mParty = hdnTempCsgeCode.val();
                hdnGSTBillingParyCode.val(hdnTempCsgeCode.val());
            }
        }
    } else {
        $(".customerSelection").hide();
    }
	
	 var module = "";
    if (hdnDocketMode.val() == "DeliveryMR") {
        module = hdnDocketMode.val();
    } else {
        module = "";
    }
	
    var mStateId = hdnActualGstCreateStateUT.val();
    var docketServiceTax =
    {
        'GSTPaymentPartyCode': mParty,
        'GSTProductID': GSTProductIDGet(),
        'GSTPayBaseId': GSTPayBaseIdGet(),
        'FromCityId': CityIdGet(),
        'DestinatonCity': DestinatonCityGet(),
        'BookingBranch': BookingBranchGet(),
        'DestinatonionBranch': DestinatonionBranchGet(),
        'BilledAtBranch': BilledAtBranchGet(),
        'PartyAs': PartyAsGet(),
        'ChangedStateId': mStateId,
		'Module': module
    };
    var data = {
        dst: docketServiceTax
    };
    AjaxRequestWithPostAndJson(serviceUrl + '/GetGSTCustomerDetails', JSON.stringify(data), LoadDetailsOfCustomerSuccess, errorFunction, false);
}
function LoadDetailsOfCustomerSuccess(data) {
    try {
        if (AJAXState != undefined) {
            AJAXState = 0
        }
    } catch (ex) {

    }
    try {
        var dst = JSON.parse(data.d)
        if (dst.Table.length > 0) {
            if (dst.Table1.length == 0) {
                alert("Service type is not MAP IN GST please map same.");
                return false;
            }
            if (dst.Table2.length != 1) {
                alert("City is not mapped with valid State master, please check same.");
                return false;
            }

            $("#tableGstDetails > tbody").remove();
            $.each(dst.Table3, function (index, obj) {
                newOtherChargeRow = "<tr class='nrow'>";
                var fontBold = '';
                if (obj.GSTINNUMBER == dst.Table2[0].GSTINNUMBER) {
                    var fontBold = ' style="FONT-WEIGHT: bold; COLOR: green" ';
                }

                newOtherChargeRow += "<td" + fontBold + ">" + obj.GSTINNUMBER + "</td>";
                newOtherChargeRow += "<td" + fontBold + ">" + obj.STATENAME + "</td>";
                newOtherChargeRow += "<td" + fontBold + ">" + obj.CITYNAME + "</td>";
                newOtherChargeRow += "<td" + fontBold + ">" + obj.STATEBILLINGADDRESS + "</td>";
                newOtherChargeRow += "<td" + fontBold + ">" + obj.GSTPINCODE + "</td>";
                newOtherChargeRow += "</tr>";

                $("#tableGstDetails").append(newOtherChargeRow.replace(/\\n/g, "<br />"));
            });

            IsGSTRegister = false;
            lblPaybasis.html(dst.Table1[0].PAYBASIS);
            hdnPaybasisCode.val(dst.Table1[0].PAYBASISCODE);
            lblStateName.html(dst.Table1[0].STATENAME);

            hdnStateCode.val(dst.Table1[0].STATECODE);
            lblServiceType.html(dst.Table1[0].SERVICETYPENAME);
            hdnServicetypeCode.val(dst.Table1[0].SERVICETYPEID);
            lblSACCategory.html(dst.Table1[0].SACCATEGORY);
            hdnSACCAtegory.val(dst.Table1[0].SACCATEGORYID);
            hdnSACCode.val(dst.Table1[0].SACCODE);
            lblProduct.html(dst.Table1[0].PRODUCT);
            hdnProduct.val(dst.Table1[0].PRODUCTID);
            lblRCMApplicable.html(dst.Table1[0].RCMAPPLICABLENAME);

            if (dst.Table1[0].RCMAPPLICABLE == "true" || dst.Table1[0].RCMAPPLICABLE == true || dst.Table1[0].RCMAPPLICABLE == "1") {
                hdnRCMApplicable.val("Y")
                hdnRCMApplicableActualValue.val("Y")
            } else {
                hdnRCMApplicable.val("N")
                hdnRCMApplicableActualValue.val("N")
            }
            txtGstRate.val(dst.Table1[0].GSTRATE);
            hdnNonRegisterRate.val(dst.Table1[0].NONREGISTERRATE);
            hdnGSTRate.val(dst.Table1[0].GSTRATE);

            /*State wise billing address.*/
            lblGSTInNumber.html(dst.Table2[0].GSTINNUMBER.length == 0 ? "Not Registered" : dst.Table2[0].GSTINNUMBER);
            IsGSTRegister = dst.Table2[0].ISREGISTER;
            txtGstCreateGSTINNumber.val(dst.Table2[0].GSTINNUMBER);
            hdnGstCreateGSTINNumber.val(dst.Table2[0].GSTINNUMBER);
            lblGstCreateBillingStateUT.html(dst.Table2[0].STATENAME);
            ddlGstCreateBillingStateUT.val(dst.Table2[0].STATEID)
            hdnGstCreateStateUT.val(dst.Table2[0].STATEID);
            lblGstCreateStateUT.html(dst.Table2[0].STATETYPE);

            txtGstCreateBillingAddress.val(dst.Table2[0].STATEBILLINGADDRESS);
            lblGstCreateBillingState.html(dst.Table2[0].STATENAME);

            /*City State Details. and one time registration details.*/
            txtGstCreateCGSTNumber.val(dst.Table[0].CSGTNUMBER);
            txtGstCreateIGSTNumber.val(dst.Table[0].IGSTNUMBER);
            lblBillingParty.text(dst.Table[0].BILLINGPARTYNAME);
            hdnGSTBillingParyCode.val(dst.Table[0].BILLINGPARTYCODE);
            lblBillingParyCode.text(dst.Table[0].BILLINGPARTYCODE);

            if (dst.Table1[0].ALLOWESELECTIONSTATE == "1") {
                ddlGstCreateBillingStateUT.prop("disabled", false);
                /*Bind Location dropdown based on location.*/
                ReBindLocationBasedOnSelectedState();
                //ddlLocation.prop("disabled", false);
            } else {
                ddlGstCreateBillingStateUT.prop("disabled", true);
                /*Bind Location dropdown based on location.*/
                ReBindLocationBasedOnSelectedState();
                //ddlLocation.prop("disabled", true);                
            }

            if ($('#' + ddlLocation.attr("id")).find('option[value="' + hdnBilledAtBranchActual.val() + '"]').length > 0) {
                ddlLocation.val(hdnBilledAtBranchActual.val());
            } else if ($('#' + ddlLocation.attr("id")).find('option[value="' + BilledAtBranchGet() + '"]').length > 0) {
                ddlLocation.val(BilledAtBranchGet());
            }

            if ($('#' + ddlCityRegistration.attr("id")).find('option[value="' + dst.Table2[0].CITYNAME + '"]').length > 0) {
                ddlCityRegistration.val(dst.Table2[0].CITYNAME);
                ddlPlaceOFSupplyCity.val(dst.Table2[0].CITYNAME);
                hdnPlaceOfSupply.val(ddlPlaceOFSupplyCity.val());
            }
            if ($('#' + ddlCityRegistration.attr("id")).find('option[value="' + hdnPlaceOfSupply.val() + '"]').length > 0) {
                ddlPlaceOFSupplyCity.val(hdnPlaceOfSupply.val());
                hdnPlaceOfSupply.val(ddlPlaceOFSupplyCity.val());
            }
            if (hdnActualPlaceOfSupply.val().length > 0) {
                if ($('#' + ddlCityRegistration.attr("id")).find('option[value="' + hdnActualPlaceOfSupply.val() + '"]').length > 0) {
                    ddlCityRegistration.val(hdnActualPlaceOfSupply.val());
                    ddlPlaceOFSupplyCity.val(hdnActualPlaceOfSupply.val());
                    hdnPlaceOfSupply.val(ddlPlaceOFSupplyCity.val());
                }
            }

            if (IsGSTRegister) {
                ddlGSTRegistered.val("Y");
                hdnGSTRegistered.val("Y")
                lnkGstDetails.html("(View GST Detail)");
                ddlGSTRegistered.prop("disabled", true);
                $('.ui-dialog-buttonset button:contains("Save")').button().hide();
            } else {
                ddlGSTRegistered.val("N");
                hdnGSTRegistered.val("N")
                lnkGstDetails.html("(Register Customer/GST Detail)");
                ddlGSTRegistered.prop("disabled", false);
                $('.ui-dialog-buttonset button:contains("Save")').button().show();
            }

            if (hdnGSTBillingParyCode.val() == "" || hdnGSTBillingParyCode.val() == "8888") {
                registerCustomer.show();
                ddlGroupCode.prop("disabled", false);
                txtCustomerName.prop("readonly", false);
            } else {
                registerCustomer.hide();
                ddlGroupCode.prop("disabled", true);
                ddlGroupCode.val(dst.Table[0].GROUPCODE)
                txtCustomerName.prop("readonly", true);
                txtCustomerName.val(dst.Table[0].BILLINGPARTYNAME);
                hdnCustomerId.val((dst.Table[0].BILLINGPARTYCODE == "8888" ? "" : dst.Table[0].BILLINGPARTYCODE));
            }
            /*CODE FOR DECLARATION*/
            hdnCustomerDeclaratoinFiles.val(dst.Table[0].DECLARATIONFILE);
            if (dst.Table[0].DECLARATIONFILE.length > 0) {
                lblCustomerDeclaratoinFilesText.text("Declaration Uploaded");
                btnUploadDocuments.hide();
            } else {
                lblCustomerDeclaratoinFilesText.text("");
                btnUploadDocuments.show();
            }
            /*END CODE FOR DECLARATION*/
            onGstRegistrationChange();

            /*GST Changes 07-07-2017 For Version V 1.0.0.5*/
            if (hdnGSTPartyRegister.val() != "Y") {
                if (hdnGSTBillingParyCode.val() == "" || hdnGSTBillingParyCode.val() == "8888") {
                    registerCustomer.hide();
                    lnkGstDetails.hide();
                }
            }
            if (hdnGSTRegister.val() != "Y") {
                if (!(hdnGSTBillingParyCode.val() == "" || hdnGSTBillingParyCode.val() == "8888")) {
                    lnkGstDetails.show();
                }
                if (hdnGstCreateGSTINNumber.val() == "") {
                    ddlGSTRegistered.val("N");
                    ddlGSTRegistered.prop("disabled", true);
                }
            }

            txtCustomerSearch.val("");
            hdnCustID.val("");
        }
        if (txtGstCreateBillingAddress.val().length > 0) {
            txtGstCreateBillingAddress.prop("readonly", true);
        } else {
            txtGstCreateBillingAddress.prop("readonly", false);
        }
        if (txtGstCreateGSTINNumber.val().length > 0) {
            txtGstCreateGSTINNumber.prop("readonly", true);
        } else {
            txtGstCreateGSTINNumber.prop("readonly", false);
        }
        onGSTExemptedChange();
    } catch (ex) {
        alert(ex.message);
    }
}

function showDetails() {
    if (hdnGstCreateGSTINNumber.val() != "") {
        $("#lightGstDetails").dialog({
            resizable: true,
            height: "auto",
            width: 900,
            modal: true,
            buttons: {
                Cancel: function () {
                    $(this).dialog("close");
                }
            }
        });
    } else {
        $("#lightGstDetails").dialog({
            resizable: true,
            closeOnEscape: false,
            open: function (event, ui) {
                $(".ui-dialog-titlebar-close", ui.dialog | ui).hide();
            },
            height: "auto",
            width: 900,
            modal: true,
            buttons: {
                "Save": function () {
                    if (ddlGSTRegistered.val() == "N") {
                        //ValidateAndGo();
                        FileUpload();
                    } else {
                        //ValidateAndGo();
                        saveDetails();
                    }
                },
                Cancel: function () {
                    $(this).dialog("close");
                }
            }
        });
    }
}

function saveDetails() {
    var partyCode = hdnGSTBillingParyCode.val();
    if (hdnGSTBillingParyCode.val() == "8888") {
        partyCode = "";
    }
    try {
        if (validateQuickCustomerGst()) {
            var customerGSTDetail =
            {
                'CUSTCD': partyCode,
                'GRPCD': ddlGroupCode.val(),
                'CUSTNM': txtCustomerName.val(),
                'CUSTPASS': partyCode,
                'CUSTCAT': GSTPayBaseIdGet(),
                'BookingBranch': hdnBookingBranch.val(),
                'ServiceOptFor': '',
                //'GSTBillingState': hdnGstCreateStateUT.val(),
                //'GSTBillingCity': ddlCityRegistration.val(),
                'CGSTnumber': txtGstCreateCGSTNumber.val(),
                'IGSTnumber': txtGstCreateIGSTNumber.val(),
                'GSTBillingAddress': txtGstCreateBillingAddress.val(),
                'BillingStateCode': hdnGstCreateStateUT.val(),
                'BillingAddress': txtGstCreateBillingAddress.val(),
                'BillingCityCode': ddlCityRegistration.val(),
                'ProvisionalNumber': txtGstCreateGSTINNumber.val(),
                'GSTINNumber': txtGstCreateGSTINNumber.val(),
                'DeclarationFile': hdnCustomerDeclaratoinFiles.val(),
                'GstPincode': txtGstPinCode.val()
            };
            var data = {
                dst: customerGSTDetail
            };
            AjaxRequestWithPostAndJson(serviceUrl + '/GSTCustomerDetailsPush', JSON.stringify(data), setDetailsOfCustomerSuccess, errorFunction, false);
        }
    } catch (message) {
        alert(message.message);
        return false;
    }
}

function setDetailsOfCustomerSuccess(data) {
    try {
        if (AJAXState != undefined) {
            AJAXState = 0
        }
    } catch (ex) {

    }
    var dst = JSON.parse(data.d)
    if (dst.Table[0].IsSuccess == 1) {
        hdnGSTBillingParyCode.val(dst.Table[0].CUSTCD);
        txtCustomerName.val(dst.Table[0].CUSTNM);
        if (hdnPartyAs.val() == "1") {
            hdnTempCsgnCode.val(dst.Table[0].CUSTCD);
        }
        if (hdnPartyAs.val() == "2") {
            hdnTempCsgeCode.val(dst.Table[0].CUSTCD);
        }
        LoadDetails();
        $('#lightGstDetails').dialog('close');
        return true
    } else {
        try {
            $body.removeClass("loading");
        } catch (ex) {
        }
        try {
            $('body').removeClass("loading");
        } catch (ex) {
        }
        $("#Progress_Bar").hide();
        //throw new Error(dst.Table[0].Error);
        alert(dst.Table[0].Error)
        return false;
    }
}
function TrimData(x) {
    return x.replace(/^\s+|\s+$/gm, '');
}
function validationOnSubmit() {
    if (hdnCustomerId.val() == "" || hdnCustomerId.val() == "8888" ||
        hdnGSTBillingParyCode.val() == "8888" || hdnGSTBillingParyCode.val() == "") {
        throw new Error("WalkIn Customer are not allowed in GST, please create customer from Register customer.");
    }
    if (hdnCustomerId.val() != hdnGSTBillingParyCode.val()) {
        throw new Error("There is some issue in selecting billing party, please re-load or start again.");
    }
    if (ddlLocation.val() == "" || ddlLocation.val()==null) {
        throw new Error("Please select billed at branch.");
    }
    /*Disable TBB Logic As Added logic of owertie*/
    if (false) {
        if (hdnPayBaseId.val() == "P02" && (hdnDocketMode.val() == "NEW" || hdnDocketMode.val() == "")) {
            if (hdnGstCreateGSTINNumber.val() == "") {
                /*Check TBB Rules.*/
                if (hdnRulesTBBAllowWithoutRegistration.val() == "Y") {
                    var toAllowWithoutRegistration = confirm("For TBB, Without GST Registration billing will be not processed, Do you want to continue without registration?");
                    if (!toAllowWithoutRegistration) {
                        if (ddlGSTRegistered.val() == "Y") {
                            if (false) {
                                if (txtGstCreateCGSTNumber.val() == "")
                                    throw new Error("Please enter CGST Number");
                                if (txtGstCreateIGSTNumber.val() == "")
                                    throw new Error("Please enter IGST Number");
                            }
                            if (txtGstCreateBillingAddress.val() == "")
                                throw new Error("Please enter Address");
                            if (TrimData(txtGstCreateGSTINNumber.val()) == "")
                                throw new Error("Please enter valid alphanumeric characters in Provisional / GSTIN Number.");
                            if (hdnGstCreateGSTINNumber.val() == "")
                                throw new Error("Please save GST Details and processed for docket entry. ");
                        } else {
                            if (hdnGstCreateGSTINNumber.val() == "")
                                throw new Error("Please save GST Details and processed for docket entry. ");
                        }
                    }
                } else {
                    throw new Error("For TBB Customer registration and GST Registration is mandatory.");
                }
            }
        } else {
            if (ddlGSTRegistered.val() == "Y") {
                if (false) {
                    if (txtGstCreateCGSTNumber.val() == "")
                        throw new Error("Please enter CGST Number");
                    if (txtGstCreateIGSTNumber.val() == "")
                        throw new Error("Please enter IGST Number");
                }
                if (txtGstCreateBillingAddress.val() == "")
                    throw new Error("Please enter Address");
                if (TrimData(txtGstCreateGSTINNumber.val()) == "")
                    throw new Error("Please enter valid alphanumeric characters in Provisional / GSTIN Number.");
                if (hdnGstCreateGSTINNumber.val() == "")
                    throw new Error("Please save GST Details and processed for docket entry. ");
            }
        }
    }
    if (ddlGSTExempted.val() == "Y") {
        if (ddlExemptionCategory.val() == "")
            throw new Error("Please select exemption category");
    }
    if (hdnRCMApplicable.val() != hdnRCMApplicableActualValue.val() && ddlGSTExempted.val() == "N") {
        var toProcessWithChangedValue = confirm("There is RCM Applicable but due to no registration of GST the RCM Applicable is NO, Do you want to continue without registration ?");
        if (!toProcessWithChangedValue) {
            if (ddlGSTRegistered.val() == "Y") {
                if (false) {
                    if (txtGstCreateCGSTNumber.val() == "")
                        throw new Error("Please enter CGST Number");
                    if (txtGstCreateIGSTNumber.val() == "")
                        throw new Error("Please enter IGST Number");
                }
                if (txtGstCreateBillingAddress.val() == "")
                    throw new Error("Please enter Address");
                if (TrimData(txtGstCreateGSTINNumber.val()) == "")
                    throw new Error("Please enter valid alphanumeric characters in Provisional / GSTIN Number.");
                if (hdnGstCreateGSTINNumber.val() == "")
                    throw new Error("Please save GST Details and processed for docket entry. ");
            } else {
                if (hdnGstCreateGSTINNumber.val() == "")
                    throw new Error("Please save GST Details and processed for docket entry. ");
            }
        }
    }
    return true;
}

function onGstRegistrationChange() {
    if (hdnRulesTBBAllowWithoutRegistration.val() != "Y") {
        if (hdnPayBaseId.val() == "P02") {
            if (ddlGSTRegistered.val() != "Y") {
                ddlGSTRegistered.val("Y");
                ddlGSTRegistered.prop("disabled", true);
            }
        }
    }

    if (ddlGSTRegistered.val() == "Y") {
        $(".gstMasterDetails").show();
        $(".gstMasterDetailsDataCapture").show();
        $(".colDeclaration").hide();
    } else {
        $(".gstMasterDetails").hide();
        $(".gstMasterDetailsDataCapture").hide();
        if (hdnGSTRegDeclaration.val() == "Y") {
            $(".colDeclarationTitle").show();
            if (hdnCustomerDeclaratoinFiles.val().length > 0) {
                btnUploadDocuments.hide();
                lblCustomerDeclaratoinFilesText.show();
                lblCustomerDeclaratoinFilesText.text("Declaration Uploaded");
            } else {
                lblCustomerDeclaratoinFilesText.text("");
                btnUploadDocuments.show();
            }
        } else {
            $(".colDeclarationTitle").hide();
            btnUploadDocuments.hide();
            if (hdnCustomerDeclaratoinFiles.val().length > 0) {
                lblCustomerDeclaratoinFilesText.show();
                lblCustomerDeclaratoinFilesText.text("Declaration Uploaded");
            }
        }
    }
    if (hdnCustomerDeclaratoinFiles.val() != "") {
        $(".uploadFileDeclaration").hide();
    }
    if ($("#tableGstDetails>tbody>tr").length > 0) {
        $(".gstMasterDetails").show();
    }
    if (IsGSTRegister) {
        $(".gstMasterDetailsDataCapture").hide();
    }
    hdnGSTRegistered.val(ddlGSTRegistered.val());
}


function FileUpload() {
    var partyCode = hdnGSTBillingParyCode.val();
    if (hdnGSTBillingParyCode.val() == "8888") {
        partyCode = "";
    }
    if (txtCustomerName.val() == "") {
        alert("Please enter customer name");
        return false;
    }
    if (ddlGroupCode.val() == "") {
        alert("Please select Group Code");
        return false;
    }

    var customerGSTDetail =
    {
        'CUSTCD': partyCode,
        'GRPCD': ddlGroupCode.val(),
        'CUSTNM': txtCustomerName.val(),
        'CUSTPASS': partyCode,
        'CUSTCAT': GSTPayBaseIdGet(),
        'BookingBranch': hdnBookingBranch.val(),
        'ServiceOptFor': '',
        //'GSTBillingState': hdnGstCreateStateUT.val(),
        //'GSTBillingCity': ddlCityRegistration.val(),
        'CGSTnumber': txtGstCreateCGSTNumber.val(),
        'IGSTnumber': txtGstCreateIGSTNumber.val(),
        'GSTBillingAddress': txtGstCreateBillingAddress.val(),
        'BillingStateCode': hdnGstCreateStateUT.val(),
        'BillingAddress': txtGstCreateBillingAddress.val(),
        'BillingCityCode': ddlCityRegistration.val(),
        'ProvisionalNumber': txtGstCreateGSTINNumber.val(),
        'GSTINNumber': txtGstCreateGSTINNumber.val(),
        'DeclarationFile': hdnCustomerDeclaratoinFiles.val()
    };
    var data = {
        dst: customerGSTDetail
    };
    AjaxRequestWithPostAndJson(serviceUrl + '/GSTCustomerDetailsPush', JSON.stringify(data), setDetailsOfCustomerSuccess, errorFunction, true);
}
function getThing(id) {
    features = 'locationbar=X,menubar=Y...';
    var url = urlPoupFileUpload + "?CustomerId=" + hdnGSTBillingParyCode.val();
    window['popup4GstCustomerUpload'] = open(url, 'someNameWithoutSpaces', features);
}
function popupCallback(data) {
    hdnCustomerDeclaratoinFiles.val(data);
    //close the popup (now that we have/are done with the data)
    window['popup4GstCustomerUpload'].close();
    lblCustomerDeclaratoinFilesText.text("Declaration Uploaded");
    lblCustomerDeclaratoinFilesText.show();
    btnUploadDocuments.hide();
}
var alpha = "[ A-Za-z]";
var numeric = "[0-9]";
var alphanumeric = "[ A-Za-z0-9]";
var float = "^(?:[1-9]\d*|0)?(?:\.\d{2})?$";
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

function LoadDetails() {
    var mParty = "";
    mParty = hdnGSTBillingParyCode.val();
    var docketServiceTax =
    {
        'GSTPaymentPartyCode': mParty,
        'GSTProductID': GSTProductIDGet(),
        'GSTPayBaseId': GSTPayBaseIdGet(),
        'FromCityId': CityIdGet(),
        'DestinatonCity': DestinatonCityGet(),
        'BookingBranch': BookingBranchGet(),
        'DestinatonionBranch': DestinatonionBranchGet(),
        'BilledAtBranch': BilledAtBranchGet(),
        'PartyAs': PartyAsGet(),
        'ChangedStateId': ddlGstCreateBillingStateUT.val()
    };
    var data = {
        dst: docketServiceTax
    };
    AjaxRequestWithPostAndJson(serviceUrl + '/GetGSTCustomerDetails', JSON.stringify(data), LoadDetailsOfCustomerSuccess, errorFunction, false);

    ddlGSTRegistered.val("Y");
    onGstRegistrationChange();


}

function ReBindLocationBasedOnSelectedState() {
    var locData = objMasterGstData.Table;
    ddlLocation.empty();
    for (var i in locData) {
        if (locData[i].LOCSTATE == ddlGstCreateBillingStateUT.val()) {
            var newOption = $('<option>');
            newOption.attr('value', locData[i].LOCCODE).text(locData[i].LOCCODE + " : " + locData[i].LOCNAME);
            ddlLocation.append(newOption);
        }
    }
    if (ddlLocation.children('option').length == 0) {
        for (var i in locData) {
            if (locData[i].LOCCODE.toUpperCase() == "HQTR") {
                var newOption = $('<option>');
                newOption.attr('value', locData[i].LOCCODE).text(locData[i].LOCCODE + " : " + locData[i].LOCNAME);
                ddlLocation.append(newOption);
            }
        }
    }    

    var CityData = objMasterGstData.Table1;
    ddlCityRegistration.empty();
    ddlPlaceOFSupplyCity.empty();
    for (var i in CityData) {
        if (CityData[i].S == ddlGstCreateBillingStateUT.val()) {
            var newOption = $('<option>');
            newOption.attr('value', CityData[i].C).text(CityData[i].C);
            ddlCityRegistration.append(newOption);
            var newOption = $('<option>');
            newOption.attr('value', CityData[i].C).text(CityData[i].C);
            ddlPlaceOFSupplyCity.append(newOption);
        }
    }
    ChangeLocationCall();
}

function ChangeLocationCall(k) {
    var locData = objMasterGstData.Table;
    for (var i in locData) {
        if (locData[i].LOCCODE == ddlLocation.val()) {
            if ($('#' + ddlCityRegistration.attr("id")).find('option[value="' + locData[i].LOCCITY + '"]').length > 0) {
                ddlCityRegistration.val(locData[i].LOCCITY);
            }
            if ($('#' + ddlPlaceOFSupplyCity.attr("id")).find('option[value="' + locData[i].LOCCITY + '"]').length > 0) {
                ddlPlaceOFSupplyCity.val(locData[i].LOCCITY);
            }
        }
    }
    hdnBilledAtBranch.val(ddlLocation.val());
    hdnPlaceOfSupply.val(ddlPlaceOFSupplyCity.val());
}

function onGSTExemptedChange() {
    if (ddlGSTExempted.val() == "Y") {
        $(".ExemptionCategory").show();
    } else {
        $(".ExemptionCategory").hide();
        hdnRCMApplicable.val(hdnRCMApplicableActualValue.val());
        txtGstRate.val(hdnGSTRate.val());
    }
    CalculateGSTTax();
}


function AutoCompleteForGSTTaxtControl(eleId, url, type, contentType, dataType, prefixText, focus, select, s1, s2, EvalOrtext, eleVal, alertMsg, minPrefixLength, additionalData, disableNotFoundAlert) {
    try {
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
                            //$(eleId).val("");
                            $("#" + eleVal).val('NAFOUND');
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
    } catch (ex) {

    }
}

function OnBlurCustomerSelection(id) {
    if (hdnCustID.val() == "NAFOUND") {
        hdnGSTBillingParyCode.val("8888");
        txtCustomerName.val(txtCustomerSearch.val());
        LoadDetails();
    } else if (hdnCustID.val() != "") {
        if (confirm("Are you sure to continue with customer " + hdnCustID.val() + " : " + txtCustomerSearch.val() + " ?")) {
            hdnGSTBillingParyCode.val(hdnCustID.val());
            LoadDetails();
        } else {
            hdnGSTBillingParyCode.val("8888");
            txtCustomerName.val(txtCustomerSearch.val());
            LoadDetails();
        }
    }
}
function OnChangePlaceOFSupplyCity() {
    hdnPlaceOfSupply.val(ddlPlaceOFSupplyCity.val());
}
