/// <reference name="MicrosoftAjax.js"/>
$(document).ready(function () {

    //var txtCurrentKM1 = document.getElementById("ctl00_MyCPH1_txtCurrentKM1");
    //var txtCurrentKM2 = document.getElementById("ctl00_MyCPH1_txtCurrentKM2");
    //var txtCurrentKM3 = document.getElementById("ctl00_MyCPH1_txtCurrentKM3");
    //var txtCurrentKM4 = document.getElementById("ctl00_MyCPH1_txtCurrentKM4");

    //var txtLastKM1 = document.getElementById("ctl00_MyCPH1_txtLastKM1");
    //var txtLastKM2 = document.getElementById("ctl00_MyCPH1_txtLastKM2");
    //var txtLastKM3 = document.getElementById("ctl00_MyCPH1_txtLastKM3");
    //var txtLastKM4 = document.getElementById("ctl00_MyCPH1_txtLastKM4");

    //CheckCurrentKM1(txtCurrentKM1, txtLastKM1);
    //CheckCurrentKM2(txtCurrentKM2, txtLastKM2);
    //CheckCurrentKM3(txtCurrentKM3, txtLastKM3);
    //CheckCurrentKM4(txtCurrentKM4, txtLastKM4);
});


function createXMLHttpRequest() {
    // Mozilla, Safari,...
    if (window.XMLHttpRequest) { xmlHttpRequest = new XMLHttpRequest(); if (xmlHttpRequest.overrideMimeType) xmlHttpRequest.overrideMimeType("text/xml"); }
        // IE
    else if (window.ActiveXObject) { try { xmlHttpRequest = new ActiveXObject("Msxml2.XMLHTTP"); } catch (e) { try { xmlHttpRequest = new ActiveXObject("Microsoft.XMLHTTP"); } catch (e) { } } }
}


function ChangeToUpper() { key = window.event.which || window.event.keyCode; if ((key > 0x60) && (key < 0x7B)) window.event.keyCode = key - 0x20; }

function CheckFromValidCity(row_Index, txtFrom, hdnFromCity) {
    var currentTime = new Date()
    var str_Index = "";

    if (txtFrom.value == "") {
        return true;
    }

    var gvVehicleLogEntry = document.getElementById("ctl00_MyCPH1_gvVehicleLogEntry");

    //    for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_gvVehicleLogEntry").rows.length; intIndex++) {
    //        if (intIndex < 10) {
    //            str_Index = "0" + intIndex;
    //        }
    //        else {
    //            str_Index = intIndex;
    //        }
    //        if (row_Index == intIndex - 2) {
    //            continue;
    //        }
    //        if (document.getElementById("ctl00_MyCPH1_gvVehicleLogEntry_ctl" + str_Index + "_txtFrom").value == txtFrom.value) {
    //            alert("This Part already exist at row " + (intIndex - 1));
    //            txtFrom.value = "";
    //            txtFrom.focus();
    //            return;
    //        }
    //    }

    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    alert("Invalid City. !!! Please check.");
                    txtFrom.focus();
                    txtFrom.value = "";
                    return false;
                }
                else {

                    hdnFromCity.value = returnValue[1];

                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckValidCityCode&datetime=" + currentTime + "&CityName=" + txtFrom.value, false);
        xmlHttpRequest.send(null);
    }
}



function CheckToValidCity(row_Index, txtTo, hdnToCity) {
    var currentTime = new Date()
    var str_Index = "";

    if (txtTo.value == "") {
        return true;
    }

    var gvVehicleLogEntry = document.getElementById("ctl00_MyCPH1_gvVehicleLogEntry");

    //    for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_gvVehicleLogEntry").rows.length; intIndex++) {
    //        if (intIndex < 10) {
    //            str_Index = "0" + intIndex;
    //        }
    //        else {
    //            str_Index = intIndex;
    //        }
    //        if (row_Index == intIndex - 2) {
    //            continue;
    //        }
    //        if (document.getElementById("ctl00_MyCPH1_gvVehicleLogEntry_ctl" + str_Index + "_txtTo").value == txtTo.value) {
    //            alert("This Part already exist at row " + (intIndex - 1));
    //            txtTo.value = "";
    //            txtTo.focus();
    //            return;
    //        }
    //    }
    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    alert("Invalid City. !!! Please check.");
                    txtTo.focus();
                    txtTo.value = "";
                    return false;
                }
                else {
                    hdnToCity.value = returnValue[1];
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckValidCityCode&datetime=" + currentTime + "&CityName=" + txtTo.value, false);
        xmlHttpRequest.send(null);
    }
}
function CheckValidLocation(txtLocation) {
    var currentTime = new Date()
    var str_Index = "";

    if (txtLocation.value == "") {
        return true;
    }

    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    alert("Invalid Location entered. !!! Please check.");
                    txtLocation.focus();
                    txtLocation.value = "";
                    return false;
                }
               
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=GetNewControllingBranch&datetime=" + currentTime + "&LocCode=" + txtLocation.value, false);
        xmlHttpRequest.send(null);
    }
}

//added By Anupam on 06042016
function checkCustomerCode(rowID) {

    var TextBoxCustomerTypeM, ddlCustomerType;
    //Find the GridView Row using the LinkButton reference.
    var row = rowID.parentNode.parentNode;
    //Fetch all controls in GridView Row.
    var controls = row.getElementsByTagName("*");
    //Loop through the fetched controls.
    for (var i = 0; i < controls.length; i++) {

        //Find the TextBox control.
        if (controls[i].id.indexOf("TextBoxCustomerTypeM") != -1) {
            TextBoxCustomerTypeM = controls[i];
        }

        //Find the DropDownList control.
        if (controls[i].id.indexOf("ddlCustomerType") != -1) {
            ddlCustomerType = controls[i];
        }
    }
    if (ddlCustomerType.value == "0") {
        alert("Select Customer Type!!!");
        ddlCustomerType.focus();
        return false;
    }
    if (ddlCustomerType.value == "1") {

        if (TextBoxCustomerTypeM.value != "") {
            if (TextBoxCustomerTypeM.value.search("~") > 0) {
                var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");
                hdnajaxstate.value = "1";
                var CustomerCode = TextBoxCustomerTypeM.value.split("~");
                createXMLHttpRequest();
                if (xmlHttpRequest) {
                    xmlHttpRequest.onreadystatechange = function () {
                        if (xmlHttpRequest.readyState == 4) {
                            var returnValue = xmlHttpRequest.responseText.split("~");
                            if (returnValue[0] == "N") {
                                alert("Invalid Customer. OR Customer Is not Defined In Customer Master OR Customer is not Active !!! Please check.");
                                TextBoxCustomerTypeM.value = "";
                                TextBoxCustomerTypeM.focus();
                                return false;
                            }
                            else {
                            }
                        }
                    }
                    var currentTime = new Date()
                    xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckCustomerCode&datetime=" + currentTime + "&CustCode=" + CustomerCode[1].trim(), false);
                    xmlHttpRequest.send(null);
                }
            }
            else {
                alert("Invalid Customer. Please select Customer from Auto complete");
                TextBoxCustomerTypeM.value = "";
                TextBoxCustomerTypeM.focus();
                return false;
            }
        }
    }
}

function CheckCustomerType(rowID) {
    var TextBoxCustomerTypeM, ddlCustomerType;
    //Find the GridView Row using the LinkButton reference.
    var row = rowID.parentNode.parentNode;
    //Fetch all controls in GridView Row.
    var controls = row.getElementsByTagName("*");
    //Loop through the fetched controls.
    for (var i = 0; i < controls.length; i++) {

        //Find the TextBox control.
        if (controls[i].id.indexOf("TextBoxCustomerTypeM") != -1) {
            TextBoxCustomerTypeM = controls[i];
        }
        if (controls[i].id.indexOf("TextBoxAdvanceAmountByBranchM") != -1) {
            TextBoxAdvanceAmountByBranchM = controls[i];
        }
        //Find the DropDownList control.
        if (controls[i].id.indexOf("ddlCustomerType") != -1) {
            ddlCustomerType = controls[i];
        }
    }
    TextBoxCustomerTypeM.value = "";
    TextBoxCustomerTypeM.focus();   
}


function CheckAdvanceTakenBy(rowID) {
    var textBoxCustomerTypeM, ddlCustomerType;
    //Find the GridView Row using the LinkButton reference.
    var row = rowID.parentNode.parentNode;
    //Fetch all controls in GridView Row.
    var controls = row.getElementsByTagName("*");
    //Loop through the fetched controls.
    for (var i = 0; i < controls.length; i++) {

        //Find the TextBox control.
        if (controls[i].id.indexOf("TextBoxAdvanceAmountByDriverM") != -1) {
            TextBoxAdvanceAmountByDriverM = controls[i];
        }
        if (controls[i].id.indexOf("TextBoxAdvanceAmountByBranchM") != -1) {
            TextBoxAdvanceAmountByBranchM = controls[i];
        }
        //Find the DropDownList control.
        if (controls[i].id.indexOf("ddlAdvanceTakenBy") != -1) {
            ddlAdvanceTakenBy = controls[i];
        }
    }
    if (ddlAdvanceTakenBy.value == "0") {
        TextBoxAdvanceAmountByDriverM.value = 0;
        TextBoxAdvanceAmountByBranchM.value = 0;
        TextBoxAdvanceAmountByDriverM.contentEditable = false;
        TextBoxAdvanceAmountByBranchM.contentEditable = false;
        return true;
    }
    if (ddlAdvanceTakenBy.value == "1") {
        TextBoxAdvanceAmountByBranchM.value = 0;
        TextBoxAdvanceAmountByBranchM.contentEditable = false;
        TextBoxAdvanceAmountByDriverM.contentEditable = true;
        TextBoxAdvanceAmountByDriverM.focus();
        return true;
    }
    if (ddlAdvanceTakenBy.value == "2") {
        TextBoxAdvanceAmountByDriverM.value = 0;
        TextBoxAdvanceAmountByDriverM.contentEditable = false;
        TextBoxAdvanceAmountByBranchM.contentEditable = true;
        TextBoxAdvanceAmountByBranchM.focus();
        return true;
    }
    if (ddlAdvanceTakenBy.value == "3") {
        TextBoxAdvanceAmountByDriverM.contentEditable = true;
        TextBoxAdvanceAmountByBranchM.contentEditable = true;
        TextBoxAdvanceAmountByDriverM.focus();
        return true;
    }
}

