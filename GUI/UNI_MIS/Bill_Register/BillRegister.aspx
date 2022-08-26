<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="BillRegister.aspx.cs" Inherits="BillRegister" EnableEventValidation="false" %>

<%@ OutputCache Location="none" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>

    <script language="javascript" type="text/javascript" src="./../../Images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript" src="./../../Images/CalendarPopup.js"></script>

    <script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
cal.setCssPrefix("TEST");
cal.showNavigationDropdowns();
    </script>

    <script language="javascript" type="text/jscript">
function DateCheck()
{
    if(document.getElementById("ctl00_MyCPH1_txtDateFrom").value == "")
    {
        alert("Please Enter From Date")
        document.getElementById("ctl00_MyCPH1_txtDateFrom").focus();
        return false;
    }
    if(document.getElementById("ctl00_MyCPH1_txtDateTo").value == "")
    {
        alert("Please Enter To Date")
        document.getElementById("ctl00_MyCPH1_txtDateTo").focus();
        return false;
    }
    if(ValidateDate(document.getElementById("ctl00_MyCPH1_txtDateFrom")) == false)
    {
        return false;
    } 
    if(ValidateDate(document.getElementById("ctl00_MyCPH1_txtDateTo")) == false)
    {
        return false;
    }  
}
 function BranchPopup(strPopupURL)
 {
    var strWinFeature = "height=280,width=350,resizable=yes,scrollbars=yes,left=420,top=5"
    winNew = window.open(strPopupURL, "_blank", strWinFeature)
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

    <br />
    &nbsp;
    <asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="True" NavigateUrl="~/GUI/UNI_MIS/rpt_finance.aspx">Finance</asp:HyperLink>
    &gt;
    <asp:Label ID="Label11" runat="server" Text="Bill Register" CssClass="blackfnt"></asp:Label><br />
    <a href="javascript:window.history.go(-1)" title="back">
        <img id="IMG1" align="right" alt="" border="0" src="../../../GUI/images/back.gif" /></a><br />
    <br />
    <center>
        <%--<asp:UpdatePanel ID="UpdatePanel3" runat="server"    UpdateMode="Conditional" RenderMode="Inline">
                                            <ContentTemplate>--%>
        <table cellspacing="1" style="width: 90%" class="boxbg" border="0">
            <tr class="bgbluegrey">
                <td colspan="3" align="center" style="height: 21px">
                    <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">
                                        Search Criteria
                    </asp:Label>
                </td>
            </tr>
            <tr style="background-color: white">
                <td align="left" style="width: 100px;" valign="top">
                    <asp:Label ID="Label6" CssClass="blackfnt" runat="server" Text=" Select Date"> </asp:Label><%--<asp:DropDownList
                        ID="ddldttype" runat="server">
                        <asp:ListItem Text="Generation Date" Value="mrsdt"></asp:ListItem>
                        <asp:ListItem Text="Closing Date" Value="finclosedt"></asp:ListItem>
                    </asp:DropDownList>--%>
                </td>
                <td align="left" style="vertical-align: top">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server"   UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                            <asp:RadioButtonList ID="radDate" runat="server" AutoPostBack="true" CssClass="blackfnt"
                                OnSelectedIndexChanged="radDate_OnSelectedIndexChange" ValidationGroup="VGDtFromTo"
                                Width="210px">
                                <asp:ListItem Selected="True" Text=" Date Range [dd/mm/yyyy]" Value="0"></asp:ListItem>
                                <asp:ListItem Text=" Last Week (Including Today)" Value="1"></asp:ListItem>
                                <asp:ListItem Text=" Today:" Value="2"></asp:ListItem>
                                <asp:ListItem Text=" Till Date:" Value="3" Enabled="false"></asp:ListItem>
                            </asp:RadioButtonList>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                  
                </td>
                <td align="left" colspan="1">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                            <asp:Label ID="lblFrom" runat="server" CssClass="blackfnt" Text=" From: "></asp:Label>
                            <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                            <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtDateFrom,'anchor1','dd/MM/yyyy'); return false;"
                                name="anchor1" id="anchor1">
                                <img alt="" src="../../images/calendar.jpg" border="0" />
                            </a>
                            <asp:Label ID="lblTo" runat="server" CssClass="blackfnt" Text=" To: "></asp:Label>
                            <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                            <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtDateTo,'anchor2','dd/MM/yyyy'); return false;"
                                name="anchor2" id="anchor2">
                                <img alt="" src="../../images/calendar.jpg" border="0" />
                            </a>
                            <br />
                            <asp:RequiredFieldValidator ID="RFVFromDate" runat="server" ControlToValidate="txtDateFrom"
                                CssClass="blackfnt" ErrorMessage="Date From cannot be blank :(" ValidationGroup="VGDtFromTo"></asp:RequiredFieldValidator>
                            <br />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtDateFrom"
                                ErrorMessage="Invalid Date From  :(" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                ValidationGroup="VGDtFromTo"></asp:RegularExpressionValidator>
                            <br />
                            <asp:RequiredFieldValidator ID="RFVToDate" runat="server" ControlToValidate="txtDateTo"
                                CssClass="blackfnt" ErrorMessage="Date To cannot be blank :(" ValidationGroup="VGDtFromTo"></asp:RequiredFieldValidator>
                            <br />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtDateTo"
                                ErrorMessage="Invalid Date To  :(" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                ValidationGroup="VGDtFromTo"></asp:RegularExpressionValidator><br />
                            <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="Date Range can not be greater than 1 month"
                                OnServerValidate="daterange"></asp:CustomValidator><br />
                            <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="To date can not be smaller than from date "
                                OnServerValidate="ToDate"></asp:CustomValidator>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="radDate" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr style="background-color: white">
                <td align="left" style="width: 100px">
                    <asp:Label ID="lbl" CssClass="blackfnt" Text="Billing Party: " runat="server" Width="102px"></asp:Label>
                </td>
                <td align="left" colspan="2" valign="top">
                    <asp:TextBox ID="txtPartyCode" CssClass="input" MaxLength="15" runat="server" Width="80px"></asp:TextBox>
                    <%--<asp:Button ID="btnBranchPopup" runat="server" Text="..." OnClick="BranchPopup(this)" PopupURL="../../mis/popup-cust.asp?13" />--%>
                    <input type="button" value="..." runat="server" id="btnBranchPopup" onclick="BranchPopup('BillingParty_Popup.aspx?13')" />
                    <input type="hidden" id="HIDBillPartySelFromPopupWindow" runat="server" />
                    <label id="lblErrPartyCode" runat="server" visible="false" class="blackfnt" style="color: Red;
                        font-size: small">
                        Invalid Billing Party Code!!!
                    </label>
                </td>
            </tr>
            <tr style="background-color: white">
                <td align="left" style="height: 24px; width: 100px;">
                    <asp:Label ID="Label1" CssClass="blackfnt" Text="Bill Type: " runat="server" Width="75px">
                    </asp:Label>
                </td>
                <td align="left" colspan="2" valign="top" style="height: 24px;">
                    <asp:DropDownList ID="ddlBillType" runat="server">
                        <asp:ListItem Value="All" Text="-All-"></asp:ListItem>
                        <asp:ListItem Value="Paid" Text="Paid"></asp:ListItem>
                        <asp:ListItem Value="2" Text="TBB"></asp:ListItem>
                        <asp:ListItem Value="To Pay" Text="To Pay"></asp:ListItem>
                        <asp:ListItem Value="4" Text="Misc."></asp:ListItem>
                        <asp:ListItem Value="5" Text="Cancelled"></asp:ListItem>
                        <asp:ListItem Value="6" Text="Octroi"></asp:ListItem>
                        <asp:ListItem Value="Supplimentry" Text="Supplimentry"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr style="background-color: white">
                <td align="left" style="height: 24px; width: 100px;">
                    <asp:Label ID="Label3" CssClass="blackfnt" Text="Billed At: " runat="server" Width="164px">
                    </asp:Label>
                </td>
                <td align="left" colspan="2" valign="top" style="height: 24px;">
                    <asp:TextBox ID="txtBilledAt" CssClass="input" MaxLength="3" runat="server" Width="66px"></asp:TextBox>
                    <%--<asp:Button ID="btnBilledAt" runat="server" Text="..." onclick="BranchPopup(this)" PopupURL="../popup-branch.asp?7,A,A" />--%>
                    <input type="button" value="..." runat="server" id="btnBilledAt" onclick="BranchPopup('Branch_Popup.aspx?7,A,A')" />
                    <label id="lblErrBilledAt" runat="server" visible="false" class="blackfnt" style="color: Red;
                        font-size: small">
                        Invalid Branch Code!!!
                    </label>
                </td>
            </tr>
            <tr style="background-color: white">
                <td align="left" style="width: 100px; height: 24px">
                    <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Text="Submitted At: " Width="173px">
                    </asp:Label>
                </td>
                <td align="left" colspan="2" valign="top" style="height: 24px;">
                    <asp:TextBox ID="txtSubmittedAt" CssClass="input" MaxLength="3" runat="server" Width="67px"></asp:TextBox>
                    <%--<asp:Button ID="btnSubmittedAt" runat="server" Text="..." onclick="BranchPopup(this)" PopupURL="../popup-branch.asp?8,A,A" />--%>
                    <input type="button" value="..." runat="server" id="btnSubmittedAt" onclick="BranchPopup('Branch_Popup.aspx?8,A,A')" />
                    <label id="lblErrSubmittedAt" runat="server" visible="false" class="blackfnt" style="color: Red;
                        font-size: small">
                        Invalid Branch Code!!!
                    </label>
                </td>
            </tr>
            <tr style="background-color: white">
                <td align="left" style="width: 100px; height: 9px">
                    <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Text="Collection At: "
                        Width="173px">
                    </asp:Label>
                </td>
                <td align="left" colspan="2" valign="top" style="height: 9px;">
                    <asp:TextBox ID="txtCollectionAt" CssClass="input" MaxLength="3" runat="server" Width="66px"></asp:TextBox>
                    <%--<asp:Button ID="btnCollectionAt" runat="server" Text="..." onclick="BranchPopup(this)" PopupURL="../popup-branch.asp?2,A,A" />--%>
                    <input type="button" value="..." runat="server" id="btnCollectionAt" onclick="BranchPopup('Branch_Popup.aspx?2,A,A')" />
                    <label id="lblErrCollectedAt" runat="server" visible="false" class="blackfnt" style="color: Red;
                        font-size: small">
                        Invalid Branch Code!!!
                    </label>
                </td>
            </tr>
            <tr style="background-color: white">
                <td align="left" style="height: 24px; width: 100px;">
                    <asp:Label ID="Label5" CssClass="blackfnt" Text="Status: " runat="server" Width="75px">
                    </asp:Label>
                </td>
                <td align="left" colspan="2" valign="top" style="height: 24px;">
                    <asp:DropDownList ID="ddlStatus" runat="server">
                        <asp:ListItem Value="All" Text="-All-"></asp:ListItem>
                        <asp:ListItem Value="Submitted- Due" Text="Submitted- Due"></asp:ListItem>
                        <asp:ListItem Value="Submitted – Not due" Text="Submitted – Not due"></asp:ListItem>
                        <asp:ListItem Value="Unsubmitted – Due" Text="Unsubmitted – Due"></asp:ListItem>
                        <asp:ListItem Value="Unsubmitted – Not Due" Text="Unsubmitted – Not Due"></asp:ListItem>
                        <asp:ListItem Value="Collected" Text="Collected"></asp:ListItem>
                        <asp:ListItem Value="Not Collected" Text="Not Collected"></asp:ListItem>
                        <asp:ListItem Value="Bill Cancelled" Text="Bill Cancelled"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr style="background-color: white">
                <td align="left" style="width: 100px; height: 24px">
                    <asp:Label ID="Label7" runat="server" CssClass="blackfnt" Text="Over Due Days: "
                        Width="173px">
                    </asp:Label>
                </td>
                <td align="left" colspan="2" valign="top" style="height: 24px;">
                    <%--<asp:TextBox id="txtOverDueDays" CssClass="input" MaxLength="3" Text="0" runat="server">
                                    </asp:TextBox>--%>
                    <input type="text" id="txtOverDueDays" runat="server" class="input" maxlength="3"
                        value="0" onblur="return CheckDecimalValue(this)" />
                </td>
            </tr>
            <tr style="background-color: white">
                <td align="left" style="width: 100px; height: 24px">
                    <asp:Label ID="Label8" runat="server" CssClass="blackfnt" Text="Amount Greater than: "
                        Width="173px">
                    </asp:Label>
                </td>
                <td align="left" colspan="2" valign="top" style="height: 24px;">
                    <%--<asp:TextBox id="txtAmtGreaterThan" CssClass="input" MaxLength="9" Text="0" runat="server">
                                    </asp:TextBox>--%>
                    <input type="text" id="txtAmtGreaterThan" class="input" maxlength="9" runat="server"
                        value="0" onblur="return CheckDecimalValue(this)" />
                </td>
            </tr>
            <tr style="background-color: white">
                <td align="left" style="width: 100px; height: 24px">
                    <asp:Label ID="Label9" runat="server" CssClass="blackfnt" Text="Enter Bill No.: "
                        Width="173px">
                    </asp:Label>
                </td>
                <td align="left" colspan="2" style="height: 24px;" valign="top">
                    <asp:TextBox MaxLength="1000" ID="txtBillNo" Width="254px" runat="server">
                    </asp:TextBox>
                    <asp:Label ID="Label10" runat="server" CssClass="blackfnt" Text="[seperated by <i>comma</i> 
                                          if multiple]" Width="215px">
                    </asp:Label>
                </td>
            </tr>
        </table>
        <br />
        <asp:Button ID="btnShow" runat="server" Text="Show" OnClick="btnShow_Click" Width="75px"
            OnClientClick="return DateCheck()" /><br />
        <br />
        <%-- </ContentTemplate>
                         </asp:UpdatePanel>--%>
    </center>
    <br />
</asp:Content>
