// JScript File
var currentTime = new Date()
function SelectAllDocket(chk, chklist) {
    var checkBoxList = chklist;
    if (chk.checked == true) {
        if (checkBoxList != null) {
            var options = checkBoxList.getElementsByTagName('input');
            var arrayOfCheckBoxLabels = checkBoxList.getElementsByTagName("label");
            for (i = 0; i < options.length; i++) {
                var opt = options[i];
                opt.checked = true;
            }
        }
    }
    else {
        if (checkBoxList != null) {
            var options = checkBoxList.getElementsByTagName('input');
            var arrayOfCheckBoxLabels = checkBoxList.getElementsByTagName("label");
            for (i = 0; i < options.length; i++) {
                var opt = options[i];
                opt.checked = false;
            }
        }
    }
}
function CheckStartKM(txtStartKM, hdStatKm, a) {
    alert(a)
    if (txtStartKM.value == "") return;
    if (hdStatKm.value == "") {
        hdStatKm.value = "0";
    }
    if (a == "Y") {
        if (parseFloat(txtStartKM.value) > (parseFloat(hdStatKm.value) + 500)) {
            alert("Start KM must be changed up to current km + 500 km !!!  ");
            txtStartKM.focus();
            return false;
        }
    }
    else {
        if (parseFloat(txtStartKM.value) < (parseFloat(hdStatKm.value))) {
            alert("Start KM must be greater than previous trip close vehicle for the same vehicle !!!");
            txtStartKM.focus();
            return false;
        }
    }
}
function ChangeExternalUsages() {
    var ddl_ExternalUsages_Category = document.getElementById("ctl00_MyCPH1_ddl_ExternalUsages_Category");
    var row_Docket_btn = document.getElementById("ctl00_MyCPH1_row_Docket_btn");

    var chklstDockets = document.getElementById("ctl00_MyCPH1_chklstDockets");
    var row_Docket_hdr = document.getElementById("ctl00_MyCPH1_row_Docket_hdr");
    var row_Dockets = document.getElementById("ctl00_MyCPH1_row_Dockets");

    var chkSelAllDocket = document.getElementById("ctl00_MyCPH1_chkSelAllDocket");

    if (ddl_ExternalUsages_Category.value == "02") {
        row_Docket_btn.style["display"] = "block";
        //        row_Docket_hdr.style["display"] = "block"; 
        //        row_Dockets.style["display"] = "block"; 
    }
    else if (ddl_ExternalUsages_Category.value == "01") {
        row_Docket_btn.style["display"] = "none";
        if (chklstDockets != null) {
            var options = chklstDockets.getElementsByTagName('input');
            var arrayOfCheckBoxLabels = chklstDockets.getElementsByTagName("label");
            for (i = 0; i < options.length; i++) {
                var opt = options[i];
                opt.checked = false;
            }
        }
        if (chkSelAllDocket.checked == true) {
            chkSelAllDocket.checked = false;
        }
        row_Docket_hdr.style["display"] = "none";
        row_Dockets.style["display"] = "none";
    }
}


////CHECK CUSTOMER CODE
function CheckCustomerCode(txtCustCode, lblErrorLocation1) {
    var str_Index = "";
    if (txtCustCode.value == "") {
        txtCustCode.value = "";
        lblErrorLocation1.innerText = "";
        return;
    }
    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    lblErrorLocation1.innerText = "Invalid Customer Code!!!";
                    txtCustCode.focus();
                    return false;
                }
                else {
                    txtCustCode.value = txtCustCode.value;
                    lblErrorLocation1.innerText = "";
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckCustomerCode&datetime=" + currentTime + "&CustCode=" + txtCustCode.value, false);
        xmlHttpRequest.send(null);
    }
}
////CHECK VEHICLE NUMBER
function CheckVehicleNumber(txtVehNo, lblVehCheck, txtStartKM) {
    var str_Index = "";
    if (txtVehNo.value == "") {
        txtVehNo.value = "";
        lblVehCheck.innerText = "";
        return;
    }
    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    lblVehCheck.innerText = "Invalid Vehicle Number!!!";
                    txtVehNo.focus();
                    return false;
                }
                else {
                    txtVehNo.value = txtVehNo.value;
                    txtStartKM.value = returnValue[1];
                    lblVehCheck.innerText = "";
                    CheckVehicleNumber1(txtVehNo, lblVehCheck);
                    if (returnValue[1] != "") {
                        txtStartKM.disabled = true;
                    }
                    else {
                        txtStartKM.disabled = false;
                    }
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckVehicleNumber&datetime=" + currentTime + "&VehicleNo=" + txtVehNo.value, false);
        xmlHttpRequest.send(null);
    }
}

function CheckVehicleNumber1(txtVehNo, lblVehCheck) {
    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "Y") {
                    lblVehCheck.innerText = "Tripsheet attached in this vehicle is not operationally closed !!!";
                    txtVehNo.focus();
                    return false;
                }
                else {
                    lblVehCheck.innerText = "";
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckVehicleNumber1&datetime=" + currentTime + "&VehicleNo=" + txtVehNo.value, false);
        xmlHttpRequest.send(null);
    }
}

function ChekcFinancialYear() {
    var FinYear = document.getElementById("ctl00_MyCPH1_hfFinancialYr");
    var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");
    var txtDate = document.getElementById("ctl00_MyCPH1_txtDate");
    var lblError = document.getElementById("ctl00_MyCPH1_lblError");

    if (txtDate.value != "") {
        if (!isDate(txtDate.value)) {
            lblError.innerText = "Invalid Date";
            txtDate.focus();
            return false;
        }
    }
    else {
        txtDate.value = hfTodayDate.value;
        lblError.innerText = "";
    }

    var FinYear_to = parseInt(FinYear.value) + 1;

    if (FinYear_to < 10) {
        FinYear_to = "0" + FinYear_to;
    }
    var FinYear_fromdate = "01/04/" + FinYear.value;
    var FinYear_todate = "31/03/" + FinYear_to;
    var Sle_finyear = FinYear.value + "-" + FinYear_to;

    var a = txtDate.value.split("/");
    var b = FinYear_fromdate.split("/");
    var c = FinYear_todate.split("/");

    txtDate.value = a[1] + "/" + a[0] + "/" + a[2];
    FinYear_fromdate = b[1] + "/" + b[0] + "/" + b[2];
    FinYear_todate = c[1] + "/" + c[0] + "/" + c[2];

    //alert ( txtDate.value +">="+ FinYear_fromdate+ " && " + txtDate.value + " <= " + FinYear_todate)

    if (Date.parse(txtDate.value) >= Date.parse(FinYear_fromdate) && Date.parse(txtDate.value) <= Date.parse(FinYear_todate)) {
        lblError.innerText = "";
        txtDate.value = a[0] + "/" + a[1] + "/" + a[2];
        //CheckAdvDt();
        //        if(!)
        //        {
        //            return false;
        //        }
        //        else
        //        {
        //            return true;
        //        }

    }
    else {
        txtDate.value = a[0] + "/" + a[1] + "/" + a[2];
        lblError.innerText = "Issue date  should be  in the  range of selected  financial year!";
        txtDate.focus();
        return false;
    }
}

function createXMLHttpRequest() {
    // Mozilla, Safari,...
    if (window.XMLHttpRequest) { xmlHttpRequest = new XMLHttpRequest(); if (xmlHttpRequest.overrideMimeType) xmlHttpRequest.overrideMimeType("text/xml"); }
        // IE
    else if (window.ActiveXObject) { try { xmlHttpRequest = new ActiveXObject("Msxml2.XMLHTTP"); } catch (e) { try { xmlHttpRequest = new ActiveXObject("Microsoft.XMLHTTP"); } catch (e) { } } }
}
function InputNumericValuesOnly() {
    if (!(event.keyCode == 45 || event.keyCode == 46 || event.keyCode == 48 || event.keyCode == 49 || event.keyCode == 50 || event.keyCode == 51 || event.keyCode == 52 || event.keyCode == 53 || event.keyCode == 54 || event.keyCode == 55 || event.keyCode == 56 || event.keyCode == 57)) {
        event.returnValue = false;
    }
}

