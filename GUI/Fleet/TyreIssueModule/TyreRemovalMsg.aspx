<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="TyreRemovalMsg.aspx.cs" Inherits="GUI_Fleet_TyreIssueModule_TyreRemovalMsg" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
 <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%">
        <tr>
            <td height="30">
                <font class="blackfnt"><strong>Tyre Issue/Removal Master</strong></font>
            </td>
        </tr>
        <tr>
            <td class="horzblue">
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>      
    </table>
    <br />
    <table width="500px" class="boxbg">
        <tr class="bgbluegrey">
            <td align="center" class="blackfnt">
                <b>Tyre Issue/Removal Master</b>
            </td>
        </tr>
        <tr class="bgwhite">
            <td align="center" class="blackfnt">
               <asp:Label ID="lblDocName" runat="server" Text=""></asp:Label>                
            </td>
        </tr>
        <tr class="bgbluegrey">
            <td align="left" class="blackfnt">
                <asp:LinkButton ID="LinkButton2" runat="server" OnClick="LinkButton2_Click">Click Here To Tyre Issue To Vehicle </asp:LinkButton>
            </td>
        </tr>
        <tr class="bgbluegrey">
            <td align="left" class="blackfnt">
                <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">Click Here To Tyre Remove To Vehicle </asp:LinkButton>
            </td>
        </tr>
    </table>
</asp:Content>

