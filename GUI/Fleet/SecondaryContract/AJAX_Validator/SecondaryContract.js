// JScript File

var currentTime = new Date()

function createXMLHttpRequest() {
    // Mozilla, Safari,...
    if (window.XMLHttpRequest) { xmlHttpRequest = new XMLHttpRequest(); if (xmlHttpRequest.overrideMimeType) xmlHttpRequest.overrideMimeType("text/xml"); }
    // IE
    else if (window.ActiveXObject) { try { xmlHttpRequest = new ActiveXObject("Msxml2.XMLHTTP"); } catch (e) { try { xmlHttpRequest = new ActiveXObject("Microsoft.XMLHTTP"); } catch (e) { } } }
}
/*************************************************************************************************************
*   For Blink Controls
/*************************************************************************************************************/

var g_blinkTime = 100;
var g_blinkCounter = 0;

function blinkElement(elementId) {


    if ((g_blinkCounter % 2) == 0) {
        if (document.getElementById) {
            document.getElementById(elementId).style.visibility = 'visible';
        }
        // IE 4...
        else if (document.all) {
            document.all[elementId].style.visibility = 'visible';
        }
        // NS 4...
        else if (document.layers) {
            document.layers[elementId].visibility = 'visible';
        }
    }
    else {
        if (document.getElementById) {
            document.getElementById(elementId).style.visibility = 'hidden';
        }
        // IE 4...
        else if (document.all) {
            document.all[elementId].style.visibility = 'hidden';
        }
        // NS 4...
        else if (document.layers) {
            document.layers[elementId].visibility = 'hidden';
        }
    }

    if (g_blinkCounter < 1) {
        g_blinkCounter++;
    }
    else {
        g_blinkCounter--
    }

    window.setTimeout('blinkElement(\"' + elementId + '\")', g_blinkTime);
}
/*************************************************************************************************************
*   For Check Valid CUSTOMER CODE
/*************************************************************************************************************/
function CheckCustomerCode(tb_Customer_Code, tb_Customer_Name) {
    var str_Index = "";
    var lbl_Error = document.getElementById("ctl00_MyCPH1_lbl_Error");
    if (tb_Customer_Code.value == "") {
        tb_Customer_Name.value = "";
        lbl_Error.innerText = "";
        //g_blinkCounter = 0;
        return;
    }
    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function() {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    lbl_Error.innerText = "Invalid Customer Code!!!";
                    tb_Customer_Code.focus();
                    //blinkElement("ctl00_MyCPH1_lbl_Error");                    
                    return false;
                }
                else {
                    tb_Customer_Code.value = tb_Customer_Code.value;
                    tb_Customer_Name.value = returnValue[1];
                    lbl_Error.innerText = "";
                    //g_blinkCounter = 0;
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckCustomerCode&datetime=" + currentTime + "&CustCode=" + tb_Customer_Code.value, false);
        xmlHttpRequest.send(null);
    }
}

/*************************************************************************************************************
*   For Check Valid Locaton Name
/*************************************************************************************************************/


function CheckLocation(row_Index, tb_Location, lbl_Location_Err) {
    var str_Index = "";
    var controlIdPrefix = "ctl00_MyCPH1_";

    var currIndex = parseInt(row_Index) + 2;
    if (currIndex < 10) {
        currIndex = "0" + currIndex.toString();
    }

    if (tb_Location.value == "") {
        tb_Location.value = "";
        lbl_Location_Err.innerText = "";
        return;
    }
    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function() {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    lbl_Location_Err.innerText = "!!!";
                    lbl_Location_Err.title = "Invalid Location";
                    tb_Location.focus();
                    return false;
                }
                else {
                    lbl_Location_Err.innerText = "";
                    lbl_Location_Err.title = "";
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckLocation&datetime=" + currentTime + "&Location=" + tb_Location.value, false);
        xmlHttpRequest.send(null);
    }
}

