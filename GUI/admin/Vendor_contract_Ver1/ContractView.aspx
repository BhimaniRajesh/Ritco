<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ContractView.aspx.cs" Inherits="GUI_admin_Vendor_contract_Ver1_ContractView" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>WebXpress : Vendor Contract </title>
    <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
    <style type="text/css">
        body { font-family: verdana, arial, helvetica, sans-serif;
          font-size: 12px; }
        h1 { font-size:16px }	
        /*a:link { color:#FFFFFF }	
        a:visited { color:#FFFFFF }	*/	
        div#content { margin-left:0px; height:0px }
        /* Style specs for layer that glides.
           Generally, you don't set height, but since layer nearly empty in this example... */
        #glideDiv { 
          position:absolute; 
          right:Auto; top:Auto; z-index:Auto;
          width:175px; height:16px; padding:1px;
          background-color:#FFFFFF/*#dee7f7*/
      }
    </style>
</head>
<body leftmargin="0" topmargin="0">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true">
        </asp:ScriptManager>
        <br />
        <asp:UpdatePanel ID="updtRpt" runat="server">
            <ContentTemplate>
                <rsweb:ReportViewer ID="rvDocuments" runat="server" Font-Names="Verdana" Font-Size="8pt"
                    Height="500px" ShowParameterPrompts="false" ShowPageNavigationControls="true"
                    ProcessingMode="Remote" Width="100%">
                </rsweb:ReportViewer>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>
</html>