function ValidateDate(obj) {
    if (obj.value != "") {
        if (isDate(obj.value) == false) {
            obj.focus();
            return false;
        }
        return true;
    }
}
var dtCh = "/";
var minYear = "1900";
var maxYear = "2100";
function DaysArray(n) {
    for (var i = 1; i <= n; i++) {
        this[i] = 31
        if (i == 4 || i == 6 || i == 9 || i == "11") { this[i] = 30 }
        if (i == 2) { this[i] = 29 }
    }
    return this;
}
function isDate(dtStr) {
    var daysInMonth = DaysArray(12)
    var pos1 = dtStr.indexOf(dtCh)
    var pos2 = dtStr.indexOf(dtCh, pos1 + 1)
    var strDay = dtStr.substring(0, pos1)
    var strMonth = dtStr.substring(pos1 + 1, pos2)
    var strYear = dtStr.substring(pos2 + 1)
    strYr = strYear
    if (strDay.charAt(0) == "0" && strDay.length > 1) strDay = strDay.substring(1)
    if (strMonth.charAt(0) == "0" && strMonth.length > 1) strMonth = strMonth.substring(1)
    for (var i = 1; i <= 3; i++) {
        if (strYr.charAt(0) == "0" && strYr.length > 1) strYr = strYr.substring(1)
    }

    month = parseInt(strMonth)
    day = parseInt(strDay)
    year = parseInt(strYr)
    if (pos1 == -1 || pos2 == -1) {
        alert("The date format should be : dd/mm/yyyy");
        return false;
    }
    if (strMonth.length < 1 || month < 1 || month > 12) {
        alert("Please enter a valid month");
        return false;
    }
    if (strDay.length < 1 || day < 1 || day > 31 || (month == 2 && day > daysInFebruary(year)) || day > daysInMonth[month]) {
        alert("Please enter a valid day");
        return false;
    }
    if (strYear.length != 4 || year == 0 || year < minYear || year > maxYear) {
        alert("Please enter a valid 4 digit year between " + minYear + " and " + maxYear);
        return false;
    }

    if (dtStr.indexOf(dtCh, pos2 + 1) != -1 || isInteger(stripCharsInBag(dtStr, dtCh)) == false) {
        alert("Please enter a valid date");
        return false;
    }
    return true;
}
function stripCharsInBag(s, bag) {
    var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++) {
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}
function isInteger(s) {
    var i;
    for (i = 0; i < s.length; i++) {
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}
function CheckValidBranchCode(txtBranchCode) {
    var lbl_dgAdvanceDet_Err = document.getElementById("ctl00_MyCPH1_lbl_dgAdvanceDet_Err");
    var txtStartLoc = document.getElementById("ctl00_MyCPH1_txtStartLoc");

    if (txtBranchCode.value == "") {
        lbl_dgAdvanceDet_Err.innerText = "";
        return true;
    }
    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");;
                if (returnValue[0] == "N") {
                    lbl_dgAdvanceDet_Err.innerText = "Invalid Branch Code!  Please Enter Valid Branch code!!";
                    txtBranchCode.focus();
                    return false;
                }
                else {
                    if (txtStartLoc.value.toUpperCase() != txtBranchCode.value.toUpperCase()) {
                        lbl_dgAdvanceDet_Err.innerText = "Tripsheet start locaion and branch code must be same!!";
                        txtBranchCode.focus();
                        return false;
                    }
                    else {
                        txtBranchCode.value = txtBranchCode.value.toUpperCase();
                        lbl_dgAdvanceDet_Err.innerText = "";
                    }
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckValidBranchCode&datetime=" + currentTime + "&BranchCode=" + txtBranchCode.value, false);
        xmlHttpRequest.send(null);
    }

}
function FillPaymentAmt() {
    var txtAmount = document.getElementById("ctl00_MyCPH1_UCPayment_txtAmount");
    var txtAdvAmt = document.getElementById("ctl00_MyCPH1_dgAdvanceDet_ctl02_txtAdvAmt");
    var hfPaymentAmount = document.getElementById("ctl00_MyCPH1_hfPaymentAmount");
    txtAmount.value = (parseFloat(txtAdvAmt.value)).toFixed();
    hfPaymentAmount.value = (parseFloat(txtAdvAmt.value)).toFixed();
}
function IsDateGreater(DateValue1, DateValue2) {
    var a = DateValue1.split("/");
    var b = DateValue2.split("/");
    DateValue1 = a[1] + "/" + a[0] + "/" + a[2];
    DateValue2 = b[1] + "/" + b[0] + "/" + b[2];
    if (Date.parse(DateValue1) == Date.parse(DateValue2))
        return true;
    else
        if (Date.parse(DateValue1) >= Date.parse(DateValue2))
            return true;
        else
            return false;

}
function CheckAdvDt() {
    var txtAdvDt = document.getElementById("ctl00_MyCPH1_dgAdvanceDet_ctl02_txtAdvDt");
    var txtDate = document.getElementById("ctl00_MyCPH1_txtDate");
    var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");
    var lbl_dgAdvanceDet_Err = document.getElementById("ctl00_MyCPH1_lbl_dgAdvanceDet_Err");
    if (txtAdvDt.value != "") {
        if (!isDate(txtAdvDt.value)) {
            lbl_dgAdvanceDet_Err.innerText = "Invalid Date!!!";
            txtAdvDt.focus();
            return false;
        }
        else {
            if (txtAdvDt.value != txtDate.value) {
                if (IsDateGreater(txtAdvDt.value, hfTodayDate.value)) {
                    lbl_dgAdvanceDet_Err.innerText = "Advance Date should not be greater than today's date!";
                    txtAdvDt.focus();
                    return false;
                }
                else {
                    lbl_dgAdvanceDet_Err.innerText = "";
                }
                if (IsDateGreater(txtDate.value, txtAdvDt.value)) {
                    lbl_dgAdvanceDet_Err.innerText = "Advance Date should not be less than Issue Slip Date!!";
                    txtAdvDt.focus();
                    return false;
                }
                else {
                    lbl_dgAdvanceDet_Err.innerText = "";
                }
            }
            else {
                lbl_dgAdvanceDet_Err.innerText = "";
            }
        }
    }
}
/*************************************************************************************************************
*   CHECK FOR VALID DECIMAL VALUE
/*************************************************************************************************************/
function checkDecimal(id, isID) {
    var txtID;

    if (isID == "TRUE") {
        txtID = document.getElementById(id);
    }
    else {
        txtID = id;
    }

    if (txtID.value != "") {
        if (isNaN(txtID.value)) {
            alert("Value should be Numeric.");
            txtID.value = "";
            return false;
        }
        if (parseFloat(txtID.value) < 0) {
            alert("Value should be greater than zero.");
            txtID.value = "";
            return false;
        }
    }
    return true;
}
function CheckValidMin(id, isID) {
    var txtID;
    if (isID == "TRUE") {
        txtID = document.getElementById(id);
    }
    else {
        txtID = id;
    }
    if (checkDecimal(id, isID)) {
        if (parseFloat(txtID.value) > 59) {
            alert("Invalid Minute");
            txtID.focus();
            return false;
        }
    }
}

function CountTotalUFL() {
    var tb_UFL_Weight = document.getElementById("ctl00_MyCPH1_tb_UFL_Weight");
    var tb_AFL_Weight = document.getElementById("ctl00_MyCPH1_tb_AFL_Weight");
    var tb_Total_Weight = document.getElementById("ctl00_MyCPH1_tb_Total_Weight");

    tb_Total_Weight.value = (parseFloat(tb_UFL_Weight.value) + parseFloat(tb_AFL_Weight.value)).toFixed(2);

}

function CheckValidCity(txtFromCity, lbl_FromCity_Err) {
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
function ChangeRouteDetails(ddlRouteDetails) {
    var row_Trip_Route_C = document.getElementById("ctl00_MyCPH1_row_Trip_Route_C");
    var row_Trip_Route_R = document.getElementById("ctl00_MyCPH1_row_Trip_Route_R");

    if (ddlRouteDetails.value == "1") {
        row_Trip_Route_C.style["display"] = "none";
        row_Trip_Route_R.style["display"] = "block";
    }
    else if (ddlRouteDetails.value == "2") {
        row_Trip_Route_C.style["display"] = "block";
        row_Trip_Route_R.style["display"] = "none";
    }

}

function OnChangeRoute(ddlRoute) {
    var tb_Trasit_HH = document.getElementById("ctl00_MyCPH1_tb_Trasit_HH");
    var tb_Trasit_MM = document.getElementById("ctl00_MyCPH1_tb_Trasit_MM");
    if (ddlRoute.value != "") {
        createXMLHttpRequest();
        if (xmlHttpRequest) {
            xmlHttpRequest.onreadystatechange = function () {
                if (xmlHttpRequest.readyState == 4) {
                    var returnValue = xmlHttpRequest.responseText.split("~");
                    if (returnValue[0] == "Y") {
                        var hour = returnValue[1];
                        var min = returnValue[2];
                        tb_Trasit_HH.value = parseInt(hour) + parseInt((parseInt(hour) / 60));
                        tb_Trasit_MM.value = (parseInt(min) % 60);
                        tb_Trasit_HH.disabled = true;
                        tb_Trasit_MM.disabled = true;
                    }
                    else {
                        tb_Trasit_HH.value = "";
                        tb_Trasit_MM.value = "";
                        tb_Trasit_HH.disabled = false;
                        tb_Trasit_MM.disabled = false;
                    }
                }
            }
            xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=OnChangeRoute&RutCd=" + ddlRoute.value + "&datetime=" + currentTime, false);
            xmlHttpRequest.send(null);
        }
    }
    else {
        tb_Trasit_HH.value = "";
        tb_Trasit_MM.value = "";
        tb_Trasit_HH.disabled = false;
        tb_Trasit_MM.disabled = false;
    }
}

function CheckTripRule() {
    var row_Vehicle_Manual = document.getElementById("ctl00_MyCPH1_row_Vehicle_Manual");
    var row_Vehicle_Select = document.getElementById("ctl00_MyCPH1_row_Vehicle_Select");
    var row_Driver_Select = document.getElementById("ctl00_MyCPH1_row_Driver_Select");
    var row_Driver_Manual = document.getElementById("ctl00_MyCPH1_row_Driver_Manual");
    var row_Trip_Route_B = document.getElementById("ctl00_MyCPH1_row_Trip_Route_B");
    var row_Trip_Route_C = document.getElementById("ctl00_MyCPH1_row_Trip_Route_C");
    var row_Trip_Route_R = document.getElementById("ctl00_MyCPH1_row_Trip_Route_R");
    var row_THC_Attached = document.getElementById("ctl00_MyCPH1_row_THC_Attached");
    var hfAttached = document.getElementById("ctl00_MyCPH1_hfAttached");
    var hf_Vehicle_Filter = document.getElementById("ctl00_MyCPH1_hf_Vehicle_Filter");
    var row_Auto_Manual_TSNo = document.getElementById("ctl00_MyCPH1_row_Auto_Manual_TSNo");
    var row_Manual_TSNo = document.getElementById("ctl00_MyCPH1_row_Manual_TSNo");
    var hfAutoManualTsStatus = document.getElementById("ctl00_MyCPH1_hfAutoManualTsStatus");
    var row_ExternalUsages_Category = document.getElementById("ctl00_MyCPH1_row_ExternalUsages_Category");
    var row_Vehicle_Mode = document.getElementById("ctl00_MyCPH1_row_Vehicle_Mode");

    var row_UFL1 = document.getElementById("ctl00_MyCPH1_row_UFL1");
    var row_UFL2 = document.getElementById("ctl00_MyCPH1_row_UFL2");

    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "Y") {
                    if (returnValue[1] == "Y") {
                        row_Vehicle_Manual.style["display"] = "none";
                        row_Vehicle_Select.style["display"] = "block";
                    }
                    else {
                        row_Vehicle_Manual.style["display"] = "block";
                        row_Vehicle_Select.style["display"] = "none";
                    }

                    if (returnValue[2] == "Y" && returnValue[3] == "Y") {
                        row_Driver_Manual.style["display"] = "block";
                        row_Driver_Select.style["display"] = "none";
                    }
                    else {
                        row_Driver_Manual.style["display"] = "none";
                        row_Driver_Select.style["display"] = "block";
                    }
                    if (returnValue[4] == "C") {
                        row_Trip_Route_C.style["display"] = "block";
                        row_Trip_Route_B.style["display"] = "none";
                        row_Trip_Route_R.style["display"] = "none";
                    }
                    else if (returnValue[4] == "R") {
                        row_Trip_Route_C.style["display"] = "none";
                        row_Trip_Route_B.style["display"] = "none";
                        row_Trip_Route_R.style["display"] = "block";
                    }
                    else if (returnValue[4] == "B") {
                        row_Trip_Route_C.style["display"] = "block";
                        row_Trip_Route_B.style["display"] = "block";
                        row_Trip_Route_R.style["display"] = "none";
                    }
                    else if (returnValue[4] == "N") {
                        row_Trip_Route_C.style["display"] = "none";
                        row_Trip_Route_B.style["display"] = "none";
                        row_Trip_Route_R.style["display"] = "none";
                    }
                    if (returnValue[5] == "Y") {
                        row_THC_Attached.style["display"] = "none";
                        hfAttached.value = "Y";
                    }
                    else {
                        row_THC_Attached.style["display"] = "none";
                        hfAttached.value = "N";
                    }
                    if (returnValue[6] == "CUR_LOC") {
                        hf_Vehicle_Filter.value = "CUR_LOC";
                    }
                    else if (returnValue[6] == "CONT_LOC") {
                        hf_Vehicle_Filter.value = "CONT_LOC";
                    }
                    if (returnValue[7] == "Y") {
                        row_UFL1.style["display"] = "block";
                        row_UFL2.style["display"] = "block";
                    }
                    else {
                        row_UFL1.style["display"] = "none";
                        row_UFL2.style["display"] = "none";
                    }
                    if (returnValue[8] == "Y") {
                        row_Auto_Manual_TSNo.style["display"] = "block";
                        row_Manual_TSNo.style["display"] = "none";
                        hfAutoManualTsStatus.value = "Yes";
                    }
                    else {
                        row_Auto_Manual_TSNo.style["display"] = "none";
                        row_Manual_TSNo.style["display"] = "block";
                        hfAutoManualTsStatus.value = "No";
                    }
                    //                    if(returnValue[9] == "Y")
                    //                    {
                    //                        row_ExternalUsages_Category.style["display"] = "block";
                    //                        row_ExternalUsages_Category.style["display"] = "block";
                    //                    }
                    //                    else
                    //                    {
                    //                        row_ExternalUsages_Category.style["display"] = "none";
                    //                        row_ExternalUsages_Category.style["display"] = "none";
                    //                    }
                    if (returnValue[10] == "Y") {
                        row_Vehicle_Mode.style["display"] = "block";
                        row_Vehicle_Mode.style["display"] = "block";
                    }
                    else {
                        row_Vehicle_Mode.style["display"] = "none";
                        row_Vehicle_Mode.style["display"] = "none";
                    }
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckTripRule&datetime=" + currentTime, false);
        xmlHttpRequest.send(null);
    }
}

////CHECK MANUAL TRIPSHEET NUMBER
function CheckValidManualTS(txtManualTripSheetNo, lbl_Manual_TS_Err) {

    var str_Index = "";
    if (txtManualTripSheetNo.value == "") {
        txtManualTripSheetNo.value = "";
        lbl_Manual_TS_Err.innerText = "";
        return;
    }

    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "Y") {
                    lbl_Manual_TS_Err.innerText = "Manual Tripsheet Number already exists!!!";
                    txtManualTripSheetNo.focus();
                    return false;
                }
                else {
                    txtManualTripSheetNo.value = txtManualTripSheetNo.value;
                    lbl_Manual_TS_Err.innerText = "";
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckValidManualTS&datetime=" + currentTime + "&ManualTSNo=" + txtManualTripSheetNo.value, false);
        xmlHttpRequest.send(null);
    }
}
////////////////Fill DriverDetails
function CheckDriver2ManualCode() {
    var txtDriver1 = document.getElementById("ctl00_MyCPH1_txtDriver1");
    var txtDriver2 = document.getElementById("ctl00_MyCPH1_txtDriver2");
    var hfDriver1ID = document.getElementById("ctl00_MyCPH1_hfDriver2ID");
    var lblD1Error = document.getElementById("ctl00_MyCPH1_lblD2Error");
    var LblDriver1Name = document.getElementById("ctl00_MyCPH1_LblDriver2Name");
    var lblLicno = document.getElementById("ctl00_MyCPH1_lblLicnoD2");
    var lblValidDt = document.getElementById("ctl00_MyCPH1_lblValidDtD2");

    if (txtDriver2.value == "") {
        txtDriver2.value = "";
        hfDriver1ID.value = "";
        lblD1Error.innerText = "";
        LblDriver1Name.value = "";
        lblLicno.value = "";
        lblValidDt.value = "";
    }
    else {
        if (txtDriver1.value == txtDriver2.value) {
            lblD1Error.innerText = "Not allowed. Driver1 and Driver2 manual code must be different.";
            txtDriver2.focus();
            return false;
        }

        createXMLHttpRequest();
        if (xmlHttpRequest) {
            xmlHttpRequest.onreadystatechange = function () {
                if (xmlHttpRequest.readyState == 4) {
                    var returnValue = xmlHttpRequest.responseText.split("~");
                    if (returnValue[0] == "N") {
                        lblD1Error.innerText = "Invalid Drier Manual Code!!!";

                        hfDriver1ID.value = "";
                        LblDriver1Name.value = "";
                        lblLicno.value = "";
                        lblValidDt.value = "";
                        txtDriver2.focus();
                        return false;
                    }
                    else {
                        if (returnValue[6] == "In Transit") {
                            lblD1Error.innerText = "Driver is In Transit.";
                            hfDriver1ID.value = "";
                            LblDriver1Name.value = "";
                            lblLicno.value = "";
                            lblValidDt.value = "";
                            txtDriver1.focus();
                            return false;
                        }
                        else {
                            lblD1Error.innerText = "";
                            txtDriver2.value = returnValue[1];
                            hfDriver1ID.value = returnValue[2];
                            LblDriver1Name.value = returnValue[3];
                            lblLicno.value = returnValue[4];
                            lblValidDt.value = returnValue[5];
                        }
                    }
                }
            }
            xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckDriver1ManualCode&datetime=" + currentTime + "&DriverManualCode=" + txtDriver2.value, false);
            xmlHttpRequest.send(null);
        }
    }
}
//function CheckDriver1ManualCode() {
//    var txtDriver1 = document.getElementById("ctl00_MyCPH1_txtDriver1");
//    var txtDriver2 = document.getElementById("ctl00_MyCPH1_txtDriver2");
//    var hfDriver1ID = document.getElementById("ctl00_MyCPH1_hfDriver1ID");
//    var lblD1Error = document.getElementById("ctl00_MyCPH1_lblD1Error");
//    var LblDriver1Name = document.getElementById("ctl00_MyCPH1_LblDriver1Name");
//    var lblLicno = document.getElementById("ctl00_MyCPH1_lblLicno");
//    var lblValidDt = document.getElementById("ctl00_MyCPH1_lblValidDt");
//    var LblDriverBalance = document.getElementById("ctl00_MyCPH1_LblDriverBalance");

