<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Result1.aspx.cs" Inherits="GUI_UNI_Net_MIS_BIll_MR_Register_ver1_Result1" %>

<!DOCTYPE html>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
<asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true" AsyncPostBackTimeout="600"></asp:ScriptManager>
   
<rsweb:ReportViewer ExportContentDisposition="AlwaysAttachment" ID="ReportViewer1"
                    runat="server" Font-Names="Verdana" CssClass="blackfnt" Height="600px" ShowBackButton="true"
                    ShowPromptAreaButton="true" ToolBarItemHoverBackColor="Aqua" ToolBarItemPressedHoverBackColor="BlueViolet"
                    ProcessingMode="Remote" Width="100%">
                </rsweb:ReportViewer>
    </div>
    </form>
</body>
</html>
