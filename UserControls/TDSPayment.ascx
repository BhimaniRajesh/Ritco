<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TDSPayment.ascx.cs" Inherits="UserControls_TDSPayment" %>
<br />

<table border="0" cellspacing="1" cellpadding="4" width="100%" align="center" class="boxbg">
     <tr class="bgbluegrey" >
        <td colspan="4" align="center" >
            <font class="blackfnt">TAX Details</font>
        </td>
     </tr> 
     <tr bgcolor="#FFFFFF">
        <td  align="left">
            <font class="blackfnt">Tax Type </font>
        </td> 
        <td  align="left">
            <font class="blackfnt">Particular </font>
        </td> 
        <td  align="left">
            <font class="blackfnt">Rate </font>
        </td> 
        <td  align="left">
            <font class="blackfnt">Charges </font>
        </td> 
     </tr>
     <tr bgcolor="#FFFFFF">
      <td  align="left" width="10%">
            <font class="blackfnt">TDS </font>
      </td> 
      <td  align="left" width="50%">
            <asp:DropDownList runat="server" ID="dlstTdsAcccode">
                <asp:ListItem Value="" Text="Select" Selected="True"></asp:ListItem>
            </asp:DropDownList>
      </td>
        <td  align="left" width="20%" >
            <font class="blackfnt">
                <asp:TextBox ID="txtTdsRate" MaxLength="5" CssClass="inp" width="80" runat="server" Text="0.00" EnableViewState="true" BorderStyle="Groove"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidatorTdsRate" ControlToValidate="txtTdsRate" Runat="Server" ValidationExpression="^(\+|-)?\d{1,6}(\.\d{1,2})?$" ErrorMessage="Number is not valid. Please
enter numbers with 2 decimals only" Display="Dynamic"> </asp:RegularExpressionValidator>

                 
            </font>
        </td>
        <td  align="left" width="20%">
            <font class="blackfnt">
                <asp:TextBox ID="txtTdsAmt" MaxLength="5" CssClass="inp" width="80" runat="server" Text="0.00"  EnableViewState="true" BorderStyle="Groove"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidatorTdsAmt" ControlToValidate="txtTdsAmt" Runat="Server" ValidationExpression="^(\+|-)?\d{1,6}(\.\d{1,2})?$" ErrorMessage="Number is not valid. Please
enter numbers with 2 decimals only" Display="Dynamic" > </asp:RegularExpressionValidator>

                 
            </font>
        </td>
      </tr> 
 </table>      