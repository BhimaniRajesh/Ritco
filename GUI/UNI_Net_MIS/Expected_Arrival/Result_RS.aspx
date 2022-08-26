<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPageReport.master" AutoEventWireup="true" CodeFile="Result_RS.aspx.cs" Inherits="GUI_UNI_NET_MIS_Expected_Arrival_Result_RS" %>

<%@ Register TagName="PRB" TagPrefix="PRBAR" Src="~/GUI/Common_UserControls/ProgressBar.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:UpdatePanel ID="upTHCCreate"  UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>
            <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
                <tr>
                    <td height="30">
                        <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                            class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong><font
                                class="blklnkund"><strong>Operation </strong></font><font class="bluefnt"><strong>&gt;
                                </strong><strong>Expected Arrival Report </strong></font>
                    </td>
                </tr>
                <tr>
                    <td class="horzblue">
                        <img src="./../../images/clear.gif" width="2" height="1" /></td>
                </tr>
                <tr>
                    <td align="right">
                        <prbar:prb id="PB" runat="server" />
                        <a href="javascript:window.history.go(-1)" title="back">
                            <img alt="Back" src="./../../images/back.gif" border="0" />
                        </a>
                    </td>
                </tr>
                 <tr id="TRRPV" runat="server" style="display: block">
                    <td>
                        <br />
                       
<rsweb:ReportViewer ExportContentDisposition="AlwaysAttachment" ID="ReportViewer1"
                            runat="server" Font-Names="Verdana" CssClass="blackfnt" Height="600px" ShowBackButton="true"
                            ShowPromptAreaButton="true" ToolBarItemHoverBackColor="Aqua" ToolBarItemPressedHoverBackColor="BlueViolet"
                            ProcessingMode="Remote" Width="100%">
                        </rsweb:ReportViewer>
                          </td> </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
