<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OctroiBillList.aspx.cs"  MasterPageFile="~/GUI/MasterPage.master"  Inherits="GUI_Octroi_Octroi_Bill_BillListReport" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script  language="javascript" type="text/javascript">
 function popupmenu2(choice)
 { 
  var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
  confirmWin=window.open(choice,"",winOpts);
 }
 </script>
<p>&nbsp;</p>

      
			

                                  <%--Back Link To First Page in Viewing Octroy Bills--%>
    
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td align="right" style="height: 33px">
                <a href="javascript:window.history.go(-1)" title="back">
                <img alt="back.gif" border="0" src="../../images/back.gif" /></a>
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

        <table align="center" bgcolor="#808080" class="boxbg" cellpadding="3" cellspacing="1" width="70%">
            <tr>
                <td align="right" style="width:50%" bgcolor="#ffffff"><font class="blackfnt">Bill No. : </font> </td>
                <td bgcolor="#ffffff" style="width:50%"><font class="blackfnt"><asp:Label runat="server" ID="lblbillno"></asp:Label></font></td>
            </tr>
            <tr>
                <td align="right" style="width:50%" bgcolor="#ffffff"><font class="blackfnt">Location : </font> </td>
                <td bgcolor="#ffffff" style="width:50%"><font class="blackfnt"><asp:Label runat="server" ID="lbllocation"></asp:Label></font></td>
            </tr>
            <tr>
                <td align="right" style="width:50%"  bgcolor="#ffffff"><font class="blackfnt">Customer :</font> </td>
                <td bgcolor="#ffffff" style="width:50%"><font class="blackfnt"><asp:Label runat="server" ID="lblcustomer"></asp:Label></font></td>
            </tr>
             <tr>
                <td align="right" style="width:50%"  bgcolor="#ffffff"><font class="blackfnt">Date :</font> </td>
                <td bgcolor="#ffffff" style="width:50%"><font class="blackfnt"><asp:Label runat="server" ID="lbldates"></asp:Label></font></td>
            </tr>
        </table>
                      
<p>&nbsp;</p>
                                        <%--GRID VIEW OF DATA--%>
            <div align="center" runat="server">
            <asp:GridView align="center" ID="gvoctroibill" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
                AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left"
                CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"
                PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange" 
                OnSelectedIndexChanged="gvoctroibill_SelectedIndexChanged"  Width="90%" OnRowDataBound="gvoctroibill_RowDataBound">
<Columns >
  
     <asp:TemplateField HeaderText="Sr.No.">
        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
        <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
        <ItemTemplate>
            <asp:Label ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server">
            </asp:Label>
        </ItemTemplate>
    </asp:TemplateField>

    <asp:TemplateField HeaderText="Bill Entry No." SortExpression="tot1">
        <HeaderStyle CssClass = "blackfnt" />
            <ItemTemplate>
        <%--    <asp:HyperLink Runat="server" Font-Underline="True" CssClass="blackfnt" NavigateUrl='<%#"sfm_funnel_report_loc_wise3.aspx?pro=" +DataBinder.Eval(Container.DataItem, "HotKount")+"&calltype="+"HOT"+"&value="+DataBinder.Eval(Container.DataItem, "HotWalue")+"&location=" +DataBinder.Eval(Container.DataItem, "loccode") + "&fromdt=" +strActualFromDate + "&todt=" + strActualToDate %>' Text= '<%#DataBinder.Eval(Container.DataItem, "HotKount")%>' ID="Hyperlink1">
        </asp:HyperLink>
--%>
            
              <%--  <asp:HyperLink  Font-Underline="true" CssClass="blackfnt" NavigateUrl='<%#"OctroiBill_viewPrint.aspx?billno=" + DataBinder.Eval(Container.DataItem,"billno")  %>' Text='<%# DataBinder.Eval( Container.DataItem,"billno") %>' runat="server"></asp:HyperLink>--%>
                 <a href="javascript:popupmenu2('OctroiBill_viewPrint.aspx?billno=<%# DataBinder.Eval( Container.DataItem,"ocbillno") %>&printyn=0')" > <%# DataBinder.Eval( Container.DataItem,"ocbillno") %> </a>
                  <%--<asp:LinkButton ID="lnkbillno" CommandArgument='<%# Eval("billno") %>'  CssClass="blackfnt" CommandName="LnkDocketsBooked" Font-Underline="true" Text='<%# DataBinder.Eval( Container.DataItem,"billno") %>' runat="server"></asp:LinkButton><br />--%>
            </ItemTemplate>
    </asp:TemplateField>

<asp:BoundField DataField="BBRCD" HeaderText="Bill Location" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
</asp:BoundField>

<asp:BoundField DataField="BILLAMT" HeaderText="Bill Amount " >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt"  HorizontalAlign="Right"  />
</asp:BoundField>

<asp:BoundField DataField="BILLSTATUS" HeaderText="Bill Status" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
</asp:BoundField>

<asp:BoundField DataField="BGNDT" HeaderText="Generation Date" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" HorizontalAlign="Right"  />
</asp:BoundField>

<asp:BoundField DataField="BSBDT" HeaderText="Submission Date" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt"  HorizontalAlign="Right"  />
</asp:BoundField>


<asp:BoundField DataField="BDUEDT" HeaderText="Due Date" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt"  HorizontalAlign="Right"  />
</asp:BoundField>


<asp:BoundField DataField="BCLDT" HeaderText="Collection Date" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt"  HorizontalAlign="Right"  />
</asp:BoundField>

   <asp:TemplateField HeaderText="Print" >
        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
        <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
        <ItemTemplate>
                <asp:LinkButton ID="lnkview" runat="server">
                    <a href="javascript:popupmenu2('OctroiBill_viewPrint.aspx?billno=<%# DataBinder.Eval( Container.DataItem,"billno") %>&printyn=1')" > View</a>
                </asp:LinkButton>
                
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
