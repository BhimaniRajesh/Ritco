<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EmpDetails.aspx.cs" Inherits="GUI_Fleet_Reports_LogSheetRegister" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Employee Details</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Fleet</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Reports </strong></font><strong>&gt; </strong><font class="bluefnt">
                            <strong>Employee Details</strong></font>&nbsp;
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="../../../images/clear.gif" width="2" height="1">
                </td>
            </tr>
            <tr>
                <td>
                    <img src="../../../images/clear.gif" width="15" height="10">
                </td>
            </tr>
        </table>
        <br />
        <br />
        <br />
       <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
<rsweb:ReportViewer ID="rvDocuments" runat="server" Font-Names="Verdana" Font-Size="8pt"
            Height="500px" ShowParameterPrompts="false" ShowPageNavigationControls="false"
            ShowBackButton="false" ShowCredentialPrompts="false" ShowDocumentMapButton="false"
            ShowExportControls="false" ShowFindControls="false" ShowPrintButton="false" ShowZoomControl="false"
            ShowToolBar="false" ProcessingMode="Remote" Width="700px">
            <ServerReport ReportPath="/Report Project1/JobsheetRegister"></ServerReport>
        </rsweb:ReportViewer>
    </div>
    </form>
</body>
</html>
