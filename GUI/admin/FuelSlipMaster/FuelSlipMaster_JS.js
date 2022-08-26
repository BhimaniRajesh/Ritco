function GetTripSheetVehicleDetails(txtVehicleNo) {
    var currentTime = new Date();
    var dgWorkgroup = document.getElementById("ctl00_MyCPH1_dgWorkgroup");
    var l = 0;
    l = dgWorkgroup.rows.length;


    for (i = 0; i < l - 1; i++) {

        var p_str_Index = "";

        j = i + 2
        var pref = "";
        if (j < 10) {
            pref = "ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_";
        }
        else {
            pref = "ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_";
        }


        var txtVehicleNo = document.getElementById(pref + "txtVehicleNo");
        var lblTripNo = document.getElementById(pref + "txtTripsheetNo");
        var lblTripDate = document.getElementById(pref + "txtTripsheetOpenDate");


        if (txtVehicleNo.value == "") {

            txtVehicleNo.value = "";
            lblTripNo.value = "";
            lblTripDate.value = "";
            return
        }

        createXMLHttpRequest();
        if (xmlHttpRequest) {
            xmlHttpRequest.onreadystatechange = function () {
                if (xmlHttpRequest.readyState == 4) {

                    var returnValue = xmlHttpRequest.responseText.split("~");
                    if (returnValue[0] == "N") {
                        txtVehicleNo.value = "";
                        lblTripNo.value = "";
                        lblTripDate.value = "";
                        return
                    }
                    else {
                        lblTripNo.value = returnValue[1];
                        lblTripDate.value = returnValue[2];
                    }
                }
            }
        }
        xmlHttpRequest.open("GET", "../../Fleet/Operations/Issue_FA/AJAX_Validator/AjaxResponse.aspx?Function=FillTripsheetVehicleDetails&datetime=" + currentTime + "&VehicleNo=" + txtVehicleNo.value, false);
        xmlHttpRequest.send(null);
    }
}




function createXMLHttpRequest() {
    // Mozilla, Safari,...
    if (window.XMLHttpRequest) { xmlHttpRequest = new XMLHttpRequest(); if (xmlHttpRequest.overrideMimeType) xmlHttpRequest.overrideMimeType("text/xml"); }
    // IE
    else if (window.ActiveXObject) { try { xmlHttpRequest = new ActiveXObject("Msxml2.XMLHTTP"); } catch (e) { try { xmlHttpRequest = new ActiveXObject("Microsoft.XMLHTTP"); } catch (e) { } } }
}


//**************************************************************************

function CalculateBalance_FuelSlipQnty(row_Index) {
    //debugger
    var dgWorkgroup = document.getElementById("ctl00_MyCPH1_dgWorkgroup");
    var l = 0;
    l = dgWorkgroup.rows.length;
    var txtTotalAmount = "";

    var totdiesel = "0.00", totamt = "0.00", RoundTotAmt = "0.00";

    for (i = 0; i < l - 1; i++) {

        var p_str_Index = "";

        j = i + 2
        var pref = "";
        if (j < 10) {
            pref = "ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_";
        }
        else {
            pref = "ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_";
        }

        var txtQtyLiter = document.getElementById(pref + "txtQtyLiter");
        var txtVendorRate = document.getElementById(pref + "txtVendorRate");
        var txtAmount = document.getElementById(pref + "txtAmount");    
        var txtIGST = document.getElementById(pref + "txtIGST");
        var txtSGST = document.getElementById(pref + "txtSGST");
        var txtCGST = document.getElementById(pref + "txtCGST");
        var txtamounttotal = document.getElementById(pref + "txtamounttotal");
        
        var IGST = parseFloat(txtIGST.value == "" ? "0" : txtIGST.value);
        var SGST = parseFloat(txtSGST.value == "" ? "0" : txtSGST.value);
        var CGST = parseFloat(txtCGST.value == "" ? "0" : txtCGST.value);

        txtAmount.value = "";
        //debugger
        if (txtAmount.value == "" && txtQtyLiter.value != "") {

            totamt = parseFloat(txtQtyLiter.value) * parseFloat(txtVendorRate.value);
            //RoundTotAmt= Math.round(totamt)
            //txtAmount.value = RoundTotAmt; 

            RoundTotAmt = totamt.toFixed(2);
            txtAmount.value = RoundTotAmt;
            txtamounttotal.value = parseFloat(txtAmount.value) + IGST + SGST + CGST;     
        }
    }

}
//+++++++++++++++++++++++++++++

