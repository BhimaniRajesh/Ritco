// JScript File

var foo = false;
var Flag = false;
var months = new Array("", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
var months1 = new Array("", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");
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
    //alert(a)
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
            //lblError.innerText = "Invalid Date";
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
        //lblError.innerText = "Issue date  should be  in the  range of selected  financial year!";
        alert("Issue date  should be  in the  range of selected  financial year!");
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
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    lbl_dgAdvanceDet_Err.innerText = "Invalid Branch Code!  Please Enter Valid Branch code!!";
                    txtBranchCode.focus();
                    return false;
                }
                else {
                    if (txtStartLoc.innerText.toUpperCase() != txtBranchCode.value.toUpperCase()) {
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
    //var txtAmount = document.getElementById("ctl00_MyCPH1_UCPayment_txtAmount");
    //var txtAdvAmt = document.getElementById("ctl00_MyCPH1_dgAdvanceDet_ctl02_txtAdvAmt");
    //var hfPaymentAmount = document.getElementById("ctl00_MyCPH1_hfPaymentAmount");
    //txtAmount.value() = (parseFloat(txtAdvAmt.value())).toFixed();
    //hfPaymentAmount.value() = (parseFloat(txtAdvAmt.value())).toFixed();

    var txtAmount = $('#ctl00_MyCPH1_UCPayment_txtAmount').val();
    var txtAdvAmt = $('#ctl00_MyCPH1_dgAdvanceDet_ctl02_txtAdvAmt').val();
    var hfPaymentAmount = $('#ctl00_MyCPH1_hfPaymentAmount').val();
    txtAmount = (parseFloat(txtAdvAmt)).toFixed();
    hfPaymentAmount = (parseFloat(txtAdvAmt)).toFixed();
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


function GetDateDiffInHrs(DateValue1, DateValue2) {
    var a = DateValue1.split("/");
    var b = DateValue2.split("/");
    DateValue1 = a[1] + "/" + a[0] + "/" + a[2];
    DateValue2 = b[1] + "/" + b[0] + "/" + b[2];

    var diff = (new Date(DateValue2).getTime() - new Date(DateValue2).getTime()) / 1000;
    diff /= (60 * 60);
    return Math.abs(Math.round(diff));

}



function IsDateGreaterNew(DateValue1, DateValue2) {
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

    var hfAutoManualTsStatus = document.getElementById("ctl00_MyCPH1_hfAutoManualTsStatus");

    var hfAttached = document.getElementById("ctl00_MyCPH1_hfAttached");

    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "Y") {
                    if (returnValue[8] == "Y") {

                        hfAutoManualTsStatus.value = "Yes";
                    }
                    else {

                        hfAutoManualTsStatus.value = "No";
                    }

                    if (returnValue[5] == "Y") {
                        hfAttached.value = "Y";
                    }
                    else {
                        hfAttached.value = "N";
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
    //var LblDriver1Name = document.getElementById("ctl00_MyCPH1_LblDriver2Name");
    var lblLicno = document.getElementById("ctl00_MyCPH1_lblLicnoD2");
    var lblValidDt = document.getElementById("ctl00_MyCPH1_lblValidDtD2");

    if (txtDriver2.value == "") {
        txtDriver2.value = "";
        hfDriver1ID.value = "";
        lblD1Error.innerText = "";
        //LblDriver1Name.value = "";
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
                        //LblDriver1Name.value = "";
                        lblLicno.value = "";
                        lblValidDt.value = "";
                        txtDriver2.focus();
                        return false;
                    }
                    else {
                        if (returnValue[6] == "In Transit") {
                            lblD1Error.innerText = "Driver is In Transit.";
                            hfDriver1ID.value = "";
                            // LblDriver1Name.value = "";
                            lblLicno.value = "";
                            lblValidDt.value = "";
                            txtDriver1.focus();
                            return false;
                        }
                        else {
                            lblD1Error.innerText = "";
                            txtDriver2.value = returnValue[1];
                            hfDriver1ID.value = returnValue[2];
                            //LblDriver1Name.value = returnValue[3];
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
    var txtHoldFlag = document.getElementById("ctl00_MyCPH1_txtHoldFlag");

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

                        if (hfDriver_photo_Rule.value == "Y" && mDriver_Photo == "" || hfDriverLic_Validity_Rule.value == "Y" && IsDateGreater(hfTodayDate.value, mDriverLic_Validity) || hfDriver_TripCount_Rule.value == "Y" && hfTot_No_Trip.value < mDriver_TripCount) {
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

                            //if (hfDriverLic_Validity_Rule.value == "Y" && mDriverLic_Validity < hfTodayDate.value) {
                            //if (hfDriverLic_Validity_Rule.value == "Y" && IsDateGreater(hfTodayDate.value, mDriverLic_Validity)) {
                            if (hfDriverLic_Validity_Rule.value == "Y" && IsDateGreater(hfTodayDate.value, mDriverLic_Validity) && returnValue[9]) {
                                //alert("Selected Driver's License is \r\nPlease Select Another Driver");
                                // alert("Selected Driver's License is Expired OR License Not Verified\r\nPlease Select Another Driver");
                                var retVal = confirm("Selected Driver's License is Expired OR License Not Verified\r\n Do You Want To continue ?");
                                //hfDriver1ID.value = "";
                                //LblDriver1Name.value = "";
                                //lblLicno.value = "";
                                //lblValidDt.value = "";
                                //txtDriver1.focus();
                                //LblDriverBalance.value = "";
                                if (retVal == true) {
                                    lblD1Error.innerText = "";
                                    txtDriver1.value = returnValue[1];
                                    hfDriver1ID.value = returnValue[2];
                                    LblDriver1Name.value = returnValue[3];
                                    lblLicno.value = returnValue[4];
                                    lblValidDt.value = returnValue[5];
                                    FillDriverBalance(txtDriver1);
                                    txtHoldFlag.value = "Y";
                                    Flag = true;
                                    return true;
                                }
                                else {
                                    txtHoldFlag.value = "N";
                                    return false;
                                }
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

    if (txtDriver1.value == "") {
        txtDriver1 = document.getElementById("ctl00_MyCPH1_txtDriver1");
    }

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
                    LblDriverBalance.value = "0";
                }
            }
        }
        //xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=FillDriverBalance&datetime=" + currentTime + "&txtDate=" + txtDate.value + "&Driver1=" + txtDriver1.value, false);
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=FillDriverBalanceVer1&datetime=" + currentTime + "&txtDate=" + txtDate.value + "&Driver1=" + txtDriver1.value, false);

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


function valid(obj) {
    debugger;
    //var abc = document.getElementById("ctl00_MyCPH1_abc");
    //    $find("CollapsiblePanelExtender3").expandPanel();

    //    alert($find("CollapsiblePanelExtender3"));
    //     $find("CollapsiblePanelExtender3")._doOpen();}

    //    var CollapsiblePanelExtender3 = $find("CollapsiblePanelExtender3");
    //        CollapsiblePanelExtender3.set_Collapsed(true);

    //alert('pnlDriverHdr');


    var tran = document.getElementById('ctl00_MyCPH1_UCPayment_dlsttranstype');
    var chqno = document.getElementById('ctl00_MyCPH1_UCPayment_txtChqNo');
    var chqdate = document.getElementById('ctl00_MyCPH1_UCPayment_txtChqDate');

    var hf_Vehicle_Filter = document.getElementById("ctl00_MyCPH1_hf_Vehicle_Filter");
    var hfAutoManualTsStatus = document.getElementById("ctl00_MyCPH1_hfAutoManualTsStatus");

    var txtManualTripSheetNo = document.getElementById("ctl00_MyCPH1_txtManualTripSheetNo");
    var txtEndLoc = document.getElementById("ctl00_MyCPH1_txtEndLoc");
    var txtVehno = document.getElementById("ctl00_MyCPH1_txtVehno");

    var CollapsiblePanelExtender2 = document.getElementById("ctl00$MyCPH1$CollapsiblePanelExtender2_ClientState");
    var pnlTripSummaryDet = document.getElementById("ctl00_MyCPH1_pnlTripSummaryDet");
    var lblTripHdrError = document.getElementById("ctl00_MyCPH1_lblTripHdrError");
    var pnlTripSummaryHdr = document.getElementById("ctl00_MyCPH1_pnlTripSummaryHdr");

    var gvFuelSlip = document.getElementById("ctl00_MyCPH1_gvFuelSlip");


    if (txtManualTripSheetNo.value == "") {
        alert("Please enter Manual Trip Sheet No.");
        if (pnlTripSummaryHdr.value == "Hide") {
            txtManualTripSheetNo.focus();
        }
        return false;
    }

    if (txtEndLoc.value == "") {
        alert("Please enter End Location");
        //txtEndLoc.focus();
        return false;
    }

    if (txtVehno.value == "") {
        alert("Please enter vehicle number!!!");
        //txtVehno.focus();
        return false;
    }

    var txtDieselCarryForward = document.getElementById("ctl00_MyCPH1_txtDieselCarryForward");
    var txtDieselCarryForwardAmt = document.getElementById("ctl00_MyCPH1_txtDieselCarryForwardAmt");

    if (txtDieselCarryForward != null) {
        if (txtDieselCarryForward.value == "") {
            alert("Please enter Diesel Balance Quantity");
            //txtDieselCarryForward.focus();
            return false;
        }
    }

    if (txtDieselCarryForwardAmt != null) {
        if (txtDieselCarryForwardAmt.value == "") {
            alert("Please enter Diesel Balance Amount");
            //txtDieselCarryForwardAmt.focus();
            return false;
        }
    }

    var ddlDriver1 = document.getElementById("ctl00_MyCPH1_ddlDriver1");
    var ddlDriver2 = document.getElementById("ctl00_MyCPH1_ddlDriver2");
    var ddlCleaner = document.getElementById("ctl00_MyCPH1_ddlCleaner");

    var txtDriver1 = document.getElementById("ctl00_MyCPH1_txtDriver1");
    var txtDriver1NotFromRoster = document.getElementById("ctl00_MyCPH1_txtDriver1NotFromRoster");
    var lblDriver1Licno = document.getElementById("ctl00_MyCPH1_lblDriver1Licno");
    var lblDriver1ValidDt = document.getElementById("ctl00_MyCPH1_lblDriver1ValidDt");

    var txtDriver2 = document.getElementById("ctl00_MyCPH1_txtDriver2");
    var txtDriver2NotFromRoster = document.getElementById("ctl00_MyCPH1_txtDriver2NotFromRoster");
    var lblDriver2Licno = document.getElementById("ctl00_MyCPH1_lblDriver2Licno");
    var lblDriver2ValidDt = document.getElementById("ctl00_MyCPH1_lblDriver2ValidDt");

    var txtCleaner = document.getElementById("ctl00_MyCPH1_txtCleaner");
    var txtCleanerNotFromRoster = document.getElementById("ctl00_MyCPH1_txtCleanerNotFromRoster");
    var lblCleanerLicno = document.getElementById("ctl00_MyCPH1_lblCleanerLicno");
    var lblCleanerValidDt = document.getElementById("ctl00_MyCPH1_lblCleanerValidDt");


    if (ddlDriver1.value != "0") {
        if (ddlDriver1.value == "Y") {
            if (txtDriver1.value == "") {
                alert("Please Enter Driver1!!!");
                //txtDriver1.focus();
                return false;
            }
        }
        if (ddlDriver1.value == "N") {
            if (txtDriver1NotFromRoster.value == "") {
                alert("Please Enter Driver1!!!");
                //txtDriver1NotFromRoster.focus();
                return false;
            }
            if (lblDriver1Licno.value == "") {
                //alert("Please Enter License No. of Driver1!!!");
                //lblDriver1Licno.focus();
                //return false;
            }
            if (lblDriver1ValidDt.value == "") {
                //alert("Please Enter Valid Upto Date of Driver1!!!");
                //lblDriver1ValidDt.focus();
                //return false;
            }
            else {
                var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");
                if (isDate(lblDriver1ValidDt.value)) {
                    if (!IsDateGreater(hfTodayDate.value, lblDriver1ValidDt.value)) {
                        alert("License date must be grater than or equal today's date of Driver1!");
                        //lblDriver1ValidDt.focus();
                        return false;
                    }
                }
                else {
                    alert("Invalid Date of Driver1");
                    //lblDriver1ValidDt.focus();
                    return false;
                }
            }
        }
    }
    else {
        alert("Select Driver1 From Roster Y/N!!!")
        //ddlDriver1.focus();
        return false;
    }
    //alert(ddlDriver2.value);

    //if (ddlDriver2.value != "0") {

    if (ddlDriver2.value != "0") {
        if (ddlDriver2.value == "Y") {
            if (txtDriver2.value == "") {
                alert("Please Enter Driver2!!!");
                //txtDriver2.focus();
                return false;
            }
        }
        if (ddlDriver2.value == "N") {
            if (txtDriver2NotFromRoster.value == "") {
                alert("Please Enter Driver2!!!");
                //txtDriver2NotFromRoster.focus();
                return false;
            }
            if (lblDriver2Licno.value == "") {
                //alert("Please Enter License No. of Driver2!!!");
                //lblDriver2Licno.focus();
                //return false;
            }
            if (lblDriver2ValidDt.value == "") {
                //alert("Please Enter Valid Upto Date of Driver2!!!");
                //lblDriver2ValidDt.focus();
                //return false;
            }
            else {
                var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");
                if (isDate(lblDriver2ValidDt.value)) {
                    if (!IsDateGreater(hfTodayDate.value, lblDriver2ValidDt.value)) {
                        alert("License date must be grater than or equal  today's date of Driver2!");
                        //lblDriver2ValidDt.focus();
                        return false;
                    }
                }
                else {
                    alert("Invalid Date of Driver2!!");
                    //lblDriver2ValidDt.focus();
                    return false;
                }
            }
        }
    }
    else {
        alert("Select Driver2 From Roster Y/N!!!")
        //ddlDriver2.focus();
        return false;
    }

    if (ddlCleaner.value != "0") {
        if (ddlCleaner.value == "Y") {
            if (txtCleaner.value == "") {
                alert("Please Enter Cleaner!!!");
                //txtCleaner.focus();
                return false;
            }
        }
        if (ddlCleaner.value == "N") {
            if (txtCleanerNotFromRoster.value == "") {
                alert("Please Enter Cleaner!!!");
                //txtDriver2NotFromRoster.focus();
                return false;
            }
            //            if (lblCleanerLicno.value == "") {
            //                alert("Please Enter License No. of Cleaner!!!");
            //                //lblDriver2Licno.focus();
            //                return false;
            //            }
            //            if (lblCleanerValidDt.value == "") {
            //                alert("Please Enter Valid Upto Date of Cleaner!!!");
            //                //lblDriver2ValidDt.focus();
            //                return false;
            //            }
        }
    }
    else {
        alert("Select Cleaner From Roster Y/N!!!")
        //ddlCleaner.focus();
        return false;
    }


    var ddlTripBIllingSelection = document.getElementById("ctl00_MyCPH1_ddlTripBIllingSelection");
    var txtCustomer = document.getElementById("ctl00_MyCPH1_txtCustomer");

    if (ddlTripBIllingSelection != null || ddlTripBIllingSelection != null) {
        if (ddlTripBIllingSelection.value == "0" || ddlTripBIllingSelection.value == "") {
            alert("Select Trip Billing Type!!!");
            //ddlRouteType.focus();
            return false;
        }
    }

    if (txtCustomer != null) {
        if (txtCustomer.value == "") {
            alert("Enter Customer!!!");
            //ddlRouteType.focus();
            return false;
        }
    }

    var ddlRouteType = document.getElementById("ctl00_MyCPH1_ddlRouteType");
    var ddlRoute = document.getElementById("ctl00_MyCPH1_ddlRouteName");

    if (ddlRouteType.value == "0") {
        alert("Select Route Type!!!");
        //ddlRouteType.focus();
        return false;
    }
    if (ddlRouteType.value != "0" && txtVehno.value == "") {
        alert("Kindly Select Vehicle No.");
        return false;
    }
    if (ddlRouteType.value == "01") {
        if (ddlRoute.value == "0" || ddlRoute.value == "--Select--" || ddlRoute.value == "-- Select --"
        || ddlRoute.value == "") {
            alert("Kindly Select Trip Route!!!");
            return false;
        }
    }

    var tbl_Driver_Adv = document.getElementById("ctl00_MyCPH1_tbl_Driver_Adv");
    var chkAdvanceFlag = document.getElementById("ctl00_MyCPH1_chkbxAdvacneDetails");
    //if (tbl_Driver_Adv.style["display"] == "block") {
    //if (document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtAdvPlace').value != '' || document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtAdvDt').value != '' || document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtAdvAmt').value != '' || document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtBranchCode').value != '' || document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtSignature').value != '') {
    if (chkAdvanceFlag.checked) {
        if (document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtAdvPlace').value == '') {
            alert("Please Enter Advance Place !!")
            //document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtAdvPlace').focus();
            return false;
        }
        if (document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtAdvDt').value == '') {
            alert("Please Enter Advance Date !!")
            //document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtAdvDt').focus();
            return false;

        }
        if (document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtAdvAmt').value == '') {
            alert("Please Enter Advance Amount !!")
            //document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtAdvAmt').focus();
            return false;
        }
        if (document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtAdvAmt').value <= 0) {
            alert("Amount should be  greater  than zero");
            return false;
        }
        if (document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtBranchCode').value == '') {
            alert("Please Enter Branchcode !!")
            //document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtBranchCode').focus();
            return false;
        }
        if (document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtSignature').value == '') {
            alert("Please Enter Advance Payee !!")
            //document.getElementById('ctl00_MyCPH1_dgAdvancedet_ctl02_txtSignature').focus();
            return false;
        }
        //}
        if (false) {
            if (document.getElementById('ctl00$MyCPH1$UCPayment$txtAmount').value > 0) {
                if (tran.value == "") {
                    alert("Select Payment Mode Of Transaction");
                    return false;
                }
                if (document.getElementById('ctl00$MyCPH1$UCPayment$dlstAcccode').value == '') {
                    alert("Please Select Cash / Bank Account  !!")
                    //document.getElementById('ctl00$MyCPH1$UCPayment$dlstAcccode').focus();
                    return false;
                }
                if (tran.value == "BANK") {
                    if (chqno != null) {
                        if (chqno.value == "") {
                            alert("Enter Payment Cheque Number");
                            //chqno.focus();
                            return false;
                        }
                    }
                    if (chqdate != null) {
                        if (chqdate.value == "") {
                            alert("Enter Payment Cheque Date");
                            //chqdate.focus();
                            return false;
                        }
                    }
                    var dlstAcccode = document.getElementById('ctl00$MyCPH1$UCPayment$dlstAcccode');
                    if (dlstAcccode != null) {
                        if (dlstAcccode.value == '') {
                            alert("Please Select Payment Bank Name !!")
                            //dlstAcccode.focus();
                            return false;
                        }
                    }
                    var txtAmount = document.getElementById('ctl00$MyCPH1$UCPayment$txtAmount');
                    if (txtAmount != null) {
                        if (txtAmount.value == 0) {
                            //alert("Please Payment Enter Amount !!")
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
                //            if (document.getElementById('ctl00_MyCPH1_txtVehOpnKM').value != document.getElementById('ctl00_MyCPH1_txtStartKM').value) {
                //                alert("User  is changing its present Start Km. of " + document.getElementById('ctl00_MyCPH1_txtVehOpnKM').value)
                //                return true;
                //            }

                //alert("Cash");
                //--- Trip Advance Amount Check for 'CASH IN HAND'--------------------------------------
                var txtAdvAmt = document.getElementById("ctl00_MyCPH1_dgAdvanceDet_ctl02_txtAdvAmt");
                var txtAdvDt = document.getElementById("ctl00_MyCPH1_dgAdvanceDet_ctl02_txtAdvDt");

                //alert("txtAdvAmt : " + txtAdvAmt.value);
                //alert("txtAdvDt : " + txtAdvDt.value);

                var currentTime = new Date();
                createXMLHttpRequest();
                if (xmlHttpRequest) {
                    xmlHttpRequest.onreadystatechange = function () {
                        if (xmlHttpRequest.readyState == 4) {
                            //alert("1");
                            //alert("xmlHttpRequest.responseText : " + xmlHttpRequest.responseText);
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
    }

    //if (mSubmitCheckFlag == "F") {
    //    return false;
    //}
    if (gvFuelSlip != null) {
        //alert("1");
        if (gvFuelSlip.rows.length != 0) {
            for (i = 0; i < gvFuelSlip.rows.length - 2; i++) {
                j = i + 2;
                var pref = "";
                if (j < 10) {
                    pref = "ctl00$MyCPH1$gvFuelSlip$ctl0" + j + "$";
                }
                else {
                    pref = "ctl00$MyCPH1$gvFuelSlip$ctl" + j + "$";
                }

                var txtFuelSlipNo = document.getElementById(pref + "txtFuelSlipNo");
                var ddlFuelVendor = document.getElementById(pref + "ddlFuelVendor");
                var txtQtyLiter = document.getElementById(pref + "txtQtyLiter");
                var txtRate = document.getElementById(pref + "txtRate");
                var txtAmount = document.getElementById(pref + "txtAmount");
                var ddlFuelType = document.getElementById(pref + "ddlFuelType");
                if (ddlFuelType.value == "1") {
                    if (txtFuelSlipNo.value == "") {
                        alert("Enter Fuel Slip No.")
                        txtFuelSlipNo.focus();
                        //document.getElementById(pref + "txtFrom").focus();
                        return false;
                    }
                }
                if (ddlFuelVendor.value == "0") {
                    alert("Select Fuel Vendor");
                    ddlFuelVendor.focus();
                    //document.getElementById(pref + "txtTo").focus();
                    return false;
                }
                if (txtQtyLiter.value == "") {
                    alert("Enter Quantity in Liter");
                    txtQtyLiter.focus();
                    //document.getElementById(pref + "txtStartDate").focus();
                    return false;
                }

                if (txtRate.value == "") {
                    alert("Enter Rate");
                    txtRate.focus();
                    //document.getElementById(pref + "tb_StartTime_HH").focus();
                    return false;
                }

                if (txtAmount.value == "") {
                    alert("Enter Amount!!!");
                    txtAmount.focus();
                    return false;
                }

            }
        }
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

function GetVehicleDetails(txtVehno) {
    //debugger;
    var currentTime = new Date();
    // var txtVehno = document.getElementById("ctl00_MyCPH1_txtVehno");
    var txtVehno_Name = document.getElementById("ctl00_MyCPH1_txtVehno_Name");
    var txtVehModel = document.getElementById("ctl00_MyCPH1_txtVehModel");
    var txtVehCategory = document.getElementById("ctl00_MyCPH1_txtVehCategory");
    var txtVehCapacity = document.getElementById("ctl00_MyCPH1_txtVehCapacity");
    var txtVehOpnKM = document.getElementById("ctl00_MyCPH1_txtVehOpnKM");
    var hfVehOpnKM = document.getElementById("ctl00_MyCPH1_hfVehOpnKM");
    var txtVehOpnFuel = document.getElementById("ctl00_MyCPH1_txtVehOpnFuel");
    //var txtVehChecklist = document.getElementById("ctl00_MyCPH1_txtVehChecklist");
    var txtVehOpnFuelAmt = document.getElementById("ctl00_MyCPH1_txtVehOpnFuelAmt");
    var txtVehOpnAddBlue = document.getElementById("ctl00_MyCPH1_txtVehOpnAddBlue");    
    var txtVehOpnAddBlueAmt = document.getElementById("ctl00_MyCPH1_txtVehOpnAddBlueAmt");
    var txtDieselCarryForward = document.getElementById("ctl00_MyCPH1_txtDieselCarryForward");
    var txtDieselCarryForwardAmt = document.getElementById("ctl00_MyCPH1_txtDieselCarryForwardAmt");
    var txtStartLoc = document.getElementById("ctl00_MyCPH1_txtStartLoc");
    var hfVehicleLocation = document.getElementById("ctl00_MyCPH1_hfVehicleLocation");
    var txtVendorName = document.getElementById("ctl00_MyCPH1_txtVendorName");
    var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");
    var txtHoldFlag = document.getElementById("ctl00_MyCPH1_txtHoldFlag");
    if (txtVehno.value == "") {
        txtVehno_Name.value = "";
        txtVehModel.value = "";
        txtVehCategory.value = "";
        txtVehCapacity.value = "";
        txtVehOpnKM.value = "";
        hfVehOpnKM.value = "";
        txtVehOpnFuel.value = "";
        //txtVehChecklist.value = "";
        txtVehOpnFuelAmt.value = "";
        txtVehOpnAddBlue.value = "";
        txtVehOpnAddBlueAmt.value = "";
        if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
            txtDieselCarryForward.value = "";
            txtDieselCarryForwardAmt.value = "";
        }
        txtVendorName.value = "";
        return
    }

    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    //alert("Invalid Vehicle No.")
                    txtVehno.value = "";
                    txtVehno_Name.value = "";
                    txtVehModel.value = "";
                    txtVehCategory.value = "";
                    txtVehCapacity.value = "";
                    txtVehOpnKM.value = "";
                    hfVehOpnKM.value = "";
                    txtVehOpnFuel.value = "";
                    //txtVehChecklist.value = "";
                    txtVehOpnFuelAmt.value = "";
                    txtVehOpnAddBlue.value = "";
                    txtVehOpnAddBlueAmt.value = "";
                    if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                        txtDieselCarryForward.value = "";
                        txtDieselCarryForwardAmt.value = "";
                    }
                    txtVendorName.value = "";
                    txtVehno.focus();
                    return;
                }
                else {
                    var vFitness_Validity_Date = "";
                    var vInsurance_Validity_Date = "";
                    var vRoadTaxDt = "";
                    var vNationalPermitDt = "";



                    var InsuranceValidityDateTripValidation = "";
                    var FitnessValidityDateTripValidation = "";
                    var NationalPermitDtTripValidation = "";
                    var RoadTaxDtTripValidation = "";
                    var FiveYearPermitDtTripValidation = "";
                    var DieselLtrsTripValidation = "";
                    var retValConcat = "";
                    var FiveYearPermitDt = "";
                    vFitness_Validity_Date = returnValue[13];
                    vInsurance_Validity_Date = returnValue[12];
                    vRoadTaxDt = returnValue[14];
                    vNationalPermitDt = returnValue[15];

                    InsuranceValidityDateTripValidation = returnValue[16];
                    FitnessValidityDateTripValidation = returnValue[17];
                    NationalPermitDtTripValidation = returnValue[18];
                    RoadTaxDtTripValidation = returnValue[19];
                    FiveYearPermitDtTripValidation = returnValue[20];
                    DieselLtrsTripValidation = returnValue[21];
                    FiveYearPermitDt = returnValue[22];
                    //alert(vNationalPermitDt);
                    //alert(vRoadTaxDt);
                    //alert(vInsurance_Validity_Date);
                    //alert(vFitness_Validity_Date);
                    //alert(hfVehicleLocation.value);
                    //alert(returnValue[10]);
                    //alert("HI");
                    // alert(hfVehicleLocation.value);
                    if (hfVehicleLocation.value == "CONT_LOC") {
                        //if (hfVehicleLocation.value == "CONT_LOC" || IsDateGreater(hfTodayDate.value, vInsurance_Validity_Date) || IsDateGreater(hfTodayDate.value, vFitness_Validity_Date) || IsDateGreater(hfTodayDate.value, vRoadTaxDt) || IsDateGreater(hfTodayDate.value, vNationalPermitDt)) {
                        // alert(returnValue[2]);
                        if (IsDateGreater(vInsurance_Validity_Date, hfTodayDate.value) || IsDateGreater(vFitness_Validity_Date, hfTodayDate.value) || IsDateGreater(vRoadTaxDt, hfTodayDate.value) || IsDateGreater(vNationalPermitDt, hfTodayDate.value) || IsDateGreater(FiveYearPermitDt, hfTodayDate.value)) {
                            retValConcatl = "Vehicle Insurance_Validity OR Fitness_Validity OR RoadTax OR NationalPermit Date is Expired \n Do You Want To continue ?";
                        }

                        if (IsDateGreater(InsuranceValidityDateTripValidation, vInsurance_Validity_Date)) {
                            if (retValConcat == "")
                            { retValConcat = "Vehicle Insurance Validity Expired" }
                            else {
                                retValConcat = retValConcat + " \n Vehicle Insurance Validity Expired"
                            }
                        }
                        if (IsDateGreater(FitnessValidityDateTripValidation, vFitness_Validity_Date)) {
                            if (retValConcat == "")
                            { retValConcat = "Fitnes Validity Date Expired" }
                            else {
                                retValConcat = retValConcat + " \n Fitnes Validity Date"
                            }
                        }
                        if (IsDateGreater(NationalPermitDtTripValidation, vNationalPermitDt)) {
                            if (retValConcat == "")
                            { retValConcat = "National  Permit Date Expired" }
                            else {
                                retValConcat = retValConcat + " \n National  Permit Date"
                            }
                        }
                        if (IsDateGreater(RoadTaxDtTripValidation, vRoadTaxDt)) {
                            if (retValConcat == "")
                            { retValConcat = "Road Tax Date Expired" }
                            else {
                                retValConcat = retValConcat + " \n Road Tax Date"
                            }
                        }
                        if (IsDateGreater(FiveYearPermitDtTripValidation, FiveYearPermitDt)) {

                            if (retValConcat == "")
                            { retValConcat = "Five Year Permit Date Date Expired" }
                            else {
                                retValConcat = retValConcat + " \n Five Year Permit Date Date"
                            }

                        }
                        if (parseFloat(DieselLtrsTripValidation) < parseFloat(returnValue[7])) {

                            if (retValConcat == "")
                            { retValConcat = "Diesel Ltrs are not valid for  Trip Validation" }
                            else {
                                retValConcat = retValConcat + " \n Diesel Ltrs are not valid for  Trip Validation"
                            }
                        }


                        if (retValConcat == "")
                        { retValConcat = "" }
                        else {
                            retValConcat = retValConcat + " \n Do You Want To continue ?"
                        }


                        var retVal = "";
                        if (txtStartLoc.innerText == returnValue[2].toUpperCase()) {
                            //                            alert("Vehicle Insurance_Validity_Date OR Fitness_Validity_Date OR RoadTax_Date OR NationalPermit_Date is Expired");
                            if (retValConcat == "") {
                                retVal = true
                            }
                            else {
                                retVal = confirm(retValConcat);
                            }
                            if (retVal == true) {
                                txtVehModel.value = returnValue[3];
                                txtVehCategory.value = returnValue[4];
                                txtVehCapacity.value = returnValue[5];
                                txtVehOpnKM.value = returnValue[6];
                                hfVehOpnKM.value = returnValue[6];
                                //txtVehOpnFuel.value = returnValue[7];
                                //txtVehChecklist.value = returnValue[8];
                                //txtVehOpnFuelAmt.value = returnValue[9];
                                if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                                    txtDieselCarryForward.value = returnValue[7];
                                    txtDieselCarryForwardAmt.value = returnValue[8];
                                }
                                txtVendorName.value = returnValue[11];
                                Flag = true;
                            }
                            return false;

                        }
                        else {
                            alert("Vehicle's Controlling Location is not from " + txtStartLoc.innerText + " branch");
                            txtVehno.value = "";
                            txtVehno_Name.value = "";
                            txtVehModel.value = "";
                            txtVehCategory.value = "";
                            txtVehCapacity.value = "";
                            txtVehOpnKM.value = "";
                            hfVehOpnKM.value = "";
                            txtVehOpnFuel.value = "";
                            //txtVehChecklist.value = "";
                            txtVehOpnFuelAmt.value = "";
                            txtVehOpnAddBlue.value = "";
                            txtVehOpnAddBlueAmt.value = "";
                            if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                                txtDieselCarryForward.value = "";
                                txtDieselCarryForwardAmt.value = "";
                            }
                            txtVendorName.value = "";
                            txtVehno.focus();
                        }
                    }
                        //else if (hfVehicleLocation.value == "CUR_LOC") {
                    else if (hfVehicleLocation.value == "CUR_LOC" || IsDateGreater(hfTodayDate.value, vInsurance_Validity_Date) || IsDateGreater(hfTodayDate.value, vFitness_Validity_Date) || IsDateGreater(hfTodayDate.value, vRoadTaxDt) || IsDateGreater(hfTodayDate.value, vNationalPermitDt)) {
                        if (txtStartLoc.innerText == returnValue[9]) {
                            //alert("Vehicle Insurance_Validity_Date OR Fitness_Validity_Date OR RoadTax_Date OR NationalPermit_Date is Expired");
                            var retVal = confirm("Vehicle Insurance_Validity OR Fitness_Validity OR RoadTax OR NationalPermit Date is Expired \n Do You Want To continue ?");
                            if (retVal == true) {

                                txtVehModel.value = returnValue[3];
                                txtVehCategory.value = returnValue[4];
                                txtVehCapacity.value = returnValue[5];
                                txtVehOpnKM.value = returnValue[6];
                                hfVehOpnKM.value = returnValue[6];
                                //txtVehOpnFuel.value = returnValue[7];
                                //txtVehChecklist.value = returnValue[8];
                                //txtVehOpnFuelAmt.value = returnValue[9];
                                if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                                    txtDieselCarryForward.value = returnValue[7];
                                    txtDieselCarryForwardAmt.value = returnValue[8];
                                }
                                txtVendorName.value = returnValue[11];
                                Flag = true;
                            }
                            else {
                                return false;
                            }
                        }
                        else {
                            alert("Vehicle's Current Location is not from " + txtStartLoc.innerText + " branch");
                            txtVehno.value = "";
                            txtVehno_Name.value = "";
                            txtVehModel.value = "";
                            txtVehCategory.value = "";
                            txtVehCapacity.value = "";
                            txtVehOpnKM.value = "";
                            hfVehOpnKM.value = "";
                            txtVehOpnFuel.value = "";
                            //txtVehChecklist.value = "";
                            txtVehOpnFuelAmt.value = "";
                            txtVehOpnAddBlue.value = "";
                            txtVehOpnAddBlueAmt.value = "";
                            if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                                txtDieselCarryForward.value = "";
                                txtDieselCarryForwardAmt.value = "";
                            }
                            txtVendorName.value = "";
                            txtVehno.focus();
                        }
                    }
                        //else if (hfVehicleLocation.value == "NONE") {
                    else if (hfVehicleLocation.value == "NONE" || IsDateGreater(hfTodayDate.value, vInsurance_Validity_Date) || IsDateGreater(hfTodayDate.value, vFitness_Validity_Date) || IsDateGreater(hfTodayDate.value, vRoadTaxDt) || IsDateGreater(hfTodayDate.value, vNationalPermitDt)) {
                        //alert("Vehicle Insurance_Validity_Date OR Fitness_Validity_Date OR RoadTax_Date OR NationalPermit_Date is Expired");
                        var retVal = confirm("Vehicle Insurance_Validity OR Fitness_Validity OR RoadTax OR NationalPermit Date is Expired \n Do You Want To continue ?");
                        if (retVal == true) {
                            txtVehModel.value = returnValue[3];
                            txtVehCategory.value = returnValue[4];
                            txtVehCapacity.value = returnValue[5];
                            txtVehOpnKM.value = returnValue[6];
                            hfVehOpnKM.value = returnValue[6];
                            //txtVehOpnFuel.value = returnValue[7];
                            //txtVehChecklist.value = returnValue[8];
                            //txtVehOpnFuelAmt.value = returnValue[9];
                            if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                                txtDieselCarryForward.value = returnValue[7];
                                txtDieselCarryForwardAmt.value = returnValue[8];
                            }
                            txtVendorName.value = returnValue[11];
                            Flag = true;
                        }
                        else {
                            return false;
                        }
                    }
                    if (returnValue[10] == "In Transit") {
                        alert("Vehicle is in Transit Mode \r\n Kindly Select Another Vehicle.");
                        txtVehno.value = "";
                        txtVehno_Name.value = "";
                        txtVehModel.value = "";
                        txtVehCategory.value = "";
                        txtVehCapacity.value = "";
                        txtVehOpnKM.value = "";
                        hfVehOpnKM.value = "";
                        txtVehOpnFuel.value = "";
                        //txtVehChecklist.value = "";
                        txtVehOpnFuelAmt.value = "";
                        txtVehOpnAddBlue.value = "";
                        txtVehOpnAddBlueAmt.value = "";
                        if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                            txtDieselCarryForward.value = "";
                            txtDieselCarryForwardAmt.value = "";
                        }
                        txtVendorName.value = "";
                        txtVehno.focus();
                    }

                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=FillVehicleDetails&datetime=" + currentTime + "&Vehno=" + txtVehno.value, false);
        xmlHttpRequest.send(null);
    }
}
/*
function GetVehicleDetailsMaster(txtVehno) {
    //debugger;
    var currentTime = new Date();
    // var txtVehno = document.getElementById("ctl00_MyCPH1_txtVehno");
    var txtVehno_Name = document.getElementById("ctl00_MyCPH1_txtVehno_Name");
    var txtVehModel = document.getElementById("ctl00_MyCPH1_txtVehModel");
    var txtVehCategory = document.getElementById("ctl00_MyCPH1_txtVehCategory");
    var txtVehCapacity = document.getElementById("ctl00_MyCPH1_txtVehCapacity");
    var txtVehOpnKM = document.getElementById("ctl00_MyCPH1_txtVehOpnKM");
    var hfVehOpnKM = document.getElementById("ctl00_MyCPH1_hfVehOpnKM");
    var txtVehOpnFuel = document.getElementById("ctl00_MyCPH1_txtVehOpnFuel");
    //var txtVehChecklist = document.getElementById("ctl00_MyCPH1_txtVehChecklist");
    var txtVehOpnFuelAmt = document.getElementById("ctl00_MyCPH1_txtVehOpnFuelAmt");
    var txtDieselCarryForward = document.getElementById("ctl00_MyCPH1_txtDieselCarryForward");
    var txtDieselCarryForwardAmt = document.getElementById("ctl00_MyCPH1_txtDieselCarryForwardAmt");
    var txtStartLoc = document.getElementById("ctl00_MyCPH1_txtStartLoc");
    var hfVehicleLocation = document.getElementById("ctl00_MyCPH1_hfVehicleLocation");
    var txtVendorName = document.getElementById("ctl00_MyCPH1_txtVendorName");
    var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");
    var txtHoldFlag = document.getElementById("ctl00_MyCPH1_txtHoldFlag");

    var hidFitnessValidation = document.getElementById("ctl00_MyCPH1_hidFitnessValidation").value = "";
    var hidFitnessExpiryDate = document.getElementById("ctl00_MyCPH1_hidFitnessExpiryDate").value = "";
    var hidFitnessGraceDays = document.getElementById("ctl00_MyCPH1_hidFitnessGraceDays").value = "";
    var hidNationalPermitValidation = document.getElementById("ctl00_MyCPH1_hidNationalPermitValidation").value = "";
    var hidNationalPermitExpiryDate = document.getElementById("ctl00_MyCPH1_hidNationalPermitExpiryDate").value = "";
    var hidNationalPermitGraceDays = document.getElementById("ctl00_MyCPH1_hidNationalPermitGraceDays").value = "";
    var hid5YrPermitValidation = document.getElementById("ctl00_MyCPH1_hid5YrPermitValidation").value = "";
    var hid5YrPermitExpiryDate = document.getElementById("ctl00_MyCPH1_hid5YrPermitExpiryDate").value = "";
    var hid5YrPermitGraceDays = document.getElementById("ctl00_MyCPH1_hid5YrPermitGraceDays").value = "";
    var hidInsuranceValidation = document.getElementById("ctl00_MyCPH1_hidInsuranceValidation").value = "";
    var hidInsuranceExpiryDate = document.getElementById("ctl00_MyCPH1_hidInsuranceExpiryDate").value = "";
    var hidInsuranceGraceDays = document.getElementById("ctl00_MyCPH1_hidInsuranceGraceDays").value = "";
    var hidRoadTaxValidation = document.getElementById("ctl00_MyCPH1_hidRoadTaxValidation").value = "";
    var hidRoadTaxExpiryDate = document.getElementById("ctl00_MyCPH1_hidRoadTaxExpiryDate").value = "";
    var hidRoadTaxGraceDays = document.getElementById("ctl00_MyCPH1_hidRoadTaxGraceDays").value = "";
    var hidDieselLiterValidation = document.getElementById("ctl00_MyCPH1_hidDieselLiterValidation").value = "";
    var hidDieselLiter = document.getElementById("ctl00_MyCPH1_hidDieselLiter").value = "";
    var hidDieselLiterGrace = document.getElementById("ctl00_MyCPH1_hidDieselLiterGrace").value = "";
    var retValConcatl = "";
    if (txtVehno.value == "") {
        txtVehno_Name.value = "";
        txtVehModel.value = "";
        txtVehCategory.value = "";
        txtVehCapacity.value = "";
        txtVehOpnKM.value = "";
        hfVehOpnKM.value = "";
        txtVehOpnFuel.value = "";
        //txtVehChecklist.value = "";
        txtVehOpnFuelAmt.value = "";
        if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
            txtDieselCarryForward.value = "";
            txtDieselCarryForwardAmt.value = "";
        }
        txtVendorName.value = "";
        return
    }

    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    //alert("Invalid Vehicle No.")
                    txtVehno.value = "";
                    txtVehno_Name.value = "";
                    txtVehModel.value = "";
                    txtVehCategory.value = "";
                    txtVehCapacity.value = "";
                    txtVehOpnKM.value = "";
                    hfVehOpnKM.value = "";
                    txtVehOpnFuel.value = "";
                    //txtVehChecklist.value = "";
                    txtVehOpnFuelAmt.value = "";
                    if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                        txtDieselCarryForward.value = "";
                        txtDieselCarryForwardAmt.value = "";
                    }
                    txtVendorName.value = "";
                    //txtVehno.focus();
                    return;
                }
                else {
                    var vFitness_Validity_Date = "";
                    var vInsurance_Validity_Date = "";
                    var vRoadTaxDt = "";
                    var vNationalPermitDt = "";

                    var InsuranceValidityDateTripValidation = "";
                    var FitnessValidityDateTripValidation = "";
                    var NationalPermitDtTripValidation = "";
                    var RoadTaxDtTripValidation = "";
                    var FiveYearPermitDtTripValidation = "";
                    var DieselLtrsTripValidation = "";
                    var retValConcat = "";
                    var FiveYearPermitDt = "";
                    var InsuranceDays = "0";
                    var FitnessDays = "0";
                    var NationalPermitDays = "0";
                    var RoadTaxDays = "0";
                    var FiveYearPermitDays = "0";
                    vFitness_Validity_Date = returnValue[13];
                    vInsurance_Validity_Date = returnValue[12];
                    vRoadTaxDt = returnValue[14];
                    vNationalPermitDt = returnValue[15];

                    InsuranceValidityDateTripValidation = returnValue[16];
                    FitnessValidityDateTripValidation = returnValue[17];
                    NationalPermitDtTripValidation = returnValue[18];
                    RoadTaxDtTripValidation = returnValue[19];
                    FiveYearPermitDtTripValidation = returnValue[20];
                    DieselLtrsTripValidation = returnValue[21];
                    FiveYearPermitDt = returnValue[22];
                    InsuranceDays = returnValue[23];
                    FitnessDays = returnValue[24];
                    NationalPermitDays = returnValue[25];
                    RoadTaxDays = returnValue[26];
                    FiveYearPermitDays = returnValue[27];
                    //alert(vNationalPermitDt);
                    //alert(vRoadTaxDt);
                    //alert(vInsurance_Validity_Date);
                    //alert(vFitness_Validity_Date);
                    //alert(hfVehicleLocation.value);
                    //alert(returnValue[10]);
                    //alert("HI");
                    // alert(hfVehicleLocation.value);
                    //if (returnValue[28] != "0") {
                    //    alert("Please approve pending request. Request ID:- " + returnValue[29]);
                    //    txtVehno.value = "";
                    //    txtVehno_Name.value = "";
                    //    txtVehModel.value = "";
                    //    txtVehCategory.value = "";
                    //    txtVehCapacity.value = "";
                    //    txtVehOpnKM.value = "";
                    //    txtVehOpnFuel.value = "";
                    //    txtVehOpnFuelAmt.value = "";
                    //    if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                    //        txtDieselCarryForward.value = "";
                    //        txtDieselCarryForwardAmt.value = "";
                    //    }
                    //    txtVendorName.value = "";
                    //    txtVehno.focus();
                    //    return false;
                    //}
                    if (!GetVehicleRequestGenerated(txtVehno)) {
                        txtVehno.value = "";
                        txtVehno_Name.value = "";
                        txtVehno.focus();
                        return false;
                    }
                    if (hfVehicleLocation.value == "CONT_LOC") {
                        //if (hfVehicleLocation.value == "CONT_LOC" || IsDateGreater(hfTodayDate.value, vInsurance_Validity_Date) || IsDateGreater(hfTodayDate.value, vFitness_Validity_Date) || IsDateGreater(hfTodayDate.value, vRoadTaxDt) || IsDateGreater(hfTodayDate.value, vNationalPermitDt)) {
                        // alert(returnValue[2]);
                        //if (IsDateGreater(hfTodayDate.value, vInsurance_Validity_Date) || IsDateGreater(hfTodayDate.value, vFitness_Validity_Date) || IsDateGreater(hfTodayDate.value, vRoadTaxDt) || IsDateGreater(hfTodayDate.value, vNationalPermitDt) || IsDateGreater(hfTodayDate.value, FiveYearPermitDt)) {
                        //    retValConcatl = "Vehicle Insurance Validity\nFitness Validity\nRoad Tax\nNational Permit\nDate is Expired.";
                        //}
                        if (IsDateGreater(hfTodayDate.value, returnValue[30]) && (returnValue[28] == "0") && (returnValue[29] == "") && (returnValue[30] != "")) {
                        }
                        else {
                            if (IsDateGreater(vInsurance_Validity_Date, hfTodayDate.value)) {
                                if (retValConcatl == "")
                                { retValConcat = "Vehicle Insurance Validity Expired."; }
                                else { retValConcatl = retValConcatl + "\nVehicle Insurance Validity Expired."; }
                            }
                        }
                        if (IsDateGreater(hfTodayDate.value, returnValue[31]) && (returnValue[28] == "0") && (returnValue[29] == "") && (returnValue[31] != "")) {
                        }
                        else {
                            if (IsDateGreater(vFitness_Validity_Date, hfTodayDate.value)) {
                                if (retValConcatl == "")
                                { retValConcat = "Fitnes Validity Date Expired."; }
                                else {
                                    retValConcatl = retValConcatl + "\nFitnes Validity Date Expired.";
                                }
                            }
                        }
                        if (IsDateGreater(hfTodayDate.value, returnValue[32]) && (returnValue[28] == "0") && (returnValue[29] == "") && (returnValue[32] != "")) {
                        }
                        else {
                            if (IsDateGreater(vNationalPermitDt, hfTodayDate.value)) {
                                if (retValConcatl == "")
                                { retValConcatl = "National Permit Date Expired."; }
                                else {
                                    retValConcatl = retValConcatl + "\nNational Permit Date Expired.";
                                }
                            }
                        }
                        if (IsDateGreater(hfTodayDate.value, returnValue[33]) && (returnValue[28] == "0") && (returnValue[29] == "") && (returnValue[33] != "")) {
                        }
                        else {
                            if (IsDateGreater(vRoadTaxDt, hfTodayDate.value)) {
                                if (retValConcatl == "")
                                { retValConcatl = "Road Tax Date Expired."; }
                                else {
                                    retValConcatl = retValConcatl + "\nRoad Tax Date Expired.";
                                }
                            }
                        }
                        if (!IsDateGreater(hfTodayDate.value, returnValue[34]) && (returnValue[28] == "0") && (returnValue[29] == "") && (returnValue[34] != "")) {
                        }
                        else {
                            if (IsDateGreater(FiveYearPermitDt, hfTodayDate.value)) {

                                if (retValConcatl == "")
                                { retValConcatl = "Five Year Permit Date Expired."; }
                                else {
                                    retValConcatl = retValConcatl + "\nFive Year Permit Date Expired.";
                                }
                            }
                        }
                        if (IsDateGreater(hfTodayDate.value, returnValue[30]) && (returnValue[28] == "0") && (returnValue[29] == "") && (returnValue[30] != "")) {
                        }
                        else {
                            if (IsDateGreater(InsuranceValidityDateTripValidation, hfTodayDate.value)) {
                                if (retValConcat == "")
                                { retValConcat = "Vehicle Insurance Validity Expired. Expired Date:-" + vInsurance_Validity_Date + ".Grace Days:-" + InsuranceDays }
                                else {
                                    retValConcat = retValConcat + "\nVehicle Insurance Validity Expired. Expired Date:-" + vInsurance_Validity_Date + ".Grace Days:-" + InsuranceDays
                                }
                                hidInsuranceValidation = "Vehicle Insurance Validity Expired. Expired Date:-" + vInsurance_Validity_Date + ".Grace Days:-" + InsuranceDays;
                                hidInsuranceExpiryDate = vInsurance_Validity_Date;
                                hidInsuranceGraceDays = InsuranceDays;
                            }
                        }
                        if (IsDateGreater(hfTodayDate.value, returnValue[31]) && (returnValue[28] == "0") && (returnValue[29] == "") && (returnValue[31] != "")) {
                        }
                        else {
                            if (IsDateGreater(FitnessValidityDateTripValidation, hfTodayDate.value)) {
                                if (retValConcat == "")
                                { retValConcat = "Fitnes Validity Date Expired. Expired Date:-" + vFitness_Validity_Date + ".Grace Days:-" + FitnessDays }
                                else {
                                    retValConcat = retValConcat + "\nFitnes Validity Date Expired. Expired Date:-" + vFitness_Validity_Date + ".Grace Days:-" + FitnessDays
                                }
                                hidFitnessValidation = "Fitnes Validity Date Expired. Expired Date:-" + vFitness_Validity_Date + ".Grace Days:-" + FitnessDays
                                hidFitnessExpiryDate = vFitness_Validity_Date;
                                hidFitnessGraceDays = FitnessDays;
                            }
                        }
                        if (IsDateGreater(hfTodayDate.value, returnValue[32]) && (returnValue[28] == "0") && (returnValue[29] == "") && (returnValue[32] != "")) {
                        }
                        else {
                            if (IsDateGreater(NationalPermitDtTripValidation, hfTodayDate.value)) {
                                if (retValConcat == "")
                                { retValConcat = "National Permit Date Expired. Expired Date:-" + vNationalPermitDt + ".Grace Days:-" + NationalPermitDays }
                                else {
                                    retValConcat = retValConcat + "\nNational Permit Date Expired. Expired Date:-" + vNationalPermitDt + ".Grace Days:-" + NationalPermitDays
                                }
                                hidNationalPermitValidation = "National Permit Date Expired. Expired Date:-" + vNationalPermitDt + ".Grace Days:-" + NationalPermitDays
                                hidNationalPermitExpiryDate = vNationalPermitDt;
                                hidNationalPermitGraceDays = NationalPermitDays;
                            }
                        }
                        if (IsDateGreater(hfTodayDate.value, returnValue[33]) && (returnValue[28] == "0") && (returnValue[29] == "") && (returnValue[33] != "")) {
                        }
                        else {
                            if (IsDateGreater(RoadTaxDtTripValidation, hfTodayDate.value)) {
                                if (retValConcat == "")
                                { retValConcat = "Road Tax Date Expired. Expired Date:-" + vRoadTaxDt + ".Grace Days:-" + RoadTaxDays }
                                else {
                                    retValConcat = retValConcat + "\nRoad Tax Date Expired. Expired Date:-" + vRoadTaxDt + ".Grace Days:-" + RoadTaxDays
                                }
                                hidRoadTaxValidation = "Road Tax Date Expired. Expired Date:-" + vRoadTaxDt + ".Grace Days:-" + RoadTaxDays
                                hidRoadTaxExpiryDate = vRoadTaxDt;
                                hidRoadTaxGraceDays = RoadTaxDays;
                            }
                        }
                        if (IsDateGreater(hfTodayDate.value, returnValue[34]) && (returnValue[28] == "0") && (returnValue[29] == "") && (returnValue[34] != "")) {
                        }
                        else {
                            if (IsDateGreater(FiveYearPermitDtTripValidation, hfTodayDate.value)) {

                                if (retValConcat == "")
                                { retValConcat = "Five Year Permit Date Expired. Expired Date:-" + FiveYearPermitDt + ".Grace Days:-" + FiveYearPermitDays }
                                else {
                                    retValConcat = retValConcat + "\nFive Year Permit Date Expired. Expired Date:-" + FiveYearPermitDt + ".Grace Days:-" + FiveYearPermitDays
                                }
                                hid5YrPermitValidation = "Five Year Permit Date Expired. Expired Date:-" + FiveYearPermitDt + ".Grace Days:-" + FiveYearPermitDays
                                hid5YrPermitExpiryDate = FiveYearPermitDt;
                                hid5YrPermitGraceDays = FiveYearPermitDays;
                            }
                        }
                        if (parseFloat(DieselLtrsTripValidation) < parseFloat(returnValue[7])) {

                            if (retValConcat == "")
                            { retValConcat = "Diesel Ltrs are not valid for Trip Validation. Diesel Ltrs:-" + returnValue[7] }
                            else {
                                retValConcat = retValConcat + "\nDiesel Ltrs are not valid for Trip Validation. Diesel Ltrs:-" + returnValue[7]
                            }
                            hidDieselLiterValidation = "Diesel Ltrs are not valid for Trip Validation. Diesel Ltrs:-" + returnValue[7]
                            hidDieselLiter = DieselLtrsTripValidation;
                            hidDieselLiterGrace = returnValue[7];
                        }
                        if (retValConcat == "")
                        { retValConcat = "" }
                        else {
                            retValConcat = retValConcat + "\n Do You Want To Send for Validation ?"
                        }
                        var retVal = "";
                        if (txtStartLoc.innerText == returnValue[2].toUpperCase()) {
                            //                            alert("Vehicle Insurance_Validity_Date OR Fitness_Validity_Date OR RoadTax_Date OR NationalPermit_Date is Expired");
                            if (retValConcat == "") {
                                retVal = true
                            }
                            else {
                                if (retValConcatl != "") {
                                    alert(retValConcatl);
                                    txtVehno.value = "";
                                    txtVehno_Name.value = "";
                                    retVal = false;
                                }
                                else {
                                    retVal = confirm(retValConcat);
                                }
                            }
                            if (retVal == true) {
                                txtVehModel.value = returnValue[3];
                                txtVehCategory.value = returnValue[4];
                                txtVehCapacity.value = returnValue[5];
                                txtVehOpnKM.value = returnValue[6];
                                hfVehOpnKM.value = returnValue[6];
                                //txtVehOpnFuel.value = returnValue[7];
                                //txtVehChecklist.value = returnValue[8];
                                //txtVehOpnFuelAmt.value = returnValue[9];
                                if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                                    txtDieselCarryForward.value = returnValue[7];
                                    txtDieselCarryForwardAmt.value = returnValue[8];
                                }
                                txtVendorName.value = returnValue[11];
                                var twoD = new Array();
                                twoD[1] = new Array();
                                twoD[1]['Validation'] = hidFitnessValidation;
                                twoD[1]['ExpiryDate'] = hidFitnessExpiryDate;
                                twoD[1]['GraceDays'] = hidFitnessGraceDays;
                                twoD[1]['Document'] = "Fitness";

                                twoD[2] = new Array();
                                twoD[2]['Validation'] = hidNationalPermitValidation;
                                twoD[2]['ExpiryDate'] = hidNationalPermitExpiryDate;
                                twoD[2]['GraceDays'] = hidNationalPermitGraceDays;
                                twoD[2]['Document'] = "NationalPermit";

                                twoD[3] = new Array();
                                twoD[3]['Validation'] = hid5YrPermitValidation;
                                twoD[3]['ExpiryDate'] = hid5YrPermitExpiryDate;
                                twoD[3]['GraceDays'] = hid5YrPermitGraceDays;
                                twoD[3]['Document'] = "5YrPermit";

                                twoD[4] = new Array();
                                twoD[4]['Validation'] = hidInsuranceValidation;
                                twoD[4]['ExpiryDate'] = hidInsuranceExpiryDate;
                                twoD[4]['GraceDays'] = hidInsuranceGraceDays;
                                twoD[4]['Document'] = "Insurance";

                                twoD[5] = new Array();
                                twoD[5]['Validation'] = hidRoadTaxValidation;
                                twoD[5]['ExpiryDate'] = hidRoadTaxExpiryDate;
                                twoD[5]['GraceDays'] = hidRoadTaxGraceDays;
                                twoD[5]['Document'] = "RoadTax";

                                twoD[6] = new Array();
                                twoD[6]['Validation'] = hidDieselLiterValidation;
                                twoD[6]['ExpiryDate'] = hidDieselLiter;
                                twoD[6]['GraceDays'] = hidDieselLiterGrace;
                                twoD[6]['Document'] = "DieselLiter";
                                if (retValConcat != "") {
                                    if (PushVehicleRequest(twoD)) {
                                        //alert("Request Generated. Request No:-" + document.getElementById("ctl00_MyCPH1_hidRequestID").value);
                                        alert("Request Sent Successfully for validation");
                                        txtVehno.value = "";
                                        txtVehno_Name.value = "";
                                        txtVehModel.value = "";
                                        txtVehCategory.value = "";
                                        txtVehCapacity.value = "";
                                        txtVehOpnKM.value = "";
                                        hfVehOpnKM.value = "";
                                        txtVehOpnFuel.value = "";
                                        //txtVehChecklist.value = "";
                                        txtVehOpnFuelAmt.value = "";
                                        if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                                            txtDieselCarryForward.value = "";
                                            txtDieselCarryForwardAmt.value = "";
                                        }
                                        txtVendorName.value = "";
                                        txtVehno.focus();
                                        Flag = true;
                                    }
                                    else {
                                        alert("Request Failed");
                                        txtVehno.value = "";
                                        txtVehno_Name.value = "";
                                        txtVehModel.value = "";
                                        txtVehCategory.value = "";
                                        txtVehCapacity.value = "";
                                        txtVehOpnKM.value = "";
                                        hfVehOpnKM.value = "";
                                        txtVehOpnFuel.value = "";
                                        //txtVehChecklist.value = "";
                                        txtVehOpnFuelAmt.value = "";
                                        if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                                            txtDieselCarryForward.value = "";
                                            txtDieselCarryForwardAmt.value = "";
                                        }
                                        txtVendorName.value = "";
                                        txtVehno.focus();
                                        return false;
                                    }
                                }
                            }
                            return false;

                        }
                        else {
                            alert("Vehicle's Controlling Location is not from " + txtStartLoc.innerText + " branch");
                            txtVehno.value = "";
                            txtVehno_Name.value = "";
                            txtVehModel.value = "";
                            txtVehCategory.value = "";
                            txtVehCapacity.value = "";
                            txtVehOpnKM.value = "";
                            hfVehOpnKM.value = "";
                            txtVehOpnFuel.value = "";
                            //txtVehChecklist.value = "";
                            txtVehOpnFuelAmt.value = "";
                            if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                                txtDieselCarryForward.value = "";
                                txtDieselCarryForwardAmt.value = "";
                            }
                            txtVendorName.value = "";
                            txtVehno.focus();
                        }
                    }
                        //else if (hfVehicleLocation.value == "CUR_LOC") {
                    else if (hfVehicleLocation.value == "CUR_LOC" || IsDateGreater(hfTodayDate.value, vInsurance_Validity_Date) || IsDateGreater(hfTodayDate.value, vFitness_Validity_Date) || IsDateGreater(hfTodayDate.value, vRoadTaxDt) || IsDateGreater(hfTodayDate.value, vNationalPermitDt)) {
                        if (txtStartLoc.innerText == returnValue[9]) {
                            //alert("Vehicle Insurance_Validity_Date OR Fitness_Validity_Date OR RoadTax_Date OR NationalPermit_Date is Expired");
                            var retVal = confirm("Vehicle Insurance_Validity OR Fitness_Validity OR RoadTax OR NationalPermit Date is Expired \n Do You Want To continue ?");
                            if (retVal == true) {

                                txtVehModel.value = returnValue[3];
                                txtVehCategory.value = returnValue[4];
                                txtVehCapacity.value = returnValue[5];
                                txtVehOpnKM.value = returnValue[6];
                                hfVehOpnKM.value = returnValue[6];
                                //txtVehOpnFuel.value = returnValue[7];
                                //txtVehChecklist.value = returnValue[8];
                                //txtVehOpnFuelAmt.value = returnValue[9];
                                if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                                    txtDieselCarryForward.value = returnValue[7];
                                    txtDieselCarryForwardAmt.value = returnValue[8];
                                }
                                txtVendorName.value = returnValue[11];
                                Flag = true;
                            }
                            else {
                                return false;
                            }
                        }
                        else {
                            alert("Vehicle's Current Location is not from " + txtStartLoc.innerText + " branch");
                            txtVehno.value = "";
                            txtVehno_Name.value = "";
                            txtVehModel.value = "";
                            txtVehCategory.value = "";
                            txtVehCapacity.value = "";
                            txtVehOpnKM.value = "";
                            hfVehOpnKM.value = "";
                            txtVehOpnFuel.value = "";
                            //txtVehChecklist.value = "";
                            txtVehOpnFuelAmt.value = "";
                            if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                                txtDieselCarryForward.value = "";
                                txtDieselCarryForwardAmt.value = "";
                            }
                            txtVendorName.value = "";
                            txtVehno.focus();
                        }
                    }
                        //else if (hfVehicleLocation.value == "NONE") {
                    else if (hfVehicleLocation.value == "NONE" || IsDateGreater(hfTodayDate.value, vInsurance_Validity_Date) || IsDateGreater(hfTodayDate.value, vFitness_Validity_Date) || IsDateGreater(hfTodayDate.value, vRoadTaxDt) || IsDateGreater(hfTodayDate.value, vNationalPermitDt)) {
                        //alert("Vehicle Insurance_Validity_Date OR Fitness_Validity_Date OR RoadTax_Date OR NationalPermit_Date is Expired");
                        var retVal = confirm("Vehicle Insurance_Validity OR Fitness_Validity OR RoadTax OR NationalPermit Date is Expired \n Do You Want To continue ?");
                        if (retVal == true) {
                            txtVehModel.value = returnValue[3];
                            txtVehCategory.value = returnValue[4];
                            txtVehCapacity.value = returnValue[5];
                            txtVehOpnKM.value = returnValue[6];
                            hfVehOpnKM.value = returnValue[6];
                            //txtVehOpnFuel.value = returnValue[7];
                            //txtVehChecklist.value = returnValue[8];
                            //txtVehOpnFuelAmt.value = returnValue[9];
                            if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                                txtDieselCarryForward.value = returnValue[7];
                                txtDieselCarryForwardAmt.value = returnValue[8];
                            }
                            txtVendorName.value = returnValue[11];
                            Flag = true;
                        }
                        else {
                            return false;
                        }
                    }
                    if (returnValue[10] == "In Transit") {
                        alert("Vehicle is in Transit Mode \r\n Kindly Select Another Vehicle.");
                        txtVehno.value = "";
                        txtVehno_Name.value = "";
                        txtVehModel.value = "";
                        txtVehCategory.value = "";
                        txtVehCapacity.value = "";
                        txtVehOpnKM.value = "";
                        hfVehOpnKM.value = "";
                        txtVehOpnFuel.value = "";
                        //txtVehChecklist.value = "";
                        txtVehOpnFuelAmt.value = "";
                        if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                            txtDieselCarryForward.value = "";
                            txtDieselCarryForwardAmt.value = "";
                        }
                        txtVendorName.value = "";
                        txtVehno.focus();
                    }

                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=FillVehicleDetailsMaster&datetime=" + currentTime + "&Vehno=" + txtVehno.value, false);
        xmlHttpRequest.send(null);
    }
}
*/
function GetVehicleDetailsMaster(txtVehno) {

    if (txtVehno.value == "") {
        return false;
    }

    var currentTime = new Date();
    // var txtVehno = document.getElementById("ctl00_MyCPH1_txtVehno");
    var txtVehno_Name = document.getElementById("ctl00_MyCPH1_txtVehno_Name");
    var txtVehModel = document.getElementById("ctl00_MyCPH1_txtVehModel");
    var txtVehCategory = document.getElementById("ctl00_MyCPH1_txtVehCategory");
    var txtVehCapacity = document.getElementById("ctl00_MyCPH1_txtVehCapacity");
    var txtVehOpnKM = document.getElementById("ctl00_MyCPH1_txtVehOpnKM");
    var hfVehOpnKM = document.getElementById("ctl00_MyCPH1_hfVehOpnKM");
    var txtVehOpnFuel = document.getElementById("ctl00_MyCPH1_txtVehOpnFuel");
    //var txtVehChecklist = document.getElementById("ctl00_MyCPH1_txtVehChecklist");
    var txtVehOpnFuelAmt = document.getElementById("ctl00_MyCPH1_txtVehOpnFuelAmt");
    var txtVehOpnAddBlue = document.getElementById("ctl00_MyCPH1_txtVehOpnAddBlue");    
    var txtVehOpnAddBlueAmt = document.getElementById("ctl00_MyCPH1_txtVehOpnAddBlueAmt");
    var txtDieselCarryForward = document.getElementById("ctl00_MyCPH1_txtDieselCarryForward");
    var txtDieselCarryForwardAmt = document.getElementById("ctl00_MyCPH1_txtDieselCarryForwardAmt");
    var txtStartLoc = document.getElementById("ctl00_MyCPH1_txtStartLoc");
    var hfVehicleLocation = document.getElementById("ctl00_MyCPH1_hfVehicleLocation");
    var txtVendorName = document.getElementById("ctl00_MyCPH1_txtVendorName");
    var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");
    var txtHoldFlag = document.getElementById("ctl00_MyCPH1_txtHoldFlag");

    var hidFitnessValidation = document.getElementById("ctl00_MyCPH1_hidFitnessValidation").value = "";
    var hidFitnessExpiryDate = document.getElementById("ctl00_MyCPH1_hidFitnessExpiryDate").value = "";
    var hidFitnessGraceDays = document.getElementById("ctl00_MyCPH1_hidFitnessGraceDays").value = "";
    var hidNationalPermitValidation = document.getElementById("ctl00_MyCPH1_hidNationalPermitValidation").value = "";
    var hidNationalPermitExpiryDate = document.getElementById("ctl00_MyCPH1_hidNationalPermitExpiryDate").value = "";
    var hidNationalPermitGraceDays = document.getElementById("ctl00_MyCPH1_hidNationalPermitGraceDays").value = "";
    var hid5YrPermitValidation = document.getElementById("ctl00_MyCPH1_hid5YrPermitValidation").value = "";
    var hid5YrPermitExpiryDate = document.getElementById("ctl00_MyCPH1_hid5YrPermitExpiryDate").value = "";
    var hid5YrPermitGraceDays = document.getElementById("ctl00_MyCPH1_hid5YrPermitGraceDays").value = "";
    var hidInsuranceValidation = document.getElementById("ctl00_MyCPH1_hidInsuranceValidation").value = "";
    var hidInsuranceExpiryDate = document.getElementById("ctl00_MyCPH1_hidInsuranceExpiryDate").value = "";
    var hidInsuranceGraceDays = document.getElementById("ctl00_MyCPH1_hidInsuranceGraceDays").value = "";
    var hidRoadTaxValidation = document.getElementById("ctl00_MyCPH1_hidRoadTaxValidation").value = "";
    var hidRoadTaxExpiryDate = document.getElementById("ctl00_MyCPH1_hidRoadTaxExpiryDate").value = "";
    var hidRoadTaxGraceDays = document.getElementById("ctl00_MyCPH1_hidRoadTaxGraceDays").value = "";
    var hidDieselLiterValidation = document.getElementById("ctl00_MyCPH1_hidDieselLiterValidation").value = "";
    var hidDieselLiter = document.getElementById("ctl00_MyCPH1_hidDieselLiter").value = "";
    var hidDieselLiterGrace = document.getElementById("ctl00_MyCPH1_hidDieselLiterGrace").value = "";
    var retValConcatl = "";
    if (txtVehno.value == "") {
        txtVehno_Name.value = "";
        txtVehModel.value = "";
        txtVehCategory.value = "";
        txtVehCapacity.value = "";
        txtVehOpnKM.value = "";
        hfVehOpnKM.value = "";
        txtVehOpnFuel.value = "";
        //txtVehChecklist.value = "";
        txtVehOpnFuelAmt.value = "";
        txtVehOpnAddBlue.value = "";
        txtVehOpnAddBlueAmt.value = "";
        if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
            txtDieselCarryForward.value = "";
            txtDieselCarryForwardAmt.value = "";
        }
        txtVendorName.value = "";
        return
    }

    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    //alert("Invalid Vehicle No.")
                    txtVehno.value = "";
                    txtVehno_Name.value = "";
                    txtVehModel.value = "";
                    txtVehCategory.value = "";
                    txtVehCapacity.value = "";
                    txtVehOpnKM.value = "";
                    hfVehOpnKM.value = "";
                    txtVehOpnFuel.value = "";
                    //txtVehChecklist.value = "";
                    txtVehOpnFuelAmt.value = "";
                    txtVehOpnAddBlue.value = "";
                    txtVehOpnAddBlueAmt.value = "";
                    if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                        txtDieselCarryForward.value = "";
                        txtDieselCarryForwardAmt.value = "";
                    }
                    txtVendorName.value = "";
                    //txtVehno.focus();
                    return;
                }
                else {
                    var vFitness_Validity_Date = "";
                    var vInsurance_Validity_Date = "";
                    var vRoadTaxDt = "";
                    var vNationalPermitDt = "";

                    var InsuranceValidityDateTripValidation = "";
                    var FitnessValidityDateTripValidation = "";
                    var NationalPermitDtTripValidation = "";
                    var RoadTaxDtTripValidation = "";
                    var FiveYearPermitDtTripValidation = "";
                    var DieselLtrsTripValidation = "";
                    var retValConcat = "";
                    var FiveYearPermitDt = "";
                    var InsuranceDays = "0";
                    var FitnessDays = "0";
                    var NationalPermitDays = "0";
                    var RoadTaxDays = "0";
                    var FiveYearPermitDays = "0";

                    var TripSheetNumber = "";
                    var TripSheetDate = "";
                    var TripSheetOCloseDate = "";
                    var TripSheetCount = "0";

                    vFitness_Validity_Date = returnValue[13];
                    vInsurance_Validity_Date = returnValue[12];
                    vRoadTaxDt = returnValue[14];
                    vNationalPermitDt = returnValue[15];

                    InsuranceValidityDateTripValidation = returnValue[16];
                    FitnessValidityDateTripValidation = returnValue[17];
                    NationalPermitDtTripValidation = returnValue[18];
                    RoadTaxDtTripValidation = returnValue[19];
                    FiveYearPermitDtTripValidation = returnValue[20];
                    DieselLtrsTripValidation = returnValue[21];
                    FiveYearPermitDt = returnValue[22];
                    InsuranceDays = returnValue[23];
                    FitnessDays = returnValue[24];
                    NationalPermitDays = returnValue[25];
                    RoadTaxDays = returnValue[26];
                    FiveYearPermitDays = returnValue[27];

                    TripSheetNumber = returnValue[35];
                    TripSheetDate = returnValue[36];
                    TripSheetOCloseDate = returnValue[37];
                    TripSheetCount = returnValue[38];

                    if (!GetVehicleRequestGenerated(txtVehno)) {
                        txtVehno.value = "";
                        txtVehno_Name.value = "";
                        txtVehno.focus();
                        return false;
                    }

                    if (txtStartLoc.innerText == returnValue[2].toUpperCase()) {
                        //                            alert("Vehicle Insurance_Validity_Date OR Fitness_Validity_Date OR RoadTax_Date OR NationalPermit_Date is Expired");
                        if (retValConcat == "") {
                            retVal = true
                        }
                        else {
                            if (retValConcatl != "") {
                                alert(retValConcatl);
                                txtVehno.value = "";
                                txtVehno_Name.value = "";
                                retVal = false;
                            }
                            else {
                                retVal = confirm(retValConcat);
                            }
                        }
                        if (retVal == true) {
                            txtVehModel.value = returnValue[3];
                            txtVehCategory.value = returnValue[4];
                            txtVehCapacity.value = returnValue[5];
                            txtVehOpnKM.value = returnValue[6];
                            hfVehOpnKM.value = returnValue[6];
                            //txtVehOpnFuel.value = returnValue[7];
                            txtVehOpnFuel.value = returnValue[8];
                            //txtVehChecklist.value = returnValue[8];
                            //txtVehOpnFuelAmt.value = returnValue[9];
                            txtVehOpnFuelAmt.value = returnValue[7];
                            txtVehOpnAddBlueAmt.value = returnValue[40];
                            txtVehOpnAddBlue.value = returnValue[41];                            
                            if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                                //txtDieselCarryForward.value = returnValue[7];
                                //txtDieselCarryForwardAmt.value = returnValue[8];
                                txtDieselCarryForward.value = returnValue[8];
                                txtDieselCarryForwardAmt.value = returnValue[7];
                            }
                            txtVendorName.value = returnValue[11];


                        }

                    }
                    else {
                        alert("Vehicle's Controlling Location is not from " + txtStartLoc.innerText + " branch");
                        txtVehno.value = "";
                        txtVehno_Name.value = "";
                        txtVehModel.value = "";
                        txtVehCategory.value = "";
                        txtVehCapacity.value = "";
                        txtVehOpnKM.value = "";
                        hfVehOpnKM.value = "";
                        txtVehOpnFuel.value = "";
                        //txtVehChecklist.value = "";
                        txtVehOpnFuelAmt.value = "";
                        if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                            txtDieselCarryForward.value = "";
                            txtDieselCarryForwardAmt.value = "";
                        }
                        txtVendorName.value = "";
                        txtVehno.focus();
                    }

                    if (returnValue[10] == "In Transit") {
                        alert("Vehicle is in Transit Mode \r\n Kindly Select Another Vehicle.");
                        txtVehno.value = "";
                        txtVehno_Name.value = "";
                        txtVehModel.value = "";
                        txtVehCategory.value = "";
                        txtVehCapacity.value = "";
                        txtVehOpnKM.value = "";
                        hfVehOpnKM.value = "";
                        txtVehOpnFuel.value = "";
                        //txtVehChecklist.value = "";
                        txtVehOpnFuelAmt.value = "";
                        txtVehOpnAddBlue.value = "";
                        txtVehOpnAddBlueAmt.value = "";
                        if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                            txtDieselCarryForward.value = "";
                            txtDieselCarryForwardAmt.value = "";
                        }
                        txtVendorName.value = "";
                        txtVehno.focus();
                    }

                    function clearVehicleDetails() {
                        txtVehno.value = "";
                        txtVehno_Name.value = "";
                        txtVehModel.value = "";
                        txtVehCategory.value = "";
                        txtVehCapacity.value = "";
                        txtVehOpnKM.value = "";
                        hfVehOpnKM.value = "";
                        txtVehOpnFuel.value = "";
                        //txtVehChecklist.value = "";
                        txtVehOpnFuelAmt.value = "";
                        txtVehOpnAddBlue.value = "";
                        txtVehOpnAddBlueAmt.value="";
                        if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                            txtDieselCarryForward.value = "";
                            txtDieselCarryForwardAmt.value = "";
                        }
                        txtVendorName.value = "";
                        txtVehno.focus();
                    }

                    if (parseInt(TripSheetCount) >= 2) {
                        alert(TripSheetCount.toString() + " Tripsheet is already pending for Financial close against this vehicle. Please close it first.");
                        txtVehno.value = "";
                        txtVehno_Name.value = "";
                        txtVehModel.value = "";
                        txtVehCategory.value = "";
                        txtVehCapacity.value = "";
                        txtVehOpnKM.value = "";
                        hfVehOpnKM.value = "";
                        txtVehOpnFuel.value = "";
                        //txtVehChecklist.value = "";
                        txtVehOpnFuelAmt.value = "";
                        txtVehOpnAddBlue.value = "";
                        txtVehOpnAddBlueAmt.value = "";
                        if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                            txtDieselCarryForward.value = "";
                            txtDieselCarryForwardAmt.value = "";
                        }
                        txtVendorName.value = "";
                        txtVehno.focus();
                    }

                    if (!IsDateGreater(vFitness_Validity_Date, hfTodayDate.value)) {
                        alert("Fitness Validity document is expired  !!");
                        clearVehicleDetails();
                        return false;
                    }

                    if (!IsDateGreater(vInsurance_Validity_Date, hfTodayDate.value)) {
                        alert("Insurance Validity document is expired  !!");
                        clearVehicleDetails();
                        return false;
                    }

                    if (!IsDateGreater(vRoadTaxDt, hfTodayDate.value)) {
                        alert("Road Tax  document is expired !!")
                        clearVehicleDetails();
                        return false;
                    }

                    if (!IsDateGreater(vNationalPermitDt, hfTodayDate.value)) {
                        alert("National Permit  document is expired !!")
                        clearVehicleDetails();
                        return false;
                    }


                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=FillVehicleDetailsMaster&datetime=" + currentTime + "&Vehno=" + txtVehno.value, false);
        xmlHttpRequest.send(null);
    }
}
function GetVehicleRequestGenerated(txtVehno) {
    var flag = false;
    var currentTime = new Date();
    var txtVehno_Name = document.getElementById("ctl00_MyCPH1_txtVehno_Name");
    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    //alert("Driver is not attached with Vehicle No. " + txtVehno.value + "")
                    txtVehno.value = "";
                    txtVehno_Name.value = "";
                    //alert("Driver is not attached with Vehicle No. " + txtVehno.value + "")
                    //txtDriver1.focus();
                    flag = true;
                }
                else {
                    if (returnValue[28] != "0") {
                        alert("Please approve pending request. Request ID:- " + returnValue[29]);
                        txtVehno.value = "";
                        txtVehno_Name.value = "";
                        txtVehno.focus();
                        flag = false;
                    }
                    else { flag = true; }
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=FillVehicleDetailsMaster&datetime=" + currentTime + "&Vehno=" + txtVehno.value, false);
        xmlHttpRequest.send(null);
    }
    return flag;
}
function GetDriver1Details(txtDriver1) {
    debugger;
    //var LblDriver1Name = document.getElementById("ctl00_MyCPH1_LblDriver1Name");
    var lblDriver1Licno = document.getElementById("ctl00_MyCPH1_lblDriver1Licno");
    var lblDriver1ValidDt = document.getElementById("ctl00_MyCPH1_lblDriver1ValidDt");
    var hf_Manual_Driver1_Code = document.getElementById("ctl00_MyCPH1_hf_Manual_Driver1_Code");
    var txtDriver2 = document.getElementById("ctl00_MyCPH1_txtDriver2");
    var LblDriverBalance = document.getElementById("ctl00_MyCPH1_LblDriverBalance");

    var hfDriver_Photo = document.getElementById("ctl00_MyCPH1_hfDriver_Photo");
    var hfDriver_photo_Rule = document.getElementById("ctl00_MyCPH1_hfDriver_photo_Rule");
    var hfDriverLic_Validity = document.getElementById("ctl00_MyCPH1_hfDriverLic_Validity");
    var hfDriverLic_Validity_Rule = document.getElementById("ctl00_MyCPH1_hfDriverLic_Validity_Rule");
    var hfDriver_TripCount = document.getElementById("ctl00_MyCPH1_hfDriver_TripCount");
    var hfDriver_TripCount_Rule = document.getElementById("ctl00_MyCPH1_hfDriver_TripCount_Rule");
    var hfTot_No_Trip = document.getElementById("ctl00_MyCPH1_hfTot_No_Trip");
    var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");
    var txtDriver1Name = document.getElementById("ctl00_MyCPH1_txtDriver1Name");

    var ddlDriver1 = document.getElementById("ctl00_MyCPH1_ddlDriver1");
    var txtVehno = document.getElementById("ctl00_MyCPH1_txtVehno");
    var lblDriver1LicView = document.getElementById("ctl00_MyCPH1_lblDriver1LicView");
    var lblDriver1PhotoView = document.getElementById("ctl00_MyCPH1_lblDriver1PhotoView");
    var LblDriverBalance = document.getElementById("ctl00_MyCPH1_LblDriverBalance");
    var ddlDriver2 = document.getElementById("ctl00_MyCPH1_ddlDriver2");
    var ddlCleaner = document.getElementById("ctl00_MyCPH1_ddlCleaner");

    //alert(foo);

    if (txtDriver1.value != "") {
        if (txtVehno.value == "") {
            alert("First Enter Vehicle No.");
            txtDriver1.value = "";
            txtDriver1Name.value = "";
            txtVehno.focus();
            return false;
        }
        if (ddlDriver1.value == "0") {
            alert("Select Driver From Roster Y/N.");
            txtDriver1.value = "";
            txtDriver1Name.value = "";
            ddlDriver1.focus();
            return false;
        }
        if (txtDriver2 != null) {
            if (txtDriver1.value == txtDriver2.value) {
                alert("Not allowed. Driver1 and Driver2 must be different.");
                txtDriver1Name.value = "";
                LblDriver1Name.value = "";
                lblDriver1Licno.value = "";
                lblDriver1ValidDt.value = "";
                txtDriver1.value = "";
                lblDriver1LicView.innerText = "";
                lblDriver1PhotoView.innerText = "";
                return false;
            }
        }
        createXMLHttpRequest();
        if (xmlHttpRequest) {
            xmlHttpRequest.onreadystatechange = function () {
                if (xmlHttpRequest.readyState == 4) {
                    var returnValue = xmlHttpRequest.responseText.split("~");
                    if (returnValue[0] == "N") {
                        //LblDriver1Name.value = "";
                        //alert("Invalid Driver!!");
                        txtDriver1.value = "";
                        txtDriver1Name.value = "";
                        lblDriver1Licno.value = "";
                        lblDriver1ValidDt.value = "";
                        hf_Manual_Driver1_Code.value = "";
                        LblDriverBalance.value = "";
                        lblDriver1LicView.innerText = "";
                        lblDriver1PhotoView.innerText = "";
                        //txtDriver1.focus();
                        return false;
                    }
                    else {
                        var mDriverLic_Validity = "";
                        var mDriver_Photo = "";
                        var mDriver_TripCount = "";

                        mDriverLic_Validity = returnValue[3];
                        mDriver_Photo = returnValue[5];
                        mDriver_TripCount = returnValue[6];

                        if (txtVehno.value == "") {
                            alert("First Enter Vehicle No.");
                            txtDriver1.value = "";
                            txtDriver1Name.value = "";
                            txtVehno.focus();
                            return false;
                        }
                        if (ddlDriver1.value == "0") {
                            alert("Select Driver From Roster Y/N.");
                            txtDriver1.value = "";
                            txtDriver1Name.value = "";
                            ddlDriver1.focus();
                            return false;
                        }
                        //alert(returnValue[9]);
                        if (returnValue[9] == "In Transit") {
                            alert("Selected Driver is in Transit Mode \r\n Kindly Select Another Driver.");
                            txtDriver1.value = "";
                            txtDriver1Name.value = "";
                            lblDriver1Licno.value = "";
                            lblDriver1ValidDt.value = "";
                            hf_Manual_Driver1_Code.value = "";
                            LblDriverBalance.value = "";
                            lblDriver1LicView.innerText = "";
                            lblDriver1PhotoView.innerText = "";
                            //txtDriver1.focus();
                            return false;
                        }

                        if (ddlDriver1.value == "Y" && returnValue[8] == "02") {
                            alert("Selected Peron is Cleaner \r\n Please Select Driver");
                            txtDriver1.value = "";
                            txtDriver1Name.value = "";
                            lblDriver1Licno.value = "";
                            lblDriver1ValidDt.value = "";
                            hf_Manual_Driver1_Code.value = "";
                            LblDriverBalance.value = "";
                            lblDriver1LicView.innerText = "";
                            lblDriver1PhotoView.innerText = "";
                            //txtDriver1.focus();
                            return false;
                        }

                        if (hfDriver_photo_Rule.value == "Y" || mDriver_Photo == "") {
                            if (hfDriver_photo_Rule.value == "Y" && mDriver_Photo == "") {
                                alert("Selected Driver Do Not have Their Photo \r\nPlease Select Another Driver");
                                //LblDriver1Name.value = "";
                                txtDriver1Name.value = "";
                                lblDriver1Licno.value = "";
                                lblDriver1ValidDt.value = "";
                                txtDriver1.value = "";
                                txtDriver1.focus();
                                return false;
                            }
                            if (hfDriverLic_Validity_Rule.value == "Y" || IsDateGreater(hfTodayDate.value, mDriverLic_Validity) || returnValue[10] == "N") {
                                var retVal = confirm("Selected Driver's License is Expired OR License Not Verified  \n Do You Want To continue ?");
                                if (retVal == true) {
                                    lblDriver1Licno.value = returnValue[2];
                                    lblDriver1ValidDt.value = returnValue[3];
                                    hf_Manual_Driver1_Code.value = returnValue[4];
                                    lblDriver1LicView.innerText = returnValue[7];
                                    lblDriver1PhotoView.innerText = returnValue[5];
                                    FillDriverBalance(hf_Manual_Driver1_Code);
                                    Flag = true;
                                    return true;
                                }
                                else {
                                    return false;
                                }

                            }

                            var LicenseValditydtTripValidation = "";
                            var LicenseVerifiedDtTripValidation = "";
                            var DriverCashTripValidation = "";
                            var vValdity_dt = "";
                            var vLicense_Verified_Dt = "";
                            var retValConcat = "";
                            var retVal = "";
                            vValdity_dt = returnValue[3];
                            vLicense_Verified_Dt = returnValue[14];
                            LicenseValditydtTripValidation = returnValue[11];
                            LicenseVerifiedDtTripValidation = returnValue[12];
                            DriverCashTripValidation = returnValue[13];
                            var LblDriverBalance = document.getElementById("ctl00_MyCPH1_LblDriverBalance");
                            FillDriverBalance(hf_Manual_Driver1_Code);
                            if (IsDateGreater(LicenseValditydtTripValidation, vValdity_dt)) {
                                if (retValConcat == "")
                                { retValConcat = "License valdity date Expired" }
                                else {
                                    retValConcat = retValConcat + " \n License valdity date Expired"
                                }
                            }
                            if (IsDateGreater(LicenseVerifiedDtTripValidation, vLicense_Verified_Dt)) {
                                if (retValConcat == "")
                                { retValConcat = "License Verified Date Expired" }
                                else {
                                    retValConcat = retValConcat + " \n License Verified Date Expired"
                                }
                            }
                            if (parseFloat(DriverCashTripValidation) < parseFloat(LblDriverBalance.value)) {

                                if (retValConcat == "")
                                { retValConcat = "Driver Cash is not valid for  Trip Validation" }
                                else {
                                    retValConcat = retValConcat + " \n Driver Cash is not valid for  Trip Validation"
                                }
                            }


                            if (retValConcat == "")
                            { retValConcat = ""; retVal = true; }
                            else {
                                retValConcat = retValConcat + " \n Do You Want To continue ?"
                            }
                            if (retValConcat != "") {
                                retVal = confirm(retValConcat);

                                if (retVal == true) {
                                    lblDriver1Licno.value = returnValue[2];
                                    lblDriver1ValidDt.value = returnValue[3];
                                    hf_Manual_Driver1_Code.value = returnValue[4];
                                    lblDriver1LicView.innerText = returnValue[7];
                                    lblDriver1PhotoView.innerText = returnValue[5];
                                    FillDriverBalance(hf_Manual_Driver1_Code);
                                    txtHoldFlag.value = "Y";
                                    Flag = true;
                                    return true;
                                }
                                else {
                                    txtHoldFlag.value = "N";
                                    return false;
                                }
                            }

                            if (IsDateGreater(hfTodayDate.value, mDriverLic_Validity) || returnValue[10] == "N") {
                                var retVal = confirm("Selected Driver's License is Expired OR License Not Verified  \n Do You Want To continue ?");
                                if (retVal == true) {
                                    lblDriver1Licno.value = returnValue[2];
                                    lblDriver1ValidDt.value = returnValue[3];
                                    hf_Manual_Driver1_Code.value = returnValue[4];
                                    lblDriver1LicView.innerText = returnValue[7];
                                    lblDriver1PhotoView.innerText = returnValue[5];
                                    FillDriverBalance(hf_Manual_Driver1_Code);
                                    Flag = true;
                                    return true;
                                }
                                else {
                                    return false;
                                }

                            }

                            if (hfDriver_TripCount_Rule.value == "Y" && hfTot_No_Trip.value < mDriver_TripCount) {
                                alert("Driver Settlement is Pending For " + returnValue[6] + " Trip Sheet \r\nPlease Select Another Driver");
                                txtDriver1Name.value = "";
                                //LblDriver1Name.value = "";
                                lblDriver1Licno.value = "";
                                lblDriver1ValidDt.value = "";
                                txtDriver1.value = "";
                                txtDriver1.focus();
                                return false;
                            }
                        }
                        else {
                            //LblDriver1Name.value = returnValue[1];
                            lblDriver1Licno.value = returnValue[2];
                            lblDriver1ValidDt.value = returnValue[3];
                            hf_Manual_Driver1_Code.value = returnValue[4];
                            lblDriver1LicView.innerText = returnValue[7];
                            lblDriver1PhotoView.innerText = returnValue[5];
                            FillDriverBalance(hf_Manual_Driver1_Code);

                        }
                    }
                }
            }
            xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=GetNewDriverDetails&datetime=" + currentTime + "&DriverId=" + txtDriver1.value + "&VEHNO=" + txtVehno.value, false);
            xmlHttpRequest.send(null);
        }
    }
    else {
        //LblDriver1Name.value = "";
        txtDriver1Name.value = "";
        lblDriver1Licno.value = "";
        lblDriver1ValidDt.value = "";
        txtDriver1.value = "";
    }

}


