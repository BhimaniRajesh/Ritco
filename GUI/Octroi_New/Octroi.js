
	 var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
	 //var months1 = new Array("","Jan", "Feb", "Mar", "Apr", "May", "Jun","Jul", "Aug", "Sep", "Oct", "Nov", "Dec");
	
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

function ADD_DueDate(Add_Days)
{
 
    
		var dockdta=document.getElementById("ctl00_MyCPH1_txtBillDate").value
	    if(dockdta=="")
	    {
	        alert("Plz Enter Bill Submission Date ")
	        document.getElementById("ctl00_MyCPH1_txtBillDate").focus()
	        return false;
	    }
		dockdta_dd=dockdta.substring(0,2)
		dockdta_mm=dockdta.substring(3,5)
		dockdta_yy=dockdta.substring(6,10)  
	    
		var dockdt_billdt=new Date(months[parseFloat(dockdta_mm)] + " " + parseFloat(dockdta_dd) + ", " + parseFloat(dockdta_yy))
		var days=parseInt(Add_Days)
		if(parseInt(Add_Days)=="0")
		{
		  alert("Due date Will Change According to Party Contract \n AS Per Contract Due Days is :-" +days + "\n If due Days is Zero Then Due Date Will BE Same AS Bill Date")
		}
		else
		{
		 alert("Due date Will Change According to Party Contract \n AS Per Contract Due Days is :-" +days)
		}
		// alert(dockdt_billdt)
		dues=dateAdd('D',days,dockdt_billdt)
		// alert(dues)
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
	// alert(dd)
	mm=parseInt(dt.getMonth()+1)
	// alert(mm)
	yy=parseInt(dt.getFullYear())
	// alert(yy)
	    
	    if(parseInt(dd)<10)
	    {
	    dd="0"+dd
	    }
	 //   alert(dd)
	    if(parseInt(mm)<10)
	    {
	    mm="0"+mm
	    }
	   // alert(mm)
	    dt=dd + "/" + mm + "/" + yy
	  //  alert(dt)
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
        //alert("hi...01")
        var datePat = /^(\d{1,2})(\/|-)(\d{1,2})\2(\d{4})$/; // requires 4 digit year
        //alert(dateStr)
        var matchArray = dateStr.value.match(datePat); // is the format ok?
        // alert("hi...0")
        if (matchArray == null) 
            {
                alert("Please Enter " + str + " Date in dd/mm/yyyy Format");
                dateStr.focus()
                return false;
            }
       // alert("hi...")
            month = matchArray[3]; // parse date into variables
            day = matchArray[1];
            year = matchArray[4];
 
        if (month < 1 || month > 12) { // check month range
                alert("In " + str + "Date Month must be between 1 and 12.");
                 dateStr.focus()
                return false;
            }

        if (day < 1 || day > 31) {
            alert("In " + str + "Day must be between 1 and 31.");
             dateStr.focus()
            return false;
            }
    
        if ((month==4 || month==6 || month==9 || month==11) && day==31) {
            alert("In " + str + "Month "+month+" doesn't have 31 days!")
             dateStr.focus()
            return false
            }
            
        if (month == 2) { // check for february 29th
            var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
            
            if (day>29 || (day==29 && !isleap)) {
                alert("In " + str + "February " + year + " doesn't have " + day + " days!");
                 dateStr.focus()
                return false;
                }
            }
    return true; // date is valid
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

/*************************************************************************************************************
             FUNCTION For On SUBMIT VALIDATION
*************************************************************************************************************/
       		  
       		 

function PartyLocBlur(Obj,Type)
 {
 
    
    document.getElementById(Obj).value=document.getElementById(Obj).value.toUpperCase();
    var txtPartyLocId=document.getElementById(Obj);
    if(txtPartyLocId.value == "")
        return false;
    
    var Search_Char="~";        
    if (txtPartyLocId.value.indexOf(Search_Char)==-1)
    {
       alert("Invalid  "+ Type +"  Name~Code Format");
       txtPartyLocId.focus();
       return false;
    }
    
    //Obj.value=Obj.value.toUpperCase()
    var Code_ID=document.getElementById(Obj);
    
    var Code_Value=Code_ID.value;
    Code_Value_Arr=Code_Value.split("~");
    
    var Code_Value_0=Code_Value_Arr[0];
    var Code_Value_1=Code_Value_Arr[1];
    
    if(Code_Value_1=="")
    return false;
    
    if(Type == "Party")
        var txtPartyCode = txtPartyLocId;
    else if(Type == "SubLoc")
        var txtBillSubAt = txtPartyLocId; 
    else if(Type == "ColLoc")
        var txtBillColAt = txtPartyLocId; 
        
    var lblPartyAdd = document.getElementById("ctl00_MyCPH1_lblPartyAdd");
    var Lbl_Credit_days = document.getElementById("ctl00_MyCPH1_Lbl_Credit_days");
    var Lbl_Credit_Limit = document.getElementById("ctl00_MyCPH1_Lbl_Credit_Limit");
    var Lbl_Outstanding_amt = document.getElementById("ctl00_MyCPH1_Lbl_Outstanding_amt");
    var txtBillSubAt = document.getElementById("ctl00_MyCPH1_txtBillSubAt");
    var txtBillColAt = document.getElementById("ctl00_MyCPH1_txtBillColAt");

        
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
        var strpg="../CheckPartyLocExist.aspx?mode=" + Type + "&Code=" + Code_Value_1 + "&sid=" + Math.random();
        findobj.open("GET",strpg,true);
        findobj.onreadystatechange=function()
        { 
            if(findobj.readyState==4 && findobj.status==200)
                {
                    var res=findobj.responseText.split("|");
                    if(res[0]=="false")
                    {
                        if(Type == "Party")
                        {
                            alert("Party Code Is Not Valid For This Location... Plz Enter Valid Party Code");
                            txtPartyLocId.value="";
                            txtPartyLocId.focus();
                            return false;
                        }
                        else
                        {
                            alert("Location Code Is Not Valid... Plz Enter Valid Location Code");
                            txtPartyLocId.value="";
                            txtPartyLocId.focus();
                            return false;
                        }
                    }
                    else
                    {
                        if(Type == "Party")
                        {   
                            //alert(findobj.responseText)
                          
                            lblPartyAdd.innerText = res[1];
                            Lbl_Credit_days.innerText = res[2];
                            Lbl_Credit_Limit.innerText = res[3];
                            Lbl_Outstanding_amt.innerText = res[4];
                            txtBillSubAt.value = res[5];
                            txtBillColAt.value = res[6];
                            ADD_DueDate(Lbl_Credit_days.innerText);
                        }
                    }
                }
         }
         
    findobj.send(null);
    }
    return false;
}


