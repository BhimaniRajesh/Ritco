<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="DownloadExternalThcScannDocResult.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_ExternalThcAudit_DownloadExternalThcScannDocResult" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <div class="blackfnt">
        <table border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module </strong></font><strong>&gt; </strong><font
                        class="blklnkund"><strong>Fleet </strong></font><strong>&gt; </strong>
                    <font class="blklnkund"><strong>Operations </strong></font><strong>&gt; </strong>
                    <font class="blklnkund"><strong>External Thc </strong></font><strong>&gt; </strong><font class="bluefnt">
                        <strong>Download</strong></font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="../../../../images/clear.gif" width="2" height="1" /></td>
            </tr>
            <tr>
                <td>
                    <img src="../../../../images/clear.gif" width="15" height="10" /></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
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
                            <td>From-To :
                            </td>
                            <td>
                                <asp:Label ID="lblDt" runat="server"></asp:Label>
                            </td>
                        </tr>

                        <tr bgcolor="white">
                            <td>External Thc No :
                            </td>
                            <td>
                                <asp:Label ID="lblExternalThcNo" runat="server"></asp:Label></td>
                        </tr>
                    </table>
                    <br />
                    <asp:GridView Visible="false" ID="dgExternalThc" runat="server" BorderWidth="0" CellPadding="3"
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
                            <asp:TemplateField HeaderText="External Thc No" HeaderStyle-CssClass="blackfnt" ItemStyle-BackColor="white">
                                <ItemTemplate>
                                    <font><u>
                                        <%#DataBinder.Eval(Container.DataItem, "ExternalThcNo")%>
                                    </u></font></a>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="UploadFileName" HeaderText="Transporter Document" ItemStyle-BackColor="white">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" />
                            </asp:BoundField>
                            <asp:TemplateField ItemStyle-BackColor="white">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkDownload" Text="Download" CommandArgument='<%# Eval("UploadFileName") %>' runat="server" OnClick="DownloadFile"></asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                        </Columns>
                        <RowStyle />
                        <PagerStyle HorizontalAlign="Left" CssClass="bgbluegrey" />
                        <HeaderStyle CssClass="bgbluegrey" Font-Bold="true" />
                        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" Position="TopAndBottom" />
                        <FooterStyle CssClass="boxbg" />
                    </asp:GridView>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
