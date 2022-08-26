var addBluePopup, tollPopup, fuelPopup;
var addBluePopupDisplay, fuelPopupDisplay, SummaryPopup;
var protsahanrashiPopup;
$(document).ready(function () {
    //if ($("#ctl00_MyCPH1_btnTripSubbmission").val() != "1") {
    //    TripSubmissionRows('HIDE');
    //}

    $("#txtThisDate_Toll").datepicker({ dateFormat: 'dd/mm/yy' });
    addBluePopup = $("#addbluePopup").dialog({
        autoOpen: false,
        resizable: false,
        height: 300,
        width: 700,
        modal: true,
        buttons: {
            "Submit": function () {
                if (Submit_AddBlue() == true) {
                    Load_TotalfuelDetails();
                    $(this).dialog("close");
                    $("#" + lblNExpenseID_AddBlue.replace("lblNExpense", "txtAmount")).focus();
                }
            },
            Cancel: function () {
                $(this).dialog("close");
            }
        }
    });


    addBluePopupDisplay = $("#addbluePopupDisplay").dialog({
        autoOpen: false,
        resizable: false,
        height: 300,
        width: 700,
        modal: true
    });


    fuelPopup = $("#fuelPopup").dialog({
        autoOpen: false,
        resizable: false,
        height: 300,
        width: 700,
        modal: true,
        buttons: {
            "Submit": function () {
                if (Submit_fuel() == true) {
                    Load_TotalfuelDetails();
                    $(this).dialog("close");
                    $("#" + lblNExpenseID_fuel.replace("lblNExpense", "txtAmount")).focus();
                }
            },
            Cancel: function () {
                $(this).dialog("close");
            }
        }
    });

    fuelPopupDisplay = $("#fuelPopupDisplay").dialog({
        autoOpen: false,
        resizable: false,
        height: 300,
        width: 700,
        modal: true
    });


    tollPopup = $("#tollPopup").dialog({
        autoOpen: false,
        resizable: false,
        height: 300,
        width: 700,
        modal: true,
        buttons: {
            "Submit": function () {
                if (Submit_Toll() == true) {
                    $(this).dialog("close");
                    $("#" + lblNExpenseID_Toll.replace("lblNExpense", "txtAmount")).focus();
                }
            },
            Cancel: function () {
                $(this).dialog("close");
            }
        }
    });

    SummaryPopup = $("#SummaryPopup").dialog({
        autoOpen: false,
        resizable: false,
        height: 400,
        width: "100%",
        modal: true,
        buttons: {
            "Submit": function () {
                debugger;
                if (OperationallyCloseValid('F')) {
                    $(this).dialog("close");
					document.getElementById("ctl00_MyCPH1_btnTripSubbmission").click();
					document.getElementById("ctl00_MyCPH1_btnTripSubbmission").trigger("click");
                    /*$("#ctl00_MyCPH1_btnTripSubbmission").click();
                    $("#ctl00_MyCPH1_btnTripSubbmission").trigger("click");*/

                } else {
                    $(this).dialog("close");
                }

            },
            Cancel: function () {
                $(this).dialog("close");
            }
        }
    });

    TotalFuelLtrPopup = $("#TotalFuelLtrPopup").dialog({
        autoOpen: false,
        resizable: false,
        height: 300,
        width: 400,
        modal: true
    });


    protsahanrashiPopup = $("#ProtsahanRashiPopup").dialog({
        autoOpen: false,
        resizable: false,
        height: 300,
        width: 800,
        modal: true,
        buttons: {
            "Submit": function () {
                if (Submit_ProtsahanRashi() == true) {
                    $(this).dialog("close");
                    $("#" + lblNExpenseID_ProtsahanRashi.replace("lblNExpense", "txtAmount")).focus();
                }
            },
            Cancel: function () {
                $(this).dialog("close");
            }
        }
    });

})

function showRouteOpen() {
    if ($('#ctl00_MyCPH1_ddlRouteType').val() == "01") {
        $('#ctl00_MyCPH1_ddlRouteName').show();
        $('#trRoute1').hide();
    }
    if ($('#ctl00_MyCPH1_ddlRouteType').val() == "02") {
        $('#ctl00_MyCPH1_ddlRouteName').hide();
        $('#trRoute1').show();
    }
}


/*Region Add Blue */
var lblNExpenseID_AddBlue = "";

function ViewAddBluePopup(addBlueId) {
    Load_AddBlueData();
    addBluePopupDisplay.dialog("open");
}

function OpenAddBluePopup(addBlueId) {
    lblNExpenseID_AddBlue = addBlueId;
    if ($("#tblAddBlue > tbody > tr").length == 0) {
        addRow_AddBlue();
    }
    addBluePopup.dialog("open");
}

function Load_AddBlueData() {

    var dtFuelSlip = [];
    if ($('#ctl00_MyCPH1_hdnJsonExistingfuelSlipData').val() != "") {
        dtFuelSlip = JSON.parse($('#ctl00_MyCPH1_hdnJsonExistingfuelSlipData').val());
    }

    $("#tblAddBlueDisplay tbody tr").remove();
    var len = $("#tblAddBlueDisplay > tbody > tr").length;

    for (var i = 0; i < dtFuelSlip.length; i++) {

        if (dtFuelSlip[i].FuelType.toString().toUpperCase() == "ADDBLUE" && dtFuelSlip[i].IsCancel.toString().toUpperCase() != "Y") {
            var tr = '<tr class="bgwhite" id="tr_' + len.toString() + '" ><td><input type="text" id="txtPlace_' + len.toString() + '"  value="' + dtFuelSlip[i].VendorCity + '" readonly />'
                + '<input type="text" style="display:none;" id="txtSrNo_' + len.toString() + '"  value="' + len.toString() + '"  /> </td>'
                + '<td><input type="text" id="txtDate_' + len.toString() + '"  value="' + (dtFuelSlip[i].FuelSlipDate == null ? "" : dtFuelSlip[i].FuelSlipDate).toString() + '"  readonly /></td>'
                + '<td><input type="text" id="txtfuel_' + len.toString() + '"  value="' + dtFuelSlip[i].Quantity + '" readonly  /></td>'
                + '<td><input type="text" id="txtRate_' + len.toString() + '"  value="' + dtFuelSlip[i].Rate + '"  readonly  /></td>'
                + '<td><input type="text" id="txtCashAmount_' + len.toString() + '"  value="' + parseFloat(dtFuelSlip[i].Amount).toFixed(2) + '" readonly  /></td>'
                + '<td><input type="text" id="txtIGST_' + len.toString() + '"  value="' + parseFloat(dtFuelSlip[i].IGST).toFixed(2) + '" readonly  /></td>'
                + '<td><input type="text" id="txtSGST_' + len.toString() + '"  value="' + parseFloat(dtFuelSlip[i].SGST).toFixed(2) + '" readonly  /></td>'
                + '<td><input type="text" id="txtCGST_' + len.toString() + '"  value="' + parseFloat(dtFuelSlip[i].CGST).toFixed(2) + '" readonly  /></td>'
                + '<td><input type="text" id="txtTotalAmount_' + len.toString() + '"  value="' + parseFloat(dtFuelSlip[i].TotalAmount).toFixed(2) + '" readonly  /></td>'               
                + '</tr>';

            $("#tblAddBlueDisplay").append(tr);
        }
    }
    calculateAddBlueDetails('VIEW');

}

