<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="SalesSummary_Result.aspx.cs" Inherits="GUI_UNI_MIS_Sales_Register_SalesSummary_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<%--<script  language="javascript" type="text/javascript">
 function popupmenu2()
 { 
  var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
  dockno="<%=dockno%>"
  confirmWin=window.open('DocketPrint/DocketView_xls.aspx?dockno='+dockno,"",winOpts);
 }
 
 </script>--%>
 <br />
                                                            
                                                            <p align="center">
                                                                <label class="blackfnt">
                                                                    <b>
                                                                        You Selected
                                                                    </b>
                                                                </label>
                                                            </p>
                                                            
                                                            <%--<center>--%>
                                                           
                                                            
                                                            <table border="0" cellpadding="3" width="565" style="background-color: #808080;" cellspacing="1" align="center" class="boxbg">
                                                                <tr style="background-color: #ffffff">
                                                                    <td style="height: 10px">
                                                                        Date :</td>
                                                                    <td style="height: 10px">
                                                                        <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td>
                                                                </tr>
                                                                    <tr style="background-color: #FFFFFF">
                                                                        <td style="width: 205; height: 15px;">
                                                                            <label class="blackfnt">
                                                                                RO :</label></td>
                                                                        
                                                                        <td style="width: 343; height: 15px;">
                                                                            &nbsp;
                                                                            <asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                    <tr style="background-color: #FFFFFF">
                                                                        <td style="width: 205">
                                                                            <label class="blackfnt">
                                                                                Location :</label></td>
                                                                        
                                                                        <td style="width: 343">
                                                                            &nbsp;
                                                                            <asp:Label ID="lblloc" runat="server" CssClass="blackfnt"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                    <tr style="background-color: #FFFFFF">
                                                                        <td style="width: 205; height: 6px;">
                                                                            <label class="blackfnt">
                                                                                Customer Code :</label></td>
                                                                        
                                                                        <td style="width: 343; height: 6px;">
                                                                            &nbsp;
                                                                            <asp:Label ID="lblcust" runat="server" CssClass="blackfnt"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                               
                                                                </table>
                                                            <br />
<asp:DataGrid ID="dgSales" runat="server"  CellPadding="4"
 HorizontalAlign="Center" OnPageIndexChanged="pgChange" AllowPaging="True" 
  HeaderStyle-CssClass = "bgbluegrey"
  ItemStyle-CssClass="blackfnt"
     PagerStyle-Position="Bottom"
    PagerStyle-Mode="NumericPages"
    PagerStyle-NextPageText="[Next]" 
     PagerStyle-PrevPageText="[Prev]" Font-Bold="False" Font-Italic="False" Font-Names="Verdana" Font-Overline="False" Font-Size="Smaller" Font-Strikeout="False" Font-Underline="False" ><Columns> 
 
 
<asp:TemplateColumn HeaderText="Sr No."> 

   <ItemTemplate > 
       <span ><asp:Label ID="lblsrnocomplainlist" text ="<%#Container.DataSetIndex+1 %>" runat="server">
                                 </asp:Label></span> 
   </ItemTemplate>  
   
   
</asp:TemplateColumn> 
    <%-- <<%--asp:HyperLinkColumn  DataNavigateUrlField="DocketNo"    DataNavigateUrlFormatString=""
                                                               
                     Target="_blank"   DataTextField="DocketNo" HeaderText="DocketNo"></asp:HyperLinkColumn>--%>
</Columns> 
                   <FooterStyle CssClass="bgbluegrey" Font-Bold="True" />
                   <%-- <SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />--%>
                    <PagerStyle CssClass="blackfnt" HorizontalAlign="Center" NextPageText="[Next]" PrevPageText="[Prev]" Mode="NumericPages" />
                    <%--<AlternatingItemStyle BackColor="White" />--%>
                   <ItemStyle HorizontalAlign="center"   BackColor="white"  CssClass="blackfnt" />
                    <HeaderStyle CssClass="bgbluegrey"   HorizontalAlign="center"  />

    </asp:DataGrid>
<table cellspacing="1" style="width: 100%">
        <tr align="center">
            <td align="center">
            <br /> <br />
            
                        <%-- <asp:Button ID="btnShow" runat="server" Text="XLS Download"  OnClick="btnShow_Click" Width="75px"  /></td>--%>
            
               <%-- <asp:UpdatePanel ID="u1"  UpdateMode="Conditional" runat="server">
                    <ContentTemplate>--%>
                     <%--<p class="pageLinks">
  <b>Page
  <asp:Label id="CurrentPage" CssClass="pageLinks" runat="server" />
  of
  <asp:Label id="TotalPages" CssClass="pageLinks" runat="server" />
      
 </p>
 <asp:LinkButton runat="server" CssClass="pageLinks"
  id="FirstPage" Text="[First Page]"
  OnCommand="NavigationLink_Click" CommandName="First" />
 <asp:LinkButton runat="server" CssClass="pageLinks"
  id="PreviousPage" Text="[Previous Page]"
  OnCommand="NavigationLink_Click" CommandName="Prev" />
 <asp:LinkButton runat="server" CssClass="pageLinks"
  id="NextPage" Text="[Next Page]"
  OnCommand="NavigationLink_Click" CommandName="Next" />
 <asp:LinkButton runat="server" CssClass="pageLinks"
  id="LastPage" Text="[Last Page]"
  OnCommand="NavigationLink_Click" CommandName="Last" />
 </center>--%>
                       <%-- </B>
                    
                    </ContentTemplate>--%>
                    <%--<Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnShow" EventName="Click" />
                    </Triggers>--%>
               <%-- </asp:UpdatePanel>--%>
               
    

    </td>
        </tr>
    </table>
    <br />
        <table border="0" cellpadding="0" width="565" bgcolor="white" cellspacing="0" align="center">
            
           
            <tr bgcolor="white">
                <td colspan="2" align="center">
                    <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                </td>
            </tr>
        </table>
</asp:Content>
