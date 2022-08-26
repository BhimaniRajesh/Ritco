<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ViewCustomerContractStep3.aspx.cs" Inherits="ViewCustomerContractStep3" EnableEventValidation="false" %>
<%@ OutputCache Location="none" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
  <br />
 <font class="blackfnt"><b><u>Customer Contract</u> >> <font class="bluefnt"><b>Single Slab Matrices - Sundry</b></font></b></font>
 <br /><br />
 <font class="blackfnt"><b><u>Custumer Code : </u></b></font><asp:Label ID="lblcustcode" runat="server" Font-Bold="true" CssClass="bluefnt"></asp:Label>
  <br /><br />
    
    <div style="width:10in;">
    <font class="blackfnt">Rate Type : </font><asp:Label ID="lblratetype" CssClass="blackfnt" runat="server"></asp:Label>
    
            <font class="bluefnt"><b>BRANCH LISTING</b></font><br />
            <asp:GridView CssClass="boxbg" runat="server" ID="grvbranch" 
                    CellSpacing="1" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                    BorderWidth="0" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                    AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                    OnRowDataBound="grvbranch_RowDataBound">
                    <Columns>
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" BackColor="#d4e0e7" Font-Bold="true" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                From
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label  ID="lblfrom" Text='<%# DataBinder.Eval( Container.DataItem,"fromlocode") %>' Style="text-align: right;" runat="server"></asp:Label>  
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                To
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label  ID="lblto" Text='<%# DataBinder.Eval( Container.DataItem,"tolocode") %>' Style="text-align: right;" runat="server"></asp:Label>  
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Air
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label  ID="lblairrate" Text='<%# DataBinder.Eval( Container.DataItem,"air_rate") %>' Style="text-align: right;" runat="server"></asp:Label>  
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Transit Days
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label  ID="lblairtransit" Text='<%# DataBinder.Eval( Container.DataItem,"air_days") %>' Style="text-align: right;" runat="server"></asp:Label>  
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Road
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                              <asp:Label  ID="lblroadrate" Text='<%# DataBinder.Eval( Container.DataItem,"road_rate") %>' Style="text-align: right;" runat="server"></asp:Label>  
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Transit Days
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label  ID="lblroadtransit" Text='<%# DataBinder.Eval( Container.DataItem,"road_days") %>' Style="text-align: right;" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Train
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label  ID="lbltrainrate" Text='<%# DataBinder.Eval( Container.DataItem,"train_rate") %>' Style="text-align: right;" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Transit Days
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label  ID="txttraintransit" Text='<%# DataBinder.Eval( Container.DataItem,"train_days") %>' Style="text-align: right;" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Express
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblexpressrate"  Text='<%# DataBinder.Eval( Container.DataItem,"express_rate") %>' Style="text-align: right;" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Transit Days
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblexpresstransit" Text='<%# DataBinder.Eval( Container.DataItem,"express_days") %>' Style="text-align: right;" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <br />
                
<%--=======================================   ZONE LISTING   ========================================--%>
                <font class="bluefnt"><b>ZONE LISTING</b></font><br />
                <asp:GridView CssClass="boxbg" runat="server" ID="grvzone" 
                    CellSpacing="1" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                    BorderWidth="0" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                    AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                    OnRowDataBound="grvzone_RowDataBound">
                    <Columns>
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                From
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label  ID="lblfrom" Text='<%# DataBinder.Eval( Container.DataItem,"fromregion") %>' Style="text-align: right;" runat="server"></asp:Label>  
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                To
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label  ID="lblto" Text='<%# DataBinder.Eval( Container.DataItem,"toregion") %>' Style="text-align: right;" runat="server"></asp:Label>  
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Air
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label  ID="lblairrate" Text='<%# DataBinder.Eval( Container.DataItem,"air_rate") %>' Style="text-align: right;" runat="server"></asp:Label>  
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Transit Days
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label  ID="lblairtransit" Text='<%# DataBinder.Eval( Container.DataItem,"air_days") %>' Style="text-align: right;" runat="server"></asp:Label>  
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Road
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                              <asp:Label  ID="lblroadrate" Text='<%# DataBinder.Eval( Container.DataItem,"road_rate") %>' Style="text-align: right;" runat="server"></asp:Label>  
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Transit Days
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label  ID="lblroadtransit" Text='<%# DataBinder.Eval( Container.DataItem,"road_days") %>' Style="text-align: right;" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Train
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label  ID="lbltrainrate" Text='<%# DataBinder.Eval( Container.DataItem,"train_rate") %>' Style="text-align: right;" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Transit Days
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label  ID="txttraintransit" Text='<%# DataBinder.Eval( Container.DataItem,"train_days") %>' Style="text-align: right;" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Express
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblexpressrate"  Text='<%# DataBinder.Eval( Container.DataItem,"express_rate") %>' Style="text-align: right;" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Transit Days
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblexpresstransit" Text='<%# DataBinder.Eval( Container.DataItem,"express_days") %>' Style="text-align: right;" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <br />
                
                
                       
<%--=======================================   CITY LISTING   ========================================--%>
    
                <font class="bluefnt"><b>CITY LISTING</b></font><br />
                <asp:GridView CssClass="boxbg" runat="server" ID="grvcity" 
                    CellSpacing="1" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                    BorderWidth="0" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                    AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                    OnRowDataBound="grvcity_RowDataBound">
                    <Columns>
                      
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                From
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label  ID="lblfrom" Text='<%# DataBinder.Eval( Container.DataItem,"fromcity") %>' Style="text-align: right;" runat="server"></asp:Label>  
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                To
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label  ID="lblto" Text='<%# DataBinder.Eval( Container.DataItem,"tocity") %>' Style="text-align: right;" runat="server"></asp:Label>  
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Air
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label  ID="lblairrate" Text='<%# DataBinder.Eval( Container.DataItem,"air_rate") %>' Style="text-align: right;" runat="server"></asp:Label>  
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Transit Days
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label  ID="lblairtransit" Text='<%# DataBinder.Eval( Container.DataItem,"air_days") %>' Style="text-align: right;" runat="server"></asp:Label>  
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Road
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                              <asp:Label  ID="lblroadrate" Text='<%# DataBinder.Eval( Container.DataItem,"road_rate") %>' Style="text-align: right;" runat="server"></asp:Label>  
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Transit Days
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label  ID="lblroadtransit" Text='<%# DataBinder.Eval( Container.DataItem,"road_days") %>' Style="text-align: right;" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Train
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label  ID="lbltrainrate" Text='<%# DataBinder.Eval( Container.DataItem,"train_rate") %>' Style="text-align: right;" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Transit Days
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label  ID="txttraintransit" Text='<%# DataBinder.Eval( Container.DataItem,"train_days") %>' Style="text-align: right;" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Express
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblexpressrate"  Text='<%# DataBinder.Eval( Container.DataItem,"express_rate") %>' Style="text-align: right;" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField>
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" BackColor="#d4e0e7" Wrap="False" CssClass="blackfnt" />
                            <HeaderTemplate>
                                Transit Days
                            </HeaderTemplate>
                            <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblexpresstransit" Text='<%# DataBinder.Eval( Container.DataItem,"express_days") %>' Style="text-align: right;" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <br />
                
    </div>
</asp:Content>
