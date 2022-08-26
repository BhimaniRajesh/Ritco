
	 var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
	 var months1 = new Array("","Jan", "Feb", "Mar", "Apr", "May", "Jun","Jul", "Aug", "Sep", "Oct", "Nov", "Dec");
	
	 var UC_FRM_NM="ctl00_MyCPH1_UCMyReceiptControls_"
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
 
    
		var dockdta=document.getElementById("ctl00_MyCPH1_txtbsbdt").value
		//alert("hi...221")
	    if(dockdta=="")
	    {
	        alert("Plz Enter Bill Submission Date ")
	        document.getElementById("ctl00_MyCPH1_txtbsbdt").focus()
	        return false;
	    }
		dockdta_dd=dockdta.substring(0,2)
		dockdta_mm=dockdta.substring(3,5)
		dockdta_yy=dockdta.substring(6,10)  
	 
		var dockdt_billdt=new Date(months[parseFloat(dockdta_mm)] + " " + parseFloat(dockdta_dd) + ", " + parseFloat(dockdta_yy))
		
     //alert(days)
     //alert(dockdt_billdt)
		
		//alert(Datadate1(dues))
		  var grid=document.getElementById("ctl00_MyCPH1_dockdata");
		//  alert(grid)
                 var rows=grid.rows.length;  
                 var Check_One="N"
                 var Total_amount="0.00",NetAmt="0.00",TotalNetAmt="0.00"
                  var i=0     
                 //  alert("hi...1")
                  for(var b=2;b<=rows-1;b++)
                  {
                         //alert(b)
                            if(b<10)
                            {
                                GV_FRM_NM="ctl00_MyCPH1_dockdata_ctl0" + b + "_";
                                //hdndockdt="ctl00_MyCPH1_dockdata_ctl0" + b + "Hnd_DUEDT" 
                            }
                            else
                            {
                                 GV_FRM_NM="ctl00_MyCPH1_dockdata_ctl" + b + "_";
                                // hdndockdt="ctl00_MyCPH1_dockdata_ctl" + b + "Hnd_DUEDT";
                            }
                           
                           //  alert(document.getElementById(hdndockdt).value)
                            //document.getElementById(hdndockdt).value= dues ;           
                          //  if(document.getElementById(GV_FRM_NM+"chkDock").checked)
                           // {
                              //  document.getElementById(hdndockdt).value= dues ; 
                                days=parseInt(document.getElementById(GV_FRM_NM+"LBL_CRD_DT").innerText) 
                                 
                                dues=dateAdd('D',days,dockdt_billdt)
                                 
       
                                
                                if(document.getElementById("ctl00_MyCPH1_CHk_Due_dt").checked)
                                 {
                                    document.getElementById(GV_FRM_NM+"LBL_DUE_DT").innerText= Datadate(dues) ; 
                                    document.getElementById(GV_FRM_NM+"Hnd_DUEDT").value= Datadate(dues) ;
                                 }
                                 else
                                 {
                                    document.getElementById(GV_FRM_NM+"LBL_DUE_DT").innerText= document.getElementById(GV_FRM_NM+"Hnd_DUEDT_Old").value ; 
                                    document.getElementById(GV_FRM_NM+"Hnd_DUEDT").value= document.getElementById(GV_FRM_NM+"Hnd_DUEDT_Old").value ; 
                                 }
                               // document.getElementById("ctl00_MyCPH1_Txt_Due_Date").innerText= Datadate1(dues) ;
                                 
                           // }
                  }
		 
		//document.getElementById("ctl00_MyCPH1_Txt_Duedate").value=Datadate1(dues)
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
		   // alert(base.getDate() + numb)
		   // alert(numb)
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
function Datadate(dt)
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
	    
	    dt=dd + " " + months1[parseFloat(mm)] + " " + yy
	    //alert(dt)
	 	return dt
	 	
	 	
	 	    
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
function Customer_Location_Blur(Obj,Mode,Acct_Y_N)
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

