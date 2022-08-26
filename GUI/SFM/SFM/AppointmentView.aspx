<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AppointmentView.aspx.cs" Inherits="GUI_SFM_SFM_AppointmentView" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Appointment View</title>
    <link href="../../images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <% string strProspectCode = Request.QueryString.Get("strProspectCode");
       string[] Split = strProspectCode.Split(new Char[] { ',' });
       string ProspectCode = Convert.ToString(Split[0]);
       string print_yn = Convert.ToString(Split[1]);
       string boxbg = "boxbg";
       string bgbluegrey = "bgbluegrey";
       string strborder = "border='0'";
        if (print_yn == "1")
       {
           boxbg = "";
           bgbluegrey = "bgwhite";
           strborder = "border='1'";
          
       }

      %>
    <div>
             <table align='center'  cellpadding="0" cellspacing="0" width="85%">
                <tr>
                    <td align="right">
                       
                    </td>
                </tr>
            </table>
            <table align="center" cellpadding="0" cellspacing="1" bgcolor="#808080"  class='<%=boxbg%>' width="85%">
            <tr class='<%=bgbluegrey%>'>
                <td align="center" class='<%=bgbluegrey%>' style="height: 27px">
                <font class="blackfnt"><strong>Appointment Entry</strong></font></td>
            </tr>
        </table>
        <br />
        
        <table cellspacing="1" cellpadding="3" border="0" bgcolor="#808080"  align="center" class='<%=boxbg%>' style="width: 85%">
     
    <tr> 
      <td valign="top"  bgcolor="#FFFFFF" width="129"><font class="blackfnt">Appointment Id</font></td>
      <td valign="top"  bgcolor="#FFFFFF" align="center" > 
        <div align="left"><font class="blackfnt"><%=ProspectCode%></font></div>
      </td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="166"> 
        <p align="left"><font class="blackfnt">Appointment date</font> 
      </td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="222"><font class="blackfnt"> 
          <asp:Label ID="lblDate" runat="server" Text="Label"></asp:Label></font></td>
    </tr>
    
    <tr> 
      <td valign="top"  bgcolor="#FFFFFF" width="129"><font class="blackfnt">Prospect</font></td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" > 
        <font class="blackfnt"><asp:Label ID="lblCompany" runat="server" Text="Label"></asp:Label></font></td>
      
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="166"> 
        <p align="left"><font class="blackfnt">Appointment Time</font></td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="222"><font class="blackfnt"><asp:Label ID="lblAppTime" runat="server" Text="Label"></asp:Label></font></td>
    </tr>
    
    <tr> 
      <td valign="top"  bgcolor="#FFFFFF" width="129"><font class="blackfnt"> Person To Met</font></td>
      <td valign="top"  bgcolor="#FFFFFF" align="center" > 
        <div align="left"><font class="blackfnt"><asp:Label ID="lblPersonTomet" runat="server" Text="Label"></asp:Label></font></div>
      </td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="166"> 
        <p align="left"><font class="blackfnt">Contact Number</font></td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="222"><font class="blackfnt"><asp:Label ID="lblContact" runat="server" Text="Label"></asp:Label></font></td>
    </tr>
    
    <tr> 
      <td valign="top"  bgcolor="#FFFFFF" width="129"><font class="blackfnt">Department</font></td>
      <td valign="top"  bgcolor="#FFFFFF" align="center" > 
        <div align="left"><font class="blackfnt"><asp:Label ID="lblDept" runat="server" Text="Label"></asp:Label></font></div>
      </td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="166"> 
        <p align="left"><font class="blackfnt">Designation</font> 
      </td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="222"><font class="blackfnt"><asp:Label ID="lblDesignation" runat="server" Text="Label"></asp:Label></font></td>
    </tr>
    
    <tr> 
      <td valign="top"  bgcolor="#FFFFFF" width="129"><font class="blackfnt">Purpose</font></td>
      <td valign="top"  bgcolor="#FFFFFF" align="center" > 
        <div align="left"><font class="blackfnt"><asp:Label ID="lblPurpose" runat="server" Text="Label"></asp:Label></font></div>
      </td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="166"><font class="blackfnt">Remarks</font></td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="222" rowspan="3"><font class="blackfnt">
          <asp:Label ID="lblRemarks" runat="server" Text="Label"></asp:Label></font></td>
    </tr>
            
    
   
     
    
   </table>   
        <%
         if (print_yn == "1")
       {
         //  Response.Write("hi..");
       %>
        <script language="javascript" type="text/javascript">
       
        function loadme()
        {
           // alert("hi...")
            window.print();
        }
       window.load =loadme()
        </script>
       <%} %>        
    </div>
    </form>
</body>
</html>
