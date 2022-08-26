<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="octCustBillStep1.aspx.cs" Inherits="octroi_octCustBillStep1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <br />
    <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 50%"
        align="center">
        <tr bgcolor="white">
            <td style="width: 190px">
                <font class="blackfnt">Enter Customer Code </font>
            </td>
            <td style="width: 376px">
                <asp:TextBox ID="Party_code" runat="server" CausesValidation="True" Columns="50"></asp:TextBox>
                <%-- <atlas:AutoCompleteExtender runat="server" ID="Extender1"  >
              <atlas:AutoCompleteProperties Enabled="True"
            TargetControlID="Party_code"
            ServiceMethod="GetCustomerList"
            ServicePath="../services/WebService.asmx" MinimumPrefixLength="1"  />
            </atlas:AutoCompleteExtender>--%>
                <ajaxToolkit:AutoCompleteExtender ID="Extender1" runat="server" Enabled="True" MinimumPrefixLength="1"
                    ServiceMethod="GetCustomerList" CompletionListItemCssClass="autocomplete_listItem"
                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" ServicePath="../services/WebService.asmx"
                    TargetControlID="Party_code">
                </ajaxToolkit:AutoCompleteExtender>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Party_code"
                    ErrorMessage="PLz Enter Customer Code"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr bgcolor="white">
            <td style="width: 190px">
                <font class="blackfnt">Above Customer is </font>
            </td>
            <td style="width: 376px">
                <asp:DropDownList ID="Billto" runat="server">
                    <asp:ListItem Value="CSGN">Consignor</asp:ListItem>
                    <asp:ListItem Value="CSGE">Consignee</asp:ListItem>
                    <asp:ListItem Value="BILL">Billing Party </asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
    <br />
    <center>
        <asp:Button ID="submit1" runat="server" OnClick="submit1_Click" Text="Submit" />
    </center>
</asp:Content>
