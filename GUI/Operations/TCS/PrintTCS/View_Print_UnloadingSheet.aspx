<%@ Page Language="C#" AutoEventWireup="true" CodeFile="View_Print_UnloadingSheet.aspx.cs"
    Inherits="GUI_Operations_TCS_PrintTCS_View_Print_UnloadingSheet" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>View & Print Loading Sheet </title>
    <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />

    <script language="javascript" type="text/javascript">
            
            function OpenInWindow(windURL, h, w, l, t)
            {
		        var winOpts = "scrollbars=yes,resizable=yes,width="+w+",height="+h+"";
    		    
		        window.open(windURL, "", winOpts);
	        }
            
    </script>

</head>
<body>
    <form id="frmLoadingSheet" runat="server">
        <div>
            <table bgcolor="white" border="0" cellpadding="3" cellspacing="1" class="boxbg" colspan="2"
                width="100%">
                <tr bgcolor="white">
                    <td align="left" rowspan="3" style="width: 62%">
                        <asp:Image ID="imgLogo" runat="server" ImageUrl="~/GUI/images/webxpress_logo.gif" /><br />
                        <br />
                        <strong><span style="font-size: 8pt; font-family: Verdana">UNLOADING SHEET</span></strong></td>
                    <td align="left">
                        <font class="blackfnt"><b><span style="font-size: 8pt; font-family: Verdana">US No</span></b></font></td>
                    <td align="left" style="font-size: 8pt; width: 210px; font-family: Verdana">
                        <font class="blackfnt"></font>
                    </td>
                </tr>
                <tr bgcolor="#ffffff" style="font-weight: bold; font-size: 8pt; font-family: Verdana">
                    <td align="left" style="width: 16%">
                        <font class="blackfnt"><b>US Date</b></font></td>
                    <td align="left" style="width: 210px">
                        <font class="blackfnt"></font>
                    </td>
                </tr>
                <tr bgcolor="#ffffff" style="font-weight: bold; font-size: 8pt; font-family: Verdana">
                    <td align="left" style="width: 16%" class="blackfnt">
                        <b>Unloading At</b></td>
                    <td align="left" style="width: 210px">
                        <font class="blackfnt"></font>
                    </td>
                </tr>
            </table>
            <br />
            <table bgcolor="#ffffff" border="0" cellpadding="3" cellspacing="1" class="boxbg"
                colspan="2" style="width: 100%">
                <tr bgcolor="#ffffff">
                    <td align="left" style="width: 210px">
                        <font class="blackfnt"><b><span style="font-size: 8pt; font-family: Verdana">&nbsp;Route</span></b></font></td>
                    <td align="Left" style="width: 169px" class="blackfnt">
                        <%=route%>
                    </td>
                    <td align="Left" style="width: 120px">
                        <font class="blackfnt"><b><span style="font-size: 8pt; font-family: Verdana">&nbsp;ETA</span></b></font></td>
                    <td align="Left" style="font-size: 8pt; width: 104px; font-family: Verdana">
                    
                        <%=ETA %>
                    </td>
                    <td align="Left" style="font-size: 8pt; width: 167px; font-family: Verdana">
                        <font class="blackfnt"><b>&nbsp;THC Statr Location</b></font></td>
                    <td align="Left" style="font-size: 8pt; font-family: Verdana">
                        <font class="blackfnt">
                            <%=preat%>
                        </font>
                    </td>
                </tr>
                <tr bgcolor="#ffffff">
                    <td align="left" style="width: 210px; font-family: Verdana; font-size: 8pt;" class="blackfnt">
                        <b>&nbsp;THC No</b></td>
                    <td align="left" class="blackfnt" style="width: 169px">
                        <%=strLoadingSheetNo%>
                    </td>
                    <td align="left" style="width: 120px; font-family: Verdana; font-size: 8pt;">
                        <b>&nbsp;THC Date</b></td>
                    <td align="left" style="font-size: 8pt; width: 104px; font-family: Verdana">
                        <%=THCDt%>
                    </td>
                    <td align="left" style="font-size: 8pt; width: 167px; font-family: Verdana">
                        <b>&nbsp;Vehical</b></td>
                    <td align="left" style="font-size: 8pt; font-family: Verdana">
                        <%=VehicalNo%>
                    </td>
                </tr>
            </table>
            <br />
           <%-- <table bgcolor="#ffffff" border="0" cellpadding="3" cellspacing="1" class="boxbg"
                colspan="2" style="width: 100%">
                <tr bgcolor="#ffffff">
                    <td align="left" style="width: 210px">
                        <font class="blackfnt"><b><span style="font-size: 8pt; font-family: Verdana">MF No</span></b></font>&nbsp;</td>
                    <td align="left" class="blackfnt" style="width: 169px">
                        <%=TCNO%>
                    </td>
                    <td align="left" style="font-size: 8pt; width: 167px; font-family: Verdana">
                        <font class="blackfnt"><b>Total Packages</b></font></td>
                    <td align="left" style="font-size: 8pt; font-family: Verdana">
                        <font class="blackfnt"></font>
                    </td>
                    <td align="left" style="font-size: 8pt; font-family: Verdana">
                        <b>
                            <%=Total_Pack %>
                        </b>
                    </td>
                </tr>
            </table>
            
            <br />--%>
            <br />
            <asp:Table id="tblunloadsheet"  runat="server" CellPadding="3" CellSpacing="1" style="width: 100%;" CssClass="boxbg">
        
        </asp:Table>
            
            <br />
           <%-- <table border="1" cellspacing="1" cellpadding="1" width="100%">
                <tr style="background-color: White">
                    <td style="width: 5%" align="center">
                        <label class="blackfnt">
                            Sr.No.
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            Docket No./Pay basis&nbsp;</label></td>
                    <td align="center">
                        <label class="blackfnt">
                            Mode/Service Type</label></td>
                    <td align="center">
                        <label class="blackfnt">
                            Booking - Delivery Date
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            Booking - Delivery Location
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            From - To
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            Consignor
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            Consignee
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            Packages
                            <br />
                            Weight L/B
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            Weight
                            <br />
                            L/B Kg
                        </label>
                    </td>
                </tr>
                <asp:Repeater ID="rptDocketList" runat="server">
                    <ItemTemplate>
                        <tr style="background-color: White">
                            <td align="center">
                                <label class="bluefnt">
                                    <%#DataBinder.Eval(Container.DataItem, "SrNo")%>
                                </label>
                            </td>
                            <td align="center">
                                <label class="bluefnt">
                                    <%#DataBinder.Eval(Container.DataItem, "DocketNo")%>
                                </label>
                            </td>
                            <td align="center">
                                <label class="bluefnt">
                                    <%#DataBinder.Eval(Container.DataItem, "Mode")%>
                                </label>
                            </td>
                            <td align="center">
                                <label class="bluefnt">
                                    <%#DataBinder.Eval(Container.DataItem, "DocketDate")%>
                                </label>
                            </td>
                            <td align="center">
                                <label class="bluefnt">
                                    <%#DataBinder.Eval(Container.DataItem, "BookingLocation")%>
                                </label>
                            </td>
                            <td align="center">
                                <label class="bluefnt">
                                    <%#DataBinder.Eval(Container.DataItem, "Location")%>
                                </label>
                            </td>
                            <td align="center">
                                <label class="bluefnt">
                                    <%#DataBinder.Eval(Container.DataItem, "ConsName")%>
                                </label>
                            </td>
                            <td align="center">
                                <label class="bluefnt">
                                    <%#DataBinder.Eval(Container.DataItem, "CoseName")%>
                                </label>
                            </td>
                            <td align="right">
                                <label class="bluefnt">
                                    <%#DataBinder.Eval(Container.DataItem, "PackagesLB")%>
                                </label>
                            </td>
                            <td align="right">
                                <label class="bluefnt">
                                    <%#DataBinder.Eval(Container.DataItem, "WeightLB")%>
                                </label>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
                <tr style="background-color: #FFFFFF" runat="server" id="trForTotalValues">
                    <td colspan="8" align="right">
                        <label class="blackfnt">
                            <b>Total : </b>
                        </label>
                    </td>
                    <td align="right">
                        <asp:Label CssClass="blackfnt" ID="lblPackLB" runat="server">
                        </asp:Label>
                    </td>
                    <td align="right">
                        <asp:Label CssClass="blackfnt" ID="lblWeightLB" runat="server">
                        </asp:Label>
                    </td>
                </tr>
            </table>--%>
            <br />
            <%--<%=strLoadingBranchCode %>
                        &nbsp;&nbsp;<%=strLoadingSheetDateAsItIs %>
                        &nbsp;&nbsp;
                        <%=strLoadingSheetTCDateInTimeFormat %>--%>
            <%--<%=strLoadingBranchCode %>
                        &nbsp;&nbsp;<%=strLoadingSheetDateAsItIs %>&nbsp;&nbsp; 
<%=strLoadingSheetTCDateInTimeFormat %>--%&gt; </TD><TD style="WIDTH: 189px" 
    class="blackfnt" align=center __designer:dtid="281474976710777"></TD><TD 
    style="WIDTH: 155px" align=center __designer:dtid="281474976710778"></TD><TD 
    style="WIDTH: 141px" align=center __designer:dtid="281474976710779"></TD><TD 
    style="WIDTH: 205px" align=center __designer:dtid="281474976710780"><FONT 
      class="blackfnt" __designer:dtid="281474976710781"></FONT></TD><TD 
    class="blackfnt" align=center __designer:dtid="281474976710782"><%--<%=strLoadingSheetPrepBy %>--%>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td colspan="10" align="right">
                        <input type="button" id="btnPrint" value="Print" runat="server" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
