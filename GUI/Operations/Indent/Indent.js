var txtFDocketNumber;
// common Client ID prepped String
var controlIdPrefix = "ctl00_MyCPH1_";

//Valid Proposed Indent Data
function Validation() {
    try {
        var hdnClickCount = $("#ctl00_MyCPH1_hdnClickCount");
	var txtWarehouse = $("#ctl00_MyCPH1_txtWarehouse");
 	if (txtWarehouse.val() == "") {
                $(txtWarehouse).focus();
                throw new Error("Please Enter Warehouse");
            }
        $("input[id*='txtDocketNumber']").each(function () {
            var txtDocketNumber = $(this);
            txtDocketNumber.val();
            var txtMobileNumber = $('#' + txtDocketNumber.attr('id').replace('txtDocketNumber', 'txtMobileNumber'));
            if (txtDocketNumber.val() == "") {
                $(txtDocketNumber).focus();
                throw new Error("Please Enter Docket Number");
            }
            if (txtMobileNumber.val().length > 1 && txtMobileNumber.val().length < 10) {
                $(txtMobileNumber).focus();
                throw new Error("Please Enter Valid Mobile Number");
            }
        });
        hdnClickCount.val(1);
        return true;
    } catch (e) {
        hdnClickCount.val(0);
        alert(e.message);
        return false;
    }
}
//Valid Proposed Indent Data
function ValidationWithFinalization() {
    try {
        var hdnClickCount = $("#ctl00_MyCPH1_hdnClickCount");
	var txtWarehouse = $("#ctl00_MyCPH1_txtWarehouse");
 	if (txtWarehouse.val() == "") {
                $(txtWarehouse).focus();
                throw new Error("Please Enter Warehouse");
            }
        $("input[id*='txtDocketNumber']").each(function () {
            var txtDocketNumber = $(this);
            txtDocketNumber.val();
            var txtMobileNumber = $('#' + txtDocketNumber.attr('id').replace('txtDocketNumber', 'txtMobileNumber'));
            if (txtDocketNumber.val() == "") {
                $(txtDocketNumber).focus();
                throw new Error("Please Enter Docket Number");
            }
            if (txtMobileNumber.val().length > 1 && txtMobileNumber.val().length < 10) {
                $(txtMobileNumber).focus();
                throw new Error("Please Enter Valid Mobile Number");
            }
        });
        hdnClickCount.val(1);
        return true;
    } catch (e) {
        hdnClickCount.val(0);
        alert(e.message);
        return false;
    }
}
//Valid Indent Finalized Data
function ValidationFinalization() {
    try {
        var lblFProposedIndentNumber = $("#ctl00_MyCPH1_lblFProposedIndentNumber");
        var hdnClickCount = $("#ctl00_MyCPH1_hdnClickCount");
        var param = { stProposedIndentNumber: lblFProposedIndentNumber.text() };
        var qs = new Querystring();
        var Type = qs.get("Type");
        if (Type == "P") {
            $.ajax({
                type: "POST",
                url: "ProposedEntry.aspx/CheckValidProposedIndentNumber",
                data: JSON.stringify(param),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: CheckValidProposedIndentNo
            });
        }
        $("input[id*='txtFDocketNumber']").each(function () {
            var txtFDocketNumber = $(this);
            var txtFMobileNumber = $('#' + txtFDocketNumber.attr('id').replace('txtFDocketNumber', 'txtFMobileNumber'));
            txtFDocketNumber.val();
            if (txtFDocketNumber.val() == "") {
                $(txtFDocketNumber).focus();
                throw new Error("Please Enter Valid Docket Number");
            }
            if (txtFMobileNumber.val().length < 10) {
                $(txtFMobileNumber).focus();
                throw new Error("Please Enter Valid Mobile Number");
            }
        });
        hdnClickCount.val(1);
        return true;
    } catch (e) {
        hdnClickCount.val(0);
        alert(e.message); return false;
    }
}

//Allow only Numbers
function numberonly(event) {
    if (event.keyCode < 48 || event.keyCode > 57) {
        event.keyCode = 0;
        return false;
    }
}

