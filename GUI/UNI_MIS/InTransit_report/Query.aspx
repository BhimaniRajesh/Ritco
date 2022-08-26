<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Query.aspx.cs" Inherits="GUI_UNI_MIS_InTransit_report_Query" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

    
        &nbsp;<br />
    &nbsp;<a href="javascript:window.history.go(-1)" title="back">
        <img id="IMG1" align="right" alt="" border="0" src="../../../GUI/images/back.gif" /></a><asp:HyperLink
            ID="HyperLink1" runat="server" Font-Underline="True" NavigateUrl="~/GUI/UNI_MIS/rpt_operation.aspx">Operations</asp:HyperLink>
    &gt;
    <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="In Transit Report"></asp:Label><br />
    <center>
        &nbsp;</center>
    <center>
    <asp:UpdatePanel ID="UPShowBrands" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
        <ContentTemplate>
            <center>
                <table cellspacing="1" style="width: 100%">
                    <tr align="center">
                        <td style="height: 172px">
                            <table cellspacing="1" class="boxbg" style="width: 70%">
                                <tr class="bgbluegrey">
                                    <td align="center" colspan="4">
                                        <asp:Label ID="lblQry" runat="server" CssClass="blackfnt" Font-Bold="True">Search In Transit Criteria</asp:Label></td>
                                </tr>
                                <tr class="bgbluegrey">
                                    <td align="center" colspan="2">
                                        <asp:Label ID="lblFrom" runat="server" CssClass="blackfnt" Text="From"></asp:Label></td>
                                    <td align="center" colspan="2">
                                        <asp:Label ID="lblTo" runat="server" CssClass="blackfnt" Text="To"></asp:Label></td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left" style="width: 146px">
                                        <asp:Label ID="lblSelRO" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Select RO"></asp:Label></td>
                                    <td align="left">
                                        <asp:DropDownList ID="cboSelRo" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cboSelRo_SelectedIndexChanged"
                                            ValidationGroup="VGDtFromTo">
                                        </asp:DropDownList></td>
                                    <td align="left" colspan="1">
                                        <asp:Label ID="lblNextRo" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Select RO"
                                            Width="73px"></asp:Label></td>
                                    <td align="left" colspan="1">
                                        <asp:DropDownList ID="cboNextRo" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cboNextRo_SelectedIndexChanged"
                                            ValidationGroup="VGDtFromTo">
                                        </asp:DropDownList></td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left" style="width: 146px; height: 24px;">
                                        <asp:Label ID="lblSelLoc" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Select Last Location" Width="154px"></asp:Label>
                                    </td>
                                    <td align="left" style="height: 24px">
                                        <asp:DropDownList ID="cboSelLoc" runat="server">
                                        </asp:DropDownList></td>
                                    <td align="left" colspan="1" style="height: 24px">
                                        <asp:Label ID="lblNextLoc" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Select Next Location"
                                            Width="142px"></asp:Label></td>
                                    <td align="left" colspan="1" style="height: 24px">
                                        <asp:DropDownList ID="cboNextLoc" runat="server">
                                        </asp:DropDownList></td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="center" colspan="5">
                                        <asp:RadioButton ID="rbtFixRpt" runat="server" CssClass="blackfnt" Font-Bold="True"
                                            Text="Fixed Report" AutoPostBack="true" OnCheckedChanged="rbtFixRpt_CheckedChanged" />
                                        <asp:RadioButton ID="rbtDiff" runat="server" CssClass="blackfnt" Font-Bold="True"
                                            Text="Diff Days : -" AutoPostBack="true" OnCheckedChanged="rbtDiff_CheckedChanged" />
                                        <asp:TextBox ID="txtDateDiff1" runat="server" Width="57px">0</asp:TextBox>
                                        <asp:Label ID="lblTo1" runat="server" Text="To" CssClass="blackfnt" Font-Bold="True"></asp:Label>&nbsp;
                                        <asp:TextBox ID="txtDateDiff2" runat="server" Width="57px">20</asp:TextBox>&nbsp;</td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="right" colspan="5">
                                        <asp:Button ID="btnShowTransit" runat="server" OnClick="btnShowTransit_OnClick"
                                            Text="Show In Transit (s) >>" /></td>
                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                                        ShowSummary="False" />
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                &nbsp;&nbsp;</center>
        </ContentTemplate>
    </asp:UpdatePanel>
    </center>
</asp:Content>
