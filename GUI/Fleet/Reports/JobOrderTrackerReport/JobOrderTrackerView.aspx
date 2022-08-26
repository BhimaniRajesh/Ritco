<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JobOrderTrackerView.aspx.cs" Inherits="GUI_Fleet_Reports_JobOrderTrackerReport_JobOrderTrackerView" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Job Order Tracker Report</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
       <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
<rsweb:ReportViewer ExportContentDisposition="AlwaysAttachment" ID="RPVJobOrderTracker"
            runat="server" Font-Names="Verdana" CssClass="blackfnt" Height="600px" ShowParameterPrompts="false"
            ShowBackButton="true" ShowPromptAreaButton="true" ToolBarItemHoverBackColor="Aqua"
            ShowDocumentMapButton="true" ToolBarItemPressedHoverBackColor="BlueViolet" ProcessingMode="Remote"
            Width="100%">
        </rsweb:ReportViewer>
    </div>
    </form>
</body>
</html>
