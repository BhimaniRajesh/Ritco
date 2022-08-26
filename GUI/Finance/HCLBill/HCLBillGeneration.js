var OTHCRateType = "", OTHCRate = 0.00, ITHCRateType = "", ITHCRate = 0.00, DDMRRateType = "", DDMRRate = 0.00, MRRateType = "", MRRate = 0.00;
var txtRebate, txtTotAmount, txtNetAmount, txtVendorName, hidClickCount;
var TotalAmount = 0.00;
$(document).ready(function () {
    IntializeControls();
});
function IntializeControls() {
    txtRebate = $("input[id$=txtRebate]");
    txtTotAmount = $("input[id$=txtTotAmount]");
    txtNetAmount = $("input[id$=txtNetAmount]");
    txtVendorName = $("input[id$=txtVendorName]");

    OTHCRateType = $("select[id*='ddlOTHCRateType']");
    OTHCRate = $("input[id*='txtOTHCRate']");
    ITHCRateType = $("select[id*='ddlITHCRateType']");
    ITHCRate = $("input[id*='txtITHCRate']");
    DDMRRateType = $("select[id*='ddlDDMRRateType']");
    DDMRRate = $("input[id*='txtDDMRRate']");
    MRRateType = $("select[id*='ddlMRRateType']");
    MRRate = $("input[id*='txtMRRate']");
}
$(function () {
    $("#Dochead [id*=chkAll]").click(function () {
        if ($(this).is(":checked")) {
            $("#Dochead [id*=chkDoc]").attr("checked", "checked");
        } else {
            $("#Dochead [id*=chkDoc]").removeAttr("checked");
        }
    });
    $("#Dochead [id*=chkDoc]").click(function () {
        if ($("#Dochead [id*=chkDoc]").length == $("#Dochead [id*=chkDoc]:checked").length) {
            $("#Dochead [id*=chkAll]").attr("checked", "checked");
        } else {
            $("#Dochead [id*=chkAll]").removeAttr("checked");
        }
    });
});
$(function () {
    var cnt = 1;
    $("#Dochead>tbody>tr").each(function () {
        var lblSrno = $(this).find("label[id*='lblSrno']");
        lblSrno.html(cnt);
        cnt = cnt + 1;
    });
});

function ApplyAll() {
    var txtRate = $(this);



    $("input[id*='txtAmount']").each(function () {
        var txtAmount = $(this);
        var chkDoc = $("#" + txtAmount.attr('id').replace('txtAmount', 'chkDoc'));
        var hdnDocType = $("#" + txtAmount.attr('id').replace('txtAmount', 'hdnDocType'));
        var ddlDetRateType = $("#" + txtAmount.attr('id').replace('txtAmount', 'ddlDetRateType'));
        var txtDetRate = $("#" + txtAmount.attr('id').replace('txtAmount', 'txtDetRate'));
        var lblActWgt = $("#" + txtAmount.attr('id').replace('txtAmount', 'lblActWgt'));
        var lblTotPkg = $("#" + txtAmount.attr('id').replace('txtAmount', 'lblTotPkg'));
        var HdnOldRate = $("#" + txtAmount.attr('id').replace('txtAmount', 'HdnOldRate'));


        if (hdnDocType.val() == "OTHC") {
            ddlDetRateType.val(OTHCRateType.val());
            txtDetRate.val(OTHCRate.val());
            HdnOldRate.val(OTHCRate.val());
        }
        else if (hdnDocType.val() == "ITHC") {
            ddlDetRateType.val(ITHCRateType.val());
            txtDetRate.val(ITHCRate.val());
            HdnOldRate.val(ITHCRate.val());
        }
        else if (hdnDocType.val() == "DDMR") {
            ddlDetRateType.val(DDMRRateType.val());
            txtDetRate.val(DDMRRate.val());
            HdnOldRate.val(DDMRRate.val());
        }
        else if (hdnDocType.val() == "MR") {
            ddlDetRateType.val(MRRateType.val());
            txtDetRate.val(MRRate.val());
            HdnOldRate.val(MRRate.val());
        }

        if (ddlDetRateType.val() == "1") {
            txtAmount.val(parseFloat(txtDetRate.val()) * parseFloat(lblActWgt.html()));
        }
        else if (ddlDetRateType.val() == "2") {
            txtAmount.val(parseFloat(txtDetRate.val()) * parseFloat(lblTotPkg.html()));
        }
        if (ddlDetRateType.val() == "3") {
            txtAmount.val(txtDetRate.val());
        }
    });
}
function CalulateTotal(id) {
    var chkDoc = $(id);
    var txtAmount = $("#" + chkDoc.attr('id').replace('chkDoc', 'txtAmount'));
    if (chkDoc.is(":checked")) {
        TotalAmount = TotalAmount + parseFloat(txtAmount.val());
        txtTotAmount.val(TotalAmount.toFixed(2));
        txtNetAmount.val(TotalAmount.toFixed(2));
    }
}
function CalulateRebate() {
    var total = 0;
    total = txtTotAmount.val().toFixed(2);
    txtNetAmount.val(parseFloat(total) - parseFloat(txtRebate.val()));
}

