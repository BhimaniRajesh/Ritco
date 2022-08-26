<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="VirtualLogin.aspx.cs" Inherits="GUI_VirtualLogin" Title="Untitled Page" EnableViewStateMac="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Change Working Location</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>

    <table cellspacing="1" cellpadding="5" border="0" runat="server" style="width: 50%" class="boxbg" id="tblAllotTo" visible="true">
        <tr class="bgbluegrey">
            <td align="center" colspan="2">
                <asp:Label ID="lblAllot" CssClass="blackfnt" Font-Bold="True" runat="server">Select New Working Location</asp:Label>
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="left" width="10%">
                <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="false" runat="server">Location:</asp:Label>
            </td>
            <td align="left">
                <asp:DropDownList ID="cboLoc" runat="server" AutoPostBack="false" EnableViewState="true"
                    DataTextField="Location" DataValueField="LocCode" OnDataBound="onLocationDataBound"
                    OnSelectedIndexChanged="onLocationChange" />
<%--                <asp:RequiredFieldValidator ID="RFV" runat="server" ControlToValidate="cboAllotTo"
                    ErrorMessage="*" CssClass="redfnt" ValidationGroup="grpDCR"></asp:RequiredFieldValidator>
--%>            </td>
        </tr>

        <tr style="background-color: white" >
            <td align="right" colspan="2">
                <asp:Button ID="btnSubmit" runat="server" Text="Change >>" OnClick="onLocationChange"/>
            </td>
        </tr>

    </table>
</asp:Content>

