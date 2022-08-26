<%@ Page Language="C#" AutoEventWireup="true" CodeFile="~/GUI/UNI_Net_MIS/PODReports/resultv1.aspx.cs" Inherits="GUI_UNI_Net_MIS_PODReports_ResultRS" %>


	
 <%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
   Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <rsweb:ReportViewer ExportContentDisposition="AlwaysAttachment" ID="ReportViewer1"
                   runat="server" Font-Names="Verdana" CssClass="blackfnt" ShowFindControls="false" 
                   Height="650px" ShowParameterPrompts="false" ShowBackButton="true" ShowPromptAreaButton="true"
                   ToolBarItemHoverBackColor="Aqua" ToolBarItemPressedHoverBackColor="BlueViolet"
                   ProcessingMode="Remote" Width="100%">
                   <ServerReport DisplayName="CN Register" ></ServerReport>                
        </rsweb:ReportViewer>
    </div>
    </form>
</body>
</html>