function CalculateBalance_FuelSlipAmt(row_Index) {
    //alert("epognerigbvunowmg,rvb")
    var dgWorkgroup = document.getElementById("ctl00_MyCPH1_dgWorkgroup");
    var l = 0;
    l = dgWorkgroup.rows.length;
    var txtTotalAmount = "";

    var totdiesel = "0.00", totamt = "0.00", RoundTotAmt = "0.00";

    for (i = 0; i < l - 1; i++) {

        var p_str_Index = "";

        j = i + 2
        var pref = "";
        if (j < 10) {
            pref = "ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_";
        }
        else {
            pref = "ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_";
        }

        var txtQtyLiter = document.getElementById(pref + "txtQtyLiter");
        var txtVendorRate = document.getElementById(pref + "txtVendorRate");
        var txtAmount = document.getElementById(pref + "txtAmount");            
        var txtIGST = document.getElementById(pref + "txtIGST");
        var txtSGST = document.getElementById(pref + "txtSGST");
        var txtCGST = document.getElementById(pref + "txtCGST");
        var txtamounttotal = document.getElementById(pref + "txtamounttotal");
      
        var IGST = parseFloat(txtIGST.value == "" ? "0" : txtIGST.value);
        var SGST = parseFloat(txtSGST.value == "" ? "0" : txtSGST.value);
        var CGST = parseFloat(txtCGST.value == "" ? "0" : txtCGST.value);

        txtQtyLiter.value = "";
        //debugger
        if (txtQtyLiter.value == "" && txtAmount.value != "") {

            if (parseFloat(txtAmount.value) < parseFloat(txtVendorRate.value)) {
                alert('Amount cannot be Less than Rate!')
                document.getElementById(pref + "txtAmount").focus();
                return false;
            }

            else {
                if (txtVendorRate.value != "0" && txtVendorRate.value != "") {
                    totamt = parseFloat(txtAmount.value) / parseFloat(txtVendorRate.value);
                }
                //RoundTotAmt = Math.round(totamt)
                //txtQtyLiter.value = RoundTotAmt;

                RoundTotAmt = parseFloat(totamt).toFixed(2);
                txtQtyLiter.value = RoundTotAmt;

                txtamounttotal.value = parseFloat(txtAmount.value) + IGST + SGST + CGST;                
            }
        }
    }

}

//*********************************************************************************************

function CheckValidSlipNo(txtSlipNo, lbl_txtSlipNo_Err) {

    var str_Index = "";
    var currentTime = new Date();
    if (txtSlipNo.value == "") {
        txtSlipNo.value = "";
        lbl_txtSlipNo_Err.innerText = "";
        return;
    }

    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "Y") {
                    //lbl_txtSlipNo_Err.innerText = "Slip Number already exists!!!";
                    alert('Slip Number already exists!');
                    txtSlipNo.focus();
                    return false;
                }
                else {
                    txtSlipNo.value = txtSlipNo.value;
                    lbl_txtSlipNo_Err.innerText = "";
                }
            }
        }
        xmlHttpRequest.open("GET", "../../Fleet/Operations/Issue_FA/AJAX_Validator/AjaxResponse.aspx?Function=CheckValidSlipNo&datetime=" + currentTime + "&SlipNo=" + txtSlipNo.value, false);
        xmlHttpRequest.send(null);
    }
}