function addRow_AddBlue() {
    var len = $("#tblAddBlue > tbody > tr").length;

    if (len != 0) {
        len = parseInt($('#tblAddBlue > tbody > tr:last').find("input[type=text][id*=txtSrNo_]").val()) + 1;
    } else {
        len = len + 1;
    }

    var tr = '<tr class="bgwhite" id="tr_' + len.toString() + '" ><td><input type="text" id="txtPlace_' + len.toString() + '"  value="" />'
        + '<input type="text" style="display:none;" id="txtSrNo_' + len.toString() + '"  value="' + len.toString() + '"  /> </td>'
        + '<td><input type="text" id="txtDate_' + len.toString() + '"  value="" class="jqdatepicker"  /></td>'
        + '<td><input type="text" id="txtfuel_' + len.toString() + '"  value="0" onkeypress="javascript:validFloat(event,this.id)"  onblur="calculateAddBlueDetails()"; /></td>'
        + '<td><input type="text" id="txtRate_' + len.toString() + '"  value="0"  onkeypress="javascript:validFloat(event,this.id)" onblur="calculateAddBlueDetails()"; /></td>'
        + '<td><input type="text" id="txtCashAmount_' + len.toString() + '"  value="0" readonly  /></td>'
        + '<td><input type="text" id="txtIGST_' + len.toString() + '"  value="0" onkeypress="javascript:validFloat(event,this.id)" onblur="calculateAddBlueDetails()"; /></td>'
        + '<td><input type="text" id="txtSGST_' + len.toString() + '"  value="0" onkeypress="javascript:validFloat(event,this.id)"  onblur="calculateAddBlueDetails()";/></td>'
        + '<td><input type="text" id="txtCGST_' + len.toString() + '"  value="0" onkeypress="javascript:validFloat(event,this.id)" onblur="calculateAddBlueDetails()";  /></td>'
        + '<td><input type="text" id="txtTotalAmount_' + len.toString() + '"  value="0" readonly  /></td>'       
        + '<td class="clsAction"><input type="image" src="../../../../../GUI/images/add.png" onClick="addRow_AddBlue(this); return false;" /><input type="image" src="../../../../../GUI/images/delete.png"  onClick="removeRow_AddBlue(this); return false;" /></td></tr>';

    $("#tblAddBlue").append(tr);
    $(".jqdatepicker").datepicker({ dateFormat: 'dd/mm/yy' });
    return false;
}

function removeRow_AddBlue(ctrl) {
    if ($("#tblAddBlue tbody tr").length != 1) {
        $(ctrl).closest('tr').remove();
        calculateAddBlueDetails();
    }
    return false;
}

function calculateAddBlueDetails(type) {
    var totalLtr = 0;
    var total = 0;
    var totalAmount = 0;

    var tblID = "";
    if (type == "VIEW") {
        tblID = "tblAddBlueDisplay";
    } else {
        tblID = "tblAddBlue";
    }

    $("#" + tblID + " tbody tr").each(function () {
        var txtPlace = $(this).find("input[type=text][id*=txtPlace_]");
        var txtDate = $(this).find("input[type=text][id*=txtDate_]");
        var txtfuel = $(this).find("input[type=text][id*=txtfuel_]");
        var txtRate = $(this).find("input[type=text][id*=txtRate_]");
        var txtAmount = $(this).find("input[type=text][id*=txtCashAmount_]");
        var txtIGST = $(this).find("input[type=text][id*=txtIGST_]");
        var txtSGST = $(this).find("input[type=text][id*=txtSGST_]");
        var txtCGST = $(this).find("input[type=text][id*=txtCGST_]");
        var txtTotalAmount = $(this).find("input[type=text][id*=txtTotalAmount_]");

        var fuel = parseFloat(txtfuel.val() == "" ? "0" : txtfuel.val());
        var rate = parseFloat(txtRate.val() == "" ? "0" : txtRate.val());
        var IGST = parseFloat(txtIGST.val() == "" ? "0" : txtIGST.val());
        var SGST = parseFloat(txtSGST.val() == "" ? "0" : txtSGST.val());
        var CGST = parseFloat(txtCGST.val() == "" ? "0" : txtCGST.val());

        txtAmount.val(fuel * rate);
        var Amount = parseFloat(txtAmount.val() == "" ? "0" : txtAmount.val())
        txtTotalAmount.val(Amount + IGST + SGST + CGST);

        totalLtr = totalLtr + parseFloat(txtfuel.val() == "" ? "0" : txtfuel.val());
        total = total + parseFloat(txtAmount.val() == "" ? "0" : txtAmount.val());
        totalAmount = totalAmount + parseFloat(txtTotalAmount.val() == "" ? "0" : txtTotalAmount.val());

    })
    if (type == "VIEW") {
        $("#txtTotalLtr_AddBlueDisplay").val(totalLtr);
        $("#txtTotal_AddBlueDisplay").val(total);
    } else {
        $("#txtTotalLtr_AddBlue").val(totalLtr);
        $("#txtTotal_AddBlue").val(total);
        $("#txtTotalAmount_AddBlue").val(totalAmount);
    }

}

function Submit_AddBlue() {

    var finalFuelSlipData = [];
    try {
        $("#tblAddBlue tbody tr").each(function () {
            var txtPlace = $(this).find("input[type=text][id*=txtPlace_]");
            var txtDate = $(this).find("input[type=text][id*=txtDate_]");
            var txtfuel = $(this).find("input[type=text][id*=txtfuel_]");
            var txtRate = $(this).find("input[type=text][id*=txtRate_]");
            var txtAmount = $(this).find("input[type=text][id*=txtCashAmount_]");
            var txtIGST = $(this).find("input[type=text][id*=txtIGST]");
            var txtSGST = $(this).find("input[type=text][id*=txtSGST]");
            var txtCGST = $(this).find("input[type=text][id*=txtCGST]");
            var txtTotalAmount = $(this).find("input[type=text][id*=txtTotalAmount]");           
            if (txtPlace.val() == "") {
                throw ("Please enter Place !!");
            }
            if (txtDate.val() == "") {
                throw ("Please enter Date !!");
            }
            if (txtfuel.val() == "") {
                throw ("Please enter fuel !!");
            }
            if (txtRate.val() == "") {
                throw ("Please enter Rate !!");
            }

            if (!isDate(txtDate.val())) {
                alert("Please Enter Valid date ( Format :: dd/mm/yyyy ) !!!");
                txtDate.focus();
                return false;
            }

            txtIGST.val() == "" ? "0" : txtIGST.val();
            txtSGST.val() == "" ? "0" : txtSGST.val();
            txtCGST.val() == "" ? "0" : txtCGST.val();

            var varDate = "";
            var ArrDate = txtDate.val().split('/');
            varDate = ArrDate[1] + '/' + ArrDate[0] + '/' + ArrDate[2];  
            
            finalFuelSlipData.push({ Place: txtPlace.val(), Date: varDate, FuelLtr: txtfuel.val(), Rate: txtRate.val(), Amount: txtAmount.val(), IGST: txtIGST.val(), SGST: txtSGST.val(), CGST: txtCGST.val(), TotalAmount: txtTotalAmount.val() });
        })
    } catch (e) {
        alert(e);
        return false
    }

    $("#" + lblNExpenseID_AddBlue.replace("lblNExpense", "hdnPopUpData")).val(JSON.stringify(finalFuelSlipData));
    $("#" + lblNExpenseID_AddBlue.replace("lblNExpense", "txtAmount")).val($("#txtTotalAmount_AddBlue").val());    
    return true;
}
/*Region Add Blue */



