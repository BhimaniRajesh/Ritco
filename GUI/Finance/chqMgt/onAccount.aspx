<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    Title="Untitled Page" codeFile="~/GUI/finance/chqMgt/onAccount.aspx.cs" Inherits="GUI_finance_chqMgt_onAccount"%>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Cheque Management : On Account Cheque Entry</asp:Label>
                <hr align="center" size="1" color="#8ba0e5" />
            </td>
        </tr>
    </table>
    <br />
    <p align="left">
        <font class="blackfnt" color="red"><b>Note : </b>Accounting Transaction will be hitting
            as On Account Entry Date.</font>
    </p>
    <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 75%"
        align="center">
        <tr bgcolor="white">
            <td align="left" class="blackfnt" width="20%">
                <font class="blackfnt">Cheque No </font>
            </td>
            <td align="left" class="blackfnt" width="20%">
                <font class="blackfnt">
                    <asp:TextBox ID="txtChqNo" MaxLength="6" CssClass="input" Width="80" runat="server"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionChqNo" runat="server" ControlToValidate="txtChqNo"
                        ErrorMessage="Please enter valid cheque no!!!" Display="Dynamic" ValidationExpression="(\d{6})"
                        ValidationGroup="SYS"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtChqNo"
                        ErrorMessage="Please enter Cheque No!!!" Display="Dynamic" CssClass="blackfnt"
                        ValidationGroup="SYS"></asp:RequiredFieldValidator>
                </font>
            </td>
            <td align="left" class="blackfnt" width="20%">
                <font class="blackfnt">Cheque Date</font>
            </td>
            <td align="left" class="blackfnt" width="20%">
                <font class="blackfnt">
                    <asp:UpdatePanel ID="UpdatePanePayment"  UpdateMode="Conditional" RenderMode="Inline"
                        runat="server">
                        <ContentTemplate>
                            <asp:TextBox ID="txtChqDate" MaxLength="12" CssClass="input" Width="80" runat="server"
                                OnTextChanged="txtChqDate_TextChanged" AutoPostBack="True"></asp:TextBox>dd/mm/yyyy
                            <asp:RegularExpressionValidator ID="RegularExpressionChqDate" runat="server" ControlToValidate="txtChqDate"
                                ErrorMessage="Please Enter Valid Date!!!" ValidationGroup="SYS" Display="Dynamic"
                                ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtChqDate"
                                ErrorMessage="Please enter Cheque Date!!!" Display="Dynamic" CssClass="blackfnt"
                                ValidationGroup="SYS"></asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="CustomValidator2" runat="server" ValidationGroup="SYS" ErrorMessage="" Display="Dynamic"
                    ControlToValidate="txtChqDate" EnableClientScript="true" SetFocusOnError="true" OnServerValidate="txtChqDate_TextChanged" ></asp:CustomValidator>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </font>
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="left" class="blackfnt" width="20%">
                <font class="blackfnt">Bank Name </font>
            </td>
            <td align="left" class="blackfnt" width="20%">
                <asp:TextBox ID="txtBankName" runat="server" MaxLength="50" Width="100"></asp:TextBox>
            </td>
            <td align="left" class="blackfnt" width="20%">
                <font class="blackfnt">Bank Branch </font>
            </td>
            <td align="left" class="blackfnt" width="20%">
                <asp:TextBox ID="txtBankBrn" runat="server" MaxLength="50" Width="100"></asp:TextBox>
            </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td align="left">
                <font class="blackfnt">Cheque Amount</font></td>
            <td align="left">
                <font class="blackfnt">
                    <asp:TextBox ID="txtAmount" MaxLength="10" CssClass="input" Width="80" runat="server"
                        Text="0.00"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidatorAmount" ValidationGroup="SYS"
                        ControlToValidate="txtAmount" runat="Server" ValidationExpression="^(\+|-)?\d{1,6}(\.\d{1,2})?$"
                        ErrorMessage="Number is not valid. Please
enter numbers with 2 decimals only" Display="Dynamic"> </asp:RegularExpressionValidator>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ValidationGroup="SYS"
                        ErrorMessage="Cheque amount should be greater than 0!!!" Display="Dynamic" ValueToCompare="0"
                        Operator="GreaterThan" ControlToValidate="txtAmount" Type="Double"></asp:CompareValidator>
                    <%-- --%>
                </font>
            </td>
            <td align="left" class="blackfnt" valign="top">
                Narration</td>
            <td align="left" class="blackfnt" colspan="3">
                <asp:TextBox ID="txtNarration" runat="server" BorderStyle="Groove" CssClass="input"
                    Width="150px" TextMode="MultiLine" Rows="3" Columns="25"></asp:TextBox>
            </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt" valign="top">
                <font class="blackfnt">Received From</font>
            </td>
            <td align="left" class="blackfnt">
                <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 85%"
                    align="center">
                    <tr bgcolor="white">
                        <td align="left" class="blackfnt">
                            <font class="blackfnt">Customer </font>
                        </td>
                        <td align="left" class="blackfnt">
                            <asp:TextBox ID="txtCustCode" runat="server" BorderStyle="Groove" CssClass="input" 
                                MaxLength="15" Text=""></asp:TextBox><asp:Button runat="server" ID="cmdctrpopup" Text="..." />
                                <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="" Display="Dynamic"
                    ControlToValidate="txtCustCode" ClientValidationFunction="fcheckpayment" EnableClientScript="true"  Enabled="true" SetFocusOnError="true"></asp:CustomValidator>
  
                        </td>
                      </tr>
                      <tr bgcolor="white">  
                        <td align="left" class="blackfnt">
                            <font class="blackfnt">8888 : </font><font class="redfnt">*</font></td>
                        <td align="left" class="blackfnt" style="width: 176px">
                            <asp:TextBox ID="txtCustName" runat="server" BorderStyle="Groove" CssClass="input"
                                MaxLength="50" Text=""></asp:TextBox>
                                 
                                </td>
                    </tr>
                </table>
            </td>
            <td valign="top" bgcolor="#FFFFFF" align="left" width="166">
                <p align="left">
                    <font class="blackfnt">On Account Entry Date</font>
            </td>
            <td align="left" class="blackfnt" width="40%">
                <asp:TextBox ID="txtOnAcDate" runat="server" BorderStyle="Groove" CssClass="input"
                    MaxLength="10" Width="60px"></asp:TextBox><font class="blackfnt">dd/mm/yyyy</font>&nbsp;
                <asp:RequiredFieldValidator ID="RequiredFieldVoucherDate" runat="server" ErrorMessage="Please Enter On Account Voucher Date!!!"
                    ControlToValidate="txtOnAcDate" ValidationGroup="SYS"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionVoucherDate" runat="server" ValidationGroup="SYS"
                    ControlToValidate="txtOnAcDate" ErrorMessage="Please Enter Valid Date!!!" Display="Dynamic"
                    ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
            </td>
        </tr>
    </table>
    <br />
    <p align="center">
        <asp:Button ID="cmdSubmit" runat="server" Text="Submit" ValidationGroup="SYS" OnClick="cmdSubmit_Click" CausesValidation="true" />
    </p>
</asp:Content>
