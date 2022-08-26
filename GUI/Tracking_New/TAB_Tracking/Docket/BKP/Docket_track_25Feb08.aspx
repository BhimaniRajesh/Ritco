<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Docket_track.aspx.cs" Inherits="GUI_Tracking_New_TAB_Tracking_Docket_Docket_track" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <link rel="stylesheet" type="text/css" href="tabcontent.css" />
    <link rel="stylesheet" type="text/css" href="../../../images/style.css" />

    <script type="text/javascript" src="tabcontent.js"></script>
<script language="javascript" type="text/javascript">
function OpenPopupWindow1(strDocketNo)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../../../../GUI/Operation/Singlescreen_docketentry/DocketPrint/DocketView_xls.aspx?dockno=" + strDocketNo    
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
            
        }
         function topWindowPOD(strDocketNo1)
        {
        
            var strWinFeature1 = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
             
              var client="<%=Session["Client"]%>"
            var strPopupURL1 = "../../GUI/Operations/FM/FMDocuments/"+client+"/" + strDocketNo1   
           
            winNew = window.open(strPopupURL1, "_blank", strWinFeature1)
            
        }
        
         function topTrackPOD(strDocketNo1)
        {
        
            var strWinFeature1 = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=340,status=no,left=60,top=270"
             
            
            var strPopupURL1 = "./Track_POD.aspx?" + strDocketNo1   
           
            winNew = window.open(strPopupURL1, "_blank", strWinFeature1)
            
        }
        
        function OpenPopupWindow1ls(strDocketNo1,view)
        {
       // alert(strDocketNo1)
            var strWinFeature1 = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
             //alert(strWinFeature1)
            var strPopupURL1 = "../../GUI/Operations/TCS/PrintTCS/ViewAndPrintLoadingSheet.aspx?MFNo=" + strDocketNo1 + ",0"
           
            winNew = window.open(strPopupURL1, "_blank", strWinFeature1)
            
        }
        
        function OpenPopupWindowLS(strLS)
        {
         var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"
            var strURL = "../../GUI/Operations/LoadingSheet/ViewPrint/LoadingSheetSummaryList.aspx?lsno="+strLS  
            winNew = window.open(strURL,"_blank",strWinFeature)
        }
        
        function OpenPopupWindow2(strDocketNo)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../../GUI/Operation/Singlescreen_docketentry/DocketPrint/PaidMR/MR_Summ_Popup.aspx?mrsno=" + strDocketNo    
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        function OpenWindow(strMF,view)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"
            var strURL = "../../GUI/Operations/TCS/PrintTCS/FrmMenifestView.aspx?MFNo=" + strMF + ",0"   
            winNew = window.open(strURL,"_blank",strWinFeature)
        }
        function OpenWindowTHC(strTHC,view)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"
            var strURL = "../../../Operations/THC/ViewPrint/THCViewPrint.aspx?tcno=" + strTHC + "." + ",0" 
            winNew = window.open(strURL,"_blank",strWinFeature)
        }
        function OpenPopupWindowPRS(pdcno,view)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"
            var strPopupURL = "../../GUI/Operations/PRS/PRS_View_Print.aspx?DRSNo=" + pdcno + ",0"  
            winNew = window.open(strURL,"_blank",strWinFeature)
        }
        function OpenWindowDRS(pdcno,view)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../../GUI/Operations/DRS/DRS_View_Print.aspx?DRSNo=" + pdcno + ",0"
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        
        function OpenPopupWindowMR(mrsno)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../../GUI/Operation/Singlescreen_docketentry/DocketPrint/PaidMR/MR_Summ_Popup.aspx?mrsno=" + mrsno    
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
            
        }
        
        function OpenPopupWindowOCTNO(mrsno)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../../GUI/Operation/Singlescreen_docketentry/DocketPrint/PaidMR/MR_Summ_Popup.aspx?mrsno=" + mrsno    
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
            
        }
        function OpenPopupWindowBMNO(mrsno)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../../GUI/Operation/Singlescreen_docketentry/DocketPrint/PaidMR/MR_Summ_Popup.aspx?mrsno=" + mrsno    
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
            
        }
        
         function OpenPopupWindowBillNo(mrsno)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../../GUI/Finance/Billing/BillViewPrint/BillNo_Popup.aspx?Bill_No=" + mrsno    
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
            
        }
