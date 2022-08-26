<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AzureBaseDownloadFile.aspx.cs" Inherits="GUI_AzureBaseDownloadFile" %>
<%@ OutputCache Location="none" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >

    <head runat="server">
        <title>
            Download Document
        </title>
        
        <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" 
            type="text/css" runat="server" />
        
        <script language="javascript" type="text/javascript">
        
            function disableenter()
            {
            
            }
            
        </script>
         
    </head>
    
    <body>
        <div>
            <label id="lblErrorMessage" runat="server" class="blackfnt" style="color: Red;" visible="false"></label>
            <br />
            <br />
            <center>
                <input type="button" id="btnCloseWindow" class="blackfnt" runat="server" onclick="JavaScript:window.close();" value="Close Window" title="Click here to Close this Window" visible="false" />
            </center>
        </div>
    </body>
    
</html>
