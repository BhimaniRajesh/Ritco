<table width="95%" border="0" cellpadding="5" cellspacing="1" class=boxbg>
    <tr class="bgbluegrey">
        <td align="center" colspan="6"><font class="blackboldfnt">View & Print</font>
        </td>
    </tr>
    <tr bgcolor="white"">
        <td align="center" colspan="6">
        </td>
    </tr>
<tr class=bgbluegrey><td align="center"><font class=blackfnt>Document </font></td>
                          <td align="center"><font class=blackfnt>Document No.</font></td>
                          <td align="center"><font class=blackfnt>Start location</font></td>
                          <td align="center"><font class=blackfnt>Date</font></td>
                          <td align="center"><font class=blackfnt>View</font></td>
                          <td align="center"><font class=blackfnt>Print</font></td></tr>
<tr bgcolor="white""><td class="bgbluegrey"  align="center"><font class=blackfnt>Docket</font></td>
<td align="center"><font class=blackfnt><%=dockno1%></font></td>
<td align="center"><font class=blackfnt><%=orgncd%></font></td>
<td align="center"><font class=blackfnt><%=dockdt%></font></td>
<td align="center"><font class=blackfnt><a href="JavaScript:OpenPopupWindow1('<%=dockno1%>')">View</a></font></td>
<td align="center"><font class=blackfnt><a href="JavaScript:OpenPopupWindow1('<%=dockno1%>')">Print</a></font></td>
</tr>
<%
    if (prs_no != "" && prs_no != null)
    {
    
%><tr bgcolor="white"><td class="bgbluegrey"  align="center"><font class=blackfnt>PRS</font></td>
<td align="center"><font class=blackfnt><%=prs_no%></font></td>
<td align="center"><font class=blackfnt><%=prs_loc%></font></td>
<td align="center"><font class=blackfnt><%=prs_date%></font></td>
<td align="center"><font class=blackfnt><a href="JavaScript:OpenPopupWindowPRS('<%=prs_no%>')">View</a></font></td>
<td align="center"><font class=blackfnt><a href="JavaScript:OpenPopupWindowPRS('<%=prs_no%>')">Print</a></font></td>
</tr>   
<%
   } 
   if (tcno != "" && tcno != null)
    {

%>

<tr bgcolor="white""><td class="bgbluegrey" align="center"><font class=blackfnt>Last Manefest</font></td>
<td align="center"><font class=blackfnt><%=tcno%></font></td>
<td align="center"><font class=blackfnt><%=tcbr%></font></td>
<td align="center"><font class=blackfnt><%=tcdt%></font></td>
<td align="center"><font class=blackfnt><a href="JavaScript:OpenWindow('<%=tcno%>')">View</a></font></td>
<td align="center"><font class=blackfnt><a href="JavaScript:OpenWindow('<%=tcno%>')">Print</a></font></td>
</tr>
<%
    }
    if (thcno != "" && thcno != null)
    {
%><tr bgcolor="white""><td class="bgbluegrey"  align="center"><font class=blackfnt>Last THC</font></td>
<td align="center"><font class=blackfnt><%=thcno%></font></td>
<td align="center"><font class=blackfnt><%=thcbr%></font></td>
<td align="center"><font class=blackfnt><%=thcdt%></font></td>
<td align="center"><font class=blackfnt><a href="JavaScript:OpenWindowTHC('<%=thcno%>')">View</a></font></td>
<td align="center"><font class=blackfnt><a href="JavaScript:OpenWindowTHC('<%=thcno%>')">Print</a></font></td>
</tr><%
    }
    if (drs_no != "" && drs_no != null)
    {
%><tr bgcolor="white""><td class="bgbluegrey"  align="center"><font class=blackfnt>DRS- Attempt 1</font></td>
<td align="center"><font class=blackfnt><%=drs_no%></font></td>
<td align="center"><font class=blackfnt><%=drs_loc%></font></td>
<td align="center"><font class=blackfnt><%=drs_date%></font></td>
<td align="center"><font class=blackfnt><a href="JavaScript:OpenWindowDRS('<%=drs_no%>')">View</a></font></td>
<td align="center"><font class=blackfnt><a href="JavaScript:OpenWindowDRS('<%=drs_no%>')">Print</a></font></td>
</tr><%
    }
    if (Bill_no != "" && Bill_no != null)
    {
%><tr bgcolor="white""><td class="bgbluegrey" align="center"><font class=blackfnt>Bill No.</font></td>
<td align="center"><font class=blackfnt><%=Bill_no%></font></td>
<td align="center"><font class=blackfnt><%=Bill_loc%></font></td>
<td align="center"><font class=blackfnt><%=Bill_date%></font></td>
<td align="center"><font class=blackfnt><a href="JavaScript:OpenPopupWindowBillNo('<%=Bill_no%>')">View</a></font></td>
<td align="center"><font class=blackfnt><a href="JavaScript:OpenPopupWindowBillNo('<%=Bill_no%>')">Print</a></font></td>
</tr><%
    }
    if (mr_no != ""  && mr_no != null)
    {
%><tr bgcolor="white""><td class="bgbluegrey"  align="center"><font class=blackfnt>Money Receipt</font></td>
<td align="center"><font class=blackfnt><%=mr_no%></font></td>
<td align="center"><font class=blackfnt><%=mr_loc%></font></td>
<td align="center"><font class=blackfnt><%=mr_date%></font></td>
<td align="center"><font class=blackfnt><a href="JavaScript:OpenPopupWindowMR('<%=mr_no%>')">View</a></font></td>
<td align="center"><font class=blackfnt><a href="JavaScript:OpenPopupWindowMR('<%=mr_no%>')">Print</a></font></td>
</tr><%
    }
    if (oct_v_no != ""  && oct_v_no != null)
    {
%><tr bgcolor="white""><td class="bgbluegrey"  align="center"><font class=blackfnt>Octroi Payment Voucher</font></td>
<td align="center"><font class=blackfnt><%=oct_v_no%></font></td>
<td align="center"><font class=blackfnt><%=oct_v_loc%></font></td>
<td align="center"><font class=blackfnt><%=oct_v_date%></font></td>
<td align="center"><font class=blackfnt><a href="JavaScript:OpenPopupWindow1('<%=oct_v_no%>')">View</a></font></td>
<td align="center"><font class=blackfnt><a href="JavaScript:OpenPopupWindow1('<%=oct_v_no%>')">Print</a></font></td>
</tr><%
    }
    if (oct_BM_no != ""  && oct_BM_no != null)
    {
%><tr bgcolor="white""><td class="bgbluegrey"  align="center"><font class=blackfnt><%=oct_BM_st%></font></td>
<td align="center"><font class=blackfnt><%=oct_BM_no%></font></td>
<td align="center"><font class=blackfnt><%=oct_BM_loc%></font></td>
<td align="center"><font class=blackfnt><%=oct_BM_date%></font></td>
<td align="center"><font class=blackfnt><a href="JavaScript:OpenPopupWindow1('<%=oct_BM_no%>')">View</a></font></td>
<td align="center"><font class=blackfnt><a href="JavaScript:OpenPopupWindow1('<%=oct_BM_no%>')">Print</a></font></td>
</tr><%
    }
    
%></table>