function CheckValidation() {

    var gvVehicleLogEntry = document.getElementById("ctl00_MyCPH1_gvVehicleLogEntry");
    var gvTHC = document.getElementById("ctl00_MyCPH1_gvTHC");

    if (gvVehicleLogEntry != null) {
        //alert("1");
        if (gvVehicleLogEntry.rows.length != 0) {
            for (i = 0; i < gvVehicleLogEntry.rows.length - 1; i++) {
                j = i + 3;
                var pref = "";
                if (j < 10) {
                    pref = "ctl00_MyCPH1_gvVehicleLogEntry_ctl0" + j + "_";
                }
                else {
                    pref = "ctl00_MyCPH1_gvVehicleLogEntry_ctl" + j + "_";
                }

                var txtFrom = document.getElementById(pref + "txtFrom");
                var txtTo = document.getElementById(pref + "txtTo");
                var ddlCategory = document.getElementById(pref + "ddlCategory");
                var txtContainerNo = document.getElementById(pref + "txtContainerNo");
                var txtInvoiceNo = document.getElementById(pref + "txtInvoiceNo");

                var txtStartKm = document.getElementById(pref + "txtStartKm");
                var txtStartDate = document.getElementById(pref + "txtStartDate");

                var tb_StartTime_HH = document.getElementById(pref + "tb_StartTime_HH");
                var tb_StartTime_MM = document.getElementById(pref + "tb_StartTime_MM");

                var txtEndKm = document.getElementById(pref + "txtEndKm");
                var txtEndDate = document.getElementById(pref + "txtEndDate");
                var tb_EndTime_HH = document.getElementById(pref + "tb_EndTime_HH");
                var tb_EndTime_MM = document.getElementById(pref + "tb_EndTime_MM");

                if (txtFrom.value == "") {
                    alert("Enter From City!!!")
                    txtFrom.focus();
                    
                    return false;
                }
                if (txtTo.value == "") {
                    alert("Enter To City!!!");
                    txtTo.focus();
                    
                    return false;
                }
                if (ddlCategory.value == "0") {
                    alert("Select Category!!!");
                    ddlCategory.focus();
                    return false;
                }

                if (ddlCategory.value == "7" && txtContainerNo.value == "" || ddlCategory.value == "8" && txtContainerNo.value == "") {
                    alert("Enter Container No.!!!");
                    txtContainerNo.focus();
                    return false;
                }

                if (ddlCategory.value != "7" && ddlCategory.value != "8" && txtContainerNo.value != "") {
                    alert("Can not Enter Container No. \r\n because you have not selected Empty or Full Container Category!!!");
                    txtContainerNo.value = "";
                    return false;
                }


                if (ddlCategory.value != "7" && ddlCategory.value != "9" && txtInvoiceNo.value == "") {
                    alert("Enter Document No");
                    txtInvoiceNo.focus();   
                    return false;
                }


                if (ddlCategory.value != "1" && ddlCategory.value != "2" && ddlCategory.value != "3" &&
                    ddlCategory.value != "4" && ddlCategory.value != "5" && ddlCategory.value != "6" &&
                    ddlCategory.value != "8" && txtInvoiceNo.value != "") {
                    alert("Can not Enter Document No. \r\n because you have not selected Empty or Full Container Category!!!");
                    txtInvoiceNo.value = "";
                    return false;
                }

                if (txtStartKm.value == "") {
                    alert("Enter Start KM");
                    txtStartKm.focus();    
                    return false;
                }

                if (txtStartDate.value == "") {
                    alert("Select Start Date");
                    txtStartDate.focus();
                    
                    return false;
                }

                if (tb_StartTime_HH.value == "") {
                    alert("Enter Start Time Hour");
                    tb_StartTime_HH.focus();
                    
                    return false;
                }

                if (tb_StartTime_MM.value == "") {
                    alert("Enter Start Time Minute");
                    tb_StartTime_MM.focus();
                 
                    return false;
                }

                if (txtEndKm.value == "") {
                    alert("Enter End KM");
                    txtEndKm.focus();
                    return false;
                }

                if (txtEndDate.value == "") {
                    alert("Select End Date");
                    txtEndDate.focus();
                    
                    return false;
                }

                if (tb_EndTime_HH.value == "") {
                    alert("Enter End Time Hour");
                    tb_EndTime_HH.focus();
                    
                    return false;
                }

                if (tb_EndTime_MM.value == "") {
                    alert("Enter End Time Minute");
                    tb_EndTime_MM.focus();
                    
                    return false;
                }
            }
        }
    }


    if (gvTHC != null) {
        if (gvTHC.rows.length != 0) {
            for (i = 0; i < gvTHC.rows.length - 2; i++) {
                j = i + 2;
                var pref = "";
                if (j < 10) {
                    pref = "ctl00_MyCPH1_gvTHC_ctl0" + j + "_";
                }
                else {
                    pref = "ctl00_MyCPH1_gvTHC_ctl" + j + "_";
                }
                var txtFrom = document.getElementById(pref + "txtFrom");
                var txtTo = document.getElementById(pref + "txtTo");
                var txtTHCNo = document.getElementById(pref + "txtTHCNo");
                var txtTHCDt = document.getElementById(pref + "txtTHCDt");
                var txtFreightAmt = document.getElementById(pref + "txtFreightAmt");
                var txtTHCTotalAmt = document.getElementById(pref + "txtTHCTotalAmt");

                if (txtFrom.value == "") {
                    alert("Enter From City!!!");
                    txtFrom.focus();
                    return false;
                }
                if (txtTo.value == "") {
                    alert("Enter To City!!!");
                    txtTo.focus();
                    return false;
                }
                if (txtTHCNo.value == "") {
                    alert("Enter THC Number !!!");
                    txtTHCNo.focus();
                    return false;
                }
                if (txtTHCDt.value == "") {
                    alert("Enter THC Date!!!");
                    txtTHCDt.focus();
                    return false;
                }
                if (txtFreightAmt.value == "0") {
                    alert("Enter Freight Amount!!!");
                    txtFreightAmt.focus();
                    return false;
                }
            }
        }
    }

    var ConFirmBox = confirm("Are you sure to submit data?");
    if (ConFirmBox == false) {
        return false;
    }
}



function CheckCurrentKM1(txtCurrentKM1, txtLastKM1) {

    var txtLastKM2 = document.getElementById("ctl00_MyCPH1_txtLastKM2");
    var hdnLastKM = document.getElementById("ctl00_MyCPH1_hdnLastKM");

    var txtCurrentKM2 = document.getElementById("ctl00_MyCPH1_txtCurrentKM2");
    var txtCurrentKM3 = document.getElementById("ctl00_MyCPH1_txtCurrentKM3");
    var txtCurrentKM4 = document.getElementById("ctl00_MyCPH1_txtCurrentKM4");

    var txtLastKM2 = document.getElementById("ctl00_MyCPH1_txtLastKM2");
    var txtLastKM3 = document.getElementById("ctl00_MyCPH1_txtLastKM3");
    var txtLastKM4 = document.getElementById("ctl00_MyCPH1_txtLastKM4");

    var txtDifference1 = document.getElementById("ctl00_MyCPH1_txtDifference1");
    var txtDifference2 = document.getElementById("ctl00_MyCPH1_txtDifference2");
    var txtDifference3 = document.getElementById("ctl00_MyCPH1_txtDifference3");
    var txtDifference4 = document.getElementById("ctl00_MyCPH1_txtDifference4");

    if (parseFloat(txtCurrentKM1.value) < parseFloat(txtLastKM1.value)) {
        alert("Current km reading cannot be less than last km reading!");
        txtCurrentKM1.value = "";
        txtCurrentKM2.value = "";
        txtCurrentKM3.value = "";
        txtCurrentKM4.value = "";
        txtLastKM2.value = "";
        txtLastKM3.value = "";
        txtLastKM4.value = "";
        txtDifference1.value = "";
        txtDifference2.value = "";
        txtDifference3.value = "";
        txtDifference4.value = "";
        txtCurrentKM1.focus();
        return false;
    }
    else {
        txtLastKM2.value = txtCurrentKM1.value;
    }

    if (parseFloat(txtCurrentKM1.value) > parseFloat(hdnLastKM.value)) {
        alert("Current km reading cannot be greater than last km reading of Trip Movement i.e. " + hdnLastKM.value + "!");
        txtCurrentKM1.value = "";
        txtCurrentKM2.value = "";
        txtCurrentKM3.value = "";
        txtCurrentKM4.value = "";
        txtLastKM2.value = "";
        txtLastKM3.value = "";
        txtLastKM4.value = "";
        txtDifference1.value = "";
        txtDifference2.value = "";
        txtDifference3.value = "";
        txtDifference4.value = "";
        txtCurrentKM1.focus();
        return false;
    }

    var txtDifference1 = document.getElementById("ctl00_MyCPH1_txtDifference1");
    if (txtCurrentKM1.value != "" && txtLastKM1.value != "") {
        txtDifference1.value = roundNumber((parseFloat(txtCurrentKM1.value) - parseFloat(txtLastKM1.value)), 2);
    }

    var txtDifference1 = document.getElementById("ctl00_MyCPH1_txtDifference1");
    var txtKMPL1 = document.getElementById("ctl00_MyCPH1_txtKMPL1");
    var txtDieselQty1 = document.getElementById("ctl00_MyCPH1_txtDieselQty1");

    if (txtDifference1.value != "" && txtDieselQty1.value != "") {
        txtKMPL1.value = roundNumber((parseFloat(txtDifference1.value) / parseFloat(txtDieselQty1.value)), 2);
    }

}