function GetDriver1DetailsVehicleWise(txtDriver1) {
    var currentTime = new Date();

    var lblDriver1Licno = document.getElementById("ctl00_MyCPH1_lblDriver1Licno");
    var lblDriver1ValidDt = document.getElementById("ctl00_MyCPH1_lblDriver1ValidDt");
    var hf_Manual_Driver1_Code = document.getElementById("ctl00_MyCPH1_hf_Manual_Driver1_Code");
    var txtDriver2 = document.getElementById("ctl00_MyCPH1_txtDriver2");
    var LblDriverBalance = document.getElementById("ctl00_MyCPH1_LblDriverBalance");

    var hfDriver_Photo = document.getElementById("ctl00_MyCPH1_hfDriver_Photo");
    var hfDriver_photo_Rule = document.getElementById("ctl00_MyCPH1_hfDriver_photo_Rule");
    var hfDriverLic_Validity = document.getElementById("ctl00_MyCPH1_hfDriverLic_Validity");
    var hfDriverLic_Validity_Rule = document.getElementById("ctl00_MyCPH1_hfDriverLic_Validity_Rule");
    var hfDriver_TripCount = document.getElementById("ctl00_MyCPH1_hfDriver_TripCount");
    var hfDriver_TripCount_Rule = document.getElementById("ctl00_MyCPH1_hfDriver_TripCount_Rule");
    var hfTot_No_Trip = document.getElementById("ctl00_MyCPH1_hfTot_No_Trip");
    var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");
    var txtDriver1Name = document.getElementById("ctl00_MyCPH1_txtDriver1Name");

    var ddlDriver1 = document.getElementById("ctl00_MyCPH1_ddlDriver1");
    var txtVehno = document.getElementById("ctl00_MyCPH1_txtVehno");
    var lblDriver1LicView = document.getElementById("ctl00_MyCPH1_lblDriver1LicView");
    var lblDriver1PhotoView = document.getElementById("ctl00_MyCPH1_lblDriver1PhotoView");

    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    //alert("Driver is not attached with Vehicle No. " + txtVehno.value + "")
                    txtDriver1.value = "";
                    txtDriver1Name.value = "";
                    lblDriver1Licno.value = "";
                    lblDriver1ValidDt.value = "";
                    hf_Manual_Driver1_Code.value = "";
                    LblDriverBalance.innerText = "";
                    lblDriver1LicView.innerText = "";
                    lblDriver1PhotoView.innerText = "";
                    //alert("Driver is not attached with Vehicle No. " + txtVehno.value + "")
                    //txtDriver1.focus();
                    return false;
                }
                else {

                    //  alert("returnValue[2]:" + returnValue[2]);
                    // alert("txtVehno.value:" + txtVehno.value);
                    if (returnValue[2] != txtVehno.value) {
                        // alert("1");
                        alert("Driver is not attached with Vehicle No. " + txtVehno.value + "")
                        txtDriver1.value = "";
                        txtDriver1Name.value = "";
                        lblDriver1Licno.value = "";
                        lblDriver1ValidDt.value = "";
                        hf_Manual_Driver1_Code.value = "";
                        LblDriverBalance.innerText = "";
                        lblDriver1LicView.innerText = "";
                        lblDriver1PhotoView.innerText = "";
                        return false;
                    }
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=GetDriverDetailsVehicleWise&datetime=" + currentTime + "&DriverId=" + txtDriver1.value + "&VEHNO=" + txtVehno.value, false);
        xmlHttpRequest.send(null);
    }
}



