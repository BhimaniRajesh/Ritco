<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"       CodeFile="Tasks.aspx.cs" Inherits="GUI_Job_Tasks" %>

 
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >

<script language="javascript" type="text/javascript">
        function validFloat(event,txtid)
      {
    var tb=document.getElementById(txtid);
    var txt=tb.value;
    if(event.keyCode==13)
        return true;
        
         if(event.keyCode==46)
          if(txt.indexOf('.')!=-1)
            event.keyCode=0;
        
    if((event.keyCode<46 || event.keyCode>57) || event.keyCode==47)
        {event.keyCode=0;return false;}
     } 

</script>

<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" style="height: 26px">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Tasks Master</asp:Label>
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

     <%-- <table  align="center" cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
        <td align="center" colspan="2">
    
            <asp:UpdatePanel ID="UpdatePanel1" Mode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>   --%>
                    
 <table cellspacing="1" align="left"   style="width: 80%" cellpadding=2>
    <tr><td align="left">
                      
      <table cellspacing="1" align="left"   style="width: 80%">
          <tr align="left" >
            <td  colspan="2" >
                <table cellspacing="1" style="width: 70%">
                    <tr style="background-color: white">
                        <td align="left">
                            <asp:Label ID="lblNew" runat="server" CssClass="blackfnt" Font-Bold="true" Text="New ?? "></asp:Label>
                            <asp:LinkButton ID="lnkCreateWG" runat="server" Text="Create Tasks" CssClass="bluefnt"   PostBackUrl="~/GUI/Fleet/Webadmin/Job/Taskdet.aspx"  ValidationGroup="VGCreate"></asp:LinkButton>    
                        </td>
                    </tr>
                </table>
          
            </td>
        </tr>
        <tr align="left">
            <td>
                <table cellspacing="1" style="width: 70%" class="boxbg" border=0>                                                                    
                        
                        
                                            <tr class="bgbluegrey">
                        <td colspan="2" align="center">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                        </td>
                    </tr>
                
                                           
                         <tr style="background-color: white" >
                                                       
                             <td align="left">
                                 <asp:Label ID="lblWorkGroup" runat="server" Text="Select Group" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td  align="left">
                                &nbsp;<asp:DropDownList ID="ddlWorkGroup" runat="server">
                                 
                             </asp:DropDownList>
                                                    <asp:RequiredFieldValidator ID="reqdlWorkGroup" runat="server" Display="Dynamic" Text="!" ControlToValidate="ddlWorkGroup"></asp:RequiredFieldValidator>
                                </td>
                             
                        </tr>
                                    
                         <tr style="background-color: white" align="center">
                                                     
                             <td align="right" colspan="2" >
                        
                                 <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"    /> 
                        </td>
                        </tr>
                     </table>
                     
           </td>
        </tr>
    
    </table>
    </td></tr>                 
     
     <tr><td align="left"> 
                        
                <table  align="left"     border="0" cellpadding="0" cellspacing="0"  width="85%">
                                                                       
                                              
                                     <tr bgcolor="white">
                        <td colspan="2" style="height: 211px">
                           <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                        
                        
                             <asp:GridView id="dgTask" runat="server"  OnRowCommand="dg_RowCommand" CellSpacing="1" BorderColor="#8BA0E5" BorderWidth="1px"  
                              CssClass="dgRowStyle"  HeaderStyle-CssClass="dgHeaderStyle" PageSize="1000" EmptyDataText="No Records Found" EmptyDataRowStyle-ForeColor="RED" DataKeyNames="w_GRPCD"
                              AutoGenerateColumns="False" CellPadding="2" BackColor="White"    
                             Width="100%" Height="1px"  >
                                <FooterStyle BackColor="#8BA0E5" ForeColor="#003399"    />
                                
                              
                                <Columns>
                                             
                                             
                                             
                                   
                                   
                                    
                                    <asp:BoundField DataField="Desc1" HeaderText="Task Description">
                                    
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    
                                    </asp:BoundField>
                                    
                                    
                                     <asp:BoundField DataField="TaskType" HeaderText="Task Type">
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:BoundField>
                                    
                                     <asp:BoundField DataField="Unit" HeaderText="Unit of Measure">
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:BoundField>
                                    
                                    
                                    <asp:BoundField DataField="SIDays" HeaderText="Service Interval Days">
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SIKMS" HeaderText="Service Interval Kms">
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ANDays" HeaderText="Advance Notification Days">
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ANKms" HeaderText="Advance Notification Kms">
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:BoundField>
     
                                    
                                    
                                      
                                    
	                         	            
	                            </Columns>
                                 <HeaderStyle CssClass="dgHeaderStyle" />
	                        </asp:GridView>
	                        
	                        
	                     <%--   <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="AddTask" runat="server" CausesValidation="False" >Add Task</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                                      <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="ViewTask" runat="server" CausesValidation="False" >View Task</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>
	                        
	                    <%--     </ContentTemplate>
	                         
	                           <Triggers>
                        <asp:ControlEventTrigger ControlID="btnSubmit" EventName="Click" />
                    </Triggers>
	                         
                            </asp:UpdatePanel>--%>
	         
	             </td>
                    </tr>
      
            </table>  
            <br/>
            <br/>
            
            
            
            
                   <table cellspacing="1"  align="center" cellpadding="3" width="70%"  id="table1" visible="false" runat="server">
     <tr>
     <td>

     <table cellspacing="1"  align="center" width="40%" id="table2"  runat="server"   >
     
     
                           <tr align="center"   style="background-color: white" width="70%" >
                           <td  align="right" colspan="1">
                 <font class="bluefnt">Enter no. of rows </font>&nbsp;&nbsp;</td>
                 <td align="left">
                 <asp:TextBox ID="txtRow"   runat="server" MaxLength="10" Width="30"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"   BorderStyle="Groove"  Text="0" AutoPostBack="true" OnTextChanged="txtRow_TextChanged"></asp:TextBox>
              	                       
              
                 </td>
                 </tr>
      </table>
     
     <br />
     
     
     <table   cellspacing="1"  align="center" cellpadding="3" width="70%" >
     
       
            <tr class="bgbluegrey">
                <td colspan="2" align="center">
                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true"  ></asp:Label></td>
            </tr>
            <tr   style="background-color:White">
            <td colspan="2" >
            
            
             <asp:datagrid id="dgAddTask" runat="server" PageSize="1000"  Visible="false"  AutoGenerateColumns="False" CellPadding="2" OnItemCommand="dgAddTask_ItemCommand"       BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CssClass="Styles.css" CellSpacing="1" Width="100%" Height="1px" ItemStyle-HorizontalAlign=Left OnItemDataBound="DataGrid1_ItemDataBound"  >
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
	                        
	                           <asp:GridView id="DataGrid1"  Visible="false"  runat="server" PageSize="10"  EmptyDataText="No Records Found.."   AutoGenerateColumns="False" CellPadding="2" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CssClass="blackfnt" CellSpacing="1" Width="100%" Height="1px"   Font-Size="10" >
                                <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />

		                             

                                <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"/>
                                <Columns >
                                
                                
                        
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
            
                <tr style="background-color: white">
                            <td colspan="3" align="center">
                             
                                        <asp:Button ID="cmdSubmit" runat="server" Text="Submit" Visible="false"  OnClick="cmdSubmit_Click"   /> 
                   
                                <br/>
                                 <asp:Label id="lblMsg"  runat="server"  ForeColor="Blue" Font-Bold="true"  Visible="false" />
                            </td>
                        </tr>
            
            
            </table>
            </td>
            </tr>
            </table>
            
               </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="cmdSubmit" EventName="Click" />
                              
                                 <asp:AsyncPostBackTrigger ControlID="btnSubmit" EventName="Click" />
                                     <asp:AsyncPostBackTrigger ControlID="txtRow" EventName="TextChanged" />
                    </Triggers>
               
                                </asp:UpdatePanel>
            
            </td>
            </tr>
            </table>
            
      </td></tr>
    </table>                    
                        
                        
                        

         </asp:Content>
