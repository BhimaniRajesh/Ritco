<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="wfrm_Fuel_Card_Master_Edit.aspx.cs" Inherits="GUI_Fleet_Webadmin_Fuel_wfrm_Fuel_Card_Master_Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">



<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td>
            <font class="blackfnt"><strong>Fuel Card Master</strong></font>
            <hr size="1" color="#8ba0e5">
        </td>
    </tr>
</table>

<table>
    <tr>
        <td align="left">
            <font class="blackfnt"><strong>New : </strong></font>
            <a href="wfrm_Fuel_Card_Master_Add.aspx?Fuel_Card_ID=0">Add Fuel Card ....</a>
        </td>
    </tr>
</table>

<asp:GridView ID="gv_Fuel_Card" runat="server" AutoGenerateColumns="False" 
HeaderStyle-CssClass="dgHeaderStyle" CssClass="dgRowStyle" 
EmptyDataText="No Records Found..." BorderColor="#8BA0E5" Width="40%">
    <HeaderStyle CssClass="dgHeaderStyle" />
    <Columns>
        <asp:HyperLinkField DataTextFormatString="Edit" 
        DataTextField="Fuel_Card_ID" DataNavigateUrlFields="Fuel_Card_ID" 
        DataNavigateUrlFormatString="wfrm_Fuel_Card_Master_Add.aspx?Fuel_Card_ID={0}">
            <ItemStyle CssClass="bluelink" ForeColor="Blue" />
        </asp:HyperLinkField>

        <asp:BoundField HeaderText="Fuel Card ID" DataField="Fuel_Card_ID" >
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
        </asp:BoundField>
        <asp:BoundField HeaderText="Manual Fuel Card No" DataField="Manual_Fuel_Card_No" >
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
        </asp:BoundField>
        <asp:BoundField HeaderText="Active Flag" DataField="Active_Flag" >
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
        </asp:BoundField>
    </Columns>
</asp:GridView>

</asp:Content>