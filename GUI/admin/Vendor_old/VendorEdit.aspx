<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"  CodeFile="VendorEdit.aspx.cs" Inherits="octroi_OctCustBillStep2"%>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">


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
                break;
                //return false;
            }
            else
            {
                continue
            }
       }
       if (a!=2)
       {
          alert("please enter valid location")
          obj.focus();
       }


}
 function nwOpen(mNo)
        {
           // debugger
            window.open("popupLoc.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }


function tupper(obj)
{
obj.value=obj.value.toUpperCase()
//txtrcpno.Attributes.Add("onblur", "javascript:tupper(this)");
}
 

function check(pin,tel,mob,email)
{
  
if(isNaN(pin.value))
{
    alert("Please Enter Only Numeric Value")
    pin.focus();
    return false
}
if(pin.value<0)
{
    alert("Please Enter Positive Value")
   pin.focus();
    return false
}
if(isNaN(tel.value))
{
    alert("Please Enter Only Numeric Value")
    tel.focus();
    return false
}
if(tel.value<0)
{
    alert("Please Enter Positive Value")
   tel.focus();
    return false
}
if(isNaN(mob.value))
{
    alert("Please Enter Only Numeric Value")
    mob.focus();
    return false
}
if(mob.value<0)
{
    alert("Please Enter Positive Value")
   mob.focus();
    return false
}

  
if (email.value!="")
{
if(email.value.indexOf("@")==-1 || email.value.indexOf(".")==-1)
{
    alert("Invalid Email Address")
    email.focus();
    return false;
}
}
  

}
function fsubmit(PanNo,servtaxno,vendorbstno,vendorcstno,txtContractStartDate,txtContractEndDt,txtOpenDt,txtOpnCrdt,ddVendorType,txtvenname)
{
if(ddVendorType.value=="--Select--")
{
 alert("Please Select Vendor Type")
 ddVendorType.focus()
 return false;
}
if(txtvenname.value=="")
{
 alert("Please Enter Vendor Name")
 txtvenname.focus()
 return false;
}

if(PanNo.value!="")
	{
		if (!isNaN(PanNo.value))
		{
		alert("Only Numbers are not allowed")
		PanNo.focus();
		return false;
		}
		
		if(PanNo.value.length <10)
			{
			alert("Minimum Size of PAN No. is 10")
			PanNo.focus()
			return false;
			}
		
		if(PanNo.value.indexOf(".")>1 || PanNo.value.indexOf("-")>1)
		   {
			alert("Special Charachter are Not Allowed")
			PanNo.focus()
			return false;
			} 	
	}
	if(PanNo.value=="")
        {
         alert("Please Enter Pan No")
         PanNo.focus()
         return false;
        }
	
	if(servtaxno.value!="")
	{
		if (!isNaN(servtaxno.value))
		{
		alert("Only Numbers are not allowed")
		servtaxno.focus();
		return false;
		}
		if(servtaxno.value.length <10)
			{
			alert("Minimum Size of Service Tax No. is 10")
			servtaxno.focus()
			return false;
			}
		
		if(servtaxno.value.indexOf(".")>1 || servtaxno.value.indexOf("-")>1)
		   {
			alert("Special Charachter are Not Allowed")
			servtaxno.focus()
			return false;
			} 	
	
	}
	if(servtaxno.value=="")
        {
         alert("Please Enter Service Tax No")
         servtaxno.focus()
         return false;
        }
		
	if(vendorbstno.value!="")
	{
		if (!isNaN(vendorbstno.value))
		{
		alert("Only Numbers are not allowed")
		vendorbstno.focus();
		return false;
		}
		if(vendorbstno.value.length <13)
			{
			alert("Minimum Size of Local Sales Tax No. is 13")
			vendorbstno.focus()
			return false;
			}
		
	}	
	if(vendorbstno.value=="")
{
 alert("Please Enter Local Sales Tax No.")
 vendorbstno.focus()
 return false;
}

	if(vendorcstno.value!="")
	{
		if (!isNaN(vendorcstno.value))
		{
		alert("Only Numbers are not allowed")
		vendorcstno.focus();
		return false;
		}
		if(vendorcstno.value.length <13)
			{
			alert("Minimum Size should be 13")
			vendorcstno.focus()
			return false;
			}
		
	}	

if(txtOpenDt.value=="")
{
 alert("Please Enter Debit")
 txtOpenDt.focus()
 return false;
}

if(txtOpnCrdt.value=="")
{
 alert("Please Enter Credit")
 txtOpnCrdt.focus()
 return false;
}


if(isNaN(txtOpenDt.value))
{
    alert("Please Enter Only Numeric Value For Dabit")
    txtOpenDt.focus();
    return false
}
if(txtOpenDt.value<0)
{
    alert("Please Enter Positive Value For Dabit")
   txtOpenDt.focus();
    return false
}


if(isNaN(txtOpnCrdt.value))
{
    alert("Please Enter Only Numeric Value For Credit")
    txtOpnCrdt.focus();
    return false
}
if(txtOpnCrdt.value<0)
{
    alert("Please Enter Positive Value For Credit")
   txtOpnCrdt.focus();
    return false
}




}

var months = new Array("","January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December");

        var dtCh= "/";
        var minYear=1900;
        var maxYear=2100;

        function isInteger(s)
        {
            for (var i = 0; i < s.length; i++)
            {   
                // Check that current character is number.
                var c = s.charAt(i);
                if (((c < "0") || (c > "9"))) return false;
            }
            // All characters are numbers.
            return true;
        }

        function stripCharsInBag(s, bag)
        {
            var returnString = "";
            // Search through string's characters one by one.
            // If character is not in bag, append to returnString.
            for (var i = 0; i < s.length; i++)
            {   
                var c = s.charAt(i);
                if (bag.indexOf(c) == -1) returnString += c;
            }
            
            return returnString;
        }

        function daysInFebruary (year)
        {
	        // February has 29 days in any year evenly divisible by four,
            // EXCEPT for centurial years which are not also divisible by 400.
            return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
        }

        function DaysArray(n)
        {
            for (var i = 1; i <= n; i++)
            {
		        this[i] = 31
		        if (i==4 || i==6 || i==9 || i==11) {this[i] = 30}
		        if (i==2) {this[i] = 29}
            }
            
            return this
        }


function isDate(dtStr)
        {
	var daysInMonth = DaysArray(12)
	var pos1=dtStr.indexOf(dtCh)
	var pos2=dtStr.indexOf(dtCh,pos1+1)
	var strDay=dtStr.substring(0,pos1)
	var strMonth=dtStr.substring(pos1+1,pos2)
	var strYear=dtStr.substring(pos2+1)
	strYr=strYear
	if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
	if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
	for (var i = 1; i <= 3; i++) {
		if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
	}
	month=parseInt(strMonth)
	day=parseInt(strDay)
	year=parseInt(strYr)
	if (pos1==-1 || pos2==-1){
		alert("The date format should be : dd/mm/yyyy")
		return false
	}
	if (strMonth.length<1 || month<1 || month>12){
		alert("Please enter a valid month")
		return false
	}
	if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
		alert("Please enter a valid day")
		return false
	}
	if (strYear.length != 4 || year==0 || year<minYear || year>maxYear){
		alert("Please enter a valid 4 digit year between "+minYear+" and "+maxYear)
		return false
	}
	if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
		alert("Please enter a valid date")
		return false
	}
	return true
}

