<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Result.aspx.cs" Inherits="GUI_UNI_Net_MIS_BIll_MR_Register_ver2_Result" %>

    <%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register TagName="PRB" TagPrefix="PRBAR" Src="~/GUI/Common_UserControls/ProgressBar.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<%--<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />--%>
    <meta http-equiv="X-UA-Compatible" content="IE=egde" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <table style="width:100%;" border="0" align="left" cellpadding="0" cellspacing="0">
                <tr>
                    <td height="30">
                        <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                            class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong><font
                                class="blklnkund"><strong>Finance </strong></font><font class="bluefnt"><strong>&gt;
                                </strong><strong>Invoice/Collection Register </strong></font>
                    </td>
                </tr>
                <tr>
                    <td class="horzblue">
                        <img src="./../../images/clear.gif" width="2" height="1" /></td>
                </tr>
                <tr>
                    <td align="right">
                        <prbar:prb id="PB" runat="server" />
                        <a href="javascript:window.history.go(-1)" title="back">
                            <img alt="Back" src="./../../images/back.gif" border="0" />
                        </a>
                    </td>
                </tr>
                 <tr id="TRRPV" runat="server" style="display: block; height=100%;">
                    <td>
                        <br />
                       <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
                            <rsweb:ReportViewer ExportContentDisposition="AlwaysAttachment" ID="ReportViewer1"
                            runat="server" Font-Names="Verdana" CssClass="blackfnt" Height="600px" ShowBackButton="true"
                            ShowPromptAreaButton="true" ToolBarItemHoverBackColor="Aqua" ToolBarItemPressedHoverBackColor="BlueViolet"
                            ProcessingMode="Remote" Width="100%">
                        </rsweb:ReportViewer>
                          </td> </tr>
            </table>
    </div>
    </form>
</body>
</html>
