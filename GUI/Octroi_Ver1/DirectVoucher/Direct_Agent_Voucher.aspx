<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Direct_Agent_Voucher.aspx.cs" Inherits="GUI_Octroi_Ver1_Octroi_Bill_Direct_Agent_Voucher" %>

<%@ Register Src="../../Common_UserControls/OctroiBillEntry.ascx" TagName="OctroiBillEntry"
    TagPrefix="uc1" %>
<%@ Register TagPrefix="UC5" TagName="UCMyPaymentControl" Src="~/UserControls/Webx_PaymentControl.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="JavaScript" src="../../Images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript">

        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

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

        function validDate(id) {

            var txtdate = document.getElementById(id);
            if (!isValidDate(txtdate.value, "Date"))
                txtdate.focus();
            return false;
        }

        function validGridDate(id) {

            var txtdate = document.getElementById(id);
            if (!isValidDate(txtdate.value, "Date"))
                txtdate.focus();

            var grid = document.getElementById("ctl00_MyCPH1_OctroiBillEntry1_gvBillEntry");
            var rows = grid.rows.length;
            var FormName = "ctl00$MyCPH1$OctroiBillEntry1$gvBillEntry$ctl"; //02$txtoctamt"	        
            var total_octamt = 0;
            var octamount = 0;
            for (i = 0; i < rows - 2; i++) {
                j = i + 2;
                if (j < 10) {
                    GV_frmname = FormName + "0" + j + "$"
                }
                else {
                    GV_frmname = FormName + j + "$"
                }

                octamount = document.getElementById(GV_frmname + "txtoctamt").value;
                document.getElementById(GV_frmname + "hidoctamt").value = octamount;

                var rcpno = document.getElementById(GV_frmname + "txtrcpno").value;
                document.getElementById(GV_frmname + "hidrcpno").value = rcpno;

                var rcpdt = document.getElementById(GV_frmname + "txtrcpdt").value;
                document.getElementById(GV_frmname + "hidrcpdt").value = rcpdt;
            }
            return false;
        }

        function Add_Value() {
            var txtoctamt = document.getElementById("ctl00_MyCPH1_octamt");
            var txtOtherCharges = document.getElementById("ctl00_MyCPH1_txtOtherCharges");
            var txtnetpay = document.getElementById("ctl00_MyCPH1_txtnetpay");
            var hidNetPay = document.getElementById("ctl00_MyCPH1_hidNetPay");

            if ((txtOtherCharges.value) < 0) {
                alert("Please Enter Positive Value");
                txtOtherCharges.focus();
                return false;
            }

            var grid = document.getElementById("ctl00_MyCPH1_OctroiBillEntry1_gvBillEntry");
            var rows = grid.rows.length;
            var FormName = "ctl00$MyCPH1$OctroiBillEntry1$gvBillEntry$ctl";

            var total_octamt = 0;
            var octamount = 0;

            for (i = 0; i < rows - 2; i++) {
                j = i + 2;
                if (j < 10) {
                    GV_frmname = FormName + "0" + j + "$"
                }
                else {
                    GV_frmname = FormName + j + "$"
                }

                octamount = document.getElementById(GV_frmname + "txtoctamt").value;
                document.getElementById(GV_frmname + "hidoctamt").value = octamount;

                var rcpno = document.getElementById(GV_frmname + "txtrcpno").value;
                document.getElementById(GV_frmname + "hidrcpno").value = rcpno;

                var rcpdt = document.getElementById(GV_frmname + "txtrcpdt").value;
                document.getElementById(GV_frmname + "hidrcpdt").value = rcpdt;

                if (octamount == "") {
                    octamount = 0;
                }
                if (document.getElementById(GV_frmname + "txtdockno").value != "") {
                    total_octamt = parseFloat(total_octamt) + parseFloat(octamount);
                }
            }
            k = j + 1;
            if (k < 10) {
                GV_frmname1 = FormName + "0" + k + "$"
            }
            else {
                GV_frmname1 = FormName + k + "$"
            }
            document.getElementById(GV_frmname1 + "txttot").value = total_octamt;

            //Assign Grid Total Octroi Amount to Octroi Paid Rs TextBox
            txtoctamt.value = total_octamt;

            // Sum of Other Charges and Grid Octroi Total
            txtnetpay.value = parseFloat(txtOtherCharges.value) + parseFloat(document.getElementById(GV_frmname1 + "txttot").value);

            //Assign Net Payable to Hidden Field
            hidNetPay.value = txtnetpay.value;
        }


        function getDockData(txtid) {
            debugger;
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
                strpg = "AjaxResponse.aspx?mode=data&code1=octdet&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();

                findobj.open("GET", strpg);
                findobj.onreadystatechange = function() {
                    if ((findobj.readyState == 4) && (findobj.status == 200)) {
                        var res = findobj.responseText.split("|");
                        if (res[0] == "false") {
                            var hidDockDate = document.getElementById(pref + "hidDockDate");
                            var hidStatus = document.getElementById(pref + "hidStatus");
                            hidDockDate.value = res[1];
                            hidStatus.value = res[2];
                            hdnajaxstate.value = "0";
                            return false;
                        }
                        else if (res[0] == "true") {
                            hdnajaxstate.value = "0";
                            var txtoctamt = document.getElementById(pref + "txtoctamt");
                            var txtrcpno = document.getElementById(pref + "txtrcpno");
                            var txtrcpdt = document.getElementById(pref + "txtrcpdt");

                            var hidoctamt = document.getElementById(pref + "hidoctamt");
                            var hidrcpno = document.getElementById(pref + "hidrcpno");
                            var hidrcpdt = document.getElementById(pref + "hidrcpdt");
                            var hidDockDate = document.getElementById(pref + "hidDockDate");
                            var hidStatus = document.getElementById(pref + "hidStatus");

                            txtoctamt.value = res[1];
                            txtoctamt.disabled = true;
                            hidoctamt.value = txtoctamt.value;

                            txtrcpno.value = res[2];
                            txtrcpno.disabled = true;
                            hidrcpno.value = txtrcpno.value;

                            txtrcpdt.value = res[3];
                            txtrcpdt.disabled = true;
                            hidrcpdt.value = txtrcpdt.value;

                            hidDockDate.value = res[4];
                            hidStatus.value = res[5];
                            checkDocketNo(txt);
                            Add_Value();
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
                    }
                }

                findobj.send(null);
            }
            return true;
        }

        function checkDocketNo(obj) {
            var grid = document.getElementById("ctl00_MyCPH1_OctroiBillEntry1_gvBillEntry");
            var rows = grid.rows.length;
            var FormName = "ctl00$MyCPH1$OctroiBillEntry1$gvBillEntry$ctl";
            var count = 0;

            for (i = 0; i < rows - 2; i++) {
                j = i + 2;
                if (j < 10) {
                    GV_frmname = FormName + "0" + j + "$"
                }
                else {
                    GV_frmname = FormName + j + "$"
                }

                var txtdockno = document.getElementById(GV_frmname + "txtdockno");
                var txtoctamt = document.getElementById(GV_frmname + "txtoctamt");
                var txtrcpno = document.getElementById(GV_frmname + "txtrcpno");
                var txtrcpdt = document.getElementById(GV_frmname + "txtrcpdt");

                if (obj.value == txtdockno.value) {
                    count = count + 1;
                    if (count > 1) {
                        alert("Docket No already entered.");
                        obj.value = "";
                        txtoctamt.value = "";
                        txtrcpno.value = "";
                        txtrcpdt.value = "";
                        obj.focus();
                        return false;
                    }
                }
            }
        }
    
    </script>

    <div style="width: 9.5in">
        <br />
        <table>
            <tr>
                <td>
                    <asp:Panel ID="pnlerror" Visible="false" runat="server">
                        <table width="90%">
                            <tr>
                                <td align="center">
                                    <asp:Label ID="Error" ForeColor="red" Text="Error:" Font-Bold="true" runat="server"></asp:Label>
                                    <br />
                                    <asp:Label ID="lblerr" ForeColor="red" Font-Bold="true" runat="server"></asp:Label>
                                    <br />
                                    <br />
                                    <asp:Label ID="Label4" Text="Please Try Again....." runat="server"></asp:Label>
                                    <br />
                                    <br />
                                    <asp:Button ID="Button1" Text="OK" runat="server" Width="170" OnClick="btn_ok_Click" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <br />
            <tr>
                <td>
                    <asp:Panel ID="pnlHeader" runat="server">
                        <br />
                        <br />
                        <table border="0" cellpadding="3" cellspacing="1" class="boxbg" width="800" align="left">
                            <tr class="bgbluegrey">
                                <td colspan="4" align="center" style="height: 21px">
                                    <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">
                                     Octroi Payment Voucher Summary
                                    </asp:Label>
                                </td>
                            </tr>
                            <tr bgcolor="white" style="height: 25px">
                                <td style="width: 200px">
                                    <font class="blackfnt">Payment Voucher Number</font>
                                </td>
                                <td style="width: 195px">
                                    <font class="blackfnt" color="red">System Generated...</font>
                                </td>
                                <td style="width: 200px">
                                    <font class="blackfnt">Voucher Date</font>
                                </td>
                                <td>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:TextBox ID="txtbgndt" Width="65px" runat="server" MaxLength="10" BorderStyle="Groove"
                                                    CssClass="blackfnt" onblur="javascript:return validDate()"></asp:TextBox>
                                            </td>
                                            <td>
                                                <a href="#" onclick="cal.select(ctl00$MyCPH1$txtbgndt,'anchor3','dd/MM/yyyy'); return false;"
                                                    name="anchor3" id="a1">
                                                    <img src="./../../images/calendar.jpg" border="0"></img>
                                                </a>
                                            </td>
                                            <td>
                                                <font class="blackfnt">dd/mm/yyyy</font>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr bgcolor="white" style="height: 25px">
                                <td>
                                    <font class="blackfnt">Octroi Agent </font>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtOctAgent" runat="server" Width="170px" TabIndex="1" BorderStyle="Groove"
                                        CssClass="blackfnt"></asp:TextBox>
                                    <%--<atlas:AutoCompleteExtender runat="server" ID="Extender1">
                                        <atlas:AutoCompleteProperties Enabled="True" TargetControlID="txtOctAgent" ServiceMethod="GetOctroiVendor"
                                            ServicePath="../AtlasAutoComplete.asmx" MinimumPrefixLength="1" />
                                    </atlas:AutoCompleteExtender>--%>
                                    <ajaxToolkit:AutoCompleteExtender ID="Extender1" runat="server" Enabled="True" MinimumPrefixLength="1"
                                        ServiceMethod="GetOctroiVendor" CompletionListItemCssClass="autocomplete_listItem"
                                        CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" ServicePath="../AtlasAutoComplete.asmx"
                                        TargetControlID="txtOctAgent">
                                    </ajaxToolkit:AutoCompleteExtender>
                                </td>
                                <td>
                                    <font class="blackfnt">Paid To </font>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtPaidTo" runat="server" Width="150px" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                </td>
                            </tr>
                            <tr bgcolor="white" style="height: 25px">
                                <td>
                                    <font class="blackfnt">Octroi paid Rs.</font>
                                </td>
                                <td>
                                    <font class="blackfnt">
                                        <asp:TextBox ID="octamt" runat="server" Enabled="false" Width="100px" BorderStyle="Groove"
                                            CssClass="blackfnt" Style="text-align: right">0</asp:TextBox>
                                        <asp:HiddenField ID="hidOctamt" runat="server" />
                                    </font>
                                </td>
                                <td>
                                    <font class="blackfnt">Other Charges</font>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtOtherCharges" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                        onblur="javascript:return Add_Value()" runat="server" Width="91px" BorderStyle="Groove"
                                        CssClass="blackfnt" Style="text-align: right">0</asp:TextBox>
                                </td>
                            </tr>
                            <tr bgcolor="white" style="height: 25px">
                                <td>
                                    <font class="blackfnt">TDS Type</font>
                                </td>
                                <td>
                                    <font class="blackfnt">
                                        <asp:DropDownList ID="ddlTDSType" CssClass="blackfnt" runat="server" Mode="Conditional"
                                            RenderMode="Inline" Width="152px">
                                        </asp:DropDownList>
                                    </font>
                                </td>
                                <td>
                                    <font class="blackfnt">TDS Deducted For</font>
                                </td>
                                <td>
                                    <asp:DropDownList ID="cboTDSDeducted" CssClass="blackfnt" runat="server" Mode="Conditional"
                                        RenderMode="Inline" Width="152px">
                                        <asp:ListItem Text="Corporate" Value="C" Selected="true"></asp:ListItem>
                                        <asp:ListItem Text="NonCorporate" Value="NC"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr bgcolor="white" style="height: 25px">
                                <td>
                                    <font class="blackfnt">Net Payable </font>
                                    <asp:HiddenField ID="hidNetPay" runat="server" />
                                </td>
                                <td>
                                    <font class="blackfnt">
                                        <asp:TextBox ID="txtnetpay" runat="server" Width="100px" Enabled="false" BorderStyle="Groove"
                                            CssClass="blackfnt" Style="text-align: right">0</asp:TextBox></font>
                                </td>
                                <td>
                                    <font class="blackfnt"></font>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <uc1:OctroiBillEntry ID="OctroiBillEntry1" runat="server" />
                </td>
            </tr>
            <tr id="Payment_Row4" runat="server">
                <td align="left">
                    <asp:UpdateProgress ID="uppMain" runat="server">
                        <ProgressTemplate>
                            <iframe frameborder="1" src="about:blank" style="border: 0px; position: absolute;
                                z-index: 9; left: 0px; top: 0px; width: expression(this.offsetParent.scrollWidth);
                                height: expression(this.offsetParent.scrollHeight); filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);">
                            </iframe>
                            <div style="position: absolute; z-index: 10; left: expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);
                                top: expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
                                <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                                    -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                                    <tr>
                                        <td align="right">
                                            <img src="../../images/loading.gif" alt="" />
                                        </td>
                                        <td>
                                            <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                    <asp:HiddenField ID="Hnd_Doc_type" runat="server" />
                </td>
            </tr>
            <tr id="Payment_Row3" runat="server">
                <td>
                    <asp:UpdatePanel ID="UpdatePanePayment" UpdateMode="Conditional" RenderMode="Inline"
                        runat="server">
                        <ContentTemplate>
                            <br />
                            <table border="0" cellspacing="1" cellpadding="3" width="800" align="left" class="boxbg">
                                <font class="blackfnt">Note : Please enter the payment details if Net Payable amount
                                    > 0.</font>
                                <tr class="bgbluegrey">
                                    <td colspan="4" align="center">
                                        <font class="blackfnt"><b>Payment Details</font>
                                    </td>
                                </tr>
                                <tr style="background-color: #FFFFFF">
                                    <td colspan="4" align="center">
                                        <UC5:UCMyPaymentControl ID="UCMyPaymentControl1" runat="server"></UC5:UCMyPaymentControl>
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <table align="left" cellspacing="1" cellpadding="3" width="800" class="boxbg" border="0"
                        id="ON_Submit" runat="server">
                        <tr class="bgbluegrey">
                            <td colspan="4" align="center" style="height: 21px">
                                <asp:Button ID="btn_submit" Text="Submit" OnClick="btnSubmit_Click" BorderStyle="Groove"
                                    CssClass="blackfnt" OnClientClick="javascript:return OnSubmit_BillEntryPayment()"
                                    runat="server" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hdnajaxstate" runat="server" />
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
