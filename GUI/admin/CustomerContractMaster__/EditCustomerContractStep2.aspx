<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="EditCustomerContractStep2.aspx.cs" Inherits="EditCustomerContractStep2" EnableEventValidation="false" %>
<%@ OutputCache Location="none" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script language="javascript" type="text/javascript">
            
            // JScript File

function disableenter()
        {
        
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
            
            // ===================================================================
// Author: Matt Kruse <matt@mattkruse.com>
// WWW: http://www.mattkruse.com/
//
// NOTICE: You may use this code for any purpose, commercial or
// private, without any further permission from the author. You may
// remove this notice from your final code if you wish, however it is
// appreciated by the author if at least my web site address is kept.
//
// You may *NOT* re-distribute this code in any way except through its
// use. That means, you can include it in your product, or your web
// site, or any other form where the code is actually being used. You
// may not put the plain javascript up on your site for download or
// include it in your javascript libraries for download. 
// If you wish to share this code with others, please just point them
// to the URL instead.
// Please DO NOT link directly to my .js files from your site. Copy
// the files to your server and use them there. Thank you.
// ===================================================================

/* SOURCE FILE: AnchorPosition.js */
function getAnchorPosition(anchorname){var useWindow=false;var coordinates=new Object();var x=0,y=0;var use_gebi=false, use_css=false, use_layers=false;if(document.getElementById){use_gebi=true;}else if(document.all){use_css=true;}else if(document.layers){use_layers=true;}if(use_gebi && document.all){x=AnchorPosition_getPageOffsetLeft(document.all[anchorname]);y=AnchorPosition_getPageOffsetTop(document.all[anchorname]);}else if(use_gebi){var o=document.getElementById(anchorname);x=AnchorPosition_getPageOffsetLeft(o);y=AnchorPosition_getPageOffsetTop(o);}else if(use_css){x=AnchorPosition_getPageOffsetLeft(document.all[anchorname]);y=AnchorPosition_getPageOffsetTop(document.all[anchorname]);}else if(use_layers){var found=0;for(var i=0;i<document.anchors.length;i++){if(document.anchors[i].name==anchorname){found=1;break;}}if(found==0){coordinates.x=0;coordinates.y=0;return coordinates;}x=document.anchors[i].x;y=document.anchors[i].y;}else{coordinates.x=0;coordinates.y=0;return coordinates;}coordinates.x=x;coordinates.y=y;return coordinates;}
function getAnchorWindowPosition(anchorname){var coordinates=getAnchorPosition(anchorname);var x=0;var y=0;if(document.getElementById){if(isNaN(window.screenX)){x=coordinates.x-document.body.scrollLeft+window.screenLeft;y=coordinates.y-document.body.scrollTop+window.screenTop;}else{x=coordinates.x+window.screenX+(window.outerWidth-window.innerWidth)-window.pageXOffset;y=coordinates.y+window.screenY+(window.outerHeight-24-window.innerHeight)-window.pageYOffset;}}else if(document.all){x=coordinates.x-document.body.scrollLeft+window.screenLeft;y=coordinates.y-document.body.scrollTop+window.screenTop;}else if(document.layers){x=coordinates.x+window.screenX+(window.outerWidth-window.innerWidth)-window.pageXOffset;y=coordinates.y+window.screenY+(window.outerHeight-24-window.innerHeight)-window.pageYOffset;}coordinates.x=x;coordinates.y=y;return coordinates;}
function AnchorPosition_getPageOffsetLeft(el){var ol=el.offsetLeft;while((el=el.offsetParent) != null){ol += el.offsetLeft;}return ol;}
function AnchorPosition_getWindowOffsetLeft(el){return AnchorPosition_getPageOffsetLeft(el)-document.body.scrollLeft;}
function AnchorPosition_getPageOffsetTop(el){var ot=el.offsetTop;while((el=el.offsetParent) != null){ot += el.offsetTop;}return ot;}
function AnchorPosition_getWindowOffsetTop(el){return AnchorPosition_getPageOffsetTop(el)-document.body.scrollTop;}

/* SOURCE FILE: date.js */
var MONTH_NAMES=new Array('January','February','March','April','May','June','July','August','September','October','November','December','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');var DAY_NAMES=new Array('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sun','Mon','Tue','Wed','Thu','Fri','Sat');
function LZ(x){return(x<0||x>9?"":"0")+x}
function isDate(val,format){var date=getDateFromFormat(val,format);if(date==0){return false;}return true;}
function compareDates(date1,dateformat1,date2,dateformat2){var d1=getDateFromFormat(date1,dateformat1);var d2=getDateFromFormat(date2,dateformat2);if(d1==0 || d2==0){return -1;}else if(d1 > d2){return 1;}return 0;}
function formatDate(date,format){format=format+"";var result="";var i_format=0;var c="";var token="";var y=date.getYear()+"";var M=date.getMonth()+1;var d=date.getDate();var E=date.getDay();var H=date.getHours();var m=date.getMinutes();var s=date.getSeconds();var yyyy,yy,MMM,MM,dd,hh,h,mm,ss,ampm,HH,H,KK,K,kk,k;var value=new Object();if(y.length < 4){y=""+(y-0+1900);}value["y"]=""+y;value["yyyy"]=y;value["yy"]=y.substring(2,4);value["M"]=M;value["MM"]=LZ(M);value["MMM"]=MONTH_NAMES[M-1];value["NNN"]=MONTH_NAMES[M+11];value["d"]=d;value["dd"]=LZ(d);value["E"]=DAY_NAMES[E+7];value["EE"]=DAY_NAMES[E];value["H"]=H;value["HH"]=LZ(H);if(H==0){value["h"]=12;}else if(H>12){value["h"]=H-12;}else{value["h"]=H;}value["hh"]=LZ(value["h"]);if(H>11){value["K"]=H-12;}else{value["K"]=H;}value["k"]=H+1;value["KK"]=LZ(value["K"]);value["kk"]=LZ(value["k"]);if(H > 11){value["a"]="PM";}else{value["a"]="AM";}value["m"]=m;value["mm"]=LZ(m);value["s"]=s;value["ss"]=LZ(s);while(i_format < format.length){c=format.charAt(i_format);token="";while((format.charAt(i_format)==c) &&(i_format < format.length)){token += format.charAt(i_format++);}if(value[token] != null){result=result + value[token];}else{result=result + token;}}return result;}
function _isInteger(val){var digits="1234567890";for(var i=0;i < val.length;i++){if(digits.indexOf(val.charAt(i))==-1){return false;}}return true;}
function _getInt(str,i,minlength,maxlength){for(var x=maxlength;x>=minlength;x--){var token=str.substring(i,i+x);if(token.length < minlength){return null;}if(_isInteger(token)){return token;}}return null;}
function getDateFromFormat(val,format){val=val+"";format=format+"";var i_val=0;var i_format=0;var c="";var token="";var token2="";var x,y;var now=new Date();var year=now.getYear();var month=now.getMonth()+1;var date=1;var hh=now.getHours();var mm=now.getMinutes();var ss=now.getSeconds();var ampm="";while(i_format < format.length){c=format.charAt(i_format);token="";while((format.charAt(i_format)==c) &&(i_format < format.length)){token += format.charAt(i_format++);}if(token=="yyyy" || token=="yy" || token=="y"){if(token=="yyyy"){x=4;y=4;}if(token=="yy"){x=2;y=2;}if(token=="y"){x=2;y=4;}year=_getInt(val,i_val,x,y);if(year==null){return 0;}i_val += year.length;if(year.length==2){if(year > 70){year=1900+(year-0);}else{year=2000+(year-0);}}}else if(token=="MMM"||token=="NNN"){month=0;for(var i=0;i<MONTH_NAMES.length;i++){var month_name=MONTH_NAMES[i];if(val.substring(i_val,i_val+month_name.length).toLowerCase()==month_name.toLowerCase()){if(token=="MMM"||(token=="NNN"&&i>11)){month=i+1;if(month>12){month -= 12;}i_val += month_name.length;break;}}}if((month < 1)||(month>12)){return 0;}}else if(token=="EE"||token=="E"){for(var i=0;i<DAY_NAMES.length;i++){var day_name=DAY_NAMES[i];if(val.substring(i_val,i_val+day_name.length).toLowerCase()==day_name.toLowerCase()){i_val += day_name.length;break;}}}else if(token=="MM"||token=="M"){month=_getInt(val,i_val,token.length,2);if(month==null||(month<1)||(month>12)){return 0;}i_val+=month.length;}else if(token=="dd"||token=="d"){date=_getInt(val,i_val,token.length,2);if(date==null||(date<1)||(date>31)){return 0;}i_val+=date.length;}else if(token=="hh"||token=="h"){hh=_getInt(val,i_val,token.length,2);if(hh==null||(hh<1)||(hh>12)){return 0;}i_val+=hh.length;}else if(token=="HH"||token=="H"){hh=_getInt(val,i_val,token.length,2);if(hh==null||(hh<0)||(hh>23)){return 0;}i_val+=hh.length;}else if(token=="KK"||token=="K"){hh=_getInt(val,i_val,token.length,2);if(hh==null||(hh<0)||(hh>11)){return 0;}i_val+=hh.length;}else if(token=="kk"||token=="k"){hh=_getInt(val,i_val,token.length,2);if(hh==null||(hh<1)||(hh>24)){return 0;}i_val+=hh.length;hh--;}else if(token=="mm"||token=="m"){mm=_getInt(val,i_val,token.length,2);if(mm==null||(mm<0)||(mm>59)){return 0;}i_val+=mm.length;}else if(token=="ss"||token=="s"){ss=_getInt(val,i_val,token.length,2);if(ss==null||(ss<0)||(ss>59)){return 0;}i_val+=ss.length;}else if(token=="a"){if(val.substring(i_val,i_val+2).toLowerCase()=="am"){ampm="AM";}else if(val.substring(i_val,i_val+2).toLowerCase()=="pm"){ampm="PM";}else{return 0;}i_val+=2;}else{if(val.substring(i_val,i_val+token.length)!=token){return 0;}else{i_val+=token.length;}}}if(i_val != val.length){return 0;}if(month==2){if( ((year%4==0)&&(year%100 != 0) ) ||(year%400==0) ){if(date > 29){return 0;}}else{if(date > 28){return 0;}}}if((month==4)||(month==6)||(month==9)||(month==11)){if(date > 30){return 0;}}if(hh<12 && ampm=="PM"){hh=hh-0+12;}else if(hh>11 && ampm=="AM"){hh-=12;}var newdate=new Date(year,month-1,date,hh,mm,ss);return newdate.getTime();}
function parseDate(val){var preferEuro=(arguments.length==2)?arguments[1]:false;generalFormats=new Array('y-M-d','MMM d, y','MMM d,y','y-MMM-d','d-MMM-y','MMM d');monthFirst=new Array('M/d/y','M-d-y','M.d.y','MMM-d','M/d','M-d');dateFirst =new Array('d/M/y','d-M-y','d.M.y','d-MMM','d/M','d-M');var checkList=new Array('generalFormats',preferEuro?'dateFirst':'monthFirst',preferEuro?'monthFirst':'dateFirst');var d=null;for(var i=0;i<checkList.length;i++){var l=window[checkList[i]];for(var j=0;j<l.length;j++){d=getDateFromFormat(val,l[j]);if(d!=0){return new Date(d);}}}return null;}

/* SOURCE FILE: PopupWindow.js */
function PopupWindow_getXYPosition(anchorname){var coordinates;if(this.type == "WINDOW"){coordinates = getAnchorWindowPosition(anchorname);}else{coordinates = getAnchorPosition(anchorname);}this.x = coordinates.x;this.y = coordinates.y;}
function PopupWindow_setSize(width,height){this.width = width;this.height = height;}
function PopupWindow_populate(contents){this.contents = contents;this.populated = false;}
function PopupWindow_setUrl(url){this.url = url;}
function PopupWindow_setWindowProperties(props){this.windowProperties = props;}
function PopupWindow_refresh(){if(this.divName != null){if(this.use_gebi){document.getElementById(this.divName).innerHTML = this.contents;}else if(this.use_css){document.all[this.divName].innerHTML = this.contents;}else if(this.use_layers){var d = document.layers[this.divName];d.document.open();d.document.writeln(this.contents);d.document.close();}}else{if(this.popupWindow != null && !this.popupWindow.closed){if(this.url!=""){this.popupWindow.location.href=this.url;}else{this.popupWindow.document.open();this.popupWindow.document.writeln(this.contents);this.popupWindow.document.close();}this.popupWindow.focus();}}}
function PopupWindow_showPopup(anchorname){this.getXYPosition(anchorname);this.x += this.offsetX;this.y += this.offsetY;if(!this.populated &&(this.contents != "")){this.populated = true;this.refresh();}if(this.divName != null){if(this.use_gebi){document.getElementById(this.divName).style.left = this.x + "px";document.getElementById(this.divName).style.top = this.y + "px";document.getElementById(this.divName).style.visibility = "visible";}else if(this.use_css){document.all[this.divName].style.left = this.x;document.all[this.divName].style.top = this.y;document.all[this.divName].style.visibility = "visible";}else if(this.use_layers){document.layers[this.divName].left = this.x;document.layers[this.divName].top = this.y;document.layers[this.divName].visibility = "visible";}}else{if(this.popupWindow == null || this.popupWindow.closed){if(this.x<0){this.x=0;}if(this.y<0){this.y=0;}if(screen && screen.availHeight){if((this.y + this.height) > screen.availHeight){this.y = screen.availHeight - this.height;}}if(screen && screen.availWidth){if((this.x + this.width) > screen.availWidth){this.x = screen.availWidth - this.width;}}var avoidAboutBlank = window.opera ||( document.layers && !navigator.mimeTypes['*']) || navigator.vendor == 'KDE' ||( document.childNodes && !document.all && !navigator.taintEnabled);this.popupWindow = window.open(avoidAboutBlank?"":"about:blank","window_"+anchorname,this.windowProperties+",width="+this.width+",height="+this.height+",screenX="+this.x+",left="+this.x+",screenY="+this.y+",top="+this.y+"");}this.refresh();}}
function PopupWindow_hidePopup(){if(this.divName != null){if(this.use_gebi){document.getElementById(this.divName).style.visibility = "hidden";}else if(this.use_css){document.all[this.divName].style.visibility = "hidden";}else if(this.use_layers){document.layers[this.divName].visibility = "hidden";}}else{if(this.popupWindow && !this.popupWindow.closed){this.popupWindow.close();this.popupWindow = null;}}}
function PopupWindow_isClicked(e){if(this.divName != null){if(this.use_layers){var clickX = e.pageX;var clickY = e.pageY;var t = document.layers[this.divName];if((clickX > t.left) &&(clickX < t.left+t.clip.width) &&(clickY > t.top) &&(clickY < t.top+t.clip.height)){return true;}else{return false;}}else if(document.all){var t = window.event.srcElement;while(t.parentElement != null){if(t.id==this.divName){return true;}t = t.parentElement;}return false;}else if(this.use_gebi && e){var t = e.originalTarget;while(t.parentNode != null){if(t.id==this.divName){return true;}t = t.parentNode;}return false;}return false;}return false;}
function PopupWindow_hideIfNotClicked(e){if(this.autoHideEnabled && !this.isClicked(e)){this.hidePopup();}}
function PopupWindow_autoHide(){this.autoHideEnabled = true;}
function PopupWindow_hidePopupWindows(e){for(var i=0;i<popupWindowObjects.length;i++){if(popupWindowObjects[i] != null){var p = popupWindowObjects[i];p.hideIfNotClicked(e);}}}
function PopupWindow_attachListener(){if(document.layers){document.captureEvents(Event.MOUSEUP);}window.popupWindowOldEventListener = document.onmouseup;if(window.popupWindowOldEventListener != null){document.onmouseup = new Function("window.popupWindowOldEventListener();PopupWindow_hidePopupWindows();");}else{document.onmouseup = PopupWindow_hidePopupWindows;}}
function PopupWindow(){if(!window.popupWindowIndex){window.popupWindowIndex = 0;}if(!window.popupWindowObjects){window.popupWindowObjects = new Array();}if(!window.listenerAttached){window.listenerAttached = true;PopupWindow_attachListener();}this.index = popupWindowIndex++;popupWindowObjects[this.index] = this;this.divName = null;this.popupWindow = null;this.width=0;this.height=0;this.populated = false;this.visible = false;this.autoHideEnabled = false;this.contents = "";this.url="";this.windowProperties="toolbar=no,location=no,status=no,menubar=no,scrollbars=auto,resizable,alwaysRaised,dependent,titlebar=no";if(arguments.length>0){this.type="DIV";this.divName = arguments[0];}else{this.type="WINDOW";}this.use_gebi = false;this.use_css = false;this.use_layers = false;if(document.getElementById){this.use_gebi = true;}else if(document.all){this.use_css = true;}else if(document.layers){this.use_layers = true;}else{this.type = "WINDOW";}this.offsetX = 0;this.offsetY = 0;this.getXYPosition = PopupWindow_getXYPosition;this.populate = PopupWindow_populate;this.setUrl = PopupWindow_setUrl;this.setWindowProperties = PopupWindow_setWindowProperties;this.refresh = PopupWindow_refresh;this.showPopup = PopupWindow_showPopup;this.hidePopup = PopupWindow_hidePopup;this.setSize = PopupWindow_setSize;this.isClicked = PopupWindow_isClicked;this.autoHide = PopupWindow_autoHide;this.hideIfNotClicked = PopupWindow_hideIfNotClicked;}


/* SOURCE FILE: CalendarPopup.js */

function CalendarPopup(){var c;if(arguments.length>0){c = new PopupWindow(arguments[0]);}else{c = new PopupWindow();c.setSize(150,175);}c.offsetX = -90;c.offsetY = 25;c.autoHide();c.monthNames = new Array("January","February","March","April","May","June","July","August","September","October","November","December");c.monthAbbreviations = new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");c.dayHeaders = new Array("S","M","T","W","T","F","S");c.returnFunction = "CP_tmpReturnFunction";c.returnMonthFunction = "CP_tmpReturnMonthFunction";c.returnQuarterFunction = "CP_tmpReturnQuarterFunction";c.returnYearFunction = "CP_tmpReturnYearFunction";c.weekStartDay = 0;c.isShowYearNavigation = false;c.displayType = "date";c.disabledWeekDays = new Object();c.disabledDatesExpression = "";c.yearSelectStartOffset = 35;c.currentDate = null;c.todayText="Today";c.cssPrefix="";c.isShowNavigationDropdowns=false;c.isShowYearNavigationInput=false;window.CP_calendarObject = null;window.CP_targetInput = null;window.CP_dateFormat = "MM/dd/yyyy";c.copyMonthNamesToWindow = CP_copyMonthNamesToWindow;c.setReturnFunction = CP_setReturnFunction;c.setReturnMonthFunction = CP_setReturnMonthFunction;c.setReturnQuarterFunction = CP_setReturnQuarterFunction;c.setReturnYearFunction = CP_setReturnYearFunction;c.setMonthNames = CP_setMonthNames;c.setMonthAbbreviations = CP_setMonthAbbreviations;c.setDayHeaders = CP_setDayHeaders;c.setWeekStartDay = CP_setWeekStartDay;c.setDisplayType = CP_setDisplayType;c.setDisabledWeekDays = CP_setDisabledWeekDays;c.addDisabledDates = CP_addDisabledDates;c.setYearSelectStartOffset = CP_setYearSelectStartOffset;c.setTodayText = CP_setTodayText;c.showYearNavigation = CP_showYearNavigation;c.showCalendar = CP_showCalendar;c.hideCalendar = CP_hideCalendar;c.getStyles = getCalendarStyles;c.refreshCalendar = CP_refreshCalendar;c.getCalendar = CP_getCalendar;c.select = CP_select;c.setCssPrefix = CP_setCssPrefix;c.showNavigationDropdowns = CP_showNavigationDropdowns;c.showYearNavigationInput = CP_showYearNavigationInput;c.copyMonthNamesToWindow();return c;}
function CP_copyMonthNamesToWindow(){if(typeof(window.MONTH_NAMES)!="undefined" && window.MONTH_NAMES!=null){window.MONTH_NAMES = new Array();for(var i=0;i<this.monthNames.length;i++){window.MONTH_NAMES[window.MONTH_NAMES.length] = this.monthNames[i];}for(var i=0;i<this.monthAbbreviations.length;i++){window.MONTH_NAMES[window.MONTH_NAMES.length] = this.monthAbbreviations[i];}}}
function CP_tmpReturnFunction(y,m,d){if(window.CP_targetInput!=null){var dt = new Date(y,m-1,d,0,0,0);if(window.CP_calendarObject!=null){window.CP_calendarObject.copyMonthNamesToWindow();}window.CP_targetInput.value = formatDate(dt,window.CP_dateFormat);}else{alert('Use setReturnFunction() to define which function will get the clicked results!');}}
function CP_tmpReturnMonthFunction(y,m){alert('Use setReturnMonthFunction() to define which function will get the clicked results!\nYou clicked: year='+y+' , month='+m);}
function CP_tmpReturnQuarterFunction(y,q){alert('Use setReturnQuarterFunction() to define which function will get the clicked results!\nYou clicked: year='+y+' , quarter='+q);}
function CP_tmpReturnYearFunction(y){alert('Use setReturnYearFunction() to define which function will get the clicked results!\nYou clicked: year='+y);}
function CP_setReturnFunction(name){this.returnFunction = name;}
function CP_setReturnMonthFunction(name){this.returnMonthFunction = name;}
function CP_setReturnQuarterFunction(name){this.returnQuarterFunction = name;}
function CP_setReturnYearFunction(name){this.returnYearFunction = name;}
function CP_setMonthNames(){for(var i=0;i<arguments.length;i++){this.monthNames[i] = arguments[i];}this.copyMonthNamesToWindow();}
function CP_setMonthAbbreviations(){for(var i=0;i<arguments.length;i++){this.monthAbbreviations[i] = arguments[i];}this.copyMonthNamesToWindow();}
function CP_setDayHeaders(){for(var i=0;i<arguments.length;i++){this.dayHeaders[i] = arguments[i];}}
function CP_setWeekStartDay(day){this.weekStartDay = day;}
function CP_showYearNavigation(){this.isShowYearNavigation =(arguments.length>0)?arguments[0]:true;}
function CP_setDisplayType(type){if(type!="date"&&type!="week-end"&&type!="month"&&type!="quarter"&&type!="year"){alert("Invalid display type! Must be one of: date,week-end,month,quarter,year");return false;}this.displayType=type;}
function CP_setYearSelectStartOffset(num){this.yearSelectStartOffset=num;}
function CP_setDisabledWeekDays(){this.disabledWeekDays = new Object();for(var i=0;i<arguments.length;i++){this.disabledWeekDays[arguments[i]] = true;}}
function CP_addDisabledDates(start, end){if(arguments.length==1){end=start;}if(start==null && end==null){return;}if(this.disabledDatesExpression!=""){this.disabledDatesExpression+= "||";}if(start!=null){start = parseDate(start);start=""+start.getFullYear()+LZ(start.getMonth()+1)+LZ(start.getDate());}if(end!=null){end=parseDate(end);end=""+end.getFullYear()+LZ(end.getMonth()+1)+LZ(end.getDate());}if(start==null){this.disabledDatesExpression+="(ds<="+end+")";}else if(end  ==null){this.disabledDatesExpression+="(ds>="+start+")";}else{this.disabledDatesExpression+="(ds>="+start+"&&ds<="+end+")";}}
function CP_setTodayText(text){this.todayText = text;}
function CP_setCssPrefix(val){this.cssPrefix = val;}
function CP_showNavigationDropdowns(){this.isShowNavigationDropdowns =(arguments.length>0)?arguments[0]:true;}
function CP_showYearNavigationInput(){this.isShowYearNavigationInput =(arguments.length>0)?arguments[0]:true;}
function CP_hideCalendar(){if(arguments.length > 0){window.popupWindowObjects[arguments[0]].hidePopup();}else{this.hidePopup();}}
function CP_refreshCalendar(index){var calObject = window.popupWindowObjects[index];if(arguments.length>1){calObject.populate(calObject.getCalendar(arguments[1],arguments[2],arguments[3],arguments[4],arguments[5]));}else{calObject.populate(calObject.getCalendar());}calObject.refresh();}
function CP_showCalendar(anchorname){if(arguments.length>1){if(arguments[1]==null||arguments[1]==""){this.currentDate=new Date();}else{this.currentDate=new Date(parseDate(arguments[1]));}}this.populate(this.getCalendar());this.showPopup(anchorname);}
function CP_select(inputobj, linkname, format){var selectedDate=(arguments.length>3)?arguments[3]:null;if(!window.getDateFromFormat){alert("calendar.select: To use this method you must also include 'date.js' for date formatting");return;}if(this.displayType!="date"&&this.displayType!="week-end"){alert("calendar.select: This function can only be used with displayType 'date' or 'week-end'");return;}if(inputobj.type!="text" && inputobj.type!="hidden" && inputobj.type!="textarea"){alert("calendar.select: Input object passed is not a valid form input object");window.CP_targetInput=null;return;}if(inputobj.disabled){return;}window.CP_targetInput = inputobj;window.CP_calendarObject = this;this.currentDate=null;var time=0;if(selectedDate!=null){time = getDateFromFormat(selectedDate,format)}else if(inputobj.value!=""){time = getDateFromFormat(inputobj.value,format);}if(selectedDate!=null || inputobj.value!=""){if(time==0){this.currentDate=null;}else{this.currentDate=new Date(time);}}window.CP_dateFormat = format;this.showCalendar(linkname);}
function getCalendarStyles(){var result = "";var p = "";if(this!=null && typeof(this.cssPrefix)!="undefined" && this.cssPrefix!=null && this.cssPrefix!=""){p=this.cssPrefix;}result += "<STYLE>\n";result += "."+p+"cpYearNavigation,."+p+"cpMonthNavigation{background-color:#C0C0C0;text-align:center;vertical-align:center;text-decoration:none;color:#000000;font-weight:bold;}\n";result += "."+p+"cpDayColumnHeader, ."+p+"cpYearNavigation,."+p+"cpMonthNavigation,."+p+"cpCurrentMonthDate,."+p+"cpCurrentMonthDateDisabled,."+p+"cpOtherMonthDate,."+p+"cpOtherMonthDateDisabled,."+p+"cpCurrentDate,."+p+"cpCurrentDateDisabled,."+p+"cpTodayText,."+p+"cpTodayTextDisabled,."+p+"cpText{font-family:arial;font-size:8pt;}\n";result += "TD."+p+"cpDayColumnHeader{text-align:right;border:solid thin #C0C0C0;border-width:0px 0px 1px 0px;}\n";result += "."+p+"cpCurrentMonthDate, ."+p+"cpOtherMonthDate, ."+p+"cpCurrentDate{text-align:right;text-decoration:none;}\n";result += "."+p+"cpCurrentMonthDateDisabled, ."+p+"cpOtherMonthDateDisabled, ."+p+"cpCurrentDateDisabled{color:#D0D0D0;text-align:right;text-decoration:line-through;}\n";result += "."+p+"cpCurrentMonthDate, .cpCurrentDate{color:#000000;}\n";result += "."+p+"cpOtherMonthDate{color:#808080;}\n";result += "TD."+p+"cpCurrentDate{color:white;background-color: #C0C0C0;border-width:1px;border:solid thin #800000;}\n";result += "TD."+p+"cpCurrentDateDisabled{border-width:1px;border:solid thin #FFAAAA;}\n";result += "TD."+p+"cpTodayText, TD."+p+"cpTodayTextDisabled{border:solid thin #C0C0C0;border-width:1px 0px 0px 0px;}\n";result += "A."+p+"cpTodayText, SPAN."+p+"cpTodayTextDisabled{height:20px;}\n";result += "A."+p+"cpTodayText{color:black;}\n";result += "."+p+"cpTodayTextDisabled{color:#D0D0D0;}\n";result += "."+p+"cpBorder{border:solid thin #808080;}\n";result += "</STYLE>\n";return result;}
function CP_getCalendar(){var now = new Date();if(this.type == "WINDOW"){var windowref = "window.opener.";}else{var windowref = "";}var result = "";if(this.type == "WINDOW"){result += "<HTML><HEAD><TITLE>Calendar</TITLE>"+this.getStyles()+"</HEAD><BODY MARGINWIDTH=0 MARGINHEIGHT=0 TOPMARGIN=0 RIGHTMARGIN=0 LEFTMARGIN=0>\n";result += '<CENTER><TABLE WIDTH=100% BORDER=0 BORDERWIDTH=0 CELLSPACING=0 CELLPADDING=0>\n';}else{result += '<TABLE CLASS="'+this.cssPrefix+'cpBorder" WIDTH=144 BORDER=1 BORDERWIDTH=1 CELLSPACING=0 CELLPADDING=1>\n';result += '<TR><TD ALIGN=CENTER>\n';result += '<CENTER>\n';}if(this.displayType=="date" || this.displayType=="week-end"){if(this.currentDate==null){this.currentDate = now;}if(arguments.length > 0){var month = arguments[0];}else{var month = this.currentDate.getMonth()+1;}if(arguments.length > 1 && arguments[1]>0 && arguments[1]-0==arguments[1]){var year = arguments[1];}else{var year = this.currentDate.getFullYear();}var daysinmonth= new Array(0,31,28,31,30,31,30,31,31,30,31,30,31);if( ((year%4 == 0)&&(year%100 != 0) ) ||(year%400 == 0) ){daysinmonth[2] = 29;}var current_month = new Date(year,month-1,1);var display_year = year;var display_month = month;var display_date = 1;var weekday= current_month.getDay();var offset = 0;offset =(weekday >= this.weekStartDay) ? weekday-this.weekStartDay : 7-this.weekStartDay+weekday ;if(offset > 0){display_month--;if(display_month < 1){display_month = 12;display_year--;}display_date = daysinmonth[display_month]-offset+1;}var next_month = month+1;var next_month_year = year;if(next_month > 12){next_month=1;next_month_year++;}var last_month = month-1;var last_month_year = year;if(last_month < 1){last_month=12;last_month_year--;}var date_class;if(this.type!="WINDOW"){result += "<TABLE WIDTH=144 BORDER=0 BORDERWIDTH=0 CELLSPACING=0 CELLPADDING=0>";}result += '<TR>\n';var refresh = windowref+'CP_refreshCalendar';var refreshLink = 'javascript:' + refresh;if(this.isShowNavigationDropdowns){result += '<TD CLASS="'+this.cssPrefix+'cpMonthNavigation" WIDTH="78" COLSPAN="3"><select CLASS="'+this.cssPrefix+'cpMonthNavigation" name="cpMonth" onChange="'+refresh+'('+this.index+',this.options[this.selectedIndex].value-0,'+(year-0)+');">';for( var monthCounter=1;monthCounter<=12;monthCounter++){var selected =(monthCounter==month) ? 'SELECTED' : '';result += '<option value="'+monthCounter+'" '+selected+'>'+this.monthNames[monthCounter-1]+'</option>';}result += '</select></TD>';result += '<TD CLASS="'+this.cssPrefix+'cpMonthNavigation" WIDTH="10">&nbsp;</TD>';result += '<TD CLASS="'+this.cssPrefix+'cpYearNavigation" WIDTH="56" COLSPAN="3"><select CLASS="'+this.cssPrefix+'cpYearNavigation" name="cpYear" onChange="'+refresh+'('+this.index+','+month+',this.options[this.selectedIndex].value-0);">';for( var yearCounter=year-this.yearSelectStartOffset;yearCounter<=year+this.yearSelectStartOffset;yearCounter++){var selected =(yearCounter==year) ? 'SELECTED' : '';result += '<option value="'+yearCounter+'" '+selected+'>'+yearCounter+'</option>';}result += '</select></TD>';}else{if(this.isShowYearNavigation){result += '<TD CLASS="'+this.cssPrefix+'cpMonthNavigation" WIDTH="10"><A CLASS="'+this.cssPrefix+'cpMonthNavigation" HREF="'+refreshLink+'('+this.index+','+last_month+','+last_month_year+');">&lt;</A></TD>';result += '<TD CLASS="'+this.cssPrefix+'cpMonthNavigation" WIDTH="58"><SPAN CLASS="'+this.cssPrefix+'cpMonthNavigation">'+this.monthNames[month-1]+'</SPAN></TD>';result += '<TD CLASS="'+this.cssPrefix+'cpMonthNavigation" WIDTH="10"><A CLASS="'+this.cssPrefix+'cpMonthNavigation" HREF="'+refreshLink+'('+this.index+','+next_month+','+next_month_year+');">&gt;</A></TD>';result += '<TD CLASS="'+this.cssPrefix+'cpMonthNavigation" WIDTH="10">&nbsp;</TD>';result += '<TD CLASS="'+this.cssPrefix+'cpYearNavigation" WIDTH="10"><A CLASS="'+this.cssPrefix+'cpYearNavigation" HREF="'+refreshLink+'('+this.index+','+month+','+(year-1)+');">&lt;</A></TD>';if(this.isShowYearNavigationInput){result += '<TD CLASS="'+this.cssPrefix+'cpYearNavigation" WIDTH="36"><INPUT NAME="cpYear" CLASS="'+this.cssPrefix+'cpYearNavigation" SIZE="4" MAXLENGTH="4" VALUE="'+year+'" onBlur="'+refresh+'('+this.index+','+month+',this.value-0);"></TD>';}else{result += '<TD CLASS="'+this.cssPrefix+'cpYearNavigation" WIDTH="36"><SPAN CLASS="'+this.cssPrefix+'cpYearNavigation">'+year+'</SPAN></TD>';}result += '<TD CLASS="'+this.cssPrefix+'cpYearNavigation" WIDTH="10"><A CLASS="'+this.cssPrefix+'cpYearNavigation" HREF="'+refreshLink+'('+this.index+','+month+','+(year+1)+');">&gt;</A></TD>';}else{result += '<TD CLASS="'+this.cssPrefix+'cpMonthNavigation" WIDTH="22"><A CLASS="'+this.cssPrefix+'cpMonthNavigation" HREF="'+refreshLink+'('+this.index+','+last_month+','+last_month_year+');">&lt;&lt;</A></TD>\n';result += '<TD CLASS="'+this.cssPrefix+'cpMonthNavigation" WIDTH="100"><SPAN CLASS="'+this.cssPrefix+'cpMonthNavigation">'+this.monthNames[month-1]+' '+year+'</SPAN></TD>\n';result += '<TD CLASS="'+this.cssPrefix+'cpMonthNavigation" WIDTH="22"><A CLASS="'+this.cssPrefix+'cpMonthNavigation" HREF="'+refreshLink+'('+this.index+','+next_month+','+next_month_year+');">&gt;&gt;</A></TD>\n';}}result += '</TR></TABLE>\n';result += '<TABLE WIDTH=120 BORDER=0 CELLSPACING=0 CELLPADDING=1 ALIGN=CENTER>\n';result += '<TR>\n';for(var j=0;j<7;j++){result += '<TD CLASS="'+this.cssPrefix+'cpDayColumnHeader" WIDTH="14%"><SPAN CLASS="'+this.cssPrefix+'cpDayColumnHeader">'+this.dayHeaders[(this.weekStartDay+j)%7]+'</TD>\n';}result += '</TR>\n';for(var row=1;row<=6;row++){result += '<TR>\n';for(var col=1;col<=7;col++){var disabled=false;if(this.disabledDatesExpression!=""){var ds=""+display_year+LZ(display_month)+LZ(display_date);eval("disabled=("+this.disabledDatesExpression+")");}var dateClass = "";if((display_month == this.currentDate.getMonth()+1) &&(display_date==this.currentDate.getDate()) &&(display_year==this.currentDate.getFullYear())){dateClass = "cpCurrentDate";}else if(display_month == month){dateClass = "cpCurrentMonthDate";}else{dateClass = "cpOtherMonthDate";}if(disabled || this.disabledWeekDays[col-1]){result += '	<TD CLASS="'+this.cssPrefix+dateClass+'"><SPAN CLASS="'+this.cssPrefix+dateClass+'Disabled">'+display_date+'</SPAN></TD>\n';}else{var selected_date = display_date;var selected_month = display_month;var selected_year = display_year;if(this.displayType=="week-end"){var d = new Date(selected_year,selected_month-1,selected_date,0,0,0,0);d.setDate(d.getDate() +(7-col));selected_year = d.getYear();if(selected_year < 1000){selected_year += 1900;}selected_month = d.getMonth()+1;selected_date = d.getDate();}result += '	<TD CLASS="'+this.cssPrefix+dateClass+'"><A HREF="javascript:'+windowref+this.returnFunction+'('+selected_year+','+selected_month+','+selected_date+');'+windowref+'CP_hideCalendar(\''+this.index+'\');" CLASS="'+this.cssPrefix+dateClass+'">'+display_date+'</A></TD>\n';}display_date++;if(display_date > daysinmonth[display_month]){display_date=1;display_month++;}if(display_month > 12){display_month=1;display_year++;}}result += '</TR>';}var current_weekday = now.getDay() - this.weekStartDay;if(current_weekday < 0){current_weekday += 7;}result += '<TR>\n';result += '	<TD COLSPAN=7 ALIGN=CENTER CLASS="'+this.cssPrefix+'cpTodayText">\n';if(this.disabledDatesExpression!=""){var ds=""+now.getFullYear()+LZ(now.getMonth()+1)+LZ(now.getDate());eval("disabled=("+this.disabledDatesExpression+")");}if(disabled || this.disabledWeekDays[current_weekday+1]){result += '		<SPAN CLASS="'+this.cssPrefix+'cpTodayTextDisabled">'+this.todayText+'</SPAN>\n';}else{result += '		<A CLASS="'+this.cssPrefix+'cpTodayText" HREF="javascript:'+windowref+this.returnFunction+'(\''+now.getFullYear()+'\',\''+(now.getMonth()+1)+'\',\''+now.getDate()+'\');'+windowref+'CP_hideCalendar(\''+this.index+'\');">'+this.todayText+'</A>\n';}result += '		<BR>\n';result += '	</TD></TR></TABLE></CENTER></TD></TR></TABLE>\n';}if(this.displayType=="month" || this.displayType=="quarter" || this.displayType=="year"){if(arguments.length > 0){var year = arguments[0];}else{if(this.displayType=="year"){var year = now.getFullYear()-this.yearSelectStartOffset;}else{var year = now.getFullYear();}}if(this.displayType!="year" && this.isShowYearNavigation){result += "<TABLE WIDTH=144 BORDER=0 BORDERWIDTH=0 CELLSPACING=0 CELLPADDING=0>";result += '<TR>\n';result += '	<TD CLASS="'+this.cssPrefix+'cpYearNavigation" WIDTH="22"><A CLASS="'+this.cssPrefix+'cpYearNavigation" HREF="javascript:'+windowref+'CP_refreshCalendar('+this.index+','+(year-1)+');">&lt;&lt;</A></TD>\n';result += '	<TD CLASS="'+this.cssPrefix+'cpYearNavigation" WIDTH="100">'+year+'</TD>\n';result += '	<TD CLASS="'+this.cssPrefix+'cpYearNavigation" WIDTH="22"><A CLASS="'+this.cssPrefix+'cpYearNavigation" HREF="javascript:'+windowref+'CP_refreshCalendar('+this.index+','+(year+1)+');">&gt;&gt;</A></TD>\n';result += '</TR></TABLE>\n';}}if(this.displayType=="month"){result += '<TABLE WIDTH=120 BORDER=0 CELLSPACING=1 CELLPADDING=0 ALIGN=CENTER>\n';for(var i=0;i<4;i++){result += '<TR>';for(var j=0;j<3;j++){var monthindex =((i*3)+j);result += '<TD WIDTH=33% ALIGN=CENTER><A CLASS="'+this.cssPrefix+'cpText" HREF="javascript:'+windowref+this.returnMonthFunction+'('+year+','+(monthindex+1)+');'+windowref+'CP_hideCalendar(\''+this.index+'\');" CLASS="'+date_class+'">'+this.monthAbbreviations[monthindex]+'</A></TD>';}result += '</TR>';}result += '</TABLE></CENTER></TD></TR></TABLE>\n';}if(this.displayType=="quarter"){result += '<BR><TABLE WIDTH=120 BORDER=1 CELLSPACING=0 CELLPADDING=0 ALIGN=CENTER>\n';for(var i=0;i<2;i++){result += '<TR>';for(var j=0;j<2;j++){var quarter =((i*2)+j+1);result += '<TD WIDTH=50% ALIGN=CENTER><BR><A CLASS="'+this.cssPrefix+'cpText" HREF="javascript:'+windowref+this.returnQuarterFunction+'('+year+','+quarter+');'+windowref+'CP_hideCalendar(\''+this.index+'\');" CLASS="'+date_class+'">Q'+quarter+'</A><BR><BR></TD>';}result += '</TR>';}result += '</TABLE></CENTER></TD></TR></TABLE>\n';}if(this.displayType=="year"){var yearColumnSize = 4;result += "<TABLE WIDTH=144 BORDER=0 BORDERWIDTH=0 CELLSPACING=0 CELLPADDING=0>";result += '<TR>\n';result += '	<TD CLASS="'+this.cssPrefix+'cpYearNavigation" WIDTH="50%"><A CLASS="'+this.cssPrefix+'cpYearNavigation" HREF="javascript:'+windowref+'CP_refreshCalendar('+this.index+','+(year-(yearColumnSize*2))+');">&lt;&lt;</A></TD>\n';result += '	<TD CLASS="'+this.cssPrefix+'cpYearNavigation" WIDTH="50%"><A CLASS="'+this.cssPrefix+'cpYearNavigation" HREF="javascript:'+windowref+'CP_refreshCalendar('+this.index+','+(year+(yearColumnSize*2))+');">&gt;&gt;</A></TD>\n';result += '</TR></TABLE>\n';result += '<TABLE WIDTH=120 BORDER=0 CELLSPACING=1 CELLPADDING=0 ALIGN=CENTER>\n';for(var i=0;i<yearColumnSize;i++){for(var j=0;j<2;j++){var currentyear = year+(j*yearColumnSize)+i;result += '<TD WIDTH=50% ALIGN=CENTER><A CLASS="'+this.cssPrefix+'cpText" HREF="javascript:'+windowref+this.returnYearFunction+'('+currentyear+');'+windowref+'CP_hideCalendar(\''+this.index+'\');" CLASS="'+date_class+'">'+currentyear+'</A></TD>';}result += '</TR>';}result += '</TABLE></CENTER></TD></TR></TABLE>\n';}if(this.type == "WINDOW"){result += "</BODY></HTML>\n";}return result;}


            
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
            
            function VolumetricChecked(objVolumetric)
            {
                if(document.getElementById("ctl00_MyCPH1_trTSVolumetricChecked"))
                {
                    if(objVolumetric.checked == true)
                    {
                        document.getElementById("ctl00_MyCPH1_trTSVolumetricChecked").style.display = '';
                    }
                    else
                    {
                        document.getElementById("ctl00_MyCPH1_trTSVolumetricChecked").style.display = 'none';
                    }
                }
            }
            
            function DACCChecked(objDACC)
            {
                if(document.getElementById("ctl00_MyCPH1_trTSDACCChecked"))
                {
                    var mDACCApplicableYN = "<%=blnAppForCODDOD %>"
                
                    if (mDACCApplicableYN == "Y")
                    {
                        if(objDACC.checked == true)
                        {
                            document.getElementById("ctl00_MyCPH1_trTSDACCChecked").style.display = '';
                        }
                        else
                        {
                            document.getElementById("ctl00_MyCPH1_trTSDACCChecked").style.display = 'none';
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
                        if(document.getElementById("ctl00_MyCPH1_ddlFOVType").value == "-1")
                        {
                            alert("Please select 'FOV Type' from the list");
                            document.getElementById("ctl00_MyCPH1_ddlFOVType").focus();
                            return false;
                        }
                    }
                    
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
                    }
                }
                
                return true;
            }
            
        </script>
           
            <%--<asp:ScriptManager ID="scManager" runat="server">
            </asp:ScriptManager>--%>
        
            <div>
                
                <input type="hidden" id="HidRandomNo" runat="server" />
                
                <input type="hidden" id="HidCustCode" runat="server" />
                <input type="hidden" id="HidContractID" runat="server" />
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
                
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    
                    <tr>
			            <td>
				            <label class="blackfnt">
				                <b>
				                    Customer Contract Master - Edit Existing Contract				            
				                </b>
				                <hr align="center" size="1" color="#8ba0e5">
				            </label>    
			            </td>
		            </tr>
                    
                    <tr>
                        <td> 
                            <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
    	                        <%--<tr>
                                    <td height="30">
                                        <a href="../../../welcome.asp">
                                            <label class="blklnkund">
                                                <strong>--%>
                                                    <%--<%=Session["Level_Type"]%>--%> <%--Module
                                                </strong>
                                            </label>
                                        </a>
                                        		  
	                                    <strong>
	                                         &gt; 
	                                    </strong>
    	                                
	                                    <a href="../../menu.asp">
	                                        <label class="blklnkund">
	                                            <strong>
	                                                Administrator 
	                                            </strong>
	                                        </label>
	                                    </a>

	                                    <strong>
	                                         &gt; 
	                                    </strong>
    	                                
	                                    <a href="../../menu_lists.asp?FA">
	                                        <label class="blklnkund">
	                                            <strong>
	                                                Finance & Accounts
	                                            </strong>
	                                        </label>
	                                    </a>
    	                                
	                                    <strong>
	                                         &gt; 
	                                    </strong>
    	                                
	                                    <a href="CustContract.asp">
	                                        <label class="blklnkund">
	                                            <strong>
	                                                Customer Contract Master
	                                            </strong>
	                                        </label>
	                                    </a>

	                                    <strong>
	                                         &gt; 
	                                    </strong>
    	                                
	                                    <label class="bluefnt">
	                                        <strong>
	                                            New Contract
	                                        </strong>
	                                    </label>
	                                </td>
                                </tr>
                                
                                <tr> 
                                    <td align="right">
                                        <a href="javascript:window.history.go(-1)" title="back">
                                            <img src="../../../GUI/images/back.gif" border="0" />
                                        </a>
                                    </td>
                                </tr>--%>
                                
                                <tr> 
                                    <td>
                                        <br /> 
                                                
                                        <table valign="top" width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td width="39%" valign="top">
                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td valign="top">
                                                                <table border="0" cellpadding="2" width="90%" 
                                                                    cellspacing="1" align="center" class="boxbg">
                                                                    <tr style="background-color: White">
                                                                        <td colspan="6" align="left">
                                                                            <label class="blackfnt">
                                                                                <b>
                                                                                    &nbsp;Step 2: Summary of Charges
                                                                                </b>
                                                                            </label>
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                    <tr> 
                                                                        <td style="background-color: White">
                                                                            <label class="blackfnt">
                                                                                &nbsp;Mode of Transport:
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td style="background-color: White">
                                                                            <input type="checkbox" id="chkMTAir" runat="server" 
                                                                                style="margin-left: 1px;" />
                                                                            <label class="blackfnt" id="lblMTAir" runat="server">
                                                                                <%=strModeOfTransportAir%>
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td style="background-color: White">
                                                                            <input type="checkbox" id="chkMTRoad" runat="server" 
                                                                                style="margin-left: 1px;" />
                                                                            <label class="blackfnt" id="lblMTRoad" runat="server">
                                                                                <%=strModeOfTransportRoad%>
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td style="background-color: White" >
                                                                            <input type="checkbox" id="chkMTTrain" runat="server" 
                                                                                style="margin-left: 1px;" />
                                                                            <label class="blackfnt" id="lblMTTrain" runat="server">
                                                                                <%=strModeOfTransportTrain%>
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td style="background-color: White" colspan="2">
                                                                            <input type="checkbox" id="chkMTExpress" runat="server" 
                                                                                style="margin-left: 1px;" />
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
                                                                            <input type="checkbox" id="chkTLFTL" runat="server" 
                                                                                style="margin-left: 1px;" />
                                                                            <label class="blackfnt" id="lblTLFTL" runat="server">
                                                                                <%=strTypeOfLoadServiceNo2 %>
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td style="background-color: White" colspan="4">
                                                                            <input type="checkbox" id="chkTLSundry" runat="server" 
                                                                                style="margin-left: 1px;" />
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
                                                                        
                                                                        <%--<td style="background-color: White" colspan="5">
                                                                            &nbsp;
                                                                            <asp:ListBox ID="lstPickupDel" SelectionMode="Multiple" runat="server">
                                                                                <asp:ListItem Selected="True" Text="Select" Value="-1"></asp:ListItem>
                                                                                <asp:ListItem Selected="False" Text="Godown-Door" Value="Godown-Door"></asp:ListItem>
                                                                                <asp:ListItem Selected="False" Text="Godown-Godown" Value="Godown-Godown"></asp:ListItem>
                                                                                <asp:ListItem Selected="False" Text="Door-Door" Value="Door-Door"></asp:ListItem>
                                                                                <asp:ListItem Selected="False" Text="Door-Godown" Value="Door-Godown"></asp:ListItem>
                                                                            </asp:ListBox> 
                                                                        </td>--%>
                                                                        
                                                                        <td style="background-color: White">
                                                                            <input type="checkbox" id="chkGD" runat="server" 
                                                                                style="margin-left: 1px;" />
                                                                            <label class="blackfnt" runat="server">
                                                                                 Godown-Door
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td style="background-color: White">
                                                                            <input type="checkbox" id="chkGG" runat="server" 
                                                                                style="margin-left: 1px;" />
                                                                            <label class="blackfnt" runat="server">
                                                                                Godown-Godown
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td style="background-color: White" >
                                                                            <input type="checkbox" id="chkDD" runat="server" 
                                                                                style="margin-left: 1px;" />
                                                                            <label class="blackfnt" runat="server">
                                                                                Door-Door
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td style="background-color: White" colspan="2">
                                                                            <input type="checkbox" id="chkDG" runat="server" 
                                                                                style="margin-left: 1px;" />
                                                                            <label class="blackfnt" runat="server">
                                                                                Door-Godown
                                                                            </label>
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                    <%--Table row for Applicabl_yn_dp_chrg="Y"--%>                                   
                                                                    <%--For Door Pickup Charge--%>
                                                                    <tr id="trDoorPickupCharge" runat="server" visible="false"  style="background-color: White">
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
                                                                            <input id="txtDoorPickupCharge" type="text" size="10"  
                                                                                maxlength="8" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                style="margin-left: 5px;" runat="server" />
                                                                        </td>
                                                                        
                                                                        <td>
                                                                            <label class="blackfnt">
                                                                                &nbsp;Rate/Kg.:
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td colspan="2">
                                                                            <input id="txtDoorPickupChargePerKg" type="text" size="10"  
                                                                                maxlength="8" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                style="margin-left: 5px;" runat="server" />
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                    <%--Table row for Applicabl_yn_dp_chrg="N"--%>
                                                                    <%--manage hidden variables - see CustomerContractStep1a.asp file--%>
                                                                    
                                                                    <%--Table row for Applicabl_yn_dd_chrg="Y"--%>
                                                                    <%--For Door Delivery Charge--%>
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
                                                                            <input id="txtDoorDeliveryCharge" type="text" size="10"   
                                                                                maxlength="8" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                style="margin-left: 5px;" runat="server" />
                                                                        </td>
                                                                        
                                                                        <td>
                                                                            <label class="blackfnt">
                                                                                &nbsp;Rate/Kg.:
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td colspan="2">
                                                                            <input id="txtDoorDeliveryChargePerKg" type="text" size="10"  
                                                                                maxlength="8" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                style="margin-left: 5px;" runat="server" />
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                    <%--Table row for Applicabl_yn_dd_chrg="N"--%>
                                                                    <%--manage hidden variables - see CustomerContractStep1a.asp file--%>
                                                                    
                                                                    <%--Table row for Applicabl_yn_fov="Y"--%>
                                                                    <%--For FOV Charge--%>
                                                                    <tr style="background-color: White" id="trFOVCharge" runat="server" visible="false"> 
			                                                            <td>
			                                                                <label class="blackfnt">
			                                                                    &nbsp;FOV Type:
			                                                                </label>
			                                                            </td>
    							                                        
			                                                            <td>
			                                                                <label style="margin-left: 5px;">
			                                                                </label>
			                                                                <asp:DropDownList ID="ddlFOVType" runat="server" CssClass="blackfnt">
			                                                                    <asp:ListItem Selected="True" Text="Select" Value="-1"></asp:ListItem>
			                                                                    <asp:ListItem Selected="False" Text="RS" Value="RS."></asp:ListItem>
			                                                                    <asp:ListItem Selected="False" Text="%" Value="% of Invoice"></asp:ListItem>
			                                                                </asp:DropDownList>
			                                                            </td>
    							                                        
			                                                            <td>
			                                                                <label class="blackfnt">
			                                                                    &nbsp;FOV Rate:
			                                                                </label>
			                                                            </td>
    							                                        
			                                                            <td colspan="4">
			                                                                <input id="txtFOVCharge" type="text" size="10" 
                                                                                maxlength="8" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                style="margin-left: 5px;" runat="server" />
                                                                        </td>
		                                                            </tr>
    						                                        
		                                                            <%--Table row for Applicabl_yn_fov="N"--%>
                                                                    <%--Manage hidden columns--%>
                                                                    
                                                                    <%--Table row for Insurance Percentage--%>
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
                                                                            <input id="txtInsPer" type="text" size="10"  
                                                                                maxlength="8" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                style="margin-left: 5px;" runat="server" />
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                    <%--Table row for Type of Service--%>
                                                                    <tr>
                                                                        <td style="background-color: White">
                                                                            <label class="blackfnt">
                                                                                &nbsp;Type of Service:
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td style="background-color: White">
                                                                                    <%--<input type="checkbox" id="chkTSCODDOD" runat="server" 
                                                                                        style="margin-left: 4px;" 
                                                                                        onclick="Javascript:CODDODChecked(this)" />--%>
                                                                            <asp:CheckBox ID="chkTSCODDOD" runat="server" AutoPostBack="true" 
                                                                                OnCheckedChanged="chkTSCODDOD_CheckedChanged" style="margin-left: 1px;" />
                                                                            <label class="blackfnt">
                                                                                COD/DOD
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td style="background-color: White">
                                                                            <input type="checkbox" id="chkTSODA" runat="server" 
                                                                                style="margin-left: 1px;" />
                                                                            <label class="blackfnt">
                                                                                ODA
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td style="background-color: White">
                                                                            <%--<input type="checkbox" id="chkTSVolumetric" runat="server" 
                                                                                style="margin-left: 4px;" 
                                                                                onclick="Javascript:VolumetricChecked(this)" />--%>
                                                                            <asp:CheckBox ID="chkTSVolumetric" runat="server" AutoPostBack="true" 
                                                                                    OnCheckedChanged="chkTSVolumetric_CheckedChanged" style="margin-left: 1px;" />
                                                                            <label class="blackfnt">
                                                                                Volumetric
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td style="background-color: White" colspan="2" valign="top">
                                                                            <%--<input type="checkbox" id="chkTSDACC" runat="server" 
                                                                                style="margin-left: 4px;" 
                                                                                onclick="Javascript:DACCChecked(this)" />--%>
                                                                            <asp:CheckBox ID="chkTSDACC" runat="server" AutoPostBack="true" 
                                                                                    OnCheckedChanged="chkTSDACC_CheckedChanged" style="margin-left: 1px;" />
                                                                            <label class="blackfnt">
                                                                                DACC
                                                                            </label>
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                    <%--Table row for COD-DOD (Type of Service) checkbox checked--%>
                                                                    <tr id="trTSCODChecked" runat="server" visible="false" style="background-color: White">
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
                    									                                <input id="txtCODCharge" type="text" size="10" class="input" 
                                                                                            maxlength="8" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
                    									                            </td>
                                                									
		                                                                            <td>
		                                                                                <label class="blackfnt">
		                                                                                    &nbsp;% of Amount:
		                                                                                </label>
		                                                                            </td>
    								                                                
		                                                                            <td>						                                                                
		                                                                                <input id="txtCODChargePer" type="text" size="10" class="input" 
                                                                                            maxlength="8" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
		                                                                            </td>
		                                                                        </tr>
				                                                                
                                                                            </table>
                                                                        </td>
                                                                    </tr>       
                                                                    
                                                                    <%--Table row for Volumetric (Type of Service) checkbox checked--%>
                                                                    <tr id="trTSVolumetricChecked" runat="server" visible="false">
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
                                                                                        <input id="txtCFTToKg" type="text" size="10" class="input" 
                                                                                            maxlength="8" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
                                                                                    </td>
				                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                    <%--Table row for DACC (Type of Service) checkbox checked--%>
                                                                    <tr id="trTSDACCChecked" runat="server" style="background-color: White" visible="false">
                                                                        <td colspan="6">
                                                                            <table width="100%" border="1" class="boxbg" cellspacing="0" cellpadding="3" bgcolor="#999999">
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
				                                                                        <input id="txtDACCChargeRs" type="text" size="10" class="input" 
                                                                                            maxlength="8" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
                                                                                    </td>
                                                                                    
				                                                                    <td>
				                                                                        <label class="blackfnt">
				                                                                            &nbsp;% of Freight:
				                                                                        </label>
				                                                                    </td>
    								                                                
				                                                                    <td>
				                                                                        <input id="txtDACCChargePer" type="text" size="10" class="input"  
                                                                                            maxlength="8" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
				                                                                    </td>           
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                    <%--Table row for Demurrage after days--%>
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
                                                                    
                                                                    <%--Table row for Applicabl_yn_dem="Y"--%>
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
                                                                            <input id="txtDemChargeRs" type="text" size="10" 
                                                                                maxlength="8" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                style="margin-left: 5px;" runat="server" />
                                                                        </td>
                                                                        
                                                                        <td>
                                                                            <label class="blackfnt">
                                                                                &nbsp;Per Kg.:
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td colspan="2">
                                                                            <input id="txtDemChargePerKg" type="text" size="10"  
                                                                                maxlength="8" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                style="margin-left: 5px;" runat="server" />
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                    <%--Table row for Bill Generation Location--%>
                                                                    <tr style="background-color: White">
                                                                        <td>
                                                                            <label class="blackfnt">
                                                                                &nbsp;Bill Generation at Location:
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td>
                                                                            <asp:UpdatePanel ID="upBillGenLoc" runat="server">
                                                                                <ContentTemplate>
                                                                                    <asp:TextBox ID="txtBillGen" runat="server" CssClass="input" 
                                                                                        MaxLength="50" Width="40px" AutoPostBack="true" style="margin-left: 5px;"
                                                                                        OnTextChanged="txtBillGen_TextChanged">
                                                                                    </asp:TextBox>
                                                                                    <br />
                                                                                    <label class="blackfnt" id="lblErrorBillGenLocation" runat="server" style="color: Red; margin-left: 5px;" visible="false">
                                                                                        Invalid location code!!!
                                                                                    </label>        
                                                                                </ContentTemplate>
                                                                                <Triggers>
                                                                                    <asp:AsyncPostBackTrigger ControlID="txtBillGen" EventName="TextChanged" />
                                                                                </Triggers>
                                                                            </asp:UpdatePanel>
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
                                                                    
                                                                    <%--Table row for Bill Submission Location--%>
                                                                    <tr style="background-color: White">
                                                                        <td>
                                                                            <label class="blackfnt">
                                                                                &nbsp;Bill Submission at Location:
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td>
                                                                            <asp:UpdatePanel ID="upBillSubLoc" runat="server">
                                                                                <ContentTemplate>
                                                                                    <asp:TextBox ID="txtBillSubLocation" runat="server" CssClass="input" 
                                                                                        MaxLength="50" Width="40px" AutoPostBack="true" style="margin-left: 5px;" 
                                                                                        OnTextChanged="txtBillSubLocation_TextChanged">
                                                                                    </asp:TextBox>
                                                                                    <br />
                                                                                    <label class="blackfnt" id="lblErrorBillSubLocation" runat="server" style="color: Red; margin-left: 5px;" visible="false" >
                                                                                        Invalid location code!!!
                                                                                    </label>  
                                                                                </ContentTemplate>
                                                                                <Triggers>
                                                                                    <asp:AsyncPostBackTrigger ControlID="txtBillSubLocation" EventName="TextChanged" />
                                                                                </Triggers>
                                                                            </asp:UpdatePanel>  
                                                                        </td>
                                                                        
                                                                        <td colspan="3">
                                                                            <label class="blackfnt">
                                                                                &nbsp;Total credit limit Rs.:
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td>
                                                                            <input id="txtCreditLimit" type="text" size="10"  
                                                                                maxlength="8" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                style="margin-left: 5px;" runat="server" />
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                    <%--Table row for Bill Collection Location--%>
                                                                    <tr style="background-color: White">
                                                                        <td>
                                                                            <label class="blackfnt">
                                                                                &nbsp;Bill Collection at Location:
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td>
                                                                            <asp:UpdatePanel ID="upBillCollLoc" runat="server">
                                                                                <ContentTemplate>
                                                                                    <asp:TextBox ID="txtBillCollLocation" runat="server" CssClass="input" 
                                                                                        MaxLength="50" Width="40px" AutoPostBack="true" style="margin-left: 5px;"
                                                                                        OnTextChanged="txtBillCollLocation_TextChanged">
                                                                                    </asp:TextBox>
                                                                                    <br />
                                                                                    <label class="blackfnt" id="lblErrorBillCollLocation" runat="server" style="color: Red; margin-left: 5px;" visible="false">
                                                                                        Invalid location code!!!
                                                                                    </label>
                                                                                </ContentTemplate>
                                                                                <Triggers>
                                                                                    <asp:AsyncPostBackTrigger ControlID="txtBillCollLocation" EventName="TextChanged" />
                                                                                </Triggers>
                                                                            </asp:UpdatePanel>
                                                                        </td>
                                                                        
                                                                        <td colspan="3">
                                                                            <label class="blackfnt">
                                                                                &nbsp;Credit days from generation:
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td>
                                                                            <input id="txtCreditDays" type="text" size="10"  
                                                                                maxlength="8" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                style="margin-left: 5px;" runat="server" />
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                    <%--Table row for SKU Wise Y/N--%>
                                                                    <tr style="background-color: White">
                                                                        <td>
                                                                            <label class="blackfnt">
                                                                                &nbsp;SKU Wise Y/N:
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td>
                                                                            <input type="checkbox" id="chkSKU" runat="server" 
                                                                                style="margin-left: 1px;" />
                                                                        </td>
                                                                        
                                                                        <td colspan="4">
                                                                            &nbsp;
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                    <%--Table row for Service Tax Payment--%>
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
                                                                
                                                                <br />
                                                                
                                                                <%--<table border="0" cellpadding="2" width="90%" cellspacing="1" align="center" class="boxbg">--%>
	                                                                <%--Dynamically populate charges table in code behind--%>
	                                                                <%--<%=strContractCharges %>--%>
	                                                                <%--<%=strContractChargesHidden %>--%>
		                                                        <%--</table>--%>
		                                                        
		                                                        <table border="0" cellpadding="2" width="90%" cellspacing="1" align="center" class="boxbg">
	                                                                <tr style="background-color: White">
	                                                                    <td style="width: 25%">
	                                                                        <label id="lblSCHG01" runat="server" class="blackfnt"></label>
	                                                                    </td>
	                                                                    
	                                                                    <td style="width: 25%">
	                                                                        <input id="txtSCHG01" runat="server" type="text" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
	                                                                    </td>
	                                                                    
	                                                                    <td style="width: 25%">
	                                                                        <label id="lblSCHG02" runat="server" class="blackfnt"></label>
	                                                                    </td>
	                                                                    
	                                                                    <td style="width: 25%">
	                                                                        <input id="txtSCHG02" runat="server" type="text" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
	                                                                    </td>
	                                                                </tr>
	                                                                
	                                                                <tr style="background-color: White">
	                                                                    <td>
	                                                                        <label id="lblSCHG03" runat="server" class="blackfnt"></label>
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <input id="txtSCHG03" runat="server" type="text" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <label id="lblSCHG04" runat="server" class="blackfnt"></label>
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <input id="txtSCHG04" runat="server" type="text" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
	                                                                    </td>
                                                                    </tr>
	                                                                
	                                                                <tr style="background-color: White">
	                                                                    <td>
	                                                                        <label id="lblSCHG05" runat="server" class="blackfnt"></label>
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <input id="txtSCHG05" runat="server" type="text" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <label id="lblSCHG06" runat="server" class="blackfnt"></label>
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <input id="txtSCHG06" runat="server" type="text" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
	                                                                    </td>
                                                                    </tr>
	                                                                  
	                                                                <%--<tr style="background-color: White">
	                                                                    <td>
	                                                                        <label id="lblSCHG07" runat="server" class="blackfnt"></label>
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <input id="txtSCHG07" runat="server" type="text" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <label id="lblSCHG08" runat="server" class="blackfnt"></label>
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <input id="txtSCHG08" runat="server" type="text" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
	                                                                    </td>
                                                                    </tr>--%>
	                                                                
	                                                                <tr style="background-color: White">
	                                                                    <td>
	                                                                        <label id="lblSCHG09" runat="server" class="blackfnt"></label>
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <input id="txtSCHG09" runat="server" type="text" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <label id="lblSCHG10" runat="server" class="blackfnt"></label>
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <input id="txtSCHG10" runat="server" type="text" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
	                                                                    </td>
	                                                                </tr>
	                                                                
	                                                                <%--<tr style="background-color: White">
	                                                                    <td>
	                                                                        <label id="lblSCHG11" runat="server" class="blackfnt"></label>
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <input id="txtSCHG11" runat="server" type="text" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <label id="lblSCHG12" runat="server" class="blackfnt"></label>
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <input id="txtSCHG12" runat="server" type="text" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
	                                                                    </td>
	                                                                </tr> 
	                                                                
	                                                                <tr style="background-color: White">
	                                                                    <td>
	                                                                        <label id="lblSCHG13" runat="server" class="blackfnt"></label>
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <input id="txtSCHG13" runat="server" type="text" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <label id="lblSCHG14" runat="server" class="blackfnt"></label>
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <input id="txtSCHG14" runat="server" type="text" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
	                                                                    </td>
	                                                                </tr>--%>
	                                                                
	                                                                <tr style="background-color: White">
	                                                                    <td>
	                                                                        <label id="lblSCHG15" runat="server" class="blackfnt"></label>
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <input id="txtSCHG15" runat="server" type="text" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <label id="lblSCHG16" runat="server" class="blackfnt"></label>
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <input id="txtSCHG16" runat="server" type="text" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
	                                                                    </td>
	                                                                </tr> 
	                                                                
	                                                                <tr style="background-color: White">
	                                                                    <td>
	                                                                        <label id="lblSCHG17" runat="server" class="blackfnt"></label>
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <input id="txtSCHG17" runat="server" type="text" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <label id="lblSCHG18" runat="server" class="blackfnt"></label>
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <input id="txtSCHG18" runat="server" type="text" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
	                                                                    </td>
	                                                                </tr>
	                                                                
	                                                                <tr style="background-color: White">
	                                                                    <td>
	                                                                        <label id="lblSCHG19" runat="server" class="blackfnt"></label>
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <input id="txtSCHG19" runat="server" type="text" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <label id="lblSCHG20" runat="server" class="blackfnt"></label>
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <input id="txtSCHG20" runat="server" type="text" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
	                                                                    </td>
	                                                                </tr>
	                                                                
	                                                                <tr style="background-color: White">
	                                                                    <td>
	                                                                        <label id="lblSCHG21" runat="server" class="blackfnt"></label>
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <input id="txtSCHG21" runat="server" type="text" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <label id="lblSCHG22" runat="server" class="blackfnt"></label>
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <input id="txtSCHG22" runat="server" type="text" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
	                                                                    </td>
	                                                                </tr>
	                                                                
	                                                                <tr style="background-color: White">
	                                                                    <td>
	                                                                        <label id="lblSCHG23" runat="server" class="blackfnt"></label>
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <input id="txtSCHG23" runat="server" type="text" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        &nbsp;
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        &nbsp;
	                                                                    </td>
	                                                                </tr>
		                                                        </table>
		                                                        
		                                                        <table border="0" cellpadding="0" width="90%" cellspacing="0" align="center" class="boxbg">
		                                                            <tr style="background-color: White">
		                                                                <td style="width: 25%">
		                                                                    <label id="lblUCHG01" runat="server" class="blackfnt"  visible="false"></label>
		                                                                </td>
		                                                                
		                                                                <td style="width: 25%">
		                                                                    <input id="txtUCHG01" runat="server" type="hidden" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
		                                                                </td>
		                                                                
		                                                                <td style="width: 25%">
		                                                                    <label id="lblUCHG02" runat="server" class="blackfnt"  visible="false"></label>
		                                                                </td>
		                                                                
		                                                                <td style="width: 25%">
		                                                                    <input id="txtUCHG02" runat="server" type="hidden" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
		                                                                </td>
		                                                            </tr>
		                                                            
		                                                            <tr style="background-color: White">
		                                                                <td>
	                                                                        <label id="lblUCHG03" runat="server" class="blackfnt" visible="false"></label>
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <input id="txtUCHG03" runat="server" type="hidden" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <label id="lblUCHG04" runat="server" class="blackfnt" visible="false"></label>
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <input id="txtUCHG04" runat="server" type="hidden" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
	                                                                    </td>
		                                                            </tr>
		                                                            
		                                                            <tr style="background-color: White">
		                                                                <td>
	                                                                        <label id="lblUCHG05" runat="server" class="blackfnt" visible="false"></label>
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <input id="txtUCHG05" runat="server" type="hidden" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <label id="lblUCHG06" runat="server" class="blackfnt" visible="false"></label>
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <input id="txtUCHG06" runat="server" type="hidden" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
	                                                                    </td>
		                                                            </tr>
		                                                            
		                                                            <tr style="background-color: White">
		                                                                <td>
	                                                                        <label id="lblUCHG07" runat="server" class="blackfnt" visible="false"></label>
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <input id="txtUCHG07" runat="server" type="hidden" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <label id="lblUCHG08" runat="server" class="blackfnt" visible="false"></label>
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <input id="txtUCHG08" runat="server" type="hidden" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
	                                                                    </td>
		                                                            </tr>
		                                                            
		                                                            <tr style="background-color: White">
		                                                                <td>
	                                                                        <label id="lblUCHG09" runat="server" class="blackfnt" visible="false"></label>
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <input id="txtUCHG09" runat="server" type="hidden" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <label id="lblUCHG10" runat="server" class="blackfnt" visible="false"></label>
	                                                                    </td>
	                                                                    
	                                                                    <td>
	                                                                        <input id="txtUCHG10" runat="server" type="hidden" size='10' class='input' value='0.0' maxlength='8' 
	                                                                            onblur='return Nagative_Chk_wDecimal(this)' style='margin-left: 5px;' />
	                                                                    </td>
		                                                            </tr>
		                                                        </table>
				                                                
		                                                        <p align="center">
		                                                            <label class="blackfnt">
		                                                                <b>
		                                                                    &nbsp;Minimum Freight
		                                                                </b>
		                                                            </label>
		                                                        </p>
    						                                    
		                                                        <table border="0" cellpadding="2" width="40%" bgcolor="#808080" cellspacing="1" align="center" class="boxbg">
			                                                        <tr style="background-color: White"> 
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
				                                                            <input id="txtAirRateForFreight" type="text" size="10" class="input" 
                                                                                maxlength="8" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                style="margin-left: 5px;" runat="server" />
				                                                        </td>
    								                                    
				                                                        <td>
				                                                            <label style="margin-left: 5px;">
				                                                            </label>
				                                                            <asp:DropDownList ID="ddlAirBasisForFreight" runat="server" CssClass="blackfnt">
			                                                                    <asp:ListItem Selected="True" Text="Select" Value="-1"></asp:ListItem>
			                                                                    <asp:ListItem Selected="False" Text="Rs." Value="RS"></asp:ListItem>
			                                                                    <asp:ListItem Selected="False" Text="Pkg." Value="PKG"></asp:ListItem>
			                                                                    <asp:ListItem Selected="False" Text="Kg." Value="KG"></asp:ListItem>
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
				                                                            <input id="txtRoadRateForFreight" type="text" size="10" class="input" 
                                                                                maxlength="8" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                style="margin-left: 5px;" runat="server" />
				                                                        </td>
    								                                    
				                                                        <td>
				                                                            <label style="margin-left: 5px;">
				                                                            </label>
				                                                            <asp:DropDownList ID="ddlRoadBasisForFreight" runat="server" CssClass="blackfnt">
			                                                                    <asp:ListItem Selected="True" Text="Select" Value="-1"></asp:ListItem>
			                                                                    <asp:ListItem Selected="False" Text="Rs." Value="RS"></asp:ListItem>
			                                                                    <asp:ListItem Selected="False" Text="Pkg." Value="PKG"></asp:ListItem>
			                                                                    <asp:ListItem Selected="False" Text="Kg." Value="KG"></asp:ListItem>
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
				                                                            <input id="txtTrainRateForFreight" type="text" size="10" class="input" 
                                                                                maxlength="8" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                style="margin-left: 5px;" runat="server" />
				                                                        </td>
    								                                    
				                                                        <td>
				                                                            <label style="margin-left: 5px;">
				                                                            </label>
				                                                            <asp:DropDownList ID="ddlTrainBasisForFreight" runat="server" CssClass="blackfnt">
			                                                                    <asp:ListItem Selected="True" Text="Select" Value="-1"></asp:ListItem>
			                                                                    <asp:ListItem Selected="False" Text="Rs." Value="RS"></asp:ListItem>
			                                                                    <asp:ListItem Selected="False" Text="Pkg." Value="PKG"></asp:ListItem>
			                                                                    <asp:ListItem Selected="False" Text="Kg." Value="KG"></asp:ListItem>
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
				                                                            <input id="txtExpressRateForFreight" type="text" size="10" class="input" 
                                                                                maxlength="8" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                style="margin-left: 5px;" runat="server" />
				                                                        </td>
    								                                    
				                                                        <td>
				                                                            <label style="margin-left: 5px;">
				                                                            </label>
				                                                            <asp:DropDownList ID="ddlExpressBasisForFreight" runat="server" CssClass="blackfnt">
			                                                                    <asp:ListItem Selected="True" Text="Select" Value="-1"></asp:ListItem>
			                                                                    <asp:ListItem Selected="False" Text="Rs." Value="RS"></asp:ListItem>
			                                                                    <asp:ListItem Selected="False" Text="Pkg." Value="PKG"></asp:ListItem>
			                                                                    <asp:ListItem Selected="False" Text="Kg." Value="KG"></asp:ListItem>
			                                                                </asp:DropDownList>
				                                                        </td>
			                                                        </tr>
			                                                    </table>
					                                            
						                                        <br />
    							                                
						                                        <center>
			                                                        <table cellpadding="1" cellspacing="1" class="boxbg" width="100%" border="0">
                                                                        <tr style="background-color: White">
                                                                            <td>
                                                                                <asp:Button ID="btnSubmit" Text="Submit" runat="server" 
                                                                                    ToolTip="Click here to submit and proceed" 
                                                                                    OnClientClick="return ValidateData()" OnClick="btnSubmit_Click" />        
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </center>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
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
        
</asp:Content>
