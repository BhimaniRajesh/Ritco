// JScript File
var currentTime = new Date()
var doc = "ctl00_MyCPH1_";
function createXMLHttpRequest() {
    // Mozilla, Safari,...
    if (window.XMLHttpRequest) { xmlHttpRequest = new XMLHttpRequest(); if (xmlHttpRequest.overrideMimeType) xmlHttpRequest.overrideMimeType("text/xml"); }
    // IE
    else if (window.ActiveXObject) { try { xmlHttpRequest = new ActiveXObject("Msxml2.XMLHTTP"); } catch (e) { try { xmlHttpRequest = new ActiveXObject("Microsoft.XMLHTTP"); } catch (e) { } } }
}
/*************************************************************************************************************
*   Fill Calculate Amount Logsheet Amt + Total Charges + Parking charge
/*************************************************************************************************************/
function CalculateAmt() {
    var tb_Logsheet_Amt = document.getElementById(doc + "tb_Logsheet_Amt");
    var tb_Toll_Charge = document.getElementById(doc + "tb_Toll_Charge");
    var tb_Parking_Charges = document.getElementById(doc + "tb_Parking_Charges");
    var tb_Total_Amt = document.getElementById(doc + "tb_Total_Amt");
    tb_Total_Amt.value = parseFloat(tb_Logsheet_Amt.value) + parseFloat(tb_Toll_Charge.value) + parseFloat(tb_Parking_Charges.value);
}

/*************************************************************************************************************
*   Fill contract Details when select contract Type
/*************************************************************************************************************/
function OnChangeContract(ddl_Contract_Type) {
    var txtCustCode = document.getElementById(doc + "txtCustCode");
    var ddl_Vehicle_Mode = document.getElementById(doc + "ddl_Vehicle_Mode");
    var ddl_Vehicle_No = document.getElementById(doc + "ddl_Vehicle_No");
    var lblErr = document.getElementById(doc + "lblErr")

    var ddl_Duration = document.getElementById(doc + "ddl_Duration");
    var ddl_Category = document.getElementById(doc + "ddl_Category");
    var ddl_Route = document.getElementById(doc + "ddl_Route");
    var tb_Standard_KM_Rec = document.getElementById(doc + "tb_Standard_KM_Rec");
    var hf_Standard_KM_Rec = document.getElementById(doc + "hf_Standard_KM_Rec");

    var tb_Std_Hrs = document.getElementById(doc + "tb_Std_Hrs");

    if (txtCustCode.value == "") {
        lblErr.innerText = "Enter Customer!!";
        txtCustCode.focus();
        ddl_Contract_Type.value = "";
        ddl_Duration.value = "";
        ddl_Category.value = "";
        ddl_Route.value = "";
        tb_Standard_KM_Rec.value = "";
        hf_Standard_KM_Rec.value = "";
        tb_Std_Hrs.value = "";
        return false;
    }

    if (ddl_Vehicle_Mode.value == "") {
        lblErr.innerText = "Select Vehicle Mode!!";
        ddl_Vehicle_Mode.focus();
        ddl_Contract_Type.value = "";        
        ddl_Duration.value = "";
        ddl_Category.value = "";
        ddl_Route.value = "";
        tb_Standard_KM_Rec.value = "";
        hf_Standard_KM_Rec.value = "";
        return false;
    }
    
    if (ddl_Vehicle_No.value == "") {
        lblErr.innerText = "Select Vehicle!!";
        ddl_Vehicle_No.focus();
        ddl_Duration.value = "";
        ddl_Contract_Type.value = "";        
        ddl_Category.value = "";
        ddl_Route.value = "";
        tb_Standard_KM_Rec.value = "";
        hf_Standard_KM_Rec.value = "";
        return false;
    }
    
    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function() {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "Y") {
                    ddl_Duration.value = returnValue[1];
                    ddl_Category.value = returnValue[2];
                    ddl_Duration.disabled = true;
                    ddl_Category.disabled = true;
                    if (ddl_Contract_Type.value == "02") {
                        ddl_Route.value = returnValue[3];
                        tb_Standard_KM_Rec.value = returnValue[4];
                        hf_Standard_KM_Rec.value = returnValue[4];
                        //tb_Std_Hrs.value = returnValue[5];
                        tb_Std_Hrs.value = (parseInt(returnValue[5]) + parseInt((parseInt(returnValue[6]) / 60))).toString() + ":" + (parseInt(returnValue[6]) % 60).toString();
                        ddl_Route.disabled = true;
                        tb_Standard_KM_Rec.disabled = true;
                        tb_Std_Hrs.disabled = true;
                    }
                    lblErr.innerText = "";
                }
                else {
                    lblErr.innerText = "Thre is no active contract for the customer " + txtCustCode.value + " and selected contract type!!";
                    ddl_Contract_Type.value = "";
                    ddl_Duration.value = "";
                    ddl_Category.value = "";
                    ddl_Route.value = "";
                    tb_Standard_KM_Rec.value = "";
                    hf_Standard_KM_Rec.value = "";
                    tb_Std_Hrs.value = "";
                    return false;
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=OnChangeContract&datetime=" + currentTime + "&Contract_Type=" + ddl_Contract_Type.value + "&VehicleNo=" + ddl_Vehicle_No.value + "&Customer_Code=" + txtCustCode.value, false);
        xmlHttpRequest.send(null);
    }
}
/*************************************************************************************************************
*   CHECK Contract already in database particular customer in given date range
/*************************************************************************************************************/
function CheckContractExist_FromDt(tb_Customer_Code,Contract_Type,tb_From_Date, tb_To_Date, lbl_Error) {
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
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckContractExist&datetime=" + currentTime + "&Contract_Type="+Contract_Type+"&FromDt=" + tb_From_Date.value + "&ToDt=" + tb_To_Date.value + "&Customer_Code=" + tb_Customer_Code, false);
        xmlHttpRequest.send(null);
    }
}

