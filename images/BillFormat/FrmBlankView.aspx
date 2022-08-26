<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FrmBlankView.aspx.cs" Inherits="GUI_Finance_BILLING_BillViewPrint_FrmBlankView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Blank Format</title>
    <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
    <script type="text/javascript" language="javascript">
        function closeAlert() 
        {
            window.close();    
//            document.getElementById("ctl00_MyCPH1_progressBackgroundFilter").style.display = "none";
//            document.getElementById("ctl00_MyCPH1_processMessage").style.display = "none";
//            return false;
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div id="progressBackgroundFilter" runat="server" class="progressBackgroundFilter">
    </div>
    <div id="processMessage" runat="server" class="processMessage">
        <div style="width: 6in; height: 4in;">
            <table class="boxbg" cellspacing="0" width="100%">
                <tr class="bgbluegrey">
                    <td>
                        Message
                    </td>
                </tr>
                <tr class="blackfnt">
                    <td>
                        <table width="100%">
                            <tr bgcolor="white">
                                <td>
                                    <asp:Label ID="lblalert" runat="server" CssClass="nfnt"></asp:Label>
                                </td>
                            </tr>
                            <tr bgcolor="white">
                                <td align="center">
                                    <asp:Button ID="btnalertclose" Font-Bold="true" onmouseover="this.style.cursor='pointer'"
                                        runat="server" OnClientClick="javascript:return closeAlert();" Width="50px" Text="OK"
                                        CssClass="ebtn"></asp:Button>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </form>
</body>
</html>
