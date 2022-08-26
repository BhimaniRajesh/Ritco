<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="DocketEditList.aspx.cs" Inherits="GUI_admin_DocketPrint_DocketList" %>




<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script  language="javascript" type="text/javascript">
 function popupmenu2(choice)
 { 
  var winOpts="scrollbars=yes,resizable=yes,target=_self,width="+500+",height="+400+"";
  window.open(choice);
 }
 function openEdit(choice)
 { 
 debugger
  var winOpts="scrollbars=yes,resizable=yes,target=_self,width="+500+",height="+400+"";
  window.open(choice,'',winOpts);
 return false;
 }
 
 </script>

<br />
                               
<u><font class="blackfnt"><b>Docket Entry</b> >> <font class="bluefnt"><b>Edit List</b></font></font></u>
<br /><br /><br />

<div style="width:10in">
                   <%--      SELECTION CRITERIA--%>

        <table align="center" bgcolor="#808080" class="boxbg" cellpadding="3" cellspacing="1" width="70%">
            <tr id="trdockno" runat="server">
                <td align="right" style="width:50%;display:block;" bgcolor="#ffffff"><font class="blackfnt"><%=dkt_call %> Number : </font> </td>
                <td bgcolor="#ffffff" style="width:50%"><font class="blackfnt"><asp:Label runat="server" CssClass="blackfnt" ID="lbldockno"></asp:Label></font></td>
            </tr>
            <tr id="trdockdt" runat="server">
                <td align="right" style="width:50%;display:block;" bgcolor="#ffffff"><font class="blackfnt"><%=dkt_call %> Booking Date : </font> </td>
                <td bgcolor="#ffffff" style="width:50%"><font class="blackfnt"><asp:Label runat="server" ID="lbldates"></asp:Label></font></td>
            </tr>
        </table>
<br /><br />                      

                                                         <%--GRID VIEW OF DATA--%>
            
        <asp:GridView align="center" ID="gvdocklist" runat="server" CellSpacing="1" BorderWidth="0" HeaderStyle-CssClass="bgbluegrey"
            AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left"
            CssClass="boxbg" FooterStyle-CssClass="boxbg" SelectedRowStyle-Font-Bold="true"
            PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
            PagerSettings-FirstPageText="[First]" PagerStyle-Font-Underline="true" PagerStyle-Font-Size="Larger" PagerSettings-LastPageText="[Last]"
            EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange"
            OnSelectedIndexChanged="gvdocklist_SelectedIndexChanged" Width="90%">
        <Columns >
 
        <asp:TemplateField HeaderText="Sr.No." >
            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Right" />
                    <ItemTemplate>
                        <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                </ItemTemplate>
        </asp:TemplateField>


    <asp:TemplateField HeaderText="<%=dkt_call %> No." SortExpression="tot1">
        <HeaderStyle Font-Bold="true" CssClass="blackfnt" />
        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
            <ItemTemplate>
                <%# DataBinder.Eval( Container.DataItem,"dockno") %> </a>
            </ItemTemplate>
    </asp:TemplateField>

        <asp:BoundField DataField="dockdt" HeaderText="Booking Date" >
            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
        </asp:BoundField>

        <asp:TemplateField HeaderText="Origin-Del Location" SortExpression="tot1">
        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
            <ItemTemplate>
                <%# DataBinder.Eval( Container.DataItem,"orgncd") %> - <%# DataBinder.Eval( Container.DataItem,"destcd") %>
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="From-To Location" SortExpression="tot1">
        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
            <ItemTemplate>
                <%# DataBinder.Eval( Container.DataItem,"from_loc") %> - <%# DataBinder.Eval( Container.DataItem,"to_loc") %>
            </ItemTemplate>
        </asp:TemplateField>

        <asp:BoundField DataField="paybas" HeaderText="Pay Basis" >
            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
        </asp:BoundField>

        <asp:BoundField DataField="party" HeaderText="Billing Party" >
            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" CssClass="blackfnt" />
                 <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Left"  />
        </asp:BoundField>

        <asp:TemplateField HeaderText="Edit">
            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
            <ItemTemplate>
               <asp:LinkButton ID="lnkdockedit" runat="server" OnClick="lnkdockedit_Click">Edit</asp:LinkButton>
               <asp:HiddenField ID="hdndockno" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"dockno") %>' />
            </ItemTemplate>
        </asp:TemplateField>

</Columns>
<PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
<HeaderStyle CssClass="bgbluegrey" />
<PagerSettings FirstPageText="[First]"  LastPageText="[Last]" Mode="NumericFirstLast" />
<FooterStyle CssClass="boxbg" />
</asp:GridView>

    <asp:Table ID="tblgrid" runat="server" CellSpacing="1" CssClass="blackfnt" BackColor="#8ba0e5" style="width:90%;display:none;">
        <asp:TableRow CssClass="bgbluegrey">
            <asp:TableCell Font-Bold="true" CssClass="blackfnt">Sr No.</asp:TableCell>
            <asp:TableCell Font-Bold="true" CssClass="blackfnt"><%=dkt_call %> No.</asp:TableCell>
            <asp:TableCell Font-Bold="true" CssClass="blackfnt">Booking Date</asp:TableCell>
            <asp:TableCell Font-Bold="true" CssClass="blackfnt">Origin-Del Location</asp:TableCell>
            <asp:TableCell Font-Bold="true" CssClass="blackfnt">From-To Location</asp:TableCell>
            <asp:TableCell Font-Bold="true" CssClass="blackfnt">Pay Basis</asp:TableCell>
            <asp:TableCell Font-Bold="true" CssClass="blackfnt">Billing Party</asp:TableCell>
            <asp:TableCell Font-Bold="true" CssClass="blackfnt">Edit</asp:TableCell>
        </asp:TableRow>
        <asp:TableRow style="height:24px;" BackColor="white">
            <asp:TableCell ColumnSpan="8" HorizontalAlign="Center" Font-Bold="true" CssClass="redfnt">No Records Found......</asp:TableCell>
        </asp:TableRow>
    </asp:Table>

</div>

</asp:Content>
