<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master"    CodeFile="PMRemainders.aspx.cs" Inherits="GUI_Fleet_Job_Default" %>

 
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >


<script language="javascript">





//function Check()
//{
// var  chk = document.getElementById("ctl00_MyCPH1_GridView1_ctl02_radSel").;

// var  chk = document.getElementById("ctl00_MyCPH1_GridView1_ctl02_chkSel").checked;






//}


  function fnCheckSel(intObjId)
{
//ctl00_MyCPH1_DataGrid1_ctl02_chksel
 var strSceTypeId; 
 strSceTypeId = intObjId + "1"
 for (var i=1; i<document.forms(0).length; i++) 
  { 
     if(document.forms(0).elements[i].id )
      { 
        if(document.forms(0).elements[i].id.indexOf("radSel")!=-1)
         {
            //alert(document.forms(0).elements[i].id ); 
            /*if (document.forms(0).elements[i].id.indexOf("chksel")==-1)
             { 
                alert("hi")
                document.forms(0).elements[i].checked=false
              }*/
              document.forms(0).elements[i].checked=false
         }
      }
  } 
 document.getElementById(intObjId).checked=true
}


function fnCheckVal(intObjId)
{
 var found_it ;
 for (var i=1; i<document.forms(0).length; i++)   
   { 
      if(document.forms(0).elements[i].id )
       { 
        if(document.forms(0).elements[i].id.indexOf("radSel")!=-1) 
         {
            if (document.forms(0).elements[i].checked)
             {// Set the flag if any radio button is checked
                found_it = true;
                break;
             }
         }
       }
   } 
 
 if(!found_it)
 {
  alert("Select atleast one Vehicle");
  return false;
 }
 else 
 {
   return true;
 } 
}

</script>










<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" style="height: 26px">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">PM Remainders & Generation Of Job Order > View Remainders </asp:Label>
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
<br/>

 <table  align="center"  width="80%"   border="0" cellpadding="0" cellspacing="0"  >
                                                                      
                                             
                                     <tr bgcolor="white">
                        <td colspan="2">
                           <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                        <asp:Label ID="lblError" runat="server"  Visible="false"
                                            CssClass="redfnt" Font-Bold="True"></asp:Label>
                        
                             <asp:GridView id="GridView1" runat="server"  CellSpacing="1" BorderColor="#8BA0E5" BorderWidth="1px"   OnRowDataBound="GridView1_RowDataBound"  
                              CssClass="dgRowStyle"  HeaderStyle-CssClass="dgHeaderStyle" PageSize="1000" EmptyDataText="No Records Found"  DataKeyNames="VEHNO"
                              AutoGenerateColumns="False" CellPadding="2" BackColor="White"    
                             Width="100%" Height="1px"  >
                                <FooterStyle BackColor="#8BA0E5" ForeColor="#003399"    />
                                
                              
                                <Columns>
                                <asp:TemplateField  HeaderText="Select Vehicle" >
	                                <ItemTemplate>
	                               
	                        <asp:RadioButton ID="radSel" runat="server" Visible="false"  /> 
	                    
	                         
	                                </ItemTemplate>
	                              </asp:TemplateField> 
        	              
        	                       <asp:TemplateField HeaderText="Select GroupCode(s)"  >
	                                <ItemTemplate>
	                               
