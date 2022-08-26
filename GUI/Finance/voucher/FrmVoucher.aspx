<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="FrmVoucher.aspx.cs" Inherits="GUI_Finance_voucher_FrmVoucher" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/jscript">
    function OpenPopupWindow(strbillno)
    {
        var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
        var strPopupURL = "VoucherView.aspx?strGenerateBillNo=" + strbillno + ",0"
        winNew = window.open(strPopupURL, "_blank", strWinFeature)
    }
    function OpenPopupWindowPrint(strbillno)
    {
        var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
        var strPopupURL = "VoucherView.aspx?strGenerateBillNo=" + strbillno + ",1"
        winNew = window.open(strPopupURL, "_blank", strWinFeature)
    }
    </script>

    <br />
    <table style="width: 10in;">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Reports</b></font></a> <b>&gt; </b><a><font class="blklnkund"><b>Operations</b></font></a>
                <%--href="../rpt_Operation.aspx"--%>
                <b>&gt; </b><font class="bluefnt"><b>Bill Details</b></font>
            </td>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img src="../../../../images/back.gif" border="0" alt="" /></a>
            </td>
        </tr>
    </table>
    <br />
    <div style="width: 10.5in;" align="center">
        <table id="tblall" runat="server" border="0" cellpadding="3" colspan="2" bgcolor="#ffffff"
            cellspacing="1" class="boxbg">
            <tr bgcolor="#ffffff" class="bgbluegrey">
                <td align="center" style="height: 25px" colspan="3">
                    <font class="blackfnt"><b>You Selected</b></font></td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="left" style="height: 25px; width: 29%;">
                    <font class="blackfnt"><b>Voucher Date Range</b></font></td>
                <td align="left" style="height: 25px">
                    <font class="blackfnt">
                        <asp:Label ID="TxtDateRange" runat="server"></asp:Label>
                    </font>
                </td>
            </tr>
             
            <tr bgcolor="#ffffff">
                <td align="left" style="width: 29%">
                    <font class="blackfnt"><b>Voucher No.</b></font></td>
                <td align="left">
                    <font class="blackfnt">
                        <asp:Label ID="lblVoucherNo" runat="server"></asp:Label>
                    </font>
                </td>
            </tr>
           
        </table>
        <br />
        <asp:GridView ID="GridVoucher" Style="width: 10in" Visible="false"
            OnPageIndexChanging="pgChange" PagerStyle-Mode="NumericPages" CssClass="boxbg"
            PageSize="10" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey" BackColor="white"
            runat="server" SelectedIndex="1" Width="686px" EmptyDataText="No Voucher Found For Given Details !!" EmptyDataRowStyle-CssClass="blackfnt" EmptyDataRowStyle-Font-Bold="true">
            <Columns>
                <asp:TemplateField HeaderText="Voucher Number">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lblVoucherNo" Visible="false" CssClass="blackfnt" Font-Underline="true"
                            Text='<%# DataBinder.Eval( Container.DataItem,"VoucherNo") %>' runat="server"></asp:LinkButton>
                        <a href="JavaScript:OpenPopupWindowPrint('<%#DataBinder.Eval(Container.DataItem, "VoucherNo") %>',0)">
                            <font cssclass="Blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "VoucherNo")%></a>
                    </ItemTemplate>
                </asp:TemplateField>
               
                <asp:TemplateField HeaderText="Voucher Branch">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblbillingbranch" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"Branch") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Document Type">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblDocumentType" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"DocumentType") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Vendor">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblVendor" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"Vendor") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
               
               <asp:TemplateField HeaderText="Print" HeaderStyle-Width="15">
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopupWindowPrint('<%#DataBinder.Eval(Container.DataItem, "VoucherNo") %>',1)">
                            <font cssclass="Blackfnt">Print</a>
                    </ItemTemplate>
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateField>
            </Columns>
            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
            <HeaderStyle CssClass="bgbluegrey" />
            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle CssClass="boxbg" />
        </asp:GridView>
        <br />
        <asp:GridView ID="GridView1" Style="width: 10in" Visible="false"
            OnPageIndexChanging="pgChange" PagerStyle-Mode="NumericPages" CssClass="boxbg"
            PageSize="10" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey" BackColor="white"
            runat="server" SelectedIndex="1" Width="686px" EmptyDataText="No Voucher Found For Given Details !!" EmptyDataRowStyle-CssClass="blackfnt" EmptyDataRowStyle-Font-Bold="true">
            <Columns>
                <asp:TemplateField HeaderText="Voucher Number">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lblVoucherNo" Visible="false" CssClass="blackfnt" Font-Underline="true"
                            Text='<%# DataBinder.Eval( Container.DataItem,"VoucherNo") %>' runat="server"></asp:LinkButton>
                        <a href="JavaScript:OpenPopupWindowPrint('<%#DataBinder.Eval(Container.DataItem, "VoucherNo") %>',0)">
                            <font cssclass="Blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "VoucherNo")%></a>
                    </ItemTemplate>
                </asp:TemplateField>
                
                <asp:TemplateField HeaderText="Voucher Branch">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblbillingbranch" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"Branch") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
              
                <asp:TemplateField HeaderText="Vendor">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblVendor" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"Vendor") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                
               <asp:TemplateField HeaderText="Print" HeaderStyle-Width="15">
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopupWindowPrint('<%#DataBinder.Eval(Container.DataItem, "VoucherNo") %>',1)">
                            <font cssclass="Blackfnt">Print</a>
                    </ItemTemplate>
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateField>
            </Columns>
            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
            <HeaderStyle CssClass="bgbluegrey" />
            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle CssClass="boxbg" />
        </asp:GridView>
        </div>
        </asp:Content>
