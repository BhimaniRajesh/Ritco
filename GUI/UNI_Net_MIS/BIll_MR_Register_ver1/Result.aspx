<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Result.aspx.cs" Inherits="GUI_UNI_Net_MIS_BIll_MR_Register_ver1_Result" %>
    
    
    <%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    
            <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
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
                
                 <tr id="TRRPV" runat="server" style="display: block">
                    <td>
                        <br />
                       <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
<rsweb:ReportViewer ExportContentDisposition="AlwaysAttachment" ID="ReportViewer1"
                            runat="server" Font-Names="Verdana" CssClass="blackfnt" Height="600px" ShowBackButton="true"
                            ShowPromptAreaButton="true" ToolBarItemHoverBackColor="Aqua" ToolBarItemPressedHoverBackColor="BlueViolet"
                            ProcessingMode="Remote" Width="100%">
                        </rsweb:ReportViewer>
                          </td> </tr>
            </table>
       
</asp:Content>
