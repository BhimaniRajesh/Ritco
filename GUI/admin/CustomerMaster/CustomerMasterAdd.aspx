 <%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="CustomerMasterAdd.aspx.cs" Inherits="GUI_admin_CustomerMaster_CustomerMasterAdd"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
      
      function nwOpen(mNo)
        {
            window.open("popupLoc.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        
        
      
     function checklocation(obj)
        {
   
   
     var a;
        a=1;
       
        obj.value = obj.value.toUpperCase()
   
    var test1 = obj.value.substring((obj.value.length - 1),(obj.value.length))
    if(test1 == ",")
    {
       var s = obj.value.substring(0,(obj.value.length - 1))
       }
       else
    {
       var s = obj.value
       }
               
      
      
        var loc = s.split(",")
        
       
       
            for(j=0;j<loc.length;j++)
             {
                 a=1;
                for(i=0;i < str.length;i++)
                {
                    if(loc[j].length > 2)
                    { 
                             if(loc[j] == str[i])
                            {
                                a=2
                                break;
                                //return false;
                             }
                             else
                            {
                                continue
                            }
                    }
                  //  break
                }
       
      
       if (a!=2)
       {
        alert("please enter valid location : " +loc[j])
          obj.focus();
          return false;
      
       }
         
  }
 return true;
}   
     
function x(id)
{
 
    if(!ValidateData())
        return false;
    
    if(!checklocation(id))
        return false;
        
        return true;
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
        
        
         function lenthless(obj)
        {
        
         alert("No Shold be 10 Digit long.")
        
        if (obj.length <10)
        {
        alert("No Shold be 10 Digit long.")
        return false;
        }
        obj.focus();
        return true;
        }
     
      function IsNumericDot(sText)
        {
           var ValidChars = "0123456789.";
           var IsNumber=true;
           var Char;

           for (i = 0; i < sText.length && IsNumber == true; i++) 
           { 
              Char = sText.charAt(i); 
              
              if (ValidChars.indexOf(Char) == -1) 
              {
                IsNumber = false;
              }
           }
           
           return IsNumber;
        }
         
         function IsNumericComma(obj)
        {
          var sText = obj.value;
        
           var ValidChars = "0123456789,";
           var IsNumber=true;
           var Char;

           for (i = 0; i < sText.length && IsNumber == true; i++) 
           { 
              Char = sText.charAt(i); 
              
              if (ValidChars.indexOf(Char) == -1) 
              {
              alert("Only Numbers Are Allowed");
              obj.focus();
              return false;
                IsNumber = false;
              }
           }
           
           return true;
        }
         
          function IsNumericDot2(sText)
        {
           var ValidChars = "0123456789,";
           var IsNumber=true;
           var Char;

           for (i = 0; i < sText.length && IsNumber == true; i++) 
           { 
              Char = sText.charAt(i); 
              
              if (ValidChars.indexOf(Char) == -1) 
              {
                IsNumber = false;
              }
           }
           
           return IsNumber;
        }
        
       function IsNumericWoDot(sText)
        {
           var ValidChars = "0123456789";
           var IsNumber=true;
           var Char;

           for (i = 0; i < sText.length && IsNumber == true; i++) 
           { 
              Char = sText.charAt(i); 
              
              if (ValidChars.indexOf(Char) == -1) 
              {
                IsNumber = false;
              }
           }
           
           return IsNumber;
        } 
        function IsText(sText)
        {
           var ValidChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
           var IsText=true;
           var Char;

           for (i = 0; i < sText.length && IsText == true; i++) 
           { 
              Char = sText.charAt(i); 
              
              if (ValidChars.indexOf(Char) == -1) 
              {
                IsText = false;
              }
           }
           
           return IsText;
        }
    
    function ValidateData()
    {   
     
     
//     if(document.getElementById("ctl00_MyCPH1_txttel"))
//        {
//        IsNumericComma();
////            if(IsNumericDot2(document.getElementById("ctl00_MyCPH1_txttel").value) == false)
////            {
////                alert("Enter telephone Number in Postive Numeric Format");
////                document.getElementById("ctl00_MyCPH1_txttel").focus();
////                return false;
////            }
//        }


  if(document.getElementById("ctl00_MyCPH1_txtCstNm"))
        {
            if(document.getElementById("ctl00_MyCPH1_txtCstNm").value == "")
            {
                alert("Enter Customer Name");
                document.getElementById("ctl00_MyCPH1_txtCstNm").focus();
                return false;
            }
        } 
        
//         if(document.getElementById("ctl00_MyCPH1_txtpan"))
//        {
//            if(Falphanum(document.getElementById("ctl00_MyCPH1_txtpan").value) == false)
//            {
//                alert("Please Enter Only Alpha Numeric Value");
//                document.getElementById("ctl00_MyCPH1_txtpan").focus();
//                return false;
//            }
//        }
 
 if(document.getElementById("ctl00_MyCPH1_txtpin"))
        {
            if((document.getElementById("ctl00_MyCPH1_txtpin").value) == "")
            {
                alert("Enter Pincode");
                document.getElementById("ctl00_MyCPH1_txtpin").focus();
                return false;
            }
            
        }
   if(document.getElementById("ctl00_MyCPH1_ddcity"))
        {
            if((document.getElementById("ctl00_MyCPH1_ddcity").value) == "-- Select --")
            {
                alert("Select City");
                document.getElementById("ctl00_MyCPH1_ddcity").focus();
                return false;
            }
        }
    if(document.getElementById("ctl00_MyCPH1_c2"))
        {
            if(document.getElementById("ctl00_MyCPH1_c2").checked == true)
            {
        
            
            if(document.getElementById("ctl00_MyCPH1_txtMblNo").value == "")
            {
                alert("Enter Mobile  No");
                document.getElementById("ctl00_MyCPH1_txtMblNo").focus();
                return false;
                }
                
                 if(document.getElementById("ctl00_MyCPH1_txtMblNo").value.length < 10)
            {
                alert("Telephone No Can not be Less than 10 digit");
                document.getElementById("ctl00_MyCPH1_txtMblNo").focus();
                return false;
                }
                return true;
            }
        } 
        
        
    
       if(document.getElementById("ctl00_MyCPH1_ddCstCat"))
        {
            if(document.getElementById("ctl00_MyCPH1_ddCstCat").value == "--Select--")
            {
                alert("Enter Customer Category");
                document.getElementById("ctl00_MyCPH1_ddCstCat").focus();
                return false;
            }
        }  
        
      if(document.getElementById("ctl00_MyCPH1_txtOpnDbt"))
        {
            if(IsNumericDot(document.getElementById("ctl00_MyCPH1_txtOpnDbt").value) == false)
            {
                alert("Enter Open Debit in Postive Numeric Format");
                document.getElementById("ctl00_MyCPH1_txtOpnDbt").focus();
                return false;
            }
        }
      if(document.getElementById("ctl00_MyCPH1_txtOpnCrdt"))
        {
            if(IsNumericDot(document.getElementById("ctl00_MyCPH1_txtOpnCrdt").value) == false)
            {
                alert("Enter Open Credit in Postive Numeric Format");
                document.getElementById("ctl00_MyCPH1_txtOpnCrdt").focus();
                return false;
            }
        }
      if(document.getElementById("ctl00_MyCPH1_txtMblNo"))
        {
            if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtMblNo").value) == false)
            {
                alert("Enter Mobile Number in Postive Numeric Format");
                document.getElementById("ctl00_MyCPH1_txtMblNo").focus();
                return false;
            }
        }
        
        
          
        
        return true;
       
          
     }        
       
       
function Nagative_Chk_wDecimal(obj)
{
  
var temp
temp=obj.value
  
if(isNaN(temp))
{
alert("Value should be Numeric")
 obj.value=""
obj.focus();
return false;
}
  
}


 function Falphanum2(obj)
 {

 
  var uid=obj.value 
 
 
   if (uid.length <10)
        {
        alert("No Shold be 10 Digit long.")
        obj.focus();
        return false;
        }
        
        
        
  var str1="'!@#$%^&*()-+~`/\.[],{}:"
  flag="0"
	for(i=0;i<uid.length;i++){
		   for(j=0;j<str1.length;j++){
					if(uid.charAt(i)==str1.charAt(j)){
							flag="1";
							break;
					}else {
							//flag="0"
					}
					if(flag=="1"){
						break;
					}
		 	}
	}
	if(flag=="1"){
		alert("Please Enter Alphabetic or Numeric Values.")
		obj.focus();
		return false;
	}
						
}
 function Falphanum(obj)
 {

 
  var uid=obj.value 
 
 
        
        
        
  var str1="'!@#$%^&*()-+~`/\.[],{}:"
  flag="0"
	for(i=0;i<uid.length;i++){
		   for(j=0;j<str1.length;j++){
					if(uid.charAt(i)==str1.charAt(j)){
							flag="1";
							break;
					}else {
							//flag="0"
					}
					if(flag=="1"){
						break;
					}
		 	}
	}
	if(flag=="1"){
		alert("Please Enter Alphabetic or Numeric Values.")
		obj.focus();
		return false;
	}
						
}
    </script>

    <div style="width: 10in">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%">
                        <tr>
                            <td height="30">
                                <a href=""><font class="blklnkund"><strong>Module</strong></font></a> &gt; <a href="">
                                    <font class="blklnkund"><strong>Administrator </strong></font></a>&gt; <a href=""><font
                                        class="blklnkund"><strong>Business Partners</strong></font></a> <font class="bluefnt">
                                            <strong>&gt; Customer Master</strong> </font>
                            </td>
                        </tr>
                        <tr>
                            <td class="horzblue">
                                <img src="../../images/clear.gif" width="2" height="1" alt="" /></td>
                        </tr>
                        <tr>
                            <td>
                                <img src="../../images/clear.gif" width="15" height="10" alt="" /></td>
                        </tr>
                        <!--         <tr> 
          <td align=right><a href="javascript:window.history.go(-1)" Title="back"><img src="../../images/back.gif" border=0></a></td>
        </tr> -->
                        <tr>
                            <td>
                                <br />
                                <table border="0" width="100%">
                                    <tr>
                                        <td width="39%" valign="top">
                                            <table border="0" width="100%">
                                                <tr>
                                                    <td height="300" valign="top">
                                                        <!--START-->
                                                        <table align="center" border="0" cellpadding="0" cellspacing="1" width="100%" class="boxbg">
                                                            <tr class="bgbluegrey">
                                                                <td colspan="3" align="center" style="height: 19px">
                                                                    <font class="blackfnt"><b>CUSTOMER MASTER SCREEN</b></font></td>
                                                            </tr>
                                                            <tr>
                                                                <td bgcolor="#FFFFFF">
                                                                    <table border="1" cellspacing="0" cellpadding="3" width="100%">
                                                                        <tr>
                                                                            <td>
                                                                                <font class="blackfnt">Group Code</font></td>
                                                                            <td>
                                                                                <font class="blackfnt">:</font></td>
                                                                            <td>
                                                                                <font class="blackfnt">
                                                                                    <asp:Label ID="lblGrpCd" runat="server" Text="Label"></asp:Label></font></td>
                                                                            <%--<td></td>--%>
                                                                            <td>
                                                                                <font class="blackfnt"></font>
                                                                            </td>
                                                                            <%--</tr>--%>
                                                                            <td valign="top">
                                                                                <font class="blackfnt">Customer Code</font></td>
                                                                            <td>
                                                                                <font class="blackfnt">:</font></td>
                                                                            <td>
                                                                                <font class="blackfnt" color="red">< System Generated... ></font></td>
                                                                            <td>
                                                                                <font class="blackfnt" color="red"></font>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <font class="blackfnt">Customer Name</font></td>
                                                                            <td>
                                                                                <font class="blackfnt">:</font></td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtCstNm" runat="server" MaxLength="45" CssClass="input" onpaste="return false" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                                                                            </td>
                                                                            <%--<td></td>--%>
                                                                            <td>
                                                                                <font class="blackfnt"></font>
                                                                            </td>
                                                                            <td>
                                                                                <font class="blackfnt">Customer Password</font></td>
                                                                            <td>
                                                                                :</td>
                                                                            <td>
                                                                                <font class="blackfnt" color="red">< System Generated... ></font>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <font class="blackfnt">Customer Category</font></td>
                                                                            <td>
                                                                                <font class="blackfnt">:</font></td>
                                                                            <td>
                                                                                <asp:DropDownList ID="ddCstCat" runat="server" CssClass="input">
                                                                                  <%--  <asp:ListItem>--Select--</asp:ListItem>
                                                                                    <asp:ListItem>TBB</asp:ListItem>
                                                                                    <asp:ListItem>BOD</asp:ListItem>
                                                                                    <asp:ListItem>TRIAL TBB</asp:ListItem>--%>
                                                                                </asp:DropDownList></td>
                                                                            <td>
                                                                            </td>
                                                                            <td>
                                                                                <font class="blackfnt">Active Flag</font></td>
                                                                            <td>
                                                                                :</td>
                                                                            <td>
                                                                                <asp:UpdatePanel ID="upChkActFlag" runat="server">
                                                                                    <ContentTemplate>
                                                                                        <asp:CheckBox ID="c1" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="c1_CheckedChanged"
                                                                                            Width="10px" />
                                                                                        <asp:TextBox ID="txtActFlag" Enabled="false" runat="server" Width="40px" OnChange="Javascript:this.value=this.value.toUpperCase();">Y</asp:TextBox>&nbsp;
                                                                                    </ContentTemplate>
                                                                                    <Triggers>
                                                                                        <asp:AsyncPostBackTrigger ControlID="c1" EventName="CheckedChanged" />
                                                                                    </Triggers>
                                                                                </asp:UpdatePanel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <font class="blackfnt">Mobile Service</font></td>
                                                                            <td>
                                                                                <font class="blackfnt">:</font></td>
                                                                            <td>
                                                                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                                                    <ContentTemplate>
                                                                                        <asp:CheckBox ID="c2" runat="server" AutoPostBack="True" OnCheckedChanged="c2_CheckedChanged"
                                                                                            Width="19px" />
                                                                                        <asp:TextBox ID="txtMblSer" Enabled="false" runat="server" Width="40px" OnChange="Javascript:this.value=this.value.toUpperCase();">N</asp:TextBox>&nbsp;
                                                                                    </ContentTemplate>
                                                                                    <Triggers>
                                                                                        <asp:AsyncPostBackTrigger ControlID="c2" EventName="CheckedChanged" />
                                                                                    </Triggers>
                                                                                </asp:UpdatePanel>
                                                                            </td>
                                                                            <td>
                                                                            </td>
                                                                            <td>
                                                                                <font class="blackfnt">Mobile Number</font></td>
                                                                            <td>
                                                                                :</td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtMblNo" MaxLength="10" runat="server"></asp:TextBox></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <font class="blackfnt">Telephone No. <font size="1">(Separated by commas)</font></font></td>
                                                                            <td>
                                                                                <font class="blackfnt">:</font></td>
                                                                            <td colspan="4">
                                                                                <asp:TextBox ID="txttel" runat="server" MaxLength="50" Width="250px"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <font class="blackfnt">ST Number</font></td>
                                                                            <td>
                                                                                <font class="blackfnt">:</font></td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtStNo" MaxLength="13" runat="server"></asp:TextBox></td>
                                                                            <td>
                                                                            </td>
                                                                            <td>
                                                                                <font class="blackfnt">PAN Number</font></td>
                                                                            <td>
                                                                                :</td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtpan" MaxLength="10" runat="server"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <font class="blackfnt">E-mail :</font></td>
                                                                            <td>
                                                                                <font class="blackfnt">:</font></td>
                                                                            <td colspan="4">
                                                                                <asp:TextBox ID="txtemail" runat="server" onblur="EmailCheck(this)" Width="250px"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <font class="blackfnt">City</font></td>
                                                                            <td>
                                                                                <font class="blackfnt">:</font></td>
                                                                            <td>
                                                                                <asp:DropDownList ID="ddcity" runat="server" Width="150" CssClass="input">
                                                                                </asp:DropDownList></td>
                                                                            <td>
                                                                            </td>
                                                                            <td>
                                                                                <font class="blackfnt">Pin Code</font></td>
                                                                            <td>
                                                                                :</td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtpin" MaxLength="6" runat="server"></asp:TextBox></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <font class="blackfnt">Customer Locations <font size="1">(Separated by commas)</font></font></td>
                                                                            <td>
                                                                                <font class="blackfnt">:</font></td>
                                                                            <td colspan="4">
                                                                                <asp:TextBox ID="txtCstLoc" runat="server" Width="381px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                                                                                <asp:Label ID="Label1" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen(1)">...</a>'
                                                                                    Width="14px"></asp:Label></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <font class="blackfnt">Customer Address </font>
                                                                            </td>
                                                                            <td>
                                                                                <font class="blackfnt">:</font></td>
                                                                            <td >
                                                                                <asp:TextBox ID="txtCstAddress" runat="server" Height="43px" TextMode="MultiLine"
                                                                                    Width="222px"></asp:TextBox></td>
                                                                            <td>
                                                                            </td>
                                                                            <td>
                                                                                <font class="blackfnt">Vendor Code</font></td>
                                                                            <td>
                                                                                :</td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtVendorCode" MaxLength="50" runat="server"></asp:TextBox></td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        <br />
                                                        <table align="center" border="0" cellpadding="0" cellspacing="1" width="100%" class="boxbg">
                                                            <tr align="center" bgcolor="#FFFFFF">
                                                                <td colspan="5">
                                                                    <table border="0" cellspacing="2" cellpadding="4">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Button ID="btnSubmit" runat="server" Width="120" Text="Submit" OnClick="btnSubmit_Click" />
                                                                                </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        <br />
                                                        <!--END-->
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
