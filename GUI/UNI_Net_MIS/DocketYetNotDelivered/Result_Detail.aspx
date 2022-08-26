<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Result_Detail.aspx.cs" Inherits="GUI_UNI_Net_MIS_DocketYetNotDelivered_Result_Detail" EnableEventValidation="false"%>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
function OpenPopupWindow(strDocketNo)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=900hi ,height=540,status=no,left=60,top=50"
            var strPopupURL = "../../Operation/Singlescreen_docketentry/DocketPrint/DocketView_xls.aspx?dockno="+strDocketNo+"&docksf=."
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        </script>
    
    <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                    class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong><font
                        class="blklnkund"><strong>Operation </strong></font><font class="bluefnt"><strong>&gt;
                        </strong><strong>Docket Not Yet Delivered</strong> </font>
            </td>
        </tr>
        <tr>
            <td class="horzblue">
                <img src="./../../images/clear.gif" width="2" height="1" /></td>
        </tr>
        <tr>
            <td align="right">
                <div align="center">
                    <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                        <ProgressTemplate>
                            <div id="progressArea">
                                <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true"></asp:Label>
                                <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </div>
                <a href="javascript:window.history.go(-1)" title="back">
                    <img alt="Back" src="./../../images/back.gif" border="0" />
                </a>
            </td>
        </tr>
        <tr>
            <td>
                <table border="0" runat="server" id="TBL_CRI" horizontalalign="left" cellpadding="3"
                    cellspacing="1" style="width: 7.0in;" class="boxbg">
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Date</td>
                        <td>
                            <asp:Label runat="server" ID="LBLDATE"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Location</td>
                        <td>
                            <asp:Label runat="server" ID="LBLRPT"></asp:Label></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <br />
                <asp:Button ID="Button1" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
            </td>
        </tr>
        <tr>
            <td valign="top">
                <br />
                <br />
                <asp:GridView align="left" ID="dgDocket" runat="server" BorderWidth="0" AutoGenerateColumns="false"
                    CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
                    ShowFooter="false" AllowPaging="true" PageSize="100" PagerStyle-HorizontalAlign="left"
                    CssClass="boxbg" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                    PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..."
                    OnPageIndexChanging="pgChange">
                    <Columns>
                        <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                            <ItemTemplate>
                                <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                    runat="server">
                                </asp:Label>
                            </ItemTemplate>
                            <ItemStyle Wrap="false" CssClass="blackfnt" HorizontalAlign="Center" />
                            <HeaderStyle Wrap="false" CssClass="blackfnt" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="DocketNo">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lblDockno" Visible="false" CssClass="blackfnt" Font-Underline="true"
                            Text='<%# DataBinder.Eval( Container.DataItem,"dockno") %>' runat="server"></asp:LinkButton>
                        <a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "dockno") %>')">
                            <font class="Blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "dockno")%></a>
                    </ItemTemplate>
                </asp:TemplateField>
                        <%--<asp:TemplateField HeaderText="DocketNo">
                            <ItemTemplate>
                                <asp:Label CssClass="blackfnt" ID="lblDockdt" Text='<% #DataBinder.Eval(Container.DataItem, "dockno")%>'
                                    runat="server">
                                </asp:Label>
                            </ItemTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                            <HeaderStyle CssClass="blackfnt" />
                        </asp:TemplateField>--%>
                        <asp:TemplateField HeaderText="Docket Date">
                            <ItemTemplate>
                                <asp:Label CssClass="blackfnt" ID="lblDockdt" Text='<% #DataBinder.Eval(Container.DataItem, "dockdt")%>'
                                    runat="server">
                                </asp:Label>
                            </ItemTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                            <HeaderStyle CssClass="blackfnt" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="EDD" HeaderText="EDD">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="orgncd" HeaderText="Origin">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="reassign_destcd" HeaderText="Destination">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="curr_loc" HeaderText="Curr. Loc.">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Cnor" HeaderText="Cnor">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Cnee" HeaderText="Cnee">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="pkgsno" HeaderText="Packages">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="actuwt" HeaderText="Actual Weight">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="chrgwt" HeaderText="Charge Weight">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Freight" HeaderText="Freight">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Docket_Status" HeaderText="Status">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                    </Columns>
                    <RowStyle HorizontalAlign="center" BackColor="white" CssClass="blackfnt" Wrap="false"
                        Width="200" />
                    <PagerStyle HorizontalAlign="left" Font-Bold="true" CssClass="bgbluegrey" />
                    <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                    <FooterStyle CssClass="bgbluegrey" Wrap="false" Width="200" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <br />
                <asp:Button ID="Button2" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
