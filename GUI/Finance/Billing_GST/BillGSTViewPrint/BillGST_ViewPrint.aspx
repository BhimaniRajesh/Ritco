<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BillGST_ViewPrint.aspx.cs" Inherits="GUI_Finance_Billing_GST_BillGSTViewPrint_BillGST_ViewPrint" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <rsweb:ReportViewer ID="rvBillGSTViewPrint" ExportContentDisposition="AlwaysAttachment"  AsyncRendering="True"  
            runat="server" Font-Names="Verdana" CssClass="blackfnt" ShowFindControls="false"  ShowPageNavigationControls="true"
            Height="800px" ShowParameterPrompts="false" ShowBackButton="false" ShowPromptAreaButton="true"
            ToolBarItemHoverBackColor="Aqua" ToolBarItemPressedHoverBackColor="BlueViolet"
            ProcessingMode="Remote" Width="100%">
            <ServerReport DisplayName="GST Bill View"></ServerReport>
        </rsweb:ReportViewer>
    </div>
        <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true">
    </asp:ScriptManager>
    </form>
</body>
</html>
