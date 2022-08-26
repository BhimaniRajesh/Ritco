<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="TyreException.aspx.cs" Inherits="GUI_Fleet_Tyre_TyreException" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table width="100%">
        <tr>
            <td>
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Exception Of Tyre</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
                </br>
            </td>
        </tr>
    </table>
    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                <tr>
                    <td align="right">
                        <img src="../../../images/loading.gif" alt="" />
                    </td>
                    <td>
                        <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                    </td>
                </tr>
            </table>
            <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
                background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
                opacity: .50; -moz-opacity: .50;" runat="server">
                <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                    left: 50%;" ID="Panel2" runat="server">
                </asp:Panel>
            </asp:Panel>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <table width="80%" cellpadding="0" cellspacing="0" border="1">
        <tr class="bgwhite" align="left" id="trClaim" runat="server">
            <td>
                <asp:GridView ID="GV_TyreException" BorderWidth="1" CellSpacing="0" CellPadding="0"
                    runat="server" Visible="true" EmptyDataText="No Data Found ...." AutoGenerateColumns="false"
                    OnRowDataBound="GV_TyreExceptionDataBound" Width="100%" CssClass="boxbg" HeaderStyle-CssClass="bgbluegrey"
                    FooterStyle-CssClass="bgwhite" PagerSettings-Mode="NumericFirstLast" PageSize="10"
                    SelectedIndex="1">
                    <Columns>
                        <asp:TemplateField HeaderText="" ItemStyle-Width="15px" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <%--<asp:CheckBox ID="chkSelectAll" runat="server" Checked="true" OnCheckedChanged="SelectAll" AutoPostBack="true" />--%>
                                <input type="CheckBox" name="SelectAllCheckBox" onclick="SelectAll(this)" checked="checked" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkSelect" runat="server" Checked="true" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <asp:Label ID="Label2416" runat="server" Text="Sr.</br>No"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtSrNo" runat="server" Enabled="false" BorderStyle="Groove"
                                    Text="<%# Container.DataItemIndex+1 %>" onfocus="this.blur()" Style="text-align: center"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <asp:Label ID="Label2412" runat="server" Text="Date Of </br> Removal</br> of Tyre"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtRemovalDT" runat="server" Enabled="false" BorderStyle="Groove"
                                    Text="" onfocus="this.blur()" Style="text-align: center"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <asp:Label ID="Label2441" runat="server" Text="Vehicle </br>No."></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtVEHNO" runat="server" Enabled="false" BorderStyle="Groove"
                                    Text="" onfocus="this.blur()" Style="text-align: center"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <asp:Label ID="Label2415" runat="server" Text="No.of</br> Tyres"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtNoOfTyre" runat="server" Enabled="false" BorderStyle="Groove"
                                    Text="" onfocus="this.blur()" Style="text-align: center"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <asp:Label ID="Label25641" runat="server" Text="Sys.Gen.</br>Tyre No."></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtSysTyreNo" runat="server" Enabled="false" BorderStyle="Groove"
                                    Text="" onfocus="this.blur()" Style="text-align: center"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <asp:Label ID="Label2481" runat="server" Text="Vehicle No."></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:DropDownList ID="ddlVehicleNo" runat="server">
                                </asp:DropDownList>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <asp:Label ID="Labe8l241" runat="server" Text="No. of Tyres"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtNoTyres" runat="server" Enabled="false" BorderStyle="Groove"
                                    Text="" Style="text-align: center"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <asp:Label ID="Label2419" runat="server" Text="Tyre No."></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtTyreNoNew" runat="server" Enabled="false" BorderStyle="Groove" Text=""
                                     Style="text-align: center"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="" ItemStyle-CssClass="bgwhite">
                            <HeaderStyle CssClass="blackboldfnt" />
                            <HeaderTemplate>
                                <asp:Label ID="Label241" runat="server" Text="Pending/Excess"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtPendingExcess" runat="server" Enabled="false" BorderStyle="Groove"
                                    Text="Excess" onfocus="this.blur()" Style="text-align: center"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr class="bgbluegrey">
        <td align="center">
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" 
                onclick="btnSubmit_Click" />
        </td>
        </tr>
    </table>
</asp:Content>
