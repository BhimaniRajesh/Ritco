<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"  CodeFile="Reports.aspx.cs" Inherits="GUI_HR_Payroll_Reports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">HR & Payroll :- Reports</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" style="width: 6.0in">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <font class="blackfnt"><b>HR & Payroll :- Reports</b> </font>
            </td>
        </tr>
        
    </table>
</asp:Content>
