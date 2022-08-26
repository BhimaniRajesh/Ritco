<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Available_dockets.aspx.cs"    Inherits="GUI_Operation_Singlescreen_docketentry_Available_dockets" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Series List</title>
</head>
<body  leftmargin="0" topmargin="0">
    <%--<atlas:ScriptManager ID="scmn1" runat="server"  >

</atlas:ScriptManager>--%>
    <form id="form1" runat="server">
        <table style="width: 100%; height: 100%">
            <tr>
                <td>
                    <iframe id="Iframe1" scrolling="no" src="./Available_dockets_list.aspx" height="230"
                        style="border: 0px" width="320" runat="server"></iframe>
                </td>
            </tr>
            <%--<tr>
        <td align="right" valign="bottom">
            <a href="#" onclick="dismissbox();return false">[Close Box] </a>
        </td>
    </tr>--%>
        </table>
    </form>
</body>
</html>
