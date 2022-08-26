<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="MasterList.aspx.cs" Inherits="GUI_admin_GeneralMaster_MasterList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript">
        function popupmenu2(choice) {
            var winOpts = "scrollbars=yes,resizable=yes,width=" + 500 + ",height=" + 400 + "";
            confirmWin = window.open(choice, "", winOpts);
        }
    </script>

    <br />
    <br />
    <div align="left" style="width: 9.2in">
        <asp:GridView align="center" ID="gvmasterlist" runat="server" BorderWidth="0" BorderStyle="None"
            CellPadding="2" CellSpacing="1" HeaderStyle-CssClass="hrow" AllowSorting="true"
            AllowPaging="false" PageSize="20" RowStyle-CssClass="nrow" PagerStyle-HorizontalAlign="left"
            CssClass="stbl" FooterStyle-CssClass="frow" PagerSettings-Mode="NumericFirstLast"
            AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
            EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange" OnSelectedIndexChanged="gvmasterlist_SelectedIndexChanged"
            Width="50%">
            <Columns>
                <asp:BoundField DataField="SerialNo" HeaderText="Sr. No">
                    <ItemStyle HorizontalAlign="Center" />
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="TMS General Masters" SortExpression="tot1">
                    <HeaderStyle CssClass="blklnkuld" />
                    <ItemStyle BackColor="White" Height="15px" HorizontalAlign="Left" />
                    <ItemTemplate>
                        <a href="GeneralMaster.aspx?mastercode=<%# DataBinder.Eval( Container.DataItem,"headercode") %>">
                            <%# DataBinder.Eval( Container.DataItem,"headerdesc") %>
                        </a>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <br />
        <br />
        <asp:GridView align="center" ID="gvFleetMasterList" runat="server" BorderWidth="0"
            BorderStyle="None" CellPadding="2" CellSpacing="1" HeaderStyle-CssClass="hrow"
            AllowSorting="true" RowStyle-CssClass="nrow" AllowPaging="false" PageSize="20"
            PagerStyle-HorizontalAlign="left" CssClass="stbl" FooterStyle-CssClass="frow"
            PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]"
            PagerSettings-LastPageText="[Last]" OnPageIndexChanging="pgChangeFleetMaster"
            Width="50%">
            <Columns>
                <asp:BoundField DataField="SerialNo" HeaderText="Sr. No">
                    <ItemStyle HorizontalAlign="Center" />
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Fleet General Masters" SortExpression="tot1">
                    <HeaderStyle CssClass="blklnkuld" />
                    <ItemStyle Height="15px" HorizontalAlign="Left" />
                    <ItemTemplate>
                        <a href="GeneralMaster.aspx?mastercode=<%# DataBinder.Eval( Container.DataItem,"headercode") %>">
                            <%# DataBinder.Eval( Container.DataItem,"headerdesc") %>
                        </a>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
