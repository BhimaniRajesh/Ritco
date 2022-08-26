<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="depositVoucher_step2.aspx.cs" Inherits="GUI_finance_chqMgt_depositVoucher_step2" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Cheque Management : Cheque Deposit Entry</asp:Label>
                <hr align="center" size="1" color="#8ba0e5" />
            </td>
        </tr>
    </table>
    <br />
    <br />
    
    <table border="0" width="100%">
        <tr>
             <td style="width: 5%">
             </td>
             <td width="95%" align="left">
             <asp:UpdatePanel ID="UpdatePanel1"  UpdateMode="Conditional" RenderMode="Inline" runat="server" >
     <ContentTemplate>
     <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="62%">
        <tr bgcolor="white">
            <td align="left" class="blackfnt" width="20%">
                <font class="blackfnt">&nbsp;Voucher No </font>
            </td>
            <td align="left" class="blackfnt" width="20%">
                <font class="blackfnt" color="red">&nbsp;System Generated...</font>
            </td>
            <td align="left" class="blackfnt" width="20%">
                <font class="blackfnt">&nbsp;Voucher Date </font><font class="blackfnt" color="red">*</font></td>
            <td align="left" class="blackfnt" width="40%">
                &nbsp;<asp:TextBox ID="txtVoucherDate" Enabled="false" runat="server" BorderStyle="Groove" CssClass="input"
                    MaxLength="10" Width="60px"></asp:TextBox><font class="blackfnt">dd/mm/yyyy</font>&nbsp;
            <asp:RequiredFieldValidator ID="RequiredFieldVoucherDate" runat="server" ErrorMessage="*" ControlToValidate="txtVoucherDate" ></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionVoucherDate" runat="server" ControlToValidate="txtVoucherDate"
                            ErrorMessage="*" Display="Dynamic" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                     
              
            </td>
        </tr>
        <tr bgcolor="#ffffff">
        <td align="left" valign="top" >
            <font class="blackfnt">&nbsp;Amount</font></td>
        <td align="left" >
            <font class="blackfnt">&nbsp;<asp:TextBox ID="txtAmount" runat="server" CssClass="inp" MaxLength="10" Text="0.00"
                    Width="80" ReadOnly="true" BorderColor="White" BorderStyle="None"></asp:TextBox>&nbsp;
            <asp:CompareValidator ID="CompareValidator1" runat="server" ValidationGroup="SYS" ErrorMessage="*"
                    Display="Dynamic" ValueToCompare="0" Operator="GreaterThan" ControlToValidate="txtAmount" Type="Double"></asp:CompareValidator>
               
            
            </font>
        </td>
        <td align="left" valign="top" >
            <font class="blackfnt">&nbsp;Deposited In Bank </font></td>
            <td align="left" valign="top" class="blackfnt">
                &nbsp;<asp:DropDownList runat="server" ID="dlstAcccode" >
                <asp:ListItem Value="" Text="Select" Selected="True"></asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                Display="Dynamic" ControlToValidate="dlstAcccode" ValidationGroup="SYS"></asp:RequiredFieldValidator>
            
            </td>
        </tr>
             <tr bgcolor="#ffffff">
          <td align="left" class="blackfnt" valign="top" >
              &nbsp;Narration</td>
            <td align="left" class="blackfnt" colspan="4" valign="top" >
                &nbsp;<asp:TextBox ID="txtNarration" runat="server" BorderStyle="Groove" CssClass="input"
                    Width="305px" TextMode="MultiLine" Rows="3" Columns="25"></asp:TextBox>
            </td>
    </tr>
    </table>
     <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font class="blackfnt"><b>List of Cheques Received </b></font><br></p> 
  <br>
   <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="62%">
        <tr bgcolor="white">
            <td align="left">
   
      <asp:GridView ID="dgGeneral" runat="server" AllowPaging="True" Width="100%" AllowSorting="True" HeaderStyle-CssClass="dgHeaderStyle" PageSize="10" 
          CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8ba0e5" AutoGenerateColumns="False" OnRowDataBound="dgGeneral_RowDataBound"  OnPageIndexChanging="dgGeneral_PageIndexChanging" >
          <Columns>
              <asp:TemplateField HeaderText="Select">
              <ItemTemplate>
              <asp:CheckBox ID="chkChqNo" runat="server" AutoPostBack="true" ValidationGroup="SYS" OnCheckedChanged="CalDepositAmt"/>
              </ItemTemplate>
              </asp:TemplateField>
              <asp:BoundField DataField="ChqNo" HeaderText="Cheque No" />
              <asp:BoundField DataField="ChqDate" HeaderText="Cheque date" />
              <asp:BoundField DataField="ChqAmt" HeaderText="Amount"  />
              <asp:BoundField DataField="EntryDt" HeaderText="Entry date"   />
              <asp:BoundField DataField="Party" HeaderText="Received from"  />
           </Columns>
          <HeaderStyle CssClass="dgHeaderStyle" />
      </asp:GridView>
       
   
    </td>
    </tr>
    </table>
         &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
         &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
         <br />
         &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
         &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
         &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
         &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
        <asp:Button ID="cmdSubmit" runat="server" Text="Submit" ValidationGroup="SYS" OnClick="cmdSubmit_Click" />
    </ContentTemplate>
              
                </asp:UpdatePanel>
                 <p align="center">
                     &nbsp;</p>
             </td>
        </tr>
    </table>
    
    
    
     
</asp:Content>