function DocketCheck(Obj)
 {
 
    var txtDockno = Obj.id;
    var txtDelVal = Obj.id;
    var txtOctAmt = Obj.id;
    var txtRecpno = Obj.id;
    var txtRecpdt = Obj.id;
    var hdndockdt = Obj.id;
    
    txtDelVal=txtDelVal.replace( "txtDockno", "txtDelVal");
    txtOctAmt=txtOctAmt.replace( "txtDockno", "txtOctAmt");
    txtRecpno=txtRecpno.replace( "txtDockno", "txtRecpno");
    txtRecpdt=txtRecpdt.replace( "txtDockno", "txtRecpdt");
    hdndockdt=txtRecpdt.replace( "txtDockno", "hdndockdt");
    
    txtDockno = document.getElementById(txtDockno);
    txtDelVal = document.getElementById(txtDelVal);
    txtOctAmt = document.getElementById(txtOctAmt);
    txtRecpno = document.getElementById(txtRecpno);
    txtRecpdt = document.getElementById(txtRecpdt);
    
    txtPartyCode = document.getElementById("ctl00_MyCPH1_txtPartyCode");
    
    if(txtDockno.value == "")
        return false;
        
    var DocketNo = txtDockno.value;
    //var PartyCode = txtPartyCode.value;
    if(txtPartyCode.value=="" || txtDockno.value=="")
    {
        return false;
    }
    //alert("hi...")
    
     var Search_Char="~";        
    if (txtPartyCode.value.indexOf(Search_Char)==-1)
    {
       alert("Invalid  Customer Party  Name~Code Format");
       txtPartyCode.focus();
       return false;
    }
    //  alert(txtPartyCode)
    //Obj.value=Obj.value.toUpperCase()
    var Code_ID=txtPartyCode;
   
    var Code_Value=Code_ID.value;
    Code_Value_Arr=Code_Value.split("~");
    
    var PartyCode=Code_Value_Arr[1];
    var PartyName=Code_Value_Arr[0];
    
    
    
    var tbl=document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols");
    var r=tbl.rows.length;
   
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
        var strpg="../CheckExist.aspx?DocketNo=" + DocketNo + "&PartyCode=" + PartyCode + "&sid=" + Math.random();
        findobj.open("GET",strpg,true);
        findobj.onreadystatechange=function()
        { 
             if(findobj.readyState==4 && findobj.status==200)
                {
                    
                    var res=findobj.responseText.split("|");
                    if(res[0]=="false")
                    {
                        alert("Invalid Docket No Or DOcket No. Not Present In System");
                        Obj.value="";
                        Obj.focus();
                        return false;
                    }
                    else
                    {
                        //debugger;
                        if(res[0] == "true")
                        {
                            txtDelVal.value = res[1];
                            txtOctAmt.value = res[2];
                            if(parseFloat(txtOctAmt.value)>0)
                            {
                                txtOctAmt.disabled=true
                            }
                            txtRecpno.value = res[3];
                           if(txtRecpno.value!="")
                            {
                                txtRecpno.disabled=true
                            }
                            txtRecpdt.value = res[4];   
                            if(txtRecpdt.value!="")
                            {
                                txtRecpdt.disabled=true
                            }
                            hdndockdt.value = res[5];   
                        }
                        else
                        {
                            alert(res[0]);
                            Obj.value="";
                            Obj.focus();
                            return false;
                        }
                        
                    }
                }
         }
      findobj.send(null);
    }
    return false;
}


 function LocBlur(id)
 {
    
    var str="";
    for(var i=0;i<id.length-14;i++)
    {
        str+=id.charAt(i);
    }
    document.getElementById(id).value=document.getElementById(id).value.toUpperCase()
    var txtLocation=document.getElementById(id);
   
    var Location=txtLocation.value;
    if(Location=="")
        return false;
 
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="CheckExist.aspx?mode=LocCode&Code=" + Location + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
             if(findobj.readyState==4 && findobj.status==200)
                {
                    var res=findobj.responseText.split("|");
                    if(res[0]=="false")
                    {
                        alert("Location Code is not Valid... Please Enter Valid Location Code");
                        txtLocation.value="";
                        txtLocation.focus();
                        return false;
                    }
                   
                }
         }
    findobj.send(null);
    }
    return false;
}