function CheckCurrentKM2(txtCurrentKM2, txtLastKM2) {

    var txtLastKM3 = document.getElementById("ctl00_MyCPH1_txtLastKM3");
    var hdnLastKM = document.getElementById("ctl00_MyCPH1_hdnLastKM");

    var txtCurrentKM3 = document.getElementById("ctl00_MyCPH1_txtCurrentKM3");
    var txtCurrentKM4 = document.getElementById("ctl00_MyCPH1_txtCurrentKM4");

    var txtLastKM3 = document.getElementById("ctl00_MyCPH1_txtLastKM3");
    var txtLastKM4 = document.getElementById("ctl00_MyCPH1_txtLastKM4");

    var txtDifference2 = document.getElementById("ctl00_MyCPH1_txtDifference2");
    var txtDifference3 = document.getElementById("ctl00_MyCPH1_txtDifference3");
    var txtDifference4 = document.getElementById("ctl00_MyCPH1_txtDifference4");

    if (parseFloat(txtCurrentKM2.value) < parseFloat(txtLastKM2.value)) {
        alert("Current km reading cannot be less than last km reading!");
        txtCurrentKM2.value = "";
        txtCurrentKM3.value = "";
        txtCurrentKM4.value = "";
        txtLastKM3.value = "";
        txtLastKM4.value = "";
        txtDifference2.value = "";
        txtDifference3.value = "";
        txtDifference4.value = "";
        txtCurrentKM2.focus();
        return false;
    }
    else {
        txtLastKM3.value = txtCurrentKM2.value;
    }
    if (parseFloat(txtCurrentKM2.value) > parseFloat(hdnLastKM.value)) {
        alert("Current km reading cannot be greater than last km reading of Trip Movement i.e. " + hdnLastKM.value + "!");
        txtCurrentKM2.value = "";
        txtCurrentKM3.value = "";
        txtCurrentKM4.value = "";
        txtLastKM3.value = "";
        txtLastKM4.value = "";
        txtDifference2.value = "";
        txtDifference3.value = "";
        txtDifference4.value = "";
        txtCurrentKM2.focus();
        return false;
    }

    var txtDifference2 = document.getElementById("ctl00_MyCPH1_txtDifference2");
    if (txtCurrentKM2.value != "" && txtLastKM2.value != "") {
        txtDifference2.value = roundNumber((parseFloat(txtCurrentKM2.value) - parseFloat(txtLastKM2.value)), 2);
    }

    var txtDifference2 = document.getElementById("ctl00_MyCPH1_txtDifference2");
    var txtKMPL2 = document.getElementById("ctl00_MyCPH1_txtKMPL2");
    var txtDieselQty2 = document.getElementById("ctl00_MyCPH1_txtDieselQty2");

    if (txtDifference2.value != "" && txtDieselQty2.value != "") {
        txtKMPL2.value = roundNumber((parseFloat(txtDifference2.value) / parseFloat(txtDieselQty2.value)), 2);
    }

}

function CheckCurrentKM3(txtCurrentKM3, txtLastKM3) {

    var txtLastKM4 = document.getElementById("ctl00_MyCPH1_txtLastKM4");
    var hdnLastKM = document.getElementById("ctl00_MyCPH1_hdnLastKM");

    var txtCurrentKM4 = document.getElementById("ctl00_MyCPH1_txtCurrentKM4");

    var txtLastKM4 = document.getElementById("ctl00_MyCPH1_txtLastKM4");

    var txtDifference3 = document.getElementById("ctl00_MyCPH1_txtDifference3");
    var txtDifference4 = document.getElementById("ctl00_MyCPH1_txtDifference4");


    if (parseFloat(txtCurrentKM3.value) < parseFloat(txtLastKM3.value)) {
        alert("Current km reading cannot be less than last km reading!");
        txtCurrentKM3.value = "";
        txtCurrentKM4.value = "";
        txtLastKM4.value = "";
        txtDifference3.value = "";
        txtDifference4.value = "";
        txtCurrentKM3.focus();
        return false;
    }
    else {
        txtLastKM4.value = txtCurrentKM3.value;
    }

    if (parseFloat(txtCurrentKM3.value) > parseFloat(hdnLastKM.value)) {
        alert("Current km reading cannot be greater than last km reading of Trip Movement i.e. " + hdnLastKM.value + "!");
        txtCurrentKM3.value = "";
        txtCurrentKM4.value = "";
        txtLastKM4.value = "";
        txtDifference3.value = "";
        txtDifference4.value = "";
        txtCurrentKM3.focus();
        return false;
    }

    var txtDifference3 = document.getElementById("ctl00_MyCPH1_txtDifference3");
    if (txtCurrentKM3.value != "" && txtLastKM3.value != "") {
        txtDifference3.value = roundNumber((parseFloat(txtCurrentKM3.value) - parseFloat(txtLastKM3.value)), 2);
    }

    var txtDifference3 = document.getElementById("ctl00_MyCPH1_txtDifference3");
    var txtKMPL3 = document.getElementById("ctl00_MyCPH1_txtKMPL3");
    var txtDieselQty3 = document.getElementById("ctl00_MyCPH1_txtDieselQty3");

    if (txtDifference3.value != "" && txtDieselQty3.value != "") {
        txtKMPL3.value = roundNumber((parseFloat(txtDifference3.value) / parseFloat(txtDieselQty3.value)), 2);
    }

}

function CheckCurrentKM4(txtCurrentKM4, txtLastKM4) {

    var hdnLastKM = document.getElementById("ctl00_MyCPH1_hdnLastKM");

    var txtDifference4 = document.getElementById("ctl00_MyCPH1_txtDifference4");


    if (parseFloat(txtCurrentKM4.value) < parseFloat(txtLastKM4.value)) {
        alert("Current km reading cannot be less than last km reading!");
        txtCurrentKM4.value = "";
        txtDifference4.value = "";
        txtCurrentKM4.focus();
        return false;
    }
    if (parseFloat(txtCurrentKM4.value) > parseFloat(hdnLastKM.value)) {
        alert("Current km reading cannot be greater than last km reading of Trip Movement i.e. " + hdnLastKM.value + "!");
        txtCurrentKM4.value = "";
        txtDifference4.value = "";
        txtCurrentKM4.focus();
        return false;
    }

    var txtDifference4 = document.getElementById("ctl00_MyCPH1_txtDifference4");
    if (txtCurrentKM4.value != "" && txtLastKM4.value != "") {
        txtDifference4.value = roundNumber((parseFloat(txtCurrentKM4.value) - parseFloat(txtLastKM4.value)), 2);
    }

    var txtDifference4 = document.getElementById("ctl00_MyCPH1_txtDifference4");
    var txtKMPL4 = document.getElementById("ctl00_MyCPH1_txtKMPL4");
    var txtDieselQty4 = document.getElementById("ctl00_MyCPH1_txtDieselQty4");

    if (txtDifference4.value != "" && txtDieselQty4.value != "") {
        txtKMPL4.value = roundNumber((parseFloat(txtDifference4.value) / parseFloat(txtDieselQty4.value)), 2);
    }
}


function CalculateDieselAmount() {
    var txtDieselQty1 = document.getElementById("ctl00_MyCPH1_txtDieselQty1");
    var txtDieselRate1 = document.getElementById("ctl00_MyCPH1_txtDieselRate1");
    var txtAmount1 = document.getElementById("ctl00_MyCPH1_txtAmount1");

    var txtDifference1 = document.getElementById("ctl00_MyCPH1_txtDifference1");
    var txtKMPL1 = document.getElementById("ctl00_MyCPH1_txtKMPL1");

    if (txtDieselQty1.value != "" && txtDieselRate1.value != "") {
        txtAmount1.value = roundNumber((parseFloat(txtDieselQty1.value) * parseFloat(txtDieselRate1.value)), 2);
    }

    if (txtDifference1.value != "" && txtDieselQty1.value != "") {
        txtKMPL1.value = roundNumber((parseFloat(txtDifference1.value) / parseFloat(txtDieselQty1.value)), 2);
    }

    var txtDieselQty2 = document.getElementById("ctl00_MyCPH1_txtDieselQty2");
    var txtDieselRate2 = document.getElementById("ctl00_MyCPH1_txtDieselRate2");
    var txtAmount2 = document.getElementById("ctl00_MyCPH1_txtAmount2");

    var txtDifference2 = document.getElementById("ctl00_MyCPH1_txtDifference2");
    var txtKMPL2 = document.getElementById("ctl00_MyCPH1_txtKMPL2");

    if (txtDieselQty2.value != "" && txtDieselRate2.value != "") {
        txtAmount2.value = roundNumber((parseFloat(txtDieselQty2.value) * parseFloat(txtDieselRate2.value)), 2);
    }

    if (txtDifference2.value != "" && txtDieselQty2.value != "") {
        txtKMPL2.value = roundNumber((parseFloat(txtDifference2.value) / parseFloat(txtDieselQty2.value)), 2);
    }

    var txtDieselQty3 = document.getElementById("ctl00_MyCPH1_txtDieselQty3");
    var txtDieselRate3 = document.getElementById("ctl00_MyCPH1_txtDieselRate3");
    var txtAmount3 = document.getElementById("ctl00_MyCPH1_txtAmount3");

    var txtDifference3 = document.getElementById("ctl00_MyCPH1_txtDifference3");
    var txtKMPL3 = document.getElementById("ctl00_MyCPH1_txtKMPL3");

    if (txtDieselQty3.value != "" && txtDieselRate3.value != "") {
        txtAmount3.value = roundNumber((parseFloat(txtDieselQty3.value) * parseFloat(txtDieselRate3.value)), 2);
    }

    if (txtDifference3.value != "" && txtDieselQty3.value != "") {
        txtKMPL3.value = roundNumber((parseFloat(txtDifference3.value) / parseFloat(txtDieselQty3.value)), 2);
    }

    var txtDieselQty4 = document.getElementById("ctl00_MyCPH1_txtDieselQty4");
    var txtDieselRate4 = document.getElementById("ctl00_MyCPH1_txtDieselRate4");
    var txtAmount4 = document.getElementById("ctl00_MyCPH1_txtAmount4");

    var txtDifference4 = document.getElementById("ctl00_MyCPH1_txtDifference4");
    var txtKMPL4 = document.getElementById("ctl00_MyCPH1_txtKMPL4");

    if (txtDieselQty4.value != "" && txtDieselRate4.value != "") {
        txtAmount4.value = roundNumber((parseFloat(txtDieselQty4.value) * parseFloat(txtDieselRate4.value)), 2);
    }

    if (txtDifference4.value != "" && txtDieselQty4.value != "") {
        txtKMPL4.value = roundNumber((parseFloat(txtDifference4.value) / parseFloat(txtDieselQty4.value)), 2);
    }
}



