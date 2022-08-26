<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Secondary_Contract_View.aspx.cs" Inherits="GUI_Fleet_Reports_TripSheet" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Secondary Contract</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:UpdateProgress ID="uppMain" runat="server">
            <ProgressTemplate>
                <iframe frameborder="0" src="about:blank" style="border: 0px; position: absolute;
                    z-index: 9; left: 0px; top: 0px; width: expression(this.offsetParent.scrollWidth);
                    height: expression(this.offsetParent.scrollHeight); filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);">
                </iframe>
                <div style="position: absolute; z-index: 10; left: expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);
                    top: expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
                    <img src="../../images/loading.gif" /><font face="verdana" color="blue" size="4">&nbsp;<b>Please
                        Wait...</b></font>
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
        <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Fleet</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>View/Print</strong></font><strong>&gt; </strong><font class="bluefnt">
                            <strong>Secondary Contract</strong></font>&nbsp;
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="../../images/clear.gif" width="2" height="1">
                </td>
            </tr>
            <tr>
                <td>
                    <img src="../../images/clear.gif" width="15" height="10">
                </td>
            </tr>
        </table>
        <br />
        <br />
        <br />
        <asp:UpdatePanel ID="updtRpt" runat="server">
            <ContentTemplate>
                <rsweb:reportviewer id="ReportViewer1" runat="server" font-names="Verdana" font-size="8pt"
                    height="500px" showparameterprompts="false" showpagenavigationcontrols="true"
                    showbackbutton="true" processingmode="Remote" width="975px">
            </rsweb:reportviewer>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    </form>
</body>
</html>
