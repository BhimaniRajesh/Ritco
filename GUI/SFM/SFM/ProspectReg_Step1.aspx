<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ProspectReg_Step1.aspx.cs" Inherits="SFM_ProspectReg_Step1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
   
    <script language="javascript" type="text/javascript">
    function Validation(txtAddress,txtCity,txtComments,txtcompanyName,txtContactPerson,txtdate,txtDesignation,txtEmail,txtPhone,txtPin,txtWebsite,industryCode)
                {
                //ctl00_MyCPH1_btnDone
                if(industryCode.value=="Select")
                    {
                    alert("Please Select Industry");
                    industryCode.focus();
                    return false;
                    }
                if(txtAddress.value=="")
                    {
                    alert("Enter Address");
                    txtAddress.focus();
                    return false;
                    }
                if(txtCity.value=="")
                    {
                    alert("Enter City");
                    txtCity.focus();
                    return false;
                    }
                 
                 if(txtcompanyName.value=="")
                    {
                    alert("Enter Company");
                    txtcompanyName.focus();
                    return false;
                    }
                 if(txtContactPerson.value=="")
                    {
                    alert("Enter Contact Person");
                    txtContactPerson.focus();
                    return false;
                    }
                 if(txtdate.value=="")
                    {
                    alert("Enter Date");
                    txtdate.focus();
                    return false;
                    }
                 if(txtDesignation.value=="")
                    {
                    alert("Enter Designation");
                    txtDesignation.focus();
                    return false;
                    }
                 if(txtEmail.value=="")
                    {
                    alert("Enter Email");
                    txtEmail.focus();
                    return false;
                    }  
                    
                if(txtPhone.value=="")
                    {
                    alert("Enter Phone");
                    txtPhone.focus();
                    return false;
                    }   
                if(txtPin.value=="")
                    {
                    alert("Enter PIN");
                    txtPin.focus();
                    return false;
                    }   
                if(txtWebsite.value=="")
                    {
                    alert("Enter Website");
                    txtWebsite.focus();
                    return false;
                    }   

	        }
                    function checklocation(obj)
                        {
                        var a;
                        a=1;
                        obj.value = obj.value.toUpperCase()
                       for(i=0;i<str.length;i++)
                       {

                            if(obj.value==str[i])
                            {
                                a=2
                                if(!confirm("Comapny Name Already Exist.Do You want to continue with same name..."))
                                {
                                obj.focus();
                                return false
                                }
                                
                                break;
                            }
                            else
                            {
                                continue
                            }
                       }

                        

}

function convertinUpper(obj)
                        {
                        obj.value = obj.value.toUpperCase()
                        }
