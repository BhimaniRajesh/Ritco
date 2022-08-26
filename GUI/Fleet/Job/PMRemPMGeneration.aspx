<%@ Page Language="C#" AutoEventWireup="true"    MasterPageFile="~/GUI/MasterPage.master"  CodeFile="PMRemPMGeneration.aspx.cs" Inherits="GUI_Fleet_Job_PMRemPMGeneration" %>





<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >

<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" style="height: 26px">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">PM Remainders & Generation of PM Job Order>PM Job Order Generation</asp:Label>
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
 
     <table cellspacing="1" width="70%" align="center">
       
                     <tr style="background-color: white" align="center">
                          <td  align="center"  >
    
         <asp:UpdatePanel ID="UpdatePanel4" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate> 
    <table  align="center"  cellspacing="2" width="100%" >                                                                    
                                         
                        <tr  align="center"  style="background-color: white">
               
                <td align="center" >

                    
     <table  align="center"  cellspacing="2" width="100%" class="boxbg">                                                                    
                           
                           
                                          
                        
                                <tr class="bgbluegrey">
                        <td colspan="4" align="center">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">PM JOB Order Genaration</asp:Label>
                        </td>
                    </tr>
                           
                
                           
                                          
                        <tr style="background-color: white">
               
                <td align="left" >
                    <asp:Label ID="Label4" runat="server" CssClass="bluefnt"   Text="Vehicle No."></asp:Label>
                                         
                </td>
                <td align="left" >&nbsp;
                <asp:Label ID="lblVehicleNo" runat="server" CssClass="blackfnt" >
                    </asp:Label>&nbsp;&nbsp;     

                               
                              
            
                    
                </td>
            
                                                       
                             <td align="left" >
                                 <asp:Label ID="Label1" runat="server" Text="Vehicle Category" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td  align="left">
                                &nbsp;<asp:Label ID="lblCategory" runat="server" CssClass="blackfnt">
                                 
                             </asp:Label>
                                </td>
                             
                        </tr>
                                                
                          <tr style="background-color: white" align="center">
                                                      
                             <td align="left"  >
                                 <asp:Label ID="Label2" runat="server" Text="Manufacturer" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
                                &nbsp;<asp:Label ID="lblMfg" runat="server" CssClass="blackfnt">
                                 
                             </asp:Label>
                                </td>
                                                    
                                      <td align="left" >
                                 <asp:Label ID="Label3" runat="server" Text="Model" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
                                &nbsp;<asp:Label ID="lblModel" runat="server" CssClass="blackfnt">
                                 
                             </asp:Label>
                                </td>
                             
                        </tr>
                        
                        
                        <tr style="background-color: white" align="center">
                                                    
                             <td align="left"  >
                                 <asp:Label ID="Label5" runat="server" Text="Work Order No" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >&nbsp;
                           <asp:Label ID="lblWONo" runat="server" CssClass="redfnt" Text="System Generated" ></asp:Label>
                                 
                             
                                </td>
                                                   
                                      <td align="left" >
                                 <asp:Label ID="Label7" runat="server" Text="Date" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
                                &nbsp;<asp:Label ID="lblDate" runat="server" CssClass="blackfnt">
                                 
                             </asp:Label>
                                </td>
                             
                        </tr>
                        
                          <tr style="background-color: white" align="center">
                                                    
                             <td align="left"  >
                                 <asp:Label ID="Label9" runat="server" Text="Order Type" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
                                &nbsp;<asp:Label ID="lblOrderType" runat="server" CssClass="blackfnt">
                                     
                                 
                             </asp:Label>
                                </td>
                                                   
                                      <td align="left" >
                                 <asp:Label ID="Label11" runat="server" Text="Order Status" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
                                &nbsp;<asp:Label ID="lblOrderStatus" runat="server" CssClass="blackfnt">
                                 
                             </asp:Label>
                                </td>
                             
                        </tr>
                        
                        
                          <tr style="background-color: white" align="center">
                                                    
                             <td align="left"  >
                                 <asp:Label ID="Label13" runat="server" Text="Service Centre Type " CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
                                &nbsp;<asp:DropDownList ID="ddlSCtype" runat="server" AutoPostBack="true" CssClass="blackfnt"   OnSelectedIndexChanged="ddlSCtype_SelectedIndexChanged" >
                                          <asp:ListItem Value="" Selected="true">Select</asp:ListItem>
                                    
                                    
                                    <asp:ListItem Value="Workshop">Workshop</asp:ListItem>
                                    <asp:ListItem Value="Vendor">Vendor</asp:ListItem> 
                                          
                                                               
                             </asp:DropDownList>
                                </td>
                                                   
                                      <td align="left" >
                                 <asp:Label ID="lblVendorHead" runat="server" Text="Vendor Name" CssClass="bluefnt" Visible="false"  ></asp:Label>
                              &nbsp;
                                <asp:Label ID="lblWLocHead" runat="server" Text="Workshop Location" CssClass="bluefnt" Visible="false"  ></asp:Label>
                                </td>
                            <td align="left" >
                                &nbsp;<asp:DropDownList ID="ddlVendor" runat="server" CssClass="blackfnt" Visible="false">
                                                              </asp:DropDownList>
                                                              <asp:DropDownList ID="ddlWLoc" runat="server" CssClass="blackfnt" Visible="false">
                                 
                             </asp:DropDownList>
                                                              
                                                              
                                </td>
                             
                        </tr>
                        
                        <tr style="background-color: white" align="center">
                                                    
                            <%-- <td align="left"  >
                                 <asp:Label ID="Label10" runat="server" Text="Workshop Location" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
                                &nbsp;<asp:DropDownList ID="ddlWLoc" runat="server" CssClass="blackfnt">
                                 
                             </asp:DropDownList>--%>
                                </td>
                                                   
                                      <td align="left" >
                                 <asp:Label ID="Label18" runat="server" Text="KM Reading" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" colspan="3" >
                                &nbsp;<asp:Label ID="lblKMReading"  Text="0"   Width="100px"  runat="server" CssClass="blackfnt"   >
                                 
                             </asp:Label>
                             
                                
                             
                                </td>
                                        </tr>
                       
                                                   
                     
                     </table>
                     <br/>
                     
                     <table cellspacing="1" width="100%">
                     
                     
                             <tr class="bgbluegrey"  >
                        <td  align="center">
                            <asp:Label ID="Label6" CssClass="blackfnt" Font-Bold="true" runat="server">Task Details</asp:Label>
                        </td>
                    </tr>
                                   
                     
            <tr align="center"   >
              <td align="center">
                 
                        <asp:GridView ID="GridView1" runat="server" AllowPaging="True"    OnRowDataBound="GridView1_RowDataBound"
                            AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5"
                            CellSpacing="1" CssClass="dgRowStyle" EmptyDataText="No Records Found..."
                            HeaderStyle-CssClass="dgHeaderStyle" PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
                            PageSize="10"   >
                            <Columns>
 
                      <%--<asp:BoundField DataField="W_GRPDESC" HeaderText="Work Group Code &amp; Description">
                             
                                </asp:BoundField> 
                               
 
                             <asp:BoundField DataField="TASKCD" HeaderText="Task Code">
                                                             </asp:BoundField> 
                                <asp:BoundField DataField="TASKDESC" HeaderText="Task Description">
              
                                </asp:BoundField>
                                <asp:BoundField DataField="TaskType" HeaderText="Task Type">
                           
                                </asp:BoundField>--%>
                                 <asp:TemplateField HeaderText="Work Group Code &amp; Description" >
	                                <ItemTemplate>
	                               
	                              <asp:Label ID="lblW_GRPCD"   EnableViewState="true"     runat="server"    CssClass="blackfnt"   ></asp:Label>
	                         
	                                </ItemTemplate>
	                              </asp:TemplateField>
                                
                                
                                 <asp:TemplateField HeaderText="Task Code " >
	                                <ItemTemplate>
	                               
	                              <asp:Label ID="lblTaskCode"       runat="server"  EnableViewState="true"   CssClass="blackfnt"   ></asp:Label>
	                         	                                </ItemTemplate>
	                              </asp:TemplateField>
	                              
	                               <asp:TemplateField HeaderText="Task Description" >
	                                <ItemTemplate>
	                               
	                              <asp:Label ID="lblTaskDesc"   EnableViewState="true"    runat="server"    CssClass="blackfnt"  ></asp:Label>
	                                                
	                                </ItemTemplate>
	                              </asp:TemplateField>
	                              
	                               <asp:TemplateField HeaderText="Task Type" >
	                                <ItemTemplate>
	                               
	                              <asp:Label ID="lblTaskType"    runat="server"  EnableViewState="true"   CssClass="blackfnt"   ></asp:Label>
	                        
	                                </ItemTemplate>
	                              </asp:TemplateField>
	                              
                          
                          
                           <asp:TemplateField   HeaderText="Remarks" >
	                                <ItemTemplate>
	                               
	                              <asp:TextBox ID="txtRemarks"    runat="server"  Width="100px" CssClass="input" BorderStyle="Groove"    ></asp:TextBox>
                           
	                                </ItemTemplate>
	                              </asp:TemplateField>
   
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                   
            </td>
        </tr> 
    </table>
    <br/>
    
      <table  align="center" cellspacing="1" width="100%">
                     
                     
                     <tr style="background-color:White">
                     <td>
                     
                        <asp:Button ID="cmdSubmit" runat="server" Text="Submit" OnClick="cmdSubmit_Click"   /> 
                     </td>
                     </tr>
                     </table>
    
    
    
    
    
    
    
    </ContentTemplate>
                   <%-- <Triggers>
                    
                                         <asp:ControlEventTrigger ControlID="txtVehicleNo" EventName="TextChanged" />
                     <asp:ControlEventTrigger ControlID="ddlSCtype" EventName="SelectedIndexChanged" />
                   
                        <asp:ControlEventTrigger ControlID="btnSubmit" EventName="Click" />
                    </Triggers>--%>
                        </asp:UpdatePanel>
    
    
    
    </td>
    </tr>
    </table>
    
    
    
    
    
    <br/>
    
    
    
    
    </asp:Content>
