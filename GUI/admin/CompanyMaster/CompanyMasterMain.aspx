<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="CompanyMasterMain.aspx.cs" Inherits="CompanyMaster" EnableEventValidation="false" %>

<%@ OutputCache Location="none" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript">
    
    function minFreightTypeClick()
    {
        var optminfreihgttype=document.getElementById("ctl00_MyCPH1_optminfreihgttype_0");
        var tblpercentwiseminfreight=document.getElementById("ctl00_MyCPH1_tblpercentwiseminfreight");
        var tblbasewiseminfreight=document.getElementById("ctl00_MyCPH1_tblbasewiseminfreight");

        if(optminfreihgttype.checked==true)
        {
            tblbasewiseminfreight.style.display="block";
            tblpercentwiseminfreight.style.display="none";
        }
        else
        {
            tblbasewiseminfreight.style.display="none";
            tblpercentwiseminfreight.style.display="block";
        }
        
            return true;
    }
    
    function octroiSurChargeClick()
    {
        var chkoctroisurcharge=document.getElementById("ctl00_MyCPH1_chkoctroisurcharge");
        var troctroisurcharge=document.getElementById("ctl00_MyCPH1_troctroisurcharge");
        
        if(chkoctroisurcharge.checked==true)
            troctroisurcharge.style.display="block";
        else
            troctroisurcharge.style.display="none";
    
    }
    
function validateOctroiSurCharge()
{
     var chkoctroisurcharge=document.getElementById("ctl00_MyCPH1_chkoctroisurcharge");
     
     var cmboctroisurchargebas=document.getElementById("ctl00_MyCPH1_cmboctroisurchargebas");
     var txtoctroisurchargerate=document.getElementById("ctl00_MyCPH1_txtoctroisurchargerate");
     var txtminoctroisurcharge=document.getElementById("ctl00_MyCPH1_txtminoctroisurcharge");
     var txtmaxoctroisurcharge=document.getElementById("ctl00_MyCPH1_txtmaxoctroisurcharge");
     
     if(chkoctroisurcharge.checked==true)
     {
     
        if(cmboctroisurchargebas.value=="" || cmboctroisurchargebas.value=="0")
        {
            alert("Please Select Octroi Surcharge Base");
            cmboctroisurchargebas.focus();
            return false;
        }
     
        if(txtoctroisurchargerate.value=="")
        {
            alert("Please Enter Octroi Surcharge Rate");
            txtoctroisurchargerate.focus();
            return false;
        }
        
        if(txtminoctroisurcharge.value=="")
        {
            alert("Please Enter Minimum Octroi Surcharge (in RS)");
            txtminoctroisurcharge.focus();
            return false;
        }
        
        if(txtmaxoctroisurcharge.value=="")
        {
            alert("Please Enter Maximum Octroi Surcharge (in RS)");
            txtmaxoctroisurcharge.focus();
            return false;
        }
        
        if(parseFloat(txtmaxoctroisurcharge.value)<parseFloat(txtminoctroisurcharge.value))
        {
            alert("Maximum Octroi Surcharge is Less than Minimum Octroi SurCharge");
            txtminoctroisurcharge.focus();
            return false;
        }
        
     }
     
     
     return true;
}
    
function validateFuelSurCharge()
{
    var chkfuelsurcharge=document.getElementById("ctl00_MyCPH1_chkfuelsurcharge");
    
    var txtfuelsurchargeair=document.getElementById("ctl00_MyCPH1_txtfuelsurchargeair");
    var txtfuelsurchargeroad=document.getElementById("ctl00_MyCPH1_txtfuelsurchargeroad");
    var txtfuelsurchargetrain=document.getElementById("ctl00_MyCPH1_txtfuelsurchargetrain");
    var txtfuelsurchargeexpress=document.getElementById("ctl00_MyCPH1_txtfuelsurchargeexpress");
    
    var txtminfuelsurchargeair=document.getElementById("ctl00_MyCPH1_txtminfuelsurchargeair");
    var txtminfuelsurchargeroad=document.getElementById("ctl00_MyCPH1_txtminfuelsurchargeroad");
    var txtminfuelsurchargetrain=document.getElementById("ctl00_MyCPH1_txtminfuelsurchargetrain");
    var txtminfuelsurchargeexpress=document.getElementById("ctl00_MyCPH1_txtminfuelsurchargeexpress");
    
    var txtmaxfuelsurchargeair=document.getElementById("ctl00_MyCPH1_txtmaxfuelsurchargeair");
    var txtmaxfuelsurchargeroad=document.getElementById("ctl00_MyCPH1_txtmaxfuelsurchargeroad");
    var txtmaxfuelsurchargetrain=document.getElementById("ctl00_MyCPH1_txtmaxfuelsurchargetrain");
    var txtmaxfuelsurchargeexpress=document.getElementById("ctl00_MyCPH1_txtmaxfuelsurchargeexpress");
    
    var cmbfuelsurchargebasair=document.getElementById("ctl00_MyCPH1_cmbfuelsurchargebasair");
    var cmbfuelsurchargebasroad=document.getElementById("ctl00_MyCPH1_cmbfuelsurchargebasroad");
    var cmbfuelsurchargebastrain=document.getElementById("ctl00_MyCPH1_cmbfuelsurchargebastrain");
    var cmbfuelsurchargebasexpress=document.getElementById("ctl00_MyCPH1_cmbfuelsurchargebasexpress");
    
    if(chkfuelsurcharge.checked==true)
    {
    
        if(cmbfuelsurchargebasair.value=="" || cmbfuelsurchargebasair.value=="0")
            {
                alert("Please Select Fuel Sur Charge Bas for Air");
                cmbfuelsurchargebasair.focus();
                return false;
            }
        if(cmbfuelsurchargebasroad.value=="" || cmbfuelsurchargebasroad.value=="0")
            {
                alert("Please Select Fuel Sur Charge Bas for Road");
                cmbfuelsurchargebasroad.focus();
                return false;
            }

        if(cmbfuelsurchargebastrain.value=="" || cmbfuelsurchargebastrain.value=="0")
            {
                alert("Please Select Fuel Sur Charge Bas for Train");
                cmbfuelsurchargebastrain.focus();
                return false;
            }

        if(cmbfuelsurchargebasexpress.value=="" || cmbfuelsurchargebasexpress.value=="0")
            {
                alert("Please Select Fuel Sur Charge Bas for Express");
                cmbfuelsurchargebasexpress.focus();
                return false;
            }
        
        // air
         if(txtminfuelsurchargeair.value=="")
            {
                alert("Please enter Minimum Fuel Surcharge (in RS) for Air");
                txtminfuelsurchargeair.value="0.00";
                txtminfuelsurchargeair.focus();
                return false;
            }
            
        if(txtmaxfuelsurchargeair.value=="")
            {
                    alert("Please enter Maximum Fuel SurCharge (in RS) for Air");
                    txtmaxfuelsurchargeair.value="0.00";
                    txtmaxfuelsurchargeair.focus();
                    return false;
            }

        //road
        if(txtminfuelsurchargeroad.value=="")
            {
                alert("Please enter Minimum Fuel Surcharge (in RS) for Road");
                txtminfuelsurchargeroad.value="0.00";
                txtminfuelsurchargeroad.focus();
                return false;
            }
            
        if(txtmaxfuelsurchargeroad.value=="")
            {
                    alert("Please enter Maximum Fuel SurCharge (in RS) for Road");
                    txtmaxfuelsurchargeroad.value="0.00";
                    txtmaxfuelsurchargeroad.focus();
                    return false;
            }
            
         // train
         if(txtminfuelsurchargetrain.value=="")
            {
                alert("Please enter Minimum Fuel Surcharge (in RS) for Train");
                txtminfuelsurchargetrain.value="0.00";
                txtminfuelsurchargetrain.focus();
                return false;
            }
            
        if(txtmaxfuelsurchargetrain.value=="")
            {
                    alert("Please enter Maximum Fuel SurCharge (in RS) for Train");
                    txtmaxfuelsurchargetrain.value="0.00";
                    txtmaxfuelsurchargetrain.focus();
                    return false;
            }
            
         // express  
         if(txtminfuelsurchargeexpress.value=="")
            {
                alert("Please enter Minimum Fuel Surcharge (in RS) for Express");
                txtminfuelsurchargeexpress.value="0.00";
                txtminfuelsurchargeexpress.focus();
                return false;
            }
            
        if(txtmaxfuelsurchargeexpress.value=="")
            {
                    alert("Please enter Maximum Fuel SurCharge (in RS) for Express");
                    txtmaxfuelsurchargeexpress.value="0.00";
                    txtmaxfuelsurchargeexpress.focus();
                    return false;
            }    
            
         
           
            
            // for air
            if(cmbfuelsurchargebasair.value!="F")
            {
                    if(txtminfuelsurchargeair.value=="")
                    {
                        alert("Please enter Minimum Fuel Surcharge (in RS) for Air");
                        txtminfuelsurchargeair.value="0.00";
                        txtminfuelsurchargeair.focus();
                        return false;
                    }
            
                    if(txtmaxfuelsurchargeair.value=="")
                    {
                        alert("Please enter Maximum Fuel SurCharge (in RS) for Air");
                        txtmaxfuelsurchargeair.value="0.00";
                        txtmaxfuelsurchargeair.focus();
                        return false;
                    }
                   
            }
            
            if(cmbfuelsurchargebasroad.value!="F")
            {
                    if(txtminfuelsurchargeroad.value=="")
                    {
                        alert("Please enter Minimum Fuel Surcharge (in RS) for Road");
                        txtminfuelsurchargeroad.value="0.00";
                        txtminfuelsurchargeroad.focus();
                        return false;
                    }
            
                    if(txtmaxfuelsurchargeroad.value=="")
                    {
                        alert("Please enter Maximum Fuel SurCharge (in RS) for Road");
                        txtmaxfuelsurchargeroad.value="0.00";
                        txtmaxfuelsurchargeroad.focus();
                        return false;
                    }
                    
            }
            
            
            if(cmbfuelsurchargebastrain.value!="F")
            {
                    if(txtminfuelsurchargetrain.value=="")
                    {
                        alert("Please enter Minimum Fuel Surcharge (in RS) for Train");
                        txtminfuelsurchargetrain.value="0.00";
                        txtminfuelsurchargetrain.focus();
                        return false;
                    }
            
                    if(txtmaxfuelsurchargetrain.value=="")
                    {
                        alert("Please enter Maximum Fuel SurCharge (in RS) for Train");
                        txtmaxfuelsurchargetrain.value="0.00";
                        txtmaxfuelsurchargetrain.focus();
                        return false;
                    }
             }
            
            
            if(cmbfuelsurchargebasexpress.value!="F")
            {
                    if(txtminfuelsurchargeexpress.value=="")
                    {
                        alert("Please enter Minimum Fuel Surcharge (in RS) for Express");
                        txtminfuelsurchargeexpress.value="0.00";
                        txtminfuelsurchargeexpress.focus();
                        return false;
                    }
            
                    if(txtmaxfuelsurchargeexpress.value=="")
                    {
                        alert("Please enter Maximum Fuel SurCharge (in RS for Express)");
                        txtmaxfuelsurchargeexpress.value="0.00";
                        txtmaxfuelsurchargeexpress.focus();
                        return false;
                    }
            }    
                
                    
                    // checking min max
                    if(parseFloat(txtmaxfuelsurchargeair.value)<parseFloat(txtminfuelsurchargeair.value))
                    {
                        alert("For Air Mode Maximum Fuel SurCharge is Less than Minimum Fuel SurCharge");
                        txtminfuelsurchargeair.focus();
                        return false;
                    }


                    if(parseFloat(txtmaxfuelsurchargeroad.value)<parseFloat(txtminfuelsurchargeroad.value))
                    {
                        alert("For Road Mode Maximum Fuel SurCharge is Less than Minimum Fuel SurCharge");
                        txtminfuelsurchargeroad.focus();
                        return false;
                    }


                    if(parseFloat(txtmaxfuelsurchargetrain.value)<parseFloat(txtminfuelsurchargetrain.value))
                    {
                        alert("For Train Mode Maximum Fuel SurCharge is Less than Minimum Fuel SurCharge");
                        txtminfuelsurchargetrain.focus();
                        return false;
                    }


                    if(parseFloat(txtmaxfuelsurchargeexpress.value)<parseFloat(txtminfuelsurchargeexpress.value))
                    {
                        alert("For Express Mode Maximum Fuel SurCharge is Less than Minimum Fuel SurCharge");
                        txtminfuelsurchargeexpress.focus();
                        return false;
                    }



            if(txtfuelsurchargeair.value=="")
            {
                alert("Please Enter Fuel Surcharge rate for Air");
                txtfuelsurchargeair.value="0.00";
                txtfuelsurchargeair.focus();
                return false;
            }
            
            if(txtfuelsurchargeroad.value=="")
            {
                alert("Please Enter Fuel Surcharge PerCent for Road");
                txtfuelsurchargeroad.value="0.00";
                txtfuelsurchargeroad.focus();
                return false;
            }
            
            if(txtfuelsurchargetrain.value=="")
            {
                alert("Please Enter Fuel Surcharge for Train");
                txtfuelsurchargetrain.value="0.00";
                txtfuelsurchargetrain.focus();
                return false;
            }
            
            if(txtfuelsurchargeexpress.value=="")
            {
                alert("Please Enter Fuel Surcharge for Express");
                txtfuelsurchargeexpress.value="0.00";
                txtfuelsurchargeexpress.focus();
                return false;
            }
           
     }
     return true;
}

