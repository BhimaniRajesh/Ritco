<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Show_Docket_Profitability_Report.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table align="left" style="width: 1100px">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Finance.aspx"><font class="blklnkund">
                        <b>Finance</b></font></a> <b>&gt; </b><font class="bluefnt"><b><%=Session["DocketCalledAs"]%> Profitability
                            Report</b></font>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <br />
    <br />
    <div style="width: 10in">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                    <br />
                    <p align="center">
                        <label class="blackfnt">
                            <b>You Selected
                                <asp:Label ID="Label1" runat="server" Text="Label" Visible="false"></asp:Label></b></label></p>
                    <table border="0" cellpadding="3" width="565" style="background-color: #808080;"
                        cellspacing="1" align="center" class="boxbg">
                        <tr style="background-color: #ffffff">
                            <td style="height: 10px">
                                <label class="blackfnt">
                                    Date :
                                </label>
                            </td>
                            <td style="height: 10px">
                                <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td style="width: 205">
                                <label class="blackfnt">
                                    Location :</label></td>
                            <td style="width: 343">
                                &nbsp;
                                <asp:Label ID="lblloc" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td style="width: 205; height: 6px;">
                                <label class="blackfnt">
                                    Ro :</label></td>
                            <td style="width: 343; height: 6px;">
                                &nbsp;
                                <asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <%--<asp:UpdatePanel ID="UP1" runat="Server">
                                                                    <ContentTemplate>--%>
                <asp:GridView ID="GV_Booking" runat="server" align="center" BorderWidth="0" CellPadding="5" CellSpacing="1"
                    HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                 FooterStyle-CssClass="boxbg" AllowPaging="true" PageSize="25"
                    OnRowDataBound="CustomersGridView_RowDataBound" OnPageIndexChanging="pgChange"
                    AllowSorting="False" AutoGenerateColumns="FALSE" PagerSettings-FirstPageText="[First]"
                    PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">
                    <PagerStyle VerticalAlign="Bottom" />
                    <Columns>
                        <asp:BoundField DataField="srno">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="dockno">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="dockdt">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="B_orgncd">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="D_destcd">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="pkgsno">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="actuwt">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="chrgwt">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="subtotal">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle  BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="avctaxcess">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="dkttot">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="yield">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="prsno">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Pick_up_cost">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Ba_code">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ba_comm_cost">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="thcno_1">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Thccost_1">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle  BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="thcno_2">
                            <HeaderStyle BackColor="white"  HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Thccost_2">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle  BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="thcno_3">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Thccost_3">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="thcno_4">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Thccost_4">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="thcno_5">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Thccost_5">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="drsno">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle  BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="delivery_cost">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="tottal_cost">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="profit">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:BoundField>
                    </Columns>
                </asp:GridView>
                <%-- </ContentTemplate>
                                                                </asp:UpdatePanel>--%>
            </tr>
            <tr>
                <asp:Label ID="lblnull" runat="server" Font-Bold="True" Font-Italic="False" Font-Size="Medium"
                    ForeColor="Red" Text="Label" Visible="False"></asp:Label></tr>
            <tr align="center">
            </tr>
        </table>
        <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="Server">
                                                                    <ContentTemplate>--%>
        <table border="0" cellpadding="0" width="565" style="background-color: #808080;"
            cellspacing="0" align="center" class="boxbg">
            <tr align="center">
                <td style="background-color: #ffffff">
                    <asp:LinkButton ID="LinkButton1" OnClick="fst" runat="server" Text="First">
                    </asp:LinkButton>
                </td>
                <td style="background-color: #ffffff">
                    <asp:LinkButton ID="LinkButton2" OnClick="lst" runat="server" Text="Last">
                    </asp:LinkButton>
                </td>
            </tr>
            <tr align="center" style="background-color: #ffffff">
            <td style="background-color: #ffffff" colspan="2">
                <asp:Button runat="server" Text="DownLoad XLS" ID="Button1" OnClick="btn_csv_Click" /></td></tr>
        </table>
        </div>
</asp:Content>
