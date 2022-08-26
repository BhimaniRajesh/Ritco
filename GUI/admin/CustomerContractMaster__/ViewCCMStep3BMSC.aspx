<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="EditCCMStep3BMSC.aspx.cs" Inherits="GUI_admin_CustomerContractMaster_EditCCMStep3BMSC" Title="Customer Contract Master - SUNDRY" %>

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
        
        function disableenter()
        {
        
        }
        
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
        
//        function CheckBranchCityMatrix(MOT, BranchCity)
//        {
//            var mCtlForFRFrom = "ctl00_MyCPH1_txtFromFor" + MOT + "For" + BranchCity;
//            var mCtlForFRFromErrorLabel = "ctl00_MyCPH1_lblFromFor" + MOT + "For" + BranchCity;
//            var mCtlForFRTo = "ctl00_MyCPH1_txtToFor" + MOT + "For" + BranchCity;
//            var mCtlForFRToErrorLabel = "ctl00_MyCPH1_lblToFor" + MOT + "For" + BranchCity;
//            var mCtlForTrDays = "ctl00_MyCPH1_txtTrDaysFor" + MOT + "For" + BranchCity;
//            var mCtlForRateType = "ctl00_MyCPH1_ddlRateTypeFor" + MOT + BranchCity;
//            var mCtlForSlab1 = "ctl00_MyCPH1_txtSlab1For" + MOT + BranchCity;
//            var mCtlForSlab2 = "ctl00_MyCPH1_txtSlab2For" + MOT + BranchCity;
//            var mCtlForSlab3 = "ctl00_MyCPH1_txtSlab3For" + MOT + BranchCity;
//            var mCtlForSlab4 = "ctl00_MyCPH1_txtSlab4For" + MOT + BranchCity;
//            var mCtlForSlab5 = "ctl00_MyCPH1_txtSlab5For" + MOT + BranchCity;
//            var mCtlForSlab6 = "ctl00_MyCPH1_txtSlab6For" + MOT + BranchCity;
//            var mCtlForFRFromZone = "ctl00_MyCPH1_ddlZone" + MOT + "FromForRow";
//            var mCtlForFRToZone = "ctl00_MyCPH1_ddlZone" + MOT + "ToForRow";
//            
//            var mVarBM = "";
//            var mVarBMTemp = "";
//            
//            //Check for Branch/City Matrix
//            for(var mLoopCounter = 1 ; mLoopCounter <= 1; mLoopCounter++)
//            {
//                if( ( BranchCity != "Zone" && document.getElementById(mCtlForFRFrom + mLoopCounter) && document.getElementById(mCtlForFRTo + mLoopCounter) ) ||  ( BranchCity == "Zone" && document.getElementById(mCtlForFRFromZone + mLoopCounter) && document.getElementById(mCtlForFRToZone + mLoopCounter) ))
//                {
////                    var mFromValue = (BranchCity != "Zone" ? document.getElementById(mCtlForFRFrom + mLoopCounter).value : document.getElementById(mCtlForFRFromZone + mLoopCounter).value);
////                    var mToValue = (BranchCity != "Zone" ? document.getElementById(mCtlForFRTo + mLoopCounter).value : document.getElementById(mCtlForFRToZone + mLoopCounter).value);
//                    var mDataExists = 0;
//                    
//                    if( ( BranchCity != "Zone" && document.getElementById(mCtlForFRFrom + mLoopCounter).value != "" && document.getElementById(mCtlForFRTo + mLoopCounter).value != "" ) ||  ( BranchCity == "Zone" && document.getElementById(mCtlForFRFromZone + mLoopCounter).value != "-1" && document.getElementById(mCtlForFRToZone + mLoopCounter).value != "-1" ))
//                    {
//                        mDataExists = 1;
//                    }
//                    //if((document.getElementById(mCtlForFRFrom + mLoopCounter).value != "" || document.getElementById(mCtlForFRFrom + mLoopCounter).value != "-1") && (document.getElementById(mCtlForFRTo + mLoopCounter).value != "" || document.getElementById(mCtlForFRTo + mLoopCounter).value != "-1"))
//                    if(mDataExists == 1)
//                    {   
//                        //Check for Branch From for Mode of Transport 
//                        if(BranchCity == "Zone")
//                        {
//                            if(document.getElementById(mCtlForFRFromZone + mLoopCounter))
//                            {
//                                if(document.getElementById(mCtlForFRFromZone + mLoopCounter).value != "-1")
//                                {
//                                    mVarBMTemp = document.getElementById(mCtlForFRFromZone + mLoopCounter).value;
//                                }
//                                else
//                                {
//                                    alert("Select Zone From for " + MOT);
//                                    document.getElementById(mCtlForFRFromZone + mLoopCounter).focus();
//                                    return false;
//                                }
//                            }
//                    
//                            //Check for Branch/City To for Mode of Transport
//                            if(document.getElementById(mCtlForFRToZone + mLoopCounter))
//                            {
//                                if(document.getElementById(mCtlForFRToZone + mLoopCounter).value != "-1")
//                                {
//                                    mVarBMTemp += "," + document.getElementById(mCtlForFRToZone + mLoopCounter).value;
//                                }
//                                else
//                                {
//                                    alert("Select Zone To for " + MOT);
//                                    document.getElementById(mCtlForFRToZone + mLoopCounter).focus();
//                                    return false;
//                                }
//                            }
//                        }
//                        else
//                        {
//                            if(document.getElementById(mCtlForFRFrom + mLoopCounter))
//                            {
//                                if(document.getElementById(mCtlForFRFrom + mLoopCounter).value != "")
//                                {
//                                    if(document.getElementById(mCtlForFRFromErrorLabel + mLoopCounter))
//                                    {
//                                        if(document.getElementById(mCtlForFRFromErrorLabel + mLoopCounter).style.display == '')
//                                        {
//                                            alert("Invalid '" + BranchCity + " Code' for " + MOT);
//                                            document.getElementById(mCtlForFRFrom + mLoopCounter).focus();
//                                            return false;
//                                        }
//                                    }
//                                    mVarBMTemp = document.getElementById(mCtlForFRFrom + mLoopCounter).value;
//                                }
//                                else
//                                {
//                                    alert("Enter/Select '" + BranchCity + " Code' for " + MOT);
//                                    document.getElementById(mCtlForFRFrom + mLoopCounter).focus();
//                                    return false;
//                                }
//                            }
//                            
//                            //Check for Branch/City To for Mode of Transport
//                            if(document.getElementById(mCtlForFRTo + mLoopCounter))
//                            {
//                                if(document.getElementById(mCtlForFRTo + mLoopCounter).value != "")
//                                {
//                                    if(document.getElementById(mCtlForFRToErrorLabel + mLoopCounter))
//                                    {
//                                        if(document.getElementById(mCtlForFRToErrorLabel + mLoopCounter).style.display == '')
//                                        {
//                                            alert("Invalid '" + BranchCity + " Code' for " + MOT);
//                                            document.getElementById(mCtlForFRTo + mLoopCounter).focus();
//                                            return false;
//                                        }
//                                    }
//                                    mVarBMTemp += "," + document.getElementById(mCtlForFRTo + mLoopCounter).value;
//                                }
//                                else
//                                {
//                                    alert("Enter/Select '" + BranchCity + " Code' for " + MOT);
//                                    document.getElementById(mCtlForFRTo + mLoopCounter).focus();
//                                    return false;
//                                }
//                            }
//                        }
//                        
//                        //Check for Transit Days for Mode of Transport Branch/City/Zone
//                        if(document.getElementById(mCtlForTrDays + mLoopCounter))
//                        {
//                            if(document.getElementById(mCtlForTrDays + mLoopCounter).value == "")
//                            {
//                                alert("Enter 'Transit Days' for '" + MOT + "' For '" + BranchCity + "'");
//                                document.getElementById(mCtlForTrDays + mLoopCounter).focus();
//                                return false;
//                            }
//                            else
//                            {
//                                mVarBMTemp += "," + document.getElementById(mCtlForTrDays + mLoopCounter).value;
//                            }
//                        }
//                                    
//                        //Check for Rate Type for Mode of Transport for Branch/Zone/City
//                        if(document.getElementById(mCtlForRateType + mLoopCounter))
//                        {
//                            if(document.getElementById(mCtlForRateType + mLoopCounter).value == "-1")
//                            {
//                                alert("Select 'Rate Type' from the list");
//                                document.getElementById(mCtlForRateType + mLoopCounter).focus();
//                                return false;
//                            }
//                            else
//                            {
//                                mVarBMTemp += "," + document.getElementById(mCtlForRateType + mLoopCounter).value;
//                            }
//                        }
//                        
//                        //Check for Slab 1 for Mode of Transport for Branch/Zone/City
//                        if(document.getElementById(mCtlForSlab1 + mLoopCounter))
//                        {
//                            if(document.getElementById(mCtlForSlab1 + mLoopCounter).value == "")
//                            {
//                                alert("Enter 'Slab 1' from the list");
//                                document.getElementById(mCtlForSlab1 + mLoopCounter).focus();
//                                return false;
//                            }
//                            else
//                            {
//                                mVarBMTemp += "," + document.getElementById(mCtlForSlab1 + mLoopCounter).value;
//                            }
//                        }
//                        
//                        //Check for Slab 2 for Mode of Transport for Branch/Zone/City
//                        if(document.getElementById(mCtlForSlab2 + mLoopCounter))
//                        {
//                            if(document.getElementById(mCtlForSlab2 + mLoopCounter).value == "")
//                            {
//                                mVarBMTemp += ",";
//                            }
//                            else
//                            {
//                                mVarBMTemp += "," + document.getElementById(mCtlForSlab2 + mLoopCounter).value;
//                            }
//                        }
//                        
//                        //Check for Slab 3 for Mode of Transport for Branch/Zone/City
//                        if(document.getElementById(mCtlForSlab3 + mLoopCounter))
//                        {
//                            if(document.getElementById(mCtlForSlab3 + mLoopCounter).value == "")
//                            {
//                                mVarBMTemp += ",";
//                            }
//                            else
//                            {
//                                mVarBMTemp += "," + document.getElementById(mCtlForSlab3 + mLoopCounter).value;
//                            }
//                        }
//                        
//                        //Check for Slab 4 for Mode of Transport for Branch/Zone/City
//                        if(document.getElementById(mCtlForSlab4 + mLoopCounter))
//                        {
//                            if(document.getElementById(mCtlForSlab4 + mLoopCounter).value == "")
//                            {
//                                mVarBMTemp += ",";
//                            }
//                            else
//                            {
//                                mVarBMTemp += "," + document.getElementById(mCtlForSlab4 + mLoopCounter).value;
//                            }
//                        }
//                        
//                        //Check for Slab 5 for Mode of Transport for Branch/Zone/City
//                        if(document.getElementById(mCtlForSlab5 + mLoopCounter))
//                        {
//                            if(document.getElementById(mCtlForSlab5 + mLoopCounter).value == "")
//                            {
//                                mVarBMTemp += ",";
//                            }
//                            else
//                            {
//                                mVarBMTemp += "," + document.getElementById(mCtlForSlab5 + mLoopCounter).value;
//                            }
//                        }
//                        
//                        //Check for Slab 6 for Mode of Transport for Branch/Zone/City
//                        if(document.getElementById(mCtlForSlab6 + mLoopCounter))
//                        {
//                            if(document.getElementById(mCtlForSlab6 + mLoopCounter).value == "")
//                            {
//                                mVarBMTemp += ",";
//                            }
//                            else
//                            {
//                                mVarBMTemp += "," + document.getElementById(mCtlForSlab6 + mLoopCounter).value;
//                            }
//                        }
//                        
//                        if(mVarBMTemp != "")
//                        {
//                            mVarBM = (mVarBM == "" ? mVarBMTemp : mVarBM + "~" + mVarBMTemp);
//                            mVarBMTemp = "";
//                        }
//                    }
//                    else
//                    {
//                        if(mLoopCounter == 1)
//                        {
//                            alert("Enter/Select Freight Matrix Details!");
//                            document.getElementById(mCtlForFRFrom + mLoopCounter).focus();
//                            return false;
//                        }    
//                    }
//                }
//            }
//            
//            //Check for Distinct Pair of Branch/City From & To
//            for(var mLoopCounter = 1 ; mLoopCounter <= 1; mLoopCounter++)
//            {
//                var mVarBranchCityFrom = (BranchCity != "Zone" ? document.getElementById(mCtlForFRFrom + mLoopCounter).value : document.getElementById(mCtlForFRFromZone + mLoopCounter).value);
//                var mVarBranchCityTo = (BranchCity != "Zone" ? document.getElementById(mCtlForFRTo + mLoopCounter).value : document.getElementById(mCtlForFRToZone + mLoopCounter).value);
//                
//                if(mVarBranchCityFrom != "" && mVarBranchCityTo != "")
//                {
//                    if(CheckDuplicateBranchCity(mVarBranchCityFrom, mVarBranchCityTo, mLoopCounter, MOT, BranchCity) == true)
//                    {
//                        alert("Please select/enter distinct '" + BranchCity + " From' & '" + BranchCity + " To'!");
//                        if(BranchCity != "Zone")
//                        {
//                            document.getElementById(mCtlForFRFrom + mLoopCounter).focus();
//                        }
//                        else
//                        {
//                            document.getElementById(mCtlForFRFromZone + mLoopCounter).focus();
//                        }
//                        return false;
//                    }
//                }
//            }
//            
//            if(BranchCity == "Branch")
//            {
//                if(document.getElementById("ctl00_MyCPH1_HidBM" + MOT))
//                {
//                    document.getElementById("ctl00_MyCPH1_HidBM" + MOT).value = mVarBM;
//                }
//                else
//                {
//                    alert("Hidden variable not found for storing " + BranchCity + " Matrix details for " + MOT + "!");
//                    return false;
//                }
//            }
//            else if(BranchCity == "City")
//            {
//                if(document.getElementById("ctl00_MyCPH1_HidCM" + MOT))
//                {
//                    document.getElementById("ctl00_MyCPH1_HidCM" + MOT).value = mVarBM;
//                }
//                else
//                {
//                    alert("Hidden variable not found for storing " + BranchCity + " Matrix details for " + MOT + "!");
//                    return false;
//                }
//            }
//            else if(BranchCity == "Zone")
//            {
//                if(document.getElementById("ctl00_MyCPH1_HidZM" + MOT))
//                {
//                    document.getElementById("ctl00_MyCPH1_HidZM" + MOT).value = mVarBM;
//                }
//                else
//                {
//                    alert("Hidden variable not found for storing " + BranchCity + " Matrix details for " + MOT + "!");
//                    return false;
//                }
//            }
//            
//            return true;
//        }
        
        function CheckBranchCityMatrix(MOT, BranchCity)
        {
            var mCtlForFRFrom = "ctl00_MyCPH1_txtFromFor" + MOT + "For" + BranchCity;
            var mCtlForFRFromErrorLabel = "ctl00_MyCPH1_lblFromFor" + MOT + "For" + BranchCity;
            var mCtlForFRTo = "ctl00_MyCPH1_txtToFor" + MOT + "For" + BranchCity;
            var mCtlForFRToErrorLabel = "ctl00_MyCPH1_lblToFor" + MOT + "For" + BranchCity;
            var mCtlForTrDays = "ctl00_MyCPH1_txtTrDaysFor" + MOT + "For" + BranchCity;
            var mCtlForRateType = "ctl00_MyCPH1_ddlRateTypeFor" + MOT + BranchCity;
            var mCtlForSlab1 = "ctl00_MyCPH1_txtSlab1For" + MOT + BranchCity;
            var mCtlForSlab2 = "ctl00_MyCPH1_txtSlab2For" + MOT + BranchCity;
            var mCtlForSlab3 = "ctl00_MyCPH1_txtSlab3For" + MOT + BranchCity;
            var mCtlForSlab4 = "ctl00_MyCPH1_txtSlab4For" + MOT + BranchCity;
            var mCtlForSlab5 = "ctl00_MyCPH1_txtSlab5For" + MOT + BranchCity;
            var mCtlForSlab6 = "ctl00_MyCPH1_txtSlab6For" + MOT + BranchCity;
            var mCtlForFRFromZone = "ctl00_MyCPH1_ddlZone" + MOT + "FromForRow";
            var mCtlForFRToZone = "ctl00_MyCPH1_ddlZone" + MOT + "ToForRow";
            
            var mVarBM = "";
            var mVarBMTemp = "";
            
            var mVarBranchCityFrom = "";
            var mVarZoneFrom = "";
            var mVarBranchCityTo = "";
            var mVarZoneTo = "";
            var mTrDays = "";
            var mRateType = "";
            var mSlab1 = "";
            var mSlab2 = "";
            var mSlab3 = "";
            var mSlab4 = "";
            var mSlab5 = "";
            var mSlab6 = "";
            
            //Check for Branch/City Matrix
            for(var mLoopCounter = 1 ; mLoopCounter <= 1; mLoopCounter++)
            {
                mVarBranchCityFrom = "";
                mVarZoneFrom = "";
                mVarBranchCityTo = "";
                mVarZoneTo = "";
                mTrDays = "";
                mRateType = "";
                mSlab1 = "";
                mSlab2 = "";
                mSlab3 = "";
                mSlab4 = "";
                mSlab5 = "";
                mSlab6 = "";
            
                if( ( BranchCity != "Zone" && document.getElementById(mCtlForFRFrom + mLoopCounter) && document.getElementById(mCtlForFRTo + mLoopCounter) ) ||  ( BranchCity == "Zone" && document.getElementById(mCtlForFRFromZone + mLoopCounter) && document.getElementById(mCtlForFRToZone + mLoopCounter) ))
                {
//                    var mFromValue = (BranchCity != "Zone" ? document.getElementById(mCtlForFRFrom + mLoopCounter).value : document.getElementById(mCtlForFRFromZone + mLoopCounter).value);
//                    var mToValue = (BranchCity != "Zone" ? document.getElementById(mCtlForFRTo + mLoopCounter).value : document.getElementById(mCtlForFRToZone + mLoopCounter).value);
                    var mDataExists = 0;
                    
                    if( ( BranchCity != "Zone" && document.getElementById(mCtlForFRFrom + mLoopCounter).value != "" && document.getElementById(mCtlForFRTo + mLoopCounter).value != "" ) ||  ( BranchCity == "Zone" && document.getElementById(mCtlForFRFromZone + mLoopCounter).value != "-1" && document.getElementById(mCtlForFRToZone + mLoopCounter).value != "-1" ))
                    {
                        mDataExists = 1;
                    }
                    //if((document.getElementById(mCtlForFRFrom + mLoopCounter).value != "" || document.getElementById(mCtlForFRFrom + mLoopCounter).value != "-1") && (document.getElementById(mCtlForFRTo + mLoopCounter).value != "" || document.getElementById(mCtlForFRTo + mLoopCounter).value != "-1"))
                    if(mDataExists == 1)
                    {   
                        //Check for Branch From for Mode of Transport 
                        if(BranchCity == "Zone")
                        {
                            if(document.getElementById(mCtlForFRFromZone + mLoopCounter))
                            {
                                if(document.getElementById(mCtlForFRFromZone + mLoopCounter).value != "-1")
                                {
                                    //mVarBMTemp = document.getElementById(mCtlForFRFromZone + mLoopCounter).value;
                                    mVarZoneFrom = document.getElementById(mCtlForFRFromZone + mLoopCounter).value;
                                }
                                else
                                {
//                                    alert("Select Zone From for " + MOT);
//                                    document.getElementById(mCtlForFRFromZone + mLoopCounter).focus();
//                                    return false;
                                }
                            }
                    
                            //Check for Branch/City To for Mode of Transport
                            if(document.getElementById(mCtlForFRToZone + mLoopCounter))
                            {
                                if(document.getElementById(mCtlForFRToZone + mLoopCounter).value != "-1")
                                {
                                    //mVarBMTemp += "," + document.getElementById(mCtlForFRToZone + mLoopCounter).value;
                                    mVarZoneTo = document.getElementById(mCtlForFRToZone + mLoopCounter).value;
                                }
                                else
                                {
//                                    alert("Select Zone To for " + MOT);
//                                    document.getElementById(mCtlForFRToZone + mLoopCounter).focus();
//                                    return false;
                                }
                            }
                        }
                        else
                        {
                            if(document.getElementById(mCtlForFRFrom + mLoopCounter))
                            {
                                if(document.getElementById(mCtlForFRFrom + mLoopCounter).value != "")
                                {
                                    if(document.getElementById(mCtlForFRFromErrorLabel + mLoopCounter))
                                    {
                                        if(document.getElementById(mCtlForFRFromErrorLabel + mLoopCounter).style.display == '')
                                        {
                                            alert("Invalid '" + BranchCity + " Code/Name' for " + MOT);
                                            document.getElementById(mCtlForFRFrom + mLoopCounter).focus();
                                            return false;
                                        }
                                    }
                                    //mVarBMTemp = document.getElementById(mCtlForFRFrom + mLoopCounter).value;
                                    mVarBranchCityFrom = document.getElementById(mCtlForFRFrom + mLoopCounter).value;
                                }
                                else
                                {
//                                    alert("Enter/Select '" + BranchCity + " Code' for " + MOT);
//                                    document.getElementById(mCtlForFRFrom + mLoopCounter).focus();
//                                    return false;
                                }
                            }
                            
                            //Check for Branch/City To for Mode of Transport
                            if(document.getElementById(mCtlForFRTo + mLoopCounter))
                            {
                                if(document.getElementById(mCtlForFRTo + mLoopCounter).value != "")
                                {
                                    if(document.getElementById(mCtlForFRToErrorLabel + mLoopCounter))
                                    {
                                        if(document.getElementById(mCtlForFRToErrorLabel + mLoopCounter).style.display == '')
                                        {
                                            alert("Invalid '" + BranchCity + " Code/Name' for " + MOT);
                                            document.getElementById(mCtlForFRTo + mLoopCounter).focus();
                                            return false;
                                        }
                                    }
                                    //mVarBMTemp += "," + document.getElementById(mCtlForFRTo + mLoopCounter).value;
                                    mVarBranchCityTo = document.getElementById(mCtlForFRTo + mLoopCounter).value;
                                }
                                else
                                {
//                                    alert("Enter/Select '" + BranchCity + " Code' for " + MOT);
//                                    document.getElementById(mCtlForFRTo + mLoopCounter).focus();
//                                    return false;
                                }
                            }
                        }
                        
                        //Check for Transit Days for Mode of Transport Branch/City/Zone
                        if(document.getElementById(mCtlForTrDays + mLoopCounter))
                        {
                            if(document.getElementById(mCtlForTrDays + mLoopCounter).value == "")
                            {
//                                alert("Enter 'Transit Days' for '" + MOT + "' For '" + BranchCity + "'");
//                                document.getElementById(mCtlForTrDays + mLoopCounter).focus();
//                                return false;
                            }
                            else
                            {
                                //mVarBMTemp += "," + document.getElementById(mCtlForTrDays + mLoopCounter).value;
                                mTrDays = document.getElementById(mCtlForTrDays + mLoopCounter).value;
                            }
                        }
                                    
                        //Check for Rate Type for Mode of Transport for Branch/Zone/City
                        if(document.getElementById(mCtlForRateType + mLoopCounter))
                        {
                            if(document.getElementById(mCtlForRateType + mLoopCounter).value == "-1")
                            {
//                                alert("Select 'Rate Type' from the list");
//                                document.getElementById(mCtlForRateType + mLoopCounter).focus();
//                                return false;
                            }
                            else
                            {
                                //mVarBMTemp += "," + document.getElementById(mCtlForRateType + mLoopCounter).value;
                                mRateType = document.getElementById(mCtlForRateType + mLoopCounter).value;
                            }
                        }
                        
                        //Check for Slab 1 for Mode of Transport for Branch/Zone/City
                        if(document.getElementById(mCtlForSlab1 + mLoopCounter))
                        {
                            if(document.getElementById(mCtlForSlab1 + mLoopCounter).value == "")
                            {
//                                alert("Enter 'Slab 1' from the list");
//                                document.getElementById(mCtlForSlab1 + mLoopCounter).focus();
//                                return false;
                            }
                            else
                            {
                                //mVarBMTemp += "," + document.getElementById(mCtlForSlab1 + mLoopCounter).value;
                                mSlab1 = document.getElementById(mCtlForSlab1 + mLoopCounter).value;
                            }
                        }
                        
                        //Check for Slab 2 for Mode of Transport for Branch/Zone/City
                        if(document.getElementById(mCtlForSlab2 + mLoopCounter))
                        {
                            if(document.getElementById(mCtlForSlab2 + mLoopCounter).value == "")
                            {
                                //mVarBMTemp += ",";
                            }
                            else
                            {
                                //mVarBMTemp += "," + document.getElementById(mCtlForSlab2 + mLoopCounter).value;
                                mSlab2 = document.getElementById(mCtlForSlab2 + mLoopCounter).value;
                            }
                        }
                        
                        //Check for Slab 3 for Mode of Transport for Branch/Zone/City
                        if(document.getElementById(mCtlForSlab3 + mLoopCounter))
                        {
                            if(document.getElementById(mCtlForSlab3 + mLoopCounter).value == "")
                            {
                                //mVarBMTemp += ",";
                            }
                            else
                            {
                                //mVarBMTemp += "," + document.getElementById(mCtlForSlab3 + mLoopCounter).value;
                                mSlab3 = document.getElementById(mCtlForSlab3 + mLoopCounter).value;
                            }
                        }
                        
                        //Check for Slab 4 for Mode of Transport for Branch/Zone/City
                        if(document.getElementById(mCtlForSlab4 + mLoopCounter))
                        {
                            if(document.getElementById(mCtlForSlab4 + mLoopCounter).value == "")
                            {
                                //mVarBMTemp += ",";
                            }
                            else
                            {
                                //mVarBMTemp += "," + document.getElementById(mCtlForSlab4 + mLoopCounter).value;
                                mSlab4 = document.getElementById(mCtlForSlab4 + mLoopCounter).value;
                            }
                        }
                        
                        //Check for Slab 5 for Mode of Transport for Branch/Zone/City
                        if(document.getElementById(mCtlForSlab5 + mLoopCounter))
                        {
                            if(document.getElementById(mCtlForSlab5 + mLoopCounter).value == "")
                            {
                                //mVarBMTemp += ",";
                            }
                            else
                            {
                                //mVarBMTemp += "," + document.getElementById(mCtlForSlab5 + mLoopCounter).value;
                                mSlab5 = document.getElementById(mCtlForSlab5 + mLoopCounter).value;
                            }
                        }
                        
                        //Check for Slab 6 for Mode of Transport for Branch/Zone/City
                        if(document.getElementById(mCtlForSlab6 + mLoopCounter))
                        {
                            if(document.getElementById(mCtlForSlab6 + mLoopCounter).value == "")
                            {
                                //mVarBMTemp += ",";
                            }
                            else
                            {
                                //mVarBMTemp += "," + document.getElementById(mCtlForSlab6 + mLoopCounter).value;
                                mSlab6 = document.getElementById(mCtlForSlab6 + mLoopCounter).value;
                            }
                        }
                        
                        if(mVarBranchCityFrom == "" && mVarZoneFrom == "" && mVarBranchCityTo == "" && mVarZoneTo == "" && mTrDays == "" && mRateType == "" && mSlab1 == "" && mSlab2 == "" && mSlab3 == "" && mSlab4 == "" && mSlab5 == "" && mSlab6 == "")
                        {
                            mVarBMTemp = "";
                        }
                        else
                        {
                            if(BranchCity != "Zone")
                            {
                                if(mVarBranchCityFrom != "" && mVarBranchCityTo == "")
                                {
                                    alert("Enter " + BranchCity + " To Code/Name For " + MOT + "!");
                                    document.getElementById(mCtlForFRTo + mLoopCounter).focus();
                                    return false;
                                }
                                else if(mVarBranchCityFrom == "" && mVarBranchCityTo != "")
                                {
                                    alert("Enter " + BranchCity + " From Code/Name For " + MOT + "!");
                                    document.getElementById(mCtlForFRFrom + mLoopCounter).focus();
                                    return false;
                                }
                                else if(mVarBranchCityFrom != "" && mVarBranchCityTo != "")
                                {
                                    if(mTrDays == "" || mRateType == "" || mSlab1 == "")
                                    {
                                        alert("Enter either Transit Days or Select Rate Type or Enter Slab 1 For " + BranchCity + " For " + MOT + "!");
                                        document.getElementById(mCtlForTrDays + mLoopCounter).focus();
                                        return false;
                                    }
                                }
                                else if(mVarBranchCityFrom == "" && mVarBranchCityTo == "")
                                {
                                    if(mTrDays != "" || mRateType != "" || mSlab1 != "" || mSlab2 != "" || mSlab3 != "" || mSlab4 != "" || mSlab5 != "" || mSlab6 != "")
                                    {
                                        alert("Enter " + BranchCity + " From & To For " + MOT + "!");
                                        document.getElementById(mCtlForFRFrom + mLoopCounter).focus();
                                        return false;
                                    }
                                }
                            }
                            else if(BranchCity == "Zone")
                            {
                                if(mVarZoneFrom != "" && mVarZoneTo == "")
                                {
                                    alert("Select " + BranchCity + " To For " + MOT + "!");
                                    document.getElementById(mCtlForFRToZone + mLoopCounter).focus();
                                    return false;
                                }
                                else if(mVarZoneFrom == "" && mVarZoneTo != "")
                                {
                                    alert("Select " + BranchCity + " From For " + MOT + "!");
                                    document.getElementById(mCtlForFRFromZone + mLoopCounter).focus();
                                    return false;
                                }
                                else if(mVarZoneFrom != "" && mVarZoneTo != "")
                                {
                                    if(mTrDays == "" || mRateType == "" || mSlab1 == "")
                                    {
                                        alert("Enter either Transit Days or Select Rate Type or Enter Slab 1 For " + BranchCity + " For " + MOT + "!");
                                        document.getElementById(mCtlForTrDays + mLoopCounter).focus();
                                        return false;
                                    }
                                }
                                else if(mVarZoneFrom == "" && mVarZoneTo == "")
                                {
                                    if(mTrDays != "" || mRateType != "" || mSlab1 != "" || mSlab2 != "" || mSlab3 != "" || mSlab4 != "" || mSlab5 != "" || mSlab6 != "")
                                    {
                                        alert("Select " + BranchCity + " From & To For " + MOT + "!");
                                        document.getElementById(mCtlForFRFromZone + mLoopCounter).focus();
                                        return false;
                                    }
                                }    
                            }
                            
                            mVarBMTemp = (BranchCity == "Zone" ? mVarZoneFrom : mVarBranchCityFrom) + "," + (BranchCity == "Zone" ? mVarZoneTo : mVarBranchCityTo) + "," + mTrDays + "," + mRateType + "," + mSlab1 + "," + (mSlab2 == "" ? "0" : mSlab2) + "," + (mSlab3 == "" ? "0" : mSlab3) + "," + (mSlab4 == "" ? "0" : mSlab4) + "," + (mSlab5 == "" ? "0" : mSlab5) + "," + (mSlab6 == "" ? "0" : mSlab6);         
                        }
                        
                        if(mVarBMTemp != "")
                        {
                            mVarBM = (mVarBM == "" ? mVarBMTemp : mVarBM + "~" + mVarBMTemp);
                            mVarBMTemp = "";
                        }
                    }
                    else
                    {
                        if(mLoopCounter == 1)
                        {
//                            alert("Enter/Select Freight Matrix Details!");
//                            document.getElementById(mCtlForFRFrom + mLoopCounter).focus();
//                            return false;
                        }    
                    }
                }
            }
            
            //Check for Distinct Pair of Branch/City From & To
            for(var mLoopCounter = 1 ; mLoopCounter <= 1; mLoopCounter++)
            {
                var mVarBranchCityFrom = (BranchCity != "Zone" ? document.getElementById(mCtlForFRFrom + mLoopCounter).value : document.getElementById(mCtlForFRFromZone + mLoopCounter).value);
                var mVarBranchCityTo = (BranchCity != "Zone" ? document.getElementById(mCtlForFRTo + mLoopCounter).value : document.getElementById(mCtlForFRToZone + mLoopCounter).value);
                
                if(mVarBranchCityFrom != "" && mVarBranchCityTo != "")
                {
                    if(CheckDuplicateBranchCity(mVarBranchCityFrom, mVarBranchCityTo, mLoopCounter, MOT, BranchCity) == true)
                    {
                        alert("Please select/enter distinct '" + BranchCity + " From' & '" + BranchCity + " To'!");
                        if(BranchCity != "Zone")
                        {
                            document.getElementById(mCtlForFRFrom + mLoopCounter).focus();
                        }
                        else
                        {
                            document.getElementById(mCtlForFRFromZone + mLoopCounter).focus();
                        }
                        return false;
                    }
                }
            }
            
            if(BranchCity == "Branch")
            {
                if(document.getElementById("ctl00_MyCPH1_HidBM" + MOT))
                {
                    document.getElementById("ctl00_MyCPH1_HidBM" + MOT).value = mVarBM;
                }
                else
                {
                    alert("Hidden variable not found for storing " + BranchCity + " Matrix details for " + MOT + "!");
                    return false;
                }
            }
            else if(BranchCity == "City")
            {
                if(document.getElementById("ctl00_MyCPH1_HidCM" + MOT))
                {
                    document.getElementById("ctl00_MyCPH1_HidCM" + MOT).value = mVarBM;
                }
                else
                {
                    alert("Hidden variable not found for storing " + BranchCity + " Matrix details for " + MOT + "!");
                    return false;
                }
            }
            else if(BranchCity == "Zone")
            {
                if(document.getElementById("ctl00_MyCPH1_HidZM" + MOT))
                {
                    document.getElementById("ctl00_MyCPH1_HidZM" + MOT).value = mVarBM;
                }
                else
                {
                    alert("Hidden variable not found for storing " + BranchCity + " Matrix details for " + MOT + "!");
                    return false;
                }
            }
            
            return true;
        }
        
