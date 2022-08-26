<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Result.aspx.cs" Inherits="GUI_Fleet_Reports_DriverWiseVehicleUsage_Result" Title="Untitled Page" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<table cellspacing="1" cellpadding="2" style="width: 100%">
    <tr >
        <td colspan="3" align="right" style="vertical-align: middle; width: 30%; text-align: right; height: 60px;">
            <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/GUI/images/back.gif" OnClick="ImageButton1_Click" />
                    </ContentTemplate>
                </asp:UpdatePanel>  
        </td>
    </tr>
   </table>
   <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Fleet</strong></font> <strong>&gt; </strong>
                <font class="blklnkund"><strong>Reports </strong></font><strong>&gt; </strong>
                <font class="bluefnt"><strong>Driver Wise Vehicle Usage</strong></font>&nbsp;</td>
        </tr>
        <tr>
            <td class="horzblue">
                <img src="../../../images/clear.gif" width="2" height="1"></td>
        </tr>
        <tr>
            <td>
                <img src="../../../images/clear.gif" width="15" height="10"></td>
        </tr>
    </table>   
    <br />
    <br />
    <br />
   
   <table cellspacing="1" style="width: 100%" align="center">
        <tr style="background-color: white">
            <td colspan="3" align="center" style="vertical-align: top; text-align: left">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                       <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
<rsweb:reportviewer id="ReportViewer1" runat="server" ShowBackButton="true"
                        processingmode="Remote" Height="1200px" Width="1000px" SizeToReportContent="True">
                        </rsweb:reportviewer>
                    </ContentTemplate>
                </asp:UpdatePanel>
               
               
            </td>
        </tr>
    </table>
    
</asp:Content>

