<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="THCAdvancePayment.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_PrepareVoucher_Vendor_THCAdvancePayment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript" src="../../../../images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript" src="../../../../images/DateControl.js"></script>

    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
    </script>

    <script language="javascript" type="text/javascript">
      frm_name="ctl00$MyCPH1$"
     var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
        var client_name="<%=Session["Client"]%>"
		var Fromdate="<%=fromdt%>"
		//alert(Fromdate)
		var Todate="<%=Todt%>"
		var FinYear="<%=Session["FinYear"]%>"
		var FinYear_to=parseInt(FinYear)+1
		
		if(FinYear_to<10)
		{
		FinYear_to="0"+FinYear_to
		}
		var FinYear_fromdate="01/04/"+FinYear
		var FinYear_todate="31/03/"+FinYear_to
		var Sle_finyear=FinYear+"-"+FinYear_to
		Frmnae="ctl00$MyCPH1$"
		var NetpaymentAmt=0;
    totdkt="<%=totdkt %>"
    function check(txtAdvanceAmtPaid,txtBalanceAmt,cboModeOfTransaction,cboPaymentAccount,txtChequeNo,txtChequeDate,txtPaymentAmt)
    {
        

//	        
//	        /***************************************  ACCOUNTING TRANSACTION *******************************/
//	       
                
                          
                           var server_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
                           
	                        //alert(document.getElementById(Frmnae+"TxtCBSDT").value)
                            // return false;
				            if(document.getElementById(Frmnae+"txtVoucherDate").value=="")
				            {
				              alert("Please enter the Financial Close Date")
				              document.getElementById(Frmnae+"txtVoucherDate").focus();
				              return false;
				            }
						  if (ValidateForm(document.getElementById(Frmnae+"txtVoucherDate"))==false)
				            {
					            document.getElementById(Frmnae+"txtVoucherDate").focus();
					            return  false ;
				            }
				        	  var dt =document.getElementById(Frmnae+"txtVoucherDate").value
				 var hdndockdt;
			   var Maxdt="01/01/2007";
			   
			    var mTotalRecords = totdkt;
			 // alert(mTotalRecords)
                for (var i=0; i < mTotalRecords; i++)
                 {
                    // alert("1")
                    j = i + 2;
                    if(j < 10)
                    {
                        hdndockdt = "ctl00_MyCPH1_dockdata_ctl" + "0" + j + "_thcdate";
                      //  alert(hdndockdt)
                        hdndockdt = document.getElementById(hdndockdt).value;
                      //  alert(hdndockdt)
                        
                    }
                    else
                    {
                        hdndockdt = "ctl00_MyCPH1_dockdata_ctl" + j + "_thcdate";
                        hdndockdt = document.getElementById(hdndockdt).value;
                        
                    }
                   //alert(hdndockdt)
                   // debugger
                  
                  
                     var Maxdt1 =Maxdt
    				
				     var Maxdt_dd=Maxdt1.substring(0,2)
				     var Maxdt_mm=Maxdt1.substring(3,5)
				     var Maxdt_yy=Maxdt1.substring(6,10)
                        
		             var hdndockdt1 =hdndockdt
				     var hdndockdt_dd=hdndockdt1.substring(0,2)
				     var hdndockdt_mm=hdndockdt1.substring(3,5)
				     var hdndockdt_yy=hdndockdt1.substring(6,10)
				    
				     Maxdt1=new Date(months[parseFloat(Maxdt_mm)] + " " + parseFloat(Maxdt_dd) + ", " + parseFloat(Maxdt_yy))
		             hdndockdt1=new Date(months[parseFloat(hdndockdt_mm)] + " " + parseFloat(hdndockdt_dd) + ", " + parseFloat(hdndockdt_yy))
                 //alert(Maxdt1)
				       // alert(hdndockdt1)
			           // alert(Maxdt1)
                    if (hdndockdt1>Maxdt1)
                    {
                    Maxdt1=hdndockdt1
                    Maxdt=hdndockdt
                    }
                 //alert(Maxdt1)
                }
				            var dt_dd=dt.substring(0,2)
				            var dt_mm=dt.substring(3,5)
				            var dt_yy=dt.substring(6,10)

		                    var sdt =server_dt
				            var sdt_dd=sdt.substring(0,2)
				            var sdt_mm=sdt.substring(3,5)
				            var sdt_yy=sdt.substring(6,10)
            				
				
				            dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
		                    server_dt=new Date(months[parseFloat(sdt_mm)] + " " + parseFloat(sdt_dd) + ", " + parseFloat(sdt_yy))
                
                var FinYear_fromdate_dd=FinYear_fromdate.substring(0,2)
				var FinYear_fromdate_mm=FinYear_fromdate.substring(3,5)
				var FinYear_fromdate_yy=FinYear_fromdate.substring(6,10)
				FinYear_fromdate1=new Date(months[parseFloat(FinYear_fromdate_mm)] + " " + parseFloat(FinYear_fromdate_dd) + ", " + parseFloat(FinYear_fromdate_yy))
				
				var FinYear_todate_dd=FinYear_todate.substring(0,2)
				var FinYear_todate_mm=FinYear_todate.substring(3,5)
				var FinYear_todate_yy=FinYear_todate.substring(6,10)
				FinYear_todate1=new Date(months[parseFloat(FinYear_todate_mm)] + " " + parseFloat(FinYear_todate_dd) + ", " + parseFloat(FinYear_todate_yy))
			
				if (dt>FinYear_todate1 || dt<FinYear_fromdate1)
				{
						alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Financial Close Date Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
						document.getElementById(Frmnae+"txtVoucherDate").focus();
						return false;
				}
				
				var Fromdate_dd=Fromdate.substring(0,2)
				var Fromdate_mm=Fromdate.substring(3,5)
				var Fromdate_yy=Fromdate.substring(6,10)
				Fromdate1=new Date(months[parseFloat(Fromdate_mm)] + " " + parseFloat(Fromdate_dd) + ", " + parseFloat(Fromdate_yy))
				
				var Todate_dd=Todate.substring(0,2)
				var Todate_mm=Todate.substring(3,5)
				var Todate_yy=Todate.substring(6,10)
				Todate1=new Date(months[parseFloat(Todate_mm)] + " " + parseFloat(Todate_dd) + ", " + parseFloat(Todate_yy))
                Fromdate1=Maxdt1
			    Fromdate=Maxdt
                              if (dt<Fromdate1)
				                {
						                alert( "Financial Close Date Should Be Greater than  "+ Fromdate +"  !!!")
						                document.getElementById(Frmnae+"txtVoucherDate").focus();
						                return false;
				                }
				                if (dt>server_dt)
				                {
						                alert( "Financial Close Date should not be greater than today's date !!!")
						                document.getElementById(Frmnae+"txtVoucherDate").focus();
						                return false;
				                }
                 k=parseFloat(totdkt)+2
                if(k < 10)
                {
                
                    Form_name1 = "ctl00$MyCPH1$dockdata$ctl" + "0" + k + "$"
                  
                }
                else
                {
                    Form_name1 = "ctl00$MyCPH1$dockdata$ctl" + k + "$"
                    
                }
                
                if (parseFloat(document.getElementById(Form_name1+"TotalNetamt").value)>0)
                {
   		        var varcboModeOfTransaction=cboModeOfTransaction.value
   		       
		            if(varcboModeOfTransaction=="")
		                {
			            alert("Please Select Mode of transaction !!! ")
			            cboModeOfTransaction.focus();
			            return false;
		                }
	                if(cboPaymentAccount.value=="")
		                {
			            alert("Please Select Cash / Bank Account !!! ")
			            cboPaymentAccount.focus();
			            return false;
		                }
		            if((varcboModeOfTransaction=="Cash")&&(cboPaymentAccount.value.indexOf("CASH")<=0))
		                {
			            txtChequeNo.value=""
			            txtChequeDate.value=""
			            alert("Please select Cash Account!!!")
			            cboPaymentAccount.focus()
			            return false;
		                }
		            if(varcboModeOfTransaction=="Cheque"||varcboModeOfTransaction=="DD")
		                {
		                
			            if(cboPaymentAccount.value.indexOf("BANK")<=0)
			                {
				             alert("Please select Bank Account!!!")
				             cboPaymentAccount.focus()
				              return false;
			                } 
			            if(txtChequeNo.value=="")
			                {
				            alert("Please enter Cheque No/DD No ")
				            txtChequeNo.focus();
				             return false;
			                }
			            if(txtChequeDate.value=="")
			                {
				            alert("Please enter Cheque /DD Date")
				            txtChequeDate.focus();
				             return false;
			                }
			            if(txtChequeDate.value!="")
			                {
			                    if (ValidateForm(txtChequeDate)==false)
				                {
					                txtChequeDate.focus();
					                return  false ;
				                }
			                }
			            if(txtPaymentAmt.value=="")
			             {
					        alert("Please enter Collection Amount")
					        txtPaymentAmt.focus();
					        return false;
			              }
			            if(parseFloat(txtPaymentAmt.value)<=0)
			                {
					        alert("Please enter cheque  Amount")
					        txtPaymentAmt.focus();
					         return false;
			                }
        			        
			            if(parseFloat(txtPaymentAmt.value)!=parseFloat(document.getElementById(Form_name1+"TotalNetamt").value))
			                {
					        alert("Cheque  Amount should be equal to Payment amount!!!")
					        txtPaymentAmt.focus();
					        return false;
			                }
		    }
	
			        
		}        
         document.getElementById(frm_name+"txtCashAmount").disabled=false
         document.getElementById(frm_name+"txtPaymentAmt").disabled=false
         click_count=parseFloat(document.getElementById("ctl00_MyCPH1_click_count").value)

 				if(click_count > 0)
				{
					alert("Sorry... You cannot click twice !!!")
					return false;
				}  
				else
				{
					click_count=click_count+1
					document.getElementById("ctl00_MyCPH1_click_count").value=click_count
					return true;
				}  
   }
   function totalcal()
   {
        totalbalmt=0
        for (var i=0; i < totdkt; i++)
         {
                    j = i + 2;
                
                    if(j < 10)
                    {
                    
                        Form_name = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$"
                      
                    }
                    else
                    {
                        Form_name = "ctl00$MyCPH1$dockdata$ctl" + j + "$"
                        
                    }
                   totalbalmt=parseFloat(totalbalmt)+parseFloat(document.getElementById(Form_name+"indadvamt").value)
                    calc();
                    
        }
                 k=j+1
                if(k < 10)
                {
                
                    Form_name1 = "ctl00$MyCPH1$dockdata$ctl" + "0" + k + "$"
                  
                }
                else
                {
                    Form_name1 = "ctl00$MyCPH1$dockdata$ctl" + k + "$"
                    
                }
                document.getElementById(Form_name1+"TotalNetamt").value=totalbalmt
                 calc();
                
}