function CheckContractExist_ToDt(tb_Customer_Code,Contract_Type,tb_From_Date, tb_To_Date, lbl_Error) {
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
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckContractExist&datetime=" + currentTime + "&Contract_Type=" + Contract_Type + "&FromDt=" + tb_From_Date.value + "&ToDt=" + tb_To_Date.value + "&Customer_Code=" + tb_Customer_Code, false);
        xmlHttpRequest.send(null);
    }
}

/*************************************************************************************************************
*   Check Date and Time for Start date time and end date time
/*************************************************************************************************************/
function CheckStartDate() {
    var tb_Start_Date = document.getElementById(doc + "tb_Start_Date");
    var tb_Total_Hours = document.getElementById(doc + "tb_Total_Hours");
    if (tb_Start_Date.value != "") {
        if (!isDate(tb_Start_Date.value)) {
            tb_Start_Date.focus();
            return false;
        }
    }
    CalculateHours(tb_Total_Hours);    
}
function CheckStartTime() {
    var tb_Start_Time = document.getElementById(doc + "tb_Start_Time");
    var tb_Total_Hours = document.getElementById(doc + "tb_Total_Hours");
    if (tb_Start_Time.value != "") {
        if (!ValidTime(tb_Start_Time)) {
            tb_Start_Time.focus();
            return false;
        }
    }
    CalculateHours(tb_Total_Hours);    
}
function CheckEndDate() {
    var tb_End_Date = document.getElementById(doc + "tb_End_Date");
    var tb_Total_Hours = document.getElementById(doc + "tb_Total_Hours");
    if (tb_End_Date.value != "") {
        if (!isDate(tb_End_Date.value)) {
            tb_End_Date.focus();
            return false;
        }
    }
    CalculateHours(tb_Total_Hours);    
}
function CheckEndTime() {
    var tb_End_Time = document.getElementById(doc + "tb_End_Time");
    var tb_Total_Hours = document.getElementById(doc + "tb_Total_Hours");
    if (tb_End_Time.value != "") {
        if (!ValidTime(tb_End_Time)) {
            tb_End_Time.focus();
            return false;
        }
    }
    CalculateHours(tb_Total_Hours);
}
function CalculateHours(tb_Total_Hours) { 
    var tb_Start_Date = document.getElementById(doc + "tb_Start_Date");
    var tb_Start_Time = document.getElementById(doc + "tb_Start_Time");
    var tb_End_Date = document.getElementById(doc + "tb_End_Date");
    var tb_End_Time = document.getElementById(doc + "tb_End_Time");

    if (tb_Start_Date.value != "" && tb_Start_Time.value != "" && tb_End_Date.value != "" && tb_End_Time.value != "") { 

        var SDT = tb_Start_Date.value +  " " + tb_Start_Time.value + ":00";
        var EDT = tb_End_Date.value +  " " + tb_End_Time.value + ":00";

        createXMLHttpRequest();
            if (xmlHttpRequest) {
                xmlHttpRequest.onreadystatechange = function() {
                    if (xmlHttpRequest.readyState == 4) {
                        var returnValue = xmlHttpRequest.responseText.split("~");
                        if (returnValue[0] == "Y") {
                            var hour = returnValue[1].split(".");
                            var min = returnValue[2].split(".");
                            tb_Total_Hours.value = hour[0] + ":" + min[0];
                        }
                    }
                }
            xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CalculateHours&SDT=" + SDT + "&EDT=" + EDT + "&datetime=" + currentTime, false);
            xmlHttpRequest.send(null);
        }
    }
}
function OnChangeWay(ddl_Way) {
    var tb_Standard_KM_Rec = document.getElementById("ctl00_MyCPH1_tb_Standard_KM_Rec");
    var hf_Standard_KM_Rec = document.getElementById("ctl00_MyCPH1_hf_Standard_KM_Rec");

    if (ddl_Way.value != "") {
        if (ddl_Way.value == "1") {
            tb_Standard_KM_Rec.value = hf_Standard_KM_Rec.value;
        }
        else if (ddl_Way.value == "2") {
            tb_Standard_KM_Rec.value = (parseFloat(hf_Standard_KM_Rec.value) * 2).toFixed(2);
        }
    }
}
function OnChangeRoute(row_Index, ddlRoute) {

    //alert(document.getElementById(ScriptVar.tb_Row_No).value);

    var str_Index = "";
    var controlIdPrefix = "ctl00_MyCPH1_";

    var tb;
    var hf_Standard_KM_Rec;
    if (row_Index != "9999999") {
        var currIndex = parseInt(row_Index) + 2;
        if (currIndex < 10) {
            currIndex = "0" + currIndex.toString();
        }
        tb = document.getElementById(controlIdPrefix + "gv_People_Contract_ctl" + currIndex + "_tb_RUTKM");
    }
    else {
        tb = document.getElementById("ctl00_MyCPH1_tb_Standard_KM_Rec");
        hf_Standard_KM_Rec = document.getElementById("ctl00_MyCPH1_hf_Standard_KM_Rec");
    }
    var tb_Std_Hrs = document.getElementById(doc + "tb_Std_Hrs");

    var tb_RUTKM = tb;

    if (ddlRoute.value != "") {
        createXMLHttpRequest();
        if (xmlHttpRequest) {
            xmlHttpRequest.onreadystatechange = function() {
                if (xmlHttpRequest.readyState == 4) {
                    var returnValue = xmlHttpRequest.responseText.split("~");
                    if (returnValue[0] == "Y") {
                        tb_RUTKM.value = returnValue[1];
                        if (row_Index == "9999999") {
                            hf_Standard_KM_Rec.value = returnValue[1];
                            tb_Std_Hrs.value = (parseInt(returnValue[2]) + parseInt((parseInt(returnValue[3]) / 60))).toString() + ":" + (parseInt(returnValue[3]) % 60).toString();
                            tb_Std_Hrs.disabled = true;
                        }
                        tb_RUTKM.disabled = true;
                    }
                    else {
                        tb_RUTKM.value = "";
                        tb_RUTKM.disabled = false;
                        if (row_Index == "9999999") {
                            tb_Std_Hrs.value = "";
                            tb_Std_Hrs.disabled = false;
                        }
                    }
                }
            }
            xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=OnChangeRoute&RutCd=" + ddlRoute.value + "&datetime=" + currentTime, false);
            xmlHttpRequest.send(null);
        }
    }
    else {
        tb_RUTKM.value = "";
        tb_RUTKM.disabled = false;
        if (row_Index == "9999999") {
            tb_Std_Hrs.value = "";
            tb_Std_Hrs.disabled = false;
        }
    }
}

