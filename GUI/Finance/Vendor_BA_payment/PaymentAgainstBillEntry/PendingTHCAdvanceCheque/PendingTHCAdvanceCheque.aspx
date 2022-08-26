<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="PendingTHCAdvanceCheque.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_PaymentAgainstBillEntry_PendingTHCAdvanceCheque_PendingTHCAdvanceCheque" %>

<%@ Register TagPrefix="UC5" TagName="UCMyPaymentControl" Src="~/UserControls/MyPaymentControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript" src="../../../../images/commonJs.js"></script>
    <script language="javascript" type="text/javascript" src="../../../../images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>
    <script language="javascript" type="text/javascript">
        var checkSelection = 0, Cprev;

        var Form_name = "ctl00$MyCPH1$"
        frm_name = "ctl00$MyCPH1$"
        var months = new Array("", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
        var client_name = "<%=Session["Client"]%>"
        var Fromdate = "<%=Fromdt%>"
        //alert(Fromdate)
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

        function AdvChqAmountAmtCalc() {
        }

        var currentTime = new Date()
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

        function calculation(a, b, c, d) {
            if (document.getElementById(d).checked == false) {
                document.getElementById(c).disabled = true

                var rows1 = document.getElementById("ctl00_MyCPH1_BillDetail").rows.length;
                //alert("rows1 : " + rows1)
                if (rows1 <= 9) {
                    var id1 = "ctl00_MyCPH1_BillDetail_ctl0" + rows1 + "_txtTotal"
                }
                else {
                    var id1 = "ctl00_MyCPH1_BillDetail_ctl" + rows1 + "_txtTotal"
                }

                //alert("hi1");
                document.getElementById(id1).value = parseFloat(document.getElementById(id1).value) - document.getElementById(c).value
                //document.getElementById('ctl00_MyCPH1_netamt').value=0;
                //alert("a : " + a);
                //alert("b : " + b);
                //alert("c : " + c);
                //alert("d : " + d);
                document.getElementById('ctl00_MyCPH1_netamt').value = document.getElementById(id1).value;//parseFloat(document.getElementById('ctl00_MyCPH1_netamt').value) - parseFloat(document.getElementById(a).innerText)
                //alert(document.getElementById(a).innerText);
                //alert(document.getElementById(b).innerText)
                //alert(document.getElementById(c).innerText)
                //sdocument.getElementById('ctl00_MyCPH1_netamt').value = parseFloat(document.getElementById(a).innerText) - parseFloat(document.getElementById(b).innerText)- parseFloat(document.getElementById(c).innerText)
                document.getElementById(c).value = 0

            }
            else {
                //alert("hi-1")
                document.getElementById(c).disabled = true
                var tot
                var varnetamt = document.getElementById(a).innerText
                var varpendamt = document.getElementById(b).innerText
                if (varpendamt == "") {
                    varpendamt = 0;
                    tot = parseFloat(varnetamt) - parseFloat(varpendamt)

                }
                tot = parseFloat(varnetamt) - parseFloat(varpendamt)

                document.getElementById(c).value = tot

                var rows = document.getElementById("ctl00_MyCPH1_BillDetail").rows.length;

                if (rows <= 9) {
                    var id = "ctl00_MyCPH1_BillDetail_ctl0" + rows + "_txtTotal"
                }
                else {
                    var id = "ctl00_MyCPH1_BillDetail_ctl" + rows + "_txtTotal"
                }
                document.getElementById(id).value = parseFloat(tot)
            }
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


        function fsubmit() {
            //debugger
            var mTotalRecords = "<%=intTotalRecords%>"

            var server_dt = "<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"

            var mDerivedControlName = "";
            var mCurrPaymentControlName = "";
            var mBillDateControlName = "";

            var mnetamtControlName = "";
            var mAdvpaidControlName = "";
            var TotNetPayment = 0;
            var mSelection = 0;
            var j = 0;
            var mSelectedDockets = "";

            var mBillDate = "";
var mTotalRecords2 = document.getElementById("ctl00_MyCPH1_hdnTHCNoId").value;
 var CurrPayment = 0;
                    mDerivedControlName = "ctl00_MyCPH1_BillDetail_ctl" + mTotalRecords2 + "_chkBill"
                    mCurrPaymentControlName = "ctl00_MyCPH1_BillDetail_ctl" + mTotalRecords2 + "_txtCurrPayment"
                    mnetamtControlName = "ctl00_MyCPH1_BillDetail_ctl" + mTotalRecords2 + "_nettotamt"
                    mAdvpaidControlName = "ctl00_MyCPH1_BillDetail_ctl" + mTotalRecords2 + "_Advpaid"

                if (document.getElementById(mDerivedControlName)) {
                    if (document.getElementById(mDerivedControlName).checked == true) {
                        if (mSelection == 0) {
                            mSelection = 1;
                        }
                        else {
                            mSelection = mSelection + 1
                        }
                        CurrPayment = parseFloat(CurrPayment) + parseFloat(document.getElementById(mCurrPaymentControlName).value);
                        TotNetPayment = parseFloat(TotNetPayment) + parseFloat(CurrPayment);
                        mSelectedDockets = (mSelectedDockets == "" ? document.getElementById(mDerivedControlName).value : mSelectedDockets + "," + document.getElementById(mDerivedControlName).value);

                        var balamt = "";
                        balamt = parseFloat(document.getElementById(mnetamtControlName).value) - parseFloat(document.getElementById(mAdvpaidControlName).value);
                        if (parseFloat(CurrPayment) > parseFloat(balamt)) {
                            alert("Current payment can not be greater than " + balamt);
                            document.getElementById(mCurrPaymentControlName).focus();
                            return false;
                        }

                        //start
                            var dgAdvanceCheque = document.getElementById("ctl00_MyCPH1_dgAdvanceCheque");
                            var totChqAmount = 0;
                            for (i = 2; i <= dgAdvanceCheque.rows.length; i++) {
                                pref = "ctl00_MyCPH1_dgAdvanceCheque_ctl0" + i + "_";
                                var txtAmount = document.getElementById(pref + "txtAmount");
                                if (parseFloat(txtAmount.value) >= 0) {
                                    totChqAmount = parseFloat(parseFloat(totChqAmount) + parseFloat(txtAmount.value));
                                }
                            }
                            if (parseFloat(totChqAmount) > parseFloat(balamt)) {
                                alert("Total cheque amount can not be greater than Current  cheque Amount "); return false;
                            }
                            if (parseFloat(totChqAmount) < parseFloat(balamt)) {
                                alert("Total cheque amount can not be Less than Current  cheque Amount "); return false;
                            }

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

                        //end
                    }
                }

                
            
if (mSelection == 0) {
                alert("Select atleast one Thc!");
                return false;
            }
            if (confirm("Do you want to submit") == false) {
                return false;
            }

            click_count = parseFloat(document.getElementById(Form_name + "click_count").value)
            if (click_count > 0) {
                alert("Sorry... You cannot click twice !!!")
                return false;
            }
            else {
                click_count = click_count + 1
                document.getElementById(Form_name + "click_count").value = click_count
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
        function ValidateDate(obj) {
            if (obj.value != "") {
                if (isDate(obj.value) == false) {
                    obj.focus();
                    return false;
                }
                return true;
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
            return this;
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
        function stripCharsInBag(s, bag) {
            var i;
            var returnString = "";
            // Search through string's characters one by one.
            // If character is not in bag, append to returnString.
            for (i = 0; i < s.length; i++) {
                var c = s.charAt(i);
                if (bag.indexOf(c) == -1) returnString += c;
            }
            return returnString;
        }
        function isInteger(s) {
            var i;
            for (i = 0; i < s.length; i++) {
                // Check that current character is number.
                var c = s.charAt(i);
                if (((c < "0") || (c > "9"))) return false;
            }
            // All characters are numbers.
            return true;
        }

        function RadioCheck(rb, a, b, c, d) {
            // debugger
            document.getElementById("ctl00_MyCPH1_hdnTHCNo").value = rb.value;
             var rowId = a.substring(27);
             document.getElementById("ctl00_MyCPH1_hdnTHCNoId").value = rowId.substr(0, rowId.length - 7)
            Cprev = c;
            document.getElementById(c).disabled = true;
            document.getElementById(c).value = 0;
            checkSelection = 1;
            var gv = document.getElementById("<%=BillDetail.ClientID%>");
            var rbs = gv.getElementsByTagName("input");

            var row = rb.parentNode.parentNode;
            for (var i = 0; i < rbs.length; i++) {
                if (rbs[i].type == "radio") {
                    if (rbs[i].checked && rbs[i] != rb) {
                        rbs[i].checked = false;
                        break;
                    }
                }
            }
        }
        function CheckDocketSelection() {
            document.getElementById('ctl00_MyCPH1_divAdvanceCheque').removeAttribute('style');
            if (checkSelection == 0) {
                alert("Select atleast one Document ....!");
                return false;
            }
            else
                return true;
        }
        function OpenPopup(thcno) {
            window.open("AdvanceTHCView.aspx?thcno=" + thcno, "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");

        }
    </script>



    <br />
    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <iframe frameborder="0" src="about:blank"
                style="border: 0px; position: absolute; z-index: 9; left: 0px; top: 0px; width: expression(this.offsetParent.scrollWidth); height: expression(this.offsetParent.scrollHeight); filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
            <div style="position: absolute; z-index: 10; left: expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft); top: expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
                <img src="../../../../images/loading.gif" /><font face="verdana" color="blue" size="4">&nbsp;<b>Please Wait...</b></font>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <div align="left">

        <table>
            <tr>
                <td>
                    <table border="0" cellspacing="1" cellpadding="4" style="width: 10.5in" align="left" class="boxbg">
                        <tr class="bgbluegrey">
                            <td colspan="4" align="center"><font class="blackfnt"><b>Pending THC Advance (Cheque)  Details</b> </font></td>
                        </tr>
                    </table>
                    <br />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                            <asp:GridView ID="BillDetail" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
                                AllowSorting="true" AllowPaging="true" PageSize="1000" PagerStyle-HorizontalAlign="left"
                                CssClass="boxbg" BackColor="white" FooterStyle-CssClass="bgbluegrey"
                                PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" ShowFooter="true"
                                EmptyDataText="No Records Found..." Style="width: 10.5in" OnRowCreated="BillDetail_RowCreated">
                                <Columns>
                                    <asp:TemplateField FooterStyle-CssClass="bgbluegrey">
                                        <ItemTemplate>
                                            <center>
                                                <asp:RadioButton ID="chkBill" runat="server" class="input" value='<%# DataBinder.Eval(Container.DataItem,"ThcNo") %>' />
                                            </center>
                                            <asp:HiddenField ID="vendorcode" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"vendorcode") %>' />
                                            <asp:HiddenField ID="vendorname" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"vendorname") %>' />
                                            <asp:HiddenField ID="Acccode" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"Acccode") %>' />
                                        </ItemTemplate>

                                    </asp:TemplateField>


                                    <asp:TemplateField HeaderText="THC No." HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <font class="blackfnt">
                                                 <a href="JavaScript:OpenPopup('<%#DataBinder.Eval(Container.DataItem, "ThcNo") %>')">
                                                         <%#DataBinder.Eval(Container.DataItem, "ThcNo")%></a>
                                                <asp:Label ID="THCNo" Text='<%# DataBinder.Eval(Container.DataItem,"ThcNo") %>' runat="server" Visible="false"></asp:Label>
                                            </font>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:BoundField DataField="vehno" HeaderText="Vehicle No." FooterStyle-CssClass="bgbluegrey">
                                        <HeaderStyle HorizontalAlign="left" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ManualTHCNo" HeaderText="Manual THC No." FooterStyle-CssClass="bgbluegrey">
                                        <HeaderStyle HorizontalAlign="left" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="sourcehb" HeaderText="Branch" FooterStyle-CssClass="bgbluegrey">
                                        <HeaderStyle HorizontalAlign="left" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="pcamt" HeaderText="Contract Amount" FooterStyle-CssClass="bgbluegrey">
                                        <HeaderStyle HorizontalAlign="left" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="advamt" HeaderText="Thc Advance" FooterStyle-CssClass="bgbluegrey">
                                        <HeaderStyle HorizontalAlign="left" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="AdvanceCash" HeaderText="Advance Cash Amount" FooterStyle-CssClass="bgbluegrey">
                                        <HeaderStyle HorizontalAlign="left" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="AdvanceCheque" HeaderText="Advance cheque paid amount" FooterStyle-CssClass="bgbluegrey">
                                        <HeaderStyle HorizontalAlign="left" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="OtherAdvance" HeaderText="Advance other amount" FooterStyle-CssClass="bgbluegrey" >
                                        <HeaderStyle HorizontalAlign="left" Wrap="False" CssClass="blackfnt"  />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                    </asp:BoundField>

                                    <asp:TemplateField HeaderText="Advance Cheque Balance Amount" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <font class="blackfnt">
                                                <asp:Label ID="netamt" Text='<%# DataBinder.Eval(Container.DataItem,"netamt") %>' runat="server"></asp:Label>
                                                <asp:HiddenField ID="nettotamt" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"netamt") %>' />
                                            </font>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Amount Paid" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <font class="blackfnt">
                                                <asp:Label ID="pendamt" Text='<%# DataBinder.Eval(Container.DataItem,"Advpaid") %>' runat="server"></asp:Label>
                                                <asp:HiddenField ID="Advpaid" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"Advpaid") %>' />

                                                <asp:HiddenField ID="pendingamt" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"pendamt") %>' />
                                            </font>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Current Payment" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtCurrPayment" runat="server" Text="" Width="50px" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox ID="txtTotal" runat="server" Text="0" Width="50px" ReadOnly="true"></asp:TextBox>
                                        </FooterTemplate>
                                    </asp:TemplateField>

                                </Columns>
                                <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                                <HeaderStyle CssClass="bgbluegrey" />
                                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                                <FooterStyle CssClass="boxbg" HorizontalAlign="Right" />
                            </asp:GridView>
                            <asp:HiddenField ID="hdnTHCNo" runat="server" Value="" />
