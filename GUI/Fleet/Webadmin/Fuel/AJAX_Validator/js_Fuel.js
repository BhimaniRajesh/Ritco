// JScript File

function formatDate(dateString){var inputDate=dateString.split('/');return inputDate[1]+'/'+inputDate[0]+'/'+inputDate[2]}
function isDate(dateString){var datePat=/^(\d{1,2})(\/|-)(\d{1,2})(\/|-)(\d{4})$/;var matchArray=dateString.match(datePat);if(matchArray==null)return false;month=matchArray[1];day=matchArray[3];year=matchArray[5];if(month<1||month>12)return false;if(day<1||day>31)return false;if((month==4||month==6||month==9||month==11)&&day==31)return false;if(month==2){var isleap=(year%4==0&&(year%100!=0||year%400==0));if(day>29||(day==29&&!isleap))return false;}return true;}
function roundNumber(number, decimals){return Math.round(number*Math.pow(10,decimals))/Math.pow(10,decimals);}

function clickYesNo(lbl_Active_Flag){if(lbl_Active_Flag.innerText=='N')lbl_Active_Flag.innerText='Y';else lbl_Active_Flag.innerText='N';}
function focusToActiveCheckBox(chk_Active_Flag){chk_Active_Flag.focus();}

function validateFormFuelBrandMaster() {
    if (document.getElementById('ctl00_MyCPH1_tb_Fuel_Brand_Name').value == '') {alert('Please input Fuel Brand Name'); document.getElementById('ctl00_MyCPH1_tb_Fuel_Brand_Name').focus(); return false;}
    if (document.getElementById('ctl00_MyCPH1_lbl_Brand_Error').innerText != '') {document.getElementById('ctl00_MyCPH1_lbl_Brand_Error').focus(); return false;}
    if (document.getElementById('ctl00_MyCPH1_tb_VendorCode').value == '') {alert('Please input Vendor Code'); document.getElementById('ctl00_MyCPH1_tb_VendorCode').focus(); return false;}
    //if (document.getElementById('ctl00_MyCPH1_ddl_Fuel_Type').value == '') {alert('Please input Fuel Type'); document.getElementById('ctl00_MyCPH1_ddl_Fuel_Type').focus(); return false;}

    return true;
}