function fuelSurChargeClick()
{

    var trfuelsurcharge=document.getElementById("ctl00_MyCPH1_trfuelsurcharge");
    var chkfuelsurcharge=document.getElementById("ctl00_MyCPH1_chkfuelsurcharge");
        if(chkfuelsurcharge.checked==true)
                trfuelsurcharge.style.display="block";
        else
                trfuelsurcharge.style.display="none";

}

	
	// Inner Function to Ropund upto defined decimal places, returns string
	function roundNumber(num, dec) 
	{
	
	    if(num=="." || num==".0" || num=="0" || num=="0." || num=="" || !num)
	        return "0.00";
	     
	    var result = Math.round(num*Math.pow(10,dec))/Math.pow(10,dec);
	           
        var len=0;
        var number=result.toString();
        len=number.length;
        
        if(number=="." || number==".0" || number=="0" || number=="0." || num=="" || !num)
	        return "0.00";
	        
        if(number.indexOf('.') == parseInt(len - 2) && len>=2)
        {
            number=number + "0";
        }
        else if(number.indexOf('.') == parseInt(len - 1))
        {
            number = number + "00";
        }
        else if(number.indexOf('.')== -1)
        {
            number = number + ".00";
        }
        
        	return number;    
    }
	
	
	
	

function chkMultiPointPickUp(id)
{
    var chkflat=document.getElementById("ctl00_MyCPH1_chkflatmultipointpickup");
    var chkloc=document.getElementById("ctl00_MyCPH1_chklocmultipointpickup");
    var trloading=document.getElementById("ctl00_MyCPH1_trloading");
    
    if(id=="ctl00_MyCPH1_chkflatmultipointpickup")
        {
            if(chkflat.checked==true)
            {
                chkloc.checked=false;
                trloading.style.display="block";
            }
        }
     else
     {
            if(chkloc.checked==true)
            {
                chkflat.checked=false;
                trloading.style.display="block";
            }
     }
     
     if(chkloc.checked==true || chkflat.checked==true)
         trloading.style.display="block";
     else
         trloading.style.display="none";
     
}


function chkMultiPointDelivery(id)
{
    var chkflat=document.getElementById("ctl00_MyCPH1_chkflatmultipointdelivery");
    var chkloc=document.getElementById("ctl00_MyCPH1_chklocmultipointdelivery");
    var trunloading=document.getElementById("ctl00_MyCPH1_trunloading");
    
    if(id=="ctl00_MyCPH1_chkflatmultipointdelivery")
        {
            if(chkflat.checked==true)
            {
                chkloc.checked=false;
            }
        }
     else
     {
            if(chkloc.checked==true)
            {
                chkflat.checked=false;
            }
     }
     
     if(chkloc.checked==true || chkflat.checked==true)
         trunloading.style.display="block";
     else
         trunloading.style.display="none";
     
}
       
            
function chkLoading(id)
{
    var chkflat=document.getElementById("ctl00_MyCPH1_chkflatloading");
    var chkloc=document.getElementById("ctl00_MyCPH1_chklocloading");
    
     if(id=="ctl00_MyCPH1_chkflatloading")
        {
            if(chkflat.checked==true)
                chkloc.checked=false;
        }
     else
     {
            if(chkloc.checked==true)
                chkflat.checked=false;
     }
}

function chkUnLoading(id)
{
    var chkflat=document.getElementById("ctl00_MyCPH1_chkflatunloading");
    var chkloc=document.getElementById("ctl00_MyCPH1_chklocunloading");
    
    if(id=="ctl00_MyCPH1_chkflatunloading")
        {
            if(chkflat.checked==true)
                chkloc.checked=false;
        }
     else
     {
            if(chkloc.checked==true)
                chkflat.checked=false;
     }
}


function locCodeBlur(id,locname)
        {
        
             var txt=document.getElementById(id);
             txt.value=txt.value.toUpperCase();
             if(txt.value=="")
                return false;
             var findobj=false;
             findobj=GetXMLHttpObject();
            
            if(findobj)
            {
                 var strpg="LocationTest.aspx?mode=check&code=loccode&loccode="+ txt.value + "&sid=" + Math.random();
                 findobj.open("GET",strpg);
                 findobj.onreadystatechange=function()
                     {
                         if((findobj.readyState==4) && (findobj.status==200))
                            {
                                  var  res=findobj.responseText.split("|");
                                  if(res[0]=="false")
                                     {
                                        alert("This " + locname + " doesn't Exists..");
                                        txt.select()
                                        return false;
                                     }
                            }
                     }
                 findobj.send(null);
             }
             return true;
        }

           // JScript File
           function cmbFOVChange()
            {
                var cmb=document.getElementById("ctl00_MyCPH1_ddlFOVType");
                var tdper=document.getElementById("ctl00_MyCPH1_tdfovpercentage");
                var tdcharge=document.getElementById("ctl00_MyCPH1_tdfovcharge");
            
                if(cmb.value=="RS")
                {
                    tdcharge.style.display="block";
                    tdper.style.display="none";
                }
                else
                {
                    tdper.style.display="block";
                    tdcharge.style.display="none";
                }
                
                
            }
            
            
            function chkVolumetricChange()
            {
                var chk=document.getElementById("ctl00_MyCPH1_chkTSVolumetric");
                var tr=document.getElementById("ctl00_MyCPH1_trTSVolumetricChecked");
                
                if(chk.checked==true)
                    tr.style.display="block";
                else
                    tr.style.display="none";
            }
            
            
            function chkDACCChange()
            {
                var chk=document.getElementById("ctl00_MyCPH1_chkTSDACC");
                var tr=document.getElementById("ctl00_MyCPH1_trTSDACCChecked");
                
                if(chk.checked==true)
                    tr.style.display="block";
                else
                    tr.style.display="none";
            
            }


var months = new Array("","January", "February", "March", "April", "May", "June",
"July", "August", "September", "October", "November", "December");

var dtCh= "/";
var minYear=1900;
var maxYear=2100;

function isInteger(s)
{
    for (var i = 0; i < s.length; i++)
    {   
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}

function stripCharsInBag(s, bag)
{
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (var i = 0; i < s.length; i++)
    {   
        var c = s.charAt(i);
        if (bag.indexOf(c) == 0) returnString += c;
    }
    
    return returnString;
}

function daysInFebruary (year)
{
	// February has 29 days in any year evenly divisible by four,
    // EXCEPT for centurial years which are not also divisible by 400.
    return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
}

function DaysArray(n)
{
    for (var i = 1; i <= n; i++)
    {
		this[i] = 31
		if (i==4 || i==6 || i==9 || i==11) {this[i] = 30}
		if (i==2) {this[i] = 29}
    }
    
    return this
}

function isDate1(dtStr)
{
	var daysInMonth = DaysArray(12)
	var pos1 = dtStr.indexOf(dtCh)
	var pos2 = dtStr.indexOf(dtCh,pos1+1)
	var strDay = dtStr.substring(0,pos1)
	var strMonth = dtStr.substring(pos1+1,pos2)
	var strYear = dtStr.substring(pos2+1)
	
	strYr = strYear
	
	if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
	if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
	
	for (var i = 1; i <= 3; i++)
	{
		if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
	}
	
	month = parseInt(strMonth)
	day = parseInt(strDay)
	year = parseInt(strYr)
	
	if (pos1==0 || pos2==0)
	{
		alert("The date format should be : dd/mm/yyyy")
		return false
	}
	
	if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month])
	{
		alert("Please enter a valid day")
		return false
	}
	
	if (strMonth.length<1 || month<1 || month>12)
	{
		alert("Please enter a valid month")
		return false
	}
	
	if (strYear.length != 4 || year==0 || year<minYear || year>maxYear)
	{
		alert("Please enter a valid 4 digit year between "+minYear+" and "+maxYear)
		return false
	}
	
	if (dtStr.indexOf(dtCh,pos2+1)!=0 || isInteger(stripCharsInBag(dtStr, dtCh))==false)
	{
		alert("Please enter a valid date")
		return false
	}
	
    return true
}

function ValidateDate(obj)
{  
    if (obj.value!="")
    {
	    var dockdt=obj.value
	
		if(dockdt.length<10)
		{
		    alert("Please enter the date in dd/mm/yyyy format")
		    obj.focus();
		    return false;
		}
	
	    if (isDate1(obj.value)==false)
	    {
		    obj.focus()
		    return false
	    }
	    
        return true
    }  
}
 
