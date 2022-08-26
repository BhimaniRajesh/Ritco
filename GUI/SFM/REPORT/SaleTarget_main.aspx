<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="SaleTarget_main.aspx.cs" Inherits="REPORT_SaleTarget_main" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Company Structure</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br />
    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="40%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <font class="blackfnt"><b>Sale Target Report</b> </font>
            </td>
        </tr>

        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="80%">
                <asp:LinkButton ID="LinkButton3" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Company Wise Report" PostBackUrl="SaleTarget_Companywise1.aspx" />
            </td>
        </tr>

        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="80%">
                <asp:LinkButton ID="LinkButton4" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Sales Person Wise Report" PostBackUrl="SaleTargetEmployeewise1.aspx" />
            </td>
        </tr>

    </table>
</asp:Content>