/*Region fuel */
var lblNExpenseID_fuel = ""; var isfuelDataLoaded = false;
function ViewFuelPopup(fuelPopupId) {
    if (isfuelDataLoaded == false) { Load_fuelData(); }
    fuelPopupDisplay.dialog("open");
}

function OpenFuelPopup(fuelPopupId) {
    lblNExpenseID_fuel = fuelPopupId;
    if ($("#tblfuel > tbody > tr").length == 0) {
        addRow_fuel();
    }
    fuelPopup.dialog("open");
}

function Load_fuelData() {

    var dtFuelSlip = [];
    if ($('#ctl00_MyCPH1_hdnJsonExistingfuelSlipData').val() != "") {
        dtFuelSlip = JSON.parse($('#ctl00_MyCPH1_hdnJsonExistingfuelSlipData').val());
    }

    $("#tblfuelDisplay tbody tr").remove();
    var len = $("#tblfuelDisplay > tbody > tr").length;

    $("input[id*=hdnFinalAmount]").each(function () {

        var lblFuelType = $("#" + $(this).attr("id").replace("hdnFinalAmount", "lblFuelType"));
        var hdnIsCancel = $("#" + $(this).attr("id").replace("hdnFinalAmount", "hdnIsCancel"));
        var hdnRateAsPerFillingDate = $("#" + $(this).attr("id").replace("hdnFinalAmount", "hdnRateAsPerFillingDate"));
        var lblFuelSlipDate = $("#" + $(this).attr("id").replace("hdnFinalAmount", "lblFuelSlipDate"));
        var lblVendorCity = $("#" + $(this).attr("id").replace("hdnFinalAmount", "lblVendorCity"));
        var lblQuantity = $("#" + $(this).attr("id").replace("hdnFinalAmount", "lblQuantity"));

        if (lblFuelType.text().toString().toUpperCase() != "ADDBLUE" && hdnIsCancel.val().toUpperCase() != "Y") {
            var tr = '<tr class="bgwhite" id="tr_' + len.toString() + '" ><td><input type="text" id="txtPlace_' + len.toString() + '"  value="' + lblVendorCity.text() + '" readonly />'
                   + '<input type="text" style="display:none;" id="txtSrNo_' + len.toString() + '"  value="' + len.toString() + '"  /> </td>'
                   + '<td><input type="text" id="txtDate_F' + len.toString() + '"  value="' + lblFuelSlipDate.text().toString() + '"  readonly /></td>'
                   + '<td><input type="text" id="txtfuel_' + len.toString() + '"  value="' + lblQuantity.text() + '" readonly  /></td>'
                   + '<td><input type="text" id="txtRate_' + len.toString() + '"  value="' + hdnRateAsPerFillingDate.val() + '"  readonly  /></td>'
                   + '<td><input type="text" id="txtCashAmount_' + len.toString() + '"  value="' + parseFloat($(this).val()).toFixed(2).toString() + '" readonly  /></td>'
                   + '<td></td></tr>';

            $("#tblfuelDisplay").append(tr);
        }

    });


    //for (var i = 0; i < dtFuelSlip.length; i++) {

    //    if (dtFuelSlip[i].FuelType.toString().toUpperCase() != "ADDBLUE" && dtFuelSlip[i].IsCancel.toString().toUpperCase() != "Y") {
    //        var tr = '<tr class="bgwhite" id="tr_' + len.toString() + '" ><td><input type="text" id="txtPlace_' + len.toString() + '"  value="' + dtFuelSlip[i].VendorCity + '" readonly />'
    //               + '<input type="text" style="display:none;" id="txtSrNo_' + len.toString() + '"  value="' + len.toString() + '"  /> </td>'
    //               + '<td><input type="text" id="txtDate_F' + len.toString() + '"  value="' + (dtFuelSlip[i].FuelSlipDate == null ? "" : dtFuelSlip[i].FuelSlipDate).toString() + '"  readonly /></td>'
    //               //+ '<td><input type="text" id="txtDate_F' + len.toString() + '"  value="' + dtFuelSlip[i].FuelSlipDate + '"  readonly /></td>'
    //               + '<td><input type="text" id="txtfuel_' + len.toString() + '"  value="' + dtFuelSlip[i].Quantity + '" readonly  /></td>'
    //               + '<td><input type="text" id="txtRate_' + len.toString() + '"  value="' + dtFuelSlip[i].Rate + '"  readonly  /></td>'
    //               + '<td><input type="text" id="txtCashAmount_' + len.toString() + '"  value="' + dtFuelSlip[i].Amount + '" readonly  /></td>'
    //               + '<td></td></tr>';

    //        $("#tblfuelDisplay").append(tr);
    //    }
    //}

    calculatefuelDetails("VIEW");
    isfuelDataLoaded = true;
}

function addRow_fuel() {
    var len = $("#tblfuel > tbody > tr").length;

    if (len != 0) {
        len = parseInt($('#tblfuel > tbody > tr:last').find("input[type=text][id*=txtSrNo_]").val()) + 1;
    } else {
        len = len + 1;
    }

    var tr = '<tr class="bgwhite" id="tr_' + len.toString() + '" ><td><input type="text" id="txtPlace_' + len.toString() + '"  value="" />'
                 + '<input type="text" style="display:none;" id="txtSrNo_' + len.toString() + '"  value="' + len.toString() + '"  /> </td>'
                 + '<td><input type="text" id="txtDate_F' + len.toString() + '" class="jqdatepicker" value=""   /></td>'
                 + '<td><input type="text" id="txtfuel_' + len.toString() + '"  value="0" onkeypress="javascript:validFloat(event,this.id)"  onblur="calculatefuelDetails()"; /></td>'
                 + '<td><input type="text" id="txtRate_' + len.toString() + '"  value="0"  onkeypress="javascript:validFloat(event,this.id)" onblur="calculatefuelDetails()"; /></td>'
                 + '<td><input type="text" id="txtCashAmount_' + len.toString() + '"  value="0" readonly  /></td>'
                 + '<td class="clsAction"><input type="image" src="../../../../../GUI/images/add.png" onClick="addRow_fuel(this); return false;" /><input type="image" src="../../../../../GUI/images/delete.png"  onClick="removeRow_fuel(this); return false;" /></td></tr>';

    $("#tblfuel").append(tr);
    $(".jqdatepicker").datepicker({ dateFormat: 'dd/mm/yy' });
    return false;
}

