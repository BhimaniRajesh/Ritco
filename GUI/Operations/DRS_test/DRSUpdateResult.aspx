<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="DRSUpdateResult.aspx.cs" Inherits="GUI_Operations_DRS_DRSUpdateResult" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

            <table cellspacing="1" style="width: 900px">
                <tr style="background-color: white">
                    <td align="left" style="width: 50%">
                        <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Update DRS Result:</asp:Label>
                        <hr align="center" size="1" color="#8ba0e5">
                    </td>
                    <td align="left">
                        <font class="blackfnt">&nbsp;</font>
                    </td>
                </tr>
            </table>
            <br />

            <table cellspacing="1" cellpadding="3" class="boxbg" width="1000px" border="0">
                <tr class="bgbluegrey">
                    <td align="left">
                        <font class="blackfnt"><b>DRS #</b></font>
                    </td>
                    <td align="left">
                        <font class="blackfnt"><b>DRS Date</b></font>
                    </td>
                    <td align="left">
                        <font class="blackfnt"><b>Delivered By</b></font>
                    </td>
                    <td align="left">
                        <font class="blackfnt"><b>Driver Name</b></font>
                    </td>
                    <td align="left">
                        <font class="blackfnt"><b>Vehicle #</b></font>
                    </td>
                    <td align="center">
                        <font class="blackfnt"><b>Start/Close (Kms)</b></font>
                    </td>
                    <td align="center">
                        <font class="blackfnt"><b>Total Dockets in DRS</b></font>
                    </td>
                    <td align="center">
                        <font class="blackfnt"><b>Updated</b></font>
                    </td>
                </tr>
                <tr style="background-color:White">
                    <td align="left">
                        <font class="blackfnt"><%= DRSCode%></font>
                    </td>
                    <td align="left">
                        <font class="blackfnt"><%= drsDate%></font>
                    </td>
                    <td align="left">
                        <font class="blackfnt"><%= deliveredBy + "[" + ba_staff + "]"%></font>
                    </td>
                    <td align="left">
                        <font class="blackfnt"><%= driverName%></font>
                    </td>
                    <td align="left">
                        <font class="blackfnt"><%= vehicleno%></font>
                    </td>
                    <td align="center">
                        <font class="blackfnt"><%= startKM + " / " + closeKM%></font>
                    </td>
                    <td align="center">
                        <font class="blackfnt"><%= totalDkts%></font>
                    </td>
                    <td align="center">
                        <font class="blackfnt"><%= Updated%></font>
                    </td>
                </tr>
            </table>

</asp:Content>

