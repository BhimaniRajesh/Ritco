var cal = new CalendarPopup("Div1"); 
cal.setCssPrefix("TEST");
cal.showNavigationDropdowns();
function numeric(e) { return ((e.keyCode == 8) || (e.keyCode == 110) || (e.keyCode == 190) || (e.keyCode > 47 && e.keyCode <58)||(e.keyCode > 95 && e.keyCode <106) || (e.keyCode == 9) || (e.keyCode == 46));  }
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
function createXMLHttpRequest()
{
    // Mozilla, Safari,...
    if (window.XMLHttpRequest){xmlHttpRequest=new XMLHttpRequest();if(xmlHttpRequest.overrideMimeType)xmlHttpRequest.overrideMimeType("text/xml");}
    // IE
    else if(window.ActiveXObject){try{xmlHttpRequest=new ActiveXObject("Msxml2.XMLHTTP");}catch(e){try{xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");}catch(e){}}}
}
function OnPartDescChange(row_Index,ddlPartNo,txtCostUnit,txtQty,txtCost,txtSpareRemark)
{
    var currentTime = new Date()    
    var str_Index = "";
    var qs = new Querystring()
    var qsJobOrderNo = qs.get("ONo");    
    
    for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_dgSpare").rows.length; intIndex++)
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
        var ddlPartNo_V = document.getElementById("ctl00_MyCPH1_dgSpare_ctl" + str_Index + "_ddlPartNo");
        if(ddlPartNo_V!=null)
        {
            if (ddlPartNo_V.value == ddlPartNo.value)
            {
                alert("This Part already exist at row " + (intIndex - 1));
                ddlPartNo.value = "";
                ddlPartNo.focus();
                return;
            }
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
                    txtCostUnit.value=returnValue[1];
                }
                else
                {
                    txtQty.value="";
                    txtCostUnit.value="";
                    txtCost.value="";
                    txtSpareRemark.value="";
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=OnPartDescChangeClose&datetime="+currentTime+"&PartCode="+ddlPartNo.value, false);
        xmlHttpRequest.send(null);
    }
}
function OnTaskDescChange(row_Index,ddlTask,ddlTaskType,JobOrderNo)
{
    var currentTime = new Date()    
    var str_Index = "";
    var qs = new Querystring()
    var qsJobOrderNo = qs.get("ONo");    
    for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_gvTaskDetails").rows.length; intIndex++)
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

        var ddlTaskIdx = document.getElementById("ctl00_MyCPH1_gvTaskDetails_ctl" + str_Index + "_ddlTask");
        if(ddlTaskIdx!=null)
        {
            if (ddlTaskIdx.value == ddlTask.value)
            {
                alert("This Part already exist at row " + (intIndex - 1));
                ddlTask.value = "";
                ddlTask.focus();
                return;
            }
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
                    if(returnValue[1]==""  && returnValue[2]=="0")
                    {
                        alert("Already Exist!!!");
                        ddlTask.selectedIndex = 0;
                        return false;
                    }
                    else
                    {
                        ddlTaskType.value=returnValue[1];
                        calculate();
                        calculateSpare();
                    }
                }
                else
                {
                    ddlTaskType.value="";
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=OnTaskDescChangeClose&datetime="+currentTime+"&TaskId="+ddlTask.value+"&JobOrderNo="+qsJobOrderNo, false);
        xmlHttpRequest.send(null);
    }
}

    
function checkme()
{
    var  m="N";
    var grid=document.getElementById("ctl00_MyCPH1_gvTaskDetails");
    var r=grid.rows.length;
    //alert(r)
    //return false;
    //  int  count=0;
    var TaksSel=0;
    for(i=0;i<r-1;i++)
    {  
        j=i+2
        var pref="";
        if(j<10)
        {
            pref = "ctl00_MyCPH1_gvTaskDetails_ctl0" + j + "_";
        }                                       
        else
        {         
            pref = "ctl00_MyCPH1_gvTaskDetails_ctl" + j + "_";
        }    
        var mSelect= document.getElementById(pref + "chk_Flag");
        var mAction= document.getElementById(pref + "txtAction") ;
        //var mDate= document.getElementById(pref + "txtComplDate") ;
        var EstHrs= document.getElementById(pref + "txtEstHrs")  
        var EstCost= document.getElementById(pref + "txtEstCost")  
        if(mSelect.checked==false)
        { 
            mAction.value="";
            //mDate.value="";
            EstHrs.value="";
            EstCost.value="";
        }   
    }
}
   
function checkOperational()
{
    var WONo="";
    WONo=document.getElementById("ctl00_MyCPH1_ddlWONo").value;
    if(WONo=="")
    {
        alert("select the Job Order Number");
        document.getElementById("ctl00_MyCPH1_ddlWONo").focus();
        return false;
    }
    var SendDt =document.getElementById("ctl00_MyCPH1_LblSendDt").innerText;
    var ActRetrunDt_WS=document.getElementById("ctl00_MyCPH1_txtDCActRetrunDt");
    
    if(ActRetrunDt_WS.value=="")
    {
        alert("Please enter actual date of return")
        ActRetrunDt_WS.focus();
        return false;   
    }
    if(ActRetrunDt_WS.value.length<10)
    {
        alert("The date format should be : dd/mm/yyyy")
        ActRetrunDt_WS.focus(); 
        return false;
    }
    if(!Date.parse(ActRetrunDt_WS.value))
    {
       alert("Invalid actual date of return !!!")
       ActRetrunDt_WS.focus(); 
       return false;
    }
    
    if(Date.parse(ActRetrunDt_WS.value)< Date.parse(SendDt))
    {
       alert("actual date of return can not be less than send date to workshop !!!")
       ActRetrunDt_WS.focus(); 
       return false;
    }
    var mServerDt = ("<%=ServerDt%>"); 
    if(Date.parse(ActRetrunDt_WS.value)> Date.parse(mServerDt))
    {
       alert("Actual date of return can not be greater than today's date !!!")
       ActRetrunDt_WS.focus(); 
       return false;
    }
    var KMReading=document.getElementById("ctl00_MyCPH1_lblKMReading").innerText;
    var CloseKM=document.getElementById("ctl00_MyCPH1_txtCloseKM").value;
    if(CloseKM=="" || CloseKM=="0")
    {
        alert("Please enter Closing KM vehicle of the Vehicle")
        document.getElementById("ctl00_MyCPH1_txtCloseKM").focus();
        return false;
    }
    if(parseFloat(CloseKM)<=parseFloat(KMReading))
    {
        alert("Closing KM should not be less than/equals to Starting KM reading !!!") 
        document.getElementById("ctl00_MyCPH1_txtCloseKM").focus();
        return false;
    }
}

function checkFinancial()
{
    var WONo="";
    WONo=document.getElementById("ctl00_MyCPH1_ddlWONo").value;
    if(WONo=="")
    {
        alert("select the Job Order Number");
        document.getElementById("ctl00_MyCPH1_ddlWONo").focus();
        return false;
    }
    var SendDt =document.getElementById("ctl00_MyCPH1_LblSendDt").innerText;
    var ActRetrunDt_WS=document.getElementById("ctl00_MyCPH1_txtDCActRetrunDt");
    
    //alert("ActRetrunDt_WS : " + ActRetrunDt_WS.value);
    if(ActRetrunDt_WS.value=="")
    {
        alert("Please enter actual date of return")
        ActRetrunDt_WS.focus();
        return false;   
    }
    if(ActRetrunDt_WS.value.length<10)
    {
        alert("The date format should be : dd/mm/yyyy")
        ActRetrunDt_WS.focus(); 
        return false
    }
    
    
    if(!Date.parse(ActRetrunDt_WS.value))
    {
       alert("Invalid actual date of return !!!")
       ActRetrunDt_WS.focus(); 
       return false
    }
    
    if(Date.parse(ActRetrunDt_WS.value)< Date.parse(SendDt))
    {
       alert("actual date of return can not be less than send date to workshop !!!")
       ActRetrunDt_WS.focus(); 
       return false
    }
    
    
        

    
    //var today = new Date(); 
    //alert(" today : " + today);

    //var mServerDt = new Date ("<%=ServerDt%>"); 
    //alert(" mServerDt : " + mServerDt);
    
    var mServerDt = ("<%=ServerDt%>"); 
    
    //alert("ActRetrunDt_WS : " + Date.parse(ActRetrunDt_WS.value))
    //alert("mServerDt : " + Date.parse(mServerDt))
    if(Date.parse(ActRetrunDt_WS.value)> Date.parse(mServerDt))
    {
       alert("Actual date of return can not be greater than today's date !!!")
       ActRetrunDt_WS.focus(); 
       return false
    }
    
    //lblKMReading
    //txtCloseKM
    var KMReading=document.getElementById("ctl00_MyCPH1_lblKMReading").innerText;
    var CloseKM=document.getElementById("ctl00_MyCPH1_txtCloseKM").value;
    if(CloseKM=="" || CloseKM=="0")
    {
        alert("Please enter Closing KM vehicle of the Vehicle")
        document.getElementById("ctl00_MyCPH1_txtCloseKM").focus();
        return false
    }
    if(parseFloat(CloseKM)<=parseFloat(KMReading))
    {
        alert("Closing KM should not be less than/equals to Starting KM reading !!!") 
        document.getElementById("ctl00_MyCPH1_txtCloseKM").focus();
        return false   
    }

   
    var  m="N";
    var grid=document.getElementById("ctl00_MyCPH1_gvTaskDetails");
    var r=grid.rows.length;
    var TaksSel=0;
    for(i=0;i<r-1;i++)
    {  
           
        j=i+2
        var pref="";
        if(j<10)
        {
            pref = "ctl00_MyCPH1_gvTaskDetails_ctl0" + j + "_";
        }                                       
        else
        {         
            pref = "ctl00_MyCPH1_gvTaskDetails_ctl" + j + "_";
        }    
        var mSelect= document.getElementById(pref + "chk_Flag");
        //alert(mSelect.checked);
        var mAction= document.getElementById(pref + "txtAction") ;

        var mTask_dd= document.getElementById(pref + "ddlTask") ;
        
        var ddlWorkGroup= document.getElementById(pref + "ddlWorkGroup") ;
        var ddlTask= document.getElementById(pref + "ddlTask") ;
        

        //var mTask_lbl= document.getElementById(pref + "lblTaskDesc") ;
        if(mSelect.checked==true)
        { 
            TaksSel=TaksSel+1;       
            if(ddlWorkGroup!=null)
            {
                if(ddlWorkGroup.value=="")
                {
                    alert("Select Workgroup !!!")
                    ddlWorkGroup.focus();
                    return false;  
                }
            }
            if(ddlTask!=null)
            {
                if(ddlTask.value=="")
                {
                    alert("Select Task !!!")
                    ddlTask.focus();
                    return false;  
                }
            }
            if(mAction.value=="")
            {
                //m="Y";
                alert("Please enter Action Taken")
                document.getElementById(pref + "txtAction").focus();
                return false;
            }
            var ddlAMC=document.getElementById(pref + "ddlAMC");
            var txtActualLabourCost= document.getElementById(pref + "txtActualLabourCost");
            
            if(ddlAMC.value=="")
            {
                alert("Select AMC or Non AMC!!");
                ddlAMC.focus();
                return false;
            }
            else
            {
                if(ddlAMC.value=="1")
                {
                    if(txtActualLabourCost.value == "")
                    {
                        alert("Enter Actual Labour Cost!!")
                        txtActualLabourCost.focus();
                        return false;
                    }
                }
            }
        }
        for(k1=i+1;k1<r1-1;k1++)
        { 
            l1=k1+2
            var tpref="";
            if(l1<10)
            {
                tpref = "ctl00_MyCPH1_gvTaskDetails_ctl0" + l1 + "_";
            }                                       
            else
            {         
                tpref = "ctl00_MyCPH1_gvTaskDetails_ctl" + l1 + "_";
            }   
            var TempTask= document.getElementById(mpref + "ddlPartNo") 

            if(TempPartNo.value==PartNo.value)
            {
                alert("Duplicate Part !!!")
                TempPartNo.focus();
                return false;
            }
        }
    }
    
    if(parseFloat(TaksSel)==0)
    {
        alert("Please select atleast one task to close the Job order !!!")
        return false;
    }
 
        
        // Spare part validation
 
    var dgrid=document.getElementById("ctl00_MyCPH1_dgSpare");
    var r1=dgrid.rows.length;
    j=0;
    for(i=0;i<r1-1;i++)
    {  

        j=i+2
        var pref="";
        if(j<10)
        {
            pref = "ctl00_MyCPH1_dgSpare_ctl0" + j + "_";
        }                                       
        else
        {         
            pref = "ctl00_MyCPH1_dgSpare_ctl" + j + "_";
        }    


        var PartNo= document.getElementById(pref + "ddlPartNo")
        var PartQty= document.getElementById(pref + "txtQty")     
        var PartCost= document.getElementById(pref + "txtCost")                        
        
        if(PartNo!=null)
        {
            if(PartNo.value=="")
            {
                alert("Please select Part!!")
                document.getElementById(pref + "ddlPartNo").focus();  
                return false;
            }
        }

        if(PartQty.value=="")
        {
            alert("Please enter Part quantity!!")
            document.getElementById(pref + "txtQty").focus();  
            return false;
        }
        if(PartCost!=null)
        {
            if(PartCost.value=="")
            {
                alert("Please enter Part Cost!!")
                return false;
            }
        }

        for(k=i+1;k<r1-1;k++)
        { 
            l=k+2
            var mpref="";
            if(l<10)
            {
                mpref = "ctl00_MyCPH1_dgSpare_ctl0" + l + "_";
            }                                       
            else
            {         
                mpref = "ctl00_MyCPH1_dgSpare_ctl" + l + "_";
            }   
            var TempPartNo= document.getElementById(mpref + "ddlPartNo") 
            var TempPartQty= document.getElementById(mpref + "txtQty")     
            
            if(TempPartNo!=null && PartNo!=null)
            {
                if(TempPartNo.value==PartNo.value)
                {
                    alert("Duplicate Part !!!")
                    TempPartNo.focus();
                    return false;
                }
            }
        }
    }
   //alert("submit");
   //return false;
}
function calculateSpareCost(txtQty,txtCostUnit,txtCost)   
{
    if(txtQty.value==""){txtQty.value="0";}
    if(txtCostUnit.value==""){txtCostUnit.value="0";}
    txtCost.value = parseFloat(txtQty.value) * parseFloat(txtCostUnit.value); 
    calculateSpare();
    calculate();
}
function calculateSpare()
{
    var Tot_PartQty="0.00",Tot_PartUnit="0.00",Tot_PartCost="0.00";
    var grid=document.getElementById("ctl00_MyCPH1_dgSpare");
    var r=grid.rows.length;
    
    var txtActCostUnit=document.getElementById("ctl00_MyCPH1_txtActCostUnit");
    var txtActQty=document.getElementById("ctl00_MyCPH1_txtActQty");
    var txtActPartCost=document.getElementById("ctl00_MyCPH1_txtActPartCost");

    for(k=0;k<r-1;k++)
    {  
        j=k+2
        var pref="";
        if(j<10)
        {
            pref = "ctl00_MyCPH1_dgSpare_ctl0" + j + "_";
        }                                       
        else
        {         
            pref = "ctl00_MyCPH1_dgSpare_ctl" + j + "_";
        }    
        if(document.getElementById(pref + "txtQty")!=null)
        {
            var txtQty = document.getElementById(pref + "txtQty") 
            var txtCostUnit = document.getElementById(pref + "txtCostUnit");
            var txtActualCost = document.getElementById(pref + "txtActualCost") 
            
            if(txtQty.value!=null)
            {
                if(txtQty.value!="")
                {
                    Tot_PartQty = parseFloat(Tot_PartQty) + parseFloat(txtQty.value);
                }
            }
            if(txtCostUnit.value!=null)
            {
                if(txtCostUnit.value!="")
                {
                    Tot_PartUnit = parseFloat(Tot_PartUnit) + parseFloat(txtCostUnit.value);
                }
            }
            if(txtActualCost.value!=null)
            {
                if(txtActualCost.value!="")
                {
                    Tot_PartCost = parseFloat(Tot_PartCost) + parseFloat(txtActualCost.value);
                }
            }
        }
    }
    txtActQty.value=Tot_PartQty;
    txtActCostUnit.value=Tot_PartUnit;
    txtActPartCost.value=Tot_PartCost;
}
function  calculate()
{

    var totHrs="0.00",totcost="0.00";
    var mtotHrs="0.00",mtotcost="0.00";
    var grid=document.getElementById("ctl00_MyCPH1_gvTaskDetails");
    var r=grid.rows.length;
    for(k=0;k<r-1;k++)
    {  
        j=k+2
        var pref="";
        if(j<10)
        {
            pref = "ctl00_MyCPH1_gvTaskDetails_ctl0" + j + "_";
        }                                       
        else
        {         
            pref = "ctl00_MyCPH1_gvTaskDetails_ctl" + j + "_";
        }    
        if(document.getElementById(pref + "txtActualLabourCost")!=null)
        {
            var EstCost= document.getElementById(pref + "txtActualLabourCost");
            if(EstCost.value!="")
            {
                totcost=parseFloat(totcost)+parseFloat(EstCost.value);
            }
        }
        mtotHrs=parseFloat(totHrs);
        mtotcost=parseFloat(totcost);
    }
    document.getElementById("ctl00_MyCPH1_txttotActLabCost").value=totcost;
    var ActLabCost="0.00";
    var ActPartCost="0.00";
        
    if(document.getElementById("ctl00_MyCPH1_txttotActLabCost").value!="")
    {
        ActLabCost=document.getElementById("ctl00_MyCPH1_txttotActLabCost").value;
    }
    if(document.getElementById("ctl00_MyCPH1_txtActPartCost")!="")
    {
        ActPartCost=document.getElementById("ctl00_MyCPH1_txtActPartCost").value;
    }
    document.getElementById("ctl00_MyCPH1_txtJobCost").value= parseFloat(ActLabCost) + parseFloat(ActPartCost);
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
     
     
     
function OnAMCChange(ddlAMC,txtActualLabourCost)
{
    if(ddlAMC.value=="1")
    {
        txtActualLabourCost.style.visibility="visible"; 
    }
    else if(ddlAMC.value=="2")
    {
        txtActualLabourCost.value="";
        txtActualLabourCost.style.visibility="hidden"; 
    }
    else
    {
        txtActualLabourCost.value="";
        txtActualLabourCost.style.visibility="hidden"; 
    }
    calculate();
    calculateSpare();
}
