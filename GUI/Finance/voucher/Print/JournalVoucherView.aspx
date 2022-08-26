<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JournalVoucherView.aspx.cs" Inherits="GUI_Finance_voucher_Print_JournalVoucherView" %>

<html>
    <head>
        <title>WebXpress: Journal Voucher View</title>
    <link id="Link1" href="../../../images/style.css" rel="Stylesheet" type="text/css" runat="server" />
        
    </head>
    
    <body>
    <div align="center" style="width:9.5in;">
    <table bgcolor="#808080" border="0"class="boxbg" style="width:9.5in;">
          <tr class="blackfnt">
            <td align="center" valign="middle" class="blackfnt" bgcolor="#ffffff" style="width:50%;">
                <font class="bluefnt"><b>JOURNAL VOUCHER</b></font><br />
                <asp:Label ID="lbljnvoucher" CssClass="bluefnt" runat="server"></asp:Label>
            </td>
            <td align="left" class="bgbluegrey"  style="width:50%;">
                    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" style="width:100%;">
                          <tr class="blackfnt">
                            <td align="left" class="bgbluegrey">Voucher No.</td>
                            <td align="left" bgcolor="#ffffff">
                                <asp:Label ID="lblvoucherno" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                          </tr>
                          
                          <tr class="blackfnt">
                            <td align="left" class="bgbluegrey">Voucher Date</td>
                            <td align="left" bgcolor="#ffffff">
                                <asp:Label ID="lblvoucherdate" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                          </tr>
                          
                          <tr class="blackfnt">
                            <td align="left" class="bgbluegrey">Branch </td>
                            <td align="left" bgcolor="#ffffff">
                                <asp:Label ID="lblbranchcode" CssClass="blackfnt" runat="server"></asp:Label> : <asp:Label ID="lblbranchname" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                          </tr>
                          
                          <tr class="blackfnt">
                            <td align="left" class="bgbluegrey">Manual Voucher No </td>
                            <td align="left" bgcolor="#ffffff">
                                <asp:Label ID="lblmanvno" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                          </tr>
                    </table>
            </td>
        </tr>
    </table>
<br />


    <asp:Table ID="tblacclist" runat="server" CellPadding="3" CssClass="boxbg" CellSpacing="1" style="width:9.5in;">
        <asp:TableRow CssClass="bgbluegrey">
            <asp:TableCell CssClass="blackfnt" Font-Bold="true">A/C CODE</asp:TableCell>
            <asp:TableCell CssClass="blackfnt" Font-Bold="true">A/C NAME</asp:TableCell>
            <asp:TableCell ColumnSpan="2" CssClass="blackfnt" Font-Bold="true">AMOUNT</asp:TableCell>
            <asp:TableCell CssClass="blackfnt" Font-Bold="true">Narration</asp:TableCell>
        </asp:TableRow>
    </asp:Table>

    
<%--
    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" style="width:9in;">
          <tr class="blackfnt">
            <td align="left" style="width:20%;" class="bgbluegrey">Branch </td>
            <td align="left" style="width:45%;" bgcolor="#ffffff">
                <asp:Label ID="lblbranch" CssClass="blackfnt" runat="server"></asp:Label>
            </td>
            <td align="left" style="width:20%;" class="bgbluegrey">Voucher No.</td>
            <td align="left" style="width:15%;" bgcolor="#ffffff">
            </td>
          </tr>
    </table>--%>
</div>
    </body>
</html>