/*************************************************************************************************************
             FUNCTION FOr Check All
*************************************************************************************************************/
var  FRM_NM="ctl00_MyCPH1_"
function Check_All(Grd_Name,Obj_chk_All,Obj_Chk_Ind,CalC_YN)
	    {
	             
	             Grid_Id=Grd_Name
	             var grid=document.getElementById("ctl00_MyCPH1_"+Grid_Id);
                 var rows=grid.rows.length;  
                 var Check_One="N"
                 var Total_amount="0.00",NetAmt="0.00",TotalNetAmt="0.00"
                 if(document.getElementById("ctl00$MyCPH1$"+Grid_Id+"$ctl01$"+Obj_chk_All).checked)
                 {
                      for(var b=2;b<=rows-1;b++)
                      {
                            //alert(b)
                            if(b<10)
                            {
                                GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl0" + b + "_";
                            }
                            else
                            {
                                 GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl" + b + "_";
                            }       
                             
                                        document.getElementById(GV_FRM_NM+Obj_Chk_Ind).checked=true
                           
                      }
                  }
                  else
                  {
                             for(var b=2;b<=rows-1;b++)
                              {
                                    //alert(b)
                                    if(b<10)
                                    {
                                        GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl0" + b + "_";
                                    }
                                    else
                                    {
                                         GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl" + b + "_";
                                    }
                                    
                                    document.getElementById(GV_FRM_NM+Obj_Chk_Ind).checked=false
                             
                              }
                  }
                  if(CalC_YN=="Y")
                  {
                     Check_Calc('dockdata','ChkAll','chkOrderNo')
                 }
    }
        
    	function Check_Calc(Grd_Name,Obj_chk_All,Obj_Chk_Ind)
	    {        
	            
	            // alert("hi...")
	             Grid_Id=Grd_Name
	             var grid=document.getElementById("ctl00_MyCPH1_"+Grid_Id);
                 var rows=grid.rows.length;  
                 //alert("hi...a")
                 var Check_One="N"
                 var Total_amount="0.00",NetAmt="0.00",TotalNetAmt="0.00"
                 var Total_adv_amt="0.00",Total_PendAmt="0.00"
                 var Total_billAmount="0"
                 //alert("hi...1")
                  for(var b=2;b<=rows-1;b++)
                  {
                                    if(b<10)
                                    {
                                        GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl0" + b + "_";
                                    }
                                    else
                                    {
                                         GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl" + b + "_";
                                    }
                                if(document.getElementById(GV_FRM_NM+Obj_Chk_Ind).checked)
                                {
                                    Total_billAmount=rounditn(parseFloat(document.getElementById(GV_FRM_NM+"Hnd_Dkttot").value)+parseFloat(Total_billAmount),2)
                                    document.getElementById(FRM_NM+"Txt_BillAmt").value=rounditn(Total_billAmount,2)
                                // alert(document.getElementById(FRM_NM+"Hnd_ON_CR_Limit_Allow").value)
                                     if(document.getElementById(FRM_NM+"Hnd_ON_CR_Limit_Allow").value=="N")
				                     {
                                         if(parseFloat(Total_billAmount) > parseFloat(document.getElementById(FRM_NM+"Lbl_Credit_Limit").innerText))
                                         {
                                            
                                                 // document.getElementById("ctl00_MyCPH1_object").style.display="block";
                                                //  $("#ctl00_MyCPH1_object").fadeOut(100).fadeIn(100).fadeOut(100).fadeIn(100).fadeOut(100).fadeIn(100).fadeOut(100);
                                                 alert("Bill Amount Should be Less then Or Equals to Credit Limit For The Same Customer.")
                                                 document.getElementById(GV_FRM_NM+Obj_Chk_Ind).checked=false 
                                                 document.getElementById("ctl00$MyCPH1$"+Grid_Id+"$ctl01$"+Obj_chk_All).checked=false
                                                 Total_billAmount=rounditn(parseFloat(Total_billAmount)-parseFloat(document.getElementById(GV_FRM_NM+"Hnd_Dkttot").value),2)   
                                         }
                                      }
                                }
                                 document.getElementById(FRM_NM+"Txt_BillAmt").value=rounditn(Total_billAmount,2)
                    } 
                  
                  
                 
                
	    }
	    
