<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="AgentBillList.aspx.cs" Inherits="GUI_Octroi_AgentBillList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
 function popupmenu2(choice)
 { 
  var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
  confirmWin=window.open(choice,"",winOpts);
 }
    </script>

    <p>
        &nbsp;</p>
    <%--Back Link To First Page in Viewing Agent Bills--%>
    <table align="left" style="width: 7.5in">
        <tr>
            <td>
                <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 7.5in">
                    <tr>
                        <td align="right" style="height: 33px">
                            <a href="javascript:window.history.go(-1)" title="back">
                                <img border="0" src="../../images/back.gif" /></a>
                        </td>
                    </tr>
                </table>
                <br />
            </td>
        </tr>
        <tr>
            <td>
                <%--YOU SELECTED LINE--%>
                <table width="100%">
                    <tr>
                        <td align="center">
                            <font class="blackfnt">You Selected</font></td>
                    </tr>
                </table>
                <br />
            </td>
        </tr>
        <tr>
            <td>
                <%--      SELECTION CRITERIA--%>
                <table align="center" bgcolor="#808080" class="boxbg" cellpadding="3" cellspacing="1"
                    style="width: 7.5in">
                    <tr>
                        <td align="right" style="width: 50%" bgcolor="#ffffff">
                            <font class="blackfnt">Billing Branch : </font>
                        </td>
                        <td bgcolor="#ffffff" style="width: 50%">
                            <font class="blackfnt">
                                <asp:Label runat="server" ID="lblbillbranch"></asp:Label></font></td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 50%" bgcolor="#ffffff">
                            <font class="blackfnt">Octroi Agent Code and Name : </font>
                        </td>
                        <td bgcolor="#ffffff" style="width: 50%">
                            <font class="blackfnt">
                                <asp:Label runat="server" ID="lblagentcode"></asp:Label></font></td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 50%" bgcolor="#ffffff">
                            <font class="blackfnt">Bill Generation Date Range :</font>
                        </td>
                        <td bgcolor="#ffffff" style="width: 50%">
                            <font class="blackfnt">
                                <asp:Label runat="server" ID="lbldate"></asp:Label></font></td>
                    </tr>
                </table>
                <p>
                    &nbsp;</p>
            </td>
        </tr>
        <tr>
            <td>
                <%--GRID VIEW OF DATA--%>
                <asp:GridView align="center" ID="gvagentbill" runat="server" BorderWidth="1" CellPadding="2"
                    Width="7.5in" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="true"
                    PageSize="1000" PagerStyle-HorizontalAlign="left" CssClass="boxbg" BackColor="white"
                    FooterStyle-CssClass="boxbg" AutoGenerateColumns="false" EmptyDataText="No Records Found..."
                    OnSelectedIndexChanged="gvagentbill_SelectedIndexChanged" OnRowDataBound="gvagentbill_RowDataBound">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr.No.">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                            <ItemTemplate>
                                <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Bill Entry No." SortExpression="tot1">
                            <HeaderStyle CssClass="blackfnt" />
                            <ItemTemplate>
                                <a href="javascript:popupmenu2('AgentBill_ViewPrint.aspx?billno=<%# DataBinder.Eval( Container.DataItem,"ocbillno") %>&printyn=0')">
                                    <%# DataBinder.Eval(Container.DataItem, "ocbillno")%>
                                </a>
                                <asp:HiddenField ID="hidBillno" runat="server" Value='<%# DataBinder.Eval( Container.DataItem,"ocbillno") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ocagbilldt" HeaderText="Bill Date">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ocbrcd" HeaderText="Bill Location">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="oct_paid" HeaderText="Octroi Amount ">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                        </asp:BoundField>
                        <%--<asp:TemplateField HeaderText="Octroi Amount">
                            <HeaderStyle CssClass="blackfnt" />
                            <ItemTemplate>
                                <asp:Label ID="lblOctroiAmount" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                        <asp:BoundField DataField="ocagserchrg" HeaderText="Octroi Service Charges">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ocagothchrg" HeaderText=" Other Charges">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="formchrg" HeaderText="Form Charges">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="clearchrg" HeaderText="Clearance charges">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="sundrychrg" HeaderText="Sundry charges">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                        </asp:BoundField>
                        <%-- <asp:BoundField DataField="actserchrg" HeaderText="Acct Sercharges">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                        </asp:BoundField>--%>
                        <asp:BoundField DataField="netamt" HeaderText="Net Amount">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Bill Status">
                            <HeaderStyle CssClass="blackfnt" />
                            <ItemTemplate>
                                <asp:Label ID="lblStatus" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"Cancel_YN") %>'
                                    runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Print">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                            <ItemTemplate>
                                <%--<a href="javascript:popupmenu2('AgentBill_ViewPrint.aspx?billno=<%# DataBinder.Eval( Container.DataItem,"ocbillno") %>&printyn=1')" > View</a>--%>
                                <a href="javascript:popupmenu2('AgentBill_ViewPrint.aspx?billno=<%# DataBinder.Eval( Container.DataItem,"ocbillno") %>&printyn=1')">
                                    Print</a>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                    <HeaderStyle CssClass="bgbluegrey" />
                    <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                    <FooterStyle CssClass="boxbg" />
                </asp:GridView>
            </td>
        </tr>
    </table>
</asp:Content>
