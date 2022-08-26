<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VehicleTrackingView.aspx.cs" Inherits="GUI_Fleet_Reports_VehicleTracking_VehicleTrackingView" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Vehicle Tracking</title>
</head>
<body>
    <form id="form1" runat="server">
           <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
<rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" Height="500px"
                ShowParameterPrompts="false" ShowPageNavigationControls="true" ShowBackButton="false" ProcessingMode="Remote" Width="100%">
            </rsweb:ReportViewer>
       
    </form>
</body>
</html>
