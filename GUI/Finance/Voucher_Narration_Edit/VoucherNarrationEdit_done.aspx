<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="VoucherNarrationEdit_done.aspx.cs" Inherits="GUI_Finance_Voucher_Narration_Edit_VoucherNarrationEdit_done" %>

<asp:Content ID="Content1" runat="server" contentplaceholderid="MyCPH1">

    <br />
    <br />
    <br />
    <div align="left" style="width: 10.0in;">
        <table align="center" bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="95%">
            <tr class="bgbluegrey">
                <td class="blackfnt" align="left" colspan="2">
                    <b>Following voucher Narration has been Successfully Edit </b>
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
                    <a href="Voucher_narrationEdit.aspx">Click here to More Edit Voucher Narration</a>
                </td>
            </tr>
        </table>
    </div>    
                    
</asp:Content>