function CheckFuelValidation() {


    var txtDate1 = document.getElementById("ctl00_MyCPH1_txtDate1");
    var txtPlace1 = document.getElementById("ctl00_MyCPH1_txtPlace1");
    var txtCurrentKM1 = document.getElementById("ctl00_MyCPH1_txtCurrentKM1");
    var txtLastKM1 = document.getElementById("ctl00_MyCPH1_txtLastKM1");
    var ddlVendor1 = document.getElementById("ctl00_MyCPH1_ddlVendor1");
    var txtBillNo1 = document.getElementById("ctl00_MyCPH1_txtBillNo1");
    var ddlPayment1 = document.getElementById("ctl00_MyCPH1_ddlPayment1");
    var txtRefNo1 = document.getElementById("ctl00_MyCPH1_txtRefNo1");
    var txtDieselQty1 = document.getElementById("ctl00_MyCPH1_txtDieselQty1");
    var txtDieselRate1 = document.getElementById("ctl00_MyCPH1_txtDieselRate1");
    var txtApprvdAmt1 = document.getElementById("ctl00_MyCPH1_txtApprvdAmt1");

    if (txtDate1.value == "") {
        alert("Enter Date!!!");
        txtDate1.focus();
        return false;
    }

    if (txtPlace1.value == "") {
        alert("Enter Place!!!");
        txtPlace1.focus();
        return false;
    }

    if (txtCurrentKM1.value == "") {
        alert("Enter Current KM!!!");
        txtCurrentKM1.focus();
        return false;
    }

    if (ddlVendor1.value == "0") {
        alert("Select Vendor!!!");
        ddlVendor1.focus();
        return false;
    }

    //    if (txtBillNo1.value == "") {
    //        alert("Enter Bill No.!!!");
    //        txtBillNo1.focus();
    //        return false;
    //    }

    if (ddlPayment1.value == "--Select--") {
        alert("Select Payment Mode!!!");
        ddlPayment1.focus();
        return false;
    }

    //    if (txtRefNo1.value == "") {
    //        alert("Enter Reference No.!!!");
    //        txtRefNo1.focus();
    //        return false;
    //    }

    if (txtDieselQty1.value == "") {
        alert("Enter Diesel Quantity!!!");
        txtDieselQty1.focus();
        return false;
    }

    if (txtDieselRate1.value == "") {
        alert("Enter Diesel Rate!!!");
        txtDieselRate1.focus();
        return false;
    }

    if (txtApprvdAmt1.value == "") {
        alert("Enter Approved Amount!!!");
        txtApprvdAmt1.focus();
        return false;
    }


    var txtDate2 = document.getElementById("ctl00_MyCPH1_txtDate2");
    var txtPlace2 = document.getElementById("ctl00_MyCPH1_txtPlace2");
    var txtCurrentKM2 = document.getElementById("ctl00_MyCPH1_txtCurrentKM2");
    var txtLastKM2 = document.getElementById("ctl00_MyCPH1_txtLastKM2");
    var ddlVendor2 = document.getElementById("ctl00_MyCPH1_ddlVendor2");
    var txtBillNo2 = document.getElementById("ctl00_MyCPH1_txtBillNo2");
    var ddlPayment2 = document.getElementById("ctl00_MyCPH1_ddlPayment2");
    var txtRefNo2 = document.getElementById("ctl00_MyCPH1_txtRefNo2");
    var txtDieselQty2 = document.getElementById("ctl00_MyCPH1_txtDieselQty2");
    var txtDieselRate2 = document.getElementById("ctl00_MyCPH1_txtDieselRate2");
    var txtApprvdAmt2 = document.getElementById("ctl00_MyCPH1_txtApprvdAmt2");

    if (txtLastKM2.value != "" && txtDate2.value != "" || txtLastKM2.value != "" && txtPlace2.value != "" ||
       txtLastKM2.value != "" && txtCurrentKM2.value != "" ||
       txtLastKM2.value != "" && txtBillNo2.value != "" ||
       txtLastKM2.value != "" && txtRefNo2.value != "" || txtLastKM2.value != "" && txtDieselQty2.value != "" ||
       txtLastKM2.value != "" && txtDieselRate2.value != "" || txtLastKM2.value != "" && txtDieselRate2.value != "") {

        if (txtDate2.value == "") {
            alert("Enter Date!!!");
            txtDate2.focus();
            return false;
        }

        if (txtPlace2.value == "") {
            alert("Enter Place!!!");
            txtPlace2.focus();
            return false;
        }

        if (txtCurrentKM2.value == "") {
            alert("Enter Current KM!!!");
            txtCurrentKM2.focus();
            return false;
        }

        if (ddlVendor2.value == "0") {
            alert("Select Vendor!!!");
            ddlVendor2.focus();
            return false;
        }

        //        if (txtBillNo2.value == "") {
        //            alert("Enter Bill No.!!!");
        //            txtBillNo2.focus();
        //            return false;
        //        }

        if (ddlPayment2.value == "Select") {
            alert("Select Payment Mode!!!");
            ddlPayment2.focus();
            return false;
        }

        //        if (txtRefNo2.value == "") {
        //            alert("Enter Reference No.!!!");
        //            txtRefNo2.focus();
        //            return false;
        //        }

        if (txtDieselQty2.value == "") {
            alert("Enter Diesel Quantity!!!");
            txtDieselQty2.focus();
            return false;
        }

        if (txtDieselRate2.value == "") {
            alert("Enter Diesel Rate!!!");
            txtDieselRate2.focus();
            return false;
        }

        if (txtApprvdAmt2.value == "") {
            alert("Enter Approved Amount!!!");
            txtApprvdAmt2.focus();
            return false;
        }
    }

    var txtDate3 = document.getElementById("ctl00_MyCPH1_txtDate3");
    var txtPlace3 = document.getElementById("ctl00_MyCPH1_txtPlace3");
    var txtCurrentKM3 = document.getElementById("ctl00_MyCPH1_txtCurrentKM3");
    var txtLastKM3 = document.getElementById("ctl00_MyCPH1_txtLastKM3");
    var ddlVendor3 = document.getElementById("ctl00_MyCPH1_ddlVendor3");
    var txtBillNo3 = document.getElementById("ctl00_MyCPH1_txtBillNo3");
    var ddlPayment3 = document.getElementById("ctl00_MyCPH1_ddlPayment3");
    var txtRefNo3 = document.getElementById("ctl00_MyCPH1_txtRefNo3");
    var txtDieselQty3 = document.getElementById("ctl00_MyCPH1_txtDieselQty3");
    var txtDieselRate3 = document.getElementById("ctl00_MyCPH1_txtDieselRate3");
    var txtApprvdAmt3 = document.getElementById("ctl00_MyCPH1_txtApprvdAmt3");

    if (txtLastKM3.value != "" && txtDate3.value != "" || txtLastKM3.value != "" && txtPlace3.value != "" ||
       txtLastKM3.value != "" && txtCurrentKM3.value != "" ||
       txtLastKM3.value != "" && txtBillNo3.value != "" ||
       txtLastKM3.value != "" && txtRefNo3.value != "" || txtLastKM3.value != "" && txtDieselQty3.value != "" ||
       txtLastKM3.value != "" && txtDieselRate3.value != "" || txtLastKM3.value != "" && txtDieselRate3.value != "") {

        if (txtDate3.value == "") {
            alert("Enter Date!!!");
            txtDate3.focus();
            return false;
        }

        if (txtPlace3.value == "") {
            alert("Enter Place!!!");
            txtPlace3.focus();
            return false;
        }

        if (txtCurrentKM3.value == "") {
            alert("Enter Current KM!!!");
            txtCurrentKM3.focus();
            return false;
        }

        if (ddlVendor3.value == "0") {
            alert("Select Vendor!!!");
            ddlVendor3.focus();
            return false;
        }

        //        if (txtBillNo3.value == "") {
        //            alert("Enter Bill No.!!!");
        //            txtBillNo3.focus();
        //            return false;
        //        }

        if (ddlPayment3.value == "Select") {
            alert("Select Payment Mode!!!");
            ddlPayment3.focus();
            return false;
        }

        //        if (txtRefNo3.value == "") {
        //            alert("Enter Reference No.!!!");
        //            txtRefNo3.focus();
        //            return false;
        //        }

        if (txtDieselQty3.value == "") {
            alert("Enter Diesel Quantity!!!");
            txtDieselQty3.focus();
            return false;
        }

        if (txtDieselRate3.value == "") {
            alert("Enter Diesel Rate!!!");
            txtDieselRate3.focus();
            return false;
        }

        if (txtApprvdAmt3.value == "") {
            alert("Enter Approved Amount!!!");
            txtApprvdAmt3.focus();
            return false;
        }
    }


    var txtDate4 = document.getElementById("ctl00_MyCPH1_txtDate4");
    var txtPlace4 = document.getElementById("ctl00_MyCPH1_txtPlace4");
    var txtCurrentKM4 = document.getElementById("ctl00_MyCPH1_txtCurrentKM4");
    var txtLastKM4 = document.getElementById("ctl00_MyCPH1_txtLastKM4");
    var ddlVendor4 = document.getElementById("ctl00_MyCPH1_ddlVendor4");
    var txtBillNo4 = document.getElementById("ctl00_MyCPH1_txtBillNo4");
    var ddlPayment4 = document.getElementById("ctl00_MyCPH1_ddlPayment4");
    var txtRefNo4 = document.getElementById("ctl00_MyCPH1_txtRefNo4");
    var txtDieselQty4 = document.getElementById("ctl00_MyCPH1_txtDieselQty4");
    var txtDieselRate4 = document.getElementById("ctl00_MyCPH1_txtDieselRate4");
    var txtApprvdAmt4 = document.getElementById("ctl00_MyCPH1_txtApprvdAmt4");

    if (txtLastKM4.value != "" && txtDate4.value != "" || txtLastKM4.value != "" && txtPlace4.value != "" ||
       txtLastKM4.value != "" && txtCurrentKM4.value != "" ||
       txtLastKM4.value != "" && txtBillNo4.value != "" ||
       txtLastKM4.value != "" && txtRefNo4.value != "" || txtLastKM4.value != "" && txtDieselQty4.value != "" ||
       txtLastKM4.value != "" && txtDieselRate4.value != "" || txtLastKM4.value != "" && txtDieselRate4.value != "") {


        if (txtDate4.value == "") {
            alert("Enter Date!!!");
            txtDate4.focus();
            return false;
        }

        if (txtPlace4.value == "") {
            alert("Enter Place!!!");
            txtPlace4.focus();
            return false;
        }

        if (txtCurrentKM4.value == "") {
            alert("Enter Current KM!!!");
            txtCurrentKM4.focus();
            return false;
        }

        if (ddlVendor4.value == "0") {
            alert("Select Vendor!!!");
            ddlVendor4.focus();
            return false;
        }

        //        if (txtBillNo4.value == "") {
        //            alert("Enter Bill No.!!!");
        //            txtBillNo4.focus();
        //            return false;
        //        }

        if (ddlPayment4.value == "Select") {
            alert("Select Payment Mode!!!");
            ddlPayment4.focus();
            return false;
        }

        //        if (txtRefNo4.value == "") {
        //            alert("Enter Reference No.!!!");
        //            txtRefNo4.focus();
        //            return false;
        //        }

        if (txtDieselQty4.value == "") {
            alert("Enter Diesel Quantity!!!");
            txtDieselQty4.focus();
            return false;
        }

        if (txtDieselRate4.value == "") {
            alert("Enter Diesel Rate!!!");
            txtDieselRate4.focus();
            return false;
        }

        if (txtApprvdAmt4.value == "") {
            alert("Enter Approved Amount!!!");
            txtApprvdAmt4.focus();
            return false;
        }
    }

    var ConFirmBox = confirm("Are you sure to submit data?");
    if (ConFirmBox == false) {
        return false;
    }

}

