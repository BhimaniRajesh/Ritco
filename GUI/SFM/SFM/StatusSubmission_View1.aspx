<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StatusSubmission_View1.aspx.cs" Inherits="SFM_StatusSubmission_View1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Prospect Detail</title>
    <link href="../../images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    
    
    
    <div>
             <table  border="0" align='center'  cellpadding="0" cellspacing="0" width="85%">
                <tr>
                    <td align="right">
                       
                    </td>
                </tr>
            </table>
            <table border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#808080"  class="boxbg" width="85%">
            <tr class="bgbluegrey">
                <td align="center" class="bgbluegrey" style="height: 27px">
                <font class="blackfnt"><strong>Prospect Registration</strong></font></td>
            </tr>
        </table>
        <br />
        
        <table cellspacing="1" cellpadding="3" border="0" bgcolor="#808080"  align="center" class="boxbg" style="width: 85%">
     
    <tr> 
      <td valign="top"  bgcolor="#FFFFFF" width="129"><font class="blackfnt">Prospect Id</font></td>
      <td valign="top"  bgcolor="#FFFFFF" align="center" > 
        <div align="left"><font class="blackfnt"><asp:Label ID="lblProspect" runat="server" Text="Label"></asp:Label></font></div>
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
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="166"> 
        <p align="left"><font class="blackfnt">E-Mail</font> 
      </td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="222"><font class="blackfnt"><asp:Label ID="lblEmail" runat="server" Text="Label"></asp:Label></font></td>
    </tr>
    
   
     
    
   </table>  
    
    
    
    </div>
    </form>
</body>
</html>