//    if (txtDriver1.value == "") {
//        txtDriver1.value = "";
//        hfDriver1ID.value = "";
//        lblD1Error.innerText = "";
//        LblDriver1Name.value = "";
//        lblLicno.value = "";
//        lblValidDt.value = "";
//        LblDriverBalance.value = "";
//    }
//    else {
//        if (txtDriver1.value == txtDriver2.value) {
//            lblD1Error.innerText = "Not allowed. Driver1 and Driver2 manual code must be different.";
//            txtDriver2.focus();
//            return false;
//        }
//        createXMLHttpRequest();
//        if (xmlHttpRequest) {
//            xmlHttpRequest.onreadystatechange = function() {
//                if (xmlHttpRequest.readyState == 4) {
//                    var returnValue = xmlHttpRequest.responseText.split("~");
//                    if (returnValue[0] == "N") {
//                        lblD1Error.innerText = "Invalid Drier Manual Code!!!";

//                        hfDriver1ID.value = "";
//                        LblDriver1Name.value = "";
//                        lblLicno.value = "";
//                        lblValidDt.value = "";
//                        txtDriver1.focus();
//                        LblDriverBalance.value = "";
//                        return false;
//                    }
//                    else {
//                        if (returnValue[6] == "In Transit") {
//                            lblD1Error.innerText = "Driver is In Transit.";
//                            hfDriver1ID.value = "";
//                            LblDriver1Name.value = "";
//                            lblLicno.value = "";
//                            lblValidDt.value = "";
//                            txtDriver1.focus();
//                            LblDriverBalance.value = "";
//                            return false;
//                        }
//                        else {
//                            lblD1Error.innerText = "";
//                            txtDriver1.value = returnValue[1];
//                            hfDriver1ID.value = returnValue[2];
//                            LblDriver1Name.value = returnValue[3];
//                            lblLicno.value = returnValue[4];
//                            lblValidDt.value = returnValue[5];
//                            FillDriverBalance(txtDriver1);
//                        }
//                    }
//                }
//            }
//            xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckDriver1ManualCode&datetime=" + currentTime + "&DriverManualCode=" + txtDriver1.value, false);
//            xmlHttpRequest.send(null);
//        }
//    }
//}
function CheckDriver1ManualCode() {
    var txtDriver1 = document.getElementById("ctl00_MyCPH1_txtDriver1");
    var txtDriver2 = document.getElementById("ctl00_MyCPH1_txtDriver2");
    var hfDriver1ID = document.getElementById("ctl00_MyCPH1_hfDriver1ID");
    var lblD1Error = document.getElementById("ctl00_MyCPH1_lblD1Error");
    var LblDriver1Name = document.getElementById("ctl00_MyCPH1_LblDriver1Name");
    var lblLicno = document.getElementById("ctl00_MyCPH1_lblLicno");
    var lblValidDt = document.getElementById("ctl00_MyCPH1_lblValidDt");
    var LblDriverBalance = document.getElementById("ctl00_MyCPH1_LblDriverBalance");

    var hfDriver_Photo = document.getElementById("ctl00_MyCPH1_hfDriver_Photo");
    var hfDriver_photo_Rule = document.getElementById("ctl00_MyCPH1_hfDriver_photo_Rule");
    var hfDriverLic_Validity = document.getElementById("ctl00_MyCPH1_hfDriverLic_Validity");
    var hfDriverLic_Validity_Rule = document.getElementById("ctl00_MyCPH1_hfDriverLic_Validity_Rule");
    var hfDriver_TripCount = document.getElementById("ctl00_MyCPH1_hfDriver_TripCount");
    var hfDriver_TripCount_Rule = document.getElementById("ctl00_MyCPH1_hfDriver_TripCount_Rule");
    var hfTot_No_Trip = document.getElementById("ctl00_MyCPH1_hfTot_No_Trip");
    var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");

    if (txtDriver1.value == "") {
        txtDriver1.value = "";
        hfDriver1ID.value = "";
        lblD1Error.innerText = "";
        LblDriver1Name.value = "";
        lblLicno.value = "";
        lblValidDt.value = "";
        LblDriverBalance.value = "";
    }
    else {
        if (txtDriver1.value == txtDriver2.value) {
            lblD1Error.innerText = "Not allowed. Driver1 and Driver2 manual code must be different.";
            txtDriver2.focus();
            return false;
        }
        createXMLHttpRequest();
        if (xmlHttpRequest) {
            xmlHttpRequest.onreadystatechange = function () {
                if (xmlHttpRequest.readyState == 4) {
                    var returnValue = xmlHttpRequest.responseText.split("~");
                    if (returnValue[0] == "N") {
                        lblD1Error.innerText = "Invalid Drier Manual Code!!!";

                        hfDriver1ID.value = "";
                        LblDriver1Name.value = "";
                        lblLicno.value = "";
                        lblValidDt.value = "";
                        txtDriver1.focus();
                        LblDriverBalance.value = "";
                        return false;
                    }
                    else {
                        var mDriverLic_Validity = "";
                        var mDriver_Photo = "";
                        var mDriver_TripCount = "";

                        mDriverLic_Validity = returnValue[5];
                        mDriver_Photo = returnValue[7];
                        mDriver_TripCount = returnValue[8];

                        if (hfDriver_photo_Rule.value == "Y" && mDriver_Photo == "" || hfDriverLic_Validity_Rule.value == "Y" && mDriverLic_Validity < hfTodayDate.value || hfDriver_TripCount_Rule.value == "Y" && hfTot_No_Trip.value < mDriver_TripCount) {
                            if (hfDriver_photo_Rule.value == "Y" && mDriver_Photo == "") {
                                alert("Selected Driver Do Not have Their Photo \r\nPlease Select Another Driver");
                                hfDriver1ID.value = "";
                                LblDriver1Name.value = "";
                                lblLicno.value = "";
                                lblValidDt.value = "";
                                txtDriver1.focus();
                                LblDriverBalance.value = "";
                                return false;
                            }
                            else {
                                if (returnValue[6] == "In Transit") {
                                    lblD1Error.innerText = "Driver is In Transit.";
                                    hfDriver1ID.value = "";
                                    LblDriver1Name.value = "";
                                    lblLicno.value = "";
                                    lblValidDt.value = "";
                                    txtDriver1.focus();
                                    LblDriverBalance.value = "";
                                    return false;
                                }
                                else {
                                    lblD1Error.innerText = "";
                                    txtDriver1.value = returnValue[1];
                                    hfDriver1ID.value = returnValue[2];
                                    LblDriver1Name.value = returnValue[3];
                                    lblLicno.value = returnValue[4];
                                    lblValidDt.value = returnValue[5];
                                    FillDriverBalance(txtDriver1)
                                }
                            }


                            if (hfDriverLic_Validity_Rule.value == "Y" && mDriverLic_Validity < hfTodayDate.value) {
                                alert("Selected Driver's License is Expired \r\nPlease Select Another Driver");
                                hfDriver1ID.value = "";
                                LblDriver1Name.value = "";
                                lblLicno.value = "";
                                lblValidDt.value = "";
                                txtDriver1.focus();
                                LblDriverBalance.value = "";
                                return false;
                            }
                            else {
                                if (returnValue[6] == "In Transit") {
                                    lblD1Error.innerText = "Driver is In Transit.";
                                    hfDriver1ID.value = "";
                                    LblDriver1Name.value = "";
                                    lblLicno.value = "";
                                    lblValidDt.value = "";
                                    txtDriver1.focus();
                                    LblDriverBalance.value = "";
                                    return false;
                                }
                                else {
                                    lblD1Error.innerText = "";
                                    txtDriver1.value = returnValue[1];
                                    hfDriver1ID.value = returnValue[2];
                                    LblDriver1Name.value = returnValue[3];
                                    lblLicno.value = returnValue[4];
                                    lblValidDt.value = returnValue[5];
                                    FillDriverBalance(txtDriver1)
                                }
                            }
                            if (hfDriver_TripCount_Rule.value == "Y" && hfTot_No_Trip.value < mDriver_TripCount) {
                                alert("Driver Settlement is Pending For " + returnValue[5] + " Trip Sheet \r\nPlease Select Another Driver");
                                hfDriver1ID.value = "";
                                LblDriver1Name.value = "";
                                lblLicno.value = "";
                                lblValidDt.value = "";
                                txtDriver1.focus();
                                LblDriverBalance.value = "";
                                return false;
                            }
                            else {
                                if (returnValue[6] == "In Transit") {
                                    lblD1Error.innerText = "Driver is In Transit.";
                                    hfDriver1ID.value = "";
                                    LblDriver1Name.value = "";
                                    lblLicno.value = "";
                                    lblValidDt.value = "";
                                    txtDriver1.focus();
                                    LblDriverBalance.value = "";
                                    return false;
                                }
                                else {
                                    lblD1Error.innerText = "";
                                    txtDriver1.value = returnValue[1];
                                    hfDriver1ID.value = returnValue[2];
                                    LblDriver1Name.value = returnValue[3];
                                    lblLicno.value = returnValue[4];
                                    lblValidDt.value = returnValue[5];
                                    FillDriverBalance(txtDriver1)
                                }
                            }
                        }
                        else {
                            lblD1Error.innerText = "";
                            txtDriver1.value = returnValue[1];
                            hfDriver1ID.value = returnValue[2];
                            LblDriver1Name.value = returnValue[3];
                            lblLicno.value = returnValue[4];
                            lblValidDt.value = returnValue[5];
                            FillDriverBalance(txtDriver1)
                        }
                    }
                }
            }
            xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckDriver1ManualCode&datetime=" + currentTime + "&DriverManualCode=" + txtDriver1.value, false);
            xmlHttpRequest.send(null);
        }
    }
}
function FillDriverBalance(txtDriver1) {
    var txtDate = document.getElementById("ctl00_MyCPH1_txtDate");
    var LblDriverBalance = document.getElementById("ctl00_MyCPH1_LblDriverBalance");
    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "Y") {
                    LblDriverBalance.value = returnValue[1];
                }
                else {
                    LblDriverBalance.value = "";
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=FillDriverBalance&datetime=" + currentTime + "&txtDate=" + txtDate.value + "&Driver1=" + txtDriver1.value, false);
        xmlHttpRequest.send(null);
    }
}

