var doc = null; 
var MyDiv = document.getElementById("RouteCodeCombo");
var formObj = null;
var MyDtOption=2;
var THC_Link_No="";
var MF_Link_No="";
var DktCount=0;

var secs
var timerID = null
var timerRunning = false
var delay = 1

var ArrivalFlag=false;
var GodownFlag =false;
var GodownNo=1;

function OpenInWindow2(windURL,h,w,l,t){
	var winOpts="scrollbars=yes,resizable=yes,width="+w+",height="+h+"";
	confirmWin=window.open(windURL,"my_window",winOpts);
	//popup = window.open(windURL,"popup","height=" + h + ",width=" + w + ",scrollbars=yes,left=" + l + ",top=" + t);
}


function InitializeTimer()
{
    // Set the length of the timer, in seconds
    secs = 1;
    findNoOfDkts();
    StopTheClock();
    StartTheTimer();
}

function StopTheClock()
{
    if(timerRunning)
        clearTimeout(timerID)
    timerRunning = false
}

function StartTheTimer()
{
    if (secs==0)
    {
		//alert(ArrivalFlag);
        StopTheClock();
        if(ArrivalFlag) {SetReceivingCondition();}
        if(GodownFlag)  {SetGodownCode();}
		ArrivalFlag=false;
		GodownFlag =false;
    }
    else
    {
        self.status = secs
        secs = secs - 1
        timerRunning = true
        timerID = self.setTimeout("StartTheTimer()", delay)
    }
}

	
	function createXMLHTTPObject(){
	    if (window.XMLHttpRequest) { // Mozilla, Safari,...
	        doc = new XMLHttpRequest();
	        if (doc.overrideMimeType) {
	            doc.overrideMimeType('text/xml');
	        }
	    } else if (window.ActiveXObject) { // IE
	        try {
	            doc = new ActiveXObject("Msxml2.XMLHTTP");
	        } catch (e) {
	            try {
	                doc = new ActiveXObject("Microsoft.XMLHTTP");
	            } catch (e) {}
	        }
	    }
	}
	
	
	var ArrivedDktRow="";
	var NotArrivedDktRow="";
	
	

	var fromDtStr = "";
	var toDtStr   = "";
	
	var dktNo = "";
	var THC_No = "";
	var MF_No = "";
	var Dest_Cd = "";
	var Search = "";
	
	var months = new Array("","January", "February", "March", "April", "May", "June",
"July", "August", "September", "October", "November", "December");

