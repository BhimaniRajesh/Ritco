<%@ Control Language="c#" AutoEventWireup="true" Codebehind="DateSelector.ascx.cs" Inherits="DateSelectorCSharp.DateSelector.DateSelector" %>
<LINK href="../../cal/popcalendar.css" type="text/css" rel="stylesheet">
<script language="javascript" src="../../cal/popcalendar.js"></script>
<TABLE id="tbl_control" cellSpacing="0" cellPadding="0" border="0">
	<TR>
		<TD align="right"><asp:label id="lbl_Date" Font-Bold="true" runat="server">Date:</asp:label></TD>
		<TD align="middle"><asp:textbox id="txt_Date" runat="server" Columns="6"></asp:textbox>
		<TD><asp:image id="imgCalendar" runat="server" ImageUrl="../../cal/calendar.gif"></asp:image></TD>
	</TR>
</TABLE>
