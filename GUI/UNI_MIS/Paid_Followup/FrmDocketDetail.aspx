<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="FrmDocketDetail.aspx.cs" Inherits="FrmDocketDetail" EnableEventValidation="false" %>

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
    <br />
    <table border="0" CellPadding="5" cellspacing="1" class="boxbg" style="width: 294px;
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
                &nbsp;<asp:Label ID="LblRptName" CssClass="blackfnt" runat="server" Text="Location :"
                    Width="474px"></asp:Label></td>
        </tr>
    </table>
    <br />
    <br />
    <asp:DataGrid ID="GrdPaidFollow" CellSpacing="1" BorderWidth="0" CellPadding="5" OnItemCommand="gotolink"
        runat="server" PagerStyle-Mode="NumericPages"
        AllowPaging="True" Style="width: 10in" HeaderStyle-CssClass="bgbluegrey" 
        FooterStyle-CssClass="boxbg" AllowSorting="True" CssClass="boxbg" OnPageIndexChanged="PageIndexChanged_Click"
        OnSortCommand="SortCommand_Click" AutoGenerateColumns="False">
        <FooterStyle CssClass="boxbg" BackColor="white"/>
        <PagerStyle CssClass="pageLinks"  BackColor="white" Position="bottom" HorizontalAlign="Center" Mode="NumericPages" />
        <HeaderStyle CssClass="bgbluegrey" Wrap="true"/>
        <Columns>
            <asp:TemplateColumn HeaderText="Sr.No" ItemStyle-BackColor="white">
                <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center" />
                <ItemStyle  HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="lblId" Text="<%# Container.DataSetIndex+1 %>" CssClass="blackfnt" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="Docket"  ItemStyle-BackColor="white">
                <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="lbllocation" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.dockno") %>'
                        runat="server"></asp:Label>&nbsp;<asp:LinkButton ID="lblTrack" Font-Underline="true"
                            Text='Track' runat="server"></asp:LinkButton>&nbsp;<asp:LinkButton ID="LinkButton1"
                                Text='View' Font-Underline="true" runat="server"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="Cnote Amt"  ItemStyle-BackColor="white">
                <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center" />
                <ItemStyle  HorizontalAlign="Right" />
                <ItemTemplate>
                    <asp:Label ID="lblPaidDocket" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.dkttot") %>'
                        runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="Origin" ItemStyle-BackColor="white">
                <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center" />
                <ItemStyle  HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="lblMRGenerated" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.Orgncd") %>'
                        runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="Consignee"  ItemStyle-BackColor="white">
                <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center" />
                <ItemStyle  HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="lblMRGeneratedAmt" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.csgecd") %>'
                        runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="Consignee"  ItemStyle-BackColor="white">
            <ItemStyle  HorizontalAlign="Center" />
                <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="lbl1" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.csgenm") %>'
                        runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="Consignor"  ItemStyle-BackColor="white">
                <ItemStyle  HorizontalAlign="Center" />
                <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="lbl2" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.csgncd") %>'
                        runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="Consignor" ItemStyle-BackColor="white">
                <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center" />
                <ItemStyle  HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="lbl3" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.csgnnm") %>'
                        runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:BoundColumn DataField="arrv_dt" HeaderText="Arrival Date" DataFormatString="{0:dd-MMM-yy}"
                HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Center" ItemStyle-BackColor="white"></asp:BoundColumn>
            <%--<asp:TemplateColumn HeaderText="MR Gen Date">
             <HeaderStyle CssClass="blackfnt" />
                 <ItemTemplate>
                     <asp:Label ID="lbl5" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.mrsdt") %>' runat="server"></asp:Label>
                 </ItemTemplate>  
              </asp:TemplateColumn>--%>
            <asp:BoundColumn DataField="mrsdt" HeaderText="MR Gen Date" DataFormatString="{0:dd-MMM-yy}"
                HeaderStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="blackfnt" ItemStyle-BackColor="white"></asp:BoundColumn>
            <asp:TemplateColumn HeaderText="View MR" ItemStyle-BackColor="white">
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center"/>
                <ItemStyle  HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:LinkButton ID="lblViewMR" Font-Underline="true" CssClass="blackfnt" CommandName="MR_Close_money"
                        Text='<%# DataBinder.Eval(Container, "DataItem.mrsno") %>' runat="server"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="Amount" ItemStyle-BackColor="white">
                <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center" />
                <ItemStyle  HorizontalAlign="Right" />
                <ItemTemplate>
                    <asp:Label ID="lbl7" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.mrsamt") %>'
                        runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <%--<asp:TemplateColumn HeaderText="Collection Date">
             <HeaderStyle CssClass="blackfnt" />
                 <ItemTemplate>
                     <asp:Label ID="lbl8" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.closedt") %>' runat="server"></asp:Label>
                 </ItemTemplate>  
              </asp:TemplateColumn>--%>
            <asp:BoundColumn DataField="closedt" HeaderText="Collection Date" DataFormatString="{0:dd-MMM-yy}"
                HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" ItemStyle-BackColor="white"></asp:BoundColumn>
            <asp:TemplateColumn HeaderText="Amount" ItemStyle-BackColor="white">
                <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center" />
                <ItemStyle  HorizontalAlign="Center" />
                <ItemStyle  HorizontalAlign="Right" />
                <ItemTemplate>
                    <asp:Label ID="lbl9" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.netamt") %>'
                        runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="Addition" ItemStyle-BackColor="white">
                <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center" />
                <ItemStyle  HorizontalAlign="Right" />
                <ItemTemplate>
                    <asp:Label ID="lbl10" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.miscchrg") %>'
                        runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="TDS Amount" ItemStyle-BackColor="white">
                <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center" />
                <ItemStyle  HorizontalAlign="Right" />
                <ItemTemplate>
                    <asp:Label ID="lbl11" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.ded_tds") %>'
                        runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="Other Deduction" ItemStyle-BackColor="white">
                <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center" />
                <ItemStyle  HorizontalAlign="right" />
                <ItemTemplate>
                    <asp:Label ID="lbl12" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.ded_oth") %>'
                        runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="Remarks" ItemStyle-BackColor="white">
                <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center" />
                <ItemStyle  HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="lbl13" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'
                        runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
        </Columns>
    </asp:DataGrid>
    <br />
    <br />
    <div style="width: 10in" align="center">
        <asp:Button Visible="false" ID="cmdprint" runat="server" BackColor="#C0C0FF" OnClick="cmdprint_Click"
            Text="Print" Width="45px" />
        <asp:Button ID="Button1" runat="server" OnClick="cmdexcel_Click" Text="Excel" Width="45px" />
    </div>
</asp:Content>
