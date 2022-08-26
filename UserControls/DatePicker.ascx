<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DatePicker.ascx.cs" Inherits="UserControls_DatePicker" %>

<link type="text/css" rel="stylesheet" href="../cal/popcalendar.css">
<script type="text/javascript" language="javascript" src="../cal/popcalendar.js"></script>

<table id="tbl_control" cellSpacing="0" cellPadding="0" border="0">
	<tr>
	    <td>
	        <asp:textbox id="tb_Date" runat="server" Columns="6" Width="60px" CssClass="input" MaxLength="10" BorderStyle="Groove"></asp:textbox>
	        <asp:image id="img_Calendar" runat="server" ImageUrl="~/cal/cal.gif" BackColor="White" BorderColor="White" ForeColor="White"></asp:image>
            <font class="blackfnt">(dd/mm/yyyy)</font>
	        <asp:RequiredFieldValidator ID="rfv_Date" runat="server" ControlToValidate="tb_Date" ErrorMessage="!!!!" ToolTip=" Required Input " Display="Dynamic"></asp:RequiredFieldValidator>
	        <asp:RegularExpressionValidator ID="rev_Date" runat="server" ErrorMessage="!!!!" ControlToValidate="tb_Date" ForeColor="Blue" ToolTip=" Invalid date format " 
	            ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))" Display="Dynamic"></asp:RegularExpressionValidator>
        </td>
    </tr>
</table>