function GetDriver2Details(txtDriver2) {
    var lblDriver2Licno = document.getElementById("ctl00_MyCPH1_lblDriver2Licno");
    var lblDriver2ValidDt = document.getElementById("ctl00_MyCPH1_lblDriver2ValidDt");
    //var hf_Manual_Driver2_Code = document.getElementById("ctl00_MyCPH1_hf_Manual_Driver2_Code");
    var txtDriver2 = document.getElementById("ctl00_MyCPH1_txtDriver2");
    var txtDriver1 = document.getElementById("ctl00_MyCPH1_txtDriver1");

    var hfDriver2_photo_Rule = document.getElementById("ctl00_MyCPH1_hfDriver2_photo_Rule");
    var hfDriver2Lic_Validity_Rule = document.getElementById("ctl00_MyCPH1_hfDriver2Lic_Validity_Rule");

    var hfDriver2_Mandetory_Rule = document.getElementById("ctl00_MyCPH1_hfDriver2_Mandetory_Rule");
    var hfDriver2_With_LocationFilter_Rule = document.getElementById("ctl00_MyCPH1_hfDriver2_With_LocationFilter_Rule");

    var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");
    var txtDriver2Name = document.getElementById("ctl00_MyCPH1_txtDriver2Name");

    var ddlDriver2 = document.getElementById("ctl00_MyCPH1_ddlDriver2");
    var txtVehno = document.getElementById("ctl00_MyCPH1_txtVehno");
    var lblDriver2LicView = document.getElementById("ctl00_MyCPH1_lblDriver2LicView");
    var lblDriver2PhotoView = document.getElementById("ctl00_MyCPH1_lblDriver2PhotoView");

    var ddlDriver1 = document.getElementById("ctl00_MyCPH1_ddlDriver1");
    var ddlDriver2 = document.getElementById("ctl00_MyCPH1_ddlDriver2");
    var ddlCleaner = document.getElementById("ctl00_MyCPH1_ddlCleaner");

    //alert(foo);

    if (txtDriver2.value != "") {
        if (txtVehno.value == "") {
            alert("First Enter Vehicle No.");
            txtDriver2.value = "";
            txtDriver2Name.value = "";
            txtVehno.focus();
            return false;
        }
        if (ddlDriver2.value == "0") {
            alert("Select Driver From Roster Y/N.");
            txtDriver2.value = "";
            txtDriver2Name.value = "";
            ddlDriver2.focus();
            return false;
        }
        if (txtDriver1 != null) {
            if (txtDriver1.value == txtDriver2.value) {
                alert("Not allowed. Driver1 and Driver2 must be different.");
                txtDriver2Name.value = "";
                //LblDriver2Name.value = "";
                lblDriver2Licno.value = "";
                lblDriver2ValidDt.value = "";
                txtDriver2.value = "";
                lblDriver2LicView.innerText = "";
                lblDriver2PhotoView.innerText = "";
                return false;
            }
        }
        createXMLHttpRequest();
        if (xmlHttpRequest) {
            xmlHttpRequest.onreadystatechange = function () {
                if (xmlHttpRequest.readyState == 4) {
                    var returnValue = xmlHttpRequest.responseText.split("~");
                    if (returnValue[0] == "N") {
                        //LblDriver1Name.value = "";
                        //alert("Invalid Driver!!");
                        txtDriver2.value = "";
                        txtDriver2Name.value = "";
                        lblDriver2Licno.value = "";
                        lblDriver2ValidDt.value = "";
                        //hf_Manual_Driver2_Code.value = "";
                        lblDriver2LicView.innerText = "";
                        lblDriver2PhotoView.innerText = "";
                        //txtDriver1.focus();
                        return false;
                    }
                    else {
                        var mDriverLic_Validity = "";
                        var mDriver_Photo = "";

                        mDriver2Lic_Validity = returnValue[3];
                        mDriver2_Photo = returnValue[5];

                        if (txtVehno.value == "") {
                            alert("First Enter Vehicle No.");
                            txtDriver2.value = "";
                            txtDriver2Name.value = "";
                            txtVehno.focus();
                            return false;
                        }
                        if (ddlDriver2.value == "0") {
                            alert("Select Driver From Roster Y/N.");
                            txtDriver2.value = "";
                            txtDriver2Name.value = "";
                            ddlDriver2.focus();
                            return false;
                        }

                        if (ddlDriver2.value == "Y" && returnValue[8] == "02") {
                            alert("Selected Peron is Cleaner \r\n Please Select Driver");
                            txtDriver2.value = "";
                            txtDriver2Name.value = "";
                            lblDriver2Licno.value = "";
                            lblDriver2ValidDt.value = "";
                            //hf_Manual_Driver1_Code.value = "";
                            lblDriver2LicView.innerText = "";
                            lblDriver2PhotoView.innerText = "";
                            //txtDriver1.focus();
                            return false;
                        }
                        if (returnValue[9] == "In Transit") {
                            alert("Selected Driver is in Transit Mode \r\n Kindly Select Another Driver.");
                            txtDriver2.value = "";
                            txtDriver2Name.value = "";
                            lblDriver2Licno.value = "";
                            lblDriver2ValidDt.value = "";
                            lblDriver2LicView.innerText = "";
                            lblDriver2PhotoView.innerText = "";
                            //txtDriver1.focus();
                            return false;
                        }

                        //alert(hfDriver2_photo_Rule.value);
                        //alert(mDriver2_Photo);

                        if (hfDriver2_photo_Rule.value == "Y" && mDriver2_Photo == "" || hfDriver2Lic_Validity_Rule.value == "Y" && IsDateGreater(hfTodayDate.value, mDriver2Lic_Validity)) {
                            if (hfDriver2_photo_Rule.value == "Y" && mDriver2_Photo == "") {
                                alert("Selected Driver Do Not have Their Photo \r\nPlease Select Another Driver");
                                //LblDriver1Name.value = "";
                                txtDriver2Name.value = "";
                                lblDriver2Licno.value = "";
                                lblDriver2ValidDt.value = "";
                                txtDriver2.value = "";
                                txtDriver2.focus();
                                return false;
                            }

                            // if (hfDriver2Lic_Validity_Rule.value == "Y" && IsDateGreater(hfTodayDate.value, mDriver2Lic_Validity)) {
                            if (hfDriver2Lic_Validity_Rule.value == "Y" && IsDateGreater(hfTodayDate.value, mDriver2Lic_Validity) && returnValue[10] == "N") {
                                // alert("Selected Driver's License is Expired \r\nPlease Select Another Driver");
                                // alert("Selected Driver's License is Expired OR License Not Verified\r\nPlease Select Another Driver");
                                //txtDriver2Name.value = "";
                                ////LblDriver2Name.value = "";
                                //lblDriver2Licno.value = "";
                                //lblDriver2ValidDt.value = "";
                                //txtDriver2.value = "";
                                //txtDriver2.focus();
                                //LblDriver1Name.value = returnValue[1];
                                var retVal = confirm("Selected Driver's License is Expired OR License Not Verified \n Do You Want To continue ?");
                                if (retVal == true) {
                                    lblDriver2Licno.value = returnValue[2];
                                    lblDriver2ValidDt.value = returnValue[3];
                                    //hf_Manual_Driver1_Code.value = returnValue[4];
                                    lblDriver2LicView.innerText = returnValue[7];
                                    lblDriver2PhotoView.innerText = returnValue[5];
                                    //FillDriverBalance(hf_Manual_Driver1_Code);
                                    Flag = true;
                                    return true;
                                }
                                else {
                                    return false;
                                }
                            }
                        }
                        else {
                            //LblDriver1Name.value = returnValue[1];
                            //alert(returnValue[3]);
                            lblDriver2Licno.value = returnValue[2];
                            lblDriver2ValidDt.value = returnValue[3];
                            //alert(lblDriver2ValidDt.value);
                            //hf_Manual_Driver1_Code.value = returnValue[4];
                            lblDriver2LicView.innerText = returnValue[7];
                            lblDriver2PhotoView.innerText = returnValue[5];
                            //FillDriverBalance(hf_Manual_Driver1_Code);

                        }
                    }
                }
            }
            xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=GetNewDriverDetails&datetime=" + currentTime + "&DriverId=" + txtDriver2.value + "&VEHNO=" + txtVehno.value, false);
            xmlHttpRequest.send(null);
        }
    }
    else {
        //LblDriver1Name.value = "";
        txtDriver2Name.value = "";
        lblDriver2Licno.value = "";
        lblDriver2ValidDt.value = "";
        txtDriver2.value = "";
    }

}


