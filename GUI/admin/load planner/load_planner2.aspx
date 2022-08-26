<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="load_planner2.aspx.cs" Inherits="GUI_admin_VehicleMaster_VehicleMasterAdd"
    EnableEventValidation="false" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <div align="left" style="width: 10in">
        <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 940px">
            <tr>
                <td height="30" style="width: 895px">
                    <a><font class="blklnkund"><strong>Module</strong></font></a> &gt; <a><font class="blklnkund">
                        <strong>Administrator </strong></font></a>&gt; <a href="../operations.aspx"><font
                            class="blklnkund"><strong>Operations</strong></font></a> <font class="bluefnt"><strong>
                                &gt; Load Planner</strong> </font>
                </td>
            </tr>
        </table>
        <br />
        <br />
        <br />
        <center>
            <asp:Label ID="Label1" Font-Bold="true" CssClass="blackfnt" Text="You Selected" runat="server"
                Width="145px"></asp:Label>
        </center>
        <asp:Panel ID="pnl2" runat="server">
            <table width="100%" border="0" class="boxbg" cellspacing="1" cellpadding="5">
                <tr bgcolor="#ffffff" align="center">
                    <td valign="top" colspan="4" align="right">
                        <asp:Label ID="lblvehcap" CssClass="blackfnt" Text="Vehicle Capacity :" runat="server"
                            Width="145px"></asp:Label>
                        <br />
                        <asp:Label ID="lblwht" CssClass="blackfnt" Text="Total Weight :" runat="server" Width="145px"></asp:Label>
                        <br />
                        <asp:Label ID="lblload" Font-Bold="true" CssClass="blackfnt" Text="" runat="server"
                            Width="145px"></asp:Label>
                        <br />
                        <br />
                        <br />
                        <center>
                            <asp:GridView ID="GV_Booking" runat="server" align="center" BorderWidth="0" CellPadding="5"
                                HeaderStyle-CssClass="bgbluegrey" CellSpacing="1" PagerStyle-HorizontalAlign="left"
                                CssClass="boxbg" FooterStyle-CssClass="boxbg" AllowPaging="false" FooterStyle-BackColor="white"
                                AllowSorting="False" AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]"
                                PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">
                                <PagerStyle VerticalAlign="Bottom" />
                                <Columns>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <asp:Label ID="Label21" Text='<%# Session["DocketCalledAs"] +" No." %>' runat="server"></asp:Label>
                                        </HeaderTemplate>
                                        <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                                        <ItemStyle HorizontalAlign="center" CssClass="blackfnt" BackColor="white" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label32" Text='<%#DataBinder.Eval(Container.DataItem, "dockno")%>'
                                                runat="server"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <asp:Label ID="Label24" Text='<%# Session["DocketCalledAs"] +" Date" %>' runat="server"></asp:Label>
                                        </HeaderTemplate>
                                        <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                                        <ItemStyle HorizontalAlign="center" CssClass="blackfnt" BackColor="white" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label35" Text='<%#DataBinder.Eval(Container.DataItem, "dt")%>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="actuwt" HeaderText="Actual Weight" ItemStyle-Wrap="true"
                                        ItemStyle-HorizontalAlign="center" ItemStyle-BackColor="White">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle Width="20" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="chrgwt" HeaderText="Charged Weight" ItemStyle-Wrap="true"
                                        ItemStyle-BackColor="White">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle Width="20" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </center>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <br />
        <table width="100%" border="0" class="boxbg" cellspacing="1" cellpadding="5">
            <tr bgcolor="#FFFFFF">
                <td valign="top" colspan="4" align="center">
                    <asp:Button ID="btn_csv" Width="150" Text="XLS" OnClick="btn_csv_Click" runat="server" />
                </td>
            </tr>
        </table>
    </div>
    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
