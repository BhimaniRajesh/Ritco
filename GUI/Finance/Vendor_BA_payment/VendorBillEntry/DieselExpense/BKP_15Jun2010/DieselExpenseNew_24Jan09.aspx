<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="DieselExpenseNew.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_VendorBillEntry_DieselExpense_DieselExpenseNew" %>
<%--<%@ Register TagName="UCDP" TagPrefix="UCMyDP" Src="~/UserControls/DatePicker.ascx" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">


   <script language="javascript" type="text/javascript" src="../../../../images/commonJs.js"></script>
    <script language="javascript" type="text/javascript" src="../../../../images/CalendarPopup.js"></script>
 <script language="javascript" type="text/javascript">
    var cal = new CalendarPopup("Div1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
    </script>
    <script language="javascript" type="text/javascript">
   
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
    	
		    obj.focus()
		    return false
	    }
        return true
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
	
	
	function GetTot()
	{
	    var i,Amt,TotAmt,T=0;

            
            T=rounditn(document.getElementById('ctl00$MyCPH1$txtTotalExeAmt').value,2);
           // alert("T : " + T);
            TotAmt=rounditn(document.getElementById('ctl00$MyCPH1$txtTotalExeAmt').value,2);
            // alert("TotAmt : " + TotAmt);
            
            document.getElementById("ctl00_MyCPH1_txtAmtAppl").value=TotAmt;
            document.getElementById("ctl00_MyCPH1_txtAmtApplL").value=TotAmt;
            document.getElementById("ctl00_MyCPH1_txtNetPayableAmt").value=TotAmt;
            
            TotAmt= T;
        
        var AmtAppl = 0;
        AmtAppl = roundit(TotAmt,2);
        document.getElementById("ctl00_MyCPH1_txtAmtAppl").value=AmtAppl;
        if(document.getElementById("ctl00_MyCPH1_Svctax_yn").checked)
        {
            document.getElementById("ctl00_MyCPH1_txtServiceTax").value=rounditn((parseFloat(AmtAppl)*12/100),2);
            document.getElementById("ctl00_MyCPH1_txtEduCess").value=rounditn((parseFloat(document.getElementById("ctl00_MyCPH1_txtServiceTax").value)*2/100),2);
            document.getElementById("ctl00_MyCPH1_txtHEduCess").value=rounditn((parseFloat(document.getElementById("ctl00_MyCPH1_txtServiceTax").value)*1/100),2);
        }
        else
        {
            document.getElementById("ctl00_MyCPH1_txtServiceTax").value="0.00";
            document.getElementById("ctl00_MyCPH1_txtEduCess").value="0.00";
            document.getElementById("ctl00_MyCPH1_txtHEduCess").value="0.00";
        }
        
         document.getElementById("ctl00_MyCPH1_txtBillAmt").value=rounditn(parseFloat(Number(AmtAppl)),2)
         //document.getElementById("ctl00_MyCPH1_txtNetAmt").value=rounditn(parseFloat(Number(AmtAppl))-parseFloat(document.getElementById("ctl00_MyCPH1_txtOtherDedudction").value)- parseFloat(document.getElementById("ctl00_MyCPH1_txtDiscRecvd").value),2)
         document.getElementById("ctl00_MyCPH1_txtNetAmt").value=rounditn(parseFloat(Number(AmtAppl)),2)
        
        
        var TP = parseFloat(Number(AmtAppl)+ Number(document.getElementById("ctl00_MyCPH1_txtServiceTax").value) + Number(document.getElementById("ctl00_MyCPH1_txtEduCess").value) + Number(document.getElementById("ctl00_MyCPH1_txtHEduCess").value));
        var AmtApplL =0; 
        AmtApplL = roundit(TP,2);
         if(parseFloat(AmtApplL)<0)
        {
            AmtApplL="0.00"
        }
        document.getElementById("ctl00_MyCPH1_txtAmtApplL").value=AmtApplL;
        
        var txtTDSAmt= document.getElementById("ctl00_MyCPH1_txtTDSAmt").value;
        var txtTDSRate = document.getElementById("ctl00_MyCPH1_txtTDSRate").value;
        if(Number(txtTDSRate) > 100)
        {
            alert("TDS Rate Should not greater than 100%");
            document.getElementById("ctl00_MyCPH1_txtTDSRate").focus();
            document.getElementById("ctl00_MyCPH1_txtTDSRate").value = "0.0";
            return false;
        }
        if(document.getElementById("ctl00_MyCPH1_TDS_yn").checked)
        {
            txtTDSAmt = rounditn(Math.round(parseFloat((Number(AmtApplL)* Number(txtTDSRate))/Number(100)).toFixed(2)),2);
        
        }
        else
        {
            txtTDSAmt = "0.00";
            txtTDSRate = "0.0";
        }
        document.getElementById("ctl00_MyCPH1_txtTDSAmt").value=txtTDSAmt;
        document.getElementById("ctl00_MyCPH1_txtTDSRate").value=txtTDSRate;
        
        var txtNetPay = 0;
        //txtNetPay = rounditn(parseFloat(Number(AmtAppl) - Number(txtTDSAmt)+ Number(document.getElementById("ctl00_MyCPH1_txtServiceTax").value) + Number(document.getElementById("ctl00_MyCPH1_txtEduCess").value) + Number(document.getElementById("ctl00_MyCPH1_txtHEduCess").value)-parseFloat(document.getElementById("ctl00_MyCPH1_txtOtherDedudction").value)- parseFloat(document.getElementById("ctl00_MyCPH1_txtDiscRecvd").value)),2);
        txtNetPay = rounditn(parseFloat(Number(AmtAppl) - Number(txtTDSAmt)+ Number(document.getElementById("ctl00_MyCPH1_txtServiceTax").value) + Number(document.getElementById("ctl00_MyCPH1_txtEduCess").value) + Number(document.getElementById("ctl00_MyCPH1_txtHEduCess").value)),2);

        
        if(parseFloat(txtNetPay)<0)
        {
            txtNetPay="0.00"
        }
        document.getElementById("ctl00_MyCPH1_txtNetPayableAmt").value=txtNetPay;
        return false;
	}
	
	
	
	  function calculateBalance()
    {
           
            var grid1;
            var r1;
            
            

            
            
          
                grid1=document.getElementById("ctl00_MyCPH1_dgHSD_OIL_EXP");
                r1=grid1.rows.length;
                //alert(r1);
          
            
            
      
       var totadv="0.00",totamt="0.00";
      
      // var mtotadv="0.00",mtotamt="0.00";
      var totadv1="0.00",totamt1="0.00";
      
       
        for(i=0;i< r1-1;i++)
        {  
            j=i+2
            var pref="";
  
              if(j<10)
              {
              pref = "ctl00_MyCPH1_dgHSD_OIL_EXP_ctl0" + j + "_";
         
              
               }                                       
               else
                {         
             pref = "ctl00_MyCPH1_dgHSD_OIL_EXP_ctl" + j + "_";
           
                }    
                
                
                var diesel_qty=document.getElementById(pref + "txtDiesel_Ltr").value;
                var diesel_rate=document.getElementById(pref + "txtDieselRate_Ltr").value; 
                if (diesel_qty=="")
                {
                    diesel_qty="0";
                }
                 if (diesel_rate=="")
                {
                    diesel_rate="0";
                }
         
            var amt1= document.getElementById(pref + "txtAmt");
            //alert("amt1 : "+ amt1)
            //document.getElementById(pref + "txtAmt").innerText=amt1;
            
            // alert("amt1 val : "+ amt1.value)
            var EAmt1=document.getElementById(pref + "txtExeAmt");
         //alert(amt1);
         //alert(amt1.value);
    
    var amt1val=parseFloat(diesel_qty) * parseFloat(diesel_rate);
    document.getElementById(pref + "txtAmt").innerText=amt1val;
    //alert("amt1val : " + amt1val);
         if(amt1.value!="")
         {
           //totadv1=parseFloat(totadv1) + parseFloat(amt1.value);
         }
         totadv1=parseFloat(totadv1) + parseFloat(amt1val);
       
        if(EAmt1.value!="")
         {
           totamt1=parseFloat(totamt1) + parseFloat(EAmt1.value);
         }
         
            
    }
 
  
    
      
      
     
  
    
    
        
      
      
       
            totadv=parseFloat(totadv1);
       
            
     
            //alert("totadv : " + totadv)
            totamt=parseFloat(totamt1);
            //alert("totamt : " + totamt)
           document.getElementById("ctl00_MyCPH1_txtTotalAmt").value= totadv;       
           
           document.getElementById("ctl00_MyCPH1_txtTotalExeAmt").value=totamt;       
            
            
            
            document.getElementById("ctl00_MyCPH1_txtBillAmt").value=totamt;
             document.getElementById("ctl00_MyCPH1_txtNetAmt").value=totamt;
            document.getElementById("ctl00_MyCPH1_txtAmtAppl").value=totamt;
            document.getElementById("ctl00_MyCPH1_txtAmtApplL").value=totamt;
            document.getElementById("ctl00_MyCPH1_txtNetPayableAmt").value=totamt;
            
         
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

	frm_name = "ctl00_MyCPH1_"
	function CheckData()
	{
	     
	    
	     
	      var server_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
                                var dt =document.getElementById(frm_name+"txtBillEntryDate").value
				               
				                var dt_dd=dt.substring(0,2)
				                var dt_mm=dt.substring(3,5)
				                var dt_yy=dt.substring(6,10)

		                        var sdt =server_dt
				                var sdt_dd=sdt.substring(0,2)
				                var sdt_mm=sdt.substring(3,5)
				                var sdt_yy=sdt.substring(6,10)
				                
				                var Edt =document.getElementById(frm_name+"txtBillDt").value
				                var Edt_dd=Edt.substring(0,2)
				                var Edt_mm=Edt.substring(3,5)
				                var Edt_yy=Edt.substring(6,10)
	 	                       Edt=new Date(months[parseFloat(Edt_mm)] + " " + parseFloat(Edt_dd) + ", " + parseFloat(Edt_yy))

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
						alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Bill Entry Date Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
						document.getElementById(frm_name+"txtBillEntryDate").focus();
						return false;
				}
				              
				
				if (dt>server_dt)
				 {
						                alert( "Bill Entry Date should not be greater than today's date !!!")
						               document.getElementById(frm_name+"txtBillEntryDate").focus();
						                return false;
				 }
	 	   
	 	     
	 	    if (Edt>server_dt)
				 {
						                alert( "Bill Date should not be greater than today's date !!!")
						               document.getElementById(frm_name+"txtBillDt").focus();
						                return false;
				 }
				 
		   if(document.getElementById(frm_name+"cboVendorType").value=="")
	 	    {
	 	        alert("Please select vendor type")
	 	        document.getElementById(frm_name+"cboVendorType").focus();
	 	        return false;
	 	    } 
	 	     if(document.getElementById(frm_name+"cboVendor").value=="")
	 	    {
	 	        alert("Please select Vendor")
	 	        document.getElementById(frm_name+"cboVendor").focus();
	 	        return false;
	 	    
	 	    }
	 	     if(document.getElementById(frm_name+"txtBillNumber").value=="")
	 	    {
	 	        alert("Please Enter the Vendor Bill Number")
	 	        document.getElementById(frm_name+"txtBillNumber").focus();
	 	        return false;
	 	    }  
	 	    ///alert(document.getElementById(frm_name+"crediit_account").innerText)
	 	   /// alert("hi..")
	 	    if(document.getElementById(frm_name+"crediit_account").innerText==":")
	 	    {
	 	        alert("No Credit Account for the same Vendor Type")
	 	        document.getElementById(frm_name+"cboVendorType").focus();
	 	        return false;
	 	    }  
	 	    
	 	    
	 	    
	 	    
	 	    //------------------------------------
	 	     if(document.getElementById(frm_name+"txtAddRowOilExp").value=="")
	 	    {
	 	        alert("Please enter the no. of row")
	 	        document.getElementById(frm_name+"txtAddRowOilExp").focus();
	 	        return false;
	 	    
	 	    }
	 	    
	 	    var grid1;
            var r1;
            grid1=document.getElementById("ctl00_MyCPH1_dgHSD_OIL_EXP");
            r1=grid1.rows.length;
            //alert(r1);
            
            for(i=0;i< r1-1;i++)
            {  
            j=i+2
            var pref="";
  
              if(j<10)
              {
              pref = "ctl00_MyCPH1_dgHSD_OIL_EXP_ctl0" + j + "_";
         
              
               }                                       
               else
                {         
                    pref = "ctl00_MyCPH1_dgHSD_OIL_EXP_ctl" + j + "_";
                }    
                
                
                var tsno=document.getElementById(pref + "txtTripsheetNo").value;
                var currkm=document.getElementById(pref + "txtKM_Reading").value; 
	 	    //--------------------------------------
	 	    if(tsno=="")
	 	    {
	 	    alert("Please enter the tripsheet no.!!!")
	 	    document.getElementById(pref + "txtTripsheetNo").focus();
	 	    return false;
	 	    }

	 	    if(document.getElementById(pref + "txtKM_Reading").disabled==true)
	 	    {
	 	        alert("Invalid tripsheet no.!!!")
	 	        document.getElementById(pref + "txtTripsheetNo").focus();
	 	        return false;
        	}
	 	    
	 	    if(currkm=="")
	 	    {
	 	     alert("Please enter the Current KM Reading!!!")
	 	    //document.getElementById(pref + "txtKM_Reading").focus();
	 	     return false;
	 	    }
	 	    
	 	    
	  }
//	  alert("hi");
//	   alert(document.getElementById("ctl00$MyCPH1$lblError1").innerText);
//	 	 if(document.getElementById("ctl00$MyCPH1$lblError1").innerText!="")
//	 	    {
//	 	    alert("1");
//	 	        alert(document.getElementById("ctl00$MyCPH1$lblError1").innerText);
//	 	        return false;
//	 	        alert("2");
//        	}
//        	alert("3");
	 	 
	        document.getElementById('ctl00$MyCPH1$txtBillAmt').value=rounditn(document.getElementById('ctl00$MyCPH1$txtTotalExeAmt').value,2);
	        document.getElementById('ctl00$MyCPH1$txtNetAmt').value=rounditn(document.getElementById('ctl00$MyCPH1$txtTotalExeAmt').value,2);

              if(document.getElementById("ctl00_MyCPH1_Svctax_yn").checked==false && document.getElementById("ctl00_MyCPH1_TDS_yn").checked==false)
                {
	                document.getElementById('ctl00$MyCPH1$txtNetPayableAmt').value=rounditn(document.getElementById('ctl00$MyCPH1$txtNetPayableAmt').value,2);
                    document.getElementById("ctl00_MyCPH1_txtAmtAppl").value=rounditn(document.getElementById('ctl00$MyCPH1$txtTotalExeAmt').value,2);
                    document.getElementById("ctl00_MyCPH1_txtAmtApplL").value=rounditn(document.getElementById('ctl00$MyCPH1$txtTotalExeAmt').value,2);
                }
		    varNetAmt = document.getElementById(frm_name+"txtNetPayableAmt").value
	 	    if (parseFloat(varNetAmt)<=0.00)
	        {
		        alert("Bill Amount should be greater that zero , please specify expense details")
		        
		        return false;
	        }
	        
	        
	     //if (CheckValid()==false)// Validation of Expense Voucher User Control
        //  {
        //    return false;
        //  }
               
       
      
         var txtServiceTax = document.getElementById("ctl00_MyCPH1_txtServiceTax");
	 
	   var txtTDSAmt= document.getElementById("ctl00_MyCPH1_txtTDSAmt");
	 
           if(txtTDSAmt.value != 0.00)
           {
                if(document.getElementById("ctl00_MyCPH1_Tdssection").value == "")
                {
                    alert("Please Select TDS Account");
                    document.getElementById("ctl00_MyCPH1_Tdssection").focus();
                    return false;
                }
           }
         //  alert("DOne  1")
   

	//alert("DOne")
	//return false;
	 if (confirm("Do you want to submit")==false)
		{
		  return false;
		}

    document.getElementById(frm_name+"txtBillAmt").disabled=false
    document.getElementById(frm_name+"txtDueDate").disabled=false
    document.getElementById(frm_name+"txtNetAmt").disabled=false
    document.getElementById(frm_name+"txtServiceTax").disabled=false
    document.getElementById(frm_name+"txtEduCess").disabled=false
    document.getElementById(frm_name+"txtTDSRate").disabled=false
    document.getElementById(frm_name+"txtHEduCess").disabled=false
    document.getElementById(frm_name+"txtTDSAmt").disabled=false
    document.getElementById(frm_name+"txtNetPayableAmt").disabled=false        
	    }
	 
	
 
 

 function loadme()
 {
  
   check()
 }
 window.onload=loadme
 function check()
{
		var dockdta=document.getElementById("ctl00_MyCPH1_txtBillDt").value
		
		dockdta_dd=dockdta.substring(0,2)
		dockdta_mm=dockdta.substring(3,5)
		dockdta_yy=dockdta.substring(6,10)
			
		var dockdt_billdt=new Date(months[parseFloat(dockdta_mm)] + " " + parseFloat(dockdta_dd) + ", " + parseFloat(dockdta_yy))
		var days=parseInt(document.getElementById("ctl00_MyCPH1_txtDueAfter").value)
      //  alert(days)
		dues=dateAdd('D',days,dockdt_billdt)
	
		document.getElementById("ctl00_MyCPH1_txtDueDate").value=Datadate1(dues)
}
function dateAdd(intval, numb, base){
	/*intval is YYYY, M, D, H, N, S as in VBscript; numb is amount +/-; base is javascript date object*/
	switch(intval){
		case "M":
			base.setMonth(base.getMonth() + numb);
			break;
		case "YYYY":
			base.setFullYear(base.getFullYear() + numb);
			break;
		case "D":
			base.setDate(base.getDate() + numb);
			break;
		case "H":
			base.setHours(base.getHours() + numb);
			break;
		case "N":
			base.setMinutes(base.getMinutes() + numb);
			break;
		case "S":
			base.setSeconds(base.getSeconds() + numb);
			break;
		default:
	}
	return base
}	
function Datadate1(dt)
{
	dd=parseInt(dt.getDate())
	//alert(dd)
	mm=parseInt(dt.getMonth()+1)
	//alert(mm)
	yy=parseInt(dt.getFullYear())
	//alert(yy)
	    
	    if(parseInt(dd)<10)
	    {
	    dd="0"+dd
	    }
	    
	    if(parseInt(mm)<10)
	    {
	    mm="0"+mm
	    }
	    
	    dt=dd + "/" + mm + "/" + yy
	    //alert(dt)
	 	return dt
	 	
	 	
	 	    
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
     <atlas:UpdateProgress ID="uppMain" runat="server">
<ProgressTemplate>
    <iframe frameborder="0" src="about:blank"
        style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
        <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);"><img src="../../../../images/loading.gif" /><font face=verdana color=blue size=4>&nbsp;<b>Please Wait...</b></font></div>