//Allow Number And Point
function numberonlyallowPoint(event) {
    if (event.keyCode < 46 || event.keyCode > 57 || event.keyCode == 47) {
        event.keyCode = 0;
        return false;
    }
}
//Check Docket for Proposed
function CheckDocketNumber(senderId) {
    var txtDocketNumber = $(senderId).attr('id');
    var param = { stDocket: $("#" + txtDocketNumber).val() };
    if ($("#" + txtFDocketNumber).val() != "") {
        $.ajax({
            type: "POST",
            url: "ProposedEntry.aspx/CheckDocketNumber",
            data: JSON.stringify(param),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: CheckValidNumber
        });
    } else {
        $("#" + txtFDocketNumber).focus();
        alert("Please Enter Docket Number");
        return false;
    }

}

function CheckValidNumber(data) {
    var objArray = JSON.parse(data.d);
    var obj = objArray[0];
    $("input[id*='txtDocketNumber']").each(function () {
        var txtDocketNumber = $(this);
        if (obj.DockNo == txtDocketNumber.val()) {
            var hdnPPackates = $('#' + txtDocketNumber.attr('id').replace('txtDocketNumber', 'hdnPPackates'));
            var hdnPPPackates = $('#' + txtDocketNumber.attr('id').replace('txtDocketNumber', 'hdnPPPackates'));
            var hdnPPackatess = $('#' + txtDocketNumber.attr('id').replace('txtDocketNumber', 'hdnPPackatess'));
            var hdnHHPackates = $('#' + txtDocketNumber.attr('id').replace('txtDocketNumber', 'hdnHHPackates'));
            var hdnPDelPackates = $('#' + txtDocketNumber.attr('id').replace('txtDocketNumber', 'hdnPDelPackates'));
            var hdnPMaterial = $('#' + txtDocketNumber.attr('id').replace('txtDocketNumber', 'hdnPMaterial'));
            var hdnPFromCity = $('#' + txtDocketNumber.attr('id').replace('txtDocketNumber', 'hdnPFromCity'));
            var hdnPToCity = $('#' + txtDocketNumber.attr('id').replace('txtDocketNumber', 'hdnPToCity'));
            var hdnPBookingStation = $('#' + txtDocketNumber.attr('id').replace('txtDocketNumber', 'hdnPBookingStation'));
            var hdnPCustomerRefrence = $('#' + txtDocketNumber.attr('id').replace('txtDocketNumber', 'hdnPCustomerRefrence'));
            var hdnPConsignor = $('#' + txtDocketNumber.attr('id').replace('txtDocketNumber', 'hdnPConsignor'));
            var hdnPConsignee = $('#' + txtDocketNumber.attr('id').replace('txtDocketNumber', 'hdnPConsignee'));
            var hdnPWeight = $('#' + txtDocketNumber.attr('id').replace('txtDocketNumber', 'hdnPWeight'));
            var hdnPDeliveryLocation = $('#' + txtDocketNumber.attr('id').replace('txtDocketNumber', 'hdnPDeliveryLocation'));
            var hdnIsSystemDocket = $('#' + txtDocketNumber.attr('id').replace('txtDocketNumber', 'hdnIsSystemDocket'));
            hdnPPackates.val(obj.Packages);
            if (obj.PendingPackages == 0)
                hdnPPPackates.val(0 + '/' + 0);
            else
                hdnPPPackates.val(obj.DeliveredPackages + '/' + obj.TotalPackages);
            hdnHHPackates.val(obj.TotalPackages)
            hdnPDelPackates.val(obj.DeliveredPackages)
            hdnPMaterial.val(obj.Material);
            hdnPFromCity.val(obj.FromCity);
            hdnPToCity.val(obj.ToCity);
            hdnPBookingStation.val(obj.BookingDeatination);
            hdnPCustomerRefrence.val(obj.CustomerRefrence);
            hdnPConsignor.val(obj.Consignor);
            hdnPConsignee.val(obj.Consignee);
            hdnPWeight.val(obj.Weight);
            hdnPDeliveryLocation.val(obj.DeliveryLocation);
            hdnIsSystemDocket.val(obj.IsSystemDocket);
        }
    });
}

