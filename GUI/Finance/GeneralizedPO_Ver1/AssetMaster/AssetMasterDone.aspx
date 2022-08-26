<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"  CodeFile="AssetMasterDone.aspx.cs" Inherits="GUI_Finance_GeneralizedPO_AssetMaster_AssetMasterDone" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:Panel runat="server" Width="8in" ID="divmain">
        <br />
        <br />
        <asp:Table runat="server" ID="tblmain" HorizontalAlign="center" Width="100%" CellSpacing="1"
            CssClass="ftbl">
            <asp:TableRow CssClass="hrow">
                <asp:TableCell HorizontalAlign="Center" ColumnSpan="3" Font-Bold="true">
                    <asp:Label ID="lblTitle" CssClass="hrow" runat="server" ></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="center" Font-Bold="true" Width="50%" ID="tdFinalizedDocket">
                    </asp:TableCell>
                <asp:TableCell HorizontalAlign="center">
                    <asp:Label ID="lblFinalizedDocket" CssClass="nfnt" Font-Bold="true" runat="server"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="nrow" ID="trBillNo" runat="server" Visible="false">
                <asp:TableCell HorizontalAlign="center" Font-Bold="true" Width="50%" ID="tdBillNo">
                    </asp:TableCell>
                <asp:TableCell HorizontalAlign="center">
                    <asp:Label ID="lblBillNo" CssClass="nfnt" Font-Bold="true" runat="server"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="frow">
                <asp:TableCell HorizontalAlign="left" ColumnSpan="2">
                    <b>Your Next Step</b></asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="left" ColumnSpan="2">
                    <asp:LinkButton ID="lnkBtnNewDocket" CssClass="bluefnt" runat="server" Font-Bold="false"></asp:LinkButton>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="left" ColumnSpan="2">
                    <asp:LinkButton ID="lnkEdit" CssClass="bluefnt" runat="server" Font-Bold="false"></asp:LinkButton>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </asp:Panel>
</asp:Content>
