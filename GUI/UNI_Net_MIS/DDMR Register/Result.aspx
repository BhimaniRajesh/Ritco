<%@ Page Language="C#"  AutoEventWireup="true" CodeFile="Result.aspx.cs" Inherits="GUI_UNI_Net_MIS_MarketVehicle_Result" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">

    <title></title>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.9.1/themes/base/jquery-ui.css" />
    <script src="http://code.jquery.com/jquery-1.8.2.js"></script>
    <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>
    <link href="../../styles/SSRSReportPrint.css" rel="stylesheet" />
    <script src="../../Js/SSRSReportPrint.js" type="text/javascript"></script>    

</head>
<body>
    <form id="form1" runat="server">
 <div class="pdf">
    </div>

    <div>

     <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
<rsweb:ReportViewer ExportContentDisposition="AlwaysAttachment" ID="ReportViewer1"
                                runat="server" Font-Names="Verdana" CssClass="blackfnt" ShowFindControls="false"  
                                Height="600px" ShowParameterPrompts="true" ShowBackButton="false" ShowPromptAreaButton="true"
                                ToolBarItemHoverBackColor="Aqua" ToolBarItemPressedHoverBackColor="BlueViolet"
                                ProcessingMode="Remote" Width="100%">
                                <ServerReport DisplayName="Branch Local Cost Report" >
                                </ServerReport>
                            </rsweb:ReportViewer>
    </div>
 <div align="center">
            <%--<input id="PrintButton" title="Print" style="width: 16px; height: 16px;" type="image" alt="Print" src="../../Reserved.ReportViewerWebControl.axd?OpType=Resource&Version=11.0.3442.2&Name=Microsoft.Reporting.WebForms.Icons.Print.gif" />--%>
        </div>
    </form>
<script type="text/javascript">
        showPrintButton(document.getElementById("ReportViewer1"));
    </script>
</body>
</html>
