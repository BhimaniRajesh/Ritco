// JScript File

var doc = "document.aspnetForm.ctl00_MyCPH1_"; //common part of all object's name on the form
var docInGrid = "document.aspnetForm.ctl00_MyCPH1_";

//Docket Weight Validation
function CHK_WT(arwt) {
    rowid = arwt.getAttribute('ID').substring(26, 28)
    chgwt = document.getElementById("ctl00_MyCPH1_dgDockets_ctl" + rowid + "_hdwt");
    chgpkg = document.getElementById("ctl00_MyCPH1_dgDockets_ctl" + rowid + "_hdpkgsno");
    Arrpkg = document.getElementById("ctl00_MyCPH1_dgDockets_ctl" + rowid + "_txtPkgs");
    if (parseFloat(chgwt.value) <= parseFloat(arwt.value)) {
        alert("Weight Should Be  Less Than " + chgwt.value)
        //arwt.value=chgwt.value;            
        arwt.value = Math.round((parseFloat(chgwt.value) / parseFloat(chgpkg.value)) * parseFloat(Arrpkg.value))
        arwt.focus();
    }

}
//Date Compare
function MyDateCompare(startDt, endDt) {
    var startDtArr;
    var endDtArr;

    startDtArr = startDt.split('/');
    endDtArr = endDt.split('/');

    var myStartDt = new Date(startDtArr[2], startDtArr[1] - 1, startDtArr[0]);
    var myEndDt = new Date(endDtArr[2], endDtArr[1] - 1, endDtArr[0]);
    var dtDiff = myEndDt.getTime() - myStartDt.getTime();

    dtDiff = dtDiff / 86400000;


    if (Trim(startDt) == Trim(endDt)) {
        dtDiff = 0;
    }
    //alert(dtDiff);
    return dtDiff
}

function BrockrMemoYN() {
    if (eval(doc + "chkBrockrMemo").checked == true) {
        eval(doc + "txtBrockrMemo").value = "YES"
        eval(doc + "uplfBrockrMemo").disabled = false
    }
    else {
        eval(doc + "txtBrockrMemo").value = "NO"
        eval(doc + "uplfBrockrMemo").disabled = true
    }

}

//Docket Weight Enabled
function ENABLED_WT(chkpkg) {
    // alert(chkpkg.value)
    rowid = chkpkg.getAttribute('ID').substring(26, 28)
    chgpkg = document.getElementById("ctl00_MyCPH1_dgDockets_ctl" + rowid + "_hdpkgsno");
    chgwt = document.getElementById("ctl00_MyCPH1_dgDockets_ctl" + rowid + "_hdwt");
    //alert(chgpkg.value)
    arwt = document.getElementById("ctl00_MyCPH1_dgDockets_ctl" + rowid + "_txtWt");
    if (parseFloat(chkpkg.value) > 0) {
        if (parseFloat(chgpkg.value) < parseFloat(chkpkg.value)) {
            alert("Arrived Pkgsno Should Be  Less Than " + chgpkg.value)
            arwt.disabled = true;
            chkpkg.value = chgpkg.value;
            chkpkg.focus();
        }
        else {
            arwt.value = Math.round((parseFloat(chgwt.value) / parseFloat(chgpkg.value)) * parseFloat(chkpkg.value))
            arwt.disabled = false;
        }

        if (parseFloat(chgpkg.value) == parseFloat(chkpkg.value)) {
            arwt.disabled = true;
            arwt.value = chgwt.value;
        }

    }
    else {

        alert("Arrived Pkgsno Should Be  Greter Than 0")
        arwt.disabled = true;
        chkpkg.value = chgpkg.value;
        chkpkg.focus();

    }

}
function CHECKOvld() {
    if (eval(doc + "chkOVLoadYN").checked == true) {
        eval(doc + "txtOVLoadYN").value = "YES"
        eval(doc + "dllOverloadreasn").disabled = false
    }
    else {
        eval(doc + "txtOVLoadYN").value = "NO"
        eval(doc + "dllOverloadreasn").disabled = true
    }

}


function OnMFCheck() {
    var grid = document.getElementById("ctl00_MyCPH1_dgDockets");
    var txtWtLoaded = document.getElementById("ctl00_MyCPH1_txtWtLoaded");
    var txtcaputi = document.getElementById("ctl00_MyCPH1_txtVehicleCapUti");
    var txtvehicleCAP = document.getElementById("ctl00_MyCPH1_txtVehicleCAP");
    var OVLoadYN = document.getElementById("ctl00_MyCPH1_chkOVLoadYN");
    var txtOVLoadYN = document.getElementById("ctl00_MyCPH1_txtOVLoadYN");
    var Overloadreasn = document.getElementById("ctl00_MyCPH1_dllOverloadreasn");
    var CEWB = document.getElementById("ctl00_MyCPH1_txtCEWBNo");

    var vehCap = parseFloat(txtvehicleCAP.value);
    var util = 0.00
    var TotWtLoaded = 0.00;

    var len = parseInt(grid.rows.length);
    var pref = "";
    var cnt = 0;
    var docketlist = [];
    for (i = 2; i <= len; i++) {
        //debugger;
        if (i < 10)
            pref = "ctl00_MyCPH1_dgDockets_ctl0" + i + "_";
        else
            pref = "ctl00_MyCPH1_dgDockets_ctl" + i + "_";

        var chkMF = document.getElementById(pref + "chkDocket");
        var hidWtLoad = document.getElementById(pref + "hidWtLoad");

        var DockNo = document.getElementById(pref + "hdnDktNo").value;
        var EWBNo = document.getElementById(pref + "hdnEWBNo").value;
        var Declval = document.getElementById(pref + "hdnDeclVal").value;
        if (CEWB.value != "") {
            if (parseFloat(Declval) >= parseFloat("50000.00") && EWBNo == "" && chkMF.checked == true) {
                docketlist = DockNo;
                //alert(DockNo + "Declared Value >= 50000 doesn't have EWB No. Kindly update the Docket & re-try ")
                chkMF.checked = false;
                //return false;

            }
        }

        if (chkMF.checked == true) {
            var wt = roundNumber(hidWtLoad.value, 2);
            TotWtLoaded = TotWtLoaded + parseFloat(wt);
        }
        if (docketlist != "") {
            alert(docketlist + " Declared Value >= 50000 doesn't have EWB No. Kindly update the Docket & re-try ")
            return false;
        }

    }
    txtWtLoaded.value = roundNumber(TotWtLoaded, 2);
    if (vehCap > 0) {
        var wtLoad = parseFloat(roundNumber(TotWtLoaded, 2));
        txtcaputi.value = roundNumber(((wtLoad * 100) / vehCap), 2);
        if (wtLoad > vehCap) {
            OVLoadYN.checked = true;
            txtOVLoadYN.value = "YES"
            Overloadreasn.disabled = false;
        }
        else {
            OVLoadYN.checked = false;
            txtOVLoadYN.value = "NO"
            Overloadreasn.disabled = true;
        }
    }
}

//Docket Field Enabled
function ENABLED_ALLFIELDS(chkval) {
	
	var chkDocket = $(chkval);
    if (chkDocket.prop("checked")) {
        var hdnDktDestination = $("#" + $(chkval).attr("id").replace("chkDocket", "hdnDktDestination"));
        var hdnDktOrigin = $("#" + $(chkval).attr("id").replace("chkDocket", "hdnDktOrigin"));
        if (hdnDktDestination.val() == $("#ctl00_MyCPH1_txtTransitLocation").val() || hdnDktOrigin.val() == $("#ctl00_MyCPH1_txtTransitLocation").val()) {
            alert("Transshipment Location can not be same as Docket Destination Location Or Origin Location !!")
            $(chkDocket).prop("checked", false);
            return;
        }
    }
	
    //alert(chkval.getAttribute('ID'))
    rowid = chkval.getAttribute('ID').substring(26, 28)
    // alert(rowid)

    var arpkg = document.getElementById("ctl00_MyCPH1_dgDockets_ctl" + rowid + "_txtPkgs");
    var arwt = document.getElementById("ctl00_MyCPH1_dgDockets_ctl" + rowid + "_txtWt");

    if (chkval.checked == true) {
        arpkg.disabled = false;

    }
    else {
        arpkg.disabled = true;
        arwt.disabled = true;
    }

    OnMFCheck();
}