/*************************************************************************************************************
             FUNCTION For On SUBMIT VALIDATION
*************************************************************************************************************/
        function OnSubmit()
        {
            
            var server_dt=document.getElementById(FRM_NM+"Hnd_Server_dt").value;
            
	         var MIn_dt=document.getElementById(FRM_NM+"Hnd_Mindate").value
            var Max_Date =document.getElementById(FRM_NM+"Hnd_Maxdate").value
				if(document.getElementById(FRM_NM+"txtbgndt").value=="")
				{
				  alert("Please Enter the Bill Date")
				  document.getElementById(FRM_NM+"txtbgndt").focus();
				  return false;
				}

				var dt =document.getElementById(FRM_NM+"txtbgndt").value
				var hdndockdt;
			    var Maxdt="01/01/2007";
			    var mTotalRecords = "<%=intTotalRecords %>";
			     Grid_Id="dockdata"
	             var grid=document.getElementById("ctl00_MyCPH1_"+Grid_Id);
                 var rows=grid.rows.length;  
                 //alert("hi...a")
                 var Check_One="N"
                 var Total_amount="0.00",NetAmt="0.00",TotalNetAmt="0.00"
                 var Total_adv_amt="0.00",Total_PendAmt="0.00"
                 var Total_billAmount="0"
                 Check_One="N"
                 //alert("hi...1")
                 
                 var FinYear_fromdate_dd=FinYear_fromdate.substring(0,2);
				var FinYear_fromdate_mm=FinYear_fromdate.substring(3,5);
				var FinYear_fromdate_yy=FinYear_fromdate.substring(6,10);
				FinYear_fromdate1=new Date(months[parseFloat(FinYear_fromdate_mm)] + " " + parseFloat(FinYear_fromdate_dd) + ", " + parseFloat(FinYear_fromdate_yy))
				
				var FinYear_todate_dd=FinYear_todate.substring(0,2);
				var FinYear_todate_mm=FinYear_todate.substring(3,5);
				var FinYear_todate_yy=FinYear_todate.substring(6,10);
				FinYear_todate1=new Date(months[parseFloat(FinYear_todate_mm)] + " " + parseFloat(FinYear_todate_dd) + ", " + parseFloat(FinYear_todate_yy))
				
				
				
               for(var b=2;b<=rows-1;b++)
                  {
                    if(b < 10)
                    {
                        hdndockdt = "ctl00_MyCPH1_dockdata_ctl" + "0" + b + "_hdndt";
                        hdndockdt = document.getElementById(hdndockdt).value;
                        checkyn = document.getElementById("ctl00_MyCPH1_dockdata_ctl" + "0" + b + "_chkOrderNo").checked;
                    }
                    else
                    {
                        hdndockdt = "ctl00_MyCPH1_dockdata_ctl" + b + "_hdndt";
                        hdndockdt = document.getElementById(hdndockdt).value;
                        checkyn = document.getElementById("ctl00_MyCPH1_dockdata_ctl" + b + "_chkOrderNo").checked;
                    }
                    
                   if(checkyn==true)
                   {
                     var Maxdt1 =Maxdt
    				 Check_One="Y"
				     var Maxdt_dd=Maxdt1.substring(0,2)
				     var Maxdt_mm=Maxdt1.substring(3,5)
				     var Maxdt_yy=Maxdt1.substring(6,10)
                        
		             var hdndockdt1 =hdndockdt
				     var hdndockdt_dd=hdndockdt1.substring(0,2)
				     var hdndockdt_mm=hdndockdt1.substring(3,5)
				     var hdndockdt_yy=hdndockdt1.substring(6,10)
				    
				     Maxdt1=new Date(months[parseFloat(Maxdt_mm)] + " " + parseFloat(Maxdt_dd) + ", " + parseFloat(Maxdt_yy))
		             hdndockdt1=new Date(months[parseFloat(hdndockdt_mm)] + " " + parseFloat(hdndockdt_dd) + ", " + parseFloat(hdndockdt_yy))

                    if (hdndockdt1>Maxdt1)
                    {
                    Maxdt1=hdndockdt1
                    Maxdt=hdndockdt
                    }
                    
                  }
                  
                      if (hdndockdt1>FinYear_todate1 || hdndockdt1<FinYear_fromdate1)
				      {
						    alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Plz select Docket date Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
						    document.getElementById(FRM_NM+"txtbgndt").focus();
						    return false;
				      }
                }
                //  alert("hi...2")
               var dt =document.getElementById(FRM_NM+"txtbgndt").value
				var dt_dd=dt.substring(0,2)
				var dt_mm=dt.substring(3,5)
				var dt_yy=dt.substring(6,10)

		        var sdt =server_dt
				var sdt_dd=sdt.substring(0,2)
				var sdt_mm=sdt.substring(3,5)
				var sdt_yy=sdt.substring(6,10)
				
				
				dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
		        server_dt=new Date(months[parseFloat(sdt_mm)] + " " + parseFloat(sdt_dd) + ", " + parseFloat(sdt_yy))

				
				if (dt>FinYear_todate1 || dt<FinYear_fromdate1)
				{
						alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Billdate Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
						document.getElementById(FRM_NM+"txtbgndt").focus();
						return false;
				}
				

			    var MIn_dt1 =MIn_dt;
				var MIn_dt_dd=MIn_dt1.substring(0,2);
				var MIn_dt_mm=MIn_dt1.substring(3,5);
				var MIn_dt_yy=MIn_dt1.substring(6,10);
				MIn_dt1=new Date(months[parseFloat(MIn_dt_mm)] + " " + parseFloat(MIn_dt_dd) + ", " + parseFloat(MIn_dt_yy));
				
				 var Max_Date1 =Max_Date;
				var Max_Date_dd=Max_Date1.substring(0,2);
				var Max_Date_mm=Max_Date1.substring(3,5);
				var Max_Date_yy=Max_Date1.substring(6,10);
				Max_Date1=new Date(months[parseFloat(Max_Date_mm)] + " " + parseFloat(Max_Date_dd) + ", " + parseFloat(Max_Date_yy));
				 Fromdate1=Maxdt1
			     Fromdate=Maxdt
				if (dt<Fromdate1)
				{
						//alert( "Bill Generation Date Should Be Between  "+ Fromdate +" to "+ Todate +" !!!");
						alert( "Bill Generation Date Should Be Greater than "+ Fromdate +" !!!")
						document.getElementById(FRM_NM+"txtbgndt").focus();
						return false;
				}
		
				if (dt>server_dt)
				{
						alert( "Bill date should not be greater than today's date !!!");
						document.getElementById(FRM_NM+"txtbgndt").focus();
						return false;
				}
					//alert("hi..")
		        if (dt<MIn_dt1)
				{
						    alert( "Bill Date Should  be Greater than "+ MIn_dt + " !!!");
						    document.getElementById(FRM_NM+"txtbgndt").focus();
						    return false;
				}
				if (dt>Max_Date1)
				{
						    alert( "Bill date should  be less than  "+ Max_Date + " !!!");
						    document.getElementById(FRM_NM+"txtbgndt").focus();
						    return false;
				}
                
				if(document.getElementById(FRM_NM+"txtduedate").value=="")
				{
						alert("Please enter the Bill Due Date");
						document.getElementById(FRM_NM+"txtduedate").focus();
						
						return false;
				}
			//alert("hi..1")
				var bduedt  =document.getElementById(FRM_NM+"txtduedate").value;
				var bduedt_dd=bduedt.substring(0,2);
				var bduedt_mm=bduedt.substring(3,5);
				var bduedt_yy=bduedt.substring(6,10);
                bduedt1=new Date(months[parseFloat(bduedt_mm)] + " " + parseFloat(bduedt_dd) + ", " + parseFloat(bduedt_yy));
			  	if (dt>bduedt1)
				{
						alert( "Bill Due date should be greater than Bill date !!!");
						document.getElementById(FRM_NM+"txtduedate").focus();
						return false ;
				}	
					//alert("hi..2")
				billcolbrcd=document.getElementById(FRM_NM+"txtbillcolloc").value;
				billsubbrcd=document.getElementById(FRM_NM+"txtbillsubloc").value;
				if(billsubbrcd=="")
				{
					alert("Please enter Submission Branch");
					document.getElementById(FRM_NM+"txtbillsubloc").focus();
					return false;
				} 
					//alert("hi..3")
				 var Search_Char="~"
		        if (document.getElementById(FRM_NM+"txtbillsubloc").value.indexOf(Search_Char)==-1)
		        {
		           alert("Invalid  Submission Location  Name~Code Format");
		           document.getElementById(FRM_NM+"txtbillsubloc").focus();
		           return false
		        }

				if(billcolbrcd=="")
				{
					alert("Please enter Collection Branch");
					document.getElementById(FRM_NM+"txtbillcolloc").focus();
					return false;
				} 
				 if (document.getElementById(FRM_NM+"txtbillcolloc").value.indexOf(Search_Char)==-1)
		        {
		           alert("Invalid  Collection Location  Name~Code Format");
		           document.getElementById(FRM_NM+"txtbillcolloc").focus();
		           return false
		        }	 
		        
		        if(document.getElementById(FRM_NM+"Hnd_manual_billno_Mandatory").value=="Y")
		        {
				    if(document.getElementById(FRM_NM+"txtManualbillno").value=="")
				    {
						    alert("Please enter Manual Billno");
						    document.getElementById(FRM_NM+"txtManualbillno").focus();
						    return false;
				    }
				 } 
				if(parseFloat(document.getElementById(FRM_NM+"Txt_BillAmt").value)<=0)
				{
						alert("Bill Amount Should be Greater Then Zero !!");
						//parseFloat(document.getElementById(FRM_NM+"Txt_BillAmt").focus();
						return false;
				} 
				if(document.getElementById(FRM_NM+"Hnd_ON_CR_Limit_Allow").value=="N")
				{
				    if(parseFloat(document.getElementById(FRM_NM+"Lbl_Credit_Limit").innerText)<parseFloat(document.getElementById(FRM_NM+"Txt_BillAmt").value))
				    {
						    alert("Bill Amount is Greater Then Credit Limit Of The same Customer. !!");
						    //parseFloat(document.getElementById(FRM_NM+"Txt_BillAmt").focus();
						    return false;
				    }
				} 
			if(document.getElementById(FRM_NM+"Hnd_OutStd_Limit_Allow").value=="N")
				{
				     if(parseFloat(document.getElementById(FRM_NM+"Lbl_Credit_Limit").innerText)<parseFloat(document.getElementById(FRM_NM+"Lbl_Outstanding_amt").innerText))
				     {
						    alert("OutStanding Amount is Greater Then Credit Limit Of The same Customer. !!");
						    //parseFloat(document.getElementById(FRM_NM+"Txt_BillAmt").focus();
						    return false;
				     } 
				}
				  // alert("hi..4")
                    // Comp_Date1= Date.parse(document.getElementById(FRM_NM+"txtbgndt").value);
                     //Comp_Date2= Date.parse(document.getElementById(FRM_NM+"txtduedate").value);
                    // alert("days -"+(Comp_Date2-Comp_Date1)/(24*60*60*1000))
                     //alert("hi..5")
                if (Check_One=="N")
                {
                                              alert( "PLz Select  Atleast One Record !!!")
						                     // document.getElementById(User_CTR_Frm_Name+"txtChqDate").focus();
						                      return false;
                }
                click_count=parseFloat(document.getElementById("ctl00$MyCPH1$click_count").value)
               // alert(click_count)
 				if(click_count > 0)
				{
					alert("Sorry... You cannot click twice !!!")
					return false;
				}  
				else
				{
					click_count=click_count+1
					document.getElementById("ctl00$MyCPH1$click_count").value=click_count
					document.getElementById(FRM_NM+"Txt_BillAmt").disabled=false
					return true;
				}  
        }
        
