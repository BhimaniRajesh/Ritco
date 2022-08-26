<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DepositeVoucherView.aspx.cs" Inherits="GUI_Finance_chqMgt_Print_DepositeVoucherView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >

<head id="Head1" runat="server">
    <title>WebXpress: Deposit Voucher View</title>
    <% 
   if (Request.QueryString["printyn"].ToString() == "N")
   {   
       border = "0";
       %>    
        <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
<% } %>
<% else if (Request.QueryString["printyn"].ToString() == "Y")
   {
       border = "1";
       %>    
        <link id="Link2" href="~/GUI/images/style_print.css" rel="Stylesheet" type="text/css" runat="server" />
<% } %>    
</head>
<% if (Request.QueryString["printyn"].ToString() == "N")
   { %>
        <body style="font-size: 12pt; font-family: Times New Roman">
<% } %>
<% else if (Request.QueryString["printyn"].ToString() == "Y")
   { %>
        <body style="font-size: 12pt; font-family: Times New Roman" onload="javascript:window.print();">    
<% } %>
    <form id="form1" runat="server">
    <div>
<br />
<br />
<br />
<br />
<table bgcolor="#808080" border="<%=border%>" cellpadding="3" cellspacing="1" class="boxbg" style="width:9in;" align="center">
    <tr class="blackfnt">
        <td align="center" class="bgbluegrey" width="10%"><font class="blackfnt"><b>Bank Deposit Voucher Summary</b></font></td>
    </tr>
</table>
<br />
<table bgcolor="#808080" border="<%=border%>" cellpadding="3" cellspacing="1" class="boxbg" style="width:9in;" align="center">
    <tr class="blackfnt">
        <td align="left" class="bgbluegrey" width="20%">Payment Voucher No.</td>
        <td align="left" bgcolor="#ffffff" width="30%"><asp:Label ID="lblVoucherNo" runat="server"></asp:Label></td>
        <td align="left" class="bgbluegrey" width="20%">Voucher Date</td>
        <td align="left" bgcolor="#ffffff" width="30%"><asp:Label ID="lblVoucherDate" runat="server"></asp:Label></td>
    </tr>
    <tr class="blackfnt">
        <td align="left" class="bgbluegrey">Total deposit amount</td>
        <td align="left" bgcolor="#ffffff"><asp:Label ID="lblTotalDepositeAmount" runat="server"></asp:Label></td>
        <td align="left" class="bgbluegrey">Deposit Date </td>
        <td align="left" bgcolor="#ffffff"><asp:Label ID="lblDepositeDate" runat="server"></asp:Label></td>
    </tr>
    <tr class="blackfnt">
        <%--<td align="left" class="bgbluegrey">Manual Voucher No.</td>
        <td align="left" bgcolor="#ffffff"><asp:Label ID="lblManualVoucherNo" runat="server"></asp:Label></td>--%>
        <td align="left" class="bgbluegrey">Deposited in Account</td>
        <td colspan="3" align="left" bgcolor="#ffffff"><asp:Label ID="lblDepositedInAccount" runat="server"></asp:Label></td>
    </tr>
    <tr class="blackfnt">
        <td align="left" class="bgbluegrey">Narration</td>
        <td align="left" bgcolor="#ffffff" colspan="3"><asp:Label ID="lblNarration" runat="server"></asp:Label></td>
    </tr>
</table>
<br />
<table bgcolor="#808080" border="<%=border%>" cellpadding="3" cellspacing="1" class="boxbg" style="width:9in;" align="center">
    <tr class="blackfnt">
        <td align="center" class="bgbluegrey" width="10%"><font class="blackfnt"><b>Voucher Details</b></font></td>
    </tr>
</table>
<br />
<table bgcolor="#808080" border="<%=border%>" cellpadding="3" cellspacing="1" class="boxbg" style="width:9in;" align="center">
    <tr class="blackfnt">
        <td class="bgbluegrey">
            <table bgcolor="#808080" border="<%=border%>" cellpadding="3" cellspacing="1" class="boxbg" style="width:100%;" align="center">
                <tr class="blackfnt">
                    <td align="center" class="bgbluegrey" width="5%"><font class="blackfnt">Sr No</font></td>
                    <td align="center" class="bgbluegrey" width="12%"><font class="blackfnt">Cheque Number</font></td>
                    <td align="center" class="bgbluegrey" width="10%"><font class="blackfnt">Cheque Date</font></td>
                    <td align="right" class="bgbluegrey" width="15%"><font class="blackfnt">Amount</font></td>
                    <td align="center" class="bgbluegrey" width="10%"><font class="blackfnt">Entry Date</font></td>
                    <td align="center" class="bgbluegrey" width="30%"><font class="blackfnt">Received From</font></td>
                    <td align="center" class="bgbluegrey"><font class="blackfnt">Location Entry</font></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td bgcolor="#ffffff" colspan="7">
            <asp:Repeater ID="rptrDepositVoucher" runat="server">
                <ItemTemplate>
                    <table border=0 cellpadding="3" width="100%" bgcolor="#808080" cellspacing="1" class=boxbg>
                        <tr bgcolor="white"> 
                            <td align="center" width="5%"><font class=blackfnt><%# Container.ItemIndex + 1%></font></td>
                            <td align="center" width="12%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "ChqNo")%></font></td>
                            <td align="center" width="10%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "ChqDt")%></font></td>
                            <td align="right" width="15%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "ChqAmt")%></font></td>
                            <td align="center" width="10%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "EntryDate")%></font></td>
                            <td align="center" width="30%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "ReceivedFrom")%></font></td>
                            <td align="center"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "LocationOfEntry")%></font></td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:Repeater>
        </td>
    </tr>
    <tr class="blackfnt">
        <td class="bgbluegrey">
            <table bgcolor="#808080" border="<%=border%>" cellpadding="3" cellspacing="1" class="boxbg" style="width:100%;" align="center">
                <tr class="blackfnt">
                    <td bgcolor="#ffffff" width="5%"></td>
                    <td bgcolor="#ffffff" width="12%"></td>
                    <td align="right" bgcolor="#ffffff" width="10%"><font class="blackfnt"><b>Total</b></font></td>
                    <td align="right" bgcolor="#ffffff" width="15%"><font class="blackfnt"><b><asp:Label runat="server" ID="lblTotalAmount" Text=""></asp:Label></b></font></td>
                    <td bgcolor="#ffffff" width="10%"></td>
                    <td bgcolor="#ffffff" width="30%"></td>
                    <td bgcolor="#ffffff"></td>
                </tr>
            </table>
        </td>  
    </tr>
    <tr class="blackfnt">
        <td class="bgbluegrey" colspan="7">
            <table class="bgbluegrey" border="<%=border%>" cellpadding="3" cellspacing="1" width="100%">
                <tr class="blackfnt">
                    <td class="bgbluegrey" width="33%"><font class="blackfnt">PASSED BY :</font></td>
                    <td class="bgbluegrey"><font class="blackfnt">CERTIFIED BY :</font></td>
                    <td class="bgbluegrey"><font class="blackfnt">RECEIVER'S SIGNATURE :</font></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
    </div>
    </form>
</body>
</html>