//select All Docket 
function SelectAll(CheckBoxControl) {
    debugger;
    if (CheckBoxControl.checked == true) {
        var i;
        for (i = 0; i < document.forms[0].elements.length; i++) {
            if ((document.forms[0].elements[i].type == 'checkbox') &&
            (document.forms[0].elements[i].name.indexOf('dgDockets') > -1)) {
                document.forms[0].elements[i].checked = true;

                ENABLED_ALLFIELDS(document.forms[0].elements[i])
            }
        }
    }
    else {
        var i;
        for (i = 0; i < document.forms[0].elements.length; i++) {
            if ((document.forms[0].elements[i].type == 'checkbox') &&
            (document.forms[0].elements[i].name.indexOf('dgDockets') > -1)) {
                document.forms[0].elements[i].checked = false;


                ENABLED_ALLFIELDS(document.forms[0].elements[i])
            }
        }
    }
    OnMFCheck();
}


///THC Step -1 Validation

function DATACHECK_Step1() {

    var THCType = eval(doc + "hdnTHCType").value;
    var THCCalleAs = eval(doc + "hdnTHCCalledAs").value;

    var boo = false;

    //THC Date Validation

    boo = isValidDate(eval(doc + "txtTHCDate").value, THCCalleAs + " Date ");
    if (!boo) {
        eval(doc + "txtTHCDate").focus();
        return false;
    }

    if (MyDateCompare(eval(doc + "hdnSystemDate").value, eval(doc + "txtTHCDate").value) > 0) boo = false;

    if (!boo) {
        alert(THCCalleAs + " Date cannot be greater than Sys. Date:" + eval(doc + "hdnSystemDate").value);
        eval(doc + "txtDOCDate").focus();
        return false;
    }

    //THC Time Validation
    boo = matchPattern(eval(doc + "txtTHCTime").value, "^([0-1][0-9]|[2][0-3]):([0-5][0-9])$", "Entry Time ");
    if (!boo) {
        eval(doc + "txtTHCTime").focus();
        return false;
    }

    if (eval(doc + "dllRouteMode").value == '') {//If Route Mode Not Selected
        alert('Select Route Mode :(');
        eval(doc + "dllRouteMode").focus();
        return false;
    }

    if (THCType == "1") { //thc fROM mf



        if (eval(doc + "dllRouteName").value == '--Routes For Available MFs--') {//If Route Name Not Selected
            alert('Select Route Name :(');
            eval(doc + "dllRouteName").focus();
            return false;
        }
    }
    else if (THCType == "2") { //THC From Docket

        if (eval(doc + "txtTHCDestination").value == '') {//If Route Name Not Selected
            alert('plz Enter Destination :(');
            eval(doc + "txtTHCDestination").focus();
            return false;
        }
    }

    //City Validation
    //if (eval(doc + "chkCity").checked == true) {

        if (eval(doc + "txtFromCity").value == '') {
            alert('plz Enter From city  :(');
            eval(doc + "txtFromCity").focus();
            return false;
        }
        if (eval(doc + "txtToCity").value == '') {
            alert('plz Enter TO city  :(');
            eval(doc + "txtToCity").focus();
            return false;
        }


    //}
	
	if (eval(doc + "chkIsTransshipment").checked == true) {

        if (eval(doc + "txtTransitLocation").value == '') {
            alert('Please Enter Transit Location  :(');
            eval(doc + "txtTransitLocation").focus();
            return false;
        }

        if (eval(doc + "txtTransitRemark").value == '') {
            alert('Please Enter Transit Remark  :(');
            eval(doc + "txtTransitRemark").focus();
            return false;
        }

        if (eval(doc + "txtTransitTentativeFreight").value == '') {
            alert('Please Enter Transit Tentative Freight  !!');
            eval(doc + "txtTransitTentativeFreight").focus();
            return false;
        }

        if (parseFloat(eval(doc + "txtTransitTentativeFreight").value )<=0) {
            alert('Please Enter Transit Tentative Freight  !!');
            eval(doc + "txtTransitTentativeFreight").focus();
            return false;
        }
    }

    if (eval(doc + "dllVendorType").value == '') {//If Vendor Type Not Selected
        alert('Select Vendor Type :(');
        eval(doc + "dllVendorType").focus();
        return false;
    }

    switch (eval(doc + "dllVendorType").value) {
        case 'XX': //Market Vendor Selected
            if (Trim(eval(doc + "txtMarketVendor").value) == '') { //If Market Vendor Name Not Entered
                alert('Enter Vendor Name :(');
                eval(doc + "txtMarketVendor").focus();
                return false;
            }
            break;
        default:
            if (eval(doc + "dllVendors").value == '') {//If Vendor Name Not Selected
                alert('Select Vendor Name :(');
                eval(doc + "dllVendors").focus();
                return false;
            }
    }

    RouteMDval = eval(doc + "dllRouteMode");

    switch (RouteMDval.value) {
        case 'S': //Road
            // alert(eval(doc+"dllVendorType").value);
            switch (eval(doc + "dllVendorType").value) {
                case 'XX':
                    if (Trim(eval(doc + "txtMarketVehicle").value) == '') {
                        alert('Enter Market Vehicle # :(');
                        eval(doc + "txtMarketVehicle").focus();
                        return false;
                    }
                    break;
                case '05': //OWN Vendor
                    if (eval(doc + "dllVehicle").value == '') {
                        alert('Select Vehicle :(');
                        eval(doc + "dllVehicle").focus();
                        return false;
                    }

                    if (eval(doc + "cboTripSheet").value == '') {
                        alert('Select TripSheet # :(');
                        eval(doc + "cboTripSheet").focus();
                        return false;
                    }
                default:
                    //alert("hi...")
                    if (eval(doc + "dllVehicle").value == '') {
                        alert('Select Vehicle :(');
                        eval(doc + "dllVehicle").focus();
                        return false;
                    }

                    if (eval(doc + "dllVehicle").value == 'O') {
                        if (Trim(eval(doc + "txtMarketVehicle").value) == '') {
                            alert('Enter Other Vehicle # :(');
                            eval(doc + "txtMarketVehicle").focus();
                            return false;
                        }
                    }

            }
            if (eval(doc + "dllVehicleTypes").value == '') { //If Vehicle Type Not Selected
                alert('Select Vehicle Type :(');
                eval(doc + "dllVehicleTypes").focus();
                return false;
            }

            if (eval(doc + "dllFTLType").value == '') { //If Vehicle Type Not Selected
                alert('Select Type of Movement :(');
                eval(doc + "dllFTLType").focus();
                return false;
            }

            if (Trim(eval(doc + "txtEngineNo").value) == '') { //If Engine No Not Entered
                alert('Enter Engine No. :(');
                eval(doc + "txtEngineNo").focus();
                return false;;
            }

            if (Trim(eval(doc + "txtChasisNo").value) == '') { //If Chasis No Not Entered
                alert('Enter Chasis No. :(');
                eval(doc + "txtChasisNo").focus();
                return false;;
            }

            if (Trim(eval(doc + "txtRCBookNo").value) == '') { //If RC Book No Not Entered
                alert('Enter RC Book No. :(');
                eval(doc + "txtRCBookNo").focus();
                return false;;
            }


            boo = isValidDate(eval(doc + "txtVehicleRegdate").value, 'Vehicle Reg. Date ');
            if (!boo) {
                eval(doc + "txtVehicleRegdate").focus();
                return false;
            }

            if (MyDateCompare(eval(doc + "txtTHCDate").value, eval(doc + "txtVehicleRegdate").value) > 0) boo = false;
            if (!boo) {
                alert("Vehicle Reg. Date cannot be greater than THC Date:" + eval(doc + "txtTHCDate").value);
                eval(doc + "txtVehicleRegdate").focus();
                if (eval(doc + "txtInsDT").disabled == false)
                    eval(doc + "txtVehicleRegdate").focus();

                return false;
            }

            if (eval(doc + "txtVehPermitDT").value != "") {

                boo = isValidDate(eval(doc + "txtVehPermitDT").value, 'Vehicle permit  Validity Date');
                if (!boo) {
                    eval(doc + "txtVehPermitDT").focus();
                    return false;
                }

                if (MyDateCompare(eval(doc + "txtTHCDate").value, eval(doc + "txtVehPermitDT").value) < 0) boo = false;
                if (!boo) {
                    alert("Vehicle permit  Validity Date cannot be Less than THC Date:" + eval(doc + "txtTHCDate").value);
                    if (eval(doc + "txtVehPermitDT").disabled == false)
                        eval(doc + "txtVehPermitDT").focus();

                    return false;
                }

            }

            boo = isValidDate(eval(doc + "txtInsDT").value, 'Insurance Validity Date');
            if (!boo) {
                eval(doc + "txtInsDT").focus();
                return false;
            }

            if (MyDateCompare(eval(doc + "txtTHCDate").value, eval(doc + "txtInsDT").value) < 0) boo = false;
            if (!boo) {
                alert("Insurance Validity Date cannot be Less than THC Date:" + eval(doc + "txtTHCDate").value);
                if (eval(doc + "txtInsDT").disabled == false)
                    eval(doc + "txtInsDT").focus();

                return false;
            }

            boo = isValidDate(eval(doc + "txFitnessDT").value, 'Fitness Validity Date ');
            if (!boo) {
                eval(doc + "txFitnessDT").focus();
                return false;
            }

            if (MyDateCompare(eval(doc + "txtTHCDate").value, eval(doc + "txFitnessDT").value) < 0) boo = false;
            if (!boo) {
                alert("Fitness Validity Date cannot be Less than THC Date:" + eval(doc + "txtTHCDate").value);
                eval(doc + "txFitnessDT").focus();
                if (eval(doc + "txFitnessDT").disabled == false)
                    eval(doc + "txFitnessDT").focus();

                return false;
            }

            var tmpString = "";

            tmpString = Trim(eval(doc + "txtDriver1").value) + Trim(eval(doc + "txtLicence1").value) + Trim(eval(doc + "txtIssuedBy1").value) + Trim(eval(doc + "txtLicVDate1").value);
            tmpString += Trim(eval(doc + "txtDriver2").value) + Trim(eval(doc + "txtLicence2").value) + Trim(eval(doc + "txtIssuedBy2").value) + Trim(eval(doc + "txtLicVDate2").value);

            if (tmpString == "") {
                alert('Atleat one Driver Information should be entered :(');
                eval(doc + "txtDriver1").focus();
                return false;
            }

            //Driver 1 Validation
            tmpString = Trim(eval(doc + "txtDriver1").value) + Trim(eval(doc + "txtLicence1").value) + Trim(eval(doc + "txtIssuedBy1").value) + Trim(eval(doc + "txtLicVDate1").value);
            if (tmpString != "") {
                if (Trim(eval(doc + "txtDriver1").value) == "") {
                    alert('Enter Driver 1 Name :(');
                    eval(doc + "txtDriver1").focus();
                    return false;
                }
                if (Trim(eval(doc + "txtLicence1").value) == "") {
                    alert('Enter Driver 1 Licence # :(');
                    eval(doc + "txtLicence1").focus();
                    return false;
                }
                if (Trim(eval(doc + "txtIssuedBy1").value) == "") {
                    alert('Enter Driver 1 Licence Issued By RTO :(');
                    eval(doc + "txtIssuedBy1").focus();
                    return false;
                }

                boo = isValidDate(eval(doc + "txtLicVDate1").value, 'Driver 1 Licence Validity Date ');
                if (!boo) {
                    eval(doc + "txtLicVDate1").focus();
                    return false;
                }
                if (MyDateCompare(eval(doc + "txtTHCDate").value, eval(doc + "txtLicVDate1").value) < 0) boo = false;
                if (!boo) {
                    alert("Driver 1 Licence Validity Date cannot be Less than THC Date:" + eval(doc + "txtTHCDate").value);
                    eval(doc + "txtLicVDate1").focus();
                    if (eval(doc + "txtLicVDate1").disabled == false)
                        eval(doc + "txtLicVDate1").focus();

                    return false;
                }
            }
            //alert('..');
            //Driver 2 Validation
            tmpString = Trim(eval(doc + "txtDriver2").value) + Trim(eval(doc + "txtLicence2").value) + Trim(eval(doc + "txtIssuedBy2").value) + Trim(eval(doc + "txtLicVDate2").value);
            if (tmpString != "") {
                if (Trim(eval(doc + "txtDriver2").value) == "") {
                    alert('Enter Driver 2 Name :(');
                    eval(doc + "txtDriver2").focus();
                    return false;
                }
                if (Trim(eval(doc + "txtLicence2").value) == "") {
                    alert('Enter Driver 2 Licence # :(');
                    eval(doc + "txtLicence2").focus();
                    return false;
                }
                if (Trim(eval(doc + "txtIssuedBy2").value) == "") {
                    alert('Enter Driver 2 Licence Issued By RTO :(');
                    eval(doc + "txtIssuedBy2").focus();
                    return false;
                }

                boo = isValidDate(eval(doc + "txtLicVDate2").value, 'Driver 2 Licence Validity Date ');
                if (!boo) {
                    eval(doc + "txtLicVDate2").focus();
                    return false;
                }
                if (MyDateCompare(eval(doc + "txtTHCDate").value, eval(doc + "txtLicVDate2").value) < 0) boo = false;
                if (!boo) {
                    alert("Driver 2 Licence Validity Date cannot be Less than THC Date:" + eval(doc + "txtTHCDate").value);
                    eval(doc + "txtLicVDate1").focus();
                    if (eval(doc + "txtLicVDate1").disabled == false)
                        eval(doc + "txtLicVDate1").focus();

                    return false;
                }
            }


            if (Trim(eval(doc + "txtOVFS").value) == "") {
                alert("Enter Vehicle Free Space :(");
                eval(doc + "txtOVFS").focus();
                return false;
            }

            if (isNaN(eval(doc + "txtOVFS").value)) {
                alert("Enter Numeric Value for Out VFS :(");
                eval(doc + "txtOVFS").focus();
                return false;
            }

            if (parseInt(eval(doc + "txtOVFS").value) < 0 || parseInt(eval(doc + "txtOVFS").value) > 100) {
                alert("Vehicle Free Space should be between 0 and 100 :(");
                eval(doc + "txtOVFS").focus();
                return false;
            }
            /*
            if (Trim(eval(doc + "txtSealNo").value) == "") {
            alert("Enter Seal No. :(");
            eval(doc + "txtSealNo").focus();
            return false;
            }

            tmpString = Trim(eval(doc + "txtSealNo").value);
            //alert(tmpString.length);
            if (tmpString.length < 3) {
            alert("Seal No. should be atleast 3 chars. :(");
            eval(doc + "txtSealNo").focus();
            return false;
            }

            CheckSealNo(eval(doc + "txtSealNo"));

            */

            break;

        case 'R': //Traine
            if (Trim(eval(doc + "txtTrainName").value) == '') {
                alert('Enter Train Name :(');
                eval(doc + "txtTrainName").focus();
                return false;
            }

            if (Trim(eval(doc + "txtTrainNo").value) == '') {
                alert('Enter Train No. :(');
                eval(doc + "txtTrainNo").focus();
                return false;
            }

            if (Trim(eval(doc + "txtRRNo").value) == '') {
                alert('Enter RR No. :(');
                eval(doc + "txtRRNo").focus();
                return false;
            }
            break;
        default: //Air
            if (Trim(eval(doc + "dllAirport").value) == '') {
                alert('Select  Airport :(');
                eval(doc + "txtAirlineName").focus();
                return false;
            }

            if (Trim(eval(doc + "dllAirline").value) == '') {
                alert('Select AirLine  :(');
                eval(doc + "dllAirline").focus();
                return false;
            }

            if (Trim(eval(doc + "dllFilghtNo").value) == '') {
                alert('Select Fligt No. :(');
                eval(doc + "dllFilghtNo").focus();
                return false;
            }

            if (Trim(eval(doc + "txtAWBNo").value) == '') {
                alert('Enter Airway Bill No. :(');
                eval(doc + "txtAWBNo").focus();
                return false;
            }
    }


} //End

