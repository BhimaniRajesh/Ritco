<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Result.aspx.cs" Inherits="GUI_UNI_MIS_Account_Reports_TrailBalance_ver3_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                    class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong><font
                        class="blklnkund"><strong>Finance </strong></font><font class="bluefnt"><strong>&gt;
                        </strong><strong>Trail Balance Report</strong> </font>
            </td>
        </tr>
        <tr>
            <td class="horzblue">
                <img src="../../../images/clear.gif" width="2" height="1" /></td>
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
                    <img alt="Back" src="../../../images/back.gif" border="0" />
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
                            RO</td>
                        <td>
                            <asp:Label runat="server" ID="LBLBRANCH"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Location</td>
                        <td>
                            <asp:Label runat="server" ID="LBLRPT"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Groups</td>
                        <td>
                            <asp:Label runat="server" ID="lblGrp"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Accounts</td>
                        <td>
                            <asp:Label runat="server" ID="LBLSUBRPT"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            <asp:Label runat="server" ID="lblCust_vend_typ"></asp:Label></td>
                        <td>
                            <asp:Label runat="server" ID="lblCust_vend"></asp:Label></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <br />
                <table border="0" cellpadding="0" width="565" bgcolor="white" cellspacing="0" align="Left">
                    <tr bgcolor="white">
                        <td colspan="2" align="center">
                            <asp:Button ID="Button1" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <br />
                <asp:Table ID="TBL_TB" Visible="false" border="0" HorizontalAlign="left" runat="server"
                    CellPadding="3" CellSpacing="1" Style="width: 8.5in; border: 1" CssClass="boxbg">
                </asp:Table>
                <asp:GridView runat="server" ID="GRV_TB" BorderWidth="0" CellPadding="3" CellSpacing="1"
                    CssClass="boxbg" EmptyDataText="No Records Found..."  HeaderStyle-CssClass="bgbluegrey" AutoGenerateColumns="false" AllowSorting="false"
                    OnRowDataBound="GRV_TB_RowDataBound">
                    <Columns>
                     <asp:BoundField DataField="Heading" HeaderText="">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" Font-Bold="true" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                    <asp:TemplateField HeaderText="Customer" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:Label ID="lblCust"  runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "NM")%>'
                                    CssClass="bluefnt"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle BackColor="white" Wrap="False" Font-Bold="true" CssClass="blackfnt" HorizontalAlign="left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Account" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:Label ID="lblACC"  runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "acccode")%>'
                                    CssClass="bluefnt"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle BackColor="white" Wrap="False" Font-Bold="true" CssClass="blackfnt" HorizontalAlign="left" />
                        </asp:TemplateField>
                        
                        <asp:BoundField DataField="VRNO" HeaderText="Voucher No.">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="VRDATE" HeaderText="Date">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="particular" HeaderText="Particular">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="debit" HeaderText="Debit">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" HorizontalAlign="Right" Wrap="False" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="credit" HeaderText="Credit">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" HorizontalAlign="Right" Wrap="False" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="party" HeaderText="Party">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Narration" HeaderText="Narration">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CHQNO" HeaderText="Cheque No">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CHQDT" HeaderText="Cheque Date">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                   
                    </Columns>
                </asp:GridView>
                <%-- <asp:GridView Visible="false" align="left" ID="dgDocket" runat="server" BorderWidth="0"
                    CellPadding="3" CellSpacing="1"  HeaderStyle-CssClass="StaticColumn" AllowSorting="false"
                    CssClass="boxbg" AutoGenerateColumns="false" FooterStyle-CssClass="boxbg" OnRowDataBound="dgDocket_RowDataBound"
                    EmptyDataText="No Records Found...">
                    <Columns>
                        <asp:TemplateField HeaderText="Account" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:Label ID="lnk0" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "acccode")%>'
                                    CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                            </ItemTemplate>
                            <ItemStyle BackColor="white" Wrap="False" Font-Bold="true" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="Heading" HeaderText="">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" Font-Bold="true" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="VRNO" HeaderText="Voucher No.">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="VRDATE" HeaderText="Date">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="particular" HeaderText="Particular">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="debit" HeaderText="Debit">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" HorizontalAlign="Right" Wrap="False" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="credit" HeaderText="Credit">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" HorizontalAlign="Right" Wrap="False" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="party" HeaderText="Party">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Narration" HeaderText="Narration">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CHQNO" HeaderText="Cheque No">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CHQDT" HeaderText="Cheque Date">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                    </Columns>
                </asp:GridView>--%>
                <br />
            </td>
        </tr>
        <tr>
            <td valign="top">
                <br />
                <table border="0" cellpadding="0" width="565" bgcolor="white" cellspacing="0" align="Left">
                    <tr bgcolor="white">
                        <td colspan="2" align="center">
                            <asp:Button ID="Button2" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