<asp:HiddenField ID="hdnTHCNoId" runat="server" Value="" />
<asp:HiddenField ID="click_count" Value=0 runat="server" />
                            <br />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td>
                    <div align="left">
                    </div>
                </td>
            </tr>
            <%-- <tr>
                <td align="center">
                    <asp:UpdatePanel ID="UpdatePanel100" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit"  OnClientClick="return CheckDocketSelection()"  OnClick="btnSubmit_Click" />
                            </ContentTemplate>
                            </asp:UpdatePanel>
                            
                </td>
            </tr>--%>
        </table>
        <div id="divAdvanceCheque" runat="server">
            <%-- style="display:none"--%>
            <table>
                <tr class="blackfnt" bgcolor="#ffffff" runat="server" id="RowAdvanceChequeGrid">
                    <td colspan="2">
                        <table id="Table1" cellspacing="1" class="boxbg" runat="server"
                            style="width: 10.5in">
                            <tr class="blackfnt" bgcolor="#ffffff">
                                <td>
                                    <table cellspacing="1" class="boxbg" border="0" style="width: 10.5in">
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
                                    <table cellspacing="1" align="left" style="width: 10.5in">
                                        <tr align="center">
                                            <td align="left">
                                                <asp:Panel ID="pnlAdvanceChequeDet" runat="server">
                                                    <table cellspacing="1" style="width: 10.5in">
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
                                                                                            Width="90" MaxLength="25" CssClass="input"></asp:TextBox>
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
                <tr>
                    <td align="center">

                        <asp:Button ID="btnSubmit" runat="server" Text="Submit"  OnClick="btnSubmit_Click"/><%-- OnClientClick="return CheckDocketSelection()"--%>
                        <%--  --%>
                    </td>
                </tr>
            </table>
        </div>
        <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;"></div>
    </div>
</asp:Content>

