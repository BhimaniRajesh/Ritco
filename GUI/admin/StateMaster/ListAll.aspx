<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    EnableEventValidation="false" CodeFile="ListAll.aspx.cs" Inherits="GUI_admin_VehicleMaster_ListAll" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:Panel runat="server" HorizontalAlign="center" Style="width: 10in" ID="pnlMain">
        <br />
        <br />
        <asp:Table BorderWidth="0" runat="server" CellSpacing="0" HorizontalAlign="center"
            Width="100%" ID="tblHeader">
            <asp:TableRow CssClass="bgwhite" Width="100%" HorizontalAlign="Right">
                <asp:TableCell CssClass="blackfnt" HorizontalAlign="Right" Width="50%">
                    <b>State List</b></asp:TableCell>
                <asp:TableCell HorizontalAlign="Right">
                    <asp:LinkButton ID="lnkBtnDownloadXLS" CssClass="blackfnt" runat="server" OnClick="lnkBtnDownloadXLS_Click">Download XLS</asp:LinkButton></asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <asp:Table BorderWidth="0" CellPadding="0" CellSpacing="0" HorizontalAlign="center"
            CssClass="boxbg" Width="100%" ID="tblMain" runat="server">
            <asp:TableRow>
                <asp:TableCell>
                    <asp:GridView ID="gvStateListAll" BorderWidth="0" CellPadding="1" runat="server"
                        AllowSorting="true" AllowPaging="true" PageSize="20" AutoGenerateColumns="false"
                        CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" OnPageIndexChanging="pgChange"
                        PagerStyle-HorizontalAlign="left" PagerStyle-CssClass="bgwhite" Width="100%"
                        CssClass="boxbg" RowStyle-CssClass="bgwhite">
                        <Columns>
                            <asp:BoundField DataField="SerialNo" HeaderText="Sr. No">
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="STCD" HeaderText="State Code">
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="STNM" HeaderText="State Name">
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="STFORM" HeaderText="State Form">
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ACTIVEFLAG" HeaderText="Active Flag">
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="inoutbound" HeaderText="Inbound/Outbound">
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            
                        </Columns>
                        <PagerStyle HorizontalAlign="Left" CssClass="cssPager span" BackColor="#d4e0e7" />
                        <PagerSettings Mode="NumericFirstLast" FirstPageText="[First]" LastPageText="[Last]" />
                        <HeaderStyle CssClass="dgHeaderStyle" Height="20px" />
                    </asp:GridView>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </asp:Panel>
    <asp:GridView ID="gvStateListAllXLS" runat="server" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="SerialNo" HeaderText="Sr. No" ControlStyle-BorderWidth="1"
                HeaderStyle-BorderWidth="1" ItemStyle-BorderWidth="1">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="STCD" HeaderText="State Code" ControlStyle-BorderWidth="1"
                HeaderStyle-BorderWidth="1" ItemStyle-BorderWidth="1">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="STNM" HeaderText="State Name" ControlStyle-BorderWidth="1"
                HeaderStyle-BorderWidth="1" ItemStyle-BorderWidth="1">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="STFORM" HeaderText="State Form" ControlStyle-BorderWidth="1"
                HeaderStyle-BorderWidth="1" ItemStyle-BorderWidth="1">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="frt_rate" HeaderText="Freight Rate" ControlStyle-BorderWidth="1"
                HeaderStyle-BorderWidth="1" ItemStyle-BorderWidth="1">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="codedesc" HeaderText="Rate Type" ControlStyle-BorderWidth="1"
                HeaderStyle-BorderWidth="1" ItemStyle-BorderWidth="1">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="stax_exmpt_yn" HeaderText="Service Tax Exempted" ControlStyle-BorderWidth="1"
                HeaderStyle-BorderWidth="1" ItemStyle-BorderWidth="1">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="inoutbound" HeaderText="Inbound/Outbound" ControlStyle-BorderWidth="1"
                HeaderStyle-BorderWidth="1" ItemStyle-BorderWidth="1">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="ACTIVEFLAG" HeaderText="Active Flag" ControlStyle-BorderWidth="1"
                HeaderStyle-BorderWidth="1" ItemStyle-BorderWidth="1">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
           
        </Columns>
    </asp:GridView>
</asp:Content>
