<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FrmLogin.aspx.cs" Inherits="_Default"
    Title="WebXpress Warehouse Management System" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../../GUI/images/style.css" rel="stylesheet" type="text/css" />

    <script language="javascript" type="text/javascript">
    function validatecst()
    {
        if (document.getElementById("txtcstuname").value == "")
        {
            alert("Please Enter Customer Name")
            return false
        }
        if (document.getElementById("txtcstpwd").value == "")
        {
            alert("Please Enter Customer Password")
            return false
        }
    }
    function validategrp()
    {
        if (document.getElementById("txtgrpuname").value == "")
        {
            alert("Please Enter Customer Group Name")
            return false
        }
        if (document.getElementById("txtgrppwd").value == "")
        {
            alert("Please Enter Customer Group Password")
            return false
        }
    }
     
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <table style="width: 100%">
            <tr>
                <td width="40%" align="left" valign="top">
                    &nbsp;<%--<asp:Image Height="40" ID="imgLogo" ImageUrl="~/GUI/images/webxpress_logo.gif"
                        runat="server" />--%>
                        <asp:Image Height="50" ID="imgLogo" runat="server" />
                </td>
            </tr>
            <tr>
                <td align="left" colspan="3">
                    <asp:Label ID="lblWelcome" runat="server" Text="" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                    <hr align="center" size="1" color="#8ba0e5">
                </td>
            </tr>
            <tr>
                <td style="width: 30%">
                </td>
                <td align="center" valign="top" style="width: 15%">
                    <table cellspacing="1" cellpadding="1" style="border-color: #8ba0e5; width: 100%"
                        bgcolor="#8ba0e5">
                        <tr bgcolor="#ffffff">
                            <td valign="top" align="center">
                                <asp:Image ID="img1" ImageUrl="~/GUI/images/midimg.jpg" runat="server" />
                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top" align="center" style="width: 45%">
                    <table border="0" cellspacing="0" style="height: 30px; margin: 1px 1px 1px 1px; width: 229px;">
                        <tr>
                            <td>
                                <table border="0" class="boxbg" cellspacing="1" width="100%" cellpadding="0">
                                    <tr>
                                        <td height="24" align="center" class="bgbluegrey">
                                            <font class="blackfnt"><%=Client %> - CUSTOMER LOGIN</font></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" style="height: 177px;">
                                <br />
                                <table  width="100%" bordercolor="#8ba0e5" border="1" style="width:100%;">
                                    <tr>
                                        <td>
                                            <table border="0" cellspacing="0" cellpadding="3" style="width: 222px">
                                                <tr bgcolor="#ffffff">
                                                    <td  align="left">
                                                        <font class="blackfnt"><strong>Username&nbsp;
                                                            <asp:TextBox ID="txtcstuname" CssClass="logininp" MaxLength="50" runat="server" onChange="javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                                                        </strong></font>
                                                    </td>
                                                </tr>
                                                <tr bgcolor="#ffffff">
                                                    <td align="left">
                                                        <font class="blackfnt"><strong>Password&nbsp;&nbsp;
                                                            <asp:TextBox ID="txtcstpwd" CssClass="logininp" MaxLength="20" runat="server" TextMode="Password"></asp:TextBox>
                                                        </strong></font>
                                                    </td>
                                                </tr>
                                                <tr bgcolor="#ffffff">
                                                    <td align="left" style="height: 25px">
                                                        <asp:Button ID="cmdcstsubmit" Text="Login" CssClass="loginbut" runat="server" OnClientClick="return validatecst()"
                                                            OnClick="cmdcstsubmit_Click" />&nbsp;<asp:Label ID="lblcusterror" runat="server"
                                                                CssClass="blackfnt" ForeColor="Red" Text="Authentication Failed !!" Visible="False"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
