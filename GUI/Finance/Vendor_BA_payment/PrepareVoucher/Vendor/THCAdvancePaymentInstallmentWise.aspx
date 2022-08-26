<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="THCAdvancePaymentInstallmentWise.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_PrepareVoucher_Vendor_THCAdvancePaymentInstallmentWise" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript" src="../../../../images/commonJs.js"></script>
    <script language="javascript" type="text/javascript" src="../../../../images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript" src="../../../../images/DateControl.js"></script>
    <script language="javascript" type="text/javascript" src="../../../../Js/WebxConvert.js"></script>
    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>
    <script language="javascript" type="text/javascript">
var submit = 0;
        function CheckDouble() {
            //debugger;
            if (++submit > 1) {
                alert('This sometimes takes a few seconds - please be patient.');
                submit = 0;
                return false;
            }
            return true;

        }  
        
        frm_name = "ctl00$MyCPH1$"
        var months = new Array("", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
        var client_name = "<%=Session["Client"]%>"
        var Fromdate = "<%=fromdt%>"
        var Todate = "<%=Todt%>"
        var FinYear = "<%=Session["FinYear"]%>"
        var FinYear_to = parseInt(FinYear) + 1

        if (FinYear_to < 10) {
            FinYear_to = "0" + FinYear_to
        }
        var FinYear_fromdate = "01/04/" + FinYear
        var FinYear_todate = "31/03/" + FinYear_to
        var Sle_finyear = FinYear + "-" + FinYear_to
        Frmnae = "ctl00_MyCPH1_"
        var NetpaymentAmt = 0;
        totdkt = "<%=totdkt %>"

        
        function check() {
            ///***************************************  ACCOUNTING TRANSACTION *******************************/
            // debugger;
            var server_dt = "<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
            if (document.getElementById(Frmnae + "txtVoucherDate").value == "") {
                alert("Please enter the Financial Close Date")
                document.getElementById(Frmnae + "txtVoucherDate").focus();
                return false;
            }
            if (ValidateForm(document.getElementById(Frmnae + "txtVoucherDate")) == false) {
                document.getElementById(Frmnae + "txtVoucherDate").focus();
                return false;
            }
            var dt = document.getElementById(Frmnae + "txtVoucherDate").value
            var hdndockdt;
            var Maxdt = "01/01/2007";

            var mTotalRecords = totdkt;
            for (var i = 0; i < mTotalRecords; i++) {
                j = i + 2;
                if (j < 10) {
                    hdndockdt = "ctl00_MyCPH1_dockdata_ctl" + "0" + j + "_thcdate";
                    hdndockdt = document.getElementById(hdndockdt).value;
                }
                else {
                    hdndockdt = "ctl00_MyCPH1_dockdata_ctl" + j + "_thcdate";
                    hdndockdt = document.getElementById(hdndockdt).value;

                }
                var Maxdt1 = Maxdt

                var Maxdt_dd = Maxdt1.substring(0, 2)
                var Maxdt_mm = Maxdt1.substring(3, 5)
                var Maxdt_yy = Maxdt1.substring(6, 10)

                var hdndockdt1 = hdndockdt
                var hdndockdt_dd = hdndockdt1.substring(0, 2)
                var hdndockdt_mm = hdndockdt1.substring(3, 5)
                var hdndockdt_yy = hdndockdt1.substring(6, 10)

                Maxdt1 = new Date(months[parseFloat(Maxdt_mm)] + " " + parseFloat(Maxdt_dd) + ", " + parseFloat(Maxdt_yy))
                hdndockdt1 = new Date(months[parseFloat(hdndockdt_mm)] + " " + parseFloat(hdndockdt_dd) + ", " + parseFloat(hdndockdt_yy))
                if (hdndockdt1 > Maxdt1) {
                    Maxdt1 = hdndockdt1
                    Maxdt = hdndockdt
                }
            }
            var dt_dd = dt.substring(0, 2)
            var dt_mm = dt.substring(3, 5)
            var dt_yy = dt.substring(6, 10)

            var sdt = server_dt
            var sdt_dd = sdt.substring(0, 2)
            var sdt_mm = sdt.substring(3, 5)
            var sdt_yy = sdt.substring(6, 10)


            dt = new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
            server_dt = new Date(months[parseFloat(sdt_mm)] + " " + parseFloat(sdt_dd) + ", " + parseFloat(sdt_yy))

            var FinYear_fromdate_dd = FinYear_fromdate.substring(0, 2)
            var FinYear_fromdate_mm = FinYear_fromdate.substring(3, 5)
            var FinYear_fromdate_yy = FinYear_fromdate.substring(6, 10)
            FinYear_fromdate1 = new Date(months[parseFloat(FinYear_fromdate_mm)] + " " + parseFloat(FinYear_fromdate_dd) + ", " + parseFloat(FinYear_fromdate_yy))

            var FinYear_todate_dd = FinYear_todate.substring(0, 2)
            var FinYear_todate_mm = FinYear_todate.substring(3, 5)
            var FinYear_todate_yy = FinYear_todate.substring(6, 10)
            FinYear_todate1 = new Date(months[parseFloat(FinYear_todate_mm)] + " " + parseFloat(FinYear_todate_dd) + ", " + parseFloat(FinYear_todate_yy))

            if (dt > FinYear_todate1 || dt < FinYear_fromdate1) {
                alert("You have Selected Finacial Year as " + Sle_finyear + " , SO Financial Close Date Should Be Between  " + FinYear_fromdate + " to " + FinYear_todate + " !!!")
                document.getElementById(Frmnae + "txtVoucherDate").focus();
                return false;
            }

            var Fromdate_dd = Fromdate.substring(0, 2)
            var Fromdate_mm = Fromdate.substring(3, 5)
            var Fromdate_yy = Fromdate.substring(6, 10)
            Fromdate1 = new Date(months[parseFloat(Fromdate_mm)] + " " + parseFloat(Fromdate_dd) + ", " + parseFloat(Fromdate_yy))

            var Todate_dd = Todate.substring(0, 2)
            var Todate_mm = Todate.substring(3, 5)
            var Todate_yy = Todate.substring(6, 10)
            Todate1 = new Date(months[parseFloat(Todate_mm)] + " " + parseFloat(Todate_dd) + ", " + parseFloat(Todate_yy))
            Fromdate1 = Maxdt1
            Fromdate = Maxdt
            if (dt < Fromdate1) {
                alert("Financial Close Date Should Be Greater than  " + Fromdate + "  !!!")
                document.getElementById(Frmnae + "txtVoucherDate").focus();
                return false;
            }
            if (dt > server_dt) {
                alert("Financial Close Date should not be greater than today's date !!!")
                document.getElementById(Frmnae + "txtVoucherDate").focus();
                return false;
            }
            k = parseFloat(totdkt) + 2
            if (k < 10) {

                Form_name1 = "ctl00_MyCPH1_dockdata_ctl" + "0" + k + "_"

            }
            else {
                Form_name1 = "ctl00_MyCPH1_dockdata_ctl" + k + "_"

            }

            if (parseFloat(document.getElementById(Form_name1 + "TotalNetamt").value) > 0) {

            }

            var RowAdvanceCash = document.getElementById("ctl00_MyCPH1_RowAdvanceCash");
            var RowAdvanceCheque = document.getElementById("ctl00_MyCPH1_RowAdvanceCheque");
            var RowAdvanceChequeGrid = document.getElementById("ctl00_MyCPH1_RowAdvanceChequeGrid");
            var RowOtherAdvance = document.getElementById("ctl00_MyCPH1_RowOtherAdvance");

            //added by anupam
            //part new
            var txtAdvanceCash = document.getElementById("ctl00_MyCPH1_txtAdvanceCash");
            if (parseFloat(txtAdvanceCash.value) > 0) {
                if (document.getElementById("ctl00_MyCPH1_RowAdvanceCash").style.display == "") {
                    var dgAdvanceCash = document.getElementById("ctl00_MyCPH1_dgAdvanceCash");
                    var txtAdvanceCash = document.getElementById("ctl00_MyCPH1_txtAdvanceCash");
                    var totInstallmentAmount = 0;
                    for (i = 2; i <= dgAdvanceCash.rows.length; i++) {
                        pref = "ctl00_MyCPH1_dgAdvanceCash_ctl0" + i + "_";
                        var txtInstallmentAmount = document.getElementById(pref + "txtInstallmentAmount");
                        if (parseFloat(txtInstallmentAmount.value) > 35000) {
                            alert("Please enter installment amount less than 35000.");
                        }
                        if (parseFloat(txtInstallmentAmount.value) >= 0) {
                            totInstallmentAmount = parseFloat(parseFloat(totInstallmentAmount) + parseFloat(txtInstallmentAmount.value));
                        }

                    }
                    if (parseFloat(totInstallmentAmount) > parseFloat(txtAdvanceCash.value))
                    { alert("Total installment amount can not be greater than advance cash "); return false; }

                    if (parseFloat(totInstallmentAmount) < parseFloat(txtAdvanceCash.value))
                    { alert("Total installment amount can not be less than advance cash "); return false; }
                }
            }

            //part new
            var txtAdvanceCheque = document.getElementById("ctl00_MyCPH1_txtAdvanceCheque");
            if (parseFloat(txtAdvanceCheque.value) > 0) {
                if (document.getElementById("ctl00_MyCPH1_RowAdvanceCheque").style.display == "") {
                    var dgAdvanceCheque = document.getElementById("ctl00_MyCPH1_dgAdvanceCheque");
                    var txtAdvanceCheque = document.getElementById("ctl00_MyCPH1_txtAdvanceCheque");
                    var rbtLstAdvanceCheque = document.getElementById("ctl00_MyCPH1_rbtLstAdvanceCheque");
                    var txtBranchName = document.getElementById("ctl00_MyCPH1_txtBranchName");
                    var totChqAmount = 0;
                    for (i = 2; i <= dgAdvanceCheque.rows.length; i++) {
                        pref = "ctl00_MyCPH1_dgAdvanceCheque_ctl0" + i + "_";
                        var txtAmount = document.getElementById(pref + "txtAmount");
                        if (parseFloat(txtAmount.value) >= 0) {
                            totChqAmount = parseFloat(parseFloat(totChqAmount) + parseFloat(txtAmount.value));
                        }
                    }



                    if (parseFloat(totChqAmount) > parseFloat(txtAdvanceCheque.value)) {
                        alert("Total cheque amount can not be greater than advance by cheque "); return false;
                    }

                    var rbtLstAdvanceChequeI = document.getElementById("ctl00_MyCPH1_rbtLstAdvanceCheque_0");
                    var rbtLstAdvanceChequeL = document.getElementById("ctl00_MyCPH1_rbtLstAdvanceCheque_1");
                    var txtBranchName = document.getElementById("ctl00_MyCPH1_txtBranchName");
                    if (rbtLstAdvanceChequeI.checked == true) {
                        for (i = 2; i <= dgAdvanceCheque.rows.length; i++) {
                            pref = "ctl00_MyCPH1_dgAdvanceCheque_ctl0" + i + "_";
                            var txtAmount = document.getElementById(pref + "txtAmount");
                            var txtChequeNo = document.getElementById(pref + "txtChequeNo");
                            var cboBankName = document.getElementById(pref + "cboBankName");
                            var txtDate = document.getElementById(pref + "txtDate");
                            var txtFavour = document.getElementById(pref + "txtFavour");

                            if (txtChequeNo.value == "") {
                                alert("Please enter cheque No");
                                txtChequeNo.focus();
                                return false;
                            }
                            if (cboBankName.value == "0Select") {
                                alert("Please enter Bank name");
                                cboBankName.focus();
                                return false;
                            }

                            if (txtDate.value == "") {
                                alert("Please enter date");
                                txtDate.focus();
                                return false;
                            }

                            if (txtAmount.value == "") {
                                alert("Please enter cheque Amount");
                                txtAmount.focus();
                                return false;
                            }

                            if (txtFavour.value == "") {
                                alert("Please enter Favour");
                                txtFavour.focus();
                                return false;
                            }
                        }
 			//if (parseFloat(totChqAmount) < parseFloat(txtAdvanceCheque.value)) {
                            
                         //   alert("Total cheque amount not less then advance by cheque")
                          //  return false;
                          
                        //}
                        if (parseFloat(totChqAmount) < parseFloat(txtAdvanceCheque.value) && txtBranchName.value == "") {
                            alert("Please enter Branch code")
                            txtBranchName.focus();
                            return false;
                       }
                    }
                }

                if (document.getElementById("ctl00_MyCPH1_RowAdvanceCheque").style.display == "") {
                    var rbtLstAdvanceChequeI = document.getElementById("ctl00_MyCPH1_rbtLstAdvanceCheque_0");
                    var rbtLstAdvanceChequeL = document.getElementById("ctl00_MyCPH1_rbtLstAdvanceCheque_1");
                    var txtBranchName = document.getElementById("ctl00_MyCPH1_txtBranchName");
                    var RowAdvanceChequeGrid = document.getElementById("ctl00_MyCPH1_RowAdvanceChequeGrid");
                    if (rbtLstAdvanceChequeL.checked == true) {
                        RowAdvanceChequeGrid.style.display = "none";
                        if (txtBranchName.value == "") {
                            alert("Please enter Branch code")
                            txtBranchName.focus();
                            return false;
                        }
                    }
                    if (rbtLstAdvanceChequeI.checked == true) {
                        rbtLstAdvanceChequeI.checked = true;
                        RowAdvanceChequeGrid.style.display = "block";
                    }
                }
            }


            //part new
            var txtOtherAdvance = document.getElementById("ctl00_MyCPH1_txtOtherAdvance");
            if (parseFloat(txtOtherAdvance.value) > 0) {
                if (document.getElementById("ctl00_MyCPH1_RowOtherAdvance").style.display == "") {
                    var dgOtherAdvance = document.getElementById("ctl00_MyCPH1_dgOtherAdvance");
                    var txtOtherAdvance = document.getElementById("ctl00_MyCPH1_txtOtherAdvance");
                    var totOthAmount = 0;
                    for (i = 2; i <= dgOtherAdvance.rows.length; i++) {
                        pref = "ctl00_MyCPH1_dgOtherAdvance_ctl0" + i + "_";

                        var txtPerticular = document.getElementById(pref + "txtPerticular");
                        var txtVendor = document.getElementById(pref + "txtVendor");
                        var txtReferenceNo = document.getElementById(pref + "txtReferenceNo");
                        var txtUnit = document.getElementById(pref + "txtUnit");
                        var txtAmount = document.getElementById(pref + "txtAmount");
                        if (parseFloat(txtOtherAdvance.value) > 0) {

                        }
                        if (parseFloat(txtAmount.value) >= 0) {
                            totOthAmount = parseFloat(parseFloat(totOthAmount) + parseFloat(txtAmount.value));
                        }
                    }
                    if (parseFloat(totOthAmount) > parseFloat(txtOtherAdvance.value))
                    { alert("Total other advance amount can not be greater than advance by other "); return false; }

                    if (parseFloat(totOthAmount) < parseFloat(txtOtherAdvance.value))
                    { alert("Total other advance amount can not be less than advance by other "); return false; }
                }
            

            //part new
            if (document.getElementById("ctl00_MyCPH1_RowOtherAdvance").style.display == "")
            {
                var dgOtherAdvance = document.getElementById("ctl00_MyCPH1_dgOtherAdvance");
                for (i = 2; i <= dgOtherAdvance.rows.length; i++) {
                    pref = "ctl00_MyCPH1_dgOtherAdvance_ctl0" + i + "_";
                    var txtUnit = document.getElementById(pref + "txtPerticular").value;
                    var txtUnitF = document.getElementById(pref + "txtPerticular");
                    if (txtUnit.length >= 21) {
                        alert("Perticular value length must be less than euqal to 20 character");
                        txtUnitF.focus();
                        return false;
                    }

                    if (txtUnitF.value == "") {
                        alert("Please enter Perticular")
                        txtUnitF.focus();
                        return false;
                    }

                }
                

                
                var dgOtherAdvance = document.getElementById("ctl00_MyCPH1_dgOtherAdvance");
                for (i = 2; i <= dgOtherAdvance.rows.length; i++) {
                    pref = "ctl00_MyCPH1_dgOtherAdvance_ctl0" + i + "_";
                    var txtUnit = document.getElementById(pref + "txtReferenceNo").value;
                    var txtUnitF = document.getElementById(pref + "txtReferenceNo");
                    if (txtUnit.length >= 21) {
                        alert("Reference value length must be less than euqal to 20 character");
                        txtUnitF.focus();
                        return false;
                    }
                    if (txtUnitF.value == "") {
                        alert("Please enter Reference")
                        txtUnitF.focus();
                        return false;
                    }
                }
                

                var dgOtherAdvance = document.getElementById("ctl00_MyCPH1_dgOtherAdvance");
                for (i = 2; i <= dgOtherAdvance.rows.length; i++) {
                    pref = "ctl00_MyCPH1_dgOtherAdvance_ctl0" + i + "_";
                    var txtUnit = document.getElementById(pref + "txtUnit").value;
                    var txtUnitF = document.getElementById(pref + "txtUnit");
                    if (txtUnit.length >= 21) {
                        alert("Unit value length must be less than euqal to 20 character");
                        txtUnitF.focus();
                        return false;
                    }
                    if (txtUnitF.value == "") {
                        alert("Please enter Unit")
                        txtUnitF.focus();
                        return false;
                    }
                }

                var dgOtherAdvance = document.getElementById("ctl00_MyCPH1_dgOtherAdvance");
                for (i = 2; i <= dgOtherAdvance.rows.length; i++) {
                    pref = "ctl00_MyCPH1_dgOtherAdvance_ctl0" + i + "_";
                    var txtVendor = document.getElementById(pref + "txtVendor");
                    var Search_Char = "~"
                    if (txtVendor.value.indexOf(Search_Char) == -1) {
                        alert("Invalid Vendor Name~Code Format");
                        txtVendor.focus();
                        return false
                    }
                    if (txtVendor.value == "") {
                        alert("Please enter vendor code.");
                        return false;
                    }
                }
            }}
            
            //Added anupam End

            click_count = parseFloat(document.getElementById("ctl00_MyCPH1_click_count").value)

            if (click_count > 0) {
                alert("Sorry... You cannot click twice !!!")
                return false;
            }
            else {
                click_count = click_count + 1
                document.getElementById("ctl00_MyCPH1_click_count").value = click_count
                return true;
            }
            //return true;

	    document.getElementById("ctl00_MyCPH1_btnSubmit").display = "none";
        }

        function totalcal() {
            //debugger;
            totalbalmt = 0
            var j;
            for (var i = 0; i < totdkt; i++) {
                j = i + 2;

                if (j < 10) {

                    //Form_name = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$"
                    Form_name = "ctl00_MyCPH1_dockdata_ctl" + "0" + j + "_"

                }
                else {
                    //Form_name = "ctl00$MyCPH1$dockdata$ctl" + j + "$"
                    Form_name = "ctl00_MyCPH1_dockdata_ctl" + j + "_"

                }
                totalbalmt = parseFloat(totalbalmt) + parseFloat(document.getElementById(Form_name + "indadvamt").value)
                calc();
            }
            if (totdkt > 0) {
            k = j + 1
            if (k < 10) {

                //Form_name1 = "ctl00$MyCPH1$dockdata$ctl" + "0" + k + "$"
                Form_name1 = "ctl00_MyCPH1_dockdata_ctl" + "0" + k + "_"

            }
            else {
                //Form_name1 = "ctl00$MyCPH1$dockdata$ctl" + k + "$"
                Form_name1 = "ctl00_MyCPH1_dockdata_ctl" + k + "_"

            }
            document.getElementById(Form_name1 + "TotalNetamt").value = totalbalmt
            calc();}
        }

        function calc() {
            //debugger;
            Form_name = "ctl00_MyCPH1_"
            totalbalmt = 0
            totalNetbalmt = 0
            var j;
            for (var i = 0; i < totdkt; i++) {
                j = i + 2;

                if (j < 10) {

                    Form_name = "ctl00_MyCPH1_dockdata_ctl" + "0" + j + "_"

                }
                else {
                    Form_name = "ctl00_MyCPH1_dockdata_ctl" + j + "_"

                }
                totalbalmt = parseFloat(totalbalmt) + parseFloat(document.getElementById(Form_name + "indadvamt").value)
                document.getElementById(Form_name + "indnetpay").value = parseFloat(document.getElementById(Form_name + "Hidden_indadvamt").value) + parseFloat(document.getElementById(Form_name + "NetbalAmt").value) - parseFloat(document.getElementById(Form_name + "indadvamt").value)
                totalNetbalmt = parseFloat(totalNetbalmt) + parseFloat(document.getElementById(Form_name + "indnetpay").value)
            }
            if (totdkt>0){
            k = j + 1
            if (k < 10) {

                Form_name1 = "ctl00_MyCPH1_dockdata_ctl" + "0" + k + "_"

            }
            else {
                Form_name1 = "ctl00_MyCPH1_dockdata_ctl" + k + "_"

            }
            document.getElementById(Form_name1 + "TotalNetamt").value = totalbalmt
            document.getElementById(Frmnae + "txtAdvanceAmtPaid").value = totalbalmt
            document.getElementById(Frmnae + "txtBalanceAmt").value = totalNetbalmt

            NetpaymentAmt = totalbalmt}
        }

        function ValidateForm(obj) {

            if (obj.value != "") {

                if (isDate(obj.value) == false) {

                    obj.focus()
                    return false
                }
                return true
            }
        }

        var dtCh = "/";
        var minYear = 1900;
        var maxYear = 2100;

        function DaysArray(n) {
            for (var i = 1; i <= n; i++) {
                this[i] = 31
                if (i == 4 || i == 6 || i == 9 || i == 11) { this[i] = 30 }
                if (i == 2) { this[i] = 29 }
            }
            return this
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
                alert("The date format should be : dd/mm/yyyy")
                return false
            }
            if (strMonth.length < 1 || month < 1 || month > 12) {
                alert("Please enter a valid month")
                return false
            }
            if (strDay.length < 1 || day < 1 || day > 31 || (month == 2 && day > daysInFebruary(year)) || day > daysInMonth[month]) {
                alert("Please enter a valid day")
                return false
            }
            if (strYear.length != 4 || year == 0 || year < minYear || year > maxYear) {
                alert("Please enter a valid 4 digit year between " + minYear + " and " + maxYear)
                return false
            }
            if (dtStr.indexOf(dtCh, pos2 + 1) != -1 || isInteger(stripCharsInBag(dtStr, dtCh)) == false) {
                alert("Please enter a valid date")
                return false
            }
            return true
        }

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

        function CheckVendor() {
            var dgOtherAdvance = document.getElementById("ctl00_MyCPH1_dgOtherAdvance");
            for (i = 2; i <= dgOtherAdvance.rows.length; i++) {
                pref = "ctl00$MyCPH1$dgOtherAdvance$ctl0" + i + "$";
                var txtVendor = document.getElementById(pref + "txtVendor");
                var Search_Char = "~"
                if (txtVendor.value.indexOf(Search_Char) == -1) {
                    //alert("Invalid Vendor Name~Code Format");
                    //txtVendor.focus();
                    return false
                }
                if (txtVendor.value == "") {
                    //alert("Please enter vendor code.");
                    //return false;
                }
            }
        }

        function AdvCashInstallmentAmtCalc() {
            var dgAdvanceCash = document.getElementById("ctl00_MyCPH1_dgAdvanceCash");
            var txtAdvanceCash = document.getElementById("ctl00_MyCPH1_txtAdvanceCash");
            var totInstallmentAmount = 0;
            for (i = 2; i <= dgAdvanceCash.rows.length; i++) {
                pref = "ctl00$MyCPH1$dgAdvanceCash$ctl0" + i + "$";
                var txtInstallmentAmount = document.getElementById(pref + "txtInstallmentAmount");
                if (parseFloat(txtInstallmentAmount.value) > 35000) {
                    alert("Please enter installment amount less than 35000.");
                }
                if (parseFloat(txtInstallmentAmount.value) >= 0) {
                    totInstallmentAmount = parseFloat(parseFloat(totInstallmentAmount) + parseFloat(txtInstallmentAmount.value));
                }
            }
        }

        function AdvChqAmountAmtCalc() {
            var dgAdvanceCheque = document.getElementById("ctl00_MyCPH1_dgAdvanceCheque");
            var txtAdvanceCheque = document.getElementById("ctl00_MyCPH1_txtAdvanceCheque");
            var rbtLstAdvanceCheque = document.getElementById("ctl00_MyCPH1_rbtLstAdvanceCheque");
            var txtBranchName = document.getElementById("ctl00_MyCPH1_txtBranchName");
            var txtVarChqAmt = document.getElementById("ctl00_MyCPH1_txtVarChqAmt");
            var totChqAmount = 0;
            for (i = 2; i <= dgAdvanceCheque.rows.length; i++) {
                pref = "ctl00$MyCPH1$dgAdvanceCheque$ctl0" + i + "$";
                var txtAmount = document.getElementById(pref + "txtAmount");

                if (parseFloat(txtAmount.value) >= 0) {
                    totChqAmount = parseFloat(parseFloat(totChqAmount) + parseFloat(txtAmount.value));
                }
            }
            if (parseFloat(totChqAmount) < parseFloat(txtAdvanceCheque.value))
            {
                txtBranchName.disabled = false;
                txtVarChqAmt.value = parseFloat(parseFloat(txtAdvanceCheque.value) - parseFloat(totChqAmount));
            }
            if (parseFloat(totChqAmount) == parseFloat(txtAdvanceCheque.value))
            {
                txtBranchName.disabled = true;
                txtVarChqAmt.value = parseFloat(parseFloat(txtAdvanceCheque.value) - parseFloat(totChqAmount));
            }
        }

        function PerticularLen() {
            var dgOtherAdvance = document.getElementById("ctl00_MyCPH1_dgOtherAdvance");
            for (i = 2; i <= dgOtherAdvance.rows.length; i++) {
                pref = "ctl00$MyCPH1$dgOtherAdvance$ctl0" + i + "$";
                var txtUnit = document.getElementById(pref + "txtPerticular").value;
                var txtUnitF = document.getElementById(pref + "txtPerticular");
                if (txtUnit.length > 20) {
                    //alert("Perticular value length must be greater than 10 character");
                    //txtUnitF.focus();
                    return false;
                }
            }
        }

        function ReferenceNoLen() {
            var dgOtherAdvance = document.getElementById("ctl00_MyCPH1_dgOtherAdvance");
            for (i = 2; i <= dgOtherAdvance.rows.length; i++) {
                pref = "ctl00$MyCPH1$dgOtherAdvance$ctl0" + i + "$";
                var txtUnit = document.getElementById(pref + "txtReferenceNo").value;
                var txtUnitF = document.getElementById(pref + "txtReferenceNo");
                if (txtUnit.length > 20) {
                    //alert("Reference value length must be greater than 10 character");
                    //txtUnitF.focus();
                    return false;
                }
            }
        }

        function UnitLen() {
            var dgOtherAdvance = document.getElementById("ctl00_MyCPH1_dgOtherAdvance");
            for (i = 2; i <= dgOtherAdvance.rows.length; i++) {
                pref = "ctl00$MyCPH1$dgOtherAdvance$ctl0" + i + "$";
                var txtUnit = document.getElementById(pref + "txtUnit").value;
                var txtUnitF = document.getElementById(pref + "txtUnit");
                if (txtUnit.length > 20) {
                    //alert("Unit value length must be greater than 10 character");
                    //txtUnitF.focus();
                    return false;
                }
            }
        }

        function AdvOthAmountAmtCalc() {
            var dgOtherAdvance = document.getElementById("ctl00_MyCPH1_dgOtherAdvance");
            var totOthAmount = 0;
            for (i = 2; i <= dgOtherAdvance.rows.length; i++) {
                pref = "ctl00$MyCPH1$dgOtherAdvance$ctl0" + i + "$";
                var txtAmount = document.getElementById(pref + "txtAmount");

                if (parseFloat(txtAmount.value) >= 0) {
                    totOthAmount = parseFloat(parseFloat(totOthAmount) + parseFloat(txtAmount.value));
                }
            } 
        }

        function advanceChequeRadioButton() {
            var rbtLstAdvanceChequeI = document.getElementById("ctl00_MyCPH1_rbtLstAdvanceCheque_0");
            var rbtLstAdvanceChequeL = document.getElementById("ctl00_MyCPH1_rbtLstAdvanceCheque_1");
            var txtBranchName = document.getElementById("ctl00_MyCPH1_txtBranchName");
            var RowAdvanceChequeGrid = document.getElementById("ctl00_MyCPH1_RowAdvanceChequeGrid");
            var txtAdvanceCheque = document.getElementById("ctl00_MyCPH1_txtAdvanceCheque");
            var txtVarChqAmt = document.getElementById("ctl00_MyCPH1_txtVarChqAmt");
            if (rbtLstAdvanceChequeL.checked == true) { txtBranchName.disabled = false; txtVarChqAmt.value = txtAdvanceCheque.value; }
            if (rbtLstAdvanceChequeI.checked == true) { txtBranchName.disabled = true; AdvChqAmountAmtCalc();}
            if (rbtLstAdvanceChequeL.checked == true) {
                RowAdvanceChequeGrid.style.display = "none";
                if (txtBranchName.value == "") {
                    //txtBranchName.disabled = false;
                    //alert("Please enter Branch code")
                    //txtBranchName.focus();
                rbtLstAdvanceChequeL.checked = true;
                rbtLstAdvanceChequeI.checked = false;
                    return false;
                }
                rbtLstAdvanceChequeL.checked = true;
                rbtLstAdvanceChequeI.checked = false;
            }
            if (rbtLstAdvanceChequeI.checked == true) {
                rbtLstAdvanceChequeI.checked = true;
                rbtLstAdvanceChequeL.checked = false;
                RowAdvanceChequeGrid.style.display = "block";
            }
            return true;
        }

        function CheckDate() {
            var txtDate = document.getElementById("ctl00_MyCPH1_dgAdvanceCheque_ctl02_txtDate");
            if (txtDate.value != "") {
                if (!isDate(txtDate.value)) {
                    alert("Invalid Date!!!");
                    txtDate.value = "";
                    txtDate.focus();
                    return false;
                }
            }
        }

        var currentTime = new Date()

        function createXMLHttpRequest() {
            // Mozilla, Safari,...
            if (window.XMLHttpRequest) { xmlHttpRequest = new XMLHttpRequest(); if (xmlHttpRequest.overrideMimeType) xmlHttpRequest.overrideMimeType("text/xml"); }
                // IE
            else if (window.ActiveXObject) { try { xmlHttpRequest = new ActiveXObject("Msxml2.XMLHTTP"); } catch (e) { try { xmlHttpRequest = new ActiveXObject("Microsoft.XMLHTTP"); } catch (e) { } } }
        }

        function CheckValidBranchCode(txtBranchCode) {
            var txtBranchName = document.getElementById("ctl00_MyCPH1_txtBranchName");
            createXMLHttpRequest();
            if (xmlHttpRequest) {
                xmlHttpRequest.onreadystatechange = function () {
                    if (xmlHttpRequest.readyState == 4) {
                        var returnValue = xmlHttpRequest.responseText.split("~");;
                        if (returnValue[0] == "N") {
                            alert("Invalid Branch Code!  Please Enter Valid Branch code!!");
                            //txtBranchCode.focus();
txtBranchName.value = "";
                            return false;
                        }
                    }
                }
                xmlHttpRequest.open("GET", "../../../../Fleet/Operations/Issue/AJAX_Validator/AjaxResponse.aspx?Function=CheckValidBranchCode&datetime=" + currentTime + "&BranchCode=" + txtBranchCode.value, false);
                xmlHttpRequest.send(null);
            }
        }

    </script>

    <br />
    <div align="left">
        <table border="0" style="width: 9.5in" bgcolor="#808080" cellpadding="2" cellspacing="1"
            class="boxbg">
            <asp:HiddenField ID="click_count" runat="server" Value="0" />
            <asp:HiddenField ID="HdnThcNo" runat="server" Value="0" />
            <tr bgcolor="#FFFFFF">
                <td colspan="2"><asp:Label ID="lblError" runat="server" Font-Bold="True" Text="" CssClass="redfnt"></asp:Label></td>
                
            </tr>
            <tr bgcolor="#FFFFFF">
                <td align="center" colspan="2">
                    <font face="verdana" size="3"><b>Trip Hire Contract (THC)</b></font>
                </td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td align="right" style="width: 2in">
                    <font class="blackfnt">&nbsp;Voucher Date &nbsp;&nbsp;&nbsp;</font>
                </td>
                <td align="left">
                    <font class="bluefnt">
                        <asp:TextBox ID="txtVoucherDate" Enabled="true" runat="server" Width="60px" Columns="8"></asp:TextBox>
                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtVoucherDate,'anchor1','dd/MM/yyyy'); return false;"
                            name="anchor1" id="a1">
                            <img src="../../../../images/calendar.jpg" border="0" />
                        </a>dd/mm/yyyy </font>
                    <asp:HiddenField ID="HdnThcVendorCode" runat="server" Value="0" />
                </td>
            </tr>
        </table>
        <table border="0" style="width: 9.5in" bgcolor="#808080" cellpadding="2" cellspacing="1"
            class="boxbg">
            <tr bgcolor="#FFFFFF">
                <td colspan="2" valign="top" style="width: 53%">
                    <table border="1" width="100%">
                        <tr>
                            <td align="left" style="width: 160px">
                                <font class="blackfnt">Standard Contract Amount</font>
                            </td>
                            <td align="left" style="width: 13px">
                                <font class="bluefnt">
                                    <asp:Label ID="lblStandardAmt" runat="server" Text="Label"></asp:Label></font>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 160px">
                                <font class="blackfnt">Contract Amount (+)</font>
                            </td>
                            <td align="left" style="width: 13px">
                                <font class="blackfnt">
                                    <asp:TextBox ID="txtContractAmt" runat="server" Enabled="false" Width="70px"></asp:TextBox></font>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 160px">
                                <font class="blackfnt">Other Amount</font>
                            </td>
                            <td align="left" style="width: 13px">
                                <font class="blackfnt">
                                    <asp:TextBox ID="txtOtherAmt" runat="server" Enabled="false" Width="70px"></asp:TextBox></font>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 160px">
                                <font class="blackfnt">TDS Amount (-)</font>
                            </td>
                            <td align="left" style="width: 13px">
                                <font class="blackfnt">
                                    <asp:TextBox ID="txtTDSAmt" runat="server" Enabled="false" Width="70px"></asp:TextBox></font>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 160px">
                                <font class="blackfnt">Service Tax (+)</font>
                            </td>
                            <td align="left" style="width: 13px">
                                <font class="blackfnt">
                                    <asp:TextBox ID="txtServiceTax" runat="server" Enabled="false" Width="70px"></asp:TextBox></font>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 160px">
                                <font class="blackfnt">Cess (+)</font>
                            </td>
                            <td align="left" style="width: 13px">
                                <font class="blackfnt">
                                    <asp:TextBox ID="cessamt" runat="server" Enabled="false" Width="70px"></asp:TextBox></font>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 160px">
                                <font class="blackfnt">Higher Edu. Cess (+)</font>
                            </td>
                            <td align="left" style="width: 13px">
                                <font class="blackfnt">
                                    <asp:TextBox ID="H_cessamt" runat="server" Enabled="false" Width="70px"></asp:TextBox></font>
                            </td>
                        </tr>
                    </table>
                </td>
                <td colspan="2" width="50%" valign="top">
                    <table border="1" width="100%">
                        <tr>
                            <td align="left">
                                <font class="blackfnt">PAN No</font>
                            </td>
                            <td align="left" bgcolor="#FFFFFF">
                                <font class="blackfnt">
                                    <asp:TextBox ID="txtPANNO" runat="server" Enabled="true" Width="70px"></asp:TextBox></font>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <font class="blackfnt">Advance Amount Paid by</font>
                            </td>
                            <td align="left">
                                <font class="blackfnt">
                                    <asp:TextBox ID="txtAdvanceAmtPaidBy" runat="server" Enabled="false" Width="136px"></asp:TextBox></font>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <font class="blackfnt">TDS type</font>
                            </td>
                            <td align="left">
                                <font class="blackfnt">
                                    <asp:DropDownList ID="cboTDSType" runat="server" Mode="Conditional" RenderMode="Inline"
                                        Width="152px">
                                        <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                    </asp:DropDownList>
                                </font>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" bgcolor="#FFFFFF">
                                <font class="blackfnt">TDS Deducted For</font>
                            </td>
                            <td align="left" bgcolor="#FFFFFF">
                                <asp:DropDownList ID="cboTDSDeducted" runat="server" Mode="Conditional" RenderMode="Inline"
                                    Width="152px">
                                    <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Corporate" Value="C"></asp:ListItem>
                                    <asp:ListItem Text="NonCorporate" Value="NC"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <font class="blackfnt">Advance Paid </font>
                            </td>
                            <td align="left">
                                <font class="blackfnt">
                                    <asp:TextBox ID="txtAdvanceAmtPaid" runat="server" Enabled="false" Width="70px"></asp:TextBox></font>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <font class="blackfnt"><b>Balance Amount</b></font>
                            </td>
                            <td align="left" bgcolor="#FFFFFF">
                                <font class="blackfnt">
                                    <asp:TextBox ID="txtBalanceAmt" runat="server" Enabled="false" Width="70px" EnableViewState="true"></asp:TextBox></font>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <font class="blackfnt"><b>Balance Payable at</b></font>
                            </td>
                            <td align="left" bgcolor="#FFFFFF">
                                <font class="blackfnt">
                                    <asp:TextBox ID="txtBalancePayableAt" runat="server" Enabled="false" Width="70px"></asp:TextBox></font>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </div>
        <br />
        <p align="left">
            &nbsp;&nbsp;&nbsp;&nbsp;<font class="blackfnt"><b><u>Note :</u></b> Please enter the
                payment details if advance amount >0 .</font>
        </p>
        <br />
        <div align="left">
            <asp:GridView ID="dockdata" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
                AllowSorting="true" AllowPaging="true" PageSize="1000" PagerStyle-HorizontalAlign="left"
                CssClass="boxbg" BackColor="white" FooterStyle-CssClass="bgbluegrey" ShowFooter="True"
                PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]"
                PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..." Style="width: 9.5in">
                <Columns>
                    <asp:TemplateField HeaderText="SRNo.">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" />
                        <ItemTemplate>
                            <asp:Label ID="lblSRNo" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="DocumentNo" CssClass="blackfnt" Text="DocumentNo" runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="thcno" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"dockno") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblcontractAmt" Style="text-align: center" CssClass="blackfnt" Text="Contract Amount (+)"
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:TextBox ID="indpcamt" runat="server" Enabled="false" MaxLength="10" Columns="6"
                                    Text='<%# DataBinder.Eval(Container.DataItem,"PCAMT") %>'></asp:TextBox>
                                <asp:HiddenField runat="server" ID="thcdate" Value='<%# DataBinder.Eval(Container.DataItem,"thcdate") %>' />
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblOtherAmt" Style="text-align: center" CssClass="blackfnt" Text="Other Amount(+) "
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:TextBox ID="indothamt" MaxLength="10" Columns="6" Enabled="false" runat="server"
                                    Text='<%# DataBinder.Eval(Container.DataItem,"OTHCHRG") %>'></asp:TextBox>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblTDSRate" Style="text-align: center" CssClass="blackfnt" Text="TDS Rate"
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:TextBox ID="indtds_rate" MaxLength="10" Enabled="false" Columns="6" runat="server"
                                    Text='<%# DataBinder.Eval(Container.DataItem,"tds_rate") %>'></asp:TextBox>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblTDSdeduction" Style="text-align: center" CssClass="blackfnt" Text="TDS Dedn.(-)"
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:TextBox ID="indtdsded" MaxLength="10" Enabled="false" Columns="6" runat="server"
                                    Text='<%# DataBinder.Eval(Container.DataItem,"tdsded") %>'></asp:TextBox>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblunexpamt" Style="text-align: center" CssClass="blackfnt" Text="Service Tax Rate"
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:TextBox ID="cboindsvctaxrate" MaxLength="10" Columns="6" Enabled="false" runat="server"
                                    Text='<%# DataBinder.Eval(Container.DataItem,"svrc_rate") %>'></asp:TextBox>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblServiceTax" Style="text-align: center" CssClass="blackfnt" Text="Service Tax (+) "
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:TextBox ID="indsvctax" MaxLength="10" Enabled="false" Columns="6" runat="server"
                                    Text='<%# DataBinder.Eval(Container.DataItem,"SVCTAX") %>'></asp:TextBox>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblcess" Style="text-align: center" CssClass="blackfnt" Text="Cess (+) "
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:TextBox ID="indcess" MaxLength="10" Enabled="false" Columns="6" runat="server"
                                    Text='<%# DataBinder.Eval(Container.DataItem,"CESSAMT") %>'></asp:TextBox>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lbl_H_cess" Style="text-align: center" CssClass="blackfnt" Text="Higher Edu. Cess (+) "
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:TextBox ID="ind_H_cess" MaxLength="10" Enabled="false" Columns="6" runat="server"
                                    Text='<%# DataBinder.Eval(Container.DataItem,"HEDU_CESS") %>'></asp:TextBox>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblAdvamt" Style="text-align: center" CssClass="blackfnt" Text=" Advance Amt. (-) "
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:TextBox ID="indadvamt" MaxLength="10" onblur="javascript:calc()" Columns="6"
                                    runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"ADVAMT") %>' Enabled="false"></asp:TextBox>
                                <asp:HiddenField ID="NetbalAmt" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"netbalamt") %>' />
                                <asp:HiddenField ID="Hidden_indadvamt" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"ADVAMT") %>' />
                                <asp:HiddenField ID="Advance_paid" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"Advance_paid") %>' />
                            </center>
                        </ItemTemplate>
                        <FooterTemplate>
                            <center>
                                <asp:TextBox ID="TotalNetamt" Font-Bold="true" runat="server" Enabled="false" Text="0.00"
                                    Columns="6"></asp:TextBox>
                            </center>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblNetPayable" Style="text-align: center" CssClass="blackfnt" Text="Net Balance Amt."
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:TextBox ID="indnetpay" Enabled="false" MaxLength="10" Columns="6" runat="server"
                                    Text='<%# DataBinder.Eval(Container.DataItem,"NET") %>'></asp:TextBox>
                                <asp:HiddenField ID="vendor_code" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"vendor_code")%>' />
                                <asp:HiddenField ID="vendor_Name" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"vendor_Name")%>' />
                                <asp:HiddenField ID="pan_no" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"pan_no")%>' />
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <RowStyle />
                <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                <HeaderStyle CssClass="bgbluegrey" />
                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                <FooterStyle CssClass="bgbluegrey" />
            </asp:GridView>
        </div>
        <br />
        <div align="left">
        <table cellspacing="1" class="boxbg" style="width: 9.5in">
            <tr class="blackfnt" bgcolor="#ffffff">
                <td align="left" style="width: 199px">Advance Cash</td>
                <td align="left">
                    <asp:TextBox Width="70px" Style="text-align: right;" Text="0.00"
                        ID="txtAdvanceCash" runat="server" Enabled="false"></asp:TextBox>
                </td>
            </tr>
            <tr class="blackfnt" bgcolor="#ffffff" runat="server" id="RowAdvanceCash">
                <td colspan="2">
                    <table id="Table2" cellspacing="1" class="boxbg" runat="server"
                        style="width: 9.5in">
                        <tr class="blackfnt" bgcolor="#ffffff">
                            <td>
                                <table cellspacing="1" class="boxbg" border="0" style="width: 9.5in">
                                    <tr class="bgbluegrey">
                                        <td width="75%">
                                            <asp:Label ID="Label6" CssClass="blackfnt" Font-Bold="true" runat="server" Width="500px">Advance Cash Installments</asp:Label>
                                        </td>
                                        <td width="5%">
                                            <asp:Panel ID="pnlAdvanceCashHdr" runat="server" Width="25px">
                                                <asp:Label ID="lblTripHdrError" runat="server" Font-Bold="True">Show...</asp:Label>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                                <table cellspacing="1" align="left" style="width: 9.5in">
                                    <tr align="center">
                                        <td align="left">
                                            <asp:Panel ID="pnlAdvanceCashDet" runat="server">
                                                <table cellspacing="1" style="width: 9.5in">
                                                    <tr>
                                                        <td align="left">
                                                            <asp:UpdatePanel ID="UPAddRow" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                                                                <ContentTemplate>
                                                                    <asp:LinkButton ID="AddRow" runat="server" Text="+" CssClass="blackfnt" Font-Bold="true"
                                                                        CausesValidation="false" OnClick="AddNewRowAdvanceCash">
                                                                    </asp:LinkButton>&nbsp;
                                                                </ContentTemplate>
                                                            </asp:UpdatePanel>
                                                            <asp:Label ID="lblAddRec" runat="server" Text="Add Row" CssClass="bluefnt"></asp:Label>
                                                            <asp:Label ID="lblNB" runat="server" Text="[Max 10 Series]" Font-Italic="true" CssClass="redfnt"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr style="background-color: white">
                                                        <td align="left">
                                                            <asp:UpdatePanel ID="UpdatePanel2" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                                                <ContentTemplate>
                                                                    <asp:GridView EnableViewState="true" ID="dgAdvanceCash" runat="server" BorderWidth="1"
                                                                        HeaderStyle-CssClass="dgHeaderStyle" AllowSorting="true" AutoGenerateColumns="false"
                                                                        CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8ba0e5" CellSpacing="2" CellPadding="2"
                                                                        OnRowDataBound="dg_RowDataBoundAdvanceCash" OnRowCommand="dg_RowCommandAdvanceCash" OnRowCreated="dg_RowCreatedAdvanceCash">
                                                                        <Columns>
                                                                            <asp:TemplateField>
                                                                                <ItemTemplate>
                                                                                    <asp:LinkButton ID="DeleteRow" ToolTip="Delete This Row" runat="server" CausesValidation="false"
                                                                                        Text="X"></asp:LinkButton>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Sr.No" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                                                                <ItemTemplate>
                                                                                    <asp:Label EnableViewState="true" ID="lblSrNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "SrNoAC")%>' />
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Installment Amount" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox EnableViewState="true" ID="txtInstallmentAmount" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "InstallmentAmount")%>'
                                                                                        Width="80" MaxLength="25" CssClass="input" ></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="RFVSeriesFrom" ControlToValidate="txtInstallmentAmount" runat="server" CssClass="redfnt" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                        <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                                                                        <HeaderStyle CssClass="dgHeaderStyle" />
                                                                    </asp:GridView>
                                                                </ContentTemplate>
                                                                <Triggers>
                                                                    <asp:AsyncPostBackTrigger ControlID="AddRow" EventName="Click" />
                                                                </Triggers>
                                                            </asp:UpdatePanel>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                            <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender2" runat="Server"
                                                TargetControlID="pnlAdvanceCashDet" Collapsed="true" ExpandControlID="pnlAdvanceCashHdr"
                                                CollapseControlID="pnlAdvanceCashHdr" AutoCollapse="False" TextLabelID="lblTripHdrError"
                                                CollapsedText="Show" ExpandedText="Hide" ExpandDirection="Vertical" SuppressPostBack="true" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr class="blackfnt" bgcolor="#ffffff">
                <td align="left" style="width: 199px">Advance Cheque</td>
                <td align="left">
                    <asp:TextBox Width="70px" Style="text-align: right;" Text="0.00"
                        ID="txtAdvanceCheque" runat="server" Enabled="false"></asp:TextBox>
                </td>
            </tr>
            <tr class="blackfnt" bgcolor="#ffffff" runat="server" id="RowAdvanceCheque">
                <td align="left" style="width: 199px">Advance Cheque Installments</td>
                <td align="left">
                    <table cellspacing="1" class="boxbg" style="width: 100%">
                        <tr class="blackfnt" bgcolor="#ffffff">
                            <td style="width: 120px">
                                <div>
                                    <asp:RadioButtonList ID="rbtLstAdvanceCheque" runat="server"
                                        RepeatDirection="Horizontal" RepeatLayout="Table" onclick="javascript:advanceChequeRadioButton()">
                                        <asp:ListItem Text="Immediately" Value="I" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="Later" Value="L"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                            </td>
                            <td align="left" runat="server" style="width:80px">Branch Name</td>
                            <td align="left" style="width:130px">
                                <asp:TextBox Width="100px" Style="text-align: left;"
                                    ID="txtBranchName" runat="server" onBlur="CheckValidBranchCode(this)" Enabled="false"> </asp:TextBox>
                            </td>
                             <td align="left" style="width:60px">
                                <asp:TextBox Width="60px" Style="text-align: left;"
                                    ID="txtVarChqAmt" runat="server"  Enabled="false"> </asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr class="blackfnt" bgcolor="#ffffff" runat="server" id="RowAdvanceChequeGrid">
                <td colspan="2">
                    <table id="Table1" cellspacing="1" class="boxbg" runat="server"
                        style="width: 9.5in">
                        <tr class="blackfnt" bgcolor="#ffffff">
                            <td>
                                <table cellspacing="1" class="boxbg" border="0" style="width: 9.5in">
                                    <tr class="bgbluegrey">
                                        <td width="75%">
                                            <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server" Width="500px">Advance Cheque Installments</asp:Label>
                                        </td>
                                        <td width="5%">
                                            <asp:Panel ID="pnlAdvanceChequeHdr" runat="server" Width="25px">
                                                <asp:Label ID="lblAdvanceChequeHdrError" runat="server" Font-Bold="True">Show...</asp:Label>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                                <table cellspacing="1" align="left" style="width: 9.5in">
                                    <tr align="center">
                                        <td align="left">
                                            <asp:Panel ID="pnlAdvanceChequeDet" runat="server">
                                                <table cellspacing="1" style="width: 9.5in">
                                                    <tr>
                                                        <td align="left">
                                                            <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                                                                <ContentTemplate>
                                                                    <asp:LinkButton ID="AddRowAdvanceCheque" runat="server" Text="+" CssClass="blackfnt" Font-Bold="true"
                                                                        CausesValidation="false" OnClick="AddNewRowAdvanceCheque">
                                                                    </asp:LinkButton>&nbsp;
                                                                </ContentTemplate>
                                                            </asp:UpdatePanel>
                                                            <asp:Label ID="lblAddRecAdvanceCheque" runat="server" Text="Add Row" CssClass="bluefnt"></asp:Label>
                                                            <asp:Label ID="lblNBAdvanceCheque" runat="server" Text="[Max 10 Series]" Font-Italic="true" CssClass="redfnt"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr style="background-color: white">
                                                        <td align="left">
                                                            <asp:UpdatePanel ID="UpdatePanel4" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                                                <ContentTemplate>
                                                                    <asp:GridView EnableViewState="true" ID="dgAdvanceCheque" runat="server" BorderWidth="1"
                                                                        HeaderStyle-CssClass="dgHeaderStyle" AllowSorting="true" AutoGenerateColumns="false"
                                                                        CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8ba0e5" CellSpacing="2" CellPadding="2"
                                                                        OnRowDataBound="dg_RowDataBoundAdvanceCheque" OnRowCommand="dg_RowCommandAdvanceCheque" OnRowCreated="dg_RowCreatedAdvanceCheque">
                                                                        <Columns>
                                                                            <asp:TemplateField>
                                                                                <ItemTemplate>
                                                                                    <asp:LinkButton ID="DeleteRow" ToolTip="Delete This Row" runat="server" CausesValidation="false"
                                                                                        Text="X"></asp:LinkButton>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Sr.No" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                                                                <ItemTemplate>
                                                                                    <asp:Label EnableViewState="true" ID="lblSrNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "SrNoAdvChq")%>' />
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Cheque No" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox EnableViewState="true" ID="txtChequeNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ChequeNo")%>'
                                                                                        Width="60" MaxLength="25" CssClass="input"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="RFVChequeNo" ControlToValidate="txtChequeNo" runat="server" CssClass="redfnt" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>

                                                                            <asp:TemplateField HeaderText="Bank Name" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false" ControlStyle-Width="200">
                                                                                <ItemTemplate>
                                                                                    <%--<asp:TextBox EnableViewState="true" ID="txtBankName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "BankName")%>'
                                                                                        Width="80" MaxLength="25" CssClass="input"></asp:TextBox>--%>
                                                                                    <asp:DropDownList ID="cboBankName" runat="server" Visible="true" DataTextField="CodeDesc" DataValueField="CodeID" AutoPostBack="true" />
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>

                                                                            <asp:TemplateField HeaderText="Date" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox EnableViewState="true" ID="txtDate" onblur="CheckDate()" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Date")%>'
                                                                                        Width="70" MaxLength="25" CssClass="input"></asp:TextBox>
                                                                                    <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" Format="dd/MM/yyyy" TargetControlID="txtDate"
                                                                                        runat="server" />
                                                                                    <asp:RegularExpressionValidator ID="REVAdvDt" runat="server" ControlToValidate="txtDate"
                                                                                        ErrorMessage="!" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                                                                        Width="1px"></asp:RegularExpressionValidator>
                                                                                    <asp:RequiredFieldValidator ID="RFVDate" ControlToValidate="txtDate" runat="server" CssClass="redfnt" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>

                                                                            <asp:TemplateField HeaderText="Amount" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox EnableViewState="true" ID="txtAmount" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Amount")%>'
                                                                                        Width="70" MaxLength="25" CssClass="input" onblur="checkDecimal(this.getAttribute('id'), 'TRUE')"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="RFVAmount" ControlToValidate="txtAmount" runat="server" CssClass="redfnt" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>

                                                                            <asp:TemplateField HeaderText="Favour" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox EnableViewState="true" ID="txtFavour" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Favour")%>'
                                                                                        Width="90" MaxLength="100" CssClass="input"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="RFVFavour" ControlToValidate="txtFavour" runat="server" CssClass="redfnt" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>

                                                                            <asp:TemplateField HeaderText="Card No" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox EnableViewState="true" ID="txtCardNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "CardNo")%>'
                                                                                        Width="90" MaxLength="50" CssClass="input"></asp:TextBox>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>

                                                                            <asp:TemplateField HeaderText="Card Type" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox EnableViewState="true" ID="txtCardType" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "CardType")%>'
                                                                                        Width="90" MaxLength="50" CssClass="input"></asp:TextBox>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>

                                                                        </Columns>
                                                                        <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                                                                        <HeaderStyle CssClass="dgHeaderStyle" />
                                                                    </asp:GridView>
                                                                </ContentTemplate>
                                                                <Triggers>
                                                                    <asp:AsyncPostBackTrigger ControlID="AddRowAdvanceCheque" EventName="Click" />
                                                                </Triggers>
                                                            </asp:UpdatePanel>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                            <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="Server"
                                                TargetControlID="pnlAdvanceChequeDet" Collapsed="true" ExpandControlID="pnlAdvanceChequeHdr"
                                                CollapseControlID="pnlAdvanceChequeHdr" AutoCollapse="False" TextLabelID="lblAdvanceChequeHdrError"
                                                CollapsedText="Show" ExpandedText="Hide" ExpandDirection="Vertical" SuppressPostBack="true" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr class="blackfnt" bgcolor="#ffffff">
                <td align="left" style="width: 199px">Other Advance</td>
                <td align="left">
                    <asp:TextBox Width="70px" Style="text-align: right;" Text="0.00"
                        ID="txtOtherAdvance" runat="server" Enabled="false"></asp:TextBox>
                </td>
            </tr>
            <tr class="blackfnt" bgcolor="#ffffff" runat="server" id="RowOtherAdvance">
                <td colspan="2">
                    <table id="Table3" cellspacing="1" class="boxbg" runat="server"
                        style="width: 9.5in">
                        <tr class="blackfnt" bgcolor="#ffffff">
                            <td>
                                <table cellspacing="1" class="boxbg" border="0" style="width: 9.5in">
                                    <tr class="bgbluegrey">
                                        <td width="75%">
                                            <asp:Label ID="Label2" CssClass="blackfnt" Font-Bold="true" runat="server" Width="500px">Other Advance Installments</asp:Label>
                                        </td>
                                        <td width="5%">
                                            <asp:Panel ID="pnlOtherAdvanceHdr" runat="server" Width="25px">
                                                <asp:Label ID="lblOtherAdvanceHdrError" runat="server" Font-Bold="True">Show...</asp:Label>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                                <table cellspacing="1" align="left" style="width: 9.5in">
                                    <tr align="center">
                                        <td align="left">
                                            <asp:Panel ID="pnlOtherAdvanceDet" runat="server">
                                                <table cellspacing="1" style="width: 9.5in">
                                                    <tr>
                                                        <td align="left">
                                                            <asp:UpdatePanel ID="UpdatePanel5" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                                                                <ContentTemplate>
                                                                    <asp:LinkButton ID="AddRowOtherAdvance" runat="server" Text="+" CssClass="blackfnt" Font-Bold="true"
                                                                        CausesValidation="false" OnClick="AddNewRowOtherAdvance">
                                                                    </asp:LinkButton>&nbsp;
                                                                </ContentTemplate>
                                                            </asp:UpdatePanel>
                                                            <asp:Label ID="lblAddRecOtherAdvance" runat="server" Text="Add Row" CssClass="bluefnt"></asp:Label>
                                                            <asp:Label ID="lblNBOtherAdvance" runat="server" Text="[Max 10 Series]" Font-Italic="true" CssClass="redfnt"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr style="background-color: white">
                                                        <td align="left">
                                                            <asp:UpdatePanel ID="UpdatePanel6" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                                                <ContentTemplate>
                                                                    <asp:GridView EnableViewState="true" ID="dgOtherAdvance" runat="server" BorderWidth="1"
                                                                        HeaderStyle-CssClass="dgHeaderStyle" AllowSorting="true" AutoGenerateColumns="false"
                                                                        CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8ba0e5" CellSpacing="2" CellPadding="2"
                                                                        OnRowDataBound="dg_RowDataBoundOtherAdvance" OnRowCommand="dg_RowCommandOtherAdvance" OnRowCreated="dg_RowCreatedOtherAdvance">
                                                                        <Columns>
                                                                            <asp:TemplateField>
                                                                                <ItemTemplate>
                                                                                    <asp:LinkButton ID="DeleteRow" ToolTip="Delete This Row" runat="server" CausesValidation="false"
                                                                                        Text="X"></asp:LinkButton>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Sr.No" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                                                                <ItemTemplate>
                                                                                    <asp:Label EnableViewState="true" ID="lblSrNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "SrNoOA")%>' />
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Particular" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox EnableViewState="true" ID="txtPerticular" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Perticular")%>'
                                                                                        Width="80" MaxLength="20" CssClass="input"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="RFVPerticular" ControlToValidate="txtPerticular" runat="server" CssClass="redfnt" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>

                                                                            <asp:TemplateField HeaderText="Vendor" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox EnableViewState="true" ID="txtVendor" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Vendor")%>'
                                                                                        Width="200"  CssClass="input"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="RFVVendor" ControlToValidate="txtVendor" runat="server" CssClass="redfnt" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                                                    <ajaxToolkit:AutoCompleteExtender ID="Ext1" runat="server" Enabled="True" CompletionListItemCssClass="autocomplete_listItem"
                                                                                        CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                                                                                        ServiceMethod="AutoOtherVendorThc" ServicePath="../../../../../services/WebService.asmx" TargetControlID="txtVendor">
                                                                                    </ajaxToolkit:AutoCompleteExtender>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>

                                                                            <asp:TemplateField HeaderText="ReferenceNo" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox EnableViewState="true" ID="txtReferenceNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ReferenceNo")%>'
                                                                                        Width="80" MaxLength="20" CssClass="input"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="RFVReferenceNo" ControlToValidate="txtReferenceNo" runat="server" CssClass="redfnt" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>

                                                                            <asp:TemplateField HeaderText="Unit" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox EnableViewState="true" ID="txtUnit" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Unit")%>'
                                                                                        Width="80" MaxLength="20" CssClass="input"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="RFVUnit" ControlToValidate="txtUnit" runat="server" CssClass="redfnt" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>

                                                                            <asp:TemplateField HeaderText="Amount" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox EnableViewState="true" ID="txtAmount" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Amount")%>'
                                                                                        Width="80" MaxLength="25" CssClass="input" onblur="checkDecimal(this.getAttribute('id'), 'TRUE')"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="RFVAmount" ControlToValidate="txtAmount" runat="server" CssClass="redfnt" ErrorMessage="*"></asp:RequiredFieldValidator>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>

                                                                        </Columns>
                                                                        <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                                                                        <HeaderStyle CssClass="dgHeaderStyle" />
                                                                    </asp:GridView>
                                                                </ContentTemplate>
                                                                <Triggers>
                                                                    <asp:AsyncPostBackTrigger ControlID="AddRowOtherAdvance" EventName="Click" />
                                                                </Triggers>
                                                            </asp:UpdatePanel>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                            <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender3" runat="Server"
                                                TargetControlID="pnlOtherAdvanceDet" Collapsed="true" ExpandControlID="pnlOtherAdvanceHdr"
                                                CollapseControlID="pnlOtherAdvanceHdr" AutoCollapse="False" TextLabelID="lblOtherAdvanceHdrError"
                                                CollapsedText="Show" ExpandedText="Hide" ExpandDirection="Vertical" SuppressPostBack="true" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr class="blackfnt" bgcolor="#ffffff">
                <td align="left" style="width: 199px">Total Advance</td>
                <td align="left">
                    <asp:TextBox Width="70px" Style="text-align: right;" Text="0.00"
                        ID="txtTotalAdvance" runat="server" Enabled="false"></asp:TextBox>
                </td>
            </tr>
        </table>
        </div>
        <br />
        <%--<table border="0" cellspacing="1" cellpadding="4" style="width: 9.5in" class="boxbg">
            <tr class="bgbluegrey">
                <td colspan="4" align="center">
                    <font class="blackfnt">Payment Details</font>
                </td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td align="left">
                    <font class="blackfnt">Mode Of Transaction </font>
                </td>
                <td align="left">
                    <font class="blackfnt">
                        <asp:UpdatePanel ID="u1" runat="server">
                            <ContentTemplate>
                                <asp:DropDownList ID="cboModeOfTransaction" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cboModeOfTransaction_SelectedIndexChanged" Mode="Conditional" RenderMode="Inline" Width="60px" onchange="javascript:cahs_N_bank(this)">
                                    <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Cash" Value="Cash"></asp:ListItem>
                                    <asp:ListItem Text="Cheque" Value="Cheque"></asp:ListItem>

                                </asp:DropDownList>
                                </font>
                            </ContentTemplate>
                        </asp:UpdatePanel></td>
                <td align="left">
                    <font class="blackfnt">Payment Account</font>
                </td>
                <td align="left">
                    <font class="blackfnt">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:DropDownList ID="cboPaymentAccount" AutoPostBack="true" runat="server">
                                    <asp:ListItem>--Select--</asp:ListItem>
                                </asp:DropDownList>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="cboModeOfTransaction" EventName="SelectedIndexChanged" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </font>
                </td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td align="left">
                    <font class="blackfnt">Cheque No </font>
                </td>
                <td align="left">
                    <font class="blackfnt">
                        <asp:TextBox ID="txtChequeNo" runat="server" Width="70px" MaxLength="6"></asp:TextBox></font>
                </td>
                <td align="left">
                    <font class="blackfnt">Cheque Date </font>
                </td>
                <td align="left">
                    <font class="blackfnt">
                        <asp:TextBox ID="txtChequeDate" runat="server" Width="70px" onblur="javascript:ValidateForm(this)"></asp:TextBox><a
                            href="#" onclick="cal.select(ctl00$MyCPH1$txtChequeDate,'anchor2','dd/MM/yyyy'); return false;"
                            name="anchor2" id="anchor2"><img src="../../../../images/calendar.jpg" border="0" />
                        </a>dd/mm/yyyy </font>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="left">
                    <font class="blackfnt">Payment Amount</font>
                </td>
                <td align="left">
                    <font class="blackfnt">
                        <asp:TextBox ID="txtPaymentAmt" runat="server" Enabled="false" Width="70px"></asp:TextBox></font>
                </td>
                <td align="left">
                    <font class="blackfnt">Cash Amount</font>
                </td>
                <td align="left">
                    <font class="blackfnt">
                        <asp:TextBox ID="txtCashAmount" runat="server" Width="70px" Enabled="false"></asp:TextBox></font>
                </td>
            </tr>
        </table>--%>
        <br />
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="blackfnt" OnClick="btnSubmit_Click"/>   <%--OnClientClick="return wrapper()"--%>
     
        <script language="javascript" type="text/javascript">
            window.onload = totalcal
        </script>

    
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
