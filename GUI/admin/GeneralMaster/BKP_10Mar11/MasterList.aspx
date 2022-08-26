<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="MasterList.aspx.cs" Inherits="GUI_admin_GeneralMaster_MasterList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    
<script type="text/javascript" language="javascript">
function popupmenu2(choice)
 { 
  var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
  confirmWin=window.open(choice,"",winOpts);
 }
</script>
     
   <br /><br />
<div align="center" style="width:9.5in">
<asp:GridView align="center" ID="gvmasterlist" runat="server" BorderWidth="0" BorderStyle="None" CellPadding="2" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey"
    AllowSorting="true" AllowPaging="false" PageSize="20" PagerStyle-HorizontalAlign="left"
    CssClass="boxbg" BackColor="#8ba0e5" FooterStyle-CssClass="boxbg"
    PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
    PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
    EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange"
    OnSelectedIndexChanged="gvmasterlist_SelectedIndexChanged"  Width="50%">
  <Columns>
          <asp:TemplateField HeaderText="" SortExpression="tot1">
                <HeaderStyle CssClass = "blackfnt" />
                   <ItemStyle BackColor="White" HorizontalAlign="Center" Width="50px" />
                    <ItemTemplate>
                           <img alt="asdfa" class="bullet" src="../../images/clear.gif" width="4" height="4"/>
                    </ItemTemplate>
          </asp:TemplateField>

          <asp:TemplateField HeaderText="General Masters" SortExpression="tot1">
                <HeaderStyle CssClass = "blklnkuld" />
                <ItemStyle BackColor="White" Height="15px" HorizontalAlign="Left" />
                    <ItemTemplate>
                          <a href="GeneralMaster.aspx?mastercode=<%# DataBinder.Eval( Container.DataItem,"headercode") %>" > <%# DataBinder.Eval( Container.DataItem,"headerdesc") %> </a>
                    </ItemTemplate>
          </asp:TemplateField>
  </Columns>
  
  <PagerStyle BackColor="White" />
 </asp:GridView>
       
   
</div>       
</asp:Content>
