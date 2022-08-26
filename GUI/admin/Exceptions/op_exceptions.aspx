<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="op_exceptions.aspx.cs" Inherits="GUI_admin_Exceptions_op_exceptions"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 900px">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Exceptions in Operations</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br />
    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="500px">
        <tr bgcolor="#FFFFFF">
            <td align="left" width="80%" colspan="2">
                <font class="blackfnt">Manifest</font>&nbsp;
                <asp:LinkButton ID="LinkButton11" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Cancel" PostBackUrl="~/GUI/admin/exceptions/operations/cancel_manifest.aspx" />
            </td>
        </tr>
    </table>
</asp:Content>
