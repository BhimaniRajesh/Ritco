<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Done.aspx.cs" Inherits="GUI_admin_ServiceTaxTransferUtility_Done" %>

<asp:content id="Content1" runat="server" contentplaceholderid="MyCPH1">
    <table align="left">
        <tr>
            <td height="30"><font class="blklnkund"><strong>Module</strong></font>
                <font class="bluefnt"><strong>&gt; </strong><strong>Service Tax Transfer Utility Result</strong> </font></td>
        </tr>
        <tr>
            <td>
                <table class="boxbg" border="0" cellpadding="3" cellspacing="1" width="500px">
                    <tr class="bgbluegrey blackboldfnt" align="center">
                        <td colspan="17">Service Tax Transfer Utility Result
                        </td>
                    </tr>
                    <tr class="bgwhite">
                        <td><font class="blackfnt">
                            <asp:Label runat="server" ID="lblResult" ></asp:Label></font>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:content>
