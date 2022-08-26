<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="EditCustomerContractStep1.aspx.cs" Inherits="AddCustomerContractStep1"
    EnableEventValidation="false" %>

<%@ OutputCache Location="none" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
        // JScript File
         function withOutQuote(event)
        {
            if(event.keyCode==39 || event.keyCode==34)
            {
                event.keyCode=0;
                return false;
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

             
    
    </script>

    <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
    <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>
    <script language="vbscript" type="text/vbscript">
        function findDateDifference(dtFrom, dtTo, interval)
            
            findDateDifference = DateDiff(interval, FormatDateTime(dtFrom, 2), FormatDateTime(dtTo, 2))
            
        end function
    </script>
    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("divDate");
        
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
        
        function BranchPopup(strPopupURL)
        {
            var strWinFeature = "height=375,width=350,scrollbars=yes,left=300,top=125"
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        
        function ValidateData()
        {   
            var mContractDate, mContractValidUntil, mEffectiveFrom
            
            //Check for Contract Date
            if(document.getElementById("ctl00_MyCPH1_txtcontractdate"))
            {
                if(document.getElementById("ctl00_MyCPH1_txtcontractdate").value == "")
                {
                    alert("Enter 'Contract Date' in 'DD/MM/YYYY' format");
                    document.getElementById("ctl00_MyCPH1_txtcontractdate").focus();
                    return false;
                }
            }
            
            var mContractDate = document.getElementById("ctl00_MyCPH1_txtcontractdate").value.substring(3, 5) + "/" + document.getElementById("ctl00_MyCPH1_txtcontractdate").value.substring(0, 2) + "/" + document.getElementById("ctl00_MyCPH1_txtcontractdate").value.substring(6, 10)
            
            //Check for Valid Until
            if(document.getElementById("ctl00_MyCPH1_txtValidUntil"))
            {
                if(document.getElementById("ctl00_MyCPH1_txtValidUntil").value == "")
                {
                    alert("Enter 'Contract Valid Until Date' in 'DD/MM/YYYY' format");
                    document.getElementById("ctl00_MyCPH1_txtValidUntil").focus();
                    return false;
                }
            }
            
            var mContractValidUntil = document.getElementById("ctl00_MyCPH1_txtValidUntil").value.substring(3, 5) + "/" + document.getElementById("ctl00_MyCPH1_txtValidUntil").value.substring(0, 2) + "/" + document.getElementById("ctl00_MyCPH1_txtValidUntil").value.substring(6, 10)
            
            //Check for Contract Date and Valid Until Date range
            if(findDateDifference(mContractDate, mContractValidUntil, "d") <= 0)
            {
                alert("Enter Contract Date earlier than Valid Until");
                document.getElementById("ctl00_MyCPH1_txtcontractdate").focus();
                return false;
            }
            
            //Check for Effective From Date
            if(document.getElementById("ctl00_MyCPH1_txtEffFromDate"))
            {
                if(document.getElementById("ctl00_MyCPH1_txtEffFromDate").value == "")
                {
                    alert("Enter 'Contract Effective From Date' in 'DD/MM/YYYY' format");
                    document.getElementById("ctl00_MyCPH1_txtEffFromDate").focus();
                    return false;
                }
            }
            
            var mEffectiveFrom = document.getElementById("ctl00_MyCPH1_txtEffFromDate").value.substring(3, 5) + "/" + document.getElementById("ctl00_MyCPH1_txtEffFromDate").value.substring(0, 2) + "/" + document.getElementById("ctl00_MyCPH1_txtEffFromDate").value.substring(6, 10)
            
            //Check for 'Contract Effective Date From' to be 
            //between 'Contract Date' and 'Valid Until Date' range
            if(findDateDifference(mContractDate, mEffectiveFrom, "d") < 0)
            {
                alert("Enter 'Contract Effective Date' between 'Contract Date' and 'Contract Valid Until Date'");
                document.getElementById("ctl00_MyCPH1_txtEffFromDate").focus();
                return false;
            }
            
            if(findDateDifference(mEffectiveFrom, mContractValidUntil, "d") <= 0)
            {
                alert("Enter 'Contract Effective Date' between 'Contract Date' and 'Contract Valid Until Date'");
                document.getElementById("ctl00_MyCPH1_txtEffFromDate").focus();
                return false;
            }
            
                       
            //Check for Pin Code to be Numeric
            
            
            //Check for Party Category
            if(document.getElementById("ctl00_MyCPH1_ddlpartycategory"))
            {
                if(document.getElementById("ctl00_MyCPH1_ddlpartycategory").value == "-1")
                {
                    alert("Select 'Party Category' from the list");
                    document.getElementById("ctl00_MyCPH1_ddlpartycategory").focus();
                    return false;
                }
            }
            
            //Check for Contract Category
            if(document.getElementById("ctl00_MyCPH1_ddlcontractcategory"))
            {
                if(document.getElementById("ctl00_MyCPH1_ddlcontractcategory").value == "-1")
                {
                    alert("Select 'Contract Category' from the list");
                    document.getElementById("ctl00_MyCPH1_ddlcontractcategory").focus();
                    return false;
                }
            }
            
            
            //Check for Contract Signing Location Not Empty
            var txtcontractsigninglocation=document.getElementById("ctl00_MyCPH1_txtcontractsigninglocation");
            if(txtcontractsigninglocation.value=="")
            {
                alert("Please Enter Contract Signing Location...");
                txtcontractsigninglocation.select();
                return false;
            }
            
            
            document.getElementById("ctl00_MyCPH1_btnSubmit").value = "Processing...";
            
            return true;
        }
        
        function locCodeBlur(id,locname)
        {
        
             var txt=document.getElementById(id);
             txt.value=txt.value.toUpperCase();
             if(txt.value=="")
                return false;
             var findobj=false;
             findobj=GetXMLHttpObject();
            
            if(findobj)
            {
                 var strpg="LocationTest.aspx?mode=check&code=loccode&loccode="+ txt.value + "&sid=" + Math.random();
                 findobj.open("GET",strpg);
                 findobj.onreadystatechange=function()
                     {
                         if((findobj.readyState==4) && (findobj.status==200))
                            {
                                  var  res=findobj.responseText.split("|");
                                  if(res[0]=="false")
                                     {
                                        alert("This " + locname + " doesn't Exists..");
                                        txt.select()
                                        return false;
                                     }
                            }
                     }
                 findobj.send(null);
             }
             return true;
        }
        
    </script>
<br />
    <asp:Panel runat="server" Style="width: 10in;" HorizontalAlign="left">
        <asp:Table runat="server" CssClass="blackfnt" >
             <asp:TableRow BackColor="White">
                <asp:TableCell>
				       &nbsp;ContractID  
                </asp:TableCell>
                <asp:TableCell>
                     : <asp:Label ID="lblcontractid" runat="server" onmouseover="this.style.cursor='pointer'" CssClass="redfnt" Font-Bold="true"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
                         <asp:TableRow BackColor="White">
                <asp:TableCell>
				       &nbsp;Customer Code & Name &nbsp;
                </asp:TableCell>
                <asp:TableCell>
                : <asp:Label ID="lblcustcodename" runat="server" onmouseover="this.style.cursor='pointer'" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>      
        <br />
        <asp:Table runat="server" CellSpacing="1" Width="10in">
            <asp:TableRow>
                <asp:TableCell Style="width: 100%">
                    <asp:Table runat="server" CellSpacing="1" CssClass="boxbg" Width="100%">
                        <%--Row for header--%>
                        <asp:TableRow class="bgbluegrey" runat="server">
                            <asp:TableCell ColumnSpan="4" HorizontalAlign="left" Style="height: 25px;">
                                    <label class="blackfnt">
                                        <strong>
                                            &nbsp;Reset contract details - Step 1
                                        </strong>
                                    </label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Style="background-color: White;" runat="server">
                            <asp:TableCell Style="width: 25%;" HorizontalAlign="left" VerticalAlign="top" nowrap>
                                    <label class="blackfnt">
                                        &nbsp;Selected Customer:&nbsp;
                                    </label>
                            </asp:TableCell>
                            <asp:TableCell Style="width: 25%;" HorizontalAlign="left" VerticalAlign="top">
                                <label class="blackfnt" id="lblSelectedCustomer" runat="server">
                                </label>
                            </asp:TableCell>
                            <asp:TableCell Style="width: 25%;" HorizontalAlign="left" VerticalAlign="top">
                                    &nbsp;
                                    
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="left" VerticalAlign="top">
                                &nbsp;
                                <label class="blackfnt" style="color: Red;" runat="server" id="lblcontid">
                                </label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Style="background-color: White" runat="server">
                            <asp:TableCell Style="width: 25%;" VerticalAlign="top" HorizontalAlign="left">
                                    <label class="blackfnt" style="color: Red;">
                                        &nbsp;*
                                    </label>
                                    <label class="blackfnt">
                                        Contract Date:&nbsp;
                                    </label>
                            </asp:TableCell>
                            <asp:TableCell Style="width: 25%;" Wrap="false" VerticalAlign="top" HorizontalAlign="left">
                                <asp:TextBox ID="txtcontractdate" Style="border-style: groove;" runat="server" CssClass="blackfnt"
                                    Width="70px" MaxLength="10"></asp:TextBox>
                                <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtcontractdate, 'alnkcontractdate', 'dd/MM/yyyy'); return false;"
                                   name="alnkcontractdate" id="alnkcontractdate">
                                    <img src="../../images/calendar.jpg" border="0" />
                                </a>&nbsp;(dd/mm/yyyy)&nbsp;
                            </asp:TableCell>
                            <asp:TableCell Style="width: 25%;" HorizontalAlign="left" VerticalAlign="top">
                                    <label class="blackfnt" style="color: Red;">
                                        &nbsp;*
                                    </label>
                                    <label class="blackfnt">
                                        Valid Until:&nbsp;
                                    </label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="left" Wrap="false" VerticalAlign="top">
                                <asp:TextBox ID="txtvaliduntil" Style="border-style: groove;" runat="server" CssClass="blackfnt"
                                    Width="70px" MaxLength="10"></asp:TextBox>
                                <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtvaliduntil, 'alnkvaliduntil', 'dd/MM/yyyy'); return false;"
                                   name="alnkvaliduntil" id="alnkvaliduntil">
                                    <img src="../../images/calendar.jpg" border="0" />
                                </a>&nbsp;(dd/mm/yyyy)&nbsp;
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Style="background-color: White" runat="server">
                            <asp:TableCell Style="width: 25%;" VerticalAlign="top" HorizontalAlign="left">
                                    <label class="blackfnt" style="color: Red;">
                                        &nbsp;*
                                    </label>
                                    <label class="blackfnt">
                                        Effective From Date:&nbsp;
                                    </label>
                            </asp:TableCell>
                            <asp:TableCell Style="width: 25%;" VerticalAlign="top" HorizontalAlign="left" Wrap="false">
                                <asp:TextBox ID="txtefffromdate" Style="border-style: groove;" runat="server" CssClass="blackfnt"
                                    Width="70px" MaxLength="10"></asp:TextBox>
                                <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtefffromdate, 'alnkefffromdate', 'dd/MM/yyyy'); return false;"
                                   name="alnkefffromdate" id="alnkefffromdate">
                                    <img src="../../images/calendar.jpg" border="0" />
                                </a>&nbsp;(dd/mm/yyyy)&nbsp;
                            </asp:TableCell>
                            <asp:TableCell Style="width: 25%;" HorizontalAlign="left" VerticalAlign="top">
                                    <label class="blackfnt" style="color: Red;">
                                        &nbsp;*
                                    </label>
                                    <label class="blackfnt">
                                        Contract Signing Location:&nbsp;
                                    </label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="left" VerticalAlign="top">
                                <asp:TextBox ID="txtcontractsigninglocation" Style="border-style: groove;" runat="server"
                                    CssClass="blackfnt" Width="40px" MaxLength="10" onblur="javascript:return locCodeBlur(this.getAttribute('id'),'Contract Signing')">
                                </asp:TextBox>
                                <input type="button" value="..." class="blackfnt" runat="server" id="btnContractSigningLocation"
                                    onclick="return BranchPopup('Branch_Popup.aspx?1')" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Style="background-color: White" runat="server">
                            <asp:TableCell Style="width: 25%;" VerticalAlign="top" HorizontalAlign="left">
                                    <label class="blackfnt">
                                        &nbsp;Customer Representative:&nbsp;
                                    </label>
                            </asp:TableCell>
                            <asp:TableCell Style="width: 25%;" VerticalAlign="top" HorizontalAlign="left">
                                <asp:TextBox ID="txtcustomerrepresentative" Style="border-style: groove;" runat="server"
                                    CssClass="blackfnt" Width="120px" MaxLength="50" onblur="javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell Style="width: 25%;" HorizontalAlign="left" VerticalAlign="top">
                                    <label class="blackfnt">
                                        &nbsp;Company Employee Name:&nbsp;
                                    </label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="left" VerticalAlign="top">
                                <asp:TextBox ID="txtcoempname" Style="border-style: groove;" runat="server" CssClass="blackfnt"
                                    Width="120px" MaxLength="50" onblur="javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Style="background-color: White" runat="server">
                            <asp:TableCell Style="width: 20%;" VerticalAlign="top" HorizontalAlign="left" nowrap>
                                    <label class="blackfnt">
                                        &nbsp;Designation:&nbsp;
                                    </label>
                            </asp:TableCell>
                            <asp:TableCell Style="width: 25%;" VerticalAlign="top" HorizontalAlign="left" nowrap>
                                <asp:TextBox ID="txtcustrepdesignation" Style="border-style: groove;" runat="server"
                                    CssClass="blackfnt" Width="120px" MaxLength="50" onkeypress="javascript:return withOutQuote(event)"
                                    onblur="javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell Style="width: 20%;" HorizontalAlign="left" VerticalAlign="top" nowrap>
                                    <label class="blackfnt">
                                        &nbsp;Designation:&nbsp;
                                    </label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="left" VerticalAlign="top">
                                <asp:TextBox ID="txtcoempdesignation" Style="border-style: groove;" runat="server"
                                    CssClass="blackfnt" Width="120px" MaxLength="50" onkeypress="javascript:return withOutQuote(event)"
                                    onblur="javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Style="background-color: White" runat="server">
                            <asp:TableCell Style="width: 25%;" VerticalAlign="top" HorizontalAlign="left">
                                    <label class="blackfnt">
                                        &nbsp;E-Mail ID:&nbsp;
                                    </label>
                            </asp:TableCell>
                            <asp:TableCell Style="width: 25%;" VerticalAlign="top" HorizontalAlign="left">
                                <asp:TextBox ID="txtcustemail" Style="border-style: groove;" runat="server" CssClass="blackfnt"
                                    Width="120px" MaxLength="50" onkeypress="javascript:return withOutQuote(event)"
                                    onblur="javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell Style="width: 25%;" HorizontalAlign="left" VerticalAlign="top">
                                    <label class="blackfnt">
                                        &nbsp;E-MailID:&nbsp;
                                    </label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="left" VerticalAlign="top">
                                <asp:TextBox ID="txtcompemail" Style="border-style: groove;" runat="server" CssClass="blackfnt"
                                    Width="120px" MaxLength="50" onkeypress="javascript:return withOutQuote(event)"
                                    onblur="javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Style="background-color: White" runat="server">
                            <asp:TableCell Style="width: 25%;" VerticalAlign="top" HorizontalAlign="left">
                                    <label class="blackfnt">
                                        &nbsp;Contact Number:&nbsp;
                                    </label>
                            </asp:TableCell>
                            <asp:TableCell Style="width: 25%;" VerticalAlign="top" HorizontalAlign="left" nowrap>
                                <asp:TextBox ID="txtcustphone" Style="border-style: groove;" runat="server" CssClass="blackfnt"
                                    Width="120px" MaxLength="50" onkeypress="javascript:return validInt(event)"
                                    onblur="javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell Style="width: 25%;" HorizontalAlign="left" VerticalAlign="top" nowrap>
                                    <label class="blackfnt">
                                        &nbsp;Contact Number:&nbsp;
                                    </label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="left" VerticalAlign="top" nowrap>
                                <asp:TextBox ID="txtcompphone" Style="border-style: groove;" runat="server" CssClass="blackfnt"
                                    Width="120px" MaxLength="50" onkeypress="javascript:return validInt(event)"
                                    onblur="javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Style="background-color: White" runat="server">
                            <asp:TableCell Style="width: 25%;" VerticalAlign="top" HorizontalAlign="left" nowrap>
                                    <label class="blackfnt">
                                        &nbsp;Customer Witness:&nbsp;
                                    </label>
                            </asp:TableCell>
                            <asp:TableCell Style="width: 25%;" VerticalAlign="top" HorizontalAlign="left" nowrap>
                                <asp:TextBox ID="txtcustwitness" Style="border-style: groove;" runat="server" CssClass="blackfnt"
                                    Width="120px" MaxLength="50" onkeypress="javascript:return withOutQuote(event)"
                                    onblur="javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell Style="width: 25%;" HorizontalAlign="left" VerticalAlign="top">
                                    <label class="blackfnt">
                                        &nbsp;Company Witness:&nbsp;
                                    </label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="left" VerticalAlign="top">
                                <asp:TextBox ID="txtcowitness" Style="border-style: groove;" runat="server" CssClass="blackfnt"
                                    Width="120px" MaxLength="50" onkeypress="javascript:return withOutQuote(event)"
                                    onblur="javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Style="background-color: White" runat="server">
                            <asp:TableCell Style="width: 25%;" VerticalAlign="top" HorizontalAlign="left">
                                    <label class="blackfnt">
                                        &nbsp;Billing Address:&nbsp;
                                    </label>
                            </asp:TableCell>
                            <asp:TableCell Style="width: 25%;" VerticalAlign="top" HorizontalAlign="left">
                                <asp:TextBox ID="txtbillingaddress" Style="border-style: groove;" runat="server"
                                    CssClass="blackfnt" Width="120px" MaxLength="50" onkeypress="javascript:return withOutQuote(event)"
                                    onblur="javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell Style="width: 25%;" HorizontalAlign="left" VerticalAlign="top">
                                    <label class="blackfnt">
                                        &nbsp;City-Pin Code:&nbsp;
                                    </label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="left" VerticalAlign="top">
                                <asp:TextBox ID="txtcity" Style="border-style: groove;" runat="server" CssClass="blackfnt"
                                    Width="120px" MaxLength="50" onkeypress="javascript:return withOutQuote(event)"
                                    onblur="javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                               -<asp:TextBox ID="txtpincode" Style="border-style: groove;" runat="server" CssClass="blackfnt"
                                    Width="60px" MaxLength="6" onkeypress="javascript:return withOutQuote(event)"
                                    onblur="javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Style="background-color: White" runat="server">
                            <asp:TableCell Style="width: 20%;" VerticalAlign="top" HorizontalAlign="left">
                                    <label class="blackfnt">
                                        Party Category:&nbsp;
                                    </label>
                            </asp:TableCell>
                            <asp:TableCell Style="width: 25%;" VerticalAlign="top" HorizontalAlign="left">
                                <asp:DropDownList ID="ddlpartycategory" BackColor="white" runat="server" CssClass="blackfnt">
                                    <asp:ListItem Selected="True" Text="Select" Value="-1"></asp:ListItem>
                                    <asp:ListItem Text="Corporate" Value="Corporate"></asp:ListItem>
                                    <asp:ListItem Text="Non-Corporate" Value="Non-Corporate"></asp:ListItem>
                                </asp:DropDownList>
                            </asp:TableCell>
                            <asp:TableCell Style="width: 20%;" HorizontalAlign="left" VerticalAlign="top" nowrap>
                                    <label class="blackfnt">
                                        Contract Category:&nbsp;
                                    </label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="left" VerticalAlign="top">
                                <asp:DropDownList ID="ddlcontractcategory" runat="server" BackColor="white" CssClass="blackfnt">
                                    <asp:ListItem Selected="True" Text="Select" Value="-1"></asp:ListItem>
                                    <asp:ListItem Text="Contract" Value="Contract"></asp:ListItem>
                                    <asp:ListItem Text="Sub-Contract" Value="Sub-Contract"></asp:ListItem>
                                </asp:DropDownList>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Style="background-color: White" runat="server">
                            <asp:TableCell Style="width: 25%;" VerticalAlign="top" HorizontalAlign="left">
                                    <label class="blackfnt">
                                        Accounts Person of Customer:&nbsp;
                                    </label>
                            </asp:TableCell>
                            <asp:TableCell Style="width: 25%;" VerticalAlign="top" HorizontalAlign="left">
                                <asp:TextBox ID="txtcustaccperson" Style="border-style: groove;" runat="server" CssClass="blackfnt"
                                    Width="120px" MaxLength="50" onkeypress="javascript:return withOutQuote(event)"
                                    onblur="javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell Style="width: 25%;" HorizontalAlign="left" VerticalAlign="top">
                                    <label class="blackfnt">
                                        C.S.E. Name:&nbsp;
                                    </label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="left" VerticalAlign="top">
                                <asp:TextBox ID="txtcseperson" Style="border-style: groove;" runat="server" CssClass="blackfnt"
                                    Width="120px" MaxLength="50" onkeypress="javascript:return withOutQuote(event)"
                                    onblur="javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Style="background-color: White" runat="server">
                            <asp:TableCell Style="width: 25%;" VerticalAlign="top" HorizontalAlign="left">
                                    <label class="blackfnt" style="color: Red;">
                                        &nbsp;*
                                    </label>
                                    <label class="blackfnt">
                                        Contact Number:&nbsp;
                                    </label>
                            </asp:TableCell>
                            <asp:TableCell Style="width: 25%;" VerticalAlign="top" HorizontalAlign="left">
                                <asp:TextBox ID="txtaccperphone" Style="border-style: groove;" runat="server" CssClass="blackfnt"
                                    Width="120px" MaxLength="50" onkeypress="javascript:return validInt(event)"
                                    onblur="javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell Style="width: 25%;" HorizontalAlign="left" VerticalAlign="top">
                                    <label class="blackfnt">
                                        Contact Number&nbsp;
                                    </label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="left" VerticalAlign="top">
                                <asp:TextBox ID="txtcsephone" Style="border-style: groove;" runat="server" CssClass="blackfnt"
                                    Width="120px" MaxLength="50" onkeypress="javascript:return validInt(event)"
                                    onblur="javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Style="background-color: White" runat="server">
                            <asp:TableCell Style="width: 25%;" VerticalAlign="top" HorizontalAlign="left">
                                    <label class="blackfnt" style="color: Red;">
                                        &nbsp;*
                                    </label>
                                    <label class="blackfnt">
                                        E-Mail ID:&nbsp;
                                    </label>
                            </asp:TableCell>
                            <asp:TableCell Style="width: 25%;" VerticalAlign="top" HorizontalAlign="left">
                                <asp:TextBox ID="txtaccperemailid" Style="border-style: groove;" runat="server" CssClass="blackfnt"
                                    Width="120px" MaxLength="50" onkeypress="javascript:return withOutQuote(event)"
                                    onblur="javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell Style="width: 25%;" HorizontalAlign="left" VerticalAlign="top">
                                    <label class="blackfnt">
                                       E-Mail ID:&nbsp;
                                    </label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="left" VerticalAlign="top">
                                <asp:TextBox ID="txtcseemail" Style="border-style: groove;" runat="server" CssClass="blackfnt"
                                    Width="120px" MaxLength="50" onkeypress="javascript:return withOutQuote(event)"
                                    onblur="javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Style="background-color: White" runat="server">
                            <asp:TableCell Style="width: 20%;" VerticalAlign="top" HorizontalAlign="left">
                                    <label class="blackfnt">
                                        &nbsp;Service Tax Applicable:&nbsp;
                                    </label>
                            </asp:TableCell>
                            <asp:TableCell Style="width: 25%;" VerticalAlign="top" HorizontalAlign="left">
                                <asp:CheckBox ID="chkstapp" runat="server" CssClass="blackfnt" />
                            </asp:TableCell>
                            <asp:TableCell Style="width: 20%;" HorizontalAlign="left" VerticalAlign="top">
                                    <label class="blackfnt">
                                        &nbsp;Accounts Representative:&nbsp;
                                    </label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="left" VerticalAlign="top" nowrap>
                                <asp:TextBox ID="txtaccountsrepresentative" Style="border-style: groove;" runat="server"
                                    CssClass="blackfnt" Width="120px" MaxLength="50" onkeypress="javascript:return withOutQuote(event)"
                                    onblur="javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Style="background-color: White" runat="server">
                            <asp:TableCell Style="width: 20%;" VerticalAlign="top" HorizontalAlign="left">
                                    <label class="blackfnt">
                                        &nbsp;Remarks &nbsp;
                                    </label>
                            </asp:TableCell>
                            <asp:TableCell Style="width: 25%;" VerticalAlign="top" HorizontalAlign="left">
                                <asp:TextBox ID="txtremarks" runat="server" TextMode="MultiLine" Width="180px" onblur="this.value=this.value.toUpperCase()"
                                    CssClass="blackfnt" BorderStyle="groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell Style="width: 20%;" HorizontalAlign="left" VerticalAlign="top">
                                   Contract Mode
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="left" VerticalAlign="top">
                                &nbsp;
                                <asp:DropDownList ID="cmbcontractmode" DataTextField="codedesc" DataValueField="codeid"
                                    runat="server" CssClass="blackfnt" BackColor="white">
                                </asp:DropDownList>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                    <br />
                    <asp:Table runat="server" CellSpacing="1" CssClass="boxbg" Width="100%">
                        <asp:TableRow CssClass="bgbluegrey">
                            <asp:TableCell HorizontalAlign="center">
                                <asp:Button ID="btnSubmit" Text="Submit" runat="server" ToolTip="Click here to submit and proceed"
                                    OnClientClick="return ValidateData()" CssClass="blackfnt" OnClick="btnSubmit_Click" />
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <br />
        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
            <ProgressTemplate>
                <div id="progressArea">
                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="blackfnt" Font-Bold="true"></asp:Label>
                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
    </asp:Panel>
    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
