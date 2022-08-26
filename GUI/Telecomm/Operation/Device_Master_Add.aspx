<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Device_Master_Add.aspx.cs" Inherits="Operation_Device_"%>
<%@ Register TagPrefix="DateCalendar" TagName="Header" Src="~/DateCalendar.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">    
    <script language="javascript" type="text/javascript">
    
//    var loccodeval = "<%=Locationstr%>";
//    function Locationcheck(obj)
//        {
//            alert(loccodeval)
//            //obj.value = obj.value.toUpperCase()
//            if (obj.value!="")
//            {
//                if(loccodeval.indexOf(obj.valuetoUpperCase())!=-1)
//                {
//                    alert("Code Already Exists !!")
//                    obj.focus();
//                    return false;
//                }
////                 && obj.value != loccode
//            }
//        }
function Checked()
{
    if(document.getElementById("ctl00_MyCPH1_chkActive").checked == true)
    {
        document.getElementById("ctl00_MyCPH1_txtActive").value = "Y";
    }
    else
    {
        document.getElementById("ctl00_MyCPH1_txtActive").value = "N";
    }
}
function Check()
{      
    if(document.getElementById("ctl00_MyCPH1_cboType").value == "--Select--")
    {
        alert("Please Select Device Type Any One")
        document.getElementById("ctl00_MyCPH1_cboType").focus();
        return false;
    }    
    if(isNaN(document.getElementById("ctl00_MyCPH1_txtNumber").value))
    {
        alert("Please Enter Only Number")
        document.getElementById("ctl00_MyCPH1_txtNumber").focus();
        return false;
    } 
    if(document.getElementById("ctl00_MyCPH1_txtNumber").value == "")
    {
        alert("Please Enter Any Phone or Any Reference Number")
        document.getElementById("ctl00_MyCPH1_txtNumber").focus();
        return false;
    }   
    if(document.getElementById("ctl00_MyCPH1_lblLocation").value == "")
    {
        alert("Please Enter Location")
        document.getElementById("ctl00_MyCPH1_lblLocation").focus();
        return false;
    }   
    if(document.getElementById("ctl00_MyCPH1_cboVendor").value == "--Select--")
    {
        alert("Please Select Any One Vendor")
        document.getElementById("ctl00_MyCPH1_cboVendor").focus();
        return false;
    }     
    if(document.getElementById("ctl00_MyCPH1_txtPerson").value == "")
    {
        alert("Please Enter Assigned to Person ID")
        document.getElementById("ctl00_MyCPH1_txtPerson").focus();
        return false;
    }   
    if(document.getElementById("ctl00_MyCPH1_txtRefNo").value == "")
    {
        alert("Please Enter Customer Ref No.")
        document.getElementById("ctl00_MyCPH1_txtRefNo").focus();
        return false;
    }   
    if(document.getElementById("ctl00_MyCPH1_txtBillCode").value == "")
    {
        alert("Please Enter Billing Code")
        document.getElementById("ctl00_MyCPH1_txtBillCode").focus();
        return false;
    } 
    if(isNaN(document.getElementById("ctl00_MyCPH1_txtAmount").value))
    {
        alert("Please Enter Credit Amount")
        document.getElementById("ctl00_MyCPH1_txtAmount").focus();
        return false;
    } 
    if(document.getElementById("ctl00_MyCPH1_txtAmount").value == "")
    {
        alert("Please Enter Credit Amount")
        document.getElementById("ctl00_MyCPH1_txtAmount").focus();
        return false;
    } 
    if(document.getElementById("ctl00_MyCPH1_txtStartDt").value == "")
    {
        alert("Please Enter Service Start Date")
        document.getElementById("ctl00_MyCPH1_txtStartDt").focus();
        return false;
    }   
        
    if(ValidateDate(document.getElementById("ctl00_MyCPH1_txtStartDt")) == false)
    {
        return false;
    } 
    if(ValidateDate(document.getElementById("ctl00_MyCPH1_txtEndDt")) == false)
    {
        return false;
    }  
    document.getElementById("ctl00_MyCPH1_HidCustName").value = document.getElementById("ctl00_MyCPH1_lblPersonName").innerText;
    document.getElementById("ctl00_MyCPH1_HidLocation").value = document.getElementById("ctl00_MyCPH1_lblLocation").innerText;   
}

