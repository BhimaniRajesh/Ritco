<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master" CodeFile="VendorVoucherList.aspx.cs" Inherits="GUI_Octroi_ViewnPrint_VendorVoucherList" %>

<asp:Content ContentPlaceHolderID="MyCPH1" ID="aaaa" runat="server">
<script  language="javascript" type="text/javascript">
 function popupmenu2(choice,docno,printyn,status)
 { 
     var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
     str=choice+"?voucherno="+docno+"&printyn="+printyn + "&status="+status;
     confirmWin=window.open(str,"",winOpts);
 }
 
 </script>
<div align="center">




<p>&nbsp;</p>

                                  <%--Back Link To First Page in Viewing Agent Bills--%>
    
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td align="right" style="height: 33px">
                <a href="javascript:window.history.go(-1)" title="back">
                <img border="0" alt="back.gif" src="../../images/back.gif" /></a>
            </td>
        </tr>
    </table>
    <br />
    
 
                                   <%--YOU SELECTED LINE--%>

<table width="100%">
        <tr>
            <td align="center"><font class="blackfnt"> You Selected</font></td>
        </tr>
</table>
<br />
                      <%--      SELECTION CRITERIA--%>

        <table align="center" bgcolor="#808080" class="boxbg" cellpadding="3" cellspacing="1" width="50%">
              <tr>
                <td align="right" style="width:50%"  bgcolor="#ffffff"><font class="blackfnt">Documnet No. : </font> </td>
                <td bgcolor="#ffffff" align="left" style="width:50%">
                    <font class="blackfnt">
                        <asp:Label runat="server" ID="lbldocno"></asp:Label>
                    </font>
                </td>
            </tr>
            <tr>
                <td align="right" style="width:50%"  bgcolor="#ffffff"><font class="blackfnt">Voucher No. : </font> </td>
                <td bgcolor="#ffffff" align="left" style="width:50%">
                    <font class="blackfnt">
                        <asp:Label runat="server" ID="lblvoucherno"></asp:Label>
                    </font>
                </td>
            </tr>
            <tr>
                <td align="right" style="width:50%" bgcolor="#ffffff"><font class="blackfnt">Voucher Date : </font> </td>
                <td bgcolor="#ffffff" align="left" style="width:50%">
                    <font class="blackfnt">
                        <asp:Label runat="server" ID="lbldates"></asp:Label>
                    </font>
                </td>
            </tr>
            
            <tr>
                <td align="right" style="width:50%"  bgcolor="#ffffff"><font class="blackfnt">Vendor Type : </font> </td>
                <td bgcolor="#ffffff" align="left" style="width:50%">
                    <font class="blackfnt">
                        <asp:Label runat="server" ID="lblvendortype"></asp:Label>
                    </font>
                </td>
            </tr>
            <tr>
                <td align="right" style="width:50%"  bgcolor="#ffffff"><font class="blackfnt">Vendor Name : </font> </td>
                <td bgcolor="#ffffff" align="left" style="width:50%">
                    <font class="blackfnt">
                        <asp:Label runat="server" ID="lblvendorname"></asp:Label>
                    </font>
                </td>
            </tr>
          
        </table>
                      
<p>&nbsp;</p>



        <table align="center" bgcolor="#808080" class="boxbg" cellpadding="3" cellspacing="1" width="90%">
                <tr class="bgbluegrey">
                    <td class="blackfnt" align="center"> Voucher List </td>
                </tr>
        </table>
<br />

                                                         <%--GRID VIEW OF DATA--%>
            
            <asp:GridView align="center" ID="gvvendorvoucher" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
                AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left"
                CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"
                PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange"
                OnSelectedIndexChanged="gvvendorvoucher_SelectedIndexChanged"  Width="90%">
<Columns >
 
     


    <asp:TemplateField HeaderText="Voucher No." SortExpression="tot1"  ItemStyle-HorizontalAlign="Center">
        <HeaderStyle CssClass = "blackfnt" />
            <ItemTemplate>
             <a href="javascript:popupmenu2('<%=pagename %>','<%# DataBinder.Eval( Container.DataItem,"documentno") %>',0,'<%=status %>')" > <%# DataBinder.Eval( Container.DataItem,"voucherno") %> </a>
<%--                <asp:HyperLink ID="HyperLink1"  Font-Underline="true" CssClass="blackfnt" NavigateUrl='<%#"VendorVoucher_viewPrint.aspx?voucherno=" + DataBinder.Eval(Container.DataItem,"voucherno")  %>' Text='<%# DataBinder.Eval( Container.DataItem,"voucherno") %>' runat="server"></asp:HyperLink>--%>
            </ItemTemplate>
    </asp:TemplateField>

        <asp:BoundField DataField="ENTRYDT" HeaderText="Date"  ItemStyle-HorizontalAlign="Center">
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
        </asp:BoundField>

    <asp:TemplateField HeaderText="Vendor" SortExpression="tot1"  ItemStyle-HorizontalAlign="Left">
        <HeaderStyle CssClass = "blackfnt" />
            <ItemTemplate>
                <asp:HyperLink ID="HyperLink1"  CssClass="blackfnt"  Text='<%# DataBinder.Eval( Container.DataItem,"pbov_code") + " : " + DataBinder.Eval( Container.DataItem,"pbov_name") %>' runat="server"></asp:HyperLink>
            </ItemTemplate>
    </asp:TemplateField>


        <asp:BoundField DataField="netamt" HeaderText="Vendor Amount" ItemStyle-HorizontalAlign="Right">
             <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Right"  />
        </asp:BoundField>

        <asp:TemplateField HeaderText="View">
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
            <ItemTemplate>
                <a href="javascript:popupmenu2('VendorVoucher_viewPrint.aspx?voucherno=<%# DataBinder.Eval( Container.DataItem,"voucherno") %>&printyn=1')" > View</a>
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
