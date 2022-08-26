<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="JobOrder.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_VendorBillEntry_Jobsheet_JobOrder" %>
<%@ Register TagName="UCTAX" TagPrefix="UCMyServiceTDSVAT" Src="~/UserControls/ServiceTDSVAT.ascx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<script language="javascript" type="text/javascript" src="../../../../images/commonJs.js"></script>
    <script language="javascript" type="text/javascript" src="../../../../images/CalendarPopup.js"></script>
     <script language="javascript" type="text/javascript">
    var cal = new CalendarPopup("Div1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
    </script>
    <script language="javascript" type="text/javascript">
     
//   function calculation()
//   
//   {
//   //alert("1")
//      var grid=document.getElementById("ctl00_MyCPH1_gvJobOrderDetail");
//      var r=grid.rows.length;
//      var mTotJobCost=0;
//      var mTotPartCost=0;
//      var mTotLabourCost=0;
//      //alert("r : " + r)
//      var Fpref="";
//      for(i=0;i<r-2;i++)
//        {  
//            //alert("2")
//              j=i+2
//              j1=i+3
//              var pref="";
//              if(j<10)
//              {
//              pref = "ctl00_MyCPH1_gvJobOrderDetail_ctl0" + j + "_";
//              Fpref = "ctl00_MyCPH1_gvJobOrderDetail_ctl0" + j1 + "_";
//              }                                       
//              else
//              {         
//              pref = "ctl00_MyCPH1_gvJobOrderDetail_ctl" + j + "_";
//              Fpref = "ctl00_MyCPH1_gvJobOrderDetail_ctl" + j1 + "_";
//              }    
//              
//              
//            var mSelect= document.getElementById(pref + "chkJobOrder");

//            var mLabourCost= document.getElementById(pref + "TOT_ACT_LABOUR_COST").innerText ;
//            var mPartCost= document.getElementById(pref + "TOT_ACT_PART_COST").innerText ;


//            var mJobCost= document.getElementById(pref + "TOT_JOB_COST").innerText ;
//            
//            //alert("3")  
//            //alert("mJobCost : " + mJobCost)
//            if(mSelect.checked==true)
//             { 
//                mTotLabourCost =parseFloat(mTotLabourCost) + parseFloat(mLabourCost);
//                mTotPartCost =parseFloat(mTotPartCost) + parseFloat(mPartCost);
//                mTotJobCost =parseFloat(mTotJobCost) + parseFloat(mJobCost);
//               
//             } 
//            
//        }  
//         //alert("Fpref : " + Fpref);
//        document.getElementById('ctl00$MyCPH1$txtBillAmt').value=rounditn(mTotJobCost,2);
//        
//        document.getElementById(Fpref + "txtTotLabourCost").value=rounditn(mTotLabourCost,2);
//        document.getElementById(Fpref + "txtTotPartCost").value=rounditn(mTotPartCost,2);
//        document.getElementById(Fpref + "txtTotJobCost").value=rounditn(mTotJobCost,2);
//        
//        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtVATAppLAmt").value=rounditn(mTotPartCost,2);
//        document.getElementById("ctl00$MyCPH1$UCMyServiceTDSVAT1$txtAmtAppl").value=rounditn(mTotLabourCost,2);
//        document.getElementById("ctl00$MyCPH1$UCMyServiceTDSVAT1$txtAmtApplL").value=rounditn(mTotLabourCost,2);
//        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTotLabourApplAmt").innerText=rounditn(mTotLabourCost,2);
//        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTotPartApplAmt").innerText=rounditn(mTotPartCost,2);
//        
//        GetTotal();
//        
//   
//   }  
   
   
    function calculation()
   
   {
    //alert("1")
      var grid=document.getElementById("ctl00_MyCPH1_gvJobOrderDetail");
      var r=grid.rows.length;
      var mTotJobCost=0;
      var mTotPartCost=0;
      var mTotLabourCost=0;
      //alert("r : " + r)
      var Fpref="";
      for(i=0;i<r-2;i++)
        {  
            //alert("2")
              j=i+2
              j1=i+3
              var pref="";
              if(j<10)
              {
              pref = "ctl00_MyCPH1_gvJobOrderDetail_ctl0" + j + "_";
              //Fpref = "ctl00_MyCPH1_gvJobOrderDetail_ctl0" + j1 + "_";
              }                                       
              else
              {         
              pref = "ctl00_MyCPH1_gvJobOrderDetail_ctl" + j + "_";
              //Fpref = "ctl00_MyCPH1_gvJobOrderDetail_ctl" + j1 + "_";
              }
              
               if(j1<10)
              {
              Fpref = "ctl00_MyCPH1_gvJobOrderDetail_ctl0" + j1 + "_";
              }                                       
              else
              {         
              Fpref = "ctl00_MyCPH1_gvJobOrderDetail_ctl" + j1 + "_";
              }
              
              
            var mSelect= document.getElementById(pref + "chkJobOrder");

            var mLabourCost= document.getElementById(pref + "TOT_ACT_LABOUR_COST").innerText ;
            var mPartCost= document.getElementById(pref + "TOT_ACT_PART_COST").innerText ;


            var mJobCost= document.getElementById(pref + "TOT_JOB_COST").innerText ;
            
            //alert("3")  
            //alert("mJobCost : " + mJobCost)
            if(mSelect.checked==true)
             { 
                mTotLabourCost =parseFloat(mTotLabourCost) + parseFloat(mLabourCost);
                mTotPartCost =parseFloat(mTotPartCost) + parseFloat(mPartCost);
                mTotJobCost =parseFloat(mTotJobCost) + parseFloat(mJobCost);
               
             } 
            
        }  
         //alert("Fpref : " + Fpref);
        document.getElementById('ctl00$MyCPH1$txtBillAmt').value=rounditn(mTotJobCost,2);
        
        document.getElementById(Fpref + "txtTotLabourCost").value=rounditn(mTotLabourCost,2);
        document.getElementById(Fpref + "txtTotPartCost").value=rounditn(mTotPartCost,2);
        document.getElementById(Fpref + "txtTotJobCost").value=rounditn(mTotJobCost,2);
        
        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtVATAppLAmt").value=rounditn(mTotPartCost,2);
        document.getElementById("ctl00$MyCPH1$UCMyServiceTDSVAT1$txtAmtAppl").value=rounditn(mTotLabourCost,2);
        document.getElementById("ctl00$MyCPH1$UCMyServiceTDSVAT1$txtAmtApplL").value=rounditn(mTotLabourCost,2);
        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTotLabourApplAmt").innerText=rounditn(mTotLabourCost,2);
        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTotPartApplAmt").innerText=rounditn(mTotPartCost,2);
        
        GetTotal();
        
   
   }  
     
     
     
    function createXMLHttpRequest()
    {
        // Mozilla, Safari,...
	    if (window.XMLHttpRequest){xmlHttpRequest=new XMLHttpRequest();if(xmlHttpRequest.overrideMimeType)xmlHttpRequest.overrideMimeType("text/xml");}
	    // IE
	    else if(window.ActiveXObject){try{xmlHttpRequest=new ActiveXObject("Msxml2.XMLHTTP");}catch(e){try{xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");}catch(e){}}}
    }
    
    
    
    function GetSTAXDetails(txtBillEntryDate)
    {
       
        
        if(txtBillEntryDate.value=="")
        {
            //LblSTaxRate.innerText="";
            //LblEduCess.innerText="";
            //LblHEduCess.innerText="";
            
            document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_LblSTaxRate").innerText="";
	        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_LblEduCess").innerText="";
	        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_LblHEduCess").innerText = "";
	        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_LblSBCess").innerText = "";	  // Added By Anupam
	        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_LblKKCess").innerText = "";	  // Added By Anupam
	  
            return true;
        }
        var currentTime = new Date()
        var ConnStr="<%= Session["SqlProvider"] %>";
        createXMLHttpRequest();
        if (xmlHttpRequest)
        {
            xmlHttpRequest.onreadystatechange = function()
            {
                if (xmlHttpRequest.readyState == 4)
                {
                    var returnValue=xmlHttpRequest.responseText.split("~");
                    //alert("returnValue :"+ returnValue);
                    if (returnValue[0] == "N")
                    {
                        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_LblSTaxRate").innerText="";
	                    document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_LblEduCess").innerText="";
	                    document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_LblHEduCess").innerText = "";
	                    document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_LblSBCess").innerText = "";// Added By Anupam
	                    document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_LblKKCess").innerText = "";// Added By Anupam
                        alert("No Rates Defined!!!");
                    }
                    else
                    {
                        //alert("STaxRate : " + returnValue[1]);
                        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_LblSTaxRate").innerText=returnValue[1];
                        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_LblEduCess").innerText=returnValue[2];
                        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_LblHEduCess").innerText = returnValue[3];
                        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_LblSBCess").innerText = returnValue[4];// Added By Anupam
                        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_LblKKCess").innerText = returnValue[5];// Added By Anupam
                        GetTotal();
                        
                    }
                }
            }
             //alert("ConnStr : " + ConnStr);
            //var tempstr = "wfrm_AJAX_Validator.aspx?Function=GetSTAXDetails&datetime="+currentTime+"&BillEntryDate=" + txtBillEntryDate.value+"&ConnStr="+ConnStr;
             //alert("tempstr : " + tempstr);
            xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=GetSTAXDetails&datetime="+currentTime+"&BillEntryDate=" + txtBillEntryDate.value+"&ConnStr="+ConnStr, false);
            xmlHttpRequest.send(null);
        }	
    }
    
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
	
//	function GetTotal()
//	{
//	
//	   var TotLabourApplAmtTax= document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtAmtAppl").value;
//	   var TotLabourApplAmtTDS= document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtAmtApplL").value;
//	  
//	  
//	   var VATAppLAmt= document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtVATAppLAmt").value;
//	   var VATRate=document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtVATRate").value;
//	  
//	   if(document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_vat_yn").checked)
//	   {
//	    
//	   }
//	   else
//	   {
//	    document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtVATRate").value="0.00";
//	    document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtVATAmt").value="0.00";
//	   }
//	   
//	   if(VATRate!="" && document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_vat_yn").checked)
//	   {
//	        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtVATAmt").value=parseFloat(VATAppLAmt) * (parseFloat(VATRate)/100);
//	   }
//	   else
//	   {
//	        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtVATAmt").value="0.00";
//	   }
//	   
//	  var ServiceTax="0.00";
//	  var EduCess="0.00";
//	  var HEduCess="0.00";
//	  
//	  var STaxRate="0.00";
//	  var EduCess="0.00";
//	  var HEduCess="0.00";
//	 
//	  STaxRate=document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_LblSTaxRate").innerText;
//	  EduCess=document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_LblEduCess").innerText;
//	  HEduCess=document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_LblHEduCess").innerText;
//	  
//	  if(document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_Svctax_yn").checked)
//        {
//            document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtServiceTax").value=rounditn((parseFloat(TotLabourApplAmtTax)* (parseFloat(STaxRate)/100)),2); 
//            document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtEduCess").value=rounditn((parseFloat(document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtServiceTax").value)* (parseFloat(EduCess)/100)),2);// STaxRate/EduCess/HEduCess
//            document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtHEduCess").value=rounditn((parseFloat(document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtServiceTax").value)* (parseFloat(HEduCess)/100)),2);
//            
//            ServiceTax=document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtServiceTax").value;
//            EduCess=document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtEduCess").value;
//            HEduCess=document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtHEduCess").value;
//            
//            document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTaxAmt").value= rounditn(parseFloat(ServiceTax)+ parseFloat(EduCess)+ parseFloat(HEduCess),2);

//        }
//        else
//        {
//            document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtServiceTax").value="0.00";
//            document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtEduCess").value="0.00";
//            document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtHEduCess").value="0.00";
//            
//            document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTaxAmt").value= "0.00";

//        }
//        
//        
//        
//         var TDSRate = document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTDSRate").value;
//         var TDSAmt="0.00";
//        if(document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_TDS_yn").checked)
//        {
//            TDSAmt = rounditn(Math.round(parseFloat((Number(TotLabourApplAmtTDS)* Number(TDSRate))/Number(100)).toFixed(2)),2);
//        
//        }
//        else
//        {
//            document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTDSAmt").value = "0.00";
//            document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTDSRate").value = "0.0";
//        }
//        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTDSAmt").value=TDSAmt;
//        
//        
//        
//        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTotLabourTaxAmt").value=document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTaxAmt").value;
//        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtLabourTDSAmt").value=document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTDSAmt").value;
//        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTotPartTaxAmt").value=document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtVATAmt").value;
//        
//        
//        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtNetLabourAmt").value= rounditn(parseFloat(document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTotLabourApplAmt").value) + parseFloat(document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTotLabourTaxAmt").value) - parseFloat(document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtLabourTDSAmt").value),2);
//        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtNetPartAmt").value=rounditn(parseFloat(document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTotPartApplAmt").value) + parseFloat(document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTotPartTaxAmt").value),2);
//        
//        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtNetPayableAmt").value=rounditn(parseFloat(document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtNetLabourAmt").value) + parseFloat(document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtNetPartAmt").value),2);
//        document.getElementById('ctl00$MyCPH1$txtBillAmt').value=document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtNetPayableAmt").value;
//	
//	}


function GetTotal()
	{
	
	   var TotLabourApplAmtTax= document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtAmtAppl").value;
	   var TotLabourApplAmtTDS= document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtAmtApplL").value;
	  
	  
	   var VATAppLAmt= document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtVATAppLAmt").value;
	   var VATRate=document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtVATRate").value;
	  
	   if(document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_vat_yn").checked)
	   {
	    
	   }
	   else
	   {
	    document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtVATRate").value="0.00";
	    document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtVATAmt").value="0.00";
	   }
	   
	   if(VATRate!="" && document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_vat_yn").checked)
	   {
	        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtVATAmt").value=parseFloat(VATAppLAmt) * (parseFloat(VATRate)/100);
	   }
	   else
	   {
	        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtVATAmt").value="0.00";
	   }
	   
	  var ServiceTax="0.00";
	  var EduCess="0.00";
	  var HEduCess="0.00";
	  
	  var STaxRate="0.00";
	  var EduCess="0.00";
	  var HEduCess = "0.00";
	  var SBCess = "0.00";// Added By Anupam
	  var KKCess = "0.00";// Added By Anupam
	 
	  STaxRate=document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_LblSTaxRate").innerText;
	  EduCess=document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_LblEduCess").innerText;
	  HEduCess = document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_LblHEduCess").innerText;
	  SBCess = document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_LblSBCess").innerText;// Added By Anupam
	  KKCess = document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_LblKKCess").innerText;// Added By Anupam
	  
	  if(document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_Svctax_yn").checked)
        {
            document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtServiceTax").value=rounditn((parseFloat(TotLabourApplAmtTax)* (parseFloat(STaxRate)/100)),2); 
            document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtEduCess").value=rounditn((parseFloat(document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtServiceTax").value)* (parseFloat(EduCess)/100)),2);// STaxRate/EduCess/HEduCess
            document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtHEduCess").value = rounditn((parseFloat(document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtServiceTax").value) * (parseFloat(HEduCess) / 100)), 2);
            document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtSBCess").value = rounditn((parseFloat(TotLabourApplAmtTax) * (parseFloat(SBCess) / 100)), 2); // Added By Anupam
            document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtKKCess").value = rounditn((parseFloat(TotLabourApplAmtTax) * (parseFloat(KKCess) / 100)), 2); // Added By Anupam
            
            ServiceTax=document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtServiceTax").value;
            EduCess=document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtEduCess").value;
            HEduCess = document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtHEduCess").value;
            SBCess = document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtSBCess").value;// Added By Anupam
            KKCess = document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtKKCess").value;// Added By Anupam
            
            document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTaxAmt").value = rounditn(parseFloat(ServiceTax) + parseFloat(EduCess) + parseFloat(HEduCess) + parseFloat(SBCess) + parseFloat(KKCess), 2);//Changed By Anupam //Changed by Anupam

        }
        else
        {
            document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtServiceTax").value="0.00";
            document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtEduCess").value="0.00";
            document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtHEduCess").value = "0.00";
            document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtSBCess").value = "0.00";// Added By Anupam
            document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtKKCess").value = "0.00";// Added By Anupam
            
            document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTaxAmt").value= "0.00";

        }
        
        
        
         var TDSRate = document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTDSRate").value;
         var TDSAmt="0.00";
        if(document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_TDS_yn").checked)
        {
            TDSAmt = rounditn(Math.round(parseFloat((Number(TotLabourApplAmtTDS)* Number(TDSRate))/Number(100)).toFixed(2)),2);
        
        }
        else
        {
            document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTDSAmt").value = "0.00";
            document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTDSRate").value = "0.0";
        }
        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTDSAmt").value=TDSAmt;
        
        
        
        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTotLabourTaxAmt").value=document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTaxAmt").value;
        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtLabourTDSAmt").value=document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTDSAmt").value;
        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTotPartTaxAmt").value=document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtVATAmt").value;
        
        
        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtNetLabourAmt").value= rounditn(parseFloat(document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTotLabourApplAmt").value) + parseFloat(document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTotLabourTaxAmt").value) - parseFloat(document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtLabourTDSAmt").value),2);
        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtNetPartAmt").value=rounditn(parseFloat(document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTotPartApplAmt").value) + parseFloat(document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTotPartTaxAmt").value),2);
        
        document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtNetPayableAmt").value=rounditn(parseFloat(document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtNetLabourAmt").value) + parseFloat(document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtNetPartAmt").value),2);
        document.getElementById('ctl00$MyCPH1$txtBillAmt').value=document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtNetPayableAmt").value;
	
	}
	
	
