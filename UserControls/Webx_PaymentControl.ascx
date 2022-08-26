<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Webx_PaymentControl.ascx.cs" Inherits="UserControls_Webx_PaymentControl" %>
 
<%--<script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"> </script>
--%>
 <script language="javascript" type="text/javascript">
 
 
//    var cal = new CalendarPopup("Div1"); 
//	cal.setCssPrefix("TEST");
//	cal.showNavigationDropdowns();
//	  var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
//      var FinYear="<%=Session["FinYear"]%>"
//		var FinYear_to=parseInt(FinYear)+1
//		
//		if(FinYear_to<10)
//		{
//		FinYear_to="0"+FinYear_to
//		}
//		var FinYear_fromdate="01/04/"+FinYear
//		var FinYear_todate="31/03/"+FinYear_to
//		var Sle_finyear=FinYear+"-"+FinYear_to
// function ValidateDate(obj)
//    {

//      if (obj.value!="")
//      {
//        
//	    if (isDate(obj.value)==false)
//	    {
//    	
//		    obj.focus()
//		    return false
//	    }
//        return true
//      }
//    }
//     var dtCh= "/";
//     var minYear="1900";
//    var maxYear="2100";
//     function DaysArray(n) 
//     {
//	    for (var i = 1; i <= n; i++) 
//	    {
//		    this[i] = 31
//		    if (i==4 || i==6 || i==9 || i=="11") {this[i] = 30}
//		    if (i==2) {this[i] = 29}
//       } 
//        return this
//     }
//   function isDate(dtStr){
//	var daysInMonth = DaysArray(12)
//	var pos1=dtStr.indexOf(dtCh)
//	var pos2=dtStr.indexOf(dtCh,pos1+1)
//	var strDay=dtStr.substring(0,pos1)
//	var strMonth=dtStr.substring(pos1+1,pos2)
//	var strYear=dtStr.substring(pos2+1)
//	strYr=strYear
//	if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
//	if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
//	for (var i = 1; i <= 3; i++) {
//		if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
//	}
//	month=parseInt(strMonth)
//	day=parseInt(strDay)
//	year=parseInt(strYr)
//	if (pos1==-1 || pos2==-1){
//		alert("The date format should be : dd/mm/yyyy")
//		return false
//	}
//	if (strMonth.length<1 || month<1 || month>12){
//		alert("Please enter a valid month")
//		return false
//	}
//	if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
//		alert("Please enter a valid day")
//		return false
//	}
//	if (strYear.length != 4 || year==0 || year<minYear || year>maxYear){
//		alert("Please enter a valid 4 digit year between "+minYear+" and "+maxYear)
//		return false
//	}
//	if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
//		alert("Please enter a valid date")
//		return false
//	}
//	return true
//}