</ProgressTemplate>
</atlas:UpdateProgress>
<table   width="800">
    <tr><td>
   
        <table cellspacing="1" class="boxbg" width="800">
            <tr class="bgbluegrey">
                <td align="center">
                    <strong>Vendor Bill Entry</strong>
                </td>
            </tr>
        </table>
        
        <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label><br />
       
   </td></tr>
    <tr><td>
        <br />
        <table border="0" cellspacing="1" cellpadding="4" width="800"  align="left" class="boxbg">
        <tr bgcolor="#FFFFFF">
            <td align="left">
                <div align="left">
                    <font class="blackfnt">Bill Entry No</font>
                </div>
            </td>
            <td>
                <font class="blackfnt" color="red">System Generated...</font></td>
            <td align="left">
                <div align="left">
                    <font class="blackfnt">Bill Entry Date</font>
                </div>
            </td>
            <td>
                <font class="blackfnt">
                    <asp:TextBox ID="txtBillEntryDate" runat="server" Width="60px"></asp:TextBox>
                    <a href="#" onclick="cal.select(ctl00$MyCPH1$txtBillEntryDate,'anchor1','dd/MM/yyyy'); return false;"
                        name="anchor1" id="a2">
                        <img src="../../../../images/calendar.jpg" border="0" />
                    </a>(e.g. dd/mm/yyyy) </font>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td>
                <font class="blackfnt">Select Vendor Type</font>
            </td>
            <td>
                <atlas:UpdatePanel ID="updatepanel10" runat="server">
                    <ContentTemplate>
                        <asp:DropDownList ID="cboVendorType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cboVendorType_SelectedIndexChanged">
                            <asp:ListItem Text="--All--" Value=""></asp:ListItem>
                        </asp:DropDownList>
                    </ContentTemplate>
                </atlas:UpdatePanel>
            </td>
            <td align="left">
                <div align="left">
                    <font class="blackfnt">Vendor </font>
                </div>
            </td>
            <td colspan="1">
                <font class="blackfnt" color="red">
                    <atlas:UpdatePanel ID="updatepanel11" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="cboVendor" runat="server" AutoPostBack="true">
                            </asp:DropDownList>
                        </ContentTemplate>
                    </atlas:UpdatePanel>
                </font>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td height="21" bgcolor="#FFFFFF" align="left" width="166">
                <div align="left">
                    <font class="blackfnt">Bill Number</font></div>
            </td>
            <td height="21" bgcolor="#FFFFFF" align="left" width="222">
                <font class="blackfnt">
                    <asp:TextBox ID="txtBillNumber" runat="server" Width="60px"></asp:TextBox>
                </font>
            </td>
            <td>
                <div align="left">
                    <font class="blackfnt">Credit Account</font>
                </div>
                
            </td>
            <td>
             <atlas:UpdatePanel ID="updatepanel4" runat="server">
                    <ContentTemplate>
                <font class="blackfnt"><asp:Label  Font-Bold="true" ID="crediit_account" runat="server" Text="" ></asp:Label> </font>
                </ContentTemplate>
                    </atlas:UpdatePanel>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td height="21" bgcolor="#FFFFFF" align="left" width="166">
                <div align="left">
                    <font class="blackfnt">Bill Amount</font>
                </div>
            </td>
            <td height="21" bgcolor="#FFFFFF" align="left" width="222">
                <font class="blackfnt">
                    <asp:TextBox ID="txtBillAmt" Enabled="false"  Font-Bold="true" runat="server" Width="60px" Text="0.00"></asp:TextBox>
                </font>
            </td>
            <td height="21" bgcolor="#FFFFFF" align="left" width="166">
                <div align="left">
                    <font class="blackfnt">Bill Date</font>
                </div>
            </td>
            <td height="21" bgcolor="#FFFFFF" align="left" width="222">
                <font class="blackfnt">
                    <asp:TextBox ID="txtBillDt" runat="server" Width="60px"></asp:TextBox>
                    <a href="#" onclick="cal.select(ctl00$MyCPH1$txtBillDt,'anchor2','dd/MM/yyyy'); return false;"
                        name="anchor2" id="a3">
                        <img src="../../../../images/calendar.jpg" border="0" />
                    </a>(e.g. dd/mm/yyyy) </font>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td height="21" bgcolor="#FFFFFF" align="left" width="166">
                <div align="left">
                    <font class="blackfnt">Due after</font>
                </div>
            </td>
            <td height="21" bgcolor="#FFFFFF" align="left" width="222">
                <font class="blackfnt">
                    <asp:TextBox ID="txtDueAfter" onblur="javascript:check()" runat="server" Width="60px" Text="15"></asp:TextBox>(Days)
                </font>
            </td>
            <td height="21" bgcolor="#FFFFFF" align="left" width="166">
                <div align="left">
                    <font class="blackfnt">Due Date</font>
                </div>
            </td>
            <td height="21" bgcolor="#FFFFFF" align="left" width="222">
                <font class="blackfnt">
                    <asp:TextBox ID="txtDueDate" Enabled="false" runat="server" Width="60px"></asp:TextBox>
                </font>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td>
                <div align="left">
                    <font class="blackfnt">Ref. No.</font>
                </div>
            </td>
            <td>
                <font class="blackfnt">
                    <asp:TextBox ID="txtRefNo" runat="server" Width="60px"></asp:TextBox>
                </font>
            </td>
            <td>
                <div align="left">
                    <font class="blackfnt">Remark</font>
                </div>
            </td>
            <td>
                <font class="blackfnt">
                    <asp:TextBox ID="txtRemarks" runat="server" Width="250px" TextMode="MultiLine" Height="20px"></asp:TextBox>
                </font>
            </td>
        </tr>
        
        <tr bgcolor="#FFFFFF">
            <td>
                <div align="left">
                    <font class="blackfnt"></font>
                </div>
            </td>
            <td>
                <font class="blackfnt">&nbsp; </font>
            </td>
            <td>
                <div align="left">
                    <font class="blackfnt"><strong>Net Amount</strong></font>
                </div>
            </td>
            <td>
                <font class="blackfnt">
                    <asp:TextBox ID="txtNetAmt"   Font-Bold="true"  Enabled="false" runat="server" Width="60px" Text="0.00"></asp:TextBox>
                </font>
            </td>
        </tr>
    </table>
     </td></tr>
            <tr><td>
        <br />
        
        <atlas:UpdatePanel ID="UpdatePanel1" Mode="Conditional" RenderMode="Inline" runat="server">
                        <ContentTemplate>
                            <asp:Panel runat="server" ID="Panel7" Visible="true">
                            <asp:Label ID="lblError1" runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor="red"></asp:Label>
 <table cellspacing="1" cellpadding="3" width="75%"  class="boxbg"
            border="0">
