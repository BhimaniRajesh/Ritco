<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="ExpenseVoucherMain.aspx.cs" Inherits="GUI_Fleet_Operations_Expense_ExpenseVoucherMain" %>
<%@ Register TagName="UCEXPVOU" TagPrefix="UCMyExpenseVoucher" Src="~/UserControls/MyExpenseVoucherFV.ascx" %>
<%@ Register TagPrefix="UC5" TagName="UCMyPaymentControlEXP" Src="~/UserControls/MyPaymentControlEXP.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

<%
    string Stat = Request.QueryString["Stat"]; %>
<script language="javascript">
function Check()
    {
        var Date=document.getElementById("ctl00_MyCPH1_txtDate").value;
        if(Date=="")
              {
                alert("Please Enter Expense Voucher Date !")
                document.getElementById("ctl00_MyCPH1_txtDate").focus();
                return false;
              }

               
         if (CheckValid()==false)// Validation of Expense Voucher User Control
          {
            return false;
          }
        
        if(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Cash"  )
        {
           {
              document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtCashAmt').value=document.getElementById('ctl00$MyCPH1$UCMyExpenseVoucher1$txtTotalExeAmt').value;
           }
           document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtNetPay').value=document.getElementById('ctl00$MyCPH1$UCMyExpenseVoucher1$txtTotalExeAmt').value;
           document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtAmtApplA').value=document.getElementById('ctl00$MyCPH1$UCMyExpenseVoucher1$txtTotalExeAmt').value;
           
        }
        
         if(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Bank"  )
        {
           {
              document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtChqAmt').value=document.getElementById('ctl00$MyCPH1$UCMyExpenseVoucher1$txtTotalExeAmt').value;
           }
           document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtNetPay').value=document.getElementById('ctl00$MyCPH1$UCMyExpenseVoucher1$txtTotalExeAmt').value;
           document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtAmtApplA').value=document.getElementById('ctl00$MyCPH1$UCMyExpenseVoucher1$txtTotalExeAmt').value;
        }
        
       
        if (CheckData()==false) // Validation of Payment User Control
          {
           return false;
          }
       
     
       if (confirm("Do you want to submit")==false)
		{
		  return false;
		}
     
          
          //alert("Submit");
          //return false;
         
   }
</script>

 <script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"> </script>
 <script language="javascript" type="text/javascript">
var cal = new CalendarPopup("Div1"); 
cal.setCssPrefix("TEST");
cal.showNavigationDropdowns();
var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");


var FinYear="<%=Session["FinYear"]%>"
		var FinYear_to=parseInt(FinYear)+1
		
		if(FinYear_to<10)
		{
		FinYear_to="0"+FinYear_to
		}
		var FinYear_fromdate="01/04/"+FinYear
		var FinYear_todate="31/03/"+FinYear_to
		var Sle_finyear=FinYear+"-"+FinYear_to

 function ValidateDate(obj)
    {
      if (obj.value!="")
      {
	    if (isDate(obj.value)==false)
	    {
		    obj.focus();
		    return false;
	    }
        return true;
      }
    }
     var dtCh= "/";
     var minYear="1900";
    var maxYear="2100";
     function DaysArray(n) 
     {
	    for (var i = 1; i <= n; i++) 
	    {
		    this[i] = 31
		    if (i==4 || i==6 || i==9 || i=="11") {this[i] = 30}
		    if (i==2) {this[i] = 29}
       } 
        return this;
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
function stripCharsInBag(s, bag){
	var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++){   
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}
function isInteger(s){
	var i;
    for (i = 0; i < s.length; i++){   
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}
</script> 


<asp:UpdateProgress ID="uppMain" runat="server">
<ProgressTemplate>
    <iframe frameborder="0" src="about:blank"
        style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
        <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);"><img src="../../../images/loading.gif" /><font face=verdana color=blue size=4>&nbsp;<b>Please Wait...</b></font></div>
</ProgressTemplate>
</asp:UpdateProgress>

<p align="center">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" width="45%">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Expense Voucher</asp:Label>
 
            </td>
            
             <td align=left>
                       
                <%--<asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                    <font class="blackfnt" color=red><b>Please wait...</b></font>
            </ProgressTemplate>
          </asp:UpdateProgress>  --%>
         
          </td>      
        </tr>
    </table>
    
    </p>
   
    <hr align="center" size="1" color="#8ba0e5">
      <br/> 
      <p align="center">
    <table  align="center" width="90%">
       <tr>
       <td>
       
              <asp:UpdatePanel ID="UpdatePanel10" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                    <ContentTemplate>
 
 
      
      <table cellspacing="1" cellpadding="3" width="90%" class="boxbg" border="0">
            
            <tr style="background-color: white">
                <td colspan="4" align="center">
                    <asp:Label ID="lblError"  runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor="red"></asp:Label>
                    
                    </td>
                   </tr>
            
            <tr class="bgbluegrey">
                <td colspan="4" align="center">
                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="EXPENSE VOUCHER FORM"></asp:Label>
                    </td>
                           
                    
            </tr>
            
            <tr style="background-color: white">
              
                <td align="left" nowrap>
                <font class="blackfnt" color=red></font> <font class=bluefnt>Expense Voucher Date</font>
                </td>
                <td align="left">
             <%--<SControls:DateSelector     ID="txtDate" runat="server" /> --%>
         <asp:TextBox ID="txtDate" runat="server" onblur="javascript:ValidateDate(this)"
                                BorderStyle="Groove" CssClass="input" MaxLength="10" Width="80px"></asp:TextBox>
                            <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDate,'anchor22','dd/MM/yyyy'); return false;" id="a1" name="anchor22">
                                <img alt="Cal" border="0" src="../../../images/calendar.jpg" /></a>

                </td>
                 
                
            </tr>
           
               
     
                 <tr style="background-color: white">
                <td nowrap align=left><font class=bluefnt>Enter Manual Voucher No.</font></td>
                
                
                <td colspan="3"    align=left>
                   <asp:TextBox ID="txtManualVno" BorderStyle="Groove"     runat="server"  ></asp:TextBox>
                </td>
                
                </tr> 
             </table>   
                
                
                <!---- FIXED/EXPENSE VOUCHER Starts Here  -->
                
                <br>
                 <%--<tr style="background-color: white">
                            <td align="left" colspan="2">--%>
                            
                            <%Session["VehiclePopoupPath"] = "../../../../"; %>
                            
                                <UCMyExpenseVoucher:UCEXPVOU ID="UCMyExpenseVoucher1" runat="server" />
                           <%-- </td>
                        </tr>--%>
                <br>
                
                <!---- FIXED/EXPENSE VOUCHER Ends Here -->
                
                
                
                
                 <table Width="90%"   cellspacing="1" cellpadding="3" class="boxbg" border="0">
  
  
             <tr class="bgbluegrey">
                <td colspan=4 align=center ><font class=blackfnt><b>Verifying Authorities</b></font></td>
            </tr>
                            
                    <tr style="background-color: white">
                        <td align="center"><font class=blackfnt>Checked By Fleet Executive</font></td>
                        <td align="center"><font class=blackfnt>Verified By Branch Head</font></td>
                       
                    </tr> 
                    
                    <tr style="background-color: white">
                        <td align="center"><asp:TextBox ID="txtCheckedBy" runat="server"  Width="150px" BorderStyle="Groove" MaxLength="50"></asp:TextBox></td>
                        <td align="center"><asp:TextBox ID="txtVerifiedBy" runat="server"  Width="150px" BorderStyle="Groove" MaxLength="50"></asp:TextBox></td>
           
                    </tr> 
                    
                    
                     <tr style="background-color: white">
                        <td align="center"><font class=blackfnt>Received By</font></td>
                        <td align="center"><font class=blackfnt>Approved & Accounted By Branch Commercial</font></td>

                    </tr> 
                     <tr style="background-color: white">
                        <td align="center"><asp:TextBox ID="txtReceivedBy" runat="server"  Width="150px" BorderStyle="Groove" MaxLength="50"></asp:TextBox></td>
                        <td align="center"><asp:TextBox ID="txtApprovedBy" runat="server"  Width="150px" BorderStyle="Groove" MaxLength="50"></asp:TextBox></td>
              
                    </tr> 
                    
                    
                    
   </table>
 
 <br>
        <asp:UpdatePanel ID="UpdatePanePayment" UpdateMode="Conditional" RenderMode="Inline" runat="server" Visible=true >
            <ContentTemplate>
                <UC5:UCMyPaymentControlEXP ID="UCMyPaymentControl1" runat="server" ></UC5:UCMyPaymentControlEXP>
            </ContentTemplate>
        </asp:UpdatePanel> 
       
  <br/>
 
    <table  width="90%">
  
     <tr>
     <td align="center">
      <asp:Button ID="cmdSubmit" runat="server" Text="Submit >>"    ValidationGroup="VGDtFromTo" OnClick="SubmitData"  OnClientClick="javascript:return Check()"   />
      </td>
      </tr> 

  </table>     
   </ContentTemplate>
                     <Triggers>
                      
<%--                          <asp:AsyncPostBackTrigger ControlID="txtRow1" EventName="TextChanged" />
                                                 <asp:AsyncPostBackTrigger ControlID="txtRow2" EventName="TextChanged" />
                                                                          <asp:AsyncPostBackTrigger ControlID="txtRow3" EventName="TextChanged" />
                                                                                                   <asp:AsyncPostBackTrigger ControlID="txtRow4" EventName="TextChanged" />--%>
                                                                                                    
                    </Triggers>
                    </asp:UpdatePanel> 
  </td>
  </tr>
           </table>  
 </p>
 
 <div id="Div1" style="position: absolute; visibility: hidden; background-color: white;layer-background-color: white; z-index: 99;">
    </div> 
                
                
                
                

</asp:Content> 