<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master"  AutoEventWireup="true" CodeFile="Grouplist.aspx.cs" Inherits="GUI_admin_Accounts_masters_Acctgroup_Grouplist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
 <div>
<table style="width:10in" border="0" cellpadding="0" cellspacing="0" align="left">
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr><td><font class="blackfnt"><b><a href="../../../welcome.aspx"><font class="blklnkund"><strong>Module</strong></font></a><strong> &gt; </strong></font>
 <a href="#"><font class="blklnkund"><strong>Admin</strong> </font></a>
  <strong> &gt; </strong>
   <a href="../../finance_accounts.aspx"><font class="blklnkund"><strong>Finance & Accounts</strong> </font></a>
   &gt; <font class="bluefnt"><strong>  
		   Group Listing
		   
		  </strong> </font>
   </td></tr>
    <%-- <tr> 
          <td><img src="../../images/clear.gif" width="15" height="10"></td>
        </tr>--%>

        <%--<tr> 
          <td align=right><a href="javascript:window.history.go(-1)" Title="back"><img src="../../images/back.gif" border=0></a></td>
        </tr>--%>
        <tr> 
          <td><img src="../../../images/clear.gif" width="15" height="10"></td>
        </tr>
   <tr> 
          <td><img src="../../../images/clear.gif" width="15" height="10"></td>
        </tr>
    <tr>
    <td>
          <asp:GridView ID="GV_Booking" runat="server" align="left" BorderWidth="1"  Width="10in" CellPadding="2" HeaderStyle-CssClass="bgbluegrey" 
                                                         PagerStyle-HorizontalAlign="left" 
                                                             CssClass="boxbg" BackColor="white" FooterStyle-CssClass="bgbluegrey"  
                                                             AllowPaging="true" PageSize="25"
                                    ShowFooter="True"
                            
                                                            OnPageIndexChanging="pgChange" AllowSorting="False" 
                                                            AutoGenerateColumns="false"
                                                               PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..." >
                                                                <PagerStyle VerticalAlign="Bottom"/>
                                                               
                                                               
                                                                <Columns>
                                                                 
                                                                   <asp:BoundField  DataField="Groupcode" HeaderStyle-Font-Bold="true"   ItemStyle-Wrap="False"  HeaderText="Group Code"   > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle    Wrap="False"  HorizontalAlign="Left" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                  <asp:BoundField  DataField="Groupdesc" HeaderStyle-Font-Bold="true"   ItemStyle-Wrap="False"  HeaderText="Group Name"   > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle    Wrap="False"  HorizontalAlign="Left" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                   
                                                                  <asp:BoundField  DataField="parentdesc"  HeaderStyle-Font-Bold="true"  ItemStyle-Wrap="false"  HeaderText="Under Group"   > 
                                                                            <HeaderStyle HorizontalAlign="Center"     CssClass="blackfnt" />
                                                                           <ItemStyle      HorizontalAlign="Left" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                        <asp:BoundField  DataField="Acct_prefix"  HeaderStyle-Font-Bold="true"  ItemStyle-Wrap="false"  HeaderText="Account Prefix"   > 
                                                                            <HeaderStyle HorizontalAlign="Center"     CssClass="blackfnt" />
                                                                           <ItemStyle      HorizontalAlign="Left" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                             
                                                                    <asp:TemplateField>
                                                                                  <HeaderTemplate >
                                                                                  <asp:Label ID="edit"  Font-Bold="true"  CssClass="blackfnt" Text="EDIT" runat="server"></asp:Label>
                                                                                  </HeaderTemplate>
                                                                                    <ItemTemplate>
                                                                                        <center>
                                                                                               <a href='Add_acctGroups.aspx?<%# DataBinder.Eval(Container.DataItem,"Groupcode") %> ' >Edit</a>
                                                                                        </center>
                                                                                    </ItemTemplate>
                                                                                  
                                                                     </asp:TemplateField>
                                                                 
                                                                 </Columns>
                                                                 
                                                                
                                              

                                                                </asp:GridView>
                                                                </td></tr> 
                                                                  <tr><td> <img src="../../../images/clear.gif" width="15" height="10"/></td></tr>
        <tr>
        <td>
       
<p></p>
<%--<center><asp:Button ID="submit" runat="server" Text="submit"  OnClick="submit_Click1"/></center>
--%>     </td>
        </tr>
       </table>
       </div>
</asp:Content>
