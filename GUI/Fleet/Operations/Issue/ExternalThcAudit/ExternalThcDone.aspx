<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ExternalThcDone.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_ExternalThcAudit_ExternalThcDone" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript" src="../../../../images/dropdowncontent.js"></script>
    <div>
        <table style="width: 10in" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>
                    <img src="../../../../images/clear.gif" width="15" height="10"></td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Msg_err" CssClass="redfnt" Font-Bold="true" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr>
                <td>
                    <table border="0" cellpadding="1" cellspacing="1" class="boxbg" align="left" style="width: 7.0in">
                        <tr class="bgbluegrey">
                            <td align="center" colspan="3">
                                <font class="blackfnt"><b>Following External Thc has been Audited successfully :</b></font></td>
                        </tr>
                        <tr bgcolor="white">
                            <td>
                                <font class="blackfnt">External Thc No</font></td>
                            <td align="center">
                                <asp:Label ID="lblExternalThcNo" runat="server" CssClass="blackfnt" Width="313px"></asp:Label></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
