<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ContraVoucherView.aspx.cs"
    Inherits="GUI_Finance_voucher_Print_ContraVoucherView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>WebXpress: Contra Voucher View</title>
    <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 9.5in;">
            <table bgcolor="#808080" border="0" class="boxbg" style="width: 9.5in;">
                <tr class="blackfnt">
                    <td align="center" valign="middle" class="blackfnt" bgcolor="#ffffff" style="width: 50%;">
                        <font class="bluefnt"><b>CONTRA VOUCHER</b></font><br />
                        <asp:Label ID="lbljnvoucher" CssClass="bluefnt" runat="server"></asp:Label>
                    </td>
                    <td align="left" class="bgbluegrey" style="width: 50%;">
                        <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg"
                            style="width: 100%;">
                            <tr class="blackfnt">
                                <td align="left" class="bgbluegrey">
                                    Voucher No.</td>
                                <td align="left" bgcolor="#ffffff">
                                    <asp:Label ID="lblvoucherno" CssClass="blackfnt" runat="server"></asp:Label></td>
                            </tr>
                            <tr class="blackfnt">
                                <td align="left" class="bgbluegrey">
                                    Voucher Date</td>
                                <td align="left" bgcolor="#ffffff">
                                    <asp:Label ID="lblvoucherdate" CssClass="blackfnt" runat="server"></asp:Label></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <br />
            <table id="tblacclist" class="boxbg" cellpadding="3" cellspacing="1" style="width: 9.5in;">
                <tr class="bgbluegrey">
                    <td width="50%">
                        <font class="blackfnt"><b>A/C Description</b></font></td>
                    <td width="10%">
                        <font class="blackfnt"><b>Chq No</b></font></td>
                    <td width="10%">
                        <font class="blackfnt"><b>Chq Date</b></font></td>
                    <td width="15%">
                        <font class="blackfnt"><b>Debit Amount</b></font></td>
                    <td width="15%">
                        <font class="blackfnt"><b>Credit Amount</b></font></td>
                </tr>
                <tr>
                    <td colspan="5" bgcolor="#ffffff">
                        <asp:Repeater ID="rptrContraVoucher" runat="server">
                            <ItemTemplate>
                                <table border="0" cellpadding="3" width="100%" bgcolor="#808080" cellspacing="1"
                                    class="boxbg">
                                    <tr bgcolor="white">
                                        <td align="left" width="50%">
                                            <font class="blackfnt">
                                                <%#DataBinder.Eval(Container.DataItem, "AccountDescription")%>
                                            </font>
                                        </td>
                                        <td align="right" width="10%">
                                            <font class="blackfnt">
                                                <%#DataBinder.Eval(Container.DataItem, "chqno")%>
                                            </font>
                                        </td>
                                        <td align="right" width="10%">
                                            <font class="blackfnt">
                                                <%#DataBinder.Eval(Container.DataItem, "dt123")%>
                                            </font>
                                        </td>
                                        <td align="right" width="15%">
                                            <font class="blackfnt">
                                                <%#DataBinder.Eval(Container.DataItem, "DebitAmount")%>
                                            </font>
                                        </td>
                                        <td align="right" width="15%">
                                            <font class="blackfnt">
                                                <%#DataBinder.Eval(Container.DataItem, "CreditAmount")%>
                                            </font>
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:Repeater>
                    </td>
                </tr>
            </table>
            <br />
            <table id="Table1" class="boxbg" cellpadding="3" cellspacing="1" style="width: 9.5in;">
                <tr class="blackfnt">
                    <td align="left" class="bgbluegrey" width="10%">
                        Narration :
                    </td>
                    <td colspan="2" align="left" bgcolor="#ffffff">
                        <asp:Label runat="server" ID="lblNarration"></asp:Label></td>
                </tr>
            </table>
            <br />
            <br />
            <br />
            <table id="Table2" class="boxbg" cellpadding="3" cellspacing="1" style="width: 9.5in;">
                <tr>
                    <td bgcolor="#FFFFFF" align="left" colspan="5">
                        <font size="2" class="blackfnt">RUPEES IN WORDS :
                            <%=totamt %>
                        </font>
                    </td>
                </tr>
                <tr style="height: 0.3in">
                    <td bgcolor="#ffffff" align="left" colspan="1">
                        <font class="blackfnt" size="2">PREPARED BY :
                            <%=emp %>
                        </font>
                    </td>
                    <td bgcolor="#ffffff" align="left">
                        <font class="blackfnt" size="2">CERTIFIED BY :</font></td>
                    <td bgcolor="#ffffff" align="left">
                        <font size="2" class="blackfnt">RECEIVER'S SIGNATURE :</font></td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