function MyDateDiff( start, end, interval, rounding )
{
    var iOut = 0;
    var bufferA = Date.parse( start ) ;
    var bufferB = Date.parse( end ) ;
    	
    // check that the start parameter is a valid Date. 
    if ( isNaN (bufferA) || isNaN (bufferB) )
    {
        alert( startMsg ) ;
        return null ;
    }
	
    // check that an interval parameter was not numeric. 
    if ( interval.charAt == 'undefined' )
    {
        // the user specified an incorrect interval, handle the error. 
        alert( intervalMsg ) ;
        return null ;
    }
    
    var number = bufferB-bufferA ;
    
    // what kind of add to do? 
    switch (interval.charAt(0))
    {
        case 'd': case 'D': 
            iOut = parseInt(number / 86400000) ;
            if(rounding) iOut += parseInt((number % 86400000)/43200001) ;
            break ;
        case 'h': case 'H':
            iOut = parseInt(number / 3600000 ) ;
            if(rounding) iOut += parseInt((number % 3600000)/1800001) ;
            break ;
        case 'm': case 'M':
            iOut = parseInt(number / 60000 ) ;
            if(rounding) iOut += parseInt((number % 60000)/30001) ;
            break ;
        case 's': case 'S':
            iOut = parseInt(number / 1000 ) ;
            if(rounding) iOut += parseInt((number % 1000)/501) ;
            break ;
        default:
        // If we get to here then the interval parameter
        // didn't meet the d,h,m,s criteria.  Handle
        // the error. 		
        alert(intervalMsg) ;
        return null ;
    }
    
    return iOut ;
}

function trimAll(strValue) 
{
    //Trimming left most white space characters
    while (strValue.substring(0,1) == ' ')
    {
        strValue = strValue.substring(1, strValue.length);
    }
    //Trimming right most white space characters
    while (strValue.substring(strValue.length0, strValue.length) == ' ')
    {
        strValue = strValue.substring(0, strValue.length0);
    }
    
    return strValue;
}

function IsNumeric(sText)
{
   var ValidChars = "0123456789.";
   var IsNumber=true;
   var Char;

   for (i = 0; i < sText.length && IsNumber == true; i++) 
   { 
      Char = sText.charAt(i); 
      
      if (ValidChars.indexOf(Char) == 0) 
      {
        IsNumber = false;
      }
   }
   
   return IsNumber;
}

function Nagative_Chk_wDecimal(obj)
{
	var temp = trimAll(obj.value) 
	
	if (temp == "")	
	{
		/*alert("Value can not be blank")
		obj.focus();
		return false;*/
		return true;
	}
	
	if(isNaN(temp))
	{
		alert("Value should be Numeric")
		obj.focus();
		return false;
	} 				
		  
	if(parseFloat(temp) < 0)
	{
		alert("Value should be greater than zero")
		obj.focus();
		return false;
	}
	
	obj.value=roundit(temp) 
	
	return true;					   
}
	
function Nagative_Chk_woDecimal(obj)
{
	var temp = obj.value 
						
	if (temp == "")	
	{
		//alert("Value can not be blank")
		//obj.focus();
		return true;
	}
	
	if(isNaN(temp))
	{
		alert("Value should be Numeric")
		obj.focus();
		return false;
	} 					  
	
	if(parseFloat(temp)<0)
	{
		alert("Value should be greater than zero")
		obj.focus();
		return false;
	}
	
	if(temp.indexOf(".") > 0)
	{
		alert("Value should not contain decimal point")
		obj.focus();
		return false;
	} 
	
	obj.value=Math.round(temp)
	 	
	return true;					 				   
}

function rounditn(Num, decplaces)
{
	Places = decplaces
	
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
				if (Num.toString().lastIndexOf('.')+1==Num.toString().length0)
					return Num.toString() +'0';	
				else
					return Num.toString();				   
    		}
		}
	}
	else
	{
	    return Math.round(Num);
    }
}

