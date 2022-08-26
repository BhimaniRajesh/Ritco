<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PaymentControl_1.ascx.cs"
    Inherits="UserControls_PaymentControl_1" %>
<br />
<table cellspacing="1" style="width: 100%" align="center" border="0">
    <tr style="background-color: white">
        <td align="left">
            <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server">Note : Please enter the payment details if payment amount >0</asp:Label>
        </td>
    </tr>
</table>
<br />
<table border="0" cellspacing="1" cellpadding="4" width="100%" align="center" class="boxbg">
    <tr class="bgbluegrey">
        <td colspan="4" align="center">
            <font class="blackfnt">Payment Details</font>
        </td>
    </tr>
    <tr bgcolor="#FFFFFF">
        <td align="left">
            <font class="blackfnt">Mode Of Transaction </font>
        </td>
        <td align="left">
            <font class="blackfnt"></font> 
                <asp:DropDownList runat="server" ID="dlstTransType" OnSelectedIndexChanged="dlstTransType_onChange" AutoPostBack="true">
                    <asp:ListItem Value="" Text="Select" Selected="True"></asp:ListItem>
                    <asp:ListItem Value="CASH" Text="Cash"></asp:ListItem>
                    <asp:ListItem Value="BANK" Text="Bank"></asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please select mode of transaction!!!"
                    Display="Dynamic" ControlToValidate="dlstTransType" ValidationGroup="SYS"></asp:RequiredFieldValidator>
        </td>
        <td align="left">
            <font class="blackfnt">Cash / Bank Account</font>
        </td>
        <td align="left">
            <asp:DropDownList runat="server" ID="dlstAcccode" >
                <asp:ListItem Value="" Text="Select" Selected="True"></asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please select Account!!!"
                Display="Dynamic" ControlToValidate="dlstAcccode" ValidationGroup="SYS"></asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr bgcolor="#FFFFFF">
        <td align="left">
            <font class="blackfnt">Cheque No <span style="color: #ff0000">*</span></font></td>
        <td align="left">
            <font class="blackfnt">
                <asp:TextBox ID="txtChqNo" MaxLength="6" CssClass="inp" Width="80" runat="server" BorderStyle="Groove" ></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionChqNo" runat="server" ControlToValidate="txtChqNo"
                    ErrorMessage="Please enter valid cheque no!!!" Display="Dynamic" ValidationExpression="(\d{6})" ValidationGroup="SYS"></asp:RegularExpressionValidator>
            </font>
        </td>
        <td align="left">
            <font class="blackfnt">Cheque Date <span style="color: #ff0000">*</span></font></td>
        <td align="left">
            <font class="blackfnt">
                <asp:TextBox ID="txtChqDate" MaxLength="12" CssClass="inp" Width="80" runat="server"
                    OnTextChanged="txtChqDate_TextChanged" AutoPostBack="True" BorderStyle="Groove" ></asp:TextBox>dd/mm/yyyy
                <asp:RegularExpressionValidator ID="RegularExpressionChqDate" runat="server" ControlToValidate="txtChqDate"
                    ErrorMessage="Please Enter Valid Date!!!" ValidationGroup="SYS" Display="Dynamic" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                </font></td>
    </tr>
    <tr bgcolor="#ffffff">
        <td align="left">
            <font class="blackfnt">Payment Amount</font></td>
        <td align="left">
            <font class="blackfnt">
                <asp:TextBox ID="txtAmount" MaxLength="10" Width="80" runat="server"
                    Text="0.00" BorderStyle="Groove" ></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidatorAmount" ValidationGroup="SYS" ControlToValidate="txtAmount"
                    runat="Server" ValidationExpression="^(\+|-)?\d{1,6}(\.\d{1,2})?$" ErrorMessage="Number is not valid. Please
enter numbers with 2 decimals only" Display="Dynamic"> </asp:RegularExpressionValidator>
                <asp:CompareValidator ID="CompareValidator1" runat="server" ValidationGroup="SYS" ErrorMessage="Payment value should be greater than 0!!!"
                    Display="Dynamic" ValueToCompare="0" Operator="GreaterThan" ControlToValidate="txtAmount" Type="Double"></asp:CompareValidator>
                <asp:CustomValidator ID="CustomValidator2" runat="server" ValidationGroup="SYS" ErrorMessage="" Display="Dynamic"
                    ControlToValidate="txtAmount" EnableClientScript="true" ></asp:CustomValidator>
            </font>
        </td>
        <td align="left">
            <font class="blackfnt"></font>
        </td>
        <td align="left">
            <font class="blackfnt"></font>
        </td>
    </tr>
</table>