//        function CheckBranchCityBasicDetails(MOT, BranchCity)
//        {
//            //Check for Branch Matrix for Road
//            if(document.getElementById("ctl00_MyCPH1_trFor" + MOT + "For" + BranchCity))
//            {
//                if(document.getElementById("ctl00_MyCPH1_trFor" + MOT + "For" + BranchCity).style.display == '')
//                {   
//                    //Check for Branch Code for Road
//                    if(document.getElementById("ctl00_MyCPH1_txt" + BranchCity + "Code" + MOT))
//                    {
//                        if(document.getElementById("ctl00_MyCPH1_txt" + BranchCity + "Code" + MOT).value != "")
//                        {
//                            if(document.getElementById("ctl00_MyCPH1_lblError" + BranchCity + "Code" + MOT))
//                            {
//                                if(document.getElementById("ctl00_MyCPH1_lblError" + BranchCity + "Code" + MOT).style.display == '')
//                                {
//                                    alert("Invalid 'Branch Code' for " + MOT);
//                                    document.getElementById("ctl00_MyCPH1_txt" + BranchCity + "Code" + MOT).focus();
//                                    return false;
//                                }
//                            }
//                        }
//                        else
//                        {
//                            alert("Enter/Select '" + BranchCity + " Code' for " + MOT);
//                            document.getElementById("ctl00_MyCPH1_txt" + BranchCity + "Code" + MOT).focus();
//                            return false;
//                        }
//                    }
//                    else
//                    {
//                        alert("Enter/Select '" + BranchCity + " Code' for " + MOT);
//                        return false;
//                    }
//                    
//                    if(CheckBranchCityMatrix(MOT, BranchCity) == false)
//                    {
//                        return false;
//                    }
//                }
//            }
//        }
        
        function CheckBranchCityBasicDetails(MOT, BranchCity)
        {
            //Check for Branch Matrix for Road
            if(document.getElementById("ctl00_MyCPH1_trFor" + MOT + "For" + BranchCity))
            {
                if(document.getElementById("ctl00_MyCPH1_trFor" + MOT + "For" + BranchCity).style.display == '')
                {   
                    //Check for Branch Code for Road
                    if(document.getElementById("ctl00_MyCPH1_txt" + BranchCity + "Code" + MOT))
                    {
                        if(document.getElementById("ctl00_MyCPH1_txt" + BranchCity + "Code" + MOT).value != "")
                        {
                            if(document.getElementById("ctl00_MyCPH1_lblError" + BranchCity + "Code" + MOT))
                            {
                                if(document.getElementById("ctl00_MyCPH1_lblError" + BranchCity + "Code" + MOT).style.display == '')
                                {
                                    alert("Invalid '" + BranchCity + " Code/Name' for " + MOT);
                                    document.getElementById("ctl00_MyCPH1_txt" + BranchCity + "Code" + MOT).focus();
                                    return false;
                                }
                            }
                        }
                        else
                        {
//                            alert("Enter/Select '" + BranchCity + " Code' for " + MOT);
//                            document.getElementById("ctl00_MyCPH1_txt" + BranchCity + "Code" + MOT).focus();
//                            return false;
                        }
                    }
                    else
                    {
                        alert("Entry/Selection box for '" + BranchCity + " Code/Name' for " + MOT + " not available!");
                        return false;
                    }
                    
                    if(CheckBranchCityMatrix(MOT, BranchCity) == false)
                    {
                        return false;
                    }
                }
            }
        }
        
        function CheckZoneBasicDetails(MOT)
        {
            //Check for Zone Matrix for Mode of Transaction
            if(document.getElementById("ctl00_MyCPH1_trFor" + MOT + "ForZone"))
            {
                if(document.getElementById("ctl00_MyCPH1_trFor" + MOT + "ForZone").style.display == '')
                {   
                    //Check for Branch Code for Road
//                    if(document.getElementById("ctl00_MyCPH1_ddlZoneHeader" + MOT))
//                    {
//                        if(document.getElementById("ctl00_MyCPH1_ddlZoneHeader" + MOT).value == "-1")
//                        {
//                            alert("Select 'Zone' for " + MOT + " from the list!");
//                            document.getElementById("ctl00_MyCPH1_ddlZoneHeader" + MOT).focus();
//                            return false;
//                        }                        
//                    }
//                    else
//                    {
//                        alert("Zone selection list is not available for " + MOT);
//                        return false;
//                    }
                    
                    if(CheckBranchCityMatrix(MOT, "Zone") == false)
                    {
                        return false;
                    }
                }
            }
        }
        
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
//            //Check for atleast one From and To Slab entry
//            if(document.getElementById("ctl00_MyCPH1_txtFromSlab1"))
//            {
//                if(document.getElementById("ctl00_MyCPH1_txtFromSlab1").value == "")
//                {
//                    alert("Enter Value for 'Slab From' 1");
//                    document.getElementById("ctl00_MyCPH1_txtFromSlab1").focus();
//                    return false;
//                }
//            }
//            else
//            {
//                alert("Input Box for 'Slab From 1' is not available!");
//                return false;
//            }
//            
//            if(document.getElementById("ctl00_MyCPH1_txtToSlab1"))
//            {
//                if(document.getElementById("ctl00_MyCPH1_txtToSlab1").value == "")
//                {
//                    alert("Enter Value for 'Slab To' 1");
//                    document.getElementById("ctl00_MyCPH1_txtToSlab1").focus();
//                    return false;
//                }
//            }
//            else
//            {
//                alert("Input Box for 'Slab To 1' is not available!");
//                return false;
//            }
//        
//            if(CheckBranchCityBasicDetails("Road", "Branch") == false)
//            {
//                return false;
//            }
//            
//            if(CheckBranchCityBasicDetails("Express", "Branch") == false)
//            {
//                return false;
//            }
//            
//            if(CheckBranchCityBasicDetails("Air", "Branch") == false)
//            {
//                return false;
//            }
//            
//            if(CheckBranchCityBasicDetails("Train", "Branch") == false)
//            {
//                return false;
//            }
//            
//            if(CheckZoneBasicDetails("Road") == false)
//            {
//                return false;
//            }
//            
//            if(CheckZoneBasicDetails("Express") == false)
//            {
//                return false;
//            }
//            
//            if(CheckZoneBasicDetails("Air") == false)
//            {
//                return false;
//            }
//            
//            if(CheckZoneBasicDetails("Train") == false)
//            {
//                return false;
//            }
//            
//            if(CheckBranchCityBasicDetails("Road", "City") == false)
//            {
//                return false;
//            }
//            
//            if(CheckBranchCityBasicDetails("Express", "City") == false)
//            {
//                return false;
//            }
//            
//            if(CheckBranchCityBasicDetails("Air", "City") == false)
//            {
//                return false;
//            }
//            
//            if(CheckBranchCityBasicDetails("Train", "City") == false)
//            {
//                return false;
//            }
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
            
            //Check for atleast one From and To Slab entry
            if(document.getElementById("ctl00_MyCPH1_txtFromSlab1"))
            {
                if(document.getElementById("ctl00_MyCPH1_txtFromSlab1").value == "")
                {
                    alert("Enter Value for 'Slab From' 1");
                    document.getElementById("ctl00_MyCPH1_txtFromSlab1").focus();
                    return false;
                }
            }
            else
            {
                alert("Input Box for 'Slab From 1' is not available!");
                return false;
            }
            
            if(document.getElementById("ctl00_MyCPH1_txtToSlab1"))
            {
                if(document.getElementById("ctl00_MyCPH1_txtToSlab1").value == "")
                {
                    alert("Enter Value for 'Slab To' 1");
                    document.getElementById("ctl00_MyCPH1_txtToSlab1").focus();
                    return false;
                }
            }
            else
            {
                alert("Input Box for 'Slab To 1' is not available!");
                return false;
            }
            
            //Slab Range validation
            if(CheckSlabValues("ctl00_MyCPH1_txtFromSlab1", "ctl00_MyCPH1_txtToSlab1", "ctl00_MyCPH1_txtFromSlab2", "ctl00_MyCPH1_txtToSlab2", "ctl00_MyCPH1_txtFromSlab3", "ctl00_MyCPH1_txtToSlab3", "ctl00_MyCPH1_txtFromSlab4", "ctl00_MyCPH1_txtToSlab4", "ctl00_MyCPH1_txtFromSlab5", "ctl00_MyCPH1_txtToSlab5", "ctl00_MyCPH1_txtFromSlab6", "ctl00_MyCPH1_txtToSlab6") == false)
            {
                return false;    
            }
            
            if(CheckBranchCityBasicDetails("Road", "Branch") == false)
            {
                return false;
            }
            
            if(CheckBranchCityBasicDetails("Express", "Branch") == false)
            {
                return false;
            }
            
            if(CheckBranchCityBasicDetails("Air", "Branch") == false)
            {
                return false;
            }
            
            if(CheckBranchCityBasicDetails("Train", "Branch") == false)
            {
                return false;
            }
            
            if(CheckZoneBasicDetails("Road") == false)
            {
                return false;
            }
            
            if(CheckZoneBasicDetails("Express") == false)
            {
                return false;
            }
            
            if(CheckZoneBasicDetails("Air") == false)
            {
                return false;
            }
            
            if(CheckZoneBasicDetails("Train") == false)
            {
                return false;
            }
            
            if(CheckBranchCityBasicDetails("Road", "City") == false)
            {
                return false;
            }
            
            if(CheckBranchCityBasicDetails("Express", "City") == false)
            {
                return false;
            }
            
            if(CheckBranchCityBasicDetails("Air", "City") == false)
            {
                return false;
            }
            
            if(CheckBranchCityBasicDetails("Train", "City") == false)
            {
                return false;
            }
            
            var mBMRoad = "";
            var mCMRoad = "";
            var mZMRoad = "";
            
            var mBMExpress = "";
            var mCMExpress = "";
            var mZMExpress = "";
            
            var mBMTrain = "";
            var mCMTrain = "";
            var mZMTrain = "";
            
            var mBMAir = "";
            var mCMAir = "";
            var mZMAir = "";
            
            if(document.getElementById("ctl00_MyCPH1_HidBMRoad"))
            {
                mBMRoad = document.getElementById("ctl00_MyCPH1_HidBMRoad").value;
            }
            
            if(document.getElementById("ctl00_MyCPH1_HidCMRoad"))
            {
                mCMRoad = document.getElementById("ctl00_MyCPH1_HidCMRoad").value;
            }
            
            if(document.getElementById("ctl00_MyCPH1_HidZMRoad"))
            {
                mZMRoad = document.getElementById("ctl00_MyCPH1_HidZMRoad").value;
            }
            
            if(document.getElementById("ctl00_MyCPH1_HidBMExpress"))
            {
                mBMExpress = document.getElementById("ctl00_MyCPH1_HidBMExpress").value;
            }
            
            if(document.getElementById("ctl00_MyCPH1_HidCMExpress"))
            {
                mCMExpress = document.getElementById("ctl00_MyCPH1_HidCMExpress").value;
            }
            
            if(document.getElementById("ctl00_MyCPH1_HidZMExpress"))
            {
                mZMExpress = document.getElementById("ctl00_MyCPH1_HidZMExpress").value;
            }
            
            if(document.getElementById("ctl00_MyCPH1_HidBMTrain"))
            {
                mBMTrain = document.getElementById("ctl00_MyCPH1_HidBMTrain").value;
            }
            
            if(document.getElementById("ctl00_MyCPH1_HidCMTrain"))
            {
                mCMTrain = document.getElementById("ctl00_MyCPH1_HidCMTrain").value;
            }
            
            if(document.getElementById("ctl00_MyCPH1_HidZMTrain"))
            {
                mZMTrain = document.getElementById("ctl00_MyCPH1_HidZMTrain").value;
            }
            
            if(document.getElementById("ctl00_MyCPH1_HidBMAir"))
            {
                mBMAir = document.getElementById("ctl00_MyCPH1_HidBMAir").value;
            }
            
            if(document.getElementById("ctl00_MyCPH1_HidCMAir"))
            {
                mCMAir = document.getElementById("ctl00_MyCPH1_HidCMAir").value;
            }
            
            if(document.getElementById("ctl00_MyCPH1_HidZMAir"))
            {
                mZMAir = document.getElementById("ctl00_MyCPH1_HidZMAir").value;
            }
            
            if(mBMRoad == "" && mCMRoad == "" && mZMRoad == "" && mBMExpress == "" && mCMExpress == "" && mZMExpress == "" && mBMTrain == "" && mCMTrain == "" && mZMTrain == "" && mBMAir == "" && mCMAir == "" && mZMAir == "")
            {
                alert("Enter/Select Either Branch or Zone or City details!");
                return false;
            }
        }
            
        function CheckDuplicateBranchCity(BranchCityFrom, BranchCityTo, BranchCityRow, MOT, BranchCity)
        {
            var mVarControlForBranchCityFrom;
            var mVarControlForBranchCityTo;
            
            //Check for Branch/City Matrix
            for(var mLoopCounter = 1 ; mLoopCounter <= 1; mLoopCounter++)
            {
                if(mLoopCounter != BranchCityRow)
                {
                    //Create control ID's
                    if(BranchCity != "Zone")
                    {
                        mVarControlForBranchCityFrom = "ctl00_MyCPH1_txtFRFrom" + MOT + "For" + BranchCity + mLoopCounter;
                        mVarControlForBranchCityTo = "ctl00_MyCPH1_txtFRTo" + MOT + "For" + BranchCity + mLoopCounter;
                    }
                    else
                    {
                        mVarControlForBranchCityFrom = "ctl00_MyCPH1_ddlZone" + MOT + "FromForRow" + mLoopCounter;
                        mVarControlForBranchCityTo = "ctl00_MyCPH1_ddlZone" + MOT + "ToForRow" + mLoopCounter;
                    }
                    
                    //Check for Branch/City From & To Duplication
                    if(BranchCity != "Zone")
                    {
                        if(document.getElementById(mVarControlForBranchCityFrom) && document.getElementById(mVarControlForBranchCityTo))
                        {
                            if(document.getElementById(mVarControlForBranchCityFrom).value != "" && document.getElementById(mVarControlForBranchCityTo).value != "")
                            {
                                if(document.getElementById(mVarControlForBranchCityFrom).value == BranchCityFrom && document.getElementById(mVarControlForBranchCityTo).value == BranchCityTo)
                                {
                                    return true;
                                }
                            }
                        }
                    }
                    else
                    {
                        if(document.getElementById(mVarControlForBranchCityFrom) && document.getElementById(mVarControlForBranchCityTo))
                        {
                            if(document.getElementById(mVarControlForBranchCityFrom).value != "-1" && document.getElementById(mVarControlForBranchCityTo).value != "-1")
                            {
                                if(document.getElementById(mVarControlForBranchCityFrom).value == BranchCityFrom && document.getElementById(mVarControlForBranchCityTo).value == BranchCityTo)
                                {
                                    return true;
                                }
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
        <input type="hidden" id="HidTL" runat="server" />
        <input type="hidden" id="HidFTL" runat="server" />
                
        <input type="hidden" id="HidCustCode" runat="server" />
        <input type="hidden" id="HidCustCodeName" runat="server" />
        
        <input type="hidden" runat="server" id="HidRandomNo" />
        
        <input type="hidden" id="HidBMRoad" runat="server" />
        <input type="hidden" id="HidBMExpress" runat="server" />
        <input type="hidden" id="HidBMAir" runat="server" />
        <input type="hidden" id="HidBMTrain" runat="server" />
        <input type="hidden" id="HidZMExpress" runat="server" />
        <input type="hidden" id="HidZMAir" runat="server" />
        <input type="hidden" id="HidZMTrain" runat="server" />
        <input type="hidden" id="HidCMRoad" runat="server" />
        <input type="hidden" id="HidZMRoad" runat="server" />
        <input type="hidden" id="HidCMExpress" runat="server" />
        <input type="hidden" id="HidCMAir" runat="server" />
        <input type="hidden" id="HidCMTrain" runat="server" />
        <input type="hidden" id="HidSlab" runat="server" />
        
        <input type="hidden" id="HidMOTAir" runat="server" />
        <input type="hidden" id="HidMOTRoad" runat="server" />
        <input type="hidden" id="HidMOTTrain" runat="server" />
        <input type="hidden" id="HidMOTExpress" runat="server" />
        
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
			                                            
			                                            <table border="0" cellpadding="1" width="85%" cellspacing="1" align="center" class="boxbg">
			                                                <tr style="background-color: White">
			                                                    <td colspan="4" align="left">
			                                                        <label class="blackfnt">
			                                                            <b>
			                                                                <u>
			                                                                    STEP 3B: Freight Matrix - Multi Slab Detailed Contract
			                                                                </u>
			                                                            </b>
			                                                        </label>
			                                                    </td>    
			                                                </tr>
				                                            
				                                            <tr style="background-color: White">
				                                                <td align="center" colspan="4">
				                                                    <br style="font-size: 6pt;" />
				                                                    <table border="0" cellpadding="0" width="100%" cellspacing="1" align="center" class="boxbg">
				                                                        <tr style="background-color: White">
							                                                <td align="right" style="height: 24px">
							                                                    <label class="blackfnt">
							                                                        Select Rate Type:&nbsp;
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="left" style="height: 24px">
							                                                    <label style="margin-left: 5px;">
	                                                                            </label>
							                                                    <asp:DropDownList ID="ddlRateType" runat="server" CssClass="blackfnt">
							                                                        <asp:ListItem Selected="True" Value="-1" Text="Select"></asp:ListItem>
							                                                        <asp:ListItem Value="W" Text="Per Kg."></asp:ListItem>
							                                                        <asp:ListItem Value="P" Text="Per Package"></asp:ListItem>
							                                                        <asp:ListItem Value="B" Text="Both"></asp:ListItem>
							                                                    </asp:DropDownList>
							                                                </td>
						                                                </tr>
				                                                    </table>
				                                                </td>				                                                
			                                                </tr>
				                                            
				                                            <tr style="background-color: White">
				                                                <td align="center" colspan="4">
				                                                    <br style="font-size: 6pt;" />
				                                                    <table border="0" cellpadding="0" width="100%" cellspacing="1" align="center" class="boxbg">
				                                                        <tr style="background-color: White">
							                                                <td align="center" colspan="12">
							                                                    <label class="bluefnt">
							                                                        <b>
							                                                            Define Slab
							                                                        </b>
							                                                    </label>
							                                                </td>
							                                            </tr>
							                                            
							                                            <tr style="background-color: White">
							                                                <td align="center" colspan="2">
							                                                    <label class="blackfnt">
							                                                        Slab 1
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center" colspan="2">
							                                                    <label class="blackfnt">
							                                                        Slab 2
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center" colspan="2">
							                                                    <label class="blackfnt">
							                                                        Slab 3
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center" colspan="2">
							                                                    <label class="blackfnt">
							                                                        Slab 4
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center" colspan="2">
							                                                    <label class="blackfnt">
							                                                        Slab 5
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center" colspan="2">
							                                                    <label class="blackfnt">
							                                                        Slab 6
							                                                    </label>
							                                                </td>
							                                            </tr>
							                                            
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
							                                            </tr>
							                                            
							                                            <tr style="background-color: White">
							                                                <td align="center">
							                                                    <input id="txtFromSlab1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <input id="txtToSlab1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <input id="txtFromSlab2" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <input id="txtToSlab2" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <input id="txtFromSlab3" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <input id="txtToSlab3" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <input id="txtFromSlab4" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <input id="txtToSlab4" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <input id="txtFromSlab5" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <input id="txtToSlab5" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <input id="txtFromSlab6" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <input id="txtToSlab6" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
							                                                </td>
							                                            </tr>
				                                                    </table>
				                                                </td>				                                                
			                                                </tr>
				                                            
			                                                <%--trForRoadForBranch here--%>
			                                                <tr style="background-color: White" id="trForRoadForBranch" runat="server">
			                                                    <td colspan="4" align="left" style="height: 200" valign="top">
			                                                        <br style="font-size: 6pt;" />
						        									
						        									<center>
						        									    <label class="bluefnt">
						        									        <b>
						        									            <u>
						        									                Matrices for Road - Freight Rate - Branch Matrix
						        									            </u>
						        									        </b>
						        									    </label>
						        									</center>
						        									
						        									<br style="font-size: 6pt;" />
						        									
					                                                <table border="0" cellpadding="2" width="50%" cellspacing="1" align="center" class="boxbg">
							                                            <tr style="background-color: White">
							                                                <td align="right">
							                                                    <label class="blackfnt">
							                                                        Branch:&nbsp;
							                                                    </label>
							                                                </td>
							                                                
								                                            <td align="left">
								                                                <asp:UpdatePanel ID="upBranchCodeForRoad" runat="server">
								                                                    <ContentTemplate>
								                                                        <asp:TextBox ID="txtBranchCodeRoad" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtBranchCodeRoad_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="60px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
								                                                        <input type="button" value="..." runat="server" id="btnBranchCode" 
                                                                                            onclick="return BranchPopup('Branch_Popup.aspx?5')" />
                                                                                        <br />
                                                                                        <label class="blackfnt" id="lblErrorBranchCodeRoad" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>    
								                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtBranchCodeRoad" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
								                                            </td>
							                                            </tr>
							                                        </table>
							                                        
							                                        <br style="font-size: 6pt;"/>	
			                                                        
			                                                        <table border="0" cellpadding="2" width="50%" cellspacing="1" align="center" class="boxbg">
			                                                            <tr style="background-color: White">
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        From
							                                                    </label>
							                                                    &nbsp;
					                                                            <input type="button" value="..." runat="server" id="btnFromForRoadBranch" 
                                                                                    onclick="return BranchPopup('Branch_Popup_Multi_Selection.aspx?8')" />            
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        To
							                                                    </label>
							                                                    &nbsp;
					                                                            <input type="button" value="..." runat="server" id="btnToForRoadBranch" 
                                                                                    onclick="return BranchPopup('Branch_Popup_Multi_Selection.aspx?9')" />            
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Transit Days
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Rate Type
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 1
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 2
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 3
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 4
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 5
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 6
							                                                    </label>
							                                                </td>
							                                            </tr>
							                                            
					                                                    <tr runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFromForRoadForBranch1" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFromForRoadForBranch1" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFromForRoadForBranch1_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="60px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblFromForRoadForBranch1" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFromForRoadForBranch1" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upToForRoadForBranch1" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtToForRoadForBranch1" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtToForRoadForBranch1_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="60px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblToForRoadForBranch1" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtToForRoadForBranch1" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtTrDaysForRoadForBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <asp:DropDownList ID="ddlRateTypeForRoadBranch1" runat="server" CssClass="blackfnt">
						                                                            <asp:ListItem Selected="True" Value="-1" Text="Select"></asp:ListItem>
							                                                        <asp:ListItem Value="W" Text="Per Kg."></asp:ListItem>
							                                                        <asp:ListItem Value="P" Text="Per Package"></asp:ListItem>
						                                                        </asp:DropDownList>
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab1ForRoadBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab2ForRoadBranch1" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab3ForRoadBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab4ForRoadBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab5ForRoadBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab6ForRoadBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
							                                        </table>
		                                                        </td>
		                                                    </tr>
		                                                    
		                                                    <%--trForExpressForBranch here--%>
			                                                <tr style="background-color: White" id="trForExpressForBranch" runat="server">
			                                                    <td colspan="4" align="left" style="height: 200" valign="top">
			                                                        <br style="font-size: 6pt;" />
			                                                        
			                                                        <center>
						        									    <label class="bluefnt">
						        									        <b>
						        									            <u>
						        									                Matrices for Express - Freight Rate - Branch Matrix
						        									            </u>
						        									        </b>
						        									    </label>
						        									</center>
			                                                        
			                                                        <br style="font-size: 6pt;" />
						        									
					                                                <table border="0" cellpadding="2" width="50%" cellspacing="1" align="center" class="boxbg">
							                                            <tr style="background-color: White">
							                                                <td align="right">
							                                                    <label class="blackfnt">
							                                                        Branch:&nbsp;
							                                                    </label>
							                                                </td>
							                                                
								                                            <td align="left">
								                                                <asp:UpdatePanel ID="upBranchCodeExpress" runat="server">
								                                                    <ContentTemplate>
								                                                        <asp:TextBox ID="txtBranchCodeExpress" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtBranchCodeExpress_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="60px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
								                                                        <input type="button" value="..." runat="server" id="Button1" 
                                                                                            onclick="return BranchPopup('Branch_Popup.aspx?6')" />
                                                                                        <br />
                                                                                        <label class="blackfnt" id="lblErrorBranchCodeExpress" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>    
								                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtBranchCodeExpress" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
								                                            </td>
							                                            </tr>
							                                        </table>
							                                        
							                                        <br style="font-size: 6pt;"/>	
			
			                                                        <table border="0" cellpadding="2" width="50%" cellspacing="1" align="center" class="boxbg">
			                                                            <tr style="background-color: White">
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        From
							                                                    </label>
							                                                    &nbsp;
					                                                            <input type="button" value="..." runat="server" id="btnFromForExpressBranch" 
                                                                                    onclick="return BranchPopup('Branch_Popup_Multi_Selection.aspx?10')" />            
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        To
							                                                    </label>
							                                                    &nbsp;
					                                                            <input type="button" value="..." runat="server" id="btnToForExpressBranch" 
                                                                                    onclick="return BranchPopup('Branch_Popup_Multi_Selection.aspx?11')" />            
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Transit Days
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Rate Type
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 1
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 2
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 3
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 4
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 5
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 6
							                                                    </label>
							                                                </td>
							                                            </tr>
							                                            
					                                                    <tr runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFromForExpressForBranch1" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFromForExpressForBranch1" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFromForExpressForBranch1_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="60px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblFromForExpressForBranch1" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFromForExpressForBranch1" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upToForExpressForBranch1" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtToForExpressForBranch1" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtToForExpressForBranch1_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="60px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblToForExpressForBranch1" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtToForExpressForBranch1" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtTrDaysForExpressForBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <asp:DropDownList ID="ddlRateTypeForExpressBranch1" runat="server" CssClass="blackfnt">
						                                                            <asp:ListItem Selected="True" Value="-1" Text="Select"></asp:ListItem>
							                                                        <asp:ListItem Value="W" Text="Per Kg."></asp:ListItem>
							                                                        <asp:ListItem Value="P" Text="Per Package"></asp:ListItem>
						                                                        </asp:DropDownList>
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab1ForExpressBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab2ForExpressBranch1" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab3ForExpressBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab4ForExpressBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab5ForExpressBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab6ForExpressBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
							                                        </table>
		                                                        </td>
		                                                    </tr>
                                                            
                                                            <%--trForAirForBranch here--%>
			                                                <tr style="background-color: White" id="trForAirForBranch" runat="server">
			                                                    <td colspan="4" align="left" style="height: 200" valign="top">
			                                                        <br style="font-size: 6pt;" />
			                                                        
			                                                        <center>
						        									    <label class="bluefnt">
						        									        <b>
						        									            <u>
						        									                Matrices for Air - Freight Rate - Branch Matrix
						        									            </u>
						        									        </b>
						        									    </label>
						        									</center>
			                                                        
			                                                        <br style="font-size: 6pt;" />
						        									
					                                                <table border="0" cellpadding="2" width="50%" cellspacing="1" align="center" class="boxbg">
							                                            <tr style="background-color: White">
							                                                <td align="right">
							                                                    <label class="blackfnt">
							                                                        Branch:&nbsp;
							                                                    </label>
							                                                </td>
							                                                
								                                            <td align="left">
								                                                <asp:UpdatePanel ID="upBranchCodeAir" runat="server">
								                                                    <ContentTemplate>
								                                                        <asp:TextBox ID="txtBranchCodeAir" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtBranchCodeAir_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="60px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
								                                                        <input type="button" value="..." runat="server" id="Button2" 
                                                                                            onclick="return BranchPopup('Branch_Popup.aspx?7')" />
                                                                                        <br />
                                                                                        <label class="blackfnt" id="lblErrorBranchCodeAir" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>    
								                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtBranchCodeAir" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
								                                            </td>
							                                            </tr>
							                                        </table>
							                                        
							                                        <br style="font-size: 6pt;"/>	
			
			                                                        <table border="0" cellpadding="2" width="50%" cellspacing="1" align="center" class="boxbg">
			                                                            <tr style="background-color: White">
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        From
							                                                    </label>
							                                                    &nbsp;
					                                                            <input type="button" value="..." runat="server" id="btnFromForAirBranch" 
                                                                                    onclick="return BranchPopup('Branch_Popup_Multi_Selection.aspx?12')" />            
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        To
							                                                    </label>
							                                                    &nbsp;
					                                                            <input type="button" value="..." runat="server" id="btnToForAirBranch" 
                                                                                    onclick="return BranchPopup('Branch_Popup_Multi_Selection.aspx?13')" />           
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Transit Days
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Rate Type
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 1
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 2
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 3
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 4
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 5
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 6
							                                                    </label>
							                                                </td>
							                                            </tr>
							                                            
					                                                    <tr id="Tr1" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFromForAirForBranch1" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFromForAirForBranch1" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFromForAirForBranch1_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="60px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblFromForAirForBranch1" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFromForAirForBranch1" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upToForAirForBranch1" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtToForAirForBranch1" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtToForAirForBranch1_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="60px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblToForAirForBranch1" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtToForAirForBranch1" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtTrDaysForAirForBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <asp:DropDownList ID="ddlRateTypeForAirBranch1" runat="server" CssClass="blackfnt">
						                                                            <asp:ListItem Selected="True" Value="-1" Text="Select"></asp:ListItem>
							                                                        <asp:ListItem Value="W" Text="Per Kg."></asp:ListItem>
							                                                        <asp:ListItem Value="P" Text="Per Package"></asp:ListItem>
						                                                        </asp:DropDownList>
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab1ForAirBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab2ForAirBranch1" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab3ForAirBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab4ForAirBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab5ForAirBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab6ForAirBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
							                                        </table>
		                                                        </td>
		                                                    </tr>
		                                                    
		                                                    <%--trForTrainForBranch here--%>
			                                                <tr style="background-color: White" id="trForTrainForBranch" runat="server">
			                                                    <td colspan="4" align="left" style="height: 200" valign="top">
			                                                        <br style="font-size: 6pt;" />
			                                                        
			                                                        <center>
						        									    <label class="bluefnt">
						        									        <b>
						        									            <u>
						        									                Matrices for Train - Freight Rate - Branch Matrix
						        									            </u>
						        									        </b>
						        									    </label>
						        									</center>
			                                                        
			                                                        <br style="font-size: 6pt;" />
						        									
					                                                <table border="0" cellpadding="2" width="50%" cellspacing="1" align="center" class="boxbg">
							                                            <tr style="background-color: White">
							                                                <td align="right">
							                                                    <label class="blackfnt">
							                                                        Branch:&nbsp;
							                                                    </label>
							                                                </td>
							                                                
								                                            <td align="left">
								                                                <asp:UpdatePanel ID="upBranchCodeTrain" runat="server">
								                                                    <ContentTemplate>
								                                                        <asp:TextBox ID="txtBranchCodeTrain" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtBranchCodeTrain_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="60px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
								                                                        <input type="button" value="..." runat="server" id="Button3" 
                                                                                            onclick="return BranchPopup('Branch_Popup.aspx?8')" />
                                                                                        <br />
                                                                                        <label class="blackfnt" id="lblErrorBranchCodeTrain" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>    
								                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtBranchCodeTrain" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
								                                            </td>
							                                            </tr>
							                                        </table>
							                                        
							                                        <br style="font-size: 6pt;"/>	
			
			                                                        <table border="0" cellpadding="2" width="50%" cellspacing="1" align="center" class="boxbg">
			                                                            <tr style="background-color: White">
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        From
							                                                    </label>
							                                                    &nbsp;
					                                                            <input type="button" value="..." runat="server" id="btnFromForTrainBranch" 
                                                                                    onclick="return BranchPopup('Branch_Popup_Multi_Selection.aspx?14')" />            
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        To
							                                                    </label>
							                                                    &nbsp;
					                                                            <input type="button" value="..." runat="server" id="btnToForTrainBranch" 
                                                                                    onclick="return BranchPopup('Branch_Popup_Multi_Selection.aspx?15')" />            
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Transit Days
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Rate Type
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 1
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 2
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 3
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 4
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 5
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 6
							                                                    </label>
							                                                </td>
							                                            </tr>
							                                            
					                                                    <tr id="Tr2" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFromForTrainForBranch1" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFromForTrainForBranch1" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFromForTrainForBranch1_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="60px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblFromForTrainForBranch1" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFromForTrainForBranch1" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upToForTrainForBranch1" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtToForTrainForBranch1" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtToForTrainForBranch1_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="60px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblToForTrainForBranch1" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtToForTrainForBranch1" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtTrDaysForTrainForBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <asp:DropDownList ID="ddlRateTypeForTrainBranch1" runat="server" CssClass="blackfnt">
						                                                            <asp:ListItem Selected="True" Value="-1" Text="Select"></asp:ListItem>
							                                                        <asp:ListItem Value="W" Text="Per Kg."></asp:ListItem>
							                                                        <asp:ListItem Value="P" Text="Per Package"></asp:ListItem>
						                                                        </asp:DropDownList>
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab1ForTrainBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab2ForTrainBranch1" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab3ForTrainBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab4ForTrainBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab5ForTrainBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab6ForTrainBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
							                                        </table>
		                                                        </td>
		                                                    </tr>
                                                            
			                                                <%--trForRoadForZone here--%>
			                                                <tr style="background-color: White" id="trForRoadForZone" runat="server">
			                                                    <td colspan="4" align="left" style="height: 200" valign="top">
			                                                        <br style="font-size: 6pt;" />
								                                    
								                                    <center>
						        									    <label class="bluefnt">
						        									        <b>
						        									            <u>
						        									                Matrices for Road - Freight Rate - Zone Matrix
						        									            </u>
						        									        </b>
						        									    </label>
						        									</center>
								                                    
								                                     <br style="font-size: 6pt;" />
								                                    
					                                                <table border="0" cellpadding="2" width="50%" cellspacing="1" align="center" class="boxbg">
							                                            <tr style="background-color: White">
							                                                <td align="right">
							                                                    <label class="blackfnt">
							                                                        Zone:&nbsp;
							                                                    </label>
							                                                </td>
							                                                
								                                            <td align="left">
						                                                        <label style="margin-left: 5px;">
                                                                                </label>
					                                                            <asp:DropDownList ID="ddlZoneHeaderRoad" runat="server" CssClass="blackfnt" >
					                                                            </asp:DropDownList>        
								                                            </td>
							                                            </tr>
							                                        </table>
							                                        
							                                        <br style="font-size: 6pt;" />
							                                        
							                                        <table border="0" cellpadding="2" width="50%" cellspacing="1" align="center" class="boxbg">
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
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Transit Days
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Rate Type
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 1
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 2
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 3
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 4
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 5
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 6
							                                                    </label>
							                                                </td>
							                                            </tr>
							                                            
							                                            <%--table row for Freight Matrix for Zone - Row 1--%>
                                                                        <tr runat="server" style="background-color: White">
					                                                        <td align="center">
							                                                    <asp:DropDownList ID="ddlZoneRoadFromForRow1" runat="server" CssClass="blackfnt">
					                                                            </asp:DropDownList>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <asp:DropDownList ID="ddlZoneRoadToForRow1" runat="server" CssClass="blackfnt">
					                                                            </asp:DropDownList>
							                                                </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtTrDaysForRoadForZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <asp:DropDownList ID="ddlRateTypeForRoadZone1" runat="server" CssClass="blackfnt">
						                                                            <asp:ListItem Selected="True" Value="-1" Text="Select"></asp:ListItem>
							                                                        <asp:ListItem Value="W" Text="Per Kg."></asp:ListItem>
							                                                        <asp:ListItem Value="P" Text="Per Package"></asp:ListItem>
						                                                        </asp:DropDownList>
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab1ForRoadZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab2ForRoadZone1" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab3ForRoadZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab4ForRoadZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab5ForRoadZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab6ForRoadZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>         
					                                                </table>
					                                            </td>
					                                        </tr>
			                                                                                                                                                                     						                                                        
					                                        <%--trForExpressForZone here--%>
					                                        <tr style="background-color: White" id="trForExpressForZone" runat="server">
			                                                    <td colspan="4" align="left" style="height: 200" valign="top">
			                                                        <br style="font-size: 6pt;" />
								                                    
								                                    <center>
						        									    <label class="bluefnt">
						        									        <b>
						        									            <u>
						        									                Matrices for Express - Freight Rate - Zone Matrix
						        									            </u>
						        									        </b>
						        									    </label>
						        									</center>
								                                    
								                                     <br style="font-size: 6pt;" />
								                                    
					                                                <table border="0" cellpadding="2" width="50%" cellspacing="1" align="center" class="boxbg">
							                                            <tr style="background-color: White">
							                                                <td align="right">
							                                                    <label class="blackfnt">
							                                                        Zone:&nbsp;
							                                                    </label>
							                                                </td>
							                                                
								                                            <td align="left">
						                                                        <label style="margin-left: 5px;">
                                                                                </label>
					                                                            <asp:DropDownList ID="ddlZoneHeaderExpress" runat="server" CssClass="blackfnt" >
					                                                            </asp:DropDownList>
								                                            </td>
							                                            </tr>
							                                        </table>
							                                        
							                                        <br style="font-size: 6pt;" />
							                                        
							                                        <table border="0" cellpadding="2" width="50%" cellspacing="1" align="center" class="boxbg">
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
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Transit Days
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Rate Type
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 1
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 2
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 3
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 4
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 5
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 6
							                                                    </label>
							                                                </td>
							                                            </tr>
							                                            
							                                            <%--table row for Freight Matrix for Zone - Row 1--%>
                                                                        <tr id="Tr4" runat="server" style="background-color: White">
					                                                        <td align="center">
							                                                    <asp:DropDownList ID="ddlZoneExpressFromForRow1" runat="server" CssClass="blackfnt">
					                                                            </asp:DropDownList>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <asp:DropDownList ID="ddlZoneExpressToForRow1" runat="server" CssClass="blackfnt">
					                                                            </asp:DropDownList>
							                                                </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtTrDaysForExpressForZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <asp:DropDownList ID="ddlRateTypeForExpressZone1" runat="server" CssClass="blackfnt">
						                                                            <asp:ListItem Selected="True" Value="-1" Text="Select"></asp:ListItem>
							                                                        <asp:ListItem Value="W" Text="Per Kg."></asp:ListItem>
							                                                        <asp:ListItem Value="P" Text="Per Package"></asp:ListItem>
						                                                        </asp:DropDownList>
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab1ForExpressZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab2ForExpressZone1" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab3ForExpressZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab4ForExpressZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab5ForExpressZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab6ForExpressZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>         
					                                                </table>
					                                            </td>
					                                        </tr>
					                                        
					                                        <%--trForAirForZone here--%>
					                                        <tr style="background-color: White" id="trForAirForZone" runat="server">
			                                                    <td colspan="4" align="left" style="height: 200" valign="top">
			                                                        <br style="font-size: 6pt;" />
								                                    
								                                    <center>
						        									    <label class="bluefnt">
						        									        <b>
						        									            <u>
						        									                Matrices for Air - Freight Rate - Zone Matrix
						        									            </u>
						        									        </b>
						        									    </label>
						        									</center>
								                                    
								                                     <br style="font-size: 6pt;" />
								                                    
					                                                <table border="0" cellpadding="2" width="50%" cellspacing="1" align="center" class="boxbg">
							                                            <tr style="background-color: White">
							                                                <td align="right">
							                                                    <label class="blackfnt">
							                                                        Zone:&nbsp;
							                                                    </label>
							                                                </td>
							                                                
								                                            <td align="left">
						                                                        <label style="margin-left: 5px;">
                                                                                </label>
					                                                            <asp:DropDownList ID="ddlZoneHeaderAir" runat="server" CssClass="blackfnt" >
					                                                            </asp:DropDownList>        
								                                            </td>
							                                            </tr>
							                                        </table>
							                                        
							                                        <br style="font-size: 6pt;" />
							                                        
							                                        <table border="0" cellpadding="2" width="50%" cellspacing="1" align="center" class="boxbg">
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
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Transit Days
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Rate Type
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 1
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 2
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 3
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 4
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 5
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 6
							                                                    </label>
							                                                </td>
							                                            </tr>
							                                            
							                                            <%--table row for Freight Matrix for Zone - Row 1--%>
                                                                        <tr id="Tr3" runat="server" style="background-color: White">
					                                                        <td align="center">
							                                                    <asp:DropDownList ID="ddlZoneAirFromForRow1" runat="server" CssClass="blackfnt">
					                                                            </asp:DropDownList>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <asp:DropDownList ID="ddlZoneAirToForRow1" runat="server" CssClass="blackfnt">
					                                                            </asp:DropDownList>
							                                                </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtTrDaysForAirForZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <asp:DropDownList ID="ddlRateTypeForAirZone1" runat="server" CssClass="blackfnt">
						                                                            <asp:ListItem Selected="True" Value="-1" Text="Select"></asp:ListItem>
							                                                        <asp:ListItem Value="W" Text="Per Kg."></asp:ListItem>
							                                                        <asp:ListItem Value="P" Text="Per Package"></asp:ListItem>
						                                                        </asp:DropDownList>
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab1ForAirZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab2ForAirZone1" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab3ForAirZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab4ForAirZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab5ForAirZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab6ForAirZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>         
					                                                </table>
					                                            </td>
					                                        </tr>
					                                        
					                                        <%--trForTrainForZone here--%>
					                                        <tr style="background-color: White" id="trForTrainForZone" runat="server">
			                                                    <td colspan="4" align="left" style="height: 200" valign="top">
			                                                        <br style="font-size: 6pt;" />
								                                    
								                                    <center>
						        									    <label class="bluefnt">
						        									        <b>
						        									            <u>
						        									                Matrices for Train - Freight Rate - Zone Matrix
						        									            </u>
						        									        </b>
						        									    </label>
						        									</center>
								                                    
								                                     <br style="font-size: 6pt;" />
								                                    
					                                                <table border="0" cellpadding="2" width="50%" cellspacing="1" align="center" class="boxbg">
							                                            <tr style="background-color: White">
							                                                <td align="right">
							                                                    <label class="blackfnt">
							                                                        Zone:&nbsp;
							                                                    </label>
							                                                </td>
							                                                
								                                            <td align="left">
						                                                        <label style="margin-left: 5px;">
                                                                                </label>
					                                                            <asp:DropDownList ID="ddlZoneHeaderTrain" runat="server" CssClass="blackfnt" >
					                                                            </asp:DropDownList>        
								                                            </td>
							                                            </tr>
							                                        </table>
							                                        
							                                        <br style="font-size: 6pt;" />
							                                        
							                                        <table border="0" cellpadding="2" width="50%" cellspacing="1" align="center" class="boxbg">
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
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Transit Days
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Rate Type
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 1
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 2
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 3
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 4
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 5
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 6
							                                                    </label>
							                                                </td>
							                                            </tr>
							                                            
							                                            <%--table row for Freight Matrix for Zone - Row 1--%>
                                                                        <tr id="Tr5" runat="server" style="background-color: White">
					                                                        <td align="center">
							                                                    <asp:DropDownList ID="ddlZoneTrainFromForRow1" runat="server" CssClass="blackfnt">
					                                                            </asp:DropDownList>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <asp:DropDownList ID="ddlZoneTrainToForRow1" runat="server" CssClass="blackfnt">
					                                                            </asp:DropDownList>
							                                                </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtTrDaysForTrainForZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <asp:DropDownList ID="ddlRateTypeForTrainZone1" runat="server" CssClass="blackfnt">
						                                                            <asp:ListItem Selected="True" Value="-1" Text="Select"></asp:ListItem>
							                                                        <asp:ListItem Value="W" Text="Per Kg."></asp:ListItem>
							                                                        <asp:ListItem Value="P" Text="Per Package"></asp:ListItem>
						                                                        </asp:DropDownList>
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab1ForTrainZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab2ForTrainZone1" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab3ForTrainZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab4ForTrainZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab5ForTrainZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab6ForTrainZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>         
					                                                </table>
					                                            </td>
					                                        </tr>
					                                        
					                                        <%--trForRoadForCity here--%>
                                                            <tr style="background-color: White" id="trForRoadForCity" runat="server">
                                                                <td colspan="4" align="left" style="height: 200" valign="top">
			                                                        <br style="font-size: 6pt;" />
						        									
						        									<center>
						        									    <label class="bluefnt">
						        									        <b>
						        									            <u>
						        									                Matrices for Road - Freight Rate - City Matrix
						        									            </u>
						        									        </b>
						        									    </label>
						        									</center>
						        									
						        									<br style="font-size: 6pt;" />
						        									
					                                                <table border="0" cellpadding="2" width="50%" cellspacing="1" align="center" class="boxbg">
							                                            <tr style="background-color: White">
							                                                <td align="right">
							                                                    <label class="blackfnt">
							                                                        City:&nbsp;
							                                                    </label>
							                                                </td>
							                                                
								                                            <td align="left">
								                                                <asp:UpdatePanel ID="upCityCodeRoad" runat="server">
								                                                    <ContentTemplate>
								                                                        <asp:TextBox ID="txtCityCodeRoad" runat="server" MaxLength="50" 
								                                                            OnTextChanged="txtCityCodeRoad_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="100px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
								                                                        <input type="button" value="..." runat="server" id="btnCityCode" 
                                                                                            onclick="return BranchPopup('City_Popup.aspx?4')" />
                                                                                        <br />
                                                                                        <label class="blackfnt" id="lblErrorCityCodeRoad" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid City Code!!!
                                                                                        </label>    
								                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtCityCodeRoad" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
								                                            </td>
							                                            </tr>
							                                        </table>
							                                        
							                                        <br style="font-size: 6pt;"/>	
			                                                        
			                                                        <table border="0" cellpadding="2" width="50%" cellspacing="1" align="center" class="boxbg">
			                                                            <tr style="background-color: White">
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        From
							                                                    </label>
							                                                    &nbsp;
					                                                            <input type="button" value="..." runat="server" id="btnFromForRoadCity" 
                                                                                    onclick="return BranchPopup('City_Popup_Multi_Selection.aspx?7')" />            
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        To
							                                                    </label>
							                                                    &nbsp;
					                                                            <input type="button" value="..." runat="server" id="btnToForRoadCity" 
                                                                                    onclick="return BranchPopup('City_Popup_Multi_Selection.aspx?8')" />            
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Transit Days
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Rate Type
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 1
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 2
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 3
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 4
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 5
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 6
							                                                    </label>
							                                                </td>
							                                            </tr>
							                                            
					                                                    <tr id="Tr6" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFromForRoadForCity1" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFromForRoadForCity1" runat="server" MaxLength="50" 
								                                                            OnTextChanged="txtFromForRoadForCity1_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="100px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblFromForRoadForCity1" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid City Code!!!
                                                                                        </label>
                                                                                </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFromForRoadForCity1" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upToForRoadForCity1" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtToForRoadForCity1" runat="server" MaxLength="50" 
								                                                            OnTextChanged="txtToForRoadForCity1_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="100px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblToForRoadForCity1" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid City Code!!!
                                                                                        </label>
                                                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtToForRoadForCity1" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtTrDaysForRoadForCity1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <asp:DropDownList ID="ddlRateTypeForRoadCity1" runat="server" CssClass="blackfnt">
						                                                            <asp:ListItem Selected="True" Value="-1" Text="Select"></asp:ListItem>
							                                                        <asp:ListItem Value="W" Text="Per Kg."></asp:ListItem>
							                                                        <asp:ListItem Value="P" Text="Per Package"></asp:ListItem>
						                                                        </asp:DropDownList>
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab1ForRoadCity1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab2ForRoadCity1" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab3ForRoadCity1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab4ForRoadCity1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab5ForRoadCity1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab6ForRoadCity1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
							                                        </table>
		                                                        </td>
		                                                    </tr>
                                                            
                                                            <%--trForExpressForCity here--%>
                                                            <tr style="background-color: White" id="trForExpressForCity" runat="server">
                                                                <td colspan="4" align="left" style="height: 200" valign="top">
			                                                        <br style="font-size: 6pt;" />
						        									
						        									<center>
						        									    <label class="bluefnt">
						        									        <b>
						        									            <u>
						        									                Matrices for Express - Freight Rate - City Matrix
						        									            </u>
						        									        </b>
						        									    </label>
						        									</center>
						        									
						        									<br style="font-size: 6pt;" />
						        									
					                                                <table border="0" cellpadding="2" width="50%" cellspacing="1" align="center" class="boxbg">
							                                            <tr style="background-color: White">
							                                                <td align="right">
							                                                    <label class="blackfnt">
							                                                        City:&nbsp;
							                                                    </label>
							                                                </td>
							                                                
								                                            <td align="left">
								                                                <asp:UpdatePanel ID="upCityCodeExpress" runat="server">
								                                                    <ContentTemplate>
								                                                        <asp:TextBox ID="txtCityCodeExpress" runat="server" MaxLength="50" 
								                                                            OnTextChanged="txtCityCodeExpress_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="100px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
								                                                        <input type="button" value="..." runat="server" id="Button4" 
                                                                                            onclick="return BranchPopup('City_Popup.aspx?5')" />
                                                                                        <br />
                                                                                        <label class="blackfnt" id="lblErrorCityCodeExpress" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid City Code!!!
                                                                                        </label>    
								                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtCityCodeExpress" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
								                                            </td>
							                                            </tr>
							                                        </table>
							                                        
							                                        <br style="font-size: 6pt;"/>	
			                                                        
			                                                        <table border="0" cellpadding="2" width="50%" cellspacing="1" align="center" class="boxbg">
			                                                            <tr style="background-color: White">
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        From
							                                                    </label>
							                                                    &nbsp;
					                                                            <input type="button" value="..." runat="server" id="btnFromForExpressCity" 
                                                                                    onclick="return BranchPopup('City_Popup_Multi_Selection.aspx?9')" />            
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        To
							                                                    </label>
							                                                    &nbsp;
					                                                            <input type="button" value="..." runat="server" id="btnToForExpressCity" 
                                                                                    onclick="return BranchPopup('City_Popup_Multi_Selection.aspx?10')" />            
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Transit Days
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Rate Type
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 1
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 2
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 3
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 4
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 5
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 6
							                                                    </label>
							                                                </td>
							                                            </tr>
							                                            
					                                                    <tr id="Tr7" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFromForExpressForCity1" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFromForExpressForCity1" runat="server" MaxLength="50" 
								                                                            OnTextChanged="txtFromForExpressForCity1_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="100px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblFromForExpressForCity1" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid City Code!!!
                                                                                        </label>
                                                                                </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFromForExpressForCity1" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upToForExpressForCity1" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtToForExpressForCity1" runat="server" MaxLength="50" 
								                                                            OnTextChanged="txtToForExpressForCity1_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="100px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblToForExpressForCity1" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid City Code!!!
                                                                                        </label>
                                                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtToForExpressForCity1" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtTrDaysForExpressForCity1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <asp:DropDownList ID="ddlRateTypeForExpressCity1" runat="server" CssClass="blackfnt">
						                                                            <asp:ListItem Selected="True" Value="-1" Text="Select"></asp:ListItem>
							                                                        <asp:ListItem Value="W" Text="Per Kg."></asp:ListItem>
							                                                        <asp:ListItem Value="P" Text="Per Package"></asp:ListItem>
						                                                        </asp:DropDownList>
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab1ForExpressCity1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab2ForExpressCity1" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab3ForExpressCity1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab4ForExpressCity1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab5ForExpressCity1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab6ForExpressCity1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
							                                        </table>
		                                                        </td>
		                                                    </tr>
		                                                    
		                                                    <%--trForAirForCity here--%>
                                                            <tr style="background-color: White" id="trForAirForCity" runat="server">
                                                                <td colspan="4" align="left" style="height: 200" valign="top">
			                                                        <br style="font-size: 6pt;" />
						        									
						        									<center>
						        									    <label class="bluefnt">
						        									        <b>
						        									            <u>
						        									                Matrices for Air - Freight Rate - City Matrix
						        									            </u>
						        									        </b>
						        									    </label>
						        									</center>
						        									
						        									<br style="font-size: 6pt;" />
						        									
					                                                <table border="0" cellpadding="2" width="50%" cellspacing="1" align="center" class="boxbg">
							                                            <tr style="background-color: White">
							                                                <td align="right">
							                                                    <label class="blackfnt">
							                                                        City:&nbsp;
							                                                    </label>
							                                                </td>
							                                                
								                                            <td align="left">
								                                                <asp:UpdatePanel ID="upCityCodeAir" runat="server">
								                                                    <ContentTemplate>
								                                                        <asp:TextBox ID="txtCityCodeAir" runat="server" MaxLength="50" 
								                                                            OnTextChanged="txtCityCodeAir_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="100px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
								                                                        <input type="button" value="..." runat="server" id="btnCityCodeAir" 
                                                                                            onclick="return BranchPopup('City_Popup.aspx?6')" />
                                                                                        <br />
                                                                                        <label class="blackfnt" id="lblErrorCityCodeAir" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid City Code!!!
                                                                                        </label>    
								                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtCityCodeAir" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
								                                            </td>
							                                            </tr>
							                                        </table>
							                                        
							                                        <br style="font-size: 6pt;"/>	
			                                                        
			                                                        <table border="0" cellpadding="2" width="50%" cellspacing="1" align="center" class="boxbg">
			                                                            <tr style="background-color: White">
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        From
							                                                    </label>
							                                                    &nbsp;
					                                                            <input type="button" value="..." runat="server" id="btnFromForAirCity" 
                                                                                    onclick="return BranchPopup('City_Popup_Multi_Selection.aspx?11')" />            
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        To
							                                                    </label>
							                                                    &nbsp;
					                                                            <input type="button" value="..." runat="server" id="btnToForAirCity" 
                                                                                    onclick="return BranchPopup('City_Popup_Multi_Selection.aspx?12')" />            
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Transit Days
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Rate Type
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 1
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 2
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 3
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 4
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 5
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 6
							                                                    </label>
							                                                </td>
							                                            </tr>
							                                            
					                                                    <tr id="Tr8" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFromForAirForCity1" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFromForAirForCity1" runat="server" MaxLength="50" 
								                                                            OnTextChanged="txtFromForAirForCity1_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="100px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblFromForAirForCity1" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid City Code!!!
                                                                                        </label>
                                                                                </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFromForAirForCity1" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upToForAirForCity1" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtToForAirForCity1" runat="server" MaxLength="50" 
								                                                            OnTextChanged="txtToForAirForCity1_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="100px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblToForAirForCity1" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid City Code!!!
                                                                                        </label>
                                                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtToForAirForCity1" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtTrDaysForAirForCity1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <asp:DropDownList ID="ddlRateTypeForAirCity1" runat="server" CssClass="blackfnt">
						                                                            <asp:ListItem Selected="True" Value="-1" Text="Select"></asp:ListItem>
							                                                        <asp:ListItem Value="W" Text="Per Kg."></asp:ListItem>
							                                                        <asp:ListItem Value="P" Text="Per Package"></asp:ListItem>
						                                                        </asp:DropDownList>
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab1ForAirCity1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab2ForAirCity1" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab3ForAirCity1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab4ForAirCity1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab5ForAirCity1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab6ForAirCity1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
							                                        </table>
		                                                        </td>
		                                                    </tr>
		                                                    
		                                                    <%--trForTrainForCity here--%>
                                                            <tr style="background-color: White" id="trForTrainForCity" runat="server">
                                                                <td colspan="4" align="left" style="height: 200" valign="top">
			                                                        <br style="font-size: 6pt;" />
						        									
						        									<center>
						        									    <label class="bluefnt">
						        									        <b>
						        									            <u>
						        									                Matrices for Train - Freight Rate - City Matrix
						        									            </u>
						        									        </b>
						        									    </label>
						        									</center>
						        									
						        									<br style="font-size: 6pt;" />
						        									
					                                                <table border="0" cellpadding="2" width="50%" cellspacing="1" align="center" class="boxbg">
							                                            <tr style="background-color: White">
							                                                <td align="right">
							                                                    <label class="blackfnt">
							                                                        City:&nbsp;
							                                                    </label>
							                                                </td>
							                                                
								                                            <td align="left">
								                                                <asp:UpdatePanel ID="upCityCodeTrain" runat="server">
								                                                    <ContentTemplate>
								                                                        <asp:TextBox ID="txtCityCodeTrain" runat="server" MaxLength="50" 
								                                                            OnTextChanged="txtCityCodeTrain_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="100px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
								                                                        <input type="button" value="..." runat="server" id="btnCityCodeTrain" 
                                                                                            onclick="return BranchPopup('City_Popup.aspx?7')" />
                                                                                        <br />
                                                                                        <label class="blackfnt" id="lblErrorCityCodeTrain" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid City Code!!!
                                                                                        </label>    
								                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtCityCodeTrain" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
								                                            </td>
							                                            </tr>
							                                        </table>
							                                        
							                                        <br style="font-size: 6pt;"/>	
			                                                        
			                                                        <table border="0" cellpadding="2" width="50%" cellspacing="1" align="center" class="boxbg">
			                                                            <tr style="background-color: White">
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        From
							                                                    </label>
							                                                    &nbsp;
					                                                            <input type="button" value="..." runat="server" id="btnFromForTrainCity" 
                                                                                    onclick="return BranchPopup('City_Popup_Multi_Selection.aspx?13')" />            
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        To
							                                                    </label>
							                                                    &nbsp;
					                                                            <input type="button" value="..." runat="server" id="btnToForTrainCity" 
                                                                                    onclick="return BranchPopup('City_Popup_Multi_Selection.aspx?14')" />            
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Transit Days
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Rate Type
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 1
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 2
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 3
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 4
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 5
							                                                    </label>
							                                                </td>
							                                                
							                                                <td align="center">
							                                                    <label class="blackfnt">
							                                                        Slab 6
							                                                    </label>
							                                                </td>
							                                            </tr>
							                                            
					                                                    <tr id="Tr9" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFromForTrainForCity1" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFromForTrainForCity1" runat="server" MaxLength="50" 
								                                                            OnTextChanged="txtFromForTrainForCity1_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="100px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblFromForTrainForCity1" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid City Code!!!
                                                                                        </label>
                                                                                </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFromForTrainForCity1" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upToForTrainForCity1" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtToForTrainForCity1" runat="server" MaxLength="50" 
								                                                            OnTextChanged="txtToForTrainForCity1_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="100px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblToForTrainForCity1" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid City Code!!!
                                                                                        </label>
                                                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtToForTrainForCity1" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtTrDaysForTrainForCity1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <asp:DropDownList ID="ddlRateTypeForTrainCity1" runat="server" CssClass="blackfnt">
						                                                            <asp:ListItem Selected="True" Value="-1" Text="Select"></asp:ListItem>
							                                                        <asp:ListItem Value="W" Text="Per Kg."></asp:ListItem>
							                                                        <asp:ListItem Value="P" Text="Per Package"></asp:ListItem>
						                                                        </asp:DropDownList>
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab1ForTrainCity1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab2ForTrainCity1" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab3ForTrainCity1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab4ForTrainCity1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab5ForTrainCity1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtSlab6ForTrainCity1" type="text" size="10" 
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
