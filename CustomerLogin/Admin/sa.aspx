<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPageSA.master" AutoEventWireup="true"
    CodeFile="sa.aspx.cs" Inherits="GUI_admin_sa" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Welcome to Super Admin Operations.</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br />
    <table class="boxbg" cellspacing="1" cellpadding="1" border="0" width="400px">
        <tr class="bgbluegrey">
            <td align="center">
                <font class="blackfnt"><b>List of Operations</b></font></td>
        </tr>
        <tr style="background: white">
            <td align="left">
                <li>
                    <font class="blackfnt">Add Menus to ERP</font>
                    <%--<asp:LinkButton runat="server" ID="lnkAddMenu" CssClass="bluefnt" Text="Add Menus to ERP"
                        PostBackUrl="~/GUI/admin/addmenu.aspx"></asp:LinkButton>--%>
                </li>
            </td>
        </tr>
        <tr style="background: white">
            <td align="left">
                <li>
                    <asp:LinkButton runat="server" ID="lnkMngMenus" CssClass="bluefnt" Text="Manage Menus of ERP"
                        PostBackUrl="~/GUI/admin/ManageMenus.aspx"></asp:LinkButton>
                </li>
            </td>
        </tr>
        <tr style="background: white">
            <td align="left">
                    <li><asp:LinkButton runat="server" ID="lnkMngRules" CssClass="bluefnt" Text="Manage Rules"
                        PostBackUrl="~/GUI/admin/ManageRules.aspx"></asp:LinkButton></li>
<%--                <li><font class="blackfnt">Manage Rules</font></li>
--%>            </td>
        </tr>
    </table>
</asp:Content>
