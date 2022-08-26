<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Result.aspx.cs" Inherits="GUI_UNI_Net_MIS_OPS_StatusReprot_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Reports </strong></font><font class="bluefnt"><strong>&gt;
                        </strong><strong>Operation Performance Report</strong> </font>
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
                    <div align="Left">
                        <asp:UpdateProgress ID="uppMain" runat="server">
                        <ProgressTemplate>
                            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                                -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                                <tr>
                                    <td align="right">
                                        <img src="./../../images/loading.gif" alt="" />
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
                </td>
            </tr>
            
            <tr>
                <td>
                    <table border="0" horizontalalign="left" id="Cri" runat="server" cellpadding="3"
                        cellspacing="1" style="width: 5.5in;" class="boxbg">
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
                                <asp:Label runat="server" ID="LBLBRANCH"></asp:Label></td>
                        </tr>
                        <tr bgcolor="white" class="blackfnt">
                            <td>
                                Paybasis</td>
                            <td>
                                <asp:Label runat="server" ID="lblPaybasis"></asp:Label></td>
                        </tr>
                        <tr bgcolor="white" class="blackfnt">
                            <td>
                                Mode Type</td>
                            <td>
                                <asp:Label ID="lblmode" runat="server"></asp:Label></td>
                        </tr>
                        <tr bgcolor="white" class="blackfnt">
                            <td>
                                Booking Type</td>
                            <td>
                                <asp:Label ID="lblBKGTYP" runat="server"></asp:Label></td>
                        </tr>
                        <tr bgcolor="white" class="blackfnt">
                            <td>
                                Load Type</td>
                            <td>
                                <asp:Label ID="Label1" runat="server"></asp:Label></td>
                        </tr>
                        <tr bgcolor="white" class="blackfnt">
                            <td>
                                Status</td>
                            <td>
                                <asp:Label ID="lblStatus" runat="server"></asp:Label></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr bgcolor="white">
            <td colspan="2" align="left">
             <br />
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
                <td height="300" valign="top">
                   
                    <br />
                    <asp:GridView ID="GRVPNL" runat="server" EmptyDataText="No Records Found" CssClass="boxbg"
                        HeaderStyle-CssClass="bgbluegrey" BorderWidth="0" k CellPadding="3" CellSpacing="1"
                    OnRowDataBound="dgDocket_RowDataBound"    AutoGenerateColumns="false">
                         <Columns><asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text=""
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="Report_loc" HeaderText="Region">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                             <asp:BoundField DataField="codedesc" HeaderText="Zone">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                             <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                                <HeaderTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblColname" runat="server"> </asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lbldockno" Text='<% #DataBinder.Eval(Container.DataItem, "dockno")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="Orgncd" HeaderText="Origin">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Curr_loc" HeaderText="Curr.Loc">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                             <asp:BoundField DataField="reassign_destcd" HeaderText="Destination">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            
                             <asp:BoundField DataField="DKTDT" HeaderText="Date">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ArrDt" HeaderText="Arrived. Date">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                             <asp:BoundField DataField="EDD" HeaderText="EDD">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                             <asp:BoundField DataField="ADDD" HeaderText="ADD">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            
                             <asp:BoundField DataField="paybasstr" HeaderText="Paybasis">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="trnmodstr" HeaderText="Mode">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                             <asp:BoundField DataField="BookingType" HeaderText="Bkg. Type">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                             <asp:BoundField DataField="BUSTYP" HeaderText="Busi.Type">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            
                            <asp:BoundField DataField="Cnor" HeaderText="Cnor">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                             <asp:BoundField DataField="Cnee" HeaderText="Cnee">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            
                            
                            <asp:BoundField DataField="pkgsno" HeaderText="Pkgs">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="actuwt" HeaderText="Actu.Wt.">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="Right" />
                            </asp:BoundField>
                             <asp:BoundField DataField="chrgwt" HeaderText="Chrg.Wt.">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="Right" />
                            </asp:BoundField>
                             <asp:BoundField DataField="Yield" HeaderText="Yield">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="Right" />
                            </asp:BoundField>
                             <asp:BoundField DataField="subtotal" HeaderText="Sub Total">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="Right" />
                            </asp:BoundField>
                             <asp:BoundField DataField="freight" HeaderText="Freight">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="Right" />
                            </asp:BoundField>
                             <asp:BoundField DataField="dkttot" HeaderText="Amount">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="Right" />
                            </asp:BoundField>
                             <asp:BoundField DataField="invamt" HeaderText="InVoice Amount">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="Right" />
                            </asp:BoundField>
                            
                            <asp:BoundField DataField="Status" HeaderText="Status">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                                 <asp:BoundField DataField="ACTSTATUS" HeaderText="Service Level">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            
                            <asp:BoundField DataField="EXPINTRD" HeaderText="Expected TR Days (EDD-Booking DT)">
                                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ACTINTRD" HeaderText="Actual TR Days-(ADD-BKG DT)">
                                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            
                             </Columns>
                        <RowStyle HorizontalAlign="center" BackColor="white" CssClass="blackfnt" Wrap="false"
                            Width="200" />
                           
                            
                    </asp:GridView>
                   
                    <br />
                </td>
                
                 <tr bgcolor="white">
            <td colspan="2" align="left">
            <br />
                <asp:Button ID="Button2" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
            </td>
        </tr>
            </tr>
            <tr>
                <td height="30" valign="top">
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
