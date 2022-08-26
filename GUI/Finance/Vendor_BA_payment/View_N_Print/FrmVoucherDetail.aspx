<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="FrmVoucherDetail.aspx.cs" Inherits="GUI_Finance_voucher_FrmVoucherDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/jscript">
    function OpenPopupWindow(strbillno)
    {
        var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=120"
        var strPopupURL = "VoucherView.aspx?strGenerateBillNo=" + strbillno + ",0"
        winNew = window.open(strPopupURL, "_blank", strWinFeature)
    }
    function OpenPopupWindowPrint(strbillno)
    {
        //alert(strbillno);
        var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=120"
        //var strPopupURL = "VoucherView.aspx?strGenerateBillNo=" + strbillno + ",1"
        var strPopupURL = "../PaymentAgainstBillEntry/Fixed_Variable_Expense/VendorBillVeiw1.aspx?strGenerateBillNo=" + strbillno + ",1"
        
        winNew = window.open(strPopupURL, "_blank", strWinFeature)
    }
    </script>

    <asp:UpdateProgress ID="uppMain" runat="server">
<ProgressTemplate>
    <iframe frameborder="0" src="about:blank"
        style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
        <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);"><img src="../../../images/loading.gif" /><font face=verdana color=blue size=4>&nbsp;<b>Please Wait...</b></font></div>
</ProgressTemplate>
</asp:UpdateProgress>



<p align="center">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" width="45%">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Vendor Payment >> View & Print >> Vendor Payment Voucher</asp:Label>
 
            </td>
            
             <td align=left>
            </td>      
        </tr>
    </table>
    
  
    <hr align="center" size="1" color="#8ba0e5">
      <br/> 
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
                <asp:TemplateField HeaderText="Voucher Number" ItemStyle-HorizontalAlign="Left">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Left" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lblVoucherNo" Visible="false" CssClass="blackfnt" Font-Underline="true"
                            Text='<%# DataBinder.Eval( Container.DataItem,"VoucherNo") %>' runat="server"></asp:LinkButton>
                        <a href="JavaScript:OpenPopupWindowPrint('<%#DataBinder.Eval(Container.DataItem, "VoucherNo") %>,0')">
                            <font cssclass="Blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "VoucherNo")%></a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Voucher Date" HeaderStyle-HorizontalAlign=left ItemStyle-HorizontalAlign=left>
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblVoucherDate" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"PAYDT") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Voucher Branch" ItemStyle-HorizontalAlign="Left">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Left"/>
                    <ItemTemplate>
                        <asp:Label ID="lblbillingbranch" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"Branch") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Document Type" ItemStyle-HorizontalAlign="Left">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Left"/>
                    <ItemTemplate>
                        <asp:Label ID="lblDocumentType" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"DocumentType") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Vendor" ItemStyle-HorizontalAlign="Left">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Left" />
                    <ItemTemplate>
                        <asp:Label ID="lblVendor" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"Vendor") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
               <asp:TemplateField HeaderText="Voucher Amount" HeaderStyle-HorizontalAlign=right ItemStyle-HorizontalAlign=right>
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblVoucherAmt" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"Paidamt") %>'
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
                <asp:TemplateField HeaderText="Voucher Number" ItemStyle-HorizontalAlign="Left">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Left" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lblVoucherNo" Visible="false" CssClass="blackfnt" Font-Underline="true"
                            Text='<%# DataBinder.Eval( Container.DataItem,"VoucherNo") %>' runat="server"></asp:LinkButton>
                        <a href="JavaScript:OpenPopupWindowPrint('<%#DataBinder.Eval(Container.DataItem, "VoucherNo") %>,0')">
                            <font cssclass="Blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "VoucherNo")%></a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Voucher Date" HeaderStyle-HorizontalAlign=left ItemStyle-HorizontalAlign=left>
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblVoucherDate" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"PAYDT") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Voucher Branch" ItemStyle-HorizontalAlign="Left">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Left"/>
                    <ItemTemplate>
                        <asp:Label ID="lblbillingbranch" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"Branch") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Document Type" HeaderStyle-HorizontalAlign=left ItemStyle-HorizontalAlign=left>
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblDocumentType" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"DocumentType") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Vendor" ItemStyle-HorizontalAlign="Left">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Left"/>
                    <ItemTemplate>
                        <asp:Label ID="lblVendor" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"Vendor") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Voucher Amount" HeaderStyle-HorizontalAlign=right ItemStyle-HorizontalAlign=right>
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblVoucherAmt" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"Paidamt") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
               <asp:TemplateField HeaderText="Print" HeaderStyle-Width="15" >
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopupWindowPrint('<%#DataBinder.Eval(Container.DataItem, "VoucherNo") %>,1')">
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