<tr class="bgbluegrey">
                                        <td colspan="4" align="left">
                                            <font class="blackfnt"><b>HSD/OIL Expenses</b></font></td>
                                    </tr>
                                    <tr style="background-color: white">
                                        <td width="5%" nowrap>
                                            <font class="blackfnt">Enter no. of rows</font></td>
                                        <td colspan="3" align="left">
                                            <asp:TextBox ID="txtAddRowOilExp" runat="server" MaxLength="3" Width="30" BorderStyle="Groove"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                OnTextChanged="add_rowOil" AutoPostBack="true"></asp:TextBox></td>
                                    </tr>
                                    <tr style="background-color: white">
                                        <td colspan="4" align="center">
                                            <table border="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <asp:DataGrid ID="dgHSD_OIL_EXP" runat="server" AutoGenerateColumns="False" CellPadding="2"
                                                            CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                                            BorderWidth="3px" Width="100%" OnItemDataBound="dgHSD_OIL_EXP_ItemDataBound">
                                                            <Columns>
                                                                <asp:TemplateColumn HeaderText="Sr.No.">
                                                                    <ItemTemplate>
                                                                        <center>
                                                                            <%# Container.ItemIndex+1 %>
                                                                            .
                                                                            <asp:Label ID="count" runat="server" Visible="false" Text=' <%# Container.ItemIndex+1 %>'></asp:Label>
                                                                        </center>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="False" />
                                                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="False" />
                                                                </asp:TemplateColumn>
                                                                
                                                                
                                                                <asp:TemplateColumn HeaderText="Manual Tripsheet No.">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtTripsheetNo" runat="server" CssClass="input" Width="60px" BorderStyle="Groove"
                                                                            MaxLength="25" OnTextChanged="TripsheetNo_Change" AutoPostBack="true"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="reqTripsheetNo" runat="server" Display="Dynamic" Text="!"
                                                                            ValidationGroup="VGDtFromTo" ControlToValidate="txtTripsheetNo"></asp:RequiredFieldValidator>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="False" />
                                                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="False" />
                                                                </asp:TemplateColumn>
                                                                
                                                                
                                                                <asp:TemplateColumn HeaderText="Vehicle No.">
                                                                    <ItemTemplate>
                                                                             <asp:Label ID="txtVehicleno" runat="server" Width="80px"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="False" />
                                                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="False" />
                                                                </asp:TemplateColumn>
                                                                
                                                                
                                                                <asp:TemplateColumn HeaderText="Place">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtOilPlace" runat="server" CssClass="input" Width="80px" BorderStyle="Groove"
                                                                            MaxLength="50"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="reqOilPlace" runat="server" Display="Dynamic" Text="!"
                                                                            ValidationGroup="VGDtFromTo" ControlToValidate="txtOilPlace"></asp:RequiredFieldValidator>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="False" />
                                                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="False" />
                                                                </asp:TemplateColumn>
                                                               
                                                                <asp:TemplateColumn HeaderText="Fuel Type">
                                                                    <ItemTemplate>
                                                                        <asp:DropDownList ID="ddlFuelType" runat="server" CssClass="input" Width="90px" BorderStyle="Groove">
                                                                        </asp:DropDownList>
                                                                        <asp:RequiredFieldValidator ID="reqFuelType" runat="server" Display="Dynamic" Text="!"
                                                                            ValidationGroup="VGDtFromTo" ControlToValidate="ddlFuelType"></asp:RequiredFieldValidator>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="False" />
                                                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="False" />
                                                                </asp:TemplateColumn>
                                                                <asp:TemplateColumn HeaderText="Last Km Reading">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="txtLKmRead" runat="server" Width="80px"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="False" />
                                                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="true" />
                                                                </asp:TemplateColumn>
                                                                <asp:TemplateColumn HeaderText="Current KM Reading">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtKM_Reading" runat="server" CssClass="input" Width="60px" BorderStyle="Groove"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                                            MaxLength="6" AutoPostBack="True" OnTextChanged="txtKM_Reading_TextChanged"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="reqKM_Reading" runat="server" Display="Dynamic" Text="!"
                                                                            ValidationGroup="VGDtFromTo" ControlToValidate="txtKM_Reading"></asp:RequiredFieldValidator>
                                                                        <asp:RegularExpressionValidator ID="RegKM_Reading" runat="server" ErrorMessage="!"
                                                                            ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true" ControlToValidate="txtKM_Reading"
                                                                            Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="False" />
                                                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="true" />
                                                                </asp:TemplateColumn>
                                                                <asp:TemplateColumn HeaderText="Slip No.">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtBillno" runat="server" CssClass="input" Width="60px" BorderStyle="Groove"
                                                                            MaxLength="25"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="reqBillno" runat="server" Display="Dynamic" Text="!"
                                                                            ValidationGroup="VGDtFromTo" ControlToValidate="txtBillno"></asp:RequiredFieldValidator>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="False" />
                                                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="False" />
                                                                </asp:TemplateColumn>
                                                                <asp:TemplateColumn HeaderText="Slip Date (dd/mm/yyyy)">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtBilldt" runat="server" MaxLength="10" Width="65" BorderStyle="Groove"></asp:TextBox>
                                                                        <%--<a href="#" onclick="cal.select(ctl00$MyCPH1$dgHSD_OIL_EXP$txtBilldt,'anchor4','dd/MM/yyyy'); return false;"  name="anchor4" id="a4">
                                                                            <img src="../../../../images/calendar.jpg" border="0" />
                                                                        </a>--%>
                    
                                                                        <asp:RequiredFieldValidator ID="reqBilldt" runat="server" Display="Dynamic" Text="!"
                                                                            ValidationGroup="VGDtFromTo" ControlToValidate="txtBilldt"></asp:RequiredFieldValidator>
                                                                        <asp:RegularExpressionValidator ID="REVBilldt" runat="server" ControlToValidate="txtBilldt"
                                                                            ErrorMessage="!" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                                                            Width="1px"></asp:RegularExpressionValidator>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="False" />
                                                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="true" />
                                                                </asp:TemplateColumn>
                                                                <asp:TemplateColumn HeaderText="Diesel (Qtn. in litres)">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtDiesel_Ltr" runat="server" CssClass="input" Width="60px" BorderStyle="Groove"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                                            MaxLength="6" onblur="javascript:return calculateBalance()" ></asp:TextBox><%--OnTextChanged="Diesel_Oil_Calc" AutoPostBack="true"--%>
                                                                        <asp:RequiredFieldValidator ID="reqDiesel_Ltr" runat="server" Display="Dynamic" Text="!"
                                                                            ValidationGroup="VGDtFromTo" ControlToValidate="txtDiesel_Ltr"></asp:RequiredFieldValidator>
                                                                        <asp:RegularExpressionValidator ID="RegDiesel_Ltr" runat="server" ErrorMessage="!"
                                                                            ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true" ControlToValidate="txtDiesel_Ltr"
                                                                            Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="False" />
                                                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="true" />
                                                                </asp:TemplateColumn>
                                                                <asp:TemplateColumn HeaderText="Diesel Rate/litres">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtDieselRate_Ltr" runat="server" CssClass="input" Width="60px" onblur="javascript:return calculateBalance()"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                                            BorderStyle="Groove" MaxLength="6" ></asp:TextBox><%--OnTextChanged="Diesel_Oil_Calc" AutoPostBack="true"--%>
                                                                        <asp:RequiredFieldValidator ID="reqDieselRate_Ltr" runat="server" Display="Dynamic"
                                                                            Text="!" ValidationGroup="VGDtFromTo" ControlToValidate="txtDieselRate_Ltr"></asp:RequiredFieldValidator>
                                                                        <asp:RegularExpressionValidator ID="RegDieselRate_Ltr" runat="server" ErrorMessage="!"
                                                                            ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true" ControlToValidate="txtDieselRate_Ltr"
                                                                            Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="False" />
                                                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="true" />
                                                                </asp:TemplateColumn>
                                                                
                                                                <asp:TemplateColumn HeaderText="Amount">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtAmt" runat="server" CssClass="input" Width="60px" BorderStyle="Groove"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                                            MaxLength="6" ReadOnly="true"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="reqAmt" runat="server" Display="Dynamic" Text="!"
                                                                            ValidationGroup="VGDtFromTo" ControlToValidate="txtAmt"></asp:RequiredFieldValidator>
                                                                        <asp:RegularExpressionValidator ID="RegAmt" runat="server" ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"
                                                                            SetFocusOnError="true" ControlToValidate="txtAmt" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="False" />
                                                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="False" />
                                                                </asp:TemplateColumn>
                                                                <asp:TemplateColumn HeaderText="Amount Approved By Fleet Executive">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtExeAmt" runat="server" CssClass="input" Width="60px" BorderStyle="Groove"    onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                                            MaxLength="6" onblur="javascript:return calculateBalance()" ></asp:TextBox><%--OnTextChanged="PopulateAdvamt" AutoPostBack="true"--%>
                                                                        <asp:RequiredFieldValidator ID="reqExeAmt" runat="server" Display="Dynamic" Text="!"
                                                                            ValidationGroup="VGDtFromTo" ControlToValidate="txtAmt"></asp:RequiredFieldValidator>
                                                                        <asp:RegularExpressionValidator ID="RegExeAmt" runat="server" ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"
                                                                            SetFocusOnError="true" ControlToValidate="txtExeAmt" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="False" />
                                                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="true" />
                                                                </asp:TemplateColumn>
                                                                <%--<asp:TemplateColumn HeaderText="By Card/Cash">
                                                                    <ItemTemplate>
                                                                        <asp:DropDownList ID="ddlPayment" runat="server" CssClass="input" Width="80px" BorderStyle="Groove">
                                                                            <asp:ListItem>select</asp:ListItem>
                                                                            <asp:ListItem>Cash</asp:ListItem>
                                                                            <asp:ListItem>Credit</asp:ListItem>
                                                                            <asp:ListItem>Diesel Card</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                        <asp:RequiredFieldValidator ID="reqPayment" runat="server" Display="Dynamic" Text="!"
                                                                            ValidationGroup="VGDtFromTo" ControlToValidate="ddlPayment"></asp:RequiredFieldValidator>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="False" />
                                                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="true" />
                                                                </asp:TemplateColumn>--%>
                                                                <asp:TemplateColumn HeaderText="Remarks">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtRemarks" runat="server" CssClass="input" Width="80px" BorderStyle="Groove"
                                                                            ReadOnly="false"></asp:TextBox>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="False" />
                                                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="False" />
                                                                </asp:TemplateColumn>
                                                            </Columns>
                                                            <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Left" BackColor="White"
                                                                ForeColor="#000066" Wrap="False" Mode="NumericPages"></PagerStyle>
                                                            <FooterStyle BackColor="White" ForeColor="#000066" />
                                                            <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                            <ItemStyle ForeColor="#000066" />
                                                            <HeaderStyle Font-Bold="False" ForeColor="Black" CssClass="bgbluegrey" Font-Italic="False"
                                                                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                                        </asp:DataGrid>
                                                    </td>
                                                </tr>
                                            </table>
                                            
                                            <table Width="100%"   cellspacing="1" cellpadding="3" class="boxbg" border="0">
            <tr style="background-color: white">
                    <td  width="83%" align=right>
                        <font class=blackfnt><b>Total</b></font>
                    </td>
                    <td align="left" >
                        <asp:TextBox ID="txtTotalAmt" runat="server"  ReadOnly="true" Width="50px" BorderStyle="Groove"></asp:TextBox>
                    </td>
                    <td align="left" width=20%>
                        <asp:TextBox ID="txtTotalExeAmt" runat="server"  ReadOnly="true" Width="50px" BorderStyle="Groove"></asp:TextBox>
                    </td>
       
      </tr>
     </table>
     <br>
     
             
                                        </td>
                                    </tr>
                                </table>
                          
                </td>
            </tr>
            </table>
