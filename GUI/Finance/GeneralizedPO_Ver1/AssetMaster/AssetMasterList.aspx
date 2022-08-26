<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="AssetMasterList.aspx.cs" Inherits="GUI_Finance_GeneralizedPO_AssetMaster_AssetMasterList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <div style="width: 10in">
        <table align="left" width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table border="0" align="left" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">                                        
                        <tr>
                            <td align="right">
                                <table border="0" cellspacing="1" cellpadding="3" align="center" class="boxbg">
                                    <tr bgcolor="#FFFFFF">
                                        <td>
                                            <center>
                                                <font class="blackfnt"><strong>Selected Query AS Follow </strong></font>
                                            </center>
                                        </td>
                                    </tr>
                                    <tr bgcolor="#FFFFFF">
                                        <td>
                                            <asp:Label ID="Select_crt" runat="server" Text="" CssClass="blackfnt"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                                <table border="0" cellpadding="0" cellspacing="1" align="center" style="width: 783px">
                                    <tr>
                                        <td>
                                            <br />
                                            <asp:UpdatePanel ID="u1" runat="server" UpdateMode="Conditional">
                                                <ContentTemplate>
                                                    <asp:GridView ID="GridView1" runat="server" AllowPaging="true" AllowSorting="true"
                                                        AutoGenerateColumns="false" BorderColor="#8ba0e5" BorderWidth="1" CellPadding="5"
                                                        CellSpacing="1" EmptyDataText="No Records Found..." HeaderStyle-CssClass="dgHeaderStyle"
                                                        PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
                                                        PageSize="30" Width="100%" CssClass="blackfnt">
                                                        <Columns>
                                                            <asp:BoundField DataField="sn" HeaderText="Sr. No">
                                                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="assetcd" HeaderText="Asset Code">
                                                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="assetname" HeaderText="Asset Name">
                                                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                                                            </asp:BoundField>                                                          
                                                            <asp:BoundField DataField="Account" HeaderText="Expense Account">
                                                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                                                            </asp:BoundField>                                                           
                                                            <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderText="Edit" HeaderStyle-Font-Bold="true">
                                                                <HeaderStyle HorizontalAlign="left" Wrap="False" CssClass="blackfnt" />
                                                                <ItemStyle CssClass="blackfnt" />
                                                                <ItemTemplate>
                                                                    <label class="blackfnt">
                                                                        <asp:HyperLink Font-Underline="True" runat="server" NavigateUrl='<%#"AssetMasterAdd.aspx?Operation=EDIT&accode="+DataBinder.Eval(Container.DataItem, "assetcd")%>'
                                                                            Text='Edit' ID="Hyperlink3" />
                                                                    </label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <PagerStyle HorizontalAlign="Left" />
                                                        <HeaderStyle CssClass="dgHeaderStyle" />
                                                    </asp:GridView>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
