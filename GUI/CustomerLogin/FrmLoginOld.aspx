<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FrmLoginOld.aspx.cs" Inherits="GUI_CustomerLogin_FrmLogin" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
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
    <div>
    <table border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td ><!--background="../images/top_bg.gif"-->
<table width="778" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><!--<img src="../images/toplogo.gif" width="121" height="40">-->
			<table border="0" cellspacing="0" cellpadding="0">
			  <tr>
			    <td valign="top" align="left"><img border="0" src="../images/webxpress_logo.gif"></td>
			    <td valign="top" align="left"><img border="0" src="../images/blank_top.gif" width="0" height="19"></td>
			  </tr>
			</table>          
          </td>
          <td>&nbsp;</td>
          <td align="right" class=blacklink>&nbsp;&nbsp;</td>
        </tr>
        <tr> 
          <td width="343" height="65" valign="top" background="../images/topband1.jpg"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td><img src="../images/clear.gif" width="10" height="7"></td>
              </tr>
              <tr> 
                <td height="14" background="../images/band_strip.gif"><font class=bandstrip><em>&nbsp;&nbsp;<strong>Information Management System</strong></em></font></td>
              </tr>
              <tr> 
                <td style="height: 14px">&nbsp;</td>
              </tr>
              <tr> 
                
                <td height="14">&nbsp;&nbsp;<font class=whitefnt></font></td>
              </tr>
            </table></td>
          <td width="246"><img src="../images/topband2.jpg" width="246" height="65"></td>
          <td width="189" background="../images/topband3.jpg">&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td><table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr> 
          <td height="30"><font class=blackfnt><strong>&nbsp;Welcome to WebXpress - CUSTOMER MODULE</strong></font></td>
        </tr>
        <tr> 
          <td class="horzblue"><img src="../images/clear.gif" width="2" height="1"></td>
        </tr>
        <tr> 
            <td style="height: 30px"><img src="../images/clear.gif" width="15" height="30"></td>
        </tr>
        <tr>
          <td>
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td valign="top"> 
                    <%--<table width="90%" border="0" cellspacing="1" cellpadding="0" class=boxbg>
                      <tr>
                        <td bgcolor="#FFFFFF">
                          <table border="0" cellspacing="0" cellpadding="0" width=100%>
                            <tr> 
                              <td valign="top"> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="3">
                                  <tr> 
                                    <td> 
                                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr> 
                                          <td height="28" align="center" class="bgbluegrey"><font class=blackfnt>WebXpress 
                                            - CUSTOMER GROUP LOGIN</font></td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td> 
                                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr> 
                                          <td width="6" ><img src="../images/clear.gif" width="4" height="10"></td>
                                          <td><img src="../images/clear.gif" width="4" height="10"></td>
                                          <td><img src="../images/clear.gif" width="4" height="10"></td>
                                        </tr>
                                        <tr> 
                                          <td >&nbsp;</td>
                                          <td>&nbsp;</td>
                                          <td><font class=blackfnt><strong>Username&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                                            <asp:TextBox ID="txtgrpuname" CssClass="logininp" MaxLength="50" runat="server" onChange="javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                                            </strong></font></td>
                                        </tr>
                                        <tr> 
                                          <td ><img src="../images/clear.gif" width="4" height="15"></td>
                                          <td><img src="../images/clear.gif" width="4" height="15"></td>
                                          <td><img src="../images/clear.gif" width="4" height="15"></td>
                                        </tr>
                                        <tr> 
                                          <td >&nbsp;</td>
                                          <td>&nbsp;</td>
                                          <td><font class=blackfnt><strong>Password&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                                            <asp:TextBox ID="txtgrppwd" CssClass="logininp" MaxLength="20" runat="server" TextMode="Password"></asp:TextBox>
                                            </strong></font></td>
                                        </tr>
                                        <tr> 
                                          <td ><img src="../images/clear.gif" width="4" height="13"></td>
                                          <td><img src="../images/clear.gif" width="4" height="13"></td>
                                          <td><img src="../images/clear.gif" width="4" height="13"></td>
                                        </tr>
                                        <tr> 
                                          <td>&nbsp;</td>
                                          <td>&nbsp;</td>
                                          <td height="25"> 
                                            <table width="100%" border="0" cellspacing="0" cellpadding="2">
                                              <tr> 
                                                <td width="23%"> 
                                                  <asp:Button ID="cmdgrpsubmit" Text="Login" CssClass="loginbut" runat="server"  OnClientClick="return validategrp()" OnClick="cmdgrpsubmit_Click" />
                                                </td>
                                                <td width="77%" valign="bottom"><a href="#" style="COLOR: #2525A8; TEXT-DECORATION: Underline"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">Forgot 
                                                  Password? Click here</font></a></td>
                                              </tr>
                                            </table>
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td ><img src="../images/clear.gif" width="4" height="13"></td>
                                          <td><img src="../images/clear.gif" width="4" height="13"></td>
                                          <td><img src="../images/clear.gif" width="4" height="13"></td>
                                        </tr>
                                        <tr> 
                                          <td >&nbsp;</td>
                                          <td>&nbsp;</td>
                                          <td>&nbsp; 
                                              <asp:Label ID="lblgrperror" runat="server" CssClass="blackfnt" ForeColor="Red" Text="Authentication Failed !!"
                                                  Visible="False" Width="196px"></asp:Label></td>
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
                    </table>--%>
                  </td>
                  <%--<td><img src="../images/clear.gif" width="20"></td>--%>
                  <td colspan="2">
                    <table border="0" cellspacing="0" cellpadding="0" width=100%>
                      <tr> 
                        <td valign="top"> 
                          <table border="0" cellspacing="1" cellpadding="0" class=boxbg style="width: 47%">
                            <tr>
                              <td bgcolor="#FFFFFF">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3">
                                  <tr> 
                                    <td> 
                                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr> 
                                          <td height="28" align="center" class="bgbluegrey"><font class=blackfnt>WebXpress
                                            - CUSTOMER LOGIN</font></td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td> 
                                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr> 
                                          <td width="6" ><img src="../images/clear.gif" width="4" height="10"></td>
                                          <td><img src="../images/clear.gif" width="4" height="10"></td>
                                          <td><img src="../images/clear.gif" width="4" height="10"></td>
                                        </tr>
                                        <tr> 
                                          <td >&nbsp;</td>
                                          <td>&nbsp;</td>
                                          <td><font class=blackfnt><strong>Username 
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                                            <asp:TextBox ID="txtcstuname" CssClass="logininp" MaxLength="50" runat="server" onChange="javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                                            </strong></font></td>
                                        </tr>
                                        <tr> 
                                          <td ><img src="../images/clear.gif" width="4" height="15"></td>
                                          <td><img src="../images/clear.gif" width="4" height="15"></td>
                                          <td><img src="../images/clear.gif" width="4" height="15"></td>
                                        </tr>
                                        <tr> 
                                          <td >&nbsp;</td>
                                          <td>&nbsp;</td>
                                          <td><font class=blackfnt><strong>Password&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                                            <asp:TextBox ID="txtcstpwd" CssClass="logininp" MaxLength="20" runat="server" TextMode="Password"></asp:TextBox>
                                            </strong></font></td>
                                        </tr>
                                        <tr> 
                                          <td ><img src="../images/clear.gif" width="4" height="13"></td>
                                          <td><img src="../images/clear.gif" width="4" height="13"></td>
                                          <td><img src="../images/clear.gif" width="4" height="13"></td>
                                        </tr>
                                        <tr> 
                                          <td >&nbsp;</td>
                                          <td>&nbsp;</td>
                                          <td height="25"> 
                                            <table width="100%" border="0" cellspacing="0" cellpadding="2">
                                              <tr> 
                                                <td width="23%"> 
                                                  <asp:Button ID="cmdcstsubmit" Text="Login" CssClass="loginbut" runat="server" OnClientClick="return validatecst()" OnClick="cmdcstsubmit_Click" />
                                                </td>
                                                <td width="77%" valign="bottom"><a href="#" style="COLOR: #2525A8; TEXT-DECORATION: Underline"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">Forgot 
                                                  Password? Click here</font></a></td>
                                              </tr>
                                            </table>
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td ><img src="../images/clear.gif" width="4" height="13"></td>
                                          <td><img src="../images/clear.gif" width="4" height="13"></td>
                                          <td><img src="../images/clear.gif" width="4" height="13"></td>
                                        </tr>
                                        <tr> 
                                          <td style="height: 19px" >&nbsp;</td>
                                          <td style="height: 19px">&nbsp;</td>
                                          <td style="height: 19px">&nbsp;<asp:Label ID="lblcusterror" runat="server" CssClass="blackfnt" ForeColor="Red"
                                                  Text="Authentication Failed !!" Visible="False" Width="196px"></asp:Label></td>
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
                  </td>
                </tr>
              </table>
              
            </td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
    </div>
    </form>
</body>
</html>