/*************************************************************************************************************
*   For Check Valid CUSTOMER Name
/*************************************************************************************************************/
function CheckCustomerName(tb_Customer_Name, tb_Customer_Code) {
    var str_Index = "";
    var lbl_Error = document.getElementById("ctl00_MyCPH1_lbl_Error");
    if (tb_Customer_Name.value == "") {
        tb_Customer_Code.value = "";
        lbl_Error.innerText = "";
        //g_blinkCounter = 0;
        return;
    }
    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function() {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    lbl_Error.innerText = "Invalid Customer Name!!!";
                    tb_Customer_Code.focus();
                    //blinkElement("ctl00_MyCPH1_lbl_Error");
                    return false;
                }
                else {
                    tb_Customer_Code.value = returnValue[1];
                    lbl_Error.innerText = "";
                    //g_blinkCounter = 0;
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckCustomerName&datetime=" + currentTime + "&Customer_Name=" + tb_Customer_Name.value, false);
        xmlHttpRequest.send(null);
    }
}
/*************************************************************************************************************
*   For PopUp
/*************************************************************************************************************/
function popupCustomer(mNo) {
    window.open("popup-CUST.aspx?mNo=" + mNo, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
}
/*************************************************************************************************************
*   For Check Hourly based or not
/*************************************************************************************************************/
function CheckHourlyBased() {
    var tr_HourlyBased = document.getElementById("ctl00_MyCPH1_tr_HourlyBased");
    var rblst_Rate_Based = document.getElementById("ctl00_MyCPH1_rblst_Rate_Based");
    var tr_HourlyBased_det = document.getElementById("ctl00_MyCPH1_tr_HourlyBased_det");

    if (rblst_Rate_Based != null) {
        var options = rblst_Rate_Based.getElementsByTagName('input');
        var arrayOfRadioButtonListLabels = rblst_Rate_Based.getElementsByTagName("label");
        for (i = 0; i < options.length; i++) {
            var opt = options[i];
            if (opt.checked == true) {
                if (opt.value == "Hourly") {
                    tr_HourlyBased.style["display"] = "block";
                    tr_HourlyBased_det.style["display"] = "block";
                    return;
                }
                else {
                    tr_HourlyBased.style["display"] = "none";
                    tr_HourlyBased_det.style["display"] = "none";
                    return;
                }
            }
        }
    }
}
/*************************************************************************************************************
*   Valid Numeric
/*************************************************************************************************************/
function numeric(e) { return ((e.keyCode == 8) || (e.keyCode == 110) || (e.keyCode == 190) || (e.keyCode > 47 && e.keyCode < 58) || (e.keyCode > 95 && e.keyCode < 106) || (e.keyCode == 9) || (e.keyCode == 46)); }
function allowNegativeNumber(e) {
    var charCode = (e.which) ? e.which : event.keyCode
    if (charCode > 31 && (charCode < 45 || charCode > 57)) {
        return false;
    }
    return true;
}

function checkDecimals(tb) {
    var txtControl = tb.value;
    var llength = txtControl.length;
    var fieldvalues = new Array(llength);

    if (txtControl.length > 1) {
        for (i = 0; i < llength; i++) {
            fieldvalues[i] = txtControl.slice(i, i + 1);
        }
        if (window.event.keyCode == 0x2E) {
            for (i = 0; i < llength; i++) {
                if (fieldvalues[i] == '.') {
                    window.event.keyCode = 0;
                }
                else {

                }
            }
        }
    }

    if (txtControl.length > 1) {
        for (i = 0; i < llength; i++) {
            if (fieldvalues[i] == '.') {
                var values = new Array(2);
                values = txtControl.split(".");
                var checkfourdigits = values[1];
                if (checkfourdigits.length > 3) {
                    return false;
                }
            }
        }
    }

    key = window.event.keyCode;
    pass = (((key >= 0x30) && (key <= 0x39)) || ((key == 0x2E)));
    if (pass == false) {
        window.event.keyCode = 0;
    }

    return pass;
}
function round(tb) {
    if (tb.value != "") {
        tb.value = parseFloat(tb.value).toFixed(2).toString();
    }
}

/*************************************************************************************************************
*   CHECK Valid VEHICLE Numeric
/*************************************************************************************************************/

function CheckVehicleNumber(row_Index, tb_Vehicle_No, lbl_Vehicle_No_Err) {
    var str_Index = "";
    var controlIdPrefix = "ctl00_MyCPH1_";

    var currIndex = parseInt(row_Index) + 2;
    if (currIndex < 10) {
        currIndex = "0" + currIndex.toString();
    }

    var ddl_Category = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + currIndex + "_ddl_Category");
    var ddl_Hourly_Based_Slot = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + currIndex + "_ddl_Hourly_Based_Slot");


    if (tb_Vehicle_No.value == "") {
        tb_Vehicle_No.value = "";
        lbl_Vehicle_No_Err.innerText = "";
        if (ddl_Hourly_Based_Slot != null) {
            ddl_Hourly_Based_Slot.value = "";
        }
        ddl_Category.value = "";
        return;
    }
    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function() {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    lbl_Vehicle_No_Err.innerText = "!!!";
                    lbl_Vehicle_No_Err.title = "Invalid Vehicle";
                    tb_Vehicle_No.focus();
                    if (ddl_Hourly_Based_Slot != null) {
                        ddl_Hourly_Based_Slot.value = "";
                    }
                    ddl_Category.value = "";
                    return false;
                }
                else {
                    lbl_Vehicle_No_Err.innerText = "";
                    lbl_Vehicle_No_Err.title = "";
                    if (ddl_Hourly_Based_Slot != null) {
                        ddl_Hourly_Based_Slot.value = "";
                    }
                    ddl_Category.value = "";
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckVehicleNumber&datetime=" + currentTime + "&VehicleNo=" + tb_Vehicle_No.value, false);
        xmlHttpRequest.send(null);
    }
}
/*************************************************************************************************************
*   CHECK Valid VEHICLE Type
/*************************************************************************************************************/

