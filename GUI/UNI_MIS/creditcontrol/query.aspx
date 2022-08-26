<%@ Page Language="C#"  MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="query.aspx.cs" Inherits="_Default"  EnableEventValidation="false"%>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="JavaScript" SRC="./../../Images/CalendarPopup.js"></script> 
<script language="javascript" src="./../../images/commonJs.js"></script>
<script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
</script>

<script language="javascript" type="text/javascript">

    function btnShowVal()
{


var txtfrom=document.getElementById("ctl00$MyCPH1$txtDateFrom");
var txtto=document.getElementById("ctl00$MyCPH1$txtDateFrom");
var Report_type=document.getElementById("ctl00$MyCPH1$Report_type");
var abc=document.getElementById("ctl00_MyCPH1_radFlow_0");
if(abc.checked==true)
{
    if(Report_type.value=="")
    {

    alert("Please select one type ")
    Report_type.focus();
    return false;
    }
}

if(!isValidDate(txtfrom.value,"From"))
    return false;
    
    if(!isValidDate(txtto.value,"To"))
    return false;


}
 </script>
            <script language="javascript" type="text/javascript">
            
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
            
            <table width="80%" border="0" align="left" cellpadding="0" cellspacing="0">
    	<tr> 
          <td height="30"><font class="blklnkund"><strong> Module</strong></font>
          
		<strong> &gt; </strong><font class="blklnkund"><strong>Administrator </strong></font>

<strong> &gt; </strong> <font class="blklnkund"><strong>Reports</strong></font>



