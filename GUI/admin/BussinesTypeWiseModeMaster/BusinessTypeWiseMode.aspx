<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="BusinessTypeWiseMode.aspx.cs" Inherits="GUI_admin_BussinesTypeWiseModeMaster_BusinessTypeWiseMode"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <br />
    <br />

    <script type="text/javascript" language="javascript">
        function btnsubmitClick()
        {
            return true;
        }
    </script>
    
    <asp:Panel ID="Panel1" runat="server" Width="10in">
        <asp:Table runat="server" CssClass="boxbg" Width="100%" CellSpacing="1">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell HorizontalAlign="Center" Font-Bold="true">
                        Business Type Wise Mode of Service
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow BackColor="white">
                <asp:TableCell>
                    <asp:GridView HorizontalAlign="center" ID="grvbusiness" runat="server" BorderWidth="0"
                        CellSpacing="1" AllowSorting="true" AutoGenerateColumns="false" CssClass="boxbg"
                        OnRowDataBound="grvbusiness_RowDataBound" HeaderStyle-CssClass="bgbluegrey"
                        Style="width: 100%;">
                        <Columns>
                            <asp:TemplateField HeaderText="Business Type" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                <ItemStyle BackColor="white" />
                                <ItemTemplate>
                                    <asp:Label ID="lblbusinesstype" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"codedesc") %>' CssClass="blackfnt"></asp:Label>
                                    <asp:HiddenField ID="hdnbusinesstype" runat="server" Value='<%#DataBinder.Eval(Container.DataItem,"codeid") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label ID="lblairname" runat="server" CssClass="blackfnt"></asp:Label>
                                </HeaderTemplate>
                                <ItemStyle HorizontalAlign="Center" BackColor="white" />
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkair" runat="server" CssClass="blackfnt" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label ID="lblroadname" runat="server" CssClass="blackfnt"></asp:Label>
                                </HeaderTemplate>
                                <ItemStyle HorizontalAlign="Center" BackColor="white" />
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkroad" runat="server" CssClass="blackfnt" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label ID="lbltrainname" runat="server" CssClass="blackfnt"></asp:Label>
                            </HeaderTemplate>
                                <ItemStyle HorizontalAlign="Center" BackColor="white" />
                                <ItemTemplate>
                                    <asp:CheckBox ID="chktrain" runat="server" CssClass="blackfnt" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Express">
                            <HeaderTemplate>
                                <asp:Label ID="lblexpressname" runat="server" CssClass="blackfnt"></asp:Label>
                            </HeaderTemplate>
                                <ItemStyle HorizontalAlign="Center" BackColor="white" />
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkexpress" runat="server" CssClass="blackfnt" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-CssClass="blackfnt" >
                            <HeaderTemplate>
                                Defalut/Selected
                            </HeaderTemplate>
                                <ItemStyle HorizontalAlign="Center" BackColor="white" />
                                <ItemTemplate>
                                    <asp:DropDownList ID="cmbtransmode" runat="server" DataValueField="codeid" DataTextField="codedesc" CssClass="blackfnt" BackColor="White">
                                    </asp:DropDownList>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-CssClass="blackfnt" >
                            <HeaderTemplate>
                                Enabled TransMode
                            </HeaderTemplate>
                                <ItemStyle HorizontalAlign="Center" BackColor="white" />
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkenabled" runat="server" CssClass="blackfnt" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-CssClass="blackfnt" >
                            <HeaderTemplate>
                                Computerised
                            </HeaderTemplate>
                                <ItemStyle HorizontalAlign="Center" BackColor="white" />
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkcomputerised" runat="server" CssClass="blackfnt" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell ColumnSpan="3" HorizontalAlign="center">
                    <asp:Button ID="btnsubmit" runat="server" OnClick="btnsubmit_Click" Text="Submit"
                        CssClass="blackfnt" />
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </asp:Panel>
</asp:Content>