function validateFormFuelCardMaster() {
    if (document.getElementById('ctl00_MyCPH1_tb_Manual_Fuel_Card_No').value == '') {alert('Please input Manual Fuel Card Number'); document.getElementById('ctl00_MyCPH1_tb_Manual_Fuel_Card_No').focus(); return false;}
    if (document.getElementById('ctl00_MyCPH1_lbl_Manual_Fuel_Card_Error').innerText != '') {document.getElementById('ctl00_MyCPH1_lbl_Manual_Fuel_Card_Error').focus(); return false;}
    if (document.getElementById('ctl00_MyCPH1_tb_VendorCode').value == '') {alert('Please input Vendor Code'); document.getElementById('ctl00_MyCPH1_tb_VendorCode').focus(); return false;}
    //if (document.getElementById('ctl00_MyCPH1_dp_Issue_Date_tb_Date').value == '') {alert('Please input Issue Date'); document.getElementById('ctl00_MyCPH1_dp_Issue_Date_tb_Date').focus(); return false;} if (!isDate(formatDate(document.getElementById('ctl00_MyCPH1_dp_Issue_Date_tb_Date').value))) {alert('Invalid Issue Date'); document.getElementById('ctl00_MyCPH1_dp_Issue_Date_tb_Date').focus(); return false;} var Issue_Date = new Date(formatDate(document.getElementById('ctl00_MyCPH1_dp_Issue_Date_tb_Date').value)); 
    //if (document.getElementById('ctl00_MyCPH1_dp_Expiry_Date_tb_Date').value == '') {alert('Please input Expiry Date'); document.getElementById('ctl00_MyCPH1_dp_Expiry_Date_tb_Date').focus(); return false;} if (!isDate(formatDate(document.getElementById('ctl00_MyCPH1_dp_Expiry_Date_tb_Date').value))) {alert('Invalid Expiry Date'); document.getElementById('ctl00_MyCPH1_dp_Expiry_Date_tb_Date').focus(); return false;} var Expiry_Date = new Date(formatDate(document.getElementById('ctl00_MyCPH1_dp_Expiry_Date_tb_Date').value)); if (Issue_Date >= Expiry_Date) {alert('Expiry Date must be greater than Issue Date'); document.getElementById('ctl00_MyCPH1_dp_Expiry_Date_tb_Date').focus(); return false;}
    if (document.getElementById('ctl00_MyCPH1_tb_Vehicle_No').value == '') {alert('Please input Vehicle Number'); document.getElementById('ctl00_MyCPH1_tb_Vehicle_No').focus(); return false;}
    //if (document.getElementById('ctl00_MyCPH1_ddl_Fuel_Type').value == '') {alert('Please input Fuel Type'); document.getElementById('ctl00_MyCPH1_ddl_Fuel_Type').focus(); return false;}
    //if (document.getElementById('ctl00_MyCPH1_ddl_Fuel_Brand').value == '') {alert('Please input Fuel Brand'); document.getElementById('ctl00_MyCPH1_ddl_Fuel_Brand').focus(); return false;}
    if (document.getElementById('ctl00_MyCPH1_ddl_LedgerType').value == '') {alert('Please input FO Ledger'); document.getElementById('ctl00_MyCPH1_ddl_LedgerType').focus(); return false;}
    
    /*alert("1");
    if(checkDuplicateFuelCardNoVehicle(document.getElementById('ctl00_MyCPH1_lbl_Fuel_Card_ID'),document.getElementById('ctl00_MyCPH1_tb_Vehicle_No'),document.getElementById('ctl00_MyCPH1_lbl_Vehicle_Error')))
    {
      alert("2");
      return true;
    }
    else
    {
    alert("STOP");
    return false;
    }*/
    
    if(document.getElementById('ctl00_MyCPH1_lbl_Vehicle_Error').innerText !='' ||  document.getElementById('ctl00_MyCPH1_lbl_VendorName').innerText !='')
    {
       if(document.getElementById('ctl00_MyCPH1_lbl_VendorName').innerText =='Invalid Vendor Code !!')
        {
            alert("Invalid Vendor Code !!");
            document.getElementById('ctl00_MyCPH1_lbl_VendorName').focus();
            return false;
        }
        
        if(document.getElementById('ctl00_MyCPH1_lbl_Vehicle_Error').innerText !='')
        {
            alert("Invalid Vehicle Number !!");
            document.getElementById('ctl00_MyCPH1_lbl_Vehicle_Error').focus();
            return false;
        }

       

    }
    //alert("hi");
    document.getElementById('ctl00_MyCPH1_tb_Vehicle_No').disabled=false;
    
    return true;
}

