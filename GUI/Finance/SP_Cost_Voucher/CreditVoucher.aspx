<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
     CodeFile="CreditVoucher.aspx.cs" Inherits="GUI_Finance_Accounts_Debit_Voucher_DebitVoucher"
    Title="Credit Voucher" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"> </script>

    <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>

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
    //debugger;
    var str="";
    for(var i=0;i<id.length-10;i++)
    {
        str+=id.charAt(i);
    }
    document.getElementById(id).value=document.getElementById(id).value.toUpperCase()
    var txtAccCode=document.getElementById(id);
    var txtDescription=document.getElementById(id.substring(0,id.length - 10) + "txtDescription");
  
    var AccCode=txtAccCode.value;
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
                    //debugger;
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
    debugger;
    var txtManualBillno=document.getElementById(id);
    var Manualbill = txtManualBillno.value;
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
                        alert("Manual Bill Number is Already Exists... Please Enter Other Mumber");
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
   
    var txtLocation=document.getElementById(id);
   
    var Location=txtLocation.value;
    if(Location=="")
        return false;
 
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
   // alert(Location)
     var strpg="CheckVendorCode.aspx?mode=Paid&Code=" + Location + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
             if(findobj.readyState==4 && findobj.status==200)
                {
                    var res=findobj.responseText.split("|");
                    if(res[0]=="false")
                    {
                        alert("Customer/Vendor Code is not Valid... Please Enter Valid Vendor Code");
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
        window.open('popup-vendor.aspx' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
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
                 Acccode=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtAccCode").value;
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
        if(document.getElementById("ctl00_MyCPH1_Svctax_yn").checked && document.getElementById("ctl00_MyCPH1_Onaccount").checked)
        {
                alert("IF Cheque Is On Account- Can not Apply Service tax");
                //document.getElementById("ctl00_MyCPH1_Svctax_yn").checked=false
            //    return false;
        }
        if(document.getElementById("ctl00_MyCPH1_TDS_yn").checked && document.getElementById("ctl00_MyCPH1_Onaccount").checked)
        {
                alert("IF Cheque Is On Account- Can not Apply TDS");
               // document.getElementById("ctl00_MyCPH1_TDS_yn").checked=false
               // return false;
        }
        //alert(document.getElementById("ctl00_MyCPH1_Svctax_yn").checked)
        if(document.getElementById("ctl00_MyCPH1_Svctax_yn").checked)
        {
      document.getElementById("ctl00_MyCPH1_txtServiceTax").value=rounditn((parseFloat(AmtAppl.value)*12/100),2);
      document.getElementById("ctl00_MyCPH1_txtEduCess").value=rounditn((parseFloat(document.getElementById("ctl00_MyCPH1_txtServiceTax").value)*2/100),2);
      document.getElementById("ctl00_MyCPH1_txtHEduCess").value=rounditn((parseFloat(document.getElementById("ctl00_MyCPH1_txtServiceTax").value)*1/100),2);
      }
      else
      {
       document.getElementById("ctl00_MyCPH1_txtServiceTax").value="0.00";
      document.getElementById("ctl00_MyCPH1_txtEduCess").value="0.00";
      document.getElementById("ctl00_MyCPH1_txtHEduCess").value="0.00";
   
      }

        
        
        var TP = parseFloat(Number(AmtAppl.value)+ Number(document.getElementById("ctl00_MyCPH1_txtServiceTax").value) + Number(document.getElementById("ctl00_MyCPH1_txtEduCess").value) + Number(document.getElementById("ctl00_MyCPH1_txtHEduCess").value));
        
        var AmtApplL = document.getElementById("ctl00_MyCPH1_txtAmtApplL");
        
//        AmtApplL.value = parseFloat(Number(AmtAppl.value) + Number(TP)).toFixed(2);
        AmtApplL.value = roundit(TP,2);
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
        
        var txtNetPay =  document.getElementById("ctl00_MyCPH1_txtNetPay");
        txtNetPay.value = Math.round(parseFloat(Number(AmtAppl.value) - Number(txtTDSAmt.value)+ Number(document.getElementById("ctl00_MyCPH1_txtServiceTax").value) + Number(document.getElementById("ctl00_MyCPH1_txtEduCess").value) + Number(document.getElementById("ctl00_MyCPH1_txtHEduCess").value)).toFixed(2));
        document.getElementById("ctl00_MyCPH1_txtAmtApplA").value=txtNetPay.value
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
//	    var txtPanNo = document.getElementById("ctl00_MyCPH1_txtPanNo");
//	    var txtTDSAmt= document.getElementById("ctl00_MyCPH1_txtTDSAmt");
//	    if(txtTDSAmt.value == 0.00 || txtTDSAmt.value == "")
//        {
//            alert("TDS Amount is 0");
//            txtPanNo.value = "";
//            return false;
//        }
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
	function CheckData()
	{
	    //debugger
	    var ddlBusinessDiv =  document.getElementById("ctl00_MyCPH1_ddlBusinessDiv");   
        var txtVoucherDate = document.getElementById("ctl00_MyCPH1_txtVoucherDate");
        var txtManualNo = document.getElementById("ctl00_MyCPH1_txtManualNo");
        var txtPreparedLoc = document.getElementById("ctl00_MyCPH1_txtPreparedLoc");
        var txtPreparedBy = document.getElementById("ctl00_MyCPH1_txtPreparedBy");
        var txtAccLoc = document.getElementById("ctl00_MyCPH1_txtAccLoc");
        var txtPreparedFor = document.getElementById("ctl00_MyCPH1_txtPreparedFor");
        var txtReferenceNo = document.getElementById("ctl00_MyCPH1_txtReferenceNo");
        var txtPaidTo = document.getElementById("ctl00_MyCPH1_txtPaidTo");
        
        var ddlPayMode = document.getElementById("ctl00_MyCPH1_ddlPayMode");
        var txtCashAmt = document.getElementById("ctl00_MyCPH1_txtCashAmt");
        var txtChqAmt = document.getElementById("ctl00_MyCPH1_txtChqAmt");
        var txtChqNo = document.getElementById("ctl00_MyCPH1_txtChqNo");
        var txtAcc = document.getElementById("ctl00_MyCPH1_txtAcc");
        var txtBank = document.getElementById("ctl00_MyCPH1_txtBank");
        var txtChqDate = document.getElementById("ctl00_MyCPH1_txtChqDate");
        var ddrCashcode = document.getElementById("ctl00_MyCPH1_ddrCashcode");
        var ddrBankaccode = document.getElementById("ctl00_MyCPH1_ddrBankaccode");
        var txtCode =  document.getElementById('ctl00$MyCPH1$txtCode');
         var Dr_Pbov_list =  document.getElementById('ctl00$MyCPH1$Dr_Pbov_list');
       
        
        if(txtVoucherDate.value == "")
        {
            alert("Please Enter Voucher Date");
            return false;
        }
        
                             var server_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
                                var dt =txtVoucherDate.value
				               
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
						txtVoucherDate.focus();
						return false;
				}
				
				if (dt>server_dt)
				 {
						                alert( "Debit Voucher Date should not be greater than today's date !!!")
						               txtVoucherDate.focus();
						                return false;
				 }
        
        if(ddlBusinessDiv.value == "-1")
	    {
	        alert("Please Selet Business Division");
	        return false;
	    }
//        else if(txtManualNo.value == "")
//        {
//            alert("Please Enter Manual No");
//            return false;
//        }

        if(txtCode.value=="" && Dr_Pbov_list.value=="")
        {
            alert("Please Select  Customer/Vendor/Employee from List");
            Dr_Pbov_list.focus()
            return false;
        }
        if(txtPreparedLoc.value == "")
        {
            alert("Please Enter Prepared Location");
            return false;
        }
        if(txtPreparedBy.value == "")
        {
            alert("Please Enter Prepared By");
            return false;
        }
        if(txtAccLoc.value == "")
        {
            alert("Please Enter Account Location");
            return false;
        }
////        if(txtPreparedFor.value == "")
////        {
////            alert("Please Enter Prepared For");
////            return false;
////        }
////        if(txtReferenceNo.value == "")
////        {
////            alert("Please Enter Reference No");
////            return false;
////        }
       //var FromMaster = document.getElementById("ctl00_MyCPH1_FromMaster");
      // var FromOther = document.getElementById("ctl00_MyCPH1_FromOther");
	   
//        if(txtPaidTo.value == "" && FromMaster.checked==true)
//        {
//            alert("Please Enter Customer/Vendor Name");
//            txtPaidTo.focus();
//            return false;
//        }
//        if(txtCode.value == "" && FromOther.checked==true)
//        {
//            if(document.getElementById("ctl00_MyCPH1_Onaccount").checked)
//            {
//                 alert("Please Enter Vendor / Customer From Master");
//                //txtCode.focus();
//                return false;
//            }
//           
//            alert("Please Enter Name");
//            txtCode.focus();
//            return false;
//        }
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
	   var txtSrvTaxNo = document.getElementById("ctl00_MyCPH1_txtSrvTaxNo");
	   var txtPanNo = document.getElementById("ctl00_MyCPH1_txtPanNo");
	   var txtTDSAmt= document.getElementById("ctl00_MyCPH1_txtTDSAmt");
	   
	   if(parseFloat(txtServiceTax.value) > 0.00)
       {
            if(txtSrvTaxNo.value == "")
            {
                alert("Please Enter Service Tax No.");
                return false;
            }
            
       }
       if(txtTDSAmt.value != 0.00)
       {
            if(txtPanNo.value == "")
            {
                alert("Please Enter Pan No.");
                return false;
            }
       }
       
        if(ddlPayMode.value == "-1")
        {
            alert("Please Enter Payment Mode");
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
            var Diposited_0 = document.getElementById("ctl00_MyCPH1_rdDiposited_0");
            var txtRecBank = document.getElementById("ctl00_MyCPH1_txtRecBank");
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
             if(txtBank.value == "")
            {
                alert("Please Enter Bank Name");
                return false;
            }
             if(txtChqDate.value == "")
            {
                alert("Please Enter Cheque Date");
                return false;
            }
       }
       
       if(ddlPayMode.value == "Cash" && document.getElementById("ctl00_MyCPH1_Onaccount").checked )
        {
                 alert("IF Cheque Is On Account- Can not Select Payment Mode as Cash");
               // document.getElementById("ctl00_MyCPH1_Svctax_yn").checked=false
                return false;
        
        }
       
       if(document.getElementById("ctl00_MyCPH1_Svctax_yn").checked && document.getElementById("ctl00_MyCPH1_Onaccount").checked)
        {
                alert("IF Cheque Is On Account- Can not Apply Service tax");
               // document.getElementById("ctl00_MyCPH1_Svctax_yn").checked=false
                return false;
        }
        if(document.getElementById("ctl00_MyCPH1_TDS_yn").checked && document.getElementById("ctl00_MyCPH1_Onaccount").checked)
        {
                alert("IF Cheque Is On Account- Can not Apply TDS");
                //document.getElementById("ctl00_MyCPH1_Svctax_yn").checked=false
                return false;
        }
       
       //document.getElementById("ctl00_MyCPH1_txtPaidTo_Name").disabled=false
        
	}
/****function enabledisable_Name()
 {
 
       var FromMaster = document.getElementById("ctl00_MyCPH1_FromMaster");
       var FromOther = document.getElementById("ctl00_MyCPH1_FromOther");
       var txtPaidTo_Name = document.getElementById("ctl00_MyCPH1_txtPaidTo_Name")
	   var txtPaidTo = document.getElementById("ctl00_MyCPH1_txtPaidTo");
	  
	   var txtCode= document.getElementById("ctl00_MyCPH1_txtCode");
	  // alert(FromMaster.checked)
	   if(FromMaster.checked)
	   {
	   txtPaidTo.disabled=false
	   txtCode.value=""
	   
	   txtCode.disabled=true
	  
	   }
	  // alert(FromOther.checked)
	   if(FromOther.checked)
	   {
	   txtCode.disabled=false
	   txtPaidTo.value=""
	   txtPaidTo_Name.value=""
	   txtPaidTo.disabled=true
	  
	   }
	   
 }*/
 function bankEnable_ondeposit()
 {
 
       var Diposited_0 = document.getElementById("ctl00_MyCPH1_rdDiposited_0");
       var Bankaccode = document.getElementById("ctl00_MyCPH1_ddrBankaccode");
       var ddlPayMode = document.getElementById("ctl00_MyCPH1_ddlPayMode");
       var RecBank = document.getElementById("ctl00_MyCPH1_txtRecBank");
       
      // alert(ddlPayMode.value)
     	 if(ddlPayMode.value == "Bank" || ddlPayMode.value == "Both" )
        {
          // alert(Diposited_0.checked)
	       if(Diposited_0.checked)
	       {
	        //alert(Bankaccode.disabled)
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
 
    </script>

    <div style="width: 10.0in; text-align: right">
        <a href="javascript:window.history.go(-1)" title="back">
            <img alt="back" src="../../images/back.gif" border="0" /></a>
    </div>
    <div style="text-align: center; width: 10.0in">
        <table cellspacing="1" class="boxbg" width="800">
            <tr class="bgbluegrey">
                <td align="center">
                    <strong>Credit Voucher</strong>
                </td>
            </tr>
        </table>
        <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label><br />
       <asp:UpdatePanel ID="UpdatePanel3" runat="server"      UpdateMode="Conditional" RenderMode="Inline">
    <ContentTemplate>  
  <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="800">
    <tr style="background-color: White"> 
      <td style="text-align: left; width: 151px;" class="blackfnt"> &nbsp;Voucher 
        No</td>
      <td style="text-align: left" class="blackfnt"> <span style="color: #ff0000">&nbsp;&lt;System 
        Generated&gt;</span></td>
      <td style="text-align: left" class="blackfnt"> &nbsp;Voucher Date</td>
      <td style="text-align: left" class="blackfnt"> &nbsp; <asp:TextBox ID="txtVoucherDate" runat="server" onblur="javascript:ValidateDate(this)"
                        Width="80px" BorderStyle="Groove" CssClass="input" MaxLength="10"></asp:TextBox> 
        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtVoucherDate,'anchor1','dd/MM/yyyy'); return false;"
                        id="anchor1" name="anchor1"> <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a></td>
      <td style="text-align: left" class="blackfnt"> &nbsp;Manual No.</td>
      <td style="text-align: left" class="blackfnt"> &nbsp; <asp:TextBox ID="txtManualNo" runat="server" BorderStyle="Groove" CssClass="blackfnt" Width="100px"></asp:TextBox></td>
    </tr>
    <tr style="background-color: White"> 
      <td style="text-align: left; width: 151px;" class="blackfnt"> &nbsp;Prepared 
        at location</td>
      <td style="text-align: left" class="blackfnt"> &nbsp; <asp:TextBox ID="txtPreparedLoc" runat="server" BorderStyle="Groove" CssClass="input" Width="100px"></asp:TextBox> 
        <input id="btnPreparedLoc" type="button" value="..." runat="server" /></td>
      <td style="text-align: left" class="blackfnt"> &nbsp;Prepared By</td>
      <td style="text-align: left" class="blackfnt"> &nbsp; <asp:TextBox ID="txtPreparedBy" runat="server" BorderStyle="Groove" CssClass="input" Width="100px"></asp:TextBox></td>
      <td style="text-align: left" class="blackfnt"> &nbsp;Business Division</td>
      <td style="text-align: left" class="blackfnt"> &nbsp; <asp:DropDownList ID="ddlBusinessDiv" runat="server" Width="105px"> 
        </asp:DropDownList></td>
    </tr>
    <tr style="background-color: White"> 
      <td style="text-align: left; width: 151px;" class="blackfnt"> &nbsp;Accounting 
        Location</td>
      <td style="text-align: left" class="blackfnt"> &nbsp; <asp:TextBox ID="txtAccLoc" runat="server" BorderStyle="Groove" CssClass="input" Width="100px"></asp:TextBox> 
        <input id="btnAccLoc" type="button" value="..." runat="server" /></td>
      <td style="text-align: left" class="blackfnt"> &nbsp;Prepared For</td>
      <td style="text-align: left" class="blackfnt"> &nbsp; <asp:TextBox ID="txtPreparedFor" runat="server" BorderStyle="Groove" CssClass="blackfnt" Width="100px"></asp:TextBox></td>
      <td style="text-align: left" class="blackfnt"> &nbsp;Reference No.</td>
      <td style="text-align: left" class="blackfnt"> &nbsp; <asp:TextBox ID="txtReferenceNo" runat="server" BorderStyle="Groove" CssClass="blackfnt" Width="100px" MaxLength="10"></asp:TextBox></td>
    </tr>
   
    <tr style="background-color: White"> 
      <td rowspan="3" class="blackfnt" style="text-align: left; "> &nbsp;Paid 
        To</td>
      <td align="left"> <asp:RadioButton ID="RAD_Customer"  Checked="true" AutoPostBack="true" GroupName="Pbov_list" runat="server"   Text="Customer" OnCheckedChanged="Show_Pbov_list" />  </td>
      <td colspan="2" align="left"><asp:RadioButton ID="RAD_Vendor" AutoPostBack="true" GroupName="Pbov_list" runat="server"  Text="Vendor" OnCheckedChanged="Show_Pbov_list" /></td>
      <td colspan="2" align="left"><asp:RadioButton ID="RAD_Emp" AutoPostBack="true" GroupName="Pbov_list" runat="server"   Text="Employee" OnCheckedChanged="Show_Pbov_list" /></td>
    </tr>
   
    <tr style="background-color: White"> 
       
      <td colspan="5" align="left"> 
      
        <%--<%--<asp:UpdatePanel ID="UpdatePanel3"     UpdateMode="Conditional" RenderMode="Inline" runat="server">  <ContentTemplate>--%>
       <%-- <asp:RadioButton ID="FromMaster" GroupName="grpcri" runat="server"  Checked="true" onclick="javacript:enabledisable_Name()" /> --%>
        &nbsp;<%-- <asp:TextBox ID="txtPaidTo" runat="server" BorderStyle="Groove" CssClass="Blackfnt" Width="100"></asp:TextBox> --%>
        <%--<asp:TextBox ID="txtPaidTo_Name" runat="server" BorderStyle="Groove" CssClass="Blackfnt" Width="250" Enabled="false"></asp:TextBox> --%>
        <%--<input id="btnPaidTo" type="button" onclick="openVend()" value="..." ToolTip="vendor" runat="server" /> --%>
      <%--  <asp:Button ID="btnPaidTo" OnClientClick="javascript:openVend()" Text="Vendor"  CssClass="blackfnt" ToolTip="Vendor" runat="server" /> 
        <asp:Button ID="Button1" OnClientClick="javascript:openCust()" Text="Customer"  CssClass="blackfnt" ToolTip="Customer" runat="server" /> --%>
       <asp:DropDownList ID="Dr_Pbov_list" runat="server" Width="300px" CssClass="blackfnt"     ></asp:DropDownList>
      
      </td>
    </tr>
     
    <tr style="background-color: White"> 
      <td colspan="5" align="left"> <%--<asp:RadioButton ID="FromOther" GroupName="grpcri" runat="server"  onclick="javacript:enabledisable_Name()"/> --%>
        <b>8888 :</b> <asp:TextBox  ID="txtCode" runat="server" BorderStyle="Groove" CssClass="Blackfnt" Width="250px" ></asp:TextBox></td>
    </tr>
    <%--<tr style="background-color: White">
                <td style="text-align: left; width: 151px;" class="blackfnt">
                    &nbsp;Received From</td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtPaidTo" runat="server" BorderStyle="Groove" CssClass="blackfnt" Width="100px"></asp:TextBox>
                    <input id="btnPaidTo" type="button" onclick="openVend()" value="..." runat="server" /></td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;Name</td>
                <td style="text-align: left" class="blackfnt" colspan="3">
                    &nbsp;<asp:TextBox ID="txtCode" runat="server" BorderStyle="Groove" CssClass="blackfnt" Width="250px"></asp:TextBox></td>
            </tr>--%>
    <tr style="background-color: White"> 
      <td style="text-align: left; width: 151px;" class="blackfnt"> &nbsp;Narration</td>
      <td style="text-align: left" colspan="5" class="blackfnt"> &nbsp; <asp:TextBox ID="txtNarration" runat="server" onblur="javascript:this.value=this.value.toUpperCase()" BorderStyle="Groove" CssClass="blackfnt" TextMode="MultiLine" Width="150px"></asp:TextBox></td>
    </tr>
  </table>
    </ContentTemplate>
       </asp:UpdatePanel>
        <br />
        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
        <asp:Table ID="Table1" runat="server">
        <asp:TableRow>
        <asp:TableCell><asp:Image ID="imgwaiting" runat="server" ImageUrl="~/GUI/images/indicator.gif" /></asp:TableCell>
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
                    &nbsp;<asp:TextBox ID="txtRows" runat="server" onkeypress="javascript:return validInt(event)" BorderStyle="Groove" CssClass="blackfnt" Width="100px"></asp:TextBox>
                    <asp:UpdatePanel ID="upAddRow" runat="server"    UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                            &nbsp;<asp:Button ID="btnAdd" runat="server" Text="Submit"  OnClick="btnAdd_Click" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
        <br />
        <table border="0" cellpadding="0" cellspacing="0" width="800">
            <tr style="background-color: White">
                <td style="text-align: left" class="blackfnt">
                    <asp:UpdatePanel ID="UpdatePanel1"   UpdateMode="Conditional" RenderMode="Inline" runat="server">
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
                                            &nbsp;&nbsp;
                                        </ItemTemplate>
                                       
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
                                            <asp:TextBox ID="txtNarration" runat="server" onblur="javascript:this.value=this.value.toUpperCase()" BorderStyle="Groove" CssClass="input" TextMode="MultiLine" Width="150px"></asp:TextBox>
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
                    &nbsp;Service tax (+)
                </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtServiceTax" runat="server" onchange="javascript:Nagative_Chk_wDecimal(this)" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="False"></asp:TextBox></td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;TDS Section
                </td>
                <td style="text-align: left" class="blackfnt">
                   &nbsp;<asp:DropDownList ID="Tdssection" runat="server" Width="200px" >
                               
                            </asp:DropDownList></td>
            </tr>
            <tr style="background-color: White">
                <td style="text-align: left" class="blackfnt">
                    &nbsp;Education Cess (+)
                </td>
                <td style="text-align: left" class="blackfnt"> 
                    &nbsp;<asp:TextBox ID="txtEduCess" runat="server" onchange="javascript:Nagative_Chk_wDecimal(this)" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="False"></asp:TextBox></td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;TDS Rate
                </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtTDSRate" runat="server" BorderStyle="Groove" onchange="javascript:Nagative_Chk_wDecimal(this)" CssClass="input" Width="80px"></asp:TextBox></td>
            </tr>
            <tr style="background-color: White">
                <td style="text-align: left" class="blackfnt">
                    &nbsp;Higher Education Cess (+)
                </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtHEduCess" runat="server" onchange="javascript:Nagative_Chk_wDecimal(this)" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="False"></asp:TextBox></td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;TDS Amount (-)
                </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtTDSAmt" runat="server" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="False"></asp:TextBox></td>
            </tr>
            <tr style="background-color: White">
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
            </tr>
        </table>
        <br />
        <asp:UpdatePanel ID="UpdatePanel2" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>
                <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="800">
                    <tr style="background-color: White">
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Payment Mode
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:DropDownList ID="ddlPayMode" runat="server" Width="87px" AutoPostBack="True"
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
                            &nbsp;<asp:TextBox ID="txtAmtApplA" runat="server" BorderStyle="Groove" CssClass="blackfnt" Width="80px" Enabled="False"></asp:TextBox></td>
                    </tr>
                    <tr style="background-color: White">
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Cash Amount
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:TextBox ID="txtCashAmt" runat="server" onchange="javascript:Nagative_Chk_wDecimal(this)" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="False"></asp:TextBox></td>
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
                            &nbsp;Cheque Amount
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:TextBox ID="txtChqAmt" runat="server"  onchange="javascript:Nagative_Chk_wDecimal(this)" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="False"></asp:TextBox></td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Deposited</td>
                        <td style="text-align: left" class="blackfnt">
                        <asp:RadioButtonList ID="rdDiposited" runat="server" 
                                RepeatDirection="Horizontal" onclick="javacript:bankEnable_ondeposit()">
                                <asp:ListItem Selected="True" Value="Y">Yes</asp:ListItem>
                                <asp:ListItem Value="N">No</asp:ListItem>
                            </asp:RadioButtonList>
                       </td>
                    </tr>
                    <tr style="background-color: White">
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Cheque No.
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:TextBox ID="txtChqNo" MaxLength="6" Columns="6" runat="server" BorderStyle="Groove" CssClass="input" Width="150px" Enabled="False"></asp:TextBox></td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Deposited in Bank</td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:DropDownList ID="ddrBankaccode" runat="server"  >
                             </asp:DropDownList>
                       </td>
                    </tr>
                    <tr style="background-color: white">
                        <td class="blackfnt" style="text-align: left">
                            &nbsp;Cheque Date
                        </td>
                        <td class="blackfnt" style="text-align: left">
                            &nbsp;<asp:TextBox ID="txtChqDate" runat="server" onblur="javascript:ValidateDate(this)"
                                BorderStyle="Groove" CssClass="input" MaxLength="10" Width="80px"></asp:TextBox>
                            <a href="#" onclick="cal.select(ctl00$MyCPH1$txtChqDate,'anchor11','dd/MM/yyyy'); return false;"
                                id="a1" name="anchor11">
                                <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a></td>
                        <td class="blackfnt" style="text-align: left">
                            &nbsp;Received From Bank</td>
                        <td class="blackfnt" style="text-align: left">
                            &nbsp;<asp:TextBox ID="txtRecBank" runat="server" BorderStyle="Groove" CssClass="input"
                                Enabled="False" Width="80px"></asp:TextBox></td>
                    </tr>
                    <tr style="background-color: White">
                        <td style="text-align: left" class="blackfnt">
                        On Account Yes/NO 
                        </td>
                        <td style="text-align: left" class="blackfnt">
                        <asp:CheckBox runat="server" ID="Onaccount" onclick="javascript:GetTot()"  />
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            <strong>&nbsp;NET RECEIVED</strong></td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:TextBox ID="txtNetPay" runat="server" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="False"></asp:TextBox></td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <br />
        <table cellspacing="1" class="boxbg" width="800">
            <tr class="bgbluegrey">
                <td align="center">
                    <asp:Button ID="btnSubmit" runat="server" OnClientClick="javascript:return CheckData();" BorderStyle="Solid" BorderWidth="1px" Text="SUBMIT"
                        Width="150px" OnClick="btnSubmit_Click" /></td>
            </tr>
        </table>
    </div>
    <br />
    <div id="Div1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