function calc()
    {
        var grid=document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols");
        var norows=grid.rows.length;
        var pref="";
        var grandtotal2=0.00;
        var pref="";
        var octamt=0.00;
        var processchrg=0.00;
        var stax=0.00;
        var cess=0.00;
        var hcess=0.00;
        var othr=0.00;
        var forsvc=0.00;
        for(var i=2;i<=norows;i++)
        {
            var grandtotal=0.00;
            if(i<10)
                pref="ctl00_MyCPH1_OctDetails_grvcontrols_ctl0" + i + "_";
            else
                pref="ctl00_MyCPH1_OctDetails_grvcontrols_ctl" + i + "_";
                
            var txtoctamt=document.getElementById(pref+"txtOctAmt");
            var txtoctper=document.getElementById(pref+"txtOctper");
            var txtclearchrg=document.getElementById(pref+"txtClearChrg");
            var txtprochrg_per=document.getElementById(pref+"txtProPercent");
            var txtprochrg=document.getElementById(pref+"txtProChrg");
            var txtstax=document.getElementById(pref+"txtSvrTax");
            var txtcess=document.getElementById(pref+"txtCess");
            var txthcess=document.getElementById(pref+"txtHEduCess");
            var txtotchg=document.getElementById(pref+"txtOtrChrg");
            var txttotalamt=document.getElementById(pref+"txtTotal");
            var txtdeclval=document.getElementById(pref+"txtDelVal");
            octamt=parseFloat(txtoctamt.value);
            if(octamt==0)
            {}
            else
            {
                //debugger;
                var perct = parseFloat(txtoctamt.value) * 100 / parseFloat(txtdeclval.value);
                txtoctper.value = rounditn(perct,2);
                grandtotal=grandtotal + octamt;  // Assigning Octroi Amount to Grand Total
                grandtotal=grandtotal + parseFloat(txtclearchrg.value); // Adding Cleasrance Charges to Grand Total
                
                grandtotal = grandtotal + +parseFloat(txtprochrg.value); // Adding Processing Charges to Grand Total
                //txtprochrg.value=rounditn(processchrg,2);
                //alert(parseFloat(txtprochrg.value))
                forsvc = parseFloat(txtclearchrg.value)+parseFloat(txtprochrg.value)+parseFloat(txtotchg.value);
                if(document.getElementById("ctl00_MyCPH1_OctDetails_svrtax_yn").checked==true)
                {
                    stax = (forsvc * 12) / 100;
                    txtstax.value=rounditn(stax,2);
                    grandtotal = grandtotal + stax; // Adding STAX to Grand Total
                    // Calculating CESS = 2 % of STAX
                        cess=(stax*2)/100;
                        txtcess.value=rounditn(cess,2);
                        grandtotal = grandtotal + cess;
            
                    //Calculating HCESS = 1 % of STAX
                        hcess=(stax*1)/100;
                        txthcess.value=rounditn(hcess,2);
                        grandtotal = grandtotal + hcess;
                }
                else
                {
                    txtstax.value="0.00"
                    txtcess.value="0.00"
                    txthcess.value="0.00"
                 }
                othr=parseFloat(txtotchg.value);
                grandtotal = grandtotal+othr;
                txttotalamt.value=rounditn(grandtotal,2);
                grandtotal2+=grandtotal;
                document.getElementById("ctl00_MyCPH1_txtBillAmt").value =rounditn(grandtotal2,2);
                //document.getElementById("ctl00_MyCPH1_h11").value = rounditn(grandtotal2,2);
             }
          }
     }
     
    function Porcess_Chrg_calc(Obj)
    {
        var txtoctamt=Obj.id;
        var txtprochrg_per=Obj.id;
        var txtprochrg=Obj.id;
         
        txtoctamt=txtoctamt.replace( "txtProPercent", "txtOctAmt");
        txtprochrg=txtprochrg.replace( "txtProPercent", "txtProChrg");
       // alert(document.getElementById(txtoctamt).value)
       // alert(document.getElementById(txtprochrg_per).value)
        processchrg=parseFloat(document.getElementById(txtoctamt).value) * parseFloat(document.getElementById(txtprochrg_per).value) / 100;
        //alert(processchrg)
        document.getElementById(txtprochrg).value=rounditn(processchrg,2)
        calc()
    }
   
