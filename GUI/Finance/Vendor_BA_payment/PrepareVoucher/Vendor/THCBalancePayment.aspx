<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="THCBalancePayment.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_PrepareVoucher_Vendor_THCBalancePayment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../../../images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript" src="../../../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript" src="../../../../images/DateControl.js"></script>

    <script language="javascript" type="text/javascript">
        function OpenPopupWindowTHC(strDocketNo, view) {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../../../../Operations/THC/ViewPrint/THCViewPrint.aspx?tcno=" + strDocketNo + ".,0"
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        frm_name = "ctl00$MyCPH1$"
        var months = new Array("", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
        var client_name = "<%=Session["Client"]%>"
     var Fromdate = "<%=fromdt%>"
        var Todate = "<%=Todt%>"
        var FinYear = "<%=Session["FinYear"]%>"
        var FinYear_to = parseInt(FinYear) + 1
        Frmnae = "ctl00$MyCPH1$"
        if (FinYear_to < 10) {
            FinYear_to = "0" + FinYear_to
        }
        var FinYear_fromdate = "01/04/" + FinYear
        var FinYear_todate = "31/03/" + FinYear_to
        var Sle_finyear = FinYear + "-" + FinYear_to
        var total_balanceamount = 0
        totdkt = "<%=totdkt %>"
		var cal = new CalendarPopup("testdiv1");
		cal.setCssPrefix("TEST");
		cal.showNavigationDropdowns();
		function totalcal() {
		    totalbalmt = 0
		    toatl_othermat = 0
		    total_Contramt = 0
		    total_adv_paid = 0
		    total_svctax_cess = 0
		    total_tds = 0
		    total_incentive = 0
		    total_penalty = 0
		    total_claims = 0
		    total_hamali = 0
		    total_detention = 0
		    total_othamt = 0
		    total_netbalamt = 0
		    total_indbalamt = 0
		    ind_othermat = 0
		    ind_Contramt = 0
		    ind_adv_paid = 0
		    ind_svctax_cess = 0
		    ind_tds = 0
		    ind_incentive = 0
		    ind_penalty = 0
		    ind_claims = 0
		    ind_hamali = 0
		    ind_detention = 0
		    ind_othamt = 0
		    ind_netbalamt = 0
		    ind_indbalamt = 0
		    total_balamt = 0
		    for (var i = 0; i < totdkt; i++) {
		        j = i + 2;

		        if (j < 10)
		        { Form_name = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$" }
		        else
		        { Form_name = "ctl00$MyCPH1$dockdata$ctl" + j + "$" }


		        //******fot individual********


		        ind_othermat = parseFloat(document.getElementById(Form_name + "indothamt").value)

		        ind_Contramt = parseFloat(document.getElementById(Form_name + "indpcamt").value)
		        ind_adv_paid = parseFloat(document.getElementById(Form_name + "indadvamt").value)

		        ind_svctax_cess = parseFloat(document.getElementById(Form_name + "indtSvctax").value)
		        ind_tds = parseFloat(document.getElementById(Form_name + "indtdsded").value)

		        ind_incentive = parseFloat(document.getElementById(Form_name + "incentive").value)
		        ind_penalty = parseFloat(document.getElementById(Form_name + "indpenalty").value)
		        ind_claims = parseFloat(document.getElementById(Form_name + "indclaim").value)
		        ind_hamali = parseFloat(document.getElementById(Form_name + "indhamali").value)
		        ind_detention = parseFloat(document.getElementById(Form_name + "inddetention").value)
		        ind_othamt = parseFloat(document.getElementById(Form_name + "indothded").value)
		        ind_balamt = parseFloat(document.getElementById(Form_name + "indbalamt").value)

		        if (document.getElementById(Form_name + "indcboHamali").value == "P") {
		            ind_indbalamt = ind_balamt + ind_incentive - ind_claims + ind_hamali - ind_penalty + ind_detention - ind_othamt
		        }
		        else {
		            ind_indbalamt = ind_balamt + ind_incentive - ind_claims - ind_hamali - ind_penalty + ind_detention - ind_othamt
		        }
		        if (ind_indbalamt < 0) {
		            ind_indbalamt = 0
		        }
		        document.getElementById(Form_name + "indnetpay").value = ind_indbalamt

		        if ("<%=Session["Client"]%>" == "Ritco" || "<%=Session["Client"]%>" == "RITCO") {

                       ind_tds_rate = parseFloat(document.getElementById(Form_name + "indtdsded_rate").value)
                       document.getElementById(Form_name + "indtdsded").value = Math.round(ind_tds_rate * parseFloat(ind_Contramt) / 100)
                       ind_indbalamt = parseFloat(ind_indbalamt) - parseFloat(document.getElementById(Form_name + "indtdsded").value)
                   }
            //////////////for total 
                   document.getElementById(Form_name + "indnetpay").value = ind_indbalamt
                   toatl_othermat = parseFloat(toatl_othermat) + parseFloat(document.getElementById(Form_name + "indothamt").value)
                   total_Contramt = parseFloat(total_Contramt) + parseFloat(document.getElementById(Form_name + "indpcamt").value)
                   total_adv_paid = parseFloat(total_adv_paid) + parseFloat(document.getElementById(Form_name + "indadvamt").value)
                   total_svctax_cess = parseFloat(total_svctax_cess) + parseFloat(document.getElementById(Form_name + "indtSvctax").value)
                   total_tds = parseFloat(total_tds) + parseFloat(document.getElementById(Form_name + "indtdsded").value)

                   total_incentive = parseFloat(total_incentive) + parseFloat(document.getElementById(Form_name + "incentive").value)
                   total_penalty = parseFloat(total_penalty) + parseFloat(document.getElementById(Form_name + "indpenalty").value)
                   total_claims = parseFloat(total_claims) + parseFloat(document.getElementById(Form_name + "indclaim").value)
                   total_hamali = parseFloat(total_hamali) + parseFloat(document.getElementById(Form_name + "indhamali").value)
                   total_detention = parseFloat(total_detention) + parseFloat(document.getElementById(Form_name + "inddetention").value)
                   total_othamt = parseFloat(total_othamt) + parseFloat(document.getElementById(Form_name + "indothded").value)
                   total_balamt = parseFloat(total_balamt) + parseFloat(document.getElementById(Form_name + "indbalamt").value)



                   total_netbalamt = parseFloat(total_netbalamt) + parseFloat(document.getElementById(Form_name + "indnetpay").value)
                   totalbalmt = parseFloat(totalbalmt) + parseFloat(document.getElementById(Form_name + "indnetpay").value)
                   document.getElementById(frm_name + "txtContractAmt").value = total_Contramt
                   document.getElementById(frm_name + "txtOtherAmount").value = toatl_othermat
                   document.getElementById(frm_name + "txtServiceTax").value = total_svctax_cess
                   document.getElementById(frm_name + "txtTDSAmt").value = total_tds
                   document.getElementById(frm_name + "txtAdvPaid").value = total_adv_paid


                   document.getElementById(frm_name + "txtBalanceAmt").value = total_balamt
                   document.getElementById(frm_name + "txtIncentive").value = total_incentive
                   document.getElementById(frm_name + "txtPenalty").value = total_penalty
                   document.getElementById(frm_name + "txtClaim").value = total_claims
                   document.getElementById(frm_name + "txtHamali2").value = total_hamali
                   document.getElementById(frm_name + "txtDetention").value = total_detention
                   document.getElementById(frm_name + "txtOther").value = total_othamt
                   document.getElementById(frm_name + "txtNetAmtPaid").value = totalbalmt

               }
               k = j + 1
               if (k < 10) {
                   Form_name1 = "ctl00$MyCPH1$dockdata$ctl" + "0" + k + "$"
               }
               else {
                   Form_name1 = "ctl00$MyCPH1$dockdata$ctl" + k + "$"
               }
               document.getElementById(Form_name1 + "TotalNetbalamt").value = totalbalmt
               document.getElementById(Frmnae + "txtCashAmount").value = totalbalmt
               total_balanceamount = totalbalmt
           }


           function check(cboModeOfTransaction, cboPaymentAccount, txtChequeNo, txtChequeDate, txtPaymentAmt) {


               Frmnae = "ctl00$MyCPH1$"
               var server_dt = "<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"

    //alert(document.getElementById(Frmnae+"TxtCBSDT").value)
    // return false;

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

            Form_name1 = "ctl00$MyCPH1$dockdata$ctl" + "0" + k + "$"

        }
        else {
            Form_name1 = "ctl00$MyCPH1$dockdata$ctl" + k + "$"

        }
        if (parseFloat(document.getElementById(Form_name1 + "TotalNetbalamt").value) > 0) {
            var varcboModeOfTransaction = cboModeOfTransaction.value

            if (varcboModeOfTransaction == "") {
                alert("Please Select Mode of transaction !!! ")
                cboModeOfTransaction.focus();
                return false;
            }
            if (cboPaymentAccount.value == "") {
                alert("Please Select Cash / Bank Account !!! ")
                cboPaymentAccount.focus();
                return false;
            }
            if ((varcboModeOfTransaction == "Cash") && (cboPaymentAccount.value.indexOf("CASH") <= 0)) {
                txtChequeNo.value = ""
                txtChequeDate.value = ""
                alert("Please select Cash Account!!!")
                cboPaymentAccount.focus()
                return false;
            }
            // alert(cboPaymentAccount.value)
            if (varcboModeOfTransaction == "Cheque" || varcboModeOfTransaction == "DD") {

                if (cboPaymentAccount.value.indexOf("BANK") <= 0) {
                    alert("Please select Bank Account!!!")
                    cboPaymentAccount.focus()
                    return false;
                }
                if (txtChequeNo.value == "") {
                    alert("Please enter Cheque No/DD No ")
                    txtChequeNo.focus();
                    return false;
                }
                if (txtChequeDate.value == "") {
                    alert("Please enter Cheque /DD Date")
                    txtChequeDate.focus();
                    return false;
                }
                if (txtChequeDate.value != "") {
                    if (ValidateForm(txtChequeDate) == false) {
                        txtChequeDate.focus();
                        return false;
                    }
                }
                if (txtPaymentAmt.value == "") {
                    alert("Please enter Collection Amount")
                    txtPaymentAmt.focus();
                    return false;
                }
                if (parseFloat(txtPaymentAmt.value) <= 0) {
                    alert("Please enter cheque  Amount")
                    txtPaymentAmt.focus();
                    return false;
                }

                if (parseFloat(txtPaymentAmt.value) != parseFloat(document.getElementById(Form_name1 + "TotalNetbalamt").value)) {
                    alert("Cheque  Amount should be equal to Payment amount!!!")
                    txtPaymentAmt.focus();
                    return false;
                }
            }


        }

        for (var i = 0; i < totdkt; i++) {
            j = i + 2;

            if (j < 10)
            { Form_name = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$" }
            else
            { Form_name = "ctl00$MyCPH1$dockdata$ctl" + j + "$" }


            //******fot individual********
            document.getElementById(Form_name + "incentive").disabled = false;
            document.getElementById(Form_name + "indclaim").disabled = false;
            document.getElementById(Form_name + "indothded").disabled = false;
        }
    //document.getElementById(frm_name+"txtCashAmount").disabled=false
    //        document.getElementById(frm_name+"txtPaymentAmt").disabled=false
    // alert("hi..")
    // return false
        click_count = parseFloat(document.getElementById("ctl00_MyCPH1_click_count").value)
    // alert(click_count)
        if (click_count > 0) {
            alert("Sorry... You cannot click twice !!!")
            return false;
        }
        else {
            click_count = click_count + 1
            document.getElementById("ctl00_MyCPH1_click_count").value = click_count
            return true;
        }
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
    function cahs_N_bank(obj) {
        frm_name = "ctl00$MyCPH1$"

        if (obj.value == "Cash") {
            document.getElementById(frm_name + "txtCashAmount").value = total_balanceamount
            document.getElementById(frm_name + "txtPaymentAmt").value = "0.00"

        }
        else {
            document.getElementById(frm_name + "txtPaymentAmt").value = total_balanceamount
            document.getElementById(frm_name + "txtCashAmount").value = "0.00"
        }
    }
    </script>

    <div align="left">
        <br />
        <table>
            <tr>
                <td>
                    <table cellspacing="1" cellpadding="3" border="0" bgcolor="#808080" style="width: 9.5in"
                        align="left" class="boxbg">
                        <tr class="bgbluegrey">
                            <asp:HiddenField ID="click_count" runat="server" Value="0" />
                            <td valign="top" height="18" colspan="4" align="center">
                                <b><font class="blackfnt"><b>THC Summary</b></b>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <br />
                </td>
            </tr>
            <tr>
                <td>
                    <table border="0" style="width: 9.5in" bgcolor="#808080" cellpadding="2" cellspacing="1"
                        class="boxbg">
                        <tr bgcolor="#FFFFFF">
                            <td colspan="2" width="50%" valign="top">
                                <table border="1" width="100%">
                                    <tr>
                                        <td align="left">
                                            <font class="blackfnt">Voucher date</font>
                                        </td>
                                        <td align="left">
                                            <font class="bluefnt">
                                                <asp:TextBox ID="txtVoucherDate" Enabled="true" runat="server" Width="60px" Columns="8"></asp:TextBox>
                                                <a href="#" onclick="cal.select(ctl00$MyCPH1$txtVoucherDate,'anchor1','dd/MM/yyyy'); return false;"
                                                    name="anchor1" id="anchor1">
                                                    <img src="../../../../images/calendar.jpg" border="0" />
                                                </a>dd/mm/yyyy </font>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <font class="blackfnt">Standard Contract Amount</font>
                                        </td>
                                        <td align="left">&nbsp;<font class="bluefnt"><asp:Label ID="lblStandardAmt" runat="server" Text="Label"></asp:Label></font>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <font class="blackfnt">Contract Amount (+)</font>
                                        </td>
                                        <td align="left">
                                            <font class="blackfnt">
                                                <asp:TextBox ID="txtContractAmt" Enabled="false" runat="server" Width="70px" Text="0.00"
                                                    TabIndex="1"></asp:TextBox></font>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <font class="blackfnt">Other Amount</font>
                                        </td>
                                        <td align="left">
                                            <font class="blackfnt">
                                                <asp:TextBox ID="txtOtherAmount" Enabled="false" runat="server" Text="0.00" Width="70px"></asp:TextBox></font>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <font class="blackfnt">Service Tax + Cess + H.Cess (+)</font>
                                        </td>
                                        <td align="left">
                                            <font class="blackfnt">
                                                <asp:TextBox ID="txtServiceTax" Enabled="false" runat="server" Text="0.00" Width="70px"></asp:TextBox></font>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <font class="blackfnt">TDS amount (-)</font>
                                        </td>
                                        <td align="left">
                                            <font class="blackfnt">
                                                <asp:TextBox ID="txtTDSAmt" Enabled="false" runat="server" Text="0.00" Width="70px"></asp:TextBox></font>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <font class="blackfnt">Advance Paid (-)</font>
                                        </td>
                                        <td align="left">
                                            <font class="blackfnt">
                                                <asp:TextBox ID="txtAdvPaid" Enabled="false" runat="server" Text="0.00" Width="70px"></asp:TextBox></font>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <font class="blackfnt">Balance Amount Paid by</font>
                                        </td>
                                        <td align="left">
                                            <font class="blackfnt">
                                                <asp:TextBox ID="txtBalPaidBy" Enabled="false" runat="server" Text="" Width="136px"></asp:TextBox></font>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <font class="blackfnt">PAN No</font>
                                        </td>
                                        <td align="left">
                                            <font class="blackfnt">
                                                <asp:TextBox ID="txtPANNo" Enabled="true" runat="server" Text="" Width="136px"></asp:TextBox></font>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <font class="blackfnt">PAN Holder Name</font>
                                        </td>
                                        <td align="left">
                                            <font class="blackfnt">
                                                <asp:TextBox ID="txtPANHolderName" Enabled="true" runat="server" Text="" Width="136px"></asp:TextBox>
                                            </font>
                                        </td>
                                        <td></td>
                                    </tr>
                                </table>
                            </td>
                            <td colspan="2" width="50%" valign="top">
                                <table border="1" width="100%">
                                    <tr>
                                        <td align="left">
                                            <font class="blackfnt"><b>Balance Amount</b></font>
                                        </td>
                                        <td align="left" bgcolor="#FFFFFF">
                                            <font class="blackfnt">
                                                <asp:TextBox Enabled="false" Font-Bold="true" ID="txtBalanceAmt" Text="0.00" runat="server"
                                                    Width="70px"></asp:TextBox></font>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <font class="blackfnt">Incentive (+)</font>
                                        </td>
                                        <td align="left" bgcolor="#FFFFFF">
                                            <font class="blackfnt">
                                                <asp:TextBox Enabled="false" ID="txtIncentive" Text="0.00" runat="server" Width="70px"></asp:TextBox></font>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <font class="blackfnt">Penalty (-)</font>
                                        </td>
                                        <td align="left" bgcolor="#FFFFFF">
                                            <font class="blackfnt">
                                                <asp:TextBox Enabled="false" ID="txtPenalty" Text="0.00" runat="server" Width="70px"></asp:TextBox></font>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" style="height: 25px">
                                            <font class="blackfnt">Claim (-)</font>
                                        </td>
                                        <td align="left" bgcolor="#FFFFFF" style="height: 25px">
                                            <font class="blackfnt">
                                                <asp:TextBox Enabled="false" Text="0.00" ID="txtClaim" runat="server" Width="70px"></asp:TextBox></font>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <font class="blackfnt">Handling</font>
                                        </td>
                                        <td align="left" bgcolor="#FFFFFF">
                                            <font class="blackfnt">
                                                <asp:TextBox ID="txtHamali2" Enabled="false" Text="0.00" runat="server" Width="70px"></asp:TextBox></font>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <font class="blackfnt">Detention charges (+)</font>
                                        </td>
                                        <td align="left" bgcolor="#FFFFFF">
                                            <font class="blackfnt">
                                                <asp:TextBox ID="txtDetention" Enabled="false" Text="0.00" runat="server" Width="70px"></asp:TextBox></font>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <font class="blackfnt">Other Deduction (-)</font>
                                        </td>
                                        <td align="left" bgcolor="#FFFFFF">
                                            <font class="blackfnt">
                                                <asp:TextBox ID="txtOther" Enabled="false" Text="0.00" runat="server" Width="70px"></asp:TextBox></font>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <font class="blackfnt"><b>Net Amount Paid</b></font>
                                        </td>
                                        <td align="left" bgcolor="#FFFFFF">
                                            <font class="blackfnt">
                                                <asp:TextBox ID="txtNetAmtPaid" Font-Bold="true" Enabled="false" Text="0.00" runat="server"
                                                    Width="70px" EnableViewState="false"></asp:TextBox></font>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <font class="blackfnt">Re-assign Balance Payable At</font>
                                        </td>
                                        <td align="left" bgcolor="#FFFFFF">
                                            <font class="blackfnt">
                                                <asp:TextBox ID="txtReassignBalPymtAt" runat="server" Width="40px"></asp:TextBox></font>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <table cellspacing="1" cellpadding="3" border="0" bgcolor="#808080" style="width: 9.5in"
                        align="left" class="boxbg">
                        <tr class="bgbluegrey">
                            <td valign="top" height="18" colspan="4" align="center">
                                <b><font class="blackfnt"><b>THC Details</b></b>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <br />
                    <div align="left">
                        <asp:GridView ID="dockdata" Style="width: 9.5in" runat="server" BorderWidth="1" CellPadding="2"
                            HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="true" PageSize="50"
                            PagerStyle-HorizontalAlign="left" CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"
                            PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" ShowFooter="true"
                            PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" OnPageIndexChanging="pgChange"
                            EmptyDataText="No Records Found..." OnRowDataBound="TDS_AT_baltime_RowDataBound">
                            <%--OnRowDataBound="CustomersGridView_RowDataBound"  --%>
                            <Columns>
                                <%--<asp:BoundField  HeaderText="Sr No." >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>--%>
                                <asp:TemplateField HeaderText="SRNo.">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblSRNo" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--<asp:BoundField DataField="thcno" HeaderText="DocumentNo." >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>--%>
                                <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                    <HeaderTemplate>
                                        <asp:Label ID="DocumentNo" CssClass="blackfnt" Text="THCNo" runat="server"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="thcno" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"dockno") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="View" HeaderStyle-Width="15">
                                    <ItemTemplate>
                                        <a href="JavaScript:OpenPopupWindowTHC('<%#DataBinder.Eval(Container.DataItem, "dockno") %>')">
                                            <font cssclass="Blackfnt">View </a>
                                    </ItemTemplate>
                                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <HeaderStyle CssClass="blackfnt" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblActualUnloadingDate" CssClass="blackfnt" Text="Unloading Date"
                                            runat="server"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <center>
                                            <asp:TextBox Enabled="false" ID="actualDt" Width="50" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"actarrv_dt") %>'></asp:TextBox>
                                        </center>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblUnloadingWeight" CssClass="blackfnt" Text="Unloading Weight" runat="server"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <center>
                                            <asp:TextBox Enabled="false" ID="UnloadingWeight" Width="50" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"UnloadActualWeight") %>'></asp:TextBox>
                                        </center>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblcontractAmt" CssClass="blackfnt" Text="Contract Amount (+)" runat="server"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <center>
                                            <asp:TextBox Enabled="false" ID="indpcamt" Width="50" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"PCAMT") %>'></asp:TextBox>
                                        </center>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblOtherAmt" CssClass="blackfnt" Text="Other Amount(+) " runat="server"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <center>
                                            <asp:TextBox Enabled="false" ID="indothamt" Width="50" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"OTHCHRG") %>'></asp:TextBox>
                                        </center>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblAdvamt" CssClass="blackfnt" Text=" Advance Paid (-) " runat="server"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <center>
                                            <asp:TextBox Enabled="false" ID="indadvamt" Width="50" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"ADVAMT") %>'></asp:TextBox>
                                        </center>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblSvctaax" CssClass="blackfnt" Text="SvcTax + Cess +H.Cess(+) " runat="server"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <center>
                                            <asp:TextBox Enabled="false" ID="indtSvctax" Width="50" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Svctax_cess") %>'></asp:TextBox>
                                        </center>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblTDSdeduction_rate" CssClass="blackfnt" Text="TDS Rate " runat="server"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <center>
                                            <asp:TextBox onblur="javascript:totalcal()" ID="indtdsded_rate" Width="50" runat="server"
                                                Text='0.00'></asp:TextBox>
                                        </center>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblTDSdeduction" CssClass="blackfnt" Text="TDS Dedn.(-) " runat="server"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <center>
                                            <asp:TextBox Enabled="false" ID="indtdsded" Width="50" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"tdsded") %>'></asp:TextBox>
                                        </center>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblNetbalamt" CssClass="blackfnt" Text="Balance Amt." runat="server"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <center>
                                            <asp:TextBox Enabled="false" ID="indbalamt" Width="50" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"netbalamt") %>'></asp:TextBox>
                                        </center>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--<asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="lblBalAmt" CssClass="blackfnt" Text="Balance Amount" runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                              <asp:TextBox  ID ="balmat" Width="50" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"balamt") %>'></asp:TextBox>
                   
                    </center>
                </ItemTemplate>
 </asp:TemplateField>--%>
                                <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblIncentive" CssClass="blackfnt" Text="Incentive(+) " runat="server"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <center>
                                            <asp:TextBox onblur="javascript:totalcal()" ID="incentive" Width="50" runat="server" Enabled="false" 
                                                Text='<%# DataBinder.Eval(Container.DataItem,"OTHDED") %>'></asp:TextBox>
                                        </center>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblPenalty" CssClass="blackfnt" Text="Penalty(-) " runat="server"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <center>
                                            <asp:TextBox onblur="javascript:totalcal()" ID="indpenalty" Width="50" runat="server"
                                                Text='<%# DataBinder.Eval(Container.DataItem,"OTHDED") %>'></asp:TextBox>
                                        </center>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblClaim" CssClass="blackfnt" Text="Claim(-) " runat="server"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <center>
                                            <asp:TextBox onblur="javascript:totalcal()" ID="indclaim" Width="50" runat="server"
                                                Text='<%# DataBinder.Eval(Container.DataItem,"OTHDED") %>'></asp:TextBox>
                                        </center>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblHamali" CssClass="blackfnt" Text="Handling Chrg" runat="server"
                                            Width="100"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <center>
                                            <asp:DropDownList ID="indcboHamali" runat="server" onblur="javascript:totalcal()">
                                                <%--<asp:ListItem Value="P" Text="+"></asp:ListItem>--%>
                                                <asp:ListItem Value="M" Text="-"></asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:TextBox onblur="javascript:totalcal()" ID="indhamali" Width="50" runat="server"
                                                Text='<%# DataBinder.Eval(Container.DataItem,"OTHDED") %>'></asp:TextBox>
                                        </center>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblDetention" CssClass="blackfnt" Text="Detention(+)" runat="server"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <center>
                                            <asp:TextBox onblur="javascript:totalcal()" ID="inddetention" Width="50" runat="server"  
                                                Text='<%# DataBinder.Eval(Container.DataItem,"OTHDED") %>'></asp:TextBox>
                                        </center>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                    <HeaderTemplate>
                                        <asp:Label ID="lbldeduction" CssClass="blackfnt" Text="Deductions(-) " runat="server"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <center>
                                            <asp:TextBox onblur="javascript:totalcal()" ID="indothded" Width="50" runat="server"
                                                Text='<%# DataBinder.Eval(Container.DataItem,"OTHDED") %>'></asp:TextBox>
                                        </center>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblNetPayable" CssClass="blackfnt" Text="Net Payable" runat="server"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <center>
                                            <asp:TextBox ID="indnetpay" Width="50" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"netbalamt") %>'></asp:TextBox>
                                            <asp:HiddenField ID="Advance_paid" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"Advance_paid") %>' />
                                            <asp:HiddenField ID="pan_no" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"pan_no")%>' />
                                        </center>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <center>
                                            <asp:TextBox ID="TotalNetBalamt" Font-Bold="true" runat="server" Enabled="false"
                                                Text="0.00" Columns="6"></asp:TextBox>
                                        </center>
                                    </FooterTemplate>
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
                </td>
            </tr>
            <tr>
                <td>
                    <div align="left">
                        <p align="left">
                            &nbsp;&nbsp;&nbsp;&nbsp;<font class="blackfnt"><b><u>Note :</u></b> Please enter the
                                payment details if advance amount >0 .</font>
                        </p>
                    </div>
                    <br />
                    <table border="0" cellspacing="1" cellpadding="4" style="width: 9.5in" align="left"
                        class="boxbg">
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
                                            <asp:DropDownList ID="cboModeOfTransaction" runat="server" Width="60px" OnSelectedIndexChanged="cboModeOfTransaction_SelectedIndexChanged"
                                                AutoPostBack="true" onchange="javascript:cahs_N_bank(this)">
                                                <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                                <asp:ListItem Text="Cash" Value="Cash"></asp:ListItem>
                                                <asp:ListItem Text="Cheque" Value="Cheque"></asp:ListItem>
                                                <asp:ListItem Text="DD" Value="DD"></asp:ListItem>
                                            </asp:DropDownList>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </font>
                            </td>
                            <td align="left">
                                <font class="blackfnt">Payment Account</font>
                            </td>
                            <td align="left">
                                <font class="blackfnt">
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <asp:DropDownList ID="cboPaymentAccount" runat="server" AutoPostBack="true">
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
                                    <asp:TextBox ID="txtPaymentAmt" runat="server" Enabled="false" Width="70px" Text="0.00"></asp:TextBox></font>
                            </td>
                            <td align="left">
                                <font class="blackfnt">Cash Amount</font>
                            </td>
                            <td align="left">
                                <font class="blackfnt">
                                    <asp:TextBox ID="txtCashAmount" runat="server" Width="70px" Enabled="false" Text="0.00"></asp:TextBox></font>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff">
                            <td align="left">
                                <font class="blackfnt">Narration</font>
                            </td>
                            <td align="left">
                                <font class="blackfnt">
                                    <asp:TextBox ID="txtNarration" runat="server" Height="56px" Width="200px" TextMode="MultiLine"></asp:TextBox></font>
                            </td>
                            <td align="left">
                                <font class="blackfnt">Behati NO/Date/Amount</font>
                            </td>
                            <td align="left">
                                <font class="blackfnt">
                                    <asp:TextBox ID="txtBehatiNo" runat="server" Height="56px" Width="200px" TextMode="MultiLine"></asp:TextBox></font>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <br />
        <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
        </div>
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />

        <script language="javascript" type="text/javascript">
            window.onload = totalcal
        </script>

    </div>
</asp:Content>
