<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master"  CodeFile="AckJobOrder.aspx.cs" Inherits="GUI_Fleet_Job_AckJobOrder" %>
 <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >
 
 
 
 <script  type="text/javascript" language="javascript">
 
 
  function Check()
    {
 
//    var grid=document.getElementById("ctl00_MyCPH1_dgAck");
//      var r=grid.rows.length;
// 
//       alert("ok");
//          for(k=0;k<r-1;k++)
//        {  
//               
//               j=k+2
//               var pref="";
//              if(j<10)
//              {
//              pref = "ctl00_MyCPH1_dgAck_ctl0" + j + "_";
//              }                                       
//              else
//              {         
//              pref = "ctl00_MyCPH1_dgAck_ctl" + j + "_";
//              }    
// 
// 
//   
// 
//      var   Date= document.getElementById(pref + "txtVArrDate")  
//     
//     var   radsel= document.getElementById(pref + "radSel") 
//     
//      alert(Date.value);
//      if(radsel.checked)
//      {
//  
//        if(Date.value="")
//        {
//          alert("Please Enter Vehicle Arrived Date for Selected Record!")
//         return false;
//        }
//   
//      }
 
 }
 
 
 
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
             { 
                found_it = true;
                break;
             }
         }
       }
   } 
 
 if(!found_it)
 {
  alert("Select atleast one request");
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
    <br/>
    
      <table cellspacing="2" width="70%" align="center">
      
           <tr align="center">
            <td align="center">
               <asp:Label ID="lblError" runat="server"  Visible="false" CssClass="redfnt" ></asp:Label>
            </td>
            </tr>
      
      
        <tr align="center">
            <td align="center">
                             
              
                        <asp:DataGrid ID="dgAck" runat="server"     
                            AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5"
                            CellSpacing="1" CssClass="dgRowStyle" 
                            HeaderStyle-CssClass="dgHeaderStyle"  PagerStyle-HorizontalAlign="left" OnItemDataBound="dgAck_ItemDataBound"
                             >
                            <Columns>
                            
                            
                            
                               <asp:TemplateColumn HeaderText="Select">
	                                <ItemTemplate>
<%--	                                 <asp:RadioButton ID="radSel" runat="server"    GroupName="1"   Enabled="true" >--%>
                                   
                                           <asp:RadioButton ID="radSel"  runat="server" />
                                        
                                      <%--  </asp:RadioButton> --%>
                           
	                            
	  
	                            
	                            
	                               </ItemTemplate>
	                              </asp:TemplateColumn>
                            
                            
                            
                            
                            
                                  <asp:TemplateColumn HeaderText="Vehicle No.">
	                                <ItemTemplate>
	                                      <asp:Label ID="lblVehicleNo" runat="server"   Width="120px" CssClass="blackfnt"   ></asp:Label>
	                               </ItemTemplate>
	                              </asp:TemplateColumn>
	                              
	                              
	                                    <asp:TemplateColumn HeaderText="Vehicle Arrival Status" >
	                                <ItemTemplate>
	                               
	                              <asp:Label ID="lblVArrStatus" runat="server"  Width="120px"   CssClass="blackfnt"   ></asp:Label>
	
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
	                                    <asp:TemplateColumn HeaderText="Vehicle Arrival Date(dd/mm/yyyy)" >
	                                <ItemTemplate>
	                               
	                              <asp:TextBox ID="txtVArrDate" runat="server"  Width="100px" CssClass="input" BorderStyle="Groove"   ></asp:TextBox>
	                                                               <%--                           <asp:RequiredFieldValidator ID="reqAdvAmt" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtVArrDate"></asp:RequiredFieldValidator>--%>
                                                                <asp:RegularExpressionValidator ID="RegAdvAmt" runat="server"
                                                    ErrorMessage="!" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))" SetFocusOnError="true"
                                                    ControlToValidate="txtVArrDate" Display="Dynamic"></asp:RegularExpressionValidator>
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
	                              
	                              
	                                    <asp:TemplateColumn HeaderText="Order No." >
	                                <ItemTemplate>
	                               
	                            	                              <asp:Label ID="lblOrderNo" runat="server"   Width="120px" CssClass="blackfnt"   ></asp:Label>
	                            
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
	                                 <asp:TemplateColumn HeaderText="Order Date" >
	                                <ItemTemplate>
	                               
	                             	                              <asp:Label ID="lblODate" runat="server"   Width="120px" CssClass="blackfnt"   ></asp:Label>
	                            
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
	                                 <asp:TemplateColumn HeaderText="Order Type" >
	                                <ItemTemplate>
	                               
	                             	                              <asp:Label ID="lblOType" runat="server"   Width="120px" CssClass="blackfnt"   ></asp:Label>
	                            
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
	                              
	                              
	                                <asp:TemplateColumn HeaderText="Order Status" >
	                                <ItemTemplate>
	                               
	                              <asp:Label ID="lblStatus" runat="server"   Width="120px" CssClass="blackfnt"   ></asp:Label>
	                            
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
    
    
     <table  align="center"  width="70%">    
                       
                       <tr style="background-color: white" align="center">
                          <td  align="center" colspan="2">
                           <asp:Button ID="cmdSubmit" runat="server" Text="Submit"   OnClientClick="javascript:return Check()"  OnClick="cmdSubmit_Click"     /> 
                       </td>
                      </tr>
                     </table>
   
    
    
    
    
        </asp:Content>
