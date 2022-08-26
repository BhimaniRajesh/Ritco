<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Result.aspx.cs" Inherits="GUI_UNI_Net_MIS_DKT_Profi_Result" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%--<%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagName="ProgressBar" TagPrefix="uc1" %>--%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=egde" />
    <title>Sales Profitability</title>

</head>
<body>
    <form id="form1" runat="server">
    <div>
       <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
<rsweb:ReportViewer ShowBackButton="true" ExportContentDisposition="AlwaysAttachment" ID="ReportViewer1"
            runat="server" Font-Names="Verdana" CssClass="blackfnt" Height="600px"
            ShowPromptAreaButton="true" ToolBarItemHoverBackColor="Aqua" ToolBarItemPressedHoverBackColor="BlueViolet"
            ProcessingMode="Remote" Width="100%">
            <ServerReport DisplayName="DKT_Prof" ReportPath="/Reports/DKT_Prof"></ServerReport>
        </rsweb:ReportViewer>
    </div>
    </form>
</body>
</html>