//******************************************************************************************

function CheckEmptyGrid(txtVehicleNo) {
    //var currentTime = new Date();
    //debugger
    var dgWorkgroup = document.getElementById("ctl00_MyCPH1_dgWorkgroup");
    var l = 0;
    l = dgWorkgroup.rows.length;


    for (i = 0; i < l - 1; i++) {

        var p_str_Index = "";

        j = i + 2
        var pref = "";
        if (j < 10) {
            pref = "ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_";
        }
        else {
            pref = "ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_";
        }

        var VehicleNo = document.getElementById(pref + "txtVehicleNo");
        var FuelType = document.getElementById(pref + "ddFuelType");
        var SlipNo = document.getElementById(pref + "txtSlipNo");
        var SlipDate = document.getElementById(pref + "txtSlipDate");
        var FuelQuantity = document.getElementById(pref + "txtQtyLiter");


        //debugger
        if (VehicleNo.value == "") {
            alert("Please enter vehicle number");
            document.getElementById(pref + "txtVehicleNo").focus();
            return false;
        }


        if (FuelType.value == "Select" || FuelType.value == "") {
            alert("Please select fuel type");
            document.getElementById(pref + "ddFuelType").focus();
            return false;
        }

        if (SlipNo.value == "") {
            alert("Please enter slip number");
            document.getElementById(pref + "txtSlipNo").focus();
            return false;
        }

        if (SlipDate.value == "") {
            alert("Please enter slip date");
            document.getElementById(pref + "txtSlipDate").focus();
            return false;
        }

        if (FuelQuantity.value == "") {
            alert("Please enter fuel quantity");
            document.getElementById(pref + "txtQtyLiter").focus();
            return false;
        }
    }
}

//----------------------------------------------------------------------------------------------------
//Fuel Rate:  Add Contract
//----------------------------------------------------------------------------------------------------


function RateCheck() {

    var rate = document.getElementById("ctl00_MyCPH1_txtRate").value;
    var c_rate = document.getElementById("ctl00_MyCPH1_txtConfirmRate").value;

    if (rate != c_rate) {
        alert("Rate and confirm rate are not same!");
        document.getElementById("ctl00_MyCPH1_txtConfirmRate").focus();
        return false;
    }

    else {
        return true;
    }
}


function Date_CheckMonth(txtVendor) {

    var FromDate = document.getElementById("ctl00_MyCPH1_txtFromDate").value;
    var ToDate = document.getElementById("ctl00_MyCPH1_txtToDate").value;

}



function CheckEmpty_AddContracts(txtVendor) {

    var Vendor = document.getElementById("ctl00_MyCPH1_txtVendor");
    var FromDate = document.getElementById("ctl00_MyCPH1_txtFromDate");
    var ToDate = document.getElementById("ctl00_MyCPH1_txtToDate");
    var Rate = document.getElementById("ctl00_MyCPH1_txtRate");
    var ConfirmRate = document.getElementById("ctl00_MyCPH1_txtConfirmRate");

    //debugger

    if (Vendor.value == "") {
        alert("Please enter vendor name");
        document.getElementById("ctl00_MyCPH1_txtVendor").focus();
        return false;
    }

    if (FromDate.value == "") {
        alert("Please enter from date");
        document.getElementById("ctl00_MyCPH1_txtFromDate").focus();
        return false;
    }

    if (ToDate.value == "") {
        alert("Please enter to date");
        document.getElementById("ctl00_MyCPH1_txtToDate").focus();
        return false;
    }

    if (Rate.value == "") {
        alert("Please enter rate");
        document.getElementById("ctl00_MyCPH1_txtRate").focus();
        return false;
    }

    if (ConfirmRate.value == "") {
        alert("Please enter confirm rate");
        document.getElementById("ctl00_MyCPH1_txtConfirmRate").focus();
        return false;
    }


    if (FromDate.value != "" && ToDate.value != "") {

        var tt = document.getElementById('ctl00_MyCPH1_txtFromDate').value;
        var ct = document.getElementById('ctl00_MyCPH1_txtToDate').value;

        var dateParts1 = tt.split("/");
        var dateParts2 = ct.split("/");

        var date1 = new Date(dateParts1[2], dateParts1[1] - 1, dateParts1[0]);
        var date2 = new Date(dateParts2[2], dateParts2[1] - 1, dateParts2[0]);

        var timeDiff = Math.abs(date2.getTime() - date1.getTime());
        var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));
        //alert(diffDays);


        if (diffDays <= 60) {
            return true
        }

        else {
            alert("Cannot add contract for more than 60 days!");
            document.getElementById("ctl00_MyCPH1_txtToDate").focus();
            return false;
        }
    }
}


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

