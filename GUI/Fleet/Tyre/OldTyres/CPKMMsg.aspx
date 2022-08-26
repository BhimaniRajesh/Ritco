<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="CPKMMsg.aspx.cs" Inherits="GUI_Fleet_Tyre_OldTyreStock_Claim_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table width="100%">
        <tr>
            <td>
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Tyre Module</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
                </br>
            </td>
        </tr>
    </table>
    <table width="500px" cellpadding="0" cellspacing="0" border="1" class="boxbg">
        <tr class="bgbluegrey">
            <td colspan="3" align="center">
                <asp:Label ID="lblTitle" runat="server" CssClass="blackboldfnt" Text="CPKM is Sent for Approval Successfully:"></asp:Label>
            </td>
        </tr>
        <tr class="bgwhite">
            <td align="center">
                <asp:Label ID="lblId" Visible="false" runat="server" CssClass="blackboldfnt" Text=""></asp:Label>
            </td>
        </tr>
        <tr class="bgwhite">
            <td>
                <asp:LinkButton ID="lnkClaim" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Click here for old tyre stock" Style="text-align: center" OnClick="lnkClaim_Click" />
            </td>
        </tr>
        
    </table>
</asp:Content>