function GetDriver2DetailsVehicleWise(txtDriver2) {
    var currentTime = new Date();

    var lblDriver2Licno = document.getElementById("ctl00_MyCPH1_lblDriver2Licno");
    var lblDriver2ValidDt = document.getElementById("ctl00_MyCPH1_lblDriver2ValidDt");
    var txtDriver2 = document.getElementById("ctl00_MyCPH1_txtDriver2");
    var txtDriver2Name = document.getElementById("ctl00_MyCPH1_txtDriver2Name");

    var ddlDriver2 = document.getElementById("ctl00_MyCPH1_ddlDriver2");
    var txtVehno = document.getElementById("ctl00_MyCPH1_txtVehno");
    var lblDriver2LicView = document.getElementById("ctl00_MyCPH1_lblDriver2LicView");
    var lblDriver2PhotoView = document.getElementById("ctl00_MyCPH1_lblDriver2PhotoView");

    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    //alert("Driver is not attached with Vehicle No. " + txtVehno.value + "")
                    txtDriver2.value = "";
                    txtDriver2Name.value = "";
                    lblDriver2Licno.value = "";
                    lblDriver2ValidDt.value = "";
                    lblDriver2LicView.innerText = "";
                    lblDriver2PhotoView.innerText = "";
                    //alert("Driver is not attached with Vehicle No. " + txtVehno.value + "")
                    //txtDriver2.focus();
                    return false;
                }
                else {

                    //alert(returnValue[2]);
                    if (returnValue[2] != txtVehno.value) {
                        alert("Driver is not attached with Vehicle No. " + txtVehno.value + "")
                        txtDriver2.value = "";
                        txtDriver2Name.value = "";
                        lblDriver2Licno.value = "";
                        lblDriver2ValidDt.value = "";
                        lblDriver2LicView.innerText = "";
                        lblDriver2PhotoView.innerText = "";
                        return false;
                    }
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=GetDriverDetailsVehicleWise&datetime=" + currentTime + "&DriverId=" + txtDriver2.value + "&VEHNO=" + txtVehno.value, false);
        xmlHttpRequest.send(null);
    }
}
/*
function GetDriver1DetailsMaster(txtDriver1) {
    //var LblDriver1Name = document.getElementById("ctl00_MyCPH1_LblDriver1Name");
    var lblDriver1Licno = document.getElementById("ctl00_MyCPH1_lblDriver1Licno");
    var lblDriver1ValidDt = document.getElementById("ctl00_MyCPH1_lblDriver1ValidDt");
    var hf_Manual_Driver1_Code = document.getElementById("ctl00_MyCPH1_hf_Manual_Driver1_Code");
    var txtDriver2 = document.getElementById("ctl00_MyCPH1_txtDriver2");
    var LblDriverBalance = document.getElementById("ctl00_MyCPH1_LblDriverBalance");

    var hfDriver_Photo = document.getElementById("ctl00_MyCPH1_hfDriver_Photo");
    var hfDriver_photo_Rule = document.getElementById("ctl00_MyCPH1_hfDriver_photo_Rule");
    var hfDriverLic_Validity = document.getElementById("ctl00_MyCPH1_hfDriverLic_Validity");
    var hfDriverLic_Validity_Rule = document.getElementById("ctl00_MyCPH1_hfDriverLic_Validity_Rule");
    var hfDriver_TripCount = document.getElementById("ctl00_MyCPH1_hfDriver_TripCount");
    var hfDriver_TripCount_Rule = document.getElementById("ctl00_MyCPH1_hfDriver_TripCount_Rule");
    var hfTot_No_Trip = document.getElementById("ctl00_MyCPH1_hfTot_No_Trip");
    var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");
    var txtDriver1Name = document.getElementById("ctl00_MyCPH1_txtDriver1Name");

    var ddlDriver1 = document.getElementById("ctl00_MyCPH1_ddlDriver1");
    var txtVehno = document.getElementById("ctl00_MyCPH1_txtVehno");
    var lblDriver1LicView = document.getElementById("ctl00_MyCPH1_lblDriver1LicView");
    var lblDriver1PhotoView = document.getElementById("ctl00_MyCPH1_lblDriver1PhotoView");
    var ddlDriver2 = document.getElementById("ctl00_MyCPH1_ddlDriver2");
    var ddlCleaner = document.getElementById("ctl00_MyCPH1_ddlCleaner");

    var hidDriverLicValidation = document.getElementById("ctl00_MyCPH1_hidDriverLicValidation").value = "";
    var hidDriverLicExpiryDate = document.getElementById("ctl00_MyCPH1_hidDriverLicExpiryDate").value = "";
    var hidDriverLicGraceDays = document.getElementById("ctl00_MyCPH1_hidDriverLicGraceDays").value = "";
    var hidDriverLicVerifValidation = document.getElementById("ctl00_MyCPH1_hidDriverLicVerifValidation").value = "";
    var hidDriverLicVerifExpiryDate = document.getElementById("ctl00_MyCPH1_hidDriverLicVerifExpiryDate").value = "";
    var hidDriverLicVerifGraceDays = document.getElementById("ctl00_MyCPH1_hidDriverLicVerifGraceDays").value = "";
    var hidCashValidation = document.getElementById("ctl00_MyCPH1_hidCashValidation").value = "";
    var hidCash = document.getElementById("ctl00_MyCPH1_hidCash").value = "";
    var hidCashGrace = document.getElementById("ctl00_MyCPH1_hidCashGrace").value = "";
    var retValConcatl = "";
    //alert(foo);

    //if (txtDriver1.value != "") {
    if (txtVehno.value == "") {
        alert("First Enter Vehicle No.");
        txtDriver1.value = "";
        txtDriver1Name.value = "";
        txtVehno.focus();
        return false;
    }
    if (ddlDriver1.value == "0") {
        alert("Select Driver From Roster Y/N.");
        txtDriver1.value = "";
        txtDriver1Name.value = "";
        ddlDriver1.focus();
        return false;
    }
    if (txtDriver2 != null) {
        if (txtDriver1.value == txtDriver2.value) {
            alert("Not allowed. Driver1 and Driver2 must be different.");
            txtDriver1Name.value = "";
            LblDriver1Name.value = "";
            lblDriver1Licno.value = "";
            lblDriver1ValidDt.value = "";
            txtDriver1.value = "";
            lblDriver1LicView.innerText = "";
            lblDriver1PhotoView.innerText = "";
            return false;
        }
    }
    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    //LblDriver1Name.value = "";
                    //alert("Invalid Driver!!");
                    txtDriver1.value = "";
                    txtDriver1Name.value = "";
                    lblDriver1Licno.value = "";
                    lblDriver1ValidDt.value = "";
                    hf_Manual_Driver1_Code.value = "";
                    //LblDriverBalance.value = "";
                    lblDriver1LicView.innerText = "";
                    lblDriver1PhotoView.innerText = "";
                    //txtDriver1.focus();
                    return false;
                }
                else {
                    var mDriverLic_Validity = "";
                    var mDriver_Photo = "";
                    var mDriver_TripCount = "";

                    mDriverLic_Validity = returnValue[3];
                    mDriver_Photo = returnValue[5];
                    mDriver_TripCount = returnValue[6];

                    if (txtVehno.value == "") {
                        alert("First Enter Vehicle No.");
                        txtDriver1.value = "";
                        txtDriver1Name.value = "";
                        txtVehno.focus();
                        return false;
                    }
                    if (ddlDriver1.value == "0") {
                        alert("Select Driver From Roster Y/N.");
                        txtDriver1.value = "";
                        txtDriver1Name.value = "";
                        ddlDriver1.focus();
                        return false;
                    }
                    //alert(returnValue[9]);
                    if (returnValue[9] == "In Transit") {
                        alert("Selected Driver is in Transit Mode \r\n Kindly Select Another Driver.");
                        txtDriver1.value = "";
                        txtDriver1Name.value = "";
                        lblDriver1Licno.value = "";
                        lblDriver1ValidDt.value = "";
                        hf_Manual_Driver1_Code.value = "";
                        //LblDriverBalance.value = "";
                        lblDriver1LicView.innerText = "";
                        lblDriver1PhotoView.innerText = "";
                        //txtDriver1.focus();
                        return false;
                    }

                    if (ddlDriver1.value == "Y" && returnValue[8] == "02") {
                        alert("Selected Peron is Cleaner \r\n Please Select Driver");
                        txtDriver1.value = "";
                        txtDriver1Name.value = "";
                        lblDriver1Licno.value = "";
                        lblDriver1ValidDt.value = "";
                        hf_Manual_Driver1_Code.value = "";
                        //LblDriverBalance.value = "";
                        lblDriver1LicView.innerText = "";
                        lblDriver1PhotoView.innerText = "";
                        //txtDriver1.focus();
                        return false;
                    }

                    if (hfDriver_photo_Rule.value == "Y" || mDriver_Photo == "") {
                        if (hfDriver_photo_Rule.value == "Y" && mDriver_Photo == "") {
                            alert("Selected Driver Do Not have Their Photo \r\nPlease Select Another Driver");
                            //LblDriver1Name.value = "";
                            txtDriver1Name.value = "";
                            lblDriver1Licno.value = "";
                            lblDriver1ValidDt.value = "";
                            txtDriver1.value = "";
                            txtDriver1.focus();
                            return false;
                        }
                        //if (hfDriverLic_Validity_Rule.value == "Y" || IsDateGreater(hfTodayDate.value, mDriverLic_Validity) || returnValue[10] == "N") {
                        //    var retVal = confirm("Selected Driver's License is Expired OR License Not Verified  \n Do You Want To continue ?");
                        //    if (retVal == true) {
                        //        lblDriver1Licno.value = returnValue[2];
                        //        lblDriver1ValidDt.value = returnValue[3];
                        //        hf_Manual_Driver1_Code.value = returnValue[4];
                        //        lblDriver1LicView.innerText = returnValue[7];
                        //        lblDriver1PhotoView.innerText = returnValue[5];
                        //        FillDriverBalance(hf_Manual_Driver1_Code);
                        //        Flag = true;
                        //        return true;
                        //    }
                        //    else {
                        //        return false;
                        //    }

                        //}

                        var LicenseValditydtTripValidation = "";
                        var LicenseVerifiedDtTripValidation = "";
                        var DriverCashTripValidation = "";
                        var DriverLicenseDays = "";
                        var DriverLicVerificationDays = "";
                        var vValdity_dt = "";
                        var vLicense_Verified_Dt = "";
                        var retValConcat = "";
                        var retVal = "";
                        vValdity_dt = returnValue[3];
                        vLicense_Verified_Dt = returnValue[14];
                        LicenseValditydtTripValidation = returnValue[11];
                        LicenseVerifiedDtTripValidation = returnValue[12];
                        DriverCashTripValidation = returnValue[13];
                        DriverLicenseDays = returnValue[14];
                        DriverLicVerificationDays = returnValue[15];
                        hf_Manual_Driver1_Code.value = returnValue[4]
                        var LblDriverBalance = document.getElementById("ctl00_MyCPH1_LblDriverBalance");
                        //FillDriverBalance(hf_Manual_Driver1_Code);
			FillDriverBalance(txtDriver1);

                        //if (returnValue[17] != "0") {
                        //    alert("Please approve pending request. Request ID:- " + returnValue[18]);
                        //    lblDriver1Licno.value = "";
                        //    lblDriver1ValidDt.value = "";
                        //    hf_Manual_Driver1_Code.value = "";
                        //    lblDriver1LicView.innerText = "";
                        //    lblDriver1PhotoView.innerText = "";
                        //    txtDriver1Name.value = "";
                        //    lblDriver1Licno.value = "";
                        //    lblDriver1ValidDt.value = "";
                        //    txtDriver1.value = "";
                        //    txtDriver1.focus();
                        //    return false;
                        //}
                        if (!GetDriverRequestGenerated(txtDriver1)) {
                            txtDriver1.value = "";
                            txtDriver1.focus();
                            return false;
                        }
                        //if (IsDateGreater(hfTodayDate.value, vValdity_dt) || IsDateGreater(hfTodayDate.value, LicenseVerifiedDtTripValidation)) {
                        //    retValConcatl = "License Valdity\nLicense Verified\nDate is Expired.";
                        //}
                        if (IsDateGreater(hfTodayDate.value, returnValue[19]) && (returnValue[17] == "0") && (returnValue[18] == "") && (returnValue[19] != "")) {
                        }
                        else {
                            if (IsDateGreater(vValdity_dt, hfTodayDate.value)) {
                                if (retValConcatl == "")
                                { retValConcatl = "License valdity date Expired."; }
                                else {
                                    retValConcatl = retValConcatl + "\nLicense valdity date Expired.";
                                }
                            }
                        }
                        if (IsDateGreater(hfTodayDate.value, returnValue[20]) && (returnValue[17] == "0") && (returnValue[18] == "") && (returnValue[20] != "")) {
                        }
                        else {
                            if (IsDateGreater(LicenseVerifiedDtTripValidation, hfTodayDate.value)) {
                                //if (retValConcatl == "")
                                //{ retValConcatl = "License Verified Date Expired."; }
                                //else {
                                //    retValConcatl = retValConcatl + "\nLicense Verified Date Expired.";
                                //}
                            }
                        }
                        if (IsDateGreater(hfTodayDate.value, returnValue[19]) && (returnValue[17] == "0") && (returnValue[18] == "") && (returnValue[19] != "")) {
                        }
                        else {
                            if (IsDateGreater(LicenseValditydtTripValidation, hfTodayDate.value)) {
                                if (retValConcat == "")
                                { retValConcat = "License valdity date Expired. Expired Date:-" + vValdity_dt + ".Grace Days:-" + DriverLicenseDays }
                                else {
                                    retValConcat = retValConcat + "\nLicense valdity date Expired. Expired Date:-" + vValdity_dt + ".Grace Days:-" + DriverLicenseDays
                                }
                                hidDriverLicValidation = "License valdity date Expired. Expired Date:-" + vValdity_dt + ".Grace Days:-" + DriverLicenseDays
                                hidDriverLicExpiryDate = vValdity_dt;
                                hidDriverLicGraceDays = DriverLicenseDays;
                            }
                        }
                        if (IsDateGreater(hfTodayDate.value, returnValue[20]) && (returnValue[17] == "0") && (returnValue[18] == "") && (returnValue[20] != "")) {
                        }
                        else {
                            if (IsDateGreater(LicenseVerifiedDtTripValidation, hfTodayDate.value)) {
                                //if (retValConcat == "")
                                //{ retValConcat = "License Verified Date Expired. Expired Date:-" + vLicense_Verified_Dt + ".Grace Days:-" + DriverLicVerificationDays }
                                //else {
                                //    retValConcat = retValConcat + "\nLicense Verified Date Expired. Expired Date:-" + vLicense_Verified_Dt + ".Grace Days:-" + DriverLicVerificationDays
                                //}
                                hidDriverLicVerifValidation = "License Verified Date Expired. Expired Date:-" + vLicense_Verified_Dt + ".Grace Days:-" + DriverLicVerificationDays
                                hidDriverLicVerifExpiryDate = vLicense_Verified_Dt;
                                hidDriverLicVerifGraceDays = DriverLicVerificationDays;
                            }
                        }
                        if (parseFloat(DriverCashTripValidation) < parseFloat(LblDriverBalance.value.slice(0, -3))) {

                            if (retValConcat == "")
                            { retValConcat = "Driver Cash is not valid for Trip Validation. Cash:-" + DriverCashTripValidation }
                            else {
                                retValConcat = retValConcat + "\nDriver Cash is not valid for Trip Validation. Cash:-" + DriverCashTripValidation
                            }
                            hidCashValidation = "Driver Cash is not valid for Trip Validation. Cash:-" + DriverCashTripValidation
                            hidCashGrace = DriverCashTripValidation;
                            hidCash = LblDriverBalance.value.slice(0, -3);
                        }
                        if (retValConcat == "")
                        { retValConcat = ""; retVal = true; }
                        else {
                            retValConcat = retValConcat + "\n Do You Want To Send for Validation ?"
                        }
                        if (retValConcat != "") {
                            if (retValConcatl != "") {
                                alert(retValConcatl);
                                txtDriver1.value = "";
                                retVal = false;
                            }
                            else {
                                retVal = confirm(retValConcat);
                            }
                            if (retVal == true) {
                                lblDriver1Licno.value = returnValue[2];
                                lblDriver1ValidDt.value = returnValue[3];
                                hf_Manual_Driver1_Code.value = returnValue[4];
                                lblDriver1LicView.innerText = returnValue[7];
                                lblDriver1PhotoView.innerText = returnValue[5];
                                FillDriverBalance(hf_Manual_Driver1_Code);
                                //txtHoldFlag.value = "Y";

                                var twoD = new Array();
                                twoD[1] = new Array();
                                twoD[1]['Validation'] = hidDriverLicValidation;
                                twoD[1]['ExpiryDate'] = hidDriverLicExpiryDate;
                                twoD[1]['GraceDays'] = hidDriverLicGraceDays;
                                twoD[1]['Document'] = "DriverLicense";

                                twoD[2] = new Array();
                                twoD[2]['Validation'] = hidDriverLicVerifValidation;
                                twoD[2]['ExpiryDate'] = hidDriverLicVerifExpiryDate;
                                twoD[2]['GraceDays'] = hidDriverLicVerifGraceDays;
                                twoD[2]['Document'] = "DriverLicenseVerification";

                                twoD[3] = new Array();
                                twoD[3]['Validation'] = hidCashValidation;
                                twoD[3]['ExpiryDate'] = hidCash;
                                twoD[3]['GraceDays'] = hidCashGrace;
                                twoD[3]['Document'] = "Cash";
                                if (retValConcat != "") {
                                    if (PushDriverRequest(twoD)) {
                                        //alert("Request Generated. Request No:-" + document.getElementById("ctl00_MyCPH1_hidRequestID").value);
                                        alert("Request Sent Successfully for validation");
                                        lblDriver1Licno.value = "";
                                        lblDriver1ValidDt.value = "";
                                        hf_Manual_Driver1_Code.value = "";
                                        lblDriver1LicView.innerText = "";
                                        lblDriver1PhotoView.innerText = "";
                                        txtDriver1Name.value = "";
                                        //LblDriver1Name.value = "";
                                        lblDriver1Licno.value = "";
                                        lblDriver1ValidDt.value = "";
                                        txtDriver1.value = "";
                                        txtDriver1.focus();
                                        Flag = true;
                                    }
                                    else {
                                        alert("Request Failed");
                                        lblDriver1Licno.value = "";
                                        lblDriver1ValidDt.value = "";
                                        hf_Manual_Driver1_Code.value = "";
                                        lblDriver1LicView.innerText = "";
                                        lblDriver1PhotoView.innerText = "";
                                        txtDriver1Name.value = "";
                                        //LblDriver1Name.value = "";
                                        lblDriver1Licno.value = "";
                                        lblDriver1ValidDt.value = "";
                                        txtDriver1.value = "";
                                        txtDriver1.focus();
                                        return false;
                                    }
                                    Flag = true;
                                    return true;
                                }

                            }
                            else {
                                //txtHoldFlag.value = "N";
                                return false;
                            }
                        }
                        else {
                            lblDriver1Licno.value = returnValue[2];
                            lblDriver1ValidDt.value = returnValue[3];
                            hf_Manual_Driver1_Code.value = returnValue[4];
                            lblDriver1LicView.innerText = returnValue[7];
                            lblDriver1PhotoView.innerText = returnValue[5];
			    // FillDriverBalance(hf_Manual_Driver1_Code);
			    FillDriverBalance(txtDriver1);
                        }

                        if (IsDateGreater(mDriverLic_Validity, hfTodayDate.value) || returnValue[10] == "N") {
                            var retVal = confirm("Selected Driver's License is Expired OR License Not Verified  \n Do You Want To continue ?");
                            if (retVal == true) {
                                lblDriver1Licno.value = returnValue[2];
                                lblDriver1ValidDt.value = returnValue[3];
                                hf_Manual_Driver1_Code.value = returnValue[4];
                                lblDriver1LicView.innerText = returnValue[7];
                                lblDriver1PhotoView.innerText = returnValue[5];
                                FillDriverBalance(hf_Manual_Driver1_Code);
                                Flag = true;
                                return true;
                            }
                            else {
                                return false;
                            }

                        }

                        if (hfDriver_TripCount_Rule.value == "Y" && hfTot_No_Trip.value < mDriver_TripCount) {
                            alert("Driver Settlement is Pending For " + returnValue[6] + " Trip Sheet \r\nPlease Select Another Driver");
                            txtDriver1Name.value = "";
                            //LblDriver1Name.value = "";
                            lblDriver1Licno.value = "";
                            lblDriver1ValidDt.value = "";
                            txtDriver1.value = "";
                            txtDriver1.focus();
                            return false;
                        }
                    }
                    else {
                        //LblDriver1Name.value = returnValue[1];
                        lblDriver1Licno.value = returnValue[2];
                        lblDriver1ValidDt.value = returnValue[3];
                        hf_Manual_Driver1_Code.value = returnValue[4];
                        lblDriver1LicView.innerText = returnValue[7];
                        lblDriver1PhotoView.innerText = returnValue[5];
                        //FillDriverBalance(hf_Manual_Driver1_Code);
			FillDriverBalance(txtDriver1);

                    }
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=GetNewDriverDetailsMaster&datetime=" + currentTime + "&DriverId=" + txtDriver1.value + "&VEHNO=" + txtVehno.value, false);
        xmlHttpRequest.send(null);
    }
}
*/

