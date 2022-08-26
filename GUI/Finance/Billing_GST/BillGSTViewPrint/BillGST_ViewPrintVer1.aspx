<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BillGST_ViewPrintVer1.aspx.cs" Inherits="GUI_Finance_Billing_GST_BillGSTViewPrint_BillGST_ViewPrintVer1" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.9.1/themes/base/jquery-ui.css" />
    <script src="http://code.jquery.com/jquery-1.8.2.js"></script>
    <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>
    <link href="../../../Images/SSRSReportPrint.css" rel="stylesheet" />
    <script src="../../../Js/SSRSReportPrint.js" type="text/javascript"></script>--%>
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
         <%--//<script type="text/javascript">
         //    showPrintButton(document.getElementById("rvBillGSTViewPrint"));
    //</script>--%>
    </form>
</body>
</html>