//check Mobile Number
function CheckMobileNumber(senderId) {
    var txtMobileNumber = $(senderId).attr('id');
    if ($("#" + txtMobileNumber).val().length >1 && $("#" + txtMobileNumber).val().length < 10) {
        $("#" + txtMobileNumber).focus();
        alert("Please Enter Valid Mobile Number");
        return false;
    }
}
//check Mobile Number Finalization
function CheckMobileNumberFinalization(senderId) {
    var txtFMobileNumber = $(senderId).attr('id');
    if ($("#" + txtFMobileNumber).val().length > 1 && $("#" + txtFMobileNumber).val().length < 10) {
        $("#" + txtFMobileNumber).focus();
        alert("Please Enter Valid Mobile Number");
        return false;
    }
}
//Check Docket for Finalization
function CheckDocketNumberFinalization(senderId) {
    var txtFDocketNumber = $(senderId).attr('id');
    var qs = new Querystring();
    var Type = qs.get("Type");
    if ($("#" + txtFDocketNumber).val() != "") {
        if (Type == "P") {
            var param = { stDocket: $("#" + txtFDocketNumber).val() };
            $.ajax({
                type: "POST",
                url: "ProposedEntry.aspx/CheckDocketNumber",
                data: JSON.stringify(param),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: CheckValidNumberFinalization
            });
        }
        else {
            var param = {
                stDocket: $("#" + txtFDocketNumber).val(),
                stPIndent: $("#ctl00_MyCPH1_lblFProposedIndentNumber").text()
            };
            $.ajax({
                type: "POST",
                url: "ProposedEntry.aspx/CheckDocketNumberWithPIndent",
                data: JSON.stringify(param),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: CheckValidNumberFinalization
            });
        }
    }
    else {
        $("#" + txtFDocketNumber).focus();
        alert("Please Enter Docket Number");
        return false;
    }
}