function Nagative_Chk_wDecimal(obj)
{
	var temp
	temp=obj.value 
	//alert(temp)					
	if (temp=="")	
	{
		alert("Value can not be blank")
		obj.focus();
        obj.value="0.0";
		return false;
	}
	if(isNaN(temp))
	{
		alert("Value should be Numeric")
		obj.value="0.0";
		obj.focus();
		return false;
	} 					  
	if(parseFloat(temp)<0)
	{
		alert("Value should be greater than zero")
		obj.value="0.0";
		obj.focus();
		return false;
	}
	obj.value=roundit(temp) 
	return true;					   
}
function roundit(Num)
	{
		Places=2
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
		else return Math.round(Num);
	}
	
	function rounditn(Num,decplaces)
	{
		Places=decplaces
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
				//alert("Hi")
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
		else return Math.round(Num);
		
	}
	
	/*function CheckData()
	{
	   if(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "-1")
        {
            alert("Please Enter Payment Mode");
            sdocument.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').focus();
            return false;
        }
        return true;
     } */  
	
	
	
	function CheckCashBank()
	{
	     var txtNetPay =  document.getElementById("ctl00_MyCPH1_txtNetPay");
	    var txtCashAmt = document.getElementById("ctl00_MyCPH1_txtCashAmt");
	    var ddlPayMode = document.getElementById("ctl00_MyCPH1_ddlPayMode");
	    var txtChqAmt = document.getElementById("ctl00_MyCPH1_txtChqAmt");
	    var temp;
	    
	    if(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Cash")
	    {
	        if(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtCashAmt').value !=  document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtNetPay').value)
            {
                alert("Cash Amount must be equal Net Payable Amount");
                document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtCashAmt').focus();
                document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtCashAmt').value = "";
                return false;
            }
         }
         else if(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Bank")
         {
            if(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtChqAmt').value !=  document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtNetPay').value)
            {
                alert("Cash Amount must be equal Net Payable Amount");
                document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtChqAmt').focus();
                document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtChqAmt').value = "";
                return false;
            }
         }
         else if(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Both")
         {
            
            if(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtCashAmt').value == 0.00 || document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtCashAmt').value == "")
            {
                if(Number(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtChqAmt').value) > Number(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtNetPay').value))
                {
                    alert("Cash Amount and Cheque Amount MUST be equal to Net payable");
                    document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtChqAmt').focus();
                    return false;
                }
            }
            else if (document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtChqAmt').value == 0.00 || document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtChqAmt').value == "")
            {
                if(Number(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtCashAmt').value) > Number(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtNetPay').value))
                {
                    alert("Cash Amount and Cheque Amount MUST be equal to Net payable");
                    document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtCashAmt').focus();
                    return false;
                }
            }
            else
            {
                temp = parseFloat(Number(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtCashAmt').value) + Number(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtChqAmt').value));
                if(temp !=  document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtNetPay').value)
                {
                    alert("Cash Amount and Cheque Amount MUST be equal to Net payable");
                    document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtCashAmt').value = "0.00";
                    document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtChqAmt').value = "0.00";
                    return false;
                }
            }
            }
	}
	
	
	function CheckData()
	{
	if(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "-1")
        {
            alert("Please Enter Payment Mode");
            document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').focus();
            return false;
        }
        if(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Cash" || document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Both" )
        {
            if(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddrCashcode').value == "")
            {
                alert("Please Select Cash Account");
                document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddrCashcode').focus();
                return false;
            }
            if(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtCashAmt').value == "")
            {
                 alert("Please Enter Cash Amount");
                 //document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtCashAmt').focus();
                return false;
            }
            
       }
        
       if(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Bank" || document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Both" )
        {
            if(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddrBankaccode').value == "")
            {
                alert("Please Select Bank Account");
                document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddrBankaccode').focus();
                return false;
            }
            if(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtChqAmt').value == "")
            {
                alert("Please Enter Cheque Amount");
                //document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtChqAmt').focus();
                return false;
            }
            if(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtChqNo').value == "")
            {
                alert("Please Enter Cheque Number");
                document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtChqNo').focus();
                return false;
            }
           
            if(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtChqDate').value == "")
            {
                alert("Please Enter Cheque Date");
                document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtChqDate').focus();
                return false;
            }
       }
       
       if(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Both" )
       {
               
                if(parseFloat(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtCashAmt').value)+parseFloat(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtChqAmt').value) != parseFloat(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtNetPay').value))
                {
                    alert("Cash Amount and Cheque Amount MUST be equal to Net payable");
                    document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtCashAmt').value = "0.00";
                    document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtChqAmt').value = "0.00";
                    return false;
                }
       }
       if(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Cash" )
       {
               
                if(parseFloat(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtCashAmt').value) != parseFloat(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtNetPay').value))
                {
                    alert("Cash Amount MUST be equal to Net payable");
                    document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtCashAmt').value = "0.00";
                    return false;
                }
       }
       if(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Bank" )
       {
               
                if(parseFloat(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtChqAmt').value) != parseFloat(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtNetPay').value))
                {
                    alert("Cheque Amount MUST be equal to Net payable");
                    document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtChqAmt').value = "0.00";
                    return false;
                }
       }
       
       return true;
	}
 </script>
 
 <br />
       <%-- <atlas:UpdatePanel ID="UpdatePanel2" runat="server" Mode="Conditional" RenderMode="Inline">
            <ContentTemplate>--%>
                <table border="0" cellpadding="3" cellspacing="1" class="boxbg" width="100%">
                    <tr style="background-color: White">
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Payment Mode
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:DropDownList ID="ddlPayMode" runat="server" Width="87px" AutoPostBack="True" CssClass="blackfnt"
                                OnSelectedIndexChanged="ddlPayMode_SelectedIndexChanged">
                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                <asp:ListItem>Cash</asp:ListItem>
                                <asp:ListItem>Bank</asp:ListItem>
                                <asp:ListItem>Both</asp:ListItem>
                            </asp:DropDownList></td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Amount Applicable
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:TextBox ID="txtAmtApplA"  style="text-align: Right"  runat="server" BorderStyle="Groove" CssClass="Blackfnt" Width="80px"  Text="0.00" Enabled="false"></asp:TextBox></td><%--Enabled="False"--%>
                    </tr>
                    <tr style="background-color: White">
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;*Cash Amount
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:TextBox style="text-align: Right"   ID="txtCashAmt" Enabled="false" Text="0.00" runat="server" onchange="javascript:Nagative_Chk_wDecimal(this)" BorderStyle="Groove" CssClass="input" Width="80px"  ></asp:TextBox></td><%-->Enabled="False"--%>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Cash Account
                        </td>
                        <td style="text-align: left" class="blackfnt"> 
                        &nbsp;<asp:DropDownList ID="ddrCashcode" runat="server"   CssClass="Blackfnt" >
                                
                            </asp:DropDownList>
                            &nbsp;</td>
                    </tr>
                    <tr style="background-color: White">
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Cheque Amount
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:TextBox  style="text-align: Right"  ID="txtChqAmt" Enabled="false" Text="0.00" runat="server"  onchange="javascript:Nagative_Chk_wDecimal(this)" BorderStyle="Groove" CssClass="input" Width="80px"   ></asp:TextBox></td><%--Enabled="False"--%>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Bank Account
                        </td>
                        <td style="text-align: left" class="blackfnt">
                             &nbsp;<asp:DropDownList ID="ddrBankaccode" runat="server"   CssClass="Blackfnt" >
                             </asp:DropDownList>
                       </td>
                    </tr>
                    <tr style="background-color: White">
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Cheque No.
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:TextBox ID="txtChqNo" MaxLength="6" runat="server" BorderStyle="Groove" CssClass="input"  Columns="6" Enabled="False"></asp:TextBox></td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Cheque date
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:TextBox ID="txtChqDate" runat="server" onblur="javascript:ValidateDate(this)"
                                BorderStyle="Groove" CssClass="input" MaxLength="10" Width="80px"></asp:TextBox>
                          <!--  <a href="#" onclick="cal.select(ctl00$MyCPH1$UCMyPaymentControl1$txtChqDate,'anchor11','dd/MM/yyyy'); return false;" id="a1" name="anchor11">
                                <img alt="Cal" border="0" src="../images/calendar.jpg" /></a>--></td>
                    </tr>
                    <tr style="background-color: White">
                        <td style="text-align: left" class="blackfnt">
                        </td>
                        <td style="text-align: left" class="blackfnt">
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            <strong>&nbsp;NET PAYABLE </strong>
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:TextBox ID="txtNetPay" style="text-align: Right"   runat="server" BorderStyle="Groove" CssClass="input" Width="80px"  Enabled="false" Text="0.00"></asp:TextBox>
                            </td><%--Enabled="False"--%>
                    </tr>
                </table>
           <%-- </ContentTemplate>
        </atlas:UpdatePanel>--%>
        <br />
               <%--<div id="Div1" style="position: absolute; visibility: hidden; background-color: white;layer-background-color: white; z-index: 99;">
    </div> --%>