function calc()
{

Form_name="ctl00$MyCPH1$"
 totalbalmt=0
 totalNetbalmt=0
        for (var i=0; i < totdkt; i++)
         {
                    j = i + 2;
                
                    if(j < 10)
                    {
                    
                        Form_name = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$"
                      
                    }
                    else
                    {
                        Form_name = "ctl00$MyCPH1$dockdata$ctl" + j + "$"
                        
                    }
                   totalbalmt=parseFloat(totalbalmt)+parseFloat(document.getElementById(Form_name+"indadvamt").value)
                  
                   
                   document.getElementById(Form_name+"indnetpay").value=parseFloat(document.getElementById(Form_name+"Hidden_indadvamt").value)+parseFloat(document.getElementById(Form_name+"NetbalAmt").value)-parseFloat(document.getElementById(Form_name+"indadvamt").value)
                    totalNetbalmt=parseFloat(totalNetbalmt)+parseFloat(document.getElementById(Form_name+"indnetpay").value)
        }
        
        
                 k=j+1
                if(k < 10)
                {
                
                    Form_name1 = "ctl00$MyCPH1$dockdata$ctl" + "0" + k + "$"
                  
                }
                else
                {
                    Form_name1 = "ctl00$MyCPH1$dockdata$ctl" + k + "$"
                    
                }
                document.getElementById(Form_name1+"TotalNetamt").value=totalbalmt
                document.getElementById(Frmnae+"txtAdvanceAmtPaid").value=totalbalmt
                document.getElementById(Frmnae+"txtBalanceAmt").value=totalNetbalmt
                
                
                if(document.getElementById(Frmnae+"cboModeOfTransaction").value=="Cash")
                {
                 document.getElementById(frm_name+"txtCashAmount").value=totalbalmt
                 document.getElementById(frm_name+"txtPaymentAmt").value="0.00"
                
                }
                else
                {
                 document.getElementById(frm_name+"txtPaymentAmt").value=totalbalmt
                 document.getElementById(frm_name+"txtCashAmount").value="0.00"
                }
                NetpaymentAmt=totalbalmt

}
    function cahs_N_bank(obj)
    {
        frm_name="ctl00$MyCPH1$"
        
        if(obj.value=="Cash")
        {
         document.getElementById(frm_name+"txtCashAmount").value=NetpaymentAmt
         document.getElementById(frm_name+"txtPaymentAmt").value="0.00"
        
        }
        else
        {
         document.getElementById(frm_name+"txtPaymentAmt").value=NetpaymentAmt
         document.getElementById(frm_name+"txtCashAmount").value="0.00"
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
    </script>

    <br />
    <div align="left">
        <table border="0" style="width: 9.5in" bgcolor="#808080" cellpadding="2" cellspacing="1"
            class="boxbg">
            <asp:HiddenField ID="click_count" runat="server" Value="0" />
            <tr bgcolor="#FFFFFF">
                <td align="center" colspan="2">
                    <font face="verdana" size="3"><b>Trip Hire Contract (THC)</b></font>
                </td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td align="right" style="width: 2in">
                    <font class="blackfnt">&nbsp;Voucher Date &nbsp;&nbsp;&nbsp;</font>
                </td>
                <td align="left">
                    <font class="bluefnt">
                        <asp:TextBox ID="txtVoucherDate" Enabled="true" runat="server" Width="60px" Columns="8"></asp:TextBox>
                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtVoucherDate,'anchor1','dd/MM/yyyy'); return false;"
                            name="anchor1" id="a1">
                            <img src="../../../../images/calendar.jpg" border="0" />
                        </a>dd/mm/yyyy </font>
                </td>
            </tr>
        </table>
        <table border="0" style="width: 9.5in" bgcolor="#808080" cellpadding="2" cellspacing="1"
            class="boxbg">
            <tr bgcolor="#FFFFFF">
                <td colspan="2" valign="top" style="width: 53%">
                    <table border="1" width="100%">
                        <tr>
                            <td align="left" style="width: 160px">
                                <font class="blackfnt">Standard Contract Amount</font>
                            </td>
                            <td align="left" style="width: 13px">
                                <font class="bluefnt">
                                    <asp:Label ID="lblStandardAmt" runat="server" Text="Label"></asp:Label></font>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 160px">
                                <font class="blackfnt">Contract Amount (+)</font>
                            </td>
                            <td align="left" style="width: 13px">
                                <font class="blackfnt">
                                    <asp:TextBox ID="txtContractAmt" runat="server" Enabled="false" Width="70px"></asp:TextBox></font>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 160px">
                                <font class="blackfnt">Other Amount</font>
                            </td>
                            <td align="left" style="width: 13px">
                                <font class="blackfnt">
                                    <asp:TextBox ID="txtOtherAmt" runat="server" Enabled="false" Width="70px"></asp:TextBox></font>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 160px">
                                <font class="blackfnt">TDS Amount (-)</font>
                            </td>
                            <td align="left" style="width: 13px">
                                <font class="blackfnt">
                                    <asp:TextBox ID="txtTDSAmt" runat="server" Enabled="false" Width="70px"></asp:TextBox></font>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 160px">
                                <font class="blackfnt">Service Tax (+)</font>
                            </td>
                            <td align="left" style="width: 13px">
                                <font class="blackfnt">
                                    <asp:TextBox ID="txtServiceTax" runat="server" Enabled="false" Width="70px"></asp:TextBox></font>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 160px">
                                <font class="blackfnt">Cess (+)</font>
                            </td>
                            <td align="left" style="width: 13px">
                                <font class="blackfnt">
                                    <asp:TextBox ID="cessamt" runat="server" Enabled="false" Width="70px"></asp:TextBox></font>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 160px">
                                <font class="blackfnt">Higher Edu. Cess (+)</font>
                            </td>
                            <td align="left" style="width: 13px">
                                <font class="blackfnt">
                                    <asp:TextBox ID="H_cessamt" runat="server" Enabled="false" Width="70px"></asp:TextBox></font>
                            </td>
                        </tr>
                    </table>
                </td>
                <td colspan="2" width="50%" valign="top">
                    <table border="1" width="100%">
                        <tr>
                            <td align="left">
                                <font class="blackfnt">PAN No</font>
                            </td>
                            <td align="left" bgcolor="#FFFFFF">
                                <font class="blackfnt">
                                    <asp:TextBox ID="txtPANNO" runat="server" Enabled="true" Width="70px"></asp:TextBox></font>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <font class="blackfnt">Advance Amount Paid by</font>
                            </td>
                            <td align="left">
                                <font class="blackfnt">
                                    <asp:TextBox ID="txtAdvanceAmtPaidBy" runat="server" Enabled="false" Width="136px"></asp:TextBox></font>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <font class="blackfnt">TDS type</font>
                            </td>
                            <td align="left">
                                <font class="blackfnt">
                                    <asp:DropDownList ID="cboTDSType" runat="server" Mode="Conditional" RenderMode="Inline"
                                        Width="152px">
                                        <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                    </asp:DropDownList>
                                </font>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" bgcolor="#FFFFFF">
                                <font class="blackfnt">TDS Deducted For</font>
                            </td>
                            <td align="left" bgcolor="#FFFFFF">
                                <asp:DropDownList ID="cboTDSDeducted" runat="server" Mode="Conditional" RenderMode="Inline"
                                    Width="152px">
                                    <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Corporate" Value="C"></asp:ListItem>
                                    <asp:ListItem Text="NonCorporate" Value="NC"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <font class="blackfnt">Advance Paid </font>
                            </td>
                            <td align="left">
                                <font class="blackfnt">
                                    <asp:TextBox ID="txtAdvanceAmtPaid" runat="server" Enabled="false" Width="70px"></asp:TextBox></font>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <font class="blackfnt"><b>Balance Amount</b></font>
                            </td>
                            <td align="left" bgcolor="#FFFFFF">
                                <font class="blackfnt">
                                    <asp:TextBox ID="txtBalanceAmt" runat="server" Enabled="false" Width="70px" EnableViewState="true"></asp:TextBox></font>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <font class="blackfnt"><b>Balance Payable at</b></font>
                            </td>
                            <td align="left" bgcolor="#FFFFFF">
                                <font class="blackfnt">
                                    <asp:TextBox ID="txtBalancePayableAt" runat="server" Enabled="false" Width="70px"></asp:TextBox></font>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <br />
        <p align="left">
            &nbsp;&nbsp;&nbsp;&nbsp;<font class="blackfnt"><b><u>Note :</u></b> Please enter the
                payment details if advance amount >0 .</font></p>
        <br />
        <div align="left">
            <asp:GridView ID="dockdata" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
                AllowSorting="true" AllowPaging="true" PageSize="1000" PagerStyle-HorizontalAlign="left"
                CssClass="boxbg" BackColor="white" FooterStyle-CssClass="bgbluegrey" ShowFooter="True"
                PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]"
                PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..." Style="width: 9.5in">
                <Columns>
                    <asp:TemplateField HeaderText="SRNo.">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" />
                        <ItemTemplate>
                            <asp:Label ID="lblSRNo" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="DocumentNo" CssClass="blackfnt" Text="DocumentNo" runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="thcno" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"dockno") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblcontractAmt" Style="text-align: center" CssClass="blackfnt" Text="Contract Amount (+)"
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:TextBox ID="indpcamt" runat="server" Enabled="false" MaxLength="10" Columns="6"
                                    Text='<%# DataBinder.Eval(Container.DataItem,"PCAMT") %>'></asp:TextBox>
                                <asp:HiddenField runat="server" ID="thcdate" Value='<%# DataBinder.Eval(Container.DataItem,"thcdate") %>' />
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblOtherAmt" Style="text-align: center" CssClass="blackfnt" Text="Other Amount(+) "
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:TextBox ID="indothamt" MaxLength="10" Columns="6" Enabled="false" runat="server"
                                    Text='<%# DataBinder.Eval(Container.DataItem,"OTHCHRG") %>'></asp:TextBox>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblTDSRate" Style="text-align: center" CssClass="blackfnt" Text="TDS Rate"
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:TextBox ID="indtds_rate" MaxLength="10" Enabled="false" Columns="6" runat="server"
                                    Text='<%# DataBinder.Eval(Container.DataItem,"tds_rate") %>'></asp:TextBox>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblTDSdeduction" Style="text-align: center" CssClass="blackfnt" Text="TDS Dedn.(-)"
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:TextBox ID="indtdsded" MaxLength="10" Enabled="false" Columns="6" runat="server"
                                    Text='<%# DataBinder.Eval(Container.DataItem,"tdsded") %>'></asp:TextBox>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblunexpamt" Style="text-align: center" CssClass="blackfnt" Text="Service Tax Rate"
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:TextBox ID="cboindsvctaxrate" MaxLength="10" Columns="6" Enabled="false" runat="server"
                                    Text='<%# DataBinder.Eval(Container.DataItem,"svrc_rate") %>'></asp:TextBox>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblServiceTax" Style="text-align: center" CssClass="blackfnt" Text="Service Tax (+) "
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:TextBox ID="indsvctax" MaxLength="10" Enabled="false" Columns="6" runat="server"
                                    Text='<%# DataBinder.Eval(Container.DataItem,"SVCTAX") %>'></asp:TextBox>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblcess" Style="text-align: center" CssClass="blackfnt" Text="Cess (+) "
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:TextBox ID="indcess" MaxLength="10" Enabled="false" Columns="6" runat="server"
                                    Text='<%# DataBinder.Eval(Container.DataItem,"CESSAMT") %>'></asp:TextBox>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lbl_H_cess" Style="text-align: center" CssClass="blackfnt" Text="Higher Edu. Cess (+) "
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:TextBox ID="ind_H_cess" MaxLength="10" Enabled="false" Columns="6" runat="server"
                                    Text='<%# DataBinder.Eval(Container.DataItem,"HEDU_CESS") %>'></asp:TextBox>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblAdvamt" Style="text-align: center" CssClass="blackfnt" Text=" Advance Amt. (-) "
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:TextBox ID="indadvamt" MaxLength="10" onblur="javascript:calc()" Columns="6"
                                    runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"ADVAMT") %>'></asp:TextBox>
                                <asp:HiddenField ID="NetbalAmt" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"netbalamt") %>' />
                                <asp:HiddenField ID="Hidden_indadvamt" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"ADVAMT") %>' />
                                <asp:HiddenField ID="Advance_paid" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"Advance_paid") %>' />
                            </center>
                        </ItemTemplate>
                        <FooterTemplate>
                            <center>
                                <asp:TextBox ID="TotalNetamt" Font-Bold="true" runat="server" Enabled="false" Text="0.00"
                                    Columns="6"></asp:TextBox>
                            </center>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblNetPayable" Style="text-align: center" CssClass="blackfnt" Text="Net Balance Amt."
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:TextBox ID="indnetpay" Enabled="false" MaxLength="10" Columns="6" runat="server"
                                    Text='<%# DataBinder.Eval(Container.DataItem,"NET") %>'></asp:TextBox>
                                <asp:HiddenField ID="vendor_code" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"vendor_code")%>' />
                                <asp:HiddenField ID="vendor_Name" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"vendor_Name")%>' />
                                <asp:HiddenField ID="pan_no" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"pan_no")%>' />
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <RowStyle />
                <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                <HeaderStyle CssClass="bgbluegrey" />
                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                <FooterStyle CssClass="bgbluegrey" />
            </asp:GridView>
        </div>
        <br />
        <table border="0" cellspacing="1" cellpadding="4" style="width: 9.5in" class="boxbg">
            <tr class="bgbluegrey">
                <td colspan="4" align="center">
                    <font class="blackfnt">Payment Details</font>
                </td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td align="left">
                    <font class="blackfnt">Mode Of Transaction </font>
                </td>
                <td align="left">
                    <font class="blackfnt">
                        <asp:updatepanel id="u1" runat="server">
				        <ContentTemplate>
				        <asp:DropDownList ID="cboModeOfTransaction" runat="server"  AutoPostBack="true" OnSelectedIndexChanged="cboModeOfTransaction_SelectedIndexChanged"  Mode="Conditional" RenderMode="Inline" Width="60px" onchange="javascript:cahs_N_bank(this)">
				        <asp:ListItem Text="Select" Value=""></asp:ListItem>
				        <asp:ListItem Text="Cash" Value="Cash"></asp:ListItem>
				        <asp:ListItem Text="Cheque" Value="Cheque"></asp:ListItem>
				       
						</asp:DropDownList>
                    </font></ContentTemplate> </asp:UpdatePanel>
                </td>
                <td align="left">
                    <font class="blackfnt">Payment Account</font>
                </td>
                <td align="left">
                    <font class="blackfnt">
                        <asp:updatepanel id="UpdatePanel1" runat="server">
				        <ContentTemplate>
				        <asp:DropDownList ID="cboPaymentAccount"  AutoPostBack="true"  runat="server">
				        <asp:ListItem>--Select--</asp:ListItem>
						</asp:DropDownList>
						</ContentTemplate>
						<Triggers>
						<asp:AsyncPostBackTrigger ControlID="cboModeOfTransaction" EventName="SelectedIndexChanged" />
						</Triggers>
						</asp:updatepanel>
                    </font>
                </td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td align="left">
                    <font class="blackfnt">Cheque No </font>
                </td>
                <td align="left">
                    <font class="blackfnt">
                        <asp:TextBox ID="txtChequeNo" runat="server" Width="70px" MaxLength="6"></asp:TextBox></font>
                </td>
                <td align="left">
                    <font class="blackfnt">Cheque Date </font>
                </td>
                <td align="left">
                    <font class="blackfnt">
                        <asp:TextBox ID="txtChequeDate" runat="server" Width="70px" onblur="javascript:ValidateForm(this)"></asp:TextBox><a
                            href="#" onclick="cal.select(ctl00$MyCPH1$txtChequeDate,'anchor2','dd/MM/yyyy'); return false;"
                            name="anchor2" id="anchor2"><img src="../../../../images/calendar.jpg" border="0" />
                        </a>dd/mm/yyyy </font>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="left">
                    <font class="blackfnt">Payment Amount</font>
                </td>
                <td align="left">
                    <font class="blackfnt">
                        <asp:TextBox ID="txtPaymentAmt" runat="server" Enabled="false" Width="70px"></asp:TextBox></font>
                </td>
                <td align="left">
                    <font class="blackfnt">Cash Amount</font>
                </td>
                <td align="left">
                    <font class="blackfnt">
                        <asp:TextBox ID="txtCashAmount" runat="server" Width="70px" Enabled="false"></asp:TextBox></font>
                </td>
            </tr>
        </table>
        <br />
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="blackfnt" OnClick="btnSubmit_Click" />

        <script language="javascript" type="text/javascript">
            window.onload = totalcal
        </script>

    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
