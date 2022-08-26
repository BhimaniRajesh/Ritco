<%@ Page Language="C#"  MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Result_ADV_TR.aspx.cs" Inherits="GUI_UNI_NET_MIS_Account_Reports_GL_TB_Result_ADV_TR" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <div align="left" style="width:100%">
        <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
               <td height="30">
                    <font class="bluefnt"><strong><u>&gt;&gt;&gt;  Advance Trail Balance</u> </strong></font>
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
                     <div align="center">
                    <asp:UpdateProgress ID="uppMain" runat="server">
                        <ProgressTemplate>
                            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                                -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                                <tr>
                                    <td align="right">
                                        <img id="Img1" src="../../../images/loading.gif"  runat="server" />
                                    </td>
                                    <td>
                                        <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                                    </td>
                                </tr>
                            </table>
                            <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
                                background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
                                opacity: .50; -moz-opacity: .50;" runat="server">
                                <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                                    left: 50%;" ID="Panel2" runat="server">
                                </asp:Panel>
                            </asp:Panel>
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
                           <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
<rsweb:ReportViewer ExportContentDisposition="AlwaysAttachment" ID="ReportViewer1"
                                runat="server" Font-Names="Verdana" CssClass="blackfnt" Height="600px"  ShowBackButton="true"
                                ShowPrintButton="true" ShowPromptAreaButton="true" ToolBarItemHoverBackColor="Aqua"
                                ToolBarItemPressedHoverBackColor="BlueViolet" ProcessingMode="Remote" Width="100%">
                                <ServerReport DisplayName="Advance Trial Balance" ReportPath="/Reports/ADV_TR_Balance"></ServerReport>
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