function CheckDate() {

    var txtDate1 = document.getElementById("ctl00_MyCPH1_txtDate1");

    if (txtDate1.value != "") {
        if (!isDate(txtDate1.value)) {
            alert("Please Enter Valid date ( Format :: dd/mm/yyyy ) !!!");
            txtDate1.focus();
            return false;
        }
    }

    var txtDate2 = document.getElementById("ctl00_MyCPH1_txtDate2");

    if (txtDate2.value != "") {
        if (!isDate(txtDate2.value)) {
            alert("Please Enter Valid date ( Format :: dd/mm/yyyy ) !!!");
            txtDate2.focus();
            return false;
        }
    }

    var txtDate3 = document.getElementById("ctl00_MyCPH1_txtDate3");

    if (txtDate3.value != "") {
        if (!isDate(txtDate3.value)) {
            alert("Please Enter Valid date ( Format :: dd/mm/yyyy ) !!!");
            txtDate3.focus();
            return false;
        }
    }

    var txtDate4 = document.getElementById("ctl00_MyCPH1_txtDate4");
    if (txtDate4.value != "") {
        if (!isDate(txtDate4.value)) {
            alert("Please Enter Valid date ( Format :: dd/mm/yyyy ) !!!");
            txtDate4.focus();
            return false;
        }
    }
}


function CheckContainerNo(row_Index, txtContainerNo, ddlCategory, txtInvoiceNo) {

    //alert(ddlCategory.value);


    if (ddlCategory.value == "7" && txtContainerNo.value == "" || ddlCategory.value == "8" && txtContainerNo.value == "") {
        alert("Enter Container No.!!!");
        txtContainerNo.focus();
        return false;
    }
    if (ddlCategory.value != "7" && ddlCategory.value != "8" && txtContainerNo.value != "") {
        alert("Can not Enter Container No. \r\n because you have not selected Empty or Full Container Category!!!");
        txtContainerNo.value = "";
        return true;
    }


}



function CheckDocumentNo(row_Index, txtContainerNo, ddlCategory, txtInvoiceNo) {

    //alert(ddlCategory.value);


    if (ddlCategory.value != "7" && ddlCategory.value != "9" && txtInvoiceNo.value == "") {
        alert("Enter Document No.!!!");
        txtInvoiceNo.focus();
        return false;
    }
    if (ddlCategory.value != "1" && ddlCategory.value != "2" && ddlCategory.value != "3" &&
        ddlCategory.value != "4" && ddlCategory.value != "5" && ddlCategory.value != "6" &&
        ddlCategory.value != "8" && txtInvoiceNo.value != "") {
        alert("Can not Enter Document No. \r\n because you have not selected Empty or Full Container Category!!!");
        txtInvoiceNo.value = "";
        return true;
    }

}

function CheckCity(txtFrom, lbl_THC_Err) {

    var currentTime = new Date();

    if (txtFrom.value == "" || txtFrom.value == " ") {
        lbl_THC_Err.innerText = "";
        txtFrom.style.borderColor = "";
        return;
    }
    else {
        createXMLHttpRequest();
        if (xmlHttpRequest) {
            xmlHttpRequest.onreadystatechange = function () {
                if (xmlHttpRequest.readyState == 4) {
                    var returnValue = xmlHttpRequest.responseText.split("~");
                    if (returnValue[0] == "N") {
                        lbl_THC_Err.innerText = "Enter valid city!!!";
                        txtFrom.value = "";
                        txtFrom.style.borderColor = "red";
                        txtFrom.focus();
                        return false;
                    }
                    else {
                        lbl_THC_Err.innerText = "";
                        txtFrom.style.borderColor = "";
                    }
                }
            }
            xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckValidCity&datetime=" + currentTime + "&CityName=" + txtFrom.value, false);
            xmlHttpRequest.send(null);
        }
    }
}

function CheckTHCDate(txtTHCDt) {
    var lbl_THC_Err = document.getElementById("ctl00_MyCPH1_lbl_THC_Err");
    if (txtTHCDt.value != "") {
        if (!isDate(txtTHCDt.value)) {
            txtTHCDt.style.borderColor = "red";
            lbl_THC_Err.innerText = "Please Enter Valid date ( Format :: dd/mm/yyyy ) !!!";
            txtTHCDt.focus();
            return false;
        }
        else {
            lbl_THC_Err.innerText = "";
            txtTHCDt.style.borderColor = "";
        }
    }
    else {
        //lbl_THCDate_Err.innerText = "";
        txtTHCDt.style.borderColor = "";
    }
}

function CalculateTHCAmt(txtFreightAmt, txtLabourChrg, txtOtherChrg, txtTHCTotalAmt) {
    if (txtFreightAmt.value == "") { txtFreightAmt.value = "0"; }
    if (txtLabourChrg.value == "") { txtLabourChrg.value = "0"; }
    if (txtOtherChrg.value == "") { txtOtherChrg.value = "0"; }
    txtTHCTotalAmt.value = parseFloat(txtFreightAmt.value) + parseFloat(txtLabourChrg.value) + parseFloat(txtOtherChrg.value)
    txtTHCTotalAmt.disabled = true;
}



function validtripbilling(obj) {
    //alert("HI");

    var ddlTripBIllingSelection = document.getElementById("ctl00_MyCPH1_ddlTripBIllingSelection");
    var txtCustomer = document.getElementById("ctl00_MyCPH1_txtCustomer");
    var TextBoxto_city = document.getElementById("ctl00_MyCPH1_txtToCity");
    var TextBoxfrom_city = document.getElementById("ctl00_MyCPH1_txtFromCity");
    var txtWalkinCustomerName = document.getElementById("ctl00_MyCPH1_txtWalkinCustomerName");

    if (ddlTripBIllingSelection != null || ddlTripBIllingSelection != null) {

        if (ddlTripBIllingSelection.value == "0" || ddlTripBIllingSelection.value == "") {
            alert("Select Trip Billing Type!!!");
            //ddlRouteType.focus();
            return false;
        }

        if (ddlTripBIllingSelection.value == "1" || ddlTripBIllingSelection.value == "01") {
            if (txtCustomer != null) {

                if (txtCustomer.value == "8888" && txtWalkinCustomerName.value == "") {
                    alert("Enter Walk-In Customer In!!!");
                    //ddlRouteType.focus();
                    return false;
                }
            }
        }

        if (ddlTripBIllingSelection.value == "1" || ddlTripBIllingSelection.value == "01") {
            //alert(ddlTripBIllingSelection.value);
            //alert(TextBoxfrom_city.value);
            if (TextBoxfrom_city.value == "" || TextBoxto_city.value == "") {
                alert("ENTER  From City,To City!!!");
                //ddlRouteType.focus();
                return false;
            }

            if (TextBoxfrom_city.value == "" || TextBoxto_city.value == "") {
                alert("ENTER  From City,To City!!!");
                //ddlRouteType.focus();
                return false;
            }
        }
    }

    if (txtCustomer != null) {
        if (txtCustomer.value == "") {
            alert("Enter Customer!!!");
            //ddlRouteType.focus();
            return false;
        }
    }
}