function validateFormFuelTicket() {
    if (document.getElementById('ctl00_MyCPH1_tb_Manual_Ticket_No').value == '') {alert('Please input Manual Ticket Number'); document.getElementById('ctl00_MyCPH1_tb_Manual_Ticket_No').focus(); return false;}
    if (document.getElementById('ctl00_MyCPH1_lbl_Ticket_Error').innerText != '') {document.getElementById('ctl00_MyCPH1_lbl_Ticket_Error').focus(); return false;}
    if (document.getElementById('ctl00_MyCPH1_dp_Ticket_Date_tb_Date').value == '') {alert('Please input Ticket Date'); document.getElementById('ctl00_MyCPH1_dp_Ticket_Date_tb_Date').focus(); return false;} if (!isDate(formatDate(document.getElementById('ctl00_MyCPH1_dp_Ticket_Date_tb_Date').value))) {alert('Invalid Ticket Date'); document.getElementById('ctl00_MyCPH1_dp_Ticket_Date_tb_Date').focus(); return false;} var Ticket_Date = new Date(formatDate(document.getElementById('ctl00_MyCPH1_dp_Ticket_Date_tb_Date').value)); var ToDay = new Date(); if (Ticket_Date > ToDay) {alert('Ticket Date can not be greater than Today'); document.getElementById('ctl00_MyCPH1_dp_Ticket_Date_tb_Date').focus(); return false;}
    if (document.getElementById('ctl00_MyCPH1_tb_Vehicle_No').value == '') {alert('Please input Vehicle Number'); document.getElementById('ctl00_MyCPH1_tb_Vehicle_No').focus(); return false;}
    if (document.getElementById('ctl00_MyCPH1_tb_Trip_Sheet_ID').value == '') {alert('Please input Journey ID'); document.getElementById('ctl00_MyCPH1_tb_Trip_Sheet_ID').focus(); return false;}
    if (document.getElementById('ctl00_MyCPH1_tb_VendorCode').value == '') {alert('Please input Vendor Code'); document.getElementById('ctl00_MyCPH1_tb_VendorCode').focus(); return false;}
    if (document.getElementById('ctl00_MyCPH1_tb_Fuel_Location').value == '') {alert('Please input Fuelling Location'); document.getElementById('ctl00_MyCPH1_tb_Fuel_Location').focus(); return false;}
    if (document.getElementById('ctl00_MyCPH1_ddl_Fuel_Type').value == '') {alert('Please input Fuel Type'); document.getElementById('ctl00_MyCPH1_ddl_Fuel_Type').focus(); return false;}
    if (document.getElementById('ctl00_MyCPH1_ddl_Fuel_Brand').value == '') {alert('Please input Fuel Brand'); document.getElementById('ctl00_MyCPH1_ddl_Fuel_Brand').focus(); return false;}
    if (isNaN(document.getElementById('ctl00_MyCPH1_tb_Curr_Meter_Read').value)) {alert('Invalid Current Meter Reading'); document.getElementById('ctl00_MyCPH1_tb_Curr_Meter_Read').focus(); return false;} if (document.getElementById('ctl00_MyCPH1_tb_Curr_Meter_Read').value == '' || document.getElementById('ctl00_MyCPH1_tb_Curr_Meter_Read').value == '0') {alert('Please input Current Meter Reading'); document.getElementById('ctl00_MyCPH1_tb_Curr_Meter_Read').focus(); return false;} if (parseFloat(document.getElementById('ctl00_MyCPH1_tb_Curr_Meter_Read').value) - parseFloat(document.getElementById('ctl00_MyCPH1_tb_Last_Meter_Read').value) <= 0) {alert('Current Meter Reading must be greater than Last Meter Reading'); document.getElementById('ctl00_MyCPH1_tb_Curr_Meter_Read').focus(); return false;}
    if (isNaN(document.getElementById('ctl00_MyCPH1_tb_Qty_In_Litres').value)) {alert('Invalid Quantity in Litres'); document.getElementById('ctl00_MyCPH1_tb_Qty_In_Litres').focus(); return false;} if (document.getElementById('ctl00_MyCPH1_tb_Qty_In_Litres').value == '' || document.getElementById('ctl00_MyCPH1_tb_Qty_In_Litres').value == '0') {alert('Please input Quantity in Litres'); document.getElementById('ctl00_MyCPH1_tb_Qty_In_Litres').focus(); return false;} if (parseFloat(document.getElementById('ctl00_MyCPH1_tb_Qty_In_Litres').value) < 0) {alert('Negative Quantity in Litres not allowed'); document.getElementById('ctl00_MyCPH1_tb_Qty_In_Litres').focus(); return false;}
    if (isNaN(document.getElementById('ctl00_MyCPH1_tb_Fuel_Cost').value)) {alert('Invalid Fuel Cost'); document.getElementById('ctl00_MyCPH1_tb_Fuel_Cost').focus(); return false;} if (document.getElementById('ctl00_MyCPH1_tb_Fuel_Cost').value == '' || document.getElementById('ctl00_MyCPH1_tb_Fuel_Cost').value == '0') {alert('Please input Fuel Cost'); document.getElementById('ctl00_MyCPH1_tb_Fuel_Cost').focus(); return false;} if (parseFloat(document.getElementById('ctl00_MyCPH1_tb_Fuel_Cost').value) < 0) {alert('Negative Fuel Cost not allowed'); document.getElementById('ctl00_MyCPH1_tb_Fuel_Cost').focus(); return false;}
    if (isNaN(document.getElementById('ctl00_MyCPH1_tb_Fuel_Tax').value)) {alert('Invalid Tax'); document.getElementById('ctl00_MyCPH1_tb_Fuel_Tax').focus(); return false;} if (document.getElementById('ctl00_MyCPH1_tb_Fuel_Tax').value == '' || document.getElementById('ctl00_MyCPH1_tb_Fuel_Tax').value == '0') {alert('Please input Tax'); document.getElementById('ctl00_MyCPH1_tb_Fuel_Tax').focus(); return false;} if (parseFloat(document.getElementById('ctl00_MyCPH1_tb_Fuel_Tax').value) < 0) {alert('Negative Tax allowed'); document.getElementById('ctl00_MyCPH1_tb_Fuel_Tax').focus(); return false;}
    if (document.getElementById('ctl00_MyCPH1_tb_Bill_No').value == '') {alert('Please input Bill No'); document.getElementById('ctl00_MyCPH1_tb_Bill_No').focus(); return false;}
    if (document.getElementById('ctl00_MyCPH1_ddl_Pay_Mode').value == '') {alert('Please input Mode of Payment'); document.getElementById('ctl00_MyCPH1_ddl_Pay_Mode').focus(); return false;}
   
    
    return true;
}

