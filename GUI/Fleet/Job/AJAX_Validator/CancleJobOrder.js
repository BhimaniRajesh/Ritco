var controlIdPrefix = "ctl00_MyCPH1_";
     
function createXMLHttpRequest()
{
  // Mozilla, Safari,...
  if (window.XMLHttpRequest){xmlHttpRequest=new XMLHttpRequest();if(xmlHttpRequest.overrideMimeType)xmlHttpRequest.overrideMimeType("text/xml");}
  // IE
  else if(window.ActiveXObject){try{xmlHttpRequest=new ActiveXObject("Msxml2.XMLHTTP");}catch(e){try{xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");}catch(e){}}}
}
    
function isDate(dtStr)
{
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
function stripCharsInBag(s, bag)
{
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

function CheckManualJobOrderNo(row_Index,txtJob_Order_No,txtCancel_Reason,lbl_Page_Error,txtJob_Order_Date,txtVehicle_No,txtJobSheet_Branch,txtOrder_Status,txtCancellation_Date)
{
    //alert("Hi1")
    var currentTime = new Date()
    var str_Index = "";

    if (txtJob_Order_No.value == "")
    {    
       lbl_Page_Error.innerText= ""; 
       txtCancel_Reason.value="";
       txtJob_Order_Date.value="";
       txtVehicle_No.value="";
       txtJobSheet_Branch.value="";
       txtOrder_Status.value="";  
       txtCancellation_Date.value="";  
       return 
    }  

    for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_gvJobOrderCancel").rows.length; intIndex++)
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
        if (document.getElementById("ctl00_MyCPH1_gvJobOrderCancel_ctl" + str_Index + "_txtJob_Order_No").value == txtJob_Order_No.value)
        {
            alert("This Job Order No is already exist at row " + (intIndex - 1));
            //txtJob_Order_No.value = "";
            txtJob_Order_No.focus();
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
                if (returnValue[0] == "N") 
                {
                    alert("Invalid Job Order No");
                    txtJob_Order_Date.value="";
                    txtVehicle_No.value="";
                    txtJobSheet_Branch.value="";
                    txtOrder_Status.value="";
                    lbl_Page_Error.innerText= "";
                    txtCancel_Reason.value="";
                    txtCancellation_Date.value=""; 
                    txtJob_Order_No.focus();
                    return false;
                }
                else
                {   
                    var jCancel_Status=returnValue[6];
                    var jCancel_Actual_dt="";
                    if(jCancel_Status != "")
                    {
                        alert("This Job Order No is Already Cancelled");
                        txtJob_Order_Date.value="";
                        txtVehicle_No.value="";
                        txtJobSheet_Branch.value="";
                        txtOrder_Status.value="";
                        lbl_Page_Error.innerText= "";
                        txtCancel_Reason.value="";               
                        txtJob_Order_No.focus();
                        return true;    
                    } 
                    else  
                    { 
                        if(returnValue[5]!="Open")
                        {
                            alert("This Job Order No is Already Closed.");
                            txtJob_Order_Date.value="";
                            txtVehicle_No.value="";
                            txtJobSheet_Branch.value="";
                            txtOrder_Status.value="";
                            lbl_Page_Error.innerText= "";
                            txtCancel_Reason.value="";               
                            txtJob_Order_No.focus();
                        }
                        else
                        {
                            txtJob_Order_Date.value=returnValue[2];
                            txtVehicle_No.value=returnValue[3];
                            txtJobSheet_Branch.value=returnValue[4];
                            txtOrder_Status.value=returnValue[5];
                        }
                    } 
                }  
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=GetJobOrderCancelDetails&datetime="+currentTime+"&JobOrderNo=" + txtJob_Order_No.value, false);
        xmlHttpRequest.send(null);
    }   
}

function CheckCancelDate(txtJob_Order_No,txtCancellation_Date,txtJOB_ORDER_NO)
 {
         //alert("hi1")
         var currentTime = new Date()
         
         if(txtJOB_ORDER_NO.value=="")
         {
            txtCancellation_Date.value="";
            return true;
         }
         if(txtCancellation_Date.value=="")
         {
           return true;
         }
         
        if(txtCancellation_Date.value.length<10)
        {
            alert("The date format should be : dd/mm/yyyy")
            txtCancellation_Date.value="";
            txtCancellation_Date.focus(); 
            return false;
        }
             
        createXMLHttpRequest();
        //alert("hi3")
        if (xmlHttpRequest)
        {
         //alert("ok-1")
            xmlHttpRequest.onreadystatechange = function()
            { 
                if (xmlHttpRequest.readyState == 4)
                {
                    var returnValue=xmlHttpRequest.responseText.split("~");
                    
                    //alert("hi3")
                    //alert(txtCancellation_Date.value);
                    //alert(returnValue);
                    //var jCancel_Actual_Dt="";
                    //jCancel_Actual_Dt=returnValue[3];
                    
                    if (returnValue[0] == "N") 
                    { 
                        alert("Job order cancel date should be from job order date to today's date.");
                        txtCancellation_Date.value = "";
                        txtCancellation_Date.focus();
                        return false;
                       
                    }
                    else
                    {  
                      
                    }
                   
                }
            }
            //alert("ok-2")
            //var str ="wfrm_AJAX_ValidatorTrip.aspx?Function=GetCancelDate&datetime="+currentTime+"&JobOrderNo="+ txtJob_Order_No.value +"&CancelDt=" + txtCancellation_Date.value;
            //alert("str : " + str)
            xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=GetCancelDate&datetime="+currentTime+"&JobOrderNo="+ txtJob_Order_No.value +"&CancelDt=" + txtCancellation_Date.value, false);
            xmlHttpRequest.send(null);
        }       
 }

 function CheckSubmit()
 { 
  //alert("h1") 
    var tot_rows=document.getElementById(controlIdPrefix + "gvJobOrderCancel").rows.length;
    //alert("submit");
    var txtJob_Order_No = "";
    
     if(tot_rows>0)
        {
            for(i=0;i< tot_rows-1;i++)
            {  
                j=i+2
                var pref="";
                if(j<10)
                {
                    pref = "ctl00_MyCPH1_gvJobOrderCancel_ctl0" + j + "_";
                }                                       
                else
                {         
                    pref = "ctl00_MyCPH1_gvJobOrderCancel_ctl" + j + "_";
                }              
                txtJob_Order_No = document.getElementById(pref +"txtJob_Order_No");
                txtCancellation_Date = document.getElementById(pref +"txtCancellation_Date");
                txtCancel_Reason = document.getElementById(pref +"txtCancel_Reason");
        
                if(txtJob_Order_No.value == "" )
                {
                    alert("Enter Job Order Number")
                    //txtManual_TripSheetNo.focus();
                    document.getElementById(pref + "txtJob_Order_No").focus();
                    return false;
                }
                
                 if(txtCancellation_Date.value == "" )
                {
                   alert("Select Cancellation Date");
                   document.getElementById(pref + "txtCancellation_Date").focus();
                   return false;
                }
                
                 if(txtCancel_Reason.value == "")
                {
                    alert("Enter Cancel Reason");
                    document.getElementById(pref + "txtCancel_Reason").focus();
                    return false;
                }
                    
                //alert("submit*");
                
                 for(k=0;k<tot_rows-1;k++)
                {  
                    if(i!=k)
                    {
                        m=k+2
                        var pref="";
                        if(j<10)
                        {
                            pref = "ctl00_MyCPH1_gvJobOrderCancel_ctl0" + m + "_";
                        }                                       
                        else
                        {         
                            pref = "ctl00_MyCPH1_gvJobOrderCancel_ctl" + m + "_";
                        }    
                    }
                }
                                             
       }
  }
                
}