function CheckValidCity(txtFromCity, lbl_FromCity_Err) {
    // alert("HI");
    if (txtFromCity.value == "") {
        txtFromCity.value = "";
        lbl_FromCity_Err.innerText = "";
        return;
    }
    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    lbl_FromCity_Err.innerText = "Invalid City. !!! Please check.";
                    txtFromCity.focus();
                    return false;
                }
                else {
                    txtFromCity.value = txtFromCity.value.substr(0, 1).toUpperCase() + txtFromCity.value.substr(1);
                    lbl_FromCity_Err.innerText = "";
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckValidCity&datetime=" + currentTime + "&CityName=" + txtFromCity.value, false);
        xmlHttpRequest.send(null);
    }
}

function nwOpenCity(strval) {
    if (strval == "1") {
        window.open("popup-city1.aspx?city_mode=1", "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
    }
    else {
        window.open("popup-city1.aspx?city_mode=2", "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
    }
}




function CheckLogEntrytxtChallanDate(txtChallanDate) {

    var currentTime = new Date();
    var txtChallanDate = document.getElementById("ctl00_MyCPH1_txtChallanDate");
    var pnlEXTERNALTHCDetailsError = document.getElementById("ctl00_MyCPH1_pnlEXTERNALTHCDetailsError");
    var lblError = document.getElementById("ctl00_MyCPH1_lblError");

    var cDate = "";


    if (txtChallanDate.value != "") {
        if (!isDate(txtChallanDate.value)) {
            txtChallanDate.style.borderColor = "red";
            pnlEXTERNALTHCDetailsError.innerText = "Please Enter Valid date ( Format :: dd/mm/yyyy ) !!!";
            txtChallanDate.focus();
            return false;
        }
        else {
            txtChallanDate.style.borderColor = "";
            pnlEXTERNALTHCDetailsError.innerText = "";
        }


    }

}



function CheckLogEntryTexLoadingDate(TexLoadingDate) {

    var currentTime = new Date();
    var TexLoadingDate = document.getElementById("ctl00_MyCPH1_TexLoadingDate");
    var pnlEXTERNALTHCDetailsError = document.getElementById("ctl00_MyCPH1_pnlEXTERNALTHCDetailsError");
    var lblError = document.getElementById("ctl00_MyCPH1_lblError");

    var cDate = "";



    if (TexLoadingDate.value != "") {
        if (!isDate(TexLoadingDate.value)) {
            TexLoadingDate.style.borderColor = "red";
            pnlEXTERNALTHCDetailsError.innerText = "Please Enter Valid date ( Format :: dd/mm/yyyy ) !!!";
            TexLoadingDate.focus();
            return false;
        }
        else {
            TexLoadingDate.style.borderColor = "";
            pnlEXTERNALTHCDetailsError.innerText = "";
        }
    }
}



function CheckFromValidCityN(txtFrom, hdnFromCity) {
    var currentTime = new Date()
    var str_Index = "";

    if (txtFrom.value == "") {
        return true;
    }





    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    alert("Invalid City. !!! Please check.");
                    txtFrom.focus();
                    return false;
                }
                else {

                    hdnFromCity.value = returnValue[1];

                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckValidCityCode&datetime=" + currentTime + "&CityName=" + txtFrom.value, false);
        xmlHttpRequest.send(null);
    }
}



function CheckToValidCityN(txtTo, hdnToCity) {
    var currentTime = new Date()
    var str_Index = "";

    if (txtTo.value == "") {
        return true;
    }




    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    alert("Invalid City. !!! Please check.");
                    txtTo.focus();
                    return false;
                }
                else {
                    hdnToCity.value = returnValue[1];
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckValidCityCode&datetime=" + currentTime + "&CityName=" + txtTo.value, false);
        xmlHttpRequest.send(null);
    }
}

function CheckFromValidCityNE(txtFrom, hdnFromCityNE) {
    var currentTime = new Date()
    var str_Index = "";

    if (txtFrom.value == "") {
        return true;
    }


    var hdnFromCityNE = document.getElementById("ctl00_MyCPH1_hdnFromCityNE");


    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    alert("Invalid City. !!! Please check.");
                    txtFrom.focus();
                    return false;
                }
                else {

                    hdnFromCityNE.value = returnValue[1];

                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckValidCityCode&datetime=" + currentTime + "&CityName=" + txtFrom.value, false);
        xmlHttpRequest.send(null);
    }
}



function CheckToValidCityNE(txtTo, hdntoCityNE) {
    var currentTime = new Date()
    var str_Index = "";

    if (txtTo.value == "") {
        return true;
    }

    var hdntoCityNE = document.getElementById("ctl00_MyCPH1_hdntoCityNE");


    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    alert("Invalid City. !!! Please check.");
                    txtTo.focus();
                    return false;
                }
                else {
                    hdntoCityNE.value = returnValue[1];
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckValidCityCode&datetime=" + currentTime + "&CityName=" + txtTo.value, false);
        xmlHttpRequest.send(null);
    }
}




function GetVehicleDetails(TextBoxVehicleNo) {
    var currentTime = new Date();
    var TextBoxVehicleNo = document.getElementById("ctl00_MyCPH1_TextBoxVehicleNo");
    if (TextBoxVehicleNo.value == "") {
        TextBoxVehicleNo.value = "";
        return
    }
    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    alert("Invalid Vehicle No.")
                    TextBoxVehicleNo.value = "";
                    TextBoxVehicleNo.focus();
                    return
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=FillVehicleDetails&datetime=" + currentTime + "&Vehno=" + TextBoxVehicleNo.value, false);
        xmlHttpRequest.send(null);
    }
}



function GetBalanceAmountDetails(TextBoxBalanceAmount) {
    var currentTime = new Date();
    var TextBoxBalanceAmount = document.getElementById("ctl00_MyCPH1_TextBoxBalanceAmount");
    var TextBoxAdvanceAmount = document.getElementById("ctl00_MyCPH1_TextBoxAdvanceAmount");
    var TextBoxContractAmount = document.getElementById("ctl00_MyCPH1_TextBoxContractAmount");
    if (TextBoxBalanceAmount.value == "") {
        TextBoxBalanceAmount.value = "0";
    }
    if (TextBoxAdvanceAmount.value == "") {
        TextBoxAdvanceAmount.value = "0";
    }
    if (TextBoxContractAmount.value == "") {
        TextBoxContractAmount.value = "0";
    }
    //    alert(TextBoxContractAmount.value);
    //    alert(TextBoxAdvanceAmount.value);
    //    alert(TextBoxBalanceAmount.value);
    TextBoxBalanceAmount.value = TextBoxContractAmount.value - TextBoxAdvanceAmount.value;

}



function CheckFromValidCityNEM(txtFrom, hdnFromCityNEM) {
    var currentTime = new Date()
    var str_Index = "";
    // alert("Hi");
    if (txtFrom.value == "") {
        return true;
    }
    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    alert("Invalid City. !!! Please check.");
                    txtFrom.focus();
                    return false;
                }
                else {

                    // alert(returnValue[1]);
                    hdnFromCityNEM.value = returnValue[1];

                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckValidCityCode&datetime=" + currentTime + "&CityName=" + txtFrom.value, false);
        xmlHttpRequest.send(null);
    }
}



function CheckToValidCityNEM(txtTo, hdntoCityNEM) {
    var currentTime = new Date()
    var str_Index = "";
    // alert("Hi");
    if (txtTo.value == "") {
        return true;
    }
    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    alert("Invalid City. !!! Please check.");
                    txtTo.focus();
                    return false;
                }
                else {
                    //alert(returnValue[1]);
                    hdntoCityNEM.value = returnValue[1];
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckValidCityCode&datetime=" + currentTime + "&CityName=" + txtTo.value, false);
        xmlHttpRequest.send(null);
    }
}

function GetBalanceAmountDetailBalanceChangeM(TextBoxAmount) {

    var gvVehicleLogEntry = document.getElementById("ctl00_MyCPH1_gvVehicleLogEntry");
    if (gvVehicleLogEntry != null) {
        //alert("1");
        if (gvVehicleLogEntry.rows.length != 0) {
            for (i = 0; i < gvVehicleLogEntry.rows.length - 1; i++) {
                j = i + 3;
                var pref = "";
                if (j < 10) {
                    pref = "ctl00_MyCPH1_gvVehicleLogEntry_ctl0" + j + "_";
                }
                else {
                    pref = "ctl00_MyCPH1_gvVehicleLogEntry_ctl" + j + "_";
                }
                var TextBoxBalanceAmountM = document.getElementById(pref + "TextBoxBalanceAmountM");
                var TextBoxAdvanceAmountM = document.getElementById(pref + "TextBoxAdvanceAmountM");
                var TextBoxContractAmountM = document.getElementById(pref + "TextBoxContractAmountM");
                if (TextBoxAmount.id == (pref + "TextBoxBalanceAmountM")) {

                    if (TextBoxBalanceAmountM.value == "") {
                        TextBoxBalanceAmountM.value = "0";
                    }
                    if (TextBoxAdvanceAmountM.value == "") {
                        TextBoxAdvanceAmountM.value = "0";
                    }
                    if (TextBoxContractAmountM.value == "") {
                        TextBoxContractAmountM.value = "0";
                    }
                    TextBoxBalanceAmountM.value = TextBoxContractAmountM.value - TextBoxAdvanceAmountM.value;
                }


            }
        }
    }

}

