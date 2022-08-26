<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewExpenseEntry.aspx.cs"
    Inherits="GUI_Finance_Vendor_BA_payment_ViewExpenseEntry" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Expense View</title>
    <link href="../../images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table border="0" cellspacing="1" width="95%" cellpadding="4" align="center" class="boxbg">
                <tr bgcolor="#FFFFFF">
                    <td align="center">
                        <font class="blackfnt"><b>Expense Entry Summary</b></font></td>
                </tr>
            </table>
            <br />
            <table border="0" cellspacing="1" cellpadding="4" width="95%" align="center" class="boxbg">
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <div align="left">
                            <font class="bluefnt">Bill Entry No</font>
                        </div>
                    </td>
                    <td>
                        <font class="bluefnt"><asp:Label ID="lblBillNo" runat="server"></asp:Label></font>
                    </td>
                    <td align="left">
                        <div align="left">
                            <font class="bluefnt">Bill Entry Date</font>
                        </div>
                    </td>
                    <td>
                        <font class="bluefnt"><asp:Label ID="lblBillEntryDt" runat="server"></asp:Label></font>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <div align="left">
                            <font class="bluefnt">Vendor Name </font>
                        </div>
                    </td>
                    <td width="30%">
                        <font class="bluefnt"><asp:Label ID="lblVendorName" runat="server"></asp:Label></font>
                    </td>
                    <td align="left">
                        <div align="left">
                            <font class="bluefnt">Vendor Accounted to</font>
                        </div>
                    </td>
                    <td nowrap>
                        <font class="bluefnt"><asp:Label ID="lblVendorAccTo" runat="server"></asp:Label></font>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td height="21" bgcolor="#FFFFFF" align="left" width="166">
                        <div align="left">
                            <font class="bluefnt">Vendor Bill Number</font></div>
                    </td>
                    <td height="21" bgcolor="#FFFFFF" align="left" width="222">
                        <font class="bluefnt"><asp:Label ID="lblVendorBillNo" runat="server"></asp:Label></font>
                    </td>
                    <td valign="top">
                        <div align="left">
                            <font class="bluefnt">Vendor Bill Amount</font>
                        </div>
                    </td>
                    <td align="left">
                        <font class="bluefnt"><asp:Label ID="lblVendorBillAmt" runat="server"></asp:Label></font>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td height="21" bgcolor="#FFFFFF" align="left" width="166">
                        <div align="left">
                            <font class="bluefnt">Vendor Bill Date</font>
                        </div>
                    </td>
                    <td height="21" bgcolor="#FFFFFF" align="left" width="222">
                        <font class="bluefnt"><asp:Label ID="lblVendorBillDt" runat="server"></asp:Label></font>
                    </td>
                    <td height="21" bgcolor="#FFFFFF" align="left" width="166">
                        <div align="left">
                            <font class="bluefnt">Due Date</font>
                        </div>
                    </td>
                    <td height="21" bgcolor="#FFFFFF" align="left" width="222">
                        <font class="bluefnt"><asp:Label ID="lblDueDt" runat="server"></asp:Label></font>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td>
                        <div align="left">
                            <font class="bluefnt">Ref. NO.</font>
                        </div>
                    </td>
                    <td>
                        <font class="bluefnt"><asp:Label ID="lblRefNo" runat="server"></asp:Label></font>
                    </td>
                    <td valign="top">
                        <div align="left">
                            <font class="bluefnt">Remark</font>
                        </div>
                    </td>
                    <td>
                        <font class="bluefnt"><asp:Label ID="lblRemarks" runat="server"></asp:Label></font>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td valign="top">
                        <div align="left">
                            <font class="bluefnt">Other Deduction</font>
                        </div>
                    </td>
                    <td valign="top">
                        <font class="bluefnt"><asp:Label ID="lblOtherDeduction" runat="server"></asp:Label></font>
                    </td>
                    <td valign="top">
                        <div align="left">
                            <font class="bluefnt">Discount Received</font>
                        </div>
                    </td>
                    <td valign="top">
                        <font class="bluefnt"><asp:Label ID="lblDiscountRecvd" runat="server"></asp:Label></font>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td valign="top">
                        <div align="left">
                            <font class="blackfnt"></font>
                        </div>
                    </td>
                    <td valign="top">
                        <font class="blackfnt"> </font>
                    </td>
                    <td valign="top">
                        <div align="left">
                            <font class="blackfnt"><strong>Net Amount</strong></font>
                        </div>
                    </td>
                    <td valign="top">
                        <font class="blackfnt"><asp:Label ID="lblNetAmt" runat="server"></asp:Label></font>
                    </td>
                </tr>
            </table>
            <br />
            <table border="1" cellspacing="1" width="100%" cellpadding="4" align="center" class="boxbg">
                <tr bgcolor="#FFFFFF">
                    <td align="center">
                        <font class="blackfnt"><b>Details of Account Head </b></font>
                    </td>
                </tr>
            </table>
            <br />
            <asp:GridView align="center" ID="gvpdclist" BorderWidth="0" runat="server" CellSpacing="1"
                HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="true" PageSize="10"
                PagerStyle-HorizontalAlign="left" CssClass="boxbg" FooterStyle-CssClass="boxbg"
                PagerSettings-Mode="NumericFirstLast" HeaderStyle-Height="24px" AutoGenerateColumns="false"
                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..."
                Width="100%">
                <Columns>
                    <asp:TemplateField HeaderText="SRNo." ControlStyle-CssClass="blackfnt">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Width="30" />
                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                        <ItemTemplate>
                            <asp:Label ID="lblSRNo" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="accdesc" HeaderText="Account Head">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="debit" HeaderText="Debit Amount">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Narration" HeaderText="Narration">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                    </asp:BoundField>
                </Columns>
                <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                <HeaderStyle CssClass="bgbluegrey" />
                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                <FooterStyle CssClass="boxbg" />
            </asp:GridView>
            <br />
            <table border="0" cellspacing="1" cellpadding="4" width="100%" align="center" class="boxbg">
                <tr class="bgbluegrey">
                    <td align="center">
                        <font class="blackfnt"><b>Tax</font></td>
                    <td align="center">
                        <font class="blackfnt"><b>Account Head</font></td>
                    <td align="center">
                        <font class="blackfnt"><b>Approved Rate</font></td>
                    <td align="center">
                        <font class="blackfnt"><b>Value</font></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td>
                        <font class="blackfnt">Service Tax</font></td>
                    <td>
                        <font class="blackfnt">SERVICE TAX ( CENVET ) </font>
                    </td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label ID="lblServiceTaxRate" runat="server"></asp:Label></font>
                    </td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label ID="lblServiceTaxValue" runat="server"></asp:Label></font>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td>
                        <font class="blackfnt">Education Cess</font></td>
                    <td>
                        <font class="blackfnt"><font class="blackfnt">Cenvat (Education Cess) Receivable A/c </font></font>
                    </td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label ID="lblEduCessRate" runat="server"></asp:Label></font>
                    </td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label ID="lblEduCessValue" runat="server"></asp:Label></font>
                    </td>
                </tr>
                
                <tr bgcolor="#FFFFFF">
                    <td>
                        <font class="blackfnt">Higher Education Cess</font></td>
                    <td>
                        <font class="blackfnt"><font class="blackfnt">Cenvat (Higher Edu Cess) Receivable A/c </font></font>
                    </td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label ID="lblHigherEduRate" runat="server"></asp:Label></font>
                    </td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label ID="lblHigherEduValue" runat="server"></asp:Label></font>
                    </td>
                </tr>
                
                <tr bgcolor="#FFFFFF">
                    <td>
                        <font class="blackfnt">TDS</td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label ID="lblTDS" runat="server"></asp:Label></font>
                    </td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label ID="lblTDSRate" runat="server"></asp:Label></font>
                    </td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label ID="lblTDSValue" runat="server"></asp:Label></font>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td colspan="3">
                        <font class="blackfnt"><b>Net Payable Amount</b></font></td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label ID="lblNetPayableAmt" runat="server"></asp:Label></font>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
