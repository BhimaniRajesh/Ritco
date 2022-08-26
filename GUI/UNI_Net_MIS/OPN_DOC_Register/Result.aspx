<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Result.aspx.cs" Inherits="GUI_UNI_MIS_OPN_DOC_Register_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <br />
    <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                       class="blklnkund"><strong>Reports </strong></font><font class="bluefnt"><strong>
                            &gt; </strong><strong>Sales & Expense Register</strong> </font>
                </td>
            </tr>
            <tr>
                <td>
                   <a href="javascript:window.history.go(-1)" title="back">
<img alt="Back" src="./../../images/back.gif" border="0"> </a></td>

            </tr>
            <tr>
                <td align="right">
                    <img src="./../../images/back.gif" border="0"></td>
                    
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
                    <tr id="TRS1" runat="server" bgcolor="white" class="blackfnt">
                        <td>
                            <asp:Label runat="server" ID="lblcust_vend"></asp:Label></td>
                        <td>
                            <asp:Label runat="server" ID="lblcust"></asp:Label></td>
                    </tr>
                    <tr id="TRS2" runat="server" bgcolor="white" class="blackfnt">
                        <td>
                            Mode</td>
                        <td>
                            <asp:Label runat="server" ID="lblmod"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Status</td>
                        <td>
                            <asp:Label runat="server" ID="lblBM_STAuTS_str"></asp:Label></td>
                    </tr>
                   
                    <tr id="TRS3" runat="server" bgcolor="white" class="blackfnt">
                        <td>
                            Paybasis
                        </td>
                        <td>
                            <asp:Label runat="server" ID="lblPaybasis"></asp:Label></td>
                    </tr>
                    <tr id="TRS4" runat="server" bgcolor="white" class="blackfnt">
                        <td>
                            Business Type
                        </td>
                        <td>
                            <asp:Label runat="server" ID="lblBusiness"></asp:Label></td>
                    </tr>
                      <%-- <tr id="TRS5" runat="server" bgcolor="white" class="blackfnt">
                        <td>
                          Service Type</td>
                        <td>
                            <asp:Label runat="server" ID="lblBM_TYp"></asp:Label></td>
                    </tr>
                   <%--  <tr id="TRS6" runat="server" bgcolor="white" class="blackfnt">
                        <td>
                          Route</td>
                        <td>
                            <asp:Label runat="server" ID="lblRoute"></asp:Label></td>
                    </tr>--%>
                </table>
            </td>
        </tr>
            <tr>
                <td  align="left" valign="top"><br />                    
                  
                                <asp:Button ID="Button1" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click"  />
                           
                                <asp:Button ID="Button2" Text="DownLoad CSV" runat="server" Width="170" OnClick="btn_csv1_Click"  />
                            
                    </td>
            </tr>
                <tr>
                <td>
                        <br />    <asp:GridView  align="left" ID="dgDocket" runat="server" BorderWidth="0"
                            AutoGenerateColumns="true"
                        CellPadding="2" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
                        AllowPaging="true" PageSize="20" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                        FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" 
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
                            
                            
                                
                            
                            
                            </Columns>
                         <RowStyle HorizontalAlign="center" BackColor="white" CssClass="blackfnt" Wrap="false"  Width="200" />
                         
                        <PagerStyle HorizontalAlign="left" Font-Bold="true" CssClass="bgbluegrey" />
                        <PagerSettings FirstPageText="[First]"    LastPageText="[Last]" Mode="NumericFirstLast" />
                        <FooterStyle CssClass="boxbg" Wrap="false"  Width="200"  />
                    </asp:GridView>
                    
                        
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    
                    
                                <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click"  />
                            
                                <asp:Button ID="btn_csv1" Text="DownLoad CSV" runat="server" Width="170" OnClick="btn_csv1_Click"  />
                           </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
