<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="FrmDocketsNotDelivered.aspx.cs" Inherits="FrmPaidFollowUp" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/jscript">
//    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
    </script>

    <br />
    <div align="left">
        <table style="width: 1000px">
            <tr>
                <td align="left">
                    <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                        <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Operation.aspx"><font class="blklnkund">
                            <b>Operations</b></font></a> <b>&gt; </b><font class="bluefnt"><b><%=Convert.ToString(Session["DocketCalledAs"]) + " Not Yet Delivered Report"%></b></font>
                </td>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img src="../../images/back.gif" border="0" alt="" /></a>
                </td>
            </tr>
        </table>
        <br />
        &nbsp;<table border="0"  CellSpacing="1" CellPadding="5" class="boxbg" style="width: 398px;
            height: 1px">
            <tr class="bgbluegrey">
                <td align="center" colspan="3" style="height: 23px" class="blackfnt">
                    Your Query
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
            <tr bgcolor="white">
                <td align="left" style="width: 60px;" class="blackfnt">
                    RO</td>
                <td style="width: 136px;">
                    <div align="left">
                        <asp:Label ID="lblStatus" runat="server" CssClass="blackfnt" Text="Label" Width="267px"></asp:Label></div>
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
        </table>
    </div>
    <asp:TextBox ID="txtfdate" runat="server" Visible="false"></asp:TextBox>
    <asp:TextBox ID="txttdate" runat="server" Visible="false"></asp:TextBox>
    &nbsp;<br />
    <br />
    <div align="left">
        <asp:GridView ID="GrdPaidFollow" AllowPaging="true" OnPageIndexChanging="PageIndexChanged_Click"
            PagerStyle-Mode="NumericPages" CssClass="boxbg" PageSize="10" AutoGenerateColumns="false"
            HeaderStyle-CssClass="bgbluegrey" runat="server" SelectedIndex="1"
            OnRowDataBound="GrdPaidFollow_RowDataBound" EmptyDataRowStyle-CssClass="blackfnt"
            EmptyDataText="No Records Found !!!!" EmptyDataRowStyle-BackColor="white"  BorderWidth="0" CellSpacing="1" CellPadding="5">
            <Columns>
                <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lblsrnocomplainlist" CssClass="blackfnt" Text="<%# Container.DataItemIndex+1 %>"
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Location"  ItemStyle-BackColor="white">
                    <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lbllocation" CssClass="blackfnt" Text="label1" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="LocCode" Visible="false"  ItemStyle-BackColor="white">
                    <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lblloccode" Font-Underline="true" ForeColor="blue" CssClass="blackfnt"
                            Text='<%# DataBinder.Eval( Container.DataItem,"loccode") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="LocName" Visible="false"  ItemStyle-BackColor="white">
                    <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center"  />
                    <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lbllocname" Font-Underline="true" ForeColor="blue" CssClass="blackfnt"
                            Text='<%# DataBinder.Eval( Container.DataItem,"locName") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <%--<asp:BoundField DataField="op_dly" HeaderText="Function" />  --%>
                <asp:TemplateField HeaderText="Function" Visible="true"  ItemStyle-BackColor="white">
                    <ItemStyle HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lblfunction" CssClass="blackfnt" Text='<%#DataBinder.Eval( Container.DataItem,"op_dly") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Total GCNs for Delivery" SortExpression="tot1"  ItemStyle-BackColor="white">
                    <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lbltotalgcn" Font-Underline="true" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"tot1") %>'
                            PostBackUrl='<%#"~/GUI/UNI_MIS/DocketsNotYetDelivered/FrmSalesDocketDetail.aspx?fromdate=" + txtfdate.Text + "&todate=" + txttdate.Text + "&loccode=" + DataBinder.Eval(Container.DataItem, "loccode") + "&location=" + DataBinder.Eval(Container.DataItem, "locname") + "&mode=Total GCNs for Delivery&val=delivery"%>'
                            runat="server"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="GCNs awaiting DRS" SortExpression="tot2"  ItemStyle-BackColor="white">
                <ItemStyle HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lblgcnawaitingdrs" Font-Underline="true" CssClass="blackfnt"
                            Text='<%# DataBinder.Eval( Container.DataItem,"tot2") %>' PostBackUrl='<%#"~/GUI/UNI_MIS/DocketsNotYetDelivered/FrmSalesDocketDetail.aspx?fromdate=" + txtfdate.Text + "&todate=" + txttdate.Text + "&loccode=" + DataBinder.Eval(Container.DataItem, "loccode") + "&location=" + DataBinder.Eval(Container.DataItem, "locname") + "&mode=GCN awaiting DRS&val=drs"%>'
                            runat="server"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="GCNs gone for Delivery" SortExpression="tot3"  ItemStyle-BackColor="white">
                <ItemStyle HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lblgcngonedelivery" CssClass="blackfnt" Font-Underline="true"
                            Text='<%# DataBinder.Eval( Container.DataItem,"tot3") %>' PostBackUrl='<%#"~/GUI/UNI_MIS/DocketsNotYetDelivered/FrmSalesDocketDetail.aspx?fromdate=" + txtfdate.Text + "&todate=" + txttdate.Text + "&loccode=" + DataBinder.Eval(Container.DataItem, "loccode") + "&location=" + DataBinder.Eval(Container.DataItem, "locname") + "&mode=GCNs gone for delivery&val=gonedelivery"%>'
                            runat="server"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="GCNs Delivered" SortExpression="tot4"  ItemStyle-BackColor="white">
                    <ItemStyle HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lblgcndelivered" CssClass="blackfnt" Font-Underline="true" Text='<%# DataBinder.Eval( Container.DataItem,"tot4") %>'
                            PostBackUrl='<%#"~/GUI/UNI_MIS/DocketsNotYetDelivered/FrmSalesDocketDetail.aspx?fromdate=" + txtfdate.Text + "&todate=" + txttdate.Text + "&loccode=" + DataBinder.Eval(Container.DataItem, "loccode") + "&location=" + DataBinder.Eval(Container.DataItem, "locname") + "&mode=GCNs Delivered&val=gcndelivered"%>'
                            runat="server"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="GCNs awaiting DRS Update" SortExpression="subtract"  ItemStyle-BackColor="white">
                    <ItemStyle HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center" />
                    <ItemTemplate>
                        <%--<asp:LinkButton ID="lblgcndrsupdate" CssClass="blackfnt"  Font-Underline=true   text ='a' PostBackUrl='<%#"~/GUI/UNI_MIS/DocketsNotYetDelivered/FrmSalesDocketDetail.aspx?fromdate=" + txtfdate.Text + "&todate=" + txttdate.Text + "&loccode=" + DataBinder.Eval(Container.DataItem, "loccode") + "&location=" + DataBinder.Eval(Container.DataItem, "locname") + "&mode=GCNs awaiting DRS update&val=drsupdate"%>' runat="server"></asp:LinkButton>--%>
                        <%--<asp:LinkButton ID="lblgcndrsupdate" CssClass="blackfnt"  Font-Underline=true   text ='<%# Convert.ToInt32(DataBinder.Eval( Container.DataItem,"tot3")) - Convert.ToInt32(DataBinder.Eval( Container.DataItem,"tot4")) %>' PostBackUrl='<%#"~/GUI/UNI_MIS/DocketsNotYetDelivered/FrmSalesDocketDetail.aspx?fromdate=" + txtfdate.Text + "&todate=" + txttdate.Text + "&loccode=" + DataBinder.Eval(Container.DataItem, "loccode") + "&location=" + DataBinder.Eval(Container.DataItem, "locname") + "&mode=GCNs awaiting DRS update&val=drsupdate"%>' runat="server"></asp:LinkButton>--%>
                        <asp:LinkButton ID="lblgcndrsupdate" CssClass="blackfnt" Font-Underline="true" Text='<%# Convert.ToInt32(DataBinder.Eval( Container.DataItem,"subtract"))%>'
                            PostBackUrl='<%#"~/GUI/UNI_MIS/DocketsNotYetDelivered/FrmSalesDocketDetail.aspx?fromdate=" + txtfdate.Text + "&todate=" + txttdate.Text + "&loccode=" + DataBinder.Eval(Container.DataItem, "loccode") + "&location=" + DataBinder.Eval(Container.DataItem, "locname") + "&mode=GCNs awaiting DRS update&val=drsupdate"%>'
                            runat="server"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" DataField="report_loc" Visible="False"
                    HeaderText="report_loc" SortExpression="report_loc"  ItemStyle-BackColor="white"/>
            </Columns>
            <RowStyle />
            <PagerStyle  BackColor="white"  HorizontalAlign="Center" CssClass="bgbluegrey" />
            <HeaderStyle CssClass="bgbluegrey" />
            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle  BackColor="white"  CssClass="boxbg" />
        </asp:GridView>
    </div>
    <div align="center" style="width: 10in">
        <br />
        <asp:Button ID="Button1" runat="server" OnClick="cmdexcel_Click" Text="Excel" Width="54px" /><br />
        &nbsp;</div>
</asp:Content>
