<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Show_Svrctax_reg.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <div align="left" style="width: 9.5in;">
        <table style="width: 1100px">
            <tr>
                <td align="left">
                    <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                        <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Finance.aspx"><font class="blklnkund">
                            <b>Finance</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Service Tax Regester
                                Report</b></font>
                </td>
            </tr>
        </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                    <br />
                    <p align="center">
                        <label class="blackfnt">
                            <b>You Selected
                                <asp:Label ID="Label1" runat="server" Text="Label" Visible="false"></asp:Label></b></label></p>
                    <table border="0" cellpadding="5" width="565" cellspacing="1" align="center" class="boxbg">
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
                    <br />
                    <br />
                </td>
            </tr>
            <%--<tr>  
                                                                
                                                                
                                                                
                                                                   
                                                                   <%--<asp:UpdatePanel ID="UP1" runat="Server">
                                                                    <ContentTemplate>--%>
            <asp:GridView ID="GV_Booking" runat="server" HorizontalAlign="Center" BorderWidth="0"
                CellPadding="5" HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left"
                CellSpacing="1" CssClass="boxbg" FooterStyle-CssClass="boxbg" AllowPaging="true"
                PageSize="25" OnRowDataBound="CustomersGridView_RowDataBound" OnPageIndexChanging="pgChange"
                AllowSorting="False" AutoGenerateColumns="false" FooterStyle-BackColor="white"
                ShowFooter="true" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                EmptyDataText="No Records Found...">
                <PagerStyle VerticalAlign="Bottom" />
                <Columns>
                    <%--  <asp:BoundField  DataField="Sno"   ItemStyle-Wrap="true"     > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="20"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>--%>
                    <asp:BoundField DataField="MRSNo" ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dockno" ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="MRSTYPE" ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="MRSDT" ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="PTNAME" ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="MRBRNNM" ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="MRSAMT" ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="svctax_rate" ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="cess_rate" ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <%--   docket--%>
                    <asp:BoundField DataField="COL_FRT" ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="COL_STAX" ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="COL_CESS" ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <%--   other did--%>
                    <asp:BoundField DataField="Othded_frt" ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Othded_svctax" ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Othded_cess" ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <%--   other chrg--%>
                    <asp:BoundField DataField="OthChrg_frt" ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="OthChrg_svctax" ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="OthChrg_cess" ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <%--   recived
                                                                               --%>
                    <asp:BoundField DataField="" ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="" ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="" ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="DED_TDS" ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="NETAMT1" ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                </Columns>
            </asp:GridView>
            <%--      OnRowDataBound="CustomersGridView_RowDataBound"
                                                                --%>
            <%-- </ContentTemplate>
                                                                </asp:UpdatePanel>--%>
            <tr>
                <asp:Label ID="lblnull" runat="server" Font-Bold="True" Font-Italic="False" Font-Size="Medium"
                    ForeColor="Red" Text="Label" Visible="False"></asp:Label></tr>
            <tr align="center">
            </tr>
        </table>
        <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="Server">
                                                                    <ContentTemplate>--%>
        <br />
        <table border="0" cellpadding="0" width="565" bgcolor="white" cellspacing="0" align="center">
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
            <tr align="center">
                <asp:Button class="btncolor" runat="server" ID="Button1" OnClick="Button1_Click" /></tr>
            <tr bgcolor="white">
                <td colspan="2" align="center">
                    <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
