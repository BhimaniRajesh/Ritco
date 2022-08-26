<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="update_Manual_MR_2.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_2" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

                                 <br />
                                 <br />
                                 
                                  
                                                           <p align="center">
                                                                <label class="blackfnt">
                                                                    <b>
                                                                        You Selected
                                                                        <asp:Label ID="Label1" runat="server" Text="Label" Visible="false"></asp:Label></b></label></p>
                                                  
                                  <table border="0" cellpadding="3" width="565" style="background-color: #808080;" cellspacing="1" align="center" class="boxbg">
                                                                <tr style="background-color: #ffffff" align="center" >
                                                                    <td style="height: 10px">
                                                                    <label class="blackfnt">
                                                                    
                                                                        Date :
                                                                        </label>
                                                                        </td>
                                                                    <td style="height: 10px">
                                                                        <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td>
                                                                </tr>
                                                                    
                                                                     
                                                                </table>
                                                                <br />
                                                                <br />
                                                               
                                                                
                                                                
                                                             
                                                              
                                                                
                                                                
                                                             
                                                                   
                                                                   <%--<asp:UpdatePanel ID="UP1" runat="Server">
                                                                    <ContentTemplate>--%>
                                                                    <asp:GridView ID="GV_Booking" runat="server" align="center" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey" 
                                                         PagerStyle-HorizontalAlign="left" 
                                                             CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"  
                                                             AllowPaging="true" PageSize="25"
                                 
                                                            OnPageIndexChanging="pgChange" AllowSorting="False" 
                                                            AutoGenerateColumns="false"
                                                               PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..." >
                                                                <PagerStyle VerticalAlign="Bottom"/>
                                                               
                                                               
                                                                <Columns>
                                                                 
                                                               <%--   <asp:BoundField  DataField="MRSNO"   ItemStyle-Wrap="False"  HeaderText="MR. No"   > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="20"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>--%>
                                                                             
                                                                             
                                                                                                    <asp:TemplateField HeaderText="MRS NO. " HeaderStyle-Font-Bold="true">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                    <label class="blackfnt">
                                                                                    <asp:HyperLink  Font-Underline="True"  Runat="server"  NavigateUrl='<%#"update_Manual_MR_3.aspx?mrno=" +DataBinder.Eval(Container.DataItem, "mrsno")%>' Text= '<%#DataBinder.Eval(Container.DataItem, "mrsno")%>' ID="Hyperlink3"/>
                                                                                        
                                                                                    </label>
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>    
                                                                  
                                                                  <asp:BoundField  DataField="mrsdt" HeaderStyle-Font-Bold="true"   ItemStyle-Wrap="False"  HeaderText="MR. Date"   > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="20"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                  
                                                                  <asp:BoundField  DataField="ptname"  HeaderStyle-Font-Bold="true"  ItemStyle-Wrap="false"  HeaderText="MR Customer "   > 
                                                                            <HeaderStyle HorizontalAlign="Center"   Width="300"   CssClass="blackfnt" />
                                                                           <ItemStyle     Width="300"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                  
                                                                  <asp:BoundField  DataField="MRSamt" HeaderStyle-Font-Bold="true"  ItemStyle-Wrap="False"  HeaderText="MR Amount "   > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="20"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField> 
                                                                             
                                                                           
                                        <%--<a href="Login_2_2.aspx?strDateRange=" +'<%#Request.QueryString["strDateRange"]%>'>                                   
                                        
                                         <asp:HyperLink  Font-Underline="True"  ForeColor="#000099"  Runat="server"  NavigateUrl='<%#"DetailFlow.aspx?loc=" +DataBinder.Eval(Container.DataItem, "loccode")+"&rep="+"2"+"&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&dttype="+Request.QueryString["DateType"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()%>' Text= '<%#DataBinder.Eval(Container.DataItem, "LEFT_TOTDKTS")%>' ID="Hyperlink2"/>



   <%#DataBinder.Eval(Container.DataItem, "totdkt")%>                                 
                                           <font cssclass="Blackfnt">
                                        </a>--%>
                                        
                                                         
                                                                                    
                                                                                  <%--  <asp:HyperLinkField   DataNavigateUrlFields="mrsno" ControlStyle-Font-Underline="true" DataNavigateUrlFormatString ="DetailFlow.aspx?loc={0}&reppara=1"  DataTextField="mrsno" />
                                                                                  --%>      
                                                                                    
                                 
                                                                       
                                                                                                                            
                                                                                         
                                                                 
                                                                 </Columns>
                                                                 
                                                                
                                              

                                                                </asp:GridView>
                                                               <%-- </ContentTemplate>
                                                                </asp:UpdatePanel>--%>
                                                                
                                                               
                                                                
                                                                
                                                                
                                                                        <asp:Label ID="lblnull" runat="server" Font-Bold="True" Font-Italic="False" Font-Size="Medium"
                                                                            ForeColor="Red" Text="Label" Visible="False"></asp:Label></tr>
                                                               
                                                               <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="Server">
                                                                    <ContentTemplate>--%>
                                                                
                                                              <%--  <table border="0" cellpadding="0" width="565" style="background-color: #808080;" cellspacing="0" align="center" class="boxbg">
                                                                <tr align="center">   
                                                                <td style="background-color: #ffffff">
                                                                
                                                                <asp:LinkButton ID="LinkButton1" OnClick="fst" runat="server" Text="First" >
                                                                </asp:LinkButton>
                                                                </td>                                                             
                                                                <td style="background-color: #ffffff">
                                                                
                                                                <asp:LinkButton ID="LinkButton2" OnClick="lst" runat="server" Text="Last">
                                                                </asp:LinkButton>
                                                                </td>
                                                                
                                                                </tr>
                                                                 <tr align="center" style="background-color: #ffffff">
			                                                    <asp:Button   class="btncolor"   runat="server" id="Button1" onclick="Button1_Click" /></tr>
                                                                </table>--%>
                                                               
                                                                
                                                            
                                                            
                                                       
                                      
    
    

</asp:Content>
