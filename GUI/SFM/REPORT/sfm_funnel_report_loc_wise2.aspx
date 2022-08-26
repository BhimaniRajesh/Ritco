<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="sfm_funnel_report_loc_wise2.aspx.cs" Inherits="REPORT_sfm_funnel_report_loc_wise2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td align="left" colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Funnel-Location Wise Report" CssClass="blackfnt"
                    Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br />
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img border="0" src="../images/back.gif" /></a>
            </td>
        </tr>
    </table>
    <br />
    <div align="left">
        <table border="0" cellpadding="3" colspan="2" width="55%" bgcolor="#ffffff" cellspacing="1"
            class="boxbg">
            <tr bgcolor="#ffffff">
                <td align="left" width="30%" style="height: 25px">
                    <font class="blackfnt"><b>Region</b></font></td>
                <td align="left" style="height: 25px">
                    <font class="blackfnt">
                        <asp:Label ID="lblRegion" runat="server" Width="100%">
                        </asp:Label>
                    </font>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="left" width="45%">
                    <font class="blackfnt"><b>Location</b></font>
                </td>
                <td align="left">
                    <font class="blackfnt">
                        <asp:Label ID="lblLocation" runat="server" Width="100%">
                        </asp:Label>
                    </font>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="left" width="42%">
                    <font class="blackfnt"><b>Date Selection</b></font>
                </td>
                <td align="left">
                    <font class="blackfnt">
                        <asp:Label ID="lbldate" runat="server" Width="100%">
                        </asp:Label>
                    </font>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <asp:DataGrid ID="dgCallSummary" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
        HeaderStyle-Font-Bold="true" AllowPaging="true" CssClass="boxbg" AutoGenerateColumns="false"
        OnPageIndexChanged="pgChange" PagerStyle-BackColor="White" Width="9.0in">
        <ItemStyle Height="24px" VerticalAlign="Top" BorderWidth="0" />
        <AlternatingItemStyle Height="24px" />
        <PagerStyle Mode="NumericPages" />
        <HeaderStyle />
        <Columns>
            <asp:TemplateColumn ItemStyle-Wrap="True" HeaderStyle-CssClass="blackfnt">
                <HeaderTemplate>
                    <b>Location</b> </td>
                    <td width="400" colspan="2" align="center" class="blackfnt">
                        <b>HOT</b></td>
                    <td width="400" colspan="2" align="center" class="blackfnt">    
                        <b>WARM</b></td>
                    <td width="400" colspan="2" align="center" class="blackfnt">
                        <b>COLD</b></td>
                    <td width="400" colspan="2" align="center" class="blackfnt">
                        <b>ALL</b></td>
                    </tr><td align="Center" height="25px" style="background-color: White">
                    </td>
                </HeaderTemplate>
                <ItemStyle BackColor="white" />
                <ItemTemplate>
                    <asp:Label ID="location" Text='<%# DataBinder.Eval(Container.DataItem,"loccode") %>'
                        runat="server" CssClass="blackfnt"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="PROSPECT" HeaderStyle-CssClass="blackfnt" HeaderStyle-BackColor="White"
                ItemStyle-BackColor="white">
                <ItemTemplate>
                    <label class="blackfnt">
                        <asp:HyperLink runat="server" Font-Underline="True" CssClass="blackfnt" NavigateUrl='<%#"sfm_funnel_report_loc_wise3.aspx?pro=" +DataBinder.Eval(Container.DataItem, "HotKount")+"&calltype="+"HOT"+"&value="+DataBinder.Eval(Container.DataItem, "HotWalue")+"&location=" +DataBinder.Eval(Container.DataItem, "loccode") + "&fromdt=" +strActualFromDate + "&todt=" + strActualToDate %>'
                            Text='<%#DataBinder.Eval(Container.DataItem, "HotKount")%>' ID="Hyperlink1">
                        </asp:HyperLink>
                    </label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="VALUE" HeaderStyle-CssClass="blackfnt" ItemStyle-BackColor="white"
                HeaderStyle-BackColor="White">
                <ItemTemplate>
                    <asp:Label ID="lblWebSiteName" CssClass="blackfnt" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"HotWalue") %>'>
                    </asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="PROSPECT" HeaderStyle-CssClass="blackfnt" ItemStyle-BackColor="white"
                HeaderStyle-BackColor="White">
                <ItemTemplate>
                    <label class="blackfnt">
                        <asp:HyperLink runat="server" Font-Underline="True" CssClass="blackfnt" NavigateUrl='<%#"sfm_funnel_report_loc_wise3.aspx?pro=" +DataBinder.Eval(Container.DataItem, "WarmKount")+"&calltype="+"WARM"+"&value="+DataBinder.Eval(Container.DataItem, "WarmWalue")+"&location=" +DataBinder.Eval(Container.DataItem, "loccode") + "&fromdt=" +strActualFromDate + "&todt=" +strActualToDate %>'
                            Text='<%#DataBinder.Eval(Container.DataItem, "WarmKount")%>' ID="Hyperlink2">
                        </asp:HyperLink>
                    </label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="VALUE" HeaderStyle-CssClass="blackfnt" ItemStyle-BackColor="white"
                HeaderStyle-BackColor="White">
                <ItemTemplate>
                    <asp:Label ID="lblBillno" CssClass="blackfnt" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"WarmWalue") %>'>
                    </asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="PROSPECT" HeaderStyle-CssClass="blackfnt" ItemStyle-BackColor="white"
                HeaderStyle-BackColor="White">
                <ItemTemplate>
                    <label class="blackfnt">
                        <asp:HyperLink runat="server" Font-Underline="True" CssClass="blackfnt" NavigateUrl='<%#"sfm_funnel_report_loc_wise3.aspx?pro=" +DataBinder.Eval(Container.DataItem, "ColdKount")+"&calltype="+"COLD"+"&value="+DataBinder.Eval(Container.DataItem, "ColdWalue")+"&location=" +DataBinder.Eval(Container.DataItem, "loccode") + "&fromdt=" +strActualFromDate + "&todt=" +strActualToDate %>'
                            Text='<%#DataBinder.Eval(Container.DataItem, "ColdKount")%>' ID="Hyperlink2">
                        </asp:HyperLink>
                    </label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="VALUE" HeaderStyle-CssClass="blackfnt" ItemStyle-BackColor="white"
                HeaderStyle-BackColor="White">
                <ItemTemplate>
                    <asp:Label ID="lblamount" CssClass="blackfnt" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"ColdWalue") %>'>
                    </asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="PROSPECT" HeaderStyle-CssClass="blackfnt" ItemStyle-BackColor="white"
                HeaderStyle-BackColor="White">
                <ItemTemplate>
                    <label class="blackfnt">
                        <asp:HyperLink runat="server" Font-Underline="True" CssClass="blackfnt" NavigateUrl='<%#"sfm_funnel_report_loc_wise3.aspx?pro=" +DataBinder.Eval(Container.DataItem, "AllKount")+"&calltype="+""+"&value="+DataBinder.Eval(Container.DataItem, "AllWalue")+"&location=" +DataBinder.Eval(Container.DataItem, "loccode") + "&fromdt=" +strActualFromDate + "&todt=" +strActualToDate %>'
                            Text='<%#DataBinder.Eval(Container.DataItem, "AllKount")%>' ID="Hyperlink2">
                            
                        </asp:HyperLink>
                    </label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="VALUE" HeaderStyle-CssClass="blackfnt" ItemStyle-BackColor="white"
                HeaderStyle-BackColor="White">
                <ItemTemplate>
                    <asp:Label ID="lblPayout" CssClass="blackfnt" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"AllWalue") %>'>
                    </asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
        </Columns>
    </asp:DataGrid>
</asp:Content>
