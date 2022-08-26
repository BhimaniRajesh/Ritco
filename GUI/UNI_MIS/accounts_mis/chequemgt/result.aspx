<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="result.aspx.cs" Inherits="GUI_UNI_MIS_accounts_mis_chequemgt_result" %>

<asp:Content ContentPlaceHolderID="MyCPH1" ID="BankAcctStatement" runat="server">
<script language="javascript" type="text/javascript">
    function poptastic(url)
    {
        newwindow=window.open(url,'name','height=400,width=800');
	    if (window.focus) {newwindow.focus()}

    }
</script>
<table width="75%" border="0">
        <tr>
            <td width="10%">
                
            </td>
            <td width="90%">
                <div align="center">
                    <br />
                    <br />
                    <table border="0"  cellpadding="4" cellspacing="1" class="boxbg" width="300">
                        <tr bgcolor="white">
                        <% 
                            string strSalesAccountText = Request.QueryString["strSalesAccountText"];
                            string dateFrom = Request.QueryString["dateFrom"];
                            string dateTo = Request.QueryString["dateTo"];
                            string TotalDateRange = dateFrom + " - " + dateTo;
                            %>
                            <td align="left" style="width: 109px"><font class="blackfnt">Date</font></td>
                            <td align="left"><font class="blackfnt"><%= TotalDateRange%></font></td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="left" style="width: 109px"><font class="blackfnt">Account</font></td>
                            <td align="left"><font class="blackfnt"><%= strSalesAccountText %></font></td>
                        </tr>
                    </table>
                    
                    <br />
                    
                            <asp:GridView ID="GrdLoadUnload" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" CssClass="blackfnt" Width="726px">
                                <Columns>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <asp:Label ID="lblChqNo" CssClass="blackfnt"  text="Cheque Number" runat="server"></asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <%--<asp:Label ID="lblSku_Code" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"chqno") %>'></asp:Label>--%>

                                            <a href="javascript:poptastic('popupc.aspx?no=<%# DataBinder.Eval( Container.DataItem,"chqno") %>&chqdt=<%# DataBinder.Eval( Container.DataItem,"chqdate") %>');"><%# DataBinder.Eval( Container.DataItem,"chqno") %></a> 
                                        </ItemTemplate>
                                        <ItemStyle Wrap="False" />
                                        <HeaderStyle Wrap="False" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <asp:Label ID="lblChqDate" CssClass="blackfnt"  text="Cheque date" runat="server"></asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblDescription" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"chqdate") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Wrap="True" />
                                        <HeaderStyle Wrap="False" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <asp:Label ID="lblParty" CssClass="blackfnt"  text="Party" runat="server"></asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblBatchno" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"Party") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Wrap="True" HorizontalAlign="Left" />
                                        <HeaderStyle Wrap="False" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <asp:Label ID="lblNarration" CssClass="blackfnt"  text="Narration" runat="server"></asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblReceiptNo" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"narration") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Wrap="True" HorizontalAlign="Left" />
                                        <HeaderStyle Wrap="False" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <asp:Label ID="lblDebit" CssClass="blackfnt"  text="Debit" runat="server"></asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblGRN_Date" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"debit") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Wrap="True" Width="100px" />
                                        <HeaderStyle Wrap="False" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <asp:Label ID="lblCredit" CssClass="blackfnt"  text="Credit" runat="server"></asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblGRN_Date" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"credit") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Wrap="True" Width="100px" />
                                        <HeaderStyle Wrap="False" />
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                <RowStyle ForeColor="#000066" Wrap="False" />
                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                            </asp:GridView>
                </div>
                <br /><br />
                
            </td>
        </tr>
    </table>
    <br /><br />
</asp:Content>
