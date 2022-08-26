<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MyReceiptControlDS.ascx.cs" Inherits="UserControls_MyReceiptControlDS" %>
 <script language="javascript" type="text/javascript">
  
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
	
	var UC_FRM_NM="ctl00_MyCPH1_UCMyReceiptControls_"
	function CheckCashBank()
	{
	     var txtNetPay =  document.getElementById(UC_FRM_NM+"txtNetPay");
	    var txtCashAmt = document.getElementById(UC_FRM_NM+"txtCashAmt");
	    var ddlPayMode = document.getElementById(UC_FRM_NM+"ddlPayMode");
	    var txtChqAmt = document.getElementById(UC_FRM_NM+"txtChqAmt");
	    var temp;
	    
	    if(document.getElementById(UC_FRM_NM+'ddlPayMode').value == "Cash")
	    {
	        if(document.getElementById(UC_FRM_NM+'txtCashAmt').value !=  document.getElementById(UC_FRM_NM+'txtNetPay').value)
            {
                alert("Cash Amount must be equal Net Payable Amount");
                document.getElementById(UC_FRM_NM+'txtCashAmt').focus();
                document.getElementById(UC_FRM_NM+'txtCashAmt').value = "0.00";
                return false;
            }
         }
         else if(document.getElementById(UC_FRM_NM+'ddlPayMode').value == "Bank")
         {
            if(document.getElementById(UC_FRM_NM+'txtChqAmt').value !=  document.getElementById(UC_FRM_NM+'txtNetPay').value)
            {
                alert("Cash Amount must be equal Net Payable Amount");
                document.getElementById(UC_FRM_NM+'txtChqAmt').focus();
                document.getElementById(UC_FRM_NM+'txtChqAmt').value = "0.00";
                return false;
            }
         }
         else if(document.getElementById(UC_FRM_NM+'ddlPayMode').value == "Both")
         {
            
            if(document.getElementById(UC_FRM_NM+'txtCashAmt').value == 0.00 || document.getElementById(UC_FRM_NM+'txtCashAmt').value == "")
            {
                if(Number(document.getElementById(UC_FRM_NM+'txtChqAmt').value) > Number(document.getElementById(UC_FRM_NM+'txtNetPay').value))
                {
                    alert("Cash Amount and Cheque Amount MUST be equal to Net payable");
                    document.getElementById(UC_FRM_NM+'txtChqAmt').focus();
                    return false;
                }
            }
            else if (document.getElementById(UC_FRM_NM+'txtChqAmt').value == 0.00 || document.getElementById(UC_FRM_NM+'txtChqAmt').value == "")
            {
                if(Number(document.getElementById(UC_FRM_NM+'txtCashAmt').value) > Number(document.getElementById(UC_FRM_NM+'txtNetPay').value))
                {
                    alert("Cash Amount and Cheque Amount MUST be equal to Net payable");
                    document.getElementById(UC_FRM_NM+'txtCashAmt').focus();
                    document.getElementById(UC_FRM_NM+'txtCashAmt').value = "0.00";
                    document.getElementById(UC_FRM_NM+'txtChqAmt').value = "0.00";
                    return false;
                }
            }
            else
            {
                temp = parseFloat(Number(document.getElementById(UC_FRM_NM+'txtCashAmt').value) + Number(document.getElementById(UC_FRM_NM+'txtChqAmt').value));
                if(temp !=  document.getElementById(UC_FRM_NM+'txtNetPay').value)
                {
                    alert("Cash Amount and Cheque Amount MUST be equal to Net payable");
                    document.getElementById(UC_FRM_NM+'txtCashAmt').value = "0.00";
                    document.getElementById(UC_FRM_NM+'txtChqAmt').value = "0.00";
                    return false;
                }
            }
            }
	}
	
	function CheckCashBank_Receipt()
	{
	    //alert("hi...12")
	    var txtNetPay =  document.getElementById(UC_FRM_NM+"txtNetPay");
	    var txtCashAmt = document.getElementById(UC_FRM_NM+"txtCashAmt");
	    var ddlPayMode = document.getElementById(UC_FRM_NM+"ddlPayMode");
	    var txtChqAmt = document.getElementById(UC_FRM_NM+"txtChqAmt");
	    var temp;
	    //alert("hi...1")
	    //alert(document.getElementById(UC_FRM_NM+'ddlPayMode').value)
	    if(document.getElementById(UC_FRM_NM+'ddlPayMode').value == "Cash")
	    {
	        //alert("hi...1..i")
	        if(document.getElementById(UC_FRM_NM+'txtCashAmt').value !=  document.getElementById(UC_FRM_NM+'txtNetPay').value)
            {
                alert("Cash Amount must be equal Net Payable Amount");
                document.getElementById(UC_FRM_NM+'txtCashAmt').focus();
                document.getElementById(UC_FRM_NM+'txtCashAmt').value = "0.00";
                return false;
            }
         }
         else if(document.getElementById(UC_FRM_NM+'ddlPayMode').value == "Bank")
         {
            if(document.getElementById(UC_FRM_NM+'txtChqAmt').value !=  document.getElementById(UC_FRM_NM+'txtNetPay').value)
            {
                //alert("Cheque Amount must be equal Net Payable Amount");
                //document.getElementById(UC_FRM_NM+'txtChqAmt').focus();
                chqAmt=document.getElementById(UC_FRM_NM+'txtChqAmt').value ;
                OnAccountAmt=document.getElementById(UC_FRM_NM+'Txt_OnAccount_Balance').value ;
                ColAmt=document.getElementById(UC_FRM_NM+'Txt_ColAmt').value ;
                if(parseFloat(OnAccountAmt)>0)
                {
                    if(parseFloat(OnAccountAmt)<parseFloat(ColAmt))
                    {
                        alert("Collection Amount  must be equal To Or Less then  On Account Balance Amount");
                        return false;
                    }
                   
                }
                else if(parseFloat(chqAmt)<parseFloat(ColAmt))
                    {
                        alert("Cheque Amount  must be equal To Or Less then  On Account Balance Amount");
                        return false;
                    }
               
               // return false;
               
               
            }
         }
         else if(document.getElementById(UC_FRM_NM+'ddlPayMode').value == "Both")
         {
             //alert("hi...2")
            if(document.getElementById(UC_FRM_NM+'txtCashAmt').value == 0.00 || document.getElementById(UC_FRM_NM+'txtCashAmt').value == "")
            {
                if(Number(document.getElementById(UC_FRM_NM+'txtChqAmt').value) > Number(document.getElementById(UC_FRM_NM+'txtNetPay').value))
                {
                    alert("Cash Amount and Cheque Amount MUST be equal to Net payable");
                    document.getElementById(UC_FRM_NM+'txtChqAmt').focus();
                    document.getElementById(UC_FRM_NM+'txtChqAmt').value = "0.00";
                    return false;
                }
            }
            else if (document.getElementById(UC_FRM_NM+'txtChqAmt').value == 0.00 || document.getElementById(UC_FRM_NM+'txtChqAmt').value == "")
            {
                //alert("hi...3")
                if(Number(document.getElementById(UC_FRM_NM+'txtCashAmt').value) > Number(document.getElementById(UC_FRM_NM+'txtNetPay').value))
                {
                    alert("Cash Amount and Cheque Amount MUST be equal to Net payable");
                    document.getElementById(UC_FRM_NM+'txtCashAmt').focus();
                    document.getElementById(UC_FRM_NM+'txtCashAmt').value = "0.00";
                    return false;
                }
            }
            else
            {
                //alert("hi...4")
                temp = parseFloat(Number(document.getElementById(UC_FRM_NM+'txtCashAmt').value) + Number(document.getElementById(UC_FRM_NM+'txtChqAmt').value));
                if(temp !=  document.getElementById(UC_FRM_NM+'txtNetPay').value)
                {
                    alert("Cash Amount and Cheque Amount MUST be equal to Net payable");
                    document.getElementById(UC_FRM_NM+'txtCashAmt').value = "0.00";
                    document.getElementById(UC_FRM_NM+'txtChqAmt').value = "0.00";
                    return false;
                }
            }
            }
            
	}
	
	function CheckData_Receipt()
	{
	
	    var txtNetPay =  document.getElementById("ctl00_MyCPH1_UCMyReceiptControl1_txtNetPay");
        var ddlPayMode = document.getElementById("ctl00_MyCPH1_UCMyReceiptControl1_ddlPayMode");
        var txtCashAmt = document.getElementById("ctl00_MyCPH1_UCMyReceiptControl1_txtCashAmt");
        var txtChqAmt = document.getElementById("ctl00_MyCPH1_UCMyReceiptControl1_txtChqAmt");
        var txtChqNo = document.getElementById("ctl00_MyCPH1_UCMyReceiptControl1_txtChqNo");
        var txtAcc = document.getElementById("ctl00_MyCPH1_UCMyReceiptControl1_txtAcc");
        var txtBank = document.getElementById("ctl00_MyCPH1_UCMyReceiptControl1_txtBank");
        var txtChqDate = document.getElementById("ctl00_MyCPH1_UCMyReceiptControl1_txtChqDate");
        var ddrCashcode = document.getElementById("ctl00_MyCPH1_UCMyReceiptControl1_ddrCashcode");
        var ddrBankaccode = document.getElementById("ctl00_MyCPH1_UCMyReceiptControl1_ddrBankaccode");
	
	
	  if(ddlPayMode.value == "-1")
        {
            alert("Please Enter Receipt Mode");
            return false;
        }
         if(ddlPayMode.value == "Cash" || ddlPayMode.value == "Both" )
        {
            if(ddrCashcode.value == "")
            {
                alert("Please Select Cash Account");
                return false;
            }
            if(txtCashAmt.value == "")
            {
                 alert("Please Enter Cash Amount");
                return false;
            }
            
       }
        if(ddlPayMode.value == "Bank" || ddlPayMode.value == "Both" )
        {
            var Diposited_0 = document.getElementById("ctl00_MyCPH1_UCMyReceiptControl1_rdDiposited_0");
            var txtRecBank = document.getElementById("ctl00_MyCPH1_UCMyReceiptControl1_txtRecBank");
              if(Diposited_0.checked)
	         {
                if(ddrBankaccode.value == "")
                {
                    alert("Please Select Bank Account");
                    return false;
                }
            }
            else
            {
            
                if(txtRecBank.value == "")
                {
                    alert("Please Enter Bank Name");
                    return false;
                }
            }
            
            if(txtChqAmt.value == "")
            {
                alert("Please Enter Cheque Amount");
                return false;
            }
            
             if(txtChqNo.value == "")
            {
                alert("Please Enter Cheque Number");
                return false;
            }
             if(txtChqDate.value == "")
            {
                alert("Please Enter Cheque Date");
                return false;
            }
       }
       
       if(ddlPayMode.value == "Cash" && document.getElementById("ctl00_MyCPH1_UCMyReceiptControl1_Onaccount").checked )
        {
                 alert("IF Cheque Is On Account- Can not Select Payment Mode as Cash");
                return false;
        
        }
	return true;
	}
	
	function bankEnable_ondeposit()
 {
 
       var Diposited_0 = document.getElementById("ctl00_MyCPH1_UCMyReceiptControl1_rdDiposited_0");
       var Bankaccode = document.getElementById("ctl00_MyCPH1_UCMyReceiptControl1_ddrBankaccode");
       var ddlPayMode = document.getElementById("ctl00_MyCPH1_UCMyReceiptControl1_ddlPayMode");
       var RecBank = document.getElementById("ctl00_MyCPH1_UCMyReceiptControl1_txtRecBank");
       
     	 if(ddlPayMode.value == "Bank" || ddlPayMode.value == "Both" )
        {
	       if(Diposited_0.checked)
	       {
	        Bankaccode.disabled=false
	        RecBank.disabled=true
	       }
	       else
	       {
	         Bankaccode.disabled=true
	         RecBank.disabled=false
	       }
	   }
 }
	
	function CheckData()
	{
	   if(document.getElementById(UC_FRM_NM+'ddlPayMode').value == "-1")
        {
            alert("Please Enter Payment Mode");
            document.getElementById(UC_FRM_NM+'ddlPayMode').focus();
            return false;
        }
        if(document.getElementById(UC_FRM_NM+'ddlPayMode').value == "Cash" || document.getElementById(UC_FRM_NM+'ddlPayMode').value == "Both" )
        {
            if(document.getElementById(UC_FRM_NM+'ddrCashcode').value == "")
            {
                alert("Please Select Cash Account");
                document.getElementById(UC_FRM_NM+'ddrCashcode').focus();
                return false;
            }
            if(document.getElementById(UC_FRM_NM+'txtCashAmt').value == "")
            {
                 alert("Please Enter Cash Amount");
                 //document.getElementById(UC_FRM_NM+'txtCashAmt').focus();
                return false;
            }
            
       }
        
       if(document.getElementById(UC_FRM_NM+'ddlPayMode').value == "Bank" || document.getElementById(UC_FRM_NM+'ddlPayMode').value == "Both" )
        {
            if(document.getElementById(UC_FRM_NM+'ddrBankaccode').value == "")
            {
                alert("Please Select Bank Account");
                document.getElementById(UC_FRM_NM+'ddrBankaccode').focus();
                return false;
            }
            if(document.getElementById(UC_FRM_NM+'txtChqAmt').value == "")
            {
                alert("Please Enter Cheque Amount");
                //document.getElementById(UC_FRM_NM+'txtChqAmt').focus();
                return false;
            }
            if(document.getElementById(UC_FRM_NM+'txtChqNo').value == "")
            {
                alert("Please Enter Cheque Number");
                document.getElementById(UC_FRM_NM+'txtChqNo').focus();
                return false;
            }
           
            if(document.getElementById(UC_FRM_NM+'txtChqDate').value == "")
            {
                alert("Please Enter Cheque Date");
                document.getElementById(UC_FRM_NM+'txtChqDate').focus();
                return false;
            }
       }
       
       if(document.getElementById(UC_FRM_NM+'ddlPayMode').value == "Both" )
       {
               
                if(parseFloat(document.getElementById(UC_FRM_NM+'txtCashAmt').value)+parseFloat(document.getElementById(UC_FRM_NM+'txtChqAmt').value) != parseFloat(document.getElementById(UC_FRM_NM+'txtNetPay').value))
                {
                    alert("Cash Amount and Cheque Amount MUST be equal to Net payable");
                    document.getElementById(UC_FRM_NM+'txtCashAmt').value = "0.00";
                    document.getElementById(UC_FRM_NM+'txtChqAmt').value = "0.00";
                    return false;
                }
       }
       if(document.getElementById(UC_FRM_NM+'ddlPayMode').value == "Cash" )
       {
               
                if(parseFloat(document.getElementById(UC_FRM_NM+'txtCashAmt').value) != parseFloat(document.getElementById(UC_FRM_NM+'txtNetPay').value))
                {
                    alert("Cash Amount MUST be equal to Net payable");
                    document.getElementById(UC_FRM_NM+'txtCashAmt').value = "0.00";
                    return false;
                }
       }
       if(document.getElementById(UC_FRM_NM+'ddlPayMode').value == "Bank" )
       {
               
                if(parseFloat(document.getElementById(UC_FRM_NM+'txtChqAmt').value) != parseFloat(document.getElementById(UC_FRM_NM+'txtNetPay').value))
                {
                    alert("Cheque Amount MUST be equal to Net payable");
                    document.getElementById(UC_FRM_NM+'txtChqAmt').value = "0.00";
                    return false;
                }
       }
       
       return true;
	}
	 function bankEnable_ondeposit()
 {
 
       var Diposited_0 = document.getElementById(UC_FRM_NM+"rdDiposited_0");
       var Bankaccode = document.getElementById(UC_FRM_NM+"ddrBankaccode");
       var ddlPayMode = document.getElementById(UC_FRM_NM+"ddlPayMode");
       var RecBank = document.getElementById(UC_FRM_NM+"txtRecBank");
       
     	 if(ddlPayMode.value == "Bank" || ddlPayMode.value == "Both" )
        {
	       if(Diposited_0.checked)
	       {
	        Bankaccode.disabled=false
	       // RecBank.disabled=true
	       }
	       else
	       {
	         Bankaccode.disabled=true
	         RecBank.disabled=false
	       }
	   }
 }
 var doc = null; 
