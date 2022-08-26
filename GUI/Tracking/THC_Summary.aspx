<table BORDER ="0"  style="width:8.in" align=center BGCOLOR="#808080" cellspacing="1" cellpadding="2" class="boxbg">
  <tr > 
    <td align="center" class="bgbluegrey"><font class="blackfnt"><%=call_thc %> no. | Start date</font></td>
    <td align="center"  bgcolor="#FFFFFF" ><font class="blackfnt"><%=thcno%><%=thcsf%> | <%=thcdt%></font></td>
    <td align="center" class="bgbluegrey"><font class="blackfnt">Origin Location</font></td>
    <td align="center" bgcolor="#FFFFFF"   ><font class="blackfnt"><%=thcbr%> </font></td>
  </tr>
   <tr > 
    <td align="center" class="bgbluegrey"><font class="blackfnt">Mode | Route</font></td>
    <td align="center"  bgcolor="#FFFFFF" ><font class="blackfnt"><%=rut_cat%>| <%=routecd %> : <%=routename%></font></td>
    <td align="center" class="bgbluegrey"><font class="blackfnt">Vendor type | Vendor</font></td>
    <td align="center" bgcolor="#FFFFFF"   ><font class="blackfnt"><%=vendtyp%>| <%=vendor_code%> : <%=vendor_name%></font></td>
  </tr>
   <tr > 
    <td align="center" class="bgbluegrey"><font class="blackfnt">Tonnage | Loaded | Utilization</font></td>
    <td align="center"  bgcolor="#FFFFFF" ><font class="blackfnt"><%=tonage%> | <%=loaded%> | <%=uti%>%</font></td>
    <td align="center" class="bgbluegrey"><font class="blackfnt">Vehicle Type | Vehicle</font></td>
    <td align="center" bgcolor="#FFFFFF"   ><font class="blackfnt"><%=vehtype%> | <%=vehno%></font></td>
  </tr>
   <tr > 
    <td align="center" class="bgbluegrey"><font class="blackfnt">Driver | Mobile</font></td>
    <td align="center"  bgcolor="#FFFFFF" ><font class="blackfnt"><%=driver%></font></td>
    <td align="center" class="bgbluegrey"><font class="blackfnt">View | Print</font></td>
    <td align="center" bgcolor="#FFFFFF"   ><font class="blackfnt">View | Print</font></td>
  </tr>
</table>
<br />
 <asp:Table ID="tblmovement1"  runat="server" CellPadding="2" CellSpacing="1"
                        style="width:8.in" align=center  CssClass="boxbg">
                    </asp:Table>
