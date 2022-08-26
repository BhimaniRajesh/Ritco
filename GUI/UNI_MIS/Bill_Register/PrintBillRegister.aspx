<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintBillRegister.aspx.cs" Inherits="GUI_Operations_TCS_PrintTCS_PrintLoadingSheet" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >

    <head runat="server">
        
        <title>
            Print Loading Sheet
        </title>
        
        <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" 
            type="text/css" runat="server" />
        
        <script language="javascript" type="text/javascript">
            
            function printLoadingSheet()
            {
                innerHTML = new String(window.opener.document.frmLoadingSheet.innerHTML);
		        document.frmPrintLS.innerHTML = innerHTML;
            }
            
        </script>
        
    </head>
    
    <body onload="Javascript:printLoadingSheet();window.print();">
        
        <form id="frmPrintLS" runat="server">
                
        </form>
        
    </body>
    
</html>
