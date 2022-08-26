<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Movement.aspx.cs" Inherits="GUI_View_Track_Operation_Docket_Movement" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Movement</title>
        <link rel="stylesheet" type="text/css" href="../../../images/style.css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table style="width: 8.0in" border="0" cellpadding="3" cellspacing="1" class="boxbg">
                <tr class="bgbluegrey">
                    <td colspan="8" nowrap align="center">
                        <font class="blackboldfnt">
                            <%=call_dkt%>
                            Movement</font></td>
                </tr>
                <tr bgcolor="white">
                    <td nowrap align="center">
    <asp:Table ID="tblMovement" Visible="true" runat="server" CellPadding="3" CellSpacing="1"
                Style="width: 8.0in;" CssClass="boxbg">
            </asp:Table>
            </td>
            </tr></table>
    </div>
    </form>
</body>
</html>
