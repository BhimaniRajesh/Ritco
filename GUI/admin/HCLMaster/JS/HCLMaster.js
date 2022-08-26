
var txtBranchcode, hdnBranch;

$(document).ready(function () {
    $('#aspnetForm').attr("enctype", "multipart/form-data");
    IntializeControls();
    AutoCompleteByAjax(txtBranchcode, serviceUrl + "/GetBranch", "POST", "application/json; charset=utf-8", "json", "prefix", 'l', 'l', 'l', 'v', hdnBranch.attr('id'), 'Invalid Branch.');
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
});
function EndRequestHandler(sender, args) {
    IntializeControls();
    AutoCompleteByAjax(txtBranchcode, serviceUrl + "/GetBranch", "POST", "application/json; charset=utf-8", "json", "prefix", 'l', 'l', 'l', 'v', hdnBranch.attr('id'), 'Invalid Branch.');
}
function IntializeControls() {
    txtBranchcode = $("#" + controlIdPrefix + "txtBranchcode");
    hdnBranch = $("#" + controlIdPrefix + "hdnBranch");

    ddlOutgoingTHCType = $("#" + controlIdPrefix + "ddlOutgoingTHCType");
    txtOutgoingTHCRate = $("#" + controlIdPrefix + "txtOutgoingTHCRate");
    txtOutgoingTHCFromDate = $("#" + controlIdPrefix + "txtOutgoingTHCFromDate");
    txtOutgoingTHCToDate = $("#" + controlIdPrefix + "txtOutgoingTHCToDate");

    ddlIncomingTHCType = $("#" + controlIdPrefix + "ddlIncomingTHCType");
    txtIncomingTHCRate = $("#" + controlIdPrefix + "txtIncomingTHCRate");
    txtIncomingTHCFromDate = $("#" + controlIdPrefix + "txtIncomingTHCFromDate");
    txtIncomingTHCToDate = $("#" + controlIdPrefix + "txtIncomingTHCToDate");

    ddlDDMR = $("#" + controlIdPrefix + "ddlDDMR");
    txtDDMRRate = $("#" + controlIdPrefix + "txtDDMRRate");
    txtDDMRFromDate = $("#" + controlIdPrefix + "txtDDMRFromDate");
    txtDDMRToDate = $("#" + controlIdPrefix + "txtDDMRToDate");

    ddlMR = $("#" + controlIdPrefix + "ddlMR");
    txtMRRate = $("#" + controlIdPrefix + "txtMRRate");
    txtMRFromDate = $("#" + controlIdPrefix + "txtMRFromDate");
    txtMRToDate = $("#" + controlIdPrefix + "txtMRToDate");

    btnSubmit = $("#" + controlIdPrefix + "btnSubmit");
    btnViewData = $("#" + controlIdPrefix + "btnViewData");
    tblMain = $("#" + controlIdPrefix + "tblMain");
}

