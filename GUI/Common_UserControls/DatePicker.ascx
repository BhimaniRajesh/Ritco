<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DatePicker.ascx.cs" Inherits="GUI_Common_UserControls_DatePicker" %>

<script type="text/javascript">
    function checkDate(txtDate, allowFutureDate, allowPastDate) {
        var DtFormat = 'dd/MM/yyyy';
        chkDatePickerDt(txtDate, DtFormat, allowFutureDate, allowPastDate);
    }
</script>
<asp:TextBox ID="txtDtBox" runat="server" Columns="10" MaxLength="10"></asp:TextBox>
<asp:LinkButton ID="lnkBtnCal" runat="server"><img src="../Images/calendar.jpg" border="0" alt=""/></asp:LinkButton>
<asp:Label ID="lblRequired" runat="server" Visible="False" ForeColor="Red">*</asp:Label>
<asp:RequiredFieldValidator ID="ReqValidator1" runat="server" ControlToValidate="txtDtBox"
    Display="Dynamic" Enabled="False" ErrorMessage="Required" Visible="False"></asp:RequiredFieldValidator>
<asp:RegularExpressionValidator ID="regexValidator" runat="server" ControlToValidate="txtDtBox"
    ErrorMessage="Invalid date format" ValidationExpression="^\s*((0?[1-9]|[12][0-9]|3[01])[/](0?[1-9]|1[012])[/](20|19)[0-9]{2})\s*$" Display="Dynamic"></asp:RegularExpressionValidator>
<asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtDtBox"
    Display="Dynamic" Enabled="False" ErrorMessage="Out of range" Visible="False"></asp:RangeValidator>