function CheckData()
{
    var prefix = "ctl00_MyCPH1_";
    var txtBillDate = document.getElementById(prefix + "txtBillDate");
    var txtPartyCode = document.getElementById(prefix + "txtPartyCode");
    var txtBillSubAt = document.getElementById(prefix + "txtBillSubAt");
    var txtBillColAt = document.getElementById(prefix + "txtBillColAt");
    var txtDueDate = document.getElementById(prefix + "txtDueDate");
    var txtRemarks = document.getElementById(prefix + "txtRemarks");
    
    var server_dt=document.getElementById(FRM_NM+"Hnd_Server_dt").value;
    var MIn_dt=document.getElementById(FRM_NM+"Hnd_Mindate").value
    var Max_Date =document.getElementById(FRM_NM+"Hnd_Maxdate").value
    
    if(txtBillDate.value == "")
    {
        alert("Plz Enter The Bill Date");
        txtBillDate.focus();
        return false;
    }
    
    		    var dt =document.getElementById(FRM_NM+"txtBillDate").value
				var hdndockdt;
			    var Maxdt="01/01/2007";
			    var mTotalRecords = "<%=intTotalRecords %>";
			     Grid_Id="OctDetails_grvcontrols"
	             var grid=document.getElementById("ctl00_MyCPH1_"+Grid_Id);
                 var rows=grid.rows.length;  
                 //alert("hi...a")
                 var Check_One="N"
                 var Total_amount="0.00",NetAmt="0.00",TotalNetAmt="0.00"
                 var Total_adv_amt="0.00",Total_PendAmt="0.00"
                 var Total_billAmount="0"
                 Check_One="N"
                //alert("hi...1")
               for(var b=2;b<=rows-1;b++)
                  {
                     if(b<10)
                        GRID_FRM_NM="ctl00_MyCPH1_OctDetails_grvcontrols_ctl0" + b + "_";
                     else
                        GRID_FRM_NM="ctl00_MyCPH1_OctDetails_grvcontrols_ctl" + b + "_";
                        
                   if(document.getElementById(GRID_FRM_NM+"txtDockno")!="")
                   {
                     var Maxdt1 =Maxdt
    				 Check_One="Y"
				     var Maxdt_dd=Maxdt1.substring(0,2)
				     var Maxdt_mm=Maxdt1.substring(3,5)
				     var Maxdt_yy=Maxdt1.substring(6,10)
                      //  alert("hi...1")
		             var hdndockdt1 = document.getElementById(GRID_FRM_NM+"hdndockdt").value
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
                }
               //alert("hi...2")
               var dt =document.getElementById(FRM_NM+"txtBillDate").value
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
						document.getElementById(FRM_NM+"txtBillDate").focus();
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
						document.getElementById(FRM_NM+"txtBillDate").focus();
						return false;
				}
		
				if (dt>server_dt)
				{
						alert( "Bill date should not be greater than today's date !!!");
						document.getElementById(FRM_NM+"txtBillDate").focus();
						return false;
				}
					//alert("hi..")
		       /* if (dt<MIn_dt1)
				{
						    alert( "Bill Date Should  be Greater than "+ MIn_dt + " !!!");
						    document.getElementById(FRM_NM+"txtBillDate").focus();
						    return false;
				}
				if (dt>Max_Date1)
				{
						    alert( "Bill date should  be less than  "+ Max_Date + " !!!");
						    document.getElementById(FRM_NM+"txtBillDate").focus();
						    return false;
				}*/
				
				if(document.getElementById(FRM_NM+"txtDueDate").value=="")
				{
						alert("Please enter the Bill Due Date");
						document.getElementById(FRM_NM+"txtDueDate").focus();
						return false;
				}
				var bduedt  =document.getElementById(FRM_NM+"txtDueDate").value;
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
		//alert(dt)	
		//alert(bduedt1)	
		//alert(document.getElementById(FRM_NM+"Lbl_Credit_days").innerText)
	    var days=parseInt(document.getElementById(FRM_NM+"Lbl_Credit_days").innerText)
        dues=dateAdd('D',days,dt)
       // alert(dues)
		//alert(Datadate1(dues))
		//alert(Datadate1(bduedt1))
		if(Datadate1(bduedt1)!= Datadate1(dues)) 
		{
		    alert("Bill Due Date Should be Greater Than Bill Date as  "+ document.getElementById(FRM_NM+"Lbl_Credit_days").innerText + " Days")
		    document.getElementById(FRM_NM+"txtduedate").focus();
			return false ;
		}
    
    if(txtPartyCode.value == "")
    {
        alert("Plz Enter The Party Code");
        txtPartyCode.focus();
        return false;
    }
    if(txtBillSubAt.value == "")
    {
        alert("Plz Enter Bill The Submission Location");
        txtBillSubAt.focus();
        return false;
    }
    if(txtBillColAt.value == "")
    {
        alert("Plz Enter Bill The Collection Location");
        txtBillColAt.focus();
        return false;
    }
    if(txtDueDate.value == "")
    {
        alert("Plz Enter The Due Date");
        txtDueDate.focus();
        return false;
    }
    
    
    /*if(txtRemarks.value == "")
    {
        alert("Plz Enter The Remarks");
        txtRemarks.focus();
        return false;
    }*/
    //Code For Disable Text boxes
    document.getElementById("ctl00_MyCPH1_txtBillAmt").disabled=false;
    
    var tbl=document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols");
    var rows=tbl.rows.length;
    for(i = 2; i <= rows ; i++)
    {
        if(i<10)
        {
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl0" + i + "_txtDelVal").disabled=false;
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl0" + i + "_txtRecpno").disabled=false;
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl0" + i + "_txtRecpdt").disabled=false;
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl0" + i + "_txtOctper").disabled=false;
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl0" + i + "_txtProChrg").disabled=false;
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl0" + i + "_txtSvrTax").disabled=false;
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl0" + i + "_txtCess").disabled=false;
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl0" + i + "_txtHEduCess").disabled=false;
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl0" + i + "_txtTotal").disabled=false;
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl0" + i + "_txtOctAmt").disabled=false;
        }
        else
        {
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl" + i + "_txtDelVal").disabled=false;
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl" + i + "_txtOctAmt").disabled=false;
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl" + i + "_txtRecpno").disabled=false;
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl" + i + "_txtRecpdt").disabled=false;
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl" + i + "_txtOctper").disabled=false;
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl" + i + "_txtProChrg").disabled=false;
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl" + i + "_txtSvrTax").disabled=false;
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl" + i + "_txtCess").disabled=false;
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl" + i + "_txtHEduCess").disabled=false;
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl" + i + "_txtTotal").disabled=false;
        }
    }
    return true;
}   


function popuplist(mode,ctlid,tbl)
 {    
      var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
      var url="";
            url="../DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl ;
            confirmWin=window.open(url,"",winOpts);
      return false;
 }