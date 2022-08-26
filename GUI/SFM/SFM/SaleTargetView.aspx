<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SaleTargetView.aspx.cs" Inherits="SFM_SaleTargetView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Sale Target View</title>
    <link href="../../images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <% string strSaleTargetCode = Request.QueryString.Get("strSaleTargetCode");
       string[] Split = strSaleTargetCode.Split(new Char[] { ',' });
       string SaleCode = Convert.ToString(Split[0]);
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
      <td valign="top"  bgcolor="#FFFFFF" width="129"><font class="blackfnt">Sale Target Id</font></td>
      <td valign="top"  bgcolor="#FFFFFF" align="center" > 
        <div align="left"><font class="blackfnt"><%=SaleCode%></font></div>
      </td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="166"> 
        <p align="left"><font class="blackfnt">Status</font> 
      </td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="222"><font class="blackfnt"> 
          <asp:Label ID="lblStatus" runat="server" Text="Label"></asp:Label></font></td>
    </tr>
    
    <tr> 
      <td valign="top"  bgcolor="#FFFFFF" width="129"><font class="blackfnt">Entry Date</font></td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" > 
        <font class="blackfnt"><asp:Label ID="lblDate" runat="server" Text="Label"></asp:Label></font></td>
      
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="166"> 
        <p align="left"><font class="blackfnt">Period</font> 
      </td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="222"><font class="blackfnt"><asp:Label ID="lblPeriod" runat="server" Text="Label"></asp:Label></font></td>
    </tr>
    
    <tr> 
      <td valign="top"  bgcolor="#FFFFFF" width="129"><font class="blackfnt">Total</font></td>
      <td valign="top"  bgcolor="#FFFFFF" align="center" > 
        <div align="left"><font class="blackfnt"><asp:Label ID="lblTotal" runat="server" Text="Label"></asp:Label></font></div>
      </td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="166"> 
      </td>
      <td valign="top" bgcolor="#FFFFFF" align="left" width="222"></td>
    </tr>
    
   </table>   
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