function CheckVehicleType(row_Index, tb_Vehicle_Type, lbl_Vehicle_Type_Err) {
    var str_Index = "";
    var controlIdPrefix = "ctl00_MyCPH1_";

    var currIndex = parseInt(row_Index) + 2;
    if (currIndex < 10) {
        currIndex = "0" + currIndex.toString();
    }

    var ddl_Category = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + currIndex + "_ddl_Category");
    var ddl_Hourly_Based_Slot = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + currIndex + "_ddl_Hourly_Based_Slot");


    if (tb_Vehicle_Type.value == "") {
        tb_Vehicle_Type.value = "";
        lbl_Vehicle_Type_Err.innerText = "";
        if (ddl_Hourly_Based_Slot != null) {
            ddl_Hourly_Based_Slot.value = "";
        }
        ddl_Category.value = "";
        return;
    }
    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function() {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    lbl_Vehicle_Type_Err.innerText = "!!!";
                    lbl_Vehicle_Type_Err.title = "Invalid Vehicle Type";
                    tb_Vehicle_Type.focus();
                    if (ddl_Hourly_Based_Slot != null) {
                        ddl_Hourly_Based_Slot.value = "";
                    }
                    ddl_Category.value = "";
                    return false;
                }
                else {
                    lbl_Vehicle_Type_Err.innerText = "";
                    lbl_Vehicle_Type_Err.title = "";
                    if (ddl_Hourly_Based_Slot != null) {
                        ddl_Hourly_Based_Slot.value = "";
                    }
                    ddl_Category.value = "";
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckVehicleType&datetime=" + currentTime + "&VehicleType=" + tb_Vehicle_Type.value, false);
        xmlHttpRequest.send(null);
    }
}
/*************************************************************************************************************
*   CHECK Valid Hourly Based slot
/*************************************************************************************************************/
function CheckHourlyBasedFTL(row_Index) {
    var controlIdPrefix = "ctl00_MyCPH1_";
    var currIndex = parseInt(row_Index) + 2;
    if (currIndex < 10) {
        currIndex = "0" + currIndex.toString();
    }
    var tb_Vehicle_Type = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + currIndex + "_tb_Vehicle_Type");
    var ddl_Category = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + currIndex + "_ddl_Category");
    var ddl_Hourly_Based_Slot = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + currIndex + "_ddl_Hourly_Based_Slot");

    var tb_Vehicle_No = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + currIndex + "_tb_Vehicle_No");

    if (tb_Vehicle_No == null) {
        tb_Vehicle_Type = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + currIndex + "_tb_Vehicle_Type");
    }
    else if (tb_Vehicle_Type == null) {
        tb_Vehicle_Type = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + currIndex + "_tb_Vehicle_No");
    }

    var currentTime = new Date()
    var str_index = "";
    if (ddl_Hourly_Based_Slot.value == "") {
        return;
    }
    var gv_Secondary_Contract = document.getElementById(controlIdPrefix + "gv_Secondary_Contract");
    for (intindex = 2; intindex <= gv_Secondary_Contract.rows.length; intindex++) {
        if (intindex < 10) {
            str_index = "0" + intindex;
        }
        else {
            str_index = intindex;
        }
        if (row_Index == intindex - 2) {
            continue;
        }

        var tb_Vehicle_Type_1 = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + str_index + "_tb_Vehicle_Type");
        var tb_Vehicle_No_1 = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + str_index + "_tb_Vehicle_No");
        var ddl_Category_1 = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + str_index + "_ddl_Category");
        var ddl_Hourly_Based_Slot_1 = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + str_index + "_ddl_Hourly_Based_Slot");

        if (tb_Vehicle_No_1 == null) {
            tb_Vehicle_Type_1 = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + str_index + "_tb_Vehicle_Type");
        }
        else if (tb_Vehicle_Type_1 == null) {
            tb_Vehicle_Type_1 = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + str_index + "_tb_Vehicle_No");
        }

        if (tb_Vehicle_Type_1.value == tb_Vehicle_Type.value && ddl_Category_1.value == ddl_Category.value && ddl_Hourly_Based_Slot_1.value == ddl_Hourly_Based_Slot.value) {
            alert("This Part already exist at row " + (intindex - 1));
            ddl_Hourly_Based_Slot.focus();
            ddl_Hourly_Based_Slot.value = "";
            return false;

        }
    }
}
/*************************************************************************************************************
*   CHECK Valid Category
/*************************************************************************************************************/
function CheckCategory(row_Index) {
    var controlIdPrefix = "ctl00_MyCPH1_";
    var currIndex = parseInt(row_Index) + 2;
    if (currIndex < 10) {
        currIndex = "0" + currIndex.toString();
    }
    var tb_Vehicle_Type = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + currIndex + "_tb_Vehicle_Type");
    var ddl_Category = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + currIndex + "_ddl_Category");
    var ddl_Hourly_Based_Slot = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + currIndex + "_ddl_Hourly_Based_Slot");

    var tb_Vehicle_No = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + currIndex + "_tb_Vehicle_No");

    if (tb_Vehicle_No == null) {
        tb_Vehicle_Type = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + currIndex + "_tb_Vehicle_Type");
    }
    else if (tb_Vehicle_Type == null) {
        tb_Vehicle_Type = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + currIndex + "_tb_Vehicle_No");
    }

    var currentTime = new Date()
    var str_index = "";
    if (ddl_Category.value == "") {
        return;
    }
    var gv_Secondary_Contract = document.getElementById(controlIdPrefix + "gv_Secondary_Contract");
    for (intindex = 2; intindex <= gv_Secondary_Contract.rows.length; intindex++) {
        if (intindex < 10) {
            str_index = "0" + intindex;
        }
        else {
            str_index = intindex;
        }
        if (row_Index == intindex - 2) {
            continue;
        }

        var tb_Vehicle_Type_1 = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + str_index + "_tb_Vehicle_Type");
        var tb_Vehicle_No_1 = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + str_index + "_tb_Vehicle_No");
        var ddl_Category_1 = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + str_index + "_ddl_Category");
        //var ddl_Hourly_Based_Slot_1 = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + str_index + "_ddl_Hourly_Based_Slot");
        var tb_From_Km_1 = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + str_index + "_tb_From_Km");
        var tb_To_Km_1 = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + str_index + "_tb_To_Km");
        
        if (tb_Vehicle_No_1 == null) {
            tb_Vehicle_Type_1 = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + str_index + "_tb_Vehicle_Type");
        }
        else if (tb_Vehicle_Type_1 == null) {
            tb_Vehicle_Type_1 = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + str_index + "_tb_Vehicle_No");
        }
        if (ddl_Hourly_Based_Slot == null) {
            if (tb_From_Km_1 == null && tb_To_Km_1 == null) {
                if (tb_Vehicle_Type_1.value == tb_Vehicle_Type.value && ddl_Category_1.value == ddl_Category.value) {
                    alert("This Part already exist at row " + (intindex - 1));
                    ddl_Category.focus();
                    ddl_Category.value = "";
                    return false;
                }
            }
        }
    }
}
/*************************************************************************************************************
*   CHECK Contract already in database particular customer in given date range
/*************************************************************************************************************/
function CheckContractExist_FromDt(tb_Customer_Code, tb_From_Date, tb_To_Date, lbl_Error) {
    var prev_To_Date = "";

    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function() {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "Y") {
                    lbl_Error.innerText = "Contract is Already Present. Please select different Criteria.";
                    tb_From_Date.focus();
                    return false;
                }
                else {
                    lbl_Error.innerText = "";
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckContractExist&datetime=" + currentTime + "&FromDt=" + tb_From_Date.value + "&ToDt=" + tb_To_Date.value + "&Customer_Code=" + tb_Customer_Code.value, false);
        xmlHttpRequest.send(null);
    }
}

