<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="FrmToPayFollowUp.aspx.cs" Inherits="FrmPaidFollowUp" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/jscript">
//    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
    </script>

    <br />
    <div align="left">
        <table style="width: 10in">
            <tr>
                <td align="left">
                    <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                        <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_finance.aspx"><font class="blklnkund">
                            <b>Finance & Accounts</b></font></a> <b>&gt; </b><font class="bluefnt"><b>To Pay Followup
                                Report</b></font>
                </td>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img src="../../images/back.gif" border="0" alt="" /></a>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <table border="0"  CellSpacing="1" CellPadding="5" class="boxbg" style="width: 362px;
        height: 19px">
        <tr class="bgbluegrey">
            <td align="center" class="blackfnt" colspan="3" style="height: 19px">
                Your Query Here
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="left" class="blackfnt">
                Date Range
            </td>
            <td align="left" class="blackfnt">
                <div align="left">
                    <asp:Label ID="lblDateRange" runat="server" CssClass="blackfnt" Text="Label" Width="233px"></asp:Label></div>
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="left" class="blackfnt">
                RO
            </td>
            <td align="left" class="blackfnt">
                <div align="left">
                    <asp:Label ID="lblRO" runat="server" CssClass="blackfnt" Text="Label" Width="233px"></asp:Label></div>
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="left" class="blackfnt">
                Location</td>
            <td align="left" class="blackfnt">
                <div align="left">
                    <asp:Label ID="lblLocation" runat="server" CssClass="blackfnt" Text="Label" Width="233px"></asp:Label></div>
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="left" class="blackfnt">
                Customer Code</td>
            <td align="left" class="blackfnt">
                <div align="left">
                    <asp:Label ID="lblCCode" runat="server" CssClass="blackfnt" Text="Label" Width="233px"></asp:Label></div>
            </td>
        </tr>
    </table>
    <asp:TextBox ID="txtLocation" runat="server" Width="168px" ReadOnly="True" Style="z-index: 102;
        left: 175px; position: absolute; top: 177px" Visible="False"></asp:TextBox>
    <asp:TextBox ID="TxtCCode" runat="server" Width="168px" ReadOnly="True" Style="z-index: 102;
        left: 171px; position: absolute; top: 177px" Visible="False"></asp:TextBox>
    <asp:TextBox ID="TxtRO" runat="server" Width="168px" ReadOnly="True" Style="z-index: 102;
        left: 174px; position: absolute; top: 174px" Visible="False"></asp:TextBox>
    <asp:TextBox ID="TxtTDt" runat="server" Visible="False"></asp:TextBox>
    <asp:TextBox ID="TxtFDt" runat="server" Visible="False"></asp:TextBox>
    <asp:TextBox ID="TxtDateRange" runat="server" Visible="False"></asp:TextBox>
    <br />
    <div align="left" style="width: 10in">
        <asp:DataGrid ID="GrdPaidFollow" ShowFooter="true" CellSpacing="1" BorderWidth="0"
            CellPadding="5" OnItemCommand="gotolink" OnItemDataBound="eventhandler" runat="server"
            PagerStyle-Mode="NumericPages" PagerStyle-Position="Bottom" PagerStyle-HorizontalAlign="Center"
            PagerStyle-CssClass="pageLinks" AllowPaging="True" HeaderStyle-CssClass="bgbluegrey"
            FooterStyle-CssClass="boxbg" AllowSorting="True" CssClass="boxbg"
            OnPageIndexChanged="PageIndexChanged_Click" OnSortCommand="SortCommand_Click"
            AutoGenerateColumns="False" PagerSettings-FirstPageText="[First]" Width="10in">
            <FooterStyle CssClass="boxbg" BackColor="white" HorizontalAlign="Center" />
            <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Center"/>
            <Columns>
                <asp:TemplateColumn HeaderText="Sr.No"  ItemStyle-BackColor="white">
                <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lblId" Text="<%# Container.DataSetIndex+1 %>" runat="server" CssClass="blackfnt"></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="lblTotal" Text="Total" Font-Bold="true" runat="server" CssClass="blackfnt"></asp:Label>
                    </FooterTemplate>
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Loccode" Visible="False"  ItemStyle-BackColor="white">
                <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lblloccode" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.loccode") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Location"  ItemStyle-BackColor="white">
                <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lbllocation" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.locName") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="To Pay Dockets Booked" ItemStyle-BackColor="white">
                <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lb1" CssClass="blackfnt" Font-Underline="true" CommandName="booked"
                            Text='<%# DataBinder.Eval(Container, "DataItem.booked") %>' runat="server"></asp:LinkButton>
                    </ItemTemplate>
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Arrived"  ItemStyle-BackColor="white">
                <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lb2" CssClass="blackfnt" Font-Underline="true" CommandName="arrived"
                            Text='<%# DataBinder.Eval(Container, "DataItem.arrived") %>' runat="server"></asp:LinkButton>
                    </ItemTemplate>
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="MR Generated"  ItemStyle-BackColor="white">
                <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lb3" CssClass="blackfnt" Font-Underline="true" CommandName="generated"
                            Text='<%# DataBinder.Eval(Container, "DataItem.generated") %>' runat="server"></asp:LinkButton>
                    </ItemTemplate>
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Amount" ItemStyle-BackColor="white">
                <ItemStyle HorizontalAlign="Right" />
                    <ItemTemplate>
                        <asp:Label ID="l1" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.gen_amt") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle CssClass="blackfnt" />
                    <FooterStyle  HorizontalAlign="Right" />
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="MR Closed"  ItemStyle-BackColor="white">
                <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lb4" CssClass="blackfnt" Font-Underline="true" CommandName="closed"
                            Text='<%# DataBinder.Eval(Container, "DataItem.Closed") %>' runat="server"></asp:LinkButton>
                    </ItemTemplate>
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Amount"  ItemStyle-BackColor="white">
                <ItemStyle HorizontalAlign="Right" />
                    <ItemTemplate>
                        <asp:Label ID="l2" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.closed_amt") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                    <FooterStyle  HorizontalAlign="Right" />
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="MR Outstanding"  ItemStyle-BackColor="white">
                <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lb5" CssClass="blackfnt" Font-Underline="true" CommandName="out_docket"
                            Text='<%# DataBinder.Eval(Container, "DataItem.out_docket") %>' runat="server"></asp:LinkButton>
                    </ItemTemplate>
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Amount" ItemStyle-BackColor="white">
                <ItemStyle HorizontalAlign="Right" />
                    <ItemTemplate>
                        <asp:Label ID="l3" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.out_amount") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle CssClass="blackfnt" />
                    <FooterStyle  HorizontalAlign="Right" />
                </asp:TemplateColumn>
            </Columns>
            <PagerStyle CssClass="pageLinks" BackColor="white" HorizontalAlign="Center" Mode="NumericPages" />
        </asp:DataGrid>
    </div>
    &nbsp;<br />
    <br />
    <div align="center" style="width: 10in">
        <asp:Button ID="Button1" Visible="false" runat="server" OnClick="Button1_Click" Text="Print"
            Width="54px" />
        <asp:Button ID="cmdexcel" runat="server" OnClick="cmdexcel_Click" Text="Excel" Width="54px" />
    </div>
</asp:Content>
