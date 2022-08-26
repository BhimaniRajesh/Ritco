<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Docket_summary.aspx.cs" Inherits="GUI_Tracking_New_TAB_Tracking_Docket_Docket_summary" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <link href="../../../images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table width="95%" border="0" cellpadding="5" cellspacing="1" class="boxbg">
                <%-- <tr class="bgbluegrey">
        <td align="center" colspan="6">
            <font class="blackboldfnt">Summary</font>
        </td>
    </tr>--%>
                <%-- <tr bgcolor="white"">
        <td align="center" colspan="6">
        </td>
    </tr>--%>
                <tr class="bgbluegrey">
                    <td align="center" style="height: 28px">
                        <font class="blackfnt">
                            <%=call_dkt%>
                            No.</font></td>
                    <td align="center" style="height: 28px">
                        <font class="blackfnt">
                            <%=call_dkt%>
                            Date</font></td>
                    <td align="center" style="height: 28px">
                        <font class="blackfnt">Origin</font></td>
                    <td align="center" style="height: 28px">
                        <font class="blackfnt">Curr Location</font></td>
                    <td align="center" style="height: 28px">
                        <font class="blackfnt">Next Location</font></td>
                    <td align="center" style="height: 28px">
                        <font class="blackfnt">Destination</font></td>
                    <td align="center" style="height: 28px">
                        <font class="blackfnt">From-To</font></td>
                </tr>
                <tr bgcolor="white"">
                    <td align="center">
                        <font class="blackfnt">
                            <%=docket%>
                        </font>
                    </td>
                    <td align="center">
                        <font class="blackfnt">
                            <%=dock_dt%>
                        </font>
                    </td>
                    <td align="center">
                        <font class="blackfnt">
                            <%=origin%>
                        </font>
                    </td>
                    <td align="center">
                        <font class="blackfnt">
                            <%=destcd%>
                        </font>
                    </td>
                    <td align="center">
                        <font class="blackfnt">
                            <%=curr_loc%>
                        </font>
                    </td>
                    <td align="center">
                        <font class="blackfnt">
                            <%=Nextloc%>
                        </font>
                    </td>
                    <td align="center">
                        <font class="blackfnt">
                            <%=from_loc%>
                            -
                            <%=to_loc%>
                        </font>
                    </td>
                </tr>
            </table>
            <br>
            <table width="80%" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#808080"
                class="boxbg">
                <tr>
                    <td align="left" width="15%" class="bgbluegrey">
                        <div align="center">
                            <font class="blackfnt">Status </font>
                        </div>
                    </td>
                    <td align="center" width="30%" bgcolor="#FFFFFF">
                        <font class="blackfnt">
                            <%=st_status%>
                        </font>
                    </td>
                </tr>
            </table>
            <br>
            <table border="0" width="98%" align="center" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="48%">
                        <center>
                            <font class="bluefnt"><b>Booking Details</b></font></center>
                    </td>
                    <td>
                        <img src="../../../images/clear.gif" width="20"></td>
                    <td width="48%">
                        <center>
                            <font class="bluefnt"><b>Delivery Details</b></font></center>
                    </td>
                </tr>
                <tr>
                    <td width="48%" valign="top">
                        <table border="0" width="100%" align="center" bgcolor="#808080" cellspacing="1" cellpadding="2"
                            class="boxbg">
                            <tr>
                                <td class="bgbluegrey" width="40%">
                                    <font class="blackfnt">Service Type</font></td>
                                <td bgcolor="#FFFFFF">
                                    <font class="blackfnt">
                                        <%=Service_Class%>
                                    </font>
                                </td>
                            </tr>
                            <tr>
                                <td class="bgbluegrey">
                                    <font class="blackfnt">Pkgs/ Charged Weight</font></td>
                                <td bgcolor="#FFFFFF">
                                    <font class="blackfnt">
                                        <%=pkgsno%>
                                        /
                                        <%=chrgwt%>
                                    </font>
                                </td>
                            </tr>
                            <tr>
                                <td class="bgbluegrey">
                                    <font class="blackfnt">Pay Basis</font></td>
                                <td bgcolor="#FFFFFF">
                                    <font class="blackfnt">
                                        <%=PAYBASis%>
                                    </font>
                                </td>
                            </tr>
                            <tr>
                                <td class="bgbluegrey">
                                    <font class="blackfnt">Mode</font></td>
                                <td bgcolor="#FFFFFF">
                                    <font class="blackfnt">
                                        <%=tranportmode%>
                                    </font>
                                </td>
                            </tr>
                            <tr>
                                <td class="bgbluegrey">
                                    <font class="blackfnt">Consignor Name</font></td>
                                <td bgcolor="#FFFFFF">
                                    <font class="blackfnt">
                                        <%=Cnor%>
                                    </font>
                                </td>
                            </tr>
                            <tr>
                                <td class="bgbluegrey">
                                    <font class="blackfnt">Consignee Name</font></td>
                                <td bgcolor="#FFFFFF">
                                    <font class="blackfnt">
                                        <%=Cnee%>
                                    </font>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <img src="../../../images/clear.gif" width="20"></td>
                    <td width="48%" valign="top">
                        <table border="0" width="100%" align="center" bgcolor="#808080" cellspacing="1" cellpadding="2"
                            class="boxbg">
                            <tr>
                                <td class="bgbluegrey">
                                    <font class="blackfnt">Assured Dly. Date</font></td>
                                <td bgcolor="#FFFFFF">
                                    <font class="blackfnt">
                                        <%=CDELDT%>
                                    </font>
                                </td>
                            </tr>
                            <tr>
                                <td class="bgbluegrey" width="45%">
                                    <font class="blackfnt">Arrival Date</font></td>
                                <td bgcolor="#FFFFFF">
                                    <font class="blackfnt">
                                        <%=Arrv_dt%>
                                    </font>
                                </td>
                            </tr>
                            <tr>
                                <td class="bgbluegrey" width="45%">
                                    <font class="blackfnt">Actual Delivery Date</font></td>
                                <td bgcolor="#FFFFFF">
                                    <font class="blackfnt">
                                        <%=dely_date%>
                                    </font>
                                </td>
                            </tr>
                            <tr>
                                <td class="bgbluegrey">
                                    <font class="blackfnt">Date of Last Attempt</font></td>
                                <td bgcolor="#FFFFFF">
                                    <font class="blackfnt">
                                        <%=DATE_OF_Last_aatempt%>
                                    </font>
                                </td>
                            </tr>
                            <tr>
                                <td class="bgbluegrey">
                                    <font class="blackfnt">No. of Attempt</font></td>
                                <td bgcolor="#FFFFFF">
                                    <font class="blackfnt">
                                        <%=NO_OF_aatempt%>
                                    </font>
                                </td>
                            </tr>
                            <tr>
                                <td class="bgbluegrey" valign="top">
                                    <font class="blackfnt">Reason </font>
                                </td>
                                <td bgcolor="#FFFFFF">
                                    <font class="blackfnt">
                                        <%=reason%>
                                    </font>
                                </td>
                            </tr>
                            <tr>
                                <td class="bgbluegrey" width="45%">
                                    <font class="blackfnt">POD Received date</font></td>
                                <td bgcolor="#FFFFFF">
                                    <font class="blackfnt">
                                        <%=POD_recDate%>
                                    </font>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <br>
            <table border="0" id="tblcod" runat="server" width="98%" bgcolor="#808080" cellspacing="1"
                cellpadding="3" class="boxbg">
                <tr class="bgbluegrey">
                    <td align="center" colspan="4">
                        <font class="blackfnt">COD/DOD Details</font></td>
                </tr>
                <tr class="bgbluegrey">
                    <td align="center" width="35%">
                        <font class="blackfnt">COD/DOD No.</font></td>
                    <td align="center" width="30%">
                        <font class="blackfnt">COD/DOD Amount To Be collected </font>
                    </td>
                    <td align="center" width="35%">
                        <font class="blackfnt">COD/DOD Amount collected</font></td>
                    <td align="center" width="35%">
                        <font class="blackfnt">Collection Date </font>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="center" width="35%">
                        <font class="blackfnt">
                            <%=codno%>
                        </font>
                    </td>
                    <td align="center" width="30%">
                        <font class="blackfnt">
                            <%=codamt%>
                        </font>
                    </td>
                    <td align="center" width="35%">
                        <font class="blackfnt">
                            <%=codcollected%>
                        </font>
                    </td>
                    <td align="center" width="35%">
                        <font class="blackfnt">
                            <%=dely_date%>
                        </font>
                    </td>
                </tr>
            </table>
            <br />
            <center>
                <table border="0" width="60%" bgcolor="#808080" cellspacing="1" cellpadding="3" class="boxbg">
                    <tr bgcolor="#FFFFFF">
                        <td align="center" width="35%">
                            <font class="blackfnt"><a href="JavaScript:OpenPopupWindow1('<%=docket%>')" title="View Docket">
                                <u>View Docket</u></a></font></td>
                        <td align="center" nowrap width="30%">
                            <a href="javascript:topWindowPOD('<%=DocumentName%>')" title="View POD"><font class="blackfnt">
                                <u>
                                    <%=POD%>
                                </u></font></a>
                        </td>
                        <% if (podtrack != "N")
               {%>
                        <td align="center" width="35%">
                            <a href="javascript:topTrackPOD('<%=docket%>')" title="View POD"><font class="blackfnt">
                                <u>
                                    <%=podtrack%>
                                </u></font></a>
                        </td>
                        <%} %>
                    </tr>
                </table>
            </center>
            <br>
            <center>
                <font class="bluefnt"><b>Time Tracking Details: <font class="blackfnt">
                    <%=dockno%>
                    &nbsp;<%=docksf%></font></b></font>
            </center>
            <center>
                <table cellspacing="1" cellpadding="3" border="0" bgcolor="#808080" width="95%" class="boxbg">
                    <tr class="bgbluegrey">
                        <td valign="top" height="24" width="251">
                            &nbsp;</td>
                        <td valign="top"  nowrap height="24" align="center" >
                            <font class="blackfnt"><b>Arrival <br /> Date &amp; Time</b></font></td>
                        <td valign="top" nowrap height="24" align="center" >
                            <font class="blackfnt"><b>Departure  <br /> Date &amp; Time</b></font></td>
                        <td valign="top" height="24" align="center" width="210">
                            <font class="blackfnt"><b>MF No.</b></font></td>
                        <td valign="top" height="24" align="center" width="210">
                            <font class="blackfnt"><b>Thc No.</b></font></td>
                        <td valign="top" height="24" align="center" width="210">
                            <font class="blackfnt"><b>Veh No.</b></font></td>
                        <td valign="top" height="24" align="center" width="210">
                            <font class="blackfnt"><b>DRS No.</b></font></td>
                        <td valign="top" height="24" align="center" width="210">
                            <font class="blackfnt"><b>PRS No.</b></font></td>
                    </tr>
                    <asp:Repeater ID="rptBillDetails" runat="server">
                        <ItemTemplate>
                            <tr style="background-color: White">
                                <td align="center" style="width: 198px">
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "doc_curloc")%>
                                    </label>
                                </td>
                                <td align="center" style="width: 198px">
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "actarrv_dt")%>
                                    </label>
                                </td>
                                <td align="center" style="width: 198px">
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "actdept_dt")%>
                                    </label>
                                </td>
                                <td align="center" style="width: 198px">
                                    <a href="JavaScript:OpenWindow('<%#DataBinder.Eval(Container.DataItem, "tcno") %>')">
                                        <u>
                                            <%#DataBinder.Eval(Container.DataItem, "tcno")%>
                                        </u></a>
                                </td>
                                <td align="center" style="width: 198px">
                                    <a href="JavaScript:OpenWindowTHC('<%#DataBinder.Eval(Container.DataItem, "thcno") %>')">
                                        <u>
                                            <%#DataBinder.Eval(Container.DataItem, "thcno")%>
                                        </u></a>
                                </td>
                                <td align="center" style="width: 198px">
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "vehno")%>
                                    </label>
                                </td>
                                <td align="center" style="width: 198px">
                                    <a href="JavaScript:OpenWindowDRS('<%#DataBinder.Eval(Container.DataItem, "drs") %>')">
                                        <u>
                                            <%#DataBinder.Eval(Container.DataItem, "drs")%>
                                        </u></a>
                                </td>
                                <td align="center" style="width: 198px">
                                    <a href="JavaScript:OpenPopupWindowPRS('<%#DataBinder.Eval(Container.DataItem, "drs") %>')">
                                        <u>
                                            <%#DataBinder.Eval(Container.DataItem, "prs")%>
                                        </u></a>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
        </div>
    </form>
</body>
</html>