//function GetDriver1Details(ddl_Driver1) {
//    var LblDriver1Name = document.getElementById("ctl00_MyCPH1_LblDriver1Name");
//    var lblLicno = document.getElementById("ctl00_MyCPH1_lblLicno");
//    var lblValidDt = document.getElementById("ctl00_MyCPH1_lblValidDt");
//    var ddl_Driver2 = document.getElementById("ctl00_MyCPH1_ddl_Driver2");
//    var hf_Manual_Driver_Code = document.getElementById("ctl00_MyCPH1_hf_Manual_Driver_Code");
//    var LblDriverBalance = document.getElementById("ctl00_MyCPH1_LblDriverBalance");

//    if (ddl_Driver1.value != "") {
//        if (ddl_Driver1.value == ddl_Driver2.value) {
//            alert("Not allowed. Driver1 and Driver2 must be different.");
//            LblDriver1Name.value = "";
//            lblLicno.value = "";
//            lblValidDt.value = "";
//            ddl_Driver1.selectedIndex = 0;
//            return false;
//        }
//        createXMLHttpRequest();
//        if (xmlHttpRequest) {
//            xmlHttpRequest.onreadystatechange = function() {
//                if (xmlHttpRequest.readyState == 4) {
//                    var returnValue = xmlHttpRequest.responseText.split("~");
//                    if (returnValue[0] == "N") {
//                        LblDriver1Name.value = "";
//                        lblLicno.value = "";
//                        lblValidDt.value = "";
//                        hf_Manual_Driver_Code.value = "";
//                        LblDriverBalance.innerText = "";
//                    }
//                    else {
//                        LblDriver1Name.value = returnValue[1];
//                        lblLicno.value = returnValue[2];
//                        lblValidDt.value = returnValue[3];
//                        hf_Manual_Driver_Code.value = returnValue[4];
//                        FillDriverBalance(hf_Manual_Driver_Code);
//                    }
//                }
//            }
//            xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=GetDriverDetails&datetime=" + currentTime + "&DriverId=" + ddl_Driver1.value, false);
//            xmlHttpRequest.send(null);
//        }
//    }
//    else {
//        LblDriver1Name.value = "";
//        lblLicno.value = "";
//        lblValidDt.value = "";
//        ddl_Driver1.selectedIndex = 0;
//        LblDriverBalance.innerText = "";
//        hf_Manual_Driver_Code.value = "";
//    }
//}


