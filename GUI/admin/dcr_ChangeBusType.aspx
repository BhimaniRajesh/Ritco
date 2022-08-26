<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="dcr_ChangeBusType.aspx.cs" Inherits="GUI_admin_dcr_ChangeBusType" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<table cellspacing="1" style="width: 100%">
    <tr style="background-color: white" width="75%">
        <td align="left">
            <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Change Business Type for DCR Series</asp:Label>
            <hr align="center" size="1" color="#8ba0e5">
        </td>
    </tr>
</table>
<br />
<div class="blackfnt">
<table cellpadding="2" cellspacing="1" border="0" class="boxbg">
    <tr class="bgbluegrey" align="center" valign="middle">
        <td><b>BookCode</b></td>
        <td><b>Series From</b></td>
        <td><b>Series To</b></td>
        <td><b>New Business Type</b></td>
    </tr>
    <tr bgcolor="white">
        <td>
            <asp:Label ID="lblBookCode" runat="server"></asp:Label>
            <asp:HiddenField ID="hidDocKey" runat="server" />
        </td>
        <td><asp:Label ID="lblDcrFrom" runat="server"></asp:Label></td>
        <td><asp:Label ID="lblDcrTo" runat="server"></asp:Label></td>
        <td><asp:DropDownList ID="ddlBusType" runat="server"></asp:DropDownList></td>
    </tr>
    <tr bgcolor="white">
        <td colspan="4" align="center">
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" BorderStyle="groove" OnClick="btnSubmit_Click" />
        </td>
    </tr>
</table>
</div>
</asp:Content>

