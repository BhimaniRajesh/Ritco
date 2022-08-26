<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="DeliveryMR_Test.aspx.cs" Inherits="GUI_Operation_DeliveryMR_DeliveryMR"
    Title="Untitled Page" %>

<%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagName="ProgressBar"
    TagPrefix="pgb" %>
<%@ Register Src="~/GUI/Common_UserControls/WebxComplete/XAC.ascx" TagPrefix="xac"
    TagName="WebxComplete" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script src="../../images/commonJs.js" type="text/javascript" language="javascript"></script>

    <script src="../../images/CalendarPopup.js" type="text/javascript" language="javascript"></script>

    <script type="text/javascript" language="javascript">

        function chkPartyType() {
            var optpartytype = document.getElementById("ctl00_MyCPH1_optpartytype_0");
            var trcneewc = document.getElementById("ctl00_MyCPH1_trcneewc");
            var trpartyc = document.getElementById("ctl00_MyCPH1_trpartyc");
            var trpartyw = document.getElementById("ctl00_MyCPH1_trpartyw");

            if (optpartytype.checked == true) {
                trcneewc.style.display = "none";
                trpartyc.style.display = "none";
                trpartyw.style.display = "none";
            }
            else {
                var optpartyc = document.getElementById("ctl00_MyCPH1_optpartyc");
                trcneewc.style.display = "block";
                if (optpartyc.checked == true) {
                    trpartyc.style.display = "block";
                    trpartyw.style.display = "none";
                }
                else {
                    trpartyc.style.display = "none";
                    trpartyw.style.display = "block";
                }

            }

        }

        function delSubTotalChange() {
            var gridbkg = document.getElementById("ctl00_MyCPH1_grvcharges");
            var len = gridbkg.rows.length;

            var strbkg = "ctl00_MyCPH1_grvcharges_ctl" + len + "_";

            var txtdelsubtotal = document.getElementById(strbkg + "txtdelsubtotal");
            var lblbkgsubtotal = document.getElementById(strbkg + "lblbkgsubtotal");
            var txtdiffsubtotal = document.getElementById(strbkg + "txtdiffsubtotal");

            if (isNaN(txtdelsubtotal.value))
                txtdelsubtotal.value = "0.00";

            if (isNaN(lblbkgsubtotal.innerText))
                lblbkgsubtotal.innerText = "0.00";

            var rebate = 0.00;
            rebate = parseFloat(txtdelsubtotal.value) - parseFloat(lblbkgsubtotal.innerText);
            txtdiffsubtotal.value = roundNumber(rebate, 2);

            var txtfreightdiff = document.getElementById("ctl00_MyCPH1_grvdelcharges_ctl02_txtdelcharge");
            var hdnflagroundoff = document.getElementById("ctl00_MyCPH1_hdnflagroundoff");

            if (hdnflagroundoff.value == "Y")
                txtfreightdiff.value = Math.round(rebate);

            txtfreightdiff.value = roundNumber(rebate, 2);

            calculateTotal();
            return false;
        }

        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
        // ON BLUR OF FREIGHT  CHARGE
        function step2Click() {
            var txtpartycode = document.getElementById("ctl00_MyCPH1_txtpartycode");
            var txtmrdate = document.getElementById("ctl00_MyCPH1_txtmrdate");
            var txtdockdate = document.getElementById("ctl00_MyCPH1_txtdockdate");
            var hdnserverdate = document.getElementById("ctl00_MyCPH1_hdnserverdate");
            var hdnfinstartyear = document.getElementById("ctl00_MyCPH1_hdnfinstartyear");
            var optpartyc = document.getElementById("ctl00_MyCPH1_optpartyc");
            var optpartyw = document.getElementById("ctl00_MyCPH1_optpartyw");
            var hdnpaybas = document.getElementById("ctl00_MyCPH1_hdnpaybas");

            var months = new Array("", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
            var arrserverdate = hdnserverdate.value.split('/');
            var arrmrdate = txtmrdate.value.split('/');
            var arrdockdate = txtmrdate.value.split('/');
            var dtfinyear = new Date("April 01, 2009");
            var dtserverdate = new Date(months[parseFloat(arrserverdate[1])] + " " + arrserverdate[0] + "," + arrserverdate[2]);
            var dtmrdate = new Date(months[parseFloat(arrmrdate[1])] + " " + arrmrdate[0] + "," + arrmrdate[2]);
            var dtdockdate = new Date(months[parseFloat(arrdockdate[1])] + " " + arrdockdate[0] + "," + arrdockdate[2]);

            if (dtmrdate > dtserverdate) {
                alert("Please MR Less than Today's Date");
                txtmrdate.value = "";
                txtmrdate.focus();
                return false;
            }

            if (dtmrdate < dtfinyear) {
                alert("Please Enter MR in Current Financial Year");
                txtmrdate.value = "";
                txtmrdate.focus();
                return false;
            }

            var dkt_call = document.getElementById("ctl00_MyCPH1_hdndockname").value;
            if (dtmrdate < dtdockdate) {
                alert("Please Enter MR Date more than " + dkt_call + " Date");
                txtmrdate.value = "";
                txtmrdate.focus();
                return false;
            }

            if (optpartyc.checked == true) {
                if (txtpartycode.value == "") {
                    alert("Please Enter Consignee Code...");
                    txtpartycode.focus();
                    return false;
                }
            }
            else {
                var txtpartyw = document.getElementById("ctl00_MyCPH1_txtpartyw");
                if (txtpartyw.value == "") {
                    alert("Please Enter Walk-In Consignee Name");
                    return false;
                }
            }


            var hdnpaybas = document.getElementById("ctl00_MyCPH1_hdnpaybas");
            var txtpartycode = document.getElementById("ctl00_MyCPH1_txtpartycode");
            var hdncsgecd = document.getElementById("ctl00_MyCPH1_hdncsgecd");
            var hdnclient = document.getElementById("ctl00_MyCPH1_hdnclient");

            var alertstring = "";
            var c = 0;
            if (hdncsgecd.value != txtpartycode.value) {
                if (c > 0)
                    alertstring = alertstring + ", ";
                alertstring = alertstring + "Party Code";
                c++;
            }

            if (alertstring != "") {
                alertstring = alertstring + "  has been Changed. New Contract will be Invoked. Are you want to Continue ??";
                if (!confirm(alertstring))
                    return false;
            }


            return true;
        }

        function freightRateBlur(id) {
            var hdnratetype = document.getElementById("ctl00_MyCPH1_hdnratetype");
            var txtchargedweight = document.getElementById("ctl00_MyCPH1_grvcharges_ctl02_txtdelcharge");
            var txtfreightrate = document.getElementById("ctl00_MyCPH1_grvcharges_ctl03_txtdelcharge");
            var txtfreightcharge = document.getElementById("ctl00_MyCPH1_grvcharges_ctl04_txtdelcharge");

            txtfreightrate.value = roundNumber(txtfreightrate.value, 2);
            var freightcharge = 0.00;
            if (hdnratetype.value == "W")
                freightcharge = parseFloat(txtfreightrate.value) * parseFloat(txtchargedweight.value);
            else if (hdnratetype.value == "P")
                freightcharge = parseFloat(txtfreightrate.value) * parseFloat(hdnpkgsno.value);
            else if (hdnratetype.value == "T")
                freightcharge = parseFloat(txtfreightrate.value) * parseFloat(txtchargedweight.value) / 1000;
            else if (hdnratetype.value == "F")
                freightcharge = parseFloat(txtfreightrate.value);


            txtfreightcharge.value = roundNumber(freightcharge, 2);

            bkgChargeChange(id);

            calculateTotal();

            return false;
        }

        function popupConsignor() {
            var hdnorgnloc = document.getElementById("ctl00_MyCPH1_hdnorgnloc");
            window.open("DataPopUp.aspx?poptp=csgn&code1=ctl00_MyCPH1_txtcsgncd&code2=ctl00_MyCPH1_txtcsgnnm&code3=" + hdnorgnloc.value, null, "height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15");
        }

        function popupConsignee() {
            var hdndelloc = document.getElementById("ctl00_MyCPH1_hdndelloc");
            window.open("DataPopUp.aspx?poptp=csge&code1=ctl00_MyCPH1_txtcsgecd&code2=ctl00_MyCPH1_txtcsgenm&code3=" + hdndelloc.value, null, "height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15");
        }

        function popupPartyCSGE() {
            var hdndelloc = document.getElementById("ctl00_MyCPH1_hdndelloc");
            window.open("DataPopUp.aspx?poptp=party&code1=ctl00_MyCPH1_txtpartycode&code2=ctl00_MyCPH1_txtpartyname&code3=" + hdndelloc.value, null, "height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15");
        }

        function popupReceiver() {
            window.open("DataPopUp.aspx?poptp=receiver&code1=ctl00_MyCPH1_txtreceivercode&code2=ctl00_MyCPH1_txtreceivername", null, "height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15");
            return false;
        }


        function chkPartPaymentClick() {
            var optpartyc = document.getElementById("ctl00_MyCPH1_optpartyc");
            var optpartyw = document.getElementById("ctl00_MyCPH1_optpartyw");
            var chkpartpayment = document.getElementById("ctl00_MyCPH1_chkpartpayment");
            var optpartytype = document.getElementById("ctl00_MyCPH1_optpartytype_0");
            var trcneewc = document.getElementById("ctl00_MyCPH1_trcneewc");

            if (chkpartpayment.checked == true) {
                if (optpartytype.checked == true) {

                }
                else {
                    optpartyc.checked = true;
                    optpartyw.checked = false;
                    optPartyCodeClick();
                }
            }
            return true;
        }

        function optPartyCodeClick() {
            var optpartyc = document.getElementById("ctl00_MyCPH1_optpartyc");
            var trpartyw = document.getElementById("ctl00_MyCPH1_trpartyw");
            var trpartyc = document.getElementById("ctl00_MyCPH1_trpartyc");

            if (optpartyc.checked == true) {
                trpartyc.style.display = "block";
                trpartyw.style.display = "none";
            }
            else {
                var chkpartpayment = document.getElementById("ctl00_MyCPH1_chkpartpayment");
                if (chkpartpayment.checked == false) {
                    trpartyc.style.display = "none";
                    trpartyw.style.display = "block";
                }
                else {
                    alert("Walk-In customers are not allowed for Partial Payment");
                    optpartyc.checked = true;
                }
            }

            return true;
        }

        function optReceiverClick() {
            var optrecc = document.getElementById("ctl00_MyCPH1_optrecc");
            var trrecw = document.getElementById("ctl00_MyCPH1_trrecw");
            var trrecc = document.getElementById("ctl00_MyCPH1_trrecc");
            if (optrecc.checked == true) {
                trrecc.style.display = "block";
                trrecw.style.display = "none";
            }
            else {
                trrecc.style.display = "none";
                trrecw.style.display = "block";
            }

            return true;
        }

        function popupConsignee() {
            var hdncurrloc = document.getElementById("ctl00_MyCPH1_hdncurrloc");
            window.open("DataPopUp.aspx?poptp=csge&code1=ctl00_MyCPH1_txtcsgecd&code2=ctl00_MyCPH1_txtcsgenm&code3=" + hdncurrloc.value, null, "height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15");
        }
        /****************************************************************************************************************
        CHECKS FOR VALID DATE WITH CUSTOMIZE ALTERT - NOT IN USE
        ****************************************************************************************************************/
        function alertInvalidDate(type) {
            if (type == "mrdate") {
                var txtmrdate = document.getElementById("ctl00_MyCPH1_txtmrdate");
                var dkt_call = document.getElementById("ctl00_MyCPH1_hdndockname").value;

                if (txtmrdate.value != "" && !isValidDate(txtmrdate.value, "MR")) {
                    txtmrdate.select();
                    return false;
                }
            }
            return false;
        }
        /****************************************************************************************************************/



        /*****************************************************************************************************************
        THIS FUCNTION IS USED TO TEST VALID DOCKET NUMBER
        *****************************************************************************************************************/
        function dockNoTest() {
            var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");
            hdnajaxstate.value = "1";

            var imgdockettick = document.getElementById("ctl00_MyCPH1_imgdockettick");
            var txt = document.getElementById('ctl00_MyCPH1_txtdockno');
            var ddlsuffix = document.getElementById('ctl00_MyCPH1_ddlsuffix');
            if (txt.value == "") {
                hdnajaxstate.value = "0";
                imgdockettick.style.display = "none";
                return false;
            }

            txt.value = txt.value.toUpperCase();

            var findobj = false;
            findobj = GetXMLHttpObject();
            if (findobj) {
                var strpg = "AjaxResponse.aspx?mode=check&code1=delmrdockno&code2=" + txt.value + "&code3=" + ddlsuffix.value + "&sid=" + Math.random() + "&sid=" + Math.random();
                findobj.open("GET", strpg);
                findobj.onreadystatechange = function() {
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



        /*****************************************************************************************************************
        THIS FUCNTION IS USED TO TEST VALID PARTY CODE 
        *****************************************************************************************************************/
        function partyTest(tp, txtid) {
            var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");
            hdnajaxstate.value = "1";

            var hdnorgnloc = document.getElementById("ctl00_MyCPH1_hdnorgnloc");
            var hdndelloc = document.getElementById("ctl00_MyCPH1_hdndelloc");

            var txt = document.getElementById('ctl00_MyCPH1_txtpartycode');
            txt.value = txt.value.toUpperCase();

            var txtname;
            var locname = "";
            if (tp == "party") {
                txtname = document.getElementById("ctl00_MyCPH1_txtpartyname");
                locname = hdndelloc.value;
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
                findobj.onreadystatechange = function() {
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
        THIS FUCNTION IS USED TO TEST VALID PARTY CODE 
        *****************************************************************************************************************/
        function receiverTest(txtid) {
            var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");
            hdnajaxstate.value = "1";

            var txt = document.getElementById(txtid);
            txt.value = txt.value.toUpperCase();

            var txtname = document.getElementById("ctl00_MyCPH1_txtreceivername");
            var locname = "";

            if (txt.value == "") {
                hdnajaxstate.value = "0";
                txtname.value = "";
                return false;
            }

            var findobj = false;
            findobj = GetXMLHttpObject();
            if (findobj) {
                var strpg = "AjaxResponse.aspx?mode=check&code1=receiver&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();
                findobj.open("GET", strpg);
                findobj.onreadystatechange = function() {
                    if ((findobj.readyState == 4) && (findobj.status == 200)) {
                        var res = findobj.responseText.split("|");

                        if (res[0] == "false") {
                            alert("This Receiver doesn't Exists OR deactivated");
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



        function bkgChargeChange(id) {

            var txt = document.getElementById(id);
            txt.value = roundNumber(txt.value, 2);

            var grvcharges = document.getElementById("ctl00_MyCPH1_grvcharges");
            var len = grvcharges.rows.length;
            var pref = ""; var diff = 0;
            var freightdiff = 0, delcharges = 0;
            for (var i = 4; i < len; i++) {
                if (i < 10)
                    pref = "ctl00_MyCPH1_grvcharges_ctl0" + i + "_";
                else
                    pref = "ctl00_MyCPH1_grvcharges_ctl" + i + "_";

                var lblbkgcharge = document.getElementById(pref + "lblbkgcharge");
                var txtdelcharge = document.getElementById(pref + "txtdelcharge");
                var txtdiffcharge = document.getElementById(pref + "txtdiffcharge");

                txtdelcharge.value = roundNumber(txtdelcharge.value, 2);

                if (isNaN(lblbkgcharge.innerText))
                    lblbkgcharge.innerText = "0.00";

                if (isNaN(txtdelcharge.value))
                    txtdelcharge.value = "0.00";

                delcharges = delcharges + parseFloat(txtdelcharge.value);
                diff = parseFloat(txtdelcharge.value) - parseFloat(lblbkgcharge.innerText);
                freightdiff = freightdiff + diff;
                txtdiffcharge.value = roundNumber(diff, 2);
            }

            var hdnflagroundoff = document.getElementById("ctl00_MyCPH1_hdnflagroundoff");
            if (hdnflagroundoff.value == "Y")
                freightdiff = Math.round(freightdiff);

            pref = "ctl00_MyCPH1_grvcharges_ctl" + i + "_";
            var txtdelsubtotal = document.getElementById(pref + "txtdelsubtotal");
            var txtdiffsubtotal = document.getElementById(pref + "txtdiffsubtotal");
            txtdiffsubtotal.value = roundNumber(freightdiff, 2);
            txtdelsubtotal.value = roundNumber(delcharges, 2);

            var txtfreightdiff = document.getElementById("ctl00_MyCPH1_grvdelcharges_ctl02_txtdelcharge");
            txtfreightdiff.value = roundNumber(freightdiff, 2);

            calculateTotal();

            return false;
        }

        function octAmountChange(id) {
            var txt = document.getElementById(id);
            txt.value = roundNumber(txt.value, 2);
            var txtoctcharge = document.getElementById("ctl00_MyCPH1_txtoctcharge");
            var txtoctprocrate = document.getElementById("ctl00_MyCPH1_txtoctprocrate");
            var txtoctproccharge = document.getElementById("ctl00_MyCPH1_txtoctproccharge");

            if (isNaN(txtoctcharge.value) || txtoctcharge.value == "")
                txtoctcharge.value = "0.00";

            if (isNaN(txtoctproccharge.value) || txtoctproccharge.value == "")
                txtoctcharge.value = "0.00";

            var proccesscharge = 0.00;
            processcharge = (parseFloat(txtoctcharge.value) * parseFloat(txtoctprocrate.value)) / 100;

            txtoctproccharge.value = roundNumber(processcharge, 2);

            calculateTotal();
            return false;
        }

        function delChargeChange(id) {
            var txt = document.getElementById(id);
            txt.value = roundNumber(txt.value, 2);

            calculateTotal();
            return false;
        }

        function calculateTotal() {
            var ddlsuffix = document.getElementById("ctl00_MyCPH1_ddlsuffix");
            var hdnpaybas = document.getElementById("ctl00_MyCPH1_hdnpaybas");
            var grvdelcharges = document.getElementById("ctl00_MyCPH1_grvdelcharges");
            var len = parseFloat(grvdelcharges.rows.length) + 1;
            var subtotal = 0.00;
            var pref = "";
            for (var i = 2; i < len; i++) {
                if (i < 10)
                    pref = "ctl00_MyCPH1_grvdelcharges_ctl0" + i + "_";
                else
                    pref = "ctl00_MyCPH1_grvdelcharges_ctl" + i + "_";

                var txtdelcharge = document.getElementById(pref + "txtdelcharge");
                if (txtdelcharge.value == "")
                    txtdelcharge.value = "0.00";

                subtotal = subtotal + parseFloat(txtdelcharge.value);
            }

            var hdnarrpkgqty = document.getElementById("ctl00_MyCPH1_hdnarrpkgqty");
            var hdnpkgsno = document.getElementById("ctl00_MyCPH1_hdnpkgsno");

            var grvcharges = document.getElementById("ctl00_MyCPH1_grvcharges");
            bkglen = grvcharges.rows.length;
            var lblbkgsubtotal;
            if (parseInt(bkglen) < 10)
                lblbkgsubtotal = document.getElementById("ctl00_MyCPH1_grvcharges_ctl0" + bkglen + "_lblbkgsubtotal");
            else
                lblbkgsubtotal = document.getElementById("ctl00_MyCPH1_grvcharges_ctl" + bkglen + "_lblbkgsubtotal");

            if (hdnpaybas.value == "P03" && (ddlsuffix.value == "." || (ddlsuffix.value == "M" && parseFloat(hdnarrpkgqty.value) == parseFloat(hdnpkgsno.value))))
                subtotal = subtotal + parseFloat(lblbkgsubtotal.innerText);

            var txtoctcharge = document.getElementById("ctl00_MyCPH1_txtoctcharge");
            var txtoctprocrate = document.getElementById("ctl00_MyCPH1_txtoctprocrate");
            var txtoctproccharge = document.getElementById("ctl00_MyCPH1_txtoctproccharge");

            if (isNaN(txtoctcharge.value) || txtoctcharge.value == "")
                txtoctcharge.value = "0.00";

            if (isNaN(txtoctproccharge.value) || txtoctproccharge.value == "")
                txtoctproccharge.value = "0.00";

            subtotal = subtotal + parseFloat(txtoctcharge.value);
            subtotal = subtotal + parseFloat(txtoctproccharge.value);

            var hdnflagroundoff = document.getElementById("ctl00_MyCPH1_hdnflagroundoff");

            if (hdnflagroundoff.value == "Y")
                subtotal = Math.round(subtotal);

            var txtsubtotal = document.getElementById("ctl00_MyCPH1_txtsubtotal");
            txtsubtotal.value = roundNumber(subtotal, 2);

            calculateMRAmount();
            return false;
        }


        /****************************************************************************************************************/

        function calculateMRAmount() {
            var servicetaxrate = parseFloat(document.getElementById("ctl00_MyCPH1_lblservicetaxrate").innerText);
            var cessrate = parseFloat(document.getElementById("ctl00_MyCPH1_lbleducessrate").innerText);
            var hcessrate = parseFloat(document.getElementById("ctl00_MyCPH1_lblheducessrate").innerText);

            var txtsubtotal = document.getElementById("ctl00_MyCPH1_txtsubtotal");
            var txtservicetax = document.getElementById("ctl00_MyCPH1_txtservicetax");
            var txteducess = document.getElementById("ctl00_MyCPH1_txteducess");
            var txtheducess = document.getElementById("ctl00_MyCPH1_txtheducess");
            var txtmramount = document.getElementById("ctl00_MyCPH1_txtmramount");
            var hdnpaybas = document.getElementById("ctl00_MyCPH1_hdnpaybas");
            var hdntransmode = document.getElementById("ctl00_MyCPH1_hdntransmode");
            var hdnservicetype = document.getElementById("ctl00_MyCPH1_hdnservicetype");
            var hdnclient = document.getElementById("ctl00_MyCPH1_hdnclient");
            var hdnflagstaxempted = document.getElementById("ctl00_MyCPH1_hdnflagstaxempted");
            var hdnstaxpayer = document.getElementById("ctl00_MyCPH1_hdnstaxpayer");
            var grvcharges = document.getElementById("ctl00_MyCPH1_grvcharges");
            var len = parseInt(grvcharges.rows.length);


            var lblbkgsubtotal;

            if (len < 10)
                lblbkgsubtotal = document.getElementById("ctl00_MyCPH1_grvcharges_ctl0" + len + "_lblbkgsubtotal");
            else
                lblbkgsubtotal = document.getElementById("ctl00_MyCPH1_grvcharges_ctl" + len + "_lblbkgsubtotal");

            if ((isNaN(servicetaxrate) || servicetaxrate == 0) && hdnflagstaxempted.value == "N") {
                alert("Service Tax is not Proper. Invalid DataBase.");
                return false;
            }

            if ((isNaN(cessrate) || cessrate == 0) && hdnflagstaxempted.value == "N") {
                alert("Education Cess Rate is not Proper. Invalid DataBase.");
                return false;
            }

            if ((isNaN(hcessrate) || hcessrate == 0) && hdnflagstaxempted.value == "N") {
                alert("Higher Education Cess Rate is not Proper. Invalid DataBase.");
                return false;
            }
            var subtotal = 0.00;
            var dockettotal = 0.00;
            var servicetax = 0.00;
            var cess = 0.00;
            var hcess = 0.00;

            subtotal = parseFloat(txtsubtotal.value);

            var txtoctcharge = document.getElementById("ctl00_MyCPH1_txtoctcharge");
            var txtoctproccharge = document.getElementById("ctl00_MyCPH1_txtoctproccharge");

            subtotal = subtotal - (txtoctcharge.value) - (txtoctproccharge.value);



            // CALCULATING TAXES ON BASE OF TRANSPORT MODE AND SERVICE TYPE BEING USED
            if (hdnstaxpayer.value == "T" && hdnflagstaxempted.value == "N") {
                if (hdntransmode.value == "2" || hdntransmode.value == "4") {
                    if ((hdnservicetype.value == "1" && subtotal <= 750) || (hdnservicetype.value == "2" && subtotal > 1500))
                        servicetaxrate = 0;
                }
            }
            else {
                servicetaxrate = 0;
            }

            servicetax = subtotal * servicetaxrate / 100;
            cess = servicetax * cessrate / 100;
            hcess = servicetax * hcessrate / 100;


            var hdnflagroundoff = document.getElementById("ctl00_MyCPH1_hdnflagroundoff");
            if (hdnflagroundoff.value == "Y") {
                servicetax = Math.round(servicetax);
                cess = Math.round(cess);
                hcess = Math.round(hcess);
            }

            txtservicetax.value = roundNumber(servicetax, 2);
            txteducess.value = roundNumber(cess, 2);
            txtheducess.value = roundNumber(hcess, 2);

            //ASSIGNING GRAND TOTAL

            serviceTaxBlur();
            return false;
        }



        /*****************************************************************************************************************
        MANUAL ENTRY FOR SERVICE TAX TO SHOW ROUND OFF
        *****************************************************************************************************************/
        function serviceTaxBlur() {
            var txtservicetax = document.getElementById("ctl00_MyCPH1_txtservicetax");
            var txteducess = document.getElementById("ctl00_MyCPH1_txteducess");
            var txtheducess = document.getElementById("ctl00_MyCPH1_txtheducess");
            var txtsubtotal = document.getElementById("ctl00_MyCPH1_txtsubtotal");
            var txtmramount = document.getElementById("ctl00_MyCPH1_txtmramount");
            var txtcollamt = document.getElementById("ctl00_MyCPH1_txtcollamt");

            txtservicetax.value = roundNumber(txtservicetax.value, 2);
            txteducess.value = roundNumber(txteducess.value, 2);
            txtheducess.value = roundNumber(txtheducess.value, 2);
            var mrtotal = 0.00;
            mrtotal = parseFloat(txtsubtotal.value) + parseFloat(txtservicetax.value) + parseFloat(txteducess.value) + parseFloat(txtheducess.value);

            txtmramount.value = roundNumber(mrtotal, 2);
            txtcollamt.value = roundNumber(mrtotal, 2);
            return false;
        }
        /*****************************************************************************************************************/



        function step1Click() {
            var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");
            //if (hdnajaxstate.value == "1") 
			//{
                //alert("Let the Internet Processes Over.");
                //return false;
            //}

            var txtdockno = document.getElementById("ctl00_MyCPH1_txtdockno");
            if (txtdockno.value == "") {
                alert("Please Enter Docket Number...");
                return false;
            }

            return true;
        }



        function btnsubmitClick() {
            var txtsubtotal = document.getElementById("ctl00_MyCPH1_txtsubtotal");
            var txtmramount = document.getElementById("ctl00_MyCPH1_txtmramount");
            var hdnpaybas = document.getElementById("ctl00_MyCPH1_hdnpaybas");
            var txtcollamt = document.getElementById("ctl00_MyCPH1_txtcollamt");
            var ddlpaymode = document.getElementById("ctl00_MyCPH1_ddlpaymode");
            var ddlbank = document.getElementById("ctl00_MyCPH1_ddlbank");
            var txtchequedate = document.getElementById("ctl00_MyCPH1_txtchequedate");
            var txtchequeno = document.getElementById("ctl00_MyCPH1_txtchequeno");
            var txtissuebank = document.getElementById("ctl00_MyCPH1_txtissuebank");
            var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");

//            if (hdnajaxstate.value == "1") {
//                alert("Let the Internet Processes Over.");
//                return false;
//            }


            if (txtsubtotal.value == "")
                txtsubtotal.value = "0.00";

            if (txtmramount.value == "")
                txtmramount.value = "0.00";

            var ddlsuffix = document.getElementById("ctl00_MyCPH1_ddlsuffix");
            var hdnarrpkgqty = document.getElementById("ctl00_MyCPH1_hdnarrpkgqty");
            var hdnpkgsno = document.getElementById("ctl00_MyCPH1_hdnpkgsno");

            if ((parseFloat(hdnarrpkgqty.value) == parseFloat(hdnpkgsno.value) && ddlsuffix.value == "M") || ddlsuffix.value == ".") {
                if (parseFloat(txtsubtotal.value) < 0) {
                    alert("SubTotal Can't be Lest than Zero. Please Enter Charges...");
                    return false;
                }

                if (parseFloat(txtmramount.value) < 0) {
                    alert("MR Amount Can't be Lest than Zero. Please Enter Charges...");
                    return false;
                }

                if (hdnpaybas.value == "P03") {
                    if (txtsubtotal.value == "" || parseFloat(txtsubtotal.value) == 0) {
                        alert("SubTotal Can't be Zero. Please Enter Charges...");
                        return false;
                    }

                    if (txtmramount.value == "" || parseFloat(txtmramount.value) == 0) {
                        alert("MR Amount Can't be Zero. Please Enter Charges...");
                        return false;
                    }
                }


                if (parseFloat(txtcollamt.value) > parseFloat(txtmramount.value)) {
                    alert("Collection Amount Can't be more than MR Amount");
                    return false;
                }

                if (parseFloat(txtcollamt.value) < parseFloat(txtmramount.value)) {
                    var txtpartycode = document.getElementById("ctl00_MyCPH1_txtpartycode");
                    if (txtpartycode.value == "") {
                        alert("Without Party Code Can't Generate Bill. Re-Enter Delivery MR");
                        return false;
                    }

                    if (!confirm("Collection Amount is Less than MR Amont\nBill will be generated. Do you want to Continue ?"))
                        return false;

                    var txtfreightdiff = document.getElementById("ctl00_MyCPH1_grvdelcharges_ctl02_txtdelcharge");
                    var txtservicetax = document.getElementById("ctl00_MyCPH1_txtservicetax");
                    var txteducess = document.getElementById("ctl00_MyCPH1_txteducess");
                    var txtheducess = document.getElementById("ctl00_MyCPH1_txtheducess");
                    var billamt = parseFloat(txtmramount.value) - parseFloat(txtcollamt.value)

                    var checkbillamt = Math.abs(parseFloat(txtfreightdiff.value)) + parseFloat(txtservicetax.value) + parseFloat(txteducess.value) + parseFloat(txtheducess.value);
                    if (billamt < checkbillamt) {
                        alert("Bill amount must be more than equal to Service Tax + Rebate");
                        return false;
                    }
                } // collection less than mr amount
            } //suffix checking ENDS HERE
            else {
                if (parseFloat(txtcollamt.value) > 0) {
                    alert("Suffix can not have collection amount more than 0");
                    return false;
                }

                if (parseFloat(txtmramount.value) > 0) {
                    alert("Suffix can not have MR amount more than 0");
                    return false;
                }

            } //suffix ELSE checking ENDS HERE

            if (ddlpaymode.value == "CHEQUE") {
                if (ddlbank.value == "" || ddlbank.value == "0") {
                    alert("No Bank Selected. Please Select a Bank");
                    ddlbank.focus();
                    return false;
                }

                if (txtchequeno.value == "") {
                    alert("Please Enter Cheque Number");
                    txtchequeno.focus();
                    return false;
                }

                if (txtchequedate.value == "") {
                    alert("Please Enter Cheque Date");
                    txtchequedate.focus();
                    return false;
                }

                if (txtissuebank.value == "") {
                    alert("Please Enter Issuing Bank Name");
                    txtissuebank.focus();
                    return false;
                }

                if (parseFloat(txtcollamt.value) == 0) {
                    alert("Cheques can not have zero amount");
                    ddlpaymode.value == "CASH";
                    return false;
                }
            } // paymode cheque ENDS HERE
            if (!confirm("Are you sure you want submit Delivery MR ?")) {
                return false;
            }
            return true;
        }

        function payModeChange() {
            var ddlpaymode = document.getElementById("ctl00_MyCPH1_ddlpaymode");
            var trbank = document.getElementById("ctl00_MyCPH1_trbank");
            var trdeposit = document.getElementById("ctl00_MyCPH1_trdeposit");

            if (ddlpaymode.value == "CHEQUE") {
                trbank.style.display = "block";
                trdeposit.style.display = "block";
            }
            else {
                trbank.style.display = "none";
                trdeposit.style.display = "none";
            }

            return false;
        }

        function optDepositeChange() {
            var optdeposit = document.getElementById("ctl00_MyCPH1_optdeposit_0");
            var ddlbank = document.getElementById("ctl00_MyCPH1_ddlbank");

            if (optdeposit.checked == true) {
                ddlbank.disabled = false;
            }
            else {
                ddlbank.disabled = true;
            }

            return true;
        }



        /****************************************************************************************************************/


    </script>

    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
    <asp:UpdatePanel ID="updone" runat="server">
        <ContentTemplate>
            <asp:Panel ID="divmain" runat="server" Width="10in">
                <br />
                <br />
                <asp:Table ID="tblmain" runat="server" Width="100%" CellSpacing="1">
                    <asp:TableRow>
                        <asp:TableCell ColumnSpan="4" HorizontalAlign="Center" Font-Bold="true">
                        <asp:Table runat="server" CellSpacing="1" CssClass="boxbg" Width="100%">
                                <asp:TableRow CssClass="bgbluegrey">
                                    <asp:TableCell Font-Bold="true">
                                    Delivery MR
                                    </asp:TableCell>
                                </asp:TableRow>
                        </asp:Table>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow ID="trstep1" runat="server" CssClass="bgwhite">
                        <asp:TableCell ColumnSpan="4">
                            <asp:Table runat="server" Width="100%" CssClass="boxbg" CellSpacing="1">
                                <asp:TableRow ID="trdockno" runat="server" CssClass="bgwhite">
                                    <asp:TableCell Width="25%">
                                        Docket Number
                                    </asp:TableCell>
                                    <asp:TableCell ColumnSpan="3" HorizontalAlign="Left">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtdockno" runat="server" Width="100px" MaxLength="15" CssClass="blackfnt"
                                                        BorderStyle="Groove" Enabled="false"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlsuffix" runat="server" onchange="javascript:return dockNoTest()"
                                                        CssClass="blackfnt" BackColor="White">
                                                        <asp:ListItem Value=".">Original</asp:ListItem>
                                                        <asp:ListItem Value="A">A</asp:ListItem>
                                                        <asp:ListItem Value="B">B</asp:ListItem>
                                                        <asp:ListItem Value="C">C</asp:ListItem>
                                                        <asp:ListItem Value="D">D</asp:ListItem>
                                                        <asp:ListItem Value="E">E</asp:ListItem>
                                                        <asp:ListItem Value="F">F</asp:ListItem>
                                                        <asp:ListItem Value="G">G</asp:ListItem>
                                                        <asp:ListItem Value="H">H</asp:ListItem>
                                                        <asp:ListItem Value="I">I</asp:ListItem>
                                                        <asp:ListItem Value="M">Misroute</asp:ListItem>
                                                        <asp:ListItem Value="X">X</asp:ListItem>
                                                        <asp:ListItem Value="Y">Y</asp:ListItem>
                                                        <asp:ListItem Value="Z">Z</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Image ID="imgdockettick" runat="server" Style="display: none;" Width="15px"
                                                        Height="15px" ImageUrl="~/GUI/images/dockettick.jpg" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3">
                                                    <asp:Label ID="lblmessage" Font-Bold="true" runat="server" CssClass="redfnt"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow runat="server" CssClass="bgbluegrey">
                                    <asp:TableCell ColumnSpan="4" HorizontalAlign="Right">
                                        <asp:Button ID="btnstep1" Text="Step 1" OnClientClick="javascript:return step1Click()"
                                            OnClick="btnstep1_Click" runat="server" CssClass="blackfnt" />
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgwhite" ID="trstep2" runat="server">
                        <asp:TableCell ColumnSpan="4">
                            <asp:Panel ID="divstep2" runat="server">
                                <asp:Table ID="Table1" runat="server" CssClass="boxbg" CellSpacing="1" Width="100%">
                                    <asp:TableRow CssClass="bgwhite">
                                        <asp:TableCell>
                                Docket No
                                        </asp:TableCell>
                                        <asp:TableCell>
                                            <asp:Label ID="lbldockno" runat="server" Font-Bold="true" CssClass="bluefnt"></asp:Label>
                                        </asp:TableCell>
                                        <asp:TableCell>
                                MR Date
                                        </asp:TableCell>
                                        <asp:TableCell>
                                            <asp:TextBox ID="txtmrdate" Enabled="false" runat="server" Width="70px" MaxLength="10"
                                                CssClass="blackfnt" BorderStyle="Groove"></asp:TextBox>
                                            <asp:Label ID="lblmrdateimage" runat="server">
                                                <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtmrdate,'ancmrdate','dd/MM/yyyy'); return false;"
                                                    name="ancmrdate" id="ancmrdate">
                                                    <img src="../../images/calendar.jpg" alt="calendar.jpg"
                                                        border="0" />
                                                </a>
                                            </asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow CssClass="bgwhite">
                                        <asp:TableCell>
                                            Payment Basis
                                        </asp:TableCell>
                                        <asp:TableCell Font-Bold="true">
                                            <asp:Label ID="lblpaybas" runat="server" CssClass="blackfnt"></asp:Label>
                                        </asp:TableCell>
                                        <asp:TableCell>
                                            GoDown Name
                                        </asp:TableCell>
                                        <asp:TableCell>
                                            <asp:Label ID="lblgodownname" runat="server" CssClass="blackfnt"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow CssClass="bgwhite">
                                        <asp:TableCell>
                                            No of Packages
                                        </asp:TableCell>
                                        <asp:TableCell Font-Bold="true">
                                            <asp:Label ID="lblnoOfPkgs" runat="server" CssClass="blackfnt"></asp:Label>
                                        </asp:TableCell>
                                        <asp:TableCell>
                                            Product Type
                                        </asp:TableCell>
                                        <asp:TableCell>
                                            <asp:Label ID="lblProductType" runat="server" CssClass="blackfnt"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow CssClass="bgwhite">
                                        <asp:TableCell>
                                            Charged Weight/No of Pkgs
                                        </asp:TableCell>
                                        <asp:TableCell Font-Bold="true">
                                            <asp:Label ID="lblchrgpkg" runat="server" CssClass="blackfnt"></asp:Label>
                                        </asp:TableCell>
                                        <asp:TableCell>
                                            <asp:Label ID="lblpartpayment" runat="server" CssClass="blackfnt">Allow Partial Payment</asp:Label>
                                        </asp:TableCell>
                                        <asp:TableCell>
                                            <asp:CheckBox ID="chkpartpayment" runat="server" onclick="javascript:return chkPartPaymentClick()"
                                                CssClass="blackfnt" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow ID="trcnee" runat="server" CssClass="bgwhite">
                                        <asp:TableCell>Change Consingee</asp:TableCell>
                                        <asp:TableCell>
                                            <asp:Table ID="tblparty" runat="server">
                                                <asp:TableRow ID="trpartytype" runat="server">
                                                    <asp:TableCell ColumnSpan="2">
                                                        <asp:RadioButtonList ID="optpartytype" RepeatDirection="Horizontal" onclick="javascript:return chkPartyType()"
                                                            runat="server" CssClass="blackfnt">
                                                            <asp:ListItem Text="Billing Party" Value="P"></asp:ListItem>
                                                            <asp:ListItem Text="Consignee" Value="CE"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="trcneewc" runat="server">
                                                    <asp:TableCell>
                                                        <asp:RadioButton ID="optpartyc" onclick="javascript:return optPartyCodeClick()" runat="server"
                                                            GroupName="optcsge" Text="From Master" />
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:RadioButton ID="optpartyw" onclick="javascript:return optPartyCodeClick()" runat="server"
                                                            GroupName="optcsge" Text="Walk-In" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="trpartyw" runat="server">
                                                    <asp:TableCell ColumnSpan="3">
                                                        <asp:TextBox ID="txtpartyw" runat="server" BorderStyle="Groove" Width="240px" onblur="javascript:this.value=this.value.toUpperCase()"
                                                            CssClass="blackfnt"></asp:TextBox>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="trpartyc" runat="server">
                                                    <asp:TableCell ColumnSpan="2">
                                                        <asp:TextBox ID="txtpartycode" runat="server" onblur="javascript:return partyTest('party',this.getAttribute('id'))"
                                                            BorderStyle="Groove" Width="100px" CssClass="blackfnt"></asp:TextBox>-<asp:TextBox
                                                                ID="txtpartyname" Enabled="false" runat="server" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox><br />
                                                        <xac:WebxComplete ID="xacpartycode" runat="server" MinPrefixLength="2" WebxEntity="Customer"
                                                            CodeTarget="txtpartycode" NameTarget="txtpartyname" FilterTextBox="txtcurrloc" />
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <input type="button" id="btnpartypopup" value="..." tabindex="2" visible="false"
                                                            onclick="javascript:return popupPartyCSGE()" class="blackfnt" runat="server" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                            </asp:Table>
                                        </asp:TableCell>
                                        <asp:TableCell>Delivery Vehicle</asp:TableCell>
                                        <asp:TableCell>
                                            <asp:TextBox ID="txtdelvehicle" Enabled="false" runat="server" BorderStyle="Groove"
                                                CssClass="blackfnt"></asp:TextBox>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow CssClass="bgwhite">
                                        <asp:TableCell>
                                            Receiver
                                        </asp:TableCell>
                                        <asp:TableCell>
                                            <asp:Table ID="tblreceiver" runat="server">
                                                <asp:TableRow>
                                                    <asp:TableCell>
                                                        <asp:RadioButton ID="optrecc" Checked="true" runat="server" onclick="javascript:return optReceiverClick()"
                                                            GroupName="optrec" Text="From Master" />
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:RadioButton ID="optrecw" runat="server" onclick="javascript:return optReceiverClick()"
                                                            GroupName="optrec" Text="Walk-In" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="trrecw" Style="display: none;" runat="server">
                                                    <asp:TableCell ColumnSpan="3">
                                                        <asp:TextBox ID="txtreceiverw" runat="server" BorderStyle="Groove" Width="240px"
                                                            onblur="javascript:this.value=this.value.toUpperCase()" CssClass="blackfnt"></asp:TextBox>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="trrecc" runat="server">
                                                    <asp:TableCell>
                                                        <asp:TextBox ID="txtreceivercode" runat="server" onblur="javascript:return receiverTest(this.getAttribute('id'))"
                                                            BorderStyle="Groove" Width="100px" CssClass="blackfnt"></asp:TextBox>-</asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:TextBox ID="txtreceivername" Enabled="false" runat="server" BorderStyle="Groove"
                                                            CssClass="blackfnt"></asp:TextBox></asp:TableCell>
                                                    <asp:TableCell>
                                                        <input type="button" id="btnrecpopup" value="..." tabindex="2" onclick="javascript:return popupReceiver()"
                                                            class="blackfnt" runat="server" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                            </asp:Table>
                                        </asp:TableCell>
                                        <asp:TableCell>Remarks</asp:TableCell>
                                        <asp:TableCell>
                                            <asp:TextBox ID="txtremarks" Enabled="false" runat="server" TextMode="MultiLine"
                                                BackColor="white" Width="150px" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow ID="TableRow1" runat="server" CssClass="bgwhite">
                                        <asp:TableCell HorizontalAlign="Left">
                                            UnLoading Date
                                        </asp:TableCell>
                                        <asp:TableCell ColumnSpan="3" HorizontalAlign="Left">
                                            <asp:Label ID="lblUnLoadingDate" runat="server"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow ID="trbtnstep2" runat="server" CssClass="bgbluegrey">
                                        <asp:TableCell ColumnSpan="4" HorizontalAlign="Right">
                                            <asp:Button ID="btnstep2" Text="Step 2" OnClientClick="javascript:return step2Click()"
                                                OnClick="btnstep2_Click" runat="server" CssClass="blackfnt" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </asp:Panel>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow ID="trcharges" runat="server" CssClass="bgwhite">
                        <asp:TableCell>
                            <asp:Table runat="server" Width="100%" CssClass="boxbg" CellSpacing="1">
                                <asp:TableRow CssClass="bgwhite">
                                    <asp:TableCell ColumnSpan="4">
                                        <asp:GridView HorizontalAlign="left" ID="grvcharges" runat="server" BorderWidth="0"
                                            CellSpacing="1" AllowSorting="true" CssClass="boxbg" HeaderStyle-CssClass="bgbluegrey"
                                            RowStyle-CssClass="bgwhite" AlternatingRowStyle-BackColor="#f7f7f7" ShowFooter="true"
                                            AutoGenerateColumns="false" FooterStyle-CssClass="bgbluegrey" OnRowDataBound="grvcharges_RowDataBound"
                                            Style="width: 100%;">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Booking Charge Name">
                                                    <ItemStyle HorizontalAlign="Left" />
                                                    <ItemTemplate>
                                                        <asp:Label CssClass="blackfnt" ID="txtchargename1" Text='<%# DataBinder.Eval(Container.DataItem,"chargename") %>'
                                                            runat="server"></asp:Label>
                                                        <asp:Label ID="lbloperator" runat="server" CssClass="bluefnt" Font-Bold="true"></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterStyle Font-Bold="true" />
                                                    <FooterTemplate>
                                                        Sub Total
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Charge at time of Booking">
                                                    <ItemStyle HorizontalAlign="Right" />
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblbkgcharge" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"docketcharge") %>'
                                                            CssClass="blackfnt"></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterStyle HorizontalAlign="Right" />
                                                    <FooterTemplate>
                                                        <asp:Label ID="lblbkgsubtotal" runat="server" Font-Bold="true"></asp:Label>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Charge at time of Delivery">
                                                    <ItemStyle HorizontalAlign="Right" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtdelcharge" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                                            MaxLength="10" Width="80px" Style="text-align: right;" Text='<%# DataBinder.Eval(Container.DataItem,"contractcharge") %>'
                                                            onblur="javascript:return bkgChargeChange(this.getAttribute('id'));" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                                        <asp:HiddenField ID="hdnchargecode" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"chargecode") %>' />
                                                        <asp:HiddenField ID="hdnactiveflag" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"activeflag") %>' />
                                                        <asp:HiddenField ID="hdnoperator" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"operator") %>' />
                                                    </ItemTemplate>
                                                    <FooterStyle HorizontalAlign="Right" />
                                                    <FooterTemplate>
                                                        <asp:TextBox ID="txtdelsubtotal" Enabled="false" runat="server" CssClass="blackfnt"
                                                            BorderStyle="Groove" onblur="javascript:return delSubTotalChange();" MaxLength="10"
                                                            Width="80px" Style="text-align: right;"></asp:TextBox>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Charge to be Collected">
                                                    <ItemStyle HorizontalAlign="Right" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtdiffcharge" Enabled="false" runat="server" CssClass="blackfnt"
                                                            BorderStyle="Groove" MaxLength="10" Width="80px" Style="text-align: right;" Text='<%# DataBinder.Eval(Container.DataItem,"docketcharge") %>'
                                                            onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <FooterStyle HorizontalAlign="Right" />
                                                    <FooterTemplate>
                                                        <asp:TextBox ID="txtdiffsubtotal" Enabled="false" runat="server" CssClass="blackfnt"
                                                            BorderStyle="Groove" MaxLength="10" Width="80px" Style="text-align: right;"></asp:TextBox>
                                                        <asp:HiddenField ID="Hdndiffsubtotal" runat="server" />
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="TableRow2" CssClass="bgwhite" runat="server">
                                    <asp:TableCell ColumnSpan="4" Font-Bold="true">
                                        <asp:GridView HorizontalAlign="left" ID="grvdelcharges" runat="server" BorderWidth="0"
                                            CellSpacing="1" AllowSorting="true" CssClass="boxbg" HeaderStyle-CssClass="bgbluegrey"
                                            RowStyle-CssClass="bgwhite" AlternatingRowStyle-BackColor="#f7f7f7" AutoGenerateColumns="false"
                                            ShowFooter="false" OnRowDataBound="grvdelcharges_RowDataBound" Style="width: 100%;">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Delivery Charge Name">
                                                    <ItemStyle HorizontalAlign="Left" />
                                                    <ItemTemplate>
                                                        <asp:Label CssClass="blackfnt" ID="lblchargename" Text='<%# DataBinder.Eval(Container.DataItem,"chargename") %>'
                                                            runat="server"></asp:Label>
                                                        <asp:Label ID="lbloperator" runat="server" CssClass="bluefnt" Font-Bold="true"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Charge at time of Delivery">
                                                    <ItemStyle HorizontalAlign="Right" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtdelcharge" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                                            MaxLength="10" Width="80px" Style="text-align: right;" Text='<%# DataBinder.Eval(Container.DataItem,"chargevalue") %>'
                                                            onblur="javascript:return delChargeChange(this.getAttribute('id'));" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                                        <asp:HiddenField ID="hdnchargecode" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"chargecode") %>' />
                                                        <asp:HiddenField ID="hdnactiveflag" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"activeflag") %>' />
                                                        <asp:HiddenField ID="hdnoperator" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"operator") %>' />
                                                        <asp:HiddenField ID="hdnvarybyloc" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"varybyloc") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite">
                                    <asp:TableCell ColumnSpan="3" HorizontalAlign="Right">Octroi Amount&nbsp;</asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Right">
                                        <asp:TextBox ID="txtoctcharge" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            Style="text-align: right;" onblur="javascript:return octAmountChange(this.getAttribute('id'))"
                                            onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" MaxLength="10"
                                            Width="80px">
                                        </asp:TextBox>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite">
                                    <asp:TableCell>Octroi Rate&nbsp;</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtoctprocrate" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            Style="text-align: right;" onblur="javascript:return octAmountChange(this.getAttribute('id'))"
                                            onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" MaxLength="10"
                                            Width="80px">
                                        </asp:TextBox>
                                    </asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Right">Octroi Processing Charge&nbsp;</asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Right">
                                        <asp:TextBox ID="txtoctproccharge" Enabled="false" runat="server" CssClass="blackfnt"
                                            BorderStyle="Groove" Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                            MaxLength="10" Width="80px">
                                        </asp:TextBox>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite">
                                    <asp:TableCell ColumnSpan="2">&nbsp;</asp:TableCell>
                                    <asp:TableCell><b>SUB-TOTAL</b></asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Right">
                                        <asp:TextBox ID="txtsubtotal" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                            MaxLength="10" Enabled="false" Width="80px">
                                        </asp:TextBox>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite">
                                    <asp:TableCell>
                                        <table>
                                            <tr>
                                                <td>
                                                    Service Tax Rate(%)
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblexmpt" runat="server" Style="display: none;" Font-Italic="true"
                                                        CssClass="redfnt">(exmpted)</asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lblservicetaxrate" runat="server" Text="12.00" CssClass="bluefnt"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                            Service Tax Collected</asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Right">
                                        <asp:TextBox ID="txtservicetax" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            Enabled="false" Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                            onblur="javascript:return serviceTaxBlur()" MaxLength="10" Width="80px">
                                        </asp:TextBox>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite">
                                    <asp:TableCell>
                            Educational Cess Rate (%)</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lbleducessrate" runat="server" Text="2.00" CssClass="bluefnt"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                        Educational Cess Collected</asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Right">
                                        <asp:TextBox ID="txteducess" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            Enabled="false" Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                            MaxLength="10" onblur="javascript:return serviceTaxBlur()" Width="80px">
                                        </asp:TextBox>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite">
                                    <asp:TableCell>
                            Higher Educational Cess Rate (%)</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lblheducessrate" runat="server" Text="1.00" CssClass="bluefnt"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                        Higher Educational Cess Collected</asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Right">
                                        <asp:TextBox ID="txtheducess" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            Enabled="false" Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                            onblur="javascript:return serviceTaxBlur()" MaxLength="10" Width="80px">
                                        </asp:TextBox>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite">
                                    <asp:TableCell>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                                            <b>MR Amount</b></asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Right">
                                        <asp:TextBox ID="txtmramount" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                            MaxLength="10" Enabled="false" Width="80px">
                                        </asp:TextBox>
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgwhite" ID="trpaymode" Style="display: none;" runat="server">
                        <asp:TableCell ColumnSpan="4" Font-Bold="true">
                            <asp:Table ID="Table2" runat="server" CssClass="boxbg" CellSpacing="1" Width="100%">
                                <asp:TableRow CssClass="bgwhite">
                                    <asp:TableCell>
                                   Mode
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:DropDownList ID="ddlpaymode" runat="server" onchange="javascript:return payModeChange()"
                                            BackColor="white" CssClass="blackfnt">
                                            <asp:ListItem Text="Cash" Value="CASH"></asp:ListItem>
                                            <asp:ListItem Text="Cheque" Value="CHEQUE"></asp:ListItem>
                                        </asp:DropDownList>
                                    </asp:TableCell>
                                    <asp:TableCell> Collection Amount</asp:TableCell>
                                    <asp:TableCell ColumnSpan="3">
                                        <asp:TextBox ID="txtcollamt" runat="server" MaxLength="9" Width="120px" Style="text-align: right"
                                            BorderStyle="Groove" CssClass="blackfnt" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                            onblur="javascript:return this.value=roundNumber(this.value,2)">
                                        </asp:TextBox></asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="trbank" Style="display: none;" runat="server" CssClass="bgwhite">
                                    <asp:TableCell> Cheque Number</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtchequeno" runat="server" MaxLength="6" Width="70px" BorderStyle="Groove"
                                            onkeypress="javascript:return validInt(event)">
                                        </asp:TextBox>
                                    </asp:TableCell>
                                    <asp:TableCell>Cheque Date</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtchequedate" runat="server" Width="70px" MaxLength="10" CssClass="blackfnt"
                                            BorderStyle="Groove" onblur="javascript:return alertInvalidDate('chequedate')">
                                        </asp:TextBox>
                                        <asp:Label ID="lblchequedateimage" runat="server">
                            <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtchequedate,'ancchequedate','dd/MM/yyyy'); return false;"
                                name="ancchequedate" id="ancchequedate">
                                <img src="../../images/calendar.jpg" alt="calendar.jpg"
                                    border="0" />
                            </a>
                                        </asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        Deposited 
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:RadioButtonList ID="optdeposit" RepeatDirection="Horizontal" onclick="javascript:return optDepositeChange()"
                                            runat="server">
                                            <asp:ListItem Value="Y" Text="Yes" Selected="True"></asp:ListItem>
                                            <asp:ListItem Value="N" Text="No"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="trdeposit" Style="display: none;" runat="server" CssClass="bgwhite">
                                    <asp:TableCell>
                               Deposite Bank
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:DropDownList ID="ddlbank" runat="server" DataValueField="acccode" DataTextField="accdesc"
                                            BackColor="white" CssClass="blackfnt">
                                        </asp:DropDownList>
                                    </asp:TableCell>
                                    <asp:TableCell>Issuing Bank</asp:TableCell>
                                    <asp:TableCell ColumnSpan="3">
                                        <asp:TextBox ID="txtissuebank" onblur="this.value=this.value.toUpperCase()" runat="server"
                                            MaxLength="40" Width="70px" CssClass="blackfnt" BorderStyle="Groove" onkeypress="javascript:return withoutQuote(event)">
                                        </asp:TextBox>
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgbluegrey" ID="trsumit" runat="server">
                        <asp:TableCell ColumnSpan="4" HorizontalAlign="Center">
                            <asp:Button ID="btnsubmit" Text="Submit" OnClientClick="javascript:return btnsubmitClick()"
                                runat="server" OnClick="btnsubmit_Click" CssClass="blackfnt" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
                <asp:HiddenField ID="hdnajaxstate" runat="server" />
                <asp:HiddenField ID="hdndockdate" runat="server" />
                <asp:TextBox ID="txtcurrloc" runat="server" Style="display: none;"></asp:TextBox>
                <asp:HiddenField ID="hdnclient" runat="server" />
                <asp:HiddenField ID="hdnfinstartyear" runat="server" />
                <asp:HiddenField ID="hdncontractid" runat="server" />
                <asp:HiddenField ID="hdntransmode" runat="server" />
                <asp:HiddenField ID="hdnbusinesstype" runat="server" />
                <asp:HiddenField ID="hdnfrom" runat="server" />
                <asp:HiddenField ID="hdnto" runat="server" />
                <asp:HiddenField ID="hdnprodtype" runat="server" />
                <asp:HiddenField ID="hdnrisktype" runat="server" />
                <asp:HiddenField ID="hdnflagoda" runat="server" />
                <asp:HiddenField ID="hdnflagcoddod" runat="server" />
                <asp:HiddenField ID="hdnflagdacc" runat="server" />
                <asp:HiddenField ID="hdncsgecd" runat="server" />
                <asp:HiddenField ID="hdncsgenm" runat="server" />
                <asp:HiddenField ID="hdndeclval" runat="server" />
                <asp:HiddenField ID="hdndelloc" runat="server" />
                <asp:HiddenField ID="hdncurrloc" runat="server" />
                <asp:HiddenField ID="hdnorgnloc" runat="server" />
                <asp:HiddenField ID="hdnpaybas" runat="server" />
                <asp:HiddenField ID="hdnpartycode" runat="server" />
                <asp:HiddenField ID="hdnpartyname" runat="server" />
                <asp:HiddenField ID="hdnservicetype" runat="server" />
                <asp:HiddenField ID="hdnftltype" runat="server" />
                <asp:HiddenField ID="hdnchargerule" runat="server" />
                <asp:HiddenField ID="hdnbasecode1" runat="server" />
                <asp:HiddenField ID="hdnchargesubrule" runat="server" />
                <asp:HiddenField ID="hdnbasecode2" runat="server" />
                <asp:HiddenField ID="hdnchargedweight" runat="server" />
                <asp:HiddenField ID="hdnpkgsno" runat="server" />
                <asp:HiddenField ID="hdnratetype" runat="server" />
                <asp:HiddenField ID="hdnstaxpayer" runat="server" />
                <asp:HiddenField ID="hdnflagstaxempted" runat="server" />
                <asp:HiddenField ID="hdnserverdate" runat="server" />
                <asp:HiddenField ID="hdndockname" runat="server" />
                <asp:HiddenField ID="hdnemployee" runat="server" />
                <asp:HiddenField ID="hdnflagroundoff" runat="server" />
                <asp:HiddenField ID="hdnarrpkgqty" runat="server" />
                <asp:HiddenField ID="hdnarrweightqty" runat="server" />
                <asp:HiddenField ID="HdnMrLoc" runat="server" />
                <asp:HiddenField ID="HdnGatePassLoc" runat="server" />
                <asp:HiddenField ID="HdnDocType" runat="server" />
                <asp:HiddenField ID="HdnFreightAmount" runat="server" />
                <asp:HiddenField ID="HdnSubtotalAmount" runat="server" />
                <asp:HiddenField ID="HdnDefaultContractId" runat="server" />
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
    <pgb:ProgressBar ID="ProgressBar1" runat="server" />
</asp:Content>
