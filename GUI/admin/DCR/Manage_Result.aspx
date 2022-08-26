<%@ Page  Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Manage_Result.aspx.cs" Inherits="GUI_admin_DCR_Manage_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<div class="blackfnt">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Split Series</asp:Label>
                <hr align="center" size="1" color="#8ba0e5" />
            </td>
        </tr>
    </table>
    <br />
    <table cellspacing="1" cellpadding="2" class="boxbg" border="0" width="500">
        <tr class="bgbluegrey">
            <td colspan="2" align="left">
                <b>Following series is successfully managed.</b>
            </td>
        </tr>
        <tr class="bgwhite">
            <td width="150">
                BookCode:
            </td>
            <td>
                <asp:Label ID="lblBookCode" runat="server"></asp:Label>
            </td>
        </tr>
        <tr class="bgwhite">
            <td width="150">
                Series Strat-End:
            </td>
            <td>
                <asp:Label ID="lblFromTo" runat="server"></asp:Label>
            </td>
        </tr>
        <tr class="bgwhite">
            <td width="150">
                Action taken:
            </td>
            <td>
                <asp:Label ID="lblAction" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <font class="blackfnt">&nbsp;Please use menu for next action.</font>
</div>
</asp:Content>
