function LoadControl(txtSubTotalId){
    uclblServiceTaxRate = $("#"+txtSubTotalId.replace('txtSubTotal','lblServiceTaxRate'));
    uclblEducationCessRate = $("#" + txtSubTotalId.replace('txtSubTotal', 'lblEducationCessRate')); 
    uclblHigherEducationCessRate = $("#" + txtSubTotalId.replace('txtSubTotal', 'lblHigherEducationCessRate')); 
    uclblSBCessRate = $("#" + txtSubTotalId.replace('txtSubTotal', 'lblSBCessRate')); 
    uclblKKCessRate = $("#" + txtSubTotalId.replace('txtSubTotal', 'lblKKCessRate')); 

    uchdnServiceTaxRateApplied = $("#" + txtSubTotalId.replace('txtSubTotal', 'hdnServiceTaxRateApplied'));
    uchdnEducationCessRateApplied = $("#" + txtSubTotalId.replace('txtSubTotal', 'hdnEducationCessRateApplied'));
    uchdnHigherEducationCessRateApplied = $("#" + txtSubTotalId.replace('txtSubTotal', 'hdnHigherEducationCessRateApplied'));
    uchdnSBCessRateApplied = $("#" + txtSubTotalId.replace('txtSubTotal', 'hdnSBCessRateApplied'));
    uchdnKKCessRateApplied = $("#" + txtSubTotalId.replace('txtSubTotal', 'hdnKKCessRateApplied'));

    uchdnServiceTaxRate = $("#" + txtSubTotalId.replace('txtSubTotal', 'hdnServiceTaxRate')); 
    uchdnEducationCessRate = $("#" + txtSubTotalId.replace('txtSubTotal', 'hdnEducationCessRate')); 
    uchdnHigherEducationCessRate = $("#" + txtSubTotalId.replace('txtSubTotal', 'hdnHigherEducationCessRate')); 
    uchdnSBCessRate = $("#" + txtSubTotalId.replace('txtSubTotal', 'hdnSBCessRate')); 
    uchdnKKCessRate = $("#" + txtSubTotalId.replace('txtSubTotal', 'hdnKKCessRate')); 

    uctxtSubTotal = $("#" + txtSubTotalId.replace('txtSubTotal', 'txtSubTotal')); 
    uctxtServiceTax = $("#" + txtSubTotalId.replace('txtSubTotal', 'txtServiceTax')); 
    uctxtEducationCess = $("#" + txtSubTotalId.replace('txtSubTotal', 'txtEducationCess')); 
    uctxtHigherEducationCess = $("#" + txtSubTotalId.replace('txtSubTotal', 'txtHigherEducationCess')); 
    uctxtSBCess = $("#" + txtSubTotalId.replace('txtSubTotal', 'txtSBCess')); 
    uctxtKKCess = $("#" + txtSubTotalId.replace('txtSubTotal', 'txtKKCess')); 
    uctxtGrandTotal = $("#" + txtSubTotalId.replace('txtSubTotal', 'txtGrandTotal')); 

    uchdnSubTotal = $("#" + txtSubTotalId.replace('txtSubTotal', 'hdnSubTotal'));
    uchdnServiceTax = $("#" + txtSubTotalId.replace('txtSubTotal', 'hdnServiceTax'));
    uchdnEducationCess = $("#" + txtSubTotalId.replace('txtSubTotal', 'hdnEducationCess'));
    uchdnHigherEducationCess = $("#" + txtSubTotalId.replace('txtSubTotal', 'hdnHigherEducationCess'));
    uchdnSBCess = $("#" + txtSubTotalId.replace('txtSubTotal', 'hdnSBCess'));
    uchdnKKCess = $("#" + txtSubTotalId.replace('txtSubTotal', 'hdnKKCess'));
    uchdnGrandTotal = $("#" + txtSubTotalId.replace('txtSubTotal', 'hdnGrandTotal'));

    uchdnIsRoundOffRequired = $("#" + txtSubTotalId.replace('txtSubTotal', 'hdnIsRoundOffRequired')); 
    uchdnIsServiceTaxExempted = $("#" + txtSubTotalId.replace('txtSubTotal', 'hdnIsServiceTaxExempted')); 
    uchdnServiceTaxPayer = $("#" + txtSubTotalId.replace('txtSubTotal', 'hdnServiceTaxPayer'));
    uchdnExceedAmount = $("#" + txtSubTotalId.replace('txtSubTotal', 'hdnExceedAmount')); 
    uchdnTransportMode = $("#" + txtSubTotalId.replace('txtSubTotal', 'hdnTransportMode')); 
    uchdnTransactionDate = $("#" + txtSubTotalId.replace('txtSubTotal', 'hdnTransactionDate')); 
    uchdnServiceType = $("#" + txtSubTotalId.replace('txtSubTotal', 'hdnServiceType')); 
    uchdnIsRebateApplicable = $("#" + txtSubTotalId.replace('txtSubTotal', 'hdnIsRebateApplicable')); 
    uchdnCheckExceedAmount = $("#" + txtSubTotalId.replace('txtSubTotal', 'hdnCheckExceedAmount'));
    uctxtSubTotal.attr('disabled', true);
    uctxtServiceTax.attr('disabled', true);
    uctxtEducationCess.attr('disabled', true);
    uctxtHigherEducationCess.attr('disabled', true);
    uctxtSBCess.attr('disabled', true);
    uctxtKKCess.attr('disabled', true);
    uctxtGrandTotal.attr('disabled', true);
}

