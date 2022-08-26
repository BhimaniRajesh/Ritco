<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="GSTMaster.aspx.cs" Inherits="GUI_admin_GSTMaster_GSTMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:Panel runat="server" HorizontalAlign="left" Style="width: 10in" ID="pnlMain">
        <br />
        <br />
        <asp:Table CssClass="boxbg" CellPadding="1" ID="tblMain" runat="server" CellSpacing="1"
            Width="100%">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell HorizontalAlign="center" Font-Bold="true" ColumnSpan="7">
                    GST Masters
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite" Visible="false">
                <asp:TableCell HorizontalAlign="center" Style="width: 15px;" VerticalAlign="Middle">
                    <asp:Image ID="Image3" runat="server" ImageAlign="Middle" ImageUrl="~/GUI/images/band_strip3.gif" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="left" CssClass="blackfnt">
                   SAC Master
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="center">
                    <asp:LinkButton ID="lnkBtnAddCustomerGroups" CssClass="bluefnt" runat="server" Font-Bold="false"
                        Text="Add"  PostBackUrl="~/GUI/admin/GSTMaster/GSTSacMaster.aspx" />
                </asp:TableCell>
                <%--<asp:TableCell HorizontalAlign="center">
                   
                </asp:TableCell><asp:TableCell HorizontalAlign="center">
                   
                </asp:TableCell><asp:TableCell HorizontalAlign="center">
                   
                </asp:TableCell><asp:TableCell HorizontalAlign="center">
                    
                </asp:TableCell>--%>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="center" Style="width: 15px;" VerticalAlign="Middle">
                    <asp:Image ID="Image1" runat="server" ImageAlign="Middle" ImageUrl="~/GUI/images/band_strip3.gif" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="left" CssClass="blackfnt">
                   Service Type-SAC Mapping Master
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="center">
                    <asp:LinkButton ID="LinkButton1" CssClass="bluefnt" runat="server" Font-Bold="false"
                        Text="Add"  PostBackUrl="~/GUI/admin/GSTMaster/GSTSacProductMapingMaster.aspx" />
                </asp:TableCell>
                <%--<asp:TableCell HorizontalAlign="center">
                   
                </asp:TableCell><asp:TableCell HorizontalAlign="center">
                   
                </asp:TableCell><asp:TableCell HorizontalAlign="center">
                   
                </asp:TableCell><asp:TableCell HorizontalAlign="center">
                    
                </asp:TableCell>--%>
            </asp:TableRow>

            <asp:TableRow CssClass="bgwhite" >
                <asp:TableCell HorizontalAlign="center" Style="width: 15px;" VerticalAlign="Middle">
                    <asp:Image ID="Image6" runat="server" ImageAlign="Middle" ImageUrl="~/GUI/images/band_strip3.gif" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="left" CssClass="blackfnt">
                    Product- Service Type Mapping
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="center">
                    <asp:LinkButton ID="LinkButton5" CssClass="bluefnt" runat="server" Font-Bold="false"
                        Text="Add"  PostBackUrl="~/GUI/admin/GSTMaster/GSTProductServiceMapingMaster.aspx" />
                </asp:TableCell>
                <%--<asp:TableCell HorizontalAlign="center">
                   
                </asp:TableCell><asp:TableCell HorizontalAlign="center">
                   
                </asp:TableCell><asp:TableCell HorizontalAlign="center">
                   
                </asp:TableCell><asp:TableCell HorizontalAlign="center">
                    
                </asp:TableCell>--%>
            </asp:TableRow>

            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="center" Style="width: 15px;" VerticalAlign="Middle">
                    <asp:Image ID="Image5" runat="server" ImageAlign="Middle" ImageUrl="~/GUI/images/band_strip3.gif" />
                </asp:TableCell><asp:TableCell HorizontalAlign="left" CssClass="blackfnt">
                    Customer GST registration master
                </asp:TableCell><asp:TableCell HorizontalAlign="center">
                    <asp:LinkButton ID="LinkButton2" CssClass="bluefnt" runat="server" Font-Bold="false"
                        Text="Add" PostBackUrl="~/GUI/admin/GSTMaster/CustomerGSTRegistration.aspx" />
                </asp:TableCell>
                <%--<asp:TableCell HorizontalAlign="center">
                   
                </asp:TableCell><asp:TableCell HorizontalAlign="center">
                    
                </asp:TableCell><asp:TableCell HorizontalAlign="center">
                   
                </asp:TableCell><asp:TableCell HorizontalAlign="center">
                    
                </asp:TableCell>--%>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="center" Style="width: 15px;" VerticalAlign="Middle">
                    <asp:Image ID="Image2" runat="server" ImageAlign="Middle" ImageUrl="~/GUI/images/band_strip3.gif" />
                </asp:TableCell><asp:TableCell HorizontalAlign="left" CssClass="blackfnt">
                    Company GST registration master
                </asp:TableCell><asp:TableCell HorizontalAlign="center">
                    <asp:LinkButton ID="LinkButton3" CssClass="bluefnt" runat="server" Font-Bold="false"
                        Text="Add" PostBackUrl="~/GUI/admin/GSTMaster/CompanyGSTRegistration.aspx" />
                </asp:TableCell>
                <%--<asp:TableCell HorizontalAlign="center">
                   
                </asp:TableCell><asp:TableCell HorizontalAlign="center">
                    
                </asp:TableCell><asp:TableCell HorizontalAlign="center">
                   
                </asp:TableCell><asp:TableCell HorizontalAlign="center">
                    
                </asp:TableCell>--%>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="center" Style="width: 15px;" VerticalAlign="Middle">
                    <asp:Image ID="Image4" runat="server" ImageAlign="Middle" ImageUrl="~/GUI/images/band_strip3.gif" />
                </asp:TableCell><asp:TableCell HorizontalAlign="left" CssClass="blackfnt">
                    Vendor GST registration master
                </asp:TableCell><asp:TableCell HorizontalAlign="center">
                    <asp:LinkButton ID="LinkButton4" CssClass="bluefnt" runat="server" Font-Bold="false"
                        Text="Add" PostBackUrl="~/GUI/admin/GSTMaster/VendorGSTRegistration.aspx" />
                </asp:TableCell>
                <%--<asp:TableCell HorizontalAlign="center">
                   
                </asp:TableCell><asp:TableCell HorizontalAlign="center">
                   
                </asp:TableCell><asp:TableCell HorizontalAlign="center">
                   
                </asp:TableCell><asp:TableCell HorizontalAlign="center">
                    
                </asp:TableCell>--%>
            </asp:TableRow>
        </asp:Table>
    </asp:Panel>
</asp:Content>

