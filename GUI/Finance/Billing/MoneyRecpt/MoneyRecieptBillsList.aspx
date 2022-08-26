<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="MoneyRecieptBillsList.aspx.cs" Inherits="GUI_Finance_MoneyRecpt_MoneyRecieptBillsList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script  language="javascript" type="text/javascript">
 function popupmenu2(choice)
 { 
  var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
  confirmWin=window.open(choice,"",winOpts);
 }
 </script>

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
                      <%--      SELECTION CRITERIA--%>

        <table align="center" bgcolor="#808080" class="boxbg" cellpadding="3" cellspacing="1" width="70%">
          
            <tr>
                <td align="right" style="width:50%" bgcolor="#ffffff"><font class="blackfnt">MR Type :</font> </td>
                <td bgcolor="#ffffff" style="width:50%">
                    <font class="blackfnt">
                        <asp:Label runat="server" ID="lblmrtype"></asp:Label>
                    </font>
                </td>
            </tr>
            <tr>
                <td align="right" style="width:50%"  bgcolor="#ffffff"><font class="blackfnt">MR No. :</font> </td>
                <td bgcolor="#ffffff" style="width:50%">
                    <font class="blackfnt">
                        <asp:Label runat="server" ID="lblmrno"></asp:Label>
                    </font>
                </td>
            </tr>
            
            <tr>
                <td align="right" style="width:50%"  bgcolor="#ffffff"><font class="blackfnt">Document No. :</font> </td>
                <td bgcolor="#ffffff" style="width:50%">
                    <font class="blackfnt">
                        <asp:Label runat="server" ID="lbldockno"></asp:Label>
                    </font>
                </td>
            </tr>
               
            <tr>
                <td align="right" style="width:50%"  bgcolor="#ffffff"><font class="blackfnt">Date :</font> </td>
                <td bgcolor="#ffffff" style="width:50%">
                    <font class="blackfnt">
                        <asp:Label runat="server" ID="lbldates"></asp:Label>
                    </font>
                </td>
            </tr>
        </table>
                      
<p>&nbsp;</p>
                                                         <%--GRID VIEW OF DATA--%>
            
            <asp:GridView align="center" ID="gvmoneyrecpbills" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
                AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left"
                CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"
                PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange"
                OnSelectedIndexChanged="gvmoneyrecpbills_SelectedIndexChanged"
                OnRowDataBound="gvmoneyrecpbills_OnRowDataBound"  Width="90%">
<Columns >
 
        <asp:TemplateField HeaderText="Sr.No." >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                    <ItemTemplate>
                        <asp:Label ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                </ItemTemplate>
        </asp:TemplateField>


        <asp:TemplateField HeaderText="MR Number" SortExpression="tot1">
            <HeaderStyle CssClass = "blackfnt" />
                <ItemTemplate>
                    <a href="javascript:popupmenu2('MR_Summ_Popup.aspx?mrno=<%# DataBinder.Eval( Container.DataItem,"mrsno") %>&printyn=0')" > <%# DataBinder.Eval( Container.DataItem,"mrsno") %> </a>
                </ItemTemplate>
        </asp:TemplateField>

        <asp:BoundField DataField="mrsdt" HeaderText="MR Date">
             <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Right"  />
        </asp:BoundField>
      
        <asp:BoundField DataField="mrstype" HeaderText="MR Type" >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                 <ItemStyle CssClass="blackfnt" HorizontalAlign="Right"  />
        </asp:BoundField>

        <asp:BoundField DataField="ptcd" HeaderText="Party" >
            <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="True"  HorizontalAlign="Right"  />
        </asp:BoundField>
        
        
        <asp:BoundField DataField="mrsamt" HeaderText="MR Amount" >
            <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="True"  HorizontalAlign="Right"  />
        </asp:BoundField>
        
        
        <asp:BoundField DataField="deduction" HeaderText="Deduction" >
            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False"  HorizontalAlign="Right"  />
        </asp:BoundField>
        
        
        <asp:BoundField DataField="netamt" HeaderText="Net Amount" >
            <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Right"  />
        </asp:BoundField>
        
         <asp:BoundField DataField="finclosedt" HeaderText="CBS Date" >
            <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="false"  HorizontalAlign="Right"  />
        </asp:BoundField>
        
        <asp:TemplateField HeaderText="Print" SortExpression="tot1">
            <HeaderStyle CssClass = "blackfnt" />
                <ItemTemplate>
                    <a href="javascript:popupmenu2('MR_Summ_Popup.aspx?mrno=<%# DataBinder.Eval( Container.DataItem,"mrsno") %>&printyn=1')" > View </a>
                </ItemTemplate>
        </asp:TemplateField>
        
                <%--COVERIN lETTER REMAINED--%>

</Columns>
<PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
<HeaderStyle CssClass="bgbluegrey" />
<PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"/>
<FooterStyle CssClass="boxbg" />
</asp:GridView>

</asp:Content>
