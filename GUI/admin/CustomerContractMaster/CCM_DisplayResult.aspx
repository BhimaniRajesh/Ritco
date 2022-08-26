<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="CCM_DisplayResult.aspx.cs" Inherits="GUI_admin_CustomerContractMaster_CCM_DisplayResult"
    Title="Customer Contract Master - Display Result" %>

<%@ Register Src="~/GUI/admin/CustomerContractMaster/CustContractInfo.ascx" TagName="CustInfo"
    TagPrefix="cust" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:Panel runat="server" Width="10in">
        <br />
        <asp:Table CssClass="boxbg" runat="server" CellSpacing="1" Width="100%">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell ColumnSpan="3" Font-Bold="true">Contract Successfully Updated</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="center" Font-Bold="true">
                    Contract ID</asp:TableCell>
                <asp:TableCell HorizontalAlign="center" Font-Bold="true">
                    Customer Name</asp:TableCell>
                <asp:TableCell HorizontalAlign="center">
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="center">
                    <asp:Label ID="lblcontractid" runat="server" CssClass="redfnt" Font-Bold="true"></asp:Label></asp:TableCell>
                <asp:TableCell HorizontalAlign="center">
                    <asp:Label ID="lblcustcode" runat="server" CssClass="blackfnt"></asp:Label></asp:TableCell>
                <asp:TableCell HorizontalAlign="Center">
                    <asp:Label ID="lblview" runat="server" onmouseover="this.style.cursor='pointer'"
                        Text="Vew/Print/XLS" CssClass="blackfnt" Font-Underline="true"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell ColumnSpan="3" Font-Bold="true" HorizontalAlign="left">
                    Your Next Step
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="left" ColumnSpan="3">
                    <asp:LinkButton ID="lnklist" runat="server" Text="Update Same Contract" onmouseover="this.style.cursor='pointer'"
                        OnClick="lnklist_Click" CssClass="blackfnt"></asp:LinkButton>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="left" ColumnSpan="3">
                    <asp:LinkButton ID="lnkcontract" runat="server" Text="Update other Contract" onmouseover="this.style.cursor='pointer'"
                        OnClick="lnkcontract_Click" CssClass="blackfnt"></asp:LinkButton>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="left" ColumnSpan="3">
                       <asp:LinkButton ID="lnkcustomer" runat="server" Text="Update Other Customer" onmouseover="this.style.cursor='pointer'"
                        OnClick="lnkcustomer_Click" CssClass="blackfnt"></asp:LinkButton> 
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </asp:Panel>
</asp:Content>