var MyDiv = document.getElementById("ReportingToCombo");
	var formObj = null;

	function createXMLHTTPObject()
	{
	    if (window.XMLHttpRequest) { // Mozilla, Safari,...
	        doc = new XMLHttpRequest();
	        if (doc.overrideMimeType) 
	        {
	            doc.overrideMimeType('text/xml');
	        }
	    } else if (window.ActiveXObject) { // IE
	        try {
	            doc = new ActiveXObject("Msxml2.XMLHTTP");
	        } catch (e) {
	            try {
	                doc = new ActiveXObject("Microsoft.XMLHTTP");
	            } catch (e) {}
	        }
	    }
	}
 function OnBlurChqDetail()
	{
               
		            chqdate=document.getElementById(UC_FRM_NM+'txtChqDate').value
		            chqno=document.getElementById(UC_FRM_NM+'txtChqNo').value
		            transtype=document.getElementById(UC_FRM_NM+'ddlPayMode').value
		            Party_code=document.getElementById(UC_FRM_NM+'Hnd_Party').value
		            //alert("h....")
		             if(chqdate!=''&&chqno!=''&&transtype=='Bank')
		             {
		                     
		                    // alert(chqno)
		                    // alert(chqdate)
		                    // alert(Party_code)
				            createXMLHTTPObject();
				            arg=new Date();
				            if (doc)
				            { 
					            doc.onreadystatechange = doWork; 
					            doc.open("GET", "dyn_combo.aspx?Search=onacctmrchq&chqno=" + chqno + "&chqdate=" + chqdate + "&RandText="+arg+"&Party="+Party_code, false);
					            doc.send(null);
				            }	
                                
                                var val_arr=val.split('~')
                    			//alert(val)
                    			Flag=val_arr[6];
                    		    // alert(val_arr[6])
		                        if (Flag=="Y")
                    			{
                    			    if(val_arr[8]!="C")
		                           {
		                                        alert("Cheque IS Already Used For Vendor Payment Or Other Use.")
		                                        document.getElementById(UC_FRM_NM+'txtChqNo').value=""
		                                        document.getElementById(UC_FRM_NM+'txtChqDate').value=""
		                                        return false;
		                           }
		                           else if(document.getElementById(UC_FRM_NM+'Hnd_Party').value!=val_arr[9])
                    			   {
                    			                alert("Cheque IS Already Enterd for Another Party : " + val_arr[9])
		                                        document.getElementById(UC_FRM_NM+'txtChqNo').value=""
		                                        document.getElementById(UC_FRM_NM+'txtChqDate').value=""
		                                        return false;
		                           }
		                           else if(parseFloat(rounditn(val_arr[3],2))>0)
                    			    {
		                                if(parseFloat(document.getElementById(UC_FRM_NM+'Txt_ColAmt').value)>parseFloat(document.getElementById(UC_FRM_NM+'Txt_OnAccount_Balance').value))
		                                {
		                                    alert("ChqNo Has: "+ val_arr[0]+" ,Pending Amount as:  "+rounditn(val_arr[3],2)+" Which is Less then Collection Amount: " +document.getElementById(UC_FRM_NM+'Txt_ColAmt').value)
		                                    document.getElementById(UC_FRM_NM+'txtChqNo').value=""
		                                    document.getElementById(UC_FRM_NM+'txtChqDate').value=""
		                                    return false;
		                                }
		                               else
		                                {
		                                    document.getElementById(UC_FRM_NM+'txtChqNo').value=val_arr[0]
			                                document.getElementById(UC_FRM_NM+'txtChqDate').value=val_arr[1]
			                                document.getElementById(UC_FRM_NM+'txtChqAmt').value=val_arr[2]
		                                    document.getElementById(UC_FRM_NM+'Txt_OnAccount_Balance').value=rounditn(val_arr[3],2);    
		                                    document.getElementById(UC_FRM_NM+'txtRecBank').value=val_arr[4].toUpperCase();
		                                    document.getElementById(UC_FRM_NM+'Txt_BankBR').value=val_arr[5].toUpperCase();
		                                    document.getElementById(UC_FRM_NM+'Onaccount').checked=true
		                                    document.getElementById(UC_FRM_NM+"rdDiposited_0").disabled=true
		                                    document.getElementById(UC_FRM_NM+"rdDiposited_1").disabled=true
		                                    document.getElementById(UC_FRM_NM+'txtRecBank').disabled=true
		                                    document.getElementById(UC_FRM_NM+'Txt_BankBR').disabled=true
		                                    document.getElementById(UC_FRM_NM+'txtChqAmt').disabled=true
		                                }
		                            }
		                            else
		                            {
		                                    alert("ChqNo Has: " + val_arr[0]+ " NO Pending Amount ")
		                                    document.getElementById(UC_FRM_NM+'txtChqNo').value=""
		                                    document.getElementById(UC_FRM_NM+'txtChqDate').value=""
		                                    return false;
		                            }
		                        }
		                        else if (Flag=="N")
		                        {
		                            
		                            if(val_arr[7]=="B")
		                            {
		                                alert("Cheque IS Bounced User Can Use After Reoffer Only  OR The same Cheque IS not For this Party.")
		                                document.getElementById(UC_FRM_NM+'txtChqNo').value=""
		                                document.getElementById(UC_FRM_NM+'txtChqDate').value=""
		                                return false;
		                            }
		                        }
		                        else
		                        {
		                          
			                        document.getElementById(UC_FRM_NM+'txtChqAmt').disabled=false
		                            document.getElementById(UC_FRM_NM+'Txt_OnAccount_Balance').value="0.00"
		                            document.getElementById(UC_FRM_NM+'txtRecBank').value=""
		                            document.getElementById(UC_FRM_NM+'Txt_BankBR').value=""
		                            document.getElementById(UC_FRM_NM+'Onaccount').checked=false
		                            document.getElementById(UC_FRM_NM+"rdDiposited_0").disabled=false
		                            document.getElementById(UC_FRM_NM+"rdDiposited_1").disabled=false
		                            document.getElementById(UC_FRM_NM+'txtRecBank').disabled=false
		                            document.getElementById(UC_FRM_NM+'Txt_BankBR').disabled=false
		                         
		                        }
		            }
		 
	}
	function doWork() {
	    if (doc.readyState == 4) {
	             
	            val=doc.responseText
				 
	    }
	}	
 </script>
 
 
 <br>
 
 <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="90%">
                    <tr style="background-color: White">
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Receipt Mode
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:DropDownList ID="ddlPayMode" runat="server" Width="87px" AutoPostBack="True" CssClass="blackfnt"
                                OnSelectedIndexChanged="ddlPayMode_SelectedIndexChanged">
                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                <asp:ListItem>Cash</asp:ListItem>
                                <asp:ListItem>Bank</asp:ListItem> 
                                
                            </asp:DropDownList></td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Amount Applicable
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:TextBox ID="txtAmtApplA" runat="server" Text="0.00"  style="text-align:right"  BorderStyle="Groove" CssClass="blackfnt" Width="80px"  Enabled="false"></asp:TextBox></td><%--Enabled="False"--%>
                    </tr>
                    <tr style="background-color: White">
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Cash Amount
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:TextBox ID="txtCashAmt" Text="0.00"  style="text-align:right" runat="server"  onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"  BorderStyle="Groove" CssClass="blackfnt" Width="80px"  Enabled="false"></asp:TextBox></td><%--Enabled="False"--%>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Account
                        </td>
                        <td style="text-align: left" class="blackfnt"> 
                        &nbsp;<asp:DropDownList ID="ddrCashcode" runat="server"  >
                                
                            </asp:DropDownList>
                            &nbsp;</td>
                    </tr>
                    <tr style="background-color: White">
                     <td style="text-align: left" class="blackfnt">
                            &nbsp;Cheque No.
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:TextBox ID="txtChqNo" MaxLength="6" Columns="6" runat="server" BorderStyle="Groove" CssClass="blackfnt" Width="150px" Enabled="False" onblur="javascript:OnBlurChqDetail()" ></asp:TextBox></td>
                         <td class="blackfnt" style="text-align: left">
                            &nbsp;Cheque Date
                        </td>
                        <td class="blackfnt" style="text-align: left">
                            &nbsp;<asp:TextBox ID="txtChqDate" runat="server" onchange="javascript:ValidateDate(this)"
                            onblur="javascript:OnBlurChqDetail()" 
                                BorderStyle="Groove" CssClass="blackfnt" MaxLength="10" Width="80px"></asp:TextBox>
                      </td>

                       
                    </tr>
                    <tr style="background-color: White">
                     <td style="text-align: left" class="blackfnt">
                            &nbsp;Cheque Amount
                        </td>
                        
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:TextBox ID="txtChqAmt" runat="server"  Text="0.00"  style="text-align:right"   onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"  BorderStyle="Groove" CssClass="blackfnt" Width="80px"   ></asp:TextBox></td><%--Enabled="False"--%>
                         <td class="blackfnt" style="text-align: left">
                            &nbsp;On Account Balance
                        </td>
                    <td class="blackfnt" style="text-align: left">
                            &nbsp;<asp:TextBox ID="Txt_OnAccount_Balance" runat="server"  
                                BorderStyle="Groove" CssClass="blackfnt" MaxLength="10"  Text="0.00"  style="text-align:right" Width="80px" Enabled="false"></asp:TextBox>
                        </td>
                        
                    </tr>
                     <tr style="background-color: White">
                     <td style="text-align: left" class="blackfnt">
                            &nbsp;Collection Amt. From Cheque 
                        </td>
                        
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:TextBox ID="Txt_ColAmt" runat="server"  Text="0.00"  style="text-align:right"   Enabled="false" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"  BorderStyle="Groove" CssClass="blackfnt" Width="80px"   ></asp:TextBox></td><%--Enabled="False"--%>
                         <td  align="Left">                 
                                  <font class="blackfnt">Tds Type</font>  
                               </td>
                               <td  align="Left">                 
                                  <font class="redfnt"> <asp:DropDownList ID="DDL_Tdstype" runat="server" CssClass="blackfnt"></asp:DropDownList></font>  
                               </td>
                        
                    </tr>
                    <tr style="background-color: white">
                    <td style="text-align: left" class="blackfnt">
                            &nbsp;Direct Deposited In Bank</td>
                        <td style="text-align: left" class="blackfnt">
                        <asp:RadioButtonList ID="rdDiposited" runat="server" 
                                RepeatDirection="Horizontal" onclick="javacript:bankEnable_ondeposit()">
                                <asp:ListItem  Value="Y">Yes</asp:ListItem>
                                <asp:ListItem Value="N">No</asp:ListItem>
                            </asp:RadioButtonList>
                       </td>
                         <td style="text-align: left" class="blackfnt">
                            &nbsp;Deposited in Bank</td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:DropDownList ID="ddrBankaccode" runat="server"  >
                             </asp:DropDownList>
                       </td>                      
                       
                       
                    </tr>
                    <tr style="background-color: white">
                    <td class="blackfnt" style="text-align: left">
                            &nbsp;Received From Bank</td>
                         <td class="blackfnt" style="text-align: left">
                            &nbsp;<asp:TextBox ID="txtRecBank" runat="server" BorderStyle="Groove" CssClass="blackfnt" onblur="javascript:this.value=this.value.toUpperCase()"
                                Width="80px"></asp:TextBox></td>
                        <td class="blackfnt" style="text-align: left">
                            &nbsp;Bank Branch</td>
                        <td class="blackfnt" style="text-align: left">
                            &nbsp;<asp:TextBox ID="Txt_BankBR" runat="server" BorderStyle="Groove" CssClass="blackfnt" onblur="javascript:this.value=this.value.toUpperCase()"
                                Width="80px"></asp:TextBox></td>
                    </tr>
                    <tr style="background-color: White">
                        <td style="text-align: left" class="blackfnt">
                        On Account Yes/NO 
                        </td>
                        <td style="text-align: left" class="blackfnt">
                        <asp:CheckBox runat="server" ID="Onaccount"  /><%--onclick="javascript:GetTot()--%>
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            <strong>&nbsp;NET RECEIVED</strong></td>
                        <td style="text-align: left" class="blackfnt">
                            <asp:TextBox ID="txtNetPay" runat="server"  Text="0.00"  style="text-align:right" BorderStyle="Groove" CssClass="blackfnt" Width="80px"  Enabled="false"></asp:TextBox></td><%--Enabled="False"--%>
                            <asp:HiddenField ID="Hnd_Party" runat="server"  />
                    </tr>
                </table>
                
               <%-- <div id="Div1" style="position: absolute; visibility: hidden; background-color: white;layer-background-color: white; z-index: 99;">
    </div> --%>