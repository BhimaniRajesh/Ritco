<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="FrmExpArrival.aspx.cs" Inherits="FrmPaidFollowUp" EnableEventValidation="false"%>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/jscript">
//    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
    </script>

    <br />
    <div style="width: 1000px">
        <table style="width: 1000px">
            <tr>
                <td align="left">
                    <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                        <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Operation.aspx"><font class="blklnkund">
                            <b>Operations</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Expected Arrival Report</b></font>
                </td>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img src="../../images/back.gif" border="0" alt="" /></a>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <div align="left">
        &nbsp;<table border="0" cellpadding="5" cellspacing="1" class="boxbg" style="width: 398px;
            height: 1px">
            <tr class="bgbluegrey">
                <td align="center" colspan="3" style="height: 23px" class="blackfnt">
                    Your Query
                </td>
            </tr>
            <tr bgcolor="white">
                <td align="left" style="width: 60px;" class="blackfnt">
                    Location</td>
                <td style="width: 136px;">
                    <div align="left">
                        <asp:Label ID="lbllocation" CssClass="blackfnt" runat="server" Text="Label" Width="267px"></asp:Label></div>
                </td>
            </tr>
            <tr bgcolor="white">
                <td align="left" style="width: 60px;" class="blackfnt">
                    Status</td>
                <td style="width: 136px;">
                    <div align="left">
                        <asp:Label ID="lblStatus" runat="server" CssClass="blackfnt" Text="Label" Width="267px"></asp:Label></div>
                </td>
            </tr>
            <tr bgcolor="white">
                <td align="left" style="width: 60px;" class="blackfnt">
                    Date</td>
                <td style="width: 136px;">
                    <div align="left">
                        <asp:Label ID="lblDate" align="left" runat="server" Text="Label" CssClass="blackfnt"
                            Width="267px"></asp:Label></div>
                </td>
            </tr>
        </table>
    </div>
    &nbsp;<br />
    <br />
    <div align="left">
        <asp:GridView EmptyDataText="No Records Found" EmptyDataRowStyle-BackColor="white" EmptyDataRowStyle-CssClass="blackfnt" 
        ID="GrdPaidFollow" AllowPaging="true" OnPageIndexChanging="PageIndexChanged_Click" PagerStyle-Mode="NumericPages" CssClass="boxbg"
            PageSize="10" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey"
            runat="server" SelectedIndex="1" CellPadding="5" CellSpacing="1" BorderWidth="0" HeaderStyle-HorizontalAlign="Center">
            <Columns>
                <asp:TemplateField HeaderText="SR.NO.">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Center" BackColor="white"/>
                    <ItemTemplate>
                        <asp:Label ID="lblsrnocomplainlist" CssClass="blackfnt" Text="<%# Container.DataItemIndex+1 %>"
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="THC Org Code & Name">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Center"  BackColor="white"/>
                    <ItemTemplate>
                        <asp:Label ID="lbllocation" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"THCName") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="THC No. & Vehicle No." Visible="true">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Center"  BackColor="white"/>
                    <ItemTemplate>
                        <asp:LinkButton ID="lblloccode" Font-Underline="true" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"thcno") %>'
                            runat="server"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="THC Date" Visible="true">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Center"  BackColor="white"/>
                    <ItemTemplate>
                        <asp:Label ID="lblloccode2" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"thcdt") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderStyle-CssClass="blackfnt" DataFormatString="{0:F0}" HeaderText="No. of Dockets"
                    DataField="TOTDKT" ItemStyle-CssClass="blackfnt" ItemStyle-BackColor="white"/>
                <asp:TemplateField HeaderText="Actual Weight(Kg.)">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Center"  BackColor="white"/>
                    <ItemTemplate>
                        <asp:Label ID="lbllocation2" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"actuwt") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Contract Rs.">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Right"  BackColor="white"/>
                    <ItemTemplate>
                        <asp:Label ID="lbllocation3" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"ContractRS") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Route">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Center"  BackColor="white"/>
                    <ItemTemplate>
                        <asp:Label ID="lbllocation4" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"routename") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Free Space (%)">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Center"  BackColor="white"/>
                    <ItemTemplate>
                        <asp:Label ID="lbllocation5" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"FreeSpace") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Last Location">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Center"  BackColor="white"/>
                    <ItemTemplate>
                        <asp:Label ID="lbllocation6" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"lastlocation") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Time & Date of Departure">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Center"  BackColor="white"/>
                    <ItemTemplate>
                        <asp:Label ID="lbllocation66" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"DtDep") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Status">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Center"  BackColor="white"/>
                    <ItemTemplate>
                        <asp:Label ID="lbllocation78" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"stat") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Days From Start">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Center"  BackColor="white"/>
                    <ItemTemplate>
                        <asp:Label ID="lbllocation35" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"DaysFromStart") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle />
            <PagerStyle HorizontalAlign="Center"  BackColor=white CssClass="bgbluegrey" />
            <HeaderStyle CssClass="bgbluegrey" />
            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle CssClass="boxbg" BackColor=white HorizontalAlign="Center" />
        </asp:GridView>
    </div>
    <div align="center">
        <br />
        <asp:Button ID="Button1" runat="server" OnClick="cmdexcel_Click" Text="Excel" Width="54px" /><br />
        &nbsp;</div>
</asp:Content>
