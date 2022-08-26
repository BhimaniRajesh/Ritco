<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Cost_Summary_Rpt.aspx.cs" Inherits="GUI_Telecomm_Cost_Summary_Rpt" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=10.2.3600.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <br />
    <a href="javascript:window.history.go(-1)" title="back">
        <img id="Img2" align="right" alt="" border="0" src="../../GUI/images/back.gif" /></a>
    <asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="True" NavigateUrl="~/GUI/Telecomm/Home.aspx">Report</asp:HyperLink>
    &gt;
    <asp:HyperLink ID="HyperLink2" runat="server" Font-Underline="True" NavigateUrl="~/GUI/Telecomm/ReportMain.aspx">Report Type</asp:HyperLink>
    &gt;
    <asp:HyperLink ID="HyperLink3" runat="server" Font-Underline="True" NavigateUrl="~/GUI/Telecomm/rptCommExeRegister.aspx">Communication Cost Summary Report</asp:HyperLink>
    &gt;
    <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="Communication Cost Summary Result"></asp:Label><br />
    <br />
    <CR:CrystalReportViewer ID="CRVCostSummary" runat="server" AutoDataBind="true" HasCrystalLogo="False" />
    <br />
    <table id="TABLE2" align="center" border="0" cellpadding="3" cellspacing="1" class="boxbg"
        style="background-color: #808080">
        <tr style="background-color: #ffffff">
            <td align="left" style="width: 211px; height: 10px">
                <label class="blackfnt">
                    Location</label></td>
            <td align="left" style="height: 10px">
                <asp:Label ID="lblLocation" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td align="left" style="width: 211px; height: 15px">
                <label class="blackfnt">
                    User</label></td>
            <td align="left" style="width: 343px; height: 15px">
                <asp:Label ID="lblUser" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td align="left" style="width: 211px">
                <label class="blackfnt">
                    Vendor</label></td>
            <td align="left" style="width: 343px">
                <asp:Label ID="lblVendor" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td align="left" class="blackfnt" style="width: 211px">
                Communication Device Type</td>
            <td align="left" style="width: 343px">
                <asp:Label ID="lblDevice" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td align="left" class="blackfnt" style="width: 211px">
                Number</td>
            <td align="left" style="width: 343px">
                <asp:Label ID="lblNumber" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td align="left" class="blackfnt" style="width: 211px">
                Year</td>
            <td align="left" style="width: 343px">
                <asp:Label ID="lblYear" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td align="left" class="blackfnt" style="width: 211px">
                Months</td>
            <td align="left" style="width: 343px">
                <asp:Label ID="lblMonths" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
    </table>
    <br />
    <br />
    <center>
    <asp:Table ID="Table1" runat="server" CellPadding="1" CellSpacing="0" CssClass="boxbg"
        Width="40%">
    </asp:Table></center>
</asp:Content>
