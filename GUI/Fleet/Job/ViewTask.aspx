<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewTask.aspx.cs" Inherits="GUI_Fleet_Job_ViewTask" %>
 
 <head id="Head1" runat="server">
    <title>View Task List</title>
    <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
    
    
    </head>
    <html>
    
    
    <body >
 
    <form id="form1" runat="server">
   
    
    <div>
    
     <br/>
        <br/>
           <br/>
              <br/>
    
    <table cellspacing="1" cellpadding="0" width="70%" align="center"  bgcolor="#8BA0E5">
     
     <tr style="background-color: white">
        <td colspan=4 align=left>
           <table cellspacing="1" cellpadding="2" width="100%" align="left" class="boxbg" border="1" bgcolor="#8BA0E5">
                     
            
            <tr class="bgbluegrey">
                <td colspan="4" align="center">
                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Task List"></asp:Label></td>
                           
                    
            </tr>
            
            
              
            <tr style="background-color: white">
                <td colspan=4 align=left>
                <table   cellpadding="0" cellspacing="0"  width="100%">
                    <tr bgcolor="white">
                        <td style="height:19px" align=left>
                             <asp:GridView id="DataGrid1"  runat="server" PageSize="10"  EmptyDataText="No Records Found.."   AutoGenerateColumns="False" CellPadding="2" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CssClass="blackfnt" CellSpacing="1" Width="100%" Height="1px"   Font-Size="10" >
                                <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />

		                             

                                <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"/>
                                <Columns >
                                
                                
                                 <%-- <asp:TemplateColumn HeaderText="Sr.No.">
                                                            <ItemTemplate>
                                                                <center>
                                                                    <%# Container.ItemIndex+1 %>.
                                                                    <asp:Label ID="count" runat="server" Visible="false" Text=' <%# Container.ItemIndex+1 %>'></asp:Label>
                                                                </center>
                                                            </ItemTemplate>
                                                          
                                                        </asp:TemplateColumn>
                                --%>
                                  <asp:BoundField DataField="Taskcd" HeaderText="Task Code" >
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                
                                
                                <asp:BoundField DataField="Taskdesc" HeaderText="Task" >
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                 <asp:BoundField DataField="Task_Type" HeaderText="Task Type">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                             
                                
	                            </Columns>
	                        </asp:GridView>&nbsp;
		               </td>
                    </tr>
            </table>
         </td>
        </tr> 
        
        
        </table>
        
        </div>
        </form>
        
        
        </body>
        </html>
        
