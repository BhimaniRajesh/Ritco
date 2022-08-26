<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintManifest.aspx.cs" Inherits="GUI_Operations_TCS_PrintTCS_PrintManifest" %>
<%@ OutputCache Location="None" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >

    <head id="Head1" runat="server">
        
        <title>
            Print Manifest
        </title>
        
        <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" 
            type="text/css" runat="server" />
        
        <script language="javascript" type="text/javascript">
            
            function printManifest()
            {
                innerHTML = new String(window.opener.document.frmManifest.innerHTML);
		        document.frmPrintMF.innerHTML = innerHTML;
            }
            
        </script>
        
    </head>
    
    <body onload="Javascript:printManifest();window.print();">
        
        <form id="frmPrintMF" runat="server">
                
        </form>
        
    </body>
    
</html>
