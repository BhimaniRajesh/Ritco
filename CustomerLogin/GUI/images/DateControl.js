/*****************************************************************************************************************
                                THIS FUCNTION IS USED TO RETRIEVE HTTP OBJECT
                                    return type XMLHttpObject
*****************************************************************************************************************/

//var ValidDate_Rule="True"
function GetXMLHttpObject()
  { 
      var xmlHttp;
      try
        {    
            xmlHttp=new XMLHttpRequest();    // Firefox, Opera 8.0+, Safari    
        }
      catch (e)
        {
            // Internet Explorer    
            try
              {  
                  xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");      
              }
            catch (e)
              {      
                try
                    {xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");}
                catch (e)
                    {
                        alert("Your browser does not support AJAX!");        
                        return false;        
                    }      
              }    
         }
         return xmlHttp;  
   }
   
function matchPattern(Str,Pattern,str) 
    {
        var matchArray = Str.match(Pattern); // is the format ok?
        if (matchArray == null){
                alert("Please Enter " + str + " in correct format");
                return false;
        } else {
            return true;
        }
    }
       //var Ret_Flag="Y"
function MIn_Max_Date_Validation(Obj,DocCode,Date_ctrl_Path)
     {
                       //alert(Obj)
                   //alert(document.getElementById(ABC))
                        //Ret_Flag="Y"
                       // document.getElementById(ABC).value="N"
                        if(Obj.value=="")
                        {
                                return false;
                        }
                        //alert(Obj.value)
                        //alert(DocCode)
                        //alert(Date_ctrl_Path)                                 
                                 if(ValidateDate(Obj)==false)
                                 {
                                    return false;
                                 }
                                var Code_ID=Obj;
                                var findobj=false;
                                findobj=GetXMLHttpObject();
                                
                                if(findobj)
                                {
                                   // alert(findobj)
                                    var strpg=Date_ctrl_Path+"?DocCode="+DocCode+"&Value=" + Code_ID.value + "&sid=" + Math.random();
                                    findobj.open("GET",strpg,true);
                                    findobj.onreadystatechange=function()
                                    {
                                         //alert(findobj.readyState)
                                         // alert(findobj.responseText)
                                         if(findobj.readyState==4 && findobj.status==200)
                                            {
                                              // alert(findobj.responseText)
                                                var res=findobj.responseText.split("|");
                                                if(res[0]=="N")
                                                {
                                                    alert(res[1]);
                                                    Code_ID.value="";
                                                    Code_ID.focus();
                                                   // document.getElementById(ABC).value="N"
                                                    return false;
                                                }
                                                else
                                                {
                                                //document.getElementById(ABC).value="Y"
                                                }
                                            }
                                    }
                                    findobj.send(null);
                                }
                
                return true
        
            //return Ret_Flag
      }
      
      
          /*************************************************************************************************************
             FUNCTION VALIDATES DATESTR........ UT STR IS ONLY STRING TO DISPLAY CONTROL NAME
*************************************************************************************************************/

function ValidateDate(obj)
    {
          if (obj.value!="")
          {       
         // alert(isDate(obj.value))
            if (isDate(obj.value)==false)
	        {
                obj.focus()
		        return false
	        }
	         
          }
          
    }
var dtCh= "/";
var minYear=1900;
var maxYear=2100;

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

function stripCharsInBag(s, bag){
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

function daysInFebruary (year){
	// February has 29 days in any year evenly divisible by four,
    // EXCEPT for centurial years which are not also divisible by 400.
    return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
}

function DaysArray(n) {
	for (var i = 1; i <= n; i++) {
		this[i] = 31
		if (i==4 || i==6 || i==9 || i==11) {this[i] = 30}
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