//function calculation(a) {

//    if (document.getElementById(d).checked == false) {

//        document.getElementById(c).disabled = true
//        var rows1 = document.getElementById("ctl00_MyCPH1_dgGeneral").rows.length;

//        if (rows1 <= 9) {
//            var id1 = "ctl00_MyCPH1_dgGeneral_ctl0" + rows1 + "_txtTotal"
//        }
//        else {
//            var id1 = "ctl00_MyCPH1_dgGeneral_ctl" + rows1 + "_txtTotal"
//        }
//        document.getElementById(id1).value = parseFloat(document.getElementById(id1).value) - document.getElementById(c).value
//        document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtAmtApplA').value = document.getElementById(id1).value;
//        document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtNetPay').value = document.getElementById(id1).value;

//        if (document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Cash") {
//            {
//                document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtCashAmt').value = document.getElementById(id1).value;
//            }
//        }

//        if (document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Bank") {
//            {
//                document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtChqAmt').value = document.getElementById(id1).value;
//            }
//        }
//        document.getElementById('ctl00_MyCPH1_netamt').value = document.getElementById(id1).value;
//        document.getElementById(c).value = 0

//    }
//    else {
//        document.getElementById(c).disabled = false
//        var tot
//        var varnetamt = document.getElementById(a).innerText
//        var varpendamt = document.getElementById(b).innerText
//        if (varpendamt == "") {
//            varpendamt = 0;
//            tot = parseFloat(varnetamt) - parseFloat(varpendamt)

//        }
//        tot = parseFloat(varnetamt) - parseFloat(varpendamt)

//        document.getElementById(c).value = tot

//        var rows = document.getElementById("ctl00_MyCPH1_dgGeneral").rows.length;

//        if (rows <= 9) {
//            var id = "ctl00_MyCPH1_dgGeneral_ctl0" + rows + "_txtTotal"
//        }
//        else {
//            var id = "ctl00_MyCPH1_dgGeneral_ctl" + rows + "_txtTotal"
//        }

//        if (document.getElementById('ctl00_MyCPH1_netamt').value == "") {
//            document.getElementById('ctl00_MyCPH1_netamt').value = 0.00
//        }

//        document.getElementById(id).value = parseFloat(tot) + parseFloat(document.getElementById(id).value)
//        document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtAmtApplA').value = document.getElementById(id).value;
//        document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtNetPay').value = document.getElementById(id).value;

//        if (document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Cash") {
//            {
//                document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtCashAmt').value = document.getElementById(id).value;
//            }
//        }

//        if (document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Bank") {
//            {
//                document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtChqAmt').value = document.getElementById(id).value;
//            }
//        }
//        document.getElementById('ctl00_MyCPH1_netamt').value = parseFloat(tot) + parseFloat(document.getElementById('ctl00_MyCPH1_netamt').value)
//    }
//}

//00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

//function calculation(row_Index) { 
//    debugger
//    var dgGeneral = document.getElementById("ctl00_MyCPH1_dgGeneral");
//    var l = 0;
//    l = dgGeneral.rows.length;
//    var lblTotalAmt = "";