function removeRow_fuel(ctrl) {
    if ($("#tblfuel tbody tr").length != 1) {
        $(ctrl).closest('tr').remove();
    }
    calculatefuelDetails();
    return false;
}

function calculatefuelDetails(type) {
    var totalLtr = 0;
    var total = 0;
    var totalAmount = 0;
    var tblID = "";
    if (type == "VIEW") {
        tblID = "tblfuelDisplay";
    } else {
        tblID = "tblfuel";
    }

    $("#" + tblID + " tbody tr").each(function () {
        var txtPlace = $(this).find("input[type=text][id*=txtPlace_]");
        var txtDate = $(this).find("input[type=text][id*=txtDate_]");
        var txtfuel = $(this).find("input[type=text][id*=txtfuel_]");
        var txtRate = $(this).find("input[type=text][id*=txtRate_]");
        var txtAmount = $(this).find("input[type=text][id*=txtCashAmount_]");

        var fuel = parseFloat(txtfuel.val() == "" ? "0" : txtfuel.val());
        var rate = parseFloat(txtRate.val() == "" ? "0" : txtRate.val());

        txtAmount.val(fuel * rate);

        totalLtr = totalLtr + parseFloat(txtfuel.val() == "" ? "0" : txtfuel.val());
        total = total + parseFloat(txtAmount.val() == "" ? "0" : txtAmount.val());

    })


    if (type == "VIEW") {
        $("#txtTotalLtr_fuelDisplay").val(totalLtr);
        $("#txtTotal_fuelDisplay").val(total);
    } else {
        $("#" + lblNExpenseID_fuel.replace("lblNExpense", "txtAmount")).val(parseFloat(total).toFixed(2));
        $("#txtTotalLtr_fuel").val(totalLtr);
        $("#txtTotal_fuel").val(total);
    }

}

function Submit_fuel() {

    var finalFuelSlipData = [];
    try {
        $("#tblfuel tbody tr").each(function () {
            var txtPlace = $(this).find("input[type=text][id*=txtPlace_]");
            var txtDate = $(this).find("input[type=text][id*=txtDate_]");
            var txtfuel = $(this).find("input[type=text][id*=txtfuel_]");
            var txtRate = $(this).find("input[type=text][id*=txtRate_]");
            var txtAmount = $(this).find("input[type=text][id*=txtCashAmount_]");

            if (txtPlace.val() == "") {
                throw ("Please enter Place !!");
            }
            if (txtDate.val() == "") {
                throw ("Please enter Date !!");
            }
            if (txtfuel.val() == "") {
                throw ("Please enter fuel !!");
            }
            if (txtRate.val() == "") {
                throw ("Please enter Rate !!");
            }

            if (!isDate(txtDate.val())) {
                alert("Please Enter Valid date ( Format :: dd/mm/yyyy ) !!!");
                txtDate.focus();
                return false;
            }

            var varDate = "";
            var ArrDate = txtDate.val().split('/');
            varDate = ArrDate[1] + '/' + ArrDate[0] + '/' + ArrDate[2];

            finalFuelSlipData.push({ Place: txtPlace.val(), Date: varDate, FuelLtr: txtfuel.val(), Rate: txtRate.val(), Amount: txtAmount.val() });
        })
    } catch (e) {
        alert(e);
        return false
    }

    $("#" + lblNExpenseID_fuel.replace("lblNExpense", "hdnPopUpData")).val(JSON.stringify(finalFuelSlipData));
    $("#" + lblNExpenseID_fuel.replace("lblNExpense", "txtAmount")).val($("#txtTotal_fuel").val());
    return true;
}
/*Region fuel */


/*Region Toll */
var lblNExpenseID_Toll = "";
function OpenTollPopup(tollId) {
    lblNExpenseID_Toll = tollId;
    $('#txtCardNo_Toll').text($('#ctl00_MyCPH1_hdnJsonVehicleTollCardNo').val());
    $('#txtLastDate_Toll').text($('#ctl00_MyCPH1_hdnJsonVehicleTollCardRefDate').val());
    $('#txtLastRefNo_Toll').text($('#ctl00_MyCPH1_hdnJsonVehicleTollCardRefNo').val());
    tollPopup.dialog("open");


}

function calculateTollDetails() {
    var card = parseFloat($("#txtByCard_Toll") == "" ? "0" : $("#txtByCard_Toll").val());
    var cash = parseFloat($("#txtByCash_Toll") == "" ? "0" : $("#txtByCash_Toll").val());
    $("#txtTotal_Toll").val(card + cash);
}

function Submit_Toll() {

    if ($("#txtByCard_Toll").val() == "") {
        alert("Please add Card Amount !!");
        return false;
    }
    if ($("#txtByCash_Toll").val() == "") {
        alert("Please add Cash Amount !!");
        return false;
    }
    if ($("#txtThisDate_Toll").val() == "") {
        alert("Please add This Date !!");
        return false;
    }
    if ($("#txtThisRefNo_Toll").val() == "") {
        alert("Please add This Ref No !!");
        return false;
    }

    if (!isDate($("#txtThisDate_Toll").val())) {
        alert("Please Enter Valid date ( Format :: dd/mm/yyyy ) !!!");
        $("#txtThisDate_Toll").focus();
        return false;
    }

    var ThisDate = "";

    var ArrThisDate = $("#txtThisDate_Toll").val().split('/');
    ThisDate = ArrThisDate[1] + '/' + ArrThisDate[0] + '/' + ArrThisDate[2];

    var finalFuelSlipData = [];
    finalFuelSlipData.push({ CardNo: $("#txtCardNo_Toll").val(), ThisDate: ThisDate, ThisRefNo: $("#txtThisRefNo_Toll").val(), ByCard: $("#txtByCard_Toll").val(), ByCash: $("#txtByCash_Toll").val() })
    $("#" + lblNExpenseID_Toll.replace("lblNExpense", "hdnPopUpData")).val(JSON.stringify(finalFuelSlipData));
    $("#" + lblNExpenseID_Toll.replace("lblNExpense", "txtAmount")).val($("#txtByCash_Toll").val());
    return true;
}
/*Region Toll */

function TripSubmissionRows(action) {
    if (action == "HIDE") {
        $("#trTripsubmission").hide();
        $("#trTripsubmission1").hide();
        $("#trTripsubmission2").hide();
        $("#trTripsubmission3").hide();
        $("#trTripsubmission4").hide();
        $("#trRoute3").hide();
        $("#trRoute2").hide();
        $("#trRoute1").hide();


    }
    if (action == "SHOW") {
        $("#trTripsubmission").show();
        $("#trTripsubmission1").show();
        $("#trTripsubmission2").show();
        $("#trTripsubmission3").show();
        $("#trTripsubmission4").show();
        $("#trRoute3").show();
        $("#trRoute2").show();
        if ($("#ctl00_MyCPH1ddlRouteType").val() == "02") {
            $("#trRoute1").show();
        }

        Load_TotalfuelDetails();
    }
}