function MyDateDiff( start, end, interval, rounding ) {

    var iOut = 0;
    
    var bufferA = Date.parse( start ) ;
    var bufferB = Date.parse( end ) ;
    	
    // check that the start parameter is a valid Date. 
    if ( isNaN (bufferA) || isNaN (bufferB) ) {
        alert( startMsg ) ;
        return null ;
    }
	
    // check that an interval parameter was not numeric. 
    if ( interval.charAt == 'undefined' ) {
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

function ValidateForm(obj){
	if (isDate(obj.value)==false){
		obj.focus()
		return false
	}
    return true
 }

	function OnShowTrack(dockno,tabtype,arg){
		var dt = new Date();
		dktNo="";
		
	//alert(dockno)
	//alert(tabtype)
		MyDiv = document.getElementById("tab_div");
		createXMLHTTPObject();
		if (doc){ 	
			doc.onreadystatechange = doWork; 
			doc.open("GET", "./tracking_type.asp?Search="+tabtype+"&dockno="+dockno+"&RandText="+arg, false);
			doc.send(null);
		}	
	}
	
	function SetReceivingCondition(){
		//alert(DktCount);
		for(k=1;k<DktCount+1;k++){
			eval('document.frm.txtArrivalCondition'+k).value=document.frm.hArrivalCond.value;
		}
		return true;
	}

	function SetGodownCode(){
		//findNoOfDkts();
		for(k=1;k<DktCount+1;k++){
			eval('document.frm.txtGodown'+GodownNo+'_'+k).value=document.frm.hGodown.value;
		}
		return true;
	}

	function findNoOfDkts(){
		DktCount=0;
		for(i=1;i<1000;i++) {
			if (typeof eval('document.frm.txtArrivalCondition'+i) == "undefined") {
			        break;
			} else {
				DktCount=DktCount+1;
			}
		}	
	}

	
	function MyDateCompare(startDt,endDt){
		var startDtArr;
		var endDtArr;
		
		startDtArr = startDt.split('/');
		endDtArr   = endDt.split('/');
		
		var myStartDt = new Date(startDtArr[2],startDtArr[1]-1,startDtArr[0]);
		var myEndDt   = new Date(endDtArr[2],endDtArr[1]-1,endDtArr[0]);
		var dtDiff    = myEndDt.getTime()-myStartDt.getTime();
		
		dtDiff = dtDiff/86400000;
		return dtDiff;
	}

	var fromDtStr = "";
	var toDtStr   = "";

	function CheckFromToDate(){
		//alert('here_there');
		fromDtStr = Trim(document.frm.txtFromDt.value);
		toDtStr   = Trim(document.frm.txtToDt.value);
		
		
		if(fromDtStr!='' && toDtStr!=''){
			//From Date
			if(isDate(fromDtStr)){
				var fromDtArr = fromDtStr.split('/');
			} else {
				return false;
			}
		
			//To Date
			if(isDate(toDtStr)){	
				var toDtArr   = toDtStr.split('/')
			} else {
				return false;
			}
		
			var fromDt = new Date(fromDtArr[2],fromDtArr[1]-1,fromDtArr[0]);
			var toDt   = new Date(toDtArr[2],toDtArr[1]-1,toDtArr[0]);

			//Date Difference
			var dtDiff    = toDt.getTime()-fromDt.getTime();
		
			if(dtDiff<0){//From Dt> To Date
				alert('From Date > To Date :(');
				return false;		
			}
		
			return true;
		} else {
			return false;
		}
		
	}

	function doWork() {
	    if (doc.readyState == 4) {
				MyDiv.innerHTML = doc.responseText;
	    }
	}
	
	function fshow(){  
		display('ProcessIndiacator');
		hidden('ProcessIndiacatorSubmit');
	}

	function display(viewShow) {
		if (document.layers) {
			content = document.layers[viewShow];
		}
		else if (document.all) {
			content = document.all(viewShow).style;
		}
		content.visibility = 'visible';
	}

	function hidden(viewShow) {
		//alert(viewShow)
		if (document.layers) {
			content = document.layers[viewShow];
		}
		else if (document.all) {
			content = document.all(viewShow).style;
		}
		content.visibility = 'hidden';
	}

	var beforePkg=0;
	
	function validatePkgs(obj,arg){
		var totPkgs=0;
		var sumPkgs = 0;
		
		if(Trim(obj.value)==''){
			alert('Pkg No. cannot be empty :(');
			obj.value = beforePkg;
			return false;
		}
		
		if(isNaN(Trim(obj.value))){
			alert('Invalid Pkg No. :(');
			obj.value = beforePkg;
			return false;
		}
		
		//alert('test');
		totPkgs=parseInt(eval('document.frm.hPkg'+arg).value);
		sumPkgs = parseInt(eval('document.frm.txtPkgs1_'+arg).value) + parseInt(eval('document.frm.txtPkgs2_'+arg).value) + parseInt(eval('document.frm.txtPkgs3_'+arg).value) + parseInt(eval('document.frm.txtPkgs4_'+arg).value) + parseInt(eval('document.frm.txtPkgs5_'+arg).value);
		if(sumPkgs>totPkgs){
			alert('Sum of Pkgs distributed accross godowns > actual pkgs no. :(');
			obj.value = beforePkg;
			return false;
		}
		return true;
	}
	
	function xlsSubmit(){
		document.frmPrn.hInnerHTML.value=document.frmPrn.innerHTML;
		document.frmPrn.action="excel_result.asp";
		document.frmPrn.method="post";
		document.frmPrn.submit();
	}
	
	function emailSubmit(){
		document.frmPrn.hInnerHTML.value=document.frmPrn.innerHTML;
		document.frmPrn.action="email.asp";
		document.frmPrn.method="post";
		document.frmPrn.target = "_new";
		document.frmPrn.submit();
	}

document.onmouseover = doOver;
document.onmouseout  = doOut;
document.onmousedown = doDown;
document.onmouseup   = doUp;


function doOver() {
	var toEl = getReal(window.event.toElement, "className", "coolButton");
	var fromEl = getReal(window.event.fromElement, "className", "coolButton");
	if (toEl == fromEl) return;
	var el = toEl;
	
//	alert(el);
	
//	var cDisabled = el.getAttribute("cDisabled");
	var cDisabled = el.cDisabled;
//	alert(cDisabled);
	cDisabled = (cDisabled != null); // If CDISABLED atribute is present
	
	if (el.className == "coolButton")
		el.onselectstart = new Function("return false");
	
	if ((el.className == "coolButton") && !cDisabled) {
		makeRaised(el);
		makeGray(el,false);
	}
}

function doOut() {
	var toEl = getReal(window.event.toElement, "className", "coolButton");
	var fromEl = getReal(window.event.fromElement, "className", "coolButton");
	if (toEl == fromEl) return;
	var el = fromEl;

//	var cDisabled = el.getAttribute("cDisabled");
	var cDisabled = el.cDisabled;
	cDisabled = (cDisabled != null); // If CDISABLED atribute is present

	var cToggle = el.cToggle;
	toggle_disabled = (cToggle != null); // If CTOGGLE atribute is present

	if (cToggle && el.value) {
		makePressed(el);
		makeGray(el,true);
	}
	else if ((el.className == "coolButton") && !cDisabled) {
		makeFlat(el);
		makeGray(el,true);
	}

}

function doDown() {
	el = getReal(window.event.srcElement, "className", "coolButton");
	
	var cDisabled = el.cDisabled;
	cDisabled = (cDisabled != null); // If CDISABLED atribute is present
	
	if ((el.className == "coolButton") && !cDisabled) {
		makePressed(el)
	}
}

function doUp() {
	el = getReal(window.event.srcElement, "className", "coolButton");
	
	var cDisabled = el.cDisabled;
	cDisabled = (cDisabled != null); // If CDISABLED atribute is present
	
	if ((el.className == "coolButton") && !cDisabled) {
		makeRaised(el);
	}
}


function getReal(el, type, value) {
	temp = el;
	while ((temp != null) && (temp.tagName != "BODY")) {
		if (eval("temp." + type) == value) {
			el = temp;
			return el;
		}
		temp = temp.parentElement;
	}
	return el;
}

function findChildren(el, type, value) {
	var children = el.children;
	var tmp = new Array();
	var j=0;
	
	for (var i=0; i<children.length; i++) {
		if (eval("children[i]." + type + "==\"" + value + "\"")) {
			tmp[tmp.length] = children[i];
		}
		tmp = tmp.concat(findChildren(children[i], type, value));
	}
	
	return tmp;
}

function disable(el) {

	if (document.readyState != "complete") {
		window.setTimeout("disable(" + el.id + ")", 100);	// If document not finished rendered try later.
		return;
	}
	
	var cDisabled = el.cDisabled;
	
	cDisabled = (cDisabled != null); // If CDISABLED atribute is present

	if (!cDisabled) {
		el.cDisabled = true;
		
		el.innerHTML = '<span style="background: buttonshadow; width: 100%; height: 100%; text-align: center;">' +
						'<span style="filter:Mask(Color=buttonface) DropShadow(Color=buttonhighlight, OffX=1, OffY=1, Positive=0); height: 100%; width: 100%%; text-align: center;">' +
						el.innerHTML +
						'</span>' +
						'</span>';

		if (el.onclick != null) {
			el.cDisabled_onclick = el.onclick;
			el.onclick = null;
		}
	}
}

function enable(el) {
	var cDisabled = el.cDisabled;
	
	cDisabled = (cDisabled != null); // If CDISABLED atribute is present
	
	if (cDisabled) {
		el.cDisabled = null;
		el.innerHTML = el.children[0].children[0].innerHTML;

		if (el.cDisabled_onclick != null) {
			el.onclick = el.cDisabled_onclick;
			el.cDisabled_onclick = null;
		}
	}
}

function addToggle(el) {
	var cDisabled = el.cDisabled;
	
	cDisabled = (cDisabled != null); // If CDISABLED atribute is present
	
	var cToggle = el.cToggle;
	
	cToggle = (cToggle != null); // If CTOGGLE atribute is present

	if (!cToggle && !cDisabled) {
		el.cToggle = true;
		
		if (el.value == null)
			el.value = 0;		// Start as not pressed down
		
		if (el.onclick != null)
			el.cToggle_onclick = el.onclick;	// Backup the onclick
		else 
			el.cToggle_onclick = "";

		el.onclick = new Function("toggle(" + el.id +"); " + el.id + ".cToggle_onclick();");
	}
}

function removeToggle(el) {
	var cDisabled = el.cDisabled;
	
	cDisabled = (cDisabled != null); // If CDISABLED atribute is present
	
	var cToggle = el.cToggle;
	
	cToggle = (cToggle != null); // If CTOGGLE atribute is present
	
	if (cToggle && !cDisabled) {
		el.cToggle = null;

		if (el.value) {
			toggle(el);
		}

		makeFlat(el);
		
		if (el.cToggle_onclick != null) {
			el.onclick = el.cToggle_onclick;
			el.cToggle_onclick = null;
		}
	}
}

function toggle(el) {
	el.value = !el.value;
	
	if (el.value)
		el.style.background = "URL(/images/tileback.gif)";
	else
		el.style.backgroundImage = "";

//	doOut(el);	
}


function makeFlat(el) {
	with (el.style) {
		background = "";
		border = "1px solid buttonface";
		padding      = "1px";
	}
}

function makeRaised(el) {
	with (el.style) {
		borderLeft   = "1px solid buttonhighlight";
		borderRight  = "1px solid buttonshadow";
		borderTop    = "1px solid buttonhighlight";
		borderBottom = "1px solid buttonshadow";
		padding      = "1px";
	}
}

function makePressed(el) {
	with (el.style) {
		borderLeft   = "1px solid buttonshadow";
		borderRight  = "1px solid buttonhighlight";
		borderTop    = "1px solid buttonshadow";
		borderBottom = "1px solid buttonhighlight";
		paddingTop    = "2px";
		paddingLeft   = "2px";
		paddingBottom = "0px";
		paddingRight  = "0px";
	}
}

function makeGray(el,b) {
	var filtval;
	
	if (b)
		filtval = "gray()";
	else
		filtval = "";

	var imgs = findChildren(el, "tagName", "IMG");
		
	for (var i=0; i<imgs.length; i++) {
		imgs[i].style.filter = filtval;
	}

}
	
	var buttontarget=""

function change(e, color){
var el=window.event? event.srcElement: e.target

el.style.backgroundColor=color
}

document.write("<style>");
document.write(".coolBar	{background: buttonface;border-top: 2px solid buttonhighlight;	border-left: 2px solid buttonhighlight;	border-bottom: 2px solid buttonshadow; border-right: 2px solid buttonshadow; padding: 2px; font: menu;background-color:gray}");
document.write(".coolButton {border: 2px solid buttonface; padding: 2px; text-align: center; cursor: default; font-weight:bold;background-color:blue}");
document.write(".coolButton IMG	{filter: gray();}");
document.write("</style>");