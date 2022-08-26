<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewAndPrintLoadingSheet.aspx.cs"
    Inherits="GUI_Operations_TCS_PrintTCS_ViewAndPrintLoadingSheet" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>View & Print Loading Sheet </title>
    <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />

    <script language="javascript" type="text/javascript">
            
            function OpenInWindow(windURL,h, w, l, t)
            {
		        var winOpts = "scrollbars=yes,resizable=yes,width="+w+",height="+h+"";
    		    
		        window.open(windURL,"", winOpts);
	        }
            
    </script>

</head>
<body>
    <form id="frmLoadingSheet" runat="server">
    
    <% string strMFNO = Request.QueryString.Get("MFNo");
       string[] Split = strMFNO.Split(new Char[] { ',' });
           string mfno = Convert.ToString(Split[0]);
           string print_yn = Convert.ToString(Split[1]);
           string boxbg = "boxbg";
           string bgbluegrey = "bgbluegrey";
           string strborder = "0";
           string strspace = "1";
           string strfnt = "bluefnt";
              if (print_yn == "1")
              {
                   boxbg = "";
                   bgbluegrey = "bgwhite";
                   strborder = "1";
                   strspace = "1";
                   strfnt = "blackfnt";
              }

      %>
    
    
        <div>
            <table  border='<%=strborder %>'  cellspacing='<%=strspace %>' cellpadding="0"  class='<%=boxbg %>' colspan="2" width="100%">
                <tr bgcolor="white">
                    <td align="left" rowspan="3" style="width: 62%">
                        <asp:Image ID="imgLogo" runat="server" ImageUrl="~/GUI/images/webxpress_logo.gif" /><br />
                        <br />
                        <strong><span style="font-size: 8pt; font-family: Verdana">LOADING SHEET</span></strong></td>
                    <td align="left">
                        <font class="blackfnt"><b><span style="font-size: 8pt; font-family: Verdana">LS No</span></b></font></td>
                    <td align="left" style="font-size: 8pt; width: 210px; font-family: Verdana">
                        <font class="blackfnt">&nbsp;<%=strLoadingSheetNo %></font></td>
                </tr>
                <tr bgcolor="#ffffff" style="font-weight: bold; font-size: 8pt; font-family: Verdana">
                    <td align="left" style="width: 16%">
                        <font class="blackfnt"><b>LS Date</b></font></td>
                    <td align="left" style="width: 210px">
                        <font class="blackfnt">&nbsp;<%=strLoadingSheetDateAsItIs%></font></td>
                </tr>
                <tr bgcolor="#ffffff" style="font-weight: bold; font-size: 8pt; font-family: Verdana">
                    <td align="left" style="width: 16%" class="blackfnt">
                        <b>Manual LS No</b></td>
                    <td align="left" style="width: 210px">
                        <font class="blackfnt"></font>
                    </td>
                </tr>
            </table>
            <br />
            <table  border='<%=strborder %>' cellspacing='<%=strspace %>' cellpadding="0"  class='<%=boxbg %>'
                colspan="2" style="width: 100%">
                <tr bgcolor="#ffffff">
                    <td align="left" style="width: 119px">
                        <font class="blackfnt"><b><span style="font-size: 8pt; font-family: Verdana">From To</span></b></font>
                    </td>
                    <td align="Left" style="width: 154px" class="blackfnt">
                        <%=strLoadingBranch %>
                    </td>
                    <td align="Left" style="width: 120px">
                        <font class="blackfnt"><b><span style="font-size: 8pt; font-family: Verdana">Vehicle
                            No.</span></b></font></td>
                    <td align="Left" style="font-size: 8pt; width: 87px; font-family: Verdana">
                        <%=strLoadingVehicle %>
                    </td>
                    <td align="Left" style="font-size: 8pt; width: 125px; font-family: Verdana">
                        <font class="blackfnt"><b>Total Packages</b></font></td>
                    <td align="Left" style="font-size: 8pt; font-family: Verdana; width: 166px;">
                        <font class="blackfnt"></font>
                    </td>
                    <td align="Left" style="font-size: 8pt; font-family: Verdana"><b>
                    <%=Total_Pack %></b>
                    </td>
                </tr>
            </table>
            <br />
            <table border='<%=strborder %>' cellspacing='<%=strspace %>' cellpadding="0" class='<%=boxbg %>' width="100%">
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
                                <label class="blackfnt">
                                    <%#DataBinder.Eval(Container.DataItem, "SrNo")%>
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    <%#DataBinder.Eval(Container.DataItem, "DocketNo")%>
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "Mode")%>
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    <%#DataBinder.Eval(Container.DataItem, "DocketDate")%>
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    <%#DataBinder.Eval(Container.DataItem, "BookingLocation")%>
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    <%#DataBinder.Eval(Container.DataItem, "LocationTo")%>
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    <%#DataBinder.Eval(Container.DataItem, "ConsName")%>
                                </label>
                            </td>
                            <td align="center">
                                <label class="blackfnt">
                                    <%#DataBinder.Eval(Container.DataItem, "CosgName")%>
                                </label>
                            </td>
                            <td align="right">
                                <label class="blackfnt">
                                    <%#DataBinder.Eval(Container.DataItem, "PackagesLB")%>
                                </label>
                            </td>
                            <td align="right">
                                <label class="blackfnt">
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
                    <td>
                        <asp:Label CssClass="blackfnt" ID="lblPackage" runat="server">
                        </asp:Label>
                    </td>
                    <td>
                        <asp:Label CssClass="blackfnt" ID="lblWeight" runat="server">
                        </asp:Label>
                    </td>
                </tr>
            </table>
            <br />
            <table  border='<%=strborder %>' cellspacing='<%=strspace %>' cellpadding="0"  class='<%=boxbg %>'
                colspan="2" style="width: 100%">
                <tr bgcolor="#ffffff">
                    <td align="center" style="width: 140px">
                        <font class="blackfnt"><b><span style="font-size: 8pt; font-family: Verdana">Prepared
                            At - Date</span></b></font>
                    </td>
                    <td align="center" style="width: 169px">
                        <font class="blackfnt"><b><span style="font-size: 8pt; font-family: Verdana">Prepared
                            by Staff Name</span></b></font>&nbsp;</td>
                    <td align="center" style="width: 120px">
                        <font class="blackfnt"><b><span style="font-size: 8pt; font-family: Verdana">Approval
                            Sign</span></b></font></td>
                    <td align="center" style="font-size: 8pt; width: 104px; font-family: Verdana">
                        <font class="blackfnt"><b>Driver Sign</b></font></td>
                    <td align="center" style="font-size: 8pt; width: 167px; font-family: Verdana">
                        <font class="blackfnt"><b>Entered At - Date</b></font></td>
                    <td align="center" style="font-size: 8pt; font-family: Verdana">
                        <b>Entered by</b>
                    </td>
                </tr>
                <tr align="center" bgcolor="#ffffff">
                    <td align="center" style="width: 140px" class="blackfnt">
                        <%--<%=strLoadingBranchCode %>
                        &nbsp;&nbsp;<%=strLoadingSheetDateAsItIs %>
                        &nbsp;&nbsp;
                        <%=strLoadingSheetTCDateInTimeFormat %>--%>
                    </td>
                    <td align="center" style="width: 169px" class="blackfnt">
                    <%--<%=strLoadingSheetPrepBy %>--%>
                    </td>
                    <td align="center" style="width: 120px">
                    </td>
                    <td align="center" style="width: 104px">
                    </td>
                    <td align="center" style="width: 167px" class="blackfnt">
                        <%=strEnterAt%>
                    </td>
                    <td align="center" class="blackfnt">
                      <%=strEnterBy %>  
                    </td>
                </tr>
            </table>
            <br />
            <br />
           <%-- <table border='<%=strborder %>' cellspacing='<%=strspace %>' width="100%"  cellpadding="0">
                <tr>
                    <td colspan="10" align="right">
                        <input type="button" id="btnPrint" value="Print" runat="server" visible="false"/>
                    </td>
                </tr>
            </table>--%>
            <%
         if (print_yn == "1")
       {
         
       %>
        <script language="javascript" type="text/javascript">
       
        function loadme()
        {
            window.print();
        }
       window.load =loadme()
        </script>
       <%} %>        
        </div>
    </form>
</body>
</html>