function GetDriver1DetailsMaster(txtDriver1) {
    //var LblDriver1Name = document.getElementById("ctl00_MyCPH1_LblDriver1Name");
    var lblDriver1Licno = document.getElementById("ctl00_MyCPH1_lblDriver1Licno");
    var lblDriver1ValidDt = document.getElementById("ctl00_MyCPH1_lblDriver1ValidDt");
    var hf_Manual_Driver1_Code = document.getElementById("ctl00_MyCPH1_hf_Manual_Driver1_Code");
    var txtDriver2 = document.getElementById("ctl00_MyCPH1_txtDriver2");
    var LblDriverBalance = document.getElementById("ctl00_MyCPH1_LblDriverBalance");

    var hfDriver_Photo = document.getElementById("ctl00_MyCPH1_hfDriver_Photo");
    var hfDriver_photo_Rule = document.getElementById("ctl00_MyCPH1_hfDriver_photo_Rule");
    var hfDriverLic_Validity = document.getElementById("ctl00_MyCPH1_hfDriverLic_Validity");
    var hfDriverLic_Validity_Rule = document.getElementById("ctl00_MyCPH1_hfDriverLic_Validity_Rule");
    var hfDriver_TripCount = document.getElementById("ctl00_MyCPH1_hfDriver_TripCount");
    var hfDriver_TripCount_Rule = document.getElementById("ctl00_MyCPH1_hfDriver_TripCount_Rule");
    var hfTot_No_Trip = document.getElementById("ctl00_MyCPH1_hfTot_No_Trip");
    var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");
    var txtDriver1Name = document.getElementById("ctl00_MyCPH1_txtDriver1Name");

    var ddlDriver1 = document.getElementById("ctl00_MyCPH1_ddlDriver1");
    var txtVehno = document.getElementById("ctl00_MyCPH1_txtVehno");
    var lblDriver1LicView = document.getElementById("ctl00_MyCPH1_lblDriver1LicView");
    var lblDriver1PhotoView = document.getElementById("ctl00_MyCPH1_lblDriver1PhotoView");
    var ddlDriver2 = document.getElementById("ctl00_MyCPH1_ddlDriver2");
    var ddlCleaner = document.getElementById("ctl00_MyCPH1_ddlCleaner");

    var hidDriverLicValidation = document.getElementById("ctl00_MyCPH1_hidDriverLicValidation").value = "";
    var hidDriverLicExpiryDate = document.getElementById("ctl00_MyCPH1_hidDriverLicExpiryDate").value = "";
    var hidDriverLicGraceDays = document.getElementById("ctl00_MyCPH1_hidDriverLicGraceDays").value = "";
    var hidDriverLicVerifValidation = document.getElementById("ctl00_MyCPH1_hidDriverLicVerifValidation").value = "";
    var hidDriverLicVerifExpiryDate = document.getElementById("ctl00_MyCPH1_hidDriverLicVerifExpiryDate").value = "";
    var hidDriverLicVerifGraceDays = document.getElementById("ctl00_MyCPH1_hidDriverLicVerifGraceDays").value = "";
    var hidCashValidation = document.getElementById("ctl00_MyCPH1_hidCashValidation").value = "";
    var hidCash = document.getElementById("ctl00_MyCPH1_hidCash").value = "";
    var hidCashGrace = document.getElementById("ctl00_MyCPH1_hidCashGrace").value = "";
    var retValConcatl = "";
    //alert(foo);

    //if (txtDriver1.value != "") {
    if (txtVehno.value == "") {
        alert("First Enter Vehicle No.");
        txtDriver1.value = "";
        txtDriver1Name.value = "";
        txtVehno.focus();
        return false;
    }
    if (ddlDriver1.value == "0") {
        alert("Select Driver From Roster Y/N.");
        txtDriver1.value = "";
        txtDriver1Name.value = "";
        ddlDriver1.focus();
        return false;
    }
    if (txtDriver2 != null) {
        if (txtDriver1.value == txtDriver2.value) {
            alert("Not allowed. Driver1 and Driver2 must be different.");
            txtDriver1Name.value = "";
            // LblDriver1Name.value = "";
            lblDriver1Licno.value = "";
            lblDriver1ValidDt.value = "";
            txtDriver1.value = "";
            lblDriver1LicView.innerText = "";
            lblDriver1PhotoView.innerText = "";
            return false;
        }
    }
    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    //LblDriver1Name.value = "";
                    //alert("Invalid Driver!!");
                    txtDriver1.value = "";
                    txtDriver1Name.value = "";
                    lblDriver1Licno.value = "";
                    lblDriver1ValidDt.value = "";
                    hf_Manual_Driver1_Code.value = "";
                    //LblDriverBalance.value = "";
                    lblDriver1LicView.innerText = "";
                    lblDriver1PhotoView.innerText = "";
                    //txtDriver1.focus();
                    return false;
                }
                else {
                    var mDriverLic_Validity = "";
                    var mDriver_Photo = "";
                    var mDriver_TripCount = "";

                    mDriverLic_Validity = returnValue[3];
                    mDriver_Photo = returnValue[5];
                    mDriver_TripCount = returnValue[6];

                    if (txtVehno.value == "") {
                        alert("First Enter Vehicle No.");
                        txtDriver1.value = "";
                        txtDriver1Name.value = "";
                        txtVehno.focus();
                        return false;
                    }
                    if (ddlDriver1.value == "0") {
                        alert("Select Driver From Roster Y/N.");
                        txtDriver1.value = "";
                        txtDriver1Name.value = "";
                        ddlDriver1.focus();
                        return false;
                    }
                    //alert(returnValue[9]);
                    if (returnValue[9] == "In Transit") {
                        alert("Selected Driver is in Transit Mode \r\n Kindly Select Another Driver.");
                        txtDriver1.value = "";
                        txtDriver1Name.value = "";
                        lblDriver1Licno.value = "";
                        lblDriver1ValidDt.value = "";
                        hf_Manual_Driver1_Code.value = "";
                        //LblDriverBalance.value = "";
                        lblDriver1LicView.innerText = "";
                        lblDriver1PhotoView.innerText = "";
                        //txtDriver1.focus();
                        return false;
                    }

                    if (ddlDriver1.value == "Y" && returnValue[8] == "02") {
                        alert("Selected Peron is Cleaner \r\n Please Select Driver");
                        txtDriver1.value = "";
                        txtDriver1Name.value = "";
                        lblDriver1Licno.value = "";
                        lblDriver1ValidDt.value = "";
                        hf_Manual_Driver1_Code.value = "";
                        //LblDriverBalance.value = "";
                        lblDriver1LicView.innerText = "";
                        lblDriver1PhotoView.innerText = "";
                        //txtDriver1.focus();
                        return false;
                    }

                    if (hfDriver_photo_Rule.value == "Y" || mDriver_Photo == "") {
                        if (hfDriver_photo_Rule.value == "Y" && mDriver_Photo == "") {
                            alert("Selected Driver Do Not have Their Photo \r\nPlease Select Another Driver");
                            //LblDriver1Name.value = "";
                            txtDriver1Name.value = "";
                            lblDriver1Licno.value = "";
                            lblDriver1ValidDt.value = "";
                            txtDriver1.value = "";
                            txtDriver1.focus();
                            return false;
                        }
                        /*
                        var LicenseValditydtTripValidation = "";
                        var LicenseVerifiedDtTripValidation = "";
                        var DriverCashTripValidation = "";
                        var DriverLicenseDays = "";
                        var DriverLicVerificationDays = "";
                        var vValdity_dt = "";
                        var vLicense_Verified_Dt = "";
                        var retValConcat = "";
                        var retVal = "";
                        vValdity_dt = returnValue[3];
                        vLicense_Verified_Dt = returnValue[14];
                        LicenseValditydtTripValidation = returnValue[11];
                        LicenseVerifiedDtTripValidation = returnValue[12];
                        DriverCashTripValidation = returnValue[13];
                        DriverLicenseDays = returnValue[14];
                        DriverLicVerificationDays = returnValue[15];
                        hf_Manual_Driver1_Code.value = returnValue[4]
                        var LblDriverBalance = document.getElementById("ctl00_MyCPH1_LblDriverBalance");
                        //FillDriverBalance(hf_Manual_Driver1_Code);
			FillDriverBalance(txtDriver1);

                        if (!GetDriverRequestGenerated(txtDriver1)) {
                            txtDriver1.value = "";
                            txtDriver1.focus();
                            return false;
                        }

                        if (IsDateGreater(hfTodayDate.value, returnValue[19]) && (returnValue[17] == "0") && (returnValue[18] == "") && (returnValue[19] != "")) {
                        }
                        else {
                            if (IsDateGreater(vValdity_dt, hfTodayDate.value)) {
                                if (retValConcatl == "")
                                { retValConcatl = "License valdity date Expired."; }
                                else {
                                    retValConcatl = retValConcatl + "\nLicense valdity date Expired.";
                                }
                            }
                        }
                        if (IsDateGreater(hfTodayDate.value, returnValue[20]) && (returnValue[17] == "0") && (returnValue[18] == "") && (returnValue[20] != "")) {
                        }
                        else {
                            if (IsDateGreater(LicenseVerifiedDtTripValidation, hfTodayDate.value)) {

                            }
                        }
                        if (IsDateGreater(hfTodayDate.value, returnValue[19]) && (returnValue[17] == "0") && (returnValue[18] == "") && (returnValue[19] != "")) {
                        }
                        else {
                            if (IsDateGreater(LicenseValditydtTripValidation, hfTodayDate.value)) {
                                if (retValConcat == "")
                                { retValConcat = "License valdity date Expired. Expired Date:-" + vValdity_dt + ".Grace Days:-" + DriverLicenseDays }
                                else {
                                    retValConcat = retValConcat + "\nLicense valdity date Expired. Expired Date:-" + vValdity_dt + ".Grace Days:-" + DriverLicenseDays
                                }
                                hidDriverLicValidation = "License valdity date Expired. Expired Date:-" + vValdity_dt + ".Grace Days:-" + DriverLicenseDays
                                hidDriverLicExpiryDate = vValdity_dt;
                                hidDriverLicGraceDays = DriverLicenseDays;
                            }
                        }
                        if (IsDateGreater(hfTodayDate.value, returnValue[20]) && (returnValue[17] == "0") && (returnValue[18] == "") && (returnValue[20] != "")) {
                        }
                        else {
                            if (IsDateGreater(LicenseVerifiedDtTripValidation, hfTodayDate.value)) {

                                hidDriverLicVerifValidation = "License Verified Date Expired. Expired Date:-" + vLicense_Verified_Dt + ".Grace Days:-" + DriverLicVerificationDays
                                hidDriverLicVerifExpiryDate = vLicense_Verified_Dt;
                                hidDriverLicVerifGraceDays = DriverLicVerificationDays;
                            }
                        }
                        if (parseFloat(DriverCashTripValidation) < parseFloat(LblDriverBalance.value.slice(0, -3))) {

                            if (retValConcat == "")
                            { retValConcat = "Driver Cash is not valid for Trip Validation. Cash:-" + DriverCashTripValidation }
                            else {
                                retValConcat = retValConcat + "\nDriver Cash is not valid for Trip Validation. Cash:-" + DriverCashTripValidation
                            }
                            hidCashValidation = "Driver Cash is not valid for Trip Validation. Cash:-" + DriverCashTripValidation
                            hidCashGrace = DriverCashTripValidation;
                            hidCash = LblDriverBalance.value.slice(0, -3);
                        }
                        if (retValConcat == "")
                        { retValConcat = ""; retVal = true; }
                        else {
                            retValConcat = retValConcat + "\n Do You Want To Send for Validation ?"
                        }
                        if (retValConcat != "") {
                            if (retValConcatl != "") {
                                alert(retValConcatl);
                                txtDriver1.value = "";
                                retVal = false;
                            }
                            else {
                                retVal = confirm(retValConcat);
                            }
                            if (retVal == true) {
                                lblDriver1Licno.value = returnValue[2];
                                lblDriver1ValidDt.value = returnValue[3];
                                hf_Manual_Driver1_Code.value = returnValue[4];
                                lblDriver1LicView.innerText = returnValue[7];
                                lblDriver1PhotoView.innerText = returnValue[5];
                                FillDriverBalance(hf_Manual_Driver1_Code);
                                //txtHoldFlag.value = "Y";

                                var twoD = new Array();
                                twoD[1] = new Array();
                                twoD[1]['Validation'] = hidDriverLicValidation;
                                twoD[1]['ExpiryDate'] = hidDriverLicExpiryDate;
                                twoD[1]['GraceDays'] = hidDriverLicGraceDays;
                                twoD[1]['Document'] = "DriverLicense";

                                twoD[2] = new Array();
                                twoD[2]['Validation'] = hidDriverLicVerifValidation;
                                twoD[2]['ExpiryDate'] = hidDriverLicVerifExpiryDate;
                                twoD[2]['GraceDays'] = hidDriverLicVerifGraceDays;
                                twoD[2]['Document'] = "DriverLicenseVerification";

                                twoD[3] = new Array();
                                twoD[3]['Validation'] = hidCashValidation;
                                twoD[3]['ExpiryDate'] = hidCash;
                                twoD[3]['GraceDays'] = hidCashGrace;
                                twoD[3]['Document'] = "Cash";
                                if (retValConcat != "") {
                                    if (PushDriverRequest(twoD)) {
                                        //alert("Request Generated. Request No:-" + document.getElementById("ctl00_MyCPH1_hidRequestID").value);
                                        alert("Request Sent Successfully for validation");
                                        lblDriver1Licno.value = "";
                                        lblDriver1ValidDt.value = "";
                                        hf_Manual_Driver1_Code.value = "";
                                        lblDriver1LicView.innerText = "";
                                        lblDriver1PhotoView.innerText = "";
                                        txtDriver1Name.value = "";
                                        //LblDriver1Name.value = "";
                                        lblDriver1Licno.value = "";
                                        lblDriver1ValidDt.value = "";
                                        txtDriver1.value = "";
                                        txtDriver1.focus();
                                        Flag = true;
                                    }
                                    else {
                                        alert("Request Failed");
                                        lblDriver1Licno.value = "";
                                        lblDriver1ValidDt.value = "";
                                        hf_Manual_Driver1_Code.value = "";
                                        lblDriver1LicView.innerText = "";
                                        lblDriver1PhotoView.innerText = "";
                                        txtDriver1Name.value = "";
                                        //LblDriver1Name.value = "";
                                        lblDriver1Licno.value = "";
                                        lblDriver1ValidDt.value = "";
                                        txtDriver1.value = "";
                                        txtDriver1.focus();
                                        return false;
                                    }
                                    Flag = true;
                                    return true;
                                }

                            }
                            else {
                                //txtHoldFlag.value = "N";
                                return false;
                            }
                        }
                        else {
                            lblDriver1Licno.value = returnValue[2];
                            lblDriver1ValidDt.value = returnValue[3];
                            hf_Manual_Driver1_Code.value = returnValue[4];
                            lblDriver1LicView.innerText = returnValue[7];
                            lblDriver1PhotoView.innerText = returnValue[5];
                            FillDriverBalance(hf_Manual_Driver1_Code);
                        }
                       
                        if (IsDateGreater(mDriverLic_Validity, hfTodayDate.value) || returnValue[10] == "N") {
                            var retVal = confirm("Selected Driver's License is Expired OR License Not Verified  \n Do You Want To continue ?");
                            if (retVal == true) {
                                lblDriver1Licno.value = returnValue[2];
                                lblDriver1ValidDt.value = returnValue[3];
                                hf_Manual_Driver1_Code.value = returnValue[4];
                                lblDriver1LicView.innerText = returnValue[7];
                                lblDriver1PhotoView.innerText = returnValue[5];
                                FillDriverBalance(hf_Manual_Driver1_Code);
                                Flag = true;
                                return true;
                            }
                            else {
                                return false;
                            }

                        }
                        */
                        if (hfDriver_TripCount_Rule.value == "Y" && hfTot_No_Trip.value < mDriver_TripCount) {
                            alert("Driver Settlement is Pending For " + returnValue[6] + " Trip Sheet \r\nPlease Select Another Driver");
                            txtDriver1Name.value = "";
                            //LblDriver1Name.value = "";
                            lblDriver1Licno.value = "";
                            lblDriver1ValidDt.value = "";
                            txtDriver1.value = "";
                            txtDriver1.focus();
                            return false;
                        }
                    }

                    //LblDriver1Name.value = returnValue[1];
                    lblDriver1Licno.value = returnValue[2];
                    lblDriver1ValidDt.value = returnValue[3];
                    hf_Manual_Driver1_Code.value = returnValue[4];
                    lblDriver1LicView.innerText = returnValue[7];
                    lblDriver1PhotoView.innerText = returnValue[5];
                    //FillDriverBalance(hf_Manual_Driver1_Code);
		    FillDriverBalance(txtDriver1);


                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=GetNewDriverDetailsMaster&datetime=" + currentTime + "&DriverId=" + txtDriver1.value + "&VEHNO=" + txtVehno.value, false);
        xmlHttpRequest.send(null);
    }
}




//else {
//    //LblDriver1Name.value = "";
//    txtDriver1Name.value = "";
//    lblDriver1Licno.value = "";
//    lblDriver1ValidDt.value = "";
//    txtDriver1.value = "";
//}

//}
function GetDriver1DetailsVehicleWiseMaster(txtDriver1) {
    var currentTime = new Date();

    var lblDriver1Licno = document.getElementById("ctl00_MyCPH1_lblDriver1Licno");
    var lblDriver1ValidDt = document.getElementById("ctl00_MyCPH1_lblDriver1ValidDt");
    var hf_Manual_Driver1_Code = document.getElementById("ctl00_MyCPH1_hf_Manual_Driver1_Code");
    var txtDriver2 = document.getElementById("ctl00_MyCPH1_txtDriver2");
    var LblDriverBalance = document.getElementById("ctl00_MyCPH1_LblDriverBalance");

    var hfDriver_Photo = document.getElementById("ctl00_MyCPH1_hfDriver_Photo");
    var hfDriver_photo_Rule = document.getElementById("ctl00_MyCPH1_hfDriver_photo_Rule");
    var hfDriverLic_Validity = document.getElementById("ctl00_MyCPH1_hfDriverLic_Validity");
    var hfDriverLic_Validity_Rule = document.getElementById("ctl00_MyCPH1_hfDriverLic_Validity_Rule");
    var hfDriver_TripCount = document.getElementById("ctl00_MyCPH1_hfDriver_TripCount");
    var hfDriver_TripCount_Rule = document.getElementById("ctl00_MyCPH1_hfDriver_TripCount_Rule");
    var hfTot_No_Trip = document.getElementById("ctl00_MyCPH1_hfTot_No_Trip");
    var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");
    var txtDriver1Name = document.getElementById("ctl00_MyCPH1_txtDriver1Name");

    var ddlDriver1 = document.getElementById("ctl00_MyCPH1_ddlDriver1");
    var txtVehno = document.getElementById("ctl00_MyCPH1_txtVehno");
    var lblDriver1LicView = document.getElementById("ctl00_MyCPH1_lblDriver1LicView");
    var lblDriver1PhotoView = document.getElementById("ctl00_MyCPH1_lblDriver1PhotoView");

    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    //alert("Driver is not attached with Vehicle No. " + txtVehno.value + "")
                    txtDriver1.value = "";
                    txtDriver1Name.value = "";
                    lblDriver1Licno.value = "";
                    lblDriver1ValidDt.value = "";
                    hf_Manual_Driver1_Code.value = "";
                    LblDriverBalance.value = "";
                    lblDriver1LicView.innerText = "";
                    lblDriver1PhotoView.innerText = "";
                    //alert("Driver is not attached with Vehicle No. " + txtVehno.value + "")
                    //txtDriver1.focus();
                    return false;
                }
                else {

                    //  alert("returnValue[2]:" + returnValue[2]);
                    // alert("txtVehno.value:" + txtVehno.value);
                    if (returnValue[2] != txtVehno.value) {
                        // alert("1");
                        alert("Driver is not attached with Vehicle No. " + txtVehno.value + "")
                        txtDriver1.value = "";
                        txtDriver1Name.value = "";
                        lblDriver1Licno.value = "";
                        lblDriver1ValidDt.value = "";
                        hf_Manual_Driver1_Code.value = "";
                        LblDriverBalance.value = "";
                        lblDriver1LicView.innerText = "";
                        lblDriver1PhotoView.innerText = "";
                        return false;
                    }
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=GetDriverDetailsVehicleWiseMaster&datetime=" + currentTime + "&DriverId=" + txtDriver1.value + "&VEHNO=" + txtVehno.value, false);
        xmlHttpRequest.send(null);
    }
}
function GetDriverRequestGenerated(txtDriver1) {
    var flag = false;
    var currentTime = new Date();
    var txtVehno = document.getElementById("ctl00_MyCPH1_txtVehno");
    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    //alert("Driver is not attached with Vehicle No. " + txtVehno.value + "")
                    txtDriver1.value = "";
                    txtDriver1Name.value = "";
                    lblDriver1Licno.value = "";
                    lblDriver1ValidDt.value = "";
                    hf_Manual_Driver1_Code.value = "";
                    LblDriverBalance.value = "";
                    lblDriver1LicView.innerText = "";
                    lblDriver1PhotoView.innerText = "";
                    //alert("Driver is not attached with Vehicle No. " + txtVehno.value + "")
                    //txtDriver1.focus();
                    flag = true;
                }
                else {
                    if (returnValue[17] != "0") {
                        alert("Please approve pending request. Request ID:- " + returnValue[18]);
                        txtDriver1.value = "";
                        txtDriver1.focus();
                        flag = false;
                    }
                    else { flag = true; }
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=GetNewDriverDetailsMaster&datetime=" + currentTime + "&DriverId=" + txtDriver1.value + "&VEHNO=" + txtVehno.value, false);
        xmlHttpRequest.send(null);
    }
    return flag;
}
function GetDriver2DetailsMaster(txtDriver2) {
    var lblDriver2Licno = document.getElementById("ctl00_MyCPH1_lblDriver2Licno");
    var lblDriver2ValidDt = document.getElementById("ctl00_MyCPH1_lblDriver2ValidDt");
    //var hf_Manual_Driver2_Code = document.getElementById("ctl00_MyCPH1_hf_Manual_Driver2_Code");
    var txtDriver2 = document.getElementById("ctl00_MyCPH1_txtDriver2");
    var txtDriver1 = document.getElementById("ctl00_MyCPH1_txtDriver1");

    var hfDriver2_photo_Rule = document.getElementById("ctl00_MyCPH1_hfDriver2_photo_Rule");
    var hfDriver2Lic_Validity_Rule = document.getElementById("ctl00_MyCPH1_hfDriver2Lic_Validity_Rule");

    var hfDriver2_Mandetory_Rule = document.getElementById("ctl00_MyCPH1_hfDriver2_Mandetory_Rule");
    var hfDriver2_With_LocationFilter_Rule = document.getElementById("ctl00_MyCPH1_hfDriver2_With_LocationFilter_Rule");

    var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");
    var txtDriver2Name = document.getElementById("ctl00_MyCPH1_txtDriver2Name");

    var ddlDriver2 = document.getElementById("ctl00_MyCPH1_ddlDriver2");
    var txtVehno = document.getElementById("ctl00_MyCPH1_txtVehno");
    var lblDriver2LicView = document.getElementById("ctl00_MyCPH1_lblDriver2LicView");
    var lblDriver2PhotoView = document.getElementById("ctl00_MyCPH1_lblDriver2PhotoView");

    var ddlDriver1 = document.getElementById("ctl00_MyCPH1_ddlDriver1");
    var ddlDriver2 = document.getElementById("ctl00_MyCPH1_ddlDriver2");
    var ddlCleaner = document.getElementById("ctl00_MyCPH1_ddlCleaner");

    //alert(foo);

    if (txtDriver2.value != "") {
        if (txtVehno.value == "") {
            alert("First Enter Vehicle No.");
            txtDriver2.value = "";
            txtDriver2Name.value = "";
            txtVehno.focus();
            return false;
        }
        if (ddlDriver2.value == "0") {
            alert("Select Driver From Roster Y/N.");
            txtDriver2.value = "";
            txtDriver2Name.value = "";
            ddlDriver2.focus();
            return false;
        }
        if (txtDriver1 != null) {
            if (txtDriver1.value == txtDriver2.value) {
                alert("Not allowed. Driver1 and Driver2 must be different.");
                txtDriver2Name.value = "";
                //LblDriver2Name.value = "";
                lblDriver2Licno.value = "";
                lblDriver2ValidDt.value = "";
                txtDriver2.value = "";
                lblDriver2LicView.innerText = "";
                lblDriver2PhotoView.innerText = "";
                return false;
            }
        }
        createXMLHttpRequest();
        if (xmlHttpRequest) {
            xmlHttpRequest.onreadystatechange = function () {
                if (xmlHttpRequest.readyState == 4) {
                    var returnValue = xmlHttpRequest.responseText.split("~");
                    if (returnValue[0] == "N") {
                        //LblDriver1Name.value = "";
                        //alert("Invalid Driver!!");
                        txtDriver2.value = "";
                        txtDriver2Name.value = "";
                        lblDriver2Licno.value = "";
                        lblDriver2ValidDt.value = "";
                        //hf_Manual_Driver2_Code.value = "";
                        lblDriver2LicView.innerText = "";
                        lblDriver2PhotoView.innerText = "";
                        //txtDriver1.focus();
                        return false;
                    }
                    else {
                        var mDriverLic_Validity = "";
                        var mDriver_Photo = "";

                        mDriver2Lic_Validity = returnValue[3];
                        mDriver2_Photo = returnValue[5];

                        if (txtVehno.value == "") {
                            alert("First Enter Vehicle No.");
                            txtDriver2.value = "";
                            txtDriver2Name.value = "";
                            txtVehno.focus();
                            return false;
                        }
                        if (ddlDriver2.value == "0") {
                            alert("Select Driver From Roster Y/N.");
                            txtDriver2.value = "";
                            txtDriver2Name.value = "";
                            ddlDriver2.focus();
                            return false;
                        }

                        if (ddlDriver2.value == "Y" && returnValue[8] == "02") {
                            alert("Selected Peron is Cleaner \r\n Please Select Driver");
                            txtDriver2.value = "";
                            txtDriver2Name.value = "";
                            lblDriver2Licno.value = "";
                            lblDriver2ValidDt.value = "";
                            //hf_Manual_Driver1_Code.value = "";
                            lblDriver2LicView.innerText = "";
                            lblDriver2PhotoView.innerText = "";
                            //txtDriver1.focus();
                            return false;
                        }
                        if (returnValue[9] == "In Transit") {
                            alert("Selected Driver is in Transit Mode \r\n Kindly Select Another Driver.");
                            txtDriver2.value = "";
                            txtDriver2Name.value = "";
                            lblDriver2Licno.value = "";
                            lblDriver2ValidDt.value = "";
                            lblDriver2LicView.innerText = "";
                            lblDriver2PhotoView.innerText = "";
                            //txtDriver1.focus();
                            return false;
                        }

                        //alert(hfDriver2_photo_Rule.value);
                        //alert(mDriver2_Photo);

                        if (hfDriver2_photo_Rule.value == "Y" && mDriver2_Photo == "" || hfDriver2Lic_Validity_Rule.value == "Y" && IsDateGreater(hfTodayDate.value, mDriver2Lic_Validity)) {
                            if (hfDriver2_photo_Rule.value == "Y" && mDriver2_Photo == "") {
                                alert("Selected Driver Do Not have Their Photo \r\nPlease Select Another Driver");
                                //LblDriver1Name.value = "";
                                txtDriver2Name.value = "";
                                lblDriver2Licno.value = "";
                                lblDriver2ValidDt.value = "";
                                txtDriver2.value = "";
                                txtDriver2.focus();
                                return false;
                            }

                            // if (hfDriver2Lic_Validity_Rule.value == "Y" && IsDateGreater(hfTodayDate.value, mDriver2Lic_Validity)) {
                            if (hfDriver2Lic_Validity_Rule.value == "Y" && IsDateGreater(hfTodayDate.value, mDriver2Lic_Validity) && returnValue[10] == "N") {
                                // alert("Selected Driver's License is Expired \r\nPlease Select Another Driver");
                                // alert("Selected Driver's License is Expired OR License Not Verified\r\nPlease Select Another Driver");
                                //txtDriver2Name.value = "";
                                ////LblDriver2Name.value = "";
                                //lblDriver2Licno.value = "";
                                //lblDriver2ValidDt.value = "";
                                //txtDriver2.value = "";
                                //txtDriver2.focus();
                                //LblDriver1Name.value = returnValue[1];
                                var retVal = confirm("Selected Driver's License is Expired OR License Not Verified \n Do You Want To continue ?");
                                if (retVal == true) {
                                    lblDriver2Licno.value = returnValue[2];
                                    lblDriver2ValidDt.value = returnValue[3];
                                    //hf_Manual_Driver1_Code.value = returnValue[4];
                                    lblDriver2LicView.innerText = returnValue[7];
                                    lblDriver2PhotoView.innerText = returnValue[5];
                                    //FillDriverBalance(hf_Manual_Driver1_Code);
                                    Flag = true;
                                    return true;
                                }
                                else {
                                    return false;
                                }
                            }
                        }
                        else {
                            //LblDriver1Name.value = returnValue[1];
                            //alert(returnValue[3]);
                            lblDriver2Licno.value = returnValue[2];
                            lblDriver2ValidDt.value = returnValue[3];
                            //alert(lblDriver2ValidDt.value);
                            //hf_Manual_Driver1_Code.value = returnValue[4];
                            lblDriver2LicView.innerText = returnValue[7];
                            lblDriver2PhotoView.innerText = returnValue[5];
                            //FillDriverBalance(hf_Manual_Driver1_Code);

                        }
                    }
                }
            }
            xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=GetNewDriverDetailsMaster&datetime=" + currentTime + "&DriverId=" + txtDriver2.value + "&VEHNO=" + txtVehno.value, false);
            xmlHttpRequest.send(null);
        }
    }
    else {
        //LblDriver1Name.value = "";
        txtDriver2Name.value = "";
        lblDriver2Licno.value = "";
        lblDriver2ValidDt.value = "";
        txtDriver2.value = "";
    }

}
function GetDriver2DetailsVehicleWiseMaster(txtDriver2) {
    var currentTime = new Date();

    var lblDriver2Licno = document.getElementById("ctl00_MyCPH1_lblDriver2Licno");
    var lblDriver2ValidDt = document.getElementById("ctl00_MyCPH1_lblDriver2ValidDt");
    var txtDriver2 = document.getElementById("ctl00_MyCPH1_txtDriver2");
    var txtDriver2Name = document.getElementById("ctl00_MyCPH1_txtDriver2Name");

    var ddlDriver2 = document.getElementById("ctl00_MyCPH1_ddlDriver2");
    var txtVehno = document.getElementById("ctl00_MyCPH1_txtVehno");
    var lblDriver2LicView = document.getElementById("ctl00_MyCPH1_lblDriver2LicView");
    var lblDriver2PhotoView = document.getElementById("ctl00_MyCPH1_lblDriver2PhotoView");

    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    //alert("Driver is not attached with Vehicle No. " + txtVehno.value + "")
                    txtDriver2.value = "";
                    txtDriver2Name.value = "";
                    lblDriver2Licno.value = "";
                    lblDriver2ValidDt.value = "";
                    lblDriver2LicView.innerText = "";
                    lblDriver2PhotoView.innerText = "";
                    //alert("Driver is not attached with Vehicle No. " + txtVehno.value + "")
                    //txtDriver2.focus();
                    return false;
                }
                else {

                    //alert(returnValue[2]);
                    if (returnValue[2] != txtVehno.value) {
                        alert("Driver is not attached with Vehicle No. " + txtVehno.value + "")
                        txtDriver2.value = "";
                        txtDriver2Name.value = "";
                        lblDriver2Licno.value = "";
                        lblDriver2ValidDt.value = "";
                        lblDriver2LicView.innerText = "";
                        lblDriver2PhotoView.innerText = "";
                        return false;
                    }
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=GetDriverDetailsVehicleWiseMaster&datetime=" + currentTime + "&DriverId=" + txtDriver2.value + "&VEHNO=" + txtVehno.value, false);
        xmlHttpRequest.send(null);
    }
}