function GetSubTotalValue() {
    return parseFloat(uctxtSubTotal.val());
}
function GetEducationCessValue() {
    return parseFloat(uctxtEducationCess.val());
}
function GetServiceTaxValue() {
    return parseFloat(uctxtServiceTax.val());
}
function GetHigherEducationCessValue() {
    return parseFloat(uctxtHigherEducationCess.val());
}
function GetSBCessValue() {
    return parseFloat(uctxtSBCess.val());
}
function GetKKCessValue() {
    return parseFloat(uctxtKKCess.val());
}
function GetGrandTotalValue() {
    return parseFloat(uctxtGrandTotal.val());
}
function GetServiceTaxRate() {
    return parseFloat(uchdnServiceTaxRateApplied.val());
}
function GetEducationCessRate() {
    return parseFloat(uchdnEducationCessRateApplied.val());
}
function GetHigherEducationCessRate() {
    return parseFloat(uchdnHigherEducationCessRateApplied.val());
}
function GetSBCessRate() {
    return parseFloat(uchdnSBCessRateApplied.val());
}
function GetKKCessRate() {
    return parseFloat(uchdnKKCessRateApplied.val());
}

function SetRoundOffRule(isRoundOffRequired) {
    return uchdnIsRoundOffRequired.val(isRoundOffRequired ? 'Y' : 'N');
}

function SetRebateApplicableRule(isRebateApplicable) {
    uchdnIsRebateApplicable.val(isRebateApplicable ? 'Y' : 'N');
}

function SetServiceTypeRule(serviceType) {
    uchdnServiceType.val(serviceType);
}

function SetServiceTaxExemptedRule(isServiceTaxExempted) {
    uchdnIsServiceTaxExempted.val(isServiceTaxExempted ? 'Y' : 'N');
}

function SetServiceTaxPayerRule(serviceTaxPayer) {
    uchdnServiceTaxPayer.val(serviceTaxPayer);
}

function SetTransportModeRule(transportMode) {
    uchdnTransportMode.val(transportMode);
    InitializeServiceTaxRates();
}

function SetTransactionDateRule(transactionDate) {
    uchdnTransactionDate.val(transactionDate);
}

function SetCheckExceedAmountRule(isCheckExceedAmountRule) {
    uchdnCheckExceedAmount.val(isCheckExceedAmountRule ? 'Y' : 'N');
}