function ValidateData() {
    //var btn_Submit = document.getElementById(doc + "btn_Submit");
    //btn_Submit.value = "Processing...";
    //btn_Submit.style.v
   //return true;
}


function selected_Customer(sender, e) {
    var customerValueArray = (e._value).split(":");
    e._value = customerValueArray[0];
    var txtCustCode = document.getElementById("ctl00_MyCPH1_txtCustCode");
    var txtCustName = document.getElementById("ctl00_MyCPH1_txtCustName");
    txtCustCode.value = customerValueArray[0];
    txtCustName.value = customerValueArray[1];
}


function GetVehicleDetails(ddl_Vehicle_No) {
    var tb_Vehicle_Type = document.getElementById("ctl00_MyCPH1_tb_Vehicle_Type");
    var tb_Current_KM_Read = document.getElementById("ctl00_MyCPH1_tb_Current_KM_Read");
    var tb_Vendor_Name = document.getElementById("ctl00_MyCPH1_tb_Vendor_Name");

    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function() {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    tb_Vehicle_Type.value = "";
                    tb_Current_KM_Read.value = "";
                    tb_Vendor_Name.value = "";
                }
                else {
                    tb_Vehicle_Type.value = returnValue[1];
                    tb_Current_KM_Read.value = returnValue[2];
                    //alert(returnValue[3])
                    tb_Vendor_Name.value = returnValue[3];
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=GetVehicleDetails&datetime=" + currentTime + "&VehNo=" + ddl_Vehicle_No.value, false);
        xmlHttpRequest.send(null);
    }
}

