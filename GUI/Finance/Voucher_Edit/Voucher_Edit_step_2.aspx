<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Voucher_Edit_step_2.aspx.cs" Inherits="GUI_Finance_Voucher_Edit_Voucher_Edit_step_2" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<table width="70%" border="0" cellpadding="0" cellspacing="0" style="height: 50px">
    <tr>
        <td>
            <font class="blackfnt"><a href=""><b><u>Module </u></b></a>&gt; 
            <a href=""><b><u>Accounts</u></b></a>&gt;
            <a href=""><b><u>Voucher Edit Module</u></b></a></font>
        </td>
    </tr>
</table>
<br />
    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                <tr>
                    <td align="right"><img src="../../images/loading.gif" alt="" /></td>
                    <td><font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font></td>
                </tr>
            </table>
            <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px; background-color: #FFFFFF;
                width: 100%; height: 100%; filter: Alpha(Opacity=50); opacity: .50; -moz-opacity: .50;"
                runat="server">
                <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                    left: 50%;" ID="Panel2" runat="server">
                </asp:Panel>
            </asp:Panel>
        </ProgressTemplate>
    </asp:UpdateProgress>
<br />
<asp:UpdatePanel ID="Up1" runat="server">
    <ContentTemplate>
        <div align="left" style="width: 10in;">
            <table border="0" class="boxbg" cellpadding="1" cellspacing="0" width="100%">
                <tr class="bgbluegrey">
                    <td align="center" colspan="3">
                        <font class="bluefnt"><b>List Of Vouchers</b> </font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td>
                        <table id="Table1" runat="server" border="0" cellpadding="0" cellspacing="0" class="boxbg" align="left" width="100%">
                            <tr id="Tr1" runat="server" bgcolor="white">
                                <td align="center">
                                    <b><font color="red"><asp:Label ID="lblmsg" runat="server"></asp:Label></font></b>
                                </td>
                            </tr>
                            <tr id="Tr3" runat="server" bgcolor="white">
                                <td align="left">
                                    <div align="left">
                                        <asp:GridView CssClass="boxbg" runat="server" CellSpacing="1" BorderWidth="0" ID="grvcontrols"
                                            Width="100%" 
                                            FooterStyle-CssClass="boxbg" AutoGenerateColumns="false"
                                            EmptyDataText="No Records Found..."
                                            OnRowDataBound="grvcontrols_RowDataBound" OnRowEditing="grvcontrols_RowEditing1">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Sr.No.">
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" Width="3%"/>
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblsrno" Text="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                                                        <asp:HiddenField ID="hidcode" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"voucherno") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Voucher No">
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="left" Width="7%"/>
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblvoucherno" Text='<%# DataBinder.Eval(Container.DataItem,"voucherno") %>'
                                                            runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Voucher Date">
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="center" Width="5%"/>
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblvoucherdate" Text='<%# DataBinder.Eval(Container.DataItem,"voucherdate") %>'
                                                            runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Narration">
                                                    <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" CssClass="blackfnt" />
                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" Width="55%"/>
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblNarration"  Text='<%# DataBinder.Eval(Container.DataItem,"Narration") %>'
                                                            runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Type">
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" Width="20%"/>
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTranstype"  Text='<%# DataBinder.Eval(Container.DataItem,"Transtype") %>'
                                                            runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:CommandField HeaderText="Edit" ShowEditButton="True" >
                                                    <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" CssClass="blackfnt" />
                                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                                </asp:CommandField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </td>
                             </tr>
                        </table>
                    </td>
                 </tr>
             </table>         
        </div>
    </ContentTemplate>
</asp:UpdatePanel>            
</asp:Content>

