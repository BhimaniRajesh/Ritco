
/***************************************************************************************************************
                                FILE NAME   :   DocketScripts.js
                                VERSION     :   2.0
                                PURPOSE     :   Client Scripting for Docket Module
                                PROJECT     :   WebXPress
                                Copy Right ECFY Consulting Pvt. Ltd.
***************************************************************************************************************/


/****************************************************************************************************************
    GENERAL SCRIPTS FOR DOCKET ENTRY AND EDIT
****************************************************************************************************************/



/****************************************************************************************************************
   INNER FUNCTION TO CHECK BOOKING DATE
****************************************************************************************************************/
function bookingDateEntryTime() {

    var txtdockdate = document.getElementById("ctl00_MyCPH1_txtdockdate");
    var hdnserverdate = document.getElementById("ctl00_MyCPH1_hdnserverdate");
    var hdnclient = document.getElementById("ctl00_MyCPH1_hdnclient");

    var dkt_call = document.getElementById("ctl00_MyCPH1_hdndockname").value;

    if (txtdockdate.value == "") {
        alert("Please Enter " + dkt_call + " Date.....");
        txtdockdate.select();
        return false;
    }


    // date validation not future for all clients
    var months = new Array("", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
    var datediff = 0;

    var arrserverdate = hdnserverdate.value.split('/');
    var arrdockdt = txtdockdate.value.split('/');

    var dtdockdate = new Date(months[parseFloat(arrdockdt[1])] + " " + arrdockdt[0] + "," + arrdockdt[2]);
    var dtserverdate = new Date(months[parseFloat(arrserverdate[1])] + " " + arrserverdate[0] + "," + arrserverdate[2]);
    datediff = MyDateDiff(dtserverdate, dtdockdate, 'D', true);

    var hdnfinstartyear = document.getElementById("ctl00_MyCPH1_hdnfinstartyear");
    var finendyear = 0;
    finendyear = parseInt(hdnfinstartyear.value) + 1;

    var finstartdt = new Date(months[4] + " 01, " + parseFloat(hdnfinstartyear.value));
    var finenddt = new Date(months[3] + " 31, " + parseFloat(finendyear));

    var finstring = dtdockdate.getFullYear() + "-" + parseInt(parseInt(dtdockdate.getFullYear()) + 1);
    if (dtdockdate < finstartdt || dtdockdate > finenddt) {
        alert("To Enter Booking date " + txtdockdate.value + " please Change Fin Year ");
        return false;
    }

    var hdnbookdaterule = document.getElementById("ctl00_MyCPH1_hdnbookdaterule");
    var arrdtrule = hdnbookdaterule.value.split('|');

    if (arrdtrule[0] == "Y") {
        var arrblwrule = arrdtrule[1].split(',');
        var arrabvrule = arrdtrule[2].split(',');

        var dtblw = arrblwrule[1].split('/');
        var dtabv = arrabvrule[1].split('/');


        var dtblwcompare = new Date(months[parseFloat(dtblw[1])] + " " + dtblw[0] + "," + dtblw[2]);
        var dtabvompare = new Date(months[parseFloat(dtabv[1])] + " " + dtabv[0] + "," + dtabv[2]);

        if (dtdockdate < dtblwcompare) {
            alert("In Valid Booking Date. Booking Date Below Rule Validation");
            return false;
        }

        if (dtabvompare < dtdockdate) {
            alert("In Valid Booking Date. Booking Date Above Rule Validation");
            return false;
        }

    }
    else {
        alert("In Valid Date Rule");
        return false;
    }


    return true;
}
/****************************************************************************************************************/





/****************************************************************************************************************
   VIEWING PARTY CONTRACT
****************************************************************************************************************/
function viewParty() {
    var txtpartycode = document.getElementById("ctl00_MyCPH1_txtpartycode");
    var cmbpaybas = document.getElementById("ctl00_MyCPH1_cmbpaybas");
    var txtdockdate = document.getElementById("ctl00_MyCPH1_txtdockdate");
    var hdndockname = document.getElementById("ctl00_MyCPH1_hdndockname");

    if (txtdockdate.value == "") {
        alert(hdndockname.value + " Date is not Entered...");
        return false;
    }

    if (txtpartycode.value == "") {
        alert("No Party Selected...");
        return false;
    }

    if (cmbpaybas.value == "" || cmbpaybas.value == "0") {
        alert("Payment Basis is not Selected...");
        return false;
    }

    if (txtpartycode.value == "") {
        alert("No Party Selected...");
        return false;
    }
    window.open("DocketPrint/ViewContract.aspx?custcode=" + txtpartycode.value + "&dockdate=" + txtdockdate.value + "&paybas=" + cmbpaybas.value + "&sid=" + Math.random(), null, "");

    return false;
}

/****************************************************************************************************************/


function payBaseChange() {
    var cmbpaybas = document.getElementById("ctl00_MyCPH1_cmbpaybas");
    var txtpartycode = document.getElementById("ctl00_MyCPH1_txtpartycode");
    var btnpartypopup = document.getElementById("ctl00_MyCPH1_btnpartypopup");
    var txtpartyname = document.getElementById("ctl00_MyCPH1_txtpartyname");
    var divpartycsgne = document.getElementById("ctl00_MyCPH1_divpartycsgne");
    var optpartycsgn = document.getElementById("ctl00_MyCPH1_optpartycsgn");
    var optpartycsge = document.getElementById("ctl00_MyCPH1_optpartycsge");

    var hdncontractsets = document.getElementById("ctl00_MyCPH1_hdncontractsets");
    var arrsets = hdncontractsets.value.split(',');

    switch (cmbpaybas.value) {
        case "P01":
            if (arrsets[0] == "C" || arrsets[0] == "CD") {
                txtpartycode.disabled = false;
                txtpartycode.style.backgroundColor = "#ffffff";
                btnpartypopup.style.display = "block";
                txtpartyname.style.display = "block";
                divpartycsgne.style.display = "block";
            }
            else {
                txtpartycode.disabled = true;
                txtpartycode.value = "";
                txtpartycode.style.backgroundColor = "#e6e6e6";
                btnpartypopup.style.display = "none";
                txtpartyname.style.display = "none";
                divpartycsgne.style.display = "none";
                txtpartyname.value = "";
            }
            optpartycsgn.checked = true;
            optpartycsge.checked = false;
            break;
        case "P02":
            if (arrsets[1] == "C" || arrsets[1] == "CD") {
                txtpartycode.disabled = false;
                txtpartycode.style.backgroundColor = "#ffffff";
                btnpartypopup.style.display = "block";
                txtpartyname.style.display = "block";
                divpartycsgne.style.display = "block";
            }
            else {
                txtpartycode.disabled = true;
                txtpartycode.value = "";
                txtpartycode.style.backgroundColor = "#e6e6e6";
                btnpartypopup.style.display = "none";
                txtpartyname.style.display = "none";
                divpartycsgne.style.display = "none";
                txtpartyname.value = "";
            }
            break;
        case "P03":
            if (arrsets[2] == "C" || arrsets[2] == "CD") {
                txtpartycode.disabled = false;
                txtpartycode.style.backgroundColor = "#ffffff";
                btnpartypopup.style.display = "block";
                txtpartyname.style.display = "block";
                divpartycsgne.style.display = "block";
            }
            else {
                txtpartycode.disabled = true;
                txtpartycode.value = "";
                txtpartycode.style.backgroundColor = "#e6e6e6";
                btnpartypopup.style.display = "none";
                txtpartyname.style.display = "none";
                divpartycsgne.style.display = "none";
                txtpartyname.value = "";
            }
            optpartycsgn.checked = false;
            optpartycsge.checked = true;
            break;
        default:
            txtpartycode.disabled = true;
            txtpartycode.value = "";
            txtpartycode.style.backgroundColor = "#e6e6e6";
            btnpartypopup.style.display = "none";
            txtpartyname.style.display = "none";
            divpartycsgne.style.display = "none";
            txtpartyname.value = "";
            break;
    } // switch of payment basis

    return false;
}


function validateInvoiceDate(id) {
    var txtdate = document.getElementById(id);
    if (txtdate.value == "")
        return false;
    if (!isValidDate(txtdate.value, "Invoice")) {
        txtdate.select();
        txtdate.value = "";
        return true;
    }
}



/****************************************************************************************************************
   CHECKS FOR VALID DATE WITH CUSTOMIZE ALTERT - NOT IN USE
****************************************************************************************************************/
function alertInvalidDate(type) {
    if (type == "dockdate") {
        var txtdockdate = document.getElementById("ctl00_MyCPH1_txtdockdate");
        var dkt_call = document.getElementById("ctl00_MyCPH1_hdndockname").value;

        if (txtdockdate.value != "" && !isValidDate(txtdockdate.value, dkt_call)) {
            txtdockdate.select();
            txtdockdate.value = "";
            return false;
        }
    }
    else if (type == "policy") {
        var txt = document.getElementById("ctl00_MyCPH1_txtpolicydate");
        if (txt.value != "" && !isValidDate(txt.value, "Policy")) {
            txt.select();
            txt.value = "";
            return false;
        }
    }
    else if (type == "permit") {
        var txt = document.getElementById("ctl00_MyCPH1_txtpermitdate");
        if (txt.value != "" && !isValidDate(txt.value, "Permit")) {
            txt.select();
            txt.value = "";
            return false;
        }
    }
    else if (type == "permitvalidity") {
        var txt = document.getElementById("ctl00_MyCPH1_txtpermitvaldate");
        if (txt.value != "" && !isValidDate(txt.value, "Permit Validity")) {
            txt.select();
            txt.value = "";
            return false;
        }
    }
    else if (type == "permitrecvd") {
        var txt = document.getElementById("ctl00_MyCPH1_txtpermitrecvddate");
        if (txt.value != "" && !isValidDate(txt.value, "Permit Recieved")) {
            txt.select();
            txt.value = "";
            return false;
        }
    }
    else if (type == "edd") {
        var txt = document.getElementById("ctl00_MyCPH1_txtedd");
        if (txt.value != "" && !isValidDate(txt.value, "Expected Delivery")) {
            txt.select();
            txt.value = "";
            return false;
        }
    }
}
/****************************************************************************************************************/



/****************************************************************************************************************
   IF VOLUMETRIC IS TRUE THEN SHOW CUBIC CALCULATION ROW
****************************************************************************************************************/
function volumetricClick() {
    var chk = document.getElementById("ctl00_MyCPH1_chkvolumetric");
    var tr = document.getElementById("ctl00_MyCPH1_trcubicfeet");
    if (chk.checked == true)
        tr.style.display = "block";
    else
        tr.style.display = "none";
}
/****************************************************************************************************************/


/****************************************************************************************************************
    ROW GENERATION CONFIRMATION FOR INOVOICE GRID
****************************************************************************************************************/
function generateRows() {
    var txtrows = document.getElementById("ctl00_MyCPH1_txtinvoicerows");
    if (parseFloat(txtrows.value) == 0 || txtrows.value == "") {
        alert("Please Enter No of Rows greater than Zero...");
        txtrows.focus();
        return false;
    }
    else {
        if (confirm("All Invoice Data will be Removed. Do you want to continue ??"))
            return true;
        else
            return false;
    }
}
/****************************************************************************************************************/

function calculateSubTotal() {
    var subtotal = 0.00;
    //var txtsubtotal = document.getElementById("ctl00_MyCPH1_txtsubtotal");

    var txtfreightcharge = document.getElementById("ctl00_MyCPH1_txtfreightcharge");
    var txtfovcharged = document.getElementById("ctl00_MyCPH1_txtfovcharged");
    var txtcoddodcharged = document.getElementById("ctl00_MyCPH1_txtcoddodcharged");
    var txtdacccharged = document.getElementById("ctl00_MyCPH1_txtdacccharged");
    var hdnclient = document.getElementById("ctl00_MyCPH1_hdnclient");
    var chkcoddod = document.getElementById("ctl00_MyCPH1_chkcoddod");
    var chkdacc = document.getElementById("ctl00_MyCPH1_chkdacc");

    if (txtfreightcharge.value == "")
        txtfreightcharge.value = "0.00";

    if (txtfovcharged.value == "")
        txtfovcharged.value = "0.00";

    subtotal = parseFloat(txtfreightcharge.value);
    subtotal = subtotal + parseFloat(txtfovcharged.value);

    if (txtcoddodcharged.value == "")
        txtcoddodcharged.value = "0.00";

    if (txtdacccharged.value == "")
        txtdacccharged.value = "0.00";

    if (chkcoddod.checked == true)
        subtotal = subtotal + parseFloat(txtcoddodcharged.value);

    if (chkdacc.checked == true)
        subtotal = subtotal + parseFloat(txtdacccharged.value);

    /////////////////// AGILITY PRORATA
    var hdnflagprorata = document.getElementById("ctl00_MyCPH1_hdnflagprorata");
    var cmbpaybas = document.getElementById("ctl00_MyCPH1_cmbpaybas");
    var cmbservicetype = document.getElementById("ctl00_MyCPH1_cmbservicetype");
    if (hdnflagprorata.value == "Y") {
        if (cmbpaybas.value == "P02" && cmbservicetype.value == "2") {
            calculateProRata();
        }
    }
    ///////////////////

    // NOW ADDING SIMPLE CHARGES
    var grvcharges = document.getElementById("ctl00_MyCPH1_grvcharges");
    var rows = grvcharges.rows.length;

    var i = 0;
    var pref = "";
    for (i = 2; i <= rows + 1; i++) {
        if (i < 10)
            pref = "ctl00_MyCPH1_grvcharges_ctl0" + i + "_";
        else
            pref = "ctl00_MyCPH1_grvcharges_ctl" + i + "_";

        var txtcharge1 = document.getElementById(pref + "txtcharge1");
        var txtcharge2 = document.getElementById(pref + "txtcharge2");
        var hdnchargecode1 = document.getElementById(pref + "hdnchargecode1");
        var hdnchargecode2 = document.getElementById(pref + "hdnchargecode2");

        var hdnoperator1 = document.getElementById(pref + "hdnoperator1");
        var hdnoperator2 = document.getElementById(pref + "hdnoperator2");

        if (txtcharge1.value == "" || isNaN(txtcharge1.value))
            txtcharge1.value = "0.00";

        if (txtcharge2.value == "" || isNaN(txtcharge2.value))
            txtcharge2.value = "0.00";

        if (hdnoperator1.value == "+")
            subtotal = subtotal + parseFloat(txtcharge1.value);
        else
            subtotal = subtotal - parseFloat(txtcharge1.value);

        if (hdnoperator2.value == "+")
            subtotal = subtotal + parseFloat(txtcharge2.value);
        else
            subtotal = subtotal - parseFloat(txtcharge2.value);

    }

    /* KK Cess */
    LoadControl("ctl00_MyCPH1_ucServiceTax_txtSubTotal");
    var cmbstaxpaidby = document.getElementById("ctl00_MyCPH1_cmbstaxpaidby");
    SetServiceTaxPayerRule(cmbstaxpaidby.value);

    var chkservicetaxexemp = document.getElementById("ctl00_MyCPH1_chkservicetaxexemp");
    SetServiceTaxExemptedRule(chkservicetaxexemp.checked);

    AssignSubTotalToServiceTaxControl(subtotal);

    //var DiscountAmt = 0;
    //var txtDiscount = document.getElementById("ctl00_MyCPH1_txtDiscount");
    //if (txtDiscount == null) {
    //    DiscountAmt = 0;
    //}
    //else {
    //    DiscountAmt = parseFloat(txtDiscount.value);
    //}
    //subtotal = subtotal - parseFloat(DiscountAmt);

    //var hdnflagroundoff = document.getElementById("ctl00_MyCPH1_hdnflagroundoff");
    //if (hdnflagroundoff.value == "Y")
    //    txtsubtotal.value = Math.round(subtotal);
    //else
    //    txtsubtotal.value = roundNumber(subtotal, 2);

    //// AFTER CALCULATING SUBTOTAL CALCULATE SERVICETAX AND DOCKET TOTAL
    //calculateServiceTax();

    return false;
}




function calculateServiceTax() {
    var cmbtransmode = document.getElementById("ctl00_MyCPH1_cmbtransmode");
    var servicetaxrate = parseFloat(document.getElementById("ctl00_MyCPH1_hdnservicetaxrate").value);

    /* SB Cess */
    var lblSbcRate = document.getElementById("ctl00_MyCPH1_lblSbcRate");
    var hdnSbcRate = document.getElementById("ctl00_MyCPH1_hdnSbcRate");
    /* SB Cess */

    var cessrate = parseFloat(document.getElementById("ctl00_MyCPH1_lbleducessrate").innerText);
    var hcessrate = parseFloat(document.getElementById("ctl00_MyCPH1_lblheducessrate").innerText);

    // Displaying Error if Service Tax is not Proper

    if (isNaN(servicetaxrate) || (servicetaxrate == 0 && cmbtransmode.value != "2" && cmbtransmode.value != "4")) {
        alert("Service Tax is not Proper. Invalid DataBase.");
        return false;
    }

    if (isNaN(cessrate) || (cessrate == 0 && cmbtransmode.value != "2" && cmbtransmode.value != "4")) {
        alert("Education Cess Rate is not Proper. Invalid DataBase.");
        return false;
    }

    if (isNaN(hcessrate) || (hcessrate == 0 && cmbtransmode.value != "2" && cmbtransmode.value != "4")) {
        alert("Higher Education Cess Rate is not Proper. Invalid DataBase.");
        return false;
    }

    var txtsubtotal = document.getElementById("ctl00_MyCPH1_txtsubtotal");
    var txtdockettotal = document.getElementById("ctl00_MyCPH1_txtdockettotal");

    var cmbservicetype = document.getElementById("ctl00_MyCPH1_cmbservicetype");
    var cmbstaxpaidby = document.getElementById("ctl00_MyCPH1_cmbstaxpaidby");

    var subtotal = 0.00;
    var dockettotal = 0.00;
    var servicetax = 0.00;
    var cess = 0.00;
    var hcess = 0.00;

    /* SB Cess */
    var sbCess = 0.00;
    var sbcRate = parseFloat(hdnSbcRate.value);
    /* SB Cess */

    subtotal = parseFloat(txtsubtotal.value);

    // FOR ROAD MODE TRANSPORTER GETS 75% REBET

    var hdnRabatePercentage = document.getElementById("ctl00_MyCPH1_hdnRabatePercentage");
    var rabatePercentage = parseFloat(hdnRabatePercentage.value);

    if (cmbtransmode.value == "2" || cmbtransmode.value == "4") {
        if (cmbservicetype.value == "1" && subtotal > 750) {
            servicetaxrate = servicetaxrate * rabatePercentage;
        }
        else if (cmbservicetype.value == "2" && subtotal > 1500) {
            servicetaxrate = servicetaxrate * rabatePercentage;
        }
        else {
            servicetaxrate = 0;
            sbcRate = 0;
        }
    }

    servicetax = subtotal * servicetaxrate / 100;
    cess = servicetax * cessrate / 100;
    hcess = servicetax * hcessrate / 100;

    /* SB Cess */
    sbCess = subtotal * sbcRate / 100;
    /* SB Cess */

    var lblservicetaxrate = document.getElementById("ctl00_MyCPH1_lblservicetaxrate");
    lblservicetaxrate.innerText = roundNumber(servicetaxrate, 2);

    /* SB Cess */
    var txtSBCess = document.getElementById("ctl00_MyCPH1_txtSBCess");
    var txtSBCessSub = document.getElementById("ctl00_MyCPH1_txtSBCessSub");
    /* SB Cess */

    /* SB Cess */
    lblSbcRate.innerText = roundNumber(sbcRate, 2);
    /* SB Cess */

    var txtservicetaxsub = document.getElementById("ctl00_MyCPH1_txtservicetaxsub");
    var txteducesssub = document.getElementById("ctl00_MyCPH1_txteducesssub");
    var txtheducesssub = document.getElementById("ctl00_MyCPH1_txtheducesssub");

    var txtservicetax = document.getElementById("ctl00_MyCPH1_txtservicetax");
    var txteducess = document.getElementById("ctl00_MyCPH1_txteducess");
    var txtheducess = document.getElementById("ctl00_MyCPH1_txtheducess");
    var hdnflagroundoff = document.getElementById("ctl00_MyCPH1_hdnflagroundoff");
    var txtDiscount = document.getElementById("ctl00_MyCPH1_txtDiscount");

    if (cmbstaxpaidby.value == "T" || cmbstaxpaidby.value == "Transporter") {
        if (hdnflagroundoff.value == "Y") {
            txtservicetax.value = Math.round(servicetax);
            txteducess.value = Math.round(cess);
            txtheducess.value = Math.round(hcess);

            txtSBCess.value = Math.round(sbCess);
            txtSBCessSub.value = Math.round(sbCess);/* SB Cess */
        }
        else {
            txtservicetax.value = roundNumber(servicetax, 2);
            txteducess.value = roundNumber(cess, 2);
            txtheducess.value = roundNumber(hcess, 2);

            txtSBCess.value = roundNumber(sbCess, 2);
            txtSBCessSub.value = roundNumber(sbCess, 2);/* SB Cess */
        }
    }
    else {
        txtservicetax.value = "0.00";
        txteducess.value = "0.00";
        txtheducess.value = "0.00";
        lblservicetaxrate.innerText = "0.00";

        txtSBCess.value = txtSBCessSub.value = lblSbcRate.innerText = "0.00"; /* SB Cess */
        sbCess = 0;
    }

    if (hdnflagroundoff.value == "Y") {
        txtservicetaxsub.value = Math.round(servicetax);
        txteducesssub.value = Math.round(cess);
        txtheducesssub.value = Math.round(hcess);

        txtSBCess.value = Math.round(sbCess);
        txtSBCessSub.value = Math.round(sbCess); /* SB Cess */
    }
    else {
        txtservicetaxsub.value = roundNumber(servicetax, 2);
        txteducesssub.value = roundNumber(cess, 2);
        txtheducesssub.value = roundNumber(hcess, 2);

        txtSBCess.value = roundNumber(sbCess, 2);
        txtSBCessSub.value = roundNumber(sbCess, 2); /* SB Cess */
    }

    //ASSIGNING GRAND TOTAL
    /* SB Cess */
    dockettotal = parseFloat(subtotal) + parseFloat(txtservicetax.value) + parseFloat(txteducess.value) + parseFloat(txtheducess.value)
        + parseFloat(txtSBCess.value);
    /* SB Cess */

    if (hdnflagroundoff.value == "Y")
        txtdockettotal.value = Math.round(dockettotal);
    else
        txtdockettotal.value = roundNumber(dockettotal, 2);

    return false;
}



function freightRateBlur() {
    var txtfreightrate = document.getElementById("ctl00_MyCPH1_txtfreightrate");
    var txtfreightcharge = document.getElementById("ctl00_MyCPH1_txtfreightcharge");
    var cmbratetype = document.getElementById("ctl00_MyCPH1_cmbratetype");
    try {
        var hdnfreightrate = document.getElementById("ctl00_MyCPH1_hdnfreightrate");
        var hdnfreightcharge = document.getElementById("ctl00_MyCPH1_hdnfreightrate");
        if (parseFloat(txtfreightrate.value) < parseFloat(hdnfreightrate.value)) {
            alert('Freight Rate can not be less than ' + parseFloat(hdnfreightrate.value));
            txtfreightrate.focus();
            return false;
        }
    }
    catch (e) { }
    var txttotchargedweight = document.getElementById("ctl00_MyCPH1_txttotchargedweight");
    var hdntotnopkgs = document.getElementById("ctl00_MyCPH1_hdntotnopkgs");

    txtfreightrate.value = roundNumber(parseFloat(txtfreightrate.value), 2);

    var chkmultipickup = document.getElementById("ctl00_MyCPH1_chkmultipickup");
    if (chkmultipickup.checked == true) {
        txtfreightrate.value = "0.00";
        txtfreightcharge.value = "0.00";
    }

    var freight = 0.00;
    if (cmbratetype.value == "P") {
        freight = parseFloat(hdntotnopkgs.value) * parseFloat(txtfreightrate.value);
    }
    else if (cmbratetype.value == "W") {
        freight = parseFloat(txttotchargedweight.value) * parseFloat(txtfreightrate.value);
    }
    else if (cmbratetype.value == "T") {
        freight = parseFloat(txttotchargedweight.value) * parseFloat(txtfreightrate.value) / 1000;
    }
    else if (cmbratetype.value == "F")
        freight = parseFloat(txtfreightrate.value);

    txtfreightcharge.value = roundNumber(freight, 2);
    /************************************************************************************
        CALCULATING MINIMUM FREIGHT IN CASE OF MANUAL ENTRY
    *************************************************************************************/
    calculateMinimumFreight();

    var cmbpaybas = document.getElementById("ctl00_MyCPH1_cmbpaybas");
    if (parseFloat(txtfreightcharge.value) == 0 && cmbpaybas.value != "P04") {
        alert("Freight Can't be Zero. Please Re-Enter");
    }

    // calculate fuel surcharge
    calculateFuelSurCharge();

    //Calculating Subtotal
    calculateSubTotal();

    return false;
}

// THIS FUNCTION IS USED WHEN SERVICE TYPE GETS CHANGED
function serviceChange() {
    var cmbservicetype = document.getElementById("ctl00_MyCPH1_cmbservicetype");
    var cmbftltype = document.getElementById("ctl00_MyCPH1_cmbftltype");
    var trmultipoint = document.getElementById("ctl00_MyCPH1_trmultipoint");
    var hdnclient = document.getElementById("ctl00_MyCPH1_hdnclient");
    var hdnflagmultipickup = document.getElementById("ctl00_MyCPH1_hdnflagmultipickup");
    var cmbpaybas = document.getElementById("ctl00_MyCPH1_cmbpaybas");

    if (cmbservicetype.value == "1") {
        cmbftltype.disabled = true;
        cmbftltype.value = "0";
        trmultipoint.style.display = "none";
    }
    else if (cmbservicetype.value == "2") {
        cmbftltype.disabled = false;
        if (cmbpaybas.value == "P02") {
            if (hdnflagmultipickup.value == "Y")
                trmultipoint.style.display = "block";
        }
    }
}



function selectMPSource(dockno) {
    var txtsource = document.getElementById("ctl00_MyCPH1_txtsourcedockno");
    var divmpsources = document.getElementById("ctl00_MyCPH1_divmpsources");
    txtsource.value = dockno;
    divmpsources.style.display = "none";
    return false;
}

function openSources() {

    var divmpsources = document.getElementById("ctl00_MyCPH1_divmpsources");
    divmpsources.style.display = "block";
    return false;
}


function multiPickUpClick() {
    var chkmultipickup = document.getElementById("ctl00_MyCPH1_chkmultipickup");
    var chkmultidelivery = document.getElementById("ctl00_MyCPH1_chkmultidelivery");
    var txtsourcedockno = document.getElementById("ctl00_MyCPH1_txtsourcedockno");
    var imgsourcedock = document.getElementById("ctl00_MyCPH1_imgsourcedock");
    var lblsourcedockname = document.getElementById("ctl00_MyCPH1_lblsourcedockname");

    if (chkmultipickup.checked == true || chkmultidelivery.checked == true) {
        txtsourcedockno.style.display = "block";
        imgsourcedock.style.display = "block";
        lblsourcedockname.style.display = "block";
    }
    else {
        txtsourcedockno.style.display = "none";
        imgsourcedock.style.display = "none";
        lblsourcedockname.style.display = "none";
    }
    return true;
}

function calculateMinimumFreight() {
    var hdnminfreighttype = document.getElementById("ctl00_MyCPH1_hdnminfreighttype");

    if (hdnminfreighttype.value == "B") {
        if (!calculateMinBasFreight())
            return false;
    }
    else if (hdnminfreighttype.value == "%") {
        if (!calculateMinPercentFreight())
            return false;
    }
    else {
        return false;
    }

    return true;
}


function calculateMinBasFreight() {
    var hdnminfreightbas = document.getElementById("ctl00_MyCPH1_hdnminfreightbas");
    var hdnminfreightbasrate = document.getElementById("ctl00_MyCPH1_hdnminfreightbasrate");

    var txtfreightrate = document.getElementById("ctl00_MyCPH1_txtfreightrate");
    var txtfreightcharge = document.getElementById("ctl00_MyCPH1_txtfreightcharge");
    var cmbratetype = document.getElementById("ctl00_MyCPH1_cmbratetype");
    var txttotchargedweight = document.getElementById("ctl00_MyCPH1_txttotchargedweight");
    var hdntotnopkgs = document.getElementById("ctl00_MyCPH1_hdntotnopkgs");
    var hdndbfreightrate = document.getElementById("ctl00_MyCPH1_hdndbfreightrate");
    var lblminfreightalert = document.getElementById("ctl00_MyCPH1_lblminfreightalert");
    var minfreight = 0.00;

    if (hdnminfreightbas.value == "RS")
        minfreight = parseFloat(hdnminfreightbasrate.value);
    else if (hdnminfreightbas.value == "KG" || hdnminfreightbas.value == "PKG" || hdnminfreightbas.value == "T")
        minfreight = parseFloat(hdndbfreightrate.value) * parseFloat(hdnminfreightbasrate.value);

    if (parseFloat(txtfreightcharge.value) < minfreight) {
        if (hdnminfreightbas.value == "RS")
            lblminfreightalert.innerText = "Minimum Freight in RS applied.";
        else if (hdnminfreightbas.value == "KG" || hdnminfreightbas.value == "PKG" || hdnminfreightbas.value == "T")
            lblminfreightalert.innerText = "Minimum Freight in " + hdnminfreightbas.value + " applied.";

        txtfreightcharge.value = roundNumber(minfreight, 2);
        if (cmbratetype.value == "W")
            txtfreightrate.value = parseFloat(txtfreightcharge.value) / parseFloat(txttotchargedweight.value);
        else if (cmbratetype.value == "P")
            txtfreightrate.value = parseFloat(txtfreightcharge.value) / parseFloat(hdntotnopkgs.value);
        else if (cmbratetype.value == "T")
            txtfreightrate.value = parseFloat(txtfreightcharge.value) / parseFloat(txttotchargedweight.value) * 1000;
        else if (cmbratetype.value == "F")
            txtfreightrate.value = parseFloat(txtfreightcharge.value);
        else
            return false;
    }
    txtfreightrate.value = roundNumber(txtfreightrate.value, 2);
    txtfreightcharge.value = roundNumber(txtfreightcharge.value, 2);

    return true;
}


/****************************************************************************************************************
*   VALIDATE INVOICE DETAILS
****************************************************************************************************************/

function validateInvoiceDetails() {

    var chkvolumetric = document.getElementById("ctl00_MyCPH1_chkvolumetric");
    var grid = document.getElementById("ctl00_MyCPH1_grvinvoice");
    if (!grid) {
        alert("Problem in Invoice Entry");
        return false;
    }

    var rws = grid.rows.length;
    if (rws) {
        if (parseFloat(rws) < 3 || rws == "") {
            alert("Please FillUp Invoice Details.");
            return false;
        }
    }
    else {
        alert("Wrong with Invoice Details.FillUp Invoice Details..");
        return false;
    }

    var i = 2;
    var pref = "";
    for (i = 2; i < rws; i++) {
        if (i < 10)
            pref = "ctl00_MyCPH1_grvinvoice_ctl0" + i + "_";
        else
            pref = "ctl00_MyCPH1_grvinvoice_ctl" + i + "_";

        var txtinvoiceno = document.getElementById(pref + "txtinvoiceno");
        var txtinvoicedate = document.getElementById(pref + "txtinvoicedate");
        var txtdeclval = document.getElementById(pref + "txtdeclval");
        var txtnopkgs = document.getElementById(pref + "txtnopkgs");
        var txtactualweight = document.getElementById(pref + "txtactualweight");

        if (txtinvoiceno.value == "") {
            alert("Please Enter Invoice Number...");
            txtinvoiceno.focus();
            return false;
        }

        if (txtinvoicedate.value == "") {
            alert("Please Enter Invoice Date...");
            txtinvoicedate.focus();
            return false;
        }


        var hdnserverdate = document.getElementById("ctl00_MyCPH1_hdnserverdate");
        // date validation not future for all clients
        var months = new Array("", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
        var datediff = 0;

        var arrserverdate = hdnserverdate.value.split('/');
        var arrinvoicedate = txtinvoicedate.value.split('/');

        var dtserverdate = new Date(months[parseFloat(arrserverdate[1])] + " " + arrserverdate[0] + "," + arrserverdate[2]);
        var dtinvoicedate = new Date(months[parseFloat(arrinvoicedate[1])] + " " + arrinvoicedate[0] + "," + arrinvoicedate[2]);

        //if date2 > date1  then returns positive
        datediff = MyDateDiff(dtserverdate, dtinvoicedate, 'D', true);
        if (datediff > 0) {
            alert("Invoice Date can't be greater than Today's Date. Please Enter another Date.");
            txtinvoicedate.value = "";
            txtinvoicedate.focus();
            return false;
        }

        if (parseFloat(txtdeclval.value) == 0) {
            alert("Declared Value Can't Be Zero...");
            txtdeclval.focus();
            return false;
        }

        if (parseFloat(txtnopkgs.value) == 0) {
            alert("No of Packages Can't Be Zero...");
            txtnopkgs.focus();
            return false;
        }

        if (parseFloat(txtactualweight.value) == 0) {
            alert("Actual Weight Can't Be Zero...");
            txtactualweight.focus();
            return false;
        }


        // VOLUMETRIC VALIDATION
        if (chkvolumetric.checked == true) {
            var txtcubicrate = document.getElementById("ctl00_MyCPH1_txtcubicrate");
            var txttotcubic = document.getElementById("ctl00_MyCPH1_txttotcubic");

            if (parseFloat(txtcubicrate.value) < 8 || parseFloat(txtcubicrate.value) > 20 || txtcubicrate.value == "") {
                alert("Wrong Cubic Conversion Ratio. Please Re-Enter.");
                txtcubicrate.focus();
                return false;
            }

            if (parseFloat(txttotcubic.value) == 0 || txttotcubic.value == "") {
                alert("Wrong Cubic Conversion. Please Check Cubic Ratio/Length/Breadth/Height. Total Cubic Must Not be Zero....");
                txtcubicrate.focus();
                return false;
            }


            var txtlength = document.getElementById(pref + "txtlength");
            var txtbreadth = document.getElementById(pref + "txtbreadth");
            var txtheight = document.getElementById(pref + "txtheight");

            if (parseFloat(txtlength.value) == 0 || txtlength.value == "") {
                alert("Please Enter Length Properly....");
                txtlength.focus();
                return false;
            }

            if (parseFloat(txtbreadth.value) == 0 || txtbreadth.value == "") {
                alert("Please Enter Breadth Properly....");
                txtbreadth.focus();
                return false;
            }

            if (parseFloat(txtheight.value) == 0 || txtheight.value == "") {
                alert("Please Enter Height Properly....");
                txtheight.focus();
                return false;
            }

        } // Volumetric validation



    } // Invoice forloop ENDS HERE


    var txttotchargedweight = document.getElementById("ctl00_MyCPH1_txttotchargedweight")
    var hdntotnopkgs = document.getElementById("ctl00_MyCPH1_hdntotnopkgs")
    var hdntotdeclval = document.getElementById("ctl00_MyCPH1_hdntotdeclval")

    if (parseFloat(txttotchargedweight.value) == 0 || txttotchargedweight.value == "") {
        alert("Total Charged Weight Must Not be Zero");
        txttotchargedweight.focus();
        return false;
    }

    if (parseFloat(hdntotnopkgs.value) == 0 || hdntotnopkgs.value == "") {
        alert("Total Number of Packages Must Not be Zero. Programming Error....");
        return false;
    }

    if (parseFloat(hdntotdeclval.value) == 0 || hdntotdeclval.value == "") {
        alert("Total Declared Value Must Not be Zero. Programming Error....");
        return false;
    }
    return true;
}

/****************************************************************************************************************/


/****************************************************************************************************************
    CHARGED WEIGHT IS ALWAYS MORE THAN ACTUAL WEIGHT
****************************************************************************************************************/
function chargedWeightTest() {
    var grid = document.getElementById("ctl00_MyCPH1_grvinvoice");
    if (!grid)
        return false;

    var rws = grid.rows.length;
    var txtactualweight;
    if (rws < 10)
        txtactualweight = document.getElementById("ctl00_MyCPH1_grvinvoice_ctl0" + rws + "_txttotactualweight");
    else
        txtactualweight = document.getElementById("ctl00_MyCPH1_grvinvoice_ctl" + rws + "_txttotactualweight");
    var txtchargedweight = document.getElementById("ctl00_MyCPH1_txttotchargedweight");
    if (parseFloat(txtchargedweight.value) < parseFloat(txtactualweight.value)) {
        alert("Charged Weight Must Not Less than Actual Weight...");
        txtchargedweight.select();
        return false;
    }
}
/****************************************************************************************************************/



/****************************************************************************************************************
    IS INVOICE NUMBER IS VALID OR NOT
****************************************************************************************************************/
function validateInvoiceNo(id) {
    var txt = document.getElementById(id);
    txt.value = txt.value.toUpperCase();

    if (txt.value == "")
        return false;

    var grid = document.getElementById("ctl00_MyCPH1_grvinvoice");
    var rows = grid.rows.length;

    var pref = "";
    for (var i = 2; i < rows; i++) {
        if (i < 10)
            pref = "ctl00_MyCPH1_grvinvoice_ctl0" + i + "_";
        else
            pref = "ctl00_MyCPH1_grvinvoice_ctl" + i + "_";

        var txtid = pref + "txtinvoiceno";
        if (txtid != id) {
            var txtgrid = document.getElementById(txtid);
            if (txt.value == txtgrid.value) {
                alert("Please Remove Duplicate Invoice Number......");
                txt.select();
                return false;
            }
        }
    }

    return true;
}
/****************************************************************************************************************/




/*****************************************************************************************************************
    THIS FUCNTION IS USED TO TEST VALID DOCKET NUMBER
*****************************************************************************************************************/
function dockNoTest(txtid) {

    var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");
    hdnajaxstate.value = "1";


    var imgdockettick = document.getElementById("ctl00_MyCPH1_imgdockettick");
    var txt = document.getElementById(txtid);
    if (txt.value == "") {
        hdnajaxstate.value = "0";
        imgdockettick.style.display = "none";
        return false;
    }

    txt.value = txt.value.toUpperCase();

    var findobj = false;
    findobj = GetXMLHttpObject();
    if (findobj) {
        var strpg = "AjaxResponse.aspx?mode=check&code1=docknotest&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();
        findobj.open("GET", strpg);
        findobj.onreadystatechange = function () {
            if ((findobj.readyState == 4) && (findobj.status == 200)) {
                var res = findobj.responseText.split("|");
                if (res[0] == "false") {
                    alert(res[1]);
                    txt.value = "";
                    txt.focus();
                    hdnajaxstate.value = "0";
                    imgdockettick.style.display = "none";
                    return false;
                }
                else if (res[0] == "true") {
                    hdnajaxstate.value = "0";
                    imgdockettick.style.display = "block";
                }
            }
        }

        findobj.send(null);
    }

    return true;
}
/****************************************************************************************************************/



/*****************************************************************************************************************
    THIS FUCNTION IS USED TO TEST VALID DOCKET NUMBER
*****************************************************************************************************************/
function sourceDockNoTest(txtid) {
    var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");
    hdnajaxstate.value = "1";

    var txtdockdt = document.getElementById("ctl00_MyCPH1_txtdockdate");
    var imgsourcedock = document.getElementById("ctl00_MyCPH1_imgsourcedock");
    var txt = document.getElementById(txtid);

    if (txt.value == "") {
        hdnajaxstate.value = "0";
        return false;
    }

    txt.value = txt.value.toUpperCase();

    var findobj = false;
    findobj = GetXMLHttpObject();
    if (findobj) {
        var strpg = "AjaxResponse.aspx?mode=check&code1=sourcedocknotest&code2=" + txt.value + "&code3=" + txtdockdt.value + "&sid=" + Math.random() + "&sid=" + Math.random();
        findobj.open("GET", strpg);
        findobj.onreadystatechange = function () {
            if ((findobj.readyState == 4) && (findobj.status == 200)) {
                var res = findobj.responseText.split("|");
                if (res[0] == "false") {
                    alert(res[1]);
                    txt.value = "";
                    txt.focus();
                    hdnajaxstate.value = "0";
                    return false;
                }
                else if (res[0] == "true") {
                    hdnajaxstate.value = "0";
                    imgsourcedock.style.display = "block";
                }
            }
        }

        findobj.send(null);
    }

    return true;
}
/****************************************************************************************************************/




/*****************************************************************************************************************
    THIS FUCNTION IS USED TO TEST VALID CITY
*****************************************************************************************************************/
function cityTest(tp, txtid) {
    var hdnIsEdit = document.getElementById("ctl00_MyCPH1_hdnIsEdit");

    var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");
    hdnajaxstate.value = "1";


    var txt = document.getElementById(txtid);
    if (txt.value == "") {
        hdnajaxstate.value = "0";
        return false;
    }

    txt.value = txt.value.toUpperCase();

    var relatedloc = "";
    if (tp == "from")
        relatedloc = document.getElementById("ctl00_MyCPH1_txtdelloc").value;
    else
        relatedloc = document.getElementById("ctl00_MyCPH1_lblorgnloc").innerText;


    var findobj = false;
    findobj = GetXMLHttpObject();
    if (findobj) {
        var strpg = "AjaxResponse.aspx?mode=check&code1=citytest&code2=" + txt.value + "&code3=" + tp + "&code4=" + relatedloc + "&sid=" + Math.random() + "&sid=" + Math.random();
        findobj.open("GET", strpg);
        findobj.onreadystatechange = function () {
            if ((findobj.readyState == 4) && (findobj.status == 200)) {
                var res = findobj.responseText.split("|");
                if (res[0] == "false") {
                    var hdnclient = document.getElementById("ctl00_MyCPH1_hdnclient");
                    if (hdnclient.value != "UFL") {
                        alert("This City doesn't Exists ");
                        txt.value = "";
                        txt.focus();
                    }
                    else {
                        if (!confirm("This City doesn't Exists... Are you want to continue ??"))
                        { txt.value = ""; txt.focus(); return false; }
                    }
                    hdnajaxstate.value = "0";
                    return false;
                }
                else if (res[0] == "true") {
                    hdnajaxstate.value = "0";
                    if (tp == "to") {
                        if (hdnIsEdit == null)
                            document.getElementById("ctl00_MyCPH1_txtdelloc").value = res[1];
                    }
                }
            }
        }

        findobj.send(null);
    }

    return true;
}
/****************************************************************************************************************/




/*****************************************************************************************************************
    THIS FUCNTION IS USED TO TEST VALID BRANCH CODE OR LOCATION CODE
*****************************************************************************************************************/
function locTest(txtid, tp) {

    var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");
    hdnajaxstate.value = "1";

    var hdnclient = document.getElementById("ctl00_MyCPH1_hdnclient");

    var txt = document.getElementById(txtid);
    if (txt.value == "") {
        hdnajaxstate.value = "0";
        return false;
    }

    txt.value = txt.value.toUpperCase();

    var findobj = false;
    findobj = GetXMLHttpObject();
    if (findobj) {
        if (tp == "delloc")
            var strpg = "AjaxResponse.aspx?mode=check&code1=delloc&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();
        else
            var strpg = "AjaxResponse.aspx?mode=check&code1=loctest&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();
        findobj.open("GET", strpg);
        findobj.onreadystatechange = function () {
            if ((findobj.readyState == 4) && (findobj.status == 200)) {
                var res = findobj.responseText.split("|");

                if (res[0] == "false") {
                    if (tp == "delloc") {
                        if (hdnclient.value == "RLL") {
                            alert("This Location doesn't Exists or Regional Office or HeadOffice.");
                        }
                        else
                            alert("This Location doesn't Exists ");
                    }
                    else
                        alert("This Location doesn't Exists ");
                    txt.value = "";
                    txt.focus();
                    hdnajaxstate.value = "0";
                    return false;
                }
                else if (res[0] == "true") {
                    hdnajaxstate.value = "0";
                }


            }
        }

        findobj.send(null);
    }

    return true;
}
/****************************************************************************************************************/




/*****************************************************************************************************************
    THIS FUCNTION IS USED TO TEST VALID PARTY CODE 
*****************************************************************************************************************/
function partyTest(tp, txtid) {
    var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");
    hdnajaxstate.value = "1";

    var lblorgnloc = document.getElementById("ctl00_MyCPH1_lblorgnloc");
    var txtdelloc = document.getElementById("ctl00_MyCPH1_txtdelloc");

    var txt = document.getElementById(txtid);
    txt.value = txt.value.toUpperCase();

    var txtname;
    var locname = "";
    if (tp == "party") {
        txtname = document.getElementById("ctl00_MyCPH1_txtpartyname");
        locname = lblorgnloc.innerText;
    }
    else if (tp == "csgn") {
        txtname = document.getElementById("ctl00_MyCPH1_txtcsgnnm");
        locname = lblorgnloc.innerText;
    }
    else if (tp == "csge") {
        txtname = document.getElementById("ctl00_MyCPH1_txtcsgenm");
        locname = txtdelloc.value;
    }
    else if (tp == "partycsgn") {
        txtname = document.getElementById("ctl00_MyCPH1_txtpartyname");
        locname = lblorgnloc.innerText;
    }
    else if (tp == "partycsge") {
        txtname = document.getElementById("ctl00_MyCPH1_txtpartyname");
        locname = txtdelloc.value;
    }


    if (txt.value == "") {
        hdnajaxstate.value = "0";
        txtname.value = "";
        return false;
    }


    var findobj = false;
    findobj = GetXMLHttpObject();
    if (findobj) {
        var strpg = "AjaxResponse.aspx?mode=check&code1=partytest&code2=" + txt.value + "&code3=" + tp + "&code4=" + locname + "&sid=" + Math.random() + "&sid=" + Math.random();
        findobj.open("GET", strpg);
        findobj.onreadystatechange = function () {
            if ((findobj.readyState == 4) && (findobj.status == 200)) {
                var res = findobj.responseText.split("|");

                if (res[0] == "false") {
                    alert("This Party doesn't Exists OR deactivated OR not For Location " + locname);
                    txt.value = "";
                    txtname.value = "";
                    txt.focus();
                    hdnajaxstate.value = "0";
                    return false;
                }
                else if (res[0] == "true") {
                    txtname.value = res[1];
                    hdnajaxstate.value = "0";  // BECAUSE AJAX STEP IS OVER
                }

            }
        }

        findobj.send(null);
    }

    return true;
}
/****************************************************************************************************************/




/*****************************************************************************************************************
    EMAIL VALIDATION FUNCTION
*****************************************************************************************************************/
function emailCheck(id) {

    var txt = document.getElementById(id);

    if (txt.value == "")
        return false;

    var str = txt.value;

    var at = "@"
    var dot = "."
    var lat = str.indexOf(at)
    var lstr = str.length
    var ldot = str.indexOf(dot)
    if (str.indexOf(at) == -1) {
        alert("Invalid E-mail ID");
        txt.select();
        return false
    }

    if (str.indexOf(at) == -1 || str.indexOf(at) == 0 || str.indexOf(at) == lstr) {
        alert("Invalid E-mail ID");
        txt.select();
        return false
    }

    if (str.indexOf(dot) == -1 || str.indexOf(dot) == 0 || str.indexOf(dot) == lstr) {
        alert("Invalid E-mail ID");
        txt.select();
        return false
    }

    if (str.indexOf(at, (lat + 1)) != -1) {
        alert("Invalid E-mail ID");
        txt.select();
        return false
    }

    if (str.substring(lat - 1, lat) == dot || str.substring(lat + 1, lat + 2) == dot) {
        alert("Invalid E-mail ID");
        txt.select();
        return false
    }

    if (str.indexOf(dot, (lat + 2)) == -1) {
        alert("Invalid E-mail ID");
        txt.select();
        return false
    }

    if (str.indexOf(" ") != -1) {
        alert("Invalid E-mail ID");
        txt.select();
        return false
    }
    return true
}
/****************************************************************************************************************/





/*****************************************************************************************************************
    THIS FUCNTION IS USED TO RETRIEVE HTTP OBJECT
        return type XMLHttpObject
*****************************************************************************************************************/
function GetXMLHttpObject() {
    var xmlHttp;
    try {
        xmlHttp = new XMLHttpRequest();    // Firefox, Opera 8.0+, Safari    
    }
    catch (e) {
        // Internet Explorer    
        try {
            xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
        }
        catch (e) {
            try
            { xmlHttp = new ActiveXObject("Microsoft.XMLHTTP"); }
            catch (e) {
                alert("Your browser does not support AJAX!");
                return false;
            }
        }
    }
    return xmlHttp;
}
/****************************************************************************************************************/




/*****************************************************************************************************************
    MANUAL ENTRY FOR SERVICE TAX TO SHOW ROUND OFF
*****************************************************************************************************************/
function serviceTaxBlur() {
    var txtservicetax = document.getElementById("ctl00_MyCPH1_txtservicetax");
    var txteducess = document.getElementById("ctl00_MyCPH1_txteducess");
    var txtheducess = document.getElementById("ctl00_MyCPH1_txtheducess");
    var txtsubtotal = document.getElementById("ctl00_MyCPH1_txtsubtotal");
    var txtdockettotal = document.getElementById("ctl00_MyCPH1_txtdockettotal");
    var txtDiscount = document.getElementById("ctl00_MyCPH1_txtDiscount");

    txtservicetax.value = roundNumber(txtservicetax.value, 2);
    txteducess.value = roundNumber(txteducess.value, 2);
    txtheducess.value = roundNumber(txtheducess.value, 2);
    var dockettotal = 0.00;
    dockettotal = parseFloat(txtsubtotal.value) + parseFloat(txtservicetax.value) + parseFloat(txteducess.value) + parseFloat(txtheducess.value);

    txtdockettotal.value = roundNumber(dockettotal, 2);

    return false;
}
/*****************************************************************************************************************

		
		
		
/*****************************************************************************************************************
    INVOICE DETAILD CALCULATIONS
*****************************************************************************************************************/
function invoiceCalculation() {
    var grid = document.getElementById("ctl00_MyCPH1_grvinvoice");
    if (!grid)
        return false;

    var rows = grid.rows.length;

    var totdeclval = 0;
    var totnopkgs = 0;
    var totactweight = 0;


    var tottotweight = 0;

    var pref = "";

    var chkvol = document.getElementById("ctl00_MyCPH1_chkvolumetric");

    if (chkvol.checked == false) {
        for (var i = 2; i < rows; i++) {
            if (i < 10)
                pref = "ctl00_MyCPH1_grvinvoice_ctl0" + i + "_";
            else
                pref = "ctl00_MyCPH1_grvinvoice_ctl" + i + "_";

            var txtdeclval = document.getElementById(pref + "txtdeclval");
            var txtnopkgs = document.getElementById(pref + "txtnopkgs");
            var txtactweight = document.getElementById(pref + "txtactualweight");

            if (txtdeclval.value == "")
                txtdeclval.value = "0";

            if (txtactweight.value == "")
                txtactweight.value = "0";

            if (txtnopkgs.value == "")
                txtnopkgs.value = "0";

            totdeclval = totdeclval + parseInt(txtdeclval.value);
            totnopkgs = totnopkgs + parseInt(txtnopkgs.value);
            totactweight = totactweight + parseInt(txtactweight.value);
        }

        if (i < 10)
            pref = "ctl00_MyCPH1_grvinvoice_ctl0" + parseInt(i) + "_";
        else
            pref = "ctl00_MyCPH1_grvinvoice_ctl" + parseInt(i) + "_";

        document.getElementById(pref + "txttotdeclval").value = Math.round(totdeclval);
        document.getElementById(pref + "txttotnopkgs").value = Math.round(totnopkgs);
        document.getElementById(pref + "txttotactualweight").value = Math.round(totactweight);

        document.getElementById("ctl00_MyCPH1_txttotchargedweight").value = Math.round(totactweight);
        document.getElementById("ctl00_MyCPH1_hdntotactualweight").value = Math.round(totactweight);
        document.getElementById("ctl00_MyCPH1_hdntotnopkgs").value = Math.round(totnopkgs);
        document.getElementById("ctl00_MyCPH1_hdntotdeclval").value = Math.round(totdeclval);
    }// chkvol.checked==false ENDS HERE
    else {
        var len = 0.00;
        var breadth = 0.00;
        var height = 0.00;
        var volume = 0.00;
        var totalvolume = 0.00;

        var hdnvolmeasuretype = document.getElementById("ctl00_MyCPH1_hdnvolmeasuretype");
        var txtcubicrate = document.getElementById("ctl00_MyCPH1_txtcubicrate");
        var txttotcubic = document.getElementById("ctl00_MyCPH1_txttotcubic");

        if (parseInt(txtcubicrate.value) < 8 || parseInt(txtcubicrate.value) < 8 || txtcubicrate.value == "") {
            alert("Cubic -> KG  Conversion Ration must Between 8 - 20.");
            txtcubicrate.focus();
            return false;
        }

        for (var i = 2; i < rows; i++) {
            if (i < 10)
                pref = "ctl00_MyCPH1_grvinvoice_ctl0" + i + "_";
            else
                pref = "ctl00_MyCPH1_grvinvoice_ctl" + i + "_";

            var txtlength = document.getElementById(pref + "txtlength");
            var txtbreadth = document.getElementById(pref + "txtbreadth");
            var txtheight = document.getElementById(pref + "txtheight");

            var txtdeclval = document.getElementById(pref + "txtdeclval");
            var txtnopkgs = document.getElementById(pref + "txtnopkgs");
            var txtcft = document.getElementById(pref + "txtcft");
            var txtactweight = document.getElementById(pref + "txtactualweight");

            if (txtdeclval.value == "")
                txtdeclval.value = "0";

            if (txtactweight.value == "")
                txtactweight.value = "0";

            if (txtnopkgs.value == "")
                txtnopkgs.value = "0";

            len = parseInt(txtlength.value);
            breadth = parseInt(txtbreadth.value);
            height = parseInt(txtheight.value);

            if (hdnvolmeasuretype.value == "INCHES")
                volume = len * breadth * height * parseFloat(txtcubicrate.value) / 1728;
            else if (hdnvolmeasuretype.value == "CM")
                volume = len * breadth * height * parseFloat(txtcubicrate.value) / 27000;
            else
                volume = len * breadth * height * parseFloat(txtcubicrate.value) / 1728;   // if not proper value then INCHES is applied

            // Total CFT is volume of one packes * no of packages
            volume = volume * parseFloat(txtnopkgs.value);

            txtcft.value = Math.round(volume);

            totalvolume = totalvolume + Math.round(volume);
            txttotcubic.value = Math.round(totalvolume);

            totdeclval = totdeclval + parseInt(txtdeclval.value);
            totnopkgs = totnopkgs + parseInt(txtnopkgs.value);
            totactweight = totactweight + parseInt(txtactweight.value);

        } // invoice forloop ENDS HERE


        if (i < 10)
            pref = "ctl00_MyCPH1_grvinvoice_ctl0" + parseInt(i) + "_";
        else
            pref = "ctl00_MyCPH1_grvinvoice_ctl" + parseInt(i) + "_";

        document.getElementById(pref + "txttotdeclval").value = Math.round(totdeclval);
        document.getElementById(pref + "txttotnopkgs").value = Math.round(totnopkgs);
        document.getElementById(pref + "txttotalcft").value = totalvolume;
        document.getElementById(pref + "txttotactualweight").value = Math.round(totactweight);

        if (totalvolume < totactweight) {
            document.getElementById("ctl00_MyCPH1_txttotchargedweight").value = Math.round(totactweight);
            document.getElementById("ctl00_MyCPH1_hdntotactualweight").value = Math.round(totactweight);
        }
        else {
            document.getElementById("ctl00_MyCPH1_txttotchargedweight").value = totalvolume;
            document.getElementById("ctl00_MyCPH1_hdntotactualweight").value = totalvolume;
        }

        document.getElementById("ctl00_MyCPH1_hdntotnopkgs").value = Math.round(totnopkgs);
        document.getElementById("ctl00_MyCPH1_hdntotdeclval").value = Math.round(totdeclval);
    }
}

/*****************************************************************************************************************/



/*****************************************************************************************************************
    ENABLING ALL FIELDS AT LAST
*****************************************************************************************************************/
function enableAllFins() {

    var txtfreightcharge = document.getElementById("ctl00_MyCPH1_txtfreightcharge");
    var txtfreightrate = document.getElementById("ctl00_MyCPH1_txtfreightrate");
    var txtfovcharged = document.getElementById("ctl00_MyCPH1_txtfovcharged");
    /* KK Cess */
    //var txtsubtotal = document.getElementById("ctl00_MyCPH1_txtsubtotal");
    //var txtservicetax = document.getElementById("ctl00_MyCPH1_txtservicetax");
    //var txteducess = document.getElementById("ctl00_MyCPH1_txteducess");
    //var txtheducess = document.getElementById("ctl00_MyCPH1_txtheducess");
    //var txtdockettotal = document.getElementById("ctl00_MyCPH1_txtdockettotal");
    /* KK Cess */
    var btnsubmit = document.getElementById("ctl00_MyCPH1_btnsubmit");

    btnsubmit.disabled = false;
    txtfreightcharge.disabled = false;
    txtfreightrate.disabled = false;
    txtfovcharged.disabled = false;
    /* KK Cess */
    //txtsubtotal.disabled = false;
    //txtservicetax.disabled = false;
    //txteducess.disabled = false;
    //txtheducess.disabled = false;
    //txtdockettotal.disabled = false;
    /* KK Cess */
    return true;
}

/*****************************************************************************************************************/






/*****************************************************************************************************************
   INNER FUNCTION TO ROPUND UPTO DEFINED DECIMAL PLACES, RETURNS STRING
*****************************************************************************************************************/
function roundNumber(num, dec) {

    if (num == "." || num == ".0" || num == "0" || num == "0." || num == "" || !num)
        return "0.00";

    var result = Math.round(num * Math.pow(10, dec)) / Math.pow(10, dec);

    var len = 0;
    var number = result.toString();
    len = number.length;

    if (number == "." || number == ".0" || number == "0" || number == "0." || num == "" || !num)
        return "0.00";

    if (number.indexOf('.') == parseInt(len - 2) && len >= 2) {
        number = number + "0";
    }
    else if (number.indexOf('.') == parseInt(len - 1)) {
        number = number + "00";
    }
    else if (number.indexOf('.') == -1) {
        number = number + ".00";
    }

    return number;
}
/*****************************************************************************************************************/





/*****************************************************************************************************************
    POPUP FUNCTIONS FOR DIFFERENT PURPOSES
*****************************************************************************************************************/
function popupConsignor() {
    var lblorgnloc = document.getElementById("ctl00_MyCPH1_lblorgnloc");
    window.open("DataPopUp.aspx?poptp=csgn&code1=ctl00_MyCPH1_txtcsgncd&code2=ctl00_MyCPH1_txtcsgnnm&code3=" + lblorgnloc.innerText, null, "height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15");
}

function popupConsignee() {
    var txtdelloc = document.getElementById("ctl00_MyCPH1_txtdelloc");
    window.open("DataPopUp.aspx?poptp=csge&code1=ctl00_MyCPH1_txtcsgecd&code2=ctl00_MyCPH1_txtcsgenm&code3=" + txtdelloc.value, null, "height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15");
}

function popupParty() {
    var lblorgnloc = document.getElementById("ctl00_MyCPH1_lblorgnloc");
    window.open("DataPopUp.aspx?poptp=party&code1=ctl00_MyCPH1_txtpartycode&code2=ctl00_MyCPH1_txtpartyname&code3=" + lblorgnloc.innerText, null, "height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15");
}

function popupDelLoc() {
    window.open("DataPopUp.aspx?poptp=delloc&code1=ctl00_MyCPH1_txtdelloc&code2=", null, "height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15");
}

function popupBillLoc() {
    window.open("DataPopUp.aspx?poptp=billloc&code1=ctl00_MyCPH1_txtbilledat&code2=", null, "height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15");
}

function popupFromCity() {
    var lblorgnloc = document.getElementById("ctl00_MyCPH1_lblorgnloc");
    window.open("DataPopUp.aspx?poptp=fromcity&code1=ctl00_MyCPH1_txtfromcity&code2=" + lblorgnloc.innerText, null, "height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15");
}

function popupToCity() {
    var txtdelloc = document.getElementById("ctl00_MyCPH1_txtdelloc");
    window.open("DataPopUp.aspx?poptp=tocity&code1=ctl00_MyCPH1_txttocity&code2=" + txtdelloc.value, null, "height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15");
}

function popupCSGNCity() {
    window.open("DataPopUp.aspx?poptp=csgncity&code1=ctl00_MyCPH1_txtcsgncity&code2=", null, "height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15");
}

function popupCSGECity() {
    window.open("DataPopUp.aspx?poptp=csgecity&code1=ctl00_MyCPH1_txtcsgecity&code2=", null, "height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15");
}

/*****************************************************************************************************************/
function showOtherProduct() {
    var Prefix = "ctl00_MyCPH1_";
    var cmbprodtype = document.getElementById(Prefix + 'cmbprodtype');
    var txtProdType = document.getElementById(Prefix + 'txtProdType');

    if (cmbprodtype.options[cmbprodtype.selectedIndex].text.toUpperCase() == "OTHERS") {
        txtProdType.style.display = "block";
        //txtProdType.value = "";
    }
    else {
        txtProdType.style.display = "none";
        txtProdType.value = cmbprodtype.value;
    }
    try {
        DisableStep1()
    } catch (e) { }
    return false;
}