function GetDriverDetails(ddl_Driver) {
    var lblLicno = document.getElementById("ctl00_MyCPH1_tb_Licno");
    var lblValidDt = document.getElementById("ctl00_MyCPH1_tb_Validity_Date");
    var hf_Manual_Driver_Code = document.getElementById("ctl00_MyCPH1_hf_Manual_Driver_Code");
    //var LblDriverBalance = document.getElementById("ctl00_MyCPH1_LblDriverBalance");
    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function() {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    lblLicno.value = "";
                    lblValidDt.value = "";
                    hf_Manual_Driver_Code.value = "";
                    //LblDriverBalance.innerText = "";
                }
                else {
                    lblLicno.value = returnValue[2];
                    lblValidDt.value = returnValue[3];
                    hf_Manual_Driver_Code.value = returnValue[4];
                    //FillDriverBalance(hf_Manual_Driver_Code);
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=GetDriverDetails&datetime=" + currentTime + "&DriverId=" + ddl_Driver.value, false);
        xmlHttpRequest.send(null);
    }
}

/*************************************************************************************************************
*   check KM
/*************************************************************************************************************/
function CheckStartKM() {
    var tb_Start_KM_Read = document.getElementById("ctl00_MyCPH1_tb_Start_KM_Read");
    var lbl_Err_Veh = document.getElementById("ctl00_MyCPH1_lbl_Err_Veh1");
    var tb_Current_KM_Read = document.getElementById("ctl00_MyCPH1_tb_Current_KM_Read");
    if (tb_Start_KM_Read.value != "") {
        if (parseInt(tb_Start_KM_Read.value) < parseInt(tb_Current_KM_Read.value)) {
            lbl_Err_Veh.innerText = "Start km reading is must be greate than previous log sheet end km reading!!!";
            tb_Start_KM_Read.focus();
            return false;
        }
        else {
            lbl_Err_Veh.innerText = "";
        }
    }
    else {
        lbl_Err_Veh.innerText = "";
    }
}
function CheckEndKM() {
    var tb_Start_KM_Read = document.getElementById("ctl00_MyCPH1_tb_Start_KM_Read");
    var tb_End_KM_Read = document.getElementById("ctl00_MyCPH1_tb_End_KM_Read");
    var lbl_Err_Veh = document.getElementById("ctl00_MyCPH1_lbl_Err_Veh");
    var lbl_Err_Veh1 = document.getElementById("ctl00_MyCPH1_lbl_Err_Veh1");
    var tb_Total_KM = document.getElementById("ctl00_MyCPH1_tb_Total_KM");
    
    if (tb_End_KM_Read.value == "") {
        return;
    }
    if (tb_Start_KM_Read.value == "") {

        lbl_Err_Veh1.innerText = "Enter Start KM Reading!!!";
        tb_End_KM_Read.value = "";
        tb_Start_KM_Read.focus();
        return false;
    }
    else {
        lbl_Err_Veh.innerText = "";
    }
    if (tb_End_KM_Read.value != "") {
        if (parseInt(tb_End_KM_Read.value) < parseInt(tb_Start_KM_Read.value)) {
            lbl_Err_Veh.innerText = "End km reading is must be greate than start km reading!!!";
            tb_End_KM_Read.focus();
            return false;
        }
    }
    else {
        lbl_Err_Veh.innerText = "";
    }


    tb_Total_KM.value = parseFloat(tb_End_KM_Read.value) - parseFloat(tb_Start_KM_Read.value);
}
/*************************************************************************************************************
*   check Manual TS Number
/*************************************************************************************************************/
function CheckValidManualTS(txtManualTripSheetNo, lbl_Manual_TS_Err, Company_Code) {

    var str_Index = "";
    if (txtManualTripSheetNo.value == "") {
        txtManualTripSheetNo.value = "";
        lbl_Manual_TS_Err.innerText = "";
        return;
    }

    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function() {
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
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckValidManualTS&datetime=" + currentTime + "&Company_Code=" + Company_Code + "&ManualTSNo=" + txtManualTripSheetNo.value, false);
        xmlHttpRequest.send(null);
    }
}
/*************************************************************************************************************
*   check City
/*************************************************************************************************************/
function checkCity(tb_From_City, lbl_Err_Text) {
    if (tb_From_City.value == "") {
        tb_From_City.value = "";
        lbl_Err_Text.innerText = "";
        return;
    }
    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function() {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    lbl_Err_Text.innerText = "Invalid area .. pl define area through area master (city master)!!!";
                    tb_From_City.focus();
                    return false;
                }
                else {
                    tb_From_City.value = tb_From_City.value;
                    lbl_Err_Text.innerText = "";
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckCityName&datetime=" + currentTime + "&CityName=" + tb_From_City.value, false);
        xmlHttpRequest.send(null);
    }
}

