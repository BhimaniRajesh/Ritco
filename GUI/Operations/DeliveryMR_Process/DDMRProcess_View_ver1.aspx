<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DDMRProcess_View_ver1.aspx.cs" Inherits="GUI_Operations_DeliveryMR_Process_DDMRProcess_View_ver1" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
<rsweb:ReportViewer ExportContentDisposition="AlwaysAttachment" ID="ReportViewer1"
                                runat="server" Font-Names="Verdana" CssClass="blackfnt" ShowFindControls="false"  
                                Height="600px" ShowParameterPrompts="true" ShowBackButton="false" ShowPromptAreaButton="true"
                                ToolBarItemHoverBackColor="Aqua" ToolBarItemPressedHoverBackColor="BlueViolet"
                                ProcessingMode="Remote" Width="100%">
                                <ServerReport DisplayName="DDMR Process View" >
                                </ServerReport>
                            </rsweb:ReportViewer>
    </div>
    </form>
</body>
</html>