function GetCleanerDetails(txtCleaner) {
    var lblCleanerLicno = document.getElementById("ctl00_MyCPH1_lblCleanerLicno");
    var lblCleanerValidDt = document.getElementById("ctl00_MyCPH1_lblCleanerValidDt");
    //var hf_Manual_Driver2_Code = document.getElementById("ctl00_MyCPH1_hf_Manual_Driver2_Code");
    var txtDriver2 = document.getElementById("ctl00_MyCPH1_txtDriver2");
    var txtDriver1 = document.getElementById("ctl00_MyCPH1_txtDriver1");

    var hfCleaner_Mandetory_Rule = document.getElementById("ctl00_MyCPH1_hfCleaner_Mandetory_Rule");

    var hfTot_No_Trip = document.getElementById("ctl00_MyCPH1_hfTot_No_Trip");
    var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");
    var txtCleanerName = document.getElementById("ctl00_MyCPH1_txtCleanerName");

    var txtVehno = document.getElementById("ctl00_MyCPH1_txtVehno");
    var lblCleanerLicView = document.getElementById("ctl00_MyCPH1_lblCleanerLicView");
    var lblCleanerPhotoView = document.getElementById("ctl00_MyCPH1_lblCleanerPhotoView");

    var ddlDriver1 = document.getElementById("ctl00_MyCPH1_ddlDriver1");
    var ddlDriver2 = document.getElementById("ctl00_MyCPH1_ddlDriver2");
    var ddlCleaner = document.getElementById("ctl00_MyCPH1_ddlCleaner");

    //alert(foo);

    if (txtCleaner.value != "") {
        if (txtVehno.value == "") {
            alert("First Enter Vehicle No.");
            txtCleaner.value = "";
            txtCleanerName.value = "";
            txtVehno.focus();
            return false;
        }
        if (ddlCleaner.value == "0") {
            alert("Select Driver From Roster Y/N.");
            txtCleaner.value = "";
            txtCleanerName.value = "";
            ddlCleaner.focus();
            return false;
        }
        createXMLHttpRequest();
        if (xmlHttpRequest) {
            xmlHttpRequest.onreadystatechange = function () {
                if (xmlHttpRequest.readyState == 4) {
                    var returnValue = xmlHttpRequest.responseText.split("~");
                    if (returnValue[0] == "N") {
                        //LblDriver1Name.value = "";
                        //alert("Invalid Driver!!");
                        txtCleaner.value = "";
                        txtCleanerName.value = "";
                        lblCleanerLicno.value = "";
                        lblCleanerValidDt.value = "";
                        //hf_Manual_Driver2_Code.value = "";
                        lblCleanerLicView.innerText = "";
                        lblCleanerPhotoView.innerText = "";
                        //txtDriver1.focus();
                        return false;
                    }
                    else {
                        var mDriverLic_Validity = "";
                        var mDriver_Photo = "";
                        var mDriver_TripCount = "";

                        mDriverLic_Validity = returnValue[3];
                        mDriver_Photo = returnValue[5];
                        mDriver_TripCount = returnValue[6];

                        if (txtVehno.value == "") {
                            alert("First Enter Vehicle No.");
                            txtCleaner.value = "";
                            txtCleanerName.value = "";
                            txtVehno.focus();
                            return false;
                        }
                        if (ddlDriver2.value == "0") {
                            alert("Select Cleaner From Roster Y/N.");
                            txtCleaner.value = "";
                            txtCleanerName.value = "";
                            ddlCleaner.focus();
                            return false;
                        }

                        if (ddlCleaner.value == "Y" && returnValue[8] == "01") {
                            alert("Selected Peron is Driver \r\n Please Select Cleaner");
                            txtCleaner.value = "";
                            txtCleanerName.value = "";
                            lblCleanerLicno.value = "";
                            lblCleanerValidDt.value = "";
                            lblCleanerLicView.innerText = "";
                            lblCleanerPhotoView.innerText = "";
                            //txtDriver1.focus();
                            return false;
                        }

                        if (ddlCleaner.value != "" && txtCleaner.value != "") {
                            //LblCleanerName.value = returnValue[1];
                            lblCleanerLicno.value = returnValue[2];
                            lblCleanerValidDt.value = returnValue[3];
                            lblCleanerLicView.innerText = returnValue[7];
                            lblCleanerPhotoView.innerText = returnValue[5];
                            //FillDriverBalance(hf_Manual_Driver1_Code);
                        }
                    }
                }
            }
            xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=GetNewDriverDetails&datetime=" + currentTime + "&DriverId=" + txtCleaner.value + "&VEHNO=" + txtVehno.value, false);
            xmlHttpRequest.send(null);
        }
    }
    else {
        //LblDriver1Name.value = "";
        txtCleanerName.value = "";
        lblCleanerLicno.value = "";
        lblCleanerValidDt.value = "";
        txtCleaner.value = "";
    }

}


function GetCleanerDetailsVehicleWise(txtCleaner) {
    var currentTime = new Date();

    var lblCleanerLicno = document.getElementById("ctl00_MyCPH1_lblCleanerLicno");
    var lblCleanerValidDt = document.getElementById("ctl00_MyCPH1_lblDriver2ValidDt");
    var txtCleaner = document.getElementById("ctl00_MyCPH1_txtCleaner");
    var txtCleanerName = document.getElementById("ctl00_MyCPH1_txtCleanerName");

    var ddlCleaner = document.getElementById("ctl00_MyCPH1_ddlCleaner");
    var txtVehno = document.getElementById("ctl00_MyCPH1_txtVehno");
    var lblCleanerLicView = document.getElementById("ctl00_MyCPH1_lblCleanerLicView");
    var lblCleanerPhotoView = document.getElementById("ctl00_MyCPH1_lblCleanerPhotoView");

    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    //alert("Driver is not attached with Vehicle No. " + txtVehno.value + "")
                    txtCleaner.value = "";
                    txtCleanerName.value = "";
                    lblCleanerLicno.value = "";
                    lblCleanerValidDt.value = "";
                    lblCleanerLicView.innerText = "";
                    lblCleanerPhotoView.innerText = "";
                    //alert("Driver is not attached with Vehicle No. " + txtVehno.value + "")
                    //txtDriver2.focus();
                    return false;
                }
                else {

                    //alert(returnValue[2]);
                    if (returnValue[2] != txtVehno.value) {
                        alert("Driver is not attached with Vehicle No. " + txtVehno.value + "")
                        txtCleaner.value = "";
                        txtCleanerName.value = "";
                        lblCleanerLicno.value = "";
                        lblCleanerValidDt.value = "";
                        lblCleanerLicView.innerText = "";
                        lblCleanerPhotoView.innerText = "";
                        return false;
                    }
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=GetDriverDetailsVehicleWise&datetime=" + currentTime + "&DriverId=" + txtCleaner.value + "&VEHNO=" + txtVehno.value, false);
        xmlHttpRequest.send(null);
    }
}


function CalculateBalance_FuelSlip(row_Index) {
    // alert("CalculateBalance_FuelSlip");
    //debugger

    var gvFuelSlip = document.getElementById("ctl00_MyCPH1_gvFuelSlip");

    var l = 0;

    l = gvFuelSlip.rows.length;

    var txtTotalDieselFilled = "";
    var txtTotalAmount = "";

    if (gvFuelSlip != null) {
        if (l < 10) {
            txtTotalDieselFilled = document.getElementById("ctl00_MyCPH1_gvFuelSlip_ctl0" + l + "_txtTotalDieselFilled");
            txtTotalAmount = document.getElementById("ctl00_MyCPH1_gvFuelSlip_ctl0" + l + "_txtTotalAmount");
        }
        else {
            txtTotalDieselFilled = document.getElementById("ctl00_MyCPH1_gvEnroute_ctl" + l + "_txtTotalDieselFilled");
            txtTotalAmount = document.getElementById("ctl00_MyCPH1_gvFuelSlip_ctl" + l + "_txtTotalAmount");
        }
    }

    var hdnTotalDieselFilled = document.getElementById("ctl00_MyCPH1_hdnTotalDieselFilled");
    var hdnTotalAmount = document.getElementById("ctl00_MyCPH1_hdnTotalAmount");

    var totdiesel = "0.00", totamt = "0.00";



    for (i = 0; i < l - 2; i++) {

        var p_str_Index = "";

        j = i + 2
        var pref = "";
        if (j < 10) {
            pref = "ctl00_MyCPH1_gvFuelSlip_ctl0" + j + "_";
        }
        else {
            pref = "ctl00_MyCPH1_gvFuelSlip_ctl" + j + "_";
        }

        var txtQtyLiter = document.getElementById(pref + "txtQtyLiter");
        var txtRate = document.getElementById(pref + "txtRate");
        var txtAmount = document.getElementById(pref + "txtAmount");
        var ddlfueltype = document.getElementById(pref + "ddlfueltype");
        var txtIGST = document.getElementById(pref + "txtIGST");
        var txtSGST = document.getElementById(pref + "txtSGST");
        var txtCGST = document.getElementById(pref + "txtCGST");
        var txtamounttotal = document.getElementById(pref + "txtamounttotal");

        var IGST = parseFloat(txtIGST.value == "" ? "0" : txtIGST.value);
        var SGST = parseFloat(txtSGST.value == "" ? "0" : txtSGST.value);
        var CGST = parseFloat(txtCGST.value == "" ? "0" : txtCGST.value);

        if (txtQtyLiter.value != "") {
            totdiesel = parseFloat(totdiesel) + parseFloat(txtQtyLiter.value);
        }
        if (txtQtyLiter.value != "" && txtRate.value) {
            if (ddlfueltype.value == "1") {
                txtAmount.value = parseFloat(txtQtyLiter.value) * parseFloat(txtRate.value);
            }
        }
        else {
            txtAmount.value = "";
        }
        if (txtAmount.value != "") {
            totamt = parseFloat(totamt) + parseFloat(txtAmount.value);
        }
        txtamounttotal.value = parseFloat(txtAmount.value) + IGST + SGST + CGST;     

    }

    hdnTotalDieselFilled.value = totdiesel;
    hdnTotalAmount.value = totamt;

    txtTotalDieselFilled.value = hdnTotalDieselFilled.value;
    txtTotalAmount.value = hdnTotalAmount.value;

}




function CheckFuelSlipNo(row_Index, txtFuelSlipNo, hdSrNo) {

    //alert("Hi1")
    var currentTime = new Date()
    var str_Index = "";

    if (txtFuelSlipNo.value == "") {
        return true;
    }

    for (intIndex = 2; intIndex < document.getElementById("ctl00_MyCPH1_gvFuelSlip").rows.length; intIndex++) {
        if (intIndex < 10) {
            str_Index = "0" + intIndex;
        }
        else {
            str_Index = intIndex;
        }
        if (row_Index == intIndex - 2) {
            continue;
        }
        if (document.getElementById("ctl00_MyCPH1_gvFuelSlip_ctl" + str_Index + "_txtFuelSlipNo").value == txtFuelSlipNo.value) {
            alert("This Fuel Slip No is already exist at row " + (intIndex - 1));
            //txtJob_Order_No.value = "";
            txtFuelSlipNo.focus();
            return true;
        }
    }
    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "Y") {
                    alert("Fuel Slip No. is Already attached with TripSheetNo. " + returnValue[2] + " \r\n Kindly enter another Fuel Slip No.!!");
                    //txtFuelSlipNo.value = "";
                    txtFuelSlipNo.focus();
                    return false;
                }
                else {

                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckFuelSlipNo&datetime=" + currentTime + "&FuelSlipNo=" + txtFuelSlipNo.value + "&SRNO=" + hdSrNo.value, false);
        xmlHttpRequest.send(null);
    }

}




