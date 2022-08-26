<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Result_TBRS.aspx.cs" Inherits="GUI_UNI_NET_MIS_Account_Reports_GL_TB_Result_TBRS" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <div align="left">
        <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Reports </strong></font><font class="bluefnt"><strong>&gt;
                        </strong><strong>Trial Balance</strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="../../../images/clear.gif" width="2" height="1" alt="" /></td>
            </tr>
            <tr>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img alt="Back" src="../../../images/back.gif" border="0" alt="" />
                    </a>
                    <div align="Left">
                        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true"></asp:Label>
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                </div>
                                <br />
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
                </td>
            </tr>
            <tr>
                <td height="300" valign="top">
                    <br />
                    <asp:UpdatePanel ID="UP" runat="server">
                        <ContentTemplate>
                           
<rsweb:ReportViewer ExportContentDisposition="AlwaysAttachment" ID="ReportViewer1"
                                runat="server" Font-Names="Verdana" CssClass="blackfnt" Height="600px" ShowParameterPrompts="false"
                                ShowPrintButton="true" ShowPromptAreaButton="true" ToolBarItemHoverBackColor="Aqua"
                                ToolBarItemPressedHoverBackColor="BlueViolet" ProcessingMode="Remote" Width="100%">
                                <ServerReport DisplayName="Trial Balance"></ServerReport>
                            </rsweb:ReportViewer>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <br />
                    <br />
                </td>
            </tr>
            <tr>
                <td height="30" valign="top">
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
