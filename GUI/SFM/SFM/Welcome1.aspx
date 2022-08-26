<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Welcome1.aspx.cs" Inherits="SFM_Welcome1" %>
<%@ Reference Control="~/include/menu.ascx"%>
<%@ Register TagPrefix="menu" TagName="Header" Src="~/include/menu.ascx" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>WelCome</title>
    <link href="../include/Styles.css" rel="stylesheet" type="text/css" />
    
</head>
<body>
    <form id="form1" runat="server">
    <menu:header id="Header1" runat="server" ></menu:header>
    <div>
        <table style="width: 648px">
            
            <tr>
                 <td>
               <strong><font class="bluefnt"> <% =  Session["empnm"]%> :</font> </strong>
                   <strong><font class="bluefnt">Welcome to WebXpress : Visibility for Supply Chains</font></strong></td>
       </tr>
        <tr>
                <td align="left" style="width: 1100px; height: 10px"><hr style="width: 140%" />
                </td>
            </tr>
                </table>
                
                <table border="0" cellpadding="0" cellspacing="0" style="width: 113%; height: 488px">
                <tr>
                    <td style="width: 36%; height: 87px" valign="top">
                        <table border="0" cellpadding="3" cellspacing="0" width="100%">
                            <tr height="70" style="font-family: Times New Roman">
                                <td style="height: 37px">
                                    <font class="blackfnt"><font color="#000000"><b>
                                        <table border="1" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td align="center" class="bgbluegrey" style="height: 28px">
                                                    <font class="blackfnt">WebXpress News </font>
                                                </td>
                                            </tr>
                                        </table>
                                    </b></font></font>
                                </td>
                            </tr>
                        </table>
                        <p align="justify">
                            <font class="blackfnt"><u>1 Sept 05</u><br />
                                Please note that there has been an increase in the diesel price by 6%. </font>
                            <a href="#"><font class="bluelink">&gt;&gt;more</font></a></p>
                        <p align="justify">
                            <font class="blackfnt"><u>1 Sept 05</u><br />
                                This is to inform you that <u>FORM 88</u> has been made <strong>mandatory</strong>
                                in the state of M.P. and it is applicable for all incoming material. </font>
                            <a href="#"><font class="bluelink">&gt;&gt;More</font></a></p>
                        <p>
                            <table border="1" cellpadding="0" cellspacing="0" style="left: 0px; position: relative;
 top: 32px" width="100%">
                                <tr>
                                    <td align="center" class="bgbluegrey" style="height: 28px">
                                        <font class="blackfnt">E-Learning</font></td>
                                </tr>
                            </table>
                        </p>
                        <table style="left: 0px; width: 280px; position: relative; top: 24px">
                            <tr>
                                <td style="height: 22px">
                                    <a href="http://webxpress.ecforyou.com/WebXpress_userguide.doc" target="_new"><font
                                        class="blklnkund">WebXpress Users Manual</font></a></td>
                            </tr>
                        </table>
                    </td>
                    <td style="width: 244px; height: 87px" valign="top">
                        <table border="0" style="width: 14px; height: 328px">
                            <tr>
                                <td style="width: 25px; height: 80px">
                                    <img align="center" src="../images/midimg.jpg" style="left: 16px; position: relative;
                                        top: 0px; height: 448px" width="131" />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="width: 42%; height: 87px" valign="top">
                        <table border="0" cellpadding="3" cellspacing="0" style="height: 248px" width="100%">
                            <tr>
                                <td style="height: 63px">
                                    <table border="1" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td align="center" class="bgbluegrey" style="height: 28px">
                                                <font class="blackfnt">WebXpress Login</font></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 152px">
                                    <table style="left: 0px; width: 336px; position: relative; top: -22px; height: 64px" frame="box">
                                        <tr>
                                            <td style="width: 229px; height: 16px;">
                                                <strong><span style="font-size: 8pt; font-family: Verdana">&nbsp;Outstanding (Rs. Lanks)</span></strong></td>
                                            <td style="width: 107px; height: 16px;">
                                                <span style="font-size: 8pt; font-family: Verdana"><strong>&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                                                    25.45</strong></span></td>
                                           
                                        </tr>
                                        <tr style="font-size: 12pt; font-family: Times New Roman">
                                            <td style="width: 229px; height: 13px;">
                                                <strong><span style="font-size: 8pt; font-family: Verdana">&nbsp;Dockets not delivered</span></strong></td>
                                            <td style="width: 107px; height: 13px;">
                                                <strong><span style="font-size: 8pt; font-family: Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
                                                    &nbsp;123</span></strong></td>
                                           
                                        </tr>
                                        <tr>
                                            <td style="width: 229px; height: 13px;">
                                                <strong><span style="font-size: 8pt; font-family: Verdana">&nbsp;Collection (Rs. Thousands)</span></strong></td>
                                            <td style="width: 107px; height: 13px;">
                                                <strong><span style="font-size: 8pt; font-family: Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
                                                    &nbsp;17.53</span></strong></td>
                                           
                                        </tr>
                                         <tr>
                                            <td style="width: 229px; height: 12px;">
                                                <strong><span style="font-size: 8pt; font-family: Verdana">&nbsp;Monthly sales target
                                                    achived</span></strong></td>
                                            <td style="width: 107px; height: 12px;">
                                                <strong><span style="font-size: 8pt; font-family: Verdana">&nbsp; &nbsp; &nbsp; &nbsp;
                                                    &nbsp;35%</span></strong></td>
                                            
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <br />
                        <br />
                        <br />
                    </td>
                </tr>
                <tr style="font-size: 12pt; font-family: Times New Roman">
                    <td style="width: 36%; height: 19px" valign="top">
                    </td>
                    <td style="width: 244px; height: 19px" valign="top">
                    </td>
                    <td style="width: 42%; height: 19px" valign="top">
                    </td>
                </tr>
            </table>
    </div>
    </form>
</body>
</html>
