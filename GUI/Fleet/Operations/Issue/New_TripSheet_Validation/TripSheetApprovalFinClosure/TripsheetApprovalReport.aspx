<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TripsheetApprovalReport.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_New_TripSheet_Validation_TripSheetApprovalFinClosure_TripsheetApprovalReport" %>
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
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <rsweb:ReportViewer ExportContentDisposition="AlwaysAttachment" ID="ReportViewer1"
                   runat="server" Font-Names="Verdana" CssClass="blackfnt" ShowFindControls="false" 
                   Height="650px" ShowParameterPrompts="false" ShowBackButton="true" ShowPromptAreaButton="true"
                   ToolBarItemHoverBackColor="Aqua" ToolBarItemPressedHoverBackColor="BlueViolet"
                   ProcessingMode="Remote" Width="100%">
                   <ServerReport DisplayName="Tripsheet Approval Report" ></ServerReport>                
        </rsweb:ReportViewer>
        </div>
    </form>
</body>
</html>
