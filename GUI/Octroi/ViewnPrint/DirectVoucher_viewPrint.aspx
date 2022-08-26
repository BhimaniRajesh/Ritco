<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"   CodeFile="DirectVoucher_viewPrint.aspx.cs" Inherits="GUI_Octroi_Octroi_Bill_DirectPayVoucher_viewPrint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">


                        <%--total at the end of summary is not done--%>
                        
                        
                        

                                     <%--SUMMARY HEADER LINE--%>
<div align="center">
<br /><br />
    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="<%=boxbg %>" width="90%">
        <tr>
            <td  class="<%=bgbluegrey %>"> <font class="blackfnt" >Octroi Payment Voucher Summery</font></td>
        </tr>
    </table>



                                        <%--SUMMARY TABLE--%>              
                                        
        <br />                                   
     <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="<%=boxbg %>" width="90%">
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Payment Voucher No</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblvoucherno" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left">Voucher date </td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblvoucherdate" runat="server"></asp:Label>
            </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Octroi Agent </td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lbloctagent" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left">Paid To  </td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblpaidto" runat="server"></asp:Label>
            </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Octroi paid Rs.</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lbloctpaidrs" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left">Other Charges</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblothchrg" runat="server"></asp:Label>
            </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Net Payable</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblnetpay" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left"></td>
            <td class="blackfnt">&nbsp;</td>
        </tr>
     </table>


                                     <%--GRIDVIEW HEADER LINE--%>
<br /><br />
    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="<%=boxbg %>" width="90%">
        <tr  class="<%=bgbluegrey %>">
            <td class="blackfnt">Octroi Payment Details</td>
        </tr>
    </table>
    
    
    
                                <%--GRID VIEW FOR PAYMENT VOUCHER--%>
   <br />
    <asp:GridView align="center" ID="gvdirectoct" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="<%=bgbluegrey %>"
                AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left"
                CssClass="<%=boxbg %>" BackColor="white" FooterStyle-CssClass="<%=bgbluegrey %>"
                PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange"
                OnSelectedIndexChanged="gvdirectoct_SelectedIndexChanged"  Width="90%">
    <Columns>
    
        <asp:TemplateField HeaderText="Sr.No." >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="<%=bgbluegrey %>" HorizontalAlign="Right" />
                <ItemTemplate>
                        <asp:Label CssClass="blackfnt" Font-Bold="true" ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                </ItemTemplate>
        </asp:TemplateField>
        
        <asp:BoundField DataField="dockno" HeaderText="Docket Number" >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
        </asp:BoundField>

        <asp:BoundField DataField="declval" HeaderText="Declared value" >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
        </asp:BoundField>


        <asp:BoundField DataField="octamt" HeaderText="Octroi Amount" >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Right"  />
        </asp:BoundField>

        <asp:BoundField DataField="recptno" HeaderText="Octroi receipt no." >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Right"  />
        </asp:BoundField>

        <asp:BoundField DataField="recptdt" HeaderText="Receipt date" >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
        </asp:BoundField>

</Columns>
    
    <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
            <HeaderStyle CssClass="bgbluegrey" />
    <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle CssClass="boxbg" />
    
</asp:GridView>
<br /><br />


                                  <%--SUMMARY HEADER LINE--%>

    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="<%=boxbg %>" width="90%">
        <tr  class="<%=bgbluegrey %>">
            <td class="blackfnt">Payment Summary</td>
        </tr>
    </table>
    
        <br />
                                          
     <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="<%=boxbg %>" width="90%">
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">Mode Of Transaction </td>
            <td class="blackfnt" align="left" style="width:25%">
                <asp:Label ID="lbltransmode" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:25%">Issued from Account </td>
            <td class="blackfnt" align="left" style="width:25%">
                <asp:Label ID="lblissuedacc" runat="server"></asp:Label>
            </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Cheque No </td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblchequeno" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left">Cheque Date</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblchequedate" runat="server"></asp:Label>
            </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Payment Amount</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblpaymentamt" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left"></td>
            <td class="blackfnt" align="left"></td>
        </tr>
     </table>


</div>

</asp:Content>
