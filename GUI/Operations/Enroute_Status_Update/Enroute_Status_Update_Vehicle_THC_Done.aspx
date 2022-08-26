<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Enroute_Status_Update_Vehicle_THC_Done.aspx.cs" Inherits="GUI_Operations_Enroute_Status_Update_Enroute_Status_Update_Vehicle_THC_Done" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:Panel runat="server" Width="8in" ID="divmain">
        <br />
        <br />
        <asp:Table runat="server" ID="tblmain" HorizontalAlign="center" Width="99%" CellSpacing="1"
            CssClass="boxbg">
            <asp:TableRow CssClass="hrow">
                <asp:TableCell HorizontalAlign="Center" Font-Bold="true" ColumnSpan="2">
                    <asp:Label ID="lblTitle" Font-Bold="true" CssClass="hfnt" runat="server"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="center" Font-Bold="true">
                    <asp:Label ID="lblHeader" CssClass="blackfnt" runat="server" />
                </asp:TableCell><asp:TableCell HorizontalAlign="Center">
                    <asp:Label ID="lblDockno" CssClass="bluefnt" Font-Bold="true" runat="server" />
                </asp:TableCell></asp:TableRow><asp:TableRow CssClass="hrow" Font-Bold="true">
                <asp:TableCell ColumnSpan="2">
                    Your Next Step
                </asp:TableCell></asp:TableRow><asp:TableRow CssClass="nrow">
                <asp:TableCell ColumnSpan="2">
                    <asp:LinkButton ID="lnknext" runat="server" PostBackUrl="Enroute_Status_Update_Step1.aspx"
                        Text="Click here another Enroute Status Update" CssClass="nfnt"></asp:LinkButton>
                </asp:TableCell></asp:TableRow></asp:Table></asp:Panel></asp:Content>
