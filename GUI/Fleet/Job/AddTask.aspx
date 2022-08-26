<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master"      CodeFile="AddTask.aspx.cs" Inherits="GUI_Job_AddTask" %>

 
 
 
  
 
 
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

 



  <table  align="center" cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Work Group Master>>Add Tasks</asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
                   <td align="right">
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                    <font class="blackfnt" color="red"><b>Please wait...</b></font>
            </ProgressTemplate>
          </asp:UpdateProgress>  
         
          </td>      
            
            
            
        </tr>
    </table>
    <br/>
    <br/>
    
         <table cellspacing="1"  align="center" cellpadding="3" width="70%" >
     <tr>
     <td>
        <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                    <ContentTemplate>
    
     <table cellspacing="1"  align="center" width="40%"   >
     
     
                           <tr align="center"   style="background-color: white" width="70%" >
                           <td  align="right" colspan="1">
                 <font class="bluefnt">Enter no. of rows </font>&nbsp;&nbsp;</td>
                 <td align="left" txtRow>
                 <asp:TextBox ID="txtRow" runat="server" MaxLength="10" Width="30" BorderStyle="Groove"  Text="0" AutoPostBack="true" OnTextChanged="txtRow_TextChanged"></asp:TextBox>
              	                                                                   <asp:RegularExpressionValidator ID="RegtxtRow" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtRow" Display="Dynamic"></asp:RegularExpressionValidator>
              
                   <%--  <asp:RangeValidator ID="RangeValidator1" runat="server"  ControlToValidate="txtRow" MinimumValue="0" MaximumValue="25" SetFocusOnError="true"  ErrorMessage="*"></asp:RangeValidator>
              --%>
              
                 </td>
                 </tr>
      </table>
     
     <br />
     
     
     <table cellspacing="1"  align="center" cellpadding="3" width="70%" >
     
       
            <tr class="bgbluegrey">
                <td colspan="2" align="center">
                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true"  ></asp:Label></td>
            </tr>
            <tr   style="background-color:White">
            <td colspan="2" >
            
            
             <asp:datagrid id="dgAddTask" runat="server" PageSize="1000"  AutoGenerateColumns="False" CellPadding="2" OnItemCommand="dgAddTask_ItemCommand"       BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CssClass="Styles.css" CellSpacing="1" Width="100%" Height="1px" ItemStyle-HorizontalAlign=Left OnItemDataBound="DataGrid1_ItemDataBound"  >
                                <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />
                                <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
		                                    <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Center" Font-Bold="True" Font-Underline="True" BackColor="#8BA0E5" ForeColor="White" Wrap="False" Mode="NumericPages" CssClass="whitefnt"></PagerStyle>
                                <ItemStyle BackColor="White" ForeColor="#003399" CssClass="blackfnt" HorizontalAlign="Left" />
                                <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"/>
                                <Columns >
	                         	<asp:TemplateColumn HeaderText="Sr.No.">
                                                            <ItemTemplate>
                                                                <center>
                                                                    <%# Container.ItemIndex+1 %>.
                                                                    <asp:Label ID="count" runat="server" Visible="false" Text=' <%# Container.ItemIndex+1 %>'></asp:Label>
                                                                </center>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
        	                      
	                              <asp:TemplateColumn HeaderText="Description">
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtDesc" runat="server" BorderStyle="Groove" Width="350px"  ></asp:TextBox>
	                                    
	                                              <asp:RequiredFieldValidator ID="RFVtxtDesc" runat="server" ControlToValidate="txtDesc"
                        ErrorMessage="*"></asp:RequiredFieldValidator>
	                                    
	                                </ItemTemplate>
                                      <HeaderStyle HorizontalAlign="Left" />
	                              </asp:TemplateColumn>
        	                      
	                               <asp:TemplateColumn HeaderText="Task Type" >
	                                <ItemTemplate>
	                                
	                                
	                              <asp:Label ID="lblTaskType" runat="server"    CssClass="blackfnt"  Visible="false"  ></asp:Label>
	                                    <asp:DropDownList ID="ddlTaskType" runat="server" BorderStyle="Groove"    >
                                                                                   
                                        </asp:DropDownList>
                                                  <asp:RequiredFieldValidator ID="RFVddlTaskType" runat="server" ControlToValidate="ddlTaskType"
                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                        
                                        
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
        	                      
	                                <asp:TemplateColumn HeaderText="Delete">
                          <ItemTemplate>
                            <asp:LinkButton ID="DeleteRow" runat="server" CausesValidation="false">X</asp:LinkButton>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateColumn>          
        	                         	                                              
        	                              	                                                                          
	                         	            
	                            </Columns>
	                        </asp:datagrid>
            
            
            </td>
            </tr>
            
                <tr style="background-color: white">
                            <td colspan="3" align="center">
                             
                                        <asp:Button ID="btnSubmit" runat="server" Text="Submit"   OnClick="btnSubmit_Click"   /> 
                                 
                            </td>
                        </tr>
            
            
            </table>
               </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnSubmit" EventName="Click" />
                                     <asp:AsyncPostBackTrigger ControlID="txtRow" EventName="TextChanged" />
                    </Triggers>
               
                                </asp:UpdatePanel>
            
            <td>
            </tr>
            </table>
            
    
    </asp:Content>