function tupper(obj)
{
    obj.value=obj.value.toUpperCase()
    
    //txtrcpno.Attributes.Add("onblur", "javascript:tupper(this)");
}
</script>

<script language="javascript" type="text/javascript">
            
        // JScript File

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

        function isDate1(dtStr)
        {
	        var daysInMonth = DaysArray(12)
	        var pos1 = dtStr.indexOf(dtCh)
	        var pos2 = dtStr.indexOf(dtCh,pos1+1)
	        var strDay = dtStr.substring(0,pos1)
	        var strMonth = dtStr.substring(pos1+1,pos2)
	        var strYear = dtStr.substring(pos2+1)
        	
	        strYr = strYear
        	
	        if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
	        if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
        	
	        for (var i = 1; i <= 3; i++)
	        {
		        if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
	        }
        	
	        month = parseInt(strMonth)
	        day = parseInt(strDay)
	        year = parseInt(strYr)
        	
	        if (pos1==-1 || pos2==-1)
	        {
		        alert("The date format should be : dd/mm/yyyy")
		        return false
	        }
        	
	        if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month])
	        {
		        alert("Please enter a valid day")
		        return false
	        }
        	
	        if (strMonth.length<1 || month<1 || month>12)
	        {
		        alert("Please enter a valid month")
		        return false
	        }
        	
	        if (strYear.length != 4 || year==0 || year<minYear || year>maxYear)
	        {
		        alert("Please enter a valid 4 digit year between "+minYear+" and "+maxYear)
		        return false
	        }
        	
	        if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false)
	        {
		        alert("Please enter a valid date")
		        return false
	        }
        	
            return true
        }

        function ValidateDate(obj)
        {  
            if (obj.value!="")
            {
	            var dockdt=obj.value
        	
		        if(dockdt.length<10)
		        {
		            alert("Please enter the date in dd/mm/yyyy format")
		            obj.focus();
		            return false;
		        }
        	
	            if (isDate1(obj.value)==false)
	            {
		            obj.focus()
		            return false
	            }
        	    
                return true
            }  
        }
         
        function MyDateDiff( start, end, interval, rounding )
        {
            var iOut = 0;
            var bufferA = Date.parse( start ) ;
            var bufferB = Date.parse( end ) ;
            	
            // check that the start parameter is a valid Date. 
            if ( isNaN (bufferA) || isNaN (bufferB) )
            {
                alert( startMsg ) ;
                return null ;
            }
        	
            // check that an interval parameter was not numeric. 
            if ( interval.charAt == 'undefined' )
            {
                // the user specified an incorrect interval, handle the error. 
                alert( intervalMsg ) ;
                return null ;
            }
            
            var number = bufferB-bufferA ;
            
            // what kind of add to do? 
            switch (interval.charAt(0))
            {
                case 'd': case 'D': 
                    iOut = parseInt(number / 86400000) ;
                    if(rounding) iOut += parseInt((number % 86400000)/43200001) ;
                    break ;
                case 'h': case 'H':
                    iOut = parseInt(number / 3600000 ) ;
                    if(rounding) iOut += parseInt((number % 3600000)/1800001) ;
                    break ;
                case 'm': case 'M':
                    iOut = parseInt(number / 60000 ) ;
                    if(rounding) iOut += parseInt((number % 60000)/30001) ;
                    break ;
                case 's': case 'S':
                    iOut = parseInt(number / 1000 ) ;
                    if(rounding) iOut += parseInt((number % 1000)/501) ;
                    break ;
                default:
                // If we get to here then the interval parameter
                // didn't meet the d,h,m,s criteria.  Handle
                // the error. 		
                alert(intervalMsg) ;
                return null ;
            }
            
            return iOut ;
        }

        function trimAll(strValue) 
        {
            //Trimming left most white space characters
            while (strValue.substring(0,1) == ' ')
            {
                strValue = strValue.substring(1, strValue.length);
            }
            //Trimming right most white space characters
            while (strValue.substring(strValue.length-1, strValue.length) == ' ')
            {
                strValue = strValue.substring(0, strValue.length-1);
            }
            
            return strValue;
        }

        function IsNumeric(sText)
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

        function Nagative_Chk_wDecimal(obj)
        {
	        var temp = trimAll(obj.value) 
        	
	        if (temp == "")	
	        {
		        /*alert("Value can not be blank")
		        obj.focus();
		        return false;*/
		        return true;
	        }
        	
	        if(isNaN(temp))
	        {
		        alert("Value should be Numeric")
		        obj.focus();
		        return false;
	        } 				
        		  
	        if(parseFloat(temp) < 0)
	        {
		        alert("Value should be greater than zero")
		        obj.focus();
		        return false;
	        }
        	
	        obj.value=roundit(temp) 
        	
	        return true;					   
        }
        	
        function Nagative_Chk_woDecimal(obj)
        {
	        var temp = obj.value 
        						
	        if (temp == "")	
	        {
		        alert("Value can not be blank")
		        obj.focus();
		        return false;
	        }
        	
	        if(isNaN(temp))
	        {
		        alert("Value should be Numeric")
		        obj.focus();
		        return false;
	        } 					  
        	
	        if(parseFloat(temp)<0)
	        {
		        alert("Value should be greater than zero")
		        obj.focus();
		        return false;
	        }
        	
	        if(temp.indexOf(".") > 0)
	        {
		        alert("Value should not contain decimal point")
		        obj.focus();
		        return false;
	        } 
        	
	        obj.value=Math.round(temp)
        	 	
	        return true;					 				   
        }

        function rounditn(Num, decplaces)
        {
	        Places = decplaces
        	
            if (Places > 0) 
	        {
	            if ((Num.toString().length - Num.toString().lastIndexOf('.')) > (Places+1)) 
		        {
			        if (Num.toString().lastIndexOf('.') < 0) 
			        {
				        return Num.toString() +'.00';
			        }
        			
			        var Rounder = Math.pow(10, Places);
        			
			        return Math.round(Num * Rounder) / Rounder;
		        }
		        else 
		        {
			        if (Num.toString().lastIndexOf('.') < 0) 
			        {
				        return Num.toString() +'.00';
			        }
			        else
			        {  
				        if (Num.toString().lastIndexOf('.')+1==Num.toString().length-1)
					        return Num.toString() +'0';	
				        else
					        return Num.toString();				   
    		        }
		        }
	        }
	        else
	        {
	            return Math.round(Num);
            }
        }

        function roundit(Num)
        {
	        Places = 2
        	
	        if (Places > 0)
	        {
		        if ((Num.toString().length - Num.toString().lastIndexOf('.')) > (Places+1)) 
		        {
			        if (Num.toString().lastIndexOf('.') < 0) 
			        {
				        return Num.toString() + '.00';
			        }
        			
			        var Rounder = Math.pow(10, Places);
        			
			        return Math.round(Num * Rounder) / Rounder;
		        }
		        else 
		        {
			        if (Num.toString().lastIndexOf('.') < 0) 
			        {
				        return Num.toString() +'.00';
			        }
			        else
			        {  
				        if (Num.toString().lastIndexOf('.')+1==Num.toString().length-1)
				        {
					        return Num.toString() +'0';
				        }
				        else
				        {
					        return Num.toString();
				        }
			        }
		        }
	        }
	        else
	        {
	            return Math.round(Num);
	        }
	        
        }
        
    </script>         
       <input type="hidden" id="HidCustName" runat="server" />
       <input type="hidden" id="HidLocation" runat="server" />
    <br />
    <a href="javascript:window.history.go(-1)" title="back">
    <img id="IMG1" align="right" alt="" border="0" src="../../../GUI/images/back.gif" /></a>&nbsp;
    <asp:HyperLink ID="HyperLink1" runat="server" CssClass="blackfnt" Font-Underline="True"
        NavigateUrl="~/GUI/Telecomm/Home.aspx">Communication Master</asp:HyperLink>
    &gt;
    <asp:HyperLink ID="HyperLink2" runat="server" CssClass="blackfnt" Font-Underline="True"
        NavigateUrl="~/GUI/Telecomm/Operation/Master_Page.aspx">Communication Device Master Type</asp:HyperLink>
    &gt;
    <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="Communication Device Master"></asp:Label><br />
    <br />
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        &nbsp;&nbsp;
                        <div>
                            <table align="center" border="0" cellpadding="0" cellspacing="1" style="font-size: 12pt;
                                width: 80%; font-family: Times New Roman" class="boxbg">
                                <tr>
                                    <td align="center" class="bgbluegrey" style="height: 27px">
                                        <font class="blackfnt"><strong><span style="font-size: 8pt; font-family: Verdana">Communication
                                            Device Master -
                                            <asp:Label ID="lblAddEdit" runat="server" CssClass="blackfnt" Font-Bold="True"></asp:Label></span></strong></font></td>
                                </tr>
                            </table>
                            <center>
                                &nbsp; &nbsp;&nbsp;
                                <table align="center" bgcolor="#000000" border="0" cellpadding="4" cellspacing="1"
                                    class="boxbg" style="font-size: 12pt; width: 80%; font-family: Times New Roman">
                                    <tr bgcolor="#ffffff">
                                        <td style="width: 31%" align="left">
                                            <font class="blackfnt">&nbsp;Device code</font>
                                        </td>
                                        <td align="left" colspan="3" style="font-size: 12pt; width: 90%; font-family: Times New Roman">
                                            <font class="blackfnt" color="red"><strong><span style="color: #000000">&nbsp;</span></strong><asp:Label
                                                ID="lblTypeCode" runat="server" Text="< System Generated >"></asp:Label></font></td>
                                    </tr>
                                    <tr bgcolor="#ffffff" style="font-weight: bold; font-size: 12pt; font-family: Times New Roman">
                                        <td style="width: 31%" align="left">
                                            <font class="blackfnt">&nbsp;Device Type</font>
                                        </td>
                                        <td align="left" colspan="3" style="font-size: 12pt; width: 90%; font-family: Times New Roman">
                                            &nbsp;<asp:DropDownList ID="cboType" runat="server">
                                            </asp:DropDownList></td>
                                    </tr>
                                    <tr bgcolor="#ffffff" style="font-weight: bold; font-size: 12pt; font-family: Times New Roman">
                                        <td style="width: 31%" align="left">
                                            <font class="blackfnt">&nbsp;Number</font>
                                        </td>
                                        <td align="left" colspan="3" style="font-size: 8pt; width: 90%; font-family: Verdana">
                                            &nbsp;<asp:TextBox ID="txtNumber" runat="server" AutoPostBack="true" OnTextChanged="txtNumber_TextChanged"
                                                Width="110px" MaxLength="49"></asp:TextBox>
                                            <asp:Label ID="lblNumber" runat="server" CssClass="blackfnt"
                                                    ForeColor="Red"></asp:Label><asp:CustomValidator ID="cvNumber" runat="server"
                                                        ControlToValidate="txtNumber" CssClass="blackfnt" OnServerValidate="Number"></asp:CustomValidator></td>
                                    </tr>
                                    <tr bgcolor="#ffffff" style="font-weight: bold; font-size: 12pt; font-family: Times New Roman">
                                        <td style="width: 31%" align="left">
                                            <font class="blackfnt">&nbsp;Vendor</font>
                                        </td>
                                        <td align="left" colspan="3" style="width: 90%">
                                            &nbsp;<asp:DropDownList ID="cboVendor" runat="server">
                                            </asp:DropDownList>&nbsp;
                                            <asp:HyperLink ID="HyperLink3" runat="server" CssClass="blackfnt" Font-Underline="True"
                                                NavigateUrl="~/GUI/admin/Vendor/VendorMaster.aspx">Add New Vednor</asp:HyperLink></td>
                                    </tr>
                                    <tr bgcolor="#ffffff" style="font-weight: bold; font-size: 12pt; font-family: Times New Roman">
                                        <td style="width: 31%" align="left">
                                            <font class="blackfnt">&nbsp;Assigned to Person</font>
                                        </td>
                                        <td align="left" colspan="3" style="font-size: 12pt; width: 90%; font-family: Times New Roman">
                                            &nbsp;<asp:TextBox ID="txtPerson" runat="server" MaxLength="15" AutoPostBack="true"
                                                Width="65px" OnTextChanged="txtPerson_TextChanged"></asp:TextBox>
                                            <input id="btnCust" runat="server" name="" type="button" />&nbsp;
                                            <asp:Label ID="lblPersonName"
                                                    runat="server" CssClass="blackfnt" ForeColor="Transparent"></asp:Label></td>
                                    </tr>
                                    <tr bgcolor="#ffffff" style="font-weight: bold; font-size: 12pt; font-family: Times New Roman">
                                        <td style="width: 31%" align="left">
                                            <font class="blackfnt">&nbsp;Assigned to Location</font>
                                        </td>
                                        <td align="left" colspan="3" style="width: 90%">
                                            &nbsp;<%--<asp:TextBox ID="lblLocation" runat="server" AutoPostBack="true"
                                                OnTextChanged="lblLocation_TextChanged" Width="112px" MaxLength="49"></asp:TextBox>--%>
                                                <asp:Label ID="lblLocation" runat="server" CssClass="blackfnt"></asp:Label>&nbsp;
                                            <%--<asp:Label ID="lblLocation" runat="server" CssClass="blackfnt"></asp:Label>--%></td>
                                    </tr>
                                    <tr bgcolor="#ffffff" style="font-weight: bold; font-size: 12pt; font-family: Times New Roman">
                                        <td class="blackfnt" align="left">
                                            &nbsp;Customer Ref No.</td>
                                        <td align="left" colspan="3" style="width: 90%">
                                            &nbsp;<asp:TextBox ID="txtRefNo" runat="server" Width="111px" MaxLength="49"></asp:TextBox></td>
                                    </tr>
                                    <tr bgcolor="#ffffff" style="font-weight: bold">
                                        <td class="blackfnt" align="left">
                                            &nbsp;Billing Code</td>
                                        <td align="left" colspan="3" style="width: 90%">
                                            &nbsp;<asp:TextBox ID="txtBillCode" runat="server" Width="111px" MaxLength="49"></asp:TextBox></td>
                                    </tr>
                                    <tr bgcolor="#ffffff" style="font-weight: bold">
                                        <td class="blackfnt" align="left">
                                            &nbsp;Credit Amount</td>
                                        <td align="left" colspan="3" style="width: 90%">
                                            &nbsp;<asp:TextBox ID="txtAmount" runat="server" Width="80px" MaxLength="9"></asp:TextBox>&nbsp;
                                        </td>
                                    </tr>
                                    <tr bgcolor="#ffffff" style="font-weight: bold">
                                        <td class="blackfnt" align="left">
                                            &nbsp;Active / Non-Active</td>
                                        <td align="left" colspan="3" style="width: 90%">
                                            <asp:CheckBox ID="chkActive" runat="server" onClick="return Checked()"/><asp:TextBox
                                                ID="txtActive" runat="server" Width="11px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr bgcolor="#ffffff" style="font-weight: bold">
                                        <td class="blackfnt" align="left">
                                            &nbsp;Service Start Date</td>
                                        <td align="left" colspan="3" style="width: 90%">
                                            &nbsp;<asp:TextBox ID="txtStartDt" runat="server" Width="73px"></asp:TextBox>&nbsp;</td>
                                    </tr>
                                    <tr bgcolor="#ffffff" style="font-weight: bold">
                                        <td class="blackfnt" align="left">
                                            &nbsp;Service End Date</td>
                                        <td align="left" colspan="3" style="width: 90%">
                                            &nbsp;<asp:TextBox ID="txtEndDt" runat="server" Width="74px"></asp:TextBox>
                                            <asp:CustomValidator ID="CustomValidator1" runat="server" CssClass="blackfnt" ErrorMessage="Service End Date can not be Smaller than Service Start Date"
                                                OnServerValidate="ToDate"></asp:CustomValidator></td>
                                    </tr>
                                    <tr bgcolor="#ffffff">
                                        <td align="center" colspan="5" width="90%">
                                            &nbsp;<asp:Button ID="cmdSubmit" runat="server" OnClick="cmdSubmit_Click" OnClientClick="return Check()"
                                                Text="Submit" />
                                        </td>
                                    </tr>
                                </table>
                            </center>
                            &nbsp;&nbsp;
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>    
</asp:Content>
