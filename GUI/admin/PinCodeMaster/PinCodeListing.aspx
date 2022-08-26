<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="PinCodeListing.aspx.cs" Inherits="GUI_admin_AirportMaster_AirportListing" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <div align="left" style="width:10in">
        <br />
        <table style="width: 1000px">
        <tr>
                            <td align="left">
                                <a><font class="blklnkund"><strong>Module</strong></font></a> &gt; <a><font class="blklnkund">
                                    <strong>Administrator </strong></font></a>&gt; <a href="../company_structure.aspx"><font
                                        class="blklnkund"><strong>Company Structure</strong></font></a> <font class="bluefnt">
                                            <strong>&gt;PinCode Master</strong> </font>
                            </td>
                            <td align="right">
                                <a href="javascript:window.history.go(-1)" title="back">
                                    <img src="../../images/back.gif" border="0" alt="" /></a>
                            </td>
                        </tr>
        </table>
        <br />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
    <ContentTemplate>
    <asp:GridView ShowFooter="true" ID="GrdPaidFollow" PagerStyle-Mode="NumericPages" CssClass="boxbg" PageSize="10" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey"  BackColor="white" runat="server" SelectedIndex="1"> 
    <Columns>
     <asp:TemplateField ItemStyle-Width="150"  HeaderText="State">
        <HeaderStyle CssClass="blackfnt" /> 
                <ItemTemplate>
                <asp:Label ID="lblstatename" CssClass="blackfnt" Width="150" runat="server" Text='<%# Eval("state") %>' ></asp:Label> 
                </ItemTemplate>
    </asp:TemplateField>
    
    <asp:TemplateField ItemStyle-Width="150"  HeaderText="State Code" Visible="false">
        <HeaderStyle CssClass="blackfnt" /> 
                <ItemTemplate>
                <asp:Label ID="lblstate" CssClass="blackfnt" Width="150" runat="server" Text='<%# Eval("statecode") %>' ></asp:Label> 
                </ItemTemplate>
    </asp:TemplateField>
    
    <asp:TemplateField ItemStyle-Width="150"  HeaderText="City">
        <HeaderStyle CssClass="blackfnt" /> 
                <ItemTemplate>                
                <asp:Label ID="lblcity" Width="150" CssClass="blackfnt" runat="server" Text='<%# Eval("cityname") %>' ></asp:Label> 
                </ItemTemplate>
    </asp:TemplateField>
    
    <asp:TemplateField ItemStyle-Width="150"  HeaderText="Pin Code">
        <HeaderStyle CssClass="blackfnt" /> 
                <ItemTemplate>                
                <asp:Label ID="lblpin" Width="150" CssClass="blackfnt" runat="server" Text='<%# Eval("pincode") %>' ></asp:Label> 
                </ItemTemplate>
    </asp:TemplateField>
    
    <asp:TemplateField>
        <HeaderStyle CssClass="blackfnt" /> 
                <ItemTemplate>
                <asp:Button Text="  Edit  " OnClick="editpincode" ID="CmdEdit" runat="server" UseSubmitBehavior="false"/>
                </ItemTemplate>
    </asp:TemplateField>  
    
    <asp:TemplateField>
        <HeaderStyle CssClass="blackfnt" /> 
                <ItemTemplate>
                <asp:Button Text="Delete" OnClientClick="return confirm('Are You Sure Want To Delete ?')"  ID="CmdDeleteExtern" OnClick="delairport"  runat="server"  UseSubmitBehavior="true"/>  
                </ItemTemplate>
                <FooterTemplate>
                <asp:Button Text=" Add  " ID="CmdAdd" runat="server" CommandName="Add" UseSubmitBehavior="true" PostBackUrl="~/GUI/admin/PinCodeMaster/FrmPincodeCriteria.aspx"/>  
                </FooterTemplate> 
    </asp:TemplateField>        
    </Columns> 
    </asp:GridView>
    </ContentTemplate> 
    </asp:UpdatePanel>       
    </div>
    </asp:Content>
