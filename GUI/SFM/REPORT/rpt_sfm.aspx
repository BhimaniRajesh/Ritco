<%@ Page Language="C#" AutoEventWireup="true" CodeFile="rpt_sfm.aspx.cs" Inherits="REPORT_rpt_sfm" %>
<%@ Reference Control="~/include/menu.ascx"%>
<%@ Register TagPrefix="menu" TagName="Header" Src="~/include/menu.ascx" %>



<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Report Main Page</title>
    <link href="../include/Styles.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <menu:header id="Header1" runat="server" ></menu:header>
    <div>
        <table align="left" border="0" cellpadding="5" cellspacing="1" class="boxbg" width="45%">
                                              
                                                <tr bgcolor="#ffffff">
                                                    <td align="middle" height="25" valign="center" width="7%">
                                                        <table border="0" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td class="bullet" style="width: 5px">
                                                                    <img height="4" src="../images/clear.gif" width="4" /></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td nowrap="nowrap">
                                                        <font class="blackfnt"><strong>Funnel Report</strong></font></td>
                                                    <td align="middle" style="font-weight: bold">
                                                      <%--  <font class="blklnkund"><a href="sfm_funnel_report_loc_wise.aspx">
                                                            Location wise</a> | <a href="./sfm_funnel_report_Sale_wise.aspx">
                                                               Sales Person wise</a> </font>--%>
                                                               <font class="blackfnt"><a href="sfm_funnel_report_loc_wise.aspx">Location wise</a> | <a href="./sfm_funnel_report_Sale_wise.aspx">
                                                                Sales Person wise</a> </font>
                                                    </td>
                                                </tr>
                                                <tr bgcolor="#ffffff" style="font-weight: bold">
                                                    <td align="middle" height="25" valign="center" width="7%">
                                                        <table border="0" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td class="bullet">
                                                                    <img height="4" src="../images/clear.gif" width="4" /></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td nowrap="nowrap">
                                                        <font class="blackfnt"><strong>Sales Call Summary</strong></font></td>
                                                    <td align="middle" nowrap="nowrap">
                                                        <font class="blackfnt"><a href="CallSummary_Locationwise1.aspx">Location wise</a> | <a href="">
                                                                Sales Person wise</a> </font>
                                                    </td>
                                                </tr>
                                                <tr bgcolor="#ffffff" style="font-weight: bold">
                                                    <td align="middle" height="25" valign="center" width="7%">
                                                        <table border="0" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td class="bullet">
                                                                    <img height="4" src="../images/clear.gif" width="4" /></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td nowrap="nowrap">
                                                        <font class="blackfnt"><strong>Sales Call Register</strong></font></td>
                                                    <td align="middle" nowrap="nowrap">
                                                        <font class="blackfnt"><a href="CallRegister_CompanywiseReport.aspx">
                                                            Company wise</a> | <a href="CallRegister_SalesPersonWiseReport.aspx">
                                                                Sales Person wise</a> </font>
                                                    </td>
                                                </tr>
                                                <tr bgcolor="#ffffff" style="font-weight: bold">
                                                    <td align="middle" height="25" valign="center" width="7%">
                                                        <table border="0" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td class="bullet">
                                                                    <img height="4" src="../images/clear.gif" width="4" /></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <!--<td nowrap><font class=blackfnt>Funnel Report</font></td>-->
                                                    <td colspan="2" nowrap="nowrap">
                                                        <font class="blackfnt"><a href="Prospect_RegisterReport.aspx"><u>
                                                            Prospect Register</u></a></font></td>
                                                </tr>
                                                
                                                
                                            </table>
    </div>
    </form>
</body>
</html>
