<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Summary.aspx.cs" Inherits="GUI_View_Track_Operation_THC_Summary" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Summary</title>
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
                            Summary</font></td>
                </tr>
                <tr bgcolor="white">
                    <td nowrap align="center">
                        <table style="width: 8.0in" border="0" cellpadding="3" cellspacing="1" class="boxbg">
                            <tr class="bgbluegrey">
                                <td nowrap align="center">
                                    <font class="blackfnt">
                                        <%=call_dkt%>
                                        No.</font></td>
                                <td nowrap align="center">
                                    <font class="blackfnt">
                                        <%=call_dkt%>
                                        Date</font></td>
                                <td nowrap align="center">
                                    <font class="blackfnt">Origin</font></td>
                                <td>
                                    <font class="blackfnt">Destination</font></td>
                            </tr>
                            <tr bgcolor="white">
                                <td nowrap align="center">
                                    <asp:Label runat="server" Text="" CssClass="blackfnt" ID="lbldockno"></asp:Label>
                                </td>
                                <td nowrap align="center">
                                    <asp:Label runat="server" Text="" CssClass="blackfnt" ID="lbldockst"></asp:Label>
                                </td>
                                <td nowrap align="center">
                                    <asp:Label runat="server" Text="" CssClass="blackfnt" ID="lblorgncd"></asp:Label>
                                </td>
                                <td nowrap align="center">
                                    <asp:Label runat="server" Text="" CssClass="blackfnt" ID="lbldestcd"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table style="width: 8.0in" border="0" cellpadding="3" cellspacing="1" class="boxbg">
                            <tr>
                                <td class="bgbluegrey" align="center">
                                    <font class="blackboldfnt">
                                        <%=call_dkt%>
                                        Status</font></td>
                                <td bgcolor="white" align="center">
                                    <asp:Label runat="server" Text="" Font-Bold="true" CssClass="bluefnt" ID="lblstatus"></asp:Label></td>
                            </tr>
                            
                        </table>
                        <br />
                        <table style="width: 8.0in" border="0" cellpadding="3" cellspacing="1" class="boxbg">
                            <tr class="bgbluegrey">
                                <td colspan="3" align="center">
                                    <font class="blackboldfnt"> <%=call_dkt%> Details</font></td>
                            </tr>
                            <tr>
                                <td class="bgbluegrey">
                                    <font class="blackfnt">Vendor | Type</font></td>
                                  <td class="bgbluegrey">
                                    <font class="blackfnt">Route | Mode</font></td>
                                    <td class="bgbluegrey">
                                    <font class="blackfnt">Driver 1 | Driver 2</font></td>
                            </tr>
                            <tr  bgcolor="white"><td bgcolor="white" align="center">
                                    <asp:Label runat="server" Text=""  CssClass="blackfnt" ID="lblVend"></asp:Label></td>
                                     <td bgcolor="white" align="center"><asp:Label runat="server" Text=""  CssClass="blackfnt" ID="lblroute"></asp:Label></td>
                                      <td bgcolor="white" align="center"><asp:Label runat="server" Text=""  CssClass="blackfnt" ID="lblDriver"></asp:Label></td></tr>
                            </table>
                            <br />
                        <table style="width: 8.0in" border="0" cellpadding="3" cellspacing="1" class="boxbg">
                            <tr class="bgbluegrey">
                                <td colspan="4" align="center">
                                    <font class="blackboldfnt">Vehicle Details</font></td>
                            </tr>
                            <tr>
                                <td class="bgbluegrey">
                                    <font class="blackfnt">Vehicle | Type</font></td>
                                  <td class="bgbluegrey">
                                    <font class="blackfnt">Tonnage | Loaded</font></td>
                                     <td class="bgbluegrey">
                                    <font class="blackfnt">Capacity | Payload</font></td>
                                    <td class="bgbluegrey">
                                    <font class="blackfnt">Utilization </font></td>
                            </tr>
                            <tr  bgcolor="white"><td bgcolor="white" align="center">
                                    <asp:Label runat="server" Text=""  CssClass="blackfnt" ID="lblveh"></asp:Label></td>
                                     <td bgcolor="white" align="center"><asp:Label runat="server" Text=""  CssClass="blackfnt" ID="lbltounnage"></asp:Label></td>
                                     <td bgcolor="white" align="center"> <asp:Label runat="server" Text=""  CssClass="blackfnt" ID="lblcapacity"></asp:Label></td>
                                      <td bgcolor="white" align="center"> <asp:Label runat="server" Text=""  CssClass="blackfnt" ID="lblUtilization"></asp:Label></td></tr>
                            </table>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
