<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"          CodeFile="TripsheetSimpleEdit.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_TripsheetSimpleEdit" %>
 <%@ Register TagPrefix="UC2" TagName="UCPaymentControl" Src="~/UserControls/PaymentControl.ascx" %>
 
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
   <script language="javascript" type="text/javascript">
       
 
//   function ShowAmt()
//   {
//            var grid1=document.getElementById("ctl00_MyCPH1_dgAdvancedet");
//             var r1=grid1.rows.length;
//       
//         for(i=0;i< r1-1;i++)
//        {
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
//           if (document.getElementById(pref  +"chksel").checked==true)
//           {
//           
//              if(document.getElementById(pref  +"txtAdvAmt").value!="")
//               {
//                 document.getElementById("ctl00$MyCPH1$UCPayment$txtAmount").value= document.getElementById(pref  +"txtAdvAmt").value;       
//              
//               }
//           }
//  
//       }
//   }
 
 
 
 
 
 function formatDate(dateString)
 {
 var inputDate=dateString.split('/');
 return inputDate[1]+'/'+inputDate[0]+'/'+inputDate[2]
 }
function isDate(dateString){
var datePat=/^(\d{1,2})(\/|-)(\d{1,2})(\/|-)(\d{4})$/;
var matchArray=dateString.match(datePat);
if(matchArray==null)return false;
month=matchArray[1];day=matchArray[3];year=matchArray[5];
if(month<1||month>12)return false;if(day<1||day>31)return false;
if((month==4||month==6||month==9||month==11)&&day==31)return false;
if(month==2){var isleap=(year%4==0&&(year%100!=0||year%400==0));
if(day>29||(day==29&&!isleap))return false;}return true;
}

 
        
        function nwOpen1(mNo)
        {
            window.open("../../../popups/Popup-Vehicle.aspx?mNo=" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        
        function nwOpen3(mNo)
        {
            window.open("../../../popups/Popup-Driver1.aspx?id=D1&mNo=" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        
        
          function nwOpen(mNo)
        {
            window.open("popup-CUST.aspx?mNo=" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        
         function nwOpenCity(strval)
        {
            //alert(strval);
            if(strval=="1")
            {
            window.open("popup-city1.aspx?city_mode=1" ,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
            }
            else
            {
            window.open("popup-city1.aspx?city_mode=2" ,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
            }
        }
        
        // function valid(obj,tran,chqno,chqdate)
           function valid()
          {
         
          
           if (document.getElementById('ctl00_MyCPH1_txtTripDate').value=="")
                {
                    alert("Please enter Tripsheet Date");
                    document.getElementById('ctl00_MyCPH1_txtTripDate').focus();
                    return false;
                }
          
          
          
             if (!isDate(formatDate(document.getElementById('ctl00_MyCPH1_txtTripDate').value)))
             {
              alert('Invalid Tripsheet Date');
              document.getElementById('ctl00_MyCPH1_txtTripDate').focus(); 
              return false;
              } 
          
          
             if (document.getElementById('ctl00_MyCPH1_txtManualTripSheetNo').value=="")
                {
                    alert("Please enter Manual Trip Sheet No.");
                    document.getElementById('ctl00_MyCPH1_txtManualTripSheetNo').focus();
                    return false;
                }
       
             
                
                
                  if (document.getElementById('ctl00_MyCPH1_txtVehNo').value=="")
                {
                    alert("Please select Vehicle Number");
                    document.getElementById('ctl00_MyCPH1_txtVehNo').focus();
                    return false;
                }
                 if (document.getElementById('ctl00_MyCPH1_txtDriver1').value=="")
                {
                    alert("Please select Driver-1");
                    document.getElementById('ctl00_MyCPH1_txtDriver1').focus();
                    return false;
                }
            
 
                if (document.getElementById('ctl00_MyCPH1_ddlCategory').value=="")
                {
                    alert("Please select category ");
                    document.getElementById('ctl00_MyCPH1_ddlCategory').focus();
                    return false;
                }
            
            if (document.getElementById('ctl00_MyCPH1_ddlCategory').value=="External Usage")
           {                
                if (document.getElementById('ctl00_MyCPH1_txtCustCode').value=="")
                {
                    alert("Please enter Customer code");
                    document.getElementById('ctl00_MyCPH1_txtCustCode').focus();
                    return false;
                }
                
          
                 if (document.getElementById('ctl00_MyCPH1_txtFromCity').value=="")
                {
                    alert("From City can not be blank");
                    document.getElementById('ctl00_MyCPH1_txtFromCity').focus();
                    return false;
                }
               if (document.getElementById('ctl00_MyCPH1_txtToCity').value=="")
               {
                alert("To City can not be blank");
                document.getElementById('ctl00_MyCPH1_txtToCity').focus();
                return false;
                }
            
                if (document.getElementById('ctl00_MyCPH1_txtFromCity').value==document.getElementById('ctl00_MyCPH1_txtToCity').value)
                {
                    alert("From and To City can not be same");
                    document.getElementById('ctl00_MyCPH1_txtFromCity').focus();
                    return false;
                }
                
          }
 
                    
  }
 
       
        </script>




 <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Trip Sheet >> Edit</asp:Label>

            </td>
              <td align="right">
                < <asp:UpdateProgress ID="uppMain" runat="server">
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
         
          </td>      
        </tr>
    </table>
    <hr align="center" size="1" color="#8ba0e5">
 <br/> 

  
      <table cellspacing="1" align="center"  cellpadding="3" style="width: 80%"     border="0">
            
            <tr style="background-color: white">
                <td   align="center" >
                
                
               <asp:UpdatePanel ID="UpdatePanel4" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate> 
                        <asp:Panel runat="server" ID="Panel7" Visible="true">
                
                                   
                                   
      <table cellspacing="1" cellpadding="3" width="100%" align="center" class="boxbg" border="0">
            
            <tr style="background-color: white">
                <td   align="center">
    
                
                    <asp:Label ID="lblError"  runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor="red"></asp:Label>
                                        <asp:Label ID="lblError1"  runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor="red"></asp:Label>
                    </td>
                           
                    
            </tr>
            
            <tr class="bgbluegrey">
                <td colspan="4" align="center">
                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="EDIT/UPDATE VEHICLE ISSUE SLIP"></asp:Label></td>
                           
                    
            </tr>
            
            <tr style="background-color: white">
            
              <td colspan=4 align="center" style="background-color: white">   
          <table     border="1" cellpadding="3" cellspacing="1" class="boxbg" width="100%">
            
             <tr style="background-color: white">
            
                <td align="left" >
                  <font class="bluefnt">Issue Slip Id</font>
                </td>
                <td align="left">
                  <asp:Label ID="lblIssueNo" runat=server CssClass="blackfnt"></asp:Label>
                </td>
                <td align="left">
                <font class=bluefnt>Issue Slip Date</font> <font class=blackfnt>(dd/mm/yyyy)</font>
                </td>
                <td align="left">
               <%--   <asp:Label ID="lblIssueDt" runat=server CssClass="blackfnt"></asp:Label>--%>
               <asp:TextBox ID="txtTripDate" runat="server" Width="100" BorderStyle="Groove" ></asp:TextBox>
                 <asp:RequiredFieldValidator ID="ReqtxtTripDate" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtTripDate" ></asp:RequiredFieldValidator>
                 <asp:RegularExpressionValidator ID="REVtxtTripDate" runat="server" ControlToValidate="txtTripDate"
                                                                            ErrorMessage="!" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                                                            Width="1px"></asp:RegularExpressionValidator>
               
                </td>
            </tr>
            
             <tr style="background-color: white" >
              <td align="left"  >

                    
                     
                  <font class="blackfnt" color=red>*</font> <font class=bluefnt>Vehicle No.</font>
                </td>
                <td align="left"  >
                       <font class=blackfnt >
                 
                     <asp:UpdatePanel ID="UpdatePanel9" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                    <ContentTemplate>
                   <asp:TextBox ID="txtVehNo"   AutoPostBack="true" CssClass="input"  runat=server OnTextChanged="txtVehNo_TextChanged"   ></asp:TextBox>
                    <asp:Label ID="Label3"      runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen1(1)">...</a>'
                                Width="14px"></asp:Label> 
                                
                                 <asp:Label ID="lblVehCheck"  Visible="false"    runat="server"    CssClass="redfnt"></asp:Label> 
                              
                  
                    
                   </ContentTemplate>
                     <Triggers>
                          <asp:AsyncPostBackTrigger ControlID="txtVehNo" EventName="TextChanged" />
                    </Triggers>
                    </asp:UpdatePanel> 
                 <asp:RequiredFieldValidator ID="ReqVehno" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtVehNo" ></asp:RequiredFieldValidator>
                   </font>
                </td>
                 
                
                
              
            
                    
                    <td align="left" >
                  <font class="blackfnt" color=red>*</font> <font class=bluefnt>Manual Trip Sheet No.</font>
                </td>
                <td align="left">
                   <font class=blackfnt >
                   <asp:TextBox ID="txtManualTripSheetNo" runat=server BorderStyle="Groove" Width="100" MaxLength="10" CssClass="input" OnTextChanged="Check_ManualTripSheetNo"  AutoPostBack="true"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="ReqtxtManualTripSheetNo" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtManualTripSheetNo" ></asp:RequiredFieldValidator>
                   
                   <asp:UpdatePanel ID="UpdatePanel2" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:Label ID="lblMTS" runat=server CssClass="balckfnt" ForeColor=red></asp:Label>
                     </ContentTemplate>
                     <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="txtManualTripSheetNo" EventName="TextChanged" />
                    </Triggers>
                    </asp:UpdatePanel> 
                   </font>
                </td>
                    
             
                
               
                
            </tr>
              <tr style="background-color: white" >
            
        
                 <td align="left" >
                  <font class="blackfnt" color=red>*</font> <font class=bluefnt>Driver1 Manual Code</font>
                </td>
                <td align="left" colspan="3">
                   <font class=blackfnt >
                   
                     <asp:UpdatePanel ID="UpdatePanel1" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                    <ContentTemplate>
                      <asp:TextBox ID="txtDriver1"   AutoPostBack="true" CssClass="input"  runat="server"  OnTextChanged="RetrieveDriverDataInfo1"     ></asp:TextBox>
                      <asp:HiddenField ID="hdfldManualDriverCode" runat="server" />
                      
                      
                    <asp:Label ID="Label4"      runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen3(1)">...</a>'
                                Width="14px"></asp:Label> 
                                
                                <asp:Label ID="lblD1Error"  Visible="false"    runat="server"    CssClass="redfnt"></asp:Label> 
                             
                    <asp:RequiredFieldValidator ID="ReqDriver1" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDriver1" ></asp:RequiredFieldValidator>
                                    </ContentTemplate>
                     <Triggers>
                    
                        
                          <asp:AsyncPostBackTrigger ControlID="txtDriver1" EventName="TextChanged" />
                    </Triggers>
                    </asp:UpdatePanel> 
                  
                  
                  
                   </font>
                </td>
           
            
            
              </tr>
            
       
            
            
            
            
            
             <tr style="background-color: white">
                <td align="left" >
                  <font class="bluefnt">Starting Location</font>
                </td>
                <td align="left">
                  <asp:Label ID="lblStartLoc" runat=server CssClass="blackfnt"></asp:Label>
                </td>
                <td align="left">
                <font class=bluefnt>End Location</font>
                </td>
                <td align="left">
                  <asp:Label ID="lblEndLoc" runat=server CssClass="blackfnt"></asp:Label>
                </td>
            </tr>
            
            
            
                                <tr style="background-color: white">
                <td align="left"   > <font class="blackfnt" color=red>*</font>
                  <font class="bluefnt">Category</font>
                </td>
                 <td align="left" style="height: 46px" >
                   <asp:DropDownList ID="ddlCategory" runat="server" CssClass="blackfnt"  AutoPostBack="true" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
                       <asp:ListItem Selected="True" Value="">Select</asp:ListItem>
                       <asp:ListItem Value="External Usage">External Usage</asp:ListItem>
                       <asp:ListItem Value="Internal Usage">Internal Usage</asp:ListItem>
                   </asp:DropDownList>
                      <asp:RequiredFieldValidator ID="Reqcategory" runat="server" Display="Dynamic" Text="!" ControlToValidate="ddlCategory" ></asp:RequiredFieldValidator>
                </td>
           
                
                <td align="left" >
                  <asp:UpdatePanel ID="upCurrLocationCode1" runat="server">
                        <ContentTemplate>
            
                  <asp:Label ID="lblCutcode" runat="server"  Text="Enter Customer Code" Visible="false" CssClass="bluefnt" />
                     <asp:Label ID="lblMarket_own" runat="server"  Text="Market\Own" Visible="false" CssClass="bluefnt" />
                  
                   </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddlCategory" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
                
                <td align="left">
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                <table id="Table1" runat="server" visible="false">
                <tr>
                                
                 <td align="left" colspan="1">
                 
                            <asp:DropDownList  ID="ddlMarket"  runat="server" Visible="false" >
                         
                                <asp:ListItem  Selected="True" Value="Own" >Own</asp:ListItem>
                            </asp:DropDownList>
                            <asp:TextBox ID="txtCustCode" AutoPostBack="true"  runat="server" Width="100px"   CssClass="input"
                                MaxLength="4" OnTextChanged="txtCustCode_TextChanged1"  ></asp:TextBox>&nbsp;
                       <asp:Label ID="lblPopup"    Visible="false" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen(1)">...</a>'
                                Width="14px"></asp:Label> 
                           
                                
                                
                                  <asp:RequiredFieldValidator ID="ReqCustCode" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtCustCode" ></asp:RequiredFieldValidator>
                            <asp:Label  id="lblErrorLocation1"   class="blackfnt"  ForeColor="red"  runat="server" 
                                visible="false">
                    
                            </asp:Label>
                     

                </td>
               
                </tr>
            
            
            
                
                
                </table>
                       </ContentTemplate>
                        <Triggers>
 
                                                           <asp:AsyncPostBackTrigger ControlID="ddlCategory" EventName="SelectedIndexChanged" />
                                                        <asp:AsyncPostBackTrigger ControlID="txtCustCode" EventName="TextChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
                
         
                
                
                </tr>
                
               </table> 
                
            
            
                   <br>
     <asp:UpdatePanel ID="UpdatePanel8" runat="server">
     <ContentTemplate>
      <table cellspacing="1" cellpadding="3" width="75%"  border=0>
         <tr><td>
                    <table cellspacing="1" cellpadding="3" width="75%" class="boxbg" align=left border="0"  >
                        <tr style="background-color: white">
                            <td align=left><font class="bluefnt">From City</font></td>
                            <td><asp:TextBox ID="txtFromCity"  runat="server" Width="100px" CssClass="input" AutoPostBack=true OnTextChanged="CheckCity"></asp:TextBox>
                            
                            <asp:Label ID="Label1"    Visible="true" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpenCity(1)">...</a>'
                                Width="14px"></asp:Label> 
                                <asp:Label ID="lblFromCity" CssClass="blackfnt" runat=server ForeColor=red></asp:Label>
                            </td>
                            <td align=left><font class="bluefnt">To City</font></td>
                            <td><asp:TextBox ID="txtToCity"  runat="server" Width="100px" CssClass="input"  AutoPostBack=true OnTextChanged="CheckCity"></asp:TextBox>
                            
                             <asp:Label ID="Label2"    Visible="true" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpenCity(2)">...</a>'
                                Width="14px"></asp:Label> 
                                <asp:Label ID="lblToCity" CssClass="blackfnt" runat=server  ForeColor=red></asp:Label>

                            </td>
                           
                        </tr>
                        
                        
                    </table>
          </td></tr>          
     </table>
                </ContentTemplate>
                     <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddlCategory" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>  
                    <br>
            
            
            
           
            
          
            </table>
            

                    
                    
     
      <br/>
                      
                      
            
            
            
              </asp:Panel>
            </ContentTemplate>
                 </asp:UpdatePanel> 
                 </td>
                 </tr>
                 
           <%--           <tr>
     <td align="center"  colspan="4"  >
 <asp:Button ID="Button1" runat="server" Text="Submit >>"    OnClientClick="javascript:return valid()"     OnClick="cmdSubmit_Click"   />
      </td>
      </tr> --%>

                 
                 
                 
            </table>
         
                      <br/>
                    
      
                      
                      
                      
                      
                      
                      
                      
     
      <p align="center">
      <asp:Button ID="cmdSubmit" runat="server" Text="Submit >>"  Visible="true"  OnClientClick="javascript:return valid()"    OnClick="cmdSubmit_Click"   />
     </p> 
              
              
<%--    
     OnClientClick="javascript:return valid()"   --%>

</asp:Content> 
