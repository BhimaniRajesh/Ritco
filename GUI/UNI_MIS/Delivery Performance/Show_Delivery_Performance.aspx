<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Show_Delivery_Performance.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <div align="left" style="width: 9in;">
        <table style="width: 1100px">
            <tr>
                <td align="left">
                    <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                        <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Operation.aspx"><font class="blklnkund">
                            <b>Operations</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Delivery Performance
                                Report</b></font>
                </td>
                
            </tr>
        </table>
        <br /><br />
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr align="left" style="background-color: #ffffff">
                <td>
                    <%--
                    <br />
                    <p align="center">
                        <label class="blackfnt">
                            <b>You Selected
                         
                                <asp:Label ID="Label1" runat="server" Text="Label" Visible="false"></asp:Label></b></label></p>--%>
                                <div align="left" style="width: 9in;">
                    <table border="0" cellpadding="5" width="565" 
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
                    </div>
                </td>
            </tr>
            <tr style="background-color: #ffffff">
                <td>      <br /><br /><br />
                    <%--<asp:UpdatePanel ID="UP1" runat="Server">
                                                                    <ContentTemplate>--%>
                    <asp:GridView ID="GV_Booking" runat="server" align="center" BorderWidth="0" CellPadding="5"
                        HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" CssClass="boxbg" CellSpacing="1"
                      FooterStyle-CssClass="boxbg" AllowPaging="true" PageSize="25"
                        OnPageIndexChanging="pgChange" AllowSorting="False" AutoGenerateColumns="false"
                        PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">
                        <PagerStyle VerticalAlign="Bottom" />
                        <Columns>
                            <asp:TemplateField HeaderText="SR.NO.">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="loccode" HeaderText="Location">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white"   CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:HyperLinkField DataNavigateUrlFields="loccode" HeaderStyle-CssClass="blackfnt" ItemStyle-BackColor="white" 
                                HeaderText="Dockets Arrived" ControlStyle-Font-Underline="true" DataNavigateUrlFormatString="DetailFlow.aspx?loc={0}&reppara=1"
                                DataTextField="Total_docket" />
                            <asp:HyperLinkField HeaderStyle-CssClass="blackfnt" DataNavigateUrlFields="loccode"
                                ItemStyle-BackColor="white"  HeaderText="DRS Not Generated" ControlStyle-Font-Underline="true" DataNavigateUrlFormatString="DetailFlow.aspx?loc={0}&reppara=2"
                                DataTextField="TotalDRS_Docket_not" />
                            <asp:BoundField DataField="TotalDRS_Docket_not_per" HeaderText="Percentage ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                                <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:HyperLinkField HeaderStyle-CssClass="blackfnt" DataNavigateUrlFields="loccode"
                                ItemStyle-BackColor="white"  HeaderText="Total DRS generated " ControlStyle-Font-Underline="true" DataNavigateUrlFormatString="DetailFlow.aspx?loc={0}&reppara=3"
                                DataTextField="TotalDRSGEN_Docket" />
                            <asp:BoundField DataField="TotalDRSGEN_Docket_per" HeaderText="Percentage">
                                <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                                <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:HyperLinkField HeaderStyle-CssClass="blackfnt" DataNavigateUrlFields="loccode"
                                 ItemStyle-BackColor="white" HeaderText="Gen 0-12 hr" ControlStyle-Font-Underline="true" DataNavigateUrlFormatString="DetailFlow.aspx?loc={0}&reppara=4"
                                DataTextField="gen_0" />
                            <asp:BoundField DataField="gen_0_per" HeaderText="Percentage">
                                <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                                <ItemStyle  BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:HyperLinkField HeaderStyle-CssClass="blackfnt" DataNavigateUrlFields="loccode"
                                ItemStyle-BackColor="white"  HeaderText="Gen 12-24 hr" ControlStyle-Font-Underline="true" DataNavigateUrlFormatString="DetailFlow.aspx?loc={0}&reppara=5"
                                DataTextField="gen_12" />
                            <asp:BoundField DataField="gen_12_per" HeaderText="Percentage">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:HyperLinkField HeaderStyle-CssClass="blackfnt" DataNavigateUrlFields="loccode"
                                ItemStyle-BackColor="white"  HeaderText="Gen 1 day" ControlStyle-Font-Underline="true" DataNavigateUrlFormatString="DetailFlow.aspx?loc={0}&reppara=6"
                                DataTextField="gen_1" />
                            <asp:BoundField DataField="gen_1_per" HeaderText="Percentage">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:HyperLinkField HeaderStyle-CssClass="blackfnt" DataNavigateUrlFields="loccode"
                                ItemStyle-BackColor="white"  HeaderText="Gen 2 days " ControlStyle-Font-Underline="true" DataNavigateUrlFormatString="DetailFlow.aspx?loc={0}&reppara=7"
                                DataTextField="gen_2" />
                            <asp:BoundField DataField="gen_2_per" HeaderText="Percentage">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:HyperLinkField HeaderStyle-CssClass="blackfnt" DataNavigateUrlFields="loccode"
                                ItemStyle-BackColor="white"  HeaderText="Gen >2 days " ControlStyle-Font-Underline="true" DataNavigateUrlFormatString="DetailFlow.aspx?loc={0}&reppara=8"
                                DataTextField="gen_2More" />
                            <asp:BoundField DataField="gen_2More_per" HeaderText="Percentage">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle  BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:HyperLinkField HeaderStyle-CssClass="blackfnt" DataNavigateUrlFields="loccode"
                                ItemStyle-BackColor="white"  HeaderText="DRS NOT Updated" ControlStyle-Font-Underline="true" DataNavigateUrlFormatString="DetailFlow.aspx?loc={0}&reppara=9"
                                DataTextField="DRS_not_update" />
                            <asp:BoundField DataField="DRS_not_update_per" HeaderText="Percentage">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:HyperLinkField HeaderStyle-CssClass="blackfnt" DataNavigateUrlFields="loccode"
                                 ItemStyle-BackColor="white" HeaderText="Total DRS updated" ControlStyle-Font-Underline="true" DataNavigateUrlFormatString="DetailFlow.aspx?loc={0}&reppara=10"
                                DataTextField="DRS_updated" />
                            <asp:BoundField DataField="DRS_updated_per" HeaderText="Percentage">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:HyperLinkField HeaderStyle-CssClass="blackfnt" DataNavigateUrlFields="loccode"
                               ItemStyle-BackColor="white"   HeaderText="Updated 0-12 hr " ControlStyle-Font-Underline="true" DataNavigateUrlFormatString="DetailFlow.aspx?loc={0}&reppara=11"
                                DataTextField="DRS_Update_0" />
                            <asp:BoundField DataField="DRS_Update_0_per" HeaderText="Percentage">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:HyperLinkField HeaderStyle-CssClass="blackfnt" DataNavigateUrlFields="loccode"
                                ItemStyle-BackColor="white"  HeaderText="Updated 12-24 hr" ControlStyle-Font-Underline="true" DataNavigateUrlFormatString="DetailFlow.aspx?loc={0}&reppara=12"
                                DataTextField="DRS_Update_12" />
                            <asp:BoundField DataField="DRS_Update_12_per" HeaderText="Percentage">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:HyperLinkField HeaderStyle-CssClass="blackfnt" DataNavigateUrlFields="loccode"
                                 ItemStyle-BackColor="white" HeaderText="Updated 1 day " ControlStyle-Font-Underline="true" DataNavigateUrlFormatString="DetailFlow.aspx?loc={0}&reppara=13"
                                DataTextField="DRS_Update_1" />
                            <asp:BoundField DataField="DRS_Update_1_per" HeaderText="Percentage">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:HyperLinkField HeaderStyle-CssClass="blackfnt" DataNavigateUrlFields="loccode"
                                ItemStyle-BackColor="white"  HeaderText=" Updated 2 days  " ControlStyle-Font-Underline="true" DataNavigateUrlFormatString="DetailFlow.aspx?loc={0}&reppara=14"
                                DataTextField="DRS_Update_2" />
                            <asp:BoundField DataField="DRS_Update_2_per" HeaderText="Percentage">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white"  CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:HyperLinkField HeaderStyle-CssClass="blackfnt" DataNavigateUrlFields="loccode"
                                ItemStyle-BackColor="white"  HeaderText="Updated >2 days " ControlStyle-Font-Underline="true" DataNavigateUrlFormatString="DetailFlow.aspx?loc={0}&reppara=15"
                                DataTextField="DRS_Update_2More" />
                            <asp:BoundField DataField="DRS_Update_2More_per" HeaderText="Percentage">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle  BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
                    <%-- </ContentTemplate>
                                                              </asp:UpdatePanel>--%>
                </td>
            </tr>
            <tr style="background-color: #ffffff">
                <asp:Label ID="lblnull" runat="server" Font-Bold="True" Font-Italic="False" Font-Size="Medium"
                    ForeColor="Red" Text="Label" Visible="False"></asp:Label></tr>
            <tr style="background-color: #ffffff">
                <td colspan="2" style="background-color: #ffffff" align="center">
                    <br />
                    <br />
                    <br />
                    <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                </td>
            </tr>
        </table>
        <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="Server">
                                                                    <ContentTemplate>--%>
        <table border="0" cellpadding="0" width="565" style="background-color: #ffffff" cellspacing="0"
            align="center" class="boxbg">
            <tr style="background-color: #ffffff" align="center">
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
                <asp:Button class="btncolor" runat="server" ID="Button1" OnClick="Button1_Click" />
            </tr>
        </table>
    </div>
</asp:Content>
