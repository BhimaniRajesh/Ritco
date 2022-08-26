<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Result.aspx.cs" Inherits="GUI_UNI_Net_MIS_Sales_EXP_Register_Result" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register TagName="LnkRPT" TagPrefix="LinkedReport" Src="~/GUI/Common_UserControls/LinkedReport.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div align="left">
        <LinkedReport:LnkRPT ID="LnkRPT1" runat="server" />
       <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
<rsweb:ReportViewer ExportContentDisposition="AlwaysAttachment" ID="ReportViewer1"
            runat="server" Font-Names="Verdana" CssClass="blackfnt" ShowFindControls="false"
            Height="600px" ShowParameterPrompts="true" ShowBackButton="false" ShowPromptAreaButton="true"
            ToolBarItemHoverBackColor="Aqua" ToolBarItemPressedHoverBackColor="BlueViolet"
            ProcessingMode="Remote" Width="100%">
            <ServerReport DisplayName="Sales Register"></ServerReport>
        </rsweb:ReportViewer>
    </div>
    </form>
</body>
</html>