function ViewSummaryPopup() {

    var txtTotal_CF = $('#ctl00_MyCPH1_txtTotal_CF');

    if (parseFloat(txtTotal_CF.val() == "" ? "0" : txtTotal_CF.val()) < 0) {
        alert("Invalid Fuel C/F : " + txtTotal_CF.val());
        return false;
    }
    Load_TotalfuelDetails();
    SummaryPopup.dialog("open");
    return false;
}



var CardLtrs = 0.0, SlipLtrs = 0.0, FuelCashLtrs = 0.0;
var FuelSlipAmount = 0.0, FuelCardAmout = 0.0, FuelCashAmount = 0.0, DriverAdvance = 0.0;
var AddBlueSlipLtrs = 0.0, AddBlueSlipAmt = 0.0;
var AddBlueCardLtrs = 0.0, AddBlueCardAmt = 0.0;
var AddBlueCashLtrs = 0.0, AddBlueCashAmt = 0.0;
var ProposedExpense = 0.0;
function Load_TotalfuelDetails() {
    CardLtrs = 0.0, SlipLtrs = 0, FuelCashLtrs = 0;
    FuelSlipAmount = 0.0, FuelCardAmout = 0.0, FuelCashAmount = 0.0, DriverAdvance = 0.0;
    AddBlueSlipLtrs = 0.0, AddBlueSlipAmt = 0.0;
    AddBlueCardLtrs = 0.0, AddBlueCardAmt = 0.0;
    AddBlueCashLtrs = 0.0, AddBlueCashAmt = 0.0;

    var dtFuelSlip = [];
    if ($('#ctl00_MyCPH1_hdnJsonExistingfuelSlipData').val() != "") {
        dtFuelSlip = JSON.parse($('#ctl00_MyCPH1_hdnJsonExistingfuelSlipData').val());
    }

    var dtFuelCard = [];
    if ($('#ctl00_MyCPH1_hdnJsonFuelCardData').val() != "") {
        dtFuelCard = JSON.parse($('#ctl00_MyCPH1_hdnJsonFuelCardData').val());
    }

    ProposedExpense = 0.0;
    $("input[id*=txtAmount]").each(function () {

        var hfPolarity = $('#' + $(this).attr('id').replace('txtAmount', 'hfPolarity'));
        if ($(this).val() != "") {
            if (hfPolarity.val() == "+") {
                ProposedExpense = parseFloat(ProposedExpense) + parseFloat($(this).val());
            }
            if (hfPolarity.val() == "-") {
                ProposedExpense = parseFloat(ProposedExpense) - parseFloat($(this).val());
            }
            
        }
    });

    $("input[id*=hdnFinalAmount]").each(function () {

        var lblFuelType = $("#" + $(this).attr("id").replace("hdnFinalAmount", "lblFuelType"));
        var hdnIsCancel = $("#" + $(this).attr("id").replace("hdnFinalAmount", "hdnIsCancel"));

        if ($(this).val() != "" && lblFuelType.text().toUpperCase() != "ADDBLUE" && hdnIsCancel.val() != "Y") {
            FuelSlipAmount = FuelSlipAmount + parseFloat($(this).val());
        }
        if ($(this).val() != "" && lblFuelType.text().toUpperCase() == "ADDBLUE" && hdnIsCancel.val() != "Y") {
            AddBlueSlipAmt = AddBlueSlipAmt + parseFloat($(this).val());
        }
    });

    var FuelslipLtr = 0.0;

    for (var i = 0; i < dtFuelSlip.length; i++) {
        if (dtFuelSlip[i].IsCancel.toString().toUpperCase() != "Y" && dtFuelSlip[i].FuelType.toString().toUpperCase() != "ADDBLUE") {
            FuelslipLtr = FuelslipLtr + parseFloat(dtFuelSlip[i].Quantity);
            SlipLtrs = SlipLtrs + parseFloat(dtFuelSlip[i].Quantity);
        }
        if (dtFuelSlip[i].IsCancel.toString().toUpperCase() != "Y" && dtFuelSlip[i].FuelType.toString().toUpperCase() == "ADDBLUE") {
            AddBlueSlipLtrs = AddBlueSlipLtrs + parseFloat(dtFuelSlip[i].Quantity);
        }

    }

    for (var i = 0; i < dtFuelCard.length; i++) {

        if (dtFuelCard[i].FuelType.toString().toUpperCase() != "ADDBLUE") {
            FuelslipLtr = FuelslipLtr + parseFloat(dtFuelCard[i].Quantity);
            CardLtrs = CardLtrs + parseFloat(dtFuelCard[i].Quantity);
            FuelCardAmout = FuelCardAmout + parseFloat(dtFuelCard[i].Amount);
        }
        if (dtFuelCard[i].FuelType.toString().toUpperCase() == "ADDBLUE") {
            AddBlueSlipLtrs = AddBlueSlipLtrs + parseFloat(dtFuelCard[i].Quantity);
            AddBlueCardLtrs = AddBlueCardLtrs + parseFloat(dtFuelCard[i].Quantity);
            AddBlueCardAmt = AddBlueCardAmt + parseFloat(dtFuelCard[i].Amount);
        }

    }

    $("#tblfuel tbody tr").each(function () {
        var txtfuel = $(this).find("input[type=text][id*=txtfuel_]");
        var txtAmount = $(this).find("input[type=text][id*=txtCashAmount_]");
        if (txtfuel.val() != "") {
            FuelslipLtr = FuelslipLtr + parseFloat(txtfuel.val());
            FuelCashLtrs = FuelCashLtrs + parseFloat(txtfuel.val());

            if (txtAmount.val() != "") {
                FuelCashAmount = FuelCashAmount + parseFloat(txtAmount.val());
            }

        }
    });
    $("#tblAddBlue tbody tr").each(function () {
        var txtfuel = $(this).find("input[type=text][id*=txtfuel_]");
        var txtAmount = $(this).find("input[type=text][id*=txtTotalAmount_]");
        if (txtfuel.val() != "") {
            AddBlueSlipLtrs = AddBlueSlipLtrs + parseFloat(txtfuel.val());
            AddBlueCashLtrs = AddBlueCashLtrs + parseFloat(txtfuel.val());
            if (txtAmount.val() != "") {
                AddBlueCashAmt = AddBlueCashAmt + parseFloat(txtAmount.val());
                //FuelCashAmount = FuelCashAmount + parseFloat(txtAmount.val());
            }
        }
    });



    var lblTotalFuel_A, ddlFixedPerKMTotal, txtAmtRateTotal, lblTotal_CF, lblStanderdFuel, txtProposedFuel, lblFuelEconomy, lblPreviouseFuelCF_Ltr, lblPreviouseFuelCF_amount;
    lblTotalFuel_A = $('#ctl00_MyCPH1_lblTotalFuel_A');
    txtTotalFuel_A = $('#ctl00_MyCPH1_txtTotalFuel_A');
    ddlFixedPerKMTotal = $('#ctl00_MyCPH1_ddlFixedPerKMTotal');
    txtAmtRateTotal = $('#ctl00_MyCPH1_txtAmtRateTotal');
    lblTotal_CF = $('#ctl00_MyCPH1_lblTotal_CF');
    txtTotal_CF = $('#ctl00_MyCPH1_txtTotal_CF');
    lblStanderdFuel = $('#ctl00_MyCPH1_lblStanderdFuel');
    txtProposedFuel = $('#ctl00_MyCPH1_txtProposedFuel');
    lblFuelEconomy = $('#ctl00_MyCPH1_lblFuelEconomy');
    lblPreviouseFuelCF_Ltr = $('#ctl00_MyCPH1_lblPreviouseFuelCF_Ltr');
    lblPreviouseFuelCF_amount = $('#ctl00_MyCPH1_lblPreviouseFuelCF_amount');

    var txtTripEndKm = $('input[id*=txtTripEndKm]');
    var lblTripStartKm = $('span[id*=lblTripStartKm]');

    var StartKm = parseFloat((lblTripStartKm.text() == "" ? "0" : lblTripStartKm.text()));
    var EndKm = parseFloat((txtTripEndKm.val() == "" ? "0" : txtTripEndKm.val()));
    var Dist = Math.abs(EndKm - StartKm);

    FuelslipLtr = FuelslipLtr + parseFloat(lblPreviouseFuelCF_Ltr.text());

    lblTotalFuel_A.text(parseFloat(FuelslipLtr).toFixed(2));
    txtTotalFuel_A.val(parseFloat(FuelslipLtr).toFixed(2));

    if (ddlFixedPerKMTotal.val() == "P") {
        var totProposed = 0;
        //totProposed = (parseFloat(txtAmtRateTotal.val() == "" ? "0" : txtAmtRateTotal.val()) * Dist) / parseFloat(lblFuelEconomy.text() == "" ? "0" : lblFuelEconomy.text())
        if (txtAmtRateTotal.val() == "") {
            totProposed = 0.0;
        } else {
            totProposed = (parseFloat(txtAmtRateTotal.val()) == 0 ? 0 : Dist / parseFloat(txtAmtRateTotal.val()));
        }

        txtProposedFuel.val(totProposed.toFixed(2));
    }

    if (ddlFixedPerKMTotal.val() == "F") {
        txtProposedFuel.val(parseFloat(txtAmtRateTotal.val() == "" ? "0" : txtAmtRateTotal.val()));
    }


    lblTotal_CF.text((FuelslipLtr - parseFloat(txtProposedFuel.val())).toFixed(2));
    txtTotal_CF.val((FuelslipLtr - parseFloat(txtProposedFuel.val())).toFixed(2));

    DriverAdvance = 0.0;
    $("span[id*=lblDriverAdv]").each(function () {
        DriverAdvance = DriverAdvance + parseFloat($(this).text());
    });

    DriverAdvance = DriverAdvance + parseFloat($('#ctl00_MyCPH1_lblPreviouseDriverAdvanceCF_amount').text());

    //Add Blue Id
    var lblTotalAddBlue_A, ddlAddBlueFixedPerKMTotal, txtAddBlueAmtRateTotal, lblTotal_AddBlue_CF, lblStanderdAddBlue, txtProposedAddBlue, lblAddBlueEconomy, lblPreviouseAddBlueCF_Ltr, lblPreviouseAddBlueCF_amount;
    lblTotalAddBlue_A = $('#ctl00_MyCPH1_lblTotalAddBlue_A');
    txtTotalAddBlue_A = $('#ctl00_MyCPH1_txtTotalAddBlue_A');
    ddlAddBlueFixedPerKMTotal = $('#ctl00_MyCPH1_ddlAddBlueFixedPerKMTotal');
    txtAddBlueAmtRateTotal = $('#ctl00_MyCPH1_txtAddBlueAmtRateTotal');
    lblTotal_AddBlue_CF = $('#ctl00_MyCPH1_lblTotal_AddBlue_CF');
    txtTotal_AddBlue_CF = $('#ctl00_MyCPH1_txtTotal_AddBlue_CF');
    lblStanderdAddBlue = $('#ctl00_MyCPH1_lblStanderdAddBlue');
    txtProposedAddBlue = $('#ctl00_MyCPH1_txtProposedAddBlue');
    lblAddBlueEconomy = $('#ctl00_MyCPH1_lblAddBlueEconomy');
    lblPreviouseAddBlueCF_Ltr = $('#ctl00_MyCPH1_lblPreviouseAddBlueCF_Ltr');
    lblPreviouseAddBlueCF_amount = $('#ctl00_MyCPH1_lblPreviouseAddBlueCF_amount');

   
    AddBlueSlipLtrs = AddBlueSlipLtrs + parseFloat(lblPreviouseAddBlueCF_Ltr.text());

    lblTotalAddBlue_A.text(parseFloat(AddBlueSlipLtrs).toFixed(2));
    txtTotalAddBlue_A.val(parseFloat(AddBlueSlipLtrs).toFixed(2));

    if (ddlAddBlueFixedPerKMTotal.val() == "P") {
        var totAddBlueProposed = 0;
        //totProposed = (parseFloat(txtAmtRateTotal.val() == "" ? "0" : txtAmtRateTotal.val()) * Dist) / parseFloat(lblFuelEconomy.text() == "" ? "0" : lblFuelEconomy.text())
        if (txtAddBlueAmtRateTotal.val() == "") {
            totAddBlueProposed = 0.0;
        } else {
            totAddBlueProposed = (parseFloat(txtAddBlueAmtRateTotal.val()) == 0 ? 0 : Dist / parseFloat(txtAddBlueAmtRateTotal.val()));
        }

        txtProposedAddBlue.val(totAddBlueProposed.toFixed(2));
    }

    if (ddlAddBlueFixedPerKMTotal.val() == "F") {
        txtProposedAddBlue.val(parseFloat(txtAddBlueAmtRateTotal.val() == "" ? "0" : txtAddBlueAmtRateTotal.val()));
    }


    lblTotal_AddBlue_CF.text((AddBlueSlipLtrs - parseFloat(txtProposedAddBlue.val())).toFixed(2));
    txtTotal_AddBlue_CF.val((AddBlueSlipLtrs - parseFloat(txtProposedAddBlue.val())).toFixed(2));

    DriverAdvance = 0.0;
    $("span[id*=lblDriverAdv]").each(function () {
        DriverAdvance = DriverAdvance + parseFloat($(this).text());
    });

    DriverAdvance = DriverAdvance + parseFloat($('#ctl00_MyCPH1_lblPreviouseDriverAdvanceCF_amount').text());
    //Set Summary Details

    $("#txtSummaryDistance").text(Dist);
    $("#txtSummaryTotalFuel1").text(parseFloat(FuelslipLtr).toFixed(2));
    $("#txtSummaryTotalFuel").text(parseFloat(txtProposedFuel.val()).toFixed(2));
    $("#txtSummaryProposedFuel").text(parseFloat(txtProposedFuel.val()).toFixed(2));
    $("#txtSummaryTotalAddBlue").text(parseFloat(txtProposedAddBlue.val()).toFixed(2));

    //$("#txtSummaryFuelEconomy").text((Dist / FuelslipLtr));
    if (txtProposedFuel.val() == "0") {
        $("#txtSummaryFuelEconomy").text("0");
    } else {
        $("#txtSummaryFuelEconomy").text((Dist / parseFloat(txtProposedFuel.val())).toFixed(2));
    }

    $("#txtSummaryCFFuel").text(parseFloat(txtTotal_CF.val()).toFixed(2));



    $("#txtSummaryProposedExpense").text(ProposedExpense);
    //$("#txtSummaryProposedExpense").text($("#ctl00_MyCPH1_gvEnroute_txtEnAmtTotal").text());


    $("#txtSummaryDriverAdvance").text(DriverAdvance);
    $("#txtSummaryDriverBalance").text((ProposedExpense - DriverAdvance).toFixed(2));

    $("#lblAddBlueSlipLtr_Blue").text(AddBlueSlipLtrs);
    $("#lblAddBlueSlipAmt_Blue").text(AddBlueSlipAmt.toFixed(2));


    $("#lblAddBlueCardLtr_Blue").text(AddBlueCardLtrs);
    $("#lblAddBlueCardAmt_Blue").text(AddBlueCardAmt.toFixed(2));
    $("#lblAddBlueCashLtr_Blue").text(AddBlueCashLtrs);
    $("#lblAddBlueCashAmt_Blue").text(AddBlueCashAmt.toFixed(2));
    $("#lblAddBlueLtrTotal_Blue").text("0");
    $("#lblAddBlueLtrTotal_Blue").text(parseFloat(AddBlueSlipLtrs) + parseFloat(AddBlueCardLtrs) + parseFloat(AddBlueCashLtrs));
    $("#lblAddBlueAmtTotal_Blue").text("0");
    $("#lblAddBlueAmtTotal_Blue").text(parseFloat(AddBlueSlipAmt) + parseFloat(AddBlueCardAmt) + parseFloat(AddBlueCashAmt));

    var addblueratio = ((parseFloat(AddBlueSlipLtrs) + parseFloat(AddBlueCardLtrs) + parseFloat(AddBlueCashLtrs)) / parseFloat(txtProposedFuel.val())) * 100;
    //$("#txtSummaryAddBlueRatio").text(((parseFloat(AddBlueSlipLtrs) + parseFloat(AddBlueCardLtrs) + parseFloat(AddBlueCashLtrs)) / (parseFloat(txtProposedFuel.val()) * 100)).toFixed(2));
    $("#txtSummaryAddBlueRatio").text(addblueratio.toFixed(2));


    var CumulativeValue = 0.0;
    if ((SlipLtrs + CardLtrs + FuelCashLtrs + parseFloat($('#ctl00_MyCPH1_lblPreviouseFuelCF_Ltr').text())) == 0) {
        CumulativeValue = 0.0;
    } else {
        CumulativeValue = (parseFloat(FuelSlipAmount) + parseFloat(FuelCardAmout) + parseFloat(FuelCashAmount) + parseFloat($('#ctl00_MyCPH1_lblPreviouseFuelCF_amount').text())) / (parseFloat(SlipLtrs) + parseFloat(CardLtrs) + parseFloat(FuelCashLtrs) + parseFloat($('#ctl00_MyCPH1_lblPreviouseFuelCF_Ltr').text()));
    }

    var ProposedFuelAmount = 0.0;
    ProposedFuelAmount = (CumulativeValue * parseFloat(txtProposedFuel.val()));
    $("#txtSummaryProposedFuelAmount").text(ProposedFuelAmount.toFixed(2));

    var tollCardAmount = parseFloat($("#txtByCard_Toll").val() == "" ? "0" : $("#txtByCard_Toll").val());

    var perkmexpense = ((parseFloat(ProposedExpense) - parseFloat(FuelCashAmount)) + parseFloat(AddBlueSlipAmt) + parseFloat(AddBlueCardAmt) + parseFloat(tollCardAmount) + parseFloat(ProposedFuelAmount)) / Dist;
    //$("#txtSummaryPerKMExpense").text((((parseFloat(ProposedExpense) - parseFloat(FuelCashAmount)) + parseFloat(AddBlueSlipAmt) + parseFloat(AddBlueCardAmt) + parseFloat(tollCardAmount) + parseFloat(ProposedFuelAmount)) / Dist).toFixed(2));
    $("#txtSummaryPerKMExpense").text(perkmexpense.toFixed(2));

}
var TotalFuelLtrPopup;
function onTotalFuelLtrClick() {

    $("#lblSlipLtr").text(SlipLtrs);
    $("#lblCardLtr").text(CardLtrs);
    $("#lblFuelCashLtr").text(FuelCashLtrs);

    $("#lblAddBlueCashLtr").text(AddBlueCashLtrs);

    $("#lblSlipAmt").text(FuelSlipAmount);
    $("#lblCardAmt").text(FuelCardAmout);
    $("#lblFuelCashAmt").text(parseFloat(FuelCashAmount).toFixed(2));

    $("#lblFuelPreviouseCF_Ltr").text(parseFloat($('#ctl00_MyCPH1_lblPreviouseFuelCF_Ltr').text()).toFixed(2));
    $("#lblFuelPreviouseCF_amount").text(parseFloat($('#ctl00_MyCPH1_lblPreviouseFuelCF_amount').text()).toFixed(2));

    $("#lblFuelLtrTotal").text(parseFloat(SlipLtrs + CardLtrs + FuelCashLtrs + parseFloat($('#ctl00_MyCPH1_lblPreviouseFuelCF_Ltr').text())).toFixed(2));
    $("#lblFuelCashAmtTotal").text(parseFloat(FuelSlipAmount + FuelCardAmout + FuelCashAmount + parseFloat($('#ctl00_MyCPH1_lblPreviouseFuelCF_amount').text())).toFixed(2));

    TotalFuelLtrPopup.dialog("open");
}
// Added By Kinjal Patel
var TotalAddBlueLtrPopup;
function onTotalAddBlueLtrClick() {

    $("#lblAddBlueSlipLtr").text(SlipLtrs);
    $("#lblAddBlueCardLtr").text(CardLtrs);
    $("#lblAddBlueCashLtr1").text(FuelCashLtrs);

  //  $("#lblAddBlueCashLtr").text(AddBlueCashLtrs);

    $("#lblAddBlueSlipAmt").text(FuelSlipAmount);
    $("#lblAddBlueCardAmt").text(FuelCardAmout);
    $("#lblAddBlueCashAmt").text(parseFloat(FuelCashAmount).toFixed(2));

    $("#lblAddBluePreviouseCF_Ltr").text(parseFloat($('#ctl00_MyCPH1_lblAddBluePreviouseCF_Ltr').text()).toFixed(2));
    $("#lblAddBluePreviouseCF_amount").text(parseFloat($('#ctl00_MyCPH1_lblAddBluePreviouseCF_amount').text()).toFixed(2));

    $("#lblAddBlueLtrTotal").text(parseFloat(SlipLtrs + CardLtrs + FuelCashLtrs + parseFloat($('#ctl00_MyCPH1_lblPreviouseAddBlueCF_Ltr').text())).toFixed(2));
    $("#lblAddBlueCashAmtTotal").text(parseFloat(FuelSlipAmount + FuelCardAmout + FuelCashAmount + parseFloat($('#ctl00_MyCPH1_lblPreviouseAddBlueCF_amount').text())).toFixed(2));

    TotalAddBlueLtrPopup.dialog("open");
}
//Added By KInjal Patel

