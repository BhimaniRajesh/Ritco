<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"     CodeFile="TripsheetEdit.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_TripsheetQuery" %>
 
 <%@ Register TagPrefix="UC2" TagName="UCPaymentControl" Src="~/UserControls/PaymentControl.ascx" %>
 
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
   <script language="javascript" type="text/javascript">
       
 
   function ShowAmt()
   {
            var grid1=document.getElementById("ctl00_MyCPH1_dgAdvancedet");
             var r1=grid1.rows.length;
       
       
       
       
         for(i=0;i< r1-1;i++)
        {
              j=i+2
              var pref="";
  
                 if(j<10)
                {
                 pref = "ctl00_MyCPH1_dgAdvancedet_ctl0" + j + "_";
                      
                 }                                       
                else
                {         
                 pref = "ctl00_MyCPH1_dgAdvancedet_ctl" + j + "_";
           
                }    
           if (document.getElementById(pref  +"chksel").checked==true)
           {
           
              if(document.getElementById(pref  +"txtAdvAmt").value!="")
               {
                 document.getElementById("ctl00$MyCPH1$UCPayment$txtAmount").value= document.getElementById(pref  +"txtAdvAmt").value;       
              
               }
           }
  
       }
       
       
       
       
       
       
       
   }
 
 
 
 
 
