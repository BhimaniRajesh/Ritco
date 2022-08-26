<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master"  AutoEventWireup="true" CodeFile="zonelist.aspx.cs" Inherits="GUI_admin_Zone_Master_zonelist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<div align="center">
    <br />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
    <ContentTemplate>
    <asp:GridView ID="GrdPaidFollow" PagerStyle-Mode="NumericPages" CssClass="blackfnt" PageSize="10" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey"  BackColor="white" runat="server" SelectedIndex="1" OnRowEditing="GrdPaidFollow_RowEditing" OnRowCancelingEdit="GrdPaidFollow_RowCancelingEdit" OnRowUpdating="GrdPaidFollow_RowUpdating" OnRowDeleting="GrdPaidFollow_RowDeleting" > 
    <Columns>
 
                                 
                                <asp:BoundField DataField="ZoneCode" HeaderText="Zone Code"  >
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left"  Width="150"/>
                                    <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ZoneName" HeaderText="Zone Name">
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" Width="650" />
                                    <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                <asp:TemplateField HeaderText="Edit" HeaderStyle-Font-Bold="true">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" Width="100" />
                                                                                <ItemTemplate>
                                    
                                                                                    <label class="blackfnt">
                                                                                    <asp:HyperLink  Font-Underline="True"  Runat="server"  NavigateUrl='<%#"Editzone.aspx?para=2&zno="+DataBinder.Eval(Container.DataItem, "zonecode")+"&znm="+DataBinder.Eval(Container.DataItem, "zonename")%>' Text= 'Edit' ID="Hyperlink3"/>
                                                                                        
                                                                                    </label>
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                             
                             
                       
    
      
    </Columns> 
    </asp:GridView>
    </ContentTemplate> 
    </asp:UpdatePanel>       
    </div>


</asp:Content>
