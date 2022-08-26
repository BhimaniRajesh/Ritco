<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="FrmDocketDetail.aspx.cs" Inherits="FrmDocketDetail" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <br />
    <div align="left" style="width: 10in">
        <table style="width: 1008px">
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
    <table border="0" cellpadding="5" cellspacing="1" class="boxbg" style="width: 294px;
        height: 19px">
        <tr class="bgbluegrey">
            <td align="center" class="blackfnt" colspan="3" style="height: 19px">
                Your Query Here
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="center" class="blackfnt" style="height: 19px">
                Location :
            </td>
            <td align="left" class="blackfnt" style="height: 19px">
                <asp:Label ID="LblRptName" runat="server" CssClass="blackfnt" Text="Location :" Width="519px"></asp:Label>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <asp:DataGrid ID="GrdToPayFollow" CellSpacing="1" BorderWidth="0" CellPadding="5"
        OnItemCommand="gotolink" OnItemDataBound="eventhandler" runat="server" PagerStyle-Mode="NumericPages"
        PagerStyle-CssClass="pageLinks" CssClass="boxbg" HeaderStyle-CssClass="bgbluegrey"
        FooterStyle-CssClass="boxbg" AllowPaging="True" AllowSorting="True" PagerSettings-FirstPageText="[First]"
        OnPageIndexChanged="PageIndexChanged_Click" OnSortCommand="SortCommand_Click"
        AutoGenerateColumns="False">
        <PagerStyle Position="Bottom" BackColor="white" HorizontalAlign="Center" />
        <Columns>
            <asp:TemplateColumn HeaderText="Sr.No" ItemStyle-BackColor="white" HeaderStyle-CssClass="blackfnt">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="lblId" Text="<%# Container.DataSetIndex+1 %>" CssClass="blackfnt"
                        runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn ItemStyle-BackColor="white" HeaderText="Docket" HeaderStyle-CssClass="blackfnt">
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="lbllocation" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.docket") %>'
                        runat="server"></asp:Label>
                    <asp:LinkButton ID="lblTrack" Text='Track' Font-Underline="true" runat="server"></asp:LinkButton>
                    &nbsp; &nbsp;<asp:LinkButton ID="LinkButton1" Text='View' Font-Underline="true" runat="server"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn ItemStyle-BackColor="white" HeaderText="Cnote Amt" HeaderStyle-CssClass="blackfnt">
                <ItemStyle HorizontalAlign="Right" />
                <HeaderStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="lblPaidDocket" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.dkttot") %>'
                        runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn ItemStyle-BackColor="white" HeaderText="Origin" HeaderStyle-CssClass="blackfnt">
                <ItemStyle HorizontalAlign="Center" />
                <HeaderStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="lblMRGenerated" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.Orgncd") %>'
                        runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn ItemStyle-BackColor="white" HeaderText="Consignee" HeaderStyle-CssClass="blackfnt">
                <ItemStyle HorizontalAlign="Center" />
                <HeaderStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="lblMRGeneratedAmt" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.csgecd") %>'
                        runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn ItemStyle-BackColor="white" HeaderText="Consignee" HeaderStyle-CssClass="blackfnt">
                <ItemStyle HorizontalAlign="Center" />
                <HeaderStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="lbl1" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.csgenm") %>'
                        runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn ItemStyle-BackColor="white" HeaderText="Consignor" HeaderStyle-CssClass="blackfnt">
                <ItemStyle HorizontalAlign="Center" />
                <HeaderStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="lbl2" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.csgncd") %>'
                        runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn ItemStyle-BackColor="white" HeaderText="Consignor" HeaderStyle-CssClass="blackfnt">
                <ItemStyle HorizontalAlign="Center" />
                <HeaderStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="lbl3" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.csgnnm") %>'
                        runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <%--<asp:TemplateColumn HeaderText="Arrival Date" HeaderStyle-CssClass="blackfnt">
                 <ItemTemplate>
                     <asp:Label ID="lbl4" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.arrv_dt") %>' runat="server"></asp:Label>
                 </ItemTemplate>  
              </asp:TemplateColumn>--%>
            <asp:BoundColumn DataField="arrv_dt" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                ItemStyle-BackColor="white" HeaderText="Arrival Date" HeaderStyle-CssClass="blackfnt"
                ItemStyle-CssClass="blackfnt" DataFormatString="{0:dd-MMM-yy}"></asp:BoundColumn>
            <asp:BoundColumn DataField="dely_dt" ItemStyle-HorizontalAlign="Center" ItemStyle-BackColor="white"
                HeaderText="Delivery Date" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center"
                ItemStyle-CssClass="blackfnt" DataFormatString="{0:dd-MMM-yy}"></asp:BoundColumn>
            <asp:BoundColumn DataField="mrsdt" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                ItemStyle-BackColor="white" HeaderText="MR Gen Date" HeaderStyle-CssClass="blackfnt"
                ItemStyle-CssClass="blackfnt" DataFormatString="{0:dd-MMM-yy}"></asp:BoundColumn>
            <%--<asp:TemplateColumn HeaderText="Delivery Date" HeaderStyle-CssClass="blackfnt">
                 <ItemTemplate>
                     <asp:Label ID="lblDeliveryDt" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.dely_dt") %>' runat="server"></asp:Label>
                 </ItemTemplate>  
              </asp:TemplateColumn>--%>
            <%--<asp:TemplateColumn HeaderText="MR Gen Date" HeaderStyle-CssClass="blackfnt">
                 <ItemTemplate>
                     <asp:Label ID="lbl5" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.mrsdt") %>' runat="server"></asp:Label>
                 </ItemTemplate>  
              </asp:TemplateColumn>--%>
            <asp:TemplateColumn HeaderText="View MR" ItemStyle-BackColor="white" HeaderStyle-CssClass="blackfnt">
                <ItemStyle HorizontalAlign="Center" />
                <HeaderStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:LinkButton ID="lblViewMR" CssClass="blackfnt" Font-Underline="true" CommandName="ViewMR"
                        Text='<%# DataBinder.Eval(Container, "DataItem.mrsno") %>' runat="server"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="Amount" ItemStyle-BackColor="white" HeaderStyle-CssClass="blackfnt">
                <ItemStyle HorizontalAlign="Right" />
                <HeaderStyle HorizontalAlign="right" />
                <ItemTemplate>
                    <asp:Label ID="lbl7" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.mrsamt") %>'
                        runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:BoundColumn DataField="finclosedt" ItemStyle-HorizontalAlign="Center" ItemStyle-BackColor="white"
                HeaderStyle-CssClass="blackfnt" HeaderText="Collection Date" ItemStyle-CssClass="blackfnt"
                DataFormatString="{0:dd-MMM-yy}"></asp:BoundColumn>
            <asp:TemplateColumn HeaderText="Amount" ItemStyle-BackColor="white" HeaderStyle-CssClass="blackfnt">
                <ItemStyle HorizontalAlign="Right" />
                <HeaderStyle HorizontalAlign="Right" />
                <ItemTemplate>
                    <asp:Label ID="lbl9" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.netamt") %>'
                        runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="TDS Amount" ItemStyle-BackColor="white" HeaderStyle-CssClass="blackfnt">
                <ItemStyle HorizontalAlign="Right" />
                <HeaderStyle HorizontalAlign="Right" />
                <ItemTemplate>
                    <asp:Label ID="lbl11" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.ded_tds") %>'
                        runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="Other Deduction" ItemStyle-BackColor="white" HeaderStyle-CssClass="blackfnt">
                <ItemStyle HorizontalAlign="Right" />
                <HeaderStyle HorizontalAlign="Right" />
                <ItemTemplate>
                    <asp:Label ID="lbl12" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.ded_oth") %>'
                        runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="Remarks" ItemStyle-BackColor="white" HeaderStyle-CssClass="blackfnt">
                <ItemStyle HorizontalAlign="center" />
                <HeaderStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="lbl13" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'
                        runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
        </Columns>
    </asp:DataGrid>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
    <br />
    <br />
    <div align="center" style="width: 10in">
        <asp:Button ID="cmdprint" runat="server" Visible="false" BackColor="#C0C0FF" OnClick="cmdprint_Click"
            Text="Print" Width="61px" />
        <asp:Button ID="cmdexcel" runat="server" OnClick="cmdexcel_Click" Text="Excel" Width="61px" /></div>
    <br />
    &nbsp;<br />
    <br />
    <br />
</asp:Content>
