<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="CommunicationExpenseBillEntry.aspx.cs" Inherits="CommunicationExpenseBill_Entry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<%--<link href="../../../GUI/Telecomm/CalendarControl.css" rel="stylesheet" type="text/css" />--%>

<script language="javascript" type="text/javascript" src="../../admin/CustomerContractMaster/Scripts/commonJs.js"></script>
<script language="javascript" type="text/javascript" src="../../admin/CustomerContractMaster/Scripts/CalendarPopup.js"></script>
<script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
cal.setCssPrefix("TEST");
cal.showNavigationDropdowns();
</script>

<script language="javascript" type="text/javascript">
    var GridDevNo = "";
    var GridBillNo = "";
    var GridBillDate = "";
    var GridDueDate = "";
    var GridBillAmt = "";
    var GridBillSvcTax = "";
    var GridBillCess = "";
    var GridBillTot = "";
    var GridFootBillAmt = "";
    var GridFootSvcTax = "";
    var GridFootCess = "";
    var GridFootTot = "";
    var GridFootTotal = "";
    
function GiveAlert()
{
    alert("Please Insert Correct Device No");
}
function Check()
{
    if(document.getElementById("ctl00_MyCPH1_txtNumber").value !="")
    {
        for(var BillNo = 1; BillNo <= document.getElementById("ctl00_MyCPH1_txtNumber").value; BillNo++)
        {
            //debugger
            GridDevNo = "ctl00_MyCPH1_gvBillDetails_ctl" + (BillNo < 9 ? ("0" + (BillNo + 1)) : (BillNo + 1)) +"_ddlDevNo";
            GridBillNo = "ctl00_MyCPH1_gvBillDetails_ctl" + (BillNo < 9 ? ("0" + (BillNo + 1)) : (BillNo + 1)) +"_txtBillNo";
            GridBillDate = "ctl00_MyCPH1_gvBillDetails_ctl" + (BillNo < 9 ? ("0" + (BillNo + 1)) : (BillNo + 1)) +"_txtBillDt";
            GridDueDate = "ctl00_MyCPH1_gvBillDetails_ctl" + (BillNo < 9 ? ("0" + (BillNo + 1)) : (BillNo + 1)) +"_txtDueDt";
            GridBillAmt = "ctl00_MyCPH1_gvBillDetails_ctl" + (BillNo < 9 ? ("0" + (BillNo + 1)) : (BillNo + 1)) +"_txtAmt";
            GridBillSvcTax = "ctl00_MyCPH1_gvBillDetails_ctl" + (BillNo < 9 ? ("0" + (BillNo + 1)) : (BillNo + 1)) +"_txtSvcTax";
            
            if(document.getElementById(GridDevNo).value != "- Select One -")
            {
                if(document.getElementById(GridBillNo).value == "")
                {
                    alert("Please Enter Bill Number For Device No: " + document.getElementById(GridDevNo).value);
                    document.getElementById(GridBillNo).focus();
                    return false;
                }
                if(document.getElementById(GridBillDate).value == "")
                {
                    alert("Please Enter Bill Date For Device No: " + document.getElementById(GridDevNo).value);
                    document.getElementById(GridBillDate).focus();
                    return false;
                }
                if(document.getElementById(GridDueDate).value == "")
                {
                    alert("Please Enter Bill Due Date For Device No: " + document.getElementById(GridDevNo).value);
                    document.getElementById(GridDueDate).focus();
                    return false;
                }
                if(document.getElementById(GridBillAmt).value == "")
                {
                    alert("Please Enter Bill Amount For Device No: " + document.getElementById(GridDevNo).value);
                    document.getElementById(GridBillAmt).focus();
                    return false;
                }
                if(document.getElementById(GridBillSvcTax).value == "")
                {
                    alert("Please Enter Bill Service Tax For Device No: " + document.getElementById(GridDevNo).value);
                    document.getElementById(GridBillSvcTax).focus();
                    return false;
                } 
                if(ValidateDate(document.getElementById(GridBillDate)) == false)
                {
                    return false;
                }  
                if(ValidateDate(document.getElementById(GridDueDate)) == false)
                {
                    return false;
                }               
            }            
            if(document.getElementById(GridBillNo).value != "")
            {
                if(document.getElementById(GridDevNo).value == "")
                {
                    alert("Please Enter Bill Device Number For Device No: " + document.getElementById(GridBillNo).value);
                    document.getElementById(GridDevNo).focus();
                    return false;
                }
            }
        }
    }
}
function PopupDt()
{
    if(document.getElementById("ctl00_MyCPH1_txtNumber").value !="")
    {
        for(var BillNo = 1; BillNo <= document.getElementById("ctl00_MyCPH1_txtNumber").value; BillNo++)
        {
            GridBillDate = "ctl00_MyCPH1_gvBillDetails_ctl" + (BillNo < 9 ? ("0" + (BillNo + 1)) : (BillNo + 1)) +"_txtBillDt";
        }
        document.getElementById(GridBillDate).innerText="";
    }
}
function AmountChk()
{ 
    var TotAmt = 0;
    var TotSvc = 0;
    var TotCess = 0;
    var Total = 0;
    if(document.getElementById("ctl00_MyCPH1_txtNumber").value !="")
    {
         for(var BillNo = 1; BillNo <= document.getElementById("ctl00_MyCPH1_txtNumber").value; BillNo++)
        {       
            var TextNumber = document.getElementById("ctl00_MyCPH1_txtNumber").value;
            GridBillAmt = "ctl00_MyCPH1_gvBillDetails_ctl" + (BillNo < 9 ? ("0" + (BillNo + 1)) : (BillNo + 1)) +"_txtAmt";
            GridBillSvcTax = "ctl00_MyCPH1_gvBillDetails_ctl" + (BillNo < 9 ? ("0" + (BillNo + 1)) : (BillNo + 1)) +"_txtSvcTax";
            GridBillCess = "ctl00_MyCPH1_gvBillDetails_ctl" + (BillNo < 9 ? ("0" + (BillNo + 1)) : (BillNo + 1)) +"_txtCess";
            GridBillTot = "ctl00_MyCPH1_gvBillDetails_ctl" + (BillNo < 9 ? ("0" + (BillNo + 1)) : (BillNo + 1)) +"_lblTot";
            
            
            if(document.getElementById(GridBillAmt).value !="")
            {
                if(isNaN(document.getElementById(GridBillAmt).value))
                {
                    alert("Please Enter Only Numeric Value");
                    document.getElementById(GridBillAmt).value ="";
                    document.getElementById(GridBillAmt).focus();
                    window.event.cancelBubble = true;
                    return false;
                }                
                document.getElementById(GridBillTot).innerText = parseFloat(document.getElementById(GridBillAmt).value);
                TotAmt = TotAmt + parseFloat(document.getElementById(GridBillAmt).value);                            
            }
            if(document.getElementById(GridBillSvcTax).value !="")
            {
                if(isNaN(document.getElementById(GridBillSvcTax).value))
                {
                    alert("Please Enter Only Numeric Value");
                    document.getElementById(GridBillSvcTax).value ="";
                    document.getElementById(GridBillSvcTax).focus();
                    window.event.cancelBubble = true;
                    return false;
                }
                document.getElementById(GridBillTot).innerText = parseFloat(document.getElementById(GridBillAmt).value) - parseFloat(document.getElementById(GridBillSvcTax).value);
                TotSvc = TotSvc + parseFloat(document.getElementById(GridBillSvcTax).value);                
            }
            if(document.getElementById(GridBillCess).value !="")
            {
                if(isNaN(document.getElementById(GridBillCess).value))
                {
                    alert("Please Enter Only Numeric Value");
                    document.getElementById(GridBillCess).value ="";    
                    document.getElementById(GridBillCess).focus();
                    window.event.cancelBubble = true;
                    return false;
                }
                document.getElementById(GridBillTot).innerText = parseFloat(document.getElementById(GridBillAmt).value) - parseFloat(document.getElementById(GridBillSvcTax).value) - parseFloat(document.getElementById(GridBillCess).value);
                TotCess = TotCess + parseFloat(document.getElementById(GridBillCess).value);   
                
                              
            }  
              Total = Total + parseFloat(document.getElementById(GridBillTot).value);        
         }
         GridFootBillAmt = "ctl00_MyCPH1_gvBillDetails_ctl" + (parseInt(TextNumber) < 8 ? ("0" + (parseInt(TextNumber) + 2)) : (parseInt(TextNumber) + 2)) +"_lblAmt";
         GridFootSvcTax = "ctl00_MyCPH1_gvBillDetails_ctl" + (parseInt(TextNumber) < 8 ? ("0" + (parseInt(TextNumber) + 2)) : (parseInt(TextNumber) + 2)) +"_lblSvcTax";
         GridFootCess = "ctl00_MyCPH1_gvBillDetails_ctl" + (parseInt(TextNumber) < 8 ? ("0" + (parseInt(TextNumber) + 2)) : (parseInt(TextNumber) + 2)) +"_lblCess";
         GridFootTotal = "ctl00_MyCPH1_gvBillDetails_ctl" + (parseInt(TextNumber) < 8 ? ("0" + (parseInt(TextNumber) + 2)) : (parseInt(TextNumber) + 2)) +"_lblTotal";
         document.getElementById(GridFootBillAmt).innerText = Math.round(TotAmt);
         document.getElementById(GridFootSvcTax).innerText = Math.round(TotSvc);
         document.getElementById(GridFootCess).innerText = Math.round(TotCess);
         document.getElementById(GridFootTotal).innerText = Math.round(TotAmt) - Math.round(TotSvc, 2) - Math.round(TotCess, 2);
         document.getElementById("ctl00_MyCPH1_lblTotAmt").innerText = Math.round(TotAmt);
         //document.getElementById("txtTotAmt").innerText = TotAmt;
         document.getElementById("ctl00_MyCPH1_lblSvcTax").innerText = TotSvc;
         document.getElementById("ctl00_MyCPH1_lblTotCess").innerText = TotCess;
         document.getElementById("ctl00_MyCPH1_lblTotal").innerText = document.getElementById(GridFootTotal).innerText;  
         document.getElementById("ctl00_MyCPH1_lblNetPay").innerText = document.getElementById(GridFootTotal).innerText; 
         
         document.getElementById("ctl00_MyCPH1_HidTotalAmount").value = TotAmt; 
         document.getElementById("ctl00_MyCPH1_HidSvcTax").value = TotSvc;
         document.getElementById("ctl00_MyCPH1_HidCess").value = TotCess;
         document.getElementById("ctl00_MyCPH1_HidTotal").value = document.getElementById(GridFootTotal).innerText;       
         document.getElementById("ctl00_MyCPH1_HidNetPay").value = document.getElementById(GridFootTotal).innerText;
                     
     }
     
     return true;
}
function DateCheck()
{
    if(document.getElementById("ctl00_MyCPH1_txtEntryDt").value == "")
    {
        alert("Please Enter Bill Entry Date");
        return false;
    }
    if(ValidateDate(document.getElementById("ctl00_MyCPH1_txtEntryDt")) == false)
    {
        return false;
    }
}
function Upper1()
{
    if(document.getElementById("ctl00_MyCPH1_txtNumber").value !="")
    {
        for(var BillNo = 1; BillNo <= document.getElementById("ctl00_MyCPH1_txtNumber").value; BillNo++)
        {
            GridDevNo = "ctl00_MyCPH1_gvBillDetails_ctl" + (BillNo < 9 ? ("0" + (BillNo + 1)) : (BillNo + 1)) +"_ddlDevNo";
            GridBillNo = "ctl00_MyCPH1_gvBillDetails_ctl" + (BillNo < 9 ? ("0" + (BillNo + 1)) : (BillNo + 1)) +"_txtBillNo";
            
            if(document.getElementById(GridDevNo).value != "")
            {
                document.getElementById(GridDevNo).innerText = document.getElementById(GridDevNo).value.toUpperCase();                
            }
            if(document.getElementById(GridBillNo).value != "")
            {
                document.getElementById(GridBillNo).innerText = document.getElementById(GridBillNo).value.toUpperCase();
            }
         }
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
       <input type="hidden" id="HidTotalAmount" runat="server" />
       <input type="hidden" id="HidSvcTax" runat="server" />
       <input type="hidden" id="HidCess" runat="server" />
       <input type="hidden" id="HidTotal" runat="server" />
       <input type="hidden" id="HidNetPay" runat="server" />
    <br />
    <a href="javascript:window.history.go(-1)" title="back">
    <img id="IMG1" align="right" alt="" border="0" src="../../../GUI/images/back.gif" /></a><asp:HyperLink
        ID="HlEntryBill" runat="server" Font-Underline="True" NavigateUrl="~/GUI/Telecomm/Home.aspx">Communication Expense Bill</asp:HyperLink>
    &gt;
    <asp:HyperLink ID="hlVendor" runat="server" Font-Underline="True" NavigateUrl="~/GUI/Telecomm/Bill Entry/Query.aspx">Vendor Selection</asp:HyperLink>
    &gt;
    <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="Bill Entry"></asp:Label><br />
       <br /> 
        <table id="TABLE1" align="center" cellpadding="0" cellspacing="1" style="width: 80%" class="boxbg">
            <tr>
                <td align="center" class="bgbluegrey" style="height: 27px">
                    <font class="blackfnt"><strong><span style="font-size: 8pt; font-family: Verdana">Bill
                        Summary</span></strong></font></td>
            </tr>
        </table>
        
        <table id="Table2" align="center" cellspacing="1" cellpadding="1" width="85%" class="boxbg" style="width: 80%;">
                <tr bgcolor="white">
                    <td class="field1" style="width: 126px">
                        <font class="blackfnt"> &nbsp;Bill Entry number</font>
                    </td>
                    <td align="left" class="blackfnt" ><font color="red">
                        &nbsp;&lt;System
                            Genarated&gt; </font>
                    </td>
                    <td class="field1" style="width: 123px">
                         <font class="blackfnt">&nbsp;Bill Entry date</font>
                    </td>
                    <td align="left" style="width: 214px">
                        &nbsp;<asp:TextBox ID="txtEntryDt" runat="server" Width="76px"></asp:TextBox>                    
                        </td>
                </tr>
                
                <tr bgcolor="white">
                    <td class="field1" style="width: 126px">
                         <font class="blackfnt">&nbsp;Vendor Type</font>
                    </td>
                    <td align="left" class="blackfnt">
                        &nbsp;Service Provider - Communication</td>
                    
                    <td class="field1" style="width: 123px">
                         <font class="blackfnt">&nbsp;Vendor</font>
                    </td>
                    <td align="left" style="width: 214px; font-size: 12pt; font-family: Times New Roman;">
                        &nbsp;<asp:Label ID="lblVendor" runat="server" CssClass="blackfnt"></asp:Label></td>
                </tr>
                <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman">
                    <td class="field1" style="width: 126px; height: 23px">
                         <font class="blackfnt">&nbsp;Total Amount</font>
                    </td>
                    <td align="left" style="height: 23px; width: 209px; font-size: 12pt; font-family: Times New Roman;">
                        &nbsp;<asp:Label ID="lblTotAmt" runat="server" CssClass="blackfnt"></asp:Label><%--<label id="lblTotAmt" runat="server" class="blackfnt"></label>--%></td>
                    <td class="field1" style="width: 123px; height: 23px; font-size: 12pt; font-family: Times New Roman;">
                        <strong>
                         <font class="blackfnt">&nbsp;TDS Rate</font><span style="font-size: 8pt;
                            font-family: Verdana">&nbsp;</span></strong></td>
                    <td align="left" style="height: 23px; font-weight: bold; font-size: 8pt; font-family: Verdana;">
                        &nbsp;<asp:Label ID="lblTDSRate" runat="server" CssClass="blackfnt">0</asp:Label></td>
                </tr>
                <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman">
                    <td class="field1" style="width: 126px">
                         <font class="blackfnt">&nbsp;Total Service Tax</font>
                    </td>
                    <td align="left" style="width: 209px; font-size: 12pt; font-family: Times New Roman;">
                        &nbsp;<asp:Label ID="lblSvcTax" runat="server" CssClass="blackfnt"></asp:Label></td>
                    
                    <td class="field1" style="width: 123px; font-size: 12pt; font-family: Times New Roman;">
                        <font class="blackfnt">&nbsp;TDS (-)</font>
                    </td>
                    <td style="font-size: 12pt; font-family: Times New Roman" >
                        &nbsp;<asp:Label ID="lblTDS" runat="server" CssClass="blackfnt">0</asp:Label></td>
                </tr>
                
                <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman">
                    <td class="field1" style="width: 126px">
                    <font class="blackfnt">&nbsp;Total Cess</font>
                       
                    </td>
                    <td align="left" style="width: 209px">
                        &nbsp;<asp:Label ID="lblTotCess" runat="server" CssClass="blackfnt"></asp:Label></td>
                    <td style="width: 123px"><font class="blackfnt"></font></td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr bgcolor="white">
                    <td class="field1" style="width: 126px">
                        <font class="blackfnt">&nbsp;Total</font>
                    </td>
                    <td align="left" style="width: 209px">
                        &nbsp;<asp:Label ID="lblTotal" runat="server" CssClass="blackfnt"></asp:Label></td>
                    <td style="width: 123px">
                        <font class="blackfnt">&nbsp;Net Payable</font>
                   </td>
                   <td>
                       &nbsp;<asp:Label ID="lblNetPay" runat="server" CssClass="blackfnt" ></asp:Label></td>
                        &nbsp;</tr>
          </table>
        
        <br />
        <table align="center" cellpadding="0" cellspacing="1" class="boxbg" width="80%">
            <tr class="bgbluegrey">
                <td align="center" class="bgbluegrey" style="height: 27px">
                <font class="blackfnt"><strong>Bill Details</strong></font></td>
            </tr>
        </table>
    <div align="center">
        &nbsp;</div>
    
    
    <div align="center">
    <asp:UpdatePanel ID="UpdatePanel8" runat="server"  UpdateMode="Conditional" RenderMode="Inline">               
            <ContentTemplate>	
            <table align="center" cellpadding="0" cellspacing="1" class="boxbg" width="20%">
        <tr bgcolor="white">
        <td class="blackfnt">Number of Bills</td>
        <td style="width: 94px">
            <asp:TextBox ID="txtNumber" runat="server" Width="40px" AutoPostBack="true" OnTextChanged="txtNumber_TextChanged">5</asp:TextBox></td>
        </tr>
        </table>
                <br />
                <asp:GridView ID="gvBillDetails" runat="server" AllowSorting="True" AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CssClass="blackfnt" ShowFooter="True" OnRowDataBound="gvBillDetails_RowDataBound">
                <Columns>
                <asp:TemplateField HeaderText="Device Number">
                <ItemTemplate>
                <asp:DropDownList ID="ddlDevNo" runat="server" AutoPostBack="true" OnTextChanged="CheckDeviceNo_TextChanged"></asp:DropDownList>
                <%--<asp:TextBox ID="txtDevNo" runat="server" onblur="JavaScript:this.value=this.value.toUpperCase();" AutoPostBack="true" OnTextChanged="CheckDeviceNo_TextChanged"/>--%>               
                <%--<asp:Label ID="lblDevNo" runat="server" Visible="true" CssClass="blckfnt" ForeColor="red"></asp:Label>--%>
                <label ID="lblDevNo" runat="server" visible="true" class="blckfnt" style="color: Red; vertical-align:top" />
                </ItemTemplate>                             
                </asp:TemplateField>                
                <asp:TemplateField HeaderText="Device Type">
                <ItemTemplate>
                <asp:Label ID="DeviceType" runat="server"></asp:Label>
                </ItemTemplate>    
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Employee Name">
                <ItemTemplate>
                <asp:Label ID="EmpName" runat="server"></asp:Label>
                </ItemTemplate>    
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Bill Number">
                <ItemTemplate>
                <asp:TextBox ID="txtBillNo" runat="server" onblur="JavaScript:this.value=this.value.toUpperCase();" Width="70" MaxLength="49" />
                </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Bill Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                            <ItemTemplate>
                                <asp:TextBox runat="server" ID="txtBillDt" Width="60"></asp:TextBox>
                     
                                <asp:LinkButton ID="lnkdate" runat="server">
                                    <img src="../../admin/CustomerContractMaster/images/calendar.jpg" alt="calendar.jpg" border="0"></a>(dd/mm/yyyy)
                                </asp:LinkButton>
                            </ItemTemplate>
                </asp:TemplateField>
               
                <asp:TemplateField HeaderText="Due Date" FooterText="Total">
                <ItemTemplate>
                <asp:TextBox ID="txtDueDt" runat="server" onlostfocus="hidecalendarcontrol();" Width="60"/>
                <asp:LinkButton ID="lnkdate1" runat="server">
                <img src="../../admin/CustomerContractMaster/images/calendar.jpg" alt="calendar.jpg" border="0"></a>(dd/mm/yyyy)
                </asp:LinkButton>
                </ItemTemplate>
                <FooterStyle Font-Bold="True" />                
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Amount">                
                <ItemTemplate>
                <asp:TextBox ID="txtAmt" runat="server" onblur="return AmountChk()" MaxLength="9" Width="60"/>              
                </ItemTemplate>
                <FooterTemplate>
                <div align="left">
                <asp:Label ID="lblAmt" runat="server"></asp:Label></div> 
                </FooterTemplate>                
                <ItemStyle HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Service Tax">
                <ItemTemplate>
                <asp:TextBox ID="txtSvcTax" runat="server" onblur="return AmountChk()" MaxLength="9" Width="60"/>
                </ItemTemplate>
                <FooterTemplate>
                <div align="left">
                <asp:Label ID="lblSvcTax" runat="server"></asp:Label> </div>
                </FooterTemplate>              
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Cess">
                <ItemTemplate>
                <asp:TextBox ID="txtCess" runat="server" onblur="return AmountChk()"  MaxLength="9" Width="60"/>
                </ItemTemplate>
                <FooterTemplate>
                <div align="left">
                <asp:Label ID="lblCess" runat="server"></asp:Label></div>
                </FooterTemplate>          
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Total">
                <ItemTemplate>
                <asp:TextBox ID="lblTot" runat="server" Enabled="true" Width="70px" />
                </ItemTemplate>
                <FooterTemplate>
                <div align="left">
                <asp:Label ID="lblTotal" runat="server"></asp:Label></div>
                </FooterTemplate>              
                </asp:TemplateField>
                </Columns>
                </asp:GridView>
         </ContentTemplate>
        </asp:UpdatePanel>
                &nbsp;&nbsp;
        <br />
        <asp:Button ID="btnSubmit" runat="server" CssClass="blackfnt" Text="Submit" OnClientClick="return Check()" OnClick="btnSubmit_Click" />&nbsp;</div>            
        <div id="testdiv1" style="position:absolute;visibility:hidden;background-color:white;z-index:99;"></div>
    </asp:Content>
