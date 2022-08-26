<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="FrmPaidFollowUp.aspx.cs" Inherits="FrmPaidFollowUp" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <br />
    <table style="width: 10in">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_finance.aspx"><font class="blklnkund">
                        <b>Finance & Accounts</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Collection
                            Followup Paid Report</b></font>
            </td>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img src="../../images/back.gif" border="0" alt="" /></a>
            </td>
        </tr>
    </table>
    <%--<table style="width: 345px;height: 173px; z-index: 104; left: 207px; position: absolute; top: 157px;" title="Your Query Here" cellspacing="1" border="1">
      <tr> <td colspan="3" class="bgbluegrey" style="height: 23px">  <p align="center" style="background-color:#d4e0e7"><label class="blackfnt">Your Query Here</label></p>
     </td></tr>
            <tr>
                <td style="width: 355px; text-align: left; height: 25px;" colspan="2">
                    Date Ranges :&nbsp;
                    <asp:Label ID="lbldaterange" runat="server" Style="z-index: 100; left: 114px; position: absolute;
                        top: 45px" Text="Label" Width="238px"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="width: 355px; text-align: left; height: 26px;" colspan="2">
                    RO :
                    <asp:TextBox ID="TxtRO" runat="server" Width="168px" ReadOnly="True" style="z-index: 102; left: 174px; position: absolute; top: 174px" Visible="False"></asp:TextBox>
                    <asp:Label ID="lblRO" runat="server" Style="z-index: 101; left: 115px; position: absolute;
                        top: 80px" Text="Label" Width="176px"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="width: 355px; height: 22px;" colspan="2">
                    Location :
                    <asp:TextBox ID="txtLocation" runat="server" Width="168px" ReadOnly="True" style="z-index: 102; left: 175px; position: absolute; top: 177px" Visible="False"></asp:TextBox>
                    <asp:Label ID="lblLocation" runat="server" Style="z-index: 101; left: 115px; position: absolute;
                        top: 116px" Text="Label" Width="187px"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="width: 355px; height: 20px;" colspan="2">
                    Customer Code :
                    <asp:TextBox ID="TxtCCode" runat="server" Width="168px" ReadOnly="True" style="z-index: 102; left: 171px; position: absolute; top: 177px" Visible="False"></asp:TextBox>
                    <asp:Label ID="lblCCode" runat="server" Style="z-index: 101; left: 116px; position: absolute;
                        top: 148px" Text="Label" Width="189px"></asp:Label>
                </td>
            </tr>
        </table>--%>
    <br />
    <div align="left" style="width: 10in">
        <table style="width: 362px; height: 19px" border="0" class="boxbg" cellspacing="1"  CellPadding="5" >
            <tr class="bgbluegrey">
                <td class="blackfnt" colspan="3" align="center" style="height: 19px">
                    Your Query Here
                </td>
            </tr>
            <tr bgcolor="white">
                <td class="blackfnt" align="left">
                    Date Range
                </td>
                <td class="blackfnt" align="left">
                    <div align="left">
                        <asp:Label ID="lblDateRange" CssClass="blackfnt" runat="server" Text="Label" Width="233px"></asp:Label></div>
                </td>
            </tr>
            <tr bgcolor="white">
                <td class="blackfnt" align="left">
                    RO
                </td>
                <td class="blackfnt" align="left">
                    <div align="left">
                        <asp:Label ID="lblRO" CssClass="blackfnt" runat="server" Text="Label" Width="233px"></asp:Label></div>
                </td>
            </tr>
            <tr bgcolor="white">
                <td class="blackfnt" align="left">
                    Location</td>
                <td class="blackfnt" align="left">
                    <div align="left">
                        <asp:Label ID="lblLocation" CssClass="blackfnt" runat="server" Text="Label" Width="233px"></asp:Label></div>
                </td>
            </tr>
            <tr bgcolor="white">
                <td class="blackfnt" align="left">
                    Customer Code</td>
                <td class="blackfnt" align="left">
                    <div align="left">
                        <asp:Label ID="lblCCode" CssClass="blackfnt" runat="server" Text="Label" Width="233px"></asp:Label></div>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <asp:TextBox ID="TxtDateRange" runat="server" Width="237px" ReadOnly="True" Visible="False"></asp:TextBox>
    <asp:TextBox ID="txtLocation" runat="server" Width="168px" ReadOnly="True" Style="z-index: 102;
        left: 175px; position: absolute; top: 177px" Visible="False"></asp:TextBox>
    <asp:TextBox ID="TxtCCode" runat="server" Width="168px" ReadOnly="True" Style="z-index: 102;
        left: 171px; position: absolute; top: 177px" Visible="False"></asp:TextBox>
    <asp:TextBox ID="TxtRO" runat="server" Width="168px" ReadOnly="True" Style="z-index: 102;
        left: 174px; position: absolute; top: 174px" Visible="False"></asp:TextBox>
    <asp:TextBox ID="TxtFDt" runat="server" Visible="False"></asp:TextBox>
    <asp:TextBox ID="TxtTDt" runat="server" Visible="False"></asp:TextBox><br />
    <div align="left" style="width: 10in">
        <asp:DataGrid CellSpacing="1" CellPadding="5" BorderWidth="0" ShowFooter="true" ID="GrdPaidFollow"
            OnItemCommand="gotolink" OnItemDataBound="eventhandler" runat="server" PagerStyle-Mode="NumericPages"
            PagerStyle-Position="Top" Style="width: 10in" PagerStyle-HorizontalAlign="left"
            PagerStyle-CssClass="pageLinks" AllowPaging="True" HeaderStyle-CssClass="bgbluegrey"
            FooterStyle-CssClass="boxbg" AllowSorting="True" CssClass="boxbg"
            OnPageIndexChanged="PageIndexChanged_Click" OnSortCommand="SortCommand_Click"
            AutoGenerateColumns="False">
            <FooterStyle CssClass="boxbg"  HorizontalAlign="Center"  BackColor="white"/>
            <PagerStyle CssClass="pageLinks" BackColor="white" Position="bottom" HorizontalAlign="Center" />
            <HeaderStyle CssClass="bgbluegrey" Wrap="true" />
            <Columns>
                <asp:TemplateColumn HeaderText="Sr.No"  ItemStyle-BackColor="white">
                    <ItemStyle HorizontalAlign="Center"/>
                    <FooterStyle CssClass="blackfnt" Font-Bold="true" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lblId" CssClass="blackfnt" Text="<%# Container.DataSetIndex+1 %>" runat="server"></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        Total</FooterTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Loccode" Visible="False"  ItemStyle-BackColor="white">
                    <ItemStyle HorizontalAlign="Center"/>
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center"  />
                    <ItemTemplate>
                        <asp:Label ID="lblloccode" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.loccode") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Location"  ItemStyle-BackColor="white">
                    <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center"/>
                    <ItemTemplate>
                        <asp:Label ID="lbllocation" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.locName") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Paid Dockets Booked"  ItemStyle-BackColor="white">
                    <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center"/>
                    <ItemTemplate>
                        <asp:LinkButton ID="lb1" CssClass="blackfnt" Font-Underline="true" CommandName="Paid_docket"
                            Text='<%# DataBinder.Eval(Container, "DataItem.Paid_docket") %>' runat="server"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="MR Generated"  ItemStyle-BackColor="white">
                    <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center"/>
                    <ItemTemplate>
                        <asp:LinkButton ID="lb2" CssClass="blackfnt" Font-Underline="true" CommandName="MR_gen"
                            Text='<%# DataBinder.Eval(Container, "DataItem.MR_gen") %>' runat="server"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Amount"  ItemStyle-BackColor="white">
                    <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Right"/>
                    <FooterStyle HorizontalAlign="Right"/>
                    <ItemTemplate>
                        <asp:Label ID="l1" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.MR_gen_amt") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="MR Closed"  ItemStyle-BackColor="white">
                    <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center"/>
                    <ItemTemplate>
                        <asp:LinkButton ID="lb3" CssClass="blackfnt" Font-Underline="true" CommandName="MR_Close_money"
                            Text='<%# DataBinder.Eval(Container, "DataItem.MR_Close_money") %>' runat="server"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Amount"  ItemStyle-BackColor="white">
                    <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Right"/>
                    <FooterStyle HorizontalAlign="Right"/>
                    <ItemTemplate>
                        <asp:Label ID="l2" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.MR_close_money_amt") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="MR Outstanding"  ItemStyle-BackColor="white">
                    <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center"/>
                    <ItemTemplate>
                        <asp:LinkButton ID="lb4" CssClass="blackfnt" Font-Underline="true" CommandName="MR_not_close"
                            Text='<%# DataBinder.Eval(Container, "DataItem.MR_not_close") %>' runat="server"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Amount"  ItemStyle-BackColor="white">
                    <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Right"/>
                    <FooterStyle HorizontalAlign="Right"/>
                    <ItemTemplate>
                        <asp:Label ID="l3" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.MR_not_close_amt") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
            </Columns>
        </asp:DataGrid>
        &nbsp;
        <br />
        <br />
    </div>
    <div align="center" style="width: 10in">
        <asp:Button ID="cmdexcel" runat="server" OnClick="cmdexcel_Click" Text="Excel" Width="60px" />
    </div>
    &nbsp;<br />
    <br />
    &nbsp;</asp:Content>
