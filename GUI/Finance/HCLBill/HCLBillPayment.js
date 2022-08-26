var txtApprovedAmount, txtTds, txtPayable, ddlPayMode, txtInstrumentNo, txtInstrumentAmount, dpLRDate, ddlBankName;
var txtRebate, txtTotAmount, txtVendorName, hidClickCount;
var IsValidCheque = "";
var TotalAmount = 0.00;
$(document).ready(function () {
    IntializeControls();

    $("[id*='chkDoc']").click(function () {
        //set name for all to name of clicked 
        $("[id*='chkDoc']").not(this).attr("checked", false);
    });
});
function IntializeControls() {
    txtApprovedAmount = $("input[id$=txtApprovedAmount]");
    txtTds = $("input[id$=txtTds]");
    txtPayable = $("input[id$=txtPayable]");
    ddlPayMode = $("select[id$=ddlPayMode]");
    txtInstrumentNo = $("input[id$=txtInstrumentNo]");
    txtInstrumentAmount = $("input[id$=txtInstrumentAmount]");
    dpLRDate = $("input[id*=dpLRDate]");
    ddlBankName = $("select[id$=ddlBankName]");
}
$(function () {
    var cnt = 1;
    $("#Dochead>tbody>tr").each(function () {
        var lblSrno = $(this).find("label[id*='lblSrno']");
        lblSrno.html(cnt);
        cnt = cnt + 1;
    });
});
function CalulateTotal(id) {
    var chkDoc = $(id);
    var lblApprovedAmount = $("#" + chkDoc.attr('id').replace('chkDoc', 'lblApprovedAmount'));
    if (chkDoc.is(":checked")) {
        txtApprovedAmount.val(lblApprovedAmount.html());
        txtPayable.val(lblApprovedAmount.html());
        txtInstrumentAmount.val(lblApprovedAmount.html());

    }
}
function CalulateTds() {
    var total = 0;
    total = txtApprovedAmount.val();
    if (parseFloat(total) < parseFloat(txtTds.val())) {
        alert("You can not enter TDS more than netamount");
        txtTds.val(0.00);
        return false;
    }
    else {
        txtPayable.val(parseFloat(total) - parseFloat(txtTds.val()));
        txtInstrumentAmount.val(parseFloat(total) - parseFloat(txtTds.val()));
    }
}
function ValidateChequeNo() {
    var url = serviceUrl + "/CheckDuplicateCheque";
    var date = moment(dpLRDate.val(), "DD/MM/YYYY").format('DD MMM YYYY')
    var strdata = "{\"chequeNo\":\"" + txtInstrumentNo.val() + "\",\"chequedate\":\"" + date + "\"}";
    AjaxRequestWithPostAndJson(url, strdata, checkSuccess, errorFunction, false);
}
function checkSuccess(data) {
    IsValidCheque = data;
}
function validateOnSubmit() {
    
    try {
        if (txtInstrumentNo.val() != "" && dpLRDate.val() != "")
        {
            ValidateChequeNo();
        }
        if ($("#Dochead input[type='radio'][id*='chkDoc']:checked").length == 0) {
            alert("Select Bills");
            return false;
        }
        else if (parseFloat(txtTds.val()) > parseFloat(txtApprovedAmount.val())) {
            alert("TDS cannot greater than net amount");
            txtTds.focus();
            return false;
        }
        else if (ddlPayMode.val() == "0") {
            alert("Please select Payment Mode");
            return false;
        }
        else if (txtInstrumentNo.val() == "") {
            alert("Please Enter Instrument No");
            return false;
        }
        else if (dpLRDate.val() == "") {
            alert("Please Enter Instrument Date");
            return false;
        }
        else if (ddlBankName.val() == "0") {
            alert("Please select Bank");
            return false;
        }
        else if (IsValidCheque == "F") {
            alert("Duplicate Cheque No");
            return false;
        }
        if (!confirm("Are You Sure to Submit"))
            return false;
        var hidClickCount = $("input[id$=hidClickCount]").val();
        if (hidClickCount > 0) {
            throw new Error("Sorry... You cannot click twice !!!")
        }
        else {
            hidClickCount = hidClickCount + 1;
            hidClickCount = $("input[id$=hidClickCount]").val(hidClickCount);
        }
        return true;
    }
    catch (e) { alert(e.message); return false; }
}

function OnSubmit() {
    try {
        if (validateOnSubmit()) {
            var url = serviceUrl + "/HCLBillPayment";

            var BillNo = "";
            $("span[id*='lblBillNo']").each(function () {
                var lblBillNo = $(this);
                var chkDoc = $("#" + lblBillNo.attr('id').replace('lblBillNo', 'chkDoc'));
                if (chkDoc.is(":checked")) {
                    BillNo = lblBillNo.html();
                }
            });
            var oHCLBillPaymenentDetails = {
                BillNo: BillNo,
                Tds: txtTds.val(),
                PayableAmount: txtPayable.val(),
                PayMode: ddlPayMode.val(),
                InstrumentNo: txtInstrumentNo.val(),
                InstrumentAmount: txtInstrumentAmount.val(),
                InstrumentDate: moment(dpLRDate.val(), "DD/MM/YYYY").format('DD MMM YYYY'),
                BankName: ddlBankName.val(),
                PaymentBy: EntryBySession,
                Branch: BranchSession,
                FinYear: FinyearSession
            };
            AjaxRequestWithPostAndJson(url, JSON.stringify(oHCLBillPaymenentDetails), OnSubmitSuccess, OnSubmiterrorFunction, false);
        }
        else {
            return false;
        }
    }
    catch (e) { alert(e.message); return false; }
}
function OnSubmitSuccess(data) {
    if (data.VoucherNo != "") {
        window.location.href = 'HCLBillPaymentDone.aspx?VoucherNo=' + data.VoucherNo;
    }
    else {
        alert(data.ErrorMessage);
    }
}
function OnSubmiterrorFunction(request, status, error) {
        alert('Failed to Generate Bill');
    return false;
}
function OpenView(anch)
{
    var BillNo = $(anch).next("[id*=hdnVal]").val();
    window.open("BillPaymentView.aspx?BillNo=" + BillNo, "_blank", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
}