function CancelFuelSlip(ctrl) {

    var lnkCancelFuelSlip = $(ctrl);
    var hdnIsBilled = $("#" + $(ctrl).attr("id").replace("lnkCancelFuelSlip", "hdnIsBilled"));
    if (hdnIsBilled.val() == "Y") {
        alert("Bill already generated for selected Fuel Slip!! ");
        return false;
    }

    var ConFirmBox = confirm("Are you sure you want to cancel fuel slip ?");
    if (ConFirmBox == false) {
        return false;
    }
    return true;
}

function GetRateFillingDateWise(ctrl) {

    var txtFillingDate = $(ctrl);
    var txtFillingDateID = $(ctrl).attr("id");
    var lblRateAsPerFillingDate = $("#" + txtFillingDateID.replace("txtFillingDate", "lblRateAsPerFillingDate"));
    var lblFinalAmount = $("#" + txtFillingDateID.replace("txtFillingDate", "lblFinalAmount"));

    var hdnRateAsPerFillingDate = $("#" + txtFillingDateID.replace("txtFillingDate", "hdnRateAsPerFillingDate"));
    var hdnFinalAmount = $("#" + txtFillingDateID.replace("txtFillingDate", "hdnFinalAmount"));

    var lblQuantity = $("#" + txtFillingDateID.replace("txtFillingDate", "lblQuantity"));
    var hdnVendorCode = $("#" + txtFillingDateID.replace("txtFillingDate", "hdnVendorCode"));
    var lblFuelType = $("#" + txtFillingDateID.replace("txtFillingDate", "lblFuelType"));

    if (txtFillingDate.val() != '') {
        var EndArray = txtFillingDate.val().split("/");
        var startDt = new Date();
        var endDt = new Date(EndArray[2], EndArray[1] - 1, EndArray[0]);
        if (endDt > startDt) {
            alert('Filling date Can not be greater than Today !!');
            txtFillingDate.focus();
            txtFillingDate.val("");
            return false;
        }
    }


    var obj = {};
    obj.VendorCode = hdnVendorCode.val();
    obj.FuelType = lblFuelType.text();
    obj.FillingDate = txtFillingDate.val();


    if (txtFillingDate.val() != "") {
        $.ajax({
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            url: "TripSubmission_CloseVer1.aspx/GetRateFillingDateWise",
            dataType: 'json',
            data: JSON.stringify(obj),
            async: false,
            success: function (data) {
                var rate = data.d;
                if (rate == "") {
                    alert("No contract found on selected filling date");
                    txtFillingDate.val("");
                    txtFillingDate.focus();
                }
                else {
                    if (parseFloat(rate) > 0) {
                        lblRateAsPerFillingDate.text(rate);
                        hdnRateAsPerFillingDate.val(rate);
                        lblFinalAmount.text((parseFloat(lblQuantity.text()) * parseFloat(lblRateAsPerFillingDate.text())).toFixed(2));
                        hdnFinalAmount.val((parseFloat(lblQuantity.text()) * parseFloat(lblRateAsPerFillingDate.text())).toFixed(2));
                        // lblFinalAmount.text(parseFloat(lblQuantity.text()) * parseFloat(lblRateAsPerFillingDate.text()));
                        // hdnFinalAmount.val(parseFloat(lblQuantity.text()) * parseFloat(lblRateAsPerFillingDate.text()))
                    }
                }
            },
            error: function (e) {
                alert(e);
            }
        });
    }

}

