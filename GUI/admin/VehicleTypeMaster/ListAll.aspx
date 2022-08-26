<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="ListAll.aspx.cs" Inherits="GUI_admin_VehicleMaster_ListAll" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:Panel runat="server" HorizontalAlign="center" Style="width: 10in" ID="pnlMain">
        <br />
        <br />
        <asp:Table BorderWidth="0" runat="server" CellSpacing="0" HorizontalAlign="center"
            Width="100%" ID="tblHeader">
            <asp:TableRow CssClass="bgwhite" Width="100%" HorizontalAlign="Right">
                <asp:TableCell CssClass="blackfnt" HorizontalAlign="Right" Width="50%">
                    <b>Vehicle Type List</b></asp:TableCell>
                <asp:TableCell HorizontalAlign="Right">
                    <asp:LinkButton ID="lnkBtnDownloadXLS" CssClass="blackfnt" runat="server" OnClick="lnkBtnDownloadXLS_Click">Download XLS</asp:LinkButton></asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <asp:Table BorderWidth="0" CellPadding="0" CellSpacing="0" HorizontalAlign="center"
            CssClass="boxbg" Width="100%" ID="tblMain" runat="server">
            <asp:TableRow>
                <asp:TableCell>
                    <asp:GridView ID="gvVehicleTypeListAll" BorderWidth="0" runat="server" AllowSorting="true"
                        AllowPaging="true" PageSize="20" AutoGenerateColumns="false" CellSpacing="1"
                        HeaderStyle-CssClass="bgbluegrey" OnPageIndexChanging="pgChange" PagerStyle-HorizontalAlign="left"
                        PagerStyle-CssClass="bgwhite" Width="100%" CssClass="boxbg" RowStyle-CssClass="bgwhite">
                        <Columns>
                            <asp:BoundField DataField="SrNo" HeaderText="Sr. No">
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="type_code" HeaderText="Vehicle Type Code">
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="type_name" HeaderText="Vehicle Type Description">
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
    <asp:GridView ID="gvVehicleTypeListAllXLS" runat="server" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="SrNo" HeaderText="Sr. No" ControlStyle-BorderWidth="1"
                HeaderStyle-BorderWidth="1" ItemStyle-BorderWidth="1">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="type_code" HeaderText="Vehicle Type Code" ControlStyle-BorderWidth="1"
                HeaderStyle-BorderWidth="1" ItemStyle-BorderWidth="1">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="type_name" HeaderText="Vehicle Type Description" ControlStyle-BorderWidth="1"
                HeaderStyle-BorderWidth="1" ItemStyle-BorderWidth="1">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Made_By" HeaderText="Made By" ControlStyle-BorderWidth="1"
                HeaderStyle-BorderWidth="1" ItemStyle-BorderWidth="1">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="VehicleType" HeaderText="Vehicle Type" ControlStyle-BorderWidth="1"
                HeaderStyle-BorderWidth="1" ItemStyle-BorderWidth="1">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Model_No" HeaderText="Model No" ControlStyle-BorderWidth="1"
                HeaderStyle-BorderWidth="1" ItemStyle-BorderWidth="1">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Type_Desc" HeaderText="Type Desc" ControlStyle-BorderWidth="1"
                HeaderStyle-BorderWidth="1" ItemStyle-BorderWidth="1">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Fuel_Type" HeaderText="Fuel Type" ControlStyle-BorderWidth="1"
                HeaderStyle-BorderWidth="1" ItemStyle-BorderWidth="1">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Rate_Per_KM" HeaderText="Rate Per KM" ControlStyle-BorderWidth="1"
                HeaderStyle-BorderWidth="1" ItemStyle-BorderWidth="1">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="length" HeaderText="Length" ControlStyle-BorderWidth="1"
                HeaderStyle-BorderWidth="1" ItemStyle-BorderWidth="1">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="width" HeaderText="Width" ControlStyle-BorderWidth="1"
                HeaderStyle-BorderWidth="1" ItemStyle-BorderWidth="1">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Height" HeaderText="Height" ControlStyle-BorderWidth="1"
                HeaderStyle-BorderWidth="1" ItemStyle-BorderWidth="1">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="TYRE_SIZEID" HeaderText="Tyre Size Id" ControlStyle-BorderWidth="1"
                HeaderStyle-BorderWidth="1" ItemStyle-BorderWidth="1">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="GVW" HeaderText="GVW" ControlStyle-BorderWidth="1" HeaderStyle-BorderWidth="1"
                ItemStyle-BorderWidth="1">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="unld_wt" HeaderText="Unladen Weight" ControlStyle-BorderWidth="1"
                HeaderStyle-BorderWidth="1" ItemStyle-BorderWidth="1">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Capacity" HeaderText="Capacity" ControlStyle-BorderWidth="1"
                HeaderStyle-BorderWidth="1" ItemStyle-BorderWidth="1">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="ActiveFlag" HeaderText="Active Flag" ControlStyle-BorderWidth="1"
                HeaderStyle-BorderWidth="1" ItemStyle-BorderWidth="1">
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
            </asp:BoundField>
        </Columns>
    </asp:GridView>
</asp:Content>
