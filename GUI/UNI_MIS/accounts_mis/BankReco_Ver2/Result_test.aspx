<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    Trace="false" CodeFile="Result_test.aspx.cs" Inherits="GUI_Finance_Fix_Asset_aaaaa" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <br />
    <div align="left" style="width: 9.5in;">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td valign="top">
                    <br />
                    <asp:Button ID="Button2" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                </td>
            </tr>
            <tr>
                <td>
                    <table id="HeaderDet" runat="server" cellspacing="1" width="600" class="boxbg" align="center">
                        <tr style="background-color: white">
                            <td>
                                <font class="blackfnt"><b>RO</b></font>
                            </td>
                            <td>
                                <asp:Label ID="Lb_RO" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td>
                                <font class="blackfnt"><b>LO</b></font>
                            </td>
                            <td>
                                <asp:Label ID="Lb_LO" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td>
                                <font class="blackfnt"><b>Account</b></font>
                            </td>
                            <td>
                                <asp:Label ID="LB_Bankcode" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td>
                                <font class="blackfnt"><b>Duration</b></font>
                            </td>
                            <td>
                                <asp:Label ID="Lb_dtaeraneg" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <table cellspacing="1" width="800" class="boxbg" align="center" id="TBL_CRI" runat="server">
                        <tr style="background-color: white">
                            <td>
                                <font class="bluefnt"><strong>Balance As per Bank Book</strong>
                            </td>
                            <td align="right">
                                <asp:Label ID="LB_Balance_Amount" runat="server" Text="" CssClass="bluefnt" Style="text-align: Right"
                                    Font-Bold="true"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td colspan="2">
                                <font class="bluefnt"><strong>
                                    <asp:Label ID="lbl_Chq_Issued" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label></strong></font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td colspan="2">
                                <asp:GridView ID="GV_CHQ_Presented" runat="server" CssClass="dgRowStyle" EmptyDataText="No Records Found..."
                                    HeaderStyle-CssClass="dgHeaderStyle" PagerSettings-Mode="Numeric" Width="800px"
                                    ShowFooter="True" OnRowDataBound="GV_D_OnRowDataBound" AutoGenerateColumns="False">
                                    <Columns>
                                        <asp:TemplateField HeaderText="SR.NO.">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">                                        </asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Cheque No">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblChqno" Text='<%# DataBinder.Eval(Container.DataItem, "chqno") %>'
                                                    runat="server">                                        
                                                </asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Cheque Date">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblChqdate" Text='<%# DataBinder.Eval(Container.DataItem, "chqdt1") %>'
                                                    runat="server">                                        
                                                </asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Received From Bank">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblbanknm" Text='<%# DataBinder.Eval(Container.DataItem, "banknm") %>'
                                                    runat="server">                                        
                                                </asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Party">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblParty" Text='<%# DataBinder.Eval(Container.DataItem, "party") %>'
                                                    runat="server">                                        
                                                </asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Bank Details">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblbankdtl" Text='<%# DataBinder.Eval(Container.DataItem, "accountDetails") %>'
                                                    runat="server">                                        
                                                </asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Deposite Date">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblTransdate" Text='<%# DataBinder.Eval(Container.DataItem, "transdate") %>'
                                                    runat="server">                                        
                                                </asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle HorizontalAlign="Right" Wrap="false" />
                                            <FooterTemplate>
                                                <asp:Label ID="lblCredit1" Text='Total Amont' Font-Bold="true" runat="server" CssClass="bluefnt"> </asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Amount">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblCredit" Text='<%# DataBinder.Eval(Container.DataItem, "chqamt") %>'
                                                    runat="server">                                        
                                                </asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle HorizontalAlign="Right" Wrap="false" />
                                            <FooterTemplate>
                                                <asp:Label ID="lblTOtalCredit" Text='' runat="server" Font-Bold="true" CssClass="bluefnt"> </asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Clearance Date">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblCLear_Dt" Text='<%# DataBinder.Eval(Container.DataItem, "RecoDate") %>'
                                                    runat="server">                                        
                                                </asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                                    <HeaderStyle CssClass="dgHeaderStyle" />
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td colspan="2" align="right">
                                <font class="blackfnt"><strong>
                                    <asp:Label ID="CR_AMT" runat="server" Text="" CssClass="bluefnt" Style="text-align: Right"
                                        Font-Bold="true"></asp:Label></strong></font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td colspan="2">
                                <font class="bluefnt"><strong>
                                    <asp:Label ID="lbl_Chq_Recived" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label></strong></font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td colspan="2">
                                <asp:GridView ID="GV_CHQ_Cleared" runat="server" CssClass="dgRowStyle" EmptyDataText="No Records Found..."
                                    HeaderStyle-CssClass="dgHeaderStyle" PagerSettings-Mode="Numeric" Width="800px"
                                    ShowFooter="True" OnRowDataBound="GV_D_OnRowDataBound1" AutoGenerateColumns="False">
                                    <Columns>
                                        <asp:TemplateField HeaderText="SR.NO.">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">                                        </asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Cheque No">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblChqno" Text='<%# DataBinder.Eval(Container.DataItem, "chqno") %>'
                                                    runat="server">                                        
                                                </asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Cheque Date">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblChqdate" Text='<%# DataBinder.Eval(Container.DataItem, "chqdt1") %>'
                                                    runat="server">                                        
                                                </asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Received From Bank">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblbanknm" Text='<%# DataBinder.Eval(Container.DataItem, "banknm") %>'
                                                    runat="server">                                        
                                                </asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Party">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblParty" Text='<%# DataBinder.Eval(Container.DataItem, "party") %>'
                                                    runat="server">                                        
                                                </asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Bank Details">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblbankdtl" Text='<%# DataBinder.Eval(Container.DataItem, "accountDetails") %>'
                                                    runat="server">                                        
                                                </asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Deposite Date">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblTransdate" Text='<%# DataBinder.Eval(Container.DataItem, "transdate") %>'
                                                    runat="server">                                        
                                                </asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle HorizontalAlign="Right" Wrap="false" />
                                            <FooterTemplate>
                                                <asp:Label ID="lblCredit1" Text='Total Amont' Font-Bold="true" runat="server" CssClass="bluefnt"> </asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Amount">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblCredit" Text='<%# DataBinder.Eval(Container.DataItem, "chqamt") %>'
                                                    runat="server">                                        
                                                </asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle HorizontalAlign="Right" Wrap="false" />
                                            <FooterTemplate>
                                                <asp:Label ID="lblTOtalCredit" Text='' runat="server" Font-Bold="true" CssClass="bluefnt"> </asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Clearance Date">
                                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" Wrap="false" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblCLear_Dt" Text='<%# DataBinder.Eval(Container.DataItem, "RecoDate") %>'
                                                    runat="server">                                        
                                                </asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                                    <HeaderStyle CssClass="dgHeaderStyle" />
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="Left">
                                <font class="bluefnt"><strong>BALANCE AS PER BANK STATEMENT</strong>
                            </td>
                            <td align="right">
                                <font class="bluefnt"><strong>
                                    <asp:Label Style="text-align: Right" ID="DR_AMT" runat="server" Text="" CssClass="bluefnt"
                                        Font-Bold="true"></asp:Label></strong></font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="Left">
                                <font class="bluefnt"><strong>ACCOUNTANT</strong>
                            </td>
                            <td align="Left">
                                <font class="bluefnt"><strong>DGM (ACCOUNTS) </strong>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