function setInputDates(tb_Issue_Date, tb_Expiry_Date) {
    tb_Issue_Date.value=document.getElementById('ctl00_MyCPH1_dp_Issue_Date_tb_Date').value;
    tb_Expiry_Date.value=document.getElementById('ctl00_MyCPH1_dp_Expiry_Date_tb_Date').value;
}

function selectVendor(obj) {
    var selectedValue=obj.value.split('~');

    window.opener.document.getElementById('ctl00_MyCPH1_tb_VendorCode').value=selectedValue[0];
    window.opener.document.getElementById('ctl00_MyCPH1_lbl_VendorName').innerText=selectedValue[1];
    window.close();
}

function selectJourney(obj) {
    var selectedValue=obj.value.split('~');

    window.opener.document.getElementById('ctl00_MyCPH1_tb_Trip_Sheet_ID').value=selectedValue[0];
    window.opener.document.getElementById('ctl00_MyCPH1_lbl_Driver_Name').innerText=selectedValue[1];
    window.close();
}

function selectVehicle(obj) {
    //alert(obj.value);
    var selectedValue=obj.value.split('~');

    window.opener.document.getElementById('ctl00_MyCPH1_tb_Vehicle_No').value=selectedValue[0];
    //window.opener.document.getElementById('ctl00_MyCPH1_lbl_Manufacturer').innerText=selectedValue[1];
    //window.opener.document.getElementById('ctl00_MyCPH1_lbl_Model').innerText=selectedValue[2];
    //window.opener.document.getElementById('ctl00_MyCPH1_lbl_Fuel_Tank_Capacity').innerText=selectedValue[3];
    //window.opener.document.getElementById('ctl00_MyCPH1_tb_Last_Meter_Read').value=selectedValue[4];
    window.close();
}

function calculateTotalKMs(tb_Last_Meter_Read, tb_Curr_Meter_Read, lbl_Total_KMs) {
    lbl_Total_KMs.innerText = parseFloat(tb_Curr_Meter_Read.value) - parseFloat(tb_Last_Meter_Read.value);
}

function calculateTotalCostAndFuelRate(tb_Qty_In_Litres, tb_Fuel_Cost, tb_Fuel_Tax, lbl_Fuel_Total_Cost, lbl_Fuel_Rate) {
    lbl_Fuel_Total_Cost.innerText = parseFloat(tb_Fuel_Cost.value) + parseFloat(tb_Fuel_Tax.value);
    lbl_Fuel_Rate.innerText = roundNumber(parseFloat(lbl_Fuel_Total_Cost.innerText) / parseFloat(tb_Qty_In_Litres.value), 2);
}

function createXMLHttpRequest() {
    // Mozilla, Safari,...
	if (window.XMLHttpRequest){xmlHttpRequest=new XMLHttpRequest();if(xmlHttpRequest.overrideMimeType)xmlHttpRequest.overrideMimeType('text/xml');}
	// IE
	else if(window.ActiveXObject){try{xmlHttpRequest=new ActiveXObject('Msxml2.XMLHTTP');}catch(e){try{xmlHttpRequest=new ActiveXObject('Microsoft.XMLHTTP');}catch(e){}}}
}