function ValidateForm(obj){
	if (isDate(obj.value)==false){
		obj.focus()
		return false
	}
    return true
}

</script>
    <br />
     
     
     <br />
       <asp:UpdatePanel ID="DataGrid2_Update" runat="server"  UpdateMode="Always" RenderMode="Inline">
                 <ContentTemplate>
          
     <table   border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width:80%"  align="center">
    <tr class="bgbluegrey">
                                <td colspan="4" align="center" style="height: 21px">
                                    <asp:Label ID="lblQry" CssClass="blackfnt" 
                                        Font-Bold="True" runat="server">Vendor Information</asp:Label>
                                </td>
                            </tr>
     <tr  bgcolor="white"  style="height:25px">
        <td style="width: 111px"><font class="blackfnt">Vendor Code</font></td>
        <td style="width: 195px"><font class="blackfnt" color="red" >System Generated...</font></td>
        <td style="width: 188px"><font class="blackfnt">
            <p align="left">
                <font class="blackfnt">Name</font></p>
        </font></td>
        <td style="width: 264px">
            <asp:TextBox ID="txtvenname" runat="server" Width="94px"></asp:TextBox>
           <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="txtbilldt"></asp:RequiredFieldValidator>--%>
            <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtbilldt"
                ErrorMessage="MM/DD/YY" ValidationExpression="^(([1-9])|(0[1-9])|(1[0-2]))\/(([1-9])|(0[1-9])|(1[0-9])|(2[0-9])|(3[0-1]))\/((\d{2})|(\d{4}))$"></asp:RegularExpressionValidator>--%></td>
     </tr>
     <tr  bgcolor="white" style="height:25px">
      <td><font class="blackfnt">Vendor Type </font></td>
       <td style="width: 195px"> 
       
                             
                                     <%--<asp:Button ID="btnBranchPopup" runat="server" Text="..." OnClick="BranchPopup(this)" PopupURL="../../mis/popup-cust.asp?13" />--%>
                                                                
           <asp:DropDownList ID="ddVendorType" runat="server" Width="103px">
           </asp:DropDownList></td>
        <td><font class="blackfnt">Address</font></td>
        <td style="width: 264px">
            <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine"></asp:TextBox>
               <%--<asp:RequiredFieldValidator ID="RequiredFieldValidatordd" runat="server" ErrorMessage="*" ControlToValidate="txtAddress"></asp:RequiredFieldValidator>--%></td>
     </tr>
         
     </table>
    &nbsp;<br />
                    <center>
                         <table border="0" cellpadding="1" cellspacing="1" class="boxbg"  align="center">
           
            <tr bgcolor="white">
               <td align="left" style="width: 91px; height: 40px;" ><font class="bluefnt">
                   Enter Row No *</font></td><td style="height: 40px" >
                   <asp:TextBox ID="roww" runat="server" Width="40px" BorderStyle="Groove" AutoPostBack="True" OnTextChanged="roww_TextChanged" TabIndex="25" ></asp:TextBox></td>
             </tr>
         </table>
                         
                    </center>
                     <center>
                          
                     <center>
                         <%--<asp:GridView id="DataGrid1" runat="server" AllowPaging="false" PageSize="1000" AutoGenerateColumns="False" CellPadding="1" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CssClass="Styles.css" CellSpacing="1" Width="90%">
                        <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />
                        <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
			            <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Center" Font-Bold="True" Font-Underline="True" BackColor="#8BA0E5" ForeColor="White" Wrap="False" Mode="NumericPages" CssClass="whitefnt"></PagerStyle>
                        <ItemStyle BackColor="White" ForeColor="#003399" CssClass="blackfnt" />
                        <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" />--%>
                        
                         
                         <asp:GridView ID="GV_D" runat="server" align="center" HeaderStyle-CssClass="bgbluegrey" 
                                                         PagerStyle-HorizontalAlign="left" 
                                                         ShowFooter="True"
                                                       BackColor="white"
                                                             CssClass="boxbg" FooterStyle-CssClass="boxbg" 
                                                            AutoGenerateColumns="False" SelectedIndex="1">
                                                             
                                                                 <Columns>
                                                                 
                                                                 <asp:TemplateField HeaderText="SR.NO." >
                                  <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle CssClass="blackfnt" />
                                 <ItemTemplate>
                                 <asp:Label ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                                 </asp:Label>
                                 </ItemTemplate>
                                 </asp:TemplateField>
                                                                 
                                                                 
                                                                  <asp:TemplateField HeaderText="Location Code " >
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="True"  CssClass="blackfnt" />
                                                                               <%--  <HeaderTemplate>
                                                                                <asp:Label ID="Label1" runat="server"  CssClass="blackfnt" Text="Location" ></asp:Label>
                                                                                <asp:Label ID="loc_pop" runat="server" BorderStyle="Groove" Height="9px" Text='<a href="javascript:nwOpen(1)">...</a>'
                                                                                         Width="15px"></asp:Label>
                                                                                </HeaderTemplate>--%>
                                                                                <ItemStyle CssClass="blackfnt"  />
                                                                                <ItemTemplate>
                                    
                                                                                       <asp:TextBox ID="txtloc" Width="40" Text='<%# DataBinder.Eval( Container.DataItem,"VENDORBRCD") %>' onblur="return checklocation(this)" runat="server" BorderStyle="Groove"></asp:TextBox>
                                                                                   <%--    <atlas:AutoCompleteExtender ID="Extender1" runat="server">
                                                                                                    <atlas:AutoCompleteProperties Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetlocationList"
                                                                                                    ServicePath="../../../GUI/services/location.asmx" TargetControlID="txtloc" /></atlas:AutoCompleteExtender>
                                                                                                                                                                                           --%>
                                                                                       
                                                                                        <ajaxToolkit:AutoCompleteExtender ID="Extender1" runat="server" Enabled="True" CompletionListItemCssClass="autocomplete_listItem"
                                                CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                                                ServiceMethod="GetlocationList" ServicePath="../../../GUI/services/location.asmx" TargetControlID="txtloc">
                                            </ajaxToolkit:AutoCompleteExtender>
                                                                                       <%--<asp:Label ID="lblLocCod1" runat="server" BorderStyle="Groove" Height="9px" Text='<a href="javascript:nwOpen(5)">...</a>'
                                                                                         Width="15px"></asp:Label>--%>
                                                                                       
                                                                                        <%--<asp:TextBox ID="txtddd" runat="server"   Visible="false" ></asp:TextBox>--%>
                                                                                       
                                                                                    </ItemTemplate>
                                                                                      
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                    
                                                                                    
                                                                                     
                                                                                    
                                                                                     <asp:TemplateField HeaderText="Contact Person  ">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                     <asp:TextBox ID="txtcontper" Width="120" Text='<%# DataBinder.Eval( Container.DataItem,"VENDORCONTACT") %>' runat="server" BorderStyle="Groove"  Columns="8"    ></asp:TextBox>				<%--OnTextChanged="OnAmtChg" AutoPostBack="true" --%>		              
                                                                                     <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*" ControlToValidate="txtoctamt"></asp:RequiredFieldValidator>--%>
                                                                                    <%-- <asp:RegularExpressionValidator id="reg1" runat="server" ValidationExpression="0-9" ControlToValidate="txtoctamt"></asp:RegularExpressionValidator>--%>
                                                                                      </ItemTemplate>
                                     
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                    
                                                                                     <asp:TemplateField HeaderText="Address">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                       <asp:TextBox ID="txtadr" Width="120" Text='<%# DataBinder.Eval( Container.DataItem,"VENDORADDRESS") %>' runat="server" TextMode="multiLine" BorderStyle="Groove" Columns="8" ></asp:TextBox>
                                                                                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*" ControlToValidate="txtrcpno"></asp:RequiredFieldValidator>--%>
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                    
                                                                                            <asp:TemplateField HeaderText="City">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                      <asp:TextBox ID="txtcity" Width="70" Text='<%# DataBinder.Eval( Container.DataItem,"VENDORCITY") %>' runat="server" BorderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                    <asp:TemplateField HeaderText="Pin Code">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                      <asp:TextBox ID="txtpin" Width="70" Text='<%# DataBinder.Eval( Container.DataItem,"VENDORPIN") %>' runat="server" BorderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                    <asp:TemplateField HeaderText="Tel .">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                      <asp:TextBox ID="txttel" Width="70" Text='<%# DataBinder.Eval( Container.DataItem,"VENDORPHONE") %>' MaxLength="10" runat="server" BorderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                    <asp:TemplateField HeaderText="Mobile">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                      <asp:TextBox ID="txtmob" Width="70" Text='<%# DataBinder.Eval( Container.DataItem,"VENDORMOBILE") %>'  MaxLength="10" runat="server" BorderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                    <asp:TemplateField HeaderText="E-Mail">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                      <asp:TextBox ID="txtemail" Width="120" Text='<%# DataBinder.Eval( Container.DataItem,"VENDOREMAIL") %>' runat="server" BorderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                    <asp:TemplateField HeaderText="Act Flag">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                      <asp:TextBox ID="txtactflag" Width="20" Text='<%# DataBinder.Eval( Container.DataItem,"ACTIVEFLAG") %>' runat="server" BorderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                      <asp:CheckBox ID="chkact" AutoPostBack="true" runat="server" OnCheckedChanged="OnchkChange" />
                                                                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                    
                                                                                    <asp:TemplateField HeaderText="Black Listed">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                      <asp:TextBox ID="txtblack" Width="20" Text='<%# DataBinder.Eval( Container.DataItem,"BLACKLISTED") %>' runat="server" BorderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                      <asp:CheckBox ID="chkblk" AutoPostBack="true"  runat="server" OnCheckedChanged="Onchk2Change" />
                                                                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                    </Columns>
                                                                                    
                             <FooterStyle CssClass="bgbluegrey"   />
                             <HeaderStyle CssClass="bgbluegrey" />
                                                                                            </asp:GridView>
                                     
				        
				     
				      &nbsp;</center>
                     
             
    <br />
    <br />
                  <br />
 
                  
                  
                  <table align="center" border="0" cellpadding="0" runat="SERVER" visible="TRUE" cellspacing="1" width="100%" class="boxbg">
                    <tr class="bgbluegrey">
                        <td align="center" ><font class="bluefnt"><b>Other Information</b></font></td>
                    </tr>
                    <tr>
                        <td>
                            <table align="center" border="0" cellpadding="2" cellspacing="0" width="100%">
                                  <tr bgcolor="#FFFFFF"> 
                                    <td valign="top" align="left"><font class="blackfnt">PAN No.</font></td>
                                    <td valign="top" ><font class="blackfnt">:<asp:TextBox ID="PanNo" MaxLength="10" runat="server" Width="123px"></asp:TextBox>
                                       </font></td>
                                    <td valign="top" align="left"><font class="blackfnt">Service Tax No.</font></td>
                                    <td valign="top" style="width: 149px;" colspan="4"><font class="blackfnt">: 
                                        <asp:TextBox ID="servtaxno" MaxLength="10" runat="server"></asp:TextBox>
                                        </font></td>
                                  </tr>
                                  <tr bgcolor="#FFFFFF"> 
                                    <td valign="top" align="left"><font class="blackfnt">Local 
                                      Sales Tax No.</font></td>
                                    <td valign="top" ><font class="blackfnt">:<asp:TextBox ID="vendorbstno" MaxLength="13" runat="server" Width="123px"></asp:TextBox>
                                        </font></td>
                                    <td valign="top" align="left"><font class="blackfnt">Central 
                                      Sales Tax No.</font></td>
                                    <td valign="top" style="width: 149px;" colspan="4"><font class="blackfnt">: 
                                        <asp:TextBox ID="vendorcstno" MaxLength="13" runat="server"></asp:TextBox>
                                        </font></td>
                                  </tr>
                                  <tr bgcolor="#FFFFFF"> 
                                    <td valign="top" align="left"><font class="blackfnt">Contract Start Date</font></td>
                                    <td valign="top" style="width: 149px;" ><font class="blackfnt">:<asp:TextBox ID="txtContractStartDate" runat="server" Width="123px"></asp:TextBox>
                                            
                                        </font></td>
                                    <td valign="top" align="left"><font class="blackfnt">Contract End Date</font></td>
                                    <td valign="top" style="width: 149px;" colspan="4" ><font class="blackfnt">: 
                                        <asp:TextBox ID="txtContractEndDt" runat="server"></asp:TextBox>
                                        </font></td>
                                    
                                  </tr>
                                  <tr bgcolor="#FFFFFF">
                                    <td valign="top" align="left"><font class="blackfnt">Open Debit</font></td>
                                    <td valign="top" ><font class="blackfnt">:<asp:TextBox ID="txtOpenDt" runat="server" Width="123px"></asp:TextBox>
                                        </font></td>
                                    <td valign="top" align="left"><font class="blackfnt">Open Credit</font></td>
                                    <td valign="top" style="width: 149px;"><font class="blackfnt">:
                                        <asp:TextBox ID="txtOpnCrdt" runat="server"></asp:TextBox>
                                        
                                        </font></td>
                                   <td valign="top" ><font class="blackfnt">Remarks :</font></td>
                                    <td valign="top" > 
                                        <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine"></asp:TextBox></td>
                                  </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                  
        <br/>
                &nbsp;<table border="0" cellspacing="2" cellpadding="2" width="50%" align="center">
        <tr>
            <td align="right">
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" /></td>
            <td>
            <asp:Button ID="btnReset" runat="server" Text="Reset" /></td>
        </tr>
    </table>
              </ContentTemplate>   
              <Triggers>
                <asp:AsyncPostBackTrigger ControlID="roww" EventName="TextChanged" />
              </Triggers>
        
               
            </asp:UpdatePanel>
    </asp:Content>