</script>
</head>
<body>
    <ul id="countrytabs" class="shadetabs">
        <li><a href="#" rel="country1" class="selected">Summary</a></li>
        <li><a href="#" rel="country2">Life Cycle - Operations</a></li>
        <li><a href="#" rel="country3">Life Cycle - Finance</a></li>
    </ul>
    <div style="border: 1px solid gray; width: 450px; margin-bottom: 1em; padding: 10px">
        <div id="country1" class="tabcontent">
            <table width="95%" border="0" cellpadding="5" cellspacing="1" class="boxbg">
                <tr class="bgbluegrey">
                    <td nowrap align="center" style="height: 28px">
                        <font class="blackfnt">
                            <%=call_dkt%>
                            No.</font></td>
                    <td nowrap align="center" style="height: 28px">
                        <font class="blackfnt">
                            <%=call_dkt%>
                            Date</font></td>
                    <td align="center" style="height: 28px">
                        <font class="blackfnt">Origin</font></td>
                    <td nowrap align="center" style="height: 28px">
                        <font class="blackfnt">Curr Location</font></td>
                    <td  nowrap align="center" style="height: 28px">
                        <font class="blackfnt">Next Location</font></td>
                    <td align="center" style="height: 28px">
                        <font class="blackfnt">Destination</font></td>
                    <td nowrap align="center" style="height: 28px">
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
                    <td align="left" width="40" class="bgbluegrey">
                        <div align="center">
                            <font class="blackfnt">Status </font>
                        </div>
                    </td>
                    <td nowrap align="center" width="30%" bgcolor="#FFFFFF">
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
                                <td nowrap class="bgbluegrey">
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
                                <td nowrap bgcolor="#FFFFFF">
                                    <font class="blackfnt">
                                        <%=Cnor%>
                                    </font>
                                </td>
                            </tr>
                            <tr>
                                <td nowrap class="bgbluegrey">
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
                                <td nowrap class="bgbluegrey">
                                    <font class="blackfnt">Assured Dly. Date</font></td>
                                <td nowrap bgcolor="#FFFFFF">
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
                                <td nowrap class="bgbluegrey">
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
                                <td  nowrap class="bgbluegrey" width="45%">
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
                        <td valign="top" nowrap height="24" align="center">
                            <font class="blackfnt"><b>Arrival
                                <br />
                                Date &amp; Time</b></font></td>
                        <td valign="top" nowrap height="24" align="center">
                            <font class="blackfnt"><b>Departure
                                <br />
                                Date &amp; Time</b></font></td>
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
        <div id="country2" class="tabcontent">
            <asp:Table ID="tblheadache" Visible="true" runat="server" CellPadding="3" CellSpacing="1"
                Style="width: 9.5in;" CssClass="boxbg">
            </asp:Table>
        </div>
        <div id="country3" class="tabcontent">
            <table width="95%" border="0" cellpadding="5" cellspacing="1" class="boxbg">
               <%-- <tr class="bgbluegrey">
                    <td align="center" colspan="6">
                        <font class="blackboldfnt">Life Cycle Finance</font>
                    </td>
                </tr>
                <tr bgcolor="white"">
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
                        <font class="blackfnt">Booking Location</font></td>
                    <td align="center" style="height: 28px">
                        <font class="blackfnt">Delivery Location</font></td>
                    <td align="center" style="height: 28px">
                        <font class="blackfnt">Destination</font></td>
                </tr>
                <tr bgcolor="white"">
                    <td align="center">
                        <font class="blackfnt">
                            <%=lf_dockno%>
                        </font>
                    </td>
                    <td align="center">
                        <font class="blackfnt">
                            <%=lf_dockdt_f%>
                        </font>
                    </td>
                    <td align="center">
                        <font class="blackfnt">
                            <%=lf_orgncd%>
                            -
                            <%=lf_orgnnm%>
                        </font>
                    </td>
                    <td align="center">
                        <font class="blackfnt">
                            <%=lf_destcd%>
                            -
                            <%=lf_destnm%>
                        </font>
                    </td>
                    <td align="center">
                        <font class="blackfnt">
                            <%=lf_re_destcd%>
                        </font>
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <table width="95%" border="0" cellpadding="5" cellspacing="1" class="boxbg">
                <tr class="bgbluegrey">
                    <td align="center" style="text-align: left">
                        <font class="blackfnt"></font>
                    </td>
                    <td align="center">
                        <font class="blackfnt">Status</font></td>
                    <td align="center">
                        <font class="blackfnt">Date</font></td>
                    <td align="center">
                        <font class="blackfnt">Cumulative Days</font></td>
                    <td align="center">
                        <font class="blackfnt">View Document</font></td>
                </tr>
                <%--public static string lo_dkt_status, lo_doc_curloc, lo_dockno, lo_dockdt
