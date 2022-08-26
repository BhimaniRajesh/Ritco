<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="StateMasterEdit.aspx.cs" Inherits="GUI_admin_StateMaster_StateMasterEdit" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<center>
    <br />
    <asp:GridView ID="gvVehicalPart" runat="server" AutoGenerateColumns="False" HeaderStyle-CssClass="dgHeaderStyle" OnRowCommand="dg_RowCommand" DataKeyNames="stcd" CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8BA0E5" Width="60%">
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="stcd" DataNavigateUrlFormatString="StateMasterAdd.aspx?id={0}" DataTextField="stcd" DataTextFormatString="- Edit -">
            <ItemStyle CssClass="bluelink" ForeColor="Blue" />
            </asp:HyperLinkField>
            <%--<asp:BoundField HeaderText="Pickup Location Code" DataField="pickup_loccode" >
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
            </asp:BoundField>--%>
            <asp:BoundField HeaderText="State Name" DataField="stnm" >
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" />
            </asp:BoundField>
            <%-- <asp:BoundField HeaderText="State" DataField="State" >
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Zone" DataField="Zone" >
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" />
            </asp:BoundField>--%>
          <%-- <asp:TemplateField>
            <ItemTemplate>
                                    <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" 
                                        Text="X" OnClientClick="return confirm('Are you certain that you want to delete this record?');">
                                    </asp:LinkButton>
                                 </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" Wrap="False" />
            </asp:TemplateField>--%>
        </Columns>
        <HeaderStyle CssClass="dgHeaderStyle" />
    </asp:GridView>
    &nbsp;</center>
</asp:Content>


