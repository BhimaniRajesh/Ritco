<%@ Page Language="C#" AutoEventWireup="true"   MasterPageFile="~/GUI/MasterPage.master"  CodeFile="ViewPendingTask.aspx.cs" Inherits="GUI_Fleet_Job_ViewPendingTask" %>
 
 <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >
 
 <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" style="height: 26px">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">View Pending Task</asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
        </tr>
    </table>
    <br/>
    <br/>
       
       <table  align="center"  width="80%"   border="0" cellpadding="0" cellspacing="0"  >
                                                                      
                                             
                                     <tr bgcolor="white">
                        <td colspan="2">
                           <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                        
                        
                             <asp:GridView id="GridView1" runat="server"  CellSpacing="1" BorderColor="#8BA0E5" BorderWidth="1px"  
                              CssClass="dgRowStyle"  HeaderStyle-CssClass="dgHeaderStyle" PageSize="1000" EmptyDataText="No Records Found" 
                              AutoGenerateColumns="False" CellPadding="2" BackColor="White"    
                             Width="100%" Height="1px"  >
                                <FooterStyle BackColor="#8BA0E5" ForeColor="#003399"    />
                                
                              
                                <Columns>
                                         <asp:BoundField DataField="Job_Order_No" HeaderText="Job Order No">
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                   
                                    </asp:BoundField>
                                    
                                      
                                    
                                        <asp:BoundField DataField="taskcd" HeaderText="Taskcode">
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                   
                                    </asp:BoundField>
                                    
                                    
                                    
                                    <asp:BoundField DataField="TaskDesc" HeaderText=" Task Description">
                                    
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    
                                    </asp:BoundField>
                                
                                    
                                    
                                      <asp:BoundField DataField="Remarks" HeaderText="Remarks">
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:BoundField>
        	                     
	                                                                                              
	                         	            
	                            </Columns>
	                        </asp:GridView>
	                        
	                        
	                         </ContentTemplate>
	                         
	                
                            </asp:UpdatePanel>
	                        
	                        
	                    		               </td>
                    </tr>
                    
                    
                  
                    
            </table>  
            <br/>
            
            

 <%-- <table  align="center"   style="width: 80%"     >    
                       
                       <tr style="background-color: white" align="center">
                          <td  align="center" colspan="2">
                           <asp:Button ID="cmdSubmit" runat="server" Text="Generate Job Order" OnClick="cmdSubmit_Click"    /> 
                       </td>
                      </tr>
                     </table>
   --%>


         </asp:Content>
       
       
       
   
