<%@ Page Language="C#" AutoEventWireup="true" CodeFile="THC_track.aspx.cs" Inherits="GUI_Tracking_New_TAB_Tracking_THC_THC_track" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link rel="stylesheet" type="text/css" href="tabcontent.css" />
    <link rel="stylesheet" type="text/css" href="../../../images/style.css" />

    <script type="text/javascript" src="tabcontent.js"></script>


</head>
<body>
<form id="frm" runat="server">
    <ul id="countrytabs" class="shadetabs">
        <li><a href="#" rel="country1" class="selected">Summary</a></li>
       <li><a href="#" rel="country2">Life Cycle - Operations</a></li>
        <%-- <li><a href="#" rel="country3">Life Cycle - Finance</a></li>--%>
    </ul>
    <div style="border: 1px solid gray; width: 450px; margin-bottom: 1em; padding: 10px">
        <div id="country1" class="tabcontent">
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
        </div>
        <div id="country2" class="tabcontent">
          <asp:GridView  align="center" ID="dgDocket1" runat="server" BorderWidth="0"
                            AutoGenerateColumns="true" CssClass="boxbg"   HeaderStyle-Wrap="false"
                        CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
                        AllowPaging="false" 
                        FooterStyle-CssClass="boxbg"  >
                        
                 
                        <RowStyle HorizontalAlign="center"  Width="1300" BackColor="white" CssClass="blackfnt"   />
                               
                     
                    </asp:GridView>
        </div>
        <div id="country3" class="tabcontent">
            
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
</form>
</body>
</html>
