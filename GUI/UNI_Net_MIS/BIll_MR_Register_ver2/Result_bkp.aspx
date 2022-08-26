<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Result.aspx.cs" Inherits="GUI_UNI_Net_MIS_BIll_MR_Register_ver1_Result" %>
    
    <%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register TagName="PRB" TagPrefix="PRBAR" Src="~/GUI/Common_UserControls/ProgressBar.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    
            <table style="width:100%;" border="0" align="left" cellpadding="0" cellspacing="0">
                <tr>
                    <td height="30">
                        <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                            class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong><font
                                class="blklnkund"><strong>Finance </strong></font><font class="bluefnt"><strong>&gt;
                                </strong><strong>Invoice/Collection Register </strong></font>
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
                 <tr id="TRRPV" runat="server" style="display: block; height=100%;">
                    <td>
                        <br />
                       
<rsweb:ReportViewer ExportContentDisposition="AlwaysAttachment" ID="ReportViewer1"
                            runat="server" Font-Names="Verdana" CssClass="blackfnt" Height="600px" ShowBackButton="true"
                            ShowPromptAreaButton="true" ToolBarItemHoverBackColor="Aqua" ToolBarItemPressedHoverBackColor="BlueViolet"
                            ProcessingMode="Remote" Width="100%">
                        </rsweb:ReportViewer>
                          </td> </tr>
            </table>
       
</asp:Content>
