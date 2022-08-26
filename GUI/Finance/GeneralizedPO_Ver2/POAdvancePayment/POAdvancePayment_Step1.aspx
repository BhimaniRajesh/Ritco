<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="POAdvancePayment_Step1.aspx.cs" Inherits="GUI_Finance_GeneralizedPO_GRNGeneration_SinglePO_GRN_DataList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" src="../../../Images/commonJs.js" type="text/javascript"></script>

    <script language="javascript" src="../../Billing_Ver1/Billing.js" type="text/javascript"></script>

    <div>
        <table width="800" border="0" cellpadding="0" cellspacing="0">
            <tr class="bgbluegrey" style="height: 25px">
                <td align="center" colspan="3">
                    <strong><span style="font-size: 8pt; font-family: Verdana">PO List For Advance Payment</span></strong>
                </td>
            </tr>
            <tr bgcolor="white">
                <td style="height: 15px">
                </td>
            </tr>
            <tr bgcolor="white" id="Tr_Stn" runat="server">
                <td>
                    <asp:GridView ID="GrdPO" runat="server" align="center" BorderWidth="1" CellPadding="2"
                        HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                        BackColor="white" AllowPaging="false" Width="800" AllowSorting="False" AutoGenerateColumns="false"
                        ShowFooter="false" EmptyDataText="No Records Found...">
                        <PagerStyle VerticalAlign="Bottom" />
                        <Columns>
                            <asp:BoundField DataField="pocode" ItemStyle-Wrap="true" HeaderText="PO Code" HeaderStyle-Font-Bold="true">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle Width="100" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Manual_PO_No" HeaderStyle-Font-Bold="true" HeaderText="Manual PO Code"
                                ItemStyle-BackColor="white" ItemStyle-Wrap="false">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" Width="150" />
                            </asp:BoundField>
                            <asp:BoundField DataField="podate" ItemStyle-Wrap="true" HeaderText="PO Date" HeaderStyle-Font-Bold="true">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle Width="100" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                            </asp:BoundField>
                            <asp:BoundField DataField="POTYPE" HeaderStyle-Font-Bold="true" HeaderText="PO Type"
                                ItemStyle-BackColor="white" ItemStyle-Wrap="false">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" Width="150" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Vendorname" ItemStyle-Wrap="False" HeaderText="Vendor"
                                HeaderStyle-Font-Bold="true">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle Width="400" Wrap="False" HorizontalAlign="Left" CssClass="blackfnt" />
                            </asp:BoundField>
                            <asp:BoundField DataField="GrandTotal" HeaderStyle-Font-Bold="true" HeaderText="Total Amount"
                                ItemStyle-BackColor="white" ItemStyle-Wrap="false">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" Width="150" />
                            </asp:BoundField>
                            <asp:BoundField DataField="PO_advamt" HeaderStyle-Font-Bold="true" HeaderText="Advance Amount"
                                ItemStyle-BackColor="white" ItemStyle-Wrap="false">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" Width="150" />
                            </asp:BoundField>
                            <asp:BoundField DataField="PO_AMOUNT" HeaderStyle-Font-Bold="true" HeaderText="Balance Amount"
                                ItemStyle-BackColor="white" ItemStyle-Wrap="false">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" Width="150" />
                            </asp:BoundField>
                            <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderText="Assign" HeaderStyle-Font-Bold="true">
                                <HeaderStyle HorizontalAlign="left" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <label class="blackfnt"><asp:HyperLink Text='Assign' ID="Hyperlink3" Font-Underline="True" runat="server"
                                            NavigateUrl='<%#"POAdvancePayment_Step2.aspx?POList="+DataBinder.Eval(Container.DataItem, "pocode")%>'>
                                        </asp:HyperLink></label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
