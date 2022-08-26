<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Result.aspx.cs" Inherits="GUI_UNI_MIS_Stock_Report_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
    function OpenPopupWindow(strDocketNo)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../../Operation/Singlescreen_docketentry/DocketPrint/DocketView_xls.aspx?dockno=" + strDocketNo + "&docksf=." 
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
    </script>

    <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                    class="blklnkund"><strong>Reports </strong></font><font class="bluefnt"><strong>&gt;
                        <strong>Operation </strong></font><font class="bluefnt"><strong></strong>&gt;<strong>Stock Register
                            Report</strong> </font>
            </td>
        </tr>
        <tr>
            <td class="horzblue">
                <img src="./../../images/clear.gif" width="2" height="1"></td>
        </tr>
        <tr>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img alt="Back" src="./../../images/back.gif" border="0">
                </a>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <p align="left">
                    <label class="blackfnt">
                        <b>You Selected </b>
                    </label>
                </p>
                <table runat="server" id="TBL_CRI" border="0" cellpadding="3" width="400" cellspacing="1"
                    align="left" class="boxbg">
                    <tr style="background-color: #ffffff">
                        <td style="height: 10px">
                            <label class="blackfnt">
                                Date</label></td>
                        <td style="height: 10px">
                            <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td>
                    </tr>
                    <tr style="background-color: #FFFFFF">
                        <td style="width: 205; height: 15px;">
                            <label class="blackfnt">
                                RO</label></td>
                        <td style="width: 343; height: 15px;">
                            <asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: #FFFFFF">
                        <td style="width: 205">
                            <label class="blackfnt">
                                Location</label></td>
                        <td style="width: 343">
                            <asp:Label ID="lblloc" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: #FFFFFF">
                        <td style="width: 205">
                            <label class="blackfnt">
                                Stock Type</label></td>
                        <td style="width: 343">
                            <asp:Label ID="lblStocktype" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="left">
                <br />
                <asp:Button ID="btn_csv1" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv1_Click" />
                <br />
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView align="left" ID="dgDocket" runat="server" BorderWidth="0" CellPadding="3"
                    CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="true"
                    PageSize="50" PagerStyle-HorizontalAlign="left" CssClass="boxbg" FooterStyle-CssClass="boxbg"
                    PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]"
                    OnRowDataBound="dgDocket_RowDataBound" OnPageIndexChanging="pgChange" PagerSettings-LastPageText="[Last]"
                    EmptyDataText="No Records Found...">
                    <Columns>
                        <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                            <ItemTemplate>
                                <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                    runat="server">
                                </asp:Label>
                            </ItemTemplate>
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                            <HeaderTemplate>
                                <asp:Label CssClass="blackfnt" ID="lblColname" Text='<% #DataBinder.Eval(Container.DataItem, "doc_no")%>'
                                    runat="server"> </asp:Label>
                            </HeaderTemplate>
                            <%--<ItemTemplate>
                                <asp:Label CssClass="blackfnt" ID="lbldockno" Text='<% #DataBinder.Eval(Container.DataItem, "dockno")%>'
                                    runat="server">
                                </asp:Label>
                            </ItemTemplate>--%>
                            <ItemTemplate>
                                <label class="blackfnt">
                                <a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "dockno") %>')">
                                    <%#DataBinder.Eval(Container.DataItem, "dockno")%></a>
                                </label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="blackfnt" Font-Bold="true"/>
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:TemplateField>
                         <asp:BoundField HeaderStyle-Wrap="true" DataField="pkgsno" HeaderText="No. of Packages">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" Font-Bold="true"/>
                            <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="right" BackColor="white" />
                        </asp:BoundField>
                         <asp:BoundField DataField="actuwt" HeaderText="Act Wgt ">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" Font-Bold="true"/>
                            <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="right" BackColor="white" />
                        </asp:BoundField>
                         <asp:BoundField DataField="chrgwt" HeaderText="Chrg Wgt ">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" Font-Bold="true"/>
                            <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="right" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="dockdt" HeaderText="Date">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" Font-Bold="true"/>
                            <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField HeaderStyle-Wrap="true" DataField="arr_dt" HeaderText="Arrival Date">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" Font-Bold="true"/>
                            <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField HeaderStyle-Wrap="true" DataField="days" HeaderText="No. of Days">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" Font-Bold="true"/>
                            <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="right" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="orgncd" HeaderText="Origin">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" Font-Bold="true"/>
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="reassign_destcd" HeaderText="Destination">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" Font-Bold="true"/>
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="curr_loc" HeaderText="Current Location">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" Font-Bold="true"/>
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="paybasstr" HeaderText="Paybas">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" Font-Bold="true"/>
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                         <asp:BoundField DataField="amount" HeaderText="Amount">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" Font-Bold="true"/>
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="right" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="trnmodstr" HeaderText="Mode">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" Font-Bold="true"/>
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="cnor" HeaderText="Consigner">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" Font-Bold="true"/>
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="cnee" HeaderText="Consignee">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" Font-Bold="true"/>
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="status" HeaderText="Status">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" Font-Bold="true"/>
                            <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="invamt" HeaderText="Invoice Value">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" Font-Bold="true"/>
                            <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="godownname" HeaderText="Godown Name">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" Font-Bold="true"/>
                            <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                    </Columns>
                    <RowStyle />
                    <PagerStyle HorizontalAlign="left" Font-Bold="true" CssClass="bgbluegrey" />
                    <HeaderStyle CssClass="bgbluegrey" />
                    <PagerSettings FirstPageText="[First]" Position="TopAndBottom" LastPageText="[Last]"
                        Mode="NumericFirstLast" />
                    <FooterStyle CssClass="boxbg" />
                </asp:GridView>
                <br />
            </td>
        </tr>
        <%--<tr>
            <td valign="top">
                <br />
                <asp:Table ID="TBL_Stock" border="0" HorizontalAlign="left" runat="server" CellPadding="3"
                    CellSpacing="1" Style="width: 8.5in;" CssClass="boxbg">
                </asp:Table>
                <br />
            </td>
        </tr>--%>
        <tr>
            <td align="left">
                <br />
                <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
    </table>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
