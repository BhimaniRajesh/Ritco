<%@ Page Language="C#" AutoEventWireup="true"   CodeFile="FinalizeTask.aspx.cs" Inherits="GUI_Fleet_Job_FinalizeTask" %>

<%-- <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >  MasterPageFile="~/GUI/MasterPage.master"     --%>
 
  <head id="Head1" runat="server">
    <title>View Task List</title>
    <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
    
    
    </head>
    <html>
    
    
    <body >
 
    <form id="form1" runat="server">
   
    
    <div>
    
     <br/>
       
      <script language="javascript" type="text/javascript">  
 function check()
 
 {
 
 alert("Task Submitted");
 window.close();
 
 
 
 }
 
 
 </script>
  
  
  
<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" style="height: 26px">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Genarate PM Schedule</asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
            
             
            
        </tr>
    </table>
    <br/>
    <br/>
    
    
    <table   width="70%" align="center">
       
            
            <tr class="bgbluegrey">
                <td colspan="4" align="center">
                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Task List"></asp:Label>
                    
                    </td>
                           
                    
            </tr>
            
            
              
            <tr style="background-color: white">
                <td colspan="4" align="center">
               
                         
                             <asp:GridView id="DataGrid1"  runat="server" PageSize="10"  EmptyDataText="No Records Found.."   AutoGenerateColumns="False" CellPadding="2" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CssClass="blackfnt" CellSpacing="1" Width="100%" Height="1px"   Font-Size="10" OnRowDataBound="DataGrid1_RowDataBound" >
                                <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />

		                             

                                <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"/>
                                <Columns >
                                
                                
                                 <asp:TemplateField HeaderText="Select" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate  >
                                                                  <asp:CheckBox ID="chkSelect" runat="server"   />
                                                            </ItemTemplate>
                                                          
                                                        </asp:TemplateField>
                                
                                
                                    <asp:TemplateField HeaderText="Task Code" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate  >
                                                                  <asp:Label ID="lblTaskCd"   runat="server" CssClass="bleckfnt"  ></asp:Label>
                                                            </ItemTemplate>
                                                          
                                                        </asp:TemplateField>
                                                        
                                                            <asp:TemplateField HeaderText="Task Description" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate  >
                                                                  <asp:Label ID="lblTaskDesc" runat="server" CssClass="bleckfnt"  ></asp:Label>
                                                            </ItemTemplate>
                                                          
                                                        </asp:TemplateField>
                                                        
                                                        
                                                        
                                                            <asp:TemplateField HeaderText="Task  Type" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate  >
                                                                  <asp:Label ID="lblTaskType" runat="server"  CssClass="bleckfnt" ></asp:Label>
                                                            </ItemTemplate>
                                                          
                                                        </asp:TemplateField>
                                                        
                                                        
                                                             
                                
                             
                             
                                
	                            </Columns>
	                        </asp:GridView>&nbsp;
		             
          </td>
          </tr>
          </table>
          
         <br/>
       
    
      <table   cellpadding="0" cellspacing="0"  width="100%">
                    <tr bgcolor="white">
                        <td style="height:19px" align="center">
    
    
    
    <asp:Button ID="btnSubmit" runat="server" Text="Submit"   OnClientClick="javascript:check()" OnClick="btnSubmit_Click"  Visible="false"  />&nbsp;&nbsp;
    <%--  
       <INPUT style="Z-INDEX: 104; width: 49px; left: 466px; top: 304px;"  visible="false" type="button" value="Next"
				onclick="Done();" tabIndex="2" id="Button1" />--%>
      
      
    </td>
    </tr>
    </table>
    
    
<%--    </asp:Content>--%>



 </div>
        </form>
        
        
        </body>
        </html>
