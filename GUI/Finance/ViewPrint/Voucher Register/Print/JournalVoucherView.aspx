<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JournalVoucherView.aspx.cs" Inherits="GUI_Finance_voucher_Print_JournalVoucherView" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>WebXpress: Journal Voucher View</title>
</head>
<body style="font-size: 12pt; font-family: Times New Roman" runat="server" id="formbody">
<form id="form1" runat="server">
<div align="left">
<br />
<br /><br />
    <table bgcolor="#808080" border="<%=border%>" cellpadding="3" cellspacing="1" class="boxbg" style="width:6.5in;">
         <tr class="blackfnt" bgcolor="#ffffff">
         <td colspan="6">
         <asp:Label ID="lblvoucherheader"  Font-Bold="true" style="left:50;" CssClass="blackfnt" runat="server"></asp:Label>
         </td>
         </tr>
          <tr class="blackfnt">
            <td align="left" class="bgbluegrey">Voucher No.</td>
            <td align="left" bgcolor="#ffffff"><asp:Label ID="lblvoucherno" runat="server"></asp:Label></td>
            <td align="left" class="bgbluegrey">Voucher Date</td>
            <td align="left" bgcolor="#ffffff"><asp:Label ID="lblVoucherdate" runat="server"></asp:Label></td>
          </tr>
          <tr class="blackfnt">
            <td align="left" class="bgbluegrey">Manual Voucher No.</td>
            <td align="left" bgcolor="#ffffff"><asp:Label ID="LblManuavoucherno" runat="server"></asp:Label></td>
            <td align="left" class="bgbluegrey">Reference no.</td>
            <td align="left" bgcolor="#ffffff"><asp:Label ID="lblRefno" runat="server"></asp:Label></td>
          </tr>
          <tr class="blackfnt">
            <td align="left" class="bgbluegrey">Prepared at location</td>
            <td align="left" bgcolor="#ffffff"><asp:Label ID="lblPreparedAt" CssClass="blackfnt" runat="server"></asp:Label></td>
            <td align="left" class="bgbluegrey">Prepared by</td>
            <td align="left" bgcolor="#ffffff"><asp:Label ID="lblPreparedBY" CssClass="blackfnt" runat="server"></asp:Label></td>
          </tr>
          <tr class="blackfnt">
            <td align="left" class="bgbluegrey">Prepared for</td>
            <td align="left" colspan="3" bgcolor="#ffffff"><asp:Label ID="lblPreparefor" CssClass="blackfnt" runat="server"></asp:Label></td>
          </tr>
          <%--<tr class="blackfnt">
            <td align="left" class="bgbluegrey">Pay To</td>
            <td align="left" bgcolor="#ffffff" colspan="3"><asp:Label ID="lblPayto" runat="server"></asp:Label></td>
          </tr>--%>
          <tr class="blackfnt">
            <td align="left" class="bgbluegrey">Narration</td>
            <td align="left" bgcolor="#ffffff" colspan="3"><asp:Label ID="LblNarration" runat="server"></asp:Label></td>
          </tr>
          <tr class="blackfnt">
            <td align="left" class="bgbluegrey">Trans Type</td>
            <td align="left" bgcolor="#ffffff" colspan="3"><asp:Label ID="lbl_Transtype" runat="server"></asp:Label></td>
          </tr>
    </table>
    <br /><br />
        <table bgcolor="#808080" border="<%=border%>" cellpadding="3" cellspacing="1" class="boxbg" style="width:6.5in;">
          <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">
                <table border="<%=border%>" cellpadding="3" width="100%" bgcolor="#808080" cellspacing="1" class=boxbg>
                    <tr  class="bgbluegrey"> 
                        <td align="center" class="blackfnt" width="25%">Description</td>
                        <td align="center" class="blackfnt" width="25%">Party</td>
                        <td align="center" class="blackfnt" width="10%">Debit Amount</td>
                        <td align="center" class="blackfnt" width="10%">Credit Amount</td>
                        <td align="center" class="blackfnt" width="30%">Narration</td>
                    </tr>
                </table>
            </td>
          </tr>
          <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">
                <asp:Repeater ID="rptrJournalVoucher" runat="server">
                    <ItemTemplate>
                        <table border="<%=border%>" cellpadding="3" width="100%" bgcolor="#808080" cellspacing="1" class=boxbg>
                            <tr bgcolor="white"> 
                                <td align="left" width="25%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "AccountDescription")%></font></td>
                                <td align="left" width="25%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "Party")%></font></td>
                                <td align="right" width="10%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "DebitAmount")%></font></td>
                                <td align="right" width="10%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "CreditAmount")%></font></td>
                                <td align="left" width="30%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "Narration")%></font></td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:Repeater>
            </td>
          </tr>
          <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">
                <table border="<%=border%>" cellpadding="3" width="100%" bgcolor="#808080" cellspacing="1" class=boxbg>
                    <tr bgcolor="white"> 
                        <td align="right" class="blackfnt" width="50%"><strong>Total Rs.</strong></td>
                        <td align="right" class="blackfnt" width="10%"><asp:Label ID="lblTotalDebitAmount" runat="server"></asp:Label></td>
                        <td align="right" class="blackfnt" width="10%"><asp:Label ID="lblTotalCreditAmount" runat="server"></asp:Label></td>
                        <td colspan="2" width="30%"></td>
                    </tr>
                </table>
            </td>
          </tr>
          <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">
                <asp:Label ID="lblinwords" runat="server"></asp:Label>
            </td>
          </tr>
        </table> 
        <br />
        <table bgcolor="#808080" border="<%=border%>" cellpadding="3" cellspacing="1" class="boxbg" style="width:6.5in;">
          <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">Passing Authority </td>
            <td align="center" class="blackfnt">Cashier/Acc</td>
            <td align="right" class="blackfnt">Manager/Director</td>
          </tr>
        </table>  
 <br />
 <div style="width:6.5in;" align="left"> <font class="blackfnt">ENCLOSE ALL SUPPORTING DOCUMENT</font></div><br />
 <asp:Label ID="lbltotalmoney" Font-Bold="true" runat="server"></asp:Label>
 <br /><br />
 <div style="width:6.5in;" align="left"> <font class="blackfnt">Signature</font></div><br />
 </div>
    </form>
</body>
</html>