<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="HCLBillGenerationDone.aspx.cs" Inherits="GUI_Finance_HCLBill_HCLBillGenerationDone" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table class="stbl" cellspacing="1" cellpadding="3" style="width: 400px" id="tblCriteria" runat="server">
        <tr class="hrow">
            <td colspan="10" align="center">
                <b>HCL Bill Generation Done</b>
            </td>
        </tr>
        <tr class="nrow">
            <td align="center">
                <asp:Label ID="lblSuc" runat="server" Text="Bill Generated Successfully" Font-Bold="True" Font-Size="Medium" ForeColor="#006600"></asp:Label>
            </td>
        </tr>
        <tr class="nrow">
            <td align="center">
                <asp:Label ID="lblBillno" runat="server"></asp:Label>
            </td>
        </tr>
        <tr class="nrow">
            <td align="center">
                <asp:LinkButton ID="lnkMore" runat="server" PostBackUrl="~/GUI/Finance/HCLBill/HCLBillGenerationCriteria.aspx" Font-Underline="True">Click here for More Bill Generation</asp:LinkButton>
            </td>
        </tr>
    </table>
</asp:Content>
