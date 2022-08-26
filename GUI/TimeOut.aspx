<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Session Expired</title>
    <LINK title="stylesheet" href="~/GUI/images/style.css" type="text/css" rel="stylesheet">
</head>
<body style="font-size: 12pt">
    <form id="form1" runat="server">
    <div align="center">
    <table border="0" width="75%">
        <tr>
            <td align="left"><font class="blackfnt"><strong>Member Site</strong></font></td>
            <td style="font-size: 12pt" align="right">
            <asp:Image runat="server" ID="imgLogo" ImageUrl="~/GUI/images/webxpress_logo.gif" />
            </td>
        </tr>                
    </table>
    <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="75%" style="font-size: 12pt">
        <tr class="bgbluegrey">
            <td colspan="2">
                &nbsp;</td>
        </tr>
        <tr bgcolor="white">
            <td >
                <table border="0" width="100%">
                    <tr width="70%">
                        <td align="left"  class="blackfnt">
                        <font class="blackfnt"><strong><span style="font-size: 14pt">We apologize</span></strong><br /><br />
                        Your session on WebXpress&trade; ERP site has ended for one of the following reasons:<br />
                        </font>
                            <ol>
                                <li>Session automatically got timed out, bcoz of inactivity, as a security precaution.&nbsp;</li><br /><br />
                                <li>You are using a bookmark from a previous visit to the site. Site is dynamically
                            generated and cannot be bookmarked.</li>
                            </ol>
                            <p>
                                <br />
                        If you would like to return to the WebXpress&trade; ERP, please use your link.
                            </p>
                        
                        </td>
                        <td width="30%">
                        <asp:Image  runat="server" ID="imgTimeOut" ImageUrl="~/GUI/images/stopwatch.gif" />
                        </td>
                    </tr>                
                </table>
            </td>
        </tr>
    </table>
    </div>
    </form>
</body>
</html>
