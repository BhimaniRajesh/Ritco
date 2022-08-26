<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="HCLBillPayement.aspx.cs" Inherits="GUI_Finance_HCLBill_HCLBillPayement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript" src="../../images/DateControl.js"></script>
    <script language="javascript" type="text/javascript" src="../../Js/moment.js"></script>
    <script src="HCLBillPayment.js?V2" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>
    <script>
        var serviceUrl = '<%=ResolveClientUrl("~/RestService/HCLMasterService.svc")%>';
        var BranchSession = '<%= SessionUtilities.CurrentBranchCode %>';
        var EntryBySession = '<%= SessionUtilities.CurrentEmployeeID %>';
        var FinyearSession = '<%= SessionUtilities.FinYear %>';
    </script>
    <div>
        <table class="stbl" cellspacing="1" cellpadding="3" id="tblCriteria" runat="server">
            <tr class="hrow">
                <td colspan="10" align="center">
                    <b>HCL Bill Payment</b>
                    <UserControl:UserMessage runat="server" ID="UserMessage" />
                </td>
            </tr>
            <tr class="nrow">
                <td colspan="10" valign="top">
                    <div class="DDScrolldesign" style="height: 250px;">
                        <asp:Repeater ID="Repeater1" runat="server">
                            <HeaderTemplate>
                                <table id="Dochead" border="0" class="boxbg" cellpadding="1" cellspacing="1" width="100%">
                                    <thead>
                                        <tr class="hrow">
                                            <th></th>
                                            <th><b>Sr. No</b></th>
                                            <th><b>Bill No</b></th>
                                            <th><b>Bill Date</b></th>
                                            <th><b>Vendor Name</b></th>
                                            <th><b>Total Amount</b></th>
                                            <th><b>Rebate</b></th>
                                            <th><b>Discount</b></th>
                                            <th><b>Approved Amount</b></th>
                                            <th><b>View</b></th>
                                        </tr>
                                    </thead>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tbody>
                                    <tr class="nrow">
                                        <td>
                                            <asp:RadioButton ID="chkDoc" runat="server" OnClick="CalulateTotal(this)" />
                                        </td>
                                        <td>
                                            <label id="lblSrno"></label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblBillNo" runat="server" Text='<%# Eval("BillNo") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblBillDate" runat="server" Text='<%# Eval("billDate") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="VendorName" runat="server" Text='<%# Eval("VendorName") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblTotalAmount" runat="server" Text='<%# Eval("TotalAmount") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblRebate" runat="server" Text='<%# Eval("RebateAmount") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblDiscount" runat="server" Text='<%# Eval("Discount") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblApprovedAmount" runat="server" Text='<%# Eval("ApprovedAmount") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <a href="#" onclick="OpenView(this)" runat="server"><u>View</u></a>
                                            <asp:HiddenField ID="hdnVal" runat="server" Value='<%# Eval("BillNo") %>' />
                                        </td>
                                    </tr>
                                </tbody>
                            </ItemTemplate>
                            <FooterTemplate>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </td>
            </tr>
            <tr class="nrow">
                <td colspan="10">
                    <table cellspacing="0" cellpadding="0" style="width: 400px" id="tblRate">
                        <tr class="nrow">
                            <td>
                                <b>Approved Amount</b>
                            </td>
                            <td>
                                <asp:TextBox ID="txtApprovedAmount" runat="server" Text="0.00" Enabled="false" Style="text-align: right"></asp:TextBox>
                            </td>
                        </tr>
                        <tr class="nrow">
                            <td>
                                <b>TDS</b>
                            </td>
                            <td>
                                <asp:TextBox ID="txtTds" runat="server" Text="0.00" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Style="text-align: right" onBlur="CalulateTds()"></asp:TextBox>
                            </td>
                        </tr>

                        <tr class="nrow">
                            <td>
                                <b>Payable Amount</b>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPayable" runat="server" Text="0.00" Enabled="false" Style="text-align: right"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr class="nrow">
                <td>Payment Mode
                </td>
                <td>
                    <asp:DropDownList ID="ddlPayMode" runat="server">
                        <asp:ListItem Text="select" Value="0"></asp:ListItem>
                        <asp:ListItem Text="Cheque" Value="Bank"></asp:ListItem>
                        <asp:ListItem Text="NEFT" Value="NEFT"></asp:ListItem>
                        <asp:ListItem Text="RTGS" Value="RTGS"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>Instrument No.</td>
                <td>
                    <asp:TextBox ID="txtInstrumentNo" runat="server"></asp:TextBox>
                </td>
                <td>Instrument Amount</td>
                <td>
                    <asp:TextBox ID="txtInstrumentAmount" runat="server" Enabled="false" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Style="text-align: right" Text="0.00"></asp:TextBox>
                </td>
                <td>Instrument Date</td>
                <td>
                    <UserControl:DatePicker runat="server" ID="dpLRDate" AllowPastDate="True" ImageUrl="../../../GUI/images/calendar.jpg" />
                </td>
                <td>Bank Name</td>
                <td>
                    <asp:DropDownList ID="ddlBankName" runat="server"></asp:DropDownList>
                </td>
            </tr>
            <tr class="hrow">
                <td colspan="10">
                    <input type="button" value="Submit" onclick="javascript: return OnSubmit();" id="btnSubmit" />
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>

