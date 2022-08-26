<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="ReprotList.aspx.cs" Inherits="GUI_UNI_NET_MIS_ReprotList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:SqlDataSource ID="MySQLDataSource_GeneralMaster" runat="server" EnableCaching="false" SelectCommand="WebxNet_ReportList_Newmenu"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="RPTTYP" QueryStringField="RPTSUBTYP" DefaultValue="All"
                Type="string" />
            <asp:QueryStringParameter Name="RPTSUBTYP" QueryStringField="RPTSUBTYP" DefaultValue="All"
                Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:UpdatePanel ID="upd2" runat="server">
        <ContentTemplate>
            <div class="blackfnt">
                <br />
                <b>Reports</b>
                <div align="center">
                    <asp:UpdateProgress ID="uppMain" runat="server">
                        <ProgressTemplate>
                            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                                -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                                <tr>
                                    <td align="right">
                                        <img id="Img1" src="./../images/loading.gif" runat="server" />
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
                <hr />
                <table border="0" class="boxbg" cellpadding="3" cellspacing="0" style="width: 13 in">
                    <tr bgcolor="white">
                        <td align="Left">
                            <asp:GridView CssClass="boxbg" runat="server" ID="grvRank" Width="13 in" DataSourceID="MySQLDataSource_GeneralMaster"
                                CellPadding="3" CellSpacing="1" AllowSorting="true" AutoGenerateColumns="false"
                             EmptyDataText="No Reports Available For this User"   
                              EmptyDataRowStyle-BackColor="White" EmptyDataRowStyle-CssClass="redfnt" 
                               EmptyDataRowStyle-Font-Bold="true" EmptyDataRowStyle-HorizontalAlign="Center" OnRowCommand="grvRank_RowCommand" GridLines="None">
                                <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Center" ForeColor="Black" />
                                <RowStyle CssClass="blackfnt" />
                                <Columns>
                                    <asp:BoundField DataField="ROWNO" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center"
                                        ItemStyle-BackColor="White" HeaderText="SR No." SortExpression="module" />
                                    <asp:BoundField  Visible="false" DataField="Report_name" ItemStyle-Width="20%" ItemStyle-Font-Underline="true"
                                        ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Left" ItemStyle-BackColor="White"
                                        HeaderText="Report Name" SortExpression="module" />
                                    <asp:TemplateField HeaderText="Report Name">
                                        <HeaderStyle Width="180" />
                                        <ItemStyle HorizontalAlign="Left" BackColor="White" VerticalAlign="Middle" />
                                        <ItemTemplate>
                                        
                                         <a href='<%#DataBinder.Eval(Container.DataItem, "link1")%>'><u><%#DataBinder.Eval(Container.DataItem, "Report_name")%></u></a>
                                           
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="descp" ItemStyle-BackColor="White" ItemStyle-Wrap="false"
                                        HeaderText="Description" SortExpression="ord" ItemStyle-HorizontalAlign="Left" />
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
                <%--                </ContentTemplate>
            </asp:UpdatePanel>--%>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    </div>
</asp:Content>
