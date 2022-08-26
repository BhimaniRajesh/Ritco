<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="FrmDocketsBookedButNotYetLoaded.aspx.cs" Inherits="FrmPaidFollowUp"
    EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/jscript">
//    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
    </script>

    <br />
    <table style="width: 1000px">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Operation.aspx"><font class="blklnkund">
                        <b>Operations</b></font></a> <b>&gt; </b><font class="bluefnt"><b><%=Convert.ToString(Session["DocketCalledAs"]) + " Booked But Not Yet Loaded Report" %></b></font>
            </td>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img src="../../images/back.gif" border="0" alt="" /></a>
            </td>
        </tr>
    </table>
    <br />
    <div align="left">
        <table border="0"  CellSpacing="1" CellPadding="5" colspan="2" bgcolor="#ffffff" class="boxbg">
            <tr bgcolor="#ffffff" class="bgbluegrey">
                <td align="center" style="height: 25px" colspan="3">
                    <font class="blackfnt"><b>You Selected</b></font></td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="left" style="height: 25px; width: 23%;">
                    <font class="blackfnt"><b>Date Range</b></font></td>
                <td align="left" style="height: 25px">
                    <font class="blackfnt">
                        <asp:Label ID="lbldaterange" runat="server">
                        </asp:Label>
                    </font>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="left" style="width: 23%">
                    <font class="blackfnt"><b>Region</b></font>
                </td>
                <td align="left">
                    <font class="blackfnt">
                        <asp:Label ID="lblRO" runat="server">
                        </asp:Label>
                    </font>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="left" style="width: 23%">
                    <font class="blackfnt"><b>Location</b></font>
                </td>
                <td align="left">
                    <font class="blackfnt">
                        <asp:Label ID="lblLocation" runat="server">
                        </asp:Label>
                    </font>
                </td>
            </tr>
        </table>
        <asp:TextBox ID="TxtDateRange" runat="server" Width="170px" ReadOnly="True" Visible="False"
            Style="z-index: 102; left: 391px; position: absolute; top: 49px"></asp:TextBox>
        <asp:TextBox ID="TxtRO" runat="server" Width="168px" ReadOnly="True" Visible="False"
            Style="z-index: 102; left: 391px; position: absolute; top: 84px"></asp:TextBox>
        <asp:TextBox ID="txtLocation" runat="server" Width="168px" ReadOnly="True" Visible="False"
            Style="z-index: 102; left: 391px; position: absolute; top: 120px"></asp:TextBox>
        <asp:TextBox ID="TxtFDt" runat="server" Visible="False"></asp:TextBox>
        <asp:TextBox ID="TxtTDt" runat="server" Visible="False"></asp:TextBox><br />
        <asp:GridView ID="GrdLoadUnload" OnRowDataBound="GrdLoadUnload_RowDataBound" OnPageIndexChanging="PageIndexChanged_Click"
            PagerStyle-Mode="NumericPages" OnRowCommand="GridView1_RowCommand" CssClass="boxbg"
            PageSize="10" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey" runat="server"
            SelectedIndex="1" EmptyDataText="No Records Found !!!!" EmptyDataRowStyle-CssClass="blackfnt"
            BorderWidth="0" CellSpacing="1" CellPadding="5">
            <Columns>
                <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                    <HeaderStyle HorizontalAlign ="Center" CssClass="blackfnt" Wrap="true" />
                    <ItemStyle HorizontalAlign ="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lblsrnocomplainlist" CssClass="blackfnt" Text="<%# Container.DataItemIndex+1 %>"
                            runat="server"></asp:Label>
                    </ItemTemplate>
                    <ItemStyle CssClass="blackfnt" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Location" ItemStyle-BackColor="white">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign ="Center"/>
                    <ItemStyle HorizontalAlign ="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lbllocation" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"location") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="loccode" Visible="False" ItemStyle-BackColor="white">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign ="Center"/>
                    <ItemStyle HorizontalAlign ="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lblloccode" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"loccode") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="report_loc" Visible="False" HeaderText="report_loc" SortExpression="report_loc"
                    ItemStyle-BackColor="white" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                    <HeaderStyle CssClass="blackfnt" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Total Dockets Booked" SortExpression="tot1" ItemStyle-BackColor="white">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign ="Center"/>
                    <ItemTemplate>
                        <asp:LinkButton ID="LnkDocketsBooked" OnClick="abc" CommandArgument='<%# Eval("loccode") %>'
                            CssClass="blackfnt" CommandName="LnkDocketsBooked" Font-Underline="true" Text='<%# DataBinder.Eval( Container.DataItem,"tot1") %>'
                            runat="server"></asp:LinkButton><br />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign ="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Total Dockets W/O Loading Sheet" SortExpression="tot2"
                    ItemStyle-BackColor="white">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign ="Center"/>
                    <ItemStyle HorizontalAlign ="Center" />
                    <ItemTemplate>
                        <asp:LinkButton ID="LnkDWOSheet" OnClick="abc" CommandArgument='<%# Eval("loccode") %>'
                            CssClass="blackfnt" CommandName="LnkDWOSheet" Font-Underline="true" Text='<%# DataBinder.Eval( Container.DataItem,"tot2") %>'
                            runat="server"></asp:LinkButton><br />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Total Dockets With Loading Sheet" SortExpression="tot3"
                    ItemStyle-BackColor="white">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign ="Center"/>
                    <ItemStyle HorizontalAlign ="Center" />
                    <ItemTemplate>
                        <asp:LinkButton ID="LnkDWSheet" OnClick="abc" CommandArgument='<%# Eval("loccode") %>'
                            CssClass="blackfnt" CommandName="LnkDWSheet" Font-Underline="true" Text='<%# DataBinder.Eval( Container.DataItem,"tot3") %>'
                            runat="server"></asp:LinkButton><br />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Dockets Loaded in THC" SortExpression="tot4" ItemStyle-BackColor="white">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign ="Center"/>
                    <ItemStyle HorizontalAlign ="Center" />
                    <ItemTemplate>
                        <asp:LinkButton ID="LnkDTHC" OnClick="abc" CommandArgument='<%# Eval("loccode") %>'
                            CssClass="blackfnt" CommandName="LnkDTHC" Font-Underline="true" Text='<%# DataBinder.Eval( Container.DataItem,"tot4") %>'
                            runat="server"></asp:LinkButton><br />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Dockets (Same Delivery Location)" SortExpression="tot5"
                    ItemStyle-BackColor="white">
                    <ItemStyle HorizontalAlign ="Center" />
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign ="Center"/>
                    <ItemTemplate>
                        <asp:LinkButton ID="LnkDSameLoc" OnClick="abc" CommandArgument='<%# Eval("loccode") %>'
                            CssClass="blackfnt" CommandName="LnkDSameLoc" Font-Underline="true" Text='<%# DataBinder.Eval( Container.DataItem,"tot5") %>'
                            runat="server"></asp:LinkButton><br />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" BackColor="white" />
            <HeaderStyle CssClass="bgbluegrey" />
            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle CssClass="boxbg" />
        </asp:GridView>
    </div>
    <div align="center" style="width: 10in">
        <br />
        <asp:Button ID="cmdexcel" runat="server" OnClick="cmdexcel_Click" Text="Excel" Width="61px" />
    </div>
    &nbsp;
</asp:Content>