//    for (i = 0; i < l - 1; i++) {

//        var p_str_Index = "";

//        j = i + 2
//        var pref = "";
//        if (j < 10) {
//            pref = "ctl00_MyCPH1_dgGeneral_ctl0" + j + "_";
//        }
//        else {
//            pref = "ctl00_MyCPH1_dgGeneral_ctl0" + j + "_";
//        }

//        var chkbxCheck = document.getElementById(pref + "chkbxCheck");
//        var lblAmount = document.getElementById(pref + "lblAmount");
//        var txtTotalAmount = document.getElementById("ctl00_MyCPH1_lblTotal");




//        if (chkbxCheck.checked == true) {
//            var tot = 0
//            tot = lblAmount.value + 0
//            txtTotalAmount = tot
//        }
//        else {
//            var tot = 0 
//            txtTotalAmount = tot
//        }
//    }
//}

//RITEEsssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssHHH the name is enouph....



function CalculatePendingAmount(row) {

    var dgGeneral = document.getElementById("ctl00_MyCPH1_dgGeneral");
    var l = 0;
    l = dgGeneral.rows.length;
    var txtTotalAmount = "";

    var totamt = "0.00", RoundTotAmt = "0.00";

    for (i = 0; i < l - 1; i++) {
        j = i + 2
        var pref = "";

        if (j < 10) {
            pref = "ctl00_MyCPH1_dgGeneral_ctl0" + j + "_";
        }
        else {
            pref = "ctl00_MyCPH1_dgGeneral_ctl0" + j + "_";
        }

        var lblAmount = document.getElementById(pref + "lblAmount");
        var txtPaidAmount = document.getElementById(pref + "txtPaidAmount");
        var lblPendingAmount = document.getElementById(pref + "lblPendingAmount");

        if (txtPaidAmount.value != "") {
            totamt = parseFloat(lblAmount.innerText) - parseFloat(txtPaidAmount.value);
            RoundTotAmt = totamt.toFixed(2);
            lblPendingAmount.innerText = RoundTotAmt;
        }
        else {
            return false
        }
    }
}

//--------------------------------------------------
//Standard Expense For Fixed Route 
//--------------------------------------------------