</asp:Panel>
      </ContentTemplate>
      <Triggers>
            <atlas:ControlEventTrigger ControlID="txtAddRowOilExp" EventName="TextChanged" />
      </Triggers>
</atlas:UpdatePanel>

        
        
        </td></tr>
           
            <tr><td>
        <br />
        <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="800">
            <tr class="bgbluegrey">
                <td style="text-align: center" class="blackfnt" colspan="2">
                  <asp:CheckBox ID="Svctax_yn" runat="server" onclick="javascript:GetTot()" /> <strong> <font  color="red">Plz Check Here to Enable Service Tax </font></strong>
                </td>
                <td style="text-align: center" class="blackfnt" colspan="2">
                  <asp:CheckBox ID="TDS_yn" runat="server" onclick="javascript:GetTot()" /> <strong> <font  color="red">Plz Check Here to Enable TDS </font></strong>
                </td>
            </tr>
            <tr class="bgbluegrey">
                <td style="text-align: center" class="blackfnt" colspan="2">
                    <strong>ADD Service Tax(+) </strong>
                </td>
                <td style="text-align: center" class="blackfnt" colspan="2">
                    <strong>LESS TDS (-) </strong>
                </td>
            </tr>
            <tr style="background-color: White">
                <td style="text-align: left" class="blackfnt">
                    &nbsp;Amount Applicable
                </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtAmtAppl" runat="server" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="False"></asp:TextBox></td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;Amount Applicable
                </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtAmtApplL" runat="server" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="False" OnTextChanged="txtAmtApplL_TextChanged"></asp:TextBox></td>
            </tr>
             <tr style="background-color: White">
                <td style="text-align: left" class="blackfnt">
                    &nbsp; 
                </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;<%--<asp:TextBox ID="txtServiceTax_rate"   onblur="javascript:GetTot()"   runat="server" onchange="javascript:Nagative_Chk_wDecimal(this)" BorderStyle="Groove" CssClass="input" Width="80px"  Text="0.00" ></asp:TextBox>--%></td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;TDS Section
                </td>
                <td style="text-align: left" class="blackfnt"><asp:DropDownList ID="Tdssection" runat="server" Width="200px" >
                               
                            </asp:DropDownList>
                   </td>
            </tr>
            <tr style="background-color: White">
                <td style="text-align: left" class="blackfnt">
                    &nbsp;Service tax (+)
                </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtServiceTax" runat="server" onchange="javascript:Nagative_Chk_wDecimal(this)" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="False"  Text="0.00"></asp:TextBox></td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;TDS Section
                </td>
                <td style="text-align: left" class="blackfnt">
                   <asp:DropDownList ID="cboCorporate" runat="server" class="blackfnt">
                    <asp:ListItem Text="Select" Value=""></asp:ListItem>
                    <asp:ListItem Text="Corporate" Value="C"></asp:ListItem>
                    <asp:ListItem Text="Non Corporate" Value="N"></asp:ListItem>
                </asp:DropDownList></td>
            </tr>
            <tr style="background-color: White">
                <td style="text-align: left" class="blackfnt">
                    &nbsp;Education Cess (+)
                </td>
                <td style="text-align: left" class="blackfnt"> 
                    &nbsp;<asp:TextBox ID="txtEduCess" runat="server" onchange="javascript:Nagative_Chk_wDecimal(this)" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="False" Text="0.00"></asp:TextBox></td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;TDS Rate
                </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtTDSRate" runat="server" BorderStyle="Groove"  Text="0.00" onchange="javascript:Nagative_Chk_wDecimal(this)" CssClass="input" Width="80px"></asp:TextBox></td>
            </tr>
            <tr style="background-color: White">
                <td style="text-align: left" class="blackfnt">
                    &nbsp;Higher Education Cess (+)
                </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtHEduCess" runat="server" onchange="javascript:Nagative_Chk_wDecimal(this)" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="False" Text="0.00"></asp:TextBox></td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;TDS Amount (-)
                </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtTDSAmt" runat="server" BorderStyle="Groove" CssClass="input"  Text="0.00" Width="80px" Enabled="False"></asp:TextBox></td>
            </tr>
           <%-- <tr style="background-color: White">
                <td style="text-align: left" class="blackfnt">
                    &nbsp;Service Tax Reg No.
                </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtSrvTaxNo" runat="server" BorderStyle="Groove" CssClass="input" Width="140px"></asp:TextBox></td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;PAN Number
                </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtPanNo" runat="server" BorderStyle="Groove" CssClass="input" Columns="10" MaxLength="10"></asp:TextBox></td>
            </tr>--%>
            
           <!--<tr class="bgbluegrey">
                <td style="text-align: center" class="blackfnt" colspan="4">
                    <strong> Other Detail </strong>
                </td>
              
            </tr>
             <tr bgcolor="#FFFFFF">
            <td>
                <div align="left">
                    <font class="blackfnt">Other Deduction</font>
                </div>
            </td>
            <td>
                <font class="blackfnt">
                    <asp:TextBox ID="txtOtherDedudction"   onkeypress="javascript:return validInt(event)"   onblur="javascript:GetTot()"   runat="server" Width="60px" Text="0"></asp:TextBox>
                </font>
            </td>
            <td>
                <div align="left">
                    <font class="blackfnt">Discount Received</font>
                </div>
            </td>
            <td>
                <font class="blackfnt">
                    <asp:TextBox ID="txtDiscRecvd"   onkeypress="javascript:return validInt(event)" onblur="javascript:GetTot()"  runat="server" Width="60px" Text="0"></asp:TextBox>
                </font>
            </td>
        </tr>-->
        <tr bgcolor="#FFFFFF">
            <td colspan="3">
                <font class="blackfnt"><b>Net Payable Amount</b></font></td>
            <td>
                <font class="blackfnt"></font>
                <asp:TextBox ID="txtNetPayableAmt" Font-Bold="true"  Enabled="false"  runat="server" Width="80px" Text="0.00"></asp:TextBox>
            </td>
        </tr>
        </table>
              </td></tr>
            <tr><td>
        <table cellspacing="1" class="boxbg" width="800">
            <tr class="bgbluegrey">
                <td align="center">
                    <asp:Button ID="btnSubmit" runat="server"  CssClass="blackfnt" OnClientClick="javascript:return CheckData();" BorderStyle="Solid" BorderWidth="1px" Text="SUBMIT"
                        Width="150px" OnClick="btnSubmit_Click" /></td>
            </tr>
        </table>
     </td></tr>
           
    <br />
  
    </table>

  <div id="Div1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>