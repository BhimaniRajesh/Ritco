<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"      CodeFile="Taskdet.aspx.cs" Inherits="GUI_Job_Taskdet" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">



   <script language="javascript" type="text/javascript">  
   
   
   function  check()
   
   
   {
   
     var Cat=document.getElementById("ctl00_MyCPH1_ddlWorkGroup").value;
   
     var grid=document.getElementById("ctl00_MyCPH1_dgWorkgroup");
   
     if(Cat=="")
     
     {
     alert ("Please select Work Group !!!")
     
     return  false; 
     
     }
   
    var r=grid.rows.length;
   
      for(k=0;k<r-1;k++)
        {  
             
               j=k+2
               var pref="";
              if(j<10)
              {
              pref = "ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_";
              }                                       
              else
              {         
              pref = "ctl00_MyCPH1_dgWorkgroup_ctl" + j + "_";
              }    
          
              var Desc=document.getElementById(pref + "txtDesc").value;
              var TaskType=document.getElementById(pref + "ddlTaskType").value;
              
               var Unit=document.getElementById(pref + "ddlUnit").value;
              
              
              var SIdays=document.getElementById(pref + "txtServiceIDays").value;
              
              var ANDays=document.getElementById(pref + "txtAdvNoteDays").value;
                   
              var SIKms=document.getElementById(pref + "txtServiceIKms").value;
                        
              var ANKms=document.getElementById(pref + "txtAdvNoteKms").value;
              
            
              
   
                  if(Desc=="")
                  {
                   alert ("Please enter Task Description!")
                   return  false; 
                 }
   
   
                  if(TaskType=="")
                  {
                   alert ("Please select Task Type!")
                   return  false; 
                 }
   
   
            
               if(TaskType=="01")
                {
                    //alert(Unit);
                     if(Unit=="")
                      {
                       alert ("Please Enter Unit of Measure!")
                       return  false; 
                     }
   
                     if(SIdays==""  && SIKms=="" )
                      {
                         alert("Service Interval  cannot  be blank!")
                         return false;
                       }
                               
                      if(ANDays==""  && ANKms=="" )
                      {
                         alert("Advance Notification   cannot  be blank!")
                         return false;
                       }            
                               
                    if(SIdays!="")
                    {
                        if( parseFloat(SIdays)<=0)
                         {
                     
                         alert("Service Interval days Should be greater than 0!")
                         return false;
                    
                         }
                     }
   
                if(Unit!="Days")
                  {
                      if(SIKms!="")
                      {
                        if( parseFloat(SIKms)<=0)
                         {
                     
                         alert("Service Interval Kms Should be greater than 0!")
                         return false;
                    
                         }
                      }
                   }
   
                     if(parseFloat(SIdays)<=parseFloat(ANDays))
                      {
                        alert ("Advance Notification Days should be  less than Service Interval Days!")
                        return  false; 
                      }
                  
                  if(Unit!="Days")
                  {
                       if(parseFloat(SIKms)<=parseFloat(ANKms))
                      {
                           alert ("Advance Notification Kms should be  less than Service Interval Kms!")
                           return  false; 
                      }
                    }
   
                }
   
   
         }
   
   
   
     
      if(r>0)
      {
         for(i=0;i< r-1;i++)
        {  
            j=i+2
            var pref="";
  
              if(j<10)
              {
              pref = "ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_";
         
              
               }                                       
               else
                {         
             pref = "ctl00_MyCPH1_dgWorkgroup_ctl" + j + "_";
           
                }    
          
              Nat1=document.getElementById(pref + "txtDesc").value;
              
        
           
       
         for(k=0;k<r-1;k++)
        {  
            if(i!=k)
           {  
               m=k+2
               var pref="";
              if(j<10)
              {
              pref = "ctl00_MyCPH1_dgWorkgroup_ctl0" + m + "_";
              }                                       
              else
              {         
              pref = "ctl00_MyCPH1_dgWorkgroup_ctl" + m + "_";
              }    
          
             Nat11=document.getElementById(pref + "txtDesc").value ;
                            
           if(Nat1==Nat11)
           {
           alert("WorkGroup  Cannot  be Duplicate!");
           return false;
           }
         }
       }
     }
   }
   
   
   
   
   
   
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

  <table  align="center" cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" >
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Task Master</asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
            
                   <td align="right" >
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                    <font class="blackfnt" color="red"><b>Please wait...</b></font>
            </ProgressTemplate>
          </asp:UpdateProgress>  
         
          </td>      
            
        </tr>
    </table>
    <br>
        <table  align="left" cellspacing="1" style="width: 100%" border=0>
        <tr style="background-color: white">
        <td align="left" colspan="2">
    
            <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>   
                <table   align="center" cellspacing="1" cellpadding="2" class="boxbg">
                                                                                    
                                           
                         <tr style="background-color: white" align="center">
                                                       
                             <td align="right" >
                                 <asp:Label ID="lblWorkGroup" runat="server" Text="Select Work Group" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
                                &nbsp;<asp:DropDownList ID="ddlWorkGroup" runat="server"    AutoPostBack="true" OnSelectedIndexChanged="ddlWorkGroup_SelectedIndexChanged">
                                 
                             </asp:DropDownList>
                                                    <asp:RequiredFieldValidator ID="reqddlWorkGroup" runat="server" Display="Dynamic" Text="!" ControlToValidate="ddlWorkGroup"></asp:RequiredFieldValidator>
                                </td>
                             
                        </tr>
                         <%--<tr style="background-color: white" align="center">
                            
                            
                             <td align="right" >
                                 <asp:Label ID="Label1" runat="server" Text="Manufacturer" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
                                &nbsp;<asp:Label ID="lblMfg" runat="server" CssClass="blackfnt">
                                 
                             </asp:Label>
                                </td>
                             
                        </tr>
                        	   
                        	    <tr style="background-color: white" align="center">
                            
                            
                             <td align="right" >
                                 <asp:Label ID="Label2" runat="server" Text="Model" CssClass="bluefnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
                                &nbsp;<asp:Label ID="lblModel" runat="server" CssClass="blackfnt">
                                 
                             </asp:Label>
                                </td>
                             
                        </tr>--%>
                        
                    
                        
                        
                        </table>
                        
                  
                        
                        
                          <br>
                        	
                         <table  align="center" cellspacing="1" cellpadding="2" class="boxbg" >
                           
                              <tr style="background-color: white">
                        <td colspan="2">
                        <asp:Label ID="lblError" runat="server"   Visible="False" CssClass="redfnt">
                                 
                             </asp:Label>
                        
                        </td>
                        </tr>
                           
                           
                           
                           
                           
                           <tr style="background-color: white" align="center" >
                           <td  align="left" width="20%">
                 <font class=blackfnt>Enter no. of rows </font>&nbsp;&nbsp;
                 </td>
                 <td align="left" >
                 <asp:TextBox ID="txtRow" runat="server" MaxLength="3" Width="30"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"   BorderStyle="Groove"  Text="0" AutoPostBack="true" OnTextChanged="txtRow_TextChanged"></asp:TextBox>
              	                                                                   <asp:RegularExpressionValidator ID="RegtxtRow" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtRow" Display="Dynamic"></asp:RegularExpressionValidator>
                           
                            
                      </td>
                 </tr>
                          
                                                     
                           
                        
                        
                        
                        
                            <tr style="background-color: white">
                        <td colspan="2">
                             <asp:datagrid id="dgWorkgroup" runat="server" PageSize="1000"  OnItemDataBound="dgWorkgroup_ItemDataBound"  OnItemCommand="dgWorkgroup_ItemCommand"      AutoGenerateColumns="False" CellPadding="2" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CssClass="Styles.css" CellSpacing="1" Width="100%" Height="1px" ItemStyle-HorizontalAlign=Left   >
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
        	                      
	                              <asp:TemplateColumn HeaderText="Task Description">
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtDesc" runat="server" BorderStyle="Groove" Width="150px"  ></asp:TextBox>
	                                </ItemTemplate>
                                      <HeaderStyle HorizontalAlign="Left" />
	                              </asp:TemplateColumn>
        	                      
        	                      <asp:TemplateColumn HeaderText="Task Type" >
	                                <ItemTemplate>
	                                    <asp:DropDownList ID="ddlTaskType" runat="server" BorderStyle="Groove" Width="150px" AutoPostBack="true" OnSelectedIndexChanged="ddlTaskType_SelectedIndexChanged">
                                        </asp:DropDownList>
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
	                              
	                               <asp:TemplateColumn HeaderText="Unit Of Measure" >
	                                <ItemTemplate>
	                                    <asp:DropDownList ID="ddlUnit" runat="server" BorderStyle="Groove" Width="60px"  AutoPostBack="true" OnSelectedIndexChanged="ddlUnit_SelectedIndexChanged"  >
                                           <asp:ListItem Selected="True" Value=""></asp:ListItem>
                                            <asp:ListItem  Value="BOTH">BOTH</asp:ListItem>
                                            <asp:ListItem Value="Days">DAYS</asp:ListItem>
                                            <asp:ListItem Value="KMS">KMS</asp:ListItem>
                                        </asp:DropDownList>
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
        	                      
	                              <asp:TemplateColumn HeaderText="Service Intervals Days"  >
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtServiceIDays" runat="server"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"    BorderStyle="Groove" Width="75px"    ></asp:TextBox>
	                                                                   <asp:RegularExpressionValidator ID="RegtxtServiceIDays" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtServiceIDays" Display="Dynamic"></asp:RegularExpressionValidator>
	                               
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
	                               <asp:TemplateColumn HeaderText="Service Intervals Kms">
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtServiceIKms" runat="server" BorderStyle="Groove" Width="75px"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"      ></asp:TextBox>
	                                                                         <asp:RegularExpressionValidator ID="RegtxtServiceIKms" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtServiceIKms" Display="Dynamic"></asp:RegularExpressionValidator>
	                                
	                                
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
	                                                       
	                                                                 	                      
	                               <asp:TemplateColumn HeaderText="Advance Notification Days">
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtAdvNoteDays" runat="server" BorderStyle="Groove" Width="75px"    onkeypress="javascript:validFloat(event,this.getAttribute('id'))"    ></asp:TextBox>
	                                                   <asp:RegularExpressionValidator ID="RegtxtAdvNoteDays" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtAdvNoteDays" Display="Dynamic"></asp:RegularExpressionValidator>
	                               
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
	                              
	                              
	                                  <asp:TemplateColumn HeaderText="Advance Notification Kms">
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtAdvNoteKms" runat="server" BorderStyle="Groove" Width="75px"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"      ></asp:TextBox>
	                                
	                                 <asp:RegularExpressionValidator ID="RegtxtAdvNoteKms" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtAdvNoteKms" Display="Dynamic"></asp:RegularExpressionValidator>
	                                
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
        	                                                        
        	                              	                                                                          
	                         	            
	                            </Columns>
	                        </asp:datagrid>
	                    		               </td>
                    </tr>
                    
 <%--                    <asp:TemplateColumn HeaderText="Delete">
                          <ItemTemplate>
                            <asp:LinkButton ID="DeleteRow" runat="server" CausesValidation="false">X</asp:LinkButton>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateColumn>
                    --%>
                    
                      <tr style="background-color: white">
                            <td colspan="3" align="center">
                          <%--      <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                    <ContentTemplate>--%>
                                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" Visible="false" OnClick="btnSubmit_Click" OnClientClick="javascript:return check()" /> 
                                    <%--</ContentTemplate>
                                </asp:UpdatePanel>--%>
                            </td>
                        </tr>
                    
                    
            </table>  
            
            
            
                                      
                                     </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlWorkGroup" EventName="SelectedIndexChanged" />
                          <asp:AsyncPostBackTrigger ControlID="txtRow" EventName="TextChanged" />
                     <%--       <asp:AsyncPostBackTrigger ControlID="ddlUnit" EventName="SelectedIndexChanged" />--%>
                    </Triggers>
                 </asp:UpdatePanel> 
                        </td>
                        </tr>
                        </table>              
                                      
                                      
                                      
                                                         
                        
                       
                        
       
 
 
 
 
 </asp:Content>    
