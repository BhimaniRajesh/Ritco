<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ListAll.aspx.cs" Inherits="GUI_admin_VehicleMaster_ListAll" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <br />
    <div align="center" style="width: 10in">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;
                        height: 228px">
                        <tr>
                            <td align="left" style="height: 1px">
                                <a href=""><font class="blklnkund"><strong>Module</strong></font></a> &gt; <a>
                                    <font class="blklnkund"><strong>Administrator </strong></font></a>&gt; <a href="../operations.aspx"><font
                                        class="blklnkund"><strong>Operations</strong></font></a> <font class="bluefnt">
                                            <strong>&gt;Route Listing</strong> </font>
                            </td>
                            <td align="right" style="height: 3px">
                                <a href="javascript:window.history.go(-1)" title="back">
                                    <img src="../../images/back.gif" border="0" alt="" /></a></td>
                        </tr>
                        <tr>
                            <td colspan="2" align="right" style="height: 392px">
                                <br />
                                <table border="0" cellspacing="1" cellpadding="3" align="center" class="boxbg">
                                    <tr bgcolor="#FFFFFF">
                                        <td>
                                            <font class="blackfnt"><b>Route Listing : &nbsp;</b></font></td>
                                        <td width="100">
                                            <font class="blackfnt">All</font></td>
                                    </tr>
                                </table>
                                <br />
                                <br />
                                <table border="0" cellpadding="0" cellspacing="1" align="center" style="width: 783px">
                                    <tr>
                                        <td>
                                            <asp:UpdatePanel ID="u1" runat="server"  UpdateMode="Conditional">
                                                <ContentTemplate>
                                                    <asp:GridView ID="GridView1" runat="server" AllowSorting="true"
                                                        AutoGenerateColumns="false" BorderColor="#8ba0e5" BorderWidth="1" CellPadding="5"
                                                        CellSpacing="1" EmptyDataText="No Records Found..." HeaderStyle-CssClass="dgHeaderStyle"
                                                        OnPageIndexChanging="pgChange" PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
                                                        Width="100%" CssClass="blackfnt">
                                                        <Columns>
                                                            <asp:TemplateField Visible="false">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkrutcode" Text='<%# Eval("rutcd") %>' runat="server"></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="Sr. No" HeaderText="Sr. No">
                                                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="rutcd" HeaderText="Route Code">
                                                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="rutnm" HeaderText="Route Name">
                                                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="rutmod" HeaderText="Route Mode">
                                                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="rutkm" HeaderText="Total KM">
                                                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                                                            </asp:BoundField>
                                                             <asp:BoundField DataField="transhrs" HeaderText="Total Transit(Hrs.)">
                                                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                                                            </asp:BoundField>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkedit" CssClass="blackfnt" Text="Edit" Font-Underline="true" OnClick="jump" runat="server"></asp:LinkButton>
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
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <br />
    <br />
</asp:Content>
