<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Docket_Fin_Cycle.aspx.cs" Inherits="GUI_Tracking_New_TAB_Tracking_Docket_Docket_Fin_Cycle" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table width="95%" border="0" cellpadding="5" cellspacing="1" class=boxbg>
<tr class="bgbluegrey">
        <td align="center" colspan="6"><font class="blackboldfnt">Life Cycle Finance</font>
        </td>
    </tr>
    <tr bgcolor="white"">
        <td align="center" colspan="6">
        </td>
    </tr>
<tr class=bgbluegrey><td align="center" style="height: 28px"><font class=blackfnt><%=call_dkt%> No.</font></td>
                          <td align="center" style="height: 28px"><font class=blackfnt><%=call_dkt%> Date</font></td>
                          <td align="center" style="height: 28px"><font class=blackfnt>Booking Location</font></td>
                          <td align="center" style="height: 28px"><font class=blackfnt>Delivery Location</font></td>
                          <td align="center" style="height: 28px"><font class=blackfnt>Destination</font></td></tr>
                          
                          
<tr bgcolor="white""><td align="center"><font class=blackfnt><%=lf_dockno%></font></td>
<td align="center"><font class=blackfnt><%=lf_dockdt_f%></font></td>
<td align="center"><font class=blackfnt><%=lf_orgncd%> - <%=lf_orgnnm%></font></td>
<td align="center"><font class=blackfnt><%=lf_destcd%> - <%=lf_destnm%></font></td>
<td align="center"><font class=blackfnt><%=lf_re_destcd%></font></td>
</tr>
</table>
<br />
<br />
<table width="95%" border="0" cellpadding="5" cellspacing="1" class=boxbg>
    <tr class=bgbluegrey>
        <td align="center" style="text-align: left">
            <font class=blackfnt></font></td>
        <td align="center">
            <font class=blackfnt>Status</font></td>
        <td align="center">
            <font class=blackfnt>Date</font></td>
        <td align="center">
            <font class=blackfnt>Cumulative Days</font></td>
        <td align="center">
            <font class=blackfnt>View Document</font></td>
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
        <font class=blackfnt>
                <%=lf_orgncd%>
                :
                <%=lf_orgnnm%>
        </font>
        </td>
    </tr>
    <tr bgcolor="white"">
        <td class="bgbluegrey"  align="center" style="text-align: left; height: 29px;">
            <font class=blackfnt>Booked</font></td>
        <td align="center" style="height: 29px">
            <font class=blackfnt>
                <%=lf_paybasnm%>
            </font>
        </td>
        <td align="center" style="height: 29px">
            <font class=blackfnt>
                <%=lf_dockdt_f%>
            </font>
        </td>
        <td align="center" style="height: 29px">
            <font class=blackfnt>
                <%=lf_book_cum_days%>
            </font>
        </td>
        <td align="center" style="height: 29px">
            <font class=blackfnt><a href="JavaScript:OpenPopupWindow1('<%=lf_dockno%>')"> 
            <%=lf_dockno%><%=lf_docksf%> 
            </a></font>
        </td>
    </tr>
    <%--
    if (lo_ls_no != "" && lo_ls_no != null)
    {
    
    --%><tr bgcolor="white"">
        <td class="bgbluegrey"  align="center" style="text-align: left; height: 29px;">
            <font class=blackfnt>Bill Generated</font></td>
        <td align="center" style="height: 29px">
            <font class=blackfnt>
                <%=lf_msg_b%>
            </font>
        </td>
        <td align="center" style="height: 29px">
            <font class=blackfnt>
                <%=lf_bgndt_f%>
            </font>
        </td>
        <td align="center" style="height: 29px">
            <font class=blackfnt>
                <%=lf_bill_cum_days%>
            </font>
        </td>
        <td align="center" style="height: 29px">
            <font class=blackfnt>
                <%=lf_billno%>
            </font>
        </td>
    </tr>
    <%--
    }
    if (lo_tcno != "" && lo_tcno != null)
    {
    
    --%><%if(lf_billsubbrcd!="")
    { %><tr bgcolor="white"">
        <td class="bgbluegrey" align="center" style="height: 29px; text-align: left">
            <font class=blackfnt>Activity At</font></td>
        <td colspan="4" align="center" style="height: 29px">
            <font class=blackfnt>
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
    --%><tr bgcolor="white"">
        <td class="bgbluegrey"  align="center" style="text-align: left">
            <font class=blackfnt>Bill Submitted</font></td>
        <td align="center">
            <font class=blackfnt>
                <%=lf_msg_sun%>
            </font>
        </td>
        <td align="center">
            <font class=blackfnt>
                <%=lf_bsbdt_f%>
            </font>
        </td>
        <td align="center">
            <font class=blackfnt>
                <%=lf_billsub_cum_days%>
            </font>
        </td>
        <td align="center">
            <font class=blackfnt>
            </font>
        </td>
    </tr>
    <% }%>
   
    <%--
    }
    if (lo_doc_curloc != lo_tohub_br)
    {
    --%><%if(lf_billcolbrnm !="")
    {%>
    <tr bgcolor="white"">
        <td class="bgbluegrey"  align="center" style="text-align: left">
            <font class=blackfnt>Activity At</font></td>
        <td colspan="5" align="center">
            <font class=blackfnt>
                <%=lf_billcolbrnm%>
            </font>
        </td>
    </tr>
    <%--lo_drs_loc,lo_drs_no,lo_drs_date,lo_drs_cumm_day--%>
    <%--
    }
    if (lo_prs_no != "" && lo_prs_no != null)
    {
    
    --%><tr bgcolor="white"">
        <td class="bgbluegrey" align="center" style="text-align: left">
            <font class=blackfnt>Bill Collected</font></td>
        <td align="center">
            <font class=blackfnt>
                <%=lf_msg_sun%>
            </font>
        </td>
        <td align="center">
            <font class=blackfnt>
                <%=lf_mrsdt_f%>
            </font>
        </td>
        <td align="center">
            <font class=blackfnt>
                <%=lf_billmrcol_cum_days%>
            </font>
        </td>
        <td align="center">
            
            <font class="blackfnt"><a href="JavaScript:OpenPopupWindow2('<%=lf_mrsno%>')"> 
                <%=lf_mrsno%>
                <%=lf_mrssf%></a>
            </font>
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
<table width="95%" border="0" cellpadding="5" cellspacing="1" class=boxbg>
<tr class=bgbluegrey><td align="center" style="text-align: left"><font class=blackfnt></font></td>
                          <td align="center"><font class=blackfnt>Status</font></td>
                          <td align="center"><font class=blackfnt>Date</font></td>
                          <td align="center"><font class=blackfnt>Cumulative Days</font></td>
                          <td align="center"><font class=blackfnt>View Document</font></td></tr>
    <tr class="bgbluegrey">
        <td class="blackfnt" align="center" style="text-align: left">
            Activity At</td>
        <td colspan="4" align="center"><font class=blackfnt><%=lf_orgncd%>:<%=lf_orgnnm%></font>
        </td>
    </tr>
<tr bgcolor="white""><td class="bgbluegrey"  align="center" style="text-align: left"><font class=blackfnt>Booked</font></td>
<td align="center"><font class=blackfnt><%=lf_paybasnm%></font></td>
<td align="center"><font class=blackfnt><%=lf_dockdt_f%></font></td>
<td align="center"><font class=blackfnt><%=lf_book_cum_days%></font></td>
<td align="center">
<%--<font class=blackfnt><%=lf_dockno%><%=lf_docksf%></font>--%>
<font class=blackfnt><a href="JavaScript:OpenPopupWindow1('<%=lf_dockno%>')"> 
            <%=lf_dockno%><%=lf_docksf%> 
            </a></font>
</td>
</tr>

<%--
    }
    if (lo_ls_no != "" && lo_ls_no != null)
    {
    
 --%>
 <%if(IF_MRSNOYN != "No")
 { %>
<tr bgcolor="white""><td class="bgbluegrey"  align="center" style="text-align: left"><font class=blackfnt>MR Generated Freight</font></td>
<td align="center"><font class=blackfnt><%=IF_MRSNOYN%></font></td>
<td align="center"><font class=blackfnt><%=lf_mrsdt_f%></font></td>
<td align="center"><font class=blackfnt><%=lf_mr_cum_days%></font></td>
<td align="center"><font class=blackfnt>
<font class="blackfnt"><a href="JavaScript:OpenPopupWindow2('<%=lf_mrsno%>')"><%=lf_mrsno%></a>
</font></td>
</tr>
<%} %>
<%--
    }
    if (lo_tcno != "" && lo_tcno != null)
    {
    
--%><%if(lf_msg_mrcoll!="No")
{ %><tr bgcolor="white""><td class="bgbluegrey" align="center" style="height: 29px; text-align: left"><font class=blackfnt>MR Collected</font></td>
<td align="center" style="height: 29px"><font class=blackfnt><%=lf_msg_mrcoll%></font></td>
<td align="center" style="height: 29px"><font class=blackfnt><%=lf_finclosedt_f%></font></td>
<td align="center" style="height: 29px"><font class=blackfnt><%=lf_mrcol_cum_days%></font></td>
<td align="center" style="height: 29px"><font class=blackfnt></font></td>
</tr>
<%}%> 
<%--
    }
    if (lo_thcno != "" && lo_thcno != null)
    {
--%>
<%if(lf_Gen_oct!="No")
{ %>
<tr bgcolor="white""><td class="bgbluegrey"  align="center" style="text-align: left"><font class=blackfnt>MR Generated Octroi</font></td>
<td align="center"><font class=blackfnt>Yes</font></td>
<td align="center"><font class=blackfnt><%=lf_mrsdt_f%></font></td>
<td align="center"><font class=blackfnt><%=lf_mr_cum_days%></font></td>
<td align="center"><font class=blackfnt><%=lf_mrsno%></font></td>
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
<%if(lf_msg_mrcoll!="No" && lf_Gen_oct!="No")
{ %>
<tr bgcolor="white""><td class="bgbluegrey" align="center" style="text-align: left"><font class=blackfnt>MR Collected</font></td>
<td align="center"><font class=blackfnt><%=lf_msg_mrcoll%></font></td>
<td align="center"><font class=blackfnt><%=lf_finclosedt_f%></font></td>
<td align="center"><font class=blackfnt><%=lf_mrcol_cum_days%></font></td>
<td align="center"><font class=blackfnt></font></td>
</tr>
<%} %>
<%--
    }
--%>
</table>
    </div>
    </form>
</body>
</html>
