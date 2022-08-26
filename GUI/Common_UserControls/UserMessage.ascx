<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UserMessage.ascx.cs" Inherits="GUI_Common_UserControls_UserMessage" %>

<script type="text/javascript" language="javascript">

    function closeAlert(idbg, idmsg) {
        document.getElementById(idbg).style.display = "none";
        document.getElementById(idmsg).style.display = "none";
        return false;
    }
</script>

<div id="divbg" runat="server" style="position: fixed; top: 0px; bottom: 0px; left: 0px;
    right: 0px; overflow: hidden; padding: 0; margin: 0; background-color: #fff;
    filter: alpha(opacity=50); opacity: .5; z-index: 1000;">
</div>
<div id="divmsg" runat="server" style="position: fixed; top: 40%; left: 20%; padding: 10px;
    width: 14%; z-index: 1001;">
    <div style="width: 6in; height: 4in;">
        <table class="ftbl" cellspacing="1">
            <tr class="hrow">
                <td>
                    <asp:Label ID="lbltitle" runat="server" CssClass="hfnt"></asp:Label>
                </td>
            </tr>
            <tr class="nrow">
                <td>
                    <table width="100%">
                        <tr>
                            <td>
                                <asp:Label ID="lblmessage" runat="server" CssClass="nfnt"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <asp:Button ID="btnok" Font-Bold="true" onmouseover="this.style.cursor='pointer'"
                                    runat="server" Width="50px" Text="OK" CssClass="nbtn"></asp:Button>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</div>