<font class=bluefnt><strong> &gt; </strong>
		  <strong>Finance & Accounts</strong> </font></td>
        </tr>
        <tr> 
          <td class="horzblue"><img src="../../images/clear.gif" width="2" height="1"></td>
        </tr>
        <tr> 
          <td><img src="../../images/clear.gif" width="15" height="10"/></td>
        </tr>

   
        
        <tr> 
          <td align=right><img src="./../../images/back.gif" border=0/></td>
        </tr>
                    <tr> 
                      <td height="300" valign="top">
					  <!--START--> 
            
            <table cellspacing="1" style="width: 9.0in%; height: 263px;" border="0">
                <tr align="center">
                    <td style="height: 324px" align="center" colspan="3">
                        <table cellspacing="1" style="width: 90%" class="boxbg" border="0"> 
                            <tr class="bgbluegrey">
                                <td colspan="4" align="center" style="height: 21px">
                                    <asp:Label ID="lblQry" CssClass="blackfnt" 
                                        Font-Bold="true" runat="server">
                                        Search Criteria
                                    </asp:Label>
                                </td>
                            </tr>
                            
                            
                            
                    
                             
                              <tr  style="font-size: 12pt; font-family: Times New Roman;background-color: white"">
                                                        <td valign="top"  Class="blackfnt"  align ="left">
                                                            Select  Date</td>
                                                        <td    style="font-size: 12pt;width 300px;font-family: Times New Roman" align="left" valign="top">
                                                            <asp:UpdatePanel  ID="up1" runat="server">
                                                            <ContentTemplate>
                                    <asp:RadioButtonList ID="radDate"  runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                        AutoPostBack="true"   OnSelectedIndexChanged="radDate_SelectedIndexChanged" >
                                        <asp:ListItem Selected="True" Value="0"  Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="1" Text=" Last Week "></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="2" Text=" Today:"></asp:ListItem>
                                       <%-- <asp:ListItem Selected="false" Value="3" Text=" Till Date:"></asp:ListItem>--%>
                                    </asp:RadioButtonList>  
                                    </ContentTemplate>
                               </asp:UpdatePanel>
                                                        </td>
                                                        
                                                        <td colspan="2" valign="top"  align="left">
                             <asp:UpdatePanel ID="up2" runat="server">
                                                            <ContentTemplate>
                                    <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                    <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                     <A href="#"  onClick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor1','dd/MM/yyyy'); return false;"
			   NAME="anchor1"  id="anchor1"><img src="./../../images/calendar.jpg" border="0"></img>
			</A>
                                    <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                    <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                    <A href="#"  onClick="cal.select(ctl00$MyCPH1$txtDateTo,'anchor2','dd/MM/yyyy'); return false;"
			   NAME="anchor2"  id="a1"><img src="./../../images/calendar.jpg" border="0"></img>
			</A><br />
                                    <br />
                                    <br />
                                    <br />
                                </ContentTemplate>
                                <Triggers>
                                    
                                    
                                    
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                                                    </tr>
                           <tr  style="font-size: 12pt; font-family: Times New Roman;background-color: white">
                                <td align="center" colspan="4" valign="top"> <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                            <ContentTemplate>
                                    <asp:RadioButtonList ID="radFlow" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"  AutoPostBack="true"  OnSelectedIndexChanged="radFlow_SelectedIndexChanged"  RepeatDirection="Horizontal">
                                        <asp:ListItem Selected="True" Text="Location Wise" Value="0"  ></asp:ListItem>
                                        <asp:ListItem Text="Customer Wise" Value="1"></asp:ListItem>
                                    </asp:RadioButtonList>
                                     </ContentTemplate>
                                <Triggers>
                                    
                                                                     
                                </Triggers>
                            </asp:UpdatePanel></td>
                                    
                            </tr>
                            
                            
                            <%--<asp:RadioButton ID="RadLocWise" runat="server" GroupName="RadGroup" Text="Location Wise" OnCheckedChanged="RadLocWise_CheckedChanged" AutoPostBack="True" />
                                    <asp:RadioButton ID="RadCustWise" runat="server" GroupName="RadGroup" Text="Customer Wise" OnCheckedChanged="RadCustWise_CheckedChanged" AutoPostBack="True" />--%>

                            <tr style="background-color: white">
                                <td align="left" style=" height: 25px;"  >
                            
                                    <asp:Label ID="lbl"  CssClass="blackfnt" Text="Select RO" runat="server" Width="102px"></asp:Label>    
                                </td>
                                
                                <td align="left"  valign="top" style="width:300px;height: 25px">
                                 
                                    
                                    <asp:UpdatePanel ID="up3" runat="server">
                                                            <ContentTemplate>
                             
                                     <asp:DropDownList ID="ddlro" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlro_SelectedIndexChanged">
                                        <asp:ListItem Text="-All-" Value="All"></asp:ListItem>
                                     </asp:DropDownList><%--<asp:Button ID="btnBranchPopup" runat="server" Text="..." OnClick="BranchPopup(this)" PopupURL="../../mis/popup-cust.asp?13" />--%>
                                     </ContentTemplate>
                                     </asp:UpdatePanel>
                                      </td>
                                <td align="left"  style=" height: 25px" valign="top">
                              
                                    <asp:Label ID="Label3"  CssClass="blackfnt" Text="Enter Customer Code :" runat="server" Width="164px"></asp:Label>
                                </td>
                                
                                <td align="left"  valign="top" style="height: 25px;">
                                   <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                            <ContentTemplate> <asp:TextBox disabled ID="txtPartyCode" runat="server" CssClass="input" MaxLength="15">
                                    </asp:TextBox>
                                    <input  id="btnBranchPopup" runat="server" onclick="BranchPopup('.././POPUPS/BillingParty_Popup.aspx?13')"
                                        type="button"  value="..." /></ContentTemplate>
                                     </asp:UpdatePanel><%--<asp:Button ID="btnBilledAt" runat="server" Text="..." onclick="BranchPopup(this)" PopupURL="../popup-branch.asp?7,A,A" />--%>
                                
                            </tr>
                               
                                </td>
                                     
                            </tr>
                    
                            <tr style="background-color: white">
                                <td align="left" style="height: 24px;">
                                    <asp:Label ID="Label1"  CssClass="blackfnt" Text="Select Location" runat="server" Width="113px"></asp:Label>
                                </td>
                                
                                <td align="left"  valign="top" style="height: 24px;">
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                            <ContentTemplate>
                                     <asp:DropDownList ID="ddlloc" runat="server" OnSelectedIndexChanged="ddlloc_SelectedIndexChanged">
                                        <asp:ListItem Value="All" Text="-All-"></asp:ListItem>
                                    </asp:DropDownList>
                                     </ContentTemplate>
                                     </asp:UpdatePanel>
                                </td>
                                <td align="left"   >
                        <asp:Label ID="Label2"  CssClass="blackfnt" Text="Select Paybas" runat="server" Width="102px"></asp:Label>
                            
                        </td>
                        <td align="left" valign="top" style="width: 231px">
                            <asp:UpdatePanel EnableViewState= ID="UpdatePanel4" runat="server">
                                                            <ContentTemplate> <asp:DropDownList ID="DDLPaybas" runat="server">
                            <asp:ListItem Value="All" Text="All"></asp:ListItem>
                            </asp:DropDownList> </ContentTemplate>
                                     </asp:UpdatePanel></td>
                            </tr>
                            
                              <tr style="background-color: white">
                                
                                <td align="left"  >
                        <asp:Label ID="Label5"  CssClass="blackfnt" Text="Select Paybas" runat="server" Width="102px"></asp:Label>
                            
                        </td>
                        <td  colspan="3" align="left" valign="top" >
                              <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                                            <ContentTemplate>  <asp:DropDownList ID="DDLPaybas2" runat="server">
                            <asp:ListItem Value="All" Text="All"></asp:ListItem>
                            </asp:DropDownList> </ContentTemplate>
                                     </asp:UpdatePanel></td>
                            
                            </tr>
                       <tr style="background-color: white">
                                
                                <td align="left"   >
                        <asp:Label ID="Label4"  CssClass="blackfnt" Text="Show OutStanding At this Location" runat="server" Width="232px"></asp:Label>
                            
                        </td>
                        <td  colspan="3" align="left" valign="top" >
                               <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                                            <ContentTemplate> <asp:DropDownList ID="Report_type" runat="server">
                            <asp:ListItem Value="" Text="--Select One--"></asp:ListItem>
                            <asp:ListItem Value="1" Text="To be collected"></asp:ListItem>
                            <asp:ListItem Value="2" Text="Generated"></asp:ListItem>
                            </asp:DropDownList></ContentTemplate>
                                     </asp:UpdatePanel></td>
                            
                            </tr>
                        
                
                <tr style="background-color: white">
                    <td colspan="4" align="center" style="height: 32px">
                        <asp:Button ID="btnShow" runat="server" Text="Show" Width="75px" OnClick="btnShow_Click1" />
                        
                         
                        
                        
                    </td>
                </tr>
                 </table>
           
            
    </td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td></td>
                    </tr>
                  </table>

        
        <DIV ID="testdiv1" STYLE="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;z-index:99;"></DIV> 
  </asp:Content>
