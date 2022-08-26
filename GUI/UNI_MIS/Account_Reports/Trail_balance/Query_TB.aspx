<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Query_TB.aspx.cs" Inherits="GUI_UNI_MIS_Account_Reports_TRIALBALANCE_PARTYWISE_Query_trailBalne_party"  Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script type="text/javascript" language="JavaScript" src="../../../Images/CalendarPopup.js"></script> 
<script type="text/javascript"language="javascript" src="../../../images/commonJs.js"></script>
<script type="text/javascript" language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
	
</script>

    <%--<title>Docket Flow Report</title>--%>
    
    
   <%-- 
     <link id="Link1" href="~/images/style.css" rel="Stylesheet" 
            type="text/css" runat="server" />--%>
            <script language="javascript" type="text/javascript">
            
            //alert("HI")
            
           
            
            function Submitdata(ddlro,txtDateFrom,txtDateTo,btnShow)
            {
                    // alert(radFlow[0].checked)
                     //debugger
//                      if(radFlow.checked==true)
//                      {
//                        alert("hai")
//                      } 
//                      if(document.getElementById("ctl00_MyCPH1_radFlow_0").checked==true)
//                      {
//                        
//                      } 

					branch=ddlro.value;
					//alert(radFlow[0].checked)
					if(branch=="")
					{
						alert("Please Enter Branch/Profit Center from lookup!!!")
						ddlro.focus();
						return false;
					}
//					  debugger
					if("<%=Session["brcd"]%>"=="<%=Session["HeadOfficeCode"]%>") 
					{
					
					   // alert("<%=Session["brcd"]%>");
					  
						if((document.getElementById("ctl00_MyCPH1_radFlow_0").checked==false)&&(branch!="<%=Session["brcd"]%>"))
						{
						    //alert("<%=Session["HeadOfficeCode"]%>")
							alert("This option is applicable only to head office to show cumulative balance of selected account!!!")
							ddlro.focus();
							return false;
						}  
					}
					
					//alert(txtDateFrom.value)
					
					if(txtDateFrom.value=="")
							 {
							  alert("Please enter the From Date")
							  txtDateFrom.focus();
							  return false;
							 }
							 
							if(txtDateFrom.value!="")
							 {
									if (ValidateForm(txtDateFrom)==false)
									{
									 return false;
									}
							 }
							 
							if(txtDateTo.value=="")
							 {
							  alert("Please enter the To Date")
							 txtDateTo.focus();
							  return false;
							 }
								
							if(txtDateTo.value!="")
							 {
									if (ValidateForm(txtDateTo)==false)
									{
									 return false;
									}
							}
			}
			
			
            
            function ValidateForm(obj){

if (obj.value!="")
{

if (isDate(obj.value)==false){

obj.focus()
return false
}
return true
}
}
var dtCh= "/";
var minYear=1900;
var maxYear=2100;
function DaysArray(n) {
for (var i = 1; i <= n; i++) {
this[i] = 31
if (i==4 || i==6 || i==9 || i==11) {this[i] = 30}
if (i==2) {this[i] = 29}
}
return this
}
function isDate(dtStr){
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
            
            var mMonths = new Array("", "January", "February", "March", 
                                  "April", "May", "June", "July", 
                                  "August", "September", "October", 
                                  "November", "December");
            
            function BranchPopup(strPopupURL)
            {
                var strWinFeature = "height=280,width=350,resizable=yes,scrollbars=yes,left=420,top=5"
                
                winNew = window.open(strPopupURL, "_blank", strWinFeature)
            }
            
            function CheckDecimalValue(obj)
            {
	            var temp = obj.value
	            var msg = ""
            						
	            if (temp=="")
	            {
		            msg = "Value can not be blank"
	            }
	            else if(isNaN(temp))
	            {
		            msg = "Value should be Numeric"
	            } 					  
	            else if(parseFloat(temp)<0)
	            {
		            msg = "Value should be greater than zero"
	            }
	            else if(temp.indexOf(".")>0 )
	            {
		            msg = "Value should not contain decimal point"
	            }
	            
	            if(msg != "")
	            {
	                alert(msg);
	                obj.focus();
		            return false;
		        }
		        else
		        {
	                obj.value=Math.round(temp)
	                return true;					 				   
	            }
            }
            
            function MyDateDiff(start, end, interval, rounding)
            {
                var iOut = 0;
                
                /*
                // Create 2 error messages, 1 for each argument. 
                var startMsg = "Check the Start Date and End Date\n"
                    startMsg += "must be a valid date format.\n\n"
                    startMsg += "Please try again." ;
            		
                var intervalMsg = "Sorry the dateAdd function only accepts\n"
                    intervalMsg += "d, h, m OR s intervals.\n\n"
                    intervalMsg += "Please try again." ;
                */
                
                var bufferA = Date.parse(start);
                var bufferB = Date.parse(end);
    	
                // check that the start parameter is a valid Date. 
                if (isNaN(bufferA) || isNaN(bufferB))
                {
                    alert( startMsg ) ;
                    return null ;
                }
	
                // check that an interval parameter was not numeric. 
                if ( interval.charAt == 'undefined' ) {
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
            
            function isDate(dateStr)
            {
                var datePat = /^(\d{1,2})(\/|-)(\d{1,2})(\/|-)(\d{4})$/;
                var matchArray = dateStr.match(datePat); // is the format ok?

                if (matchArray == null)
                {
                    alert("Please enter date as either dd/mm/yyyy or mm-dd-yyyy.");
                    return false;
                }

                day = matchArray[1];
                month = matchArray[3]; // parse date into variables
                year = matchArray[5];

                if (month < 1 || month > 12)
                { // check month range
                    alert("Month must be between 1 and 12.");
                    return false;
                }

                if (day < 1 || day > 31)
                {
                    alert("Day must be between 1 and 31.");
                    return false;
                }

                if ((month==4 || month==6 || month==9 || month==11) && day==31)
                {
                    alert("Month " + month + " doesn`t have 31 days!")
                    return false;
                }

                if (month == 2)
                { // check for february 29th
                    var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
                    if (day > 29 || (day==29 && !isleap))
                    {
                        alert("February " + year + " doesn`t have " + day + " days!");
                        return false;
                    }
                }
                return true; // date is valid
            }
            
            function ShowBillDetails()
            {
                var mRadioButtonSelection = "<%=byteRadButtonSelection %>"
                
                //Check for Date Range values
                if(mRadioButtonSelection == 0)
                {
                    //Check for Date From text box value
                    if(document.getElementById("txtDateFrom"))
                    {
                        if(document.getElementById("txtDateFrom").value == "")
                        {
                            alert("Please enter the From Date")
		                    document.getElementById("txtDateFrom").focus();
		                    return false;
                        }
                        else if (!isDate(document.getElementById("txtDateFrom").value))
				        {
                            document.getElementById("txtDateFrom").focus();
                            return false;
				        }
                    }
                    
                    //Check for Date To text box value
                    if(document.getElementById("txtDateTo"))
                    {
                        if(document.getElementById("txtDateTo").value == "")
                        {
                            alert("Please enter the To Date")
		                    document.getElementById("txtDateTo").focus();
		                    return false;
                        }
                        else if (!isDate(document.getElementById("txtDateTo").value))
				        {
				            document.getElementById("txtDateTo").focus();
                            return false;
				        }
                    }
                    
                    //Check for Date Difference between Date From and Date To
                    var dtFrom = document.getElementById("txtDateFrom").value
                    
		            var dayFrom = dtFrom.substring(0,2)
		            var mthFrom = dtFrom.substring(3,5)
		            var yearFrom = dtFrom.substring(6,10)
            			
		            var dtTo = document.getElementById("txtDateTo").value
		            
		            var dayTo = dtTo.substring(0,2)
		            var mthTo = dtTo.substring(3,5)
		            var yearTo = dtTo.substring(6,10)

		            dtFromDerived = new Date(mMonths[parseFloat(mthFrom)] + " " + parseFloat(dayFrom) + ", " + parseFloat(yearFrom) + " ")
		            dtToDerived = new Date(mMonths[parseFloat(mthTo)] + " " + parseFloat(dayTo) + ", " + parseFloat(yearTo) + " ")
		
		            var dtDiffInDays = parseFloat(MyDateDiff(dtFrom, dtTo, 'd' ,0)) + 1
		
		            if (parseInt(dtDiffInDays)>31)
		            {
		                alert("Date Range Should be of 31 days only");
		                document.getElementById("txtDateFrom").focus();
		                return false;
		            }
                }
                return true;
            }
            
        </script>
    
 
 
        <%-- <asp:HyperLink ID="HyperLink1" runat="server">
                <a  href="../../INC_HYR_Top.aspx">
                    Docket Flow Report
                </a>
            </asp:HyperLink>--%>
            <br />   
  <table id="Table1"  runat="server"  cellpadding="3"  cellspacing="1" style="width:5.5in;" >
      <tr><td></td></tr>
      <tr style="background-color: #FFFFFF"><td class="blackfnt" style="height: 12px"><font class="blackboldfnt">Reports</font> > <a href="../../rpt_finance.aspx"><font class="blklnkund">Finace & Accounts </font></a>><font class="bluefnt"> Trail Balance </font></td></tr>  
       <tr> 
          
        </tr>
        </table>
   
<br />          
            
            <table cellspacing="1" style="width: 9.5in; height: 263px;" border="0">
                <tr align="center">
                    <td style="height: 324px" align="center" colspan="3">
                        <table cellspacing="1" style="width: 7.0in" class="boxbg" border="0"> 
                            <tr class="bgbluegrey">
                                <td colspan="4" align="center" style="height: 21px">
                                    <asp:Label ID="lblQry" CssClass="blackfnt" 
                                        Font-Bold="true" runat="server">
                                        Select Branch / Profit Center 

                                    </asp:Label>
                                </td>
                            </tr>
                            
                            <tr  style="font-size: 12pt; font-family: Times New Roman;background-color: white">
                                <td  colspan="2" align="center" style="height: 21px">
                                    <asp:Label ID="Label4" CssClass="blackfnt" 
                                        Font-Bold="true" runat="server">
                                        Select Branch / Profit Center :

                                    </asp:Label>
                                </td>
                                
                                <td align="left" colspan="2" style="width: 395px"><asp:UpdatePanel ID="up3" runat="server">
                                                            <ContentTemplate>
                             
                                     <asp:DropDownList ID="ddlro" runat="server" AutoPostBack="True"  >
                                        <%--<asp:ListItem Text="---Select---" Value=""></asp:ListItem>--%>
                                     </asp:DropDownList><%--<asp:Button ID="btnBranchPopup" runat="server" Text="..." OnClick="BranchPopup(this)" PopupURL="../../mis/popup-cust.asp?13" />--%>
                                     </ContentTemplate>
                                     </asp:UpdatePanel></td>
                            </tr>
                      
                            
                          <tr  id="trradflow" runat="server"  style="font-size: 12pt; font-family: Times New Roman;background-color: white">
                                <td align="center"  colspan="4" valign="top"> <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                            <ContentTemplate>
                                    <asp:RadioButtonList ID="radFlow" runat="server"  CssClass="blackfnt"   AutoPostBack="true"    RepeatDirection="Horizontal">
                                        <asp:ListItem Selected="True"  Text="Individual" Value="0"  ></asp:ListItem>
                                        <asp:ListItem  Text="Cumulative (Transaction includes all branches)" Value="1"></asp:ListItem>
                                    </asp:RadioButtonList>
                                     </ContentTemplate>
                                <Triggers>
                                    
                                                                     
                                </Triggers>
                            </asp:UpdatePanel></td>
                                    
                            </tr>
                          <tr  style="font-size: 12pt; font-family: Times New Roman;background-color: white">
                                <td  colspan="2" align="center" style="height: 21px">
                                    <asp:Label ID="Label1" CssClass="blackfnt" 
                                        Font-Bold="true" runat="server">
                                        Select Option  :

                                    </asp:Label>
                                </td>
                                
                                <td align="left" colspan="2" style="width: 395px">
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                            <ContentTemplate>
                                <asp:RadioButtonList ID="RptOpt" runat="server"  CssClass="blackfnt"   AutoPostBack="true"    RepeatDirection="Vertical">
                                        <asp:ListItem  Text="Opening Balances" Value="0"  ></asp:ListItem>
                                        <asp:ListItem  Text="Closing Balances" Value="1"></asp:ListItem>
                                         <asp:ListItem Selected="True" Text="All" Value="2"></asp:ListItem>
                                    </asp:RadioButtonList>
                                     </ContentTemplate>
                             
                            </asp:UpdatePanel></td>
                            </tr>
                          
                             <tr class="bgbluegrey">
                                <td colspan="4" align="center" style="height: 21px">
                                    <asp:Label ID="Label6" CssClass="blackfnt" 
                                        Font-Bold="true" runat="server">
                                       Select Voucher Date Range 


                                    </asp:Label>
                                </td>
                            </tr>
                            
                            
                            
                    
                             
                              <tr  style="font-size: 12pt; font-family: Times New Roman;background-color: white ; 200px;">
                                                        <td valign="top"     class="blackfnt"  align ="left">
                                                           </td>
                                                        <td   style="font-size: 12pt; font-family: Times New Roman; width: 370px;" align="left" valign="top">
                                                            <asp:UpdatePanel ID="up1" runat="server">
                                                            <ContentTemplate>
                                    <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                        AutoPostBack="true" OnSelectedIndexChanged="radDate_SelectedIndexChanged" >
                                        <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="1" Text=" Last Week "></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="2" Text=" Today:"></asp:ListItem>
                                       <%-- <asp:ListItem Selected="false" Value="3" Text=" Till Date:"></asp:ListItem>--%>
                                    </asp:RadioButtonList>
                                    </ContentTemplate>
                               </asp:UpdatePanel>
                                                        </td>
                                                        
                                                        <td colspan="2"  valign="top" align="left">
                             <asp:UpdatePanel ID="up2" runat="server">
                                                            <ContentTemplate>
                                    <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                    <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="60" MaxLength="10" ></asp:TextBox>
                                    <A href="#"  onClick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor1','dd/MM/yyyy'); return false;"
			   NAME="anchor1"  id="anchor1"><img src="../../../images/calendar.jpg" border="0"></img>
			</A>
                                    <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                    <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="60" MaxLength="10" ></asp:TextBox>
                                    <A href="#"  onClick="cal.select(ctl00$MyCPH1$txtDateTo,'anchor2','dd/MM/yyyy'); return false;"
			   NAME="anchor2"  id="a1"><img src="../../../images/calendar.jpg" border="0"></img>
			</A>
                                    
                                </ContentTemplate>
                                <Triggers>
                                    
                                    
                                    
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                                                    </tr>
                           
                            
                            
                            <%--<asp:RadioButton ID="RadLocWise" runat="server" GroupName="RadGroup" Text="Location Wise" OnCheckedChanged="RadLocWise_CheckedChanged" AutoPostBack="True" />
                                    <asp:RadioButton ID="RadCustWise" runat="server" GroupName="RadGroup" Text="Customer Wise" OnCheckedChanged="RadCustWise_CheckedChanged" AutoPostBack="True" />--%>
<%-- <tr class="bgbluegrey">
                                <td colspan="4" align="center" style="height: 21px">
                                    <asp:Label ID="Label2" CssClass="blackfnt" 
                                        Font-Bold="true" runat="server">
                                       Select Accounts


                                    </asp:Label>
                                </td>
                            </tr>--%>
                            
                
                   <%-- <tr style="background-color: white">
                                
                                
                                
                                <td align="center" colspan="4"  valign="top" style="height: 25px; width: 395px;">
                                   <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                            <ContentTemplate>
                                                             <asp:DropDownList ID="DDAccounts" runat="server" AutoPostBack="True"  >
                                        <asp:ListItem Text="All" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="All Bank Accounts" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="All Cash Accounts" Value="2"></asp:ListItem>
                                     </asp:DropDownList> </ContentTemplate>
                                     </asp:UpdatePanel><%--<asp:Button ID="btnBilledAt" runat="server" Text="..." onclick="BranchPopup(this)" PopupURL="../popup-branch.asp?7,A,A" />
                                </td>
                                
                            </tr>--%>
                
                
                <tr style="background-color: white">
                    <td colspan="4" align="center" style="height: 32px">
                        <asp:Button ID="btnShow" runat="server" Text="Show" Width="75px" OnClick="btnShow_Click1"  />
                        
                    </td>
                </tr>
                
                     
                
                
                <%--<tr style="background-color: white">
                    <td colspan="4" align="center" style="height: 32px">
                        <asp:Button ID="btnShow" runat="server" Text="Show" Width="75px" OnClick="btnShow_Click1" />
                        
                         
                        
                        
                    </td>
                </tr>--%>
                 </table>
                 
                 <DIV ID="testdiv1" STYLE="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;z-index:99;"></DIV>
</asp:Content>

