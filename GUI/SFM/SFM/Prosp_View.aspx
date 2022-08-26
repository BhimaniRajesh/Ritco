<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Prosp_View.aspx.cs" Inherits="SFM_Prosp_View" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Prospect View</title>
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
                <font class="blackfnt"><strong>Prospect Registration</strong></font></td>
            </tr>
        </table>
        <br />
        
        <table cellspacing="1" cellpadding="3" border="0" bgcolor="#808080"  align="center" class='<%=boxbg%>' style="width: 85%">
     
    <tr> 
      <td valign="top"  bgcolor="#FFFFFF" width="129"><font class="blackfnt">Prospect Id</font></td>
      <td valign="top"  bgcolor="#FFFFFF" align="center" > 
        <div align="left"><font class="blackfnt"><%=ProspectCode%></font></div>
      </td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="166"> 
        <p align="left"><font class="blackfnt">Registration date</font> 
      </td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="222"><font class="blackfnt"> 
          <asp:Label ID="lblDate" runat="server" Text="Label"></asp:Label></font></td>
    </tr>
    
    <tr> 
      <td valign="top"  bgcolor="#FFFFFF" width="129"><font class="blackfnt">Company Name</font></td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" > 
        <font class="blackfnt"><asp:Label ID="lblCompany" runat="server" Text="Label"></asp:Label></font></td>
      
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="166"> 
        <p align="left"><font class="blackfnt">Industry</font> 
      </td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="222"><font class="blackfnt"><asp:Label ID="lblIndustry" runat="server" Text="Label"></asp:Label></font></td>
    </tr>
    
    <tr> 
      <td valign="top"  bgcolor="#FFFFFF" width="129"><font class="blackfnt">Address</font></td>
      <td valign="top"  bgcolor="#FFFFFF" align="center" > 
        <div align="left"><font class="blackfnt"><asp:Label ID="lblAddress" runat="server" Text="Label"></asp:Label></font></div>
      </td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="166"> 
        <p align="left"><font class="blackfnt">Contact Person</font> 
      </td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="222"><font class="blackfnt"><asp:Label ID="lblContact" runat="server" Text="Label"></asp:Label></font></td>
    </tr>
    
    <tr> 
      <td valign="top"  bgcolor="#FFFFFF" width="129"><font class="blackfnt">City-Pin</font></td>
      <td valign="top"  bgcolor="#FFFFFF" align="center" > 
        <div align="left"><font class="blackfnt"><asp:Label ID="lblcity" runat="server" Text="Label"></asp:Label></font></div>
      </td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="166"> 
        <p align="left"><font class="blackfnt">Designation</font> 
      </td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="222"><font class="blackfnt"><asp:Label ID="lblDesignation" runat="server" Text="Label"></asp:Label></font></td>
    </tr>
    
    <tr> 
      <td valign="top"  bgcolor="#FFFFFF" width="129"><font class="blackfnt">Phone</font></td>
      <td valign="top"  bgcolor="#FFFFFF" align="center" > 
        <div align="left"><font class="blackfnt"><asp:Label ID="lblPhone" runat="server" Text="Label"></asp:Label></font></div>
      </td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="166"><font class="blackfnt">Comments</font></td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="222" rowspan="3"><font class="blackfnt">
          <asp:Label ID="lblComments" runat="server" Text="Label"></asp:Label></font></td>
    </tr>
            <tr>
                <td bgcolor="#ffffff" valign="top" width="129">
                  <font class="blackfnt">E-Mail</font>
                </td>
                <td align="left" bgcolor="#ffffff" valign="top">
                    <font class="blackfnt"><asp:Label ID="lblEmail" runat="server" Text="Label"></asp:Label></font></td>
                <td align="left" bgcolor="#ffffff" valign="top" width="166" rowspan="2">
                </td>
            </tr>
            <tr>
                <td bgcolor="#ffffff" valign="top" width="129">
                    <font class="blackfnt">WebSite</font></td>
                <td align="left" bgcolor="#ffffff" valign="top">
                    <font class="blackfnt"><asp:Label ID="lblWebsite" runat="server" Text="Label"></asp:Label></font></td>
            </tr>
    
   <tr id="loadpyament" runat="server" bgcolor="white" visible="false"> 
      <td valign="top"  bgcolor="#FFFFFF" width="129"><font class="blackfnt">Load Type</font></td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" > 
        <font class="blackfnt"><asp:Label ID="lblLoadType" runat="server" Text="Label"></asp:Label></font></td>
      
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="166"> 
        <p align="left"><font class="blackfnt">Payment System</font> 
      </td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="222"><font class="blackfnt"><asp:Label ID="lblPaymentSystem" runat="server" Text="Label"></asp:Label></font></td>
    </tr>
    
    <tr id="routes" runat="server" bgcolor="white" visible="false"> 
      <td valign="top"  bgcolor="#FFFFFF" width="129"><font class="blackfnt">Main Routes</font></td>
      <td valign="top"  bgcolor="#FFFFFF" align="center" > 
        <div align="left"><font class="blackfnt"><asp:Label ID="lblMainRoutes" runat="server" Text="Label"></asp:Label></font></div>
      </td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="166"> 
        
      </td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="222"><font class="blackfnt"></font></td>
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