function CheckValidNumberFinalization(data) {
    var objArray = JSON.parse(data.d);
    var obj = objArray[0];
    $("input[id*='txtFDocketNumber']").each(function () {
        var txtFDocketNumber = $(this);
        if (obj.DockNo == txtFDocketNumber.val()) {
            var txtFLocation = $('#' + txtFDocketNumber.attr('id').replace('txtFDocketNumber', 'txtFLocation'));
            var txtFDeliveryPartyName = $('#' + txtFDocketNumber.attr('id').replace('txtFDocketNumber', 'txtFDeliveryPartyName'));
            var txtFBillingPartyName = $('#' + txtFDocketNumber.attr('id').replace('txtFDocketNumber', 'txtFBillingPartyName'));
            var txtFMobileNumber = $('#' + txtFDocketNumber.attr('id').replace('txtFDocketNumber', 'txtFMobileNumber'));
            var txtFRemarks = $('#' + txtFDocketNumber.attr('id').replace('txtFDocketNumber', 'txtFRemarks'));
            var txtFPackates = $('#' + txtFDocketNumber.attr('id').replace('txtFDocketNumber', 'txtFPackates'));
            var lblFPackates = $('#' + txtFDocketNumber.attr('id').replace('txtFDocketNumber', 'lblFPackates'));
            var lblFMaterial = $('#' + txtFDocketNumber.attr('id').replace('txtFDocketNumber', 'lblFMaterial'));
            var lblFFromCity = $('#' + txtFDocketNumber.attr('id').replace('txtFDocketNumber', 'lblFFromCity'));
            var lblFToCity = $('#' + txtFDocketNumber.attr('id').replace('txtFDocketNumber', 'lblFToCity'));
            var lblFBookingStation = $('#' + txtFDocketNumber.attr('id').replace('txtFDocketNumber', 'lblFBookingStation'));
            var lblFCustomerRefrence = $('#' + txtFDocketNumber.attr('id').replace('txtFDocketNumber', 'lblFCustomerRefrence'));
            var lblFConsignor = $('#' + txtFDocketNumber.attr('id').replace('txtFDocketNumber', 'lblFConsignor'));
            var lblFConsignee = $('#' + txtFDocketNumber.attr('id').replace('txtFDocketNumber', 'lblFConsignee'));
            var lblFWeight = $('#' + txtFDocketNumber.attr('id').replace('txtFDocketNumber', 'lblFWeight'));
            var lblFDeliveryLocation = $('#' + txtFDocketNumber.attr('id').replace('txtFDocketNumber', 'lblFDeliveryLocation'));
            var hdnFPackates = $('#' + txtFDocketNumber.attr('id').replace('txtFDocketNumber', 'hdnFPackates'));
            var hdnFDelPackates = $('#' + txtFDocketNumber.attr('id').replace('txtFDocketNumber', 'hdnFDelPackates'));
            var hdnHHPackates = $('#' + txtFDocketNumber.attr('id').replace('txtFDocketNumber', 'hdnHHPackates'));
            var hdnIsSystemDocket = $('#' + txtFDocketNumber.attr('id').replace('txtFDocketNumber', 'hdnIsSystemDocket'));
            txtFLocation.val(obj.Location);
            txtFDeliveryPartyName.val(obj.DeliveryPartyName);
            txtFBillingPartyName.val(obj.BillingPartyName);
            txtFMobileNumber.val(obj.MobileNumber);
            txtFRemarks.val(obj.Remarks);
            txtFPackates.val(obj.Packages);
            if (obj.PendingPackages == 0)
                lblFPackates.text(0 + '/' + 0);
            else
                lblFPackates.text(obj.DeliveredPackages + '/' + obj.TotalPackages);
            hdnFPackates.val(obj.TotalPackages)
            hdnFDelPackates.val(obj.DeliveredPackages)
            hdnHHPackates.val(obj.TotalPackages)
            lblFMaterial.text(obj.Material);
            lblFFromCity.text(obj.FromCity);
            lblFToCity.text(obj.ToCity);
            lblFBookingStation.text(obj.BookingDeatination);
            lblFCustomerRefrence.text(obj.CustomerRefrence);
            lblFConsignor.text(obj.Consignor);
            lblFConsignee.text(obj.Consignee);
            lblFWeight.text(obj.Weight);
            lblFDeliveryLocation.text(obj.DeliveryLocation);
            hdnIsSystemDocket.val(obj.IsSystemDocket);
        }
    });
}
//Check Docket
function DefinePackages(senderId) {
    var txtFPackates = $(senderId).attr('id');
    $("input[id*='txtFPackates']").each(function () {
        var txtFPackates = $(this);
        var hdnFPackates = $('#' + txtFPackates.attr('id').replace('txtFPackates', 'hdnHHPackates'));
        var lblFPackates = $('#' + txtFPackates.attr('id').replace('txtFPackates', 'lblFPackates'));
        if (hdnFPackates.val() == "")
            hdnFPackates.val(0);
        var hdnFDelPackates = $('#' + txtFPackates.attr('id').replace('txtFPackates', 'hdnFDelPackates'));
	if(txtFPackates.val()>hdnFPackates.val())
        {
            alert("Please enter number of packets which are available in docket")
            txtFPackates.val(0);
        }
        if (hdnFDelPackates.val() == hdnFPackates.val())
            lblFPackates.text(txtFPackates.val() + '/' + hdnFPackates.val()); //lblFPackates.text('');
        else
            lblFPackates.text(txtFPackates.val() + '/' + hdnFPackates.val());
    });
}
function CheckDuplication(row_Index, txtDocketNumber) {
    var str_Index = ""
    var txtDocketNumber = txtDocketNumber.getAttribute('id');
    var txtDocketNumberval = document.getElementById(txtDocketNumber);
    try {
        for (intIndex = 0; intIndex < document.getElementById("tblProposedEntry").rows.length - 1; intIndex++) {
            if (intIndex < 10) str_Index = "0" + intIndex; else str_Index = intIndex;
            if (row_Index == intIndex - 0) continue;
            var othertxtDocketNumber = document.getElementById(controlIdPrefix + "rptProposed_ctl" + str_Index + "_txtDocketNumber").value.trim();
            if (txtDocketNumberval.value != "") {
                if (othertxtDocketNumber == txtDocketNumberval.value) {
                    alert("Record Already Exist. Please Enter Docket");
                    txtDocketNumberval.value = "";
                    txtDocketNumberval.focus();
                    return false;
                }
            }
        }
    }
    catch (e) {
        alert(e.message)
        return false;
    }
}
////Check Proposed Indent Number
//function CheckValidProposedIndentNumber() {
//    var lblFProposedIndentNumber = $("#ctl00_MyCPH1_lblFProposedIndentNumber");
//    var param = { stProposedIndentNumber: lblFProposedIndentNumber.text() };