function TrimCity() {

    var r1 = document.getElementById("ctl00_MyCPH1_txtRouteType1").value;
    var r2 = document.getElementById("ctl00_MyCPH1_txtRouteType2").value;
    var r3 = document.getElementById("ctl00_MyCPH1_txtRouteType3").value;
    var r4 = document.getElementById("ctl00_MyCPH1_txtRouteType4").value;
    var r5 = document.getElementById("ctl00_MyCPH1_txtRouteType5").value;
    var r6 = document.getElementById("ctl00_MyCPH1_txtRouteType6").value;
    var r7 = document.getElementById("ctl00_MyCPH1_txtRouteType7").value;
    var r8 = document.getElementById("ctl00_MyCPH1_txtRouteType8").value;
    var r9 = document.getElementById("ctl00_MyCPH1_txtRouteType9").value;
    var r10 = document.getElementById("ctl00_MyCPH1_txtRouteType10").value;


    var result1 = r1.substring(0, 3);
    var result2 = r2.substring(0, 3);
    var result3 = r3.substring(0, 3);
    var result4 = r4.substring(0, 3);
    var result5 = r5.substring(0, 3);
    var result6 = r6.substring(0, 3);
    var result7 = r7.substring(0, 3);
    var result8 = r8.substring(0, 3);
    var result9 = r9.substring(0, 3);
    var result10 = r10.substring(0, 3);

    var final = "";

    if (r1 != "") { final = final + result1; }
    if (r2 != "") { final = final + '-' + result2; }
    if (r3 != "") { final = final + '-' + result3; }
    if (r4 != "") { final = final + '-' + result4; }
    if (r5 != "") { final = final + '-' + result5; }
    if (r6 != "") { final = final + '-' + result6; }
    if (r7 != "") { final = final + '-' + result7; }
    if (r8 != "") { final = final + '-' + result8; }
    if (r9 != "") { final = final + '-' + result9; }
    if (r10 != "") { final = final + '-' + result10; }
    document.getElementById("ctl00_MyCPH1_txtCityTrim").value = final;



    //if (r1 != "" && r2 != "") {
    //    var final = result1 + '-' + result2;
    //    document.getElementById("ctl00_MyCPH1_txtCityTrim").value = final;
    //}
    //if (r1 != "" && r2 != "" && r3 != "") {
    //    var final = result1 + '-' + result2 + '-' + result3;
    //    document.getElementById("ctl00_MyCPH1_txtCityTrim").value = final;
    //} 
    //if (r1 != "" && r2 != "" && r3 != "" && r4 != "") {
    //    var final = result1 + '-' + result2 + '-' + result3 + '-' + result4;
    //    document.getElementById("ctl00_MyCPH1_txtCityTrim").value = final;
    //} 
    //if (r1 != "" && r2 != "" && r3 != "" && r4 != "" && r5 != "") {
    //    var final = result1 + '-' + result2 + '-' + result3 + '-' + result4 + '-' + result5;
    //    document.getElementById("ctl00_MyCPH1_txtCityTrim").value = final;
    //}
    //if (r1 != "" && r2 != "" && r3 != "" && r4 != "" && r5 != "" && r6 != "") {
    //    var final = result1 + '-' + result2 + '-' + result3 + '-' + result4 + '-' + result5 + '-' + result6;
    //    document.getElementById("ctl00_MyCPH1_txtCityTrim").value = final;
    //}
    //if (r1 != "" && r2 != "" && r3 != "" && r4 != "" && r5 != "" && r6 != "" && r7 != "") {
    //    var final = result1 + '-' + result2 + '-' + result3 + '-' + result4 + '-' + result5 + '-' + result6 + '-' + result7;
    //    document.getElementById("ctl00_MyCPH1_txtCityTrim").value = final;
    //}
    //if (r1 != "" && r2 != "" && r3 != "" && r4 != "" && r5 != "" && r6 != "" && r7 != "" && r8 != "") {
    //    var final = result1 + '-' + result2 + '-' + result3 + '-' + result4 + '-' + result5 + '-' + result6 + '-' + result7 + '-' + result8;
    //    document.getElementById("ctl00_MyCPH1_txtCityTrim").value = final;
    //}
    //if (r1 != "" && r2 != "" && r3 != "" && r4 != "" && r5 != "" && r6 != "" && r7 != "" && r8 != "" && r9 != "") {
    //    var final = result1 + '-' + result2 + '-' + result3 + '-' + result4 + '-' + result5 + '-' + result6 + '-' + result7 + '-' + result8 + '-' + result9;
    //    document.getElementById("ctl00_MyCPH1_txtCityTrim").value = final;
    //}
    //if (r1 != "" && r2 != "" && r3 != "" && r4 != "" && r5 != "" && r6 != "" && r7 != "" && r8 != "" && r9 != "" && r10 != "") {
    //    var final = result1 + '-' + result2 + '-' + result3 + '-' + result4 + '-' + result5 + '-' + result6 + '-' + result7 + '-' + result8 + '-' + result10;
    //    document.getElementById("ctl00_MyCPH1_txtCityTrim").value = final;
    //}
}

function CalculateTotalAmount(row) {
    var dgWorkgroup = document.getElementById("ctl00_MyCPH1_dgWorkgroup");
    var l = 0;
    l = dgWorkgroup.rows.length;

    for (i = 0; i < l - 1; i++) {
        

        j = i + 2
        var pref = "";
        if (j < 10) {
            pref = "ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_";
        }
        else {
            pref = "ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_";
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
        txtamounttotal.value=TotalWithGSTAmount;
    }

}
