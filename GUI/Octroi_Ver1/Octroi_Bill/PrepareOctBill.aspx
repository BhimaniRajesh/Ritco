<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="PrepareOctBill.aspx.cs" Inherits="GUI_Octroi_Octroi_Bill_PrepareOctBill" %>

<%@ Register Src="../../Common_UserControls/OctroiBillDetails.ascx" TagName="OctroiBillDetails"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="JavaScript" src="../../images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript" src="../../images/DateControl.js"></script>

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript" src="../JS/Octroi.js"></script>

    <script language="javascript" type="text/javascript" src="../../Finance/Billing_Ver1/Billing.js"></script>

    <asp:HiddenField ID="txtdocketlist_count" runat="server" />
    <asp:HiddenField ID="Hnd_Mindate" runat="server"></asp:HiddenField>
    <asp:HiddenField ID="Hnd_Maxdate" runat="server"></asp:HiddenField>
    <asp:HiddenField ID="Hnd_Server_dt" runat="server"></asp:HiddenField>
    <asp:HiddenField ID="Hnd_BillGen_Loc_BasedOn" runat="server"></asp:HiddenField>
    <asp:HiddenField ID="Hnd_ON_CR_Limit_Allow" runat="server"></asp:HiddenField>
    <asp:HiddenField ID="Hnd_OutStd_Limit_Allow" runat="server"></asp:HiddenField>
    <asp:HiddenField ID="Hnd_manual_billno_Mandatory" runat="server"></asp:HiddenField>
    <asp:HiddenField ID="Hnd_Duplicate_check" runat="server"></asp:HiddenField>
    <asp:HiddenField ID="Hnd_AlloW_BackDate" runat="server"></asp:HiddenField>
    <asp:HiddenField ID="click_count" runat="server"></asp:HiddenField>
    <asp:HiddenField ID="hidCustomerTypeBillto" runat="server" />

    <script language="javascript" type="text/javascript">

        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
        FRM_Name = "ctl00_MyCPH1_"
        function OnPartySubmit() {
            if (document.getElementById(FRM_Name + 'Party_code').value == "") {
                alert("Plz Select Enter Customer Name~Code Format")
                document.getElementById(FRM_Name + 'Party_code').focus();
                return false;
            }
            var Search_Char = "~"
            if (document.getElementById(FRM_Name + 'Party_code').value.indexOf(Search_Char) == -1) {
                alert("Invalid Customer Name~Code Format");
                document.getElementById(FRM_Name + 'Party_code').focus();
                return false
            }
        }

        function validDate(id) {

            var txtdate = document.getElementById(id);
            if (!isValidDate(txtdate.value, "Date"))
                txtdate.focus();
            return false;
        }

        //Add Service Portion On 31 May 2015 By Bipin Rupavatiya
        function createXMLHttpRequest() {
            // Mozilla, Safari,...
            if (window.XMLHttpRequest) { xmlHttpRequest = new XMLHttpRequest(); if (xmlHttpRequest.overrideMimeType) xmlHttpRequest.overrideMimeType("text/xml"); }
            // IE
            else if (window.ActiveXObject) { try { xmlHttpRequest = new ActiveXObject("Msxml2.XMLHTTP"); } catch (e) { try { xmlHttpRequest = new ActiveXObject("Microsoft.XMLHTTP"); } catch (e) { } } }
        }
        /* ----- End ----*/

        function BillDate(obj) {
            if (obj.value != "") {
                if (isDate(obj.value) == false) {
                    obj.focus();
                    return false;
                }
                GetServiceTax();
            }
        }

        /* ----- Added  to Get Service Tax ----*/
        function GetServiceTax() {
            var currentTime = new Date();

            var txtVoucherDate = document.getElementById("ctl00_MYCPH1_txtbgndt");
            //var hdnOldVendorBillDate = document.getElementById(FRM_NM + "ctl00_MYCPH1_hdnOldVendorBillDate");

            var HdnServiceTaxRate = document.getElementById("ctl00_MYCPH1_HdnServiceTaxRate");
            var HdnEduCessRate = document.getElementById("ctl00_MYCPH1_HdnEduCessRate");
            var HdnHEduCessRate = document.getElementById("ctl00_MYCPH1_HdnHEduCessRate");

            //var hdnServiceTaxRate = document.getElementById(FRM_NM + "HdnServiceTaxRate");
            //var hdnEduCessRate = document.getElementById(FRM_NM + "HdnEduCessRate");
            //var hdnHEduCessRate = document.getElementById(FRM_NM + "HdnHEduCessRate");

            //if (hdnOldVendorBillDate.value != txtVoucherDate.value)
            //{
            //hdnOldVendorBillDate.value = txtVoucherDate.value;
            createXMLHttpRequest();
            if (xmlHttpRequest) {
                xmlHttpRequest.onreadystatechange = function() {
                    if (xmlHttpRequest.readyState == 4) {

                        var returnValue = xmlHttpRequest.responseText.split("|");
                        if (returnValue[0] == "true") {
                            HdnServiceTaxRate.value = returnValue[1];
                            HdnEduCessRate.value = returnValue[2];
                            HdnHEduCessRate.value = returnValue[3];
                        }
                        //else {
                        //    hdnServiceTaxRate.value = "0.00";
                        //    hdnEduCessRate.value = "0.00";
                        //    hdnHEduCessRate.value = "0.00";
                        //}
                    }
                };
                xmlHttpRequest.open("GET", "ServiceTax_AjaxResponse.aspx?Method=GetServiceTax&Parameter1=" + txtVoucherDate.value + "&datetime=" + currentTime, false);
                xmlHttpRequest.send(null);
            }
            //}
            calc();
        }
        //END
        function validGridDate(id) {
            var txtdate = document.getElementById(id);
            if (!isValidDate(txtdate.value, "Date"))
                txtdate.focus();

            var grid = document.getElementById("ctl00_MyCPH1_OctroiBillDetails1_DataGrid1");
            var rows = grid.rows.length;

            var FormControl = "ctl00$MyCPH1$OctroiBillDetails1$DataGrid1$ctl"

            for (i = 0; i < rows - 1; i++) {
                j = i + 2;

                if (j < 10) {
                    pref = FormControl + "0" + j + "$"
                }
                else {
                    pref = FormControl + j + "$"
                }
                var txtdeclval = document.getElementById(pref + "txtdeclval").value;
                document.getElementById(pref + "hiddeclval").value = txtdeclval;

                var txtoctamt = document.getElementById(pref + "txtoctamt").value;
                document.getElementById(pref + "hidoctamt").value = txtoctamt;

                var txtrcptno = document.getElementById(pref + "txtrcptno").value;
                document.getElementById(pref + "hidrcptno").value = txtrcptno;

                var txtrcptdate = document.getElementById(pref + "txtrcptdate").value;
                document.getElementById(pref + "hidrcptdate").value = txtrcptdate;
            }
            return false;
        }


        function validFloat(event, txtid) {
            var tb = document.getElementById(txtid);
            var txt = tb.value;
            if (event.keyCode == 13)
                return true;

            if (event.keyCode == 46)
                if (txt.indexOf('.') != -1)
                event.keyCode = 0;

            if ((event.keyCode < 46 || event.keyCode > 57) || event.keyCode == 47)
            { event.keyCode = 0; return false; }
        }

        function calc() {
            var HdnServiceTaxRate = document.getElementById("ctl00_MYCPH1_HdnServiceTaxRate");
            var HdnEduCessRate = document.getElementById("ctl00_MYCPH1_HdnEduCessRate");
            var HdnHEduCessRate = document.getElementById("ctl00_MYCPH1_HdnHEduCessRate");
            var grid = document.getElementById("ctl00_MyCPH1_OctroiBillDetails1_DataGrid1");
            var rows = grid.rows.length;

            var hidStaxRule = document.getElementById("ctl00_MyCPH1_OctroiBillDetails1_hidStaxRule");
            var hidRate = document.getElementById("ctl00_MyCPH1_OctroiBillDetails1_hidRate");
            var pref = "";
            var grandtotal = 0.00;
            var octamt = 0.00;
            var processchrg = 0.00;
            var othr = 0.00;
            var stax = 0.00;
            var cess = 0.00;
            var hcess = 0.00;
            var ForServiceTax = 0.00;

            var grandtotal2 = 0.00;
            var TotalStax = 0.00;
            var TotalCess = 0.00;

            var FormControl = "ctl00$MyCPH1$OctroiBillDetails1$DataGrid1$ctl"

            for (i = 0; i < rows - 1; i++) {
                j = i + 2;

                if (j < 10) {
                    pref = FormControl + "0" + j + "$"
                }
                else {
                    pref = FormControl + j + "$"
                }
                var txtdeclval = document.getElementById(pref + "txtdeclval");
                var txtoctamt = document.getElementById(pref + "txtoctamt");
                var hidoctamt = document.getElementById(pref + "hidoctamt");

                var txtoctper = document.getElementById(pref + "txtoctper");
                var hidoctper = document.getElementById(pref + "hidoctper");
                var txtclearchrg = document.getElementById(pref + "txtclearchrg");
                var txtprochrg_per = document.getElementById(pref + "txtprochrg_per");
                var txtprochrg = document.getElementById(pref + "txtprochrg");
                var txtotchg = document.getElementById(pref + "txtotchg");

                var txtstax = document.getElementById(pref + "txtstax");
                var hidstax = document.getElementById(pref + "hidstax");

                var txtcess = document.getElementById(pref + "txtcess");
                var hidcess = document.getElementById(pref + "hidcess");

                var txthcess = document.getElementById(pref + "txthcess");
                var hidhcess = document.getElementById(pref + "hidhcess");

                var txttotalamt = document.getElementById(pref + "txttotalamt");
                var hidtotalamt = document.getElementById(pref + "hidtotalamt");

                if (txtoctamt.value != "") {
                    octamt = parseFloat(txtoctamt.value);
                    hidoctamt.value = parseFloat(txtoctamt.value);
                    grandtotal = 0.00;
                    if (octamt != 0) {
                        var perct = (parseFloat(txtoctamt.value) * 100) / parseFloat(txtdeclval.value);
                        txtoctper.value = rounditn(perct, 2);
                        hidoctper.value = rounditn(perct, 2);


                        // Assigning Octroi Amount to Grand Total
                        grandtotal = grandtotal + octamt;

                        // Adding Cleasrance Charges to Grand Total             
                        grandtotal = grandtotal + parseFloat(txtclearchrg.value);

                        //                        //Calculate Processing Percentage
                        //                        var ProcessPer = (parseFloat(txtprochrg_per.value) * 100) / parseFloat(txtoctamt.value);
                        //                        txtprochrg_per.value = rounditn(ProcessPer,2);

                        //Calculate Processing Charges                    
                        processchrg = (parseFloat(txtoctamt.value) * parseFloat(txtprochrg_per.value)) / 100;

                        // Adding Processing Charges to Grand Total
                        grandtotal = grandtotal + processchrg;
                        txtprochrg.value = rounditn(processchrg, 2)

                        // Adding Other Charges to Grand Total
                        grandtotal = grandtotal + parseFloat(txtotchg.value);

                        // Calculate STAX
                        ForServiceTax = parseFloat(txtclearchrg.value) + parseFloat(txtprochrg.value) + parseFloat(txtotchg.value)

                        if (hidStaxRule.value == "Y") {
                            if (ForServiceTax != 0) {
                                stax = (ForServiceTax * parseFloat(HdnServiceTaxRate.value)) / 100;
                                txtstax.value = rounditn(stax, 2);
                                hidstax.value = rounditn(stax, 2);
                            }

                            // Adding STAX to Grand Total
                            grandtotal = grandtotal + stax;

                            TotalStax = TotalStax + stax;

                            // Calculating CESS = 2 % of STAX
                            if (stax != 0) {
                                cess = (stax * HdnEduCessRate.value) / 100;
                                txtcess.value = rounditn(cess, 2);
                                hidcess.value = rounditn(cess, 2);
                            }
                            // Adding CESS to Grand Total
                            grandtotal = grandtotal + cess;
                            TotalCess = TotalCess + cess;

                            //Calculating HCESS = 1 % of STAX
                            if (stax != 0) {
                                hcess = (stax * HdnHEduCessRate.value) / 100;
                                txthcess.value = rounditn(hcess, 2);
                                hidhcess.value = rounditn(hcess, 2);
                            }

                            // Adding HCESS to Grand Total
                            grandtotal = grandtotal + hcess;
                        }

                        txttotalamt.value = rounditn(grandtotal, 2);
                        hidtotalamt.value = rounditn(grandtotal, 2);

                        grandtotal2 += grandtotal;

                        document.getElementById("ctl00_MyCPH1_txtbillamt").value = rounditn(grandtotal2, 2);
                        //                      document.getElementById("ctl00_MyCPH1_txtRemark").value =rounditn(TotalStax,2);
                        //                      document.getElementById("ctl00_MyCPH1_txtspl_ins").value =rounditn(TotalCess,2);

                        document.getElementById("ctl00_MyCPH1_hidBillAmt").value = rounditn(grandtotal2, 2);
                        document.getElementById("ctl00_MyCPH1_hidTotStaxAmt").value = rounditn(TotalStax, 2);
                        document.getElementById("ctl00_MyCPH1_hidTotCessAmt").value = rounditn(TotalCess, 2);
                    }
                }
            }
        }


        function getDockData(txtid) {
            var hidCustomerTypeBillto = document.getElementById("ctl00_MyCPH1_hidCustomerTypeBillto");
            var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");
            hdnajaxstate.value = "1";

            var len = txtid.length;
            var pref = txtid.substring(0, len - 9);

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
                strpg = "AjaxResponse.aspx?mode=data&code1=octdet&code2=" + txt.value + "&code3=" + hidCustomerTypeBillto.value + "&sid=" + Math.random() + "&sid=" + Math.random();

                findobj.open("GET", strpg);
                findobj.onreadystatechange = function() {
                    if ((findobj.readyState == 4) && (findobj.status == 200)) {
                        var res = findobj.responseText.split("|");
                        if (res[0] == "false") {
                            var hidDockDate = document.getElementById(pref + "hidDockDate");
                            var hidStatus = document.getElementById(pref + "hidStatus");
                            var hidPartyName = document.getElementById(pref + "hidPartyName");

                            hidDockDate.value = res[1];
                            hidStatus.value = res[2];
                            hidPartyName.value = res[3];
                            hdnajaxstate.value = "0";
                            return false;
                        }
                        else if (res[0] == "true") {
                            hdnajaxstate.value = "0";

                            var txtdeclval = document.getElementById(pref + "txtdeclval");
                            var hiddeclval = document.getElementById(pref + "hiddeclval");
                            var txtoctamt = document.getElementById(pref + "txtoctamt");
                            var hidoctamt = document.getElementById(pref + "hidoctamt");
                            var txtrcptno = document.getElementById(pref + "txtrcptno");
                            var hidrcptno = document.getElementById(pref + "hidrcptno");
                            var txtrcptdate = document.getElementById(pref + "txtrcptdate");
                            var hidrcptdate = document.getElementById(pref + "hidrcptdate");
                            var hidDockDate = document.getElementById(pref + "hidDockDate");
                            var hidStatus = document.getElementById(pref + "hidStatus");
                            var hidPartyName = document.getElementById(pref + "hidPartyName");

                            txtdeclval.value = res[1];
                            txtdeclval.disabled = true;
                            hiddeclval.value = txtdeclval.value;

                            txtoctamt.value = res[2];
                            if (parseFloat(txtoctamt.value) > 0)
                                txtoctamt.disabled = true;
                            else
                                txtoctamt.disabled = false;
                            hidoctamt.value = txtoctamt.value;

                            txtrcptno.value = res[3];
                            if (txtrcptno.value != "")
                                txtrcptno.disabled = true;
                            else
                                txtrcptno.disabled = false;
                            hidrcptno.value = txtrcptno.value;

                            txtrcptdate.value = res[4];
                            if (txtrcptdate.value != "")
                                txtrcptdate.disabled = true;
                            else
                                txtrcptdate.disabled = false;
                            hidrcptdate.value = txtrcptdate.value;

                            hidDockDate.value = res[5];
                            hidStatus.value = res[6];
                            hidPartyName.value = res[7];
                            checkDocketNo(txt);
                            calc();
                        }
                        else if (res[0] == "InValid") {
                            alert("InValid Docket No...");
                            var txtdockno = document.getElementById(pref + "txtdockno");
                            txtdockno.value = "";
                            txtdockno.focus();
                        }

                        else if (res[0] == "InValidDocket") {
                            alert(res[1]);
                            var txtdockno = document.getElementById(pref + "txtdockno");
                            txtdockno.value = "";
                            txtdockno.focus();
                        }

                        else if (res[0] == "InValidRule") {
                            alert("LocationWise Octroi Bill Generation Rule not Specify");
                            var txtdockno = document.getElementById(pref + "txtdockno");
                            txtdockno.value = "";
                            txtdockno.focus();
                        }

                        else if (res[0] == "InValidLocation") {
                            alert("Current Location and Booking Location are Different");
                            var txtdockno = document.getElementById(pref + "txtdockno");
                            txtdockno.value = "";
                            txtdockno.focus();
                        }
                    }
                }

                findobj.send(null);
            }
            return true;
        }

        function checkDocketNo(obj) {
            var grid = document.getElementById("ctl00_MyCPH1_OctroiBillDetails1_DataGrid1");
            var rows = grid.rows.length;
            var FormControl = "ctl00$MyCPH1$OctroiBillDetails1$DataGrid1$ctl"
            var count = 0;

            for (i = 0; i < rows - 1; i++) {
                j = i + 2;

                if (j < 10) {
                    pref = FormControl + "0" + j + "$"
                }
                else {
                    pref = FormControl + j + "$"
                }

                var txtdockno = document.getElementById(pref + "txtdockno");
                var txtdeclval = document.getElementById(pref + "txtdeclval");
                if (obj.value == txtdockno.value) {
                    count = count + 1;
                    if (count > 1) {
                        alert("Docket No already entered.");
                        obj.value = "";
                        txtdeclval.value = "";
                        obj.focus();
                        return false;
                    }
                }
            }
        }

        function SelectSingleFile(checkVal) {
            var grid = document.getElementById("ctl00_MyCPH1_OctroiBillDetails1_DataGrid1");
            var rows = grid.rows.length;
            var FormControl = "ctl00$MyCPH1$OctroiBillDetails1$DataGrid1$ctl"

            for (i = 0; i < rows - 1; i++) {
                j = i + 2;

                if (j < 10) {
                    pref = FormControl + "0" + j + "$"
                }
                else {
                    pref = FormControl + j + "$"
                }

                var rdbParty = document.getElementById(pref + "rdbParty");
                if (rdbParty == checkVal) {
                    rdbParty.checked = true;
                }
                else {
                    rdbParty.checked = false;
                }
            }
        }
                    
    </script>

    <script language="javascript" type="text/javascript">
        var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
        var client_name="<%=Session["Client"]%>"
	 
		var FinYear="<%=Session["FinYear"]%>"
		var FinYear_to=parseInt(FinYear)+1
		
		if(FinYear_to<10)
		{
		FinYear_to="0"+FinYear_to
		}
		var FinYear_fromdate="01/04/"+FinYear
		var FinYear_todate="31/03/"+FinYear_to
		var Sle_finyear=FinYear+"-"+FinYear_to
    </script>

    <div>
        <br />
        <table width="1000" align="left">
            <tr>
                <td style="width: 996px">
                    <asp:Panel ID="pnlerror" Visible="false" runat="server">
                        <table width="90%" align="left">
                            <tr>
                                <td>
                                    <asp:Label ID="Error" ForeColor="red" Text="Error:" Font-Bold="true" runat="server"></asp:Label>
                                    <br />
                                    <asp:Label ID="lblerr" ForeColor="red" Font-Bold="true" runat="server"></asp:Label>
                                    <br />
                                    <br />
                                    <asp:Label ID="Label3" Text="Please Try Again....." runat="server"></asp:Label>
                                    <br />
                                    <br />
                                    <asp:Button ID="Button1" Text="OK" runat="server" Width="170" OnClick="btn_ok_Click" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td style="width: 996px">
                    <asp:Panel ID="pnlHeader" runat="server">
                        <table border="0" cellpadding="3" cellspacing="1" class="boxbg" width="55%" align="left">
                            <tr class="bgbluegrey">
                                <td colspan="2" class="blackfnt">
                                    <b>Select Octroi Bill Criteria</b>
                                </td>
                            </tr>
                            <tr bgcolor="white">
                                <td style="width: 250px">
                                    <font class="blackfnt">Enter Customer Code </font>
                                </td>
                                <td style="width: 376px" valign="middle">
                                    <asp:TextBox ID="Party_code" runat="server" CausesValidation="True" Columns="50"
                                        onblur="javascript:Customer_Location_Blur(this,'Customer','N')" BorderStyle="Groove"
                                        CssClass="blackfnt"></asp:TextBox>
                                    <%--<atlas:AutoCompleteExtender runat="server" ID="Extender1">
                                        <atlas:AutoCompleteProperties Enabled="True" TargetControlID="Party_code" ServiceMethod="GetCustomer"
                                            ServicePath="../AtlasAutoComplete.asmx" MinimumPrefixLength="1" />
                                    </atlas:AutoCompleteExtender>--%>
                                    <ajaxToolkit:AutoCompleteExtender ID="Extender1" runat="server" Enabled="True" MinimumPrefixLength="1"
                                        ServiceMethod="GetCustomer" CompletionListItemCssClass="autocomplete_listItem"
                                        CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" ServicePath="../AtlasAutoComplete.asmx"
                                        TargetControlID="Party_code">
                                    </ajaxToolkit:AutoCompleteExtender>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr bgcolor="white">
                                <td style="width: 250px">
                                    <font class="blackfnt">Above Customer is </font>
                                </td>
                                <td style="width: 376px">
                                    <asp:DropDownList ID="Billto" runat="server" CssClass="blackfnt">
                                        <asp:ListItem Value="CSGN">Consignor</asp:ListItem>
                                        <asp:ListItem Value="CSGE">Consignee</asp:ListItem>
                                        <asp:ListItem Value="BILL">Billing Party </asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr bgcolor="white">
                                <td colspan="2" style="text-align: center">
                                    <asp:Button ID="submit1" runat="server" OnClick="submit1_Click" OnClientClick="javascript:return OnPartySubmit()"
                                        Text="Submit" CssClass="blackfnt" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td style="width: 996px">
                    <asp:Panel ID="pnlDetail" runat="server">
                        <table align="left" border="0" cellpadding="3" cellspacing="1" class="boxbg">
                            <tr class="bgbluegrey" style="height: 25px">
                                <td colspan="5" align="center">
                                    <font class="blackfnt"><b>Prepare Octroi Bill</b></font>
                                </td>
                            </tr>
                            <tr bgcolor="white" style="height: 25px">
                                <td style="width: 148px">
                                    <font class="blackfnt">Customer</font>
                                </td>
                                <td>
                                    <asp:Label ID="lblCustomer_Name" runat="server" CssClass="blackfnt" Font-Bold="True"></asp:Label>
                                </td>
                                <td>
                                    <font class="blackfnt">Customer Type </font>
                                </td>
                                <td colspan="2">
                                    <asp:Label ID="lblCustomerType" runat="server" CssClass="blackfnt" Font-Bold="True"></asp:Label>
                                </td>
                            </tr>
                            <tr bgcolor="white" style="height: 25px">
                                <td style="width: 148px">
                                    <font class="blackfnt">Bill Number</font>
                                </td>
                                <td>
                                    <font class="blackfnt" color="red"><b>System Generated...</b></font>
                                </td>
                                <td>
                                    <font class="blackfnt">Bill Branch </font>
                                </td>
                                <td colspan="2">
                                    <font class="blackfnt">
                                        <%=Session["brcd"].ToString() %>
                                    </font>
                                </td>
                            </tr>
                            <tr bgcolor="white">
                                <td>
                                    <font class="blackfnt">Bill Date </font>
                                </td>
                                <td style="height: 24px">
                                    <asp:TextBox ID="txtbgndt" runat="server" MaxLength="10" Width="65" BorderStyle="Groove"
                                        CssClass="blackfnt" onblur="javascript:BillDate(this)"></asp:TextBox>
                                    <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtbgndt,'anchor112','dd/MM/yyyy'); return false;"
                                        name="anchor112" id="anchor112">
                                        <img src="../../images/calendar.jpg" border="0" />
                                    </a>
                                </td>
                                <td>
                                    <font class="blackfnt">Due Date </font>
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtduedate" runat="server" MaxLength="10" Width="65" BorderStyle="Groove"
                                        CssClass="blackfnt" onchange="javascript:return validDate(this.getAttribute('id'));"></asp:TextBox>
                                    <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtduedate,'anchor1','dd/MM/yyyy'); return false;"
                                        name="anchor1" id="anchor1">
                                        <img src="../../images/calendar.jpg" border="0" />
                                    </a>
                                </td>
                            </tr>
                            <tr bgcolor="white">
                                <td>
                                    <font class="blackfnt">Bill Submission at </font>
                                </td>
                                <td style="height: 25px">
                                    <asp:TextBox ID="txtbillsubloc" runat="server" Width="200" BorderStyle="Groove" CssClass="blackfnt"
                                        onblur="javascript:Customer_Location_Blur(this,'Location','N')"></asp:TextBox>
                                    <div id="Div1" runat="server" class="boxbg" />
                                    <%--<atlas:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" DropDownPanelID="Abc">
                                        <atlas:AutoCompleteProperties TargetControlID="txtbillsubloc" ServicePath="../AtlasAutoComplete.asmx"
                                            ServiceMethod="GetLocation" MinimumPrefixLength="1" Enabled="true" />
                                    </atlas:AutoCompleteExtender>--%>
                                    <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" Enabled="True"
                                        MinimumPrefixLength="1" ServiceMethod="GetLocation" CompletionListItemCssClass="autocomplete_listItem"
                                        CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" ServicePath="../AtlasAutoComplete.asmx"
                                        TargetControlID="txtbillsubloc">
                                    </ajaxToolkit:AutoCompleteExtender>
                                </td>
                                <td>
                                    <font class="blackfnt">Billing Party Address</font>
                                </td>
                                <td colspan="2">
                                    <asp:Label ID="Lbl_Party_address" runat="server" Text="" CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>
                            <tr bgcolor="white">
                                <td>
                                    <font class="blackfnt">Bill Collection at </font>
                                </td>
                                <td>
                                    <font class="blackfnt">
                                        <asp:TextBox ID="txtbillcolloc" runat="server" Width="200" BorderStyle="Groove" CssClass="blackfnt"
                                            onblur="javascript:Customer_Location_Blur(this,'Location','N')"></asp:TextBox>
                                        <div id="Abc" runat="server" class="boxbg" />
                                        <%--<atlas:AutoCompleteExtender ID="Ext1" runat="server" DropDownPanelID="Abc">
                                            <atlas:AutoCompleteProperties TargetControlID="txtbillcolloc" ServicePath="../AtlasAutoComplete.asmx"
                                                ServiceMethod="GetLocation" MinimumPrefixLength="1" Enabled="true" />
                                        </atlas:AutoCompleteExtender>--%>
                                        <ajaxToolkit:AutoCompleteExtender ID="Ext1" runat="server" Enabled="True" MinimumPrefixLength="1"
                                            ServiceMethod="GetLocation" CompletionListItemCssClass="autocomplete_listItem"
                                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" ServicePath="../AtlasAutoComplete.asmx"
                                            TargetControlID="txtbillcolloc">
                                        </ajaxToolkit:AutoCompleteExtender>
                                </td>
                                <td style="width: 203px">
                                    <font class="blackfnt">Party Phone Number</font>
                                </td>
                                <td colspan="2">
                                    <asp:Label ID="Lbl_Party_tellno" runat="server" Text="" CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>
                            <tr bgcolor="white">
                                <td>
                                    <font class="blackfnt">Manual Billno.</font>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtManualbillno" runat="server" MaxLength="25" Width="200" BorderStyle="Groove"
                                        CssClass="blackfnt"></asp:TextBox>
                                </td>
                                <td>
                                    <font class="blackfnt">Party E-mail</font>
                                </td>
                                <td colspan="2">
                                    <asp:Label ID="Lbl_Party_Email" runat="server" Text="" CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>
                            <tr bgcolor="white">
                                <td>
                                    <font class="blackfnt">Remark</font>
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtRemark" runat="server" Width="300" Rows="2" TextMode="MultiLine"
                                        BorderStyle="Groove" CssClass="blackfnt" MaxLength="200"></asp:TextBox>
                                </td>
                                <td>
                                    <font class="blackfnt">Total Bill Amount</font>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtbillamt" runat="server" Text="0.00" Enabled="false" Width="60"
                                        Style="text-align: right" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                    <asp:HiddenField ID="hidBillAmt" runat="server" />
                                </td>
                            </tr>
                            <tr bgcolor="white">
                                <td>
                                    <font class="blackfnt">Special Instruction</font>
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtspl_ins" runat="server" Width="300" Rows="2" TextMode="MultiLine"
                                        BorderStyle="Groove" CssClass="blackfnt" MaxLength="200"></asp:TextBox>
                                </td>
                                <td>
                                    <font class="redfnt"><b>Credit Days</b></font>
                                </td>
                                <td>
                                    <font class="redfnt">
                                        <asp:Label ID="Lbl_Credit_days" runat="server" Text="0.00" Font-Bold="true" CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>
                            <tr bgcolor="white">
                                <td>
                                    <font class="redfnt"><b>Credit Limit</b></font>
                                </td>
                                <td>
                                    <font class="redfnt">
                                        <asp:Label ID="Lbl_Credit_Limit" runat="server" Text="" Font-Bold="true" CssClass="blackfnt"></asp:Label>
                                    </font>
                                </td>
                                <td>
                                    <font class="redfnt"><b>OutStanding Amount(As On Date)</b></font>
                                </td>
                                <td align="right">
                                    <font class="redfnt">
                                        <asp:Label ID="Lbl_Outstanding_amt" runat="server" Text="" Font-Bold="true" CssClass="blackfnt"></asp:Label>
                                    </font>
                                </td>
                                <td>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <asp:Panel ID="pnlFooter" runat="server">
                        <table align="left" cellspacing="1" cellpadding="3" class="boxbg" id="TB_Button"
                            runat="server" visible="false">
                            <tr bgcolor="white">
                                <td>
                                    <asp:HiddenField ID="hidTotStaxAmt" runat="server" />
                                    <asp:HiddenField ID="hidTotCessAmt" runat="server" />
                                    <asp:HiddenField ID="HdnServiceTaxRate" runat="server" />
                                    <asp:HiddenField ID="HdnEduCessRate" runat="server" />
                                    <asp:HiddenField ID="HdnHEduCessRate" runat="server" />
                                    <uc1:OctroiBillDetails ID="OctroiBillDetails1" runat="server" />
                                </td>
                            </tr>
                            <tr class="bgbluegrey">
                                <td colspan="4" align="center">
                                    <asp:Button ID="btn_submit" runat="server" BorderStyle="Groove" CssClass="blackfnt"
                                        Text="Generate Bill" OnClick="BtnBillGeneration_Click" OnClientClick="javascript:return OctroiBill_OnSubmit()" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                    <table align="left" cellspacing="1" cellpadding="3" width="1000" class="boxbg" id="Table1"
                        runat="server" visible="false">
                        <tr class="bgbluegrey">
                            <td colspan="4" align="center">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <br />
        <asp:HiddenField ID="hdnajaxstate" runat="server" Value="0"></asp:HiddenField>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
