<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PaymentVoucherView1.aspx.cs" Inherits="GUI_Octroi_Ver1_BillEntry_Payment_PaymentVoucherView1" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Payment Voucher View</title>
    <link type="text/css" rel="stylesheet" href="./../../images/style.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table style="width: 100%">
                <tr>
                    <td>
                        <table border="0" style="width: 800" bgcolor="#808080" cellpadding="2" cellspacing="1">
                            <tr bgcolor="white">
                                <td colspan="4" align="center">
                                    <font class="blackfnt"><b>
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
                <tr id="TR_balance" runat="server">
                    <td>
                        <table border="0" style="width: 800" bgcolor="#808080" cellpadding="2" cellspacing="1">
                            <asp:HiddenField ID="HiddenField1" runat="server" Value="0" />
                            <asp:HiddenField ID="HiddenField2" runat="server" Value="0" />
                            <tr bgcolor="white">
                                <td align="center" colspan="4">
                                    <font class="blackfnt"><b>Vendor Contract Details </b></font>
                                </td>
                            </tr>
                            <tr bgcolor="white" id="TR_KM_Based_BAL_1" runat="server" visible="false">
                                <td align="Left" nowrap>
                                    <font class="blackfnt">Vendor Contract Type</font>
                                </td>
                                <td align="Left" nowrap>
                                    <asp:Label ID="Lbl_ContractType_1" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td align="Left">
                                    <font class="blackfnt">Rate/Additional Km.</font>
                                </td>
                                <td align="Left">
                                    <asp:Label ID="Lbl_Rate_1" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>
                            <tr bgcolor="white" id="TR_KM_Based_BAL_2" runat="server" visible="false">
                                <td align="Left">
                                    <font class="blackfnt">Total Travel Km.</font>
                                </td>
                                <td align="Left">
                                    <asp:Label ID="Lbl_Tot_KM_1" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td align="Left">
                                    <font class="blackfnt">Contract Amt.(AS Per Contract Based On Total Travel Km.)</font>
                                </td>
                                <td align="Right">
                                    <asp:Label ID="Lbl_ContractAmt_1" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="BillDetail" runat="server">
                    <td>
                        <table border="0" style="width: 800" bgcolor="#808080" cellpadding="2" cellspacing="1">
                            <asp:HiddenField ID="click_count" runat="server" Value="0" />
                            <asp:HiddenField ID="Hnd_ServerDt" runat="server" Value="0" />
                            <tr bgcolor="white">
                                <td align="center" colspan="4">
                                    <font class="blackfnt"><b>Vendor Bill Details </b></font>
                                </td>
                            </tr>
                            <tr bgcolor="#FFFFFF" id="Tr_Bill1" runat="server">
                                <td align="Left">
                                    <font class="blackfnt">Vendor Name</font>
                                </td>
                                <td align="Left" colspan="3">
                                    <asp:Label ID="VendorName" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>
                            <tr bgcolor="#FFFFFF" id="Tr_Bill3" runat="server">
                                <td align="Left">
                                    <font class="blackfnt">Vendor Bill Amount</font>
                                </td>
                                <td align="Right">
                                    <asp:Label ID="Billamt" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td align="Left">
                                    <font class="blackfnt">Vendor Bill Date</font>
                                </td>
                                <td align="Left">
                                    <asp:Label ID="BillDate" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>
                            <tr bgcolor="#FFFFFF" id="Tr_Bill4" runat="server">
                                <td align="Left">
                                    <font class="blackfnt">Due Days</font>
                                </td>
                                <td align="Left">
                                    <asp:Label ID="DueDays" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td align="Left">
                                    <font class="blackfnt">Due Date</font>
                                </td>
                                <td align="Left">
                                    <asp:Label ID="DueDate" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>
                            <tr bgcolor="white" id="TR_KM_Based_1" runat="server" visible="false">
                                <td align="Left" nowrap>
                                    <font class="blackfnt">Vendor Contract Type</font>
                                </td>
                                <td align="Left" nowrap>
                                    <asp:Label ID="Lbl_ContractType" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td align="Left">
                                    <font class="blackfnt">Rate/Additional Km.</font>
                                </td>
                                <td align="Left">
                                    <asp:Label ID="Lbl_Rate" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>
                            <tr bgcolor="white" id="TR_KM_Based_2" runat="server" visible="false">
                                <td align="Left">
                                    <font class="blackfnt">Total Travel Km.</font>
                                </td>
                                <td align="Left">
                                    <asp:Label ID="Lbl_Tot_KM" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td align="Left">
                                    <font class="blackfnt">Contract Amt.(AS Per Contract Based On Total Travel Km.)</font>
                                </td>
                                <td align="Right">
                                    <asp:Label ID="Lbl_ContractAmt" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>
                            <tr bgcolor="white">
                                <td align="Left">
                                    <font class="blackfnt">Remarks</font>
                                </td>
                                <td align="Left" colspan="3">
                                    <asp:Label ID="Lbl_Remarks" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <br />
                        <asp:GridView ID="VoucherView" ShowFooter="true" EmptyDataText="No Records Found....."
                            AllowPaging="false" PagerStyle-Mode="NumericPages" AutoGenerateColumns="true" runat="server" SelectedIndex="1" BorderWidth="1"
                            CellPadding="0" CellSpacing="0" Width="800" RowStyle-Wrap="false" HeaderStyle-Wrap="false"
                            RowStyle-HorizontalAlign="Right" FooterStyle-BackColor="white" RowStyle-BackColor="white">
                            <PagerStyle HorizontalAlign="Center"/>
                            <HeaderStyle CssClass="blackfnt" />
                            <FooterStyle CssClass="blackfnt" />                            
                        </asp:GridView>
                    </td>
                </tr>
                <tr id="TaxDetail" runat="server">
                    <td>
                        <br />
                        <table border="0" style="width: 800" bgcolor="#808080" cellpadding="2" cellspacing="1">
                            <tr bgcolor="white">
                                <td style="text-align: center" class="blackfnt" colspan="4">
                                    <b>S.tax & TDS Details</b>
                                </td>
                            </tr>
                            <tr bgcolor="white">
                                <td style="text-align: center" class="blackfnt">
                                    <strong><font color="red">Enabled Service Tax Y/N-</font></strong>
                                </td>
                                <td>
                                    <asp:Label ID="Stax_YN" runat="server" CssClass="blackfnt"></asp:Label></td>
                                <td style="text-align: center" class="blackfnt">
                                    <strong><font color="red">Enabled TDS Y/N-</font></strong>
                                </td>
                                <td>
                                    <asp:Label ID="Tds_YN" runat="server" CssClass="blackfnt"></asp:Label></td>
                            </tr>
                            <tr bgcolor="white">
                                <td style="text-align: center" class="blackfnt" colspan="2">
                                    <strong>ADD Service Tax(+) </strong>
                                </td>
                                <td style="text-align: center" class="blackfnt" colspan="2">
                                    <strong>LESS TDS (-) </strong>
                                </td>
                            </tr>
                            <tr style="background-color: White">
                                <td style="text-align: left" class="blackfnt">
                                    &nbsp;Service tax (+)</td>
                                <td style="text-align: Right" class="blackfnt">
                                    &nbsp;<asp:Label ID="STax" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td style="text-align: left" class="blackfnt">
                                    &nbsp;TDS Section</td>
                                <td style="text-align: left" class="blackfnt">
                                    &nbsp;<asp:Label ID="TDSLedger" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>
                            <tr style="background-color: White">
                                <td style="text-align: left" class="blackfnt">
                                    &nbsp;Education Cess (+)</td>
                                <td style="text-align: Right" class="blackfnt">
                                    &nbsp;<asp:Label ID="Cess" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td style="text-align: left" class="blackfnt">
                                    &nbsp;TDS Rate</td>
                                <td style="text-align: Right" class="blackfnt">
                                    &nbsp;<asp:Label ID="TdsRate" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>
                            <tr style="background-color: White">
                                <td style="text-align: left" class="blackfnt">
                                    &nbsp;Higher Education Cess (+)</td>
                                <td style="text-align: Right" class="blackfnt">
                                    &nbsp;<asp:Label ID="HCess" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td style="text-align: left" class="blackfnt">
                                    &nbsp;TDS Amount (-)</td>
                                <td style="text-align: Right" class="blackfnt">
                                    &nbsp;<asp:Label ID="TDSAmt" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>
                            <tr style="background-color: White">
                                <td style="text-align: left" class="blackfnt">
                                    &nbsp;Service Tax Reg No.</td>
                                <td style="text-align: left" class="blackfnt">
                                    &nbsp;<asp:Label ID="StaxRegNo" runat="server" CssClass="blackfnt"></asp:Label></td>
                                <td style="text-align: left" class="blackfnt">
                                    &nbsp;PAN Number</td>
                                <td style="text-align: left" class="blackfnt">
                                    &nbsp;<asp:Label ID="PANNO" runat="server" CssClass="blackfnt"></asp:Label>
                                    <asp:HiddenField ID="Hnd_totalAmount" runat="server" Value="0.00" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="PaymentDetail" runat="server">
                    <td>
                        <br />
                        <table border="0" style="width: 800" bgcolor="#808080" cellpadding="2" cellspacing="1">
                            <tr bgcolor="white">
                                <td colspan="4" align="center">
                                    <font class="blackfnt"><b>Voucher Payment Details</b></font></td>
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
