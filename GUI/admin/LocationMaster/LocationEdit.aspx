<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="LocationEdit.aspx.cs" Inherits="LocationEdit" %>

<%@ OutputCache Location="none" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="vbscript" type="text/vbscript">
        
        function findDateDifference(dtFrom, dtTo, interval)
            
            findDateDifference = DateDiff(interval, dtFrom, dtTo)
            
        end function
        
    </script>

    <script language="javascript" type="text/javascript">
        function checknumber(obj) {
            // debugger;
            if (isNaN(obj.value)) {
                alert("Value Should Be Numeric !!")
                obj.focus()
                return false
            }
            if (obj.value < 0) {
                alert("Value should be greater than zero !!")
                obj.value = "";
                obj.focus();
                return false;
            }
            
        }

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

        function Citycheck(obj) {
            obj.value = trimAll(obj.value);
            if (obj.value != "") {
                var a;
                a = 1;
                obj.value = obj.value.toUpperCase()
                for (i = 0; i < str.length; i++) {

                    if (obj.value == str[i].toUpperCase()) {
                        a = 2
                        break;
                        //return false;
                    }
                    else {
                        continue
                    }
                }
                if (a != 2) {
                    alert("please enter valid City")
                    obj.focus();
                }
            }
        }
        function Locationcheck(obj) {
            obj.value = trimAll(obj.value);
            if (obj.value.length < 3 && obj.value.length > 0) {
                alert("Invalid location code Length")
                obj.focus();
                return false;
            }
            // obj.value = obj.value.toUpperCase()
            obj.value = trimAll(obj.value);
            if (obj.value != "") {
                var a;
                a = 1;
                obj.value = obj.value.toUpperCase()
                for (i = 0; i < strloc.length; i++) {

                    if (obj.value == strloc[i].toUpperCase()) {
                        a = 2
                        break;
                        //return false;
                    }
                    else {
                        continue
                    }
                }
                if (a == 2) {
                    alert("Location Code Already Exists !!")
                    obj.focus();
                }
            }
        }

        function chkdateloc(obj) {
            if (flag == "2") {
                var mToday = "<%=strToday %>";
                mToday = mToday.substring(3, 5) + "/" + mToday.substring(0, 2) + "/" + mToday.substring(6, 10);
                var mLocStartDate = obj.value;
                mLocStartDate = mLocStartDate.substring(3, 5) + "/" + mLocStartDate.substring(0, 2) + "/" + mLocStartDate.substring(6, 10);

                //Check for Date From and Date To Date range
                if (findDateDifference(mToday, mLocStartDate, "d") > 0) {
                    alert("Enter Date Less Than Or Equal To Today!");
                    obj.focus();
                    return false;
                }
            }
            else {
                return false
            }
        }
        var flag
        function ValidateForm(obj) {
            flag = "1"
            if (obj.value != "") {
                if (isDate1(obj.value) == false) {

                    obj.focus()
                    return false
                }
                flag = "2"
                return true
            }
        }
        var dtCh = "/";
        var minYear = 1900;
        var maxYear = 2100;
        function DaysArray(n) {
            for (var i = 1; i <= n; i++) {
                this[i] = 31
                if (i == 4 || i == 6 || i == 9 || i == 11) { this[i] = 30 }
                if (i == 2) { this[i] = 29 }
            }
            return this
        }
        function isDate1(dtStr) {
            ///alert(dtStr)
            var daysInMonth = DaysArray(12)
            var pos1 = dtStr.indexOf(dtCh)
            var pos2 = dtStr.indexOf(dtCh, pos1 + 1)
            var strDay = dtStr.substring(0, pos1)
            var strMonth = dtStr.substring(pos1 + 1, pos2)
            var strYear = dtStr.substring(pos2 + 1)
            strYr = strYear
            if (strDay.charAt(0) == "0" && strDay.length > 1) strDay = strDay.substring(1)
            if (strMonth.charAt(0) == "0" && strMonth.length > 1) strMonth = strMonth.substring(1)
            for (var i = 1; i <= 3; i++) {
                if (strYr.charAt(0) == "0" && strYr.length > 1) strYr = strYr.substring(1)
            }

            month = parseInt(strMonth)
            day = parseInt(strDay)
            year = parseInt(strYr)
            if (pos1 == -1 || pos2 == -1) {
                alert("The date format should be : dd/mm/yyyy")
                return false
            }

            if (strMonth.length < 1 || month < 1 || month > 12) {
                alert("Please enter a valid month")
                return false
            }
            if (strDay.length < 1 || day < 1 || day > 31 || (month == 2 && day > daysInFebruary(year)) || day > daysInMonth[month]) {
                alert("Please enter a valid day")
                return false
            }
            if (strYear.length != 4 || year == 0 || year < minYear || year > maxYear) {
                alert("Please enter a valid 4 digit year between " + minYear + " and " + maxYear)
                return false
            }
            if (dtStr.indexOf(dtCh, pos2 + 1) != -1 || isInteger(stripCharsInBag(dtStr, dtCh)) == false) {
                alert("Please enter a valid date")
                return false
            }
            return true
        }
        //***************************************************************
        var loccodeval = "<%=Locationstr%>";
        var citycodeval = "<%=Citystr%>";
        var loccode = "<%=loccode %>"
        //        function Locationcheck(obj)
        //        {
        //            //alert(loccodeval)
        //             obj.value = trimAll(obj.value);
        //            if(obj.value.length<3 && obj.value.length>0)
        //            {
        //                alert("Invalid location code Length")
        //                obj.focus();
        //                return false;
        //            }      
        //            obj.value = obj.value.toUpperCase()
        //            if (obj.value.toUpperCase()!="")
        //            {
        //                if(loccodeval.indexOf(obj.value.toUpperCase())!=-1 && obj.value != loccode)
        //                {
        //                    alert("Location Code Already Exists !!")
        //                    obj.focus();
        //                    return false;
        //                }
        //            }
        //        }

        function EmailCheck(obj) {
            if (obj.value != "") {
                if (obj.value.indexOf("@") == -1 || obj.value.indexOf(".") == -1) {
                    alert("Invalid Email Address")
                    obj.focus();
                    return false;
                }
            }
        }

        //        function DefNxtLoc(obj)
        //        {
        //            obj.value = trimAll(obj.value);
        //            obj.value = obj.value.toUpperCase()
        //            if (obj.value.toUpperCase()!="")
        //            {
        //                if(obj.value.length<3 && obj.value.length>0)
        //                {
        //                    {
        //                        alert("Invalid location code Length")
        //                        obj.focus();
        //                        return false;
        //                    }
        //                }
        //                if(loccodeval.indexOf(obj.value.toUpperCase())==-1 )
        //                {
        //                    alert("Invalid Location Code !!")
        //                    obj.focus();
        //                    return false;
        //                }
        //            }
        //        }
        function DefNxtLoc(obj) {
            obj.value = trimAll(obj.value);
            if (obj.value.length < 3 && obj.value.length > 0) {
                alert("Invalid location code Length")
                obj.focus();
                return false;
            }
            // obj.value = obj.value.toUpperCase()
            obj.value = trimAll(obj.value);
            if (obj.value != "") {
                var a;
                a = 1;
                obj.value = obj.value.toUpperCase()
                for (i = 0; i < strloc.length; i++) {

                    if (obj.value == strloc[i].toUpperCase()) {
                        a = 2
                        break;
                        //return false;
                    }
                    else {
                        continue
                    }
                }
                if (a != 2) {
                    alert("Invalid Location Code !!")
                    obj.focus();
                }
            }
        }
        function check2loc(obj) {
            //debugger
            var locsame = "";
            //var cnt = 0;
            obj.value = trimAll(obj.value);
            obj.value = obj.value.toUpperCase()
            sText = obj.value.toUpperCase()
            sarr = sText.split(",")
            if (sarr.length > 2) {
                alert("Only Two Locations Allowed !!")
                obj.focus()
                return false
            }
            else {
                //debugger
                if (obj.value.toUpperCase() != "") {
                    for (i = 0; i < sarr.length; i++) {
                        if (sarr[i].length < 2 && sarr[i].length > 0) {
                            {
                                alert("Invalid location code Length")
                                obj.focus();
                                return false;
                            }
                        }
                        //var strLocations = loccodeval.split(",");
                        //for (j = 0; j < strLocations.length; j++) {

                        if (loccodeval.indexOf(sarr[i].toUpperCase()) == -1) {
                            //if (strLocations[i].toUpperCase() == sarr[i].toUpperCase()) {
                            //cnt++;
                            alert("Invalid Location Code !!")
                            obj.focus();
                            return false;
                        }
                        else {
                            if (locsame == sarr[i]) {
                                alert("Same Locations Are Not Allowed !!")
                                obj.focus();
                                return false
                            }
                            else {
                                locsame = sarr[i]
                            }
                        }
                        //}
                    }
                }

            }
        }

        //        function Citycheck(obj)
        //        {
        //            obj.value = trimAll(obj.value);
        //            obj.value = obj.value.toUpperCase()
        //            if (obj.value.toUpperCase()!="" )
        //            {
        //                if(obj.value.length<3  && obj.value.length>0)
        //                {
        //                    alert("Invalid City Code Length")
        //                    obj.focus();
        //                    return false;
        //                }

        //                if(citycodeval.indexOf(obj.value.toUpperCase())==-1 )
        //                {                
        //                    alert("Invalid City  !!")
        //                    obj.focus();
        //                    return false;
        //                }
        //            }
        //        }
        function getAnchorPosition(anchorname) { var useWindow = false; var coordinates = new Object(); var x = 0, y = 0; var use_gebi = false, use_css = false, use_layers = false; if (document.getElementById) { use_gebi = true; } else if (document.all) { use_css = true; } else if (document.layers) { use_layers = true; } if (use_gebi && document.all) { x = AnchorPosition_getPageOffsetLeft(document.all[anchorname]); y = AnchorPosition_getPageOffsetTop(document.all[anchorname]); } else if (use_gebi) { var o = document.getElementById(anchorname); x = AnchorPosition_getPageOffsetLeft(o); y = AnchorPosition_getPageOffsetTop(o); } else if (use_css) { x = AnchorPosition_getPageOffsetLeft(document.all[anchorname]); y = AnchorPosition_getPageOffsetTop(document.all[anchorname]); } else if (use_layers) { var found = 0; for (var i = 0; i < document.anchors.length; i++) { if (document.anchors[i].name == anchorname) { found = 1; break; } } if (found == 0) { coordinates.x = 0; coordinates.y = 0; return coordinates; } x = document.anchors[i].x; y = document.anchors[i].y; } else { coordinates.x = 0; coordinates.y = 0; return coordinates; } coordinates.x = x; coordinates.y = y; return coordinates; }
        function getAnchorWindowPosition(anchorname) { var coordinates = getAnchorPosition(anchorname); var x = 0; var y = 0; if (document.getElementById) { if (isNaN(window.screenX)) { x = coordinates.x - document.body.scrollLeft + window.screenLeft; y = coordinates.y - document.body.scrollTop + window.screenTop; } else { x = coordinates.x + window.screenX + (window.outerWidth - window.innerWidth) - window.pageXOffset; y = coordinates.y + window.screenY + (window.outerHeight - 24 - window.innerHeight) - window.pageYOffset; } } else if (document.all) { x = coordinates.x - document.body.scrollLeft + window.screenLeft; y = coordinates.y - document.body.scrollTop + window.screenTop; } else if (document.layers) { x = coordinates.x + window.screenX + (window.outerWidth - window.innerWidth) - window.pageXOffset; y = coordinates.y + window.screenY + (window.outerHeight - 24 - window.innerHeight) - window.pageYOffset; } coordinates.x = x; coordinates.y = y; return coordinates; }
        function AnchorPosition_getPageOffsetLeft(el) { var ol = el.offsetLeft; while ((el = el.offsetParent) != null) { ol += el.offsetLeft; } return ol; }
        function AnchorPosition_getWindowOffsetLeft(el) { return AnchorPosition_getPageOffsetLeft(el) - document.body.scrollLeft; }
        function AnchorPosition_getPageOffsetTop(el) { var ot = el.offsetTop; while ((el = el.offsetParent) != null) { ot += el.offsetTop; } return ot; }
        function AnchorPosition_getWindowOffsetTop(el) { return AnchorPosition_getPageOffsetTop(el) - document.body.scrollTop; }

        /* SOURCE FILE: date.js */
        var MONTH_NAMES = new Array('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'); var DAY_NAMES = new Array('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat');
        function LZ(x) { return (x < 0 || x > 9 ? "" : "0") + x }
        function isDate(val, format) { var date = getDateFromFormat(val, format); if (date == 0) { return false; } return true; }
        function compareDates(date1, dateformat1, date2, dateformat2) { var d1 = getDateFromFormat(date1, dateformat1); var d2 = getDateFromFormat(date2, dateformat2); if (d1 == 0 || d2 == 0) { return -1; } else if (d1 > d2) { return 1; } return 0; }
        function formatDate(date, format) { format = format + ""; var result = ""; var i_format = 0; var c = ""; var token = ""; var y = date.getYear() + ""; var M = date.getMonth() + 1; var d = date.getDate(); var E = date.getDay(); var H = date.getHours(); var m = date.getMinutes(); var s = date.getSeconds(); var yyyy, yy, MMM, MM, dd, hh, h, mm, ss, ampm, HH, H, KK, K, kk, k; var value = new Object(); if (y.length < 4) { y = "" + (y - 0 + 1900); } value["y"] = "" + y; value["yyyy"] = y; value["yy"] = y.substring(2, 4); value["M"] = M; value["MM"] = LZ(M); value["MMM"] = MONTH_NAMES[M - 1]; value["NNN"] = MONTH_NAMES[M + 11]; value["d"] = d; value["dd"] = LZ(d); value["E"] = DAY_NAMES[E + 7]; value["EE"] = DAY_NAMES[E]; value["H"] = H; value["HH"] = LZ(H); if (H == 0) { value["h"] = 12; } else if (H > 12) { value["h"] = H - 12; } else { value["h"] = H; } value["hh"] = LZ(value["h"]); if (H > 11) { value["K"] = H - 12; } else { value["K"] = H; } value["k"] = H + 1; value["KK"] = LZ(value["K"]); value["kk"] = LZ(value["k"]); if (H > 11) { value["a"] = "PM"; } else { value["a"] = "AM"; } value["m"] = m; value["mm"] = LZ(m); value["s"] = s; value["ss"] = LZ(s); while (i_format < format.length) { c = format.charAt(i_format); token = ""; while ((format.charAt(i_format) == c) && (i_format < format.length)) { token += format.charAt(i_format++); } if (value[token] != null) { result = result + value[token]; } else { result = result + token; } } return result; }
        function _isInteger(val) { var digits = "1234567890"; for (var i = 0; i < val.length; i++) { if (digits.indexOf(val.charAt(i)) == -1) { return false; } } return true; }
        function _getInt(str, i, minlength, maxlength) { for (var x = maxlength; x >= minlength; x--) { var token = str.substring(i, i + x); if (token.length < minlength) { return null; } if (_isInteger(token)) { return token; } } return null; }
        function getDateFromFormat(val, format) { val = val + ""; format = format + ""; var i_val = 0; var i_format = 0; var c = ""; var token = ""; var token2 = ""; var x, y; var now = new Date(); var year = now.getYear(); var month = now.getMonth() + 1; var date = 1; var hh = now.getHours(); var mm = now.getMinutes(); var ss = now.getSeconds(); var ampm = ""; while (i_format < format.length) { c = format.charAt(i_format); token = ""; while ((format.charAt(i_format) == c) && (i_format < format.length)) { token += format.charAt(i_format++); } if (token == "yyyy" || token == "yy" || token == "y") { if (token == "yyyy") { x = 4; y = 4; } if (token == "yy") { x = 2; y = 2; } if (token == "y") { x = 2; y = 4; } year = _getInt(val, i_val, x, y); if (year == null) { return 0; } i_val += year.length; if (year.length == 2) { if (year > 70) { year = 1900 + (year - 0); } else { year = 2000 + (year - 0); } } } else if (token == "MMM" || token == "NNN") { month = 0; for (var i = 0; i < MONTH_NAMES.length; i++) { var month_name = MONTH_NAMES[i]; if (val.substring(i_val, i_val + month_name.length).toLowerCase() == month_name.toLowerCase()) { if (token == "MMM" || (token == "NNN" && i > 11)) { month = i + 1; if (month > 12) { month -= 12; } i_val += month_name.length; break; } } } if ((month < 1) || (month > 12)) { return 0; } } else if (token == "EE" || token == "E") { for (var i = 0; i < DAY_NAMES.length; i++) { var day_name = DAY_NAMES[i]; if (val.substring(i_val, i_val + day_name.length).toLowerCase() == day_name.toLowerCase()) { i_val += day_name.length; break; } } } else if (token == "MM" || token == "M") { month = _getInt(val, i_val, token.length, 2); if (month == null || (month < 1) || (month > 12)) { return 0; } i_val += month.length; } else if (token == "dd" || token == "d") { date = _getInt(val, i_val, token.length, 2); if (date == null || (date < 1) || (date > 31)) { return 0; } i_val += date.length; } else if (token == "hh" || token == "h") { hh = _getInt(val, i_val, token.length, 2); if (hh == null || (hh < 1) || (hh > 12)) { return 0; } i_val += hh.length; } else if (token == "HH" || token == "H") { hh = _getInt(val, i_val, token.length, 2); if (hh == null || (hh < 0) || (hh > 23)) { return 0; } i_val += hh.length; } else if (token == "KK" || token == "K") { hh = _getInt(val, i_val, token.length, 2); if (hh == null || (hh < 0) || (hh > 11)) { return 0; } i_val += hh.length; } else if (token == "kk" || token == "k") { hh = _getInt(val, i_val, token.length, 2); if (hh == null || (hh < 1) || (hh > 24)) { return 0; } i_val += hh.length; hh--; } else if (token == "mm" || token == "m") { mm = _getInt(val, i_val, token.length, 2); if (mm == null || (mm < 0) || (mm > 59)) { return 0; } i_val += mm.length; } else if (token == "ss" || token == "s") { ss = _getInt(val, i_val, token.length, 2); if (ss == null || (ss < 0) || (ss > 59)) { return 0; } i_val += ss.length; } else if (token == "a") { if (val.substring(i_val, i_val + 2).toLowerCase() == "am") { ampm = "AM"; } else if (val.substring(i_val, i_val + 2).toLowerCase() == "pm") { ampm = "PM"; } else { return 0; } i_val += 2; } else { if (val.substring(i_val, i_val + token.length) != token) { return 0; } else { i_val += token.length; } } } if (i_val != val.length) { return 0; } if (month == 2) { if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) { if (date > 29) { return 0; } } else { if (date > 28) { return 0; } } } if ((month == 4) || (month == 6) || (month == 9) || (month == 11)) { if (date > 30) { return 0; } } if (hh < 12 && ampm == "PM") { hh = hh - 0 + 12; } else if (hh > 11 && ampm == "AM") { hh -= 12; } var newdate = new Date(year, month - 1, date, hh, mm, ss); return newdate.getTime(); }
        function parseDate(val) { var preferEuro = (arguments.length == 2) ? arguments[1] : false; generalFormats = new Array('y-M-d', 'MMM d, y', 'MMM d,y', 'y-MMM-d', 'd-MMM-y', 'MMM d'); monthFirst = new Array('M/d/y', 'M-d-y', 'M.d.y', 'MMM-d', 'M/d', 'M-d'); dateFirst = new Array('d/M/y', 'd-M-y', 'd.M.y', 'd-MMM', 'd/M', 'd-M'); var checkList = new Array('generalFormats', preferEuro ? 'dateFirst' : 'monthFirst', preferEuro ? 'monthFirst' : 'dateFirst'); var d = null; for (var i = 0; i < checkList.length; i++) { var l = window[checkList[i]]; for (var j = 0; j < l.length; j++) { d = getDateFromFormat(val, l[j]); if (d != 0) { return new Date(d); } } } return null; }

        /* SOURCE FILE: PopupWindow.js */
        function PopupWindow_getXYPosition(anchorname) { var coordinates; if (this.type == "WINDOW") { coordinates = getAnchorWindowPosition(anchorname); } else { coordinates = getAnchorPosition(anchorname); } this.x = coordinates.x; this.y = coordinates.y; }
        function PopupWindow_setSize(width, height) { this.width = width; this.height = height; }
        function PopupWindow_populate(contents) { this.contents = contents; this.populated = false; }
        function PopupWindow_setUrl(url) { this.url = url; }
        function PopupWindow_setWindowProperties(props) { this.windowProperties = props; }
        function PopupWindow_refresh() { if (this.divName != null) { if (this.use_gebi) { document.getElementById(this.divName).innerHTML = this.contents; } else if (this.use_css) { document.all[this.divName].innerHTML = this.contents; } else if (this.use_layers) { var d = document.layers[this.divName]; d.document.open(); d.document.writeln(this.contents); d.document.close(); } } else { if (this.popupWindow != null && !this.popupWindow.closed) { if (this.url != "") { this.popupWindow.location.href = this.url; } else { this.popupWindow.document.open(); this.popupWindow.document.writeln(this.contents); this.popupWindow.document.close(); } this.popupWindow.focus(); } } }
        function PopupWindow_showPopup(anchorname) { this.getXYPosition(anchorname); this.x += this.offsetX; this.y += this.offsetY; if (!this.populated && (this.contents != "")) { this.populated = true; this.refresh(); } if (this.divName != null) { if (this.use_gebi) { document.getElementById(this.divName).style.left = this.x + "px"; document.getElementById(this.divName).style.top = this.y + "px"; document.getElementById(this.divName).style.visibility = "visible"; } else if (this.use_css) { document.all[this.divName].style.left = this.x; document.all[this.divName].style.top = this.y; document.all[this.divName].style.visibility = "visible"; } else if (this.use_layers) { document.layers[this.divName].left = this.x; document.layers[this.divName].top = this.y; document.layers[this.divName].visibility = "visible"; } } else { if (this.popupWindow == null || this.popupWindow.closed) { if (this.x < 0) { this.x = 0; } if (this.y < 0) { this.y = 0; } if (screen && screen.availHeight) { if ((this.y + this.height) > screen.availHeight) { this.y = screen.availHeight - this.height; } } if (screen && screen.availWidth) { if ((this.x + this.width) > screen.availWidth) { this.x = screen.availWidth - this.width; } } var avoidAboutBlank = window.opera || (document.layers && !navigator.mimeTypes['*']) || navigator.vendor == 'KDE' || (document.childNodes && !document.all && !navigator.taintEnabled); this.popupWindow = window.open(avoidAboutBlank ? "" : "about:blank", "window_" + anchorname, this.windowProperties + ",width=" + this.width + ",height=" + this.height + ",screenX=" + this.x + ",left=" + this.x + ",screenY=" + this.y + ",top=" + this.y + ""); } this.refresh(); } }
        function PopupWindow_hidePopup() { if (this.divName != null) { if (this.use_gebi) { document.getElementById(this.divName).style.visibility = "hidden"; } else if (this.use_css) { document.all[this.divName].style.visibility = "hidden"; } else if (this.use_layers) { document.layers[this.divName].visibility = "hidden"; } } else { if (this.popupWindow && !this.popupWindow.closed) { this.popupWindow.close(); this.popupWindow = null; } } }
        function PopupWindow_isClicked(e) { if (this.divName != null) { if (this.use_layers) { var clickX = e.pageX; var clickY = e.pageY; var t = document.layers[this.divName]; if ((clickX > t.left) && (clickX < t.left + t.clip.width) && (clickY > t.top) && (clickY < t.top + t.clip.height)) { return true; } else { return false; } } else if (document.all) { var t = window.event.srcElement; while (t.parentElement != null) { if (t.id == this.divName) { return true; } t = t.parentElement; } return false; } else if (this.use_gebi && e) { var t = e.originalTarget; while (t.parentNode != null) { if (t.id == this.divName) { return true; } t = t.parentNode; } return false; } return false; } return false; }
        function PopupWindow_hideIfNotClicked(e) { if (this.autoHideEnabled && !this.isClicked(e)) { this.hidePopup(); } }
        function PopupWindow_autoHide() { this.autoHideEnabled = true; }
        function PopupWindow_hidePopupWindows(e) { for (var i = 0; i < popupWindowObjects.length; i++) { if (popupWindowObjects[i] != null) { var p = popupWindowObjects[i]; p.hideIfNotClicked(e); } } }
        function PopupWindow_attachListener() { if (document.layers) { document.captureEvents(Event.MOUSEUP); } window.popupWindowOldEventListener = document.onmouseup; if (window.popupWindowOldEventListener != null) { document.onmouseup = new Function("window.popupWindowOldEventListener();PopupWindow_hidePopupWindows();"); } else { document.onmouseup = PopupWindow_hidePopupWindows; } }
        function PopupWindow() { if (!window.popupWindowIndex) { window.popupWindowIndex = 0; } if (!window.popupWindowObjects) { window.popupWindowObjects = new Array(); } if (!window.listenerAttached) { window.listenerAttached = true; PopupWindow_attachListener(); } this.index = popupWindowIndex++; popupWindowObjects[this.index] = this; this.divName = null; this.popupWindow = null; this.width = 0; this.height = 0; this.populated = false; this.visible = false; this.autoHideEnabled = false; this.contents = ""; this.url = ""; this.windowProperties = "toolbar=no,location=no,status=no,menubar=no,scrollbars=auto,resizable,alwaysRaised,dependent,titlebar=no"; if (arguments.length > 0) { this.type = "DIV"; this.divName = arguments[0]; } else { this.type = "WINDOW"; } this.use_gebi = false; this.use_css = false; this.use_layers = false; if (document.getElementById) { this.use_gebi = true; } else if (document.all) { this.use_css = true; } else if (document.layers) { this.use_layers = true; } else { this.type = "WINDOW"; } this.offsetX = 0; this.offsetY = 0; this.getXYPosition = PopupWindow_getXYPosition; this.populate = PopupWindow_populate; this.setUrl = PopupWindow_setUrl; this.setWindowProperties = PopupWindow_setWindowProperties; this.refresh = PopupWindow_refresh; this.showPopup = PopupWindow_showPopup; this.hidePopup = PopupWindow_hidePopup; this.setSize = PopupWindow_setSize; this.isClicked = PopupWindow_isClicked; this.autoHide = PopupWindow_autoHide; this.hideIfNotClicked = PopupWindow_hideIfNotClicked; }

        /* SOURCE FILE: CalendarPopup.js */

        function CalendarPopup() { var c; if (arguments.length > 0) { c = new PopupWindow(arguments[0]); } else { c = new PopupWindow(); c.setSize(150, 175); } c.offsetX = -90; c.offsetY = 25; c.autoHide(); c.monthNames = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"); c.monthAbbreviations = new Array("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"); c.dayHeaders = new Array("S", "M", "T", "W", "T", "F", "S"); c.returnFunction = "CP_tmpReturnFunction"; c.returnMonthFunction = "CP_tmpReturnMonthFunction"; c.returnQuarterFunction = "CP_tmpReturnQuarterFunction"; c.returnYearFunction = "CP_tmpReturnYearFunction"; c.weekStartDay = 0; c.isShowYearNavigation = false; c.displayType = "date"; c.disabledWeekDays = new Object(); c.disabledDatesExpression = ""; c.yearSelectStartOffset = 35; c.currentDate = null; c.todayText = "Today"; c.cssPrefix = ""; c.isShowNavigationDropdowns = false; c.isShowYearNavigationInput = false; window.CP_calendarObject = null; window.CP_targetInput = null; window.CP_dateFormat = "MM/dd/yyyy"; c.copyMonthNamesToWindow = CP_copyMonthNamesToWindow; c.setReturnFunction = CP_setReturnFunction; c.setReturnMonthFunction = CP_setReturnMonthFunction; c.setReturnQuarterFunction = CP_setReturnQuarterFunction; c.setReturnYearFunction = CP_setReturnYearFunction; c.setMonthNames = CP_setMonthNames; c.setMonthAbbreviations = CP_setMonthAbbreviations; c.setDayHeaders = CP_setDayHeaders; c.setWeekStartDay = CP_setWeekStartDay; c.setDisplayType = CP_setDisplayType; c.setDisabledWeekDays = CP_setDisabledWeekDays; c.addDisabledDates = CP_addDisabledDates; c.setYearSelectStartOffset = CP_setYearSelectStartOffset; c.setTodayText = CP_setTodayText; c.showYearNavigation = CP_showYearNavigation; c.showCalendar = CP_showCalendar; c.hideCalendar = CP_hideCalendar; c.getStyles = getCalendarStyles; c.refreshCalendar = CP_refreshCalendar; c.getCalendar = CP_getCalendar; c.select = CP_select; c.setCssPrefix = CP_setCssPrefix; c.showNavigationDropdowns = CP_showNavigationDropdowns; c.showYearNavigationInput = CP_showYearNavigationInput; c.copyMonthNamesToWindow(); return c; }
        function CP_copyMonthNamesToWindow() { if (typeof (window.MONTH_NAMES) != "undefined" && window.MONTH_NAMES != null) { window.MONTH_NAMES = new Array(); for (var i = 0; i < this.monthNames.length; i++) { window.MONTH_NAMES[window.MONTH_NAMES.length] = this.monthNames[i]; } for (var i = 0; i < this.monthAbbreviations.length; i++) { window.MONTH_NAMES[window.MONTH_NAMES.length] = this.monthAbbreviations[i]; } } }
        function CP_tmpReturnFunction(y, m, d) { if (window.CP_targetInput != null) { var dt = new Date(y, m - 1, d, 0, 0, 0); if (window.CP_calendarObject != null) { window.CP_calendarObject.copyMonthNamesToWindow(); } window.CP_targetInput.value = formatDate(dt, window.CP_dateFormat); } else { alert('Use setReturnFunction() to define which function will get the clicked results!'); } }
        function CP_tmpReturnMonthFunction(y, m) { alert('Use setReturnMonthFunction() to define which function will get the clicked results!\nYou clicked: year=' + y + ' , month=' + m); }
        function CP_tmpReturnQuarterFunction(y, q) { alert('Use setReturnQuarterFunction() to define which function will get the clicked results!\nYou clicked: year=' + y + ' , quarter=' + q); }
        function CP_tmpReturnYearFunction(y) { alert('Use setReturnYearFunction() to define which function will get the clicked results!\nYou clicked: year=' + y); }
        function CP_setReturnFunction(name) { this.returnFunction = name; }
        function CP_setReturnMonthFunction(name) { this.returnMonthFunction = name; }
        function CP_setReturnQuarterFunction(name) { this.returnQuarterFunction = name; }
        function CP_setReturnYearFunction(name) { this.returnYearFunction = name; }
        function CP_setMonthNames() { for (var i = 0; i < arguments.length; i++) { this.monthNames[i] = arguments[i]; } this.copyMonthNamesToWindow(); }
        function CP_setMonthAbbreviations() { for (var i = 0; i < arguments.length; i++) { this.monthAbbreviations[i] = arguments[i]; } this.copyMonthNamesToWindow(); }
        function CP_setDayHeaders() { for (var i = 0; i < arguments.length; i++) { this.dayHeaders[i] = arguments[i]; } }
        function CP_setWeekStartDay(day) { this.weekStartDay = day; }
        function CP_showYearNavigation() { this.isShowYearNavigation = (arguments.length > 0) ? arguments[0] : true; }
        function CP_setDisplayType(type) { if (type != "date" && type != "week-end" && type != "month" && type != "quarter" && type != "year") { alert("Invalid display type! Must be one of: date,week-end,month,quarter,year"); return false; } this.displayType = type; }
        function CP_setYearSelectStartOffset(num) { this.yearSelectStartOffset = num; }
        function CP_setDisabledWeekDays() { this.disabledWeekDays = new Object(); for (var i = 0; i < arguments.length; i++) { this.disabledWeekDays[arguments[i]] = true; } }
        function CP_addDisabledDates(start, end) { if (arguments.length == 1) { end = start; } if (start == null && end == null) { return; } if (this.disabledDatesExpression != "") { this.disabledDatesExpression += "||"; } if (start != null) { start = parseDate(start); start = "" + start.getFullYear() + LZ(start.getMonth() + 1) + LZ(start.getDate()); } if (end != null) { end = parseDate(end); end = "" + end.getFullYear() + LZ(end.getMonth() + 1) + LZ(end.getDate()); } if (start == null) { this.disabledDatesExpression += "(ds<=" + end + ")"; } else if (end == null) { this.disabledDatesExpression += "(ds>=" + start + ")"; } else { this.disabledDatesExpression += "(ds>=" + start + "&&ds<=" + end + ")"; } }
        function CP_setTodayText(text) { this.todayText = text; }
        function CP_setCssPrefix(val) { this.cssPrefix = val; }
        function CP_showNavigationDropdowns() { this.isShowNavigationDropdowns = (arguments.length > 0) ? arguments[0] : true; }
        function CP_showYearNavigationInput() { this.isShowYearNavigationInput = (arguments.length > 0) ? arguments[0] : true; }
        function CP_hideCalendar() { if (arguments.length > 0) { window.popupWindowObjects[arguments[0]].hidePopup(); } else { this.hidePopup(); } }
        function CP_refreshCalendar(index) { var calObject = window.popupWindowObjects[index]; if (arguments.length > 1) { calObject.populate(calObject.getCalendar(arguments[1], arguments[2], arguments[3], arguments[4], arguments[5])); } else { calObject.populate(calObject.getCalendar()); } calObject.refresh(); }
        function CP_showCalendar(anchorname) { if (arguments.length > 1) { if (arguments[1] == null || arguments[1] == "") { this.currentDate = new Date(); } else { this.currentDate = new Date(parseDate(arguments[1])); } } this.populate(this.getCalendar()); this.showPopup(anchorname); }
        function CP_select(inputobj, linkname, format) { var selectedDate = (arguments.length > 3) ? arguments[3] : null; if (!window.getDateFromFormat) { alert("calendar.select: To use this method you must also include 'date.js' for date formatting"); return; } if (this.displayType != "date" && this.displayType != "week-end") { alert("calendar.select: This function can only be used with displayType 'date' or 'week-end'"); return; } if (inputobj.type != "text" && inputobj.type != "hidden" && inputobj.type != "textarea") { alert("calendar.select: Input object passed is not a valid form input object"); window.CP_targetInput = null; return; } if (inputobj.disabled) { return; } window.CP_targetInput = inputobj; window.CP_calendarObject = this; this.currentDate = null; var time = 0; if (selectedDate != null) { time = getDateFromFormat(selectedDate, format) } else if (inputobj.value != "") { time = getDateFromFormat(inputobj.value, format); } if (selectedDate != null || inputobj.value != "") { if (time == 0) { this.currentDate = null; } else { this.currentDate = new Date(time); } } window.CP_dateFormat = format; this.showCalendar(linkname); }
        function getCalendarStyles() { var result = ""; var p = ""; if (this != null && typeof (this.cssPrefix) != "undefined" && this.cssPrefix != null && this.cssPrefix != "") { p = this.cssPrefix; } result += "<STYLE>\n"; result += "." + p + "cpYearNavigation,." + p + "cpMonthNavigation{background-color:#C0C0C0;text-align:center;vertical-align:center;text-decoration:none;color:#000000;label-weight:bold;}\n"; result += "." + p + "cpDayColumnHeader, ." + p + "cpYearNavigation,." + p + "cpMonthNavigation,." + p + "cpCurrentMonthDate,." + p + "cpCurrentMonthDateDisabled,." + p + "cpOtherMonthDate,." + p + "cpOtherMonthDateDisabled,." + p + "cpCurrentDate,." + p + "cpCurrentDateDisabled,." + p + "cpTodayText,." + p + "cpTodayTextDisabled,." + p + "cpText{label-family:arial;label-size:8pt;}\n"; result += "TD." + p + "cpDayColumnHeader{text-align:right;border:solid thin #C0C0C0;border-width:0px 0px 1px 0px;}\n"; result += "." + p + "cpCurrentMonthDate, ." + p + "cpOtherMonthDate, ." + p + "cpCurrentDate{text-align:right;text-decoration:none;}\n"; result += "." + p + "cpCurrentMonthDateDisabled, ." + p + "cpOtherMonthDateDisabled, ." + p + "cpCurrentDateDisabled{color:#D0D0D0;text-align:right;text-decoration:line-through;}\n"; result += "." + p + "cpCurrentMonthDate, .cpCurrentDate{color:#000000;}\n"; result += "." + p + "cpOtherMonthDate{color:#808080;}\n"; result += "TD." + p + "cpCurrentDate{color:white;background-color: #C0C0C0;border-width:1px;border:solid thin #800000;}\n"; result += "TD." + p + "cpCurrentDateDisabled{border-width:1px;border:solid thin #FFAAAA;}\n"; result += "TD." + p + "cpTodayText, TD." + p + "cpTodayTextDisabled{border:solid thin #C0C0C0;border-width:1px 0px 0px 0px;}\n"; result += "A." + p + "cpTodayText, SPAN." + p + "cpTodayTextDisabled{height:20px;}\n"; result += "A." + p + "cpTodayText{color:black;}\n"; result += "." + p + "cpTodayTextDisabled{color:#D0D0D0;}\n"; result += "." + p + "cpBorder{border:solid thin #808080;}\n"; result += "</STYLE>\n"; return result; }
        function CP_getCalendar() { var now = new Date(); if (this.type == "WINDOW") { var windowref = "window.opener."; } else { var windowref = ""; } var result = ""; if (this.type == "WINDOW") { result += "<HTML><HEAD><TITLE>Calendar</TITLE>" + this.getStyles() + "</HEAD><BODY MARGINWIDTH=0 MARGINHEIGHT=0 TOPMARGIN=0 RIGHTMARGIN=0 LEFTMARGIN=0>\n"; result += '<CENTER><TABLE WIDTH=100% BORDER=0 BORDERWIDTH=0 CELLSPACING=0 CELLPADDING=0>\n'; } else { result += '<TABLE CLASS="' + this.cssPrefix + 'cpBorder" WIDTH=144 BORDER=1 BORDERWIDTH=1 CELLSPACING=0 CELLPADDING=1>\n'; result += '<TR><TD ALIGN=CENTER>\n'; result += '<CENTER>\n'; } if (this.displayType == "date" || this.displayType == "week-end") { if (this.currentDate == null) { this.currentDate = now; } if (arguments.length > 0) { var month = arguments[0]; } else { var month = this.currentDate.getMonth() + 1; } if (arguments.length > 1 && arguments[1] > 0 && arguments[1] - 0 == arguments[1]) { var year = arguments[1]; } else { var year = this.currentDate.getFullYear(); } var daysinmonth = new Array(0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31); if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) { daysinmonth[2] = 29; } var current_month = new Date(year, month - 1, 1); var display_year = year; var display_month = month; var display_date = 1; var weekday = current_month.getDay(); var offset = 0; offset = (weekday >= this.weekStartDay) ? weekday - this.weekStartDay : 7 - this.weekStartDay + weekday; if (offset > 0) { display_month--; if (display_month < 1) { display_month = 12; display_year--; } display_date = daysinmonth[display_month] - offset + 1; } var next_month = month + 1; var next_month_year = year; if (next_month > 12) { next_month = 1; next_month_year++; } var last_month = month - 1; var last_month_year = year; if (last_month < 1) { last_month = 12; last_month_year--; } var date_class; if (this.type != "WINDOW") { result += "<TABLE WIDTH=144 BORDER=0 BORDERWIDTH=0 CELLSPACING=0 CELLPADDING=0>"; } result += '<TR>\n'; var refresh = windowref + 'CP_refreshCalendar'; var refreshLink = 'javascript:' + refresh; if (this.isShowNavigationDropdowns) { result += '<TD CLASS="' + this.cssPrefix + 'cpMonthNavigation" WIDTH="78" COLSPAN="3"><select CLASS="' + this.cssPrefix + 'cpMonthNavigation" name="cpMonth" onChange="' + refresh + '(' + this.index + ',this.options[this.selectedIndex].value-0,' + (year - 0) + ');">'; for (var monthCounter = 1; monthCounter <= 12; monthCounter++) { var selected = (monthCounter == month) ? 'SELECTED' : ''; result += '<option value="' + monthCounter + '" ' + selected + '>' + this.monthNames[monthCounter - 1] + '</option>'; } result += '</select></TD>'; result += '<TD CLASS="' + this.cssPrefix + 'cpMonthNavigation" WIDTH="10">&nbsp;</TD>'; result += '<TD CLASS="' + this.cssPrefix + 'cpYearNavigation" WIDTH="56" COLSPAN="3"><select CLASS="' + this.cssPrefix + 'cpYearNavigation" name="cpYear" onChange="' + refresh + '(' + this.index + ',' + month + ',this.options[this.selectedIndex].value-0);">'; for (var yearCounter = year - this.yearSelectStartOffset; yearCounter <= year + this.yearSelectStartOffset; yearCounter++) { var selected = (yearCounter == year) ? 'SELECTED' : ''; result += '<option value="' + yearCounter + '" ' + selected + '>' + yearCounter + '</option>'; } result += '</select></TD>'; } else { if (this.isShowYearNavigation) { result += '<TD CLASS="' + this.cssPrefix + 'cpMonthNavigation" WIDTH="10"><A CLASS="' + this.cssPrefix + 'cpMonthNavigation" HREF="' + refreshLink + '(' + this.index + ',' + last_month + ',' + last_month_year + ');">&lt;</A></TD>'; result += '<TD CLASS="' + this.cssPrefix + 'cpMonthNavigation" WIDTH="58"><SPAN CLASS="' + this.cssPrefix + 'cpMonthNavigation">' + this.monthNames[month - 1] + '</SPAN></TD>'; result += '<TD CLASS="' + this.cssPrefix + 'cpMonthNavigation" WIDTH="10"><A CLASS="' + this.cssPrefix + 'cpMonthNavigation" HREF="' + refreshLink + '(' + this.index + ',' + next_month + ',' + next_month_year + ');">&gt;</A></TD>'; result += '<TD CLASS="' + this.cssPrefix + 'cpMonthNavigation" WIDTH="10">&nbsp;</TD>'; result += '<TD CLASS="' + this.cssPrefix + 'cpYearNavigation" WIDTH="10"><A CLASS="' + this.cssPrefix + 'cpYearNavigation" HREF="' + refreshLink + '(' + this.index + ',' + month + ',' + (year - 1) + ');">&lt;</A></TD>'; if (this.isShowYearNavigationInput) { result += '<TD CLASS="' + this.cssPrefix + 'cpYearNavigation" WIDTH="36"><INPUT NAME="cpYear" CLASS="' + this.cssPrefix + 'cpYearNavigation" SIZE="4" MAXLENGTH="4" VALUE="' + year + '" onBlur="' + refresh + '(' + this.index + ',' + month + ',this.value-0);"></TD>'; } else { result += '<TD CLASS="' + this.cssPrefix + 'cpYearNavigation" WIDTH="36"><SPAN CLASS="' + this.cssPrefix + 'cpYearNavigation">' + year + '</SPAN></TD>'; } result += '<TD CLASS="' + this.cssPrefix + 'cpYearNavigation" WIDTH="10"><A CLASS="' + this.cssPrefix + 'cpYearNavigation" HREF="' + refreshLink + '(' + this.index + ',' + month + ',' + (year + 1) + ');">&gt;</A></TD>'; } else { result += '<TD CLASS="' + this.cssPrefix + 'cpMonthNavigation" WIDTH="22"><A CLASS="' + this.cssPrefix + 'cpMonthNavigation" HREF="' + refreshLink + '(' + this.index + ',' + last_month + ',' + last_month_year + ');">&lt;&lt;</A></TD>\n'; result += '<TD CLASS="' + this.cssPrefix + 'cpMonthNavigation" WIDTH="100"><SPAN CLASS="' + this.cssPrefix + 'cpMonthNavigation">' + this.monthNames[month - 1] + ' ' + year + '</SPAN></TD>\n'; result += '<TD CLASS="' + this.cssPrefix + 'cpMonthNavigation" WIDTH="22"><A CLASS="' + this.cssPrefix + 'cpMonthNavigation" HREF="' + refreshLink + '(' + this.index + ',' + next_month + ',' + next_month_year + ');">&gt;&gt;</A></TD>\n'; } } result += '</TR></TABLE>\n'; result += '<TABLE WIDTH=120 BORDER=0 CELLSPACING=0 CELLPADDING=1 ALIGN=CENTER>\n'; result += '<TR>\n'; for (var j = 0; j < 7; j++) { result += '<TD CLASS="' + this.cssPrefix + 'cpDayColumnHeader" WIDTH="14%"><SPAN CLASS="' + this.cssPrefix + 'cpDayColumnHeader">' + this.dayHeaders[(this.weekStartDay + j) % 7] + '</TD>\n'; } result += '</TR>\n'; for (var row = 1; row <= 6; row++) { result += '<TR>\n'; for (var col = 1; col <= 7; col++) { var disabled = false; if (this.disabledDatesExpression != "") { var ds = "" + display_year + LZ(display_month) + LZ(display_date); eval("disabled=(" + this.disabledDatesExpression + ")"); } var dateClass = ""; if ((display_month == this.currentDate.getMonth() + 1) && (display_date == this.currentDate.getDate()) && (display_year == this.currentDate.getFullYear())) { dateClass = "cpCurrentDate"; } else if (display_month == month) { dateClass = "cpCurrentMonthDate"; } else { dateClass = "cpOtherMonthDate"; } if (disabled || this.disabledWeekDays[col - 1]) { result += '	<TD CLASS="' + this.cssPrefix + dateClass + '"><SPAN CLASS="' + this.cssPrefix + dateClass + 'Disabled">' + display_date + '</SPAN></TD>\n'; } else { var selected_date = display_date; var selected_month = display_month; var selected_year = display_year; if (this.displayType == "week-end") { var d = new Date(selected_year, selected_month - 1, selected_date, 0, 0, 0, 0); d.setDate(d.getDate() + (7 - col)); selected_year = d.getYear(); if (selected_year < 1000) { selected_year += 1900; } selected_month = d.getMonth() + 1; selected_date = d.getDate(); } result += '	<TD CLASS="' + this.cssPrefix + dateClass + '"><A HREF="javascript:' + windowref + this.returnFunction + '(' + selected_year + ',' + selected_month + ',' + selected_date + ');' + windowref + 'CP_hideCalendar(\'' + this.index + '\');" CLASS="' + this.cssPrefix + dateClass + '">' + display_date + '</A></TD>\n'; } display_date++; if (display_date > daysinmonth[display_month]) { display_date = 1; display_month++; } if (display_month > 12) { display_month = 1; display_year++; } } result += '</TR>'; } var current_weekday = now.getDay() - this.weekStartDay; if (current_weekday < 0) { current_weekday += 7; } result += '<TR>\n'; result += '	<TD COLSPAN=7 ALIGN=CENTER CLASS="' + this.cssPrefix + 'cpTodayText">\n'; if (this.disabledDatesExpression != "") { var ds = "" + now.getFullYear() + LZ(now.getMonth() + 1) + LZ(now.getDate()); eval("disabled=(" + this.disabledDatesExpression + ")"); } if (disabled || this.disabledWeekDays[current_weekday + 1]) { result += '		<SPAN CLASS="' + this.cssPrefix + 'cpTodayTextDisabled">' + this.todayText + '</SPAN>\n'; } else { result += '		<A CLASS="' + this.cssPrefix + 'cpTodayText" HREF="javascript:' + windowref + this.returnFunction + '(\'' + now.getFullYear() + '\',\'' + (now.getMonth() + 1) + '\',\'' + now.getDate() + '\');' + windowref + 'CP_hideCalendar(\'' + this.index + '\');">' + this.todayText + '</A>\n'; } result += '		<BR>\n'; result += '	</TD></TR></TABLE></CENTER></TD></TR></TABLE>\n'; } if (this.displayType == "month" || this.displayType == "quarter" || this.displayType == "year") { if (arguments.length > 0) { var year = arguments[0]; } else { if (this.displayType == "year") { var year = now.getFullYear() - this.yearSelectStartOffset; } else { var year = now.getFullYear(); } } if (this.displayType != "year" && this.isShowYearNavigation) { result += "<TABLE WIDTH=144 BORDER=0 BORDERWIDTH=0 CELLSPACING=0 CELLPADDING=0>"; result += '<TR>\n'; result += '	<TD CLASS="' + this.cssPrefix + 'cpYearNavigation" WIDTH="22"><A CLASS="' + this.cssPrefix + 'cpYearNavigation" HREF="javascript:' + windowref + 'CP_refreshCalendar(' + this.index + ',' + (year - 1) + ');">&lt;&lt;</A></TD>\n'; result += '	<TD CLASS="' + this.cssPrefix + 'cpYearNavigation" WIDTH="100">' + year + '</TD>\n'; result += '	<TD CLASS="' + this.cssPrefix + 'cpYearNavigation" WIDTH="22"><A CLASS="' + this.cssPrefix + 'cpYearNavigation" HREF="javascript:' + windowref + 'CP_refreshCalendar(' + this.index + ',' + (year + 1) + ');">&gt;&gt;</A></TD>\n'; result += '</TR></TABLE>\n'; } } if (this.displayType == "month") { result += '<TABLE WIDTH=120 BORDER=0 CELLSPACING=1 CELLPADDING=0 ALIGN=CENTER>\n'; for (var i = 0; i < 4; i++) { result += '<TR>'; for (var j = 0; j < 3; j++) { var monthindex = ((i * 3) + j); result += '<TD WIDTH=33% ALIGN=CENTER><A CLASS="' + this.cssPrefix + 'cpText" HREF="javascript:' + windowref + this.returnMonthFunction + '(' + year + ',' + (monthindex + 1) + ');' + windowref + 'CP_hideCalendar(\'' + this.index + '\');" CLASS="' + date_class + '">' + this.monthAbbreviations[monthindex] + '</A></TD>'; } result += '</TR>'; } result += '</TABLE></CENTER></TD></TR></TABLE>\n'; } if (this.displayType == "quarter") { result += '<BR><TABLE WIDTH=120 BORDER=1 CELLSPACING=0 CELLPADDING=0 ALIGN=CENTER>\n'; for (var i = 0; i < 2; i++) { result += '<TR>'; for (var j = 0; j < 2; j++) { var quarter = ((i * 2) + j + 1); result += '<TD WIDTH=50% ALIGN=CENTER><BR><A CLASS="' + this.cssPrefix + 'cpText" HREF="javascript:' + windowref + this.returnQuarterFunction + '(' + year + ',' + quarter + ');' + windowref + 'CP_hideCalendar(\'' + this.index + '\');" CLASS="' + date_class + '">Q' + quarter + '</A><BR><BR></TD>'; } result += '</TR>'; } result += '</TABLE></CENTER></TD></TR></TABLE>\n'; } if (this.displayType == "year") { var yearColumnSize = 4; result += "<TABLE WIDTH=144 BORDER=0 BORDERWIDTH=0 CELLSPACING=0 CELLPADDING=0>"; result += '<TR>\n'; result += '	<TD CLASS="' + this.cssPrefix + 'cpYearNavigation" WIDTH="50%"><A CLASS="' + this.cssPrefix + 'cpYearNavigation" HREF="javascript:' + windowref + 'CP_refreshCalendar(' + this.index + ',' + (year - (yearColumnSize * 2)) + ');">&lt;&lt;</A></TD>\n'; result += '	<TD CLASS="' + this.cssPrefix + 'cpYearNavigation" WIDTH="50%"><A CLASS="' + this.cssPrefix + 'cpYearNavigation" HREF="javascript:' + windowref + 'CP_refreshCalendar(' + this.index + ',' + (year + (yearColumnSize * 2)) + ');">&gt;&gt;</A></TD>\n'; result += '</TR></TABLE>\n'; result += '<TABLE WIDTH=120 BORDER=0 CELLSPACING=1 CELLPADDING=0 ALIGN=CENTER>\n'; for (var i = 0; i < yearColumnSize; i++) { for (var j = 0; j < 2; j++) { var currentyear = year + (j * yearColumnSize) + i; result += '<TD WIDTH=50% ALIGN=CENTER><A CLASS="' + this.cssPrefix + 'cpText" HREF="javascript:' + windowref + this.returnYearFunction + '(' + currentyear + ');' + windowref + 'CP_hideCalendar(\'' + this.index + '\');" CLASS="' + date_class + '">' + currentyear + '</A></TD>'; } result += '</TR>'; } result += '</TABLE></CENTER></TD></TR></TABLE>\n'; } if (this.type == "WINDOW") { result += "</BODY></HTML>\n"; } return result; }
        
    </script>

    <script language="javascript" type="text/javascript">

        var cal = new CalendarPopup("divDate");

        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
        
    </script>

    <script language="javascript" type="text/javascript">

        // JScript File

        var months = new Array("", "January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December");

        var dtCh = "/";
        var minYear = 1900;
        var maxYear = 2100;

        function isInteger(s) {
            for (var i = 0; i < s.length; i++) {
                // Check that current character is number.
                var c = s.charAt(i);
                if (((c < "0") || (c > "9"))) return false;
            }
            // All characters are numbers.
            return true;
        }

        function stripCharsInBag(s, bag) {
            var returnString = "";
            // Search through string's characters one by one.
            // If character is not in bag, append to returnString.
            for (var i = 0; i < s.length; i++) {
                var c = s.charAt(i);
                if (bag.indexOf(c) == -1) returnString += c;
            }

            return returnString;
        }

        function daysInFebruary(year) {
            // February has 29 days in any year evenly divisible by four,
            // EXCEPT for centurial years which are not also divisible by 400.
            return (((year % 4 == 0) && ((!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28);
        }

        function DaysArray(n) {
            for (var i = 1; i <= n; i++) {
                this[i] = 31
                if (i == 4 || i == 6 || i == 9 || i == 11) { this[i] = 30 }
                if (i == 2) { this[i] = 29 }
            }

            return this
        }

        function isDate1(dtStr) {
            var daysInMonth = DaysArray(12)
            var pos1 = dtStr.indexOf(dtCh)
            var pos2 = dtStr.indexOf(dtCh, pos1 + 1)
            var strDay = dtStr.substring(0, pos1)
            var strMonth = dtStr.substring(pos1 + 1, pos2)
            var strYear = dtStr.substring(pos2 + 1)

            strYr = strYear

            if (strDay.charAt(0) == "0" && strDay.length > 1) strDay = strDay.substring(1)
            if (strMonth.charAt(0) == "0" && strMonth.length > 1) strMonth = strMonth.substring(1)

            for (var i = 1; i <= 3; i++) {
                if (strYr.charAt(0) == "0" && strYr.length > 1) strYr = strYr.substring(1)
            }

            month = parseInt(strMonth)
            day = parseInt(strDay)
            year = parseInt(strYr)

            if (pos1 == -1 || pos2 == -1) {
                alert("The date format should be : dd/mm/yyyy")
                return false
            }

            if (strDay.length < 1 || day < 1 || day > 31 || (month == 2 && day > daysInFebruary(year)) || day > daysInMonth[month]) {
                alert("Please enter a valid day")
                return false
            }

            if (strMonth.length < 1 || month < 1 || month > 12) {
                alert("Please enter a valid month")
                return false
            }

            if (strYear.length != 4 || year == 0 || year < minYear || year > maxYear) {
                alert("Please enter a valid 4 digit year between " + minYear + " and " + maxYear)
                return false
            }

            if (dtStr.indexOf(dtCh, pos2 + 1) != -1 || isInteger(stripCharsInBag(dtStr, dtCh)) == false) {
                alert("Please enter a valid date")
                return false
            }

            return true
        }

        function ValidateTime(objMF, strHHMM) {
            objMF.value = trimAll(objMF.value);

            if (objMF.value == "") {
                if (strHHMM == "2") {
                    alert("Enter Time in Minutes between 1 & 59");
                }
                else {
                    alert("Enter Time in Hours between 1 & 23");
                }
                return false;
            }

            if (strHHMM == "1") {
                if (IsNumericWoDot(objMF.value) == false) {
                    alert("Enter Time in Hours between 1 & 23");
                    return false;
                }

                if (eval(objMF.value) < 1 && eval(objMF.value) > 23) {
                    alert("Enter Time in Hours between 1 & 23");
                    return false;
                }
            }
            else {
                if (IsNumericWoDot(objMF.value) == false) {
                    alert("Enter Time in Minutes between 1 & 59");
                    return false;
                }

                if (eval(objMF.value) < 1 && eval(objMF.value) > 59) {
                    alert("Enter Time in Minutes between 1 & 59");
                    return false;
                }
            }
        }

        function ValidateDate(obj) {
            if (obj.value != "") {
                var dockdt = obj.value

                if (dockdt.length < 10) {
                    alert("Please enter the date in dd/mm/yyyy format")
                    obj.focus();
                    return false;
                }

                if (isDate1(obj.value) == false) {
                    obj.focus()
                    return false
                }

                return true
            }
        }

        function MyDateDiff(start, end, interval, rounding) {
            var iOut = 0;
            var bufferA = Date.parse(start);
            var bufferB = Date.parse(end);

            // check that the start parameter is a valid Date. 
            if (isNaN(bufferA) || isNaN(bufferB)) {
                alert(startMsg);
                return null;
            }

            // check that an interval parameter was not numeric. 
            if (interval.charAt == 'undefined') {
                // the user specified an incorrect interval, handle the error. 
                alert(intervalMsg);
                return null;
            }

            var number = bufferB - bufferA;

            // what kind of add to do? 
            switch (interval.charAt(0)) {
                case 'd': case 'D':
                    iOut = parseInt(number / 86400000);
                    if (rounding) iOut += parseInt((number % 86400000) / 43200001);
                    break;
                case 'h': case 'H':
                    iOut = parseInt(number / 3600000);
                    if (rounding) iOut += parseInt((number % 3600000) / 1800001);
                    break;
                case 'm': case 'M':
                    iOut = parseInt(number / 60000);
                    if (rounding) iOut += parseInt((number % 60000) / 30001);
                    break;
                case 's': case 'S':
                    iOut = parseInt(number / 1000);
                    if (rounding) iOut += parseInt((number % 1000) / 501);
                    break;
                default:
                    // If we get to here then the interval parameter
                    // didn't meet the d,h,m,s criteria.  Handle
                    // the error. 		
                    alert(intervalMsg);
                    return null;
            }

            return iOut;
        }

        function trimAll(strValue) {
            //Trimming left most white space characters
            while (strValue.substring(0, 1) == ' ') {
                strValue = strValue.substring(1, strValue.length);
            }
            //Trimming right most white space characters
            while (strValue.substring(strValue.length - 1, strValue.length) == ' ') {
                strValue = strValue.substring(0, strValue.length - 1);
            }

            return strValue;
        }

        function IsNumeric(sText) {
            var ValidChars = "0123456789.";
            var IsNumber = true;
            var Char;

            for (i = 0; i < sText.length && IsNumber == true; i++) {
                Char = sText.charAt(i);

                if (ValidChars.indexOf(Char) == -1) {
                    IsNumber = false;
                }
            }

            return IsNumber;
        }

        function IsNumericWoDot(sText) {
            var ValidChars = "0123456789";
            var IsNumber = true;
            var Char;

            for (i = 0; i < sText.length && IsNumber == true; i++) {
                Char = sText.charAt(i);

                if (ValidChars.indexOf(Char) == -1) {
                    IsNumber = false;
                }
            }

            return IsNumber;
        }

        function Nagative_Chk_wDecimal(obj) {
            //debugger
            var temp = trimAll(obj.value)

            if (temp == "") {
                /*alert("Value can not be blank")
                obj.focus();
                return false;*/
                return true;
            }

            if (isNaN(temp)) {
                //alert("Value should be Numeric")
                obj.focus();
                return false;
            }

            if (parseFloat(temp) < 0) {
                alert("Value should be greater than zero")
                obj.focus();
                return false;
            }

            //obj.value=roundit(temp) 

            return true;
        }

        function Nagative_Chk_woDecimal(obj) {
            var temp = obj.value

            if (temp == "") {
                alert("Value can not be blank")
                obj.focus();
                return false;
            }

            if (isNaN(temp)) {
                alert("Value should be Numeric")
                obj.focus();
                return false;
            }

            if (parseFloat(temp) < 0) {
                alert("Value should be greater than zero")
                obj.focus();
                return false;
            }

            if (temp.indexOf(".") > 0) {
                alert("Value should not contain decimal point")
                obj.focus();
                return false;
            }

            obj.value = Math.round(temp)

            return true;
        }

        function rounditn(Num, decplaces) {
            Places = decplaces

            if (Places > 0) {
                if ((Num.toString().length - Num.toString().lastIndexOf('.')) > (Places + 1)) {
                    if (Num.toString().lastIndexOf('.') < 0) {
                        return Num.toString() + '.00';
                    }

                    var Rounder = Math.pow(10, Places);

                    return Math.round(Num * Rounder) / Rounder;
                }
                else {
                    if (Num.toString().lastIndexOf('.') < 0) {
                        return Num.toString() + '.00';
                    }
                    else {
                        if (Num.toString().lastIndexOf('.') + 1 == Num.toString().length - 1)
                            return Num.toString() + '0';
                        else
                            return Num.toString();
                    }
                }
            }
            else {
                return Math.round(Num);
            }
        }

        function roundit(Num) {
            Places = 2

            if (Places > 0) {
                if ((Num.toString().length - Num.toString().lastIndexOf('.')) > (Places + 1)) {
                    if (Num.toString().lastIndexOf('.') < 0) {
                        return Num.toString() + '.00';
                    }

                    var Rounder = Math.pow(10, Places);

                    return Math.round(Num * Rounder) / Rounder;
                }
                else {
                    if (Num.toString().lastIndexOf('.') < 0) {
                        return Num.toString() + '.00';
                    }
                    else {
                        if (Num.toString().lastIndexOf('.') + 1 == Num.toString().length - 1) {
                            return Num.toString() + '0';
                        }
                        else {
                            return Num.toString();
                        }
                    }
                }
            }
            else {
                return Math.round(Num);
            }
        }
        
    </script>

    <script language="javascript" type="text/javascript">

        function nwOpen(mNo) {
            window.open("popupbranch.aspx?" + mNo, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        function nwOpenCity(mNo) {
            var state = mNo + "|" + document.getElementById("ctl00_MyCPH1_hidstate").value
            window.open("popupCity.aspx?" + state, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }

        function Payment_Type_Clicked(objPayType) {
            if (objPayType.checked == true) {
                if (document.getElementById("ctl00_MyCPH1_hidPayType").value == "") {
                    document.getElementById("ctl00_MyCPH1_hidPayType").value = objPayType.value;
                }
                else {
                    if (CheckPayType(objPayType.value) == false) {
                        document.getElementById("ctl00_MyCPH1_hidPayType").value = document.getElementById("ctl00_MyCPH1_hidPayType").value + "," + objPayType.value;
                    }
                }
            }
            else {
                var mArrPayType = document.getElementById("ctl00_MyCPH1_hidPayType").value.split(",");
                var mPayType = "";

                for (var mLoopCounter = 0; mLoopCounter < mArrPayType.length; mLoopCounter++) {
                    if (objPayType.value != mArrPayType[mLoopCounter]) {
                        mPayType = (mPayType == "" ? mArrPayType[mLoopCounter] : mPayType + "," + mArrPayType[mLoopCounter]);
                    }
                }

                //                mPayType = mPayType.replace(objPayType.value, "");
                //                mPayType = mPayType.replace(objPayType.value + ",", "");
                //                mPayType = mPayType.replace("," + objPayType.value, "");
                document.getElementById("ctl00_MyCPH1_hidPayType").value = mPayType
            }

            alert(document.getElementById("ctl00_MyCPH1_hidPayType").value);
        }

        function CheckPayType(mPayType) {
            var mArrPayType = document.getElementById("ctl00_MyCPH1_hidPayType").value.split(",");

            for (var mLoopCounter = 0; mLoopCounter < mArrPayType.length; mLoopCounter++) {
                if (mPayType == mArrPayType[mLoopCounter]) {
                    return true;
                }
            }

            return false;
        }

        function IsNumericWoDot(sText) {
            var ValidChars = "0123456789";
            var IsNumber = true;
            var Char;

            for (i = 0; i < sText.length && IsNumber == true; i++) {
                Char = sText.charAt(i);

                if (ValidChars.indexOf(Char) == -1) {
                    IsNumber = false;
                }
            }

            return IsNumber;
        }

        function IsText(sText) {
            var ValidChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            var IsText = true;
            var Char;

            for (i = 0; i < sText.length && IsText == true; i++) {
                Char = sText.charAt(i);

                if (ValidChars.indexOf(Char) == -1) {
                    IsText = false;
                }
            }

            return IsText;
        }

        function ValidateData() {
            //debugger
            if (document.getElementById("ctl00_MyCPH1_ddLocHir")) {
                if (document.getElementById("ctl00_MyCPH1_ddLocHir").value == "--Select--") {
                    alert("Enter Location Hirearchy");
                    document.getElementById("ctl00_MyCPH1_ddLocHir").focus();
                    return false;
                }
            }
            if (document.getElementById("ctl00_MyCPH1_ddRptTo")) {
                if (document.getElementById("ctl00_MyCPH1_ddRptTo").value == "--Select--") {
                    alert("Enter Reporting to");
                    document.getElementById("ctl00_MyCPH1_ddRptTo").focus();
                    return false;
                }
            }
            if (document.getElementById("ctl00_MyCPH1_ddRptLoc")) {
                if (document.getElementById("ctl00_MyCPH1_ddRptLoc").value == "--Select--") {
                    alert("Enter Reporting Location");
                    document.getElementById("ctl00_MyCPH1_ddRptLoc").focus();
                    return false;
                }
            }
            if (document.getElementById("ctl00_MyCPH1_txtLocCod")) {
                if (document.getElementById("ctl00_MyCPH1_txtLocCod").value == "") {
                    alert("Enter Location Code");
                    document.getElementById("ctl00_MyCPH1_txtLocCod").focus();
                    return false;
                }
                else if (IsText(document.getElementById("ctl00_MyCPH1_txtLocCod").value) == false) {
                    alert("Enter Location Code in text format");
                    document.getElementById("ctl00_MyCPH1_txtLocCod").focus();
                    return false;
                }
                else if (document.getElementById("ctl00_MyCPH1_lblErrorLocation")) {
                    if (document.getElementById("ctl00_MyCPH1_lblErrorLocation").style.display == '') {
                        alert("Invalid 'Location Code'");
                        document.getElementById("ctl00_MyCPH1_txtLocCod").focus();
                        return false;
                    }
                }
            }
            if (document.getElementById("ctl00_MyCPH1_txtLocNm")) {
                if (document.getElementById("ctl00_MyCPH1_txtLocNm").value == "") {
                    alert("Enter Location Name");
                    document.getElementById("ctl00_MyCPH1_txtLocNm").focus();
                    return false;
                }
                //                    else if(IsText(document.getElementById("ctl00_MyCPH1_txtLocNm").value) == false)
                //                    {
                //                        alert("Enter Location Name in alphabet format");
                //                        document.getElementById("ctl00_MyCPH1_txtLocNm").focus();
                //                        return false;
                //                    }
            }
            if (document.getElementById("ctl00_MyCPH1_txtPin")) {
                //                    if(document.getElementById("ctl00_MyCPH1_txtPin").value == "")
                //                    {
                //                        alert("Enter Rail Day");
                //                        document.getElementById("ctl00_MyCPH1_txtPin").focus();
                //                        return false;
                //                    }
                //                    else
                if (IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtPin").value) == false) {
                    alert("Enter Pin Code in Postive Numeric Format");
                    document.getElementById("ctl00_MyCPH1_txtPin").focus();
                    return false;
                }
            }
            if (document.getElementById("ctl00_MyCPH1_ddState")) {
                if (document.getElementById("ctl00_MyCPH1_ddState").value == "--Select--") {
                    alert("Enter State");
                    document.getElementById("ctl00_MyCPH1_ddState").focus();
                    return false;
                }
            }
            if (document.getElementById("ctl00_MyCPH1_TextBox6")) {
                if (document.getElementById("ctl00_MyCPH1_lblErrorCity")) {
                    if (document.getElementById("ctl00_MyCPH1_lblErrorCity").style.display == '') {
                        alert("Invalid 'City'");
                        document.getElementById("ctl00_MyCPH1_TextBox6").focus();
                        return false;
                    }
                }
            }
            //                if(document.getElementById("ctl00_MyCPH1_txtCNCod"))
            //                {
            //                    if(document.getElementById("ctl00_MyCPH1_txtCNCod").value == "")
            //                    {
            //                        alert("Enter CN Prefix Code");
            //                        document.getElementById("ctl00_MyCPH1_txtCNCod").focus();
            //                        return false;
            //                    }
            //                    else if(IsText(document.getElementById("ctl00_MyCPH1_txtCNCod").value) == false)
            //                    {
            //                        alert("Do not use any symbol in CN Prefix Code");
            //                        document.getElementById("ctl00_MyCPH1_txtCNCod").focus();
            //                        return false;
            //                    }
            //                }
            if (document.getElementById("ctl00_MyCPH1_txtStdCod")) {
                if (IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtStdCod").value) == false) {
                    alert("Enter STD Code in Positive Numeric Format");
                    document.getElementById("ctl00_MyCPH1_txtStdCod").focus();
                    return false;
                }
            }
            if (document.getElementById("ctl00_MyCPH1_txtTel")) {
                if (IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtTel").value) == false) {
                    alert("Enter Telephone Number in Positive Numeric Format");
                    document.getElementById("ctl00_MyCPH1_txtTel").focus();
                    return false;
                }
            }
            //if (document.getElementById("ctl00_MyCPH1_txtFax")) {
            //    if (IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtFax").value) == false) {
            //        alert("Enter Telephone Number in Positive Numeric Format");
            //        document.getElementById("ctl00_MyCPH1_txtFax").focus();
            //        return false;
            //    }
            //}
            if (document.getElementById("ctl00_MyCPH1_txtMob")) {
                if (IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtMob").value) == false) {
                    alert("Enter Mobile Number in Positive Numeric Format");
                    document.getElementById("ctl00_MyCPH1_txtMob").focus();
                    return false;
                }
            }
            if (document.getElementById("ctl00_MyCPH1_ddRgLoc")) {
                if (document.getElementById("ctl00_MyCPH1_ddRgLoc").value == "--Select--") {
                    alert("Enter Region Location");
                    document.getElementById("ctl00_MyCPH1_ddRgLoc").focus();
                    return false;
                }
            }
            if (document.getElementById("ctl00_MyCPH1_TextBox16")) {
                if (document.getElementById("ctl00_MyCPH1_TextBox16").value == "") {
                    alert("Enter Location Start Date");
                    document.getElementById("ctl00_MyCPH1_TextBox16").focus();
                    return false;
                }
            }
            //                if(document.getElementById("ctl00_MyCPH1_txtBkStrDt"))
            //                {
            //                    if(document.getElementById("ctl00_MyCPH1_txtBkStrDt").value == "")
            //                    {
            //                        alert("Enter Booking Start Date");
            //                        document.getElementById("ctl00_MyCPH1_txtBkStrDt").focus();
            //                        return false;
            //                    }
            //                }
            //                if(document.getElementById("ctl00_MyCPH1_txtdlStrDt"))
            //                {
            //                    if(document.getElementById("ctl00_MyCPH1_txtdlStrDt").value == "")
            //                    {
            //                        alert("Enter Delievery Start Date");
            //                        document.getElementById("ctl00_MyCPH1_txtdlStrDt").focus();
            //                        return false;
            //                    }
            //                }
            //                if(document.getElementById("ctl00_MyCPH1_txttransStrDT"))
            //                {
            //                    if(document.getElementById("ctl00_MyCPH1_txttransStrDT").value == "")
            //                    {
            //                        alert("Enter Tranship Start Date");
            //                        document.getElementById("ctl00_MyCPH1_txttransStrDT").focus();
            //                        return false;
            //                    }
            //                }
            if (document.getElementById("ctl00_MyCPH1_ddLocOnr")) {
                if (document.getElementById("ctl00_MyCPH1_ddLocOnr").value == "--Select--") {
                    alert("Enter Location Ownership");
                    document.getElementById("ctl00_MyCPH1_ddLocOnr").focus();
                    return false;
                }
            }
            if (document.getElementById("ctl00_MyCPH1_DropDownList1")) {
                if (document.getElementById("ctl00_MyCPH1_DropDownList1").style.display == '')   // .style.display == 'none' for false.
                {
                    if (document.getElementById("ctl00_MyCPH1_DropDownList1").value == "--Select--") {
                        alert("Enter Octroi");
                        document.getElementById("ctl00_MyCPH1_DropDownList1").focus();
                        return false;
                    }
                }
            }
            var mToday = "<%=strToday %>";
            mToday = mToday.substring(3, 5) + "/" + mToday.substring(0, 2) + "/" + mToday.substring(6, 10);
            var mLocStartDate = document.getElementById("ctl00_MyCPH1_TextBox16").value;
            mLocStartDate = mLocStartDate.substring(3, 5) + "/" + mLocStartDate.substring(0, 2) + "/" + mLocStartDate.substring(6, 10);

            //Check for Date From and Date To Date range
            if (findDateDifference(mToday, mLocStartDate, "d") > 0) {
                alert("Enter Date Less Than Or Equal To Today!");
                document.getElementById("ctl00_MyCPH1_TextBox16").focus();
                return false;
            }

            if (document.getElementById("ctl00_MyCPH1_chkBkOpr").checked == true) {
                // var mBkgStartDate = document.getElementById("ctl00_MyCPH1_txtBkStrDt").value;
                //mBkgStartDate = mBkgStartDate.substring(3, 5) + "/" + mBkgStartDate.substring(0, 2) + "/" + mBkgStartDate.substring(6, 10);
                if (document.getElementById("ctl00_MyCPH1_txtBkStrDt").value != "") {
                    //                        if(findDateDifference(mToday, mBkgStartDate, "d") < 0)
                    //                        {
                    //                            alert("Enter Date Greater Than Today!");
                    //                            document.getElementById("ctl00_MyCPH1_txtBkStrDt").focus();
                    //                            return false;
                    //                        }
                }
                else {
                    alert("Please Enter Booking Start Date !!")
                    document.getElementById("ctl00_MyCPH1_txtBkStrDt").focus();
                    return false;
                }
            }
            if (document.getElementById("ctl00_MyCPH1_chkDly").checked == true) {
                //var mDelStartDate = document.getElementById("ctl00_MyCPH1_txtdlStrDt").value;
                //mDelStartDate = mDelStartDate.substring(3, 5) + "/" + mDelStartDate.substring(0, 2) + "/" + mDelStartDate.substring(6, 10);

                //Check for Date From and Date To Date range
                if (document.getElementById("ctl00_MyCPH1_txtdlStrDt").value != "") {
                    //                        if(findDateDifference(mToday, mDelStartDate, "d") < 0)
                    //                        {
                    //                            alert("Enter Date Greater Than Today!");
                    //                            document.getElementById("ctl00_MyCPH1_txtdlStrDt").focus();
                    //                            return false;
                    //                        }
                }
                else {
                    alert("Please Enter Delivery Start Date !!")
                    document.getElementById("ctl00_MyCPH1_txtdlStrDt").focus();
                    return false;
                }
            }
            if (document.getElementById("ctl00_MyCPH1_chktransOpr").checked == true) {
                //var mTrnStartDate = document.getElementById("ctl00_MyCPH1_txttransStrDT").value;
                //mTrnStartDate = mTrnStartDate.substring(3, 5) + "/" + mTrnStartDate.substring(0, 2) + "/" + mTrnStartDate.substring(6, 10);

                //Check for Date From and Date To Date range
                if (document.getElementById("ctl00_MyCPH1_txttransStrDT").value != "") {
                    //                        if(findDateDifference(mToday, mTrnStartDate, "d") < 0)
                    //                        {
                    //                            alert("Enter Date Greater Than Today!");
                    //                            document.getElementById("ctl00_MyCPH1_txttransStrDT").focus();
                    //                            return false;
                    //                        }
                }
                else {
                    alert("Please Enter Transhipment Start Date !!")
                    document.getElementById("ctl00_MyCPH1_txttransStrDT").focus();
                    return false;
                }
            }

            return true;
        }
                   
    </script>

    <input type="hidden" runat="server" id="hidPayType" />
    <div align="left" style="width: 10in">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height: 50px">
            <tr>
                <td>
                    <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%">
                        <tr>
                            <td height="30" style="width: 1443px">
                                <a href=""><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a href=""><font
                                    class="blklnkund"><b>Administrator</b></font></a> <b>&gt; </b><a href="../company_structure.aspx">
                                        <font class="blklnkund"><b>Company Structure</b></font></a> <b>&gt; </b>
                                <font class="bluefnt"><b>Location Master</b></font>
                            </td>
                            <td align="right" style="height: 33px; width: 519px;">
                                <a href="javascript:window.history.go(-1)" title="back">
                                    <img src="../../images/back.gif" border="0" alt="" /></a>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table style="width: 100%; height: 100%;">
            <tr>
                <td style="width: 959px">
                    <table border="0" width="100%" cellpadding="0" cellspacing="1" class="boxbg">
                        <tr class="bgbluegrey">
                            <td align="center" style="height: 17px">
                                <font class="blackfnt"><b>LOCATION MASTER</b></font>
                            </td>
                        </tr>
                    </table>
                    &nbsp;&nbsp;&nbsp;
                    <table border="0" width="100%" cellpadding="0" cellspacing="1" class="boxbg">
                        <tr>
                            <td>
                                <table border="0" width="100%">
                                    <tr bgcolor="#ffffff">
                                        <td align="left" style="width: 122px; height: 22px;">
                                            <font class="blackfnt">Location hierarchy:</font>
                                        </td>
                                        <td align="left" valign="top" style="width: 199px; height: 22px;">
                                            <asp:UpdatePanel ID="upLocHir" runat="server">
                                                <contenttemplate>
                                                    <asp:DropDownList ID="ddLocHir" runat="server" Width="97px" AutoPostBack="true" OnSelectedIndexChanged="ddLocHir_SelectedIndexChanged"
                                                        TabIndex="1">
                                                    </asp:DropDownList>
                                                </contenttemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                        <td align="left" style="width: 107px; height: 22px;">
                                            <font class="blackfnt">Reporting to:</font>
                                        </td>
                                        <td align="left" style="width: 194px; height: 22px;">
                                            <asp:UpdatePanel ID="upRptTo" runat="server">
                                                <contenttemplate>
                                                    <asp:DropDownList ID="ddRptTo" runat="server" Width="93px" AutoPostBack="true" OnSelectedIndexChanged="ddRptTo_SelectedIndexChanged"
                                                        TabIndex="2">
                                                    </asp:DropDownList>
                                                </contenttemplate>
                                                <triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="ddLocHir" EventName="SelectedIndexChanged" />
                                                </triggers>
                                            </asp:UpdatePanel>
                                        </td>
                                        <td align="left" style="width: 125px; height: 22px;">
                                            <font class="blackfnt">Reporting Location:</font>
                                        </td>
                                        <td align="left" style="height: 22px">
                                            <asp:UpdatePanel ID="upRptLoc" runat="server">
                                                <contenttemplate>
                                                    <asp:DropDownList ID="ddRptLoc" runat="server" Width="175px" TabIndex="3">
                                                    </asp:DropDownList>
                                                </contenttemplate>
                                                <triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="ddLocHir" EventName="SelectedIndexChanged" />
                                                    <asp:AsyncPostBackTrigger ControlID="ddRptTo" EventName="SelectedIndexChanged" />
                                                </triggers>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    &nbsp;&nbsp;&nbsp;
                    <table border="0" width="100%" cellpadding="0" cellspacing="1" class="boxbg">
                        <tr class="bgbluegrey">
                            <td align="center" style="height: 17px; width: 939px;">
                                <font class="bluefnt"><b>Location Information</b></font>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100%">
                                <table border="0" width="100%">
                                    <tr bgcolor="#ffffff">
                                        <td align="left" valign="top" style="width: 150px; height: 34px;">
                                            <font class="blackfnt">Location code:</font>
                                        </td>
                                        <td align="left" valign="top" style="width: 218px; height: 34px;">
                                            <%--<asp:UpdatePanel ID="upLocationCode" runat="server">
                    <ContentTemplate>--%>
                                            <asp:TextBox ID="txtLocCod" runat="server" class="input" TabIndex="4" MaxLength="50"
                                                Width="94px" ReadOnly="True"></asp:TextBox>
                                            <%--OnTextChanged="txtLocCod_TextChanged"--%>
                                            <br />
                                            <%--<label class="blackfnt" id="lblErrorLocation" runat="server" style="color: Red;" visible="false">
                            &nbsp;Invalid Location Code!!!
                        </label>--%>
                                            <%--</ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="txtLocCod" EventName="TextChanged" />
                    </Triggers>
                </asp:UpdatePanel>--%>
                                        </td>
                                        <td align="left" valign="top" style="width: 165px; height: 34px;">
                                            <font class="blackfnt">Location Name:</font>
                                        </td>
                                        <td align="left" valign="top" style="width: 141px; height: 34px;">
                                            <asp:TextBox ID="txtLocNm" runat="server" class="input" TabIndex="5" Width="94px"
                                                OnChange="Javascript:this.value=this.value.toUpperCase();" MaxLength="50"></asp:TextBox>
                                        </td>
                                        <td align="left" valign="top" style="width: 105px; height: 34px;">
                                            <font class="blackfnt">Address:</font>
                                        </td>
                                        <td align="left" valign="top" style="width: 234px; height: 34px;">
                                            <asp:TextBox ID="txtAdd" runat="server" TextMode="MultiLine" TabIndex="6" OnChange="Javascript:this.value=this.value.toUpperCase();"
                                                MaxLength="200"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <!--Row 2-->
                                    <tr bgcolor="#ffffff">
                                        <td align="left" valign="top" style="width: 150px; height: 13px;">
                                            <font class="blackfnt">State:</font>
                                        </td>
                                        <td align="left" style="width: 218px; height: 13px;">
                                            <asp:UpdatePanel runat="server" ID="updstate">
                                                <contenttemplate>
                                                    <asp:DropDownList ID="ddState" runat="server" Width="136px" TabIndex="7" AutoPostBack="True"
                                                        OnSelectedIndexChanged="ddState_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                    <asp:HiddenField ID="hidState" runat="server" />
                                                </contenttemplate>
                                            </asp:UpdatePanel>
                                            <span style="font-size: 8pt; font-family: Verdana"><strong></strong></span>
                                        </td>
                                        <td align="left" valign="top" style="font-size: 12pt; width: 165px; font-family: Times New Roman;
                                            height: 13px;">
                                            <font class="blackfnt">City:</font>
                                        </td>
                                        <td align="left" valign="top" style="width: 141px; height: 13px;">
                                            <span style="font-size: 8pt; font-family: Verdana">
                                                <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
                          <ContentTemplate>--%>
                                                <asp:TextBox ID="TextBox6" runat="server" TabIndex="8" Width="94px" OnChange="Javascript:this.value=this.value.toUpperCase();"
                                                    MaxLength="50"></asp:TextBox>
                                                <asp:Label ID="Label5" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpenCity(5)">...</a>'
                                                    Width="14px"></asp:Label>
                                                <br />
                                                <%--<label class="blackfnt" id="lblErrorCity" runat="server" style="color: Red;" visible="false">
                                    &nbsp;Invalid City!!!
                                </label>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="TextBox6" EventName="TextChanged" />
                            </Triggers>
                        </asp:UpdatePanel>       --%>
                                            </span>
                                        </td>
                                        <td align="left" valign="top" style="font-size: 12pt; width: 105px; font-family: Times New Roman;
                                            height: 13px;">
                                            <font class="blackfnt">Pin code:</font>
                                        </td>
                                        <td align="left" valign="top" style="font-size: 12pt; font-family: Times New Roman;
                                            width: 234px; height: 13px;">
                                            <asp:TextBox ID="txtPin" onblur="Nagative_Chk_wDecimal(this)" runat="server" TabIndex="9"
                                                MaxLength="6" Width="94px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                        <td align="left" style="width: 150px; height: 43px">
                                            <font class="blackfnt">CN Prefix Code:</font>
                                        </td>
                                        <asp:TextBox ID="TextBox9" runat="server" Visible="False"></asp:TextBox><td align="left"
                                            style="width: 218px; height: 43px">
                                            <asp:TextBox ID="txtCNCod" runat="server" class="input" TabIndex="10" Width="94px"
                                                OnChange="Javascript:this.value=this.value.toUpperCase();" MaxLength="10"></asp:TextBox>
                                        </td>
                                        <td align="left" style="width: 165px; height: 43px;">
                                            <font class="blackfnt">Cash Limit:</font>
                                        </td>
                                        <td align="left" style="font-size: 12pt; font-family: Times New Roman;
                                            width: 234px; height: 43px;">
                                            <asp:TextBox ID="txtCashlimit" onblur="checknumber(this)" runat="server" TabIndex="9"
                                                MaxLength="10" Width="94px"></asp:TextBox>
                                        </td>
                                        <td align="left" style="width: 105px; height: 43px">
                                            <font class="blackfnt">Bank:</font>
                                        </td>
                                        <td align="left" style="height: 43px; width: 234px;">
                                           <asp:TextBox ID="txtBank" runat="server"  MaxLength="50" TabIndex='10' 
                                                        Width="200px" CssClass="ltxtm" ></asp:TextBox>
                                            <ajaxToolkit:AutoCompleteExtender ID="aceAccountCode" runat="server" TargetControlID="txtBank"
                                                ServicePath="~/services/WebxCommonService.asmx" ServiceMethod="GetBankDetail" MinimumPrefixLength="3" CompletionSetCount="10"
                                                CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                ContextKey="" FirstRowSelected="True" Enabled=" True" >
                                            </ajaxToolkit:AutoCompleteExtender>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    &nbsp;&nbsp;&nbsp;
                    <table border="0" width="100%" cellpadding="0" cellspacing="1" class="boxbg">
                        <tr class="bgbluegrey">
                            <td align="center" style="width: 950px">
                                <font class="bluefnt"><b>Contact Information</b></font>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table border="0" width="100%" bgcolor="#ffffff">
                                    <!--Row 1-->
                                    <tr bgcolor="#ffffff">
                                        <td align="left" style="width: 192px; height: 24px;">
                                            <font class="blackfnt">Std code:</font>
                                        </td>
                                        <td align="left" style="width: 252px; height: 24px;">
                                            <asp:TextBox ID="txtStdCod" onblur="Nagative_Chk_wDecimal(this)" runat="server" Width="94px"
                                                TabIndex="11" MaxLength="6"></asp:TextBox>&nbsp;
                                        </td>
                                        <td align="left" style="width: 210px; height: 24px;">
                                            <font class="blackfnt">Tele. No.:</font>
                                        </td>
                                        <td align="left" style="height: 24px; width: 229px;">
                                            <asp:TextBox ID="txtTel" onblur="Nagative_Chk_wDecimal(this)" runat="server" Width="94px"
                                                TabIndex="12" MaxLength="10"></asp:TextBox>&nbsp;
                                        </td>
                                        <td align="left" style="height: 24px; width: 140px;">
                                            <font class="blackfnt">User Name:</font>
                                        </td>
                                        <%--<td align="left" style="height: 24px; width: 187px;">
                                            <asp:TextBox ID="txtFax" onblur="Nagative_Chk_wDecimal(this)" runat="server" Width="94px"
                                                TabIndex="13" MaxLength="12"></asp:TextBox>
                                        </td>--%>
                                        <td align="left" style="height: 24px; width: 187px;">
                                            <%--<asp:TextBox ID="txtFax" runat="server" Width="94px" 
                                                TabIndex="13" MaxLength="12"></asp:TextBox>--%>
                                            <asp:TextBox ID="Txt_User" runat="server" Width="350" BorderStyle="Groove" OnTextChanged="Txt_User_TextChanged" AutoPostBack="true" CssClass="blackfnt"></asp:TextBox>                                            
                                            <ajaxToolkit:AutoCompleteExtender ID="Ext1" runat="server" Enabled="True"
                                                CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                MinimumPrefixLength="1" ServiceMethod="GetUser" ServicePath="../AtlasAutoComplete.asmx"
                                                TargetControlID="Txt_User">
                                            </ajaxToolkit:AutoCompleteExtender>

                                            <font class="redfnt">Plz Type Initial Character OF User Name </font>
                                        </td>   
                                    </tr>
                                    <!--Row 2-->
                                    <tr bgcolor="#ffffff">
                                        <td align="left" style="width: 192px">
                                            <font class="blackfnt">Mobile No.:</font>
                                        </td>
                                        <td align="left" style="width: 252px">
                                            <asp:TextBox ID="txtMob" onblur="Nagative_Chk_wDecimal(this)" runat="server" Width="94px"
                                                TabIndex="14" MaxLength="12" Enabled="false"></asp:TextBox>&nbsp;
                                        </td>
                                        <td align="left" style="width: 210px">
                                            <font class="blackfnt">Email ID:</font>
                                        </td>
                                        <td align="left" colspan="3">
                                            <asp:TextBox ID="txtEmail"  runat="server" TabIndex="15"
                                                Width="215px" MaxLength="350"></asp:TextBox>&nbsp;
                                            <%--<asp:RegularExpressionValidator
                           ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmail"
                           ErrorMessage="Please Enter Valid Email Address" ForeColor="White" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>--%>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    &nbsp;&nbsp;&nbsp;&nbsp;<table border="0" cellpadding="0" cellspacing="1" class="boxbg"
                        width="100%">
                        <tr class="bgbluegrey">
                            <td align="center">
                                <font class="bluefnt"><b>Other Information</b></font>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table border="0" width="100%">
                                    <!--Row 1-->
                                    <tr bgcolor="#ffffff">
                                        <td align="left" style="width: 139px">
                                            <font class="blackfnt">Zone Code:</font>
                                        </td>
                                        <td align="left" style="font-size: 12pt; width: 198px; font-family: Times New Roman">
                                            <asp:DropDownList ID="ddRgLoc" runat="server" Width="104px" TabIndex="16">
                                            </asp:DropDownList>
                                            &nbsp;
                                        </td>
                                        <td align="left" style="font-size: 12pt; width: 154px; font-family: Times New Roman">
                                            <font class="blackfnt">Accounting Location:</font><span style="font-size: 8pt; font-family: Verdana">
                                            </span>
                                        </td>
                                        <td align="left" colspan="3" style="font-weight: bold; font-size: 8pt; font-family: Verdana">
                                            <asp:TextBox ID="txtAcLoc" runat="server" Width="94px" TabIndex="17" OnChange="Javascript:this.value=this.value.toUpperCase();"
                                                MaxLength="15"></asp:TextBox>
                                            <asp:Label ID="Label1" runat="server" BorderStyle="Groove" Text='<a href="javascript:nwOpen(1)">...</a>'
                                                Width="14px" TabIndex="18"></asp:Label>&nbsp;
                                        </td>
                                    </tr>
                                    <!--Row 2-->
                                    <tr bgcolor="#ffffff" style="font-size: 8pt; font-family: Verdana">
                                        <td align="left" valign="top" style="width: 139px; height: 20px">
                                            <font class="blackfnt"><span>Computerised:</span></font>
                                        </td>
                                        <td align="left" style="width: 198px; height: 20px">
                                            <asp:UpdatePanel ID="upChkComp" runat="server">
                                                <contenttemplate>
                                                    <asp:CheckBox ID="chkComp" runat="server" OnCheckedChanged="chkComp_CheckedChanged"
                                                        AutoPostBack="true" TabIndex="19" />
                                                    <asp:TextBox ID="TextBox15" runat="server" Width="18px" ReadOnly="True" TabIndex="20"></asp:TextBox>
                                                </contenttemplate>
                                                <triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="chkComp" EventName="CheckedChanged" />
                                                </triggers>
                                            </asp:UpdatePanel>
                                            &nbsp;
                                        </td>
                                        <td align="left" valign="top" style="font-size: 8pt; width: 154px; font-family: Verdana;
                                            height: 20px">
                                            <font class="blackfnt">Data Entry Location:</font>
                                        </td>
                                        <td align="left" valign="top" colspan="3" style="height: 20px">
                                            <asp:TextBox ID="txtDataLoc" runat="server" Width="94px" TabIndex="21" OnChange="Javascript:this.value=this.value.toUpperCase();"
                                                MaxLength="20"></asp:TextBox>
                                            <asp:Label ID="Label2" runat="server" BorderStyle="Groove" Text='<a href="javascript:nwOpen(2)">...</a>'
                                                Width="14px" TabIndex="22"></asp:Label>&nbsp;
                                        </td>
                                    </tr>
                                    <!--Row 3-->
                                    <tr bgcolor="#ffffff">
                                        <td align="left" valign="top" style="width: 139px; height: 24px">
                                            <font class="blackfnt">Location Start Date:</font>
                                        </td>
                                        <%--<td align="left">
                                <asp:Label ID="lblSalesDt" runat="server" Text="Sales Date" CssClass="blackfnt" Font-Bold="True"></asp:Label><DateCalendar:header id="DtCal" runat="server"></DateCalendar:header></td>
                                    <td align="left" style="width: 173px">--%>
                                        <td align="left" valign="top" style="width: 198px; height: 24px">
                                            <%--<asp:TextBox ID="TextBox16" runat="server" class="input" TabIndex="23" Width="94px"></asp:TextBox>&nbsp;
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ControlToValidate="TextBox16"
                                    ErrorMessage="Invalid Date" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                    ValidationGroup="VGDtFromTo"></asp:RegularExpressionValidator><br />
                                &nbsp;--%>
                                            <%--<input type="text" id="TextBox16" maxlength="10" size="10" runat="server" 
                                   class="input" onblur="ValidateDate(this)" />--%>
                                            <asp:TextBox ID="TextBox16" runat="server" MaxLength="10" CssClass="input" Width="80px"></asp:TextBox>
                                            <a href="#" onclick="cal.select(ctl00_MyCPH1_TextBox16, 'alnkTextBox16', 'dd/MM/yyyy'); return false;"
                                                id="alnkTextBox16">
                                                <img src="../../../GUI/images/calendar.jpg" border="0" alt="" />
                                            </a>
                                            <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ControlToValidate="TextBox16"
                                    ErrorMessage="Invalid Date" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                    ValidationGroup="VGDtFromTo"></asp:RegularExpressionValidator>--%>
                                        </td>
                                        <td align="left" valign="top" style="width: 154px; height: 24px">
                                            <font class="blackfnt">Location End Date:</font>
                                        </td>
                                        <td align="left" valign="top" style="width: 177px; height: 24px">
                                            <%--<asp:TextBox ID="txtLocEndDt" runat="server" Width="94px"></asp:TextBox>&nbsp;<br />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator8" runat="server" ControlToValidate="txtLocEndDt"
                                    ErrorMessage="Invalid Date" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                    ValidationGroup="VGDtFromTo"></asp:RegularExpressionValidator>--%>
                                            <%--<input type="text" id="txtLocEndDt" maxlength="10" size="10" runat="server" 
                                   class="input" onblur="ValidateDate(this)" />--%>
                                            <asp:TextBox ID="txtLocEndDt" runat="server" MaxLength="10" CssClass="input" Width="80px"></asp:TextBox>
                                            <a href="#" onclick="cal.select(ctl00_MyCPH1_txtLocEndDt, 'alnktxtLocEndDt', 'dd/MM/yyyy'); return false;"
                                                id="alnktxtLocEndDt">
                                                <img src="../../../GUI/images/calendar.jpg" border="0" alt="" />
                                            </a>
                                            <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator8" runat="server" ControlToValidate="txtLocEndDt"
                                    ErrorMessage="Invalid Date" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                    ValidationGroup="VGDtFromTo"></asp:RegularExpressionValidator>--%>
                                        </td>
                                        <td align="left" valign="top" style="height: 24px">
                                            <font class="blackfnt">Active Flag:</font>
                                        </td>
                                        <td align="left" style="height: 24px">
                                            <asp:UpdatePanel ID="upChkActFlag" runat="server">
                                                <contenttemplate>
                                                    <asp:CheckBox ID="CheckBox2" runat="server" AutoPostBack="true" OnCheckedChanged="CheckBox2_CheckedChanged" />
                                                    <asp:TextBox ID="txtActFlag" runat="server" Width="17px" ReadOnly="True" MaxLength="1"></asp:TextBox>
                                                </contenttemplate>
                                                <triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="CheckBox2" EventName="CheckedChanged" />
                                                </triggers>
                                            </asp:UpdatePanel>
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    &nbsp;&nbsp;&nbsp;
                    <table align="center" border="0" cellpadding="0" cellspacing="1" class="boxbg" style="width: 100%">
                        <tr class="bgbluegrey">
                            <td align="center" style="text-align: center; height: 25px; width: 806px;">
                                <font class="bluefnt"><b>Operation Information</b></font>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 806px">
                                <table align="center" border="0" cellpadding="2" cellspacing="0" style="width: 119%">
                                    <tr bgcolor="#ffffff">
                                        <td valign="top" style="height: 39px; width: 128px;">
                                            <font class="blackfnt">Booking Operation</font>
                                        </td>
                                        <td valign="top">
                                            <font class="blackfnt">
                                                <asp:UpdatePanel ID="upChkBkOpr" runat="server">
                                                    <contenttemplate>
                                                        <asp:CheckBox ID="chkBkOpr" runat="server" Width="15px" OnCheckedChanged="chkBkOpr_CheckedChanged"
                                                            AutoPostBack="true" />
                                                        <asp:TextBox ID="txtBkOpr" runat="server" Width="16px" ReadOnly="True" TabIndex="24"
                                                            MaxLength="1"></asp:TextBox>
                                                    </contenttemplate>
                                                </asp:UpdatePanel>
                                            </font>&nbsp;
                                        </td>
                                        <td valign="top" style="width: 131px; height: 39px;">
                                            <font class="blackfnt">Delivery Operation</font>
                                        </td>
                                        <td valign="top" style="height: 39px; width: 157px;">
                                            <font class="blackfnt">
                                                <asp:UpdatePanel ID="upChkDly" runat="server">
                                                    <contenttemplate>
                                                        <asp:CheckBox ID="chkDly" runat="server" Width="15px" OnCheckedChanged="chkDly_CheckedChanged"
                                                            AutoPostBack="true" TabIndex="25" />
                                                        <asp:TextBox ID="TextBox26" runat="server" Width="18px" ReadOnly="True" TabIndex="26"
                                                            MaxLength="1"></asp:TextBox>
                                                    </contenttemplate>
                                                    <triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="chkDly" EventName="CheckedChanged" />
                                                    </triggers>
                                                </asp:UpdatePanel>
                                                &nbsp;&nbsp; </font>&nbsp;
                                        </td>
                                        <td valign="top" style="width: 96px; height: 39px;">
                                            <font class="blackfnt">Tranship Operation</font>
                                        </td>
                                        <td valign="top" style="height: 39px; width: 161px;">
                                            <font class="blackfnt">
                                                <asp:UpdatePanel ID="upChktransOpr" runat="server">
                                                    <contenttemplate>
                                                        <asp:CheckBox ID="chktransOpr" runat="server" Height="19px" Width="15px" OnCheckedChanged="chktransOpr_CheckedChanged"
                                                            AutoPostBack="true" TabIndex="27" />
                                                        <asp:TextBox ID="txttransOpr" runat="server" Width="17px" ReadOnly="True" TabIndex="28"
                                                            MaxLength="1"></asp:TextBox>
                                                    </contenttemplate>
                                                    <triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="chktransOpr" EventName="CheckedChanged" />
                                                    </triggers>
                                                </asp:UpdatePanel>
                                                &nbsp;</font>&nbsp;
                                        </td>
                                    </tr>
                                    <tr bgcolor="#ffffff">
                                        <td valign="top" style="width: 128px">
                                            <font class="blackfnt">Default Next Location</font>
                                        </td>
                                        <td valign="top" style="width: 187px">
                                            <font class="blackfnt"></font>
                                            <asp:TextBox ID="txtNxtLoc" runat="server" TabIndex="38" Width="94px" MaxLength="500"></asp:TextBox>
                                            <%--OnChange="Javascript:this.value=this.value.toUpperCase();"--%>
                                            <asp:Label ID="Label3" runat="server" BorderStyle="Groove" Text='<a href="javascript:nwOpen(3)">...</a>'
                                                Width="14px" TabIndex="39"></asp:Label>
                                        </td>
                                        <td valign="top" style="width: 131px">
                                            <font class="blackfnt">Nearest Previous Location</font>
                                        </td>
                                        <td valign="top" style="width: 157px">
                                            <asp:TextBox ID="txtNrPrLoc" runat="server" TabIndex="40" Width="94px" MaxLength="500"></asp:TextBox>
                                            <%--OnChange="Javascript:this.value=this.value.toUpperCase();--%>
                                            <asp:Label ID="Label4" runat="server" BorderStyle="Groove" Text='<a href="javascript:nwOpen(4)">...</a>'
                                                Width="14px" TabIndex="41"></asp:Label>
                                        </td>
                                        <td valign="top" style="width: 96px">
                                            <font class="blackfnt">Location Ownership</font>
                                        </td>
                                        <td valign="top" style="width: 161px">
                                            <font class="blackfnt">
                                                <asp:DropDownList ID="ddLocOnr" runat="server" Width="94px" TabIndex="31">
                                                    <asp:ListItem>--Select--</asp:ListItem>
                                                    <asp:ListItem Value="C">Company</asp:ListItem>
                                                    <asp:ListItem Value="B">BA</asp:ListItem>
                                                    <asp:ListItem Value="O">Customer</asp:ListItem>
                                                    <asp:ListItem Value="F">Franchise</asp:ListItem>
                                                </asp:DropDownList>
                                            </font>
                                        </td>
                                    </tr>
                                    <tr bgcolor="#ffffff">
                                        <td valign="top" style="height: 11px; width: 128px;">
                                            <font class="blackfnt">UGD</font>
                                        </td>
                                        <td valign="top" style="width: 187px; height: 11px;">
                                            <font class="blackfnt"></font>
                                            <asp:UpdatePanel ID="upchkUgd" runat="server">
                                                <contenttemplate>
                                                    <asp:CheckBox ID="chkUgd" runat="server" Width="9px" AutoPostBack="True" OnCheckedChanged="chkUgd_CheckedChanged"
                                                        TabIndex="34" />
                                                    &nbsp;<asp:TextBox ID="txtUgd" runat="server" Width="18px" ReadOnly="True" TabIndex="35"
                                                        MaxLength="1"></asp:TextBox>&nbsp; &nbsp;&nbsp;
                                                </contenttemplate>
                                                <triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="chkUgd" EventName="CheckedChanged" />
                                                </triggers>
                                            </asp:UpdatePanel>
                                        </td>
                                        <td valign="top" style="width: 131px; height: 11px;">
                                            &nbsp;
                                        </td>
                                        <td valign="top" style="height: 11px; width: 157px;">
                                        </td>
                                        <td valign="top" style="width: 96px; height: 11px;">
                                            <font class="blackfnt"></font>
                                        </td>
                                        <td valign="top" style="height: 11px; width: 161px;">
                                            <font class="blackfnt">&nbsp;</font>
                                        </td>
                                        <%--<asp:CheckBox ID="chkUgd" runat="server" Width="9px" AutoPostBack="True" OnCheckedChanged="chkUgd_CheckedChanged" TabIndex="34" />
            &nbsp;<asp:TextBox ID="txtUgd" runat="server" Width="18px" ReadOnly="True" TabIndex="35"></asp:TextBox>&nbsp; &nbsp;&nbsp; </font></td>--%>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    &nbsp;&nbsp;&nbsp;
                    <asp:UpdatePanel ID="upOperTable" runat="server">
                        <contenttemplate>
                            <table align="center" border="0" cellpadding="0" cellspacing="1" class="boxbg" style="width: 100%">
                                <%--<table align="center" border="0" cellpadding="2" cellspacing="0" style="width: 100%">--%>
                                <%--<tr id="booking" runat="server" bgcolor="#ffffff">
                <td valign="top" style="width: 128px; height: 26px;" ><font class="blackfnt">Booking Start Date</font></td>
                <td valign="top" style="width: 187px; height: 26px;" ><asp:TextBox ID="txtBkStrDt" runat="server" class="input" TabIndex="29" Width="94px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox><asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtBkStrDt"
                ErrorMessage="Invalid Date" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                ValidationGroup="VGDtFromTo"></asp:RegularExpressionValidator></td>


                <td valign="top" style="width: 131px; height: 26px;" ><font class="blackfnt">Booking End Date</font></td>
                <td valign="top" style="width: 157px; height: 26px;" ><asp:TextBox ID="txtBkEndDt" runat="server" TabIndex="30" Width="94px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtBkEndDt"
                ErrorMessage="Invalid Date" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                ValidationGroup="VGDtFromTo"></asp:RegularExpressionValidator></td>
                </tr>--%>
                                <tr id="trBooking" runat="server" bgcolor="#ffffff">
                                    <td valign="top">
                                        <font class="blackfnt">Booking Start Date </font>
                                    </td>
                                    <td valign="top">
                                        <%--<input type="text" id="txtBkStrDt" maxlength="10" size="10" runat="server" 
                            class="input" onblur="ValidateDate(this)" />--%>
                                        <asp:TextBox ID="txtBkStrDt" runat="server" MaxLength="10" CssClass="input" Width="80px"></asp:TextBox>
                                        <a href="#" onclick="cal.select(ctl00_MyCPH1_txtBkStrDt, 'alnkBkStrDt', 'dd/MM/yyyy'); return false;"
                                            id="alnkBkStrDt">
                                            <img src="../../../GUI/images/calendar.jpg" border="0" alt="" />
                                        </a>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtBkStrDt"
                                            ErrorMessage="Invalid Date" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                            ValidationGroup="VGDtFromTo">
                                        </asp:RegularExpressionValidator>
                                    </td>
                                    <td valign="top">
                                        <font class="blackfnt">Booking End Date </font>
                                    </td>
                                    <td valign="top">
                                        <%--<asp:TextBox ID="txtBkEndDt" runat="server" TabIndex="30" Width="94px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>--%>
                                        <asp:TextBox ID="txtBkEndDt" runat="server" MaxLength="10" CssClass="input" Width="80px"></asp:TextBox>
                                        <%--<input type="text" id="txtBkEndDt" maxlength="10" size="10" runat="server" 
                            class="input" onblur="ValidateDate(this)" />--%>
                                        <a href="#" onclick="cal.select(ctl00_MyCPH1_txtBkEndDt, 'alnkBkEndDt', 'dd/MM/yyyy'); return false;"
                                            id="alnkBkEndDt">
                                            <img src="../../../GUI/images/calendar.jpg" border="0" alt="" />
                                        </a>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator41" runat="server"
                                            ControlToValidate="txtBkEndDt" ErrorMessage="Invalid Date" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                            ValidationGroup="VGDtFromTo"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr id="trDelivery" runat="server" bgcolor="#ffffff">
                                    <td valign="top" style="height: 11px; width: 128px;">
                                        <font class="blackfnt">Delivery Start Date</font></td>
                                    <td valign="top" style="width: 187px; height: 11px;">
                                        <font class="blackfnt"></font>
                                        <%--<asp:TextBox ID="txtdlStrDt" runat="server" class="input" TabIndex="32" Width="94px"></asp:TextBox><asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtdlStrDt"
                ErrorMessage="Invalid Date" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                ValidationGroup="VGDtFromTo"></asp:RegularExpressionValidator>--%>
                                        <%--<input type="text" id="txtdlStrDt" maxlength="10" size="10" runat="server" 
                            class="input" onblur="ValidateDate(this)"/>--%>
                                        <asp:TextBox ID="txtdlStrDt" runat="server" MaxLength="10" CssClass="input" Width="80px"></asp:TextBox>
                                        <a href="#" onclick="cal.select(ctl00_MyCPH1_txtdlStrDt, 'alnkdlStrDt', 'dd/MM/yyyy'); return false;"
                                            id="alnkdlStrDt">
                                            <img src="../../images/calendar.jpg" border="0" alt="" />
                                        </a>
                                        <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtdlStrDt" 
                                ErrorMessage="Invalid Date" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                ValidationGroup="VGDtFromTo"></asp:RegularExpressionValidator>--%>
                                    </td>
                                    <td valign="top" style="width: 131px; height: 11px;">
                                        <font class="blackfnt">Delivery End Date</font></td>
                                    <td valign="top" style="height: 11px; width: 157px;">
                                        <asp:TextBox ID="txtdlyEndDt" runat="server" MaxLength="10" CssClass="input" Width="80px"></asp:TextBox>
                                        <%--<input type="text" id="txtdlyEndDt" maxlength="10" size="10" runat="server" 
                            class="input" onblur="ValidateDate(this)"/>--%>
                                        <a href="#" onclick="cal.select(ctl00_MyCPH1_txtdlyEndDt, 'alnkdlyEndDt', 'dd/MM/yyyy'); return false;"
                                            id="alnkdlyEndDt">
                                            <img src="../../../GUI/images/calendar.jpg" border="0" alt="" />
                                        </a>
                                        <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="txtdlyEndDt"
                ErrorMessage="Invalid Date" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                ValidationGroup="VGDtFromTo"></asp:RegularExpressionValidator> --%>
                                        <%--<asp:TextBox ID="txtdlyEndDt" runat="server" TabIndex="33" Width="94px"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="txtdlyEndDt"
                ErrorMessage="Invalid Date" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                ValidationGroup="VGDtFromTo"></asp:RegularExpressionValidator>--%>
                                    </td>
                                    <%--<asp:CheckBox ID="chkUgd" runat="server" Width="9px" AutoPostBack="True" OnCheckedChanged="chkUgd_CheckedChanged" TabIndex="34" />
                    &nbsp;<asp:TextBox ID="txtUgd" runat="server" Width="18px" ReadOnly="True" TabIndex="35"></asp:TextBox>&nbsp; &nbsp;&nbsp; </font></td>--%>
                                </tr>
                                <tr id="trTranship" runat="server" bgcolor="#ffffff">
                                    <td valign="top" style="width: 128px; height: 19px;">
                                        <font class="blackfnt">Tranship Start Date</font></td>
                                    <td valign="top" style="width: 187px; height: 19px;">
                                        <font class="blackfnt"></font>
                                        <%--<asp:TextBox ID="txttransStrDT" runat="server" class="input" TabIndex="36" Width="94px"></asp:TextBox><asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txttransStrDT"
                ErrorMessage="Invalid Date" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                ValidationGroup="VGDtFromTo"></asp:RegularExpressionValidator>--%>
                                        <asp:TextBox ID="txttransStrDT" runat="server" MaxLength="10" CssClass="input" Width="80px"></asp:TextBox>
                                        <%--<input type="text" id="txttransStrDT" maxlength="10" size="10" runat="server" 
                            class="input" onblur="ValidateDate(this)" />--%>
                                        <a href="#" onclick="cal.select(ctl00_MyCPH1_txttransStrDT, 'alnkdltransStrDT', 'dd/MM/yyyy'); return false;"
                                            id="alnkdltransStrDT">
                                            <img src="../../../GUI/images/calendar.jpg" border="0" alt="" />
                                        </a>
                                        <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txttransStrDT"
                ErrorMessage="Invalid Date" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                ValidationGroup="VGDtFromTo"></asp:RegularExpressionValidator>--%>
                                    </td>
                                    <td valign="top" style="width: 131px; height: 19px;">
                                        <label class="blackfnt">
                                            Tranship End Date</label></td>
                                    <td valign="top" style="width: 157px; height: 19px;">
                                        <%--<input type="text" id="txttransEndDt" maxlength="10" size="10" runat="server" 
                            class="input" onblur="ValidateDate(this)" />--%>
                                        <%--<input type="text" id="txttransEndDt" runat="server" maxlength="10" size="10" class="input" onblur="return ValidateDate(this)" />--%>
                                        <asp:TextBox ID="txttransEndDt" runat="server" MaxLength="10" CssClass="input" Width="80px"></asp:TextBox>
                                        <a href="#" onclick="cal.select(ctl00_MyCPH1_txttransEndDt, 'alnktransEndDt', 'dd/MM/yyyy'); return false;"
                                            id="alnktransEndDt">
                                            <img src="../../../GUI/images/calendar.jpg" border="0" alt="" />
                                        </a>
                                        <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="txttransEndDt"
                            ErrorMessage="Invalid Date" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                            ValidationGroup="VGDtFromTo"></asp:RegularExpressionValidator>--%>
                                        <%--<asp:TextBox ID="txttransEndDt" runat="server" TabIndex="37" Width="94px"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="txttransEndDt"
                ErrorMessage="Invalid Date" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                ValidationGroup="VGDtFromTo"></asp:RegularExpressionValidator>--%>
                                    </td>
                                </tr>
                            </table>
                        </contenttemplate>
                        <triggers>
                            <asp:AsyncPostBackTrigger ControlID="chkBkOpr" EventName="CheckedChanged" />
                            <asp:AsyncPostBackTrigger ControlID="chkDly" EventName="CheckedChanged" />
                            <asp:AsyncPostBackTrigger ControlID="chktransOpr" EventName="CheckedChanged" />
                        </triggers>
                    </asp:UpdatePanel>
                    <%-- </table> 
                </td>
                </tr>
            </table>--%>
                    <asp:UpdatePanel ID="upTables" runat="server">
                        <contenttemplate>
                            <table id="pay" align="center" border="0" cellpadding="0" cellspacing="1" class="boxbg"
                                visible="false" runat="Server" style="width: 100%">
                                <tr class="bgbluegrey">
                                    <td align="center" style="height: 16px; width: 950px;">
                                        <font class="bluefnt"><b>Payment Type</b></font></td>
                                </tr>
                                <tr>
                                    <td bgcolor="#FFFFFF" style="height: 45px; width: 950px;">
                                        <table border="0" cellpadding="2" cellspacing="0" style="width: 573px; height: 17px;">
                                            <tr bgcolor="#FFFFFF">
                                                <td valign="middle" style="width: 134px; height: 53px;">
                                                    <font class="blackfnt">Payment Type : </font>
                                                </td>
                                                <td>
                                                    <asp:CheckBoxList ID="ChkListPayType" runat="server" AutoPostBack="True" RepeatColumns="7"
                                                        RepeatDirection="Horizontal" OnSelectedIndexChanged="ChkListPayType_SelectedIndexChanged">
                                                    </asp:CheckBoxList><%=strPayType%></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <table id="Service" runat="server" visible="false" align="center" border="0" cellpadding="0"
                                cellspacing="1" class="boxbg" style="width: 100%">
                                <tr class="bgbluegrey">
                                    <td align="center">
                                        <font class="bluefnt"><b>Services</b></font></td>
                                </tr>
                                <tr>
                                    <td bgcolor="#ffffff">
                                        <table border="0" cellpadding="2" cellspacing="0">
                                            <tr bgcolor="#ffffff">
                                                <td align="left" colspan="3" style="height: 26px">
                                                    <asp:CheckBox ID="chkVol" runat="server" AutoPostBack="true" OnCheckedChanged="chkVol_CheckedChanged" />
                                                    <asp:TextBox ID="txtVol" runat="server" Width="19px" MaxLength="1"></asp:TextBox><font
                                                        class="blackfnt">Volumetric</font>
                                                    <asp:CheckBox ID="chkCod" runat="server" AutoPostBack="true" OnCheckedChanged="chkCod_CheckedChanged" />
                                                    <asp:TextBox ID="txtCod" runat="server" Width="17px" MaxLength="1"></asp:TextBox><font
                                                        class="blackfnt">COD/DOD</font>
                                                    <asp:CheckBox ID="chkOda" runat="server" AutoPostBack="true" OnCheckedChanged="chkOda_CheckedChanged" />
                                                    <asp:TextBox ID="txtOda" runat="server" Width="21px" ReadOnly="True" MaxLength="1"></asp:TextBox><font
                                                        class="blackfnt">ODA</font>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <table id="bkOpr" runat="server" visible="false" align="center" border="0" cellpadding="0"
                                cellspacing="1" class="boxbg" style="width: 100%">
                                <tr class="bgbluegrey">
                                    <td align="center">
                                        <font class="bluefnt"><b>Booking/Delivery Information</b></font></td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td>
                                        <table border="0" cellspacing="0" cellpadding="2" style="width: 100%">
                                            <tr>
                                                <td valign="top">
                                                    <font class="blackfnt">Octroi :</font></td>
                                                <td valign="top">
                                                    <asp:DropDownList ID="DropDownList1" runat="server" Width="104px">
                                                        <asp:ListItem Value="N" Text="--Select--"></asp:ListItem>
                                                        <asp:ListItem Value="I" Text="Inside Octroi Limit"></asp:ListItem>
                                                        <asp:ListItem Value="O" Text="Outside Octroi Limit"></asp:ListItem>
                                                        <asp:ListItem Value="N" Text="Octroi Not Applicable"></asp:ListItem>
                                                    </asp:DropDownList></td>
                                                <td align="left" valign="top">
                                                    <font class="blackfnt">Air Service :</font></td>
                                                <td align="left" valign="top">
                                                    <font class="blackfnt">
                                                        <asp:CheckBox ID="c1" runat="server" OnCheckedChanged="c1_CheckedChanged" AutoPostBack="true" /><asp:TextBox
                                                            ID="TextBox3" runat="server" Width="17px" ReadOnly="True"></asp:TextBox></font></td>
                                                <td valign="top">
                                                    <font class="blackfnt">Rail Service</font>
                                                </td>
                                                <td valign="top">
                                                    <asp:CheckBox ID="c4" runat="server" AutoPostBack="true" OnCheckedChanged="c4_CheckedChanged" />
                                                    <asp:TextBox ID="txtRail" runat="server" Width="17px" ReadOnly="True"></asp:TextBox></td>
                                                <td valign="top">
                                                    <font class="blackfnt">Sea Service</font> &nbsp;
                                                </td>
                                                <td valign="top">
                                                    <asp:CheckBox ID="c6" runat="server" OnCheckedChanged="c6_CheckedChanged" AutoPostBack="true" />
                                                    <asp:TextBox ID="txtSea" runat="server" Width="16px" ReadOnly="True"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td valign="top">
                                                    <font class="blackfnt">CN Generation :</font></td>
                                                <td valign="top" align="left">
                                                    <asp:ListBox ID="ListBox1" runat="server" Width="99px" Height="54px">
                                                        <asp:ListItem>--Select--</asp:ListItem>
                                                        <asp:ListItem Value="A">Computerised</asp:ListItem>
                                                        <asp:ListItem Value="M">Manual</asp:ListItem>
                                                    </asp:ListBox>
                                                </td>
                                                <td valign="top">
                                                    <font class="blackfnt">Cutoff time applicable :</font>
                                                </td>
                                                <td valign="top" align="left">
                                                    <font class="blackfnt">
                                                        <asp:CheckBox ID="c2" runat="server" OnCheckedChanged="c2_CheckedChanged" AutoPostBack="true" /><asp:TextBox
                                                            ID="txtCutOff" runat="server" Width="18px" ReadOnly="True"></asp:TextBox></font></td>
                                                <td valign="top">
                                                    <font class="blackfnt">Booking Cut off time :</font>
                                                </td>
                                                <td valign="top">
                                                    <%--<input type="text" id="TextBox8" maxlength="10" size="10" runat="server" 
                            class="input" onblur="ValidateDate(this)" />--%>
                                                    <asp:TextBox ID="TextBox8" runat="server" MaxLength="8" CssClass="input" Width="80px"></asp:TextBox><font
                                                        class="blackfnt"> (hh:mm)</font>
                                                    <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox8"
                                ErrorMessage="Invalid Date" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                ValidationGroup="VGDtFromTo"></asp:RegularExpressionValidator>--%>
                                                    <%--<a href="#" onclick="cal.select(ctl00_MyCPH1_TextBox8, 'alnkTextBox8', 'dd/MM/yyyy'); return false;" 
                            id="alnkTextBox8">
                            <img src="../../../GUI/images/calendar.jpg" border="0" alt="" />--%>
                                                    </a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="height: 47px">
                                                    <font class="blackfnt">&nbsp;</font></td>
                                                <td valign="top">
                                                    <font class="blackfnt">Pickup Door :</font></td>
                                                <td valign="top">
                                                    <font class="blackfnt">
                                                        <asp:CheckBox ID="c3" runat="server" OnCheckedChanged="c3_CheckedChanged" AutoPostBack="true" /><asp:TextBox
                                                            ID="txtPickDor" runat="server" Width="17px" ReadOnly="True"></asp:TextBox></font></td>
                                                <td align="left" valign="top">
                                                    <font class="blackfnt">Pickup Godown :</font>
                                                </td>
                                                <td valign="top" align="left">
                                                    <font class="blackfnt">
                                                        <asp:CheckBox ID="c5" runat="server" OnCheckedChanged="c5_CheckedChanged" AutoPostBack="true" />
                                                        <asp:TextBox ID="txtPickGodwn" runat="server" Width="19px" ReadOnly="True"></asp:TextBox>
                                                    </font>
                                                </td>
                                                <td colspan="1" valign="top">
                                                    <font class="blackfnt">Billed At</font></td>
                                                <td colspan="1" valign="top">
                                                    <asp:TextBox ID="TextBox11" runat="server" Width="46px" OnChange="Javascript:this.value=this.value.toUpperCase();"
                                                        MaxLength="10"></asp:TextBox></td>
                                                <td valign="top">
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </contenttemplate>
                        <triggers>
                            <asp:AsyncPostBackTrigger ControlID="chkBkOpr" EventName="CheckedChanged" />
                        </triggers>
                    </asp:UpdatePanel>
                    <table style="width: 954px">
                        <tr>
                            <td align="right" colspan="3" style="height: 90px">
                                &nbsp;<asp:UpdatePanel ID="upBtnSubmit" runat="server">
                                    <contenttemplate>
                                    </contenttemplate>
                                    <triggers>
                                        <asp:AsyncPostBackTrigger ControlID="btnSubmit" EventName="Click" />
                                    </triggers>
                                </asp:UpdatePanel>
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClientClick="return ValidateData()"
                                    OnClick="btnSubmit_Click" />
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" Height="19px" ShowMessageBox="True"
                                    Width="144px" />
                            </td>
                        </tr>
                    </table>
                    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white;
                        z-index: 99;">
                    </div>
    </div>
</asp:Content>