function checkDuplicateFuelBrandName(Fuel_Brand_ID, tb_Fuel_Brand_Name, lbl_Brand_Error) {
    createXMLHttpRequest();

    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function() {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue=xmlHttpRequest.responseText;

                if (returnValue == 'Y') {
                    lbl_Brand_Error.style.color='red';
                    lbl_Brand_Error.innerText = 'Brand name already exist !!';
                    tb_Fuel_Brand_Name.focus();
                }
                else {
                    lbl_Brand_Error.innerText = '';
                }
            }
        }

        xmlHttpRequest.open('GET', 'AJAX_Validator/wfrm_AJAX_Validator.aspx?Function=CheckDuplicateFuelBrandName&Fuel_Brand_ID=' + Fuel_Brand_ID + '&Fuel_Brand_Name=' + tb_Fuel_Brand_Name.value, false);
        xmlHttpRequest.send(null);
    }	
}

function checkDuplicateFuelCardNo(Fuel_Card_ID, tb_Manual_Fuel_Card_No, lbl_Manual_Fuel_Card_Error) {
    createXMLHttpRequest();
   
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function() {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue=xmlHttpRequest.responseText;

                if (returnValue == 'Y') {
                    lbl_Manual_Fuel_Card_Error.style.color='red';
                    lbl_Manual_Fuel_Card_Error.innerText = 'Card name already exist !!';
                    tb_Manual_Fuel_Card_No.focus();
                }
                else {
                    lbl_Manual_Fuel_Card_Error.innerText = '';
                }
            }
        }

        xmlHttpRequest.open('GET', 'AJAX_Validator/wfrm_AJAX_Validator.aspx?Function=CheckDuplicateFuelCardNo&Fuel_Card_ID=' + Fuel_Card_ID + '&Manual_Fuel_Card_No=' + tb_Manual_Fuel_Card_No.value, false);
        xmlHttpRequest.send(null);
    }	
}


function checkDuplicateFuelCardNoVehicle(Fuel_Card_ID, tb_Vehicle_No, lbl_Vehicle_Error) {
    createXMLHttpRequest();
    alert("hi");
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function() {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue=xmlHttpRequest.responseText;
                alert(returnValue);
                if (returnValue == 'Y') {
                    lbl_Vehicle_Error.style.color='red';
                    lbl_Vehicle_Error.innerText = 'Card name already exist !!';
                    tb_Vehicle_No.focus();
                }
                else if (returnValue == '') {
                    lbl_Vehicle_Error.style.color='red';
                    lbl_Vehicle_Error.innerText = 'Card name already exist to this vehicle !!';
                    tb_Vehicle_No.focus();
                }
                else {
                    lbl_Vehicle_Error.innerText = '';
                }
            }
        }

        xmlHttpRequest.open('GET', 'AJAX_Validator/wfrm_AJAX_Validator.aspx?Function=CheckDuplicateFuelCardNoVehicle&Fuel_Card_ID=' + Fuel_Card_ID + '&Vehicle_No=' + tb_Vehicle_No.value, false);
        xmlHttpRequest.send(null);
    }	
}


function checkDuplicateFuelManualTicketNo(Ticket_No, tb_Manual_Ticket_No, lbl_Ticket_Error) {
    createXMLHttpRequest();

    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function() {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue=xmlHttpRequest.responseText;

                if (returnValue == 'Y') {
                    lbl_Ticket_Error.style.color='red';
                    lbl_Ticket_Error.innerText = 'Already exist !!';
                    tb_Manual_Ticket_No.focus();
                }
                else {
                    lbl_Ticket_Error.innerText = '';
                }
            }
        }

        xmlHttpRequest.open('GET', 'AJAX_Validator/wfrm_AJAX_Validator.aspx?Function=CheckDuplicateFuelManualTicketNo&Ticket_No=' + Ticket_No + '&Manual_Ticket_No=' + tb_Manual_Ticket_No.value, false);
        xmlHttpRequest.send(null);
    }	
}