//     function   checkRadio()
//    {       var grid1=document.getElementById("ctl00_MyCPH1_dgAdvancedet");
//             var r1=grid1.rows.length;
//       
//            for(i=0;i< r1-1;i++)
//            {
//              j=i+2
//              var pref="";
//  
//                 if(j<10)
//                {
//                 pref = "ctl00_MyCPH1_dgAdvancedet_ctl0" + j + "_";
//                      
//                 }                                       
//                else
//                {         
//                 pref = "ctl00_MyCPH1_dgAdvancedet_ctl" + j + "_";
//           
//                }    
//               
//            
//                    if (document.getElementById(pref  +"chksel").checked==true)
//                      {
//                        document.getElementById(pref  +"txtAdvPlace").ReadOnly=false;
//                        document.getElementById(pref  +"txtAdvDt").ReadOnly=false;
//                        document.getElementById(pref  +"txtAdvAmt").ReadOnly=false;
//                        document.getElementById(pref  +"txtBranchCode").ReadOnly=false;
//                        document.getElementById(pref  +"txtSignature").ReadOnly=false;
//                      
//                      
//                      }
//           
//           
//            }
//     
//     
//     
//     }
//     
 
 
 
 
  function fnCheckSel(intObjId)
{
//ctl00_MyCPH1_DataGrid1_ctl02_chksel
 var strSceTypeId; 
 strSceTypeId = intObjId + "1"
 for (var i=1; i<document.forms(0).length; i++) 
  { 
     if(document.forms(0).elements[i].id )
      { 
        if(document.forms(0).elements[i].id.indexOf("chksel")!=-1)
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
        if(document.forms(0).elements[i].id.indexOf("chksel")!=-1) 
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
  alert("Select atleast one request");
  return false;
 }
 else 
 {
   return true;
 } 
}
 
 
 
        
 
        
function IsDateGreater(DateValue1, DateValue2)
{
//alert(DateValue1)
//alert(DateValue2)

var a=DateValue1.split("/");
var b=DateValue2.split("/");
DateValue1 = a[1]+ "/" + a[0]+ "/" + a[2];
DateValue2 = b[1]+ "/" + b[0]+ "/" + b[2];
if(Date.parse(DateValue1) >= Date.parse(DateValue2))
return true;
else
return false;
}
        
       
        function valid(obj,tran,chqno,chqdate,VslipDt,VCloseDt,ServerDt)
     //function valid(obj,tran,chqno,chqdate)
          {
            
            //alert("VslipDt : "  + VslipDt);
            //alert("VCloseDt : "  + VCloseDt);
            //alert("ServerDt : "  + ServerDt);
          var grid1=document.getElementById("ctl00_MyCPH1_dgAdvancedet");
            var r1=grid1.rows.length;
          
          
          
       
         for(i=0;i< r1-1;i++)
        {  
            //alert("1");
            j=i+2
            var pref="";
  
                 if(j<10)
                {
                 pref = "ctl00_MyCPH1_dgAdvancedet_ctl0" + j + "_";
                      
                 }                                       
               else
                {         
                 pref = "ctl00_MyCPH1_dgAdvancedet_ctl" + j + "_";
           
                }    
                    //alert("2");
                    var mSelect= document.getElementById(pref + "chksel");  
                    //alert(mSelect.name) 
//                    alert("1");
//                    if(document.getElementById(pref + "chksel").checked==true)
//                    {
//                        alert(pref);   
//                    }
//                  alert("2");

            if(document.getElementById(pref + "chksel").checked==true)
              {
                  if (document.getElementById(pref  +"txtAdvPlace").value != "" || document.getElementById(pref+"txtAdvDt").value != "" || document.getElementById(pref+"txtAdvAmt").value != "" || document.getElementById(pref+"txtBranchCode").value != "" || document.getElementById(pref+"txtSignature").value != "")
                    {
                    
                    
                            //alert(mSelect.name) 
            
                              if (document.getElementById(pref + "txtAdvPlace").value == "")
                             {
                                alert("Please Enter Advance Place !!")
                               document.getElementById(pref + "txtAdvPlace").focus();
                               return false;
                            
                             }
                         
                     
                            if (document.getElementById(pref+"txtAdvDt").value == "")
                             {
                                alert("Please Enter Advance Date !!")
                               document.getElementById(pref+"txtAdvDt").focus();
                               return false;
                            
                             }
                             
                              var AdvDt= document.getElementById(pref+"txtAdvDt").value;
                              
                              if(AdvDt.length<10)
                                 {
                                  alert("The date format should be : dd/mm/yyyy")
                                  document.getElementById(pref+"txtAdvDt").focus(); 
                                  return false
                                 }
    
    
                                if(!Date.parse(AdvDt))
                                {
                                   alert("Invalid advance date !!!")
                                   document.getElementById(pref+"txtAdvDt").focus(); 
                                   return false
                                }           
                             
                             
                             
                             //alert("AdvDt : " + Date.parse(AdvDt))
                            // alert("VslipDt : " + Date.parse(VslipDt))
                             //alert("ServerDt : " + Date.parse(ServerDt))
                             //alert("VCloseDt : " + Date.parse(VCloseDt))
                              
                              
                              if (!IsDateGreater(AdvDt,VslipDt))
                              //if(Date.parse(AdvDt)< Date.parse(VslipDt))
                                 {
                                   alert("Advance date can not be less than Issue Slip date " + VslipDt + "  !!!")
                                   document.getElementById(pref+"txtAdvDt").focus(); 
                                   return false
                                 } 
                              
                              if (!IsDateGreater(ServerDt,AdvDt))
                              //if(Date.parse(AdvDt)> Date.parse(ServerDt))
                                 {
                                   alert("Advance date can not be greater than today's date !!!")
                                   document.getElementById(pref+"txtAdvDt").focus(); 
                                   return false
                                  } 
                                    
                              if(VCloseDt!="")
                               {
                                     if (!IsDateGreater(VCloseDt,AdvDt))
                                   //if(Date.parse(AdvDt)> Date.parse(VCloseDt))
                                    {
                                       alert("Advance date can not be greater than Issue Slip close date " + VCloseDt + " !!!")
                                       document.getElementById(pref+"txtAdvDt").focus(); 
                                       return false
                                    }
                                }
                                
                             
                             if (document.getElementById(pref+"txtAdvAmt").value == "")
                             {
                                alert("Please Enter Advance Amount !!")
                               document.getElementById(pref+"txtAdvAmt").focus();
                               return false;
                            
                             }
                             if (document.getElementById(pref+"txtBranchCode").value == "")
                            {
                                alert("Please Enter Branchcode !!")
                               document.getElementById(pref+"txtBranchCode").focus();
                               return false;
                            
                            }
                          
                             if (document.getElementById(pref+"txtSignature").value == "")
                            {
                                alert("Please Enter Advance Payee !!")
                               document.getElementById(pref+"txtSignature").focus();
                               return false;
                            
                             }
                              
                     }//if End
                  }     
            }
           //For End     
           
            if(document.getElementById('ctl00$MyCPH1$UCPayment$txtAmount').value != '0.00')
            {
                        //alert("hi")
                        if(tran.value == "")
                        {
                                alert("Select Payment Mode Of Transaction");
                                return false;
                        }
                        
                        
                        if (document.getElementById('ctl00$MyCPH1$UCPayment$dlstAcccode').value == '')
                            {
                                 alert("Please Select Cash / Bank Account  !!")
                                 document.getElementById('ctl00$MyCPH1$UCPayment$dlstAcccode').focus();
                                return false;
                            }
                        
                        
                        
                        
                        if (tran.value == "BANK")
                        {
                            if (chqno.value == "")
                            {
                                alert("Enter Payment Cheque Number");
                                return false;
                            }   
                            else if (chqdate.value == "")
                            {
                                alert("Enter Payment Cheque Date");
                                return false;
                            }
                            else if (document.getElementById('ctl00$MyCPH1$UCPayment$dlstAcccode').value == '')
                            {
                                 alert("Please Select Payment Bank Name !!")
                                 document.getElementById('ctl00$MyCPH1$UCPayment$dlstAcccode').focus();
                                return false;
                            }
                            else if (document.getElementById('ctl00$MyCPH1$UCPayment$txtAmount').value == '0.00')
                            {
                                 alert("Please Payment Enter Amount !!")
                                return false;
                            }
                        }
                        else
                        {
                            
                            if (document.getElementById('ctl00$MyCPH1$UCPayment$dlstAcccode').value == '')
                            {
                                 alert("Please Select Payment Cash Account !!")
                                return false;
                            }
                            
                            
                            if(document.getElementById('ctl00$MyCPH1$UCPayment$txtAmount').value == '0.00')
                            {
                                alert("Please Enter Payment Amount !!")
                                return false;
                            }
                        }
                        
                            
                        //alert("Submit");
                        //return false;
           }
            var lblError=document.getElementById("ctl00_MyCPH1_lblError");
            if(lblError.innerText != "")
            {
                alert(lblError.innerText);
                return false;
            }
                    
    }//Valid End
 
        </script>
  <asp:UpdateProgress ID="uppMain" runat="server">
            <ProgressTemplate>
                <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                    -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                    <tr>
                        <td align="right">
                            <img src="../../../images/loading.gif" alt="" />
                        </td>
                        <td>
                            <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                        </td>
                    </tr>
                </table>
                <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
                    background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
                    opacity: .50; -moz-opacity: .50;" runat="server">
                    <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                        left: 50%;" ID="Panel2" runat="server">
                    </asp:Panel>
                </asp:Panel>
            </ProgressTemplate>
        </asp:UpdateProgress>
        
 <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Trip Sheet >> Edit</asp:Label>

            </td>
              <td align="right">
        
         
          </td>      
        </tr>
    </table>
    
    <hr align="center" size="1" color="#8ba0e5">
 <br/> 

   <table cellspacing="1" cellpadding="2" width="60%"  align="left">
        <tr style="background-color: white" align="center">
            <td align="center">

       <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" RenderMode="Inline" runat="server" >
         <ContentTemplate>


      <table cellspacing="1" align="center"  border="1"   class="boxbg" cellpadding="3" width="100%"   >

            <tr style="background-color: white">
                <td   align="center" colspan="4">
   
 
              
     
                        <asp:Label ID="lblError"  runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor="red"></asp:Label>
                       <%-- <asp:Label ID="lblError1"  runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor="red"></asp:Label>--%>
                    </td>
   
            </tr>
            
            <tr class="bgbluegrey">
                <td colspan="4" align="center" style="height: 22px">
                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="EDIT/UPDATE VEHICLE ISSUE SLIP"></asp:Label></td>
                           
                    
            </tr>
     
           
            
             <tr style="background-color: white">
            
                <td align="left" >
                  <font class="bluefnt">Issue Slip Id</font>
                </td>
                <td   align="left">
                  <asp:Label ID="lblIssueNo" runat=server CssClass="blackfnt"></asp:Label>
                </td>
                
                
                <td align="left" >
                  <font class="bluefnt">Issue Slip Date</font>
                </td>
                <td   align="left">
                  <asp:Label ID="lblSlipdt" runat=server CssClass="blackfnt"></asp:Label>
                </td>
             
            </tr>
 
                </table>
                       
               
                
            
             
            
                         <table border="0" Width="100%" align="center">
                                 <tr>
                                    <td>
                                    
                                    <asp:DataGrid ID="dgAdvanceDet" runat="server" AutoGenerateColumns="False"
                                                    CellPadding="2" CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                                    BorderWidth="3px" Width="100%"  OnItemDataBound="dgAdvanceDet_ItemDataBound">
                                                    <Columns>
                                                    
                                                    
                                                      <asp:TemplateColumn >
                                                            <ItemTemplate>
                                                               
                                                                
                                                                <asp:RadioButton ID="chksel"  AutoPostBack="true"     runat="server" OnCheckedChanged="chksel_CheckedChanged"></asp:RadioButton>
                                                  
                                                                
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                    
                                                    
                                                    
                                                    
                                                    
                                                    
                                                    
                                                    
                                                        <asp:TemplateColumn HeaderText="Sr.No.">
                                                            <ItemTemplate>
                                                                <center>
                                                                    <%# Container.ItemIndex+1 %>.
                                                                    <asp:Label ID="count" runat="server" Visible="false" Text=' <%# Container.ItemIndex+1 %>'></asp:Label>
                                                             <asp:HiddenField ID="hdVNo" runat="server"     ></asp:HiddenField>
                                                             
                                                                </center>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        <asp:TemplateColumn HeaderText="Place">
                                                            <ItemTemplate>
                                                               
                                                                
                                                                <asp:TextBox ID="txtAdvPlace"     runat="server"      CssClass="input" Width="150px" BorderStyle="Groove" MaxLength="50"></asp:TextBox>
                                                   
                                                                
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Advance Date (dd/mm/yyyy)">
                                                            <ItemTemplate>
                                                                  <asp:TextBox ID="txtAdvDt" runat=server MaxLength="10"      Width="65" BorderStyle="Groove"></asp:TextBox>
                                                               <%--  <asp:RequiredFieldValidator ID="reqAdvDt" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtAdvDt"></asp:RequiredFieldValidator>--%>
                                                             <asp:RegularExpressionValidator ID="REVAdvDt" runat="server" ControlToValidate="txtAdvDt"
                                                            ErrorMessage="!" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                                            Width="1px"></asp:RegularExpressionValidator> 
                                                        </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                         <asp:TemplateColumn HeaderText="Amount">
                                                            <ItemTemplate>
                                                            <asp:TextBox ID="txtAdvAmt"  runat="server" CssClass="input"  onblur="javascript:return ShowAmt()"    Width="60px" BorderStyle="Groove" MaxLength="6"   ></asp:TextBox>
                                                           <%--     <asp:RequiredFieldValidator ID="reqAdvAmt" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtAdvAmt" ></asp:RequiredFieldValidator>--%>
                                                               <asp:RegularExpressionValidator ID="RegAdvAmt" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtAdvAmt" Display="Dynamic"></asp:RegularExpressionValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                 
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Branch Code">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtBranchCode" runat="server"   CssClass="input" Width="100px" BorderStyle="Groove"  AutoPostBack="true"   MaxLength="15" OnTextChanged="txtBranchCode_TextChanged"></asp:TextBox>
                                                               <asp:HiddenField ID="hdBrCode" runat="server"     ></asp:HiddenField>
                                                        
                                                             <%--   <asp:RequiredFieldValidator ID="reqBranchCode" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtBranchCode"></asp:RequiredFieldValidator>--%>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                         <asp:TemplateColumn HeaderText="Advance paid by">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtSignature" runat="server"      CssClass="input" Width="100px" BorderStyle="Groove" MaxLength="50"></asp:TextBox>
                                                         <%--       <asp:RequiredFieldValidator ID="reqSignature" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtSignature"></asp:RequiredFieldValidator>--%>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
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
                                                
                                                
                        
                                         <br>
                                            <asp:UpdatePanel ID="UpdatePanePayment" UpdateMode="Conditional" RenderMode="Inline" runat="server" >
                                                <ContentTemplate>
                                                    <UC2:UCPaymentControl ID="UCPayment" runat="server" ></UC2:UCPaymentControl>
                                                </ContentTemplate>
                                            </asp:UpdatePanel> 
                                            <br>
                                    
                                     
                                    </td>
                                 </tr>
                               </table>   
                                       
       
       
       
       
          </ContentTemplate>
       
      <%--       <Triggers>
          <atlas:ControlEventTrigger ControlID="chksel" EventName="CheckedChanged" />
      </Triggers>--%>
          
          
          
               </asp:UpdatePanel> 
       
                                                        
     </td>
                                 </tr>
                                 
                                 <tr>
                                 <td>
                                   <p align="center">
      <asp:Button ID="cmdSubmit" runat="server" Text="Submit >>"  Visible="true"   OnClick="cmdSubmit_Click"   />
     </p> 
              
                                 </td>
                                 </tr>
                                 
                               </table>   
                                       
            

                    
                    
     
      
   

                 
                 
 
    
              
<%--    
     OnClientClick="javascript:return valid()"   --%>

</asp:Content> 
