<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Result.aspx.cs" Inherits="GUI_UNI_Net_MIS_Voucher_register_Query" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <script type="text/javascript" language="javascript">

        // Script Source: CodeLifter.com
        // Copyright 2003
        // Do not remove this notice.

        // SETUPS:
        // ===============================

        // Set the horizontal and vertical position for the popup

        PositionX = 100;
        PositionY = 100;

        // Set these value approximately 20 pixels greater than the
        // size of the largest image to be used (needed for Netscape)

        defaultWidth = 500;
        defaultHeight = 500;

        // Set autoclose true to have the window close automatically
        // Set autoclose false to allow multiple popup windows

        var AutoClose = true;

        // Do not edit below this line...
        // ================================
        if (parseInt(navigator.appVersion.charAt(0)) >= 4) {
            var isNN = (navigator.appName == "Netscape") ? 1 : 0;
            var isIE = (navigator.appName.indexOf("Microsoft") != -1) ? 1 : 0;
        }
        var optNN = 'scrollbars=no,width=' + defaultWidth + ',height=' + defaultHeight + ',left=' + PositionX + ',top=' + PositionY;
        var optIE = 'scrollbars=no,width=150,height=100,left=' + PositionX + ',top=' + PositionY;
        function popImage(imageURL, imageTitle) {
            if (isNN) { imgWin = window.open('about:blank', '', optNN); }
            if (isIE) { imgWin = window.open('about:blank', '', optIE); }
            with (imgWin.document) {
                writeln('<html><head><title>Loading...</title><style>body{margin:0px;}</style>'); writeln('<sc' + 'ript>');
                writeln('var isNN,isIE;'); writeln('if (parseInt(navigator.appVersion.charAt(0))>=4){');
                writeln('isNN=(navigator.appName=="Netscape")?1:0;'); writeln('isIE=(navigator.appName.indexOf("Microsoft")!=-1)?1:0;}');
                writeln('function reSizeToImage(){'); writeln('if (isIE){'); writeln('window.resizeTo(300,300);');
                writeln('width=300-(document.body.clientWidth-document.images[0].width);');
                writeln('height=300-(document.body.clientHeight-document.images[0].height);');
                writeln('window.resizeTo(width,height);}'); writeln('if (isNN){');
                writeln('window.innerWidth=document.images["George"].width;'); writeln('window.innerHeight=document.images["George"].height;}}');
                writeln('function doTitle(){document.title="' + imageTitle + '";}'); writeln('</sc' + 'ript>');
                if (!AutoClose) writeln('</head><body bgcolor=000000 scroll="no" onload="reSizeToImage();doTitle();self.focus()">')
                else writeln('</head><body bgcolor=000000 scroll="no" onload="reSizeToImage();doTitle();self.focus()" onblur="self.close()">');
                writeln('<img name="George" src=' + imageURL + ' style="display:block"></body></html>');
                close();
            } 
        }

    </script>

</head>
<body>
    <form id="form1" runat="server">
   <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
<rsweb:ReportViewer ExportContentDisposition="AlwaysAttachment" ID="ReportViewer1"
        runat="server" Font-Names="Verdana" CssClass="blackfnt" Height="600px" ShowParameterPrompts="false"
        ShowPrintButton="true" ShowPromptAreaButton="true" ToolBarItemHoverBackColor="Aqua"
        ToolBarItemPressedHoverBackColor="BlueViolet" ProcessingMode="Remote" Width="100%">
        <ServerReport DisplayName="CustomerContractReport" ReportPath="/Reports/GL_Ver1"></ServerReport>
    </rsweb:ReportViewer>
    </form>
</body>
</html>
