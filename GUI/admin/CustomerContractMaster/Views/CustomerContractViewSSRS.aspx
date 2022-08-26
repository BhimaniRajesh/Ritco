<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="CustomerContractViewSSRS.aspx.cs"
    Inherits="GUI_UNI_Net_MIS_CustomerContractViewSSRS" %>
    
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register TagName="PRB" TagPrefix="PRBAR" Src="~/GUI/Common_UserControls/ProgressBar.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Customer Contract View</title>
</head>
<body onload="javascript:return printPage()">
    <form id="form1" runat="server">
    <br />
     <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true">
        </asp:ScriptManager>
    <asp:UpdatePanel ID="upTHCCreate"  UpdateMode="Conditional" runat="server">
        <ContentTemplate>
            <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
                <tr id="TRRPV" runat="server" style="display: block">
                    <td>
                        <br />
                        <rsweb:ReportViewer ExportContentDisposition="AlwaysAttachment" ID="ReportViewer1"
                            runat="server" Font-Names="Verdana" CssClass="blackfnt" Height="600px" ShowBackButton="true"
                            ShowPromptAreaButton="true" ToolBarItemHoverBackColor="Aqua" ToolBarItemPressedHoverBackColor="BlueViolet"
                            ProcessingMode="Remote" Width="100%" ShowParameterPrompts="False">
                        </rsweb:ReportViewer>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    </form>
</body>
</html>
