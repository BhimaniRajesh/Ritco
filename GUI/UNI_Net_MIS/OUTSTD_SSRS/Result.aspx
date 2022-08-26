<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Result.aspx.cs" Inherits="GUI_UNI_NET_MIS_OUTSTD_SSRS_Result" ValidateRequest="false" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Account Receivable Report</title>
</head>
<body>
    <form id="form1" runat="server">
        <table width="100%">
            <div>
                <tr>
                    <td>
                        <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true" AsyncPostBackTimeout="600"></asp:ScriptManager>
                        <rsweb:ReportViewer ExportContentDisposition="AlwaysAttachment" ID="ReportViewer1"
                            runat="server" Font-Names="Verdana" CssClass="blackfnt" Height="600px" ShowBackButton="true"
                            ShowPromptAreaButton="true" ToolBarItemHoverBackColor="Aqua" ToolBarItemPressedHoverBackColor="BlueViolet"
                            ProcessingMode="Remote" Width="100%">
                        </rsweb:ReportViewer>
                    </td>
                </tr>
            </div>
        </table>
    </form>
</body>
</html>

