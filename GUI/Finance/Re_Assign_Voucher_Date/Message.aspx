<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Message.aspx.cs" Inherits="GUI_Finance_Billing_BillEdit_Message" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<link href="../../images/style.css" rel="stylesheet" type="text/css" />
    <div align="left" style="width: 10in;">
        <br /><br />
        <table cellpadding="3" cellspacing="1" class="boxbg" width="100%">
            <tr class="bgbluegrey">
                <td class="blackfnt" align="center">
                    <asp:Label runat="server" ID="lblmessage"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
