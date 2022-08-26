<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="ErrorPage.aspx.cs" Inherits="GUI_ErrorPage" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
   
   <div align="left">
   <br /><br />
    <asp:Table runat="server" ID="tblmain" CssClass="boxbg" CellSpacing="1" Width="10in">
        <asp:TableRow CssClass="bgbluegrey">
            <asp:TableCell HorizontalAlign="Left" Height="20px">
                <asp:Label ID="lblheading" runat="server" Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow BackColor="White">
        <asp:TableCell Height="3in" CssClass="blackfnt" Font-Bold="true" VerticalAlign="Top">
            <br /><br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Error occured because of following Reasons
                <br /><br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.&nbsp;&nbsp;&nbsp;
                <asp:Label ID="lbldetail1" runat="server" CssClass="blackfnt" Width="8in"></asp:Label>
                <br /><br /><br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.&nbsp;&nbsp;&nbsp;
                <asp:Label ID="lbldetail2" runat="server" CssClass="blackfnt" Width="8in"></asp:Label>
                <br /><br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Possible Suggesions 
                <br /><br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.&nbsp;&nbsp;&nbsp;
                <asp:Label ID="lblsuggesion1" runat="server" CssClass="blackfnt" Width="8in"></asp:Label>
                <br /><br /><br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.&nbsp;&nbsp;&nbsp;
                <asp:Label ID="lblsuggesion2" runat="server" CssClass="blackfnt" Width="8in"></asp:Label>
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>
   </div>
</asp:Content>