function roundit(Num)
{
	Places = 2
	
	if (Places > 0)
	{
		if ((Num.toString().length - Num.toString().lastIndexOf('.')) > (Places+1)) 
		{
			if (Num.toString().lastIndexOf('.') < 0) 
			{
				return Num.toString() + '.00';
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
				if (Num.toString().lastIndexOf('.')+1==Num.toString().length0)
				{
					return Num.toString() +'0';
				}
				else
				{
					return Num.toString();
				}
			}
		}
	}
	else
	{
	    return Math.round(Num);
	}
}
        
    </script>

    <script language="javascript" type="text/javascript">
            
            function CODDODChecked(objCODDOD)
            {
                if(document.getElementById("ctl00_MyCPH1_trTSCODChecked"))
                {
                    var mCODDODApplicableYN = "<%=blnAppForCODDOD %>"
                    
                    if (mCODDODApplicableYN == "Y")
                    {
                        if(objCODDOD.checked == true)
                        {
                            document.getElementById("ctl00_MyCPH1_trTSCODChecked").style.display = '';
                        }
                        else
                        {
                            document.getElementById("ctl00_MyCPH1_trTSCODChecked").style.display = 'none';
                        }
                    }
                }
            }
                     
            function ValidateData()
            {
                //Check for Mode of Transport checkbox
                //at least one checkbox must be checked
                if(document.getElementById("ctl00_MyCPH1_chkMTRoad") && document.getElementById("ctl00_MyCPH1_chkMTAir") && document.getElementById("ctl00_MyCPH1_chkMTTrain") && document.getElementById("ctl00_MyCPH1_chkMTExpress"))
                {
                    if(document.getElementById("ctl00_MyCPH1_chkMTRoad").checked == false && document.getElementById("ctl00_MyCPH1_chkMTAir").checked == false && document.getElementById("ctl00_MyCPH1_chkMTTrain").checked == false && document.getElementById("ctl00_MyCPH1_chkMTExpress").checked == false)
                    {
                        alert("Please select at least one Mode of Transport");
                        document.getElementById("ctl00_MyCPH1_chkMTAir").focus();
                        return false;
                    }
                }
                
                //Check for Type of Load checkbox
                //at least one checkbox must be checked
                if(document.getElementById("ctl00_MyCPH1_chkTLFTL") && document.getElementById("ctl00_MyCPH1_chkTLSundry"))
                {
                    if(document.getElementById("ctl00_MyCPH1_chkTLFTL").checked == false && document.getElementById("ctl00_MyCPH1_chkTLSundry").checked == false)
                    {
                        alert("Please select at least one Type of Load");
                        document.getElementById("ctl00_MyCPH1_chkTLFTL").focus();
                        return false;
                    }
                }
                
                //Check for 'FTL' Type of Load checkbox
                //Road and/or Express checkbox must be checked
                //None of the other checkboxes can be checked
                if(document.getElementById("ctl00_MyCPH1_chkTLFTL"))
                {
                    if(document.getElementById("ctl00_MyCPH1_chkTLFTL").checked == true && document.getElementById("ctl00_MyCPH1_chkTLSundry").checked == false)
                    {
                        if((document.getElementById("ctl00_MyCPH1_chkMTRoad").checked == false && document.getElementById("ctl00_MyCPH1_chkMTExpress").checked == false) || (document.getElementById("ctl00_MyCPH1_chkMTAir").checked == true)  || (document.getElementById("ctl00_MyCPH1_chkMTTrain").checked == true))
                        {
                            alert("For 'FTL' Type of Load, you can select 'Road' and/or 'Express' as Mode of Transport");
                            document.getElementById("ctl00_MyCPH1_chkMTRoad").focus();
                            return false;
                        }
                    }
                }
                
                //Check for Pickup-Delivery checkbox
                //at least one checkbox must be checked
                if(document.getElementById("ctl00_MyCPH1_chkGD") && document.getElementById("ctl00_MyCPH1_chkGG") && document.getElementById("ctl00_MyCPH1_chkDD") && document.getElementById("ctl00_MyCPH1_chkDG"))
                {
                    if(document.getElementById("ctl00_MyCPH1_chkGD").checked == false && document.getElementById("ctl00_MyCPH1_chkGG").checked == false && document.getElementById("ctl00_MyCPH1_chkDD").checked == false && document.getElementById("ctl00_MyCPH1_chkDG").checked == false)
                    {
                        alert("Please select at least one Pickup-Delivery from the list");
                        document.getElementById("ctl00_MyCPH1_chkGD").focus();
                        return false;
                    }
                }
                
                //Check for Godown-Door checkbox
                //Minimum Charges and Rate/Kg. for DELIVERY must be entered
                if(document.getElementById("ctl00_MyCPH1_chkGD"))
                {
                    if(document.getElementById("ctl00_MyCPH1_chkGD").checked == true)
                    {
                        //Check for Minimum Charges
                        if(document.getElementById("ctl00_MyCPH1_txtDoorDeliveryCharge"))
                        {
                            document.getElementById("ctl00_MyCPH1_txtDoorDeliveryCharge").value = trimAll(document.getElementById("ctl00_MyCPH1_txtDoorDeliveryCharge").value);
                            
                            if(document.getElementById("ctl00_MyCPH1_txtDoorDeliveryCharge").value == "")
                            {
                                alert("Please enter 'Minimum Charges' for Door Delivery");
                                document.getElementById("ctl00_MyCPH1_txtDoorDeliveryCharge").focus();
                                return false;
                            }
                        }
                        
                        //Check for Rate/Kg.
                        if(document.getElementById("ctl00_MyCPH1_txtDoorDeliveryChargePerKg"))
                        {
                            document.getElementById("ctl00_MyCPH1_txtDoorDeliveryChargePerKg").value = trimAll(document.getElementById("ctl00_MyCPH1_txtDoorDeliveryChargePerKg").value);
                            
                            if(document.getElementById("ctl00_MyCPH1_txtDoorDeliveryChargePerKg").value == "")
                            {
                                alert("Please enter 'Rate/Kg.' charges for Door Delivery");
                                document.getElementById("ctl00_MyCPH1_txtDoorDeliveryChargePerKg").focus();
                                return false;
                            }
                        }
                    }
                }
                
                //Check for Door-Door checkbox
                //Minimum Charges and Rate/Kg. for both PICKUP & DELIVERY must be entered
                if(document.getElementById("ctl00_MyCPH1_chkDD"))
                {
                    if(document.getElementById("ctl00_MyCPH1_chkDD").checked == true)
                    {
                        //Check for Minimum Charges for Pickup
                        if(document.getElementById("ctl00_MyCPH1_txtDoorPickupCharge"))
                        {
                            document.getElementById("ctl00_MyCPH1_txtDoorPickupCharge").value = trimAll(document.getElementById("ctl00_MyCPH1_txtDoorPickupCharge").value);
                            
                            if(document.getElementById("ctl00_MyCPH1_txtDoorPickupCharge").value == "")
                            {
                                alert("Please enter 'Minimum Charges' for Door Pickup");
                                document.getElementById("ctl00_MyCPH1_txtDoorPickupCharge").focus();
                                return false;
                            }
                        }
                        
                        //Check for Rate/Kg. for Pickup
                        if(document.getElementById("ctl00_MyCPH1_txtDoorPickupChargePerKg"))
                        {
                            document.getElementById("ctl00_MyCPH1_txtDoorPickupChargePerKg").value = trimAll(document.getElementById("ctl00_MyCPH1_txtDoorPickupChargePerKg").value);
                            
                            if(document.getElementById("ctl00_MyCPH1_txtDoorPickupChargePerKg").value == "")
                            {
                                alert("Please enter 'Rate/Kg.' charges for Door Pickup");
                                document.getElementById("ctl00_MyCPH1_txtDoorPickupChargePerKg").focus();
                                return false;
                            }
                        }
                        
                        //Check for Minimum Charges for Delivery
                        if(document.getElementById("ctl00_MyCPH1_txtDoorDeliveryCharge"))
                        {
                            document.getElementById("ctl00_MyCPH1_txtDoorDeliveryCharge").value = trimAll(document.getElementById("ctl00_MyCPH1_txtDoorDeliveryCharge").value);
                            
                            if(document.getElementById("ctl00_MyCPH1_txtDoorDeliveryCharge").value == "")
                            {
                                alert("Please enter 'Minimum Charges' for Door Delivery");
                                document.getElementById("ctl00_MyCPH1_txtDoorDeliveryCharge").focus();
                                return false;
                            }
                        }
                        
                        //Check for Rate/Kg. for Delivery
                        if(document.getElementById("ctl00_MyCPH1_txtDoorDeliveryChargePerKg"))
                        {
                            document.getElementById("ctl00_MyCPH1_txtDoorDeliveryChargePerKg").value = trimAll(document.getElementById("ctl00_MyCPH1_txtDoorDeliveryChargePerKg").value);
                            
                            if(document.getElementById("ctl00_MyCPH1_txtDoorDeliveryChargePerKg").value == "")
                            {
                                alert("Please enter 'Rate/Kg.' charges for Door Delivery");
                                document.getElementById("ctl00_MyCPH1_txtDoorDeliveryChargePerKg").focus();
                                return false;
                            }
                        }
                    }
                }
                
                //Check for Door-Godown checkbox
                //Minimum Charges and Rate/Kg. for both PICKUP must be entered
                if(document.getElementById("ctl00_MyCPH1_chkDG"))
                {
                    if(document.getElementById("ctl00_MyCPH1_chkDG").checked == true)
                    {
                        //Check for Minimum Charges for Pickup
                        if(document.getElementById("ctl00_MyCPH1_txtDoorPickupCharge"))
                        {
                            document.getElementById("ctl00_MyCPH1_txtDoorPickupCharge").value = trimAll(document.getElementById("ctl00_MyCPH1_txtDoorPickupCharge").value);
                            
                            if(document.getElementById("ctl00_MyCPH1_txtDoorPickupCharge").value == "")
                            {
                                alert("Please enter 'Minimum Charges' for Door Pickup");
                                document.getElementById("ctl00_MyCPH1_txtDoorPickupCharge").focus();
                                return false;
                            }
                        }
                        
                        //Check for Rate/Kg. for Pickup
                        if(document.getElementById("ctl00_MyCPH1_txtDoorPickupChargePerKg"))
                        {
                            document.getElementById("ctl00_MyCPH1_txtDoorPickupChargePerKg").value = trimAll(document.getElementById("ctl00_MyCPH1_txtDoorPickupChargePerKg").value);
                            
                            if(document.getElementById("ctl00_MyCPH1_txtDoorPickupChargePerKg").value == "")
                            {
                                alert("Please enter 'Rate/Kg.' charges for Door Pickup");
                                document.getElementById("ctl00_MyCPH1_txtDoorPickupChargePerKg").focus();
                                return false;
                            }
                        }
                    }    
                }
                
                //Check for FOV details
                if(document.getElementById("ctl00_MyCPH1_trFOVCharge"))
                {
                   if(document.getElementById("ctl00_MyCPH1_ddlFOVType"))
                    {
                        if(document.getElementById("ctl00_MyCPH1_ddlFOVType").value == "0")
                        {
                            alert("Please select 'FOV Type' from the list");
                            document.getElementById("ctl00_MyCPH1_ddlFOVType").focus();
                            return false;
                        }
                        else if(document.getElementById("ctl00_MyCPH1_ddlFOVType").value == "RS")
                        {
                             if(document.getElementById("ctl00_MyCPH1_txtFOVCharge"))
                                {
                                    document.getElementById("ctl00_MyCPH1_txtFOVCharge").value = trimAll(document.getElementById("ctl00_MyCPH1_txtFOVCharge").value)
                                    if(document.getElementById("ctl00_MyCPH1_txtFOVCharge").value == "")
                                    {
                                        alert("Please enter 'FOV Rate'");
                                        document.getElementById("ctl00_MyCPH1_txtFOVCharge").focus();
                                        return false;
                                    }
                                }
                        }
                        else if(document.getElementById("ctl00_MyCPH1_ddlFOVType").value == "%")
                        {
                            if(document.getElementById("ctl00_MyCPH1_txtcarrierrisk"))
                            {
                                if(document.getElementById("ctl00_MyCPH1_txtcarrierrisk").value=="")
                                {
                                    alert("Please enter Carrier's Risk");
                                    return false;
                                }
                            }
                            
                            if(document.getElementById("ctl00_MyCPH1_txtownerrisk"))
                            {
                                if(document.getElementById("ctl00_MyCPH1_txtownerrisk").value=="")
                                {
                                    alert("Please enter Owner's Risk");
                                    return false;
                                }
                            }
                        }
                    }
                 }
                 
                 
                var optownerrisk=document.getElementById("ctl00_MyCPH1_optrisktype_0")
                var optcarrierrisk=document.getElementById("ctl00_MyCPH1_optrisktype_1")
                if(optownerrisk.checked==false && optcarrierrisk.checked==false)
                {
                    alert("Please Select Risk Type......");
                    optownerrisk.focus();
                    return false;
                }
                
                var optbastype=document.getElementById("ctl00_MyCPH1_optminfreihgttype_0")
                var optpercenttype=document.getElementById("ctl00_MyCPH1_optminfreihgttype_1")
                if(optbastype.checked==false && optpercenttype.checked==false)
                {
                    alert("Please Minimum Freight Type......");
                    optbastype.focus();
                    return false;
                }
                
                
                
                //Check for COD-DOD checkbox
                //Minimum Charges and % of Amount must be entered
                if(document.getElementById("ctl00_MyCPH1_chkTSCODDOD"))
                {
                    if(document.getElementById("ctl00_MyCPH1_chkTSCODDOD").checked == true)
                    {
                        //Check for Minimum Charges
                        if(document.getElementById("ctl00_MyCPH1_txtCODCharge"))
                        {
                            document.getElementById("ctl00_MyCPH1_txtCODCharge").value = trimAll(document.getElementById("ctl00_MyCPH1_txtCODCharge").value);
                            
                            if(document.getElementById("ctl00_MyCPH1_txtCODCharge").value == "")
                            {
                                alert("Please enter 'Minimum Charges' for COD/DOD");
                                document.getElementById("ctl00_MyCPH1_txtCODCharge").focus();
                                return false;
                            }
                        }
                        
                        //Check for % of Amount
                        if(document.getElementById("ctl00_MyCPH1_txtCODChargePer"))
                        {
                            document.getElementById("ctl00_MyCPH1_txtCODChargePer").value = trimAll(document.getElementById("ctl00_MyCPH1_txtCODChargePer").value);
                            
                            if(document.getElementById("ctl00_MyCPH1_txtCODChargePer").value == "")
                            {
                                alert("Please enter '% of Amount' for COD/DOD");
                                document.getElementById("ctl00_MyCPH1_txtCODChargePer").focus();
                                return false;
                            }
                        }
                    }
                }
                
                //Check for Volumetric checkbox
                //Minimum Charges and % of Amount must be entered
                if(document.getElementById("ctl00_MyCPH1_chkTSVolumetric"))
                {
                    if(document.getElementById("ctl00_MyCPH1_chkTSVolumetric").checked == true)
                    {
                        //Check for Minimum Charges
                        if(document.getElementById("ctl00_MyCPH1_ddlVolMeasure"))
                        {
                            if(document.getElementById("ctl00_MyCPH1_ddlVolMeasure").value == "0")
                            {
                                alert("Please select 'Volumetric Measure' from the list");
                                document.getElementById("ctl00_MyCPH1_ddlVolMeasure").focus();
                                return false;
                            }
                        }
                        
                        //Check for Volumetric Conversion
                        if(document.getElementById("ctl00_MyCPH1_txtCFTToKg"))
                        {
                            document.getElementById("ctl00_MyCPH1_txtCFTToKg").value = trimAll(document.getElementById("ctl00_MyCPH1_txtCFTToKg").value);
                            
                            if(document.getElementById("ctl00_MyCPH1_txtCFTToKg").value == "")
                            {
                                alert("Please enter 'Volumetric Conversion 1 CFT = Kg.'");
                                document.getElementById("ctl00_MyCPH1_txtCFTToKg").focus();
                                return false;
                            }
                        }
                    }
                }
                
                //Check for DACC checkbox
                //Minimum Charges and % of Amount must be entered
                if(document.getElementById("ctl00_MyCPH1_chkTSDACC"))
                {
                    if(document.getElementById("ctl00_MyCPH1_chkTSDACC").checked == true)
                    {
                        //Check for Minimum in Rs.
                        if(document.getElementById("ctl00_MyCPH1_txtDACCChargeRs"))
                        {
                            document.getElementById("ctl00_MyCPH1_txtDACCChargeRs").value = trimAll(document.getElementById("ctl00_MyCPH1_txtDACCChargeRs").value);
                            
                            if(document.getElementById("ctl00_MyCPH1_txtDACCChargeRs").value == "")
                            {
                                alert("Please enter 'Minimum in Rs.'");
                                document.getElementById("ctl00_MyCPH1_txtDACCChargeRs").focus();
                                return false;
                            }
                        }
                        
                        //Check for % of Freight
                        if(document.getElementById("ctl00_MyCPH1_txtDACCChargePer"))
                        {
                            document.getElementById("ctl00_MyCPH1_txtDACCChargePer").value = trimAll(document.getElementById("ctl00_MyCPH1_txtDACCChargePer").value);
                            
                            if(document.getElementById("ctl00_MyCPH1_txtDACCChargePer").value == "")
                            {
                                alert("Please enter '% of Freight'");
                                document.getElementById("ctl00_MyCPH1_txtDACCChargePer").focus();
                                return false;
                            }
                        }
                    }
                }
                
                
                // Fuel surcharge validation
                if(!validateFuelSurCharge())
                    return false;
                    
                // Octroi SurCharge Validation
                if(!validateOctroiSurCharge())
                     return false;
                    
                    
                    
                var cmbpaybas=document.getElementById("ctl00_MyCPH1_cmbpaybas");
                if(cmbpaybas.value=="P02")
                {
                        //Check for Bill Generation at Location
                        var txtbillgenloc=document.getElementById("ctl00_MyCPH1_txtBillGen");
                        if(txtbillgenloc.value == "")
                        {
                            alert("Please enter 'Bill Generation at Location'");
                            txtbillgenloc.focus();
                            return false;
                        }
                    
                        //Check for Billing Instance
                        var cmbbillinginst=document.getElementById("ctl00_MyCPH1_ddlBillingInstance");
                        if(cmbbillinginst.value == "0" || cmbbillinginst.value == "")
                        {
                            alert("Please select 'Billing Instance' from the list");
                            cmbbillinginst.focus();
                            return false;
                        }
                   
                        //Check for Bill Submission at Location
                        var txtbillsubloc=document.getElementById("ctl00_MyCPH1_txtBillSubLocation");
                        if(txtbillsubloc.value == "")
                        {
                            alert("Please enter 'Bill Submission at Location'");
                            txtbillsubloc.focus();
                            return false;
                        }
                    
                        //Check for Bill Collection at Location
                        var txtbillcolloc=document.getElementById("ctl00_MyCPH1_txtBillCollLocation");
                        if(txtbillcolloc.value == "")
                        {
                            alert("Please enter 'Bill Collection at Location'");
                            txtbillcolloc.focus();
                            return false;
                        }
               } 
                
                
                //Check for Service Tax Applicable & Paid By
                    var cmbstaxpaidby=document.getElementById("ctl00_MyCPH1_cmbstaxpaidby");
                    if(cmbstaxpaidby.value == "0" || cmbstaxpaidby.value=="")
                      {
                            alert("Please select 'Service Tax Paid by' from the list");
                            cmbstaxpaidby.focus();
                            return false;
                      }                    

                                
                //Check for Minimum Freight entries
                
                //Rate and Basis must be entered/selected for Air row
                //If 'Air' Mode of Transport is checked
                
                var optminfreihgttype_bas=document.getElementById("ctl00_MyCPH1_optminfreihgttype_0");
                var chkair=document.getElementById("ctl00_MyCPH1_chkMTAir");
                var txtbasrateair=document.getElementById("ctl00_MyCPH1_txtairrateforfreight");
                var cmbbasair=document.getElementById("ctl00_MyCPH1_ddlairbasisforfreight");
                
                var chkroad=document.getElementById("ctl00_MyCPH1_chkMTRoad");
                var txtbasrateroad=document.getElementById("ctl00_MyCPH1_txtroadrateforfreight");
                var cmbbasroad=document.getElementById("ctl00_MyCPH1_ddlroadbasisforfreight");
                
                var chktrain=document.getElementById("ctl00_MyCPH1_chkMTTrain");
                var txtbasratetrain=document.getElementById("ctl00_MyCPH1_txttrainrateforfreight");
                var cmbbastrain=document.getElementById("ctl00_MyCPH1_ddltrainbasisforfreight");
                
                var chkexpress=document.getElementById("ctl00_MyCPH1_chkMTExpress");
                var txtbasrateexpress=document.getElementById("ctl00_MyCPH1_txtExpressRateForFreight");
                var cmbbasexpress=document.getElementById("ctl00_MyCPH1_ddlexpressbasisforfreight");
                
                if(optminfreihgttype_bas.checked==true)
                {
                        if(chkair.checked == true)
                        {
                            if(txtbasrateair.value == "")
                            {
                                alert("Please enter 'Freight Rate' for 'Air' Mode of Transport");
                                txtbasrateair.focus();
                                return false;
                            }
                            
                            if(cmbbasair.value == "0" || cmbbasair.value == "" )
                            {
                                alert("Please select 'Basis' for 'Air' Mode of Transport, from the list");
                                cmbbasair.focus();
                                return false;
                            }
                        } // air checked
                
                        if(chkroad.checked == true)
                        {
                            if(txtbasrateroad.value == "")
                            {
                                alert("Please enter 'Freight Rate' for 'Road' Mode of Transport");
                                txtbasrateroad.focus();
                                return false;
                            }
                        
                            if(cmbbasroad.value == "0")
                            {
                                alert("Please select 'Basis' for 'Road' Mode of Transport, from the list");
                                cmbbasroad.focus();
                                return false;
                            }
                        } // road checked
                 
                        if(chktrain.checked == true)
                        {
                            if(txtbasratetrain.value == "")
                            {
                                alert("Please enter 'Freight Rate' for 'Train' Mode of Transport");
                                txtbasratetrain.focus();
                                return false;
                            }

                            if(cmbbastrain.value == "0" || cmbbastrain.value == "")
                            {
                                alert("Please select 'Basis' for 'Train' Mode of Transport, from the list");
                                cmbbastrain.focus();
                                return false;
                            }
                        } // train checked
                    
                        if(chkexpress.checked == true)
                        {
                            if(txtbasrateexpress.value == "")
                            {
                                alert("Please enter 'Freight Rate' for 'Express' Mode of Transport");
                                txtbasrateexpress.focus();
                                return false;
                            }
                            
                            if(cmbbasexpress.value == "0" || cmbbasexpress.value == "")
                            {
                                alert("Please select 'Basis' for 'Express' Mode of Transport, from the list");
                                cmbbasexpress.focus();
                                return false;
                            }
                        } // express checked
                   
                } // end of min freihgt bas checking
                
                
                //ONLY FOR RCPL
                var hdnclient = document.getElementById("ctl00_MyCPH1_hdnclient");
                if(hdnclient.value=="RCPL")
                {
                    var txtcombus=document.getElementById("ctl00_MyCPH1_txtcommitedbusiness");
                    if(txtcombus.value=="")
                    {
                        alert("Please Enter Commite Business...");
                        txtcombus.select();
                        return false;
                    }
                }
                
                return true;
            }
            
    </script>

    <script type="text/javascript" language="javascript">
    
       
    function chkcoddodchange()
    {
        var chkcod=document.getElementById("ctl00_MyCPH1_chkTSCODDOD");
        var tr=document.getElementById("ctl00_MyCPH1_trTSCODChecked");
      
            if(chkcod.checked==true)
                tr.style.display="block";
            else
                tr.style.display="none";
      
        return true;
    }

  
     function chktsvolumetricchange()
        {
            var chk=document.getElementById("ctl00_MyCPH1_chkTSVolumetric");
            var tr=document.getElementById("ctl00_MyCPH1_trTSVolumetricChecked");
                       
                if(chk.checked==true)
                    tr.style.display="block";
                else
                    tr.style.display="none";
          
            return true;
        }
   
    
    function chktsdaccchange()
    {
        var chk=document.getElementById("ctl00_MyCPH1_chkTSDACC");
        var tr=document.getElementById("ctl00_MyCPH1_trTSDACCChecked");
        var hdn=document.getElementById("ctl00_MyCPH1_HidDACCApp");
        
        if(hdn.value=="Y")
        {
            if(chk.checked==true)
                tr.style.display="block";
            else
                tr.style.display="none";
        }
        
        return true;
    }
    
    </script>

    <asp:Panel Width="10in" runat="server">
        <br />
        <br />
        <asp:Table runat="server" Width="9in" CssClass="boxbg" CellSpacing="1">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell HorizontalAlign="Center" ColumnSpan="2" Font-Bold="true">Default Contract Master</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow BackColor="white">
                <asp:TableCell HorizontalAlign="Center">
                     Payment Basis&nbsp;
                    <asp:DropDownList ID="cmbpaybas" AutoPostBack="true" OnTextChanged="cmbpaybas_TextChanged"
                        runat="server" BackColor="White" CssClass="blackfnt">
                        <asp:ListItem Selected="True" Text="Select" Value="0"></asp:ListItem>
                        <asp:ListItem Value="P01" Text="Paid"></asp:ListItem>
                        <asp:ListItem Value="P02" Text="TBB"></asp:ListItem>
                        <asp:ListItem Value="P03" Text="ToPay"></asp:ListItem>
                    </asp:DropDownList>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <br />
        <asp:Table ID="tblmain" runat="server" Width="9in" CellSpacing="0">
            <asp:TableRow>
                <asp:TableCell HorizontalAlign="left">
                    <asp:Table Width="100%" runat="server" CellSpacing="0">
                        <asp:TableRow>
                            <asp:TableCell HorizontalAlign="Left" VerticalAlign="top">
                                <asp:Table Width="100%" runat="server" CellSpacing="0">
                                    <asp:TableRow>
                                        <asp:TableCell VerticalAlign="top">
                                            <asp:Table border="0" runat="server" Width="100%" CellSpacing="1" HorizontalAlign="Left"
                                                CssClass="boxbg">
                                                <asp:TableRow CssClass="bgbluegrey">
                                                    <asp:TableCell ColumnSpan="6" HorizontalAlign="left" CssClass="blackfnt">
                                                        <b>&nbsp;Step 2: Summary of Charges </b>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow>
                                                    <asp:TableCell Style="background-color: White;" CssClass="blackfnt">
                                                            Mode of Transport:
                                                    </asp:TableCell>
                                                    <asp:TableCell Style="background-color: White">
                                                        <asp:CheckBox ID="chkMTAir" runat="server" CssClass="blackfnt" />
                                                    </asp:TableCell>
                                                    <asp:TableCell Style="background-color: White">
                                                        <asp:CheckBox ID="chkMTRoad" runat="server" CssClass="blackfnt" />
                                                    </asp:TableCell>
                                                    <asp:TableCell Style="background-color: White">
                                                        <asp:CheckBox ID="chkMTTrain" runat="server" CssClass="blackfnt" />
                                                    </asp:TableCell>
                                                    <asp:TableCell Style="background-color: White" ColumnSpan="2">
                                                        <asp:CheckBox ID="chkMTExpress" runat="server" CssClass="blackfnt" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow>
                                                    <asp:TableCell Style="background-color: White" CssClass="blackfnt">
                                                            &nbsp;Type of Load:
                                                    </asp:TableCell>
                                                    <asp:TableCell Style="background-color: White">
                                                        <asp:CheckBox ID="chkTLFTL" runat="server" CssClass="blackfnt" />
                                                    </asp:TableCell>
                                                    <asp:TableCell Style="background-color: White" ColumnSpan="4">
                                                        <asp:CheckBox ID="chkTLSundry" runat="server" CssClass="blackfnt" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="trmultipointpickup" runat="server" Style="background-color: White">
                                                    <asp:TableCell>
                                                        Flat MultiPoint PickUp
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:CheckBox ID="chkflatmultipointpickup" runat="server" CssClass="blackfnt" onclick="javascript:return chkMultiPointPickUp(this.getAttribute('id'))" />
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        Location Wise MultiPoint PickUp
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="3">
                                                        <asp:CheckBox ID="chklocmultipointpickup" runat="server" CssClass="blackfnt" onclick="javascript:return chkMultiPointPickUp(this.getAttribute('id'))" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="trloading" runat="server" Style="background-color: White">
                                                    <asp:TableCell>
                                                        Flat Loading Charges
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:CheckBox ID="chkflatloading" runat="server" CssClass="blackfnt" onclick="javascript:return chkLoading(this.getAttribute('id'))" />
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        Location Wise Loading Charges
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="3">
                                                        <asp:CheckBox ID="chklocloading" runat="server" CssClass="blackfnt" onclick="javascript:return chkLoading(this.getAttribute('id'))" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="trmultipointdelivery" runat="server" Style="background-color: White">
                                                    <asp:TableCell>
                                                        Flat MultiPoint Delivery
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:CheckBox ID="chkflatmultipointdelivery" runat="server" CssClass="blackfnt" onclick="javascript:return chkMultiPointDelivery(this.getAttribute('id'))" />
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        Location Wise MultiPoint Delivery
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="3">
                                                        <asp:CheckBox ID="chklocmultipointdelivery" runat="server" CssClass="blackfnt" onclick="javascript:return chkMultiPointDelivery(this.getAttribute('id'))" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="trunloading" runat="server" Style="background-color: White">
                                                    <asp:TableCell>
                                                        Flat Unloading Charges
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:CheckBox ID="chkflatunloading" runat="server" CssClass="blackfnt" onclick="javascript:return chkUnLoading(this.getAttribute('id'))" />
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        Location Wise Unloading Charges
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="3">
                                                        <asp:CheckBox ID="chklocunloading" runat="server" CssClass="blackfnt" onclick="javascript:return chkUnLoading(this.getAttribute('id'))" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow BackColor="White">
                                                    <asp:TableCell>
                                                            &nbsp;Pickup-Delivery:
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:CheckBox ID="chkGD" runat="server" CssClass="blackfnt" />
                                                        Godown-Door
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:CheckBox ID="chkGG" runat="server" CssClass="blackfnt" />
                                                        Godown-Godown
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:CheckBox ID="chkDD" runat="server" CssClass="blackfnt" />
                                                        Door-Door
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="2">
                                                        <asp:CheckBox ID="chkDG" runat="server" CssClass="blackfnt" />
                                                        Door-Godown
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="trDoorPickupCharge" runat="server" Visible="false" Style="background-color: White">
                                                    <asp:TableCell>
                                                            &nbsp;Door Pickup Charges:
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                            &nbsp;Minimum in Rs.:
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <input id="txtDoorPickupCharge" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                            style="margin-left: 5px; border-style: groove;" runat="server" />
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                            &nbsp;Rate/Kg.:
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="2">
                                                        <input id="txtDoorPickupChargePerKg" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                            style="margin-left: 5px;" runat="server" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="trDoorDeliveryCharge" runat="server" Visible="false" Style="background-color: White">
                                                    <asp:TableCell>
                                                            &nbsp;Door Delivery Charges:
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                            &nbsp;Minimum in Rs.:
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <input id="txtDoorDeliveryCharge" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                            style="margin-left: 5px;" runat="server" />
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                       
                                                            &nbsp;Rate/Kg.:
                                                       
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="2">
                                                        <input id="txtDoorDeliveryChargePerKg" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                            style="margin-left: 5px;" runat="server" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow Style="background-color: white; width: 100%" ID="trFOVCharge" runat="server"
                                                    Visible="false">
                                                    <asp:TableCell>
                                                            FOV Type:
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:DropDownList ID="ddlFOVType" BackColor="White" onchange="javascript:return cmbFOVChange()"
                                                            runat="server" CssClass="blackfnt">
                                                            <asp:ListItem Selected="True" Text="Select" Value="0"></asp:ListItem>
                                                            <asp:ListItem Selected="False" Text="RS." Value="RS"></asp:ListItem>
                                                            <asp:ListItem Selected="False" Text="% of Invoice" Value="%"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </asp:TableCell>
                                                    <asp:TableCell ID="tdfovcharge" ColumnSpan="4" runat="server" CssClass="blackfnt">
                                                        <asp:Table Width="100%" CellSpacing="1" runat="server" CssClass="boxbg">
                                                            <asp:TableRow BackColor="#ffffff">
                                                                <asp:TableCell>
                                                                    FOV Rate:</asp:TableCell>
                                                                <asp:TableCell ColumnSpan="3">
                                                                    <input id="txtFOVCharge" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                                        runat="server" />
                                                                </asp:TableCell>
                                                            </asp:TableRow>
                                                        </asp:Table>
                                                    </asp:TableCell>
                                                    <asp:TableCell ID="tdfovpercentage" ColumnSpan="4" Style="display: none;" CssClass="blackfnt"
                                                        runat="server">
                                                        <asp:Table runat="server" Width="100%" CellSpacing="1" CssClass="boxbg">
                                                            <asp:TableRow BackColor="#ffffff">
                                                                <asp:TableCell>
                                                                    FOV Owner Risk(%)</asp:TableCell>
                                                                <asp:TableCell>
                                                                    <input id="txtownerrisk" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                                        style="border-style: groove; text-align: right" runat="server" />
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    FOV Carrier Risk(%)</asp:TableCell>
                                                                <asp:TableCell>
                                                                    <input id="txtcarrierrisk" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                                        style="border-style: groove; text-align: right" runat="server" />
                                                                </asp:TableCell>
                                                            </asp:TableRow>
                                                        </asp:Table>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow Style="background-color: White">
                                                    <asp:TableCell>Risk Type</asp:TableCell>
                                                    <asp:TableCell ColumnSpan="5">
                                                        <asp:RadioButtonList ID="optrisktype" runat="server" RepeatDirection="Horizontal"
                                                            CssClass="blackfnt">
                                                            <asp:ListItem Value="C" Text="Carrier Risk"></asp:ListItem>
                                                            <asp:ListItem Value="O" Text="Owner Risk"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow BackColor="White">
                                                    <asp:TableCell>
                                                            Type of Minimum Freight 
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="5">
                                                        <asp:RadioButtonList ID="optminfreihgttype" onclick="javascript:return minFreightTypeClick()"
                                                            runat="server" RepeatDirection="Horizontal" CssClass="blackfnt">
                                                            <asp:ListItem Value="B" Text="Base Wise"></asp:ListItem>
                                                            <asp:ListItem Value="%" Text="Percent Wise"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow Style="background-color: White">
                                                    <asp:TableCell>
                                                        &nbsp;
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        &nbsp;
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                      
                                                            &nbsp;Insurance Percentage:
                                                      
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="4">
                                                        <input id="txtInsPer" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                            style="margin-left: 5px; border-left-style: groove;" runat="server" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow>
                                                    <asp:TableCell Style="background-color: White">
                                                            &nbsp;Type of Service:
                                                    </asp:TableCell>
                                                    <asp:TableCell Style="background-color: White">
                                                        <asp:CheckBox ID="chkTSCODDOD" runat="server" onclick="javascript:return chkcoddodchange()"
                                                            Style="margin-left: 1px;" />
                                                        COD/DOD
                                                    </asp:TableCell>
                                                    <asp:TableCell Style="background-color: White">
                                                        <input type="checkbox" id="chkTSODA" runat="server" style="margin-left: 1px;" />
                                                        ODA
                                                    </asp:TableCell>
                                                    <asp:TableCell Style="background-color: White">
                                                        <asp:CheckBox ID="chkTSVolumetric" runat="server" onclick="javascript:return chkVolumetricChange();"
                                                            Style="margin-left: 1px;" />
                                                        Volumetric
                                                    </asp:TableCell>
                                                    <asp:TableCell Style="background-color: White" ColumnSpan="2" VerticalAlign="top">
                                                        <asp:CheckBox ID="chkTSDACC" runat="server" onclick="javascript:return chkDACCChange();"
                                                            Style="margin-left: 1px;" />
                                                        DACC
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <%--Table row for COD-DOD (Type of Service) checkbox checked--%>
                                                <asp:TableRow ID="trTSCODChecked" runat="server" Style="background-color: White">
                                                    <asp:TableCell ColumnSpan="6">
                                                        <asp:Table Width="100%" runat="server" CssClass="boxbg" CellSpacing="1">
                                                            <asp:TableRow Style="background-color: White">
                                                                <asp:TableCell>
                                                                        &nbsp;COD/DOD Charges:
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                        &nbsp;Minimum in Rs.:
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <input id="txtCODCharge" type="text" size="10" class="blackfnt" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                                        style="margin-left: 5px;" runat="server" />
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                        &nbsp;% of Amount:
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <input id="txtCODChargePer" type="text" size="10" class="blackfnt" maxlength="8"
                                                                        onblur="return Nagative_Chk_wDecimal(this)" style="margin-left: 5px;" runat="server" />
                                                                </asp:TableCell>
                                                            </asp:TableRow>
                                                        </asp:Table>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <%--Table row for Volumetric (Type of Service) checkbox checked--%>
                                                <asp:TableRow BackColor="White">
                                                    <asp:TableCell>
                                                        Fuel Surcharge Applicable
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:CheckBox ID="chkfuelsurcharge" runat="server" onclick="javascript:return fuelSurChargeClick()" />
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        Octroi Surcharge Applicable
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:CheckBox ID="chkoctroisurcharge" runat="server" onclick="javascript:return octroiSurChargeClick()" />
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="2"></asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow BackColor="White" ID="trfuelsurcharge" runat="server">
                                                    <asp:TableCell ColumnSpan="6">
                                                        <asp:Table runat="server" ID="tblfuelsurcharge" Style="width: 100%;" CssClass="boxbg"
                                                            CellSpacing="1">
                                                            <asp:TableRow BackColor="White">
                                                                <asp:TableCell></asp:TableCell>
                                                                <asp:TableCell>Air</asp:TableCell>
                                                                <asp:TableCell>Road</asp:TableCell>
                                                                <asp:TableCell>Train</asp:TableCell>
                                                                <asp:TableCell>Express</asp:TableCell>
                                                            </asp:TableRow>
                                                            <asp:TableRow BackColor="White">
                                                                <asp:TableCell>
                                                                    Fuel Surcharge Based On
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:DropDownList ID="cmbfuelsurchargebasair" BackColor="White" runat="server" CssClass="blackfnt">
                                                                        <asp:ListItem Value="0">Select</asp:ListItem>
                                                                        <asp:ListItem Value="%">PerCent on Freight</asp:ListItem>
                                                                        <asp:ListItem Value="W">PerKG</asp:ListItem>
                                                                        <asp:ListItem Value="F">Flat RS</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:DropDownList ID="cmbfuelsurchargebasroad" BackColor="White" runat="server" CssClass="blackfnt">
                                                                        <asp:ListItem Value="0">Select</asp:ListItem>
                                                                        <asp:ListItem Value="%">PerCent on Freight</asp:ListItem>
                                                                        <asp:ListItem Value="W">PerKG</asp:ListItem>
                                                                        <asp:ListItem Value="F">Flat RS</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:DropDownList ID="cmbfuelsurchargebastrain" BackColor="White" runat="server"
                                                                        CssClass="blackfnt">
                                                                        <asp:ListItem Value="0">Select</asp:ListItem>
                                                                        <asp:ListItem Value="%">PerCent on Freight</asp:ListItem>
                                                                        <asp:ListItem Value="W">PerKG</asp:ListItem>
                                                                        <asp:ListItem Value="F">Flat RS</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:DropDownList ID="cmbfuelsurchargebasexpress" BackColor="White" runat="server"
                                                                        CssClass="blackfnt">
                                                                        <asp:ListItem Value="0">Select</asp:ListItem>
                                                                        <asp:ListItem Value="%">PerCent on Freight</asp:ListItem>
                                                                        <asp:ListItem Value="W">PerKG</asp:ListItem>
                                                                        <asp:ListItem Value="F">Flat RS</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </asp:TableCell>
                                                            </asp:TableRow>
                                                            <asp:TableRow BackColor="White">
                                                                <asp:TableCell>
                                                                    Rate</asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtfuelsurchargeair" runat="server" CssClass="blackfnt" MaxLength="10"
                                                                        Width="80px" onblur="javascript:this.value=roundNumber(this.value,2)" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                        Style="border-style: groove; text-align: right;">
                                                                    </asp:TextBox>
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtfuelsurchargeroad" runat="server" CssClass="blackfnt" MaxLength="10"
                                                                        Width="80px" onblur="javascript:this.value=roundNumber(this.value,2)" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                        Style="border-style: groove; text-align: right;">
                                                                    </asp:TextBox>
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtfuelsurchargetrain" runat="server" CssClass="blackfnt" MaxLength="10"
                                                                        Width="80px" onblur="javascript:this.value=roundNumber(this.value,2)" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                        Style="border-style: groove; text-align: right;">
                                                                    </asp:TextBox>
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtfuelsurchargeexpress" runat="server" CssClass="blackfnt" MaxLength="10"
                                                                        Width="80px" onblur="javascript:this.value=roundNumber(this.value,2)" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                        Style="border-style: groove; text-align: right;">
                                                                    </asp:TextBox>
                                                                </asp:TableCell>
                                                            </asp:TableRow>
                                                            <asp:TableRow BackColor="White">
                                                                <asp:TableCell>
                                                                    Min Charges in RS</asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtminfuelsurchargeair" runat="server" CssClass="blackfnt" MaxLength="10"
                                                                        Width="80px" onblur="javascript:this.value=roundNumber(this.value,2)" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                        Style="border-style: groove; text-align: right;">
                                                                    </asp:TextBox>
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtminfuelsurchargeroad" runat="server" CssClass="blackfnt" MaxLength="10"
                                                                        Width="80px" onblur="javascript:this.value=roundNumber(this.value,2)" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                        Style="border-style: groove; text-align: right;">
                                                                    </asp:TextBox>
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtminfuelsurchargetrain" runat="server" CssClass="blackfnt" MaxLength="10"
                                                                        Width="80px" onblur="javascript:this.value=roundNumber(this.value,2)" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                        Style="border-style: groove; text-align: right;">
                                                                    </asp:TextBox>
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtminfuelsurchargeexpress" runat="server" CssClass="blackfnt" MaxLength="10"
                                                                        Width="80px" onblur="javascript:this.value=roundNumber(this.value,2)" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                        Style="border-style: groove; text-align: right;">
                                                                    </asp:TextBox>
                                                                </asp:TableCell>
                                                            </asp:TableRow>
                                                            <asp:TableRow BackColor="White">
                                                                <asp:TableCell>
                                                                    Max Charge in RS</asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtmaxfuelsurchargeair" runat="server" CssClass="blackfnt" MaxLength="10"
                                                                        Width="80px" onblur="javascript:this.value=roundNumber(this.value,2)" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                        Style="border-style: groove; text-align: right;"></asp:TextBox>
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtmaxfuelsurchargeroad" runat="server" CssClass="blackfnt" MaxLength="10"
                                                                        Width="80px" onblur="javascript:this.value=roundNumber(this.value,2)" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                        Style="border-style: groove; text-align: right;"></asp:TextBox>
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtmaxfuelsurchargetrain" runat="server" CssClass="blackfnt" MaxLength="10"
                                                                        Width="80px" onblur="javascript:this.value=roundNumber(this.value,2)" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                        Style="border-style: groove; text-align: right;"></asp:TextBox>
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtmaxfuelsurchargeexpress" runat="server" CssClass="blackfnt" MaxLength="10"
                                                                        Width="80px" onblur="javascript:this.value=roundNumber(this.value,2)" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                        Style="border-style: groove; text-align: right;"></asp:TextBox>
                                                                </asp:TableCell>
                                                            </asp:TableRow>
                                                        </asp:Table>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow BackColor="White" runat="server" ID="troctroisurcharge">
                                                    <asp:TableCell ColumnSpan="6">
                                                        <asp:Table runat="server" Style="width: 100%;" CssClass="boxbg" CellSpacing="1">
                                                            <asp:TableRow BackColor="White">
                                                                <asp:TableCell>Octroi Sur Charge Based On</asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:DropDownList ID="cmboctroisurchargebas" BackColor="White" runat="server" CssClass="blackfnt">
                                                                        <asp:ListItem Value="0">Select</asp:ListItem>
                                                                        <asp:ListItem Value="O">PerCent on Octroi Value</asp:ListItem>
                                                                        <asp:ListItem Value="I">PerCent on Invoice Value</asp:ListItem>
                                                                        <asp:ListItem Value="F">Flat in RS</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </asp:TableCell>
                                                                <asp:TableCell>Octroi SurCharge</asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtoctroisurchargerate" runat="server" CssClass="blackfnt" MaxLength="10"
                                                                        Width="80px" onblur="javascript:this.value=roundNumber(this.value,2)" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                        Style="border-style: groove; text-align: right;"></asp:TextBox>
                                                                </asp:TableCell>
                                                            </asp:TableRow>
                                                            <asp:TableRow BackColor="White">
                                                                <asp:TableCell>
                                                                    Minimum Octroi Charge in RS
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtminoctroisurcharge" runat="server" CssClass="blackfnt" MaxLength="10"
                                                                        Width="80px" onblur="javascript:this.value=roundNumber(this.value,2)" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                        Style="border-style: groove; text-align: right;"></asp:TextBox>
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    Maximum Octroi Charge in RS
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:TextBox ID="txtmaxoctroisurcharge" runat="server" CssClass="blackfnt" MaxLength="10"
                                                                        Width="80px" onblur="javascript:this.value=roundNumber(this.value,2)" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                        Style="border-style: groove; text-align: right;"></asp:TextBox>
                                                                </asp:TableCell>
                                                            </asp:TableRow>
                                                        </asp:Table>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="trTSVolumetricChecked" Style="display: none;" runat="server">
                                                    <asp:TableCell ColumnSpan="6" Style="background-color: White">
                                                        <asp:Table Width="100%" runat="server" CssClass="boxbg" CellSpacing="1">
                                                            <asp:TableRow Style="background-color: White">
                                                                <asp:TableCell>
                                                                        &nbsp;Volumetric Measure:
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <asp:DropDownList ID="ddlVolMeasure" BackColor="White" runat="server" CssClass="blackfnt">
                                                                        <asp:ListItem Selected="True" Text="Select" Value="0"></asp:ListItem>
                                                                        <asp:ListItem Selected="False" Text="Cm" Value="CM"></asp:ListItem>
                                                                        <asp:ListItem Selected="False" Text="Inches" Value="INCHES"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </asp:TableCell>
                                                                <asp:TableCell ColumnSpan="2">
                                                                        &nbsp;Volumetric conversion 1 CFT=Kg.:
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <input id="txtCFTToKg" type="text" size="10" cssclass="blackfnt" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                                        style="margin-left: 5px; border-style: groove; text-align: right" runat="server" />
                                                                </asp:TableCell>
                                                            </asp:TableRow>
                                                        </asp:Table>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="trTSDACCChecked" runat="server" Style="background-color: White;
                                                    display: none;">
                                                    <asp:TableCell ColumnSpan="6">
                                                        <asp:Table Width="100%" runat="server" CssClass="boxbg" CellSpacing="0" BackColor="#999999">
                                                            <asp:TableRow Style="background-color: White">
                                                                <asp:TableCell>
                                                                        &nbsp;DACC Charges:
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                        &nbsp;Minimum in Rs.:
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <input id="txtDACCChargeRs" type="text" size="10" class="blackfnt" maxlength="8"
                                                                        onblur="return Nagative_Chk_wDecimal(this)" style="margin-left: 5px;" runat="server" />
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                        &nbsp;% of Freight:
                                                                </asp:TableCell>
                                                                <asp:TableCell>
                                                                    <input id="txtDACCChargePer" type="text" size="10" class="blackfnt" maxlength="8"
                                                                        onblur="return Nagative_Chk_wDecimal(this)" style="margin-left: 5px;" runat="server" />
                                                                </asp:TableCell>
                                                            </asp:TableRow>
                                                        </asp:Table>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <%--Table row for Demurrage after days--%>
                                                <asp:TableRow Style="background-color: White">
                                                    <asp:TableCell>
                                                        
                                                            &nbsp;Demurrage after days:
                                                       
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <input id="txtDemAfterDays" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                            style="margin-left: 5px;" runat="server" />
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="4">
                                                        &nbsp;
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <%--Table row for Applicabl_yn_dem="Y"--%>
                                                <asp:TableRow ID="trDemurrageCharges" Style="background-color: White" runat="Server">
                                                    <asp:TableCell>
                                                            &nbsp;Demurrage Charges:
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                            &nbsp;Minimum in Rs.:
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <input id="txtDemChargeRs" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                            style="margin-left: 5px;" runat="server" />
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                            &nbsp;Per Kg.:
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="2">
                                                        <input id="txtDemChargePerKg" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                            style="margin-left: 5px;" runat="server" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <%--Table row for Bill Generation Location--%>
                                                <asp:TableRow Style="background-color: White" ID="trbillgen" runat="server">
                                                    <asp:TableCell>
                                                            &nbsp;Bill Generation at Location:
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:TextBox ID="txtBillGen" runat="server" onblur="javascript:return locCodeBlur(this.getAttribute('id'),'Bill Submission')"
                                                            CssClass="blackfnt" MaxLength="50" Width="40px" Style="margin-left: 5px; border-style: groove;">
                                                        </asp:TextBox>
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="3">
                                                            &nbsp;Billing Instance:
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:DropDownList ID="ddlBillingInstance" BackColor="White" runat="server" CssClass="blackfnt">
                                                            <asp:ListItem Selected="True" Text="Select" Value="0"></asp:ListItem>
                                                            <asp:ListItem Selected="False" Text="On Booking" Value="BKG"></asp:ListItem>
                                                            <asp:ListItem Selected="False" Text="POD" Value="POD"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <%--Table row for Bill Submission Location--%>
                                                <asp:TableRow Style="background-color: White">
                                                    <asp:TableCell>
                                                        <asp:Label ID="lblbillsubname" runat="server" CssClass="blackfnt">Bill Submission at Location:</asp:Label>
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:TextBox ID="txtBillSubLocation" runat="server" onblur="javascript:return locCodeBlur(this.getAttribute('id'),'Bill Submission')"
                                                            CssClass="blackfnt" MaxLength="50" Width="40px" Style="margin-left: 5px; border-style: groove;">
                                                        </asp:TextBox>
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="3">
                                                            &nbsp;Total credit limit Rs.:
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <input id="txtCreditLimit" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                            style="margin-left: 5px;" runat="server" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <%--Table row for Bill Collection Location--%>
                                                <asp:TableRow Style="background-color: White">
                                                    <asp:TableCell>
                                                        <asp:Label ID="lblbillcolname" runat="server" CssClass="blackfnt">Bill Collection at Location:</asp:Label>
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:TextBox ID="txtBillCollLocation" runat="server" onblur="javascript:return locCodeBlur(this.getAttribute('id'),'Bill Collection')"
                                                            CssClass="blackfnt" MaxLength="50" Width="40px" Style="margin-left: 5px; border-style: groove;">
                                                        </asp:TextBox>
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="3">
                                                            &nbsp;Credit days from generation:
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <input id="txtCreditDays" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                            style="margin-left: 5px;" runat="server" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <%--Table row for SKU Wise Y/N--%>
                                                <asp:TableRow Style="background-color: White">
                                                    <asp:TableCell>
                                                            &nbsp;SKU Wise Y/N:
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <input type="checkbox" id="chkSKU" runat="server" style="margin-left: 1px;" />
                                                    </asp:TableCell>
                                                    <asp:TableCell ColumnSpan="3" HorizontalAlign="left" CssClass="blackfnt">
                                                        Service Tax Paid By
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:DropDownList ID="cmbstaxpaidby" CssClass="blackfnt" BackColor="White" runat="server">
                                                            <asp:ListItem Selected="True" Text="Select" Value="0"></asp:ListItem>
                                                            <asp:ListItem Selected="False" Text="Transporter" Value="T"></asp:ListItem>
                                                            <asp:ListItem Selected="False" Text="Party" Value="P"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                            </asp:Table>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell HorizontalAlign="center" Style="width: 100%">
                    <br />
                    <asp:GridView ID="grvcharges" runat="server" BorderWidth="0" CellSpacing="1" CellPadding="2"
                        AllowSorting="true" PagerStyle-HorizontalAlign="left" Width="8in" CssClass="boxbg"
                        BackColor="#8ba0e5" HeaderStyle-CssClass="bgbluegrey" FooterStyle-CssClass="<%=boxbg%>"
                        PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]"
                        PagerSettings-LastPageText="[Last]" HorizontalAlign="Left" OnRowDataBound="grvcharges_RowDataBound"
                        EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange">
                        <Columns>
                            <asp:TemplateField HeaderText="" HeaderStyle-CssClass="blackfnt">
                                <ItemStyle BackColor="White" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblsrno" Text='<%# DataBinder.Eval(Container.DataItem,"codedesc") %>'
                                        runat="server">
                                    </asp:Label>
                                    <asp:HiddenField ID="hdnstatuscode" Value='<%# DataBinder.Eval(Container.DataItem,"statuscode") %>'
                                        runat="server" />
                                    <asp:HiddenField ID="hdncodeid" Value='<%# DataBinder.Eval(Container.DataItem,"codeid") %>'
                                        runat="server" />
                                </ItemTemplate>
                                <FooterStyle BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                                <FooterTemplate>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Air">
                                <ItemStyle BackColor="White" />
                                <ItemTemplate>
                                    <center>
                                        <asp:TextBox ID="txtaircharge" Text='<%# DataBinder.Eval(Container.DataItem,"airrate") %>'
                                            Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                            runat="server" MaxLength="10" CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                                    </center>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Road">
                                <ItemStyle BackColor="White" />
                                <ItemTemplate>
                                    <center>
                                        <asp:TextBox ID="txtroadcharge" Text='<%# DataBinder.Eval(Container.DataItem,"roadrate") %>'
                                            Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                            runat="server" MaxLength="10" CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                                    </center>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Train">
                                <ItemStyle BackColor="White" />
                                <ItemTemplate>
                                    <center>
                                        <asp:TextBox ID="txtraincharge" Text='<%# DataBinder.Eval(Container.DataItem,"trainrate") %>'
                                            Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                            runat="server" MaxLength="10" CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                                    </center>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Express">
                                <ItemStyle BackColor="White" />
                                <ItemTemplate>
                                    <center>
                                        <asp:TextBox ID="txtexpresscharge" Text='<%# DataBinder.Eval(Container.DataItem,"expressrate") %>'
                                            Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                            runat="server" MaxLength="10" CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                                    </center>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell HorizontalAlign="Center">
                    <br />
                    <asp:Table ID="tblbasewiseminfreight" runat="server" Width="40%" CellSpacing="1"
                        CssClass="boxbg">
                        <asp:TableRow CssClass="bgbluegrey">
                            <asp:TableCell>
                                    &nbsp;Mode of Transport
                            </asp:TableCell>
                            <asp:TableCell>
                                    &nbsp;Rate
                            </asp:TableCell>
                            <asp:TableCell>
                                    &nbsp;Basis
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Style="background-color: White">
                            <asp:TableCell>
                                <asp:Label ID="lblairname" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtairrateforfreight" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:DropDownList ID="ddlairbasisforfreight" BackColor="White" runat="server" CssClass="blackfnt">
                                    <asp:ListItem Selected="True" Text="Select" Value="0"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Rs." Value="RS"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Pkg." Value="PKG"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Kg." Value="KG"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Ton." Value="T"></asp:ListItem>
                                </asp:DropDownList>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Style="background-color: White">
                            <asp:TableCell>
                                <asp:Label ID="lblroadname" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtroadrateforfreight" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:DropDownList ID="ddlroadbasisforfreight" BackColor="White" runat="server" CssClass="blackfnt">
                                    <asp:ListItem Selected="True" Text="Select" Value="0"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Rs." Value="RS"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Pkg." Value="PKG"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Kg." Value="KG"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Ton." Value="T"></asp:ListItem>
                                </asp:DropDownList>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Style="background-color: White">
                            <asp:TableCell>
                                <asp:Label ID="lbltrainname" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txttrainrateforfreight" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:DropDownList ID="ddltrainbasisforfreight" BackColor="White" runat="server" CssClass="blackfnt">
                                    <asp:ListItem Selected="True" Text="Select" Value="0"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Rs." Value="RS"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Pkg." Value="PKG"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Kg." Value="KG"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Ton." Value="T"></asp:ListItem>
                                </asp:DropDownList>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Style="background-color: White">
                            <asp:TableCell>
                                <asp:Label ID="lblexpressname" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtexpressrateforfreight" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:DropDownList ID="ddlexpressbasisforfreight" BackColor="White" runat="server"
                                    CssClass="blackfnt">
                                    <asp:ListItem Selected="True" Text="Select" Value="0"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Rs." Value="RS"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Pkg." Value="PKG"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Kg." Value="KG"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Ton." Value="T"></asp:ListItem>
                                </asp:DropDownList>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                    <br />
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow Style="display: none;">
                <asp:TableCell HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true">Minimum Subtotal</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell HorizontalAlign="Center">
                    <asp:Table ID="tblpercentwiseminfreight" runat="server" Width="80%" CellSpacing="1"
                        CssClass="boxbg">
                        <asp:TableRow CssClass="bgbluegrey">
                            <asp:TableCell></asp:TableCell>
                            <asp:TableCell HorizontalAlign="Center" Font-Bold="true" ColumnSpan="3">
                                    Freight Rate
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Center" Font-Bold="true" ColumnSpan="3">
                                    SubTotal
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell></asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left" Font-Bold="true" ColumnSpan="3">
                                    <asp:CheckBox ID="chkapplyfreight" runat="server" Text="Freight Rate Limits Applicable" CssClass="blackfnt" />
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left" Font-Bold="true" ColumnSpan="3">
                                    <asp:CheckBox ID="chkapplysubtotal" runat="server" Text="Sub Total Limits Applicable" CssClass="blackfnt" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgbluegrey">
                            <asp:TableCell>
                                    &nbsp;Mode of Transport
                            </asp:TableCell>
                            <asp:TableCell>
                                    &nbsp;Minimum<br /> (in RS)
                            </asp:TableCell>
                            <asp:TableCell>
                                &nbsp;Lower<br /> Limit(in %)
                            </asp:TableCell>
                            <asp:TableCell>
                                &nbsp;Upper<br /> Limit(in %)
                            </asp:TableCell>
                            <asp:TableCell>
                                    &nbsp;Minimum<br /> (in RS)
                            </asp:TableCell>
                            <asp:TableCell>
                                &nbsp;Lower<br /> Limit(in %)
                            </asp:TableCell>
                            <asp:TableCell>
                                &nbsp;Upper<br /> Limit(in %)
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Style="background-color: White">
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:Label ID="lblmodenameair" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminfreightrateair" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminfreightratelowerlimair" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminfreightrateupperlimair" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminsubtotalair" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtsubtotallowerlimair" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtsubtotalupperlimair" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Style="background-color: White">
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:Label ID="lblmodenameroad" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminfreightrateroad" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminfreightratelowerlimroad" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminfreightrateupperlimroad" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminsubtotalroad" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtsubtotallowerlimroad" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtsubtotalupperlimroad" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Style="background-color: White">
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:Label ID="lblmodenametrain" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminfreightratetrain" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminfreightratelowerlimtrain" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminfreightrateupperlimtrain" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminsubtotaltrain" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtsubtotallowerlimtrain" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtsubtotalupperlimtrain" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Style="background-color: White">
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:Label ID="lblmodenameexpress" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminfreightrateexpress" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminfreightratelowerlimexpress" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminfreightrateupperlimexpress" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtminsubtotalexpress" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtsubtotallowerlimexpress" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:TextBox ID="txtsubtotalupperlimexpress" Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    runat="server" MaxLength="10" onblur="javascript:this.value=roundNumber(this.value,2)"
                                    CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell HorizontalAlign="center">
                    <br />
                    <asp:Table runat="server" CellSpacing="1" CssClass="boxbg" Style="width: 8in">
                        <asp:TableRow CssClass="bgbluegrey">
                            <asp:TableCell HorizontalAlign="center">
                                <asp:Button ID="btnSubmit" CssClass="blackfnt" Text="Submit" runat="server" ToolTip="Click here to submit and proceed"
                                    OnClientClick="javascript:return ValidateData()" OnClick="btnSubmit_Click" />
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </asp:Panel>
    <%--                HIDDEN AREA             --%>
    <input type="hidden" id="HidCODDODApp" runat="server" />
    <input type="hidden" id="HidDACCApp" runat="server" />
    <input type="hidden" id="HidFTL" runat="server" />
    <input type="hidden" id="HidSUNDRY" runat="server" />
    <input type="hidden" id="HidMOTAir" runat="server" />
    <input type="hidden" id="HidMOTRoad" runat="server" />
    <input type="hidden" id="HidMOTTrain" runat="server" />
    <input type="hidden" id="HidMOTExpress" runat="server" />
    <input type="hidden" id="hdnclient" runat="server" />
</asp:Content>
