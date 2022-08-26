<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JournalVoucherView.aspx.cs"
    Inherits="GUI_Finance_voucher_Print_JournalVoucherView" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>WebXpress: Journal Voucher View</title>
</head>
<body style="font-size: 12pt; font-family: Times New Roman" runat="server" id="formbody">
    <form id="form1" runat="server">
    <div align="left">
        <br />
        <br />
        <br />
        <table bgcolor="#808080" border="<%=border%>" cellpadding="3" cellspacing="1" class="boxbg"
            style="width: 7.5in;">
            <tr class="blackfnt" bgcolor="#ffffff">
                <td colspan="6">
                    <asp:Image Height="50" ID="imgLogo" runat="server" />
                </td>
             </tr>
             <tr class="blackfnt" bgcolor="#ffffff">
                <td colspan="6">
                    <asp:Label ID="lblcompany"  Font-Bold="true" style="left:50;" CssClass="blackfnt" runat="server"></asp:Label>
                </td>
             </tr>
            <tr class="blackfnt" bgcolor="#ffffff">
                <td colspan="6">
                    <asp:Label ID="lblvoucherheader" Font-Bold="true" Style="left: 50;" CssClass="blackfnt"
                        runat="server"></asp:Label>
                </td>
            </tr>
            <tr class="blackfnt">
                <td align="left" class="bgbluegrey">
                    Voucher No.
                </td>
                <td align="left" bgcolor="#ffffff">
                    <asp:Label ID="lblvoucherno" runat="server"></asp:Label>
                </td>
                <td align="left" class="bgbluegrey">
                    Voucher Date
                </td>
                <td align="left" bgcolor="#ffffff">
                    <asp:Label ID="lblVoucherdate" runat="server"></asp:Label>
                </td>
            </tr>
            <%--<tr class="blackfnt">
                <td align="left" class="bgbluegrey">
                    Manual Voucher No.
                </td>
                <td align="left" bgcolor="#ffffff">
                    <asp:Label ID="LblManuavoucherno" runat="server"></asp:Label>
                </td>
                <td align="left" class="bgbluegrey">
                    Reference no.
                </td>
                <td align="left" bgcolor="#ffffff">
                    <asp:Label ID="lblRefno" runat="server"></asp:Label>
                </td>
            </tr>--%>
            <tr class="blackfnt">
                <td align="left" class="bgbluegrey">
                    Prepared at location
                </td>
                <td align="left" bgcolor="#ffffff">
                    <asp:Label ID="lblPreparedAt" CssClass="blackfnt" runat="server"></asp:Label>
                </td>
                <td align="left" class="bgbluegrey">
                    Prepared by
                </td>
                <td align="left" bgcolor="#ffffff">
                    <asp:Label ID="lblPreparedBY" CssClass="blackfnt" runat="server"></asp:Label>
                </td>
            </tr>
            <tr class="blackfnt">
                <td align="left" class="bgbluegrey">
                    Prepared for
                </td>
                <td align="left" colspan="3" bgcolor="#ffffff">
                    <asp:Label ID="lblPreparefor" CssClass="blackfnt" runat="server"></asp:Label>
                </td>
            </tr>
            <%--<tr class="blackfnt">
                <td align="left" class="bgbluegrey">
                    Narration
                </td>
                <td align="left" bgcolor="#ffffff" colspan="3">
                    <asp:Label ID="LblNarration" runat="server"></asp:Label>
                </td>
            </tr>--%>
            <tr class="blackfnt">
                <td align="left" class="bgbluegrey">
                    Trans Type
                </td>
                <td align="left" bgcolor="#ffffff" colspan="3">
                    <asp:Label ID="lbl_Transtype" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
        <br />
        <br />
        <table bgcolor="#808080" border="<%=border%>" cellpadding="0" cellspacing="1" class="boxbg"
            style="width: 7.5in;">
            <tr bgcolor="#ffffff">
                <td align="left" class="blackfnt">
                    <asp:GridView CssClass="boxbg" runat="server" CellSpacing="0" ID="grvcontrols" Width="100%"
                        AutoGenerateColumns="false" EmptyDataText="No Records Found..." ShowFooter="True"
                        OnRowDataBound="grvcontrols_RowDataBound">
                        <Columns>
                            <asp:TemplateField HeaderText="Description" HeaderStyle-Font-Bold="true">
                                <HeaderStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                                <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="left" />
                                <ItemTemplate>
                                    <asp:Label ID="lblDesc" Text='<%# DataBinder.Eval(Container.DataItem,"AccountDescription") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <FooterStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Right" />
                                <FooterTemplate>
                                    <strong>&nbsp; Total</strong>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Debit Amount" HeaderStyle-Font-Bold="true">
                                <HeaderStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                                <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="right" />
                                <ItemTemplate>
                                    <asp:Label ID="lblDebitAmt" Text='<%# DataBinder.Eval(Container.DataItem,"DebitAmount") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <FooterStyle CssClass="blackfnt" Font-Bold="true" BackColor="White" HorizontalAlign="Right" />
                                <FooterTemplate>
                                    <asp:Label ID="lblTotDebitAmt" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Credit Amount" HeaderStyle-Font-Bold="true">
                                <HeaderStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                                <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="right" />
                                <ItemTemplate>
                                    <asp:Label ID="lblCreditAmt" Text='<%# DataBinder.Eval(Container.DataItem,"CreditAmount") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <FooterStyle CssClass="blackfnt" Font-Bold="true" BackColor="White" HorizontalAlign="Right" />
                                <FooterTemplate>
                                    <asp:Label ID="lblTotCreditAmt" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="Cost Center Type" HeaderStyle-Font-Bold="true">
                                <HeaderStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                                <ItemStyle CssClass="blackfnt" BackColor="white" Wrap="true" />
                                <ItemTemplate>
                                    <asp:Label ID="lblDoctype" Text='<%# DataBinder.Eval(Container.DataItem,"DocType") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <FooterStyle CssClass="bgbluegrey" BackColor="White" HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Cost Center" HeaderStyle-Font-Bold="true">
                                <HeaderStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                                <ItemStyle CssClass="blackfnt" BackColor="white" Wrap="true" />
                                <ItemTemplate>
                                    <asp:Label ID="lblDocno" Text='<%# DataBinder.Eval(Container.DataItem,"DocNo") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <FooterStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Right" />
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Party" HeaderStyle-Font-Bold="true">
                                <HeaderStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                                <ItemStyle CssClass="blackfnt" BackColor="white" Wrap="true" />
                                <ItemTemplate>
                                    <asp:Label ID="lblDoctype" Text='<%# DataBinder.Eval(Container.DataItem,"Party") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <FooterStyle CssClass="bgbluegrey" BackColor="White" HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Narration" HeaderStyle-Font-Bold="true">
                                <HeaderStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="left" BackColor="white" />
                                <ItemTemplate>
                                    <asp:Label ID="lblNarration" Text='<%# DataBinder.Eval(Container.DataItem,"Narration") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <FooterStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Right" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="left" class="blackfnt">
                    <asp:Label ID="lblinwords" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
        <br />
        <table bgcolor="#808080" border="<%=border%>" cellpadding="3" cellspacing="1" class="boxbg"
            style="width: 7.5in;">
            <tr bgcolor="#ffffff">
                <td align="left" class="blackfnt">
                    Passing Authority
                </td>
                <td align="center" class="blackfnt">
                    Cashier/Acc
                </td>
                <td align="right" class="blackfnt">
                    Manager/Director
                </td>
            </tr>
        </table>
        <br />
        <div style="width: 7.5in;" align="left">
            <font class="blackfnt">ENCLOSE ALL SUPPORTING DOCUMENT</font></div>
        <br />
        <asp:Label ID="lbltotalmoney" Font-Bold="true" runat="server"></asp:Label>
        <br />
        <br />
        <div style="width: 7.5in;" align="left">
            <font class="blackfnt">Signature</font></div>
        <br />
    </div>
    </form>
</body>
</html>
