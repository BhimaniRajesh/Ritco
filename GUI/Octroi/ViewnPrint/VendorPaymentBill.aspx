<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="VendorPaymentBill.aspx.cs" Inherits="GUI_Octroi_ViewnPrint_VendorPaymentBill" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="server">

<script  language="javascript" type="text/javascript">
 function popupmenu2(choice)
 { 
  var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
  confirmWin=window.open(choice,"",winOpts);
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

        <table align="center" bgcolor="#808080" class="boxbg" cellpadding="3" cellspacing="1" width="90%">
            <tr>
                <td align="right" style="width:50%" bgcolor="#ffffff"><font class="blackfnt">Bill Entry Number : </font> </td>
                <td bgcolor="#ffffff" align="left" style="width:50%">
                    <font class="blackfnt">
                        <asp:Label runat="server" ID="lblbillno"></asp:Label>
                    </font>
                </td>
            </tr>
            <tr>
                <td align="right" style="width:50%" bgcolor="#ffffff"><font class="blackfnt">Dates : </font> </td>
                <td bgcolor="#ffffff" align="left" style="width:50%">
                    <font class="blackfnt">
                        <asp:Label runat="server" ID="lbldates"></asp:Label>
                    </font>
                </td>
            </tr>
            <tr>
                <td align="right" style="width:50%"  bgcolor="#ffffff"><font class="blackfnt">Documnet Type : </font> </td>
                <td bgcolor="#ffffff" align="left" style="width:50%">
                    <font class="blackfnt">
                        <asp:Label runat="server" ID="lbldoctype"></asp:Label>
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
                                                         <%--GRID VIEW OF DATA--%>
            
            <asp:GridView align="center" ID="gvvendorpayment" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
                AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left"
                CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"
                PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange"
                OnSelectedIndexChanged="gvvendorpayment_SelectedIndexChanged"  Width="90%">
<Columns >
 
        <asp:TemplateField HeaderText="Sr.No." >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                    <ItemTemplate>
                        <asp:Label ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                </ItemTemplate>
        </asp:TemplateField>


    <asp:TemplateField HeaderText="Bill Entry No." SortExpression="tot1">
        <HeaderStyle CssClass = "blackfnt" />
            <ItemTemplate>
                    <%--<a href="javascript:popupmenu2('VendorPayment_viewPrint.aspx?billno=<%# DataBinder.Eval( Container.DataItem,"billno") %>&printyn=0')" > <%# DataBinder.Eval( Container.DataItem,"billno") %> </a>--%>
                     <a href="javascript:popupmenu2('VendorPayment_viewPrint.aspx?billno=<%# DataBinder.Eval( Container.DataItem,"billno") %>&printyn=0')" > <%# DataBinder.Eval( Container.DataItem,"billno") %> </a>
            </ItemTemplate>
    </asp:TemplateField>

        <asp:BoundField DataField="ENTRYDT" HeaderText="Bill Date" >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
        </asp:BoundField>


        <asp:BoundField DataField="BRCD" HeaderText="Bill Location" >
             <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Right"  />
        </asp:BoundField>

        <asp:BoundField DataField="VENDORNAME" HeaderText="Vendor Name " >
             <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Right"  />
        </asp:BoundField>

        <asp:BoundField DataField="DUEDT" HeaderText="Due Date" >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
        </asp:BoundField>

        <asp:BoundField DataField="NETAMT" HeaderText="Net Amount" >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                 <ItemStyle CssClass="blackfnt" HorizontalAlign="Right"  />
        </asp:BoundField>

        <asp:TemplateField HeaderText="View">
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
            <ItemTemplate>
               

<a href="javascript:popupmenu2('VendorPayment_viewPrint.aspx?billno=<%# DataBinder.Eval( Container.DataItem,"billno") %>&printyn=1')" > View</a>
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