function IscheckDate(obj) {

    var dtOutgoingTHCFromDate = txtOutgoingTHCFromDate.val();
    var dtOutgoingTHCToDate = txtOutgoingTHCToDate.val();
    var dtIncomingThcFromDate = txtIncomingTHCFromDate.val();
    var dtIncomingThcToDate = txtIncomingTHCToDate.val();
    var dtDDMRFromDate = txtDDMRFromDate.val();
    var dtDDMRToDate = txtDDMRToDate.val();
    var dtMRFromDate = txtMRFromDate.val();
    var dtMRToDate = txtMRToDate.val();
    var format = 'dd/MM/yyyy';
    var OutgoingResult = compareDates(dtOutgoingTHCFromDate, format, dtOutgoingTHCToDate, format);
    var IncomingResult = compareDates(dtIncomingThcFromDate, format, dtIncomingThcToDate, format);
    var DDMRResult = compareDates(dtDDMRFromDate, format, dtDDMRToDate, format);
    var MRResult = compareDates(dtMRFromDate, format, dtMRToDate, format);
    
    if (OutgoingResult == 1)/// end date is less than start date
    {
        alert("Outgoing THC From Date Can't be greater than To Date.");
        return false;
    }
    if (IncomingResult == 1)/// end date is less than start date
    {
        alert("Incoming THC From Date Can't be greater than To Date.");
        return false;
    }
    if (DDMRResult == 1)/// end date is less than start date
    {
        alert("DDMR THC From Date Can't be greater than To Date.");
        return false;
    }
    if (MRResult == 1)/// end date is less than start date
    {
        alert("MR THC From Date Can't be greater than To Date.");
        return false;
    }
   
    //if (Date.parse(from) > Date.parse(to))
    //{
    //    alert("Outgoing THC From Date Can't be greater than To Date.");
    //    txtOutgoingTHCToDate.value = "";
    //   // txtOutgoingTHCToDate.focus();
    //    return false;
    //}
    //if (txtIncomingTHCFromDate.val() > txtIncomingTHCToDate.val()) {
    //    alert("Incoming THC From Date Can't be greater than To Date.");
    //    txtIncomingTHCToDate.value = "";
    //   // txtIncomingTHCToDate.focus();
    //    return false;
    //}
    //if (txtDDMRFromDate.val() > txtDDMRToDate.val()) {
    //    alert("DDMR THC From Date Can't be greater than To Date.");
    //    txtDDMRToDate.value = "";
    //    //txtDDMRToDate.focus();
    //    return false;
    //}
    //if (txtMRFromDate.val() > txtMRToDate.val()) {
    //    alert("MR THC From Date Can't be greater than To Date.");
    //    txtMRToDate.value = "";
    //    //txtMRToDate.focus();
    //    return false;
    //}
    return true;
}
var txtBranch;
function IsBranchExist(obj) {
    var id = $(obj).attr('id');
    txtBranchcode = obj;
    if (obj.value != "") {
        if (hdnBranch.val() == "") {
            var url = serviceUrl + "/IsBranchExist";
            var strdata = "{\"BranchCode\":\"" + obj.value + "\"}";
            AjaxRequestWithPostAndJson(url, strdata, checkBranchSuccess, errorFunction, false);
        }
        else {
          
        }
    }
    else {
        return true;
    }
}

