<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="LocWiseOtherCharges.aspx.cs" Inherits="GUI_admin_CustomerContractMaster_DeliveryPointCharges"
     %>

<%@ Register Src="~/GUI/admin/CustomerContractMaster/CustContractInfo.ascx" TagName="CustInfo"
    TagPrefix="cust" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <div>

        <script type="text/javascript" language="javascript" src="../../../images/commonJs.js"></script>

        <cust:CustInfo runat="server" ID="cstheader" />
        <br />
        <table width="600">
            <tr class="bgwhite">
                <td width="100" class="blackfnt">
                    Charge Name :
                </td>
                <td>
                    <asp:Label ID="lblchargename" runat="server" Font-Bold="true" CssClass="blackfnt"></asp:Label>&nbsp;
                </td>
            </tr>
        </table>
        <br />
        <br />
        <asp:UpdatePanel ID="updtPnl" runat="server">
            <ContentTemplate>
                <asp:Menu ID="menuTabs" CssClass="menuTabs" StaticMenuItemStyle-CssClass="tab" StaticSelectedStyle-CssClass="selectedTab"
                    Orientation="Horizontal" OnMenuItemClick="menuTabs_MenuItemClick" EnableViewState="true"
                    runat="server">
                    <Items>
                        <asp:MenuItem Text="Tab1" Value="0" Selected="true" />
                    </Items>
                </asp:Menu>
                <div class="tabBody">
                    <table>
                        <tr>
                            <td>
                                <asp:MultiView ID="multiTabs" ActiveViewIndex="0" runat="server" EnableViewState="true">
                                    <asp:View ID="view1" runat="server">
                                        <asp:GridView HorizontalAlign="left" ID="grvcharges" runat="server" BorderWidth="0"
                                            AllowPaging="true" PageSize="25" CellSpacing="1" CellPadding="2" AllowSorting="true"
                                            PagerStyle-HorizontalAlign="left" CssClass="boxbg" HeaderStyle-CssClass="dgHeaderStyle"
                                            FooterStyle-CssClass="boxbg" AutoGenerateColumns="false" HeaderStyle-Font-Bold="true" EmptyDataText="No Records Found..." 
                                            OnRowDataBound="grvcharges_RowDataBound" OnPageIndexChanging="grvcharges_PageIndexChanging"
                                            >
                                            <Columns>
                                                <asp:TemplateField HeaderText="SrNo" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblSrno" Text="<%# Container.DataItemIndex+1 %>"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="From" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblFrom" Text='<%# DataBinder.Eval( Container.DataItem,"fromLocName") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="To" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblTo" Text='<%# DataBinder.Eval( Container.DataItem,"toLocName") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Tran. Mode" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblTransMode" Text='<%# DataBinder.Eval( Container.DataItem,"trans_type_desc") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Mimimum Charge(in RS)" HeaderStyle-HorizontalAlign="Center"
                                                    ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblMinChg" Text='<%# DataBinder.Eval( Container.DataItem,"minrate") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Charge Rate" HeaderStyle-HorizontalAlign="Center"
                                                    ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblChgRate" Text='<%# DataBinder.Eval( Container.DataItem,"rate") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Maximum Charge(in Rs)" HeaderStyle-HorizontalAlign="Center"
                                                    ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblMaxChg" Text='<%# DataBinder.Eval( Container.DataItem,"maxrate") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Rate Type" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblRateType" Text='<%# DataBinder.Eval( Container.DataItem,"RateTypeDesc") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <RowStyle CssClass="dgRowStyle" />
                                        </asp:GridView>
                                    </asp:View>
                                </asp:MultiView>
                            </td>
                        </tr>
                    </table>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