function CheckSealNo(txtSLNo) {
    if (txtSLNo.value != "") {
        if (txtSLNo.value == "Open Body") {
            eval(doc + "imgSealNo").style.display = 'Block';
            return true;
        }

        var objXMLHttpObject = false;
        objXMLHttpObject = GetXMLHttpObject();

        if (objXMLHttpObject) {
            var boolLocationCode = "CheckValidation.aspx?function=IsValiedSealNo&SEALNO=" + txtSLNo.value + "&LOC=" + eval(doc + "hBrCd").value + "&sid=" + Math.random() + "&sid2" + Math.random();
            objXMLHttpObject.open("GET", boolLocationCode);

            objXMLHttpObject.onreadystatechange = function () {
                if ((objXMLHttpObject.readyState == 4) && (objXMLHttpObject.status == 200)) {
                    var result = objXMLHttpObject.responseText.split("|");

                    if (result[0] == "0") {
                        // alert("false:");
                        alert(result[1]);
                        eval(doc + "imgSealNo").style.display = 'none';
                        txtSLNo.value = "";
                        txtSLNo.focus();
                        return false;
                    }
                    else {
                        // alert("true:");
                        eval(doc + "imgSealNo").style.display = 'Block';
                        return true;
                    }
                }
            }
            objXMLHttpObject.send(null);
        }
    }
    else {
        eval(doc + "imgSealNo").style.display = 'None';
        return false;
    }
    return true;
}


