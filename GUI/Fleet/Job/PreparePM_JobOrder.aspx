<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master" CodeFile="PreparePM_JobOrder.aspx.cs" Inherits="GUI_Fleet_Job_PreparePM_JobOrder" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >
 
  <script language="javascript" type="text/javascript">
 
 
    function nwOpen(mNo)
        {
            //window.open("/ERP.NET/GUI/Fleet/Webadmin/Driver/PopupVehicleNo.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
            window.open("Popup-Vehicle.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        
        
        
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
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">PM Job Order Generation</asp:Label>
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
     <table  align="center"  cellspacing="2" width="55%" >                                                                    
                                         
                        <tr  align="center"  style="background-color: white">
               
                <td align="center" >
    <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                    
     <table  align="center"  cellspacing="2" width="100%" class="boxbg">                                                                    
                           
                           
                                          
                        
                           
                               <tr class="bgbluegrey">
                        <td colspan="4" align="center">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Prepare Job Order</asp:Label>
                        </td>
                    </tr>
                           
                                          
                        <tr style="background-color: white">
               
                <td align="left" >
                    <asp:Label ID="Label4" runat="server" CssClass="bluefnt"   Text="Vehicle No."></asp:Label>
                                         
                </td>
                <td align="left" >&nbsp;
                <asp:TextBox ID="txtVehicleNo" runat="server" CssClass="input"   BorderStyle="Groove" AutoPostBack="true" OnTextChanged="txtVehNo_TextChanged">
                    </asp:TextBox>&nbsp;&nbsp;     <asp:Label ID="lblPopup"     runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen(1)">...</a>'
                                Width="14px"> </asp:Label>
                                   &nbsp;<asp:RequiredFieldValidator ID="ReqtxtVehicleNo" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtVehicleNo"></asp:RequiredFieldValidator>
                               
                                <asp:Label ID="lblCheck" runat="server"  ForeColor="red" Visible="false"/>
            
                    
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
                            <td align="left" >
                           <asp:Label ID="lblDriverCodeVal" runat="server" CssClass="redfnt" Text="Sys. Generated"></asp:Label>
                                 
                             
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
                                &nbsp;<asp:DropDownList ID="ddlOrderType" runat="server" CssClass="blackfnt">
                                      <asp:ListItem Value="" Selected="true">Select</asp:ListItem>
                                    
                                    <asp:ListItem Value="Repair/Breakdown">Repair/Breakdown</asp:ListItem>
                                    <asp:ListItem Value="Manual Preventive Maintainence">Manual Preventive Maintainence</asp:ListItem>
                                 
                             </asp:DropDownList>
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
                                &nbsp;<asp:DropDownList ID="ddlSCtype" runat="server"  AutoPostBack="true"   CssClass="blackfnt" OnSelectedIndexChanged="ddlSCtype_SelectedIndexChanged">
                                    
                                     <asp:ListItem Value="" Selected="true">Select</asp:ListItem>
                                    
                                    
                                    <asp:ListItem Value="Workshop">Workshop</asp:ListItem>
                                    <asp:ListItem Value="Vendor">Vendor</asp:ListItem>
                                 
                             </asp:DropDownList>
                                </td>
                                                   
                                      <td align="left" >
                                 <asp:Label ID="lblVendor" runat="server" Text="Vendor Name" CssClass="bluefnt" Visible="false"  ></asp:Label>
                              &nbsp;
                                <asp:Label ID="lblWLoc" runat="server" Text="Workshop Location" CssClass="bluefnt" Visible="false"  ></asp:Label>
                                </td>
                            <td align="left" >
                                &nbsp;<asp:DropDownList ID="ddlVendor" runat="server" CssClass="blackfnt" Visible="false">
                                                              </asp:DropDownList>
                                                              <asp:DropDownList ID="ddlWLoc" runat="server" CssClass="blackfnt" Visible="false">
                                 
                             </asp:DropDownList>
                                                              
                                                              
                                </td>
                             
                        </tr>
                        
                        <tr style="background-color: white" align="center">
                                                    
                    
                                </td>
                                                   
                                      <td align="left" >
                                 <asp:Label ID="Label18" runat="server" Text="KM Reading"       CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" colspan="3" >
                                &nbsp;<asp:TextBox ID="txtKMReading" runat="server"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"   BorderStyle="Groove" CssClass="input">
                                 
                             </asp:TextBox>
                             
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtKMReading"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtKMReading" Display="Dynamic"></asp:RegularExpressionValidator>                    
                             
                                </td>
                                        </tr>
                        <tr style="background-color: white" align="center">
                                                    
                             <td align="left"  >
                                 <asp:Label ID="Label20" runat="server" Text="Estimated Hrs"  CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
                                &nbsp;<asp:TextBox ID="txtEstHrs" runat="server" CssClass="input"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"   BorderStyle="Groove" >
                                                              </asp:TextBox>
                                                              
                                                              <asp:RequiredFieldValidator ID="reqtxtEstHrs" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtEstHrs"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegtxtEstHrs" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtEstHrs" Display="Dynamic"></asp:RegularExpressionValidator>                    
                                                              
                                                              
                                </td>
                                                   
                                      <td align="left" >
                                 <asp:Label ID="Label22" runat="server" Text="Estimated Cost"  CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >  
                                &nbsp;<asp:TextBox ID="txtEstCost" runat="server" CssClass="input"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"    BorderStyle="Groove" >
                                 
                             </asp:TextBox>
                             
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtEstCost"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtEstCost" Display="Dynamic"></asp:RegularExpressionValidator>                    
                                                              
                             
                                </td>
                             
                        </tr>
                        
                             
                     
                     </table>
                     <br/>
                          <table  align="center"  cellspacing="2" width="100%"   border="1" class="boxbg"   >    
                           <tr style="background-color: white" align="center">
                          <td  align="left" colspan="1" width="20%">
                 <asp:Label id="lblRow1" runat="server"   CssClass="bluefnt">Enter no. of rows </asp:Label>&nbsp;&nbsp;
                 </td>
                 <td align="center" colspan="1" >
                 <asp:TextBox ID="txtRow" runat=server MaxLength="3" Width="30" BorderStyle="Groove"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"  Text="0" ></asp:TextBox>
              	            <asp:RegularExpressionValidator ID="RegtxtRow" runat="server"
                                ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                            ControlToValidate="txtRow" Display="Dynamic"></asp:RegularExpressionValidator>
                           
                            
                      </td>
                     </tr>
                       <tr style="background-color: white" align="center">
                          <td  align="center" colspan="2">
                           <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"    /> 
                       </td>
                      </tr>
                     </table>
                     <br/>
                 
    
      <table cellspacing="2"  width="100%" align="center">
        <tr align="center">
            <td align="center">
                          <%--    OnRowDataBound="DataGrid1_ItemDataBound"  --%>
              <%--    <asp:UpdatePanel ID="UpdatePanel4" Mode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate> --%>
                        <asp:GridView ID="DataGrid1" runat="server"      OnRowDataBound="DataGrid1_ItemDataBound" 
                            AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5"
                            CellSpacing="1" CssClass="dgRowStyle" 
                            HeaderStyle-CssClass="dgHeaderStyle"  PagerStyle-HorizontalAlign="left" OnRowCommand="DataGrid1_RowCommand"
                             >
                            <Columns>
                     <asp:TemplateField HeaderText="Work Group Code" >
	                                <ItemTemplate>
	                               	   <asp:DropDownList ID="ddlWorkGroup" runat="server"  AutoPostBack="true"  Width="120px" CssClass="blackfnt" OnSelectedIndexChanged="ddlWorkGroup_SelectedIndexChanged"  ></asp:DropDownList> 
	                           
	                
	                           
	                               </ItemTemplate>
	                              </asp:TemplateField>
	                              
	                              
	                                    <asp:TemplateField HeaderText="Task Description" >
	                                <ItemTemplate>
	                               
	                         	   <asp:DropDownList ID="ddlTask" runat="server"   Width="200px" AutoPostBack="true"  CssClass="blackfnt" OnSelectedIndexChanged="ddlTask_SelectedIndexChanged"  ></asp:DropDownList> 
	                            <asp:RequiredFieldValidator ID="ReqddlTask" runat="server" Display="Dynamic" Text="!"  ValidationGroup="Group11" ControlToValidate="ddlTask"></asp:RequiredFieldValidator>
	                                </ItemTemplate>
	                              </asp:TemplateField>
	                                    <asp:TemplateField HeaderText="Task Type" >
	                                <ItemTemplate>
	                          <%--     
	                              <asp:DropDownList ID="ddlTaskType" runat="server"  Width="150px" CssClass="blackfnt"    ></asp:DropDownList>
	                            <asp:RequiredFieldValidator ID="ReqddlTaskType" runat="server" Display="Dynamic" Text="!"   ValidationGroup="Group11"    ControlToValidate="ddlTaskType"></asp:RequiredFieldValidator>--%>
	                           <asp:Label ID="lblTaskType" runat="server"    CssClass="blackfnt"    ></asp:Label>
	                          
	                                </ItemTemplate>
	                              </asp:TemplateField>
	                              
	                              
	                                    <asp:TemplateField HeaderText="Remarks" >
	                                <ItemTemplate>
	                               
	                              <asp:TextBox ID="txtRemarks" runat="server" BorderStyle="Groove"   Width="200px" CssClass="blackfnt"   ></asp:TextBox>
	                            
	                                </ItemTemplate>
	                              </asp:TemplateField>
  
                            </Columns>
                      
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>

        <%--    </ContentTemplate>
                   
                 </asp:UpdatePanel> --%>
 
 
            </td>
        </tr>
    </table>
    <br/>
    
            <table  align="center"   style="width: 100%"     >    
                       
                       <tr style="background-color: white" align="center">
                          <td  align="center" colspan="2">
                           <asp:Button ID="cmdSubmit" runat="server" Text="Submit"  Visible="false"  ValidationGroup="Group11"  OnClick="cmdSubmit_Click1"   /> 
                       </td>
                      </tr>
                     </table>
   
  
  </ContentTemplate>
                    <Triggers>
                    
                                         <asp:AsyncPostBackTrigger ControlID="txtVehicleNo" EventName="TextChanged" />
                     <asp:AsyncPostBackTrigger ControlID="ddlSCtype" EventName="SelectedIndexChanged" />
                   
                        <asp:AsyncPostBackTrigger ControlID="btnSubmit" EventName="Click" />
                    </Triggers>
                        </asp:UpdatePanel>
  
    
            </td>
        </tr>
     </table>
  
      
    </asp:Content>
