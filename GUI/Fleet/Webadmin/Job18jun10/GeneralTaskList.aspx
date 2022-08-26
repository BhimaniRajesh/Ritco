<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"       CodeFile="GeneralTaskList.aspx.cs" Inherits="GUI_Job_Tasks" %>

 
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
    
            <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" RenderMode="Inline" runat="server">
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
                            <asp:LinkButton ID="lnkCreateWG" runat="server" Text="Create General Tasks" CssClass="bluefnt"   PostBackUrl="~/GUI/Fleet/Webadmin/Job/GeneralTaskMst.aspx"  ValidationGroup="VGCreate"></asp:LinkButton>    
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
                        
                        <%--OnRowCommand="dg_RowCommand"--%>
                             <asp:GridView id="dgGenTask" runat="server"   CellSpacing="1" BorderColor="#8BA0E5" BorderWidth="1px"  
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
                                    
                                     <asp:BoundField DataField="LABOUR_HRS" HeaderText="Estimated Labour Hrs.">
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:BoundField>
                                    
                                  
                                    <asp:BoundField DataField="ACTIVE_FLAG" HeaderText="Active Flag">
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:BoundField>
     
                                     <asp:BoundField DataField="ENTRY_DT" HeaderText="Entry Date">
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
                        <asp:AsyncPostBackTrigger ControlID="btnSubmit" EventName="Click" />
                    </Triggers>
	                         
                            </asp:UpdatePanel>--%>
	         
	             </td>
                    </tr>
      
            </table>  
            <br/>
            <br/>
            
            
            
            
               </ContentTemplate>
<%--                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="cmdSubmit" EventName="Click" />
                              
                                 <asp:AsyncPostBackTrigger ControlID="btnSubmit" EventName="Click" />
                                     <asp:AsyncPostBackTrigger ControlID="txtRow" EventName="TextChanged" />
                    </Triggers>
               --%>
                                </asp:UpdatePanel>
            
            </td>
            </tr>
            </table>
            
      </td></tr>
    </table>                    
                        
                        
                        

         </asp:Content>
