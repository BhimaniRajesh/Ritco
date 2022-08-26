<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FrmMain.aspx.cs" Inherits="GUI_CustomerLogin_FrmMain" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <link href="../../GUI/images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            &nbsp;
            <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td align="left" width="40%" valign="top">
                        <%--<asp:Image Height="40" ID="imgLogo" ImageUrl="~/GUI/images/webxpress_logo.gif"
                            runat="server" />--%>
                            <asp:Image Height="50" ID="imgLogo" runat="server" />
                            <br />
                            <asp:Label id="lblccode" CssClass="blackfnt" runat="server" ></asp:Label> | <asp:Label id="lblcname"  CssClass="blackfnt" runat="server" ></asp:Label>
                            <br />
                    </td>
                    <td align="right">
                        <asp:LinkButton ID="lnklogout" runat="server" Text="Logout" CssClass="blacklink"
                            OnClick="logout" Font-Underline="true"></asp:LinkButton> | 
                        <asp:LinkButton Font-Underline="true" ID="LinkButton1" runat="server" Text="Home" CssClass="blacklink"
                            PostBackUrl="~/GUI/CustomerLogin/FrmMain.aspx"></asp:LinkButton>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="left">
                        <asp:Label ID="lblWelcome" runat="server"  CssClass="blackfnt" Font-Bold="true"></asp:Label>
                        <hr align="center" size="1" color="#8ba0e5">
                        
                    </td>
                </tr>
                <tr>
                    <td colspan="2"  height="30">
                        <a><font class="blklnkund"><strong>Module </strong></font></a><font class="bluefnt">
                            <strong>&gt; Customer Module</strong> </font>
                    </td>
                </tr>
                <%--<tr>
                    <td colspan="2"  class="horzblue">
                        <img src="../images/clear.gif" width="2" height="1"></td>
                </tr>--%>
                <tr>
                    <td  colspan="2" >
                        <img src="../images/clear.gif" width="15" height="10"></td>
                </tr>
                <tr>
                    <td  colspan="2" >
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="39%" valign="top">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                                        <tr>
                                            <td height="300" valign="top">
                                                <table width="40%" border="0" cellpadding="5" cellspacing="1" class="boxbg">
                                                    <tr>
                                                        <td height="25" bgcolor="#FFFFFF">
                                                            <table border="0" cellspacing="0" cellpadding="0">
                                                                <tr>
                                                                    <td class="bullet">
                                                                        <img src="../images/clear.gif" width="4" height="4"></td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td bgcolor="#FFFFFF" width="98%">
                                                            <a href="FrmListLocations.aspx"><font class="blklnkund">View Location List</font></a></td>
                                                    </tr>
                                                    <tr>
                                                        <td height="25" bgcolor="#FFFFFF">
                                                            <table border="0" cellspacing="0" cellpadding="0">
                                                                <tr>
                                                                    <td class="bullet">
                                                                        <img src="../images/clear.gif" width="4" height="4"></td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td bgcolor="#FFFFFF" width="98%">
                                                            <a href="FrmCriteria.aspx"><font class="blklnkund">Track dockets</font></a></td>
                                                    </tr>
                                                    <%--<tr>
                                                        <td height="25" bgcolor="#FFFFFF">
                                                            <table border="0" cellspacing="0" cellpadding="0">
                                                                <tr>
                                                                    <td class="bullet">
                                                                        <img src="../images/clear.gif" width="4" height="4"></td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td bgcolor="#FFFFFF">
                                                            <a href="#"><font class="blklnkund">Quick Reports</font></a></td>
                                                    </tr>--%>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;</td>
                                        </tr>
                                    </table>
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
