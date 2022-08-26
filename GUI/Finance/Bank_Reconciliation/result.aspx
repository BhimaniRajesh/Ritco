<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="result.aspx.cs" Inherits="GUI_Finance_Bank_Reconciliation_result" %>

<%@ Reference Control="~/GUI/Finance/Bank_Reconciliation/WebUserControl.ascx" %>
<%@Register TagPrefix="SControlsTo" TagName="DateSelectorTo" src="~/GUI/Finance/Bank_Reconciliation/WebUserControl.ascx" %>
<asp:Content ContentPlaceHolderID="MyCPH1" ID="resul" runat="server">
<script type="text/javascript" language="javascript" src="../../../cal/popcalendar.js"></script>
    <div align="left">
        <table width="1000" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr align="left">
                <td align="left" style="height: 30px">
                </td>
                <tr>
                    <td class="horzblue">
                        <img src="../../images/clear.gif" width="2" height="1"></td>
                </tr>
                <tr>
                    <td>
                        <img src="../../images/clear.gif" width="15" height="10"></td>
                </tr>
                <tr>
                    <td align="right">
                        <a href="javascript:window.history.go(-1)" title="back">
                            <img src="../../images/back.gif" border="0"></a></td>
                </tr>
                <tr>
                    <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="39%" valign="top">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td height="300" valign="top" align="center">
                                                <!--START-->
                                                <br>
                                                <table border="0" width="500" bgcolor="#000000" cellspacing="1" cellpadding="2" class="boxbg">
                                                    <tr>
                                                        <td width="25%" bgcolor="#ffffff" align="left">
                                                            <font class="blackfnt">Prepared At</font></td>
                                                        <td width="25%" bgcolor="#ffffff" align="left">
                                                            <font class="blackfnt">
                                                                <asp:Label ID="lblBran" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                                                    </tr>
                                                    <tr>
                                                        <td bgcolor="#ffffff" width="25%" align="center">
                                                            <div align="left">
                                                                <font class="blackfnt">Date Range </font>
                                                            </div>
                                                        </td>
                                                        <td bgcolor="#ffffff" width="75%" align="center">
                                                            <div align="left">
                                                                <font class="blackfnt">
                                                                    <asp:Label ID="lblDate_Range" runat="server" CssClass="blackfnt"></asp:Label></font></div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td bgcolor="#ffffff" width="25%" align="center">
                                                            <div align="left">
                                                                <font class="blackfnt">Type</font></div>
                                                        </td>
                                                        <td bgcolor="#ffffff" width="75%" align="center">
                                                            <div align="left">
                                                                <font class="blackfnt">
                                                                    <asp:Label ID="lblAccount" runat="server" CssClass="blackfnt"></asp:Label></font></div>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <br />
                                                    <asp:DataGrid ID="MyGrid" runat="server" AutoGenerateColumns="False" CssClass="blackfnt" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="2" CellSpacing="2" DataKeyField="srno"  OnItemDataBound="MyGrid_ItemDataBound">
                                                    <Columns>
                                                    <asp:TemplateColumn HeaderText="Select">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkSelect" runat="server" />
                                                        </ItemTemplate>
                                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                            Font-Underline="False" Wrap="False" />
                                                    </asp:TemplateColumn>
                                                        <asp:BoundColumn HeaderText="Sl.No" DataField="srno">
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn HeaderText="Cheque No." DataField="chqno">
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn HeaderText="Dated" DataField="chqdate">
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn HeaderText="Voucher Type" DataField="transtype">
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn HeaderText="Voucher No." DataField="voucherno">
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn HeaderText="Amount" DataField="Amt">
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        <asp:TemplateColumn HeaderText="Clear Date">
                                                            <ItemTemplate>
                                                                <SControlsTo:DateSelectorTo ID="txtDateTo" runat="server" />
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        <asp:BoundColumn HeaderText="Narration" DataField="Narration">
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        <asp:TemplateColumn HeaderText="Comment">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtNarration" runat="server" Width="100" MaxLength="255" BorderStyle="Groove"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                    </Columns>
                                                    <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:DataGrid>
                                                <%--<asp:DataGrid ID="myGrid" runat="server" AutoGenerateColumns="False"
                                                    Style="text-align: center" CssClass="blackfnt" BackColor="White" BorderColor="#CCCCCC"
                                                    BorderStyle="None" BorderWidth="1px" CellPadding="3" AllowSorting="True" Width="841px" DataKeyField="srno">
                                                    <AlternatingItemStyle CssClass="blackfnt" />
                                                    <Columns>
                                                        <asp:TemplateColumn HeaderText="Select">
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chkSelect" runat="server" />
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        <asp:BoundColumn DataField="srno" HeaderText="Sl.No">
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="chqno" HeaderText="Cheque No.">
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="chqdate" HeaderText="Dated">
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="transtype" HeaderText="Voucher Type">
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" HorizontalAlign="Left" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="voucherno" HeaderText="Voucher No.">
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" HorizontalAlign="Left" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        <asp:BoundColumn DataField="Amt" HeaderText="Amount">
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" HorizontalAlign="Left" Wrap="False" />
                                                        </asp:BoundColumn>
                                                        <asp:TemplateColumn HeaderText="Clear Date">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtReason" runat="server" BorderStyle="Groove"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        <asp:BoundColumn DataField="Narration" HeaderText="Narration">
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" HorizontalAlign="Left" Wrap="False" />
                                                        </asp:BoundColumn>
                                                    </Columns>
                                                    <PagerStyle Mode="NumericPages" BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                    <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                    <ItemStyle ForeColor="#000066" />
                                                    <HeaderStyle BackColor="#006699" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                                        Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                                               </asp:DataGrid>--%>
                                                <br />
                                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="updateData" />
                                                
                                                <br />
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                </td>
                            </tr>
                            <div>
                            </div>
                    </td>
                </tr>
        </table>
    </div>
</asp:Content>