function getVendorDetails(tb_VendorCode, lbl_VendorName) {
    createXMLHttpRequest();

    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function() {
            if (xmlHttpRequest.readyState == 4) {
	            var returnValue=xmlHttpRequest.responseText.split('~')
               
                if (returnValue[0] == 'Y') {
                    lbl_VendorName.style.color='#006699';
                    lbl_VendorName.innerText = returnValue[1];
                }
                else {
                    if (tb_VendorCode.value == '') {        //  User has not put any value
                        lbl_VendorName.innerText = '';
                    }
                    else {
                        lbl_VendorName.style.color='red';
                        lbl_VendorName.innerText = 'Invalid Vendor Code !!';
                        tb_VendorCode.focus();
                    }
                }
            }
        }

        xmlHttpRequest.open('GET', 'AJAX_Validator/wfrm_AJAX_Validator.aspx?Function=GetVendorDetails&VendorCode=' + tb_VendorCode.value, false);
        xmlHttpRequest.send(null);
    }	
}

//function getVehicleDetails(tb_Vehicle_No, hf_Vehicle_No, lbl_Vehicle_Error, lbl_Manufacturer, lbl_Model, lbl_Fuel_Tank_Capacity, tb_Last_Meter_Read, hf_Last_Meter_Read) {
function getVehicleDetails(tb_Vehicle_No,lbl_Vehicle_Error) {
    createXMLHttpRequest();

    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function() {
            if (xmlHttpRequest.readyState == 4) {
	            var returnValue=xmlHttpRequest.responseText.split('~')
                 
                if (returnValue[0] == 'Y') {
                    lbl_Vehicle_Error.style.color='#006699';
                    lbl_Vehicle_Error.innerText = '';
                    //lbl_Manufacturer.innerText = returnValue[1];
                    //lbl_Model.innerText = returnValue[2];
                    //lbl_Fuel_Tank_Capacity.innerText = returnValue[3];
                    //if (tb_Vehicle_No.value == hf_Vehicle_No.value) tb_Last_Meter_Read.value = hf_Last_Meter_Read.value; else tb_Last_Meter_Read.value = returnValue[4];
                }
                else {
                    if (tb_Vehicle_No.value == '') {        //  User has not put any value
                        lbl_Vehicle_Error.innerText = '';
                        //lbl_Manufacturer.innerText = '';
                        //lbl_Model.innerText = '';
                        //lbl_Fuel_Tank_Capacity.innerText = '';
                        //tb_Last_Meter_Read.value = '0';
                    }
                    else {
                        lbl_Vehicle_Error.style.color='red';
                        lbl_Vehicle_Error.innerText = 'Invalid Vehicle Number !!';
                        //lbl_Manufacturer.innerText = '';
                        //lbl_Model.innerText = '';
                        //lbl_Fuel_Tank_Capacity.innerText = '';
                        //tb_Last_Meter_Read.value = '0';

                        tb_Vehicle_No.focus();
                    }
                }
            }
        }

        xmlHttpRequest.open('GET', 'AJAX_Validator/wfrm_AJAX_Validator.aspx?Function=GetVehicleDetails&Vehicle_No=' + tb_Vehicle_No.value, false);
        xmlHttpRequest.send(null);
    }	
}

function getJourneyDetails(tb_Trip_Sheet_ID, lbl_Journey_Error, lbl_Driver_Name) {
    createXMLHttpRequest();

    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function() {
            if (xmlHttpRequest.readyState == 4) {
	            var returnValue=xmlHttpRequest.responseText.split('~')

                if (returnValue[0] == 'Y') {
                    lbl_Journey_Error.innerText = '';
                    lbl_Driver_Name.innerText = returnValue[1];
                }
                else {
                    if (tb_Trip_Sheet_ID.value == '') {        //   User has not put any value
                        lbl_Journey_Error.innerText = '';
                        lbl_Driver_Name.innerText = '';
                    }
                    else {
                        lbl_Journey_Error.style.color='red';
                        lbl_Journey_Error.innerText = 'Invalid Journey ID !!';
                        lbl_Driver_Name.innerText = '';

                        tb_Trip_Sheet_ID.focus();
                    }
                }
            }
        }

        xmlHttpRequest.open('GET', 'AJAX_Validator/wfrm_AJAX_Validator.aspx?Function=GetJourneyDetails&Trip_Sheet_ID=' + tb_Trip_Sheet_ID.value, false);
        xmlHttpRequest.send(null);
    }	
}