function locTest(txtid, testtype) {

    var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");
    hdnajaxstate.value = "1";
    var btnStep1 = document.getElementById("ctl00_MyCPH1_btnStep1");

    var currLoc = '<%=SessionUtilities.CurrentBranchCode %>';
    var txt = document.getElementById(txtid);

    if (txt.value == "") {
        hdnajaxstate.value = "0";
        return false;
    }

    txt.value = txt.value.toUpperCase();
    var strpg = "";
    var findobj = false;
    findobj = GetXMLHttpObject();
    if (findobj) {
        strpg = "../AjaxResponse.aspx?mode=check&code1=" + testtype + "&code2=" + txt.value + "&currloc=" + currLoc + "&sid=" + Math.random();
        //   alert(" hii 2 : - " + strpg)
        findobj.open("GET", strpg);
        findobj.onreadystatechange = function () {
            //  alert(" hii : - " + findobj.readyState)
            //  alert(" hii 2 : - " + findobj.status)
            if ((findobj.readyState == 4) && (findobj.status == 200)) {

                var res = findobj.responseText.split("|");
                //  alert(res[0])
                if (res[0] == "false") {


                    if (testtype == "citytest")
                    { alert("City doesn't Exists..."); }
                    else if (testtype == "loctest" || testtype == "LSMFloctest" || testtype == "OTloctest")
                    { alert(res[1]); }
                    else if (testtype == "zonetest")
                    { alert("Region doesn't Exists..."); }
                    else if (testtype == "emptest")
                    { alert("Employee doesn't Exists..."); }

                    txt.value = "";
                    txt.focus();
                    hdnajaxstate.value = "0";
                    btnStep1.disabled = true;
                    return false;
                }
                else if (res[0] == "true") {
                    hdnajaxstate.value = "0";
                    btnStep1.disabled = false;

                }
            }
        }
        findobj.send(null);
    }
    return true;
}
function onRelatedLocationSelected(source, eventArgs) {
    var txtrelocation = document.getElementById("ctl00_MyCPH1_txtTHCDestination");
    var hidReLocation = document.getElementById("ctl00_MyCPH1_hdnTHCDestination");
    //var hidReLocation = $get("<%=hdnTHCDestination.ClientID %>");
    var results = eventArgs._text;
    // alert(results)
    var arrVal = results.split('~ ');
    hidReLocation.value = arrVal[1];
    txtrelocation.value = arrVal[1];
}


//Weight Adjustment

function CHECKWTADJ() {
    if (eval(doc + "chkWtAdjCP").checked == true) {
        eval(doc + "dllWtAdj").disabled = false
        eval(doc + "txtWtAdj").disabled = false
    }
    else {
        eval(doc + "dllWtAdj").disabled = true
        eval(doc + "txtWtAdj").disabled = true
    }

}

//Step 2 Validation
function DATACHECK_Step2() {

    try {
        document.getElementById('ctl00_MyCPH1_tr_div_setp2').style.display = "none";

        if (Trim(eval(doc + "txtOutRemarks").value) == '') {
            eval(doc + "txtOutRemarks").focus();
            throw new Error('Enter  Remarks :(');
        }
        /*
        if (Trim(eval(doc + "txtStartKM").value) == "") {
        alert("Enter Start KMs :(");
        eval(doc + "txtStartKM").focus();
        return false;
        }

        if (isNaN(eval(doc + "txtStartKM").value)) {
        alert("Enter Numeric Value for Start KM :(");
        eval(doc + "txtStartKM").focus();
        return false;
        }


        if (parseInt(eval(doc + "txtStartKM").value) < 0) {
        alert("Start KM cannot be negetive :(");
        eval(doc + "txtStartKM").focus();
        return false;
        }
        */
        if (eval(doc + "chkOVLoadYN").checked == true) {
            if (parseInt(eval(doc + "dllOverloadreasn").value) == "") {
                eval(doc + "dllOverloadreasn").focus();
                throw new Error("Please Select Overload reason :(");
            }

        }


        var GV_frmname = "ctl00_MyCPH1_dgDockets_";
        var GV = document.getElementById("ctl00_MyCPH1_dgDockets");
        var rno = parseInt(GV.rows.length) + 1;
        var pref = "";
        var chkcount = 0;
        for (var ij = 2; ij < rno; ij++) {
            if (ij < 10)
                pref = GV_frmname + "ctl0" + ij + "_";
            else
                pref = GV_frmname + "ctl" + ij + "_";

            var chk = document.getElementById(pref + "chkDocket");

            if (chk.checked == true) {
                chkcount++;
            }
        }
        if (chkcount == 0) {
            throw new Error("No Row Selected..........");
        }

        var THCCalleAs = eval(doc + "hdnTHCCalledAs").value;
        var DKTCalleAs = eval(doc + "hdnDKTCalleAs").value;

        if (IsTHCDateLessThanDKTDate()) {
            throw new Error('Atleast one ' + DKTCalleAs + ' selected has Date > ' + THCCalleAs + ' Date');
        }
    }
    catch (e) {
        document.getElementById('ctl00_MyCPH1_tr_div_setp2').style.display = "block";
        alert(e.message);
        return false;
    }
}

function IsTHCDateLessThanDKTDate() {
    var boo = false;
    var knt = -1;
    //  alert("Hii..2")
    var GV_frmname = "ctl00_MyCPH1_dgDockets_";
    var GV = document.getElementById("ctl00_MyCPH1_dgDockets");
    var rno = parseInt(GV.rows.length) + 1;
    var pref = "";

    for (var ij = 2; ij < rno; ij++) {
        if (ij < 10)
            pref = GV_frmname + "ctl0" + ij + "_";
        else
            pref = GV_frmname + "ctl" + ij + "_";

        var chk = document.getElementById(pref + "chkDocket");

        if (chk.checked == true) {
            // alert("Hiiii"+chk.checked)

            var strdockdt = document.getElementById(pref + "hndgrdockdt");
            // alert(strdockdt.value)
            // alert(eval(doc + "txtTHCDate").value)

            // alert(" 1  " + MyDateCompare(strdockdt.value, eval(doc + "txtTHCDate").value));
            //  alert(" 2  " + MyDateCompare(eval(doc + "txtTHCDate").value, strdockdt.value));

            if (MyDateCompare(strdockdt.value, eval(doc + "txtTHCDate").value) < 0) boo = true;
        }

    }

    return boo;
}


