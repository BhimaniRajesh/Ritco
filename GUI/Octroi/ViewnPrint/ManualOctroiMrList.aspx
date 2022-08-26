<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="ManualOctroiMrList.aspx.cs" Inherits="GUI_Octroi_ViewnPrint_ManualOctroiMrList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script  language="javascript" type="text/javascript">
 function popupmenu2(choice)
 { 
  var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
  confirmWin=window.open(choice,"",winOpts);
 }
 </script>
 
                                <%--fields to bind in grid view has remained--%>

<p>&nbsp;</p>

                                  <%--Back Link To First Page in Viewing Agent Bills--%>
    
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td align="right" style="height: 33px">
                <a href="javascript:window.history.go(-1)" title="back">
                <img border="0" src="../../images/back.gif" /></a>
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
                                       <%-- SELECTION CRITERIA--%>

        <table align="center" bgcolor="#808080" class="boxbg" cellpadding="3" cellspacing="1" width="70%">
            <tr>
                <td align="right" style="width:50%" bgcolor="#ffffff"><font class="blackfnt">Mr Number : </font> </td>
                <td bgcolor="#ffffff" style="width:50%"><font class="blackfnt"><asp:Label runat="server" ID="lblmrno"></asp:Label></font></td>
            </tr>
            <tr>
                <td align="right" style="width:50%" bgcolor="#ffffff"><font class="blackfnt">Mr Date : </font> </td>
                <td bgcolor="#ffffff" style="width:50%"><font class="blackfnt"><asp:Label runat="server" ID="lblmrdate"></asp:Label></font></td>
            </tr>
        </table>
                      
<p>&nbsp;</p>


                                       <%--GRID VIEW OF DATA--%>
            
            <asp:GridView align="center" ID="gvmanualoctmr" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
                AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left"
                CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"
                PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange"
                OnSelectedIndexChanged="gvmanualoctmr_SelectedIndexChanged"  Width="90%">
    <Columns >
        <asp:TemplateField HeaderText="Sr.No." >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                    <ItemTemplate>
                        <asp:Label ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                </ItemTemplate>
        </asp:TemplateField>


<%--        <asp:BoundField DataField="MRSNO" HeaderText="MR No." >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
        </asp:BoundField>
--%>        
       
        <asp:TemplateField HeaderText="Bill Entry No." SortExpression="tot1">
        <HeaderStyle CssClass = "blackfnt" />
            <ItemTemplate>
                    <a href="javascript:popupmenu2('ManualOctroiMr_viewPrint.aspx?mrno=<%# DataBinder.Eval( Container.DataItem,"mrsno") %>&printyn=0')" > <%# DataBinder.Eval( Container.DataItem,"mrsno") %> </a>
                <%--<asp:HyperLink ID="HyperLink1"  Font-Underline="true" CssClass="blackfnt" NavigateUrl='<%#"ManualOctroiMr_viewPrint.aspx?mrno=" + DataBinder.Eval(Container.DataItem,"mrsno")  %>' Text='<%# DataBinder.Eval( Container.DataItem,"mrsno") %>' runat="server"></asp:HyperLink>--%>
            </ItemTemplate>
        </asp:TemplateField>
 
        <asp:BoundField DataField="MRSDT" HeaderText="MR Date" >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
        </asp:BoundField>


        <asp:BoundField DataFormatString="{0:F2}" DataField="PTNAME" HeaderText="MR Customer" >
             <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Right"  />
        </asp:BoundField>

        <asp:BoundField DataFormatString="{0:F2}" DataField="MRSAMT" HeaderText="MR Amount " >
             <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Right"  />
        </asp:BoundField>

        <asp:BoundField DataField="RECPTNO" HeaderText="Octroi Reciept Numebr" >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
        </asp:BoundField>

        <asp:TemplateField HeaderText="View">
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
            <ItemTemplate>
                <a href="javascript:popupmenu2('ManualOctroiMr_viewPrint.aspx?mrno=<%# DataBinder.Eval( Container.DataItem,"mrsno") %>&printyn=1')" > View</a>
            </ItemTemplate>
        </asp:TemplateField>

</Columns>
<PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
<HeaderStyle CssClass="bgbluegrey" />
<PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"
/>
<FooterStyle CssClass="boxbg" />
</asp:GridView>

</asp:Content>
