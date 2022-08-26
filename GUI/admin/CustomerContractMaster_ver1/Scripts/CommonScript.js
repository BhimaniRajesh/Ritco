// JScript File

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

function isDate(dtStr)
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
	
	    if (isDate(obj.value)==false)
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
		alert("Value can not be blank")
		obj.focus();
		return false;
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