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
                            &gt; </strong><strong>Operation Document Register</strong> </font>
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
                <td  valign="top">
                    
                   <%-- <asp:Table ID="TBL_OPNDOC_Register" border="0" HorizontalAlign="left" runat="server"
                        CellPadding="3" CellSpacing="1" Style="width: 8.5in;" CssClass="boxbg">
                    </asp:Table>--%>
                    <table border="0" cellpadding="0" width="200" bgcolor="white" cellspacing="0" align="left">
                        <tr bgcolor="white">
                            <td colspan="2" align="center">
                                <asp:Button ID="Button1" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click"  />
                            </td>
                        </tr>
                    </table>
                     <table border="0" cellpadding="0" width="200" bgcolor="white" cellspacing="0" align="left">
                        <tr bgcolor="white">
                            <td colspan="2" align="center">
                                <asp:Button ID="Button2" Text="DownLoad CSV" runat="server" Width="170" OnClick="btn_csv1_Click"  />
                            </td>
                        </tr>
                    </table>
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
                         
                        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                        <FooterStyle CssClass="boxbg" Wrap="false"  Width="200"  />
                    </asp:GridView>
                    
                        
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    
                    <table border="0" cellpadding="0" width="200" bgcolor="white" cellspacing="0" align="left">
                        <tr bgcolor="white">
                            <td colspan="2" align="center">
                                <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click"  />
                            </td>
                        </tr>
                    </table>
                     <table border="0" cellpadding="0" width="200" bgcolor="white" cellspacing="0" align="left">
                        <tr bgcolor="white">
                            <td colspan="2" align="center">
                                <asp:Button ID="btn_csv1" Text="DownLoad CSV" runat="server" Width="170" OnClick="btn_csv1_Click"  />
                            </td>
                        </tr>
                    </table></td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