//function GetDriver1Details(ddl_Driver1) {
//    var LblDriver1Name = document.getElementById("ctl00_MyCPH1_LblDriver1Name");
//    var lblLicno = document.getElementById("ctl00_MyCPH1_lblLicno");
//    var lblValidDt = document.getElementById("ctl00_MyCPH1_lblValidDt");
//    var hf_Manual_Driver_Code = document.getElementById("ctl00_MyCPH1_hf_Manual_Driver_Code");
//    var ddl_Driver2 = document.getElementById("ctl00_MyCPH1_ddl_Driver2");
//    var LblDriverBalance = document.getElementById("ctl00_MyCPH1_LblDriverBalance");

//    var hfDriver_Photo = document.getElementById("ctl00_MyCPH1_hfDriver_Photo");
//    var hfDriver_photo_Rule = document.getElementById("ctl00_MyCPH1_hfDriver_photo_Rule");
//    var hfDriverLic_Validity = document.getElementById("ctl00_MyCPH1_hfDriverLic_Validity");
//    var hfDriverLic_Validity_Rule = document.getElementById("ctl00_MyCPH1_hfDriverLic_Validity_Rule");
//    var hfDriver_TripCount = document.getElementById("ctl00_MyCPH1_hfDriver_TripCount");
//    var hfDriver_TripCount_Rule = document.getElementById("ctl00_MyCPH1_hfDriver_TripCount_Rule");
//    var hfTot_No_Trip = document.getElementById("ctl00_MyCPH1_hfTot_No_Trip");
//    var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");

//    if (ddl_Driver1.value != "") {
//        if (ddl_Driver1.value == ddl_Driver2.value) {
//            alert("Not allowed. Driver1 and Driver2 must be different.");
//            LblDriver1Name.value = "";
//            lblLicno.value = "";
//            lblValidDt.value = "";
//            ddl_Driver1.selectedIndex = 0;
//            return false;
//        }
//        createXMLHttpRequest();
//        if (xmlHttpRequest) {
//            xmlHttpRequest.onreadystatechange = function() {
//                if (xmlHttpRequest.readyState == 4) {
//                    var returnValue = xmlHttpRequest.responseText.split("~");
//                    if (returnValue[0] == "N") {
//                        LblDriver1Name.value = "";
//                        lblLicno.value = "";
//                        lblValidDt.value = "";
//                        hf_Manual_Driver_Code.value = "";
//                        LblDriverBalance.innerText = "";
//                    }
//                    else {
//                        var mDriverLic_Validity = "";
//                        var mDriver_Photo = "";
//                        var mDriver_TripCount = "";

//                        mDriverLic_Validity = returnValue[3];
//                        mDriver_Photo = returnValue[5];
//                        mDriver_TripCount = returnValue[6];

//                        if (hfDriver_photo_Rule.value == "Y" && mDriver_Photo == "" || hfDriverLic_Validity_Rule.value == "Y" && mDriverLic_Validity < hfTodayDate.value || hfDriver_TripCount_Rule.value == "Y" && hfTot_No_Trip.value < mDriver_TripCount) {
//                            if (hfDriver_photo_Rule.value == "Y" && mDriver_Photo == "") {
//                                alert("Selected Driver Do Not have Their Photo \r\nPlease Select Another Driver");
//                                LblDriver1Name.value = "";
//                                lblLicno.value = "";
//                                lblValidDt.value = "";
//                                ddl_Driver1.selectedIndex = 0;
//                                ddl_Driver1.focus();
//                            }

//                            //if (hfDriverLic_Validity_Rule.value == "Y" && mDriverLic_Validity < hfTodayDate.value) {
//                             if (hfDriverLic_Validity_Rule.value == "Y" && IsDateGreater(hfTodayDate.value, mDriverLic_Validity)) {
//                                alert(mDriverLic_Validity);
//                                alert(hfTodayDate.value);
//                                alert("Selected Driver's License is Expired \r\nPlease Select Another Driver");
//                                LblDriver1Name.value = "";
//                                lblLicno.value = "";
//                                lblValidDt.value = "";
//                                ddl_Driver1.selectedIndex = 0;
//                                ddl_Driver1.focus();
//                            }
//                            if (hfDriver_TripCount_Rule.value == "Y" && hfTot_No_Trip.value < mDriver_TripCount) {
//                                alert("Driver Settlement is Pending For " + returnValue[6] + " Trip Sheet \r\nPlease Select Another Driver");
//                                LblDriver1Name.value = "";
//                                lblLicno.value = "";
//                                lblValidDt.value = "";
//                                ddl_Driver1.selectedIndex = 0;
//                                ddl_Driver1.focus();
//                            }
//                        }
//                        else {
//                            LblDriver1Name.value = returnValue[1];
//                            lblLicno.value = returnValue[2];
//                            lblValidDt.value = returnValue[3];
//                            hf_Manual_Driver_Code.value = returnValue[4];
//                            FillDriverBalance(hf_Manual_Driver_Code);
//                        }
//                    }
//                }
//            }
//            xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=GetDriverDetails&datetime=" + currentTime + "&DriverId=" + ddl_Driver1.value, false);
//            xmlHttpRequest.send(null);
//        }
//    }
//    else {
//        LblDriver1Name.value = "";
//        lblLicno.value = "";
//        lblValidDt.value = "";
//        ddl_Driver1.selectedIndex = 0;
//    }

//}


function GetDriver1Details(ddl_Driver1) {
    var LblDriver1Name = document.getElementById("ctl00_MyCPH1_LblDriver1Name");
    var lblLicno = document.getElementById("ctl00_MyCPH1_lblLicno");
    var lblValidDt = document.getElementById("ctl00_MyCPH1_lblValidDt");
    var hf_Manual_Driver_Code = document.getElementById("ctl00_MyCPH1_hf_Manual_Driver_Code");
    var ddl_Driver2 = document.getElementById("ctl00_MyCPH1_ddl_Driver2");
    var hfDriver_Photo = document.getElementById("ctl00_MyCPH1_hfDriver_Photo");
    var hfDriver_photo_Rule = document.getElementById("ctl00_MyCPH1_hfDriver_photo_Rule");
    var hfDriverLic_Validity = document.getElementById("ctl00_MyCPH1_hfDriverLic_Validity");
    var hfDriverLic_Validity_Rule = document.getElementById("ctl00_MyCPH1_hfDriverLic_Validity_Rule");
    var hfDriver_TripCount = document.getElementById("ctl00_MyCPH1_hfDriver_TripCount");
    var hfDriver_TripCount_Rule = document.getElementById("ctl00_MyCPH1_hfDriver_TripCount_Rule");
    var hfTot_No_Trip = document.getElementById("ctl00_MyCPH1_hfTot_No_Trip");
    var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");

    if (ddl_Driver1.value != "") {
        if (ddl_Driver1.value == ddl_Driver2.value) {
            alert("Not allowed. Driver1 and Driver2 must be different.");
            LblDriver1Name.value = "";
            lblLicno.value = "";
            lblValidDt.value = "";
            ddl_Driver1.selectedIndex = 0;
            return false;
        }
        createXMLHttpRequest();
        if (xmlHttpRequest) {
            xmlHttpRequest.onreadystatechange = function () {
                if (xmlHttpRequest.readyState == 4) {
                    var returnValue = xmlHttpRequest.responseText.split("~");
                    if (returnValue[0] == "N") {
                        LblDriver1Name.value = "";
                        lblLicno.value = "";
                        lblValidDt.value = "";
                    }
                    else {
                        var mDriverLic_Validity = "";
                        var mDriver_Photo = "";
                        var mDriver_TripCount = "";

                        mDriverLic_Validity = returnValue[3];
                        mDriver_Photo = returnValue[4];
                        mDriver_TripCount = returnValue[5];

                        //                        alert(returnValue[3]);
                        //                        alert(hfTodayDate.value);

                        if (hfDriver_photo_Rule.value == "Y" && mDriver_Photo == "" || hfDriverLic_Validity_Rule.value == "Y" && IsDateGreater(hfTodayDate.value, mDriverLic_Validity) || hfDriver_TripCount_Rule.value == "Y" && hfTot_No_Trip.value < mDriver_TripCount) {
                            if (hfDriver_photo_Rule.value == "Y" && mDriver_Photo == "") {
                                alert("Selected Driver Do Not have Their Photo \r\nPlease Select Another Driver");
                                LblDriver1Name.value = "";
                                lblLicno.value = "";
                                lblValidDt.value = "";
                                ddl_Driver1.selectedIndex = 0;
                                ddl_Driver1.focus();
                            }
                            if (hfDriverLic_Validity_Rule.value == "Y" && IsDateGreater(hfTodayDate.value, mDriverLic_Validity)) {
                                alert("Selected Driver's License is Expired \r\nPlease Select Another Driver");
                                LblDriver1Name.value = "";
                                lblLicno.value = "";
                                lblValidDt.value = "";
                                ddl_Driver1.selectedIndex = 0;
                                ddl_Driver1.focus();
                            }
                            if (hfDriver_TripCount_Rule.value == "Y" && hfTot_No_Trip.value < mDriver_TripCount) {
                                alert("Driver Settlement is Pending For " + returnValue[5] + " Trip Sheet \r\nPlease Select Another Driver");
                                LblDriver1Name.value = "";
                                lblLicno.value = "";
                                lblValidDt.value = "";
                                ddl_Driver1.selectedIndex = 0;
                                ddl_Driver1.focus();
                            }
                        }
                        else {
                            LblDriver1Name.value = returnValue[1];
                            lblLicno.value = returnValue[2];
                            lblValidDt.value = returnValue[3];
                        }
                    }
                }
            }
            xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=GetDriverDetails&datetime=" + currentTime + "&DriverId=" + ddl_Driver1.value, false);
            xmlHttpRequest.send(null);
        }
    }
    else {
        LblDriver1Name.value = "";
        lblLicno.value = "";
        lblValidDt.value = "";
        ddl_Driver1.selectedIndex = 0;
    }
}


