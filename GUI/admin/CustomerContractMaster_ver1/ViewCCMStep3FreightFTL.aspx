<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="EditCCMStep3FreightFTL.aspx.cs" Inherits="GUI_admin_CustomerContractMaster_EditCCMStep3FreightFTL" Title="Customer Contract Master - FTL" %>

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

        function BranchPopup(strPopupURL)
        {
            var strWinFeature = "height=375,width=350,scrollbars=yes,left=300,top=125"
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        
        function CheckBranchCityMatrix(MOT, BranchCity)
        {
            var mCtlForFTLType = "ctl00_MyCPH1_ddlFTLType" + MOT + "For" + BranchCity;
            var mCtlForFRFrom = "ctl00_MyCPH1_txtFRFrom" + MOT + "For" + BranchCity;
            var mCtlForFRFromErrorLabel = "ctl00_MyCPH1_lblErrorFRFrom" + MOT + "For" + BranchCity;
            var mCtlForFRTo = "ctl00_MyCPH1_txtFRTo" + MOT + "For" + BranchCity;
            var mCtlForFRToErrorLabel = "ctl00_MyCPH1_lblErrorFRTo" + MOT + "For" + BranchCity;
            var mCtlForFRFromZone = "ctl00_MyCPH1_ddlZone" + MOT + "FromForRow";
            var mCtlForFRToZone = "ctl00_MyCPH1_ddlZone" + MOT + "ToForRow";
            
            var mVarBM = "";
            var mVarBMTemp = "";
            
            if(document.getElementById(mCtlForFTLType + "1") && document.getElementById(mCtlForFTLType + "2") && document.getElementById(mCtlForFTLType + "3") && document.getElementById(mCtlForFTLType + "4") && document.getElementById(mCtlForFTLType + "5"))
            {
                var mFTL1 = document.getElementById(mCtlForFTLType + "1").value;    
                var mFTL2 = (document.getElementById(mCtlForFTLType + "2").value == "-1" ? "2" : document.getElementById(mCtlForFTLType + "2").value);
                var mFTL3 = (document.getElementById(mCtlForFTLType + "3").value == "-1" ? "3" : document.getElementById(mCtlForFTLType + "3").value);
                var mFTL4 = (document.getElementById(mCtlForFTLType + "4").value == "-1" ? "4" : document.getElementById(mCtlForFTLType + "4").value);
                var mFTL5 = (document.getElementById(mCtlForFTLType + "5").value == "-1" ? "5" : document.getElementById(mCtlForFTLType + "5").value);
                
                if(mFTL1 == mFTL2 || mFTL1 == mFTL3 || mFTL1 == mFTL4 || mFTL1 == mFTL5 || mFTL2 == mFTL3 || mFTL2 == mFTL4 || mFTL2 == mFTL5 || mFTL3 == mFTL4 || mFTL3 == mFTL5 || mFTL4 == mFTL5)
                {
                    alert("Select distinct value for FTL Type!");
                    document.getElementById(mCtlForFTLType + "1").focus();
                    return false;
                }
            }
            
            //Check for Branch/City Matrix
            for(var mLoopCounter = 1 ; mLoopCounter <= 10; mLoopCounter++)
            {
                if( ( BranchCity != "Zone" && document.getElementById(mCtlForFRFrom + mLoopCounter) && document.getElementById(mCtlForFRTo + mLoopCounter) ) ||  ( BranchCity == "Zone" && document.getElementById(mCtlForFRFromZone + mLoopCounter) && document.getElementById(mCtlForFRToZone + mLoopCounter) ))
                {
                    var mDataExists = 0;
                    
                    if( ( BranchCity != "Zone" && document.getElementById(mCtlForFRFrom + mLoopCounter).value != "" && document.getElementById(mCtlForFRTo + mLoopCounter).value != "" ) ||  ( BranchCity == "Zone" && document.getElementById(mCtlForFRFromZone + mLoopCounter).value != "-1" && document.getElementById(mCtlForFRToZone + mLoopCounter).value != "-1" ))
                    {
                        mDataExists = 1;
                    }
                    if(mDataExists == 1)
                    {   
                        //Check for Branch From for Mode of Transport 
                        if(BranchCity == "Zone")
                        {
                            if(document.getElementById(mCtlForFRFromZone + mLoopCounter))
                            {
                                if(document.getElementById(mCtlForFRFromZone + mLoopCounter).value != "-1")
                                {
                                    mVarBMTemp = document.getElementById(mCtlForFRFromZone + mLoopCounter).value;
                                }
                                else
                                {
                                    alert("Select Zone From for " + MOT);
                                    document.getElementById(mCtlForFRFromZone + mLoopCounter).focus();
                                    return false;
                                }
                            }
                    
                            //Check for Branch/City To for Mode of Transport
                            if(document.getElementById(mCtlForFRToZone + mLoopCounter))
                            {
                                if(document.getElementById(mCtlForFRToZone + mLoopCounter).value != "-1")
                                {
                                    mVarBMTemp += "," + document.getElementById(mCtlForFRToZone + mLoopCounter).value;
                                }
                                else
                                {
                                    alert("Select Zone To for " + MOT);
                                    document.getElementById(mCtlForFRToZone + mLoopCounter).focus();
                                    return false;
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
                                            alert("Invalid '" + BranchCity + " Code' for " + MOT);
                                            document.getElementById(mCtlForFRFrom + mLoopCounter).focus();
                                            return false;
                                        }
                                    }
                                    mVarBMTemp = document.getElementById(mCtlForFRFrom + mLoopCounter).value;
                                }
                                else
                                {
                                    alert("Enter '" + BranchCity + " Code' for " + MOT);
                                    document.getElementById(mCtlForFRFrom + mLoopCounter).focus();
                                    return false;
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
                                            alert("Invalid '" + BranchCity + " Code' for " + MOT);
                                            document.getElementById(mCtlForFRTo + mLoopCounter).focus();
                                            return false;
                                        }
                                    }
                                    mVarBMTemp += "," + document.getElementById(mCtlForFRTo + mLoopCounter).value;
                                }
                                else
                                {
                                    alert("Enter '" + BranchCity + " Code' for " + MOT);
                                    document.getElementById(mCtlForFRTo + mLoopCounter).focus();
                                    return false;
                                }
                            }
                        }
                        
                        for(var mLoopCounterForFTL = 1 ; mLoopCounterForFTL <= 5; mLoopCounterForFTL++)
                        {        
                            if(document.getElementById(mCtlForFTLType + mLoopCounterForFTL))
                            {
                                if(document.getElementById(mCtlForFTLType + mLoopCounterForFTL).value != "-1")
                                {
                                    //Check for Freight Rate for Mode of Transport for FTL Types
                                    if(document.getElementById("ctl00_MyCPH1_txtFR" + MOT + "FTLType" + mLoopCounterForFTL + "RowFor" + BranchCity + mLoopCounter))
                                    {
                                        if(document.getElementById("ctl00_MyCPH1_txtFR" + MOT + "FTLType" + mLoopCounterForFTL + "RowFor" + BranchCity + mLoopCounter).value == "")
                                        {
                                            alert("Enter 'Freight Rate' for FTL Type" + mLoopCounterForFTL);
                                            document.getElementById("ctl00_MyCPH1_txtFR" + MOT + "FTLType" + mLoopCounterForFTL + "RowFor" + BranchCity + mLoopCounter).focus();
                                            return false;
                                        }
                                        else
                                        {
                                            mVarBMTemp += "," + document.getElementById("ctl00_MyCPH1_txtFR" + MOT + "FTLType" + mLoopCounterForFTL + "RowFor" + BranchCity + mLoopCounter).value;
                                        }
                                    }
                                    
                                    //Check for Transit Days for Mode of Transport for FTL Types
                                    if(document.getElementById("ctl00_MyCPH1_txtTrDays" + MOT + "FTLType" + mLoopCounterForFTL + "RowFor" + BranchCity + mLoopCounter))
                                    {
                                        if(document.getElementById("ctl00_MyCPH1_txtTrDays" + MOT + "FTLType" + mLoopCounterForFTL + "RowFor" + BranchCity + mLoopCounter).value == "")
                                        {
                                            alert("Enter 'Transit Days' for FTL Type" + mLoopCounterForFTL);
                                            document.getElementById("ctl00_MyCPH1_txtTrDays" + MOT + "FTLType" + mLoopCounterForFTL + "RowFor" + BranchCity + mLoopCounter).focus();
                                            return false;
                                        }
                                        else
                                        {
                                            mVarBMTemp += "," + document.getElementById("ctl00_MyCPH1_txtTrDays" + MOT + "FTLType" + mLoopCounterForFTL + "RowFor" + BranchCity + mLoopCounter).value;
                                        }
                                    }
                                }
                                else
                                {
                                    mVarBMTemp += "," + ",";
                                }
                            }
                        }
                        if(mVarBMTemp != "")
                        {
                            mVarBM = (mVarBM == "" ? mVarBMTemp : mVarBM + "~" + mVarBMTemp);
                            mVarBMTemp = "";
                        }
                    }
                    else
                    {
//                        if(mLoopCounter == 1)
//                        {
//                            if(BranchCity == "Zone")
//                            {
//                                alert("Enter/Select Freight Matrix Details!");
//                                document.getElementById(mCtlForFRFromZone + mLoopCounter).focus();
//                            }
//                            else
//                            {
//                                alert("Enter Freight Matrix Details!");
//                                document.getElementById(mCtlForFRFrom + mLoopCounter).focus();
//                            }
//                            return false;
//                        }    
                    }
                }
            }
            
            //Check for Distinct Pair of Branch/City From & To
            for(var mLoopCounter = 1 ; mLoopCounter <= 10; mLoopCounter++)
            {
                var mVarBranchCityFrom = "";
                var mVarBranchCityTo =  "";
                
                if(BranchCity != "Zone")
                {
                    if(document.getElementById(mCtlForFRFrom + mLoopCounter))
                    {
                        mVarBranchCityFrom = document.getElementById(mCtlForFRFrom + mLoopCounter).value;
                    }
                    
                    if(document.getElementById(mCtlForFRTo + mLoopCounter))
                    {
                        mVarBranchCityTo = document.getElementById(mCtlForFRTo + mLoopCounter).value;
                    }
                }
                else
                {
                    if(document.getElementById(mCtlForFRFromZone + mLoopCounter))
                    {
                        mVarBranchCityFrom = document.getElementById(mCtlForFRFromZone + mLoopCounter).value;
                    }
                    
                    if(document.getElementById(mCtlForFRToZone + mLoopCounter))
                    {
                        mVarBranchCityTo = document.getElementById(mCtlForFRToZone + mLoopCounter).value;
                    } 
                }
                
                if(mVarBranchCityFrom != "" && mVarBranchCityTo != "")
                {
                    if(CheckDuplicateBranchCity(mVarBranchCityFrom, mVarBranchCityTo, mLoopCounter, MOT, BranchCity) == true)
                    {
                        alert("Please enter/select distinct '" + BranchCity + " From' & '" + BranchCity + " To'!");
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
        
        function CheckBranchCityBasicDetails(MOT, BranchCity)
        {
            //Check for Branch Matrix for Road
            if(document.getElementById("ctl00_MyCPH1_trFor" + MOT + "For" + BranchCity))
            {
                if(document.getElementById("ctl00_MyCPH1_trFor" + MOT + "For" + BranchCity).style.display == '')
                {   
                    //Check for Branch Code for Road
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
//                            alert("Enter '" + BranchCity + " Code' for " + MOT);
//                            document.getElementById("ctl00_MyCPH1_txt" + BranchCity + "Code" + MOT).focus();
//                            return false;
//                        }
//                    }
//                    else
//                    {
//                        alert("Input Box not available for '" + BranchCity + " Code' for " + MOT);
//                        return false;
//                    }
                    
                    if(CheckBranchCityMatrix(MOT, BranchCity) == false)
                    {
                        return false;
                    }
                    
                    var mVarM = "";
                    
                    //Check for Atleast FTL Type1 Selection
                    if(BranchCity == "Branch")
                    {
                        if(document.getElementById("ctl00_MyCPH1_HidBM" + MOT))
                        {
                             mVarM = document.getElementById("ctl00_MyCPH1_HidBM" + MOT).value;
                        }    
                    }
                    else
                    {
                        if(document.getElementById("ctl00_MyCPH1_HidCM" + MOT))
                        {
                             mVarM = document.getElementById("ctl00_MyCPH1_HidCM" + MOT).value;
                        } 
                    }
                    
                    if(mVarM != "")
                    {
                        if(document.getElementById("ctl00_MyCPH1_ddlFTLType" + MOT + "For" + BranchCity + "1"))
                        {
                            if(document.getElementById("ctl00_MyCPH1_ddlFTLType" + MOT + "For" + BranchCity + "1").value == "-1")
                            {
                                alert("Select FTL Type1 from the list!");
                                document.getElementById("ctl00_MyCPH1_ddlFTLType" + MOT + "For" + BranchCity + "1").focus();
                                return false;
                            }
                        }
                        else
                        {
                            alert("Selection Box not available for FTL Type1 for " + MOT);
                            return false;
                        }
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
                    
                    //Check for Atleast FTL Type1 Selection
                    var mVarM = "";
                    
                    if(document.getElementById("ctl00_MyCPH1_HidZM" + MOT))
                    {
                         mVarM = document.getElementById("ctl00_MyCPH1_HidZM" + MOT).value;
                    } 
                    
                    if(mVarM != "")
                    {
                        if(document.getElementById("ctl00_MyCPH1_ddlFTLType" + MOT + "ForZone1"))
                        {
                            if(document.getElementById("ctl00_MyCPH1_ddlFTLType" + MOT + "ForZone1").value == "-1")
                            {
                                alert("Select FTL Type1 from the list!");
                                document.getElementById("ctl00_MyCPH1_ddlFTLType" + MOT + "ForZone1").focus();
                                return false;
                            }
                        }
                    }
                }
            }
        }
        
        function ValidateData()
        {
            if(CheckBranchCityBasicDetails("Road", "Branch") == false)
            {
                return false;
            }
            
            if(CheckBranchCityBasicDetails("Express", "Branch") == false)
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
            
            if(CheckBranchCityBasicDetails("Road", "City") == false)
            {
                return false;
            }
            
            if(CheckBranchCityBasicDetails("Express", "City") == false)
            {
                return false;
            }
            
            var mVarZMRoad = "";
            var mVarZMExpress = "";
            var mVarBMRoad = "";
            var mVarBMExpress = "";
            var mVarCMRoad = "";
            var mVarCMExpress = "";
                        
            if(document.getElementById("ctl00_MyCPH1_HidZMRoad"))
            {
                 mVarZMRoad = document.getElementById("ctl00_MyCPH1_HidZMRoad").value;
            }
            if(document.getElementById("ctl00_MyCPH1_HidZMExpress"))
            {
                 mVarZMExpress = document.getElementById("ctl00_MyCPH1_HidZMExpress").value;
            }
            if(document.getElementById("ctl00_MyCPH1_HidBMRoad"))
            {
                 mVarBMRoad = document.getElementById("ctl00_MyCPH1_HidBMRoad").value;
            }
            if(document.getElementById("ctl00_MyCPH1_HidBMExpress"))
            {
                 mVarBMExpress = document.getElementById("ctl00_MyCPH1_HidBMExpress").value;
            }
            if(document.getElementById("ctl00_MyCPH1_HidCMRoad"))
            {
                 mVarCMRoad = document.getElementById("ctl00_MyCPH1_HidCMRoad").value;
            }
            if(document.getElementById("ctl00_MyCPH1_HidCMExpress"))
            {
                 mVarCMExpress = document.getElementById("ctl00_MyCPH1_HidCMExpress").value;
            }
            
            if(mVarCMRoad == "" && mVarCMExpress == "" && mVarBMRoad == "" && mVarBMExpress == "" && mVarZMRoad == "" && mVarZMExpress == "")
            {
                alert("Enter Branch Matrix or Zone Matrix or City Matrix Details!");
                return false;
            }
            
            return true;
        }
            
        function CheckDuplicateBranchCity(BranchCityFrom, BranchCityTo, BranchCityRow, MOT, BranchCity)
        {
            var mVarControlForBranchCityFrom;
            var mVarControlForBranchCityTo;
            
            //Check for Branch/City Matrix
            for(var mLoopCounter = 1 ; mLoopCounter <= 10; mLoopCounter++)
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
                
        <input type="hidden" id="HidCustCode" runat="server" />
        <input type="hidden" id="HidCustCodeName" runat="server" />
        
        <input type="hidden" runat="server" id="HidRandomNo" />
        
        <input type="hidden" id="HidBMRoad" runat="server" />
        <input type="hidden" id="HidBMExpress" runat="server" />
        <input type="hidden" id="HidZMExpress" runat="server" />
        <input type="hidden" id="HidCMRoad" runat="server" />
        <input type="hidden" id="HidZMRoad" runat="server" />
        <input type="hidden" id="HidCMExpress" runat="server" />
        
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
			                                            
			                                            <table border="0" cellpadding="2" width="85%" cellspacing="1" align="center" class="boxbg">
			                                                <tr style="background-color: White">
			                                                    <td colspan="4" align="left">
			                                                        <label class="blackfnt" id="lblNote" runat="server">
			                                                        </label>
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
							                                                <td align="left">
							                                                    <label class="blackfnt">
							                                                        Branch:
							                                                    </label>
							                                                </td>
							                                                
								                                            <td align="left">
								                                                <asp:UpdatePanel ID="upBranchCodeRoad" runat="server">
								                                                    <ContentTemplate>
								                                                        <asp:TextBox ID="txtBranchCodeRoad" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtBranchCodeRoad_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
								                                                        <input type="button" value="..." runat="server" id="btnBranchCode" 
                                                                                            onclick="return BranchPopup('Branch_Popup.aspx?3')" />
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
			
			                                                        <table border="0" align="center" cellspacing="1" cellpadding="5" width="100%" class="boxbg">
				                                                        <tr style="background-color: White">
					                                                        <td align="center">
					                                                            <label class="blackfnt">
					                                                                From&nbsp;
						                                                            <input type="button" value="..." runat="server" id="btnBranchFromRoad" 
                                                                                        onclick="return BranchPopup('Branch_Popup_Multi_Selection.aspx?3')" />
					                                                            </label>
					                                                        </td>
					                                                        
						                                                    <td align="center">
						                                                        <label class="blackfnt">
						                                                            To&nbsp;
						                                                            <input type="button" value="..." runat="server" id="btnBranchToRoad" 
                                                                                        onclick="return BranchPopup('Branch_Popup_Multi_Selection.aspx?4')" />
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center" colspan="2">
						                                                        <label class="blackfnt">
						                                                            FTL Type1
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center" colspan="2">
						                                                        <label class="blackfnt">
						                                                            FTL Type2
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center" colspan="2">
						                                                        <label class="blackfnt">
						                                                            FTL Type3
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center" colspan="2">
						                                                        <label class="blackfnt">
						                                                            FTL Type4
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center" colspan="2">
						                                                        <label class="blackfnt">
						                                                            FTL Type5
						                                                        </label>
						                                                    </td>
						                                                </tr>
						                                                
						                                                <tr style="background-color: White">
					                                                        <td align="center">
					                                                            <label class="blackfnt">
					                                                                &nbsp;
					                                                            </label>
					                                                        </td>
					                                                        
						                                                    <td align="center">
						                                                        <label class="blackfnt">
						                                                            &nbsp;
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center" colspan="2">
						                                                        <asp:DropDownList ID="ddlFTLTypeRoadForBranch1" runat="server" CssClass="blackfnt"></asp:DropDownList>
						                                                    </td>
						                                                    
						                                                    <td align="center" colspan="2">
						                                                        <asp:DropDownList ID="ddlFTLTypeRoadForBranch2" runat="server" CssClass="blackfnt"></asp:DropDownList>
						                                                    </td>
						                                                    
						                                                    <td align="center" colspan="2">
						                                                        <asp:DropDownList ID="ddlFTLTypeRoadForBranch3" runat="server" CssClass="blackfnt"></asp:DropDownList>
						                                                    </td>
						                                                    
						                                                    <td align="center" colspan="2">
						                                                        <asp:DropDownList ID="ddlFTLTypeRoadForBranch4" runat="server" CssClass="blackfnt"></asp:DropDownList>
						                                                    </td>
						                                                    
						                                                    <td align="center" colspan="2">
						                                                        <asp:DropDownList ID="ddlFTLTypeRoadForBranch5" runat="server" CssClass="blackfnt"></asp:DropDownList>
						                                                    </td>
						                                                </tr>
						                                                
						                                                <tr style="background-color: White">
					                                                        <td align="center">
					                                                            <label class="blackfnt">
					                                                                &nbsp;
					                                                            </label>
					                                                        </td>
					                                                        
						                                                    <td align="center">
						                                                        <label class="blackfnt">
						                                                            &nbsp;
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center">
					                                                            <label class="blackfnt">
					                                                                FTL Rate
					                                                            </label>
					                                                        </td>
					                                                        
						                                                    <td align="center">
						                                                        <label class="blackfnt">
						                                                            Transit Days
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center">
					                                                            <label class="blackfnt">
					                                                                FTL Rate
					                                                            </label>
					                                                        </td>
					                                                        
						                                                    <td align="center">
						                                                        <label class="blackfnt">
						                                                            Transit Days
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center">
					                                                            <label class="blackfnt">
					                                                                FTL Rate
					                                                            </label>
					                                                        </td>
					                                                        
						                                                    <td align="center">
						                                                        <label class="blackfnt">
						                                                            Transit Days
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center">
					                                                            <label class="blackfnt">
					                                                                FTL Rate
					                                                            </label>
					                                                        </td>
					                                                        
						                                                    <td align="center">
						                                                        <label class="blackfnt">
						                                                            Transit Days
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center">
					                                                            <label class="blackfnt">
					                                                                FTL Rate
					                                                            </label>
					                                                        </td>
					                                                        
						                                                    <td align="center">
						                                                        <label class="blackfnt">
						                                                            Transit Days
						                                                        </label>
						                                                    </td>
						                                                </tr>
						                                                
						                                                <%--table row for Freight Matrix for Branch - Row 1--%>
					                                                    <tr id="Tr1" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRFromRoadForBranch1" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRFromRoadForBranch1" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRFromRoadForBranch1_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRFromRoadForBranch1" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRFromRoadForBranch1" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRToRoadForBranch1" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRToRoadForBranch1" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRToRoadForBranch1_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRToRoadForBranch1" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRToRoadForBranch1" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtFRRoadFTLType1RowForBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType1RowForBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType2RowForBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType2RowForBranch1" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType3RowForBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType3RowForBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType4RowForBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType4RowForBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType5RowForBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType5RowForBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
					                                                    
					                                                    <%--table row for Freight Matrix for Branch - Row 2--%>
					                                                    <tr id="Tr2" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRFromRoadForBranch2" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRFromRoadForBranch2" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRFromRoadForBranch2_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRFromRoadForBranch2" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRFromRoadForBranch2" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRToRoadForBranch2" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRToRoadForBranch2" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRToRoadForBranch2_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRToRoadForBranch2" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRToRoadForBranch2" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtFRRoadFTLType1RowForBranch2" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType1RowForBranch2" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType2RowForBranch2" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType2RowForBranch2" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType3RowForBranch2" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType3RowForBranch2" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType4RowForBranch2" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType4RowForBranch2" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType5RowForBranch2" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType5RowForBranch2" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
					                                                    
					                                                    <%--table row for Freight Matrix for Branch - Row 3--%>
					                                                    <tr id="Tr3" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRFromRoadForBranch3" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRFromRoadForBranch3" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRFromRoadForBranch3_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRFromRoadForBranch3" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRFromRoadForBranch3" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRToRoadForBranch3" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRToRoadForBranch3" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRToRoadForBranch3_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRToRoadForBranch3" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRToRoadForBranch3" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtFRRoadFTLType1RowForBranch3" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType1RowForBranch3" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType2RowForBranch3" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType2RowForBranch3" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType3RowForBranch3" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType3RowForBranch3" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType4RowForBranch3" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType4RowForBranch3" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType5RowForBranch3" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType5RowForBranch3" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
					                                                    
					                                                    <%--table row for Freight Matrix for Branch - Row 4--%>
					                                                    <tr id="Tr4" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRFromRoadForBranch4" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRFromRoadForBranch4" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRFromRoadForBranch4_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRFromRoadForBranch4" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRFromRoadForBranch4" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRToRoad4" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRToRoadForBranch4" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRToRoadForBranch4_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRToRoadForBranch4" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRToRoadForBranch4" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtFRRoadFTLType1RowForBranch4" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType1RowForBranch4" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType2RowForBranch4" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType2RowForBranch4" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType3RowForBranch4" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType3RowForBranch4" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType4RowForBranch4" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType4RowForBranch4" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType5RowForBranch4" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType5RowForBranch4" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
					                                                    
					                                                    <%--table row for Freight Matrix for Branch - Row 5--%>
					                                                    <tr id="Tr5" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRFromRoadForBranch5" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRFromRoadForBranch5" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRFromRoadForBranch5_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRFromRoadForBranch5" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRFromRoadForBranch5" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRToRoadForBranch5" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRToRoadForBranch5" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRToRoadForBranch5_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRToRoadForBranch5" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRToRoadForBranch5" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtFRRoadFTLType1RowForBranch5" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType1RowForBranch5" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType2RowForBranch5" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType2RowForBranch5" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType3RowForBranch5" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType3RowForBranch5" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType4RowForBranch5" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType4RowForBranch5" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType5RowForBranch5" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType5RowForBranch5" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
					                                                    
					                                                    <%--table row for Freight Matrix for Branch - Row 6--%>
					                                                    <tr id="Tr6" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRFromRoadForBranch6" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRFromRoadForBranch6" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRFromRoadForBranch6_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRFromRoadForBranch6" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRFromRoadForBranch6" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRToRoadForBranch6" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRToRoadForBranch6" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRToRoadForBranch6_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRToRoad6" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRToRoadForBranch6" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtFRRoadFTLType1RowForBranch6" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType1RowForBranch6" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType2RowForBranch6" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType2RowForBranch6" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType3RowForBranch6" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType3RowForBranch6" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType4RowForBranch6" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType4RowForBranch6" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType5RowForBranch6" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType5RowForBranch6" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
					                                                    
					                                                    <%--table row for Freight Matrix for Branch - Row 7--%>
					                                                    <tr id="Tr7" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRFromRoadForBranch7" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRFromRoadForBranch7" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRFromRoadForBranch7_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRFromRoadForBranch7" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRFromRoadForBranch7" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRToRoadForBranch7" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRToRoadForBranch7" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRToRoadForBranch7_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRToRoadForBranch7" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRToRoadForBranch7" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtFRRoadFTLType1RowForBranch7" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType1RowForBranch7" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType2RowForBranch7" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType2RowForBranch7" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType3RowForBranch7" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType3RowForBranch7" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType4RowForBranch7" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType4RowForBranch7" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType5RowForBranch7" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType5RowForBranch7" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
					                                                    
					                                                    <%--table row for Freight Matrix for Branch - Row 8--%>
					                                                    <tr id="Tr8" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRFromRoadForBranch8" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRFromRoadForBranch8" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRFromRoadForBranch8_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRFromRoadForBranch8" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRFromRoadForBranch8" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRToRoadForBranch8" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRToRoadForBranch8" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRToRoadForBranch8_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRToRoadForBranch8" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRToRoadForBranch8" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtFRRoadFTLType1RowForBranch8" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType1RowForBranch8" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType2RowForBranch8" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType2RowForBranch8" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType3RowForBranch8" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType3RowForBranch8" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType4RowForBranch8" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType4RowForBranch8" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType5RowForBranch8" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType5RowForBranch8" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
					                                                    
					                                                    <%--table row for Freight Matrix for Branch - Row 9--%>
					                                                    <tr id="Tr9" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRFromRoadForBranch9" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRFromRoadForBranch9" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRFromRoadForBranch9_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRFromRoadForBranch9" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRFromRoadForBranch9" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRToRoadForBranch9" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRToRoadForBranch9" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRToRoadForBranch9_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRToRoadForBranch9" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRToRoadForBranch9" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtFRRoadFTLType1RowForBranch9" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType1RowForBranch9" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType2RowForBranch9" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType2RowForBranch9" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType3RowForBranch9" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType3RowForBranch9" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType4RowForBranch9" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType4RowForBranch9" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType5RowForBranch9" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType5RowForBranch9" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
					                                                    
					                                                    <%--table row for Freight Matrix for Branch - Row 10--%>
					                                                    <tr id="Tr10" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRFromRoadForBranch10" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRFromRoadForBranch10" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRFromRoadForBranch10_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRFromRoadForBranch10" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRFromRoadForBranch10" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRToRoadForBranch10" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRToRoadForBranch10" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRToRoadForBranch10_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRToRoadForBranch10" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRToRoadForBranch10" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtFRRoadFTLType1RowForBranch10" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType1RowForBranch10" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType2RowForBranch10" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType2RowForBranch10" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType3RowForBranch10" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType3RowForBranch10" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType4RowForBranch10" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType4RowForBranch10" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType5RowForBranch10" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType5RowForBranch10" type="text" size="10" 
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
							                                                <td align="left">
							                                                    <label class="blackfnt">
							                                                        Branch:
							                                                    </label>
							                                                </td>
							                                                
								                                            <td align="left">
								                                                <asp:UpdatePanel ID="upBranchCodeExpress" runat="server">
								                                                    <ContentTemplate>
								                                                        <asp:TextBox ID="txtBranchCodeExpress" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtBranchCodeExpress_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
								                                                        <input type="button" value="..." runat="server" id="Button1" 
                                                                                            onclick="return BranchPopup('Branch_Popup.aspx?4')" />
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
			
			                                                        <table border="0" align="center" cellspacing="1" cellpadding="5" width="100%" class="boxbg">
				                                                        <tr style="background-color: White">
					                                                        <td align="center">
					                                                            <label class="blackfnt">
					                                                                From&nbsp;
						                                                            <input type="button" value="..." runat="server" id="btnBranchFromExpress" 
                                                                                        onclick="return BranchPopup('Branch_Popup_Multi_Selection.aspx?5')" />
					                                                            </label>
					                                                        </td>
					                                                        
						                                                    <td align="center">
						                                                        <label class="blackfnt">
						                                                            To&nbsp;
						                                                            <input type="button" value="..." runat="server" id="btnBranchToExpress" 
                                                                                        onclick="return BranchPopup('Branch_Popup_Multi_Selection.aspx?6')" />
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center" colspan="2">
						                                                        <label class="blackfnt">
						                                                            FTL Type1
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center" colspan="2">
						                                                        <label class="blackfnt">
						                                                            FTL Type2
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center" colspan="2">
						                                                        <label class="blackfnt">
						                                                            FTL Type3
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center" colspan="2">
						                                                        <label class="blackfnt">
						                                                            FTL Type4
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center" colspan="2">
						                                                        <label class="blackfnt">
						                                                            FTL Type5
						                                                        </label>
						                                                    </td>
						                                                </tr>
						                                                
						                                                <tr style="background-color: White">
					                                                        <td align="center">
					                                                            <label class="blackfnt">
					                                                                &nbsp;
					                                                            </label>
					                                                        </td>
					                                                        
						                                                    <td align="center">
						                                                        <label class="blackfnt">
						                                                            &nbsp;
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center" colspan="2">
						                                                        <asp:DropDownList ID="ddlFTLTypeExpressForBranch1" runat="server" CssClass="blackfnt"></asp:DropDownList>
						                                                    </td>
						                                                    
						                                                    <td align="center" colspan="2">
						                                                        <asp:DropDownList ID="ddlFTLTypeExpressForBranch2" runat="server" CssClass="blackfnt"></asp:DropDownList>
						                                                    </td>
						                                                    
						                                                    <td align="center" colspan="2">
						                                                        <asp:DropDownList ID="ddlFTLTypeExpressForBranch3" runat="server" CssClass="blackfnt"></asp:DropDownList>
						                                                    </td>
						                                                    
						                                                    <td align="center" colspan="2">
						                                                        <asp:DropDownList ID="ddlFTLTypeExpressForBranch4" runat="server" CssClass="blackfnt"></asp:DropDownList>
						                                                    </td>
						                                                    
						                                                    <td align="center" colspan="2">
						                                                        <asp:DropDownList ID="ddlFTLTypeExpressForBranch5" runat="server" CssClass="blackfnt"></asp:DropDownList>
						                                                    </td>
						                                                </tr>
						                                                
						                                                <tr style="background-color: White">
					                                                        <td align="center">
					                                                            <label class="blackfnt">
					                                                                &nbsp;
					                                                            </label>
					                                                        </td>
					                                                        
						                                                    <td align="center">
						                                                        <label class="blackfnt">
						                                                            &nbsp;
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center">
					                                                            <label class="blackfnt">
					                                                                FTL Rate
					                                                            </label>
					                                                        </td>
					                                                        
						                                                    <td align="center">
						                                                        <label class="blackfnt">
						                                                            Transit Days
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center">
					                                                            <label class="blackfnt">
					                                                                FTL Rate
					                                                            </label>
					                                                        </td>
					                                                        
						                                                    <td align="center">
						                                                        <label class="blackfnt">
						                                                            Transit Days
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center">
					                                                            <label class="blackfnt">
					                                                                FTL Rate
					                                                            </label>
					                                                        </td>
					                                                        
						                                                    <td align="center">
						                                                        <label class="blackfnt">
						                                                            Transit Days
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center">
					                                                            <label class="blackfnt">
					                                                                FTL Rate
					                                                            </label>
					                                                        </td>
					                                                        
						                                                    <td align="center">
						                                                        <label class="blackfnt">
						                                                            Transit Days
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center">
					                                                            <label class="blackfnt">
					                                                                FTL Rate
					                                                            </label>
					                                                        </td>
					                                                        
						                                                    <td align="center">
						                                                        <label class="blackfnt">
						                                                            Transit Days
						                                                        </label>
						                                                    </td>
						                                                </tr>
						                                                
						                                                <%--table row for Freight Matrix for Branch - Row 1--%>
					                                                    <tr id="Tr31" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRFromExpressForBranch1" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRFromExpressForBranch1" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRFromExpressForBranch1_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRFromExpressForBranch1" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRFromExpressForBranch1" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRToExpressForBranch1" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRToExpressForBranch1" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRToExpressForBranch1_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRToExpressForBranch1" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRToExpressForBranch1" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtFRExpressFTLType1RowForBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType1RowForBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType2RowForBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType2RowForBranch1" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType3RowForBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType3RowForBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType4RowForBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType4RowForBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType5RowForBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType5RowForBranch1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
					                                                    
					                                                    <%--table row for Freight Matrix for Branch - Row 2--%>
					                                                    <tr id="Tr32" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRFromExpressForBranch2" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRFromExpressForBranch2" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRFromExpressForBranch2_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRFromExpressForBranch2" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRFromExpressForBranch2" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRToExpressForBranch2" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRToExpressForBranch2" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRToExpressForBranch2_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRToExpressForBranch2" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRToExpressForBranch2" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtFRExpressFTLType1RowForBranch2" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType1RowForBranch2" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType2RowForBranch2" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType2RowForBranch2" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType3RowForBranch2" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType3RowForBranch2" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType4RowForBranch2" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType4RowForBranch2" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType5RowForBranch2" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType5RowForBranch2" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
					                                                    
					                                                    <%--table row for Freight Matrix for Branch - Row 3--%>
					                                                    <tr id="Tr33" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRFromExpressForBranch3" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRFromExpressForBranch3" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRFromExpressForBranch3_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRFromExpressForBranch3" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRFromExpressForBranch3" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRToExpressForBranch3" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRToExpressForBranch3" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRToExpressForBranch3_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRToExpressForBranch3" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRToExpressForBranch3" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtFRExpressFTLType1RowForBranch3" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType1RowForBranch3" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType2RowForBranch3" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType2RowForBranch3" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType3RowForBranch3" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType3RowForBranch3" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType4RowForBranch3" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType4RowForBranch3" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType5RowForBranch3" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType5RowForBranch3" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
					                                                    
					                                                    <%--table row for Freight Matrix for Branch - Row 4--%>
					                                                    <tr id="Tr34" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRFromExpressForBranch4" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRFromExpressForBranch4" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRFromExpressForBranch4_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRFromExpressForBranch4" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRFromExpressForBranch4" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRToExpressForBranch4" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRToExpressForBranch4" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRToExpressForBranch4_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRToExpressForBranch4" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRToExpressForBranch4" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtFRExpressFTLType1RowForBranch4" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType1RowForBranch4" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType2RowForBranch4" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType2RowForBranch4" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType3RowForBranch4" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType3RowForBranch4" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType4RowForBranch4" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType4RowForBranch4" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType5RowForBranch4" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType5RowForBranch4" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
					                                                    
					                                                    <%--table row for Freight Matrix for Branch - Row 5--%>
					                                                    <tr id="Tr35" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRFromExpressForBranch5" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRFromExpressForBranch5" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRFromExpressForBranch5_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRFromExpressForBranch5" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRFromExpressForBranch5" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRToExpressForBranch5" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRToExpressForBranch5" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRToExpressForBranch5_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRToExpressForBranch5" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRToExpressForBranch5" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtFRExpressFTLType1RowForBranch5" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType1RowForBranch5" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType2RowForBranch5" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType2RowForBranch5" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType3RowForBranch5" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType3RowForBranch5" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType4RowForBranch5" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType4RowForBranch5" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType5RowForBranch5" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType5RowForBranch5" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
					                                                    
					                                                    <%--table row for Freight Matrix for Branch - Row 6--%>
					                                                    <tr id="Tr36" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRFromExpressForBranch6" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRFromExpressForBranch6" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRFromExpressForBranch6_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRFromExpressForBranch6" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRFromExpressForBranch6" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRToExpressForBranch6" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRToExpressForBranch6" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRToExpressForBranch6_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRToExpressForBranch6" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRToExpressForBranch6" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtFRExpressFTLType1RowForBranch6" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType1RowForBranch6" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType2RowForBranch6" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType2RowForBranch6" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType3RowForBranch6" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType3RowForBranch6" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType4RowForBranch6" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType4RowForBranch6" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType5RowForBranch6" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType5RowForBranch6" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
					                                                    
					                                                    <%--table row for Freight Matrix for Branch - Row 7--%>
					                                                    <tr id="Tr37" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRFromExpressForBranch7" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRFromExpressForBranch7" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRFromExpressForBranch7_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRFromExpressForBranch7" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRFromExpressForBranch7" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRToExpressForBranch7" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRToExpressForBranch7" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRToExpressForBranch7_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRToExpressForBranch7" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRToExpressForBranch7" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtFRExpressFTLType1RowForBranch7" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType1RowForBranch7" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType2RowForBranch7" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType2RowForBranch7" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType3RowForBranch7" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType3RowForBranch7" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType4RowForBranch7" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType4RowForBranch7" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType5RowForBranch7" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType5RowForBranch7" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
					                                                    
					                                                    <%--table row for Freight Matrix for Branch - Row 8--%>
					                                                    <tr id="Tr38" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRFromExpressForBranch8" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRFromExpressForBranch8" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRFromExpressForBranch8_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRFromExpressForBranch8" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRFromExpressForBranch8" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRToExpressForBranch8" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRToExpressForBranch8" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRToExpressForBranch8_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRToExpressForBranch8" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRToExpressForBranch8" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtFRExpressFTLType1RowForBranch8" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType1RowForBranch8" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType2RowForBranch8" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType2RowForBranch8" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType3RowForBranch8" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType3RowForBranch8" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType4RowForBranch8" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType4RowForBranch8" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType5RowForBranch8" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType5RowForBranch8" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
					                                                    
					                                                    <%--table row for Freight Matrix for Branch - Row 9--%>
					                                                    <tr id="Tr39" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRFromExpressForBranch9" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRFromExpressForBranch9" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRFromExpressForBranch9_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRFromExpressForBranch9" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRFromExpressForBranch9" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRToExpressForBranch9" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRToExpressForBranch9" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRToExpressForBranch9_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRToExpressForBranch9" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRToExpressForBranch9" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtFRExpressFTLType1RowForBranch9" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType1RowForBranch9" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType2RowForBranch9" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType2RowForBranch9" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType3RowForBranch9" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType3RowForBranch9" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType4RowForBranch9" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType4RowForBranch9" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType5RowForBranch9" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType5RowForBranch9" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
					                                                    
					                                                    <%--table row for Freight Matrix for Branch - Row 10--%>
					                                                    <tr id="Tr40" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRFromExpressForBranch10" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRFromExpressForBranch10" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRFromExpressForBranch10_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRFromExpressForBranch10" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRFromExpressForBranch10" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <asp:UpdatePanel ID="upFRToExpressForBranch10" runat="server">
								                                                    <ContentTemplate>
					                                                                    <asp:TextBox ID="txtFRToExpressForBranch10" runat="server" MaxLength="4" 
								                                                            OnTextChanged="txtFRToExpressForBranch10_TextChanged" CssClass="input" 
								                                                            AutoPostBack="true" Width="40px" style="margin-left: 5px;">
								                                                        </asp:TextBox>
                                                                                        <label class="blackfnt" id="lblErrorFRToExpressForBranch10" runat="server" style="color: Red;" visible="false">
                                                                                            &nbsp;Invalid Branch Code!!!
                                                                                        </label>
                                                                                    </ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="txtFRToExpressForBranch10" EventName="TextChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtFRExpressFTLType1RowForBranch10" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType1RowForBranch10" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType2RowForBranch10" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType2RowForBranch10" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType3RowForBranch10" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType3RowForBranch10" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType4RowForBranch10" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType4RowForBranch10" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRExpressFTLType5RowForBranch10" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysExpressFTLType5RowForBranch10" type="text" size="10" 
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
							                                                <td align="left">
							                                                    <label class="blackfnt">
							                                                        Zone:
							                                                    </label>
							                                                </td>
							                                                
								                                            <td align="left">
								                                                <%--<asp:UpdatePanel ID="upZoneHeaderRoad" runat="server">
								                                                    <ContentTemplate>--%>
								                                                        <label style="margin-left: 5px;">
	                                                                                    </label>
							                                                            <asp:DropDownList ID="ddlZoneHeaderRoad" runat="server" CssClass="blackfnt" >
							                                                            </asp:DropDownList>        
								                                                    <%--</ContentTemplate>
								                                                    <Triggers>
								                                                        <asp:AsyncPostBackTrigger ControlID="ddlZoneHeaderRoad" EventName="SelectedIndexChanged" />
								                                                    </Triggers>
								                                                </asp:UpdatePanel>--%>
								                                            </td>
							                                            </tr>
							                                        </table>
							                                        
							                                        <br style="font-size: 6pt;" />
							                                        
							                                        <table border="0" align="center" cellspacing="1" cellpadding="5" width="100%" class="boxbg">
				                                                        <tr style="background-color: White">
					                                                        <td align="center">
					                                                            <label class="blackfnt">
					                                                                &nbsp;
					                                                            </label>
					                                                        </td>
					                                                        
						                                                    <td align="center">
						                                                        <label class="blackfnt">
						                                                            &nbsp;
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center" colspan="2">
						                                                        <label class="blackfnt">
						                                                            FTL Type1
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center" colspan="2">
						                                                        <label class="blackfnt">
						                                                            FTL Type2
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center" colspan="2">
						                                                        <label class="blackfnt">
						                                                            FTL Type3
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center" colspan="2">
						                                                        <label class="blackfnt">
						                                                            FTL Type4
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center" colspan="2">
						                                                        <label class="blackfnt">
						                                                            FTL Type5
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
						                                                    
						                                                    <td align="center" colspan="2">
						                                                        <asp:DropDownList ID="ddlFTLTypeRoadForZone1" runat="server" CssClass="blackfnt"></asp:DropDownList>
						                                                    </td>
						                                                    
						                                                    <td align="center" colspan="2">
						                                                        <asp:DropDownList ID="ddlFTLTypeRoadForZone2" runat="server" CssClass="blackfnt"></asp:DropDownList>
						                                                    </td>
						                                                    
						                                                    <td align="center" colspan="2">
						                                                        <asp:DropDownList ID="ddlFTLTypeRoadForZone3" runat="server" CssClass="blackfnt"></asp:DropDownList>
						                                                    </td>
						                                                    
						                                                    <td align="center" colspan="2">
						                                                        <asp:DropDownList ID="ddlFTLTypeRoadForZone4" runat="server" CssClass="blackfnt"></asp:DropDownList>
						                                                    </td>
						                                                    
						                                                    <td align="center" colspan="2">
						                                                        <asp:DropDownList ID="ddlFTLTypeRoadForZone5" runat="server" CssClass="blackfnt"></asp:DropDownList>
						                                                    </td>
						                                                </tr>
						                                                
						                                                <tr style="background-color: White">
					                                                        <td align="center">
					                                                            <label class="blackfnt">
					                                                                &nbsp;
					                                                            </label>
					                                                        </td>
					                                                        
						                                                    <td align="center">
						                                                        <label class="blackfnt">
						                                                            &nbsp;
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center">
					                                                            <label class="blackfnt">
					                                                                FTL Rate
					                                                            </label>
					                                                        </td>
					                                                        
						                                                    <td align="center">
						                                                        <label class="blackfnt">
						                                                            Transit Days
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center">
					                                                            <label class="blackfnt">
					                                                                FTL Rate
					                                                            </label>
					                                                        </td>
					                                                        
						                                                    <td align="center">
						                                                        <label class="blackfnt">
						                                                            Transit Days
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center">
					                                                            <label class="blackfnt">
					                                                                FTL Rate
					                                                            </label>
					                                                        </td>
					                                                        
						                                                    <td align="center">
						                                                        <label class="blackfnt">
						                                                            Transit Days
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center">
					                                                            <label class="blackfnt">
					                                                                FTL Rate
					                                                            </label>
					                                                        </td>
					                                                        
						                                                    <td align="center">
						                                                        <label class="blackfnt">
						                                                            Transit Days
						                                                        </label>
						                                                    </td>
						                                                    
						                                                    <td align="center">
					                                                            <label class="blackfnt">
					                                                                FTL Rate
					                                                            </label>
					                                                        </td>
					                                                        
						                                                    <td align="center">
						                                                        <label class="blackfnt">
						                                                            Transit Days
						                                                        </label>
						                                                    </td>
						                                                </tr>
						                                                
						                                                <%--table row for Freight Matrix for Branch - Row 1--%>
					                                                    <tr id="Tr41" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                           <label style="margin-left: 5px;">
                                                                                </label>
					                                                            <asp:DropDownList ID="ddlZoneRoadFromForRow1" runat="server" CssClass="blackfnt">
					                                                            </asp:DropDownList> 
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <label style="margin-left: 5px;">
                                                                                </label>
					                                                            <asp:DropDownList ID="ddlZoneRoadToForRow1" runat="server" CssClass="blackfnt">
					                                                            </asp:DropDownList>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtFRRoadFTLType1RowForZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType1RowForZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType2RowForZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType2RowForZone1" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType3RowForZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType3RowForZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType4RowForZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType4RowForZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType5RowForZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType5RowForZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
					                                                    
					                                                    <%--table row for Freight Matrix for Zone - Row 2--%>
					                                                    <tr id="Tr42" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                           <label style="margin-left: 5px;">
                                                                                </label>
					                                                            <asp:DropDownList ID="ddlZoneRoadFromForRow2" runat="server" CssClass="blackfnt">
					                                                            </asp:DropDownList> 
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <label style="margin-left: 5px;">
                                                                                </label>
					                                                            <asp:DropDownList ID="ddlZoneRoadToForRow2" runat="server" CssClass="blackfnt">
					                                                            </asp:DropDownList>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtFRRoadFTLType1RowForZone2" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType1RowForZone2" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType2RowForZone2" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType2RowForZone2" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType3RowForZone2" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType3RowForZone2" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType4RowForZone2" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType4RowForZone2" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType5RowForZone2" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType5RowForZone2" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
					                                                    
					                                                    <%--table row for Freight Matrix for Zone - Row 3--%>
					                                                    <tr id="Tr43" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                           <label style="margin-left: 5px;">
                                                                                </label>
					                                                            <asp:DropDownList ID="ddlZoneRoadFromForRow3" runat="server" CssClass="blackfnt">
					                                                            </asp:DropDownList> 
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <label style="margin-left: 5px;">
                                                                                </label>
					                                                            <asp:DropDownList ID="ddlZoneRoadToForRow3" runat="server" CssClass="blackfnt">
					                                                            </asp:DropDownList>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtFRRoadFTLType1RowForZone3" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType1RowForZone3" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType2RowForZone3" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType2RowForZone3" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType3RowForZone3" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType3RowForZone3" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType4RowForZone3" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType4RowForZone3" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType5RowForZone3" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType5RowForZone3" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
					                                                    
					                                                    <%--table row for Freight Matrix for Zone - Row 4--%>
					                                                    <tr id="Tr44" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                           <label style="margin-left: 5px;">
                                                                                </label>
					                                                            <asp:DropDownList ID="ddlZoneRoadFromForRow4" runat="server" CssClass="blackfnt">
					                                                            </asp:DropDownList> 
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <label style="margin-left: 5px;">
                                                                                </label>
					                                                            <asp:DropDownList ID="ddlZoneRoadToForRow4" runat="server" CssClass="blackfnt">
					                                                            </asp:DropDownList>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtFRRoadFTLType1RowForZone4" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType1RowForZone4" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType2RowForZone4" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType2RowForZone4" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType3RowForZone4" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType3RowForZone4" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType4RowForZone4" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType4RowForZone4" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType5RowForZone4" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType5RowForZone4" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
					                                                    
					                                                    <%--table row for Freight Matrix for Zone - Row 5--%>
                                                                        <tr id="Tr45" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                           <label style="margin-left: 5px;">
                                                                                </label>
					                                                            <asp:DropDownList ID="ddlZoneRoadFromForRow5" runat="server" CssClass="blackfnt">
					                                                            </asp:DropDownList> 
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <label style="margin-left: 5px;">
                                                                                </label>
					                                                            <asp:DropDownList ID="ddlZoneRoadToForRow5" runat="server" CssClass="blackfnt">
					                                                            </asp:DropDownList>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtFRRoadFTLType1RowForZone5" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType1RowForZone5" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType2RowForZone5" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType2RowForZone5" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType3RowForZone5" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType3RowForZone5" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType4RowForZone5" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType4RowForZone5" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType5RowForZone5" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType5RowForZone5" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
					                                                    
					                                                    <%--table row for Freight Matrix for Zone - Row 6--%>
                                                                        <tr id="Tr46" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                           <label style="margin-left: 5px;">
                                                                                </label>
					                                                            <asp:DropDownList ID="ddlZoneRoadFromForRow6" runat="server" CssClass="blackfnt">
					                                                            </asp:DropDownList> 
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <label style="margin-left: 5px;">
                                                                                </label>
					                                                            <asp:DropDownList ID="ddlZoneRoadToForRow6" runat="server" CssClass="blackfnt">
					                                                            </asp:DropDownList>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtFRRoadFTLType1RowForZone6" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType1RowForZone6" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType2RowForZone6" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType2RowForZone6" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType3RowForZone6" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType3RowForZone6" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType4RowForZone6" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType4RowForZone6" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType5RowForZone6" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType5RowForZone6" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
					                                                    
					                                                    <%--table row for Freight Matrix for Zone - Row 7--%>
                                                                        <tr id="Tr47" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                           <label style="margin-left: 5px;">
                                                                                </label>
					                                                            <asp:DropDownList ID="ddlZoneRoadFromForRow7" runat="server" CssClass="blackfnt">
					                                                            </asp:DropDownList> 
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <label style="margin-left: 5px;">
                                                                                </label>
					                                                            <asp:DropDownList ID="ddlZoneRoadToForRow7" runat="server" CssClass="blackfnt">
					                                                            </asp:DropDownList>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtFRRoadFTLType1RowForZone7" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType1RowForZone7" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType2RowForZone7" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType2RowForZone7" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType3RowForZone7" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType3RowForZone7" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType4RowForZone7" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType4RowForZone7" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType5RowForZone7" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType5RowForZone7" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
					                                                    
					                                                    <%--table row for Freight Matrix for Zone - Row 8--%>
                                                                        <tr id="Tr48" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                           <label style="margin-left: 5px;">
                                                                                </label>
					                                                            <asp:DropDownList ID="ddlZoneRoadFromForRow8" runat="server" CssClass="blackfnt">
					                                                            </asp:DropDownList> 
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <label style="margin-left: 5px;">
                                                                                </label>
					                                                            <asp:DropDownList ID="ddlZoneRoadToForRow8" runat="server" CssClass="blackfnt">
					                                                            </asp:DropDownList>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtFRRoadFTLType1RowForZone8" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType1RowForZone8" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType2RowForZone8" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType2RowForZone8" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType3RowForZone8" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType3RowForZone8" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType4RowForZone8" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType4RowForZone8" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType5RowForZone8" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType5RowForZone8" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
					                                                    
					                                                    <%--table row for Freight Matrix for Zone - Row 9--%>
                                                                        <tr id="Tr49" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                           <label style="margin-left: 5px;">
                                                                                </label>
					                                                            <asp:DropDownList ID="ddlZoneRoadFromForRow9" runat="server" CssClass="blackfnt">
					                                                            </asp:DropDownList> 
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <label style="margin-left: 5px;">
                                                                                </label>
					                                                            <asp:DropDownList ID="ddlZoneRoadToForRow9" runat="server" CssClass="blackfnt">
					                                                            </asp:DropDownList>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtFRRoadFTLType1RowForZone9" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType1RowForZone9" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType2RowForZone9" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType2RowForZone9" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType3RowForZone9" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType3RowForZone9" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType4RowForZone9" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType4RowForZone9" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType5RowForZone9" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType5RowForZone9" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
					                                                    </tr>
					                                                    
					                                                    <%--table row for Freight Matrix for Zone - Row 10--%>
                                                                        <tr id="Tr50" runat="server" style="background-color: White">
					                                                        <td align="center">
					                                                           <label style="margin-left: 5px;">
                                                                                </label>
					                                                            <asp:DropDownList ID="ddlZoneRoadFromForRow10" runat="server" CssClass="blackfnt">
					                                                            </asp:DropDownList> 
					                                                        </td>    
					                                                        
					                                                        <td align="center">
					                                                            <label style="margin-left: 5px;">
                                                                                </label>
					                                                            <asp:DropDownList ID="ddlZoneRoadToForRow10" runat="server" CssClass="blackfnt">
					                                                            </asp:DropDownList>
					                                                        </td>
					                                                        
					                                                        <td align="center">
						                                                        <input id="txtFRRoadFTLType1RowForZone10" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType1RowForZone10" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType2RowForZone10" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType2RowForZone10" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType3RowForZone10" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType3RowForZone10" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType4RowForZone10" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType4RowForZone10" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtFRRoadFTLType5RowForZone10" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
						                                                    </td>
						                                                    
						                                                    <td align="center">
						                                                        <input id="txtTrDaysRoadFTLType5RowForZone10" type="text" size="10" 
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
				                                                            <td align="left">
				                                                                <label class="blackfnt">
				                                                                    Zone:
				                                                                </label>
				                                                            </td>
							                                                
					                                                        <td align="left">
					                                                            <%--<asp:UpdatePanel ID="upZoneHeaderExpress" runat="server">
					                                                                <ContentTemplate>--%>
					                                                                    <label style="margin-left: 5px;">
                                                                                        </label>
				                                                                        <asp:DropDownList ID="ddlZoneHeaderExpress" runat="server" CssClass="blackfnt" >
				                                                                        </asp:DropDownList>        
					                                                                <%--</ContentTemplate>
					                                                                <Triggers>
					                                                                    <asp:AsyncPostBackTrigger ControlID="ddlZoneHeaderExpress" EventName="SelectedIndexChanged" />
					                                                                </Triggers>
					                                                            </asp:UpdatePanel>--%>
					                                                        </td>
				                                                        </tr>
				                                                    </table>
								                                        
				                                                    <br style="font-size: 6pt;" />
					                                        
				                                                    <table border="0" align="center" cellspacing="1" cellpadding="5" width="100%" class="boxbg">
	                                                                    <tr style="background-color: White">
		                                                                    <td align="center">
		                                                                        <label class="blackfnt">
		                                                                            &nbsp;
		                                                                        </label>
		                                                                    </td>
					                                                        
			                                                                <td align="center">
			                                                                    <label class="blackfnt">
			                                                                        &nbsp;
			                                                                    </label>
			                                                                </td>
						                                                    
			                                                                <td align="center" colspan="2">
			                                                                    <label class="blackfnt">
			                                                                        FTL Type1
			                                                                    </label>
			                                                                </td>
						                                                    
			                                                                <td align="center" colspan="2">
			                                                                    <label class="blackfnt">
			                                                                        FTL Type2
			                                                                    </label>
			                                                                </td>
						                                                    
			                                                                <td align="center" colspan="2">
			                                                                    <label class="blackfnt">
			                                                                        FTL Type3
			                                                                    </label>
			                                                                </td>
						                                                    
			                                                                <td align="center" colspan="2">
			                                                                    <label class="blackfnt">
			                                                                        FTL Type4
			                                                                    </label>
			                                                                </td>
						                                                    
			                                                                <td align="center" colspan="2">
			                                                                    <label class="blackfnt">
			                                                                        FTL Type5
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
						                                                    
			                                                                <td align="center" colspan="2">
			                                                                    <asp:DropDownList ID="ddlFTLTypeExpressForZone1" runat="server" CssClass="blackfnt"></asp:DropDownList>
			                                                                </td>
						                                                    
			                                                                <td align="center" colspan="2">
			                                                                    <asp:DropDownList ID="ddlFTLTypeExpressForZone2" runat="server" CssClass="blackfnt"></asp:DropDownList>
			                                                                </td>
						                                                    
			                                                                <td align="center" colspan="2">
			                                                                    <asp:DropDownList ID="ddlFTLTypeExpressForZone3" runat="server" CssClass="blackfnt"></asp:DropDownList>
			                                                                </td>
						                                                    
			                                                                <td align="center" colspan="2">
			                                                                    <asp:DropDownList ID="ddlFTLTypeExpressForZone4" runat="server" CssClass="blackfnt"></asp:DropDownList>
			                                                                </td>
						                                                    
			                                                                <td align="center" colspan="2">
			                                                                    <asp:DropDownList ID="ddlFTLTypeExpressForZone5" runat="server" CssClass="blackfnt"></asp:DropDownList>
			                                                                </td>
			                                                            </tr>
        							                                                
			                                                            <tr style="background-color: White">
		                                                                    <td align="center">
		                                                                        <label class="blackfnt">
		                                                                            &nbsp;
		                                                                        </label>
		                                                                    </td>
					                                                        
			                                                                <td align="center">
			                                                                    <label class="blackfnt">
			                                                                        &nbsp;
			                                                                    </label>
			                                                                </td>
						                                                    
			                                                                <td align="center">
		                                                                        <label class="blackfnt">
		                                                                            FTL Rate
		                                                                        </label>
		                                                                    </td>
					                                                        
			                                                                <td align="center">
			                                                                    <label class="blackfnt">
			                                                                        Transit Days
			                                                                    </label>
			                                                                </td>
						                                                    
			                                                                <td align="center">
		                                                                        <label class="blackfnt">
		                                                                            FTL Rate
		                                                                        </label>
		                                                                    </td>
					                                                        
			                                                                <td align="center">
			                                                                    <label class="blackfnt">
			                                                                        Transit Days
			                                                                    </label>
			                                                                </td>
						                                                    
			                                                                <td align="center">
		                                                                        <label class="blackfnt">
		                                                                            FTL Rate
		                                                                        </label>
		                                                                    </td>
					                                                        
			                                                                <td align="center">
			                                                                    <label class="blackfnt">
			                                                                        Transit Days
			                                                                    </label>
			                                                                </td>
						                                                    
			                                                                <td align="center">
		                                                                        <label class="blackfnt">
		                                                                            FTL Rate
		                                                                        </label>
		                                                                    </td>
					                                                        
			                                                                <td align="center">
			                                                                    <label class="blackfnt">
			                                                                        Transit Days
			                                                                    </label>
			                                                                </td>
						                                                    
			                                                                <td align="center">
		                                                                        <label class="blackfnt">
		                                                                            FTL Rate
		                                                                        </label>
		                                                                    </td>
					                                                        
			                                                                <td align="center">
			                                                                    <label class="blackfnt">
			                                                                        Transit Days
			                                                                    </label>
			                                                                </td>
			                                                            </tr>
							                                                
			                                                            <%--table row for Freight Matrix for Branch - Row 1--%>
		                                                                <tr id="Tr11" runat="server" style="background-color: White">
		                                                                    <td align="center">
		                                                                       <label style="margin-left: 5px;">
                                                                                </label>
		                                                                        <asp:DropDownList ID="ddlZoneExpressFromForRow1" runat="server" CssClass="blackfnt">
		                                                                        </asp:DropDownList> 
		                                                                    </td>    
					                                                        
		                                                                    <td align="center">
		                                                                        <label style="margin-left: 5px;">
                                                                                </label>
		                                                                        <asp:DropDownList ID="ddlZoneExpressToForRow1" runat="server" CssClass="blackfnt">
		                                                                        </asp:DropDownList>
		                                                                    </td>
					                                                        
		                                                                    <td align="center">
			                                                                    <input id="txtFRExpressFTLType1RowForZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
			                                                                </td>
						                                                    
			                                                                <td align="center">
			                                                                    <input id="txtTrDaysExpressFTLType1RowForZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
			                                                                </td>
						                                                    
			                                                                <td align="center">
			                                                                    <input id="txtFRExpressFTLType2RowForZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
			                                                                </td>
						                                                    
			                                                                <td align="center">
			                                                                    <input id="txtTrDaysExpressFTLType2RowForZone1" type="text" size="10"  
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
			                                                                </td>
						                                                    
			                                                                <td align="center">
			                                                                    <input id="txtFRExpressFTLType3RowForZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
			                                                                </td>
						                                                    
			                                                                <td align="center">
			                                                                    <input id="txtTrDaysExpressFTLType3RowForZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
			                                                                </td>
						                                                    
			                                                                <td align="center">
			                                                                    <input id="txtFRExpressFTLType4RowForZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
			                                                                </td>
						                                                    
			                                                                <td align="center">
			                                                                    <input id="txtTrDaysExpressFTLType4RowForZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
			                                                                </td>
						                                                    
			                                                                <td align="center">
			                                                                    <input id="txtFRExpressFTLType5RowForZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
			                                                                </td>
						                                                    
			                                                                <td align="center">
			                                                                    <input id="txtTrDaysExpressFTLType5RowForZone1" type="text" size="10" 
                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                    style="margin-left: 5px;" runat="server" />
			                                                                </td>
		                                                                </tr>
						                                                    
					                                                                <%--table row for Freight Matrix for Zone - Row 2--%>
					                                                                <tr id="Tr12" runat="server" style="background-color: White">
					                                                                    <td align="center">
					                                                                       <label style="margin-left: 5px;">
                                                                                            </label>
					                                                                        <asp:DropDownList ID="ddlZoneExpressFromForRow2" runat="server" CssClass="blackfnt">
					                                                                        </asp:DropDownList> 
					                                                                    </td>    
        						                                                        
					                                                                    <td align="center">
					                                                                        <label style="margin-left: 5px;">
                                                                                            </label>
					                                                                        <asp:DropDownList ID="ddlZoneExpressToForRow2" runat="server" CssClass="blackfnt">
					                                                                        </asp:DropDownList>
					                                                                    </td>
        						                                                        
					                                                                    <td align="center">
						                                                                    <input id="txtFRExpressFTLType1RowForZone2" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType1RowForZone2" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType2RowForZone2" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType2RowForZone2" type="text" size="10"  
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType3RowForZone2" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType3RowForZone2" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType4RowForZone2" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType4RowForZone2" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType5RowForZone2" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType5RowForZone2" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
					                                                                </tr>
						                                                    
					                                                                <%--table row for Freight Matrix for Zone - Row 3--%>
					                                                                <tr id="Tr13" runat="server" style="background-color: White">
					                                                                    <td align="center">
					                                                                       <label style="margin-left: 5px;">
                                                                                            </label>
					                                                                        <asp:DropDownList ID="ddlZoneExpressFromForRow3" runat="server" CssClass="blackfnt">
					                                                                        </asp:DropDownList> 
					                                                                    </td>    
        						                                                        
					                                                                    <td align="center">
					                                                                        <label style="margin-left: 5px;">
                                                                                            </label>
					                                                                        <asp:DropDownList ID="ddlZoneExpressToForRow3" runat="server" CssClass="blackfnt">
					                                                                        </asp:DropDownList>
					                                                                    </td>
        						                                                        
					                                                                    <td align="center">
						                                                                    <input id="txtFRExpressFTLType1RowForZone3" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType1RowForZone3" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType2RowForZone3" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType2RowForZone3" type="text" size="10"  
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType3RowForZone3" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType3RowForZone3" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType4RowForZone3" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType4RowForZone3" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType5RowForZone3" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType5RowForZone3" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
					                                                                </tr>
						                                                    
					                                                                <%--table row for Freight Matrix for Zone - Row 4--%>
					                                                                <tr id="Tr14" runat="server" style="background-color: White">
					                                                                    <td align="center">
					                                                                       <label style="margin-left: 5px;">
                                                                                            </label>
					                                                                        <asp:DropDownList ID="ddlZoneExpressFromForRow4" runat="server" CssClass="blackfnt">
					                                                                        </asp:DropDownList> 
					                                                                    </td>    
        						                                                        
					                                                                    <td align="center">
					                                                                        <label style="margin-left: 5px;">
                                                                                            </label>
					                                                                        <asp:DropDownList ID="ddlZoneExpressToForRow4" runat="server" CssClass="blackfnt">
					                                                                        </asp:DropDownList>
					                                                                    </td>
        						                                                        
					                                                                    <td align="center">
						                                                                    <input id="txtFRExpressFTLType1RowForZone4" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType1RowForZone4" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType2RowForZone4" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType2RowForZone4" type="text" size="10"  
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType3RowForZone4" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType3RowForZone4" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType4RowForZone4" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType4RowForZone4" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType5RowForZone4" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType5RowForZone4" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
					                                                                </tr>
						                                                    
					                                                                <%--table row for Freight Matrix for Zone - Row 5--%>
                                                                                    <tr id="Tr15" runat="server" style="background-color: White">
					                                                                    <td align="center">
					                                                                       <label style="margin-left: 5px;">
                                                                                            </label>
					                                                                        <asp:DropDownList ID="ddlZoneExpressFromForRow5" runat="server" CssClass="blackfnt">
					                                                                        </asp:DropDownList> 
					                                                                    </td>    
        						                                                        
					                                                                    <td align="center">
					                                                                        <label style="margin-left: 5px;">
                                                                                            </label>
					                                                                        <asp:DropDownList ID="ddlZoneExpressToForRow5" runat="server" CssClass="blackfnt">
					                                                                        </asp:DropDownList>
					                                                                    </td>
        						                                                        
					                                                                    <td align="center">
						                                                                    <input id="txtFRExpressFTLType1RowForZone5" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType1RowForZone5" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType2RowForZone5" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType2RowForZone5" type="text" size="10"  
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType3RowForZone5" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType3RowForZone5" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType4RowForZone5" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType4RowForZone5" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType5RowForZone5" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType5RowForZone5" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
					                                                                </tr>
						                                                    
					                                                                <%--table row for Freight Matrix for Zone - Row 6--%>
                                                                                    <tr id="Tr16" runat="server" style="background-color: White">
					                                                                    <td align="center">
					                                                                       <label style="margin-left: 5px;">
                                                                                            </label>
					                                                                        <asp:DropDownList ID="ddlZoneExpressFromForRow6" runat="server" CssClass="blackfnt">
					                                                                        </asp:DropDownList> 
					                                                                    </td>    
        						                                                        
					                                                                    <td align="center">
					                                                                        <label style="margin-left: 5px;">
                                                                                            </label>
					                                                                        <asp:DropDownList ID="ddlZoneExpressToForRow6" runat="server" CssClass="blackfnt">
					                                                                        </asp:DropDownList>
					                                                                    </td>
        						                                                        
					                                                                    <td align="center">
						                                                                    <input id="txtFRExpressFTLType1RowForZone6" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType1RowForZone6" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType2RowForZone6" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType2RowForZone6" type="text" size="10"  
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType3RowForZone6" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType3RowForZone6" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType4RowForZone6" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType4RowForZone6" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType5RowForZone6" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType5RowForZone6" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
					                                                                </tr>
						                                                    
					                                                                <%--table row for Freight Matrix for Zone - Row 7--%>
                                                                                    <tr id="Tr17" runat="server" style="background-color: White">
					                                                                    <td align="center">
					                                                                       <label style="margin-left: 5px;">
                                                                                            </label>
					                                                                        <asp:DropDownList ID="ddlZoneExpressFromForRow7" runat="server" CssClass="blackfnt">
					                                                                        </asp:DropDownList> 
					                                                                    </td>    
        						                                                        
					                                                                    <td align="center">
					                                                                        <label style="margin-left: 5px;">
                                                                                            </label>
					                                                                        <asp:DropDownList ID="ddlZoneExpressToForRow7" runat="server" CssClass="blackfnt">
					                                                                        </asp:DropDownList>
					                                                                    </td>
        						                                                        
					                                                                    <td align="center">
						                                                                    <input id="txtFRExpressFTLType1RowForZone7" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType1RowForZone7" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType2RowForZone7" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType2RowForZone7" type="text" size="10"  
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType3RowForZone7" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType3RowForZone7" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType4RowForZone7" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType4RowForZone7" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType5RowForZone7" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType5RowForZone7" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
					                                                                </tr>
						                                                    
					                                                                <%--table row for Freight Matrix for Zone - Row 8--%>
                                                                                    <tr id="Tr18" runat="server" style="background-color: White">
					                                                                    <td align="center">
					                                                                       <label style="margin-left: 5px;">
                                                                                            </label>
					                                                                        <asp:DropDownList ID="ddlZoneExpressFromForRow8" runat="server" CssClass="blackfnt">
					                                                                        </asp:DropDownList> 
					                                                                    </td>    
        						                                                        
					                                                                    <td align="center">
					                                                                        <label style="margin-left: 5px;">
                                                                                            </label>
					                                                                        <asp:DropDownList ID="ddlZoneExpressToForRow8" runat="server" CssClass="blackfnt">
					                                                                        </asp:DropDownList>
					                                                                    </td>
        						                                                        
					                                                                    <td align="center">
						                                                                    <input id="txtFRExpressFTLType1RowForZone8" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType1RowForZone8" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType2RowForZone8" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType2RowForZone8" type="text" size="10"  
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType3RowForZone8" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType3RowForZone8" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType4RowForZone8" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType4RowForZone8" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType5RowForZone8" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType5RowForZone8" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
					                                                                </tr>
						                                                    
					                                                                <%--table row for Freight Matrix for Zone - Row 9--%>
                                                                                    <tr id="Tr19" runat="server" style="background-color: White">
					                                                                    <td align="center">
					                                                                       <label style="margin-left: 5px;">
                                                                                            </label>
					                                                                        <asp:DropDownList ID="ddlZoneExpressFromForRow9" runat="server" CssClass="blackfnt">
					                                                                        </asp:DropDownList> 
					                                                                    </td>    
        						                                                        
					                                                                    <td align="center">
					                                                                        <label style="margin-left: 5px;">
                                                                                            </label>
					                                                                        <asp:DropDownList ID="ddlZoneExpressToForRow9" runat="server" CssClass="blackfnt">
					                                                                        </asp:DropDownList>
					                                                                    </td>
        						                                                        
					                                                                    <td align="center">
						                                                                    <input id="txtFRExpressFTLType1RowForZone9" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType1RowForZone9" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType2RowForZone9" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType2RowForZone9" type="text" size="10"  
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType3RowForZone9" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType3RowForZone9" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType4RowForZone9" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType4RowForZone9" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType5RowForZone9" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType5RowForZone9" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
					                                                                </tr>
        						                                                    
					                                                                <%--table row for Freight Matrix for Zone - Row 10--%>
                                                                                    <tr id="Tr20" runat="server" style="background-color: White">
					                                                                    <td align="center">
					                                                                       <label style="margin-left: 5px;">
                                                                                            </label>
					                                                                        <asp:DropDownList ID="ddlZoneExpressFromForRow10" runat="server" CssClass="blackfnt">
					                                                                        </asp:DropDownList> 
					                                                                    </td>    
        						                                                        
					                                                                    <td align="center">
					                                                                        <label style="margin-left: 5px;">
                                                                                            </label>
					                                                                        <asp:DropDownList ID="ddlZoneExpressToForRow10" runat="server" CssClass="blackfnt">
					                                                                        </asp:DropDownList>
					                                                                    </td>
        						                                                        
					                                                                    <td align="center">
						                                                                    <input id="txtFRExpressFTLType1RowForZone10" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType1RowForZone10" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType2RowForZone10" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType2RowForZone10" type="text" size="10"  
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType3RowForZone10" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType3RowForZone10" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType4RowForZone10" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType4RowForZone10" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtFRExpressFTLType5RowForZone10" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
        							                                                    
						                                                                <td align="center">
						                                                                    <input id="txtTrDaysExpressFTLType5RowForZone10" type="text" size="10" 
                                                                                                maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                style="margin-left: 5px;" runat="server" />
						                                                                </td>
					                                                                </tr>
					                                                            </table>
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
								                                                            <td align="left">
								                                                                <label class="blackfnt">
								                                                                    City:
								                                                                </label>
								                                                            </td>
            								                                                
									                                                        <td align="left">
									                                                            <asp:UpdatePanel ID="upCityCodeRoad" runat="server">
									                                                                <ContentTemplate>
									                                                                    <asp:TextBox ID="txtCityCodeRoad" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtCityCodeRoad_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
									                                                                    <input type="button" value="..." runat="server" id="btnCityCodeRoad" 
                                                                                                            onclick="return BranchPopup('City_Popup.aspx?2')" />
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
								                                                    
								                                                    <table border="0" align="center" cellspacing="1" cellpadding="5" width="100%" class="boxbg">
					                                                                    <tr style="background-color: White">
						                                                                    <td align="center">
						                                                                        <label class="blackfnt">
						                                                                            From&nbsp;
							                                                                        <input type="button" value="..." runat="server" id="btnCityFromRoad" 
                                                                                                        onclick="return BranchPopup('City_Popup_Multi_Selection.aspx?3')" />
						                                                                        </label>
						                                                                    </td>
            						                                                        
							                                                                <td align="center">
							                                                                    <label class="blackfnt">
							                                                                        To&nbsp;
							                                                                        <input type="button" value="..." runat="server" id="btnCityToRoad" 
                                                                                                        onclick="return BranchPopup('City_Popup_Multi_Selection.aspx?4')" />
							                                                                    </label>
							                                                                </td>
            							                                                    
							                                                                <td align="center" colspan="2">
							                                                                    <label class="blackfnt">
							                                                                        FTL Type1
							                                                                    </label>
							                                                                </td>
            							                                                    
							                                                                <td align="center" colspan="2">
							                                                                    <label class="blackfnt">
							                                                                        FTL Type2
							                                                                    </label>
							                                                                </td>
            							                                                    
							                                                                <td align="center" colspan="2">
							                                                                    <label class="blackfnt">
							                                                                        FTL Type3
							                                                                    </label>
							                                                                </td>
            							                                                    
							                                                                <td align="center" colspan="2">
							                                                                    <label class="blackfnt">
							                                                                        FTL Type4
							                                                                    </label>
							                                                                </td>
            							                                                    
							                                                                <td align="center" colspan="2">
							                                                                    <label class="blackfnt">
							                                                                        FTL Type5
							                                                                    </label>
							                                                                </td>
							                                                            </tr>
            							                                                
							                                                            <tr style="background-color: White">
						                                                                    <td align="center">
						                                                                        <label class="blackfnt">
						                                                                            &nbsp;
						                                                                        </label>
						                                                                    </td>
            						                                                        
							                                                                <td align="center">
							                                                                    <label class="blackfnt">
							                                                                        &nbsp;
							                                                                    </label>
							                                                                </td>
            							                                                    
							                                                                <td align="center" colspan="2">
							                                                                    <asp:DropDownList ID="ddlFTLTypeRoadForCity1" runat="server" CssClass="blackfnt"></asp:DropDownList>
							                                                                </td>
            							                                                    
							                                                                <td align="center" colspan="2">
							                                                                    <asp:DropDownList ID="ddlFTLTypeRoadForCity2" runat="server" CssClass="blackfnt"></asp:DropDownList>
							                                                                </td>
            							                                                    
							                                                                <td align="center" colspan="2">
							                                                                    <asp:DropDownList ID="ddlFTLTypeRoadForCity3" runat="server" CssClass="blackfnt"></asp:DropDownList>
							                                                                </td>
            							                                                    
							                                                                <td align="center" colspan="2">
							                                                                    <asp:DropDownList ID="ddlFTLTypeRoadForCity4" runat="server" CssClass="blackfnt"></asp:DropDownList>
							                                                                </td>
            							                                                    
							                                                                <td align="center" colspan="2">
							                                                                    <asp:DropDownList ID="ddlFTLTypeRoadForCity5" runat="server" CssClass="blackfnt"></asp:DropDownList>
							                                                                </td>
							                                                            </tr>
            							                                                
							                                                            <tr style="background-color: White">
						                                                                    <td align="center">
						                                                                        <label class="blackfnt">
						                                                                            &nbsp;
						                                                                        </label>
						                                                                    </td>
            						                                                        
							                                                                <td align="center">
							                                                                    <label class="blackfnt">
							                                                                        &nbsp;
							                                                                    </label>
							                                                                </td>
            							                                                    
							                                                                <td align="center">
						                                                                        <label class="blackfnt">
						                                                                            FTL Rate
						                                                                        </label>
						                                                                    </td>
            						                                                        
							                                                                <td align="center">
							                                                                    <label class="blackfnt">
							                                                                        Transit Days
							                                                                    </label>
							                                                                </td>
            							                                                    
							                                                                <td align="center">
						                                                                        <label class="blackfnt">
						                                                                            FTL Rate
						                                                                        </label>
						                                                                    </td>
            						                                                        
							                                                                <td align="center">
							                                                                    <label class="blackfnt">
							                                                                        Transit Days
							                                                                    </label>
							                                                                </td>
            							                                                    
							                                                                <td align="center">
						                                                                        <label class="blackfnt">
						                                                                            FTL Rate
						                                                                        </label>
						                                                                    </td>
            						                                                        
							                                                                <td align="center">
							                                                                    <label class="blackfnt">
							                                                                        Transit Days
							                                                                    </label>
							                                                                </td>
            							                                                    
							                                                                <td align="center">
						                                                                        <label class="blackfnt">
						                                                                            FTL Rate
						                                                                        </label>
						                                                                    </td>
            						                                                        
							                                                                <td align="center">
							                                                                    <label class="blackfnt">
							                                                                        Transit Days
							                                                                    </label>
							                                                                </td>
            							                                                    
							                                                                <td align="center">
						                                                                        <label class="blackfnt">
						                                                                            FTL Rate
						                                                                        </label>
						                                                                    </td>
            						                                                        
							                                                                <td align="center">
							                                                                    <label class="blackfnt">
							                                                                        Transit Days
							                                                                    </label>
							                                                                </td>
							                                                            </tr>
							                                                            
							                                                            <%--table row for Freight Matrix for City - Row 1--%>
						                                                                <tr id="Tr51" runat="server" style="background-color: White">
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRFromRoadForCity1" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRFromRoadForCity1" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRFromRoadForCity1_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRFromRoadForCity1" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRFromRoadForCity1" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>    
            						                                                        
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRToRoadForCity1" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRToRoadForCity1" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRToRoadForCity1_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRToRoadForCity1" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                    </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRToRoadForCity1" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>
            						                                                        
						                                                                    <td align="center">
							                                                                    <input id="txtFRRoadFTLType1RowForCity1" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType1RowForCity1" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType2RowForCity1" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType2RowForCity1" type="text" size="10"  
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType3RowForCity1" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType3RowForCity1" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType4RowForCity1" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType4RowForCity1" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType5RowForCity1" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType5RowForCity1" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
						                                                                </tr>
								                                                        
								                                                        <%--table row for Freight Matrix for City - Row 2--%>
						                                                                <tr id="Tr52" runat="server" style="background-color: White">
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRFromRoadForCity2" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRFromRoadForCity2" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRFromRoadForCity2_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRFromRoadForCity2" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRFromRoadForCity2" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>    
            						                                                        
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRToRoadForCity2" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRToRoadForCity2" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRToRoadForCity2_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRToRoadForCity2" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                    </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRToRoadForCity2" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>
            						                                                        
						                                                                    <td align="center">
							                                                                    <input id="txtFRRoadFTLType1RowForCity2" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType1RowForCity2" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType2RowForCity2" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType2RowForCity2" type="text" size="10"  
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType3RowForCity2" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType3RowForCity2" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType4RowForCity2" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType4RowForCity2" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType5RowForCity2" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType5RowForCity2" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
						                                                                </tr>
							        									    
						                                                                <%--table row for Freight Matrix for City - Row 3--%>
						                                                                <tr id="Tr53" runat="server" style="background-color: White">
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRFromRoadForCity3" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRFromRoadForCity3" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRFromRoadForCity3_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRFromRoadForCity3" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRFromRoadForCity3" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>    
            						                                                        
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRToRoadForCity3" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRToRoadForCity3" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRToRoadForCity3_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRToRoadForCity3" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                    </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRToRoadForCity3" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>
            						                                                        
						                                                                    <td align="center">
							                                                                    <input id="txtFRRoadFTLType1RowForCity3" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType1RowForCity3" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType2RowForCity3" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType2RowForCity3" type="text" size="10"  
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType3RowForCity3" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType3RowForCity3" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType4RowForCity3" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType4RowForCity3" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType5RowForCity3" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType5RowForCity3" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
						                                                                </tr>
						                                                                
						                                                                <%--table row for Freight Matrix for City - Row 4--%>
						                                                                <tr id="Tr21" runat="server" style="background-color: White">
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRFromRoadForCity4" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRFromRoadForCity4" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRFromRoadForCity4_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRFromRoadForCity4" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRFromRoadForCity4" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>    
            						                                                        
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRToRoadForCity4" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRToRoadForCity4" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRToRoadForCity4_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRToRoadForCity4" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                    </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRToRoadForCity4" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>
            						                                                        
						                                                                    <td align="center">
							                                                                    <input id="txtFRRoadFTLType1RowForCity4" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType1RowForCity4" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType2RowForCity4" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType2RowForCity4" type="text" size="10"  
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType3RowForCity4" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType3RowForCity4" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType4RowForCity4" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType4RowForCity4" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType5RowForCity4" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType5RowForCity4" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
						                                                                </tr>
						                                                                
						                                                                <%--table row for Freight Matrix for City - Row 5--%>
						                                                                <tr id="Tr22" runat="server" style="background-color: White">
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRFromRoadForCity5" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRFromRoadForCity5" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRFromRoadForCity5_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRFromRoadForCity5" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRFromRoadForCity5" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>    
            						                                                        
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRToRoadForCity5" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRToRoadForCity5" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRToRoadForCity5_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRToRoadForCity5" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                    </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRToRoadForCity5" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>
            						                                                        
						                                                                    <td align="center">
							                                                                    <input id="txtFRRoadFTLType1RowForCity5" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType1RowForCity5" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType2RowForCity5" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType2RowForCity5" type="text" size="10"  
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType3RowForCity5" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType3RowForCity5" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType4RowForCity5" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType4RowForCity5" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType5RowForCity5" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType5RowForCity5" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
						                                                                </tr>
						                                                                
						                                                                <%--table row for Freight Matrix for City - Row 6--%>
						                                                                <tr id="Tr23" runat="server" style="background-color: White">
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRFromRoadForCity6" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRFromRoadForCity6" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRFromRoadForCity6_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRFromRoadForCity6" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRFromRoadForCity6" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>    
            						                                                        
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRToRoadForCity6" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRToRoadForCity6" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRToRoadForCity6_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRToRoadForCity6" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                    </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRToRoadForCity6" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>
            						                                                        
						                                                                    <td align="center">
							                                                                    <input id="txtFRRoadFTLType1RowForCity6" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType1RowForCity6" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType2RowForCity6" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType2RowForCity6" type="text" size="10"  
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType3RowForCity6" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType3RowForCity6" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType4RowForCity6" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType4RowForCity6" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType5RowForCity6" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType5RowForCity6" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
						                                                                </tr>
						                                                                
						                                                                <%--table row for Freight Matrix for City - Row 7--%>
						                                                                <tr id="Tr24" runat="server" style="background-color: White">
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRFromRoadForCity7" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRFromRoadForCity7" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRFromRoadForCity7_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRFromRoadForCity7" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRFromRoadForCity7" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>    
            						                                                        
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRToRoadForCity7" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRToRoadForCity7" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRToRoadForCity7_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRToRoadForCity7" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                    </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRToRoadForCity7" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>
            						                                                        
						                                                                    <td align="center">
							                                                                    <input id="txtFRRoadFTLType1RowForCity7" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType1RowForCity7" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType2RowForCity7" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType2RowForCity7" type="text" size="10"  
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType3RowForCity7" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType3RowForCity7" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType4RowForCity7" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType4RowForCity7" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType5RowForCity7" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType5RowForCity7" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
						                                                                </tr>
						                                                                
						                                                                <%--table row for Freight Matrix for City - Row 8--%>
						                                                                <tr id="Tr25" runat="server" style="background-color: White">
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRFromRoadForCity8" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRFromRoadForCity8" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRFromRoadForCity8_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRFromRoadForCity8" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRFromRoadForCity8" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>    
            						                                                        
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRToRoadForCity8" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRToRoadForCity8" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRToRoadForCity8_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRToRoadForCity8" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                    </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRToRoadForCity8" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>
            						                                                        
						                                                                    <td align="center">
							                                                                    <input id="txtFRRoadFTLType1RowForCity8" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType1RowForCity8" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType2RowForCity8" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType2RowForCity8" type="text" size="10"  
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType3RowForCity8" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType3RowForCity8" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType4RowForCity8" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType4RowForCity8" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType5RowForCity8" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType5RowForCity8" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
						                                                                </tr>
						                                                                
						                                                                <%--table row for Freight Matrix for City - Row 9--%>
						                                                                <tr id="Tr26" runat="server" style="background-color: White">
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRFromRoadForCity9" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRFromRoadForCity9" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRFromRoadForCity9_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRFromRoadForCity9" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRFromRoadForCity9" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>    
            						                                                        
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRToRoadForCity9" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRToRoadForCity9" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRToRoadForCity9_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRToRoadForCity9" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                    </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRToRoadForCity9" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>
            						                                                        
						                                                                    <td align="center">
							                                                                    <input id="txtFRRoadFTLType1RowForCity9" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType1RowForCity9" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType2RowForCity9" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType2RowForCity9" type="text" size="10"  
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType3RowForCity9" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType3RowForCity9" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType4RowForCity9" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType4RowForCity9" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType5RowForCity9" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType5RowForCity9" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
						                                                                </tr>
						                                                                
						                                                                <%--table row for Freight Matrix for City - Row 10--%>
						                                                                <tr id="Tr27" runat="server" style="background-color: White">
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRFromRoadForCity10" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRFromRoadForCity10" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRFromRoadForCity10_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRFromRoadForCity10" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRFromRoadForCity10" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>    
            						                                                        
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRToRoadForCity10" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRToRoadForCity10" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRToRoadForCity10_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRToRoadForCity10" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                    </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRToRoadForCity10" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>
            						                                                        
						                                                                    <td align="center">
							                                                                    <input id="txtFRRoadFTLType1RowForCity10" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType1RowForCity10" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType2RowForCity10" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType2RowForCity10" type="text" size="10"  
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType3RowForCity10" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType3RowForCity10" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType4RowForCity10" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType4RowForCity10" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRRoadFTLType5RowForCity10" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysRoadFTLType5RowForCity10" type="text" size="10" 
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
								                                                            <td align="left">
								                                                                <label class="blackfnt">
								                                                                    City:
								                                                                </label>
								                                                            </td>
            								                                                
									                                                        <td align="left">
									                                                            <asp:UpdatePanel ID="upCityCodeExpress" runat="server">
									                                                                <ContentTemplate>
									                                                                    <asp:TextBox ID="txtCityCodeExpress" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtCityCodeExpress_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
									                                                                    <input type="button" value="..." runat="server" id="btnCityCodeExpress" 
                                                                                                            onclick="return BranchPopup('City_Popup.aspx?3')" />
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
								                                                    
								                                                    <table border="0" align="center" cellspacing="1" cellpadding="5" width="100%" class="boxbg">
					                                                                    <tr style="background-color: White">
						                                                                    <td align="center">
						                                                                        <label class="blackfnt">
						                                                                            From&nbsp;
							                                                                        <input type="button" value="..." runat="server" id="btnCityFromExpress" 
                                                                                                        onclick="return BranchPopup('City_Popup_Multi_Selection.aspx?5')" />
						                                                                        </label>
						                                                                    </td>
            						                                                        
							                                                                <td align="center">
							                                                                    <label class="blackfnt">
							                                                                        To&nbsp;
							                                                                        <input type="button" value="..." runat="server" id="btnCityToExpress" 
                                                                                                        onclick="return BranchPopup('City_Popup_Multi_Selection.aspx?6')" />
							                                                                    </label>
							                                                                </td>
            							                                                    
							                                                                <td align="center" colspan="2">
							                                                                    <label class="blackfnt">
							                                                                        FTL Type1
							                                                                    </label>
							                                                                </td>
            							                                                    
							                                                                <td align="center" colspan="2">
							                                                                    <label class="blackfnt">
							                                                                        FTL Type2
							                                                                    </label>
							                                                                </td>
            							                                                    
							                                                                <td align="center" colspan="2">
							                                                                    <label class="blackfnt">
							                                                                        FTL Type3
							                                                                    </label>
							                                                                </td>
            							                                                    
							                                                                <td align="center" colspan="2">
							                                                                    <label class="blackfnt">
							                                                                        FTL Type4
							                                                                    </label>
							                                                                </td>
            							                                                    
							                                                                <td align="center" colspan="2">
							                                                                    <label class="blackfnt">
							                                                                        FTL Type5
							                                                                    </label>
							                                                                </td>
							                                                            </tr>
            							                                                
							                                                            <tr style="background-color: White">
						                                                                    <td align="center">
						                                                                        <label class="blackfnt">
						                                                                            &nbsp;
						                                                                        </label>
						                                                                    </td>
            						                                                        
							                                                                <td align="center">
							                                                                    <label class="blackfnt">
							                                                                        &nbsp;
							                                                                    </label>
							                                                                </td>
            							                                                    
							                                                                <td align="center" colspan="2">
							                                                                    <asp:DropDownList ID="ddlFTLTypeExpressForCity1" runat="server" CssClass="blackfnt"></asp:DropDownList>
							                                                                </td>
            							                                                    
							                                                                <td align="center" colspan="2">
							                                                                    <asp:DropDownList ID="ddlFTLTypeExpressForCity2" runat="server" CssClass="blackfnt"></asp:DropDownList>
							                                                                </td>
            							                                                    
							                                                                <td align="center" colspan="2">
							                                                                    <asp:DropDownList ID="ddlFTLTypeExpressForCity3" runat="server" CssClass="blackfnt"></asp:DropDownList>
							                                                                </td>
            							                                                    
							                                                                <td align="center" colspan="2">
							                                                                    <asp:DropDownList ID="ddlFTLTypeExpressForCity4" runat="server" CssClass="blackfnt"></asp:DropDownList>
							                                                                </td>
            							                                                    
							                                                                <td align="center" colspan="2">
							                                                                    <asp:DropDownList ID="ddlFTLTypeExpressForCity5" runat="server" CssClass="blackfnt"></asp:DropDownList>
							                                                                </td>
							                                                            </tr>
            							                                                
							                                                            <tr style="background-color: White">
						                                                                    <td align="center">
						                                                                        <label class="blackfnt">
						                                                                            &nbsp;
						                                                                        </label>
						                                                                    </td>
            						                                                        
							                                                                <td align="center">
							                                                                    <label class="blackfnt">
							                                                                        &nbsp;
							                                                                    </label>
							                                                                </td>
            							                                                    
							                                                                <td align="center">
						                                                                        <label class="blackfnt">
						                                                                            FTL Rate
						                                                                        </label>
						                                                                    </td>
            						                                                        
							                                                                <td align="center">
							                                                                    <label class="blackfnt">
							                                                                        Transit Days
							                                                                    </label>
							                                                                </td>
            							                                                    
							                                                                <td align="center">
						                                                                        <label class="blackfnt">
						                                                                            FTL Rate
						                                                                        </label>
						                                                                    </td>
            						                                                        
							                                                                <td align="center">
							                                                                    <label class="blackfnt">
							                                                                        Transit Days
							                                                                    </label>
							                                                                </td>
            							                                                    
							                                                                <td align="center">
						                                                                        <label class="blackfnt">
						                                                                            FTL Rate
						                                                                        </label>
						                                                                    </td>
            						                                                        
							                                                                <td align="center">
							                                                                    <label class="blackfnt">
							                                                                        Transit Days
							                                                                    </label>
							                                                                </td>
            							                                                    
							                                                                <td align="center">
						                                                                        <label class="blackfnt">
						                                                                            FTL Rate
						                                                                        </label>
						                                                                    </td>
            						                                                        
							                                                                <td align="center">
							                                                                    <label class="blackfnt">
							                                                                        Transit Days
							                                                                    </label>
							                                                                </td>
            							                                                    
							                                                                <td align="center">
						                                                                        <label class="blackfnt">
						                                                                            FTL Rate
						                                                                        </label>
						                                                                    </td>
            						                                                        
							                                                                <td align="center">
							                                                                    <label class="blackfnt">
							                                                                        Transit Days
							                                                                    </label>
							                                                                </td>
							                                                            </tr>
							                                                            
							                                                            <%--table row for Freight Matrix for City - Row 1--%>
						                                                                <tr id="Tr28" runat="server" style="background-color: White">
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRFromExpressForCity1" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRFromExpressForCity1" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRFromExpressForCity1_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRFromExpressForCity1" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRFromExpressForCity1" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>    
            						                                                        
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRToExpressForCity1" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRToExpressForCity1" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRToExpressForCity1_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRToExpressForCity1" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                    </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRToExpressForCity1" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>
            						                                                        
						                                                                    <td align="center">
							                                                                    <input id="txtFRExpressFTLType1RowForCity1" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType1RowForCity1" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType2RowForCity1" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType2RowForCity1" type="text" size="10"  
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType3RowForCity1" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType3RowForCity1" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType4RowForCity1" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType4RowForCity1" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType5RowForCity1" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType5RowForCity1" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
						                                                                </tr>
						                                                                
						                                                                <%--table row for Freight Matrix for City - Row 2--%>
						                                                                <tr id="Tr29" runat="server" style="background-color: White">
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRFromExpressForCity2" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRFromExpressForCity2" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRFromExpressForCity2_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRFromExpressForCity2" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRFromExpressForCity2" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>    
            						                                                        
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRToExpressForCity2" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRToExpressForCity2" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRToExpressForCity2_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRToExpressForCity2" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                    </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRToExpressForCity2" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>
            						                                                        
						                                                                    <td align="center">
							                                                                    <input id="txtFRExpressFTLType1RowForCity2" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType1RowForCity2" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType2RowForCity2" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType2RowForCity2" type="text" size="10"  
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType3RowForCity2" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType3RowForCity2" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType4RowForCity2" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType4RowForCity2" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType5RowForCity2" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType5RowForCity2" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
						                                                                </tr>
						                                                                
						                                                                <%--table row for Freight Matrix for City - Row 3--%>
						                                                                <tr id="Tr30" runat="server" style="background-color: White">
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRFromExpressForCity3" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRFromExpressForCity3" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRFromExpressForCity3_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRFromExpressForCity3" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRFromExpressForCity3" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>    
            						                                                        
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRToExpressForCity3" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRToExpressForCity3" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRToExpressForCity3_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRToExpressForCity3" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                    </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRToExpressForCity3" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>
            						                                                        
						                                                                    <td align="center">
							                                                                    <input id="txtFRExpressFTLType1RowForCity3" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType1RowForCity3" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType2RowForCity3" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType2RowForCity3" type="text" size="10"  
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType3RowForCity3" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType3RowForCity3" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType4RowForCity3" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType4RowForCity3" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType5RowForCity3" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType5RowForCity3" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
						                                                                </tr>
						                                                                
						                                                                <%--table row for Freight Matrix for City - Row 3--%>
						                                                                <tr id="Tr54" runat="server" style="background-color: White">
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRFromExpressForCity4" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRFromExpressForCity4" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRFromExpressForCity4_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRFromExpressForCity4" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRFromExpressForCity4" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>    
            						                                                        
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRToExpressForCity4" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRToExpressForCity4" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRToExpressForCity4_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRToExpressForCity4" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                    </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRToExpressForCity4" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>
            						                                                        
						                                                                    <td align="center">
							                                                                    <input id="txtFRExpressFTLType1RowForCity4" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType1RowForCity4" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType2RowForCity4" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType2RowForCity4" type="text" size="10"  
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType3RowForCity4" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType3RowForCity4" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType4RowForCity4" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType4RowForCity4" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType5RowForCity4" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType5RowForCity4" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
						                                                                </tr>
						                                                                
						                                                                <%--table row for Freight Matrix for City - Row 3--%>
						                                                                <tr id="Tr55" runat="server" style="background-color: White">
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRFromExpressForCity5" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRFromExpressForCity5" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRFromExpressForCity5_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRFromExpressForCity5" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRFromExpressForCity5" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>    
            						                                                        
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRToExpressForCity5" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRToExpressForCity5" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRToExpressForCity5_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRToExpressForCity5" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                    </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRToExpressForCity5" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>
            						                                                        
						                                                                    <td align="center">
							                                                                    <input id="txtFRExpressFTLType1RowForCity5" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType1RowForCity5" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType2RowForCity5" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType2RowForCity5" type="text" size="10"  
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType3RowForCity5" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType3RowForCity5" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType4RowForCity5" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType4RowForCity5" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType5RowForCity5" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType5RowForCity5" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
						                                                                </tr>
						                                                                
						                                                                <%--table row for Freight Matrix for City - Row 3--%>
						                                                                <tr id="Tr56" runat="server" style="background-color: White">
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRFromExpressForCity6" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRFromExpressForCity6" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRFromExpressForCity6_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRFromExpressForCity6" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRFromExpressForCity6" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>    
            						                                                        
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRToExpressForCity6" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRToExpressForCity6" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRToExpressForCity6_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRToExpressForCity6" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                    </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRToExpressForCity6" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>
            						                                                        
						                                                                    <td align="center">
							                                                                    <input id="txtFRExpressFTLType1RowForCity6" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType1RowForCity6" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType2RowForCity6" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType2RowForCity6" type="text" size="10"  
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType3RowForCity6" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType3RowForCity6" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType4RowForCity6" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType4RowForCity6" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType5RowForCity6" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType5RowForCity6" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
						                                                                </tr>
						                                                                
						                                                                <%--table row for Freight Matrix for City - Row 3--%>
						                                                                <tr id="Tr57" runat="server" style="background-color: White">
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRFromExpressForCity7" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRFromExpressForCity7" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRFromExpressForCity7_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRFromExpressForCity7" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRFromExpressForCity7" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>    
            						                                                        
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRToExpressForCity7" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRToExpressForCity7" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRToExpressForCity7_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRToExpressForCity7" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                    </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRToExpressForCity7" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>
            						                                                        
						                                                                    <td align="center">
							                                                                    <input id="txtFRExpressFTLType1RowForCity7" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType1RowForCity7" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType2RowForCity7" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType2RowForCity7" type="text" size="10"  
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType3RowForCity7" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType3RowForCity7" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType4RowForCity7" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType4RowForCity7" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType5RowForCity7" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType5RowForCity7" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
						                                                                </tr>
						                                                                
						                                                                <%--table row for Freight Matrix for City - Row 8--%>
						                                                                <tr id="Tr58" runat="server" style="background-color: White">
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRFromExpressForCity8" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRFromExpressForCity8" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRFromExpressForCity8_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRFromExpressForCity8" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRFromExpressForCity8" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>    
            						                                                        
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRToExpressForCity8" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRToExpressForCity8" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRToExpressForCity8_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRToExpressForCity8" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                    </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRToExpressForCity8" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>
            						                                                        
						                                                                    <td align="center">
							                                                                    <input id="txtFRExpressFTLType1RowForCity8" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType1RowForCity8" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType2RowForCity8" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType2RowForCity8" type="text" size="10"  
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType3RowForCity8" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType3RowForCity8" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType4RowForCity8" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType4RowForCity8" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType5RowForCity8" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType5RowForCity8" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
						                                                                </tr>
						                                                                
						                                                                <%--table row for Freight Matrix for City - Row 3--%>
						                                                                <tr id="Tr59" runat="server" style="background-color: White">
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRFromExpressForCity9" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRFromExpressForCity9" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRFromExpressForCity9_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRFromExpressForCity9" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRFromExpressForCity9" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>    
            						                                                        
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRToExpressForCity9" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRToExpressForCity9" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRToExpressForCity9_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRToExpressForCity9" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                    </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRToExpressForCity9" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>
            						                                                        
						                                                                    <td align="center">
							                                                                    <input id="txtFRExpressFTLType1RowForCity9" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType1RowForCity9" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType2RowForCity9" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType2RowForCity9" type="text" size="10"  
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType3RowForCity9" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType3RowForCity9" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType4RowForCity9" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType4RowForCity9" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType5RowForCity9" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType5RowForCity9" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
						                                                                </tr>
						                                                                
						                                                                <%--table row for Freight Matrix for City - Row 3--%>
						                                                                <tr id="Tr60" runat="server" style="background-color: White">
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRFromExpressForCity10" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRFromExpressForCity10" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRFromExpressForCity10_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRFromExpressForCity10" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRFromExpressForCity10" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>    
            						                                                        
						                                                                    <td align="center">
						                                                                        <asp:UpdatePanel ID="upFRToExpressForCity10" runat="server">
									                                                                <ContentTemplate>
						                                                                                <asp:TextBox ID="txtFRToExpressForCity10" runat="server" MaxLength="50" 
									                                                                        OnTextChanged="txtFRToExpressForCity10_TextChanged" CssClass="input" 
									                                                                        AutoPostBack="true" Width="40px" style="margin-left: 5px;">
									                                                                    </asp:TextBox>
                                                                                                        <label class="blackfnt" id="lblErrorFRToExpressForCity10" runat="server" style="color: Red;" visible="false">
                                                                                                            &nbsp;Invalid City Code!!!
                                                                                                        </label>
                                                                                                    </ContentTemplate>
									                                                                <Triggers>
									                                                                    <asp:AsyncPostBackTrigger ControlID="txtFRToExpressForCity10" EventName="TextChanged" />
									                                                                </Triggers>
									                                                            </asp:UpdatePanel>
						                                                                    </td>
            						                                                        
						                                                                    <td align="center">
							                                                                    <input id="txtFRExpressFTLType1RowForCity10" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType1RowForCity10" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType2RowForCity10" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType2RowForCity10" type="text" size="10"  
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType3RowForCity10" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType3RowForCity10" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType4RowForCity10" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType4RowForCity10" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_woDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtFRExpressFTLType5RowForCity10" type="text" size="10" 
                                                                                                    maxlength="6" onblur="return Nagative_Chk_wDecimal(this)" 
                                                                                                    style="margin-left: 5px;" runat="server" />
							                                                                </td>
            							                                                    
							                                                                <td align="center">
							                                                                    <input id="txtTrDaysExpressFTLType5RowForCity10" type="text" size="10" 
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
