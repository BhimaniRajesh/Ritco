<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdvanceTHCView.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_PaymentAgainstBillEntry_PendingTHCAdvanceCheque_AdvanceTHCView" %>
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
      <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
<rsweb:ReportViewer ExportContentDisposition="AlwaysAttachment" ID="ReportViewer1"
                                runat="server" Font-Names="Verdana" CssClass="blackfnt" ShowFindControls="false"  
                                Height="600px" ShowParameterPrompts="true" ShowBackButton="false" ShowPromptAreaButton="true"
                                ToolBarItemHoverBackColor="Aqua" ToolBarItemPressedHoverBackColor="BlueViolet"
                                ProcessingMode="Remote" Width="100%">
             <ServerReport DisplayName="Market Vehicle" >
             </ServerReport>
       </rsweb:ReportViewer>
    </div>
    </form>
</body>
</html>