function checkFromCity() {
    var tb_From_City = document.getElementById("ctl00_MyCPH1_tb_From_City");
    var lbl_Cust_Err = document.getElementById("ctl00_MyCPH1_lblErr");
    if (tb_From_City.value == "") {
        tb_From_City.value = "";
        lbl_Cust_Err.innerText = "";
        return;
    }
    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function() {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    lbl_Cust_Err.innerText = "Invalid area .. pl define area through area master (city master)!!!";
                    tb_From_City.focus();
                    return false;
                }
                else {
                    tb_From_City.value = tb_From_City.value;
                    lbl_Cust_Err.innerText = "";
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckCityName&datetime=" + currentTime + "&CityName=" + tb_From_City.value, false);
        xmlHttpRequest.send(null);
    }
}

function checkToCity() {
    var tb_To_City = document.getElementById("ctl00_MyCPH1_tb_To_City");
    var lbl_Cust_Err = document.getElementById("ctl00_MyCPH1_lbl_Cust_Err");
    if (tb_To_City.value == "") {
        tb_To_City.value = "";
        lbl_Cust_Err.innerText = "";
        return;
    }
    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function() {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    lbl_Cust_Err.innerText = "Invalid area .. pl define area through area master (city master)!!!";
                    tb_To_City.focus();
                    return false;
                }
                else {
                    tb_To_City.value = tb_To_City.value;
                    lbl_Cust_Err.innerText = "";
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckCityName&datetime=" + currentTime + "&CityName=" + tb_To_City.value, false);
        xmlHttpRequest.send(null);
    }
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


function nwOpen(mNo) {
    window.open("popup-CUST.aspx?mNo=" + mNo, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
}


function CheckCustomerCode(txtCustCode, lblErrorLocation1) {
    var str_Index = "";
    var txtCustName = document.getElementById("ctl00_MyCPH1_txtCustName");

    if (txtCustCode.value == "") {
        txtCustCode.value = "";
        if (txtCustName != null) {
            txtCustName.value = "";
        }
        lblErrorLocation1.innerText = "";
        return;
    }
    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function() {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") {
                    lblErrorLocation1.innerText = "Invalid Customer Code!!!";
                    if (txtCustName != null) {
                        txtCustName.value = "";
                    }
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

    if (tb_Vehicle_Type.value == "") {
        tb_Vehicle_Type.value = "";
        lbl_Vehicle_Type_Err.innerText = "";
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
                    return false;
                }
                else {
                    lbl_Vehicle_Type_Err.innerText = "";
                    lbl_Vehicle_Type_Err.title = "";
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
//function CheckContractExist_FromDt(tb_Customer_Code, tb_From_Date, tb_To_Date, lbl_Error) {
//    var prev_To_Date = "";

//    createXMLHttpRequest();
//    if (xmlHttpRequest) {
//        xmlHttpRequest.onreadystatechange = function() {
//            if (xmlHttpRequest.readyState == 4) {
//                var returnValue = xmlHttpRequest.responseText.split("~");
//                if (returnValue[0] == "Y") {
//                    lbl_Error.innerText = "Contract is Already Present. Please select different Criteria.";
//                    tb_From_Date.focus();
//                    return false;
//                }
//                else {
//                    lbl_Error.innerText = "";
//                }
//            }
//        }
//        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckContractExist&datetime=" + currentTime + "&FromDt=" + tb_From_Date.value + "&ToDt=" + tb_To_Date.value + "&Customer_Code=" + tb_Customer_Code.value, false);
//        xmlHttpRequest.send(null);
//    }
//}

//function CheckContractExist_ToDt(tb_Customer_Code, tb_From_Date, tb_To_Date, lbl_Error) {
//    var prev_To_Date = "";

//    createXMLHttpRequest();
//    if (xmlHttpRequest) {
//        xmlHttpRequest.onreadystatechange = function() {
//            if (xmlHttpRequest.readyState == 4) {
//                var returnValue = xmlHttpRequest.responseText.split("~");
//                if (returnValue[0] == "Y") {
//                    lbl_Error.innerText = "Contract is Already Present. Please select different Criteria.";
//                    tb_To_Date.focus();
//                    return false;
//                }
//                else {
//                    lbl_Error.innerText = "";
//                }
//            }
//        }
//        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckContractExist&datetime=" + currentTime + "&FromDt=" + tb_From_Date.value + "&ToDt=" + tb_To_Date.value + "&Customer_Code=" + tb_Customer_Code.value, false);
//        xmlHttpRequest.send(null);
//    }
//}

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

    if (parseInt(tb_To_Km.value) > parseInt(tb_From_Km.value)) {
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