<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="VoucherCancellation_done.aspx.cs" Inherits="GUI_Operations_Voucher_Cancellation_VoucherCancellation_done" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<br />
<br /><br />
<div align="left" style="width: 10.0in;">
    <table align="center" bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="95%">
        <tr class="bgbluegrey">
            <td class="blackfnt" align="left" colspan="2">
                <b>Following voucher has been Successfully Cancelled </b>
            </td>
        </tr>
        <tr bgcolor="white">
            <td class="blackfnt" align="center">
                <b>Voucher Numbers</b>
            </td>
            <td class="blackfnt" align="center">
                <strong><font color="red"><asp:Label ID="lblvouchernos" runat="server"></asp:Label></font></strong>
            </td>
        </tr>
        <tr bgcolor="white">
            <td class="blackfnt" align="center">
                <b>Next Step</b>
            </td>
            <td class="blackfnt" align="center">
                <a href="VoucherCancellation.aspx">Click here to More Update Voucher Cancellation</a>
            </td>
        </tr>
    </table>
</div>    
</asp:Content>

