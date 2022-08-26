<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="TyreUpdate_Msg.aspx.cs" Inherits="GUI_Fleet_Tyre_TyreUpdate_Msg" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<table width="100%">
        <tr>
            <td>
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Tyre </asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <table width="50%" cellpadding="0" cellspacing="0" border="1" class="boxbg">
    <tr>
    <td class="bgbluegrey" colspan="3" align="center">
        <asp:Label ID="Label4" runat="server" CssClass="blackboldfnt" Text="Following Tyre is updated :"></asp:Label>
    </td>
    </tr>
    <tr align="center">
    <td>
    <asp:GridView ID="GV_FuelRequest" BorderWidth="1" CellSpacing="0" CellPadding="0" runat="server"
                    Visible="true" EmptyDataText="No Data Found ...." AutoGenerateColumns="false"
                    Width="100%" CssClass="boxbg" HeaderStyle-CssClass="bgbluegrey" FooterStyle-CssClass="bgwhite"
                    PagerSettings-Mode="NumericFirstLast" PageSize="10" SelectedIndex="1">
                    <Columns>
                        <asp:TemplateField HeaderText="" ItemStyle-Width="5px" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <asp:Label ID="lblsr" Text="Sr.No." runat="server">
                                </asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblSrNo" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <asp:Label ID="Label1" runat="server" Text="Tyre ID"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtFuelReqID" runat="server" BorderStyle="None"
                                    onfocus="this.blur()" Text='<%# Bind("TYRE_NO") %>' Style="text-align:center"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
    </td>
    </tr>
     
    </table>
</asp:Content>

