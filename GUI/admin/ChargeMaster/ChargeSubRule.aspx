<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="ChargeSubRule.aspx.cs" Inherits="GUI_admin_ChargeMaster_ChargeSubRule"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <br /><br />
    <asp:Table runat="server" Width="5in" CellSpacing="1" CssClass="boxbg">
        <asp:TableRow CssClass="bgbluegrey">
            <asp:TableCell ColumnSpan="2" Font-Bold="true" HorizontalAlign="Center">Charge SubRule Setting</asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell CssClass="bgwhite" Width="50%">Charge Primary Base</asp:TableCell>
            <asp:TableCell CssClass="bgwhite" Width="50%">
                <asp:Label ID="lblprimarybase" runat="server" CssClass="blackfnt"></asp:Label>
            </asp:TableCell>
            </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell CssClass="bgwhite" ColumnSpan="2">
                <asp:GridView HorizontalAlign="center" ID="grvcharge" runat="server" BorderWidth="0"
                    CellSpacing="1" AllowSorting="true" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                    HeaderStyle-CssClass="bgbluegrey" OnRowDataBound="grvcharge_RowDataBound"
                    EmptyDataText="No Records Found..." AutoGenerateColumns="false" RowStyle-CssClass="bgwhite" Style="width: 100%;">
                    <Columns>
                        <asp:TemplateField HeaderText="Primary Charge Rule" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <center>
                                    <asp:Label CssClass="blackfnt" ID="lblbasecodename" Text='<%# DataBinder.Eval(Container.DataItem,"basecodename") %>'
                                        runat="server"></asp:Label>
                                </center>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Secondary Charge Rule" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <center>
                                    <asp:DropDownList ID="ddlsubrule" runat="server" CssClass="blackfnt">
                                        <asp:ListItem Value="NONE" Text="NONE"></asp:ListItem>
                                        <asp:ListItem Value="PROD" Text="Product Type"></asp:ListItem>
                                        <asp:ListItem Value="PKPDL" Text="PickUP/Del wise"></asp:ListItem>
                                     </asp:DropDownList>
                                     <asp:HiddenField ID="hdnbasecode" Value='<%# DataBinder.Eval(Container.DataItem,"basecode") %>' runat="server" />
                                </center>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                    </Columns>
                </asp:GridView>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgbluegrey">
            <asp:TableCell ColumnSpan="2">
                <asp:Button ID="btnsubmit" Text="Submit" CssClass="blackfnt" runat="server" OnClick="btnsubmit_Click" />
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>
    <asp:HiddenField ID="hdnchargerule" runat="server" />
</asp:Content>
