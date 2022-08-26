<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Update_rate_commision.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_BA_Payment_Update_rate_commision" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<br />
<br />
<br />
<table  width="60%"  align="left"  cellpadding="0" cellspacing="0"
        style="width: 5.5in;">

<tr  ><td >
<table  width="60%"  align="left" class="boxbg" cellpadding="3" cellspacing="1"
        style="width: 5.5in;">

<tr  class="bgbluegrey"><td  height="30" align="center" colspan="2"><font class="blackboldfnt"> Enter Docket List - For Delivery Rates Update</font></td></tr>
<tr bgcolor="white"><td  height="30"><asp:TextBox ID="DKTlist" Width="250"  runat="server" ></asp:TextBox><font class="blackfnt">(Max 50 Dockets)</font></td><td ><asp:Button runat="server" ID="Submit" Text="Submit" OnClick="Submit_Click" /></td></tr>
</table>
</td>
    </tr>
    <tr><td><br /><br /><br /> <asp:Label  Visible="false" Text="Following Dockets Update Susccessfully !!!!!!" ID="lblsubmit" runat="server" CssClass="bluefnt"  Font-Bold="true"></asp:Label>
          
</td>
</tr><tr>
<td>
<br />
 <asp:GridView align="left" ID="dgDocket" Visible="false" runat="server" CellSpacing="1" CellPadding="2"
                HeaderStyle-CssClass="bgbluegrey" 
                 CssClass="boxbg" 
                 AutoGenerateColumns="false"   EmptyDataText="No Dockets Updates..."            >
                <Columns>
                  <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                  
                    <asp:BoundField DataField="dockno" HeaderText="Dockno">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="drs_BACODE" HeaderText="Vendor - BA">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt"  BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="actwt" HeaderText="Actu Wt.">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt"  BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="subtotal" HeaderText="Sub Total">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt"  BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="slabrate_dely" HeaderText="Slab Rate">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt"  BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="commission_dely" HeaderText="Commission">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt"  BackColor="white" />
                    </asp:BoundField>
                    
                    </Columns>
                <RowStyle />
                </asp:GridView>
</td>
</tr>
</table>
</asp:Content>

