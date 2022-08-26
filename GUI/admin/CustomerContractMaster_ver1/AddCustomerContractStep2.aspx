<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="AddCustomerContractStep2.aspx.cs" Inherits="AddCustomerContractStep2"
    EnableEventValidation="false" %>

<%@ OutputCache Location="none" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript">
            
            // JScript File

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
        if (bag.indexOf(c) == -1) returnString += c;
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
	
	if (pos1==-1 || pos2==-1)
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
	
	if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false)
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
    while (strValue.substring(strValue.length-1, strValue.length) == ' ')
    {
        strValue = strValue.substring(0, strValue.length-1);
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
      
      if (ValidChars.indexOf(Char) == -1) 
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
				if (Num.toString().lastIndexOf('.')+1==Num.toString().length-1)
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
				if (Num.toString().lastIndexOf('.')+1==Num.toString().length-1)
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
//                if(document.getElementById("ctl00_MyCPH1_trTSCODChecked"))
//                {
                    var mCODDODApplicableYN = "<%=blnAppForCODDOD %>"
                    
                    if (mCODDODApplicableYN == "True")
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
//                }
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
                        if(document.getElementById("ctl00_MyCPH1_ddlFOVType").value == "-1")
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
                            if(document.getElementById("ctl00_MyCPH1_ddlVolMeasure").value == "-1")
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
                
                //Check for Bill Generation at Location
                if(document.getElementById("ctl00_MyCPH1_txtBillGen"))
                {
                    document.getElementById("ctl00_MyCPH1_txtBillGen").value = trimAll(document.getElementById("ctl00_MyCPH1_txtBillGen").value);
                    
                    if(document.getElementById("ctl00_MyCPH1_txtBillGen").value == "")
                    {
                        alert("Please enter 'Bill Generation at Location'");
                        document.getElementById("ctl00_MyCPH1_txtBillGen").focus();
                        return false;
                    }
                    else if(document.getElementById("ctl00_MyCPH1_lblErrorBillGenLocation"))
                    {
                        if(document.getElementById("ctl00_MyCPH1_lblErrorBillGenLocation").style.display == '')
                        {
                            alert("Please enter valid 'Bill Generation at Location'");
                            document.getElementById("ctl00_MyCPH1_txtBillGen").focus();
                            return false;
                        }   
                    }
                }
                
                //Check for Billing Instance
                if(document.getElementById("ctl00_MyCPH1_ddlBillingInstance"))
                {
                    if(document.getElementById("ctl00_MyCPH1_ddlBillingInstance").value == "-1")
                    {
                        alert("Please select 'Billing Instance' from the list");
                        document.getElementById("ctl00_MyCPH1_ddlBillingInstance").focus();
                        return false;
                    }
                }
                
                //Check for Bill Submission at Location
                if(document.getElementById("ctl00_MyCPH1_txtBillSubLocation"))
                {
                    document.getElementById("ctl00_MyCPH1_txtBillSubLocation").value = trimAll(document.getElementById("ctl00_MyCPH1_txtBillSubLocation").value);
                    
                    if(document.getElementById("ctl00_MyCPH1_txtBillSubLocation").value == "")
                    {
                        alert("Please enter 'Bill Submission at Location'");
                        document.getElementById("ctl00_MyCPH1_txtBillSubLocation").focus();
                        return false;
                    }
                    else if(document.getElementById("ctl00_MyCPH1_lblErrorBillSubLocation"))
                    {
                        if(document.getElementById("ctl00_MyCPH1_lblErrorBillSubLocation").style.display == '')
                        {
                            alert("Please enter valid 'Bill Submission at Location'");
                            document.getElementById("ctl00_MyCPH1_txtBillSubLocation").focus();
                            return false;
                        }   
                    }
                }
                
                //Check for Bill Collection at Location
                if(document.getElementById("ctl00_MyCPH1_txtBillCollLocation"))
                {
                    document.getElementById("ctl00_MyCPH1_txtBillCollLocation").value = trimAll(document.getElementById("ctl00_MyCPH1_txtBillCollLocation").value);
                    
                    if(document.getElementById("ctl00_MyCPH1_txtBillCollLocation").value == "")
                    {
                        alert("Please enter 'Bill Collection at Location'");
                        document.getElementById("ctl00_MyCPH1_txtBillCollLocation").focus();
                        return false;
                    }
                    else if(document.getElementById("ctl00_MyCPH1_lblErrorBillCollLocation"))
                    {
                        if(document.getElementById("ctl00_MyCPH1_lblErrorBillCollLocation").style.display == '')
                        {
                            alert("Please enter valid 'Bill Collection at Location'");
                            document.getElementById("ctl00_MyCPH1_txtBillCollLocation").focus();
                            return false;
                        }
                    }
                }
                
                //Check for Service Tax Applicable & Paid By
                if(document.getElementById("ctl00_MyCPH1_ddlSTPaidBy"))
                {
                    if(document.getElementById("ctl00_MyCPH1_ddlSTPaidBy").value == "-1")
                    {
                        alert("Please select 'Service Tax Paid by' from the list");
                        document.getElementById("ctl00_MyCPH1_ddlSTPaidBy").focus();
                        return false;
                    }                    
                }
                                
                //Check for Minimum Freight entries
                
                //Rate and Basis must be entered/selected for Air row
                //If 'Air' Mode of Transport is checked
                if(document.getElementById("ctl00_MyCPH1_chkMTAir"))
                {
                    if(document.getElementById("ctl00_MyCPH1_chkMTAir").checked == true)
                    {
                        //Check for Rate entry
                        if(document.getElementById("ctl00_MyCPH1_txtAirRateForFreight"))
                        {
                            document.getElementById("ctl00_MyCPH1_txtAirRateForFreight").value = trimAll(document.getElementById("ctl00_MyCPH1_txtAirRateForFreight").value);
                            
                            if(document.getElementById("ctl00_MyCPH1_txtAirRateForFreight").value == "")
                            {
                                alert("Please enter 'Freight Rate' for 'Air' Mode of Transport");
                                document.getElementById("ctl00_MyCPH1_txtAirRateForFreight").focus();
                                return false;
                            }
                        }
                        
                        //Check for Basis selection
                        if(document.getElementById("ctl00_MyCPH1_ddlAirBasisForFreight"))
                        {
                            if(document.getElementById("ctl00_MyCPH1_ddlAirBasisForFreight").value == "-1")
                            {
                                alert("Please select 'Basis' for 'Air' Mode of Transport, from the list");
                                document.getElementById("ctl00_MyCPH1_ddlAirBasisForFreight").focus();
                                return false;
                            }
                        }           
                    }
                }
                
                //Rate and Basis must be entered/selected for Road row
                //If 'Road' Mode of Transport is checked
                if(document.getElementById("ctl00_MyCPH1_chkMTRoad"))
                {
                    if(document.getElementById("ctl00_MyCPH1_chkMTRoad").checked == true)
                    {
                        //Check for Rate entry
                        if(document.getElementById("ctl00_MyCPH1_txtRoadRateForFreight"))
                        {
                            document.getElementById("ctl00_MyCPH1_txtRoadRateForFreight").value = trimAll(document.getElementById("ctl00_MyCPH1_txtRoadRateForFreight").value);
                            
                            if(document.getElementById("ctl00_MyCPH1_txtRoadRateForFreight").value == "")
                            {
                                alert("Please enter 'Freight Rate' for 'Road' Mode of Transport");
                                document.getElementById("ctl00_MyCPH1_txtRoadRateForFreight").focus();
                                return false;
                            }
                        }
                        
                        //Check for Basis selection
                        if(document.getElementById("ctl00_MyCPH1_ddlRoadBasisForFreight"))
                        {
                            if(document.getElementById("ctl00_MyCPH1_ddlRoadBasisForFreight").value == "-1")
                            {
                                alert("Please select 'Basis' for 'Road' Mode of Transport, from the list");
                                document.getElementById("ctl00_MyCPH1_ddlRoadBasisForFreight").focus();
                                return false;
                            }
                        }           
                    }
                }
                
                //Rate and Basis must be entered/selected for Train row
                //If 'Train' Mode of Transport is checked
                if(document.getElementById("ctl00_MyCPH1_chkMTTrain"))
                {
                    if(document.getElementById("ctl00_MyCPH1_chkMTTrain").checked == true)
                    {
                        //Check for Rate entry
                        if(document.getElementById("ctl00_MyCPH1_txtTrainRateForFreight"))
                        {
                            document.getElementById("ctl00_MyCPH1_txtTrainRateForFreight").value = trimAll(document.getElementById("ctl00_MyCPH1_txtTrainRateForFreight").value);
                            
                            if(document.getElementById("ctl00_MyCPH1_txtTrainRateForFreight").value == "")
                            {
                                alert("Please enter 'Freight Rate' for 'Train' Mode of Transport");
                                document.getElementById("ctl00_MyCPH1_txtTrainRateForFreight").focus();
                                return false;
                            }
                        }
                        
                        //Check for Basis selection
                        if(document.getElementById("ctl00_MyCPH1_ddlTrainBasisForFreight"))
                        {
                            if(document.getElementById("ctl00_MyCPH1_ddlTrainBasisForFreight").value == "-1")
                            {
                                alert("Please select 'Basis' for 'Train' Mode of Transport, from the list");
                                document.getElementById("ctl00_MyCPH1_ddlTrainBasisForFreight").focus();
                                return false;
                            }
                        }           
                    }
                }
                
                //Rate and Basis must be entered/selected for Express row
                //If 'Express' Mode of Transport is checked
                if(document.getElementById("ctl00_MyCPH1_chkMTExpress"))
                {
                    if(document.getElementById("ctl00_MyCPH1_chkMTExpress").checked == true)
                    {
                        //Check for Rate entry
                        if(document.getElementById("ctl00_MyCPH1_txtExpressRateForFreight"))
                        {
                            document.getElementById("ctl00_MyCPH1_txtExpressRateForFreight").value = trimAll(document.getElementById("ctl00_MyCPH1_txtExpressRateForFreight").value);
                            
                            if(document.getElementById("ctl00_MyCPH1_txtExpressRateForFreight").value == "")
                            {
                                alert("Please enter 'Freight Rate' for 'Express' Mode of Transport");
                                document.getElementById("ctl00_MyCPH1_txtExpressRateForFreight").focus();
                                return false;
                            }
                        }
                        
                        //Check for Basis selection
                        if(document.getElementById("ctl00_MyCPH1_ddlExpressBasisForFreight"))
                        {
                            if(document.getElementById("ctl00_MyCPH1_ddlExpressBasisForFreight").value == "-1")
                            {
                                alert("Please select 'Basis' for 'Express' Mode of Transport, from the list");
                                document.getElementById("ctl00_MyCPH1_ddlExpressBasisForFreight").focus();
                                return false;
                            }
                        }  
                    } // if express is true
                } // if express control is present
                
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

    <div>
        <font class="blackfnt">Customer Contract Master >> </font>
        <font class="blackfnt">Add Contract Step - 2</font><br />
        <font class="blackfnt">Customer >> </font><asp:Label ID="lblcustcodename" runat="server" CssClass="bluefnt" Font-Bold="true"></asp:Label>
        <hr align="center" size="1" style="color: #8ba0e5" />
        <table style="width: 9in;" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td valign="top" style="width: 100%">
                    <table border="0" cellpadding="2" cellspacing="1" style="width: 100%" align="center"
                        class="boxbg">
                        <tr class="bgbluegrey">
                            <td colspan="6" align="left" class="blackfnt">
                                <b>&nbsp;Step 2: Summary of Charges</b>
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color: White">
                                <label class="blackfnt">
                                    &nbsp;Mode of Transport:
                                </label>
                            </td>
                            <td style="background-color: White">
                                <input type="checkbox" id="chkMTAir" runat="server" style="margin-left: 1px;" />
                                <label class="blackfnt" id="lblMTAir" runat="server">
                                    <%=strModeOfTransportAir%>
                                </label>
                            </td>
                            <td style="background-color: White">
                                <input type="checkbox" id="chkMTRoad" runat="server" style="margin-left: 1px;" />
                                <label class="blackfnt" id="lblMTRoad" runat="server">
                                    <%=strModeOfTransportRoad%>
                                </label>
                            </td>
                            <td style="background-color: White">
                                <input type="checkbox" id="chkMTTrain" runat="server" style="margin-left: 1px;" />
                                <label class="blackfnt" id="lblMTTrain" runat="server">
                                    <%=strModeOfTransportTrain%>
                                </label>
                            </td>
                            <td style="background-color: White" colspan="2">
                                <input type="checkbox" id="chkMTExpress" runat="server" style="margin-left: 1px;" />
                                <label class="blackfnt" id="lblMTExpress" runat="server">
                                    <%=strModeOfTransportExpress%>
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color: White">
                                <label class="blackfnt">
                                    &nbsp;Type of Load:
                                </label>
                            </td>
                            <td style="background-color: White">
                                <input type="checkbox" id="chkTLFTL" runat="server" style="margin-left: 1px;" />
                                <label class="blackfnt" id="lblTLFTL" runat="server">
                                    <%=strTypeOfLoadServiceNo2 %>
                                </label>
                            </td>
                            <td style="background-color: White" colspan="4">
                                <input type="checkbox" id="chkTLSundry" runat="server" style="margin-left: 1px;" />
                                <label class="blackfnt" id="lblTLSundry" runat="server">
                                    <%=strTypeOfLoadServiceNo1 %>
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color: White">
                                <label class="blackfnt">
                                    &nbsp;Pickup-Delivery:
                                </label>
                            </td>
                            <td style="background-color: White">
                                <input type="checkbox" id="chkGD" runat="server" style="margin-left: 1px;" />
                                <label class="blackfnt" runat="server">
                                    Godown-Door
                                </label>
                            </td>
                            <td style="background-color: White">
                                <input type="checkbox" id="chkGG" runat="server" style="margin-left: 1px;" />
                                <label class="blackfnt" runat="server">
                                    Godown-Godown
                                </label>
                            </td>
                            <td style="background-color: White">
                                <input type="checkbox" id="chkDD" runat="server" style="margin-left: 1px;" />
                                <label class="blackfnt" runat="server">
                                    Door-Door
                                </label>
                            </td>
                            <td style="background-color: White" colspan="2">
                                <input type="checkbox" id="chkDG" runat="server" style="margin-left: 1px;" />
                                <label class="blackfnt" runat="server">
                                    Door-Godown
                                </label>
                            </td>
                        </tr>
                        <%--Table row for Applicabl_yn_dp_chrg="Y"--%>
                        <%--For Door Pickup Charge--%>
                        <tr id="trDoorPickupCharge" runat="server" visible="false" style="background-color: White">
                            <td>
                                <label class="blackfnt">
                                    &nbsp;Door Pickup Charges:
                                </label>
                            </td>
                            <td>
                                <label class="blackfnt">
                                    &nbsp;Minimum in Rs.:
                                </label>
                            </td>
                            <td>
                                <input id="txtDoorPickupCharge" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td>
                                <label class="blackfnt">
                                    &nbsp;Rate/Kg.:
                                </label>
                            </td>
                            <td colspan="2">
                                <input id="txtDoorPickupChargePerKg" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                        </tr>
                       
                        <tr id="trDoorDeliveryCharge" runat="server" visible="false" style="background-color: White">
                            <td>
                                <label class="blackfnt">
                                    &nbsp;Door Delivery Charges:
                                </label>
                            </td>
                            <td>
                                <label class="blackfnt">
                                    &nbsp;Minimum in Rs.:
                                </label>
                            </td>
                            <td>
                                <input id="txtDoorDeliveryCharge" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td>
                                <label class="blackfnt">
                                    &nbsp;Rate/Kg.:
                                </label>
                            </td>
                            <td colspan="2">
                                <input id="txtDoorDeliveryChargePerKg" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                        </tr>
                       
                        <tr style="background-color: white;width:100%" id="trFOVCharge" runat="server" visible="false">
                            <td>
                                <label class="blackfnt">
                                    &nbsp;FOV Type:
                                </label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlFOVType" onchange="javascript:return cmbFOVChange()" runat="server" CssClass="blackfnt">
                                    <asp:ListItem Selected="True" Text="Select" Value="-1"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="RS." Value="RS"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="% of Invoice" Value="%"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td id="tdfovcharge" colspan="4" runat="server" class="blackfnt">
                                        <table width="100%" cellspacing="1" class="boxbg">
                                            <tr bgcolor="#ffffff">
                                                <td>FOV Rate:</td>
                                                <td colspan="3">
                                                    <input id="txtFOVCharge" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                        style="margin-left: 5px;" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                             </td>
                             <td id="tdfovpercentage" colspan="4" style="display: none;" class="blackfnt" runat="server">
                                        <table width="100%" cellspacing="1" class="boxbg">
                                            <tr bgcolor="#ffffff">
                                                <td>
                                                    FOV Owner Risk(%)</td>
                                                <td>
                                                    <input id="txtownerrisk" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                        style="margin-left: 5px;" runat="server" />
                                                </td>
                                                <td>
                                                    FOV Carrier Risk(%)</td>
                                                <td>
                                                    <input id="txtcarrierrisk" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                        style="margin-left: 5px;" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                              </td>
                        </tr>
                     
                        <tr style="background-color: White">
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <label class="blackfnt">
                                    &nbsp;Insurance Percentage:
                                </label>
                            </td>
                            <td colspan="4">
                                <input id="txtInsPer" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                        </tr>
                       
                        <tr>
                            <td style="background-color: White">
                                <label class="blackfnt">
                                    &nbsp;Type of Service:
                                </label>
                            </td>
                            <td style="background-color: White">
                                <input type="checkbox" id="chkTSCODDOD" runat="server" onclick="CODDODChecked(this)"
                                    class="blackfnt" />
                                <label class="blackfnt">
                                    COD/DOD
                                </label>
                            </td>
                            <td style="background-color: White">
                                <input type="checkbox" id="chkTSODA" runat="server" style="margin-left: 1px;" />
                                <label class="blackfnt">
                                    ODA
                                </label>
                            </td>
                            <td style="background-color: White">
                                <input type="checkbox" id="chkTSVolumetric" runat="server" onclick="javascript:return chkVolumetricChange();" 
                                    class="blackfnt" />
                                <label class="blackfnt">
                                    Volumetric
                                </label>
                            </td>
                            <td style="background-color: White" colspan="2" valign="top">
                                <input type="checkbox" id="chkTSDACC" runat="server" onclick="javascript:return chkDACCChange();"
                                    class="blackfnt" />
                                <label class="blackfnt">
                                    DACC
                                </label>
                            </td>
                        </tr>
                       
                        <tr id="trTSCODChecked" runat="server" style="background-color: White; display: none">
                            <td colspan="6">
                                <table width="100%" border="0" class="boxbg" cellspacing="1" cellpadding="3">
                                    <tr style="background-color: White">
                                        <td>
                                            <label class="blackfnt">
                                                &nbsp;COD/DOD Charges:
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                &nbsp;Minimum in Rs.:
                                            </label>
                                        </td>
                                        <td>
                                            <input id="txtCODCharge" type="text" size="10" class="input" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                style="margin-left: 5px;" runat="server" />
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                &nbsp;% of Amount:
                                            </label>
                                        </td>
                                        <td>
                                            <input id="txtCODChargePer" type="text" size="10" class="input" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                style="margin-left: 5px;" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        
                        <tr id="trTSVolumetricChecked" runat="server" style="display: none">
                            <td colspan="6" style="background-color: White">
                                <table width="100%" border="0" class="boxbg" cellspacing="1" cellpadding="3">
                                    <tr style="background-color: White">
                                        <td>
                                            <label class="blackfnt">
                                                &nbsp;Volumetric Measure:
                                            </label>
                                        </td>
                                        <td>
                                            <label style="margin-left: 5px;">
                                            </label>
                                            <asp:DropDownList ID="ddlVolMeasure" runat="server" CssClass="blackfnt">
                                                <asp:ListItem Selected="True" Text="Select" Value="-1"></asp:ListItem>
                                                <asp:ListItem Selected="False" Text="Cm" Value="CM"></asp:ListItem>
                                                <asp:ListItem Selected="False" Text="Inches" Value="INCHES"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td colspan="2">
                                            <label class="blackfnt">
                                                &nbsp;Volumetric conversion 1 CFT=Kg.:
                                            </label>
                                        </td>
                                        <td>
                                            <input id="txtCFTToKg" type="text" size="10" class="input" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                style="margin-left: 5px;" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        
                        <tr id="trTSDACCChecked" runat="server" style="background-color: White; display: none">
                            <td colspan="6">
                                <table width="100%" class="boxbg" cellspacing="1" bgcolor="#8ba0e5">
                                    <tr style="background-color: White">
                                        <td>
                                            <label class="blackfnt">
                                                &nbsp;DACC Charges:
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                &nbsp;Minimum in Rs.:
                                            </label>
                                        </td>
                                        <td>
                                            <input id="txtDACCChargeRs" type="text" size="10" class="input" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                style="margin-left: 5px;" runat="server" />
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                &nbsp;% of Freight:
                                            </label>
                                        </td>
                                        <td>
                                            <input id="txtDACCChargePer" type="text" size="10" class="input" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                                style="margin-left: 5px;" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                       
                        <tr style="background-color: White">
                            <td>
                                <label class="blackfnt">
                                    &nbsp;Demurrage after days:
                                </label>
                            </td>
                            <td>
                                <input id="txtDemAfterDays" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td colspan="4">
                                &nbsp;
                            </td>
                        </tr>
                        
                        <tr id="trDemurrageCharges" style="background-color: White" runat="Server" visible="false">
                            <td>
                                <label class="blackfnt">
                                    &nbsp;Demurrage Charges:
                                </label>
                            </td>
                            <td>
                                <label class="blackfnt">
                                    &nbsp;Minimum in Rs.:
                                </label>
                            </td>
                            <td>
                                <input id="txtDemChargeRs" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                            <td>
                                <label class="blackfnt">
                                    &nbsp;Per Kg.:
                                </label>
                            </td>
                            <td>
                                <input id="txtDemChargePerKg" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                        </tr>
                        
                        <tr style="background-color: White">
                            <td>
                                <label class="blackfnt">
                                    &nbsp;Bill Generation at Location:
                                </label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtBillGen" runat="server" onblur="javascript:return locCodeBlur(this.getAttribute('id'),'Bill Generation')" CssClass="input" MaxLength="50" Width="40px"
                                    Style="margin-left: 5px;">
                                </asp:TextBox>
                            </td>
                            <td colspan="3">
                                <label class="blackfnt">
                                    &nbsp;Billing Instance:
                                </label>
                            </td>
                            <td>
                                <label style="margin-left: 5px;">
                                </label>
                                <asp:DropDownList ID="ddlBillingInstance" runat="server" CssClass="blackfnt">
                                    <asp:ListItem Selected="True" Text="Select" Value="-1"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="On Booking" Value="BKG"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="POD" Value="POD"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        
                        <tr style="background-color: White">
                            <td>
                                <label class="blackfnt">
                                    &nbsp;Bill Submission at Location:
                                </label>
                            </td>
                            <td>
                                    <asp:TextBox ID="txtBillSubLocation" onblur="javascript:return locCodeBlur(this.getAttribute('id'),'Bill Submission')" runat="server" CssClass="input" MaxLength="50"
                                        Width="40px"  Style="margin-left: 5px;">
                                    </asp:TextBox>
                            </td>
                            <td colspan="3">
                                <label class="blackfnt">
                                    &nbsp;Total credit limit Rs.:
                                </label>
                            </td>
                            <td>
                                <input id="txtCreditLimit" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                        </tr>
                        
                        <tr style="background-color: White">
                            <td>
                                <label class="blackfnt">
                                    &nbsp;Bill Collection at Location:
                                </label>
                            </td>
                            <td>
                                    <asp:TextBox ID="txtBillCollLocation" runat="server" onblur="javascript:return locCodeBlur(this.getAttribute('id'),'Bill Collection')" CssClass="input" MaxLength="50"
                                        Width="40px" Style="margin-left: 5px;">
                                    </asp:TextBox>
                            </td>
                            <td colspan="3">
                                <label class="blackfnt">
                                    &nbsp;Credit days from generation:
                                </label>
                            </td>
                            <td>
                                <input id="txtCreditDays" type="text" size="10" maxlength="8" onblur="return Nagative_Chk_wDecimal(this)"
                                    style="margin-left: 5px;" runat="server" />
                            </td>
                        </tr>
                        
                        <tr style="background-color: White">
                            <td>
                                <label class="blackfnt">
                                    &nbsp;SKU Wise Y/N:
                                </label>
                            </td>
                            <td>
                                <input type="checkbox" id="chkSKU" runat="server" style="margin-left: 1px;" />
                            </td>
                            <td colspan="3" align="left" class="blackfnt">
                                    Service Tax Paid By
                            </td>
                            <td>
                                <asp:DropDownList ID="cmbstaxpaidby" runat="server">
                                    <asp:ListItem Selected="True" Text="Select" Value="0"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Transporter" Value="T"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Party" Value="P"></asp:ListItem>                                
                                </asp:DropDownList>
                            </td>
                        </tr>
                        
                        <tr id="trcombus" runat="server" style="background-color: White;display:none;">
                            <td class="blackfnt" align="left">
                                Committed Business per Month
                            </td>
                            <td>
                                <input type="text" id="txtcommitedbusiness" class="input" maxlength="11" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" runat="server" style="margin-left: 1px; text-align:right;" />
                            </td>
                            <td colspan="3" align="left" class="blackfnt"></td>
                            <td></td>
                        </tr>
                        
                        <tr id="trServiceTax" style="background-color: White" runat="server" visible="false">
                            <td>
                                <label class="blackfnt">
                                    &nbsp;Service Tax Paid by:
                                </label>
                            </td>
                            <td>
                                <label style="margin-left: 5px;">
                                </label>
                                <asp:DropDownList ID="ddlSTPaidBy" runat="server" CssClass="blackfnt">
                                    <asp:ListItem Selected="True" Text="Select" Value="-1"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Transporter" Value="T"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Party" Value="P"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td colspan="4">
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <br />
                <td align="center" style="width: 100%">
                    <br />
                    <asp:GridView ID="grvcharges" runat="server" HorizontalAlign="Center" BorderWidth="0"
                        CellSpacing="1" CellPadding="2" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                        Width="70%" CssClass="boxbg" BackColor="#8ba0e5" HeaderStyle-CssClass="bgbluegrey"
                        FooterStyle-CssClass="<%=boxbg%>" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                        PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" OnRowDataBound="grvcharges_RowDataBound"
                        EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange">
                        <Columns>
                            <asp:TemplateField HeaderText="Charge Name" HeaderStyle-CssClass="blackfnt">
                                <HeaderStyle Font-Bold="true" />
                                <ItemStyle BackColor="White" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblsrno" Text='<%# DataBinder.Eval(Container.DataItem,"codedesc") %>'
                                        runat="server"></asp:Label> ( 
                                    <asp:Label CssClass="blackfnt" ID="lblcodefor" Text='<%# DataBinder.Eval(Container.DataItem,"codefor") %>' runat="server"></asp:Label> ) 
                                    
                                    <asp:HiddenField ID="hdnstatuscode" Value='<%# DataBinder.Eval(Container.DataItem,"statuscode") %>'
                                        runat="server" />
                                    <asp:HiddenField ID="hdncodeid" Value='<%# DataBinder.Eval(Container.DataItem,"codeid") %>'
                                        runat="server" />
                                </ItemTemplate>
                                <FooterStyle BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                                <FooterTemplate>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Charge Rate">
                                <ItemStyle BackColor="White" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtcharge" Text='<%# DataBinder.Eval(Container.DataItem,"chargerate") %>'
                                        Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                        runat="server" MaxLength="10" CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <p align="center">
                        <label class="blackfnt">
                            <b>&nbsp;Minimum Freight </b>
                        </label>
                    </p>
                    <table border="0" cellpadding="2" width="40%" bgcolor="#808080" cellspacing="1" align="center"
                        class="boxbg">
                        <tr class="bgbluegrey">
                            <td>
                                <label class="blackfnt">
                                    &nbsp;Mode of Transport
                                </label>
                            </td>
                            <td>
                                <label class="blackfnt">
                                    &nbsp;Rate
                                </label>
                            </td>
                            <td>
                                <label class="blackfnt">
                                    &nbsp;Basis
                                </label>
                            </td>
                        </tr>
                        <tr style="background-color: White">
                            <td>
                                <label class="blackfnt" id="lblAirForFreight" runat="server" style="margin-left: 5px;">
                                    <%=strModeOfTransportAir%>
                                </label>
                            </td>
                            <td>
                                <input id="txtAirRateForFreight" type="text" size="10" class="input" maxlength="8"
                                    onblur="return Nagative_Chk_wDecimal(this)" style="margin-left: 5px;" runat="server" />
                            </td>
                            <td>
                                <label style="margin-left: 5px;">
                                </label>
                                <asp:DropDownList ID="ddlAirBasisForFreight" runat="server" CssClass="blackfnt">
                                    <asp:ListItem Selected="True" Text="Select" Value="-1"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Rs." Value="RS"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Pkg." Value="PKG"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Kg." Value="KG"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Ton." Value="T"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="background-color: White">
                            <td>
                                <label class="blackfnt" id="lblRoadForFreight" runat="server" style="margin-left: 5px;">
                                    <%=strModeOfTransportRoad%>
                                </label>
                            </td>
                            <td>
                                <input id="txtRoadRateForFreight" type="text" size="10" class="input" maxlength="8"
                                    onblur="return Nagative_Chk_wDecimal(this)" style="margin-left: 5px;" runat="server" />
                            </td>
                            <td>
                                <label style="margin-left: 5px;">
                                </label>
                                <asp:DropDownList ID="ddlRoadBasisForFreight" runat="server" CssClass="blackfnt">
                                    <asp:ListItem Selected="True" Text="Select" Value="-1"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Rs." Value="RS"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Pkg." Value="PKG"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Kg." Value="KG"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Ton." Value="T"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="background-color: White">
                            <td>
                                <label class="blackfnt" id="lblTrainForFreight" runat="server" style="margin-left: 5px;">
                                    <%=strModeOfTransportTrain%>
                                </label>
                            </td>
                            <td>
                                <input id="txtTrainRateForFreight" type="text" size="10" class="input" maxlength="8"
                                    onblur="return Nagative_Chk_wDecimal(this)" style="margin-left: 5px;" runat="server" />
                            </td>
                            <td>
                                <label style="margin-left: 5px;">
                                </label>
                                <asp:DropDownList ID="ddlTrainBasisForFreight" runat="server" CssClass="blackfnt">
                                    <asp:ListItem Selected="True" Text="Select" Value="-1"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Rs." Value="RS"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Pkg." Value="PKG"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Kg." Value="KG"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Ton." Value="T"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="background-color: White">
                            <td>
                                <label class="blackfnt" id="lblExpressForFreight" runat="server" style="margin-left: 5px;">
                                    <%=strModeOfTransportExpress%>
                                </label>
                            </td>
                            <td>
                                <input id="txtExpressRateForFreight" type="text" size="10" class="input" maxlength="8"
                                    onblur="return Nagative_Chk_wDecimal(this)" style="margin-left: 5px;" runat="server" />
                            </td>
                            <td>
                                <label style="margin-left: 5px;">
                                </label>
                                <asp:DropDownList ID="ddlExpressBasisForFreight" runat="server" CssClass="blackfnt">
                                    <asp:ListItem Selected="True" Text="Select" Value="-1"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Rs." Value="RS"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Pkg." Value="PKG"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Kg." Value="KG"></asp:ListItem>
                                    <asp:ListItem Selected="False" Text="Ton." Value="T"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <br />
                    <table cellpadding="1" cellspacing="1" class="boxbg" style="width: 8in" border="0">
                        <tr class="bgbluegrey">
                            <td align="center">
                                <asp:Button ID="btnSubmit" Text="Submit" runat="server" ToolTip="Click here to submit and proceed"
                                    OnClientClick="javascript:return ValidateData()" OnClick="btnSubmit_Click" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <br />
        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
            <ProgressTemplate>
                <div id="progressArea">
                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="blackfnt" Font-Bold="true"></asp:Label>
                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
    </div>
    <%--HIDDEN AREA--%>
    <input type="hidden" id="HidRandomNo" runat="server" />
    <input type="hidden" id="HidCustCode" runat="server" />
    <input type="hidden" id="HidCustCodeName" runat="server" />
    <input type="hidden" id="HidContDate" runat="server" />
    <input type="hidden" id="HidContValidUntil" runat="server" />
    <input type="hidden" id="HidContEffFromDate" runat="server" />
    <input type="hidden" id="HidContSignLoc" runat="server" />
    <input type="hidden" id="HidCustRep" runat="server" />
    <input type="hidden" id="HidCoEmpName" runat="server" />
    <input type="hidden" id="HidCustRepDesi" runat="server" />
    <input type="hidden" id="HidCoEmpDesi" runat="server" />
    <input type="hidden" id="HidCustWitness" runat="server" />
    <input type="hidden" id="HidCoWitness" runat="server" />
    <input type="hidden" id="HidBillAdd" runat="server" />
    <input type="hidden" id="HidCity" runat="server" />
    <input type="hidden" id="HidPinCode" runat="server" />
    <input type="hidden" id="HidPartyCat" runat="server" />
    <input type="hidden" id="HidContCat" runat="server" />
    <input type="hidden" id="HidSTApp" runat="server" />
    <input type="hidden" id="HidAcctRep" runat="server" />
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
