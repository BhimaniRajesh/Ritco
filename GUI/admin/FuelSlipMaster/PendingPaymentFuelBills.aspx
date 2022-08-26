<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PendingPaymentFuelBills.aspx.cs" MasterPageFile="~/GUI/MasterPage.master" Inherits="GUI_admin_FuelSlipMaster_PendingPaymentFuelBills" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript" src="VendorPayment.js"></script>
    <script language="javascript" type="text/javascript" src="../../../GUI/images/CommonJS.js"></script>
    <script language="javascript" type="text/javascript" src="../../../admin/FuelSlipMaster/FuelSlipMaster_JS.js"></script>
    <script language="javascript" type="text/javascript" src="FuelRateMaster.js"></script>

    <script type="text/javascript" language="javascript">
        function Edit_Alert() {
            if (confirm('Do you want to send for Date Entry?')) {
                return true;
            }
            else {
                return false;
            }
        }
        function ValidateDate(obj) {
            if (obj.value != "") {
                // alert(isDate(obj.value))
                if (isDate(obj.value) == false) {
                    obj.focus()
                    return false
                }
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
        function validation() {

            var txtinstrumentno = document.getElementById("ctl00_MyCPH1_txtinstrumentno");
            if (txtinstrumentno.value == '') {
                alert('Please enter Instrument No.');
                return false;
            }
        }
        function Cal(event, txtid) {
            //    function Cal(c, a) {
            // var table = document.getElementById("dgGeneral");
            var table = document.getElementById("ctl00_MyCPH1_dgGeneral");
            var l = 0;
            l = table.rows.length;
            for (i = 0; i < l - 1; i++) {
                var tb = document.getElementById(txtid);
                var tb1 = tb.value;
                //alert(i);
                var tableCell = document.getElementById("ctl00_MyCPH1_dgGeneral").rows[1].cells[7].innerHTML.toString();
                var rows1 = document.getElementById("ctl00_MyCPH1_dgGeneral").rows.length;
                //i = i + 2;
                // alert(i);
                var tot = tableCell - tb1;
                //document.getElementById('ctl00_MyCPH1_dgGeneral_ctl0' + i+2 + '_lblPendingAmount').innerHTML = tot;

                // document.getElementById("ctl00_MyCPH1_dgGeneral_ctl02_lblPendingAmount").innerHTML = tot;
                //var id1 = "ctl00_MyCPH1_dgGeneral_ctl0" + i + "lblPendingAmount";
                //var lblPendingAmount = document.getElementById(id1 + "lblPendingAmount");
                //var lblPendingAmount;
                //lblPendingAmount.value = document.getElementById(id1 + "lblPendingAmount");
                //document.getElementById('ctl00_MyCPH1_dgGeneral_ctl02_lblPendingAmount').value;
                document.getElementById('ctl00_MyCPH1_dgGeneral_ctl02_lblPendingAmount').innerHTML = tot;
                document.getElementById('ctl00_MyCPH1_dgGeneral_ctl02_hdnPendingAmount').value=tot;
                


            }
        }
        function calculation(c, d) {
            document.getElementById("ctl00_MyCPH1_txtGrandTotal").value = 0;
            if (document.getElementById(d).checked == true) {
                var rows1 = document.getElementById("ctl00_MyCPH1_dgGeneral").rows.length;

                var tableCell = document.getElementById("ctl00_MyCPH1_dgGeneral").rows[1].cells[7].innerHTML.toString();

                if (rows1 <= 9) {
                    var id1 = "ctl00_MyCPH1_dgGeneral_ctl0" + rows1 + "_";
                }
                else {
                    var id1 = "ctl00_MyCPH1_dgGeneral_ctl" + rows1 + "_";
                }
                var lblAmount = document.getElementById(id1 + "lblAmount");
                var txtPaidAmount = document.getElementById(id1 + "txtPaidAmount");
				var lblPendingAmount = document.getElementById(id1 + "lblPendingAmount");

                if (document.getElementById(c).value == '') {
                    document.getElementById(c).value = 0;
                }else
				{
					//document.getElementById(c).value=lblAmount.innerText;
					document.getElementById(c).value = document.getElementById(c.replace("txtPaidAmount", "lblAmount")).innerText;
				}
                document.getElementById("ctl00_MyCPH1_txtGrandTotal").value = parseFloat(document.getElementById("ctl00_MyCPH1_txtGrandTotal").value) + parseFloat(document.getElementById(c).value);

                //if (parseFloat(document.getElementById(c).value) > parseFloat(lblAmount.innerText)) {
				if (parseFloat(document.getElementById(c).value) > parseFloat(document.getElementById(c.replace("txtPaidAmount", "lblAmount")).innerText)) {
                    alert("paid amount cannot be greater than total amount");
                    document.getElementById("ctl00_MyCPH1_txtGrandTotal").value = 0;
                    document.getElementById(c).value = 0;
                    lblPendingAmount.innerText = 0;
                    hdnPendingAmount.value=0;
                    return false;
                }
            }
            else if (document.getElementById(d).checked == false) {
				document.getElementById(c).value = 0;
                document.getElementById("ctl00_MyCPH1_txtGrandTotal").value = parseFloat(document.getElementById("ctl00_MyCPH1_txtGrandTotal").value) - parseFloat(document.getElementById(c).value);
            }
			CalculatePendingAmount(c);

        }
        function CalculatePendingAmount(row) {
            //debugger;
            var dgGeneral = document.getElementById("ctl00_MyCPH1_dgGeneral");
            var l = 0;
            l = dgGeneral.rows.length;
            var txtTotalAmount = "";

            var totamt = "0.00", RoundTotAmt = "0.00";
			var payRoundTotAmt = 0.00;

            for (i = 0; i < l - 1; i++) {
                j = i + 2
                var pref = "";

                if (j < 10) {
                    pref = "ctl00_MyCPH1_dgGeneral_ctl0" + j + "_";
                }
                else {
                    pref = "ctl00_MyCPH1_dgGeneral_ctl" + j + "_";
                }

                var lblAmount = document.getElementById(pref + "lblAmount");
                var txtPaidAmount = document.getElementById(pref + "txtPaidAmount");
                var lblPendingAmount = document.getElementById(pref + "lblPendingAmount");
                var hdnPendingAmount = document.getElementById(pref + "hdnPendingAmount");

                if (txtPaidAmount.value != "") {
					payRoundTotAmt =payRoundTotAmt+parseFloat(txtPaidAmount.value)
                    totamt = parseFloat(lblAmount.innerText) - parseFloat(txtPaidAmount.value);
                    RoundTotAmt = totamt.toFixed(2);
                    lblPendingAmount.innerText = RoundTotAmt;
                    hdnPendingAmount.value=RoundTotAmt;
                }

                //calculation(pref + "txtPaidAmount", pref + "chkbxCheck");
                //else {
                //    return false
                //}
            }
			document.getElementById("ctl00_MyCPH1_txtGrandTotal").value = payRoundTotAmt;
        }

        function CalculateTotalPaymentAmount() {
            var txtTotalPaymentAmt = $("#" + '<%= txtTotalPaymentAmt.ClientID%>');
            var txtInstrumentAmount = $("#" + '<%= txtInstrumentAmount.ClientID%>');
            var txtReedem = $("#" + '<%= txtReedem.ClientID%>');

            if (txtInstrumentAmount.val() == "")
                txtInstrumentAmount.val("0");

            if (txtReedem.val() == "")
                txtReedem.val("0");

            txtTotalPaymentAmt.val(parseFloat(txtInstrumentAmount.val()) + parseFloat(txtReedem.val()));
        }
        function ValidateOnSubmit() {
            var txtTotalPaymentAmt = $("#" + '<%= txtTotalPaymentAmt.ClientID%>');
            var txtGrandTotal = $("#" + '<%= txtGrandTotal.ClientID%>');
            var txtinstrumentno = $("#" + '<%= txtinstrumentno.ClientID%>');
            var ddlBank = $("#" + '<%= ddlBank.ClientID%>');
            var txtInstrumentAmount = $("#" + '<%= txtInstrumentAmount.ClientID%>');

            if (parseFloat(txtTotalPaymentAmt.val()) != parseFloat(txtGrandTotal.val())) {
                alert("Total Paid amount must be same as Total Payment amount");
                return false;
            }
            if (txtInstrumentAmount.val() != "" && parseFloat(txtInstrumentAmount.val()) != 0) {
                if (txtinstrumentno.val() == "") {
                    alert("Please enter Instrument No");
                    txtinstrumentno.focus();
                    return false;
                }
                if (ddlBank.val() == "0") {
                    alert("Please select Bank");
                    ddlBank.focus();
                    return false;
                }
            }
            return true;
        }
        
        function OpenViewPrint(ctrl)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50";
            var strPopupURL = "PendingFuelBillApprovalView.aspx?Billno=" + $(ctrl).text();
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
    </script>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                <tr>
                    <td align="right">
                        <img src="../../images/loading.gif" alt="" /></td>
                    <td><font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font></td>
                </tr>
            </table>
            <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px; background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50); opacity: .50; -moz-opacity: .50;"
                runat="server">
                <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%; left: 50%;"
                    ID="Panel2" runat="server">
                </asp:Panel>
            </asp:Panel>
        </ProgressTemplate>
    </asp:UpdateProgress>

    <div align="left" style="width: 75%">
        <asp:UpdatePanel ID="UP1" runat="Server">
            <ContentTemplate>
                <UserControl:UserMessage runat="server" ID="UserMessage" />
                <table cellspacing="1" border="0" style="width: 100%">
                    <tr align="left">
                        <td colspan="3">
                            <table cellspacing="1" style="width: 90%" class="boxbg" border="0">
                                <tr class="bgbluegrey">
                                    <td colspan="3" align="left" style="height: 21px">
                                        <asp:Label ID="Label5" CssClass="blackfnt" Font-Bold="true" runat="server">
                                                    Pending Payment Fuel Bills
                                        </asp:Label>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                    <td valign="top" align="left">
                                        <asp:Label ID="Label6" CssClass="blackfnt" Text="Select Date Range" runat="server"
                                            Width="145px"></asp:Label>
                                    </td>
                                    <td align="left" style="width: 259px" valign="top">
                                        <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                            AutoPostBack="true" OnSelectedIndexChanged="radDate_SelectedIndexChanged" RepeatColumns="1"
                                            Width="244px">
                                            <asp:ListItem Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                            <asp:ListItem Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                            <asp:ListItem Selected="True" Value="2" Text=" Today:"></asp:ListItem>
                                            <asp:ListItem Value="3" Text=" Till Date:"></asp:ListItem>
                                        </asp:RadioButtonList></td>
                                    <td valign="top" align="left" style="width: 359px">
                                        <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                        <asp:TextBox ID="txtDateFrom" runat="server" CssClass="input" BorderStyle="Groove" onblur="return ValidateDate(this)" Width="80px" TabIndex="3"></asp:TextBox></font>
                                        <ajaxToolkit:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" TargetControlID="txtDateFrom" runat="server" />

                                        </a>
                                        <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                        <asp:TextBox ID="txtDateTo" runat="server" CssClass="input" BorderStyle="Groove" onblur="return ValidateDate(this)" Width="80px" TabIndex="3"></asp:TextBox></font>
                                        <ajaxToolkit:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" TargetControlID="txtDateTo" runat="server" />

                                        <br />
                                        <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Date Range Must Be 1 month Only"
                                            OnServerValidate="daterange"></asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td valign="top" align="left">
                                        <asp:Label ID="Label1" CssClass="blackfnt" Text="Select Vendor" runat="server"
                                            Width="145px"></asp:Label>
                                    </td>
                                    <td align="left" colspan="2" valign="top">
                                        <asp:DropDownList ID="ddVendorName" AutoPostBack="True" OnSelectedIndexChanged="ddVendorName_SelectedIndexChanged" runat="server" Width="261px" CssClass="input">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td colspan="4">
                                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="ShowPendingPayemntBills" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <%--*************************** Gridarea ****************************--%>
                <table border="0" cellspacing="1" cellpadding="3" width="900px">
                    <tr>
                        <td align="center">
                            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                <ProgressTemplate>
                                    <div id="progressArea">
                                        <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                        <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                    </div>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </td>
                    </tr>
                </table>

                <table border="0" cellspacing="1" cellpadding="3" width="1000px" runat="server" id="tblDCR">
                    <tr style="background-color: white">
                        <td align="center" width="100%">
                            <asp:UpdatePanel ID="u1" UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
                                    <asp:GridView ID="dgGeneral" runat="server" AutoGenerateColumns="False"
                                        CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                                        CssClass="dgRowStyle" Width="100%" AllowPaging="false" PagerStyle-CssClass="pager" PageSize="20"
                                        PagerSettings-Mode="NumericFirstLast" EmptyDataText="No Records Found" OnRowDataBound="dgGeneral_RowDataBound">
                                        <Columns>
                                            <asp:TemplateField runat="server" HeaderText="Options" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkbxCheck"  />
                                                    <%--/
                                                    <asp:Button Text="Edit" ID="btnEdit" OnClientClick="javascript:return Edit_Alert()" runat="server" Enabled="false" OnClick="btnEdit_Click" />--%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Sr No.">
                                                <ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="VENDORNAME" ItemStyle-HorizontalAlign="Left" HeaderText="Vendor Name" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                            <asp:TemplateField runat="server" HeaderText="Fuel Bill No" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblBillNo" runat="server" Text='<%# Bind("Bill_No") %>'  onclick="OpenViewPrint(this)" ></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField runat="server" HeaderText="Bill Date" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblBillDate" runat="server" Text='<%# Bind("BillDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField runat="server" HeaderText="Total Ltrs" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTotalLtr" runat="server" Text='<%# Bind("TotalLtr") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                             <asp:TemplateField runat="server" HeaderText="Total Slip" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTotalSlips" runat="server" Text='<%# Bind("TotalSlips") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <%--<asp:HyperLinkField DataTextField="Bill_No" ItemStyle-HorizontalAlign="Left" DataNavigateUrlFields="Bill_No" DataNavigateUrlFormatString="PendingFuelBillApprovalView.aspx?Billno={0}" InsertVisible="false" Target="_blank" HeaderText="Fuel Bill No" HeaderStyle-HorizontalAlign="Left" />
                                            <asp:BoundField DataField="BillDate" ItemStyle-HorizontalAlign="Left" HeaderText="Bill Date" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" SortExpression="Rate" />--%>
                                            <%--<asp:BoundField DataField="TotalLtr" HeaderText="Total Ltrs" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="True" SortExpression="Amount" />
                                            <asp:BoundField DataField="TotalSlips" HeaderText="Total Slip" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="True" SortExpression="TotalSlip" />--%>
                                            <%-- <asp:BoundField DataField="Amount" HeaderText="Amount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="True" SortExpression="Amount" />--%>
                                            <asp:TemplateField runat="server" HeaderText="IGST" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblIGST" runat="server" Text='<%# Bind("IGST") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField runat="server" HeaderText="SGST" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSGST" runat="server" Text='<%# Bind("SGST") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField runat="server" HeaderText="CGST" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCGST" runat="server" Text='<%# Bind("CGST") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField runat="server" HeaderText="Amount" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAmount" runat="server" Text='<%# Bind("TotalAmount") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%--<asp:BoundField DataField="tripsheetno" HeaderText="Paid Amount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="True" SortExpression="PaidAmount" />--%>
                                            <asp:TemplateField runat="server" HeaderText="Paid Amount" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                                <ItemTemplate>
                                                    <%--<asp:TextBox ID="txtPaidAmount" runat="server" onblur="javascript:Cal(event,this.getAttribute('id'))" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>--%>
                                                    <asp:TextBox ID="txtPaidAmount" runat="server" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" Text="0.00"></asp:TextBox>
                                                    <%-- <asp:TextBox ID="txtPaidAmount" runat="server" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>--%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField runat="server" HeaderText="Pending" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                                <ItemTemplate>
                                                    <%--  <asp:TextBox ID="txtPendingAmount" runat="server"></asp:TextBox>--%>
                                                    <asp:HiddenField ID="hdnPendingAmount" runat="server"></asp:HiddenField>
                                                    <asp:Label ID="lblPendingAmount" runat="server"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%--  <asp:BoundField DataField="Quantity" HeaderText="Pending" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="True" SortExpression="Pending" />--%>
                                        </Columns>
                                    </asp:GridView>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <b id="Total" runat="server">Total</b>
                            <asp:TextBox ID="txtGrandTotal" runat="server" Text="0" Enabled="false"></asp:TextBox>
                        </td>
                    </tr>
                </table>
                <table border="0" cellspacing="1" cellpadding="3" width="1200px" runat="server" id="trinstrument" visible="false">
                    <tr>
                        <td>
                            <table cellspacing="1" border="0" style="width: 100%; font-weight: bold" class="boxbg" id="tblinstrument">
                                <tr class="bgwhite">
                                    <td>
                                        <asp:DropDownList runat="server" ID="drpinstrument">
                                            <asp:ListItem Text="NEFT" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="CHEQUE" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="RTGS" Value="3"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:Label ID="lblInstrumentAmount" CssClass="blackfnt" Text="Instrument Amount" runat="server" Style="font-weight: bold"></asp:Label>
                                        <asp:TextBox runat="server" ID="txtInstrumentAmount" MaxLength="20" Text="0.00" CssClass="blackfnt" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" onBlur="CalculateTotalPaymentAmount()"></asp:TextBox>
                                    </td>
                                    <td>

                                        <asp:Label ID="lblInstrumentNo" CssClass="blackfnt" Text="Instrument No" runat="server" Style="font-weight: bold"></asp:Label>
                                        <asp:TextBox runat="server" ID="txtinstrumentno" MaxLength="20" CssClass="blackfnt"></asp:TextBox>
                                    </td>
                                    <td style="width: 20%">
                                        <font class="blackfnt">
                                            <font class="blackfnt">
                                                <asp:Label runat="server" Text="Instrument Date" ID="instrumentdate" CssClass="blackfnt" Style="font-weight: bold"></asp:Label>
                                                <asp:TextBox ID="txtFromDate" runat="server" CssClass="blackfnt" BorderStyle="Groove" onblur="return ValidateDate(this)" Width="80px" TabIndex="3"></asp:TextBox></font>
                                            <ajaxToolkit:CalendarExtender ID="CalendarExtender3" Format="dd/MM/yyyy" TargetControlID="txtFromDate" runat="server" /></td>
                                    <td style="width: 20%">
                                        <asp:Label runat="server" ID="Label4" Text="Bank Name" CssClass="blackfnt" Style="font-weight: bold"></asp:Label>
                                        <asp:DropDownList runat="server" ID="ddlBank">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr class="bgwhite">
                                    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <asp:Label ID="lblReedem" CssClass="blackfnt" Text="Reedem Fuel Rewards " runat="server" Style="font-weight: bold"></asp:Label>
                                        <asp:TextBox runat="server" ID="txtReedem" MaxLength="20" CssClass="blackfnt" Text="0.00" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" onBlur="CalculateTotalPaymentAmount()"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblOilCompany" CssClass="blackfnt" Text="Oil Company Name" runat="server" Style="font-weight: bold"></asp:Label>
                                        <asp:TextBox runat="server" ID="txtOilCompany" MaxLength="50" CssClass="blackfnt"></asp:TextBox>
                                    </td>
                                    <td rowspan="2" colspan="2" valign="top">
                                        <asp:Label ID="lblRemarks" CssClass="blackfnt" Text="Remarks" runat="server" Style="font-weight: bold"></asp:Label>
                                        <asp:TextBox runat="server" ID="txtRemarks" MaxLength="500" CssClass="blackfnt" TextMode="MultiLine" Width="200" Height="50"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr class="bgwhite">
                                    <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <asp:Label ID="lblTotalPaymentAmt" CssClass="blackfnt" Text="Total Payment Amount" runat="server" Style="font-weight: bold"></asp:Label>
                                        <asp:TextBox runat="server" ID="txtTotalPaymentAmt" MaxLength="20" CssClass="blackfnt" Enabled="false" Text="0.00"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr id="trCancel" class="bgwhite">
                                    <td align="center" colspan="4">
                                        <asp:Button runat="server" Text="Submit" ID="btnSubmitBills" OnClick="btnSubmitBills_Click" OnClientClick="return ValidateOnSubmit(this)" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <asp:Label runat="server" ID="lblSuccess" ForeColor="Blue" Text=""></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <%--<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues"></asp:SqlDataSource>--%>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>


