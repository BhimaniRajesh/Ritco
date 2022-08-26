<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="ListAll.aspx.cs" Inherits="GUI_admin_CustomerMaster_ListAll"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:Panel runat="server" HorizontalAlign="center" Style="width: 10in" ID="pnlMain">
        <br />
        <br />
        <asp:Table BorderWidth="0" runat="server" CellSpacing="0" HorizontalAlign="center"
            Width="100%" ID="tblHeader">
            <asp:TableRow CssClass="bgwhite" Width="100%" HorizontalAlign="Right">
                <asp:TableCell CssClass="blackfnt" HorizontalAlign="Right" Width="50%">
                    <b>Warehouse List</b></asp:TableCell>
                <asp:TableCell CssClass="blackfnt" HorizontalAlign="Right">
                    <asp:LinkButton ID="lnkBtnDownloadXLS" runat="server" OnClick="lnkBtnDownloadXLS_Click">Download XLS</asp:LinkButton></asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <asp:Table BorderWidth="0" CellPadding="0" CellSpacing="0" HorizontalAlign="center"
            CssClass="boxbg" Width="100%" ID="tblMain" runat="server">
            <asp:TableRow>
                <asp:TableCell>
                    <asp:GridView ID="gvGodownListAll" BorderWidth="0" runat="server" AllowSorting="true"
                        AllowPaging="true" PageSize="20" AutoGenerateColumns="false" CellSpacing="1"
                        HeaderStyle-CssClass="bgbluegrey" OnPageIndexChanging="pgChange" PagerStyle-HorizontalAlign="left"
                        PagerStyle-CssClass="bgwhite" Width="100%" CssClass="boxbg" RowStyle-CssClass="bgwhite">
                        <Columns>
                            <asp:BoundField DataField="SrNo" HeaderText="Sr. No">
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="spdbrcd" HeaderText="Location">
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="godown_name" HeaderText="Warehouse Name">
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="godown_desc" HeaderText="Warehouse Description">
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ActiveFlag" HeaderText="Active Flag">
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                        </Columns>
                        <PagerStyle HorizontalAlign="Left" CssClass="cssPager span" BackColor="#d4e0e7" />
                        <PagerSettings Mode="NumericFirstLast" FirstPageText="[First]" LastPageText="[Last]" />
                        <HeaderStyle CssClass="dgHeaderStyle" />
                    </asp:GridView>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </asp:Panel>
    <asp:GridView ID="gvGodownListAllXLS" runat="server" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="SrNo" HeaderText="Sr. No">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="spdbrcd" HeaderText="Location">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="godown_name" HeaderText="Warehouse Name">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="godown_desc" HeaderText="Warehouse Description">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="ActiveFlag" HeaderText="Active Flag">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
        </Columns>
    </asp:GridView>
</asp:Content>