function SetEditFlag(id) {
    var txtDetRate = $(id);
    var hdnIsEdited = $("#" + txtDetRate.attr('id').replace('txtDetRate', 'hdnIsEdited'));
    var HdnOldRate = $("#" + txtDetRate.attr('id').replace('txtDetRate', 'HdnOldRate'));
    var txtAmount = $("#" + txtDetRate.attr('id').replace('txtDetRate', 'txtAmount'));
    var ddlDetRateType = $("#" + txtDetRate.attr('id').replace('txtDetRate', 'ddlDetRateType'));
    var lblActWgt = $("#" + txtDetRate.attr('id').replace('txtDetRate', 'lblActWgt'));
    var lblTotPkg = $("#" + txtDetRate.attr('id').replace('txtDetRate', 'lblTotPkg'));


    if (HdnOldRate.val() != txtDetRate.val())
        hdnIsEdited.val(1);
    else
        hdnIsEdited.val(0);

    if (ddlDetRateType.val() == "1") {
        txtAmount.val(parseFloat(txtDetRate.val()) * parseFloat(lblActWgt.html()));
    }
    else if (ddlDetRateType.val() == "2") {
        txtAmount.val(parseFloat(txtDetRate.val()) * parseFloat(lblTotPkg.html()));
    }
    if (ddlDetRateType.val() == "3") {
        txtAmount.val(txtDetRate.val());
    }

    txtTotAmount.val(0.00);
    txtNetAmount.val(0.00);
    $("input[id*='txtAmount']").each(function () {
        var txtAmount = $(this);
        var chkDoc = $("#" + txtAmount.attr('id').replace('txtAmount', 'chkDoc'));
        if (chkDoc.is(":checked")) {
            txtTotAmount.val((parseFloat(txtTotAmount.val()) + parseFloat(txtAmount.val())).toFixed(2));
            txtNetAmount.val((parseFloat(txtNetAmount.val()) + parseFloat(txtAmount.val())).toFixed(2));
        }
    });

}
function validateOnSubmit() {
	var remarkid = "";
    try {
        if (txtVendorName.val() == "") {
            alert("Please Enter Vendor Name");
            return false;
        }
        else if (parseFloat(txtRebate.val()) > parseFloat(txtTotAmount.val())) {
            alert("Rebate cannot greater than net amount");
            txtRebate.focus();
            return false;
        }
        else if ($("#Dochead input[type='checkbox'][id*='chkDoc']:checked").length == 0) {
            alert("Select Bills");
            return false;
        }
 	else if (txtNetAmount.val() == 0) {
            alert("Net Amount can not be Zero.");
            return false;
        }
        else {
            var cnt = 0;
            $("input[id*='txtRemarks']").each(function () {
                var txtRemarks = $(this);
                var chkDoc = $("#" + txtRemarks.attr('id').replace('txtRemarks', 'chkDoc'));
                var hdnIsEdited = $("#" + txtRemarks.attr('id').replace('txtRemarks', 'hdnIsEdited'));

                if (chkDoc.is(":checked")) {
                    if (txtRemarks.val() == "" && hdnIsEdited.val() == "1") {
                        cnt++;
                        remarkid = txtRemarks.attr("id");
                        //throw (txtRemarks.attr("id"));
                        throw ("txtRemarks");
                    }
                }
            });
            if (cnt > 0) {
                alert("Please Enter Remarks for Edited Rate");
                return false;
            }
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
    catch (e) {
        //var expr = /txtRemarks/;
        //if (e.match(expr) != null){
        //    alert("Please Enter Remarks for Edited Rate");
        //    $("#" + e).focus();
        //} else {
        //    alert(e.message);
        //}
		
		if (e == "txtRemarks") {
            alert("Please Enter Remarks for Edited Rate");
            $("#" + remarkid).focus();
        } else {
            alert(e.message);
        }
		
        return false;
    }
}

function OnSubmit() {
    try {
        if (validateOnSubmit()) {
            var url = serviceUrl + "/HCLBillEntry";

            var oHCLBillGenerationHeader = {
                EntryBy: EntryBySession,
                CompanyCode: CompanyCodeSession,
                Branch: BranchSession,
                FinYear: FinyearSession,
                VendorName: txtVendorName.val(),
                TotalAmount: txtTotAmount.val(),
                RebateAmount: txtRebate.val(),
                NetAmount: txtNetAmount.val(),
                OTHCRateType: OTHCRateType.val(),
                ITHCRateType: ITHCRateType.val(),
                DDMRRateType: DDMRRateType.val(),
                MRRateType: MRRateType.val(),
                OTHCRate: OTHCRate.val(),
                ITHCRate: ITHCRate.val(),
                DDMRRate: DDMRRate.val(),
                MRRate: MRRate.val(),
                BillDetails: []
            };

            $("input[id*='txtAmount']").each(function () {
                var txtAmount = $(this);
                var chkDoc = $("#" + txtAmount.attr('id').replace('txtAmount', 'chkDoc'));
                var lblDocNo = $("#" + txtAmount.attr('id').replace('txtAmount', 'lblDocNo'));
                var ddlDetRateType = $("#" + txtAmount.attr('id').replace('txtAmount', 'ddlDetRateType'));
                var txtDetRate = $("#" + txtAmount.attr('id').replace('txtAmount', 'txtDetRate'));
                var txtRemarks = $("#" + txtAmount.attr('id').replace('txtAmount', 'txtRemarks'));
                var hdnIsEdited = $("#" + txtAmount.attr('id').replace('txtAmount', 'hdnIsEdited'));
                var lblActWgt = $("#" + txtAmount.attr('id').replace('txtAmount', 'lblActWgt'));
                var lblTotPkg = $("#" + txtAmount.attr('id').replace('txtAmount', 'lblTotPkg'));

                if (chkDoc.is(":checked")) {
                    oHCLBillGenerationHeader.BillDetails.push({
                        DocumentNo: lblDocNo.html(),
                        RateType: ddlDetRateType.val(),
                        Rate: txtDetRate.val(),
                        Amount: txtAmount.val(),
                        Remarks: txtRemarks.val(),
                        Edited: hdnIsEdited.val(),
                        TOTWT: lblActWgt.html(),
                        TOTPKGS: lblTotPkg.html()
                    });
                }
            });

            AjaxRequestWithPostAndJson(url, JSON.stringify(oHCLBillGenerationHeader), OnSubmitSuccess, OnSubmiterrorFunction, false);
        }
        else {
            return false;
        }
    }
    catch (e) { alert(e.message); return false; }
}
function OnSubmitSuccess(data) {
    window.location.href = 'HCLBillGenerationDone.aspx?BillNo=' + data;
}
function OnSubmiterrorFunction(request, status, error) {
    alert('Failed to Generate Bill');
    return false;
}