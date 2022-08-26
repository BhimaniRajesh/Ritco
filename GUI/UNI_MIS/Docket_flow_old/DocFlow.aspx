<%@ Page Language="C#"  MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="DocFlow.aspx.cs" Inherits="_Default"  EnableEventValidation="false"%>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">


    <title>Docket Flow Report</title>
    
    
    
     <link id="Link1" href="~/images/style.css" rel="Stylesheet" 
            type="text/css" runat="server" />
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
    
 
 
         <asp:HyperLink ID="HyperLink1" runat="server">
                <a  href="../../INC_HYR_Top.aspx">
                    Docket Flow Report
                </a>
            </asp:HyperLink>
            
            
            
            <table cellspacing="1" style="width: 100%; height: 263px;" border="0">
                <tr align="center">
                    <td style="height: 324px" align="center" colspan="3">
                        <table cellspacing="1" style="width: 90%" class="boxbg" border="0"> 
                            <tr class="bgbluegrey">
                                <td colspan="3" align="center" style="height: 21px">
                                    <asp:Label ID="lblQry" CssClass="blackfnt" 
                                        Font-Bold="true" runat="server">
                                        Search Criteria
                                    </asp:Label>
                                </td>
                            </tr>
                            
                            
                            <tr style="background-color: white">
                                <td align="left" style="width: 100px; height: 25px;"  >
                            
                                    <asp:Label ID="lbl"  CssClass="blackfnt" Text="Select RO" runat="server" Width="102px"></asp:Label>    
                                </td>
                                
                                <td align="left" colspan="2" valign="top" style="height: 25px">
                                    &nbsp;
                                    
                                    <asp:UpdatePanel ID="up3" runat="server">
                                                            <ContentTemplate>
                             
                                     <asp:DropDownList ID="ddlro" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlro_SelectedIndexChanged">
                                        <asp:ListItem Text="-All-" Value="All"></asp:ListItem>
                                     </asp:DropDownList><%--<asp:Button ID="btnBranchPopup" runat="server" Text="..." OnClick="BranchPopup(this)" PopupURL="../../mis/popup-cust.asp?13" />--%>
                                     </ContentTemplate>
                                     </asp:UpdatePanel>
                                      </td>
                                     
                            </tr>
                    
                            <tr style="background-color: white">
                                <td align="left" style="height: 24px; width: 100px;">
                                    <asp:Label ID="Label1"  CssClass="blackfnt" Text="Select Location" runat="server" Width="113px"></asp:Label>
                                </td>
                                
                                <td align="left" colspan="2" valign="top" style="height: 24px;">
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                            <ContentTemplate>
                                     <asp:DropDownList ID="ddlloc" runat="server" OnSelectedIndexChanged="ddlloc_SelectedIndexChanged">
                                        <asp:ListItem Value="All" Text="-All-"></asp:ListItem>
                                    </asp:DropDownList>
                                     </ContentTemplate>
                                     </asp:UpdatePanel>
                                </td>
                            </tr>
                    
                             <tr style="background-color: white">
                                <td align="left" style="height: 24px; width: 100px;">
                                    <asp:Label ID="Label3"  CssClass="blackfnt" Text="Enter Customer Code :" runat="server" Width="164px"></asp:Label>
                                </td>
                                
                                <td align="left" colspan="2" valign="top" style="height: 24px;">
                                    &nbsp;<asp:TextBox ID="txtPartyCode" runat="server" CssClass="input" MaxLength="15">
                                    </asp:TextBox>
                                    <input id="btnBranchPopup" runat="server" onclick="BranchPopup('.././POPUPS/BillingParty_Popup.aspx?13')"
                                        type="button" value="..." /><%--<asp:Button ID="btnBilledAt" runat="server" Text="..." onclick="BranchPopup(this)" PopupURL="../popup-branch.asp?7,A,A" />--%>
                                </td>
                            </tr>
                              <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                                        <td valign="top" align ="left">
                                                            Select<asp:DropDownList ID="ddlbookdt" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                                                                <asp:ListItem Value="dockdt">Booking</asp:ListItem>
                                                                <asp:ListItem Value="dely_dt">Delivery</asp:ListItem>
                                                            </asp:DropDownList>
                                                            Date</td>
                                                        <td style="font-size: 12pt; font-family: Times New Roman" align="left" valign="top">
                                                            <asp:UpdatePanel ID="up1" runat="server">
                                                            <ContentTemplate>
                                    <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                        AutoPostBack="true" OnSelectedIndexChanged="radDate_SelectedIndexChanged" >
                                        <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="2" Text=" Today:"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="3" Text=" Till Date:"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    </ContentTemplate>
                               </asp:UpdatePanel>
                                                        </td>
                                                        
                                                        <td valign="top" align="left">
                             <asp:UpdatePanel ID="up2" runat="server">
                                                            <ContentTemplate>
                                    <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                    <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                    <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                    <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>&nbsp;<br />
                                    <br />
                                    <br />
                                    <br />
                                </ContentTemplate>
                                <Triggers>
                                    
                                    
                                    
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                                                    </tr>
                            <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                <td align="center" colspan="3" valign="top">
                                    <asp:RadioButtonList ID="radFlow" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt" OnSelectedIndexChanged="radDate_SelectedIndexChanged" RepeatDirection="Horizontal">
                                        <asp:ListItem Selected="True" Text="Docket Booking Flow" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Docket Delivry Flow" Value="1"></asp:ListItem>
                                    </asp:RadioButtonList></td>
                            </tr>

                            
                        </table>
                    </td>
                </tr>                    
                
                <tr style="background-color: white">
                    <td colspan="3" align="center" style="height: 32px">
                        <asp:Button ID="btnShow" runat="server" Text="Show" Width="75px" OnClick="btnShow_Click1" />
                        
                         
                        
                        
                    </td>
                </tr>
                
            </table>
            
    

        
        
  </asp:Content>
