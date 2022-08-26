<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="OutStand.aspx.cs" Inherits="OutStanding_OutStand" %>

 
 <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

 <script language="javascript" type="text/javascript" src="../../CAL/popcalendar.js"></script>


    
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
            
           
            
        </script>

       <table cellspacing="1" style="width: 11.5in;" align="left"   border="0">

    <tr>
    <td  align="left">  
        <a><font class="blklnkund"><b>Module</b></font></a>
							<b> &gt; </b>
							<a><font class="blklnkund"><b>Reports</b></font></a>
							<b> &gt; </b>
							<a href="../rpt_finance.aspx"><font class="blklnkund"><b>Finance</b></font></a>
							<b> &gt; </b>
							<font class="bluefnt"><b>  Customer Outstanding Report </b></font>
	</td>
	<td align="right">
	    <a href="javascript:window.history.go(-1)"  title="back"><img src="../../images/back.gif" border="0" alt="" /></a>
	</td>
    </tr>
    </table>
            
            <br /><br /><br /><br />
            
           <table cellspacing="1" style="width:9.5in;" align="left"   border="0">
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
                                <td align="left" style="width: 100px; height: 22px">
                                    <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Text="Bill Type" Width="113px"></asp:Label></td>
                                <td align="left" colspan="2" style="height: 22px" valign="top">
                                    <asp:DropDownList ID="ddlbilltype" runat="server">
                                        <asp:ListItem>-- All --</asp:ListItem>
                                        <asp:ListItem Value="2">Freight Bill</asp:ListItem>
                                        <asp:ListItem Value="6">Octroi Bill</asp:ListItem>
                                    </asp:DropDownList></td>
                            </tr>
                    
                             <tr style="background-color: white">
                                <td align="left" style="height: 24px; width: 100px;">
                                    <asp:Label ID="Label3"  CssClass="blackfnt" Text="Billing party" runat="server" Width="164px"></asp:Label>
                                </td>
                                
                                <td align="left" colspan="2" valign="top" style="height: 24px;">
                                   <asp:TextBox ID="txtPartyCode" runat="server" CssClass="input" MaxLength="15">
                                    </asp:TextBox>
                                    <input id="btnBranchPopup" runat="server" onclick="BranchPopup('.././POPUPS/BillingParty_Popup.aspx?13')"
                                        type="button" value="..." /><%--<asp:Button ID="btnBilledAt" runat="server" Text="..." onclick="BranchPopup(this)" PopupURL="../popup-branch.asp?7,A,A" />--%>
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td align="left" style="width: 100px; height: 10px">
                                    <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Text="Age Of O/S" Width="113px"></asp:Label></td>
                                <td align="left" colspan="2" style="height: 10px" valign="top">
                                    <asp:DropDownList ID="ddlageos" runat="server">
                                        <asp:ListItem>-- All --</asp:ListItem>
                                        <asp:ListItem Value="0">0 - 30 Days</asp:ListItem>
                                        <asp:ListItem Value="30">31 - 60 Days</asp:ListItem>
                                        <asp:ListItem Value="60">61 - 90 Days</asp:ListItem>
                                        <asp:ListItem Value="90">91 - 180 Days</asp:ListItem>
                                        <asp:ListItem Value="180">&gt; 180 Days</asp:ListItem>
                                        <asp:ListItem Value="U">Undue Bills</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RadioButtonList ID="rddttype" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt" OnSelectedIndexChanged="rddttype_SelectedIndexChanged" RepeatDirection="Horizontal" style="left: 100px; position: relative; top: -20px">
                                        <asp:ListItem Selected="True" Text="Generation Date" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Submission Date" Value="1"></asp:ListItem>
                                        <asp:ListItem Value="2">Due Date</asp:ListItem>
                                    </asp:RadioButtonList></td>
                            </tr>
                              <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                                        <td valign="top" align ="left">
                                                         <asp:Label ID="Label5" runat="server" CssClass="blackfnt" Text="Select Date" Width="113px"></asp:Label></td>
                                                            
                                                        <td style="font-size: 12pt; font-family: Times New Roman" valign="top" align="left" colspan="2">
                                                              <asp:TextBox ID="txtdt" runat="server"></asp:TextBox>
                                                             
                                                            </td>
                                
                                                    </tr>
                            <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                <td align="center" colspan="3" valign="top">
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                
                                     <ContentTemplate>
                                    <asp:RadioButtonList ID="rdbrcst" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt" RepeatDirection="Horizontal" >
                                     
                                        <asp:ListItem Selected="True" Text="Branch Wise" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Customer Wise" Value="1"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    </ContentTemplate>
                                    </asp:UpdatePanel>
                                    </td>
                                    
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