//Step 3 Validation
function DATACHECK_Step3() {
    try {
        document.getElementById('ctl00_MyCPH1_btnSubmit').style.display = "none";

        /*Removed*/
        //if (eval(doc + "chkWtAdjCP").checked == true) {
        //    var txtpluorminus = eval(doc + "dllWtAdj");
        //    //  alert(txtpluorminus.value)
        //    if (txtpluorminus.value == "-") {
        //        //alert(eval(doc+"HIDTOTWT").value)
        //        // alert(eval(doc+"txtWtAdj").value)
        //        if (parseFloat(eval(doc + "hdnTotWt").value) <= parseFloat(eval(doc + "txtWtAdj").value)) {
        //            eval(doc + "txtWtAdj").focus();
        //            throw new Error("Weight Adjustment  should be Less Than MF  Weight  :(");
        //        }

        //    }
        //}
        /*Removed*/


        if (eval(doc + "dllVendorType").value != "05") {
            //alert("hii_22")
            if (eval(doc + "txtContamt").value == "") {
                eval(doc + "txtContamt").focus();
                throw new Error("Enter Contract Amount :(");
            }

            if (eval(doc + "txtContamt").value == "") {
                eval(doc + "txtContamt").focus();
                throw new Error("Enter Contract Amount :(");
            }

            if (parseInt(eval(doc + "txtContamt").value) <= 0) {
                eval(doc + "txtContamt").focus();
                throw new Error("Contract Amount  should be Greater Than 0 :(");
            }
            if (eval(doc + "txtAdvamt").value != "" || parseInt(eval(doc + "txtAdvamt").value)) {
                if (parseInt(eval(doc + "txtAdvamt").value) >= parseInt(eval(doc + "txtContamt").value)) {
                    eval(doc + "txtAdvamt").focus();
                    throw new Error("Advance Amount should be Less Than Contract Amount    :(");
                }
            }
            if (parseInt(eval(doc + "txtAdvPaidAt").value) == "") {
                eval(doc + "txtAdvPaidAt").focus();
                throw new Error("Enter Advance paid at location");
            }
            if (parseInt(eval(doc + "txtBalPaidAt").value) == "") {
                eval(doc + "txtBalPaidAt").focus();
                throw new Error("Enter Balance paid at location");
            }
        }

        if (!confirm("Are you Sure that Entered Details are correct and want to Submit Data?")) {
            document.getElementById('ctl00_MyCPH1_btnSubmit').style.display = "block";
            return false;
        }
        //document.getElementById('ctl00_MyCPH1_btnSubmit').style.display = "none";
    }
    catch (e) {
        document.getElementById('ctl00_MyCPH1_btnSubmit').style.display = "block";
        alert(e.message);
        return false;
    }
}

//Time Calculation
function CHECKTime(txtid) {
    // alert("Hii");
    // alert(txtid.value);
    // var txtid = txtid;

    // alert(txtid.value);
    //  alert(txtid.value.substring(0, txtid.value.indexOf(':')));


    if (txtid.value.substring(0, txtid.value.indexOf(':')) != "") {
        if (parseInt(txtid.value.substring(0, txtid.value.indexOf(':'))) > parseInt("23")) {
            alert("Hour must be less than 23.");
            txtid.value = "";
            txtid.focus();
            return false;
        }
    }
    else {
        alert("Pleas Enter Actual Time Hour .");
        txtid.value = "";
        txtid.focus();
        return false;
    }
    //  alert(txtid.value.substring(txtid.value.indexOf(':'), txtid.value.length));

    if (txtid.value.substring(txtid.value.indexOf(':') + 1, txtid.value.length) != "") {
        if (parseInt(txtid.value.substring(txtid.value.indexOf(':') + 1, txtid.value.length)) > parseInt("59")) {
            alert("Minute must be less than 59.");
            txtid.value = txtid.value.substring(0, (txtid.value.indexOf(':') + 1));
            txtid.value = "";
            txtid.focus();
            return false;
        }
    }
    else {
        alert("Pleas Enter Actual Time Minute .");
        txtid.value = txtid.value.substring(0, (txtid.value.indexOf(':') + 1));
        txtid.value = "";
        txtid.focus();
        return false;
    }

    if (txtid.value.substring(0, txtid.value.indexOf(':')).length == 1)
        txtid.value = "0" + txtid.value;

    if (txtid.value.substring(txtid.value.indexOf(':') + 1, txtid.value.length).length == 1)
        txtid.value = txtid.value.substring(0, txtid.value.indexOf(':') + 1) + "0" + txtid.value.substring(txtid.value.indexOf(':') + 1, txtid.value.length);

    //   alert("Done");

}



/*Multiple Advance Changes*/