//    $.ajax({
//        type: "POST",
//        url: "ProposedEntry.aspx/CheckValidProposedIndentNumber",
//        data: JSON.stringify(param),
//        contentType: "application/json; charset=utf-8",
//        dataType: "json",
//        async: false,
//        success: CheckValidProposedIndentNo
//    });
//}
function CheckValidProposedIndentNo(data) {
    var objArray = JSON.parse(data.d);
    if (objArray.length > 0) {
        throw new Error("Proposed Indent Number already Used.");
    }
    else { return true; }
}
//Proposed Indent Number Search
function ValidationOnSearch() {
    try {
        var txtIndentNumber = $("#ctl00_MyCPH1_txtIndentNumber");
        var hdnClickCount = $("#ctl00_MyCPH1_hdnClickCount");
        var param = { stProposedIndentNumber: txtIndentNumber.val() };

        $.ajax({
            type: "POST",
            url: "ProposedEntry.aspx/SearchProposedIndentNumber",
            data: JSON.stringify(param),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: SearchValidProposedIndentNo
        });
        $("input[id*='txtIndentNumber']").each(function () {
            var txtIndentNumber = $(this);
            txtIndentNumber.val();
            if (txtIndentNumber.val() == "") {
                $(txtIndentNumber).focus();
                throw new Error("Please Enter Valid Proposed Indent Number");
            }
        });
        hdnClickCount.val(1);
        return true;
    } catch (e) {
        hdnClickCount.val(0);
        alert(e.message);
        return false;
    }
}
////Search Proposed Indent Number
//function SearchValidProposedIndentNumber() {
//    var txtIndentNumber = $("#ctl00_MyCPH1_txtIndentNumber");
//    var param = { stProposedIndentNumber: txtIndentNumber.val() };

//    $.ajax({
//        type: "POST",
//        url: "ProposedEntry.aspx/SearchProposedIndentNumber",
//        data: JSON.stringify(param),
//        contentType: "application/json; charset=utf-8",
//        dataType: "json",
//        async: false,
//        success: SearchValidProposedIndentNo
//    });
//}
function SearchValidProposedIndentNo(data) {
    var objArray = JSON.parse(data.d);
    if (objArray.length == 0) {
        throw new Error("Proposed Indent Number not Valid.");
    }
    else { return true; }
}

function SubmitOnCancellationListing() {
    try {
        var txtIndentNumber = $("#" + controlIdPrefix + "txtIndentNumber");
        var radDate_0 = $("#" + controlIdPrefix + "DT_radDate_0");
        var txtDateFrom = $("#" + controlIdPrefix + "DT_txtDateFrom");
        var txtDateTo = $("#" + controlIdPrefix + "DT_txtDateTo");
        if (txtIndentNumber.val() == "") {
            if (radDate_0.checked) {
                if (txtDateFrom.val() == "") {
                    throw new Error("Please Enter From date");
                    txtDateFrom.focus();
                }
                if (txtDateTo.val() == "") {
                    throw new Error("Please Enter To date");
                    txtDateTo.focus();
                }
            }
        }
        return true;
    } catch (e) { alert(e.message); return false; }
}

function SubmitOnCancellation() {
    try {
        var txtCanceldate = $("#" + controlIdPrefix + "txtCanceldate");
        var txtCancelReason = $("#" + controlIdPrefix + "txtCancelReason");
        if (txtCanceldate.val() == "") {
            throw new Error("Please Enter Cancellation date");
            txtCanceldate.focus();
        }
        if (txtCancelReason.val() == "") {
            throw new Error("Please Enter Cancellation Reason");
            txtCancelReason.focus();
        }
        return true;
    } catch (e) { alert(e.message); return false; }
}
