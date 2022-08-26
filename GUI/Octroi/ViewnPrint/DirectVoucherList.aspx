<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="DirectVoucherList.aspx.cs" Inherits="GUI_Octroi_ViewnPrint_DirectVoucherList" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script  language="javascript" type="text/javascript">
 function popupmenu2(choice)
 { 
  var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
  confirmWin=window.open(choice,"",winOpts);
 }
 </script>


<div align="center">
                                     <%--LIST HEADER LINE--%>
    
    <br /><br />




<table width="100%">
        <tr>
            <td align="center"><font class="blackfnt"> You Selected</font></td>
        </tr>
</table>
<br />
                      <%--      SELECTION CRITERIA--%>

        <table align="center" bgcolor="#808080" class="boxbg" cellpadding="3" cellspacing="1" width="70%">
            <tr>
                <td align="right" style="width:50%" bgcolor="#ffffff"><font class="blackfnt">Docket No. : </font> </td>
                <td bgcolor="#ffffff" style="width:50%" align="left">
                    <font class="blackfnt"><asp:Label runat="server" ID="lbldocno"></asp:Label></font>
                </td>
            </tr>
            <tr>
                <td align="right" style="width:50%" bgcolor="#ffffff"><font class="blackfnt">Bill No. : </font> </td>
                <td bgcolor="#ffffff" style="width:50%" align="left">
                    <font class="blackfnt"><asp:Label runat="server" ID="lblbillno"></asp:Label></font>
                </td>
            </tr>
            <tr>
                <td align="right" style="width:50%"  bgcolor="#ffffff"><font class="blackfnt">Reciept No. :</font> </td>
                <td bgcolor="#ffffff" style="width:50%" align="left">
                    <font class="blackfnt"><asp:Label runat="server" ID="lblrecno"></asp:Label></font>
                </td>
            </tr>
            <tr>
                <td align="right" style="width:50%"  bgcolor="#ffffff"><font class="blackfnt">Date. :</font> </td>
                <td bgcolor="#ffffff" style="width:50%" align="left">
                    <font class="blackfnt"><asp:Label runat="server" ID="lbldates"></asp:Label></font>
                </td>
            </tr>
        </table>
                      
<p>&nbsp;</p>

<br /><br />
                                 <%--GRID VIEW OF VOUCHER LIST--%>
                               
    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="85%">
        <tr class="bgbluegrey">
            <td class="blackfnt">Octroi Payment Voucher Summery</td>
        </tr>
    </table>
<br />


<asp:GridView align="center" ID="gvdirectvoucher" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
    AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left"
    CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"
    PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
    PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
    EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange"
    OnSelectedIndexChanged="gvdirectvoucher_SelectedIndexChanged"  Width="85%">
          <Columns >
          
          <asp:TemplateField HeaderText="Voucher No." SortExpression="tot1">
                <HeaderStyle CssClass = "blackfnt" />
                    <ItemTemplate>
                          <a href="javascript:popupmenu2('DirectVoucher_viewPrint.aspx?voucherno=<%# DataBinder.Eval( Container.DataItem,"voucherno") %>&printyn=0')" > <%# DataBinder.Eval( Container.DataItem,"voucherno") %> </a>
<%--                        <asp:HyperLink ID="HyperLink1"  Font-Underline="true" CssClass="blackfnt" NavigateUrl='<%#"DirectVoucher_viewPrint.aspx?voucherno=" + DataBinder.Eval(Container.DataItem,"voucherno")  %>' Text='<%# DataBinder.Eval( Container.DataItem,"voucherno") %>' runat="server"></asp:HyperLink>--%>
                    </ItemTemplate>
          </asp:TemplateField>
          
           <asp:BoundField DataField="transdate" HeaderText="Date" >
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
            </asp:BoundField>

            <asp:BoundField DataField="pbov_name" HeaderText="Octroi Agent" >
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
            </asp:BoundField>

            <asp:BoundField DataField="octamt" HeaderText="Octroi Agent" >
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
            </asp:BoundField>



    <asp:TemplateField HeaderText="Print" >
        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
        <ItemTemplate>
               <a href="javascript:popupmenu2('DirectVoucher_viewPrint.aspx?voucherno=<%# DataBinder.Eval( Container.DataItem,"voucherno") %>&printyn=1')" > View</a>
        </ItemTemplate>
    </asp:TemplateField>

</Columns>
<PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
<HeaderStyle CssClass="bgbluegrey" />
<PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"
/>
<FooterStyle CssClass="boxbg" />
</asp:GridView>
                               
            
</div>
</asp:Content>
