<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="RouteCityListAll.aspx.cs" Inherits="GUI_admin_RouteCity_RouteCityListAll" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:Panel runat="server" HorizontalAlign="center" Style="width: 10in" ID="pnlMain">
        <br />
        <br />
        <asp:Table BorderWidth="0" runat="server" CellSpacing="0" HorizontalAlign="center"
            Width="100%" ID="tblHeader">
            <asp:TableRow CssClass="bgwhite" Width="100%" HorizontalAlign="Right">
                <asp:TableCell CssClass="blackfnt" HorizontalAlign="Right" Width="50%">
                    <b>City Based Route List</b></asp:TableCell>
                <asp:TableCell CssClass="blackfnt" HorizontalAlign="Right">
                    <asp:LinkButton ID="lnkBtnDownloadXLS" runat="server" OnClick="lnkBtnDownloadXLS_Click">Download XLS</asp:LinkButton></asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <asp:Table BorderWidth="0" CellPadding="0" CellSpacing="0" HorizontalAlign="center"
            CssClass="boxbg" Width="100%" ID="tblMain" runat="server">
            <asp:TableRow>
                <asp:TableCell>
                    <asp:GridView ID="gvRouteListAll" BorderWidth="0" runat="server" AllowSorting="true"
                        AllowPaging="true" PageSize="20" AutoGenerateColumns="false" CellSpacing="1"
                        HeaderStyle-CssClass="bgbluegrey" OnPageIndexChanging="pgChange" PagerStyle-HorizontalAlign="left"
                        PagerStyle-CssClass="bgwhite" Width="100%" CssClass="boxbg" RowStyle-CssClass="bgwhite">
                        <Columns>
                            <asp:BoundField DataField="SrNo" HeaderText="Sr. No">
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="rutcd" HeaderText="Route Code">
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="rutnm" HeaderText="Route Name">
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="rutmod" HeaderText="Route Mode">
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="rutkm" HeaderText="Total KM">
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="transhrs" HeaderText="Total Transit(Hrs.)">
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                        </Columns>
                        <PagerStyle HorizontalAlign="Left" CssClass="cssPager span" BackColor="#d4e0e7" />
                        <PagerSettingsUpdateMode="NumericFirstLast" FirstPageText="[First]" LastPageText="[Last]" />
                        <HeaderStyle CssClass="dgHeaderStyle" />
                    </asp:GridView>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </asp:Panel>
    <asp:GridView ID="gvRouteListAllXLS" runat="server" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="SrNo" HeaderText="Sr. No">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="rutcd" HeaderText="Route Code">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="rutnm" HeaderText="Route Name">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="rutmod" HeaderText="Route Mode">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="rutkm" HeaderText="Total KM">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="transhrs" HeaderText="Total Transit(Hrs.)">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
        </Columns>
    </asp:GridView>
</asp:Content>
