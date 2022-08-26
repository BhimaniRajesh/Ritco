<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="ResultTyre.aspx.cs" Inherits="GUI_Fleet_Tyre_TyreIssueRemoval_ResultTyre" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table width="100%">
        <tr>
            <td>
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Tyre Interchange Master</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
                </br>
            </td>
        </tr>
    </table>
    <table width="50%" border="1">
        <tr class="bgbluegrey">
            <td align="center">
                <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server">Tyre Interchange Master</asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblMsg" CssClass="blackfnt" Font-Bold="true" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                </br>
            </td>
        </tr>       
        <tr>
            <td>
                <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">Click here to Interchange more Tyre.</asp:LinkButton>
            </td>
        </tr>
    </table>
</asp:Content>
