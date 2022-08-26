<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="CCM_DisplayResult.aspx.cs" Inherits="GUI_admin_CustomerContractMaster_CCM_DisplayResult"
    Title="Customer Contract Master - Display Result" %>

<%@ Register Src="~/GUI/admin/CustomerContractMaster/CustContractInfo.ascx" TagName="CustInfo"
    TagPrefix="cust" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:Panel runat="server" Width="10in">
        <br />
        <asp:Table CssClass="ftbl" runat="server" CellSpacing="1">
            <asp:TableRow CssClass="hrow">
                <asp:TableCell ColumnSpan="3" Font-Bold="true">Contract Successfully Updated</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="center" Font-Bold="true">
                    Contract ID</asp:TableCell>
                <asp:TableCell HorizontalAlign="center" Font-Bold="true">
                    <asp:Label ID="lbl_customername" runat="server" CssClass="nfnt"></asp:Label> </asp:TableCell>
                <asp:TableCell HorizontalAlign="center">
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="center">
                    <asp:Label ID="lblcontractid" runat="server" CssClass="redfnt" Font-Bold="true"></asp:Label></asp:TableCell>
                <asp:TableCell HorizontalAlign="center">
                    <asp:Label ID="lblcustcode" runat="server" CssClass="nfnt"></asp:Label></asp:TableCell>
                <asp:TableCell HorizontalAlign="Center">
                    <asp:Label ID="lblview" runat="server" onmouseover="this.style.cursor='pointer'"
                        Text="View" CssClass="nfnt" Font-Underline="true"></asp:Label>
                        <asp:LinkButton ID="lnkview" runat="server" CssClass="nfnt"></asp:LinkButton>
                        
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="hrow">
                <asp:TableCell ColumnSpan="3" Font-Bold="true" HorizontalAlign="left">
                    Your Next Step
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="left" ColumnSpan="3">
                    <asp:LinkButton ID="lnklist" runat="server" Text="Update Same Contract" onmouseover="this.style.cursor='pointer'"
                        OnClick="lnklist_Click" CssClass="nfnt"></asp:LinkButton>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="left" ColumnSpan="3">
                    <asp:LinkButton ID="lnkcontract" runat="server" Text="Update Other Contract" onmouseover="this.style.cursor='pointer'"
                        OnClick="lnkcontract_Click" CssClass="nfnt"></asp:LinkButton>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="left" ColumnSpan="3">
                       <asp:LinkButton ID="lnkcustomer" runat="server" Text="Update Other Customer" onmouseover="this.style.cursor='pointer'"
                        OnClick="lnkcustomer_Click" CssClass="nfnt"></asp:LinkButton> 
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </asp:Panel>
    <asp:HiddenField ID="hdnflagcstvnd" runat="server" />
</asp:Content>
