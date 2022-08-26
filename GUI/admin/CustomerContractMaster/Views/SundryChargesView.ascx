<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SundryChargesView.ascx.cs"
    Inherits="GUI_admin_CustomerContractMaster_Views_SundryChargesView" %>
<%@ Register Src="~/GUI/admin/CustomerContractMaster/Views/CCMFilter.ascx" TagPrefix="ccm"
    TagName="Filter" %>
<div class="blackfnt">
    <asp:Table ID="Table1" Width="10in" runat="server">
        <asp:TableRow>
            <asp:TableCell>
                <asp:Table ID="Table2" runat="server" Width="10in" CssClass="boxbg" CellSpacing="1">
                    <asp:TableRow CssClass="bgbluegrey">
                        <asp:TableCell>
                                <b>Advanced Search</b>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>
                <ccm:Filter ID="ucfilter" runat="server" />
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell CssClass="blackfnt">
                <asp:Table ID="Table3" runat="server" Width="10in" CssClass="boxbg" CellSpacing="1">
                    <asp:TableRow CssClass="bgbluegrey">
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:LinkButton ID="lnksearch" runat="server" Text="Search" OnClick="lnksearch_Click"
                                Font-Bold="true"></asp:LinkButton>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>
            
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow ID="trslabrange" runat="server">
            <asp:TableCell>
                <asp:Table ID="Table4" runat="server" CellSpacing="1" Width="100%" CssClass="boxbg">
                    <asp:TableRow CssClass="bgbluegrey">
                        <asp:TableCell ColumnSpan="12" Font-Bold="true">
                    Multiple Slab Sundry Slab Range
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
                    <asp:TableRow CssClass="bgwhite">
                        <asp:TableCell ColumnSpan="2" HorizontalAlign="Center">
                            <asp:Label ID="lblratetype1" runat="server" CssClass="blackfnt"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell ColumnSpan="2" HorizontalAlign="Center">
                            <asp:Label ID="lblratetype2" runat="server" CssClass="blackfnt"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell ColumnSpan="2" HorizontalAlign="Center">
                            <asp:Label ID="lblratetype3" runat="server" CssClass="blackfnt"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell ColumnSpan="2" HorizontalAlign="Center">
                            <asp:Label ID="lblratetype4" runat="server" CssClass="blackfnt"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell ColumnSpan="2" HorizontalAlign="Center">
                            <asp:Label ID="lblratetype5" runat="server" CssClass="blackfnt"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell ColumnSpan="2" HorizontalAlign="Center">
                            <asp:Label ID="lblratetype6" runat="server" CssClass="blackfnt"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow ID="trheader" runat="server">
            <asp:TableCell>
                <asp:Table runat="server" CssClass="boxbg" CellSpacing="1" Width="100%">
                    <asp:TableRow CssClass="bgbluegrey">
                        <asp:TableCell>
                            <asp:Label ID="lblheader" Font-Bold="true" runat="server"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:TableCell></asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>
                <asp:GridView HorizontalAlign="left" ID="grvcharges" runat="server" BorderWidth="0"
                    CellSpacing="1" Width="10in" PagerSettings-Position="TopAndBottom" PageSize="10" AllowPaging="true" OnPageIndexChanging="grvcharges_PageIndexChanging" PagerStyle-HorizontalAlign="left"
                    CssClass="boxbg" HeaderStyle-CssClass="dgHeaderStyle" PagerStyle-CssClass="dgHeaderStyle" RowStyle-CssClass="dgRowStyle"
                    EmptyDataRowStyle-CssClass="bgwhite" EmptyDataText="No Record Found...." RowStyle-HorizontalAlign="Center"
                    AutoGenerateColumns="true" HeaderStyle-Font-Bold="true">
                    <Columns>
                    </Columns>
                </asp:GridView>
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>
    <asp:HiddenField ID="hdncontractid" runat="server" />
</div>