function GetRoundOffRule() {
    return uchdnIsRoundOffRequired.val();
}

function GetRebateApplicableRule() {
    return uchdnIsRebateApplicable.val();
}

function GetServiceTypeRule() {
    return uchdnServiceType.val();
}

function GetServiceTaxExemptedRule() {
    return uchdnIsServiceTaxExempted.val();
}

function GetServiceTaxPayerRule() {
    return uchdnServiceTaxPayer.val();
}

function GetTransportModeRule() {
    return uchdnTransportMode.val();
}

function GetTransactionDateRule() {
    return uchdnTransactionDate.val();
}

function GetCheckExceedAmountRule() {
    return uchdnCheckExceedAmount.val();
}

function AssignSubTotalToServiceTaxControl(subTotal) {
    uctxtSubTotal.val(subTotal);
    uchdnSubTotal.val(subTotal);
    CalculateServiceTaxAmount();
}

function SetValueToZeroIfBlank(obj) {
    if (obj.val().trim() == "" || isNaN(parseFloat(obj.val())))
        obj.val(0);
}

function ApplyRoundOff(obj, roundOffRequired) {
    obj.val(roundNumber(parseFloat(obj.val()), (roundOffRequired ? 0 : 2)));
}

function InitializeServiceTaxRates() {

    var docketServiceTax =
    {
        'Date': moment(GetTransactionDateRule(), 'dd MMM yyyy'),
        'SubTotal': GetSubTotalValue(),
        'TransMode': GetTransportModeRule(),
        'StaxPayer': GetServiceTaxPayerRule(),
        'ServiceType': GetServiceTypeRule(),
        'IsRebateApplicable': GetRebateApplicableRule() == 'Y',
        'CheckExceedAmount': GetCheckExceedAmountRule() == 'Y'
    };
    var data = { dst: docketServiceTax };
    AjaxRequestWithPostAndJson(serviceUrl + '/GetServiceTaxRates', JSON.stringify(data), GetServiceTaxRatesSuccess, errorFunction, false);
}
function GetServiceTaxRatesSuccess(data) {
    var dst = JSON.parse(data.d)
    uchdnServiceTaxRate.val(dst.STaxRate); uclblServiceTaxRate.text(dst.STaxRate); uchdnServiceTaxRateApplied.val(dst.STaxRate);
    uchdnEducationCessRate.val(dst.StdEduCessRate); uclblEducationCessRate.text(dst.StdEduCessRate); uchdnEducationCessRateApplied.val(dst.StdEduCessRate);
    uchdnHigherEducationCessRate.val(dst.StdHEduCessRate); uclblHigherEducationCessRate.text(dst.StdHEduCessRate); uchdnHigherEducationCessRateApplied.val(dst.StdHEduCessRate);
    uchdnSBCessRate.val(dst.SbcRate); uclblSBCessRate.text(dst.SbcRate); uchdnSBCessRateApplied.val(dst.SbcRate);
    uchdnKKCessRate.val(dst.KKCessRate); uclblKKCessRate.text(dst.KKCessRate); uchdnKKCessRateApplied.val(dst.KKCessRate);

    CalculateServiceTaxAmount();
}
function CalculateServiceTaxAmount() {
    SetValueToZeroIfBlank(uctxtSubTotal);
    SetValueToZeroIfBlank(uchdnServiceTaxRate);
    SetValueToZeroIfBlank(uchdnEducationCessRate);
    SetValueToZeroIfBlank(uchdnHigherEducationCessRate);
    SetValueToZeroIfBlank(uchdnSBCessRate);
    SetValueToZeroIfBlank(uchdnKKCessRate);

    var serviceTaxRate = parseFloat(uchdnServiceTaxRate.val());
    var educationCessRate = parseFloat(uchdnEducationCessRate.val());
    var higherEducationCessRate = parseFloat(uchdnHigherEducationCessRate.val());
    var sbCessRate = parseFloat(uchdnSBCessRate.val());
    var kkCessRate = parseFloat(uchdnKKCessRate.val());

    var exceedAmount = parseFloat(uchdnExceedAmount.val());

    var subTotal = 0, serviceTax = 0, educationCess = 0, higherEducationCess = 0, sbCess = 0, kkCess = 0, grandTotal = 0;

    subTotal = parseFloat(uctxtSubTotal.val());

    if (uchdnIsRoundOffRequired.val() == 'Y')
        subTotal = Math.round(subTotal);
    else
        subTotal = roundNumber(subTotal, 2);

    if (uchdnIsServiceTaxExempted.val() == 'Y' || uchdnServiceTaxPayer.val() != 'T' || subTotal <= exceedAmount)
        serviceTaxRate = serviceTax = educationCessRate = higherEducationCessRate = sbCessRate = kkCessRate = 0;

    serviceTax = subTotal * serviceTaxRate / 100;
    educationCess = serviceTax * educationCessRate / 100;
    higherEducationCess = serviceTax * higherEducationCessRate / 100;
    sbCess = subTotal * sbCessRate / 100;
    kkCess = subTotal * kkCessRate / 100;

    uctxtSubTotal.val(roundNumber(subTotal, 2));
    uclblServiceTaxRate.text(roundNumber(serviceTaxRate, 2));
    uchdnServiceTaxRateApplied.val(roundNumber(serviceTaxRate, 2));
    uclblEducationCessRate.text(roundNumber(educationCessRate, 2));
    uchdnEducationCessRateApplied.val(roundNumber(educationCessRate, 2));
    uclblHigherEducationCessRate.text(roundNumber(higherEducationCessRate, 2));
    uchdnHigherEducationCessRateApplied.val(roundNumber(higherEducationCessRate, 2));
    uclblSBCessRate.text(roundNumber(sbCessRate, 2));
    uchdnSBCessRateApplied.val(roundNumber(sbCessRate, 2));
    uclblKKCessRate.text(roundNumber(kkCessRate, 2));
    uchdnKKCessRateApplied.val(roundNumber(kkCessRate, 2));
    if (uchdnIsRoundOffRequired.val() == 'Y') {
        uctxtSubTotal.val(Math.round(subTotal));
	uctxtServiceTax.val(Math.round(serviceTax));
        uctxtEducationCess.val(Math.round(educationCess));
        uctxtHigherEducationCess.val(Math.round(higherEducationCess));
        uctxtSBCess.val(Math.round(sbCess));
        uctxtKKCess.val(Math.round(kkCess));
    }
    else {
		uctxtSubTotal.val(roundNumber(subTotal, 2));
        uctxtServiceTax.val(roundNumber(serviceTax, 2));
        uctxtEducationCess.val(roundNumber(educationCess, 2));
        uctxtHigherEducationCess.val(roundNumber(higherEducationCess, 2));
        uctxtSBCess.val(roundNumber(sbCess, 2));
        uctxtKKCess.val(roundNumber(kkCess, 2));
    }

    grandTotal = parseFloat(uctxtSubTotal.val()) + parseFloat(uctxtServiceTax.val()) + parseFloat(uctxtEducationCess.val()) +
            parseFloat(uctxtHigherEducationCess.val()) + parseFloat(uctxtSBCess.val()) + parseFloat(uctxtKKCess.val());

    uchdnSubTotal.val(uctxtSubTotal.val());
    uchdnServiceTax.val(uctxtServiceTax.val());
    uchdnEducationCess.val(uctxtEducationCess.val());
    uchdnHigherEducationCess.val(uctxtHigherEducationCess.val());
    uchdnSBCess.val(uctxtSBCess.val());
    uchdnKKCess.val(uctxtKKCess.val());

    if (uchdnIsRoundOffRequired.val() == 'Y')
        uctxtGrandTotal.val(Math.round(grandTotal));
    else
        uctxtGrandTotal.val(roundNumber(grandTotal, 2));

    uchdnGrandTotal.val(uctxtGrandTotal.val());
    return false;
}
