<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DateSelector1.ascx.cs" Inherits="include_DateSelector" %>
<%@ Register Assembly="AtlasControlToolkit" Namespace="AtlasControlToolkit" TagPrefix="atlasToolkit" %>
<LINK href="../cal/popcalendar.css" type="text/css" rel="stylesheet">
<script language="javascript" src="../cal/popcalendar.js"></script>
<TABLE id="tbl_control" cellSpacing="0" cellPadding="0" border="0">
	<TR>
		<TD align="right"></TD>
		<TD align="center"><asp:textbox id="txt_Date" Width="58px" Columns="6" runat="server" MaxLength="10" CssClass="input" BorderStyle="Groove"></asp:textbox><asp:RequiredFieldValidator ID="RFVFromDate" runat="server" ControlToValidate="txt_Date" ErrorMessage="*" ValidationGroup="VGDtFromTo"></asp:RequiredFieldValidator>
	<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="*"
                                        ControlToValidate="txt_Date" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
	
		</TD>
		 
	</TR>
</TABLE>