function SummaryCancel() {
    SummaryPopup.dialog("close")
    return false;
}

function SetRecoverableAmount(type) {
    var amt = 0;
    $("input[id*=txtRecoverableAmount]").each(function () {
        if ($(this).val() != "") {
            amt = amt + parseFloat($(this).val());
        }
    });

    if (type == "VALIDATE") {
        var recoveramt = parseFloat($("#ctl00_MyCPH1_gvEnroute_ctl02_txtAmount").val() == "" ? "0" : $("#ctl00_MyCPH1_gvEnroute_ctl02_txtAmount").val());
        if (recoveramt > amt) {
            alert("Can not increase recoverable amount !!");
            $("#ctl00_MyCPH1_gvEnroute_ctl02_txtAmount").val(amt);
        }
    } else {
        $("#ctl00_MyCPH1_gvEnroute_ctl02_txtAmount").val(amt);
    }

}

var lblNExpenseID_ProtsahanRashi = "";
function OpenProtsahanRashiPopup(ProtsahanRashiId) {
    lblNExpenseID_ProtsahanRashi = ProtsahanRashiId;
    protsahanrashiPopup.dialog("open");

    //ctl00_MyCPH1_grdProtsahanRashi
}


function Submit_ProtsahanRashi() {

    var finalProtsahanRashiData = [];

    try {
        var TotalProtsahanRashi = 0.00;
        $("#ctl00_MyCPH1_grdProtsahanRashi tbody tr").each(function () {
            var txtETHCNo = $(this).find("[id*=txtETHCNo]");
            var txtTransitDays = $(this).find("input[id*=txtTransitDays]");
            var txtSaveDays = $(this).find("input[id*=txtSaveDays]");
            var txtAmount = $(this).find("input[id*=txtAmount]");
            var txtRemarks = $(this).find("input[id*=txtRemarks]");
            if (txtAmount.length != 0) {
                if (txtAmount.val() != "" && txtAmount.val() != null && txtAmount.val() != undefined) {
                    TotalProtsahanRashi += parseFloat(txtAmount.val());
                }
                finalProtsahanRashiData.push({ ETHCNo: txtETHCNo.text(), TransitDays: txtTransitDays.val(), SaveDays: txtSaveDays.val(), Amount: txtAmount.val(), Remarks: txtRemarks.val() });
            }            
        });
    } catch (e) {
        alert(e);
        return false
    }

    $("#" + lblNExpenseID_ProtsahanRashi.replace("lblNExpense", "txtAmount")).val(parseFloat(TotalProtsahanRashi));
    $("#" + lblNExpenseID_ProtsahanRashi.replace("lblNExpense", "hdnPopUpData")).val(JSON.stringify(finalProtsahanRashiData));
    GVcalculateBalanceNewVer1();
    return true;
}