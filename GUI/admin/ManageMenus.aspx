<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPageSA.master" AutoEventWireup="true"
    CodeFile="ManageMenus.aspx.cs" Inherits="GUI_admin_ManageMenus" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Manage Menus</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br />
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:UpdatePanel ID="u1"  UpdateMode="Conditional" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="dgGeneral" runat="server" AutoGenerateColumns="False" DataKeyNames="MenuID"
                            DataSourceID="SqlDataSource1" CellSpacing="2" CellPadding="2" HeaderStyle-CssClass="dgHeaderStyle"
                            CssClass="dgRowStyle" OnRowDataBound="dg_RowDataBound">
                            <Columns>
                                <asp:CommandField ShowDeleteButton="false" ShowEditButton="True" />
                                <asp:BoundField DataField="L0_Text" HeaderText="Menu Level 0" InsertVisible="false"
                                    ReadOnly="True" SortExpression="L0_Text" />
                                <asp:BoundField DataField="L1_Text" HeaderText="Menu Level 1" ReadOnly="True" SortExpression="L1_Text" />
                                <asp:BoundField DataField="Text" HeaderText="Menu Level 2" SortExpression="Text" />
                                <asp:BoundField DataField="NavigationURL" HeaderText="Navigatin URL [Level 2]" SortExpression="Text" />
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
    <%--    ConnectionString="Data Source=WEBXPRESS;Initial Catalog=WebXNet;User ID=sa;Password=sys"
--%>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues"
        DeleteCommand="DELETE FROM [WebX_Master_Menu2] WHERE [MenuID] = @original_MenuID"
        InsertCommand="INSERT INTO [WebX_Master_Menu2] ([Text], [Description], [SysMenu], [ParentID]) VALUES (@Text, @Description, @SysMenu, @ParentID)"
        OldValuesParameterFormatString="original_{0}" ProviderName="System.Data.SqlClient"
        SelectCommand="SELECT * FROM [vw_Menu_All_Levels_With_FinalAppModule]" UpdateCommand="UPDATE [WebX_Master_Menu2] SET [Text] = @Text, NavigationURL=@NavigationURL WHERE [MenuID] = IsNull(@original_MenuID,0)">
        <DeleteParameters>
            <asp:Parameter Name="original_L0_Text" Type="String" />
            <asp:Parameter Name="original_L1_Text" Type="String" />
            <asp:Parameter Name="original_Text" Type="String" />
            <asp:Parameter Name="original_MenuID" Type="Int32" />
            <asp:Parameter Name="original_NavigationURL" Type="String" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="L0_Text" Type="String" />
            <asp:Parameter Name="L1_Text" Type="String" />
            <asp:Parameter Name="Text" Type="String" />
            <asp:Parameter Name="MenuID" Type="Int32" />
            <asp:Parameter Name="NavigationURL" Type="String" />
            <asp:Parameter Name="original_L0_Text" Type="String" />
            <asp:Parameter Name="original_L1_Text" Type="String" />
            <asp:Parameter Name="original_Text" Type="String" />
            <asp:Parameter Name="original_MenuID" Type="Int32" />
            <asp:Parameter Name="original_NavigationURL" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
