<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="EditCCMStep3ASSC.aspx.cs" Inherits="EditCCMStep3ASSC" EnableEventValidation="false" %>
<%@ OutputCache Location="none" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

    <script language="javascript" type="text/javascript">
           
        function disableenter()
        {
        
        }   
            
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

        function BranchPopup(strPopupURL)
        {
            var strWinFeature = "height=375,width=350,scrollbars=yes,left=300,top=125"
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        
//        function ValidateData()
//        {
//            //Check for selection of Rate Type
//            if(document.getElementById("ctl00_MyCPH1_ddlRateType"))
//            {
//                if(document.getElementById("ctl00_MyCPH1_ddlRateType").value == "-1")
//                {
//                    alert("Please select Rate Type from the list");
//                    document.getElementById("ctl00_MyCPH1_ddlRateType").focus();
//                    return false;
//                }
//            }
//            else
//            {
//                alert("Selection list for Rate Type is not available!");
//                return false;
//            }
//            
//            //Check for Branch Matrix
////            if(document.getElementById("ctl00_MyCPH1_txtBranchCode"))
////            {
////                if(document.getElementById("ctl00_MyCPH1_txtBranchCode").value != "")
////                {
////                    if(document.getElementById("ctl00_MyCPH1_lblErrorBranchCode"))
////                    {
////                        if(document.getElementById("ctl00_MyCPH1_lblErrorBranchCode").style.display == '')
////                        {
////                            alert("Invalid 'Branch Code'");
////                            document.getElementById("ctl00_MyCPH1_txtBranchCode").focus();
////                            return false;
////                        }
////                    }
////                }
////                else
////                {
////                    alert("Enter/Select 'Branch Code'");
////                    document.getElementById("ctl00_MyCPH1_txtBranchCode").focus();
////                    return false;
////                }
////            }
////            else
////            {
////                alert("Input Box for 'Branch Code' is not available!");
////                return false;
////            }
//            
//            var mVarControlForBranchFrom;
//            var mVarControlForBranchFromErrorLabel;
//            var mVarControlForBranchTo;
//            var mVarControlForBranchToErrorLabel;
//            var mVarControlForBranchAir;
//            var mVarControlForBranchAirTrDays;
//            var mVarControlForBranchRoad;
//            var mVarControlForBranchRoadTrDays;
//            var mVarControlForBranchTrain;
//            var mVarControlForBranchTrainTrDays;
//            var mVarControlForBranchExpress;
//            var mVarControlForBranchExpressTrDays;
//            
//            var mVarBM = "";
//            var mVarBMTemp = "";
//            
//            //Check for Branch Matrix
//            for(var mLoopCounter = 1 ; mLoopCounter <= 10; mLoopCounter++)
//            {
//                //Create control ID's
//                mVarControlForBranchFrom = "ctl00_MyCPH1_txtFreightMatrixRow" + mLoopCounter + "From";
//                mVarControlForBranchFromErrorLabel = "ctl00_MyCPH1_lblErrorFreightMatrixRow" + mLoopCounter + "From";
//                mVarControlForBranchTo = "ctl00_MyCPH1_txtFreightMatrixRow" + mLoopCounter + "To";
//                mVarControlForBranchToErrorLabel = "ctl00_MyCPH1_lblErrorFreightMatrixRow" + mLoopCounter + "To";
//                
//                mVarControlForBranchAir = "ctl00_MyCPH1_txtFreightForAirRow" + mLoopCounter;
//                mVarControlForBranchAirTrDays = "ctl00_MyCPH1_txtAirTrDaysRow" + mLoopCounter;
//                mVarControlForBranchRoad = "ctl00_MyCPH1_txtFreightForRoadRow" + mLoopCounter;
//                mVarControlForBranchRoadTrDays = "ctl00_MyCPH1_txtRoadTrDaysRow" + mLoopCounter;
//                mVarControlForBranchTrain = "ctl00_MyCPH1_txtFreightForTrainRow" + mLoopCounter;
//                mVarControlForBranchTrainTrDays = "ctl00_MyCPH1_txtTrainTrDaysRow" + mLoopCounter;
//                mVarControlForBranchExpress = "ctl00_MyCPH1_txtFreightForExpressRow" + mLoopCounter;
//                mVarControlForBranchExpressTrDays = "ctl00_MyCPH1_txtExpressTrDaysRow" + mLoopCounter;
//                
//                //Check for Branch From
//                if(document.getElementById(mVarControlForBranchFrom))
//                {
//                    if(document.getElementById(mVarControlForBranchFrom).value != "")
//                    {
//                        if(document.getElementById(mVarControlForBranchFromErrorLabel))
//                        {
//                            if(document.getElementById(mVarControlForBranchFromErrorLabel).style.display == '')
//                            {
//                                alert("Invalid 'Branch Code'");
//                                document.getElementById(mVarControlForBranchFrom).focus();
//                                return false;
//                            }
//                        }
//                    }
//                }
//                else
//                {
//                    alert("Input Box for 'Branch Code' is not available!");
//                    return false;
//                }
//                
//                //Check for Branch To
//                if(document.getElementById(mVarControlForBranchTo))
//                {
//                    if(document.getElementById(mVarControlForBranchTo).value != "")
//                    {
//                        if(document.getElementById(mVarControlForBranchToErrorLabel))
//                        {
//                            if(document.getElementById(mVarControlForBranchToErrorLabel).style.display == '')
//                            {
//                                alert("Invalid 'Branch Code'");
//                                document.getElementById(mVarControlForBranchTo).focus();
//                                return false;
//                            }
//                        }
//                    }
//                }
//                else
//                {
//                    alert("Input Box for 'Branch Code' is not available!");
//                    return false;
//                }
//                
//                var mBranchAirFr = "";
//                var mBranchAirTrDays = "";
//                var mBranchRoadFr = "";
//                var mBranchRoadTrDays = "";
//                var mBranchTrainFr = "";
//                var mBranchTrainTrDays = "";
//                var mBranchExpressFr = "";
//                var mBranchExpressTrDays = "";
//                var mFlag = 0;
//                
//                //if(document.getElementById(mVarControlForBranchFrom) && document.getElementById(mVarControlForBranchTo) && ((document.getElementById(mVarControlForBranchAir) && document.getElementById(mVarControlForBranchAirTrDays)) || (document.getElementById(mVarControlForBranchRoad) && document.getElementById(mVarControlForBranchRoadTrDays)) || (document.getElementById(mVarControlForBranchTrain) && document.getElementById(mVarControlForBranchTrainTrDays)) || (document.getElementById(mVarControlForBranchExpress) && document.getElementById(mVarControlForBranchExpressTrDays))))
//                if(document.getElementById(mVarControlForBranchFrom) && document.getElementById(mVarControlForBranchTo)) 
//                {
//                    if(document.getElementById(mVarControlForBranchAir) && document.getElementById(mVarControlForBranchAirTrDays))
//                    {
//                        mBranchAirFr = document.getElementById(mVarControlForBranchAir).value;
//                        mBranchAirTrDays = document.getElementById(mVarControlForBranchAirTrDays).value;
//                    }
//                    if(document.getElementById(mVarControlForBranchRoad) && document.getElementById(mVarControlForBranchRoadTrDays))
//                    {
//                        mBranchRoadFr = document.getElementById(mVarControlForBranchRoad).value;
//                        mBranchRoadTrDays = document.getElementById(mVarControlForBranchRoadTrDays).value;
//                    }
//                    if(document.getElementById(mVarControlForBranchTrain) && document.getElementById(mVarControlForBranchTrainTrDays))
//                    {
//                        mBranchTrainFr = document.getElementById(mVarControlForBranchTrain).value;
//                        mBranchTrainTrDays = document.getElementById(mVarControlForBranchTrainTrDays).value;
//                    }
//                    if(document.getElementById(mVarControlForBranchExpress) && document.getElementById(mVarControlForBranchExpressTrDays))
//                    {
//                        mBranchExpressFr = document.getElementById(mVarControlForBranchExpress).value;
//                        mBranchExpressTrDays = document.getElementById(mVarControlForBranchExpressTrDays).value;
//                    }
//                    //if(document.getElementById(mVarControlForBranchFrom).value == "" && document.getElementById(mVarControlForBranchTo).value == "" && ((document.getElementById(mVarControlForBranchAir).value == "" && document.getElementById(mVarControlForBranchAirTrDays).value == "") || (document.getElementById(mVarControlForBranchRoad).value == "" && document.getElementById(mVarControlForBranchRoadTrDays).value == "") || (document.getElementById(mVarControlForBranchTrain).value == "" && document.getElementById(mVarControlForBranchTrainTrDays).value == "") || (document.getElementById(mVarControlForBranchExpress).value == "" && document.getElementById(mVarControlForBranchExpressTrDays).value == "")))
//                    if(document.getElementById(mVarControlForBranchFrom).value == "" && document.getElementById(mVarControlForBranchTo).value == "")
//                    {
//                        if(mBranchRoadFr == "" && mBranchRoadTrDays == "" && mBranchAirFr == "" && mBranchAirTrDays == "" && mBranchTrainFr == "" && mBranchTrainTrDays == "" && mBranchExpressFr == "" && mBranchExpressTrDays == "")
//                        {
////                            if(mLoopCounter == 1)
////                            {
////                                alert("Enter Branch Matrix Details!");
////                                document.getElementById(mVarControlForBranchFrom).focus();
////                                return false;
////                            }   
//                        }
//                    }
//                    else
//                    {
//                        if(document.getElementById(mVarControlForBranchFrom).value == "")
//                        {
//                            alert("Enter 'Branch From' for Branch Matrix!");
//                            document.getElementById(mVarControlForBranchFrom).focus();
//                            return false;
//                        }
//                        else
//                        {
//                            mVarBMTemp = document.getElementById(mVarControlForBranchFrom).value;
//                        }
//                        if(document.getElementById(mVarControlForBranchTo).value == "")
//                        {
//                            alert("Enter 'Branch To' for Branch Matrix!");
//                            document.getElementById(mVarControlForBranchTo).focus();
//                            return false;
//                        }
//                        else
//                        {
//                            mVarBMTemp += "," + document.getElementById(mVarControlForBranchTo).value;
//                        }
//                        
//                        //Check for Different Branch From & To
//                        var mVarBranchFrom = document.getElementById(mVarControlForBranchFrom).value;
//                        var mVarBranchTo = document.getElementById(mVarControlForBranchTo).value;
//                        
//                        if(mVarBranchFrom == mVarBranchTo)
//                        {
//                            alert("'Branch From' & 'Branch To' must be different!");
//                            document.getElementById(mVarControlForBranchFrom).focus();
//                            return false;
//                        }
//                        
//                        if(document.getElementById(mVarControlForBranchAir))
//                        {
//                            if(document.getElementById(mVarControlForBranchAir).value == "")
//                            {
//                                alert("Enter 'Freight Rate' for 'Air' for Branch Matrix!");
//                                document.getElementById(mVarControlForBranchAir).focus();
//                                return false;
//                            }
//                            else
//                            {
//                                mVarBMTemp += "," + document.getElementById(mVarControlForBranchAir).value;
//                            }
//                        }
//                        else
//                        {
//                            mVarBMTemp += "," + "0.0";
//                        }
//                        if(document.getElementById(mVarControlForBranchAirTrDays))
//                        {
//                            if(document.getElementById(mVarControlForBranchAirTrDays).value == "")
//                            {
//                                alert("Enter 'Transit Days' for 'Air' for Branch Matrix!");
//                                document.getElementById(mVarControlForBranchAirTrDays).focus();
//                                return false;
//                            }
//                            else
//                            {
//                                mVarBMTemp += "," + document.getElementById(mVarControlForBranchAirTrDays).value;
//                            }
//                        }
//                        else
//                        {
//                            mVarBMTemp += "," + "0.0";
//                        }
//                        if(document.getElementById(mVarControlForBranchRoad))
//                        {
//                            if(document.getElementById(mVarControlForBranchRoad).value == "")
//                            {
//                                alert("Enter 'Freight Rate' for 'Road' for Branch Matrix!");
//                                document.getElementById(mVarControlForBranchRoad).focus();
//                                return false;
//                            }
//                            else
//                            {
//                                mVarBMTemp += "," + document.getElementById(mVarControlForBranchRoad).value;
//                            }
//                        }
//                        else
//                        {
//                            mVarBMTemp += "," + "0.0";
//                        }
//                        if(document.getElementById(mVarControlForBranchRoadTrDays))
//                        {
//                            if(document.getElementById(mVarControlForBranchRoadTrDays).value == "")
//                            {
//                                alert("Enter 'Transit Days' for 'Road' for Branch Matrix!");
//                                document.getElementById(mVarControlForBranchRoadTrDays).focus();
//                                return false;
//                            }
//                            else
//                            {
//                                mVarBMTemp += "," + document.getElementById(mVarControlForBranchRoadTrDays).value;
//                            }
//                        }
//                        else
//                        {
//                            mVarBMTemp += "," + "0.0";
//                        }
//                        if(document.getElementById(mVarControlForBranchTrain))
//                        {
//                            if(document.getElementById(mVarControlForBranchTrain).value == "")
//                            {
//                                alert("Enter 'Freight Rate' for 'Train' for Branch Matrix!");
//                                document.getElementById(mVarControlForBranchTrain).focus();
//                                return false;
//                            }
//                            else
//                            {
//                                mVarBMTemp += "," + document.getElementById(mVarControlForBranchTrain).value;
//                            }
//                        }
//                        else
//                        {
//                            mVarBMTemp += "," + "0.0";
//                        }
//                        if(document.getElementById(mVarControlForBranchTrainTrDays))
//                        {
//                            if(document.getElementById(mVarControlForBranchTrainTrDays).value == "")
//                            {
//                                alert("Enter 'Transit Days' for 'Train' for Branch Matrix!");
//                                document.getElementById(mVarControlForBranchTrain).focus();
//                                return false;
//                            }
//                            else
//                            {
//                                mVarBMTemp += "," + document.getElementById(mVarControlForBranchTrainTrDays).value;
//                            }
//                        }
//                        else
//                        {
//                            mVarBMTemp += "," + "0.0";
//                        }
//                        if(document.getElementById(mVarControlForBranchExpress))
//                        {
//                            if(document.getElementById(mVarControlForBranchExpress).value == "")
//                            {
//                                alert("Enter 'Freight Rate' for 'Express' for Branch Matrix!");
//                                document.getElementById(mVarControlForBranchExpress).focus();
//                                return false;
//                            }
//                            else
//                            {
//                                mVarBMTemp += "," + document.getElementById(mVarControlForBranchExpress).value;
//                            }
//                        }
//                        else
//                        {
//                            mVarBMTemp += "," + "0.0";
//                        }
//                        if(document.getElementById(mVarControlForBranchExpressTrDays))
//                        {
//                            if(document.getElementById(mVarControlForBranchExpressTrDays).value == "")
//                            {
//                                alert("Enter 'Transit Days' for 'Express' for Branch Matrix!");
//                                document.getElementById(mVarControlForBranchExpressTrDays).focus();
//                                return false;
//                            }
//                            else
//                            {
//                                mVarBMTemp += "," + document.getElementById(mVarControlForBranchExpressTrDays).value;
//                            }
//                        }
//                        else
//                        {
//                            mVarBMTemp += "," + "0.0";
//                        }
//                    }
//                    if(mVarBMTemp != "")
//                    {
//                        mVarBM = (mVarBM == "" ? mVarBMTemp : mVarBM + "~" + mVarBMTemp);
//                        mVarBMTemp = "";
//                    }
//                }
//            }
//            
//            //Check for Distinct Pair of Branch From & To
//            for(var mLoopCounter = 1 ; mLoopCounter <= 10; mLoopCounter++)
//            {
//                //Create control ID's
//                mVarControlForBranchFrom = "ctl00_MyCPH1_txtFreightMatrixRow" + mLoopCounter + "From";
//                mVarControlForBranchTo = "ctl00_MyCPH1_txtFreightMatrixRow" + mLoopCounter + "To";
//                
//                var mVarBranchFrom = document.getElementById(mVarControlForBranchFrom).value;
//                var mVarBranchTo = document.getElementById(mVarControlForBranchTo).value;
//                
//                if(mVarBranchFrom != "" && mVarBranchTo != "")
//                {
//                    if(CheckDuplicateBranch(mVarBranchFrom, mVarBranchTo, mLoopCounter) == true)
//                    {
//                        alert("Please enter distinct 'Branch From' & 'Branch To'!");
//                        document.getElementById(mVarControlForBranchFrom).focus();
//                        return false;
//                    }
//                }
//            }
//            
//            //Check for selection of Zone Header
////            if(document.getElementById("ctl00_MyCPH1_ddlZoneHeader"))
////            {
////                if(document.getElementById("ctl00_MyCPH1_ddlZoneHeader").value == "-1")
////                {
////                    alert("Please select Zone from the list");
////                    document.getElementById("ctl00_MyCPH1_ddlZoneHeader").focus();
////                    return false;
////                }
////            }
////            else
////            {
////                alert("Selection list for Zone Header is not available!");
////                return false;
////            }
//            
//            var mVarControlForZoneFrom;
//            var mVarControlForZoneTo;
//            var mVarControlForZoneAir;
//            var mVarControlForZoneAirTrDays;
//            var mVarControlForZoneRoad;
//            var mVarControlForZoneRoadTrDays;
//            var mVarControlForZoneTrain;
//            var mVarControlForZoneTrainTrDays;
//            var mVarControlForZoneExpress;
//            var mVarControlForZoneExpressTrDays;
//            
//            var mVarZM = "";
//            var mVarZMTemp = "";
//            
//            var mVarZoneAir = "";
//            var mVarZoneAirTrDays = "";
//            var mVarZoneRoad = "";
//            var mVarZoneRoadTrDays = "";
//            var mVarZoneTrain = "";
//            var mVarZoneTrainTrDays = "";
//            var mVarZoneExpress = "";
//            var mVarZoneExpressTrDays = "";
//            
//            //Check for Zone Matrix
//            for(var mLoopCounter = 1 ; mLoopCounter <= 10; mLoopCounter++)
//            {
//                //Create control ID's
//                mVarControlForZoneFrom = "ctl00_MyCPH1_ddlZoneFromForRow" + mLoopCounter;
//                mVarControlForZoneTo = "ctl00_MyCPH1_ddlZoneToForRow" + mLoopCounter;
//                
//                mVarControlForZoneAir = "ctl00_MyCPH1_txtFreightForAirZoneForRow" + mLoopCounter;
//                mVarControlForZoneAirTrDays = "ctl00_MyCPH1_txtAirTrDaysRowForZone" + mLoopCounter;
//                mVarControlForZoneRoad = "ctl00_MyCPH1_txtFreightForRoadZoneForRow" + mLoopCounter;
//                mVarControlForZoneRoadTrDays = "ctl00_MyCPH1_txtRoadTrDaysRowForZone" + mLoopCounter;
//                mVarControlForZoneTrain = "ctl00_MyCPH1_txtFreightForTrainZoneForRow" + mLoopCounter;
//                mVarControlForZoneTrainTrDays = "ctl00_MyCPH1_txtTrainTrDaysRowForZone" + mLoopCounter;
//                mVarControlForZoneExpress = "ctl00_MyCPH1_txtFreightForExpressZoneForRow" + mLoopCounter;
//                mVarControlForZoneExpressTrDays = "ctl00_MyCPH1_txtExpressTrDaysRowForZone" + mLoopCounter;
//                
//                mVarZoneAir = "";
//                mVarZoneAirTrDays = "";
//                mVarZoneRoad = "";
//                mVarZoneRoadTrDays = "";
//                mVarZoneTrain = "";
//                mVarZoneTrainTrDays = "";
//                mVarZoneExpress = "";
//                mVarZoneExpressTrDays = "";
//                
//                //if(document.getElementById(mVarControlForZoneFrom) && document.getElementById(mVarControlForZoneTo) && ((document.getElementById(mVarControlForZoneAir) && document.getElementById(mVarControlForZoneAirTrDays)) || (document.getElementById(mVarControlForZoneRoad) && document.getElementById(mVarControlForZoneRoadTrDays)) || (document.getElementById(mVarControlForZoneTrain) && document.getElementById(mVarControlForZoneTrainTrDays)) || (document.getElementById(mVarControlForZoneExpress) && document.getElementById(mVarControlForZoneExpressTrDays))))
//                if(document.getElementById(mVarControlForZoneFrom) && document.getElementById(mVarControlForZoneTo)) 
//                {
//                    //&& ((document.getElementById(mVarControlForZoneAir) && document.getElementById(mVarControlForZoneAirTrDays)) || (document.getElementById(mVarControlForZoneRoad) && document.getElementById(mVarControlForZoneRoadTrDays)) || (document.getElementById(mVarControlForZoneTrain) && document.getElementById(mVarControlForZoneTrainTrDays)) || (document.getElementById(mVarControlForZoneExpress) && document.getElementById(mVarControlForZoneExpressTrDays))))
//                    if(document.getElementById(mVarControlForZoneAir) && document.getElementById(mVarControlForZoneAirTrDays))
//                    {
//                        mVarZoneAir = document.getElementById(mVarControlForZoneAir).value;
//                        mVarZoneAirTrDays = document.getElementById(mVarControlForZoneAirTrDays).value;  
//                    }
//                    
//                    if(document.getElementById(mVarControlForZoneRoad) && document.getElementById(mVarControlForZoneRoadTrDays))
//                    {
//                        mVarZoneRoad = document.getElementById(mVarControlForZoneRoad).value;
//                        mVarZoneRoadTrDays = document.getElementById(mVarControlForZoneRoadTrDays).value;  
//                    }
//                    
//                    if(document.getElementById(mVarControlForZoneTrain) && document.getElementById(mVarControlForZoneTrainTrDays))
//                    {
//                        mVarZoneTrain = document.getElementById(mVarControlForZoneTrain).value;
//                        mVarZoneTrainTrDays = document.getElementById(mVarControlForZoneTrainTrDays).value;  
//                    }
//                    
//                    if(document.getElementById(mVarControlForZoneExpress) && document.getElementById(mVarControlForZoneExpressTrDays))
//                    {
//                        mVarZoneExpress = document.getElementById(mVarControlForZoneExpress).value;
//                        mVarZoneExpressTrDays = document.getElementById(mVarControlForZoneExpressTrDays).value;  
//                    }
//                    
//                    //if(document.getElementById(mVarControlForZoneFrom).value != "-1" && document.getElementById(mVarControlForZoneTo).value == "-1" && ((document.getElementById(mVarControlForZoneAir).value == "" && document.getElementById(mVarControlForZoneAirTrDays).value == "") || (document.getElementById(mVarControlForZoneRoad).value == "" && document.getElementById(mVarControlForZoneRoadTrDays).value == "") || (document.getElementById(mVarControlForZoneTrain).value == "" && document.getElementById(mVarControlForZoneTrainTrDays).value == "") || (document.getElementById(mVarControlForZoneExpress).value == "" && document.getElementById(mVarControlForZoneExpressTrDays).value == "")))
//                    if(document.getElementById(mVarControlForZoneFrom).value != "-1" && document.getElementById(mVarControlForZoneTo).value == "-1")
//                    {
//                         //&& ((document.getElementById(mVarControlForZoneAir).value == "" && document.getElementById(mVarControlForZoneAirTrDays).value == "") || (document.getElementById(mVarControlForZoneRoad).value == "" && document.getElementById(mVarControlForZoneRoadTrDays).value == "") || (document.getElementById(mVarControlForZoneTrain).value == "" && document.getElementById(mVarControlForZoneTrainTrDays).value == "") || (document.getElementById(mVarControlForZoneExpress).value == "" && document.getElementById(mVarControlForZoneExpressTrDays).value == "")))
//                        if(mVarZoneAir == "" && mVarZoneAirTrDays == "" &&  mVarZoneRoad == "" && mVarZoneRoadTrDays == "" && mVarZoneTrain == "" && mVarZoneTrainTrDays == "" && mVarZoneExpress == "" && mVarZoneExpressTrDays == "")
//                        {
////                            if(mLoopCounter == 1)
////                            {
////                                alert("Enter Zone Matrix Details!");
////                                document.getElementById(mVarControlForZoneFrom).focus();
////                                return false;
////                            }
//                        }
//                    }
//                    else
//                    {
//                        if(document.getElementById(mVarControlForZoneFrom).value == "-1")
//                        {
//                            alert("Select 'Zone From' for Zone Matrix!");
//                            document.getElementById(mVarControlForZoneFrom).focus();
//                            return false;
//                        }
//                        else
//                        {
//                            mVarZMTemp = document.getElementById(mVarControlForZoneFrom).value;
//                        }
//                        if(document.getElementById(mVarControlForZoneTo).value == "-1")
//                        {
//                            alert("Select 'Branch To' for Branch Matrix!");
//                            document.getElementById(mVarControlForZoneTo).focus();
//                            return false;
//                        }
//                        else
//                        {
//                            mVarZMTemp += "," + document.getElementById(mVarControlForZoneTo).value;
//                        }
//                        
//                        //Check for Different Zone From & To
//                        var mVarZoneFrom = document.getElementById(mVarControlForZoneFrom).value;
//                        var mVarZoneTo = document.getElementById(mVarControlForZoneTo).value;
//                        
//                        if(mVarZoneFrom == mVarZoneTo)
//                        {
//                            alert("'Zone From' & 'Zone To' must be different!");
//                            document.getElementById(mVarControlForZoneFrom).focus();
//                            return false;
//                        }
//                        
//                        if(document.getElementById(mVarControlForZoneAir))
//                        {
//                            if(document.getElementById(mVarControlForZoneAir).value == "")
//                            {
//                                alert("Enter 'Freight Rate' for 'Air' for Zone Matrix!");
//                                document.getElementById(mVarControlForZoneAir).focus();
//                                return false;
//                            }
//                            else
//                            {
//                                mVarZMTemp += "," + document.getElementById(mVarControlForZoneAir).value;
//                            }
//                        }
//                        else
//                        {
//                            mVarZMTemp += "," + "0.0";
//                        }
//                        if(document.getElementById(mVarControlForZoneAirTrDays))
//                        {
//                            if(document.getElementById(mVarControlForZoneAirTrDays).value == "")
//                            {
//                                alert("Enter 'Transit Days' for 'Air' for Zone Matrix!");
//                                document.getElementById(mVarControlForZoneAirTrDays).focus();
//                                return false;
//                            }
//                            else
//                            {
//                                mVarZMTemp += "," + document.getElementById(mVarControlForZoneAirTrDays).value;
//                            }
//                        }
//                        else
//                        {
//                            mVarZMTemp += "," + "0.0";
//                        }
//                        
//                        if(document.getElementById(mVarControlForZoneRoad))
//                        {
//                            if(document.getElementById(mVarControlForZoneRoad).value == "")
//                            {
//                                alert("Enter 'Freight Rate' for 'Road' for Zone Matrix!");
//                                document.getElementById(mVarControlForZoneRoad).focus();
//                                return false;
//                            }
//                            else
//                            {
//                                mVarZMTemp += "," + document.getElementById(mVarControlForZoneRoad).value;
//                            }
//                        }
//                        else
//                        {
//                            mVarZMTemp += "," + "0.0";
//                        }
//                        if(document.getElementById(mVarControlForZoneRoadTrDays))
//                        {
//                            if(document.getElementById(mVarControlForZoneRoadTrDays).value == "")
//                            {
//                                alert("Enter 'Transit Days' for 'Road' for Zone Matrix!");
//                                document.getElementById(mVarControlForZoneRoadTrDays).focus();
//                                return false;
//                            }
//                            else
//                            {
//                                mVarZMTemp += "," + document.getElementById(mVarControlForZoneRoadTrDays).value;
//                            }
//                        }
//                        else
//                        {
//                            mVarZMTemp += "," + "0.0";
//                        }
//                        
//                        if(document.getElementById(mVarControlForZoneTrain))
//                        {
//                            if(document.getElementById(mVarControlForZoneTrain).value == "")
//                            {
//                                alert("Enter 'Freight Rate' for 'Train' for Zone Matrix!");
//                                document.getElementById(mVarControlForZoneTrain).focus();
//                                return false;
//                            }
//                            else
//                            {
//                                mVarZMTemp += "," + document.getElementById(mVarControlForZoneTrain).value;
//                            }
//                        }
//                        else
//                        {
//                            mVarZMTemp += "," + "0.0";
//                        }
//                        if(document.getElementById(mVarControlForZoneTrainTrDays))
//                        {
//                            if(document.getElementById(mVarControlForZoneTrainTrDays).value == "")
//                            {
//                                alert("Enter 'Transit Days' for 'Train' for Zone Matrix!");
//                                document.getElementById(mVarControlForZoneTrainTrDays).focus();
//                                return false;
//                            }
//                            else
//                            {
//                                mVarZMTemp += "," + document.getElementById(mVarControlForZoneTrainTrDays).value;
//                            }
//                        }
//                        else
//                        {
//                            mVarZMTemp += "," + "0.0";
//                        }
//                        
//                        if(document.getElementById(mVarControlForZoneExpress))
//                        {
//                            if(document.getElementById(mVarControlForZoneExpress).value == "")
//                            {
//                                alert("Enter 'Freight Rate' for 'Express' for Zone Matrix!");
//                                document.getElementById(mVarControlForZoneExpress).focus();
//                                return false;
//                            }
//                            else
//                            {
//                                mVarZMTemp += "," + document.getElementById(mVarControlForZoneExpress).value;
//                            }
//                        }
//                        else
//                        {
//                            mVarZMTemp += "," + "0.0";
//                        }
//                        if(document.getElementById(mVarControlForZoneExpressTrDays))
//                        {
//                            if(document.getElementById(mVarControlForZoneExpressTrDays).value == "")
//                            {
//                                alert("Enter 'Transit Days' for 'Express' for Zone Matrix!");
//                                document.getElementById(mVarControlForZoneExpressTrDays).focus();
//                                return false;
//                            }
//                            else
//                            {
//                                mVarZMTemp += "," + document.getElementById(mVarControlForZoneExpressTrDays).value;
//                            }
//                        }
//                        else
//                        {
//                            mVarZMTemp += "," + "0.0";
//                        }
//                    }
//                    if(mVarZMTemp != "")
//                    {
//                        mVarZM = (mVarZM == "" ? mVarZMTemp : mVarZM + "~" + mVarZMTemp);
//                        mVarZMTemp = "";
//                    }
//                }
//            }
//            
//            //Check for Distinct Pair of Zone From & To
//            for(var mLoopCounter = 1 ; mLoopCounter <= 10; mLoopCounter++)
//            {
//                //Create control ID's
//                mVarControlForZoneFrom = "ctl00_MyCPH1_ddlZoneFromForRow" + mLoopCounter;
//                mVarControlForZoneTo = "ctl00_MyCPH1_ddlZoneToForRow" + mLoopCounter;
//                
//                var mVarZoneFrom = document.getElementById(mVarControlForZoneFrom).value;
//                var mVarZoneTo = document.getElementById(mVarControlForZoneTo).value;
//                
//                if(mVarZoneTo != "-1")
//                {
//                    if(CheckDuplicateZone(mVarZoneFrom, mVarZoneTo, mLoopCounter) == true)
//                    {
//                        alert("Please enter distinct 'Zone From' & 'Zone To'!");
//                        document.getElementById(mVarControlForZoneFrom).focus();
//                        return false;
//                    }
//                }
//            }
//            
//            //Check for City Matrix
////            if(document.getElementById("ctl00_MyCPH1_txtCity"))
////            {
////                if(document.getElementById("ctl00_MyCPH1_txtCity").value != "")
////                {
////                    if(document.getElementById("ctl00_MyCPH1_lblErrorCity"))
////                    {
////                        if(document.getElementById("ctl00_MyCPH1_lblErrorCity").style.display == '')
////                        {
////                            alert("Invalid 'City Name'");
////                            document.getElementById("ctl00_MyCPH1_txtCity").focus();
////                            return false;
////                        }
////                    }
////                }
////                else
////                {
////                    alert("Enter/Select 'City Name'");
////                    document.getElementById("ctl00_MyCPH1_txtCity").focus();
////                    return false;
////                }
////            }
//            
//            var mVarControlForCityFrom;
//            var mVarControlForCityFromErrorLabel;
//            var mVarControlForCityTo;
//            var mVarControlForCityToErrorLabel;
//            var mVarControlForCityAir;
//            var mVarControlForCityAirTrDays;
//            var mVarControlForCityRoad;
//            var mVarControlForCityRoadTrDays;
//            var mVarControlForCityTrain;
//            var mVarControlForCityTrainTrDays;
//            var mVarControlForCityExpress;
//            var mVarControlForCityExpressTrDays;
//            
//            var mVarCM = "";
//            var mVarCMTemp = "";
//            
//            mVarCityAir = "";
//            mVarCityAirTrDays = "";
//            mVarCityRoad = "";
//            mVarCityRoadTrDays = "";
//            mVarCityTrain = "";
//            mVarCityTrainTrDays = "";
//            mVarCityExpress = "";
//            mVarCityExpressTrDays = "";
//            
//            //Check for City Matrix
//            for(var mLoopCounter = 1 ; mLoopCounter <= 10; mLoopCounter++)
//            {
//                //Create control ID's
//                mVarControlForCityFrom = "ctl00_MyCPH1_txtFromCityRow" + mLoopCounter;
//                mVarControlForCityFromErrorLabel = "ctl00_MyCPH1_lblErrorFromCityRow" + mLoopCounter;
//                mVarControlForCityTo = "ctl00_MyCPH1_txtToCityRow" + mLoopCounter;
//                mVarControlForCityToErrorLabel = "ctl00_MyCPH1_lblErrorToCityRow" + mLoopCounter;
//                
//                mVarControlForCityAir = "ctl00_MyCPH1_txtAirCityForRow" + mLoopCounter;
//                mVarControlForCityAirTrDays = "ctl00_MyCPH1_txtAirTrDaysRowForCity" + mLoopCounter;
//                mVarControlForCityRoad = "ctl00_MyCPH1_txtRoadCityForRow" + mLoopCounter;
//                mVarControlForCityRoadTrDays = "ctl00_MyCPH1_txtRoadTrDaysRowForCity" + mLoopCounter;
//                mVarControlForCityTrain = "ctl00_MyCPH1_txtTrainCityForRow" + mLoopCounter;
//                mVarControlForCityTrainTrDays = "ctl00_MyCPH1_txtTrainTrDaysRowForCity" + mLoopCounter;
//                mVarControlForCityExpress = "ctl00_MyCPH1_txtExpressCityForRow" + mLoopCounter;
//                mVarControlForCityExpressTrDays = "ctl00_MyCPH1_txtExpressTrDaysRowForCity" + mLoopCounter;
//                
//                //Check for City From
//                if(document.getElementById(mVarControlForCityFrom))
//                {
//                    if(document.getElementById(mVarControlForCityFrom).value != "")
//                    {
//                        if(document.getElementById(mVarControlForCityFromErrorLabel))
//                        {
//                            if(document.getElementById(mVarControlForCityFromErrorLabel).style.display == '')
//                            {
//                                alert("Invalid 'City Name'");
//                                document.getElementById(mVarControlForCityFrom).focus();
//                                return false;
//                            }
//                        }
//                    }
//                }
//                
//                //Check for City To
//                if(document.getElementById(mVarControlForCityTo))
//                {
//                    if(document.getElementById(mVarControlForCityTo).value != "")
//                    {
//                        if(document.getElementById(mVarControlForCityToErrorLabel))
//                        {
//                            if(document.getElementById(mVarControlForCityToErrorLabel).style.display == '')
//                            {
//                                alert("Invalid 'City Name'");
//                                document.getElementById(mVarControlForCityTo).focus();
//                                return false;
//                            }
//                        }
//                    }
//                }
//                
//                //if(document.getElementById(mVarControlForCityFrom) && document.getElementById(mVarControlForCityTo) && ((document.getElementById(mVarControlForCityAir) && document.getElementById(mVarControlForCityAirTrDays)) || (document.getElementById(mVarControlForCityRoad) && document.getElementById(mVarControlForCityRoadTrDays)) || (document.getElementById(mVarControlForCityTrain) && document.getElementById(mVarControlForCityTrainTrDays)) || (document.getElementById(mVarControlForCityExpress) && document.getElementById(mVarControlForCityExpressTrDays))))
//                if(document.getElementById(mVarControlForCityFrom) && document.getElementById(mVarControlForCityTo)) 
//                {
//                    //&& ((document.getElementById(mVarControlForCityAir) && document.getElementById(mVarControlForCityAirTrDays)) || (document.getElementById(mVarControlForCityRoad) && document.getElementById(mVarControlForCityRoadTrDays)) || (document.getElementById(mVarControlForCityTrain) && document.getElementById(mVarControlForCityTrainTrDays)) || (document.getElementById(mVarControlForCityExpress) && document.getElementById(mVarControlForCityExpressTrDays))))
//                    if(document.getElementById(mVarControlForCityAir) && document.getElementById(mVarControlForCityAirTrDays))
//                    {
//                        mVarCityAir = document.getElementById(mVarControlForCityAir).value;
//                        mVarCityAirTrDays = document.getElementById(mVarControlForCityAirTrDays).value;  
//                    }
//                    
//                    if(document.getElementById(mVarControlForCityRoad) && document.getElementById(mVarControlForCityRoadTrDays))
//                    {
//                        mVarCityRoad = document.getElementById(mVarControlForCityRoad).value;
//                        mVarCityRoadTrDays = document.getElementById(mVarControlForCityRoadTrDays).value;  
//                    }
//                    
//                    if(document.getElementById(mVarControlForCityTrain) && document.getElementById(mVarControlForCityTrainTrDays))
//                    {
//                        mVarCityTrain = document.getElementById(mVarControlForCityTrain).value;
//                        mVarCityTrainTrDays = document.getElementById(mVarControlForCityTrainTrDays).value;  
//                    }
//                    
//                    if(document.getElementById(mVarControlForCityExpress) && document.getElementById(mVarControlForCityExpressTrDays))
//                    {
//                        mVarCityExpress = document.getElementById(mVarControlForCityExpress).value;
//                        mVarCityExpressTrDays = document.getElementById(mVarControlForCityExpressTrDays).value;  
//                    }
//                    
//                    //if(document.getElementById(mVarControlForCityFrom).value == "" && document.getElementById(mVarControlForCityTo).value == "" && ((document.getElementById(mVarControlForCityAir).value == "" && document.getElementById(mVarControlForCityAirTrDays).value == "") || (document.getElementById(mVarControlForCityRoad).value == "" && document.getElementById(mVarControlForCityRoadTrDays).value == "") || (document.getElementById(mVarControlForCityTrain).value == "" && document.getElementById(mVarControlForCityTrainTrDays).value == "") || (document.getElementById(mVarControlForCityExpress).value == "" && document.getElementById(mVarControlForCityExpressTrDays).value == "")))
//                    if(document.getElementById(mVarControlForCityFrom).value == "" && document.getElementById(mVarControlForCityTo).value == "") //&& ((document.getElementById(mVarControlForCityAir).value == "" && document.getElementById(mVarControlForCityAirTrDays).value == "") || (document.getElementById(mVarControlForCityRoad).value == "" && document.getElementById(mVarControlForCityRoadTrDays).value == "") || (document.getElementById(mVarControlForCityTrain).value == "" && document.getElementById(mVarControlForCityTrainTrDays).value == "") || (document.getElementById(mVarControlForCityExpress).value == "" && document.getElementById(mVarControlForCityExpressTrDays).value == "")))
//                    {
//                        if(mVarCityAir == "" && mVarCityAirTrDays == "" &&  mVarCityRoad == "" && mVarCityRoadTrDays == "" && mVarCityTrain == "" && mVarCityTrainTrDays == "" && mVarCityExpress == "" && mVarCityExpressTrDays == "")
//                        {
////                            if(mLoopCounter == 1)
////                            {
////                                alert("Enter City Matrix Details!");
////                                document.getElementById(mVarControlForCityFrom).focus();
////                                return false;
////                            }
//                        }
//                    }
//                    else
//                    {
//                        if(document.getElementById(mVarControlForCityFrom).value == "")
//                        {
//                            alert("Enter 'City From' for City Matrix!");
//                            document.getElementById(mVarControlForCityFrom).focus();
//                            return false;
//                        }
//                        else
//                        {
//                            mVarCMTemp = document.getElementById(mVarControlForCityFrom).value;
//                        }
//                        if(document.getElementById(mVarControlForCityTo).value == "")
//                        {
//                            alert("Enter 'City To' for City Matrix!");
//                            document.getElementById(mVarControlForCityTo).focus();
//                            return false;
//                        }
//                        else
//                        {
//                            mVarCMTemp += "," + document.getElementById(mVarControlForCityTo).value;
//                        }
//                        
//                        //Check for Different City From & To
//                        var mVarCityFrom = document.getElementById(mVarControlForCityFrom).value;
//                        var mVarCityTo = document.getElementById(mVarControlForCityTo).value;
//                        
//                        if(mVarCityFrom == mVarCityTo)
//                        {
//                            alert("'City From' & 'City To' must be different!");
//                            document.getElementById(mVarControlForCityFrom).focus();
//                            return false;
//                        }
//                        
//                        if(document.getElementById(mVarControlForCityAir))
//                        {
//                            if(document.getElementById(mVarControlForCityAir).value == "")
//                            {
//                                alert("Enter 'Freight Rate' for 'Air' for City Matrix!");
//                                document.getElementById(mVarControlForCityAir).focus();
//                                return false;
//                            }
//                            else
//                            {
//                                mVarCMTemp += "," + document.getElementById(mVarControlForCityAir).value;
//                            }
//                        }
//                        else
//                        {
//                            mVarCMTemp += "," + "0.0";
//                        }
//                        if(document.getElementById(mVarControlForCityAirTrDays))
//                        {
//                            if(document.getElementById(mVarControlForCityAirTrDays).value == "")
//                            {
//                                alert("Enter 'Transit Days' for 'Air' for City Matrix!");
//                                document.getElementById(mVarControlForCityAirTrDays).focus();
//                                return false;
//                            }
//                            else
//                            {
//                                mVarCMTemp += "," + document.getElementById(mVarControlForCityAirTrDays).value;
//                            }
//                        }
//                        else
//                        {
//                            mVarCMTemp += "," + "0.0";
//                        }
//                        
//                        if(document.getElementById(mVarControlForCityRoad))
//                        {
//                            if(document.getElementById(mVarControlForCityRoad).value == "")
//                            {
//                                alert("Enter 'Freight Rate' for 'Road' for City Matrix!");
//                                document.getElementById(mVarControlForCityRoad).focus();
//                                return false;
//                            }
//                            else
//                            {
//                                mVarCMTemp += "," + document.getElementById(mVarControlForCityRoad).value;
//                            }
//                        }
//                        else
//                        {
//                            mVarCMTemp += "," + "0.0";
//                        }
//                        if(document.getElementById(mVarControlForCityRoadTrDays))
//                        {
//                            if(document.getElementById(mVarControlForCityRoadTrDays).value == "")
//                            {
//                                alert("Enter 'Transit Days' for 'Road' for City Matrix!");
//                                document.getElementById(mVarControlForCityRoadTrDays).focus();
//                                return false;
//                            }
//                            else
//                            {
//                                mVarCMTemp += "," + document.getElementById(mVarControlForCityRoadTrDays).value;
//                            }
//                        }
//                        else
//                        {
//                            mVarCMTemp += "," + "0.0";
//                        }
//                        
//                        if(document.getElementById(mVarControlForCityTrain))
//                        {
//                            if(document.getElementById(mVarControlForCityTrain).value == "")
//                            {
//                                alert("Enter 'Freight Rate' for 'Train' for City Matrix!");
//                                document.getElementById(mVarControlForCityTrain).focus();
//                                return false;
//                            }
//                            else
//                            {
//                                mVarCMTemp += "," + document.getElementById(mVarControlForCityTrain).value;
//                            }
//                        }
//                        else
//                        {
//                            mVarCMTemp += "," + "0.0";
//                        }
//                        if(document.getElementById(mVarControlForCityTrainTrDays))
//                        {
//                            if(document.getElementById(mVarControlForCityTrainTrDays).value == "")
//                            {
//                                alert("Enter 'Transit Days' for 'Train' for City Matrix!");
//                                document.getElementById(mVarControlForCityTrainTrDays).focus();
//                                return false;
//                            }
//                            else
//                            {
//                                mVarCMTemp += "," + document.getElementById(mVarControlForCityTrainTrDays).value;
//                            }
//                        }
//                        else
//                        {
//                            mVarCMTemp += "," + "0.0";
//                        }
//                        
//                        if(document.getElementById(mVarControlForCityExpress))
//                        {
//                            if(document.getElementById(mVarControlForCityExpress).value == "")
//                            {
//                                alert("Enter 'Freight Rate' for 'Express' for City Matrix!");
//                                document.getElementById(mVarControlForCityExpress).focus();
//                                return false;
//                            }
//                            else
//                            {
//                                mVarCMTemp += "," + document.getElementById(mVarControlForCityExpress).value;
//                            }
//                        }
//                        else
//                        {
//                            mVarCMTemp += "," + "0.0";
//                        }
//                        if(document.getElementById(mVarControlForCityExpressTrDays))
//                        {
//                            if(document.getElementById(mVarControlForCityExpressTrDays).value == "")
//                            {
//                                alert("Enter 'Transit Days' for 'Express' for City Matrix!");
//                                document.getElementById(mVarControlForCityExpressTrDays).focus();
//                                return false;
//                            }
//                            else
//                            {
//                                mVarCMTemp += "," + document.getElementById(mVarControlForCityExpressTrDays).value;
//                            }
//                        }
//                        else
//                        {
//                            mVarCMTemp += "," + "0.0";
//                        }
//                    }
//                    if(mVarCMTemp != "")
//                    {
//                        mVarCM = (mVarCM == "" ? mVarCMTemp : mVarCM + "~" + mVarCMTemp);
//                        mVarCMTemp = "";
//                    }
//                }
//            }
//            
//            //Check for Distinct Pair of City From & To
//            for(var mLoopCounter = 1 ; mLoopCounter <= 10; mLoopCounter++)
//            {
//                //Create control ID's
//                mVarControlForCityFrom = "ctl00_MyCPH1_txtFromCityRow" + mLoopCounter;
//                mVarControlForCityTo = "ctl00_MyCPH1_txtToCityRow" + mLoopCounter;
//                
//                var mVarCityFrom = document.getElementById(mVarControlForCityFrom).value;
//                var mVarCityTo = document.getElementById(mVarControlForCityTo).value;
//                
//                if(mVarCityFrom != "" && mVarCityTo != "")
//                {
//                    if(CheckDuplicateCity(mVarCityFrom, mVarCityTo, mLoopCounter) == true)
//                    {
//                        alert("Please enter distinct 'City From' & 'City To'!");
//                        document.getElementById(mVarControlForCityFrom).focus();
//                        return false;
//                    }
//                }
//            }
//            
//            if(mVarBM == "" && mVarZM == "" && mVarCM == "")
//            {
//                alert("Enter Branch Matrix or Zone Matrix or City Matrix Details!");
//                document.getElementById("ctl00_MyCPH1_txtBranchCode").focus();   
//                return false;
//            }
//            
//            if(document.getElementById("ctl00_MyCPH1_HidBM"))
//            {
//                document.getElementById("ctl00_MyCPH1_HidBM").value = mVarBM;
//            }
//            else
//            {
//                alert("Hidden variable not found for storing Branch Matrix details!");
//                return false;
//            }
//            
//            if(document.getElementById("ctl00_MyCPH1_HidZM"))
//            {
//                document.getElementById("ctl00_MyCPH1_HidZM").value = mVarZM;
//            }
//            else
//            {
//                alert("Hidden variable not found for storing Zone Matrix details!");
//                return false;
//            }
//            
//            if(document.getElementById("ctl00_MyCPH1_HidCM"))
//            {
//                document.getElementById("ctl00_MyCPH1_HidCM").value = mVarCM;
//            }
//            else
//            {
//                alert("Hidden variable not found for storing City Matrix details!");
//                return false;
//            }
//            
////            alert(mVarBM);
////            alert(mVarZM);
////            alert(mVarCM);
////            
////            return false;
//            
//            return true;
//        }

        function ValidateData()
        {
            //Check for selection of Rate Type
            if(document.getElementById("ctl00_MyCPH1_ddlRateType"))
            {
                if(document.getElementById("ctl00_MyCPH1_ddlRateType").value == "-1")
                {
                    alert("Please select Rate Type from the list");
                    document.getElementById("ctl00_MyCPH1_ddlRateType").focus();
                    return false;
                }
            }
            else
            {
                alert("Selection list for Rate Type is not available!");
                return false;
            }
            
            //Check for Branch Matrix
//            if(document.getElementById("ctl00_MyCPH1_txtBranchCode"))
//            {
//                if(document.getElementById("ctl00_MyCPH1_txtBranchCode").value != "")
//                {
//                    if(document.getElementById("ctl00_MyCPH1_lblErrorBranchCode"))
//                    {
//                        if(document.getElementById("ctl00_MyCPH1_lblErrorBranchCode").style.display == '')
//                        {
//                            alert("Invalid 'Branch Code'");
//                            document.getElementById("ctl00_MyCPH1_txtBranchCode").focus();
//                            return false;
//                        }
//                    }
//                }
//                else
//                {
//                    alert("Enter/Select 'Branch Code'");
//                    document.getElementById("ctl00_MyCPH1_txtBranchCode").focus();
//                    return false;
//                }
//            }
//            else
//            {
//                alert("Input Box for 'Branch Code' is not available!");
//                return false;
//            }
            
            var mVarControlForBranchFrom;
            var mVarControlForBranchFromErrorLabel;
            var mVarControlForBranchTo;
            var mVarControlForBranchToErrorLabel;
            var mVarControlForBranchAir;
            var mVarControlForBranchAirTrDays;
            var mVarControlForBranchRoad;
            var mVarControlForBranchRoadTrDays;
            var mVarControlForBranchTrain;
            var mVarControlForBranchTrainTrDays;
            var mVarControlForBranchExpress;
            var mVarControlForBranchExpressTrDays;
            
            var mVarBM = "";
            var mVarBMTemp = "";
            
            //Check for Branch Matrix
            for(var mLoopCounter = 1 ; mLoopCounter <= 10; mLoopCounter++)
            {
                //Create control ID's
                mVarControlForBranchFrom = "ctl00_MyCPH1_txtFreightMatrixRow" + mLoopCounter + "From";
                mVarControlForBranchFromErrorLabel = "ctl00_MyCPH1_lblErrorFreightMatrixRow" + mLoopCounter + "From";
                mVarControlForBranchTo = "ctl00_MyCPH1_txtFreightMatrixRow" + mLoopCounter + "To";
                mVarControlForBranchToErrorLabel = "ctl00_MyCPH1_lblErrorFreightMatrixRow" + mLoopCounter + "To";
                
                mVarControlForBranchAir = "ctl00_MyCPH1_txtFreightForAirRow" + mLoopCounter;
                mVarControlForBranchAirTrDays = "ctl00_MyCPH1_txtAirTrDaysRow" + mLoopCounter;
                mVarControlForBranchRoad = "ctl00_MyCPH1_txtFreightForRoadRow" + mLoopCounter;
                mVarControlForBranchRoadTrDays = "ctl00_MyCPH1_txtRoadTrDaysRow" + mLoopCounter;
                mVarControlForBranchTrain = "ctl00_MyCPH1_txtFreightForTrainRow" + mLoopCounter;
                mVarControlForBranchTrainTrDays = "ctl00_MyCPH1_txtTrainTrDaysRow" + mLoopCounter;
                mVarControlForBranchExpress = "ctl00_MyCPH1_txtFreightForExpressRow" + mLoopCounter;
                mVarControlForBranchExpressTrDays = "ctl00_MyCPH1_txtExpressTrDaysRow" + mLoopCounter;
                
                //Check for Branch From
                if(document.getElementById(mVarControlForBranchFrom))
                {
                    if(document.getElementById(mVarControlForBranchFrom).value != "")
                    {
                        if(document.getElementById(mVarControlForBranchFromErrorLabel))
                        {
                            if(document.getElementById(mVarControlForBranchFromErrorLabel).style.display == '')
                            {
                                alert("Invalid 'Branch Code'");
                                document.getElementById(mVarControlForBranchFrom).focus();
                                return false;
                            }
                        }
                    }
                }
                else
                {
                    alert("Input Box for 'Branch Code' is not available!");
                    return false;
                }
                
                //Check for Branch To
                if(document.getElementById(mVarControlForBranchTo))
                {
                    if(document.getElementById(mVarControlForBranchTo).value != "")
                    {
                        if(document.getElementById(mVarControlForBranchToErrorLabel))
                        {
                            if(document.getElementById(mVarControlForBranchToErrorLabel).style.display == '')
                            {
                                alert("Invalid 'Branch Code'");
                                document.getElementById(mVarControlForBranchTo).focus();
                                return false;
                            }
                        }
                    }
                }
                else
                {
                    alert("Input Box for 'Branch Code' is not available!");
                    return false;
                }
                
                var mBranchAirFr = "";
                var mBranchAirTrDays = "";
                var mBranchRoadFr = "";
                var mBranchRoadTrDays = "";
                var mBranchTrainFr = "";
                var mBranchTrainTrDays = "";
                var mBranchExpressFr = "";
                var mBranchExpressTrDays = "";
                var mFlag = 0;
                
                //if(document.getElementById(mVarControlForBranchFrom) && document.getElementById(mVarControlForBranchTo) && ((document.getElementById(mVarControlForBranchAir) && document.getElementById(mVarControlForBranchAirTrDays)) || (document.getElementById(mVarControlForBranchRoad) && document.getElementById(mVarControlForBranchRoadTrDays)) || (document.getElementById(mVarControlForBranchTrain) && document.getElementById(mVarControlForBranchTrainTrDays)) || (document.getElementById(mVarControlForBranchExpress) && document.getElementById(mVarControlForBranchExpressTrDays))))
                if(document.getElementById(mVarControlForBranchFrom) && document.getElementById(mVarControlForBranchTo)) 
                {
                    if(document.getElementById(mVarControlForBranchAir) && document.getElementById(mVarControlForBranchAirTrDays))
                    {
                        mBranchAirFr = document.getElementById(mVarControlForBranchAir).value;
                        mBranchAirTrDays = document.getElementById(mVarControlForBranchAirTrDays).value;
                    }
                    if(document.getElementById(mVarControlForBranchRoad) && document.getElementById(mVarControlForBranchRoadTrDays))
                    {
                        mBranchRoadFr = document.getElementById(mVarControlForBranchRoad).value;
                        mBranchRoadTrDays = document.getElementById(mVarControlForBranchRoadTrDays).value;
                    }
                    if(document.getElementById(mVarControlForBranchTrain) && document.getElementById(mVarControlForBranchTrainTrDays))
                    {
                        mBranchTrainFr = document.getElementById(mVarControlForBranchTrain).value;
                        mBranchTrainTrDays = document.getElementById(mVarControlForBranchTrainTrDays).value;
                    }
                    if(document.getElementById(mVarControlForBranchExpress) && document.getElementById(mVarControlForBranchExpressTrDays))
                    {
                        mBranchExpressFr = document.getElementById(mVarControlForBranchExpress).value;
                        mBranchExpressTrDays = document.getElementById(mVarControlForBranchExpressTrDays).value;
                    }
                    //if(document.getElementById(mVarControlForBranchFrom).value == "" && document.getElementById(mVarControlForBranchTo).value == "" && ((document.getElementById(mVarControlForBranchAir).value == "" && document.getElementById(mVarControlForBranchAirTrDays).value == "") || (document.getElementById(mVarControlForBranchRoad).value == "" && document.getElementById(mVarControlForBranchRoadTrDays).value == "") || (document.getElementById(mVarControlForBranchTrain).value == "" && document.getElementById(mVarControlForBranchTrainTrDays).value == "") || (document.getElementById(mVarControlForBranchExpress).value == "" && document.getElementById(mVarControlForBranchExpressTrDays).value == "")))
                    if(document.getElementById(mVarControlForBranchFrom).value == "" && document.getElementById(mVarControlForBranchTo).value == "")
                    {
                        if(mBranchRoadFr == "" && mBranchRoadTrDays == "" && mBranchAirFr == "" && mBranchAirTrDays == "" && mBranchTrainFr == "" && mBranchTrainTrDays == "" && mBranchExpressFr == "" && mBranchExpressTrDays == "")
                        {
//                            if(mLoopCounter == 1)
//                            {
//                                alert("Enter Branch Matrix Details!");
//                                document.getElementById(mVarControlForBranchFrom).focus();
//                                return false;
//                            }   
                        }
                    }
                    else
                    {
                        if(document.getElementById(mVarControlForBranchFrom).value == "")
                        {
                            alert("Enter 'Branch From' for Branch Matrix!");
                            document.getElementById(mVarControlForBranchFrom).focus();
                            return false;
                        }
                        else
                        {
                            mVarBMTemp = document.getElementById(mVarControlForBranchFrom).value;
                        }
                        if(document.getElementById(mVarControlForBranchTo).value == "")
                        {
                            alert("Enter 'Branch To' for Branch Matrix!");
                            document.getElementById(mVarControlForBranchTo).focus();
                            return false;
                        }
                        else
                        {
                            mVarBMTemp += "," + document.getElementById(mVarControlForBranchTo).value;
                        }
                        
                        //Check for Different Branch From & To
                        var mVarBranchFrom = document.getElementById(mVarControlForBranchFrom).value;
                        var mVarBranchTo = document.getElementById(mVarControlForBranchTo).value;
                        
                        if(mVarBranchFrom == mVarBranchTo)
                        {
                            alert("'Branch From' & 'Branch To' must be different!");
                            document.getElementById(mVarControlForBranchFrom).focus();
                            return false;
                        }
                        
                        if(mBranchAirFr == "" && mBranchAirTrDays == "" && mBranchRoadFr == "" && mBranchRoadTrDays == "" && mBranchTrainFr == "" && mBranchTrainTrDays == "" && mBranchExpressFr == "" && mBranchExpressTrDays == "")
                        {
                            alert("Enter 'Freight Rate & Transit Days' for " + "<%=strAir %>" + " OR " + "<%=strRoad %>" + " OR " + "<%=strTrain %>" + " OR " + "<%=strExpress %>" + " for Branch Matrix!");
                            if(document.getElementById(mVarControlForBranchAir))
                            {
                                document.getElementById(mVarControlForBranchAir).focus();
                            }
                            else if(document.getElementById(mVarControlForBranchRoad))
                            {
                                document.getElementById(mVarControlForBranchRoad).focus();
                            }
                            else if(document.getElementById(mVarControlForBranchTrain))
                            {
                                document.getElementById(mVarControlForBranchTrain).focus();
                            }
                            else if(document.getElementById(mVarControlForBranchExpress))
                            {
                                document.getElementById(mVarControlForBranchExpress).focus();
                            }
                            
                            return false;
                        }
                        
                        if(mBranchAirFr == "" && mBranchAirTrDays != "")
                        {
                            alert("Enter 'Freight Rate & Transit Days' for " + "<%=strAir %>" + " for Branch Matrix!");
                            document.getElementById(mVarControlForBranchAir).focus();
                            return false;
                        }
                        else if(mBranchAirFr != "" && mBranchAirTrDays == "")
                        {
                            alert("Enter 'Freight Rate & Transit Days' for " + "<%=strAir %>" + " for Branch Matrix!");
                            document.getElementById(mVarControlForBranchAirTrDays).focus();
                            return false;
                        }
                        
                        if(mBranchRoadFr == "" && mBranchRoadTrDays != "")
                        {
                            alert("Enter 'Freight Rate & Transit Days' for " + "<%=strRoad %>" + " for Branch Matrix!");
                            document.getElementById(mVarControlForBranchRoad).focus();
                            return false;
                        }
                        else if(mBranchRoadFr != "" && mBranchRoadTrDays == "")
                        {
                            alert("Enter 'Freight Rate & Transit Days' for " + "<%=strRoad %>" + " for Branch Matrix!");
                            document.getElementById(mVarControlForBranchRoadTrDays).focus();
                            return false;
                        }
                        
                        if(mBranchTrainFr == "" && mBranchTrainTrDays != "")
                        {
                            alert("Enter 'Freight Rate & Transit Days' for " + "<%=strTrain %>" + " for Branch Matrix!");
                            document.getElementById(mVarControlForBranchTrain).focus();
                            return false;
                        }
                        else if(mBranchTrainFr != "" && mBranchTrainTrDays == "")
                        {
                            alert("Enter 'Freight Rate & Transit Days' for " + "<%=strTrain %>" + " for Branch Matrix!");
                            document.getElementById(mVarControlForBranchTrainTrDays).focus();
                            return false;
                        }
                        
                        if(mBranchExpressFr == "" && mBranchExpressTrDays != "")
                        {
                            alert("Enter 'Freight Rate & Transit Days' for " + "<%=strExpress %>" + " for Branch Matrix!");
                            document.getElementById(mVarControlForBranchExpress).focus();
                            return false;
                        }
                        else if(mBranchExpressFr != "" && mBranchExpressTrDays == "")
                        {
                            alert("Enter 'Freight Rate & Transit Days' for " + "<%=strExpress %>" + " for Branch Matrix!");
                            document.getElementById(mVarControlForBranchExpressTrDays).focus();
                            return false;
                        }
                        
                        if(document.getElementById(mVarControlForBranchAir))
                        {
                            if(document.getElementById(mVarControlForBranchAir).value == "")
                            {
//                                alert("Enter 'Freight Rate' for 'Air' for Branch Matrix!");
//                                document.getElementById(mVarControlForBranchAir).focus();
//                                return false;
                                mVarBMTemp += "," + "0.0";
                            }
                            else
                            {
                                mVarBMTemp += "," + document.getElementById(mVarControlForBranchAir).value;
                            }
                        }
                        else
                        {
                            mVarBMTemp += "," + "0.0";
                        }
                        if(document.getElementById(mVarControlForBranchAirTrDays))
                        {
                            if(document.getElementById(mVarControlForBranchAirTrDays).value == "")
                            {
//                                alert("Enter 'Transit Days' for 'Air' for Branch Matrix!");
//                                document.getElementById(mVarControlForBranchAirTrDays).focus();
//                                return false;
                                mVarBMTemp += "," + "0.0";
                            }
                            else
                            {
                                mVarBMTemp += "," + document.getElementById(mVarControlForBranchAirTrDays).value;
                            }
                        }
                        else
                        {
                            mVarBMTemp += "," + "0.0";
                        }
                        if(document.getElementById(mVarControlForBranchRoad))
                        {
                            if(document.getElementById(mVarControlForBranchRoad).value == "")
                            {
//                                alert("Enter 'Freight Rate' for 'Road' for Branch Matrix!");
//                                document.getElementById(mVarControlForBranchRoad).focus();
//                                return false;
                                mVarBMTemp += "," + "0.0";
                            }
                            else
                            {
                                mVarBMTemp += "," + document.getElementById(mVarControlForBranchRoad).value;
                            }
                        }
                        else
                        {
                            mVarBMTemp += "," + "0.0";
                        }
                        if(document.getElementById(mVarControlForBranchRoadTrDays))
                        {
                            if(document.getElementById(mVarControlForBranchRoadTrDays).value == "")
                            {
//                                alert("Enter 'Transit Days' for 'Road' for Branch Matrix!");
//                                document.getElementById(mVarControlForBranchRoadTrDays).focus();
//                                return false;
                                mVarBMTemp += "," + "0.0";
                            }
                            else
                            {
                                mVarBMTemp += "," + document.getElementById(mVarControlForBranchRoadTrDays).value;
                            }
                        }
                        else
                        {
                            mVarBMTemp += "," + "0.0";
                        }
                        if(document.getElementById(mVarControlForBranchTrain))
                        {
                            if(document.getElementById(mVarControlForBranchTrain).value == "")
                            {
//                                alert("Enter 'Freight Rate' for 'Train' for Branch Matrix!");
//                                document.getElementById(mVarControlForBranchTrain).focus();
//                                return false;
                                mVarBMTemp += "," + "0.0";
                            }
                            else
                            {
                                mVarBMTemp += "," + document.getElementById(mVarControlForBranchTrain).value;
                            }
                        }
                        else
                        {
                            mVarBMTemp += "," + "0.0";
                        }
                        if(document.getElementById(mVarControlForBranchTrainTrDays))
                        {
                            if(document.getElementById(mVarControlForBranchTrainTrDays).value == "")
                            {
//                                alert("Enter 'Transit Days' for 'Train' for Branch Matrix!");
//                                document.getElementById(mVarControlForBranchTrain).focus();
//                                return false;
                                mVarBMTemp += "," + "0.0";
                            }
                            else
                            {
                                mVarBMTemp += "," + document.getElementById(mVarControlForBranchTrainTrDays).value;
                            }
                        }
                        else
                        {
                            mVarBMTemp += "," + "0.0";
                        }
                        if(document.getElementById(mVarControlForBranchExpress))
                        {
                            if(document.getElementById(mVarControlForBranchExpress).value == "")
                            {
//                                alert("Enter 'Freight Rate' for 'Express' for Branch Matrix!");
//                                document.getElementById(mVarControlForBranchExpress).focus();
//                                return false;
                                mVarBMTemp += "," + "0.0";
                            }
                            else
                            {
                                mVarBMTemp += "," + document.getElementById(mVarControlForBranchExpress).value;
                            }
                        }
                        else
                        {
                            mVarBMTemp += "," + "0.0";
                        }
                        if(document.getElementById(mVarControlForBranchExpressTrDays))
                        {
                            if(document.getElementById(mVarControlForBranchExpressTrDays).value == "")
                            {
//                                alert("Enter 'Transit Days' for 'Express' for Branch Matrix!");
//                                document.getElementById(mVarControlForBranchExpressTrDays).focus();
//                                return false;
                                mVarBMTemp += "," + "0.0";
                            }
                            else
                            {
                                mVarBMTemp += "," + document.getElementById(mVarControlForBranchExpressTrDays).value;
                            }
                        }
                        else
                        {
                            mVarBMTemp += "," + "0.0";
                        }
                    }
                    if(mVarBMTemp != "")
                    {
                        mVarBM = (mVarBM == "" ? mVarBMTemp : mVarBM + "~" + mVarBMTemp);
                        mVarBMTemp = "";
                    }
                }
            }
            
            //Check for Distinct Pair of Branch From & To
            for(var mLoopCounter = 1 ; mLoopCounter <= 10; mLoopCounter++)
            {
                //Create control ID's
                mVarControlForBranchFrom = "ctl00_MyCPH1_txtFreightMatrixRow" + mLoopCounter + "From";
                mVarControlForBranchTo = "ctl00_MyCPH1_txtFreightMatrixRow" + mLoopCounter + "To";
                
                var mVarBranchFrom = document.getElementById(mVarControlForBranchFrom).value;
                var mVarBranchTo = document.getElementById(mVarControlForBranchTo).value;
                
                if(mVarBranchFrom != "" && mVarBranchTo != "")
                {
                    if(CheckDuplicateBranch(mVarBranchFrom, mVarBranchTo, mLoopCounter) == true)
                    {
                        alert("Please enter distinct 'Branch From' & 'Branch To'!");
                        document.getElementById(mVarControlForBranchFrom).focus();
                        return false;
                    }
                }
            }
            
            //Check for selection of Zone Header
//            if(document.getElementById("ctl00_MyCPH1_ddlZoneHeader"))
//            {
//                if(document.getElementById("ctl00_MyCPH1_ddlZoneHeader").value == "-1")
//                {
//                    alert("Please select Zone from the list");
//                    document.getElementById("ctl00_MyCPH1_ddlZoneHeader").focus();
//                    return false;
//                }
//            }
//            else
//            {
//                alert("Selection list for Zone Header is not available!");
//                return false;
//            }
            
            var mVarControlForZoneFrom;
            var mVarControlForZoneTo;
            var mVarControlForZoneAir;
            var mVarControlForZoneAirTrDays;
            var mVarControlForZoneRoad;
            var mVarControlForZoneRoadTrDays;
            var mVarControlForZoneTrain;
            var mVarControlForZoneTrainTrDays;
            var mVarControlForZoneExpress;
            var mVarControlForZoneExpressTrDays;
            
            var mVarZM = "";
            var mVarZMTemp = "";
            
            var mVarZoneAir = "";
            var mVarZoneAirTrDays = "";
            var mVarZoneRoad = "";
            var mVarZoneRoadTrDays = "";
            var mVarZoneTrain = "";
            var mVarZoneTrainTrDays = "";
            var mVarZoneExpress = "";
            var mVarZoneExpressTrDays = "";
            
            //Check for Zone Matrix
            for(var mLoopCounter = 1 ; mLoopCounter <= 10; mLoopCounter++)
            {
                //Create control ID's
                mVarControlForZoneFrom = "ctl00_MyCPH1_ddlZoneFromForRow" + mLoopCounter;
                mVarControlForZoneTo = "ctl00_MyCPH1_ddlZoneToForRow" + mLoopCounter;
                
                mVarControlForZoneAir = "ctl00_MyCPH1_txtFreightForAirZoneForRow" + mLoopCounter;
                mVarControlForZoneAirTrDays = "ctl00_MyCPH1_txtAirTrDaysRowForZone" + mLoopCounter;
                mVarControlForZoneRoad = "ctl00_MyCPH1_txtFreightForRoadZoneForRow" + mLoopCounter;
                mVarControlForZoneRoadTrDays = "ctl00_MyCPH1_txtRoadTrDaysRowForZone" + mLoopCounter;
                mVarControlForZoneTrain = "ctl00_MyCPH1_txtFreightForTrainZoneForRow" + mLoopCounter;
                mVarControlForZoneTrainTrDays = "ctl00_MyCPH1_txtTrainTrDaysRowForZone" + mLoopCounter;
                mVarControlForZoneExpress = "ctl00_MyCPH1_txtFreightForExpressZoneForRow" + mLoopCounter;
                mVarControlForZoneExpressTrDays = "ctl00_MyCPH1_txtExpressTrDaysRowForZone" + mLoopCounter;
                
                mVarZoneAir = "";
                mVarZoneAirTrDays = "";
                mVarZoneRoad = "";
                mVarZoneRoadTrDays = "";
                mVarZoneTrain = "";
                mVarZoneTrainTrDays = "";
                mVarZoneExpress = "";
                mVarZoneExpressTrDays = "";
                
                //if(document.getElementById(mVarControlForZoneFrom) && document.getElementById(mVarControlForZoneTo) && ((document.getElementById(mVarControlForZoneAir) && document.getElementById(mVarControlForZoneAirTrDays)) || (document.getElementById(mVarControlForZoneRoad) && document.getElementById(mVarControlForZoneRoadTrDays)) || (document.getElementById(mVarControlForZoneTrain) && document.getElementById(mVarControlForZoneTrainTrDays)) || (document.getElementById(mVarControlForZoneExpress) && document.getElementById(mVarControlForZoneExpressTrDays))))
                if(document.getElementById(mVarControlForZoneFrom) && document.getElementById(mVarControlForZoneTo)) 
                {
                    //&& ((document.getElementById(mVarControlForZoneAir) && document.getElementById(mVarControlForZoneAirTrDays)) || (document.getElementById(mVarControlForZoneRoad) && document.getElementById(mVarControlForZoneRoadTrDays)) || (document.getElementById(mVarControlForZoneTrain) && document.getElementById(mVarControlForZoneTrainTrDays)) || (document.getElementById(mVarControlForZoneExpress) && document.getElementById(mVarControlForZoneExpressTrDays))))
                    if(document.getElementById(mVarControlForZoneAir) && document.getElementById(mVarControlForZoneAirTrDays))
                    {
                        mVarZoneAir = document.getElementById(mVarControlForZoneAir).value;
                        mVarZoneAirTrDays = document.getElementById(mVarControlForZoneAirTrDays).value;  
                    }
                    
                    if(document.getElementById(mVarControlForZoneRoad) && document.getElementById(mVarControlForZoneRoadTrDays))
                    {
                        mVarZoneRoad = document.getElementById(mVarControlForZoneRoad).value;
                        mVarZoneRoadTrDays = document.getElementById(mVarControlForZoneRoadTrDays).value;  
                    }
                    
                    if(document.getElementById(mVarControlForZoneTrain) && document.getElementById(mVarControlForZoneTrainTrDays))
                    {
                        mVarZoneTrain = document.getElementById(mVarControlForZoneTrain).value;
                        mVarZoneTrainTrDays = document.getElementById(mVarControlForZoneTrainTrDays).value;  
                    }
                    
                    if(document.getElementById(mVarControlForZoneExpress) && document.getElementById(mVarControlForZoneExpressTrDays))
                    {
                        mVarZoneExpress = document.getElementById(mVarControlForZoneExpress).value;
                        mVarZoneExpressTrDays = document.getElementById(mVarControlForZoneExpressTrDays).value;  
                    }
                    
                    //if(document.getElementById(mVarControlForZoneFrom).value != "-1" && document.getElementById(mVarControlForZoneTo).value == "-1" && ((document.getElementById(mVarControlForZoneAir).value == "" && document.getElementById(mVarControlForZoneAirTrDays).value == "") || (document.getElementById(mVarControlForZoneRoad).value == "" && document.getElementById(mVarControlForZoneRoadTrDays).value == "") || (document.getElementById(mVarControlForZoneTrain).value == "" && document.getElementById(mVarControlForZoneTrainTrDays).value == "") || (document.getElementById(mVarControlForZoneExpress).value == "" && document.getElementById(mVarControlForZoneExpressTrDays).value == "")))
                    if(document.getElementById(mVarControlForZoneFrom).value == "-1" && document.getElementById(mVarControlForZoneTo).value == "-1")
                    {
                        //&& ((document.getElementById(mVarControlForZoneAir).value == "" && document.getElementById(mVarControlForZoneAirTrDays).value == "") || (document.getElementById(mVarControlForZoneRoad).value == "" && document.getElementById(mVarControlForZoneRoadTrDays).value == "") || (document.getElementById(mVarControlForZoneTrain).value == "" && document.getElementById(mVarControlForZoneTrainTrDays).value == "") || (document.getElementById(mVarControlForZoneExpress).value == "" && document.getElementById(mVarControlForZoneExpressTrDays).value == "")))
                        if(mVarZoneAir == "" && mVarZoneAirTrDays == "" &&  mVarZoneRoad == "" && mVarZoneRoadTrDays == "" && mVarZoneTrain == "" && mVarZoneTrainTrDays == "" && mVarZoneExpress == "" && mVarZoneExpressTrDays == "")
                        {
//                            if(mLoopCounter == 1)
//                            {
//                                alert("Enter Zone Matrix Details!");
//                                document.getElementById(mVarControlForZoneFrom).focus();
//                                return false;
//                            }
                        }
                    }
                    else
                    {
                        if(document.getElementById(mVarControlForZoneFrom).value == "-1")
                        {
                            alert("Select 'Zone From' for Zone Matrix!");
                            document.getElementById(mVarControlForZoneFrom).focus();
                            return false;
                        }
                        else
                        {
                            mVarZMTemp = document.getElementById(mVarControlForZoneFrom).value;
                        }
                        if(document.getElementById(mVarControlForZoneTo).value == "-1")
                        {
                            alert("Select 'Branch To' for Branch Matrix!");
                            document.getElementById(mVarControlForZoneTo).focus();
                            return false;
                        }
                        else
                        {
                            mVarZMTemp += "," + document.getElementById(mVarControlForZoneTo).value;
                        }
                        
                        //Check for Different Zone From & To
                        var mVarZoneFrom = document.getElementById(mVarControlForZoneFrom).value;
                        var mVarZoneTo = document.getElementById(mVarControlForZoneTo).value;
                        
                        if(mVarZoneFrom == mVarZoneTo)
                        {
                            alert("'Zone From' & 'Zone To' must be different!");
                            document.getElementById(mVarControlForZoneFrom).focus();
                            return false;
                        }
                        
                        if(mVarZoneAir == "" && mVarZoneAirTrDays == "" && mVarZoneRoad == "" && mVarZoneRoadTrDays == "" && mVarZoneTrain == "" && mVarZoneTrainTrDays == "" && mVarZoneExpress == "" && mVarZoneExpressTrDays == "")
                        {
                            alert("Enter 'Freight Rate & Transit Days' for " + "<%=strAir %>" + " OR " + "<%=strRoad %>" + " OR " + "<%=strTrain %>" + " OR " + "<%=strExpress %>" + " for Zone Matrix!");
                            if(document.getElementById(mVarControlForZoneAir))
                            {
                                document.getElementById(mVarControlForZoneAir).focus();
                            }
                            else if(document.getElementById(mVarControlForZoneRoad))
                            {
                                document.getElementById(mVarControlForZoneRoad).focus();
                            }
                            else if(document.getElementById(mVarControlForZoneTrain))
                            {
                                document.getElementById(mVarControlForZoneTrain).focus();
                            }
                            else if(document.getElementById(mVarControlForZoneExpress))
                            {
                                document.getElementById(mVarControlForZoneExpress).focus();
                            }
                            return false;
                        }
                        
                        if(mVarZoneAir == "" && mVarZoneAirTrDays != "")
                        {
                            alert("Enter 'Freight Rate & Transit Days' for " + "<%=strAir %>" + " for Zone Matrix!");
                            document.getElementById(mVarControlForZoneAir).focus();
                            return false;
                        }
                        else if(mVarZoneAir != "" && mVarZoneAirTrDays == "")
                        {
                            alert("Enter 'Freight Rate & Transit Days' for " + "<%=strAir %>" + " for Zone Matrix!");
                            document.getElementById(mVarControlForZoneAirTrDays).focus();
                            return false;
                        }
                        
                        if(mVarZoneRoad == "" && mVarZoneRoadTrDays != "")
                        {
                            alert("Enter 'Freight Rate & Transit Days' for " + "<%=strRoad %>" + " for Zone Matrix!");
                            document.getElementById(mVarControlForZoneRoad).focus();
                            return false;
                        }
                        else if(mVarZoneRoad != "" && mVarZoneRoadTrDays == "")
                        {
                            alert("Enter 'Freight Rate & Transit Days' for " + "<%=strRoad %>" + " for Zone Matrix!");
                            document.getElementById(mVarControlForZoneRoadTrDays).focus();
                            return false;
                        }
                        
                        if(mVarZoneTrain == "" && mVarZoneTrainTrDays != "")
                        {
                            alert("Enter 'Freight Rate & Transit Days' for " + "<%=strTrain %>" + " for Zone Matrix!");
                            document.getElementById(mVarControlForZoneTrain).focus();
                            return false;
                        }
                        else if(mVarZoneTrain != "" && mVarZoneTrainTrDays == "")
                        {
                            alert("Enter 'Freight Rate & Transit Days' for " + "<%=strTrain %>" + " for Zone Matrix!");
                            document.getElementById(mVarControlForZoneTrainTrDays).focus();
                            return false;
                        }
                        
                        if(mVarZoneExpress == "" && mVarZoneExpressTrDays != "")
                        {
                            alert("Enter 'Freight Rate & Transit Days' for " + "<%=strExpress %>" + " for Zone Matrix!");
                            document.getElementById(mVarControlForZoneExpress).focus();
                            return false;
                        }
                        else if(mVarZoneExpress != "" && mVarZoneExpressTrDays == "")
                        {
                            alert("Enter 'Freight Rate & Transit Days' for " + "<%=strExpress %>" + " for Zone Matrix!");
                            document.getElementById(mVarControlForZoneExpressTrDays).focus();
                            return false;
                        }
                        
                        if(document.getElementById(mVarControlForZoneAir))
                        {
                            if(document.getElementById(mVarControlForZoneAir).value == "")
                            {
//                                alert("Enter 'Freight Rate' for 'Air' for Zone Matrix!");
//                                document.getElementById(mVarControlForZoneAir).focus();
//                                return false;
                                mVarZMTemp += "," + "0.0";
                            }
                            else
                            {
                                mVarZMTemp += "," + document.getElementById(mVarControlForZoneAir).value;
                            }
                        }
                        else
                        {
                            mVarZMTemp += "," + "0.0";
                        }
                        if(document.getElementById(mVarControlForZoneAirTrDays))
                        {
                            if(document.getElementById(mVarControlForZoneAirTrDays).value == "")
                            {
//                                alert("Enter 'Transit Days' for 'Air' for Zone Matrix!");
//                                document.getElementById(mVarControlForZoneAirTrDays).focus();
//                                return false;
                                mVarZMTemp += "," + "0.0";
                            }
                            else
                            {
                                mVarZMTemp += "," + document.getElementById(mVarControlForZoneAirTrDays).value;
                            }
                        }
                        else
                        {
                            mVarZMTemp += "," + "0.0";
                        }
                        
                        if(document.getElementById(mVarControlForZoneRoad))
                        {
                            if(document.getElementById(mVarControlForZoneRoad).value == "")
                            {
//                                alert("Enter 'Freight Rate' for 'Road' for Zone Matrix!");
//                                document.getElementById(mVarControlForZoneRoad).focus();
//                                return false;
                                mVarZMTemp += "," + "0.0";
                            }
                            else
                            {
                                mVarZMTemp += "," + document.getElementById(mVarControlForZoneRoad).value;
                            }
                        }
                        else
                        {
                            mVarZMTemp += "," + "0.0";
                        }
                        if(document.getElementById(mVarControlForZoneRoadTrDays))
                        {
                            if(document.getElementById(mVarControlForZoneRoadTrDays).value == "")
                            {
//                                alert("Enter 'Transit Days' for 'Road' for Zone Matrix!");
//                                document.getElementById(mVarControlForZoneRoadTrDays).focus();
//                                return false;
                                mVarZMTemp += "," + "0.0";
                            }
                            else
                            {
                                mVarZMTemp += "," + document.getElementById(mVarControlForZoneRoadTrDays).value;
                            }
                        }
                        else
                        {
                            mVarZMTemp += "," + "0.0";
                        }
                        
                        if(document.getElementById(mVarControlForZoneTrain))
                        {
                            if(document.getElementById(mVarControlForZoneTrain).value == "")
                            {
//                                alert("Enter 'Freight Rate' for 'Train' for Zone Matrix!");
//                                document.getElementById(mVarControlForZoneTrain).focus();
//                                return false;
                                mVarZMTemp += "," + "0.0";
                            }
                            else
                            {
                                mVarZMTemp += "," + document.getElementById(mVarControlForZoneTrain).value;
                            }
                        }
                        else
                        {
                            mVarZMTemp += "," + "0.0";
                        }
                        if(document.getElementById(mVarControlForZoneTrainTrDays))
                        {
                            if(document.getElementById(mVarControlForZoneTrainTrDays).value == "")
                            {
//                                alert("Enter 'Transit Days' for 'Train' for Zone Matrix!");
//                                document.getElementById(mVarControlForZoneTrainTrDays).focus();
//                                return false;
                                mVarZMTemp += "," + "0.0";
                            }
                            else
                            {
                                mVarZMTemp += "," + document.getElementById(mVarControlForZoneTrainTrDays).value;
                            }
                        }
                        else
                        {
                            mVarZMTemp += "," + "0.0";
                        }
                        
                        if(document.getElementById(mVarControlForZoneExpress))
                        {
                            if(document.getElementById(mVarControlForZoneExpress).value == "")
                            {
//                                alert("Enter 'Freight Rate' for 'Express' for Zone Matrix!");
//                                document.getElementById(mVarControlForZoneExpress).focus();
//                                return false;
                                mVarZMTemp += "," + "0.0";
                            }
                            else
                            {
                                mVarZMTemp += "," + document.getElementById(mVarControlForZoneExpress).value;
                            }
                        }
                        else
                        {
                            mVarZMTemp += "," + "0.0";
                        }
                        if(document.getElementById(mVarControlForZoneExpressTrDays))
                        {
                            if(document.getElementById(mVarControlForZoneExpressTrDays).value == "")
                            {
//                                alert("Enter 'Transit Days' for 'Express' for Zone Matrix!");
//                                document.getElementById(mVarControlForZoneExpressTrDays).focus();
//                                return false;
                                mVarZMTemp += "," + "0.0";
                            }
                            else
                            {
                                mVarZMTemp += "," + document.getElementById(mVarControlForZoneExpressTrDays).value;
                            }
                        }
                        else
                        {
                            mVarZMTemp += "," + "0.0";
                        }
                    }
                    if(mVarZMTemp != "")
                    {
                        mVarZM = (mVarZM == "" ? mVarZMTemp : mVarZM + "~" + mVarZMTemp);
                        mVarZMTemp = "";
                    }
                }
            }
            
            //Check for Distinct Pair of Zone From & To
            for(var mLoopCounter = 1 ; mLoopCounter <= 10; mLoopCounter++)
            {
                //Create control ID's
                mVarControlForZoneFrom = "ctl00_MyCPH1_ddlZoneFromForRow" + mLoopCounter;
                mVarControlForZoneTo = "ctl00_MyCPH1_ddlZoneToForRow" + mLoopCounter;
                
                var mVarZoneFrom = document.getElementById(mVarControlForZoneFrom).value;
                var mVarZoneTo = document.getElementById(mVarControlForZoneTo).value;
                
                if(mVarZoneTo != "-1")
                {
                    if(CheckDuplicateZone(mVarZoneFrom, mVarZoneTo, mLoopCounter) == true)
                    {
                        alert("Please enter distinct 'Zone From' & 'Zone To'!");
                        document.getElementById(mVarControlForZoneFrom).focus();
                        return false;
                    }
                }
            }
            
            //Check for City Matrix
//            if(document.getElementById("ctl00_MyCPH1_txtCity"))
//            {
//                if(document.getElementById("ctl00_MyCPH1_txtCity").value != "")
//                {
//                    if(document.getElementById("ctl00_MyCPH1_lblErrorCity"))
//                    {
//                        if(document.getElementById("ctl00_MyCPH1_lblErrorCity").style.display == '')
//                        {
//                            alert("Invalid 'City Name'");
//                            document.getElementById("ctl00_MyCPH1_txtCity").focus();
//                            return false;
//                        }
//                    }
//                }
//                else
//                {
//                    alert("Enter/Select 'City Name'");
//                    document.getElementById("ctl00_MyCPH1_txtCity").focus();
//                    return false;
//                }
//            }
            
            var mVarControlForCityFrom;
            var mVarControlForCityFromErrorLabel;
            var mVarControlForCityTo;
            var mVarControlForCityToErrorLabel;
            var mVarControlForCityAir;
            var mVarControlForCityAirTrDays;
            var mVarControlForCityRoad;
            var mVarControlForCityRoadTrDays;
            var mVarControlForCityTrain;
            var mVarControlForCityTrainTrDays;
            var mVarControlForCityExpress;
            var mVarControlForCityExpressTrDays;
            
            var mVarCM = "";
            var mVarCMTemp = "";
            
            var mVarCityAir = "";
            var mVarCityAirTrDays = "";
            var mVarCityRoad = "";
            var mVarCityRoadTrDays = "";
            var mVarCityTrain = "";
            var mVarCityTrainTrDays = "";
            var mVarCityExpress = "";
            var mVarCityExpressTrDays = "";
            
            //Check for City Matrix
            for(var mLoopCounter = 1 ; mLoopCounter <= 10; mLoopCounter++)
            {
                //Create control ID's
                mVarControlForCityFrom = "ctl00_MyCPH1_txtFromCityRow" + mLoopCounter;
                mVarControlForCityFromErrorLabel = "ctl00_MyCPH1_lblErrorFromCityRow" + mLoopCounter;
                mVarControlForCityTo = "ctl00_MyCPH1_txtToCityRow" + mLoopCounter;
                mVarControlForCityToErrorLabel = "ctl00_MyCPH1_lblErrorToCityRow" + mLoopCounter;
                
                mVarControlForCityAir = "ctl00_MyCPH1_txtAirCityForRow" + mLoopCounter;
                mVarControlForCityAirTrDays = "ctl00_MyCPH1_txtAirTrDaysRowForCity" + mLoopCounter;
                mVarControlForCityRoad = "ctl00_MyCPH1_txtRoadCityForRow" + mLoopCounter;
                mVarControlForCityRoadTrDays = "ctl00_MyCPH1_txtRoadTrDaysRowForCity" + mLoopCounter;
                mVarControlForCityTrain = "ctl00_MyCPH1_txtTrainCityForRow" + mLoopCounter;
                mVarControlForCityTrainTrDays = "ctl00_MyCPH1_txtTrainTrDaysRowForCity" + mLoopCounter;
                mVarControlForCityExpress = "ctl00_MyCPH1_txtExpressCityForRow" + mLoopCounter;
                mVarControlForCityExpressTrDays = "ctl00_MyCPH1_txtExpressTrDaysRowForCity" + mLoopCounter;
                
                //Check for City From
                if(document.getElementById(mVarControlForCityFrom))
                {
                    if(document.getElementById(mVarControlForCityFrom).value != "")
                    {
                        if(document.getElementById(mVarControlForCityFromErrorLabel))
                        {
                            if(document.getElementById(mVarControlForCityFromErrorLabel).style.display == '')
                            {
                                alert("Invalid 'City Name'");
                                document.getElementById(mVarControlForCityFrom).focus();
                                return false;
                            }
                        }
                    }
                }
                
                //Check for City To
                if(document.getElementById(mVarControlForCityTo))
                {
                    if(document.getElementById(mVarControlForCityTo).value != "")
                    {
                        if(document.getElementById(mVarControlForCityToErrorLabel))
                        {
                            if(document.getElementById(mVarControlForCityToErrorLabel).style.display == '')
                            {
                                alert("Invalid 'City Name'");
                                document.getElementById(mVarControlForCityTo).focus();
                                return false;
                            }
                        }
                    }
                }
                
                //if(document.getElementById(mVarControlForCityFrom) && document.getElementById(mVarControlForCityTo) && ((document.getElementById(mVarControlForCityAir) && document.getElementById(mVarControlForCityAirTrDays)) || (document.getElementById(mVarControlForCityRoad) && document.getElementById(mVarControlForCityRoadTrDays)) || (document.getElementById(mVarControlForCityTrain) && document.getElementById(mVarControlForCityTrainTrDays)) || (document.getElementById(mVarControlForCityExpress) && document.getElementById(mVarControlForCityExpressTrDays))))
                if(document.getElementById(mVarControlForCityFrom) && document.getElementById(mVarControlForCityTo)) 
                {
                    //&& ((document.getElementById(mVarControlForCityAir) && document.getElementById(mVarControlForCityAirTrDays)) || (document.getElementById(mVarControlForCityRoad) && document.getElementById(mVarControlForCityRoadTrDays)) || (document.getElementById(mVarControlForCityTrain) && document.getElementById(mVarControlForCityTrainTrDays)) || (document.getElementById(mVarControlForCityExpress) && document.getElementById(mVarControlForCityExpressTrDays))))
                    if(document.getElementById(mVarControlForCityAir) && document.getElementById(mVarControlForCityAirTrDays))
                    {
                        mVarCityAir = document.getElementById(mVarControlForCityAir).value;
                        mVarCityAirTrDays = document.getElementById(mVarControlForCityAirTrDays).value;  
                    }
                    
                    if(document.getElementById(mVarControlForCityRoad) && document.getElementById(mVarControlForCityRoadTrDays))
                    {
                        mVarCityRoad = document.getElementById(mVarControlForCityRoad).value;
                        mVarCityRoadTrDays = document.getElementById(mVarControlForCityRoadTrDays).value;  
                    }
                    
                    if(document.getElementById(mVarControlForCityTrain) && document.getElementById(mVarControlForCityTrainTrDays))
                    {
                        mVarCityTrain = document.getElementById(mVarControlForCityTrain).value;
                        mVarCityTrainTrDays = document.getElementById(mVarControlForCityTrainTrDays).value;  
                    }
                    
                    if(document.getElementById(mVarControlForCityExpress) && document.getElementById(mVarControlForCityExpressTrDays))
                    {
                        mVarCityExpress = document.getElementById(mVarControlForCityExpress).value;
                        mVarCityExpressTrDays = document.getElementById(mVarControlForCityExpressTrDays).value;  
                    }
                    
                    //if(document.getElementById(mVarControlForCityFrom).value == "" && document.getElementById(mVarControlForCityTo).value == "" && ((document.getElementById(mVarControlForCityAir).value == "" && document.getElementById(mVarControlForCityAirTrDays).value == "") || (document.getElementById(mVarControlForCityRoad).value == "" && document.getElementById(mVarControlForCityRoadTrDays).value == "") || (document.getElementById(mVarControlForCityTrain).value == "" && document.getElementById(mVarControlForCityTrainTrDays).value == "") || (document.getElementById(mVarControlForCityExpress).value == "" && document.getElementById(mVarControlForCityExpressTrDays).value == "")))
                    if(document.getElementById(mVarControlForCityFrom).value == "" && document.getElementById(mVarControlForCityTo).value == "") //&& ((document.getElementById(mVarControlForCityAir).value == "" && document.getElementById(mVarControlForCityAirTrDays).value == "") || (document.getElementById(mVarControlForCityRoad).value == "" && document.getElementById(mVarControlForCityRoadTrDays).value == "") || (document.getElementById(mVarControlForCityTrain).value == "" && document.getElementById(mVarControlForCityTrainTrDays).value == "") || (document.getElementById(mVarControlForCityExpress).value == "" && document.getElementById(mVarControlForCityExpressTrDays).value == "")))
                    {
                        if(mVarCityAir == "" && mVarCityAirTrDays == "" &&  mVarCityRoad == "" && mVarCityRoadTrDays == "" && mVarCityTrain == "" && mVarCityTrainTrDays == "" && mVarCityExpress == "" && mVarCityExpressTrDays == "")
                        {
//                            if(mLoopCounter == 1)
//                            {
//                                alert("Enter City Matrix Details!");
//                                document.getElementById(mVarControlForCityFrom).focus();
//                                return false;
//                            }
                        }
                    }
                    else
                    {
                        if(document.getElementById(mVarControlForCityFrom).value == "")
                        {
                            alert("Enter 'City From' for City Matrix!");
                            document.getElementById(mVarControlForCityFrom).focus();
                            return false;
                        }
                        else
                        {
                            mVarCMTemp = document.getElementById(mVarControlForCityFrom).value;
                        }
                        if(document.getElementById(mVarControlForCityTo).value == "")
                        {
                            alert("Enter 'City To' for City Matrix!");
                            document.getElementById(mVarControlForCityTo).focus();
                            return false;
                        }
                        else
                        {
                            mVarCMTemp += "," + document.getElementById(mVarControlForCityTo).value;
                        }
                        
                        //Check for Different City From & To
                        var mVarCityFrom = document.getElementById(mVarControlForCityFrom).value;
                        var mVarCityTo = document.getElementById(mVarControlForCityTo).value;
                        
                        if(mVarCityFrom == mVarCityTo)
                        {
                            alert("'City From' & 'City To' must be different!");
                            document.getElementById(mVarControlForCityFrom).focus();
                            return false;
                        }
                        
                        if(mVarCityAir == "" && mVarCityAirTrDays == "" && mVarCityRoad == "" && mVarCityRoadTrDays == "" && mVarCityTrain == "" && mVarCityTrainTrDays == "" && mVarCityExpress == "" && mVarCityExpressTrDays == "")
                        {
                            alert("Enter 'Freight Rate & Transit Days' for " + "<%=strAir %>" + " OR " + "<%=strRoad %>" + " OR " + "<%=strTrain %>" + " OR " + "<%=strExpress %>" + " for City Matrix!");
                            if(document.getElementById(mVarControlForCityAir))
                            {
                                document.getElementById(mVarControlForCityAir).focus();
                            }
                            else if(document.getElementById(mVarControlForCityRoad))
                            {
                                document.getElementById(mVarControlForCityRoad).focus();
                            }
                            else if(document.getElementById(mVarControlForCityTrain))
                            {
                                document.getElementById(mVarControlForCityTrain).focus();
                            }
                            else if(document.getElementById(mVarControlForCityExpress))
                            {
                                document.getElementById(mVarControlForCityExpress).focus();
                            }
                            return false;
                        }
                        
                        if(mVarCityAir == "" && mVarCityAirTrDays != "")
                        {
                            alert("Enter 'Freight Rate & Transit Days' for " + "<%=strAir %>" + " for City Matrix!");
                            document.getElementById(mVarControlForCityAir).focus();
                            return false;
                        }
                        else if(mVarCityAir != "" && mVarCityAirTrDays == "")
                        {
                            alert("Enter 'Freight Rate & Transit Days' for " + "<%=strAir %>" + " for City Matrix!");
                            document.getElementById(mVarControlForCityAirTrDays).focus();
                            return false;
                        }
                        
                        if(mVarCityRoad == "" && mVarCityRoadTrDays != "")
                        {
                            alert("Enter 'Freight Rate & Transit Days' for " + "<%=strRoad %>" + " for City Matrix!");
                            document.getElementById(mVarControlForCityRoad).focus();
                            return false;
                        }
                        else if(mVarCityRoad != "" && mVarCityRoadTrDays == "")
                        {
                            alert("Enter 'Freight Rate & Transit Days' for " + "<%=strRoad %>" + " for City Matrix!");
                            document.getElementById(mVarControlForCityRoadTrDays).focus();
                            return false;
                        }
                        
                        if(mVarCityTrain == "" && mVarCityTrainTrDays != "")
                        {
                            alert("Enter 'Freight Rate & Transit Days' for " + "<%=strTrain %>" + " for City Matrix!");
                            document.getElementById(mVarControlForCityTrain).focus();
                            return false;
                        }
                        else if(mVarCityTrain != "" && mVarCityTrainTrDays == "")
                        {
                            alert("Enter 'Freight Rate & Transit Days' for " + "<%=strTrain %>" + " for City Matrix!");
                            document.getElementById(mVarControlForCityTrainTrDays).focus();
                            return false;
                        }
                        
                        if(mVarCityExpress == "" && mVarCityExpressTrDays != "")
                        {
                            alert("Enter 'Freight Rate & Transit Days' for " + "<%=strExpress %>" + " for City Matrix!");
                            document.getElementById(mVarControlForCityExpress).focus();
                            return false;
                        }
                        else if(mVarCityExpress != "" && mVarCityExpressTrDays == "")
                        {
                            alert("Enter 'Freight Rate & Transit Days' for " + "<%=strExpress %>" + " for City Matrix!");
                            document.getElementById(mVarControlForCityExpressTrDays).focus();
                            return false;
                        }
                        
                        if(document.getElementById(mVarControlForCityAir))
                        {
                            if(document.getElementById(mVarControlForCityAir).value == "")
                            {
//                                alert("Enter 'Freight Rate' for 'Air' for City Matrix!");
//                                document.getElementById(mVarControlForCityAir).focus();
//                                return false;
                                mVarCMTemp += "," + "0.0";
                            }
                            else
                            {
                                mVarCMTemp += "," + document.getElementById(mVarControlForCityAir).value;
                            }
                        }
                        else
                        {
                            mVarCMTemp += "," + "0.0";
                        }
                        if(document.getElementById(mVarControlForCityAirTrDays))
                        {
                            if(document.getElementById(mVarControlForCityAirTrDays).value == "")
                            {
//                                alert("Enter 'Transit Days' for 'Air' for City Matrix!");
//                                document.getElementById(mVarControlForCityAirTrDays).focus();
//                                return false;
                                mVarCMTemp += "," + "0.0";
                            }
                            else
                            {
                                mVarCMTemp += "," + document.getElementById(mVarControlForCityAirTrDays).value;
                            }
                        }
                        else
                        {
                            mVarCMTemp += "," + "0.0";
                        }
                        
                        if(document.getElementById(mVarControlForCityRoad))
                        {
                            if(document.getElementById(mVarControlForCityRoad).value == "")
                            {
//                                alert("Enter 'Freight Rate' for 'Road' for City Matrix!");
//                                document.getElementById(mVarControlForCityRoad).focus();
//                                return false;
                                mVarCMTemp += "," + "0.0";
                            }
                            else
                            {
                                mVarCMTemp += "," + document.getElementById(mVarControlForCityRoad).value;
                            }
                        }
                        else
                        {
                            mVarCMTemp += "," + "0.0";
                        }
                        if(document.getElementById(mVarControlForCityRoadTrDays))
                        {
                            if(document.getElementById(mVarControlForCityRoadTrDays).value == "")
                            {
//                                alert("Enter 'Transit Days' for 'Road' for City Matrix!");
//                                document.getElementById(mVarControlForCityRoadTrDays).focus();
//                                return false;
                                mVarCMTemp += "," + "0.0";      
                            }
                            else
                            {
                                mVarCMTemp += "," + document.getElementById(mVarControlForCityRoadTrDays).value;
                            }
                        }
                        else
                        {
                            mVarCMTemp += "," + "0.0";
                        }
                        
                        if(document.getElementById(mVarControlForCityTrain))
                        {
                            if(document.getElementById(mVarControlForCityTrain).value == "")
                            {
//                                alert("Enter 'Freight Rate' for 'Train' for City Matrix!");
//                                document.getElementById(mVarControlForCityTrain).focus();
//                                return false;
                                mVarCMTemp += "," + "0.0";
                            }
                            else
                            {
                                mVarCMTemp += "," + document.getElementById(mVarControlForCityTrain).value;
                            }
                        }
                        else
                        {
                            mVarCMTemp += "," + "0.0";
                        }
                        if(document.getElementById(mVarControlForCityTrainTrDays))
                        {
                            if(document.getElementById(mVarControlForCityTrainTrDays).value == "")
                            {
//                                alert("Enter 'Transit Days' for 'Train' for City Matrix!");
//                                document.getElementById(mVarControlForCityTrainTrDays).focus();
//                                return false;
                                mVarCMTemp += "," + "0.0";
                            }
                            else
                            {
                                mVarCMTemp += "," + document.getElementById(mVarControlForCityTrainTrDays).value;
                            }
                        }
                        else
                        {
                            mVarCMTemp += "," + "0.0";
                        }
                        
                        if(document.getElementById(mVarControlForCityExpress))
                        {
                            if(document.getElementById(mVarControlForCityExpress).value == "")
                            {
//                                alert("Enter 'Freight Rate' for 'Express' for City Matrix!");
//                                document.getElementById(mVarControlForCityExpress).focus();
//                                return false;
                                mVarCMTemp += "," + "0.0";
                            }
                            else
                            {
                                mVarCMTemp += "," + document.getElementById(mVarControlForCityExpress).value;
                            }
                        }
                        else
                        {
                            mVarCMTemp += "," + "0.0";
                        }
                        if(document.getElementById(mVarControlForCityExpressTrDays))
                        {
                            if(document.getElementById(mVarControlForCityExpressTrDays).value == "")
                            {
//                                alert("Enter 'Transit Days' for 'Express' for City Matrix!");
//                                document.getElementById(mVarControlForCityExpressTrDays).focus();
//                                return false;
                                mVarCMTemp += "," + "0.0";
                            }
                            else
                            {
                                mVarCMTemp += "," + document.getElementById(mVarControlForCityExpressTrDays).value;
                            }
                        }
                        else
                        {
                            mVarCMTemp += "," + "0.0";
                        }
                    }
                    if(mVarCMTemp != "")
                    {
                        mVarCM = (mVarCM == "" ? mVarCMTemp : mVarCM + "~" + mVarCMTemp);
                        mVarCMTemp = "";
                    }
                }
            }
            
            //Check for Distinct Pair of City From & To
            for(var mLoopCounter = 1 ; mLoopCounter <= 10; mLoopCounter++)
            {
                //Create control ID's
                mVarControlForCityFrom = "ctl00_MyCPH1_txtFromCityRow" + mLoopCounter;
                mVarControlForCityTo = "ctl00_MyCPH1_txtToCityRow" + mLoopCounter;
                
                var mVarCityFrom = document.getElementById(mVarControlForCityFrom).value;
                var mVarCityTo = document.getElementById(mVarControlForCityTo).value;
                
                if(mVarCityFrom != "" && mVarCityTo != "")
                {
                    if(CheckDuplicateCity(mVarCityFrom, mVarCityTo, mLoopCounter) == true)
                    {
                        alert("Please enter distinct 'City From' & 'City To'!");
                        document.getElementById(mVarControlForCityFrom).focus();
                        return false;
                    }
                }
            }
            
            if(mVarBM == "" && mVarZM == "" && mVarCM == "")
            {
                alert("Enter Branch Matrix or Zone Matrix or City Matrix Details!");
                document.getElementById("ctl00_MyCPH1_txtBranchCode").focus();   
                return false;
            }
            
            if(document.getElementById("ctl00_MyCPH1_HidBM"))
            {
                document.getElementById("ctl00_MyCPH1_HidBM").value = mVarBM;
            }
            else
            {
                alert("Hidden variable not found for storing Branch Matrix details!");
                return false;
            }
            
            if(document.getElementById("ctl00_MyCPH1_HidZM"))
            {
                document.getElementById("ctl00_MyCPH1_HidZM").value = mVarZM;
            }
            else
            {
                alert("Hidden variable not found for storing Zone Matrix details!");
                return false;
            }
            
            if(document.getElementById("ctl00_MyCPH1_HidCM"))
            {
                document.getElementById("ctl00_MyCPH1_HidCM").value = mVarCM;
            }
            else
            {
                alert("Hidden variable not found for storing City Matrix details!");
                return false;
            }
            
//            alert(mVarBM);
//            alert(mVarZM);
//            alert(mVarCM);
//            
//            return false;
            
            return true;
        }
        
        function CheckDuplicateBranch(BranchFrom, BranchTo, BranchRow)
        {
            var mVarControlForBranchFrom;
            var mVarControlForBranchTo;
            
            //Check for Branch Matrix
            for(var mLoopCounter = 1 ; mLoopCounter <= 10; mLoopCounter++)
            {
                if(mLoopCounter != BranchRow)
                {
                    //Create control ID's
                    mVarControlForBranchFrom = "ctl00_MyCPH1_txtFreightMatrixRow" + mLoopCounter + "From";
                    mVarControlForBranchTo = "ctl00_MyCPH1_txtFreightMatrixRow" + mLoopCounter + "To";
                    
                    //Check for Branch From
                    if(document.getElementById(mVarControlForBranchFrom) && document.getElementById(mVarControlForBranchTo))
                    {
                        if(document.getElementById(mVarControlForBranchFrom).value != "" && document.getElementById(mVarControlForBranchTo).value != "")
                        {
                            if(document.getElementById(mVarControlForBranchFrom).value == BranchFrom && document.getElementById(mVarControlForBranchTo).value != BranchTo)
                            {
                                return true;
                            }
                        }
                    }
                }
            }
            
            return false;
        }
        
        function CheckDuplicateCity(CityFrom, CityTo, CityRow)
        {
            var mVarControlForCityFrom;
            var mVarControlForCityTo;
            
            //Check for Branch Matrix
            for(var mLoopCounter = 1 ; mLoopCounter <= 10; mLoopCounter++)
            {
                if(mLoopCounter != CityRow)
                {
                    //Create control ID's
                    mVarControlForCityFrom = "ctl00_MyCPH1_txtFromCityRow" + mLoopCounter;
                    mVarControlForCityTo = "ctl00_MyCPH1_txtToCityRow" + mLoopCounter;
                    
                    //Check for Branch From
                    if(document.getElementById(mVarControlForCityFrom) && document.getElementById(mVarControlForCityTo))
                    {
                        if(document.getElementById(mVarControlForCityFrom).value != "" && document.getElementById(mVarControlForCityTo).value != "")
                        {
                            if(document.getElementById(mVarControlForCityFrom).value == CityFrom && document.getElementById(mVarControlForCityTo).value != CityTo)
                            {
                                return true;
                            }
                        }
                    }
                }
            }
            
            return false;
        }
        
        function CheckDuplicateZone(ZoneFrom, ZoneTo, ZoneRow)
        {
            var mVarControlForZoneFrom = "";
            var mVarControlForZoneTo = "";
            
            //Check for Branch Matrix
            for(var mLoopCounter = 1 ; mLoopCounter <= 10; mLoopCounter++)
            {
                if(mLoopCounter != ZoneRow)
                {
                    //Create control ID's
                    mVarControlForZoneFrom = "ctl00_MyCPH1_ddlZoneFromForRow" + mLoopCounter;
                    mVarControlForZoneTo = "ctl00_MyCPH1_ddlZoneToForRow" + mLoopCounter;
                    
                    //Check for Branch From
                    if(document.getElementById(mVarControlForZoneFrom) && document.getElementById(mVarControlForZoneTo))
                    {
                        if(document.getElementById(mVarControlForZoneFrom).value != "-1" && document.getElementById(mVarControlForZoneTo).value != "-1")
                        {
                            if(document.getElementById(mVarControlForZoneFrom).value == ZoneFrom && document.getElementById(mVarControlForZoneTo).value == ZoneTo)
                            {
                                return true;
                            }
                        }
                    }
                }
            }
            
            return false;
        }
        
    </script>
            
    <div>
    
        <input type="hidden" id="HidContractID" runat="server" />
                
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
        
        <input type="hidden" runat="server" id="HidSlab" />
        <input type="hidden" runat="server" id="HidRandomNo" />
        <input type="hidden" id="HidMOTAir" runat="server" />
        <input type="hidden" id="HidMOTRoad" runat="server" />
        <input type="hidden" id="HidMOTTrain" runat="server" />
        <input type="hidden" id="HidMOTExpress" runat="server" />
        
        <input type="hidden" id="HidBM" runat="server" />
        <input type="hidden" id="HidZM" runat="server" />
        <input type="hidden" id="HidCM" runat="server" />
        
        <input type="hidden" id="HidODA" runat="server" />
        
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
                                <a href="#">
                                    <label class="blklnkund">
                                        <strong>--%>
                                            <%--<%=Session["Level_Type"]%>--%> <%--Module
                                        </strong>
                                    </label>
                                </a>
                                		  
                                <strong>
                                     &gt; 
                                </strong>
                                
                                <a href="#">
                                    <label class="blklnkund">
                                        <strong>
                                            Administrator 
                                        </strong>
                                    </label>
                                </a>

                                <strong>
                                     &gt; 
                                </strong>
                                
                                <a href="#">
                                    <label class="blklnkund">
                                        <strong>
                                            Finance & Accounts
                                        </strong>
                                    </label>
                                </a>
                                
                                <strong>
                                     &gt; 
                                </strong>
                                
                                <a href="#">
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
                               
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td style="width: 39%" valign="top">
                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td valign="top">
                                                                <br style="font-size: 6pt;" />
					                                            
					                                            <table border="0" cellpadding="2" width="85%" cellspacing="1" align="center" class="boxbg">
					                                                <tr style="background-color: White">
					                                                    <td colspan="4" align="left">
					                                                        <label class="blackfnt">
					                                                            <b>
					                                                                &nbsp;STEP 3A: Freight Matrix- Single Slab Contract
					                                                            </b>
					                                                        </label>
					                                                    </td>    
					                                                </tr>
					    
					                                                <tr style="background-color: White">
					                                                    <td colspan="4" align="left" style="height: 200" valign="top">
					                                                        <br style="font-size: 6pt;" />
					                                                        
					                                                        <table border="0" cellpadding="2" width="80%" cellspacing="1" align="center" class="boxbg">
								                                                <tr style="background-color: White">
									                                                <td align="left">
									                                                    <label class="blackfnt">
									                                                        Select Rate Type:
									                                                    </label>
									                                                </td>
									                                                
									                                                <td align="left">
									                                                    <label style="margin-left: 5px;">
			                                                                            </label>
									                                                    <asp:DropDownList ID="ddlRateType" runat="server" CssClass="blackfnt">
									                                                        <asp:ListItem Selected="True" Value="-1" Text="Select"></asp:ListItem>
									                                                        <asp:ListItem Value="W" Text="Per Kg."></asp:ListItem>
									                                                        <asp:ListItem Value="P" Text="Per Package"></asp:ListItem>
									                                                    </asp:DropDownList>
									                                                </td>
								                                                </tr>
								        									</table>
								        									
								        									<br style="font-size: 6pt;" />
								        									
								        									<p align="center">
								        									    <label class="blackfnt">
								        									        <b>
								        									            Branch Matrix
								        									        </b>
								        									    </label>
								        									</p>
								        									
							                                                <p align="left">
							                                                    <label class="bluefnt">
							                                                        <b>
							                                                            Freight Rate
							                                                        </b>
							                                                    </label>
							                                                </p>
							                                                
							                                                <table border="0" cellpadding="2" width="50%" cellspacing="1" align="center" class="boxbg">
									                                            <tr style="background-color: White">
									                                                <td align="left">
									                                                    <label class="blackfnt">
									                                                        Branch:
									                                                    </label>
									                                                </td>
									                                                
										                                            <td align="left">
										                                                <asp:UpdatePanel ID="upBranchCode" runat="server">
										                                                    <ContentTemplate>
										                                                        <asp:TextBox ID="txtBranchCode" runat="server" MaxLength="4" 
										                                                            OnTextChanged="txtBranchCode_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
										                                                        <input type="button" value="..." runat="server" id="btnBranchCode" 
                                                                                                    onclick="return BranchPopup('Branch_Popup.aspx?2')" />
                                                                                                <br />
                                                                                                <label class="blackfnt" id="lblErrorBranchCode" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid Branch Code!!!
                                                                                                </label>    
										                                                    </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtBranchCode" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
										                                            </td>
									                                            </tr>
									                                        </table>
									                                        
									                                        <br style="font-size: 6pt;"/>	
					
					                                                        <table border="0" align="center" cellspacing="1" cellpadding="5" width="100%" class="boxbg">
						                                                        <tr style="background-color: White">
							                                                        <td align="center">
							                                                            <label class="blackfnt">
							                                                                From&nbsp;
								                                                            <input type="button" value="..." runat="server" id="btnBranchFrom" 
                                                                                                onclick="return BranchPopup('Branch_Popup_Multi_Selection.aspx?1')" />
							                                                            </label>
							                                                        </td>
							                                                        
								                                                    <td align="center">
								                                                        <label class="blackfnt">
								                                                            To&nbsp;
								                                                            <input type="button" value="..." runat="server" id="btnBranchTo" 
                                                                                                onclick="return BranchPopup('Branch_Popup_Multi_Selection.aspx?2')" />
								                                                        </label>
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirHeader">
								                                                        <label class="blackfnt" id="lblAirHeader" runat="server">
								                                                        </label>
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirHeaderForTrDays">
								                                                        <label class="blackfnt" id="lblAirHeaderForTrDays" runat="server">
								                                                            Transit Days
								                                                        </label>
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadHeader">
								                                                        <label class="blackfnt" id="lblRoadHeader" runat="server">
								                                                        </label>
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadHeaderForTrDays">
								                                                        <label class="blackfnt" id="lblRoadHeaderForTrDays" runat="server">
								                                                            Transit Days
								                                                        </label>
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainHeader">
								                                                        <label class="blackfnt" id="lblTrainHeader" runat="server">
								                                                        </label>
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainHeaderForTrDays">
								                                                        <label class="blackfnt" id="lblTrainHeaderForTrDays" runat="server">
								                                                            Transit Days
								                                                        </label>
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressHeader">
								                                                        <label class="blackfnt" id="lblExpressHeader" runat="server">
								                                                        </label>
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressHeaderForTrDays">
								                                                        <label class="blackfnt" id="lblExpressHeaderForTrDays" runat="server">
								                                                            Transit Days
								                                                        </label>
								                                                    </td>
							                                                    </tr>
							                                                    
							                                                    <%--table row for Freight Matrix for Branch - Row 1--%>
							                                                    <tr id="Tr1" runat="server" style="background-color: White">
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upFMR1From" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtFreightMatrixRow1From" runat="server" MaxLength="4" 
										                                                            OnTextChanged="txtFreightMatrixRow1From_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorFreightMatrixRow1From" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid Branch Code!!!
                                                                                                </label>
                                                                                        </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtFreightMatrixRow1From" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>    
							                                                        
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upFMR1To" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtFreightMatrixRow1To" runat="server" MaxLength="4" 
										                                                            OnTextChanged="txtFreightMatrixRow1To_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorFreightMatrixRow1To" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid Branch Code!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtFreightMatrixRow1To" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center" runat="server" id="tdAirForRow1">
								                                                        <input id="txtFreightForAirRow1" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirForRowTrDays1">
								                                                        <input id="txtAirTrDaysRow1" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRow1">
								                                                        <input id="txtFreightForRoadRow1" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRowTrDays1">
								                                                        <input id="txtRoadTrDaysRow1" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRow1">
								                                                        <input id="txtFreightForTrainRow1" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRowTrDays1">
								                                                        <input id="txtTrainTrDaysRow1" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRow1">
								                                                        <input id="txtFreightForExpressRow1" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRowTrDays1">
								                                                        <input id="txtExpressTrDaysRow1" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
							                                                    </tr>
							                                                    
							                                                    <%--table row for Freight Matrix for Branch - Row 2--%>
							                                                    <tr id="Tr2" runat="server" style="background-color: White">
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upFMR2From" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtFreightMatrixRow2From" runat="server" MaxLength="4" 
										                                                            OnTextChanged="txtFreightMatrixRow2From_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorFreightMatrixRow2From" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid Branch Code!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtFreightMatrixRow2From" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>    
							                                                        
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upFMR2To" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtFreightMatrixRow2To" runat="server" MaxLength="4" 
										                                                            OnTextChanged="txtFreightMatrixRow2To_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorFreightMatrixRow2To" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid Branch Code!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtFreightMatrixRow2To" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center" runat="server" id="tdAirForRow2">
								                                                        <input id="txtFreightForAirRow2" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirForRowTrDays2">
								                                                        <input id="txtAirTrDaysRow2" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRow2">
								                                                        <input id="txtFreightForRoadRow2" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRowTrDays2">
								                                                        <input id="txtRoadTrDaysRow2" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRow2"> 
								                                                        <input id="txtFreightForTrainRow2" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRowTrDays2">
								                                                        <input id="txtTrainTrDaysRow2" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRow2">
								                                                        <input id="txtFreightForExpressRow2" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRowTrDays2">
								                                                        <input id="txtExpressTrDaysRow2" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
							                                                    </tr>
							                                                    
							                                                    <%--table row for Freight Matrix for Branch - Row 3--%>
							                                                    <tr id="Tr3" runat="server" style="background-color: White">
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upFMR3From" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtFreightMatrixRow3From" runat="server" MaxLength="4" 
										                                                            OnTextChanged="txtFreightMatrixRow3From_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorFreightMatrixRow3From" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid Branch Code!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtFreightMatrixRow3From" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>    
							                                                        
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upFMR3To" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtFreightMatrixRow3To" runat="server" MaxLength="4" 
										                                                            OnTextChanged="txtFreightMatrixRow3To_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorFreightMatrixRow3To" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid Branch Code!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtFreightMatrixRow3To" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center" runat="server" id="tdAirForRow3">
								                                                        <input id="txtFreightForAirRow3" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirForRowTrDays3">
								                                                        <input id="txtAirTrDaysRow3" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRow3">
								                                                        <input id="txtFreightForRoadRow3" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRowTrDays3">
								                                                        <input id="txtRoadTrDaysRow3" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRow3">
								                                                        <input id="txtFreightForTrainRow3" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRowTrDays3">
								                                                        <input id="txtTrainTrDaysRow3" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRow3">
								                                                        <input id="txtFreightForExpressRow3" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRowTrDays3">
								                                                        <input id="txtExpressTrDaysRow3" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
							                                                    </tr>
							                                                    
							                                                    <%--table row for Freight Matrix for Branch - Row 4--%>
							                                                    <tr id="Tr4" runat="server" style="background-color: White">
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upFMR4From" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtFreightMatrixRow4From" runat="server" MaxLength="4" 
										                                                            OnTextChanged="txtFreightMatrixRow4From_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorFreightMatrixRow4From" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid Branch Code!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtFreightMatrixRow4From" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>    
							                                                        
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upFMR4To" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtFreightMatrixRow4To" runat="server" MaxLength="4" 
										                                                            OnTextChanged="txtFreightMatrixRow4To_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorFreightMatrixRow4To" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid Branch Code!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtFreightMatrixRow4To" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center" runat="server" id="tdAirForRow4">
								                                                        <input id="txtFreightForAirRow4" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirForRowTrDays4">
								                                                        <input id="txtAirTrDaysRow4" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRow4">
								                                                        <input id="txtFreightForRoadRow4" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRowTrDays4">
								                                                        <input id="txtRoadTrDaysRow4" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRow4">
								                                                        <input id="txtFreightForTrainRow4" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRowTrDays4">
								                                                        <input id="txtTrainTrDaysRow4" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRow4">
								                                                        <input id="txtFreightForExpressRow4" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRowTrDays4">
								                                                        <input id="txtExpressTrDaysRow4" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
							                                                    </tr>
							                                                    
							                                                    <%--table row for Freight Matrix for Branch - Row 5--%>
							                                                    <tr id="Tr5" runat="server" style="background-color: White">
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upFMR5From" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtFreightMatrixRow5From" runat="server" MaxLength="4" 
										                                                            OnTextChanged="txtFreightMatrixRow5From_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorFreightMatrixRow5From" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid Branch Code!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtFreightMatrixRow5From" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upFMR5To" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtFreightMatrixRow5To" runat="server" MaxLength="4" 
										                                                            OnTextChanged="txtFreightMatrixRow5To_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorFreightMatrixRow5To" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid Branch Code!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtFreightMatrixRow5To" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center" runat="server" id="tdAirForRow5">
								                                                        <input id="txtFreightForAirRow5" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirForRowTrDays5">
								                                                        <input id="txtAirTrDaysRow5" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRow5">
								                                                        <input id="txtFreightForRoadRow5" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRowTrDays5">
								                                                        <input id="txtRoadTrDaysRow5" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>

								                                                    <td align="center" runat="server" id="tdTrainForRow5">
								                                                        <input id="txtFreightForTrainRow5" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRowTrDays5">
								                                                        <input id="txtTrainTrDaysRow5" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRow5">
								                                                        <input id="txtFreightForExpressRow5" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRowTrDays5">
								                                                        <input id="txtExpressTrDaysRow5" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
							                                                    </tr>
							                                                    
							                                                    <%--table row for Freight Matrix for Branch - Row 6--%>
							                                                    <tr id="Tr6" runat="server" style="background-color: White">
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upFMR6From" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtFreightMatrixRow6From" runat="server" MaxLength="4" 
										                                                            OnTextChanged="txtFreightMatrixRow6From_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorFreightMatrixRow6From" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid Branch Code!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtFreightMatrixRow6From" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upFMR6To" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtFreightMatrixRow6To" runat="server" MaxLength="4" 
										                                                            OnTextChanged="txtFreightMatrixRow6To_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorFreightMatrixRow6To" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid Branch Code!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtFreightMatrixRow6To" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center" runat="server" id="tdAirForRow6">
								                                                        <input id="txtFreightForAirRow6" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirForRowTrDays6">
								                                                        <input id="txtAirTrDaysRow6" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRow6">
								                                                        <input id="txtFreightForRoadRow6" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRowTrDays6">
								                                                        <input id="txtRoadTrDaysRow6" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRow6">
								                                                        <input id="txtFreightForTrainRow6" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRowTrDays6">
								                                                        <input id="txtTrainTrDaysRow6" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRow6">
								                                                        <input id="txtFreightForExpressRow6" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRowTrDays6">
								                                                        <input id="txtExpressTrDaysRow6" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
							                                                    </tr>
							                                                    
							                                                    <%--table row for Freight Matrix for Branch - Row 7--%>
							                                                    <tr id="Tr7" runat="server" style="background-color: White">
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upFMR7From" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtFreightMatrixRow7From" runat="server" MaxLength="4" 
										                                                            OnTextChanged="txtFreightMatrixRow7From_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorFreightMatrixRow7From" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid Branch Code!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtFreightMatrixRow7From" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upFMR7To" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtFreightMatrixRow7To" runat="server" MaxLength="4" 
										                                                            OnTextChanged="txtFreightMatrixRow7To_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorFreightMatrixRow7To" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid Branch Code!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtFreightMatrixRow7To" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center" runat="server" id="tdAirForRow7">
								                                                        <input id="txtFreightForAirRow7" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirForRowTrDays7">
								                                                        <input id="txtAirTrDaysRow7" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRow7">
								                                                        <input id="txtFreightForRoadRow7" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRowTrDays7">
								                                                        <input id="txtRoadTrDaysRow7" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRow7">
								                                                        <input id="txtFreightForTrainRow7" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRowTrDays7">
								                                                        <input id="txtTrainTrDaysRow7" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRow7">
								                                                        <input id="txtFreightForExpressRow7" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRowTrDays7">
								                                                        <input id="txtExpressTrDaysRow7" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
							                                                    </tr>
							                                                    
							                                                    <%--table row for Freight Matrix for Branch - Row 8--%>
							                                                    <tr id="Tr8" runat="server" style="background-color: White">
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upFMR8From" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtFreightMatrixRow8From" runat="server" MaxLength="4" 
										                                                            OnTextChanged="txtFreightMatrixRow8From_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorFreightMatrixRow8From" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid Branch Code!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtFreightMatrixRow8From" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upFMR8To" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtFreightMatrixRow8To" runat="server" MaxLength="4" 
										                                                            OnTextChanged="txtFreightMatrixRow8To_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorFreightMatrixRow8To" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid Branch Code!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtFreightMatrixRow8To" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center" runat="server" id="tdAirForRow8">
								                                                        <input id="txtFreightForAirRow8" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirForRowTrDays8">
								                                                        <input id="txtAirTrDaysRow8" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRow8">
								                                                        <input id="txtFreightForRoadRow8" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRowTrDays8">
								                                                        <input id="txtRoadTrDaysRow8" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRow8">
								                                                        <input id="txtFreightForTrainRow8" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRowTrDays8">
								                                                        <input id="txtTrainTrDaysRow8" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRow8">
								                                                        <input id="txtFreightForExpressRow8" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRowTrDays8">
								                                                        <input id="txtExpressTrDaysRow8" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
							                                                    </tr>
							                                                    
							                                                    <%--table row for Freight Matrix for Branch - Row 9--%>
							                                                    <tr id="Tr9" runat="server" style="background-color: White">
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upFMR9From" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtFreightMatrixRow9From" runat="server" MaxLength="4" 
										                                                            OnTextChanged="txtFreightMatrixRow9From_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorFreightMatrixRow9From" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid Branch Code!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtFreightMatrixRow9From" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upFMR9To" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtFreightMatrixRow9To" runat="server" MaxLength="4" 
										                                                            OnTextChanged="txtFreightMatrixRow9To_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorFreightMatrixRow9To" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid Branch Code!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtFreightMatrixRow9To" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center" runat="server" id="tdAirForRow9">
								                                                        <input id="txtFreightForAirRow9" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirForRowTrDays9">
								                                                        <input id="txtAirTrDaysRow9" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRow9">
								                                                        <input id="txtFreightForRoadRow9" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRowTrDays9">
								                                                        <input id="txtRoadTrDaysRow9" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRow9">
								                                                        <input id="txtFreightForTrainRow9" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRowTrDays9">
								                                                        <input id="txtTrainTrDaysRow9" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRow9">
								                                                        <input id="txtFreightForExpressRow9" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRowTrDays9">
								                                                        <input id="txtExpressTrDaysRow9" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
							                                                    </tr>
							                                                    
							                                                    <%--table row for Freight Matrix for Branch - Row 10--%>
							                                                    <tr id="Tr10" runat="server" style="background-color: White">
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upFMR10From" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtFreightMatrixRow10From" runat="server" MaxLength="4" 
										                                                            OnTextChanged="txtFreightMatrixRow10From_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorFreightMatrixRow10From" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid Branch Code!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtFreightMatrixRow10From" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upFMR10To" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtFreightMatrixRow10To" runat="server" MaxLength="4" 
										                                                            OnTextChanged="txtFreightMatrixRow10To_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorFreightMatrixRow10To" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid Branch Code!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtFreightMatrixRow10To" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center" runat="server" id="tdAirForRow10">
								                                                        <input id="txtFreightForAirRow10" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirForRowTrDays10">
								                                                        <input id="txtAirTrDaysRow10" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRow10">
								                                                        <input id="txtFreightForRoadRow10" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRowTrDays10">
								                                                        <input id="txtRoadTrDaysRow10" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRow10">
								                                                        <input id="txtFreightForTrainRow10" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRowTrDays10">
								                                                        <input id="txtTrainTrDaysRow10" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRow10">
								                                                        <input id="txtFreightForExpressRow10" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRowTrDays10">
								                                                        <input id="txtExpressTrDaysRow10" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
							                                                    </tr>
				                                                            </table>
										                                        
							                                                <br style="font-size: 6pt;" />
							                                                
							                                                <p align="center">
							                                                    <label class="blackfnt">
							                                                        <b>
							                                                            Zone Matrix
							                                                        </b>
							                                                    </label>
							                                                </p>
							                                                
							                                                <p align="left">
							                                                    <label class="bluefnt">
							                                                        <b>
							                                                            Freight Rate
							                                                        </b>
							                                                    </label>
							                                                </p>
							                                                
							                                                <table border="0" cellpadding="2" width="50%" cellspacing="1" align="center" class="boxbg">
									                                            <tr style="background-color: White">
									                                                <td align="left">
									                                                    <label class="blackfnt">
									                                                        Zone:
									                                                    </label>
									                                                </td>
									                                                
										                                            <td align="left">
										                                                <asp:UpdatePanel ID="upZoneHeader" runat="server">
										                                                    <ContentTemplate>
										                                                        <label style="margin-left: 5px;">
			                                                                                    </label>
									                                                            <asp:DropDownList ID="ddlZoneHeader" runat="server" CssClass="blackfnt" 
									                                                                OnSelectedIndexChanged="ddlZoneHeader_SelectedIndexChanged" AutoPostBack="true">
									                                                            </asp:DropDownList>        
										                                                    </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="ddlZoneHeader" EventName="SelectedIndexChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
										                                            </td>
									                                            </tr>
									                                        </table>
									                                        
									                                        <br style="font-size: 6pt;" />
									                                        
									                                        <table border="0" align="center" cellspacing="1" cellpadding="5" width="100%" class="boxbg">
						                                                        <tr style="background-color: White">
							                                                        <td align="center">
							                                                            <label class="blackfnt">
							                                                                From
							                                                            </label>
							                                                        </td>
							                                                        
								                                                    <td align="center">
								                                                        <label class="blackfnt">
								                                                            To
								                                                        </label>
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirHeaderForZone">
								                                                        <label class="blackfnt" id="lblAirHeaderForZone" runat="server">
								                                                        </label>
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirHeaderForTrDaysForZone">
								                                                        <label class="blackfnt" id="lblAirHeaderForTrDaysForZone" runat="server">
								                                                            Transit Days
								                                                        </label>
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadHeaderForZone">
								                                                        <label class="blackfnt" id="lblRoadHeaderForZone" runat="server">
								                                                        </label>
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadHeaderForTrDaysForZone">
								                                                        <label class="blackfnt" id="lblRoadHeaderForTrDaysForZone" runat="server">
								                                                            Transit Days
								                                                        </label>
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainHeaderForZone">
								                                                        <label class="blackfnt" id="lblTrainHeaderForZone" runat="server">
								                                                        </label>
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainHeaderForTrDaysForZone">
								                                                        <label class="blackfnt" id="lblTrainHeaderForTrDaysForZone" runat="server">
								                                                            Transit Days
								                                                        </label>
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressHeaderForZone">
								                                                        <label class="blackfnt" id="lblExpressHeaderForZone" runat="server">
								                                                        </label>
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressHeaderForTrDaysForZone">
								                                                        <label class="blackfnt" id="lblExpressHeaderForTrDaysForZone" runat="server">
								                                                            Transit Days
								                                                        </label>
								                                                    </td>
							                                                    </tr>
							                                                    
							                                                    <%--table row for Freight Matrix for Zone - Row 1--%>
							                                                    <tr id="Tr11" runat="server" style="background-color: White">
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upZFR1" runat="server">
										                                                    <ContentTemplate>
							                                                                    <label style="margin-left: 5px;">
			                                                                                    </label>
									                                                            <asp:DropDownList ID="ddlZoneFromForRow1" runat="server" CssClass="blackfnt">
									                                                            </asp:DropDownList>
									                                                        </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="ddlZoneHeader" EventName="SelectedIndexChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>    
							                                                        
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upZTR1" runat="server">
										                                                    <ContentTemplate>
							                                                                    <label style="margin-left: 5px;">
			                                                                                    </label>
									                                                            <asp:DropDownList ID="ddlZoneToForRow1" runat="server" CssClass="blackfnt">
									                                                            </asp:DropDownList>
									                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="ddlZoneHeader" EventName="SelectedIndexChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center" runat="server" id="tdAirZoneForRow1">
								                                                        <input id="txtFreightForAirZoneForRow1" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirForRowTrDaysForZone1">
								                                                        <input id="txtAirTrDaysRowForZone1" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadZoneForRow1">
								                                                        <input id="txtFreightForRoadZoneForRow1" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRowTrDaysForZone1">
								                                                        <input id="txtRoadTrDaysRowForZone1" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainZoneForRow1">
								                                                        <input id="txtFreightForTrainZoneForRow1" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRowTrDaysForZone1">
								                                                        <input id="txtTrainTrDaysRowForZone1" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressZoneForRow1">
								                                                        <input id="txtFreightForExpressZoneForRow1" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRowTrDaysForZone1">
								                                                        <input id="txtExpressTrDaysRowForZone1" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
							                                                    </tr>
							                                                    
							                                                    <%--table row for Freight Matrix for Zone - Row 2--%>
							                                                    <tr id="Tr12" runat="server" style="background-color: White">
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upZFR2" runat="server">
										                                                    <ContentTemplate>
							                                                                    <label style="margin-left: 5px;">
			                                                                                    </label>
									                                                            <asp:DropDownList ID="ddlZoneFromForRow2" runat="server" CssClass="blackfnt">
									                                                            </asp:DropDownList>
									                                                        </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="ddlZoneHeader" EventName="SelectedIndexChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>    
							                                                        
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upZTR2" runat="server">
										                                                    <ContentTemplate>
							                                                                    <label style="margin-left: 5px;">
			                                                                                    </label>
									                                                            <asp:DropDownList ID="ddlZoneToForRow2" runat="server" CssClass="blackfnt">
									                                                            </asp:DropDownList>
									                                                        </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="ddlZoneHeader" EventName="SelectedIndexChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center" runat="server" id="tdAirZoneForRow2">
								                                                        <input id="txtFreightForAirZoneForRow2" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirForRowTrDaysForZone2">
								                                                        <input id="txtAirTrDaysRowForZone2" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadZoneForRow2">
								                                                        <input id="txtFreightForRoadZoneForRow2" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRowTrDaysForZone2">
								                                                        <input id="txtRoadTrDaysRowForZone2" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainZoneForRow2"> 
								                                                        <input id="txtFreightForTrainZoneForRow2" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRowTrDaysForZone2">
								                                                        <input id="txtTrainTrDaysRowForZone2" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressZoneForRow2">
								                                                        <input id="txtFreightForExpressZoneForRow2" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRowTrDaysForZone2">
								                                                        <input id="txtExpressTrDaysRowForZone2" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
							                                                    </tr>
							                                                    
							                                                    <%--table row for Freight Matrix for Zone - Row 3--%>
							                                                    <tr id="Tr13" runat="server" style="background-color: White">
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upZFR3" runat="server">
										                                                    <ContentTemplate>
							                                                                    <label style="margin-left: 5px;">
			                                                                                    </label>
									                                                            <asp:DropDownList ID="ddlZoneFromForRow3" runat="server" CssClass="blackfnt">
									                                                            </asp:DropDownList>
									                                                        </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="ddlZoneHeader" EventName="SelectedIndexChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>    
							                                                        
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upZTR3" runat="server">
										                                                    <ContentTemplate>
							                                                                    <label style="margin-left: 5px;">
			                                                                                    </label>
									                                                            <asp:DropDownList ID="ddlZoneToForRow3" runat="server" CssClass="blackfnt">
									                                                            </asp:DropDownList>
									                                                        </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="ddlZoneHeader" EventName="SelectedIndexChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center" runat="server" id="tdAirZoneForRow3">
								                                                        <input id="txtFreightForAirZoneForRow3" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirForRowTrDaysForZone3">
								                                                        <input id="txtAirTrDaysRowForZone3" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadZoneForRow3">
								                                                        <input id="txtFreightForRoadZoneForRow3" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRowTrDaysForZone3">
								                                                        <input id="txtRoadTrDaysRowForZone3" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainZoneForRow3">
								                                                        <input id="txtFreightForTrainZoneForRow3" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRowTrDaysForZone3">
								                                                        <input id="txtTrainTrDaysRowForZone3" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressZoneForRow3">
								                                                        <input id="txtFreightForExpressZoneForRow3" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRowTrDaysForZone3">
								                                                        <input id="txtExpressTrDaysRowForZone3" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
							                                                    </tr>
							                                                    
							                                                    <%--table row for Freight Matrix for Zone - Row 4--%>
							                                                    <tr id="Tr14" runat="server" style="background-color: White">
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upZFR4" runat="server">
										                                                    <ContentTemplate>
							                                                                    <label style="margin-left: 5px;">
			                                                                                    </label>
									                                                            <asp:DropDownList ID="ddlZoneFromForRow4" runat="server" CssClass="blackfnt">
									                                                            </asp:DropDownList>
									                                                        </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="ddlZoneHeader" EventName="SelectedIndexChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>    
							                                                        
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upZTR4" runat="server">
										                                                    <ContentTemplate>
							                                                                    <label style="margin-left: 5px;">
			                                                                                    </label>
									                                                            <asp:DropDownList ID="ddlZoneToForRow4" runat="server" CssClass="blackfnt">
									                                                            </asp:DropDownList>
									                                                        </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="ddlZoneHeader" EventName="SelectedIndexChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center" runat="server" id="tdAirZoneForRow4">
								                                                        <input id="txtFreightForAirZoneForRow4" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirForRowTrDaysForZone4">
								                                                        <input id="txtAirTrDaysRowForZone4" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadZoneForRow4">
								                                                        <input id="txtFreightForRoadZoneForRow4" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRowTrDaysForZone4">
								                                                        <input id="txtRoadTrDaysRowForZone4" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainZoneForRow4">
								                                                        <input id="txtFreightForTrainZoneForRow4" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRowTrDaysForZone4">
								                                                        <input id="txtTrainTrDaysRowForZone4" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressZoneForRow4">
								                                                        <input id="txtFreightForExpressZoneForRow4" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRowTrDaysForZone4">
								                                                        <input id="txtExpressTrDaysRowForZone4" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
							                                                    </tr>
							                                                    
							                                                    <%--table row for Freight Matrix for Zone - Row 5--%>
							                                                    <tr id="Tr15" runat="server" style="background-color: White">
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upZFR5" runat="server">
										                                                    <ContentTemplate>
							                                                                    <label style="margin-left: 5px;">
			                                                                                    </label>
									                                                            <asp:DropDownList ID="ddlZoneFromForRow5" runat="server" CssClass="blackfnt">
									                                                            </asp:DropDownList>
									                                                        </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="ddlZoneHeader" EventName="SelectedIndexChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upZTR5" runat="server">
										                                                    <ContentTemplate>
							                                                                    <label style="margin-left: 5px;">
			                                                                                    </label>
									                                                            <asp:DropDownList ID="ddlZoneToForRow5" runat="server" CssClass="blackfnt">
									                                                            </asp:DropDownList>
									                                                        </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="ddlZoneHeader" EventName="SelectedIndexChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center" runat="server" id="tdAirZoneForRow5">
								                                                        <input id="txtFreightForAirZoneForRow5" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirForRowTrDaysForZone5">
								                                                        <input id="txtAirTrDaysRowForZone5" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadZoneForRow5">
								                                                        <input id="txtFreightForRoadZoneForRow5" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRowTrDaysForZone5">
								                                                        <input id="txtRoadTrDaysRowForZone5" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainZoneForRow5">
								                                                        <input id="txtFreightForTrainZoneForRow5" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRowTrDaysForZone5">
								                                                        <input id="txtTrainTrDaysRowForZone5" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressZoneForRow5">
								                                                        <input id="txtFreightForExpressZoneForRow5" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRowTrDaysForZone5">
								                                                        <input id="txtExpressTrDaysRowForZone5" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
							                                                    </tr>
							                                                    
							                                                    <%--table row for Freight Matrix for Zone - Row 6--%>
							                                                    <tr id="Tr16" runat="server" style="background-color: White">
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upZFR6" runat="server">
										                                                    <ContentTemplate>
							                                                                    <label style="margin-left: 5px;">
			                                                                                    </label>
									                                                            <asp:DropDownList ID="ddlZoneFromForRow6" runat="server" CssClass="blackfnt">
									                                                            </asp:DropDownList>
									                                                        </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="ddlZoneHeader" EventName="SelectedIndexChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upZTR6" runat="server">
										                                                    <ContentTemplate>
							                                                                    <label style="margin-left: 5px;">
			                                                                                    </label>
									                                                            <asp:DropDownList ID="ddlZoneToForRow6" runat="server" CssClass="blackfnt">
									                                                            </asp:DropDownList>
									                                                        </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="ddlZoneHeader" EventName="SelectedIndexChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center" runat="server" id="tdAirZoneForRow6">
								                                                        <input id="txtFreightForAirZoneForRow6" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirForRowTrDaysForZone6">
								                                                        <input id="txtAirTrDaysRowForZone6" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadZoneForRow6">
								                                                        <input id="txtFreightForRoadZoneForRow6" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRowTrDaysForZone6">
								                                                        <input id="txtRoadTrDaysRowForZone6" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainZoneForRow6">
								                                                        <input id="txtFreightForTrainZoneForRow6" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRowTrDaysForZone6">
								                                                        <input id="txtTrainTrDaysRowForZone6" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressZoneForRow6">
								                                                        <input id="txtFreightForExpressZoneForRow6" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRowTrDaysForZone6">
								                                                        <input id="txtExpressTrDaysRowForZone6" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
							                                                    </tr>
							                                                    
							                                                    <%--table row for Freight Matrix for Zone - Row 7--%>
							                                                    <tr id="Tr17" runat="server" style="background-color: White">
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upZFR7" runat="server">
										                                                    <ContentTemplate>
							                                                                    <label style="margin-left: 5px;">
			                                                                                    </label>
									                                                            <asp:DropDownList ID="ddlZoneFromForRow7" runat="server" CssClass="blackfnt">
									                                                            </asp:DropDownList>
									                                                        </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="ddlZoneHeader" EventName="SelectedIndexChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upZTR7" runat="server">
										                                                    <ContentTemplate>
							                                                                    <label style="margin-left: 5px;">
			                                                                                    </label>
									                                                            <asp:DropDownList ID="ddlZoneToForRow7" runat="server" CssClass="blackfnt">
									                                                            </asp:DropDownList>
									                                                        </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="ddlZoneHeader" EventName="SelectedIndexChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center" runat="server" id="tdAirZoneForRow7">
								                                                        <input id="txtFreightForAirZoneForRow7" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirForRowTrDaysForZone7">
								                                                        <input id="txtAirTrDaysRowForZone7" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadZoneForRow7">
								                                                        <input id="txtFreightForRoadZoneForRow7" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRowTrDaysForZone7">
								                                                        <input id="txtRoadTrDaysRowForZone7" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainZoneForRow7">
								                                                        <input id="txtFreightForTrainZoneForRow7" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRowTrDaysForZone7">
								                                                        <input id="txtTrainTrDaysRowForZone7" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressZoneForRow7">
								                                                        <input id="txtFreightForExpressZoneForRow7" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRowTrDaysForZone7">
								                                                        <input id="txtExpressTrDaysRowForZone7" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
							                                                    </tr>
							                                                    
							                                                    <%--table row for Freight Matrix for Zone - Row 8--%>
							                                                    <tr id="Tr18" runat="server" style="background-color: White">
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upZFR8" runat="server">
										                                                    <ContentTemplate>
							                                                                    <label style="margin-left: 5px;">
			                                                                                    </label>
									                                                            <asp:DropDownList ID="ddlZoneFromForRow8" runat="server" CssClass="blackfnt">
									                                                            </asp:DropDownList>
									                                                        </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="ddlZoneHeader" EventName="SelectedIndexChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upZTR8" runat="server">
										                                                    <ContentTemplate>
							                                                                    <label style="margin-left: 5px;">
			                                                                                    </label>
									                                                            <asp:DropDownList ID="ddlZoneToForRow8" runat="server" CssClass="blackfnt">
									                                                            </asp:DropDownList>
									                                                    </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="ddlZoneHeader" EventName="SelectedIndexChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center" runat="server" id="tdAirZoneForRow8">
								                                                        <input id="txtFreightForAirZoneForRow8" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirForRowTrDaysForZone8">
								                                                        <input id="txtAirTrDaysRowForZone8" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadZoneForRow8">
								                                                        <input id="txtFreightForRoadZoneForRow8" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRowTrDaysForZone8">
								                                                        <input id="txtRoadTrDaysRowForZone8" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainZoneForRow8">
								                                                        <input id="txtFreightForTrainZoneForRow8" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRowTrDaysForZone8">
								                                                        <input id="txtTrainTrDaysRowForZone8" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressZoneForRow8">
								                                                        <input id="txtFreightForExpressZoneForRow8" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRowTrDaysForZone8">
								                                                        <input id="txtExpressTrDaysRowForZone8" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
							                                                    </tr>
							                                                    
							                                                    <%--table row for Freight Matrix for Zone - Row 9--%>
							                                                    <tr id="Tr19" runat="server" style="background-color: White">
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upZFR9" runat="server">
										                                                    <ContentTemplate>
							                                                                    <label style="margin-left: 5px;">
			                                                                                    </label>
									                                                            <asp:DropDownList ID="ddlZoneFromForRow9" runat="server" CssClass="blackfnt">
									                                                            </asp:DropDownList>
									                                                        </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="ddlZoneHeader" EventName="SelectedIndexChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upZTR9" runat="server">
										                                                    <ContentTemplate>
							                                                                    <label style="margin-left: 5px;">
			                                                                                    </label>
									                                                            <asp:DropDownList ID="ddlZoneToForRow9" runat="server" CssClass="blackfnt">
									                                                            </asp:DropDownList>
									                                                        </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="ddlZoneHeader" EventName="SelectedIndexChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center" runat="server" id="tdAirZoneForRow9">
								                                                        <input id="txtFreightForAirZoneForRow9" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirForRowTrDaysForZone9">
								                                                        <input id="txtAirTrDaysRowForZone9" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadZoneForRow9">
								                                                        <input id="txtFreightForRoadZoneForRow9" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRowTrDaysForZone9">
								                                                        <input id="txtRoadTrDaysRowForZone9" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainZoneForRow9">
								                                                        <input id="txtFreightForTrainZoneForRow9" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRowTrDaysForZone9">
								                                                        <input id="txtTrainTrDaysRowForZone9" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressZoneForRow9">
								                                                        <input id="txtFreightForExpressZoneForRow9" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRowTrDaysForZone9">
								                                                        <input id="txtExpressTrDaysRowForZone9" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
							                                                    </tr>
							                                                    
							                                                    <%--table row for Freight Matrix for Zone - Row 10--%>
							                                                    <tr id="Tr20" runat="server" style="background-color: White">
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upZFR10" runat="server">
										                                                    <ContentTemplate>
							                                                                    <label style="margin-left: 5px;">
			                                                                                    </label>
									                                                            <asp:DropDownList ID="ddlZoneFromForRow10" runat="server" CssClass="blackfnt">
									                                                            </asp:DropDownList>
									                                                        </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="ddlZoneHeader" EventName="SelectedIndexChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upZTR10" runat="server">
										                                                    <ContentTemplate>
							                                                                    <label style="margin-left: 5px;">
			                                                                                    </label>
									                                                            <asp:DropDownList ID="ddlZoneToForRow10" runat="server" CssClass="blackfnt">
									                                                            </asp:DropDownList>
									                                                        </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="ddlZoneHeader" EventName="SelectedIndexChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center" runat="server" id="tdAirZoneForRow10">
								                                                        <input id="txtFreightForAirZoneForRow10" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirForRowTrDaysForZone10">
								                                                        <input id="txtAirTrDaysRowForZone10" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadZoneForRow10">
								                                                        <input id="txtFreightForRoadZoneForRow10" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRowTrDaysForZone10">
								                                                        <input id="txtRoadTrDaysRowForZone10" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainZoneForRow10">
								                                                        <input id="txtFreightForTrainZoneForRow10" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRowTrDaysForZone10">
								                                                        <input id="txtTrainTrDaysRowForZone10" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressZoneForRow10">
								                                                        <input id="txtFreightForExpressZoneForRow10" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRowTrDaysForZone10">
								                                                        <input id="txtExpressTrDaysRowForZone10" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
							                                                    </tr>
							                                                </table>
							                                                
							                                                <br style="font-size: 6pt;" />
								        									
								        									<p align="center">
								        									    <label class="blackfnt">
								        									        <b>
								        									            City Matrix
								        									        </b>
								        									    </label>
								        									</p>
								        									
							                                                <p align="left">
							                                                    <label class="bluefnt">
							                                                        <b>
							                                                            Freight Rate
							                                                        </b>
							                                                    </label>
							                                                </p>
							                                                
							                                                <table border="0" cellpadding="2" width="50%" cellspacing="1" align="center" class="boxbg">
									                                            <tr style="background-color: White">
									                                                <td align="left">
									                                                    <label class="blackfnt">
									                                                        City:
									                                                    </label>
									                                                </td>
									                                                
										                                            <td align="left">
										                                                <asp:UpdatePanel ID="upCity" runat="server">
										                                                    <ContentTemplate>
										                                                        <asp:TextBox ID="txtCity" runat="server" MaxLength="50" 
										                                                            OnTextChanged="txtCity_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="150px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
										                                                        <input type="button" value="..." runat="server" id="btnCity" 
                                                                                                    onclick="return BranchPopup('City_Popup.aspx?1')" />
                                                                                                <br />
                                                                                                <label class="blackfnt" id="lblErrorCity" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid City Name!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtCity" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
										                                            </td>
									                                            </tr>
									                                        </table>
									                                        
									                                        <br style="font-size: 6pt;"/>	
					
					                                                        <table border="0" align="center" cellspacing="1" cellpadding="5" width="100%" class="boxbg">
						                                                        <tr style="background-color: White">
							                                                        <td align="center">
							                                                            <label class="blackfnt">
							                                                                From&nbsp;
								                                                            <input type="button" value="..." runat="server" id="btnCityFrom" 
                                                                                                onclick="return BranchPopup('City_Popup_Multi_Selection.aspx?1')" />
							                                                            </label>
							                                                        </td>
							                                                        
								                                                    <td align="center">
								                                                        <label class="blackfnt">
								                                                            To&nbsp;
								                                                            <input type="button" value="..." runat="server" id="btnCityTo" 
                                                                                                onclick="return BranchPopup('City_Popup_Multi_Selection.aspx?2')" />
								                                                        </label>
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirHeaderForCity">
								                                                        <label class="blackfnt" runat="server" id="lblAirHeaderForCity">
								                                                        </label>
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirHeaderForTrDaysForCity">
								                                                        <label class="blackfnt" id="lblAirHeaderForTrDaysForCity" runat="server">
								                                                            Transit Days
								                                                        </label>
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadHeaderForCity">
								                                                        <label class="blackfnt" runat="server" id="lblRoadHeaderForCity">
								                                                        </label>
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadHeaderForTrDaysForCity">
								                                                        <label class="blackfnt" id="lblRoadHeaderForTrDaysForCity" runat="server">
								                                                            Transit Days
								                                                        </label>
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainHeaderForCity">
								                                                        <label class="blackfnt" runat="server" id="lblTrainHeaderForCity">
								                                                        </label>
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainHeaderForTrDaysForCity">
								                                                        <label class="blackfnt" id="lblTrainHeaderForTrDaysForCity" runat="server">
								                                                            Transit Days
								                                                        </label>
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressHeaderForCity">
								                                                        <label class="blackfnt" runat="server" id="lblExpressHeaderForCity">
								                                                        </label>
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressHeaderForTrDaysForCity">
								                                                        <label class="blackfnt" id="lblExpressHeaderForTrDaysForCity" runat="server">
								                                                            Transit Days
								                                                        </label>
								                                                    </td>
							                                                    </tr>
							                                                    
							                                                    <%--table row for Freight Matrix for Branch - Row 1--%>
							                                                    <tr id="Tr21" runat="server" style="background-color: White">
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upFCR1" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtFromCityRow1" runat="server" MaxLength="50" 
										                                                            OnTextChanged="txtFromCityRow1_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="75px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorFromCityRow1" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid City Name!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtFromCityRow1" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>    
							                                                        
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upTCR1" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtToCityRow1" runat="server" MaxLength="50" 
										                                                            OnTextChanged="txtToCityRow1_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="75px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorToCityRow1" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid City Name!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtToCityRow1" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center" runat="server" id="tdAirCityForRow1">
								                                                        <input id="txtAirCityForRow1" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirForRowTrDaysForCity1">
								                                                        <input id="txtAirTrDaysRowForCity1" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadCityForRow1">
								                                                        <input id="txtRoadCityForRow1" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRowTrDaysForCity1">
								                                                        <input id="txtRoadTrDaysRowForCity1" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainCityForRow1">
								                                                        <input id="txtTrainCityForRow1" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRowTrDaysForCity1">
								                                                        <input id="txtTrainTrDaysRowForCity1" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressCityForRow1">
								                                                        <input id="txtExpressCityForRow1" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRowTrDaysForCity1">
								                                                        <input id="txtExpressTrDaysRowForCity1" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
							                                                    </tr>
							                                                    
							                                                    <%--table row for Freight Matrix for Branch - Row 2--%>
							                                                    <tr id="Tr22" runat="server" style="background-color: White">
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upFCR2" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtFromCityRow2" runat="server" MaxLength="50" 
										                                                            OnTextChanged="txtFromCityRow2_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="75px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorFromCityRow2" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid City Name!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtFromCityRow2" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>    
							                                                        
							                                                        <td align="center"> 
							                                                            <asp:UpdatePanel ID="upTCR2" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtToCityRow2" runat="server" MaxLength="50" 
										                                                            OnTextChanged="txtToCityRow2_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="75px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorToCityRow2" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid City Name!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtToCityRow2" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center" runat="server" id="tdAirCityForRow2">
								                                                        <input id="txtAirCityForRow2" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirForRowTrDaysForCity2">
								                                                        <input id="txtAirTrDaysRowForCity2" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadCityForRow2">
								                                                        <input id="txtRoadCityForRow2" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRowTrDaysForCity2">
								                                                        <input id="txtRoadTrDaysRowForCity2" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainCityForRow2"> 
								                                                        <input id="txtTrainCityForRow2" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRowTrDaysForCity2">
								                                                        <input id="txtTrainTrDaysRowForCity2" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressCityForRow2">
								                                                        <input id="txtExpressCityForRow2" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRowTrDaysForCity2">
								                                                        <input id="txtExpressTrDaysRowForCity2" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
							                                                    </tr>
							                                                    
							                                                    <%--table row for Freight Matrix for Branch - Row 3--%>
							                                                    <tr id="Tr23" runat="server" style="background-color: White">
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upFCR3" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtFromCityRow3" runat="server" MaxLength="50" 
										                                                            OnTextChanged="txtFromCityRow3_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="75px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorFromCityRow3" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid City Name!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtFromCityRow3" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>    
							                                                        
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upTCR3" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtToCityRow3" runat="server" MaxLength="50" 
										                                                            OnTextChanged="txtToCityRow3_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="75px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorToCityRow3" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid City Name!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtToCityRow3" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center" runat="server" id="tdAirCityForRow3">
								                                                        <input id="txtAirCityForRow3" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirForRowTrDaysForCity3">
								                                                        <input id="txtAirTrDaysRowForCity3" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadCityForRow3">
								                                                        <input id="txtRoadCityForRow3" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRowTrDaysForCity3">
								                                                        <input id="txtRoadTrDaysRowForCity3" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainCityForRow3">
								                                                        <input id="txtTrainCityForRow3" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRowTrDaysForCity3">
								                                                        <input id="txtTrainTrDaysRowForCity3" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressCityForRow3">
								                                                        <input id="txtExpressCityForRow3" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRowTrDaysForCity3">
								                                                        <input id="txtExpressTrDaysRowForCity3" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
							                                                    </tr>
							                                                    
							                                                    <%--table row for Freight Matrix for Branch - Row 4--%>
							                                                    <tr id="Tr24" runat="server" style="background-color: White">
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upFCR4" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtFromCityRow4" runat="server" MaxLength="50" 
										                                                            OnTextChanged="txtFromCityRow4_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="75px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorFromCityRow4" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid City Name!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtFromCityRow4" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>    
							                                                        
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upTCR4" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtToCityRow4" runat="server" MaxLength="50" 
										                                                            OnTextChanged="txtToCityRow4_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="75px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorToCityRow4" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid City Name!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtToCityRow4" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center" runat="server" id="tdAirCityForRow4">
								                                                        <input id="txtAirCityForRow4" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirForRowTrDaysForCity4">
								                                                        <input id="txtAirTrDaysRowForCity4" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadCityForRow4">
								                                                        <input id="txtRoadCityForRow4" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRowTrDaysForCity4">
								                                                        <input id="txtRoadTrDaysRowForCity4" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainCityForRow4">
								                                                        <input id="txtTrainCityForRow4" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRowTrDaysForCity4">
								                                                        <input id="txtTrainTrDaysRowForCity4" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressCityForRow4">
								                                                        <input id="txtExpressCityForRow4" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRowTrDaysForCity4">
								                                                        <input id="txtExpressTrDaysRowForCity4" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
							                                                    </tr>
							                                                    
							                                                    <%--table row for Freight Matrix for Branch - Row 5--%>
							                                                    <tr id="Tr25" runat="server" style="background-color: White">
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upFCR5" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtFromCityRow5" runat="server" MaxLength="50" 
										                                                            OnTextChanged="txtFromCityRow5_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="75px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorFromCityRow5" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid City Name!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtFromCityRow5" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upTCR5" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtToCityRow5" runat="server" MaxLength="50" 
										                                                            OnTextChanged="txtToCityRow5_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="75px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorToCityRow5" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid City Name!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtToCityRow5" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center" runat="server" id="tdAirCityForRow5">
								                                                        <input id="txtAirCityForRow5" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirForRowTrDaysForCity5">
								                                                        <input id="txtAirTrDaysRowForCity5" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadCityForRow5">
								                                                        <input id="txtRoadCityForRow5" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRowTrDaysForCity5">
								                                                        <input id="txtRoadTrDaysRowForCity5" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainCityForRow5">
								                                                        <input id="txtTrainCityForRow5" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRowTrDaysForCity5">
								                                                        <input id="txtTrainTrDaysRowForCity5" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressCityForRow5">
								                                                        <input id="txtExpressCityForRow5" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRowTrDaysForCity5">
								                                                        <input id="txtExpressTrDaysRowForCity5" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
							                                                    </tr>
							                                                    
							                                                    <%--table row for Freight Matrix for Branch - Row 6--%>
							                                                    <tr id="Tr26" runat="server" style="background-color: White">
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upFCR6" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtFromCityRow6" runat="server" MaxLength="50" 
										                                                            OnTextChanged="txtFromCityRow6_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="75px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorFromCityRow6" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid City Name!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtFromCityRow6" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upTCR6" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtToCityRow6" runat="server" MaxLength="50" 
										                                                            OnTextChanged="txtToCityRow6_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="75px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorToCityRow6" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid City Name!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtToCityRow6" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center" runat="server" id="tdAirCityForRow6">
								                                                        <input id="txtAirCityForRow6" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirForRowTrDaysForCity6">
								                                                        <input id="txtAirTrDaysRowForCity6" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadCityForRow6">
								                                                        <input id="txtRoadCityForRow6" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRowTrDaysForCity6">
								                                                        <input id="txtRoadTrDaysRowForCity6" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainCityForRow6">
								                                                        <input id="txtTrainCityForRow6" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRowTrDaysForCity6">
								                                                        <input id="txtTrainTrDaysRowForCity6" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressCityForRow6">
								                                                        <input id="txtExpressCityForRow6" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRowTrDaysForCity6">
								                                                        <input id="txtExpressTrDaysRowForCity6" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
							                                                    </tr>
							                                                    
							                                                    <%--table row for Freight Matrix for Branch - Row 7--%>
							                                                    <tr id="Tr27" runat="server" style="background-color: White">
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upFCR7" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtFromCityRow7" runat="server" MaxLength="50" 
										                                                            OnTextChanged="txtFromCityRow7_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="75px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorFromCityRow7" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid City Name!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtFromCityRow7" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upTCR7" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtToCityRow7" runat="server" MaxLength="50" 
										                                                            OnTextChanged="txtToCityRow7_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="75px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorToCityRow7" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid City Name!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtToCityRow7" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center" runat="server" id="tdAirCityForRow7">
								                                                        <input id="txtAirCityForRow7" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirForRowTrDaysForCity7">
								                                                        <input id="txtAirTrDaysRowForCity7" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadCityForRow7">
								                                                        <input id="txtRoadCityForRow7" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRowTrDaysForCity7">
								                                                        <input id="txtRoadTrDaysRowForCity7" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainCityForRow7">
								                                                        <input id="txtTrainCityForRow7" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRowTrDaysForCity7">
								                                                        <input id="txtTrainTrDaysRowForCity7" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressCityForRow7">
								                                                        <input id="txtExpressCityForRow7" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRowTrDaysForCity7">
								                                                        <input id="txtExpressTrDaysRowForCity7" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
							                                                    </tr>
							                                                    
							                                                    <%--table row for Freight Matrix for Branch - Row 8--%>
							                                                    <tr id="Tr28" runat="server" style="background-color: White">
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upFCR8" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtFromCityRow8" runat="server" MaxLength="50" 
										                                                            OnTextChanged="txtFromCityRow8_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="75px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorFromCityRow8" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid City Name!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtFromCityRow8" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upTCR8" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtToCityRow8" runat="server" MaxLength="50" 
										                                                            OnTextChanged="txtToCityRow8_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="75px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorToCityRow8" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid City Name!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtToCityRow8" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center" runat="server" id="tdAirCityForRow8">
								                                                        <input id="txtAirCityForRow8" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirForRowTrDaysForCity8">
								                                                        <input id="txtAirTrDaysRowForCity8" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadCityForRow8">
								                                                        <input id="txtRoadCityForRow8" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRowTrDaysForCity8">
								                                                        <input id="txtRoadTrDaysRowForCity8" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainCityForRow8">
								                                                        <input id="txtTrainCityForRow8" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRowTrDaysForCity8">
								                                                        <input id="txtTrainTrDaysRowForCity8" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressCityForRow8">
								                                                        <input id="txtExpressCityForRow8" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRowTrDaysForCity8">
								                                                        <input id="txtExpressTrDaysRowForCity8" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
							                                                    </tr>
							                                                    
							                                                    <%--table row for Freight Matrix for Branch - Row 9--%>
							                                                    <tr id="Tr29" runat="server" style="background-color: White">
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upFCR9" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtFromCityRow9" runat="server" MaxLength="50" 
										                                                            OnTextChanged="txtFromCityRow9_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="75px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorFromCityRow9" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid City Name!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtFromCityRow9" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upTCR9" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtToCityRow9" runat="server" MaxLength="50" 
										                                                            OnTextChanged="txtToCityRow9_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="75px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorToCityRow9" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid City Name!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtToCityRow9" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center" runat="server" id="tdAirCityForRow9">
								                                                        <input id="txtAirCityForRow9" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirForRowTrDaysForCity9">
								                                                        <input id="txtAirTrDaysRowForCity9" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadCityForRow9">
								                                                        <input id="txtRoadCityForRow9" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRowTrDaysForCity9">
								                                                        <input id="txtRoadTrDaysRowForCity9" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainCityForRow9">
								                                                        <input id="txtTrainCityForRow9" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRowTrDaysForCity9">
								                                                        <input id="txtTrainTrDaysRowForCity9" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressCityForRow9">
								                                                        <input id="txtExpressCityForRow9" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRowTrDaysForCity9">
								                                                        <input id="txtExpressTrDaysRowForCity9" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
							                                                    </tr>
							                                                    
							                                                    <%--table row for Freight Matrix for Branch - Row 10--%>
							                                                    <tr id="Tr30" runat="server" style="background-color: White">
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upFCR10" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtFromCityRow10" runat="server" MaxLength="50" 
										                                                            OnTextChanged="txtFromCityRow10_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="75px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorFromCityRow10" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid City Name!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtFromCityRow10" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center">
							                                                            <asp:UpdatePanel ID="upTCR10" runat="server">
										                                                    <ContentTemplate>
							                                                                    <asp:TextBox ID="txtToCityRow10" runat="server" MaxLength="50" 
										                                                            OnTextChanged="txtToCityRow10_TextChanged" CssClass="input" 
										                                                            AutoPostBack="true" Width="75px" style="margin-left: 5px;">
										                                                        </asp:TextBox>
                                                                                                <label class="blackfnt" id="lblErrorToCityRow10" runat="server" style="color: Red;" visible="false">
                                                                                                    &nbsp;Invalid City Name!!!
                                                                                                </label>
                                                                                            </ContentTemplate>
										                                                    <Triggers>
										                                                        <asp:AsyncPostBackTrigger ControlID="txtToCityRow10" EventName="TextChanged" />
										                                                    </Triggers>
										                                                </asp:UpdatePanel>
							                                                        </td>
							                                                        
							                                                        <td align="center" runat="server" id="tdAirCityForRow10">
								                                                        <input id="txtAirCityForRow10" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdAirForRowTrDaysForCity10">
								                                                        <input id="txtAirTrDaysRowForCity10" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadCityForRow10">
								                                                        <input id="txtRoadCityForRow10" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdRoadForRowTrDaysForCity10">
								                                                        <input id="txtRoadTrDaysRowForCity10" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainCityForRow10">
								                                                        <input id="txtTrainCityForRow10" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdTrainForRowTrDaysForCity10">
								                                                        <input id="txtTrainTrDaysRowForCity10" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressCityForRow10">
								                                                        <input id="txtExpressCityForRow10" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
								                                                    
								                                                    <td align="center" runat="server" id="tdExpressForRowTrDaysForCity10">
								                                                        <input id="txtExpressTrDaysRowForCity10" type="text" size="10" class="input" 
                                                                                            maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                            style="margin-left: 5px;" runat="server" />
								                                                    </td>
							                                                    </tr>
				                                                            </table>
							                                            </td>
							                                        </tr>
					                                            </table>
					                                                
			                                                    <table border="0" cellpadding="2" width="85%" cellspacing="1" align="center">
                                                                    <tr style="background-color: White">
                                                                        <td colspan="4" align="center">
                                                                            <br />
                                                                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClientClick="return ValidateData()" 
                                                                                OnClick="btnSubmit_Click" ToolTip="Click here to Submit and Proceed" />
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
                </td>
            </tr>
        </table>
        
        <br />
			                                                
        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
            <ProgressTemplate>
                <div id="progressArea">
                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="blackfnt" Font-Bold="true"></asp:Label>
                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
        
    </div>                                                            
        
</asp:Content>