function GetBalanceAmountDetailContractChangeM(TextBoxAmount) {

    var gvVehicleLogEntry = document.getElementById("ctl00_MyCPH1_gvVehicleLogEntry");
    if (gvVehicleLogEntry != null) {
        //alert("1");
        if (gvVehicleLogEntry.rows.length != 0) {
            for (i = 0; i < gvVehicleLogEntry.rows.length - 1; i++) {
                j = i + 3;
                var pref = "";
                if (j < 10) {
                    pref = "ctl00_MyCPH1_gvVehicleLogEntry_ctl0" + j + "_";
                }
                else {
                    pref = "ctl00_MyCPH1_gvVehicleLogEntry_ctl" + j + "_";
                }
                var TextBoxBalanceAmountM = document.getElementById(pref + "TextBoxBalanceAmountM");
                var TextBoxAdvanceAmountM = document.getElementById(pref + "TextBoxAdvanceAmountM");
                var TextBoxContractAmountM = document.getElementById(pref + "TextBoxContractAmountM");
                if (TextBoxAmount.id == (pref + "TextBoxContractAmountM")) {

                    if (TextBoxBalanceAmountM.value == "") {
                        TextBoxBalanceAmountM.value = "0";
                    }
                    if (TextBoxAdvanceAmountM.value == "") {
                        TextBoxAdvanceAmountM.value = "0";
                    }
                    if (TextBoxContractAmountM.value == "") {
                        TextBoxContractAmountM.value = "0";
                    }
                    TextBoxBalanceAmountM.value = TextBoxContractAmountM.value - TextBoxAdvanceAmountM.value;
                }
                

            }
        }
    }

}
function GetBalanceAmountDetailsAdvanceChangeM(TextBoxAmount) {
    
    var gvVehicleLogEntry = document.getElementById("ctl00_MyCPH1_gvVehicleLogEntry");
    if (gvVehicleLogEntry != null) {
        //alert("1");
        if (gvVehicleLogEntry.rows.length != 0) {
            for (i = 0; i < gvVehicleLogEntry.rows.length - 1; i++) {
                j = i + 3;
                var pref = "";
                if (j < 10) {
                    pref = "ctl00_MyCPH1_gvVehicleLogEntry_ctl0" + j + "_";
                }
                else {
                    pref = "ctl00_MyCPH1_gvVehicleLogEntry_ctl" + j + "_";
                }
                var TextBoxBalanceAmountM = document.getElementById(pref + "TextBoxBalanceAmountM");
                var TextBoxAdvanceAmountM = document.getElementById(pref + "TextBoxAdvanceAmountM");
                var TextBoxContractAmountM = document.getElementById(pref + "TextBoxContractAmountM");
                if (TextBoxAmount.id == (pref + "TextBoxAdvanceAmountM")) {

                    if (TextBoxBalanceAmountM.value == "") {
                        TextBoxBalanceAmountM.value = "0";
                    }
                    if (TextBoxAdvanceAmountM.value == "") {
                        TextBoxAdvanceAmountM.value = "0";
                    }
                    if (TextBoxContractAmountM.value == "") {
                        TextBoxContractAmountM.value = "0";
                    }
                    TextBoxBalanceAmountM.value = TextBoxContractAmountM.value - TextBoxAdvanceAmountM.value;
                }


            }
        }
    }

}
function CheckLogEntrytxtChallanDateM(txtChallanDateM) {
    var CurrentDate = "";
    var currentTime = new Date();
    var lbl_VehicleLog_Err = document.getElementById("ctl00_MyCPH1_lbl_VehicleLog_Err");
    var lblError = document.getElementById("ctl00_MyCPH1_lblError");
    var gvVehicleLogEntry = document.getElementById("ctl00_MyCPH1_gvVehicleLogEntry");
    var cDate = "";
    if (gvVehicleLogEntry != null) {
        //alert("CheckLogEntrytxtChallanDateM");
        if (gvVehicleLogEntry.rows.length != 0) {
            for (i = 0; i < gvVehicleLogEntry.rows.length - 1; i++) {
                j = i + 3;
                var pref = "";
                if (j < 10) {
                    pref = "ctl00_MyCPH1_gvVehicleLogEntry_ctl0" + j + "_";
                }
                else {
                    pref = "ctl00_MyCPH1_gvVehicleLogEntry_ctl" + j + "_";
                }
                var txtChallanDateM = document.getElementById(pref + "txtChallanDateM");
                if (txtChallanDateM == undefined) {
                    return false;
                }
                if (txtChallanDateM.value != "") {
                    if (!isDate(txtChallanDateM.value)) {
                        txtChallanDateM.style.borderColor = "red";
                        lbl_VehicleLog_Err.innerText = "Please Enter Valid date ( Format :: dd/mm/yyyy ) !!!";
                        txtChallanDateM.focus();
                        return false;
                    }
                    else {
                        txtChallanDateM.style.borderColor = "";
                        lbl_VehicleLog_Err.innerText = "";
                    }
                    //Added by Sandeep Maurya to validate  date which is not future date related to error RIT_005630
                    if (!IsCompareDateTense(txtChallanDateM.value, CurrentDate, 'PastNPresent')) {
                        txtChallanDateM.style.borderColor = "red";
                        lbl_VehicleLog_Err.innerText = "Challan Date Should Be Less Than Or Equals To Current Date!!!";
                        txtChallanDateM.focus();
                        return false;
                    }
                    else {
                        txtChallanDateM.style.borderColor = "";
                        lbl_VehicleLog_Err.innerText = "";
                    }
                    //end
                }
                else {
                    txtChallanDateM.style.borderColor = "";
                    lbl_VehicleLog_Err.innerText = "";
                }
            }

        }
    }
}

