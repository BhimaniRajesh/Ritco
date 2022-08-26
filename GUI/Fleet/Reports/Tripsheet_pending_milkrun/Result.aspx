<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Result.aspx.cs" Inherits="GUI_UNI_NET_MIS_Tripsheet_pending_milkrun_Result" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
    <%@ Register TagName="LnkRPT" TagPrefix="LinkedReport" Src="~/GUI/Common_UserControls/LinkedReport.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
 <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
    <title>Tripsheet pending for Trip billing -Legwise (Milkrun)</title>
    <script src="../../../Js/DisableReportFormat.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
     <LinkedReport:LnkRPT ID="LnkRPT1" runat="server" />
    <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
<rsweb:ReportViewer ID="rvvehicle" runat="server" ShowBackButton="true"
        ShowPageNavigationControls="true" ShowParameterPrompts="false" ProcessingMode="Remote"
        ShowPrintButton="true" ShowRefreshButton="true" Width="100%" Height="600px">
    </rsweb:ReportViewer>
    </form>
</body>
</html>