function GetDriver2Details(ddl_Driver2, LblDriver2Name, lblLicnoD2, lblValidDtD2) {
    var ddl_Driver1 = document.getElementById("ctl00_MyCPH1_ddl_Driver1");
    if (ddl_Driver2.value != "") {
        if (ddl_Driver1.value == ddl_Driver2.value) {
            alert("Not allowed. Driver1 and Driver2 must be different.");
            LblDriver2Name.value = "";
            lblLicnoD2.value = "";
            lblValidDtD2.value = "";
            ddl_Driver2.selectedIndex = 0;
            return false;
        }
        createXMLHttpRequest();
        if (xmlHttpRequest) {
            xmlHttpRequest.onreadystatechange = function () {
                if (xmlHttpRequest.readyState == 4) {
                    var returnValue = xmlHttpRequest.responseText.split("~");
                    if (returnValue[0] == "N") {
                        LblDriver2Name.value = "";
                        lblLicnoD2.value = "";
                        lblValidDtD2.value = "";
                    }
                    else {
                        LblDriver2Name.value = returnValue[1];
                        lblLicnoD2.value = returnValue[2];
                        lblValidDtD2.value = returnValue[3];
                    }
                }
            }
            xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=GetDriverDetails&datetime=" + currentTime + "&DriverId=" + ddl_Driver2.value, false);
            xmlHttpRequest.send(null);
        }
    }
    else {
        LblDriver2Name.value = "";
        lblLicnoD2.value = "";
        lblValidDtD2.value = "";
        ddl_Driver2.selectedIndex = 0;
    }
}

