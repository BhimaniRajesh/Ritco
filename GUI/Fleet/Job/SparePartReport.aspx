<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SparePartReport.aspx.cs" Inherits="GUI_Fleet_Job_SparePartReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
<rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" Height="500px"
                ShowParameterPrompts="false" ShowPageNavigationControls="true" ShowBackButton="true" ProcessingMode="Remote" Width="100%" ToolBarItemPressedHoverBackColor="221, 238, 247">
    </rsweb:ReportViewer>
    </div>
    </form>
   
</body>
</html>
