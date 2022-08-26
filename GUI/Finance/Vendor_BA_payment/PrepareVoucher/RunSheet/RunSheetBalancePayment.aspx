<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="RunSheetBalancePayment.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_PrepareVoucher_Vendor_THCAdvancePayment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript" src="../../../../images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript" src="../../../../images/DateControl.js"></script>

    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1"); 
	    cal.setCssPrefix("TEST");
	    cal.showNavigationDropdowns();
    </script>

    <script language="javascript" type="text/javascript">
     frm_name="ctl00$MyCPH1$"
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
        totdkt="<%=totdkt %>"

    function dateBlur(obj,tp)
    {
        if(!isValidDate(obj.value,tp))
            return false;
    }
    
   
    function cash_N_bank(obj)      
    {
        var pay=document.getElementById("ctl00_MyCPH1_txtBalanceAmt").value
        if(obj.value=="Cash")
        {
           // document.getElementById(frm_name + "txtCashAmount").disabled=false;
            document.getElementById(frm_name + "txtCashAmount").value=pay;
          //  document.getElementById(frm_name + "txtPaymentAmt").disabled=true;
            document.getElementById(frm_name + "txtPaymentAmt").value="0.00";
        }
        else
        {
           // document.getElementById(frm_name + "txtCashAmount").disabled=false;
            document.getElementById(frm_name + "txtCashAmount").value="0.00";
           // document.getElementById(frm_name + "txtPaymentAmt").disabled=true;
            document.getElementById(frm_name + "txtPaymentAmt").value=pay;
            
        }
    }
       
        
    function calculateBalance()
    {
        var grid=document.getElementById("ctl00_MyCPH1_gvrunsheet");
        var r=grid.rows.length;
        
        var totbal=0.00;
        var totadv=0.00;
        var totcon=0.00;
        var tototh=0.00;
        var totded=0.00;
        var total_deduction=0.00
   // alert(totdkt)
        for(i=0;i<totdkt;i++)
        {
        j=i+2
            var pref=""; 
            if(j<10)
                pref = "ctl00_MyCPH1_gvrunsheet_ctl0" + j + "_";
            else
                pref = "ctl00_MyCPH1_gvrunsheet_ctl" + j + "_";
                
            var conamt=document.getElementById(pref + "indpcamt");
            var othamt=document.getElementById(pref + "indothamt");
            
            var tdsrate=document.getElementById(pref + "indtds_rate");
            
            var dedamt=document.getElementById(pref + "indtdsded");
            var advamt=document.getElementById(pref + "indadvamt");
            var balamt=document.getElementById(pref + "indnetpay");
            var ded_amt=document.getElementById(pref + "indoth_ded_amt"); 
            
            tototh=tototh + parseFloat(othamt.value);
            totcon=totcon + parseFloat(conamt.value);
            totded=totded + parseFloat(dedamt.value);
            total_deduction=total_deduction + parseFloat(ded_amt.value);
            var tdsamt=0;
            if(parseFloat(tdsrate.value)!=0)
                tdsamt = (parseFloat(conamt.value)/parseFloat(tdsrate.value))*100;
            
            var bal=parseFloat(conamt.value) + parseFloat(othamt.value)  - parseFloat(dedamt.value) - parseFloat(advamt.value)-parseFloat(ded_amt.value);
            
            balamt.value=bal;
            totbal=totbal+bal;            
                                        // ctl00$MyCPH1$gvrunsheet$ctl06$TotalNetPay 4 datarow
            totadv=totadv + parseFloat(advamt.value);
        }
    
            var rs=parseInt(r);
            
           if(rs<10)
                {
                    document.getElementById("ctl00_MyCPH1_gvrunsheet_ctl0" + parseInt(rs) + "_TotalNetamt").value=totadv;
                    document.getElementById("ctl00_MyCPH1_gvrunsheet_ctl0" + parseInt(rs) + "_TotalNetPay").value=totbal;
                }
            else
                {
                    document.getElementById("ctl00_MyCPH1_gvrunsheet_ctl" + parseInt(rs) + "_TotalNetamt").value=totadv;
                    document.getElementById("ctl00_MyCPH1_gvrunsheet_ctl" + parseInt(rs) + "_TotalNetPay").value=totbal;
                }
                
                
               // document.getElementById("ctl00_MyCPH1_txtPaymentAmt").value=totbal;
                document.getElementById("ctl00_MyCPH1_txtBalanceAmt").value=totbal;
                document.getElementById("ctl00_MyCPH1_txtContractAmt").value=totcon;
                document.getElementById("ctl00_MyCPH1_txtOtherAmt").value=tototh;
                document.getElementById("ctl00_MyCPH1_txtTDSAmt").value=totded;
                document.getElementById("ctl00_MyCPH1_tototherdecuction").value=total_deduction;
                
                
    return false;
    }
    
   function check(txtAdvanceAmtPaid,txtBalanceAmt,cboModeOfTransaction,cboPaymentAccount,txtChequeNo,txtChequeDate,txtPaymentAmt)
    {   
    //alert("Dax u r Great")
       //  var grid=document.getElementById("ctl00_MyCPH1_gvrunsheet");
       // var totdkt=grid.rows;
                      //  alert(totdkt)
                     //   return false;
                        
                          Frmnae="ctl00$MyCPH1$"
                           var server_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
                           
	                        //alert(document.getElementById(Frmnae+"TxtCBSDT").value)
                            // return false;
				            if(document.getElementById(Frmnae+"txtVoucherDate").value=="")
				            {
				              alert("Please enter the Financial Close Date")
				              document.getElementById(Frmnae+"txtVoucherDate").focus();
				              return false;
				            }
//						  if (ValidateForm(document.getElementById(Frmnae+"txtVoucherDate"))==false)
//				            {
//					            document.getElementById(Frmnae+"txtVoucherDate").focus();
//					            return  false ;
//				            }
				        	var dt =document.getElementById(Frmnae+"txtVoucherDate").value
				
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
				
				
				///****************for adv date validation******************
				start_date="01/01/2006"
				var start_date_dd=start_date.substring(0,2)
				var start_date_mm=start_date.substring(3,5)
				var start_date_yy=start_date.substring(6,10)
				start_date=new Date(months[parseFloat(start_date_mm)] + " " + parseFloat(start_date_dd) + ", " + parseFloat(start_date_yy))
	           // alert(totdkt)
			   var m_advdt=""
				 for(i=0;i<totdkt;i++)
                 {
                   j=i+2
                    var pref=""; 
                    if(j<10)
                        pref = "ctl00_MyCPH1_gvrunsheet_ctl0" + j + "_";
                    else
                        pref = "ctl00_MyCPH1_gvrunsheet_ctl" + j + "_";
                 
                
                          //  var conamt=document.getElementById(pref + "advdt");
                            var advdt =document.getElementById(pref + "advdt").value
				          //  alert(advdt)
				            var advdt_dd=advdt.substring(0,2)
				            var advdt_mm=advdt.substring(3,5)
				            var advdt_yy=advdt.substring(6,10)

		                   advance_date=new Date(months[parseFloat(advdt_mm)] + " " + parseFloat(advdt_dd) + ", " + parseFloat(advdt_yy))
				    
				            if(advance_date > start_date)
				            {
				             m_advdt=advance_date
				            }
				          start_date=advance_date
                 }
               //  alert(m_advdt)
				//******************************************************************
				
				
				var Fromdate_dd=Fromdate.substring(0,2)
				var Fromdate_mm=Fromdate.substring(3,5)
				var Fromdate_yy=Fromdate.substring(6,10)
				Fromdate1=new Date(months[parseFloat(Fromdate_mm)] + " " + parseFloat(Fromdate_dd) + ", " + parseFloat(Fromdate_yy))
				
				var Todate_dd=Todate.substring(0,2)
				var Todate_mm=Todate.substring(3,5)
				var Todate_yy=Todate.substring(6,10)
				Todate1=new Date(months[parseFloat(Todate_mm)] + " " + parseFloat(Todate_dd) + ", " + parseFloat(Todate_yy))
              
                if (dt>Todate1 || dt<Fromdate1)
				                {
						                alert( "Financial Close Date Should Be Between  "+ Fromdate +" to "+ Todate +" !!!")
						                document.getElementById(Frmnae+"txtVoucherDate").focus();
						                return false;
				                }
                		
				                if (dt>server_dt)
				                {
						                alert( "Financial Close Date should not be greater than today's date !!!")
						                document.getElementById(Frmnae+"txtVoucherDate").focus();
						                return false;
				                }
				                if (dt<m_advdt)
				                {
						                alert( "Financial Close Date should not be greater than Advance date !!!")
						                document.getElementById(Frmnae+"txtVoucherDate").focus();
						                return false;
				                }
				
                 k=parseFloat(totdkt)+2
                if(k < 10)
                {
                
                    Form_name1 = "ctl00$MyCPH1$gvrunsheet$ctl" + "0" + k + "$"
                  
                }
                else
                {
                    Form_name1 = "ctl00$MyCPH1$gvrunsheet$ctl" + k + "$"
                    
                }
               
                // alert(document.getElementById(Form_name1+"TotalNetamt").value)
                 
                if (parseFloat(document.getElementById(Form_name1+"TotalNetPay").value)>0)
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
		               // alert(cboPaymentAccount.value)
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
        			        
			            if(parseFloat(txtPaymentAmt.value)!=parseFloat(document.getElementById(Form_name1+"TotalNetPay").value))
			                {
					        alert("Cheque  Amount should be equal to Payment amount!!!")
					        txtPaymentAmt.focus();
					        return false;
			                }
		    }
	
			        
		}        
