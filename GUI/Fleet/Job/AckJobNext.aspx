<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master"   CodeFile="AckJobNext.aspx.cs" Inherits="GUI_Fleet_Job_AckJobNext" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >
 
  
   <script language="javascript" type="text/javascript">



 function  check()
   {
      
        var grid=document.getElementById("ctl00_MyCPH1_GridView1");
        
        
         var grid2=document.getElementById("ctl00_MyCPH1_dgSpare");
        
          var Kmread=document.getElementById("ctl00_MyCPH1_txtKMReading").value;
        
        
        var r=grid.rows.length;
        var  r2=grid.rows.length;
        
           if(Kmread=="")
              {
              
               alert("Enter Km Reading!!")
               return false;
              
              }
        
        
          for(k=0;k<r-1;k++)
        {  
               
               j=k+2
               var pref="";
              if(j<10)
              {
              pref = "ctl00_MyCPH1_GridView1_ctl0" + j + "_";
              }                                       
              else
              {         
              pref = "ctl00_MyCPH1_GridView1_ctl" + j + "_";
              }    
         
              
           if(document.getElementById(pref + "txtEstHrs")!=null)
              {
                var   EstHrs= document.getElementById(pref + "txtEstHrs")         
                    
               if(EstHrs.value=="")
               {
               alert("Enter Actual Labour Hours!!")
               return false;
            
               }
                       
              }
        
              if(document.getElementById(pref + "txtEstCost")!=null)
              {
                var   EstCost= document.getElementById(pref + "txtEstCost")         
                    
               if(EstCost.value=="")
               {
               alert("Enter Actual Labour Cost!!")
               return false;
            
               }
                       
              }
        
         }
         
       
         
         
           for(i=0;i<r2-1;i++)
          {  
               
               k=i+2
               var pref="";
              if(k<10)
              {
              pref = "ctl00_MyCPH1_dgSpare_ctl0" + k+ "_";
              }                                       
              else
              {         
              pref = "ctl00_MyCPH1_dgSpare_ctl" + k + "_";
              }    
         
         
         
             var   partno= document.getElementById(pref + "ddlPartNo")   
             
                 var   desc= document.getElementById(pref + "ddlPDesc")   
         
         
         
             var   Qty= document.getElementById(pref + "txtQty")   
           
           
           if(partno.value=="")
               {
               alert("Enter Spare Part No.!!");
               return false;
            
               }
           
           
           
            if(desc.value=="")
               {
               alert("Enter Spare Part Description!!");
               return false;
            
               }
           
           
             if(Qty.value=="")
               {
               alert("Enter spare Part Quantity!!");
               return false;
            
               }
      
            }
   
}













         function  calculate()
   
   
   {
    
      var totHrs="0.00",totcost="0.00";
        var mtotHrs="0.00",mtotcost="0.00";
      
      
   
     var grid=document.getElementById("ctl00_MyCPH1_GridView1");
   
   
               var r=grid.rows.length;
                
  
   
      for(k=0;k<r-1;k++)
        {  
             
             
           
               j=k+2
               var pref="";
              if(j<10)
              {
              pref = "ctl00_MyCPH1_GridView1_ctl0" + j + "_";
              }                                       
              else
              {         
              pref = "ctl00_MyCPH1_GridView1_ctl" + j + "_";
              }    
          
         
              if(document.getElementById(pref + "txtEstHrs")!=null)
              {
                            
               var   EstHrs= document.getElementById(pref + "txtEstHrs") 
            
               if(EstHrs.value!=""  )
              {
              totHrs=parseFloat(totHrs)+parseFloat(EstHrs.value);
              }
            
            
              }
 
              
              
              
              if(document.getElementById(pref + "txtEstCost")!=null)
              {
                           
                 var    EstCost= document.getElementById(pref + "txtEstCost") 
              
                if(EstCost.value!="")
                {
                 totcost=parseFloat(totcost)+parseFloat(EstCost.value);
                }
             
             
             
              }
 
             
              
            
              
                mtotHrs=parseFloat(totHrs);
                 mtotcost=parseFloat(totcost);
              
  
              
           
                  
        }
              
           document.getElementById("ctl00_MyCPH1_txttotEstHrs").value= totHrs;       
           
           document.getElementById("ctl00_MyCPH1_txttotEstCost").value=totcost;     
         
  
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
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Acknowledge Job Order</asp:Label>
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
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Acknowledge Job Order</asp:Label>
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
                           <asp:Label ID="lblWONo" runat="server" CssClass="blackfnt" ></asp:Label>
                                 
                             
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
                                &nbsp;<asp:Label ID="lblSCType" runat="server"  CssClass="blackfnt" >
                                                               
                             </asp:Label>
                                </td>
                                                   
                                      <td align="left" >
                                 <asp:Label ID="lblVendorHead" runat="server" Text="Vendor Name" CssClass="bluefnt" Visible="false"  ></asp:Label>
                              &nbsp;
                                <asp:Label ID="lblWLocHead" runat="server" Text="Workshop Location" CssClass="bluefnt" Visible="false"  ></asp:Label>
                                </td>
                            <td align="left" >
                                &nbsp;<asp:Label ID="lblVendor" runat="server" CssClass="blackfnt" Visible="false">
                                                              </asp:Label>
                                                              <asp:Label ID="lblwLoc" runat="server" CssClass="blackfnt" Visible="false">
                                 
                             </asp:Label>
                                                              
                                                              
                                </td>
                             
                        </tr>
                        
                        <tr style="background-color: white" align="center">
                                                   
                                      <td align="left" >
                                 <asp:Label ID="Label18" runat="server" Text="KM Reading" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" colspan="3" >
                                &nbsp;<asp:TextBox ID="txtKMReading"   runat="server" CssClass="input"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"   BorderStyle="groove">
                                 
                             </asp:TextBox>
                             
                                 <asp:RequiredFieldValidator ID="ReqtxtKMReading" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtKMReading" ></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtKMReading" Display="Dynamic"></asp:RegularExpressionValidator>                    
                             
                                </td>
                        <tr style="background-color: white" align="center">
                                                    
                             <td align="left"  >
                                 <asp:Label ID="Label20" runat="server" Text="Total Estimated Labour Hrs" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
                                &nbsp;<asp:TextBox ID="txttotEstHrs" runat="server" CssClass="blackfnt"  ReadOnly="true"  BorderStyle="groove">
                                                              </asp:TextBox>
                                                              
                                                            
                                                                <asp:RegularExpressionValidator ID="RegtxttotEstHrs" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txttotEstHrs" Display="Dynamic"></asp:RegularExpressionValidator>                    
                                                              
                                                              
                                </td>
                                                   
                                      <td align="left" >
                                 <asp:Label ID="Label22" runat="server" Text="Total Estimated Labour Cost" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
                                &nbsp;<asp:TextBox ID="txttotEstCost" runat="server" ReadOnly="true"   CssClass="blackfnt"  BorderStyle="groove"  >
                                 
                             </asp:TextBox>
                             
                         
                                                                <asp:RegularExpressionValidator ID="RegtxttotEstCost" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txttotEstCost" Display="Dynamic"></asp:RegularExpressionValidator>                    
                                                              
                             
                                </td>
                             
                        </tr>
                     <br/>
                     
                     <table cellspacing="1" width="100%">
                     
                     
                             <tr class="bgbluegrey"  >
                        <td  align="center">
                            <asp:Label ID="Label6" CssClass="blackfnt" Font-Bold="true" runat="server">Task Details</asp:Label>
                        </td>
                    </tr>
                                   
                     
            <tr align="center"   >
              <td align="center">
                 
                        <asp:GridView ID="GridView1" runat="server"  
                            AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5"
                            CellSpacing="1" CssClass="dgRowStyle" EmptyDataText="No Records Found..."
                            HeaderStyle-CssClass="dgHeaderStyle" PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
                            PageSize="10" OnRowDataBound="GridView1_RowDataBound"   >
                            <Columns>
 
             
                                
                                
                                <asp:TemplateField HeaderText="Work Group Code & Description" >
	                                <ItemTemplate>
	                                
	                              <asp:Label ID="lblW_GRPCD"   EnableViewState="true"     runat="server"    CssClass="blackfnt"   ></asp:Label>
	                         
	                                </ItemTemplate>
	                              </asp:TemplateField>
                                
                                
                                 <asp:TemplateField HeaderText="Task Code " >
	                                <ItemTemplate>
	                               
	                              <asp:Label ID="lblTaskCode"       runat="server"  EnableViewState="true"   CssClass="blackfnt"   ></asp:Label>
	                         	                                </ItemTemplate>
	                              </asp:TemplateField>
	                              
	                               <asp:TemplateField HeaderText="Task Description"   HeaderStyle-Wrap="false" ItemStyle-Wrap="false" >
	                                <ItemTemplate>
	                               
	                              <asp:Label ID="lblTaskDesc"   EnableViewState="true"    runat="server"    CssClass="blackfnt"  ></asp:Label>
	                                                
	                                </ItemTemplate>
	                              </asp:TemplateField>
	                              
	                               <asp:TemplateField HeaderText="Task Type" >
	                                <ItemTemplate>
	                               
	                              <asp:Label ID="lblTaskType"    runat="server"  EnableViewState="true"   CssClass="blackfnt"   ></asp:Label>
	                        
	                                </ItemTemplate>
	                              </asp:TemplateField>
	                              
	                               <asp:TemplateField HeaderText="Remark" >
	                                <ItemTemplate>
	                               
	                              <asp:Label ID="lblRemark"      runat="server"  EnableViewState="true"   CssClass="blackfnt"  ></asp:Label>
	                         
	                                </ItemTemplate>
	                              </asp:TemplateField>
	                              
                                
	                              
                                
                                
                                
 
   	                             <asp:TemplateField HeaderText="Estimated Hours" >
	                                <ItemTemplate>
	                               
<%--	                              <asp:TextBox ID="txtEstHrs"   onblur="javascript:return calculateBalance(this.form)"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"    Text='<%# DataBinder.Eval(Container.DataItem,"EstHrs") %>'        runat="server"  Width="100px" CssClass="input" BorderStyle="Groove" OnTextChanged="txtEstHrs_TextChanged"   ></asp:TextBox>--%>
	                              <asp:TextBox ID="txtEstHrs"      onblur="javascript:return calculate(this.form)"       onkeypress="javascript:validFloat(event,this.getAttribute('id'))"    runat="server"  Width="100px" CssClass="input" BorderStyle="Groove" OnTextChanged="txtEstHrs_TextChanged"   ></asp:TextBox>
	                         <asp:RequiredFieldValidator ID="reqtxtEstHrs1" runat="server"    ValidationGroup="G1"    Display="Dynamic" Text="!" ControlToValidate="txtEstHrs"></asp:RequiredFieldValidator>
                                                  <asp:RegularExpressionValidator ID="RegtxtEstHrs" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtEstHrs" Display="Dynamic"></asp:RegularExpressionValidator>                           
	                                </ItemTemplate>
	                              </asp:TemplateField>
	                              
	                              
	                                <asp:TemplateField HeaderText="Estimated Cost" >
	                                <ItemTemplate>
	                               
	  <%--                            <asp:TextBox ID="txtEstCost"  onblur="javascript:return calculateBalance(this.form)"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"    Text='<%# DataBinder.Eval(Container.DataItem,"EstCost") %>'      runat="server"  Width="100px" CssClass="input" BorderStyle="Groove" OnTextChanged="txtEstCost_TextChanged"   ></asp:TextBox>--%>
	                                <asp:TextBox ID="txtEstCost"    onblur="javascript:return calculate(this.form)"        onkeypress="javascript:validFloat(event,this.getAttribute('id'))"    runat="server"  Width="100px" CssClass="input" BorderStyle="Groove" OnTextChanged="txtEstCost_TextChanged"   ></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqtxtEstCost"   ValidationGroup="G1"   runat="server" Display="Dynamic" Text="!" ControlToValidate="txtEstCost"></asp:RequiredFieldValidator>
                                                                                                          <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtEstCost" Display="Dynamic"></asp:RegularExpressionValidator>                              
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
    
    
    
    
    
    
    
       
                      <table cellspacing="1" width="100%"  class="boxbg" border="0">
                        
                                 <tr class="bgbluegrey">
                        <td  align="center"  colspan="2">
                            <asp:Label ID="lblHead" CssClass="blackfnt"      Font-Bold="true" runat="server">Spare Part-Requirements(Estimates)</asp:Label>
                        </td>
                    </tr>
                        
                        
                        <tr align="center" style="background-color:White">
                          <td  align="center" width="20%">
                 <asp:Label  CssClass="bluefnt" ID="lblRow" runat="server">Enter no. of rows </asp:Label>&nbsp;&nbsp;
                 </td>
                 <td align="center">
                 <asp:TextBox ID="txtRow" runat="server" MaxLength="3" Width="30" BorderStyle="Groove"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"  AutoPostBack="true"  Text="0" OnTextChanged="txtRow_TextChanged" ></asp:TextBox>
              	            <asp:RegularExpressionValidator ID="RegtxtRow" runat="server"
                                ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"  ValidationGroup="row"  
                            ControlToValidate="txtRow" Display="Dynamic"></asp:RegularExpressionValidator>
                           
                            
                      </td>
                     </tr>
                     </table>
    
    
    
    
    
    
     <table cellspacing="1" width="100%">
       
                      
                    <%--         <tr class="bgbluegrey">
                        <td  align="center" >
                            <asp:Label ID="lblHead" CssClass="blackfnt"      Font-Bold="true" runat="server">Spare Part-Requirements(Estimates)</asp:Label>
                        </td>
                    </tr>--%>
                                   
     
        <tr align="center">
            <td align="center" >
                             
                
                        <asp:DataGrid ID="dgSpare" runat="server"    
                            AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5"
                            CellSpacing="1" CssClass="dgRowStyle" 
                            HeaderStyle-CssClass="dgHeaderStyle"  PagerStyle-HorizontalAlign="left" OnItemDataBound="dgSpare_ItemDataBound"
                             >
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
               
               
               
               
	                              
                            <asp:TemplateColumn HeaderText="Part No" >
	                                <ItemTemplate>
	                               
	                              <asp:DropDownList ID="ddlPartNo" runat="server"  Width="100px"  CssClass="blackfnt"    ></asp:DropDownList>
	                            
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
	                              
	                              
	                              
	                                    <asp:TemplateColumn HeaderText="Part Description" >
	                                <ItemTemplate>
	                               
	                              <asp:DropDownList ID="ddlPDesc" runat="server" Width="150px" CssClass="blackfnt"   ></asp:DropDownList>
	                            
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
	                                    <asp:TemplateColumn HeaderText="Quantity" >
	                                <ItemTemplate>
	                               
	                              <asp:TextBox ID="txtQty" runat="server"  AutoPostBack="true"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"  CssClass="blackfnt" BorderStyle="Groove" OnTextChanged="txtQty_TextChanged"    ></asp:TextBox>
	                              <asp:RequiredFieldValidator ID="reqtxtQty"   ValidationGroup="G1"   runat="server" Display="Dynamic" Text="!" ControlToValidate="txtQty"></asp:RequiredFieldValidator>
	                                <asp:RegularExpressionValidator ID="RegtxtQty" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtQty" Display="Dynamic"></asp:RegularExpressionValidator>                    
	                            
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
	                              
	                              
	                                    <asp:TemplateColumn HeaderText="Cost/Unit" >
	                                <ItemTemplate>
	                               
	                              <asp:Label ID="lblCostUnit" runat="server"  width="120px" CssClass="blackfnt"   ></asp:Label>
	                            
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
	                              
	                                    <asp:TemplateColumn HeaderText="Cost" >
	                                <ItemTemplate>
	                               
	                              <asp:TextBox ID="txtCost" runat="server"   ReadOnly="true"   CssClass="blackfnt" BorderStyle="Groove"  ></asp:TextBox>
	                                <asp:RequiredFieldValidator ID="reqtxtCost"   ValidationGroup="G1"   runat="server" Display="Dynamic" Text="!" ControlToValidate="txtCost"></asp:RequiredFieldValidator>
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
	                        
  
                            </Columns>
                      
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:DataGrid>

          
 
 
            </td>
        </tr>
    </table>
    
      
    
    <br/>
    
    
       <table cellspacing="1" width="100%" align="">
     
<%--      OnClientClick="javascript:return check()"  --%>
                             <tr style="background-color:White">
                        <td  align="center">
                           <asp:Button ID="cmdSubmit" runat="server"    ValidationGroup="G1"  Text="Submit" OnClick="cmdSubmit_Click"  /> 
                        </td>
                    </tr>
                    
                    </table>
                                                    
                        
                                </td>
                                        </tr>
                        
                             
                     
                     </table>
    
    
    </ContentTemplate>
             
                        </asp:UpdatePanel>
  
    
      </td>
        </tr>
     </table>
    
                     
    
    </asp:Content>
