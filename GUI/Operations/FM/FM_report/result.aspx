<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="result.aspx.cs" Inherits="GUI_Operations_FM_FM_report_result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="JavaScript">
        function ViewPrint(arg1,arg2,arg3)
        {
            window.open("../../PFM/pfm_print.aspx?strPFMNo=" + arg1 + "," + arg2 + "," + arg3 ,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=700,height=350,status=no,left=60,top=125");
        }
    </script>
    <div class="blackfnt">
        <table border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module </strong></font><strong>&gt; </strong><font
                        class="blklnkund"><strong>Administrator </strong></font><strong>&gt; </strong>
                    <font class="blklnkund"><strong>Operations </strong></font><strong>&gt; </strong>
                    <font class="blklnkund"><strong>DFM </strong></font><strong>&gt; </strong><font class="bluefnt">
                        <strong>View & Print</strong></font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="../../../images/clear.gif" width="2" height="1" /></td>
            </tr>
            <tr>
                <td>
                    <img src="../../../images/clear.gif" width="15" height="10" /></td>
            </tr>
            <tr>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    <table border="0" cellpadding="3" cellspacing="1" class="boxbg">
                        <tr class="bgbluegrey">
                            <td colspan="2">
                                <b>You Selected</b>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td>
                                From-To :
                            </td>
                            <td>
                                <asp:Label ID="lblDt" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td>
                                Region :
                            </td>
                            <td>
                                <asp:Label ID="lblRegion" runat="server"></asp:Label></td>
                        </tr>
                        <tr bgcolor="white">
                            <td>
                                Location :
                            </td>
                            <td>
                                <asp:Label ID="lblLoc" runat="server"></asp:Label></td>
                        </tr>
                        <tr bgcolor="white">
                            <td>
                                FM No :
                            </td>
                            <td>
                                <asp:Label ID="lblFmNO" runat="server"></asp:Label></td>
                        </tr>
                    </table>
                    <br />
                    <table border="0" cellpadding="0" width="565" bgcolor="white" cellspacing="3">
                        <tr bgcolor="white">
                            <td colspan="2">
                                <asp:Button ID="Button1" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:GridView Visible="false" ID="dgDocket" runat="server" BorderWidth="0" CellPadding="3"
                        CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="true"
                        PageSize="25" CssClass="boxbg" FooterStyle-CssClass="boxbg" AutoGenerateColumns="false" 
                        EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange">
                        <Columns>
                            <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="FM No" HeaderStyle-CssClass="blackfnt" ItemStyle-BackColor="white">
                                <ItemTemplate>
                                    <a href="JavaScript:ViewPrint('<%#DataBinder.Eval(Container.DataItem, "fm_no") %>','<%#DataBinder.Eval(Container.DataItem, "fm_doc_type") %>',0)">
                                        <font class="bluefnt"><u>
                                            <%#DataBinder.Eval(Container.DataItem, "fm_no")%>
                                        </u></font></a>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Manual_fm_no" HeaderText="Manual FM No">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField DataField="fmdt" HeaderText="FM Date">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField DataField="doc_fwd_to" HeaderText="Document Forwarded To">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Fur_FWD_loc" HeaderText="Further Forwarded Location">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Total_Documents" HeaderText="Total Documents">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField DataField="FM_Status" HeaderText="FM Status">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Print" HeaderStyle-CssClass="blackfnt" ItemStyle-BackColor="white">
                                <ItemTemplate>
                                    <a href="JavaScript:ViewPrint('<%#DataBinder.Eval(Container.DataItem, "fm_no") %>','<%#DataBinder.Eval(Container.DataItem, "fm_doc_type") %>',1)">
                                        <font class="bluefnt"><u>
                                            <%#DataBinder.Eval(Container.DataItem, "fm_no")%>
                                        </u></font></a>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <RowStyle />
                        <PagerStyle HorizontalAlign="Left" CssClass="bgbluegrey" />
                        <HeaderStyle CssClass="bgbluegrey" Font-Bold="true" />
                        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" Position="TopAndBottom" />
                        <FooterStyle CssClass="boxbg" />
                    </asp:GridView>
                    <br />
                    <table border="0" cellpadding="3" width="565" bgcolor="white" cellspacing="0">
                        <tr bgcolor="white">
                            <td colspan="2">
                                <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
