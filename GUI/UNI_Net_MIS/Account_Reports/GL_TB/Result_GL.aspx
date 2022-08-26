<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Result_GL.aspx.cs" Inherits="GUI_UNI_Net_MIS_Account_Reports_GL_TB_Result_GL" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table id="Table1" horizontalalign="left" runat="server" cellpadding="0" cellspacing="0"
        style="width: 10.5in;" cssclass="boxbg">
        <tr>
            <td height="30">
                <font class="bluefnt"><strong><u>&gt;&gt;&gt; General Ledger</u> </strong></font>
            </td>
        </tr>
        <tr>
                <td class="horzblue">
                    <img src="../../../images/clear.gif" width="2" height="1" /></td>
            </tr>
        <tr>
            <td align="right">
                <div align="center">
                    <asp:UpdateProgress ID="uppMain" runat="server">
                        <ProgressTemplate>
                            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                                -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                                <tr>
                                    <td align="right">
                                        <img src="../../../images/loading.gif" alt="" />
                                    </td>
                                    <td>
                                        <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                                    </td>
                                </tr>
                            </table>
                            <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
                                background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
                                opacity: .50; -moz-opacity: .50;" runat="server">
                                <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                                    left: 50%;" ID="Panel2" runat="server">
                                </asp:Panel>
                            </asp:Panel>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </div>
                <a href="javascript:window.history.go(-1)" title="back">
                    <img alt="Back" src="../../../images/back.gif" border="0" />
                </a>
            </td>
        </tr>
        <tr>
            <td>
                <br />
                <br />
                <table border="0" id="tblGl" runat="server" horizontalalign="left" cellpadding="3"
                    cellspacing="1" style="width: 5.5in;" class="boxbg">
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Date</td>
                        <td>
                            <asp:Label runat="server" ID="LBLDATE"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Branch</td>
                        <td>
                            <asp:Label runat="server" ID="LBLBRANCH"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Report Type</td>
                        <td>
                            <asp:Label runat="server" ID="LBLRPT"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Report Sub Type</td>
                        <td>
                            <asp:Label runat="server" ID="LBLSUBRPT"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Ledger</td>
                        <td>
                            <asp:Label runat="server" ID="lblLdger"></asp:Label></td>
                    </tr>
                </table>
                <br />
            </td>
        </tr>
        <tr bgcolor="white">
            <td colspan="2" align="left">
                <asp:Button ID="Button1" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
            </td>
        </tr>
        <tr bgcolor="white" id="TRPG" runat="server" style="display: block;">
            <td colspan="2" align="left" valign="top">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <img alt="Back" id="imgPrev" style="display: none;" runat="server" src="../../../images/prev.gif"
                            border="0" />
                        <font class="blackfnt">Page :</font>
                        <asp:DropDownList ID="PAging" CssClass="blackfnt" runat="server" OnSelectedIndexChanged="PAging_SelectedIndexChanged">
                        </asp:DropDownList>
                        <font class="blackfnt">&nbsp;&nbsp;<b>of</b>&nbsp;
                            <%=TOTPg%>
                        </font>
                        <img alt="Back" id="imgNext" style="display: none;" runat="server" src="../../../images/next.gif"
                            border="0" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView Visible="false" align="left" ID="dgDocket" runat="server" BorderWidth="0"
                    CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="false"
                    CssClass="boxbg" AutoGenerateColumns="false" FooterStyle-CssClass="boxbg" OnRowDataBound="dgDocket_RowDataBound"
                    EmptyDataText="No Records Found...">
                    <Columns>
                        <asp:BoundField DataField="ROWNO" HeaderText="">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" Font-Bold="true" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Customer" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:Label ID="lblCust" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "PBOV_Name")%>'
                                    CssClass="bluefnt"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle BackColor="white" Font-Bold="true" CssClass="blackfnt" HorizontalAlign="left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Account" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:Label ID="lblACC" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Accdesc")%>'
                                    CssClass="bluefnt"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle BackColor="white" Font-Bold="true" CssClass="blackfnt" HorizontalAlign="left" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="voucherno" HeaderText="Voucher No.">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="transdate" HeaderText="Date">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="oppaccount" HeaderText="Particular">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="debit" HeaderText="Debit">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" HorizontalAlign="Right" Wrap="False" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="credit" HeaderText="Credit">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" HorizontalAlign="Right" Wrap="False" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PBOV_name" HeaderText="Party">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Narration" HeaderText="Narration">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CHQNO" HeaderText="Cheque No">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Chqdate" HeaderText="Cheque Date">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                    </Columns>
                </asp:GridView>
                <br />
            </td>
        </tr>
        <tr bgcolor="white">
            <td colspan="2" align="left">
                <asp:Button ID="Button2" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
