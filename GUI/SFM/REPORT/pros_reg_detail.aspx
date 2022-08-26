<%@ Page Language="C#" AutoEventWireup="true" CodeFile="pros_reg_detail.aspx.cs" Inherits="REPORT_pros_reg_detail" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<%--<head id="Head1" runat="server">
    <title>Call View</title>
    <link href="../include/Styles.css" rel="stylesheet" type="text/css" />
</head>
<body>
<form id="form1" runat="server">
<div align="center">
<table  border="0"  cellpadding="3" cols="2"  width="100%"  bgcolor="#ffffff" cellspacing="1" class="boxbg">
		<tr>
			<td  align="left" class="bgbluegrey" style="width: 40%">
				<font class="blackfnt"><b>Registration Date:</b></font>
			</td>
			<td  align="left" bgcolor="#ffffff">
				<font class="blackfnt">
                    <asp:Label ID="lblRegistrationDate" runat="server" Text="Label"></asp:Label></font></td>
		</tr>

		<tr>
			<td  align="left" class="bgbluegrey" style="width: 40%">
				<font class="blackfnt"><b>Company Name:</b></font>
			</td>
			<td  align="left" bgcolor="#ffffff">
				<font class="blackfnt">
                    <asp:Label ID="lblCompanyName" runat="server" Text="Label"></asp:Label></font></td>
		</tr>

		<tr>
			<td  align="left" class="bgbluegrey" style="width: 40%; height: 25px">
				<font class="blackfnt"><b>Industry Code:</b></font>
			</td>
			<td  align="left" bgcolor="#ffffff" style="height: 25px">
				<font class="blackfnt">
                    <asp:Label ID="lblIndustryCode" runat="server" Text="Label"></asp:Label></font></td>
		</tr>
		
		<tr>
			<td  align="left" class="bgbluegrey" style="width: 40%">
				<font class="blackfnt"><b>Company Address:</b></font>
			</td>
			<td  align="left" bgcolor="#ffffff">
				<font class="blackfnt">
                    <asp:Label ID="lblCompanyAddress" runat="server" Text="Label"></asp:Label></font></td>
		</tr>

		<tr>
			<td  align="left" class="bgbluegrey" style="width: 40%">
				<font class="blackfnt"><b>Contact No.:</b></font>
			</td>
			<td  align="left" bgcolor="#ffffff">
				<font class="blackfnt">
                    <asp:Label ID="lblContactNo" runat="server" Text="Label"></asp:Label></font></td>
		</tr>	

		<tr>
			<td  align="left" class="bgbluegrey" style="width: 40%">
				<font class="blackfnt"><b>Email:</b></font>
			</td>
			<td  align="left" bgcolor="#ffffff">
				<font class="blackfnt">
                    <asp:Label ID="lblEmail" runat="server" Text="Label"></asp:Label></font></td>
		</tr>					

		<tr>
			<td  align="left" class="bgbluegrey" style="width: 40%">
				<font class="blackfnt"><b>Contact Person:</b></font>
			</td>
			<td  align="left" bgcolor="#ffffff">
				<font class="blackfnt">
                    <asp:Label ID="lblContactPerson" runat="server" Text="Label"></asp:Label></font></td>
		</tr>
	</table>
</div>
</form>
</body>
</html>--%>

<head id="Head1" runat="server">
    <title>Prospect View</title>
    <link href="../../images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
   
    <div>
             <table align='center'  cellpadding="0" cellspacing="0" width="85%">
                <tr>
                    <td align="right">
                       
                    </td>
                </tr>
            </table>
            <table align="center" cellpadding="0" cellspacing="1" bgcolor="#808080"  class="boxbg" width="85%">
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
        <div align="left"><font class="blackfnt"><%=Prospect%></font></div>
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
        
        
    </div>
    </form>
</body>
</html>
