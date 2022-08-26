<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="QAStep1.aspx.cs" Inherits="GUI_UNI_Net_MIS_QAStep1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                <tr>
                    <td align="right">
                        <img src="./../images/loading.gif" alt="" />
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
    &nbsp;&nbsp;&nbsp;
    <asp:UpdatePanel ID="ww2" runat="server">
        <ContentTemplate>
            <table border="0" cellspacing="1" cellpadding="3" width="900px" class="boxbg" visible="true">
                <tr class="bgbluegrey">
                    <td colspan="2" style="text-align: left">
                    </td>
                </tr>
                <tr colspan="2" style="background-color: White;">
                    <td style="text-align: left">
                        Enter Query
                        <asp:TextBox ID="txtquery" runat="server" Width="600" Height="200" CssClass="blackfnt"
                            TextMode="MultiLine"></asp:TextBox></td>
                </tr>
                <tr style="background-color: White;">
                    <td colspan="2" align="center" style="text-align: left">
                        <asp:Button ID="btnSubmit" OnClick="btnSubmit_Click" runat="server" CssClass="blackfnt"
                            Text="Show" />
                    </td>
                </tr>
                <tr style="background-color: White;">
                    <td colspan="2" align="Left" style="text-align: left">
                        <asp:GridView ID="GRVPNL" runat="server" EmptyDataText="No Records Found" CssClass="boxbg"
                            HeaderStyle-CssClass="bgbluegrey" BorderWidth="0" CellPadding="3" CellSpacing="1"
                            OnRowDataBound="dgDocket_RowDataBound" AutoGenerateColumns="true">
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
                            </Columns>
                            <RowStyle HorizontalAlign="center" BackColor="white" CssClass="blackfnt" Wrap="false"
                                Width="200" />
                        </asp:GridView>
                            <asp:Label ID="lable11" CssClass="redfnt" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