//	function GetTot()
//	{
//	    var i,Amt,TotAmt,T=0;

//            
//            T=rounditn(document.getElementById('ctl00$MyCPH1$txtBillAmt').value,2);
//           // alert("T : " + T);
//            TotAmt=rounditn(document.getElementById('ctl00$MyCPH1$txtBillAmt').value,2);
//            // alert("TotAmt : " + TotAmt);
//            
//            document.getElementById("ctl00_MyCPH1_txtAmtAppl").value=TotAmt;
//            document.getElementById("ctl00_MyCPH1_txtAmtApplL").value=TotAmt;
//            document.getElementById("ctl00_MyCPH1_txtNetPayableAmt").value=TotAmt;
//            
//            TotAmt= T;
//        
//        var AmtAppl = 0;
//        AmtAppl = roundit(TotAmt,2);
//        document.getElementById("ctl00_MyCPH1_txtAmtAppl").value=AmtAppl;
//        if(document.getElementById("ctl00_MyCPH1_Svctax_yn").checked)
//        {
//            document.getElementById("ctl00_MyCPH1_txtServiceTax").value=rounditn((parseFloat(AmtAppl)*12/100),2);
//            document.getElementById("ctl00_MyCPH1_txtEduCess").value=rounditn((parseFloat(document.getElementById("ctl00_MyCPH1_txtServiceTax").value)*2/100),2);
//            document.getElementById("ctl00_MyCPH1_txtHEduCess").value=rounditn((parseFloat(document.getElementById("ctl00_MyCPH1_txtServiceTax").value)*1/100),2);
//        }
//        else
//        {
//            document.getElementById("ctl00_MyCPH1_txtServiceTax").value="0.00";
//            document.getElementById("ctl00_MyCPH1_txtEduCess").value="0.00";
//            document.getElementById("ctl00_MyCPH1_txtHEduCess").value="0.00";
//        }
//        
//         document.getElementById("ctl00_MyCPH1_txtBillAmt").value=rounditn(parseFloat(Number(AmtAppl)),2)
//         //document.getElementById("ctl00_MyCPH1_txtNetAmt").value=rounditn(parseFloat(Number(AmtAppl))-parseFloat(document.getElementById("ctl00_MyCPH1_txtOtherDedudction").value)- parseFloat(document.getElementById("ctl00_MyCPH1_txtDiscRecvd").value),2)
//         document.getElementById("ctl00_MyCPH1_txtNetAmt").value=rounditn(parseFloat(Number(AmtAppl)),2)
//        
//        
//        var TP = parseFloat(Number(AmtAppl)+ Number(document.getElementById("ctl00_MyCPH1_txtServiceTax").value) + Number(document.getElementById("ctl00_MyCPH1_txtEduCess").value) + Number(document.getElementById("ctl00_MyCPH1_txtHEduCess").value));
//        var AmtApplL =0; 
//        AmtApplL = roundit(TP,2);
//         if(parseFloat(AmtApplL)<0)
//        {
//            AmtApplL="0.00"
//        }
//        document.getElementById("ctl00_MyCPH1_txtAmtApplL").value=AmtApplL;
//        
//        var txtTDSAmt= document.getElementById("ctl00_MyCPH1_txtTDSAmt").value;
//        var txtTDSRate = document.getElementById("ctl00_MyCPH1_txtTDSRate").value;
//        if(Number(txtTDSRate) > 100)
//        {
//            alert("TDS Rate Should not greater than 100%");
//            document.getElementById("ctl00_MyCPH1_txtTDSRate").focus();
//            document.getElementById("ctl00_MyCPH1_txtTDSRate").value = "0.0";
//            return false;
//        }
//        if(document.getElementById("ctl00_MyCPH1_TDS_yn").checked)
//        {
//            txtTDSAmt = rounditn(Math.round(parseFloat((Number(AmtApplL)* Number(txtTDSRate))/Number(100)).toFixed(2)),2);
//        
//        }
//        else
//        {
//            txtTDSAmt = "0.00";
//            txtTDSRate = "0.0";
//        }
//        document.getElementById("ctl00_MyCPH1_txtTDSAmt").value=txtTDSAmt;
//        document.getElementById("ctl00_MyCPH1_txtTDSRate").value=txtTDSRate;
//        
//        var txtNetPay = 0;
//        //txtNetPay = rounditn(parseFloat(Number(AmtAppl) - Number(txtTDSAmt)+ Number(document.getElementById("ctl00_MyCPH1_txtServiceTax").value) + Number(document.getElementById("ctl00_MyCPH1_txtEduCess").value) + Number(document.getElementById("ctl00_MyCPH1_txtHEduCess").value)-parseFloat(document.getElementById("ctl00_MyCPH1_txtOtherDedudction").value)- parseFloat(document.getElementById("ctl00_MyCPH1_txtDiscRecvd").value)),2);
//        txtNetPay = rounditn(parseFloat(Number(AmtAppl) - Number(txtTDSAmt)+ Number(document.getElementById("ctl00_MyCPH1_txtServiceTax").value) + Number(document.getElementById("ctl00_MyCPH1_txtEduCess").value) + Number(document.getElementById("ctl00_MyCPH1_txtHEduCess").value)),2);