/*************************************************************************************************************
             FUNCTION FOR BILL COLLECTION DETAILS
*************************************************************************************************************/
function Docket_Wise_Calc(CNT_Bill,Cnt)
	    {        
                 
                 Grid_Id="GridView1"
                 CNT_Bill=parseFloat(CNT_Bill)+parseFloat(1)
	             var grid=document.getElementById("ctl00_MyCPH1_"+Grid_Id);
                 var rows=grid.rows.length;  
                  var Check_One="N"
                  var Total_Frt_Amt=0
                  var Toall_Claim_Amt=0
                  var MinFlag="N"
                  if(Cnt<10)
                        GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl0" + Cnt + "_";
                  else
                        GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl" + Cnt + "_";
                  if(rows<10)
                        GV_FRM_NM_Footer="ctl00_MyCPH1_"+Grid_Id+"_ctl0" + rows + "_";
                  else
                        GV_FRM_NM_Footer="ctl00_MyCPH1_"+Grid_Id+"_ctl" + rows + "_";
                  
                  var Dkt_Deduction="0.00";
                  var j=0;
                  Hnd_SCHG_Arr=document.getElementById(GV_FRM_NM+"Hnd_SCHG").value.split("*/");
                  for (var k=0;k<Hnd_SCHG_Arr.length;k++)
                  {
                                        j=parseFloat(k)+parseFloat(1)
                                        if(document.getElementById(GV_FRM_NM+"CHG"+j))
                                        {
                                            Code_Operand_Arr=Hnd_SCHG_Arr[k].split("~");
                                            Code_Operand=Code_Operand_Arr[4]
                                            Charge_Val=Code_Operand+document.getElementById(GV_FRM_NM+"CHG"+j).value
                                            Dkt_Deduction=parseFloat(Dkt_Deduction)+parseFloat(Charge_Val)
                                            // alert(Dkt_Deduction)
                                            TotAmt=parseFloat(document.getElementById(GV_FRM_NM+"HND_PendAmt").value)+parseFloat(Dkt_Deduction)
                                            if(parseFloat(TotAmt) < 0)
                                            {  
                                                // alert(TotAmt)
                                                 alert("Total Deduction Should Be Less Then Pending Amount ")
                                                 Make_All_Zero(CNT_Bill,Cnt)
                                                 return false;
                                            }    
                                            if(document.getElementById(GV_FRM_NM_Footer+"Txt_TOT_CHG"+j))
                                            {
                                                document.getElementById(GV_FRM_NM_Footer+"Txt_TOT_CHG"+j).value="0.00"
                                            }
                                        }
                    } 
                   for (var k=1;k<11;k++)
                    {
                       if(document.getElementById(GV_FRM_NM+"CHG"+k))
                       {
                              if(document.getElementById(GV_FRM_NM_Footer+"Txt_TOT_CHG"+k))
                              {
                                   document.getElementById(GV_FRM_NM_Footer+"Txt_TOT_CHG"+k).value=rounditn(parseFloat(document.getElementById(GV_FRM_NM_Footer+"Txt_TOT_CHG"+k).value)+parseFloat(document.getElementById(GV_FRM_NM+"CHG"+k).value),2)
                              }
                        }
                    }
                  /*****************************************************************************
                  TO DISPLAY SUM OF THE DEDUCTION CHARGES
                  *******************************************************************************************************/
                  Grid_Id="dockdata"
                  
                  if(CNT_Bill<10)
                        GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl0" + CNT_Bill + "_";
                  else
                        GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl" + CNT_Bill + "_";
                  //j=0;
                   for (var k=1;k<11;k++)
                   {
                         // j=parseFloat(k)+parseFloat(1)
                          if(document.getElementById(GV_FRM_NM+"CHG"+k))
                          {
                                document.getElementById(GV_FRM_NM+"CHG"+k).value=rounditn(document.getElementById(GV_FRM_NM_Footer+"Txt_TOT_CHG"+k).value,2)
                          }
                  }
                  Bill_Wise_Calc("",CNT_Bill)

	    }
	    
	    function Bill_Wise_Calc(Obj,Cnt)
	    {
	            // alert("hi.")
	            var Total_Amount=0
                var Total_NetAmt=0
	            // alert(Cnt)
	             if(Cnt)
	             {
	                      Grid_Id="dockdata"
	                      if(Cnt<10)
                               GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl0" + Cnt + "_";
                          else
                               GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl" + Cnt + "_";
                               
	                      var grid=document.getElementById("ctl00_MyCPH1_"+Grid_Id);
                          var rows=grid.rows.length;  
                          var Check_One="N"
                           
                           var Dkt_Deduction_RW_Wise="0.00"
                          Hnd_SCHG_Arr=document.getElementById(GV_FRM_NM+"Hnd_SCHG").value.split("*/"); 
                          for (var k=0;k<Hnd_SCHG_Arr.length;k++)
                          {
                                j=parseFloat(k)+parseFloat(1)
                               if(document.getElementById(GV_FRM_NM+"CHG"+j))
                               {
                                    Code_Operand_Arr=Hnd_SCHG_Arr[k].split("~");
                                    Code_Operand=Code_Operand_Arr[4]
                                    Charge_Val=Code_Operand+document.getElementById(GV_FRM_NM+"CHG"+j).value
                                    Dkt_Deduction_RW_Wise=parseFloat(Dkt_Deduction_RW_Wise)+parseFloat(Charge_Val)
                               }
                          } 
                          Tds=document.getElementById(GV_FRM_NM+"tds").value
                          //alert("tds " + Tds)
                          UNEXPDED=document.getElementById(GV_FRM_NM+"unexpamt").value
                          Pendamt=document.getElementById(GV_FRM_NM+"txtpendamt").value
                          Deduction= parseFloat(Tds)+parseFloat(UNEXPDED)
                          Total_Amount=rounditn(parseFloat(Pendamt)+parseFloat(Dkt_Deduction_RW_Wise)-parseFloat(Deduction),2)
                          if(parseFloat(Total_Amount)< 0) 
                          {
                                 alert("Total Deduction OR Unadjusted Amount Should Be Less Then Pending Amount")
                                 document.getElementById(GV_FRM_NM+"totalamt").value=rounditn(Pendamt,2)
                                 document.getElementById(GV_FRM_NM+"tds").value=rounditn(0,2)
                                 document.getElementById(GV_FRM_NM+"unexpamt").value=rounditn(0,2)
                                 Make_All_Zero_Bill_Wise(Cnt)
                                 return false;
                         }
                         else
                         {
                               document.getElementById(GV_FRM_NM+"totalamt").value=rounditn(Total_Amount,2)
                         }
                 }
                 Grid_Id="dockdata"                   
                 var grid=document.getElementById("ctl00_MyCPH1_"+Grid_Id);
                 var rows=grid.rows.length;  
                 var Check_One="N"
                 for(var b=2;b<=rows;b++)
                 {
                          if(b<10)
                          {
                                GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl0" + b + "_";
                          }
                          else
                          {
                                GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl" + b + "_";
                          }
                          Total_NetAmt=rounditn(parseFloat(Total_NetAmt)+parseFloat(document.getElementById(GV_FRM_NM+"totalamt").value),2)
                 }
                 document.getElementById(UC_FRM_NM+"txtAmtApplA").value=rounditn(Total_NetAmt,2)
                 document.getElementById(UC_FRM_NM+"txtNetPay").value=rounditn(Total_NetAmt,2)
                 if(document.getElementById(UC_FRM_NM+'ddlPayMode').value == "Cash")
                 {
                 document.getElementById(UC_FRM_NM+'txtCashAmt').value =rounditn(Total_NetAmt,2)
                 }
                 else  if(document.getElementById(UC_FRM_NM+'ddlPayMode').value == "Bank")
                 {
                    document.getElementById(UC_FRM_NM+'txtChqAmt').value=rounditn(Total_NetAmt,2)
                 }
	    }
	    function  Make_All_Zero(CNT_Bill,Cnt)
	    {
	                    
	                    
	              Grid_Id="GridView1"
	              var grid=document.getElementById("ctl00_MyCPH1_"+Grid_Id);
                  var rows=grid.rows.length;  
                  var Check_One="N"
                  var Total_Frt_Amt=0
                  var Toall_Claim_Amt=0
                  var MinFlag="N"
                  if(Cnt<10)
                        GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl0" + Cnt + "_";
                  else
                        GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl" + Cnt + "_";
                  if(rows<10)
                        GV_FRM_NM_Footer="ctl00_MyCPH1_"+Grid_Id+"_ctl0" + rows + "_";
                  else
                        GV_FRM_NM_Footer="ctl00_MyCPH1_"+Grid_Id+"_ctl" + rows + "_";
	                    
	              for (var k=1;k<11;k++)
                  {
                      if(document.getElementById(GV_FRM_NM+"CHG"+k))
                      {
                           document.getElementById(GV_FRM_NM+"CHG"+k).value="0.00"
                      }
                      if(document.getElementById(GV_FRM_NM_Footer+"Txt_TOT_CHG"+k))
                      {
                           document.getElementById(GV_FRM_NM_Footer+"Txt_TOT_CHG"+k).value="0.00"
                      }
                  }       
                 /*****************************************************************************
                  TO DISPLAY SUM OF THE DEDUCTION CHARGES
                  *******************************************************************************************************/
              // alert("bill zero")
              Make_All_Zero_Bill_Wise(CNT_Bill)
	    }
	    function  Make_All_Zero_Bill_Wise(Cnt)
	    {
	             //alert("bill Wise Zero" +Cnt)
	             Grid_Id="dockdata"
	             if(Cnt<10)
                               GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl0" + Cnt + "_";
                 else
                               GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl" + Cnt + "_";
                 for (var k=1;k<11;k++)
                 {
                       if(document.getElementById(GV_FRM_NM+"CHG"+k))
                       {
                           document.getElementById(GV_FRM_NM+"CHG"+k).value="0.00"
                       }
                 }
                // alert(document.getElementById(GV_FRM_NM+"txtpendamt").value)
                 document.getElementById(GV_FRM_NM+"totalamt").value=document.getElementById(GV_FRM_NM+"txtpendamt").value
                 Bill_Wise_Calc("",Cnt)
	    }
	           