function fbalamt() {
    if (eval(doc + "contractamt").value == "") {
        alert("Please enter the 'Contract Amount'")
        eval(doc + "contractamt").focus();
        return false;
    }
    if (isNaN(eval(doc + "contractamt").value)) {
        alert("'Contract Amount' should be numeric.")
        eval(doc + "contractamt").focus();
        return false;
    }
    if (parseFloat(eval(doc + "contractamt").value) < 0) {
        alert("'Contract Amount' should not be negative.")
        eval(doc + "contractamt").focus();
        return false;
    }
    camt = eval(doc + "contractamt").value;
    var svctax = ("<%=ServiceTaxRate%>" / 100)
    var othertax = ("<%=OtherTaxRate%>" / 100)
    eval(doc + "svrcamt").value = 0
    eval(doc + "cessamt").value = 0

    if ("<%=routecd%>" == "5555") {
        eval(doc + "svrcamt").value = Math.round((parseInt(camt)) * parseFloat(svctax))
        eval(doc + "cessamt").value = Math.round((parseInt(eval(doc + "svrcamt").value)) * parseFloat(othertax))
    }
    svrcamt = parseInt(eval(doc + "svrcamt").value)
    cessamt = parseInt(eval(doc + "cessamt").value)

    if (eval(doc + "tel_chrg").value == "") {
        alert("Please enter the 'Telephone charges'")
        eval(doc + "tel_chrg").focus();
        return false;
    }
    if (isNaN(eval(doc + "tel_chrg").value)) {
        alert("'Telephone charges' should be numeric.")
        eval(doc + "tel_chrg").focus();
        return false;
    }
    if (parseFloat(eval(doc + "tel_chrg").value) < 0) {
        alert("'Telephone charges' should not be negative.")
        eval(doc + "tel_chrg").focus();
        return false;
    }

    if (eval(doc + "mamul_chrg").value == "") {
        alert("Please enter the 'Mamul charges'")
        eval(doc + "mamul_chrg").focus();
        return false;
    }
    if (isNaN(eval(doc + "mamul_chrg").value)) {
        alert("'Mamul charges' should be numeric.")
        eval(doc + "mamul_chrg").focus();
        return false;
    }
    if (parseFloat(eval(doc + "mamul_chrg").value) < 0) {
        alert("'Mamul charges' should not be negative.")
        eval(doc + "mamul_chrg").focus();
        return false;
    }
    if (eval(doc + "load_chrg").value == "") {
        alert("Please enter the 'Hamali'")
        eval(doc + "load_chrg").focus();
        return false;
    }
    if (isNaN(eval(doc + "load_chrg").value)) {
        alert("'Hamali' should be numeric.")
        eval(doc + "load_chrg").focus();
        return false;
    }
    if (parseFloat(eval(doc + "load_chrg").value) < 0) {
        alert("'Mamul Loading' should not be negative.")
        eval(doc + "load_chrg").focus();
        return false;
    }
    //if (eval(doc+"contractamt").value==0)
    //camt=eval(doc+"stdpcamt").value;
    if (eval(doc + "advanceamt").value == "") {
        alert("Please enter the 'Advance Amount'")
        eval(doc + "advanceamt").focus();
        return false;
    }
    if (isNaN(eval(doc + "advanceamt").value)) {
        alert("'Advance Amount' should be numeric.")
        eval(doc + "advanceamt").focus();
        return false;
    }
    if (parseFloat(eval(doc + "advanceamt").value) < 0) {
        alert("'Advance Amount' should not be negative.")
        eval(doc + "advanceamt").focus();
        return false;
    }
    if (isNaN(eval(doc + "tds_rate").value)) {
        alert("'TDS Rate' should be numeric.")
        eval(doc + "tds_rate").focus();
        return false;
    }
    if (parseFloat(eval(doc + "tds_rate").value) < 0) {
        alert("'TDS Rate' should not be negative.")
        eval(doc + "tds_rate").focus();
        return false;
    }

    if (eval(doc + "svtax_rate").value == "") {
        alert("'Service Tax Rate' should be numeric.")
        eval(doc + "svtax_rate").focus();
        return false;
    }
    if (isNaN(eval(doc + "svtax_rate").value)) {
        alert("'Service Tax Rate' should be numeric.")
        eval(doc + "svtax_rate").focus();
        return false;
    }
    if (parseFloat(eval(doc + "svtax_rate").value) < 0) {
        alert("'Service Tax Rate' should not be negative.")
        eval(doc + "svtax_rate").focus();
        return false;
    }




    var totalcontractamt = parseFloat(eval(doc + "contractamt").value) + parseFloat(eval(doc + "txtmultipt").value) + parseFloat(eval(doc + "txtdetentionchg").value) + parseFloat(eval(doc + "txtheight").value)
    eval(doc + "tds_chrg").value = Math.round(parseFloat(totalcontractamt) * (parseFloat(eval(doc + "tds_rate").value) / 100))
    eval(doc + "svrcamt").value = Math.round(parseFloat(eval(doc + "contractamt").value) * (parseFloat(eval(doc + "svtax_rate").value) / 100))
    eval(doc + "cessamt").value = Math.round(parseFloat(eval(doc + "svrcamt").value) * (2 / 100))
    eval(doc + "hcessamt").value = Math.round(parseFloat(eval(doc + "svrcamt").value) * (1 / 100))
    svrcamt = parseInt(eval(doc + "svrcamt").value)
    cessamt = parseInt(eval(doc + "cessamt").value)
    hcessamt = parseInt(eval(doc + "hcessamt").value)
    //**inland charges calc******
    var indothechrg = 0
    txtcwt = parseInt(eval(doc + "txtcwt").value)
    txtheight = parseInt(eval(doc + "txtheight").value)
    txtdetentionchg = parseInt(eval(doc + "txtdetentionchg").value)
    txtmultipt = parseInt(eval(doc + "txtmultipt").value)
    indothechrg = parseFloat(txtheight) + parseFloat(txtdetentionchg) + parseFloat(txtmultipt) - parseFloat(txtcwt)
    //**************************************
    //tdsval=Math.ceil(parseFloat(eval(doc+"contractamt").value) * (parseFloat(eval(doc+"tds_rate").value)/100))
    //eval(doc+"tds_chrg").value=tdsval
    m_loadOperType = eval(doc + "loadOpertype").value
    if (m_loadOperType == "P") {
        totchrg = parseFloat(eval(doc + "contractamt").value) + parseFloat(eval(doc + "tel_chrg").value) - parseFloat(eval(doc + "mamul_chrg").value) + parseFloat(eval(doc + "load_chrg").value) + parseFloat(indothechrg)
    }
    else {
        totchrg = parseFloat(eval(doc + "contractamt").value) + parseFloat(eval(doc + "tel_chrg").value) - parseFloat(eval(doc + "mamul_chrg").value) - parseFloat(eval(doc + "load_chrg").value) + parseFloat(indothechrg)

    }

    if (totchrg < 0) totchrg = 0
    netpayamt = parseFloat(eval(doc + "advanceamt").value)//-parseFloat(eval(doc+"tds_chrg").value)
    if (netpayamt < 0) netpayamt = 0
    eval(doc + "netpayamt").value = roundit(netpayamt)


    //eval(doc+"colamt").value=eval(doc+"netpayamt").value
    //eval(doc+"chequeamt").value=eval(doc+"netpayamt").value
    var totchrg
    var advanceamt_paid = eval(doc + "advanceamt_paid").value
    //balamt=Math.round(parseFloat(totchrg)-parseFloat(eval(doc+"advanceamt").value)-parseFloat(eval(doc+"tds_chrg").value))+svrcamt+cessamt
    balamt = Math.round(parseFloat(totchrg) - parseFloat(eval(doc + "netpayamt").value) + svrcamt + cessamt + hcessamt - parseFloat(eval(doc + "tds_chrg").value) - advanceamt_paid)
    if (balamt < 0) balamt = 0
    eval(doc + "balamt").value = Math.round(balamt)
    if (parseFloat(balamt) < 0) {
        alert("'Balance Amount' should not be negative.")
        eval(doc + "advanceamt").focus();
        return false;
    }


    //Added By Anupam 15122016 Start
    if (parseFloat(eval(doc + "advanceamt").value) > 0) {
        if (eval(doc + "txtAdvanceCash").value == "") {
            alert("'Advance Cash' should be numeric.")
            eval(doc + "txtAdvanceCash").focus();
            return false;
        }
        if (eval(doc + "txtAdvanceCheque").value == "") {
            alert("'Advance Cheque' should be numeric.")
            eval(doc + "txtAdvanceCheque").focus();
            return false;
        }

        if (eval(doc + "txtOtherAdvance").value == "") {
            alert("'Other Advance' should be numeric.")
            eval(doc + "txtOtherAdvance").focus();
            return false;
        }

        if (eval(doc + "txtTotalAdvance").value == "") {
            alert("'Total Advance' should be numeric.")
            eval(doc + "txtTotalAdvance").focus();
            return false;
        }

        if (isNaN(eval(doc + "txtAdvanceCash").value)) {
            alert("'Advance Cash' should be numeric.")
            eval(doc + "txtAdvanceCash").focus();
            return false;
        }
        if (isNaN(eval(doc + "txtAdvanceCheque").value)) {
            alert("'Advance Cheque' should be numeric.")
            eval(doc + "txtAdvanceCheque").focus();
            return false;
        }
        if (isNaN(eval(doc + "txtOtherAdvance").value)) {
            alert("'Other Advance' should be numeric.")
            eval(doc + "txtOtherAdvance").focus();
            return false;
        }
        if (isNaN(eval(doc + "txtTotalAdvance").value)) {
            alert("'Total Advance' should be numeric.")
            eval(doc + "txtTotalAdvance").focus();
            return false;
        }
        eval(doc + "txtTotalAdvance").value = Math.round(parseFloat(eval(doc + "txtAdvanceCash").value) + parseFloat(eval(doc + "txtAdvanceCheque").value) + parseFloat(eval(doc + "txtOtherAdvance").value));
        //if (parseFloat(eval(doc + "txtTotalAdvance").value) != parseFloat(eval(doc + "advanceamt").value))
        //{
        //    alert("'Total Advance' should match with Advance Payment System")
        //    eval(doc + "advanceamt").focus();
        //    return false;
        //}

    }
    //Added By Anupam 15122016 End


}



function rounditn(Num, decplaces) {
    Places = decplaces

    if (Places > 0) {
        if ((Num.toString().length - Num.toString().lastIndexOf('.')) > (Places + 1)) {
            if (Num.toString().lastIndexOf('.') < 0) {
                return Num.toString() + '.00';
            }

            var Rounder = Math.pow(10, Places);

            return Math.round(Num * Rounder) / Rounder;
        }
        else {
            if (Num.toString().lastIndexOf('.') < 0) {
                return Num.toString() + '.00';
            }
            else {
                if (Num.toString().lastIndexOf('.') + 1 == Num.toString().length - 1)
                    return Num.toString() + '0';
                else
                    return Num.toString();
            }
        }
    }
    else {
        return Math.round(Num);
    }
}