function ViewPhoto(strdriver) {
    var driverid = document.getElementById(strdriver).value;
    if (driverid == "") {
        alert("Please enter Driver manual code")
        document.getElementById(strdriver).focus();
    }
    if (driverid != "") {
        window.open("ViewPhoto.aspx?Manual_Driver_Code=" + driverid, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=225,height=230,status=no,left=150,top=70")
    }
}

function nwOpen(mNo) {
    window.open("popup-CUST.aspx?mNo=" + mNo, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
}

function PopUpVehNo(mNo) {
    window.open("../../../../GUI/popups/Popup-Vehicle.aspx?mNo=" + mNo, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
}

function PopUpDriver1(mNo) {
    window.open("../../../../GUI/popups/Popup-Driver1.aspx?id=D1&mNo=" + mNo, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=450,height=220,status=no,left=220,top=70")
}
function PopUpDriver2(mNo) {
    window.open("../../../../GUI/popups/Popup-Driver1.aspx?id=D2&mNo=" + mNo, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=450,height=220,status=no,left=220,top=70")
}
//function PopUpDriver2(mNo)
//{
//    window.open("../../../../GUI/popups/Popup-Driver2.aspx?mNo=" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
//}

function nwOpenCity(strval) {
    if (strval == "1") {
        window.open("popup-city1.aspx?city_mode=1", "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
    }
    else {
        window.open("popup-city1.aspx?city_mode=2", "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
    }
}

function valid(obj, tran) {
    var chqno = document.getElementById('ctl00_MyCPH1_UCPayment_txtChqNo');
    var chqdate = document.getElementById('ctl00_MyCPH1_UCPayment_txtChqDate');



    var row_THC_Attached = document.getElementById("ctl00_MyCPH1_row_THC_Attached");
    var hfAttached = document.getElementById("ctl00_MyCPH1_hfAttached");
    var hf_Vehicle_Filter = document.getElementById("ctl00_MyCPH1_hf_Vehicle_Filter");
    var row_Auto_Manual_TSNo = document.getElementById("ctl00_MyCPH1_row_Auto_Manual_TSNo");
    var hfAutoManualTsStatus = document.getElementById("ctl00_MyCPH1_hfAutoManualTsStatus");


    var row_Manual_TSNo = document.getElementById("ctl00_MyCPH1_row_Manual_TSNo");
    var txtManualTripSheetNo = document.getElementById('ctl00_MyCPH1_txtManualTripSheetNo');

    if (row_Manual_TSNo.style["display"] == "block") {
        if (txtManualTripSheetNo.value == "") {
            alert("Please enter Manual Trip Sheet No.");
            txtManualTripSheetNo.focus();
            return false;
        }
    }
    if (document.getElementById('ctl00_MyCPH1_txtEndLoc').value == "") {
        alert("Please enter End Location");
        document.getElementById('ctl00_MyCPH1_txtEndLoc').focus();
        return false;
    }



    if (document.getElementById('ctl00_MyCPH1_ddlCategory').value == "") {
        alert("Please select category ");
        document.getElementById('ctl00_MyCPH1_ddlCategory').focus();
        return false;
    }

    var ddl_ExternalUsages_Category = document.getElementById('ctl00_MyCPH1_ddl_ExternalUsages_Category');
    var row_ExternalUsages_Category = document.getElementById("ctl00_MyCPH1_row_ExternalUsages_Category");

    if (document.getElementById('ctl00_MyCPH1_ddlCategory').value == "External Usage") {

        if (document.getElementById('ctl00_MyCPH1_chkExCust').checked == false) {
            if (document.getElementById('ctl00_MyCPH1_txtCustCode').value == "") {
                alert("Please enter Customer code");
                document.getElementById('ctl00_MyCPH1_txtCustCode').focus();
                return false;
            }
        }
        else {

            if (document.getElementById('ctl00_MyCPH1_txtExCustCode').value == "") {
                alert("Please enter Walk in Customer Name");
                document.getElementById('ctl00_MyCPH1_txtExCustCode').focus();
                return false;
            }

        }

        if (ddl_ExternalUsages_Category != null) {
            if (ddl_ExternalUsages_Category.value == "") {
                alert("Please select External Usages Category");
                ddl_ExternalUsages_Category.focus();
                return false;
            }
        }

        if (document.getElementById('ctl00_MyCPH1_txtChallanNo').value == "") {
            alert("Please enter Challann no");
            document.getElementById('ctl00_MyCPH1_txtChallanNo').focus();
            return false;
        }

        if (document.getElementById('ctl00_MyCPH1_txtChallanDt').value == "") {
            alert("Please enter Challann Date");
            document.getElementById('ctl00_MyCPH1_txtChallanDt').focus();
            return false;
        }

        if (document.getElementById('ctl00_MyCPH1_txtBrokerName').value == "") {
            alert("Please enter Broker Name");
            document.getElementById('ctl00_MyCPH1_txtBrokerName').focus();
            return false;
        }

        if (document.getElementById('ctl00_MyCPH1_txtBrokerPhone').value == "") {
            alert("Please enter Broker Phone no.");
            document.getElementById('ctl00_MyCPH1_txtBrokerPhone').focus();
            return false;
        }

        if (document.getElementById('ctl00_MyCPH1_txtTotalFreight').value == "") {
            alert("Please enter Total Freight Amount");
            document.getElementById('ctl00_MyCPH1_txtTotalFreight').focus();
            return false;
        }

        if (parseFloat(document.getElementById('ctl00_MyCPH1_txtTotalFreight').value) <= 0) {
            alert("Total Freight Amount should be greater than zero");
            document.getElementById('ctl00_MyCPH1_txtTotalFreight').focus();
            return false;
        }


        if (document.getElementById('ctl00_MyCPH1_txtTotalAdvance').value == "") {
            alert("Please enter Total Advance Amount");
            document.getElementById('ctl00_MyCPH1_txtTotalAdvance').focus();
            return false;
        }


        if (parseFloat(document.getElementById('ctl00_MyCPH1_txtTotalAdvance').value) > 0) {

            if (parseFloat(document.getElementById('ctl00_MyCPH1_txtTotalBalanceAmt').value) < 0) {
                alert("Total Balance Amount should not be negative");
                document.getElementById('ctl00_MyCPH1_txtTotalBalanceAmt').focus();
                return false;

            }
            if (document.getElementById('ctl00_MyCPH1_ddlAdvAmtCollectionMode').value == "") {
                alert("Please select Advance Amount to be collected by ");
                document.getElementById('ctl00_MyCPH1_ddlAdvAmtCollectionMode').focus();
                return false;

            }
        }


        //Advance Amount to be collected by 


        /*txtChallanDt
        txtBrokerName
        txtBrokerPhone
        txtTotalFreight
        txtTotalBalanceAmt
        TxtRemark
        ddlAdvAmtCollectionMode*/
        if (document.getElementById('ctl00_MyCPH1_ddlAdvAmtCollectionMode').value == "1") {
            if (document.getElementById('ctl00$MyCPH1$UCAdvPaymentControl$txtAmount').value > 0) {
                //if (tran.value == "") {

                if (document.getElementById('ctl00$MyCPH1$UCAdvPaymentControl$dlsttranstype').value == "") {
                    alert("Select Payment Mode Of Transaction");
                    document.getElementById('ctl00$MyCPH1$UCAdvPaymentControl$dlsttranstype').focus();
                    return false;
                }
                if (document.getElementById('ctl00$MyCPH1$UCAdvPaymentControl$dlstAcccode').value == '') {
                    alert("Please Select Cash / Bank Account  !!")
                    document.getElementById('ctl00$MyCPH1$UCAdvPaymentControl$dlstAcccode').focus();
                    return false;
                }
                //if (tran.value == "BANK") {

                if (document.getElementById('ctl00$MyCPH1$UCAdvPaymentControl$dlsttranstype').value == "BANK") {
                    if (document.getElementById('ctl00$MyCPH1$UCAdvPaymentControl$txtChqNo').value == "") {
                        alert("Enter Payment Cheque Number");
                        document.getElementById('ctl00$MyCPH1$UCAdvPaymentControl$txtChqNo').focus();
                        return false;
                    }

                    if (document.getElementById('ctl00$MyCPH1$UCAdvPaymentControl$txtChqDate').value == "") {
                        alert("Enter Payment Cheque Date");
                        document.getElementById('ctl00$MyCPH1$UCAdvPaymentControl$txtChqDate').focus();
                        return false;
                    }
                    var dlstAcccode = document.getElementById('ctl00$MyCPH1$UCAdvPaymentControl$dlstAcccode');
                    if (dlstAcccode != null) {
                        if (dlstAcccode.value == '') {
                            alert("Please Select Payment Bank Name !!")
                            dlstAcccode.focus();
                            return false;
                        }
                    }
                    var txtAmount = document.getElementById('ctl00$MyCPH1$UCAdvPaymentControl$txtAmount');
                    if (txtAmount != null) {
                        if (txtAmount.value == 0) {
                            alert("Please Payment Enter Amount !!")
                            return false;
                        }
                    }
                }
                else {
                    if (document.getElementById('ctl00$MyCPH1$UCAdvPaymentControl$dlstAcccode').value == '') {
                        alert("Please Select Payment Cash Account !!")
                        return false;
                    }
                    if (document.getElementById('ctl00$MyCPH1$UCAdvPaymentControl$txtAmount').value == '0.00') {
                        alert("Please Enter Payment Amount !!")
                        return false;
                    }
                }
            }



        }

    }




    var row_Vehicle_Mode = document.getElementById("ctl00_MyCPH1_row_Vehicle_Mode");
    if (row_Vehicle_Mode.style["display"] == "block") {
        var ddl_Vehicle_Mode = document.getElementById("ctl00_MyCPH1_ddl_Vehicle_Mode");
        if (ddl_Vehicle_Mode.value == "") {
            alert("Please select vehicle mode");
            ddl_Vehicle_Mode.focus();
            return false;
        }
    }

    var row_Vehicle_Manual = document.getElementById("ctl00_MyCPH1_row_Vehicle_Manual");
    if (row_Vehicle_Manual.style["display"] == "block") {
        var txtVehNo = document.getElementById("ctl00_MyCPH1_txtVehNo");
        var lblVehCheck = document.getElementById("ctl00_MyCPH1_lblVehCheck");
        if (txtVehNo.value == "") {
            alert("Please enter vehicle number!!!");
            txtVehNo.focus();
            return false;
        }
        if (lblVehCheck.innerText != "") {
            alert("Enter valid vehicle number!!!");
            txtVehNo.focus();
            return false;
        }
        //        if(txtVehNo.value.length > 10)
        //        {
        //            alert("Vehicle Number length is greater than 10 is not allowed.");
        //            txtVehNo.focus();
        //            return false;
        //        }
    }

    var row_Vehicle_Select = document.getElementById("ctl00_MyCPH1_row_Vehicle_Select");
    if (row_Vehicle_Select.style["display"] == "block") {
        var i = document.getElementById('ctl00_MyCPH1_cboVehno').selectedIndex;
        var selected_text = document.getElementById('ctl00_MyCPH1_cboVehno').options[i].text;
        if (document.getElementById('ctl00_MyCPH1_cboVehno').value == "") {
            alert("Please select Vehicle Number!!!");
            document.getElementById('ctl00_MyCPH1_cboVehno').focus();
            return false;
        }
        //        if (selected_text.length > 10)
        //        {
        //            alert("Vehicle Number length is greater than 10 is not allowed.");
        //            return false;
        //        }
    }
    var row_Vehicle_Name = document.getElementById("ctl00_MyCPH1_row_Vehicle_Name");
    var tb_Vehicle_Name = document.getElementById("ctl00_MyCPH1_tb_Vehicle_Name");
    if (row_Vehicle_Name.style["display"] == "block") {
        if (tb_Vehicle_Name.value == "") {
            alert("Please enter vehicle number!!!");
            tb_Vehicle_Name.focus();
            return false;
        }
    }

    var row_Driver_Name = document.getElementById("ctl00_MyCPH1_row_Driver_Name");
    if (row_Driver_Name.style["display"] == "block") {
        var tb_Driver_Name1 = document.getElementById("ctl00_MyCPH1_tb_Driver_Name1");
        var tb_Driver_Name2 = document.getElementById("ctl00_MyCPH1_tb_Driver_Name2");
        if (tb_Driver_Name1.value == "") {
            alert("Enter Driver-1 Name!!!")
            tb_Driver_Name1.focus();
            return false;
        }
        if (tb_Driver_Name2.value != "") {
            if (tb_Driver_Name1.value == tb_Driver_Name2.value) {
                alert("Driver-1 and Driver-2 must be different!!!")
                tb_Driver_Name2.focus();
                return false;
            }
        }
        var lblLicno = document.getElementById("ctl00_MyCPH1_lblLicno");
        var lblLicnoD2 = document.getElementById("ctl00_MyCPH1_lblLicnoD2");
        var lblValidDt = document.getElementById("ctl00_MyCPH1_lblValidDt");
        var lblValidDtD2 = document.getElementById("ctl00_MyCPH1_lblValidDtD2");

        if (lblLicno.value == "") {
            alert("Enter License!!!")
            lblLicno.focus();
            return false;
        }
        if (lblValidDt.value == "") {
            alert("Enter License Validity Date!!!")
            lblValidDt.focus();
            return false;
        }
        else {
            var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");
            if (isDate(lblValidDt.value)) {
                if (IsDateGreater(hfTodayDate.value, lblValidDt.value)) {
                    alert("License date must be grater than today's date!");
                    lblValidDt.focus();
                    return false;
                }
            }
            else {
                alert("Invalid Date");
                lblValidDt.focus();
                return false;
            }
        }

        if (tb_Driver_Name2.value != "") {
            if (lblLicnoD2.value == "") {
                alert("Enter License for driver2!!!")
                lblLicnoD2.focus();
                return false;
            }

            if (lblValidDtD2.value == "") {
                alert("Enter License Validity Date for driver2!!!")
                lblValidDtD2.focus();
                return false;
            }
            else {
                var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");
                if (isDate(lblValidDtD2.value)) {
                    if (IsDateGreater(hfTodayDate.value, lblValidDtD2.value)) {
                        alert("License date must be grater than today's date!");
                        lblValidDtD2.focus();
                        return false;
                    }
                }
                else {
                    alert("Invalid Date");
                    lblValidDtD2.focus();
                    return false;
                }
            }
        }
    }

    var row_Driver_Select = document.getElementById("ctl00_MyCPH1_row_Driver_Select");
    if (row_Driver_Select.style["display"] == "block") {
        if (document.getElementById('ctl00_MyCPH1_ddl_Driver1').value == "") {
            alert("Please select Driver-1");
            document.getElementById('ctl00_MyCPH1_ddl_Driver1').focus();
            return false;
        }
    }

    var row_Driver_Manual = document.getElementById("ctl00_MyCPH1_row_Driver_Manual");
    if (row_Driver_Manual.style["display"] == "block") {
        if (document.getElementById('ctl00_MyCPH1_txtDriver1').value == "") {
            alert("Please enter Driver-1 Manual Code");
            document.getElementById('ctl00_MyCPH1_txtDriver1').focus();
            return false;
        }
    }

    if (document.getElementById('ctl00_MyCPH1_txtStartKM').value == "") {
        alert("Please enter Starting Km. Reading ");
        document.getElementById('ctl00_MyCPH1_txtStartKM').focus();
        return false;
    }
    if (parseFloat(document.getElementById('ctl00_MyCPH1_txtStartKM').value) < parseFloat(document.getElementById('ctl00_MyCPH1_hdStatKm').value)) {
        alert("Start Km Cannot  be less than actual Stat Km. i.e " + document.getElementById('ctl00_MyCPH1_hdStatKm').value);
        document.getElementById('ctl00_MyCPH1_txtStartKM').focus();
        return false;
    }

    if (document.getElementById('ctl00_MyCPH1_ddlCategory').value == "") {
        alert("Please select category ");
        document.getElementById('ctl00_MyCPH1_ddlCategory').focus();
        return false;
    }

    var ddl_ExternalUsages_Category = document.getElementById('ctl00_MyCPH1_ddl_ExternalUsages_Category');
    var row_ExternalUsages_Category = document.getElementById("ctl00_MyCPH1_row_ExternalUsages_Category");

    if (document.getElementById('ctl00_MyCPH1_ddlCategory').value == "External Usage") {
        if (document.getElementById('ctl00_MyCPH1_txtCustCode').value == "") {
            alert("Please enter Customer code");
            document.getElementById('ctl00_MyCPH1_txtCustCode').focus();
            return false;
        }
        if (ddl_ExternalUsages_Category != null) {
            if (ddl_ExternalUsages_Category.value == "") {
                alert("Please select External Usages Category");
                ddl_ExternalUsages_Category.focus();
                return false;
            }
        }
    }

    var row_Trip_Route_B = document.getElementById("ctl00_MyCPH1_row_Trip_Route_B");
    var row_Trip_Route_C = document.getElementById("ctl00_MyCPH1_row_Trip_Route_C");
    if (row_Trip_Route_C.style["display"] == "block") {
        var hfLOCAL_CITY = document.getElementById('ctl00_MyCPH1_hfLOCAL_CITY');
        var txtFromCity = document.getElementById('ctl00_MyCPH1_txtFromCity');
        var txtToCity = document.getElementById('ctl00_MyCPH1_txtToCity');


        if (txtFromCity.value == "") {
            alert("From City can not be blank");
            txtFromCity.focus();
            return false;
        }
        if (txtToCity.value == "") {
            alert("To City can not be blank");
            txtToCity.focus();
            return false;
        }
        if (hfLOCAL_CITY.value == "N") {
            if (txtFromCity.value == txtToCity.value) {
                alert("From and To City can not be same");
                txtFromCity.focus();
                return false;
            }
        }
    }
    var row_Trip_Route_R = document.getElementById("ctl00_MyCPH1_row_Trip_Route_R");
    if (row_Trip_Route_R.style["display"] == "block") {
        if (document.getElementById('ctl00_MyCPH1_ddlRoute').value == "") {
            alert("Please Select Route");
            document.getElementById('ctl00_MyCPH1_ddlRoute').focus();
            return false;
        }
    }

    var tb_Trasit_HH = document.getElementById('ctl00_MyCPH1_tb_Trasit_HH');
    var tb_Trasit_MM = document.getElementById('ctl00_MyCPH1_tb_Trasit_MM');
    if (tb_Trasit_HH.value == "") {
        alert("Please enter Trnsit Hours!!!");
        tb_Trasit_HH.focus();
        return false;
    }
    if (tb_Trasit_MM.value == "") {
        alert("Please enter Trnsit Minutes!!!");
        tb_Trasit_MM.focus();
        return false;
    }

    var row_UFL1 = document.getElementById('ctl00_MyCPH1_row_UFL1');
    var row_UFL2 = document.getElementById('ctl00_MyCPH1_row_UFL2');

    var tb_Trip_Revenue = document.getElementById('ctl00_MyCPH1_tb_Trip_Revenue');
    var tb_UFL_Weight = document.getElementById('ctl00_MyCPH1_tb_UFL_Weight');
    var tb_AFL_Weight = document.getElementById('ctl00_MyCPH1_tb_AFL_Weight');
    var tb_Total_Weight = document.getElementById('ctl00_MyCPH1_tb_Total_Weight');

    if (row_UFL1.style["display"] == "block") {
        if (tb_Trip_Revenue.value == "") {
            alert("Please enter Trip Revenue!!!");
            tb_Trip_Revenue.focus();
            return false;
        }
        if (tb_UFL_Weight.value == "") {
            alert("Please UFL Weight!!!");
            tb_UFL_Weight.focus();
            return false;
        }
    }

    if (row_UFL2.style["display"] == "block") {
        if (tb_AFL_Weight.value == "") {
            alert("Please enter AFL Weight!!!");
            tb_AFL_Weight.focus();
            return false;
        }
        if (tb_Total_Weight.value == "") {
            alert("Please enter Total Weight!!!");
            tb_Total_Weight.focus();
            return false;
        }
    }

    var row_Docket_btn = document.getElementById('ctl00_MyCPH1_row_Docket_btn');

    var row_Dockets = document.getElementById('ctl00_MyCPH1_row_Dockets');
    var chklstDockets = document.getElementById('ctl00_MyCPH1_chklstDockets');
    var hfDocketLabel = document.getElementById('ctl00_MyCPH1_hfDocketLabel');

    if (row_Dockets.style["display"] == "block") {
        if (ddl_ExternalUsages_Category.value == "02") {
            var bool = false;
            if (chklstDockets != null) {
                var options = chklstDockets.getElementsByTagName('input');
                var arrayOfCheckBoxLabels = chklstDockets.getElementsByTagName("label");
                for (i = 0; i < options.length; i++) {
                    var opt = options[i];
                    if (opt.checked == true) {
                        bool = true;
                    }
                }
            }
            else {
                alert("There is no " + hfDocketLabel.value + " number!!!");
                return false;
            }
            if (bool == false) {
                alert("If external usages category is milk run, you must be select one " + hfDocketLabel.value + "number !!!");
                return false;
            }
        }
    }
    else {
        if (ddl_ExternalUsages_Category == "02") {
            alert("If external usages category is milk run, you must be select one docket!!!");
            return false;
        }
    }

    var tbl_Driver_Adv = document.getElementById('ctl00_MyCPH1_tbl_Driver_Adv');

    if (tbl_Driver_Adv.style["display"] == "block") {
        if (document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtAdvPlace').value != '' || document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtAdvDt').value != '' || document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtAdvAmt').value != '' || document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtBranchCode').value != '' || document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtSignature').value != '') {
            if (document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtAdvPlace').value == '') {
                alert("Please Enter Advance Place !!")
                document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtAdvPlace').focus();
                return false;
            }
            if (document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtAdvDt').value == '') {
                alert("Please Enter Advance Date !!")
                document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtAdvDt').focus();
                return false;

            }
            if (document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtAdvAmt').value == '') {
                alert("Please Enter Advance Amount !!")
                document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtAdvAmt').focus();
                return false;
            }
            if (document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtAdvAmt').value <= 0) {
                alert("Amount should be  greater  than zero");
                return false;
            }
            if (document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtBranchCode').value == '') {
                alert("Please Enter Branchcode !!")
                document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtBranchCode').focus();
                return false;
            }
            if (document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtSignature').value == '') {
                alert("Please Enter Advance Payee !!")
                document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtSignature').focus();
                return false;
            }
        }
        if (document.getElementById('ctl00$MyCPH1$UCPayment$txtAmount').value > 0) {
            if (tran.value == "") {
                alert("Select Payment Mode Of Transaction");
                return false;
            }
            if (document.getElementById('ctl00$MyCPH1$UCPayment$dlstAcccode').value == '') {
                alert("Please Select Cash / Bank Account  !!")
                document.getElementById('ctl00$MyCPH1$UCPayment$dlstAcccode').focus();
                return false;
            }
            if (tran.value == "BANK") {
                if (chqno != null) {
                    if (chqno.value == "") {
                        alert("Enter Payment Cheque Number");
                        chqno.focus();
                        return false;
                    }
                }
                if (chqdate != null) {
                    if (chqdate.value == "") {
                        alert("Enter Payment Cheque Date");
                        chqdate.focus();
                        return false;
                    }
                }
                var dlstAcccode = document.getElementById('ctl00$MyCPH1$UCPayment$dlstAcccode');
                if (dlstAcccode != null) {
                    if (dlstAcccode.value == '') {
                        alert("Please Select Payment Bank Name !!")
                        dlstAcccode.focus();
                        return false;
                    }
                }
                var txtAmount = document.getElementById('ctl00$MyCPH1$UCPayment$txtAmount');
                if (txtAmount != null) {
                    if (txtAmount.value == 0) {
                        alert("Please Payment Enter Amount !!")
                        return false;
                    }
                }
            }
            else {
                if (document.getElementById('ctl00$MyCPH1$UCPayment$dlstAcccode').value == '') {
                    alert("Please Select Payment Cash Account !!")
                    return false;
                }
                if (document.getElementById('ctl00$MyCPH1$UCPayment$txtAmount').value == '0.00') {
                    alert("Please Enter Payment Amount !!")
                    return false;
                }
            }
            if (document.getElementById('ctl00_MyCPH1_hdStatKm').value != document.getElementById('ctl00_MyCPH1_txtStartKM').value) {
                alert("User  is changing its present Start Km. of " + document.getElementById('ctl00_MyCPH1_hdStatKm').value)
                return true;
            }
            //--- Trip Advance Amount Check for 'CASH IN HAND'--------------------------------------
            var txtAdvAmt = document.getElementById("ctl00_MyCPH1_dgAdvanceDet_ctl02_txtAdvAmt");
            var txtAdvDt = document.getElementById("ctl00_MyCPH1_dgAdvanceDet_ctl02_txtAdvDt");
            var currentTime = new Date();
            createXMLHttpRequest();
            if (xmlHttpRequest) {
                xmlHttpRequest.onreadystatechange = function () {
                    if (xmlHttpRequest.readyState == 4) {
                        var returnValue = xmlHttpRequest.responseText.split("~");
                        //T or F;
                        if (returnValue[0] == "F") {
                            alert("Transactions halted !!!,No sufficient 'CASH IN HAND' for this Location");
                            document.getElementById("ctl00_MyCPH1_dgAdvanceDet_ctl02_txtAdvAmt").focus();
                            mSubmitCheckFlag = "F";
                            return false;
                        }
                        else {
                            mSubmitCheckFlag = "T";
                        }

                    }
                }
                xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=GetAdvanceAmtCheck&datetime=" + currentTime + "&AdvAmt=" + txtAdvAmt.value + "&AdvDate=" + txtAdvDt.value, false);
                xmlHttpRequest.send(null);
            }
            //----------------------------------------------------------------------------

        }
    }
    if (mSubmitCheckFlag == "F") {
        return false;
    }
    var ConFirmBox = confirm("Are you sure to submit data?");
    if (ConFirmBox == false) {
        return false;
    }
    else {
        document.getElementById('ctl00$MyCPH1$cmdSubmit').style.visibility = "hidden";
    }
    //return false;
}
function changeFocus(obj) {
    document.getElementById('ctl00$MyCPH1$cmdSubmit').focus()
}
function changePayment(obj) {
    alert("OK");
}


function CheckCnoteNo(row_Index, txtCnoteNo, txtBkgDate, txtOriginDestination, txtPackage, txtActualWeight, txtChargedWeight, txtSubTotal, txtCnoteTotal) {
    //alert("Hi1")
    var currentTime = new Date()
    var str_Index = "";

    if (txtCnoteNo.value == "") {
        txtCnoteNo.value = "";
        txtBkgDate.value = "";
        txtOriginDestination.value = "";
        txtPackage.value = "";
        txtActualWeight.value = "";
        txtChargedWeight.value = "";
        txtSubTotal.value = "";
        txtCnoteTotal.value = "";
        return
    }

    for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_gvCnote").rows.length; intIndex++) {
        if (intIndex < 10) {
            str_Index = "0" + intIndex;
        }
        else {
            str_Index = intIndex;
        }
        if (row_Index == intIndex - 2) {
            continue;
        }
        if (document.getElementById("ctl00_MyCPH1_gvCnote_ctl" + str_Index + "_txtCnoteNo").value == txtCnoteNo.value) {
            alert("This Cnote No is already exist at row " + (intIndex - 1));
            txtCnoteNo.value = "";
            //txtCnoteNo.focus();
            return;
        }
    }
    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                //alert(xmlHttpRequest.responseText);
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    alert("Invalid Cnote No");
                    txtCnoteNo.value = "";
                    txtBkgDate.value = "";
                    txtOriginDestination.value = "";
                    txtPackage.value = "";
                    txtActualWeight.value = "";
                    txtChargedWeight.value = "";
                    txtSubTotal.value = "";
                    txtCnoteTotal.value = "";
                    return false;
                }
                else {
                    txtBkgDate.value = returnValue[2];
                    txtOriginDestination.value = returnValue[3];
                    txtPackage.value = returnValue[4];
                    txtActualWeight.value = returnValue[5];
                    txtChargedWeight.value = returnValue[6];
                    txtSubTotal.value = returnValue[7];
                    txtCnoteTotal.value = returnValue[8];
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=GetCnoteDetails&datetime=" + currentTime + "&CnoteNo=" + txtCnoteNo.value, false);
        xmlHttpRequest.send(null);
    }
}