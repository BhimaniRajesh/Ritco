
	 var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
	/*************************************************************************************************************
             FUNCTION FOR NO OF DECIMAL VALUE
*************************************************************************************************************/

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
	
/*************************************************************************************************************
            function assignment in keypress doesn't allow any character other than number
*************************************************************************************************************/

 
function validInt(event)
{
    if(event.keyCode==13)
    {
    return true;
    }
    if(event.keyCode<48 || event.keyCode>57)
    {
    event.keyCode=0;return false;
    }
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

/*************************************************************************************************************
          FUNCTION FOR ADD DUE DATE
*************************************************************************************************************/

function ADD_DueDate()
{
		var dockdta=document.getElementById("ctl00_MyCPH1_TxtVoucherDT").value
		
		dockdta_dd=dockdta.substring(0,2)
		dockdta_mm=dockdta.substring(3,5)
		dockdta_yy=dockdta.substring(6,10)  
			
		var dockdt_billdt=new Date(months[parseFloat(dockdta_mm)] + " " + parseFloat(dockdta_dd) + ", " + parseFloat(dockdta_yy))
		var days=parseInt(document.getElementById("ctl00_MyCPH1_Txt_DueDays").value)
      //  alert(days)
		dues=dateAdd('D',days,dockdt_billdt)
		document.getElementById("ctl00_MyCPH1_Txt_Duedate").value=Datadate1(dues)
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
			base.setDat(base.getDate() + numb);
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
/*****************************************************************************************************************
                                THIS FUCNTION IS USED TO RETRIEVE HTTP OBJECT
                                    return type XMLHttpObject
*****************************************************************************************************************/
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
    
    /*************************************************************************************************************
             FUNCTION VALIDATES DATESTR........ UT STR IS ONLY STRING TO DISPLAY CONTROL NAME
*************************************************************************************************************/

function isValidDate(dateStr,str) 
    {
        var datePat = /^(\d{1,2})(\/|-)(\d{1,2})\2(\d{4})$/; // requires 4 digit year
        var matchArray = dateStr.match(datePat); // is the format ok?
        if (matchArray == null) 
            {
                alert("Please Enter " + str + " Date in dd/mm/yyyy Format");
                return false;
            }

            month = matchArray[3]; // parse date into variables
            day = matchArray[1];
            year = matchArray[4];


        if (month < 1 || month > 12) { // check month range
                alert("In " + str + "Date Month must be between 1 and 12.");
                return false;
            }

        if (day < 1 || day > 31) {
            alert("In " + str + "Day must be between 1 and 31.");
            return false;
            }
    
        if ((month==4 || month==6 || month==9 || month==11) && day==31) {
            alert("In " + str + "Month "+month+" doesn't have 31 days!")
            return false
            }
            
        if (month == 2) { // check for february 29th
            var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
            
            if (day>29 || (day==29 && !isleap)) {
                alert("In " + str + "February " + year + " doesn't have " + day + " days!");
                return false;
                }
            }
    return true; // date is valid
}




//**********************************************************

//********************************
function VenDor_Vechicle_Blur(Obj,Mode,Acct_Y_N)
 {
                
    
                if(Obj.value=="")
                {
                        return false;
                }
                var Search_Char="~"
		        if (Obj.value.indexOf(Search_Char)==-1)
		        {
		           alert("Invalid  "+ Mode +"  Name~Code Format");
		           Obj.focus();
		           return false
		        }
    Obj.value=Obj.value.toUpperCase()
    var Code_ID=Obj;
   
    var Code_Value=Code_ID.value;
    Code_Value_Arr=Code_Value.split("~");
    
    var Code_Value_0=Code_Value_Arr[0]
    var Code_Value_1=Code_Value_Arr[1]
    
    if(Code_Value_1=="")
    return false;
    
    var findobj=false;
    findobj=GetXMLHttpObject();
   
    if(findobj)
    {
    //alert("Hi..1")
    //alert(Code_Value_1)
    //alert(Mode)
     var strpg="../CheckExist.aspx?Mode="+Mode+"&Code=" + Code_Value_1 + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
            // alert("Hi..2")
            // alert(findobj.readyState)
             // alert(findobj.status)
             if(findobj.readyState==4 && findobj.status==200)
                {
                    //alert(findobj.responseText)
                    var res=findobj.responseText.split("|");
                    
                    if(res[0]=="false")
                    {
                        alert(Mode + "  Code is not Valid... Please Enter Valid "+ Mode +" Code");
                        Code_ID.value="";
                        Code_ID.focus();
                        return false;
                    }
                    else
                    {
                       // alert(res[2])
                       if(Acct_Y_N=="Y")
                      {
                        document.getElementById("ctl00_MyCPH1_Lbl_cr_account").innerText=res[2]
                        Acct_ARR=res[2].split(":");
                      //  alert(Acct_ARR[0])
                      
                        document.getElementById("ctl00_MyCPH1_CR_Accounts").value=Acct_ARR[0]
                       } 
                    }
                }
         }
    findobj.send(null);
    }
    return false;
}


//***************Display Asset Name 
function Show_assetNM(Obj)
 {
               // alert("hi..")
                if(Obj.value=="")
                {
                        return false;
                }
                var Search_Char="~"
		        if (Obj.value.indexOf(Search_Char)==-1)
		        {
		           alert("Invalid  Asset  Name~Code Format");
		           Obj.focus();
		           return false
		        }
   
    
    
     var TxtAssetcode=Obj.id;
    
    var txtastnm=TxtAssetcode.replace( "txtassetcd", "txtastnm");
     
    var Assetcode_Arr=document.getElementById(TxtAssetcode).value.split("~");
    Assetcode=Assetcode_Arr[1]
    //alert(Assetcode)
  
        if(Assetcode!="")
        {
           
                var findobj=false;
                findobj=GetXMLHttpObject();
                if(findobj)
                {
                  
                 var strpg="CheckExist.aspx?mode=Assetcode&Code=" + Assetcode + "&sid=" + Math.random();
                 findobj.open("GET",strpg,true);
                 findobj.onreadystatechange=function()
                     {
                        
                         if(findobj.readyState==4 && findobj.status==200)
                            {
                                var res=findobj.responseText.split("|");
                                if(res[0]=="false")
                                {
                                    alert("Asset Code is not Valid... Please Enter Valid Asset Code");
                                    document.getElementById(TxtAssetcode).value="";
                                    document.getElementById(TxtAssetcode).focus();
                                    return false;
                                }
                                 
                                
                            }
                     }
                     
                    findobj.send(null);
                }
        return false;
        }
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