<%--	                        <asp:RadioButton ID="radSel" runat="server" Visible="false"  /> &nbsp;&nbsp;--%>
                        <asp:CheckBox ID="chkSel"   runat="server" Visible="false"   /> 
	                    
	                         
	                                </ItemTemplate>
	                              </asp:TemplateField> 
                                <%--
                                  <asp:TemplateField   H >
	                                <ItemTemplate>
	                          
	                             
	                          <asp:LinkButton ID="lnkLvl0" runat="server" 
                                            CssClass="bluefnt" Font-Underline="true"  
                                             />
	                                </ItemTemplate>
	                              </asp:TemplateField>--%>
                                
        	                     
        	                     
        	                     
        	                     
        	                     
        	                     
        	                     
        	                     
        	                       <asp:TemplateField HeaderText="Vehicle No " >
	                                <ItemTemplate>
	                                     <%--<asp:LinkButton ID="lblVehNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "VEHNO")%>'
                                            CssClass="bluefnt" Font-Underline="true"  CommandArgument="<%# Container.DataItemIndex %>"
                                            OnCommand="SetAllLevel0"     />--%>
	                             <%--  OnCommand="SetAllLevel0"--%>
	                               
	                        <asp:Label ID="lblVehNo"       runat="server"  EnableViewState="true"   CssClass="blackfnt"   ></asp:Label>
	                         	                                </ItemTemplate>
	                              </asp:TemplateField>
        	                     
        	                     
        	                         <asp:TemplateField HeaderText="Work Group Code" >
	                                <ItemTemplate>
	                               
	                              <asp:Label ID="lblW_GRPCD"   EnableViewState="true"     runat="server"    CssClass="blackfnt"   ></asp:Label>
	                         
	                                </ItemTemplate>
	                              </asp:TemplateField>
                                
                                
                               
	                              
	                               <asp:TemplateField HeaderText="Vehicle Category" >
	                                <ItemTemplate>
	                               
	                              <asp:Label ID="lblVeh_Cat"   EnableViewState="true"    runat="server"    CssClass="blackfnt"  ></asp:Label>
	                                                
	                                </ItemTemplate>
	                              </asp:TemplateField>
	                              
	                               <asp:TemplateField HeaderText="Description" >
	                                <ItemTemplate>
	                               
	                              <asp:Label ID="lblDesc"    runat="server"  EnableViewState="true"   CssClass="blackfnt"   ></asp:Label>
	                        
	                                </ItemTemplate>
	                              </asp:TemplateField>
	                              
	                               <asp:TemplateField HeaderText="Job Order No" >
	                                <ItemTemplate>
	                               
	                              <asp:Label ID="lblJONo"      runat="server"  EnableViewState="true"   CssClass="blackfnt"  ></asp:Label>
	                         
	                                </ItemTemplate>
	                              </asp:TemplateField>
        	                     
        	                     
        	                        <asp:TemplateField HeaderText="Job Order Date" >
	                                <ItemTemplate>
	                               
	                              <asp:Label ID="lblJODate"      runat="server"  EnableViewState="true"   CssClass="blackfnt"  ></asp:Label>
	                         
	                                </ItemTemplate>
	                              </asp:TemplateField>
	                              
	                              
        	                     
        	                        <asp:TemplateField HeaderText="Job Completion Date" >
	                                <ItemTemplate>
	                               
	                              <asp:Label ID="lblJCDate"      runat="server"  EnableViewState="true"   CssClass="blackfnt"  ></asp:Label>
	                         
	                                </ItemTemplate>
	                              </asp:TemplateField>
	                             <asp:TemplateField HeaderText="Km Reading" >
	                                <ItemTemplate>
	                               
	                              <asp:Label ID="lblKMRead"      runat="server"  EnableViewState="true"   CssClass="blackfnt"  ></asp:Label>
	                         
	                                </ItemTemplate>
	                              </asp:TemplateField>
	                                  <asp:TemplateField HeaderText="Current Km Reading" >
	                                <ItemTemplate>
	                               
	                              <asp:Label ID="lblCKMRead"      runat="server"  EnableViewState="true"   CssClass="blackfnt"  ></asp:Label>
	                         
	                                </ItemTemplate>
	                              </asp:TemplateField>
	                              
	                              
	                                <asp:TemplateField HeaderText="PM due on Kms" >
	                                <ItemTemplate>
	                               
	                              <asp:Label ID="lblPMKms"      runat="server"  EnableViewState="true"   CssClass="blackfnt"  ></asp:Label>
	                         
	                                </ItemTemplate>
	                              </asp:TemplateField>
	                              
	                              <asp:TemplateField HeaderText="PM due on Days" >
	                                <ItemTemplate>
	                               
	                              <asp:Label ID="lblPMDays"      runat="server"  EnableViewState="true"   CssClass="blackfnt"  ></asp:Label>
	                         
	                                </ItemTemplate>
	                              </asp:TemplateField>
	                              
	                              
	                              <asp:TemplateField HeaderText="Remarks" >
	                                <ItemTemplate>
	                               
	                              <asp:Label ID="lblRemark"      runat="server"  EnableViewState="true"   CssClass="blackfnt"  ></asp:Label>
	                         
	                                </ItemTemplate>
	                              </asp:TemplateField>
	                              
	                              
	                                                                                              
	                         	            
	                            </Columns>
	                        </asp:GridView>
	                        
	                        
	                         </ContentTemplate>
	                         
	                
                            </asp:UpdatePanel>
	                        
	                        
	                    		               </td>
                    </tr>
                    
                    
                  
                    
            </table>  
            <br/>
            
            

  <table  align="center"   style="width: 80%"     >    
                       
                       <tr style="background-color: white" align="center">
                          <td  align="center" colspan="2">
                           <asp:Button ID="cmdSubmit" runat="server" Text="Generate Job Order" OnClick="cmdSubmit_Click"    /> 
                       </td>
                      </tr>
                     </table>
   


         </asp:Content>
