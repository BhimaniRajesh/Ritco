<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="UpdateAdvTHCChqPytLocResult.aspx.cs" Inherits="GUI_Operations_new_THC_Ver2_UpdateAdvTHCChqPytLocResult" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" style="height: 26px">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Update THC Payment Location</asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
        </tr>
    </table>

    <table border="0" class="boxbg" cellpadding="2" cellspacing="1" width="50%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">

                <asp:Label ID="lblHeader" runat="server" Font-Bold="true" Text="THC Payment Location updated successfully" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>

        <tr style="background-color: White">
            <td align="center">
                <asp:HyperLink ID="hyper" NavigateUrl="UpdateAdvTHCChqPytLoc.aspx" Text="Click here to Update another THC Payment Location" runat="server"></asp:HyperLink>
            </td>
        </tr>
    </table>
</asp:Content>

