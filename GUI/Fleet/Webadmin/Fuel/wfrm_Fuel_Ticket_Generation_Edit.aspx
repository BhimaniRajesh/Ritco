<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="wfrm_Fuel_Ticket_Generation_Edit.aspx.cs" Inherits="GUI_Fleet_Webadmin_Fuel_wfrm_Fuel_Ticket_Generation_Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">



<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td>
            <font class="blackfnt"><strong>Fuel Ticket Generation</strong></font>
            <hr size="1" color="#8ba0e5">
        </td>
    </tr>
</table>

<table>
    <tr>
        <td align="left">
            <font class="blackfnt"><strong>New : </strong></font>
            <a href="wfrm_Fuel_Ticket_Generation_Add.aspx?Ticket_No=0">Add Fuel Ticket Generation ....</a>
        </td>
    </tr>
</table>

<asp:GridView ID="gv_Fuel_Ticket" runat="server" AutoGenerateColumns="False" 
HeaderStyle-CssClass="dgHeaderStyle" CssClass="dgRowStyle" 
EmptyDataText="No Records Found..." BorderColor="#8BA0E5" Width="40%">
    <HeaderStyle CssClass="dgHeaderStyle" />
    <Columns>
        <asp:HyperLinkField DataTextFormatString="Edit" 
        DataTextField="Ticket_No" DataNavigateUrlFields="Ticket_No" 
        DataNavigateUrlFormatString="wfrm_Fuel_Ticket_Generation_Add.aspx?Ticket_No={0}">
            <ItemStyle CssClass="bluelink" ForeColor="Blue" />
        </asp:HyperLinkField>

        <asp:BoundField HeaderText="Ticket No" DataField="Ticket_No" >
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
        </asp:BoundField>
        <asp:BoundField HeaderText="Manual Ticket No" DataField="Manual_Ticket_No" >
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
        </asp:BoundField>
        <asp:BoundField HeaderText="Ticket Date" DataField="Ticket_Date" >
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
        </asp:BoundField>
    </Columns>
</asp:GridView>

</asp:Content>