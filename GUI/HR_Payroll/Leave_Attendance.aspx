<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Leave_Attendance.aspx.cs" Inherits="GUI_HR_Payroll_Leave_Attendance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">HR & Payroll :- Leave Attendance</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" style="width: 6.0in">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <font class="blackfnt"><b>HR & Payroll :- Leave Attendance</b> </font>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle" width="8%">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%">
                <font class="blackfnt">Set Leave Opening Balance</font>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%">
                <font class="blackfnt">Weekly Holiday & Overtime Settings</font>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%">
                <font class="blackfnt">Allot Leave</font>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%">
                <font class="blackfnt">Leave Application</font>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%">
                <font class="blackfnt">Leave Approval</font>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%">
                <font class="blackfnt">Reports</font>
            </td>
        </tr>
    </table>
</asp:Content>