function CheckContractExist_ToDt(tb_Customer_Code, tb_From_Date, tb_To_Date, lbl_Error) {
    var prev_To_Date = "";

    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function() {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "Y") {
                    lbl_Error.innerText = "Contract is Already Present. Please select different Criteria.";
                    tb_To_Date.focus();
                    return false;
                }
                else {
                    lbl_Error.innerText = "";
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckContractExist&datetime=" + currentTime + "&FromDt=" + tb_From_Date.value + "&ToDt=" + tb_To_Date.value + "&Customer_Code=" + tb_Customer_Code.value, false);
        xmlHttpRequest.send(null);
    }
}

/*************************************************************************************************************
*   CHECK From KM To KM for matrix
/*************************************************************************************************************/
function CheckFromKM(row_Index) {
    var controlIdPrefix = "ctl00_MyCPH1_";
    var currIndex = parseInt(row_Index) + 2;
    if (currIndex < 10) {
        currIndex = "0" + currIndex.toString();
    }

    var tb_Vehicle_Type = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + currIndex + "_tb_Vehicle_Type");
    var ddl_Category = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + currIndex + "_ddl_Category");
    var ddl_Hourly_Based_Slot = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + currIndex + "_ddl_Hourly_Based_Slot");
    var tb_Vehicle_No = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + currIndex + "_tb_Vehicle_No");
    var tb_From_Km = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + currIndex + "_tb_From_Km");
    var tb_To_Km = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + currIndex + "_tb_To_Km");

    if(parseInt(tb_To_Km.value) > parseInt(tb_From_Km.value))
    {
        alert("From KM must be less than To KM !!!");
        tb_To_Km.focus();
        return false;
    }
    
    if (tb_Vehicle_No == null) {
        tb_Vehicle_Type = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + currIndex + "_tb_Vehicle_Type");
    }
    else if (tb_Vehicle_Type == null) {
        tb_Vehicle_Type = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + currIndex + "_tb_Vehicle_No");
    }

    var currentTime = new Date()
    
    var str_index = "";
    if (ddl_Category.value == "") {
        return;
    }
    
    var gv_Secondary_Contract = document.getElementById(controlIdPrefix + "gv_Secondary_Contract");
    for (intindex = 2; intindex <= gv_Secondary_Contract.rows.length; intindex++) {
        if (intindex < 10) {
            str_index = "0" + intindex;
        }
        else {
            str_index = intindex;
        }
        if (row_Index == intindex - 2) {
            continue;
        }

        var tb_Vehicle_Type_1 = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + str_index + "_tb_Vehicle_Type");
        var tb_Vehicle_No_1 = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + str_index + "_tb_Vehicle_No");
        var ddl_Category_1 = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + str_index + "_ddl_Category");
        var ddl_Hourly_Based_Slot_1 = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + str_index + "_ddl_Hourly_Based_Slot");
        var tb_From_Km_1 = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + str_index + "_tb_From_Km");
        var tb_To_Km_1 = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + str_index + "_tb_To_Km");

        if (tb_Vehicle_No_1 == null) {
            tb_Vehicle_Type_1 = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + str_index + "_tb_Vehicle_Type");
        }
        else if (tb_Vehicle_Type_1 == null) {
            tb_Vehicle_Type_1 = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + str_index + "_tb_Vehicle_No");
        }
        if (ddl_Hourly_Based_Slot == null) {
            if (tb_From_Km == null && tb_To_Km == null) {
                if (tb_Vehicle_Type_1.value == tb_Vehicle_Type.value && ddl_Category_1.value == ddl_Category.value) {
                    alert("This Part already exist at row " + (intindex - 1) + " !!!");
                    ddl_Category.focus();
                    ddl_Category.value = "";
                    return false;
                }
            }
            else {
                if (tb_Vehicle_Type_1.value == tb_Vehicle_Type.value && ddl_Category_1.value == ddl_Category.value) {
                    if (parseInt(tb_From_Km.value) < parseInt(tb_To_Km_1.value)) {
                        alert("From KM must be greate than previous To KM for the same vehicle and and same category !!!");
                        tb_From_Km.focus();
                        return false;
                    }
                }
            }
        }
    }
}

/*************************************************************************************************************
*   CHECK To KM 
/*************************************************************************************************************/
function CheckToKM(row_Index) {
    var controlIdPrefix = "ctl00_MyCPH1_";
    var currIndex = parseInt(row_Index) + 2;
    if (currIndex < 10) {
        currIndex = "0" + currIndex.toString();
    }

    var tb_From_Km = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + currIndex + "_tb_From_Km");
    var tb_To_Km = document.getElementById(controlIdPrefix + "gv_Secondary_Contract_ctl" + currIndex + "_tb_To_Km");

    if (parseInt(tb_To_Km.value) < parseInt(tb_From_Km.value)) {
        alert("To KM must be greate than From KM");
        tb_To_Km.focus();
        return false;
    }
}