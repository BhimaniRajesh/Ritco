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
    <script language="javascript">
    
    function PageLoad()
    {
        document.getElementById("ctl00_MyCPH1_txtPercAmt").style.visibility="hidden";
        document.getElementById("ctl00_MyCPH1_txtFinalAmt").disabled=true;
    } 
    //function CheckVehNumber(row_Index,txtVehicleno,txtKM_Reading,hfVslipNo,hfManualVslipNo,lblError1)    
    function CheckVehNumber(row_Index,txtVehicleno,txtKM_Reading,lblError1)
    {
        var currentTime = new Date()
        if(txtVehicleno.value=="")
        {
            txtKM_Reading.value =  "";
            lblError1.innerText = "";
            //hfVslipNo.value="";
            //hfManualVslipNo.value="";
            return true;
        }
        for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_dgHSD_OIL_EXP").rows.length; intIndex++)
        {
            if (intIndex < 10)
            {
                str_Index = "0" + intIndex;
            }
            else
            {
                str_Index = intIndex;
            }
            if (row_Index == intIndex - 2)
            {
                continue;
            }
            if (document.getElementById("ctl00_MyCPH1_dgHSD_OIL_EXP_ctl" + str_Index + "_txtVehicleno").value == txtVehicleno.value)
            {
                lblError1.innerText="This Part already exist at row " + (intIndex - 1);
                txtVehicleno.focus();
                return;
            }
        }
        
        createXMLHttpRequest();
        if (xmlHttpRequest)
        {
            xmlHttpRequest.onreadystatechange = function()
            {
                if (xmlHttpRequest.readyState == 4)
                {
                    var returnValue=xmlHttpRequest.responseText.split("~");
                    if (returnValue[0] == "Y") 
                    {
                        txtKM_Reading.value =  returnValue[1];
//                        hfVslipNo.value =  returnValue[2];
//                        hfManualVslipNo.value =  returnValue[3];
                        lblError1.innerText = "";
                    }
                    else
                    {
                        txtVehicleno.value = "";
                        txtKM_Reading.value =  "";
//                        hfVslipNo.value =  "";
//                        hfManualVslipNo.value =  "";
                        lblError1.innerText = "Invalid Vehicle number!!!";
                        txtVehicleno.focus();                        
                        return false;
                    }
                }
            }
            xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=CheckVehNumber&datetime="+currentTime+"&Vehicleno=" + txtVehicleno.value, false);
            xmlHttpRequest.send(null);
        }
    }
    function createXMLHttpRequest()
    {
        // Mozilla, Safari,...
	    if (window.XMLHttpRequest){xmlHttpRequest=new XMLHttpRequest();if(xmlHttpRequest.overrideMimeType)xmlHttpRequest.overrideMimeType("text/xml");}
	    // IE
	    else if(window.ActiveXObject){try{xmlHttpRequest=new ActiveXObject("Msxml2.XMLHTTP");}catch(e){try{xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");}catch(e){}}}
    }
    function CheckKmReading(txtLKMRead,txtKM_Reading,lblError1)
    {
        if(txtLKMRead.value=="")
        {
            txtLKMRead.value="0";
        }
        if(txtKM_Reading.value=="")
        {
            txtKM_Reading.value="0";
        }
        if(parseFloat(txtKM_Reading.value) < parseFloat(txtLKMRead.value))
        {
            lblError1.innerText = "Current km reading cannot be less than last km reading !!!";
            txtKM_Reading.focus();
            return false;
        }
        else
        {
            lblError1.innerText = "";
        }
    }
    
    function CheckTSNumber(row_Index,txtTripsheetNo,txtVehicleno,txtKM_Reading,lblError1)
    {
        var currentTime = new Date()
        if(txtTripsheetNo.value=="")
        {
            txtVehicleno.value = "";
            txtKM_Reading.value =  "";
            lblError1.innerText = "";
            return true;
        }
        for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_dgHSD_OIL_EXP").rows.length; intIndex++)
        {
            if (intIndex < 10)
            {
                str_Index = "0" + intIndex;
            }
            else
            {
                str_Index = intIndex;
            }
            if (row_Index == intIndex - 2)
            {
                continue;
            }
            if (document.getElementById("ctl00_MyCPH1_dgHSD_OIL_EXP_ctl" + str_Index + "_txtTripsheetNo").value == txtTripsheetNo.value)
            {
                lblError1.innerText="This Part already exist at row " + (intIndex - 1);
                txtTripsheetNo.focus();
                return;
            }
        }
        
        createXMLHttpRequest();
        if (xmlHttpRequest)
        {
            xmlHttpRequest.onreadystatechange = function()
            {
                if (xmlHttpRequest.readyState == 4)
                {
                    var returnValue=xmlHttpRequest.responseText.split("~");
                    if (returnValue[0] == "Y") 
                    {
                        if(returnValue[3]=="")
                        {
                            if(returnValue[4]=="")
                            {
                                txtVehicleno.value = returnValue[1];
                                txtKM_Reading.value =  returnValue[2];
                                lblError1.innerText = "";
                            }
                            else
                            {
                                txtVehicleno.value = "";
                                txtKM_Reading.value =  "";
                                lblError1.innerText = "This tripsheet no. " + txtTripsheetNo.value + " is already closed & settled !!!";
                                txtTripsheetNo.focus();
                                return false;
                            }
                        }
                        else
                        {
                            txtVehicleno.value = "";
                            txtKM_Reading.value =  "";
                            lblError1.innerText = "This tripsheet no. " + txtTripsheetNo.value + " is already closed !!!";
                            txtTripsheetNo.focus();
                            return false;
                        }
                    }
                    else
                    {
                        txtVehicleno.value = "";
                        txtKM_Reading.value =  "";
                        lblError1.innerText = "Invalid tripsheet no.: " + txtTripsheetNo.value + "!!!";
                        txtTripsheetNo.focus();                        
                        return false;
                    }
                }
            }
            xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=CheckTSNumber&datetime="+currentTime+"&TripsheetNo=" + txtTripsheetNo.value, false);
            xmlHttpRequest.send(null);
        }
    }
    function CheckBillNumber(txtBillNumber,cboVendor)
    {
        var currentTime = new Date()
        if(cboVendor.value=="")
        {
            alert("Select Vendor!!!");
            cboVendor.focus();
            return false;
        }
        
        createXMLHttpRequest();
        if (xmlHttpRequest)
        {
            xmlHttpRequest.onreadystatechange = function()
            {
                if (xmlHttpRequest.readyState == 4)
                {
                    var returnValue=xmlHttpRequest.responseText.split("~");
                    //alert(returnValue);
                    if (returnValue[0] == "N") 
                    {
                       txtBillNumber.value=txtBillNumber.value;
                    }
                    else
                    {
                        alert("Bill No is Already Exist !");
                        txtBillNumber.value="";
                        txtBillNumber.focus();
                    }
                }
            }
            xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=CheckBillNumber&datetime="+currentTime+"&BillNo=" + txtBillNumber.value+"&VENDORCODE="+cboVendor.value, false);
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

function CheckBillDate(txtBilldt,hfTodayDate,hfVSlipDt)
    {
//        alert(txtBilldt.value);
//        alert(hfTodayDate.value);
//        alert(hfVSlipDt.value);
        var SlipDate=txtBilldt.value;
        //alert("issue slip date : " + hfVSlipDt.value);
        //alert("*slip date : " + SlipDate);
 
        if(txtBilldt.value!="")
        {
            if(!isDate(txtBilldt.value))
            {
                alert("Invalid Date!!!");
                txtBilldt.focus();
                return false;
            }
            else
            {
                //if(IsDateGreater(txtBilldt.value,hfTodayDate.value))
                if(IsDateGreater(SlipDate,hfTodayDate.value))
                {
                    alert("Slip Date should not be greater than today's date!");
                    txtBilldt.focus();
                    return false;
                }
                if(IsDateGreater(hfVSlipDt.value,SlipDate))
                {
                    //alert("Bill Date should not be less than Issue Slip Date!!");
                    alert("Slip Date should not be less than Trip sheet Date!!");
                    txtBilldt.focus();
                    return false;
                }
            }
        }
    }
    
function IsDateGreater(DateValue1, DateValue2)
    {
        var a=DateValue1.split("/");
        var b=DateValue2.split("/");
        DateValue1 = a[1]+ "/" + a[0]+ "/" + a[2];
        DateValue2 = b[1]+ "/" + b[0]+ "/" + b[2];
        
         //alert("DateValue1 : " + DateValue1)
         //alert("DateValue2 : " + DateValue2)
        
        //alert("DateValue1-p* : " + Date.parse(DateValue1))
        //alert("DateValue2-p* : " + Date.parse(DateValue2))
        
        if(Date.parse(DateValue1) == Date.parse(DateValue2))
            {
            //alert("1");
            return false;
            }
        else
            if(Date.parse(DateValue1) >= Date.parse(DateValue2))
              {
                //alert("2");
                return true;
                }
            else
                {
                //alert("3");
                return false;
                }
                    
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
	
    function createXMLHttpRequest() {
    // Mozilla, Safari,...
    if (window.XMLHttpRequest) { xmlHttpRequest = new XMLHttpRequest(); if (xmlHttpRequest.overrideMimeType) xmlHttpRequest.overrideMimeType("text/xml"); }
        // IE
    else if (window.ActiveXObject) { try { xmlHttpRequest = new ActiveXObject("Msxml2.XMLHTTP"); } catch (e) { try { xmlHttpRequest = new ActiveXObject("Microsoft.XMLHTTP"); } catch (e) { } } }
}


//Added by Manisha on 30-May-15
function GetSTAXDetails(txtBillEntryDate) {
    if (txtBillEntryDate.value == "") {
        document.getElementById("ctl00_MyCPH1_hdnSTaxRate").value = "0";
        document.getElementById("ctl00_MyCPH1_hdnEduCess").value = "0";
        document.getElementById("ctl00_MyCPH1_hdnHEduCess").value = "0";
        document.getElementById("ctl00_MyCPH1_hdnSBCess").value = "0";//Changed by Anupam KKC
        document.getElementById("ctl00_MyCPH1_hdnKKCess").value = "0";//Changed by Anupam KKC

        return true;
    }
    var currentTime = new Date()
    var ConnStr = "<%= Session["SqlProvider"] %>";
            createXMLHttpRequest();
            if (xmlHttpRequest) {
                xmlHttpRequest.onreadystatechange = function () {
                    if (xmlHttpRequest.readyState == 4) {
                        var returnValue = xmlHttpRequest.responseText.split("~");
                        if (returnValue[0] == "N") {
                            document.getElementById("ctl00_MyCPH1_hdnSTaxRate").value = "0";
                            document.getElementById("ctl00_MyCPH1_hdnEduCess").value = "0";
                            document.getElementById("ctl00_MyCPH1_hdnHEduCess").value = "0";
                            document.getElementById("ctl00_MyCPH1_hdnSBCess").value = "0";//Changed by Anupam KKC
                            document.getElementById("ctl00_MyCPH1_hdnKKCess").value = "0";//Changed by Anupam KKC
                            alert("No Rates Defined!!!");
                        }
                        else {
                            document.getElementById("ctl00_MyCPH1_hdnSTaxRate").value = returnValue[1];
                            document.getElementById("ctl00_MyCPH1_hdnEduCess").value = returnValue[2];
                            document.getElementById("ctl00_MyCPH1_hdnHEduCess").value = returnValue[3];
                            document.getElementById("ctl00_MyCPH1_hdnSBCess").value = returnValue[4];//Changed by Anupam KKC
                            document.getElementById("ctl00_MyCPH1_hdnKKCess").value = returnValue[5];//Changed by Anupam KKC
                            GetTot();

                        }
                    }
                }
                xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=GetSTAXDetails&datetime=" + currentTime + "&BillEntryDate=" + txtBillEntryDate.value + "&ConnStr=" + ConnStr, false);
                xmlHttpRequest.send(null);
            }
}

//Altered by Manisha on 30-May-15

	
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
//            document.getElementById("ctl00_MyCPH1_txtServiceTax").value=rounditn((parseFloat(AmtAppl)*12/100),2);
//            document.getElementById("ctl00_MyCPH1_txtEduCess").value=rounditn((parseFloat(document.getElementById("ctl00_MyCPH1_txtServiceTax").value)*2/100),2);
//            document.getElementById("ctl00_MyCPH1_txtHEduCess").value=rounditn((parseFloat(document.getElementById("ctl00_MyCPH1_txtServiceTax").value)*1/100),2);

             document.getElementById("ctl00_MyCPH1_txtServiceTax").value = rounditn((parseFloat(AmtAppl)) * ((parseFloat(document.getElementById("ctl00_MyCPH1_hdnSTaxRate").value) / 100)), 2);
             document.getElementById("ctl00_MyCPH1_txtEduCess").value = rounditn((parseFloat(document.getElementById("ctl00_MyCPH1_txtServiceTax").value) * ((parseFloat(document.getElementById("ctl00_MyCPH1_hdnEduCess").value) / 100))), 2);
             document.getElementById("ctl00_MyCPH1_txtHEduCess").value = rounditn((parseFloat(document.getElementById("ctl00_MyCPH1_txtServiceTax").value) * ((parseFloat(document.getElementById("ctl00_MyCPH1_hdnHEduCess").value) / 100))), 2);
             document.getElementById("ctl00_MyCPH1_txtSBCess").value = rounditn((parseFloat(AmtAppl)) * ((parseFloat(document.getElementById("ctl00_MyCPH1_hdnSBCess").value) / 100)), 2);//Changed by Anupam KKC
             document.getElementById("ctl00_MyCPH1_txtKKCess").value = rounditn((parseFloat(AmtAppl)) * ((parseFloat(document.getElementById("ctl00_MyCPH1_hdnKKCess").value) / 100)), 2);//Changed by Anupam KKC
     
        }
        else
        {
            document.getElementById("ctl00_MyCPH1_txtServiceTax").value="0.00";
            document.getElementById("ctl00_MyCPH1_txtEduCess").value="0.00";
            document.getElementById("ctl00_MyCPH1_txtHEduCess").value = "0.00";
            document.getElementById("ctl00_MyCPH1_txtSBCess").value = "0.00";//Changed by Anupam KKC
            document.getElementById("ctl00_MyCPH1_txtKKCess").value = "0.00";//Changed by Anupam KKC
        }
        
         document.getElementById("ctl00_MyCPH1_txtBillAmt").value=rounditn(parseFloat(Number(AmtAppl)),2)
         //document.getElementById("ctl00_MyCPH1_txtNetAmt").value=rounditn(parseFloat(Number(AmtAppl))-parseFloat(document.getElementById("ctl00_MyCPH1_txtOtherDedudction").value)- parseFloat(document.getElementById("ctl00_MyCPH1_txtDiscRecvd").value),2)
         document.getElementById("ctl00_MyCPH1_txtNetAmt").value=rounditn(parseFloat(Number(AmtAppl)),2)
        
        
         var TP = parseFloat(Number(AmtAppl) + Number(document.getElementById("ctl00_MyCPH1_txtServiceTax").value) + Number(document.getElementById("ctl00_MyCPH1_txtEduCess").value) + Number(document.getElementById("ctl00_MyCPH1_txtHEduCess").value) + Number(document.getElementById("ctl00_MyCPH1_txtSBCess").value) + Number(document.getElementById("ctl00_MyCPH1_txtKKCess").value));//Changed by Anupam KKC
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
        txtNetPay = rounditn(parseFloat(Number(AmtAppl) - Number(txtTDSAmt) + Number(document.getElementById("ctl00_MyCPH1_txtServiceTax").value) + Number(document.getElementById("ctl00_MyCPH1_txtEduCess").value) + Number(document.getElementById("ctl00_MyCPH1_txtHEduCess").value) + Number(document.getElementById("ctl00_MyCPH1_txtSBCess").value) + Number(document.getElementById("ctl00_MyCPH1_txtKKCess").value)), 2);//Changed by Anupam KKC

        
        if(parseFloat(txtNetPay)<0)
        {
            txtNetPay="0.00"
        }
        document.getElementById("ctl00_MyCPH1_txtNetPayableAmt").value=txtNetPay;
        return false;
	}
	
	
	
	   var totAmt=0;
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
            document.getElementById(pref + "txtAmt").value=amt1val;
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
            
        var txtExeAmtDE = document.getElementById(pref + "txtExeAmt");
        var txtAmtDE = document.getElementById(pref + "txtAmt");
        var txtAmtUL = "5000.00";
        var txtAmtULChk = "0.00";
        txtAmtULChk = parseFloat(txtAmtUL) + parseFloat(txtAmtDE.value);
        if (parseFloat(txtExeAmtDE.value) > parseFloat(txtAmtULChk)) {
            alert("Approved Amount Can not be greater than " + txtAmtULChk);
            txtExeAmtDE.focus();
                     return false;
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
        
        //document.getElementById("ctl00_MyCPH1_txtNetPayableAmt").value=totamt;
        
        var txtNetPayableAmt=document.getElementById("ctl00_MyCPH1_txtNetPayableAmt");
        var txtFinalAmt=document.getElementById("ctl00_MyCPH1_txtFinalAmt");
        var ddlDiscount=document.getElementById("ctl00_MyCPH1_ddlDiscount");
        var txtPercAmt=document.getElementById("ctl00_MyCPH1_txtPercAmt");
        txtNetPayableAmt.value = totamt;
        totAmt=totamt;
        CalculatePerc(ddlDiscount,txtPercAmt,txtFinalAmt,txtNetPayableAmt);
        
        
//        var txtFinalAmt=document.getElementById("ctl00_MyCPH1_txtFinalAmt");
//        var ddlDiscount=document.getElementById("ctl00_MyCPH1_ddlDiscount");
//        var txtPercAmt=document.getElementById("ctl00_MyCPH1_txtPercAmt");
//        
//         if(ddlDiscount.value=="2")
//        {
//            if( txtPercAmt.style.visibility=="visible")
//            {
//                txtFinalAmt.value= (parseFloat(totamt)-(parseFloat(txtNetPayableAmt.value) * parseFloat(txtPercAmt.value) / 100)).toString()
//            }
//        }
//        totAmt=totamt;
//        txtFinalAmt.value=totamt;
        GetTot();
    }
	function CalculatePerc(ddlDiscount,txtPercAmt,txtFinalAmt,txtNetPayableAmt)
    {
        if(ddlDiscount.value=="0")
        {
            txtPercAmt.value="0.00";
            txtFinalAmt.value="0.00";
            txtFinalAmt.disabled=true;
            txtPercAmt.style.visibility="hidden";
            txtNetPayableAmt.value=totAmt;
        } 
        else if(ddlDiscount.value=="1")
        {
            txtFinalAmt.disabled=false;
            txtPercAmt.style.visibility="hidden";
            txtNetPayableAmt.value= (parseFloat(totAmt)-parseFloat(txtFinalAmt.value)).toString();
        }
        else if(ddlDiscount.value=="2")
        {
            txtPercAmt.style.visibility="visible";
            if( txtPercAmt.style.visibility=="visible")
            {
                txtFinalAmt.disabled=true;
                if((parseFloat(txtPercAmt.value) < 0) || (parseFloat(txtPercAmt.value) > 100))
                {
                     alert("Enter Valid Percentage Value.");
                     txtPercAmt.focus();
                     return false;
                }
                //txtFinalAmt.value= (parseFloat(txtNetPayableAmt.value)-(parseFloat(txtNetPayableAmt.value) * parseFloat(txtPercAmt.value) / 100)).toString();
//                txtFinalAmt.value= (roundit((parseFloat(totAmt) * parseFloat(txtPercAmt.value) / 100))).toString();
//               txtNetPayableAmt.value= (roundit(parseFloat(totAmt)-parseFloat(txtFinalAmt.value))).toString();
               
               txtFinalAmt.value= ((parseFloat(totAmt) * parseFloat(txtPercAmt.value) / 100)).toFixed(2).toString();
               txtNetPayableAmt.value= (parseFloat(totAmt)-parseFloat(txtFinalAmt.value)).toFixed(2).toString();
            }
        }
    }
    function numeric(e) { return ((e.keyCode == 8) || (e.keyCode == 110) || (e.keyCode == 190) || (e.keyCode > 47 && e.keyCode <58)||(e.keyCode > 95 && e.keyCode <106) || (e.keyCode == 9) || (e.keyCode == 46));  }
	
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
	
	
	var counter=0;
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

        document.getElementById('ctl00_MyCPH1_txtBillAmt').value=rounditn(document.getElementById('ctl00_MyCPH1_txtTotalExeAmt').value,2);
        document.getElementById('ctl00_MyCPH1_txtNetAmt').value=rounditn(document.getElementById('ctl00_MyCPH1_txtTotalExeAmt').value,2);

        if(document.getElementById("ctl00_MyCPH1_Svctax_yn").checked==false && document.getElementById("ctl00_MyCPH1_TDS_yn").checked==false)
        {
            document.getElementById('ctl00_MyCPH1_txtNetPayableAmt').value=rounditn(document.getElementById('ctl00_MyCPH1_txtNetPayableAmt').value,2);
            document.getElementById("ctl00_MyCPH1_txtAmtAppl").value=rounditn(document.getElementById('ctl00_MyCPH1_txtTotalExeAmt').value,2);
            document.getElementById("ctl00_MyCPH1_txtAmtApplL").value=rounditn(document.getElementById('ctl00_MyCPH1_txtTotalExeAmt').value,2);
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
        
        var txtFinalAmt=document.getElementById("ctl00_MyCPH1_txtFinalAmt");
        var ddlDiscount=document.getElementById("ctl00_MyCPH1_ddlDiscount");
        var txtPercAmt=document.getElementById("ctl00_MyCPH1_txtPercAmt");
        if(ddlDiscount.value=="1")
        {
            if(parseFloat(txtFinalAmt.value)==0 || txtFinalAmt.value=="")
            {
                alert("Enter Received Discount.");
                txtFinalAmt.focus(); 
                return false;
            }
        }
        if(ddlDiscount.value=="2")
        {
            if(parseFloat(txtPercAmt.value)==0 || txtPercAmt.value=="")
            {
                alert("Enter Discount Percentage.");
                txtPercAmt.focus();   
                return false;
            }
        }

        if(counter>0)
        {
            alert("Double click is not allowed");
            return false;
        }
        else
        {
            if (confirm("Do you want to submit")==false)
            {
                //document.getElementById(frm_name+"btnSubmit").disabled=false
                return false;
            }
            else
            {
                counter=counter+1;
                //document.getElementById(frm_name+"btnSubmit").disabled=true
            }
        }
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
                     <asp:HiddenField ID="hfTodayDate" runat="server" />
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
                    <asp:TextBox ID="txtBillAmt" Font-Bold="true" runat="server" Width="60px" Text="0.00"></asp:TextBox>
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
                    <asp:TextBox ID="txtDueDate"  runat="server" Width="60px"></asp:TextBox>
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
                    <asp:TextBox ID="txtNetAmt"   Font-Bold="true"  runat="server" Width="60px" Text="0.00"></asp:TextBox>
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
                                                                
                                                                <%--OnTextChanged="TripsheetNo_Change" AutoPostBack="true"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"--%>
                                                                <asp:TemplateColumn HeaderText="Manual Tripsheet No.">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtTripsheetNo" runat="server" CssClass="input" Width="175px" BorderStyle="Groove"
                                                                            MaxLength="100" ></asp:TextBox> 
                                                                        <ajaxToolkit:AutoCompleteExtender
                                                                            runat="server" 
                                                                            ID="autoComplete1" 
                                                                            TargetControlID="txtTripsheetNo"
                                                                            ServicePath="~/services/FleetAutoComplet.asmx" 
                                                                            ServiceMethod="GetManualTSNo"
                                                                            MinimumPrefixLength="1" 
                                                                            CompletionInterval="1000"
                                                                            EnableCaching="true"
                                                                            CompletionSetCount="20"
                                                                            CompletionListCssClass="autocomplete_completionListElement" 
                                                                            CompletionListItemCssClass="autocomplete_listItem" 
                                                                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                                            DelimiterCharacters=";, :">
                                                                        </ajaxToolkit:AutoCompleteExtender>
                                                                            
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
                                                                        <asp:HiddenField ID="hfVslipNo" runat="server" />
                                                                        <asp:HiddenField ID="hfManualVslipNo" runat="server" />
                                                                             <asp:TextBox ID="txtVehicleno" BorderStyle="None"  runat="server" Width="80px"></asp:TextBox>
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
                                                                        <asp:TextBox ID="txtLKmRead"  BorderStyle="None" onfocus="this.blur();"  runat="server" Width="80px"></asp:TextBox>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="False" />
                                                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                        Font-Underline="False" Wrap="true" />
                                                                </asp:TemplateColumn>
                                                                
                                                                <%--AutoPostBack="True" OnTextChanged="txtKM_Reading_TextChanged"--%>
                                                                <asp:TemplateColumn HeaderText="Current KM Reading">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtKM_Reading" runat="server" CssClass="input" Width="60px" BorderStyle="Groove"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                                            MaxLength="6" ></asp:TextBox>
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
																		<ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" Format="dd/MM/yyyy" TargetControlID="txtBilldt" runat="server" />
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
            <asp:AsyncPostBackTrigger ControlID="txtAddRowOilExp" EventName="TextChanged" />
      </Triggers>
</asp:UpdatePanel>

        
        
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
                    &nbsp;<asp:TextBox ID="txtAmtAppl" runat="server" BorderStyle="Groove" CssClass="input" Width="80px" ></asp:TextBox></td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;Amount Applicable
                </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtAmtApplL" runat="server" BorderStyle="Groove" CssClass="input" Width="80px"  OnTextChanged="txtAmtApplL_TextChanged"></asp:TextBox></td>
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
                    <!--//Added by Manisha on 30-May-15-->
                    <asp:HiddenField ID="hdnSTaxRate" runat="server" />
                     <asp:HiddenField ID="hdnEduCess" runat="server" />
                     <asp:HiddenField ID="hdnHEduCess" runat="server" />
                      <%--//changed by Anupam kkc--%>
                            <asp:HiddenField ID="hdnSBCess" runat="server" />
                            <asp:HiddenField ID="hdnKKCess" runat="server" />
                            <%--//changed by Anupam kkc--%>
                    <!---------------------------------------------------->
                </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtServiceTax" runat="server" onchange="javascript:Nagative_Chk_wDecimal(this)" BorderStyle="Groove" CssClass="input" Width="80px"   Text="0.00"></asp:TextBox></td>
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
                    &nbsp;<asp:TextBox ID="txtEduCess" runat="server" onchange="javascript:Nagative_Chk_wDecimal(this)" BorderStyle="Groove" CssClass="input" Width="80px"  Text="0.00"></asp:TextBox></td>
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
                    &nbsp;<asp:TextBox ID="txtHEduCess" runat="server" onchange="javascript:Nagative_Chk_wDecimal(this)" BorderStyle="Groove" CssClass="input" Width="80px"  Text="0.00"></asp:TextBox></td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;TDS Amount (-)
                </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtTDSAmt" runat="server" BorderStyle="Groove" CssClass="input"  Text="0.00" Width="80px" ></asp:TextBox></td>
            </tr>
             <%--//changed by Anupam kkc--%>
                    <tr style="background-color: White">
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Swachh Bharat Cess (+)
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:TextBox ID="txtSBCess" runat="server" onchange="javascript:Nagative_Chk_wDecimal(this)"
                                BorderStyle="none" Width="80px" Text="0.00"></asp:TextBox>
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Krishi Kalyan Cess (+)
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:TextBox ID="txtKKCess" runat="server" onchange="javascript:Nagative_Chk_wDecimal(this)"
                                BorderStyle="none" Width="80px" Text="0.00"></asp:TextBox>
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;
                        </td>
                    </tr>
                    <%--//changed by Anupam kkc--%>
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
        <tr class="bgbluegrey">
            <td colspan="4" align="left">
                <font class="blackfnt"><b>Other Details</b></font>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">

            <td>
                <font class="blackfnt"></font>
                Discount Received 
            </td>
            <td colspan="3">
                <asp:DropDownList ID="ddlDiscount" runat="server">
                    <asp:ListItem Text="Select" Value="0" />
                    <asp:ListItem Text="Flat" Value="1" />
                    <asp:ListItem Text="%" Value="2" />
                </asp:DropDownList>
                <asp:TextBox ID="txtPercAmt"  onkeydown="return numeric(event)"  Font-Bold="true"   runat="server" Width="80px" Text="0.00" /> 
                <asp:TextBox ID="txtFinalAmt"  onkeydown="return numeric(event)"  Font-Bold="true"   runat="server" Width="80px" Text="0.00"></asp:TextBox>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td colspan="3">
                <font class="blackfnt"><b>Net Payable Amount</b></font></td>
            <td>
                <font class="blackfnt"></font>
                <asp:TextBox ID="txtNetPayableAmt" Font-Bold="true"    runat="server" Width="80px" Text="0.00"></asp:TextBox>
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