function EmailCheck(obj)
            {
                if (obj.value!="")
                {
                    if(obj.value.indexOf("@")==-1 || obj.value.indexOf(".")==-1)
                    {
                    alert("Invalid Email Address")
                    obj.focus();
                    return false;
                    }
                }
            }
            function PinCheck(txtPin)
            {
            if(txtPin.value!="")
	                {
		            if(isNaN(txtPin.value))
		                {
			            alert("Please Enter Only Number For PIN!!!")
			            txtPin.focus();
		                return false;
		                }
		            if((txtPin.value).length!=6)
		                {
			            alert("PIN should be 6 character long!!!")
			            txtPin.focus();
		                return false;
		                }
		            }
            }
            
            function PhoneCheck(txtPhone)
            {
             if(txtPhone!="")
	                {
		            if(isNaN(txtPhone))
		                {
			            alert("Please Enter Only Number For PIN!!!")
			            txtPhone.focus();
		                return false;
		                }
		            }    
            }
        </script>       
                    

    
    <table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Prospect Entry" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5" />
            </td>
        </tr>
        </table>
        <br />
    
            
            <table align="center" cellpadding="0" cellspacing="1" class="boxbg" width="85%">
            <tr class="bgbluegrey">
                <td align="center" class="bgbluegrey" style="height: 27px">
                <font class="blackfnt"><strong>Prospect Registration</strong></font></td>
            </tr>
        </table>
        <br />
        
        <table align="center" cellspacing="1" cellpadding="1" width="85%" border="0" class="boxbg" style="text-align: left">

               
                <tr bgcolor="white">
                    <td class="field1" style="width: 186px">
                        <font class="blackfnt">Prospect Id</font>
                    </td>
                    <td align="left" style="width: 138px" colspan="2">
                        &nbsp;<strong><span style="font-size: 8pt; color: #ff0000; font-family: Verdana">System
                            Genarated... </span></strong>
                    </td>
                    <td class="field1" style="width: 148px">
                         <font class="blackfnt">Registration date</font>
                    </td>
                    <td  align="left" style="width: 214px">
                        <asp:TextBox ID="txtdate" runat="server"></asp:TextBox></td>
                </tr>
                
                <tr bgcolor="white">
                    <td class="field1" style="width: 186px">
                         <font class="blackfnt">Company Name</font>
                    </td>
                    <td align="left" style="width: 138px" colspan="2">
                        <asp:TextBox ID="txtcompanyName" runat="server" onBlur="return checklocation(this)" Width="272px"></asp:TextBox>
                    </td>
                    
                    
                    <td class="field1" style="width: 148px">
                         <font class="blackfnt">Industry</font>
                    </td>
                    <td align="left" style="width: 214px">
                     <asp:DropDownList ID="industryCode" runat="server" Height="56px"
                         Style="left: 0px; position: relative; top: 0px" Width="136px">
                     </asp:DropDownList>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td class="field1" rowspan="2" style="width: 186px; height: 23px">
                         <font class="blackfnt">Address</font>
                    </td>
                    <td align="left" rowspan="2" style="height: 23px; width: 138px;" colspan="2">
                    <asp:TextBox ID="txtAddress" runat="server" onBlur="return convertinUpper(this)" Height="50px" Width="272px" TextMode="MultiLine"></asp:TextBox>
                       
                    </td>
                    <td class="field1" style="width: 148px; height: 27px">
                         <font class="blackfnt">Contact Person</font>
                    </td>
                    <td align="left" style="width: 138px; height: 27px;">
                        <asp:TextBox ID="txtContactPerson" runat="server" onBlur="return convertinUpper(this)"></asp:TextBox>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td class="field1" style="width: 186px">
                         <font class="blackfnt">Designation</font>
                    </td>
                    <td align="left" style="width: 138px">
                        <asp:TextBox ID="txtDesignation" runat="server" onBlur="return convertinUpper(this)"></asp:TextBox>
                        
                    </td>
                </tr>
                
                <tr bgcolor="white" >
                    <td class="field1" style="width: 186px">
                    <font class="blackfnt">City-Pin</font>
                       
                    </td>
                    <td align="left" style="width: 57px">
                      <asp:TextBox ID="txtCity" runat="server" Width="154px" onBlur="return convertinUpper(this)"></asp:TextBox>  
                        
                        <td align="left" style="width: 66px">
                        <asp:TextBox ID="txtPin" runat="server" Width="108px" MaxLength="6"></asp:TextBox>
                        </td>
                    </td>
                    <td style="width: 148px"><font class="blackfnt" >Phone</font></td>
                    <td>
                    <asp:TextBox ID="txtPhone" runat="server" Width="129px"></asp:TextBox>  
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td class="field1" style="width: 186px; height: 22px;">
                        <font class="blackfnt">Email</font>
                    </td>
                    <td align="left" style="width: 138px; height: 22px;" colspan="2">
                        <asp:TextBox ID="txtEmail" runat="server" Width="272px"></asp:TextBox> 
                        
                    </td>
                    <td style="width: 148px; height: 22px;" rowspan="2">
                        <font class="blackfnt">Comments</font>
                   </td>
                   <td style="height: 22px"  rowspan="2">
                   
                   <asp:TextBox ID="txtComments" runat="server" onBlur="return convertinUpper(this)" Height="56px" Width="272px" TextMode="MultiLine"></asp:TextBox>
                     </td>
                </tr>
                
                <tr bgcolor="white">
                    <td class="field1" style="width: 186px; height: 22px;">
                        <font class="blackfnt">Website</font>
                    </td>
                    <td align="left" style="width: 138px; height: 22px;" colspan="2">
                         <asp:TextBox ID="txtWebsite" runat="server" Width="272px"></asp:TextBox>
                        
                    </td>
                    
                     
                </tr>
                
                <tr id="loadpyament" runat="server" bgcolor="white" visible="false">
                    <td class="field1" style="width: 186px; height: 22px;">
                        <font class="blackfnt">Load Type</font>
                    </td>
                    <td align="left" style="width: 138px; height: 22px;" colspan="2">
                        <asp:TextBox ID="txtLoadType" runat="server" Width="272px"></asp:TextBox> 
                        
                    </td>
                    <td style="width: 148px; height: 22px;" rowspan="2">
                        <font class="blackfnt">Payment System</font>
                   </td>
                   <td style="height: 22px"  rowspan="2">
                   
                   <asp:TextBox ID="txtPaymentSystem" runat="server" onBlur="return convertinUpper(this)"></asp:TextBox>
                     </td>
                </tr>
                <tr id="routes" runat="server" bgcolor="white" visible="false">
                    <td class="field1" style="width: 186px; height: 22px;">
                        <font class="blackfnt">Main Routes</font>
                    </td>
                    <td align="left" style="width: 138px; height: 22px;" colspan="2">
                         <asp:TextBox ID="txtMainroutes" runat="server" onBlur="return convertinUpper(this)" Width="272px"></asp:TextBox>
                        
                    </td>
                    
                     
                </tr>
          </table><br />
          
        <table align="center">
            <tr>
                <td align="center" style="width: 768px; height: 23px">
                    <asp:Button ID="btnDone" runat="server" 
                        Style="left: 40px; position: relative; top: 0px" Text="Submit" OnClick="btnDone_Click" />
                </td>
              
            </tr>
           
           
        </table>
            
    
    

</asp:Content>