function roundit(Num) {
    Places = 2

    if (Places > 0) {
        if ((Num.toString().length - Num.toString().lastIndexOf('.')) > (Places + 1)) {
            if (Num.toString().lastIndexOf('.') < 0) {
                return Num.toString() + '.00';
            }

            var Rounder = Math.pow(10, Places);

            return Math.round(Num * Rounder) / Rounder;
        }
        else {
            if (Num.toString().lastIndexOf('.') < 0) {
                return Num.toString() + '.00';
            }
            else {
                if (Num.toString().lastIndexOf('.') + 1 == Num.toString().length - 1) {
                    return Num.toString() + '0';
                }
                else {
                    return Num.toString();
                }
            }
        }
    }
    else {
        return Math.round(Num);
    }
}

function balPayAtBlur(id) {
    // var txt= doc + "balamtbr";
    var txt = eval(doc + "balamtbr").value;
    var findobj = false;
    // alert(txt)
    findobj = GetXMLHttpObject();
    if (findobj) {

        var strpg = "../CheckExist.aspx?loccd=" + txt;
        findobj.open("GET", strpg, true);
        findobj.onreadystatechange = function () {
            if (findobj.readyState == 4 && findobj.status == 200) {
                var res = findobj.responseText.split("|");
                if (res[0] == "false") {
                    alert(res[1]);
                    txt.select();
                    txt.focus();
                }
            }
        }
        findobj.send(null);
    }
}

function createXMLHTTPObject() {
    if (window.XMLHttpRequest) { // Mozilla, Safari,...
        doc = new XMLHttpRequest();
        if (doc.overrideMimeType) {
            doc.overrideMimeType('text/xml');
        }
    } else if (window.ActiveXObject) { // IE
        try {
            doc = new ActiveXObject("Msxml2.XMLHTTP");
        } catch (e) {
            try {
                doc = new ActiveXObject("Microsoft.XMLHTTP");
            } catch (e) { }
        }
    }
}

function Dovalidate() {
    if (doc.readyState == 4) {
        //alert(doc.responseText)
        val = doc.responseText;
        if (val != "OK") {
            alert(doc.responseText)
            formObj.value = "";
            formObj.focus();
        }

        //MyDiv.innerHTML = doc.responseText;
        //document.form1.submit1.focus();
    }
}


function GenerateTHC() {
    //alert('..>>>');
    var ret_boo = true;
    //ret_boo = ValidateData();
    //  alert('here..');
    //alert(ret_boo);
    if (ret_boo) {

        // alert('here.11.' +doc);

        //alert(eval(doc+"cboVendorType").value)
		var joo = true;
		if (MyDateCompare(eval(doc + "hdnSystemDate").value, eval(doc + "txtTHCDate").value) > 0) joo = false;

		if (!joo) {
			alert("THC Date cannot be greater than Sys. Date:" + eval(doc + "hdnSystemDate").value);
			eval(doc + "txtTHCDate").focus();
			ret_boo = false;
			return false;
		}
	
        if (eval(doc + "dllVendorType").value == 'XX') { //Market Vendor

            // alert(eval(doc+"contractamt").value)
            if (eval(doc + "contractamt").value == "") {
                alert("Please enter the 'Contract Amount'")
                eval(doc + "contractamt").focus();
                return false;
            }
            if (isNaN(eval(doc + "contractamt").value)) {
                alert("'Contract Amount' should be numeric.")
                eval(doc + "contractamt").focus();
                return false;
            }
            if (parseFloat(eval(doc + "contractamt").value) < 0) {
                alert("'Contract Amount' should not be negative.")
                eval(doc + "contractamt").focus();
                return false;
            }
            // alert(eval(doc+"contractamt").value)
            if (parseFloat(eval(doc + "contractamt").value) == 0) {
                alert("'Contract Amount' should not be >0.")
                eval(doc + "contractamt").focus();
                return false;
            }

        }
        //alert('here..');
        if (eval(doc + "dllVendorType").value == '05') { //OWN Vendor
            if (eval(doc + "txtContractAmountOWN").value == "") {
                alert('Enter Contract Amount :(');
                eval(doc + "txtContractAmountOWN").focus();
                ret_boo = false;
            }


            if (isNaN(eval(doc + "txtContractAmountOWN").value)) {
                alert('Contract Amount should be Numeric :(');
                eval(doc + "txtContractAmountOWN").focus();
                ret_boo = false;
            }

        } else {
            //alert('there..');
            ret_boo = check_advancedetail();
        }

        //Added By Anupam 15122016 Start
        if (eval(doc + "dllVendorType").value != "05") // Not Equal to Market
        {
            if (eval(doc + "contractamt") != undefined && eval(doc + "advanceamt") != undefined) {
                if (parseFloat(eval(doc + "contractamt").value) < parseFloat(eval(doc + "advanceamt").value)) {
                    alert("'Contract Amount'  can not less than advance amount")
                    eval(doc + "contractamt").focus();
                    return false;
                }

                if (parseFloat(eval(doc + "txtTotalAdvance").value) != parseFloat(eval(doc + "advanceamt").value)) {
                    alert("'Total Advance' should match with Advance Payment System")
                    eval(doc + "advanceamt").focus();
                    return false;
                }
            }
            else {
                ret_boo = false;
            }
        }
        //Added By Anupam 15122016 End
		if (eval(doc + "dllVendorType").value != "05") // Not Equal to Market
        {
            if (ret_boo) {
                var hidClickCountValue = eval(doc + "hidClickCount").value;
                if (hidClickCountValue == 0) {
                    eval(doc + "contractamt").focus();
                    eval(doc + "contractamt").select();
                    hidClickCountValue = parseInt(hidClickCountValue) + 1
                    eval(doc + "hidClickCount").value = hidClickCountValue;
                    return false;
                }
                if (hidClickCountValue == 1) {
                    eval(doc + "advanceamt").focus();
                    eval(doc + "advanceamt").select();
                    hidClickCountValue = parseInt(hidClickCountValue) + 1
                    eval(doc + "hidClickCount").value = hidClickCountValue;
                    return false;
                }
                if (hidClickCountValue == 2) {
                    eval(doc + "balamtbr").focus();
                    eval(doc + "balamtbr").select();
                    hidClickCountValue = parseInt(hidClickCountValue) + 1
                    eval(doc + "hidClickCount").value = hidClickCountValue;
                    return false;
                }

            }
        }


        if (!confirm("Are you Sure that Entered Details are correct and want to Submit Data?")) {
            document.getElementById('ctl00_MyCPH1_btnSubmit').style.display = "block";
            ret_boo = false;
            //return false;
        }

        document.getElementById('ctl00_MyCPH1_btnSubmit').style.display = "none";
        //eval(doc + "btnGenerateTHC")[0].setAttribute("style", "display:none");
    }

    return ret_boo;
}


