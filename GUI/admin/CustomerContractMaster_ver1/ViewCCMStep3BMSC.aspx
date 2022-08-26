<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ViewCCMStep3BMSC.aspx.cs" Inherits="GUI_admin_CustomerContractMaster_ViewCCMStep3BMSC" Title="Customer Contract Master - SUNDRY" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
 <div style="width:10in;">
   
   <br /><br />
   <table style="width:100%" cellspacing="1" class="boxbg">
        <tr class="bgbluegrey">
            <td align="center" colspan="12">
                <b>Slab Range</b>
            </td>
        </tr>
        <tr class="blackfnt" bgcolor="#ffffff">
            <td colspan="2" align="center"><b>Slab 1</b></td>
            <td colspan="2" align="center"><b>Slab 2</b></td>
            <td colspan="2" align="center"><b>Slab 3</b></td>
            <td colspan="2" align="center"><b>Slab 4</b></td>
            <td colspan="2" align="center"><b>Slab 5</b></td>
            <td colspan="2" align="center"><b>Slab 6</b></td>
        </tr>
        <tr bgcolor="#ffffff">
            <td>
                <asp:Label ID="lblslab1from" CssClass="blackfnt" runat="server" Text="0.00"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblslab1to" CssClass="blackfnt" runat="server" Text="0.00"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblslab2from" CssClass="blackfnt" runat="server" Text="0.00"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblslab2to" CssClass="blackfnt" runat="server" Text="0.00"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblslab3from" CssClass="blackfnt" runat="server" Text="0.00"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblslab3to" CssClass="blackfnt" runat="server" Text="0.00"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblslab4from" CssClass="blackfnt" runat="server" Text="0.00"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblslab4to" CssClass="blackfnt" runat="server" Text="0.00"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblslab5from" CssClass="blackfnt" runat="server" Text="0.00"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblslab5to" CssClass="blackfnt" runat="server" Text="0.00"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblslab6from" CssClass="blackfnt" runat="server" Text="0.00"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblslab6to" CssClass="blackfnt" runat="server" Text="0.00"></asp:Label>
            </td>
        </tr>
   </table>
   
   <br /><br />
     <font class="bluefnt"><b>RAOD - BRANCH LISTING</b></font><br />
            <asp:GridView CssClass="boxbg" runat="server" ID="grvroadfreightbranch" 
                    CellSpacing="1" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                    BorderWidth="0" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                    AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                    OnRowDataBound="grvroadfreightbranch_RowDataBound">
                    <Columns>

                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                From
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblfrom" Text='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>' Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                To
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblto" Text='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>' Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Transit Days
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lbltransit" Text='<%# DataBinder.Eval( Container.DataItem,"trdays") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Rate Type
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblratetype" Text='<%# DataBinder.Eval( Container.DataItem,"ratetype") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 1
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab1" Text='<%# DataBinder.Eval( Container.DataItem,"slab1") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 2
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab2" Text='<%# DataBinder.Eval( Container.DataItem,"slab2") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 3
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab3" Text='<%# DataBinder.Eval( Container.DataItem,"slab3") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 4
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab4" Text='<%# DataBinder.Eval( Container.DataItem,"slab4") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 5
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab5" Text='<%# DataBinder.Eval( Container.DataItem,"slab5") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 6
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab6" Text='<%# DataBinder.Eval( Container.DataItem,"slab6") %>'  Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
             
    <br /><br />
     <font class="bluefnt"><b>EXPRESS - BRANCH LISTING</b></font><br />
            <asp:GridView CssClass="boxbg" runat="server" ID="grvexpressfreightbranch" 
                    CellSpacing="1" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                    BorderWidth="0" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                    AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                    OnRowDataBound="grvexpressfreightbranch_RowDataBound">
                    <Columns>

                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                From
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblfrom" Text='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>' Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                To
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblto" Text='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>' Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Transit Days
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lbltransit" Text='<%# DataBinder.Eval( Container.DataItem,"trdays") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Rate Type
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblratetype" Text='<%# DataBinder.Eval( Container.DataItem,"ratetype") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 1
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab1" Text='<%# DataBinder.Eval( Container.DataItem,"slab1") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 2
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab2" Text='<%# DataBinder.Eval( Container.DataItem,"slab2") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 3
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab3" Text='<%# DataBinder.Eval( Container.DataItem,"slab3") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 4
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab4" Text='<%# DataBinder.Eval( Container.DataItem,"slab4") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 5
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab5" Text='<%# DataBinder.Eval( Container.DataItem,"slab5") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 6
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab6" Text='<%# DataBinder.Eval( Container.DataItem,"slab6") %>'  Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
             
     <br /><br />
     <font class="bluefnt"><b>AIR - BRANCH LISTING</b></font><br />
            <asp:GridView CssClass="boxbg" runat="server" ID="grvairfreightbranch" 
                    CellSpacing="1" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                    BorderWidth="0" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                    AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                    OnRowDataBound="grvairfreightbranch_RowDataBound">
                    <Columns>

                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                From
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblfrom" Text='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>' Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                To
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblto" Text='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>' Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Transit Days
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lbltransit" Text='<%# DataBinder.Eval( Container.DataItem,"trdays") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Rate Type
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblratetype" Text='<%# DataBinder.Eval( Container.DataItem,"ratetype") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 1
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab1" Text='<%# DataBinder.Eval( Container.DataItem,"slab1") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 2
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab2" Text='<%# DataBinder.Eval( Container.DataItem,"slab2") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 3
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab3" Text='<%# DataBinder.Eval( Container.DataItem,"slab3") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 4
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab4" Text='<%# DataBinder.Eval( Container.DataItem,"slab4") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 5
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab5" Text='<%# DataBinder.Eval( Container.DataItem,"slab5") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 6
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab6" Text='<%# DataBinder.Eval( Container.DataItem,"slab6") %>'  Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
             
             
 <br /><br />
     <font class="bluefnt"><b>TRAIN - BRANCH LISTING</b></font><br />
            <asp:GridView CssClass="boxbg" runat="server" ID="grvtrainfreightbranch" 
                    CellSpacing="1" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                    BorderWidth="0" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                    AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                    OnRowDataBound="grvtrainfreightbranch_RowDataBound">
                    <Columns>

                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                From
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblfrom" Text='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>' Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                To
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblto" Text='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>' Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Transit Days
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lbltransit" Text='<%# DataBinder.Eval( Container.DataItem,"trdays") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Rate Type
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblratetype" Text='<%# DataBinder.Eval( Container.DataItem,"ratetype") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 1
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab1" Text='<%# DataBinder.Eval( Container.DataItem,"slab1") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 2
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab2" Text='<%# DataBinder.Eval( Container.DataItem,"slab2") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 3
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab3" Text='<%# DataBinder.Eval( Container.DataItem,"slab3") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 4
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab4" Text='<%# DataBinder.Eval( Container.DataItem,"slab4") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 5
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab5" Text='<%# DataBinder.Eval( Container.DataItem,"slab5") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 6
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab6" Text='<%# DataBinder.Eval( Container.DataItem,"slab6") %>'  Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
   
   
   
   
   
   <%--ZONE FILLING--%>
   
   
   
   
   <br /><br />
     <font class="bluefnt"><b>RAOD - ZONE LISTING</b></font><br />
            <asp:GridView CssClass="boxbg" runat="server" ID="grvroadfreightzone" 
                    CellSpacing="1" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                    BorderWidth="0" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                    AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                    OnRowDataBound="grvroadfreightzone_RowDataBound">
                    <Columns>

                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                From
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblfrom" Text='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>' Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                To
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblto" Text='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>' Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Transit Days
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lbltransit" Text='<%# DataBinder.Eval( Container.DataItem,"trdays") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Rate Type
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblratetype" Text='<%# DataBinder.Eval( Container.DataItem,"ratetype") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 1
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab1" Text='<%# DataBinder.Eval( Container.DataItem,"slab1") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 2
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab2" Text='<%# DataBinder.Eval( Container.DataItem,"slab2") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 3
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab3" Text='<%# DataBinder.Eval( Container.DataItem,"slab3") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 4
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab4" Text='<%# DataBinder.Eval( Container.DataItem,"slab4") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 5
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab5" Text='<%# DataBinder.Eval( Container.DataItem,"slab5") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 6
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab6" Text='<%# DataBinder.Eval( Container.DataItem,"slab6") %>'  Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
   
   
    <br /><br />
     <font class="bluefnt"><b>EXPRESS - ZONE LISTING</b></font><br />
            <asp:GridView CssClass="boxbg" runat="server" ID="grvexpressfreightzone" 
                    CellSpacing="1" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                    BorderWidth="0" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                    AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                    OnRowDataBound="grvexpressfreightbranch_RowDataBound">
                    <Columns>

                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                From
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblfrom" Text='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>' Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                To
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblto" Text='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>' Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Transit Days
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lbltransit" Text='<%# DataBinder.Eval( Container.DataItem,"trdays") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Rate Type
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblratetype" Text='<%# DataBinder.Eval( Container.DataItem,"ratetype") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 1
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab1" Text='<%# DataBinder.Eval( Container.DataItem,"slab1") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 2
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab2" Text='<%# DataBinder.Eval( Container.DataItem,"slab2") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 3
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab3" Text='<%# DataBinder.Eval( Container.DataItem,"slab3") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 4
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab4" Text='<%# DataBinder.Eval( Container.DataItem,"slab4") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 5
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab5" Text='<%# DataBinder.Eval( Container.DataItem,"slab5") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 6
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab6" Text='<%# DataBinder.Eval( Container.DataItem,"slab6") %>'  Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
             
     <br /><br />
     <font class="bluefnt"><b>AIR - ZONE LISTING</b></font><br />
            <asp:GridView CssClass="boxbg" runat="server" ID="grvairfreightzone" 
                    CellSpacing="1" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                    BorderWidth="0" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                    AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                    OnRowDataBound="grvairfreightzone_RowDataBound">
                    <Columns>

                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                From
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblfrom" Text='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>' Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                To
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblto" Text='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>' Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Transit Days
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lbltransit" Text='<%# DataBinder.Eval( Container.DataItem,"trdays") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Rate Type
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblratetype" Text='<%# DataBinder.Eval( Container.DataItem,"ratetype") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 1
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab1" Text='<%# DataBinder.Eval( Container.DataItem,"slab1") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 2
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab2" Text='<%# DataBinder.Eval( Container.DataItem,"slab2") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 3
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab3" Text='<%# DataBinder.Eval( Container.DataItem,"slab3") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 4
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab4" Text='<%# DataBinder.Eval( Container.DataItem,"slab4") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 5
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab5" Text='<%# DataBinder.Eval( Container.DataItem,"slab5") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 6
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab6" Text='<%# DataBinder.Eval( Container.DataItem,"slab6") %>'  Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
             
             
 <br /><br />
     <font class="bluefnt"><b>TRAIN - ZONE LISTING</b></font><br />
            <asp:GridView CssClass="boxbg" runat="server" ID="grvtrainfreightzone" 
                    CellSpacing="1" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                    BorderWidth="0" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                    AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                    OnRowDataBound="grvtrainfreightzone_RowDataBound">
                    <Columns>

                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                From
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblfrom" Text='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>' Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                To
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblto" Text='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>' Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Transit Days
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lbltransit" Text='<%# DataBinder.Eval( Container.DataItem,"trdays") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Rate Type
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblratetype" Text='<%# DataBinder.Eval( Container.DataItem,"ratetype") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 1
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab1" Text='<%# DataBinder.Eval( Container.DataItem,"slab1") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 2
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab2" Text='<%# DataBinder.Eval( Container.DataItem,"slab2") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 3
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab3" Text='<%# DataBinder.Eval( Container.DataItem,"slab3") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 4
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab4" Text='<%# DataBinder.Eval( Container.DataItem,"slab4") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 5
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab5" Text='<%# DataBinder.Eval( Container.DataItem,"slab5") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 6
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab6" Text='<%# DataBinder.Eval( Container.DataItem,"slab6") %>'  Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
             
             
             
             <%--CITY FILLING--%>
             
              <%--ZONE FILLING--%>
   <br /><br />
     <font class="bluefnt"><b>RAOD - CITY LISTING</b></font><br />
            <asp:GridView CssClass="boxbg" runat="server" ID="grvroadfreightcity" 
                    CellSpacing="1" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                    BorderWidth="0" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                    AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                    OnRowDataBound="grvroadfreightcity_RowDataBound">
                    <Columns>

                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                From
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblfrom" Text='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>' Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                To
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblto" Text='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>' Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Transit Days
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lbltransit" Text='<%# DataBinder.Eval( Container.DataItem,"trdays") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Rate Type
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblratetype" Text='<%# DataBinder.Eval( Container.DataItem,"ratetype") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 1
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab1" Text='<%# DataBinder.Eval( Container.DataItem,"slab1") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 2
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab2" Text='<%# DataBinder.Eval( Container.DataItem,"slab2") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 3
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab3" Text='<%# DataBinder.Eval( Container.DataItem,"slab3") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 4
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab4" Text='<%# DataBinder.Eval( Container.DataItem,"slab4") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 5
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab5" Text='<%# DataBinder.Eval( Container.DataItem,"slab5") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 6
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab6" Text='<%# DataBinder.Eval( Container.DataItem,"slab6") %>'  Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
   
   
    <br /><br />
     <font class="bluefnt"><b>EXPRESS - CITY LISTING</b></font><br />
            <asp:GridView CssClass="boxbg" runat="server" ID="grvexpressfreightcity" 
                    CellSpacing="1" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                    BorderWidth="0" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                    AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                    OnRowDataBound="grvexpressfreightcity_RowDataBound">
                    <Columns>

                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                From
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblfrom" Text='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>' Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                To
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblto" Text='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>' Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Transit Days
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lbltransit" Text='<%# DataBinder.Eval( Container.DataItem,"trdays") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Rate Type
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblratetype" Text='<%# DataBinder.Eval( Container.DataItem,"ratetype") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 1
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab1" Text='<%# DataBinder.Eval( Container.DataItem,"slab1") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 2
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab2" Text='<%# DataBinder.Eval( Container.DataItem,"slab2") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 3
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab3" Text='<%# DataBinder.Eval( Container.DataItem,"slab3") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 4
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab4" Text='<%# DataBinder.Eval( Container.DataItem,"slab4") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 5
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab5" Text='<%# DataBinder.Eval( Container.DataItem,"slab5") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 6
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab6" Text='<%# DataBinder.Eval( Container.DataItem,"slab6") %>'  Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
             
     <br /><br />
     <font class="bluefnt"><b>AIR - CITY LISTING</b></font><br />
            <asp:GridView CssClass="boxbg" runat="server" ID="grvairfreightcity" 
                    CellSpacing="1" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                    BorderWidth="0" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                    AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                    OnRowDataBound="grvairfreightcity_RowDataBound">
                    <Columns>

                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                From
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblfrom" Text='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>' Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                To
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblto" Text='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>' Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Transit Days
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lbltransit" Text='<%# DataBinder.Eval( Container.DataItem,"trdays") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Rate Type
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblratetype" Text='<%# DataBinder.Eval( Container.DataItem,"ratetype") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 1
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab1" Text='<%# DataBinder.Eval( Container.DataItem,"slab1") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 2
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab2" Text='<%# DataBinder.Eval( Container.DataItem,"slab2") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 3
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab3" Text='<%# DataBinder.Eval( Container.DataItem,"slab3") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 4
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab4" Text='<%# DataBinder.Eval( Container.DataItem,"slab4") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 5
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab5" Text='<%# DataBinder.Eval( Container.DataItem,"slab5") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 6
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab6" Text='<%# DataBinder.Eval( Container.DataItem,"slab6") %>'  Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
             
             
 <br /><br />
     <font class="bluefnt"><b>TRAIN - CITY LISTING</b></font><br />
            <asp:GridView CssClass="boxbg" runat="server" ID="grvtrainfreightcity" 
                    CellSpacing="1" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                    BorderWidth="0" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                    AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                    OnRowDataBound="grvtrainfreightcity_RowDataBound">
                    <Columns>

                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                From
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblfrom" Text='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>' Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                To
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblto" Text='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>' Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Transit Days
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lbltransit" Text='<%# DataBinder.Eval( Container.DataItem,"trdays") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Rate Type
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblratetype" Text='<%# DataBinder.Eval( Container.DataItem,"ratetype") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 1
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab1" Text='<%# DataBinder.Eval( Container.DataItem,"slab1") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 2
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab2" Text='<%# DataBinder.Eval( Container.DataItem,"slab2") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 3
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab3" Text='<%# DataBinder.Eval( Container.DataItem,"slab3") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 4
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab4" Text='<%# DataBinder.Eval( Container.DataItem,"slab4") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 5
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab5" Text='<%# DataBinder.Eval( Container.DataItem,"slab5") %>' Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Slab 6
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblslab6" Text='<%# DataBinder.Eval( Container.DataItem,"slab6") %>'  Style="text-align: right;" Width="50px" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
   
</div>            
 </asp:Content>
