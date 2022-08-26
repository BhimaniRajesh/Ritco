<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Query.aspx.cs" Inherits="GUI_UNI_MIS_RouteTimeline_DMRV_Query" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<div id="testdiv1" style="position:absolute;visibility:hidden;background-color:white;z-index:99;"></div>
<script language="javascript" type="text/javascript" src="../../admin/CustomerContractMaster/Scripts/commonJs.js"></script>
<script language="javascript" type="text/javascript" src="../../admin/CustomerContractMaster/Scripts/CalendarPopup.js"></script>
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
    <a href="javascript:window.history.go(-1)" title="back">
        <img id="IMG1" align="right" alt="" border="0" src="../../../GUI/images/back.gif" /></a>&nbsp;
    <asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="True" NavigateUrl="~/GUI/UNI_MIS/rpt_operation.aspx">Operations</asp:HyperLink>
    &gt;
    <asp:Label ID="Label3" runat="server" CssClass="blackfnt" Text="Route Timeliness Track and DMRV and Route Movement"></asp:Label>

    &nbsp;
    
        &nbsp;
    <center>
    <asp:UpdatePanel ID="UPShowBrands" runat="server"    UpdateMode="Conditional" RenderMode="Inline">
        <ContentTemplate>
            <center>
                <table cellspacing="1" style="width: 100%">
                    <tr align="center">
                        <td>
                            <table cellspacing="1" class="boxbg" style="width: 70%">
                                <tr class="bgbluegrey">
                                    <td align="center" colspan="3">
                                        <asp:Label ID="lblQry" runat="server" CssClass="blackfnt" Font-Bold="True">Search Criteria</asp:Label></td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left" style="width: 146px">
                                        &nbsp;<asp:Label ID="lblDateRange1" runat="server" CssClass="blackfnt" Font-Bold="True"
                                            Width="116px">Select THC Date</asp:Label>
                                        &nbsp; &nbsp; &nbsp;
                                    </td>
                                    <td align="left" valign="top">
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
                                    <td align="left" valign="top">
                                        <asp:UpdatePanel ID="UpdatePanel2" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
                                            <ContentTemplate>
                                                <asp:Label ID="lblFrom" runat="server" CssClass="blackfnt" Text=" From: "></asp:Label>
                                                <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                                <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor1','dd/MM/yyyy'); return false;" name="anchor1" id="anchor1" ><img alt="" src="../../images/calendar.jpg" border="0" />
                                                </a>
                                                <asp:Label ID="lblTo" runat="server" CssClass="blackfnt" Text=" To: "></asp:Label>
                                                <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                                <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateTo,'anchor2','dd/MM/yyyy'); return false;" name="anchor2" id="anchor2" ><img alt="" src="../../images/calendar.jpg" border="0" />
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
                                    <td align="left" style="width: 146px">
                                        &nbsp;<asp:Label ID="lblSelRo" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Route Start Location"></asp:Label></td>
                                    <td align="left" colspan="2">
                                        &nbsp;<asp:TextBox ID="txtStartLoc" runat="server" Width="93px"></asp:TextBox>
                                        <input id="btnStartLoc" runat="server" name="" type="button" /></td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left" style="width: 146px">
                                        &nbsp;<asp:Label ID="lblSelLoc" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Route End Location"></asp:Label>
                                    </td>
                                    <td align="left" colspan="2">
                                        &nbsp;<asp:TextBox ID="txtEndLoc" runat="server" Width="93px"></asp:TextBox>
                                        <input id="btnEndLoc" runat="server" name="" type="button" /></td>
                                    &nbsp;</tr>
                                <tr style="background-color: white">
                                    <td align="left" style="width: 146px">
                                        &nbsp;<asp:Label ID="lblCustCode" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Enroute Location"
                                            Width="118px"></asp:Label>
                                    </td>
                                    <td align="left" colspan="2">
                                        &nbsp;<asp:TextBox ID="txtEnLoc" runat="server" Width="93px"></asp:TextBox>
                                        <input id="btnLoc" runat="server" name="" type="button" />
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left" style="width: 146px">
                                        &nbsp;<asp:Label ID="lblMode" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Mode of Transport"
                                            Width="132px"></asp:Label></td>
                                    <td align="left" colspan="2">
                                        &nbsp;<asp:DropDownList ID="cboMode" runat="server" CssClass="blackfnt">
                                            <asp:ListItem>ALL</asp:ListItem>
                                            <asp:ListItem Value="A">Air</asp:ListItem>
                                            <asp:ListItem Value="S">Road</asp:ListItem>
                                            <asp:ListItem Value="R">Train</asp:ListItem>
                                            <asp:ListItem Value="E">Express</asp:ListItem>
                                        </asp:DropDownList></td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left" style="width: 146px; height: 21px">
                                        &nbsp;<asp:Label ID="Label2" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Enter THC No."
                                            Width="106px"></asp:Label></td>
                                    <td align="left" colspan="2" style="height: 21px">
                                        &nbsp;<asp:TextBox ID="txtTHCNo" runat="server" Width="187px"></asp:TextBox>
                                        <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="[seperated by comma if multiple]"></asp:Label></td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="center" colspan="3" style="height: 21px">
                                        <asp:RadioButton ID="rbtTimeTrack" runat="server" Text="TimeLine Track" CssClass="blackfnt" AutoPostBack="true" OnCheckedChanged="rbtTimeTrack_CheckedChanged" />
                                        &nbsp; &nbsp;
                                        <asp:RadioButton ID="rbtRMRV" runat="server" Text="DMRV" CssClass="blackfnt" AutoPostBack="true" OnCheckedChanged="rbtRMRV_CheckedChanged" />
                                        &nbsp;&nbsp;
                                        <asp:RadioButton ID="rbtRoute" runat="server" Text="Route Movement Report" CssClass="blackfnt" AutoPostBack="true" OnCheckedChanged="rbtRoute_CheckedChanged" />
                                        &nbsp; &nbsp;<asp:DropDownList ID="cboStatus" runat="server" CssClass="blackfnt">
                                            <asp:ListItem>Both</asp:ListItem>
                                            <asp:ListItem Value="C">Completed</asp:ListItem>
                                            <asp:ListItem Value="N">Non-Completed</asp:ListItem>
                                        </asp:DropDownList></td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="right" colspan="3">
                                        <asp:Button ID="btnShowTHCRoute" runat="server" OnClick="btnShowTHCRoute_OnClick" Text="Show THC Route (s) >>" OnClientClick="return DateCheck()"/></td>
                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                                        ShowSummary="False" />
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                &nbsp;&nbsp;</center>
        </ContentTemplate>
    </asp:UpdatePanel>
    </center>
</asp:Content>