function check_advancedetail() {
    //    debugger
    //frm_name="ctl00_MyCPH1_"

    //////---------------------Fleet Code---------------------------------------------
    //                if(document.getElementById("ctl00_MyCPH1_ddlRouteMode").value == "S" && document.getElementById("ctl00_MyCPH1_ddlVendorType").value == "05")
    //                {
    //                    if(document.getElementById("ctl00_MyCPH1_ddlTripSheetNo"))
    //                    {
    //                        //alert(document.getElementById("ctl00_MyCPH1_ddlTripSheetNo").value);
    //                        if(document.getElementById("ctl00_MyCPH1_ddlTripSheetNo").value == "" )
    //                        {
    //                            alert("Select Trip Sheet No. from the List!");
    //                            document.getElementById("ctl00_MyCPH1_ddlTripSheetNo").focus();
    //                            return false;
    //                        }
    //                        
    //                        mMktVeh = "N";
    //                    }
    //                }
    //////---------------------End Fleet Code---------------------------------------------  



    var advpaidby = eval(doc + "advpaidby").value

    if (eval(doc + "contractamt").value == "") {
        alert("Please enter the Contract Amount'")
        eval(doc + "contractamt").focus();
        return false;
    }
    if (isNaN(eval(doc + "contractamt").value)) {
        alert("'Contract Amount should be numeric.")
        eval(doc + "contractamt").focus();
        return false;
    }

    if (parseFloat(eval(doc + "contractamt").value) < 0) {
        alert("'Contract Amount should not be negative.")
        eval(doc + "contractamt").focus();
        return false;
    }

    // return false;
    if (parseFloat(eval(doc + "tds_rate").value) > 0) {
        if (parseFloat(eval(doc + "tds_rate").value) > 100) {
            alert("TDS rate can not be greater than 100")
            eval(doc + "tds_rate").focus();
            return false;
        }
    }

    //    if (parseFloat(eval(doc+"tds_chrg").value)>0)
    //    {
    //        
    //    }
    //    else
    //    {
    //        eval(doc+"tdsacccode").value=""
    //    }


    if (eval(doc + "tdsacccode").value == "") {
        alert("Please select the TDS type")
        eval(doc + "tdsacccode").focus();
        return false;
    }

    //var tdsfor=eval(doc+"tdsfor").value
    var tdsacccode = eval(doc + "tdsacccode").value

    //        if (tdsfor=="")
    //        {
    //            alert("Please select TDS deducted for!!!")
    //            eval(doc+"tdsfor").focus();
    //            return false;
    //        }

    if (tdsacccode == "") {
        alert("Please select TDS Type for!!!")
        eval(doc + "tdsacccode").focus();
        return false;
    }

    if (eval(doc + "pan_no").value == "") {
        alert("Please enter the PAN number")
        eval(doc + "pan_no").focus();
        return false;
    }

    if (eval(doc + "pan_no").value != "") {
        if (eval(doc + "pan_no").value.length != 10) {
            alert("PAN number should be of 10 character")
            eval(doc + "pan_no").focus();
            return false;
        }
    }


    if ((isNaN(eval(doc + "advanceamt").value) == true) || (eval(doc + "advanceamt").value == "")) {
        alert("Advance Amount should be ZERO or greater than ZERO");
        eval(doc + "advanceamt").focus();
        return false;
    }
    else {
        var temp
        temp = eval(doc + "advanceamt").value
        if (temp.substring(0, 1) == "-") {
            alert("'Advance Amount' can not be negative")
            eval(doc + "advanceamt").focus();
            return false;
        }
    }

    /*if (parseFloat(eval(doc+"advanceamt").value)> parseFloat(eval(doc+"contractamt").value) )
    {
    alert("'Advance Amount' should not be greater than 'Contract Amount'")
    eval(doc+"advanceamt").focus();
    return false;
    }*/

    var advanceamt_paid = eval(doc + "advanceamt_paid").value
    balamt = Math.round(parseFloat(eval(doc + "contractamt").value) - parseFloat(eval(doc + "advanceamt").value))
    totchrg = parseFloat(eval(doc + "contractamt").value) + parseFloat(eval(doc + "tel_chrg").value) - parseFloat(eval(doc + "mamul_chrg").value) + parseFloat(eval(doc + "load_chrg").value)
    balamt = Math.round(parseFloat(totchrg) - parseFloat(eval(doc + "advanceamt").value) - parseFloat(eval(doc + "tds_chrg").value) - advanceamt_paid)

    eval(doc + "balamt").value = Math.round(balamt)

    balamt = parseFloat(eval(doc + "balamt").value)

    var totalcontractamt = parseFloat(eval(doc + "contractamt").value) + parseFloat(eval(doc + "txtmultipt").value) + parseFloat(eval(doc + "txtdetentionchg").value) + parseFloat(eval(doc + "txtheight").value)
    eval(doc + "tds_chrg").value = Math.round(parseFloat(totalcontractamt) * (parseFloat(eval(doc + "tds_rate").value) / 100))
    eval(doc + "svrcamt").value = Math.round(parseFloat(eval(doc + "contractamt").value) * (parseFloat(eval(doc + "svtax_rate").value) / 100))
    eval(doc + "cessamt").value = Math.round(parseFloat(eval(doc + "svrcamt").value) * (2 / 100))
    svrcamt = parseInt(eval(doc + "svrcamt").value)
    cessamt = parseInt(eval(doc + "cessamt").value)

    //***inland charges calc*******
    var indothechrg = 0
    txtcwt = parseInt(eval(doc + "txtcwt").value)
    txtheight = parseInt(eval(doc + "txtheight").value)
    txtdetentionchg = parseInt(eval(doc + "txtdetentionchg").value)
    txtmultipt = parseInt(eval(doc + "txtmultipt").value)
    indothechrg = parseFloat(txtheight) + parseFloat(txtdetentionchg) + parseFloat(txtmultipt) - parseFloat(txtcwt)
    //**************************************
    //tdsval=Math.ceil(parseFloat(eval(doc+"contractamt").value) * (parseFloat(eval(doc+"tds_rate").value)/100))
    //eval(doc+"tds_chrg").value=tdsval
    m_loadOperType = eval(doc + "loadOpertype").value
    if (m_loadOperType == "P") {
        totchrg = parseFloat(eval(doc + "contractamt").value) + parseFloat(eval(doc + "tel_chrg").value) - parseFloat(eval(doc + "mamul_chrg").value) + parseFloat(eval(doc + "load_chrg").value) + parseFloat(indothechrg)
    }
    else {
        totchrg = parseFloat(eval(doc + "contractamt").value) + parseFloat(eval(doc + "tel_chrg").value) - parseFloat(eval(doc + "mamul_chrg").value) - parseFloat(eval(doc + "load_chrg").value) + parseFloat(indothechrg)
    }
    if (totchrg < 0)
        totchrg = 0

    netpayamt = parseFloat(eval(doc + "advanceamt").value)//-parseFloat(eval(doc+"tds_chrg").value)

    if (netpayamt < 0)
        netpayamt = 0

    eval(doc + "netpayamt").value = roundit(netpayamt)

    var totchrg
    var advanceamt_paid = eval(doc + "advanceamt_paid").value
    balamt = Math.round(parseFloat(totchrg) - parseFloat(eval(doc + "netpayamt").value) + svrcamt + cessamt - parseFloat(eval(doc + "tds_chrg").value) - advanceamt_paid)

    if (balamt < 0)
        balamt = 0

    eval(doc + "balamt").value = Math.round(balamt)

    if (parseFloat(balamt) < 0) {
        balamt = 0
        eval(doc + "balamt").value = 0
    }

    //alert(branches)
    if (parseFloat(balamt) > 0 && ((eval(doc + "balamtbr").value == ""))) {
        alert("Invalid 'Balance Payable at' (i.e. Branch Code) OR Please enter 'Balance Payable at'!!!")
        eval(doc + "balamtbr").focus()
        return false;
    }
    if (parseFloat(balamt) < 0) {
        alert("Balance amount cannot be less than zero,Please enter valid advance amount!!!")
        eval(doc + "advanceamt").focus()
        return false;
    }
    // alert("Done")
    // return false;
    //

    eval(doc + "tds_chrg").disabled = false;
    eval(doc + "cessamt").disabled = false;
    eval(doc + "hcessamt").disabled = false;
    eval(doc + "svrcamt").disabled = false;

    eval(doc + "tel_chrg").disabled = false;
    eval(doc + "load_chrg").disabled = false;
    eval(doc + "mamul_chrg").disabled = false;
    eval(doc + "svtax_rate").disabled = false;

    return true;

}

function validpanno(ctrl){
	
	 if ($(ctrl).val() != "") {
        if ($(ctrl).val().length != 10) {
            alert("PAN number should be of 10 character")
            $(ctrl).focus();
            return false;
        }
    }
}