function checkBranchSuccess(data) {
    if (data.IsBranchExistResult.length > 0) {
        $.each(data.IsBranchExistResult, function () {
            if (this['IsBranchExist'] == "True") {
                hdnBranch.val(this['BranchCode']);
            }
            else {
                txtBranch.value = "";
                txtBranch.focus();
                alert("Invalid Branch Code.");
                return false;
            }
        });

        return true;
    }
    else {
        txtBranch.value = "";
        txtBranch.focus();
        alert("Invalid Branch Code.");
        return false;
    }

}
var txtBranch;
function Step1Click()
{
    txtBranch = $("#" + controlIdPrefix + "txtBranchcode");
   // var bcode = document.getElementById("#txtBranchcode").value;
    if (txtBranch.val() == "") {
        alert("Please Enter Branch.");
        txtBranchcode.focus();
        return false;
    }
    else {
        IsBranchExistInMaster(txtBranchcode);
    }
    
    
}
function IsBranchExistInMaster(obj) {
    var id = $(obj).attr('id');
    txtBranchcode = obj;
    if (obj.value != "") {
        if (txtBranchcode.value != "") {
            var url = serviceUrl + "/IsBranchExistInMaster";
            var strdata = "{\"BranchCode\":\"" + obj.value + "\"}";
            AjaxRequestWithPostAndJson(url, strdata, checkBranchInMasterSuccess, errorInMasterFunction, false);
        }
        else {

        }
    }
    else {
        return true;
    }
}
function checkBranchInMasterSuccess(data) {
   
    if (data.IsBranchExistInMasterResult.length > 0) {
        $.each(data.IsBranchExistInMasterResult, function () {
            if (data.IsBranchExistInMasterResult[0]['IsBranchExist'] == "True") {
                alert('HCL Labour Already Exist In Master For This Branch.');
                txtBranch.value = "";
                txtBranch.focus();
                return false;
            }
            else {
                tblMain.show();
                return false;
            }
        });

        return true;
    }
    //else {
    //    tblMain.show();
    //    return false;
    //}

    
}
function errorInMasterFunction(request, status, error) {
    //alert(request);
    //alert(status);
    //alert(error);
    //alert('HCL Labour Already Exist In Master For This Branch.');
}
function SubmitClick() {
    try {
        if (!IscheckDate()) {

        }
        else {
            btnSubmit.hide();

            objHCLDetail = {};
            objHCLDetail.BranchCode = txtBranchcode.value;
            objHCLDetail.OutgoingThcType = parseInt(ddlOutgoingTHCType.val());
            objHCLDetail.OutgoingThcRate = parseFloat(txtOutgoingTHCRate.val());
            objHCLDetail.OutgoingThcFromDate =txtOutgoingTHCFromDate.val()==""?null: moment(txtOutgoingTHCFromDate.val(), "DD/MM/YYYY").format('DD MMM YYYY');
            objHCLDetail.OutgoingThcToDate =txtOutgoingTHCToDate.val()==""?null: moment(txtOutgoingTHCToDate.val(), "DD/MM/YYYY").format('DD MMM YYYY');

            objHCLDetail.IncomingThcType = parseInt(ddlIncomingTHCType.val());
            objHCLDetail.IncomingThcRate = parseFloat(txtIncomingTHCRate.val());
            objHCLDetail.IncomingThcFromDate =txtIncomingTHCFromDate.val()==""?null: moment(txtIncomingTHCFromDate.val(), "DD/MM/YYYY").format('DD MMM YYYY');
            objHCLDetail.IncomingThcToDate = txtIncomingTHCToDate.val()==""?null:moment(txtIncomingTHCToDate.val(), "DD/MM/YYYY").format('DD MMM YYYY');

            objHCLDetail.DDMRType = parseInt(ddlDDMR.val());
            objHCLDetail.DDMRRate = parseFloat(txtDDMRRate.val());
            objHCLDetail.DDMRFromDate =txtDDMRFromDate.val()==""?null: moment(txtDDMRFromDate.val(), "DD/MM/YYYY").format('DD MMM YYYY');
            objHCLDetail.DDMRToDate =txtDDMRToDate.val()==""?null: moment(txtDDMRToDate.val(), "DD/MM/YYYY").format('DD MMM YYYY');

            objHCLDetail.MRType = parseInt(ddlMR.val());
            objHCLDetail.MRRate = parseFloat(txtMRRate.val());
            objHCLDetail.MRFromDate =txtMRFromDate.val()==""?null: moment(txtMRFromDate.val(), "DD/MM/YYYY").format('DD MMM YYYY');
            objHCLDetail.MRToDate = txtMRToDate.val()==""?null:moment(txtMRToDate.val(), "DD/MM/YYYY").format('DD MMM YYYY');

            objHCLDetail.EntryBy = empCode;

            if (confirm("Are You Sure You Want To Submit Data?")) {
                $("#btnSubmit").hide();
                // console.log(objHCLDetail)
                AjaxRequestWithPostAndJson(serviceUrl + "/HCLEntry", JSON.stringify(objHCLDetail), OnHCLDetailInsertSuccess, OnHCLDetailInsertError, false);
            }
        }
    }
    catch (e) {
        return false;
    }

}
function OnHCLDetailInsertSuccess(data) {
    window.location.href = "HCLMasterDone.aspx?Flag=Add";
    //alert("HCL Inserted Successfully.");
}
function OnHCLDetailInsertError(request, status, error) {
    $("#btnSubmit").show();
    alert('HCL Insert Failed');
}


