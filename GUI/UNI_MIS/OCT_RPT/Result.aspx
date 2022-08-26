<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Result.aspx.cs" EnableEventValidation="false" Inherits="GUI_UNI_MIS_OCT_RPT_Result" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
 <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                    class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong><font
                        class="blklnkund"><strong>Operation </strong></font><font class="bluefnt"><strong>&gt;
                        </strong><strong>Octroi Report</strong> </font>
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
                <table border="0" runat="server" id="TBL_CRI"   horizontalalign="left" cellpadding="3" cellspacing="1" style="width: 7.0in;"
                    class="boxbg">
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Date</td>
                        <td>
                            <asp:Label runat="server" ID="LBLDATE"></asp:Label></td>
                    </tr>
                   
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Status</td>
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
            <td valign="top"><br />
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
               <asp:GridView Visible="false" align="center" ID="dgDocket" runat="server" BorderWidth="0"
                        CellPadding="2" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
                        AllowPaging="true" PageSize="50" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                        FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                        PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" OnRowDataBound="dgDocket_RowDataBound"
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
                            
                            <asp:TemplateField HeaderText="DocNO" ItemStyle-BackColor="white" >
                                <HeaderTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblColdockno1" runat="server"> </asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lbldockno1" Text='<% #DataBinder.Eval(Container.DataItem, "dockno")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            
 
                            
                            
                           
                          
                            <asp:BoundField  DataField="Dockdt" HeaderText=" Date">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField  DataField="paybasstr" HeaderText=" Paybas">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField  DataField="orgncd" HeaderText=" Origin">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField  DataField="reassign_DESTCD" HeaderText=" Destination">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField  DataField="Freight" HeaderText=" Freight">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField  DataField="DECLVAL" HeaderText=" Invoice Value">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField  DataField="recptno" HeaderText=" Octroi receipt no">
                                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField  DataField="octamt" HeaderText=" Octroi amount">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField  DataField="OCT_CUSTPAIDBY" HeaderText=" Octroi paid by">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField  DataField="OCT_CUST" HeaderText=" Customer">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField  DataField="process_chrg" HeaderText=" Octroi processing charges">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField  DataField="OTCHG" HeaderText=" Other charges">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField  DataField="billno" HeaderText=" Bill No.">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField  DataField="MRSNO" HeaderText=" MR No.">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField  DataField="Vendor" HeaderText=" Vendor ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <%--<asp:BoundField  DataField="Dockdt" HeaderText=" Vendor name">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>--%>
                            <asp:BoundField  DataField="OCBILLNO" HeaderText=" Bill entry no.">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField  DataField="voucherNo" HeaderText=" Voucher No.">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                           <%-- <asp:BoundField  DataField="Dockdt" HeaderText=" Customer">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField Visible="false" DataField="Dockdt" HeaderText=" Customer">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField Visible="false" DataField="Dockdt" HeaderText=" Customer">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>--%>
                           
                           
                        </Columns>
                      
                        <RowStyle />
                        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                        <FooterStyle CssClass="boxbg" />
                    </asp:GridView>
                
            </td>
        </tr>
        <tr>
            <td valign="top"><br />
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

