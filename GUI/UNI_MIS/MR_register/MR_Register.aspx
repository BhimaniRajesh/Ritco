<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="MR_Register.aspx.cs" Inherits="MR_Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" src="./../../Images/CalendarPopup.js"></script>

    <script language="javascript" src="./../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
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
            
            function ShowMRdetails()
            {
                var mRadioButtonSelection = "<%=byteRadButtonSelection %>"
                
                //Check for Date Range values
                if(mRadioButtonSelection == 0)
                {
                    //Check for Date From text box value
                    if(document.getElementById("ctl00_MyCPH1_txtDateFrom"))
                    {
                        if(document.getElementById("ctl00_MyCPH1_txtDateFrom").value == "")
                        {
                            alert("Please enter the From Date")
		                    document.getElementById("ctl00_MyCPH1_txtDateFrom").focus();
		                    return false;
                        }
                        else if (!isDate(document.getElementById("ctl00_MyCPH1_txtDateFrom").value))
				        {
                            document.getElementById("ctl00_MyCPH1_txtDateFrom").focus();
                            return false;
				        }
                    }
                    
                    //Check for Date To text box value
                    if(document.getElementById("ctl00_MyCPH1_txtDateTo"))
                    {
                        if(document.getElementById("ctl00_MyCPH1_txtDateTo").value == "")
                        {
                            alert("Please enter the To Date")
		                    document.getElementById("ctl00_MyCPH1_txtDateTo").focus();
		                    return false;
                        }
                        else if (!isDate(document.getElementById("ctl00_MyCPH1_txtDateTo").value))
				        {
				            document.getElementById("ctl00_MyCPH1_txtDateTo").focus();
                            return false;
				        }
                    }
                    
                    //Check for Date Difference between Date From and Date To
                    var dtFrom = document.getElementById("ctl00_MyCPH1_txtDateFrom").value
                    
		            var dayFrom = dtFrom.substring(0,2)
		            var mthFrom = dtFrom.substring(3,5)
		            var yearFrom = dtFrom.substring(6,10)
            			
		            var dtTo = document.getElementById("ctl00_MyCPH1_txtDateTo").value
		            
		            var dayTo = dtTo.substring(0,2)
		            var mthTo = dtTo.substring(3,5)
		            var yearTo = dtTo.substring(6,10)

		            dtFromDerived = new Date(mMonths[parseFloat(mthFrom)] + " " + parseFloat(dayFrom) + ", " + parseFloat(yearFrom) + " ")
		            dtToDerived = new Date(mMonths[parseFloat(mthTo)] + " " + parseFloat(dayTo) + ", " + parseFloat(yearTo) + " ")
		
		            var dtDiffInDays = parseFloat(MyDateDiff(dtFrom, dtTo, 'd' ,0)) + 1
		
		           
                }
                return true;
            }
            
            
            
    </script>

    <table style="width: 1100px">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Finance.aspx"><font class="blklnkund">
                        <b>Finance</b></font></a> <b>&gt; </b><font class="bluefnt"><b>MR Regester Report</b></font>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <div align="left" style="width: 9.5in;">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <table cellspacing="1" style="width: 100%; height: 263px;" border="0">
                    <tr align="center">
                        <td style="height: 324px" align="center" colspan="3">
                            <table cellspacing="1" style="width: 90%" class="boxbg" border="0">
                                <tr class="bgbluegrey">
                                    <td colspan="3" align="center" style="height: 21px">
                                        <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">
                                        Search Criteria
                                        </asp:Label>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                    <td valign="top" align="left" style="width: 25%">
                                        <asp:Label ID="Label6" CssClass="blackfnt" Text="Select MR" runat="server"></asp:Label><asp:DropDownList
                                            ID="ddldttype" runat="server">
                                            <asp:ListItem Text="Generation Date" Value="mrsdt"></asp:ListItem>
                                            <asp:ListItem Text="Closing Date" Value="finclosedt"></asp:ListItem>
                                        </asp:DropDownList></td>
                                    <td align="left" style="width: 30%" valign="top">
                                        <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                            AutoPostBack="true" OnSelectedIndexChanged="radDate_SelectedIndexChanged" RepeatColumns="1"
                                            Width="244px">
                                            <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                            <asp:ListItem Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                            <asp:ListItem Value="2" Text=" Today:"></asp:ListItem>
                                        </asp:RadioButtonList></td>
                                    <td valign="top" align="left" style="width: 359px">
                                        <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                        <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="80">
                                        </asp:TextBox>
                                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor1','dd/MM/yyyy'); return false;"
                                            name="anchor1" id="anchor1">
                                            <img src="./../../images/calendar.jpg" border="0"></img>
                                        </a>
                                        <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                        <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateTo,'anchor2','dd/MM/yyyy'); return false;"
                                            name="anchor2" id="a1">
                                            <img src="./../../images/calendar.jpg" border="0"></img>
                                        </a>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDateFrom"
                                            ErrorMessage="Date From Can Not Be Blank"></asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDateTo"
                                            ErrorMessage="Date To Can Not Be Blank"></asp:RequiredFieldValidator><br />
                                        <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Date Range Must Be 1 month Only"
                                            OnServerValidate="daterange"></asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left" style="height: 25px; width: 100px;">
                                        <asp:Label ID="lbl" CssClass="blackfnt" Text="Select RO" runat="server" Width="102px"></asp:Label>
                                    </td>
                                    <td align="left" colspan="2" valign="top" style="height: 25px">
                                        <asp:UpdatePanel ID="up3" runat="server">
                                            <ContentTemplate>
                                                <%--<asp:Button ID="btnBranchPopup" runat="server" Text="..." OnClick="BranchPopup(this)" PopupURL="../../mis/popup-cust.asp?13" />--%>
                                                <asp:DropDownList ID="ddlro" runat="server" OnSelectedIndexChanged="ddlro_SelectedIndexChanged"
                                                    AutoPostBack="True">
                                                </asp:DropDownList>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left" style="height: 24px; width: 100px;">
                                        <asp:Label ID="Label1" CssClass="blackfnt" Text="Select Location" runat="server"
                                            Width="113px"></asp:Label>
                                    </td>
                                    <td align="left" colspan="2" valign="top" style="height: 24px;">
                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                            <ContentTemplate>
                                                &nbsp;<asp:DropDownList ID="ddlloc" runat="server" AutoPostBack="True">
                                                </asp:DropDownList>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left" style="height: 24px; width: 100px;">
                                        <asp:Label ID="Label3" CssClass="blackfnt" Text="MR Party" runat="server" Width="164px"></asp:Label>
                                    </td>
                                    <td align="left" colspan="2" valign="top" style="height: 24px;">
                                        <asp:TextBox ID="txtPartyCode" runat="server" CssClass="input" MaxLength="15">
                                        </asp:TextBox>
                                        <input id="btnBranchPopup" runat="server" onclick="BranchPopup('./BillingParty_Popup.aspx?13')"
                                            type="button" value="..." /><%--<asp:Button ID="btnBilledAt" runat="server" Text="..." onclick="BranchPopup(this)" PopupURL="../popup-branch.asp?7,A,A" />--%>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left" style="width: 100px; height: 24px">
                                        <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Text="MR Type" Width="173px"></asp:Label>
                                    </td>
                                    <td align="left" colspan="2" valign="top" style="height: 24px;">
                                        <asp:DropDownList ID="ddlmrtype" runat="server">
                                            <asp:ListItem Text="-All-" Value="All"></asp:ListItem>
                                            <asp:ListItem Text="Paid" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="TBB" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="To Pay" Value="3"></asp:ListItem>
                                            <asp:ListItem Text="Misc." Value="6"></asp:ListItem>
                                            <asp:ListItem Text="Cancelled" Value="5"></asp:ListItem>
                                            <asp:ListItem Text="Octroi" Value="4"></asp:ListItem>
                                            <asp:ListItem Text="Supplimentry" Value="7"></asp:ListItem>
                                        </asp:DropDownList><%--<asp:Button ID="btnSubmittedAt" runat="server" Text="..." onclick="BranchPopup(this)" PopupURL="../popup-branch.asp?8,A,A" />--%></td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left" style="width: 100px; height: 24px">
                                        <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Text="Status :" Width="173px"></asp:Label>
                                    </td>
                                    <td align="left" colspan="2" valign="top" style="height: 24px;">
                                        <asp:DropDownList ID="ddlstatus" runat="server" EnableTheming="True">
                                            <asp:ListItem Text="-All-" Value="All"></asp:ListItem>
                                            <asp:ListItem Value="N">MR - Generated</asp:ListItem>
                                            <asp:ListItem Value="Y">MR - Closed</asp:ListItem>
                                            <asp:ListItem Value="X">MR - Not Closed</asp:ListItem>
                                            <asp:ListItem Value="C">Cancelled - MR</asp:ListItem>
                                        </asp:DropDownList><%--<asp:Button ID="btnCollectionAt" runat="server" Text="..." onclick="BranchPopup(this)" PopupURL="../popup-branch.asp?2,A,A" />--%></td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left" style="width: 100px; height: 24px">
                                        <asp:Label ID="Label8" runat="server" CssClass="blackfnt" Text="MR List Type :" Width="173px"></asp:Label>
                                    </td>
                                    <td align="left" colspan="2" valign="top" style="height: 24px;">
                                        <asp:DropDownList ID="ddlmrlittype" runat="server" EnableTheming="True">
                                            <asp:ListItem Text="-All-" Value="All"></asp:ListItem>
                                            <asp:ListItem Value="1">With SVCTAX+Cess</asp:ListItem>
                                            <asp:ListItem Value="2">MR - Closed</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left" style="width: 100px; height: 24px">
                                        <asp:Label ID="Label7" runat="server" CssClass="blackfnt" Text="Cash / Cheque :"
                                            Width="173px"></asp:Label>
                                    </td>
                                    <td align="left" colspan="2" valign="top" style="height: 24px;">
                                        <asp:DropDownList ID="ddlcash" runat="server">
                                            <asp:ListItem Text="-All-" Value="All"></asp:ListItem>
                                            <asp:ListItem Value="cash">Close By Cash</asp:ListItem>
                                            <asp:ListItem Value="Cheque">Close By Cheque</asp:ListItem>
                                        </asp:DropDownList><%--<asp:TextBox id="txtOverDueDays" CssClass="input" MaxLength="3" Text="0" runat="server">
                                    </asp:TextBox>--%></td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left" style="width: 100px; height: 24px">
                                        <asp:Label ID="Label5" runat="server" CssClass="blackfnt" Text="Amount GraterThen :"
                                            Width="173px"></asp:Label>
                                    </td>
                                    <td align="left" colspan="2" valign="top" style="height: 24px;">
                                        <asp:TextBox ID="txtamtgrt" runat="server" Width="60" CssClass="input" MaxLength="3"></asp:TextBox><%--<asp:TextBox id="txtOverDueDays" CssClass="input" MaxLength="3" Text="0" runat="server">
                                    </asp:TextBox>--%></td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left" style="width: 100px; height: 24px">
                                        <asp:Label ID="Label9" runat="server" CssClass="blackfnt" Text="Enter MR No. :" Width="173px"></asp:Label>
                                    </td>
                                    <td align="left" colspan="2" valign="top" style="height: 24px;">
                                        <asp:TextBox ID="txtmrno" runat="server" Width="300" CssClass="input"></asp:TextBox>
                                        <asp:Label ID="Label10" runat="server" CssClass="blackfnt" Text="[seperated by comma if multiple] "></asp:Label>
                                        <%--<asp:TextBox id="txtOverDueDays" CssClass="input" MaxLength="3" Text="0" runat="server">
                                        
                                    </asp:TextBox>--%>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left" style="width: 100px; height: 24px">
                                        <asp:Label ID="Label11" runat="server" CssClass="blackfnt" Text="Enter Docket No. :"
                                            Width="173px"></asp:Label>
                                    </td>
                                    <td align="left" colspan="2" valign="top" style="height: 24px;">
                                        <asp:TextBox ID="txtdock" runat="server" Width="300" CssClass="input"></asp:TextBox>
                                        <asp:Label ID="Label12" runat="server" CssClass="blackfnt" Text="[seperated by comma if multiple] "></asp:Label>
                                        <%--<asp:TextBox id="txtOverDueDays" CssClass="input" MaxLength="3" Text="0" runat="server">
                                        
                                    </asp:TextBox>--%>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td colspan="3" align="center" style="height: 32px">
                            <asp:Button ID="btnShow" runat="server" Text="Show" Width="75px" OnClientClick="return ShowMRdetails()"
                                OnClick="btnShow_Click1" />
                            <%--<input type="button" id="btnShow" runat="server" onclick="return ShowBillDetails()" value="Show" style="width: 75px" />--%>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <%--<table cellspacing="1" style="width: 100%">
                <tr align="center">
                    <td align="center">
                        <asp:UpdatePanel ID="u1"  UpdateMode="Conditional" runat="server">
                            <ContentTemplate>
                                <asp:DataGrid ID="dgSales" runat="server" CellPadding="4" 
                                    Gridlines="None" HorizontalAlign="Center" 
                                    OnPageIndexChanged="pgChange" CssClass="bgbluegrey" 
                                    AllowPaging="True" AllowSorting="True" 
                                    HeaderStyle-CssClass="boxborder" 
                                    ItemStyle-CssClass="blackfnt" 
                                    PagerStyle-Mode="NumericPages" 
                                    PagerStyle-NextPageText="[Next]" 
                                    PagerStyle-PrevPageText="[Prev]" 
                                    Font-Bold="False" Font-Italic="False" 
                                    Font-Names="Verdana" Font-Overline="False" 
                                    Font-Size="Smaller" Font-Strikeout="False" 
                                    Font-Underline="False" ForeColor="#333333" 
                                    ShowFooter="True">
                                    
                                    <Columns> 
                                        <asp:TemplateColumn HeaderText="Sr No."> 
                                            <ItemTemplate>
                                                <span>
                                                    <asp:Label ID="lblsrnocomplainlist" 
                                                        text="<%#Container.DataSetIndex+1 %>" 
                                                        runat="server">
                                                    </asp:Label>
                                                </span>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                    </Columns>
                                    
                                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                    
                                    <EditItemStyle BackColor="#2461BF" />
                                    
                                    <SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                    
                                    <PagerStyle BackColor="#2461BF" ForeColor="White" 
                                        HorizontalAlign="Center" NextPageText="[Next]" 
                                        Position="TopAndBottom" PrevPageText="[Prev]" />
                                    
                                    <AlternatingItemStyle BackColor="White" />
                                    
                                    <ItemStyle BackColor="#EFF3FB" CssClass="blackfnt" />
                                    
                                    <HeaderStyle BackColor="#507CD1" CssClass="boxborder" 
                                        Font-Bold="True" ForeColor="White" />
                                </asp:DataGrid>
                            </ContentTemplate>
                            
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnShow" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </td>
                </tr>
            </table>--%>
        <%--<asp:Button id="Button1" runat="server" Text="Export to excel"></asp:Button>&nbsp;
			<asp:Button id="Button2" runat="server" Text="Export to CSV"></asp:Button>--%>
        <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
            layer-background-color: white; z-index: 99;">
        </div>
    </div>
</asp:Content>
