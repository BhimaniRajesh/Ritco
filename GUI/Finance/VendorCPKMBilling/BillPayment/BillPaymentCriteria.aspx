<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="BillPaymentCriteria.aspx.cs" Inherits="GUI_Finance_VendorCPKMBilling_BillPayment_BillPaymentCriteria" %>

<%@ Register Src="~/Common_UserControls/RPT_Date.ascx" TagPrefix="MultiCheckCombo" TagName="RPT_Date" %>

<%@ Register Src="~/GUI/Common_UserControls/DatePicker1.ascx" TagName="DTP" TagPrefix="DateP" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="JavaScript" src="./../Images/CalendarPopup.js"></script>
    <script language="javascript" src="./../images/commonJs.js"></script>
    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        function RadioCheck(rb) {
            var gv = document.getElementById("<%=gvCPKMBillDT.ClientID%>");
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


        function AmontCalculation(e) {
            var CurrentRow = $(e).closest('tr');
            //var lblClosingKM = $(e).closest('tr').find('span[id*="lblBillAmount"]');

            //if ($(e).closest('tr').find('input[type=checkbox]:checked').prop("checked")) {
            Subtotal();

        }

        function Subtotal() {
            var txtSubTotal = $('#<%=txtTotalBill.ClientID%>');
            var hdnSubTotal = $('#<%=hdnTotalBill.ClientID%>');
            var txtMiscAmount = $('#<%=txtRebateAmount.ClientID%>');
            var hdnMiscAmount = $('#<%=hdnRebateAmount.ClientID%>');
            var txtTotalbillAmount = $('#<%=txtNetTotalbillAmount.ClientID%>');
            var hdnTotalbillAmount = $('#<%=hdnNetTotalbillAmount.ClientID%>');
            //Add By Minesh
            var txtTDSAmount = $('#<%=txtTDSAmount.ClientID%>');            

            var SubTotal = 0, MiscTotal = 0, TotalBill = 0, TDS = 0;
            MiscTotal = parseFloat(txtMiscAmount.val()) || 0;
            //if (txtTDSAmount.val() == "") {
              //  TDS = 0;
            //}
            //else {
              //  TDS = parseFloat(txtTDSAmount.val());
            //}
            $("span[id*='lblBillAmount']").each(function (data) {
                var lblFinalAmount = $(this);
                var chkVehicleNo = $('#' + $(this).attr('id').replace("lblBillAmount", "chkVehicleNo"));
				var hidTDSAmount = $('#' + $(this).attr('id').replace("lblBillAmount", "hidTDSAmount"));
                if (chkVehicleNo.prop("checked")) {
                    SubTotal = SubTotal + parseFloat(lblFinalAmount.html());
					TDS = TDS + parseFloat(hidTDSAmount.val());
                } else {
                    SubTotal = SubTotal + 0;
					TDS = TDS + 0;
                }
            });

            if (MiscTotal > SubTotal) {
                alert("Rebate must be less than the Total bill Amount !");
                txtMiscAmount.val("0");
                hdnRebateAmount.val("0");
                txtMiscAmount.focus();

            } else {
                txtSubTotal.val(SubTotal+TDS);
                hdnSubTotal.val(SubTotal+TDS);
				txtTDSAmount.val(TDS);
                txtTotalbillAmount.val((SubTotal - MiscTotal).toFixed(2));
                hdnTotalbillAmount.val((SubTotal - MiscTotal).toFixed(2));
            }
        }
        function payment() {
            var txtSubTotal = $('#<%=txtTotalBill.ClientID%>');
            var hdnSubTotal = $('#<%=hdnTotalBill.ClientID%>');
            var txtMiscAmount = $('#<%=txtRebateAmount.ClientID%>');
            var hdnMiscAmount = $('#<%=hdnRebateAmount.ClientID%>');
            var txtTotalbillAmount = $('#<%=txtNetTotalbillAmount.ClientID%>');
            var hdnTotalbillAmount = $('#<%=hdnNetTotalbillAmount.ClientID%>');

            var ddlOption = $('#<%=ddlOption.ClientID%>');
            var ddlBank = $('#<%=ddlBank.ClientID%>');
            var txtAmount = $('#<%=txtAmount.ClientID%>');
            var txtCreditAmount = $('#<%=txtCreditAmount.ClientID%>');
            var ddlConfirmVendor = $('#<%=ddlConfirmVendor.ClientID%>');
            var txtFromDate = $('#<%=txtFromDate.ClientID%>_txtDate');
            var lblNetPaybleAmount = $('#<%=lblNetPaybleAmount.ClientID%>');
            var NetPaybleAmount = 0;
            //if (txtCreditAmount.val() == '') {
            //    alert("Please enter the Amount !");
            //    txtCreditAmount.focus();
            //    return false;
            //}
            if (txtAmount.val() == '') {
                alert("Please enter the Amount !");
                txtAmount.focus();
                return false;

            }
            //NetPaybleAmount = parseFloat(txtCreditAmount.val()) + parseFloat(txtAmount.val());
            if (parseFloat(hdnTotalbillAmount.val()) != parseFloat(txtAmount.val())) {
                alert("Net Amount and Payment AMount was not match!");
                txtAmount.val('0');
				txtAmount.focus();
				
                return false;
            }
            //lblNetPaybleAmount.html(NetPaybleAmount);
            return true;
        }


    </script>
    <div style="width: 10in">
        <UserControl:ProgressBar runat="server" ID="ProgressBar" />
        <asp:UpdatePanel runat="server">
            <ContentTemplate>

                <UserControl:UserMessage runat="server" ID="umsg" />
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%">
                                <tr>
                                    <td height="30">
                                        <font class="bluefnt">
                                            <strong>Bill Payment of CPKM</strong> </font>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="horzblue">
                                        <img src="../../images/clear.gif" width="2" height="1" alt="" /></td>
                                </tr>
                                <tr>
                                    <td>
                                        <img src="../../images/clear.gif" width="15" height="10" alt="" /></td>
                                </tr>

                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table cellpadding="1" cellspacing="1" border="0" style="width: 90%" class="boxbg">
                                <thead>
                                    <tr class="bgbluegrey">
                                        <td colspan="4" align="center">
                                            <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="CPKM Bill Payment"></asp:Label></td>
                                    </tr>
                                    <tr class="nrow">
                                        <td>
                                            <b>Vendor</b>
                                        </td>
                                        <td>
                                            <asp:DropDownList runat="server" ID="ddlVendor" Width="200PX">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr class="nrow">
                                        <td>
                                            <b>Date Range</b>
                                        </td>
                                        <td>
                                            <UserControl:RPT_Date runat="server" ID="RPT_Date" EnableTillDate="true" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <center><b>OR</b></center>
                                        </td>
                                    </tr>
                                    <tr class="nrow">
                                        <td>Bill no
                                        </td>
                                        <td>
                                            <asp:TextBox runat="server" ID="txtBillNo"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr class="bgbluegrey">
                                        <td colspan="4" align="center">
                                            <asp:Button runat="server" ID="btnSearch" Text="Submit" OnClick="btnSearch_OnClick" />
                                        </td>
                                    </tr>
                                    <tr class="nrow">

                                        <td colspan="4">
                                            <asp:GridView runat="server" CssClass="boxbg" ID="gvCPKMBillDT" AutoGenerateColumns="False" CellSpacing="1"
                                                HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" PagerStyle-CssClass="bgwhite" Width="100%" RowStyle-CssClass="bgwhite" BorderWidth="0">

                                                <Columns>
                                                    <asp:TemplateField HeaderText="Select">
                                                        <ItemTemplate>
                                                            <asp:CheckBox runat="server" ID="chkVehicleNo" onclick="return AmontCalculation(this);" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Vendor Name">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblVendorName" Text='<%# Eval("VendorName") %>'></asp:Label>
                                                            <asp:HiddenField runat="server" ID="hdnVendorCode" Value='<%# Eval("VendorCode") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Bill No.">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblBillNo" Text='<%# Eval("BillNo") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Bill Date">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblBillDate" Text='<%# Eval("BillDate") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="No. Of Vehicle">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblNoOfVehicle" Text='<%# Eval("NoOfVehicle") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Net Bill Amount">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblBillAmount" Text='<%# Eval("NetBillAmount") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Paid Amount">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblPaidBillAmount" Text='<%# Eval("PaidAmount") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Belance Amount">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblNetBillAmount" Text='<%# Eval("BelanceAmount") %>'></asp:Label>
															<asp:HiddenField ID="hidTDSAmount" runat="server" Value='<%# Eval("TDSAmount") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <tr class="nrow" style="display: none" runat="server" id="trTotal">
                                            <td colspan="4">
                                                <table cellpadding="1" cellspacing="1" border="0" style="width: 30%" class="boxbg">
                                                    <tr class="nrow">
                                                        <td><b>Total Bill Amount</b></td>
                                                        <td>
                                                            <asp:TextBox runat="server" Enabled="False" ID="txtTotalBill" CssClass="ltxt" Width="200PX"></asp:TextBox>
                                                            <asp:HiddenField runat="server" ID="hdnTotalBill" />
                                                        </td>

                                                    </tr>
                                                    <tr class="nrow">
                                                        <td><b>Final Rebate Amount</b></td>
                                                        <td>
                                                            <asp:TextBox runat="server" ID="txtRebateAmount" Text="0" CssClass="ltxt" Width="200PX" onchange="Subtotal();"></asp:TextBox>
                                                            <asp:HiddenField runat="server" ID="hdnRebateAmount" />
                                                        </td>

                                                    </tr>
                                                    <tr class="nrow">
                                                        <td><b>TDS Amount</b></td>
                                                        <td>
                                                            <asp:TextBox runat="server" ID="txtTDSAmount"  Enabled="False" Text="0" CssClass="ltxt" Width="200PX" onblur="Subtotal();"></asp:TextBox>
															<asp:HiddenField runat="server" ID="hdnTDSAmount" />
                                                        </td>
                                                    </tr>
                                                    <tr class="nrow">
                                                        <td><b>Net Bill Amount</b></td>
                                                        <td>
                                                            <asp:TextBox runat="server" Enabled="False" ID="txtNetTotalbillAmount" CssClass="ltxt" Width="200PX"></asp:TextBox>
                                                            <asp:HiddenField runat="server" ID="hdnNetTotalbillAmount" />
                                                        </td>

                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>

                                    </tr>
                                    <tr class="nrow" style="display: none" runat="server" id="tr1">
                                        <td colspan="4">
                                            <table cellpadding="1" cellspacing="1" border="0" style="width: 100%" class="boxbg">
                                                <tr class="nrow">
                                                    <table cellpadding="1" cellspacing="1" border="0" style="width: 30%" class="boxbg">
                                                        <tr class="nrow">
                                                            <td>Select</td>
                                                            <td>
                                                                <asp:DropDownList runat="server" ID="ddlOption">
                                                                    <asp:ListItem Text="Cheque" Value="1"></asp:ListItem>
                                                                    <asp:ListItem Text="NEFT" Value="1"></asp:ListItem>
                                                                    <asp:ListItem Text="RTGS" Value="1"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>Amount</td>
                                                            <td>
                                                                <asp:TextBox runat="server" ID="txtAmount" onchange="javascript:payment();"></asp:TextBox>
                                                            </td>
                                                            <td>Instrument No</td>
                                                            <td>
                                                                <asp:TextBox runat="server" ID="txtInstrumentNo"></asp:TextBox>
                                                            </td>
                                                            <td>Instrument Date</td>
                                                            <td>
                                                                <DateP:DTP ID="txtFromDate" AllowFutureDate="true" AllowPastDate="true" runat="server" ImageUrl="../../images/calendar.jpg" />
                                                            </td>
                                                            <td>Bank</td>
                                                            <td>
                                                                <asp:DropDownList runat="server" ID="ddlBank"></asp:DropDownList>
                                                            </td>

                                                        </tr>
                                                        <tr class="nrow" style="display: none">
                                                            <td></td>
                                                            <td></td>
                                                            <td>Credit Amount</td>
                                                            <td>
                                                                <asp:TextBox runat="server" ID="txtCreditAmount" onchange="javascript:payment();"></asp:TextBox>
                                                            </td>
                                                            <td>Credit A/C
                                                            </td>
                                                            <td>
                                                                <asp:Label runat="server" ID="lblCreditVendor"></asp:Label>
                                                            </td>
                                                            <td>Confirmed Credit A/C
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList runat="server" ID="ddlConfirmVendor" Width="200PX">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td></td>
                                                            <td></td>
                                                        </tr>
                                                        <tr class="nrow" style="display: none">
                                                            <td></td>
                                                            <td></td>
                                                            <td>Net Payable Amount</td>
                                                            <td>
                                                                <asp:Label runat="server" ID="lblNetPaybleAmount"></asp:Label>
                                                            </td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                            <td></td>
                                                        </tr>
                                                    </table>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                    </tr>
                    <tr runat="server" id="trsubbtn" style="display: none" class="bgbluegrey">
                        <td align="center" colspan="4">
                            <asp:Button runat="server" ID="btnSubmit" CssClass="btn btn-primary" Text="Submit" OnClientClick="javascript: return payment();" OnClick="btnSubmit_OnClick" />
                        </td>
                    </tr>
                    </thead>
                </table>

                </td>
                    </tr>

                </table>

            </ContentTemplate>
        </asp:UpdatePanel>
        <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
        </div>
    </div>
</asp:Content>



