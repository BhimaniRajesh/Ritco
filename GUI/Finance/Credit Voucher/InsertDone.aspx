<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="InsertDone.aspx.cs" Inherits="GUI_Finance_Credit_Voucher_InsertDone" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script type="text/javascript" language="javascript" src="../../../../GUI/images/CalendarPopup.js"></script>
    <script type="text/javascript" language="javascript" src="../../../../GUI/images/commonJs.js"></script>
    <script language="javascript" type="text/javascript" >
    
    </script>
  <div align="left" style="width: 10in;">
    <table border="0" cellpadding="0" class="boxbg" cellspacing="0">
        <tr bgcolor="white">
            <td align="left" colspan="5" height="30" style="width: 459px">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                <b>Operations</b></font></a> <b>&gt; </b><a href=""><font class="blklnkund">
                <b>Credit Voucher</b></font></a> <b>&gt;</b>
            </td>
        </tr>
    </table>
    <br />
    
    <table align="center" bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="80%">
        <tr class="bgbluegrey">
            <td class="blackfnt" align="center" colspan="2">
                <b>Credit Voucher Done Successfully</b>
            </td>
        </tr>
        <tr  bgcolor="white"  colspan="2">
            <td class="blackfnt" align="left">
                <b>Next Step</b>
            </td>
            <td class="blackfnt" align="center">
                <a href="CreditVoucher.aspx">Click here For Using Default Date</a>    
            </td>
        </tr>
        <tr  bgcolor="white"  colspan="2">
            <td class="blackfnt" align="left">
                <b></b>
            </td>
            <td class="blackfnt" align="center">
                <a href="CreditVoucher.aspx?Vdate=<%=VoucherDate%>">Click here For Using New Date</a>    
            </td>
        </tr>
       <%-- <tr  bgcolor="white"  >
            <td class="blackfnt" align="left">
                <b></b>
            </td>
            <td class="blackfnt" align="left">
               
            </td>
        </tr>--%>
    </table>

</asp:Content>

