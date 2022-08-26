<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdvanceVoucher.aspx.cs" Inherits="GUI_Finance_VendorPayment_Ver1_Advance_Balance_Payment_AdvanceVoucher" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Payment Voucher View</title>
    <link type="text/css" rel="stylesheet" href="../../../images/style.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table style="width: 80%">
                <tr>
                    <td>
                        <table border="0" style="width: 600" bgcolor="#808080" cellpadding="2" cellspacing="1"
                            class="boxbg">
                            <tr class="bgbluegrey">
                                <td colspan="4" align="center">
                                    <font class="bluefnt"><b>
                                        <asp:Label ID="lbl_title" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label></b></font></td>
                            </tr>
                            <tr bgcolor="white">
                                <td>
                                    <font class="blackfnt">
                                        <asp:Label ID="Lbl_Docno" runat="server" CssClass="blackfnt"></asp:Label></font>
                                </td>
                                <td>
                                    <asp:Label ID="lbl_voucher_No" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td>
                                    <font class="blackfnt">
                                        <asp:Label ID="Lbl_DocDate" runat="server" CssClass="blackfnt"></asp:Label></font>
                                </td>
                                <td>
                                    <asp:Label ID="lbl_voucher_Dt" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>
                            <tr bgcolor="white">
                                <td>
                                    <font class="blackfnt">Manual Voucher No:</font>
                                </td>
                                <td>
                                    <asp:Label ID="Lbl_manualVRNO" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td>
                                    <font class="blackfnt">Vendor Name</font>
                                </td>
                                <td>
                                    <asp:Label ID="Lbl_Vendorname" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>
                            <tr bgcolor="white">
                                <td>
                                    <font class="blackfnt">Document Type</font>
                                </td>
                                <td>
                                    <asp:Label ID="Lbl_Voucher_type" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <br />
                        <asp:GridView ID="VoucherView" ShowFooter="true" EmptyDataText="No Records Found....."
                            AllowPaging="false" PagerStyle-Mode="NumericPages" CssClass="boxbg" AutoGenerateColumns="true"
                            HeaderStyle-CssClass="bgbluegrey" runat="server" SelectedIndex="1" BorderWidth="0"
                            CellPadding="3" CellSpacing="1" Width="600" RowStyle-Wrap="false" HeaderStyle-Wrap="false"
                            RowStyle-HorizontalAlign="Right" FooterStyle-BackColor="white" RowStyle-BackColor="white">
                            <PagerStyle HorizontalAlign="Center" CssClass="boxbg" />
                            <HeaderStyle CssClass="bgbluegrey" />
                            <FooterStyle CssClass="boxbg" />
                        </asp:GridView>
                    </td>
                </tr>
                
                <tr id="PaymentDetail" runat="server">
                    <td>
                        <br />
                        <table border="0" style="width: 600" bgcolor="#808080" cellpadding="2" cellspacing="1"
                            class="boxbg">
                            <tr class="bgbluegrey">
                                <td colspan="4" align="center">
                                    <font class="bluefnt"><b>Voucher Payment Details</b></font></td>
                            </tr>
                            <tr bgcolor="white">
                                <td width="200">
                                    <font class="blackfnt">Payment Mode </font>
                                </td>
                                <td width="200">
                                    <asp:Label ID="Lbl_Paymode" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td width="200">
                                </td>
                                <td width="200">
                                </td>
                            </tr>
                            <tr bgcolor="white">
                                <td>
                                    <font class="blackfnt">Cash Amount </font>
                                </td>
                                <td align="right">
                                    <asp:Label ID="Lbl_CashAMt" Font-Bold="true" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td>
                                    <font class="blackfnt">Cash Account </font>
                                </td>
                                <td nowrap>
                                    <asp:Label ID="Lbl_cash_accode" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>
                            <tr bgcolor="white">
                                <td>
                                    <font class="blackfnt">Cheque Amount </font>
                                </td>
                                <td align="right">
                                    <asp:Label ID="Lbl_Chqamt" Font-Bold="true" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td nowrap>
                                    <font class="blackfnt">Bank Account </font>
                                </td>
                                <td nowrap>
                                    <asp:Label ID="Lbl_bankCode" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>
                            <tr bgcolor="white">
                                <td>
                                    <font class="blackfnt">Cheque No. </font>
                                </td>
                                <td>
                                    <asp:Label ID="Lbl_chqno" Font-Bold="true" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td>
                                    <font class="blackfnt">Cheque date </font>
                                </td>
                                <td>
                                    <asp:Label ID="Lbl_chqDate" Font-Bold="true" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>
                            <tr bgcolor="white">
                                <td>
                                    <font class="blackfnt"></font>
                                </td>
                                <td>
                                </td>
                                <td>
                                    <font class="blackfnt"><b>NET PAYABLE </b></font>
                                </td>
                                <td align="right">
                                    <asp:Label ID="Lbl_netamt" Font-Bold="true" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
