<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="MiscBillGeneration.aspx.cs" Inherits="GUI_Finance_Billing_MiscBillGeneration" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript" language="javascript" src="../../../images/commonJs.js"></script>
    <script type="text/javascript" language="javascript" src="../../../images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>
    <script language="javascript" type="text/javascript">
        var months = new Array("", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
        var FinYear = "<%=Session["FinYear"]%>"
        var FinYear_to = parseInt(FinYear) + 1

        if (FinYear_to < 10) {
            FinYear_to = "0" + FinYear_to
        }
        var FinYear_fromdate = "01/04/" + FinYear
        var FinYear_todate = "31/03/" + FinYear_to
        var Sle_finyear = FinYear + "-" + FinYear_to
        function nwOpen(mNo) {
            window.open("popupbranch.aspx?" + mNo, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        function nwOpen1(mNo) {
            window.open("popupbranch1.aspx?" + mNo, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
	function nwOpen2(mNo) {
            window.open("popupbranch2.aspx?" + mNo, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
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
        var minYear = "1900";
        var maxYear = "2100";
        function DaysArray(n) {
            for (var i = 1; i <= n; i++) {
                this[i] = 31
                if (i == 4 || i == 6 || i == 9 || i == "11") { this[i] = 30 }
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
                if (ValidateForm(obj) == false) {
                    obj.focus();
                    return false;
                }
                GetServiceTax();
            }
        }

        /* ----- Added  to Get Service Tax ----*/
        function GetServiceTax() {
            var currentTime = new Date();

            var txtVoucherDate = document.getElementById("ctl00_MYCPH1_txtbilldate");
            //var hdnOldVendorBillDate = document.getElementById(FRM_NM + "ctl00_MYCPH1_hdnOldVendorBillDate");

            var HdnServiceTaxRate = document.getElementById("ctl00_MYCPH1_HdnServiceTaxRate");
            var HdnEduCessRate = document.getElementById("ctl00_MYCPH1_HdnEduCessRate");
            var HdnHEduCessRate = document.getElementById("ctl00_MYCPH1_HdnHEduCessRate");
            var HdnSBCRate = document.getElementById("ctl00_MYCPH1_HdnSBCRate");
            var HdnKKCRate = document.getElementById("ctl00_MYCPH1_HdnKKCRate");

            //var hdnServiceTaxRate = document.getElementById(FRM_NM + "HdnServiceTaxRate");
            //var hdnEduCessRate = document.getElementById(FRM_NM + "HdnEduCessRate");
            //var hdnHEduCessRate = document.getElementById(FRM_NM + "HdnHEduCessRate");

            //if (hdnOldVendorBillDate.value != txtVoucherDate.value)
            //{
            //hdnOldVendorBillDate.value = txtVoucherDate.value;
            createXMLHttpRequest();
            if (xmlHttpRequest) {
                xmlHttpRequest.onreadystatechange = function () {
                    if (xmlHttpRequest.readyState == 4) {

                        var returnValue = xmlHttpRequest.responseText.split("|");
                        if (returnValue[0] == "true") {
                            HdnServiceTaxRate.value = returnValue[1];
                            HdnEduCessRate.value = returnValue[2];
                            HdnHEduCessRate.value = returnValue[3];
                            HdnSBCRate.value = returnValue[4];
                            HdnKKCRate.value = returnValue[5];
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
            fcalbillamt();
        }
        //END
        function fcalbillamt() {
            //debugger;
            vehdetchrg = parseFloat(document.getElementById("ctl00_MYCPH1_vehdetchrg").value);
            warechrg = parseFloat(document.getElementById("ctl00_MYCPH1_warechrg").value);
            dischrg = parseFloat(document.getElementById("ctl00_MYCPH1_dischrg").value);
            handchrg = parseFloat(document.getElementById("ctl00_MYCPH1_handchrg").value);
            rentalchrg = parseFloat(document.getElementById("ctl00_MYCPH1_rentalchrg").value);
            otherchrg = parseFloat(document.getElementById("ctl00_MYCPH1_otherchrg").value);
            var HdnServiceTaxRate = document.getElementById("ctl00_MYCPH1_HdnServiceTaxRate");
            var HdnEduCessRate = document.getElementById("ctl00_MYCPH1_HdnEduCessRate");
            var HdnHEduCessRate = document.getElementById("ctl00_MYCPH1_HdnHEduCessRate");
            var HdnSBCRate = document.getElementById("ctl00_MYCPH1_HdnSBCRate");
            var HdnKKCRate = document.getElementById("ctl00_MYCPH1_HdnKKCRate");

            subtotal = parseFloat(warechrg + vehdetchrg + dischrg + handchrg + otherchrg + rentalchrg)
            //alert(subtotal)
            //sertax=parseFloat(parseFloat("12")*subtotal/100)
            //sertax=document.frm.sertax.value
            if (document.getElementById("ctl00_MYCPH1_svctax_yn").checked) {
                document.getElementById("ctl00_MYCPH1_sertax").value = rounditn(parseFloat(subtotal) * parseFloat(HdnServiceTaxRate.value) / 100, 2)
                document.getElementById("ctl00_MYCPH1_cess").value = rounditn(parseFloat(document.getElementById("ctl00_MYCPH1_sertax").value) * HdnEduCessRate.value / 100, 2)
                document.getElementById("ctl00_MYCPH1_H_cess").value = rounditn(parseFloat(document.getElementById("ctl00_MYCPH1_sertax").value) * HdnHEduCessRate.value / 100, 2)
                document.getElementById("ctl00_MYCPH1_SBC").value = rounditn(parseFloat(subtotal) * parseFloat(HdnSBCRate.value) / 100, 2)
                document.getElementById("ctl00_MyCPH1_KKC").value = rounditn((parseFloat(subtotal) * parseFloat(HdnKKCRate.value) / 100), 2);
            }
            else {
                document.getElementById("ctl00_MYCPH1_sertax").value = "0.00"
                document.getElementById("ctl00_MYCPH1_cess").value = "0.00"
                document.getElementById("ctl00_MYCPH1_H_cess").value = "0.00"
                document.getElementById("ctl00_MYCPH1_SBC").value = "0.00"
                document.getElementById("ctl00_MyCPH1_KKC").value = "0.00";

            }
            sertax = document.getElementById("ctl00_MYCPH1_sertax").value
            //cess=document.frm.cess.value
            cess = document.getElementById("ctl00_MYCPH1_cess").value
            H_cess = document.getElementById("ctl00_MYCPH1_H_cess").value
            SBC = document.getElementById("ctl00_MYCPH1_SBC").value
            KKC = document.getElementById("ctl00_MYCPH1_KKC").value


            totalchrg = parseFloat(subtotal) + parseFloat(sertax) + parseFloat(cess) + parseFloat(H_cess) + parseFloat(SBC) + parseFloat(KKC);
            //document.frm.sertax.value=roundit(sertax)
            //document.frm.subtotal.value=roundit(subtotal)
            //document.frm.totalchrg.value=roundit(totalchrg)
            document.getElementById("ctl00_MYCPH1_subtotal").value = roundit(subtotal);
            document.getElementById("ctl00_MYCPH1_totalchrg").value = rounditn(Math.round(totalchrg), 2);
        }
        function Nagative_Chk_wDecimal(obj) {
            var temp
            temp = obj.value
            //alert(temp)
            if (temp == "") {
                alert("Value can not be blank")
                obj.focus();
                obj.value = "0.0";
                return false;
            }
            if (isNaN(temp)) {
                alert("Value should be Numeric")
                obj.value = "0.0";
                obj.focus();
                return false;
            }
            if (parseFloat(temp) < 0) {
                alert("Value should be greater than zero")
                obj.value = "0.0";
                obj.focus();
                return false;
            }
            obj.value = roundit(temp)
            return true;
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
                        if (Num.toString().lastIndexOf('.') + 1 == Num.toString().length - 1)
                            return Num.toString() + '0';
                        else
                            return Num.toString();

                    }
                }
            }
            else return Math.round(Num);
        }
        function FSubmit() {

            var frmname = "ctl00_MYCPH1_"
            var server_dt = "<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>";
            if (document.getElementById(frmname + "txtDateFrom").value == "") {
                alert("PLz enter From Date");
                document.getElementById(frmname + "txtDateFrom").focus();
                return false;
            }

            if (document.getElementById(frmname + "txttodate").value == "") {
                alert("PLz enter TO Date");
                document.getElementById(frmname + "txttodate").focus();
                return false;
            }
            if (document.getElementById(frmname + "txtbilldate").value == "") {
                alert("PLz enter Bill Generation");
                document.getElementById(frmname + "txtbilldate").focus();
                return false;
            }

            var dt = document.getElementById(frmname + "txtbilldate").value
            // alert(dt)
            var dt_dd = dt.substring(0, 2)
            var dt_mm = dt.substring(3, 5)
            var dt_yy = dt.substring(6, 10)

            var sdt = server_dt
            var sdt_dd = sdt.substring(0, 2)
            var sdt_mm = sdt.substring(3, 5)
            var sdt_yy = sdt.substring(6, 10)


            dt = new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
            server_dt = new Date(months[parseFloat(sdt_mm)] + " " + parseFloat(sdt_dd) + ", " + parseFloat(sdt_yy))
            //			alert("server_dt : " + server_dt)
            //			alert("dt : " + dt)

            var FinYear_fromdate_dd = FinYear_fromdate.substring(0, 2);
            var FinYear_fromdate_mm = FinYear_fromdate.substring(3, 5);
            var FinYear_fromdate_yy = FinYear_fromdate.substring(6, 10);
            FinYear_fromdate1 = new Date(months[parseFloat(FinYear_fromdate_mm)] + " " + parseFloat(FinYear_fromdate_dd) + ", " + parseFloat(FinYear_fromdate_yy))

            var FinYear_todate_dd = FinYear_todate.substring(0, 2);
            var FinYear_todate_mm = FinYear_todate.substring(3, 5);
            var FinYear_todate_yy = FinYear_todate.substring(6, 10);
            FinYear_todate1 = new Date(months[parseFloat(FinYear_todate_mm)] + " " + parseFloat(FinYear_todate_dd) + ", " + parseFloat(FinYear_todate_yy))
            //   alert(FinYear_todate1)	
            //	alert(FinYear_fromdate1)	
            if (dt > FinYear_todate1 || dt < FinYear_fromdate1) {
                alert("You have Selected Finacial Year as " + Sle_finyear + " , SO Billdate Should Be Between  " + FinYear_fromdate + " to " + FinYear_todate + " !!!")
                document.getElementById(frmname + "txtbilldate").focus();
                return false;
            }
            //alert(server_dt)	
            //alert(dt)		
            if (dt > server_dt) {
                alert("Bill date should not be greater than today's date !!!");
                document.getElementById(frmname + "txtbilldate").focus();
                return false;
            }
            if (document.getElementById(frmname + "txtduedate").value == "") {
                alert("PLz enter Bill Due Date");
                document.getElementById(frmname + "txtduedate").focus();
                return false;
            }
            if (document.getElementById(frmname + "txtparty").value == "") {
                alert("PLz enter Billing Party");
                document.getElementById(frmname + "txtparty").focus();
                return false;
            }
            if (document.getElementById(frmname + "txtsubbranch").value == "") {
                alert("PLz enter Bill Submission Location");
                document.getElementById(frmname + "txtsubbranch").focus();
                return false;
            }
            if (document.getElementById(frmname + "txtbillcolbranch").value == "") {
                alert("PLz enter Bill Collection Location");
                document.getElementById(frmname + "txtbillcolbranch").focus();
                return false;
            }
            var totalamt = parseFloat(document.getElementById(frmname + "totalchrg").value)

            if (totalamt <= 0) {
                alert("Bill Amount Should BE Greater than Zero");

                return false;
            }
            document.getElementById(frmname + "totalchrg").disabled = false
            document.getElementById(frmname + "sertax").disabled = false
            document.getElementById(frmname + "cess").disabled = false
            document.getElementById(frmname + "H_cess").disabled = false
            document.getElementById(frmname + "SBC").disabled = false
            document.getElementById(frmname + "KKC").disabled = false
            return true;

        }
        function PartyBlur(id, mode) {
            //debugger;
            //var txt=document.getElementById(id);

            if (id.value == "" && mode == "party") {
                alert("Please Enter Party Code....");
                //id.focus();
                return false;
            }
            if (id.value == "" && mode == "loc") {
                alert("Please Enter Location Code....");
                //id.focus();
                return false;
            }
            id.value = id.value.toUpperCase();
            var findobj = false;
            findobj = GetXMLHttpObject();
            if (findobj) {
                var strpg = "CheckExist.aspx?mode=" + mode + "&code=" + id.value + "&sid=" + Math.random();
                findobj.open("GET", strpg, true);
                findobj.onreadystatechange = function () {
                    if (findobj.readyState == 4 && findobj.status == 200) {
                        var res = findobj.responseText.split("|");
                        if (res[0] == "false" && res[1] == "party") {
                            alert("Party Code Is not Valid..Enter Proper Party Code....");
                            id.value = "";
                            return false;
                        }
                        if (res[0] == "false" && res[1] == "loc") {
                            alert("Location Is not Valid..Enter Proper Location Code....");
                            id.value = "";
                            return false;
                        }
                    }
                }
                findobj.send(null);
            }
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
                    //alert("Hi")
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
            else return Math.round(Num);

        }

    </script>
    <table border="0" cellpadding="0" class="boxbg" cellspacing="0" width="55%">

        <tr bgcolor="white">
            <td align="left" colspan="5" height="30" style="width: 459px">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Billing</b></font></a> <b>&gt; </b><a href=""><font class="blklnkund">
                        <b>Misc. Bill Generation</b></font></a> <b>&gt;</b>
            </td>
            <td align="right"><a href="javascript:window.history.go(-1)" title="back">
                <img src="../../../images/back.gif" border="0"></a></td>
        </tr>
    </table>
    <table border="0" cellpadding="0" class="boxbg" cellspacing="0" width="60%">
        <tr bgcolor="white">
            <td align="center" height="30">
                <a><font color="red"><b>
                    <asp:Label ID="lblmsg" runat="server" Visible="false"></asp:Label></b></font>
            </td>
        </tr>
    </table>
    <table bgcolor="white" width="60%" border="0" cellspacing="0" cellpadding="3" align="left" class="boxbg">
        <tr>
            <td bgcolor="white">
                <%--<table width="50%" border="0" cellspacing="1" cellpadding="3" align="left" bgcolor="#808080" class=boxbg>--%>
                <asp:UpdatePanel ID="UP1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                    <ContentTemplate>
                        <table width="86%" border="0" cellspacing="1" cellpadding="3" align="center" bgcolor="#808080" class="boxbg">
                            <tr bgcolor="#ffffff">
                                <td><font class="blackfnt">
                                    <asp:Label ID="lblbillno" Text="Bill No" CssClass="blackfnt" runat="server"></asp:Label></font></td>
                                <td><font color="red">
                                    <asp:Label ID="lblbillno1" Text="System Generated..." CssClass="blackfnt" runat="server"></asp:Label></font></td>
                                <td><font class="blackfnt">
                                    <asp:Label ID="lblmanualbillno" Text="Manual Bill No" CssClass="blackfnt" runat="server"></asp:Label></font></td>
                                <td><font class="blackfnt">&nbsp;<asp:TextBox ID="txtmanualbillno" MaxLength="25" runat="server"></asp:TextBox>
                                </font></td>
                            </tr>
                            <tr bgcolor="#ffffff">
                                <td><font class="blackfnt">
                                    <asp:Label ID="lblfromdate" Text="From Date" CssClass="blackfnt" runat="server"></asp:Label></font></td>
                                <td>
                                    <div align="left">
                                        <asp:TextBox ID="txtDateFrom" CssClass="input" runat="Server" onblur="javascript:ValidateForm(this)" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                        <a href="#" onclick="cal.select(ctl00_MyCPH1_txtDateFrom, 'alnkDateFrom', 'dd/MM/yyyy'); return false;" id="alnkDateFrom">
                                            <img src="../../../images/calendar.jpg" border="0" alt="" /></a>
                                        <font face="verdana" size="1">(dd/mm/yyyy)</font>
                                    </div>
                                </td>

                                <td height="19" valign="top" bgcolor="#FFFFFF"><font class="blackfnt">
                                    <asp:Label ID="lbltodate" Text="To Date" CssClass="blackfnt" runat="server"></asp:Label></font></td>
                                <td height="19" align="center" valign="top" bgcolor="#FFFFFF">
                                    <div align="left">
                                        <font class="blackfnt">&nbsp;<asp:TextBox ID="txttodate" CssClass="input" onblur="javascript:ValidateForm(this)" runat="server" Width="80"></asp:TextBox>
                                            <a href="#" onclick="cal.select(ctl00_MyCPH1_txttodate, 'alnkDateTo', 'dd/MM/yyyy'); return false;" id="alnkDateTo">
                                                <img src="../../../images/calendar.jpg" border="0" alt="" /></a></font>
                                        <font face="verdana" size="1">(dd/mm/yyyy)</font>
                                    </div>
                                </td>
                            </tr>
                            <tr bgcolor="#ffffff">
                                <td><font class="blackfnt">
                                    <asp:Label ID="lblbilldate" Text="Bill Date" CssClass="blackfnt" runat="server"></asp:Label></font></td>
                                <td>
                                    <div align="left">
                                        <asp:TextBox ID="txtbilldate" onblur="javascript:BillDate(this)" CssClass="input" runat="server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                        <a href="#" onclick="cal.select(ctl00_MyCPH1_txtbilldate, 'alnbilldate', 'dd/MM/yyyy'); return false;" id="alnbilldate">
                                            <img src="../../../images/calendar.jpg" border="0" alt="" /></a>
                                        <font face="verdana" size="1">(dd/mm/yyyy)</font>
                                    </div>
                                </td>
                                <td height="19" valign="top" bgcolor="#FFFFFF"><font class="blackfnt">
                                    <asp:Label ID="lblduedate" Text="Due Date" CssClass="blackfnt" runat="server"></asp:Label></font></td>
                                <td height="19" align="center" valign="top" bgcolor="#FFFFFF">
                                    <div align="left">
                                        <font class="blackfnt">&nbsp;<asp:TextBox ID="txtduedate" CssClass="input" onblur="javascript:ValidateForm(this)" runat="server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                            <a href="#" onclick="cal.select(ctl00_MyCPH1_txtduedate, 'alnduedate', 'dd/MM/yyyy'); return false;" id="alnduedate">
                                                <img src="../../../images/calendar.jpg" border="0" alt="" /></a></font>
                                        <font face="verdana" size="1">(dd/mm/yyyy)</font>
                                    </div>
                                </td>
                            </tr>
                            <tr bgcolor="#ffffff">
                                <td><font class="blackfnt">
                                    <asp:Label ID="lblparty" Text="Party" CssClass="blackfnt" runat="server"></asp:Label>
                                </font></td>
                                <td>
                                    <div align="left">
                                        <font class="blackfnt">
                                            <asp:TextBox ID="txtparty" runat="server" ValidationGroup="VGDtFromTo" onblur="javascript:PartyBlur(this,'party')" CssClass="input" Width="80"></asp:TextBox>
                                            <%--<asp:HiddenField ID="hdpartynm" runat="server"/>--%>
                                            <asp:Button ID="btnparty" runat="server" CssClass="input" Text="..." OnClientClick="javascript:return nwOpen(1)" />
                                            <%--<input tabIndex="1" type=button value="..." name=branchpopup onclick="fOpenInPopup('../../../webadmin/popup-branch.asp?7')">--%>
                                        </font>
                                    </div>
                                </td>
                                <td style="width: 178px"><font class="blackfnt">Aggrement No </font></td>
                                <td>
                                    <div align="left">
                                        <font class="blackfnt">&nbsp;<asp:TextBox ID="txtagrno" runat="server" ValidationGroup="VGDtFromTo"
                                            Width="80"></asp:TextBox></font>
                                    </div>
                                </td>
                            </tr>
                            <tr bgcolor="#ffffff">
                                <td><font class="blackfnt">
                                    <asp:Label ID="lblsubbranch" Text="Submission Branch" CssClass="blackfnt" runat="server"></asp:Label></font></td>
                                <td>
                                    <div align="left">
                                        <font class="blackfnt">
                                            <asp:TextBox ID="txtsubbranch" CssClass="input" onblur="javascript:PartyBlur(this,'loc')" runat="server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                            <asp:Button ID="btnsubbranch" CssClass="input" runat="server" Text="..." OnClientClick="javascript:nwOpen2(3)" />
                                            <%--<input tabIndex="1" type=button value="..." name=branchpopup onclick="fOpenInPopup('../../../webadmin/popup-branch.asp?7')">--%>
                                        </font>
                                    </div>
                                </td>
                                <td><font class="blackfnt">Bill Collection Branch</font></td>
                                <td>
                                    <div align="left">
                                        <font class="blackfnt">&nbsp;<asp:TextBox ID="txtbillcolbranch" runat="server" onblur="javascript:PartyBlur(this,'loc')" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                            <asp:Button ID="btnbillcol" CssClass="input" runat="server" Text="..." OnClientClick="javascript:nwOpen1(2)" />
                                            <%--<input tabIndex="1" type=button value="..." name=branchpopup onclick="fOpenInPopup('../../../webadmin/popup-branch.asp?7')">--%></font>
                                    </div>
                                </td>
                            </tr>
                            <tr bgcolor="#ffffff">
                                <td><font class="blackfnt">
                                    <asp:Label ID="lblpreat" Text="Prepared At" CssClass="blackfnt" runat="server"></asp:Label></font></td>
                                <td><font class="blackfnt">
                                    <asp:Label ID="lblhqtr" Text="HQTR : HEAD OFFICE" CssClass="blackfnt" runat="server"></asp:Label></font></td>
                                <td><font class="blackfnt">
                                    <asp:Label ID="lblpreby" Text="Prepared By" CssClass="blackfnt" runat="server"></asp:Label></font></td>
                                <td><font class="blackfnt">
                                    <asp:Label ID="lbladmin" Text="10001 : Administrator" CssClass="blackfnt" runat="server"></asp:Label></font></td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td bgcolor="white">
                <table width="86%" border="0" cellspacing="1" cellpadding="3" align="center" bgcolor="#808080" class="boxbg">
                    <tr class="bgbluegrey">
                        <td valign="top" height="18" colspan="4" align="center"><b><font class="blackfnt">
                            <asp:Label ID="lblbillchrgdtl" Text="Bill Charges Details" CssClass="blackfnt" runat="server"></asp:Label></font></b></td>
                    </tr>
                    <tr class="bgbluegrey">
                        <td valign="top" height="18" align="center" width="7%"><b><font class="blackfnt">
                            <asp:Label ID="lblsrno" Text="Sr No" CssClass="blackfnt" runat="server"></asp:Label></font></b></td>
                        <td valign="top" height="18" align="center" width="61%"><b><font class="blackfnt">
                            <asp:Label ID="lblbillhead" Text="Billing Head" CssClass="blackfnt" runat="server"></asp:Label></font></b></td>
                        <td valign="top" height="18" align="center" width="32%"><b><font class="blackfnt">
                            <asp:Label ID="lblamtrs" Text="Amount In Rs." CssClass="blackfnt" runat="server"></asp:Label></font></b></td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td width="7%" class="" height="36">
                            <div align="center"><font class="blackfnt">1</font></div>
                        </td>
                        <td width="61%" height="36"><font class="blackfnt">
                            <asp:Label ID="lblvehdetchrg" Text="Vehicle Detention Charges" CssClass="blackfnt" runat="server"></asp:Label></font></td>
                        <td width="32%" class="" height="36"><font class="blackfnt">
                            <asp:TextBox ID="vehdetchrg" CssClass="input" runat="server" ValidationGroup="VGDtFromTo" Width="80" Text="0.00" onblur="javascript:fcalbillamt()" onchange="javascript:return Nagative_Chk_wDecimal(this)" TabIndex="1"></asp:TextBox>
                        </font></td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td width="7%" class="">
                            <div align="center"><font class="blackfnt">2</font></div>
                        </td>
                        <td width="61%"><font class="blackfnt">
                            <asp:Label ID="lblwarehousingchrg" Text="Ware Housing Charges" CssClass="blackfnt" runat="server"></asp:Label></font></td>
                        <td width="32%" class=""><font class="blackfnt">
                            <asp:TextBox ID="warechrg" CssClass="input" runat="server" ValidationGroup="VGDtFromTo" Width="80" Text="0.00" onblur="javascript:fcalbillamt()" onchange="javascript:return Nagative_Chk_wDecimal(this)" TabIndex="2"></asp:TextBox>

                        </font></td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td width="7%" class="">
                            <div align="center"><font class="blackfnt">3</font></div>
                        </td>
                        <td width="61%"><font class="blackfnt">
                            <asp:Label ID="lbldismangchar" Text="Disaster management charges" CssClass="blackfnt" runat="server"></asp:Label></font></td>
                        <td width="32%" class=""><font class="blackfnt">
                            <asp:TextBox ID="dischrg" CssClass="input" runat="server" ValidationGroup="VGDtFromTo" Width="80" Text="0.00" onblur="javascript:fcalbillamt()" onchange="javascript:return Nagative_Chk_wDecimal(this)" TabIndex="3"></asp:TextBox>

                        </font></td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td width="7%" class="">
                            <div align="center"><font class="blackfnt">4</font></div>
                        </td>
                        <td width="61%"><font class="blackfnt">
                            <asp:Label ID="lblhandchrg" Text="Handling charges" CssClass="blackfnt" runat="server"></asp:Label></font></td>
                        <td width="32%" class=""><font class="blackfnt">
                            <asp:TextBox ID="handchrg" CssClass="input" runat="server" ValidationGroup="VGDtFromTo" Width="80" Text="0.00" onblur="javascript:fcalbillamt()" onchange="javascript:return Nagative_Chk_wDecimal(this)" TabIndex="4"></asp:TextBox>

                        </font></td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td width="7%" class="">
                            <div align="center"><font class="blackfnt">5</font></div>
                        </td>
                        <td width="61%"><font class="blackfnt">
                            <asp:Label ID="lblrenchrg" Text="Rental charges" CssClass="blackfnt" runat="server"></asp:Label></font></td>
                        <td width="32%" class=""><font class="blackfnt">
                            <asp:TextBox ID="rentalchrg" CssClass="input" runat="server" ValidationGroup="VGDtFromTo" Width="80" Text="0.00" onblur="javascript:fcalbillamt()" onchange="javascript:return Nagative_Chk_wDecimal(this)" TabIndex="5"></asp:TextBox>

                        </font></td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td width="7%" class="">
                            <div align="center"><font class="blackfnt">6</font></div>
                        </td>
                        <td width="61%"><font class="blackfnt">
                            <asp:Label ID="lblotherchrg" Text="Other charges" CssClass="blackfnt" runat="server"></asp:Label></font></td>
                        <td width="32%" class=""><font class="blackfnt">
                            <asp:TextBox ID="otherchrg" CssClass="input" runat="server" ValidationGroup="VGDtFromTo" Width="80" Text="0.00" onblur="javascript:fcalbillamt()" onchange="javascript:return Nagative_Chk_wDecimal(this)" TabIndex="6"></asp:TextBox>

                        </font></td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td width="7%" class="">&nbsp;</td>
                        <td width="61%"><font class="blackfnt">
                            <asp:Label ID="lblsubtotal" Text="SubTotal" CssClass="blackfnt" runat="server"></asp:Label></font></td>
                        <td width="32%" class=""><font class="blackfnt">
                            <asp:TextBox ID="subtotal" CssClass="input" Enabled="false" runat="server" ValidationGroup="VGDtFromTo" Width="80" Text="0.00" onchange="javascript:return Nagative_Chk_wDecimal(this)"></asp:TextBox>

                        </font></td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td width="7%" class="blckfnt" colspan="3"><font class="redfnt"><strong>
                            <asp:CheckBox runat="server" ID="svctax_yn" Checked="true" />
                            Check here to Apply Service tax Deatils On Sub Total
                            <br />
                        </strong></font></td>

                    </tr>
                    <tr bgcolor="#ffffff">
                        <td width="7%" class="">&nbsp;</td>
                        <td width="61%"><font class="blackfnt">
                            <asp:Label ID="lblservicetax" Text="Service Tax" CssClass="blackfnt" runat="server"></asp:Label></font></td>
                        <td width="32%" class=""><font class="blackfnt">
                            <asp:TextBox ID="sertax" CssClass="input" Enabled="false" runat="server" ValidationGroup="VGDtFromTo" Width="80" Text="0.00" onblur="javascript:fcalbillamt(this)" onchange="javascript:return Nagative_Chk_wDecimal(this)" TabIndex="7"></asp:TextBox>

                        </font></td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td width="7%" class="">&nbsp;</td>
                        <td width="61%"><font class="blackfnt">
                            <asp:Label ID="lblcess" Text="Cess" CssClass="blackfnt" runat="server"></asp:Label></font></td>
                        <td width="32%" class=""><font class="blackfnt">
                            <asp:TextBox ID="cess" CssClass="input" Enabled="false" runat="server" ValidationGroup="VGDtFromTo" Width="80" Text="0.00" onblur="javascript:fcalbillamt()" onchange="javascript:return Nagative_Chk_wDecimal(this)" TabIndex="8"></asp:TextBox>

                        </font></td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td width="7%" class="">&nbsp;</td>
                        <td width="61%"><font class="blackfnt">
                            <asp:Label ID="Label1" Text="HIgher Edu.Cess" CssClass="blackfnt" runat="server"></asp:Label></font></td>
                        <td width="32%" class=""><font class="blackfnt">
                            <asp:TextBox ID="H_cess" CssClass="input" Enabled="false" runat="server" ValidationGroup="VGDtFromTo" Width="80" Text="0.00" onblur="javascript:fcalbillamt()" onchange="javascript:return Nagative_Chk_wDecimal(this)" TabIndex="8"></asp:TextBox>

                        </font></td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td width="7%" class="">&nbsp;</td>
                        <td width="61%"><font class="blackfnt">
                            <asp:Label ID="Label111" Text="Swachh Bharat Cess" CssClass="blackfnt" runat="server"></asp:Label></font></td>
                        <td width="32%" class=""><font class="blackfnt">
                    			<asp:TextBox ID="SBC" CssClass="input" Enabled="false" runat="server" ValidationGroup="VGDtFromTo" Width="80" Text="0.00" onblur="javascript:fcalbillamt()" onchange="javascript:return Nagative_Chk_wDecimal(this)" TabIndex="8"></asp:TextBox>

                        </font></td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td width="7%" class="">&nbsp;</td>
                        <td width="61%"><font class="blackfnt">
                            <asp:Label ID="lblKKC" Text="Krishi Kalyan Cess" CssClass="blackfnt" runat="server"></asp:Label></font></td>
                        <td width="32%" class=""><font class="blackfnt">
                    			<asp:TextBox ID="KKC" CssClass="input" Enabled="false" runat="server" ValidationGroup="VGDtFromTo" Width="80" Text="0.00" onblur="javascript:fcalbillamt()" onchange="javascript:return Nagative_Chk_wDecimal(this)" TabIndex="8"></asp:TextBox>

                        </font></td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td width="7%" class="">&nbsp;</td>
                        <td width="61%"><font class="blackfnt">
                            <asp:Label ID="lbltotal" Text="TOTAL" CssClass="blackfnt" runat="server"></asp:Label></font></td>
                        <td width="32%" class=""><font class="blackfnt">
                            <asp:TextBox ID="totalchrg" CssClass="input" Enabled="false" runat="server" ValidationGroup="VGDtFromTo" Text="0.00" Width="80"></asp:TextBox>

                        </font></td>
                    </tr>

                </table>
            </td>

        </tr>
        <tr>
            <td bgcolor="white" align="center">
                <asp:Button ID='submit' Text="Submit" runat="server" OnClick="submit_Click" />
                <asp:HiddenField ID="HdnServiceTaxRate" runat="server" />
                <asp:HiddenField ID="HdnEduCessRate" runat="server" />
                <asp:HiddenField ID="HdnHEduCessRate" runat="server" />
                <asp:HiddenField ID="HdnSBCRate" runat="server" />
                <asp:HiddenField ID="HdnKKCRate" runat="server" />
            </td>
        </tr>

    </table>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;"></div>

</asp:Content>

