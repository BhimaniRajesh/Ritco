<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="DDMRResult.aspx.cs" Inherits="GUI_Finance_GeneralizedPO_POViewPrint_POViewPrintResult" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
        function ViewPrint(mrsno, printyn) 
        {
            window.open("Result.aspx?DDMRCode=" + mrsno + "", "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }        
    </script>

    <br />
    <br />
    <table border="0" cellpadding="3" width="700" bgcolor="#ffffff" cellspacing="1" class="boxbg"
        align="left">
        <tr bgcolor="white" id="gridview" runat="server" visible="true">
            <td>
                <br />
                <asp:GridView ID="GV_DDMRList" runat="server" align="left" BorderWidth="0" CellSpacing="1"
                    CellPadding="2" HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left"
                    CssClass="boxbg" FooterStyle-CssClass="bgbluegrey" AllowPaging="False" PageSize="1"
                    Width="100%" AllowSorting="False" AutoGenerateColumns="false" ShowFooter="false"
                    PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">
                    <PagerStyle VerticalAlign="Bottom" />
                    <Columns>
                        <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                            <ItemStyle CssClass="blackfnt" Width="30px" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server"> </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="DDMR Sheet No." ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                            <ItemStyle CssClass="blackfnt" Width="150px" HorizontalAlign="Left" />
                            <ItemTemplate>
                                <asp:Label ID="LblMRSNO" Text='<%# DataBinder.Eval(Container.DataItem, "DDMRNo") %>'
                                    runat="server"> </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Dockets Given" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                            <ItemStyle CssClass="blackfnt" Width="100px" HorizontalAlign="Right" />
                            <ItemTemplate>
                                <asp:Label ID="LblDOCKNO" Text='<%# DataBinder.Eval(Container.DataItem, "DocketCNT") %>'
                                    runat="server"> </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="PKT GIVEN" ItemStyle-Wrap="true" ItemStyle-BackColor="white">
                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                            <ItemStyle CssClass="blackfnt" Width="100" HorizontalAlign="Right" />
                            <ItemTemplate>
                                <asp:Label ID="LblPktGiven" Text='<%# DataBinder.Eval(Container.DataItem, "PktGiven") %>'
                                    runat="server"> </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="PKT DELIVERED" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                            <ItemStyle CssClass="blackfnt" Width="100" HorizontalAlign="Right" />
                            <ItemTemplate>
                                <asp:Label ID="LblDeliveredPkt" Text='<%# DataBinder.Eval(Container.DataItem, "DeliveredPkt") %>'
                                    runat="server"> </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="PENDING PKT" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                            <ItemStyle CssClass="blackfnt" Width="100" HorizontalAlign="Right" />
                            <ItemTemplate>
                                <asp:Label ID="LblPendPkt" Text='<%# DataBinder.Eval(Container.DataItem, "PendPkt") %>'
                                    runat="server"> </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Print">
                            <ItemStyle  horizontalalign="Center" backcolor="White" wrap="false" />
                            <HeaderStyle horizontalalign="Center" cssclass="blackfnt" wrap="false" Font-Bold="true" />
                            <ItemTemplate>
                                <a href="Javascript:ViewPrint('<%# DataBinder.Eval(Container, "DataItem.DDMRNo") %>','Y')" style="text-decoration:underline">Print</a>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <%--<tr align="center" bgcolor="white" id="submit" runat="server" visible="true">
            <td class="frow" colspan="3">
                <asp:Button ID="btnShow" OnClientClick="Javascript:return OnSub_DATACHECK();" runat="server"
                    Text="Submit" Width="75px" CssClass="fbtn" OnClick="btnShow_Click" />
            </td>
        </tr>--%>
    </table>
</asp:Content>
