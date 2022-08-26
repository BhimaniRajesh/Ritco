<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"    CodeFile="SparePartMaster.aspx.cs" Inherits="GUI_Fleet_Job_SparePartMaster" %>



  <asp:Content  ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">


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
        {
            event.keyCode=0;
            return false;
        }
    } 
</script>



    <asp:HiddenField ID="moreprod" runat="server" />
    <table cellspacing="1" width="100%" >
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Spare Part  Master</asp:Label>
                <hr align="center"  color="#8ba0e5">
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
    
    <br /><br /><br />
    <p align="center">
    
        
        <table cellspacing="1" cellpadding="3"  class="boxg"    border="0"  >
            <tr style="background-color: white">
                <td   align="center">
     <asp:UpdatePanel ID="UpdatePanel4" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate> 
                        <asp:Panel runat="server" ID="Panel4" Visible="true">
    
        <table  width="100%"     cellspacing="1" cellpadding="3" class="boxbg" border="0">
            <tr class="bgbluegrey">
                <td colspan="4" align="center">
                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Spare Details"></asp:Label></td>
            </tr>
            <tr style="background-color: white">
                <td align="left" colspan="1" >
                    <asp:Label ID="lblPartType" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Part Type"></asp:Label>
                    <asp:RequiredFieldValidator ID="ReqcboPartType" runat="server" ControlToValidate="cboPartType"
                        ErrorMessage="*"></asp:RequiredFieldValidator></td>
                <td align="left" colspan="1"  >
          <asp:DropDownList ID="cboPartType" runat="server"  width="100px" >
                  <asp:ListItem Text="Select" Value=""  Selected="true"></asp:ListItem>
                     <asp:ListItem Text="Inventory" Value="I" ></asp:ListItem>
                                <asp:ListItem Text="Non-Inventory" Value="N"></asp:ListItem>
                    </asp:DropDownList>
                  
                </td>
                
                
                
                
                </tr>
                <%-- <tr style="background-color: white">
               
                <td align="left" colspan="1" style="height: 26px">
                    <asp:Label ID="lblPartCat" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Part Category"></asp:Label>
                    <asp:RequiredFieldValidator ID="RFVcboPartCat" runat="server" ControlToValidate="cboPartCat"
                        ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
                 
                 <td align="left" colspan="1" style="height: 26px">
                          <asp:DropDownList ID="cboPartCat" runat="server" width="100px"   >
                                   <asp:ListItem Text="Select" Value=""  Selected="true"></asp:ListItem>
                                        <asp:ListItem Text="Electrical" Value="E" ></asp:ListItem>
                                <asp:ListItem Text="General" Value="G"></asp:ListItem>
                                            <asp:ListItem Text="Fluids" Value="F"></asp:ListItem>
                    </asp:DropDownList>
                    
                    
                  </td>
                
            </tr>--%>
           
             <tr style="background-color: white">
               
                <td align="left" colspan="1" style="height: 26px">
                    <asp:Label ID="lblWorkGp" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Work Group"></asp:Label>
                   
                </td>
                 
                 <td align="left" colspan="1" style="height: 26px">
                          <asp:DropDownList ID="ddlWorkGroup" runat="server" width="100px"   >
                    </asp:DropDownList>
                    
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Dynamic" Text="!" ControlToValidate="ddlWorkGroup"></asp:RequiredFieldValidator>
                  </td>
                
            </tr>
             <tr style="background-color: white">
               
                <td align="left" colspan="1" style="height: 26px">
                    <asp:Label ID="Label5" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Task Type"></asp:Label>
                   
                </td>
                 
                 <td align="left" colspan="1" style="height: 26px">
                    <asp:DropDownList ID="ddlTaskType" runat="server" width="100px" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" Text="!" ControlToValidate="ddlTaskType"></asp:RequiredFieldValidator>
                    
                  </td>
                
            </tr>
            <tr style="background-color: white">

                <td align="left" colspan="1">
                    <asp:Label ID="lblPno" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Part No./Stock No."></asp:Label>  

                    </td>
                    <td align="left" colspan="1" >
                    <asp:Label ID="lblPartId" runat="server" CssClass="bluefnt" Text="System Gennerated."></asp:Label>
                </td>
            </tr>
                     
                             <tr style="background-color: white">        
               
                
                 <td align="left" colspan="1">
                    <asp:Label ID="lblDesc" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Description"></asp:Label>
                   <asp:RequiredFieldValidator ID="ReqtxtDesc" runat="server" ControlToValidate="txtDesc"
                        ErrorMessage="*"></asp:RequiredFieldValidator> 
                </td>
                <td align="left" colspan="1">
                <asp:TextBox ID="txtDesc" runat="server"  CssClass="input" Width="121px"></asp:TextBox>
                 
                     
                        
                
                
            </tr>


    <tr style="background-color: white">
               
                <td align="left" colspan="1">
                    <asp:Label ID="lblOE" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Unit Of Inventory"></asp:Label>
                 <asp:RequiredFieldValidator ID="ReqtxtInvUnt" runat="server" ControlToValidate="txtInvUnt"
                        ErrorMessage="*"></asp:RequiredFieldValidator> 
                </td>
                <td align="left"  colspan="1" >
                   
                 <asp:TextBox ID="txtInvUnt" runat="server"  CssClass="input" Width="121px"></asp:TextBox>
            
                     
                    
                </td>
                
                </tr>
                  <tr style="background-color: white">
                
                
                  <td align="left" colspan="1">
                    <asp:Label ID="lblAvgCost" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Average Cost"  ></asp:Label>
                  <asp:RequiredFieldValidator ID="ReqtxtAvgCost" runat="server" ControlToValidate="txtAvgCost"
                        ErrorMessage="*"></asp:RequiredFieldValidator> 
                          <asp:RegularExpressionValidator ID="RegtxtAvgCost" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtAvgCost" Display="Dynamic"></asp:RegularExpressionValidator>
                        
                        
                        
                        
                </td>
                <td align="left" colspan="1">
                     
                <asp:TextBox ID="txtAvgCost" runat="server" CssClass="input"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"   Width="121px"></asp:TextBox>
                   
                      
                    
                </td>
            </tr>


 

             <tr style="background-color: white">
               
                <td align="left" colspan="1" >
                    <asp:Label ID="lblSellPrice" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Selling Price"></asp:Label>
                  <asp:RequiredFieldValidator ID="ReqtxtSellPrice" runat="server" ControlToValidate="txtSellPrice"
                        ErrorMessage="*"></asp:RequiredFieldValidator> 
                          <asp:RegularExpressionValidator ID="RegtxtSellPrice" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtSellPrice" Display="Dynamic"></asp:RegularExpressionValidator>
                        
                        
                        
                </td>
                <td align="left" colspan="1">

  <asp:TextBox ID="txtSellPrice" runat="server" CssClass="input"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"     Width="121px"></asp:TextBox>

                
                  </td>
                   </tr>
        
            
          <tr style="background-color: white">
               
                <td align="left" colspan="1" >
                    <asp:Label ID="lblReOrderUnit" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Reorder Unit"></asp:Label>
                   <asp:RequiredFieldValidator ID="ReqtxtReorder" runat="server" ControlToValidate="txtReorder"
                        ErrorMessage="*"></asp:RequiredFieldValidator> 
                </td>
                <td align="left" colspan="1" >
                     
               <asp:TextBox ID="txtReorder" runat="server" CssClass="input" Width="121px"></asp:TextBox> 
                   
                     
                    
                </td>
                 </tr>
                          <tr style="background-color: white">
                
                <td align="left" colspan="1" >
                    <asp:Label ID="lblReOQty" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Reorder Quantity"></asp:Label>
                 <asp:RequiredFieldValidator ID="ReqtxtReorderQry" runat="server" ControlToValidate="txtReorderQry"
                        ErrorMessage="*"></asp:RequiredFieldValidator> 
                         <asp:RegularExpressionValidator ID="RegtxtReorderQry" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtReorderQry" Display="Dynamic"></asp:RegularExpressionValidator>
                        
                        
                        
                </td>
                <td align="left"  colspan="1" >
                              
                <asp:TextBox ID="txtReorderQry" runat="server" CssClass="input" Width="121px"></asp:TextBox>
 
                   
                     
                    
                </td>
                
                
            </tr>

             
              
              </table>
              
              
              <table cellspacing="1"  align="center" cellpadding="3" class="boxbg" border="0"  >
                 <tr class="bgbluegrey">
                <td colspan="4" align="left">
                 <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Vendor Details"></asp:Label>
                     </td>
            </tr>
              <tr style="background-color: white">
                <td  colspan="2">
                 <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Enter No.Of Rows"></asp:Label>
                     </td>
                        <td  colspan="2">
                 <asp:TextBox ID="txtRow" runat="server"  Width="50px" AutoPostBack="true"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove"    OnTextChanged="txtRow_TextChanged"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegtxtRow" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtRow" Display="Dynamic"></asp:RegularExpressionValidator>
                   
                     </td>
            </tr>
              
            <tr style="background-color: white">
                <td colspan="4">
                <asp:DataGrid ID="dgVendor" runat="server" AutoGenerateColumns="False"
                                                    CellPadding="2" CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                                    BorderWidth="3px" Width="100%" OnItemDataBound="dgVendor_ItemDataBound" OnItemCommand="dgVendor_ItemCommand" >
                                                    <Columns>
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
                                                        
                                                        <asp:TemplateColumn HeaderText="Vendor  Name">
                                                            <ItemTemplate>
                         <asp:DropDownList ID="cboVendorName" runat="server"  >    </asp:DropDownList>
                                       <asp:RequiredFieldValidator ID="reqcboVendorName" runat="server" Display="Dynamic" Text="!" ControlToValidate="cboVendorName"></asp:RequiredFieldValidator>
                                                                
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Vendor Part No.">
                                                            <ItemTemplate>
                                                                  <asp:TextBox ID="txtVendorPtNo" runat="server"  CssClass="input"       Width="65" BorderStyle="Groove"></asp:TextBox>
                                                                  <asp:RequiredFieldValidator ID="reqtxtVendorPtNo" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtVendorPtNo"></asp:RequiredFieldValidator>
                                                                
                                                        </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                         <asp:TemplateColumn HeaderText="Manufacturer">
                                                            <ItemTemplate>
                                                            <asp:TextBox ID="txtMfg"  runat="server" CssClass="input"     Width="60px" BorderStyle="Groove"  ></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqtxtMfg" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtMfg"></asp:RequiredFieldValidator>
                                                              
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                      
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Cost">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtCost" runat="server"     CssClass="input" Width="100px" BorderStyle="Groove"  ></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqtxtCost" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtCost"></asp:RequiredFieldValidator>
                                                           <asp:RegularExpressionValidator ID="RegtxtCost" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtCost" Display="Dynamic"></asp:RegularExpressionValidator>
                                                           
                                                           
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                         <asp:TemplateColumn HeaderText="Lead Time">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtLeadTime" runat="server"     CssClass="input" Width="100px" BorderStyle="Groove"  ></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqtxtLeadTime" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtLeadTime"></asp:RequiredFieldValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                                    
                                                                    
                                                                    
                                                                        <asp:TemplateColumn HeaderText="Delete">
                                         <ItemTemplate>
                            <asp:LinkButton ID="DeleteRow" runat="server" CausesValidation="false">X</asp:LinkButton>
                                  </ItemTemplate>
                                                 <ItemStyle HorizontalAlign="Center" />
                                                  </asp:TemplateColumn>
                                                        
                                                        </Columns>
                                                    <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Left" BackColor="White"
                                                        ForeColor="#000066" Wrap="False" Mode="NumericPages"></PagerStyle>
                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                    <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                    <ItemStyle ForeColor="#000066" />
                                                    <HeaderStyle Font-Bold="False" ForeColor="Black" CssClass="bgbluegrey"
                                                        Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                                </asp:DataGrid>
            
            </td>
            </tr>
               <tr style="background-color: white">
                <td>
                 <asp:Label ID="Label3" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Expiry Date:"></asp:Label>
                      <asp:RequiredFieldValidator ID="reqtxtExpDate" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtExpDate"></asp:RequiredFieldValidator>
                  
                   <asp:RegularExpressionValidator ID="REVtxtExpDate" runat="server" ControlToValidate="txtExpDate"
                                                            ErrorMessage="!" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                                            Width="1px"></asp:RegularExpressionValidator>
                    
                     </td>
                        <td>
                 <asp:TextBox ID="txtExpDate" runat="server"   CssClass="input"  ></asp:TextBox>
                 
                  
                  
                  
                     </td>
                     
                          <td>
                 <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Expiry Kms:"></asp:Label>
                     <asp:RequiredFieldValidator ID="ReqtxtExpKms" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtExpKms"></asp:RequiredFieldValidator>
                     <asp:RegularExpressionValidator ID="RegtxtExpKms" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtExpKms" Display="Dynamic"></asp:RegularExpressionValidator>
                     </td>
                        <td >
                 <asp:TextBox ID="txtExpKms" runat="server"    CssClass="input"  ></asp:TextBox>
                    
                       
                    
                    
                    
                     </td>
                     
            </tr>
            
        </table>
        
        
        
          
              
              
              
              
                <table cellspacing="1" cellpadding="3"  >
            <tr style="background-color: white">
                <td colspan="4" align="right">
                    <asp:Label ID="lblErrMsg" runat="server" Text="" CssClass="blackfnt" Font-Bold="true" ForeColor="red" Visible="false"></asp:Label>  
                    <asp:Button ID="cmdSubmit" runat="server" Text="Submit >>" OnClick="cmdSubmit_Click"   />&nbsp;&nbsp;
                </td>
            </tr>
        </table>
        
         </asp:Panel>
                   </ContentTemplate>
                    <Triggers>
                                        
                        <asp:AsyncPostBackTrigger ControlID="txtRow" EventName="TextChanged" />
                                   </Triggers>
                 </asp:UpdatePanel> 
        
        
        
        </td>
        </tr>
        </table>
        
        </p>
        
  
 </asp:Content>
