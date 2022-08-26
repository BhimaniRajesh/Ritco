<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ViewODACharges.ascx.cs"
    Inherits="GUI_admin_CustomerContractMaster_Views_ViewODACharges" %>
<%@ Register Src="~/GUI/admin/CustomerContractMaster/Views/CCMFilter.ascx" TagName="Filter"
    TagPrefix="ccm" %>
<asp:Table ID="Table1" runat="server" Width="10in">
    <asp:TableRow>
        <asp:TableCell>
            <asp:Table ID="Table4" runat="server" CellSpacing="1" Width="100%" CssClass="boxbg">
                <asp:TableRow CssClass="bgbluegrey">
                    <asp:TableCell ColumnSpan="12" Font-Bold="true">
                    ODA Slab Range
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell ColumnSpan="2" Font-Bold="true" HorizontalAlign="Center">
                   Slab 1
                    </asp:TableCell>
                    <asp:TableCell ColumnSpan="2" Font-Bold="true" HorizontalAlign="Center">
                    Slab 2
                    </asp:TableCell>
                    <asp:TableCell ColumnSpan="2" Font-Bold="true" HorizontalAlign="Center">
                   Slab 3
                    </asp:TableCell>
                    <asp:TableCell ColumnSpan="2" Font-Bold="true" HorizontalAlign="Center">
                    Slab 4
                    </asp:TableCell>
                    <asp:TableCell ColumnSpan="2" Font-Bold="true" HorizontalAlign="Center">
                    Slab 5
                    </asp:TableCell>
                    <asp:TableCell ColumnSpan="2" Font-Bold="true" HorizontalAlign="Center">
                    Slab 6
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell>From</asp:TableCell>
                    <asp:TableCell>To</asp:TableCell>
                    <asp:TableCell>From</asp:TableCell>
                    <asp:TableCell>To</asp:TableCell>
                    <asp:TableCell>From</asp:TableCell>
                    <asp:TableCell>To</asp:TableCell>
                    <asp:TableCell>From</asp:TableCell>
                    <asp:TableCell>To</asp:TableCell>
                    <asp:TableCell>From</asp:TableCell>
                    <asp:TableCell>To</asp:TableCell>
                    <asp:TableCell>From</asp:TableCell>
                    <asp:TableCell>To</asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell HorizontalAlign="Right">
                        <asp:Label ID="lblfrom1" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Right">
                        <asp:Label ID="lblto1" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Right">
                        <asp:Label ID="lblfrom2" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Right">
                        <asp:Label ID="lblto2" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Right">
                        <asp:Label ID="lblfrom3" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Right">
                        <asp:Label ID="lblto3" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Right">
                        <asp:Label ID="lblfrom4" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Right">
                        <asp:Label ID="lblto4" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Right">
                        <asp:Label ID="lblfrom5" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Right">
                        <asp:Label ID="lblto5" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Right">
                        <asp:Label ID="lblfrom6" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Right">
                        <asp:Label ID="lblto6" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </asp:TableCell>
    </asp:TableRow>
    <asp:TableRow>
        <asp:TableCell>
            <asp:Table ID="Table3" runat="server" CellSpacing="1" Width="100%" CssClass="boxbg">
                <asp:TableRow CssClass="bgbluegrey">
                    <asp:TableCell ColumnSpan="12" Font-Bold="true">
                    ODA Distance(in KM)
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell ColumnSpan="2" Font-Bold="true" HorizontalAlign="Center">
                   Slab 1
                    </asp:TableCell>
                    <asp:TableCell ColumnSpan="2" Font-Bold="true" HorizontalAlign="Center">
                    Slab 2
                    </asp:TableCell>
                    <asp:TableCell ColumnSpan="2" Font-Bold="true" HorizontalAlign="Center">
                   Slab 3
                    </asp:TableCell>
                    <asp:TableCell ColumnSpan="2" Font-Bold="true" HorizontalAlign="Center">
                    Slab 4
                    </asp:TableCell>
                    <asp:TableCell ColumnSpan="2" Font-Bold="true" HorizontalAlign="Center">
                    Slab 5
                    </asp:TableCell>
                    <asp:TableCell ColumnSpan="2" Font-Bold="true" HorizontalAlign="Center">
                    Slab 6
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell>From</asp:TableCell>
                    <asp:TableCell>To</asp:TableCell>
                    <asp:TableCell>From</asp:TableCell>
                    <asp:TableCell>To</asp:TableCell>
                    <asp:TableCell>From</asp:TableCell>
                    <asp:TableCell>To</asp:TableCell>
                    <asp:TableCell>From</asp:TableCell>
                    <asp:TableCell>To</asp:TableCell>
                    <asp:TableCell>From</asp:TableCell>
                    <asp:TableCell>To</asp:TableCell>
                    <asp:TableCell>From</asp:TableCell>
                    <asp:TableCell>To</asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell HorizontalAlign="Right">
                        <asp:Label ID="lbldistfrom1" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Right">
                        <asp:Label ID="lbldistto1" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Right">
                        <asp:Label ID="lbldistfrom2" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Right">
                        <asp:Label ID="lbldistto2" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Right">
                        <asp:Label ID="lbldistfrom3" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Right">
                        <asp:Label ID="lbldistto3" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Right">
                        <asp:Label ID="lbldistfrom4" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Right">
                        <asp:Label ID="lbldistto4" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Right">
                        <asp:Label ID="lbldistfrom5" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Right">
                        <asp:Label ID="lbldistto5" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Right">
                        <asp:Label ID="lbldistfrom6" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Right">
                        <asp:Label ID="lbldistto6" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </asp:TableCell>
    </asp:TableRow>
    <asp:TableRow>
        <asp:TableCell>&nbsp;</asp:TableCell></asp:TableRow>
    <asp:TableRow>
        <asp:TableCell>
            <asp:Table Width="100%" runat="server" CssClass="boxbg" CellSpacing="1">
                 <asp:TableRow CssClass="bgbluegrey">
        <asp:TableCell Font-Bold="true">ODA Rate Matrix</asp:TableCell></asp:TableRow>
</asp:Table>
        </asp:TableCell></asp:TableRow>
    <asp:TableRow>
        <asp:TableCell>
            <asp:GridView HorizontalAlign="left" ID="grvcharges" runat="server" BorderWidth="0"
                Width="10in" CellSpacing="1" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                HeaderStyle-CssClass="bgbluegrey" AllowPaging="false" FooterStyle-CssClass="bgbluegrey"
                AutoGenerateColumns="true" RowStyle-HorizontalAlign="Right" EmptyDataRowStyle-CssClass="bgwhite"
                RowStyle-CssClass="bgwhite" HeaderStyle-Font-Bold="true" EmptyDataText="No Records Found..."
                OnRowDataBound="grvcharges_RowDataBound">
                <Columns>
                </Columns>
            </asp:GridView>
        </asp:TableCell>
    </asp:TableRow>
</asp:Table>
