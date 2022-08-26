<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"  
     CodeFile="OtherBillentry.aspx.cs" Inherits="GUI_Finance_Accounts_OtherBillentry"
    Title="Debit Voucher" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">


    <script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"></script>

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
function popuplist(mode,ctlid,tbl)
 { 
      var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
      var url="";
            url="DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl ;
            confirmWin=window.open(url,"",winOpts);
      return false;
 }
 
 function LocBlur(id)
 {
    
    var str="";
    for(var i=0;i<id.length-14;i++)
    {
        str+=id.charAt(i);
    }
   document.getElementById(id).value=document.getElementById(id).value.toUpperCase()
    var txtLocation=document.getElementById(id);
   
    var Location=txtLocation.value;
    if(Location=="")
        return false;
 
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="CheckExist.aspx?mode=LocCode&Code=" + Location + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
             if(findobj.readyState==4 && findobj.status==200)
                {
                    var res=findobj.responseText.split("|");
                    if(res[0]=="false")
                    {
                        alert("Location Code is not Valid... Please Enter Valid Location Code");
                        txtLocation.value="";
                        txtLocation.focus();
                        return false;
                    }
                   
                }
         }
    findobj.send(null);
    }
    return false;
}

function AccBlur(id)
 {
    var str="";
    for(var i=0;i<id.length-10;i++)
    {
        str+=id.charAt(i);
    }
    document.getElementById(id).value=document.getElementById(id).value.toUpperCase()
    var txtAccCode=document.getElementById(id);
    var txtDescription=document.getElementById(id.substring(0,id.length - 10) + "txtDescription");
  
    var AccCode=txtAccCode.value.toUpperCase();
    
    if(AccCode=="")
        return false;
 
   var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
   var r=tbl.rows.length;
   
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
     
     var strpg="CheckExist.aspx?mode=AccCode&Code=" + AccCode + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
          
             if(findobj.readyState==4 && findobj.status==200)
                {
                    var res=findobj.responseText.split("|");
                    if(res[0]=="false")
                    {
                        alert("Account Code is not Valid... Please Enter Valid Account Code");
                        txtAccCode.value="";
                        txtAccCode.focus();
                        return false;
                    }
                    else
                    {
                        txtDescription.value=res[1];
                    }
                    
                }
         }
         
    findobj.send(null);
    }
    return false;
}
function Manualbillblur(id)
{
    //debugger;
    var txtManualBillno=document.getElementById(id);
    var Manualbill = txtManualBillno.value;
    if(Manualbill=="")
    {
        return false
    }
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
    
     var strpg="CheckExist.aspx?mode=Manualbill&Code=" + Manualbill + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
             if(findobj.readyState==4 && findobj.status==200)
                {
                    var res=findobj.responseText.split("|");
                    if(res[0]=="true")
                    {
                        alert("Manual Voucher Number is Already Exists... Please Enter Other Mumber");
                        txtManualBillno.value="";
                        txtManualBillno.focus();
                        return false;
                    }
                    
                }
         }
    findobj.send(null);
    }
    return false;
     
}
function PaidBlur(id)
 {
 
    var str="";
    for(var i=0;i<id.length-9;i++)
    {
        str+=id.charAt(i);
    }
  document.getElementById(id).value=document.getElementById(id).value.toUpperCase()
    var txtLocation=document.getElementById(id);
   
    var Location=txtLocation.value.toUpperCase();
    if(Location=="")
        return false;
 
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
   // var party_arr=Location.split("~");
   // Location=party_arr[0]
    //alert(Location)
     var strpg="CheckVendorCode.aspx?mode=Paid&Code=" + Location + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
             
             if(findobj.readyState==4 && findobj.status==200)
                {
                    var res=findobj.responseText.split("|");
                    if(res[0]=="false")
                    {
                        alert("Vendor/Customer Code is not Valid... Please Enter Valid Vendor Code");
                        txtLocation.value="";
                        txtLocation.focus();
                        return false;
                    }
                    else
                    {
                        document.getElementById('ctl00$MyCPH1$txtPaidTo_Name').value = res[0];
                    }
                   
                }
         }
    findobj.send(null);
    }
    return false;
}
function openVend()
    {
        window.open('popup-vendor.aspx?type=ven' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
     }
function openCust()
    {
        window.open('popup-customer.aspx?type=cust' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
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
	    
	    var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
        var rows=tbl.rows.length;
        for(i = 2; i < rows ; i++)
        {
            if(i<10)
            {
               Amt=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtAmt").value;
               Acccode=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtAccCode").value;
            }
            else
            {
                Amt=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_txtAmt").value;
                Acccode=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_txtAccCode").value;
            }
            if(Acccode!="")
            {
            T = parseFloat(Number(T) + Number(Amt)).toFixed(2);
            }
        }
        
        var j = Number(rows) + Number(1);
            if(j<10)
            {
               TotAmt=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtTotAmt");
            }
            else
            {
                TotAmt=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_txtTotAmt");
            }
        
        TotAmt.value = T;
        
        var AmtAppl = document.getElementById("ctl00_MyCPH1_txtAmtAppl");
        AmtAppl.value = roundit(TotAmt.value,2);
        
//        if(document.getElementById("ctl00_MyCPH1_Svctax_yn").checked && document.getElementById("ctl00_MyCPH1_Onaccount").checked)
//        {
//                alert("IF Cheque Is On Account- Can not Apply Service tax");
//                //document.getElementById("ctl00_MyCPH1_Svctax_yn").checked=false
//            //    return false;
//        }
//        if(document.getElementById("ctl00_MyCPH1_TDS_yn").checked && document.getElementById("ctl00_MyCPH1_Onaccount").checked)
//        {
//                alert("IF Cheque Is On Account- Can not Apply TDS");
//               // document.getElementById("ctl00_MyCPH1_TDS_yn").checked=false
//               // return false;
//        }
        
	    //var ServiceTax_rate=document.getElementById("ctl00_MyCPH1_txtServiceTax_rate").value

        var HdnServiceTaxRate = document.getElementById("ctl00_MyCPH1_HdnServiceTaxRate");
        var HdnEduCessRate = document.getElementById("ctl00_MyCPH1_HdnEduCessRate");
        var HdnHEduCessRate = document.getElementById("ctl00_MyCPH1_HdnHEduCessRate");

        //var txtServiceTax = document.getElementById("ctl00_MyCPH1_txtServiceTax");
        //var txtEduCess = document.getElementById("ctl00_MyCPH1_txtEduCess");
        //var txtHEduCess = document.getElementById("ctl00_MyCPH1_txtHEduCess");

        //var HdnServiceTax = document.getElementById("ctl00_MyCPH1_HdnServiceTax");
        //var HdnEduCess = document.getElementById("ctl00_MyCPH1_HdnEduCess");
        //var HdnHEduCess = document.getElementById("ctl00_MyCPH1_HdnHEduCess");

        if(document.getElementById("ctl00_MyCPH1_Svctax_yn").checked)
        {
            document.getElementById("ctl00_MyCPH1_txtServiceTax").value = rounditn((parseFloat(AmtAppl.value) * parseFloat(HdnServiceTaxRate.value) / 100), 2);
            document.getElementById("ctl00_MyCPH1_txtEduCess").value = rounditn((parseFloat(document.getElementById("ctl00_MyCPH1_txtServiceTax").value) * parseFloat(HdnEduCessRate.value) / 100), 2);
            document.getElementById("ctl00_MyCPH1_txtHEduCess").value = rounditn((parseFloat(document.getElementById("ctl00_MyCPH1_txtServiceTax").value) * parseFloat(HdnHEduCessRate.value) / 100), 2);
        }
        else
        {
            document.getElementById("ctl00_MyCPH1_txtServiceTax").value="0.00";
            document.getElementById("ctl00_MyCPH1_txtEduCess").value="0.00";
            document.getElementById("ctl00_MyCPH1_txtHEduCess").value="0.00";
            //document.getElementById("ctl00_MyCPH1_txtServiceTax_rate").value="0.00";
        }
          
        
         document.getElementById("ctl00_MyCPH1_txtBillAmt").value=rounditn(parseFloat(Number(AmtAppl.value)),2)
         document.getElementById("ctl00_MyCPH1_txtNetAmt").value=rounditn(parseFloat(Number(AmtAppl.value))-parseFloat(document.getElementById("ctl00_MyCPH1_txtOtherDedudction").value)- parseFloat(document.getElementById("ctl00_MyCPH1_txtDiscRecvd").value),2)
         
        var TP = parseFloat(Number(AmtAppl.value)+ Number(document.getElementById("ctl00_MyCPH1_txtServiceTax").value) + Number(document.getElementById("ctl00_MyCPH1_txtEduCess").value) + Number(document.getElementById("ctl00_MyCPH1_txtHEduCess").value));
        
        var AmtApplL = document.getElementById("ctl00_MyCPH1_txtAmtApplL");
        
//        AmtApplL.value = parseFloat(Number(AmtAppl.value) + Number(TP)).toFixed(2);
        AmtApplL.value = roundit(TP,2);
        if(parseFloat(AmtApplL.value)<0)
        {
            AmtApplL.value="0.00"
        }
        var txtTDSAmt= document.getElementById("ctl00_MyCPH1_txtTDSAmt");
        var txtTDSRate = document.getElementById("ctl00_MyCPH1_txtTDSRate");
        var txtSrvTaxNo = document.getElementById("ctl00_MyCPH1_txtSrvTaxNo");
        
        if(Number(txtTDSRate.value) > 100)
        {
            alert("TDS Rate Should not greater than 100%");
            txtTDSRate.focus();
            txtTDSRate.value = "0.0";
            return false;
        }
        if(document.getElementById("ctl00_MyCPH1_TDS_yn").checked)
        {
        txtTDSAmt.value = rounditn(Math.round(parseFloat((Number(AmtApplL.value)* Number(txtTDSRate.value))/Number(100)).toFixed(2)),2);
        }
        else
        {
        txtTDSAmt.value = "0.00";
         txtTDSRate.value = "0.0";
        }
        
        
          var txtNetPay =  document.getElementById("ctl00_MyCPH1_txtNetPayableAmt");
          
        txtNetPay.value = rounditn(parseFloat(Number(AmtAppl.value) - Number(txtTDSAmt.value)+ Number(document.getElementById("ctl00_MyCPH1_txtServiceTax").value) + Number(document.getElementById("ctl00_MyCPH1_txtEduCess").value) + Number(document.getElementById("ctl00_MyCPH1_txtHEduCess").value)-parseFloat(document.getElementById("ctl00_MyCPH1_txtOtherDedudction").value)- parseFloat(document.getElementById("ctl00_MyCPH1_txtDiscRecvd").value)),2);
        
        if(parseFloat(txtNetPay.value)<0)
        {
            txtNetPay.value="0.00"
        }
       // document.getElementById("ctl00_MyCPH1_txtAmtApplA").value=rounditn(Math.round(txtNetPay.value),2);
      
       
        return false;
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
	function CheckTax()
	{
//	    var txtServiceTax = document.getElementById("ctl00_MyCPH1_txtServiceTax");
//	    var txtSrvTaxNo = document.getElementById("ctl00_MyCPH1_txtSrvTaxNo");
//	    if(txtServiceTax.value == 0.00 || txtServiceTax.value == "")
//        {
//            alert("Service Tax Amount is 0");
//            txtSrvTaxNo.value = "";
//            return false;
//        }
	}
	function CheckPan(obj)
	{
	    if(obj.value!="")
	    {
	        if(obj.value.length!=10)
            {
                alert("PAN No length Should be > 10");
                obj.focus();
                return false;
            }
        }
	}
	function CheckCashBank()
	{
	     var txtNetPay =  document.getElementById("ctl00_MyCPH1_txtNetPay");
	    var txtCashAmt = document.getElementById("ctl00_MyCPH1_txtCashAmt");
	    var ddlPayMode = document.getElementById("ctl00_MyCPH1_ddlPayMode");
	    var txtChqAmt = document.getElementById("ctl00_MyCPH1_txtChqAmt");
	    var temp;
	    
	    if(ddlPayMode.value == "Cash")
	    {
	        if(txtCashAmt.value !=  txtNetPay.value)
            {
                alert("Cash Amount must be equal Net Payable Amount");
                txtCashAmt.focus();
                txtCashAmt.value = "";
                return false;
            }
         }
         else if(ddlPayMode.value == "Bank")
         {
            if(txtChqAmt.value !=  txtNetPay.value)
            {
                alert("Cash Amount must be equal Net Payable Amount");
                txtChqAmt.focus();
                txtChqAmt.value = "";
                return false;
            }
         }
         else if(ddlPayMode.value == "Both")
         {
            
            if(txtCashAmt.value == 0.00 || txtCashAmt.value == "")
            {
                if(Number(txtChqAmt.value) > Number(txtNetPay.value))
                {
                    alert("Cash Amount and Cheque Amount MUST be equal to Net payable");
                    txtChqAmt.focus();
                    return false;
                }
            }
            else if (txtChqAmt.value == 0.00 || txtChqAmt.value == "")
            {
                if(Number(txtCashAmt.value) > Number(txtNetPay.value))
                {
                    alert("Cash Amount and Cheque Amount MUST be equal to Net payable");
                    txtCashAmt.focus();
                    return false;
                }
            }
            else
            {
                temp = parseFloat(Number(txtCashAmt.value) + Number(txtChqAmt.value));
                if(temp !=  txtNetPay.value)
                {
                    alert("Cash Amount and Cheque Amount MUST be equal to Net payable");
                    txtCashAmt.value = "";
                    txtChqAmt.value = "";
                    return false;
                }
            }
            }
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
	 	    
	 	     
		    varNetAmt = document.getElementById(frm_name+"txtNetPayableAmt").value
	 	    if (parseFloat(varNetAmt)<=0.00)
	        {
		        alert("Bill Amount should be greater that zero , please specify expense details")
		        
		        return false;
	        }
	        
	        
	        
        var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
        var Totalcount=tbl.rows.length;
        var Acccode_flag="N"
        for(i = 2; i < Totalcount ; i++)
        {
            if(i<10)
            {
               Acccode=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtAccCode").value;
               
            }
            else
            {
                Acccode=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_txtAccCode").value;
                
            }
           
            if(Acccode!="")
            {
                Acccode_flag="Y"
                
            }
           
        }
         if(Acccode_flag!="Y")
       {
             alert("Please Enter Atleast One Account Code");
             return false;
       }
        for(i = 2; i < Totalcount ; i++)
        {
           if(i<10)
            {
               Acccode=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtAccCode").value;
               Amount=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtAmt");
            }
            else
            {
               Amount=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_txtAmt");
                Acccode=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_txtAccCode").value;
            }
            if(Acccode!="")
            {
                if(parseFloat(Amount.value)<= 0 )
                    {
                         alert("Please Enter Amount Greater than Zero");
                         Amount.focus();
                         return false;
                    }
             }
        }
      
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
           document.getElementById(frm_name+"txtBillAmt").disabled=false
    document.getElementById(frm_name+"txtDueDate").disabled=false
    document.getElementById(frm_name+"txtNetAmt").disabled=false
    document.getElementById(frm_name+"txtServiceTax").disabled=false
    document.getElementById(frm_name+"txtEduCess").disabled=false
    document.getElementById(frm_name+"txtTDSRate").disabled=false
    document.getElementById(frm_name+"txtHEduCess").disabled=false
    document.getElementById(frm_name+"txtTDSAmt").disabled=false
    document.getElementById(frm_name+"txtNetPayableAmt").disabled=false

	//alert("DOne")
        
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

    </script>
    <asp:UpdatePanel ID="Updtl" runat="server" UpdateMode="Conditional" RenderMode="Inline">
        <ContentTemplate>
<table   width="800">
    <tr><td>
   
        <table cellspacing="1" class="boxbg" width="800">
            <tr class="bgbluegrey">
                <td align="center">
                    <strong>Other Bill Entry</strong>
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
                        <img src="../../../images/calendar.jpg" border="0" />
                    </a>(e.g. dd/mm/yyyy) </font>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td>
                <font class="blackfnt">Select Vendor Type</font>
            </td>
            <td>
                <asp:UpdatePanel ID="updatepanel10" runat="server">
                    <ContentTemplate>
                        <asp:DropDownList ID="cboVendorType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cboVendorType_SelectedIndexChanged">
                            <asp:ListItem Text="--All--" Value=""></asp:ListItem>
                        </asp:DropDownList>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
            <td align="left">
                <div align="left">
                    <font class="blackfnt">Vendor </font>
                </div>
            </td>
            <td colspan="1">
                <font class="blackfnt" color="red">
                    <asp:UpdatePanel ID="updatepanel11" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="cboVendor" runat="server" AutoPostBack="true">
                            </asp:DropDownList>
                        </ContentTemplate>
                    </asp:UpdatePanel>
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
             <asp:UpdatePanel ID="updatepanel4" runat="server">
                    <ContentTemplate>
                <font class="blackfnt"><asp:Label  Font-Bold="true" ID="crediit_account" runat="server" Text="" ></asp:Label> </font>
                </ContentTemplate>
                    </asp:UpdatePanel>
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
                        <img src="../../../images/calendar.jpg" border="0" />
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
        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
        <asp:Table ID="Table1" runat="server">
        <asp:TableRow>
        <asp:TableCell><asp:Image ID="imgwaiting" runat="server" ImageUrl="~/GUI/images/loading.gif" /></asp:TableCell>
        <asp:TableCell CssClass="blackfnt" Font-Bold="true">&nbsp; Please Wait</asp:TableCell>
        </asp:TableRow>
        </asp:Table>
        </ProgressTemplate>
        </asp:UpdateProgress>
        <br />

        <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="350">
            <tr style="background-color: White">
                <td style="text-align: left" class="blackfnt">
                    &nbsp;Enter No. of Rows
                </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtRows" runat="server" BorderStyle="Groove" CssClass="input" Width="100px"></asp:TextBox>
                    <asp:UpdatePanel ID="upAddRow" runat="server"   UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                            &nbsp;<asp:Button ID="btnAdd" runat="server" Text="Submit"  OnClick="btnAdd_Click" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
         </td></tr>
            <tr><td>
        <br />
        <table border="0" cellpadding="0" cellspacing="0" width="800">
            <tr style="background-color: White">
                <td style="text-align: left" class="blackfnt">
                    <asp:UpdatePanel ID="UpdatePanel1"  UpdateMode="Conditional" RenderMode="Inline" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="grvcontrols" runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                                CellSpacing="1" CssClass="boxbg" EmptyDataText="No Records Found..." FooterStyle-CssClass="boxbg"
                                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" PagerSettings-Mode="NumericFirstLast"
                                PagerStyle-HorizontalAlign="left" Width="100%" ShowFooter="True" OnRowDataBound="grvcontrols_RowDataBound">
                                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                                <FooterStyle CssClass="boxbg" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr. No.">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                        <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblsrno" runat="server" Text="<%# Container.DataItemIndex+1 %>"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:TemplateField HeaderText="Account Code">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                        <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            &nbsp;<asp:TextBox ID="txtAccCode" runat="server" BorderStyle="Groove" CssClass="input"
                                                Enabled="true" Width="100px"></asp:TextBox>
                                            <input id="btnAccCode" type="button" value="..." runat="server" />
                                            <asp:Button ID="btnAccCode" runat="server" Text="..." />
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                    <asp:TemplateField HeaderText="Account Code">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                        <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            &nbsp;<asp:TextBox ID="txtAccCode" runat="server" BorderStyle="Groove" CssClass="input"
                                                Enabled="true" Width="100px"></asp:TextBox>
                                            <%--<input id="btnAccCode" type="button" value="..." runat="server" />--%>
                                            <asp:TextBox ID="txtDescription" runat="server" BorderStyle="Groove"
                                                Width="150px" CssClass="input" ></asp:TextBox>
                                            <asp:Button ID="btnAccCode" runat="server" Text="..." />
                                            
                                              </ItemTemplate>
                                               <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                               <FooterTemplate>
                                            <strong>&nbsp; Total</strong>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:TemplateField HeaderText="Description">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                        <ItemTemplate>
                                            &nbsp;<asp:TextBox ID="txtDescription" runat="server" BorderStyle="Groove"
                                                Width="150px" CssClass="input" TextMode="MultiLine"></asp:TextBox>&nbsp;
                                        </ItemTemplate>
                                        <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                        <FooterTemplate>
                                            <strong>&nbsp; Total</strong>
                                        </FooterTemplate>
                                    </asp:TemplateField>--%>
                                    <asp:TemplateField HeaderText="Amount">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                        <ItemTemplate>
                                            &nbsp;
                                            <asp:TextBox ID="txtAmt" onchange="javascript:Nagative_Chk_wDecimal(this)" runat="server"
                                                BorderStyle="Groove" CssClass="input" Width="100px" Text="0.00" ></asp:TextBox>
                                        </ItemTemplate>
                                        <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                        <FooterTemplate>
                                            &nbsp;&nbsp;<asp:TextBox ID="txtTotAmt" runat="server" CssClass="input" BorderStyle="Groove"
                                                Width="100px" MaxLength="10" Enabled="False"></asp:TextBox>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Narration">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                        <FooterStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            &nbsp;
                                            <asp:TextBox ID="txtNarration"  onblur="javascript:this.value=this.value.toUpperCase()"  runat="server" BorderStyle="Groove" CssClass="input" TextMode="MultiLine" Width="150px"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <PagerStyle HorizontalAlign="Left" />
                            </asp:GridView>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
         </td></tr>
           
            <tr><td>
        <br />
        <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="800">
            <tr class="bgbluegrey">
                <td style="text-align: center" class="blackfnt" colspan="2">
                  <asp:CheckBox ID="Svctax_yn" runat="server" AutoPostBack="true" onclick="javascript:GetTot()" /> <strong> <font  color="red">Plz Check Here to Enable Service Tax </font></strong>
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
                <td style="text-align: left" class="blackfnt"><asp:DropDownList ID="Tdssection" runat="server">
                               
                            </asp:DropDownList>
                   </td>
            </tr>
            <tr style="background-color: White">
                <td style="text-align: left" class="blackfnt">
                    &nbsp;Service tax (+)
                </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtServiceTax" runat="server" onchange="javascript:Nagative_Chk_wDecimal(this)" BorderStyle="Groove" 
                        CssClass="input" Width="80px" Enabled="False"  Text="0.00"></asp:TextBox>
                    <asp:HiddenField ID="HdnServiceTax" runat="server" />
                                    <asp:HiddenField ID="HdnServiceTaxRate" runat="server" />
                </td>
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
                    &nbsp;<asp:TextBox ID="txtEduCess" runat="server" onchange="javascript:Nagative_Chk_wDecimal(this)" BorderStyle="Groove" 
                        CssClass="input" Width="80px" Enabled="False" Text="0.00"></asp:TextBox>
                    <asp:HiddenField ID="HdnEduCess" runat="server" />
                                    <asp:HiddenField ID="HdnEduCessRate" runat="server" />
                </td>
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
                    &nbsp;<asp:TextBox ID="txtHEduCess" runat="server" onchange="javascript:Nagative_Chk_wDecimal(this)" BorderStyle="Groove" 
                        CssClass="input" Width="80px" Enabled="False" Text="0.00"></asp:TextBox>
                    <asp:HiddenField ID="HdnHEduCess" runat="server" />
                                    <asp:HiddenField ID="HdnHEduCessRate" runat="server" />
                </td>
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
            
           <tr class="bgbluegrey">
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
        </tr>
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
            </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
