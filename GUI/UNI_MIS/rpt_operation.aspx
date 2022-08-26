<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master"  AutoEventWireup="true" CodeFile="rpt_operation.aspx.cs" Inherits="GUI_UNI_MIS_rpt_operation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <div>
       <br />
           <asp:GridView  align="center" ID="Register" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
                            AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left" 
                              CssClass="boxbg"     BackColor="white" FooterStyle-CssClass="boxbg"                      
                            PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" 
                           
                             
                             EmptyDataText="No Records Found..." Width="700px"   >
                            <Columns >
                                 <asp:TemplateField   HeaderStyle-Width="50" HeaderText="SR.NO." >
                                 <ItemTemplate>
                                 <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                                 </asp:Label>
                                 </ItemTemplate>
                                     <HeaderStyle CssClass="blackfnt"  />
                                 </asp:TemplateField>              
                        
                         
                                                            
                                <asp:TemplateField  HeaderText="Accounts">
                               
                                    <ItemTemplate>
                                        <a href='<%#DataBinder.Eval(Container.DataItem, "link_name") %>' >
                                           <font  cssclass="Blackfnt"><%#DataBinder.Eval(Container.DataItem, "Report_name") %>
                                        </a>
                                        <HeaderStyle  CssClass="Blackfnt" />
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="blackfnt" Width="15px" />
                                    </asp:TemplateField>  
                                
                                <asp:BoundField DataField="DISCRIPTION"  HeaderText="Description" > 
                                    <HeaderStyle   Width="400px" HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                </asp:BoundField>
                                
                                </Columns>
                            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                            <HeaderStyle CssClass="bgbluegrey" />
           <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"
                />
           <FooterStyle CssClass="boxbg" />
        </asp:GridView>
        
        <asp:GridView  align="center" ID="Summary" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
                            AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left" 
                              CssClass="boxbg"     BackColor="white" FooterStyle-CssClass="boxbg"                      
                            PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" 
                           
                             
                             EmptyDataText="No Records Found..." Width="700px"   >
                            <Columns >
                                 <asp:TemplateField  HeaderStyle-Width="50" HeaderText="SR.NO." >
                                 <ItemTemplate>
                                 <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                                 </asp:Label>
                                 </ItemTemplate>
                                     <HeaderStyle CssClass="blackfnt"  />
                                 </asp:TemplateField>              
                        
                         
                                                            
                                <asp:TemplateField  HeaderText="Accounts">
                               
                                    <ItemTemplate>
                                        <a href='<%#DataBinder.Eval(Container.DataItem, "link_name") %>' >
                                           <font cssclass="Blackfnt"><%#DataBinder.Eval(Container.DataItem, "Report_name") %>
                                        </a>
                                        <HeaderStyle CssClass="Blackfnt" />
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="blackfnt" Width="15px" />
                                    </asp:TemplateField>  
                                
                                <asp:BoundField DataField="DISCRIPTION"  HeaderText="Description" > 
                                    <HeaderStyle   Width="400px" HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                </asp:BoundField>
                                
                                </Columns>
                            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                            <HeaderStyle CssClass="bgbluegrey" />
           <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"
                />
           <FooterStyle CssClass="boxbg" />
        </asp:GridView>
        
        <asp:GridView  align="center" ID="Accounts" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
                            AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left" 
                              CssClass="boxbg"     BackColor="white" FooterStyle-CssClass="boxbg"                      
                            PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" 
                                                         
                             EmptyDataText="No Records Found..." Width="700px"   >
                            <Columns >
                                 <asp:TemplateField   HeaderStyle-Width="50" HeaderText="SR.NO." >
                                 <ItemTemplate>
                                 <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                                 </asp:Label>
                                 </ItemTemplate>
                                     <HeaderStyle CssClass="blackfnt"  />
                                 </asp:TemplateField>              
                        
                        <asp:TemplateField  HeaderText="Accounts">
                               
                                    <ItemTemplate>
                                        <a href='<%#DataBinder.Eval(Container.DataItem, "link_name") %>' >
                                           <font cssclass="Blackfnt"><%#DataBinder.Eval(Container.DataItem, "Report_name") %>
                                        </a>
                                        <HeaderStyle CssClass="Blackfnt" />
                                    </ItemTemplate>
                            <HeaderStyle CssClass="blackfnt" Width="15px" />
                                    </asp:TemplateField>  
                                                    
                              
                                <asp:BoundField DataField="DISCRIPTION"  HeaderText="Description" > 
                                    <HeaderStyle   Width="400px" HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                </asp:BoundField>
                                
                                </Columns>
                            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                            <HeaderStyle CssClass="bgbluegrey" />
           <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"
                />
           <FooterStyle CssClass="boxbg" />
        </asp:GridView>
    
    </div>

</asp:Content>
