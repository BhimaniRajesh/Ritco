<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Result.aspx.cs" Inherits="GUI_Fleet_Reports_TyrePerKMCost_Result" Title="Untitled Page" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Tyre Per KM Cost</title>

    <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />

</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table width="100%">
            <tr>
                <td>
                   <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
<rsweb:ReportViewer ExportContentDisposition="AlwaysAttachment" ID="rvTyrePerKMCost"
                        SizeToReportContent="true" runat="server" Font-Names="Verdana" CssClass="blackfnt"
                        Height="480px" ShowBackButton="true" ShowPromptAreaButton="true" ToolBarItemHoverBackColor="Aqua"
                        ToolBarItemPressedHoverBackColor="BlueViolet" ProcessingMode="Remote" Width="1100px">
                    </rsweb:ReportViewer>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
