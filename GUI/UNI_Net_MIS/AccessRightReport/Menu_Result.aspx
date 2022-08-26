<%@ Page Language="C#"  AutoEventWireup="true" CodeFile="Menu_Result.aspx.cs" Inherits="GUI_UNI_Net_MIS_AccessRightReport_Result" Title="Untitled Page" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
	
	<meta http-equiv="X-UA-Compatible" content="IE=edge" >
    <meta http-equiv="X-UA-Compatible" content="IE=Emulate11" >
    <title></title>
	
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
            
<rsweb:ReportViewer ID="rvDocuments" runat="server" Font-Names="Verdana" Font-Size="8pt" Height="500px"
                ShowParameterPrompts="false" ShowPageNavigationControls="true" ShowBackButton="true" ProcessingMode="Remote" Width="100%">
                <ServerReport ReportPath="/Report Project1/AccessRightsReport"></ServerReport>
            </rsweb:ReportViewer>
        </div>
    </form>
</body>
</html>