/*************************************************************************************************************
             FUNCTION FOR BILL COLLECTION ON SUBMIT VALIDATION CHECK
*************************************************************************************************************/
function ONSubmit_Collection()
{
                            var server_dt=document.getElementById(FRM_NM+"Hnd_Server_dt").value;
                             var MIn_dt=document.getElementById(FRM_NM+"Hnd_Mindate").value
            var Max_Date =document.getElementById(FRM_NM+"Hnd_Maxdate").value
                          // alert(document.getElementById(FRM_NM+"txtVoucherDate").value)
				            if(document.getElementById(FRM_NM+"txtVoucherDate").value=="")
				            {
				              alert("Please enter the Financial Close Date")
				              document.getElementById(FRM_NM+"txtVoucherDate").focus();
				              return false;
				            }
							 var dt =document.getElementById(FRM_NM+"txtVoucherDate").value
				 Grid_Id="dockdata"
	             var grid=document.getElementById("ctl00_MyCPH1_"+Grid_Id);
                 var rows=grid.rows.length;  
                   var Check_One="N"
                    var Maxdt="01/01/2007";
                   for(var b=2;b<=rows;b++)
                  {
                    if(b < 10)
                    {
                        hdndockdt = "ctl00_MyCPH1_dockdata_ctl" + "0" + b + "_Hnd_BillSubDate";
                        hdndockdt = document.getElementById(hdndockdt).value;
                         
                    }
                    else
                    {
                        hdndockdt = "ctl00_MyCPH1_dockdata_ctl" + b + "_Hnd_BillSubDate";
                        hdndockdt = document.getElementById(hdndockdt).value;
                         
                    }
                    
                     var Maxdt1 =Maxdt
    				 Check_One="Y"
				     var Maxdt_dd=Maxdt1.substring(0,2)
				     var Maxdt_mm=Maxdt1.substring(3,5)
				     var Maxdt_yy=Maxdt1.substring(6,10)
                        
		             var hdndockdt1 =hdndockdt
				     var hdndockdt_dd=hdndockdt1.substring(0,2)
				     var hdndockdt_mm=hdndockdt1.substring(3,5)
				     var hdndockdt_yy=hdndockdt1.substring(6,10)
				    
				     Maxdt1=new Date(months[parseFloat(Maxdt_mm)] + " " + parseFloat(Maxdt_dd) + ", " + parseFloat(Maxdt_yy))
		             hdndockdt1=new Date(months[parseFloat(hdndockdt_mm)] + " " + parseFloat(hdndockdt_dd) + ", " + parseFloat(hdndockdt_yy))

                    if (hdndockdt1>Maxdt1)
                    {
                    Maxdt1=hdndockdt1
                    Maxdt=hdndockdt
                    }

                }
                //  alert("hi...2")
               var dt =document.getElementById(FRM_NM+"txtVoucherDate").value
				var dt_dd=dt.substring(0,2)
				var dt_mm=dt.substring(3,5)
				var dt_yy=dt.substring(6,10)

		        var sdt =server_dt
				var sdt_dd=sdt.substring(0,2)
				var sdt_mm=sdt.substring(3,5)
				var sdt_yy=sdt.substring(6,10)
				
				
				dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
		        server_dt=new Date(months[parseFloat(sdt_mm)] + " " + parseFloat(sdt_dd) + ", " + parseFloat(sdt_yy))

				var FinYear_fromdate_dd=FinYear_fromdate.substring(0,2);
				var FinYear_fromdate_mm=FinYear_fromdate.substring(3,5);
				var FinYear_fromdate_yy=FinYear_fromdate.substring(6,10);
				FinYear_fromdate1=new Date(months[parseFloat(FinYear_fromdate_mm)] + " " + parseFloat(FinYear_fromdate_dd) + ", " + parseFloat(FinYear_fromdate_yy))
				
				var FinYear_todate_dd=FinYear_todate.substring(0,2);
				var FinYear_todate_mm=FinYear_todate.substring(3,5);
				var FinYear_todate_yy=FinYear_todate.substring(6,10);
				FinYear_todate1=new Date(months[parseFloat(FinYear_todate_mm)] + " " + parseFloat(FinYear_todate_dd) + ", " + parseFloat(FinYear_todate_yy))
				
				if (dt>FinYear_todate1 || dt<FinYear_fromdate1)
				{
						alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Billdate Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
						document.getElementById(FRM_NM+"txtVoucherDate").focus();
						return false;
				}

			    var MIn_dt1 =MIn_dt;
				var MIn_dt_dd=MIn_dt1.substring(0,2);
				var MIn_dt_mm=MIn_dt1.substring(3,5);
				var MIn_dt_yy=MIn_dt1.substring(6,10);
				MIn_dt1=new Date(months[parseFloat(MIn_dt_mm)] + " " + parseFloat(MIn_dt_dd) + ", " + parseFloat(MIn_dt_yy));
				
				 var Max_Date1 =Max_Date;
				var Max_Date_dd=Max_Date1.substring(0,2);
				var Max_Date_mm=Max_Date1.substring(3,5);
				var Max_Date_yy=Max_Date1.substring(6,10);
				Max_Date1=new Date(months[parseFloat(Max_Date_mm)] + " " + parseFloat(Max_Date_dd) + ", " + parseFloat(Max_Date_yy));
				 Fromdate1=Maxdt1
			     Fromdate=Maxdt
				if (dt<Fromdate1)
				{
						//alert( "Bill Generation Date Should Be Between  "+ Fromdate +" to "+ Todate +" !!!");
						alert( "Bill Generation Date Should Be Greater than "+ Fromdate +" !!!")
						document.getElementById(FRM_NM+"txtVoucherDate").focus();
						return false;
				}
		
				if (dt>server_dt)
				{
						alert( "Bill date should not be greater than today's date !!!");
						document.getElementById(FRM_NM+"txtVoucherDate").focus();
						return false;
				}
					//alert("hi..")
		        if (dt<MIn_dt1)
				{
						    alert( "Bill Date Should  be Greater than "+ MIn_dt + " !!!");
						    document.getElementById(FRM_NM+"txtVoucherDate").focus();
						    return false;
				}
				if (dt>Max_Date1)
				{
						    alert( "Bill date should  be less than  "+ Max_Date + " !!!");
						    document.getElementById(FRM_NM+"txtVoucherDate").focus();
						    return false;
				} 
		        
        if(document.getElementById(UC_FRM_NM+'ddlPayMode').value == "-1")
        {
            alert("Please Enter Payment Mode");
            document.getElementById(UC_FRM_NM+'ddlPayMode').focus();
            return false;
        }
        if(document.getElementById(UC_FRM_NM+'ddlPayMode').value == "Cash" || document.getElementById(UC_FRM_NM+'ddlPayMode').value == "Both" )
        {
            if(document.getElementById(UC_FRM_NM+'ddrCashcode').value == "")
            {
                alert("Please Select Cash Account");
                document.getElementById(UC_FRM_NM+'ddrCashcode').focus();
                return false;
            }
            if(document.getElementById(UC_FRM_NM+'txtCashAmt').value == "")
            {
                 alert("Please Enter Cash Amount");
                 //document.getElementById(UC_FRM_NM+'txtCashAmt').focus();
                return false;
            }
            
       }
        
       if(document.getElementById(UC_FRM_NM+'ddlPayMode').value == "Bank" || document.getElementById(UC_FRM_NM+'ddlPayMode').value == "Both" )
        {
           
            if(document.getElementById(UC_FRM_NM+'txtChqAmt').value == "")
            {
                alert("Please Enter Cheque Amount");
                //document.getElementById(UC_FRM_NM+'txtChqAmt').focus();
                return false;
            }
            if(document.getElementById(UC_FRM_NM+'txtChqNo').value == "")
            {
                alert("Please Enter Cheque Number");
                document.getElementById(UC_FRM_NM+'txtChqNo').focus();
                return false;
            }
           
            if(document.getElementById(UC_FRM_NM+'txtChqDate').value == "")
            {
                alert("Please Enter Cheque Date");
                document.getElementById(UC_FRM_NM+'txtChqDate').focus();
                return false;
            }
           // rdDiposited
           /* if(document.getElementById(UC_FRM_NM+'ddrBankaccode').value == "")
            {
                alert("Please Select Bank Account");
                document.getElementById(UC_FRM_NM+'ddrBankaccode').focus();
                return false;
            }*/
            if(document.getElementById(UC_FRM_NM+'txtRecBank').value == "")
            {
                alert("Please Enter Received From Bank ");
                document.getElementById(UC_FRM_NM+'txtRecBank').focus();
                return false;
            }
            if(document.getElementById(UC_FRM_NM+'Txt_BankBR').value == "")
            {
                alert("Please Enter Bank Branch");
                document.getElementById(UC_FRM_NM+'Txt_BankBR').focus();
                return false;
            }
             
             if(document.getElementById(UC_FRM_NM+'rdDiposited_0').checked==false && document.getElementById(UC_FRM_NM+'rdDiposited_1').checked==false )
             {
                    alert("PLz Select Cheque Depostion Option");
                    document.getElementById(UC_FRM_NM+'rdDiposited_0').focus();
                    return false;
             }
            if(document.getElementById(UC_FRM_NM+'rdDiposited_0').checked)
            {
                if(document.getElementById(UC_FRM_NM+'ddrBankaccode').value == "")
                {
                    alert("Please Enter Bank Account");
                    document.getElementById(UC_FRM_NM+'ddrBankaccode').focus();
                    return false;
                }
            
            }
                chqAmt=document.getElementById(UC_FRM_NM+'txtChqAmt').value ;
                OnAccountAmt=document.getElementById(UC_FRM_NM+'Txt_OnAccount_Balance').value ;
                ColAmt=document.getElementById(UC_FRM_NM+'Txt_ColAmt').value ;
                if(parseFloat(OnAccountAmt)>0)
                {
                    if(parseFloat(OnAccountAmt)<parseFloat(ColAmt))
                    {
                        alert("Collection Amount  must be equal To Or Less then  On Account Balance Amount");
                        return false;
                    }
                   
                }
                else if(parseFloat(chqAmt)<parseFloat(ColAmt))
                    {
                        alert("Cheque Amount  must be equal To Or Less then  On Account Balance Amount");
                        return false;
                    }
            
       }
       
       if(document.getElementById(UC_FRM_NM+'ddlPayMode').value == "Both" )
       {
               
                if(parseFloat(document.getElementById(UC_FRM_NM+'txtCashAmt').value)+parseFloat(document.getElementById(UC_FRM_NM+'txtChqAmt').value) != parseFloat(document.getElementById(UC_FRM_NM+'txtNetPay').value))
                {
                    alert("Cash Amount and Cheque Amount MUST be equal to Net payable");
                    document.getElementById(UC_FRM_NM+'txtCashAmt').value = "0.00";
                    document.getElementById(UC_FRM_NM+'txtChqAmt').value = "0.00";
                    return false;
                }
       }
       if(document.getElementById(UC_FRM_NM+'ddlPayMode').value == "Cash" )
       {
                if(parseFloat(document.getElementById(UC_FRM_NM+'txtCashAmt').value) != parseFloat(document.getElementById(UC_FRM_NM+'txtNetPay').value))
                {
                    alert("Cash Amount MUST be equal to Net payable");
                    document.getElementById(UC_FRM_NM+'txtCashAmt').value = "0.00";
                    return false;
                }
       }
       if(document.getElementById(UC_FRM_NM+'ddlPayMode').value == "Bank" )
       {
                if(parseFloat(document.getElementById(UC_FRM_NM+'txtChqAmt').value) != parseFloat(document.getElementById(UC_FRM_NM+'txtNetPay').value))
                {
                    //alert("Cheque Amount MUST be equal to Net payable");
                    //document.getElementById(UC_FRM_NM+'txtChqAmt').value = "0.00";
                    //return false;
                }
       }
       if(!confirm("Are You Sure That All Collection Details Are Correct Or Not"))
	        return false;
	        
	  document.getElementById(UC_FRM_NM+'Txt_ColAmt').disabled=false	
	  document.getElementById(UC_FRM_NM+'txtCashAmt').disabled=false
	  document.getElementById(UC_FRM_NM+'txtChqAmt').disabled=false	          
				             
}




function ManualMRsno(id)
{
    //debugger;
    var ManualNO=document.getElementById(id);
    var ManualNumber = ManualNO.value;
    var findobj=false;
     //alert(ManualNumber)
    if (ManualNumber!="")
    {
        findobj=GetXMLHttpObject();
        if(findobj)
        {
         var strpg="CheckExist.aspx?mode=ManualMR&Code=" + ManualNumber + "&sid=" + Math.random();
         findobj.open("GET",strpg,true);
         findobj.onreadystatechange=function()
             {
                 //  alert(findobj.readyState)
                  //  alert(findobj.status)
                    if(findobj.readyState==4 && findobj.status==200)
                    {
                        //alert(findobj.responseText)
                        var res=findobj.responseText;
                        if(res=="True")
                        {
                            alert("Manual MR Number is Already Exists... Please Enter Other Number");
                            ManualNO.value="";
                            ManualNO.focus();
                            return false;
                        }
                        
                    }
             }
        findobj.send(null);
        }
        return false;
    }
     
}