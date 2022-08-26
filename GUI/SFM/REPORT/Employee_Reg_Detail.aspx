<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Employee_Reg_Detail.aspx.cs" Inherits="REPORT_Employee_Reg_Detail" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Employee Detail</title>
    <link href="../../images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<form id="form1" runat="server">
<div align="center">
<table  border="0"  cellpadding="3" cols="2"  width="100%"  bgcolor="#ffffff" cellspacing="1" class="boxbg">
		<tr>
			<td  align="left" class="bgbluegrey" style="width: 40%">
				<font class="blackfnt"><b>Employee Code:</b></font>
			</td>
			<td  align="left" bgcolor="#ffffff">
				<font class="blackfnt">
                    <asp:Label ID="lblEmployeeCode" runat="server" Text="Label"></asp:Label></font></td>
		</tr>

		<tr>
			<td  align="left" class="bgbluegrey" style="width: 40%">
				<font class="blackfnt"><b>Employee Name:</b></font>
			</td>
			<td  align="left" bgcolor="#ffffff">
				<font class="blackfnt">
                    <asp:Label ID="lblEmployeeName" runat="server" Text="Label"></asp:Label></font></td>
		</tr>

		<tr>
			<td  align="left" class="bgbluegrey" style="width: 40%; height: 25px">
				<font class="blackfnt"><b>Resi. Address:</b></font>
			</td>
			<td  align="left" bgcolor="#ffffff" style="height: 25px">
				<font class="blackfnt">
                    <asp:Label ID="lblAddress" runat="server" Text="Label"></asp:Label></font></td>
		</tr>
		
		<tr>
			<td  align="left" class="bgbluegrey" style="width: 40%">
				<font class="blackfnt"><b>Resi Phone No:</b></font>
			</td>
			<td  align="left" bgcolor="#ffffff">
				<font class="blackfnt">
                    <asp:Label ID="lblPhoneNo" runat="server" Text="Label"></asp:Label></font></td>
		</tr>

		<tr>
			<td  align="left" class="bgbluegrey" style="width: 40%">
				<font class="blackfnt"><b>Mobile No:</b></font>
			</td>
			<td  align="left" bgcolor="#ffffff">
				<font class="blackfnt">
                    <asp:Label ID="lblMobileNo" runat="server" Text="Label"></asp:Label></font></td>
		</tr>	

		<tr>
			<td  align="left" class="bgbluegrey" style="width: 40%">
				<font class="blackfnt"><b>Email Id:</b></font>
			</td>
			<td  align="left" bgcolor="#ffffff">
				<font class="blackfnt">
                    <asp:Label ID="lblEmail" runat="server" Text="Label"></asp:Label></font></td>
		</tr>					

		<%--<tr>
			<td  align="left" class="bgbluegrey" style="width: 40%">
				<font class="blackfnt"><b>Designation:</b></font>
			</td>
			<td  align="left" bgcolor="#ffffff">
				<font class="blackfnt">
                    <asp:Label ID="lblDesignation" runat="server" Text="Label"></asp:Label></font></td>
		</tr>--%>
	</table>
</div>
</form>
</body>
</html>
