<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Result.aspx.cs" Inherits="GUI_Fleet_Reports_JobRegister_JobTaskNotDone_Result" Title="Untitled Page" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <iframe frameborder="0" src="about:blank" style="border: 0px; position: absolute;
                z-index: 9; left: 0px; top: 0px; width: expression(this.offsetParent.scrollWidth);
                height: expression(this.offsetParent.scrollHeight); filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);">
            </iframe>
            <div style="position: absolute; z-index: 10; left: expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);
                top: expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
                <img src="../../images/loading.gif" /><font face="verdana" color="blue" size="4">&nbsp;<b>Please
                    Wait...</b></font></div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Fleet</strong></font> <strong>&gt; </strong>
                <font class="blklnkund"><strong>Reports </strong></font><strong>&gt; </strong>
                <font class="bluefnt"><strong>Job Task Not Done Register Report</strong></font>&nbsp;</td>
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
    <asp:UpdatePanel ID="updtRpt" runat="server">
        <ContentTemplate>
           <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
<rsweb:ReportViewer ID="rvDocuments" runat="server" Font-Names="Verdana" Font-Size="8pt" Height="500px"
                ShowParameterPrompts="true" ShowPageNavigationControls="true" ShowBackButton="true" ProcessingMode="Remote" Width="100%">
                <ServerReport ReportPath="/Fleet_Reports/Job_Task_Not_Done"></ServerReport>
            </rsweb:ReportViewer>
        </ContentTemplate>
    </asp:UpdatePanel>   

</asp:Content>

