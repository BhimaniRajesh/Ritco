<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Add_Edit_Done.aspx.cs" Inherits="GUI_admin_Accounts_masters_Acctgroup_Add_Edit_Done" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<br /><br />
<div align="left" style="width: 10.0in;">
    <table align="center" bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="95%">
        <tr class="bgbluegrey">
            <td class="blackfnt" align="left" colspan="2">
                <b><asp:Label ID="Lblmsg" runat="server"></asp:Label></b>
            </td>
        </tr>
        <tr bgcolor="white">
            <td class="blackfnt" align="center">
                <b>Account Code</b>
            </td>
            <td class="blackfnt" align="center">
                <font class="bluefnt"><asp:Label ID="lblaccountCode" Font-Bold="true" runat="server"></asp:Label></font>
            </td>
        </tr>
        <tr bgcolor="white">
            <td class="blackfnt" align="center">
                <b>Next Step</b>
            </td>
            <td class="blackfnt" align="center">
                <% if (flag == "new")
                   { %>
                        <a href="Add_Accounts.aspx?Data=new">Click here to Add More Account Code</a>
                <% }
                   else
                   { %>
                        <a href="Edit_Accounts.aspx">Click here to Update More Account Code</a>
                <% }%>
            </td>
        </tr>
    </table>
</div> 
</asp:Content>