function CheckLogEntryTexLoadingDateM(TexLoadingDateM) {

    var currentTime = new Date();
    //r TexLoadingDate = document.getElementById("ctl00_MyCPH1_TexLoadingDate");
    var lbl_VehicleLog_Err = document.getElementById("ctl00_MyCPH1_lbl_VehicleLog_Err");
    var lblError = document.getElementById("ctl00_MyCPH1_lblError");
    var gvVehicleLogEntry = document.getElementById("ctl00_MyCPH1_gvVehicleLogEntry");
    var cDate = "";
    if (gvVehicleLogEntry != null) {
        // alert("1");
        if (gvVehicleLogEntry.rows.length != 0) {
            for (i = 0; i < gvVehicleLogEntry.rows.length - 1; i++) {
                j = i + 3;
                var pref = "";
                if (j < 10) {
                    pref = "ctl00_MyCPH1_gvVehicleLogEntry_ctl0" + j + "_";
                }
                else {
                    pref = "ctl00_MyCPH1_gvVehicleLogEntry_ctl" + j + "_";
                }

                var TexLoadingDateM = document.getElementById(pref + "TexLoadingDateM");
                if (TexLoadingDateM == undefined) {
                    return false;
                }
                if (TexLoadingDateM.value != "") {
                    if (!isDate(TexLoadingDateM.value)) {
                        TexLoadingDateM.style.borderColor = "red";
                        lbl_VehicleLog_Err.innerText = "Please Enter Valid date ( Format :: dd/mm/yyyy ) !!!";
                        TexLoadingDateM.focus();
                        return false;
                    }
                    else {
                        TexLoadingDateM.style.borderColor = "";
                        lbl_VehicleLog_Err.innerText = "";
                    }
                }


            }
        }
    }
}
function CheckValidationETMULTI() {
    
    var gvVehicleLogEntry = document.getElementById("ctl00_MyCPH1_gvVehicleLogEntry");


    if (gvVehicleLogEntry != null) {
        //alert("1");
        if (gvVehicleLogEntry.rows.length != 0) {
            for (i = 0; i < gvVehicleLogEntry.rows.length - 1; i++) {
                j = i + 3;
                var pref = "";
                if (j < 10) {
                    pref = "ctl00_MyCPH1_gvVehicleLogEntry_ctl0" + j + "_";
                }
                else {
                    pref = "ctl00_MyCPH1_gvVehicleLogEntry_ctl" + j + "_";
                }
                var LabelSystemGeneratedM = document.getElementById(pref + "LabelSystemGeneratedM");
                var LabelExternalTHCNoM = document.getElementById(pref + "LabelExternalTHCNoM");
                var TextBoxUserIdM = document.getElementById(pref + "TextBoxUserIdM");
                var TextBoxVehicleNoM = document.getElementById(pref + "TextBoxVehicleNoM");
                var TextBoxTripsheetNoM = document.getElementById(pref + "TextBoxTripsheetNoM");
                var TextBoxCustomerTypeM = document.getElementById(pref + "TextBoxCustomerTypeM");
                var TextBoxTransporterNameM = document.getElementById(pref + "TextBoxTransporterNameM");
                var TextBoxFromCityM = document.getElementById(pref + "TextBoxFromCityM");
                var TextBoxToCityM = document.getElementById(pref + "TextBoxToCityM");
                var TextBoxTransporterChallanNoM = document.getElementById(pref + "TextBoxTransporterChallanNoM");
                var txtChallanDateM = document.getElementById(pref + "txtChallanDateM");
                var TexLoadingDateM = document.getElementById(pref + "TexLoadingDateM");
                var TextBoxContactNoM = document.getElementById(pref + "TextBoxContactNoM");
                var TextBoxBrokerNameM = document.getElementById(pref + "TextBoxBrokerNameM");
                var TextBoxMobileNoM = document.getElementById(pref + "TextBoxMobileNoM");
                var TextBoxWeightM = document.getElementById(pref + "TextBoxWeightM");
                var TextBoxNugM = document.getElementById(pref + "TextBoxNugM");
                var TextBoxCommodityM = document.getElementById(pref + "TextBoxCommodityM");
                var TextBoxContractAmountM = document.getElementById(pref + "TextBoxContractAmountM");
                var TextBoxAdvanceAmountM = document.getElementById(pref + "TextBoxAdvanceAmountM");
                var TextBoxBalanceAmountM = document.getElementById(pref + "TextBoxBalanceAmountM");
                var TextBoxAdvanceAmountByOther = document.getElementById(pref + "TextBoxAdvanceAmountByOther");
                var TextBoxAdvanceAmountByDeduction = document.getElementById(pref + "TextBoxAdvanceAmountByDeduction");
                var TextBoxAdvanceRemarks = document.getElementById(pref + "TextBoxAdvanceRemarks");
                var TextBoxAdvanceAmountTDS = document.getElementById(pref + "TextBoxAdvanceAmountTDS");
                var TextBoxRemarksM = document.getElementById(pref + "TextBoxRemarksM");
                var TextBoxBalancePaymentM = document.getElementById(pref + "TextBoxBalancePaymentM");

                var ddlCustomerType = document.getElementById(pref + "ddlCustomerType");
               // var ddlAdvanceTakenBy = document.getElementById(pref + "ddlAdvanceTakenBy");
                var TextBoxAdvanceAmountByDriverM = document.getElementById(pref + "TextBoxAdvanceAmountByDriverM");
                var TextBoxAdvanceAmountByBranchM = document.getElementById(pref + "TextBoxAdvanceAmountByBranchM");
                if (LabelExternalTHCNoM.innerHTML != "") {
                    continue;
                }
                if (TextBoxCustomerTypeM.value == "") {
                    alert("Enter Customer Type!!!")
                    TextBoxCustomerTypeM.focus();
                    
                    return false;
                }
                //if (TextBoxTransporterNameM.value == "") {
                //    alert("Enter Transporter Name !!!");
                //    TextBoxTransporterNameM.focus();
                //    
                //    return false;
                //}
                if (TextBoxFromCityM.value == "") {
                    alert("Enter From City!!!");
                    TextBoxFromCityM.focus();
                    return false;
                }
                if (TextBoxToCityM.value == "") {
                    alert("Enter To City");
                    TextBoxToCityM.focus();
                    
                    return false;
                }

                if (TextBoxTransporterChallanNoM.value == "") {
                    alert("Enter Transporter Challan No");
                    TextBoxTransporterChallanNoM.focus();
                    
                    return false;
                }

                if (txtChallanDateM.value == "") {
                    alert("Enter Challan Date");
                    txtChallanDateM.focus();
                    
                    return false;
                }

                if (TexLoadingDateM.value == "") {
                    alert("Enter Loading Date");
                    TexLoadingDateM.focus();
                    
                    return false;
                }

                if (TextBoxContactNoM.value == "") {
                    alert("Enter Contact No");
                    TextBoxContactNoM.focus();
                  
                    return false;
                }

                if (TextBoxBrokerNameM.value == "") {
                    alert("Enter Broker Name");
                    TextBoxBrokerNameM.focus();
                    
                    return false;
                }

                if (TextBoxMobileNoM.value == "") {
                    alert("Enter Mobile No");
                    TextBoxMobileNoM.focus();
                    
                    return false;
                }

                if (TextBoxWeightM.value == "") {
                    alert("Enter Weight");
                    TextBoxWeightM.focus();
                    
                    return false;
                }
                if (TextBoxNugM.value == "") {
                    alert("Enter Nug");
                    TextBoxNugM.focus();
                    
                    return false;
                }
                if (TextBoxCommodityM.value == "") {
                    alert("Enter Commodity");
                    TextBoxCommodityM.focus();
                    
                    return false;
                }
                if (TextBoxContractAmountM.value == "") {
                    alert("Enter Contract Amount");
                    TextBoxContractAmountM.focus();
                    
                    return false;
                }

                if (TextBoxAdvanceAmountM.value == "") {
                    alert("Enter Advance Amount");
                    TextBoxAdvanceAmountM.focus();
                    
                    return false;
                }
              /*  if (ddlAdvanceTakenBy.value == "0") {
                    alert("Select advance taken by!!!");
                    ddlAdvanceTakenBy.focus();
                    return false;
                }

                if (ddlAdvanceTakenBy.value == "1")
                {

                    if (TextBoxAdvanceAmountM.value == "") {
                        TextBoxAdvanceAmountM.value = "0";
                    }
                    if (TextBoxAdvanceAmountByDriverM.value == "") {
                        TextBoxAdvanceAmountByDriverM.value = "0";
                    }
                    //alert(TextBoxAdvanceAmountByDriverM.value);
                    // alert(TextBoxAdvanceAmountM.value);
                    if (parseFloat(TextBoxAdvanceAmountByDriverM.value) != parseFloat(TextBoxAdvanceAmountM.value))
                    {
                        alert("Total advance amount not matching with advance taken by driver amount");
                        TextBoxAdvanceAmountByDriverM.focus();
                        return false;
                    }
                }

                if (ddlAdvanceTakenBy.value == "2") {
                    if (TextBoxAdvanceAmountM.value == "") {
                        TextBoxAdvanceAmountM.value = "0";
                    }
                    if (TextBoxAdvanceAmountByBranchM.value == "") {
                        TextBoxAdvanceAmountByBranchM.value = "0";
                    }
                    if (parseFloat(TextBoxAdvanceAmountByBranchM.value) != parseFloat(TextBoxAdvanceAmountM.value)) {
                        alert("Total advance amount not matching with advance taken by branch amount");
                        TextBoxAdvanceAmountByBranchM.focus();
                        return false;
                    }
                }

                if (ddlAdvanceTakenBy.value == "3") {
                    */
                    if (TextBoxAdvanceAmountM.value == "") {
                        TextBoxAdvanceAmountM.value = "0";
                    }
                    if (TextBoxAdvanceAmountByDriverM.value == "") {
                        TextBoxAdvanceAmountByDriverM.value = "0";
                    }
                    if (TextBoxAdvanceAmountByBranchM.value == "") {
                        TextBoxAdvanceAmountByBranchM.value = "0";
                    }
                    if (TextBoxAdvanceAmountByOther.value == "") {
                        TextBoxAdvanceAmountByOther.value = "0";
                    }
                    if (TextBoxAdvanceAmountByDeduction.value == "") {
                        TextBoxAdvanceAmountByDeduction.value = "0";
                    }
                    if (TextBoxAdvanceAmountTDS.value == "") {
                        TextBoxAdvanceAmountTDS.value = "0";
                    }
                    
                    
                    
                    //alert(parseFloat((parseFloat(TextBoxAdvanceAmountByDriverM.value) + parseFloat(TextBoxAdvanceAmountByBranchM.value))));
                    //alert(parseFloat(TextBoxAdvanceAmountM.value));
                    
                    if (parseFloat((parseFloat(TextBoxAdvanceAmountByDriverM.value) + parseFloat(TextBoxAdvanceAmountByBranchM.value) + parseFloat(TextBoxAdvanceAmountByOther.value) + parseFloat(TextBoxAdvanceAmountByDeduction.value) + parseFloat(TextBoxAdvanceAmountTDS.value))) != parseFloat(TextBoxAdvanceAmountM.value)) {
                        alert("Total advance amount does not matching with advance taken by driver amount/branch amount/other amount/deduction amount,");
                        TextBoxAdvanceAmountByDriverM.focus();
                        return false;
                    }
                //}
                    if (TextBoxAdvanceRemarks.value == "") {
                        alert("Enter Advance Taken Remarks.!");
                        TextBoxAdvanceRemarks.focus();
                        
                        return false;
                    }

                if (TextBoxRemarksM.value == "") {
                    alert("Enter Remarks");
                    TextBoxRemarksM.focus();
                    
                    return false;
                }
                if (TextBoxBalancePaymentM.value == "") {
                    alert("Enter Balance Payment location.!");
                    TextBoxBalancePaymentM.focus();
                    return false;
                }

                var msg = "Please check:\n";
                msg = msg + "Contract Amount: " + TextBoxContractAmountM.value + "\n";
                msg = msg + "Advance Amount: " + TextBoxAdvanceAmountM.value + "\n";
				msg = msg + "Driver Amount: " + TextBoxAdvanceAmountByDriverM.value + "\n";
                msg = msg + "Branch Amount: " + TextBoxAdvanceAmountByBranchM.value + "\n";
                msg = msg + "Other Amount: " + TextBoxAdvanceAmountByOther.value + "\n";
                msg = msg + "Deduction: " + TextBoxAdvanceAmountByDeduction.value + "\n";
                msg = msg + "TDS : " + TextBoxAdvanceAmountTDS.value + "\n";
                msg = msg + "Balance Amonut: " + TextBoxBalanceAmountM.value + "\n";
                msg = msg + "Are you sure you want to submit.?";

                if (!confirm(msg)) {

                    return false;
                } else {
                    break;
                }
            }
        }
    }
    //var ConFirmBox = confirm("Are you sure to submit data?");
    //if (ConFirmBox == false) {
    //    return false;
    //}
}


function GettxtCustomerwalkin(txtCustomer) {
    /*var txtCustomer = document.getElementById("ctl00_MyCPH1_txtCustomer");
    var TableRowWalkincust = document.getElementById("ctl00_MyCPH1_TableRowWalkincust");
   
    if (txtCustomer.value == "8888") {
    TableRowWalkincust.style.display = "block";
    }
    else {
    TableRowWalkincust.style.display = "none";
    }
    txtCustomer.focus();*/
}



function CheckValidCustomer(customer) {
    //alert("in");
    var currentTime = new Date()
    var str_Index = "";
    if (customer.value == "") {
        return true;
    }
    var TableRowWalkincust = document.getElementById("ctl00_MyCPH1_TableRowWalkincust");
    var myArr = new Array();
    var myString = new String();
    myString = customer.value;
    myArr = myString.split("~");

    var txtCustomerName = document.getElementById("ctl00_MyCPH1_txtCustomerName");
    txtCustomer = document.getElementById("ctl00_MyCPH1_txtCustomer");
    //txtCustomerName.value = "";
    if (myArr.length == 2) {
        customer.value = myArr[0].trim();
        txtCustomerName.value = myArr[1].trim();
    }

    if (txtCustomerName.value == "") {
        alert("Select Customer from Smart search box properly !!!")
        return false;
    }

    //    alert(" myArr.length : " + myArr.length);
    //    for (var i = 0; i < myArr.length; i++) {
    //        txtCustomerName.value = myArr[1].trim();
    //    }


    //alert("customer : " + customer.value);
    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    alert("Invalid Customer !!! Please check.");
                    customer.focus();
                    txtCustomerName.value = "";
                    return false;
                }
                else {
                    if (customer.value == "8888") {
                        TableRowWalkincust.style.display = "block";
                    }
                    else {
                        TableRowWalkincust.style.display = "none";
                    }
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckCustomerCode&datetime=" + currentTime + "&CustCode=" + customer.value, false);
        xmlHttpRequest.send(null);
    }
}