//        
//        if(parseFloat(txtNetPay)<0)
//        {
//            txtNetPay="0.00"
//        }
//        document.getElementById("ctl00_MyCPH1_txtNetPayableAmt").value=txtNetPay;
//        return false;
//	}
//	
	
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
	 	    if(document.getElementById(frm_name+"crediit_account").innerText==":")
	 	    {
	 	        alert("No Credit Account for the same Vendor Type")
	 	        document.getElementById(frm_name+"cboVendorType").focus();
	 	        return false;
	 	    }  
	 	    
	 	    


	 	 
	          /*document.getElementById('ctl00$MyCPH1$txtBillAmt').value=rounditn(document.getElementById('ctl00$MyCPH1$txtBillAmt').value,2);
	          document.getElementById('ctl00$MyCPH1$txtNetAmt').value=rounditn(document.getElementById('ctl00$MyCPH1$txtBillAmt').value,2);
              if(document.getElementById("ctl00_MyCPH1_Svctax_yn").checked==false && document.getElementById("ctl00_MyCPH1_TDS_yn").checked==false)
                {
	                document.getElementById('ctl00$MyCPH1$txtNetPayableAmt').value=rounditn(document.getElementById('ctl00$MyCPH1$txtNetPayableAmt').value,2);
                    document.getElementById("ctl00_MyCPH1_txtAmtAppl").value=rounditn(document.getElementById('ctl00$MyCPH1$txtBillAmt').value,2);
                    document.getElementById("ctl00_MyCPH1_txtAmtApplL").value=rounditn(document.getElementById('ctl00$MyCPH1$txtBillAmt').value,2);
                }
                */
		    varNetAmt = document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtNetPayableAmt").value
	 	    if (parseFloat(varNetAmt)<=0.00)
	        {
		        alert("Net Payable Amount should be greater that zero , please specify Job order details")
		        
		        return false;
	        }
	 
	        
	     //if (CheckValid()==false)// Validation of Expense Voucher User Control
        //  {
        //    return false;
        //  }
               
       
      
      // var txtServiceTax = document.getElementById("ctl00_MyCPH1_txtServiceTax");
	 
	   var txtTDSAmt= document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTDSAmt");
	 
           if(txtTDSAmt.value != 0.00)
           {
                if(document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_Tdssection").value == "")
                {
                    alert("Please Select TDS Account");
                    document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_Tdssection").focus();
                    return false;
                }
           }
         //  alert("DOne  1")
   

	
	 if (confirm("Do you want to submit")==false)
		{
		  return false;
		}

    document.getElementById(frm_name+"txtBillAmt").disabled=false
    document.getElementById(frm_name+"txtDueDate").disabled=false
    //document.getElementById(frm_name+"txtNetAmt").disabled=false
    document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtServiceTax").disabled=false
    document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtEduCess").disabled=false
    document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTDSRate").disabled=false
    document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtHEduCess").disabled = false
    document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtSBCess").disabled = false // Changed By Anupam
    document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtKKCess").disabled = false // Changed By Anupam
    document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtTDSAmt").disabled=false
    document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtNetPayableAmt").disabled=false   
    
    document.getElementById("ctl00_MyCPH1_UCMyServiceTDSVAT1_txtVATAmt").disabled=false        
    
    //alert("Done")
	//return false;

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
     
function billdate_blur()
{
alert("hi");

}

    </script>

<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" width="45%">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Trip Finances >> Bill Entry >> Job Order</asp:Label>
 
            </td>
             <td align=left>
          </td>      
        </tr>
    </table>
    
  
    <hr align="center" size="1" color="#8ba0e5">
      
    <br />
    
  <asp:UpdateProgress ID="uppMain" runat="server">
            <ProgressTemplate>
                <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                    -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                    <tr>
                        <td align="right">
                            <img src="../../../../images/loading.gif" alt="" />
                        </td>
                        <td>
                            <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                        </td>
                    </tr>
                </table>
                <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
                    background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
                    opacity: .50; -moz-opacity: .50;" runat="server">
                    <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                        left: 50%;" ID="Panel2" runat="server">
                    </asp:Panel>
                </asp:Panel>
            </ProgressTemplate>
        </asp:UpdateProgress>
        
<table   width="800">
    <tr><td>
   
        <table cellspacing="1" class="boxbg" width="800">
            <tr class="bgbluegrey">
                <td align="center">
                    <strong>Bill Entry - Job Order</strong>
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
                    <asp:TextBox ID="txtBillEntryDate" runat="server" Width="60px" onblur="billdate_blur()" ></asp:TextBox>
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
        
        
        
        <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                        <ContentTemplate>
                            <asp:Panel runat="server" ID="Panel7" Visible="true">
                            <asp:Label ID="lblError1" runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor="red"></asp:Label>
 <table cellspacing="1" cellpadding="3" width="85%"  class="boxbg"
            border="0">
<tr class="bgbluegrey">
                                        <td colspan="4" align="left">
                                            <font class="blackfnt"><b>Job Order Details</b></font></td>
                                    </tr>
                                    <%--<tr style="background-color: white">
                                        <td width="5%" nowrap>
                                            <font class="blackfnt">Enter no. of rows</font></td>
                                        <td colspan="3" align="left">
                                            <asp:TextBox ID="txtAddRow" runat="server" MaxLength="3" Width="30" BorderStyle="Groove"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                OnTextChanged="add_row" AutoPostBack="true"></asp:TextBox></td>
                                    </tr>--%>
                                    <tr style="background-color: white">
                                        <td colspan="4" align="center">
                                            <table border="0" width="85%">
                                                <tr>
                                                    <td>
                                                    
                                                        <!--------------JOB ORDER DETAILS STARTS HERE--------------------------->
<%--FooterStyle-CssClass="bgbluegrey" ShowFooter="true"--%>
<asp:GridView ID="gvJobOrderDetail" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
AllowSorting="true" AllowPaging="true" PageSize="1000" PagerStyle-HorizontalAlign="left"
CssClass="boxbg" BackColor="white" 
PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" 
FooterStyle-CssClass="bgbluegrey" ShowFooter="true"
EmptyDataText="No Job orders available..." EmptyDataRowStyle-ForeColor="red" EmptyDataRowStyle-HorizontalAlign="Left" style="width:9.5in" OnRowCreated="gvJobOrderDetail_RowCreated">
<PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"
/>
    <FooterStyle CssClass="bgbluegrey" />
    <EmptyDataRowStyle ForeColor="Red" HorizontalAlign="Left" />
<Columns >
<asp:TemplateField >

  
           
                <ItemTemplate>
                    <center>
                    <asp:CheckBox ID="chkJobOrder" runat="server"  /><%-- AutoPostBack="true"--%>
                    </center>
                </ItemTemplate>
                
     </asp:TemplateField>


<asp:TemplateField HeaderText="Job Order Number"> 
    <ItemStyle HorizontalAlign="Left" />
    <HeaderStyle CssClass="blackfnt" />
                <ItemTemplate >
                    
                    <font class="blackfnt">
                    <asp:Label ID="JOB_ORDER_NO" Text='<%# DataBinder.Eval(Container.DataItem,"JOB_ORDER_NO") %>'  runat="server" ></asp:Label>
                    </font>
                    
                </ItemTemplate>
                
     </asp:TemplateField>


<asp:TemplateField HeaderText="Job Order date">
    <ItemStyle HorizontalAlign="Left" />
    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <ItemTemplate>
                    <font class="blackfnt">
                    <asp:Label ID="JOB_ORDER_DT" Text='<%# DataBinder.Eval(Container.DataItem,"JOB_ORDER_DT") %>'  runat="server" ></asp:Label>
                    </font>
                </ItemTemplate>
     </asp:TemplateField>
   
   <asp:TemplateField HeaderText="Job Order Close date">
       <ItemStyle HorizontalAlign="Left" />
       <HeaderStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <ItemTemplate>
                    <font class="blackfnt">
                    <asp:Label ID="JOB_ORDER_CLOSEDT" Text='<%# DataBinder.Eval(Container.DataItem,"JOB_ORDER_CLOSEDT") %>'  runat="server" ></asp:Label>
                    </font>
                </ItemTemplate>
     </asp:TemplateField>  

<asp:BoundField DataField="JobCardType" HeaderText="Job Card Type"    >
<ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
<HeaderStyle HorizontalAlign="Left" Wrap="False" CssClass="blackfnt" />
</asp:BoundField>

<asp:TemplateField HeaderText="Vehicle No.">
    <ItemStyle HorizontalAlign="Left" />
    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Left" />
                <ItemTemplate>
                    <font class="blackfnt">
                    <asp:Label ID="VEHNO" Text='<%# DataBinder.Eval(Container.DataItem,"VEHNO") %>'  runat="server" ></asp:Label>
                    </font>
                </ItemTemplate>
     </asp:TemplateField>


    <asp:TemplateField HeaderText="Total Labour Cost" ItemStyle-HorizontalAlign="Right">
        <FooterTemplate>
            <asp:TextBox ID="txtTotLabourCost" runat="server" class="input" width="95%" ReadOnly="true" ItemStyle-HorizontalAlign="Right" style="text-align: right"></asp:TextBox>
        </FooterTemplate>
        <ItemStyle HorizontalAlign="Right" />
        <HeaderStyle CssClass="blackfnt" HorizontalAlign="Right" />
                <ItemTemplate>
                    <font class="blackfnt">
                    <asp:Label ID="TOT_ACT_LABOUR_COST" Text='<%# DataBinder.Eval(Container.DataItem,"TOT_ACT_LABOUR_COST") %>'  runat="server" ></asp:Label>
                    </font>
                </ItemTemplate>
     </asp:TemplateField>
     
     <asp:TemplateField HeaderText="Total Part Cost" ItemStyle-HorizontalAlign="Right">
         <FooterTemplate>
             <asp:TextBox ID="txtTotPartCost" runat="server" class="input" width="95%" ReadOnly="true" ItemStyle-HorizontalAlign="Right" style="text-align: right"></asp:TextBox>
         </FooterTemplate>
         <ItemStyle HorizontalAlign="Right" />
         <HeaderStyle CssClass="blackfnt" HorizontalAlign="Right" />
                <ItemTemplate>
                    <font class="blackfnt">
                    <asp:Label ID="TOT_ACT_PART_COST" Text='<%# DataBinder.Eval(Container.DataItem,"TOT_ACT_PART_COST") %>'  runat="server" ></asp:Label>
                    </font>
                </ItemTemplate>
     </asp:TemplateField>
     
      <asp:TemplateField HeaderText="Total Job Cost" ItemStyle-HorizontalAlign="Right">
          <FooterTemplate>
              <asp:TextBox ID="txtTotJobCost" runat="server" class="input" width="95%" ReadOnly="true" ItemStyle-HorizontalAlign="Right" style="text-align: right" ></asp:TextBox>
          </FooterTemplate>
          <ItemStyle HorizontalAlign="Right" />
          <HeaderStyle CssClass="blackfnt" HorizontalAlign="Right" />
                <ItemTemplate>
                    <font class="blackfnt">
                    <asp:Label ID="TOT_JOB_COST" Text='<%# DataBinder.Eval(Container.DataItem,"TOT_JOB_COST") %>'  runat="server" ></asp:Label>
                    </font>
                </ItemTemplate>
     </asp:TemplateField>






</Columns>
<PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
<HeaderStyle CssClass="bgbluegrey" />
</asp:GridView>
 
<br />



                                                        <!--------------JOB ORDER DETAILS ENDS HERE--------------------------->
                                                    
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
</asp:UpdatePanel>

        
        
              <%--  </asp:Panel> </ContentTemplate> </asp:UpdatePanel>
--%>
        
        
        </td></tr>
           
            <tr><td>
        <br />
         <UCMyServiceTDSVAT:UCTAX ID="UCMyServiceTDSVAT1" runat="server" />
        <%--<table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="800">
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
                    &nbsp;<asp:TextBox ID="txtAmtApplL" runat="server" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="False" ></asp:TextBox></td>
            </tr>
             <tr style="background-color: White">
                <td style="text-align: left" class="blackfnt">
                    &nbsp; 
                </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;</td>
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
                    &nbsp;<asp:TextBox ID="txtTDSRate" runat="server" BorderStyle="Groove"  Text="0.00" onchange="javascript:Nagative_Chk_wDecimal(this);GetTot()" CssClass="input" Width="80px"></asp:TextBox></td>
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
           
        <tr bgcolor="#FFFFFF">
            <td colspan="3">
                <font class="blackfnt"><b>Net Payable Amount</b></font></td>
            <td>
                <font class="blackfnt"></font>
                <asp:TextBox ID="txtNetPayableAmt" Font-Bold="true"  Enabled="false"  runat="server" Width="80px" Text="0.00"></asp:TextBox>
            </td>
        </tr>
        </table>--%>
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