//		        
//	        
//        

     for(i=0;i<totdkt;i++)
        {
        j=i+2
            var pref=""; 
            if(j<10)
                pref = "ctl00_MyCPH1_gvrunsheet_ctl0" + j + "_";
            else
                pref = "ctl00_MyCPH1_gvrunsheet_ctl" + j + "_";
                
           document.getElementById(pref + "indpcamt").disabled=false;
            document.getElementById(pref + "indothamt").disabled=false;
            
            document.getElementById(pref + "indtds_rate").disabled=false;
            
           document.getElementById(pref + "indtdsded").disabled=false;
           document.getElementById(pref + "indadvamt").disabled=false;
          document.getElementById(pref + "indnetpay").disabled=false;
            document.getElementById(pref + "indoth_ded_amt").disabled=false; 
      }
 document.getElementById(frm_name+"txtCashAmount").disabled=false
         document.getElementById(frm_name+"txtPaymentAmt").disabled=false
//     alert("Dax u r Great")
//			 return false;
//alert("Hello")
//         return false;
return true
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
  function validFloat(event,txtid)
{
    var tb=document.getElementById(txtid);
    var txt=tb.value;
    if(event.keyCode==13)
        return true;
        
         if(event.keyCode==46)
          if(txt.indexOf('.')!=-1)
            event.keyCode=0;
        
    if((event.keyCode<46 || event.keyCode>57) || event.keyCode==47)
        {event.keyCode=0;return false;}
}
    </script>

    <br />
    <div align="left">
        <table border="0" style="width: 9.5in" bgcolor="#808080" cellpadding="2" cellspacing="1"
            class="boxbg">
            <tr bgcolor="#FFFFFF">
                <td align="center" colspan="4">
                    <font face="verdana" size="3"><b>Run Sheet </b></font></td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td align="left" style="width: 2in" class="blackfnt">Voucher Date</td>
                <td align="left" class="bluefnt">
                        <asp:TextBox ID="txtVoucherDate" runat="server" Width="60px" Enabled="true" Columns="8"></asp:TextBox>
                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtVoucherDate,'anchor1','dd/MM/yyyy'); return false;" name="anchor1" id="a1">
                            <img alt="" src="../../../../images/calendar.jpg" border="0" />
                        </a> [ dd/mm/yyyy ] 
                </td>
                 <td align="left" style="width: 2in" class="blackfnt">Manual Voucher NO.</td>
                <td align="left" class="bluefnt">
                        <asp:TextBox ID="Manualvoucherno" runat="server" Width="60px" Columns="12" onblur="javascript:this.value=this.value.toUpperCase()"  ></asp:TextBox>
                         
                </td>
            </tr>
        </table>
        <table border="0" style="width: 9.5in" bgcolor="#808080" cellpadding="2" cellspacing="1"
            class="boxbg">
            <tr bgcolor="#FFFFFF">
                <td colspan="2" valign="top" style="width: 53%">
                    <table border="1" width="100%">
                        <tr>
                            <td align="left" style="width: 160px" class="blackfnt">
                                Standard Contract Amount</td>
                            <td align="left" style="width: 13px" class="bluefnt">
                                <asp:Label ID="lblStandardAmt" style="text-align:right;" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 160px" class="blackfnt">
                                Contract Amount (+)</td>
                            <td align="left" style="width: 13px" class="blackfnt">
                                <asp:TextBox ID="txtContractAmt" onkeypress="javascript:validFloat(event,this.getAtr)" style="text-align:right;" runat="server"  Width="70px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 160px" class="blackfnt">
                                Other Amount</td>
                            <td align="left" style="width: 13px" class="blackfnt">
                                <asp:TextBox ID="txtOtherAmt" style="text-align:right;" runat="server"  Width="70px"></asp:TextBox></td>
                        </tr>
                         <tr>
                            <td align="left" style="width: 160px" class="blackfnt">
                                Other Deduction</td>
                            <td align="left" style="width: 13px" class="blackfnt">
                                <asp:TextBox ID="tototherdecuction" Enabled="false" style="text-align:right;" runat="server"  Width="70px"></asp:TextBox></td>
                        </tr>
                    </table>
                </td>
                <td colspan="2" width="50%" valign="top">
                    <table border="1" width="100%">
                     <tr>
                            <td align="left" style="width: 160px" class="blackfnt">
                                TDS Amount (-)</td>
                            <td align="left" style="width: 13px" class="blackfnt">
                                <asp:TextBox ID="txtTDSAmt" style="text-align:right;" runat="server" Width="70px"></asp:TextBox></td>
                        </tr>
                       <%-- <tr>
                            <td align="left">
                                <font class="blackfnt">Advance Amount Paid by</font></td>
                            <td align="left" class="blackfnt">
                                <asp:TextBox ID="txtAdvanceAmtPaidBy" runat="server"  Width="136px"></asp:TextBox>
                            </td>
                        </tr>--%>
                      <%--  <tr>
                            <td align="left">
                                <font class="blackfnt">TDS type</font></td>
                            <td align="left">
                                <font class="blackfnt">
                                    <asp:DropDownList ID="cboTDSType" runat="server" Mode="Conditional" RenderMode="Inline"
                                        Width="152px">
                                     
                                    </asp:DropDownList>
                                </font>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" bgcolor="#FFFFFF">
                                <font class="blackfnt">TDS Deducted For</font></td>
                            <td align="left" bgcolor="#FFFFFF">
                                <asp:DropDownList ID="cboTDSDeducted" runat="server" Mode="Conditional" RenderMode="Inline"
                                    Width="152px">
                                    <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Corporate" Value="C"></asp:ListItem>
                                    <asp:ListItem Text="NonCorporate" Value="NC"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>--%>
                        <tr>
                            <td align="left" class="blackfnt">
                                Advance Paid
                            </td>
                            <td align="left" class="blackfnt">
                                <asp:TextBox ID="txtAdvanceAmtPaid" style="text-align:right;" runat="server" Width="70px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="blackfnt">
                                <b>Balance Amount</b></td>
                            <td align="left" bgcolor="#FFFFFF" class="blackfnt">
                                <asp:TextBox ID="txtBalanceAmt" style="text-align:right;" runat="server" Width="70px" EnableViewState="true"></asp:TextBox>
                            </td>
                        </tr>
                       <%-- <tr>
                            <td align="left" class="blackfnt">
                                <b>Balance Payable at</b></td>
                            <td align="left" bgcolor="#FFFFFF" class="blackfnt">
                                <asp:TextBox ID="txtBalancePayableAt"  runat="server" Width="70px"></asp:TextBox>
                            </td>
                        </tr>--%>
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
            <asp:GridView ID="gvrunsheet" runat="server" BorderWidth="0" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey"
                AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left"
                CssClass="boxbg" FooterStyle-CssClass="bgbluegrey" ShowFooter="True" PagerSettings-Mode="NumericFirstLast"
                AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                EmptyDataText="No Records Found..." Style="width: 9.5in" OnRowDataBound="gvrunsheet_RowDataBound">
                <Columns>
                    <asp:TemplateField HeaderText="SRNo.">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" BackColor="White" />
                        <ItemTemplate>
                            <asp:Label ID="lblSRNo" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="DocumentNo" CssClass="blackfnt" Text="DocumentNo" runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemStyle CssClass="blackfnt" BackColor="White" />
                        <ItemTemplate>
                            <asp:Label ID="thcno" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"dockno") %>'></asp:Label>
                            <asp:HiddenField id="advdt"  runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"adv_voucherdt") %>' />
                            
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblcontractAmt" Style="text-align: center" CssClass="blackfnt" Text="Contract Amount (+)"
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemStyle CssClass="blackfnt" BackColor="White" />
                        <ItemTemplate>
                            <asp:TextBox ID="indpcamt" onblur="javascript:return calculateBalance()" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" style="text-align:right;" runat="server"  MaxLength="10" Columns="6"
                                Enabled="false" Text='<%# DataBinder.Eval(Container.DataItem,"PCAMT") %>'></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblOtherAmt" Style="text-align: center" CssClass="blackfnt" Text="Other Amount(+) "
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemStyle CssClass="blackfnt" BackColor="White" />
                        <ItemTemplate>
                            <asp:TextBox ID="indothamt" onblur="javascript:return calculateBalance()" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" style="text-align:right;" MaxLength="10" Columns="6"  runat="server"
                               Text='<%# DataBinder.Eval(Container.DataItem,"OTHCHRG") %>'></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblOther_ded_Amt" Style="text-align: center" CssClass="blackfnt" Text="Other Deduction(-) "
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemStyle CssClass="blackfnt" BackColor="White" />
                        <ItemTemplate>
                            <asp:TextBox ID="indoth_ded_amt" onblur="javascript:return calculateBalance()" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" style="text-align:right;" MaxLength="10" Columns="6"  runat="server"
                              Enabled="true"   Text='0.00'></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblTDSRate" Style="text-align: center" CssClass="blackfnt" Text="TDS Rate"
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemStyle CssClass="blackfnt" BackColor="White" />
                        <ItemTemplate>
                            <asp:TextBox ID="indtds_rate" onblur="javascript:return calculateBalance()" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" style="text-align:right;" MaxLength="10"  Columns="6" runat="server"
                              Enabled="false"   Text='<%# DataBinder.Eval(Container.DataItem,"tds_rate") %>'></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblTDSdeduction" Style="text-align: center" CssClass="blackfnt" Text="TDS Dedn.(-)"
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemStyle CssClass="blackfnt" BackColor="White" />
                        <ItemTemplate>
                            <asp:TextBox ID="indtdsded" onblur="javascript:return calculateBalance()"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))" style="text-align:right;" MaxLength="10"  Columns="6" runat="server"
                               Enabled="false"  Text='<%# DataBinder.Eval(Container.DataItem,"tdsded") %>'></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblAdvamt" Style="text-align: center" CssClass="blackfnt" Text=" Advance Amt. (-)"
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemStyle CssClass="blackfnt" BackColor="White" />
                        <ItemTemplate>
                            <asp:TextBox ID="indadvamt" onblur="javascript:return calculateBalance()" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" style="text-align:right;"  MaxLength="10"  Columns="6" runat="server"
                              Enabled="false"   Text='<%# DataBinder.Eval(Container.DataItem,"ADVAMT") %>'></asp:TextBox>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="TotalNetamt" style="text-align:right;" Font-Bold="true" Enabled="false" runat="server"  Text="0.00"
                             Columns="6"></asp:TextBox>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblNetPayable" Style="text-align: right" CssClass="blackfnt" Text="Net Balance Amt."
                               Enabled="true"  runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemStyle CssClass="blackfnt" BackColor="White" />
                        <ItemTemplate>
                            <asp:TextBox ID="indnetpay" Enabled="false"  onblur="javascript:return calculateBalance()" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" style="text-align:right;"  MaxLength="10" Columns="6" runat="server"></asp:TextBox>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="TotalNetPay" style="text-align:right;" Enabled="false" Font-Bold="true" runat="server"  Text="0.00"
                                Columns="6"></asp:TextBox>
                                
                        </FooterTemplate>
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
                    <asp:DropDownList ID="cboModeOfTransaction"  onchange="javascript:cash_N_bank(this)" runat="server" Width="60px" AutoPostBack="true" OnSelectedIndexChanged="cboModeOfTransaction_SelectedIndexChanged">
                        <asp:ListItem Text="Select" Value=""></asp:ListItem>
                        <asp:ListItem Text="Cash" Value="Cash"></asp:ListItem>
                        <asp:ListItem Text="Cheque" Value="Cheque"> </asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td align="left">
                    <font class="blackfnt">Payment Account</font>
                </td>
                <td align="left">
                    <font class="blackfnt">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:DropDownList ID="cboPaymentAccount" AutoPostBack="true" runat="server" Width="152px">
                                    <asp:ListItem>--Select--</asp:ListItem>
                                </asp:DropDownList>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="cboModeOfTransaction" EventName="SelectedIndexChanged" />
                            </Triggers>
                        </asp:UpdatePanel>
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
                <td align="left" class="blackfnt">Cheque Date </td>
                <td align="left" class="blackfnt">
                        <asp:TextBox ID="txtChequeDate" runat="server" Width="70px" onblur="javascript:return dateBlur(this,'Cheque')"></asp:TextBox>
                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtChequeDate,'anchor2','dd/MM/yyyy'); return false;" name="anchor2" id="anchor2">
                                <img alt="" src="../../../../images/calendar.jpg" border="0" />
                        </a> [ dd/mm/yyyy ]
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="left" class="blackfnt">Payment Amount</td>
                <td align="left" class="blackfnt">
                        <asp:TextBox ID="txtPaymentAmt" style="text-align:right;" Enabled="false" runat="server"  Width="70px"></asp:TextBox>
                </td>
                <td align="left" class="blackfnt">Cash Amount</td>
                <td align="left" class="blackfnt">
                        <asp:TextBox ID="txtCashAmount" style="text-align:right;" Enabled="false" runat="server" Width="70px"></asp:TextBox>
                </td>
            </tr>
        </table>
        <br />
        <table cellspacing="1" class="boxbg" style="width:9.5in;">
             <tr class="bgbluegrey">
                <td align="center" class="blackfnt">
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="blackfnt" OnClick="btnSubmit_Click" />
                </td>
            </tr>
        </table>
    </div>
   <script language="javascript" type="text/javascript">
          var rows="<%=rows%>";
            window.load=calculateBalance()
             document.getElementById(frm_name + "txtCashAmount").value=  document.getElementById("ctl00_MyCPH1_txtBalanceAmt").value
   </script>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;z-index: 99;"></div>
</asp:Content>