, lo_pdc_loc, lo_prs_no, lo_pdc_date, lo_prs_cumm_day, 
lo_ls_status, lo_ls_loc, lo_ls_no, lo_ls_date, lo_ls_cumm_day,
 lo_tc_status,lo_tcbr,lo_tcno,lo_tcdt,lo_tc_cumm_day,
 lo_thc_status,lo_thcbr,lo_thcno,lo_thcdt,lo_thc_cumm_day,
 lo_tohub_br,lo_drs_loc,lo_drs_no,lo_drs_date,lo_drs_cumm_day;--%>
                <tr class="bgbluegrey">
                    <td class="blackfnt" align="center" style="text-align: left">
                        Activity At</td>
                    <td colspan="4" align="center">
                        <font class="blackfnt">
                            <%=lf_orgncd%>
                            :
                            <%=lf_orgnnm%>
                        </font>
                    </td>
                </tr>
                <tr bgcolor="white"">
                    <td class="bgbluegrey" align="center" style="text-align: left; height: 29px;">
                        <font class="blackfnt">Booked</font></td>
                    <td align="center" style="height: 29px">
                        <font class="blackfnt">
                            <%=lf_paybasnm%>
                        </font>
                    </td>
                    <td align="center" style="height: 29px">
                        <font class="blackfnt">
                            <%=lf_dockdt_f%>
                        </font>
                    </td>
                    <td align="center" style="height: 29px">
                        <font class="blackfnt">
                            <%=lf_book_cum_days%>
                        </font>
                    </td>
                    <td align="center" style="height: 29px">
                        <font class="blackfnt"><a href="JavaScript:OpenPopupWindow1('<%=lf_dockno%>')">
                            <%=lf_dockno%>
                            <%=lf_docksf%>
                        </a></font>
                    </td>
                </tr>
                <%--
    if (lo_ls_no != "" && lo_ls_no != null)
    {
    
    --%>
                <tr bgcolor="white"">
                    <td class="bgbluegrey" align="center" style="text-align: left; height: 29px;">
                        <font class="blackfnt">Bill Generated</font></td>
                    <td align="center" style="height: 29px">
                        <font class="blackfnt">
                            <%=lf_msg_b%>
                        </font>
                    </td>
                    <td align="center" style="height: 29px">
                        <font class="blackfnt">
                            <%=lf_bgndt_f%>
                        </font>
                    </td>
                    <td align="center" style="height: 29px">
                        <font class="blackfnt">
                            <%=lf_bill_cum_days%>
                        </font>
                    </td>
                    <td align="center" style="height: 29px">
                        <font class="blackfnt">
                            <%=lf_billno%>
                        </font>
                    </td>
                </tr>
                <%--
    }
    if (lo_tcno != "" && lo_tcno != null)
    {
    
    --%>
                <%if (lf_billsubbrcd != "")
                  { %>
                <tr bgcolor="white"">
                    <td class="bgbluegrey" align="center" style="height: 29px; text-align: left">
                        <font class="blackfnt">Activity At</font></td>
                    <td colspan="4" align="center" style="height: 29px">
                        <font class="blackfnt">
                            <%=lf_billsubbrcd%>
                            :
                            <%=lf_billsubbrnm%>
                        </font>
                    </td>
                </tr>
                <%--
    }
    if (lo_thcno != "" && lo_thcno != null)
    {
    --%>
                <tr bgcolor="white"">
                    <td class="bgbluegrey" align="center" style="text-align: left">
                        <font class="blackfnt">Bill Submitted</font></td>
                    <td align="center">
                        <font class="blackfnt">
                            <%=lf_msg_sun%>
                        </font>
                    </td>
                    <td align="center">
                        <font class="blackfnt">
                            <%=lf_bsbdt_f%>
                        </font>
                    </td>
                    <td align="center">
                        <font class="blackfnt">
                            <%=lf_billsub_cum_days%>
                        </font>
                    </td>
                    <td align="center">
                        <font class="blackfnt"></font>
                    </td>
                </tr>
                <% }%>
                <%--
    }
    if (lo_doc_curloc != lo_tohub_br)
    {
    --%>
                <%if (lf_billcolbrnm != "")
                  {%>
                <tr bgcolor="white"">
                    <td class="bgbluegrey" align="center" style="text-align: left">
                        <font class="blackfnt">Activity At</font></td>
                    <td colspan="5" align="center">
                        <font class="blackfnt">
                            <%=lf_billcolbrnm%>
                        </font>
                    </td>
                </tr>
                <%--lo_drs_loc,lo_drs_no,lo_drs_date,lo_drs_cumm_day--%>
                <%--
    }
    if (lo_prs_no != "" && lo_prs_no != null)
    {
    
    --%>
                <tr bgcolor="white"">
                    <td class="bgbluegrey" align="center" style="text-align: left">
                        <font class="blackfnt">Bill Collected</font></td>
                    <td align="center">
                        <font class="blackfnt">
                            <%=lf_msg_sun%>
                        </font>
                    </td>
                    <td align="center">
                        <font class="blackfnt">
                            <%=lf_mrsdt_f%>
                        </font>
                    </td>
                    <td align="center">
                        <font class="blackfnt">
                            <%=lf_billmrcol_cum_days%>
                        </font>
                    </td>
                    <td align="center">
                        <font class="blackfnt"><a href="JavaScript:OpenPopupWindow2('<%=lf_mrsno%>')">
                            <%=lf_mrsno%>
                            <%=lf_mrssf%>
                        </a></font>
                    </td>
                </tr>
                <%} %>
                <%--
    }
    if (lo_drs_no != "" && lo_drs_no != null)
    {
    --%>
            </table>
            <br />
            <br />
            <table width="95%" border="0" cellpadding="5" cellspacing="1" class="boxbg">
                <tr class="bgbluegrey">
                    <td align="center" style="text-align: left">
                        <font class="blackfnt"></font>
                    </td>
                    <td align="center">
                        <font class="blackfnt">Status</font></td>
                    <td align="center">
                        <font class="blackfnt">Date</font></td>
                    <td align="center">
                        <font class="blackfnt">Cumulative Days</font></td>
                    <td align="center">
                        <font class="blackfnt">View Document</font></td>
                </tr>
                <tr class="bgbluegrey">
                    <td class="blackfnt" align="center" style="text-align: left">
                        Activity At</td>
                    <td colspan="4" align="center">
                        <font class="blackfnt">
                            <%=lf_orgncd%>
                            :<%=lf_orgnnm%></font>
                    </td>
                </tr>
                <tr bgcolor="white"">
                    <td class="bgbluegrey" align="center" style="text-align: left">
                        <font class="blackfnt">Booked</font></td>
                    <td align="center">
                        <font class="blackfnt">
                            <%=lf_paybasnm%>
                        </font>
                    </td>
                    <td align="center">
                        <font class="blackfnt">
                            <%=lf_dockdt_f%>
                        </font>
                    </td>
                    <td align="center">
                        <font class="blackfnt">
                            <%=lf_book_cum_days%>
                        </font>
                    </td>
                    <td align="center">
                        <%--<font class=blackfnt><%=lf_dockno%><%=lf_docksf%></font>--%>
                        <font class="blackfnt"><a href="JavaScript:OpenPopupWindow1('<%=lf_dockno%>')">
                            <%=lf_dockno%>
                            <%=lf_docksf%>
                        </a></font>
                    </td>
                </tr>
                <%--
    }
    if (lo_ls_no != "" && lo_ls_no != null)
    {
    
 --%>
                <%if (IF_MRSNOYN != "No")
                  { %>
                <tr bgcolor="white"">
                    <td class="bgbluegrey" align="center" style="text-align: left">
                        <font class="blackfnt">MR Generated Freight</font></td>
                    <td align="center">
                        <font class="blackfnt">
                            <%=IF_MRSNOYN%>
                        </font>
                    </td>
                    <td align="center">
                        <font class="blackfnt">
                            <%=lf_mrsdt_f%>
                        </font>
                    </td>
                    <td align="center">
                        <font class="blackfnt">
                            <%=lf_mr_cum_days%>
                        </font>
                    </td>
                    <td align="center">
                        <font class="blackfnt"><font class="blackfnt"><a href="JavaScript:OpenPopupWindow2('<%=lf_mrsno%>')">
                            <%=lf_mrsno%>
                        </a></font>
                    </td>
                </tr>
                <%} %>
                <%--
    }
    if (lo_tcno != "" && lo_tcno != null)
    {
    
--%>
                <%if (lf_msg_mrcoll != "No")
                  { %>
                <tr bgcolor="white"">
                    <td class="bgbluegrey" align="center" style="height: 29px; text-align: left">
                        <font class="blackfnt">MR Collected</font></td>
                    <td align="center" style="height: 29px">
                        <font class="blackfnt">
                            <%=lf_msg_mrcoll%>
                        </font>
                    </td>
                    <td align="center" style="height: 29px">
                        <font class="blackfnt">
                            <%=lf_finclosedt_f%>
                        </font>
                    </td>
                    <td align="center" style="height: 29px">
                        <font class="blackfnt">
                            <%=lf_mrcol_cum_days%>
                        </font>
                    </td>
                    <td align="center" style="height: 29px">
                        <font class="blackfnt"></font>
                    </td>
                </tr>
                <%}%>
                <%--
    }
    if (lo_thcno != "" && lo_thcno != null)
    {
--%>
                <%if (lf_Gen_oct != "No")
                  { %>
                <tr bgcolor="white"">
                    <td class="bgbluegrey" align="center" style="text-align: left">
                        <font class="blackfnt">MR Generated Octroi</font></td>
                    <td align="center">
                        <font class="blackfnt">Yes</font></td>
                    <td align="center">
                        <font class="blackfnt">
                            <%=lf_mrsdt_f%>
                        </font>
                    </td>
                    <td align="center">
                        <font class="blackfnt">
                            <%=lf_mr_cum_days%>
                        </font>
                    </td>
                    <td align="center">
                        <font class="blackfnt">
                            <%=lf_mrsno%>
                        </font>
                    </td>
                </tr>
                <%} %>
                <%--
    }
    if (lo_doc_curloc != lo_tohub_br)
    {
--%>
                <%--
    }
    if (lo_prs_no != "" && lo_prs_no != null)
    {    
--%>
                <%if (lf_msg_mrcoll != "No" && lf_Gen_oct != "No")
                  { %>
                <tr bgcolor="white"">
                    <td class="bgbluegrey" align="center" style="text-align: left">
                        <font class="blackfnt">MR Collected</font></td>
                    <td align="center">
                        <font class="blackfnt">
                            <%=lf_msg_mrcoll%>
                        </font>
                    </td>
                    <td align="center">
                        <font class="blackfnt">
                            <%=lf_finclosedt_f%>
                        </font>
                    </td>
                    <td align="center">
                        <font class="blackfnt">
                            <%=lf_mrcol_cum_days%>
                        </font>
                    </td>
                    <td align="center">
                        <font class="blackfnt"></font>
                    </td>
                </tr>
                <%} %>
                <%--
    }
--%>
            </table>
        </div>
        <div id="country4" class="tabcontent">
            Tab content 4 here<br />
            Tab content 4 here<br />
        </div>
    </div>

    <script type="text/javascript">

var countries=new ddtabcontent("countrytabs")
countries.setpersist(true)
countries.setselectedClassTarget("link") //"link" or "linkparent"
countries.init()

    </script>

    <div align="left">
        <a href="javascript:countries.cycleit('prev')" style="margin-right: 25px; text-decoration: none">
           <%--<img src="roundleft.gif" runat="server"  /> --%><b>Back</b></a>
        <%--<a href="javascript: countries.expandit(3)">Click here to select last tab</a>--%>
        <a href="javascript:countries.cycleit('next')" style="margin-left: 25px; text-decoration: none">
           <%-- <img id="Img1" src="roundright.gif" runat="server"  height="5" />--%><b>Forward</b></a></div>
    <hr />

    <script type="text/javascript">

var mypets=new ddtabcontent("pettabs")
mypets.setpersist(true)
mypets.setselectedClassTarget("link")
mypets.init(2000)


    </script>

</body>
</html>
