<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ETHCBillApprovalDone.aspx.cs" Inherits="GUI_Finance_Billing_Ver1_Billcollection_ETHC_ETHCBillApprovalDone" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
        <table class="stbl" cellspacing="1" cellpadding="3" style="width: 400px" id="tblCriteria" runat="server">
        <tr class="hrow">
            <td colspan="10" align="center">
                <b>HCL Bill Approval Done</b>
            </td>
        </tr>
        <tr class="nrow">
            <td align="center">
                <asp:Label ID="lblstatus" runat="server"  Font-Bold="True" Font-Size="Medium" ForeColor="#006600"></asp:Label>

            </td>
        </tr>
        <tr class="nrow">
            <td align="center">
                <asp:Label ID="lblVoucherNo" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>

