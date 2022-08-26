<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="AppointmentEntry_Done.aspx.cs" Inherits="SFM_AppointmentEntry_Done" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">
        function ViewPrint(arg1,arg2) 
        { 
        window.open("./AppointmentView.aspx?strProspectCode=" + arg1 + "," + arg2 ,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"); 
        }
    </script>
 <table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Appointment Entry Done" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
        </table>

<br />

<div align="center">
        <table border="0" cellpadding="4" cellspacing="1" class="boxbg" width="85%">
            <tr class="bgbluegrey">
                <td align="center" colspan="4" >
                    <font class="bluefnt"><b>Following document has been successfully generated</b></font></td>
            </tr>
            <tr>
    <td  align="center" bgcolor="#FFFFFF" height="18" colspan="2" ><font class="blackfnt" >Document name</font></td>
    <td  align="center" bgcolor="#FFFFFF" height="18" colspan="1" ><font class="blackfnt" >Document Number</font></td>
    <td  align="center" bgcolor="#FFFFFF" height="18" colspan="1"><font class="blackfnt">&nbsp;</font></td>
  </tr>
   <tr>
    <td  align="center" bgcolor="#FFFFFF" height="18" colspan="2"><font class="blackfnt">New Appointment</font></td>
    <td  align="center" bgcolor="#FFFFFF" height="18" colspan="1"><font class="blackfnt"><%=Request.QueryString.Get("AppontmentId")%></font></td>
    
    <td  align="right" bgcolor="#FFFFFF" height="18" colspan="1"><font class="blackfnt"><a href="Javascript:ViewPrint('<%=Request.QueryString.Get("AppontmentId")%>',0)">View </a>| <a href="Javascript:ViewPrint('<%=Request.QueryString.Get("AppontmentId")%>',1)">Print</a> </td>
  </tr>
  <tr>
    <td  align="left" bgcolor="#FFFFFF" height="18" colspan="4"><font class="blackfnt"><b>Your Next Step:</b></font></td>
    
  </tr>
      
      <tr  bgcolor="#FFFFFF">
    <td width="2%" height="15" bgcolor="#FFFFFF"> 
					                  <table border="0" cellspacing="0" cellpadding="0">
					                    <tr> 
					                      <td class="bullet"><img src="../images/clear.gif" width="4" height="4"></td>
					                    </tr>
					                  </table> </td>
    <td width="100%" align="left" bgcolor="#FFFFFF" height="15" colspan="3"><font class="blackfnt" color="#0000FF"><a href="AppointmentEntry1.aspx"><font class="blklnkund">Enter More Appointments</a></font></td>
  </tr>
  <%--<tr  bgcolor="#FFFFFF">
    <td width="2%" height="15" bgcolor="#FFFFFF"> 
					                  <table border="0" cellspacing="0" cellpadding="0">
					                    <tr> 
					                      <td class="bullet"><img src="../images/clear.gif" width="4" height="4"></td>
					                    </tr>
					                  </table> </td>
    <td width="100%" align="left" bgcolor="#FFFFFF" height="15" colspan="3"><font class="blackfnt" color="#0000FF"><a href="../Report/AppointmentSchedule1.aspx"><font class="blklnkund">View Appointment Schedule</a></font></td>
  </tr>--%>
   <tr  bgcolor="#FFFFFF">
    <td width="2%" height="15" bgcolor="#FFFFFF"> 
					                  <table border="0" cellspacing="0" cellpadding="0">
					                    <tr> 
					                      <td class="bullet"><img src="../images/clear.gif" width="4" height="4"></td>
					                    </tr>
					                  </table> </td>
    <td width="100%" align="left" bgcolor="#FFFFFF" height="15" colspan="3"><font class="blackfnt" color="#0000FF"><a href="../Main.aspx"><font class="blklnkund">SFM Main Page</a></font></td>
  </tr>
  
      
      
            
            
        </table>
    </div>
   </asp:Content>