function FuelSlipCheckonSubmit() {

    var gvFuelSlip = document.getElementById('ctl00_MyCPH1_gvFuelSlip');

    if (gvFuelSlip != null) {
        //alert("1");
        if (gvFuelSlip.rows.length != 0) {
            for (i = 0; i < gvFuelSlip.rows.length - 2; i++) {
                j = i + 2;
                var pref = "";
                if (j < 10) {
                    pref = "ctl00$MyCPH1$gvFuelSlip$ctl0" + j + "$";
                }
                else {
                    pref = "ctl00$MyCPH1$gvFuelSlip$ctl" + j + "$";
                }

                var txtFuelSlipNo = document.getElementById(pref + "txtFuelSlipNo");
                var ddlFuelVendor = document.getElementById(pref + "ddlFuelVendor");
                var txtQtyLiter = document.getElementById(pref + "txtQtyLiter");
                var txtRate = document.getElementById(pref + "txtRate");
                var txtAmount = document.getElementById(pref + "txtAmount");

                var ddlFuelTypePD = document.getElementById(pref + "ddlFuelTypePD");
                var txtFromCity = document.getElementById(pref + "txtFromCity");

                if (txtFuelSlipNo.value == "") {
                    alert("Enter Fuel Slip No.")
                    txtFuelSlipNo.focus();
                    //document.getElementById(pref + "txtFrom").focus();
                    return false;
                }
                if (ddlFuelVendor.value == "") {
                    alert("Select Fuel Vendor");
                    ddlFuelVendor.focus();
                    //document.getElementById(pref + "txtTo").focus();
                    return false;
                }
                if (txtQtyLiter.value == "") {
                    alert("Enter Quantity in Liter");
                    txtQtyLiter.focus();
                    //document.getElementById(pref + "txtStartDate").focus();
                    return false;
                }

                if (txtRate.value == "") {
                    alert("Enter Rate");
                    txtRate.focus();
                    //document.getElementById(pref + "tb_StartTime_HH").focus();
                    return false;
                }

                if (txtAmount.value == "") {
                    alert("Enter Amount!!!");
                    txtAmount.focus();
                    return false;
                }
                if (ddlFuelTypePD.value == "") {
                    alert("Select  FuelType!!!");
                    ddlFuelTypePD.focus();
                    return false;
                }
                if (txtFromCity.value == "") {
                    alert("Enter FromCity!!!");
                    txtFromCity.focus();
                    return false;
                }

            }
        }
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



function THCCalculateBalance_FuelSlip(row_Index) {

    var gvFuelSlip = document.getElementById("ctl00_MyCPH1_gvFuelSlip");
    var hdnDummyAmt = document.getElementById("ctl00_MyCPH1_hdnDummyAmt");

    var l = 0;

    l = gvFuelSlip.rows.length;

    var txtTotalDieselFilled = "";
    var txtTotalAmount = "";

    if (gvFuelSlip != null) {
        if (l < 10) {
            txtTotalDieselFilled = document.getElementById("ctl00_MyCPH1_gvFuelSlip_ctl0" + l + "_txtTotalDieselFilled");
            txtTotalAmount = document.getElementById("ctl00_MyCPH1_gvFuelSlip_ctl0" + l + "_txtTotalAmount");
        }
        else {
            txtTotalDieselFilled = document.getElementById("ctl00_MyCPH1_gvEnroute_ctl" + l + "_txtTotalDieselFilled");
            txtTotalAmount = document.getElementById("ctl00_MyCPH1_gvFuelSlip_ctl" + l + "_txtTotalAmount");
        }
    }

    var hdnTotalDieselFilled = document.getElementById("ctl00_MyCPH1_hdnTotalDieselFilled");
    var hdnTotalAmount = document.getElementById("ctl00_MyCPH1_hdnTotalAmount");

    var totdiesel = "0.00", totamt = "0.00";



    for (i = 0; i < l - 2; i++) {

        var p_str_Index = "";

        j = i + 2
        var pref = "";
        if (j < 10) {
            pref = "ctl00_MyCPH1_gvFuelSlip_ctl0" + j + "_";
        }
        else {
            pref = "ctl00_MyCPH1_gvFuelSlip_ctl" + j + "_";
        }

        var txtQtyLiter = document.getElementById(pref + "txtQtyLiter");
        var txtRate = document.getElementById(pref + "txtRate");
        var txtAmount = document.getElementById(pref + "txtAmount");
        var ddlFuelVendor = document.getElementById(pref + "ddlFuelVendor");

        if (txtQtyLiter.value != "") {
            totdiesel = parseFloat(totdiesel) + parseFloat(txtQtyLiter.value);
        }
        if (txtQtyLiter.value != "" && txtRate.value != "" && ddlFuelVendor.disabled == false) {
            txtAmount.value = parseFloat(txtQtyLiter.value) * parseFloat(txtRate.value);
            hdnDummyAmt.value = txtAmount.value;
        }
        else {
            if (ddlFuelVendor.disabled == true) {
                txtAmount.value = parseFloat(txtQtyLiter.value) * parseFloat(txtRate.value);
            }
            else {
                txtAmount.value = "";
            }
        }
        if (txtAmount.value != "") {
            totamt = parseFloat(totamt) + parseFloat(txtAmount.value);
        }

    }

    hdnTotalDieselFilled.value = totdiesel;
    hdnTotalAmount.value = totamt;

    txtTotalDieselFilled.value = hdnTotalDieselFilled.value;
    txtTotalAmount.value = hdnTotalAmount.value;

}


function THCFuelSlipCheckonSubmit() {

    var gvFuelSlip = document.getElementById('ctl00_MyCPH1_gvFuelSlip');


    if (gvFuelSlip != null) {
        //alert("1");
        if (gvFuelSlip.rows.length != 0) {
            for (i = 0; i < gvFuelSlip.rows.length - 2; i++) {
                j = i + 2;
                var pref = "";
                if (j < 10) {
                    pref = "ctl00$MyCPH1$gvFuelSlip$ctl0" + j + "$";
                }
                else {
                    pref = "ctl00$MyCPH1$gvFuelSlip$ctl" + j + "$";
                }

                var txtFuelSlipNo = document.getElementById(pref + "txtFuelSlipNo");
                var ddlFuelVendor = document.getElementById(pref + "ddlFuelVendor");
                var txtQtyLiter = document.getElementById(pref + "txtQtyLiter");
                var txtRate = document.getElementById(pref + "txtRate");
                var txtAmount = document.getElementById(pref + "txtAmount");

                if (txtFuelSlipNo.value == "") {
                    alert("Enter Fuel Slip No.")
                    txtFuelSlipNo.focus();
                    //document.getElementById(pref + "txtFrom").focus();
                    return false;
                }
                if (ddlFuelVendor.value == "") {
                    alert("Select Fuel Vendor");
                    ddlFuelVendor.focus();
                    //document.getElementById(pref + "txtTo").focus();
                    return false;
                }
                if (txtQtyLiter.value == "") {
                    alert("Enter Quantity in Liter");
                    txtQtyLiter.focus();
                    //document.getElementById(pref + "txtStartDate").focus();
                    return false;
                }

                if (txtRate.value == "") {
                    alert("Enter Rate");
                    txtRate.focus();
                    //document.getElementById(pref + "tb_StartTime_HH").focus();
                    return false;
                }

                if (txtAmount.value == "") {
                    alert("Enter Amount!!!");
                    txtAmount.focus();
                    return false;
                }

            }
        }
    }

    var hdnDummyAmt = document.getElementById("ctl00_MyCPH1_hdnDummyAmt");
    var hdnDummyCompare = document.getElementById("ctl00_MyCPH1_hdnDummyCompare");
    var lblpcamt = document.getElementById("ctl00_MyCPH1_lblpcamt");
    var lbladvamt = document.getElementById("ctl00_MyCPH1_lbladvamt");
    var lblnetbalamt = document.getElementById("ctl00_MyCPH1_lblnetbalamt");

    if (lblpcamt.innerText != "0") {
        if (lbladvamt.innerText != "0" || lbladvamt.innerText != "0" && lblpcamt.innerText == "0" || lblpcamt.innerText != "0") {
            if (lblnetbalamt.innerText == "0" || lblnetbalamt.innerText == "") {
                hdnDummyCompare.value = lblpcamt.innerText - lblnetbalamt.innerText;
            }
            else {
                hdnDummyCompare.value = lblnetbalamt.innerText;
            }
        }
        else if ((lbladvamt.innerText == "0" || lbladvamt.innerText == "") && (lblnetbalamt.innerText == "0" || lblnetbalamt.innerText == "")) {
            hdnDummyCompare.value = lblpcamt.innerText;
        }
        else if (lbladvamt.innerText == "0" && lblnetbalamt.innerText != "0") {
            hdnDummyCompare.value = lblnetbalamt.innerText;
        }
        else if (lbladvamt.innerText != "0") {
            hdnDummyCompare.value = lblnetbalamt.innerText;
        }
    }

    if (parseFloat(hdnDummyAmt.value) >= parseFloat(hdnDummyCompare.value)) {

        alert("You can not add the amount greater than " + hdnDummyCompare.value + " \r\nKindly change the Quantity and rate of Fuel!!!");
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


function CallA() {

    //foo = false;

    //alert(foo);

}




function CheckFromValidCityNEM(txtFromCity, hdFromCityCode, ddlFuelTypePD, txtRate, ddlFuelVendor) {
    var currentTime = new Date()
    var str_Index = "";
    //alert("Hi");
    //alert(ddlFuelVendor.value);
    //alert(txtRate.value);
    var txtIGST = document.getElementById(txtFromCity.id.replace('FromCity', 'IGST'));
    var txtSGST = document.getElementById(txtFromCity.id.replace("FromCity", "SGST"));
    var txtCGST = document.getElementById(txtFromCity.id.replace("FromCity", "CGST"));
    var txtamounttotal = document.getElementById(txtFromCity.id.replace("FromCity", "amounttotal"));
    if (ddlFuelTypePD.selectedIndex == "4") {
        txtIGST.Enabled = true;
        txtSGST.Enabled = true;
        txtCGST.Enabled = true;        
        txtIGST.disabled = false;
        txtSGST.disabled = false;
        txtCGST.disabled = false;
        
        txtIGST.style.borderStyle = "Groove";
        txtIGST.className = "input";
        txtSGST.style.borderStyle = "Groove";
        txtSGST.className = "input";
        txtCGST.style.borderStyle = "Groove";
        txtCGST.className = "input";      
    }
    else {
        txtIGST.Enabled = false;
        txtSGST.Enabled = false;
        txtCGST.Enabled = false;        
        txtIGST.disabled = true;
        txtSGST.disabled = true;
        txtCGST.disabled = true;        
        txtIGST.Text = "";
        txtSGST.Text = "";
        txtCGST.Text = "";
        txtamounttotal.Text = "";
        txtIGST.style.borderStyle = "None";
        txtIGST.className = "";
        txtSGST.style.borderStyle = "None";
        txtSGST.className = "";
        txtCGST.style.borderStyle = "None";
        txtCGST.className = "";
     
    }    
    if (txtFromCity.value == "") {
        return true;
    }
    createXMLHttpRequest();
    if (xmlHttpRequest) {

        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                //alert(returnValue);
                if (returnValue[0] == "N") {
                    alert("Invalid City. OR City Is not Defined In Fuel Rate Master With This Vendor !!! Please check.");
                    txtFromCity.value = "";
                    txtRate.value = "";
                    txtFromCity.focus();
                    return false;
                }
                else {

                    // alert(returnValue[1]);
                    hdFromCityCode.value = returnValue[1];
                    txtRate.value = returnValue[2];

                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckValidCityCodeFUEL&datetime=" + currentTime + "&CityName=" + txtFromCity.value + "&ddlFuelTypePD=" + ddlFuelTypePD.value + "&ddlFuelVendor=" + ddlFuelVendor.value, false);
        xmlHttpRequest.send(null);
    }
}


///Added by ritesh singh


function Validate() {
    var txtHoldFlag = document.getElementById("ctl00_MyCPH1_txtHoldFlag");
    if (Flag == true) {
        //var retVal = confirm("The Driver Licence is expired Do you want to continue ?");
        var retVal = confirm("The Driver OR Vehicle Document is expired Do you want to continue ?");
        if (retVal == true) {
            //var txtHoldFlag = document.getElementById("ctl00_MyCPH1_txtHoldFlag");
            txtHoldFlag.value = "Y";
            return true;
        }
        else {
            return false;
        }
    }
    else {
        txtHoldFlag.value = "N";
    }
}
function PushVehicleRequest(twoD) {
    try {
        var txtVehno = document.getElementById("ctl00_MyCPH1_txtVehno").value;
        var ListPushVehicleDriverRequest = [];
        // var PushVehicleDriverRequest = {};
        for (var i = 1; i <= 6; i++) {
            var PushVehicleDriverRequest = {};
            if (i <= 5 && (twoD[i]['Validation'] != '' || twoD[i]['Validation'] != "")) {
                dockdta_dd = twoD[i]['ExpiryDate'].substring(0, 2)
                dockdta_mm = twoD[i]['ExpiryDate'].substring(3, 5)
                dockdta_yy = twoD[i]['ExpiryDate'].substring(6, 10)
                var combineDatestr = dockdta_dd + " " + months1[dockdta_mm - 1 + 1] + " " + dockdta_yy;
                PushVehicleDriverRequest.VehicleDriverID = txtVehno;
                PushVehicleDriverRequest.RequestType = "V";
                PushVehicleDriverRequest.Branch = "HQTR";
                PushVehicleDriverRequest.ControllingLocation = "HQTR";
                PushVehicleDriverRequest.IsCancelled = "N";
                PushVehicleDriverRequest.EntryBy = "10001";
                PushVehicleDriverRequest.DocumentName = twoD[i]['Validation'];
                PushVehicleDriverRequest.ExpiryDate = combineDatestr;
                PushVehicleDriverRequest.GraceDays = twoD[i]['GraceDays'];
                PushVehicleDriverRequest.Value = null;
                PushVehicleDriverRequest.RequestOrder = i;
                PushVehicleDriverRequest.Document = twoD[i]['Document'];
                ListPushVehicleDriverRequest.push(PushVehicleDriverRequest);
            }
            if (i == 6 && (twoD[i]['Validation'] != '' || twoD[i]['Validation'] != "")) {
                var PushVehicleDriverRequest = {};
                PushVehicleDriverRequest.VehicleDriverID = txtVehno;
                PushVehicleDriverRequest.RequestType = "V";
                PushVehicleDriverRequest.Branch = "HQTR";
                PushVehicleDriverRequest.ControllingLocation = "HQTR";
                PushVehicleDriverRequest.IsCancelled = "N";
                PushVehicleDriverRequest.EntryBy = "10001";
                PushVehicleDriverRequest.DocumentName = twoD[i]['Validation'];
                PushVehicleDriverRequest.ExpiryDate = null;
                PushVehicleDriverRequest.GraceDays = twoD[i]['GraceDays'];
                PushVehicleDriverRequest.Value = twoD[i]['ExpiryDate'];
                PushVehicleDriverRequest.RequestOrder = i;
                PushVehicleDriverRequest.Document = twoD[i]['Document'];
                ListPushVehicleDriverRequest.push(PushVehicleDriverRequest);
            }
        }
        var ListPushVehicleDriverRequestData = { ListPushVehicleDriverRequest: ListPushVehicleDriverRequest };
        var listPushVehicleDriverRequestDataJson = JSON.stringify(ListPushVehicleDriverRequest);
        var url = "../../../../RestService/MasterService.svc/VehicleDriverRequestInsert";
        AjaxRequest(url, "POST", "application/json; charset=utf-8", "json", listPushVehicleDriverRequestDataJson, GenerateSuccess, GenerateError, false);
        return true;
    } catch (e) {
        alert(e.message);
        return false;
    }
}
function PushDriverRequest(twoD) {
    try {
        var txtDriver1 = document.getElementById("ctl00_MyCPH1_txtDriver1").value;
        var ListPushVehicleDriverRequest = [];
        //var PushVehicleDriverRequest = {};
        for (var i = 1; i <= 3; i++) {
            var PushVehicleDriverRequest = {};
            if (i <= 2 && (twoD[i]['Validation'] != '' || twoD[i]['Validation'] != "")) {
                dockdta_dd = twoD[i]['ExpiryDate'].substring(0, 2)
                dockdta_mm = twoD[i]['ExpiryDate'].substring(3, 5)
                dockdta_yy = twoD[i]['ExpiryDate'].substring(6, 10)
                var combineDatestr = dockdta_dd + " " + months1[dockdta_mm - 1 + 1] + " " + dockdta_yy;
                PushVehicleDriverRequest.VehicleDriverID = txtDriver1;
                PushVehicleDriverRequest.RequestType = "D";
                PushVehicleDriverRequest.Branch = "HQTR";
                PushVehicleDriverRequest.ControllingLocation = "HQTR";
                PushVehicleDriverRequest.IsCancelled = "N";
                PushVehicleDriverRequest.EntryBy = "10001";
                PushVehicleDriverRequest.DocumentName = twoD[i]['Validation'];
                PushVehicleDriverRequest.ExpiryDate = combineDatestr;
                PushVehicleDriverRequest.GraceDays = twoD[i]['GraceDays'];
                PushVehicleDriverRequest.Value = null;
                PushVehicleDriverRequest.RequestOrder = i;
                PushVehicleDriverRequest.Document = twoD[i]['Document'];
                ListPushVehicleDriverRequest.push(PushVehicleDriverRequest);
            }
            if (i == 3 && (twoD[i]['Validation'] != '' || twoD[i]['Validation'] != "")) {
                var PushVehicleDriverRequest = {};
                PushVehicleDriverRequest.VehicleDriverID = txtDriver1;
                PushVehicleDriverRequest.RequestType = "D";
                PushVehicleDriverRequest.Branch = "HQTR";
                PushVehicleDriverRequest.ControllingLocation = "HQTR";
                PushVehicleDriverRequest.IsCancelled = "N";
                PushVehicleDriverRequest.EntryBy = "10001";
                PushVehicleDriverRequest.DocumentName = twoD[i]['Validation'];
                PushVehicleDriverRequest.ExpiryDate = null;
                PushVehicleDriverRequest.GraceDays = twoD[i]['GraceDays'];
                PushVehicleDriverRequest.Value = twoD[i]['ExpiryDate'];
                PushVehicleDriverRequest.RequestOrder = i;
                PushVehicleDriverRequest.Document = twoD[i]['Document'];
                ListPushVehicleDriverRequest.push(PushVehicleDriverRequest);
            }
        }
        var ListPushVehicleDriverRequestData = { ListPushVehicleDriverRequest: ListPushVehicleDriverRequest };
        var listPushVehicleDriverRequestDataJson = JSON.stringify(ListPushVehicleDriverRequest);
        var url = "../../../../RestService/MasterService.svc/VehicleDriverRequestInsert";
        AjaxRequest(url, "POST", "application/json; charset=utf-8", "json", listPushVehicleDriverRequestDataJson, GenerateSuccess, GenerateError, false);
        return true;
    } catch (e) {
        alert(e.message);
        return false;
    }
}
function GenerateError(request, status, error) {

    alert(status)
    alert(error)
    return false;
}
function GenerateSuccess(request, status, error) {
    debugger;
    var datavalue = JSON.stringify(request);

    if (datavalue.indexOf("Error") != -1) {
        alert(datavalue);
        return false;
    } else {
        var hidRequestID = document.getElementById("ctl00_MyCPH1_hidRequestID").value = request;
        alert("Request sent for validate successfully.!");
        return true;
    }
}
function SubmitOnCancellationListing() {
    try {
        var radDate_0 = $("#" + controlIdPrefix + "DT_radDate_0");
        var txtDateFrom = $("#" + controlIdPrefix + "DT_txtDateFrom");
        var txtDateTo = $("#" + controlIdPrefix + "DT_txtDateTo");
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
        return true;
    } catch (e) { alert(e.message); return false; }
}

function SubmitOnValidate() {
    try {
        var countChecked = 0;
        countChecked = $("input[id*='chkRequest']:checked").length;
        if (parseFloat(countChecked) <= 0) {
            throw new Error("Please select at least one record ! ")
        }
        //return true;
    } catch (e) { alert(e.message); return false; }
}
function SetVehicleOpeningKM() {
    var txtVehOpnKM = document.getElementById("ctl00_MyCPH1_txtVehOpnKM");
    var hfVehOpnKM = document.getElementById("ctl00_MyCPH1_hfVehOpnKM");
    if (txtVehOpnKM.value != "") {
        if (parseFloat(txtVehOpnKM.value) < parseFloat(hfVehOpnKM.value)) {
            txtVehOpnKM.value = hfVehOpnKM.value;
        }
    }
}


function GetVehicleDetailToValidate() {
    try {


        //debugger;
        var retval = false;
        var currentTime = new Date();
        var txtVehno = document.getElementById("ctl00_MyCPH1_txtVehno");
        var txtVehno_Name = document.getElementById("ctl00_MyCPH1_txtVehno_Name");
        var txtVehModel = document.getElementById("ctl00_MyCPH1_txtVehModel");
        var txtVehCategory = document.getElementById("ctl00_MyCPH1_txtVehCategory");
        var txtVehCapacity = document.getElementById("ctl00_MyCPH1_txtVehCapacity");
        var txtVehOpnKM = document.getElementById("ctl00_MyCPH1_txtVehOpnKM");
        var hfVehOpnKM = document.getElementById("ctl00_MyCPH1_hfVehOpnKM");
        var txtVehOpnFuel = document.getElementById("ctl00_MyCPH1_txtVehOpnFuel");
        //var txtVehChecklist = document.getElementById("ctl00_MyCPH1_txtVehChecklist");
        var txtVehOpnFuelAmt = document.getElementById("ctl00_MyCPH1_txtVehOpnFuelAmt");
        var txtVehOpnAddBlue = document.getElementById("ctl00_MyCPH1_txtVehOpnAddBlue");        
        var txtVehOpnAddBlueAmt = document.getElementById("ctl00_MyCPH1_txtVehOpnAddBlueAmt");
        var txtDieselCarryForward = document.getElementById("ctl00_MyCPH1_txtDieselCarryForward");
        var txtDieselCarryForwardAmt = document.getElementById("ctl00_MyCPH1_txtDieselCarryForwardAmt");
        var txtStartLoc = document.getElementById("ctl00_MyCPH1_txtStartLoc");
        var hfVehicleLocation = document.getElementById("ctl00_MyCPH1_hfVehicleLocation");
        var txtVendorName = document.getElementById("ctl00_MyCPH1_txtVendorName");
        var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");
        var txtHoldFlag = document.getElementById("ctl00_MyCPH1_txtHoldFlag");

        var hidFitnessValidation = document.getElementById("ctl00_MyCPH1_hidFitnessValidation").value = "";
        var hidFitnessExpiryDate = document.getElementById("ctl00_MyCPH1_hidFitnessExpiryDate").value = "";
        var hidFitnessGraceDays = document.getElementById("ctl00_MyCPH1_hidFitnessGraceDays").value = "";
        var hidNationalPermitValidation = document.getElementById("ctl00_MyCPH1_hidNationalPermitValidation").value = "";
        var hidNationalPermitExpiryDate = document.getElementById("ctl00_MyCPH1_hidNationalPermitExpiryDate").value = "";
        var hidNationalPermitGraceDays = document.getElementById("ctl00_MyCPH1_hidNationalPermitGraceDays").value = "";
        var hid5YrPermitValidation = document.getElementById("ctl00_MyCPH1_hid5YrPermitValidation").value = "";
        var hid5YrPermitExpiryDate = document.getElementById("ctl00_MyCPH1_hid5YrPermitExpiryDate").value = "";
        var hid5YrPermitGraceDays = document.getElementById("ctl00_MyCPH1_hid5YrPermitGraceDays").value = "";
        var hidInsuranceValidation = document.getElementById("ctl00_MyCPH1_hidInsuranceValidation").value = "";
        var hidInsuranceExpiryDate = document.getElementById("ctl00_MyCPH1_hidInsuranceExpiryDate").value = "";
        var hidInsuranceGraceDays = document.getElementById("ctl00_MyCPH1_hidInsuranceGraceDays").value = "";
        var hidRoadTaxValidation = document.getElementById("ctl00_MyCPH1_hidRoadTaxValidation").value = "";
        var hidRoadTaxExpiryDate = document.getElementById("ctl00_MyCPH1_hidRoadTaxExpiryDate").value = "";
        var hidRoadTaxGraceDays = document.getElementById("ctl00_MyCPH1_hidRoadTaxGraceDays").value = "";
        var hidDieselLiterValidation = document.getElementById("ctl00_MyCPH1_hidDieselLiterValidation").value = "";
        var hidDieselLiter = document.getElementById("ctl00_MyCPH1_hidDieselLiter").value = "";
        var hidDieselLiterGrace = document.getElementById("ctl00_MyCPH1_hidDieselLiterGrace").value = "";
        var retValConcatl = "";

        if (txtVehno.value == "") {

            txtVehno_Name.value = "";
            txtVehModel.value = "";
            txtVehCategory.value = "";
            txtVehCapacity.value = "";
            txtVehOpnKM.value = "";
            hfVehOpnKM.value = "";
            txtVehOpnFuel.value = "";
            //txtVehChecklist.value = "";
            txtVehOpnFuelAmt.value = "";
            txtVehOpnAddBlue.value = "";
            txtVehOpnAddBlueAmt.value="";
            if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                txtDieselCarryForward.value = "";
                txtDieselCarryForwardAmt.value = "";
            }
            txtVendorName.value = "";
            return
        }
        var newRow = "";
        $("#tblVehicleDetails>tbody").html("");
        createXMLHttpRequest();
        if (xmlHttpRequest) {
            xmlHttpRequest.onreadystatechange = function () {
                if (xmlHttpRequest.readyState == 4) {
                    var returnValue = xmlHttpRequest.responseText.split("~");
                    if (returnValue[0] == "N") {
                        //alert("Invalid Vehicle No.")

                        txtVehno.value = "";
                        txtVehno_Name.value = "";
                        txtVehModel.value = "";
                        txtVehCategory.value = "";
                        txtVehCapacity.value = "";
                        txtVehOpnKM.value = "";
                        hfVehOpnKM.value = "";
                        txtVehOpnFuel.value = "";
                        //txtVehChecklist.value = "";
                        txtVehOpnFuelAmt.value = "";
                        txtVehOpnAddBlue.value = "";
                        txtVehOpnAddBlueAmt.value = "";
                        if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                            txtDieselCarryForward.value = "";
                            txtDieselCarryForwardAmt.value = "";
                        }
                        txtVendorName.value = "";
                        //txtVehno.focus();
                        return;
                    }
                    else {
                        var vFitness_Validity_Date = "";
                        var vInsurance_Validity_Date = "";
                        var vRoadTaxDt = "";
                        var vNationalPermitDt = "";

                        var InsuranceValidityDateTripValidation = "";
                        var FitnessValidityDateTripValidation = "";
                        var NationalPermitDtTripValidation = "";
                        var RoadTaxDtTripValidation = "";
                        var FiveYearPermitDtTripValidation = "";
                        var DieselLtrsTripValidation = "";
                        var retValConcat = "";
                        var FiveYearPermitDt = "";
                        var InsuranceDays = "0";
                        var FitnessDays = "0";
                        var NationalPermitDays = "0";
                        var RoadTaxDays = "0";
                        var FiveYearPermitDays = "0";
                        var TripSheetNumber = "";
                        var TripSheetDate = "";
                        var TripSheetOCloseDate = "";
                        var TripSheetCount = "0";
                        var RequestDieselLtrValidate = "";

                        vFitness_Validity_Date = returnValue[13];
                        vInsurance_Validity_Date = returnValue[12];
                        vRoadTaxDt = returnValue[14];
                        vNationalPermitDt = returnValue[15];

                        InsuranceValidityDateTripValidation = returnValue[16];
                        FitnessValidityDateTripValidation = returnValue[17];
                        NationalPermitDtTripValidation = returnValue[18];
                        RoadTaxDtTripValidation = returnValue[19];
                        FiveYearPermitDtTripValidation = returnValue[20];
                        DieselLtrsTripValidation = returnValue[21];
                        FiveYearPermitDt = returnValue[22];
                        InsuranceDays = returnValue[23];
                        FitnessDays = returnValue[24];
                        NationalPermitDays = returnValue[25];
                        RoadTaxDays = returnValue[26];
                        FiveYearPermitDays = returnValue[27];

                        TripSheetNumber = returnValue[35];
                        TripSheetDate = returnValue[36];
                        TripSheetOCloseDate = returnValue[37];
                        TripSheetCount = returnValue[38];
                        RequestDieselLtrValidate = returnValue[39];



                        if (!GetVehicleRequestGenerated(txtVehno)) {

                            txtVehno.value = "";
                            txtVehno_Name.value = "";
                            txtVehno.focus();
                            return false;
                        }



                        if (parseInt(TripSheetCount) > 2) {
                            alert("More then two trip sheet generation against this vehicle not allowed !!");
                            txtVehno.focus();
                            return false;
                        }

                        if (!IsDateGreater(vFitness_Validity_Date, hfTodayDate.value)) {
                            alert("Fitness Validity document expired  !!");
                            txtVehno.focus();
                            return false;
                        }

                        if (!IsDateGreater(vInsurance_Validity_Date, hfTodayDate.value)) {
                            alert("Insurance Validity document expired  !!");
                            txtVehno.focus();
                            return false;
                        }

                        if (!IsDateGreater(vRoadTaxDt, hfTodayDate.value)) {
                            alert("Road Tax  document expired !!")
                            return false;
                        }

                        if (!IsDateGreater(vNationalPermitDt, hfTodayDate.value)) {
                            alert("National Permit  document expired !!")
                            return false;
                        }


                        // if (hfVehicleLocation.value == "CONT_LOC") {


                        if (
                            (!IsDateGreater(hfTodayDate.value, returnValue[30]) || GetDateDiffInHrs(returnValue[30], hfTodayDate.value) <= 24)
                            && (returnValue[28] == "0") && (returnValue[29] == "") && (returnValue[30] != "")) {
                        }
                        else {
                            if (!IsDateGreater(InsuranceValidityDateTripValidation, hfTodayDate.value)) {
                                //if (retValConcat == "")
                                //{
                                newRow += "<tr class='bgbluegrey'>";
                                newRow += "<td><span id='Validation'>Vehicle Insurance Validity Expired.</td>";
                                newRow += "<td>Vehicle Insurance</td>";
                                newRow += "<td><span id='ExpiryDate'>" + InsuranceValidityDateTripValidation + "</span></td>";
                                newRow += "<td><span id='GraceDays'>" + InsuranceDays + "</span></td>";
                                newRow += "<td><input type='text' id='txtRemarks' value='' maxlength='250'><input type='hidden' id='hdnDocumentType' value='V'/><input type='hidden' id='hdnDocument' value='Insurance'/></td>";
                                newRow += "</tr>";
                                //retValConcat = " Expired Date:-" + vInsurance_Validity_Date + ".Grace Days:-" + InsuranceDays
                                //}
                                //else {
                                //  retValConcat = retValConcat + "\nVehicle Insurance Validity Expired. Expired Date:-" + vInsurance_Validity_Date + ".Grace Days:-" + InsuranceDays
                                //}
                                hidInsuranceValidation = "Vehicle Insurance Validity Expired. Expired Date:-" + InsuranceValidityDateTripValidation + ".Grace Days:-" + InsuranceDays;
                                hidInsuranceExpiryDate = vInsurance_Validity_Date;
                                hidInsuranceGraceDays = InsuranceDays;
                            }
                        }
                        if (
                             (!IsDateGreater(hfTodayDate.value, returnValue[31]) || GetDateDiffInHrs(returnValue[31], hfTodayDate.value) <= 24)
                            && (returnValue[28] == "0") && (returnValue[29] == "") && (returnValue[31] != "")) {
                        }
                        else {
                            if (!IsDateGreater(FitnessValidityDateTripValidation, hfTodayDate.value)) {
                                //if (retValConcat == "")
                                //{
                                newRow += "<tr class='bgbluegrey'>";
                                newRow += "<td><span id='Validation'>Fitness Validity Date Expired.</span></td>";
                                newRow += "<td>Fitness Validity</td>";
                                newRow += "<td><span id='ExpiryDate'>" + FitnessValidityDateTripValidation + "</span></td>";
                                newRow += "<td><span id='GraceDays'>" + FitnessDays + "</span></td>";
                                newRow += "<td><input type='text' id='txtRemarks' value='' maxlength='250'><input type='hidden' id='hdnDocumentType' value='V'/><input type='hidden' id='hdnDocument' value='Fitness'/></td>";
                                newRow += "</tr>";

                                //retValConcat = "Fitnes Validity Date Expired. Expired Date:-" + vFitness_Validity_Date + ".Grace Days:-" + FitnessDays
                                //}
                                //else {
                                //  retValConcat = retValConcat + "\nFitnes Validity Date Expired. Expired Date:-" + vFitness_Validity_Date + ".Grace Days:-" + FitnessDays
                                //}
                                hidFitnessValidation = "Fitnes Validity Date Expired. Expired Date:-" + FitnessValidityDateTripValidation + ".Grace Days:-" + FitnessDays
                                hidFitnessExpiryDate = vFitness_Validity_Date;
                                hidFitnessGraceDays = FitnessDays;
                            }
                        }
                        if (
                             (!IsDateGreater(hfTodayDate.value, returnValue[32]) || GetDateDiffInHrs(returnValue[32], hfTodayDate.value) <= 24)
                            && (returnValue[28] == "0") && (returnValue[29] == "") && (returnValue[32] != "")) {
                        }
                        else {
                            if (!IsDateGreater(NationalPermitDtTripValidation, hfTodayDate.value)) {
                                //if (retValConcat == "")
                                //{
                                newRow += "<tr class='bgbluegrey'>";
                                newRow += "<td><span id='Validation'>National Permit Date Expired.</span></td>";
                                newRow += "<td>National Permit</td>";
                                newRow += "<td><span id='ExpiryDate'>" + NationalPermitDtTripValidation + "</span></td>";
                                newRow += "<td><span id='GraceDays'>" + NationalPermitDays + "</span></td>";
                                newRow += "<td><input type='text' id='txtRemarks' value='' maxlength='250'><input type='hidden' id='hdnDocumentType' value='V'/><input type='hidden' id='hdnDocument' value='NationalPermit'/></td>";
                                newRow += "</tr>";

                                // retValConcat = "National Permit Date Expired. Expired Date:-" + vNationalPermitDt + ".Grace Days:-" + NationalPermitDays
                                //}
                                //else {
                                //  retValConcat = retValConcat + "\nNational Permit Date Expired. Expired Date:-" + vNationalPermitDt + ".Grace Days:-" + NationalPermitDays
                                //}
                                hidNationalPermitValidation = "National Permit Date Expired. Expired Date:-" + NationalPermitDtTripValidation + ".Grace Days:-" + NationalPermitDays
                                hidNationalPermitExpiryDate = vNationalPermitDt;
                                hidNationalPermitGraceDays = NationalPermitDays;
                            }
                        }
                        if (
                            (!IsDateGreater(hfTodayDate.value, returnValue[33]) || GetDateDiffInHrs(returnValue[33], hfTodayDate.value) <= 24)
                            && (returnValue[28] == "0") && (returnValue[29] == "") && (returnValue[33] != "")) {
                        }
                        else {
                            if (!IsDateGreater(RoadTaxDtTripValidation, hfTodayDate.value)) {
                                //if (retValConcat == "")
                                //{
                                newRow += "<tr class='bgbluegrey'>";
                                newRow += "<td><span id='Validation'>Road Tax Date Expired.</span></td>";
                                newRow += "<td>Road Tax</td>";
                                newRow += "<td><span id='ExpiryDate'>" + RoadTaxDtTripValidation + "</span></td>";
                                newRow += "<td><span id='GraceDays'>" + RoadTaxDays + "</span></td>";
                                newRow += "<td><input type='text' id='txtRemarks' value='' maxlength='250'><input type='hidden' id='hdnDocumentType' value='V'/><input type='hidden' id='hdnDocument' value='RoadTax'/></td>";
                                newRow += "</tr>";
                                //retValConcat = "Road Tax Date Expired. Expired Date:-" + vRoadTaxDt + ".Grace Days:-" + RoadTaxDays
                                //}
                                //else {
                                // retValConcat = retValConcat + "\nRoad Tax Date Expired. Expired Date:-" + vRoadTaxDt + ".Grace Days:-" + RoadTaxDays
                                //}
                                hidRoadTaxValidation = "Road Tax Date Expired. Expired Date:-" + RoadTaxDtTripValidation + ".Grace Days:-" + RoadTaxDays
                                hidRoadTaxExpiryDate = vRoadTaxDt;
                                hidRoadTaxGraceDays = RoadTaxDays;
                            }
                        }
                        if (
                             (!IsDateGreater(hfTodayDate.value, returnValue[34]) || GetDateDiffInHrs(returnValue[34], hfTodayDate.value) <= 24)
                            && (returnValue[28] == "0") && (returnValue[29] == "") && (returnValue[34] != "")) {
                        }
                        else {
                            if (!IsDateGreater(FiveYearPermitDtTripValidation, hfTodayDate.value)) {

                                //if (retValConcat == "")
                                //{
                                newRow += "<tr class='bgbluegrey'>";
                                newRow += "<td><span id='Validation'>Five Year Permit Date Expired.</span></td>";
                                newRow += "<td>Five Year Permit</td>";
                                newRow += "<td><span id='ExpiryDate'>" + FiveYearPermitDtTripValidation + "</span></td>";
                                newRow += "<td><span id='GraceDays'>" + FiveYearPermitDays + "</span></td>";
                                newRow += "<td><input type='text' id='txtRemarks' value='' maxlength='250'><input type='hidden' id='hdnDocumentType' value='V'/><input type='hidden' id='hdnDocument' value='5YrPermit'/></td>";
                                newRow += "</tr>";
                                //  retValConcat = "Five Year Permit Date Expired. Expired Date:-" + FiveYearPermitDt + ".Grace Days:-" + FiveYearPermitDays
                                //}
                                //else {
                                //retValConcat = retValConcat + "\nFive Year Permit Date Expired. Expired Date:-" + FiveYearPermitDt + ".Grace Days:-" + FiveYearPermitDays
                                //}
                                hid5YrPermitValidation = "Five Year Permit Date Expired. Expired Date:-" + FiveYearPermitDtTripValidation + ".Grace Days:-" + FiveYearPermitDays
                                hid5YrPermitExpiryDate = FiveYearPermitDt;
                                hid5YrPermitGraceDays = FiveYearPermitDays;
                            }
                        }
                        //returnValue[8] carryforward Ltr
                        if ((parseFloat(DieselLtrsTripValidation) < parseFloat(returnValue[8])) && RequestDieselLtrValidate == "") {

                            //if (retValConcat == "")
                            //{
                            newRow += "<tr class='bgbluegrey'>";
                            newRow += "<td><span id='Validation'>Diesel Ltrs are not valid for Trip Validation.</span></td>";
                            newRow += "<td>Diesel Ltrs</td>";
                            newRow += "<td><span id='ExpiryDate'>" + DieselLtrsTripValidation + "</span></td>";
                            newRow += "<td><span id='GraceDays'>" + returnValue[8] + "</span></td>";
                            newRow += "<td><input type='text' id='txtRemarks' value='' maxlength='250'><input type='hidden' id='hdnDocumentType' value='V'/><input type='hidden' id='hdnDocument' value='DieselLiter'/></td>";
                            newRow += "</tr>";
                            // retValConcat = "Diesel Ltrs are not valid for Trip Validation. Diesel Ltrs:-" + returnValue[7]
                            //}
                            //else {
                            // retValConcat = retValConcat + "\nDiesel Ltrs are not valid for Trip Validation. Diesel Ltrs:-" + returnValue[7]
                            //}
                            hidDieselLiterValidation = "Diesel Ltrs are not valid for Trip Validation. Diesel Ltrs:-" + returnValue[7]
                            hidDieselLiter = DieselLtrsTripValidation;
                            hidDieselLiterGrace = returnValue[7];
                        }
                        if (TripSheetCount == "1") {
                            newRow += "<tr class='bgbluegrey'>";
                            newRow += "<td><span id='Validation'>Trip Sheet pending for financial close.</span></td>";
                            newRow += "<td>" + TripSheetNumber + "</td>";
                            newRow += "<td><span id='ExpiryDate'>" + TripSheetDate + "</span></td>";
                            newRow += "<td><span id='GraceDays'>" + TripSheetOCloseDate + "</span></td>";
                            newRow += "<td><input type='text' id='txtRemarks' value='' maxlength='250'><input type='hidden' id='hdnDocumentType' value='V'/><input type='hidden' id='hdnDocument' value='TripSheet'/></td>";
                            newRow += "</tr>";
                        }

                        //if (retValConcat == "")
                        //{ retValConcat = "" }
                        //else {
                        //    retValConcat = retValConcat + "\n Do You Want To Send for Validation ?"
                        //}
                        //var retVal = "";
                        //if (txtStartLoc.innerText == returnValue[2].toUpperCase()) {
                        //    //                            alert("Vehicle Insurance_Validity_Date OR Fitness_Validity_Date OR RoadTax_Date OR NationalPermit_Date is Expired");
                        //    if (retValConcat == "") {
                        //        retVal = true
                        //    }
                        //    else {
                        //        if (retValConcatl != "") {
                        //            alert(retValConcatl);
                        //            txtVehno.value = "";
                        //            txtVehno_Name.value = "";
                        //            retVal = false;
                        //        }
                        //        else {
                        //            retVal = confirm(retValConcat);
                        //        }
                        //    }
                        //    if (retVal == true) {
                        //        txtVehModel.value = returnValue[3];
                        //        txtVehCategory.value = returnValue[4];
                        //        txtVehCapacity.value = returnValue[5];
                        //        txtVehOpnKM.value = returnValue[6];
                        //        hfVehOpnKM.value = returnValue[6];
                        //        //txtVehOpnFuel.value = returnValue[7];
                        //        //txtVehChecklist.value = returnValue[8];
                        //        //txtVehOpnFuelAmt.value = returnValue[9];
                        //        if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                        //            txtDieselCarryForward.value = returnValue[7];
                        //            txtDieselCarryForwardAmt.value = returnValue[8];
                        //        }
                        //        txtVendorName.value = returnValue[11];
                        //        var twoD = new Array();
                        //        twoD[1] = new Array();
                        //        twoD[1]['Validation'] = hidFitnessValidation;
                        //        twoD[1]['ExpiryDate'] = hidFitnessExpiryDate;
                        //        twoD[1]['GraceDays'] = hidFitnessGraceDays;
                        //        twoD[1]['Document'] = "Fitness";

                        //        twoD[2] = new Array();
                        //        twoD[2]['Validation'] = hidNationalPermitValidation;
                        //        twoD[2]['ExpiryDate'] = hidNationalPermitExpiryDate;
                        //        twoD[2]['GraceDays'] = hidNationalPermitGraceDays;
                        //        twoD[2]['Document'] = "NationalPermit";

                        //        twoD[3] = new Array();
                        //        twoD[3]['Validation'] = hid5YrPermitValidation;
                        //        twoD[3]['ExpiryDate'] = hid5YrPermitExpiryDate;
                        //        twoD[3]['GraceDays'] = hid5YrPermitGraceDays;
                        //        twoD[3]['Document'] = "5YrPermit";

                        //        twoD[4] = new Array();
                        //        twoD[4]['Validation'] = hidInsuranceValidation;
                        //        twoD[4]['ExpiryDate'] = hidInsuranceExpiryDate;
                        //        twoD[4]['GraceDays'] = hidInsuranceGraceDays;
                        //        twoD[4]['Document'] = "Insurance";

                        //        twoD[5] = new Array();
                        //        twoD[5]['Validation'] = hidRoadTaxValidation;
                        //        twoD[5]['ExpiryDate'] = hidRoadTaxExpiryDate;
                        //        twoD[5]['GraceDays'] = hidRoadTaxGraceDays;
                        //        twoD[5]['Document'] = "RoadTax";

                        //        twoD[6] = new Array();
                        //        twoD[6]['Validation'] = hidDieselLiterValidation;
                        //        twoD[6]['ExpiryDate'] = hidDieselLiter;
                        //        twoD[6]['GraceDays'] = hidDieselLiterGrace;
                        //        twoD[6]['Document'] = "DieselLiter";
                        //        if (retValConcat != "") {
                        //            if (PushVehicleRequest(twoD)) {
                        //                //alert("Request Generated. Request No:-" + document.getElementById("ctl00_MyCPH1_hidRequestID").value);
                        //                alert("Request Sent Successfully for validation");
                        //                txtVehno.value = "";
                        //                txtVehno_Name.value = "";
                        //                txtVehModel.value = "";
                        //                txtVehCategory.value = "";
                        //                txtVehCapacity.value = "";
                        //                txtVehOpnKM.value = "";
                        //                hfVehOpnKM.value = "";
                        //                txtVehOpnFuel.value = "";
                        //                //txtVehChecklist.value = "";
                        //                txtVehOpnFuelAmt.value = "";
                        //                if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                        //                    txtDieselCarryForward.value = "";
                        //                    txtDieselCarryForwardAmt.value = "";
                        //                }
                        //                txtVendorName.value = "";
                        //                txtVehno.focus();
                        //                Flag = true;
                        //            }
                        //            else {
                        //                alert("Request Failed");
                        //                txtVehno.value = "";
                        //                txtVehno_Name.value = "";
                        //                txtVehModel.value = "";
                        //                txtVehCategory.value = "";
                        //                txtVehCapacity.value = "";
                        //                txtVehOpnKM.value = "";
                        //                hfVehOpnKM.value = "";
                        //                txtVehOpnFuel.value = "";
                        //                //txtVehChecklist.value = "";
                        //                txtVehOpnFuelAmt.value = "";
                        //                if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                        //                    txtDieselCarryForward.value = "";
                        //                    txtDieselCarryForwardAmt.value = "";
                        //                }
                        //                txtVendorName.value = "";
                        //                txtVehno.focus();
                        //                return false;
                        //            }
                        //        }
                        //    }
                        //    return false;

                        //}
                        //else {
                        //    alert("Vehicle's Controlling Location is not from " + txtStartLoc.innerText + " branch");
                        //    txtVehno.value = "";
                        //    txtVehno_Name.value = "";
                        //    txtVehModel.value = "";
                        //    txtVehCategory.value = "";
                        //    txtVehCapacity.value = "";
                        //    txtVehOpnKM.value = "";
                        //    hfVehOpnKM.value = "";
                        //    txtVehOpnFuel.value = "";
                        //    //txtVehChecklist.value = "";
                        //    txtVehOpnFuelAmt.value = "";
                        //    if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                        //        txtDieselCarryForward.value = "";
                        //        txtDieselCarryForwardAmt.value = "";
                        //    }
                        //    txtVendorName.value = "";
                        //    txtVehno.focus();
                        //}
                        //}
                        //else if (hfVehicleLocation.value == "CUR_LOC") {
                        //else if (hfVehicleLocation.value == "CUR_LOC" || IsDateGreater(hfTodayDate.value, vInsurance_Validity_Date) || IsDateGreater(hfTodayDate.value, vFitness_Validity_Date) || IsDateGreater(hfTodayDate.value, vRoadTaxDt) || IsDateGreater(hfTodayDate.value, vNationalPermitDt)) {
                        //    if (txtStartLoc.innerText == returnValue[9]) {
                        //        //alert("Vehicle Insurance_Validity_Date OR Fitness_Validity_Date OR RoadTax_Date OR NationalPermit_Date is Expired");
                        //        var retVal = confirm("Vehicle Insurance_Validity OR Fitness_Validity OR RoadTax OR NationalPermit Date is Expired \n Do You Want To continue ?");
                        //        if (retVal == true) {

                        //            txtVehModel.value = returnValue[3];
                        //            txtVehCategory.value = returnValue[4];
                        //            txtVehCapacity.value = returnValue[5];
                        //            txtVehOpnKM.value = returnValue[6];
                        //            hfVehOpnKM.value = returnValue[6];
                        //            //txtVehOpnFuel.value = returnValue[7];
                        //            //txtVehChecklist.value = returnValue[8];
                        //            //txtVehOpnFuelAmt.value = returnValue[9];
                        //            if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                        //                txtDieselCarryForward.value = returnValue[7];
                        //                txtDieselCarryForwardAmt.value = returnValue[8];
                        //            }
                        //            txtVendorName.value = returnValue[11];
                        //            Flag = true;
                        //        }
                        //        else {
                        //            return false;
                        //        }
                        //    }
                        //    else {
                        //        alert("Vehicle's Current Location is not from " + txtStartLoc.innerText + " branch");
                        //        txtVehno.value = "";
                        //        txtVehno_Name.value = "";
                        //        txtVehModel.value = "";
                        //        txtVehCategory.value = "";
                        //        txtVehCapacity.value = "";
                        //        txtVehOpnKM.value = "";
                        //        hfVehOpnKM.value = "";
                        //        txtVehOpnFuel.value = "";
                        //        //txtVehChecklist.value = "";
                        //        txtVehOpnFuelAmt.value = "";
                        //        if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                        //            txtDieselCarryForward.value = "";
                        //            txtDieselCarryForwardAmt.value = "";
                        //        }
                        //        txtVendorName.value = "";
                        //        txtVehno.focus();
                        //    }
                        //}
                        //    //else if (hfVehicleLocation.value == "NONE") {
                        //else if (hfVehicleLocation.value == "NONE" || IsDateGreater(hfTodayDate.value, vInsurance_Validity_Date) || IsDateGreater(hfTodayDate.value, vFitness_Validity_Date) || IsDateGreater(hfTodayDate.value, vRoadTaxDt) || IsDateGreater(hfTodayDate.value, vNationalPermitDt)) {
                        //    //alert("Vehicle Insurance_Validity_Date OR Fitness_Validity_Date OR RoadTax_Date OR NationalPermit_Date is Expired");
                        //    var retVal = confirm("Vehicle Insurance_Validity OR Fitness_Validity OR RoadTax OR NationalPermit Date is Expired \n Do You Want To continue ?");
                        //    if (retVal == true) {
                        //        txtVehModel.value = returnValue[3];
                        //        txtVehCategory.value = returnValue[4];
                        //        txtVehCapacity.value = returnValue[5];
                        //        txtVehOpnKM.value = returnValue[6];
                        //        hfVehOpnKM.value = returnValue[6];
                        //        //txtVehOpnFuel.value = returnValue[7];
                        //        //txtVehChecklist.value = returnValue[8];
                        //        //txtVehOpnFuelAmt.value = returnValue[9];
                        //        if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                        //            txtDieselCarryForward.value = returnValue[7];
                        //            txtDieselCarryForwardAmt.value = returnValue[8];
                        //        }
                        //        txtVendorName.value = returnValue[11];
                        //        Flag = true;
                        //    }
                        //    else {
                        //        return false;
                        //    }
                        //}
                        //if (returnValue[10] == "In Transit") {
                        //    alert("Vehicle is in Transit Mode \r\n Kindly Select Another Vehicle.");
                        //    txtVehno.value = "";
                        //    txtVehno_Name.value = "";
                        //    txtVehModel.value = "";
                        //    txtVehCategory.value = "";
                        //    txtVehCapacity.value = "";
                        //    txtVehOpnKM.value = "";
                        //    hfVehOpnKM.value = "";
                        //    txtVehOpnFuel.value = "";
                        //    //txtVehChecklist.value = "";
                        //    txtVehOpnFuelAmt.value = "";
                        //    if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
                        //        txtDieselCarryForward.value = "";
                        //        txtDieselCarryForwardAmt.value = "";
                        //    }
                        //    txtVendorName.value = "";
                        //    txtVehno.focus();
                        //}

                    }
                }
            }
            xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=FillVehicleDetailsMaster&datetime=" + currentTime + "&Vehno=" + txtVehno.value, false);
            xmlHttpRequest.send(null);
        }


        /*
        Driver 1 details to be validate
        */

        //var LblDriver1Name = document.getElementById("ctl00_MyCPH1_LblDriver1Name");
        var txtDriver1 = document.getElementById("ctl00_MyCPH1_txtDriver1");
        var lblDriver1Licno = document.getElementById("ctl00_MyCPH1_lblDriver1Licno");
        var lblDriver1ValidDt = document.getElementById("ctl00_MyCPH1_lblDriver1ValidDt");
        var hf_Manual_Driver1_Code = document.getElementById("ctl00_MyCPH1_hf_Manual_Driver1_Code");
        var txtDriver2 = document.getElementById("ctl00_MyCPH1_txtDriver2");
        var LblDriverBalance = document.getElementById("ctl00_MyCPH1_LblDriverBalance");

        var hfDriver_Photo = document.getElementById("ctl00_MyCPH1_hfDriver_Photo");
        var hfDriver_photo_Rule = document.getElementById("ctl00_MyCPH1_hfDriver_photo_Rule");
        var hfDriverLic_Validity = document.getElementById("ctl00_MyCPH1_hfDriverLic_Validity");
        var hfDriverLic_Validity_Rule = document.getElementById("ctl00_MyCPH1_hfDriverLic_Validity_Rule");
        var hfDriver_TripCount = document.getElementById("ctl00_MyCPH1_hfDriver_TripCount");
        var hfDriver_TripCount_Rule = document.getElementById("ctl00_MyCPH1_hfDriver_TripCount_Rule");
        var hfTot_No_Trip = document.getElementById("ctl00_MyCPH1_hfTot_No_Trip");
        var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");
        var txtDriver1Name = document.getElementById("ctl00_MyCPH1_txtDriver1Name");

        var ddlDriver1 = document.getElementById("ctl00_MyCPH1_ddlDriver1");
        var lblDriver1LicView = document.getElementById("ctl00_MyCPH1_lblDriver1LicView");
        var lblDriver1PhotoView = document.getElementById("ctl00_MyCPH1_lblDriver1PhotoView");
        var ddlDriver2 = document.getElementById("ctl00_MyCPH1_ddlDriver2");
        var ddlCleaner = document.getElementById("ctl00_MyCPH1_ddlCleaner");

        var hidDriverLicValidation = document.getElementById("ctl00_MyCPH1_hidDriverLicValidation").value = "";
        var hidDriverLicExpiryDate = document.getElementById("ctl00_MyCPH1_hidDriverLicExpiryDate").value = "";
        var hidDriverLicGraceDays = document.getElementById("ctl00_MyCPH1_hidDriverLicGraceDays").value = "";
        var hidDriverLicVerifValidation = document.getElementById("ctl00_MyCPH1_hidDriverLicVerifValidation").value = "";
        var hidDriverLicVerifExpiryDate = document.getElementById("ctl00_MyCPH1_hidDriverLicVerifExpiryDate").value = "";
        var hidDriverLicVerifGraceDays = document.getElementById("ctl00_MyCPH1_hidDriverLicVerifGraceDays").value = "";
        var hidCashValidation = document.getElementById("ctl00_MyCPH1_hidCashValidation").value = "";
        var hidCash = document.getElementById("ctl00_MyCPH1_hidCash").value = "";
        var hidCashGrace = document.getElementById("ctl00_MyCPH1_hidCashGrace").value = "";
        var retValConcatl = "";

        createXMLHttpRequest();
        if (xmlHttpRequest) {
            xmlHttpRequest.onreadystatechange = function () {
                if (xmlHttpRequest.readyState == 4) {
                    var returnValue = xmlHttpRequest.responseText.split("~");
                    if (returnValue[0] == "N") {
                        //LblDriver1Name.value = "";
                        //alert("Invalid Driver!!");
                        txtDriver1.value = "";
                        txtDriver1Name.value = "";
                        lblDriver1Licno.value = "";
                        lblDriver1ValidDt.value = "";
                        hf_Manual_Driver1_Code.value = "";
                        //LblDriverBalance.value = "";
                        lblDriver1LicView.innerText = "";
                        lblDriver1PhotoView.innerText = "";
                        //txtDriver1.focus();
                        return false;
                    }
                    else {
                        var mDriverLic_Validity = "";
                        var mDriver_Photo = "";
                        var mDriver_TripCount = "";

                        mDriverLic_Validity = returnValue[3];
                        mDriver_Photo = returnValue[5];
                        mDriver_TripCount = returnValue[6];


                        var LicenseValditydtTripValidation = "";
                        var LicenseVerifiedDtTripValidation = "";
                        var DriverCashTripValidation = "";
                        var DriverLicenseDays = "";
                        var DriverLicVerificationDays = "";
                        var vValdity_dt = "";
                        var vLicense_Verified_Dt = "";
                        var retValConcat = "";
                        var retVal = "";
                        vValdity_dt = returnValue[3];
                        vLicense_Verified_Dt = returnValue[14];
                        LicenseValditydtTripValidation = returnValue[11];
                        LicenseVerifiedDtTripValidation = returnValue[12];
                        DriverCashTripValidation = returnValue[13];
                        DriverLicenseDays = returnValue[15];
                        DriverLicVerificationDays = returnValue[16];
                        hf_Manual_Driver1_Code.value = returnValue[4]

                        var LblDriverBalance = document.getElementById("ctl00_MyCPH1_LblDriverBalance");


                        if (!IsDateGreater(vValdity_dt, hfTodayDate.value)) {
                            throw ("Licence Validity document expired  !!");
                            txtDriver1.focus();
                            //return false;
                        }


                        
                        if (IsDateGreater(hfTodayDate.value, returnValue[19]) && (returnValue[17] == "0") && (returnValue[18] == "") && (returnValue[19] != "")) {
                        }
						 else if ((returnValue[17] == "0") && (returnValue[18] == "") && (returnValue[19] != "")) {
                        }
                        else {
                            if (!IsDateGreater(LicenseValditydtTripValidation, hfTodayDate.value)) {
                                //if (retValConcat == "")
                                //{
                                newRow += "<tr class='bgbluegrey'>";
                                newRow += "<td><span id='Validation'>Driver 1 License valdity date Expired.</td>";
                                newRow += "<td>Driver 1 License valdity</td>";
                                newRow += "<td><span id='ExpiryDate'>" + vValdity_dt + "</span></td>";
                                newRow += "<td><span id='GraceDays'>" + DriverLicenseDays + "</span></td>";
                                newRow += "<td><input type='text' id='txtRemarks' value='' maxlength='250'><input type='hidden' id='hdnDocumentType' value='D'/><input type='hidden' id='hdnDocument' value='DriverLicense'/></td>";
                                newRow += "</tr>";

                                //retValConcat = " Expired Date:-" + vValdity_dt + ".Grace Days:-" + DriverLicenseDays
                                //}
                                //else {
                                //    retValConcat = retValConcat + "\nLicense valdity date Expired. Expired Date:-" + vValdity_dt + ".Grace Days:-" + DriverLicenseDays
                                //}
                                hidDriverLicValidation = "License valdity date Expired. Expired Date:-" + vValdity_dt + ".Grace Days:-" + DriverLicenseDays
                                hidDriverLicExpiryDate = vValdity_dt;
                                hidDriverLicGraceDays = DriverLicenseDays;
                            }
                        }
                        if (IsDateGreater(hfTodayDate.value, returnValue[20]) && (returnValue[17] == "0") && (returnValue[18] == "") && (returnValue[20] != "")) {
                        }
                        else {
                            if (!IsDateGreater(LicenseVerifiedDtTripValidation, hfTodayDate.value)) {

                                newRow += "<tr class='bgbluegrey'>";
                                newRow += "<td><span id='Validation'>Driver 1 License Verified Date Expired.</td>";
                                newRow += "<td>Driver 1 License Verification Expired</td>";
                                newRow += "<td><span id='ExpiryDate'>" + vLicense_Verified_Dt + "</span></td>";
                                newRow += "<td><span id='GraceDays'>" + DriverLicVerificationDays + "</span></td>";
                                newRow += "<td><input type='text' id='txtRemarks' value='' maxlength='250'><input type='hidden' id='hdnDocument' value='DriverLicenseVerification'/><input type='hidden' id='hdnDocumentType' value='D'/></td>";
                                newRow += "</tr>";

                                hidDriverLicVerifValidation = "License Verified Date Expired. Expired Date:-" + vLicense_Verified_Dt + ".Grace Days:-" + DriverLicVerificationDays
                                hidDriverLicVerifExpiryDate = vLicense_Verified_Dt;
                                hidDriverLicVerifGraceDays = DriverLicVerificationDays;
                            }
                        }
                        if (parseFloat(DriverCashTripValidation) < parseFloat(LblDriverBalance.value) && returnValue[21] == "") {

                            //if (retValConcat == "")
                            //{
                            newRow += "<tr class='bgbluegrey'>";
                            newRow += "<td><span id='Validation'>Driver 1 Cash is not valid for Trip Validation.</td>";
                            newRow += "<td>Driver 1 License Verified</td>";
                            newRow += "<td><span id='ExpiryDate'>" + LblDriverBalance.value + "</span></td>";
                            newRow += "<td><span id='GraceDays'>" + DriverCashTripValidation + "</span></td>";
                            newRow += "<td><input type='text' id='txtRemarks' value='' maxlength='250'><input type='hidden' id='hdnDocumentType' value='D'/><input type='hidden' id='hdnDocument' value='Cash'/></td>";
                            newRow += "</tr>";
                            //    retValConcat = "Driver Cash is not valid for Trip Validation. Cash:-" + DriverCashTripValidation
                            //}
                            //else {
                            //    retValConcat = retValConcat + "\nDriver Cash is not valid for Trip Validation. Cash:-" + DriverCashTripValidation
                            //}
                            hidCashValidation = "Driver Cash is not valid for Trip Validation. Cash:-" + DriverCashTripValidation
                            hidCashGrace = DriverCashTripValidation;
                            hidCash = LblDriverBalance.value;
                        }


                    }
                }
            }
            xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=GetNewDriverDetailsMaster&datetime=" + currentTime + "&DriverId=" + txtDriver1.value + "&VEHNO=" + txtVehno.value, false);
            xmlHttpRequest.send(null);

        }




        if (newRow != "") {

            $("#tblVehicleDetails>tbody").html(newRow);
            retval = true;

        } else {

            retval = false;
        }

    } catch (e) {
        alert(e.message);
        retval = false;
    }
    return retval;
}

function CancelVehicle() {
    var txtVehno = document.getElementById("ctl00_MyCPH1_txtVehno");
    var txtVehno_Name = document.getElementById("ctl00_MyCPH1_txtVehno_Name");
    var txtVehModel = document.getElementById("ctl00_MyCPH1_txtVehModel");
    var txtVehCategory = document.getElementById("ctl00_MyCPH1_txtVehCategory");
    var txtVehCapacity = document.getElementById("ctl00_MyCPH1_txtVehCapacity");
    var txtVehOpnKM = document.getElementById("ctl00_MyCPH1_txtVehOpnKM");
    var hfVehOpnKM = document.getElementById("ctl00_MyCPH1_hfVehOpnKM");
    var txtVehOpnFuel = document.getElementById("ctl00_MyCPH1_txtVehOpnFuel");
    var txtVehOpnFuelAmt = document.getElementById("ctl00_MyCPH1_txtVehOpnFuelAmt");
    var txtVehOpnAddBlue = document.getElementById("ctl00_MyCPH1_txtVehOpnAddBlue");
    var txtVehOpnAddBlueAmt = document.getElementById("ctl00_MyCPH1_txtVehOpnAddBlueAmt");
    var txtDieselCarryForward = document.getElementById("ctl00_MyCPH1_txtDieselCarryForward");
    var txtDieselCarryForwardAmt = document.getElementById("ctl00_MyCPH1_txtDieselCarryForwardAmt");
    var txtStartLoc = document.getElementById("ctl00_MyCPH1_txtStartLoc");
    var hfVehicleLocation = document.getElementById("ctl00_MyCPH1_hfVehicleLocation");
    var txtVendorName = document.getElementById("ctl00_MyCPH1_txtVendorName");
    var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");
    var txtHoldFlag = document.getElementById("ctl00_MyCPH1_txtHoldFlag");


    var txtDriver1 = document.getElementById("ctl00_MyCPH1_txtDriver1");
    var lblDriver1Licno = document.getElementById("ctl00_MyCPH1_lblDriver1Licno");
    var lblDriver1ValidDt = document.getElementById("ctl00_MyCPH1_lblDriver1ValidDt");
    var hf_Manual_Driver1_Code = document.getElementById("ctl00_MyCPH1_hf_Manual_Driver1_Code");
    var txtDriver2 = document.getElementById("ctl00_MyCPH1_txtDriver2");
    var LblDriverBalance = document.getElementById("ctl00_MyCPH1_LblDriverBalance");

    var hfDriver_Photo = document.getElementById("ctl00_MyCPH1_hfDriver_Photo");
    var hfDriver_photo_Rule = document.getElementById("ctl00_MyCPH1_hfDriver_photo_Rule");
    var hfDriverLic_Validity = document.getElementById("ctl00_MyCPH1_hfDriverLic_Validity");
    var hfDriverLic_Validity_Rule = document.getElementById("ctl00_MyCPH1_hfDriverLic_Validity_Rule");
    var hfDriver_TripCount = document.getElementById("ctl00_MyCPH1_hfDriver_TripCount");
    var hfDriver_TripCount_Rule = document.getElementById("ctl00_MyCPH1_hfDriver_TripCount_Rule");
    var hfTot_No_Trip = document.getElementById("ctl00_MyCPH1_hfTot_No_Trip");
    var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");
    var txtDriver1Name = document.getElementById("ctl00_MyCPH1_txtDriver1Name");

    var ddlDriver1 = document.getElementById("ctl00_MyCPH1_ddlDriver1");
    var lblDriver1LicView = document.getElementById("ctl00_MyCPH1_lblDriver1LicView");
    var lblDriver1PhotoView = document.getElementById("ctl00_MyCPH1_lblDriver1PhotoView");
    var ddlDriver2 = document.getElementById("ctl00_MyCPH1_ddlDriver2");
    var ddlCleaner = document.getElementById("ctl00_MyCPH1_ddlCleaner");

    var hidDriverLicValidation = document.getElementById("ctl00_MyCPH1_hidDriverLicValidation").value = "";
    var hidDriverLicExpiryDate = document.getElementById("ctl00_MyCPH1_hidDriverLicExpiryDate").value = "";
    var hidDriverLicGraceDays = document.getElementById("ctl00_MyCPH1_hidDriverLicGraceDays").value = "";
    var hidDriverLicVerifValidation = document.getElementById("ctl00_MyCPH1_hidDriverLicVerifValidation").value = "";
    var hidDriverLicVerifExpiryDate = document.getElementById("ctl00_MyCPH1_hidDriverLicVerifExpiryDate").value = "";
    var hidDriverLicVerifGraceDays = document.getElementById("ctl00_MyCPH1_hidDriverLicVerifGraceDays").value = "";
    var hidCashValidation = document.getElementById("ctl00_MyCPH1_hidCashValidation").value = "";
    var hidCash = document.getElementById("ctl00_MyCPH1_hidCash").value = "";
    var hidCashGrace = document.getElementById("ctl00_MyCPH1_hidCashGrace").value = "";

    var txtDriver1NotFromRoster = document.getElementById("ctl00_MyCPH1_txtDriver1NotFromRoster");

    var txtDriver2 = document.getElementById("ctl00_MyCPH1_txtDriver2");
    var txtDriver2NotFromRoster = document.getElementById("ctl00_MyCPH1_txtDriver2NotFromRoster");

    var txtDriver2Name = document.getElementById("ctl00_MyCPH1_txtDriver2Name");
    var lblDriver2Licno = document.getElementById("ctl00_MyCPH1_lblDriver2Licno");
    var lblDriver2ValidDt = document.getElementById("ctl00_MyCPH1_lblDriver2ValidDt");
    var lblDriver2LicView = document.getElementById("ctl00_MyCPH1_lblDriver2LicView");
    var lblDriver2PhotoView = document.getElementById("ctl00_MyCPH1_lblDriver2PhotoView");

    var txtCleanerNotFromRoster = document.getElementById("ctl00_MyCPH1_txtCleanerNotFromRoster");
    var txtCleanerName = document.getElementById("ctl00_MyCPH1_txtCleanerName");
    var lblCleanerLicno = document.getElementById("ctl00_MyCPH1_lblCleanerLicno");
    var lblCleanerValidDt = document.getElementById("ctl00_MyCPH1_lblCleanerValidDt");
    var lblCleanerLicView = document.getElementById("ctl00_MyCPH1_lblCleanerLicView");
    var lblCleanerPhotoView = document.getElementById("ctl00_MyCPH1_lblCleanerPhotoView");

    txtVehno.value = "";
    txtVehno_Name.value = "";
    txtVehModel.value = "";
    txtVehCategory.value = "";
    txtVehCapacity.value = "";
    txtVehOpnKM.value = "";
    hfVehOpnKM.value = "";
    txtVehOpnFuel.value = "";
    //txtVehChecklist.value = "";
    txtVehOpnFuelAmt.value = "";
    txtVehOpnAddBlue.value = "";
    txtVehOpnAddBlueAmt.value = "";
    if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
        txtDieselCarryForward.value = "";
        txtDieselCarryForwardAmt.value = "";
    }
    txtVendorName.value = "";
    txtVehno.focus();
    if (ddlDriver1.value != "N") {
        txtDriver1.value = "";
        txtDriver1Name.value = "";
    } else {
        txtDriver1NotFromRoster.value = ""
    }

    lblDriver1Licno.value = "";
    lblDriver1ValidDt.value = "";
    hf_Manual_Driver1_Code.value = "";
    LblDriverBalance.value = "";
    lblDriver1LicView.innerText = "";
    lblDriver1PhotoView.innerText = "";
    if (ddlDriver2.value != "N") {
        txtDriver2.value = "";
        txtDriver2Name.value = "";
    } else {
        txtDriver2NotFromRoster.value = ""
    }

    lblDriver2Licno.value = "";
    lblDriver2ValidDt.value = "";
    lblDriver2LicView.innerText = "";
    lblDriver2PhotoView.innerText = "";

    txtCleanerNotFromRoster.value = "";
    //txtCleanerName.value = "";
    lblCleanerLicno.value = "";
    lblCleanerValidDt.value = "";
    //hf_Manual_Driver2_Code.value = "";
    lblCleanerLicView.innerText = "";
    lblCleanerPhotoView.innerText = "";
}

function SendVehicleDetailToValidate() {
    try {
        var flag = false;
        var txtVehno = document.getElementById("ctl00_MyCPH1_txtVehno");
        var txtVehno_Name = document.getElementById("ctl00_MyCPH1_txtVehno_Name");
        var txtVehModel = document.getElementById("ctl00_MyCPH1_txtVehModel");
        var txtVehCategory = document.getElementById("ctl00_MyCPH1_txtVehCategory");
        var txtVehCapacity = document.getElementById("ctl00_MyCPH1_txtVehCapacity");
        var txtVehOpnKM = document.getElementById("ctl00_MyCPH1_txtVehOpnKM");
        var hfVehOpnKM = document.getElementById("ctl00_MyCPH1_hfVehOpnKM");
        var txtVehOpnFuel = document.getElementById("ctl00_MyCPH1_txtVehOpnFuel");
        var txtVehOpnFuelAmt = document.getElementById("ctl00_MyCPH1_txtVehOpnFuelAmt");
        var txtVehOpnAddBlue = document.getElementById("ctl00_MyCPH1_txtVehOpnAddBlue");
        var txtVehOpnAddBlueAmt = document.getElementById("ctl00_MyCPH1_txtVehOpnAddBlueAmt");
        var txtDieselCarryForward = document.getElementById("ctl00_MyCPH1_txtDieselCarryForward");
        var txtDieselCarryForwardAmt = document.getElementById("ctl00_MyCPH1_txtDieselCarryForwardAmt");
        var txtStartLoc = document.getElementById("ctl00_MyCPH1_txtStartLoc");
        var hfVehicleLocation = document.getElementById("ctl00_MyCPH1_hfVehicleLocation");
        var txtVendorName = document.getElementById("ctl00_MyCPH1_txtVendorName");
        var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");
        var txtHoldFlag = document.getElementById("ctl00_MyCPH1_txtHoldFlag");


        var txtDriver1 = document.getElementById("ctl00_MyCPH1_txtDriver1");
        var lblDriver1Licno = document.getElementById("ctl00_MyCPH1_lblDriver1Licno");
        var lblDriver1ValidDt = document.getElementById("ctl00_MyCPH1_lblDriver1ValidDt");
        var hf_Manual_Driver1_Code = document.getElementById("ctl00_MyCPH1_hf_Manual_Driver1_Code");
        var txtDriver2 = document.getElementById("ctl00_MyCPH1_txtDriver2");
        var LblDriverBalance = document.getElementById("ctl00_MyCPH1_LblDriverBalance");

        var hfDriver_Photo = document.getElementById("ctl00_MyCPH1_hfDriver_Photo");
        var hfDriver_photo_Rule = document.getElementById("ctl00_MyCPH1_hfDriver_photo_Rule");
        var hfDriverLic_Validity = document.getElementById("ctl00_MyCPH1_hfDriverLic_Validity");
        var hfDriverLic_Validity_Rule = document.getElementById("ctl00_MyCPH1_hfDriverLic_Validity_Rule");
        var hfDriver_TripCount = document.getElementById("ctl00_MyCPH1_hfDriver_TripCount");
        var hfDriver_TripCount_Rule = document.getElementById("ctl00_MyCPH1_hfDriver_TripCount_Rule");
        var hfTot_No_Trip = document.getElementById("ctl00_MyCPH1_hfTot_No_Trip");
        var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");
        var txtDriver1Name = document.getElementById("ctl00_MyCPH1_txtDriver1Name");

        var ddlDriver1 = document.getElementById("ctl00_MyCPH1_ddlDriver1");
        var lblDriver1LicView = document.getElementById("ctl00_MyCPH1_lblDriver1LicView");
        var lblDriver1PhotoView = document.getElementById("ctl00_MyCPH1_lblDriver1PhotoView");
        var ddlDriver2 = document.getElementById("ctl00_MyCPH1_ddlDriver2");
        var ddlCleaner = document.getElementById("ctl00_MyCPH1_ddlCleaner");

        var hidDriverLicValidation = document.getElementById("ctl00_MyCPH1_hidDriverLicValidation").value = "";
        var hidDriverLicExpiryDate = document.getElementById("ctl00_MyCPH1_hidDriverLicExpiryDate").value = "";
        var hidDriverLicGraceDays = document.getElementById("ctl00_MyCPH1_hidDriverLicGraceDays").value = "";
        var hidDriverLicVerifValidation = document.getElementById("ctl00_MyCPH1_hidDriverLicVerifValidation").value = "";
        var hidDriverLicVerifExpiryDate = document.getElementById("ctl00_MyCPH1_hidDriverLicVerifExpiryDate").value = "";
        var hidDriverLicVerifGraceDays = document.getElementById("ctl00_MyCPH1_hidDriverLicVerifGraceDays").value = "";
        var hidCashValidation = document.getElementById("ctl00_MyCPH1_hidCashValidation").value = "";
        var hidCash = document.getElementById("ctl00_MyCPH1_hidCash").value = "";
        var hidCashGrace = document.getElementById("ctl00_MyCPH1_hidCashGrace").value = "";

        var txtDriver1NotFromRoster = document.getElementById("ctl00_MyCPH1_txtDriver1NotFromRoster");

        var txtDriver2 = document.getElementById("ctl00_MyCPH1_txtDriver2");
        var txtDriver2NotFromRoster = document.getElementById("ctl00_MyCPH1_txtDriver2NotFromRoster");
        var txtDriver2Name = document.getElementById("ctl00_MyCPH1_txtDriver2Name");
        var lblDriver2Licno = document.getElementById("ctl00_MyCPH1_lblDriver2Licno");
        var lblDriver2ValidDt = document.getElementById("ctl00_MyCPH1_lblDriver2ValidDt");
        var lblDriver2LicView = document.getElementById("ctl00_MyCPH1_lblDriver2LicView");
        var lblDriver2PhotoView = document.getElementById("ctl00_MyCPH1_lblDriver2PhotoView");

        var txtCleanerNotFromRoster = document.getElementById("ctl00_MyCPH1_txtCleanerNotFromRoster");
        var txtCleanerName = document.getElementById("ctl00_MyCPH1_txtCleanerName");
        var lblCleanerLicno = document.getElementById("ctl00_MyCPH1_lblCleanerLicno");
        var lblCleanerValidDt = document.getElementById("ctl00_MyCPH1_lblCleanerValidDt");
        var lblCleanerLicView = document.getElementById("ctl00_MyCPH1_lblCleanerLicView");
        var lblCleanerPhotoView = document.getElementById("ctl00_MyCPH1_lblCleanerPhotoView");



        var ListPushVehicleDriverRequest = [];
        var cnt = 1;
        $('#tblVehicleDetails').find('tbody tr').each(function () {
            var row = $(this);


            if ($.trim(row.find('#txtRemarks').val()) == "") {
                //alert("Remarks can not be blank.!");
                throw "Remarks can not be blank.!";
                return false;
                flag = false;
            }
            //alert($('#Validation').html());
            //alert($('#ExpiryDate').html());
            //alert($('#GraceDays').html());
            //alert($('#hdnDocument').val());


            if (row.find('#hdnDocument').val() != "DieselLiter" && row.find('#hdnDocument').val() != "Cash" && row.find('#hdnDocument').val() != "TripSheet") {

                var PushVehicleDriverRequest = {};
                var combineDatestr = "";
                if (row.find('#ExpiryDate').html() != "") {
                    dockdta_dd = row.find('#ExpiryDate').html().substring(0, 2)
                    dockdta_mm = row.find('#ExpiryDate').html().substring(3, 5)
                    dockdta_yy = row.find('#ExpiryDate').html().substring(6, 10)
                    var combineDatestr = dockdta_dd + " " + months1[dockdta_mm - 1 + 1] + " " + dockdta_yy;
                }

                PushVehicleDriverRequest.VehicleDriverID = (row.find('#hdnDocumentType').val() == "D" ? txtDriver1.value : txtVehno.value);
                PushVehicleDriverRequest.RequestType = row.find('#hdnDocumentType').val();
                PushVehicleDriverRequest.Branch = "HQTR";
                PushVehicleDriverRequest.ControllingLocation = "HQTR";
                PushVehicleDriverRequest.IsCancelled = "N";
                PushVehicleDriverRequest.EntryBy = currentuser;
                PushVehicleDriverRequest.DocumentName = row.find('#Validation').html();
                PushVehicleDriverRequest.ExpiryDate = combineDatestr;
                PushVehicleDriverRequest.GraceDays = row.find('#GraceDays').html();
                PushVehicleDriverRequest.Value = null;
                PushVehicleDriverRequest.RequestOrder = cnt;
                PushVehicleDriverRequest.Document = row.find('#hdnDocument').val();
                PushVehicleDriverRequest.Remarks = row.find('#txtRemarks').val();
                ListPushVehicleDriverRequest.push(PushVehicleDriverRequest);

            }
            else if (row.find('#hdnDocument').val() == "TripSheet") {
                var PushVehicleDriverRequest = {};
                PushVehicleDriverRequest.VehicleDriverID = (row.find('#hdnDocumentType').val() == "D" ? txtDriver1.value : txtVehno.value);
                PushVehicleDriverRequest.RequestType = row.find('#hdnDocumentType').val();
                PushVehicleDriverRequest.Branch = "HQTR";
                PushVehicleDriverRequest.ControllingLocation = "HQTR";
                PushVehicleDriverRequest.IsCancelled = "N";
                PushVehicleDriverRequest.EntryBy = currentuser;
                PushVehicleDriverRequest.DocumentName = row.find('#Validation').html();
                PushVehicleDriverRequest.ExpiryDate = null;
                PushVehicleDriverRequest.GraceDays = 0;
                PushVehicleDriverRequest.Value = 0;
                PushVehicleDriverRequest.RequestOrder = cnt;
                PushVehicleDriverRequest.Document = row.find('#hdnDocument').val();
                PushVehicleDriverRequest.Remarks = row.find('#txtRemarks').val();
                ListPushVehicleDriverRequest.push(PushVehicleDriverRequest);
            }
            else {
                var PushVehicleDriverRequest = {};
                PushVehicleDriverRequest.VehicleDriverID = (row.find('#hdnDocumentType').val() == "D" ? txtDriver1.value : txtVehno.value);
                PushVehicleDriverRequest.RequestType = row.find('#hdnDocumentType').val();
                PushVehicleDriverRequest.Branch = "HQTR";
                PushVehicleDriverRequest.ControllingLocation = "HQTR";
                PushVehicleDriverRequest.IsCancelled = "N";
                PushVehicleDriverRequest.EntryBy = currentuser;
                PushVehicleDriverRequest.DocumentName = row.find('#Validation').html();
                PushVehicleDriverRequest.ExpiryDate = null;
                PushVehicleDriverRequest.GraceDays = row.find('#GraceDays').html();
                PushVehicleDriverRequest.Value = row.find('#ExpiryDate').html();
                PushVehicleDriverRequest.RequestOrder = cnt;
                PushVehicleDriverRequest.Document = row.find('#hdnDocument').val();
                PushVehicleDriverRequest.Remarks = row.find('#txtRemarks').val();
                ListPushVehicleDriverRequest.push(PushVehicleDriverRequest);
            }
            cnt = cnt + 1;
        });


        var ListPushVehicleDriverRequestData = { ListPushVehicleDriverRequest: ListPushVehicleDriverRequest };
        var listPushVehicleDriverRequestDataJson = JSON.stringify(ListPushVehicleDriverRequest);
        var url = "../../../../RestService/MasterService.svc/VehicleDriverRequestInsert";
        AjaxRequest(url, "POST", "application/json; charset=utf-8", "json", listPushVehicleDriverRequestDataJson, GenerateSuccess, GenerateError, false);

        flag = true;
    } catch (e) {
        alert(e.message);
        flag = false;
        return false;
    }
    debugger;
    txtVehno.value = "";
    txtVehno_Name.value = "";
    txtVehModel.value = "";
    txtVehCategory.value = "";
    txtVehCapacity.value = "";
    txtVehOpnKM.value = "";
    hfVehOpnKM.value = "";
    txtVehOpnFuel.value = "";
    //txtVehChecklist.value = "";
    txtVehOpnFuelAmt.value = "";
    txtVehOpnAddBlue.value = "";
    txtVehOpnAddBlueAmt.value = "";
    if (txtDieselCarryForward != null && txtDieselCarryForwardAmt != null) {
        txtDieselCarryForward.value = "";
        txtDieselCarryForwardAmt.value = "";
    }
    txtVendorName.value = "";
    txtVehno.focus();

    if (ddlDriver1.value != "N") {
        txtDriver1.value = "";
        txtDriver1Name.value = "";
    } else {
        txtDriver1NotFromRoster.value = ""
    }
    lblDriver1Licno.value = "";
    lblDriver1ValidDt.value = "";
    hf_Manual_Driver1_Code.value = "";
    LblDriverBalance.value = "";
    lblDriver1LicView.innerText = "";
    lblDriver1PhotoView.innerText = "";

    if (ddlDriver2.value != "N") {
        txtDriver2.value = "";
        txtDriver2Name.value = "";
    } else {
        txtDriver2NotFromRoster.value = ""
    }
    lblDriver2Licno.value = "";
    lblDriver2ValidDt.value = "";
    lblDriver2LicView.innerText = "";
    lblDriver2PhotoView.innerText = "";

    txtCleanerNotFromRoster.value = "";
    // txtCleanerName.value = "";
    lblCleanerLicno.value = "";
    lblCleanerValidDt.value = "";
    //hf_Manual_Driver2_Code.value = "";
    lblCleanerLicView.innerText = "";
    lblCleanerPhotoView.innerText = "";
    return flag;
}

function CalculateTotalAmount(row) {
    var gvFuelSlip = document.getElementById("ctl00_MyCPH1_gvFuelSlip");

    var l = 0;
    l = gvFuelSlip.rows.length-1;

    for (i = 0; i < l - 1; i++) {


        j = i + 2
        var pref = "";
        if (j < 10) {
            pref = "ctl00_MyCPH1_gvFuelSlip_ctl0" + j + "_";
        }
        else {
            pref = "ctl00_MyCPH1_gvFuelSlip_ctl0" + j + "_";
        }
        var txtAmount = document.getElementById(pref + "txtAmount");
        var txtIGST = document.getElementById(pref + "txtIGST");
        var txtSGST = document.getElementById(pref + "txtSGST");
        var txtCGST = document.getElementById(pref + "txtCGST");
        var txtamounttotal = document.getElementById(pref + "txtamounttotal");

        var Amount = parseFloat(txtAmount.value == "" ? "0" : txtAmount.value);
        var IGST = parseFloat(txtIGST.value == "" ? "0" : txtIGST.value);
        var SGST = parseFloat(txtSGST.value == "" ? "0" : txtSGST.value);
        var CGST = parseFloat(txtCGST.value == "" ? "0" : txtCGST.value);

        var TotalWithGSTAmount = Amount + IGST + SGST + CGST;
        txtamounttotal.value = TotalWithGSTAmount;
    }
}
