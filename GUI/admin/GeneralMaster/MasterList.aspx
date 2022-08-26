<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="MasterList.aspx.cs" Inherits="GUI_admin_GeneralMaster_MasterList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript">
        function popupmenu2(choice) {
            var winOpts = "scrollbars=yes,resizable=yes,width=" + 500 + ",height=" + 400 + "";
            confirmWin = window.open(choice, "", winOpts);
        }

        function popupView(mastercode) {

            var winOpts = "scrollbars=yes,resizable=yes,width=" + 500 + ",height=" + 400 + "";
            window.open("GeneralMasterView.aspx?mastercode=" + mastercode + "&print=N", "", winOpts);
            return false;
        }

        function downloadXLS(mastercode) {
            var winOpts = "scrollbars=yes,resizable=yes,width=" + 500 + ",height=" + 400 + "";
            window.open("GeneralMasterView.aspx?mastercode=" + mastercode + "&print=D", "", winOpts);
            return false;
        }
    </script>

    <br />
    <br />
    <div align="left" style="width: 9.2in">
        <asp:GridView align="center" ID="gvmasterlist" runat="server" BorderWidth="0" BorderStyle="None"
            CellPadding="2" CellSpacing="1" HeaderStyle-CssClass="hrow" AllowSorting="false"
            AllowPaging="false" PageSize="20" RowStyle-CssClass="nrow" PagerStyle-HorizontalAlign="left"
            CssClass="stbl" FooterStyle-CssClass="frow" PagerSettings-Mode="NumericFirstLast"
            AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
            EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange" OnSelectedIndexChanged="gvmasterlist_SelectedIndexChanged"
            OnRowDataBound="gvmasterlist_OnRowDataBound" Width="100%">
            <Columns>
                <asp:BoundField DataField="SerialNo" HeaderText="Sr. No">
                    <ItemStyle HorizontalAlign="Center" />
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="TMS General Masters" SortExpression="tot1">
                    <HeaderStyle CssClass="blklnkuld" Width="2in" Wrap="true" />
                    <ItemStyle BackColor="White" Height="15px" Wrap="true" HorizontalAlign="Left" Width="2in" />
                    <ItemTemplate>
                        <a href="GeneralMaster.aspx?mastercode=<%# DataBinder.Eval( Container.DataItem,"headercode") %>">
                            <%# DataBinder.Eval( Container.DataItem,"headerdesc") %>
                        </a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Description" SortExpression="tot1">
                    <HeaderStyle CssClass="blklnkuld" />
                    <ItemStyle BackColor="White" Height="15px"  Width="3in" Wrap="true" HorizontalAlign="Left" />
                    <ItemTemplate>
                        <%# DataBinder.Eval(Container.DataItem, "Description")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Masters/forms where used" SortExpression="tot1">
                    <HeaderStyle CssClass="blklnkuld" />
                    <ItemStyle BackColor="White" Height="15px" HorizontalAlign="Left" Width="3in" Wrap="true" />
                    <ItemTemplate>
                        <%# DataBinder.Eval(Container.DataItem, "whereused")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField SortExpression="tot1">
                    <HeaderStyle CssClass="blklnkuld" />
                    <ItemStyle BackColor="White" Height="15px" HorizontalAlign="center" Width="0.5in" Wrap="false" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkBtnGeneralmasterView" CssClass="bluefnt" runat="server" Text="View" />
                        <asp:HiddenField ID="hdnMasterCode" runat="server" Value='<%# DataBinder.Eval( Container.DataItem,"headercode") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField SortExpression="tot1">
                    <HeaderStyle CssClass="blklnkuld" />
                    <ItemStyle BackColor="White" Height="15px" HorizontalAlign="center" Wrap="false" Width="1in"/>
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkBtnGeneralmasterXLS" CssClass="bluefnt" runat="server" Text="Download XLS" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <br />
        <br />
         <asp:GridView align="center" ID="gvFleetMasterList" runat="server" BorderWidth="0"
            BorderStyle="None" CellPadding="2" CellSpacing="1" HeaderStyle-CssClass="hrow"
            AllowSorting="false" RowStyle-CssClass="nrow" AllowPaging="false" PageSize="20"
            PagerStyle-HorizontalAlign="left" CssClass="stbl" FooterStyle-CssClass="frow"
            PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]"
            PagerSettings-LastPageText="[Last]" OnPageIndexChanging="pgChangeFleetMaster" OnRowDataBound="gvmasterlist_OnRowDataBound"
            Width="100%">
            <Columns>
                <asp:BoundField DataField="SerialNo" HeaderText="Sr. No">
                    <ItemStyle HorizontalAlign="Center" />
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Fleet General Masters" SortExpression="tot1">
                    <HeaderStyle CssClass="blklnkuld" Width="2in" />
                    <ItemStyle Height="15px" HorizontalAlign="Left" Width="2in" Wrap="true" />
                    <ItemTemplate>
                        <a href="GeneralMaster.aspx?mastercode=<%# DataBinder.Eval( Container.DataItem,"headercode") %>">
                            <%# DataBinder.Eval( Container.DataItem,"headerdesc") %>
                        </a>
                    </ItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Description" SortExpression="tot1">
                    <HeaderStyle CssClass="blklnkuld" />
                    <ItemStyle BackColor="White" Height="15px" HorizontalAlign="Left" Width="3in" Wrap="true" />
                    <ItemTemplate>
                        <%# DataBinder.Eval(Container.DataItem, "Description")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Masters/forms where used" SortExpression="tot1">
                    <HeaderStyle CssClass="blklnkuld" />
                    <ItemStyle BackColor="White" Height="15px" HorizontalAlign="Left" Width="3in" Wrap="true"/>
                    <ItemTemplate>
                        <%# DataBinder.Eval(Container.DataItem, "whereused")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField SortExpression="tot1">
                    <HeaderStyle CssClass="blklnkuld" />
                    <ItemStyle BackColor="White" Height="15px" HorizontalAlign="center"  Width="0.5in" Wrap="false" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkBtnGeneralmasterView" CssClass="bluefnt" runat="server" Text="View" />
                        <asp:HiddenField ID="hdnMasterCode" runat="server" Value='<%# DataBinder.Eval( Container.DataItem,"headercode") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField SortExpression="tot1">
                    <HeaderStyle CssClass="blklnkuld" />
                    <ItemStyle BackColor="White" Height="15px" HorizontalAlign="center" Width="1in" Wrap="false" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkBtnGeneralmasterXLS" CssClass="bluefnt" runat="server" Text="Download XLS" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        
    </div>
</asp:Content>
